Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FC74CD98DA
	for <dpdk-dev@archiver.kernel.org>; Tue, 16 Jun 2026 10:48:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0F31F40E2B;
	Tue, 16 Jun 2026 12:47:52 +0200 (CEST)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49]) by mails.dpdk.org (Postfix) with ESMTP id 4FC8540E0C
 for <dev@dpdk.org>; Tue, 16 Jun 2026 12:47:50 +0200 (CEST)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-490a76757e5so31618795e9.2
 for <dev@dpdk.org>; Tue, 16 Jun 2026 03:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781606870; x=1782211670; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bnDkIceKSnjE4JQZm5JneepHpqmbywIWcZkPX+JxZ04=;
 b=DI6MlJDYPKpdNAXCm6unSxAIXpiL2BTpT8P82GqdIzklw8s/iAyW/uZUnkiYRfMplG
 Dfs2UTZh5qfXlQwvh0WCI1DxuX1YkEWvbRXVZ/hsVImZ81i5TjuDRfSQ4X9yFV/8NmCs
 H5+Qo28WfbhQeQWP1XCxRE+kEb8ttKTe7JQODFT+JKTgDkj+++XmdX9zngfxUG3klaNX
 XR/Xy8dtxrk725e/i5nMD/oDwKrc4otbsDxuoxWmEerYCiaotV8pL/1z2bad4WvDce2c
 7U+Zb930eH+BIo5SWukDDfMq+74/FCl23DbuNdck6ZZuUvTxKVfnwM6a6z4QNBlpeNrL
 Hfow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781606870; x=1782211670;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bnDkIceKSnjE4JQZm5JneepHpqmbywIWcZkPX+JxZ04=;
 b=lKXtKNaMezxV+d7NuLb9iueTZ9XezC8R4u/I2k9HpQafpox2nmZ28fYWeZ/TItqwDg
 kAlpZ/fWlToWG2IjBjBuUCmcR/GCG6vlRO6NiQ2FunL2iGdoze6V9tlpB17E3/T2dDvy
 fM0IRhF0l1qbi5gozn8AshgWAeq/oHtQEzN/OZTAcj2OZf+iMSSqtbJM6GmozWv2eImY
 u1ySNru9FNbm+sHMKc9SKgF55VZMAyPP8IkIzBPM9eQnKlwBuLVn0hVRR85bRpyEkk9k
 LZaH/GmRZTWsVBzgtDUYR8LnIDgVKPdi2I4ucK+xBbStocNdNtTsCUsmT6q1+gAjBbJt
 9bNA==
X-Gm-Message-State: AOJu0Yx1ju+5C2XdQpgVSc5wUg3Al3+mX7BLwIf/BVBXt98g0ZHZIPgy
 dzX0eIafYB9n+JOfcYAJJA39EhgTFFC4tPWh86kGfEQ7QxWTwH0CTAK8Xwom06Ot
X-Gm-Gg: Acq92OHqucflqUdoL9grJHtSjUtFBV9B0ECs23yJBh2RWecyP4ix+7JnfEH+Uswowl6
 HJE1Rqu56x8SpyvSeZDFuP+Ln175TJHXi3pNsVE4fllUPCqTI4dktJOvrIt6s5dj9Lf2HAn8kJL
 vUT7nnc6R4ZMcD16Su+sW3BIpoH83U4YcK45DyM4UPXmltPGQae3uFaXF7OY8Xyn2KYWYiN/vHZ
 iJvOG58a367hrTGJ2AhRp/ljeBJ0mRKj5BvlA24HlJLjzT89JGmkhrOMgG6raiofBA32VBipxVG
 uUBJNjfnDfjDNI+YIZrqvmLi4QxYiQHDiqTLwT/hmLbaZAP9xYOQKpjcCZqUNPkjLxFTsRLLyPn
 UOhc+GysIn2zU7CYmXgiB67gVgmIY8oiUOJRzfR7lCnYawPwRUmArIQdnF+Nh02MNSP/04pXIlB
 /1bKT5xDKMDA0Iz3M5jImgBBcgFSeC1Uzdu3SgfVG30UwvwyMtqIGT
