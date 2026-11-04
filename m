Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C032606D804
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Nov 2026 15:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=nUTtTFVk
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1F8FD40B9E;
	Wed,  4 Nov 2026 16:15:43 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTPS id B179640B8F
 for <dev@dpdk.org>; Wed,  4 Nov 2026 16:15:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793805341; x=1825341341;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=YK+K+49NwrbqYw2EDStDuKhneIMuQLNKkKLoAZ1ixqA=;
 b=nUTtTFVkRtQTe0Gb4bkvP6ii7bpDGuiSzosk7qAY/lhTYBj/GgUYCtP+
 ki8a0OxNpgbfnvWHufUaJCkv9aMFEbDawpw8g41Zjgq1ewgeSkDJ5nYEf
 U8BSFNPrg/HYZfmsP2pMKxy49Lfmkm3eXadOt+1seg5hkzuIfrzMSy8kg
 jPmEcOxxS6Ei37wAYb51BLQ/TLy9Y552wnQaLMFs1Zo8moB2XrIq2xT1M
 2Jd9kW0I/kK/NeZHU8epjljHtpzQTAOP5kM7bRl+dwdKKdginlitpvABE
 K6lp1GBv/Hzel233SXcVPk6iJTeMKoNPR+sCmdYwjNvtJKxqCq5jzi/qk A==;
X-CSE-ConnectionGUID: dOSMRbc/RoK34rPr6536iQ==
X-CSE-MsgGUID: 8456ttQ9Q9qF24+HM7pu5A==
X-IronPort-AV: E=McAfee;i="6800,10657,11955"; a="2437345"
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="2437345"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2026 07:15:39 -0800
X-CSE-ConnectionGUID: bhculXQpQRC6ZbFqn9uD3Q==
X-CSE-MsgGUID: NRJie79BRFW9N4khdNCDAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="7093776"
Received: from silpixa00401385.ir.intel.com ([10.20.227.220])
 by fmviesa006.fm.intel.com with ESMTP; 04 Nov 2026 07:15:37 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH 3/3] app/test: add unit tests for nic_uio BDF parsing fns
Date: Wed,  4 Nov 2026 15:15:24 +0000
Message-ID: <20261104151524.3990486-4-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261104151524.3990486-1-bruce.richardson@intel.com>
References: <20261104151524.3990486-1-bruce.richardson@intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Move the BDF parsing functions from nic_uio into a separate header which
allows us to unit test them as independent functions, verifying that
both BSD and Linux format PCI addresses are supported.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 app/test/meson.build               |   1 +
 app/test/test_kmod_pci_bdf.c       | 142 +++++++++++++++++++++++++++++
 kernel/freebsd/nic_uio/meson.build |   2 +-
 kernel/freebsd/nic_uio/nic_uio.c   | 112 +----------------------
 kernel/freebsd/nic_uio/pci_bdf.h   | 129 ++++++++++++++++++++++++++
 5 files changed, 277 insertions(+), 109 deletions(-)
 create mode 100644 app/test/test_kmod_pci_bdf.c
 create mode 100644 kernel/freebsd/nic_uio/pci_bdf.h

