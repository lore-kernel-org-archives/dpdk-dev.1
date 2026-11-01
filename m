Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15E0606A331
	for <dpdk-dev@archiver.kernel.org>; Sun,  1 Nov 2026 23:22:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 266FA40264;
	Mon,  2 Nov 2026 00:22:02 +0100 (CET)
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com
 [74.125.82.170])
 by mails.dpdk.org (Postfix) with ESMTPS id 9AA4B402E3
 for <dev@dpdk.org>; Mon,  2 Nov 2026 00:22:00 +0100 (CET)
Received: by mail-dy1-f170.google.com with SMTP id
 5a478bee46e88-3535bf8b3e0so3509720eec.0
 for <dev@dpdk.org>; Sun, 01 Nov 2026 15:22:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kev009.com; s=google; t=1793575319; x=1794180119; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=a5vRsT77guZnsQ8CeNK7k1Az8N5cMIf+obUTQqwVzDI=;
 b=Af7FwmD0UNLxAEggTgQG+Ch9wkk/TzPMQCXA/5reFd30CiRoC1yOIpwylxk8Jg6Ysy
 C9bL1ly3XOfWE78SVG6bUMNE6vp3cgFYoHgxhDhGDszQ4gmKXmxMM0LPq10vSsJbKaKe
 /J34+8M6PmKVXTj2TUlfc8oX2yVmA+wDiiufE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793575319; x=1794180119;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=a5vRsT77guZnsQ8CeNK7k1Az8N5cMIf+obUTQqwVzDI=;
 b=nbglo7/liiuU9ojL2G8NeYO2XgTRMprYnkiWHzGFbzGB7tTaNig0BSx7HkghTM4OM6
 ZY6M9u/BzgP+SLvM540AA+rVBb1FApY/BtG8ulTTnx/TeRz3ssm5KPQnob7XsriQjF9V
 tTez4Hwi4d297+h3z3ZUNq6C8tje5U8/g6lnL3oBontS+SdC2m4CMD5A0hIcgG5LjkOS
 tb2+SYjIP7T2ZQTg9kt3Zg3hq0fXu2adjDYtLiUwbW8jCK6OXcLC63mDuf7woYNB060H
 5ZgvfS8U1PFnk789iOr2KQz4pjzjB9UmXBgWu76KwoQcgj0lx2IjFVDRXoT5kpJmUX8/
 vcuw==
X-Gm-Message-State: AFq9FYK/JlXG/orAZLjPYxhUdkfV6uPrkwsBAdrym/ZKb60A3gCsU0Oc
 rQJStok8y7dxL7lwmLg38rk9ikHYny6cz9I5Rf9MOq5gYihW7WvmJlWQ/+tgvBFEx3F3Kb3eB/D
 c+aZVclYG
X-Gm-Gg: AYBFou3Fk18uHO1vX0YkwraOo2vyvqWSvTMb1HQzKdGPsJG3Pfvz1+YVc9iWcnuOWMO
 xg7h9A1O6oZkGP77MPx77F6jwH3vyFPLxAh5hPv+aTyS3STUwK6/Ye1qM+Q1zebSK+xIQFhbC9F
 vhGFad5FhKVzypb12f0QjLK02ezHu2gXdsFoKjKRNxotX8jG5pD0Fvconkdo/ivU8TTexSASSVL
 sUbBIM9L0BNRnU/dDe8JVjIOR9Jk1SXfjEKVDAeB2nv5ZFS/TE3tyY0yoMlHQ5FngCgNAwjdL1/
 oIm+M8Zh/PuBAw+X+Q5yHvZd99Pk7WmriyP3KEeQKxxAALBavBqEBkbricRp92MkqGo9Gg8vL+O
 LMNiuIz/yBE9fTuWHOMxyNRosExBZgQqXeaPCduolTlIkjKdpjC3b+f5WAXKzXNZ4IYmrP26qTj
 ccozGqX31hOPcSjVaUWnBTG7pIGyQgW6nQrSjcwnBEfZmf2nW3BCG5wTXF6VfX9MzOU/R79eZkv
 AuqYGyWVvjix2+ZaPtrfGdNwoJlwfMGbZCIDnpXIauuj6WdkGj+VO31G5i9wimqp8YBYBG1/8MV
 OPm4Jok4VnoW52DlQqXmKsK5dmsKjM0G61eaJ4tWqHEO6w+Ka6gs07jo6ElQ6ufCjWY9JXUQ94+
 4W9uZQEkZbDONVErMo1kvfIUX5a9YaRNpePAk6uTr/k/YsYzP645wRCan3uLem+FSGSMsCEJe8u
 hIqvTr6Rw=
