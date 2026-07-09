Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAFDEC43458
	for <dpdk-dev@archiver.kernel.org>; Thu,  9 Jul 2026 04:07:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CF464406B4;
	Thu,  9 Jul 2026 06:07:47 +0200 (CEST)
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com
 [209.85.214.202])
 by mails.dpdk.org (Postfix) with ESMTP id 58F0440697
 for <dev@dpdk.org>; Thu,  9 Jul 2026 06:07:46 +0200 (CEST)
Received: by mail-pl1-f202.google.com with SMTP id
 d9443c01a7336-2cc88e22f92so32534435ad.1
 for <dev@dpdk.org>; Wed, 08 Jul 2026 21:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1783570065; x=1784174865; darn=dpdk.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=aTzQ0E3JKhWfw3QRkT2xgExixjhbZcSWphObIF76mg0=;
 b=GqsZLuJyWiJ28j9q0/VGWVae5rUe+69BTFDkIFcwqjYpPImKK+scw3ZKoqMblbUCAY
 aW7l0UFL+bbYiBzMexwsPJEr52TfEaNP0wA15vgIzvp9FYOtKJ1FJlTkggmzC7ORaR5y
 GAOkftaH/6hmXFrxiW19jq5RxDvrIvT89DPLN+3GyZz/wgIavqs2K/fTMCsHOvi5N4p7
 t80185O2yKPglJmEyGuUB1JYSuP/c/QKAKf1m3dGAm7phoxyU9IeSqI0BuSdpdCBeCPn
 9ZlVS93SyJA+N7AUw9FY4TsNQAhW26Cc9Iz7m3KnfkqKqn1mWdQfgaw5tOS/F6kJ2b68
 bQqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783570065; x=1784174865;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=aTzQ0E3JKhWfw3QRkT2xgExixjhbZcSWphObIF76mg0=;
 b=A5HSkth5+tI/OKhM2mLfaFXwV/jIZfkxbmfTGctpCYvheddc2EZ3VwQJRB/JbICBdn
 9sMMRdQ96awSKEsTOitQUOichk3Uu+N6Y8a7Ohbqpz0akqzI/qooRWKc/PrxEIEku/Hd
 gVbdsgJk3apFD4cfYUfVYqqeMdF5KSfhGSwmjBuOlX5QFt2T/c2NOftfik04id4rdfCu
 3Hx9/wgAjRWdH2uqrqpVjbUyshMxYeFX83ZSKeMPUD3JDhzA5ukkAqECjcwnhX3rD+7V
 D0zBbR0Dofj7V2wKdD0UtkokUqa/6Cnj2sBCxIf0l7laBn/IoS/4bODArxvpBwnAhAYB
 72pg==
X-Gm-Message-State: AOJu0YwrZkI8ckImcc8baBMC/oirzzscQosoCcgg7YhYp7/rbwFEsZ4U
 E1auOgwE79mIvPk5lIv4tE78QbCHWalRwzhBSUq+gHSXyf3/pHF8z4XwHD43ryJQQMP2RMVPIQh
 KgyNfc/XGyH3keg==
X-Received: from pllx13.prod.google.com ([2002:a17:902:7c0d:b0:2ca:dd72:56ce])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:19ee:b0:2cc:d192:50b8 with SMTP id
 d9443c01a7336-2ccea3e7098mr56406175ad.47.1783570065270; 
 Wed, 08 Jul 2026 21:07:45 -0700 (PDT)
Date: Wed,  8 Jul 2026 21:07:30 -0700
In-Reply-To: <20260709040739.3184955-1-joshwash@google.com>
Mime-Version: 1.0
References: <20260707164020.2936476-1-joshwash@google.com>
 <20260709040739.3184955-1-joshwash@google.com>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <20260709040739.3184955-3-joshwash@google.com>
Subject: [PATCH v4 2/9] net/gve: delay adding mbuf head to software ring
From: Joshua Washington <joshwash@google.com>
To: Jeroen de Borst <jeroendb@google.com>,
 Joshua Washington <joshwash@google.com>, 
 Junfeng Guo <junfengg@nvidia.com>, Xiaoyun Li <xiaoyun.li@intel.com>
Cc: dev@dpdk.org, stable@dpdk.org, 
 "Jasper Tran O'Leary" <jtranoleary@google.com>
Content-Type: text/plain; charset="UTF-8"
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

The GQ TX datapath was set up to write the mbuf head into the sw_ring
before writing the descriptors. This poses a problem because it's
possible for the packet to be dropped due to lacking the FIFO space to
do a proper TX. In such a case, the packet won't be sent, and will lead
to leaked mbufs in the subsequent segments.

There is also no real reason that the head mbuf must be set in the
sw_ring separately from the others; the mbuf chain is not actually
walked as part of GQ TX.

Fixes: a46583cf43c8 ("net/gve: support Rx/Tx")
Cc: stable@dpdk.org
Signed-off-by: Joshua Washington <joshwash@google.com>
Reviewed-by: Jasper Tran O'Leary <jtranoleary@google.com>
---
 drivers/net/gve/gve_tx.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/gve/gve_tx.c b/drivers/net/gve/gve_tx.c
index 5c73c21b8d..59c82b04ed 100644
--- a/drivers/net/gve/gve_tx.c
+++ b/drivers/net/gve/gve_tx.c
@@ -301,7 +301,6 @@ gve_tx_burst_qpl(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 			(uint32_t)(tx_offload.l2_len + tx_offload.l3_len + tx_offload.l4_len) :
 			tx_pkt->pkt_len;
 
-		sw_ring[sw_id] = tx_pkt;
 		if (!is_fifo_avail(txq, hlen)) {
 			gve_tx_clean(txq);
 			if (!is_fifo_avail(txq, hlen))
@@ -344,13 +343,14 @@ gve_tx_burst_qpl(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 		}
 
 		/* record mbuf in sw_ring for free */
-		for (i = 1; i < first->nb_segs; i++) {
+		for (i = 0; i < first->nb_segs; i++) {
+			if (!tx_pkt)
+				break;
+			sw_ring[sw_id] = tx_pkt;
 			sw_id = (sw_id + 1) & mask;
 			tx_pkt = tx_pkt->next;
-			sw_ring[sw_id] = tx_pkt;
 		}
 
-		sw_id = (sw_id + 1) & mask;
 		tx_id = (tx_id + 1) & mask;
 
 		txq->nb_free -= nb_used;
-- 
2.55.0.795.g602f6c329a-goog

