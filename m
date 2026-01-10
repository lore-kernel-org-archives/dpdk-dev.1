Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32337D277CA
	for <dpdk-dev@archiver.kernel.org>; Sat, 10 Jan 2026 01:57:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0F23F40E0A;
	Sat, 10 Jan 2026 02:57:17 +0100 (CET)
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com
 [209.85.222.171])
 by mails.dpdk.org (Postfix) with ESMTP id 261CB40DD8
 for <dev@dpdk.org>; Sat, 10 Jan 2026 02:57:16 +0100 (CET)
Received: by mail-qk1-f171.google.com with SMTP id
 af79cd13be357-8b144ec3aa8so497549385a.2
 for <dev@dpdk.org>; Fri, 09 Jan 2026 17:57:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768010235; x=1768615035; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EtL4pGsb3xD2lYLalkrLfJEksVNle3xVKC0fhltLCwU=;
 b=X62WoI2YpqX5V3EiyK6KxOxoUST8sV0Qd1+Vk7Sm910XA2BA4MRNnCGgBUIls/z38/
 AUWMkZ+F7CfpdkgyzXrikSQ//dpHI/4b+BnQL5oUQX8GHJEBSMgDj1ufDqk8euY91a1k
 aXY6SHZTXjF300OPZkLlQG8L4M8xOTsp6G9q3oO1TI0qyxwhI4CyGHJ9jX2SDQGUkO+Z
 CyR/8s/a6Cbl450R71BV8EfsS61+cmN+IB6DFNrg76I0+inBNAV2cmw5lCmL6tZWtmrz
 TDONYXci1kbtfw6msg3nBNKBVT0uZhcNMbxHZ+CmRuhS17cZ+VOQ5BScN4V6VBS6bw7Y
 Jn+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768010235; x=1768615035;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=EtL4pGsb3xD2lYLalkrLfJEksVNle3xVKC0fhltLCwU=;
 b=JOWXNxWS+vaN57PBSF2xU+UZEaUbZjLKw+XoCSIvQELH0bAwTAC07iSyzzL9lQq5i/
 lowvbqfszk4pbBVCwGAm23KJaSxS9Tr6rgEWL1I0s4y6yxp96Ug+4Gu+JB7uIBiur26O
 EMDxTMh3F4hFUduA47+4BX5sVhwr7HA4ssYc7gdBHLam531CMxZNKA1UgyBS+0MW5ECH
 RFYn2mLNKnuR+h56qNftiknPFtTY/nyjLFCKMzgLYnLN22rCccE4PwOXKJRIaaTofwwM
 mDDs0jZ0f5/mD9y8s76Lm53k+YTurlTBpOhUzUrGMvGv+dDkvKjUv9XN/TJVImTudV1N
 PKBw==
X-Gm-Message-State: AOJu0YyycMr4KB0lDqF7b8CuChiy9scQNdZhOnFykxoLe6O4zcx6mwiZ
 F9Zf9RUXz0ioc3HrfSI1G4HZy2dXc9OXPr/jvckT2Bwd2DNV3JYZka8vsEymlQ==
X-Gm-Gg: AY/fxX6dAyEWwBLWK2+Nn3v+Py5YK0wU7QgBQ6OdKJ43RElDYQUHbmHm+5wxeR9k9o7
 kaNwILBuI6PDJfkZMOKjce1A4xLGFNknf/ysC7kJESPbFc5VTlmZo+OIeMYV0XntNWABUHC7vaS
 d3PR11w3NsVPIB3gFHwThkprhnSxkpPC5IlPkEsQDFfT26nVlKUp9FBNAVWKx2jh5kwB+Z8YM1V
 iUfiTObXuCx8hCt1QqUdvVgDv68OPN9ORaqNBV3Jr8iyQrE26ZTgZksfWdYNjv1ZuSIpFSq/gLw
 8SNf9mumLfJrobdpP6bXyFsf62wZWqBPnPjUZhNDIBORaLQfvtyp1fOot4Woky95+grcG7EBEqI
 xMQee68imFene7qUTTpzg6tnJH3mN6wAJM3ctUVPt/t9n/zSS8eQdnEaXJtBvL2uJUU5aBuUEQh
 lYD6qa1NIYw4Jskor4t71oTzVH+hRls/WkSga9pS9LPUSFyysgwEil4qND0g==
X-Google-Smtp-Source: AGHT+IHXDdvBv4fIPYOvyguhC5yHgjmrfqchw/UTlz9469jPHRwK3xlxpW1b79jR5ApG+5iFST2Lzg==
X-Received: by 2002:a05:620a:4d4b:b0:8c5:af6:3efa with SMTP id
 af79cd13be357-8c50af63fb2mr27283885a.86.1768010235287; 
 Fri, 09 Jan 2026 17:57:15 -0800 (PST)
Received: from st57p01nt-relayp01.apple.com
 ([2601:182:b80:6a50:314a:3f86:1924:bd42])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8c37f4a6145sm939379385a.5.2026.01.09.17.57.14
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 09 Jan 2026 17:57:15 -0800 (PST)
From: scott.k.mitch1@gmail.com
To: dev@dpdk.org
Cc: mb@smartsharesystems.com, stephen@networkplumber.org,
 Scott <scott_mitchell@apple.com>, Scott Mitchell <scott.k.mitch1@gmail.com>
Subject: [PATCH v12 3/3] eal/net: add workaround for GCC optimization bug
Date: Fri,  9 Jan 2026 20:56:51 -0500
Message-Id: <20260110015651.26201-4-scott.k.mitch1@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260110015651.26201-1-scott.k.mitch1@gmail.com>
References: <20260110015651.26201-1-scott.k.mitch1@gmail.com>
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

From: Scott <scott_mitchell@apple.com>

