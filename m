Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB3D8606A32F
	for <dpdk-dev@archiver.kernel.org>; Sun,  1 Nov 2026 23:22:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1433340E3B;
	Mon,  2 Nov 2026 00:22:04 +0100 (CET)
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
 by mails.dpdk.org (Postfix) with ESMTPS id E44E4402E3
 for <dev@dpdk.org>; Mon,  2 Nov 2026 00:22:01 +0100 (CET)
Received: by mail-dl1-f44.google.com with SMTP id
 a92af1059eb24-1aefd1bf74aso1236788c88.1
 for <dev@dpdk.org>; Sun, 01 Nov 2026 15:22:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kev009.com; s=google; t=1793575320; x=1794180120; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VEM8VxX43KCs+xx1xsKoBVwNiH/gRL0TlYhQ93aqp2c=;
 b=MdfSwUatoJQSAk9/49TmAj8YDe5Gm8/GnCHB/rU7MRwQCQHTMsh+CNz2WzsrXxTo2b
 oll0RWZtgno4u3KvpD7ZDm6L8Pz+mwBlDyLnG+2lvfUio/mMYIr0Ls+3CmVwn2Fa509o
 +DOw5rlQpt1DXuNSw0ovG6rccVHv6Ew+Y1+Ec=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793575320; x=1794180120;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=VEM8VxX43KCs+xx1xsKoBVwNiH/gRL0TlYhQ93aqp2c=;
 b=RdJlpv5lk0tXhc4clXh+xsCqTCo5s3HU5Uu3y4uh9Gzohfl6thyQASAlXORjVabgyx
 fgKymJYoDcomvXblTKeUwlUW9wBPNHpJLns2VYAK9heyWNZoFj6rukZZmMDReGqQDKja
 51Mx0qOHQj9xm2WQsXphowttd1rpVFMOeOTL0BaYc32cdhVjuaNvBw0DxkrstO3purBK
 A4Cvy0Ay8k4JRF7EGhvuDQrVxiw+4n/D86DC2kUxQAyuHUBJNvWWXSaz97NgRO+uPEzZ
 TV5p3IZgGubdSdKFnBrnPlOVBoxARicCdpdca/3I2moYJu1GqOte5PEnq0GuavI+P0Xb
 2bTg==
X-Gm-Message-State: AFq9FYKp25IVHoQcPBOG1J0RG8EZ9Zg/2pKNoTszAWvHJYxzB46GQcw9
 8O0+NQX49EYMyvwpKuf9K1SmrPL6av3fei2T9Tts7C3Stx0fwcJ1Fol2FUTDSch06ZFbMO5ztD2
 N287bj936
X-Gm-Gg: AYBFou3Y8NPRqgQAjCdW3SiTl4eRkFA57sCtAyZ6/p9uSYTdH7NmLEO9MOUbqQ9mZv0
 ydeI69qm9djairW5sU+RkoF/g1Fa//dQwElJVDkrUmI8pcykA/ZBAcgOKwpFlSX3LaVNLu1bwJl
 3KhqWOxKgdFlS6BB+bXhuUI6mH+oReMvO1cqbBa1B+dQj/zIYb1QnIGIEYIu8wmvkUHRN2nYGnI
 2YH98WTI8eEG6YqXliSNue/+xau737Tf+E1XN2W9MKI4950ecaJtvFOuhCOojebwuRIyZPqdaqU
 3HMahf9Np1bP1srE/i/vNagqRsZfv9DaAhsoLhLM4DFCVdd2L/lsm3oyQwb1EDbdMOcg3GsNOXZ
 504rM8lXb31E+tsQ67Fwz5wqB68KERmPEza4nwuhminZx1p3i8FIfMVn8x8Jlx+sik6BeR6dv/t
 KF7KCqx5wI0eK6nqxRao3IPQ4dmxPCMg63sYil22cgQMt3hPlNYgaLqbJ0VAor5xD3RVbn82PDF
 SGA+x9c3aG46p1Q2demvsLPjKU40R5InNE1Ez6hhoMXgN5F88mxMtv5ie2N5E9JidPOr3voN8Yz
 L6DcLIe/JtMCsZni8rOo/xweVBUAbXQoVXzuig4L6KIiDMpOROFalX3s93IES9/kCEPtME4lKML
 fhG/FUzD/ZUexFsJnutN5NVKhav775/nK6FYLyKm7EodiJdRwXUhTEJe/xYkAlz40o8ypTasYFh
 Om42F94zU=
