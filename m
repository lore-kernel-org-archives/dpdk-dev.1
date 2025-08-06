Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BCD1C87FCB
	for <dpdk-dev@archiver.kernel.org>; Wed,  6 Aug 2025 21:42:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 44C2B4064A;
	Wed,  6 Aug 2025 23:42:29 +0200 (CEST)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com
 [209.85.221.44]) by mails.dpdk.org (Postfix) with ESMTP id A1B3D40615
 for <dev@dpdk.org>; Wed,  6 Aug 2025 23:42:27 +0200 (CEST)
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-3b7886bee77so209365f8f.0
 for <dev@dpdk.org>; Wed, 06 Aug 2025 14:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1754516547;
 x=1755121347; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8JBnpPYalxjvG7xml7r8CXLliDz8gCzqjgPTUVLzfGo=;
 b=uPfH/wNlinhFZOMcHAj7enm/U5UkMxUADacZ43ljYwUGDA18lU/RZmfWeVvxTUk1im
 U10sq0oVXXGG0ezsvjwDtjJ+5QzKmnhI5cf+UfMG32pk09Oxjvje6xhI6u5UzizfKgqK
 WnehxXstGpkweIgVI8rOxk1anxXhW0KyhJ8IBstGufjJlR74BKSSQYEN294G6DUN53j6
 A96wvcE6BkDFaDVbeqJ3q/AbxnjFs/YQznBSVYUjDePpxmU07Ylsja33b8c/pecXdO7A
 znEYcpiPkiCfb9X7a5hw+4nwR5uZW16CUo68hQX8Sq9QgKOwaEamblpovM7x+Px8YyQH
 MPuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754516547; x=1755121347;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8JBnpPYalxjvG7xml7r8CXLliDz8gCzqjgPTUVLzfGo=;
 b=UanrUxoUpalCfEo8FEuVVLNpDuIJo7CZRN+eIaju1RgrWbb2qLLDilrlBnylTvEnln
 99U0oQUom/roZOfAiIedsESRbC7BVyS0nBpJuRTZDdockO6SrZXjwIFw6FkkCeE47eqM
 P00zL9wz4dY5UNc2mPpHm8BWKxPXVRt6qntAFR69WyBwlPYbgIPfWiLA7VLfLA/vO6ZP
 2d6iGhOBH93Qw5iF9a9uDMZa2A83Ylj2umbHYPtWFbK/GSR4RqJSBq7BPvaI4N74Ac5o
 bmgOFFASxs8JmUOMMiJZcXldjDg2KHNCwFxmtMPlePpNJ5CaEHayQTn5o+4HLBVoa5RT
 R8RQ==
X-Gm-Message-State: AOJu0Yz3GLGcEesz28K7+FORUohZyxANdG5ELrGhRdDQ+zvCfmcl1GA5
 liZORvXj1WokfvFqLsGxZ2k8hxkvHr7f3rY/VskBCPOVZBmcy0EfMe4QcnwVeLmwdX1H2R6W4gP
 z67/S
X-Gm-Gg: ASbGnctgd5M7tt/ReoT+U4rghHvSLHnji0N0qasifXq5B+zs9XFKsTUosTssxQeUOuU
 k23VRK/nDS07GUQ4PK66tpweuqtlO5z7vr/XNLcw9RuP6CreBnApc/oBZHCG7II7AU2HB55IK3G
 ko6jMyicQxBm+cV02u4aJ1jR/aU0HjEpXoSZPuJ+3WnTtcPBNBgbSJ91RBa58u6m8xzOLkGWX5b
 TnR1IEcA7Q3/ohnskv99w56MzjDcvXn6BbhM2h6LMWJ2/dIBaJg8s2LuunVExj7fUrKep1kTmwU
 Be+GmL6QD8XNEW9ibTyF/5quYEQxuqI5fZv+JEOCOQU7Ll2cYigN7aNyyB694WYKcq8H5KYzyCT
 EJYogsjNMApvE26nFRRPwhjnTdJKsDunv4l+uZfiBNjbV+VdqzLIg+iwr9IbGMlWuApATWi/T
X-Google-Smtp-Source: AGHT+IG7w0mLEDsbelyeq/y8Pus+gw0LrzFuumeQHWMt0v/Lj8umckddjKaLL9cKUfBltDS0wrzJyA==
X-Received: by 2002:a05:6000:4285:b0:3b7:88f5:f0ad with SMTP id
 ffacd0b85a97d-3b8f4167071mr3480114f8f.16.1754516547132; 
 Wed, 06 Aug 2025 14:42:27 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c3b9160sm24436913f8f.21.2025.08.06.14.42.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Aug 2025 14:42:26 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v9 06/13] net/ring: allow lockfree transmit if ring supports it
Date: Wed,  6 Aug 2025 14:40:35 -0700
Message-ID: <20250806214200.193029-7-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250806214200.193029-1-stephen@networkplumber.org>
References: <20250411234927.114568-1-stephen@networkplumber.org>
 <20250806214200.193029-1-stephen@networkplumber.org>
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

