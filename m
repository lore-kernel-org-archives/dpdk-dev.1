Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B75E8C43458
	for <dpdk-dev@archiver.kernel.org>; Tue,  7 Jul 2026 16:40:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 75A99406B4;
	Tue,  7 Jul 2026 18:40:28 +0200 (CEST)
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com
 [209.85.214.202])
 by mails.dpdk.org (Postfix) with ESMTP id D2F104069F
 for <dev@dpdk.org>; Tue,  7 Jul 2026 18:40:26 +0200 (CEST)
Received: by mail-pl1-f202.google.com with SMTP id
 d9443c01a7336-2cc7e86e7c5so49718565ad.3
 for <dev@dpdk.org>; Tue, 07 Jul 2026 09:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1783442426; x=1784047226; darn=dpdk.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=y3iEXTWnWoxgGhQGrNfblO1S1UlwzKKGcWF5+ywgEyA=;
 b=bL3tgpdhxdCdyFB2zAokgyzK2rwfR3vNMsJiz2XftBVURjYht8ke4DDh70ABF3XOpA
 vNAsWREDObcj+f6GuiIwr8c6SWaMnwDyp6Di+IbmfTbSirLpd2ZAkpRE+yFkDI083NUH
 iqXPJ3omfir1KHayJh75aU/qJH9lpxPGFoYQsoiJKGekzMnYpWxXRrUA2sNS+87xSPnF
 PWhKEKiJvSy1ivINtrtAQadnR3sJkIzORSExntJeS8u2eN02zXncetdFqYTYtqy1jCNc
 fFs6TmQlxlZDcj0XAXRoozCMXs87mfuoXV18PnMlt5N1JL6dBVWdFOMJUMtjJstLNiIp
 sGdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783442426; x=1784047226;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=y3iEXTWnWoxgGhQGrNfblO1S1UlwzKKGcWF5+ywgEyA=;
 b=Wfxa3rnz1ljLxxwVGVlPT8NMaJ4dDuGk1gr/XNXgG4PSTT1hNOjXw6gsPp44oYOs3f
 iLXRh061SLYfau/h2SBXEC2N5xshtCmz3dO4KMHin2G6NFv+rxBDchLoNE00oEEXOYEu
 JxOJjNNQseavxovmdAMfauroLyN8zFZdkC7Jm/I9p10TfILDl/HUvuzZGmXDmaD18mny
 HyKTrylD5ukMEaQfIdmUjvESyx9ZTVVVbun9xLEXlAhbKtiKw8iG9j0voiUU4pYXRQfz
 qlg9/QMhAZlbOV0OpYVcFalB0E85HgvIpMTWlNLp9hK4Lj3mycoXGYwPiA4oCeHgMmUM
 8UKg==
X-Gm-Message-State: AOJu0YwVyuId8pdbEzup8HMroukL2A6RsUmZWCciJQR53gs88LL15wFs
 /mpE5TyGXQhIwLHhIeM8sqTHMk4mgVoLOuwKMjrgZzrCexUhorgsBgDXDt74/mn/85rLRiastdm
 cL9WfeVdD9nr31A==
X-Received: from pgbcq12.prod.google.com
 ([2002:a05:6a02:408c:b0:c99:a30a:7619])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:778b:b0:3bf:d0c8:2aa7 with SMTP id
 adf61e73a8af0-3c08eecba3amr5999215637.47.1783442425818; 
 Tue, 07 Jul 2026 09:40:25 -0700 (PDT)
Date: Tue,  7 Jul 2026 09:40:12 -0700
In-Reply-To: <20260707164020.2936476-1-joshwash@google.com>
Mime-Version: 1.0
References: <20260703131308.2507403-1-joshwash@google.com>
 <20260707164020.2936476-1-joshwash@google.com>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <20260707164020.2936476-3-joshwash@google.com>
Subject: [PATCH v3 2/9] net/gve: delay adding mbuf head to software ring
From: Joshua Washington <joshwash@google.com>
To: Jeroen de Borst <jeroendb@google.com>,
 Joshua Washington <joshwash@google.com>, 
 Xiaoyun Li <xiaoyun.li@intel.com>, Junfeng Guo <junfengg@nvidia.com>
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
2.55.0.rc2.803.g1fd1e6609c-goog

