Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24390C88E72
	for <dpdk-dev@archiver.kernel.org>; Mon, 14 Sep 2026 17:37:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 13DBA40EDD;
	Mon, 14 Sep 2026 19:37:21 +0200 (CEST)
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com
 [209.85.210.176])
 by mails.dpdk.org (Postfix) with ESMTP id 3676740A7F
 for <dev@dpdk.org>; Mon, 14 Sep 2026 19:37:20 +0200 (CEST)
Received: by mail-pf1-f176.google.com with SMTP id
 d2e1a72fcca58-86a25369f16so2801100b3a.3
 for <dev@dpdk.org>; Mon, 14 Sep 2026 10:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789407439;
 x=1790012239; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Vd0eDL/c78Bf0wUJZ1oajpFF829u/QxA68ajXRC/eYo=;
 b=a1XoqNTeyLSjnUuP/rf2xlLV6HyArCVgVOaRFHtYtuYtYp4Zo5zWnD6DbcNjgFiftd
 1B+zaufvXipzaubT+hveAZ6Xb9HxHbxOm2qCrn8gSB7AB6e0BORZfcYwnVjF68AI6s0k
 DynTDc84gdeYS6R+FVg6i0yTg4IEUkjeiGWt7KSOUjq9IXJelz+JpHraMLZuZSts4GQ4
 qxooK10PFVdDORjP0fc52P+J7C7XH6kQBXjInZb3T4FRHZp32EKRT3fz8JmoG4Y2AJwi
 uDYLw+tnmU8RUAg5xw1E0pWU7iD65tvOeNOgUSOUZlz2M3+tlfkBwSJtxCeyaWFRhOAR
 anvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789407439; x=1790012239;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Vd0eDL/c78Bf0wUJZ1oajpFF829u/QxA68ajXRC/eYo=;
 b=L+xfBoR334JacH6VYpBUWHAUpfnAH9hGLCQMZBx8okIUQeKv2Tt/kGSTOeqA2cUAS+
 RhBfuNgk86ZV62mAC1DTBMx0yvu7S3Ip1sZHhuKqSXgl8eORR7msshzuaj0FAGGa8JxI
 poK046kOKL7LFzICkVIl73dElde+k81MefCm+hG/eRx3L4Eu7y7GJ49MZ9dc/AqzBgCg
 +G8yJJyxvAUqN9Y1RRkuMMbpDrU0otzdMDRJ2fv3z0vYKdPAXccXHeFmLLUtvsNmlWgs
 OFTVnCLKTwvE4jhAiLUlwV4TqaqJw5BMY8BqyHWKwW22e5dC0Cxi8AMZ92IVwPpv4yFe
 SHCA==
X-Gm-Message-State: AFuF++kqhFRayrYdJPGn1m5PlcZhB5AAoGDhHbM8/t7Ogkrt/2sELYOg
 VsbjBc8pzQJyMbY+WToAwlUdQKl783e54RvrFiK3VS+F+4yAoTRBwWZxWLI04gxGy1TrqcXi8dS
 ERPrEkWxkNQ==
X-Gm-Gg: AYBFou279X+YRHXG74JsP2rubnNEdku0IdeaF7nmIW2N8yRbs4vVOHziVvu7s9fmVaL
 H+HJabS+KrUZ1gVF4dEQ0jehu1JWj2lV6YzOuuVz2H6oa5c05Acp6iFZXJNEdNH6eGncaGZzU3r
 n40NRDJDHkssEqkYggimYbBijKNXNCu5V/+CxCCND7eeOwmDGOgL7PihC6N6k66FVDplEcS+FmD
 /73UktFnMtkTPp5CYAX055EOZaastesny4dJ+Ttv/6DhhkJUZu/S2bc6xBslj4P8WQq4lZHekfF
 O/uzsMEMSSwSdJsNq5+OgAP/B2WM0/GHAsT10+FfVhfW50pQ2spKx2YnqnJpThX8ZuRXOWi8tii
 zfWz/MIl3NG9lKBUqvaVS5uM6Yek9VnKk4iWOxZPTGp+fLYAK5DfIJF0MnzC03wWSg0FX9XmHUC
 B9mhiMjpWBcqPOVYJeynhYare8IlY4N/NWIK5kbNY/9JCILPMdV73mQJnEywV8YdTIMREkuNJQx
 kEcJLio3dg4QG5rtY1Hinl20nDw/X4ko+tJjLc=
X-Received: by 2002:a05:6a00:1916:b0:857:7317:cff6 with SMTP id
 d2e1a72fcca58-86f861d014dmr7120055b3a.23.1789407438823; 
 Mon, 14 Sep 2026 10:37:18 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-86b286c49d2sm5159867b3a.10.2026.09.14.10.37.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2026 10:37:18 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Parav Pandit <parav@nvidia.com>, Xueming Li <xuemingl@nvidia.com>,
 Nipun Gupta <nipun.gupta@amd.com>, Nikhil Agarwal <nikhil.agarwal@amd.com>,
 Chenbo Xia <chenbox@nvidia.com>, Tomasz Duszynski <tduszynski@marvell.com>,
 Long Li <longli@microsoft.com>, Wei Hu <weh@microsoft.com>,
 Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Kiran Kumar K <kirankumark@marvell.com>,
 Sunil Kumar Kori <skori@marvell.com>, Satha Rao <skoteshwar@marvell.com>,
 Harman Kalra <hkalra@marvell.com>,
 Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>,
 Bing Zhao <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>,
 Suanming Mou <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>,
 Ciara Loftus <ciara.loftus@intel.com>, Maryam Tahhan <mtahhan@redhat.com>
Subject: [PATCH v3 1/9] eal: add common sysfs value routines
Date: Mon, 14 Sep 2026 10:36:14 -0700
Message-ID: <20260914173700.2795983-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260914173700.2795983-1-stephen@networkplumber.org>
References: <20260912063319.4117869-1-stephen@networkplumber.org>
 <20260914173700.2795983-1-stephen@networkplumber.org>
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

Many drivers in DPDK read single values, and each one
open codes the same sequence: build a path with snprintf, open the
file, read a line, and convert it. Several drivers grew their own
private copy of that helper, and most of them parse with fscanf()
which cannot tell a failed conversion from a legitimate zero and
silently accepts trailing garbage.

Add a single set of routines in EAL that build the path from a
printf style format and do the conversion with strtoul()/strtol():

  rte_sysfs_parse_uint()    unsigned value
  rte_sysfs_parse_int()     signed value
  rte_sysfs_parse_string()  string value, newline stripped
  rte_sysfs_write_string()  write a string

rte_sysfs_vparse_uint() takes a va_list, so that a wrapper such
as the one in the power library can forward its arguments without
formatting the path a second time.

Folding the path construction into the routine removes the separate
snprintf() and its truncation check from every caller.

The signed variant exists because some attributes are genuinely
signed: numa_node is -1 when the device is not tied to a node.

These replace eal_parse_sysfs_value(), which was declared in the
internal eal_filesystem.h yet exported as a stable symbol, and was
reached by drivers through that private header.

sysfs is a Linux filesystem, so the implementation belongs in
lib/eal/linux rather than lib/eal/unix. That also settles the use
of strchrnul(), which is a GNU extension that FreeBSD only grew
recently. The declarations stay in lib/eal/include since they are
part of the driver SDK headers, and the test is skipped on the
platforms that no longer provide the routines.

