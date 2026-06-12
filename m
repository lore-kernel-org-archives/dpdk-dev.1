Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BB4FCD98CE
	for <dpdk-dev@archiver.kernel.org>; Fri, 12 Jun 2026 06:20:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EF6864027F;
	Fri, 12 Jun 2026 08:20:38 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 5C2B640279;
 Fri, 12 Jun 2026 08:20:37 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65C39Hw83782261; Thu, 11 Jun 2026 23:20:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pfpt0220; bh=Vx6rdafp5P7EtDOB88dcmhZ
 KEyX8jtx00e2+hD+NkYg=; b=ghRui0yh7OJ0uv/5hICba6N5hHTWsIcluI8zmWf
 egnm3w8vMLbItcUdpVh0ETRh0z8dV7RmLiFDlGkSCA0o6bAUIM26QX8epT1eOUkp
 E6jk0VXkUoZw6CeLkJMuvq05xOF5CGIezWBEZdsg5b5lw3l8Z29hbPBFTCIeRGxF
 Y3yb0UthoIN9h9Kos6OqjDh0WtnwQVTypvX+O9FF9xi3Ce1WfnQvYRlh9ugK/YUY
 2JLh8CebfkTi7J85tJAToDcVyUI1zJneHQ6MZXW+L041w86OpZlkQ0AlQwFhjwSy
 3Xw9QtEt7uC2JNm/Ae1e7tAEefAAzQqQI3343QK3FYTp6vQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4er6r2h1uq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 11 Jun 2026 23:20:36 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 11 Jun 2026 23:20:35 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 11 Jun 2026 23:20:35 -0700
Received: from cavium-OptiPlex-9020.. (unknown [10.28.38.191])
 by maili.marvell.com (Postfix) with ESMTP id 4DC203F7051;
 Thu, 11 Jun 2026 23:20:33 -0700 (PDT)
From: Daphne Priscilla <df@marvell.com>
To: <dev@dpdk.org>
CC: <stable@dpdk.org>, <gakhil@marvell.com>, <ktejasree@marvell.com>,
 <anoobj@marvell.com>, Daphne Priscilla <df@marvell.com>
Subject: [PATCH] crypto/cnxk: fix out of place AES GCM
Date: Fri, 12 Jun 2026 11:50:09 +0530
Message-ID: <20260612062009.3587783-1-df@marvell.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEyMDA1NCBTYWx0ZWRfX28zZq9AU9s+G
 YKibuQ/e08/mxdqT0NXwWRS5GwFulr6GcfB5rwsrGNbHnY7UuZw+pm5Y3RrsQwRDT4FIxXDAy7/
 o1jDC/OHKindzAO+X0ftyjl8KGXm5fe597MWZc7HsfLtC/me6U8tlpXgC0PKvlgMgN3dSHvw1fH
 MewzzYRwK46L+BadimF5OL8Y70GI6+rBkBIhdKlBCt7xRUKDAtuKDPZtXpclHyByNPAhepL0C50
 mbjRlT9PGNTuEoHZU1yNOJEQpoG0R/ReMgPTjFeFy2vK+QYfVQD1yN/ZHbcR+YleJqZsGLyz6//
 VA1t0BW8PlbzvOfY+DMCdxg5VcIzcSsqutMfmbzG8/d2E1vzSMGNIoaGzM8J3+UPxpDWnW7zxct
 u5OL04jy4OEPAx3xYkVfc961thKklFXLliLaxvuw6YNjarNehtO4pq7BbS4eV4CXevH14Xk2j4I
 8FQJbSvOAY2vrvie9zw==
X-Authority-Analysis: v=2.4 cv=GoByPE1C c=1 sm=1 tr=0 ts=6a2ba534 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=qit2iCtTFQkLgVSMPQTB:22 a=8rWy6zfcAAAA:8 a=M5GUcnROAAAA:8 a=QyXUC8HyAAAA:8
 a=KgxZQTYqAAAA:8 a=_Z4P8YoxkZqYIHta7eIA:9 a=YjdVzJdQTyZRADMV7wFX:22
 a=OBjm3rFKGHvpk9ecZwUJ:22 a=J70gtpi9w7iKWgri9Xi8:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjEyMDA1NCBTYWx0ZWRfX0TPHA4GBKZm3
 M7cRmrf0jQ70Ea4WvJrR95YnIqWBdGqDKa8+rjdDnWFespi5oV4bPbFMaMa45Tj1UaZ73h2hYMe
 /FWpDzJ3mcssioqRYp+mLVbHfHpwxmQ=
X-Proofpoint-GUID: kSCqPgXXApFkilOWwvp3psI9na0srILX
X-Proofpoint-ORIG-GUID: kSCqPgXXApFkilOWwvp3psI9na0srILX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-12_01,2026-06-11_01,2025-10-01_01
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

