Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74BCECCD193
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Oct 2025 09:01:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B80AC40DC9;
	Wed, 15 Oct 2025 11:01:22 +0200 (CEST)
Received: from mail-io1-f99.google.com (mail-io1-f99.google.com
 [209.85.166.99]) by mails.dpdk.org (Postfix) with ESMTP id 2832740C35
 for <dev@dpdk.org>; Wed, 15 Oct 2025 11:01:21 +0200 (CEST)
Received: by mail-io1-f99.google.com with SMTP id
 ca18e2360f4ac-930a6c601b3so613312439f.3
 for <dev@dpdk.org>; Wed, 15 Oct 2025 02:01:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760518880; x=1761123680;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XR80NAAp81LcFYSWQ60clg3AbHriMDJnZXM5rypO5V0=;
 b=PpokGRPdFix4os7UwiFvwnNejWEttpD/LCOuk+xuu6smUH2l8b4269RPxw42xnXIzY
 vx/zbXhmsOl71l+pym4vq82Vd2Yc95c2VZVYTNOhXlylpHldIyW2Cw/Emi8PdxwzdQua
 tvx8drxfP1Jx9hD0ujqG4A2aFqCOFUic42D2REbBIu3psfqfPoaZYjIOZNZa7gLXpyC/
 ryDq7fQTr30VubvZgjItJEOA/xx1pi0zk6HvSdbzUF0JXh8eFu81Zgpx//PtVqq9sgil
 v++GewCE3REkkk3mSUymukk1Vo1yHAiIupOhKanubzQZMgGUrCs/8ipQWJUckJ1z3D2t
 dyBA==
X-Gm-Message-State: AOJu0YyE770//LHXjnT8xvueJHzzxKsQ0l2c9BX7WrMHBIN3ayc8LckT
 I13QH40RgxVepPM9GOdp0GXpNidezGXw6V3kCld11sTcE9vuxrIwQdQI6/0IZEtiuUlxhKNiwEw
 p34zoKNI82hkatTuI/mVLsgcbgWfgrpIT6tKEHq3hyOMdp0meRXpP/Xwxhy9N4DI2NO0ITqVNfh
 8fTqbRgvuTnmFmM+uBxgth3UqqRUk2NDty2f9oHv7CY5dAYpfCmCxYHycNyfsByAUTrOP2fw==
X-Gm-Gg: ASbGncttkc5Lc1tFDCAE5uBhxyRfw1q6HTjr/0/8zYrVwpHgHb6PQfJ6AedwTwZdq9T
 fqCOSh/mnXYu511OSLUMrG2ZbfDNmdvbhuMiwXyVLiCgQjUzI5R20H0X2zGKW96YAyvS/do6lhN
 agLn3CiFlZh/w3GxSibBSeFX2HQnbmPGTI3X494y42FIwsZg7+Vmd79zrAc+FD7YGQV8UGlajT9
 2LQSl1bedqPjkXHADdxrPSknj2chSny3sVMe0Jw6VDapJkg3vSYjaV0yW3Qd4V5hGVVhGAnh5mB
 heT74yCRSfCm1ydAPzRX86XuZ0KcoqKhYgdiD65x6mx8R5A4KvHOoc3mspZEEYwMOG+MD6bUbiI
 Waoe8UbdCSRB6Rs8Se+FVscIu+XPgFB4gFKl5pOTuOu0Prm6dFruaYFEQk1Jr0lX3BlIvz4K5
X-Google-Smtp-Source: AGHT+IElZBXqpn1/jx6/w8Zw/r3nnmW8G/JkhMga9pF9cmCXj/LNxY6vbu8wVvH1//rh3acBq3xpzyvyUu1S
X-Received: by 2002:a05:6602:1483:b0:913:48f3:27a3 with SMTP id
 ca18e2360f4ac-93bd1994a84mr3595271239f.14.1760518880385; 
 Wed, 15 Oct 2025 02:01:20 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-1.dlp.protect.broadcom.com. [144.49.247.1])
 by smtp-relay.gmail.com with ESMTPS id
 ca18e2360f4ac-93e25a4c78esm94322939f.11.2025.10.15.02.01.19
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 15 Oct 2025 02:01:20 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-78102ba5966so9807210b3a.2
 for <dev@dpdk.org>; Wed, 15 Oct 2025 02:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1760518877; x=1761123677; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XR80NAAp81LcFYSWQ60clg3AbHriMDJnZXM5rypO5V0=;
 b=Suib4avtu+LE8zoUYYUjviQuX+WQukIPSjae1w/nHZOHbed5NJXSG3ejDhXXVI0muT
 A5t4cYVWld2ls6P25wwxfmKQRk9mpCsvYI65fWQ2rLi0DhT3SPS5tmgaezM6+lUwmc2T
 OMn2d9GK3e5o/Sv15jbcbx9ZIc3do3PfQmI8A=
