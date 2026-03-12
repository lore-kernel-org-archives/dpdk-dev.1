Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D767B103E2F5
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Mar 2026 00:21:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B1852410D4;
	Thu, 12 Mar 2026 01:21:35 +0100 (CET)
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com
 [209.85.160.41]) by mails.dpdk.org (Postfix) with ESMTP id 9BDFC40E4D
 for <dev@dpdk.org>; Thu, 12 Mar 2026 01:21:31 +0100 (CET)
Received: by mail-oa1-f41.google.com with SMTP id
 586e51a60fabf-40ee9b945d5so331963fac.0
 for <dev@dpdk.org>; Wed, 11 Mar 2026 17:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1773274891;
 x=1773879691; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lHtFf//xfmBkeSgDwNbgojnphmysX3unR7mUQCFyIxY=;
 b=FUTTJaHnqOh7XZjYqaAXlUENB3/QTn92A732pOVTJtFIJMVT2LMGRrSQaEUb8Wxp6O
 unvuJlguu4RuT5gawr5JTWafal0RSVOX6LnQ4TLT6/f0TbJEhIMW0FKKp0t2T3VEUv0+
 tNtih4L2p1meqza/cwA47Ve0Idy8moEjmoV9p7aWIWPinX8mmvi9Y3nH4DmK8Vti9Uy5
 y875Bh5nRGPpzWMyaQ+sUCQb0HOWU8ctcYQhdFQAbe0Xfb1vcWTtXHDu8SuLB/s0QhQS
 3awB46SVlK6iCXeH0gxBZqf0oRypVR0cz42pxJJ/dPAxNfUqeNGscQ4arjBigqaGcws4
 dqjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773274891; x=1773879691;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lHtFf//xfmBkeSgDwNbgojnphmysX3unR7mUQCFyIxY=;
 b=rRUcss0mYy029I+nunoYHeQhxM2/NZU/detfxm2RxFrWsVUOwguRBiNSNvMWcT8yqz
 DlvPe1MRpau26BHicNM5DnyVQ0dSnAyJcY/Mty1hfnWjKvQVwVlUKeFpsgfEs2OLbM3S
 hpWf/aUrwT13DDicDXHrVxHtSrzhWVCowK9RGeDgYe/G8QdoXjqhcW5TlC5Oxo34YOia
 Hi87L+TxeIgy9Ssz9p7WAd8oBiochbFdIWjvzwmgeGhpSoZfr1MsNuSFxyyZTHMpHHE3
 AvjL4vSG3okB4Gswc2gnX33Ol1R00nl85r9BoWHfr2OxeYR8BCxtFLzVLZm15ctra9hJ
 5FEw==
X-Gm-Message-State: AOJu0YzJfTuEbTw2LikgbPpfYGGzGbZj4Tjeckpb8GncZRGGUqRHFqIp
 0LfbW4lZeQVDH1LTNjdwN/1YHU8OXy+JPug4y5T8J/T1XrSp18qoVrK98n5nVrgaesLkZQKYNmT
 vT/MLO+M=
X-Gm-Gg: ATEYQzyk6P8BB8MI/bRLvxaESAHfUYhn2xcx+JjmBL7lGJV7toc3UikDToYuEDJ9Iio
 VgecH6IVCorfe47oPaZMOgDjMpbBRHVYiHJ3CXRd3wW85AVx1pwWfuu8lQ1m3BTx3DXHdQRmwTL
 PtpYAMDPPPPk9okCfVHpWK6CFnTeF6WJUQqXLfNqghg9g22LOz0aDj0HgZV8/2rRygdOHavffb6
 L4rFIQ6u560uOgZvHJ2MBztxj5ooAo7X9P7DhxHTmjHUbVlqLh7V3lmhX515APphT7j5Sz2Zsb6
 j0TStEC0mF4WaeYSZW9q87LHtO4wWwaKf3OBaVoKYBUEMoDvlGsQsUahvfTVfnZJK+3u7nl64p9
 eOJFrJeW3F2EVL3VnQqZwSQTPMtaF4zZ7lyeWaL+y+eV929xCZukIZfLYuAJ3dSebX97uJOWPEw
 6RlccJooNupeyVfIEfnHi+TaVIKf+fDXX3
X-Received: by 2002:a05:6870:b14e:b0:417:68c7:56a6 with SMTP id
 586e51a60fabf-4177c258494mr2910597fac.0.1773274890766; 
 Wed, 11 Mar 2026 17:21:30 -0700 (PDT)