X-Received: by 2002:a05:7022:38b:b0:1aa:47e7:97e3 with SMTP id
 a92af1059eb24-1ac5c45fd1dmr15128808c88.15.1793575318672; 
 Sun, 01 Nov 2026 15:21:58 -0800 (PST)
Received: from kev-ws-aurora.cv0.bbox.io ([172.83.102.10])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1ac194b5437sm31982675c88.13.2026.11.01.15.21.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Nov 2026 15:21:57 -0800 (PST)
From: Kevin Bowling <kevin.bowling@kev009.com>
To: dev@dpdk.org
Cc: Thomas Monjalon <thomas@monjalon.net>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH RESEND 2/3] kernel/freebsd: add single-vector MSI-X support
Date: Sun,  1 Nov 2026 16:21:52 -0700
Message-ID: <20261101232154.94354-3-kevin.bowling@kev009.com>
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

Add an optional interrupt interface to the FreeBSD UIO module. A writable
file may reserve MSI-X vector zero, enable or disable its kernel handler,
and receive a cumulative 32-bit event count through read and EVFILT_READ.
Device-specific interrupt acknowledgment remains the PMD's responsibility.

One open file description owns the vector; other opens can still map
BARs. Serialize BAR allocation and IRQ lifecycle operations, preserve
pending events across failed copyout, and release the handler and vector
when the owner's last reference closes. Refuse detach while device files
remain open and publish initialized device state atomically.

Enable bus mastering on the first writable open and disable it on the
last writable close, including process exit. Preserve DMA across temporary
BAR-mapping opens, duplicated descriptors, and secondary processes.
Read-only opens neither enable DMA nor retain it after the last writer
exits. Disable bus mastering before publishing or detaching the device.

Use PCI interrupt setup and teardown to unmask and mask the MSI-X vector.
Support control events only; MSI, INTx, and per-queue Rx interrupts are
outside this interface.

Add a hardware lifecycle regression covering ioctl permissions, mapping
and descriptor lifetime, ownership transfer, fork, and SIGKILL. Document
that applications must retain a writable descriptor while using DMA.

Signed-off-by: Kevin Bowling <kevin.bowling@kev009.com>
---
 MAINTAINERS                           |   1 +
 app/test/test_nic_uio.py              | 140 ++++++++++
 doc/guides/freebsd_gsg/build_dpdk.rst |  25 ++
 kernel/freebsd/nic_uio/meson.build    |   2 +-
 kernel/freebsd/nic_uio/nic_uio.c      | 364 +++++++++++++++++++++++---
 kernel/freebsd/nic_uio/nic_uio.h      |  33 +++
 6 files changed, 531 insertions(+), 34 deletions(-)
 create mode 100644 app/test/test_nic_uio.py
 create mode 100644 kernel/freebsd/nic_uio/nic_uio.h

diff --git a/MAINTAINERS b/MAINTAINERS
index f78126b03d..435343e5d7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -393,6 +393,7 @@ F: kernel/freebsd/contigmem/
 FreeBSD UIO
 M: Bruce Richardson <bruce.richardson@intel.com>
 F: kernel/freebsd/nic_uio/
+F: app/test/test_nic_uio.py
 
 Windows support
 M: Dmitry Kozlyuk <dmitry.kozliuk@gmail.com>
