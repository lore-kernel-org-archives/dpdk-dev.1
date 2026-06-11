Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13995CD98CE
	for <dpdk-dev@archiver.kernel.org>; Thu, 11 Jun 2026 15:51:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0754B4335C;
	Thu, 11 Jun 2026 17:50:30 +0200 (CEST)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com
 [209.85.221.52]) by mails.dpdk.org (Postfix) with ESMTP id 9C5004330E
 for <dev@dpdk.org>; Thu, 11 Jun 2026 17:50:28 +0200 (CEST)
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-45ef29c5561so4390718f8f.0
 for <dev@dpdk.org>; Thu, 11 Jun 2026 08:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781193028; x=1781797828; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p4/IilRQ6NRLtgSViNGmLo0q6/3hir/4gBl7aOUJync=;
 b=QML9L0qc+0i3FkuR6pV4YjxHqIts7SrWsAPEcmJ02Rjh+iU/5V7gnu8RcKeRWbT5KG
 evlSkQlyyu7VMNTg2wkMIIz333pNvCMsnF3K6J925iBOJvkUk0P7Il/5z7hiym+z5m+j
 0XVV+ADcbwsqwrkwu6Ot96KP7zaevVp0LMSURzhTQJCuZbq31kQxTgu0R1AOULFpvZsH
 pygPyYOE9KFeUhqepQsElFThK/LXIjnFp2mxB7ARToAndi7AZVxQFK/y6uyyxTU6tHxF
 5y0yYFYrnw0lU1Fw3fqYRhfeXZMMcbMHlDcWvyq2ZuPOhVbLW9xO1ppIxx3/dG9r9EDT
 fGSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781193028; x=1781797828;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=p4/IilRQ6NRLtgSViNGmLo0q6/3hir/4gBl7aOUJync=;
 b=kipezZXnQegJGEaK9c8beESHATdZ33LWO53Okgce3XIK9eRnB4LlX+GQuM1hJIZKKu
 M9dUNzslc7PqXLcWaN6hLsaOfEWR/fLIC+bUEoESeDoGtHfSzoE3SRg1yxuTLL/dCDrS
 eMTxX3klCj7XNK3xynosJ7YjxTw/XK678QrIgwC0PYxUs8RJqUzpcMIlSthBnJ9U6ibV
 nYRjSXO0MFoegZY8diMR6+/ayg2glJ1uv84cdtXr0GJApDv2bDn0pPC2scCTqsrb8xMa
 0wWhcZCeqrf7lIfzWYWasFbX/L7xU6nIOpb7OtLtUDDlEWH1xJWFLphrgxiIg9Ij7zJC
 C02A==
X-Gm-Message-State: AOJu0YyN5Rx2favzYzaiq4jZLwSIp5ZGxwKfa7FX4hqcVFG8JS1qZTh4
 Ax7XOeHImgFOm7BrNVSO1WYEh7Se0jFCKyaI4mrZSadv2yB4W3J63i0OG+phW1o3
X-Gm-Gg: Acq92OEaen6Z5qDaEbbmHNBqfkeYu8OxUlBmAR2r8NGan3NOvQ+F7heYf/jzQOH4CDJ
 jFSQ4u+BENrpYizCI2VLHHsErfkntA56sN4B227gozvQ7Tl7yNFH+RjQ/lcrmuZWlwFZ7Vkyftz
 a528b+rTiB+OAoz9GCCiuTLQZBMUOxE8Uiy1ox9FTKR5JKgjmW5+DPCiXdrluYys3Uvym2Utg19
 Kt9G3BL81rF1t07StdKnPmNLcGr+Rneh4Om+V5jSzCFcQ7+wD+iGObNnaEP8mgeOp2TB0e/6QEG
 eimrjTMerTGHKPeTtbdfRFEKM9oBABHAskAm3icwaHVsee/umzRTm0kepqqdq8e8eqE3A4tm+CB
 vZqK4ZmmkAAwppJTx1zQD7PTMVjmwoJrnG/pclniVilCZT03eL0XRMWaknSB5TxbwSvFzOJ3oR9
 gMjrntwjzlMpjDPGb0QM/wHRt2gwanRjeanyJ36ns2DFci6CcUYHZT8X7tz/fPPUc=
