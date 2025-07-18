Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0CC0C83F17
	for <dpdk-dev@archiver.kernel.org>; Fri, 18 Jul 2025 16:37:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B955A40DDD;
	Fri, 18 Jul 2025 18:37:52 +0200 (CEST)
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com
 [209.85.214.172])
 by mails.dpdk.org (Postfix) with ESMTP id E117540DCA
 for <dev@dpdk.org>; Fri, 18 Jul 2025 18:37:51 +0200 (CEST)
Received: by mail-pl1-f172.google.com with SMTP id
 d9443c01a7336-234b440afa7so22801185ad.0
 for <dev@dpdk.org>; Fri, 18 Jul 2025 09:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1752856671;
 x=1753461471; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MSh6kbv+hR1zb7kg6e6a3Btjfbls58Zvj3ges5YQbBI=;
 b=EKqqCIlAPLiPkZnWSwG0ThtZY5Yr0VBwSsDPZImE38C346Fz9lJ5e9Y6kp3t4TdHy4
 3xdVTnxgZHgUyrmGgV1EpJa/7kFJAWtF6Qsa6QEYkI908lBt8dSx8dqbFnc9I5Yl93RW
 FD7YvsMHIpFaYtLRZ1DgnIZTzVpSTtLdflD0ijfgTT7kuiIZCq+dS4Ca/z+c4KfrwBIq
 H/8r+ySMiO51BBUIXjCtbrAIpYmpy0gUnAd1YklAr4JZBTe2CnbolzMfS+PvqG51OZfa
 rnM0mBP6Alfz0hTRIBQWq7E78hl35yv+UIh7gl1zvgrGk9DPNUvqEsEUe9v591KCEWk3
 QNcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752856671; x=1753461471;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MSh6kbv+hR1zb7kg6e6a3Btjfbls58Zvj3ges5YQbBI=;
 b=ocdgdmLgWk9OhFNofhYewXhP7F97LUSfy1F8doKgiqtW4Gjno2RtADffmXNjrh6MwW
 Rfo0lrv2IrEOw+8qbm0brGCFRHjjj1dZrE49oRN2hsYnsNPUsukJ2IXtKSwmaEmTvJ+0
 YLsj1/LKqhcbKUBOQ0TeKHufKBxIMoaPub2kS1Ipn5VMpE+9ABxVG3v1ApO2xVbdp1Nv
 A0ZAK4VHNr/Fr37AwbWqYzd4kqIftVPNARpLpHbhi+XJAMn3xBYEtUNP1rZQ2NhkGF0p
 jP3p/Rz7tlu8Rsj+AaKk0imHsAMMbBxS4PsIfLDdXAgAI2OOZeD6MSt4ProTixBAmzt7
 dhwg==
X-Gm-Message-State: AOJu0YwrPsm4jn8CG6nkafhKRx/zS4XoeVZnpw3N6o9I91VEKzQIN/Th
 bw8nCghmOvjIvZWg+pezoc6zkSatlgPG2k/kC6fGnWKRJXucgzYZI5kjmVIagUAYX/xn6f0cslP
 Cga7L
X-Gm-Gg: ASbGncuk2ksvpqoQT9Ij+mUEQwiuvTisj654UPt0k4NyNU0nT3dhr7uQA9vXuwhruc5
 n3AQxGE53u0AnGHgZtxYH15t+gehdkdzkBauemuCCT6MhQtggmuMJIUOQ8RuBYUh4MAquIDU5fC
 gcY2g55Z8yA/c/dqUFnygF/7aUodNLob1ZnE4qfjKL97dE0HNuosPydZECJ0pY9tShlxJ74ZVZ9
 pT+T3ruWwldngF6N0Nk1/THIu/tPVhxlM115wWDXbpLlywuFXBkxQZwH4z7MIeYOjrmlrG/dpbb
 1PKRKMBqaYl3vEaTHHM01GyIlI67R+eYWQNGjMGQEeOJfjQMTBwMvX+oG3+9piw0aRusx4ShzvR
 SYKyfQxFlVE9zj61D1ziRMKvgbPJudVKtOobvlxy+VdYLD8Ubkdrq8bztt/E918dzs2z9VJcC
X-Google-Smtp-Source: AGHT+IE53T7mEZZJYnlSc+Oorc0RUPsbFI72Q5RbF1nU6vpesLJqa4wOx7nk1KevTynJO4iqDXc13w==
X-Received: by 2002:a05:620a:1727:b0:7d3:90b3:28f with SMTP id
 af79cd13be357-7e34d8bfd35mr1240518785a.5.1752856367764; 
 Fri, 18 Jul 2025 09:32:47 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7e356cc1aa8sm103392685a.111.2025.07.18.09.32.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Jul 2025 09:32:47 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH v5 03/13] test: add test for hotplug and secondary process
 operations
Date: Fri, 18 Jul 2025 09:28:20 -0700
Message-ID: <20250718163236.9870-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250718163236.9870-1-stephen@networkplumber.org>
References: <20250411234927.114568-1-stephen@networkplumber.org>
 <20250718163236.9870-1-stephen@networkplumber.org>
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

