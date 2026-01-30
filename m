Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C431BD73EB7
	for <dpdk-dev@archiver.kernel.org>; Fri, 30 Jan 2026 05:22:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D241C40649;
	Fri, 30 Jan 2026 06:21:56 +0100 (CET)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com
 [209.85.221.49]) by mails.dpdk.org (Postfix) with ESMTP id E7EE840150
 for <dev@dpdk.org>; Fri, 30 Jan 2026 06:21:54 +0100 (CET)
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-435903c4040so1148165f8f.3
 for <dev@dpdk.org>; Thu, 29 Jan 2026 21:21:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769750514;
 x=1770355314; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fVTc+BcxiiTtv/kBghSS0vQERGObVezK+FcOmGnCCKM=;
 b=pRoxsKkP+rgCIIYfQUpiHsLR5XQJ8DQIAdYQfzokJyhMUp6Dd2W/TmfyofqxYg7BLp
 kVb1w5s87V5Dbyjb3WCFkQ0UV5phECKK0gRY01ftbPotYS2QLrZSIHnU9lp+p25G2rX0
 b++spwXSef8hwbfD7lP4U6Afnydw2BE2oHYuhvFMYx2hvWtwrCVebgZvD1alOTGneSpT
 jJDkPXNeGcUJr/RsNvk7Zu3ZtxnVE9ccryMq0TS7YmBhNc3i0FWc1yOdphPKW7vpk8D8
 sdUnN/pmlcTbtpej5z2936ZyhBOwfz+Ifu5Ep4oL5J1STB0o1p6yAO0eBJ5Os0WL4+Gl
 zHyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769750514; x=1770355314;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fVTc+BcxiiTtv/kBghSS0vQERGObVezK+FcOmGnCCKM=;
 b=txAXjmXe5YyPDEQB6efbauqoaer6Am8U+GpIqbrJ9LpOlPuRiIVmH2aRjxipN8Wxcl
 H7dzG+ewDhi0mPqh0TLWb1UbgxoNat0dyIGell0B96b8R5tN0myVUVEm+fhhpc6BkdFu
 6JRoVnXnqMzoK0VMfiletkGhMZ6tfT1g/KUexr6/VKMKkvbp/wYm1qgjGzj9XjCqOagd
 1AqqzaWLqzQkEmM1/wXs8Y9J1nM8QrLe5JeckRbWR7ypvi5ycS/Uh2hCkllVXJq1/0V6
 5NowJKU319TJRWl4P0qmjXHpyqrczGkCEw1Pjten1BthCBCVRRzPYjvijUW0+BU4LiTS
 mdyw==
X-Gm-Message-State: AOJu0YxOq5jrDQ2gA83bJi26PlNHA7iMuvU//57Kj5IaIzOs1eLxv7g6
 COea+ReQifbt3B3t8DF2u3Sdbj7ZJ7n81txzx66n+oI8boYixFx+oKoUhDJ1y5saZU5lnPCMcYE
 XwKbd
X-Gm-Gg: AZuq6aJ1PQhuQxi0+24AVRBsgCV+jnZOWc2vE9x9mIQo5tJB1eJeYQLYBsVXGwar8DT
 mTxkNUJu8SMy8uhvk7tmvmd2ALLHTiZo18LmIbNmKSIfCR0eNhv2urQbAtbb0aWu0L3gWwCqKXs
 k6Fm0wz7sJdsDaNcxyjgE0bWrWSpuww+/x2QWd7Mm9KSEw7safKXLOzdYQ3sJH5KTxnKZugXeQZ
 oecaVO8L5/+avff1mgIIMtKepAD+bwsK+aYGxy4PQdoW7JrclT65swyv8uwnZ30noI9Qmi4rowl
 2ZNbZfNEyrMXzj8V0kp26S2GN8cl9ZqVkMupl0EDcGwC4Gjh3PrqfeOMlDx4S0PQmmh9QiiU6L4
 ZFXxzbHmTnwCjCH1iz/hpqrrtzu8OcMT+RGl01Ur0iPBcaLs06DQ0MeKkG3qJJlA7fTQwLtijTR
 w/4UZUzMeA37yKIrLf605xekQTG9XsvdJNKTUIOOFSHc9GWZq4UA==
X-Received: by 2002:a05:6000:2dc9:b0:435:9b3d:d969 with SMTP id
 ffacd0b85a97d-435f3a86766mr2290823f8f.21.1769750514551; 
 Thu, 29 Jan 2026 21:21:54 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e1323034sm19182107f8f.35.2026.01.29.21.21.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Jan 2026 21:21:54 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Igor Russkikh <irusskikh@marvell.com>,
 Pavel Belous <pavel.belous@aquantia.com>
Subject: [RFC 3/6] net/atlantic: fix mbox_mutex for multi-process
Date: Thu, 29 Jan 2026 21:17:34 -0800
Message-ID: <20260130052142.251649-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260130052142.251649-1-stephen@networkplumber.org>
References: <20260130052142.251649-1-stephen@networkplumber.org>
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
2.51.0

