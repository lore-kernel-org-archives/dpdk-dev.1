Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74120C83F0A
	for <dpdk-dev@archiver.kernel.org>; Wed,  9 Jul 2025 17:36:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5729F40B8C;
	Wed,  9 Jul 2025 19:36:21 +0200 (CEST)
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com
 [209.85.214.176])
 by mails.dpdk.org (Postfix) with ESMTP id DCB8940DCD
 for <dev@dpdk.org>; Wed,  9 Jul 2025 19:36:18 +0200 (CEST)
Received: by mail-pl1-f176.google.com with SMTP id
 d9443c01a7336-23694cec0feso1599975ad.2
 for <dev@dpdk.org>; Wed, 09 Jul 2025 10:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1752082578;
 x=1752687378; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8JBnpPYalxjvG7xml7r8CXLliDz8gCzqjgPTUVLzfGo=;
 b=yRFIgSfoMVoWGWAzkLhbVwMnpUd6zaE6l+Sj5FaODQGZiMUg8K/QKiDRVQbf49PSGO
 OXXJ+r60tkLLg1BzxOcYEmwJ+j7zMJqPoXm5Vrv5w6cGK3Tjvy3HM98Nqew+rRHbK+cs
 pUKzE6ZrmEeUiHqN188sd1AdjkvfPYY3x96NNBrcK6tavFmPnNJrYBO3T/L2o9AFE2V0
 G2dO0nvQ9PlIveKfAoTjwLLFCHvRfIaO/Cp0ACv4NJEFSyrcjiE6bzhrEa5Rs32+SHMm
 KEylZCr2u0RmWaev4B9MN/2YeBWOl4VyjPqvYMbnD6r83k5sd/DM2dECw1wvffKNYjv4
 GlKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752082578; x=1752687378;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8JBnpPYalxjvG7xml7r8CXLliDz8gCzqjgPTUVLzfGo=;
 b=QqBTrn5e6V3bBQBQy7aCq9jAWZvAnN5XJ6gmGwDERyufFDi0/dMbex/emP53s6I0YF
 MpETurS11+lYxYQLt5qJb//CqM1mr6T8SSqxoiYtpiLY+3oF9FJPZjML7HfDZP4Z0U3I
 c7UHG0HJOajCPt8ddPxESg68F0KdkOMxxPkwxSvQdoaAAYAt81NcWPQcE0+vgVg5GFPE
 0GO1RpNXapZkpM3kIqIRntul2QpiK4t1um7OfQ9FUXvY7d/aoDiATsUGj2Zh6pGtfUV1
 /JqGE9kM5IDVEApnmuxYBFwPPVGfoBmx+Cd+fD7o/BCf5B/qqzsx9yB7s2KuZulHZDJU
 Wcjg==
X-Gm-Message-State: AOJu0YxfVHd1+F34mu5OKtud0fMA3AZ0hul6yM9lkcjJBQOQ/9n8Ik8b
 N0mvLt8mc9480sZQuDKGACddIYre3hYw7qvEG48DOvX3GMQKKZa+GCsET4e8/OC8l9RL1WtUAih
 OEnMM
X-Gm-Gg: ASbGncsM1ue/EYSxIqpVtTWFCwmcTKtaTnPGZJZa/YhcCqibO8BAkvNAvCtzk0OidDL
 LrBtaXXsw95WhpLcsZxnV0y/bD7GR5yEuZc738uQM3X3k7nx6eEVr6bfyJEyd/Zpmhh5n19uRvX
 MrFcy2MH1qCvgK5bCnKU6SsgxrrYChaWrKCpT8vzF6wj4OJhmGWxAP6erImt10Oe5E1EKJPOlRP
 QD+6SWx8CPHh1Tx3TQOg9KpaY/lVr0STZWRSB/yDw1Item8Iy5YImMNqOC044ZaykAuADdK1cFe
 naQfoorEgtnh2hUMeDw90cuHHp6HSad8GUxaFK4ythOGjetAktssVkCbOlzHW+PiQhKAnfGmfM0
 wja74op35z4Z+Qd21uP2dhxmvmrpfHO2bnCIn
X-Google-Smtp-Source: AGHT+IHKVbz4YtkuUPu7feLlPEucgX2csoFhfIky3WVrsrdfmfow+/KnppkJwYlv6C/Wlc0RAFaShA==
X-Received: by 2002:a17:903:1aa4:b0:234:d292:be7f with SMTP id
 d9443c01a7336-23ddb3125d9mr56334295ad.31.1752082578037; 
 Wed, 09 Jul 2025 10:36:18 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23c845b7467sm138525475ad.230.2025.07.09.10.36.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Jul 2025 10:36:17 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [RFC v2 03/12] net/ring: allow lockfree transmit if ring supports it
Date: Wed,  9 Jul 2025 10:33:29 -0700
Message-ID: <20250709173611.6390-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250709173611.6390-1-stephen@networkplumber.org>
References: <0250411234927.114568-1-stephen@networkplumber.org>
 <20250709173611.6390-1-stephen@networkplumber.org>
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

Need to be able have multiple threads all using same
transmit queue when using SPAN.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/ring/rte_eth_ring.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/net/ring/rte_eth_ring.c b/drivers/net/ring/rte_eth_ring.c
index b1085bf390..966c64d9a5 100644
--- a/drivers/net/ring/rte_eth_ring.c
+++ b/drivers/net/ring/rte_eth_ring.c
@@ -177,6 +177,19 @@ eth_tx_queue_setup(struct rte_eth_dev *dev, uint16_t tx_queue_id,
 	return 0;
 }
 
+static bool
+eth_tx_queue_lockfree(const struct pmd_internals *internals)
+{
+	unsigned int i;
+
+	for (i = 0; i < internals->max_tx_queues; i++) {
+		const struct ring_queue *r = &internals->tx_ring_queues[i];
+
+		if (r->rng->flags & RING_F_SP_ENQ)
+			return false;
+	}
+	return true;
+}
 
 static int
 eth_dev_info(struct rte_eth_dev *dev,
@@ -189,6 +202,10 @@ eth_dev_info(struct rte_eth_dev *dev,
 	dev_info->max_rx_queues = (uint16_t)internals->max_rx_queues;
 	dev_info->rx_offload_capa = RTE_ETH_RX_OFFLOAD_SCATTER;
 	dev_info->tx_offload_capa = RTE_ETH_TX_OFFLOAD_MULTI_SEGS;
+
+	if (eth_tx_queue_lockfree(internals))
+		dev_info->tx_offload_capa |= RTE_ETH_TX_OFFLOAD_MT_LOCKFREE;
+
 	dev_info->max_tx_queues = (uint16_t)internals->max_tx_queues;
 	dev_info->min_rx_bufsize = 0;
 
-- 
2.47.2

