Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B44C9CA9ED2
	for <dpdk-dev@archiver.kernel.org>; Mon, 12 Oct 2026 20:39:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 60B1340612;
	Mon, 12 Oct 2026 22:38:44 +0200 (CEST)
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com
 [74.125.82.175]) by mails.dpdk.org (Postfix) with ESMTP id 61E954026D
 for <dev@dpdk.org>; Mon, 12 Oct 2026 12:50:36 +0200 (CEST)
Received: by mail-dy1-f175.google.com with SMTP id
 5a478bee46e88-3514e7cbbbaso4489236eec.1
 for <dev@dpdk.org>; Mon, 12 Oct 2026 03:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791802235; x=1792407035; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=a8Mpm5CcXVVPcPxSxvCPPsHhCeCt4lK/epA8ew3UBtI=;
 b=snA+Yqc8qf+EU0Lc5UddjhkeSxXWvdL3Se3/j5nifXnOt47dHA2Di/Yy0RSg8E7vZa
 xRrGsYObYXm9CprK6MOQvUGzIizvv0oNHOu5XlLNvB8TXvr/Dgaol8PXRwJH+OH8D4ez
 I5P881MJZa7h6U+mnJ1UoCUvMGovFc3tcHqnqZtLPjZZbh8VCOdXiF9r+NIcNG2qT2dD
 6BXWhnS7MvdaL/6N//MrycoaxNMUv6cCquvlSXKIXOLR59Su2jrWgpqmDS/c4+VCIdMZ
 Dj6vGChqsRhLsZPK1kpakXdRskm1aC95UY4C1s9ePP59RisE+gZaprh6OqWLqJweVl2F
 HbMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791802235; x=1792407035;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=a8Mpm5CcXVVPcPxSxvCPPsHhCeCt4lK/epA8ew3UBtI=;
 b=UFiEV1svTCOgbib/V05tHOTyhAlqbWhz1CXauV7R204vtn9lk+O3I3TIVLWg+A8Tpn
 BZWNgAorDzJYVVHMxi5bgieRvVFnPoMKdn9pwvbkafgBsJVH23MklvhEyodJQSi4n8nw
 h9o035i2FL3d2cQV+E3C1qIHrknlX5v78ewqBq93/lsa2vVm+/qg1Q4msJAZY7qXcz6J
 CMAH6Al63a68QoL3w5x+dk5GSrcN0zF9U4ft3j2wl5WS3XCApyQRUBkPVr1nsAqimfmq
 441kFV/2iS4QfQLZGvDMsEZLMsKK5ltVbCKw4a3f5WqoPuCtt+Ah0QmsZzgBAD0bDpA+
 5N2Q==
X-Gm-Message-State: AFq9FYJLKjVuKeKAqIJU85VmEqco9nqcNGBOuwdJ5PGLvyxwQr7QL8ig
 Vs1vny4C6ECaupe3ia7zOOqlZzGR4ul3Nx9KMWJ69xDrUqcmpwsNz4UT5ACDdQ==
X-Gm-Gg: AYBFou1K+N3useUPS9uB4Ej4WiNYF1tEsUcXWETNkyJ5+WxmPbsqeA/Ae2toEE/078B
 /N3Y4yrI0jl+xkydpFaDUJLuvK1HoEXPFPv9EZkWg0i3YG3VCGIG8dGTF84+KMCWhR85motSRoI
 J4NO3k3aAa3L9F8i9/W3mpydRgI9TlsP/jsFnsZP1Ak09yextDwB/tLJgsQtI0qk2xwYhqg4FYV
 QkZgz4kVg9iJtwYjGjXXxFUiNaKONH7ncfIErvxmOxA9iEafyR8A5te6NcayeoU68rLS+s/kCIB
 CeaT9lEGBEYIo3LkIgZbZ3nXdis/CGRGO1gp0EGhqqyrKUeOPIUN9qVt2tK7kFHvVpRNV8IY+re
 xePWDIrFGd810dN3JfMESdlZ9mSuayn+gdmh3Hx5sNTBRmJfiF4YvNzJSb8DtMQAMM/OX5WgNk9
 FAMRhLRdqVKIA5JGXvBhLP5T0J+Ifj95gbG5/4ngb/g4p/jkWJedA5LRRBh2ruaXAiB7nPbeja
