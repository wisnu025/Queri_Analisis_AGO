select * from AGOINT.int_gmvt_out_result where mat_doc_sap in(
'4918049665',
'4918046690',
'4918046692',
'4918043518',
'4918043518',
'4918043620',
'4918043620',
'4918043564',
'4918043561',
'4918043624');
select * from AGODIST.trans_penerimaan; where flag_deleted='1';
select * from AGODIST.trans_pengiriman;
select * from AGODIST.trans_penerimaan_detail;
select * from AGODIST.master_unitap;
select * from AGODIST.master_unitup;
select * from AGODIST.master_plant;
select * from AGODIST.master_stor_loc;
SELECT * FROM AGODIST.master_stor_loc;
a.tgl_penerimaan => to_date('01-03-2018','dd-mm-yyyy');

select a.material_document as no_penerimaan,
a.plant,c.plant_name,
a.stor_loc_asal,
a.stor_loc_tujuan, 
d.stor_loc_name as Gudang_Penerima,
a.tgl_penerimaan ,
b.mat_doc_sap as mat_doc_Sap_pengiriman 
from 
AGODIST.trans_penerimaan a join 
AGODIST.trans_pengiriman b on a.material_document_pengiriman = b.material_document join
AGODIST.master_plant c on a.plant  = c.plant join AGODIST.master_stor_loc d on d.stor_loc=a.stor_loc_tujuan
and a.plant=d.plant
where 
a.flag_deleted ='0' and 
c.comp_code='52' and 
a.tgl_penerimaan >= to_date('01-03-2018','dd-mm-yyyy');

select a.nomor_reservasi as nomor_reservasi,
a.tgl_reservasi,
a.created_by,
b.plant_name as UP3 ,
c.stor_loc_name as ULP
from AGODIST.trans_reservasi a join 
AGODIST.master_plant b on  a.plant=b.plant join 
AGODIST.master_stor_loc c on c.stor_loc=a.stor_loc
and a.plant=c.plant where
a.status_sap='S' and 
a.flag_deleted='0' and
a.tgl_reservasi >= to_date('01-03-2018','dd-mm-yyyy') and
b.comp_code='52';

select * from AGOINT.int_gmvt_out_result where mat_doc_sap in(
'4917869051');

select distinct(material_no) from AGOINT.int_gmvt_out_detail where mat_doc_sap = '4918080149' and material_no not in (
select DISTINCT(material_no) from AGODIST.material_stock where plant = '7614' );



