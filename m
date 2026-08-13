Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA684C5CFCF
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Aug 2026 17:23:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8823542DA1;
	Thu, 13 Aug 2026 19:23:05 +0200 (CEST)
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198])
 by mails.dpdk.org (Postfix) with ESMTP id 72E7E42E59
 for <dev@dpdk.org>; Thu, 13 Aug 2026 19:23:04 +0200 (CEST)
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-848d21bbb55so3240090b3a.0
 for <dev@dpdk.org>; Thu, 13 Aug 2026 10:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1786641783; x=1787246583; darn=dpdk.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=CMOUz31Hn33PQwTHUiY7j0gas0DABDuvkQpTec6IaV8=;
 b=B967WQET71TfiQ4azNj8MtFdUBuxZGgifimCu+gIZNVaL06bbpQ7pi96uAVXJxxFz6
 ssK67y/8EQ9pcBTbAf3+tcRUnOydX6C5e/jsLv+7oZaDLnru8hNFYnNGHqGboICPZr+2
 6OvwsTpALnCx0vw4PybBZXVrIjHCjhaUDRqYVVpjvvDGMJoiscR7qhNpd21P6+3ck6Mo
 imiCRoW7Y+shbxz24PvzbrAgtVa+Wl+LWt3fxFfnX8R7CkFKhSCzrlmnOytu3A0VvJU0
 NHc6J84+wbMImi+F7KxPZiH13/tyKtE2HasiKUbbBqlKyF3bWpqS6q6e1mjUPeBLYFJE
 mnDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786641783; x=1787246583;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=CMOUz31Hn33PQwTHUiY7j0gas0DABDuvkQpTec6IaV8=;
 b=O6vtpcbFbVVbX0F3kcx9vMXrwLHW1qvW8KAfcOsmb6j/ZazV7OoHr6DLtst11Qqd1d
 xzZNoRI6Nu2puJrM6D1q4VcuHc+8mSaiHmN80KIpnETECp1GWI3ekhficZEpY8SD5PbC
 uZ7WZo56IUTVILl/KBUs529kw+1Sd6PkCF0Et++XR6dbbgcqPeEulYGrz/C19O/Sv6Al
 YwUjUY2DrhNX8b/CwF46bv3i6T5hg6RtFcnvr8z864XVZL64CeeOjImG51sSeFmjlwJm
 5zBctmUUxA1Y2OY/HepHvf4cHdmP4qU5Fed1tOVg/sdh/CnYqJVux5Fq1h62M1SXS7iG
 vqLA==
X-Gm-Message-State: AOJu0YzlaKPcEVNEjukS5HCQahn4J+/8sFMK+3ns22fq1QgiEKRKLnJ4
 K0m3mjF3hIYpOn64LHChhhAIs2amVoyf2ohYHjhlnHSHGd8MLFvMdYP/uDaYObKneKsJ297JpUP
 wfCMtQOh33sZlNA==
X-Received: from pfbkm16.prod.google.com
 ([2002:a05:6a00:3c50:b0:84b:62e9:404d])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:7487:b0:84f:dc19:b77d with SMTP id
 d2e1a72fcca58-84fdc19b931mr38278b3a.12.1786641783440; 
 Thu, 13 Aug 2026 10:23:03 -0700 (PDT)
Date: Thu, 13 Aug 2026 10:22:33 -0700
In-Reply-To: <20260813172241.964736-1-joshwash@google.com>
Mime-Version: 1.0
References: <20260812223017.2980190-1-joshwash@google.com>
 <20260813172241.964736-1-joshwash@google.com>
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
Message-ID: <20260813172241.964736-9-joshwash@google.com>
Subject: [PATCH v2 08/14] net/hinic: use common division round up macro
From: Joshua Washington <joshwash@google.com>
To: Xiaoyun Wang <cloud.wangxiaoyun@huawei.com>
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

The RTE_DIV_ROUND_UP in rte_common.h makes DIV_ROUND_UP redundant.

Signed-off-by: Joshua Washington <joshwash@google.com>
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
2.55.0.691.gc56d675ccc-goog

