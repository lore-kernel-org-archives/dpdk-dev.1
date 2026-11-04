Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48321606A31B
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Nov 2026 15:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=O4jCw5I1
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4D1F740B8F;
	Wed,  4 Nov 2026 16:15:42 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTPS id 1BC1940A79
 for <dev@dpdk.org>; Wed,  4 Nov 2026 16:15:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793805339; x=1825341339;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Goy96QDYMUb7LYdKA8e5f7e708ES3/PtsPWDmH3/ax0=;
 b=O4jCw5I1e7t9dtWjOSudo8jbEtG/RjVs/aGryUWkAH4zf0r1Fj06WIGd
 EjjInRBLpk7WAvH0fxbA/6a+uellq7ohyRZUAf/suJ1QT3hAqttC1BN2b
 YZlfA34ynvH17sC0MVXuZ977qXStl+QmMMk1Cx7LuB7CrUCdYo0iCD8Zf
 vXoESszMWGRfsgZuFaAj20t+ISt6g8306LjTCVGYk0bLewwoRRSVWoNdC
 Vc6VtLDcAq8f3NBrITyDWwIdremj2sqdikvmJOPAWQH2Cgb2Z0uVCZT4g
 rF48uK67RC8DC6e63kpnS925MA5MakTRsqn3ASnD8tMYZlD7G9Ifvjc0R Q==;
X-CSE-ConnectionGUID: ypeH9g5xQD6eoRn7nzJobA==
X-CSE-MsgGUID: ifwN6HNvS1OKy4JCM9Xyxg==
X-IronPort-AV: E=McAfee;i="6800,10657,11955"; a="2437336"
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="2437336"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2026 07:15:37 -0800
X-CSE-ConnectionGUID: rvdLFAAORwWqyZxCB5VCdQ==
X-CSE-MsgGUID: vEb5FXlRT/O9k8/MTtsH9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="7093771"
Received: from silpixa00401385.ir.intel.com ([10.20.227.220])
 by fmviesa006.fm.intel.com with ESMTP; 04 Nov 2026 07:15:35 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH 2/3] kernel/nic_uio: support Linux format PCI addresses
Date: Wed,  4 Nov 2026 15:15:23 +0000
Message-ID: <20261104151524.3990486-3-bruce.richardson@intel.com>
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

For consistency with linux and with DPDK EAL -a/-b parameters which take
PCI devices in Linux BDF format, allow nic_uio to also accept the device
specifiers in that format. In the process, also support taking the domain
specifier for both linux-format and bsd-format cases.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 doc/guides/freebsd_gsg/build_dpdk.rst |   8 ++
 kernel/freebsd/nic_uio/nic_uio.c      | 185 ++++++++++++++++++--------
 2 files changed, 141 insertions(+), 52 deletions(-)

diff --git a/doc/guides/freebsd_gsg/build_dpdk.rst b/doc/guides/freebsd_gsg/build_dpdk.rst
index 9dafa64e84..20d4a63246 100644
--- a/doc/guides/freebsd_gsg/build_dpdk.rst
+++ b/doc/guides/freebsd_gsg/build_dpdk.rst
@@ -228,12 +228,20 @@ kernel environment variable prior to loading ``nic_uio``, as follows::
 
 Where a comma separated list of selectors is set, the list must not contain any
 whitespace.
+Selectors can use colon-separated decimal FreeBSD addresses (``b:d:f`` or ``pciD:b:d:f``)
+or fixed-width hexadecimal Linux/DPDK addresses with final "." separator (``bb:dd.f`` or ``dddd:bb:dd.f``).
+An omitted domain is zero.
+Invalid selectors cause module loading to fail before any devices are detached.
 
 For example to re-bind ``ix2@pci0:2:0:0`` and ``ix3@pci0:2:0:1`` to the ``nic_uio`` module
 upon loading, use the following command::
 
     kenv hw.nic_uio.bdfs="2:0:0,2:0:1"
 