X-Received: by 2002:a05:7022:eb50:10b0:183:942e:8493 with SMTP id
 a92af1059eb24-1ac5a67f97bmr13190640c88.11.1793575320119; 
 Sun, 01 Nov 2026 15:22:00 -0800 (PST)
Received: from kev-ws-aurora.cv0.bbox.io ([172.83.102.10])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1ac194b5437sm31982675c88.13.2026.11.01.15.21.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Nov 2026 15:21:59 -0800 (PST)
From: Kevin Bowling <kevin.bowling@kev009.com>
To: dev@dpdk.org
Cc: Harman Kalra <hkalra@marvell.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Chenbo Xia <chenbox@nvidia.com>, Nipun Gupta <nipun.gupta@amd.com>
Subject: [PATCH RESEND 3/3] eal/freebsd: support UIO MSI-X interrupts
Date: Sun,  1 Nov 2026 16:21:53 -0700
Message-ID: <20261101232154.94354-4-kevin.bowling@kev009.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261101232154.94354-1-kevin.bowling@kev009.com>
References: <20261101232154.94354-1-kevin.bowling@kev009.com>
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
X-Spam-Status: No, score=-15.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,TVD_FROM_1,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Negotiate the optional UIO interrupt interface when registering a callback.
Read its 32-bit event counter through the existing kqueue dispatcher and
connect interrupt enable and disable to the module's control operations.
MSI-X acknowledgment remains device-specific and is handled by the PMD.

Older modules reject the initialization ioctl, allowing PMDs to retain
polling fallback. New modules retain BAR-only operation for older EAL
versions. Open the PCI interrupt descriptor in nonblocking mode and keep
per-queue interrupt capability reporting unchanged.

Add a regression test for descriptors that lack the UIO interface and
document the supported scope and module compatibility. Clang and GCC
builds pass for EAL, the PCI bus, and iavf. E810 VF tests exercise AdminQ
interrupts, queue restarts, resets, and polling fallback with an old
module.

Signed-off-by: Kevin Bowling <kevin.bowling@kev009.com>
---
 app/test/test_interrupts_freebsd.c     | 16 +++++++++++++
 doc/guides/freebsd_gsg/build_dpdk.rst  | 10 ++++----
 doc/guides/rel_notes/release_26_11.rst | 10 ++++++++
 drivers/bus/pci/bsd/pci.c              |  2 +-
 lib/eal/freebsd/eal_interrupts.c       | 33 ++++++++++++++++++++++----
 lib/eal/freebsd/meson.build            |  2 ++
 6 files changed, 62 insertions(+), 11 deletions(-)

diff --git a/app/test/test_interrupts_freebsd.c b/app/test/test_interrupts_freebsd.c
index c6a68f8a66..8f65146340 100644
--- a/app/test/test_interrupts_freebsd.c
+++ b/app/test/test_interrupts_freebsd.c
@@ -169,11 +169,27 @@ freebsd_interrupt_read_race(void)
 	return TEST_SUCCESS;
 }
 
+static int
+freebsd_interrupt_no_uio(void)
+{
+	TEST_ASSERT_SUCCESS(rte_intr_type_set(handles[0], RTE_INTR_HANDLE_UIO),
+		"Cannot set UIO type");
+	TEST_ASSERT_EQUAL(rte_intr_callback_register(handles[0], freebsd_gate, NULL),
+		-ENOTTY, "A descriptor without the UIO interface was accepted");
+	TEST_ASSERT_EQUAL(rte_intr_enable(handles[0]), -ENOTTY,
+		"Unsupported UIO interrupts were enabled");
+	TEST_ASSERT_EQUAL(rte_intr_disable(handles[0]), -ENOTTY,
+		"Unsupported UIO interrupts were disabled");
+	return TEST_SUCCESS;
+}
+
 static struct unit_test_suite freebsd_interrupt_suite = {
 	.suite_name = "FreeBSD interrupt dispatch",
 	.unit_test_cases = {
 		TEST_CASE_ST(freebsd_interrupt_setup, freebsd_interrupt_teardown,
 			freebsd_interrupt_read_race),
+		TEST_CASE_ST(freebsd_interrupt_setup, freebsd_interrupt_teardown,
+			freebsd_interrupt_no_uio),
 		TEST_CASES_END()
 	}
 };
