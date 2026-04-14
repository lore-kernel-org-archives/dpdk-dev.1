Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAF95F9D0D5
	for <dpdk-dev@archiver.kernel.org>; Tue, 14 Apr 2026 14:43:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 428BB4066D;
	Tue, 14 Apr 2026 16:42:59 +0200 (CEST)
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com
 [74.125.82.175]) by mails.dpdk.org (Postfix) with ESMTP id 4F3554065F
 for <dev@dpdk.org>; Tue, 14 Apr 2026 16:42:56 +0200 (CEST)
Received: by mail-dy1-f175.google.com with SMTP id
 5a478bee46e88-2d868d014a5so2453959eec.1
 for <dev@dpdk.org>; Tue, 14 Apr 2026 07:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1776177775;
 x=1776782575; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+GDZjtbpl5/pgT7tFJ+n7Ub2Hg6o1OEmB9GyKJb8V3c=;
 b=GT88NU2qJH3MOqUKM9MkZHeCiLFSPgkDPtt0lEiEuigdrpjkujRwj0tOfbLhaFy8ln
 nUzinAfOYI/JGAqp9/q98PLKkr0HKvgjI+YFFp9ihcHjuYiCsnAtP/y2Mk+UjSh6FGAo
 cQhk1SbyoIn7i/hrgAgKQ8MJofUHljn89kTybnGJZsgovLva6VSSe+FmKygFfK/hCVlj
 gdz23HtlQRhROmr8qrgSE8T0pUVoFkMCZ+YImX3aLBRHt6UOleJW8l9I0WGt7bTtNwuo
 Tz1/6fRCLazmJz2y/ZM+X0Sy3kVcTaAueKery+V92LHHAjj1SSb6DsEQwURtbR/EvcHR
 1aRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776177775; x=1776782575;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+GDZjtbpl5/pgT7tFJ+n7Ub2Hg6o1OEmB9GyKJb8V3c=;
 b=A5WQBrgeeckkhbTddr08JvecE+0E4bt5nMhioLWv/ubA5BS7ugeifom0rDYkXE4mij
 OaD2k78Xp7xWr6r/eXkNmqHzctpC75ygVNGiQCS0wUR2UgHPsZoZYsEF7tHZwpnYcRKE
 4ntjuLKnzwEzluaMMlYukD7bJILivnRmKBi5kYFOjXoOgaGjHDG64WTzcIvgU1cmMffX
 ERbk+ZPjDN0OEbNTf+mXQ7Qv+UVq1/14bO/GlKUaCuJtlnpYBar412t0W+X0gUkp4gU2
 AjeYktzamJvvhS1HXAve1ZULhQgNngCIuZz1//IP0J0kmIH0RDgSYcpYSyli3WPT79FK
 35pQ==
X-Gm-Message-State: AOJu0YwPUnG4ocwK7AB2ZtzzFk6cHAEQmXtuKxtE3x744eOGtSKgTcKv
 GzY1C3oeXUnbBpLXu1SnQSqLwxgb/OH/RAoHsYi9cpcDt5peppCPESwz47JDTLTIBRpshv7EdUS
 s71Dd
X-Gm-Gg: AeBDiesMXj8fCZ0oiUtz30Yaq8CllZyR2yu2yvHDF1GQVfhNYlMCoFvW0t+Ldx7Pt0f
 AL5CeQ9H9MNDWNFbwmkvmJPeN71bUzYkWHq+gP/Q+kk92IhabdQQxTPG5x8sP58VlXxLWuGD/v/
 NejrVb9ve89bgcMwa/8zYJiIYtozKJroMf8Pam7fEF63h5e+prz0+KfnqeusWdqig5ZkeF0xujc
 u7gYUrrUk1AlyXqqGrfvI3Kb/jXLGMWpBv/o7a9MC9CQBYkUqFxOTsh3TCz7YTUBcARgiuTWmog
 u614AKPV/AESDnmpYPsO/cfMlJ5cFFO0FqadURJfsiAdoYv5F4Tl3trEZoPBq+P8gk0TT0ueAlB
 5blwIuU77Y9vE6KW57cfyKmRcOuhYgcBAIgaXLrJqAY+srGLYUqEu4lI4ejsgs14yaQlAv8pIcr
 /8pQmEPnzE1fEUPfPy8GN1UhuKW9hOIkxjNiFlSYmQbx8=
X-Received: by 2002:a05:7301:18a6:b0:2d9:a799:3c4f with SMTP id
 5a478bee46e88-2d9a79961f3mr2559387eec.24.1776177772902; 
 Tue, 14 Apr 2026 07:42:52 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2d55f5c69d5sm24985835eec.3.2026.04.14.07.42.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Apr 2026 07:42:52 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Igor Russkikh <irusskikh@marvell.com>,
 Pavel Belous <pavel.belous@aquantia.com>
Subject: [PATCH v2 3/6] net/atlantic: fix mbox_mutex for multi-process
Date: Tue, 14 Apr 2026 07:39:55 -0700
Message-ID: <20260414144246.110681-4-stephen@networkplumber.org>
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

