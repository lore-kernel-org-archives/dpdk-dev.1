Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BF97CCD184
	for <dpdk-dev@archiver.kernel.org>; Tue, 21 Oct 2025 17:54:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0CF7F40ED2;
	Tue, 21 Oct 2025 19:53:06 +0200 (CEST)
Received: from mail-io1-f98.google.com (mail-io1-f98.google.com
 [209.85.166.98]) by mails.dpdk.org (Postfix) with ESMTP id 23FB8410EE
 for <dev@dpdk.org>; Tue, 21 Oct 2025 19:53:01 +0200 (CEST)
Received: by mail-io1-f98.google.com with SMTP id
 ca18e2360f4ac-940d25b807bso152956639f.1
 for <dev@dpdk.org>; Tue, 21 Oct 2025 10:53:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761069180; x=1761673980;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PHjvvpHYx5Ftfh2AvSqM0ChA3PUyEyIfBV//D7wQ4mI=;
 b=c/A738Kt+nfWNZelMELr6+DY5PYvGdvtrUJUI6fLFwEuhqcOj2rEknRAutUd5iWzUO
 MVmsC/JJVLA/3ZQCF3RCEhS6wscI98alB7FlqVhqdc1qdFacwhyKrJVytoeI8bCBiKdk
 pLJLCq57rxY2QTU8hpk79OhpNR3sH+a3G4MSPfR+3DyXeeyRKC6Ce5Za2B67N2eDPjnu
 9iLppsVlkQhqO582lAhqWB9dKrahXLYaQpkezFeKyXu9C9XsD2/mKOYXlkiQ85+fxsjF
 JMC6I8IeICZ63sDfa8vQ2fozjhTw180WZ/JWaFyYNghqcjVoVu4eiOTS9yHL2TGKXNuu
 jRtg==
X-Gm-Message-State: AOJu0Yx/WPJZq10Y57+2W49DdZrOmv2lSCxVTNvBTaxXQ1alu8a8ln73
 /ik3mwFgcXeLgyBjfZw8XGlrQo7qgnnV11k5wV9kvqFhoxkmG1Thato+kJLuCnrcZKJfTkzmzY+
 iBzPEZLtDNCJcuANKK+Zju8c+OrrcKQIPLjLJml8/bbpy9BRUULHUsMi7w0dTl0JjvR6yj2hYgL
 vx1FRzLSXyR+AwHTuR7ZqR6uYsbBWGlxOpdag55I/kf9HpctKowkWa0JM4asD6kzes4bEB5w==
X-Gm-Gg: ASbGncvpmbPJxdAhJ/KuEIgZcA2YMYfxrsM9qwf7UpoIGCgikD3UR/kF39utgy5LK3L
 nMiGtiJFH7GLAXFdRhMYoIGYD+qXki0D3B7HWWmcIOLwA27/Z3B0jPS4D4z76hNfmG8U0UBdE+M
 5rG3GrjI+kpUzhZzCgtS/g9ZfB5t3vP8zrHWC2cCY3sA9kZVseO4mVNtZioGvjrjugXkReo02yR
 sMsFbiPAoEnZTL3CIj/2oCRNahjebKf75zXQjqrO/aewHE1oTUyFpxM6wvR3eRwPxUOcrgeF63Q
 yh4xMC6R2sJJV/Y8ffv6GXJQhKEzZAnOMSXoMM3etUGs6028nR7B9P7Swgst3hIYfzh7Byavq16
 Dt6UIsvyZzJMOouH5Dp39QFJE9+rY5yehokhkf6NRlobi1uHwgCFQLDoh3hoE6YQFqgr6BNbRvd
 CvouLDCADe6twWepKCTUoIaf+FCjkveAKw6A==
