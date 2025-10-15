Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AB36CCD18E
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Oct 2025 09:05:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BC9A640E1B;
	Wed, 15 Oct 2025 11:04:46 +0200 (CEST)
Received: from mail-yw1-f225.google.com (mail-yw1-f225.google.com
 [209.85.128.225])
 by mails.dpdk.org (Postfix) with ESMTP id B2F7640E2B
 for <dev@dpdk.org>; Wed, 15 Oct 2025 11:04:45 +0200 (CEST)
Received: by mail-yw1-f225.google.com with SMTP id
 00721157ae682-7501c24a731so75320397b3.3
 for <dev@dpdk.org>; Wed, 15 Oct 2025 02:04:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760519085; x=1761123885;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NWoSr4KeytGd4GizxVUX2X+fYsf91kn30CgFt6sPJQ0=;
 b=XkC+NebuqHbM0TeBOI7FBSo3Xo4YJqkh5DF/OJpO8uitnNDnMIQ1SOEVdLK5wDXg8h
 06mGPGsC30/+D8OOyLUdhDTjqh9lSbhCoHi9m3RrYtUDgngx74tag/so4F96RaFu5lGe
 4aHntxBkV24EE8HiubRngZtNb9/7JVqbDmna6Le6cnmRkwRvhGNOCgWzN8wCcrrVA01+
 J2odtXenappaU/N7lMoMrV2vJQMIdL+BbNSuszbgff1pzR33M2Nqjms+4XaZ3wEd0Uly
 S0DpabDBx4y/OBbApGMXKK1y6d8z7EXZxmmHsIuVU8iWGDtcIcuVjuyRxkWAnNp4IgJT
 DAMg==
X-Gm-Message-State: AOJu0Yytp+bccF05Gvjf6OvhSNSlOU4oWTVKolxRMFXYTUCHyHAyu83a
 GHzlIiRTQWS9YPDtX0fSu/7Gom/ry3GwSJnHtO4lzgVzLAhTvYFzaOUULOX05ieJPTv3rBK76hN
 vN+v4rjkI9ZlAmQVvL1xMItfoF2x/i2mdf23rCNHIuhWjGO/rB7G9IkwyuIJiAI12xPIcAP6JSq
 x1eeJnwrGmktuiqsPascKTkOoN4DcWZnAZss5Kspauy3OvCxddH0bxiof7Q8Lblxg1CQhwXA==
X-Gm-Gg: ASbGncu3I8GMKZMT9yzzMIOMYy2hvHpD1jdxF9R0zi98M0s7X/IENO1/fXN1LfUK2jP
 X5VXw4N0fYCZt9bEGSFy/tt9+18quVm5XoMJ1WIyjJ4DR2EmKhbz0MzCBw35tF0+V2YdOdplXJt
 insXGeyvdfRF71XBE0z3dmVqyPFcjgG8CkzzhmE8yydM4ZY9VNwWyfyL0OlwrgTL8joOVynncKL
 EGY2b+kxJgTYY74zYoTbQv6Uv/BDStgUTWhh7Jr2xhJp5l/HT4ySM9R84IXXZHrHh5an7n+V5cs
 zSy2D3wh2YMAi/K0Alj5ttEKKcDa3Vnnv3wqKvKiqEqlrTmuXwiWErCrTby1u2A0XSrHbWT0XSl
 RMGMsTdbPfLPHHokd2CVo2QYjI+2UoATfnMfwIYPQri9xQwLEn073bkii2Eq9O8pG/YYS6MIu9f
 Y=
