Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52C30CCD1AB
	for <dpdk-dev@archiver.kernel.org>; Wed, 22 Oct 2025 12:59:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B8A214027D;
	Wed, 22 Oct 2025 14:59:45 +0200 (CEST)
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com
 [209.85.214.170])
 by mails.dpdk.org (Postfix) with ESMTP id 3C0024025E
 for <dev@dpdk.org>; Wed, 22 Oct 2025 14:59:45 +0200 (CEST)
Received: by mail-pl1-f170.google.com with SMTP id
 d9443c01a7336-269af38418aso85398525ad.1
 for <dev@dpdk.org>; Wed, 22 Oct 2025 05:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761137984; x=1761742784; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=jioTDfrub3SFn1ivIdnf+Kz9NrKUj3pUSaxJEjtXWS8=;
 b=JtsQzgd5jTlzDIddK6nBIzHAEJYsuL9ZB84DK6JwOdZFqGkiDtrHYjzQPmIrgpV2E1
 sZMtK6YDeMBJDrTZd7dCIajCmesSNfZZ5LiejyV/ljJ+MV0x6mcyZVl8fq61wvYLRCpM
 d8uKM+fThf3riK1QbQnrQRak+6FetmU407RbTk3G/xfluDz+sC1E2EgK7r2gHVWFsmim
 364OQW6ec9bPxc5X79QURoYRUjt9AONGnMVwE5hg/FARuKaNgweZz93BSFI7qzHeQrmv
 5qS6giPdbPz6twySxEcFOPe+SzIbjkXQly8vURV/H5ar+rpEZISgHrsaTqHQbbsbcMjI
 Lp7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761137984; x=1761742784;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jioTDfrub3SFn1ivIdnf+Kz9NrKUj3pUSaxJEjtXWS8=;
 b=TGl6usDhrkNj9arHPkOOx88rf+s53bZiJ6kTqn0t4KlyE1L+VjDMj8C60FR1FVG2a3
 P1vsQHktHnmQYlqEFrgk+TkaOwEGlChrVy89mLhcgRS03vHPbiPFD10cdbWdx1lL9wVa
 NfJQ+i/yV+xUhnuJqKexlFVMJnNqSj6UQU7uYCpxvQ8aKzvgo2rAUmZxPCdWMb9k3OGM
 q//KikF+HudtXmiHf/XpHXCIJTh4V9bAY5gCTBfjNI1rzy6+Scrjz0xzl7EN5Gp/cD8f
 IWoIJYvqVo6N9mggmyozBDqKtKD6BPy+GJ1hcaCNq0XGfS2CJIOasYSlTpN4AAe5WcPo
 2/pw==
X-Gm-Message-State: AOJu0YzIHmmDPzf2A/4P3Ac0SDYO7igQrI0/tuvUWo09ULuIAMgBvJ05
 +jb34sjtFQximMBzftgLJwBdhP1jzI736hDUL607uIEOCzKPlKoi58n1sFlZkQ==
X-Gm-Gg: ASbGncs14MdXOla6lil3a1Ve8Gw8fC9FbCvbg0EjsHf72fbWBX2Px0Hgt90FdhZNvuA
 mFxVXVGnckY42V+feLfQ2rIpbDspJXPw6cd/dcgWjxD8zzGpjnbNxKE+/o4RNXFlQ94xbDpahhS
 M7Ss1t0kmeZWUe9BIALodFfH5hCiKgQKsMg85QUA8n4gCZBQYNvimIkHUDdHvj5G3MRYxjb+8e4
 vsDkwqWuheA3qejWh6I+gsgPk9YpnPzcLKVZ+ceavGM7s7aAj9KZKudeCYDeu/GgNs9y8FZPvwp
 Ajib5FKL71f6+k2AEsDIS6i8gtJzNHHXQhBkQ39tnmjmEzqNjhhddigN09XJe/i4kzNcnqFGUOr
 VijaTg18XWsycySTla4ZmyGQ2L1OXexZ2/xVinyNf7abcIU7DShgOEvVqjrGYNgmaV0B40P6Ayj
 8ndjaLJuG5swvI/5Tcj1eVYo9bfolW2Vbq6QQT51TOQnU8bPwwN5TWUyvIZvZVewd0uyte
X-Google-Smtp-Source: AGHT+IFVuomptp8mXDjxxyc3LL3i4mQB8VRBsJ8V54CCka8lPb4G5qJrgH9M5oBiwEEleM1OgS2Z0w==
X-Received: by 2002:a17:902:f610:b0:272:2bf1:6a21 with SMTP id
 d9443c01a7336-290c9ca72aamr290213035ad.14.1761137983726; 
 Wed, 22 Oct 2025 05:59:43 -0700 (PDT)
Received: from amiya73TMT9m.aristanetworks.com
 ([2402:e280:2162:53:50bb:5301:cacd:1307])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b6a76b5a007sm12774741a12.31.2025.10.22.05.59.40
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 22 Oct 2025 05:59:42 -0700 (PDT)
From: Amiya Ranjan Mohakud <amiyaranjan.mohakud@gmail.com>
To: dev@dpdk.org
Cc: amiyaranjan.mohakud@gmail.com,
	stable@dpdk.org
Subject: [PATCH] net/vmxnet3: disable RSS for single queue configuration for
 ESX8.0+ versions
Date: Wed, 22 Oct 2025 18:28:44 +0530
Message-Id: <20251022125844.6187-1-amiyaranjan.mohakud@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
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

This fixes the issue of v4 RSS configuration failure in vmxnet3_v4_rss_configure
while writing to BAR register. It's very specific to single queue conifuguration.

Ref: https://mails.dpdk.org/archives/users/2025-April/008236.html

Bugzilla ID:1789
Cc: stable@dpdk.org

Signed-off-by: Amiya Ranjan Mohakud <amiyaranjan.mohakud@gmail.com>
---
 drivers/net/vmxnet3/vmxnet3_ethdev.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/vmxnet3/vmxnet3_ethdev.c b/drivers/net/vmxnet3/vmxnet3_ethdev.c
index f4cdb1bb31..fee4c23091 100644
--- a/drivers/net/vmxnet3/vmxnet3_ethdev.c
+++ b/drivers/net/vmxnet3/vmxnet3_ethdev.c
@@ -534,6 +534,12 @@ vmxnet3_dev_configure(struct rte_eth_dev *dev)
 
 	PMD_INIT_FUNC_TRACE();
 
+    /* Disabling RSS for single queue pair */
+    if (dev->data->nb_rx_queues == 1) {
+        dev->data->dev_conf.rxmode.mq_mode = ETH_MQ_RX_NONE;
+        PMD_INIT_LOG(ERR, "WARN: Disabling RSS for single Rx queue");
+    }
+
 	if (dev->data->dev_conf.rxmode.mq_mode & RTE_ETH_MQ_RX_RSS_FLAG)
 		dev->data->dev_conf.rxmode.offloads |= RTE_ETH_RX_OFFLOAD_RSS_HASH;
 
-- 
2.39.5 (Apple Git-154)

