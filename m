Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DF6FCAC58D
	for <dpdk-dev@archiver.kernel.org>; Wed, 10 Sep 2025 18:57:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B637040665;
	Wed, 10 Sep 2025 20:57:33 +0200 (CEST)
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com
 [209.85.219.44]) by mails.dpdk.org (Postfix) with ESMTP id B87254042E
 for <dev@dpdk.org>; Wed, 10 Sep 2025 20:57:32 +0200 (CEST)
Received: by mail-qv1-f44.google.com with SMTP id
 6a1803df08f44-7211b09f639so77623116d6.3
 for <dev@dpdk.org>; Wed, 10 Sep 2025 11:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=atomicrules-com.20230601.gappssmtp.com; s=20230601; t=1757530652;
 x=1758135452; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O5CLORycxzUzZGXTs+kr7fOTjhEEdeMYtMIL+2jLHH8=;
 b=yO3/bBJsZKr+9x1pG5RQQRnqhzvySbVZXr3OKNAF+34dnC7AGPI4uVWzvcs7HSSiHA
 jtbC3mBP6ZoWoMcp0/5k+eqsUGmpzBitiPyyeeYocSNikCH4Q/oUVpY71T2oMWX41pfl
 CKbeM4Vn2kbv+0Ox+oJiBztPo6Jv+oZy7C6EM9yTqK+3g27yOQitHt1nHQXr6f5x3W3P
 j5L6WIdvP1tTBHIpDI+QXrOdISiFt2cikOSiCglWLml8cpNoXeH5HZDwAm/wjHRsqvO6
 D6V9FbOIrFBLKy7m90QsGFcx73NraQjLgqUQk6dTi3Uh1j1wNLkMZf8adVY92joeMEZz
 AZ8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757530652; x=1758135452;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=O5CLORycxzUzZGXTs+kr7fOTjhEEdeMYtMIL+2jLHH8=;
 b=UqzdNLcGmP43VRGBE1sXQDV0Vg5bNWGLdE/MP8W9jJS6SUDb9fVXIZ4NeCyP0jKMgA
 OS+4rbHCsVdDlvxrbPjHu88qKu/PYlNiY1Cpxl6gVGt43sq8USA4kSXEPOLk0D1NCqgF
 WA+1lrzfUAdpJ+uix5fh4U5ZYV44jobhv6Bs0cL4ntPRkVUj5uO5OLnnCJu64VnbcDwU
 VfEb1XVQfUvvloZV2IPzuk7t3dD73uRzZe+hzQxDDf2wxTlKnQP6wBQJT28v/J58fj+i
 IaHtIijIGC9LMceSwMRWVgEE5teQ+362407F+v/nmB/YTNT/WDfvQPTaUgMdctdpPmE1
 mOQw==
X-Gm-Message-State: AOJu0YyZHeBQjIBsQT2c4c2eWx/nzI2vmhuaIN+csYomDbVDeQQuWP2f
 xVaXtzwqjQuzsBoUEF040RBGVsVFc6Scce0r43sQxVjDgiwjs8iJV4G3e6ozXd2uMJ4f34hG06f
 3p9I=
X-Gm-Gg: ASbGncsAgwYyw+SoIcmIPmlERaXH147xaaNjAW+EB64enAxPhRsIf3sNMyOya6uculV
 7/mZ1T+ahE1lNbbf556gEEA13dp/5AIKSHWThmluODYLy/57+gywc5leBL40DvrN8DBzPff9a7s
 VCq34ULP8UOrAP/vSidhYjITp4IAXUyKleMYL0UNL1UXmYFFYTHXnA7/ii6MSN/XArysDWki7Zs
 04YlyTBbQXj6c0jB70UDo0U5vtWWXG5s6Hady8u+rfuv4BILMLilCJ9GQ9Uz/RMgdq0snh++gbl
 yVV4JIjLQjuQcWxkBISoCIYKn+Ml/zVANULyZSb2jrAdbkS28T6knDLxUIUgj8oTjujaDRZB1Jb
 /GOa+TGEKAUTs6UTrLjD0/Cf4yfhlhad0kGa/5KkxAGvkUCSJ+Et7PHe0DX+Pr0h1Fec5H2017H
 xU88xUGr4h
X-Google-Smtp-Source: AGHT+IHuHlMLLp3aAhgr2+DQofRovKjfppjC8HYxy0wUd6EJJNiynrEbbTJUifgFjMvbt2D9NpidGA==
X-Received: by 2002:a05:6214:cad:b0:756:a4cf:b1df with SMTP id
 6a1803df08f44-756a4cfb444mr95691166d6.18.1757530651627; 
 Wed, 10 Sep 2025 11:57:31 -0700 (PDT)
Received: from z690.czeck.local (pool-108-20-194-239.bstnma.fios.verizon.net.
 [108.20.194.239]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-762c955968csm376176d6.73.2025.09.10.11.57.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Sep 2025 11:57:31 -0700 (PDT)
From: Ed Czeck <ed.czeck@atomicrules.com>
To: dev@dpdk.org,
	stephen@networkplumber.org
Cc: John Miller <john.miller@atomicrules.com>, stable@dpdk.org,
 Shepard Siegel <shepard.siegel@atomicrules.com>
Subject: [PATCH v2 2/4] net/ark: remove double mbuf frees
Date: Wed, 10 Sep 2025 14:57:18 -0400
Message-Id: <20250910185720.995300-2-ed.czeck@atomicrules.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250910185720.995300-1-ed.czeck@atomicrules.com>
References: <20250910185720.995300-1-ed.czeck@atomicrules.com>
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