Received: from phoenix.lan ([104.202.29.139]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4177e26e2c6sm3779484fac.7.2026.03.11.17.21.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Mar 2026 17:21:30 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Kishore Padmanabha <kishore.padmanabha@broadcom.com>,
 Ajit Khaparde <ajit.khaparde@broadcom.com>
Subject: [PATCH 2/2] net/bnxt: fix shadow variable warnings
Date: Wed, 11 Mar 2026 17:20:27 -0700
Message-ID: <20260312002123.867357-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260312002123.867357-1-stephen@networkplumber.org>
References: <20260312002123.867357-1-stephen@networkplumber.org>
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

Fix things flagged as warnings about shadowed variables.
If the variable was harmless overlap then just drop the shadowed
version. For min values case use RTE_MIN3() and RTE_MIN4().

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/bnxt/bnxt.h        | 6 +++---
 drivers/net/bnxt/bnxt_ethdev.c | 3 +--
 drivers/net/bnxt/bnxt_rxq.c    | 6 ++----
 drivers/net/bnxt/bnxt_txr.c    | 3 ---
 4 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/net/bnxt/bnxt.h b/drivers/net/bnxt/bnxt.h
index 7515f0564f..8b81c11b32 100644
--- a/drivers/net/bnxt/bnxt.h
+++ b/drivers/net/bnxt/bnxt.h
@@ -1110,9 +1110,9 @@ inline uint16_t bnxt_max_rings(struct bnxt *bp)
 	 * max Tx rings == max Rx rings, one stat ctx for each.
 	 */
 	if (BNXT_STINGRAY(bp)) {
-		max_rx_rings = RTE_MIN(RTE_MIN(max_rx_rings / 2U,
-					       MAX_STINGRAY_RINGS),
-				       bp->max_stat_ctx / 2U);
+		max_rx_rings = RTE_MIN3(max_rx_rings / 2U,
+					MAX_STINGRAY_RINGS,
+					bp->max_stat_ctx / 2U);
 	} else {
 		max_rx_rings = RTE_MIN(max_rx_rings / 2U,
 				       bp->max_stat_ctx / 2U);
diff --git a/drivers/net/bnxt/bnxt_ethdev.c b/drivers/net/bnxt/bnxt_ethdev.c
index b677f9491d..f033c34aab 100644
--- a/drivers/net/bnxt/bnxt_ethdev.c
+++ b/drivers/net/bnxt/bnxt_ethdev.c
@@ -473,7 +473,7 @@ static int bnxt_setup_one_vnic(struct bnxt *bp, uint16_t vnic_id)
 
 	/* Alloc RSS context only if RSS mode is enabled */
 	if (dev_conf->rxmode.mq_mode & RTE_ETH_MQ_RX_RSS) {
-		int j, nr_ctxs = bnxt_rss_ctxts(bp);
+		unsigned int nr_ctxs = bnxt_rss_ctxts(bp);
 
 		/* RSS table size in P5 is 512.
 		 * Cap max Rx rings to same value
@@ -3560,7 +3560,6 @@ bnxt_rx_descriptor_status_op(void *rx_queue, uint16_t offset)
 	 */
 #if defined(RTE_ARCH_X86) || defined(RTE_ARCH_ARM64)
 	if (bp->flags & BNXT_FLAG_RX_VECTOR_PKT_MODE) {
-		struct rx_pkt_cmpl *rxcmp;
 		uint32_t cons;
 
 		/* Check status of completion descriptor. */
diff --git a/drivers/net/bnxt/bnxt_rxq.c b/drivers/net/bnxt/bnxt_rxq.c
index 91b3555df6..df9ed391c4 100644
--- a/drivers/net/bnxt/bnxt_rxq.c
+++ b/drivers/net/bnxt/bnxt_rxq.c
@@ -98,10 +98,8 @@ int bnxt_mq_rx_configure(struct bnxt *bp)
 			/* ETH_8/64_POOLs */
 			pools = conf->nb_queue_pools;
 			/* For each pool, allocate MACVLAN CFA rule & VNIC */
-			max_pools = RTE_MIN(bp->max_vnics,
-					    RTE_MIN(bp->max_l2_ctx,
-					    RTE_MIN(bp->max_rsscos_ctx,
-						    RTE_ETH_64_POOLS)));
+			max_pools = RTE_MIN4(bp->max_vnics, bp->max_l2_ctx,
+					    bp->max_rsscos_ctx, RTE_ETH_64_POOLS);
 			PMD_DRV_LOG_LINE(DEBUG,
 				    "pools = %u max_pools = %u",
 				    pools, max_pools);
diff --git a/drivers/net/bnxt/bnxt_txr.c b/drivers/net/bnxt/bnxt_txr.c
index 27758898b0..498778aae0 100644
--- a/drivers/net/bnxt/bnxt_txr.c
+++ b/drivers/net/bnxt/bnxt_txr.c
@@ -179,9 +179,6 @@ bnxt_check_pkt_needs_ts(struct rte_mbuf *m)
 		if (proto == RTE_ETHER_TYPE_ECPRI)
 			return true;
 		if (proto == RTE_ETHER_TYPE_VLAN) {
-			const struct rte_vlan_hdr *vh;
-			struct rte_vlan_hdr vh_copy;
-
 			vh = rte_pktmbuf_read(m, off, sizeof(*vh), &vh_copy);
 			if (unlikely(vh == NULL))
 				return false;
-- 
2.51.0

