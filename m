Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 035B3FCE095
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Feb 2026 14:34:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3AE8A40A73;
	Thu, 26 Feb 2026 15:34:15 +0100 (CET)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com
 [209.85.221.54]) by mails.dpdk.org (Postfix) with ESMTP id 1235940658
 for <dev@dpdk.org>; Thu, 26 Feb 2026 15:34:08 +0100 (CET)
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-4327790c4e9so644774f8f.2
 for <dev@dpdk.org>; Thu, 26 Feb 2026 06:34:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772116448; x=1772721248; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4GID3l3YLkEHrFvewdL3jt57nQ8t/3gTJ/Gf1NUDTj8=;
 b=POtlC6QUrq51mWBgI39/CzUpwammtRRArV0obVSQSDkqq9I/n4DyN26OeboK4VgqT0
 g5uDs011ayXb5AE6K36WZRo54eYp10F5ZUKZfDAGtBIaZC80dXkVpjV7kpTYBZWtWeI2
 AHqcdUK41JacEij+3U5dlgYv5IF7w8y3NuElIkcckcjmMXT6VJLebySefJDcJDUnG9aY
 uu5tocI6FQolntkevLVM8Zm7VJ6l7T0wRclKz1n2HVXTkz+np8FyWRCgS1SNZTFIT5fN
 B/E2bgiCaDCPRrC5Yd6f4r43cR6S5rkzqCmZDAqdY+eLd7LtolAfedbpX8zgOD7z+fu3
 KVMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772116448; x=1772721248;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4GID3l3YLkEHrFvewdL3jt57nQ8t/3gTJ/Gf1NUDTj8=;
 b=sURPT2DrlYRrX98QaknBspi0KOTdxZo+b7yHfX7a+BhVffj7dBtjEmrGKJ5bP7Og3L
 ygFXO3uLHOt9h2DOMcWJ30jFCKjcViVlsQiUKoFZFADme1Hf4k27JthVmI1zNhDWymyL
 RLtiTgeV6DLRSVYSi1QC8mzNJvHejyaLBNYOiYY5j+aHtZ0kjexoX/O2ps7dUD9n4vj0
 gsWTx5F/Su7zYypMfKsIaKY1k0KvhBl1B60jqiUi79i6hS8NsCEYOFiUxznoQ6JIv115
 cHnATyz3FTRiLZS2jwSWiJpu9BLsnA4UTbwhtbwC1+6hhj0X5mJN0RdbWbaPn+vqVnU3
 0uaQ==
X-Gm-Message-State: AOJu0YzdH/Kb7SAfC+JwQeovjlXMsttf/eN3nTrBf3szczH1wPlsw+Gg
 mHi36xi7JZlrRimwT/ygV7cjR53pkybYaZUpcwDpcz7tqdR6LJcV6rDxw/ryXQ==
X-Gm-Gg: ATEYQzworWUGcYSTr/9+Ui3PELcl1/hC8InC7wJPZ0poGywThFuiIUE0nMYb1ORBX6j
 VJbwGppKJROhr4dZ9ShBp1Ljp1+IPHv4SeBfQz+TgVuvl34XKHKMmrh4ICX3dQpw1aWPopjwPZh
 O2IT9W3NfwMsJ1oW98dycurrFWf9WIRkI1GRJvnub1Q46nPtq5+PahBZAmVekQjc1jxLkpAtO85
 g7K+QVAf+ul/TiiY3O5hHprAgEg25rdaS90+w19j2mhXgC6z/wl3fIqOSuN6ng9ckNskVZQRed+
 RDvbF3mf1t8pQBVgayv8ZQniyn9bOLtW5CaDzoSya3CeOIWpBIW2RaCu/oTAgJRQE8g5JYwwE65
 zPo3Kz8MPISRfWnoFrdSsT+kVyzEK2BYBElo52LABbAFCIoPmEtJD3aBpfJeb2b87IeJZOBof6D
 k3was0bV/7ycKu1RdQXS7jAbvsoGGbC0fzKkGH
