Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88249C54F4C
	for <dpdk-dev@archiver.kernel.org>; Tue, 28 Jul 2026 14:12:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D1BAB4064A;
	Tue, 28 Jul 2026 16:12:37 +0200 (CEST)
Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com
 [74.125.224.49]) by mails.dpdk.org (Postfix) with ESMTP id 3B9CB40615
 for <dev@dpdk.org>; Tue, 28 Jul 2026 16:12:37 +0200 (CEST)
Received: by mail-yx1-f49.google.com with SMTP id
 956f58d0204a3-664db84f074so5109402d50.0
 for <dev@dpdk.org>; Tue, 28 Jul 2026 07:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1785247956;
 x=1785852756; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=q0d8QHEACQPCOnqFLiNaCi/kihGdqxWXGeutgymXOJY=;
 b=Si36dUM4C3FsD/c3SvkH5+Hm5VOOdT/cAK6DZoducG/tarWNVOVNLs3UTNn1b8jM2V
 S/wRi+RY9h97yiChNL/rwKfF3/7R/NGFJfxs5DnqZJUIK291IKGt0tvtEOecRqFKG07J
 WrkmoKSVJ/VapCx7mrQ8wSkDH0ATRt4qT1fM182B5sy4YIjK0krWu1J43SUky8TEEi16
 Q1jMWwVBjr5LE6+rdqPA/ce6sTRao6JPT561ZzG6jaFNWilOHuPJb2GxlGfQ/JUH+Cuz
 Iz9b6Fdn6DSELjdFEmXvNLOhcnMqwF6kaw5708XNxaOWlObob40P9F2UwMtT8x9zY9Sd
 d3Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785247956; x=1785852756;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=q0d8QHEACQPCOnqFLiNaCi/kihGdqxWXGeutgymXOJY=;
 b=ApCi1mAyG8dFSaMaqhGMcZdbeCW/Bulisz13E0uNsTv+5R/Yrv6qCjT233Ni7QImKy
 BkJKjwyzfIri0Bw8I7A3Z2D3hlPzweU9adWmVe4gWDQk0zaLb+ci3YzJgsS8NKR2jE+d
 StoLe+3biYPedygIzxdasFREdqjhrDXdJUnXk1zr5Z4S5ktJ4vHz83pCshn1G2LiJOjQ
 otNT4skZzKTumcRUjP7YwbP2lgmOSd181+Le6umbRTLxD9laz0BfeHVFG4/otkD/kG5r
 g3fRKQjinAYMFsV1nyR4InA18HX7fLf7UrVzdg4gRI9cYBvIkXr0A7irxMZBC6IfeZve
 Cjww==
X-Gm-Message-State: AOJu0YxbSMTfxgmj0iM8pbtn0gxDgVG1CytPWmrzoHXvXUnM+0zjjcPd
 xMaV72Mc1sWXzyChaGnLv5hgbOtqBcSl7Qc2Wf6PqNG5OznxN6GBRXZAAjaBDQzpQVzkSF1M8mk
 bgIvl
X-Gm-Gg: AR+sD1310poT8QGZ9abqVTP56xTtG9sqmIv3Za+hQJ0cTfLEKMJpWfjEjUYBV08pZDO
 q8NzrVvZ51KLNBoyxC7B+EwmmWVM/O6nT3LfxOi1ojN5RqGl1W1ZzY48oNKHwOck4pd6LpOu62b
 cRYvjhVLkgoHWkqa21RjTRqwJRLVDwz0eWmlrNbUrr66yNzR/6QKoNE5TDWlTpt1jYz1PjmJRm1
 WLL2IAuJQlp/AAGsp5eUanKlKb8/QfnGvMmroA6kcHxPWQzmfkwwEb0Vad7HlQo3qkpjvxpHiHs
 5Q/tM0F9MrIz9Nedy8J0MZteB0i5O2C31/UjgqEO5rwrbq3Jspq0cjZz5ZZOBN1yxR3/gNwecf4
 5vQmLi3LkfIpYwAEylppkUt9ditpAMZuj3qo80yn+Z+XxgJFMSME0KOcXCItRCHfHxVdB+qPsEZ
 cJeacHQzKnY9bMw7qrxcxPGhijKD3gdIlg6YLMgzqUF8igsB/X/ao=
X-Received: by 2002:a05:690e:4550:20b0:667:b8df:c65b with SMTP id
 956f58d0204a3-6690582868cmr628145d50.86.1785247956602; 
 Tue, 28 Jul 2026 07:12:36 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-668c6f6aea3sm5065610d50.12.2026.07.28.07.12.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 07:12:35 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Jeroen de Borst <jeroendb@google.com>,
 Joshua Washington <joshwash@google.com>
Subject: [PATCH 2/3] net/gve: remove unnecessary check for NULL
Date: Tue, 28 Jul 2026 07:11:44 -0700
Message-ID: <20260728141229.93878-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260728141229.93878-1-stephen@networkplumber.org>
References: <20260728141229.93878-1-stephen@networkplumber.org>
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

Checking for NULL before calling rte_free is unnecessary.
Found by cocci/nullfree.cocci script.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/gve/gve_rx.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/gve/gve_rx.c b/drivers/net/gve/gve_rx.c
index 567b82d020..932293ddad 100644
--- a/drivers/net/gve/gve_rx.c
+++ b/drivers/net/gve/gve_rx.c
@@ -205,8 +205,9 @@ gve_rx_burst(void *rx_queue, struct rte_mbuf **rx_pkts, uint16_t nb_pkts)
 		if (gve_rx(rxq, rxd, rx_id)) {
 			if (!ctx->drop_pkt)
 				rx_pkts[nb_rx++] = ctx->mbuf_head;
-			else if (ctx->mbuf_head != NULL)
+			else {
 				rte_pktmbuf_free(ctx->mbuf_head);
+			}
 			rxq->nb_avail += ctx->total_frags;
 			gve_rx_ctx_clear(ctx);
 		}
-- 
2.53.0

