Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D428DC83F22
	for <dpdk-dev@archiver.kernel.org>; Tue, 15 Jul 2025 16:17:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2CCB14065D;
	Tue, 15 Jul 2025 18:17:12 +0200 (CEST)
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com
 [209.85.219.52]) by mails.dpdk.org (Postfix) with ESMTP id C14574028C
 for <dev@dpdk.org>; Tue, 15 Jul 2025 18:17:10 +0200 (CEST)
Received: by mail-qv1-f52.google.com with SMTP id
 6a1803df08f44-700c7e4c048so92945156d6.3
 for <dev@dpdk.org>; Tue, 15 Jul 2025 09:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1752596230;
 x=1753201030; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8JBnpPYalxjvG7xml7r8CXLliDz8gCzqjgPTUVLzfGo=;
 b=VG96BefzQyH7KxE9ZVYr3uywSFa2UDOn72qIRpVCEjoyf7SNCbAENPXULPC4VG4apK
 Y+M1+owu2o7aSrNLSj0uF//1UePwHwCH3CTKcVhlhfLmmoie35EHzO0xBgRXIMDjj6kx
 ongTHt59fyT6sdvZsUTuuZVtTZwKjfSh/U2VADhvCnw9SBi8RGGzRmihXrrtzzZcSLie
 DfirPPJzLEpESJOcqsPYk2glmP0aDt/VRpXgb0NS8CA8uOUFHtRkVNvlFrfSgh7g8Tst
 uVWa0SH0MerdRR0XMgEMaKeUQzOwPF/ce5k8KJrfRFtm3Jc8P6Y0kAZhbqsc03ammqEh
 ELuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752596230; x=1753201030;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8JBnpPYalxjvG7xml7r8CXLliDz8gCzqjgPTUVLzfGo=;
 b=wKPfrF2o0egtYnv8KukhPrrA2cBop1zhyfPRpEBGvv4jVNlMPmYHkcnO5TZPFo6WKm
 Qf1k9EqjZo9X3LdDsM8q4kbMneWbYNk7bK3oI0Y65srlJHPkV7ZSJhBUKO7Adao7cde6
 8YPnJBhUWz79ke7qIT/w1ddw6qdkkmM4nAfkYsul0EPj8BcUCN6G/RlZ7vaGnWfs7hGD
 YUZ0hlZj80uMif9M7y7EfzcrbOyu2DmxRtja7NyKGroNjG2d4GiOMzNAgqAX1y3UeouG
 oqyIR8M/bGjbtX0tJDMyg2782+dbpjK0thfo/5vVSBQq0g2e1OMj6H0g6zJfP/Ce8r9E
 vMMA==
X-Gm-Message-State: AOJu0Yz5tJuOHOKv2/H4CoxJ2Y5rtNV83DCuLwRXl2ioXYpdqd4w7CX6
 3XSeiPP3t9WOOaM624Reu1pnJFdFqXGPs0BVUMbf7BbxjTRdQyct++3mJBQWykxRNbwtEeMfID/
 Cri2g
X-Gm-Gg: ASbGncvU0XkDUY2Oi9ecxTZKe5sk67cixn3qv2Pigv18cKwN3Uj3W9whFF51vklHRl0
 vU3cw8aT+VGTJgMNdworgQV3aBfFghVSZD6PV7IZICmszJZbHRLAzMiw8nnKi+rJFsAxhvBiIzk
 38Dh652fDLEfjCRiTuXwj7LGCwN/lPbX70ZdOrdsDiXQNkKCyg7tOaQheji0EWyzqoCt9WWdVpB
 wNIyFlgcS6PCTTpajpziJjvj99OSt4OwZrqIAATHsfNMJ0bEivn8eBP8JePQ/fhO7ZbuwrCx8+t
 fHUy0eTs8Omh/bRWkFnFe8T2V3XEZFnoERpP7bGUC1VKJ7KfWHZ3A4k0sUajAhIXaZNaPiW6xYK
 W8EwVbdRIsfUsknMpgfBC0OLHabOcPQ9uh5rljTa2p1s69FbBmFrSSXW5c2tpC6iiQ6pPo1ap
X-Google-Smtp-Source: AGHT+IHv972psl4A53ad0XM6HWN1wnz8SKCvzEbwZxL0QO0Z2oSQ9i9abpdLKhb54rZ88B2UhPb3Hw==
X-Received: by 2002:a05:6214:5c4a:b0:704:e021:7af1 with SMTP id
 6a1803df08f44-704f4b174ffmr781376d6.38.1752596229917; 
 Tue, 15 Jul 2025 09:17:09 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-704979a8857sm59985106d6.9.2025.07.15.09.17.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Jul 2025 09:17:09 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v4 04/13] net/ring: allow lockfree transmit if ring supports it
Date: Tue, 15 Jul 2025 09:15:42 -0700
Message-ID: <20250715161700.103209-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250715161700.103209-1-stephen@networkplumber.org>
References: <20250411234927.114568-1-stephen@networkplumber.org>
 <20250715161700.103209-1-stephen@networkplumber.org>
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

