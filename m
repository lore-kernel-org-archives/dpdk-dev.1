Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8225BC87FC9
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Jul 2025 06:39:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 864F940E11;
	Tue, 29 Jul 2025 08:39:37 +0200 (CEST)
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com
 [209.85.210.181])
 by mails.dpdk.org (Postfix) with ESMTP id F3E4540647
 for <dev@dpdk.org>; Tue, 29 Jul 2025 08:39:34 +0200 (CEST)
Received: by mail-pf1-f181.google.com with SMTP id
 d2e1a72fcca58-769a9c3bbc4so391641b3a.3
 for <dev@dpdk.org>; Mon, 28 Jul 2025 23:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=uetpeshawar-edu-pk.20230601.gappssmtp.com; s=20230601; t=1753771174;
 x=1754375974; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6pPxKaBDqAP3QahJb5MsRlvGdSd85f5P3UVuLDjBnMo=;
 b=iI4/ooNP6j2VzVCAY0AByD2HPAN1hHcGm0Lezawsmorl48GGz3EKFsz28Y4yyU7Enj
 FvC7h/mTF7kR+eLK8vkts607vFMUAxJp+Wzt+ikw2qMmC5C6X1CENptDzGjbtFpGoOLs
 IX9tUou2IvFyCLcXYSB1TPpNPfDV4Q2ILOsENukb0cKKrmGi7XZUF74l0VSdLxIFTM1P
 0DBL9FrvF7UbzZt4NMGgblS7I/7065dVFklz/OhMExPQDnzf8hU2K7iAVuOKBIYdGNEa
 MpdXgRy5RZ6EOFKxK1pawDCnVMXgiEhVqFAW1Vx0qDbQLu9UhPkDdktS236L6PTE5bxx
 V7YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753771174; x=1754375974;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6pPxKaBDqAP3QahJb5MsRlvGdSd85f5P3UVuLDjBnMo=;
 b=euaSDtobiFWlzcNc/4XLQ5JIhCDM4n7vr36CJqdVK02c1+pXSFdqd4z1/O5X5lgb3i
 lzwYYNZrRS9/VkQvrhAbRukZLQEUlz5Af3jUrqqYEvzUjaJCJ/rbz/TnugQjSsglYt0M
 79WJTqWlcSQA8vu9yMxv0V1qqe1NlEUdr++YdGPeOaKW9IOiIVDsbFzTZm7GrYMgZR4/
 TalLVxPJ3R22IcOmIge4/MsldN4fH9MgJDMqnnFjpNh32TwrOy8cJ1MBCoSaXaI14/dT
 tQFKiSIeyGltml9ooXgrYsbgqkmLkQMm+r9159Qoghi5EHsFam/T/dOrDb3p3nzpG/MI
 6G1w==
X-Gm-Message-State: AOJu0YzXgfczexufaQ/VXnXY7c0v7ICErXqOD+5lftk3fWawXfgXXel8
 EHxi0w7BPZX/fd2sndl7i+hrEwT0g4jJ56RVmN1Nsh55ddVYVrsb5Oc3eWqtHt4+s7RFyhBhJlx
 t1TQb09adsg==
X-Gm-Gg: ASbGncuHIci2f0joAHAU6OmTSr0V3cIDDDDJliuSmy8CR/kShR+7tF98KLJKN82ZWjU
 ia9CGcXcB4bBuHp6StHuOjXolzwG4OrhFN6Rt7S0tP25rmPJG1ZcpOfW+hjVdIN6fnm0oK6ar3V
 1+6uwRvt9KF8l6iEwEOzkcYM6SxN8NpcRo2+VyeD46Z5HWslp+nDMnos0OKCt8XyoCpsLyVwdEW
 jTG5oylcxB4sU2OUXG2e+LNh3hDatxe23AUP0wiHs/9myMr5pm6/UaHweA8sRbPoiUOT4lSeBR7
 6jI9Y/xPnbH8KAbzWsOKfysBhSLLKOLruh6IPJp3kWW+f+DGw7P/t7o3T0x0ASrWBEk4sNzxeXT
 7vLIcJnjF2+BNUVHr/Umfx9pclM6cOT775lEhyK4A7FPapNdR
X-Google-Smtp-Source: AGHT+IHeKmZRb7tsN2gjt00G3BqL8PhDxOZNJFlFln9Y6nvT5Qdwp1WftkoQqye4TKSk+mn0CmqzmA==
X-Received: by 2002:a05:6a00:3991:b0:75d:8e1a:6db9 with SMTP id
 d2e1a72fcca58-76335a7e7d9mr20298516b3a.7.1753771174150; 
 Mon, 28 Jul 2025 23:39:34 -0700 (PDT)
Received: from localhost.localdomain ([64.62.143.197])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7640b8b2868sm6640791b3a.128.2025.07.28.23.39.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Jul 2025 23:39:33 -0700 (PDT)
From: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
To: stephen@networkplumber.org, thomas@monjalon.net, ferruh.yigit@amd.com,
 andrew.rybchenko@oktetlabs.ru
Cc: dev@dpdk.org, stable@dpdk.org,
 Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
Subject: [PATCH] [PATCH v4] lib/ethdev: fix segfault in secondary process by
 validating dev_private pointer
Date: Tue, 29 Jul 2025 02:39:18 -0400
Message-ID: <20250729063919.3554143-2-14pwcse1224@uetpeshawar.edu.pk>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250729063919.3554143-1-14pwcse1224@uetpeshawar.edu.pk>
References: <20250725125526.2340233-1-14pwcse1224@uetpeshawar.edu.pk>
 <20250729063919.3554143-1-14pwcse1224@uetpeshawar.edu.pk>
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