X-Google-Smtp-Source: AGHT+IEykj9ephVX/8AsJP5vkKMpD5ZB2T+pLmrz/n95n6y6BATvOLZAeDtSVNIn1DhZ0nULdPPXlyVAn/9V
X-Received: by 2002:a05:690c:6c83:b0:746:e6a3:1f6d with SMTP id
 00721157ae682-780e1584b39mr286562697b3.43.1760519084835; 
 Wed, 15 Oct 2025 02:04:44 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-19.dlp.protect.broadcom.com. [144.49.247.19])
 by smtp-relay.gmail.com with ESMTPS id
 00721157ae682-78106fac172sm9514907b3.21.2025.10.15.02.04.44
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 15 Oct 2025 02:04:44 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-77f2466eeb5so9932028b3a.2
 for <dev@dpdk.org>; Wed, 15 Oct 2025 02:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1760519083; x=1761123883; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NWoSr4KeytGd4GizxVUX2X+fYsf91kn30CgFt6sPJQ0=;
 b=dnm6V2QWBTnbNGP/zjHw1LpvmiMCehbNtiL+QhpLLLRfPcLjspq5J3V/bN4ZgfSTIh
 a9x8gxPQfOWk/Vq2q3puNVQrOvoqeJMXhPYfY9TQO3JLz1I5pehT9vYdPTPPBE9XRIW5
 nRmmZMKsDFSH4XVZtQe+h6lPOdxfq+NZHjom0=
X-Received: by 2002:a05:6a21:6d81:b0:2e6:22da:91bf with SMTP id
 adf61e73a8af0-32da817f8b9mr30176760637.9.1760519082900; 
 Wed, 15 Oct 2025 02:04:42 -0700 (PDT)
X-Received: by 2002:a05:6a21:6d81:b0:2e6:22da:91bf with SMTP id
 adf61e73a8af0-32da817f8b9mr30176731637.9.1760519082336; 
 Wed, 15 Oct 2025 02:04:42 -0700 (PDT)
Received: from localhost.localdomain ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7992bc12a8asm17832412b3a.34.2025.10.15.02.04.40
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 15 Oct 2025 02:04:41 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com, Shahaji Bhosle <shahaji.bhosle@broadcom.com>,
 Kishore Padmanabha <kishore.padmanabha@broadcom.com>
Subject: [PATCH v3 31/54] net/bnxt/tf_ulp: ulp parser support to handle gre key
Date: Wed, 15 Oct 2025 05:00:01 -0400
Message-Id: <20251015090024.32250-32-manish.kurup@broadcom.com>
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

From: Shahaji Bhosle <shahaji.bhosle@broadcom.com>

1. Added a new handler to GRE key input from the parser
2. Add a new pattern to match on GRE with KEY id.

Signed-off-by: Shahaji Bhosle <shahaji.bhosle@broadcom.com>
Reviewed-by: Kishore Padmanabha <kishore.padmanabha@broadcom.com>
---
 drivers/net/bnxt/tf_ulp/ulp_rte_handler_tbl.c |  4 +-
 drivers/net/bnxt/tf_ulp/ulp_rte_parser.c      | 45 ++++++++++++++++++-
 drivers/net/bnxt/tf_ulp/ulp_rte_parser.h      |  5 +++
 .../net/bnxt/tf_ulp/ulp_template_db_enum.h    |  3 +-
 drivers/net/bnxt/tf_ulp/ulp_template_struct.h |  2 +
 5 files changed, 55 insertions(+), 4 deletions(-)

