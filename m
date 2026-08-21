Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD23BC5DF8C
	for <dpdk-dev@archiver.kernel.org>; Fri, 21 Aug 2026 19:28:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 210AC4069D;
	Fri, 21 Aug 2026 21:28:14 +0200 (CEST)
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com
 [209.85.210.176])
 by mails.dpdk.org (Postfix) with ESMTP id C0A3540658
 for <dev@dpdk.org>; Fri, 21 Aug 2026 21:28:12 +0200 (CEST)
Received: by mail-pf1-f176.google.com with SMTP id
 d2e1a72fcca58-8486ac3f347so2146224b3a.1
 for <dev@dpdk.org>; Fri, 21 Aug 2026 12:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1787340492;
 x=1787945292; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=W8uNKxjMy37OwOjMCzOtx+bkGJTNDUmJoPP2zDTWvPs=;
 b=G/eUA55EOfVjjtxPIkOHd1cKNvkTUn3Z5q/y6W3gqBWfNGPyQLJtvpV/nPCfxznxnM
 9fE+p/b/O/NZLvfJmD/xcbNCko82Kdm7mV1SioRWH8OUhWciUGMmDxJWfOM4GDvAczZc
 lC3sAcBf1BvB3xJtOAC4gHw/YGmmLV57FSvtTxBYwX/RNIqTbpocRXjV1n3sbt5xamew
 jCMta1YJQuAh3sUnpdy3ovWZIA7ovhZ/H/xhmVJmgiiVqWN1SmJs0fRLLR0ylio3Dcq3
 ko1fNPdLY8ttbpW4n2xivDzSUbLWTC/QZyj2nZ3F+55eLWMxRlnl+nfMHPNrhyd4xF1H
 uWAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787340492; x=1787945292;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=W8uNKxjMy37OwOjMCzOtx+bkGJTNDUmJoPP2zDTWvPs=;
 b=eDmCaYT9/J5t6H+5oqvOP88odU79fY3TNI9Kw8AWBEbHiT88s8B1ZITrLuboFg8FJO
 0zQFaYjW4chwRiS6tD/knM/tNQhEIjfgKX5ASaZX1t1hDsAuaLXbp/mV9Sa6t2Cxw1/z
 I1MrLrmC1aSpQT2E5/w9VlEaksYANlyd/Z9fhA7M2Q+SxkhopxiNiXYpVZDGMzHXroEL
 VHJyfupMkEoWpL6kTvfpEjIhiQik6u0Oq6b07Ez2/K7hRPUreAKee9k35VoHBGa/ueJF
 QBhhCwVGaKAqcd0DAYLHioHTEHyqxcFXlgaBH3EgoHZTZXycgJWNdter8HP51yC7w8B4
 LhoA==
X-Gm-Message-State: AFuF++nORAdBcLMsiOAZZRfn+iXQdDK+VsfYjsZ4lUtsniCdhrJnoQj/
 Kx5b3s/hRX/BLYdUTKDb8UiMLJxnKOZxw3ye9PT3wVFi8A6HF1X0NqL9bIy7V7XnPUWR0b1Cwmo
 UYjNi
X-Gm-Gg: AR+sD1386Zl6gHjB/YNPbJ1n3rITEue0XlI2Dh/oH9RegdB71i8aqkLwH8ZtaeFpJAz
 1xcd2GGGvqXnZax8JsV0eYrgXZ5/1k1ePWghINzYx+gnTnfWyuSd1ksMGtVe6t8K3cIMM2iHcrj
 pbD+2vyh9WDDySkxFJgkGbNQbavGebd0n1HDCr8q2ibfS6ElfklOjDIPn0zcPhzkFKd3Yg8HhGG
 uBTxhKMYAMAga1JrG2xUG8NnThr5hGPPV88+jTSxuJRf7QAE++1uUDANziOlIb4hvl5geMd+1+H
 LiXd53OVg6E72v/L06ubt1YbaVmzMLSzI5fz+Fe3NOJlbrbpXT2wxsJT/xgX+8ho9rabJD8KnCd
 z01Q1Z9IT1pj7gOk27g/mE9lj1zM3NQ+u+aas8rxDQ+J1Mcn7pWjCGoUYSiOuwRR5tdzB74HpzV
 DGUyBXHOIDK0IE86t6OLOcvQeRAu+g6+0b5evONeUTuzVH91USAKlvcZk9erozF/fNb5queKa1s
 +pnU+xqVv6L7XHxVTvSzqQVbks=
