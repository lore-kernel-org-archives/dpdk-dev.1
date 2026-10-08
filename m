Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5D73CA6015
	for <dpdk-dev@archiver.kernel.org>; Thu,  8 Oct 2026 23:37:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 25AFA40A71;
	Fri,  9 Oct 2026 01:37:06 +0200 (CEST)
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com
 [209.85.210.170])
 by mails.dpdk.org (Postfix) with ESMTP id 96DD340684
 for <dev@dpdk.org>; Fri,  9 Oct 2026 01:37:03 +0200 (CEST)
Received: by mail-pf1-f170.google.com with SMTP id
 d2e1a72fcca58-85377c8bc96so2188400b3a.3
 for <dev@dpdk.org>; Thu, 08 Oct 2026 16:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1791502623;
 x=1792107423; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PlbUc/KgikpAYq8SFyNqRBXK/TQJsEnXfE5C3nniQ2s=;
 b=0tE13ckmwHna4H09WY1KmcS1Bf8sDPMGNcOvXsNd8HcpzcMVu0ZQTskuVTom5zF+i1
 3pJHmMapgwy6F/TVJzCR7tKUhAoKSna0fndDlUZwsu+qUIdh6Y/Z9Edc0+e0oBGfWFFS
 zz6IoqnM3rw4zsFycMKwBvnYTBGplcvS2R7YWtcR5XKgRz860ChbcmjBY05NJMit3uHi
 cDgh7lZiNjTSzDjVrAlYBYpZol1PhU9By7Gmb8s+G6lIagMmnAnm+ryC8B5YII5KJPXB
 towKRMcWTVtban+GLcv+2zqA3ucXuDrvVZsNKN/yJ4B35W6lQQv8vFulKo9bt9npbh3p
 MjYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791502623; x=1792107423;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=PlbUc/KgikpAYq8SFyNqRBXK/TQJsEnXfE5C3nniQ2s=;
 b=WUbok0aBQh5uW/QP/jnDWVY0MIbvQfl1EoDeOV/Q/VJzj5VX8xNxXEL8OYVSkxdilg
 /kte3qlFne98loMZJomEvqEhaaJEFoWTUUVpCSPAnb5o83MxSjiYqsg19dzP/vGrsr1C
 tA43TgYUW6qDen9+2d8WaxjCc/C3ClGj3xcDATOeoS7kh7laNQEf1XI5MqPx8WpgjUAk
 ti6tUgFR6LicW42tibQdZfY6AtvDAtXmMWg4TZXvuskxHVarokywwSdEDRkloeCJJ2XS
 haMIhUj9gaoNfEjfbdnHxmFWDPQUvlJ0MEjdYmjuzj6U4gqQ6LRSLvqJuXfBpCtXL4WJ
 UmeA==
X-Gm-Message-State: AFuF++k+KYF+Qv2U3tKjqxOWAKT70EwU+PBH+YO/122d5Bmwdpb61Hvw
 vmADlu4z+zmpp38GbAoo+LthZMcAf8b+Cyu6ef/3lKJqH44w5q0fF8bwTp8vkwKeru/oLnQIJrN
 sXhCwVDc=
X-Gm-Gg: AYBFou2N1tzrsYLFlOX6i50ZVBfQE2gvwiwKHZyjwrvMHJGpeRdmQfxm7dQ42BScSHK
 SKvHqn5bGwAX1IaELTguwgrKu2EodU9hPFctwncaG48C1pID27K7JHpwWNSkZhAP61hkC1NtrtQ
 O4lG7QVBw26JSyP39im3A5yqXJ3A15sKJ9+1rcEdgNw7nN2jyiWTNto3YwnCl1fB9IZOKdIz3yb
 JoItHPUpj6YqlqOanCEeXVIhFkwknMLs7/XspTi22Gy/nSwEF9Bjw1I5apoPqB4yT2doHbRbKCw
 5BJHm8mw4nzmg9VpOhZQu+7A0qvmIiqAxtv3s6iZRKQSnL5tA6mYkOW6tPLJFzR3QP6K2zMaedM
 G1Vl3rI4JfDqeuZNQMXueUlv4ejVvsYZqD9nMCrFSLt2PZZxYjpkN/YOrSoqpft6q36jMjIQ1j6
 Cidxo4PzVgLr8hidLIS5B4rTT3pOND+VhA28afBjZx8cG1sm9ihfwxd7YHtqW2p5NFvTcdNMuhm
 kxa+TqZSUajTRKUIxYGHpVxIqEt61oOU21faa855CXbePwK
X-Received: by 2002:a05:6a00:3310:b0:890:ac21:efe9 with SMTP id
 d2e1a72fcca58-897c7ec62bemr42032b3a.57.1791502622725; 
 Thu, 08 Oct 2026 16:37:02 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-896c42b06e9sm187909b3a.42.2026.10.08.16.37.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2026 16:37:02 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Jerin Jacob <jerinj@marvell.com>, Maciej Czekaj <mczekaj@marvell.com>
Subject: [PATCH v3 10/29] net/thunderx: replace deprecated SMP barriers
Date: Thu,  8 Oct 2026 16:35:03 -0700
Message-ID: <20261008233649.1260843-11-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261008233649.1260843-1-stephen@networkplumber.org>
References: <20260729175715.165120-1-stephen@networkplumber.org>
 <20261008233649.1260843-1-stephen@networkplumber.org>
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

Redefine the nicvf barrier wrappers as C11 fences and add an IO
variant. The RBDR refill barrier orders descriptor writes in DMA
memory against the doorbell register write, which is device
ordering: use the IO barrier there. The mailbox flag barriers are
genuine inter thread ordering and become release/acquire fences.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/thunderx/base/nicvf_hw.c   | 3 ++-
 drivers/net/thunderx/base/nicvf_plat.h | 5 +++--
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/thunderx/base/nicvf_hw.c b/drivers/net/thunderx/base/nicvf_hw.c
index 5b1abe2015..d1e31ffdaa 100644
--- a/drivers/net/thunderx/base/nicvf_hw.c
+++ b/drivers/net/thunderx/base/nicvf_hw.c
@@ -499,7 +499,8 @@ nicvf_qset_rbdr_precharge(void *dev, struct nicvf *nic,
 			break;
 		}
 	}
-	nicvf_smp_wmb();
+	/* Descriptors must be visible to the device before the doorbell */
+	nicvf_io_wmb();
 	nicvf_queue_reg_write(nic, NIC_QSET_RBDR_0_1_DOOR, ridx, count);
 	rbdr->tail = nicvf_queue_reg_read(nic,
 				NIC_QSET_RBDR_0_1_TAIL, ridx) >> 3;
diff --git a/drivers/net/thunderx/base/nicvf_plat.h b/drivers/net/thunderx/base/nicvf_plat.h
index 8421f57040..08ebb0cf62 100644
--- a/drivers/net/thunderx/base/nicvf_plat.h
+++ b/drivers/net/thunderx/base/nicvf_plat.h
@@ -25,8 +25,9 @@
 
 /* barrier */
 #include <rte_atomic.h>
-#define nicvf_smp_wmb() rte_smp_wmb()
-#define nicvf_smp_rmb() rte_smp_rmb()
+#define nicvf_smp_wmb() rte_atomic_thread_fence(rte_memory_order_release)
+#define nicvf_smp_rmb() rte_atomic_thread_fence(rte_memory_order_acquire)
+#define nicvf_io_wmb() rte_io_wmb()
 
 /* utils */
 #include <rte_common.h>
-- 
2.53.0

