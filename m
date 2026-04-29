Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD6C4FF8875
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Apr 2026 18:48:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6EEAD40B9B;
	Wed, 29 Apr 2026 20:47:58 +0200 (CEST)
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com
 [74.125.82.175]) by mails.dpdk.org (Postfix) with ESMTP id 0268D40A87
 for <dev@dpdk.org>; Wed, 29 Apr 2026 20:47:53 +0200 (CEST)
Received: by mail-dy1-f175.google.com with SMTP id
 5a478bee46e88-2dee127b3c5so251386eec.1
 for <dev@dpdk.org>; Wed, 29 Apr 2026 11:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1777488472;
 x=1778093272; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PZ0S6WxcvZuZ1HR/x0DOciftNNWmsyblUjJUk3CcMAs=;
 b=Gc/z+IXWNQNoqG2CVe4GaWl6e37FtswON82uKYHUwEgLpQOeI0ENn+5UoUaiweA/ao
 CuzU6Sg1NcRBqOaRUaGBZsRjII9oVVPsASXujjrT6LyyHdxwtB2pmEL6CndvAQtMUijj
 f7nDwNNxHOAXt2+x8XX6Y9b/0xTqCwV5FTlSmN2W+k8dR2dsbaZUTMfwTPN8o+piDhmd
 qhUZUs/NfaVks1YGJF7ozBUgE/MKMkwaYQVhZe5bg63LzAc+C8FTE9eTdP9IXHH3IIwD
 dnCFpaxfv6wscWRJb2gbUfncD+7ZC6kqvov1OFdTifKCS/pp4hDiZP25y9AUqziaia31
 Rx1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777488472; x=1778093272;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PZ0S6WxcvZuZ1HR/x0DOciftNNWmsyblUjJUk3CcMAs=;
 b=hEWEStTh4pJ9gs0gwzaFSbPwSAU6xjTzsd0ctk/lPyYFS8wuVLvvit39UNKz8B8Ntq
 NJ1w4yKvZHo9NwHNnfHMPKul8OsgRV9946GdfPMmcKxysvhYPQ+5+al5lRHikAGmkJUS
 rZZgtOC740h436gp7fspccA0tkly6KGauKnNpeGSMDjytQ9rNZbA3vbk9XT1fzGXljPb
 S2NG1YK7osmwzr6LWp6WihXVhoRHZaeUdmp8IhMZDqyxYvvCq04Su1dmXLIHMfVsdPso
 83MAmezicmuby4ateu6WXlSHZ4SxSarsZK0ECiwY2ktPOSmUFgrIrwT1Qg5S1YwA0xEf
 d3bg==
X-Gm-Message-State: AOJu0YwAKXNiSmuHlQs5aO7/w0dpFnE9reEnSwL5VuqRhHSQnRoX5htC
 bSCTQCjKT3DiK5cFpeQpn94/qieiCdHjKyjGpXQx8WClDZQCLn6sZe7sYgDsxxMbDcNDJLhQmLr
 LD+kO
X-Gm-Gg: AeBDievyjOPAdpCyYKsB9AfP+VZe9+EURDn8XeEFzllyuJVQ8TgYF32Yzhh4ehLctlO
 iKRRZ1CZ+nsVW7rdKmCaiC9GvSoaUX8TA8CIM/kdmfrXYBWno2XwpLk0JMPyQ4fmrNzCsuXqKiG
 9W44hx8F+yklHKJhd2u9zGlCVCa5dfcsuJDcJkoFyGDXctItkWx0TTmwEoWzwlBJyKpiU1/G9aX
 eTQ8cj2N2wumfug2A6fOzUvqDsD0j+3UxXoCNbdGrOZMS9MAznclRjRhDzQYTOQLPV5I32D8hRd
 oikTePzHabx06xPcHOvNeJtckMPxuG8VnhYB2Z1pb/uk60EWI3TETN21Jb+w6Dc8O5gQZ3nQqDP
 yWvXIMadSWArNMY2T1VvZ6Oq06hk2uKFtKHmegXQaryfFIUB1+dTlFQtSnIVYGa/GkMIoeEAlVK
 4qCQcesMCC5cvOs9+iXI0t43f7OkzXL+7+5E4U+bB07xM=
X-Received: by 2002:a05:693c:2c84:b0:2ed:e16:6b48 with SMTP id
 5a478bee46e88-2ed0e16e943mr3464075eec.30.1777488471816; 
 Wed, 29 Apr 2026 11:47:51 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2ed1c09ca30sm3271027eec.24.2026.04.29.11.47.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 11:47:51 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Xiaoyun Wang <cloud.wangxiaoyun@huawei.com>,
 Ziyang Xuan <xuanziyang2@huawei.com>
Subject: [PATCH v3 7/7] net/hinic: fix mutexes for multi-process
Date: Wed, 29 Apr 2026 11:46:44 -0700
Message-ID: <20260429184739.706250-8-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260429184739.706250-1-stephen@networkplumber.org>
References: <20260413171836.123467-1-stephen@networkplumber.org>
 <20260429184739.706250-1-stephen@networkplumber.org>
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

The hinic driver supports secondary processes. Mutexes in structures
allocated in shared memory must be initialized with
PTHREAD_PROCESS_SHARED. All callers of hinic_mutex_init() pass NULL
as the attribute argument, so route it through the EAL helper and
drop the unused parameter handling.

Bugzilla ID: 662
Fixes: ae865766b334 ("net/hinic: replace spinlock with mutex")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/hinic/base/hinic_compat.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/hinic/base/hinic_compat.h b/drivers/net/hinic/base/hinic_compat.h
index d3994c50e9..707a3b92b9 100644
--- a/drivers/net/hinic/base/hinic_compat.h
+++ b/drivers/net/hinic/base/hinic_compat.h
@@ -19,6 +19,7 @@
 #include <rte_spinlock.h>
 #include <rte_cycles.h>
 #include <rte_log.h>
+#include <rte_thread.h>
 
 typedef uint8_t   u8;
 typedef int8_t    s8;
@@ -198,9 +199,10 @@ static inline u16 ilog2(u32 n)
 }
 
 static inline int hinic_mutex_init(pthread_mutex_t *pthreadmutex,
-					const pthread_mutexattr_t *mattr)
+					__rte_unused const pthread_mutexattr_t *mattr)
 {
-	return pthread_mutex_init(pthreadmutex, mattr);
+	rte_thread_mutex_init_shared(pthreadmutex);
+	return 0;
 }
 
 static inline int hinic_mutex_destroy(pthread_mutex_t *pthreadmutex)
-- 
2.53.0

