Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 616E1CFD376
	for <dpdk-dev@archiver.kernel.org>; Tue,  2 Dec 2025 10:46:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6CAB5402EE;
	Tue,  2 Dec 2025 11:46:12 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by mails.dpdk.org (Postfix) with ESMTP id 93E39400D5;
 Tue,  2 Dec 2025 11:46:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1764672371; x=1796208371;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=Acs+DdWee/IFZejk5hfBAMEVh+AgkKbSyj+xyDms4lw=;
 b=bgxh3ce9aVFr38vuEkZ6HHOkB166+LqVNlFqsWG8rNFdHmTUb4khe2Xo
 4s6B98IBHwqAuJMNZEsNghvZjXrYyJkWxnQGZHhJgcmfuORL8naTOqqFb
 +et3GvOHmdGOGh5YSKMrA+SIwkSS+4unXl3rnmE17F67+aqk7kBMSA1uG
 Qopm8F5o3uWC++BuWjdc0TsL9MstTR/JrqYU8HskIUZ/tFf4YRhBzbiLg
 H4hp+LLwSBeoEH6s1k8T30ZEZwHkF/KghSYdh8ru6CrNnR9OrD/S09823
 k29xYCrRZj68iCsL3rVLSuvmr66eLei8HKeNGctbTiUlHuioX/t+rHTCM A==;
X-CSE-ConnectionGUID: yGMhAYQ3TkGOBy4tBqMQ7w==
X-CSE-MsgGUID: t0NEq6hoSMqyq1Q57iuIXw==
X-IronPort-AV: E=McAfee;i="6800,10657,11630"; a="66347079"
X-IronPort-AV: E=Sophos;i="6.20,242,1758610800"; d="scan'208";a="66347079"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Dec 2025 02:46:10 -0800
X-CSE-ConnectionGUID: av8pbQsbSqu8NseiMzv+tw==
X-CSE-MsgGUID: /rKYimtmTd2swoyfWcsJ8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,242,1758610800"; d="scan'208";a="194435625"
Received: from silpixa00401749.ir.intel.com ([10.20.224.233])
 by orviesa008.jf.intel.com with ESMTP; 02 Dec 2025 02:46:09 -0800
From: Radu Nicolau <radu.nicolau@intel.com>
To: dev@dpdk.org
Cc: Radu Nicolau <radu.nicolau@intel.com>, stable@dpdk.org,
 Kai Ji <kai.ji@intel.com>
Subject: [PATCH 2/2] crypto/qat: align the the vector address
Date: Tue,  2 Dec 2025 10:46:06 +0000
Message-ID: <20251202104606.849348-1-radu.nicolau@intel.com>
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
make sure the alignement is properly propagated.

Fixes: 253174309ff7 ("crypto/qat: fix source buffer alignment")
Cc: stable@dpdk.org

Signed-off-by: Radu Nicolau <radu.nicolau@intel.com>
---
 drivers/crypto/qat/dev/qat_crypto_pmd_gens.h | 33 +++++++++-----------
 1 file changed, 15 insertions(+), 18 deletions(-)

diff --git a/drivers/crypto/qat/dev/qat_crypto_pmd_gens.h b/drivers/crypto/qat/dev/qat_crypto_pmd_gens.h
index 67dc889b50..3883a06aaf 100644
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
+			if (src_data_start - offset >= buff_addr) {
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

