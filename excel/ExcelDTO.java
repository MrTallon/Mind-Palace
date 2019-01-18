package com.excel;

import com.xuxueli.poi.excel.annotation.ExcelField;
import com.xuxueli.poi.excel.annotation.ExcelSheet;
import org.apache.poi.hssf.util.HSSFColor;

/**
 * 导出Excel测试实体类
 *
 * @author YangBo
 * @date 2018/11/03
 */
@ExcelSheet(name = "测试分栏", headColor = HSSFColor.HSSFColorPredefined.AQUA)
public class ExcelDTO {

    @ExcelField(name = "编号")
    private Integer ID;

    @ExcelField(name = "姓名")
    private String name;

    public ExcelDTO() {
    }

    public ExcelDTO(Integer ID, String name) {
        this.ID = ID;
        this.name = name;
    }

    @Override
    public String toString() {
        return "测试类详情{" +
                "ID=" + ID +
                ", name='" + name + '\'' +
                '}';
    }
}
