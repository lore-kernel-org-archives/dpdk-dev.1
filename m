Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5238CCD184
	for <dpdk-dev@archiver.kernel.org>; Thu,  9 Oct 2025 22:17:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C72D240DDC;
	Fri, 10 Oct 2025 00:16:10 +0200 (CEST)
Received: from mail-io1-f98.google.com (mail-io1-f98.google.com
 [209.85.166.98]) by mails.dpdk.org (Postfix) with ESMTP id D1F9640DD6
 for <dev@dpdk.org>; Fri, 10 Oct 2025 00:16:08 +0200 (CEST)
Received: by mail-io1-f98.google.com with SMTP id
 ca18e2360f4ac-91122373653so57017439f.1
 for <dev@dpdk.org>; Thu, 09 Oct 2025 15:16:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760048168; x=1760652968;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NWoSr4KeytGd4GizxVUX2X+fYsf91kn30CgFt6sPJQ0=;
 b=ILgOqpJzjGqJLMJ43nixpGfVBh08uYKEN2I21VdiufONvXvnAnGm49c4rr1x5x13dN
 76DJDA8hY6ESl7tENyC2MBvq5PG1oEkM+GC46PZbmXeRvIlvqk0OIHw+doS44Y63AZqa
 Vz9gbnXxUO8Rcuuf+s/eWm8AJItegPLrhzwFLEy8ZgUR1fjXEhxKEd+XSkTWZczxfeYf
 7WLQ4MuvibUNr1MKYO7NOnKgN2zacZO0IiY7IPsPUSiByvp9R3AwE3iqAcXInt40chri
 aIKKtYMLubrMjjgun58/CVlWQ/Sfh2d25uA2iSAbM4IWMrLW/Bm3C2IlqLzX/wmCWiGU
 Yduw==
X-Gm-Message-State: AOJu0YyWXvvoIjLZt85Q3Wx0ELRioWRDa3P6SLNL+/XrXz9O4szKhf9L
 AdKKLVYwjA5w5SgO0RJYbTRBjBULLbk4DyunN+kkpIwPWpZBB74mXybxfjeLWZ0uArhv+jtnFAr
 p6i4MBayPyqeMd2dvF3p48pYTpPtwJevJ5MmPAvg3hJ53EjmClYozSOJ9uzCa7I8Ae6erVXVcnK
 caP1V6gF0zE0rkb+7QAu9CbVQwbkj8zv8ouZwGDy3tTII7j6b7LCtJjsjAC4gCjmnbSFfBcQ==
X-Gm-Gg: ASbGncutIRhmdM2NcauorHIGg3g6ZjvuQ6q2Y9ZLRmDpuf9WtqzYyYn0dr9ZtnCRfRy
 0WTobHOWvseW+9ziZusKqCOfyQsVYhrXIdyrUkmNagNVHP8pGbYsyBdlSL5FjvzwSRvMUKs2OtM
 zmQvoUEKZSAHqx6Kb8BVUwThJh/IZyk/d0zDeNDsVObiofsMWouY7ao7aiMCLhLNMVaBVSIdQao
 yFpHYYyObxiFBa5TNQj8UWFYP7+vUp+ETJ48raRpEyq3uRb7bax3oyAdkgQpcPI3yFLrOMX9Eyo
 l1VvD3cj8SpNJjYZCTeUv+Or+XWwwWfOxKmo0S1Je6Ap0IoiV3A7jXgGxCa1hQVnKyF71H/cwa6
 Fv8PExW2NPKowqIWEvrKkVqtSmEzFAJX14vWq/ZDQRHSwpjp6EJnKLG8saRSBg2Piy8V/ANJjZd
 ojEg==
X-Google-Smtp-Source: AGHT+IEzs3TCn4AMjkVAwmJ6NagzE84LK+eodJR1+RkfKnAFpn7b5usfmeGwe31ez1sj4X/rFfLtV2PIo6hL
X-Received: by 2002:a05:6e02:1c24:b0:42f:9847:15bd with SMTP id
 e9e14a558f8ab-42f984716b3mr23254995ab.26.1760048167940; 
 Thu, 09 Oct 2025 15:16:07 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-118.dlp.protect.broadcom.com. [144.49.247.118])
 by smtp-relay.gmail.com with ESMTPS id
 8926c6da1cb9f-58f71e18846sm44348173.33.2025.10.09.15.16.07
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 09 Oct 2025 15:16:07 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-70d7c7e972eso47771246d6.3
 for <dev@dpdk.org>; Thu, 09 Oct 2025 15:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1760048167; x=1760652967; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NWoSr4KeytGd4GizxVUX2X+fYsf91kn30CgFt6sPJQ0=;
 b=b8cSiIq0gD5AR5UOf4n8GYYiTESfFOaSZxAL37IX32eTqtb71pTdkGpyJK13IURvQF
 bp+KYD9WjJO72bY8j5ffQwd6KRiqUvZeTCyEkHlh/uAmDqvbCdFi+e9V/fbjW4N20j51
 IF6B2HO7ImjQ77LJbYY/nWZnTvd9CaVSdUD+A=
X-Received: by 2002:ad4:5c83:0:b0:79e:88e2:1e60 with SMTP id
 6a1803df08f44-87b2108abedmr124158086d6.29.1760048166547; 
 Thu, 09 Oct 2025 15:16:06 -0700 (PDT)
X-Received: by 2002:ad4:5c83:0:b0:79e:88e2:1e60 with SMTP id
 6a1803df08f44-87b2108abedmr124157606d6.29.1760048165927; 
 Thu, 09 Oct 2025 15:16:05 -0700 (PDT)
Received: from KX3WTC9T54.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-87bc3479344sm4189986d6.17.2025.10.09.15.16.05
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 09 Oct 2025 15:16:05 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com, Shahaji Bhosle <shahaji.bhosle@broadcom.com>,
 Kishore Padmanabha <kishore.padmanabha@broadcom.com>
Subject: [PATCH v2 31/54] net/bnxt/tf_ulp: ulp parser support to handle gre key
Date: Thu,  9 Oct 2025 18:11:06 -0400
Message-Id: <20251009221129.28256-32-manish.kurup@broadcom.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20251009221129.28256-1-manish.kurup@broadcom.com>
References: <20250930003604.87108-1-manish.kurup@broadcom.com>
 <20251009221129.28256-1-manish.kurup@broadcom.com>
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

