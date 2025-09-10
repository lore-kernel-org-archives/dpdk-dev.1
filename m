Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B170CA101F
	for <dpdk-dev@archiver.kernel.org>; Wed, 10 Sep 2025 18:57:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D35AC40670;
	Wed, 10 Sep 2025 20:57:34 +0200 (CEST)
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com
 [209.85.219.41]) by mails.dpdk.org (Postfix) with ESMTP id BD59F40668
 for <dev@dpdk.org>; Wed, 10 Sep 2025 20:57:33 +0200 (CEST)
Received: by mail-qv1-f41.google.com with SMTP id
 6a1803df08f44-726e7449186so77742826d6.0
 for <dev@dpdk.org>; Wed, 10 Sep 2025 11:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=atomicrules-com.20230601.gappssmtp.com; s=20230601; t=1757530652;
 x=1758135452; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fTEAznG4NXOJLArTQoDpsmL4cChyT1LfBWkRGAxUj/A=;
 b=0Z6JMFFYhpvKSK6F880tAEeBHvFwgEP7hKeOgUn0O+d3Jeqdrj13b39d38LtHpCDzL
 MoBdTN+A6H+zKruL0nUkFLHBUOUXk83u3p+gtfk4mSy9v7DENiy0OPGtF+QT6CB+LTj1
 vZjZ/rBNBfePupBHk5WxbEeSCCTuJnodSllF5HL2W4udrTgHIzR3LVUv2rJEXL6eZeKe
 MiEjHZA3fa7M/pJQTyDOEOSvt4hy5mVmGBodtSRzd7FhOPXp3uUTdbPcRzga+fSXrgCQ
 xXsmunW3RgezhCM1lSd/EXA/6BRTRUWBKs+mgupYOpXk5mxhqVyVfYKzfJW4znGW5r0G
 96Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757530652; x=1758135452;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fTEAznG4NXOJLArTQoDpsmL4cChyT1LfBWkRGAxUj/A=;
 b=kNCfbCfQEDMiAPfWRcNcQ4AYEuTD2Qp2ulOBCf81zHaKUhGdF6a92WJ0ILTg9gexog
 OMbzkEaZZewWduiVfmPqN7IeTpb0643Gjr2IyOyOQcgDm/clbtGnUKfN51ihFxOq7npt
 KM6v7eKW1OEXb5faMevGZfILFq4rvoD95aJRi2Sz7zHzYfdkRgnAFSsvit3kjJHjhG/j
 JKBt4LABOZk7MnY32u1U3q9sfPsFDnzm1GTm2A7iAmfmeTGy5q0AGZwZ0s5Hcu6V9yfl
 XixNf5qjeW1cEOpjC3B7aIisIHb7d3Ls3HriLca23X9ramSszGZmEqFYtiBbFjeXxi0L
 gjUw==
X-Gm-Message-State: AOJu0Ywg9f4gy1efSHAnRHvVkln3iiBMDRkxbhb4GdtSBwVssr0BKk5K
 5oZErhmkqP3yfqweq9mgswexFfTsJ7yo2CRwgcf9Dkmk6r4LF2OIxDnPDQKyKbw6LZ+bEncgfHj
 xk5I=
X-Gm-Gg: ASbGncuF9D0Ppf56CpW27iObNcgSYf8OnSydNajlEB+2jrLAivTuH90sImKKVLkxtZZ
 48hSqc6ZZLPHKOCoVYJ214RvtSMW+jsAbjTv8XCYVT6k8MsNr8xSCdIWuP266FIlvnEtEFbj4Hl
 bJD/lnLPTgUwOlGwyqsgn3zxD4TelB6LrBxGxyvvwS1RYAe7AyH6zsrwBK2lBVbP8XRreWX3hyJ
 ndQDbP7/iMvJhuuomugl1HioOsJR2Rd9674i2dXuBWCbKHrQOQy70ZTwgussuUZDTiJ5eSd1xO9
 MGaBFatddh+UKVuPKQ3uBVhHlC5CHstXynVpWg0GpstXZac2RgyRQ0q7kSN6aMt1vLRN2+/TlA0
 HCSCDh9jXSznoYD5pEeaP1CVuUJaIeCFXIuIdUbxEEZWz9ltRsHtMn604u17ZEZ4Tx6JFAXh/T5
 R39zgh+d62+WYYWnq+LKca5qiidt8YAA==
X-Google-Smtp-Source: AGHT+IEDYNNj8Osov4kf6lZRmIZT6DfCRHU1Q0wR5COGxOxxYrUAmatl74LAACarA1GCIlxaZkPvQQ==
X-Received: by 2002:ad4:5945:0:b0:736:bfb9:b27f with SMTP id
 6a1803df08f44-7393ec166a6mr176680536d6.41.1757530652655; 
 Wed, 10 Sep 2025 11:57:32 -0700 (PDT)
Received: from z690.czeck.local (pool-108-20-194-239.bstnma.fios.verizon.net.
 [108.20.194.239]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-762c955968csm376176d6.73.2025.09.10.11.57.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Sep 2025 11:57:32 -0700 (PDT)
From: Ed Czeck <ed.czeck@atomicrules.com>
To: dev@dpdk.org,
	stephen@networkplumber.org
Cc: Shepard Siegel <shepard.siegel@atomicrules.com>,
 John Miller <john.miller@atomicrules.com>
Subject: [PATCH v2 3/4] net/ark: improve ring handling for segmented packets
Date: Wed, 10 Sep 2025 14:57:19 -0400
Message-Id: <20250910185720.995300-3-ed.czeck@atomicrules.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250910185720.995300-1-ed.czeck@atomicrules.com>
References: <20250910185720.995300-1-ed.czeck@atomicrules.com>
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

handle case where complete packet is not yet available

Signed-off-by: Ed Czeck <ed.czeck@atomicrules.com>
---
 drivers/net/ark/ark_ethdev_rx.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ark/ark_ethdev_rx.c b/drivers/net/ark/ark_ethdev_rx.c
index 6077d98ae0..1b5c4b64a4 100644
--- a/drivers/net/ark/ark_ethdev_rx.c
+++ b/drivers/net/ark/ark_ethdev_rx.c
@@ -313,11 +313,15 @@ eth_ark_recv_pkts(void *rx_queue,
 			}
 		}
 
-		if (unlikely(meta->pkt_len > queue->dataroom))
-			cons_index = eth_ark_rx_jumbo
-				(queue, meta, mbuf, cons_index + 1);
-		else
+		if (unlikely(meta->pkt_len > queue->dataroom)) {
+			uint32_t tcons = eth_ark_rx_jumbo(queue, meta, mbuf, cons_index + 1);
+			if ((int32_t)(prod_index - tcons) >= 0)
+				cons_index = tcons; /* nominal condition */
+			else
+				break;
+		} else {
 			cons_index += 1;
+		}
 
 		rx_pkts[nb] = mbuf;
 		nb++;
-- 
2.34.1