diff --git a/app/test/test_nic_uio.py b/app/test/test_nic_uio.py
new file mode 100644
index 0000000000..721ca9c1e3
--- /dev/null
+++ b/app/test/test_nic_uio.py
@@ -0,0 +1,140 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: BSD-3-Clause
+# Copyright(c) 2026 Kevin Bowling
+
+"""Exercise an idle FreeBSD nic_uio device; requires root and MSI-X hardware."""
+
+import argparse
+import ctypes
+import errno
+import fcntl
+import mmap
+import os
+import signal
+import subprocess
+
+INIT, ENABLE, DISABLE = (0x20004E00 + i for i in (1, 2, 3))
+LIBC = ctypes.CDLL(None, use_errno=True)
+LIBC.mmap.argtypes = (
+    ctypes.c_void_p,
+    ctypes.c_size_t,
+    ctypes.c_int,
+    ctypes.c_int,
+    ctypes.c_int,
+    ctypes.c_int64,
+)
+LIBC.mmap.restype = ctypes.c_void_p
+LIBC.munmap.argtypes = (ctypes.c_void_p, ctypes.c_size_t)
+
+
+def expect_errno(fd, command, expected):
+    try:
+        fcntl.ioctl(fd, command)
+    except OSError as error:
+        assert error.errno == expected, error
+    else:
+        raise AssertionError(f"ioctl {command:#x} unexpectedly succeeded")
+
+
+def busmaster(pci, enabled):
+    command = int(subprocess.check_output(["pciconf", "-r", "-h", pci, "4"], text=True).strip(), 16)
+    assert command != 0xFFFF and bool(command & 4) == enabled, hex(command)
+
+
+def lifecycle(device, pci):
+    busmaster(pci, False)
+    readonly = os.open(device, os.O_RDONLY | os.O_NONBLOCK)
+    try:
+        busmaster(pci, False)
+        for command in (INIT, ENABLE, DISABLE):
+            expect_errno(readonly, command, errno.EBADF)
+        expect_errno(readonly, 0x20004EFF, errno.ENOTTY)
+
+        owner = os.open(device, os.O_RDWR | os.O_NONBLOCK)
+        try:
+            busmaster(pci, True)
+            fcntl.ioctl(owner, INIT)
+            fcntl.ioctl(owner, ENABLE)
+            mapping_fd = os.open(device, os.O_RDWR)
+            try:
+                # Python's mmap object retains a duplicate fd. Use the
+                # syscall directly to test the mapping's kernel lifetime.
+                mapping = LIBC.mmap(
+                    None,
+                    mmap.PAGESIZE,
+                    mmap.PROT_READ | mmap.PROT_WRITE,
+                    mmap.MAP_SHARED,
+                    mapping_fd,
+                    0,
+                )
+                assert mapping != ctypes.c_void_p(-1).value, ctypes.get_errno()
+            finally:
+                os.close(mapping_fd)
+            try:
+                busmaster(pci, True)
+                duplicate = os.dup(owner)
+                try:
+                    os.close(owner)
+                    owner = -1
+                    busmaster(pci, True)
+                    other = os.open(device, os.O_RDWR)
+                    try:
+                        expect_errno(other, INIT, errno.EBUSY)
+                        os.close(duplicate)
+                        duplicate = -1
+                        busmaster(pci, True)
+                        fcntl.ioctl(other, INIT)
+                        fcntl.ioctl(other, ENABLE)
+                    finally:
+                        os.close(other)
+                finally:
+                    if duplicate >= 0:
+                        os.close(duplicate)
+                # Neither an mmap nor a read-only descriptor retains DMA.
+                busmaster(pci, False)
+            finally:
+                assert LIBC.munmap(mapping, mmap.PAGESIZE) == 0
+        finally:
+            if owner >= 0:
+                os.close(owner)
+
+        owner = os.open(device, os.O_RDWR)
+        try:
+            busmaster(pci, True)
+            fcntl.ioctl(owner, INIT)
+            fcntl.ioctl(owner, ENABLE)
+            child = os.fork()
+            if child == 0:
+                while True:
+                    signal.pause()
+            try:
+                os.close(owner)
+                owner = -1
+                busmaster(pci, True)
+            finally:
+                os.kill(child, signal.SIGKILL)
+                _, status = os.waitpid(child, 0)
+                assert os.WIFSIGNALED(status)
+            busmaster(pci, False)
+        finally:
+            if owner >= 0:
+                os.close(owner)
+    finally:
+        os.close(readonly)
+    busmaster(pci, False)
+
+
+def main():
+    parser = argparse.ArgumentParser(description=__doc__)
+    parser.add_argument("device", help="idle nic_uio device node")
+    parser.add_argument("pci", help="matching pciconf selector, e.g. pci0:2:16:0")
+    args = parser.parse_args()
+    if os.geteuid() != 0:
+        parser.error("root is required")
+    for repetition in range(1, 4):
+        lifecycle(args.device, args.pci)
+        print(f"PASS lifecycle repetition {repetition}", flush=True)
+
+
+if __name__ == "__main__":
+    main()
diff --git a/doc/guides/freebsd_gsg/build_dpdk.rst b/doc/guides/freebsd_gsg/build_dpdk.rst
index 9dafa64e84..48e499b6ca 100644
--- a/doc/guides/freebsd_gsg/build_dpdk.rst
+++ b/doc/guides/freebsd_gsg/build_dpdk.rst
@@ -158,6 +158,31 @@ To avoid this error, reduce the number of buffers or the buffer size.
 Loading the DPDK nic_uio Module
 -------------------------------
 
