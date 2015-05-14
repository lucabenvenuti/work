exp_file_name_list = {'20131001_1117_Iron_ore',1;'20131001_1157_Iron_ore',2;'20131001_13011_Iron_ore',3;'20131128_0957_PP_test01',4;'20131128_1016_PP_test02',5;'20131128_1058_PP_test03',6;'20131128_1114_PP_test04',7;'20131128_1140_PP_test05',8;'20131128_1158_silibeads2mm_test01',9;'20131128_1218_silibeads2mm_test02',10;'20131128_1238_silibeads2mm_test03',11;'20131128_1443_silibeads4mm_test01',12;'20131128_1517_silibeads4mm_test02',13;'20131128_1612_sinterfine315-10_test01',14;'20131128_1712_sinterfine315-10_test02',15;'20131128_1742_sinterfine315-10_test03',16;'20131128_1824_sinterfine0-315_test01',17;'20131128_1851_sinterfine0-315_test02',18;'20131128_1951_sinterfine0-315_test03',19;'20131129_0841_sinterfine0-315_test04',20;'20131129_0921_limestone315-10_test01',21;'20131129_1000_limestone315-10_test02',22;'20131129_1019_limestone0-315_test01',23;'20131129_1035_limestone0-315_test02',24;'20131129_1059_limestone0-315_test03',25;'20131129_1121_limestone0-315_test04',26;'20131129_1155_coal315-10_test01',27;'20131129_1245_coal315-10_test02',28;'20131129_1356_coal0-315_test02',29;'20131129_1418_coal0-315_test03',30;'20131129_1437_coal0-315_test04',31;'20131129_1514_ironore315-10_test01',32;'20131129_1554_ironore315-10_test02',33;'20131129_1610_ironore0-315_test01',34;'20131129_1629_ironore0-315_test02',35;'20131129_1648_ironore0-315_test03',36;'20131129_1713_ironore0-315_test04',37;'20131129_1733_ironore0-315_test05',38;'20131129_1831_ironore315-10_test03',39;'20131129_1854_saatbau_test01',40;'20131129_1915_perlite_test01',41;'Iron_ore1030-011013',42;'Iron_ore1030-011013.in',43};

k=1;

for i=[2,5:41]
    
    exp_file_name = exp_file_name_list{i,1};
    
    exp{k}.exp_file_name = exp_file_name;
    [exp{k}.coeffShear40, exp{k}.coeffShear60, exp{k}.coeffShear80, exp{k}.coeffShear100, exp{k}.expFtd, exp{k}.expInp, exp{k}.expOut] = experimentalImport(exp_file_name );
    
    k = k +1 ;
    
end

k = 1;

for j = 1: length(exp)
	if ( exp{j, 1}.expOut.sigmaAnM < 5100 & exp{j, 1}.expOut.sigmaAnM > 4900)
        exp2{k,1} = exp{j, 1};
        k = k + 1  ;
    end
end