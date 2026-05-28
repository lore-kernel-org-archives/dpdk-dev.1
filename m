Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97320CD4F54
	for <dpdk-dev@archiver.kernel.org>; Fri, 29 May 2026 00:02:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 19B2D40665;
	Fri, 29 May 2026 02:02:08 +0200 (CEST)
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com
 [74.125.82.174]) by mails.dpdk.org (Postfix) with ESMTP id 3F7DB402EE
 for <dev@dpdk.org>; Fri, 29 May 2026 02:02:05 +0200 (CEST)
Received: by mail-dy1-f174.google.com with SMTP id
 5a478bee46e88-304d555293aso2909454eec.0
 for <dev@dpdk.org>; Thu, 28 May 2026 17:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1780012924;
 x=1780617724; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DMVJeZwpdnwpWN2HGzgaZS+qlUoaP/bL8wZLxKZD0ag=;
 b=tAykvCu2nEDXC2DK1YetDs/zCn6WZauxQoUoSPSaOd6DBMJWrSv9ii9+3Qx1XugWU1
 q7b6pv3AjUT4ML5TKX4DRjLagKHYV3OoxQ+XIS0aJzVzf3Os1OKO+dE4DccdmrmjAM5x
 GTn9Mw/WmKXnJgykgqLnpxGImRtbUcdE5vm3dcF7Bv13ajkL7sKbsIXPKCqg22ArjX6k
 6B18P5cp+ju+XttUQf1rMkj8CkHIPC9VNe2fCtz9t5nBbyBLN/mRPgh0mO46tUGxVQpw
 CzJx5tmJRNNjXKgAyirKPNHyo/fi7jeGTFYRALXgV7t8sKZX056r4q4C6Jdh5bdsabuS
 Ibzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780012924; x=1780617724;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DMVJeZwpdnwpWN2HGzgaZS+qlUoaP/bL8wZLxKZD0ag=;
 b=jMbgi2BonB0kMVTI6+CRFHs5dcFfUYf5ctbhCPfKW88O4p0YdwQcUuHAzuXDqYx52e
 Iw7QazD18xX4nIUY1bTeU9pUCUrjB0CEBKNBqg9J89TtKlbC4Yo41mdy1lDkVEcRNP9B
 n6Dsv8CWYjSs0EMqjwYfhorTSgT+XoydkQk/CofJzxGyRNpcg5mTTrbQVQWByiUUQn3F
 NBt+mWCDCo6ZlWBd/ZJdZe7pki51S/QD0HpOjz6tXYzI9fGuQ54GpaSgW39Rr4JOEqLZ
 m6eskzu8No4Ss30XaOdDm/kRQNm6LbDlnCDmMLbmZDR6/PdKXaa/WjZzAU6kg7x6WBty
 27IA==
X-Gm-Message-State: AOJu0YzUQqRO/T0ndIfOzn8FAZ/30WdG6jJhKCLaYqJf5SdAwGF840eZ
 Ykob7tpNe36kK9xEvjDdIVZWdorIXppbvBDAAZml/jvAgrtxdOcg64s6l3heqArxFqrElFmjfDv
 kUKU0
X-Gm-Gg: Acq92OFVFFWAAuyA/18WPkj75qValkjthewq6Obz3IPI32+yGbzZbKZNaCsbdqQChIg
 B7rcH6QtX8FhbL+pF4Me9XPE6wPeLe2q/B6GFmE4TyH01VXQNikmrqnT5LYF84VBe5Z+eCCzrLE
 4Oqs9Jxlcark6W8Rwh6L+GVzLCc/bKKCITus35wWS7nbusJd4mpWt8agsiNA5a9UGu+QaEgQqip
 ot1ovvpaozxiavyldZBFuOa6Ni4eX+TSx/S1pVoPIwh0D4KPm8d32hzOUZu1DcoP5uGNhjYg31s
 imCW5/WDlVmQAoH779yZB8ELrbYQgUgA7TG9mX9gu8ERrUs115ktxHKlfVxyRK6MayJi9Brf6xk
 fLTOOcuyggiP5hArAM0riA1nAybmfMOvoFTK45GXaIWSkw/Yi5Vzf2WUnnV9YqITOCCeYWZPyRi
 9PH8cI5Sku8kaPDugwpU5OsdwUVoE+Islo+KwWp2bYmp4A4NEPLHrd7lUbNcJV22xkMSWbNpG1
