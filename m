Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AFA3D44C59
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 Jan 2026 14:41:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 89BF1427E4;
	Thu, 15 Jan 2026 15:41:17 +0100 (CET)
Received: from office2.cesnet.cz (office2.cesnet.cz [78.128.248.237])
 by mails.dpdk.org (Postfix) with ESMTP id 4B7A1410E3
 for <dev@dpdk.org>; Thu, 15 Jan 2026 15:41:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cesnet.cz;
 s=office2-2020; t=1768488070;
 bh=+q2nEyUh17YNhQcs3ne7IkPe5AyKHFnT0DOKXwspicU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=dTzVChkhve4+KEyhndPNEKN3SqXb3NhuqJ3cuJjce3Rgeg09i9n349o5LK0YTTV2I
 KWMzzSHnv5U/VS5/hddcahJLD+fuqGPjcd+ul1r5LbXMepOm/wDXjS3/Rue4gPknHL
 R7sCvuvdgNKFvKwpNTj2+HQA9JV7o3ZS4YHnvQzT/7AwcqyYcQXUnLwrsT/K0JHs6+
 TApr3wTXBrvpmFX5tNWzr9mLWWZxgXi9ozjBuBDcGEUDxMhWfru7VdZLGipsdVy692
 HtOUybkTLTpxCDURAMIVtv4upgMzkhayT56W7h7snR0mu5aQtm4LEDHaVbvuq+u8AP
 m9MSidMj37/+A==
Received: from emil.cesnet.cz (gtx107.cesnet.cz [IPv6:2001:718:812:27::107])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by office2.cesnet.cz (Postfix) with ESMTPSA id 21ECC1180072;
 Thu, 15 Jan 2026 15:41:10 +0100 (CET)
From: spinler@cesnet.cz
To: dev@dpdk.org
Cc: Martin Spinler <spinler@cesnet.cz>
Subject: [PATCH v2 6/6] net/nfb: stop only started queues in fail path
Date: Thu, 15 Jan 2026 15:40:40 +0100
Message-ID: <20260115144040.345873-7-spinler@cesnet.cz>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260115144040.345873-1-spinler@cesnet.cz>
References: <20260115140134.235877-1-spinler@cesnet.cz>
 <20260115144040.345873-1-spinler@cesnet.cz>
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

From: Martin Spinler <spinler@cesnet.cz>

The driver should stop only running queues in case of error
inside eth_dev_start.

Signed-off-by: Martin Spinler <spinler@cesnet.cz>
---
 drivers/net/nfb/nfb_ethdev.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/net/nfb/nfb_ethdev.c b/drivers/net/nfb/nfb_ethdev.c
index 23f3896c36..74728f91dd 100644
--- a/drivers/net/nfb/nfb_ethdev.c
+++ b/drivers/net/nfb/nfb_ethdev.c
@@ -140,11 +140,12 @@ nfb_eth_dev_start(struct rte_eth_dev *dev)
 	return 0;
 
 err_tx:
-	for (i = 0; i < nb_tx; i++)
-		nfb_eth_tx_queue_stop(dev, i);
+	for (; i > 0; i--)
+		nfb_eth_tx_queue_stop(dev, i - 1);
+	i = nb_rx;
 err_rx:
-	for (i = 0; i < nb_rx; i++)
-		nfb_eth_rx_queue_stop(dev, i);
+	for (; i > 0; i--)
+		nfb_eth_rx_queue_stop(dev, i - 1);
 	return ret;
 }
 
-- 
2.52.0