Convert all of the existing callers.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/test/test_eal_fs.c                        | 148 ++++++++++----
 drivers/bus/auxiliary/linux/auxiliary.c       |  13 +-
 drivers/bus/cdx/cdx.c                         |   7 +-
 drivers/bus/pci/linux/pci.c                   |  44 ++--
 drivers/bus/platform/platform.c               |  10 +-
 drivers/bus/vmbus/linux/vmbus_bus.c           |  25 +--
 drivers/common/cnxk/roc_model.c               |  40 +---
 drivers/common/cnxk/roc_platform.h            |   3 +-
 .../common/mlx5/linux/mlx5_common_auxiliary.c |  13 +-
 drivers/net/af_xdp/rte_eth_af_xdp.c           |  13 +-
 lib/eal/common/eal_filesystem.h               |   4 +-
 lib/eal/include/meson.build                   |   1 +
 lib/eal/include/rte_sysfs.h                   | 125 ++++++++++++
 lib/eal/linux/eal_hugepage_info.c             |  33 +--
 lib/eal/linux/eal_lcore.c                     |  18 +-
 lib/eal/linux/eal_sysfs.c                     | 188 ++++++++++++++++++
 lib/eal/linux/meson.build                     |   1 +
 lib/eal/unix/eal_filesystem.c                 |  31 ---
 18 files changed, 503 insertions(+), 214 deletions(-)
 create mode 100644 lib/eal/include/rte_sysfs.h
 create mode 100644 lib/eal/linux/eal_sysfs.c

diff --git a/app/test/test_eal_fs.c b/app/test/test_eal_fs.c
index 62eea98677..d2e94ff0db 100644
--- a/app/test/test_eal_fs.c
+++ b/app/test/test_eal_fs.c
@@ -7,19 +7,21 @@
 #include <stdlib.h>
 #include <string.h>
 #include <errno.h>
+#include <limits.h>
+#include <unistd.h>
 
-#include "eal_filesystem.h"
-
-#ifdef RTE_EXEC_ENV_WINDOWS
+#ifndef RTE_EXEC_ENV_LINUX
 static int
 test_eal_fs(void)
 {
-	printf("eal_fs not supported on Windows, skipping test\n");
+	printf("sysfs is only available on Linux, skipping test\n");
 	return TEST_SKIPPED;
 }
 
 #else
 
