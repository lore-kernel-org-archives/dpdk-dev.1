Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6CD3CA5FFD
	for <dpdk-dev@archiver.kernel.org>; Tue,  6 Oct 2026 02:32:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AE02A40E4B;
	Tue,  6 Oct 2026 04:31:26 +0200 (CEST)
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mails.dpdk.org (Postfix) with ESMTP id 85E57410E3
 for <dev@dpdk.org>; Tue,  6 Oct 2026 04:31:25 +0200 (CEST)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-cc4ac5feaa4so1870937a12.1
 for <dev@dpdk.org>; Mon, 05 Oct 2026 19:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1791253885; x=1791858685; darn=dpdk.org;
 h=content-type:cc:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=t3+6H8/daprry6UgefoaCAElnyPZwxTns0LbDV8j4l0=;
 b=ebC68yDhf7WAc1eemb1+Hy7gSZ2epYBtsVK2bk/gyD2oWzlP/9wnYK3KXyROp1XY2Y
 BH/pEWo2UoWOIQ9hNjAjT9pPqCsMRVI4p7SUxu0AMdt3YIR/pDtiOzAyIjC7SizU6uey
 Ou0CljIW6Kg10nHg753dkQDLq/kBwi492hNbi92vywDDPg4GuI2gucCyxpggO1r7p1Ze
 Et14A598FkFaLghhhrHH8Y0UjcAU75AAZanuVA82GIZyS+aMTWqTSwLKTftrxfjIhbW/
 HrlI+RFZzCXLnl3TOLv6/DC8FGo3moAdRsc9ESkbhD/25tqSUQMg9P61sdCakBJHU0TX
 mhkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791253885; x=1791858685;
 h=content-type:cc:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=t3+6H8/daprry6UgefoaCAElnyPZwxTns0LbDV8j4l0=;
 b=MmSIHq3qncZYsRkewwdRO86YSuI5EDbEz2dl4VgN4nE/pKmOsSCDNEpxDgDgVCmLfU
 Wovp8bwhE8zOumm5QSMKiQCvWo3oryHJKQgYsYGQCx7zt1xqazFc82nZHBOi/vkGdfRM
 tCvJaJjVobcHvkruUhKLDPtEwiLib5TznonxrWbbrHFt2VE8xh4FYV8a9dysSS6jkW1T
 yqVz6caz6fQN4Gs9O2HAMGqGUeLX6DtNKMdfD4/FUErhUTjDFEd14vbk80LzKablCwv6
 N01m8rVLOM83SizMWriFlC7ivm814cZfHskjcvQwncuTduW16vgPVN1BXHGKH4pHm/C2
 UZXA==
X-Gm-Message-State: AFuF++kVykR8dPTSXEBlg4PagRwXEc8+O/On56A59spgpf+HuB6rB3ac
 wWDRduJwdbhtHXY/fWvtCeZaMNB6MBnn5FrnRECIBmUOW3ZwqGD3iVHzpApbpitqSU+dPROX+YG
 pAZyyxRHJtKIHKV1PPjypuDq+mylNeuFy2XxZewCtrPqW8ULlu3HxoafmLhTMRCXqobNMwM2wXN
 4Y4HszV3dzHs4/Uh5sDB4GEWFFgJ9ctBaGOQ==
X-Received: from pglk7-n1.prod.google.com
 ([2002:a05:6a02:6b87:10b0:cc7:8db3:268c])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:7113:b0:3df:c9eb:1281 with SMTP id
 adf61e73a8af0-3e124494f88mr4804637.3.1791253884073; 
 Mon, 05 Oct 2026 19:31:24 -0700 (PDT)
Date: Mon,  5 Oct 2026 19:30:51 -0700
In-Reply-To: <20261006023053.2572501-1-joshwash@google.com>
Mime-Version: 1.0
References: <20260923010742.2468145-1-joshwash@google.com>
 <20261006023053.2572501-1-joshwash@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20261006023053.2572501-16-joshwash@google.com>
Subject: [PATCH v4 15/15] app/test-compress-perf: use common division round up
 macro
From: Joshua Washington <joshwash@google.com>
Cc: dev@dpdk.org, Joshua Washington <joshwash@google.com>, 
 Chengwen Feng <fengchengwen@huawei.com>
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
Acked-by: Chengwen Feng <fengchengwen@huawei.com>
---
Changes in v4:
  - Add rte_common.h include.
Changes in v3:
  - New patch converting DIV_CEIL in comp_perf_test_common.c.
---
 app/test-compress-perf/comp_perf_test_common.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/app/test-compress-perf/comp_perf_test_common.c b/app/test-compress-perf/comp_perf_test_common.c
index 78487196ad..53685cd57d 100644
--- a/app/test-compress-perf/comp_perf_test_common.c
+++ b/app/test-compress-perf/comp_perf_test_common.c
@@ -6,6 +6,7 @@
 #include <rte_eal.h>
 #include <rte_log.h>
 #include <rte_compressdev.h>
+#include <rte_common.h>
 
 #include "comp_perf.h"
 #include "comp_perf_options.h"
@@ -14,9 +15,6 @@
 #include "comp_perf_test_common.h"
 #include "comp_perf_test_verify.h"
 
-
-#define DIV_CEIL(a, b)  ((a) / (b) + ((a) % (b) != 0))
-
 struct cperf_buffer_info {
 	uint16_t total_segments;
 	uint16_t segment_sz;
@@ -238,8 +236,8 @@ comp_perf_allocate_memory(struct comp_test_data *test_data,
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
@@ -292,8 +290,8 @@ comp_perf_allocate_memory(struct comp_test_data *test_data,
 		return -1;
 	}
 
-	mem->total_bufs = DIV_CEIL(test_data->total_segs,
-				   test_data->max_sgl_segs);
+	mem->total_bufs = RTE_DIV_ROUND_UP(test_data->total_segs,
+					   test_data->max_sgl_segs);
 
 	snprintf(pool_name, sizeof(pool_name), "op_pool_%u_qp_%u",
 			mem->dev_id, mem->qp_id);
@@ -557,7 +555,7 @@ prepare_bufs(struct comp_test_data *test_data, struct cperf_mem_resources *mem)
 void
 print_test_dynamics(const struct comp_test_data *test_data)
 {
-	uint32_t opt_total_segs = DIV_CEIL(buffer_info.input_data_sz,
+	uint32_t opt_total_segs = RTE_DIV_ROUND_UP(buffer_info.input_data_sz,
 			MAX_SEG_SIZE);
 
 	if (buffer_info.total_buffs > 1) {
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

