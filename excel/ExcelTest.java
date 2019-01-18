package com.excel;

import com.xuxueli.poi.excel.ExcelExportUtil;
import com.xuxueli.poi.excel.ExcelImportUtil;
import org.junit.Test;

import java.util.ArrayList;
import java.util.List;

/**
 * This is Description
 *
 * @author YangBo
 * @date 2018/11/03
 */
public class ExcelTest {
    @Test
    public void export() {
        List<ExcelDTO> list = new ArrayList<>();
        ExcelDTO t = new ExcelDTO(1, "Eric");
        list.add(t);
//        路径及文件名
        String path = "excelTest.xls";
//        不定长list，多个栏
        ExcelExportUtil.exportToFile(path, list, list);
    }

    @Test
    public void input() {
        String path = "excelTest.xls";
        List<Object> list = ExcelImportUtil.importExcel(path, ExcelDTO.class);

        for (Object e : list) {
            System.out.println((ExcelDTO)e);
        }
    }

}
