Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38AA6C982CC
	for <dpdk-dev@archiver.kernel.org>; Sat, 19 Sep 2026 08:17:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 299F740611;
	Sat, 19 Sep 2026 10:17:38 +0200 (CEST)
Received: from mail-pj2-f14.google.com (mail-pj2-f14.google.com
 [74.125.227.142])
 by mails.dpdk.org (Postfix) with ESMTP id BE6BA4026A
 for <dev@dpdk.org>; Sat, 19 Sep 2026 00:56:11 +0200 (CEST)
Received: by mail-pj2-f14.google.com with SMTP id
 d9443c01a7336-2d747f05ffcso10403175ad.0
 for <dev@dpdk.org>; Fri, 18 Sep 2026 15:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789772171; x=1790376971; darn=dpdk.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=UI9sxDqhG2XvWfP5nX+k0e6l4wlWqNknmi+D528ANck=;
 b=VY/5rq6/5uryMh19bOJD+B7s+81HxnqdswJcGKe53KKXWaixtIBeS1XE2/ub+kyKBh
 Ej7JrEin6DncJHjOyxIisu2o65h7jzrYWFHf8KHHFnal7RmvV5tmhlE8FQ5Jpcj+3/QS
 y380MnkvwAmUa4W3JHCa2Gc/PBJSBPuEvMbpyvrySGwHPt32NW9zsExJEAwtr4iYjqHy
 hlxrPkEIfOLcu+eMWYp9tQrfqelpmpQO0BbIloK93F3nx+AGM7/FOa65ca8lZ6emkiNK
 CCLNDAf5iaOHYKTeRBI+Jxuq725FbvxYJWAL75cGd2WS3zPSaUpUnt/0cImVyVLJgznz
 OfyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789772171; x=1790376971;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=UI9sxDqhG2XvWfP5nX+k0e6l4wlWqNknmi+D528ANck=;
 b=uNR3HuCBfM54iR9YSM4OrK7TI+zkCkStw+vNkDRJNg4wys8Y26GrGU4Qa1wmRrqQub
 xkU+M0n7RKVf80sv+RsFxZsMKKB4E0tIGkyoX5BLLdDu+Vtr33pem5TPMSXubc/ur3r8
 7JcAayhT5nejM+dM6q/gbkmp0unUTJ1ddB9lGUI8sTYWKNK4QzDB+WwikVKybb+n5O+N
 /vhFacPyuL/544K0Ny3rmrd8GAkN6tsxodoQUT+/oBcDv7YyVL953+oYVxq7Wh66/D30
 uUI+ufT8x/Sg8m3ayiNn9inB/ECYrZJ5T3dYHlC2Ir9SjJbV+GOHul45xnC3wMcncoum
 0w5A==
X-Gm-Message-State: AFuF++lF5vr65lnqaloNntE8Ym6lhmJjh8FZmQlogMVFZZALuxrQQPSp
 uQP9x3m8hm431a4dc5w1swY8+eU5Wr7/DjtOLsGNJQu2d0qL5oCZr/X7kdljggNX
X-Gm-Gg: AYBFou3OmhAKKkFRHLJGWoPtewXQTJ6wP/MOgfsL/JH4gXAqmk1PCRK/qfn7RZcLr28
 Pqc+QrR4s935KZRo4ESrMHAwCTloM8y/siqR+TSnA8A/5E5yq2DaDtxTN16fKKKPz+mfkTRVixN
 kfZmG152vo4JwqEpsSUVf5dhoPgx5m6l0ibmrtM55AwAj8e6eQ5qWErnYypt3LFsJWO9I1Ql9V/
 cK3Gt83nX0NsHdvxKgzAX4pRRy2Sze9lJxZbsJnLfGkIZREpydgWJqIaSKCLtIb0DsENHKdUoAp
 wbvTTsn11CkOLQpATvC0AH8AtGLswg+k1tybxfByUcpERpb+k2EOeX1W0QRkTGcH9FEtJOmBqta
 7rwoMtQghJQZPLWIBogHb4l1wUBsdV4GY5hLWAPPiXBwDMt/jE3+DmCBnGC+kzbSbNauIXGrvTZ
 Js6g3cf+0CGIGr+7r68MBJkLV4xnCWmVXOQ4wgCIQ0Kr72W89U9Ga1BPJPzP+JmQaDkO3OJBw7l
 A==
X-Received: by 2002:a17:903:32c6:b0:2dd:ad74:ac29 with SMTP id
 d9443c01a7336-2ddb1bae2b9mr73432195ad.27.1789772170637; 
 Fri, 18 Sep 2026 15:56:10 -0700 (PDT)
