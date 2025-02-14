Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0345C021A4
	for <dpdk-dev@archiver.kernel.org>; Fri, 14 Feb 2025 17:43:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7742540A70;
	Fri, 14 Feb 2025 18:42:45 +0100 (CET)
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com
 [209.85.216.54]) by mails.dpdk.org (Postfix) with ESMTP id 400C6406A2
 for <dev@dpdk.org>; Fri, 14 Feb 2025 18:42:42 +0100 (CET)
Received: by mail-pj1-f54.google.com with SMTP id
 98e67ed59e1d1-2fc1c80cdc8so3039242a91.2
 for <dev@dpdk.org>; Fri, 14 Feb 2025 09:42:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1739554961;
 x=1740159761; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AzA8WAPrkM0wRCSPl+1qS/cMiO7HcMgUtJjy29TPsVA=;
 b=bXrS/FFGCL1OxPr2Zr14aA1MUJxu0u0xQWgpIlewz/FzZ/0P/lkHFdEcElwI4K2gSX
 I6+4xnqbhig8xMcWKrqGr2IYnzoCik+IBca+/ZZJ/Rkoxk3PJGeK/wLWiXgryOcK3uCj
 r3zRyhwfIuXUIQ872S2U7pdXkM6YstrLHdj8mzHx8xPmcpU/QoEwqe7qXAUOz3LfgPNu
 +I0GAEQQpcslwbxoVxeb8YPMte/+5a9XIlBVV4WhatSkaIXVbPFbX5p0m3eI1L/i2XKc
 lKFral4tKpQ/5bOa2CLxvWRiEg09Dm9b93rECROQ9GZP1fKHkl5j1ldYNLlccUNj3dlN
 3ZCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739554961; x=1740159761;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AzA8WAPrkM0wRCSPl+1qS/cMiO7HcMgUtJjy29TPsVA=;
 b=XV1G+nCyTqBBCZXUBxZEY0eZY6JOtMp5YNk3aEHELRLIXemuSI+Qn4cSs52L9cgHUb
 afoEdNFPMfECGLLtE3SelNSweeDtNWZegpx/cEcceKuvuB9uuCsCUxoCusLEeeBDfDZX
 LMVRF31LoPQBOjgzfnCONI9kIfnorfpew190/gXx/gnpRoh+N+L66dTVtDJpLS08aka3
 eO8xhHCZHAdC8oH1CxiA6L7bF9D23/6AL6tSCe+QEpfVMvg9KWNhe7J8nbu3DcgEwy1t
 ANH/vEowgZl67uM4IaVAKDX/Yfyf/AR++n7JyAv3eWgn6Ty/mjWPEFTZq1VYQWTFyVXW
 V0tQ==
X-Gm-Message-State: AOJu0Yy9n5SckWEww/B7duYsuUxFjUsf3AnFbCePBOE7qjUyCORpmdJk
 SfS6oJZNzIIK5NE2UHd27kcn7UCmEh21QD3oijOWY+OKDrfNOQipo8lLwT2qBdG9KaeBsQ8xbaZ
 Bvgc=
X-Gm-Gg: ASbGncvjEdHRvuCRnRAQrVd0RNY/mybydolZ06MsDPwYX9nFbhFLl9l34ic9CNLG5C/
 ijpXeQtmoZIadEl/cmyu3XWVKrdUzFh1R7G0Rfn8855eW9n30oLszIqWxmfMSVOaeNTvOrJ1AEu
 iTWyN8LBZJSv4YeQfVMkBbT99LXojjvEWTiG+Szzjd7WGpcND+b24UOaYQx9HTb74sfE6mRHFhE
 OyMZd8adcK63ktISjNMefAHMIrfvavWMPOo2f/E/5npV8Ah3LO6Myhrln3rPkx6MRZGDvf5xaxG
 e9PUf7t33mOtcFxcsUI8nK/FxLF9JI1JP5Xm2iFP+KJm12Nqet9gY44ERquRukaWcl+O
X-Google-Smtp-Source: AGHT+IFZcGreT8sKpq5s+tGACijV5R2UM6XjJGUJKlAQCm9szH8zCB+4gofzI4a6P3gvFXwTyKdViw==
X-Received: by 2002:a17:90b:5243:b0:2ee:d96a:5816 with SMTP id
 98e67ed59e1d1-2fbf5bf360emr20400256a91.10.1739554961502; 
 Fri, 14 Feb 2025 09:42:41 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fbf98f48eesm5449852a91.22.2025.02.14.09.42.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Feb 2025 09:42:40 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Maxime Coquelin <maxime.coquelin@redhat.com>,
 Chenbo Xia <chenbox@nvidia.com>
Subject: [PATCH v2 6/6] net/virtio: remove unneeded deferred start check
Date: Fri, 14 Feb 2025 09:38:59 -0800
Message-ID: <20250214174224.79142-7-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250214174224.79142-1-stephen@networkplumber.org>
References: <20241213214929.817688-1-stephen@networkplumber.org>
 <20250214174224.79142-1-stephen@networkplumber.org>
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

Already checked in ethdev now.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/virtio/virtio_rxtx.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/net/virtio/virtio_rxtx.c b/drivers/net/virtio/virtio_rxtx.c
index b67f063b31..6ae3a6eb12 100644
--- a/drivers/net/virtio/virtio_rxtx.c
+++ b/drivers/net/virtio/virtio_rxtx.c
@@ -654,11 +654,6 @@ virtio_dev_rx_queue_setup(struct rte_eth_dev *dev,
 
 	PMD_INIT_FUNC_TRACE();
 
-	if (rx_conf->rx_deferred_start) {
-		PMD_INIT_LOG(ERR, "Rx deferred start is not supported");
-		return -EINVAL;
-	}
-
 	buf_size = virtio_rx_mem_pool_buf_size(mp);
 	if (!virtio_rx_check_scatter(hw->max_rx_pkt_len, buf_size,
 				     hw->rx_ol_scatter, &error)) {
@@ -819,11 +814,6 @@ virtio_dev_tx_queue_setup(struct rte_eth_dev *dev,
 
 	PMD_INIT_FUNC_TRACE();
 
-	if (tx_conf->tx_deferred_start) {
-		PMD_INIT_LOG(ERR, "Tx deferred start is not supported");
-		return -EINVAL;
-	}
-
 	if (nb_desc == 0 || nb_desc > vq->vq_nentries)
 		nb_desc = vq->vq_nentries;
 	vq->vq_free_cnt = RTE_MIN(vq->vq_free_cnt, nb_desc);
-- 
2.47.2

