Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32663C87FD3
	for <dpdk-dev@archiver.kernel.org>; Wed,  6 Aug 2025 21:42:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 36F7140431;
	Wed,  6 Aug 2025 23:42:27 +0200 (CEST)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47]) by mails.dpdk.org (Postfix) with ESMTP id C0DD44042C
 for <dev@dpdk.org>; Wed,  6 Aug 2025 23:42:25 +0200 (CEST)
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-451d3f72391so3176845e9.3
 for <dev@dpdk.org>; Wed, 06 Aug 2025 14:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1754516545;
 x=1755121345; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uN8iaZlMVimROEUTtt1lhRt9g6RxVR7PpKINVBdW/WA=;
 b=Wg+n8a5LYJPtgkIqvNmCqmesO6TJP6yBv9erkCJhl/Qm/nQ+KN9XyOPMOGHB2Wwapz
 BDa2UyE1wt32S/aDfzZOrsZp4InjAgwxMX6wujRk5vyAjJlI2vANiVe8/GYEQ2FAc6OJ
 7zX760DMue8J9TcQ+kfEzjLB1+5Zo6htS+N1+JPgHNVKW0Hbh5uYGgm3n6T0l3lkMNC1
 j0ZBi/aPnMd/eqCdEXYUB3y1tXrhRDs0inYn5Cdu6/di05KC4G5srvxbooVPjmyEzYrj
 DDfigAIk2CS+kRcuVsKELCfKGyx+lnRDlLu69lsI9NZBcm85dVINsXl3UKC+zPFlduBn
 WF4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754516545; x=1755121345;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uN8iaZlMVimROEUTtt1lhRt9g6RxVR7PpKINVBdW/WA=;
 b=D7qnz/IaD9Us67HLEjEGGVCldU6qPqJ93oxyV2HX8ku/afGd/ZvmaFp6CoC9vVoE9H
 zZyG2KSVr5olQZ22CBpU9pTRr4mSwCukLkzkJSQwNnZOFL7O4ScK+S1pcZER/B01F7j0
 LC1mSDUm6YaWQcp613yZNx5zMHySq5AKKqS5Ui3GVeI5XvD9sgOBecZxZ6laMWExdreo
 cA8L5XhqDkEOqsXoF3ISA64vlVTazMEb+ejWpSPmWR6LKzODCMDU7YOCt3yz3/cyHu24
 W8qEf5Jb+/oM83XBtrNNOFBids+zyJwK6VOurlLCe0Lj0dBwl0ACr/KW9uzD80ZWQeTr
 XQow==
X-Gm-Message-State: AOJu0YzM5VnpDgWB8l/3VR3+DLxfNG10bhZDgyiVE1XU5xBrSllbMVmz
 Vg+ms8v5fWraKpq0tqbq1DGTuqwDMqA2FCOQrmYaTL+af2RZ+MN1kshnXpaGmcunKMwoEccqHXg
 Lg87E
X-Gm-Gg: ASbGncvCVm6UmzCZXGMzEk06Kb84UHQHD17KG612SQXT3KZpk8TXJVxhVVcQsSX/zQj
 6xa4QqLzuYarRinOjf+jnVfJQT/22AsOfFhWCCRzXegTwR0+ecLbIE5xYMmw+uMTtCSfnk4Jacd
 NmZjpQCXlk0YNW5wc/nLx0FpzaPSlv9B2X6sv6Bi3ONn4IHDGOcuNHqMfs2uTv87b5ysynslKM/
 dcXKjqyyHHQl34KbpJx3lb9arRKXE22jDTiKeu7tnSgV2VN04pQVrInh+pQ1iGsGSEwLSIvNwbQ
 Z+/QxJ8FLYWKD+AaERkI892zQ2mXAK3rbVerCRC33Ywv4VVHITzeZubC2kNm7mQM1SEhVYlobmJ
 vD9EBo+7FsWcbzJQNBLRuTkPajk3gGiE03FDRh85a61fOn2qhA8ejt0fvw3i4GmIAxoZ7nwyBea
 UUJn7/ahTk193bKI052A==
X-Google-Smtp-Source: AGHT+IGpy70Ln9hRDQtv0r8Iqeq+4qM5zbC0QDVVBvvYZsbYWU7Dl08ttc+qEEHeipnaf1MjHNTHtQ==
X-Received: by 2002:a05:600c:1d16:b0:455:fc16:9eb3 with SMTP id
 5b1f17b1804b1-459e70f68c5mr37705355e9.33.1754516545294; 
 Wed, 06 Aug 2025 14:42:25 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c3b9160sm24436913f8f.21.2025.08.06.14.42.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Aug 2025 14:42:24 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH v9 05/13] test: add test for hotplug and secondary process
 operations
Date: Wed,  6 Aug 2025 14:40:34 -0700
Message-ID: <20250806214200.193029-6-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250806214200.193029-1-stephen@networkplumber.org>
References: <20250411234927.114568-1-stephen@networkplumber.org>
 <20250806214200.193029-1-stephen@networkplumber.org>
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
 app/test/test_mp_secondary.c | 50 +++++++++++++++++++++++++++++++++---
 1 file changed, 47 insertions(+), 3 deletions(-)

diff --git a/app/test/test_mp_secondary.c b/app/test/test_mp_secondary.c
index f3694530a8..d6604b326d 100644
--- a/app/test/test_mp_secondary.c
+++ b/app/test/test_mp_secondary.c
@@ -42,6 +42,8 @@ test_mp_secondary(void)
 #include <rte_debug.h>
 #include <rte_log.h>
 #include <rte_mempool.h>
+#include <rte_ethdev.h>
+#include <rte_bus_vdev.h>
 
 #ifdef RTE_LIB_HASH
 #include <rte_hash.h>
@@ -204,6 +206,44 @@ run_object_creation_tests(void)
 	return 0;
 }
 
+static int
+run_ethdev_tests(void)
+{
+	static const char vdev_name[] = "net_null";
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
+	printf("# Checked hotplug_add OK\n");
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
+	printf("# Checked hotplug_remove OK\n");
+	return 0;
+}
+
 /* if called in a primary process, just spawns off a secondary process to
  * run validation tests - which brings us right back here again...
  * if called in a secondary process, this runs a series of API tests to check
@@ -212,15 +252,19 @@ run_object_creation_tests(void)
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

