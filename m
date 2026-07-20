Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A54DDC4452A
	for <dpdk-dev@archiver.kernel.org>; Mon, 20 Jul 2026 13:34:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5574840664;
	Mon, 20 Jul 2026 15:34:43 +0200 (CEST)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48]) by mails.dpdk.org (Postfix) with ESMTP id 9EBB7402A2
 for <dev@dpdk.org>; Mon, 20 Jul 2026 15:34:41 +0200 (CEST)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-493f75f7172so79589005e9.1
 for <dev@dpdk.org>; Mon, 20 Jul 2026 06:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784554481; x=1785159281; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=AU09kgzihS+j95orVrKmJe1Jp7jiZo4OfNMFUgTOr+U=;
 b=Ow4CQMcUXnNvLpkmJ7abkNCMikbPrB6PTyRi8ufHpkuIdpYbMU7DvRiPKaRehwJ100
 C2TOZdt/yHFk9dJDEG/tnuWgvdvM4zib/vowoVH7cE9nl2w0cG4jW0glyw/RuKKy9uXI
 tDEe7S1E4cgOENU77tqZBVUt/ArfvIdgL1080v+0sOtLNjcifmmuxTc1Usa/iDKqLlVn
 LtF2WIIfoeitOZoMiJi2PL8TiTrK/UHNWgMDGp7YwVTYyoAN5ZN8PK31BXcrJt5qmLl8
 N6MtGpZL7vv9RnhbJO4wxh64Siwc+MqSSErphy04EoHPHNrOKD5bImsfK0K0oF5FKRy3
 AXhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784554481; x=1785159281;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=AU09kgzihS+j95orVrKmJe1Jp7jiZo4OfNMFUgTOr+U=;
 b=Afv7ipMNnpQwVSyYKkQvu6csyZezqkPrY1jpYG0zePKNlCCafJN/rPPKCV3L8eMeVl
 bVjBph3DROccNBbEng7ufwasFWHWU28zuAJ91SPqNBjLkpxMj0Dkcs5HnxzlpLHR6qMj
 95iscYY/dJiOQbwOTAG+taxX5VdIeYJN9PH40FiusqigCEhh5oTdlwCDS8BaL44P9IEA
 s18rRppzXWdmY2MKmBuDML01+Lpwr90IRfJ5/uk7tc1DKCTR+KV1AKlHaZaNyuQiBIv9
 FTZxFgXdwM2CISb1+XtwvdoZI5nFcMhlv2g2F2SdQM6UOGzfOc/jvPbf+oyoT3n0+AhP
 lvQg==
X-Gm-Message-State: AOJu0Yw2MWBUwxl34TjHpdAd1wJqoeBbswvhxEMsnm5Eq250jFUwHA06
 7m2r3tKXt6KaoPisA/LaeZXPde8XVGRRrnjYcitnVEuYt9Jwvhp4B1guUDY/3yfD
X-Gm-Gg: AfdE7clKJdy8c3mlxIPnM9LIBJaUyT3C0Rh3reIZRIwXlIJoH1fs8V1BKA1hvD07Daq
 wxhMrjt0wJYxjhDWm4uLhJw6Ji91U4kbmqCnp0VdBKPNfSGxPSFgb6PfhuyXB3MMmrS10vzYCLW
 sTkYRwh2oFCLomSCoe70lINOcCeKZsj0Y8S78F3ysMzaR+SE1E2TyuP9SGFCvgn+3DUsuTD2LY7
 aLfouUZ0z+buh3ulsImaYDMCk9z72HrH10aha5ZeTpeecYTkFKDBjU+Wpc9eoTIzUXyUiEGTfEh
 vynoYFtPKCRSg2rSFQUQqiEDc/fUNKQGJ1K/hJ2H5E5d72vQQWz4ax1VWzanWpldAIJOKed8k32
 yAnxQcZRdc6jtupY3T9txo4tdskRvgt3gpZ9vf6cW7ovMPnAgIDTTIwPf13TYlOzXJ/cBHBS7Qt
 kINcv45tUpQ+uCclFB7gevSJa7Jvtgz3BVJFUQUzaNQgTLROADadc=
