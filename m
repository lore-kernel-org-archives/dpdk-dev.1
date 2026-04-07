Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36AB6FF5106
	for <dpdk-dev@archiver.kernel.org>; Tue,  7 Apr 2026 15:17:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 910A440430;
	Tue,  7 Apr 2026 17:17:47 +0200 (CEST)
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com
 [209.85.215.177])
 by mails.dpdk.org (Postfix) with ESMTP id 911EF40664
 for <dev@dpdk.org>; Tue,  7 Apr 2026 17:17:46 +0200 (CEST)
Received: by mail-pg1-f177.google.com with SMTP id
 41be03b00d2f7-c76ffd06593so474037a12.0
 for <dev@dpdk.org>; Tue, 07 Apr 2026 08:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1775575066;
 x=1776179866; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UwHmQ2PRbGRhsF9pqMmzveqxAWBY9EEY9xGgP77PbqE=;
 b=zCyQmo2bmNjA9B7a9qPn/T9dHTCDLdQQCeRbC7Y6wn59LAEecyhxnH8WhvseqVI17x
 RtWusYinJBkIWRviU/IRm8z/L5IT+2wFwntmM51gNImCTM/zLxGjS9zxWkFDJXEdWgt+
 XZUCf1WzKxFldojNVfpqH/Nwn5V3U42UTZPeautRAbhLNLD4Kj0KsMVkQjvHHNflv6RQ
 Nvc5tNAVwZqkkzMHHaTHHs00Je7tDpQVeFXKZbHZefvPZq/4rMl4kIms6PmONKA/gcmx
 ZiQzZoc4ZMzwO6Bx6FTauxh4Ug7aIDXNw9ImZZbfyCzZQMbxCi3bnwFS6vjv5leoBo8J
 fBqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775575066; x=1776179866;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=UwHmQ2PRbGRhsF9pqMmzveqxAWBY9EEY9xGgP77PbqE=;
 b=aJXT29fpmwZueJy54GKUzcGhWIGIpdwfDUMB/MshikTj5bHhutQNV2QRL8KUzDqTiA
 GZ6TLJYOQMQgB0ruL4WgQfpGjUG1e1D0CSzjwkSXuqMSXpqNhjJJZ129Lf/kJ0Rlwvhl
 H6iExNtXQ6jc3DV9es8GbvbqfiEoYi4WpP2gaSzI9ci9JXvXS5vxM8Tjx0zFcJmR0mjb
 C3diqs16m2+rhBk3j3Iy/pp6gcpaJiUAO6YJB+r1AI2M4S4QZrKfw18wcN+lrFim/bBp
 LbA0gY4Vst92UwpD5qWTBJ2gHTsl9M8/jYAXQs6bbDDr4KCBkCMq84cnFigvyVXYOd1L
 WExQ==
X-Gm-Message-State: AOJu0Ywvehe2jw1N4ztrBFw108Xe8FlMMm2XxrKZa4AM/1ia29qnZo8v
 Y07vcMJq/piF7HUk5QOTI1MwhMY/uOZ6QURLsHWvYfkBoKw5hydv8RMllxgqyR0tehSGoUh2YOr
 UnatQ
X-Gm-Gg: AeBDieuVN+FysEsQryua/qRYe7GhP4hUyOwH/wrGxko9XGrd1HnXtv8uagDXzHSGzlt
 wLYKZIH4bVMWszhW8mNzDt1O2ryiLkn3tVSjBSEVpJcCLzAUSMp3sfSt2uO3ACmHnyCDMMG4Lrm
 9NJIdj+dcQ2MvBMdRWZA8+SdoRiZr4rDVVwooQJ/Q07BVUTlrCenxcEjw78l/I5l5pibGxAmUE3
 n5eqmSOuIUxQV32pd/HOV8x7U1etIIH787OrUqT95aeQCXZVj6jGdzyYRvDDkF9PFVnJbmqzAia
 WMbbCgnUWrVVI+B8DlCcX2SwcZnQ0x6lHjVPrw2V01T9JfmqsiYxOkvGcH9IZ1LJ9ejQyuE8xD3
 2QZv1GnjTddehVciGNDIHsSRtnEgQUorIWxBO9R0Eh4NEPFlaPJBfKmkSb1RaKQjfbhLdbTzs1L
 n1AQls8fwq1nz0AVK7bIBbqUGNpeJakq4L
X-Received: by 2002:a05:6a21:3397:b0:398:ba99:bc87 with SMTP id
 adf61e73a8af0-39f2ed7adcamr17694020637.3.1775575065521; 
 Tue, 07 Apr 2026 08:17:45 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c76c6477bbcsm15842933a12.3.2026.04.07.08.17.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Apr 2026 08:17:45 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v2 02/23] examples/eventdev_pipeline: resolve shadow variable
 warning
Date: Tue,  7 Apr 2026 08:15:58 -0700
Message-ID: <20260407151732.272195-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260407151732.272195-1-stephen@networkplumber.org>
References: <20260407035209.650419-1-stephen@networkplumber.org>
 <20260407151732.272195-1-stephen@networkplumber.org>
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

Fix shadow variable warning by reusing the existing 'ret' variable
instead of declaring a new one with the same name.

../examples/eventdev_pipeline/pipeline_worker_tx.c:877:25: warning:
declaration of 'ret' shadows a previous local [-Wshadow]

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
 examples/eventdev_pipeline/meson.build          | 1 -
 examples/eventdev_pipeline/pipeline_worker_tx.c | 4 ++--
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/examples/eventdev_pipeline/meson.build b/examples/eventdev_pipeline/meson.build
index c317f4b3e2..b8f5cfe109 100644
--- a/examples/eventdev_pipeline/meson.build
+++ b/examples/eventdev_pipeline/meson.build
@@ -13,4 +13,3 @@ sources = files(
         'pipeline_worker_generic.c',
         'pipeline_worker_tx.c',
 )
-cflags += no_shadow_cflag
diff --git a/examples/eventdev_pipeline/pipeline_worker_tx.c b/examples/eventdev_pipeline/pipeline_worker_tx.c
index f7b7937d6a..a3090e3b49 100644
--- a/examples/eventdev_pipeline/pipeline_worker_tx.c
+++ b/examples/eventdev_pipeline/pipeline_worker_tx.c
@@ -874,8 +874,8 @@ init_adapters(uint16_t nb_ports)
 		service.callback = service_rx_adapter;
 		service.callback_userdata = (void *)adptr_services;
 
-		int32_t ret = rte_service_component_register(&service,
-				&fdata->rxadptr_service_id);
+		ret = rte_service_component_register(&service,
+					&fdata->rxadptr_service_id);
 		if (ret)
 			rte_exit(EXIT_FAILURE,
 				"Rx adapter service register failed");
-- 
2.53.0

