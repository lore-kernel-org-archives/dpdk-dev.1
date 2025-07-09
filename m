Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61D29C83F0A
	for <dpdk-dev@archiver.kernel.org>; Wed,  9 Jul 2025 17:36:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0EF3040BA0;
	Wed,  9 Jul 2025 19:36:20 +0200 (CEST)
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com
 [209.85.214.172])
 by mails.dpdk.org (Postfix) with ESMTP id 40E6240B8C
 for <dev@dpdk.org>; Wed,  9 Jul 2025 19:36:18 +0200 (CEST)
Received: by mail-pl1-f172.google.com with SMTP id
 d9443c01a7336-2366e5e4dbaso10469155ad.1
 for <dev@dpdk.org>; Wed, 09 Jul 2025 10:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1752082577;
 x=1752687377; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MSh6kbv+hR1zb7kg6e6a3Btjfbls58Zvj3ges5YQbBI=;
 b=C0cm7MJJWKk1dZZMbfKA6E32X0pOyp8sssyMxV5lvQJW7tfPo4eQB9hvBQqdkrfIm9
 GrslYnQa171KLhP+BSw1sUFnBVsH3nWjgekmkdYugaryFy2UJvFmT7/LtPiez2fcOlO/
 TGRnmANljW5qfJxtmrPx3Wmc/fH9NQA+L9UIRQFlQBM8x2QHGMB1chXiT4Gbov+eWMm9
 YrE4X4O2ilvPTCkZQCrYKW/Vsz+aw8K7X5FsOmZgqGLq/zBLNsbBvvaJbGxVCGO9iCtH
 LYYMQLXptO/xxjeyI/eSPOmuWiE5N40jOuAV2s1lKTPZr19R4Z0nls4G6IdM07069CJU
 7lDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752082577; x=1752687377;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MSh6kbv+hR1zb7kg6e6a3Btjfbls58Zvj3ges5YQbBI=;
 b=pDlgssKsjzN5JqsKtcfLmxUWzFdLgiEZKqlOcJNUU99lomW1FIuOu0Q4MDWZ310IZc
 TNbUeN4iygoUIkD6y4eFKYdSlhqFi22d/jjEZnE3pMa5h1H6JqOM9tb/X6u62O887n8o
 QraFt5VwurTHx8UKTdoLTsVNtVePlOtyEF2A76dRdNMJZhIqRgjNwr25fuZqpg0qLgkd
 ETq/KzGg46sqanqr+d/AvS/zn+5V39vHFc17S7y6vDULaxuoqZwtmnasHia+YFRDJfM7
 ciUcPl+WdP4ftSyYBe/i/aJlJG/Equ8TEGPnK1uQ7NXoQxl/BHeXvhzYF+m4wYLSMoeH
 Ioog==
X-Gm-Message-State: AOJu0YxYK1UwvTLfrgRc31W5jvF5NLSycjPqJl/U5g+XWul55hekN6Lb
 cOVqw41H5HnY03cv+PMUKWHYBFtENnlnct7G1l9PXISvsbH9WtLKaRRm8h0QBt8q+5PTVfMZz+U
 Ke3gO
X-Gm-Gg: ASbGncv3IdSDCl9mi3U+xBD02rOY8yfuPaBLqNMB27RtO97A49l1EfugLdiZtJLiH/c
 MnddZ3nWgQ2k+oJkTcqVMVTquKebI41NHwn8qIrABEI1a7idQzL/sRL1BDJY9zP1089gJ9wYCdW
 zJRY9WADqfZvuK4ZDMw27sOiLZwqlsvnIvQyyfHK3In4dWFeHbz50Cp+aCUtOOGIyR+vKjC08pp
 imEi5DBNwGOjRlT5yXkSqmslj1LTuFLWwd1cqBJzFFMeg+KgdqYHJeoow7yVTzmrgpjCXKHx3Mu
 2Qt6khqkiNTd//0csC05R3K2BD4N8tEZdz2GelpYCZKM0o+A8XV9bx3PgRYo5S+hMBJKR1IGg4X
 HXVgKxhPKwmth1TtBhABI+bHOa0ucrEOTiA6w