+The module supports one MSI-X vector per PCI function for control events,
+such as AdminQ messages and link changes. Interrupt resources are allocated
+only when an application requests them through the initialization ioctl.
+The application retains responsibility for acknowledging and rearming
+device interrupt causes.
+Per-queue Rx interrupts, MSI, and legacy INTx interrupts are not supported.
+
+The interrupt interface is optional. Applications can use the updated
+module without allocating interrupts.
+The file description that initializes interrupts owns the vector until its
+last reference is closed; other opens can still map device BARs. Detaching
+the device is refused while device files remain open.
+
+Interrupt-control ioctls require a writable descriptor. Bus mastering is
+enabled by the first writable open and disabled by the last writable close,
+including process exit. Temporary BAR-mapping opens do not interrupt DMA
+while another writable descriptor remains open. Applications must retain a
+writable descriptor while using DMA; a BAR mapping or read-only descriptor
+alone does not keep it enabled. This does not provide IOMMU isolation.
+
+The hardware lifecycle test requires an idle MSI-X device already bound to
+``nic_uio``. Run it as root with its device node and matching PCI selector::
+
+    python3 app/test/test_nic_uio.py /dev/uio@pci:2:16:0 pci0:2:16:0
+
 After loading the contigmem module, the ``nic_uio`` module must also be loaded into the
 running kernel prior to running any DPDK application, e.g. using::
 
diff --git a/kernel/freebsd/nic_uio/meson.build b/kernel/freebsd/nic_uio/meson.build
index 4bdaf96944..b4e73dccdf 100644
--- a/kernel/freebsd/nic_uio/meson.build
+++ b/kernel/freebsd/nic_uio/meson.build
@@ -1,4 +1,4 @@
 # SPDX-License-Identifier: BSD-3-Clause
 # Copyright(c) 2017 Intel Corporation
 
-sources = files('nic_uio.c')
+sources = files('nic_uio.c', 'nic_uio.h')
diff --git a/kernel/freebsd/nic_uio/nic_uio.c b/kernel/freebsd/nic_uio/nic_uio.c
index 0043892870..34086d7f3d 100644
--- a/kernel/freebsd/nic_uio/nic_uio.c
+++ b/kernel/freebsd/nic_uio/nic_uio.c
@@ -12,7 +12,13 @@ __FBSDID("$FreeBSD$");
 #include <sys/rman.h>
 #include <sys/systm.h>
 #include <sys/lock.h>
+#include <sys/malloc.h>
+#include <sys/mutex.h>
 #include <sys/rwlock.h>
+#include <sys/sx.h>
+#include <sys/event.h>
+#include <sys/fcntl.h>
+#include <sys/uio.h>
 #include <sys/proc.h>
 
 #include <machine/bus.h>
@@ -24,6 +30,11 @@ __FBSDID("$FreeBSD$");
 #include <vm/vm_page.h>
 #include <vm/vm_pager.h>
 
+#include "nic_uio.h"
+
+static MALLOC_DEFINE(M_NIC_UIO, "nic_uio", "DPDK interrupt owner");
+
+struct nic_uio_file;
 
 #define MAX_BARS (PCIR_MAX_BAR_0 + 1)
 
@@ -38,11 +49,29 @@ struct nic_uio_softc {
 	struct resource *bar_res[MAX_BARS];
 	u_long           bar_start[MAX_BARS];
 	u_long           bar_size[MAX_BARS];
+	struct sx        lock;
+	struct mtx       event_lock;
+	struct resource *irq;
+	void            *irq_cookie;
+	struct nic_uio_file *owner;
+	unsigned int     opens;
+	unsigned int     writers;
+	bool             detaching;
+};
+
+struct nic_uio_file {
+	struct nic_uio_softc *sc;
+	struct knlist    knlist;
+	uint32_t        events;
+	uint32_t        consumed;
+	bool            writable;
 };
 
 /* Function prototypes */
 static d_open_t         nic_uio_open;
-static d_close_t        nic_uio_close;
+static d_read_t         nic_uio_read;
+static d_ioctl_t        nic_uio_ioctl;
+static d_kqfilter_t     nic_uio_kqfilter;
 static d_mmap_t         nic_uio_mmap;
 static d_mmap_single_t  nic_uio_mmap_single;
 static int              nic_uio_probe(device_t dev);