X-Received: by 2002:a7b:c7c1:0:b0:490:ba0a:1178 with SMTP id
 5b1f17b1804b1-492200e7bf4mr138261495e9.28.1781606869762; 
 Tue, 16 Jun 2026 03:47:49 -0700 (PDT)
Received: from freepad.iliad.local (free-mobile.vlq16.iliad.fr. [213.36.7.11])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49230a9b45bsm43485095e9.15.2026.06.16.03.47.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 03:47:49 -0700 (PDT)
Sender: Maxime Leroy <maxime.leroys@gmail.com>
From: Maxime Leroy <maxime@leroys.fr>
To: dev@dpdk.org
Cc: Maxime Leroy <maxime@leroys.fr>, Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>
Subject: [PATCH 5/6] net/dpaa2: support inner RSS level for tunnelled traffic
Date: Tue, 16 Jun 2026 12:47:14 +0200
Message-ID: <20260616104717.723087-6-maxime@leroys.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260616104717.723087-1-maxime@leroys.fr>
References: <20260616104717.723087-1-maxime@leroys.fr>
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

Honour RTE_ETH_RSS_LEVEL_INNERMOST in the RSS configuration. When it is
set, program the IP extracts with hdr_index = HDR_INDEX_LAST so the RSS
key uses the innermost IP header instead of the outer one.

This is useful for tunnelled traffic whose outer headers are fixed,
leaving no entropy for an outer IP hash. Hashing on the inner IP
addresses spreads such flows.

The hdr_index field is only defined for IP/IPv4/IPv6, VLAN and MPLS
extracts, so this patch only controls the IP extracts. L4 extracts do not
have a header-instance selector and keep hdr_index 0; they continue to
use the parser-selected L4 offset.

The RSS level is carried in the high bits of rss_hf; extract it and strip
the level bits before walking the protocol bits so they are not mistaken
for an unsupported hash type. The level is also advertised in
flow_type_rss_offloads, otherwise ethdev rejects an rss_hf carrying it.

Signed-off-by: Maxime Leroy <maxime@leroys.fr>
---
 doc/guides/rel_notes/release_26_07.rst |  4 ++++
 drivers/net/dpaa2/base/dpaa2_hw_dpni.c | 23 +++++++++++++++++++++++
 drivers/net/dpaa2/dpaa2_ethdev.c       |  3 ++-
 3 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/doc/guides/rel_notes/release_26_07.rst b/doc/guides/rel_notes/release_26_07.rst
index 5d7aa8d1bf..39f3988198 100644
--- a/doc/guides/rel_notes/release_26_07.rst
+++ b/doc/guides/rel_notes/release_26_07.rst
@@ -140,6 +140,10 @@ New Features
 
   * Added support for selective Rx in scalar SPRQ Rx path.
 
+* **Updated NXP dpaa2 driver.**
+
+  * Added inner RSS level support for tunnelled traffic.
+
 * **Updated PCAP ethernet driver.**
 
   * Added support for VLAN insertion and stripping.
diff --git a/drivers/net/dpaa2/base/dpaa2_hw_dpni.c b/drivers/net/dpaa2/base/dpaa2_hw_dpni.c
index 2724672a5e..8a05253bbd 100644
--- a/drivers/net/dpaa2/base/dpaa2_hw_dpni.c
+++ b/drivers/net/dpaa2/base/dpaa2_hw_dpni.c
@@ -220,6 +220,13 @@ dpaa2_remove_flow_dist(struct rte_eth_dev *eth_dev,
 	return ret;
 }
 
