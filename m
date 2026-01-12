Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2B2CC9EC7C
	for <dpdk-dev@archiver.kernel.org>; Mon, 12 Jan 2026 12:23:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E244E40DF8;
	Mon, 12 Jan 2026 13:23:19 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 04B1E40DD7
 for <dev@dpdk.org>; Mon, 12 Jan 2026 13:23:17 +0100 (CET)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 60C43tQp052142 for <dev@dpdk.org>; Mon, 12 Jan 2026 04:23:17 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=F
 Qj5r0SzphI2pc1HKAW6tmbnj4YQlQylsUQwxi9CoLA=; b=cNgIoNIOTg/Y1EdgU
 CfgYHAL2yAZHC0SJlFDNcqEFqE2TFdMUJ5A+9D1egme75/dyAlj/gAooW4yV1Zx1
 8d2XR9KnZBWl7XuBhF9whV9G6QXse5oAHW/m6JrpHcgJbR1613vt5WqTvDRZA2G2
 ECeoKWABF3GGeMu/WYry3pWOEqC2unqx9kURxyMb3w3qRFmtIPk23ZCYymb0eB/0
 4QfCUQhnWsucjks07Pf0W9gAsLpkYg5sztHNLsmbxnCCNGqm9gg3YKtoUPtuZMbS
 y92mTeyT8p7tkEoNCdoM/Hu0pO3KmW2rGTMn+uONDSPdeY/nMYjUP5jy8aMyYbn4
 Tu4ng==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4bm8dbjb3n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Mon, 12 Jan 2026 04:23:16 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 12 Jan 2026 04:23:30 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 12 Jan 2026 04:23:30 -0800
Received: from hyd1554.caveonetworks.com (unknown [10.29.56.32])
 by maili.marvell.com (Postfix) with ESMTP id 631EC3F70A1;
 Mon, 12 Jan 2026 04:23:14 -0800 (PST)
From: Tejasree Kondoj <ktejasree@marvell.com>
To: Akhil Goyal <gakhil@marvell.com>
CC: Anoob Joseph <anoobj@marvell.com>, Nithinsen Kaithakadan
 <nkaithakadan@marvell.com>, <dev@dpdk.org>
Subject: [PATCH 2/2] crypto/cnxk: align TLS CPTR to 256B
Date: Mon, 12 Jan 2026 17:53:09 +0530
Message-ID: <20260112122309.2448535-3-ktejasree@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260112122309.2448535-1-ktejasree@marvell.com>
References: <20260112122309.2448535-1-ktejasree@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: I10Esak6uRBM1NWcPGlzNdVkXvxjGQ9O
X-Authority-Analysis: v=2.4 cv=DNKCIiNb c=1 sm=1 tr=0 ts=6964e7b4 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=M5GUcnROAAAA:8
 a=G-eMEw5_6xTkAFNbRx4A:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: I10Esak6uRBM1NWcPGlzNdVkXvxjGQ9O
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEyMDA5OSBTYWx0ZWRfX3r3MIs6ORiJd
 Qa05mIm0Hxv23BJR5m079eztmPVU+ZYO8gT71kOhb2Ne14ScSbQpGWL3vOEgSbqiFtHR1Zt7eHM
 eEAyPoSAJslpskMF1+8XnLd0eDlvEEqZcRR0EhHiaqF5tX9Qww1uSFMSr/3zRK5RCTR935ZEraW
 4c3D+kIBUzdXc+gB300TTV3sDhc222FjTMnqZ05RefS6+01Iu2pbkQepg43G7nftjbZvaBGG+vq
 2D499+62NvtuJkJ3fYZ+UAy8G679gaeg7XA9WJzww26SpYCL9AlGFrjviLSqUGQMqPdLTL6X7Ld
 9MYwf/OvJGW8frYMWtJ7rq7vGzqSuNn8RIV8HeRUoIAKzDG8C7VUplKU1VxxdVQ1oUkwuTFQCBb
 5Gx0rFd0CAehOHsoDn/bsjMcQtax6l8GWXJuyvIyMrQxrIy4wGu8rDpf6kRflpOwva3hdc/hJe7
 5vTcgvFYkgnN9Jmri2g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-12_03,2026-01-09_02,2025-10-01_01
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

Aligning CPTR to 256B for TLS cases.

Signed-off-by: Tejasree Kondoj <ktejasree@marvell.com>
---
 drivers/common/cnxk/roc_cpt.c       |  4 +--
 drivers/crypto/cnxk/cn20k_tls.c     | 47 +++++++++++++++++++++++------
 drivers/crypto/cnxk/cn20k_tls.h     | 15 ++++++---
 drivers/crypto/cnxk/cn20k_tls_ops.h |  6 +++-
 4 files changed, 55 insertions(+), 17 deletions(-)

