Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 584B9C87FCE
	for <dpdk-dev@archiver.kernel.org>; Fri, 25 Jul 2025 12:55:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C6279402F0;
	Fri, 25 Jul 2025 14:55:41 +0200 (CEST)
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com
 [209.85.214.170])
 by mails.dpdk.org (Postfix) with ESMTP id 6E2284025A
 for <dev@dpdk.org>; Fri, 25 Jul 2025 14:55:40 +0200 (CEST)
Received: by mail-pl1-f170.google.com with SMTP id
 d9443c01a7336-23c8f179e1bso24067895ad.1
 for <dev@dpdk.org>; Fri, 25 Jul 2025 05:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=uetpeshawar-edu-pk.20230601.gappssmtp.com; s=20230601; t=1753448139;
 x=1754052939; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6pPxKaBDqAP3QahJb5MsRlvGdSd85f5P3UVuLDjBnMo=;
 b=PeiXiw8x9flLIBKZqEoWQEcSct0+bcBgqyfm2noWYpdLqLhWB6PnCzraKLIwyHqDsx
 arGAJr6vVcqAbEbSJkzvSS7E8Ab6kOKTunM/IRXnK9+y9EsFsL5bo0Vd9jvKOQcHHKB8
 YkTMGzUJ0pDIag60Il+RIiu1wxeEUkJ83tR337sEFbQXourrBz62abk0I7cVt/5yPeyO
 eCq2oJM0nE3n3bMAPmvgUz6u9d36phoeuHCntr0p8x9dusNCw9st0/ARVohJraLMiv9j
 La2AheLbWcHLyb6tpiECGcIYmTG3ictTHJfw42YdP5vNhWk5JwbHyuaJGqB+k1Gru1qm
 rBvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753448139; x=1754052939;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6pPxKaBDqAP3QahJb5MsRlvGdSd85f5P3UVuLDjBnMo=;
 b=md5U/r1Q+i7kfMNVUHu0o3IyHQ2dVkQkA6ktCNNr2igAYaNewzcJc3bscqdEtU4Avk
 f3uiRK20KxeeDjhKAZOI7sKwhK8dgTieKmVdIn4OLSVb0jKYSCnLsG5ETWZ9svH1voLF
 MavOX4rm73Pa5vVuCHLrESAv2ra8zQ+AMlzMCm3NNos4PfZgPT0vh18WRlm6ehJt+wPd
 C4oX1JxYQirKU1EmOw/AAhRDKkzdhOE5iXmpBtVBE/NaGksxlw3tHqzDrb8JpEZvHLmG
 aOjKwS4pxJWaFOJu0nwB9FA935cMpZUxYFW31ED+VKee3uc1JAplCCxqS4+L4zADHBFJ
 vEkw==
X-Gm-Message-State: AOJu0YzqL4Gerwn6jtXC7IkW/V9hgdkaCrktVSK5y/IMiRNKWQEY4+Po
 KFVH7pxGzP+APdkSF1xYp0ZSS9mCdM2fmkrtwndA5MsUkulIJQ0vDixW7NehVannuHk=
X-Gm-Gg: ASbGncvrAedUSOBWDDk5T9Fwep0JFipyi3IuSEEm5s59ARD1C6b4ZaObUeoqd0VseHS
 YdWxkga0v/p763/uBJT3aEWQ18pPbvVOrOwD7j0ZxTbFZZW2vKmjMVmStoBqSX3UEGI2jpp2b/4
 GUF+PQ9OQ+V/fuoA+3aGupdopZ6ZnIR58l8F9TfUt+TELNcw3ouqhuUdB0fbmggCd2qbU3ljDMT
 u8ls2qMx9MHozVHCSa9id+fcWXxTDrSAJAVwWtxgWqjJxvkSDtNKd5/GzqdwHyNAs1JnO5pTQ2p
 +a5y6emWAaNx/GEl7MmPSuoKozyfB3d8faRNGSCwGPedYUxYNef9h0OYr69sAJTERjiIxlO0ID1
 HFBX2eU+umFw1Di+zg4e+YsSiJzZHTnURDnyn36CmTU8lBrSP
