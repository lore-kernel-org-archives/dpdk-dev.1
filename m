Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F8DBC8303F
	for <dpdk-dev@archiver.kernel.org>; Tue, 26 Aug 2025 00:03:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BF468402DE;
	Tue, 26 Aug 2025 02:03:43 +0200 (CEST)
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com
 [209.85.210.201])
 by mails.dpdk.org (Postfix) with ESMTP id 50A894021E
 for <dev@dpdk.org>; Tue, 26 Aug 2025 02:03:42 +0200 (CEST)
Received: by mail-pf1-f201.google.com with SMTP id
 d2e1a72fcca58-771e331f0fcso1222073b3a.1
 for <dev@dpdk.org>; Mon, 25 Aug 2025 17:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1756166621; x=1756771421; darn=dpdk.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=dudVmx3upkTxURmveJP80DOEUxGRUw1rx4wZdqjzMQk=;
 b=NZsAyRa13cxR0dBI7AaVfN+NUxBMjgSZ3R+bdw+8UAOUVQNIJo2JB5d0voCe9iRAFc
 YebQVkrTmhwUaWEaWDSl2Tr3SrkD+fVOVzfD/CKB7H7eQMrGm7WGJ4wF7JDw8+fR04tH
 5FmxZae7qZrW0RzQuposopg/zs3Dz4Q/3cMCW4Iz1Jl9rNrFcxF8xqmsz7gEUez4Icl/
 roHJ2E3DmZxCQnXNCweqdQtPfKqkWSqGIAGxBIUsfYxA9u/Mg4B8QdlDC78XZvGq4PED
 tyIdforPc1NF1+3ZkC3N2rn925VbEBcOiTWIZJclqBmxwnGTWFLSu/1tZvh9+mnHr+i9
 lhFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756166621; x=1756771421;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dudVmx3upkTxURmveJP80DOEUxGRUw1rx4wZdqjzMQk=;
 b=XgAxZy0KSjaEQBLLUOk2GZirFCKOzAdhu1xyqvtvKkilX4dpu/faQLIi7Pi8afjWpp
 a1IjYahsxrkVda+GAM8/pLDM3vXTqNcr7ZPoJ6Hhdp70k5F0c8pkJTkxD3q86lXmhO+B
 wuXICf4s/V/PlGflNq3BgjEzKzeh2xd0MTw8pqUyZ7SxJgehXbL5GfR0i4T+Fu7Kallu
 Hm1YG9FTofWvkWq1cr5mEn64MADMd7Qnk4cc0ONUXlmz8Twlr8v+OQvNJJ8kg+W81jke
 S2zsDx4qbzBx8SLk6F2L2VlU0zoDyOCnTJDw+Dd6SDjF6HmB/ozOs3bwxDuSEvSMZNxk
 jbQA==
X-Gm-Message-State: AOJu0Yw+Pg5VWCBMwIbM1WgdKBsnzsPTTogleQuBdj44ZrizDO+jkldf
 MTo1pykhDHwGo2u5CFf1YWeby4E9JLUHYiDni2n8LaM0awLCwpjwSfooTPQyMz9KRMHcDDjVy51
 kn7xeWFPEVc161A==
X-Google-Smtp-Source: AGHT+IGmDxAekIKTNbFyICG6O7LiRzhivIR3nCv/QFafPZh6VAsCHVgxcJy9kujSEJ2hVlrdnmW4lJ4vR+yihQ==
X-Received: from pfoo6.prod.google.com ([2002:a05:6a00:1a06:b0:770:5229:752e])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:3e01:b0:76e:885a:c33a with SMTP id
 d2e1a72fcca58-7702fc28b0cmr19210365b3a.32.1756166621387; 
 Mon, 25 Aug 2025 17:03:41 -0700 (PDT)
Date: Mon, 25 Aug 2025 17:03:34 -0700
In-Reply-To: <20250826000337.3922883-1-joshwash@google.com>
Mime-Version: 1.0
References: <20250826000337.3922883-1-joshwash@google.com>
X-Mailer: git-send-email 2.51.0.261.g7ce5a0a67e-goog
Message-ID: <20250826000337.3922883-2-joshwash@google.com>
Subject: [PATCH 1/4] net/gve: free Rx mbufs if allocation fails on ring setup
From: Joshua Washington <joshwash@google.com>
To: Jeroen de Borst <jeroendb@google.com>,
 Joshua Washington <joshwash@google.com>, 
 Rushil Gupta <rushilg@google.com>,
 Praveen Kaligineedi <pkaligineedi@google.com>
Cc: dev@dpdk.org, stable@dpdk.org, Ankit Garg <nktgrg@google.com>, 
 Ziwei Xiao <ziweixiao@google.com>
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

When creating new RX rings, one less than the number of buffers in the
ring need to be allocated. It is possible that only a part of the
allocation is successful, resulting in a failure to create the rings.
In this case, the driver should free the buffers which were successfully
allocated to avoid a memory leak in case the application does not
automatically exit.

Fixes: 265daac8a53a ("net/gve: fix mbuf allocation memory leak for DQ Rx")
Cc: stable@dpdk.org
Signed-off-by: Joshua Washington <joshwash@google.com>
Reviewed-by: Ankit Garg <nktgrg@google.com>
Reviewed-by: Ziwei Xiao <ziweixiao@google.com>
---
 drivers/net/gve/gve_rx_dqo.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/net/gve/gve_rx_dqo.c b/drivers/net/gve/gve_rx_dqo.c
index 0103add985..cd85d90bb6 100644
--- a/drivers/net/gve/gve_rx_dqo.c
+++ b/drivers/net/gve/gve_rx_dqo.c
@@ -376,14 +376,13 @@ gve_rxq_mbufs_alloc_dqo(struct gve_rx_queue *rxq)
 		rxq->stats.no_mbufs_bulk++;
 		for (i = 0; i < rx_mask; i++) {
 			nmb = rte_pktmbuf_alloc(rxq->mpool);
-			if (!nmb)
-				break;
+			if (!nmb) {
+				rxq->stats.no_mbufs++;
+				gve_release_rxq_mbufs_dqo(rxq);
+				return -ENOMEM;
+			}
 			rxq->sw_ring[i] = nmb;
 		}
-		if (i < rxq->nb_rx_desc - 1) {
-			rxq->stats.no_mbufs += rx_mask - i;
-			return -ENOMEM;
-		}
 	}
 
 	for (i = 0; i < rx_mask; i++) {
-- 
2.51.0.rc1.167.g924127e9c0-goog

