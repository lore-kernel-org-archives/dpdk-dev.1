Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 060B7F436BF
	for <dpdk-dev@archiver.kernel.org>; Fri, 17 Apr 2026 16:55:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C28A04064E;
	Fri, 17 Apr 2026 18:55:38 +0200 (CEST)
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
 by mails.dpdk.org (Postfix) with ESMTP id 1916440665
 for <dev@dpdk.org>; Fri, 17 Apr 2026 18:55:37 +0200 (CEST)
Received: by mail-dl1-f53.google.com with SMTP id
 a92af1059eb24-12c45281a06so1257403c88.1
 for <dev@dpdk.org>; Fri, 17 Apr 2026 09:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1776444936;
 x=1777049736; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LWuvkSO3E41sodgzKi46wA4JRsszdPj5cao24NoRk2c=;
 b=ZXnPwfiPr/Jjztkjalwg5L+fKOcm9hYdFwSuFwsvdDpGRWzWLq4YsMRrFstBA3ZZQi
 1185ZDU4I19w3RIsiFlGc8Qaxfwr8Bwji+PsTv0P5jbqrKLd4SPWo6HsXrBzpVqWLeak
 r/93x4W3u0sWE+lt2ZoGH8tspujiZ93E/8ZbyPI6FbUdQaoI959cfFcup9hkjub8egEL
 iVA2itOZilxsoaGd16gbLGBzfSkDbGDSU6mOmFj07+oFGf/Gt/769Bso8i/lyFuoKCjZ
 BKWag4d9pjvQGQ9GOdSXMRaB6oyYkDxRNQBs+8eXwSNqOSF6oovJd5dOfk7y9brm0jT3
 DzEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776444936; x=1777049736;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LWuvkSO3E41sodgzKi46wA4JRsszdPj5cao24NoRk2c=;
 b=f53MHAqWsG4rv2EfPXPwi6/MjxsJpBuoMIEfEDtInYhhTRm1lPfmnMcr/6rojUJ2I+
 akjp5q34B9UAajSoZn1R5PdwyT0MkbivyXME4d31tbNU0WESyZFoKf2P40xj0RaOLeE9
 encPjJobHfoxQrnPTP9br0DIUo3b3AyOa0Jk8MY1yyrnAVDdXRAM0KSvtFtWhVLpbB61
 8/lSYiU+hhQPhv0GHOkKIPNVYjqGktEnPhtjzJZIgOVxdzdsdEobZqtp9KBi4uOTckKI
 Zjkfk5Hb1Bb7G8buK30qCAkX0FI00b0WDVIhPpY4rM4C0Vwh/F6NO/JCCBkXRXv2Hmm4
 tlCQ==
X-Gm-Message-State: AOJu0YxD2AiuWHNry+HkRloDNDj4Aw8Ysh3gjDHB3IXKIUCsweUHLTaq
 Qx8JL2jVZOzD/sXU2+rf95KDd1q0Z1MoLTFTYEXf4fNxGkUhC7mRcWMyCdTg6alcMrv2UCrvjaV
 WgawN
X-Gm-Gg: AeBDiesJ0bfGimCRq37B361fMnml0GRZZjdO8WoTqeW0H4kO25JkeeAVhCyajTLLIym
 P5EvXyrmUa7H241vFUfxNf4l0ddWBsaJK7liKQAH1Iimey3YFp0X+sAbz/6zO1ehzG6/JhlbIsv
 kvJQmH/0XklhzfCY1xDSNdqj/IcyQmCl9biRNfEjFMaqEqb5HZU04kY9jqpgxDYHr2I0axyRL/w
 os48PMFnLqWdCO5dV2239KWVy/JM2vyz9zsH/vjxSRiWQYx8MgpXfsaGDbEE03aeAJG9lWAhBET
 kYg2ICFGZYKOVIlGFSOq0Bu8lBiMkkTvpLoI31S/yjIDnZoyktLAblz//sF7p/smExrVG5+EoIa
 1DjdU/VCB0ELp/84r9TS1OuRWMzsQxloI23GsSfligsSTBwGVHOU7GcGwgXWwZa8iAZ/Wjg08E/
 /6lQNRqxIG8ROq1j7HgsxQS59LjFORL9mPGn9uaT3k2Yw=
X-Received: by 2002:a05:7022:6189:b0:12c:44a5:fb51 with SMTP id
 a92af1059eb24-12c73f74b2fmr1732677c88.9.1776444935703; 
 Fri, 17 Apr 2026 09:55:35 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2e539fa6134sm2891264eec.3.2026.04.17.09.55.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Apr 2026 09:55:35 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Chas Williams <3chas3@gmail.com>, "Min Hu (Connor)" <humin29@huawei.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Qi Zhang <qi.z.zhang@intel.com>
Subject: [PATCH 2/3] net/bonding: prevent crash on Rx/Tx from secondary process
Date: Fri, 17 Apr 2026 09:51:36 -0700
Message-ID: <20260417165530.653328-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260417165530.653328-1-stephen@networkplumber.org>
References: <20260417165530.653328-1-stephen@networkplumber.org>
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
index 96725071da..6a42257d2b 100644
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
+		RTE_BOND_LOG(NOTICE, "receive not supported in secondary");
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
+		RTE_BOND_LOG(NOTICE, "transmit not supported in secondary");
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
@@ -3799,9 +3831,18 @@ bond_probe(struct rte_vdev_device *dev)
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

