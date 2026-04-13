Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E1D2F34C78
	for <dpdk-dev@archiver.kernel.org>; Mon, 13 Apr 2026 17:19:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 804144067E;
	Mon, 13 Apr 2026 19:18:50 +0200 (CEST)
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
 by mails.dpdk.org (Postfix) with ESMTP id 6DAEA4066B
 for <dev@dpdk.org>; Mon, 13 Apr 2026 19:18:48 +0200 (CEST)
Received: by mail-dl1-f46.google.com with SMTP id
 a92af1059eb24-12c20010f10so11843471c88.0
 for <dev@dpdk.org>; Mon, 13 Apr 2026 10:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1776100727;
 x=1776705527; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oizSaBbIdkYoUiF2qujPD9pKZrOQbICtvipg04VAO9M=;
 b=KXdbJKR1VFtmOm7eoC0cgE3sgrsKhl8g9gX5RwOGcQKEo0ZmHXRYOfmTssW/Ce2iIC
 cCQF/NENw/Evv+c24VM60mNHDi61psfbHGlDYzTZLqK3AmXj1e8MYVMsSkTX3doFa+Gm
 rFl+i4BwPLwM2kyBS3v5JHrEuQHN0aZnw+ex2IV3QGCyWlyrk2c5hBRhybUTjbAAatru
 0MPnomxW2UapP2Qgr0GNOuiQ7tCXyGmEejbkiqLxHR3nFP0VOqwex1WNkZZq0s1GZpkG
 7f7r6XBUxkol8xsEJ82uEAC/8GQSDY63F/C6o9Qc+Qaos9p8tOnSwJjCOSBJc4OsHt88
 Y6eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776100727; x=1776705527;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=oizSaBbIdkYoUiF2qujPD9pKZrOQbICtvipg04VAO9M=;
 b=DvIDwprm8+/Si+YC1lEDizBgdWYv79MhiV15kLQZp/4howqpT9/TkS8IjLB0NvEN9w
 8dQqdo9Jq2wj2c26T5LaV+qFt36XXh7RgarxgoL9tdLBqztIM3VAwJD53ZKuN1CL4DyY
 oNY71inqHLKDYflDZcytvH58ze7GUuiVidSfvruMgnklkUg71jIkHeT7zXa2+eTfVPVT
 G/b9TLaTfbBasaHiPbkzi7SYkbi9FPINaFJNNj12z7307LTwtaqZSiphUAela/8oRZ2X
 t9baPPD2/+RqMfWXNLFi6+iQZaMXLedjRWS7NiOR4A2P0ohUMJVEJAPCrS48jxA7lFx7
 eYdA==
X-Gm-Message-State: AOJu0Yyvzee70hCCSvmg22kH4SAB/0fCcKFxv0eAk1DkUrTqdeca85Sh
 fqucQp4XWLaM0dzS3T1P7MvG3nI/qz0fPTlHvLyO5XudBv+WOECd63q6KqzSH+7UOpNMJ8uYM6V
 iU/C0
X-Gm-Gg: AeBDievyZG+1u32B11VimsBUWL3JtZv0ED68XTw/ty9EhHSk9gbyxtU1p/l0aR+lk48
 Z0N2Nr4odj7a4r/ZbW0vSL9U1rjsfeQ9cdwPphfp+O/VgHRnWXECVDK/PXkoqINhfGDR5L5YXGW
 XsO3xiCmiO0vRhm7OmdVc0yMrpvWDy7wdAAX5IVQvMLdlqohYmjngESsogv5fqjgQmmEQZeygs3
 RkqkpH3Ym4jgbZIX1EQEpFnrxd7QE+YMWl54C1G4KEbT70dmhvCqKDZN99d1pMqIw+xc3yo6Gen
 brgMz0z7/sEAWbBr4ssr2C2LBZsCu4fyBdnvj3oGxq616hUK1SPv1ey2RJZooXOXhVTmpNqw3qh
 iPA0s7JceLhJ8MWTiA4fko8SWhTwc1TDSHU+z3GR4hRxB+8MhgJSAeyBEtDgGAccIOIlapqz5Rt
 bnHqdqMqnAlFItKW4aXBWnZLOmiyMLl2XgDpxtOeafjG8=
X-Received: by 2002:a05:7300:5721:b0:2d9:6373:ace9 with SMTP id
 5a478bee46e88-2d96373b21bmr2694274eec.8.1776100727299; 
 Mon, 13 Apr 2026 10:18:47 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2d55f5c69d5sm20258602eec.3.2026.04.13.10.18.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Apr 2026 10:18:46 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Xiaoyun Wang <cloud.wangxiaoyun@huawei.com>,
 Ziyang Xuan <xuanziyang2@huawei.com>
Subject: [PATCH 6/6] net/hinic: fix mutexes for multi-process
Date: Mon, 13 Apr 2026 10:14:50 -0700
Message-ID: <20260413171836.123467-7-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413171836.123467-1-stephen@networkplumber.org>
References: <20260413171836.123467-1-stephen@networkplumber.org>
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

The hinic driver supports secondary processes, as shown by the
explicit check in hinic_dev_init(). Multiple mutexes are located
in structures allocated in shared memory (dev_private and
rte_zmalloc'd structures) that are accessible by both primary
and secondary processes.

However, the mutexes are initialized without PTHREAD_PROCESS_SHARED
attribute, which means synchronization between processes is
undefined behavior.

POSIX mutexes are by default private to the process creating them.
When a mutex protects data structures in shared memory that are
accessed by multiple processes, pthread_mutexattr_setpshared() must
be called with PTHREAD_PROCESS_SHARED.

Fix the hinic_mutex_init() wrapper function to set the
PTHREAD_PROCESS_SHARED attribute on all mutexes.

Note: all callers to hinic_mutex_init() pass NULL as
second argument, so it could be simplified but that would
entail more changes to base vendor code.

Bugzilla ID: 662
Fixes: ae865766b334 ("net/hinic: replace spinlock with mutex")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/hinic/base/hinic_compat.h | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/net/hinic/base/hinic_compat.h b/drivers/net/hinic/base/hinic_compat.h
index d3994c50e9..18148a119e 100644
--- a/drivers/net/hinic/base/hinic_compat.h
+++ b/drivers/net/hinic/base/hinic_compat.h
@@ -197,10 +197,21 @@ static inline u16 ilog2(u32 n)
 	return res;
 }
 
+/*
+ * Initialize mutex for process-shared access.
+ * Structures may be in shared memory accessible by multiple processes,
+ * so mutexes must use PTHREAD_PROCESS_SHARED.
+ */
 static inline int hinic_mutex_init(pthread_mutex_t *pthreadmutex,
 					const pthread_mutexattr_t *mattr)
 {
-	return pthread_mutex_init(pthreadmutex, mattr);
+	pthread_mutexattr_t attr;
+
+	pthread_mutexattr_init(&attr);
+	pthread_mutexattr_setpshared(&attr, PTHREAD_PROCESS_SHARED);
+	pthread_mutex_init(pthreadmutex, mattr ? mattr : &attr);
+	pthread_mutexattr_destroy(&attr);
+	return 0;
 }
 
 static inline int hinic_mutex_destroy(pthread_mutex_t *pthreadmutex)
-- 
2.53.0

