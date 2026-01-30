Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C990D73EB7
	for <dpdk-dev@archiver.kernel.org>; Fri, 30 Jan 2026 05:21:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7DC48402E9;
	Fri, 30 Jan 2026 06:21:52 +0100 (CET)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com
 [209.85.221.53]) by mails.dpdk.org (Postfix) with ESMTP id 88C03402E2
 for <dev@dpdk.org>; Fri, 30 Jan 2026 06:21:51 +0100 (CET)
Received: by mail-wr1-f53.google.com with SMTP id
 ffacd0b85a97d-43596062728so1753742f8f.1
 for <dev@dpdk.org>; Thu, 29 Jan 2026 21:21:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769750511;
 x=1770355311; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5KbD3a6ogx+HDv0vFxdR4Ker2XT/DQ7IndIBydfaFVc=;
 b=h3QN88K/Ikhbi1S4idJe26eVVoB/2x0LBH3NRegUoxrG1eapdUAI1SrTa6iSimd6bS
 Ul1x1/llRF/Ie0p8ZwznksXxpe7TFtTMtExFgQU24JqFNr/nNbRoL9lDKWnbKPV7cE7t
 vE5IUyp9NlvJdwR/Kv18ZeMesdHuJ0SnviHko9zZcRr4UpsjQJJ6jAJ9B/iB8xIE0zwx
 vk/+6v3/foKUVbLy1PRJslPJuyeh5V9TU3NHNnq+Ed5gB1TzoYx2/Iom4FV4Jgh0wchf
 AIrzpKSRMOlt2DzBDcXbDRwDAuocSaj1dnM8/Re27w3WPcPW0pyYQtWT6jggvhWYanqD
 884Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769750511; x=1770355311;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5KbD3a6ogx+HDv0vFxdR4Ker2XT/DQ7IndIBydfaFVc=;
 b=YRqCw5I37Rcry89XKOIubzj2iRMsahZVhcrBTErZTkojrVUgLpCUU32SHcNrsRk9eP
 HhGFplp9GREh2S8ilq/0t9j1eX9T+sDi2xxZ7HM6r8RWHBH0/btfP6bnbWbi/yZ0rKut
 l6LgV9K1df8Z9pBKXy7NJEGISkrOMz3ns3QNDC0SIwCoLI1Z8HEOVs0/TLjFXy9Tjenw
 7qS5ubdZJw6ykSHcx6EpmNJ3aSe++bX8C0pyadBOkV4iXBKPaAsNeSPtw8vL3T0Ijze+
 8SPmh6PPBQKwoJKO0w9Kaj6o/wP7wPECliBAJPP4mJkDpcj7VEDVfvNnKRm9TrmDchfz
 Q6YA==
X-Gm-Message-State: AOJu0YyFHLoqEFeBKHKxPE22Vzsqk75aYbRRfqT1ajvRU+vAqxeLUvwT
 zwVuvP2+covNO+8iEzm/P6Oza6INPphGaBDeDKLie3o2AcpRB/AFpgiPSGHNpfeAoyTtb89b2rV
 BBe5Q
X-Gm-Gg: AZuq6aJd8rpAvLx5yjSSeZ73rlcjPg6Y+yL6VnjXKL7nc9fSE9plWVfZnrjGTdflHIP
 hMF1mebkC9zkdDKrq1pwzFjXQs8j6veOp1rAgI4RhOZRuS/Jo4VJ3YkyWB3oXcZBTdXAohQp7s4
 HyaLLEHD3L4D0HRpvzGZjYVoNNIxSOihfdvQ5ArYi67kcSMw12E3ybkL54XpKKnAQ1gT29h/CDF
 i7ARGj7tUlIrIiCzLuOgFiu4CFYXKdCA8xpq8DEaIbEXurdC/VmyUynja75PCklpRrXRZa+llVP
 Hd4w7mCik/af0p8c73/UNJ6epndPZvKTmFVsd8LItq5x+qATEdjL4DAzG0BwFWykBZguzf0L4ib
 +OMgJ7CS0sDi+0dqbGoT6MglqDeZuPXewWmRrun16zChMy3/9vrrJmrEfyEgbK4mEcLItn+uhbE
 Ltns+pHAYw4J3dOauiYwaQoH/XYjGjWd/fQ9qhn08E9obSRL+x1G11yDjuZpZf
X-Received: by 2002:a05:6000:3103:b0:435:bdc2:461 with SMTP id
 ffacd0b85a97d-435ea2102a0mr7915408f8f.21.1769750510303; 
 Thu, 29 Jan 2026 21:21:50 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e1323034sm19182107f8f.35.2026.01.29.21.21.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Jan 2026 21:21:49 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Thomas Monjalon <thomas@monjalon.net>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Matan Azrad <matan@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>,
 Ajit Khaparde <ajit.khaparde@broadcom.com>
Subject: [RFC 1/6] ethdev: fix flow_ops_mutex for multi-process
Date: Thu, 29 Jan 2026 21:17:32 -0800
Message-ID: <20260130052142.251649-2-stephen@networkplumber.org>
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
2.51.0

