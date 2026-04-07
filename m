Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4E33FB5190
	for <dpdk-dev@archiver.kernel.org>; Tue,  7 Apr 2026 03:52:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B11674028D;
	Tue,  7 Apr 2026 05:52:15 +0200 (CEST)
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
 by mails.dpdk.org (Postfix) with ESMTP id 257984014F
 for <dev@dpdk.org>; Tue,  7 Apr 2026 05:52:14 +0200 (CEST)
Received: by mail-dl1-f54.google.com with SMTP id
 a92af1059eb24-12c0b72dac7so1936413c88.0
 for <dev@dpdk.org>; Mon, 06 Apr 2026 20:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1775533933;
 x=1776138733; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fi8goIuVCYTR41Nn44/VOM83JFH82OxEoIPUvo5ErDU=;
 b=FMfoVe5tU7MquoyJk2i6ZGDkVbZsONHJaJLwmWCdLv9QM04uOLy5fdi8W4daXLBJQh
 MXAw8AvUgPH0/3zhF9NyVbrkahRpwvjk25nHEOLS6n6Um8oaQ8wxapb3tw3gXIhDNxyM
 PjfRkcCkmodmPGID2t43wEkHsW6T/aGji2f89Z8pJSGaSPbVRG52jdn32tgfJ/WIiRjz
 2tC+4a261RtIQaEnXim+N8Fpqpnl/m5j2lNyWWEfnQP9ZMPK+F9qlL8uBX+/yTDgNCfW
 d6tLarWknroQTKl5pQe2QAyuL9S/rxadn7u4aqWcLbCewBaYgNc+VnAD8OP+Zb5VJvJC
 Ok4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775533933; x=1776138733;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fi8goIuVCYTR41Nn44/VOM83JFH82OxEoIPUvo5ErDU=;
 b=HrsHdBUg6xij61tKCn4ID3VGgUtvvOwvMngenLZkeWVJCwMhU/19hKmcpBSkMGZK65
 Hsqq3gyyfmN3+Kt+lcsmUR41NMaSz9E8SfwQuBt9CmwOEkXMRe23uPI9njk5kMfQI1sD
 1Jf1Tv+73HrvePuejDl430D+tL0g/kYNLnpUG9ZC9wOQRN0ZEr2mGFHGiHhPesZxajo8
 1JAWG6DH2KOv5dk0+wLiTld8czmQWb34dKDiCInsC7rInnNbr0pAkqtLDv2NzhoZMb+9
 i6xTvRP5/ZizVOS+zS3a9dTQcyQDcc5hV4nMTK9rxK1HJ3B68cNgnzPltSTjCeX76peP
 4OGg==
X-Gm-Message-State: AOJu0YwO3hkNgqjw7/EmwG+KpTnRj+JBKftl9/YYQzKrwaVn+vUUK6HY
 oGiCpWkicdWxNAxGdCkwwcl/VMMFzfVy5D1TH2pkTRKYh8Znoc8szFo83RzQTDFWq2rTDhLNVY4
 iTxe7
X-Gm-Gg: AeBDiesT92Hh7DEeF/iZ+aqi/JCeupNanoGrt5OEJDMacau5tRa+/etORI12ANwYp6q
 7oMvIgqS5+20qU03N9XXykx/JWwQF4mdUEdMPkfalsngKUrcccDDQe654AuqxSkUFMH7sUM0upy
 Mwz7tXjBrVeR0S+L1NmCpdBbGe/CCZYaH1d05OJWuBoPNfYAfB2McZQqqgIVnPRBPXchapv+B37
 WY0JK2j4iSbHH/4P6nUhZVmTjRZd7IdwCkDZtAR8cwisfccGcKQGwlta3revP1jRwIPIUGIKqOA
 yql9YDM1XOsxEo4CbFZH0WG1u4qBJ+fNFRUV2qck6GfvnaAsfxBpNWpBKnx8wWiIUStCttph2Tg
 E3Bpzny4aEGB3SiNlrz6WCUkWmp6AG07Y2BVWgMtJpKhS9sguF9OHC77tohpsN96BmDznPO7TQp
 ExRO28uo8/0Oz311lS5I+ZRWTJ/pdx57DN
X-Received: by 2002:a05:7022:418f:b0:11b:82b8:40ae with SMTP id
 a92af1059eb24-12bfb76092cmr7264477c88.18.1775533933018; 
 Mon, 06 Apr 2026 20:52:13 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12bede545e8sm12716093c88.11.2026.04.06.20.52.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2026 20:52:12 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH 01/23] examples/ethtool: fix shadow variable warning
Date: Mon,  6 Apr 2026 20:49:27 -0700
Message-ID: <20260407035209.650419-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260407035209.650419-1-stephen@networkplumber.org>
References: <20260407035209.650419-1-stephen@networkplumber.org>
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

Fix shadow variable warning by renaming the function parameter
from 'app_cfg' to 'ptr_cfg' to avoid shadowing the global variable.

../examples/ethtool/ethtool-app/main.c:89:44: warning: declaration of
'app_cfg' shadows a global declaration [-Wshadow]

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 examples/ethtool/ethtool-app/main.c | 4 ++--
 examples/ethtool/meson.build        | 1 -
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/examples/ethtool/ethtool-app/main.c b/examples/ethtool/ethtool-app/main.c
index b6bbae70d2..6545eb322d 100644
--- a/examples/ethtool/ethtool-app/main.c
+++ b/examples/ethtool/ethtool-app/main.c
@@ -86,7 +86,7 @@ void mark_port_newmac(int idx_port)
 	ptr_port->port_dirty = 1;
 }
 
-static void setup_ports(struct app_config *app_cfg, int cnt_ports)
+static void setup_ports(struct app_config *ptr_cfg, int cnt_ports)
 {
 	int idx_port;
 	int size_pktpool;
@@ -101,7 +101,7 @@ static void setup_ports(struct app_config *app_cfg, int cnt_ports)
 	cfg_port.txmode.mq_mode = RTE_ETH_MQ_TX_NONE;
 
 	for (idx_port = 0; idx_port < cnt_ports; idx_port++) {
-		struct app_port *ptr_port = &app_cfg->ports[idx_port];
+		struct app_port *ptr_port = &ptr_cfg->ports[idx_port];
 
 		ret = rte_eth_dev_info_get(idx_port, &dev_info);
 		if (ret != 0)
diff --git a/examples/ethtool/meson.build b/examples/ethtool/meson.build
index 3ad948d109..d7f63d48af 100644
--- a/examples/ethtool/meson.build
+++ b/examples/ethtool/meson.build
@@ -17,7 +17,6 @@ sources = files(
         'ethtool-app/main.c',
 )
 includes = include_directories('lib', 'ethtool-app')
-cflags += no_shadow_cflag
 
 deps += 'bus_pci'
 if dpdk_conf.has('RTE_NET_IXGBE')
-- 
2.53.0

