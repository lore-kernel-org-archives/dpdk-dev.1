Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAC20C98302
	for <dpdk-dev@archiver.kernel.org>; Wed, 23 Sep 2026 01:08:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DD6A140DD2;
	Wed, 23 Sep 2026 03:08:09 +0200 (CEST)
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mails.dpdk.org (Postfix) with ESMTP id 1940942EEA
 for <dev@dpdk.org>; Wed, 23 Sep 2026 03:08:07 +0200 (CEST)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2d94a158dc8so5607155ad.2
 for <dev@dpdk.org>; Tue, 22 Sep 2026 18:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1790125686; x=1790730486; darn=dpdk.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=GbxFcjuVXyxv8ehnGpbngzci2YtFAF107o+CPp4xy50=;
 b=hVRHpHyutDuslqIVh2O5ZpEYOlW0vyJGrTFoeyKPgy/rFp98FsEu6BkZMc4DAJyKKG
 1wbL5pePWMeGoMiQkPVW22g1NVv7o56TOs6/LJXZslScg57MrDIob2SxRenite/B8uvx
 NBEuwRa9UflWgyQEf1rm+kxesy1jNSbJvx0HDHtd+FKZcYXyHHwioWOjMFc1K9S6BHob
 RqWlw9Pzr0C7huVY2pXkr+K5Za76L8sObLt5L/NKUCJpWHlM5tmloRRV7LvIJM+TcviZ
 sL6hrVJiSxGnUqx/eN+ZzismVDjAmj9jkOmOrC/a/lZro0luyDLv4oF4OQa5IAZiDKKo
 OSjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790125686; x=1790730486;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GbxFcjuVXyxv8ehnGpbngzci2YtFAF107o+CPp4xy50=;
 b=1G+IR8Jz6fzGvESS6cr04MtCwxc/jd/Df/2+vIRzWq2WTZf6tZeB4mdoaTfnL/enSK
 770l69m109EBg8aYcT9JkcdDs5hKtQaIX2c1CPAr6d50CKc+4UnN6jfY8CpFb8g4KxrV
 +DP0b/Jlveh1E+3W1jo7Diw0Hpd8fzZs92K03SwAav3NezOpSm0aE/hEex51k+fN4SN+
 rzuf+/kpAWE/bGAW9QC/LZqXG5Q9z9UwhzUKvVxc7hJvE5VpMtRdLZ/ZLmQFGKV5kCz7
 SGtkuw7FuSlUg1zbOTXaK2QSLP+ie76q5HhrhyD4dy8Po4i8rk98zGw7FCuwqSbfWuHe
 vC+A==
X-Gm-Message-State: AFuF++kQI8OFd4MzeZouslh2moD/V+UBMKKfRbJgOsFGIeyl38VfRjXb
 uhq8qxQdt8HkTjBCo5dRqZMGY+14/BTwx9vTafw7e+P0DVT/2sbjjjdV7jlrx7BbW1znTAC8FwW
 2lyeycyaofOPFRQ==
X-Received: from plbd13.prod.google.com ([2002:a17:902:f14d:b0:2df:3a10:ea7f])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:2446:b0:2dd:ad74:ac7d with SMTP id
 d9443c01a7336-2df69d5a9d7mr9958345ad.24.1790125685754; 
 Tue, 22 Sep 2026 18:08:05 -0700 (PDT)
Date: Tue, 22 Sep 2026 18:07:35 -0700
In-Reply-To: <20260923010742.2468145-1-joshwash@google.com>
Mime-Version: 1.0
References: <20260812223017.2980190-1-joshwash@google.com>
 <20260923010742.2468145-1-joshwash@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260923010742.2468145-13-joshwash@google.com>
Subject: [PATCH v3 12/16] raw/ifpga/base: use common division round up macro
From: Joshua Washington <joshwash@google.com>
To: Rosen Xu <rosen.xu@altera.com>
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
 drivers/raw/ifpga/base/opae_osdep.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/raw/ifpga/base/opae_osdep.h b/drivers/raw/ifpga/base/opae_osdep.h
index e35a21c80e..b0045a36a0 100644
--- a/drivers/raw/ifpga/base/opae_osdep.h
+++ b/drivers/raw/ifpga/base/opae_osdep.h
@@ -71,10 +71,9 @@ struct uuid {
 } while (0)
 #endif
 
-#define DIV_ROUND_UP(n, d) (((n) + (d) - 1) / (d))
 #define udelay(x) opae_udelay(x)
 #define msleep(x) opae_udelay(1000 * (x))
-#define usleep_range(min, max) msleep(DIV_ROUND_UP(min, 1000))
+#define usleep_range(min, max) msleep(RTE_DIV_ROUND_UP(min, 1000))
 
 #define time_after(a, b)	((long)((b) - (a)) < 0)
 #define time_before(a, b)	time_after(b, a)
-- 
2.55.0.1082.g2b9226bbc0-goog