X-Google-Smtp-Source: AGHT+IED3kIwy5imDgwiipTo1eADMcF4dz3if/RrnmPtpmjcppmM9tQv7fh+V2dNUu3pJ1BML9skpQ==
X-Received: by 2002:a17:902:e84d:b0:235:1966:93a9 with SMTP id
 d9443c01a7336-23fb309bc81mr30555025ad.3.1753448139345; 
 Fri, 25 Jul 2025 05:55:39 -0700 (PDT)
Received: from localhost.localdomain ([64.62.143.197])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23fa49167ffsm36626845ad.204.2025.07.25.05.55.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Jul 2025 05:55:38 -0700 (PDT)
From: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
To: stephen@networkplumber.org, thomas@monjalon.net, ferruh.yigit@amd.com,
 andrew.rybchenko@oktetlabs.ru
Cc: dev@dpdk.org, stable@dpdk.org,
 Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
Subject: [PATCH] [PATCH v4] lib/ethdev: fix segfault in secondary process by
 validating dev_private pointer
Date: Fri, 25 Jul 2025 08:55:26 -0400
Message-ID: <20250725125526.2340233-1-14pwcse1224@uetpeshawar.edu.pk>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250723131049.1703172-1-14pwcse1224@uetpeshawar.edu.pk>
References: <20250723131049.1703172-1-14pwcse1224@uetpeshawar.edu.pk>
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

In secondary processes, directly accessing 'dev->data->dev_private' can
cause a segmentation fault if the primary process has exited or if the
shared memory is no longer accessible.

The secondary process not only crashes on device close but also segfaults
when executing commands like "show device info all" after the primary has
exited.

This patch adds a mechanism in testpmd to monitor the primary process from the
secondary using `rte_eal_primary_proc_alive()`, and introduces safety
checks before dereferencing 'dev_private'. The `rte_mem_virt2phy()` call
is also guarded to avoid access to invalid memory regions, with
`unlikely()` hints to minimize impact in the fast path.

Fixes: bdad90d12ec8 ("ethdev: change device info get callback to return int")
Cc: stable@dpdk.org

Signed-off-by: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
---
 app/test-pmd/testpmd.c  | 56 ++++++++++++++++++++++++++++++++++++++---
 lib/ethdev/rte_ethdev.c | 15 ++++++++++-
 2 files changed, 66 insertions(+), 5 deletions(-)

diff --git a/app/test-pmd/testpmd.c b/app/test-pmd/testpmd.c
index bb88555328..25e55de281 100644
--- a/app/test-pmd/testpmd.c
+++ b/app/test-pmd/testpmd.c
@@ -101,13 +101,17 @@
 uint16_t verbose_level = 0; /**< Silent by default. */
 int testpmd_logtype; /**< Log type for testpmd logs */
 
+static volatile uint8_t quit_signal;
+
+/* Maximum delay for exiting after primary process. */
+#define MONITOR_INTERVAL (500 * 1000)
+
 /* use main core for command line ? */
 uint8_t interactive = 0;
 uint8_t auto_start = 0;
 uint8_t tx_first;
 char cmdline_filename[PATH_MAX] = {0};
 bool echo_cmdline_file;
