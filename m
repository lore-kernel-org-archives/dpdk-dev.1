Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51B5CF9D0D5
	for <dpdk-dev@archiver.kernel.org>; Tue, 14 Apr 2026 14:43:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7EAB84067B;
	Tue, 14 Apr 2026 16:43:00 +0200 (CEST)
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
 by mails.dpdk.org (Postfix) with ESMTP id 5725940661
 for <dev@dpdk.org>; Tue, 14 Apr 2026 16:42:57 +0200 (CEST)
Received: by mail-dl1-f41.google.com with SMTP id
 a92af1059eb24-12c555f886dso847551c88.0
 for <dev@dpdk.org>; Tue, 14 Apr 2026 07:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1776177776;
 x=1776782576; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oizSaBbIdkYoUiF2qujPD9pKZrOQbICtvipg04VAO9M=;
 b=TSjmVhinoREa280gW2DX9tIgUIlHF6pIXYXF/romJqTQsE9t6kYGBzhtie83FUWBjP
 QxFq9ufyNvvayIuifa4bAxlRO3Xi4fx+QFw20kwH8cfp4CtiLuBlKDzUVT3SZaAUaRQm
 UQ3wobgBk7/p05WClVs+X66L4F2fq1puZrnI3Una38acWnSvJQffnkvJql4Eh99LWLH4
 S24TkKlwe2zZrAXz4DwI25SFDMACB9Ugdg4bqYwmQG8ou92VbMzp5kEzLaFllAn/TPzv
 dVzUH/EblVHr/LQpqxHyyBV5JK/WrQoUTHU0SENdmvNerYHjPSVYfTGl5jhr9CoHzt5N
 eppA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776177776; x=1776782576;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=oizSaBbIdkYoUiF2qujPD9pKZrOQbICtvipg04VAO9M=;
 b=V4HMquJRKt8oGyNPMTRhZzReZdnKqj3Fx/WgX4Gzwxh5qeIMnrC2yhybzHYhzIAP4E
 u77/zqhCn/hiD8Klw1193jGMBr1kG8sTlRHDMdnmIje0aA5WATDL0zDQAwHTcYq3gG7y
 awLgSWbpNcm/R//UMdblQ/roVaH5LgoNjHa2utyjfR4/a1+WwnUwABZypCRiwAClZvbB
 9DwCi6ECnTOjcd/WfgXJSLwvuRECJu+7Ww8qX4SKlBs1qrV+Ewx5MC0BvkJZMqa2N49R
 yVbq8FFMis2Tkb25EyFIo4Zqn2X0ko8EZnnuRXFK7Hudp36viGJKoDP7nQ6dFx3jSFPU
 H8Ug==
X-Gm-Message-State: AOJu0Yx8Dp1CZHU62IR3eiFGHOSp9sklHkohRKz22hTJbz1SBUZZEa0K
 9ujh0Q2QNDj7Yac3aWUZX2n/bJIpYL1FM6FL4k1l2bcnPtwYQGQTmOxI7hHfU4/6VOybQfMMeY0
 LTlX2
X-Gm-Gg: AeBDieskcMSXooQ98czV6AIw5a1ZZDhubNAFjD5+SDV1MuN0/kULNrw9S1/A92J77p8
 idIP2M8v4WH10fPHiRg9sjtuBn1vFt5VwA2W0KzukUN9+karjnA0/o0w3eAwZNfRfCKwq4bRgHT
 W/CoZgwM3MVjim9x7V33/mCCOHOtFX+mex3HOvXS0SrfgFKWPdJ6wImU1jECd4lgDzb1j/pn1/o
 5Sf2QJTBHkiKBbQcMhJkA/43BaRH9ww9GXkYNZguzUTF1oGCpS071AUkDz5/yIL7+uSNMPJ7Dgs
 unqFXhlBT1uVZXdN41MyEmr1ttGXWrzU7q6Pk37lnjGgZI4nPAJi25fORbMYFQDshkHIA4Kfc4G
 OxXHKp9NyOINxOuAxu2l1TpQxse6U0FmnQa6CJA6C/Vo0ZAXfye5gA5JfoGOoBUEPMi3hVPD5ge
 2UQlpxEZ9+BMBVM9k4QfIsiHCPJ8Qned9LxV6v5gliMpM=
X-Received: by 2002:a05:7300:7c04:b0:2d4:532e:7e45 with SMTP id
 5a478bee46e88-2d5898aaaf4mr10697539eec.23.1776177776328; 
 Tue, 14 Apr 2026 07:42:56 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2d55f5c69d5sm24985835eec.3.2026.04.14.07.42.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Apr 2026 07:42:55 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Xiaoyun Wang <cloud.wangxiaoyun@huawei.com>,
 Ziyang Xuan <xuanziyang2@huawei.com>
Subject: [PATCH v2 6/6] net/hinic: fix mutexes for multi-process
Date: Tue, 14 Apr 2026 07:39:58 -0700
Message-ID: <20260414144246.110681-7-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260414144246.110681-1-stephen@networkplumber.org>
References: <20260413171836.123467-1-stephen@networkplumber.org>
 <20260414144246.110681-1-stephen@networkplumber.org>
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

