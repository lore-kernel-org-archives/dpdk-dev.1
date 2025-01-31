Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8C8BC0218D
	for <dpdk-dev@archiver.kernel.org>; Fri, 31 Jan 2025 08:05:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B930B402DC;
	Fri, 31 Jan 2025 09:05:38 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 4C5084026E
 for <dev@dpdk.org>; Fri, 31 Jan 2025 09:05:37 +0100 (CET)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50V70SKS004964
 for <dev@dpdk.org>; Fri, 31 Jan 2025 00:05:36 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pfpt0220; bh=GP+nU780smYE4EnUlD9U5Oj
 6cyjIwugFgiamLJt1B7w=; b=XvV6Mvj3RjNsDnPtXQ3Xc2jiPsYuYmsEzm+fAy+
 HQbbqfq2LFWGc8XmqrD4ErvoNJ1RZhh5OZQI65AKN6v6XyfYOP/niBJMs7KpYHt/
 wOS5N4EnaqwcvbnvuoGqIuaoSZQYfcB4H7NQw2EJZchw8DbdwEW1/RdCTsIcfwHQ
 jWmOEAcylRoWnIA/e9/YxAJ6lSdeaSSGF8itM34nfz0rXwQo/Hrg++hMDbPSpxsm
 Ds4y5sfltg+z9IGTYWGsEsuh9s2TUwlS6CiPmxYzGJ92WM/G7iBckHHAKxfhCKpB
 PsIZFV0JVcwhNwlOO4pzaqYZIZeIFHT7moAhzG49ENhQm5g==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 44gsr3g2xr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Fri, 31 Jan 2025 00:05:36 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 31 Jan 2025 00:05:35 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 31 Jan 2025 00:05:35 -0800
Received: from hyd1588t430.caveonetworks.com (unknown [10.29.52.204])
 by maili.marvell.com (Postfix) with ESMTP id 42A1E3F707D;
 Fri, 31 Jan 2025 00:05:33 -0800 (PST)
From: Nithin Dabilpuram <ndabilpuram@marvell.com>
To: <jerinj@marvell.com>, Nithin Dabilpuram <ndabilpuram@marvell.com>, "Kiran
 Kumar K" <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>,
 Satha Rao <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <dev@dpdk.org>
Subject: [PATCH 01/34] net/cnxk: allow duplicate SPI in outbound IPsec
Date: Fri, 31 Jan 2025 13:34:56 +0530
Message-ID: <20250131080530.3224977-1-ndabilpuram@marvell.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: Xg8Agi7USs1gOXb59Y1WnCLKSmg06808
X-Proofpoint-GUID: Xg8Agi7USs1gOXb59Y1WnCLKSmg06808
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-31_03,2025-01-30_01,2024-11-22_01
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

Since outbound IPsec is not really dependent on SPI,
allow duplicate SPI in outbound inline IPsec sessions.

Signed-off-by: Nithin Dabilpuram <ndabilpuram@marvell.com>
---

Depends-on: series-34428 ("[v4,1/2] common/cnxk: support NPC flow on cn20k")

 drivers/net/cnxk/cn10k_ethdev_sec.c | 14 +++++++-------
 drivers/net/cnxk/cn9k_ethdev_sec.c  | 14 +++++++-------
 drivers/net/cnxk/cnxk_ethdev.h      |  4 ++--
 drivers/net/cnxk/cnxk_ethdev_sec.c  |  8 ++++++--
 4 files changed, 22 insertions(+), 18 deletions(-)

