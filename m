Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85881CAC5B9
	for <dpdk-dev@archiver.kernel.org>; Tue, 30 Sep 2025 07:09:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2A64540E4A;
	Tue, 30 Sep 2025 09:06:02 +0200 (CEST)
Received: from mail-pg1-f228.google.com (mail-pg1-f228.google.com
 [209.85.215.228])
 by mails.dpdk.org (Postfix) with ESMTP id A6F0D402D8
 for <dev@dpdk.org>; Tue, 30 Sep 2025 02:37:19 +0200 (CEST)
Received: by mail-pg1-f228.google.com with SMTP id
 41be03b00d2f7-b551b040930so3543117a12.2
 for <dev@dpdk.org>; Mon, 29 Sep 2025 17:37:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759192639; x=1759797439;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NWoSr4KeytGd4GizxVUX2X+fYsf91kn30CgFt6sPJQ0=;
 b=OmAOnzmIlFCcusy9rFNm+8ac3zIYGCDFB0qnmwo9af/cPyWjvNfjPVbKp+B2f2B0Kp
 qDI2bk9+qW71Me5PNol0foAjVTKOH1zNOG7p+XBDyFDjnlRqQKg/8kKadlYQaMewl4E0
 FLUuiJtWMmD6gMOR2zr1B1Hfcq7DwQRw5//kkgsbYCVfXfJdTtJb3NdLKjwiY3KD4qCA
 hnRT2GFaTNE/NDpOxdEyD8y/7PkNvhkzBxlZ5oF2mK0SeaADmMEzdBA92ieMoyAJLuX2
 PwgTZNZNSMMYaDraqYTad+wOT82HITZzhYUrZI9cBhxKUcUoqMxO7vdhtcNgg0ZNJYuW
 Dq9Q==
X-Gm-Message-State: AOJu0Yxh7R/pc67U4JT9sC98Kf7q6qYSBLAVJqE9waVvBZwFuOEjDBE9
 gAvrkbvcfuaSY5CCkOLQyOK9zVH9VWkCF4uhALOfcmanmrZ6cWGB4fpexXXHP5AQfnyS9MMeMBL
 d7L+nEDVGhvhsdvujzPEWd4Z9CUX7B9fm6zoKZxtqH2rTvsHOYLBDY8AWzaeNb+sNstrJZOMGF4
 fWocPnSW3RxfNwZtKSUleep5IWZnDZVbyT1yTT3ujqlrkLa+3Sx9RFTaxoe3aDEj5RClYrsw==
X-Gm-Gg: ASbGncsTNJw0VzzDWautH5tU6uVl7jMbDWNoFFM3rOZte6GtUp0wlJjJEmGwZqStWOo
 31Jq72G2dA/TAqKZQuXGzsPg47x4ctlbzO8Ja3eb9aBl1vRM4EmPK5b9TwJpbgPzVKQrrhKPawo
 3z6q5HtY01cRAYuj+DhxJXhgK3+tOgCrW4Yos+ehr9uHsYJCyDHwvgrdjagForYowcwpv5q3hQT
 dN0871rLPnZJt9iLK+/hO9pQ65C1SYOdrFs5N2IuugT4ZF5AaT4ZmuMwATdEsGSlqR6VofAUyhT
 fWeizSGPqdrE2VVn0IZBN/FsxZsKx4kewSacmT8czjNVIYmvF1/Xt5iRnLSgydsCdWOlr0bNCWl
 grMoYfNPhCwvs8QOQPlLEi/xnDwgmT+emrY8tfBOs4AH3RAXt1XvMEEWjAIEwcgQQs1yE34BD7r
 yHN8xaEbk=
X-Google-Smtp-Source: AGHT+IGG3Zi+KbjAzojO+vKmDbZpxZxkef0XvYncorXVvFPByEkxQuLrA9EWoU5ejOqEooyUHuv8C2wG/why
X-Received: by 2002:a17:902:f602:b0:275:b1cf:6dd9 with SMTP id
 d9443c01a7336-27ed4a608c8mr207512605ad.52.1759192638828; 
 Mon, 29 Sep 2025 17:37:18 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-100.dlp.protect.broadcom.com. [144.49.247.100])
 by smtp-relay.gmail.com with ESMTPS id
 d9443c01a7336-27ed66df723sm10538665ad.24.2025.09.29.17.37.18
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 29 Sep 2025 17:37:18 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-32eddb7e714so4579325a91.1
 for <dev@dpdk.org>; Mon, 29 Sep 2025 17:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1759192637; x=1759797437; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NWoSr4KeytGd4GizxVUX2X+fYsf91kn30CgFt6sPJQ0=;
 b=GvdYhPwiM4E7M17xVWExC9qzhKGq1joA1tR15RgWDLHTAnEBkKMTqvsBTxDRPTrQQ7
 2dp0dDHr7aiNZGgch+6/Ng47zHPdOOsokpv3JJee15zSasrYYFq4GMAu+eHie0feYFMJ
 QI8slcN/neeB2Xu/xjF/GAxl74kpVNkQN9CtA=
X-Received: by 2002:a17:90b:17c4:b0:338:2ed3:affb with SMTP id
 98e67ed59e1d1-3382ed3b12emr4729694a91.26.1759192636719; 
 Mon, 29 Sep 2025 17:37:16 -0700 (PDT)
X-Received: by 2002:a17:90b:17c4:b0:338:2ed3:affb with SMTP id
 98e67ed59e1d1-3382ed3b12emr4729667a91.26.1759192636165; 
 Mon, 29 Sep 2025 17:37:16 -0700 (PDT)
Received: from KX3WTC9T54.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b57c53bb97dsm12234825a12.9.2025.09.29.17.37.14
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 29 Sep 2025 17:37:15 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com, Shahaji Bhosle <shahaji.bhosle@broadcom.com>,
 Kishore Padmanabha <kishore.padmanabha@broadcom.com>
Subject: [PATCH 31/54] net/bnxt/tf_ulp: ulp parser support to handle gre key
Date: Mon, 29 Sep 2025 20:35:41 -0400
Message-Id: <20250930003604.87108-32-manish.kurup@broadcom.com>
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