X-Received: by 2002:a05:6a21:58d:b0:3cc:9294:5b2e with SMTP id
 adf61e73a8af0-3cd31281fb6mr9403363637.0.1787340491908; 
 Fri, 21 Aug 2026 12:28:11 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc16c6dd2f4sm1860304a12.17.2026.08.21.12.28.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 12:28:11 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Sunil Kumar Kori <skori@marvell.com>,
 Rakesh Kudurumalla <rkudurumalla@marvell.com>,
 Nicolas Chautru <nicolas.chautru@intel.com>,
 Cheng Jiang <honest.jiang@foxmail.com>,
 Chengwen Feng <fengchengwen@huawei.com>,
 Srikanth Yalavarthi <syalavarthi@marvell.com>,
 Fan Zhang <fanzhang.oss@gmail.com>, Ashish Gupta <ashishg@marvell.com>,
 Akhil Goyal <gakhil@marvell.com>,
 Abhinandan Gujjar <abhinandan.gujjar@intel.com>
Subject: [PATCH v2 06/68] app: add missing include of rte_memcpy.h
Date: Fri, 21 Aug 2026 12:24:01 -0700
Message-ID: <20260821192646.146382-7-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260821192646.146382-1-stephen@networkplumber.org>
References: <20260820052251.1453273-1-stephen@networkplumber.org>
 <20260821192646.146382-1-stephen@networkplumber.org>
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

These files use rte_memcpy() but relied on rte_memcpy.h being
included indirectly via another header. Add the direct include
so that later patches which remove now-unnecessary includes of
rte_memcpy.h do not break the build.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/graph/ip4_output_hook.c                    | 1 +
 app/test-bbdev/test_bbdev_perf.c               | 1 +
 app/test-compress-perf/comp_perf_test_common.c | 1 +
 app/test-compress-perf/comp_perf_test_verify.c | 1 +
 app/test-dma-perf/benchmark.c                  | 1 +
 app/test-mldev/test_common.c                   | 1 +
 app/test-mldev/test_inference_common.c         | 1 +
 app/test/test_compressdev.c                    | 1 +
 app/test/test_cryptodev_crosscheck.c           | 1 +
 app/test/test_event_crypto_adapter.c           | 1 +
 10 files changed, 10 insertions(+)

diff --git a/app/graph/ip4_output_hook.c b/app/graph/ip4_output_hook.c
index 8757f294cb..16e81d39d9 100644
--- a/app/graph/ip4_output_hook.c
+++ b/app/graph/ip4_output_hook.c
@@ -5,6 +5,7 @@
 #include <rte_graph.h>
 #include <rte_graph_worker.h>
 #include <rte_graph_feature_arc_worker.h>
+#include <rte_memcpy.h>
 
 #include "rte_node_ip4_api.h"
 
diff --git a/app/test-bbdev/test_bbdev_perf.c b/app/test-bbdev/test_bbdev_perf.c
index 9fb0a25948..d6f49549eb 100644
--- a/app/test-bbdev/test_bbdev_perf.c
+++ b/app/test-bbdev/test_bbdev_perf.c
@@ -15,6 +15,7 @@
 #include <rte_cycles.h>
 #include <rte_lcore.h>
 #include <rte_malloc.h>
+#include <rte_memcpy.h>
 #include <rte_random.h>
 #include <rte_hexdump.h>
 #include <rte_interrupts.h>
