Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9154CD6E43
	for <dpdk-dev@archiver.kernel.org>; Fri, 29 May 2026 00:02:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B223C40395;
	Fri, 29 May 2026 02:02:05 +0200 (CEST)
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com
 [74.125.82.180]) by mails.dpdk.org (Postfix) with ESMTP id E2ECD40264
 for <dev@dpdk.org>; Fri, 29 May 2026 02:02:02 +0200 (CEST)
Received: by mail-dy1-f180.google.com with SMTP id
 5a478bee46e88-304e83724bfso527901eec.0
 for <dev@dpdk.org>; Thu, 28 May 2026 17:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1780012922;
 x=1780617722; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RDoN1kWYZDVya8dZ3g2qb3NFCUdGwv3zFX7bN5drG+g=;
 b=o+MCR/mVPJucSGKYeQ2zTA5mYYl2yzMtTPrZrNHY/1WRjTh9s+IMQuxWEX5nL6C7kg
 Ravs8hZ6JTs98vVj8J+3BWy2jJznKYGCWCV9UGuUctGPsdpUdDxnIPmXun00TrZBVpNW
 ZEHDVsy3lqpkbCK2botmuAU6bZYl4zj4mHmKlLj1y6L15ZGOTMMIh3E46+EcbUNqZnQQ
 GjzA1EFuSsH2GxkBb7FmQsh5Fx10gWMwMBYYdT7ocEaSUeW3KhnUnpv88f2gSCDzlS2U
 GFg14d+vsC4ZoajbXGourExsBR6o4c+Oooy1R9wBpssA61fX31xdKBntJ31jguSvt0zM
 Afiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780012922; x=1780617722;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RDoN1kWYZDVya8dZ3g2qb3NFCUdGwv3zFX7bN5drG+g=;
 b=r4yWlPt9VDwQJE7mbViq63GUHLHSyUU/fAfCy5sC0yiCUW68S2PuAYEMCTzhZz9i/y
 tsmlCOKcSAw4MMa5tHFaGIGcbiD3oXQ/kcgNA1HAYNaDWV3UPLN5PrpcOHst27MCz8eF
 x3dLBHTcfvRhcpPv0XnwcZBZ8tl2s2gFZlL9WtXRxyfadiVOmei3JNz2YtoBK16gNs+6
 OMzk1cPhkJ+GoL1fAVySJEQujL81vI+6KEUuS7O6kL5l5T2HQu9TOV2WnmO8csIDuAvd
 qQ7LG8tGGrCfzf+kb8I4CVFc4mzBKwIQH4AHN4hsoLD7UMstCRugJ0rwKpcK/CPeJDIH
 iaFA==
X-Gm-Message-State: AOJu0YzptYkW4voYwiJdGxjzqQbfJgU3HjdrLR7kfT+PJp2vBDJ8Fwk2
 Pj2j1vm91eTbYkrFYpddnoboacCjXCdHPfMh+02C32RO26s/3KDBeNBV/gX9jUNd7sdEBYFEa6g
 YdoPR
X-Gm-Gg: Acq92OHrRA96IutMlDxlwiN1j7djKOo4SFSgi1m4eTx0JPP5eyJSAAvz7Brp7crRvz1
 Z72tgZiK5z0g1xRjNMX45zyz+KOSzRRAZ4RVyraxv862SP5v0L8NT+bBRiky0HB1qV0aCL05wFu
 qtgslOtcs8b13N8mloVnmPU9ngix/S27a3hZCaDj3ktSSNGWFV0OIxWIsBy6z6x6qjzEMDUM8Tn
 iM3up/YjVqJ0BHLRnKAf/bzUDBGKfqMzMW3MAd3oSQ1P1FfZRjNM6AvBZ8SS50Q0h7UakyhLDQ2
 HU8K+9CVBejXJdq7nOW1uQagmlf4JhH9RBZiNThVI1tHsTeBj47E7zUyRYzMgmD3wVpBmIDvwHc
 GR/GZ5zgx/BTExY0uGZeCfghTXrkiAt/2GXy7nEwXlfXmL+BRIdkQrQPMJHRIqtCmaJsdReKy7V
 HJKnUWH+5Gxq6I+EsTxKHd5r2oW3eg9D+iAThcvSxdNQqcdrvGemH9t36iVAEA8fUslkJfmsbc
X-Received: by 2002:a05:7300:3213:b0:304:ccdd:594a with SMTP id
 5a478bee46e88-304ead90e5dmr380600eec.5.1780012921475; 
 Thu, 28 May 2026 17:02:01 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-304ed5d5385sm53076eec.28.2026.05.28.17.02.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2026 17:02:01 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Chas Williams <3chas3@gmail.com>, "Min Hu (Connor)" <humin29@huawei.com>