diff --git a/app/test/meson.build b/app/test/meson.build
index 51abeeb732..a5d4716650 100644
--- a/app/test/meson.build
+++ b/app/test/meson.build
@@ -104,6 +104,7 @@ source_file_deps = {
     'test_ipsec.c': ['bus_vdev', 'net', 'cryptodev', 'ipsec', 'security'],
     'test_ipsec_perf.c': ['net', 'ipsec'],
     'test_ipsec_sad.c': ['ipsec'],
+    'test_kmod_pci_bdf.c': [],
     'test_kvargs.c': ['kvargs'],
     'test_latencystats.c': ['ethdev', 'latencystats', 'metrics'] + sample_packet_forward_deps,
     'test_lcore_var.c': [],
diff --git a/app/test/test_kmod_pci_bdf.c b/app/test/test_kmod_pci_bdf.c
new file mode 100644
index 0000000000..41d5c9e442
--- /dev/null
+++ b/app/test/test_kmod_pci_bdf.c
@@ -0,0 +1,142 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2026 Intel Corporation
+ */
+
+#include <rte_common.h>
+
+#include "../../kernel/freebsd/nic_uio/pci_bdf.h"
+#include "test.h"
+
+static int
+test_kmod_pci_bdf_valid(void)
+{
+	static const struct {
+		const char *address;
+		struct pci_bdf expected;
+	} cases[] = {
+		{"0:0:0", {0, 0, 0, 0}},
+		{"42:0:0", {0, 42, 0, 0}},
+		{"177:31:7", {0, 177, 31, 7}},
+		{"255:31:7", {0, 255, 31, 7}},
+		{"pci0:0:0:0", {0, 0, 0, 0}},
+		{"pci1:177:31:7", {1, 177, 31, 7}},
+		{"pci65535:255:31:7", {65535, 255, 31, 7}},
+		{"00:00.0", {0, 0, 0, 0}},
+		{"42:00.0", {0, 0x42, 0, 0}},
+		{"ff:1f.7", {0, 255, 31, 7}},
+		{"FF:1F.7", {0, 255, 31, 7}},
+		{"0000:00:00.0", {0, 0, 0, 0}},
+		{"0000:98:00.1", {0, 0x98, 0, 1}},
+		{"0001:b1:1f.7", {1, 0xb1, 31, 7}},
+		{"aBcD:Ab:0F.3", {0xabcd, 0xab, 15, 3}},
+		{"ffff:ff:1f.7", {65535, 255, 31, 7}},
+	};
+
+	for (size_t i = 0; i < RTE_DIM(cases); i++) {
+		struct pci_bdf actual = {UINT32_MAX, UINT32_MAX, UINT32_MAX, UINT32_MAX};
+		const struct pci_bdf *expected = &cases[i].expected;
+		const char *address = cases[i].address;
+
+		TEST_ASSERT_SUCCESS(pci_bdf_parse(address, &actual),
+				"Rejected valid address '%s'", address);
+		TEST_ASSERT_EQUAL(actual.domain, expected->domain,
+				"Incorrect domain for '%s'", address);
+		TEST_ASSERT_EQUAL(actual.bus, expected->bus,
+				"Incorrect bus for '%s'", address);
+		TEST_ASSERT_EQUAL(actual.devid, expected->devid,
+				"Incorrect device for '%s'", address);
+		TEST_ASSERT_EQUAL(actual.function, expected->function,
+				"Incorrect function for '%s'", address);
+	}
+	return TEST_SUCCESS;
+}
+
+static int
+test_kmod_pci_bdf_invalid(void)
+{
+	static const char * const cases[] = {
+		"",
+		"0",
+		"0:0",
+		":0:00",
+		"42::0",
+		"42:0:",
+		"42:0:0:0",
+		"42:0:0,43:0:0",
+		"pci",
+		"pci:42:0:0",
+		"pci0::0:0",
+		"pci0:42::0",
+		"pci0:42:0:",
+		"pci0:42:0:0:0",
+		"+42:0:0",
+		"-0:0:0",
+		"42:+0:0",
+		"42:0:-0",
+		"pci+1:42:0:0",
+		"pci-0:42:0:0",
+		" 42:0:0",
+		"42: 0:0",
+		"42:0:0 ",
+		"42:0:0\n",
+		"42:0:0junk",
+		"pci0:af:0:0",
+		"af:0:0",
+		"0x42:0:0",
+		"256:0:0",
+		"0:32:0",
+		"0:0:8",
+		"pci65536:0:0:0",
+		"65578:0:0",
+		"pci65536:42:0:0",
+		"99999999999999999999999999999999999999:0:0",
+		"0000:42:0:0",
+		"pci0:42:00.0",
+		"0000:152:00.0",
+		"0000:42:000.0",
+		"0000:42:00.000",
+		"00000:42:00.0",
+		"0:42:00.0",
+		"42:0.0",
+		"42:00.",
+		"42.00:0",
+		"42.00.0",
+		"0000:gg:00.0",
+		"0000:00:20.0",
+		"0000:00:00.8",
+		"0000:00:00.f",
+		"0000:00:00.0junk",
+		"\xff:00.0",
+	};
+	const struct pci_bdf sentinel = {1, 2, 3, 4};
+
+	for (size_t i = 0; i < RTE_DIM(cases); i++) {
+		struct pci_bdf actual = sentinel;
+		const char *address = cases[i];
+
+		TEST_ASSERT_EQUAL(pci_bdf_parse(address, &actual), EINVAL,
+				"Did not reject invalid address '%s' with EINVAL", address);
+		TEST_ASSERT(actual.domain == sentinel.domain && actual.bus == sentinel.bus &&
+				actual.devid == sentinel.devid &&
+				actual.function == sentinel.function,
+				"Modified output for invalid address '%s'", address);
+	}
+	return TEST_SUCCESS;
+}
+
+static struct unit_test_suite kmod_pci_bdf_testsuite = {
+	.suite_name = "Kernel module PCI BDF parsing",
+	.unit_test_cases = {
+		TEST_CASE(test_kmod_pci_bdf_valid),
+		TEST_CASE(test_kmod_pci_bdf_invalid),
+		TEST_CASES_END(),
+	},
+};
+
+static int
+test_kmod_pci_bdf(void)
+{
+	return unit_test_suite_runner(&kmod_pci_bdf_testsuite);
+}
+
+REGISTER_FAST_TEST(kmod_pci_bdf_autotest, NOHUGE_OK, ASAN_OK, test_kmod_pci_bdf);
diff --git a/kernel/freebsd/nic_uio/meson.build b/kernel/freebsd/nic_uio/meson.build
index 4bdaf96944..f10a8a7913 100644
--- a/kernel/freebsd/nic_uio/meson.build
+++ b/kernel/freebsd/nic_uio/meson.build
@@ -1,4 +1,4 @@
 # SPDX-License-Identifier: BSD-3-Clause
 # Copyright(c) 2017 Intel Corporation
 
-sources = files('nic_uio.c')
+sources = files('nic_uio.c', 'pci_bdf.h')
diff --git a/kernel/freebsd/nic_uio/nic_uio.c b/kernel/freebsd/nic_uio/nic_uio.c
index 7260a2a2f6..92865e296d 100644
--- a/kernel/freebsd/nic_uio/nic_uio.c
+++ b/kernel/freebsd/nic_uio/nic_uio.c
@@ -9,7 +9,6 @@ __FBSDID("$FreeBSD$");
 #include <sys/kernel.h> /* types used in module initialization */
 #include <sys/conf.h> /* cdevsw struct */
 #include <sys/bus.h> /* structs, prototypes for pci bus stuff and DEVMETHOD */
-#include <sys/ctype.h>
 #include <sys/rman.h>
 #include <sys/systm.h>
 #include <sys/lock.h>
@@ -25,6 +24,8 @@ __FBSDID("$FreeBSD$");
 #include <vm/vm_page.h>
 #include <vm/vm_pager.h>
 
+/* the PCI BDF parsing functions are kept separate so we can unit test them from userspace */
+#include "pci_bdf.h"
 
 #define MAX_BARS (PCIR_MAX_BAR_0 + 1)
 
@@ -73,111 +74,6 @@ struct device {
     int dev;
 };
 
-struct pci_bdf {
-	uint32_t domain;
-	uint32_t bus;
-	uint32_t devid;
-	uint32_t function;
-};
-
-
-static int
-nic_uio_parse_bdf_linux(const char *token, const size_t token_len, unsigned long *values)
-{
-	static const char *long_fmt = "FFFF:FF:FF.F";
-	static const char *short_fmt = "FF:FF.F";
-	const char *fmt = NULL;
-	int bus_ofs = 0;
-
-	if (token_len == strlen(long_fmt))
-		fmt = long_fmt;
-	else if (token_len == strlen(short_fmt))
-		fmt = short_fmt;
-	else
-		return EINVAL;
-
-	/* validate the token against the expected format */
-	for (size_t i = 0; i < token_len; i++)
-		if (fmt[i] == 'F') {
-			if (!isxdigit(token[i]))
-				return EINVAL;
-		} else if (token[i] != fmt[i])
-			return EINVAL;
-
-	if (fmt == long_fmt) {
-		values[0] = strtoul(token, NULL, 16);
-		bus_ofs = 5;
-	}
-	values[1] = strtoul(token + bus_ofs, NULL, 16);
-	values[2] = strtoul(token + bus_ofs + 3, NULL, 16);
-	values[3] = strtoul(token + bus_ofs + 6, NULL, 16);
-	return 0;
-}
-
-static int
-nic_uio_parse_bdf_bsd(const char *token, const size_t token_len, unsigned long *values)
-{
-	char *endptr;
-
-	/* skip the "pci" prefix if present */
-	if (strncmp(token, "pci", 3) == 0) {
-		token += 3;
-		if (!isdigit(*token))
-			return EINVAL;
-
-		values[0] = strtoul(token, &endptr, 10);
-		if (*endptr != ':' || !isdigit(*(endptr + 1)))
-			return EINVAL;
-		token = endptr + 1;
-	} else if (!isdigit(*token))
-		return EINVAL;
-
-	/* parse bus */
-	values[1] = strtoul(token, &endptr, 10);
-	if (*endptr != ':' || !isdigit(*(endptr + 1)))
-		return EINVAL;
-	token = endptr + 1;
-	/* parse device */
-	values[2] = strtoul(token, &endptr, 10);
-	if (*endptr != ':' || !isdigit(*(endptr + 1)))
-		return EINVAL;
-	token = endptr + 1;
-	/* parse function */
-	values[3] = strtoul(token, &endptr, 10);
-	if (*endptr != '\0')
-		return EINVAL;
-
-	return 0;
-}
-
-static int
-nic_uio_parse_bdf(char *token, struct pci_bdf *bdf)
-{
-	static const unsigned long bdf_field_limits[4] = {UINT16_MAX, 255, 31, 7};
-	const size_t token_len = strlen(token);
-	unsigned long values[4] = {0};
-
-	if (token_len < 5)
-		return EINVAL;
-
-	/* linux uses '.' for final separator */
-	int ret = token[token_len - 2] == '.' ?
-			nic_uio_parse_bdf_linux(token, token_len, values) :
-			nic_uio_parse_bdf_bsd(token, token_len, values);
-	if (ret != 0)
-		return ret;
-
-	for (int i = 0; i < 4; i++)
-		if (values[i] > bdf_field_limits[i])
-			return EINVAL;
-
-	bdf->domain = values[0];
-	bdf->bus = values[1];
-	bdf->devid = values[2];
-	bdf->function = values[3];
-	return 0;
-}
-
 DEFINE_CLASS_0(nic_uio, nic_uio_driver, nic_uio_methods, sizeof(struct nic_uio_softc));
 
 #if __FreeBSD_version < 1400000
@@ -278,7 +174,7 @@ nic_uio_probe (device_t dev)
 		struct pci_bdf bdf;
 
 		token = strsep(&remaining, ",");
-		if (nic_uio_parse_bdf(token, &bdf) != 0) {
+		if (pci_bdf_parse(token, &bdf) != 0) {
 			device_printf(dev, "Invalid PCI address in hw.nic_uio.bdfs\n");
 			return ENXIO;
 		}
@@ -365,7 +261,7 @@ nic_uio_load(void)
 	printf("nic_uio: hw.nic_uio.bdfs = '%s'\n", bdf_str);
 	while (remaining != NULL && remaining[0] != '\0') {
 		token = strsep(&remaining, ",");
-		if (count == nitems(bdfs) || nic_uio_parse_bdf(token, &bdfs[count]) != 0 ||
+		if (count == nitems(bdfs) || pci_bdf_parse(token, &bdfs[count]) != 0 ||
 				(remaining != NULL && remaining[0] == '\0')) {
 			printf("nic_uio: invalid PCI address list in hw.nic_uio.bdfs\n");
 			return EINVAL;
diff --git a/kernel/freebsd/nic_uio/pci_bdf.h b/kernel/freebsd/nic_uio/pci_bdf.h
new file mode 100644
index 0000000000..8115c0f435
--- /dev/null
+++ b/kernel/freebsd/nic_uio/pci_bdf.h
@@ -0,0 +1,129 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2026 Intel Corporation
+ */
+
+#ifndef _PCI_BDF_H_
+#define _PCI_BDF_H_
+
+#ifdef _KERNEL
+#include <sys/param.h>
+#include <sys/ctype.h>
+#include <sys/errno.h>
+#include <sys/systm.h>
+#else
+#include <ctype.h>
+#include <errno.h>
+#include <stdint.h>
+#include <stdlib.h>
+#include <string.h>
+#endif
+
+struct pci_bdf {
+	uint32_t domain;
+	uint32_t bus;
+	uint32_t devid;
+	uint32_t function;
+};
+
+static inline int
+pci_bdf_parse_linux(const char *token, const size_t token_len, unsigned long *values)
+{
+	static const char *long_fmt = "FFFF:FF:FF.F";
+	static const char *short_fmt = "FF:FF.F";
+	const char *fmt = NULL;
+	int bus_ofs = 0;
+
+	if (token_len == strlen(long_fmt))
+		fmt = long_fmt;
+	else if (token_len == strlen(short_fmt))
+		fmt = short_fmt;
+	else
+		return EINVAL;
+
+	/* validate the token against the expected format */
+	for (size_t i = 0; i < token_len; i++)
+		if (fmt[i] == 'F') {
+			if (!isxdigit((unsigned char)token[i]))
+				return EINVAL;
+		} else if (token[i] != fmt[i])
+			return EINVAL;
+
+	if (fmt == long_fmt) {
+		values[0] = strtoul(token, NULL, 16);
+		bus_ofs = 5;
+	}
+	values[1] = strtoul(token + bus_ofs, NULL, 16);
+	values[2] = strtoul(token + bus_ofs + 3, NULL, 16);
+	values[3] = strtoul(token + bus_ofs + 6, NULL, 16);
+	return 0;
+}
+
+static inline int
+pci_bdf_parse_bsd(const char *token, unsigned long *values)
+{
+	char *endptr;
+
+	/* skip the "pci" prefix if present */
+	if (strncmp(token, "pci", 3) == 0) {
+		token += 3;
+		if (!isdigit((unsigned char)*token))
+			return EINVAL;
+
+		values[0] = strtoul(token, &endptr, 10);
+		if (*endptr != ':' || !isdigit((unsigned char)*(endptr + 1)))
+			return EINVAL;
+		token = endptr + 1;
+	} else if (!isdigit((unsigned char)*token))
+		return EINVAL;
+
+	/* parse bus */
+	values[1] = strtoul(token, &endptr, 10);
+	if (*endptr != ':' || !isdigit((unsigned char)*(endptr + 1)))
+		return EINVAL;
+	token = endptr + 1;
+	/* parse device */
+	values[2] = strtoul(token, &endptr, 10);
+	if (*endptr != ':' || !isdigit((unsigned char)*(endptr + 1)))
+		return EINVAL;
+	token = endptr + 1;
+	/* parse function */
+	values[3] = strtoul(token, &endptr, 10);
+	if (*endptr != '\0')
+		return EINVAL;
+
+	return 0;
+}
+
+/*
+ * Parse a hexadecimal DPDK or decimal FreeBSD PCI address.
+ * Return zero on success or EINVAL on failure, leaving bdf unchanged on failure.
+ */
+static inline int
+pci_bdf_parse(const char *token, struct pci_bdf *bdf)
+{
+	static const unsigned long bdf_field_limits[4] = {UINT16_MAX, 255, 31, 7};
+	const size_t token_len = strlen(token);
+	unsigned long values[4] = {0};
+
+	if (token_len < 5)
+		return EINVAL;
+
+	/* linux uses '.' for final separator */
+	int ret = token[token_len - 2] == '.' ?
+			pci_bdf_parse_linux(token, token_len, values) :
+			pci_bdf_parse_bsd(token, values);
+	if (ret != 0)
+		return ret;
+
+	for (int i = 0; i < 4; i++)
+		if (values[i] > bdf_field_limits[i])
+			return EINVAL;
+
+	bdf->domain = values[0];
+	bdf->bus = values[1];
+	bdf->devid = values[2];
+	bdf->function = values[3];
+	return 0;
+}
+
+#endif /* _PCI_BDF_H_ */
-- 
2.55.0