diff --git a/app/test-compress-perf/comp_perf_test_common.c b/app/test-compress-perf/comp_perf_test_common.c
index 78487196ad..0841e27cce 100644
--- a/app/test-compress-perf/comp_perf_test_common.c
+++ b/app/test-compress-perf/comp_perf_test_common.c
@@ -6,6 +6,7 @@
 #include <rte_eal.h>
 #include <rte_log.h>
 #include <rte_compressdev.h>
+#include <rte_memcpy.h>
 
 #include "comp_perf.h"
 #include "comp_perf_options.h"
diff --git a/app/test-compress-perf/comp_perf_test_verify.c b/app/test-compress-perf/comp_perf_test_verify.c
index 66425d7e3c..12a5f8b764 100644
--- a/app/test-compress-perf/comp_perf_test_verify.c
+++ b/app/test-compress-perf/comp_perf_test_verify.c
@@ -8,6 +8,7 @@
 #include <rte_eal.h>
 #include <rte_log.h>
 #include <rte_compressdev.h>
+#include <rte_memcpy.h>
 
 #include "comp_perf_test_verify.h"
 #include "comp_perf_test_common.h"
diff --git a/app/test-dma-perf/benchmark.c b/app/test-dma-perf/benchmark.c
index c0ffc859bd..f415f73cb2 100644
--- a/app/test-dma-perf/benchmark.c
+++ b/app/test-dma-perf/benchmark.c
@@ -7,6 +7,7 @@
 #include <stdlib.h>
 #include <unistd.h>
 
+#include <rte_memcpy.h>
 #include <rte_time.h>
 #include <rte_mbuf.h>
 #include <rte_dmadev.h>
diff --git a/app/test-mldev/test_common.c b/app/test-mldev/test_common.c
index 90e591f205..3c095d3abf 100644
--- a/app/test-mldev/test_common.c
+++ b/app/test-mldev/test_common.c
@@ -6,6 +6,7 @@
 
 #include <rte_common.h>
 #include <rte_malloc.h>
+#include <rte_memcpy.h>
 #include <rte_memory.h>
 #include <rte_mldev.h>
 
diff --git a/app/test-mldev/test_inference_common.c b/app/test-mldev/test_inference_common.c
index 3b77f37010..e21d1311b3 100644
--- a/app/test-mldev/test_inference_common.c
+++ b/app/test-mldev/test_inference_common.c
@@ -13,6 +13,7 @@
 #include <rte_launch.h>
 #include <rte_lcore.h>
 #include <rte_malloc.h>
+#include <rte_memcpy.h>
 #include <rte_memzone.h>
 #include <rte_mldev.h>
 
diff --git a/app/test/test_compressdev.c b/app/test/test_compressdev.c
index 293d1d757f..73e2d4bbbe 100644
--- a/app/test/test_compressdev.c
+++ b/app/test/test_compressdev.c
@@ -10,6 +10,7 @@
 
 #include <rte_cycles.h>
 #include <rte_malloc.h>
+#include <rte_memcpy.h>
 #include <rte_mempool.h>
 #include <rte_mbuf.h>
 #include <rte_compressdev.h>
diff --git a/app/test/test_cryptodev_crosscheck.c b/app/test/test_cryptodev_crosscheck.c
index bb21c3bc50..84e05b8359 100644
--- a/app/test/test_cryptodev_crosscheck.c
+++ b/app/test/test_cryptodev_crosscheck.c
@@ -3,6 +3,7 @@
  */
 #include <rte_cryptodev.h>
 #include <rte_malloc.h>
+#include <rte_memcpy.h>
 
 #include "test.h"
 #include "test_cryptodev.h"
diff --git a/app/test/test_event_crypto_adapter.c b/app/test/test_event_crypto_adapter.c
index cac1584f40..d1674a5ba1 100644
--- a/app/test/test_event_crypto_adapter.c
+++ b/app/test/test_event_crypto_adapter.c
@@ -7,6 +7,7 @@
 #include <string.h>
 #include <rte_common.h>
 #include <rte_malloc.h>
+#include <rte_memcpy.h>
 #include <rte_mempool.h>
 #include <rte_mbuf.h>
 #include <rte_cryptodev.h>
-- 
2.53.0