X-Received: by 2002:a05:600c:1382:b0:495:699:5c8b with SMTP id
 5b1f17b1804b1-4954a3e206dmr151585695e9.7.1784554481134; 
 Mon, 20 Jul 2026 06:34:41 -0700 (PDT)
Received: from freepad.sicorp.iliad.local (free-mobile.vlq16.iliad.fr.
 [213.36.7.11]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49549a3f07esm272407755e9.6.2026.07.20.06.34.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 06:34:40 -0700 (PDT)
Sender: Maxime Leroy <maxime.leroys@gmail.com>
From: Maxime Leroy <maxime@leroys.fr>
To: dev@dpdk.org
Cc: thomas@monjalon.net, david.marchand@redhat.com, hemant.agrawal@oss.nxp.com,
 Maxime Leroy <maxime@leroys.fr>
Subject: [PATCH v1 1/2] net/dpaa2: revert inner RSS level support
Date: Mon, 20 Jul 2026 15:34:35 +0200
Message-ID: <20260720133436.869334-2-maxime@leroys.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260630123857.392884-1-maxime@leroys.fr>
References: <20260630123857.392884-1-maxime@leroys.fr>
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

This reverts commit 618a06c53d479ae576ff01c7d274b10c60b3d3d5.

RTE_ETH_RSS_LEVEL_INNERMOST was mapped to the innermost IP instance by
programming the IP key extracts with hdr_index = HDR_INDEX_LAST. The
hardware only resolves that index when several IP headers are stacked.
A non-tunnelled frame carries a single IP header, so the extract
resolves to nothing, the RSS hash is constant and every such frame is
steered to a single Rx queue.

The ethdev API defines INNERMOST by encapsulation level, not by the
presence of a tunnel: a plain frame's innermost header is its only IP
header and must be hashed. The dpaa2 hardware cannot honour that and
keep true inner-only semantics for tunnelled traffic at the same time,
so the level cannot be implemented correctly as merged.

Revert it. Hashing the outer plus the inner IP under the PMD default
level, which spreads both plain and tunnelled traffic, is added in a
follow-up.

Signed-off-by: Maxime Leroy <maxime@leroys.fr>
---
 doc/guides/rel_notes/release_26_07.rst |  1 -
 drivers/net/dpaa2/base/dpaa2_hw_dpni.c | 23 -----------------------
 drivers/net/dpaa2/dpaa2_ethdev.c       |  3 +--
 3 files changed, 1 insertion(+), 26 deletions(-)

diff --git a/doc/guides/rel_notes/release_26_07.rst b/doc/guides/rel_notes/release_26_07.rst
index 6badd6d91b..6a528e4a0d 100644
--- a/doc/guides/rel_notes/release_26_07.rst
+++ b/doc/guides/rel_notes/release_26_07.rst
@@ -162,7 +162,6 @@ New Features
 
 * **Updated NXP dpaa2 driver.**
 
-  * Added inner RSS level support for tunnelled traffic.
   * Added RSS RETA query and update support.
   * Removed the software VLAN strip offload:
     ``RTE_ETH_RX_OFFLOAD_VLAN_STRIP`` is no longer advertised,
diff --git a/drivers/net/dpaa2/base/dpaa2_hw_dpni.c b/drivers/net/dpaa2/base/dpaa2_hw_dpni.c
index 07f4a3d414..26ad105c73 100644
--- a/drivers/net/dpaa2/base/dpaa2_hw_dpni.c
+++ b/drivers/net/dpaa2/base/dpaa2_hw_dpni.c
@@ -236,13 +236,6 @@ dpaa2_remove_flow_dist(struct rte_eth_dev *eth_dev,
 	return ret;
 }
 
-/* dpkg from_hdr.hdr_index value selecting the innermost IP instance (see
- * fsl_dpkg.h, where hdr_index is only defined for NET_PROT_IP/IPv4/IPv6/
- * VLAN/MPLS). Used to hash on the inner IP of tunnelled traffic when
- * RTE_ETH_RSS_LEVEL_INNERMOST is requested.
- */
-#define DPAA2_DIST_HDR_INDEX_LAST 0xff
-
 int
 dpaa2_distset_to_dpkg_profile_cfg(
 		uint64_t req_dist_set,
@@ -257,18 +250,8 @@ dpaa2_distset_to_dpkg_profile_cfg(
 	int esp_configured = 0;
 	int ah_configured = 0;
 	int pppoe_configured = 0;
-	uint8_t hdr_index = 0;
 
 	memset(kg_cfg, 0, sizeof(struct dpkg_profile_cfg));
-
-	/* RTE_ETH_RSS_LEVEL_INNERMOST asks for the inner header to be hashed.
-	 * Map it to the innermost IP instance in the key extracts; the level
-	 * bits are not protocol bits, so strip them before the loop.
-	 */
-	if ((req_dist_set & RTE_ETH_RSS_LEVEL_MASK) == RTE_ETH_RSS_LEVEL_INNERMOST)
-		hdr_index = DPAA2_DIST_HDR_INDEX_LAST;
-	req_dist_set &= ~RTE_ETH_RSS_LEVEL_MASK;
-
 	while (req_dist_set) {
 		if (req_dist_set % 2 != 0) {
 			dist_field = 1ULL << loop;
@@ -406,8 +389,6 @@ dpaa2_distset_to_dpkg_profile_cfg(
 
 				kg_cfg->extracts[i].extract.from_hdr.prot =
 					NET_PROT_IP;
-				kg_cfg->extracts[i].extract.from_hdr.hdr_index =
-					hdr_index;
 				kg_cfg->extracts[i].extract.from_hdr.field =
 					NH_FLD_IP_SRC;
 				kg_cfg->extracts[i].type =
@@ -418,8 +399,6 @@ dpaa2_distset_to_dpkg_profile_cfg(
 
 				kg_cfg->extracts[i].extract.from_hdr.prot =
 					NET_PROT_IP;
-				kg_cfg->extracts[i].extract.from_hdr.hdr_index =
-					hdr_index;
 				kg_cfg->extracts[i].extract.from_hdr.field =
 					NH_FLD_IP_DST;
 				kg_cfg->extracts[i].type =
@@ -430,8 +409,6 @@ dpaa2_distset_to_dpkg_profile_cfg(
 
 				kg_cfg->extracts[i].extract.from_hdr.prot =
 					NET_PROT_IP;
-				kg_cfg->extracts[i].extract.from_hdr.hdr_index =
-					hdr_index;
 				kg_cfg->extracts[i].extract.from_hdr.field =
 					NH_FLD_IP_PROTO;
 				kg_cfg->extracts[i].type =
diff --git a/drivers/net/dpaa2/dpaa2_ethdev.c b/drivers/net/dpaa2/dpaa2_ethdev.c
index 53ea060a4c..f211357919 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.c
+++ b/drivers/net/dpaa2/dpaa2_ethdev.c
@@ -453,8 +453,7 @@ dpaa2_dev_info_get(struct rte_eth_dev *dev,
 	dev_info->max_hash_mac_addrs = 0;
 	dev_info->max_vfs = 0;
 	dev_info->max_vmdq_pools = RTE_ETH_16_POOLS;
-	dev_info->flow_type_rss_offloads = DPAA2_RSS_OFFLOAD_ALL |
-		RTE_ETH_RSS_LEVEL_OUTERMOST | RTE_ETH_RSS_LEVEL_INNERMOST;
+	dev_info->flow_type_rss_offloads = DPAA2_RSS_OFFLOAD_ALL;
 	/* DPAA2 has no software-visible indirection table: incoming packets are
 	 * dispatched to FQs via 'queue_id = hash % dist_size'. We expose the
 	 * standard RETA API as an emulation that only accepts uniform patterns
-- 
2.43.0

