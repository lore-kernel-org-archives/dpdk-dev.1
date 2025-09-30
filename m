Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CB74CAC5B8
	for <dpdk-dev@archiver.kernel.org>; Tue, 30 Sep 2025 07:09:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E51CE40A6B;
	Tue, 30 Sep 2025 09:05:59 +0200 (CEST)
Received: from mail-il1-f226.google.com (mail-il1-f226.google.com
 [209.85.166.226])
 by mails.dpdk.org (Postfix) with ESMTP id A009B402A2
 for <dev@dpdk.org>; Tue, 30 Sep 2025 02:37:14 +0200 (CEST)
Received: by mail-il1-f226.google.com with SMTP id
 e9e14a558f8ab-4258bd8c19bso45826135ab.2
 for <dev@dpdk.org>; Mon, 29 Sep 2025 17:37:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759192634; x=1759797434;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8IUhUsuMOakohN0O0TO5V/CAw7Bfo+566vnlAp9JAHs=;
 b=g5m9+RP/2J0l1mDhMMQ5zT8sej6vX6Queg4G9UNg+ClMx6VHe4nIabpky7mQBDuTEX
 K3j0KYhO+B5W0FILwuk3NNH1Wk7ntFFltDxhewF219JzIKpWCovDnryqMhr2ey3cBPDM
 VdsfgpinkHpNxrrTD69DCJ5WV1DhrtcFC4tVG82Ai/l+PBBDwvOYqiheOvpZRodnXSud
 MTt/UzU3ypWXhx4i4cMoGJxkVimw8IeCOj2A+vC+E++R8giLD9Zf8C3gZox7DCY6AWpX
 sqyzb6GM8NgjutyNwXYTJY1+KVlJ1gg7SSta/SepXARQ5QtlEeAY77A1OmxPRjKx/uzg
 yQBg==
X-Gm-Message-State: AOJu0YyXwJrXQ90ve8+3da9aemXB804IXNaRFtPgQWiAv8qG1exAMv9m
 CRirP8z/oHX3An9yFqiZhBn6sgVw9fJQxbVbKGouvxquWRB1cfxTdnTDmQHCmcyitwcMAgpIavH
 Wh29TOO0VCNZrpawtDCzwz6h6p5HN/0R9V9cmDhWILxDdx6DIbVlOsb0PppLDG7G7DSVrWFtn0/
 Nh9EUyDuctl2gP+9+D9RMrAwzyEp+FMQkKL/FKPsnQORRdQOCRQReTmuRSAIcm9PI64g6X+A==
X-Gm-Gg: ASbGncs8izQA1BdjXHIjutk3lWWHTbYtKOrX3I2GhZvhTT4SDTq+J4MgefYH1LLukuc
 94R9M1MG3pSPmMSymt1YXaDIiPId4CmY50DnC7gwEU3PteURX7stwasjnajz+lwVdRqPDvHZucT
 sQ2KnEfFVdE9mKQqprO3grD46WLnafGGgEVW6EgCYLr5RtYG1PW8c7PvKlMx0ZyHhg4YOFMMKSE
 JDnhRwaOcxAP8gXRCCmdKPJLAbwxtKmk0DsSZkwZPD30m/aYuSubU3lVGet6QYY4GjbEUZ8p1XM
 hvmZf9DIBkKwf2rDE6DtgGg5Xj85Zf5YqdpGeR8lI6vXgHSnylJey3z/hcISQ687C1zVS1UVvrj
 vzF7HlzvMkaKpgrx/DprD4JGhUE9lE5aW9QV+CuKNmSOZE72RujgqtLtQQTVJ1hspZA3qdbWCAd
 +HKw==
X-Google-Smtp-Source: AGHT+IE4CU4rd8u0HgXUX8m7vzAT4v2eWrtzZxqL72hMzJTlcfT1xaEQYAmhGx24ZzcaQRUOHwubi532URjP
X-Received: by 2002:a05:6e02:b4f:b0:424:40c:2426 with SMTP id
 e9e14a558f8ab-4259562f632mr265145835ab.16.1759192633890; 
 Mon, 29 Sep 2025 17:37:13 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-116.dlp.protect.broadcom.com. [144.49.247.116])
 by smtp-relay.gmail.com with ESMTPS id
 e9e14a558f8ab-425bf6d4f6fsm9519545ab.26.2025.09.29.17.37.12
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 29 Sep 2025 17:37:13 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-7810912fc31so4501459b3a.3
 for <dev@dpdk.org>; Mon, 29 Sep 2025 17:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1759192631; x=1759797431; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8IUhUsuMOakohN0O0TO5V/CAw7Bfo+566vnlAp9JAHs=;
 b=N5vTz1XYaAbbIH6x1ImS6gTJYVh7PJrUT6bSnKjG64qtfbcX0E7bl4UFWtBKHMxaW8
 WvYPmAg03wWZiWNWHfMJjtTnCc+kAOEqtIcKk71sC2Az6MYvpq8Hz5Glel9WY+NtKdLg
 GB0mvNlqXjCyGPhB4eU907MGRD5ueJa6OGIAc=
X-Received: by 2002:a05:6300:880f:b0:2f5:ba02:a28f with SMTP id
 adf61e73a8af0-2f5ba6d74d5mr17773815637.19.1759192631122; 
 Mon, 29 Sep 2025 17:37:11 -0700 (PDT)
X-Received: by 2002:a05:6300:880f:b0:2f5:ba02:a28f with SMTP id
 adf61e73a8af0-2f5ba6d74d5mr17773782637.19.1759192630499; 
 Mon, 29 Sep 2025 17:37:10 -0700 (PDT)
Received: from KX3WTC9T54.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b57c53bb97dsm12234825a12.9.2025.09.29.17.37.09
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 29 Sep 2025 17:37:10 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com, Shuanglin Wang <shuanglin.wang@broadcom.com>,
 Kishore Padmanabha <kishore.padmanabha@broadcom.com>
Subject: [PATCH 28/54] net/bnxt/tf_ulp: support MPLS packets
Date: Mon, 29 Sep 2025 20:35:38 -0400
Message-Id: <20250930003604.87108-29-manish.kurup@broadcom.com>
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

From: Shuanglin Wang <shuanglin.wang@broadcom.com>

Thor supports offloading MPLS packets and performing drop, forward,
or queue actions for matchied packets.

