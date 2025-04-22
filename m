Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFDEAC369C2
	for <dpdk-dev@archiver.kernel.org>; Tue, 22 Apr 2025 15:52:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 26239402ED;
	Tue, 22 Apr 2025 17:52:05 +0200 (CEST)
Received: from mail-ed1-f99.google.com (mail-ed1-f99.google.com
 [209.85.208.99]) by mails.dpdk.org (Postfix) with ESMTP id 6CBE3402DE
 for <dev@dpdk.org>; Tue, 22 Apr 2025 17:52:03 +0200 (CEST)
Received: by mail-ed1-f99.google.com with SMTP id
 4fb4d7f45d1cf-5f4ca707e31so7906960a12.2
 for <dev@dpdk.org>; Tue, 22 Apr 2025 08:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=6wind.com; s=google; t=1745337123; x=1745941923; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tic0nB9QoVQwCHegH443hnxy0e4lI6cJNi9ZpjBtsu0=;
 b=WN3Wxuc7c9QIqknnf+cPtLVuqHKyBf7a6mJ+EqPV7eq3ikUvIMkG7R19yGOlPOuPCV
 nJUJwcon4he6KlecU7kdBEpPaQ5NUe5xjeKxE4GINz/CctqNIcBg3SwwjlQ/SMbW51cm
 ypiPfInoYIhGG+YpARm66ugRiOs2fuxJrWYPijdMj0fS7QqEFS8oqQc+vUUnkvCqlDgg
 5BLGV57cbajoq2jy+6VhTwg9sQqh4h/bcSWYJ/RUvItSABcT2jhDv5Ue8uuqrbVyCVWe
 klrB/uhMCliUcaeN+f0FfqVqDiRbA78XfA9BBPNajbI9o9udv7HI68x0EJ6PR0+JPQ5e
 zwWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745337123; x=1745941923;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tic0nB9QoVQwCHegH443hnxy0e4lI6cJNi9ZpjBtsu0=;
 b=ofUxMokonnmz14tcq4Duab2GsAwC84s23KF7eWqvvhRwO2wD4et8LutK0+PnWet7WS
 5OUVYNwSlX++AEv9KzUayRXpeKLk/hytuIYHXn9knwjerLhZ2GEdqUaluVrUoxg5PwUP
 /VxE/dT7Zr08DanL6frIYJ44UztcLLXalxRjaMFc4ZWnByEj6kJsCaiz0Ci2O3qUuFkb
 1UFWxvwnT02P8CC5VzKYaTWyLD9knSzNlLN8dBEaO32S6XZX9f+9f0L8TSXYlJ+PVhlj
 iKqGQpcTQaYjPcnjJvFlmbG0v1KjTLFwTrc65Oat2FG/wsGJnJAl/FzflTchjV4g8vNg
 vv+g==
X-Gm-Message-State: AOJu0YyCsLDAplBxRDS2DjeSP9PrqmtcD/g8ZazF4t8MiZl+lVMssP+l
 nw8djqVx4L8cOCt7o4OI6OusIctOn/HYEuCmzOJAifEvQZ/rf7V1ymMBaPNs68LRbqlfLkqMFyO
 bKy82sgnwXd8cXu7PbzCSu5kHHyyXnS7ELKHrJHT4
X-Gm-Gg: ASbGncumFfiJlBOMILHWXhslavGb01gp5GwYQ+rbUiyNRT4cP0BQQWPHUQ2ZdkvrxEm
 1SHqj9C3JFPhFta2nPbfgrm5DkNnT7bdvByUe4M42T8Qcn0foobyPrPcG65VtdIkaTa06H8G33j
 V+HIl8hWDOjpGTLBfn94UZTsqJAI8HQh0Xwr/5Tyu9wFn4FJtjQqnB5jMBQVLzsWudvZlC2i41Q
 og3BrVwIdnLAJfSWamvUTk35O/GUsidsC+VoP740NVeEZ2dLN58Gj0RdM2j7gKW74D5iPLPxb27
 j9o5rXGRGEmeGKR5TRhotXS3tYcWCvV8ZgAiKnWdGq0Jss8hZajz5sAFj1Iy56QvCDA=