+#include <rte_sysfs.h>
+
 static int
 test_parse_sysfs_value(void)
 {
@@ -30,13 +32,10 @@ test_parse_sysfs_value(void)
 	FILE *fd = NULL;
 	unsigned valid_number;
 	unsigned long retval = 0;
+	char strval[64];
+	long sretval = 0;
 
-#ifdef RTE_EXEC_ENV_FREEBSD
-	/* BSD doesn't have /proc/pid/fd */
-	return 0;
-#endif
-
-	printf("Testing function eal_parse_sysfs_value()\n");
+	printf("Testing sysfs value functions\n");
 
 	/* get a temporary filename to use for all tests - create temp file handle and then
 	 * use /proc to get the actual file that we can open */
@@ -54,8 +53,8 @@ test_parse_sysfs_value(void)
 
 	/* test we get an error value if we use file before it's created */
 	printf("Test reading a missing file ...\n");
-	if (eal_parse_sysfs_value("/dev/not-quite-null", &retval) == 0) {
-		printf("Error with eal_parse_sysfs_value() - returned success on reading empty file\n");
+	if (rte_sysfs_parse_uint(&retval, "/dev/not-quite-null") == 0) {
+		printf("rte_sysfs_parse_uint() returned success on a missing file - test failed\n");
 		goto error;
 	}
 	printf("Confirmed return error when reading empty file\n");
@@ -71,12 +70,12 @@ test_parse_sysfs_value(void)
 	fprintf(fd,"%u\n", valid_number);
 	fclose(fd);
 	fd = NULL;
-	if (eal_parse_sysfs_value(filename, &retval) < 0) {
-		printf("eal_parse_sysfs_value() returned error - test failed\n");
+	if (rte_sysfs_parse_uint(&retval, "%s", filename) < 0) {
+		printf("rte_sysfs_parse_uint() returned error - test failed\n");
 		goto error;
 	}
 	if (retval != valid_number) {
-		printf("Invalid value read by eal_parse_sysfs_value() - test failed\n");
+		printf("Invalid value read by rte_sysfs_parse_uint() - test failed\n");
 		goto error;
 	}
 	printf("Read '%u\\n' ok\n", valid_number);
@@ -91,43 +90,93 @@ test_parse_sysfs_value(void)
 	fprintf(fd,"0x%x\n", valid_number);
 	fclose(fd);
 	fd = NULL;
-	if (eal_parse_sysfs_value(filename, &retval) < 0) {
-		printf("eal_parse_sysfs_value() returned error - test failed\n");
+	if (rte_sysfs_parse_uint(&retval, "%s", filename) < 0) {
+		printf("rte_sysfs_parse_uint() returned error - test failed\n");
 		goto error;
 	}
 	if (retval != valid_number) {
-		printf("Invalid value read by eal_parse_sysfs_value() - test failed\n");
+		printf("Invalid value read by rte_sysfs_parse_uint() - test failed\n");
 		goto error;
 	}
 	printf("Read '0x%x\\n' ok\n", valid_number);
 
-	printf("Test reading invalid values ...\n");
+	/* a value without a trailing newline is accepted */
+	valid_number = 3;
+	fd = fopen(filename, "w");
+	if (fd == NULL) {
+		printf("line %d, Error opening %s: %s\n", __LINE__, filename, strerror(errno));
+		goto error;
+	}
+	fprintf(fd, "%u", valid_number);
+	fclose(fd);
+	fd = NULL;
+	if (rte_sysfs_parse_uint(&retval, "%s", filename) < 0 || retval != valid_number) {
+		printf("rte_sysfs_parse_uint() failed without trailing newline - test failed\n");
+		goto error;
+	}
+	printf("Read '%u' (no newline) ok\n", valid_number);
 
-	/* test reading an empty file - expect failure!*/
-	fd = fopen(filename,"w");
+	/* a negative value is rejected by the unsigned variant ... */
+	fd = fopen(filename, "w");
 	if (fd == NULL) {
 		printf("line %d, Error opening %s: %s\n", __LINE__, filename, strerror(errno));
 		goto error;
 	}
+	fprintf(fd, "-1\n");
 	fclose(fd);
 	fd = NULL;
-	if (eal_parse_sysfs_value(filename, &retval) == 0) {
-		printf("eal_parse_sysfs_value() read invalid value  - test failed\n");
+	if (rte_sysfs_parse_uint(&retval, "%s", filename) == 0) {
+		printf("rte_sysfs_parse_uint() accepted a negative value - test failed\n");
 		goto error;
 	}
 
-	/* test reading a valid number value *without* "\n" on the end - expect failure!*/
-	valid_number = 3;
+	/* ... and read correctly by the signed one, as for numa_node */
+	if (rte_sysfs_parse_int(&sretval, "%s", filename) < 0 || sretval != -1) {
+		printf("rte_sysfs_parse_int() failed to read -1 - test failed\n");
+		goto error;
+	}
+	printf("Read '-1' as signed ok\n");
+
+	/* string read strips the trailing newline */
+	fd = fopen(filename, "w");
+	if (fd == NULL) {
+		printf("line %d, Error opening %s: %s\n", __LINE__, filename, strerror(errno));
+		goto error;
+	}
+	fprintf(fd, "performance\n");
+	fclose(fd);
+	fd = NULL;
+	if (rte_sysfs_parse_string(strval, sizeof(strval), "%s", filename) < 0 ||
+			strcmp(strval, "performance") != 0) {
+		printf("rte_sysfs_parse_string() returned '%s' - test failed\n", strval);
+		goto error;
+	}
+	printf("Read 'performance' ok\n");
+
+	/* write it back and read it again */
+	if (rte_sysfs_write_string("powersave", "%s", filename) < 0) {
+		printf("rte_sysfs_write_string() returned error - test failed\n");
+		goto error;
+	}
+	if (rte_sysfs_parse_string(strval, sizeof(strval), "%s", filename) < 0 ||
+			strcmp(strval, "powersave") != 0) {
+		printf("read back '%s' after write - test failed\n", strval);
+		goto error;
+	}
+	printf("Wrote and read back 'powersave' ok\n");
+
+	printf("Test reading invalid values ...\n");
+
+	/* test reading an empty file - expect failure!*/
 	fd = fopen(filename,"w");
 	if (fd == NULL) {
 		printf("line %d, Error opening %s: %s\n", __LINE__, filename, strerror(errno));
 		goto error;
 	}
-	fprintf(fd,"%u", valid_number);
 	fclose(fd);
 	fd = NULL;
-	if (eal_parse_sysfs_value(filename, &retval) == 0) {
-		printf("eal_parse_sysfs_value() read invalid value  - test failed\n");
+	if (rte_sysfs_parse_uint(&retval, "%s", filename) == 0) {
+		printf("rte_sysfs_parse_uint() read invalid value  - test failed\n");
 		goto error;
 	}
 
@@ -141,8 +190,8 @@ test_parse_sysfs_value(void)
 	fprintf(fd,"%uJ\n", valid_number);
 	fclose(fd);
 	fd = NULL;
-	if (eal_parse_sysfs_value(filename, &retval) == 0) {
-		printf("eal_parse_sysfs_value() read invalid value  - test failed\n");
+	if (rte_sysfs_parse_uint(&retval, "%s", filename) == 0) {
+		printf("rte_sysfs_parse_uint() read invalid value  - test failed\n");
 		goto error;
 	}
 
@@ -155,14 +204,45 @@ test_parse_sysfs_value(void)
 	fprintf(fd,"error\n");
 	fclose(fd);
 	fd = NULL;
-	if (eal_parse_sysfs_value(filename, &retval) == 0) {
-		printf("eal_parse_sysfs_value() read invalid value  - test failed\n");
+	if (rte_sysfs_parse_uint(&retval, "%s", filename) == 0) {
+		printf("rte_sysfs_parse_uint() read invalid value  - test failed\n");
+		goto error;
+	}
+
+	/* test reading a negative value as unsigned - expect failure! */
+	fd = fopen(filename, "w");
+	if (fd == NULL) {
+		printf("line %d, Error opening %s: %s\n", __LINE__, filename, strerror(errno));
+		goto error;
+	}
+	fprintf(fd, "-1\n");
+	fclose(fd);
+	fd = NULL;
+	if (rte_sysfs_parse_uint(&retval, "%s", filename) == 0) {
+		printf("rte_sysfs_parse_uint() read negative value  - test failed\n");
+		goto error;
+	}
+
+	/*
+	 * Same, but with leading whitespace: strtoul() skips it before it
+	 * negates, so the sign has to be looked for past the whitespace.
+	 */
+	fd = fopen(filename, "w");
+	if (fd == NULL) {
+		printf("line %d, Error opening %s: %s\n", __LINE__, filename, strerror(errno));
+		goto error;
+	}
+	fprintf(fd, " -1\n");
+	fclose(fd);
+	fd = NULL;
+	if (rte_sysfs_parse_uint(&retval, "%s", filename) == 0) {
+		printf("rte_sysfs_parse_uint() read negative value  - test failed\n");
 		goto error;
 	}
 
 	close(tmp_file_handle);
 	unlink(filename);
-	printf("eal_parse_sysfs_value() - OK\n");
+	printf("sysfs value functions - OK\n");
 	return 0;
 
 error:
@@ -183,6 +263,6 @@ test_eal_fs(void)
 	return 0;
 }
 
-#endif /* !RTE_EXEC_ENV_WINDOWS */
+#endif /* RTE_EXEC_ENV_LINUX */
 
 REGISTER_FAST_TEST(eal_fs_autotest, NOHUGE_OK, ASAN_OK, test_eal_fs);
diff --git a/drivers/bus/auxiliary/linux/auxiliary.c b/drivers/bus/auxiliary/linux/auxiliary.c
index 3a2dca2865..c8d289eecb 100644
--- a/drivers/bus/auxiliary/linux/auxiliary.c
+++ b/drivers/bus/auxiliary/linux/auxiliary.c
@@ -9,6 +9,7 @@
 #include <rte_malloc.h>
 #include <rte_devargs.h>
 #include <rte_memcpy.h>
+#include <rte_sysfs.h>
 #include <eal_filesystem.h>
 
 #include "../private.h"
@@ -21,8 +22,7 @@ auxiliary_scan_one(const char *dirname, const char *name)
 {
 	struct rte_auxiliary_device *dev;
 	struct rte_auxiliary_device *dev2;
-	char filename[PATH_MAX];
-	unsigned long tmp;
+	long num;
 	int ret;
 
 	dev = malloc(sizeof(*dev));
@@ -36,12 +36,9 @@ auxiliary_scan_one(const char *dirname, const char *name)
 	}
 	dev->device.name = dev->name;
 
-	/* Get NUMA node, default to 0 if not present */
-	snprintf(filename, sizeof(filename), "%s/%s/numa_node",
-		 dirname, name);
-	if (access(filename, F_OK) == 0 &&
-	    eal_parse_sysfs_value(filename, &tmp) == 0)
-		dev->device.numa_node = tmp;
+	/* Get NUMA node, default to SOCKET_ID_ANY if not present */
+	if (rte_sysfs_parse_int(&num, "%s/%s/numa_node", dirname, name) == 0)
+		dev->device.numa_node = num;
 	else
 		dev->device.numa_node = SOCKET_ID_ANY;
 
diff --git a/drivers/bus/cdx/cdx.c b/drivers/bus/cdx/cdx.c
index c0b46a41ad..8cbe2473a9 100644
--- a/drivers/bus/cdx/cdx.c
+++ b/drivers/bus/cdx/cdx.c
@@ -74,6 +74,7 @@
 #include <rte_kvargs.h>
 #include <rte_malloc.h>
 #include <rte_vfio.h>
+#include <rte_sysfs.h>
 
 #include <eal_export.h>
 #include <eal_filesystem.h>
@@ -179,16 +180,14 @@ cdx_scan_one(const char *dirname, const char *dev_name)
 	}
 
 	/* get vendor id */
-	snprintf(filename, sizeof(filename), "%s/vendor", dirname);
-	if (eal_parse_sysfs_value(filename, &tmp) < 0) {
+	if (rte_sysfs_parse_uint(&tmp, "%s/vendor", dirname) < 0) {
 		ret = -1;
 		goto err;
 	}
 	dev->id.vendor_id = (uint16_t)tmp;
 
 	/* get device id */
-	snprintf(filename, sizeof(filename), "%s/device", dirname);
-	if (eal_parse_sysfs_value(filename, &tmp) < 0) {
+	if (rte_sysfs_parse_uint(&tmp, "%s/device", dirname) < 0) {
 		ret = -1;
 		goto err;
 	}
diff --git a/drivers/bus/pci/linux/pci.c b/drivers/bus/pci/linux/pci.c
index 9aae0a5d14..d40a09e78a 100644
--- a/drivers/bus/pci/linux/pci.c
+++ b/drivers/bus/pci/linux/pci.c
@@ -12,6 +12,7 @@
 #include <rte_devargs.h>
 #include <rte_memcpy.h>
 #include <rte_vfio.h>
+#include <rte_sysfs.h>
 
 #include <eal_export.h>
 #include "eal_filesystem.h"
@@ -205,6 +206,7 @@ pci_scan_one(const char *dirname, const struct rte_pci_addr *addr)
 {
 	char filename[PATH_MAX];
 	unsigned long tmp;
+	long num;
 	struct rte_pci_device_internal *pdev;
 	struct rte_pci_device *dev;
 	char driver[PATH_MAX];
@@ -221,43 +223,35 @@ pci_scan_one(const char *dirname, const struct rte_pci_addr *addr)
 	dev->addr = *addr;
 
 	/* get vendor id */
-	snprintf(filename, sizeof(filename), "%s/vendor", dirname);
-	if (eal_parse_sysfs_value(filename, &tmp) < 0) {
+	if (rte_sysfs_parse_uint(&tmp, "%s/vendor", dirname) < 0) {
 		pci_free(pdev);
 		return -1;
 	}
 	dev->id.vendor_id = (uint16_t)tmp;
 
 	/* get device id */
-	snprintf(filename, sizeof(filename), "%s/device", dirname);
-	if (eal_parse_sysfs_value(filename, &tmp) < 0) {
+	if (rte_sysfs_parse_uint(&tmp, "%s/device", dirname) < 0) {
 		pci_free(pdev);
 		return -1;
 	}
 	dev->id.device_id = (uint16_t)tmp;
 
 	/* get subsystem_vendor id */
-	snprintf(filename, sizeof(filename), "%s/subsystem_vendor",
-		 dirname);
-	if (eal_parse_sysfs_value(filename, &tmp) < 0) {
+	if (rte_sysfs_parse_uint(&tmp, "%s/subsystem_vendor", dirname) < 0) {
 		pci_free(pdev);
 		return -1;
 	}
 	dev->id.subsystem_vendor_id = (uint16_t)tmp;
 
 	/* get subsystem_device id */
-	snprintf(filename, sizeof(filename), "%s/subsystem_device",
-		 dirname);
-	if (eal_parse_sysfs_value(filename, &tmp) < 0) {
+	if (rte_sysfs_parse_uint(&tmp, "%s/subsystem_device", dirname) < 0) {
 		pci_free(pdev);
 		return -1;
 	}
 	dev->id.subsystem_device_id = (uint16_t)tmp;
 
 	/* get class_id */
-	snprintf(filename, sizeof(filename), "%s/class",
-		 dirname);
-	if (eal_parse_sysfs_value(filename, &tmp) < 0) {
+	if (rte_sysfs_parse_uint(&tmp, "%s/class", dirname) < 0) {
 		pci_free(pdev);
 		return -1;
 	}
@@ -266,25 +260,15 @@ pci_scan_one(const char *dirname, const struct rte_pci_addr *addr)
 
 	/* get max_vfs */
 	dev->max_vfs = 0;
-	snprintf(filename, sizeof(filename), "%s/max_vfs", dirname);
-	if (!access(filename, F_OK) &&
-	    eal_parse_sysfs_value(filename, &tmp) == 0)
+	if (rte_sysfs_parse_uint(&tmp, "%s/max_vfs", dirname) == 0)
+		dev->max_vfs = (uint16_t)tmp;
+	/* for non igb_uio driver, need kernel version >= 3.8 */
+	else if (rte_sysfs_parse_uint(&tmp, "%s/sriov_numvfs", dirname) == 0)
 		dev->max_vfs = (uint16_t)tmp;
-	else {
-		/* for non igb_uio driver, need kernel version >= 3.8 */
-		snprintf(filename, sizeof(filename),
-			 "%s/sriov_numvfs", dirname);
-		if (!access(filename, F_OK) &&
-		    eal_parse_sysfs_value(filename, &tmp) == 0)
-			dev->max_vfs = (uint16_t)tmp;
-	}
-
-	/* get numa node, default to 0 if not present */
-	snprintf(filename, sizeof(filename), "%s/numa_node", dirname);
 
-	if (access(filename, F_OK) == 0 &&
-	    eal_parse_sysfs_value(filename, &tmp) == 0)
-		dev->device.numa_node = tmp;
+	/* get numa node, default to SOCKET_ID_ANY if not present */
+	if (rte_sysfs_parse_int(&num, "%s/numa_node", dirname) == 0)
+		dev->device.numa_node = num;
 	else
 		dev->device.numa_node = SOCKET_ID_ANY;
 
diff --git a/drivers/bus/platform/platform.c b/drivers/bus/platform/platform.c
index 90d865a8df..9585fb79e9 100644
--- a/drivers/bus/platform/platform.c
+++ b/drivers/bus/platform/platform.c
@@ -24,6 +24,7 @@
 #include <rte_memory.h>
 #include <rte_string_fns.h>
 #include <rte_vfio.h>
+#include <rte_sysfs.h>
 
 #include "private.h"
 
@@ -49,8 +50,7 @@ static int
 dev_add(const char *dev_name)
 {
 	struct rte_platform_device *pdev, *tmp;
-	char path[PATH_MAX];
-	unsigned long val;
+	long val;
 
 	pdev = calloc(1, sizeof(*pdev));
 	if (pdev == NULL)
@@ -59,8 +59,10 @@ dev_add(const char *dev_name)
 	rte_strscpy(pdev->name, dev_name, sizeof(pdev->name));
 	pdev->device.name = pdev->name;
 	pdev->device.devargs = rte_bus_find_devargs(&platform_bus, dev_name);
-	snprintf(path, sizeof(path), PLATFORM_BUS_DEVICES_PATH "/%s/numa_node", dev_name);
-	pdev->device.numa_node = eal_parse_sysfs_value(path, &val) ? rte_socket_id() : val;
+	if (rte_sysfs_parse_int(&val, PLATFORM_BUS_DEVICES_PATH "/%s/numa_node", dev_name) == 0)
+		pdev->device.numa_node = val;
+	else
+		pdev->device.numa_node = rte_socket_id();
 
 	RTE_BUS_FOREACH_DEV(tmp, &platform_bus) {
 		if (!strcmp(tmp->name, pdev->name)) {
diff --git a/drivers/bus/vmbus/linux/vmbus_bus.c b/drivers/bus/vmbus/linux/vmbus_bus.c
index 779ea50b92..9ee7983eb6 100644
--- a/drivers/bus/vmbus/linux/vmbus_bus.c
+++ b/drivers/bus/vmbus/linux/vmbus_bus.c
@@ -19,6 +19,7 @@
 #include <rte_malloc.h>
 #include <rte_bus_vmbus.h>
 #include <rte_kvargs.h>
+#include <rte_sysfs.h>
 
 #include <eal_export.h>
 #include "eal_filesystem.h"
@@ -202,11 +203,8 @@ rte_vmbus_map_device(struct rte_vmbus_device *dev)
 			return -1;
 		}
 
-		snprintf(filename, sizeof(filename),
-			 "%s/size", dirname);
-		if (eal_parse_sysfs_value(filename, &len) < 0) {
-			VMBUS_LOG(ERR,
-				"could not read %s", filename);
+		if (rte_sysfs_parse_uint(&len, "%s/size", dirname) < 0) {
+			VMBUS_LOG(ERR, "could not read size of %s", dirname);
 			return -1;
 		}
 		res->len = len;
@@ -280,6 +278,7 @@ vmbus_scan_one(const char *name)
 	char filename[PATH_MAX];
 	char dirname[PATH_MAX];
 	unsigned long tmp;
+	long num;
 
 	dev = calloc(1, sizeof(*dev));
 	if (dev == NULL)
@@ -314,14 +313,12 @@ vmbus_scan_one(const char *name)
 		goto error;
 
 	/* get relid */
-	snprintf(filename, sizeof(filename), "%s/id", dirname);
-	if (eal_parse_sysfs_value(filename, &tmp) < 0)
+	if (rte_sysfs_parse_uint(&tmp, "%s/id", dirname) < 0)
 		goto error;
 	dev->relid = tmp;
 
 	/* get monitor id */
-	snprintf(filename, sizeof(filename), "%s/monitor_id", dirname);
-	if (eal_parse_sysfs_value(filename, &tmp) >= 0) {
+	if (rte_sysfs_parse_uint(&tmp, "%s/monitor_id", dirname) >= 0) {
 		dev->monitor_id = tmp;
 	} else {
 		VMBUS_LOG(NOTICE, "monitor disabled on %s", name);
@@ -333,14 +330,8 @@ vmbus_scan_one(const char *name)
 	dev->device.numa_node = SOCKET_ID_ANY;
 	if (vmbus_use_numa(dev)) {
 		/* get numa node (if present) */
-		snprintf(filename, sizeof(filename), "%s/numa_node",
-			 dirname);
-
-		if (access(filename, R_OK) == 0) {
-			if (eal_parse_sysfs_value(filename, &tmp) < 0)
-				goto error;
-			dev->device.numa_node = tmp;
-		}
+		if (rte_sysfs_parse_int(&num, "%s/numa_node", dirname) == 0)
+			dev->device.numa_node = num;
 	}
 
 	/* device is valid, add in list (sorted) */
diff --git a/drivers/common/cnxk/roc_model.c b/drivers/common/cnxk/roc_model.c
index f0312a5400..800e1ef013 100644
--- a/drivers/common/cnxk/roc_model.c
+++ b/drivers/common/cnxk/roc_model.c
@@ -105,20 +105,17 @@ is_rvu_device(unsigned long val)
 static int
 rvu_device_lookup(const char *dirname, uint32_t *part, uint32_t *pass)
 {
-	char filename[PATH_MAX];
 	unsigned long val;
 
 	/* Check if vendor id is cavium */
-	snprintf(filename, sizeof(filename), "%s/vendor", dirname);
-	if (plt_sysfs_value_parse(filename, &val) < 0)
+	if (plt_sysfs_value_parse(&val, "%s/vendor", dirname) < 0)
 		goto error;
 
 	if (val != PCI_VENDOR_ID_CAVIUM)
 		goto error;
 
 	/* Get device id  */
-	snprintf(filename, sizeof(filename), "%s/device", dirname);
-	if (plt_sysfs_value_parse(filename, &val) < 0)
+	if (plt_sysfs_value_parse(&val, "%s/device", dirname) < 0)
 		goto error;
 
 	/* Check if device ID belongs to any RVU device */
@@ -126,15 +123,13 @@ rvu_device_lookup(const char *dirname, uint32_t *part, uint32_t *pass)
 		goto error;
 
 	/* Get subsystem_device id */
-	snprintf(filename, sizeof(filename), "%s/subsystem_device", dirname);
-	if (plt_sysfs_value_parse(filename, &val) < 0)
+	if (plt_sysfs_value_parse(&val, "%s/subsystem_device", dirname) < 0)
 		goto error;
 
 	*part = val >> MODEL_CN10K_PART_SHIFT;
 
 	/* Get revision for pass value*/
-	snprintf(filename, sizeof(filename), "%s/revision", dirname);
-	if (plt_sysfs_value_parse(filename, &val) < 0)
+	if (plt_sysfs_value_parse(&val, "%s/revision", dirname) < 0)
 		goto error;
 
 	*pass = val & MODEL_CN10K_PASS_MASK;
@@ -230,31 +225,14 @@ populate_model(struct roc_model *model, uint32_t midr)
 static int
 midr_get(unsigned long *val)
 {
-	const char *file =
-		"/sys/devices/system/cpu/cpu0/regs/identification/midr_el1";
-	int rc = UTIL_ERR_FS;
-	char buf[BUFSIZ];
-	char *end = NULL;
-	FILE *f;
-
 	if (val == NULL)
-		goto err;
-	f = fopen(file, "r");
-	if (f == NULL)
-		goto err;
-
-	if (fgets(buf, sizeof(buf), f) == NULL)
-		goto fclose;
+		return UTIL_ERR_FS;
 
-	*val = strtoul(buf, &end, 0);
-	if ((buf[0] == '\0') || (end == NULL) || (*end != '\n'))
-		goto fclose;
+	if (plt_sysfs_value_parse(val,
+			"/sys/devices/system/cpu/cpu0/regs/identification/midr_el1") < 0)
+		return UTIL_ERR_FS;
 
-	rc = 0;
-fclose:
-	fclose(f);
-err:
-	return rc;
+	return 0;
 }
 
 static void
diff --git a/drivers/common/cnxk/roc_platform.h b/drivers/common/cnxk/roc_platform.h
index ac4f76473f..71f9d9a256 100644
--- a/drivers/common/cnxk/roc_platform.h
+++ b/drivers/common/cnxk/roc_platform.h
@@ -23,6 +23,7 @@
 #include <rte_seqcount.h>
 #include <rte_spinlock.h>
 #include <rte_string_fns.h>
+#include <rte_sysfs.h>
 #include <rte_tailq.h>
 #include <rte_telemetry.h>
 
@@ -109,7 +110,7 @@
 #define plt_pci_device		    rte_pci_device
 #define plt_pci_read_config	    rte_pci_read_config
 #define plt_pci_find_ext_capability rte_pci_find_ext_capability
-#define plt_sysfs_value_parse	    eal_parse_sysfs_value
+#define plt_sysfs_value_parse	    rte_sysfs_parse_uint
 
 #define plt_log2_u32	 rte_log2_u32
 #define plt_cpu_to_be_16 rte_cpu_to_be_16
diff --git a/drivers/common/mlx5/linux/mlx5_common_auxiliary.c b/drivers/common/mlx5/linux/mlx5_common_auxiliary.c
index 3ee2f4638a..07bb899f9e 100644
--- a/drivers/common/mlx5/linux/mlx5_common_auxiliary.c
+++ b/drivers/common/mlx5/linux/mlx5_common_auxiliary.c
@@ -10,6 +10,7 @@
 #include <rte_errno.h>
 #include <bus_auxiliary_driver.h>
 #include <rte_common.h>
+#include <rte_sysfs.h>
 #include <eal_export.h>
 #include "eal_filesystem.h"
 
@@ -93,16 +94,12 @@ mlx5_auxiliary_get_pci_str(const struct rte_auxiliary_device *dev,
 static int
 mlx5_auxiliary_get_numa(const struct rte_auxiliary_device *dev)
 {
-	unsigned long numa;
-	char numa_path[PATH_MAX];
+	char pci_path[PATH_MAX];
+	long numa;
 
-	if (mlx5_auxiliary_get_pci_path(dev, numa_path, sizeof(numa_path)) != 0)
+	if (mlx5_auxiliary_get_pci_path(dev, pci_path, sizeof(pci_path)) != 0)
 		return SOCKET_ID_ANY;
-	if (strcat(numa_path, "/numa_node") == NULL) {
-		rte_errno = ENAMETOOLONG;
-		return SOCKET_ID_ANY;
-	}
-	if (eal_parse_sysfs_value(numa_path, &numa) != 0) {
+	if (rte_sysfs_parse_int(&numa, "%s/numa_node", pci_path) != 0) {
 		rte_errno = EINVAL;
 		return SOCKET_ID_ANY;
 	}
diff --git a/drivers/net/af_xdp/rte_eth_af_xdp.c b/drivers/net/af_xdp/rte_eth_af_xdp.c
index 2cdb533276..9fc48e113b 100644
--- a/drivers/net/af_xdp/rte_eth_af_xdp.c
+++ b/drivers/net/af_xdp/rte_eth_af_xdp.c
@@ -38,6 +38,7 @@
 #include <rte_ring.h>
 #include <rte_spinlock.h>
 #include <rte_power_intrinsics.h>
+#include <rte_sysfs.h>
 
 #include "compat.h"
 #include "eal_filesystem.h"
@@ -2568,15 +2569,13 @@ rte_pmd_af_xdp_probe(struct rte_vdev_device *dev)
 
 	/* get numa node id from net sysfs */
 	if (dev->device.numa_node == SOCKET_ID_ANY) {
-		unsigned long numa = 0;
-		char numa_path[PATH_MAX];
+		long numa;
 
-		snprintf(numa_path, sizeof(numa_path), "/sys/class/net/%s/device/numa_node",
-			 if_name);
-		if (access(numa_path, R_OK) != 0 || eal_parse_sysfs_value(numa_path, &numa) != 0)
-			dev->device.numa_node = rte_socket_id();
-		else
+		if (rte_sysfs_parse_int(&numa, "/sys/class/net/%s/device/numa_node",
+					if_name) == 0)
 			dev->device.numa_node = numa;
+		else
+			dev->device.numa_node = rte_socket_id();
 	}
 
 	busy_budget = busy_budget == -1 ? ETH_AF_XDP_DFLT_BUSY_BUDGET :
diff --git a/lib/eal/common/eal_filesystem.h b/lib/eal/common/eal_filesystem.h
index 912f446f64..9859fe7241 100644
--- a/lib/eal/common/eal_filesystem.h
+++ b/lib/eal/common/eal_filesystem.h
@@ -128,8 +128,6 @@ eal_get_hugefile_list_seg_path(char *buffer, size_t buflen,
 /** define the default filename prefix for the %s values above */
 #define HUGEFILE_PREFIX_DEFAULT "rte"
 
-/** Function to read a single numeric value from a file on the filesystem.
- * Used to read information from files on /sys */
-int eal_parse_sysfs_value(const char *filename, unsigned long *val);
+/* Reading and writing of sysfs values is in <rte_sysfs.h> */
 
 #endif /* EAL_FILESYSTEM_H */
diff --git a/lib/eal/include/meson.build b/lib/eal/include/meson.build
index aef5824e5f..8c0a59f3d7 100644
--- a/lib/eal/include/meson.build
+++ b/lib/eal/include/meson.build
@@ -61,6 +61,7 @@ headers += files(
 driver_sdk_headers = files(
         'bus_driver.h',
         'dev_driver.h',
+        'rte_sysfs.h',
 )
 
 # special case install the generic headers, since they go in a subdir
diff --git a/lib/eal/include/rte_sysfs.h b/lib/eal/include/rte_sysfs.h
new file mode 100644
index 0000000000..b1efd06571
--- /dev/null
+++ b/lib/eal/include/rte_sysfs.h
@@ -0,0 +1,125 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2026 Stephen Hemminger
+ */
+
+#ifndef RTE_SYSFS_H
+#define RTE_SYSFS_H
+
+/**
+ * @file
+ * @internal
+ *
+ * Helpers to read and write single values in sysfs, used across DPDK.
+ *
+ * All of these build the path from a printf-style format, so that
+ * callers do not have to construct it separately.
+ */
+
+#include <stdarg.h>
+#include <stddef.h>
+
+#include <rte_common.h>
+#include <rte_compat.h>
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+#ifdef RTE_EXEC_ENV_LINUX
+
+/**
+ * Read an unsigned numeric value from a file, typically under /sys.
+ *
+ * The value is parsed with strtoul() using base 0, so decimal, octal
+ * and 0x-prefixed hexadecimal are all accepted. A negative value is
+ * rejected rather than wrapping; use rte_sysfs_parse_int() for the
+ * attributes that are signed.
+ *
+ * @param val
+ *   Where to store the parsed value, unmodified on failure.
+ * @param format
+ *   printf-style format describing the path to read.
+ * @return
+ *   0 on success, -1 on error.
+ */
+__rte_internal
+int rte_sysfs_parse_uint(unsigned long *val, const char *format, ...)
+__rte_format_printf(2, 3);
+
+/**
+ * Read an unsigned numeric value from a file, typically under /sys.
+ *
+ * As rte_sysfs_parse_uint(), but takes a va_list, so that a wrapper
+ * can forward its arguments without formatting the path itself.
+ *
+ * @param val
+ *   Where to store the parsed value, unmodified on failure.
+ * @param format
+ *   printf-style format describing the path to read.
+ * @param ap
+ *   Arguments for the format.
+ * @return
+ *   0 on success, -1 on error.
+ */
+__rte_internal
+int rte_sysfs_vparse_uint(unsigned long *val, const char *format, va_list ap)
+__rte_format_printf(2, 0);
+
+/**
+ * Read a signed numeric value from a file, typically under /sys.
+ *
+ * The value is parsed with strtol() using base 0. Some sysfs
+ * attributes are signed, most notably "numa_node" which is -1 when
+ * the device is not associated with any NUMA node.
+ *
+ * @param val
+ *   Where to store the parsed value, unmodified on failure.
+ * @param format
+ *   printf-style format describing the path to read.
+ * @return
+ *   0 on success, -1 on error.
+ */
+__rte_internal
+int rte_sysfs_parse_int(long *val, const char *format, ...)
+__rte_format_printf(2, 3);
+
+/**
+ * Read a string value from a file, typically under /sys.
+ *
+ * The trailing newline, if any, is stripped.
+ *
+ * @param buf
+ *   Where to store the NUL-terminated value. The contents are
+ *   indeterminate on failure.
+ * @param buflen
+ *   Size of buf, the value is truncated if it does not fit.
+ * @param format
+ *   printf-style format describing the path to read.
+ * @return
+ *   0 on success, -1 on error.
+ */
+__rte_internal
+int rte_sysfs_parse_string(char *buf, size_t buflen, const char *format, ...)
+__rte_format_printf(3, 4);
+
+/**
+ * Write a string value to a file, typically under /sys.
+ *
+ * @param str
+ *   The NUL-terminated value to write.
+ * @param format
+ *   printf-style format describing the path to write.
+ * @return
+ *   0 on success, -1 on error.
+ */
+__rte_internal
+int rte_sysfs_write_string(const char *str, const char *format, ...)
+__rte_format_printf(2, 3);
+
+#endif /* RTE_EXEC_ENV_LINUX */
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif /* RTE_SYSFS_H */
diff --git a/lib/eal/linux/eal_hugepage_info.c b/lib/eal/linux/eal_hugepage_info.c
index 05c5b3f613..9c05d86f6e 100644
--- a/lib/eal/linux/eal_hugepage_info.c
+++ b/lib/eal/linux/eal_hugepage_info.c
@@ -25,6 +25,7 @@
 #include <rte_debug.h>
 #include <rte_log.h>
 #include <rte_common.h>
+#include <rte_sysfs.h>
 #include "rte_string_fns.h"
 
 #include "eal_private.h"
@@ -68,18 +69,6 @@ create_shared_memory(const char *filename, const size_t mem_size)
 	return map_shared_memory(filename, mem_size, O_RDWR | O_CREAT);
 }
 
-static int get_hp_sysfs_value(const char *subdir, const char *file, unsigned long *val)
-{
-	char *path = NULL;
-	int ret;
-
-	if (asprintf(&path, "%s/%s/%s", sys_dir_path, subdir, file) < 0)
-		return -1;
-	ret = eal_parse_sysfs_value(path, val);
-	free(path);
-	return ret;
-}
-
 /* this function is only called from eal_hugepage_info_init which itself
  * is only called from a primary process */
 static uint32_t
@@ -92,16 +81,17 @@ get_num_hugepages(const char *subdir, size_t sz, unsigned int reusable_pages)
 	const char *nr_splus_file = "surplus_hugepages";
 
 	/* first, check how many reserved pages kernel reports */
-	if (get_hp_sysfs_value(subdir, nr_rsvd_file, &resv_pages) < 0)
+	if (rte_sysfs_parse_uint(&resv_pages, "%s/%s/%s", sys_dir_path, subdir, nr_rsvd_file) < 0)
 		return 0;
 
-	if (get_hp_sysfs_value(subdir, nr_hp_file, &num_pages) < 0)
+	if (rte_sysfs_parse_uint(&num_pages, "%s/%s/%s", sys_dir_path, subdir, nr_hp_file) < 0)
 		return 0;
 
-	if (get_hp_sysfs_value(subdir, nr_over_file, &over_pages) < 0)
+	if (rte_sysfs_parse_uint(&over_pages, "%s/%s/%s", sys_dir_path, subdir, nr_over_file) < 0)
 		over_pages = 0;
 
-	if (get_hp_sysfs_value(subdir, nr_splus_file, &surplus_pages) < 0)
+	if (rte_sysfs_parse_uint(&surplus_pages, "%s/%s/%s",
+			sys_dir_path, subdir, nr_splus_file) < 0)
 		surplus_pages = 0;
 
 	/* adjust num_pages */
@@ -138,7 +128,7 @@ get_num_hugepages(const char *subdir, size_t sz, unsigned int reusable_pages)
 static uint32_t
 get_num_hugepages_on_node(const char *subdir, unsigned int socket, size_t sz)
 {
-	char *path = NULL, *socketpath = NULL;
+	char *socketpath = NULL;
 	DIR *socketdir;
 	unsigned long num_pages = 0;
 	const char *nr_hp_file = "free_hugepages";
@@ -158,13 +148,7 @@ get_num_hugepages_on_node(const char *subdir, unsigned int socket, size_t sz)
 		goto nopages;
 	}
 
-	if (asprintf(&path, "%s/%s/%s", socketpath, subdir, nr_hp_file) < 0) {
-		EAL_LOG(ERR, "Can not format free hugepages path");
-		path = NULL;
-		goto nopages;
-	}
-
-	if (eal_parse_sysfs_value(path, &num_pages) < 0)
+	if (rte_sysfs_parse_uint(&num_pages, "%s/%s/%s", socketpath, subdir, nr_hp_file) < 0)
 		goto nopages;
 
 	if (num_pages == 0)
@@ -179,7 +163,6 @@ get_num_hugepages_on_node(const char *subdir, unsigned int socket, size_t sz)
 		num_pages = UINT32_MAX;
 
 nopages:
-	free(path);
 	free(socketpath);
 
 	return num_pages;
diff --git a/lib/eal/linux/eal_lcore.c b/lib/eal/linux/eal_lcore.c
index 29b36dd610..ada1c408f4 100644
--- a/lib/eal/linux/eal_lcore.c
+++ b/lib/eal/linux/eal_lcore.c
@@ -6,6 +6,7 @@
 #include <limits.h>
 
 #include <rte_log.h>
+#include <rte_sysfs.h>
 
 #include "eal_private.h"
 #include "eal_filesystem.h"
@@ -57,18 +58,13 @@ eal_cpu_socket_id(unsigned lcore_id)
 unsigned
 eal_cpu_core_id(unsigned lcore_id)
 {
-	char path[PATH_MAX];
 	unsigned long id;
 
-	int len = snprintf(path, sizeof(path), SYS_CPU_DIR "/%s", lcore_id, CORE_ID_FILE);
-	if (len <= 0 || (unsigned)len >= sizeof(path))
-		goto err;
-	if (eal_parse_sysfs_value(path, &id) != 0)
-		goto err;
-	return (unsigned)id;
+	if (rte_sysfs_parse_uint(&id, SYS_CPU_DIR "/%s", lcore_id, CORE_ID_FILE) != 0) {
+		EAL_LOG(ERR, "Error reading core id value from %s "
+				"for lcore %u - assuming core 0", SYS_CPU_DIR, lcore_id);
+		return 0;
+	}
 
-err:
-	EAL_LOG(ERR, "Error reading core id value from %s "
-			"for lcore %u - assuming core 0", SYS_CPU_DIR, lcore_id);
-	return 0;
+	return (unsigned int)id;
 }
diff --git a/lib/eal/linux/eal_sysfs.c b/lib/eal/linux/eal_sysfs.c
new file mode 100644
index 0000000000..a5e411585c
--- /dev/null
+++ b/lib/eal/linux/eal_sysfs.c
@@ -0,0 +1,188 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2026 Stephen Hemminger
+ */
+
+#include <ctype.h>
+#include <errno.h>
+#include <limits.h>
+#include <stdarg.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+
+#include <rte_log.h>
+#include <rte_sysfs.h>
+
+#include <eal_export.h>
+#include "eal_private.h"
+
+/* build the path from the format, then read the first line of that file */
+static int
+__rte_format_printf(3, 0)
+sysfs_read_line(char *buf, size_t buflen, const char *format, va_list ap)
+{
+	char path[PATH_MAX];
+	FILE *f;
+	int len;
+
+	len = vsnprintf(path, sizeof(path), format, ap);
+	if (len < 0 || len >= (int)sizeof(path)) {
+		EAL_LOG(ERR, "sysfs path too long");
+		return -1;
+	}
+
+	f = fopen(path, "r");
+	if (f == NULL) {
+		/*
+		 * A missing attribute is normal: callers probe for optional
+		 * ones such as max_vfs or numa_node. Anything else, such as
+		 * a permission problem, is worth reporting.
+		 */
+		if (errno == ENOENT)
+			EAL_LOG(DEBUG, "cannot open %s: %s", path, strerror(errno));
+		else
+			EAL_LOG(ERR, "cannot open %s: %s", path, strerror(errno));
+		return -1;
+	}
+
+	if (fgets(buf, buflen, f) == NULL) {
+		EAL_LOG(ERR, "cannot read %s", path);
+		fclose(f);
+		return -1;
+	}
+	fclose(f);
+
+	/* sysfs values are newline terminated, strip it */
+	*strchrnul(buf, '\n') = '\0';
+
+	return 0;
+}
+
+RTE_EXPORT_INTERNAL_SYMBOL(rte_sysfs_vparse_uint)
+int
+rte_sysfs_vparse_uint(unsigned long *val, const char *format, va_list ap)
+{
+	const char *start;
+	char buf[BUFSIZ];
+	unsigned long tmp;
+	char *end;
+
+	if (sysfs_read_line(buf, sizeof(buf), format, ap) < 0)
+		return -1;
+
+	/*
+	 * strtoul() skips leading whitespace and then silently negates a
+	 * leading '-', so " -1" would come back as ULONG_MAX. Look for the
+	 * sign past any whitespace: attributes that are really signed, such
+	 * as numa_node, must use rte_sysfs_parse_int() instead.
+	 */
+	start = buf;
+	while (isspace((unsigned char)*start))
+		++start;
+
+	errno = 0;
+	tmp = strtoul(start, &end, 0);
+	if (end == start || *end != '\0' || errno != 0 || *start == '-') {
+		EAL_LOG(ERR, "cannot parse sysfs value '%s'", buf);
+		return -1;
+	}
+
+	*val = tmp;
+	return 0;
+}
+
+RTE_EXPORT_INTERNAL_SYMBOL(rte_sysfs_parse_uint)
+int
+rte_sysfs_parse_uint(unsigned long *val, const char *format, ...)
+{
+	va_list ap;
+	int ret;
+
+	va_start(ap, format);
+	ret = rte_sysfs_vparse_uint(val, format, ap);
+	va_end(ap);
+
+	return ret;
+}
+
+RTE_EXPORT_INTERNAL_SYMBOL(rte_sysfs_parse_int)
+int
+rte_sysfs_parse_int(long *val, const char *format, ...)
+{
+	char buf[BUFSIZ];
+	va_list ap;
+	char *end;
+	long tmp;
+	int ret;
+
+	va_start(ap, format);
+	ret = sysfs_read_line(buf, sizeof(buf), format, ap);
+	va_end(ap);
+	if (ret < 0)
+		return -1;
+
+	errno = 0;
+	tmp = strtol(buf, &end, 0);
+	if (end == buf || *end != '\0' || errno != 0) {
+		EAL_LOG(ERR, "cannot parse sysfs value '%s'", buf);
+		return -1;
+	}
+
+	*val = tmp;
+	return 0;
+}
+
+RTE_EXPORT_INTERNAL_SYMBOL(rte_sysfs_parse_string)
+int
+rte_sysfs_parse_string(char *buf, size_t buflen, const char *format, ...)
+{
+	va_list ap;
+	int ret;
+
+	va_start(ap, format);
+	ret = sysfs_read_line(buf, buflen, format, ap);
+	va_end(ap);
+
+	return ret;
+}
+
+RTE_EXPORT_INTERNAL_SYMBOL(rte_sysfs_write_string)
+int
+rte_sysfs_write_string(const char *str, const char *format, ...)
+{
+	char path[PATH_MAX];
+	va_list ap;
+	FILE *f;
+	int len;
+
+	va_start(ap, format);
+	len = vsnprintf(path, sizeof(path), format, ap);
+	va_end(ap);
+	if (len < 0 || len >= (int)sizeof(path)) {
+		EAL_LOG(ERR, "sysfs path too long");
+		return -1;
+	}
+
+	f = fopen(path, "w");
+	if (f == NULL) {
+		if (errno == ENOENT)
+			EAL_LOG(DEBUG, "cannot open %s: %s", path, strerror(errno));
+		else
+			EAL_LOG(ERR, "cannot open %s: %s", path, strerror(errno));
+		return -1;
+	}
+
+	if (fputs(str, f) < 0) {
+		EAL_LOG(ERR, "cannot write '%s' to %s", str, path);
+		fclose(f);
+		return -1;
+	}
+
+	/* errors on a sysfs write are reported at close time */
+	if (fclose(f) != 0) {
+		EAL_LOG(ERR, "cannot write '%s' to %s: %s", str, path, strerror(errno));
+		return -1;
+	}
+
+	return 0;
+}
diff --git a/lib/eal/linux/meson.build b/lib/eal/linux/meson.build
index 29ba313218..2313cd7488 100644
--- a/lib/eal/linux/meson.build
+++ b/lib/eal/linux/meson.build
@@ -13,6 +13,7 @@ sources += files(
         'eal_lcore.c',
         'eal_memalloc.c',
         'eal_memory.c',
+        'eal_sysfs.c',
         'eal_thread.c',
         'eal_timer.c',
         'eal_vfio.c',
diff --git a/lib/eal/unix/eal_filesystem.c b/lib/eal/unix/eal_filesystem.c
index 6b8451cd3e..c6e827f805 100644
--- a/lib/eal/unix/eal_filesystem.c
+++ b/lib/eal/unix/eal_filesystem.c
@@ -76,34 +76,3 @@ int eal_create_runtime_dir(void)
 
 	return 0;
 }
-
-/* parse a sysfs (or other) file containing one integer value */
-RTE_EXPORT_SYMBOL(eal_parse_sysfs_value)
-int eal_parse_sysfs_value(const char *filename, unsigned long *val)
-{
-	FILE *f;
-	char buf[BUFSIZ];
-	char *end = NULL;
-
-	if ((f = fopen(filename, "r")) == NULL) {
-		EAL_LOG(ERR, "%s(): cannot open sysfs value %s",
-			__func__, filename);
-		return -1;
-	}
-
-	if (fgets(buf, sizeof(buf), f) == NULL) {
-		EAL_LOG(ERR, "%s(): cannot read sysfs value %s",
-			__func__, filename);
-		fclose(f);
-		return -1;
-	}
-	*val = strtoul(buf, &end, 0);
-	if ((buf[0] == '\0') || (end == NULL) || (*end != '\n')) {
-		EAL_LOG(ERR, "%s(): cannot parse sysfs value %s",
-				__func__, filename);
-		fclose(f);
-		return -1;
-	}
-	fclose(f);
-	return 0;
-}
-- 
2.53.0

