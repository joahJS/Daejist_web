/*
 * Decompiled with CFR 0.152.
 */
package com.daeji.scm.dao;

import com.daeji.scm.vo.UserVO;
import java.util.List;
import java.util.Map;

public interface HomeDao {
    public List<UserVO> getUserAuthList(String var1);

    public List<Map<String, Object>> getTableData(Map<String, Object> var1);

    public Map<String, String> chgScmPw(Map<String, Object> var1);

    public List<Map<String, Object>> getPrintData(Map<String, Object> var1);

    public Map<String, Object> getDaejiInfo();

    public List<Map<String, Object>> getTableDataPRE(Map<String, Object> var1);

    public Map<String, Object> getCarryOver(Map<String, Object> var1);
}