+/* dpkg from_hdr.hdr_index value selecting the innermost IP instance (see
+ * fsl_dpkg.h, where hdr_index is only defined for NET_PROT_IP/IPv4/IPv6/
+ * VLAN/MPLS). Used to hash on the inner IP of tunnelled traffic when
+ * RTE_ETH_RSS_LEVEL_INNERMOST is requested.
+ */
+#define DPAA2_DIST_HDR_INDEX_LAST 0xff
+
 int
 dpaa2_distset_to_dpkg_profile_cfg(
 		uint64_t req_dist_set,
@@ -234,8 +241,18 @@ dpaa2_distset_to_dpkg_profile_cfg(
 	int esp_configured = 0;
 	int ah_configured = 0;
 	int pppoe_configured = 0;
+	uint8_t hdr_index = 0;
 
 	memset(kg_cfg, 0, sizeof(struct dpkg_profile_cfg));
+
+	/* RTE_ETH_RSS_LEVEL_INNERMOST asks for the inner header to be hashed.
+	 * Map it to the innermost IP instance in the key extracts; the level
+	 * bits are not protocol bits, so strip them before the loop.
+	 */
+	if ((req_dist_set & RTE_ETH_RSS_LEVEL_MASK) == RTE_ETH_RSS_LEVEL_INNERMOST)
+		hdr_index = DPAA2_DIST_HDR_INDEX_LAST;
+	req_dist_set &= ~RTE_ETH_RSS_LEVEL_MASK;
+
 	while (req_dist_set) {
 		if (req_dist_set % 2 != 0) {
 			dist_field = 1ULL << loop;
@@ -373,6 +390,8 @@ dpaa2_distset_to_dpkg_profile_cfg(
 
 				kg_cfg->extracts[i].extract.from_hdr.prot =
 					NET_PROT_IP;
+				kg_cfg->extracts[i].extract.from_hdr.hdr_index =
+					hdr_index;
 				kg_cfg->extracts[i].extract.from_hdr.field =
 					NH_FLD_IP_SRC;
 				kg_cfg->extracts[i].type =
@@ -383,6 +402,8 @@ dpaa2_distset_to_dpkg_profile_cfg(
 
 				kg_cfg->extracts[i].extract.from_hdr.prot =
 					NET_PROT_IP;
+				kg_cfg->extracts[i].extract.from_hdr.hdr_index =
+					hdr_index;
 				kg_cfg->extracts[i].extract.from_hdr.field =
 					NH_FLD_IP_DST;
 				kg_cfg->extracts[i].type =
@@ -393,6 +414,8 @@ dpaa2_distset_to_dpkg_profile_cfg(
 
 				kg_cfg->extracts[i].extract.from_hdr.prot =
 					NET_PROT_IP;
+				kg_cfg->extracts[i].extract.from_hdr.hdr_index =
+					hdr_index;
 				kg_cfg->extracts[i].extract.from_hdr.field =
 					NH_FLD_IP_PROTO;
 				kg_cfg->extracts[i].type =
diff --git a/drivers/net/dpaa2/dpaa2_ethdev.c b/drivers/net/dpaa2/dpaa2_ethdev.c
index 803a8321e0..c19736fb80 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.c
+++ b/drivers/net/dpaa2/dpaa2_ethdev.c
@@ -424,7 +424,8 @@ dpaa2_dev_info_get(struct rte_eth_dev *dev,
 	dev_info->max_hash_mac_addrs = 0;
 	dev_info->max_vfs = 0;
 	dev_info->max_vmdq_pools = RTE_ETH_16_POOLS;
-	dev_info->flow_type_rss_offloads = DPAA2_RSS_OFFLOAD_ALL;
+	dev_info->flow_type_rss_offloads = DPAA2_RSS_OFFLOAD_ALL |
+		RTE_ETH_RSS_LEVEL_OUTERMOST | RTE_ETH_RSS_LEVEL_INNERMOST;
 
 	dev_info->default_rxportconf.burst_size = dpaa2_dqrr_size;
 	/* same is rx size for best perf */
-- 
2.43.0

