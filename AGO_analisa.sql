select
    pgl.material_document as Nomor_Pemakaian,
    pgl.plant,
    pgl.stor_loc,
    pln.plant_name as UP3,
    loc.stor_loc_name as Gudang,
    pgl.tgl_pengeluaran,
    rsl.message AS Error,
    CASE 
    when  rsl.message like '%Batch NORMAL of mat.%' then 'silahkan tanyakan ke bagian UP3 apakah ada material di block oleh SAP'
    when  rsl.message like '%Cannot Connect to Server SAP%' then 'silahkan hapus reservasi dan pemakaian di AGO kemudian buat ulang reservasi dan pemakaiannya'
    when  rsl.message like '%Deficit of BA Unrestricted-use%' then 'Bandingkan stok antar AGO dan SAP, jika ada selisih lebih besar AGO daripada SAP silahkan dilaporkan ke servicedesk supaya bisa dilakukan pengecekan oleh tim support'
    else 'Tanyakan ke service desk'
    END as Solusi
from 
     AGODIST.trans_pengeluaran pgl ,
     AGOINT.int_gmvt_in_header hdr ,
     
     AGOINT.int_gmvt_in_result rsl ,
     AGODIST.master_stor_loc loc,
     AGODIST.master_plant pln
where 
   hdr.session_id_golds = rsl.session_id_golds and
   hdr.mat_doc_ago = pgl.material_document and
   loc.plant = pgl.plant and
   loc.stor_loc = pgl.stor_loc and
   pgl.plant= pln.plant and
   loc.plant = pln.plant and
   pgl.flag_deleted = 0 and
   pgl.status_sap ='E' and 
   pgl.plant like '%6311%' 
group by
    pgl.material_document,
    pgl.plant,
    pgl.stor_loc,
    loc.stor_loc_name,
    pgl.tgl_pengeluaran,
    rsl.message,
    pln.plant_name;
    
select DISTINCT(message) from AGOINT.int_gmvt_in_result;
    
    

