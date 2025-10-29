Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23D10CCF9EB
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Oct 2025 16:19:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3B49240669;
	Wed, 29 Oct 2025 17:19:29 +0100 (CET)
Received: from mail-oa1-f98.google.com (mail-oa1-f98.google.com
 [209.85.160.98]) by mails.dpdk.org (Postfix) with ESMTP id AEC9940A79
 for <dev@dpdk.org>; Wed, 29 Oct 2025 17:19:27 +0100 (CET)
Received: by mail-oa1-f98.google.com with SMTP id
 586e51a60fabf-3d2ea93836bso66279fac.3
 for <dev@dpdk.org>; Wed, 29 Oct 2025 09:19:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761754767; x=1762359567;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NWoSr4KeytGd4GizxVUX2X+fYsf91kn30CgFt6sPJQ0=;
 b=fKGXww7V+tmj6QMYwFGPotIfhOVvstNxyOjQtEezYQeQ31ybiod8f9jXa04trAlzqp
 xdHGtPD4g9H48Ub0SwZyx0WE6etEsxDo6RIhYdhRXKIOjYQB1JAM3+/gnKQhaUnKTOAj
 DRu6R6wavEdghsVUHfANN3e9CSyQZyBnD4VYiv9O16jNAYgmCKeLmF53xMzVKL3ZsCXw
 mpgPxGgfVdJnMVVeLhUqiy0mrOaBu/gQnRLRz8FHNRoFR+7vFfPeFgRObNQY2C4a3QUs
 t2d/YFuT+ArBcfJANCGwA4i/PbU+u6o9YVZIYG9YQ9dLE2TATMbjsKXU2h9Q6A8p4sNE
 E/0w==
X-Gm-Message-State: AOJu0YyeHeIt9yd2CoE99XDKcH123DpXVf9BXFwaloor6s4jOr0dCqCL
 3++Zc9q99bUm8tqlPWVxmQJ+dJUnCl2CQYnp6R0FwEOMgl7QI8p0x+R1rEIKsF3Jg7YdxzBQcG+
 eEnFxh8McRpZG+brnN/C1tUeBgRzBixK2sMEeWWCtHmS8S+GwMJYtJNcWx6QJk/0lrypBJgfzZu
 8L4STY8SR9jE6491EQ/jg1ZaGMjWnCoXPGdWLkTptKYLV1TwYvHetmWPO8E2Dships+ybwIw==
X-Gm-Gg: ASbGncufyMCV8gvc6wtliZHJ2ji9Pa6zkESF89jKpt1eU3GIzUupNHomXkWUiN+te+R
 p9zmGSkBoixCl0B5ukEVP2JPEcayJqSNcI6wHz/CdJDAIquzC4hVezqz+Ae1kG/G3RKfyFvhSO9
 qdetAklkvyTrnTi9e6ry2qwzXXZiRWYI6dscUVxOtZwJSK6T6RRr3TXC5StW62WWSbgPJ5aaJ9E
 DA+bdJbXDHF+HIFxwt40ElXI5wZNaW/7/oytlZiNEGJKjEjb/sMynpXLLvUlvB2sAA4Ev/R91pe
 c9UkbDc6nesjp5icDxy1uSfPYqmfdEeIjRfTyg1mV6HIR25PSuyMMQWCLGQrVZvPLYiW/pAyR17
 TRMoKmX+aRfZ64Pm8xkr5Q9W1UMpeJ6+n6GmXvdviiNmOtQliFrNIa2q5/fnppOPfYmRcpJb0lQ
 rHZUCdbJtrEReCigavLWc3XRm4jHi7FCM=
X-Google-Smtp-Source: AGHT+IFELjn1bTYO9nOlSOFVWDV2bdkBceB2q8h2ho+xIozFMasleVJmuT1P90RsQRu26r9a+nZdzB83hU/+
X-Received: by 2002:a05:6871:8302:b0:3d1:b6a4:1914 with SMTP id
 586e51a60fabf-3d74b26cc19mr1704020fac.27.1761754766657; 
 Wed, 29 Oct 2025 09:19:26 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-0.dlp.protect.broadcom.com. [144.49.247.0])
 by smtp-relay.gmail.com with ESMTPS id
 586e51a60fabf-3d1e3d5edf4sm1273927fac.19.2025.10.29.09.19.26
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 29 Oct 2025 09:19:26 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-4eba930d6ecso156508741cf.3
 for <dev@dpdk.org>; Wed, 29 Oct 2025 09:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1761754765; x=1762359565; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NWoSr4KeytGd4GizxVUX2X+fYsf91kn30CgFt6sPJQ0=;
 b=QlNlwYr/biOpl5MwwQbtRkpORHVpn5+XPDHeWkZvriIH/GpJB5iLTNpWmGdCDToLUT
 XcWCNyo+d80As5OLPdUmF4+h39qBj4uY087NCehKknhy2/V5uNr7R2pvY+QVekZtfGiW
 hrhfkpqOlcmgMDyj9TJBONPqSdEdOWZAbX408=
X-Received: by 2002:a05:622a:58a:b0:4ec:f5cd:8721 with SMTP id
 d75a77b69052e-4ed15a3c05amr40893321cf.0.1761754765509; 
 Wed, 29 Oct 2025 09:19:25 -0700 (PDT)
X-Received: by 2002:a05:622a:58a:b0:4ec:f5cd:8721 with SMTP id
 d75a77b69052e-4ed15a3c05amr40892821cf.0.1761754764889; 
 Wed, 29 Oct 2025 09:19:24 -0700 (PDT)
Received: from KX3WTC9T54.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-89f2421fba6sm1089026785a.4.2025.10.29.09.19.24
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 29 Oct 2025 09:19:24 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com, Shahaji Bhosle <shahaji.bhosle@broadcom.com>,
 Kishore Padmanabha <kishore.padmanabha@broadcom.com>
Subject: [PATCH v5 34/57] net/bnxt/tf_ulp: ulp parser support to handle gre key
Date: Wed, 29 Oct 2025 12:06:49 -0400
Message-Id: <20251029160712.58519-35-manish.kurup@broadcom.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20251029160712.58519-1-manish.kurup@broadcom.com>
References: <20251021175049.46092-1-manish.kurup@broadcom.com>
 <20251029160712.58519-1-manish.kurup@broadcom.com>
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