+The equivalent DPDK addresses can also be used::
+
+    kenv hw.nic_uio.bdfs="02:00.0,02:00.1"
+
 The variable can also be specified during boot by placing the following into
 ``/boot/loader.conf``, before the previously-described ``nic_uio_load`` line - as
 shown:
diff --git a/kernel/freebsd/nic_uio/nic_uio.c b/kernel/freebsd/nic_uio/nic_uio.c
index 0043892870..7260a2a2f6 100644
--- a/kernel/freebsd/nic_uio/nic_uio.c
+++ b/kernel/freebsd/nic_uio/nic_uio.c
@@ -9,6 +9,7 @@ __FBSDID("$FreeBSD$");
 #include <sys/kernel.h> /* types used in module initialization */
 #include <sys/conf.h> /* cdevsw struct */
 #include <sys/bus.h> /* structs, prototypes for pci bus stuff and DEVMETHOD */
+#include <sys/ctype.h>
 #include <sys/rman.h>
 #include <sys/systm.h>
 #include <sys/lock.h>
@@ -73,11 +74,110 @@ struct device {
 };
 
 struct pci_bdf {
+	uint32_t domain;
 	uint32_t bus;
 	uint32_t devid;
 	uint32_t function;
 };
 
+
+static int
+nic_uio_parse_bdf_linux(const char *token, const size_t token_len, unsigned long *values)
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
+			if (!isxdigit(token[i]))
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
+static int
+nic_uio_parse_bdf_bsd(const char *token, const size_t token_len, unsigned long *values)
+{
+	char *endptr;
+
+	/* skip the "pci" prefix if present */
+	if (strncmp(token, "pci", 3) == 0) {
+		token += 3;
+		if (!isdigit(*token))
+			return EINVAL;
+
+		values[0] = strtoul(token, &endptr, 10);
+		if (*endptr != ':' || !isdigit(*(endptr + 1)))
+			return EINVAL;
+		token = endptr + 1;
+	} else if (!isdigit(*token))
+		return EINVAL;
+
+	/* parse bus */
+	values[1] = strtoul(token, &endptr, 10);
+	if (*endptr != ':' || !isdigit(*(endptr + 1)))
+		return EINVAL;
+	token = endptr + 1;
+	/* parse device */
+	values[2] = strtoul(token, &endptr, 10);
+	if (*endptr != ':' || !isdigit(*(endptr + 1)))
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
+static int
+nic_uio_parse_bdf(char *token, struct pci_bdf *bdf)
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
+			nic_uio_parse_bdf_linux(token, token_len, values) :
+			nic_uio_parse_bdf_bsd(token, token_len, values);
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
 DEFINE_CLASS_0(nic_uio, nic_uio_driver, nic_uio_methods, sizeof(struct nic_uio_softc));
 
 #if __FreeBSD_version < 1400000
@@ -152,6 +252,7 @@ static int
 nic_uio_probe (device_t dev)
 {
 	int i;
+	unsigned int domain = pci_get_domain(dev);
 	unsigned int bus = pci_get_bus(dev);
 	unsigned int device = pci_get_slot(dev);
 	unsigned int function = pci_get_function(dev);
@@ -161,7 +262,8 @@ nic_uio_probe (device_t dev)
 
 	/* First check if we found this on load */
 	for (i = 0; i < num_detached; i++)
-		if (bus == pci_get_bus(detached_devices[i]) &&
+		if (domain == pci_get_domain(detached_devices[i]) &&
+		    bus == pci_get_bus(detached_devices[i]) &&
 		    device == pci_get_slot(detached_devices[i]) &&
 		    function == pci_get_function(detached_devices[i])) {
 			device_set_desc(dev, "DPDK PCI Device");
@@ -172,25 +274,17 @@ nic_uio_probe (device_t dev)
 	memset(bdf_str, 0, sizeof(bdf_str));
 	TUNABLE_STR_FETCH("hw.nic_uio.bdfs", bdf_str, sizeof(bdf_str));
 	remaining = bdf_str;
-	while (1) {
-		if (remaining == NULL || remaining[0] == '\0')
-			break;
-		token = strsep(&remaining, ",:");
-		if (token == NULL)
-			break;
-		bus = strtol(token, NULL, 10);
-		token = strsep(&remaining, ",:");
-		if (token == NULL)
-			break;
-		device = strtol(token, NULL, 10);
-		token = strsep(&remaining, ",:");
-		if (token == NULL)
-			break;
-		function = strtol(token, NULL, 10);
-
-		if (bus == pci_get_bus(dev) &&
-				device == pci_get_slot(dev) &&
-				function == pci_get_function(dev)) {
+	while (remaining != NULL && remaining[0] != '\0') {
+		struct pci_bdf bdf;
+
+		token = strsep(&remaining, ",");
+		if (nic_uio_parse_bdf(token, &bdf) != 0) {
+			device_printf(dev, "Invalid PCI address in hw.nic_uio.bdfs\n");
+			return ENXIO;
+		}
+
+		if (bdf.domain == domain && bdf.bus == bus &&
+				bdf.devid == device && bdf.function == function) {
 
 			if (num_detached < MAX_DETACHED_DEVICES) {
 				printf("%s: probed dev=%p\n",
@@ -256,10 +350,11 @@ nic_uio_detach(device_t dev)
 	return 0;
 }
 
-static void
+static int
 nic_uio_load(void)
 {
-	uint32_t bus, device, function;
+	struct pci_bdf bdfs[MAX_DETACHED_DEVICES];
+	unsigned int count = 0;
 	device_t dev;
 	char bdf_str[256];
 	char *token, *remaining;
@@ -268,34 +363,20 @@ nic_uio_load(void)
 	TUNABLE_STR_FETCH("hw.nic_uio.bdfs", bdf_str, sizeof(bdf_str));
 	remaining = bdf_str;
 	printf("nic_uio: hw.nic_uio.bdfs = '%s'\n", bdf_str);
-	/*
-	 * Users should specify PCI BDFs in the format "b:d:f,b:d:f,b:d:f".
-	 *  But the code below does not try differentiate between : and ,
-	 *  and just blindly uses 3 tokens at a time to construct a
-	 *  bus/device/function tuple.
-	 *
-	 * There is no checking on strtol() return values, but this should
-	 *  be OK.  Worst case is it cannot convert and returns 0.  This
-	 *  could give us a different BDF than intended, but as long as the
-	 *  PCI device/vendor ID does not match it will not matter.
-	 */
-	while (1) {
-		if (remaining == NULL || remaining[0] == '\0')
-			break;
-		token = strsep(&remaining, ",:");
-		if (token == NULL)
-			break;
-		bus = strtol(token, NULL, 10);
-		token = strsep(&remaining, ",:");
-		if (token == NULL)
-			break;
-		device = strtol(token, NULL, 10);
-		token = strsep(&remaining, ",:");
-		if (token == NULL)
-			break;
-		function = strtol(token, NULL, 10);
-
-		dev = pci_find_bsf(bus, device, function);
+	while (remaining != NULL && remaining[0] != '\0') {
+		token = strsep(&remaining, ",");
+		if (count == nitems(bdfs) || nic_uio_parse_bdf(token, &bdfs[count]) != 0 ||
+				(remaining != NULL && remaining[0] == '\0')) {
+			printf("nic_uio: invalid PCI address list in hw.nic_uio.bdfs\n");
+			return EINVAL;
+		}
+		count++;
+	}
+
+	for (unsigned int i = 0; i < count; i++) {
+		const struct pci_bdf *bdf = &bdfs[i];
+
+		dev = pci_find_dbsf(bdf->domain, bdf->bus, bdf->devid, bdf->function);
 		if (dev == NULL)
 			continue;
 
@@ -309,6 +390,7 @@ nic_uio_load(void)
 		}
 		device_detach(dev);
 	}
+	return 0;
 }
 
 static void
@@ -339,8 +421,7 @@ nic_uio_modevent(module_t mod, int type, void *arg)
 
 	switch (type) {
 	case MOD_LOAD:
-		nic_uio_load();
-		break;
+		return nic_uio_load();
 	case MOD_UNLOAD:
 		nic_uio_unload();
 		break;
-- 
2.55.0

