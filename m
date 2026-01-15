Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEF45D44C4F
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 Jan 2026 14:02:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 83A9F427C9;
	Thu, 15 Jan 2026 15:02:03 +0100 (CET)
Received: from office2.cesnet.cz (office2.cesnet.cz [78.128.248.237])
 by mails.dpdk.org (Postfix) with ESMTP id C8C0441153
 for <dev@dpdk.org>; Thu, 15 Jan 2026 15:01:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cesnet.cz;
 s=office2-2020; t=1768485717;
 bh=tmxtNZqtrNu/yC+2yRzUWPP4o1uj2AcjkQ2oj7WOoAI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=bClnaAli4CVK+6u1c/UKJxauMi9uRGH0vQMVvVn3te8KtmNYD/VW/X7OXyfvIfZMK
 JfaB9UgetO7jRL2BCPXElxM85bqGR9vrbIfGoo/+x20RfRFInrRfhK2tmw50I/3UMh
 5DQBH4Lc0qe7wdohE0FjaBtbbqoa4QGZMqZrb/l8XSeymOBP+vuA6m0onWQIPoS2Ef
 Vx7cTRbKRQ29FIJvlTTgCsLh7nGK6SfycnYCPEnWr68lZFLBA5I5o2JtzupxEm0pGr
 Vc7dmLPYEIMyWM6iFosIotiYEQJjF0zFOBdoh5Ssw4h9NAnvgg3QFJr7y7sk8hfXRl
 bQ6e53UDrRwVg==
Received: from emil.cesnet.cz (gtx107.cesnet.cz [IPv6:2001:718:812:27::107])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by office2.cesnet.cz (Postfix) with ESMTPSA id 978F8118007F;
 Thu, 15 Jan 2026 15:01:57 +0100 (CET)
From: spinler@cesnet.cz
To: spinler@cesnet.cz
Cc: dev@dpdk.org
Subject: [PATCH 6/6] net/nfb: stop only started queues in fail path
Date: Thu, 15 Jan 2026 15:01:34 +0100
Message-ID: <20260115140134.235877-7-spinler@cesnet.cz>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260115140134.235877-1-spinler@cesnet.cz>
References: <20260115140134.235877-1-spinler@cesnet.cz>
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
index 3bd9cab5fa..2d36a0a7dd 100644
--- a/drivers/net/nfb/nfb_ethdev.c
+++ b/drivers/net/nfb/nfb_ethdev.c
@@ -140,11 +140,12 @@ nfb_eth_dev_start(struct rte_eth_dev *dev)
 	return 0;
 
 err_tx:
-	for (i = 0; i < nb_tx; i++)
-		nfb_eth_tx_queue_stop(dev, i);
+	for (; i > 0; i--)
+		nfb_eth_tx_queue_stop(dev, i-1);
+	i = nb_rx;
 err_rx:
-	for (i = 0; i < nb_rx; i++)
-		nfb_eth_rx_queue_stop(dev, i);
+	for (; i > 0; i--)
+		nfb_eth_rx_queue_stop(dev, i-1);
 	return ret;
 }
 
-- 
2.52.0