Received: from ubuntu-desktop.. ([137.99.252.104])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33c3314313esm1569423eec.14.2026.09.18.15.56.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2026 15:56:10 -0700 (PDT)
From: Md Rayhanul Islam <r97yhan@gmail.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, Chuanyu Xue <chuanyu.xue@uconn.edu>,
 Song Han <song.han@uconn.edu>,
 Md Rayhanul Islam <md_rayhanul.islam@uconn.edu>,
 Md Rayhanul Islam <r97yhan@gmail.com>,
 Thomas Monjalon <thomas@monjalon.net>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH 1/2] eal/linux: apply PCIe inbound DMA translation
Date: Fri, 18 Sep 2026 18:50:43 -0400
Message-Id: <20260918225045.177125-2-r97yhan@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260918225045.177125-1-r97yhan@gmail.com>
References: <20260918225045.177125-1-r97yhan@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 19 Sep 2026 10:17:34 +0200
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

On some platforms a device does not see memory at the CPU's physical
addresses: the PCIe host bridge translates inbound traffic.  An IOVA in
RTE_IOVA_PA mode is then an address the device cannot reach, so its
reads and writes fall outside the bridge's inbound window and are
dropped with no error reported.

On a Raspberry Pi Compute Module 4 (BCM2711) with an Intel I210, the
host bridge declares in its device tree "dma-ranges" that CPU physical
address 0 is reached at bus address 0x4_0000_0000.  Without that offset
the NIC reported link up but never completed a DMA: testpmd in txonly
mode left TX-packets at 0, and received data never reached the mbufs.

Read the translation from the PCI host bridge "dma-ranges" in the device
tree and add it to IOVAs in rte_mem_virt2iova() and the legacy memory
path.  Platforms that declare no translation, and those with no device
tree, keep an identity mapping.  DPDK_IOVA_PA_OFFSET overrides it.

Signed-off-by: Md Rayhanul Islam <r97yhan@gmail.com>
---
 .mailmap                                  |   1 +
 doc/guides/linux_gsg/bcm2711_platform.rst |  45 ++++
 doc/guides/linux_gsg/index.rst            |   1 +
 doc/guides/rel_notes/release_26_11.rst    |   8 +
 lib/eal/linux/eal_memory.c                | 265 +++++++++++++++++++++-
 5 files changed, 318 insertions(+), 2 deletions(-)
 create mode 100644 doc/guides/linux_gsg/bcm2711_platform.rst

diff --git a/.mailmap b/.mailmap
index 9e45cdce8f..9fd78db7e2 100644
--- a/.mailmap
+++ b/.mailmap
@@ -1032,6 +1032,7 @@ Marek Mical <marekx.mical@intel.com>
 Marek Zalfresso-jundzillo <marekx.zalfresso-jundzillo@intel.com>
 Maria Lingemark <maria.lingemark@ericsson.com>
 Mario Carrillo <mario.alfredo.c.arevalo@intel.com>
+Md Rayhanul Islam <r97yhan@gmail.com>
 Mário Kuka <kuka@cesnet.cz>
 Mariusz Drost <mariuszx.drost@intel.com>
 Mark Asselstine <mark.asselstine@windriver.com>