X-Received: by 2002:a05:7301:5787:b0:351:7990:f3cf with SMTP id
 5a478bee46e88-3537df9b5c1mr19817772eec.18.1791802235289; 
 Mon, 12 Oct 2026 03:50:35 -0700 (PDT)
Received: from aviuser.. ([192.19.252.250]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3537cab27d5sm36875760eec.17.2026.10.12.03.50.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 03:50:34 -0700 (PDT)
From: Tathagat Priyadarshi <tathagat.dpdk@gmail.com>
To: dev@dpdk.org
Cc: joshwash@google.com,
	stable@dpdk.org
Subject: [PATCH 3/4] net/gve: add cacheline overlap margin to DQO TX ring
Date: Mon, 12 Oct 2026 10:50:22 +0000
Message-ID: <20261012105023.669486-4-tathagat.dpdk@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261012105023.669486-1-tathagat.dpdk@gmail.com>
References: <20261012105023.669486-1-tathagat.dpdk@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 12 Oct 2026 22:38:37 +0200
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

The GVNIC DQO hardware DMA engine prefetches descriptors in cacheline
units (64 bytes = 4 descriptors of 16 bytes each). When producer tail
and consumer head indices share a cacheline, CPU and device DMA memory
collisions can occur.

Align with the Linux driver (gve_has_tx_slots_available()) by requiring
GVE_TX_MIN_DESC_PREVENT_CACHE_OVERLAP (4 descriptors) headroom when
checking descriptor availability before enqueueing packets.

Fixes: 4022f9999f56 ("net/gve: support basic Tx data path for DQO")
Cc: stable@dpdk.org

Acked-by: Joshua Washington <joshwash@google.com>
Signed-off-by: Tathagat Priyadarshi <tathagat.dpdk@gmail.com>
---
 drivers/net/gve/gve_tx_dqo.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/net/gve/gve_tx_dqo.c b/drivers/net/gve/gve_tx_dqo.c
index a8382ff3c4..9210b02eb1 100644
--- a/drivers/net/gve/gve_tx_dqo.c
+++ b/drivers/net/gve/gve_tx_dqo.c
@@ -261,6 +261,7 @@ gve_tx_burst_dqo(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 	uint16_t nb_tx = 0;
 	uint64_t bytes = 0;
 	uint64_t ol_flags;
+	uint16_t req_descs;
 	uint16_t nb_descs;
 	bool csum, tso;
 	uint16_t tx_id;
@@ -291,14 +292,17 @@ gve_tx_burst_dqo(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 
 		nb_descs = gve_tx_pkt_nb_data_descs(tx_pkt);
 		nb_descs += tso;
+		req_descs = nb_descs + GVE_TX_MIN_DESC_PREVENT_CACHE_OVERLAP;
 
-		/* Clean if there aren't enough descriptors to send the packet. */
-		if (unlikely(!gve_can_tx(txq, nb_descs, 1))) {
+		/* Clean if there aren't enough descriptors to send the packet
+		 * while maintaining the cacheline overlap margin.
+		 */
+		if (unlikely(!gve_can_tx(txq, req_descs, 1))) {
 			int nb_to_clean = RTE_MAX(DQO_TX_MULTIPLIER * txq->rs_thresh,
-						  nb_descs);
+						  (int)req_descs);
 
 			gve_tx_clean_descs_dqo(txq, nb_to_clean);
-			if (!gve_can_tx(txq, nb_descs, 1))
+			if (!gve_can_tx(txq, req_descs, 1))
 				break;
 		}
 
-- 
2.43.0