For AES-GCM out of place, when AAD is present in inbuf before the data,
it is treated as passthrough data. This results in AAD being
present in outbuf header, but test expects outbuf header to remain
zero. Passthrough data is now diverted to metabuf so outbuf
header remains zero.

Fixes: 7c19abdd0cf1 ("common/cnxk: support 103XX CPT")
Cc: stable@dpdk.org

Signed-off-by: Daphne Priscilla <df@marvell.com>
---
 .mailmap                                 |  1 +
 drivers/common/cnxk/roc_se.h             |  2 +-
 drivers/crypto/cnxk/cnxk_cryptodev_ops.c |  3 +
 drivers/crypto/cnxk/cnxk_se.h            | 96 ++++++++++++++++++++++--
 4 files changed, 93 insertions(+), 9 deletions(-)

diff --git a/.mailmap b/.mailmap
index 118dfa0ff9..1191afbf0b 100644
--- a/.mailmap
+++ b/.mailmap
@@ -334,6 +334,7 @@ Danny Patel <dannyp@marvell.com>
 Danny Zhou <danny.zhou@intel.com>
 Danylo Vodopianov <dvo-plv@napatech.com>
 Dapeng Yu <dapengx.yu@intel.com>
+Daphne Priscilla <df@marvell.com>
 Darek Stojaczyk <dariusz.stojaczyk@intel.com>
 Daria Kolistratova <daria.kolistratova@intel.com>
 Dariusz Chaberski <dariuszx.chaberski@intel.com>
diff --git a/drivers/common/cnxk/roc_se.h b/drivers/common/cnxk/roc_se.h
index 499e71ce85..d3ad61ca04 100644
--- a/drivers/common/cnxk/roc_se.h
+++ b/drivers/common/cnxk/roc_se.h
@@ -26,7 +26,7 @@
 #define ROC_SE_MISC_MINOR_OP_DUMMY	 0x04ULL
 #define ROC_SE_MISC_MINOR_OP_HW_SUPPORT	 0x08ULL
 
-#define ROC_SE_MAX_AAD_SIZE 64
+#define ROC_SE_MAX_AAD_SIZE 1024
 #define ROC_SE_MAX_MAC_LEN  64
 
 #define ROC_SE_OFF_CTRL_LEN 8
diff --git a/drivers/crypto/cnxk/cnxk_cryptodev_ops.c b/drivers/crypto/cnxk/cnxk_cryptodev_ops.c
index 2f9eb322dc..5e59f1d7bd 100644
--- a/drivers/crypto/cnxk/cnxk_cryptodev_ops.c
+++ b/drivers/crypto/cnxk/cnxk_cryptodev_ops.c
@@ -82,6 +82,9 @@ cnxk_cpt_get_mlen(void)
 			       (RTE_ALIGN_CEIL(ROC_MAX_SG_IN_OUT_CNT, 4) >> 2) * ROC_SG_ENTRY_SIZE),
 			      8);
 
+	/* Space for discarding AAD bytes from output stream in GCM OOP */
+	len += ROC_SE_MAX_AAD_SIZE;
+
 	return len;
 }
 
