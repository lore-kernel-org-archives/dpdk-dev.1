Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EBC0C83F27
	for <dpdk-dev@archiver.kernel.org>; Tue, 22 Jul 2025 17:36:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2EA91406BC;
	Tue, 22 Jul 2025 19:36:06 +0200 (CEST)
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com
 [209.85.222.176])
 by mails.dpdk.org (Postfix) with ESMTP id 4B1164066E
 for <dev@dpdk.org>; Tue, 22 Jul 2025 19:36:02 +0200 (CEST)
Received: by mail-qk1-f176.google.com with SMTP id
 af79cd13be357-7e62773cab8so52162885a.1
 for <dev@dpdk.org>; Tue, 22 Jul 2025 10:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1753205761;
 x=1753810561; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8JBnpPYalxjvG7xml7r8CXLliDz8gCzqjgPTUVLzfGo=;
 b=vF74iDqnQRYMV8S6Lte5ewGO0I1d9muOTfcDEN69Pr9J2a7dc+41Ul7G0yysyeFfQY
 BBpOiPzuHqJPo0npdsjp4Y8JC+PGQBbNgnJY9vg8Kkdf5CeT4z/kufoBdGJomGD9K0ij
 P2j7QBFxNU8ag5OPWE6OL3hwQ3utEyTRLPJlHssJlWzIrWgdRgZgNT6WOJBXRJr5HWzz
 rSKpCjA+xNHFh34vFHI06ql9ZvbwpsLvOLi1nHxKplDzNK64NeKFQywbL6gc9zqEuJVJ
 RqVk1/Fmk7AkbFAj7ZAglhhBU6tyRwOpz7mfMlcb1/uTN78tovwIYBptcD6b2vjnI/o0
 kgzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753205761; x=1753810561;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8JBnpPYalxjvG7xml7r8CXLliDz8gCzqjgPTUVLzfGo=;
 b=Ee8AbI4PiOOQOaLYmANol5TYNYsAx9LwM1X0GDp4TXSbNFJTszxFFfKYR+uNAOcwVC
 cbrswbEiApq5/8KWkOfAFnDQujxYpLmg4aIu0+3ebrkuVIimPmHXfxjxq1QEjR6PbAum
 QBK8Uvc4hkT9aBMbsK7vEVTrfJcKlCY0OjUbEdsz5oBzQMoHWKVuMNp/FfOejNcYMqFZ
 zc7nbdR/lUAfV8W33/RMUChYv5OvKFfrujIRTsWXi0P9pTFj+1f9VhgFoAkh36Df8ZQV
 JZMB8NhnNQQ1MPhUkCqrjr+xKlh0ZwlizCK0K0JmnDDuPJPsO6dvETFxHWJtStZtAv9S
 dE0w==
X-Gm-Message-State: AOJu0YxCr4Rqpejv531BFqPrnNNmVPBcQmcvAwmDNGNtSvLs+t4ae2N9
 zaTe2c0KkHS60Et0c8eDHbd8k/wd6Do0nDmpSd4HGIq2GF1oa1nrerv22hrCrBLpytDiR+og9Xm
 UIusA
X-Gm-Gg: ASbGnctbPHRLQu1A2gkfAPym9oQIcMoyTuipeZorqYHob0ZPEQMp5G9hLRpl8FZy1Kj
 ZppM2N0pqtXVB19l3PmUft/ksdnV7fFSzbq8z+kIJwEUIyD4jJnQQvdpHanEySfQEvCqFYK6F+M
 EZaPadt37md4kAGpkF3mZeViSv9VzQELLqlO8PTqJSd4KKmS/ZLoeQaX1H1ngKK+uRCEvzgdYLj
 gFWohfGk48ngpj0RxRPEobWn8NNZJ/K2NtWz1V4aTSxoFoMS3sv14yKmcLt9nE3X7l9MhtlCoZ/
 6aQ+ox6rGYftcQIrMhcC7IXiPCEeuyiiYesRMnXdUYLDhQHK0crnkECH9O5ZxtYdQhTLMGlaSfy
 1W+N3wWaoBYoquoXOc4pSKDn02qwHg89C8LdN02bq9U+Ve0YHZpXgH9UoZLC4W8AOgFxDaA2e
X-Google-Smtp-Source: AGHT+IHkToAyy29UHMtTEB2ar7IsNIq+rKYEpzZwi4ASiO5P2Tk5sPvEWnKf/AIj8P6aN6C1tllTvw==
X-Received: by 2002:a05:620a:a201:b0:7e3:4413:e492 with SMTP id
 af79cd13be357-7e62a1fcf2fmr8225285a.62.1753205761528; 
 Tue, 22 Jul 2025 10:36:01 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7e356b282aasm552155885a.14.2025.07.22.10.36.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Jul 2025 10:36:01 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v6 04/13] net/ring: allow lockfree transmit if ring supports it
Date: Tue, 22 Jul 2025 10:34:35 -0700
Message-ID: <20250722173552.184141-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250722173552.184141-1-stephen@networkplumber.org>
References: <20250411234927.114568-1-stephen@networkplumber.org>
 <20250722173552.184141-1-stephen@networkplumber.org>
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