X-Received: by 2002:a5d:5f53:0:b0:437:8fd6:d849 with SMTP id
 ffacd0b85a97d-4396f1a6693mr36029754f8f.54.1772116447481; 
 Thu, 26 Feb 2026 06:34:07 -0800 (PST)
Received: from freepad.iliad.local ([213.36.9.96])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4398bb96b90sm17993866f8f.9.2026.02.26.06.34.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Feb 2026 06:34:06 -0800 (PST)
Sender: Maxime Leroy <maxime.leroys@gmail.com>
From: Maxime Leroy <maxime@leroys.fr>
To: dev@dpdk.org
Cc: hemant.agrawal@nxp.com, stephen@networkplumber.org,
 david.marchand@redhat.com, Maxime Leroy <maxime@leroys.fr>, stable@dpdk.org
Subject: [PATCH v2 05/17] net/dpaa2: fix link not up after port stop/start
Date: Thu, 26 Feb 2026 15:33:29 +0100
Message-ID: <20260226143341.282188-6-maxime@leroys.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260218160453.142311-1-maxime@leroys.fr>
References: <20260218160453.142311-1-maxime@leroys.fr>
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

When LSC (Link State Change) interrupts are enabled, the link status
is only updated by interrupt events -- rte_eth_link_get_nowait() reads
the cached value without querying the hardware.

During dev_start(), dpaa2_dev_set_link_up() was called immediately
after dpni_enable(), before LSC interrupts were registered. The MAC
needs ~30ms to renegotiate after being re-enabled, so the initial
link query returned link down. By the time the link came up, the LSC
interrupt handler was not yet installed, so the link-up event was
missed and the cached link status remained down permanently.

The issue does not occur on the first dev_start() after probe because
dpni_reset() during probe does not bring the MAC down -- the kernel
dpmac driver keeps the physical link up. Only dpni_disable() during
dev_stop() causes the MAC to go down, requiring a full renegotiation
on the next dpni_enable().

The problem is more likely to occur with many queues: the queue setup
loop (dpni_get_queue for each RX queue) between dpni_enable() and the
LSC interrupt registration adds MC portal round-trips, giving the MAC
more time to complete negotiation before interrupts are armed. This
makes the link-up event more likely to be missed.

Move dpaa2_dev_set_link_up() after the LSC interrupt setup so that
any link-up event occurring during MAC negotiation is properly caught.

Fixes: c5acbb5ea20e ("net/dpaa2: support link status event")
Cc: stable@dpdk.org

Signed-off-by: Maxime Leroy <maxime@leroys.fr>
Acked-by: Hemant Agrawal <hemant.agrawal@nxp.com>
---
 drivers/net/dpaa2/dpaa2_ethdev.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/net/dpaa2/dpaa2_ethdev.c b/drivers/net/dpaa2/dpaa2_ethdev.c
index 3658e24dd2..e58b93c564 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.c
+++ b/drivers/net/dpaa2/dpaa2_ethdev.c
@@ -1391,9 +1391,6 @@ dpaa2_dev_start(struct rte_eth_dev *dev)
 		return ret;
 	}
 
-	/* Power up the phy. Needed to make the link go UP */
-	dpaa2_dev_set_link_up(dev);
-
 	for (i = 0; i < data->nb_rx_queues; i++) {
 		dpaa2_q = data->rx_queues[i];
 		ret = dpni_get_queue(dpni, CMD_PRI_LOW, priv->token,
@@ -1461,6 +1458,12 @@ dpaa2_dev_start(struct rte_eth_dev *dev)
 		dpaa2_eth_setup_irqs(dev, 1);
 	}
 
+	/* Power up the phy. Needed to make the link go UP.
+	 * Called after LSC interrupt setup so that the link-up
+	 * event is not missed if the MAC negotiates quickly.
+	 */
+	dpaa2_dev_set_link_up(dev);
+
 	/* Change the tx burst function if ordered queues are used */
 	if (priv->en_ordered)
 		dev->tx_pkt_burst = dpaa2_dev_tx_ordered;
-- 
2.43.0