GCC has a bug where it incorrectly elides struct initialization in
inline functions when strict aliasing is enabled (-O2/-O3/-Os), causing
reads from uninitialized memory. This affects both designated initializers
and manual field assignment.

Add RTE_FORCE_INIT_BARRIER macro that uses an asm volatile memory barrier
to prevent the compiler from incorrectly optimizing away struct
initialization. Apply the workaround to pseudo-header checksum functions
in rte_ip4.h, rte_ip6.h, hinic driver, and mlx5 driver.

Signed-off-by: Scott Mitchell <scott.k.mitch1@gmail.com>
---
 drivers/net/hinic/hinic_pmd_tx.c |  2 ++
 drivers/net/mlx5/mlx5_flow_dv.c  |  2 ++
 lib/eal/include/rte_common.h     | 14 ++++++++++++++
 lib/net/rte_ip4.h                |  1 +
 lib/net/rte_ip6.h                |  1 +
 5 files changed, 20 insertions(+)

diff --git a/drivers/net/hinic/hinic_pmd_tx.c b/drivers/net/hinic/hinic_pmd_tx.c
index 22fb0bffaf..570715531d 100644
--- a/drivers/net/hinic/hinic_pmd_tx.c
+++ b/drivers/net/hinic/hinic_pmd_tx.c
@@ -725,6 +725,7 @@ hinic_ipv4_phdr_cksum(const struct rte_ipv4_hdr *ipv4_hdr, uint64_t ol_flags)
 		rte_cpu_to_be_16(rte_be_to_cpu_16(ipv4_hdr->total_length) -
 				 rte_ipv4_hdr_len(ipv4_hdr));
 	}
+	RTE_FORCE_INIT_BARRIER(psd_hdr);
 	return rte_raw_cksum(&psd_hdr, sizeof(psd_hdr));
 }
 
@@ -743,6 +744,7 @@ hinic_ipv6_phdr_cksum(const struct rte_ipv6_hdr *ipv6_hdr, uint64_t ol_flags)
 	else
 		psd_hdr.len = ipv6_hdr->payload_len;
 
+	RTE_FORCE_INIT_BARRIER(psd_hdr);
 	sum = __rte_raw_cksum(&ipv6_hdr->src_addr,
 		sizeof(ipv6_hdr->src_addr) + sizeof(ipv6_hdr->dst_addr), 0);
 	sum = __rte_raw_cksum(&psd_hdr, sizeof(psd_hdr), sum);
diff --git a/drivers/net/mlx5/mlx5_flow_dv.c b/drivers/net/mlx5/mlx5_flow_dv.c
index 47f6d28410..1eeeb6747f 100644
--- a/drivers/net/mlx5/mlx5_flow_dv.c
+++ b/drivers/net/mlx5/mlx5_flow_dv.c
@@ -4445,6 +4445,8 @@ __flow_encap_decap_resource_register(struct rte_eth_dev *dev,
 			.reserve = 0,
 		}
 	};
+	RTE_FORCE_INIT_BARRIER(encap_decap_key);
+
 	struct mlx5_flow_cb_ctx ctx = {
 		.error = error,
 		.data = resource,
diff --git a/lib/eal/include/rte_common.h b/lib/eal/include/rte_common.h
index 00d428e295..d58e856d96 100644
--- a/lib/eal/include/rte_common.h
+++ b/lib/eal/include/rte_common.h
@@ -555,6 +555,20 @@ static void __attribute__((destructor(RTE_PRIO(prio)), used)) func(void)
 #define __rte_no_ubsan_alignment
 #endif
 
+/**
+ * Force struct initialization to prevent GCC optimization bug.
+ * GCC has a bug where it incorrectly elides struct initialization in
+ * inline functions when strict aliasing is enabled, causing reads from
+ * uninitialized memory. This memory barrier prevents the misoptimization.
+ */
+#ifdef RTE_CC_GCC
+#define RTE_FORCE_INIT_BARRIER(var) do {	\
+	asm volatile("" : "+m" (var));		\
+} while (0)
+#else
+#define RTE_FORCE_INIT_BARRIER(var)
+#endif
+
 /*********** Macros for pointer arithmetic ********/
 
 /**
diff --git a/lib/net/rte_ip4.h b/lib/net/rte_ip4.h
index 822a660cfb..a0839c584e 100644
--- a/lib/net/rte_ip4.h
+++ b/lib/net/rte_ip4.h
@@ -238,6 +238,7 @@ rte_ipv4_phdr_cksum(const struct rte_ipv4_hdr *ipv4_hdr, uint64_t ol_flags)
 		psd_hdr.len = rte_cpu_to_be_16((uint16_t)(l3_len -
 			rte_ipv4_hdr_len(ipv4_hdr)));
 	}
+	RTE_FORCE_INIT_BARRIER(psd_hdr);
 	return rte_raw_cksum(&psd_hdr, sizeof(psd_hdr));
 }
 
diff --git a/lib/net/rte_ip6.h b/lib/net/rte_ip6.h
index d1abf1f5d5..902f100a44 100644
--- a/lib/net/rte_ip6.h
+++ b/lib/net/rte_ip6.h
@@ -572,6 +572,7 @@ rte_ipv6_phdr_cksum(const struct rte_ipv6_hdr *ipv6_hdr, uint64_t ol_flags)
 	else
 		psd_hdr.len = ipv6_hdr->payload_len;
 
+	RTE_FORCE_INIT_BARRIER(psd_hdr);
 	sum = __rte_raw_cksum(&ipv6_hdr->src_addr,
 		sizeof(ipv6_hdr->src_addr) + sizeof(ipv6_hdr->dst_addr),
 		0);
-- 
2.39.5 (Apple Git-154)