X-Received: by 2002:a05:6a00:4f86:b0:76b:c9b9:a11b with SMTP id
 d2e1a72fcca58-793851362d8mr28999909b3a.3.1760518876981; 
 Wed, 15 Oct 2025 02:01:16 -0700 (PDT)
X-Received: by 2002:a05:6a00:4f86:b0:76b:c9b9:a11b with SMTP id
 d2e1a72fcca58-793851362d8mr28999853b3a.3.1760518876213; 
 Wed, 15 Oct 2025 02:01:16 -0700 (PDT)
Received: from localhost.localdomain ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7992bc12a8asm17832412b3a.34.2025.10.15.02.01.12
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 15 Oct 2025 02:01:15 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com, Farah Smith <farah.smith@broadcom.com>,
 Jay Ding <jay.ding@broadcom.com>
Subject: [PATCH v3 05/54] net/bnxt/tf_core: dynamic UPAR support for THOR2
Date: Wed, 15 Oct 2025 04:59:35 -0400
Message-Id: <20251015090024.32250-6-manish.kurup@broadcom.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20251015090024.32250-1-manish.kurup@broadcom.com>
References: <20251009221129.28256-1-manish.kurup@broadcom.com>
 <20251015090024.32250-1-manish.kurup@broadcom.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
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

Changes to support Dynamic UPAR APIs on THOR2.
1. TF core changes
2. ULP Mapper changes
3. RTE parser changes
4. Add 128B encap table type string

Signed-off-by: Manish Kurup <manish.kurup@broadcom.com>
Reviewed-by: Farah Smith <farah.smith@broadcom.com>
Reviewed-by: Jay Ding <jay.ding@broadcom.com>
---
 .../bnxt/hcapi/cfa_v3/include/cfa_resources.h |  25 +++-
 drivers/net/bnxt/tf_core/tf_util.c            |   2 +
 drivers/net/bnxt/tf_core/v3/tfc.h             |   1 +
 drivers/net/bnxt/tf_core/v3/tfc_idx_tbl.c     |  51 +++++---
 drivers/net/bnxt/tf_core/v3/tfc_msg.c         | 121 +++++++++++++++++-
 drivers/net/bnxt/tf_core/v3/tfc_msg.h         |  13 +-
 drivers/net/bnxt/tf_core/v3/tfc_util.c        |   2 +
 drivers/net/bnxt/tf_ulp/ulp_mapper_tfc.c      |  29 +++++
 8 files changed, 213 insertions(+), 31 deletions(-)

diff --git a/drivers/net/bnxt/hcapi/cfa_v3/include/cfa_resources.h b/drivers/net/bnxt/hcapi/cfa_v3/include/cfa_resources.h
index 7408859a53..d1d62738d3 100644
--- a/drivers/net/bnxt/hcapi/cfa_v3/include/cfa_resources.h
+++ b/drivers/net/bnxt/hcapi/cfa_v3/include/cfa_resources.h
@@ -94,7 +94,18 @@ enum cfa_resource_subtype_idx_tbl {
 	CFA_RSUBTYPE_IDX_TBL_EM_FKB,       /**< EM FKB table        */
 	CFA_RSUBTYPE_IDX_TBL_WC_FKB,       /**< WC TCAM FKB table   */
 	CFA_RSUBTYPE_IDX_TBL_EM_FKB_MASK,  /**< EM FKB Mask table   */
-	CFA_RSUBTYPE_IDX_TBL_MAX
+	CFA_RSUBTYPE_IDX_TBL_MAX,
+	/*
+	 * Resource subtypes that come after this point are handled "specially"
+	 * by code in the TFC core and firmware layers. This #define loses
+	 * significance after the Mapper TFC layer.
+	 */
+	CFA_RSUBTYPE_IDX_TBL_DYN_UPAR,     /**< Dynamic UPAR table  */
+	/*
+	 * MAX value for custom index tables, i.e. tables that are handled
+	 * specially by firmware or layers below mapper.
+	 */
+	CFA_RSUBTYPE_CUSTOM_IDX_TBL_MAX
 };
 
 /**
@@ -132,6 +143,18 @@ enum cfa_resource_subtype_if_tbl {
 	CFA_RSUBTYPE_IF_TBL_MAX
 };
 
+/**
+ * Resource sub-types for CFA_BLKTYPE_IDX_TBL
+ */
+enum cfa_resource_blktype_idx_tbl {
+	CFA_IDX_TBL_BLKTYPE_CFA = 0,
+	CFA_IDX_TBL_BLKTYPE_RXP,
+	CFA_IDX_TBL_BLKTYPE_RE_GPARSE,
+	CFA_IDX_TBL_BLKTYPE_TE_GPARSE,
+	CFA_IDX_TBL_BLKTYPE_LAST = CFA_IDX_TBL_BLKTYPE_TE_GPARSE,
+	CFA_IDX_TBL_BLKTYPE_MAX
+};
+
 /**
  * Resource sub-types for CFA_RTYPE_CMM
  */
