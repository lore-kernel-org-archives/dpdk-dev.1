Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AF8AF34C78
	for <dpdk-dev@archiver.kernel.org>; Mon, 13 Apr 2026 17:18:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 446AF40650;
	Mon, 13 Apr 2026 19:18:43 +0200 (CEST)
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com
 [74.125.82.176]) by mails.dpdk.org (Postfix) with ESMTP id A4BDE402CC
 for <dev@dpdk.org>; Mon, 13 Apr 2026 19:18:41 +0200 (CEST)
Received: by mail-dy1-f176.google.com with SMTP id
 5a478bee46e88-2d9916deb14so1638377eec.0
 for <dev@dpdk.org>; Mon, 13 Apr 2026 10:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1776100721;
 x=1776705521; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SLfVMIT+bRQ0oqKQbXeqdNgH221DDN/p7PpW92KAQiw=;
 b=URUrXJ308ugdVxeHaBDSOx57tJ9JYRHCK/e5hwhXNnL0VfRFOnTwDAglcAaoneFgnG
 uMfjt8r85sW1OEDtJcKfRiBTYdAV4TYu5Jgc58IyV2YEhhOFryaFlYFklHAsVY+Gb6tq
 Hrv4MwJfiavUKgMaj4500B9dwW1GblIQCg3rCQcMt+TsKoJsuDa2JnsWLitaaTHLxune
 xtpVMFUHfg9P3GgZvRvNG3TzeS3U0AAwoJuGQX+wTkVGFMiVPx0Hr899h+FmruvqMAeK
 LO75ZmIoT7S150CR2lWoOtuWg6ILLE5JVCAmjLd3beFIwJ9ag8t4PFYWxQ6dhjNtg67y
 PMmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776100721; x=1776705521;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SLfVMIT+bRQ0oqKQbXeqdNgH221DDN/p7PpW92KAQiw=;
 b=ZylXB32C8jl/xH3ph8H4Gbcldpzv6WMt5AQ/rD+F20YKjAkOpeeYMsgr/cIDUjQkkK
 JFd9/YbPIGexmP+kARiAkkPwBVXpPfouNmKqFk2DzWW+R4EH03qQq3ZFh07P6Wi4m3qi
 PmI8dimantgNX2j22I86sBrFkezKd0+6d5LjfxTlV6dnHYmQAZOkz+3U8ia7WAFP50zN
 jOBPSX4mtr/oM672sfsCiUDXTip4SKyLq0+7ULI8Oq2KtrbHpF/twy7fCCLOmV1bWCuV
 IG5qEhA5BIru/mfoev3XnsUpaEQk8A4V21ag3hFhY7+wol1XoIcXh/PkTKm7VNX4tqNa
 07Eg==
X-Gm-Message-State: AOJu0Yy8691GVBEKDdY30CXk3CRVLlPLgFEgCFfT8p+WOf00354cipW2
 qcSwS+UVpts01SqyREtEdtu+hFPPgH49C19QJLrPZs0T1i3CuhG7xN8Gd+rmm0FFK3tSENOgkYa
 /GAWT
X-Gm-Gg: AeBDietn2zaqLWo/9O6YvvK+UNck+pfRBpqHC6V18mLBXznVqrlpvAFsr+KTaA+uj1z
 9e0z3WW+r6GdbRylFOmQKkUJcWe/MD9UqoGAcWX1uYJFOTm/6zJrF1FC5YLadw8tBrbAovlre3M
 zvyMqlS1Yk1tp8splryTu5VyrH/+T0TMnJOx1RaIF6HPpZW7GFLG5kkZRzE+JS4vUgnxg5wgzsS
 Vro6U6UxJy825d6tWcHilReoLHlxZsB/DIUbZcNpRsYjm1xR349yTLmzFxWZRhOvH4OHAn1PI9Y
 2yZdJsr1rq0p4cT+j2CK8H0UPtxap/oJVgtWj+SDEVI/iPBRxrJZBdXuRl611gA/YA78wNmjEZT
 nwsn0fh5r1fs8qcIMCvp4lXjhR80QBblgSufFmceLBYm27AQsBg6qPe36NTDniNFzMqUntFDF4H
 NqStcXZ3mp/PkFQMiq5BAQcjyNlXNWNDbuy8KRtt50ghKhbA4TWiRYoA==
