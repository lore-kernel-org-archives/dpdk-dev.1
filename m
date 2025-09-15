Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95AD0CAC592
	for <dpdk-dev@archiver.kernel.org>; Mon, 15 Sep 2025 15:02:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 897FC4067D;
	Mon, 15 Sep 2025 17:02:27 +0200 (CEST)
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com
 [209.85.219.43]) by mails.dpdk.org (Postfix) with ESMTP id 171AF406A2
 for <dev@dpdk.org>; Mon, 15 Sep 2025 17:02:26 +0200 (CEST)
Received: by mail-qv1-f43.google.com with SMTP id
 6a1803df08f44-7240eb21ccaso50202126d6.0
 for <dev@dpdk.org>; Mon, 15 Sep 2025 08:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=atomicrules-com.20230601.gappssmtp.com; s=20230601; t=1757948545;
 x=1758553345; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fTEAznG4NXOJLArTQoDpsmL4cChyT1LfBWkRGAxUj/A=;
 b=XHj+W+n+ZRa+XBhYMhMtUZN05YB7oNswqURzKJ5nnFSbJgI3Qil3py81hrBoTTIqMX
 n3hPTv7xXoCmS0x75Lftg0D8MDnZfoxWLA9S0mYWaqQ2Bm/kAr7Lgcz5LLUkh4HUHKd6
 GCPkOdTb9uXJ5tjt5w4W21ECZepj4BGLtaYXRgcXjSNXJL1Z2Ke3wKb0Lnbe3bmXnnOy
 g50+HcMCc4uk5dShKXdQlMHFEVM4F1PvkkPW5wfEprJjw7WoGZRX5Nl6na0zpgFW/jkx
 jGPPoFFY6HpayfJTDdEySKz8enNVyKG1PdlLUsZM8w+JutiETXypvHs759swpPiIWpbi
 ZSJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757948545; x=1758553345;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fTEAznG4NXOJLArTQoDpsmL4cChyT1LfBWkRGAxUj/A=;
 b=LMUobQOcHpaA9iEtYUtYQl3BUxTeu8sDfuUi5sQpUt1VnGbD9nPpB3t8rLYC9TI2vj
 rwEYX3j7LgGUioQKmlwqG4qFmlSH4KeTbmGWxphCvgOWim3ycRNyjMUq1lhoP+bwfWNM
 PsrVCotxV80nz5qSwYtoszBhzZZ2qx5TyRa0ncAuV1nzdstj8oRq3NKHAeEmKwQxkj38
 BoqIwf2jhlaeD0L6LqkHGIUTpoRJooHaQU41U6tx+tyG1sDVqCk+4UswZ9dCtQVmjW2A
 irxNspyqy5J/rX1hCxnsE+Vvjg7aqmxYn1UZvMjh97pd09aMeqTVbCa7PTOY047/w9nz
 q/pw==
X-Gm-Message-State: AOJu0YxrK0GDjyY55AWAqttlQdjxhP9pucKeFQJMCO9wnHUBNpx+Rx1O
 TWWKYE/VP1PDf7yTMqZrJj7A93hK3q9WBIOIeJFhUlwpgjd0kxth7a5XbRhzihP+KtR0VjHzHvy
 QPp0=
X-Gm-Gg: ASbGnctZE7YaVJn4yy+Fdz2S9Ngg4gTBuu7axfAiltGXTY/uNNNH+qEKFermE6tdm5Y
 /4k4w4CJrN/ST3estGXgOv6bQJkQf4+DoV9LTGrRAPyXfet7CcE1bx47dM8V5RK4iRqZjD8mWpL
 7ViQGdqXAvP3nxPAK4PlKN/ywd0+Pyfr6gQ84CpLsVfv7eUh9nz6q3aaUlP1K2wf9QbKt+p7dzv
 0aRmwu7d3QpAki73H0dPvP+K9lFYIuilFMyW3zZi4Yeoy5Ra/iOyCsshVFWvBrVU4mjWcW4eACC
 +qyHmo9A/np5UJvdaekTH27CKxE48Hj01cIMNceYg4UugpfbJH3pp3mt46A4R7LZY0LI7B2j+pG
 fy+t8aTN30GGXYqjK24BkDIxwRzNuPpTjtp0NvhCV+1dAov8OwpQT59+dKd3q5qdNCZONVhksaA
 Peh84VkT7kl/r5yPi5NxE=
X-Google-Smtp-Source: AGHT+IHi0rZDTjsDXXiBsrGl+oPd6GM3YBlRrLZfFgzCawdRDEuYC5wNCXNdsq4C+T6JT5FdA13b6w==
X-Received: by 2002:a05:6214:518a:b0:780:a69f:d7a8 with SMTP id
 6a1803df08f44-780a69fd836mr39203166d6.21.1757948544756; 
 Mon, 15 Sep 2025 08:02:24 -0700 (PDT)
Received: from z690.czeck.local (pool-108-20-194-239.bstnma.fios.verizon.net.
 [108.20.194.239]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-783edc88db3sm18930486d6.66.2025.09.15.08.02.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Sep 2025 08:02:23 -0700 (PDT)
From: Ed Czeck <ed.czeck@atomicrules.com>
To: dev@dpdk.org,
	stephen@networkplumber.org
Cc: Shepard Siegel <shepard.siegel@atomicrules.com>,
 John Miller <john.miller@atomicrules.com>
Subject: [PATCH v3 3/4] net/ark: improve ring handling for segmented packets
Date: Mon, 15 Sep 2025 11:02:03 -0400
Message-Id: <20250915150204.1719628-3-ed.czeck@atomicrules.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250915150204.1719628-1-ed.czeck@atomicrules.com>
References: <20250903212846.268492-1-ed.czeck@atomicrules.com>
 <20250915150204.1719628-1-ed.czeck@atomicrules.com>
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