diff --git a/drivers/net/bnxt/tf_ulp/ulp_rte_handler_tbl.c b/drivers/net/bnxt/tf_ulp/ulp_rte_handler_tbl.c
index 6e1115b985..4a7c7e437c 100644
--- a/drivers/net/bnxt/tf_ulp/ulp_rte_handler_tbl.c
+++ b/drivers/net/bnxt/tf_ulp/ulp_rte_handler_tbl.c
@@ -373,8 +373,8 @@ struct bnxt_ulp_rte_hdr_info ulp_hdr_info[] = {
 	.proto_hdr_func          = NULL
 	},
 	[RTE_FLOW_ITEM_TYPE_GRE_KEY] = {
-	.hdr_type                = BNXT_ULP_HDR_TYPE_NOT_SUPPORTED,
-	.proto_hdr_func          = NULL
+	.hdr_type                = BNXT_ULP_HDR_TYPE_SUPPORTED,
+	.proto_hdr_func          = ulp_rte_gre_key_hdr_handler
 	},
 	[RTE_FLOW_ITEM_TYPE_GTP_PSC] = {
 	.hdr_type                = BNXT_ULP_HDR_TYPE_NOT_SUPPORTED,
diff --git a/drivers/net/bnxt/tf_ulp/ulp_rte_parser.c b/drivers/net/bnxt/tf_ulp/ulp_rte_parser.c
index af7f8b7ab4..ceda1ff5ef 100644
--- a/drivers/net/bnxt/tf_ulp/ulp_rte_parser.c
+++ b/drivers/net/bnxt/tf_ulp/ulp_rte_parser.c
@@ -31,6 +31,9 @@
 #define ULP_UDP_PORT_GENEVE		6081
 #define ULP_UDP_PORT_GENEVE_MASK	0xFFFF
 
+/* GRE cks_rsvd0_ver bits */
+#define ULP_GRE_CKS_RSVD0_VER_HDR_KEY_BIT 0x2000
+
 /**
  * Geneve header first 16Bit
  * Version (2b), length of the options fields (6b), OAM packet (1b),
@@ -1887,14 +1890,51 @@ ulp_rte_geneve_hdr_handler(const struct rte_flow_item *item,
 	return BNXT_TF_RC_SUCCESS;
 }
 
+/* Function to handle the parsing of RTE Flow item GRE Key Header. */
+int32_t
+ulp_rte_gre_key_hdr_handler(const struct rte_flow_item *item,
+			    struct ulp_rte_parser_params *params)
+{
+	const rte_be32_t *gre_key_spec = item->spec;
+	const rte_be32_t *gre_key_mask = item->mask;
+	rte_be32_t gre_key_full_mask = RTE_BE32(UINT32_MAX);
+	struct ulp_rte_hdr_bitmap *hdr_bitmap = &params->hdr_bitmap;
+	uint32_t idx = 0;
+	uint32_t size;
+
+	if (unlikely(ulp_rte_prsr_fld_size_validate(params, &idx,
+						    BNXT_ULP_PROTO_HDR_GRE_KEY_NUM))) {
+		BNXT_DRV_DBG(ERR, "Error parsing protocol header");
+		return BNXT_TF_RC_ERROR;
+	}
+
+	if (unlikely(!(params->gre_cks_rsvd0_ver & RTE_BE16(ULP_GRE_CKS_RSVD0_VER_HDR_KEY_BIT)))) {
+		BNXT_DRV_DBG(ERR, "Error GRE K bit is not set");
+		return BNXT_TF_RC_ERROR;
+	}
+
+	if (gre_key_spec && !gre_key_mask)
+		gre_key_mask = &gre_key_full_mask;
+
+	size = sizeof(uint32_t);
+	ulp_rte_prsr_fld_mask(params, &idx, size,
+			      gre_key_spec,
+			      gre_key_mask,
+			      ULP_PRSR_ACT_DEFAULT);
+
+	/* Update the hdr_bitmap with GRE */
+	ULP_BITMAP_SET(hdr_bitmap->bits, BNXT_ULP_HDR_BIT_T_GRE_OPT);
+	return BNXT_TF_RC_SUCCESS;
+}
+
 /* Function to handle the parsing of RTE Flow item GRE Header. */
 int32_t
 ulp_rte_gre_hdr_handler(const struct rte_flow_item *item,
 			struct ulp_rte_parser_params *params)
 {
+	struct ulp_rte_hdr_bitmap *hdr_bitmap = &params->hdr_bitmap;
 	const struct rte_flow_item_gre *gre_spec = item->spec;
 	const struct rte_flow_item_gre *gre_mask = item->mask;
-	struct ulp_rte_hdr_bitmap *hdr_bitmap = &params->hdr_bitmap;
 	uint32_t idx = 0;
 	uint32_t size;
 
@@ -1907,6 +1947,9 @@ ulp_rte_gre_hdr_handler(const struct rte_flow_item *item,
 	if (gre_spec && !gre_mask)
 		gre_mask = &rte_flow_item_gre_mask;
 
+	params->gre_cks_rsvd0_ver = (gre_spec && gre_mask) ?
+		(gre_spec->c_rsvd0_ver & gre_mask->c_rsvd0_ver) : 0;
+
 	size = sizeof(((struct rte_flow_item_gre *)NULL)->c_rsvd0_ver);
 	ulp_rte_prsr_fld_mask(params, &idx, size,
 			      ulp_deference_struct(gre_spec, c_rsvd0_ver),
diff --git a/drivers/net/bnxt/tf_ulp/ulp_rte_parser.h b/drivers/net/bnxt/tf_ulp/ulp_rte_parser.h
index 5f451ba404..92c34394ae 100644
--- a/drivers/net/bnxt/tf_ulp/ulp_rte_parser.h
+++ b/drivers/net/bnxt/tf_ulp/ulp_rte_parser.h
@@ -140,6 +140,11 @@ int32_t
 ulp_rte_geneve_hdr_handler(const struct rte_flow_item *item,
 			      struct ulp_rte_parser_params *params);
 
+/* Function to handle the parsing of RTE Flow item GRE KEY Header. */
+int32_t
+ulp_rte_gre_key_hdr_handler(const struct rte_flow_item *item,
+			    struct ulp_rte_parser_params *params);
+
 /* Function to handle the parsing of RTE Flow item GRE Header. */
 int32_t
 ulp_rte_gre_hdr_handler(const struct rte_flow_item *item,
diff --git a/drivers/net/bnxt/tf_ulp/ulp_template_db_enum.h b/drivers/net/bnxt/tf_ulp/ulp_template_db_enum.h
index c30a43568b..3ce43f4c92 100644
--- a/drivers/net/bnxt/tf_ulp/ulp_template_db_enum.h
+++ b/drivers/net/bnxt/tf_ulp/ulp_template_db_enum.h
@@ -119,7 +119,8 @@ enum bnxt_ulp_hdr_bit {
 	BNXT_ULP_HDR_BIT_NON_GENERIC         = 0x0000000400000000,
 	BNXT_ULP_HDR_BIT_GENERIC             = 0x0000000800000000,
 	BNXT_ULP_HDR_BIT_T_MPLS              = 0x0000001000000000,
-	BNXT_ULP_HDR_BIT_LAST                = 0x0000002000000000
+	BNXT_ULP_HDR_BIT_T_GRE_OPT           = 0x0000002000000000,
+	BNXT_ULP_HDR_BIT_LAST                = 0x0000004000000000
 };
 
 enum bnxt_ulp_accept_opc {
diff --git a/drivers/net/bnxt/tf_ulp/ulp_template_struct.h b/drivers/net/bnxt/tf_ulp/ulp_template_struct.h
index 5b3e82f336..f38ebcea9a 100644
--- a/drivers/net/bnxt/tf_ulp/ulp_template_struct.h
+++ b/drivers/net/bnxt/tf_ulp/ulp_template_struct.h
@@ -32,6 +32,7 @@
 #define BNXT_ULP_PROTO_HDR_VXLAN_GPE_NUM 5
 #define BNXT_ULP_PROTO_HDR_GENEVE_NUM 4
 #define BNXT_ULP_PROTO_HDR_GRE_NUM	2
+#define BNXT_ULP_PROTO_HDR_GRE_KEY_NUM	1
 #define BNXT_ULP_PROTO_HDR_ICMP_NUM	5
 #define BNXT_ULP_PROTO_HDR_ECPRI_NUM	2
 #define	BNXT_ULP_PROTO_HDR_IPV6_EXT_NUM	1
@@ -100,6 +101,7 @@ struct ulp_rte_parser_params {
 	uint32_t			act_pattern_id;
 	uint8_t				app_id;
 	uint8_t				tun_idx;
+	uint16_t			gre_cks_rsvd0_ver; /* GRE C, K, S bits and version */
 	uint16_t			class_info_idx;
 	uint64_t			wc_field_bitmap;
 	uint64_t			cf_bitmap;
-- 
2.39.5 (Apple Git-154)