-
 /*
  * NUMA support configuration.
  * When set, the NUMA support attempts to dispatch the allocation of the
@@ -2281,7 +2285,7 @@ run_pkt_fwd_on_lcore(struct fwd_lcore *fc, packet_fwd_t pkt_fwd)
 			fc->total_cycles += tsc - prev_tsc;
 			prev_tsc = tsc;
 		}
-	} while (! fc->stopped);
+	} while (!fc->stopped && !quit_signal);
 }
 
 static int
@@ -4329,9 +4333,51 @@ static void
 signal_handler(int signum __rte_unused)
 {
 	f_quit = 1;
+	quit_signal = 1;
 	prompt_exit();
 }
 
+
+/* Alarm signal handler, used to check that primary process */
+static void
+monitor_primary(void *arg __rte_unused)
+{
+	if (rte_atomic_load_explicit(&quit_signal, rte_memory_order_relaxed))
+		return;
+
+	if (rte_eal_primary_proc_alive(NULL)) {
+		rte_eal_alarm_set(MONITOR_INTERVAL, monitor_primary, NULL);
+	} else {
+		fprintf(stderr,
+			"Primary process is no longer active, exiting...\n");
+		quit_signal = 1;
+		f_quit = 1;
+		prompt_exit();
+	}
+}
+
+/* Setup handler to check when primary exits. */
+static void
+enable_primary_monitor(void)
+{
+	int ret;
+
+	/* Once primary exits, so will pdump. */
+	ret = rte_eal_alarm_set(MONITOR_INTERVAL, monitor_primary, NULL);
+	if (ret < 0)
+		fprintf(stderr, "Fail to enable monitor:%d\n", ret);
+}
+
+static void
+disable_primary_monitor(void)
+{
+	int ret;
+
+	ret = rte_eal_alarm_cancel(monitor_primary, NULL);
+	if (ret < 0)
+		fprintf(stderr, "Fail to disable monitor:%d\n", ret);
+}
+
 int
 main(int argc, char** argv)
 {
@@ -4362,7 +4408,8 @@ main(int argc, char** argv)
 	if (diag < 0)
 		rte_exit(EXIT_FAILURE, "Cannot init EAL: %s\n",
 			 rte_strerror(rte_errno));
-
+	if (rte_eal_process_type() == RTE_PROC_SECONDARY)
+		enable_primary_monitor();
 	/* allocate port structures, and init them */
 	init_port();
 
@@ -4571,7 +4618,8 @@ main(int argc, char** argv)
 	if (ret != 0)
 		rte_exit(EXIT_FAILURE, "Cannot unregister for ethdev events");
 
-
+	if (rte_eal_process_type() == RTE_PROC_SECONDARY)
+		disable_primary_monitor();
 	ret = rte_eal_cleanup();
 	if (ret != 0)
 		rte_exit(EXIT_FAILURE,
diff --git a/lib/ethdev/rte_ethdev.c b/lib/ethdev/rte_ethdev.c
index dd7c00bc94..343e156a4f 100644
--- a/lib/ethdev/rte_ethdev.c
+++ b/lib/ethdev/rte_ethdev.c
@@ -4079,6 +4079,13 @@ rte_eth_dev_info_get(uint16_t port_id, struct rte_eth_dev_info *dev_info)
 
 	if (dev->dev_ops->dev_infos_get == NULL)
 		return -ENOTSUP;
+	if (rte_eal_process_type() == RTE_PROC_SECONDARY &&
+		unlikely(rte_mem_virt2phy(dev->data->dev_private) == RTE_BAD_PHYS_ADDR)) {
+			RTE_ETHDEV_LOG_LINE(ERR,
+			"Secondary: dev_private not accessible (primary exited?)");
+			rte_errno = ENODEV;
+			return -rte_errno;
+	}
 	diag = dev->dev_ops->dev_infos_get(dev, dev_info);
 	if (diag != 0) {
 		/* Cleanup already filled in device information */
@@ -4307,7 +4314,13 @@ rte_eth_macaddr_get(uint16_t port_id, struct rte_ether_addr *mac_addr)
 			port_id);
 		return -EINVAL;
 	}
-
+	if (rte_eal_process_type() == RTE_PROC_SECONDARY &&
+		(dev->data->mac_addrs == NULL)) {
+			RTE_ETHDEV_LOG_LINE(ERR,
+			"Secondary: dev_private not accessible (primary exited?)");
+			rte_errno = ENODEV;
+			return -rte_errno;
+	}
 	rte_ether_addr_copy(&dev->data->mac_addrs[0], mac_addr);
 
 	rte_eth_trace_macaddr_get(port_id, mac_addr);
-- 
2.43.0

