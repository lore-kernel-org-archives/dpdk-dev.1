Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70292CA1012
	for <dpdk-dev@archiver.kernel.org>; Wed,  3 Sep 2025 21:29:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 76D7340ED3;
	Wed,  3 Sep 2025 23:28:57 +0200 (CEST)
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com
 [209.85.222.177])
 by mails.dpdk.org (Postfix) with ESMTP id 26BDA40E2D
 for <dev@dpdk.org>; Wed,  3 Sep 2025 23:28:54 +0200 (CEST)
Received: by mail-qk1-f177.google.com with SMTP id
 af79cd13be357-805a55c09aeso44972785a.0
 for <dev@dpdk.org>; Wed, 03 Sep 2025 14:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=atomicrules-com.20230601.gappssmtp.com; s=20230601; t=1756934933;
 x=1757539733; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fTEAznG4NXOJLArTQoDpsmL4cChyT1LfBWkRGAxUj/A=;
 b=GIep7vpV+XqzDJSa06Bpgs1kyd5CapdpCJEB3vNqjtYcNBcM5fbWTnlgVV5MjRwMua
 +6NegsUTxVFBXa55HGm5djnmOkYFFZenKjVE27cxEgErjdigXsUYyKz4BqtQGG87L389
 gyya3fBegZE+17LhVlu/lf2zpmCcDIxz2tSuXbB6GLL76zvx1e4lrBbyNm22KJmwaIiP
 /NaWYAtqP2etigqUMlckdx7i4jFMz3QblyMpYQY7cmt6TJ3/M2T8zNjsrlypjHOt3tx+
 1XbftTdB1YFb7X4LYPv00n+Q9eVBSD2VVw3vm/ScHQ8cxP3GP1kn0bbwB0+Du3G0y/VY
 Pvaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756934933; x=1757539733;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fTEAznG4NXOJLArTQoDpsmL4cChyT1LfBWkRGAxUj/A=;
 b=iDuiDfg/lzPZl5iUXJ0tcyBCVfcflN2K+7d/t/MtQx2I9u6U0XeYXP5y/Op9ERSJd8
 DNmg0FlJA3IrodRf76XKIJVsz37hyLw1CzUyCEpVIs6+BVbUJMKbzpWbSN4+sRSkId2G
 kpZD76VQJN/nwT2zBU5CeSqvw9vuYmRGuWp941l5SzJrIg9jNq5ZdF5cCK3r7FW6jqk/
 dAY6+7icU9dcOLfpqIV73Zb/hQiJ4F0DEXnj68d5SzwV24JlmQBnYN36zcQRfNPbHsQd
 2OcPI8TANhqVmpdp5D4U4X28EI5IyukJ656kHdg0P/PJW8GZy9QwwE20if9q9o8Cpb4c
 hPyQ==
X-Gm-Message-State: AOJu0YzjtBII4ZRouvCW6VipofCVw4nFLVqn9LyK1eg32aNHKITPJgad
 NJa+q24fVHgXFgeIcrbPehdpJQ/51E53yEktPuseW0d8oqg+nBRl0mFtc2FXgAzV9epzATurqZ3
 yiyM=
X-Gm-Gg: ASbGnctvsuiCdY0B2hUotNcwrNbwHrdpzWWpfL1O5GEU83DjL4BaLinFcDK/BldDtL9
 HO+FzGHWfXEGdRNEPKYtr2qWu4qSeeF77HeKeqU9s+qeGZT/DI2zoEFJq4Yh4BZ1a76TVh4/JQZ
 K2843BGxYQuirWX7KhsujOaoUKf8bFOVK2GQ/Nm2K1/njBR0EYPFxXcUrRsHLtURQ9OyudznrLH
 smG9TiSDNx3lYcOMGqbTu0KGFTw7mbaAMuNg2McmvnAVSEGPh08u0h3/ihB4JuUfKNiaI3Hclr0
 riIAfTODWFsG9JF0rzTi1XvoB5PM4Jpwhb6VGoUYGBhAE/fFOiGYtEa8qVrbBeQN6JOsp0GpK/J
 GM19rDu00I13JDFP+He5ZpX9dvT/x8rjzygushhO6oRAwiNpMLbDsDdQcsuv6MGtntndXFZ/K3L
 rsvn3Hd1F1oCwyx+oFEvtEuq/O7dB7pw==
X-Google-Smtp-Source: AGHT+IGiJ3ohDqBN++IJDCLJMrgVk4UDbSxYg/GVX/wUGT5WJj5kZMLIJvdfp4GhHNrxTs2q3lLV6g==
X-Received: by 2002:a05:620a:700c:b0:7ea:f50d:8e8b with SMTP id
 af79cd13be357-7ff27b1f8edmr1920630685a.21.1756934933135; 
 Wed, 03 Sep 2025 14:28:53 -0700 (PDT)
Received: from z690.czeck.local (pool-108-20-194-239.bstnma.fios.verizon.net.
 [108.20.194.239]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-80aaaa1d6f4sm175929385a.42.2025.09.03.14.28.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Sep 2025 14:28:52 -0700 (PDT)
From: Ed Czeck <ed.czeck@atomicrules.com>
To: dev@dpdk.org
Cc: Shepard Siegel <shepard.siegel@atomicrules.com>,
 John Miller <john.miller@atomicrules.com>
Subject: [PATCH 3/4] net/ark: improve ring handling for segmented packets
Date: Wed,  3 Sep 2025 17:28:44 -0400
Message-Id: <20250903212846.268492-3-ed.czeck@atomicrules.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250903212846.268492-1-ed.czeck@atomicrules.com>
References: <20250903212846.268492-1-ed.czeck@atomicrules.com>
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

