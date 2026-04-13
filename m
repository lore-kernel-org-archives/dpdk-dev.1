Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF0E8F34C74
	for <dpdk-dev@archiver.kernel.org>; Mon, 13 Apr 2026 17:19:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 76E674065C;
	Mon, 13 Apr 2026 19:18:45 +0200 (CEST)
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com
 [74.125.82.169]) by mails.dpdk.org (Postfix) with ESMTP id 1231940654
 for <dev@dpdk.org>; Mon, 13 Apr 2026 19:18:44 +0200 (CEST)
Received: by mail-dy1-f169.google.com with SMTP id
 5a478bee46e88-2b4520f6b32so4921418eec.0
 for <dev@dpdk.org>; Mon, 13 Apr 2026 10:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1776100723;
 x=1776705523; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+GDZjtbpl5/pgT7tFJ+n7Ub2Hg6o1OEmB9GyKJb8V3c=;
 b=s1MLfxcMEt+i2r27yZrVJIjukJuJ76KB5/Xu1GG1slynIhHd+vqWWA1WLjDbHSL9bi
 zxXDEllyklu9d0Ukb+szNSs6ELfsflYhYnQIKc4yE1OmI0WsrXSMVz8jJQJAMgYAaioM
 siLRYLGLvu3r9A9snry1832yf/9RO5FEgRSXSSpAlBxgacA+mlo9ynyUNxHyBCd+X6Gg
 iLf/Xnay82BvYNifRQtr+oOW/CbAfLQeMdkSRHcyjHI4NL7iKgkTq0gB9io9aNmcwn0a
 zgJqnxl48umOK3SxnUqj8PAxpSJJmjqlAj3044kL9WbuIWwfQaBMOZXxFcbRM6SzQZ6s
 S7Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776100723; x=1776705523;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+GDZjtbpl5/pgT7tFJ+n7Ub2Hg6o1OEmB9GyKJb8V3c=;
 b=UP+aCTcQDTQ98XLBochd56olGzyM0Vkc/mHZLosNmwvBMvV9KmAk4QFczkfRLc9aBk
 YQA+o0RWdC1C9gPvXGGb5TTAf2Nzf2VAR4NA0y2e3QxjSgnXV1X3YFACBrH8oKQmFu++
 Y4fIrPY/3E8Rhq9NyIosMsh7sHNiHLbzsL0lNXVa3MMn+APGufXrXfwXbNBO6kI7AefE
 v65jR0JtaXnM1JCl37lY7sgnO6cTcGvX+c4Iz0uVXMqNOdujywlXfl+2ka1LMsphJhH7
 VE0hbC1EspB3SHG86vyE71sGch1aIL7wqX2ZTO4r8WPfulIkIaCwVpuHL2kQMtw7Xt1t
 cxYg==
X-Gm-Message-State: AOJu0YyKSA+ghmPYUT8eXVE4AFt6+iFxR6aJjjYYmEdeNM37AhYzMhAk
 7zD7JIaatRjvlvbK45b8OY0HJFBlzcTTy6O0v1kvSm5xevYvfs59nyKjdCLHt21IqX4Yj7PGr/i
 EUz3H
X-Gm-Gg: AeBDieuRXUOXuOE3zAbFS+SiWmrHLEouIaV9Y91HsOADw8BBbdx3pAwBvGuNHcnUzrC
 UdB+agtd1exN+Cn29mULf4URXF0SoJr1DVB9Xt7TQGCHWGt2ePQlkIpJNKR6EP5xuoOVtHlKYpa
 IKcoJfB/dW9h+sN3cP8arApFHqF4M4OEoYDzP3+m/S6qE0CXptzQ46GLmokOKyFyxFm90dCz3jZ
 jxwdp3Gz/+06SWZ4DKz1etH3pS21H1/Wv0qrrSaWWc4fk/BDDLjsqngqZTHLBsJTSRoad0RBSym
 mJ/r76rTGbSfPqgJpdPwv0QNkMGVWfn0ltbUxrmrPrMm+Y13GCr8/8DGukPOUd7DW8dLW+dxAFl
 JiQm+G2RpZ2Bh/2Qe3exkBKQW8QZHeWsrni3voj19pTuetUjs78ZNc3/T6/fRyPXUqU0XT9LpBB
 sldSnhD3ImWj25q5An3bKfTmsa4YQDn0UgWdXSqd0/cks=
X-Received: by 2002:a05:7300:3247:b0:2c9:ee15:a0f1 with SMTP id
 5a478bee46e88-2d5898aadc1mr6924513eec.27.1776100723069; 
 Mon, 13 Apr 2026 10:18:43 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2d55f5c69d5sm20258602eec.3.2026.04.13.10.18.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Apr 2026 10:18:42 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Igor Russkikh <irusskikh@marvell.com>,
 Pavel Belous <pavel.belous@aquantia.com>
Subject: [PATCH 3/6] net/atlantic: fix mbox_mutex for multi-process
Date: Mon, 13 Apr 2026 10:14:47 -0700
Message-ID: <20260413171836.123467-4-stephen@networkplumber.org>
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

The Atlantic driver supports secondary processes, as shown by the
explicit check in eth_atl_dev_init(). The mbox_mutex in aq_hw_s
is located in dev_private which is in shared memory accessible
by both primary and secondary processes.

However, the mutex is initialized without PTHREAD_PROCESS_SHARED
attribute, which means synchronization between processes is
undefined behavior.

POSIX mutexes are by default private to the process creating them.
When a mutex protects data structures in shared memory that are
accessed by multiple processes, pthread_mutexattr_setpshared() must
be called with PTHREAD_PROCESS_SHARED.

Bugzilla ID: 662
Fixes: e9924638f5c9 ("net/atlantic: add FW mailbox guard mutex")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/atlantic/atl_ethdev.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/net/atlantic/atl_ethdev.c b/drivers/net/atlantic/atl_ethdev.c
index 2925dc2478..7282f9b691 100644
--- a/drivers/net/atlantic/atl_ethdev.c
+++ b/drivers/net/atlantic/atl_ethdev.c
@@ -3,6 +3,7 @@
  */
 
 #include <rte_string_fns.h>
+#include <pthread.h>
 #include <ethdev_pci.h>
 #include <rte_alarm.h>
 
@@ -355,6 +356,17 @@ atl_disable_intr(struct aq_hw_s *hw)
 	hw_atl_itr_irq_msk_clearlsw_set(hw, 0xffffffff);
 }
 
+static void
+atl_init_mutex(pthread_mutex_t *mutex)
+{
+	pthread_mutexattr_t attr;
+
+	pthread_mutexattr_init(&attr);
+	pthread_mutexattr_setpshared(&attr, PTHREAD_PROCESS_SHARED);
+	pthread_mutex_init(mutex, &attr);
+	pthread_mutexattr_destroy(&attr);
+}
+
 static int
 eth_atl_dev_init(struct rte_eth_dev *eth_dev)
 {
@@ -405,7 +417,7 @@ eth_atl_dev_init(struct rte_eth_dev *eth_dev)
 
 	hw->aq_nic_cfg = &adapter->hw_cfg;
 
-	pthread_mutex_init(&hw->mbox_mutex, NULL);
+	atl_init_mutex(&hw->mbox_mutex);
 
 	/* disable interrupt */
 	atl_disable_intr(hw);
-- 
2.53.0

