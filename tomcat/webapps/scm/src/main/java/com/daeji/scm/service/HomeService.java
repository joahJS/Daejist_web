/*
 * Decompiled with CFR 0.152.
 */
package com.daeji.scm.service;

import java.util.List;
import java.util.Map;

public interface HomeService {
    public List<Map<String, Object>> getTableData(Map<String, Object> var1);

    public Map<String, String> chgScmPw(Map<String, Object> var1);

    public List<Map<String, Object>> getPrintData(Map<String, Object> var1);

    public Map<String, Object> getDaejiInfo();

    public List<Map<String, Object>> getTableDataPRE(Map<String, Object> var1);

    public Map<String, Object> getCarryOver(Map<String, Object> var1);
}
