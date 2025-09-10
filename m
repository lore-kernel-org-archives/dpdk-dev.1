Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F176CA101F
	for <dpdk-dev@archiver.kernel.org>; Wed, 10 Sep 2025 19:04:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4D08140678;
	Wed, 10 Sep 2025 21:04:53 +0200 (CEST)
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com
 [209.85.219.43]) by mails.dpdk.org (Postfix) with ESMTP id DE0054042E
 for <dev@dpdk.org>; Wed, 10 Sep 2025 21:04:48 +0200 (CEST)
Received: by mail-qv1-f43.google.com with SMTP id
 6a1803df08f44-7220d7dea27so58786986d6.1
 for <dev@dpdk.org>; Wed, 10 Sep 2025 12:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=atomicrules-com.20230601.gappssmtp.com; s=20230601; t=1757531088;
 x=1758135888; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O5CLORycxzUzZGXTs+kr7fOTjhEEdeMYtMIL+2jLHH8=;
 b=yA5nzgFTgOXtFhJHa6OYOOwxQkeRdTJuyjoFdpt5tUmwJUzc7DXUcE/epmlna4p2+m
 8jNoCSogFakI/YXj/w7u/jgo7reN2pT5ektnmg1CerPMUTq7euoNTV6P3hJjRRPWAdc7
 lV0nsxr4eOnkbembLYzPb317Mwc5sSfMZgb20dhmbW3xtcBJH5nnckzDfnLZDh2kcQKB
 dC3epSnm9geTfsltVhm9L7fcvPCmNcpybRUmMLhT4CLpTtOXfRJ7H/cJE8upluMK+eFA
 YbC7sQkm5bYKxesmaO14e8H7zex3XD9LJU4sT8U2e0AiB9MVdmasMU6wnnUWQnQjTAoc
 Is7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757531088; x=1758135888;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=O5CLORycxzUzZGXTs+kr7fOTjhEEdeMYtMIL+2jLHH8=;
 b=K+8N5IEbuVo4hEpJbuTtw8mRw/Hnu1EeshGn6LO7SnJ33dTZeXBsRAISZaARwYQjWV
 4BqjnVJCY9JPQQcqpQLqd+AnpI2u1rRBLQ/dDJoE3QCUuwJb31woMabTiCN6AJmXDyMh
 KHvMnY998b81zpsMf1IwCJVMUNJu3fiFfu+50F1zrnuScgv5Yfvua87D6tU64d/a9pbK
 hyYkbLFDlhOgpgxIxGHCT47dxa0AGSJMxZSrkfB3UBCDUG3yoMLunqazHphaymhAvxSU
 n5Bk8liu6GEl+mnMFiL+Wmwz925ZOeLoBso89hAogb5Geadng0x6h2bS6Dp0n4KBN+vJ
 k3Ug==
X-Gm-Message-State: AOJu0Yydu3qEUGCHYsn+PROyCD9xLOfBz0vtUphbYwCtNEV4kHh7yWtk
 v1lN4YTYpW4ezt52CRwfqyr539Zgka2n7i50ji3958AgQs7UTgh2LwbHf6Qq7QQgxrF47PJpHLv
 C2No=
X-Gm-Gg: ASbGnctsaeL9wIw2YtkTKCeDEWQKQGT0po3Opp44Ct9BN3eArugdGEm5amtj99Al4pn
 Uh/+TGaAFeXZnKZ+W7nLrsX93n9ujSos6805NElLGd/kfiiprj2g8uaFGFAAVZqSOIG3so9bD4e
 Q2hlTG0G64b0mmvFMXNPAmrVjCz4J4oTlP541sTYialGIxT4WqPTXkT43Usdclxdt9TwAAK74Gl
 Rvi9E4YJMvCY2YgisH6DciwMAV5vP7moiu/G696edcSIx6r0DQ2bOrzsAsQCUMf81/hhakt+JBl
 +nhd1sWTrcJgO9awQVHbrVa05ywaJzOavwJCVFsTiezL8Gp/0DIQL9Q8xyyyAz94hov9br7ss9n
 aXBdGzvOTyzawnFizwpdf6FIRqFVXIppXhVSW+zmYUBA7TnjBwC+ZsoNh1/5Pb6lyp+tlSguARs
 ZgiKiYto7X
X-Google-Smtp-Source: AGHT+IH+LcRGnW7v13Fyti9Lymjr9oA3RkRLF3CH49kRtux8Edd/FYQGn4GzrJ+088evHQjzcMMmLw==
X-Received: by 2002:a05:6214:20c2:b0:72b:205c:aad5 with SMTP id
 6a1803df08f44-73919ca39b4mr176945466d6.2.1757531087624; 
 Wed, 10 Sep 2025 12:04:47 -0700 (PDT)
Received: from z690.czeck.local (pool-108-20-194-239.bstnma.fios.verizon.net.
 [108.20.194.239]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-762c81319e1sm488856d6.61.2025.09.10.12.04.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Sep 2025 12:04:47 -0700 (PDT)
From: Ed Czeck <ed.czeck@atomicrules.com>
To: dev@dpdk.org,
	stephen@networkplumber.org
Cc: John Miller <john.miller@atomicrules.com>, stable@dpdk.org,
 Shepard Siegel <shepard.siegel@atomicrules.com>
Subject: [PATCH v2 2/4] net/ark: remove double mbuf frees
Date: Wed, 10 Sep 2025 15:04:34 -0400
Message-Id: <20250910190436.995899-2-ed.czeck@atomicrules.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250910190436.995899-1-ed.czeck@atomicrules.com>
References: <20250903212846.268492-1-ed.czeck@atomicrules.com>
 <20250910190436.995899-1-ed.czeck@atomicrules.com>
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

From: John Miller <john.miller@atomicrules.com>

Fixes: 8b154b690266 ("net/ark: add Rx initial version")
Cc: stable@dpdk.org

Signed-off-by: John Miller <john.miller@atomicrules.com>
---
 drivers/net/ark/ark_ethdev_rx.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/net/ark/ark_ethdev_rx.c b/drivers/net/ark/ark_ethdev_rx.c
index 80e431f1ae..6077d98ae0 100644
--- a/drivers/net/ark/ark_ethdev_rx.c
+++ b/drivers/net/ark/ark_ethdev_rx.c
@@ -538,7 +538,6 @@ void
 eth_ark_dev_rx_queue_release(void *vqueue)
 {
 	struct ark_rx_queue *queue;
-	uint32_t i;
 
 	queue = (struct ark_rx_queue *)vqueue;
 	if (queue == 0)
@@ -551,9 +550,6 @@ eth_ark_dev_rx_queue_release(void *vqueue)
 	/* Need to clear out mbufs here, dropping packets along the way */
 	eth_ark_rx_queue_drain(queue);
 
-	for (i = 0; i < queue->queue_size; ++i)
-		rte_pktmbuf_free(queue->reserve_q[i]);
-
 	rte_free(queue->reserve_q);
 	rte_free(queue->paddress_q);
 	rte_free(queue);
-- 
2.34.1

