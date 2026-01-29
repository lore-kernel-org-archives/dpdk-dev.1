Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35E97D358E4
	for <dpdk-dev@archiver.kernel.org>; Thu, 29 Jan 2026 09:03:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C6D4C402D1;
	Thu, 29 Jan 2026 10:03:29 +0100 (CET)
Received: from mail-lf1-f68.google.com (mail-lf1-f68.google.com
 [209.85.167.68]) by mails.dpdk.org (Postfix) with ESMTP id 9475B402BA
 for <dev@dpdk.org>; Thu, 29 Jan 2026 10:03:28 +0100 (CET)
Received: by mail-lf1-f68.google.com with SMTP id
 2adb3069b0e04-59dd34f8120so846016e87.3
 for <dev@dpdk.org>; Thu, 29 Jan 2026 01:03:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769677407; x=1770282207; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=WiCgkKmM6u8iOFMMLQzE2kfGje23i3HFCKhILvts7Fg=;
 b=FjgEe8PA0+EW17XjVvE2DpNzqCnFX6z0qwaCEuN7LcXh+44N9FiB6esSxHFtKsr4fE
 Sv4RhH+I04VKSQz9Je3q8lplPy0NqSmJlF4/pYhc6V/fuWNBI7krDy7ETfgFEXPeaVhu
 KFAcFBJXyAF60eZdPj7ulgA5KQG19bgHgibpZmi+DHIk3+xo2E4OPlK63ZstR7qrlIVO
 mcPmcFaX3IQjPfZ+twF0+sGnWmcuSsLKqEX2sOp2g+RDnCJeMeiZxzypPVms/ODtz5i4
 5RJtjKRiME80e1VSzrh36zD1Byf0tN8VoXuK1mPxnj/rnVkFplj/vOMeV559KBRKTyi6
 GSUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769677407; x=1770282207;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WiCgkKmM6u8iOFMMLQzE2kfGje23i3HFCKhILvts7Fg=;
 b=YRNM+rK8zuR9tqzg61lj418gvW4XLM3OPc0ddKDsnt6XMhJgD9lfHX2b3TXCvLO0FC
 b5074bhwmlLYdHCbvc77jdzRNHCm0gAs3Ud2bJtmW0wm8d+ZVirinfdClTvyIljrUh1L
 0pnWJ3trGMk3TCSjkc02zJjrQ9bU2Ajp0img5ZtFk+i3mmCjbOM5JYNwJozYzlf0GU0r
 vIG8S0TYgiKwW3bMelGoHn0Wy7WKpiogrpdH5mJhPW7YXfWKc4V+dShtxuMa5g2xfq6k
 oKTQ5u8r08rZOMOPwI3YKnXv8YS+Kr8TjOKZaktdZC2JbrLSIAb6KLedQwppLxj8jpLf
 Q+mg==
X-Gm-Message-State: AOJu0Yw9AVLX3uEhSxjgghOxPZtRb7ffkmY3SS5f8Sp5VDNonIj1JATD
 ZuRY9rj0U1ZcwNPafloFsiUkkmQ7XkCc2CRQneAdBmRalkrO+SmSZwPM4tiWOJXV9dWqTA==
X-Gm-Gg: AZuq6aIg45qpyM68rY61GixyGGKsnBJwkVEKhskQ6qYWqr+GSWO67yLeZ5OdpbDEQsl
 H/2blKi/BILs1As+08KywHV35IaeaMBe00/bcmCnn5b8paQuIsO4bxNYXla8Qhk33LNDY/b7T6J
 ClUVfBXqbT/RQYlUjFwv9p/Mdo+qyoSgGqighamOepZu9DBK8SzmK/Xc2bJgNly5c+Zs8/KtOPz
 OeJJ6CQZ+tEsz0hwEwG6o2PEJGQEhelnydn86RYYWnKvZf1bEfvTzbMpIVLNodAoZelQgGU3yn1
 fB8K/2CIlWQHd9nUnrVAWnAzmQnATr+5mcZ9CPBausaKDYgNZ/Xnvlz2mifiV9qJK5cyOYzF1oA
 7tMLTQuEmztGFQe/ngDMUsf/kb5A4bbfPug7EJMwpw2Djshxn93zLvT1UKXoJ0NHbyHiTmOajJs
 0u920MN6N3DUCFDcOWYIr9WMBKD6ZzclUMnEBRA5GeUQ==
X-Received: by 2002:ac2:4e16:0:b0:59c:ba5b:ff62 with SMTP id
 2adb3069b0e04-59e0401704emr3350732e87.15.1769677407219; 
 Thu, 29 Jan 2026 01:03:27 -0800 (PST)
Received: from dpi-G5-MF5.pulsar.kazdream.kz ([109.163.197.162])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-59e074beadcsm1018352e87.95.2026.01.29.01.03.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Jan 2026 01:03:26 -0800 (PST)
From: Zhanibek Bakin <zhanibek.bakin@gmail.com>
To: dev@dpdk.org
Cc: mtetsuyah@gmail.com, stephen@networkplumber.org,
 Zhanibek Bakin <zhanibek.bakin@gmail.com>, stable@dpdk.org
Subject: [PATCH] net/null: fix Tx statistics accumulation
Date: Thu, 29 Jan 2026 14:03:12 +0500
Message-ID: <20260129090312.98636-1-zhanibek.bakin@gmail.com>
X-Mailer: git-send-email 2.43.0
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

The eth_stats_get() function incorrectly uses assignment (=) instead
of accumulation (+=) for opackets and obytes in the TX queue loop.
This causes only the last TX queue's statistics to be reported,
while the RX side correctly uses +=.

Fixes: 31326ce7f151 ("net/null: count all queues")
Cc: stable@dpdk.org

Signed-off-by: Zhanibek Bakin <zhanibek.bakin@gmail.com>
---
v2: Fixed Fixes tag to use 12-character hash
---
 drivers/net/null/rte_eth_null.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/null/rte_eth_null.c b/drivers/net/null/rte_eth_null.c
index 46e7e7bd8c..7fba3a661b 100644
--- a/drivers/net/null/rte_eth_null.c
+++ b/drivers/net/null/rte_eth_null.c
@@ -345,8 +345,8 @@ eth_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats,
 		pkts = rte_atomic_load_explicit(&q->tx_pkts, rte_memory_order_relaxed);
 		bytes = rte_atomic_load_explicit(&q->tx_bytes, rte_memory_order_relaxed);
 
-		stats->opackets = pkts;
-		stats->obytes = bytes;
+		stats->opackets += pkts;
+		stats->obytes += bytes;
 
 		if (qstats != NULL && i < RTE_ETHDEV_QUEUE_STAT_CNTRS) {
 			qstats->q_opackets[i] = pkts;
-- 
2.43.0

