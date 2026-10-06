Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE448CA5FFD
	for <dpdk-dev@archiver.kernel.org>; Tue,  6 Oct 2026 02:32:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C773D410D4;
	Tue,  6 Oct 2026 04:31:24 +0200 (CEST)
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mails.dpdk.org (Postfix) with ESMTP id 3FB5140DF5
 for <dev@dpdk.org>; Tue,  6 Oct 2026 04:31:23 +0200 (CEST)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2d02df2bf09so21027945ad.0
 for <dev@dpdk.org>; Mon, 05 Oct 2026 19:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1791253882; x=1791858682; darn=dpdk.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=o9T7WM9og5gs7OuHnwETmn6m+QIy5v0hnjjvKSd0vxk=;
 b=iKHrF6cbCpzB2ocqZhQ5SkY5Uhw+f60fQl1AsOpuCh3hUQNyZLPu1NzHU/qtqXOzjB
 GhddIUajGgltMMkvUwD1cX3GXIhCCq4cCFo2LWQkfylq7sgzxP4uvgjKUViK6uyZ6v1F
 J6NmX/t24l8zDkK+VVbBig0AtRNdLfhg8ZUOSgfCKSz+etF/SlEmz7axPDF7fF8cMus7
 ejk99UEnQQKOB9ZZnRlTcGpV6E+wtrhoCihYGVLt0AQDLU6crPg9rCxYS5LhM5BMfCU+
 HS/q/JlOz2EJECFXmQ8Qwqc5A1dpLJIqdxrAjVNdwS13JFN1G65SYt7f/qiCJoTpkoIC
 2YRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791253882; x=1791858682;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=o9T7WM9og5gs7OuHnwETmn6m+QIy5v0hnjjvKSd0vxk=;
 b=KOkPONnX3hT3UJ2iqec7oIH41oKjXtbjNM99u5KjYEVW7qiMq++0WFk8bLMRBY76LJ
 DisnRi2V6/OLvaYBLRhNCV2Qz158r0hygQRVkRIrFIZmam/73SKWG0F1rJHd/OJKyg5L
 bTaCc20yat41fKZdUKgL1n0UnNRBk3xAGdj2rDFF/VKrsO1PJS6ZWCG7TYLNp/EgF6O8
 jKUIbOoaIZQTBkJbWMjc8sBioELtJWM9NcDnJdyY1Qe5UboihWaB2qs74wCZzpAMygua
 qpiix2GGV2sBlSFO9AZgQD3Uqh0Ac566kQDoahauIkm/hiNjCT4boNf7nn/JEFlXZ3Vz
 4xVw==
X-Gm-Message-State: AFq9FYLcSXPvkbIIEbO/gUxILAp3kRdK0FieVWfA5T/HWPhc/ksyXv13
 YhZkUrJyS7nxMTIjRuIwNRWOdOtvp5QeBWV2di2P+uLHT22oMH46g94tQUC8Hr0w06bEO0eBoaO
 OlsCMHmMSeuUZrg==
X-Received: from plbmo11.prod.google.com ([2002:a17:903:a8b:b0:2dd:288d:db3b])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:ecc3:b0:2df:a023:6883 with SMTP id
 d9443c01a7336-2e5dcd824admr557645ad.17.1791253882173; 
 Mon, 05 Oct 2026 19:31:22 -0700 (PDT)
Date: Mon,  5 Oct 2026 19:30:50 -0700
In-Reply-To: <20261006023053.2572501-1-joshwash@google.com>
Mime-Version: 1.0
References: <20260923010742.2468145-1-joshwash@google.com>
 <20261006023053.2572501-1-joshwash@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20261006023053.2572501-15-joshwash@google.com>
Subject: [PATCH v4 14/15] app/test: use common division round up macro
From: Joshua Washington <joshwash@google.com>
To: Fan Zhang <fanzhang.oss@gmail.com>, Ashish Gupta <ashishg@marvell.com>
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
  - New patch converting DIV_CEIL in test_compressdev.c.
---
 app/test/test_compressdev.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/app/test/test_compressdev.c b/app/test/test_compressdev.c
index 293d1d757f..ed0352a909 100644
--- a/app/test/test_compressdev.c
+++ b/app/test/test_compressdev.c
@@ -14,12 +14,11 @@
 #include <rte_mbuf.h>
 #include <rte_compressdev.h>
 #include <rte_string_fns.h>
+#include <rte_common.h>
 
 #include "test_compressdev_test_buffer.h"
 #include "test.h"
 
-#define DIV_CEIL(a, b)  ((a) / (b) + ((a) % (b) != 0))
-
 #define DEFAULT_WINDOW_SIZE 15
 #define DEFAULT_MEM_LEVEL 8
 #define MAX_DEQD_RETRIES 10
@@ -688,7 +687,7 @@ prepare_sgl_bufs(const char *test_buf, struct rte_mbuf *head_buf,
 		uint16_t seg_size)
 {
 	uint32_t remaining_data = total_data_size;
-	uint16_t num_remaining_segs = DIV_CEIL(remaining_data, seg_size);
+	uint16_t num_remaining_segs = RTE_DIV_ROUND_UP(remaining_data, seg_size);
 	struct rte_mempool *pool;
 	struct rte_mbuf *next_seg;
 	uint32_t data_size;
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

