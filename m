Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6D1FC5DF8C
	for <dpdk-dev@archiver.kernel.org>; Fri, 21 Aug 2026 19:30:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0B6A140DD8;
	Fri, 21 Aug 2026 21:29:39 +0200 (CEST)
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com
 [209.85.215.173])
 by mails.dpdk.org (Postfix) with ESMTP id 9C28E40DD8
 for <dev@dpdk.org>; Fri, 21 Aug 2026 21:29:38 +0200 (CEST)
Received: by mail-pg1-f173.google.com with SMTP id
 41be03b00d2f7-c9eefcf9175so1428734a12.3
 for <dev@dpdk.org>; Fri, 21 Aug 2026 12:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1787340578;
 x=1787945378; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dQc5NT5zvBWOwM3Z16Dx7hBl94HTyk2usxSA34jCDDg=;
 b=kMDsddI4O307M3dqc4UrZeA9SZ9e9qfdfqT7A92j5Jhy5n1ZLu8ZGd3d+hzT1jM8xg
 seoNewMmlOJx/swTrdhz3SwFDe7AZalpuL+ngDscP2OKXgJ8XiaX2JAH+BnVppuwRer/
 3BjJ9Tp0xRR7CEOOwKypK5iVWKQtM3r2/3nWCtRSwSaeS1qFkssoleCuWhAjkiK1A2X4
 vJpejNqu6eUKlD2YXj8mSVfDe67EL5uC1zWpJyPfIaJqIs24dFX6ZHsM7XMEV+4kdpCm
 KUU8ziuPOBhfWc+XSRJrifDr4X0l8wl+AcYh+KSjoekCDDRVMsISSRUdYLbmWFAA2roU
 2W/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787340578; x=1787945378;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=dQc5NT5zvBWOwM3Z16Dx7hBl94HTyk2usxSA34jCDDg=;
 b=CAWRzRsZfQ2AUXD3BmUx0RxIi2HvPo3vu7SQQ807gGxS7QK1h9m9ixbn2ImtkJCAL5
 tNG8ENlt9LaBRpUPKW5UlFs+YDKRvHlWwaVCwGc4El/5q5QATCXlr8Hg6zPpZn8YgtJv
 bI9WdywDfAHDKsE0IaSn1SmslLIdBgGpRrD6rt8KtTz/sxTwUjhK5TviH+tvGO5l4Xka
 TSBLjCwbc3JDXfqTN7nZA9u3+Pu9BCmuyXiSVT2tTpXnOksz2zA+WNq7pJKlR+0uahzN
 gftk13opCs1QHunr+2KTlYqFQM1Yodps8FMg3Yr9b8+T01YQjJKSEdRb7FKxwhfYEun3
 03pQ==
X-Gm-Message-State: AFuF++mkFmVyMQzqLx6y8S5k6lR5VUEsZNjJjv3uQA7z4z/i4CUUpeLA
 wtBpbDl0JBTx8WYCJ4G8TItuLNEbBPgNBUp9d28YQBqJwgtk5Fe0HiIfBY19JkMVCm9K+NJGRz6
 5noX66sU=
X-Gm-Gg: AR+sD108whqBp95gxaPxsprqw9C7xbiUmWC/UtPx46BNXvaeMOKd5Yjv9Fk49s0keqc
 ucO+fPkDpb0ms05Pseh4g1/wAQ23dX1f4IS0W9PmB4cymTGo5y/ZVvmr9Q5OOZg0ucPFAZrDLY/
 Vv3CuibOk/cIhw6tRMIq4P7ZWcA2DmoztiW1ii6X+20NnG9B2CfuZ5kGdCoJGx7DY7cBa/CQH+0
 HhbUkNgGkfaWIcVW/ZDp+ptMQJKVThfb2/9bOZmtfyrax0gh6CHxdXrhzTAkj+dye5X2VW/ps7T
 ItdonV8DaSrJLcM7h6agd6gy36wQQ1DB3bieMenzeTcvDgbdXe1XUZsJ6uIx/SzT2ZpdJVzHEpb
 KOQ8ZvV4bnr5/mUxYWia7H8g6kGJ8LZPYXRUZSXRwVsQaq7KLNSsg9+doDpbG+9QtuQQw7pEpNR
 0wRRzj53U5B8W9RdxbBAXppqDInpR29UlFEap4jHEjw66no++yyIYr+CODK/sx9zDkB8qP0sU54
 /85mbRLmS0stuI98WMuTQawQI8=
X-Received: by 2002:a05:6a20:5482:b0:3c3:64cb:9b99 with SMTP id
 adf61e73a8af0-3cd2fdd1f41mr17787942637.6.1787340577668; 
 Fri, 21 Aug 2026 12:29:37 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc16c6dd2f4sm1860304a12.17.2026.08.21.12.29.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 12:29:37 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Kishore Padmanabha <kishore.padmanabha@broadcom.com>,
 Ajit Khaparde <ajit.khaparde@broadcom.com>
Subject: [PATCH v2 28/68] net/bnxt: replace use of rte_memcpy
Date: Fri, 21 Aug 2026 12:24:23 -0700
Message-ID: <20260821192646.146382-29-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260821192646.146382-1-stephen@networkplumber.org>
References: <20260820052251.1453273-1-stephen@networkplumber.org>
 <20260821192646.146382-1-stephen@networkplumber.org>
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