X-Google-Smtp-Source: AGHT+IGxqQaIzB6Ybw20btXqGSEKKGqPyBTPV9qqaeD/V7XpSr6iCSwWAXnAJAZIehlKD580fEJplhETcvLc
X-Received: by 2002:a17:907:3f24:b0:aca:d6f2:5d5 with SMTP id
 a640c23a62f3a-acb74dd4b4amr1345910966b.39.1745337122756; 
 Tue, 22 Apr 2025 08:52:02 -0700 (PDT)
Received: from smtpservice.6wind.com ([185.13.181.2])
 by smtp-relay.gmail.com with ESMTP id
 a640c23a62f3a-acb6ef28d90sm64621766b.126.2025.04.22.08.52.02; 
 Tue, 22 Apr 2025 08:52:02 -0700 (PDT)
X-Relaying-Domain: 6wind.com
Received: from localhost (dio.dev.6wind.com [10.17.1.86])
 by smtpservice.6wind.com (Postfix) with ESMTP id 67902360D9;
 Tue, 22 Apr 2025 17:52:02 +0200 (CEST)
From: edwin.brossette@6wind.com
To: dev@dpdk.org
Cc: olivier.matz@6wind.com, didier.pallard@6wind.com, lauren.hardy@6wind.com,
 dsinghrawat@marvell.com, palok@marvell.com,
 Edwin Brossette <edwin.brossette@6wind.com>, stable@dpdk.org
Subject: [PATCH 2/5] net/qede: fix bad sanity check on Rx queue release
Date: Tue, 22 Apr 2025 17:51:40 +0200
Message-Id: <20250422155143.3893525-2-edwin.brossette@6wind.com>
X-Mailer: git-send-email 2.35.0.4.g44a5d4affccf
In-Reply-To: <20250422155143.3893525-1-edwin.brossette@6wind.com>
References: <CANDF9xDNq9Yy+FujvGcc3r1ycjbJDJmnP4_ih+LEm-07=jHDcA@mail.gmail.com>
 <20250422155143.3893525-1-edwin.brossette@6wind.com>
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

From: Edwin Brossette <edwin.brossette@6wind.com>

As per the rte_mbuf API: the driver is responsible of initializing all
the required fields. This is not done at qede alloc, meaning there can
be garbage data in mbufs memory, although this garbage data should be
overwritten when the mbufs are used. Since a sanity check is done when
freeing the queues, its possible some remaining garbage data causes a
panic when trying to release the queues if some mbufs are being
processed.

Use rte_pktmbuf_raw_free() instead of rte_pktmbuf_free() as the sanity
check is more relaxed.

Fixes: 2ea6f76aff40 ("qede: add core driver")
CC: stable@dpdk.org

Signed-off-by: Edwin Brossette <edwin.brossette@6wind.com>
Acked-by: Didier Pallard <didier.pallard@6wind.com>
---
 drivers/net/qede/qede_rxtx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/qede/qede_rxtx.c b/drivers/net/qede/qede_rxtx.c
index c764e3d83763..601fcb30b357 100644
--- a/drivers/net/qede/qede_rxtx.c
+++ b/drivers/net/qede/qede_rxtx.c
@@ -305,7 +305,7 @@ static void qede_rx_queue_release_mbufs(struct qede_rx_queue *rxq)
 	if (rxq->sw_rx_ring) {
 		for (i = 0; i < rxq->nb_rx_desc; i++) {
 			if (rxq->sw_rx_ring[i]) {
-				rte_pktmbuf_free(rxq->sw_rx_ring[i]);
+				rte_mbuf_raw_free(rxq->sw_rx_ring[i]);
 				rxq->sw_rx_ring[i] = NULL;
 			}
 		}
-- 
2.35.0.4.g44a5d4affccf