X-Google-Smtp-Source: AGHT+IHA9jhlgAtDf6w0/TP2FjskLHttNWcIDp19DkXWhAFwbjTTilxccXfghjSrrsevIKpzsucqtg==
X-Received: by 2002:a17:902:e841:b0:237:e753:1808 with SMTP id
 d9443c01a7336-23de2feb28cmr4082685ad.20.1752082577197; 
 Wed, 09 Jul 2025 10:36:17 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23c845b7467sm138525475ad.230.2025.07.09.10.36.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Jul 2025 10:36:16 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [RFC v2 02/12] test: add test for hotplug and secondary process
 operations
Date: Wed,  9 Jul 2025 10:33:28 -0700
Message-ID: <20250709173611.6390-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250709173611.6390-1-stephen@networkplumber.org>
References: <0250411234927.114568-1-stephen@networkplumber.org>
 <20250709173611.6390-1-stephen@networkplumber.org>
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

Use null device to exercise ethdev start/stop in secondary process.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/test/test_mp_secondary.c | 51 +++++++++++++++++++++++++++++++++---
 1 file changed, 48 insertions(+), 3 deletions(-)

diff --git a/app/test/test_mp_secondary.c b/app/test/test_mp_secondary.c
index f3694530a8..09611cc5c2 100644
--- a/app/test/test_mp_secondary.c
+++ b/app/test/test_mp_secondary.c
@@ -15,6 +15,9 @@
 #include <string.h>
 #include <unistd.h>
 
+#include <rte_ethdev.h>
+#include <rte_bus_vdev.h>
+
 #ifdef RTE_EXEC_ENV_WINDOWS
 int
 test_mp_secondary(void)
@@ -204,6 +207,44 @@ run_object_creation_tests(void)
 	return 0;
 }
 
+static int
+run_ethdev_tests(void)
+{
+	char vdev_name[] = "net_null";
+	struct rte_eth_conf dev_conf = { 0 };
+	uint16_t port;
+	int ret;
+
+	printf("### Testing hotplug and ethdev start/stop\n");
+
+	/* use hotplug to make a null vdev */
+	ret = rte_eal_hotplug_add("vdev", vdev_name, "");
+	TEST_ASSERT(ret == 0, "Hotplug add of '%s' failed", vdev_name);
+
+	printf("# Checked hotlug_add OK\n");
+
+	ret = rte_eth_dev_get_port_by_name(vdev_name, &port);
+	TEST_ASSERT(ret == 0, "Lookup vdev '%s' failed", vdev_name);
+
+	ret = rte_eth_dev_configure(port, 1, 1, &dev_conf);
+	TEST_ASSERT(ret == 0, "Configure port %u failed", port);
+
+	ret = rte_eth_dev_start(port);
+	TEST_ASSERT(ret == 0, "Start port %u failed", port);
+
+	printf("# Checked rte_eth_dev_start\n");
+
+	ret = rte_eth_dev_stop(port);
+	TEST_ASSERT(ret == 0, "Stop port %u failed", port);
+
+	printf("# Checked rte_eth_dev_stop\n");
+
+	rte_eal_hotplug_remove("vdev", vdev_name);
+
+	printf("# Checked hotlug_remove OK\n");
+	return 0;
+}
+
 /* if called in a primary process, just spawns off a secondary process to
  * run validation tests - which brings us right back here again...
  * if called in a secondary process, this runs a series of API tests to check
@@ -212,15 +253,19 @@ run_object_creation_tests(void)
 int
 test_mp_secondary(void)
 {
-	if (rte_eal_process_type() == RTE_PROC_PRIMARY) {
+	int ret;
+
+	if (rte_eal_process_type() == RTE_PROC_PRIMARY)
 		return run_secondary_instances();
-	}
 
 	printf("IN SECONDARY PROCESS\n");
+	ret = run_ethdev_tests();
+	if (ret != 0)
+		return ret;
 
 	return run_object_creation_tests();
 }
 
 #endif /* !RTE_EXEC_ENV_WINDOWS */
 
-REGISTER_FAST_TEST(multiprocess_autotest, false, false, test_mp_secondary);
+REGISTER_FAST_TEST(multiprocess_autotest, true, true, test_mp_secondary);
-- 
2.47.2

