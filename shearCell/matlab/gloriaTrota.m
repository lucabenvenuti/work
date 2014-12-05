                            if (exist('densityBulkBoxMean') &  (vector(nY2rowsBis+1,1)<0.05) & (vector(nY2rowsBis+2,1)<0.05) &   ...
                                    (vector(densityBulkBoxMeanPos,1)<vector(nY2rowsBis+4,1)*(1.0+densTolerance))  ...
                                    &  (vector(densityBulkBoxMeanPos,1)>vector(nY2rowsBis+5,1)*(1.0-densTolerance)) )
                                trotaculo=1
                            end
                            
                            jjj=1;
                            
                            for ii=100000:200000
                                if (exist('densityBulkBoxMean') &  (newY2(nY2rowsBis+1,ii)<0.05) & (newY2(nY2rowsBis+2,ii)<0.05) &   (newY2(densityBulkBoxMeanPos,ii)<newY2(nY2rowsBis+4,ii)*(1.0+densTolerance))  ...
                                        &  (newY2(densityBulkBoxMeanPos,ii)>newY2(nY2rowsBis+5,ii)*(1.0-densTolerance)) )
                                    gloriaTrota(1,jjj) = ii;
                                     jjj=jjj+1;
                                end
                            end
                            
                            
                            
                             for ii=1:100000
                                if (exist('densityBulkBoxMean') &  (gloriaAugustaSchulzeNN(nY2rowsBis+2,ii)<0.05) & (gloriaAugustaSchulzeNN(nY2rowsBis+3,ii)<0.05) & ...
                                        (gloriaAugustaSchulzeNN(densityBulkBoxMeanPos+1,ii)<gloriaAugustaSchulzeNN(nY2rowsBis+5,ii)*(1.0+densTolerance))  ...
                                        &  (gloriaAugustaSchulzeNN(densityBulkBoxMeanPos+1,ii)>gloriaAugustaSchulzeNN(nY2rowsBis+6,ii)*(1.0-densTolerance)) )
                                    gloriaTrota(1,jjj) = ii;
                                     jjj=jjj+1;
                                end
                            end