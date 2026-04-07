Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80CA7FF5105
	for <dpdk-dev@archiver.kernel.org>; Tue,  7 Apr 2026 15:20:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7F65D40DC9;
	Tue,  7 Apr 2026 17:18:50 +0200 (CEST)
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com
 [209.85.216.53]) by mails.dpdk.org (Postfix) with ESMTP id 6169540DC9
 for <dev@dpdk.org>; Tue,  7 Apr 2026 17:18:49 +0200 (CEST)
Received: by mail-pj1-f53.google.com with SMTP id
 98e67ed59e1d1-35da01fc0baso3508302a91.2
 for <dev@dpdk.org>; Tue, 07 Apr 2026 08:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1775575128;
 x=1776179928; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C47heTD91qhR5gBKwyBrZS1MV55S5hBMkLnXIM6N5k0=;
 b=osaiegMhTVuP4CY9DUX34y/OQq25Mia8MOMZ4+O7bHNfgFf1zqcXW2jna2Xds67rGO
 JbFZjTjCtFH9Jwvsui2j0hwC+j4lVrIt/YwxaWqyQ1j8fUHwSAr8hWW6GszMgYdzVekT
 QAc7Uz+itvGdyytxHG8pJHPf6OLEClrkNseuENaB8a72YxkvdI69StsiihtWAMueBHUF
 8uxkrATfeeAPhQb7Ds57yMzXRcTMwH8y7PH32qv7hUaIVfSVv1Bp+P9XmSiisO7EVUPA
 frMvHEpGOif1AQKs4+TqZ07tE4dg+xNqBHrn69E3bfwgTFE1maQ6mlznWEe/IJq+UeXE
 yaBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775575128; x=1776179928;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=C47heTD91qhR5gBKwyBrZS1MV55S5hBMkLnXIM6N5k0=;
 b=iN9md3/cjkJLg8YEWA93HFLE+7+BlVrPvsmn9jxNCQ8ytN9PoctsuFl4inIZmABBs0
 oTXwSRMXvv8zO53mtn/wKMBhFSqSK6En4VxklyW3nAxc+pvengkD4ugbB+YMmffaJ2Ox
 k+K6JvgTXNhgyYxoMDczuO5DTFLYi6x41AYpiM9fOFSKVJogtj3nXkeqfABUpZAII1n6
 EgePjFxgV4R83tbQs5yHOWxPrRPyDZtcw4TJ58s0a1L1VuWQ7mc/I0mT4mhGE6PgFH56
 Izts80iCTGINh0IM1ytwnCIlsOcPtVvvMfM1v3zA8VyVPnKHVro3DekQLV515pjnkYKg
 fHrw==
X-Gm-Message-State: AOJu0Yw3jSYQvYXl2TlbJ2NpFB8M9QoDAMDxDt3/63E3LlLuGZheJ0eJ
 nAJ1kPn/uQzbFK5sPH0pDCZhXbQwxsi8JUu87RteAGoXpXuPQxyc3abBPQG4FoC7y+I1FOEm1OF
 Q/nKq
X-Gm-Gg: AeBDiev/c5ffFIz5EiVKtSifY0bbLQcDkg6wdqK1kSLmB8W80demqkmC165PZl3IDkE
 +Qgo97vQlwaqqQGgWzRzR7wai0VZKURKnIXbpkppsdiyJ2uCiLbQnUaXKOmCfBmQmmpIXtWTJ2S
 +MQq9+w9F30EaOkDRWGwY+hXUXgaAmrwtsqJ5VG2TJHOwqcPjrPxk4LBW89sjLR9t10Sf90asQN
 JU62RWFoKsVz5cTm03c6BGUcZoqVpkaWu4LWoGQR7Ce/yKhZt9Baev6Om0ROztEUmHex5PHzoXo
 KA71SHyNUDV+WTr9tc8OTqQm7ni1N1FPG7lhXtxFjkMkuq4CNps9gozdHOYOmLyqd5ACgtK+jEA
 HkbsQF2zd7hDrd/5iuLCnKbevJpMpgWSrtZ7YwfQPI4qNGx7G5wo1SWO9c3mVvE1pjkWTlNxPtt
 bVRaiiY66voD6aKYhm3w0FsvaXF6dmPrZY
X-Received: by 2002:a17:90b:2d10:b0:35d:a9bb:1e33 with SMTP id
 98e67ed59e1d1-35de685ecf3mr17648425a91.11.1775575128412; 
 Tue, 07 Apr 2026 08:18:48 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c76c6477bbcsm15842933a12.3.2026.04.07.08.18.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Apr 2026 08:18:48 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v2 20/23] examples/l2fwd-keepalive: resolve shadow variable
 warning
Date: Tue,  7 Apr 2026 08:16:16 -0700
Message-ID: <20260407151732.272195-21-stephen@networkplumber.org>
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

The qconf parameter can reused, fixing a shadow warning.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
 examples/l2fwd-keepalive/main.c      | 2 +-
 examples/l2fwd-keepalive/meson.build | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/examples/l2fwd-keepalive/main.c b/examples/l2fwd-keepalive/main.c
index 993e0bf9da..12ca60c3e4 100644
--- a/examples/l2fwd-keepalive/main.c
+++ b/examples/l2fwd-keepalive/main.c
@@ -780,7 +780,7 @@ main(int argc, char **argv)
 	}
 	/* launch per-lcore init on every worker lcore */
 	RTE_LCORE_FOREACH_WORKER(lcore_id) {
-		struct lcore_queue_conf *qconf = &lcore_queue_conf[lcore_id];
+		qconf = &lcore_queue_conf[lcore_id];
 
 		if (qconf->n_rx_port == 0)
 			RTE_LOG(INFO, L2FWD,
diff --git a/examples/l2fwd-keepalive/meson.build b/examples/l2fwd-keepalive/meson.build
index 258f3baf08..e3f72aedb8 100644
--- a/examples/l2fwd-keepalive/meson.build
+++ b/examples/l2fwd-keepalive/meson.build
@@ -19,4 +19,3 @@ sources = files(
         'main.c',
         'shm.c',
 )
-cflags += no_shadow_cflag
-- 
2.53.0

