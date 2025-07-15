Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 522EDC83F22
	for <dpdk-dev@archiver.kernel.org>; Tue, 15 Jul 2025 16:17:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 313C340647;
	Tue, 15 Jul 2025 18:17:11 +0200 (CEST)
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com
 [209.85.219.45]) by mails.dpdk.org (Postfix) with ESMTP id 95BF54064C
 for <dev@dpdk.org>; Tue, 15 Jul 2025 18:17:09 +0200 (CEST)
Received: by mail-qv1-f45.google.com with SMTP id
 6a1803df08f44-6fa980d05a8so42463876d6.2
 for <dev@dpdk.org>; Tue, 15 Jul 2025 09:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1752596229;
 x=1753201029; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MSh6kbv+hR1zb7kg6e6a3Btjfbls58Zvj3ges5YQbBI=;
 b=YesOY5Yl7S31WUJJg3D9f2jVxWnp2nfvNfxPmvq1o5dcr/uFpqNIIJ32hewBQWK8/9
 Oz2nlH8+VuRdHNWsvWFFhvTNxjbLx3eBmNEIOJVYz6aBrxe16ve2+FdsNy5KUOil/Y9Y
 8fkKZT04ZEaFcKoB/4zc5X/grHEz26445202IHnnb86AplskQEmgdj4w9uRdfxfdMHfq
 OckuiX4uC+AsVqdiWK9WE+6JnIbr2snqoAeHYclxOFJVzPxWzrk7mNCaI+cGQFCv/hTP
 z7kFHB+DPKo9rj/FvD1KsNOBZwr3sSGn5AEjajdHIe88o0BPy9QTYXjxLQNdW5u+uPV6
 PaBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752596229; x=1753201029;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MSh6kbv+hR1zb7kg6e6a3Btjfbls58Zvj3ges5YQbBI=;
 b=O4+Z1tbJdnP5IUFddalsR9Agd8W1gmiJXthOm6BO94/zv0zeWzkRvsK1wqGjhfcAEN
 Kby1JXnR1RKM8Ic44QQEn2GYYoGU2MjToQwPoHktUvMKmGgeMUwTdMOJojxrQpDHH7pJ
 ++y2b761PtOy0ok9Gh900B4/Zd93cQxia8dfIesKrwzxrk5JKrpTk+XvVhGPsrkV5P5J
 fVL3UC44fA6cLgUybAqR9cZ/P5A2ltq3BbQLqHImzK0+S5pePHS6vqE5HFgKhtGVYOIL
 Sp+BXwzphiGttFDDythf7I47Oy/P+U6lWNZh2RnZ1LIiW3nCiIqJvyVqdqxJROcAUrkd
 /e5Q==
X-Gm-Message-State: AOJu0YzaHeWQaXh3rw56HlfzvxRNrwYtxCmiTeZqhLFJaxYa/OAF7LNZ
 m5aDwAJpaj/lqdhgUKVf1ijIuKLFwjEK56YXZ4Xh7HKfMCr1fQFNSHNSkNBCRq27Qg+JTpWuOLy
 ck9Wk
X-Gm-Gg: ASbGncvzBNAG2PP/gOlKDNqG2FO5XatZBXeFDe8CJqal6IYazZCJ2+m8i4KvrVYjRrc
 rhQ0ujrPMcj3mp1gvvzcrKyufhGBSKI9fc4faWlymf7a0/N+c2Zh/YQH6DsvondlfRqFQoNluaN
 NonATXQKnIwV16PrhL1PJTxd6dGs7akigpcJc6eFen+3ZD3N6LI5wB/hSwt1KepAHgyVBkjLqf9
 d9Fzupto5WvC7c+cH9KV6lGpYRVsmYHw9NJBe+wOZItJNJmk8uP52J241np48oUjTRs+TlFiTWj
 f8KLeeZ3OC6Vhgg2+kvW6noaFMfmdr7eBeVPCbgzvVzedDxt3kIieYEAk8VB6G3K0scQZSHPSG7
 1Bor5IhQprxX3yLOyXi3AfE+GAHK5uaF6k0drOV9MdtT7VcWcpy9mWtjDfSCLLvoO85/VadlA
X-Google-Smtp-Source: AGHT+IEpX1L00BJZzmiha8QzwWQKj/mjWd38DzKIABejvOkwNsVlP1+cZY06lcj9SmCNbGEaJPnB+Q==
X-Received: by 2002:a05:6214:2e41:b0:704:8315:4cfa with SMTP id
 6a1803df08f44-704f48419dbmr1278816d6.16.1752596228632; 
 Tue, 15 Jul 2025 09:17:08 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-704979a8857sm59985106d6.9.2025.07.15.09.17.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Jul 2025 09:17:08 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH v4 03/13] test: add test for hotplug and secondary process
 operations
Date: Tue, 15 Jul 2025 09:15:41 -0700
Message-ID: <20250715161700.103209-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250715161700.103209-1-stephen@networkplumber.org>
References: <20250411234927.114568-1-stephen@networkplumber.org>
 <20250715161700.103209-1-stephen@networkplumber.org>
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

