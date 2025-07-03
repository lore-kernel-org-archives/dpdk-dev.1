Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38573C83F03
	for <dpdk-dev@archiver.kernel.org>; Thu,  3 Jul 2025 17:24:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 36C7F40267;
	Thu,  3 Jul 2025 19:24:13 +0200 (CEST)
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com
 [209.85.215.181])
 by mails.dpdk.org (Postfix) with ESMTP id 81C6440264
 for <dev@dpdk.org>; Thu,  3 Jul 2025 19:24:11 +0200 (CEST)
Received: by mail-pg1-f181.google.com with SMTP id
 41be03b00d2f7-b271f3ae786so110953a12.3
 for <dev@dpdk.org>; Thu, 03 Jul 2025 10:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1751563450;
 x=1752168250; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Fg7BqYktK92LjVCHxSheymrh39UjuwBhVBql369KtRI=;
 b=qF3cM3kWuirv9mb+CRA82o3IB1TFKJe0xYyP6X3IL2O+fuM3Z02NVbrKKZaDZqzWVU
 bjIv+vPczrR5RMsl8Z9HGqMmaZT6MYdNGkl+m/Z2Df8hLTuyN73AFCJhtSvlF3mQm8I8
 Tjyp7KKGBjM1hOp9UdzQ3dfCyZ43iGBH5h+7GdoStdOLLNqhCp7LR+HH/cD4zl8K1vVL
 MVnLoBI7GgOyQZ2d15yR/VEmSkFJ2r3bSOxK9rwBxktPl3iAbqDtQmSn+6QaTpzBRNA0
 WZE5doG0ANqMXS+NFvNm/OwUD76X+bfPcztTjbeADbSL7zf+H1lPOsfT4DkT3WP5LHLw
 g/Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751563450; x=1752168250;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Fg7BqYktK92LjVCHxSheymrh39UjuwBhVBql369KtRI=;
 b=RcqX27f8POJxp5uh3volSNJh+ND8r6PzQNJeRtTqrSB0b97NjpfFMH2LaZhZ7rAJoQ
 6YXD1yk10OUxiOJjqHgDhcSpBSWXreSOygt3bbzWieQI4eUAWxdlo9akdxsq2ly30l5q
 I72pmqjLQmtKhgERh2TaexbElA6Y4YfAnrMlFKdoxBYxwbbCDSN06z7Cm3FUgPnPlXUG
 snwNgzWwvBEPGJ6i3tUyLf8cr6s5AnAr76JQqfeoN+Qew0hn52jhWbhjaXXAHya64ZXZ
 GivTDd1RPm/rjV9sfqPi2s2995rlltVmKPOu7zp5efnBmU2oxR8N4LEYIf1KAcw25gpL
 iQ7Q==
X-Gm-Message-State: AOJu0YynwWZKrynCcG5BLk2zyL1y8gnggzFr7cMpIwtT5mDbI9Gn1HNK
 LZypCU6uSepFf7eYhOEaf7O9Ma6RnQf/ysnaDLN1b6/yM4Yp1oL5RDBB+PjsXMRxEfO0TIprsN5
 9FVi4
X-Gm-Gg: ASbGnctf6H/Gu9mWaYj8oAabaNgs9BROK7AU9n1mAD4qgSqmQvlybCo+CU8LSBrGkLp
 JKDgyov6zC96jCb3BM7FO/Wg04Xby31MwEREYa9kxI+kCWFvemnxkXF1b6Z+oRJ+dDpjG83bnJj
 FeM//NhtD4qOL9TEamrRTzMSkrGTOVGc6xFokI6Ur69x8h+JPoIp8zkM7CjFW+67ijtInpTW8wV
 pOs3dJgNDUbzzYzp4MV0rneAws30Z3xdBJ7rnBDrIAEDMu1ztnA3pKmS88Hi6IGsy2d7JoEERMW
 tbIAF7shRaVwB8Y3NeMuyxkr4bGoNF5clMrwFkz1LLv2PqYmX1wCksiLS4vi+kvhR5QNqqqIVxv
 QFYK3uAFUVUzkOaJNpZUvKawGfl5YxhSrNht8
X-Google-Smtp-Source: AGHT+IFshSqesmMaIl97kqBBPJFYi9MtG+1eTEJvWm1+tdWBncAqfbWwLPm6Ppypqiw8sET3kn3cTw==
X-Received: by 2002:a17:90b:5350:b0:312:f263:954a with SMTP id
 98e67ed59e1d1-31a9de8b3b6mr5069870a91.5.1751563450351; 
 Thu, 03 Jul 2025 10:24:10 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-31a9cb7e88esm2963330a91.0.2025.07.03.10.24.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Jul 2025 10:24:09 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH] ethdev: fix shadow variable definition
Date: Thu,  3 Jul 2025 10:24:07 -0700
Message-ID: <20250703172407.116249-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
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

The variable 'ret' is defined twice in rte_eth_tx_queue_setup.
Can remove one.

Fixes: 1bb4a528c41f ("ethdev: fix max Rx packet length")

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 config/meson.build      | 1 +
 lib/ethdev/rte_ethdev.c | 1 -
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/config/meson.build b/config/meson.build
index f31fef216c..3fc58c53b8 100644
--- a/config/meson.build
+++ b/config/meson.build
@@ -322,6 +322,7 @@ global_cflags = [
         '-Wnested-externs',
         '-Wold-style-definition',
         '-Wpointer-arith',
+        '-Wshadow',
         '-Wsign-compare',
         '-Wstrict-prototypes',
         '-Wundef',
diff --git a/lib/ethdev/rte_ethdev.c b/lib/ethdev/rte_ethdev.c
index dd7c00bc94..9934e48415 100644
--- a/lib/ethdev/rte_ethdev.c
+++ b/lib/ethdev/rte_ethdev.c
@@ -2468,7 +2468,6 @@ rte_eth_rx_queue_setup(uint16_t port_id, uint16_t rx_queue_id,
 	if (local_conf.offloads & RTE_ETH_RX_OFFLOAD_TCP_LRO) {
 		uint32_t overhead_len;
 		uint32_t max_rx_pktlen;
-		int ret;
 
 		overhead_len = eth_dev_get_overhead_len(dev_info.max_rx_pktlen,
 				dev_info.max_mtu);
-- 
2.47.2