X-Google-Smtp-Source: AGHT+IEHqAXo94l+D1GXXjQcYOT2cKxcsYFpaazON09Z78nXfbsj9tU9wob6Kdi5QjBbWQBzZZ8EKnKZwmVG
X-Received: by 2002:a05:6e02:440a:20b0:430:c534:e189 with SMTP id
 e9e14a558f8ab-430c534e1c6mr218352925ab.28.1761069180219; 
 Tue, 21 Oct 2025 10:53:00 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-19.dlp.protect.broadcom.com. [144.49.247.19])
 by smtp-relay.gmail.com with ESMTPS id
 8926c6da1cb9f-5a8a9797ed3sm1264997173.40.2025.10.21.10.52.59
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 21 Oct 2025 10:53:00 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-b5516e33800so8557804a12.0
 for <dev@dpdk.org>; Tue, 21 Oct 2025 10:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1761069178; x=1761673978; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PHjvvpHYx5Ftfh2AvSqM0ChA3PUyEyIfBV//D7wQ4mI=;
 b=EXL6/zSVq6J36uXUxSxZtYoPNtDvkI3Ks4LlOKOlYb8HcXGtUGw/PTfcfz49YRf4Pr
 Dr+CwYPoD4QruICPVokYjQjvbVfYly4977CpTcx6m+H0tdQrIU3bJowuWRNB5ipKar68
 TGOJST6pNzgqbQDoT2LJp5y/JCmEh3O2jAZf0=
X-Received: by 2002:a17:902:e889:b0:274:746c:b09 with SMTP id
 d9443c01a7336-290cba491admr226724415ad.55.1761069178411; 
 Tue, 21 Oct 2025 10:52:58 -0700 (PDT)
X-Received: by 2002:a17:902:e889:b0:274:746c:b09 with SMTP id
 d9443c01a7336-290cba491admr226724155ad.55.1761069177689; 
 Tue, 21 Oct 2025 10:52:57 -0700 (PDT)
Received: from KX3WTC9T54.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-292472193c2sm115441495ad.104.2025.10.21.10.52.56
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 21 Oct 2025 10:52:57 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com,
 Kishore Padmanabha <kishore.padmanabha@broadcom.com>,
 Shuanglin Wang <shuanglin.wang@broadcom.com>
Subject: [PATCH v4 26/57] net/bnxt/tf_ulp: enable support for global index
 table
Date: Tue, 21 Oct 2025 13:50:18 -0400
Message-Id: <20251021175049.46092-27-manish.kurup@broadcom.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20251021175049.46092-1-manish.kurup@broadcom.com>
References: <20251015090024.32250-1-manish.kurup@broadcom.com>
 <20251021175049.46092-1-manish.kurup@broadcom.com>
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

From: Kishore Padmanabha <kishore.padmanabha@broadcom.com>

The multi instance applications use metadata profile tables to set the
metadata mask and this mask needs to be shared by multiple applications.
The code is extended to support global id for these metadata profiles
that these can be shared across applications. Since there are limited
number of these resources, to scale the number of applications this
resource needs to be shared as global ids.

Signed-off-by: Kishore Padmanabha <kishore.padmanabha@broadcom.com>
Reviewed-by: Shuanglin Wang <shuanglin.wang@broadcom.com>
---
 drivers/net/bnxt/tf_ulp/ulp_mapper.c     | 111 +++++++++++++++++++++++
 drivers/net/bnxt/tf_ulp/ulp_mapper.h     |  11 +++
 drivers/net/bnxt/tf_ulp/ulp_mapper_tf.c  |   2 +
 drivers/net/bnxt/tf_ulp/ulp_mapper_tfc.c |  77 ++++++++++++++++
 4 files changed, 201 insertions(+)

diff --git a/drivers/net/bnxt/tf_ulp/ulp_mapper.c b/drivers/net/bnxt/tf_ulp/ulp_mapper.c
index 1901845499..9cda3b355b 100644
--- a/drivers/net/bnxt/tf_ulp/ulp_mapper.c
+++ b/drivers/net/bnxt/tf_ulp/ulp_mapper.c
@@ -3129,6 +3129,110 @@ ulp_mapper_global_identifier_process(struct bnxt_ulp_mapper_parms *parms,
 	return rc;
 }
 
