Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C919FC36002
	for <dpdk-dev@archiver.kernel.org>; Tue, 25 Mar 2025 02:39:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8511140B9C;
	Tue, 25 Mar 2025 03:39:15 +0100 (CET)
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com
 [209.85.216.46]) by mails.dpdk.org (Postfix) with ESMTP id 8E724402E2
 for <dev@dpdk.org>; Tue, 25 Mar 2025 03:39:14 +0100 (CET)
Received: by mail-pj1-f46.google.com with SMTP id
 98e67ed59e1d1-30332dfc820so4105105a91.2
 for <dev@dpdk.org>; Mon, 24 Mar 2025 19:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742870353; x=1743475153; darn=dpdk.org;
 h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Hhqdglag6Xr+XraUPW3CcVb+tX/+aoLHNcBL7o+4elw=;
 b=LVJWgR4hlZr8fGW68P2O7r3B6EfcvAITP5XAHvImYGM+3CU2JanQbFqpQ2UVwlxiHb
 bB09McwlY5bGcy2BhtcDRIdH6PD6vATxlt6kYRuDah/+pHe3n0rdCGtTkgwTAAGY446A
 kqmDQl1lcM0jmUF6vjreIrm8+8mK1P/0J6Prl6waIOOuRlNueNihdExkGh4KqIQGGuNN
 YjIIJsrNKDX34DbZaFErX/es6YB2r6YNJTMW4lpXmRIsgtxwFrIhCr5VplARNnBGssP+
 kKB2lD+XUPcbDB1nnZaNRrDlvpHG3gnFEaa39wutj/bUCceOb/kU1iyMrJkJUtKzYEiY
 OpuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742870353; x=1743475153;
 h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Hhqdglag6Xr+XraUPW3CcVb+tX/+aoLHNcBL7o+4elw=;
 b=MKjI5Vl/Y1h54jGJ27Ksi+tbCIxb2dvWFRv+uutCiYhCNzpC0ikxHXV28zcUBSrTM/
 5oBt4knXQb0mk2Q2yGcjce+IkzspAnebF3CTq+T280pWp72IAC2VK/toxrD5AqlySBOe
 6uO4a1euPbkI3jZHBnTzjwX0gAbhBmavtMOEiDlNPjOeD4YPeL+6Mp4aiy6r1FxdSpuo
 I16kZGNRHcau2y0W80WqbfXCW0jbCYc04ovO3QJVPRD8BEyH/nBTrrg6hLzV0+HzwoPo
 SjmSyKVj91Q2/DaUpdq/+2HcdDWLSRpz0ZqgvUjSoxnhecP/LkElyN+oQhtyvd3AxDpz
 WyuA==
X-Gm-Message-State: AOJu0YxwmnbH5qPJmHD9LctyHtilNDrPlRE/B9wLzJu9bxxtJcR9oXG7
 z5DJZ4ZhCZQEkfCUBlA1JgD4gCdTjyx/Yh4UwsntikyugGWF3IYL
X-Gm-Gg: ASbGnctMmwNvPQeN62Hs1QLJdd80OBdVnOOTmoIUYLhpbs3PdRefmqTDT3c2IWb9WOZ
 /E61+Ix33nfQ55Vl8wKF5bDhgFOeIplu0tdE5FW2hBvuMQq42IjrOOVBdvg77pNUhA8Jzg7O+5f
 EUUox6M/1DUYTY29JTPEEXGhAf33MiYh90AUZwecvsBUZy99ZuunHh8tXS4uzDw98hl8vhlAJo9
 gAlAmtBANS7X/BJlkfNdsepaZK7DDuovjuWZ8FOUgRvg5R93xNtZITpImncSMzpRoStK817yO32
 13WdpUFUz0jKww4utRpLuakM1woekPHvVqLsiNHjzZfvchgtgr/nX82EauUWVNw2Z6oY6DZk8wf
 tdt74rJES5g==
X-Google-Smtp-Source: AGHT+IEOrBQK5LUX9P3WUK+xKQlpK51YcNfFXztO/KotvfpHVMszjD2co0VAzLieuqP6AJtxRqC17g==
X-Received: by 2002:a17:90b:4c43:b0:2fc:c262:ef4b with SMTP id
 98e67ed59e1d1-3030feb2497mr28263518a91.18.1742870353452; 
 Mon, 24 Mar 2025 19:39:13 -0700 (PDT)
Received: from localhost.localdomain.localdomain ([114.254.2.167])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3030f5d4f0asm9031728a91.17.2025.03.24.19.39.11
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 24 Mar 2025 19:39:13 -0700 (PDT)
From: Wenbo Liu <liuwenbo109@gmail.com>
To: rasland@nvidia.com
Cc: dev@dpdk.org,
	Wenbo Liu <liuwenbo109@gmail.com>
Subject: [PATCH] drivers/net/mlx5: fix mlx5 send packet failed
Date: Tue, 25 Mar 2025 18:39:00 +0800
Message-Id: <1742899140-2013-1-git-send-email-liuwenbo109@gmail.com>
X-Mailer: git-send-email 1.8.3.1
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

Test Environment: ARM architecture, OpenEuler operating system
CPU: HUAWEI Kunpeng 920 5220, BIOS Vendor ID: HiSilicon
Network Card: Mellanox Technologies MT27800 Family [ConnectX-5]
DPDK program sending self-encapsulated packets with MAC, IP, and UDP headers
continuously prints the following errors and ceases packet transmission

mlx5_common: Failed to modify SQ using DevX
mlx5_net: Cannot change the Tx SQ state to RESET Remote I/O error

Signed-off-by: Wenbo Liu <liuwenbo109@gmail.com>
---
 drivers/net/mlx5/mlx5_tx.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/mlx5/mlx5_tx.c b/drivers/net/mlx5/mlx5_tx.c
index 4286876..5cf9873 100644
--- a/drivers/net/mlx5/mlx5_tx.c
+++ b/drivers/net/mlx5/mlx5_tx.c
@@ -186,6 +186,7 @@
 	volatile struct mlx5_cqe *last_cqe = NULL;
 	bool ring_doorbell = false;
 	int ret;
+	int offset = 0;
 
 	do {
 		volatile struct mlx5_cqe *cqe;
@@ -205,8 +206,11 @@
 			 * here, before we might perform SQ reset.
 			 */
 			rte_wmb();
+#if (RTE_CACHE_LINE_SIZE == 128)
+                        offset = 64;
+#endif
 			ret = mlx5_tx_error_cqe_handle
-				(txq, (volatile struct mlx5_error_cqe *)cqe);
+				(txq, (volatile struct mlx5_err_cqe *)(((char *)cqe) + offset));
 			if (unlikely(ret < 0)) {
 				/*
 				 * Some error occurred on queue error
-- 
1.8.3.1

