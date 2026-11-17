Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1726C606A336
	for <dpdk-dev@archiver.kernel.org>; Wed, 18 Nov 2026 09:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=f7eiVW0X
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3B6F7402F1;
	Wed, 18 Nov 2026 10:20:05 +0100 (CET)
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mails.dpdk.org (Postfix) with ESMTPS id 95D1D402A4
 for <dev@dpdk.org>; Tue, 17 Nov 2026 15:11:48 +0100 (CET)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-94960131befso588127985a.0
 for <dev@dpdk.org>; Tue, 17 Nov 2026 06:11:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1794924707; x=1795529507; darn=dpdk.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=s6h4NVCXjBSgTVmgwL6hditmvVyTkbQyP/CZRhZQHTE=;
 b=f7eiVW0XxA7EYucvPw6cMP8521RXeDODzbd5Tss/1f6fV6nO786bFoImWmjBBUg6IE
 4eCN0EkMrebB2FCOMb2/D0QwskEB/tqr3G9YJZrAfzJhFprKRYqO7aTfrHwPcioLdBKt
 spSMrj/1if+JNRyeaXtnIbQ4fJQkcttGbEkAhOEko4pdy/pAQ6ATx087GOn3sIVsKXRe
 b40FLIqFsAyx8pLUGEX64eiV1JLOl/KSlD0JPZQiqr2iWp8AjLo7RqbmBO23hfoUJUy8
 XIiXX6mi3DZAXtyrvhyaRW3ld9IqdY/IBIazM+QgRxpy/DzSm9D+1OK3v5E6Rw7hD5st
 gpTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794924707; x=1795529507;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=s6h4NVCXjBSgTVmgwL6hditmvVyTkbQyP/CZRhZQHTE=;
 b=qcosBSCt5fkAKJHXngsIbboGSyquL8u0wV/Qbv1AK6lvGIXJV6HNoXOZazHyQHOZ+E
 wC/wWQ73n4Dea/R5t+4Zq52kJGklPuYIEeTXIETOsgEJzkP266MUCVWq2o2vYeIn+Of1
 E1/Vj81Ly2KUhiflKjUrcyuKc/clBJEt9YWtnDotcyJxBeCue8YKvH4c/YSkiDxQh3Jq
 ikGYoSfoi9a5YUibn2GZNJ4dIInzSA38QyVBo6heeNZHi6CAG6EAfaJjBD//DTgVUhvk
 CMBU9R2OWLb5kNYt6qINjTH/Y3qssKMjrTOAtger29lUEIvSIwn2Ctc3yA0rwl08JmXU
 doFQ==
X-Gm-Message-State: APuU4Z/qJSXFZyk/qRZ3L+T8N2IZGQpgNpO/RBSw+UPCLOXaTdEv82rQ
 Rr2IbKjFKi43yEwCAGFpBTMiBhIpRg+jPdVNQaPMkosZ+CbcR7B26cyzrOz5J9fEy0Gp3VX/nWs
 cfpqqmOP+z3CpqfmlRoxx2Azkqfcrw8Ss+pl9v6LvQG0r4WO5e31V9JVEvttaTKmO1pvPnnOOTO
 zOqrC+p69ErXEoY5q8TTdoYYXXQWyR
X-Received: from qkat3.prod.google.com ([2002:a05:620a:ac03:b0:945:c45b:d774])
 (user=rnwolfe job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:8002:b0:945:c4b9:3de2
 with SMTP id af79cd13be357-9494bcb0e9dmr2167252685a.73.1794924706941; Tue, 17
 Nov 2026 06:11:46 -0800 (PST)
Date: Tue, 17 Nov 2026 09:11:43 -0500
In-Reply-To: <cover.1794908231.git.rnwolfe@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261115140016.3830109-1-rnwolfe@google.com>
 <cover.1794908231.git.rnwolfe@google.com>
X-Mailer: git-send-email 2.56.1.708.g77570a6a1d-goog
Message-ID: <b3b916de152e3d3be30a9a2fbb69b7b70c7e69ad.1794908231.git.rnwolfe@google.com>
Subject: [PATCH v2 2/3] net/gve: fix GQI RDA multi-seg descriptor length and
 clean
From: Ryan Wolfe <rnwolfe@google.com>
To: dev@dpdk.org, Junfeng Guo <junfeng.guo@intel.com>, 
 Joshua Washington <joshwash@google.com>
Cc: stable@dpdk.org, Harshitha Ramamurthy <hramamurthy@google.com>, 
 Rushil Gupta <rushilg@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Wed, 18 Nov 2026 10:20:02 +0100
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

gve_tx_burst_ra() has three bugs on multi-segment bursts and ring wrap:

1. For non-TSO packets, hlen was set to tx_pkt->pkt_len instead of
   tx_pkt->data_len and passed as the first descriptor's seg_len,
   causing the device to overrun the head mbuf buffer on multi-segment
   frames while also transmitting the trailing segment descriptors.
2. When txq->nb_free dropped below nb_used mid-burst, gve_tx_burst_ra()
   aborted immediately without calling gve_tx_clean(txq) to reclaim
   completed descriptors.
3. Unsent packets left for the caller on ring-full backpressure were
   added to txq->stats.errors.

Use tx_pkt->data_len for the head segment of non-TSO frames, attempt
gve_tx_clean() before stopping when descriptors run low mid-burst, and
stop counting normal backpressure as Tx errors.

Fixes: a46583cf43c8 ("net/gve: support Rx/Tx")
Cc: stable@dpdk.org

Signed-off-by: Ryan Wolfe <rnwolfe@google.com>
---
 drivers/net/gve/gve_tx.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/net/gve/gve_tx.c b/drivers/net/gve/gve_tx.c
index d344648d0f..14495e3851 100644
--- a/drivers/net/gve/gve_tx.c
+++ b/drivers/net/gve/gve_tx.c
@@ -412,8 +412,11 @@ gve_tx_burst_ra(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 		if (ol_flags & RTE_MBUF_F_TX_TCP_SEG)
 			nb_used++;
 
-		if (txq->nb_free < nb_used)
-			goto end_of_tx;
+		if (txq->nb_free < nb_used) {
+			gve_tx_clean(txq);
+			if (txq->nb_free < nb_used)
+				goto end_of_tx;
+		}
 
 		tx_offload.l2_len = tx_pkt->l2_len;
 		tx_offload.l3_len = tx_pkt->l3_len;
@@ -425,7 +428,7 @@ gve_tx_burst_ra(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 
 		hlen = ol_flags & RTE_MBUF_F_TX_TCP_SEG ?
 			(uint32_t)(tx_offload.l2_len + tx_offload.l3_len + tx_offload.l4_len) :
-			tx_pkt->pkt_len;
+			tx_pkt->data_len;
 		/*
 		 * if tso, the driver needs to fill 2 descs for 1 mbuf
 		 * so only put this mbuf into the 1st tx entry in sw ring
@@ -466,7 +469,6 @@ gve_tx_burst_ra(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 
 		txq->stats.packets += nb_tx;
 		txq->stats.bytes += bytes;
-		txq->stats.errors += nb_pkts - nb_tx;
 	}
 
 	return nb_tx;