X-Received: by 2002:a05:693c:26c2:b0:2d8:7302:d21 with SMTP id
 5a478bee46e88-2d8730215b3mr2322269eec.16.1776100720641; 
 Mon, 13 Apr 2026 10:18:40 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2d55f5c69d5sm20258602eec.3.2026.04.13.10.18.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Apr 2026 10:18:40 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Thomas Monjalon <thomas@monjalon.net>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Matan Azrad <matan@nvidia.com>, Ajit Khaparde <ajit.khaparde@broadcom.com>,
 Ori Kam <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>
Subject: [PATCH 1/6] ethdev: fix flow_ops_mutex for multi-process
Date: Mon, 13 Apr 2026 10:14:45 -0700
Message-ID: <20260413171836.123467-2-stephen@networkplumber.org>
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

The flow_ops_mutex in rte_eth_dev_data is located in shared memory
that is accessed by both primary and secondary processes. However,
the mutex is initialized without PTHREAD_PROCESS_SHARED attribute,
which means synchronization between processes is undefined behavior.

POSIX mutexes are by default private to the process creating them.
When a mutex protects data structures in shared memory that are
accessed by multiple processes, pthread_mutexattr_setpshared() must
be called with PTHREAD_PROCESS_SHARED.

This bug has existed since the flow_ops_mutex was added and affects
any multi-process DPDK application using rte_flow APIs.

Bugzilla ID: 662
Fixes: 80d1a9aff7f6 ("ethdev: make flow API thread safe")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/ethdev/ethdev_driver.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/lib/ethdev/ethdev_driver.c b/lib/ethdev/ethdev_driver.c
index 2ec665be0f..d12395efe0 100644
--- a/lib/ethdev/ethdev_driver.c
+++ b/lib/ethdev/ethdev_driver.c
@@ -89,6 +89,22 @@ eth_dev_set_dummy_fops(struct rte_eth_dev *eth_dev)
 	eth_dev->recycle_rx_descriptors_refill = rte_eth_recycle_rx_descriptors_refill_dummy;
 }
 
+/*
+ * Initialize mutex for process-shared access.
+ * The rte_eth_dev_data structure is in shared memory, so any mutex
+ * protecting it must use PTHREAD_PROCESS_SHARED.
+ */
+static void
+eth_dev_flow_ops_mutex_init(pthread_mutex_t *mutex)
+{
+	pthread_mutexattr_t attr;
+
+	pthread_mutexattr_init(&attr);
+	pthread_mutexattr_setpshared(&attr, PTHREAD_PROCESS_SHARED);
+	pthread_mutex_init(mutex, &attr);
+	pthread_mutexattr_destroy(&attr);
+}
+
 RTE_EXPORT_INTERNAL_SYMBOL(rte_eth_dev_allocate)
 struct rte_eth_dev *
 rte_eth_dev_allocate(const char *name)
@@ -135,7 +151,7 @@ rte_eth_dev_allocate(const char *name)
 	eth_dev->data->port_id = port_id;
 	eth_dev->data->backer_port_id = RTE_MAX_ETHPORTS;
 	eth_dev->data->mtu = RTE_ETHER_MTU;
-	pthread_mutex_init(&eth_dev->data->flow_ops_mutex, NULL);
+	eth_dev_flow_ops_mutex_init(&eth_dev->data->flow_ops_mutex);
 	RTE_ASSERT(rte_eal_process_type() == RTE_PROC_PRIMARY);
 	eth_dev_shared_data->allocated_ports++;
 
-- 
2.53.0

