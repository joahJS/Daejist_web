/*
 * Decompiled with CFR 0.152.
 * 
 * Could not load the following classes:
 *  org.apache.ibatis.session.SqlSession
 *  org.springframework.beans.factory.annotation.Autowired
 */
package com.daeji.scm.dao.impl;

import com.daeji.scm.dao.HomeDao;
import com.daeji.scm.vo.UserVO;
import java.util.List;
import java.util.Map;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;

public class HomeDaoImpl
implements HomeDao {
    @Autowired
    SqlSession session;

    @Override
    public List<UserVO> getUserAuthList(String username) {
        return this.session.selectList("com.daeji.scm.dao.HomeDao.getUserAuthList", (Object)username);
    }

    @Override
    public List<Map<String, Object>> getTableData(Map<String, Object> map) {
        return this.session.selectList("com.daeji.scm.dao.HomeDao.getTableData", map);
    }

    @Override
    public Map<String, String> chgScmPw(Map<String, Object> map) {
        return (Map)this.session.selectOne("com.daeji.scm.dao.HomeDao.chgScmPw", map);
    }

    @Override
    public List<Map<String, Object>> getPrintData(Map<String, Object> map) {
        return this.session.selectList("com.daeji.scm.dao.HomeDao.getPrintData", map);
    }

    @Override
    public Map<String, Object> getDaejiInfo() {
        return (Map)this.session.selectOne("getDaejiInfo");
    }

    @Override
    public List<Map<String, Object>> getTableDataPRE(Map<String, Object> map) {
        return this.session.selectList("com.daeji.scm.dao.HomeDao.getTableDataPRE", map);
    }

    @Override
    public Map<String, Object> getCarryOver(Map<String, Object> map) {
        return (Map)this.session.selectOne("com.daeji.scm.dao.HomeDao.getCarryOver", map);
    }
}
