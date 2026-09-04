Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEA06C79F82
	for <dpdk-dev@archiver.kernel.org>; Fri,  4 Sep 2026 19:17:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BBE6D42DDF;
	Fri,  4 Sep 2026 21:17:31 +0200 (CEST)
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com
 [209.85.214.182])
 by mails.dpdk.org (Postfix) with ESMTP id 2481142DDF
 for <dev@dpdk.org>; Fri,  4 Sep 2026 21:17:31 +0200 (CEST)
Received: by mail-pl1-f182.google.com with SMTP id
 d9443c01a7336-2d6e954afbdso8948015ad.2
 for <dev@dpdk.org>; Fri, 04 Sep 2026 12:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1788549450;
 x=1789154250; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fplwwEHgKDewxgn2g2rKzq3vtZ+oonaCvMOQly6Q/Uk=;
 b=d9FVGGZ8HS3Wton3JeOzoXLcnYYETeyg+asMsVEEhyJ7u2ZfcvS0lStB2uwleDezjp
 B12IN15Jztpa+GtArRm+XVd9FHcsWsWd3fkI+LRBpDmS4nyWRlGgQmkEm235OzG5iTlX
 n5hMDwOXSxNd4lf0U7aVJGNchjipGKydor6p5hksgqn3a487VwmHqi20acIBqoA3j45c
 oudmLLXe7+CLfZvhtFquZpgP1zR2lbTEl+AE5bfGh4lfexCNRu62+uRAFPGAKadasiH4
 PPqEkWQmXgFSOOd8VMfo2hSu8hscXQNm2jUsQUcHLlyxQ7KCxEf0u75a7Ytt1Zm03mCE
 T3RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788549450; x=1789154250;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=fplwwEHgKDewxgn2g2rKzq3vtZ+oonaCvMOQly6Q/Uk=;
 b=F00W+mZZbWwdhI5cK+XU9fsC2HXbPEtT1qF0yqy6ulHA13VkgMghKXQQPx6g6stJcw
 RGOVtTMR9haSBv31HC5ubkMfUyebXNuSzWQjvlaS1+CqJpJpqFkfxvyD6bUN/ZmrnH6E
 cJVF3L5ZHnmoPJgWAgzGmi38TFUJGJoFyzarCUz4bF4pvn2oc6xu0FeYv19IWEqoFTo0
 ZxYOR8zHUgCRw5pit6ZvWR5Wm0ea+JLOBeguHmgqsRJuTQvXsWTi3efRVnIE/c8jJI7L
 tjAWireD8drOyIzI+sMkfiB6YtBjkFOKRQeLiatg3p0NsBsGiQcRJahNwEm+7SlgRweR
 A9lw==
X-Gm-Message-State: AFuF++lEOD/MA8/HYejDbNTde6MkoYDDvtQKuHmOuNMM+i1nqX9/i3eN
 MxdrhQ5t8QhsV4bZ9c3/c9QVvKko+/ussDxJLcj1CYQm5PATryI7K00PeZoRr9dSKQbyHeQB6E1
 PA8zA
X-Gm-Gg: AYBFou36sn8o7sEkOJmrVIBtu2Wt6V8ju/T4+vju3FzOfI822GE0mAQU/P4w6MH/INW
 MHnNmslgWHTAweiDnrRQvK02BwnxyfOlQROKEW+ssZFN5tZ0XEZd7y+gzdXt1CwrmCWlnS9M+UE
 hDBBcVuQqphWIHGrydu0cmOdfg6Oe05dvq381PtVwBJZnNqWOXO5P1bNqyfk76O9e5F+POgdw8W
 SgTKmH1EjoAWmmyX4c67jL7+HF1ejqQ7i7iKuYT/xlDUM6gzd6GIH4Edui9KnL3McxrbIClmuzr
 FC2/JT7/zVaRyMpLeaNYtn/2fW9PL7ultIARCAVdIKAqV8GiVm5dyDXlnyu6vHWnz7gwy6MGVEm
 PJz2FT1AIChtMAdifNJzwLzqy/310XOYNWRyDL7R15ebSTSP8zYove9oyXS5QWFIb6gECex5qTo
 7J/hKy+TE7jYDPJfmhsEviqKKZcL6lOrNAb0NbD/rl624zof3dOVh1WXBQmI++1uccahvNnq80W
 0CIbwltHFXzfYbSp8tEq1qobIQ=
X-Received: by 2002:a17:903:4509:b0:2ca:2079:91cc with SMTP id
 d9443c01a7336-2db1235b99amr82938595ad.5.1788549450200; 
 Fri, 04 Sep 2026 12:17:30 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2db1499f07asm13335975ad.57.2026.09.04.12.17.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 12:17:29 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Jochen Behrens <jochen.behrens@broadcom.com>
