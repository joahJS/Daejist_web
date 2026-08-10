/*
 * Decompiled with CFR 0.152.
 * 
 * Could not load the following classes:
 *  org.springframework.beans.factory.annotation.Autowired
 *  org.springframework.stereotype.Service
 */
package com.daeji.scm.service.impl;

import com.daeji.scm.dao.HomeDao;
import com.daeji.scm.service.HomeService;
import java.util.List;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service(value="homeService")
public class HomeServiceImpl
implements HomeService {
    @Autowired(required=false)
    HomeDao hDao;

    @Override
    public List<Map<String, Object>> getTableData(Map<String, Object> map) {
        System.out.println(this.hDao.getTableData(map));
        return this.hDao.getTableData(map);
    }

    @Override
    public Map<String, String> chgScmPw(Map<String, Object> map) {
        return this.hDao.chgScmPw(map);
    }

    @Override
    public List<Map<String, Object>> getPrintData(Map<String, Object> map) {
        return this.hDao.getPrintData(map);
    }

    @Override
    public Map<String, Object> getDaejiInfo() {
        return this.hDao.getDaejiInfo();
    }

    @Override
    public List<Map<String, Object>> getTableDataPRE(Map<String, Object> map) {
        return this.hDao.getTableDataPRE(map);
    }

    @Override
    public Map<String, Object> getCarryOver(Map<String, Object> map) {
        return this.hDao.getCarryOver(map);
    }
}
