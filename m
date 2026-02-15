Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9D5BE63F08
	for <dpdk-dev@archiver.kernel.org>; Sun, 15 Feb 2026 19:54:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C723B40616;
	Sun, 15 Feb 2026 20:54:02 +0100 (CET)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51]) by mails.dpdk.org (Postfix) with ESMTP id A3E8740608
 for <dev@dpdk.org>; Sun, 15 Feb 2026 20:54:00 +0100 (CET)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-48375f10628so13200555e9.1
 for <dev@dpdk.org>; Sun, 15 Feb 2026 11:54:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771185240;
 x=1771790040; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mJio/py1Yb7onUjPuAZl1hRkbVK3/qaQuVU882+hVag=;
 b=ibIZ7TPwr/ub0qqBIiWl3lwMhYTLPNAI0GFHegQi9fGqGm1hqDv/eUSz2ke5w3S2b5
 tfEmpeqKCrEoMWk9J3mmhgZJXXXMlFZGX7oA2W3o96MgaJFBghLAYClfhGBRYOL7LoG4
 L5cB6oHPQNwDUsaBmGHunXr7hoN59aEJqGxLRUaJCQGPiSVGhJX1hKoZAYVT/wZCnV+f
 NecjyH1y/4yvv4UEwhSIlcyyQkx2N0o7jD2dUSxoz0iPlna5Vg4qjigNCS9ydNHRiD1r
 mlt/R4R1oJkRzIY/gmS+SOpKWjDHPDrYiHtqTDMQcVaHlMMeTQyhIrhiQBlEvYdTocd7
 cEFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771185240; x=1771790040;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mJio/py1Yb7onUjPuAZl1hRkbVK3/qaQuVU882+hVag=;
 b=S1Xy3BVOkXrjs1OkikGtTDNe1GFoOObAD3/fXD/uYNF8BvTReXI/uXpOhytbE7J+9Z
 nHos3hextKT1BrxKqwyE7I3J5RJmvxHjPjGcJbWPl5W3WdBUdR5ukkZ0Ej3cEcRJklxN
 VrDG7gS+ds96Ta+A6NQbaXpP+05xn8TTtkB7iINZOCn3TeccFDFBSvUFnu99jKtRzifz
 hJPjQq7IQA8duUiGagw3iG09+0wksv0Ei1dlEC5e0iK5dvVtOuGJtyhHilUHQzWFkIL3
 G6u/7ZkC7YHC1beI3ysgz2n7wx6Q2dLraNHVvqRr5HIZq1oHyxxpSxXRsMaQ7P4Wf5Du
 hjwg==
X-Gm-Message-State: AOJu0YzV2Z7Cp3YvQSjUulExgSyErUaTtezjok+GKRmQSbgjdl3/zBHf
 L0wVVeH5yOmrUC0nNEwIjxJKTovqgsuy8g7PMEgu3UrIZZfxSLmpx4Vy08K+E/wlOfuNwBreywA
 6CjA2gpA=
X-Gm-Gg: AZuq6aJamIispQEboLBjq5odyjYNdMNt21R1R4ga9FSnKXEL36XUqBpurI7Jbc1rXFR
 crrRmBA/1OBwiJ7/ZAKELeq2nDnTVPSuDex/CieWzmnzZ/s+8uq8tid2b2TEbTofhMc8rCXaahm
 KzwY+/mTC51Z3lfa65v8PsCrnMg0hgg1ScSDOq2ljytR2ZMg2Bb4Xbp3PqwusGSPv1PV4t1YJDL
 GTQ200dRn1EW24r1DTRYByy9C4ROt8tA8/XZvDdupBx4bLIlLOT8fF2y2hJxNP8jiVDHcmAS7It
 DFvI9i34eaI7QKhJdYeOIFCzgS/pFBAxHciV6Vd8lh+1LvwTiJ5/m5Et/6TOwO62+mHTinH1fCv
 nJOagQpv6KbfQKAGhpl0IMs5hKA2eaUmCXJKeht5UzxlJ3CLpsTMYCwYmxSj3QqjGjKHcKm6oBy
 DrvaG5nViCzYLL+yt4FYs0u4bUQL5Xix7Y2wG8Viv+uSdbtn7/2+4FUqEV4jAVK1rTTSGxQaeX
X-Received: by 2002:a05:600c:64cf:b0:480:4a4f:c36f with SMTP id
 5b1f17b1804b1-48373a38599mr155528805e9.21.1771185240133; 
 Sun, 15 Feb 2026 11:54:00 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4835d99497asm526490415e9.6.2026.02.15.11.53.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Feb 2026 11:53:59 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH 04/10] net/tap: extend fixed MAC range to 16 bits
Date: Sun, 15 Feb 2026 11:52:22 -0800
Message-ID: <20260215195348.557945-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260215195348.557945-1-stephen@networkplumber.org>
References: <20260215195348.557945-1-stephen@networkplumber.org>
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

The generated fixed MAC address stored the interface index in a single
byte, which wraps after 256 devices and produces duplicate MACs under
repeated hot-plug. Spread the index across the last two bytes of the
address, extending the unique range to 65536.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/tap/rte_eth_tap.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/tap/rte_eth_tap.c b/drivers/net/tap/rte_eth_tap.c
index 31c8c185e9..fcc452527b 100644
--- a/drivers/net/tap/rte_eth_tap.c
+++ b/drivers/net/tap/rte_eth_tap.c
@@ -2276,13 +2276,13 @@ set_mac_type(const char *key __rte_unused,
 		return 0;
 
 	if (!strncasecmp(ETH_TAP_MAC_FIXED, value, strlen(ETH_TAP_MAC_FIXED))) {
-		static int iface_idx;
+		static uint16_t iface_idx;
 
 		/* fixed mac = 02:64:74:61:70:<iface_idx> */
-		memcpy((char *)user_mac->addr_bytes, "\002dtap",
-			RTE_ETHER_ADDR_LEN);
-		user_mac->addr_bytes[RTE_ETHER_ADDR_LEN - 1] =
-			iface_idx++ + '0';
+		memcpy((char *)user_mac->addr_bytes, "\002dtap", RTE_ETHER_ADDR_LEN);
+		user_mac->addr_bytes[4] = iface_idx >> 8;
+		user_mac->addr_bytes[5] = (uint8_t)iface_idx;
+		++iface_idx;
 		goto success;
 	}
 
-- 
2.51.0

