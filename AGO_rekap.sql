SELECT * FROM AGODIST.trans_reservasi where flag_deleted = '0' and status_sap = 'S' ORDER BY created_on desc;

select 
    plant,
    plant_name,
    stor_loc,
    Gudang,
    round(sum(jarak_hari)/(count(gudang)),0)rata_rata_jarak,
    sum(total_pemakaian)Jumlah_pemakaian,
    case 
    when  round(sum(jarak_hari)/(count(gudang)),0) < 3 then 'SANGAT BAIK'
    when  round(sum(jarak_hari)/(count(gudang)),0) < 5 then 'BAIK'
    else  'KURANG BAIK'
    end as kategori
    from (
select
    pgl.plant,
    pln.plant_name,
    pgl.stor_loc,
    loc.stor_loc_name as Gudang,
    pgl.tgl_dokumen as Doc_date,
    pgl.tgl_pengeluaran as Post_date,
    (pgl.tgl_pengeluaran-pgl.tgl_dokumen)jarak_hari,
    count(pgl.material_document) as total_pemakaian
    --rsl.message AS Error
from 
     AGODIST.trans_pengeluaran pgl ,
     AGODIST.trans_reservasi rsv ,
     --AGOINT.int_gmvt_in_header hdr ,
    -- AGOINT.int_gmvt_in_result rsl ,
    AGODIST.master_plant pln,
     AGODIST.master_stor_loc loc
where 
   --hdr.session_id_golds = rsl.session_id_golds and
   --hdr.mat_doc_ago = pgl.material_document and
   pln.plant = pgl.plant and
   pgl.no_pemesanan = rsv.nomor_reservasi and
   loc.plant = pgl.plant and
   loc.stor_loc = pgl.stor_loc and
   pgl.flag_deleted = 0 and
   pgl.status_sap ='S' and 
   pgl.plant like '63%' and 
   pgl.tgl_dokumen BETWEEN TO_DATE ('01/11/2019', 'dd/mm/yyyy')
   AND TO_DATE ('31/12/2019', 'dd/mm/yyyy')
   --rsl.message ='Successfully created material document in SAP'
group by
   -- pgl.material_document,
    pgl.plant,
    pln.plant_name,
    pgl.stor_loc,
    loc.stor_loc_name,
    pgl.tgl_pengeluaran,
    --rsl.message,
    pgl.tgl_pengeluaran,
    rsv.tgl_reservasi,
    pgl.tgl_dokumen
    
order by 2 asc) 
group by    
    plant,
    plant_name,
    stor_loc,
    gudang
order by 2 asc;