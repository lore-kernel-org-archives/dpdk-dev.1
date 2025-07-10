Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22C84C83F17
	for <dpdk-dev@archiver.kernel.org>; Thu, 10 Jul 2025 16:42:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 60A6D406FF;
	Thu, 10 Jul 2025 18:42:46 +0200 (CEST)
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com
 [209.85.219.50]) by mails.dpdk.org (Postfix) with ESMTP id D1D6240648
 for <dev@dpdk.org>; Thu, 10 Jul 2025 18:42:44 +0200 (CEST)
Received: by mail-qv1-f50.google.com with SMTP id
 6a1803df08f44-6fb1be9ba89so11958826d6.2
 for <dev@dpdk.org>; Thu, 10 Jul 2025 09:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1752165764;
 x=1752770564; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MSh6kbv+hR1zb7kg6e6a3Btjfbls58Zvj3ges5YQbBI=;
 b=Vi17u3fjjoy22N9mJRr4CfQ4Bq2iZxlBZC95R3SN78mYT1NHYdgkjPFfAzanMQlLj0
 cNKbGltj4OsnNPxQC5sYCGdZEu/VEcjBnDXUODbJXfRia9QfswUNlcNj9x5usXtZHNtj
 WbDbTu9XXtIrOoMAvKAHp3wa4DFNHiMPVefo0DDgz2GNuQplbYmGQsp50/nPyT3IfMUt
 AZADzUycL2l6ODIy8IjLnglId/vcyUQIdLB8DpXnMXsotIXqF4sACVFV4/Bihcuts9mn
 GNq5EeXJ49wd2ASxVRpYf1O6iIayc7h12hkrfH5NXKW1K7coNBoh2sgvjRqmEKzvDs9z
 F9KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752165764; x=1752770564;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MSh6kbv+hR1zb7kg6e6a3Btjfbls58Zvj3ges5YQbBI=;
 b=l4DJaMa2+yAxvIKyl3uyMQT+LxEY5U61tcctgys18aeAOrAi1CKtYpCIYQ8gQ+2hqi
 9ysU709rUH7q/XhpGeA0yMnLVswnVEHrszsoVXxZpadAUkrrzIBIc3bt9i575APed1T0
 5UxMOk65k3phd67ysxMjNrvLmSSd5DjibyOssJAhWAGNf/pLDGT9UJmvIMe3wJl1gH2J
 xqCgXvVeiaVow3kkC0Frf20rWZh6878+6oBQZIgtN9M9li4qLF3MpTsjeZViK/unknzJ
 JVhF2Ahhvj89zc0GUg0gJL+l7fqi6ygjWv9QJwg8N6g0/kb8W0Rgo/i+poB8baxbKA0Z
 GNmQ==
X-Gm-Message-State: AOJu0Yzbb89kSmOBVOLDAm3R2JStUH1flJkz5tO+Mf9AlwrcQRGvY12S
 wsFeUXYhZc3eqdJhY9NPnhS4WP5QMB9V0q2jCGUKPRowHnvCpfCV57e9x4jnYnr4nEn5VIbOzwE
 5ZQAv
X-Gm-Gg: ASbGncsneFVFJrVRw9CHlLJNjJG8ERP1uEou/z0qJJXdmbnzCpZqhpoQef4N+kREFHF
 ntf7gYWpcKKbad0xFOUahfY5VnvF89cL0ctNsNda3eaHxYmuWiLEnggMwtaQQWt76TYt67UnBWj
 88bfIDu0e+cgVxexXifUBYzSZCLuKZpS/Ifjf10ItzdHUR+yPvDdFWO5oEXriy7Q0VbC/rNKbKf
 qSmUxhDv5mFd6x/YoBd+cjxcmVzzK9OndBqvByp3S8/fYyldd0EHnCL4UOebec5w1UjDqBLl0ow
 8uYU88hLS6hZ6LRehx8Wn74eq93PjnRHB16kJcGtmBBT/wn4sNWB4Z2f3CBZOh91hw2xywfzPnj
 8N3sX4p74LLKMAdNhcY96VutqwUuGWy90pnyH
X-Google-Smtp-Source: AGHT+IEuJy3ZMRaCbHMnZ+xV8v8leZbFzdnxv6lHvNtQUA6//iIHPVFHd1pzH53jm1ZxCSPsQx2fhQ==
X-Received: by 2002:a05:6214:3909:b0:702:ca9e:dba6 with SMTP id
 6a1803df08f44-704a33f1602mr973786d6.16.1752165763871; 
 Thu, 10 Jul 2025 09:42:43 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-704979b49b3sm10167966d6.30.2025.07.10.09.42.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Jul 2025 09:42:43 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH v3 02/13] test: add test for hotplug and secondary process
 operations
Date: Thu, 10 Jul 2025 09:16:43 -0700
Message-ID: <20250710164237.8630-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250710164237.8630-1-stephen@networkplumber.org>
References: <0250411234927.114568-1-stephen@networkplumber.org>
 <20250710164237.8630-1-stephen@networkplumber.org>
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