X-Received: by 2002:a05:7301:3f16:b0:304:8366:7456 with SMTP id
 5a478bee46e88-304eb0f0b91mr408463eec.3.1780012924113; 
 Thu, 28 May 2026 17:02:04 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-304ed5d5385sm53076eec.28.2026.05.28.17.02.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2026 17:02:03 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Chas Williams <3chas3@gmail.com>, "Min Hu (Connor)" <humin29@huawei.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Qi Zhang <qi.z.zhang@intel.com>
Subject: [PATCH v2 3/4] net/bonding: prevent crash on Rx/Tx from secondary
 process
Date: Thu, 28 May 2026 16:59:15 -0700
Message-ID: <20260529000157.235931-4-stephen@networkplumber.org>
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

The bonding PMD's secondary process attach path registered the
ethdev but never installed rx_pkt_burst or tx_pkt_burst, leaving
both as NULL. Any rx_burst or tx_burst call from a secondary
process therefore crashed with a NULL pointer dereference.

Fully sharing bonding state across processes would be
overly complex. Instead, install blackhole burst functions
in the secondary so the data path is safe by default. Rx returns 0
and Tx frees the mbufs and reports them as transmitted,
matching /dev/null semantics so applications do not spin
retrying. Each stub logs once at NOTICE level on first use.

Also reject bond mode changes from a secondary process.
rte_eth_bond_mode_set() is callable from secondary, and
without this guard it would overwrite the secondary's safe
burst stubs with real per-mode functions whose internal
state is not valid outside the primary, reintroducing the
crash by another path.

This keeps secondary support available for the more
common use cases of procinfo and packet capture.

Bugzilla ID: 1698
Fixes: 4852aa8f6e21 ("drivers/net: enable hotplug on secondary process")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/bonding/rte_eth_bond_pmd.c | 43 +++++++++++++++++++++++++-
 1 file changed, 42 insertions(+), 1 deletion(-)

diff --git a/drivers/net/bonding/rte_eth_bond_pmd.c b/drivers/net/bonding/rte_eth_bond_pmd.c
index 7fcb3ec7d7..8a9c329fb8 100644
--- a/drivers/net/bonding/rte_eth_bond_pmd.c
+++ b/drivers/net/bonding/rte_eth_bond_pmd.c
@@ -56,6 +56,33 @@ get_vlan_offset(struct rte_ether_hdr *eth_hdr, uint16_t *proto)
 	return vlan_offset;
 }
 
+static uint16_t
+bond_ethdev_rx_secondary(void *queue __rte_unused,
+			 struct rte_mbuf **bufs __rte_unused, uint16_t nb_pkts __rte_unused)
+{
+	static bool once = true;
+
+	if (once) {
+		/* once per process is enough of a notice */
+		RTE_BOND_LOG(ERR, "receive not supported in secondary");
+		once = false;
+	}
+	return 0;
+}
+
+static uint16_t
+bond_ethdev_tx_secondary(void *queue __rte_unused, struct rte_mbuf **bufs, uint16_t nb_pkts)
+{
+	static bool once = true;
+
+	if (once) {
+		RTE_BOND_LOG(ERR, "transmit not supported in secondary");
+		once = false;
+	}
+	rte_pktmbuf_free_bulk(bufs, nb_pkts);
+	return nb_pkts;
+}
+
 static uint16_t
 bond_ethdev_rx_burst(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 {
@@ -1599,6 +1626,11 @@ bond_ethdev_mode_set(struct rte_eth_dev *eth_dev, uint8_t mode)
 {
 	struct bond_dev_private *internals;
 
+	if (rte_eal_process_type() == RTE_PROC_SECONDARY) {
+		RTE_BOND_LOG(ERR, "Setting mode in secondary not allowed");
+		return -1;
+	}
+
 	internals = eth_dev->data->dev_private;
 
 	switch (mode) {
@@ -3798,9 +3830,18 @@ bond_probe(struct rte_vdev_device *dev)
 			RTE_BOND_LOG(ERR, "Failed to probe %s", name);
 			return -1;
 		}
-		/* TODO: request info from primary to set up Rx and Tx */
+
 		eth_dev->dev_ops = &default_dev_ops;
 		eth_dev->device = &dev->device;
+
+		/*
+		 * Propagation of bond mode would require adding
+		 * MP client/server support and lots of error handling.
+		 *
+		 * For now just install a black hole.
+		 */
+		eth_dev->tx_pkt_burst = bond_ethdev_tx_secondary;
+		eth_dev->rx_pkt_burst = bond_ethdev_rx_secondary;
 		rte_eth_dev_probing_finish(eth_dev);
 		return 0;
 	}
-- 
2.53.0

