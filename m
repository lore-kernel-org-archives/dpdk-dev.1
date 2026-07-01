Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F0D7C43458
	for <dpdk-dev@archiver.kernel.org>; Wed,  1 Jul 2026 18:35:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A7B03406B4;
	Wed,  1 Jul 2026 20:35:36 +0200 (CEST)
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com
 [209.85.214.202])
 by mails.dpdk.org (Postfix) with ESMTP id B860240685
 for <dev@dpdk.org>; Wed,  1 Jul 2026 20:35:35 +0200 (CEST)
Received: by mail-pl1-f202.google.com with SMTP id
 d9443c01a7336-2ca2396713bso7720955ad.0
 for <dev@dpdk.org>; Wed, 01 Jul 2026 11:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1782930935; x=1783535735; darn=dpdk.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=vfmDWPlPa2XqDYErLOH8U7YHV4NQmH+0QZ8uuCF7YCA=;
 b=MXuFEsROegCHaHlFFelnwoAPmNE7xzwZlMn/ASH4qUQj7gw7+oUZ0CisJS0seV9ZON
 wFo4serKuiK+kUQH7OUD0mqd2jsUcm8hI47YQzN+/rSpsncCivOA0oR8CicuM8FuVjgx
 ClgvCTR041c04p8h70sTw9NkkVZ1dSRcq3o9crKKvMd15hObhq38vYRMqZgYWJmUud4d
 pe9pVdzrZMukkRAwfFH20P2lbqZL6NU9AWnm6CSUnBwG6y49UgWfda1l1MHUIyiqKUwe
 1zbR/bNuPf6kXP5SKXbOjWCyCIG5kRCf0ksXjKZi4DE5BYFA7ur2BcY49ktCyWpkclO0
 Ur6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782930935; x=1783535735;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vfmDWPlPa2XqDYErLOH8U7YHV4NQmH+0QZ8uuCF7YCA=;
 b=NhkEQwKH9bu3g8bjYlgxRLX/4orVe+wlVO0wp0m6YEG1J9hPmM9Ow0PJUpqmW0BGwp
 jOu2tGdr1jbLiyAEFCQ/xiK7PBlMXVWlBOZvv4ieZdb0pujhuOxpjFnIG7tUVCgzL972
 Q+IlQAFX5Fq4BSpPObGK7hCbbV9A4rxV8JYz5beDvgahgxKmseBmRM8SIQ8POeDKydSH
 DXtzknvmaZq+xRvKhNKAZ/PKLtDuulJQRzFaicGZp6/K4EUGfvVR/nb0zsDO8m+clCiI
 5Nr2dZv1GZ2cUrv96mACfJg4+MLeyKHlSF6iOBoKOYfuxZgN+Ltjl78kCE2gfBW8foAC
 8lOw==
X-Gm-Message-State: AOJu0Yw6WmjZAEs4TCkZUP2BwVktstJk10qott4VBtDZY1FGUB6Yv1BC
 5nBeCIuxu3wCAyKWzTrAQeFqc+BCSiswLNajvSj57dOiRx07ybb06XFLvbONdSgmQppYjOqd0CS
 jBgWQReoDIzWXCA==
X-Received: from plfz14.prod.google.com ([2002:a17:902:d54e:b0:2bc:ac01:8af8])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:db04:b0:2c9:afad:c5f2 with SMTP id
 d9443c01a7336-2ca91239be3mr17377595ad.45.1782930934607; 
 Wed, 01 Jul 2026 11:35:34 -0700 (PDT)
Date: Wed,  1 Jul 2026 11:35:20 -0700
In-Reply-To: <20260701183528.2443032-1-joshwash@google.com>
Mime-Version: 1.0
References: <20260701183528.2443032-1-joshwash@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260701183528.2443032-3-joshwash@google.com>
Subject: [PATCH 2/9] net/gve: delay adding mbuf head to software ring
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
2.55.0.rc0.799.gd6f94ed593-goog

