Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23462C98302
	for <dpdk-dev@archiver.kernel.org>; Wed, 23 Sep 2026 01:08:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EE0D442ED5;
	Wed, 23 Sep 2026 03:08:02 +0200 (CEST)
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mails.dpdk.org (Postfix) with ESMTP id 4385C42EAE
 for <dev@dpdk.org>; Wed, 23 Sep 2026 03:07:59 +0200 (CEST)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-cc52c1b829fso637519a12.0
 for <dev@dpdk.org>; Tue, 22 Sep 2026 18:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1790125678; x=1790730478; darn=dpdk.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=yKFEssW3ILx0ilte9mzG3mKxpZVReM8P6oRYR/C8I4A=;
 b=ivSPHVaXMX0nCnTLcFBcgQicDYwNQnKmb2ZLxP0okrDKTfMLTAG69HjVmHGyVlEftl
 9aRZZXCqHSg19zJbarYEyo8Tyd+S8KvqV8WBKeo3dMniWuHnq5gi1A9H3QZiq44ANybB
 aIMVbohYOREFpVWcCaitDVisbasyRfh+1GUi2h9KCtcM+QL4/USQDx15hOFLDzqoDqfY
 PGZ22a7Zg1XeQB7kt5rw+T4aptytUj1Rwt05mQqo3NkmtL3ub6qk6KBD6yoGAyqFHgvu
 TfKv9RtRCad2sBcZ8aeZ8nVLssNZ0tUg6rXztcsDFdMBGJi5aRgCXsmZtp2z+FTAGzY0
 kieQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790125678; x=1790730478;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=yKFEssW3ILx0ilte9mzG3mKxpZVReM8P6oRYR/C8I4A=;
 b=QbS0L0mvOKsyblqtZojWM7T+0bERjOzxF7ezJzaMYul1LwlJkgmci/zlt2fIjay/pP
 iydzDFf3YUEsxfrKpQbMUVMZIrsahgXj8mPwXFP7k9318gxYG7o7brwvzQE3wi0+vigB
 9g8Wj3oUUOOpVSYaRm6W6ObMW1Bjx7GtJswhrG6cWiUaeZNXF9kPRK+Dr6Y4HZmVlaui
 lQOWJkP1y7rcu6QlaIk6i72ZXJAyyTd3W+Vhpe2S/3Q2dl+JV++iDEzxyPG+YzKkVs1M
 JlT91hJu1ksaT04MhcZfUwx8Lj1yCEEYuuJjaNGjxbVtFQzktMyULBHgFd2E43jLZOpb
 nO3Q==
X-Gm-Message-State: AFuF++lD4HlGmHgRk9Y0fitlQ7NYm9VyJfVJviLL6duttJVvbtqrubMU
 gNwG9hrZA3FhUxlwzBNxfnj/KmpHybV/nDvSq8Et3jqe3irD0ZLSXQRxyV0MO3MgI8YWj0JooTr
 CaVq1++gfGVujYw==
X-Received: from pgbbj12.prod.google.com ([2002:a05:6a02:18c:b0:cc1:5705:ff3b])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:4ccc:b0:3cc:f0c7:5999 with SMTP id
 adf61e73a8af0-3ddf7e62b15mr1066577637.16.1790125677941; 
 Tue, 22 Sep 2026 18:07:57 -0700 (PDT)
Date: Tue, 22 Sep 2026 18:07:31 -0700
In-Reply-To: <20260923010742.2468145-1-joshwash@google.com>
Mime-Version: 1.0
References: <20260812223017.2980190-1-joshwash@google.com>
 <20260923010742.2468145-1-joshwash@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260923010742.2468145-9-joshwash@google.com>
Subject: [PATCH v3 08/16] net/hinic: use common division round up macro
From: Joshua Washington <joshwash@google.com>
To: Xiaoyun Wang <cloud.wangxiaoyun@huawei.com>
Cc: dev@dpdk.org, Joshua Washington <joshwash@google.com>, 
 Stephen Hemminger <stephen@networkplumber.org>
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

The RTE_DIV_ROUND_UP in rte_common.h makes DIV_ROUND_UP redundant.

Signed-off-by: Joshua Washington <joshwash@google.com>
Reviewed-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/hinic/base/hinic_compat.h | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/net/hinic/base/hinic_compat.h b/drivers/net/hinic/base/hinic_compat.h
index 707a3b92b9..f4398a7847 100644
--- a/drivers/net/hinic/base/hinic_compat.h
+++ b/drivers/net/hinic/base/hinic_compat.h
@@ -70,11 +70,8 @@ typedef uint64_t  dma_addr_t;
 #define upper_32_bits(n) ((u32)(((n) >> 16) >> 16))
 #define lower_32_bits(n) ((u32)(n))
 
-/* Returns X / Y, rounding up.  X must be nonnegative to round correctly. */
-#define DIV_ROUND_UP(X, Y) (((X) + ((Y) - 1)) / (Y))
-
 /* Returns X rounded up to the nearest multiple of Y. */
-#define ROUND_UP(X, Y) (DIV_ROUND_UP(X, Y) * (Y))
+#define ROUND_UP(X, Y) (RTE_DIV_ROUND_UP(X, Y) * (Y))
 
 #undef  ALIGN
 #define ALIGN(x, a)  RTE_ALIGN(x, a)
-- 
2.55.0.1082.g2b9226bbc0-goog

