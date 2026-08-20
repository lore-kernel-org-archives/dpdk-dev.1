Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D7EFC5DF85
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Aug 2026 05:25:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1AC6B40A84;
	Thu, 20 Aug 2026 07:24:25 +0200 (CEST)
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com
 [209.85.215.175])
 by mails.dpdk.org (Postfix) with ESMTP id 330CB40A84
 for <dev@dpdk.org>; Thu, 20 Aug 2026 07:24:23 +0200 (CEST)
Received: by mail-pg1-f175.google.com with SMTP id
 41be03b00d2f7-c9aea40d799so908775a12.0
 for <dev@dpdk.org>; Wed, 19 Aug 2026 22:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1787203462;
 x=1787808262; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dQc5NT5zvBWOwM3Z16Dx7hBl94HTyk2usxSA34jCDDg=;
 b=T5W4k6wdcesjtB93nniW4P2OVMtox2ptML/S0lH/1iMcMF2UQ1ZQf1SosLT8qIcioZ
 A663eETIaGTzYGALcjHvmb+uRy4kGWNF7lAs7GvfMAeKUZvAgILXx7kMSUBwhYdGJQ0+
 UrgkM5otYfOwCzmGIS2uIm4TJEXvPyO3OZDZyULnmqViy0i+r7IGfduqiwZYDFPcHRIF
 12IhA4rGSYO7/u0x4RxPQQ6tvqFMWOtU3P1JkyP5ow1+QKUydJJdW5nZJANXA8S1K2hB
 ROdk4iKqEmMcTM2upLmC62Y4Iz8voLF92fqn4C5TwXVPfWRhKF+4AFPsutiTLvtDS8T0
 GYVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787203462; x=1787808262;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=dQc5NT5zvBWOwM3Z16Dx7hBl94HTyk2usxSA34jCDDg=;
 b=GQlpMZvzBDMfIRyJVaKTL7//oPEeyIBIkOPtu7hUoniIOeP+zOIgV8YKZu0vg0jGAH
 E+4p5H0CDKqyNnS3LfFVVxrxrrpGlP71Vl2Ii6nqIUjpmQfFOfcbr/Td3jj68gdz3Z81
 c4sNMHyvhk+40Ha2j7/vcCiVMl5JiVDsjX/UyGT3miF2k5BwYg1PyzqlhsHCpRGjGJVt
 EqF9RwZeRsBF7qMgmoRkZl3PkmG+dN2Dh8/fiUrDROMvH3558d/8d1FVMMrH625RiraR
 0VLPFSk2bl3ZXqtAtxd2QLZI/onKTIpfwM758BOccVmlVX/iGUjZlFrV0EKYeujXfjM1
 rqrg==
X-Gm-Message-State: AOJu0YzNdNikwGUA1trhsuEu1vnZTj7pGTG0426bHkbq1kDarrgpyYbn
 ULf7XhJgwfHP6m/1JNOl1Y+1PDGjzZNhD03uq7205P59TZwPDwBsYml0LaznGvwcYgeIUQKK2U8
 NmkrF
X-Gm-Gg: AR+sD10O8JUYDN1BIa+FSoxjv/0x64Y5/u5y8+JDyNTVSgsn6+80a3q+xI5CS9Z27YA
 BL0AD3Lj+jqJxCPueZ6GwVaCRA0+E1yBsVNSEscKvV75rJEOJVXlxEdLi4eXrMVMl8sHl1A/jdY
 S+XEcOd5oRzs0ZA8jmrkhBJdKDkPgzw39Twt6gymGGjdNUKiQm8ni9TcY9P8/M04eKFPYPmdjR0
 /Oo/rA69TNxXD26zHfRbfc5ZynNM4pkqILFwqhbDea1h442YUdr5uBfyV0IhiEDf7mrBf9cprkt
 GQ1XVw5bbm7kCqweBrTH/cPeat3yanVZKD3GjlhHr88z/ApE5NUtMHqSOo0msc2kXajLBu29lDG
 XjYqb2OYPhdzEiDak3APJTQXZRQeUscK1SnulRUQ+ZU6Wm0A80/+KGI3U0aXJkrVsKMY3acwYQP
 SIsQ6oTPPMpGWOv5j+ieNMyDhQN9lJw8yQfj3h99NPyGDY+4xcolPeD+Zq1NGGswrvZKinPhL5a
 LV5tMd3qGRNl3AqskD/EokxWvgdBkrztV2+8g==
X-Received: by 2002:a05:6372:a80c:b0:3cd:f6c:6cdd with SMTP id
 adf61e73a8af0-3cd0f6cc723mr10404611637.16.1787203462266; 
 Wed, 19 Aug 2026 22:24:22 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-327bef3bb5csm13700974eec.2.2026.08.19.22.24.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 22:24:21 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Kishore Padmanabha <kishore.padmanabha@broadcom.com>,
 Ajit Khaparde <ajit.khaparde@broadcom.com>