Subject: [PATCH v2 1/4] net/bonding: make 8023ad enable function void
Date: Thu, 28 May 2026 16:59:13 -0700
Message-ID: <20260529000157.235931-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260529000157.235931-1-stephen@networkplumber.org>
References: <20260417165530.653328-1-stephen@networkplumber.org>
 <20260529000157.235931-1-stephen@networkplumber.org>
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

The function never returns an error. Cleanup the call sites.

The 8023ad disable function was never implemented,
remove prototype.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/bonding/eth_bond_8023ad_private.h | 17 +----------------
 drivers/net/bonding/rte_eth_bond_8023ad.c     |  4 +---
 drivers/net/bonding/rte_eth_bond_pmd.c        |  7 +++----
 3 files changed, 5 insertions(+), 23 deletions(-)

diff --git a/drivers/net/bonding/eth_bond_8023ad_private.h b/drivers/net/bonding/eth_bond_8023ad_private.h
index ab7d15f81a..bd7a5848de 100644
--- a/drivers/net/bonding/eth_bond_8023ad_private.h
+++ b/drivers/net/bonding/eth_bond_8023ad_private.h
@@ -209,25 +209,10 @@ bond_mode_8023ad_setup(struct rte_eth_dev *dev,
  * @internal
  *
  * Enables 802.1AX mode and all active members on bonding interface.
- *
- * @param dev Bonding interface
- * @return
- *  0 on success, negative value otherwise.
  */
-int
+void
 bond_mode_8023ad_enable(struct rte_eth_dev *dev);
 
-/**
- * @internal
- *
- * Disables 802.1AX mode of the bonding interface and members.
- *
- * @param dev Bonding interface
- * @return
- *   0 on success, negative value otherwise.
- */
-int bond_mode_8023ad_disable(struct rte_eth_dev *dev);
-
 /**
  * @internal
  *
diff --git a/drivers/net/bonding/rte_eth_bond_8023ad.c b/drivers/net/bonding/rte_eth_bond_8023ad.c
index ba88f6d261..eba713e381 100644
--- a/drivers/net/bonding/rte_eth_bond_8023ad.c
+++ b/drivers/net/bonding/rte_eth_bond_8023ad.c
@@ -1287,7 +1287,7 @@ bond_mode_8023ad_setup(struct rte_eth_dev *dev,
 		bond_mode_8023ad_start(dev);
 }
 
-int
+void
 bond_mode_8023ad_enable(struct rte_eth_dev *bond_dev)
 {
 	struct bond_dev_private *internals = bond_dev->data->dev_private;
@@ -1296,8 +1296,6 @@ bond_mode_8023ad_enable(struct rte_eth_dev *bond_dev)
 	for (i = 0; i < internals->active_member_count; i++)
 		bond_mode_8023ad_activate_member(bond_dev,
 				internals->active_members[i]);
-
-	return 0;
 }
 
 int
diff --git a/drivers/net/bonding/rte_eth_bond_pmd.c b/drivers/net/bonding/rte_eth_bond_pmd.c
index 96725071da..7fcb3ec7d7 100644
--- a/drivers/net/bonding/rte_eth_bond_pmd.c
+++ b/drivers/net/bonding/rte_eth_bond_pmd.c
@@ -1619,8 +1619,7 @@ bond_ethdev_mode_set(struct rte_eth_dev *eth_dev, uint8_t mode)
 		eth_dev->rx_pkt_burst = bond_ethdev_rx_burst;
 		break;
 	case BONDING_MODE_8023AD:
-		if (bond_mode_8023ad_enable(eth_dev) != 0)
-			return -1;
+		bond_mode_8023ad_enable(eth_dev);
 
 		if (internals->mode4.dedicated_queues.enabled == 0) {
 			eth_dev->rx_pkt_burst = bond_ethdev_rx_burst_8023ad;
@@ -1641,13 +1640,13 @@ bond_ethdev_mode_set(struct rte_eth_dev *eth_dev, uint8_t mode)
 		eth_dev->rx_pkt_burst = bond_ethdev_rx_burst_active_backup;
 		break;
 	case BONDING_MODE_ALB:
-		if (bond_mode_alb_enable(eth_dev) != 0)
-			return -1;
+		bond_mode_alb_enable(eth_dev);
 
 		eth_dev->tx_pkt_burst = bond_ethdev_tx_burst_alb;
 		eth_dev->rx_pkt_burst = bond_ethdev_rx_burst_alb;
 		break;
 	default:
+		RTE_BOND_LOG(ERR, "Invalid mode %#x", mode);
 		return -1;
 	}
 
-- 
2.53.0