X-Received: by 2002:a05:6000:ecb:b0:460:6731:6165 with SMTP id
 ffacd0b85a97d-460677aeb24mr4349635f8f.22.1781193028020; 
 Thu, 11 Jun 2026 08:50:28 -0700 (PDT)
Received: from freepad.iliad.local (free-mobile.vlq16.iliad.fr. [213.36.7.11])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f2dcad5sm91100069f8f.5.2026.06.11.08.50.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2026 08:50:27 -0700 (PDT)
Sender: Maxime Leroy <maxime.leroys@gmail.com>
From: Maxime Leroy <maxime@leroys.fr>
To: hemant.agrawal@nxp.com,
	sachin.saxena@nxp.com
Cc: dev@dpdk.org, Maxime Leroy <maxime@leroys.fr>, stable@dpdk.org,
 Thomas Monjalon <thomas@monjalon.net>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>,
 Sunil Kumar Kori <skori@marvell.com>
Subject: [PATCH 8/9] ethdev: keep fast-path ops valid after port stop
Date: Thu, 11 Jun 2026 17:49:23 +0200
Message-ID: <20260611154926.392670-9-maxime@leroys.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260611154926.392670-1-maxime@leroys.fr>
References: <20260611154926.392670-1-maxime@leroys.fr>
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

eth_dev_fp_ops_reset() restores a port's fast-path ops on stop/release
via a compound literal, so every field it omits is zeroed to NULL. It
sets only rx_pkt_burst/tx_pkt_burst (and the rxq/txq data), leaving
rx_queue_count, tx_queue_count, rx/tx_descriptor_status, tx_pkt_prepare
and the recycle callbacks NULL.

In non-debug builds these ops are reached through an unguarded indirect
call (the NULL check exists only under RTE_ETHDEV_DEBUG_RX/TX). So a
thread calling e.g. rte_eth_rx_queue_count() on a port being stopped
dereferences NULL and crashes, while the same race on rte_eth_rx_burst()
is harmless because the burst ops are reset to dummies. A poll-mode
worker re-checking rx_queue_count before arming the Rx interrupt and
sleeping hits exactly this.

Reset these ops to the same dummies eth_dev_set_dummy_fops() installs,
so a stopped port behaves like a freshly allocated one: every fast-path
op is a safe no-op, none is NULL.

Fixes: 066f3d9cc21c ("ethdev: remove callback checks from fast path")
Cc: stable@dpdk.org
Signed-off-by: Maxime Leroy <maxime@leroys.fr>
---
 lib/ethdev/ethdev_private.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/lib/ethdev/ethdev_private.c b/lib/ethdev/ethdev_private.c
index 72a0723846..75ea3eedff 100644
--- a/lib/ethdev/ethdev_private.c
+++ b/lib/ethdev/ethdev_private.c
@@ -263,6 +263,13 @@ eth_dev_fp_ops_reset(struct rte_eth_fp_ops *fpo)
 	*fpo = (struct rte_eth_fp_ops) {
 		.rx_pkt_burst = dummy_eth_rx_burst,
 		.tx_pkt_burst = dummy_eth_tx_burst,
+		.tx_pkt_prepare = rte_eth_tx_pkt_prepare_dummy,
+		.rx_queue_count = rte_eth_queue_count_dummy,
+		.tx_queue_count = rte_eth_queue_count_dummy,
+		.rx_descriptor_status = rte_eth_descriptor_status_dummy,
+		.tx_descriptor_status = rte_eth_descriptor_status_dummy,
+		.recycle_tx_mbufs_reuse = rte_eth_recycle_tx_mbufs_reuse_dummy,
+		.recycle_rx_descriptors_refill = rte_eth_recycle_rx_descriptors_refill_dummy,
 		.rxq = {
 			.data = (void **)&dummy_queues_array[port_id],
 			.clbk = dummy_data,
-- 
2.43.0