diff --git a/doc/guides/freebsd_gsg/build_dpdk.rst b/doc/guides/freebsd_gsg/build_dpdk.rst
index 48e499b6ca..bbce6f49bf 100644
--- a/doc/guides/freebsd_gsg/build_dpdk.rst
+++ b/doc/guides/freebsd_gsg/build_dpdk.rst
@@ -160,13 +160,13 @@ Loading the DPDK nic_uio Module
 
 The module supports one MSI-X vector per PCI function for control events,
 such as AdminQ messages and link changes. Interrupt resources are allocated
-only when an application requests them through the initialization ioctl.
-The application retains responsibility for acknowledging and rearming
-device interrupt causes.
+only when an application registers an interrupt callback. The application
+retains responsibility for acknowledging and rearming device interrupt causes.
 Per-queue Rx interrupts, MSI, and legacy INTx interrupts are not supported.
 
-The interrupt interface is optional. Applications can use the updated
-module without allocating interrupts.
+The interrupt interface is optional. An updated application can continue
+to use an older module with a PMD that supports polling fallback. Older
+applications can use the updated module without allocating interrupts.
 The file description that initializes interrupts owns the vector until its
 last reference is closed; other opens can still map device BARs. Detaching
 the device is refused while device files remain open.
diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index c5dc75d81c..6fe64faeca 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -55,6 +55,16 @@ New Features
      Also, make sure to start the actual text at the margin.
      =======================================================
 
+* **Added FreeBSD PCI control interrupt support.**
+
+  The ``nic_uio`` module and FreeBSD EAL now support a single MSI-X vector
+  per PCI function for control events. PMDs can use interrupt callbacks for
+  AdminQ and link notifications. Older modules remain usable with PMDs that
+  support polling fallback. Per-queue Rx interrupts are not supported.
+  Interrupt control requires a writable descriptor. Bus mastering is enabled
+  on the first writable open and disabled on the last writable close,
+  including process exit.
+
 * **Added division round up macro.**
 
   Added the ``RTE_DIV_ROUND_UP`` macro in ``rte_common.h``