diff --git a/drivers/net/cnxk/cn10k_ethdev_sec.c b/drivers/net/cnxk/cn10k_ethdev_sec.c
index 6acab8afa0..41dfba36d3 100644
--- a/drivers/net/cnxk/cn10k_ethdev_sec.c
+++ b/drivers/net/cnxk/cn10k_ethdev_sec.c
@@ -793,13 +793,6 @@ cn10k_eth_sec_session_create(void *device,
 	inbound = !!(ipsec->direction == RTE_SECURITY_IPSEC_SA_DIR_INGRESS);
 	inl_dev = !!dev->inb.inl_dev;
 
-	/* Search if a session already exits */
-	if (cnxk_eth_sec_sess_get_by_spi(dev, ipsec->spi, inbound)) {
-		plt_err("%s SA with SPI %u already in use",
-			inbound ? "Inbound" : "Outbound", ipsec->spi);
-		return -EEXIST;
-	}
-
 	memset(eth_sec, 0, sizeof(struct cnxk_eth_sec_sess));
 	sess_priv.u64 = 0;
 
@@ -821,6 +814,13 @@ cn10k_eth_sec_session_create(void *device,
 
 		spi_mask = roc_nix_inl_inb_spi_range(nix, inl_dev, NULL, NULL);
 
+		/* Search if a session already exits */
+		if (cnxk_eth_sec_sess_get_by_sa_idx(dev, ipsec->spi & spi_mask, true)) {
+			plt_err("Inbound SA with SPI/SA index %u already in use", ipsec->spi);
+			rc = -EEXIST;
+			goto err;
+		}
+
 		/* Get Inbound SA from NIX_RX_IPSEC_SA_BASE */
 		sa = roc_nix_inl_inb_sa_get(nix, inl_dev, ipsec->spi);
 		if (!sa && dev->inb.inl_dev) {
diff --git a/drivers/net/cnxk/cn9k_ethdev_sec.c b/drivers/net/cnxk/cn9k_ethdev_sec.c
index 390853c728..5e13dc862e 100644
--- a/drivers/net/cnxk/cn9k_ethdev_sec.c
+++ b/drivers/net/cnxk/cn9k_ethdev_sec.c
@@ -604,13 +604,6 @@ cn9k_eth_sec_session_create(void *device,
 	crypto = conf->crypto_xform;
 	inbound = !!(ipsec->direction == RTE_SECURITY_IPSEC_SA_DIR_INGRESS);
 
-	/* Search if a session already exists */
-	if (cnxk_eth_sec_sess_get_by_spi(dev, ipsec->spi, inbound)) {
-		plt_err("%s SA with SPI %u already in use",
-			inbound ? "Inbound" : "Outbound", ipsec->spi);
-		return -EEXIST;
-	}
-
 	lock = inbound ? &dev->inb.lock : &dev->outb.lock;
 	rte_spinlock_lock(lock);
 
@@ -633,6 +626,13 @@ cn9k_eth_sec_session_create(void *device,
 
 		spi_mask = roc_nix_inl_inb_spi_range(nix, false, NULL, NULL);
 
+		/* Search if a session already exits */
+		if (cnxk_eth_sec_sess_get_by_sa_idx(dev, ipsec->spi & spi_mask, true)) {
+			plt_err("Inbound SA with SPI/SA index %u already in use", ipsec->spi);
+			rc = -EEXIST;
+			goto err;
+		}
+
 		/* Get Inbound SA from NIX_RX_IPSEC_SA_BASE. Assume no inline
 		 * device always for CN9K.
 		 */
diff --git a/drivers/net/cnxk/cnxk_ethdev.h b/drivers/net/cnxk/cnxk_ethdev.h
index 350adc1161..eae5336a9b 100644
--- a/drivers/net/cnxk/cnxk_ethdev.h
+++ b/drivers/net/cnxk/cnxk_ethdev.h
@@ -729,8 +729,8 @@ typedef void (*cnxk_ethdev_rx_offload_cb_t)(uint16_t port_id, uint64_t flags);
 __rte_internal
 void cnxk_ethdev_rx_offload_cb_register(cnxk_ethdev_rx_offload_cb_t cb);
 
-struct cnxk_eth_sec_sess *cnxk_eth_sec_sess_get_by_spi(struct cnxk_eth_dev *dev,
-						       uint32_t spi, bool inb);
+struct cnxk_eth_sec_sess *cnxk_eth_sec_sess_get_by_sa_idx(struct cnxk_eth_dev *dev,
+							  uint32_t sa_idx, bool inb);
 struct cnxk_eth_sec_sess *
 cnxk_eth_sec_sess_get_by_sess(struct cnxk_eth_dev *dev,
 			      struct rte_security_session *sess);
diff --git a/drivers/net/cnxk/cnxk_ethdev_sec.c b/drivers/net/cnxk/cnxk_ethdev_sec.c
index ef75e5f0f1..2c649c985a 100644
--- a/drivers/net/cnxk/cnxk_ethdev_sec.c
+++ b/drivers/net/cnxk/cnxk_ethdev_sec.c
@@ -231,6 +231,10 @@ cnxk_eth_outb_sa_idx_get(struct cnxk_eth_dev *dev, uint32_t *idx_p,
 		if (spi > dev->outb.max_sa)
 			return -ENOTSUP;
 		idx = spi;
+		if (!plt_bitmap_get(dev->outb.sa_bmap, idx)) {
+			plt_err("Outbound SA index %u already in use", idx);
+			return -EEXIST;
+		}
 	} else {
 		/* Scan bitmap to get the free sa index */
 		rc = plt_bitmap_scan(dev->outb.sa_bmap, &pos, &slab);
@@ -265,14 +269,14 @@ cnxk_eth_outb_sa_idx_put(struct cnxk_eth_dev *dev, uint32_t idx)
 }
 
 struct cnxk_eth_sec_sess *
-cnxk_eth_sec_sess_get_by_spi(struct cnxk_eth_dev *dev, uint32_t spi, bool inb)
+cnxk_eth_sec_sess_get_by_sa_idx(struct cnxk_eth_dev *dev, uint32_t sa_idx, bool inb)
 {
 	struct cnxk_eth_sec_sess_list *list;
 	struct cnxk_eth_sec_sess *eth_sec;
 
 	list = inb ? &dev->inb.list : &dev->outb.list;
 	TAILQ_FOREACH(eth_sec, list, entry) {
-		if (eth_sec->spi == spi)
+		if (eth_sec->sa_idx == sa_idx)
 			return eth_sec;
 	}
 
-- 
2.34.1