Signed-off-by: Shuanglin Wang <shuanglin.wang@broadcom.com>
Reviewed-by: Kishore Padmanabha <kishore.padmanabha@broadcom.com>
---
 drivers/net/bnxt/tf_ulp/ulp_rte_handler_tbl.c |   4 +-
 drivers/net/bnxt/tf_ulp/ulp_rte_parser.c      |  52 ++++
 drivers/net/bnxt/tf_ulp/ulp_rte_parser.h      |   5 +
 .../net/bnxt/tf_ulp/ulp_template_db_enum.h    | 239 +++++++++++++++++-
 drivers/net/bnxt/tf_ulp/ulp_template_struct.h |   3 +
 5 files changed, 289 insertions(+), 14 deletions(-)

diff --git a/drivers/net/bnxt/tf_ulp/ulp_rte_handler_tbl.c b/drivers/net/bnxt/tf_ulp/ulp_rte_handler_tbl.c
index 5b9caabe1d..6e1115b985 100644
--- a/drivers/net/bnxt/tf_ulp/ulp_rte_handler_tbl.c
+++ b/drivers/net/bnxt/tf_ulp/ulp_rte_handler_tbl.c
@@ -297,8 +297,8 @@ struct bnxt_ulp_rte_hdr_info ulp_hdr_info[] = {
 	.proto_hdr_func          = NULL
 	},
 	[RTE_FLOW_ITEM_TYPE_MPLS] = {
-	.hdr_type                = BNXT_ULP_HDR_TYPE_NOT_SUPPORTED,
-	.proto_hdr_func          = NULL
+	.hdr_type                = BNXT_ULP_HDR_TYPE_SUPPORTED,
+	.proto_hdr_func          = ulp_rte_mpls_hdr_handler
 	},
 	[RTE_FLOW_ITEM_TYPE_GRE] = {
 	.hdr_type                = BNXT_ULP_HDR_TYPE_SUPPORTED,
diff --git a/drivers/net/bnxt/tf_ulp/ulp_rte_parser.c b/drivers/net/bnxt/tf_ulp/ulp_rte_parser.c
index bf3a3deb18..af7f8b7ab4 100644
--- a/drivers/net/bnxt/tf_ulp/ulp_rte_parser.c
+++ b/drivers/net/bnxt/tf_ulp/ulp_rte_parser.c
@@ -2159,6 +2159,58 @@ ulp_rte_ecpri_hdr_handler(const struct rte_flow_item *item,
 	return BNXT_TF_RC_SUCCESS;
 }
 
+/* Function to handle the parsing of RTE Flow item MPLS Header. */
+int32_t
+ulp_rte_mpls_hdr_handler(const struct rte_flow_item *item,
+			 struct ulp_rte_parser_params *params)
+{
+	const struct rte_flow_item_mpls *mpls_spec = item->spec;
+	const struct rte_flow_item_mpls *mpls_mask = item->mask;
+	struct ulp_rte_hdr_bitmap *hdr_bitmap = &params->hdr_bitmap;
+	uint32_t idx = 0;
+	uint32_t size;
+
+	if (unlikely(ulp_rte_prsr_fld_size_validate(params, &idx,
+						    BNXT_ULP_PROTO_HDR_MPLS_NUM))) {
+		BNXT_DRV_DBG(ERR, "Error parsing protocol header");
+		return BNXT_TF_RC_ERROR;
+	}
+
+	if (mpls_spec && !mpls_mask)
+		mpls_mask = &rte_flow_item_mpls_mask;
+
+	if (mpls_spec) {
+		uint8_t spec_label_tc_s[3] = {0};
+		uint8_t mask_label_tc_s[3] = {0};
+		/* right-shift 4 bits */
+		spec_label_tc_s[0] = mpls_spec->label_tc_s[0] >> 4;
+		spec_label_tc_s[1] = mpls_spec->label_tc_s[0] << 4 | mpls_spec->label_tc_s[1] >> 4;
+		spec_label_tc_s[2] = mpls_spec->label_tc_s[1] << 4 | mpls_spec->label_tc_s[2] >> 4;
+		mask_label_tc_s[0] = mpls_mask->label_tc_s[0] >> 4;
+		mask_label_tc_s[1] = mpls_mask->label_tc_s[0] << 4 | mpls_mask->label_tc_s[1] >> 4;
+		mask_label_tc_s[2] = mpls_mask->label_tc_s[1] << 4 | mpls_mask->label_tc_s[2] >> 4;
+
+		/* Process mpls label field */
+		size = sizeof(((struct rte_flow_item_mpls *)NULL)->label_tc_s);
+		ulp_rte_prsr_fld_mask(params, &idx, size,
+				      spec_label_tc_s,
+				      mask_label_tc_s,
+				      ULP_PRSR_ACT_DEFAULT);
+
+		/* Process mpls ttl field */
+		size = sizeof(((struct rte_flow_item_mpls *)NULL)->ttl);
+		ulp_rte_prsr_fld_mask(params, &idx, size,
+				      ulp_deference_struct(mpls_spec, ttl),
+				      ulp_deference_struct(mpls_mask, ttl),
+				      ULP_PRSR_ACT_DEFAULT);
+	}
+
+	/* Update the hdr_bitmap with MPLS and cf bitmap*/
+	ULP_BITMAP_SET(hdr_bitmap->bits, BNXT_ULP_HDR_BIT_T_MPLS);
+	ULP_BITMAP_SET(params->cf_bitmap, BNXT_ULP_CF_BIT_IS_TUNNEL);
+	return BNXT_TF_RC_SUCCESS;
+}
+
 /* Function to handle the parsing of RTE Flow item void Header */
 int32_t
 ulp_rte_void_hdr_handler(const struct rte_flow_item *item __rte_unused,
diff --git a/drivers/net/bnxt/tf_ulp/ulp_rte_parser.h b/drivers/net/bnxt/tf_ulp/ulp_rte_parser.h
index b20cb1ccde..5f451ba404 100644
--- a/drivers/net/bnxt/tf_ulp/ulp_rte_parser.h
+++ b/drivers/net/bnxt/tf_ulp/ulp_rte_parser.h
@@ -164,6 +164,11 @@ int32_t
 ulp_rte_ecpri_hdr_handler(const struct rte_flow_item *item,
 			  struct ulp_rte_parser_params *params);
 
+/* Function to handle the parsing of RTE Flow item MPLS Header. */
+int32_t
+ulp_rte_mpls_hdr_handler(const struct rte_flow_item *item,
+			 struct ulp_rte_parser_params *params);
+
 /* Function to handle the parsing of RTE Flow item void Header. */
 int32_t
 ulp_rte_void_hdr_handler(const struct rte_flow_item *item,
diff --git a/drivers/net/bnxt/tf_ulp/ulp_template_db_enum.h b/drivers/net/bnxt/tf_ulp/ulp_template_db_enum.h
index 4e7cb570b0..02534d8fe8 100644
--- a/drivers/net/bnxt/tf_ulp/ulp_template_db_enum.h
+++ b/drivers/net/bnxt/tf_ulp/ulp_template_db_enum.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: BSD-3-Clause
- * Copyright(c) 2014-2024 Broadcom
+ * Copyright(c) 2014-2025 Broadcom
  * All rights reserved.
  */
 
@@ -71,7 +71,8 @@ enum bnxt_ulp_cf_bit {
 	BNXT_ULP_CF_BIT_STATIC_VXLAN_IP_PORT = 0x0000000000000800,
 	BNXT_ULP_CF_BIT_DYNAMIC_VXLAN_PORT   = 0x0000000000001000,
 	BNXT_ULP_CF_BIT_DYNAMIC_GENEVE_PORT  = 0x0000000000002000,
-	BNXT_ULP_CF_BIT_LAST                 = 0x0000000000004000
+	BNXT_ULP_CF_BIT_HOT_UP_SECONDARY     = 0x0000000000004000,
+	BNXT_ULP_CF_BIT_LAST                 = 0x0000000000008000
 };
 
 enum bnxt_ulp_dev_ft {
@@ -117,7 +118,8 @@ enum bnxt_ulp_hdr_bit {
 	BNXT_ULP_HDR_BIT_I_L4_FLOW           = 0x0000000200000000,
 	BNXT_ULP_HDR_BIT_NON_GENERIC         = 0x0000000400000000,
 	BNXT_ULP_HDR_BIT_GENERIC             = 0x0000000800000000,
-	BNXT_ULP_HDR_BIT_LAST                = 0x0000001000000000
+	BNXT_ULP_HDR_BIT_T_MPLS              = 0x0000001000000000,
+	BNXT_ULP_HDR_BIT_LAST                = 0x0000002000000000
 };
 
 enum bnxt_ulp_accept_opc {
@@ -386,7 +388,8 @@ enum bnxt_ulp_enc_field {
 	BNXT_ULP_ENC_FIELD_GENEVE_OPT_W3 = 51,
 	BNXT_ULP_ENC_FIELD_GENEVE_OPT_W4 = 52,
 	BNXT_ULP_ENC_FIELD_GENEVE_OPT_W5 = 53,
-	BNXT_ULP_ENC_FIELD_LAST = 54
+	BNXT_ULP_ENC_FIELD_MPLS_LABEL = 54,
+	BNXT_ULP_ENC_FIELD_LAST = 55
 };
 
 enum bnxt_ulp_fdb_opc {
@@ -479,7 +482,10 @@ enum bnxt_ulp_func_opc {
 	BNXT_ULP_FUNC_OPC_COND_LIST = 26,
 	BNXT_ULP_FUNC_OPC_PORT_TABLE = 27,
 	BNXT_ULP_FUNC_OPC_MTR_ID_TO_STATS_HANDLE = 28,
-	BNXT_ULP_FUNC_OPC_LAST = 29
+	BNXT_ULP_FUNC_OPC_APP_PRIORITY = 29,
+	BNXT_ULP_FUNC_OPC_TCAM_SET_PRIORITY = 30,
+	BNXT_ULP_FUNC_OPC_GET_HA_PRIORITY = 31,
+	BNXT_ULP_FUNC_OPC_LAST = 32
 };
 
 enum bnxt_ulp_func_src {
@@ -511,7 +517,8 @@ enum bnxt_ulp_generic_tbl_opc {
 	BNXT_ULP_GENERIC_TBL_OPC_NOT_USED = 0,
 	BNXT_ULP_GENERIC_TBL_OPC_READ = 1,
 	BNXT_ULP_GENERIC_TBL_OPC_WRITE = 2,
-	BNXT_ULP_GENERIC_TBL_OPC_LAST = 3
+	BNXT_ULP_GENERIC_TBL_OPC_ITERATE = 3,
+	BNXT_ULP_GENERIC_TBL_OPC_LAST = 4
 };
 
 enum bnxt_ulp_glb_rf_idx {
@@ -616,6 +623,18 @@ enum bnxt_ulp_glb_rf_idx {
 	BNXT_ULP_GLB_RF_IDX_LAST = 98
 };
 
+enum bnxt_ulp_global_identifier_tbl_opc {
+	BNXT_ULP_GLOBAL_IDENTIFIER_TBL_OPC_NOP = 0,
+	BNXT_ULP_GLOBAL_IDENTIFIER_TBL_OPC_ALLOC = 1,
+	BNXT_ULP_GLOBAL_IDENTIFIER_TBL_OPC_LAST = 2
+};
+
+enum bnxt_ulp_global_idx_tbl_opc {
+	BNXT_ULP_GLOBAL_IDX_TBL_OPC_NOP = 0,
+	BNXT_ULP_GLOBAL_IDX_TBL_OPC_ALLOC = 1,
+	BNXT_ULP_GLOBAL_IDX_TBL_OPC_LAST = 2
+};
+
 enum bnxt_ulp_global_register_tbl_opc {
 	BNXT_ULP_GLOBAL_REGISTER_TBL_OPC_NOT_USED = 0,
 	BNXT_ULP_GLOBAL_REGISTER_TBL_OPC_WR_REGFILE = 1,
@@ -830,7 +849,13 @@ enum bnxt_ulp_rf_idx {
 	BNXT_ULP_RF_IDX_FLOW_CNTR_PTR_MTR = 104,
 	BNXT_ULP_RF_IDX_SW_METER_PTR_0 = 105,
 	BNXT_ULP_RF_IDX_METER_STATS_HNDL_0 = 106,
-	BNXT_ULP_RF_IDX_LAST = 107
+	BNXT_ULP_RF_IDX_DYN_TUN_TYPE = 107,
+	BNXT_ULP_RF_IDX_DYN_UPAR_TUN = 108,
+	BNXT_ULP_RF_IDX_DYN_UPAR_ID = 109,
+	BNXT_ULP_RF_IDX_GENERIC_TBL_INDEX = 110,
+	BNXT_ULP_RF_IDX_APP_PRIO = 111,
+	BNXT_ULP_RF_IDX_HA_PRIO = 112,
+	BNXT_ULP_RF_IDX_LAST = 113
 };
 
 enum bnxt_ulp_stats_cache_tbl_opc {
@@ -883,7 +908,10 @@ enum bnxt_ulp_feature_bit {
 	BNXT_ULP_FEATURE_BIT_PARENT_DMAC = 0x00000001,
 	BNXT_ULP_FEATURE_BIT_PORT_DMAC = 0x00000002,
 	BNXT_ULP_FEATURE_BIT_MULTI_TUNNEL_FLOW = 0x00000004,
-	BNXT_ULP_FEATURE_BIT_SOCKET_DIRECT = 0x00000008
+	BNXT_ULP_FEATURE_BIT_SOCKET_DIRECT = 0x00000008,
+	BNXT_ULP_FEATURE_BIT_MULTI_INSTANCE = 0x00000010,
+	BNXT_ULP_FEATURE_BIT_SPECIAL_VXLAN = 0x00000020,
+	BNXT_ULP_FEATURE_BIT_HOT_UPGRADE = 0x00000040
 };
 
 enum bnxt_ulp_flow_dir_bitmask {
@@ -909,7 +937,9 @@ enum bnxt_ulp_resource_func {
 	BNXT_ULP_RESOURCE_FUNC_GLOBAL_REGISTER_TABLE = 0x8a,
 	BNXT_ULP_RESOURCE_FUNC_KEY_RECIPE_TABLE = 0x8b,
 	BNXT_ULP_RESOURCE_FUNC_ALLOCATOR_TABLE = 0x8c,
-	BNXT_ULP_RESOURCE_FUNC_STATS_CACHE = 0x8d
+	BNXT_ULP_RESOURCE_FUNC_STATS_CACHE = 0x8d,
+	BNXT_ULP_RESOURCE_FUNC_GLOBAL_IDENTIFIER = 0x8e,
+	BNXT_ULP_RESOURCE_FUNC_GLOBAL_IDX_TBL = 0x8f
 };
 
 enum bnxt_ulp_resource_sub_type {
@@ -951,6 +981,8 @@ enum bnxt_ulp_resource_sub_type {
 	BNXT_ULP_RESOURCE_SUB_TYPE_GENERIC_TABLE_PROF_FUNC_CACHE = 28,
 	BNXT_ULP_RESOURCE_SUB_TYPE_GENERIC_TABLE_GROUP_MISS_ACTION_CACHE = 29,
 	BNXT_ULP_RESOURCE_SUB_TYPE_GENERIC_TABLE_SHARED_METER_STATS_CACHE = 30,
+	BNXT_ULP_RESOURCE_SUB_TYPE_GENERIC_TABLE_HOT_UPGRADE_TCAM_CACHE = 31,
+	BNXT_ULP_RESOURCE_SUB_TYPE_GENERIC_TABLE_GLOBAL_REGFILES_CACHE = 32,
 	BNXT_ULP_RESOURCE_SUB_TYPE_ALLOCATOR_TABLE_JUMP_INDEX = 0,
 	BNXT_ULP_RESOURCE_SUB_TYPE_VNIC_TABLE_RSS = 0,
 	BNXT_ULP_RESOURCE_SUB_TYPE_VNIC_TABLE_QUEUE = 1,
@@ -1374,10 +1406,44 @@ enum ulp_wp_sym {
 	ULP_WP_SYM_DECAP_FUNC_THRU_L2 = 11,
 	ULP_WP_SYM_DECAP_FUNC_THRU_L3 = 12,
 	ULP_WP_SYM_DECAP_FUNC_THRU_L4 = 13,
+	ULP_WP_SYM_DECAP_FUNC_THRU_OL2 = 0,
+	ULP_WP_SYM_DECAP_FUNC_THRU_OL3 = 0,
+	ULP_WP_SYM_DECAP_FUNC_THRU_OL4 = 0,
+	ULP_WP_SYM_DECAP_FUNC_THRU_OTUN = 0,
 	ULP_WP_SYM_ECV_VALID_NO = 0,
 	ULP_WP_SYM_ECV_VALID_YES = 1,
 	ULP_WP_SYM_ECV_CUSTOM_EN_NO = 0,
 	ULP_WP_SYM_ECV_CUSTOM_EN_YES = 1,
+	ULP_WP_SYM_ECV_CUSTOM_IPV4_CTRL_ENCREC = 0,
+	ULP_WP_SYM_ECV_CUSTOM_IPV4_CTRL_RSVD = 0,
+	ULP_WP_SYM_ECV_CUSTOM_IPV4_CTRL_INHERIT = 0,
+	ULP_WP_SYM_ECV_CUSTOM_IPV4_CTRL_INCREMENT = 0,
+	ULP_WP_SYM_ECV_SMAC_OVR_USE_SPSMAC = 0,
+	ULP_WP_SYM_ECV_SMAC_OVR_REUSE_IN_L2 = 0,
+	ULP_WP_SYM_ECV_SMAC_OVR_REUSE_TUN_L2 = 0,
+	ULP_WP_SYM_ECV_SMAC_OVR_USE_OUT_L2 = 0,
+	ULP_WP_SYM_ECV_SMAC_OVR_RFU = 0,
+	ULP_WP_SYM_ECV_SMAC_OVR_REUSE_IN_L2_DMAC = 0,
+	ULP_WP_SYM_ECV_SMAC_OVR_REUSE_TUN_L2_DMAC = 0,
+	ULP_WP_SYM_ECV_SMAC_OVR_REUSE_OUT_L2_DMAC = 0,
+	ULP_WP_SYM_ECV_VLAN_OVR_USE_ENCREC_VLANS = 0,
+	ULP_WP_SYM_ECV_VLAN_OVR_USE_IN_L2_VLANS = 0,
+	ULP_WP_SYM_ECV_VLAN_OVR_USE_TUN_L2_VLANS = 0,
+	ULP_WP_SYM_ECV_VLAN_OVR_USE_OUT_L2_VLANS = 0,
+	ULP_WP_SYM_ECV_VLAN_OVR_USE_IN_VLAN_IN_L2 = 0,
+	ULP_WP_SYM_ECV_VLAN_OVR_USE_OUT_VLAN_IN_L2 = 0,
+	ULP_WP_SYM_ECV_VLAN_OVR_USE_IN_VLAN_OUT_L2 = 0,
+	ULP_WP_SYM_ECV_VLAN_OVR_USE_OUT_VLAN_OUT_L2 = 0,
+	ULP_WP_SYM_ECV_VLAN_OVR_USE_ENCREC_DMAC = 0,
+	ULP_WP_SYM_ECV_VLAN_OVR_USE_IN_L2_DMAC = 0,
+	ULP_WP_SYM_ECV_VLAN_OVR_USE_IN_TUN_DMAC = 0,
+	ULP_WP_SYM_ECV_VLAN_OVR_USE_OUT_L2_DMAC = 0,
+	ULP_WP_SYM_ECV_GRE_SET_K_INCLUDE_OPTIONAL = 0,
+	ULP_WP_SYM_ECV_GRE_SET_K_NONE = 0,
+	ULP_WP_SYM_ECV_IP_TOS_IN_HDR = 0,
+	ULP_WP_SYM_ECV_IP_TOS_ENCREC = 0,
+	ULP_WP_SYM_ECV_IP_TTL_IN_HDR = 0,
+	ULP_WP_SYM_ECV_IP_TTL_ENCREC = 0,
 	ULP_WP_SYM_ECV_L2_EN_NO = 0,
 	ULP_WP_SYM_ECV_L2_EN_YES = 1,
 	ULP_WP_SYM_ECV_VTAG_TYPE_NOP = 0,
@@ -1412,6 +1478,8 @@ enum ulp_wp_sym {
 	ULP_WP_SYM_ECV_TUN_TYPE_NGE = 3,
 	ULP_WP_SYM_ECV_TUN_TYPE_NVGRE = 4,
 	ULP_WP_SYM_ECV_TUN_TYPE_GRE = 5,
+	ULP_WP_SYM_ECV_TUN_TYPE_GA_L4 = 0,
+	ULP_WP_SYM_ECV_TUN_TYPE_GA_TUN = 0,
 	ULP_WP_SYM_EEM_ACT_REC_INT = 1,
 	ULP_WP_SYM_EEM_EXT_FLOW_CNTR = 0,
 	ULP_WP_SYM_UC_ACT_REC = 0,
@@ -1452,6 +1520,7 @@ enum ulp_wp_sym {
 	ULP_WP_SYM_DPORT_TUN_TYPE_ECPRI = 4,
 	ULP_WP_SYM_DPORT_TUN_TYPE_SRV6 = 5,
 	ULP_WP_SYM_DPORT_TUN_TYPE_VXLAN_IPV4 = 6,
+	ULP_WP_SYM_TUN_TYPE_DYN_UPAR = 6,
 	ULP_WP_SYM_L3_ECPRI_HDR_SIZE = 0,
 	ULP_WP_SYM_L3_ECPRI_HDR_OFFS = 0,
 	ULP_WP_SYM_L3_ECPRI_PAT = 0,
@@ -1470,7 +1539,31 @@ enum ulp_wp_sym {
 	ULP_WP_SYM_T_ECPRI_ID_MASK = 0,
 	ULP_WP_SYM_T_ECPRI_CONTEXT_SIZE = 0,
 	ULP_WP_SYM_T_ECPRI_CONTEXT_OFFS = 0,
-	ULP_WP_SYM_T_ECPRI_CONTEXT_MASK = 0
+	ULP_WP_SYM_T_ECPRI_CONTEXT_MASK = 0,
+	ULP_WP_SYM_SRV6_IP_PROTO_IPV6_ROUTE = 0,
+	ULP_WP_SYM_SRV6_IPV6_ENCAP = 0,
+	ULP_WP_SYM_SRV6_HDR_SIZE = 0,
+	ULP_WP_SYM_SRV6_HDR_OFFSET = 0,
+	ULP_WP_SYM_SRV6_V6_ENCAP = 0,
+	ULP_WP_SYM_SRV6_NXT_HDR_EXT_LEN = 0,
+	ULP_WP_SYM_SRV6_8BYTE_UNIT = 0,
+	ULP_WP_SYM_SRV6_8BIT_FLD = 0,
+	ULP_WP_SYM_SRV6_HDR_LEN_OFFSET = 0,
+	ULP_WP_SYM_SRV6_ID_EXTRACTION_LENGTH = 0,
+	ULP_WP_SYM_SRV6_ID_EXTRACTION_OFFSET = 0,
+	ULP_WP_SYM_SRV6_PATTERN = 0,
+	ULP_WP_SYM_SRV6_ID_MASK = 0,
+	ULP_WP_SYM_SRV6_CTXT_EXTRACTION_LENGTH = 0,
+	ULP_WP_SYM_SRV6_CTXT_EXTRACTION_OFFSET = 0,
+	ULP_WP_SYM_SRV6_CTXT_MASK = 0,
+	ULP_WP_SYM_GLB_ID_L2_CNTXT_ID = 0,
+	ULP_WP_SYM_GLB_ID_PROF_FUNC_ID = 1,
+	ULP_WP_SYM_GLB_ID_WC_PROFILE_ID = 2,
+	ULP_WP_SYM_GLB_ID_EM_PROFILE_ID = 3,
+	ULP_WP_SYM_GLB_APP_IDX_TBL_ID = 0,
+	ULP_WP_SYM_GLB_IDX_META_REC_ACT = 4,
+	ULP_WP_SYM_GLB_IDX_META_REC_PROF = 5,
+	ULP_WP_SYM_GLB_IDX_META_REC_LKUP = 6
 };
 
 enum ulp_thor_sym {
@@ -1696,10 +1789,44 @@ enum ulp_thor_sym {
 	ULP_THOR_SYM_DECAP_FUNC_THRU_L2 = 11,
 	ULP_THOR_SYM_DECAP_FUNC_THRU_L3 = 12,
 	ULP_THOR_SYM_DECAP_FUNC_THRU_L4 = 13,
+	ULP_THOR_SYM_DECAP_FUNC_THRU_OL2 = 0,
+	ULP_THOR_SYM_DECAP_FUNC_THRU_OL3 = 0,
+	ULP_THOR_SYM_DECAP_FUNC_THRU_OL4 = 0,
+	ULP_THOR_SYM_DECAP_FUNC_THRU_OTUN = 0,
 	ULP_THOR_SYM_ECV_VALID_NO = 0,
 	ULP_THOR_SYM_ECV_VALID_YES = 1,
 	ULP_THOR_SYM_ECV_CUSTOM_EN_NO = 0,
 	ULP_THOR_SYM_ECV_CUSTOM_EN_YES = 1,
+	ULP_THOR_SYM_ECV_CUSTOM_IPV4_CTRL_ENCREC = 0,
+	ULP_THOR_SYM_ECV_CUSTOM_IPV4_CTRL_RSVD = 0,
+	ULP_THOR_SYM_ECV_CUSTOM_IPV4_CTRL_INHERIT = 0,
+	ULP_THOR_SYM_ECV_CUSTOM_IPV4_CTRL_INCREMENT = 0,
+	ULP_THOR_SYM_ECV_SMAC_OVR_USE_SPSMAC = 0,
+	ULP_THOR_SYM_ECV_SMAC_OVR_REUSE_IN_L2 = 0,
+	ULP_THOR_SYM_ECV_SMAC_OVR_REUSE_TUN_L2 = 0,
+	ULP_THOR_SYM_ECV_SMAC_OVR_USE_OUT_L2 = 0,
+	ULP_THOR_SYM_ECV_SMAC_OVR_RFU = 0,
+	ULP_THOR_SYM_ECV_SMAC_OVR_REUSE_IN_L2_DMAC = 0,
+	ULP_THOR_SYM_ECV_SMAC_OVR_REUSE_TUN_L2_DMAC = 0,
+	ULP_THOR_SYM_ECV_SMAC_OVR_REUSE_OUT_L2_DMAC = 0,
+	ULP_THOR_SYM_ECV_VLAN_OVR_USE_ENCREC_VLANS = 0,
+	ULP_THOR_SYM_ECV_VLAN_OVR_USE_IN_L2_VLANS = 0,
+	ULP_THOR_SYM_ECV_VLAN_OVR_USE_TUN_L2_VLANS = 0,
+	ULP_THOR_SYM_ECV_VLAN_OVR_USE_OUT_L2_VLANS = 0,
+	ULP_THOR_SYM_ECV_VLAN_OVR_USE_IN_VLAN_IN_L2 = 0,
+	ULP_THOR_SYM_ECV_VLAN_OVR_USE_OUT_VLAN_IN_L2 = 0,
+	ULP_THOR_SYM_ECV_VLAN_OVR_USE_IN_VLAN_OUT_L2 = 0,
+	ULP_THOR_SYM_ECV_VLAN_OVR_USE_OUT_VLAN_OUT_L2 = 0,
+	ULP_THOR_SYM_ECV_VLAN_OVR_USE_ENCREC_DMAC = 0,
+	ULP_THOR_SYM_ECV_VLAN_OVR_USE_IN_L2_DMAC = 0,
+	ULP_THOR_SYM_ECV_VLAN_OVR_USE_IN_TUN_DMAC = 0,
+	ULP_THOR_SYM_ECV_VLAN_OVR_USE_OUT_L2_DMAC = 0,
+	ULP_THOR_SYM_ECV_GRE_SET_K_INCLUDE_OPTIONAL = 0,
+	ULP_THOR_SYM_ECV_GRE_SET_K_NONE = 0,
+	ULP_THOR_SYM_ECV_IP_TOS_IN_HDR = 0,
+	ULP_THOR_SYM_ECV_IP_TOS_ENCREC = 0,
+	ULP_THOR_SYM_ECV_IP_TTL_IN_HDR = 0,
+	ULP_THOR_SYM_ECV_IP_TTL_ENCREC = 0,
 	ULP_THOR_SYM_ECV_L2_EN_NO = 0,
 	ULP_THOR_SYM_ECV_L2_EN_YES = 1,
 	ULP_THOR_SYM_ECV_VTAG_TYPE_NOP = 0,
@@ -1734,6 +1861,8 @@ enum ulp_thor_sym {
 	ULP_THOR_SYM_ECV_TUN_TYPE_NGE = 3,
 	ULP_THOR_SYM_ECV_TUN_TYPE_NVGRE = 4,
 	ULP_THOR_SYM_ECV_TUN_TYPE_GRE = 5,
+	ULP_THOR_SYM_ECV_TUN_TYPE_GA_L4 = 0,
+	ULP_THOR_SYM_ECV_TUN_TYPE_GA_TUN = 0,
 	ULP_THOR_SYM_EEM_ACT_REC_INT = 0,
 	ULP_THOR_SYM_EEM_EXT_FLOW_CNTR = 0,
 	ULP_THOR_SYM_UC_ACT_REC = 0,
@@ -1774,6 +1903,7 @@ enum ulp_thor_sym {
 	ULP_THOR_SYM_DPORT_TUN_TYPE_ECPRI = 4,
 	ULP_THOR_SYM_DPORT_TUN_TYPE_SRV6 = 5,
 	ULP_THOR_SYM_DPORT_TUN_TYPE_VXLAN_IPV4 = 6,
+	ULP_THOR_SYM_TUN_TYPE_DYN_UPAR = 0x12,
 	ULP_THOR_SYM_L3_ECPRI_HDR_SIZE = 4,
 	ULP_THOR_SYM_L3_ECPRI_HDR_OFFS = 0,
 	ULP_THOR_SYM_L3_ECPRI_PAT = 0,
@@ -1792,7 +1922,31 @@ enum ulp_thor_sym {
 	ULP_THOR_SYM_T_ECPRI_ID_MASK = 0xffffffff,
 	ULP_THOR_SYM_T_ECPRI_CONTEXT_SIZE = 32,
 	ULP_THOR_SYM_T_ECPRI_CONTEXT_OFFS = 3,
-	ULP_THOR_SYM_T_ECPRI_CONTEXT_MASK = 0xffffffff
+	ULP_THOR_SYM_T_ECPRI_CONTEXT_MASK = 0xffffffff,
+	ULP_THOR_SYM_SRV6_IP_PROTO_IPV6_ROUTE = 0x2b,
+	ULP_THOR_SYM_SRV6_IPV6_ENCAP = 0x2900,
+	ULP_THOR_SYM_SRV6_HDR_SIZE = 4,
+	ULP_THOR_SYM_SRV6_HDR_OFFSET = 0,
+	ULP_THOR_SYM_SRV6_V6_ENCAP = 3,
+	ULP_THOR_SYM_SRV6_NXT_HDR_EXT_LEN = 0x2900,
+	ULP_THOR_SYM_SRV6_8BYTE_UNIT = 3,
+	ULP_THOR_SYM_SRV6_8BIT_FLD = 8,
+	ULP_THOR_SYM_SRV6_HDR_LEN_OFFSET = 1,
+	ULP_THOR_SYM_SRV6_ID_EXTRACTION_LENGTH = 32,
+	ULP_THOR_SYM_SRV6_ID_EXTRACTION_OFFSET = 3,
+	ULP_THOR_SYM_SRV6_PATTERN = 2,
+	ULP_THOR_SYM_SRV6_ID_MASK = 0xff00ffff,
+	ULP_THOR_SYM_SRV6_CTXT_EXTRACTION_LENGTH = 32,
+	ULP_THOR_SYM_SRV6_CTXT_EXTRACTION_OFFSET = 7,
+	ULP_THOR_SYM_SRV6_CTXT_MASK = 0xffffffff,
+	ULP_THOR_SYM_GLB_ID_L2_CNTXT_ID = 0,
+	ULP_THOR_SYM_GLB_ID_PROF_FUNC_ID = 1,
+	ULP_THOR_SYM_GLB_ID_WC_PROFILE_ID = 2,
+	ULP_THOR_SYM_GLB_ID_EM_PROFILE_ID = 3,
+	ULP_THOR_SYM_GLB_APP_IDX_TBL_ID = 0,
+	ULP_THOR_SYM_GLB_IDX_META_REC_ACT = 4,
+	ULP_THOR_SYM_GLB_IDX_META_REC_PROF = 5,
+	ULP_THOR_SYM_GLB_IDX_META_REC_LKUP = 6
 };
 
 enum ulp_thor2_sym {
@@ -2018,10 +2172,44 @@ enum ulp_thor2_sym {
 	ULP_THOR2_SYM_DECAP_FUNC_THRU_L2 = 11,
 	ULP_THOR2_SYM_DECAP_FUNC_THRU_L3 = 12,
 	ULP_THOR2_SYM_DECAP_FUNC_THRU_L4 = 13,
+	ULP_THOR2_SYM_DECAP_FUNC_THRU_OL2 = 0x14,
+	ULP_THOR2_SYM_DECAP_FUNC_THRU_OL3 = 0x15,
+	ULP_THOR2_SYM_DECAP_FUNC_THRU_OL4 = 0x16,
+	ULP_THOR2_SYM_DECAP_FUNC_THRU_OTUN = 0x17,
 	ULP_THOR2_SYM_ECV_VALID_NO = 0,
 	ULP_THOR2_SYM_ECV_VALID_YES = 1,
 	ULP_THOR2_SYM_ECV_CUSTOM_EN_NO = 0,
 	ULP_THOR2_SYM_ECV_CUSTOM_EN_YES = 1,
+	ULP_THOR2_SYM_ECV_CUSTOM_IPV4_CTRL_ENCREC = 0,
+	ULP_THOR2_SYM_ECV_CUSTOM_IPV4_CTRL_RSVD = 1,
+	ULP_THOR2_SYM_ECV_CUSTOM_IPV4_CTRL_INHERIT = 2,
+	ULP_THOR2_SYM_ECV_CUSTOM_IPV4_CTRL_INCREMENT = 3,
+	ULP_THOR2_SYM_ECV_SMAC_OVR_USE_SPSMAC = 0,
+	ULP_THOR2_SYM_ECV_SMAC_OVR_REUSE_IN_L2 = 1,
+	ULP_THOR2_SYM_ECV_SMAC_OVR_REUSE_TUN_L2 = 2,
+	ULP_THOR2_SYM_ECV_SMAC_OVR_USE_OUT_L2 = 3,
+	ULP_THOR2_SYM_ECV_SMAC_OVR_RFU = 4,
+	ULP_THOR2_SYM_ECV_SMAC_OVR_REUSE_IN_L2_DMAC = 5,
+	ULP_THOR2_SYM_ECV_SMAC_OVR_REUSE_TUN_L2_DMAC = 6,
+	ULP_THOR2_SYM_ECV_SMAC_OVR_REUSE_OUT_L2_DMAC = 7,
+	ULP_THOR2_SYM_ECV_VLAN_OVR_USE_ENCREC_VLANS = 0,
+	ULP_THOR2_SYM_ECV_VLAN_OVR_USE_IN_L2_VLANS = 1,
+	ULP_THOR2_SYM_ECV_VLAN_OVR_USE_TUN_L2_VLANS = 0,
+	ULP_THOR2_SYM_ECV_VLAN_OVR_USE_OUT_L2_VLANS = 0,
+	ULP_THOR2_SYM_ECV_VLAN_OVR_USE_IN_VLAN_IN_L2 = 0,
+	ULP_THOR2_SYM_ECV_VLAN_OVR_USE_OUT_VLAN_IN_L2 = 0,
+	ULP_THOR2_SYM_ECV_VLAN_OVR_USE_IN_VLAN_OUT_L2 = 0,
+	ULP_THOR2_SYM_ECV_VLAN_OVR_USE_OUT_VLAN_OUT_L2 = 0,
+	ULP_THOR2_SYM_ECV_VLAN_OVR_USE_ENCREC_DMAC = 0,
+	ULP_THOR2_SYM_ECV_VLAN_OVR_USE_IN_L2_DMAC = 1,
+	ULP_THOR2_SYM_ECV_VLAN_OVR_USE_IN_TUN_DMAC = 2,
+	ULP_THOR2_SYM_ECV_VLAN_OVR_USE_OUT_L2_DMAC = 3,
+	ULP_THOR2_SYM_ECV_GRE_SET_K_INCLUDE_OPTIONAL = 1,
+	ULP_THOR2_SYM_ECV_GRE_SET_K_NONE = 1,
+	ULP_THOR2_SYM_ECV_IP_TOS_IN_HDR = 1,
+	ULP_THOR2_SYM_ECV_IP_TOS_ENCREC = 0,
+	ULP_THOR2_SYM_ECV_IP_TTL_IN_HDR = 1,
+	ULP_THOR2_SYM_ECV_IP_TTL_ENCREC = 0,
 	ULP_THOR2_SYM_ECV_L2_EN_NO = 0,
 	ULP_THOR2_SYM_ECV_L2_EN_YES = 1,
 	ULP_THOR2_SYM_ECV_VTAG_TYPE_NOP = 0,
@@ -2056,6 +2244,8 @@ enum ulp_thor2_sym {
 	ULP_THOR2_SYM_ECV_TUN_TYPE_NGE = 3,
 	ULP_THOR2_SYM_ECV_TUN_TYPE_NVGRE = 4,
 	ULP_THOR2_SYM_ECV_TUN_TYPE_GRE = 5,
+	ULP_THOR2_SYM_ECV_TUN_TYPE_GA_L4 = 6,
+	ULP_THOR2_SYM_ECV_TUN_TYPE_GA_TUN = 7,
 	ULP_THOR2_SYM_EEM_ACT_REC_INT = 0,
 	ULP_THOR2_SYM_EEM_EXT_FLOW_CNTR = 0,
 	ULP_THOR2_SYM_UC_ACT_REC = 0,
@@ -2096,6 +2286,7 @@ enum ulp_thor2_sym {
 	ULP_THOR2_SYM_DPORT_TUN_TYPE_ECPRI = 4,
 	ULP_THOR2_SYM_DPORT_TUN_TYPE_SRV6 = 5,
 	ULP_THOR2_SYM_DPORT_TUN_TYPE_VXLAN_IPV4 = 6,
+	ULP_THOR2_SYM_TUN_TYPE_DYN_UPAR = 0x12,
 	ULP_THOR2_SYM_L3_ECPRI_HDR_SIZE = 0,
 	ULP_THOR2_SYM_L3_ECPRI_HDR_OFFS = 0,
 	ULP_THOR2_SYM_L3_ECPRI_PAT = 0,
@@ -2114,7 +2305,31 @@ enum ulp_thor2_sym {
 	ULP_THOR2_SYM_T_ECPRI_ID_MASK = 0,
 	ULP_THOR2_SYM_T_ECPRI_CONTEXT_SIZE = 0,
 	ULP_THOR2_SYM_T_ECPRI_CONTEXT_OFFS = 0,
-	ULP_THOR2_SYM_T_ECPRI_CONTEXT_MASK = 0
+	ULP_THOR2_SYM_T_ECPRI_CONTEXT_MASK = 0,
+	ULP_THOR2_SYM_SRV6_IP_PROTO_IPV6_ROUTE = 0x2b,
+	ULP_THOR2_SYM_SRV6_IPV6_ENCAP = 0x2900,
+	ULP_THOR2_SYM_SRV6_HDR_SIZE = 4,
+	ULP_THOR2_SYM_SRV6_HDR_OFFSET = 0,
+	ULP_THOR2_SYM_SRV6_V6_ENCAP = 3,
+	ULP_THOR2_SYM_SRV6_NXT_HDR_EXT_LEN = 0x2900,
+	ULP_THOR2_SYM_SRV6_8BYTE_UNIT = 3,
+	ULP_THOR2_SYM_SRV6_8BIT_FLD = 8,
+	ULP_THOR2_SYM_SRV6_HDR_LEN_OFFSET = 1,
+	ULP_THOR2_SYM_SRV6_ID_EXTRACTION_LENGTH = 32,
+	ULP_THOR2_SYM_SRV6_ID_EXTRACTION_OFFSET = 3,
+	ULP_THOR2_SYM_SRV6_PATTERN = 2,
+	ULP_THOR2_SYM_SRV6_ID_MASK = 0xff00ffff,
+	ULP_THOR2_SYM_SRV6_CTXT_EXTRACTION_LENGTH = 32,
+	ULP_THOR2_SYM_SRV6_CTXT_EXTRACTION_OFFSET = 7,
+	ULP_THOR2_SYM_SRV6_CTXT_MASK = 0xffffffff,
+	ULP_THOR2_SYM_GLB_ID_L2_CNTXT_ID = 0,
+	ULP_THOR2_SYM_GLB_ID_PROF_FUNC_ID = 1,
+	ULP_THOR2_SYM_GLB_ID_WC_PROFILE_ID = 2,
+	ULP_THOR2_SYM_GLB_ID_EM_PROFILE_ID = 3,
+	ULP_THOR2_SYM_GLB_APP_IDX_TBL_ID = 0,
+	ULP_THOR2_SYM_GLB_IDX_META_REC_ACT = 4,
+	ULP_THOR2_SYM_GLB_IDX_META_REC_PROF = 5,
+	ULP_THOR2_SYM_GLB_IDX_META_REC_LKUP = 6
 };
 
 #endif
diff --git a/drivers/net/bnxt/tf_ulp/ulp_template_struct.h b/drivers/net/bnxt/tf_ulp/ulp_template_struct.h
index fbce97269b..5b3e82f336 100644
--- a/drivers/net/bnxt/tf_ulp/ulp_template_struct.h
+++ b/drivers/net/bnxt/tf_ulp/ulp_template_struct.h
@@ -34,6 +34,9 @@
 #define BNXT_ULP_PROTO_HDR_GRE_NUM	2
 #define BNXT_ULP_PROTO_HDR_ICMP_NUM	5
 #define BNXT_ULP_PROTO_HDR_ECPRI_NUM	2
+#define	BNXT_ULP_PROTO_HDR_IPV6_EXT_NUM	1
+#define BNXT_ULP_PROTO_HDR_SRV6_NUM	7
+#define BNXT_ULP_PROTO_HDR_MPLS_NUM	2
 #define BNXT_ULP_PROTO_HDR_MAX		128
 #define BNXT_ULP_PROTO_HDR_ENCAP_MAX	64
 #define BNXT_ULP_PROTO_HDR_FIELD_SVIF_IDX	1
-- 
2.39.5 (Apple Git-154)

