Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0596FC87FC9
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Jul 2025 06:39:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0E6A540668;
	Tue, 29 Jul 2025 08:39:36 +0200 (CEST)
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com
 [209.85.210.176])
 by mails.dpdk.org (Postfix) with ESMTP id 460F740647
 for <dev@dpdk.org>; Tue, 29 Jul 2025 08:39:34 +0200 (CEST)
Received: by mail-pf1-f176.google.com with SMTP id
 d2e1a72fcca58-748feca4a61so3188675b3a.3
 for <dev@dpdk.org>; Mon, 28 Jul 2025 23:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=uetpeshawar-edu-pk.20230601.gappssmtp.com; s=20230601; t=1753771173;
 x=1754375973; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=srihcXYhJz2GOLDs1Net4X9VmFNIhWy+k2KGA8Fe/CM=;
 b=zDaDZzlVWjLEYHzcQWEz5kS2IdEdle2GW0Vhi2xePXU4HaTjS9pDh8tmMbrKxDYYFx
 JHrqG/fhFzKDpUz5NHgKzJwkzw74zkH6cSHRMam6QFr6N2nwgHosWas8mYN4lRD0ybx0
 W6PpM4T3gzG5bTtJpWxjAV5JsFvmHeoDB2zPp9Fd+cVnCVaFwuwUuTNtrmJXKJlY+Iyn
 6E5tdIdGuqyilYjX6pzUNmUs99L/XcSb+sNW5hXGc4va2RXrHvJLt1TW58AIcfmMByt3
 +inEDoss2L+zNkGxa/KC4yt7pKoGPCjnS6v9T8UXbEyGtj5phStZhW6UxYXOZYUZzMpJ
 iCTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753771173; x=1754375973;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=srihcXYhJz2GOLDs1Net4X9VmFNIhWy+k2KGA8Fe/CM=;
 b=v6LDVi0ZRLgGhjJVXSF112xMOiXIzVwZHrT1k4aCmJVYY6okBpcVjzhTV7peI/Cxyo
 DkzHurjl1KUjAT4ANrMXtLxrCTfg2STQewwvXUmUWty2O4S8IIOT6LYzDgNoeAq7s6uQ
 Msm5/Niok+rgOrMnEeUuZRaCuDLqubLJyxWjjfugQH/u3lprPDva1iWuDYxBTlSeIE71
 Uq3e8pdPfx0CoF8VKEuG6ZsCbSifSeJzr8ho+3+SFbvxl66dilNwwuq8wCEwVLXcNVBw
 zEqgRjtSc99nNaXUc+SsBHdkysTy8dwY70ivIoYgsCoshK5dqynNQY+pvjxbDecGB4cJ
 4l5w==
X-Gm-Message-State: AOJu0YydEQLzKWcWPHoVcYYRry++zjH59WpZlrPZ1L4Yn2MOlfZ5UgTQ
 cxQIzS8aGkeF09QYFvxa/REbG/TAfqCysxaaF5WvPNU1opb1xa5+4LWONFwHSCOA5fM=
X-Gm-Gg: ASbGncuxugyhvYxLJzKTOq7O4KHfphryf2hnw1CSU9eZ3RFHUWUHiheKxBNHXLjYrrN
 INx5l+3h91pICshmOB2J4CR09QStCcYM5+Tin5+m4SghjyJbs80zJHsZphrrH8CjM3pZUEeijEa
 rFTP+bEIQn6vp0NfRQjoitd2InV/xC8eMkVPAHVWxZZRI1cLXMVvuZ0pdCH04PnnNDL6k6RbVbf
 +NpOaMNDddfW7k3JHV3GuPk9N/OMD/Pyv0efcTyve4haKQ4dV7s8WpuI+xU3sRGS2lSJ3oUGIX7
 oxcQ4lg3MKj5kyCL/kgmXUgBuLagxw8Sf0LuKzm+nkMWe6ObkIxz2LYVsFH8w8Jliq3u4iqoW1r
 N2a/8LoCgY84uNS3U7dSsfrgOuRQAwCztqyIErNGgNXX75Hxm
X-Google-Smtp-Source: AGHT+IHs57Hm1/EUmWM7qBEcNVkf7vFLfYLOamEDYE75OEGCDaqYM8qKdXnMNIbFVCCio/oDyKxOqg==
X-Received: by 2002:a05:6a00:228e:b0:749:8c3:873e with SMTP id
 d2e1a72fcca58-76336369dd9mr21908671b3a.24.1753771173180; 
 Mon, 28 Jul 2025 23:39:33 -0700 (PDT)
