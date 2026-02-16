Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1051E83840
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Feb 2026 23:05:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B82E840650;
	Tue, 17 Feb 2026 00:04:51 +0100 (CET)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com
 [209.85.221.45]) by mails.dpdk.org (Postfix) with ESMTP id E2707402EE
 for <dev@dpdk.org>; Tue, 17 Feb 2026 00:04:49 +0100 (CET)
Received: by mail-wr1-f45.google.com with SMTP id
 ffacd0b85a97d-4359108fd24so2490072f8f.2
 for <dev@dpdk.org>; Mon, 16 Feb 2026 15:04:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771283089;
 x=1771887889; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SezU/5GufF1EnMCX8wl/9cMSJxt7mlXFMHwW5iGBxLY=;
 b=VCcMYVeYnwT9EJEEAVRqAkPNhawIQd4M4vdifN4J6fT/+ktD2jgTXOnWigANHVnkbP
 h/k5U4DUhL9JM1IMUiQ+Yvyf2CqLFsliDEgW4DS8HiLjChpvWudDKyOVjPn2CrUDFHC/
 3EsllxjEulG1v0noKDvt5XR5cHG80kMsLE0x/emerU2qXyUoiwjO/mul9V73dh05oVtY
 EMopwOJ+l/yN85jfmGapAnZ2uYb8G0Z17+TakjOs2XUy5XhcdGoc8sbd8ZgJcO2c6x+9
 BR3ge11F8H+4MErJz9xYm/SdPrJM8nbB066BG6y6MrNeegu/WYoSHrhr7v+lh/dYfr++
 MbRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771283089; x=1771887889;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SezU/5GufF1EnMCX8wl/9cMSJxt7mlXFMHwW5iGBxLY=;
 b=M8VWi631gNl35ofd2pZfkFded39OZOW2Sj9Lo2QTQkCV11khR64aPCe78dOJlY+ZXO
 xYeAvz05qzDHifOBZ4xICDoWRXzohaYpInUWmRHEi0rkIwIyanvWhE1Z5YeMALMWVpxK
 npqhVgR5vcuvJu5U8d7kvvNRt/M2zS3NsMgkElCf1ojVpru+9+PIz2n0GNUxZ0uy/E6g
 HJMO7KbN4s8UjMpQRBJZhvbGYRO9F8uAkiP6swhd+iKXcW5Bha93eMS2d1Nq871x58nr
 8ZsT/2ea3AR2jf0KLNpPOdwnorxF55ktQ9tJkmeycjIuKUzRdKjqy1YhGBQOSDpAEH3D
 vxrg==
X-Gm-Message-State: AOJu0YyVmXE3793gUfVRER7Cj3tEtgAtYXrW6SPZlNM3O2g+awGipeIB
 HVPHhSJe9ZZ5PyOwsAdexjfWhrZZi7ejK3rsXpdlmqm8cPjH5bEWz8+6srwQT0htBnLk344xPAh
 5aIERPeg=
X-Gm-Gg: AZuq6aJSaqhobXoJVal2hm+GZZNfQw85unWHKFpBVvOyYlYk1pzuSaPHCXYxfSJL84B
 x+fv1cTZqSdcTi159HOLkNZTQuBvaChUYAp5+Q4wC3jY2SxJlkdUVkyA7EsbsKnUvaN6r5wDhJn
 vShL7csflXBoCx+zDJPmMHolLqdA4aHfX+HIPR+17aktTZaJI5Y4+Hb1Ms4qErY9lXeJrIpuBUN
 oO2RJr2RLs2O0+yXcPSkGzd1cbWzU1Heeh0jG1eeO8hWquVrQ0kdZakTLLg2vVBEB+TgH2fMqK+
 gzdtU9ixojKvMiqPQ7URnHLUxHIE7SjcaBhbIZaJdxwIlDCI8Asf1Z1LkgX4eXK7ziNY3bKt+DB
 LJ87SAocYxToRGxdZcKnCj4xskgDQ2OHVtq11j2v1IVrrrbFjaawfcb7uWDvqhDCKqF1xh2BE30
 xNhMqxLb35tvS/QLk77dLQvqsrbSFhsqRPLXZzRly3e989NfbknZuMZm3QioN0mQ==
X-Received: by 2002:a05:6000:40df:b0:437:6858:260e with SMTP id
 ffacd0b85a97d-437978c1087mr23104195f8f.5.1771283089446; 
 Mon, 16 Feb 2026 15:04:49 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43796ac82f7sm33158867f8f.28.2026.02.16.15.04.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Feb 2026 15:04:48 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v2 04/11] net/tap: extend fixed MAC range to 16 bits
Date: Mon, 16 Feb 2026 15:02:28 -0800
Message-ID: <20260216230437.847578-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260216230437.847578-1-stephen@networkplumber.org>
References: <20260215195348.557945-1-stephen@networkplumber.org>
 <20260216230437.847578-1-stephen@networkplumber.org>
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