Subject: [PATCH 7/7] net/vmxnet3: remove unused queue dump functions
Date: Fri,  4 Sep 2026 12:12:42 -0700
Message-ID: <20260904191652.2399074-8-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260904191652.2399074-1-stephen@networkplumber.org>
References: <20260904191652.2399074-1-stephen@networkplumber.org>
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

vmxnet3_rxq_dump() and vmxnet3_txq_dump() are guarded by
RTE_LIBRTE_VMXNET3_DEBUG_DRIVER_NOT_USED, a macro that is defined
nowhere and whose name records that the callers were removed long
ago. Building with the macro forced on only produces -Wunused-function warnings.

Remove the dead code.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/vmxnet3/vmxnet3_rxtx.c | 58 ------------------------------
 1 file changed, 58 deletions(-)

diff --git a/drivers/net/vmxnet3/vmxnet3_rxtx.c b/drivers/net/vmxnet3/vmxnet3_rxtx.c
index 552b8a9823..aaebfc8675 100644
--- a/drivers/net/vmxnet3/vmxnet3_rxtx.c
+++ b/drivers/net/vmxnet3/vmxnet3_rxtx.c
@@ -59,64 +59,6 @@
 
 static int vmxnet3_post_rx_bufs(vmxnet3_rx_queue_t*, uint8_t);
 static void vmxnet3_tq_tx_complete(vmxnet3_tx_queue_t *);
-#ifdef RTE_LIBRTE_VMXNET3_DEBUG_DRIVER_NOT_USED
-static void vmxnet3_rxq_dump(struct vmxnet3_rx_queue *);
-static void vmxnet3_txq_dump(struct vmxnet3_tx_queue *);
-#endif
-
-#ifdef RTE_LIBRTE_VMXNET3_DEBUG_DRIVER_NOT_USED
-static void
-vmxnet3_rxq_dump(struct vmxnet3_rx_queue *rxq)
-{
-	uint32_t avail = 0;
-
-	if (rxq == NULL)
-		return;
-
-	PMD_RX_LOG(DEBUG,
-		   "RXQ: cmd0 base : %p cmd1 base : %p comp ring base : %p.",
-		   rxq->cmd_ring[0].base, rxq->cmd_ring[1].base, rxq->comp_ring.base);
-	PMD_RX_LOG(DEBUG,
-		   "RXQ: cmd0 basePA : 0x%lx cmd1 basePA : 0x%lx comp ring basePA : 0x%lx.",
-		   (unsigned long)rxq->cmd_ring[0].basePA,
-		   (unsigned long)rxq->cmd_ring[1].basePA,
-		   (unsigned long)rxq->comp_ring.basePA);
-
-	avail = vmxnet3_cmd_ring_desc_avail(&rxq->cmd_ring[0]);
-	PMD_RX_LOG(DEBUG,
-		   "RXQ:cmd0: size=%u; free=%u; next2proc=%u; queued=%u",
-		   (uint32_t)rxq->cmd_ring[0].size, avail,
-		   rxq->comp_ring.next2proc,
-		   rxq->cmd_ring[0].size - avail);
-
-	avail = vmxnet3_cmd_ring_desc_avail(&rxq->cmd_ring[1]);
-	PMD_RX_LOG(DEBUG, "RXQ:cmd1 size=%u; free=%u; next2proc=%u; queued=%u",
-		   (uint32_t)rxq->cmd_ring[1].size, avail, rxq->comp_ring.next2proc,
-		   rxq->cmd_ring[1].size - avail);
-
-}
-
-static void
-vmxnet3_txq_dump(struct vmxnet3_tx_queue *txq)
-{
-	uint32_t avail = 0;
-
-	if (txq == NULL)
-		return;
-
-	PMD_TX_LOG(DEBUG, "TXQ: cmd base : %p comp ring base : %p data ring base : %p.",
-		   txq->cmd_ring.base, txq->comp_ring.base, txq->data_ring.base);
-	PMD_TX_LOG(DEBUG, "TXQ: cmd basePA : 0x%lx comp ring basePA : 0x%lx data ring basePA : 0x%lx.",
-		   (unsigned long)txq->cmd_ring.basePA,
-		   (unsigned long)txq->comp_ring.basePA,
-		   (unsigned long)txq->data_ring.basePA);
-
-	avail = vmxnet3_cmd_ring_desc_avail(&txq->cmd_ring);
-	PMD_TX_LOG(DEBUG, "TXQ: size=%u; free=%u; next2proc=%u; queued=%u",
-		   (uint32_t)txq->cmd_ring.size, avail,
-		   txq->comp_ring.next2proc, txq->cmd_ring.size - avail);
-}
-#endif
 
 static void
 vmxnet3_tx_cmd_ring_release_mbufs(vmxnet3_cmd_ring_t *ring)
-- 
2.53.0