diff --git a/doc/guides/linux_gsg/bcm2711_platform.rst b/doc/guides/linux_gsg/bcm2711_platform.rst
new file mode 100644
index 0000000000..5a774607da
--- /dev/null
+++ b/doc/guides/linux_gsg/bcm2711_platform.rst
@@ -0,0 +1,45 @@
+.. SPDX-License-Identifier: BSD-3-Clause
+   Copyright(c) 2026 Md Rayhanul Islam
+
+Running DPDK on Broadcom BCM2711 platforms
+==========================================
+
+The Broadcom BCM2711, used on the Raspberry Pi 4 and Compute Module 4,
+has a platform property that must be taken into account before a PCIe
+device can DMA correctly.  It is handled automatically; this page
+describes what happens and how to check it.
+
+PCIe inbound address translation
+--------------------------------
+
+The PCIe host bridge does not present system memory to devices at the CPU
+physical addresses.  On a Compute Module 4 the host bridge node declares::
+
+   $ hexdump -C /proc/device-tree/scb/pcie@7d500000/dma-ranges
+   02000000 00000004 00000000  00000000 00000000  00000001 00000000
+
+which places CPU physical address 0 at PCIe bus address ``0x4_0000_0000``.
+
+In ``RTE_IOVA_PA`` mode, an IOVA must therefore be the CPU physical
+address plus that offset.  EAL reads the translation from the host
+bridge's ``dma-ranges`` property and applies it.  Platforms that declare
+no translation, and platforms without a device tree, are unaffected.
+
+A DPDK application logs the offset it found at startup::
+
+   EAL: PCIe bus addresses are offset by 0x400000000 from CPU physical
+   addresses (/proc/device-tree/scb/pcie@7d500000/dma-ranges); applying
+   it to IOVAs
+
+The value can be overridden with the ``DPDK_IOVA_PA_OFFSET`` environment
+variable, given in hexadecimal.  Without the translation, a device
+reports link up and counts packets in its own registers while never
+completing a DMA.
+
+Recommended settings
+--------------------
+
+* Add ``pcie_aspm=off`` to the kernel command line, so the PCIe link does
+  not enter a low-power state during a run.
+* Bind the device to ``uio_pci_generic``.  There is no IOMMU on this
+  SoC, so ``vfio-pci`` can only be used in unsafe no-IOMMU mode.
diff --git a/doc/guides/linux_gsg/index.rst b/doc/guides/linux_gsg/index.rst
index f739edd6ca..480909ec2c 100644
--- a/doc/guides/linux_gsg/index.rst
+++ b/doc/guides/linux_gsg/index.rst
@@ -20,3 +20,4 @@ Getting Started Guide for Linux
     enable_func
     nic_perf_intel_platform
     amd_platform
+    bcm2711_platform
diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index 4b3e5d995c..37452b2a3f 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -55,6 +55,14 @@ New Features
      Also, make sure to start the actual text at the margin.
      =======================================================
 
+* **Added PCIe inbound DMA address translation on Linux.**
+
+  EAL now reads the PCIe host bridge "dma-ranges" property from the device
+  tree and applies the translation it declares to IOVAs, so devices on a
+  platform whose inbound window is not identity-mapped, such as the
+  Broadcom BCM2711 on Raspberry Pi 4 and Compute Module 4, can reach
+  system memory.
+
 
 Removed Items
 -------------
diff --git a/lib/eal/linux/eal_memory.c b/lib/eal/linux/eal_memory.c
index d9d505d865..75c6ba07c8 100644
--- a/lib/eal/linux/eal_memory.c
+++ b/lib/eal/linux/eal_memory.c
@@ -3,6 +3,7 @@
  * Copyright(c) 2013 6WIND S.A.
  */
 
+#include <dirent.h>
 #include <errno.h>
 #include <fcntl.h>
 #include <stdbool.h>
@@ -25,6 +26,7 @@
 #include <numaif.h>
 #endif
 
+#include <rte_byteorder.h>
 #include <rte_errno.h>
 #include <rte_log.h>
 #include <rte_memory.h>
@@ -83,6 +85,262 @@ uint64_t eal_get_baseaddr(void)
 #endif
 }
 
