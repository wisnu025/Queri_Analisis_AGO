SELECT *  FROM AGODIST.TRANS_RESERVASI_DETAIL a JOIN 
AGODIST.TRANS_RESERVASI b ON a.NOMOR_RESERVASI=b.NOMOR_RESERVASI 
WHERE b.STATUS_SAP='S' AND b.FLAG_DELETED='1' 
    AND b.PLANT='7213' 
    AND b.STOR_LOC='2030' 
    AND a.MATERIAL_NO='000000000003250015'
    
    AND a.valuation_type='NORMAL'
    AND a.nomor_reservasi not in (select material_document from AGODIST.mutasi_stock);
    
    
select * from AGODIST.mutasi_stock where material_document in (
'233201903191298')and material_no='000000000003250015';

select * from AGODIST.trans_pengeluaran_detail where material_document ='233201903191298';
select * from AGODIST.trans_pengeluaran_batal where no_pemesanan='233201902180596';

select * from 
AGODIST.trans_pengeluaran pgl, AGODIST.trans_pengeluaran_detail dtl
where pgl.material_document = dtl.material_document and
pgl.plant='7213' and pgl.stor_loc='2030' and 
dtl.material_no='000000000003250015'  and dtl.valuation_type='NORMAL' and dtl.material_document not in (select material_document from agodist.mutasi_stock);

select * from AGODIST.trans_pengeluaran where mat_doc_sap='4917039887';
 Pemakaian;
233201903190699 reservasi;
0011267319 mat_doc_sap reservasi;
select * from AGODIST.trans_pengeluaran_detail where material_document='233201903191298';
select * from AGODIST.trans_reservasi where nomor_reservasi='233201903190699';
select * from AGODIST.mutasi_stock where material_document='233201903191298';
select * from AGODIST.mutasi_stock where material_document='233201903190699';

declare
ok VARCHAR2(200)
begin
ok :=agodist.FUNC_UPADTESTOCKSIAPTORESV('7213', '2030', 
    '000000000002190231','NORMAL', '7','233201903190699');
DBMS_OUTPUT.put_line(ok);
end;

select * from AGODIST.mutasi_stock where material_document='535341803272423';


