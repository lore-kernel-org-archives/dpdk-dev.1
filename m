Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0364C83F1A
	for <dpdk-dev@archiver.kernel.org>; Tue, 22 Jul 2025 17:36:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C3EDD4003C;
	Tue, 22 Jul 2025 19:36:04 +0200 (CEST)
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com
 [209.85.222.180])
 by mails.dpdk.org (Postfix) with ESMTP id 0FAD040647
 for <dev@dpdk.org>; Tue, 22 Jul 2025 19:36:01 +0200 (CEST)
Received: by mail-qk1-f180.google.com with SMTP id
 af79cd13be357-7e62773cab8so52160185a.1
 for <dev@dpdk.org>; Tue, 22 Jul 2025 10:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1753205760;
 x=1753810560; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MSh6kbv+hR1zb7kg6e6a3Btjfbls58Zvj3ges5YQbBI=;
 b=Apbuk4CUJTSLRrMWjmQx8NhOJLuq7M5Eiz0Z60PaVpur4XhBwF491V0Ufo3EhdKZ8c
 N2RYIo8400tuoEeuckjDEmh8VqYmToKSgL7NCdSShZnd68WmN65mKdBhAgmChn/DYA+j
 MwrUo9tR7tTcywTWxUzmkm/k2AzsDPsGxlplPVC1oiLaJmgWj7y8o0sqsRWLjgi0YJCg
 0bRVdJYhH2dRMyummpHxilqLKauTUkdgvtI7N4T8QYQE7tUTkVGyR7V4uc4ct6Lhmu2L
 5CwWEZeM6n6Wj/TDilmyGxSvyopxPWfdC1/xFREyjS3f8tLirqMqwvE9FHrutUxlY2SE
 +edQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753205760; x=1753810560;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MSh6kbv+hR1zb7kg6e6a3Btjfbls58Zvj3ges5YQbBI=;
 b=e4GXsmwY4dKyz/nXHVgcni7KGzhuiLtxS2QrASFaFFYO+XyT9r91f6HUxeUejYByWH
 rVFqMUzCyRoNIqpOe23X/i+jlIZLq+FWvodPZh7l9tUpvvFRbnM6Qymc1BVCH7SYG4co
 CW3Q4TcnGq4HonjZ5E54AHxtMSWiUBI+EqU6wpMLz3RqbgHyxVTP+PGifvSpPwExHxau
 +cCWQfXAfGbmem01BxrZrZjssV4Qe1gFlj0qEK9q5u7BPAVm8QBSIHY+D08neq9twimb
 ZxUc8jdOV9ofKGhMweVCX7gPn2qJnWsgZQYrXQ1/rXZ8s3Vg1C+qYFX2EqMrcsQn+dtX
 kZLw==
X-Gm-Message-State: AOJu0YxgYHlUZm/kvJwycf8eT/Y8/QkWwmP5PX3gbtn8gEPLb6eLHPs8
 boumVj945FIVa0q/547lglJQKJh2c96Fy3GE4ME6dMnq7ddwrLDF56lVAbAzGAoZe+dutU6IjIR
 2yfW0
X-Gm-Gg: ASbGncvn1E2u39ScBd41KFfOXEWdzC2dHhZv9gpBv+/VNX7+bpwKObDuPSJ+Qw0lXrY
 rAt6qU87TwjX5iKGOFKMCxh0/ejfZRk00Mc6vsYtwT9ce0TmjrmBagZg7/nVL735GyrclzVxzTl
 QXR2NII4wdaNxRstWdfwtEnAFpZBI/OB7Lido7i74xiN1xLQrZoiuiwt0AJEorXKaO+Zl34AW0h
 SDQmm89kRwa4xZxgjZ2eG8fadoH1ErKD+D5g26/6bmjae/xn2wKXjJZsO5nj1qB0teJEXs+x/8u
 lZ0ZPr8PGEYa6mGq5XOGKjiEFgUWt8B1+fZR3edgKgOCFM1mOaGo0ehDQIQU1A81JULIg1C+tQN
 QT9wi+2EkQ8m1IzYFfYjrq1ewuQSYdCQK2oMNM0Po2YDXhRg16OnF17o7/ZVHOPDmvRcwjm0b
X-Google-Smtp-Source: AGHT+IHaefLcELgMSmEseWbC5XxLUqbheFVB6BxEX0xcxySAm889ITpCWN2GMIo/nT+nXq6Qg3df4A==
X-Received: by 2002:ae9:e906:0:b0:7e3:52f6:66e5 with SMTP id
 af79cd13be357-7e62a1a4528mr12443085a.35.1753205760336; 
 Tue, 22 Jul 2025 10:36:00 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7e356b282aasm552155885a.14.2025.07.22.10.35.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Jul 2025 10:35:59 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH v6 03/13] test: add test for hotplug and secondary process
 operations
Date: Tue, 22 Jul 2025 10:34:34 -0700
Message-ID: <20250722173552.184141-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250722173552.184141-1-stephen@networkplumber.org>
References: <20250411234927.114568-1-stephen@networkplumber.org>
 <20250722173552.184141-1-stephen@networkplumber.org>
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

