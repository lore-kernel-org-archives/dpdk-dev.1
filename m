Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66163C02198
	for <dpdk-dev@archiver.kernel.org>; Sat,  8 Feb 2025 20:32:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7164540649;
	Sat,  8 Feb 2025 21:32:05 +0100 (CET)
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com
 [209.85.214.177])
 by mails.dpdk.org (Postfix) with ESMTP id 3528140615
 for <dev@dpdk.org>; Sat,  8 Feb 2025 21:32:02 +0100 (CET)
Received: by mail-pl1-f177.google.com with SMTP id
 d9443c01a7336-21f61b01630so20259635ad.1
 for <dev@dpdk.org>; Sat, 08 Feb 2025 12:32:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1739046721;
 x=1739651521; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=laxEXCx80XcdHoH1gOOKbSj67MVc4I5m5RVujYFj2G8=;
 b=FTTStHbGhafRNceI3x24k1ZIINWthAMAab3cPlP+lcXXyT3FyXtMtO/k3rWUHxfO6Q
 F9wQgdLrSy5Lf8Xab0twoOUPknIKWFXi7yZR/zwWRxoNFA9yfN/y3fsh/Gr3JnNnWg4j
 jEjftqOGNqADk6JP0GSGgXwmb0zTCLONmrjKQEwguz7rMUqBgoVXR2s6cZR6iD2ojhhQ
 y5ogxod/KoWfefCLK85M0w+7fpu9EODCZu+YXlTyUg9bRd5cOqWBHHmYOEm3FqrOKE1g
 bKzCkO5yAVbwSPHPxhVwphWOy3bp+Cd/puojPwWf8X88lmSBLMyGN0ZhKQlL4WmDAxnV
 p/GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739046721; x=1739651521;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=laxEXCx80XcdHoH1gOOKbSj67MVc4I5m5RVujYFj2G8=;
 b=vI3EkqlR/PWtNv5YGzzJSh6Iu1/ZkiKZYs7FtTfl/+r85f2ImMn3W7rYwXUWPvNv/J
 H58ks6VoFPI2ogRmDhHzxB/ZfO+G+bYk2qk4j5jEF+Viow6I+35BAeHUKSgfyQA2nKpc
 agLgBVDpvFAYCGk3x/UCY0mIdrC7ht96/TE+Ls9FtYfbsilbu7KSGNfAvMWrXPJYh+QG
 nma7jXNOB3mpSpz1y04INJB6/pvbrwdbeMc0z5yipREBWhADI5b9ewG01U50WeWIzB0k
 T/cdHGQ7BFgceu3Co4sPiFb4B4R3I8XU6QKvf/qdCjd0rupAqC8HYcDt2ka1Ghs77Ri6
 eXRw==
X-Gm-Message-State: AOJu0Yzd1TMlPVu1cohg8PdDuKPPEIt/pLXLyvsVU2y//6IzOUXWfmPj
 4weAy51wSQkO90cdhKNX9x9dOyKiJXLGKGLvIx37tQm2CE3JzPxsvaqoxrboz1cAz7QP6gj9TFT
 Mw3E=
X-Gm-Gg: ASbGnct1c+lNE5VY7M2tGiKpwdSf8E9C0naNQfrhApwf24/K1VpcOc76eY7bPi3v6Mt
 iAyI7QlIyf7mqHzsTd6xHC921tRNk0rxzIand5k9zKjSPccfH9MGYo+2Xq6byM97AE9LzuO3x6r
 l2n880NBrplVEZgZjyJs158QHjMX3njl3RNbENOZo2zw1zff0FkYUtf/QIIOjH12dmZpDrfokvC
 hMIC8Hbi//aYVPsuihhzsx12GNze8S1fHdqHJL32CCATJOzSrMSpzIdvAu/zDYyyOezNMExMu1t
 06t5tYaMIW/youKMOC5fydJOWIO15Y4Ni24Jkh7Cec9kIBqnDQL0gYo5F0PaBFeb81iY
X-Google-Smtp-Source: AGHT+IEJec9El1Al32BdNjFH/HUigmyApaO4fLl2JIUPHbPU5xsxwkfkJOFuMCjHKlEwF4+sHJanGw==
X-Received: by 2002:a05:6a21:6d8e:b0:1e2:2e4:6893 with SMTP id
 adf61e73a8af0-1ee052c529cmr12387299637.9.1739046721381; 
 Sat, 08 Feb 2025 12:32:01 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7304c780da5sm4882019b3a.69.2025.02.08.12.32.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Feb 2025 12:32:00 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Amit Prakash Shukla <amitprakashs@marvell.com>,
 Jerin Jacob <jerinj@marvell.com>,
 Erik Gabriel Carrillo <erik.g.carrillo@intel.com>
Subject: [PATCH 06/32] eventdev: replace memcpy with assignment
Date: Sat,  8 Feb 2025 12:21:58 -0800
Message-ID: <20250208203142.242284-7-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250208203142.242284-1-stephen@networkplumber.org>
References: <20250208203142.242284-1-stephen@networkplumber.org>
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

Prefer structure assignment over memcpy.
Found by cocci/struct_assign.cocci

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/eventdev/rte_event_dma_adapter.c   | 2 +-
 lib/eventdev/rte_event_timer_adapter.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/eventdev/rte_event_dma_adapter.c b/lib/eventdev/rte_event_dma_adapter.c
index 165374d195..70a208620a 100644
--- a/lib/eventdev/rte_event_dma_adapter.c
+++ b/lib/eventdev/rte_event_dma_adapter.c
@@ -449,7 +449,7 @@ rte_event_dma_adapter_create(uint8_t id, uint8_t evdev_id, struct rte_event_port
 	if (pc == NULL)
 		return -ENOMEM;
 
-	rte_memcpy(pc, port_config, sizeof(struct rte_event_port_conf));
+	*pc = *port_config;
 	ret = rte_event_dma_adapter_create_ext(id, evdev_id, edma_default_config_cb, mode, pc);
 	if (ret != 0)
 		rte_free(pc);
diff --git a/lib/eventdev/rte_event_timer_adapter.c b/lib/eventdev/rte_event_timer_adapter.c
index 5886965d14..871cfba576 100644
--- a/lib/eventdev/rte_event_timer_adapter.c
+++ b/lib/eventdev/rte_event_timer_adapter.c
@@ -549,7 +549,7 @@ event_buffer_add(struct event_buffer *bufp, struct rte_event *eventp)
 	/* Instead of modulus, bitwise AND with mask to get head_idx. */
 	head_idx = bufp->head & EVENT_BUFFER_MASK;
 	buf_eventp = &bufp->events[head_idx];
-	rte_memcpy(buf_eventp, eventp, sizeof(struct rte_event));
+	*buf_eventp = *eventp;
 
 	/* Wrap automatically when overflow occurs. */
 	bufp->head++;
-- 
2.47.2

