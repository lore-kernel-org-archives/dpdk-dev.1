Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43818CCD1B9
	for <dpdk-dev@archiver.kernel.org>; Tue, 21 Oct 2025 18:57:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1282140E17;
	Tue, 21 Oct 2025 20:57:29 +0200 (CEST)
Received: from mail-pg1-f226.google.com (mail-pg1-f226.google.com
 [209.85.215.226])
 by mails.dpdk.org (Postfix) with ESMTP id 2787040E03
 for <dev@dpdk.org>; Tue, 21 Oct 2025 20:57:27 +0200 (CEST)
Received: by mail-pg1-f226.google.com with SMTP id
 41be03b00d2f7-b633b54d05dso4110515a12.2
 for <dev@dpdk.org>; Tue, 21 Oct 2025 11:57:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761073046; x=1761677846;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NWoSr4KeytGd4GizxVUX2X+fYsf91kn30CgFt6sPJQ0=;
 b=iLosTbBOrqnNt+d4tH3NSNjaov3pyaP9PRHzjVqvqSwELmCNZZR1oPfrfW98pgf4Yr
 GxpPlMVnCeMIk7pFlYtAJnDuUZUq8KT5wLsWJf+e7SLiOkAzezMv2+jO41e8FxtSnQUI
 qCld5uZKhwLU8AuhpeZFVswjHOK6d2bJyUngA5pl6j7POAf/kMAZVikvKcvMFWOBssHH
 HWLQdDEMUxJXSzEgI/E67SiFkGlkgmEiXpaAVFmhcPz4DPrcQPzuXrTiigv6gPDnBJqd
 8iwJIlbiW2W/NvekA8HxpQlgUpPsrfMgh2XMvv9ZbfxIoL5Jj0K0/cp6KthhI3/TcHb0
 9heg==
X-Gm-Message-State: AOJu0YxikVc9gCer4rET0EIrTwPTbDYyglblgTlSR2f7fOjyefJJtz8o
 O+BvKXAr809yM0jNk2u528nHEbGr/91ciEVk0ixmWd19EGP2POoPEl3273aa6wpMgIT6se1AK+9
 TVabGlIVBNh4W6jlOG3CGSM8EGcm0d+6+POZQHwZeItFq/hnlSD8h9hKBDrRVOiSP5co9NtytQL
 hnnE8PlIjUfNKRQX/FRCbOavxTV1Mg1T+E1ANOHbDpMQ0/ZuIKxwQTLvXvHic/5JiM+NN3ew==
X-Gm-Gg: ASbGnctfULKJMvUB+0bkpECyDSa7U/qbbbs8HTVh+2fAlcpTXa1nq7mfMkYc7LMjZeD
 vDVB6xZIQdcS2LXe/AdVwTm1GEoC3HZH4ekKxSgPr/8ov4o3Meq//vWP0QEvBcC8EaymjGlz136
 /xrt6GNsPOm6D18VqGLQMdiqlvvHyRZso/sSFYeL89lcYYEFoAdwKHxSaOo+/VaUVkCod0IM/52
 rvDjnOSFJPnbyK3YE+0lNXlElW8g2yWMz5QIZ6enGT/CHnQNSdXGcTA15TMnwaKQqA4bwJzKC72
 G49YKeDd3o8h1TsWNpRDkLEgEYbQJdGudNk/4rilStKkS/06WDplljYXUCmOysyBk2kZgoubuf7
 BhPaO/iZI9mfRSNU6BWhoGWDvlJd4C2Fmze05m34BEe8m/vakaysVtwBm7jgDUGQCWNxUIErz77
 23gQ5PQze5w1Ok5gOuS7wSMxv+82rSVkWNDORH
X-Google-Smtp-Source: AGHT+IEJ6hlKYMpD9jYTZmLJYgZGMkIojSrcU154B1zLVmM4DEPVewhIHDoYjPOs3FVc/aL/HM32ERtoPBta
X-Received: by 2002:a17:902:d483:b0:265:47:a7b0 with SMTP id
 d9443c01a7336-290c9c896a5mr211856825ad.10.1761073046211; 
 Tue, 21 Oct 2025 11:57:26 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-120.dlp.protect.broadcom.com. [144.49.247.120])
 by smtp-relay.gmail.com with ESMTPS id
 98e67ed59e1d1-33e248a8df1sm578a91.0.2025.10.21.11.57.25
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 21 Oct 2025 11:57:26 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2924b3b9d47so35559985ad.0
 for <dev@dpdk.org>; Tue, 21 Oct 2025 11:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1761073044; x=1761677844; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NWoSr4KeytGd4GizxVUX2X+fYsf91kn30CgFt6sPJQ0=;
 b=XRILL3EDKasT7/lD2e5f3rWGFC8H802xVgivuN5r3rzhntxLqLdmu0olpEi5MGa4m3
 chnbBwvHarKqRBbu5TskiWYL2C9vyBhUnj2hblsXz+8Ni+ah8x+cSsgiKGPeZ111wlOW
 dULfHq88diU/cEnyeTvS1sdqW3LSvyUmPZcA0=
X-Received: by 2002:a17:902:ce0e:b0:266:7871:37dc with SMTP id
 d9443c01a7336-290ca1216abmr254279865ad.36.1761073043898; 
 Tue, 21 Oct 2025 11:57:23 -0700 (PDT)
X-Received: by 2002:a17:902:ce0e:b0:266:7871:37dc with SMTP id
 d9443c01a7336-290ca1216abmr254279495ad.36.1761073043306; 
 Tue, 21 Oct 2025 11:57:23 -0700 (PDT)
Received: from KX3WTC9T54.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29246fdc9cfsm116598155ad.45.2025.10.21.11.57.22
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 21 Oct 2025 11:57:22 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com, Shahaji Bhosle <shahaji.bhosle@broadcom.com>,
 Kishore Padmanabha <kishore.padmanabha@broadcom.com>
Subject: [PATCH v4 34/57] net/bnxt/tf_ulp: ulp parser support to handle gre key
Date: Tue, 21 Oct 2025 14:56:38 -0400
Message-Id: <20251021185701.71881-3-manish.kurup@broadcom.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20251021185701.71881-1-manish.kurup@broadcom.com>
References: <20251021185701.71881-1-manish.kurup@broadcom.com>
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