+static int32_t
+ulp_mapper_global_idx_tbl_process(struct bnxt_ulp_mapper_parms *parms,
+				  struct bnxt_ulp_mapper_tbl_info *tbl)
+{
+	const struct ulp_mapper_core_ops *op = parms->mapper_data->mapper_oper;
+	struct bnxt_ulp_glb_resource_info glb_res = { 0 };
+	struct ulp_flow_db_res_params fid_parms = { 0 };
+	struct bnxt_ulp_mapper_key_info	*kflds;
+	struct ulp_blob key;
+	uint32_t num_kflds = 0;
+	uint16_t tmplen = 0;
+	uint64_t idx = 0;
+	uint8_t *context;
+	int32_t rc = 0;
+	uint32_t i;
+
+	/* check the table opcode  */
+	if (tbl->tbl_opcode != BNXT_ULP_GLOBAL_IDX_TBL_OPC_ALLOC) {
+		BNXT_DRV_DBG(ERR, "Invalid global idx table opcode %d",
+			     tbl->tbl_opcode);
+		return -EINVAL;
+	}
+
+	/* Create the key blob */
+	if (unlikely(ulp_blob_init(&key, tbl->blob_key_bit_size,
+				   BNXT_ULP_BYTE_ORDER_BE))) {
+		BNXT_DRV_DBG(ERR, "blob init failed.");
+		return -EINVAL;
+	}
+
+	kflds = ulp_mapper_key_fields_get(parms, tbl, &num_kflds);
+	for (i = 0; i < num_kflds; i++) {
+		rc = ulp_mapper_field_opc_process(parms, tbl->direction,
+						  &kflds[i].field_info_spec,
+						  &key, 1,
+						  "Global Idx Context");
+		if (unlikely(rc)) {
+			BNXT_DRV_DBG(ERR, "Key field set failed %s",
+				     kflds[i].field_info_spec.description);
+			return rc;
+		}
+	}
+
+	context = ulp_blob_data_get(&key, &tmplen);
+	tmplen = ULP_BITS_2_BYTE(tmplen);
+
+	if (unlikely(!op->ulp_mapper_core_glb_idx_tbl_alloc)) {
+		BNXT_DRV_DBG(ERR, "global idx tbl process not supported");
+		return -EINVAL;
+	}
+
+	rc = op->ulp_mapper_core_glb_idx_tbl_alloc(parms->ulp_ctx,
+						   tbl->resource_type,
+						   tbl->direction, context,
+						   tmplen, &idx);
+	if (unlikely(rc)) {
+		BNXT_DRV_DBG(ERR, "global idx tbl process failed");
+		return rc;
+	}
+
+	/* Add the table index to the flow db */
+	memset(&fid_parms, 0, sizeof(fid_parms));
+	fid_parms.direction = tbl->direction;
+	fid_parms.resource_func = tbl->resource_func;
+	fid_parms.resource_type	= tbl->resource_type;
+	fid_parms.critical_resource = tbl->critical_resource;
+	fid_parms.resource_hndl = idx;
+
+	rc = ulp_mapper_fdb_opc_process(parms, tbl, &fid_parms);
+	if (unlikely(rc)) {
+		BNXT_DRV_DBG(ERR, "Fail to link res to flow rc = %d", rc);
+		goto error;
+	}
+
+	rc = bnxt_ulp_cntxt_dev_id_get(parms->ulp_ctx, &glb_res.device_id);
+	if (unlikely(rc)) {
+		BNXT_DRV_DBG(ERR, "Failed to get device id (%d)", rc);
+		goto error;
+	}
+
+	rc = bnxt_ulp_cntxt_app_id_get(parms->ulp_ctx, &glb_res.app_id);
+	if (unlikely(rc)) {
+		BNXT_DRV_DBG(ERR, "Failed to get app id (%d)", rc);
+		goto error;
+	}
+
+	glb_res.direction = tbl->direction;
+	glb_res.resource_func = tbl->resource_func;
+	glb_res.resource_type = tbl->resource_type;
+	glb_res.glb_regfile_index = tbl->tbl_operand;
+	/* Write the table index into the regfile*/
+	if (ulp_mapper_glb_resource_write(parms->mapper_data, &glb_res,
+					  tfp_cpu_to_be_64(idx), false)) {
+		BNXT_DRV_DBG(ERR, "Glb Regfile[%d] write failed.",
+			     tbl->tbl_operand);
+		rc = -EINVAL;
+		goto error;
+	}
+	return rc;
+error:
+	(void)op->ulp_mapper_core_glb_idx_tbl_free(parms->ulp_ctx, &fid_parms);
+	return rc;
+}
+
 /* Free the vnic resource */
 static int32_t
 ulp_mapper_vnic_tbl_res_free(struct bnxt_ulp_context *ulp __rte_unused,
@@ -4357,6 +4461,9 @@ ulp_mapper_tbls_process(struct bnxt_ulp_mapper_parms *parms, void *error)
 		case BNXT_ULP_RESOURCE_FUNC_GLOBAL_IDENTIFIER:
 			rc = ulp_mapper_global_identifier_process(parms, tbl);
 			break;
+		case BNXT_ULP_RESOURCE_FUNC_GLOBAL_IDX_TBL:
+			rc = ulp_mapper_global_idx_tbl_process(parms, tbl);
+			break;
 		default:
 			BNXT_DRV_DBG(ERR, "Unexpected mapper resource %d\n",
 				     tbl->resource_func);
@@ -4501,6 +4608,10 @@ ulp_mapper_resource_free(struct bnxt_ulp_context *ulp,
 		break;
 	case BNXT_ULP_RESOURCE_FUNC_GLOBAL_IDENTIFIER:
 		rc = mapper_op->ulp_mapper_core_global_ident_free(ulp, res);
+		break;
+	case BNXT_ULP_RESOURCE_FUNC_GLOBAL_IDX_TBL:
+		rc = mapper_op->ulp_mapper_core_glb_idx_tbl_free(ulp, res);
+		break;
 	default:
 		break;
 	}
diff --git a/drivers/net/bnxt/tf_ulp/ulp_mapper.h b/drivers/net/bnxt/tf_ulp/ulp_mapper.h
index a4a42ab84d..732f095f01 100644
--- a/drivers/net/bnxt/tf_ulp/ulp_mapper.h
+++ b/drivers/net/bnxt/tf_ulp/ulp_mapper.h
@@ -166,6 +166,17 @@ struct ulp_mapper_core_ops {
 	(*ulp_mapper_core_global_ident_free)(struct bnxt_ulp_context *ulp_ctx,
 					     struct ulp_flow_db_res_params *r);
 
+	int32_t
+	(*ulp_mapper_core_glb_idx_tbl_alloc)(struct bnxt_ulp_context *ctx,
+					     uint16_t sub_type,
+					     uint8_t direction,
+					     uint8_t *context_id,
+					     uint16_t context_len,
+					     uint64_t *idx_id);
+
+	int32_t
+	(*ulp_mapper_core_glb_idx_tbl_free)(struct bnxt_ulp_context *ulp_ctx,
+					    struct ulp_flow_db_res_params *r);
 	uint32_t
 	(*ulp_mapper_core_dyn_tbl_type_get)(struct bnxt_ulp_mapper_parms *parms,
 					    struct bnxt_ulp_mapper_tbl_info *t,
diff --git a/drivers/net/bnxt/tf_ulp/ulp_mapper_tf.c b/drivers/net/bnxt/tf_ulp/ulp_mapper_tf.c
index 72d0f96573..3960be4e48 100644
--- a/drivers/net/bnxt/tf_ulp/ulp_mapper_tf.c
+++ b/drivers/net/bnxt/tf_ulp/ulp_mapper_tf.c
@@ -1380,6 +1380,8 @@ const struct ulp_mapper_core_ops ulp_mapper_tf_core_ops = {
 	.ulp_mapper_core_ident_free = ulp_mapper_tf_ident_free,
 	.ulp_mapper_core_global_ident_alloc = NULL,
 	.ulp_mapper_core_global_ident_free = NULL,
+	.ulp_mapper_core_glb_idx_tbl_alloc = NULL,
+	.ulp_mapper_core_glb_idx_tbl_free = NULL,
 	.ulp_mapper_core_dyn_tbl_type_get = ulp_mapper_tf_dyn_tbl_type_get,
 	.ulp_mapper_core_index_tbl_alloc_process =
 		ulp_mapper_tf_index_tbl_alloc_process,
diff --git a/drivers/net/bnxt/tf_ulp/ulp_mapper_tfc.c b/drivers/net/bnxt/tf_ulp/ulp_mapper_tfc.c
index 20b1ac09fc..0f967b838d 100644
--- a/drivers/net/bnxt/tf_ulp/ulp_mapper_tfc.c
+++ b/drivers/net/bnxt/tf_ulp/ulp_mapper_tfc.c
@@ -1911,6 +1911,81 @@ ulp_mapper_tfc_mtr_stats_hndl_del(uint32_t mtr_id)
 		}
 
 	return rc;
+}
+
+static int32_t
+ulp_mapper_tfc_glb_idx_tbl_alloc(struct bnxt_ulp_context *ulp_ctx,
+				 uint16_t sub_type, uint8_t direction,
+				 uint8_t *context_id, uint16_t context_len,
+				 uint64_t *idx_id)
+{
+	struct tfc *tfcp = NULL;
+	struct tfc_global_id_req glb_req = { 0 };
+	struct tfc_global_id glb_rsp = { 0 };
+	uint16_t fw_fid = 0;
+	int32_t rc = 0;
+	bool first = false;
+
+	if (unlikely(bnxt_ulp_cntxt_fid_get(ulp_ctx, &fw_fid))) {
+		BNXT_DRV_DBG(ERR, "Failed to get func_id");
+		return -EINVAL;
+	}
+
+	tfcp = bnxt_ulp_cntxt_tfcp_get(ulp_ctx);
+	if (unlikely(tfcp == NULL)) {
+		BNXT_DRV_DBG(ERR, "Failed to get tfcp pointer");
+		return -EINVAL;
+	}
+
+	glb_req.rtype = CFA_RTYPE_IDX_TBL;
+	glb_req.dir = direction;
+	glb_req.rsubtype = sub_type;
+	glb_req.context_len = context_len;
+	glb_req.context_id = context_id;
+
+	rc = tfc_global_id_alloc(tfcp, fw_fid, &glb_req, &glb_rsp, &first);
+	if (unlikely(rc != 0)) {
+		BNXT_DRV_DBG(ERR, "alloc failed %d", rc);
+		return rc;
+	}
+	*idx_id = glb_rsp.id;
+
+	return rc;
+}
+
+static int32_t
+ulp_mapper_tfc_glb_idx_tbl_free(struct bnxt_ulp_context *ulp_ctx,
+				struct ulp_flow_db_res_params *res)
+{
+	struct tfc_global_id_req glb_req = { 0 };
+	struct tfc *tfcp = NULL;
+	int32_t rc = 0;
+	uint16_t fw_fid = 0;
+
+	if (unlikely(bnxt_ulp_cntxt_fid_get(ulp_ctx, &fw_fid))) {
+		BNXT_DRV_DBG(ERR, "Failed to get func_id");
+		return -EINVAL;
+	}
+
+	tfcp = bnxt_ulp_cntxt_tfcp_get(ulp_ctx);
+	if (unlikely(tfcp == NULL)) {
+		BNXT_DRV_DBG(ERR, "Failed to get tfcp pointer");
+		return -EINVAL;
+	}
+
+	glb_req.rtype = CFA_RTYPE_IDX_TBL;
+	glb_req.dir = (enum cfa_dir)res->direction;
+	glb_req.rsubtype = res->resource_type;
+	glb_req.resource_id = (uint16_t)res->resource_hndl;
+
+	rc = tfc_global_id_free(tfcp, fw_fid, &glb_req);
+	if (unlikely(rc != 0)) {
+		BNXT_DRV_DBG(ERR, "free failed %d", rc);
+		return rc;
+	}
+
+	return rc;
+}
 
 static inline int32_t
 ulp_mapper_tfc_tcam_prio_update(struct bnxt_ulp_mapper_parms *parms,
@@ -1963,6 +2038,8 @@ const struct ulp_mapper_core_ops ulp_mapper_tfc_core_ops = {
 	.ulp_mapper_core_ident_free = ulp_mapper_tfc_ident_free,
 	.ulp_mapper_core_global_ident_alloc = ulp_mapper_tfc_global_ident_alloc,
 	.ulp_mapper_core_global_ident_free = ulp_mapper_tfc_global_ident_free,
+	.ulp_mapper_core_glb_idx_tbl_alloc = ulp_mapper_tfc_glb_idx_tbl_alloc,
+	.ulp_mapper_core_glb_idx_tbl_free = ulp_mapper_tfc_glb_idx_tbl_free,
 	.ulp_mapper_core_dyn_tbl_type_get = ulp_mapper_tfc_dyn_tbl_type_get,
 	.ulp_mapper_core_index_tbl_alloc_process =
 		ulp_mapper_tfc_index_tbl_alloc_process,
-- 
2.39.5 (Apple Git-154)

