Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FA99C53214
	for <dpdk-dev@archiver.kernel.org>; Fri, 20 Feb 2026 05:04:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5D6B440647;
	Fri, 20 Feb 2026 06:04:22 +0100 (CET)
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com
 [209.85.222.175])
 by mails.dpdk.org (Postfix) with ESMTP id 27C4C40395
 for <dev@dpdk.org>; Fri, 20 Feb 2026 06:04:18 +0100 (CET)
Received: by mail-qk1-f175.google.com with SMTP id
 af79cd13be357-8cb3e0093e3so170820585a.0
 for <dev@dpdk.org>; Thu, 19 Feb 2026 21:04:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771563857;
 x=1772168657; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SezU/5GufF1EnMCX8wl/9cMSJxt7mlXFMHwW5iGBxLY=;
 b=be4rHLGdf6N053GOk38yqxkHSD1a0hecJsiuNkiV7YTaehuHpd7IQPuL5precTuqWm
 sM/rzDLL6aWqOFTyhcTcgrVNTKWj5KHOKPm1rKMpjpEZi17fwgf/oJ3eWk7DbCAwK1MP
 gLOTppzG9UY9IFVdGKHcqyHxuMVyU4TDvt/tNyfGc7bXVjP8xod3wXrV/2AERQTHZLcD
 lF/kDr6I6Yg82QrzIM/KDJKJyYp9nCehEkw5O5R5P5xbUn/TJFLTUvkcst7G64Yg6vQJ
 k8bAYAQjLwBJKAq8kYv1xa1QdLFExWNQXis+XpdzIpFU3lY6ePp1W6O+Nm8ohTdkhium
 79Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771563857; x=1772168657;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SezU/5GufF1EnMCX8wl/9cMSJxt7mlXFMHwW5iGBxLY=;
 b=vs2yWIHUlP2c9z8eVEObVZnhYSKmEWRziImprxY52aJP3Z1RwkMDcFKVuV7vV8Obkl
 gj0NAmwan2IKl+pzjocpZjCfRa/8/FRoTHBTx6ZwOW319zpuqh9O1wdvZ3TZXPy5LN9O
 x1cTNprtKu25WMu5iuYB1T/a6Hkb48IXMkjifB/CzYeqAbNwCZdIBk8t9FMOQ8T59vdJ
 EgSE3oYzHBW1pYX+nX8JvvFg8LXl3kuwvdlEMxPGlsmBHNKwXnhFNnRoGZ8mhrydBdg2
 uJIhS69fm1lcPEnfjIFrBMt4RtHLclBqMKJHFhtSKFZcaUz1yKZROcqAAh0lZAPKeN0g
 jxdw==
X-Gm-Message-State: AOJu0YwHetg1Q90iGhnJaOYdLaeRyZ+bFgoTbPE/OamlxCZSAMnDvQ5v
 BkOF8KUchwARN8Hczf96VmQe9QDckOvyVA8A7yL58EGaR5ZDsBhDxZFw6Ynh7JeFJtV/8OBqOvU
 cU1OZ
X-Gm-Gg: AZuq6aIfFVsNxIEqSfFjL1Z+NE0G/N2ZX3OYSP2MEeQGBn1j/Ziyy9T5KqsIei0wuyI
 wTirubmhXR9QkgQMJ85zTajyp9G/Wi+DOkARgLrl8WnozChM+EnDVQI+Niq9HNQwFD4QknzqITK
 6bDShMh4ETL9d4U7G1fSXJOUGop1UqBE0xj1fCFFyo5l/lBrlxocYzRZidj7V7XP1qHFtkufi7C
 h2NuZkgdAB8VU9iJxSIEXSBhQmzl9i5xDU6ICY74tbUDvXoYQc1TQpfVoY4ADwWOgSqHgLppWYk
 nemkS1GmbOjcJPBh3HAGsHHhipzgoE2sudZh+MrCLjCso7ZtBj0zgd+c/xnwqtbS0QS60ngr72C
 HzHQkGmhzNzD0Ey7mwtxqjAkyx4ieuGHT9q4fVnjDbVF6K6K0/zyn24OucaxvMp2apfYCFe1YZJ
 3m55UME5PoZ+KzvApAJ63ZRBYF4ff4votskF009AwJc/FGRj7HpCEqH9dcJqX+pw==
X-Received: by 2002:a05:620a:4712:b0:8cb:43a3:8b58 with SMTP id
 af79cd13be357-8cb85ac9eb2mr41216285a.76.1771563857473; 
 Thu, 19 Feb 2026 21:04:17 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cb2b0f38dbsm2289278685a.21.2026.02.19.21.04.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Feb 2026 21:04:17 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v3 04/10] net/tap: extend fixed MAC range to 16 bits
Date: Thu, 19 Feb 2026 21:02:06 -0800
Message-ID: <20260220050409.1571022-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260220050409.1571022-1-stephen@networkplumber.org>
References: <20260215195348.557945-1-stephen@networkplumber.org>
 <20260220050409.1571022-1-stephen@networkplumber.org>
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
 drivers/net/tap/rte_eth_tap.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/net/tap/rte_eth_tap.c b/drivers/net/tap/rte_eth_tap.c
index e06e1ca079..8b6d5db37e 100644
--- a/drivers/net/tap/rte_eth_tap.c
+++ b/drivers/net/tap/rte_eth_tap.c
@@ -2274,13 +2274,15 @@ set_mac_type(const char *key __rte_unused,
 		return 0;
 
 	if (!strncasecmp(ETH_TAP_MAC_FIXED, value, strlen(ETH_TAP_MAC_FIXED))) {
-		static int iface_idx;
-
-		/* fixed mac = 02:64:74:61:70:<iface_idx> */
-		memcpy((char *)user_mac->addr_bytes, "\002dtap",
-			RTE_ETHER_ADDR_LEN);
-		user_mac->addr_bytes[RTE_ETHER_ADDR_LEN - 1] =
-			iface_idx++ + '0';
+		static uint16_t iface_idx;
+
+		/* fixed mac that is locally assigned based off of iface_idx. */
+		user_mac->addr_bytes[0] = RTE_ETHER_LOCAL_ADMIN_ADDR; /* 0x2 */
+		user_mac->addr_bytes[1] = 'd';
+		user_mac->addr_bytes[2] = 't';
+		user_mac->addr_bytes[3] = 'a';
+		user_mac->addr_bytes[4] = 'p' + (iface_idx >> 8);
+		user_mac->addr_bytes[5] = '0' + (uint8_t)iface_idx++;
 		goto success;
 	}
 
-- 
2.51.0