Subject: [PATCH 21/61] net/bnxt: replace use of rte_memcpy
Date: Wed, 19 Aug 2026 22:12:11 -0700
Message-ID: <20260820052251.1453273-22-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260820052251.1453273-1-stephen@networkplumber.org>
References: <20260820052251.1453273-1-stephen@networkplumber.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Don't need rte_memcpy for fixed size value.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/bnxt/bnxt_flow.c | 34 ++++++++++++++++++----------------
 1 file changed, 18 insertions(+), 16 deletions(-)

diff --git a/drivers/net/bnxt/bnxt_flow.c b/drivers/net/bnxt/bnxt_flow.c
index a2e590540b..901b019e66 100644
--- a/drivers/net/bnxt/bnxt_flow.c
+++ b/drivers/net/bnxt/bnxt_flow.c
@@ -233,8 +233,9 @@ bnxt_validate_and_parse_flow_type(const struct rte_flow_attr *attr,
 						    "DMAC is invalid!");
 					return -rte_errno;
 				}
-				rte_memcpy(filter->dst_macaddr,
-					   &eth_spec->hdr.dst_addr, RTE_ETHER_ADDR_LEN);
+				memcpy(filter->dst_macaddr,
+				       &eth_spec->hdr.dst_addr,
+				       RTE_ETHER_ADDR_LEN);
 				en |= use_ntuple ?
 					NTUPLE_FLTR_ALLOC_INPUT_EN_DST_MACADDR :
 					EM_FLOW_ALLOC_INPUT_EN_DST_MACADDR;
@@ -257,8 +258,9 @@ bnxt_validate_and_parse_flow_type(const struct rte_flow_attr *attr,
 						    "SMAC is invalid!");
 					return -rte_errno;
 				}
-				rte_memcpy(filter->src_macaddr,
-					   &eth_spec->hdr.src_addr, RTE_ETHER_ADDR_LEN);
+				memcpy(filter->src_macaddr,
+				       &eth_spec->hdr.src_addr,
+				       RTE_ETHER_ADDR_LEN);
 				en |= use_ntuple ?
 					NTUPLE_FLTR_ALLOC_INPUT_EN_SRC_MACADDR :
 					EM_FLOW_ALLOC_INPUT_EN_SRC_MACADDR;
@@ -423,23 +425,23 @@ bnxt_validate_and_parse_flow_type(const struct rte_flow_attr *attr,
 				en |= EM_FLOW_ALLOC_INPUT_EN_SRC_IPADDR |
 					EM_FLOW_ALLOC_INPUT_EN_DST_IPADDR;
 
-			rte_memcpy(filter->src_ipaddr,
-				   &ipv6_spec->hdr.src_addr, 16);
-			rte_memcpy(filter->dst_ipaddr,
-				   &ipv6_spec->hdr.dst_addr, 16);
+			memcpy(filter->src_ipaddr, &ipv6_spec->hdr.src_addr,
+			       16);
+			memcpy(filter->dst_ipaddr, &ipv6_spec->hdr.dst_addr,
+			       16);
 
 			if (!bnxt_check_zero_bytes(ipv6_mask->hdr.src_addr.a,
 						   16)) {
-				rte_memcpy(filter->src_ipaddr_mask,
-					   &ipv6_mask->hdr.src_addr, 16);
+				memcpy(filter->src_ipaddr_mask,
+				       &ipv6_mask->hdr.src_addr, 16);
 				en |= !use_ntuple ? 0 :
 				    NTUPLE_FLTR_ALLOC_INPUT_EN_SRC_IPADDR_MASK;
 			}
 
 			if (!bnxt_check_zero_bytes(ipv6_mask->hdr.dst_addr.a,
 						   16)) {
-				rte_memcpy(filter->dst_ipaddr_mask,
-					   &ipv6_mask->hdr.dst_addr, 16);
+				memcpy(filter->dst_ipaddr_mask,
+				       &ipv6_mask->hdr.dst_addr, 16);
 				en |= !use_ntuple ? 0 :
 				     NTUPLE_FLTR_ALLOC_INPUT_EN_DST_IPADDR_MASK;
 			}
@@ -591,8 +593,8 @@ bnxt_validate_and_parse_flow_type(const struct rte_flow_attr *attr,
 					return -rte_errno;
 				}
 
-				rte_memcpy(((uint8_t *)&tenant_id_be + 1),
-					   vxlan_spec->hdr.vni, 3);
+				memcpy(((uint8_t *)&tenant_id_be + 1),
+				       vxlan_spec->hdr.vni, 3);
 				filter->vni =
 					rte_be_to_cpu_32(tenant_id_be);
 				filter->tunnel_type =
@@ -645,8 +647,8 @@ bnxt_validate_and_parse_flow_type(const struct rte_flow_attr *attr,
 						 "Invalid TNI mask");
 					return -rte_errno;
 				}
-				rte_memcpy(((uint8_t *)&tenant_id_be + 1),
-					   nvgre_spec->tni, 3);
+				memcpy(((uint8_t *)&tenant_id_be + 1),
+				       nvgre_spec->tni, 3);
 				filter->vni =
 					rte_be_to_cpu_32(tenant_id_be);
 				filter->tunnel_type =
-- 
2.53.0

