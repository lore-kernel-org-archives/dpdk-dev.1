Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78F55C98302
	for <dpdk-dev@archiver.kernel.org>; Wed, 23 Sep 2026 01:09:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E271442EFA;
	Wed, 23 Sep 2026 03:08:15 +0200 (CEST)
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mails.dpdk.org (Postfix) with ESMTP id EE08142EF1
 for <dev@dpdk.org>; Wed, 23 Sep 2026 03:08:14 +0200 (CEST)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2cfc52ddc55so3877595ad.3
 for <dev@dpdk.org>; Tue, 22 Sep 2026 18:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1790125694; x=1790730494; darn=dpdk.org;
 h=content-type:cc:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=nmwEE/xj/VmxDwwNUkGVxqZis4hpuVyMCR3Opi1DKfM=;
 b=v1E1wT9N/4w9UDBcZdG7sDBLs+pruma4lSGM9Wl/vdfOVTEH4iqYfvOpD7Murfvgeu
 Dq823ewTirGqnU6ScyF87fRjc5tiOSA6OPD+2wWXpgSjMMXZLqogdSxwGsXguoJydjTa
 3p7WGd4+Ghy6CUNrmN4ltyMaMnKkXbbRk6KOshhc+7Qretu/+GX57Ni+AJzvxev5QmxP
 KVI2ZlPiWNR3kDNmZ/0A+0RCoug4gZlm/kd/dqWZ/FXkYF8avGpCeb+6IcvgcpNiXYHs
 YWViyPezMlJEEf5OtAai2tz/uShRUvTuTiXYyMQtAQf8XokWyCEUvlDJj1eOdsbNQT2f
 JIsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790125694; x=1790730494;
 h=content-type:cc:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=nmwEE/xj/VmxDwwNUkGVxqZis4hpuVyMCR3Opi1DKfM=;
 b=Ym3OufOPQsMMOkc9etkzVy2neKDeulgsiw/nmChWFn77DufSzXn95yrr9lmRd3s81V
 AEf0Fn3nas4pf5P4OtbOT5taM+e5M6J6eVuM/t5Av/lYdKgdKasNK/7gL36+4dfmm5ky
 VA5vR86kLuSMhWxFJ4W7jNrP4XzHrPpvMoWWKqeItH6rrpouO13vMfZXtmz3cajUGgFm
 3Ayf9RSzgNgcUCL4BerJKVjTmkGIBcGUqs37autETZuWWt2CIqX4TQ5juipaEE4RiSlM
 wtmeB+10TLG8SPPPlZgqj8nTEr8GBiXqAcwR2foTIj6ZK8wDSIwckLQqfDgi3OviBaG1
 s8ow==
X-Gm-Message-State: AFuF++mV3IAdwnFMG95WS4MqKkyMMkFKSDi3mwGAy0GgcNdUEgU5m14+
 Z/m954HUNu0ngLP1v6PWuAjBRFtrZh+mka4Ge05Rn/YBszr1gpq0/oGgIVB9BEGBRLViP1dr0dI
 APbASkHGeX9lV6waFV3pnfeTr1kV/bzXgDP9MvBoswWBQd9SQfK/HkB5nXu+RSFvGgJVs6GifBU
 bFWzMmeef5lZg4ZK9sTO0k8RPLU3FB6bAWig==
X-Received: from plei10.prod.google.com ([2002:a17:902:e48a:b0:2df:48dd:9e68])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:e80f:b0:2db:5052:fd6f with SMTP id
 d9443c01a7336-2df69d5751amr10181545ad.17.1790125693595; 
 Tue, 22 Sep 2026 18:08:13 -0700 (PDT)
Date: Tue, 22 Sep 2026 18:07:39 -0700
In-Reply-To: <20260923010742.2468145-1-joshwash@google.com>
Mime-Version: 1.0
References: <20260812223017.2980190-1-joshwash@google.com>
 <20260923010742.2468145-1-joshwash@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260923010742.2468145-17-joshwash@google.com>
Subject: [PATCH v3 16/16] app/test-compress-perf: use common division round up
 macro
From: Joshua Washington <joshwash@google.com>
Cc: dev@dpdk.org, Joshua Washington <joshwash@google.com>
Content-Type: text/plain; charset="UTF-8"
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

The RTE_DIV_ROUND_UP in rte_common.h makes DIV_CEIL redundant.

Signed-off-by: Joshua Washington <joshwash@google.com>
---
Changes in v3:
  - New patch converting DIV_CEIL in comp_perf_test_common.c.
---
 app/test-compress-perf/comp_perf_test_common.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/app/test-compress-perf/comp_perf_test_common.c b/app/test-compress-perf/comp_perf_test_common.c
index 78487196ad..3f70c222c4 100644
--- a/app/test-compress-perf/comp_perf_test_common.c
+++ b/app/test-compress-perf/comp_perf_test_common.c
@@ -14,9 +14,6 @@
 #include "comp_perf_test_common.h"
 #include "comp_perf_test_verify.h"
 
-
-#define DIV_CEIL(a, b)  ((a) / (b) + ((a) % (b) != 0))
-
 struct cperf_buffer_info {
 	uint16_t total_segments;
 	uint16_t segment_sz;
@@ -238,8 +235,8 @@ comp_perf_allocate_memory(struct comp_test_data *test_data,
 		 * Number of segments for input and output
 		 * (compression and decompression)
 		 */
-		test_data->total_segs = DIV_CEIL(test_data->input_data_sz,
-						 test_data->seg_sz);
+		test_data->total_segs = RTE_DIV_ROUND_UP(test_data->input_data_sz,
+							 test_data->seg_sz);
 	} else {
 		/*
 		 * When application does decompression only, input data is
@@ -292,8 +289,8 @@ comp_perf_allocate_memory(struct comp_test_data *test_data,
 		return -1;
 	}
 
-	mem->total_bufs = DIV_CEIL(test_data->total_segs,
-				   test_data->max_sgl_segs);
+	mem->total_bufs = RTE_DIV_ROUND_UP(test_data->total_segs,
+					   test_data->max_sgl_segs);
 
 	snprintf(pool_name, sizeof(pool_name), "op_pool_%u_qp_%u",
 			mem->dev_id, mem->qp_id);
@@ -557,7 +554,7 @@ prepare_bufs(struct comp_test_data *test_data, struct cperf_mem_resources *mem)
 void
 print_test_dynamics(const struct comp_test_data *test_data)
 {
-	uint32_t opt_total_segs = DIV_CEIL(buffer_info.input_data_sz,
+	uint32_t opt_total_segs = RTE_DIV_ROUND_UP(buffer_info.input_data_sz,
 			MAX_SEG_SIZE);
 
 	if (buffer_info.total_buffs > 1) {
-- 
2.55.0.1082.g2b9226bbc0-goog