+/*
+ * On some platforms the address space seen by PCIe devices is not the CPU
+ * physical address space: the host bridge applies a fixed translation to
+ * inbound (device-to-memory) traffic.  There, an IOVA in RTE_IOVA_PA mode is
+ * *not* a CPU physical address -- a device DMAing to CPU physical address P
+ * must be programmed with P + offset, or its reads and writes fall outside the
+ * bridge's inbound window and are silently discarded.
+ *
+ * This was found on a Broadcom BCM2711 (Raspberry Pi Compute Module 4, 4GB),
+ * whose host bridge node pcie@7d500000 declares in "dma-ranges" that CPU
+ * physical 0 is reached by devices at PCIe address 0x4_0000_0000 (its outbound
+ * window, in "ranges", starts at PCIe address 0xc000_0000).  Without the
+ * translation every DPDK descriptor ring and mbuf address handed to the NIC is
+ * unreachable, and the observed symptom was a device that reported link up and
+ * counted packets in its own registers while never completing a single DMA.
+ *
+ * The translation is read from the "dma-ranges" property of the PCI host
+ * bridge in the device tree, so each platform gets the value it declares
+ * rather than one assumed here.  It is zero on identity-mapped platforms and
+ * absent where there is no device tree (x86), and everything below is then a
+ * no-op.
+ */
+#define DT_ROOT_PATH		"/proc/device-tree"
+#define IOVA_PA_OFFSET_ENV	"DPDK_IOVA_PA_OFFSET"
+#define IOVA_PA_OFFSET_UNSET	UINT64_MAX
+#define DT_MAX_SCAN_DEPTH	4
+
+/*
+ * Cached PCIe-bus-address-minus-CPU-physical-address translation.  Written at
+ * most once with a value that does not depend on who computes it, and it is a
+ * single aligned 64-bit store, so the benign race between threads racing to
+ * fill it in cannot produce a torn or inconsistent result.
+ */
+static uint64_t iova_pa_offset = IOVA_PA_OFFSET_UNSET;
+
+/* Read a device-tree property into buf, storing its length in *outlen. */
+static int
+dt_read_prop(const char *dir, const char *prop, void *buf, size_t buflen,
+		size_t *outlen)
+{
+	char path[PATH_MAX];
+	size_t n;
+	FILE *f;
+
+	if (snprintf(path, sizeof(path), "%s/%s", dir, prop) >= (int)sizeof(path))
+		return -1;
+	f = fopen(path, "rb");
+	if (f == NULL)
+		return -1;
+	n = fread(buf, 1, buflen, f);
+	if (ferror(f)) {
+		fclose(f);
+		return -1;
+	}
+	fclose(f);
+	*outlen = n;
+	return 0;
+}
+
+/* Read a single-cell device-tree property, e.g. #address-cells. */
+static int
+dt_read_u32(const char *dir, const char *prop, uint32_t *out)
+{
+	uint32_t val;
+	size_t len;
+
+	if (dt_read_prop(dir, prop, &val, sizeof(val), &len) < 0 ||
+			len != sizeof(val))
+		return -1;
+	*out = rte_be_to_cpu_32(val);
+	return 0;
+}
+
+/* Device-tree addresses are big-endian sequences of 32-bit cells. */
+static uint64_t
+dt_read_cells(const uint32_t *cells, uint32_t n)
+{
+	uint64_t val = 0;
+	uint32_t i;
+
+	for (i = 0; i < n; i++)
+		val = (val << 32) | rte_be_to_cpu_32(cells[i]);
+	return val;
+}
+
+/*
+ * Derive the inbound translation from the "dma-ranges" of one PCI host bridge.
+ * Each entry is <pci-address> <parent-address> <size>, where a PCI address is
+ * always 3 cells (phys.hi holds flags, phys.mid/phys.lo hold the address), the
+ * parent address is the parent bus' #address-cells, and the size is this node's
+ * #size-cells.
+ */
+static int
+dt_pci_dma_offset(const char *node, const char *parent, uint64_t *offset)
+{
+	uint32_t cells[256];
+	uint32_t parent_ac, size_c;
+	size_t len, ncells, per_entry, i;
+	uint64_t off = 0;
+	bool first = true;
+
+	if (dt_read_prop(node, "dma-ranges", cells, sizeof(cells), &len) < 0)
+		return -1;
+
+	/* An empty "dma-ranges" declares the bus to be identity mapped. */
+	if (len == 0) {
+		*offset = 0;
+		return 0;
+	}
+
+	if (dt_read_u32(parent, "#address-cells", &parent_ac) < 0 ||
+			dt_read_u32(node, "#size-cells", &size_c) < 0)
+		return -1;
+	/* More than 2 cells cannot be held in a uint64_t. */
+	if (parent_ac == 0 || parent_ac > 2 || size_c > 2)
+		return -1;
+
+	per_entry = 3 + parent_ac + size_c;
+	ncells = len / sizeof(uint32_t);
+	if (ncells == 0 || ncells % per_entry != 0)
+		return -1;
+
+	for (i = 0; i < ncells; i += per_entry) {
+		uint64_t pci_addr = dt_read_cells(&cells[i + 1], 2);
+		uint64_t cpu_addr = dt_read_cells(&cells[i + 3], parent_ac);
+		uint64_t entry_off = pci_addr - cpu_addr;
+
+		if (first) {
+			off = entry_off;
+			first = false;
+		} else if (entry_off != off) {
+			/*
+			 * The bridge translates different regions differently,
+			 * which a single offset cannot express.  Refuse to
+			 * guess rather than corrupt every IOVA.
+			 */
+			EAL_LOG(WARNING,
+				"%s: non-uniform dma-ranges, cannot derive an IOVA offset",
+				node);
+			return -1;
+		}
+	}
+
+	*offset = off;
+	return 0;
+}
+
+/*
+ * Walk the device tree looking for a PCI host bridge that describes a non-zero
+ * inbound translation, and report the first one found.  Systems with several
+ * host bridges translating differently would need per-device IOVAs, which the
+ * IOVA-as-PA model cannot express; we log the node we used so a mismatch is
+ * visible rather than silent.
+ */
+static int
+dt_scan_pci_dma_offset(const char *dir, const char *parent, int depth,
+		uint64_t *offset, char *node, size_t node_len)
+{
+	struct dirent *ent;
+	int ret = -1;
+	DIR *d;
+
+	if (depth > DT_MAX_SCAN_DEPTH)
+		return -1;
+
+	if (parent != NULL) {
+		char type[16];
+		size_t len;
+
+		if (dt_read_prop(dir, "device_type", type, sizeof(type) - 1,
+				&len) == 0) {
+			type[len] = '\0';
+			if (strcmp(type, "pci") == 0 &&
+					dt_pci_dma_offset(dir, parent,
+						offset) == 0 && *offset != 0) {
+				strlcpy(node, dir, node_len);
+				return 0;
+			}
+		}
+	}
+
+	d = opendir(dir);
+	if (d == NULL)
+		return -1;
+	while ((ent = readdir(d)) != NULL) {
+		char child[PATH_MAX];
+
+		/* Skip ".", "..", and the device tree's own dot-properties. */
+		if (ent->d_name[0] == '.')
+			continue;
+		/* procfs may not fill in d_type; opendir() filters non-dirs. */
+		if (ent->d_type != DT_DIR && ent->d_type != DT_UNKNOWN)
+			continue;
+		if (snprintf(child, sizeof(child), "%s/%s", dir,
+				ent->d_name) >= (int)sizeof(child))
+			continue;
+		if (dt_scan_pci_dma_offset(child, dir, depth + 1, offset,
+				node, node_len) == 0) {
+			ret = 0;
+			break;
+		}
+	}
+	closedir(d);
+	return ret;
+}
+
+/* Offset to add to a CPU physical address to obtain the address a PCIe device
+ * must use to reach it.  Zero on identity-mapped platforms.
+ */
+static uint64_t
+eal_iova_pa_offset(void)
+{
+	char node[PATH_MAX] = "";
+	uint64_t offset = 0;
+	const char *env;
+	char *end;
+
+	if (iova_pa_offset != IOVA_PA_OFFSET_UNSET)
+		return iova_pa_offset;
+
+	env = getenv(IOVA_PA_OFFSET_ENV);
+	if (env != NULL && env[0] != '\0') {
+		errno = 0;
+		offset = strtoull(env, &end, 0);
+		if (errno != 0 || *end != '\0') {
+			EAL_LOG(ERR, "Invalid %s value '%s', assuming no offset",
+				IOVA_PA_OFFSET_ENV, env);
+			offset = 0;
+		} else {
+			EAL_LOG(NOTICE,
+				"Using IOVA offset 0x%" PRIx64 " from %s",
+				offset, IOVA_PA_OFFSET_ENV);
+		}
+	} else if (dt_scan_pci_dma_offset(DT_ROOT_PATH, NULL, 0, &offset,
+			node, sizeof(node)) == 0) {
+		EAL_LOG(NOTICE,
+			"PCIe bus addresses are offset by 0x%" PRIx64
+			" from CPU physical addresses (%s/dma-ranges); applying it to IOVAs",
+			offset, node);
+	} else {
+		offset = 0;
+	}
+
+	iova_pa_offset = offset;
+	return offset;
+}
+
+/* Convert a CPU physical address into the IOVA a device must be given. */
+static rte_iova_t
+eal_pa_to_iova(phys_addr_t pa)
+{
+	if (pa == RTE_BAD_IOVA)
+		return RTE_BAD_IOVA;
+	return pa + eal_iova_pa_offset();
+}
+
 /*
  * Get physical address of any mapped virtual address in the current process.
  */
@@ -150,7 +408,7 @@ rte_mem_virt2iova(const void *virtaddr)
 {
 	if (rte_eal_iova_mode() == RTE_IOVA_VA)
 		return (uintptr_t)virtaddr;
-	return rte_mem_virt2phy(virtaddr);
+	return eal_pa_to_iova(rte_mem_virt2phy(virtaddr));
 }
 
 /*
@@ -805,7 +1063,10 @@ remap_segment(struct hugepage_file *hugepages, int seg_start, int seg_end)
 		ms->addr = addr;
 		ms->hugepage_sz = page_sz;
 		ms->len = memseg_len;
-		ms->iova = hfile->physaddr;
+		/* In IOVA-as-VA mode physaddr has been rewritten to the VA. */
+		ms->iova = rte_eal_iova_mode() == RTE_IOVA_VA ?
+				hfile->physaddr :
+				eal_pa_to_iova(hfile->physaddr);
 		ms->socket_id = hfile->socket_id;
 		ms->nchannel = rte_memory_get_nchannel();
 		ms->nrank = rte_memory_get_nrank();
-- 
2.34.1

