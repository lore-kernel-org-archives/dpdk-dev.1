Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96167CFD376
	for <dpdk-dev@archiver.kernel.org>; Tue,  2 Dec 2025 10:58:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9188040268;
	Tue,  2 Dec 2025 11:58:40 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by mails.dpdk.org (Postfix) with ESMTP id BBA4D400D5;
 Tue,  2 Dec 2025 11:58:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1764673119; x=1796209119;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=YJCq2wG22n129R07iazSEduk7zUBvywWfe/g3dTJ6i0=;
 b=VNwYdJi3nRwtaWQKk2bYYqx+FSaJLh+WRyo56PqLBjvCb82+6ODaVTVX
 OHBWlK6cVPauV7HqYMmfwTan34osKwR/b4n1yme0NC04eZch9Y+rOr362
 5/Eyx/q8fjBFU1T1OHldJ2mD3VT76UO7RmPr4G+elXTerzc+i41gXeqXD
 McSvo+rSyhnMTY6weJcnh4BDO7cV2HlW1Uz7Lp80DwUSy3ld/CCYBZbKd
 A4Bgh/MKEWkMmvirlncw0UlmkvAVRrKsps8x8wOxmTb+RbO9GzX7lFJYp
 yE6UxUMgNqa3P9Bwxr9bi1W/Q23pAiM9//GXyoxIwqC4eD0GynSLLfctQ g==;
X-CSE-ConnectionGUID: BWoysAPHQgC+OfUk4gL/sg==
X-CSE-MsgGUID: AOLlfk68S76TcnBm7Pa7oA==
X-IronPort-AV: E=McAfee;i="6800,10657,11630"; a="66579453"
X-IronPort-AV: E=Sophos;i="6.20,242,1758610800"; d="scan'208";a="66579453"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Dec 2025 02:57:35 -0800
X-CSE-ConnectionGUID: 4o41XHd8R9G9int3E7v7Bg==
X-CSE-MsgGUID: Q1JnORzrSKmh1+d9GiVxaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,242,1758610800"; d="scan'208";a="194776352"
Received: from silpixa00401749.ir.intel.com ([10.20.224.233])
 by fmviesa009.fm.intel.com with ESMTP; 02 Dec 2025 02:57:33 -0800
From: Radu Nicolau <radu.nicolau@intel.com>
To: dev@dpdk.org
Cc: Radu Nicolau <radu.nicolau@intel.com>, stable@dpdk.org,
 Kai Ji <kai.ji@intel.com>
Subject: [PATCH] crypto/qat: align the the vector address
Date: Tue,  2 Dec 2025 10:57:31 +0000
Message-ID: <20251202105731.851124-1-radu.nicolau@intel.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Unsubscribe: <https://mails.dpdk.org/options/dev>,
 <mailto:dev-request@dpdk.org?subject=unsubscribe>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
Errors-To: dev-bounces@dpdk.org

Align the vector address rather than computed source address to
make sure the alignment is properly propagated.

Fixes: 253174309ff7 ("crypto/qat: fix source buffer alignment")
Cc: stable@dpdk.org

Signed-off-by: Radu Nicolau <radu.nicolau@intel.com>
---
 drivers/crypto/qat/dev/qat_crypto_pmd_gens.h | 33 +++++++++-----------
 1 file changed, 15 insertions(+), 18 deletions(-)

diff --git a/drivers/crypto/qat/dev/qat_crypto_pmd_gens.h b/drivers/crypto/qat/dev/qat_crypto_pmd_gens.h
index 67dc889b50..22ee0fe4fe 100644
--- a/drivers/crypto/qat/dev/qat_crypto_pmd_gens.h
+++ b/drivers/crypto/qat/dev/qat_crypto_pmd_gens.h
@@ -443,6 +443,21 @@ qat_sym_build_req_set_data(struct icp_qat_fw_la_bulk_req *req,
 			n_dst > QAT_SYM_SGL_MAX_NUMBER))
 		return -1;
 
+	/* For crypto API only: try to align the in-place buffers*/
+	if (op != NULL && likely(n_dst == 0) && likely(!is_sgl)) {
+		rte_iova_t offset = src_vec[0].iova & RTE_CACHE_LINE_MASK;
+		if (offset) {
+			rte_iova_t buff_addr = rte_mbuf_iova_get(op->sym->m_src);
+			/* make sure src_data_start is still within the buffer */
+			if (src_vec[0].iova - offset >= buff_addr) {
+				src_vec[0].iova -= offset;
+				src_vec[0].len += offset;
+				ofs->ofs.auth.head += offset;
+				ofs->ofs.cipher.head += offset;
+			}
+		}
+	}
+
 	if (likely(!is_sgl)) {
 		src_data_start = src_vec[0].iova;
 		tl_src = total_len_src =
@@ -503,24 +518,6 @@ qat_sym_build_req_set_data(struct icp_qat_fw_la_bulk_req *req,
 			dst_data_start = src_data_start;
 	}
 
-	/* For crypto API only try to align the in-place buffers*/
-	if (op != NULL && likely(n_dst == 0)) {
-		uint16_t offset = src_data_start & RTE_CACHE_LINE_MASK;
-		if (offset) {
-			rte_iova_t buff_addr = rte_mbuf_iova_get(op->sym->m_src);
-			/* make sure src_data_start is still within the buffer */
-			if (src_data_start - offset >= buff_addr) {
-				src_data_start -= offset;
-				dst_data_start = src_data_start;
-				ofs->ofs.auth.head += offset;
-				ofs->ofs.cipher.head += offset;
-				tl_src += offset;
-				total_len_src = tl_src;
-				total_len_dst = tl_src;
-			}
-		}
-	}
-
 	req->comn_mid.src_data_addr = src_data_start;
 	req->comn_mid.dest_data_addr = dst_data_start;
 	req->comn_mid.src_length = total_len_src;
-- 
2.50.1

