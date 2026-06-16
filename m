Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 363ADCD98DA
	for <dpdk-dev@archiver.kernel.org>; Tue, 16 Jun 2026 09:43:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 40AAE406BB;
	Tue, 16 Jun 2026 11:43:11 +0200 (CEST)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com
 [209.85.221.48]) by mails.dpdk.org (Postfix) with ESMTP id ABDC4406BB
 for <dev@dpdk.org>; Tue, 16 Jun 2026 11:43:09 +0200 (CEST)
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-45ef56d9b67so3686155f8f.2
 for <dev@dpdk.org>; Tue, 16 Jun 2026 02:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781602989; x=1782207789; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Gc02EQv5QA6SxV+V+dDP9i6L6+UcqtHQ/X5gxIR96yM=;
 b=ddCaUW3oi5WCFvT3YULB48x3V/0rn7YWKPseg6Yn9zwkIsD6vN4jbD2IQsIrEdNweE
 ZYqNaZLJvQKBB2bxqYmKxt4L3i7B8CSQYHdzHWPmzsAQLpAR8JPjj8wTBWDEDBYqNzfL
 E8F+aClUWNAkvW6DqlBPMHenivEx3zj5dvbxtKHnpjGyXTJ72C0/3bKyEJQsezsoVT5E
 5EDsN16ETVoWZ6a1gCi4gAVFd0TtfjUnVxQh6ith+FGxoP/uhO2HYMeF9ySL4UWbqyTC
 JC4lj7F9lWwoU4r9GIgMI10132hfoS/fYYwGscBn1WI80KRyArS0QNPrvGvzaOree1cZ
 xVEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781602989; x=1782207789;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Gc02EQv5QA6SxV+V+dDP9i6L6+UcqtHQ/X5gxIR96yM=;
 b=frkcrcTQWQJS6i43t4FbFPpmRC3bRMilXaV+g8FFPDCoTwngWvrSY8ArsDF2kC2qQT
 TBCishebL/MsqGJAk8M8KnRBcZRD+GVni3mTXABA2I+ZaBD6qHZ2qPgmt+iwg1SdOV1J
 p+91qf+GQ/3Eg+5EmCjaLeSgM6HCK+2Ra7YTsKj7LUof6xyjcfuYsQMxmeTFz+7uZGca
 SclHD+u1cuqPnVSMSI0hIE82VW/ZbexUyYCBuVmOOZWmqGDcaDEfnDjfFX3NiS+vOhNU
 YnfcjHvBuqtGJvPRgcfMw6CbJVw8twfYlVJ6jMm3n8lRBVsYqKMGawIkP/NqdYpmp8O4
 o2RQ==
X-Gm-Message-State: AOJu0Ywe8IVcOBeaMIfKEiHiZa9wUXiKfAGOtKfJrNoecTaUGi7aMXpU
 ci+PdWP8bAHZzgeGJKmTtVGXS1R3z73XMeKhqOgaHoizi58jVwPResHCA8d1gew8
X-Gm-Gg: Acq92OHOY+fT0r2kiTBYg581Q3DqdqeBCPHmD4RI4YzdZ/8Rjsu5RvAalmN76+IWFCQ
 cTVJYgn1UUmlM6OUK8gvpVGWaV/hy9baQWwCaXJF11THVHSs/0qBqAsyAZtivPpnraxi5meajKQ
 I1g5JLsvLPykcpl06CJ0S2B6aAHm72FLWs5HazhGA7a2fqS+MdY0GCPipFbQocZvcThyvvvOSMy
 wZRlxtkTO06ZT49aYS5MyaUHqmTEpcGqMh3OnVh2IiXayltCng/wi1g6saqTPzMDJVVI++NjgJp
 Czb+dewZZkuTZN0mOWIfaQIbQSvnJvAo+kLzUJ/UHtduCKX9t5we1q1JOpQ6ppHOdesqfBdJ0dq
 UYXK88k6QR9J6MukYcYq5pmGi5+jzmh/hLfRbxYGNH12MjqJMyNm92cFFfz6JfKXOSE9F3wV++P
 0p3QiDVBCrQ61V2Rxgr+M3w3gzQ+GM424/aQDvwoah3e8x0MPp/+mU
X-Received: by 2002:a05:6000:992:b0:460:6a83:222b with SMTP id
 ffacd0b85a97d-46079db7283mr20286526f8f.28.1781602989164; 
 Tue, 16 Jun 2026 02:43:09 -0700 (PDT)
Received: from freepad.iliad.local (free-mobile.vlq16.iliad.fr. [213.36.7.11])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f2dbfb1sm45814089f8f.35.2026.06.16.02.43.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 02:43:08 -0700 (PDT)
Sender: Maxime Leroy <maxime.leroys@gmail.com>
From: Maxime Leroy <maxime@leroys.fr>
To: dev@dpdk.org
Cc: Maxime Leroy <maxime@leroys.fr>, stable@dpdk.org,
 =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>,
 Thomas Monjalon <thomas@monjalon.net>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Sunil Kumar Kori <skori@marvell.com>
Subject: [PATCH 1/2] ethdev: keep fast-path ops valid after port stop
Date: Tue, 16 Jun 2026 11:42:57 +0200
Message-ID: <20260616094259.686555-2-maxime@leroys.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260616094259.686555-1-maxime@leroys.fr>
References: <20260616094259.686555-1-maxime@leroys.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Reset these non-burst ops to the same dummies eth_dev_set_dummy_fops()
installs, so a stopped port behaves like a freshly allocated one: every
fast-path op is a safe no-op, none is NULL.

Fixes: 066f3d9cc21c ("ethdev: remove callback checks from fast path")
Cc: stable@dpdk.org

Signed-off-by: Maxime Leroy <maxime@leroys.fr>
Acked-by: Morten Brørup <mb@smartsharesystems.com>
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