diff --git a/drivers/net/bnxt/tf_core/tf_util.c b/drivers/net/bnxt/tf_core/tf_util.c
index 8ce8238b4a..16aea7204c 100644
--- a/drivers/net/bnxt/tf_core/tf_util.c
+++ b/drivers/net/bnxt/tf_core/tf_util.c
@@ -85,6 +85,8 @@ tf_tbl_type_2_str(enum tf_tbl_type tbl_type)
 		return "Encap 32B";
 	case TF_TBL_TYPE_ACT_ENCAP_64B:
 		return "Encap 64B";
+	case TF_TBL_TYPE_ACT_ENCAP_128B:
+		return "Encap 128B";
 	case TF_TBL_TYPE_ACT_SP_SMAC:
 		return "Source Properties SMAC";
 	case TF_TBL_TYPE_ACT_SP_SMAC_IPV4:
diff --git a/drivers/net/bnxt/tf_core/v3/tfc.h b/drivers/net/bnxt/tf_core/v3/tfc.h
index 4176aa01bd..1c7eb51c8c 100644
--- a/drivers/net/bnxt/tf_core/v3/tfc.h
+++ b/drivers/net/bnxt/tf_core/v3/tfc.h
@@ -372,6 +372,7 @@ struct tfc_idx_tbl_info {
 	enum cfa_resource_subtype_idx_tbl rsubtype; /**< resource subtype */
 	enum cfa_dir dir; /**< direction rx/tx */
 	uint16_t id; /**< alloc/free index */
+	enum cfa_resource_blktype_idx_tbl blktype; /**< block type */
 };
 
 /**
diff --git a/drivers/net/bnxt/tf_core/v3/tfc_idx_tbl.c b/drivers/net/bnxt/tf_core/v3/tfc_idx_tbl.c
index c8d64c5418..3311b9df65 100644
--- a/drivers/net/bnxt/tf_core/v3/tfc_idx_tbl.c
+++ b/drivers/net/bnxt/tf_core/v3/tfc_idx_tbl.c
@@ -15,6 +15,9 @@
 #include "tfc_msg.h"
 #include "tfc_util.h"
 
+#define BLKTYPE_IS_CFA(blktype) \
+		(CFA_IDX_TBL_BLKTYPE_CFA == (blktype))
+
 int tfc_idx_tbl_alloc(struct tfc *tfcp, uint16_t fid,
 		      enum cfa_track_type tt,
 		      struct tfc_idx_tbl_info *tbl_info)
@@ -48,9 +51,10 @@ int tfc_idx_tbl_alloc(struct tfc *tfcp, uint16_t fid,
 		return -EINVAL;
 	}
 
-	if (tbl_info->rsubtype >= CFA_RSUBTYPE_IDX_TBL_MAX) {
-		PMD_DRV_LOG_LINE(ERR, "Invalid idx tbl subtype: %d",
-				 tbl_info->rsubtype);
+	if (BLKTYPE_IS_CFA(tbl_info->blktype) &&
+	    tbl_info->rsubtype >= CFA_RSUBTYPE_IDX_TBL_MAX) {
+		PMD_DRV_LOG_LINE(ERR, "%s: Invalid idx tbl subtype: %d",
+				 __func__, tbl_info->rsubtype);
 		return -EINVAL;
 	}
 
@@ -68,7 +72,8 @@ int tfc_idx_tbl_alloc(struct tfc *tfcp, uint16_t fid,
 	}
 
 	rc = tfc_msg_idx_tbl_alloc(tfcp, fid, sid, tt, tbl_info->dir,
-				   tbl_info->rsubtype, &tbl_info->id);
+				   tbl_info->rsubtype, &tbl_info->id,
+				   tbl_info->blktype);
 	if (rc)
 		PMD_DRV_LOG_LINE(ERR, "hwrm failed: %s:%s %s",
 				 tfc_dir_2_str(tbl_info->dir),
@@ -118,9 +123,10 @@ int tfc_idx_tbl_alloc_set(struct tfc *tfcp, uint16_t fid,
 		return -EINVAL;
 	}
 
-	if (tbl_info->rsubtype >= CFA_RSUBTYPE_IDX_TBL_MAX) {
-		PMD_DRV_LOG_LINE(ERR, "Invalid idx tbl subtype: %d",
-				 tbl_info->rsubtype);
+	if (BLKTYPE_IS_CFA(tbl_info->blktype) &&
+	    tbl_info->rsubtype >= CFA_RSUBTYPE_IDX_TBL_MAX) {
+		PMD_DRV_LOG_LINE(ERR, "%s: Invalid idx tbl subtype: %d",
+				 __func__, tbl_info->rsubtype);
 		return -EINVAL;
 	}
 
@@ -143,7 +149,8 @@ int tfc_idx_tbl_alloc_set(struct tfc *tfcp, uint16_t fid,
 
 	rc = tfc_msg_idx_tbl_alloc_set(tfcp, fid, sid, tt, tbl_info->dir,
 				       tbl_info->rsubtype, data,
-				       data_sz_in_bytes, &tbl_info->id);
+				       data_sz_in_bytes, &tbl_info->id,
+				       tbl_info->blktype);
 	if (rc)
 		PMD_DRV_LOG_LINE(ERR, "hwrm failed: %s:%s %s",
 				 tfc_dir_2_str(tbl_info->dir),
@@ -181,8 +188,9 @@ int tfc_idx_tbl_set(struct tfc *tfcp, uint16_t fid,
 		return -EINVAL;
 	}
 
-	if (tbl_info->rsubtype >= CFA_RSUBTYPE_IDX_TBL_MAX) {
-		PMD_DRV_LOG_LINE(ERR, "Invalid idx tbl subtype: %d",
+	if (BLKTYPE_IS_CFA(tbl_info->blktype) &&
+	    tbl_info->rsubtype >= CFA_RSUBTYPE_IDX_TBL_MAX) {
+		PMD_DRV_LOG_LINE(ERR, "%s: Invalid idx tbl subtype: %d", __func__,
 				 tbl_info->rsubtype);
 		return -EINVAL;
 	}
@@ -202,7 +210,8 @@ int tfc_idx_tbl_set(struct tfc *tfcp, uint16_t fid,
 
 	rc = tfc_msg_idx_tbl_set(tfcp, fid, sid, tbl_info->dir,
 				 tbl_info->rsubtype, tbl_info->id,
-				 data, data_sz_in_bytes);
+				 data, data_sz_in_bytes,
+				 tbl_info->blktype);
 	if (rc)
 		PMD_DRV_LOG_LINE(ERR, "hwrm failed: %s:%s %d %s",
 				 tfc_dir_2_str(tbl_info->dir),
@@ -240,9 +249,10 @@ int tfc_idx_tbl_get(struct tfc *tfcp, uint16_t fid,
 		return -EINVAL;
 	}
 
-	if (tbl_info->rsubtype >= CFA_RSUBTYPE_IDX_TBL_MAX) {
-		PMD_DRV_LOG_LINE(ERR, "Invalid idx tbl subtype: %d",
-				 tbl_info->rsubtype);
+	if (BLKTYPE_IS_CFA(tbl_info->blktype) &&
+	    tbl_info->rsubtype >= CFA_RSUBTYPE_IDX_TBL_MAX) {
+		PMD_DRV_LOG_LINE(ERR, "%s: Invalid idx tbl subtype: %d",
+				 __func__, tbl_info->rsubtype);
 		return -EINVAL;
 	}
 
@@ -261,7 +271,8 @@ int tfc_idx_tbl_get(struct tfc *tfcp, uint16_t fid,
 
 	rc = tfc_msg_idx_tbl_get(tfcp, fid, sid, tbl_info->dir,
 				 tbl_info->rsubtype, tbl_info->id,
-				 data, data_sz_in_bytes);
+				 data, data_sz_in_bytes,
+				 tbl_info->blktype);
 	if (rc)
 		PMD_DRV_LOG_LINE(ERR, "hwrm failed: %s:%s %d %s",
 				 tfc_dir_2_str(tbl_info->dir),
@@ -297,9 +308,10 @@ int tfc_idx_tbl_free(struct tfc *tfcp, uint16_t fid,
 		return -EINVAL;
 	}
 
-	if (tbl_info->rsubtype >= CFA_RSUBTYPE_IDX_TBL_MAX) {
-		PMD_DRV_LOG_LINE(ERR, "Invalid idx tbl subtype: %d",
-				 tbl_info->rsubtype);
+	if (BLKTYPE_IS_CFA(tbl_info->blktype) &&
+	    tbl_info->rsubtype >= CFA_RSUBTYPE_IDX_TBL_MAX) {
+		PMD_DRV_LOG_LINE(ERR, "%s: Invalid idx tbl subtype: %d",
+				 __func__, tbl_info->rsubtype);
 		return -EINVAL;
 	}
 
@@ -317,7 +329,8 @@ int tfc_idx_tbl_free(struct tfc *tfcp, uint16_t fid,
 	}
 
 	rc = tfc_msg_idx_tbl_free(tfcp, fid, sid, tbl_info->dir,
-				  tbl_info->rsubtype, tbl_info->id);
+				  tbl_info->rsubtype, tbl_info->id,
+				  tbl_info->blktype);
 	if (rc)
 		PMD_DRV_LOG_LINE(ERR, "hwrm failed: %s:%s %d %s",
 				 tfc_dir_2_str(tbl_info->dir),
diff --git a/drivers/net/bnxt/tf_core/v3/tfc_msg.c b/drivers/net/bnxt/tf_core/v3/tfc_msg.c
index ef64707233..2ad0b386fa 100644
--- a/drivers/net/bnxt/tf_core/v3/tfc_msg.c
+++ b/drivers/net/bnxt/tf_core/v3/tfc_msg.c
@@ -61,6 +61,79 @@ static int tfc_msg_set_fid(struct bnxt *bp, uint16_t req_fid, uint16_t *msg_fid)
 	return 0;
 }
 
+/*
+ * Lookup table to map TFC local blocktype values to HWRM equivalents. Does
+ * this on a per HWRM command basis.
+ */
+enum tfc_hwrm_idx_tbl_cmds {
+	IDX_TBL_ALLOC,
+	IDX_TBL_ALLOC_SET,
+	IDX_TBL_SET,
+	IDX_TBL_GET,
+	IDX_TBL_FREE,
+	IDX_TBL_LAST = IDX_TBL_FREE,
+	IDX_TBL_MAX
+};
+
+#define CMD_TO_HWRM_BLKT(tfc_cmd, blktype)	\
+		HWRM_TFC_##tfc_cmd##_INPUT_BLKTYPE_BLKTYPE_##blktype
+
+uint8_t cfa_res_to_hwrm_blkt_lkup_tbl[IDX_TBL_MAX][CFA_IDX_TBL_BLKTYPE_MAX] = {
+	[IDX_TBL_ALLOC] = {
+		CMD_TO_HWRM_BLKT(IDX_TBL_ALLOC, CFA),
+		CMD_TO_HWRM_BLKT(IDX_TBL_ALLOC, RXP),
+		CMD_TO_HWRM_BLKT(IDX_TBL_ALLOC, RE_GPARSE),
+		CMD_TO_HWRM_BLKT(IDX_TBL_ALLOC, TE_GPARSE),
+	},
+	[IDX_TBL_ALLOC_SET] = {
+		CMD_TO_HWRM_BLKT(IDX_TBL_ALLOC_SET, CFA),
+		CMD_TO_HWRM_BLKT(IDX_TBL_ALLOC_SET, RXP),
+		CMD_TO_HWRM_BLKT(IDX_TBL_ALLOC_SET, RE_GPARSE),
+		CMD_TO_HWRM_BLKT(IDX_TBL_ALLOC_SET, TE_GPARSE),
+	},
+	[IDX_TBL_SET] = {
+		CMD_TO_HWRM_BLKT(IDX_TBL_SET, CFA),
+		CMD_TO_HWRM_BLKT(IDX_TBL_SET, RXP),
+		CMD_TO_HWRM_BLKT(IDX_TBL_SET, RE_GPARSE),
+		CMD_TO_HWRM_BLKT(IDX_TBL_SET, TE_GPARSE),
+	},
+	[IDX_TBL_GET] = {
+		CMD_TO_HWRM_BLKT(IDX_TBL_GET, CFA),
+		CMD_TO_HWRM_BLKT(IDX_TBL_GET, RXP),
+		CMD_TO_HWRM_BLKT(IDX_TBL_GET, RE_GPARSE),
+		CMD_TO_HWRM_BLKT(IDX_TBL_GET, TE_GPARSE),
+	},
+	[IDX_TBL_FREE] = {
+		CMD_TO_HWRM_BLKT(IDX_TBL_FREE, CFA),
+		CMD_TO_HWRM_BLKT(IDX_TBL_FREE, RXP),
+		CMD_TO_HWRM_BLKT(IDX_TBL_FREE, RE_GPARSE),
+		CMD_TO_HWRM_BLKT(IDX_TBL_FREE, TE_GPARSE),
+	},
+};
+
+/*
+ * Maps TFC local blocktype values to HWRM equivalents. This function is
+ * required as each HWRM idx_tbl msg (alloc, alloc_set, get_set, free) has
+ * their own #defines, even though the values are the same across messages.
+ * Using this macro maps the appropriate TFC block type correctly to its HWRM
+ * msg relative equivalent. Returns an ERROR value if either idxtbl cmd OR
+ * blocktype is invalid.
+ */
+#define HWRM_BLKTYPE_ERR	0xff
+static uint8_t
+cfa_res_to_hwrm_blkt_lkup(enum cfa_resource_blktype_idx_tbl blktype,
+			  enum tfc_hwrm_idx_tbl_cmds idxtbl_cmd)
+{
+	if ((idxtbl_cmd) > IDX_TBL_LAST ||
+	    (blktype) > CFA_IDX_TBL_BLKTYPE_LAST) {
+		PMD_DRV_LOG_LINE(ERR, "%s: Invalid blocktype [%u]",
+				 __func__, (blktype));
+		return -EINVAL;
+	}
+
+	return cfa_res_to_hwrm_blkt_lkup_tbl[idxtbl_cmd][blktype];
+}
+
 /**
  * Allocates a DMA buffer that can be used for message transfer.
  *
@@ -406,7 +479,7 @@ int
 tfc_msg_idx_tbl_alloc(struct tfc *tfcp, uint16_t fid, uint16_t sid,
 		      enum cfa_track_type tt, enum cfa_dir dir,
 		      enum cfa_resource_subtype_idx_tbl subtype,
-		      uint16_t *id)
+		      uint16_t *id, enum cfa_resource_blktype_idx_tbl blktype)
 
 {
 	int rc = 0;
@@ -430,7 +503,13 @@ tfc_msg_idx_tbl_alloc(struct tfc *tfcp, uint16_t fid, uint16_t sid,
 	if (rc)
 		return rc;
 	req.sid = rte_le_to_cpu_16(sid);
-	req.subtype = rte_le_to_cpu_16(subtype);
+	req.subtype = (uint8_t)subtype;
+	req.blktype = cfa_res_to_hwrm_blkt_lkup(blktype, IDX_TBL_ALLOC);
+	if (req.blktype == HWRM_BLKTYPE_ERR) {
+		PMD_DRV_LOG_LINE(ERR, "%s: Invalid blocktype [%u]",
+				 __func__, blktype);
+		return -EINVAL;
+	}
 
 	rc = bnxt_hwrm_tf_message_direct(bp, false, HWRM_TFC_IDX_TBL_ALLOC,
 					 &req, sizeof(req), &resp, sizeof(resp));
@@ -446,7 +525,7 @@ tfc_msg_idx_tbl_alloc_set(struct tfc *tfcp, uint16_t fid, uint16_t sid,
 			  enum cfa_track_type tt, enum cfa_dir dir,
 			  enum cfa_resource_subtype_idx_tbl subtype,
 			  const uint32_t *dev_data, uint8_t data_size,
-			  uint16_t *id)
+			  uint16_t *id, enum cfa_resource_blktype_idx_tbl blktype)
 
 {
 	int rc = 0;
@@ -473,6 +552,13 @@ tfc_msg_idx_tbl_alloc_set(struct tfc *tfcp, uint16_t fid, uint16_t sid,
 		return rc;
 	req.sid = rte_le_to_cpu_16(sid);
 	req.subtype = rte_le_to_cpu_16(subtype);
+	req.blktype = cfa_res_to_hwrm_blkt_lkup(blktype, IDX_TBL_ALLOC_SET);
+	if (req.blktype == HWRM_BLKTYPE_ERR) {
+		PMD_DRV_LOG_LINE(ERR, "%s: Invalid blocktype [%u]",
+				 __func__, blktype);
+		return -EINVAL;
+	}
+
 	req.data_size = rte_le_to_cpu_16(data_size);
 
 	if (req.data_size >= sizeof(req.dev_data)) {
@@ -504,7 +590,8 @@ int
 tfc_msg_idx_tbl_set(struct tfc *tfcp, uint16_t fid,
 		    uint16_t sid, enum cfa_dir dir,
 		    enum cfa_resource_subtype_idx_tbl subtype, uint16_t id,
-		    const uint32_t *dev_data, uint8_t data_size)
+		    const uint32_t *dev_data, uint8_t data_size,
+		    enum cfa_resource_blktype_idx_tbl blktype)
 {
 	int rc = 0;
 	struct bnxt *bp = tfcp->bp;
@@ -526,6 +613,13 @@ tfc_msg_idx_tbl_set(struct tfc *tfcp, uint16_t fid,
 	req.sid = rte_le_to_cpu_16(sid);
 	req.idx_tbl_id = rte_le_to_cpu_16(id);
 	req.subtype = rte_le_to_cpu_16(subtype);
+	req.blktype = cfa_res_to_hwrm_blkt_lkup(blktype, IDX_TBL_SET);
+	if (req.blktype == HWRM_BLKTYPE_ERR) {
+		PMD_DRV_LOG_LINE(ERR, "%s: Invalid blocktype [%u]",
+				 __func__, blktype);
+		return -EINVAL;
+	}
+
 	req.data_size = rte_le_to_cpu_16(data_size);
 	rc = tfc_msg_alloc_dma_buf(&buf, data_size);
 	if (rc)
@@ -555,7 +649,8 @@ int
 tfc_msg_idx_tbl_get(struct tfc *tfcp, uint16_t fid,
 		    uint16_t sid, enum cfa_dir dir,
 		    enum cfa_resource_subtype_idx_tbl subtype, uint16_t id,
-		    uint32_t *dev_data, uint8_t *data_size)
+		    uint32_t *dev_data, uint8_t *data_size,
+		    enum cfa_resource_blktype_idx_tbl blktype)
 {
 	int rc = 0;
 	struct bnxt *bp = tfcp->bp;
@@ -576,6 +671,13 @@ tfc_msg_idx_tbl_get(struct tfc *tfcp, uint16_t fid,
 	req.sid = rte_cpu_to_le_16(sid);
 	req.idx_tbl_id = rte_cpu_to_le_16(id);
 	req.subtype = rte_cpu_to_le_16(subtype);
+	req.blktype = cfa_res_to_hwrm_blkt_lkup(blktype, IDX_TBL_GET);
+	if (req.blktype == HWRM_BLKTYPE_ERR) {
+		PMD_DRV_LOG_LINE(ERR, "%s: Invalid blocktype [%u]",
+				 __func__, blktype);
+		return -EINVAL;
+	}
+
 	req.buffer_size = rte_cpu_to_le_16(*data_size);
 
 	rc = tfc_msg_alloc_dma_buf(&buf, *data_size);
@@ -600,7 +702,8 @@ tfc_msg_idx_tbl_get(struct tfc *tfcp, uint16_t fid,
 int
 tfc_msg_idx_tbl_free(struct tfc *tfcp, uint16_t fid,
 		     uint16_t sid, enum cfa_dir dir,
-		     enum cfa_resource_subtype_idx_tbl subtype, uint16_t id)
+		     enum cfa_resource_subtype_idx_tbl subtype, uint16_t id,
+		     enum cfa_resource_blktype_idx_tbl blktype)
 {
 	struct bnxt *bp = tfcp->bp;
 	struct hwrm_tfc_idx_tbl_free_input req = { 0 };
@@ -620,6 +723,12 @@ tfc_msg_idx_tbl_free(struct tfc *tfcp, uint16_t fid,
 	req.sid = rte_cpu_to_le_16(sid);
 	req.idx_tbl_id = rte_cpu_to_le_16(id);
 	req.subtype = rte_cpu_to_le_16(subtype);
+	req.blktype = cfa_res_to_hwrm_blkt_lkup(blktype, IDX_TBL_FREE);
+	if (req.blktype == HWRM_BLKTYPE_ERR) {
+		PMD_DRV_LOG_LINE(ERR, "%s: Invalid blocktype [%u]",
+				 __func__, blktype);
+		return -EINVAL;
+	}
 
 	return bnxt_hwrm_tf_message_direct(bp, false, HWRM_TFC_IDX_TBL_FREE,
 					   &req, sizeof(req), &resp, sizeof(resp));
diff --git a/drivers/net/bnxt/tf_core/v3/tfc_msg.h b/drivers/net/bnxt/tf_core/v3/tfc_msg.h
index a8dcacc9f0..635c656e8f 100644
--- a/drivers/net/bnxt/tf_core/v3/tfc_msg.h
+++ b/drivers/net/bnxt/tf_core/v3/tfc_msg.h
@@ -46,31 +46,34 @@ int
 tfc_msg_idx_tbl_alloc(struct tfc *tfcp, uint16_t fid, uint16_t sid,
 		      enum cfa_track_type tt, enum cfa_dir dir,
 		      enum cfa_resource_subtype_idx_tbl rsubtype,
-		      uint16_t *id);
+		      uint16_t *id, enum cfa_resource_blktype_idx_tbl blktype);
 
 int
 tfc_msg_idx_tbl_alloc_set(struct tfc *tfcp, uint16_t fid, uint16_t sid,
 			  enum cfa_track_type tt, enum cfa_dir dir,
 			  enum cfa_resource_subtype_idx_tbl subtype,
 			  const uint32_t *dev_data, uint8_t data_size,
-			  uint16_t *id);
+			  uint16_t *id, enum cfa_resource_blktype_idx_tbl blktype);
 
 int
 tfc_msg_idx_tbl_set(struct tfc *tfcp, uint16_t fid,
 		    uint16_t sid, enum cfa_dir dir,
 		    enum cfa_resource_subtype_idx_tbl subtype,
-		    uint16_t id, const uint32_t *dev_data, uint8_t data_size);
+		    uint16_t id, const uint32_t *dev_data,
+		    uint8_t data_size, enum cfa_resource_blktype_idx_tbl blktype);
 
 int
 tfc_msg_idx_tbl_get(struct tfc *tfcp, uint16_t fid,
 		    uint16_t sid, enum cfa_dir dir,
 		    enum cfa_resource_subtype_idx_tbl subtype,
-		    uint16_t id, uint32_t *dev_data, uint8_t *data_size);
+		    uint16_t id, uint32_t *dev_data,
+		    uint8_t *data_size, enum cfa_resource_blktype_idx_tbl blktype);
 
 int
 tfc_msg_idx_tbl_free(struct tfc *tfcp, uint16_t fid,
 		     uint16_t sid, enum cfa_dir dir,
-		     enum cfa_resource_subtype_idx_tbl subtype, uint16_t id);
+		     enum cfa_resource_subtype_idx_tbl subtype,
+		     uint16_t id, enum cfa_resource_blktype_idx_tbl blktype);
 
 int tfc_msg_global_id_alloc(struct tfc *tfcp, uint16_t fid, uint16_t sid,
 			    enum tfc_domain_id domain_id, uint16_t req_cnt,
diff --git a/drivers/net/bnxt/tf_core/v3/tfc_util.c b/drivers/net/bnxt/tf_core/v3/tfc_util.c
index cd784245e5..d3229bd104 100644
--- a/drivers/net/bnxt/tf_core/v3/tfc_util.c
+++ b/drivers/net/bnxt/tf_core/v3/tfc_util.c
@@ -92,6 +92,8 @@ tfc_idx_tbl_2_str(enum cfa_resource_subtype_idx_tbl tbl_stype)
 		return "idx_tbl_range_prof";
 	case CFA_RSUBTYPE_IDX_TBL_RANGE_ENTRY:
 		return "idx_tbl_range_entry";
+	case CFA_RSUBTYPE_IDX_TBL_DYN_UPAR:
+		return "idx_tbl_dyn_upar";
 	default:
 		return "Invalid idx tbl subtype";
 	}
diff --git a/drivers/net/bnxt/tf_ulp/ulp_mapper_tfc.c b/drivers/net/bnxt/tf_ulp/ulp_mapper_tfc.c
index 388ebea7ee..db7aa22c57 100644
--- a/drivers/net/bnxt/tf_ulp/ulp_mapper_tfc.c
+++ b/drivers/net/bnxt/tf_ulp/ulp_mapper_tfc.c
@@ -18,6 +18,15 @@
 #include "tfc_debug.h"
 #endif
 
+#define BNXT_METER_MAX_NUM 1024
+static struct bnxt_mtr_stats_id_map mtr_stats[BNXT_METER_MAX_NUM];
+
+static uint32_t CFA_RESTYPE_TO_BLKT(uint8_t idx_tbl_restype)
+{
+	return (idx_tbl_restype > CFA_RSUBTYPE_IDX_TBL_MAX) ?
+			CFA_IDX_TBL_BLKTYPE_RXP : CFA_IDX_TBL_BLKTYPE_CFA;
+}
+
 /* Internal function to write the tcam entry */
 static int32_t
 ulp_mapper_tfc_tcam_tbl_entry_write(struct bnxt_ulp_mapper_parms *parms,
@@ -857,6 +866,7 @@ ulp_mapper_tfc_index_tbl_process(struct bnxt_ulp_mapper_parms *parms,
 		index = rte_be_to_cpu_64(regval);
 		tbl_info.dir = tbl->direction;
 		tbl_info.rsubtype = tbl->resource_type;
+		tbl_info.blktype = CFA_RESTYPE_TO_BLKT(tbl->resource_type);
 		tbl_info.id = index;
 		/* Nothing has been pushed to blob, so push bit_size */
 		tmplen = ulp_blob_pad_push(&data, bit_size);
@@ -910,6 +920,22 @@ ulp_mapper_tfc_index_tbl_process(struct bnxt_ulp_mapper_parms *parms,
 	if (alloc) {
 		tbl_info.dir = tbl->direction;
 		tbl_info.rsubtype = tbl->resource_type;
+		tbl_info.blktype = CFA_RESTYPE_TO_BLKT(tbl->resource_type);
+		/*
+		 * Read back the operand and pass it into the
+		 * alloc command if its a Dyn UPAR table.
+		 */
+		if (tbl_info.blktype == CFA_IDX_TBL_BLKTYPE_RXP) {
+			if (ulp_regfile_read(parms->regfile,
+					     tbl->tbl_operand, &regval)) {
+				BNXT_DRV_DBG(ERR,
+					     "Failed to get tbl idx from regfile[%d]\n",
+					     tbl->tbl_operand);
+				return -EINVAL;
+			}
+			tbl_info.rsubtype = rte_be_to_cpu_64(regval);
+		}
+
 		rc =  tfc_idx_tbl_alloc(tfcp, fw_fid, tt, &tbl_info);
 		if (unlikely(rc)) {
 			BNXT_DRV_DBG(ERR, "Alloc table[%s][%s] failed rc=%d\n",
@@ -971,6 +997,7 @@ ulp_mapper_tfc_index_tbl_process(struct bnxt_ulp_mapper_parms *parms,
 		data_p = ulp_blob_data_get(&data, &tmplen);
 		tbl_info.dir = tbl->direction;
 		tbl_info.rsubtype = tbl->resource_type;
+		tbl_info.blktype = CFA_RESTYPE_TO_BLKT(tbl->resource_type);
 		tbl_info.id = index;
 		wordlen = ULP_BITS_2_BYTE(tmplen);
 		rc = tfc_idx_tbl_set(tfcp, fw_fid, &tbl_info,
@@ -1021,6 +1048,7 @@ ulp_mapper_tfc_index_tbl_process(struct bnxt_ulp_mapper_parms *parms,
 	 * write to the entry or link the flow
 	 */
 
+	tbl_info.blktype = CFA_RESTYPE_TO_BLKT(tbl->resource_type);
 	if (tfc_idx_tbl_free(tfcp, fw_fid, &tbl_info))
 		BNXT_DRV_DBG(ERR, "Failed to free index entry on failure\n");
 	return rc;
@@ -1050,6 +1078,7 @@ ulp_mapper_tfc_index_entry_free(struct bnxt_ulp_context *ulp_ctx,
 	tbl_info.dir = (enum cfa_dir)res->direction;
 	tbl_info.rsubtype = res->resource_type;
 	tbl_info.id = (uint16_t)res->resource_hndl;
+	tbl_info.blktype = CFA_RESTYPE_TO_BLKT(res->resource_type);
 
 	/* TBD: check to see if the memory needs to be cleaned as well*/
 	rc = tfc_idx_tbl_free(tfcp, fw_fid, &tbl_info);
-- 
2.39.5 (Apple Git-154)