@@ -55,7 +84,9 @@ static struct cdevsw uio_cdevsw = {
 		.d_name        = "nic_uio",
 		.d_version     = D_VERSION,
 		.d_open        = nic_uio_open,
-		.d_close       = nic_uio_close,
+		.d_read        = nic_uio_read,
+		.d_ioctl       = nic_uio_ioctl,
+		.d_kqfilter    = nic_uio_kqfilter,
 		.d_mmap        = nic_uio_mmap,
 		.d_mmap_single = nic_uio_mmap_single,
 };
@@ -95,6 +126,24 @@ nic_uio_mmap(struct cdev *cdev, vm_ooffset_t offset, vm_paddr_t *paddr,
 	return 0;
 }
 
+static int
+nic_uio_alloc_bar(struct nic_uio_softc *sc, unsigned int bar)
+{
+	int type;
+
+	sx_assert(&sc->lock, SA_XLOCKED);
+	if (bar >= MAX_BARS)
+		return EINVAL;
+	if (sc->bar_res[bar] != NULL)
+		return 0;
+	sc->bar_id[bar] = PCIR_BAR(bar);
+	type = PCI_BAR_IO(pci_read_config(sc->dev_t, sc->bar_id[bar], 4)) ?
+		SYS_RES_IOPORT : SYS_RES_MEMORY;
+	sc->bar_res[bar] = bus_alloc_resource_any(sc->dev_t, type,
+		&sc->bar_id[bar], RF_ACTIVE);
+	return sc->bar_res[bar] == NULL ? ENXIO : 0;
+}
+
 static int
 nic_uio_mmap_single(struct cdev *cdev, vm_ooffset_t *offset, vm_size_t size,
 		struct vm_object **obj, int nprot)
