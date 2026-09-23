Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FE98C98302
	for <dpdk-dev@archiver.kernel.org>; Wed, 23 Sep 2026 01:09:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 053DE42EF6;
	Wed, 23 Sep 2026 03:08:15 +0200 (CEST)
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by mails.dpdk.org (Postfix) with ESMTP id 8F9FF42EE2
 for <dev@dpdk.org>; Wed, 23 Sep 2026 03:08:12 +0200 (CEST)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-39deda201bcso632805a91.2
 for <dev@dpdk.org>; Tue, 22 Sep 2026 18:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1790125692; x=1790730492; darn=dpdk.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=DZowHLCumLbnHpya44Y7DR0qolTAEir0Ole+8ZwfvPQ=;
 b=SKHFMoVufOmpgBtq/gklAqjeD006GEqtccvrCwZeBkV5LvVOGjRv0yn0UC715vuWBc
 dm0GsPRIzV/oDP5UpORmzHqAsaP/RhvoprARgBnw9SR1lz25wrRteN+ym6VT5dO0R192
 S3s1Uc6xh0luo6EVHdwWklrtr9uAspzWzj4RuOEm9Q1Ht+JW8EP5Zmc9Y43pyujy+PL6
 WFizZCrD/sXoxdPPVgNWTsFXct5zAOcvtz9gXqsrCgrbJJw7tmx7i1Ixo5FwTacNxA/V
 Xi52ZUFeu/O4XtYKlgjMuFQxyOOB2GLDDr/TRezla2WF92yTqdWHWbpP8BZyN8cvhv2M
 LZew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790125692; x=1790730492;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DZowHLCumLbnHpya44Y7DR0qolTAEir0Ole+8ZwfvPQ=;
 b=vFxtitSQ7O3a32/qGne9Bn79yzzRN/hYA7HxaUQ6uaIttnafEtJ5sKTzZxMWnDant1
 KpWKbwR5SvjeoTAtcijHH3trupN6VtQAx14NjStrmXGyxa9NjNF0sweoErIiwUT6meq5
 F+/NBtGllpietIs9smUZbMJXAcXBaRxO0RGjdyfEq55OOc4wZ/EyROkZ+pWRtdD9N56N
 NPA0SCRQfA6c8EfzaqrGHiCTMvRBhia7ThI35kJuOCXuZLE4mtWxXA+DjrZD3FitIJb2
 F2y09/AAmpjV4vGlwO0VGLq1jYfxbGt7d3UYp6Zfg4wiyvTZed+KCjJfxWY03hNqeRTK
 PGUA==
X-Gm-Message-State: AFuF++m3mxE14Ah31bsC8Ch5egGLKpMspp8s+8MG0cgy1EW0NNtCqio7
 U7D9JaUW+dr/SVJhxTVr0J/52pjXWTkZOv8w3MjrcYZoF/9NVc6ZSzaJksHJbKom6whk5KY320j
 NHkn/UXSdYl5qXg==
X-Received: from pgvc3.prod.google.com ([2002:a65:6183:0:b0:cc4:56ea:7ae7])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:50c3:b0:3a0:49c5:d3c3 with SMTP id
 98e67ed59e1d1-3a07e6bbc8emr992116a91.53.1790125691538; 
 Tue, 22 Sep 2026 18:08:11 -0700 (PDT)
Date: Tue, 22 Sep 2026 18:07:38 -0700
In-Reply-To: <20260923010742.2468145-1-joshwash@google.com>
Mime-Version: 1.0
References: <20260812223017.2980190-1-joshwash@google.com>
 <20260923010742.2468145-1-joshwash@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260923010742.2468145-16-joshwash@google.com>
Subject: [PATCH v3 15/16] app/test: use common division round up macro
From: Joshua Washington <joshwash@google.com>
To: Fan Zhang <fanzhang.oss@gmail.com>, Ashish Gupta <ashishg@marvell.com>
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
  - New patch converting DIV_CEIL in test_compressdev.c.
---
 app/test/test_compressdev.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/app/test/test_compressdev.c b/app/test/test_compressdev.c
index 293d1d757f..2891b98d56 100644
--- a/app/test/test_compressdev.c
+++ b/app/test/test_compressdev.c
@@ -18,8 +18,6 @@
 #include "test_compressdev_test_buffer.h"
 #include "test.h"
 
-#define DIV_CEIL(a, b)  ((a) / (b) + ((a) % (b) != 0))
-
 #define DEFAULT_WINDOW_SIZE 15
 #define DEFAULT_MEM_LEVEL 8
 #define MAX_DEQD_RETRIES 10
@@ -688,7 +686,7 @@ prepare_sgl_bufs(const char *test_buf, struct rte_mbuf *head_buf,
 		uint16_t seg_size)
 {
 	uint32_t remaining_data = total_data_size;
-	uint16_t num_remaining_segs = DIV_CEIL(remaining_data, seg_size);
+	uint16_t num_remaining_segs = RTE_DIV_ROUND_UP(remaining_data, seg_size);
 	struct rte_mempool *pool;
 	struct rte_mbuf *next_seg;
 	uint32_t data_size;
-- 
2.55.0.1082.g2b9226bbc0-goog