diff --git a/drivers/crypto/cnxk/cnxk_se.h b/drivers/crypto/cnxk/cnxk_se.h
index 8dbf3e73c7..09d9d1e0e3 100644
--- a/drivers/crypto/cnxk/cnxk_se.h
+++ b/drivers/crypto/cnxk/cnxk_se.h
@@ -407,8 +407,28 @@ sg_inst_prep(struct roc_se_fc_params *params, struct cpt_inst_s *inst, uint64_t
 			if (unlikely(req_flags & ROC_SE_SINGLE_BUF_INPLACE)) {
 				i = fill_sg_comp_from_buf_min(scatter_comp, i, params->bufs, &size);
 			} else {
-				i = fill_sg_comp_from_iov(scatter_comp, i, params->dst_iov, 0,
-							  &size, aad_buf, aad_offset);
+				uint32_t dst_offset = 0;
+
+				if (passthrough_len) {
+					if (unlikely(passthrough_len > ROC_SE_MAX_AAD_SIZE)) {
+						plt_dp_err(
+							"Passthrough length %u exceeds reserved space %u",
+							passthrough_len, ROC_SE_MAX_AAD_SIZE);
+						return -1;
+					}
+					uint64_t meta_passthrough =
+						(uint64_t)params->meta_buf.vaddr +
+						params->meta_buf.size - ROC_SE_MAX_AAD_SIZE;
+					i = fill_sg_comp(scatter_comp, i, meta_passthrough,
+							 passthrough_len);
+					size -= passthrough_len;
+					dst_offset = passthrough_len;
+					aad_offset = 0;
+				}
+				if (size)
+					i = fill_sg_comp_from_iov(scatter_comp, i, params->dst_iov,
+								  dst_offset, &size, aad_buf,
+								  aad_offset);
 			}
 			if (unlikely(size)) {
 				plt_dp_err("Insufficient buffer space,"
@@ -430,8 +450,28 @@ sg_inst_prep(struct roc_se_fc_params *params, struct cpt_inst_s *inst, uint64_t
 			if (unlikely(req_flags & ROC_SE_SINGLE_BUF_INPLACE)) {
 				i = fill_sg_comp_from_buf_min(scatter_comp, i, params->bufs, &size);
 			} else {
-				i = fill_sg_comp_from_iov(scatter_comp, i, params->dst_iov, 0,
-							  &size, aad_buf, aad_offset);
+				uint32_t dst_offset = 0;
+
+				if (passthrough_len) {
+					if (unlikely(passthrough_len > ROC_SE_MAX_AAD_SIZE)) {
+						plt_dp_err(
+							"Passthrough length %u exceeds reserved space %u",
+							passthrough_len, ROC_SE_MAX_AAD_SIZE);
+						return -1;
+					}
+					uint64_t meta_passthrough =
+						(uint64_t)params->meta_buf.vaddr +
+						params->meta_buf.size - ROC_SE_MAX_AAD_SIZE;
+					i = fill_sg_comp(scatter_comp, i, meta_passthrough,
+							 passthrough_len);
+					size -= passthrough_len;
+					dst_offset = passthrough_len;
+					aad_offset = 0;
+				}
+				if (size)
+					i = fill_sg_comp_from_iov(scatter_comp, i, params->dst_iov,
+								  dst_offset, &size, aad_buf,
+								  aad_offset);
 			}
 
 			if (unlikely(size)) {
@@ -606,8 +646,28 @@ sg2_inst_prep(struct roc_se_fc_params *params, struct cpt_inst_s *inst, uint64_t
 				i = fill_sg2_comp_from_buf_min(scatter_comp, i, params->bufs,
 							       &size);
 			} else {
-				i = fill_sg2_comp_from_iov(scatter_comp, i, params->dst_iov, 0,
-							   &size, aad_buf, aad_offset);
+				uint32_t dst_offset = 0;
+
+				if (passthrough_len) {
+					if (unlikely(passthrough_len > ROC_SE_MAX_AAD_SIZE)) {
+						plt_dp_err(
+							"Passthrough length %u exceeds reserved space %u",
+							passthrough_len, ROC_SE_MAX_AAD_SIZE);
+						return -1;
+					}
+					uint64_t meta_passthrough =
+						(uint64_t)params->meta_buf.vaddr +
+						params->meta_buf.size - ROC_SE_MAX_AAD_SIZE;
+					i = fill_sg2_comp(scatter_comp, i, meta_passthrough,
+							  passthrough_len);
+					size -= passthrough_len;
+					dst_offset = passthrough_len;
+					aad_offset = 0;
+				}
+				if (size)
+					i = fill_sg2_comp_from_iov(scatter_comp, i, params->dst_iov,
+								   dst_offset, &size, aad_buf,
+								   aad_offset);
 			}
 			if (unlikely(size)) {
 				plt_dp_err("Insufficient buffer space,"
@@ -632,8 +692,28 @@ sg2_inst_prep(struct roc_se_fc_params *params, struct cpt_inst_s *inst, uint64_t
 				i = fill_sg2_comp_from_buf_min(scatter_comp, i, params->bufs,
 							       &size);
 			} else {
-				i = fill_sg2_comp_from_iov(scatter_comp, i, params->dst_iov, 0,
-							   &size, aad_buf, aad_offset);
+				uint32_t dst_offset = 0;
+
+				if (passthrough_len) {
+					if (unlikely(passthrough_len > ROC_SE_MAX_AAD_SIZE)) {
+						plt_dp_err(
+							"Passthrough length %u exceeds reserved space %u",
+							passthrough_len, ROC_SE_MAX_AAD_SIZE);
+						return -1;
+					}
+					uint64_t meta_passthrough =
+						(uint64_t)params->meta_buf.vaddr +
+						params->meta_buf.size - ROC_SE_MAX_AAD_SIZE;
+					i = fill_sg2_comp(scatter_comp, i, meta_passthrough,
+							  passthrough_len);
+					size -= passthrough_len;
+					dst_offset = passthrough_len;
+					aad_offset = 0;
+				}
+				if (size)
+					i = fill_sg2_comp_from_iov(scatter_comp, i, params->dst_iov,
+								   dst_offset, &size, aad_buf,
+								   aad_offset);
 			}
 
 			if (unlikely(size)) {
-- 
2.43.0

