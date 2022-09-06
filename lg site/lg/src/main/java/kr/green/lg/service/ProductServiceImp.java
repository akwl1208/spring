package kr.green.lg.service;

import java.io.File;
import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import kr.green.lg.dao.ProductDAO;
import kr.green.lg.pagenation.Criteria;
import kr.green.lg.utils.UploadFileUtils;
import kr.green.lg.vo.CategoryVO;
import kr.green.lg.vo.ProductVO;

@Service
public class ProductServiceImp implements ProductService {

	@Autowired
	ProductDAO productDao;
	
	String productThumbUploadPath = "D:\\git\\product";
	
	@Override
	public int insertCategory(CategoryVO category) {
		if(category == null ||
				category.getCa_name() == null || category.getCa_name().length() == 0 ||
				category.getCa_code() == null || category.getCa_code().length() == 0)
			return -2;
		
		if(category.getCa_code().length() != 3)
			return 1;
		
		try {
			productDao.insertCategory(category);
		} catch (Exception e) {
			return -1;
		}
		return 0;
	}

	@Override
	public ArrayList<CategoryVO> getCategoryList() {
		return productDao.selectCategoryList();
	}

	@Override
	public void insertProduct(ProductVO product, MultipartFile file) {
		if(product == null || file == null || file.getOriginalFilename().length() == 0)
			return;
		
		//파일 업로드
		String prefix = product.getPr_ca_name(); //COM001
		CategoryVO category = productDao.selectCategoryByCa_Code(prefix.substring(0,3));
		try {
			product.setPr_ca_name(category.getCa_name()); 
			String dir = product.getPr_ca_name(); //COM
			
			String str = UploadFileUtils.uploadFile(productThumbUploadPath, File.separator +dir, prefix, file.getOriginalFilename(), file.getBytes());
			product.setPr_thumb("/"+dir+str);
		} catch (Exception e) {
			e.printStackTrace();
			return;
		}
		productDao.insertProduct(product);
		productDao.updateCategory(category);
	}

	@Override
	public ArrayList<ProductVO> selectProductList(Criteria cri) {
		if(cri == null)
			cri = new Criteria();
		return productDao.selectProductList(cri);
	}

	@Override
	public int getProductTotalCount(Criteria cri) {
		if(cri == null)
			cri = new Criteria();
		return productDao.selectProductTotalCount(cri);
	}

	@Override
	public ProductVO selectProduct(String pr_code) {
		if(pr_code == null || pr_code.length() != 6)
			return null;
		return productDao.selectProduct(pr_code);
	}
}
