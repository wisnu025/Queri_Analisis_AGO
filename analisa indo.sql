
select 
    plant,
    stor_loc,
    Gudang,
    round(sum(selisih_hari)/(count(gudang)),0)rata_rata_selisih,
    sum(total_pemakaian)Jumlah_pemakaian 
    from (
select
    pgl.plant,
    pgl.stor_loc,
    loc.stor_loc_name as Gudang,
    pgl.tgl_dokumen as Doc_date,
    pgl.tgl_pengeluaran as Post_date,
    (pgl.tgl_pengeluaran-pgl.tgl_dokumen)selisih_hari,
    count(pgl.material_document) as total_pemakaian
    --rsl.message AS Error
from 
     AGODIST.trans_pengeluaran pgl ,
     AGODIST.trans_reservasi rsv ,
     --AGOINT.int_gmvt_in_header hdr ,
    -- AGOINT.int_gmvt_in_result rsl ,
     AGODIST.master_stor_loc loc
where 
   --hdr.session_id_golds = rsl.session_id_golds and
   --hdr.mat_doc_ago = pgl.material_document and
   pgl.no_pemesanan = rsv.nomor_reservasi and
   loc.plant = pgl.plant and
   loc.stor_loc = pgl.stor_loc and
   pgl.flag_deleted = 0 and
   pgl.status_sap ='S' and 
   pgl.plant='5617' and 
   pgl.stor_loc <> 2050 and
   pgl.tgl_dokumen BETWEEN TO_DATE ('01/11/2019', 'dd/mm/yyyy')
   AND TO_DATE ('31/12/2019', 'dd/mm/yyyy')
   --rsl.message ='Successfully created material document in SAP'
group by
   -- pgl.material_document,
    pgl.plant,
    pgl.stor_loc,
    loc.stor_loc_name,
    pgl.tgl_pengeluaran,
    --rsl.message,
    pgl.tgl_pengeluaran,
    rsv.tgl_reservasi,
    pgl.tgl_dokumen
    
order by 3 asc) 
group by    
    plant,
    stor_loc,
    gudang
order by 3 asc;




----------------------------
-----------pemakaian error------

select
    pgl.material_document,
    pgl.plant,
    pgl.stor_loc,
    loc.stor_loc_name as Gudang,
    pgl.tgl_pengeluaran
    
    --rsl.message AS Error
from 
     AGODIST.trans_pengeluaran pgl, 
     AGODIST.master_stor_loc loc
where 
   loc.plant = pgl.plant and
   loc.stor_loc = pgl.stor_loc and
   pgl.flag_deleted = 0 and
   pgl.status_sap ='E' and 
   pgl.plant='5581' and
   pgl.tgl_pengeluaran BETWEEN TO_DATE ('01/01/2019', 'dd/mm/yyyy')
   AND TO_DATE ('31/12/2019', 'dd/mm/yyyy')
group by
    pgl.material_document,
    pgl.plant,
    pgl.stor_loc,
    loc.stor_loc_name,
    pgl.tgl_pengeluaran,
    --rsl.message,
    pgl.tgl_pengeluaran;
    
    
    
--------------
--rata rata pemakaian
---------

select Gudang,round(sum(total_pemakaian)/(count(gudang)),0)rata_rata_pemakaian,sum(total_pemakaian)Jumlah_pemakaian from (
select
    
    pgl.plant,
    pgl.stor_loc,
    loc.stor_loc_name as Gudang,
    pgl.tgl_pengeluaran,
    count(pgl.material_document) as total_pemakaian
    
    --rsl.message AS Error
from 
     AGODIST.trans_pengeluaran pgl ,
     AGODIST.master_stor_loc loc
where 
   loc.plant = pgl.plant and
   loc.stor_loc = pgl.stor_loc and
   pgl.flag_deleted = 0 and
   pgl.status_sap ='S' and 
   pgl.plant = '5581' and
   pgl.tgl_pengeluaran BETWEEN TO_DATE ('01/01/2019', 'dd/mm/yyyy')
   AND TO_DATE ('31/12/2019', 'dd/mm/yyyy')
group by
   -- pgl.material_document,
    pgl.plant,
    pgl.stor_loc,
    loc.stor_loc_name,
    pgl.tgl_pengeluaran,
    --rsl.message,
    pgl.tgl_pengeluaran
order by  3,pgl.tgl_pengeluaran
)group by gudang
order by  1;