diff --git a/drivers/bus/pci/bsd/pci.c b/drivers/bus/pci/bsd/pci.c
index 2d29f8d2e2..c1a0e413a5 100644
--- a/drivers/bus/pci/bsd/pci.c
+++ b/drivers/bus/pci/bsd/pci.c
@@ -110,7 +110,7 @@ pci_uio_alloc_resource(struct rte_pci_device *dev,
 	snprintf(devname, sizeof(devname), "/dev/uio@pci:%u:%u:%u",
 			dev->addr.bus, dev->addr.devid, dev->addr.function);
 
-	fd = open(devname, O_RDWR);
+	fd = open(devname, O_RDWR | O_NONBLOCK);
 	if (fd < 0) {
 		if (errno == ENOENT) {
 			PCI_LOG(WARNING, PCI_PRI_FMT" not managed by UIO driver, skipping",
diff --git a/lib/eal/freebsd/eal_interrupts.c b/lib/eal/freebsd/eal_interrupts.c
index 8ba92f71a8..1f302d5736 100644
--- a/lib/eal/freebsd/eal_interrupts.c
+++ b/lib/eal/freebsd/eal_interrupts.c
@@ -5,6 +5,7 @@
 #include <string.h>
 #include <sys/types.h>
 #include <sys/event.h>
+#include <sys/ioctl.h>
 #include <sys/queue.h>
 #include <unistd.h>
 
@@ -18,6 +19,7 @@
 
 #include "eal_private.h"
 #include "eal_alarm_private.h"
+#include "nic_uio.h"
 
 #define MAX_INTR_EVENTS 16
 
@@ -25,6 +27,7 @@
  * union buffer for reading on different devices
  */
 union rte_intr_read_buffer {
+	uint32_t uio_count;
 	char charbuf[16];                /* for others */
 };
 
@@ -100,6 +103,10 @@ rte_intr_callback_register(const struct rte_intr_handle *intr_handle,
 		EAL_LOG(ERR, "Kqueue is not active: %d", kq);
 		return -ENODEV;
 	}
+	/* Older nic_uio modules do not implement this optional interface. */
+	if (rte_intr_type_get(intr_handle) == RTE_INTR_HANDLE_UIO &&
+			ioctl(rte_intr_fd_get(intr_handle), NIC_UIO_IRQ_INIT) < 0)
+		return -errno;
 
 	rte_spinlock_lock(&intr_lock);
 
@@ -171,10 +178,7 @@ rte_intr_callback_register(const struct rte_intr_handle *intr_handle,
 		 * add the intr file descriptor into wait list.
 		 */
 		if (kevent(kq, &ke, 1, NULL, 0, NULL) < 0) {
-			/* currently, nic_uio does not support interrupts, so
-			 * this error will always be triggered and output to the
-			 * user. so, don't output it unless debug log level set.
-			 */
+			/* An interrupt source may not support kqueue notification. */
 			if (errno == ENODEV)
 				EAL_LOG(DEBUG, "Interrupt handle %d not supported",
 					rte_intr_fd_get(src->intr_handle));
@@ -373,6 +377,13 @@ rte_intr_enable(const struct rte_intr_handle *intr_handle)
 	if (intr_handle == NULL)
 		return -1;
 
+	if (rte_intr_type_get(intr_handle) == RTE_INTR_HANDLE_UIO) {
+		rc = ioctl(rte_intr_fd_get(intr_handle), NIC_UIO_IRQ_ENABLE);
+		if (rc < 0)
+			rc = -errno;
+		goto out;
+	}
+
 	if (rte_intr_type_get(intr_handle) == RTE_INTR_HANDLE_VDEV) {
 		rc = 0;
 		goto out;
@@ -415,6 +426,13 @@ rte_intr_disable(const struct rte_intr_handle *intr_handle)
 	if (intr_handle == NULL)
 		return -1;
 
+	if (rte_intr_type_get(intr_handle) == RTE_INTR_HANDLE_UIO) {
+		rc = ioctl(rte_intr_fd_get(intr_handle), NIC_UIO_IRQ_DISABLE);
+		if (rc < 0)
+			rc = -errno;
+		goto out;
+	}
+
 	if (rte_intr_type_get(intr_handle) == RTE_INTR_HANDLE_VDEV) {
 		rc = 0;
 		goto out;
@@ -451,7 +469,9 @@ RTE_EXPORT_SYMBOL(rte_intr_ack)
 int
 rte_intr_ack(const struct rte_intr_handle *intr_handle)
 {
-	if (rte_intr_type_get(intr_handle) == RTE_INTR_HANDLE_VDEV)
+	/* nic_uio MSI-X handlers leave device-specific rearming to the PMD. */
+	if (rte_intr_type_get(intr_handle) == RTE_INTR_HANDLE_VDEV ||
+			rte_intr_type_get(intr_handle) == RTE_INTR_HANDLE_UIO)
 		return 0;
 
 	return -1;
@@ -499,6 +519,9 @@ eal_intr_process_interrupts(struct kevent *events, int nfds)
 			bytes_read = 0;
 			call = true;
 			break;
+		case RTE_INTR_HANDLE_UIO:
+			bytes_read = sizeof(buf.uio_count);
+			break;
 		default:
 			bytes_read = 1;
 			break;
diff --git a/lib/eal/freebsd/meson.build b/lib/eal/freebsd/meson.build
index a9588be70f..0851f713cb 100644
--- a/lib/eal/freebsd/meson.build
+++ b/lib/eal/freebsd/meson.build
@@ -3,6 +3,8 @@
 
 subdir('include')
 
+includes += include_directories('../../../kernel/freebsd/nic_uio')
+
 sources += files(
         'eal.c',
         'eal_alarm.c',
-- 
2.56.0