Received: from localhost.localdomain ([64.62.143.197])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7640b8b2868sm6640791b3a.128.2025.07.28.23.39.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Jul 2025 23:39:32 -0700 (PDT)
From: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
To: stephen@networkplumber.org, thomas@monjalon.net, ferruh.yigit@amd.com,
 andrew.rybchenko@oktetlabs.ru
Cc: dev@dpdk.org, stable@dpdk.org,
 Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
Subject: [PATCH] app/testpmd: fix segfault in secondary process by monitoring
 primary
Date: Tue, 29 Jul 2025 02:39:17 -0400
Message-ID: <20250729063919.3554143-1-14pwcse1224@uetpeshawar.edu.pk>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250725125526.2340233-1-14pwcse1224@uetpeshawar.edu.pk>
References: <20250725125526.2340233-1-14pwcse1224@uetpeshawar.edu.pk>
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
shared memory is no longer accessible. If a secondary process attempts
to query device information (e.g., via testpmd), a NULL dereference
may occur due to missing shared data.

The secondary process not only crashes on device close but also segfaults
when executing commands like "show device info all" after the primary has
exited.

This patch adds a mechanism in testpmd to monitor the primary process from the
secondary using `rte_eal_primary_proc_alive()`, and exits secondary process
when primary has exited.

Fixes: af75078fece3 ("first public release")
Cc: stable@dpdk.org

Signed-off-by: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
---
 app/test-pmd/testpmd.c  | 49 +++++++++++++++++++++++++++++++++++++----
 lib/ethdev/rte_ethdev.c |  8 ++++++-
 2 files changed, 52 insertions(+), 5 deletions(-)

diff --git a/app/test-pmd/testpmd.c b/app/test-pmd/testpmd.c
index bb88555328..ad780ba754 100644
--- a/app/test-pmd/testpmd.c
+++ b/app/test-pmd/testpmd.c
@@ -101,13 +101,15 @@
 uint16_t verbose_level = 0; /**< Silent by default. */
 int testpmd_logtype; /**< Log type for testpmd logs */
 
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
@@ -2281,7 +2283,7 @@ run_pkt_fwd_on_lcore(struct fwd_lcore *fc, packet_fwd_t pkt_fwd)
 			fc->total_cycles += tsc - prev_tsc;
 			prev_tsc = tsc;
 		}
-	} while (! fc->stopped);
+	} while (!fc->stopped && !f_quit);
 }
 
 static int
@@ -4332,6 +4334,43 @@ signal_handler(int signum __rte_unused)
 	prompt_exit();
 }
 
+
+/* Alarm signal handler, used to check that primary process */
+static void
+monitor_primary(void *arg __rte_unused)
+{
+	if (rte_eal_primary_proc_alive(NULL)) {
+		rte_eal_alarm_set(MONITOR_INTERVAL, monitor_primary, NULL);
+	} else {
+		fprintf(stderr,
+			"Primary process is no longer active, exiting...\n");
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
@@ -4362,7 +4401,8 @@ main(int argc, char** argv)
 	if (diag < 0)
 		rte_exit(EXIT_FAILURE, "Cannot init EAL: %s\n",
 			 rte_strerror(rte_errno));
-
+	if (rte_eal_process_type() == RTE_PROC_SECONDARY)
+		enable_primary_monitor();
 	/* allocate port structures, and init them */
 	init_port();
 
@@ -4571,7 +4611,8 @@ main(int argc, char** argv)
 	if (ret != 0)
 		rte_exit(EXIT_FAILURE, "Cannot unregister for ethdev events");
 
-
+	if (rte_eal_process_type() == RTE_PROC_SECONDARY)
+		disable_primary_monitor();
 	ret = rte_eal_cleanup();
 	if (ret != 0)
 		rte_exit(EXIT_FAILURE,
diff --git a/lib/ethdev/rte_ethdev.c b/lib/ethdev/rte_ethdev.c
index dd7c00bc94..5c73397164 100644
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
@@ -4307,7 +4314,6 @@ rte_eth_macaddr_get(uint16_t port_id, struct rte_ether_addr *mac_addr)
 			port_id);
 		return -EINVAL;
 	}
-
 	rte_ether_addr_copy(&dev->data->mac_addrs[0], mac_addr);
 
 	rte_eth_trace_macaddr_get(port_id, mac_addr);
-- 
2.43.0

