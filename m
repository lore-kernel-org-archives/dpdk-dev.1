Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBABBCAC5B9
	for <dpdk-dev@archiver.kernel.org>; Tue, 30 Sep 2025 07:08:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 511FF40E28;
	Tue, 30 Sep 2025 09:05:54 +0200 (CEST)
Received: from mail-pl1-f225.google.com (mail-pl1-f225.google.com
 [209.85.214.225])
 by mails.dpdk.org (Postfix) with ESMTP id 14B7E402A2
 for <dev@dpdk.org>; Tue, 30 Sep 2025 02:37:07 +0200 (CEST)
Received: by mail-pl1-f225.google.com with SMTP id
 d9443c01a7336-26e68904f0eso53260965ad.0
 for <dev@dpdk.org>; Mon, 29 Sep 2025 17:37:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759192626; x=1759797426;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PHjvvpHYx5Ftfh2AvSqM0ChA3PUyEyIfBV//D7wQ4mI=;
 b=AFdJ4Il53rcsBoVsTcgToL+YGCBk2H+iQLeyt8UiRvNOKlP++qWVgMeBdkIY1A9R+o
 o8QISAXXpj4LSa0+qOo9VggUV4Lkf2hBukgbreX67nHYrbdN34dcE7uAfWxJu9roYVO7
 TZOu/r9I1L+zCnHsSF6y6APDsNOJJPVTEcjDEvyZrNX4rHO1/F4aq9UF8EGVnCNDibHz
 9+JSOv9Hvb+f8rgNcEWfiLpO8Ulz6GZLiYtO+z5djoL5MdcXu3zXwJ3y2lv1lwSu+qRv
 Kp0GIC6+UhbDsI2Aac6beSMk7D/jNuOhGhTdYZrDxYh3T/ZaNiAiHsqpHBgz+MifY6HJ
 afoQ==
X-Gm-Message-State: AOJu0YyBYO7luIp16jmPZduaJORrhJFJjPewStQprcJDNIrk/zFrF504
 XpTrbnadWIEmT5Hegx1dNSlg+Vc60J1n7CPpv2+w2OIMgdJV/7EqfuiAi89RPcuMJuvE+nmrJKm
 LxQgQkTcSKcZj2W2Ozlk9wb5hi/eKsd9m5FYeYg8PHnqEO6+Cre2JsZ6qmpP0ozEdj/+RQ0cCYb
 vF2kQiPgxQLU1z47uzygt1VJXqp4M2EaHcZIJ5a2hQSdmSgUOG1fm/1+hrkkEj2BlWjaJdWw==
X-Gm-Gg: ASbGnct/JXO68/XyYdITv4Dm6P0N+xwxb+Y840j4N0o4GzicHG3zA7knVr+Dq50raIb
 GbFVadV683GwwIK0WIwGfwXKIwwarfi9na11/zebCu/1T043uj0LHCmafzO+FvjBD05hFeeZ2iM
 V8BZbAeudiAJ2ugNsUqz2m46PqrRORGoAd+eEb99HkJKe7O1ytFWnVrJbNGxwsulI9DgH0MvWUj
 3FmWYXIdvEeNBX+2xWIC+BP9Fk3YMaAKl1vCLcYb4l4qqh/7sZFwlPwk+GJ3Pax5dzIc3py6+Dj
 ODQr14LYWhmtg73MuvIvMCKBv+nlSg1fdKzaGIp96De0LbUirnOmNGtJ96Io/bYqP70Jxx/wM+v
 7CL8Mmbyn0bKTwAQ3UeqYgS2RqTr97YjBIyNf/K9BVnJ+oBtZDds2XLY3AcMqhnDiPzbybl9izA
 chDktOLDY=
X-Google-Smtp-Source: AGHT+IHG4aa4twlJW5iHq2pyN+i7D+3UF/6sT0svnP788Z1KongkUptv4CKJaBcxXGQowc8UnhsV2n0qKuZ2
X-Received: by 2002:a17:902:c403:b0:23f:fa79:15d0 with SMTP id
 d9443c01a7336-27ed4a986e0mr201629765ad.46.1759192626131; 
 Mon, 29 Sep 2025 17:37:06 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-121.dlp.protect.broadcom.com. [144.49.247.121])
 by smtp-relay.gmail.com with ESMTPS id
 d9443c01a7336-27ed680fe8asm10879255ad.57.2025.09.29.17.37.05
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 29 Sep 2025 17:37:06 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-78104c8c8ddso4397993b3a.2
 for <dev@dpdk.org>; Mon, 29 Sep 2025 17:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1759192624; x=1759797424; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PHjvvpHYx5Ftfh2AvSqM0ChA3PUyEyIfBV//D7wQ4mI=;
 b=TCdKE6uelE9Cpnn3USchBmrmHWuFrtk1yavJhbFG6S02vyu9VOH9NcglZYEnBUV11z
 3o4W48KaMCj+5TiGlVG9L+XA60JudFRWBwgAV0l3QsFU7NslMfDGAI58XN1YwPW047I4
 ZY0PVLX6MTuxr0mNZZYmyg+y7gFncy0880+X0=
X-Received: by 2002:a05:6a20:7347:b0:245:4181:e1ff with SMTP id
 adf61e73a8af0-2e7c7ea0e27mr23159539637.14.1759192623549; 
 Mon, 29 Sep 2025 17:37:03 -0700 (PDT)
X-Received: by 2002:a05:6a20:7347:b0:245:4181:e1ff with SMTP id
 adf61e73a8af0-2e7c7ea0e27mr23159509637.14.1759192622875; 
 Mon, 29 Sep 2025 17:37:02 -0700 (PDT)
Received: from KX3WTC9T54.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b57c53bb97dsm12234825a12.9.2025.09.29.17.37.01
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 29 Sep 2025 17:37:02 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com,
 Kishore Padmanabha <kishore.padmanabha@broadcom.com>,
 Shuanglin Wang <shuanglin.wang@broadcom.com>
Subject: [PATCH 23/54] net/bnxt/tf_ulp: enable support for global index table
Date: Mon, 29 Sep 2025 20:35:33 -0400
Message-Id: <20250930003604.87108-24-manish.kurup@broadcom.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250930003604.87108-1-manish.kurup@broadcom.com>
References: <20250930003604.87108-1-manish.kurup@broadcom.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Mailman-Approved-At: Tue, 30 Sep 2025 09:05:07 +0200
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

