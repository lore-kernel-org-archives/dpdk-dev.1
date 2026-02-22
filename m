Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A15B6C636A0
	for <dpdk-dev@archiver.kernel.org>; Sun, 22 Feb 2026 17:33:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 611FC40676;
	Sun, 22 Feb 2026 18:32:43 +0100 (CET)
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com
 [209.85.160.42]) by mails.dpdk.org (Postfix) with ESMTP id 1A0FF402EF
 for <dev@dpdk.org>; Sun, 22 Feb 2026 18:32:36 +0100 (CET)
Received: by mail-oa1-f42.google.com with SMTP id
 586e51a60fabf-404254ffe8aso2295571fac.0
 for <dev@dpdk.org>; Sun, 22 Feb 2026 09:32:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771781555;
 x=1772386355; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UVp2gbZ2DHiBF0gTvzWh8nALEMOtDah3HMGXof98riQ=;
 b=vMj6Yi9pnxLSh2a67kMZ2X01ijlJA0cMhFQxfvAlI+R8h8uVS8VFWNvjofue+5e9p8
 ezfBMN9Mh04+YU/hgpthxmRxWWwyUKA8Va5GcM9GRbpIXyDmKRSzPCnoKfCXfdBrSY8W
 eH3zNr028tMlNmrjiQQ7QOAJ2/diVqv+slklJh1aHJ7c6oljgml81cMnYx7yLQ16P3L4
 1GCXPCcF8ZL3KWLpo9LX7uAccM1KuBVY8zOR9lhjZ+vbrEeerZzKg59DdYc6K0H4WndL
 IPpBMq8qRAqgZFuJSXVy+QevG76t3fbB1pCXMEgcDzmcZS3Zn+9N+BW7ypDM5zbCh3nd
 UtZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771781555; x=1772386355;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=UVp2gbZ2DHiBF0gTvzWh8nALEMOtDah3HMGXof98riQ=;
 b=FhZDOw1ltHf/0WujYuDhJ4Gn6T3JfO2dKrVSy5i8eycKIBk61k2PVr0GyJjqsX2g3+
 Jea4ow1gBd9P/Ya6OPKVyPgI3VQb1pTmroJOJvsgo9tBftsJSrJcjYLP8r62sV5rcbhH
 sPMKbqY7rNuABaWpwlqQRbWFWyD1ui673oHZQ4WHdo9xZIw57py7CkqEnFp9no9J1tHb
 MsCwmjeMIX3EEUDa+mEdw+mRj+jgt+s6veHSwcYuEjeAw3VgkbeVYIo1LIEIFYakXCC/
 IS93Xl230O3qZ/8jXbvagWcJEB3QPlAF3YGTlpTUtb9Zon48jOz1no0SgMBq5AhR5mnV
 iJhQ==
X-Gm-Message-State: AOJu0YwXv2e1WTZoP8nPHTjItVqErubeldipRPLeiOa3vPhyZELU29HG
 EzNRc4juiD1zgPTMMKHeWjw1Vshji/G0p3i236e8liIf5AjgDo7eV58R8EpVvlkZYQTIdpwiCf9
 BnUa3
X-Gm-Gg: AZuq6aLTk/1I8UhHRWyQ3zq774wlDeyQ5E7DPMezaLMuhWz8XXy8nqQfk6f9DLjDA0p
 fo5HPFhUsMu8qE1GgK8Re+SQ/OWN35uqjMK58yBvfMN56pYc//FWUyske/0qVX43FrDqBUCMQjT
 tQQI1jEG0EAlndfaeutF3LLOJXypaJOQw4RPdv27Dj4LZvz/ZBTJ9JVPQC1JJlcwkno9PcZUHYd
 qa5TJ8ww/8JJ8QnWeNaZ9FVPdcz0dq6WOsJ8nlkIrAdTmHGU2NpgmfZkjHJ1V2b+Mpa3o6d8MkY
 NdI7ue2LfPVSTMJC0UoQtEL4fhpEy8h5eM3ARre9aba5KJjAiDcAzGgPhU2XeyrNadOnAgHm6mP
 q0bbsTLni766l49Mr1oGPleo6PEGxCZijrXGAfgfSg0BFpYSKW2OmastyNDPgvrdhIe7tbceMSR
 cz8kvRQYNZFVhad0/KehpVGrmqHJcfXXopGmlqVBlWVy74H+2IKo53Kn/9elvBQg==
X-Received: by 2002:a05:6870:b60c:b0:404:3f2b:fcb4 with SMTP id
 586e51a60fabf-415458d7111mr6413628fac.25.1771781555405; 
 Sun, 22 Feb 2026 09:32:35 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4157d2d7922sm5608972fac.12.2026.02.22.09.32.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Feb 2026 09:32:34 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v5 06/19] net/tap: extend fixed MAC range to 16 bits
Date: Sun, 22 Feb 2026 09:30:41 -0800
Message-ID: <20260222173225.522754-7-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260222173225.522754-1-stephen@networkplumber.org>
References: <20260215195348.557945-1-stephen@networkplumber.org>
 <20260222173225.522754-1-stephen@networkplumber.org>
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
index 291c3b5a9d..47dad54465 100644
--- a/drivers/net/tap/rte_eth_tap.c
+++ b/drivers/net/tap/rte_eth_tap.c
@@ -2263,13 +2263,15 @@ set_mac_type(const char *key __rte_unused,
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