@@ -106,22 +155,14 @@ nic_uio_mmap_single(struct cdev *cdev, vm_ooffset_t *offset, vm_size_t size,
 	 */
 	unsigned bar = *offset/PAGE_SIZE;
 	struct nic_uio_softc *sc = cdev->si_drv1;
+	int error;
 
-	if (bar >= MAX_BARS)
-		return EINVAL;
-
-	if (sc->bar_res[bar] == NULL) {
-		sc->bar_id[bar] = PCIR_BAR(bar);
-
-		if (PCI_BAR_IO(pci_read_config(sc->dev_t, sc->bar_id[bar], 4)))
-			sc->bar_res[bar] = bus_alloc_resource_any(sc->dev_t, SYS_RES_IOPORT,
-					&sc->bar_id[bar], RF_ACTIVE);
-		else
-			sc->bar_res[bar] = bus_alloc_resource_any(sc->dev_t, SYS_RES_MEMORY,
-					&sc->bar_id[bar], RF_ACTIVE);
+	sx_xlock(&sc->lock);
+	error = nic_uio_alloc_bar(sc, bar);
+	if (error != 0) {
+		sx_xunlock(&sc->lock);
+		return error;
 	}
-	if (sc->bar_res[bar] == NULL)
-		return ENXIO;
 
 	sc->bar_start[bar] = rman_get_start(sc->bar_res[bar]);
 	sc->bar_size[bar] = rman_get_size(sc->bar_res[bar]);
@@ -132,20 +173,249 @@ nic_uio_mmap_single(struct cdev *cdev, vm_ooffset_t *offset, vm_size_t size,
 	*offset = sc->bar_start[bar];
 	*obj = vm_pager_allocate(OBJT_DEVICE, cdev, size, nprot, *offset,
 				curthread->td_ucred);
+	sx_xunlock(&sc->lock);
 	return 0;
 }
 
+static void
+nic_uio_intr(void *arg)
+{
+	struct nic_uio_softc *sc = arg;
+	struct nic_uio_file *priv;
+
+	mtx_lock(&sc->event_lock);
+	priv = sc->owner;
+	priv->events++;
+	KNOTE_LOCKED(&priv->knlist, 0);
+	mtx_unlock(&sc->event_lock);
+}
 
-int
-nic_uio_open(struct cdev *dev, int oflags, int devtype, struct thread *td)
+static void
+nic_uio_irq_disable(struct nic_uio_softc *sc)
+{
+	sx_assert(&sc->lock, SA_XLOCKED);
+	if (sc->irq_cookie != NULL) {
+		bus_teardown_intr(sc->dev_t, sc->irq, sc->irq_cookie);
+		sc->irq_cookie = NULL;
+	}
+}
+
+static int
+nic_uio_irq_init(struct nic_uio_file *priv)
 {
+	struct nic_uio_softc *sc = priv->sc;
+	int count = 1, rid = 1, error;
+
+	sx_assert(&sc->lock, SA_XLOCKED);
+	if (sc->owner != NULL)
+		return sc->owner == priv ? 0 : EBUSY;
+	if (pci_msix_count(sc->dev_t) == 0)
+		return EOPNOTSUPP;
+	error = nic_uio_alloc_bar(sc, PCI_RID2BAR(pci_msix_table_bar(sc->dev_t)));
+	if (error != 0)
+		return error;
+	error = nic_uio_alloc_bar(sc, PCI_RID2BAR(pci_msix_pba_bar(sc->dev_t)));
+	if (error != 0)
+		return error;
+	error = pci_alloc_msix(sc->dev_t, &count);
+	if (error != 0)
+		return error;
+	sc->irq = bus_alloc_resource_any(sc->dev_t, SYS_RES_IRQ, &rid, RF_ACTIVE);
+	if (sc->irq == NULL) {
+		pci_release_msi(sc->dev_t);
+		return ENXIO;
+	}
+	mtx_lock(&sc->event_lock);
+	sc->owner = priv;
+	mtx_unlock(&sc->event_lock);
 	return 0;
 }
 
+static void
+nic_uio_disable_busmaster(struct nic_uio_softc *sc)
+{
+	int error;
+
+	sx_assert(&sc->lock, SA_XLOCKED);
+	error = pci_disable_busmaster(sc->dev_t);
+	if (error != 0)
+		device_printf(sc->dev_t, "Cannot disable bus mastering: %d\n", error);
+}
+
+static void
+nic_uio_file_destroy(void *arg)
+{
+	struct nic_uio_file *priv = arg;
+	struct nic_uio_softc *sc = priv->sc;
+
+	sx_xlock(&sc->lock);
+	KASSERT(sc->opens != 0, ("nic_uio open count underflow"));
+	KASSERT(!priv->writable || sc->writers != 0,
+		("nic_uio writable open count underflow"));
+	if (priv->writable && --sc->writers == 0)
+		nic_uio_disable_busmaster(sc);
+	if (sc->owner == priv) {
+		nic_uio_irq_disable(sc);
+		bus_release_resource(sc->dev_t, SYS_RES_IRQ, 1, sc->irq);
+		pci_release_msi(sc->dev_t);
+		sc->irq = NULL;
+		mtx_lock(&sc->event_lock);
+		sc->owner = NULL;
+		mtx_unlock(&sc->event_lock);
+	}
+	knlist_clear(&priv->knlist, 0);
+	knlist_destroy(&priv->knlist);
+	free(priv, M_NIC_UIO);
+	sc->opens--;
+	sx_xunlock(&sc->lock);
+}
+
 int
-nic_uio_close(struct cdev *dev, int fflag, int devtype, struct thread *td)
+nic_uio_open(struct cdev *dev, int oflags, int devtype, struct thread *td)
 {
-	return 0;
+	struct nic_uio_softc *sc = dev->si_drv1;
+	struct nic_uio_file *priv;
+	int error;
+
+	priv = malloc(sizeof(*priv), M_NIC_UIO, M_WAITOK | M_ZERO);
+	priv->sc = sc;
+	priv->writable = (oflags & FWRITE) != 0;
+	knlist_init_mtx(&priv->knlist, &sc->event_lock);
+	sx_xlock(&sc->lock);
+	error = sc->detaching ? ENXIO : 0;
+	if (error == 0 && priv->writable && sc->writers == 0)
+		error = pci_enable_busmaster(sc->dev_t);
+	if (error == 0)
+		error = devfs_set_cdevpriv(priv, nic_uio_file_destroy);
+	if (error == 0) {
+		sc->opens++;
+		if (priv->writable)
+			sc->writers++;
+	} else {
+		if (!sc->detaching && priv->writable && sc->writers == 0)
+			nic_uio_disable_busmaster(sc);
+		knlist_destroy(&priv->knlist);
+		free(priv, M_NIC_UIO);
+	}
+	sx_xunlock(&sc->lock);
+	return error;
+}
+
+static int
+nic_uio_ioctl(struct cdev *dev, u_long cmd, caddr_t data, int fflag,
+		struct thread *td)
+{
+	struct nic_uio_file *priv;
+	struct nic_uio_softc *sc;
+	int error;
+
+	if (cmd != NIC_UIO_IRQ_INIT && cmd != NIC_UIO_IRQ_ENABLE &&
+			cmd != NIC_UIO_IRQ_DISABLE)
+		return ENOTTY;
+	if ((fflag & FWRITE) == 0)
+		return EBADF;
+	error = devfs_get_cdevpriv((void **)&priv);
+	if (error != 0)
+		return error;
+	sc = priv->sc;
+	sx_xlock(&sc->lock);
+	if (cmd == NIC_UIO_IRQ_INIT) {
+		error = nic_uio_irq_init(priv);
+	} else if (sc->owner != priv) {
+		error = EPERM;
+	} else if (cmd == NIC_UIO_IRQ_DISABLE) {
+		nic_uio_irq_disable(sc);
+	} else if (sc->irq_cookie == NULL) {
+		error = bus_setup_intr(sc->dev_t, sc->irq,
+				INTR_TYPE_NET | INTR_MPSAFE, NULL, nic_uio_intr,
+				sc, &sc->irq_cookie);
+	}
+	sx_xunlock(&sc->lock);
+	return error;
+}
+
+static int
+nic_uio_read(struct cdev *dev, struct uio *uio, int ioflag)
+{
+	struct nic_uio_file *priv;
+	struct nic_uio_softc *sc;
+	uint32_t events;
+	int error;
+
+	if (uio->uio_resid < sizeof(events))
+		return EINVAL;
+	error = devfs_get_cdevpriv((void **)&priv);
+	if (error != 0)
+		return error;
+	sc = priv->sc;
+	/* Serialize readers while copying out without holding the event mutex. */
+	sx_xlock(&sc->lock);
+	mtx_lock(&sc->event_lock);
+	events = priv->events;
+	if (sc->owner != priv)
+		error = EPERM;
+	else if (events == priv->consumed)
+		error = EAGAIN;
+	mtx_unlock(&sc->event_lock);
+	if (error == 0) {
+		error = uiomove(&events, sizeof(events), uio);
+		if (error == 0) {
+			mtx_lock(&sc->event_lock);
+			priv->consumed = events;
+			mtx_unlock(&sc->event_lock);
+		}
+	}
+	sx_xunlock(&sc->lock);
+	return error;
+}
+
+static void
+nic_uio_filter_detach(struct knote *kn)
+{
+	struct nic_uio_file *priv = kn->kn_hook;
+
+	knlist_remove(&priv->knlist, kn, 0);
+}
+
+static int
+nic_uio_filter_read(struct knote *kn, long hint)
+{
+	struct nic_uio_file *priv = kn->kn_hook;
+
+	mtx_assert(&priv->sc->event_lock, MA_OWNED);
+	kn->kn_data = priv->events != priv->consumed ? sizeof(uint32_t) : 0;
+	return kn->kn_data != 0;
+}
+
+static const struct filterops nic_uio_read_filter = {
+	.f_isfd = 1,
+	.f_detach = nic_uio_filter_detach,
+	.f_event = nic_uio_filter_read,
+};
+
+static int
+nic_uio_kqfilter(struct cdev *dev, struct knote *kn)
+{
+	struct nic_uio_file *priv;
+	struct nic_uio_softc *sc;
+	int error;
+
+	if (kn->kn_filter != EVFILT_READ)
+		return EINVAL;
+	error = devfs_get_cdevpriv((void **)&priv);
+	if (error != 0)
+		return error;
+	sc = priv->sc;
+	mtx_lock(&sc->event_lock);
+	if (sc->owner != priv) {
+		error = ENODEV;
+	} else {
+		kn->kn_hook = priv;
+		kn->kn_fop = &nic_uio_read_filter;
+		knlist_add(&priv->knlist, kn, 1);
+	}
+	mtx_unlock(&sc->event_lock);
+	return error;
 }
 
 static int
@@ -213,33 +483,61 @@ nic_uio_probe (device_t dev)
 static int
 nic_uio_attach(device_t dev)
 {
-	int i;
+	struct make_dev_args args;
+	int i, error;
 	struct nic_uio_softc *sc;
 
 	sc = device_get_softc(dev);
 	sc->dev_t = dev;
-	sc->my_cdev = make_dev(&uio_cdevsw, device_get_unit(dev),
-			UID_ROOT, GID_WHEEL, 0600, "uio@pci:%u:%u:%u",
-			pci_get_bus(dev), pci_get_slot(dev), pci_get_function(dev));
-	if (sc->my_cdev == NULL)
-		return ENXIO;
-	sc->my_cdev->si_drv1 = sc;
+	sx_init(&sc->lock, "nic_uio");
+	mtx_init(&sc->event_lock, "nic_uio events", NULL, MTX_DEF);
 
 	for (i = 0; i < MAX_BARS; i++)
 		sc->bar_res[i] = NULL;
-
-	pci_enable_busmaster(dev);
-
+	/* Leave DMA disabled until a writable device file is opened. */
+	error = pci_disable_busmaster(dev);
+	if (error != 0)
+		goto fail;
+	make_dev_args_init(&args);
+	args.mda_devsw = &uio_cdevsw;
+	args.mda_uid = UID_ROOT;
+	args.mda_gid = GID_WHEEL;
+	args.mda_mode = 0600;
+	args.mda_si_drv1 = sc;
+	args.mda_flags = MAKEDEV_WAITOK | MAKEDEV_CHECKNAME;
+	error = make_dev_s(&args, &sc->my_cdev, "uio@pci:%u:%u:%u",
+		pci_get_bus(dev), pci_get_slot(dev), pci_get_function(dev));
+	if (error != 0)
+		goto fail;
 	return 0;
+
+fail:
+	mtx_destroy(&sc->event_lock);
+	sx_destroy(&sc->lock);
+	return error;
 }
 
 static int
 nic_uio_detach(device_t dev)
 {
-	int i;
+	int i, error;
 	struct nic_uio_softc *sc;
 	sc = device_get_softc(dev);
 
+	sx_xlock(&sc->lock);
+	if (sc->opens != 0) {
+		sx_xunlock(&sc->lock);
+		return EBUSY;
+	}
+	error = pci_disable_busmaster(dev);
+	if (error != 0) {
+		sx_xunlock(&sc->lock);
+		return error;
+	}
+	sc->detaching = true;
+	sx_xunlock(&sc->lock);
+	destroy_dev(sc->my_cdev);
+
 	for (i = 0; i < MAX_BARS; i++)
 		if (sc->bar_res[i] != NULL) {
 
@@ -251,8 +549,8 @@ nic_uio_detach(device_t dev)
 						sc->bar_res[i]);
 		}
 
-	if (sc->my_cdev != NULL)
-		destroy_dev(sc->my_cdev);
+	mtx_destroy(&sc->event_lock);
+	sx_destroy(&sc->lock);
 	return 0;
 }
 
diff --git a/kernel/freebsd/nic_uio/nic_uio.h b/kernel/freebsd/nic_uio/nic_uio.h
new file mode 100644
index 0000000000..7061d4fccf
--- /dev/null
+++ b/kernel/freebsd/nic_uio/nic_uio.h
@@ -0,0 +1,33 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2026 Kevin Bowling
+ */
+
+#ifndef NIC_UIO_H
+#define NIC_UIO_H
+
+#include <sys/ioccom.h>
+
+/*
+ * Optional single-vector MSI-X interface. INIT reserves vector zero for this
+ * open file description; other opens may still mmap the BARs. Repeating INIT
+ * on the owner is harmless. Closing the owner releases the interrupt.
+ *
+ * ENABLE installs the handler and unmasks the vector; DISABLE removes the
+ * handler and masks the vector. Neither operation acknowledges device-specific
+ * interrupt causes: that remains the PMD's responsibility.
+ *
+ * EVFILT_READ reports unread interrupts. read() returns a native uint32_t
+ * cumulative event count, or EAGAIN when there is no unread event. Counts wrap.
+ * An older module rejects INIT with ENOTTY and continues to support BAR mmap.
+ * All interrupt-control ioctls require a writable descriptor.
+ *
+ * The first writable open enables bus mastering; the last writable close
+ * disables it, including process exit. dup() and fork() retain that open file
+ * description. A BAR mapping alone does not keep DMA enabled: applications
+ * must keep a writable descriptor open while using the device for DMA.
+ */
+#define NIC_UIO_IRQ_INIT		_IO('N', 1)
+#define NIC_UIO_IRQ_ENABLE	_IO('N', 2)
+#define NIC_UIO_IRQ_DISABLE	_IO('N', 3)
+
+#endif /* NIC_UIO_H */
-- 
2.56.0