diff --git a/drivers/common/cnxk/roc_cpt.c b/drivers/common/cnxk/roc_cpt.c
index 83e0c9896b..0deb0b52d5 100644
--- a/drivers/common/cnxk/roc_cpt.c
+++ b/drivers/common/cnxk/roc_cpt.c
@@ -1275,8 +1275,8 @@ roc_cpt_ctx_write(struct roc_cpt_lf *lf, void *sa_dptr, void *sa_cptr,
 	uint8_t egrp;
 	int i;
 
-	if (!plt_is_aligned(sa_cptr, 128)) {
-		plt_err("Context pointer should be 128B aligned");
+	if (!plt_is_aligned(sa_cptr, ROC_CPTR_ALIGN)) {
+		plt_err("Context pointer should be %dB aligned", ROC_CPTR_ALIGN);
 		return -EINVAL;
 	}
 
diff --git a/drivers/crypto/cnxk/cn20k_tls.c b/drivers/crypto/cnxk/cn20k_tls.c
index 9f7acefc19..8556a95ab6 100644
--- a/drivers/crypto/cnxk/cn20k_tls.c
+++ b/drivers/crypto/cnxk/cn20k_tls.c
@@ -385,13 +385,20 @@ cn20k_tls_read_sa_create(struct roc_cpt *roc_cpt, struct roc_cpt_lf *lf,
 	int ret = 0;
 
 	tls = &sec_sess->tls_rec;
-	read_sa = &tls->read_sa;
+
+	read_sa = rte_zmalloc("cn20k_tls", sizeof(struct roc_ie_ow_tls_read_sa), ROC_CPTR_ALIGN);
+	if (read_sa == NULL) {
+		plt_err("Couldn't allocate memory for READ SA");
+		return -ENOMEM;
+	}
+	tls->read_sa = read_sa;
 
 	/* Allocate memory to be used as dptr for CPT ucode WRITE_SA op */
 	sa_dptr = plt_zmalloc(sizeof(struct roc_ie_ow_tls_read_sa), 8);
 	if (sa_dptr == NULL) {
 		plt_err("Could not allocate memory for SA dptr");
-		return -ENOMEM;
+		ret = -ENOMEM;
+		goto sa_cptr_free;
 	}
 
 	/* Translate security parameters to SA */
@@ -457,6 +464,11 @@ cn20k_tls_read_sa_create(struct roc_cpt *roc_cpt, struct roc_cpt_lf *lf,
 
 sa_dptr_free:
 	plt_free(sa_dptr);
+sa_cptr_free:
+	if (ret != 0) {
+		rte_free(read_sa);
+		read_sa = NULL;
+	}
 
 	return ret;
 }
@@ -706,13 +718,20 @@ cn20k_tls_write_sa_create(struct roc_cpt *roc_cpt, struct roc_cpt_lf *lf,
 	int ret = 0;
 
 	tls = &sec_sess->tls_rec;
-	write_sa = &tls->write_sa;
+
+	write_sa = rte_zmalloc("cn20k_tls", sizeof(struct roc_ie_ow_tls_write_sa), ROC_CPTR_ALIGN);
+	if (write_sa == NULL) {
+		plt_err("Couldn't allocate memory for WRITE SA");
+		return -ENOMEM;
+	}
+	tls->write_sa = write_sa;
 
 	/* Allocate memory to be used as dptr for CPT ucode WRITE_SA op */
 	sa_dptr = plt_zmalloc(sizeof(struct roc_ie_ow_tls_write_sa), 8);
 	if (sa_dptr == NULL) {
 		plt_err("Could not allocate memory for SA dptr");
-		return -ENOMEM;
+		ret = -ENOMEM;
+		goto sa_cptr_free;
 	}
 
 	/* Translate security parameters to SA */
@@ -781,6 +800,11 @@ cn20k_tls_write_sa_create(struct roc_cpt *roc_cpt, struct roc_cpt_lf *lf,
 
 sa_dptr_free:
 	plt_free(sa_dptr);
+sa_cptr_free:
+	if (ret != 0) {
+		rte_free(write_sa);
+		write_sa = NULL;
+	}
 
 	return ret;
 }
@@ -868,15 +892,18 @@ cn20k_sec_tls_session_destroy(struct cnxk_cpt_qp *qp, struct cn20k_sec_session *
 
 	tls = &sess->tls_rec;
 
+	if (tls->sa_ptr == NULL)
+		return -EINVAL;
+
 	/* Trigger CTX flush to write dirty data back to DRAM */
-	roc_cpt_lf_ctx_flush(lf, &tls->read_sa, false);
+	roc_cpt_lf_ctx_flush(lf, tls->read_sa, false);
 
 	if (sess->tls_opt.is_write) {
 		sa_dptr = plt_zmalloc(sizeof(struct roc_ie_ow_tls_write_sa), 8);
 		if (sa_dptr != NULL) {
 			tls_write_sa_init(sa_dptr);
 
-			ret = roc_cpt_ctx_write(lf, sa_dptr, &tls->write_sa,
+			ret = roc_cpt_ctx_write(lf, sa_dptr, tls->write_sa,
 						sizeof(struct roc_ie_ow_tls_write_sa));
 			plt_free(sa_dptr);
 		}
@@ -889,14 +916,14 @@ cn20k_sec_tls_session_destroy(struct cnxk_cpt_qp *qp, struct cn20k_sec_session *
 			rte_atomic_thread_fence(rte_memory_order_seq_cst);
 
 			/* Trigger CTX reload to fetch new data from DRAM */
-			roc_cpt_lf_ctx_reload(lf, &tls->write_sa);
+			roc_cpt_lf_ctx_reload(lf, tls->write_sa);
 		}
 	} else {
 		sa_dptr = plt_zmalloc(sizeof(struct roc_ie_ow_tls_read_sa), 8);
 		if (sa_dptr != NULL) {
 			tls_read_sa_init(sa_dptr);
 
-			ret = roc_cpt_ctx_write(lf, sa_dptr, &tls->read_sa,
+			ret = roc_cpt_ctx_write(lf, sa_dptr, tls->read_sa,
 						sizeof(struct roc_ie_ow_tls_read_sa));
 			plt_free(sa_dptr);
 		}
@@ -909,9 +936,11 @@ cn20k_sec_tls_session_destroy(struct cnxk_cpt_qp *qp, struct cn20k_sec_session *
 			rte_atomic_thread_fence(rte_memory_order_seq_cst);
 
 			/* Trigger CTX reload to fetch new data from DRAM */
-			roc_cpt_lf_ctx_reload(lf, &tls->read_sa);
+			roc_cpt_lf_ctx_reload(lf, tls->read_sa);
 		}
 	}
 
+	rte_free(tls->sa_ptr);
+
 	return 0;
 }
diff --git a/drivers/crypto/cnxk/cn20k_tls.h b/drivers/crypto/cnxk/cn20k_tls.h
index 27124602a0..5fed749545 100644
--- a/drivers/crypto/cnxk/cn20k_tls.h
+++ b/drivers/crypto/cnxk/cn20k_tls.h
@@ -16,13 +16,18 @@
 /* Forward declaration */
 struct cn20k_sec_session;
 
-struct __rte_aligned(ROC_ALIGN) cn20k_tls_record
+struct __rte_aligned(ROC_CPTR_ALIGN) cn20k_tls_record
 {
 	union {
-		/** Read SA */
-		struct roc_ie_ow_tls_read_sa read_sa;
-		/** Write SA */
-		struct roc_ie_ow_tls_write_sa write_sa;
+		void *sa_ptr;
+		struct {
+			union {
+				/** Read SA */
+				struct roc_ie_ow_tls_read_sa *read_sa;
+				/** Write SA */
+				struct roc_ie_ow_tls_write_sa *write_sa;
+			};
+		};
 	};
 };
 
diff --git a/drivers/crypto/cnxk/cn20k_tls_ops.h b/drivers/crypto/cnxk/cn20k_tls_ops.h
index 9f70a1d42d..e7a8ba34ae 100644
--- a/drivers/crypto/cnxk/cn20k_tls_ops.h
+++ b/drivers/crypto/cnxk/cn20k_tls_ops.h
@@ -38,7 +38,11 @@ process_tls_write(struct roc_cpt_lf *lf, struct rte_crypto_op *cop, struct cn20k
 	pad_len = (pad_bytes >> tls_opt.pad_shift) * tls_opt.enable_padding;
 
 #ifdef LA_IPSEC_DEBUG
-	write_sa = &sess->tls_rec.write_sa;
+	write_sa = sess->tls_rec.write_sa;
+	if (write_sa == NULL) {
+		return -EINVAL;
+	}
+
 	if (write_sa->w2.s.iv_at_cptr == ROC_IE_OW_TLS_IV_SRC_FROM_SA) {
 
 		uint8_t *iv = PLT_PTR_ADD(write_sa->cipher_key, 32);
-- 
2.25.1

