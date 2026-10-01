Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C183CA5FB3
	for <dpdk-dev@archiver.kernel.org>; Thu,  1 Oct 2026 09:06:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DEC644027A;
	Thu,  1 Oct 2026 11:06:12 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 7C6A540144
 for <dev@dpdk.org>; Thu,  1 Oct 2026 11:06:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790845570;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WXxjIMdsSL04iLusdeJaOx/2PaPCvUXjEfKGhXixn2s=;
 b=Nb2tHLALq1LPps84eBsm8tGA6DFYKbGFibcyPcef+88R2yAo/PqzzFpg5xnM8xPbLlD1j2
 wrTQlPiJXtOOuLyaRNMEYFMVgoYvyMqQJNWIsFxkvySme9DcEnbFwSqwbYDhA6LiM6sft8
 RPMbkaAfwmckKJ1YN5hllLQBZSlGZUo=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-604-zHleDYpRNiuMQmGYdyopdg-1; Thu,
 01 Oct 2026 05:06:07 -0400
X-MC-Unique: zHleDYpRNiuMQmGYdyopdg-1
X-Mimecast-MFC-AGG-ID: zHleDYpRNiuMQmGYdyopdg_1790845566
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CB03B1979044; Thu,  1 Oct 2026 09:06:05 +0000 (UTC)
Received: from dmarchan.redhat.corp
 (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E6F43195604D; Thu,  1 Oct 2026 09:06:03 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: eperezma@redhat.com, maxime.coquelin@redhat.com, thomas@monjalon.net,
 stephen@networkplumber.org
Subject: [PATCH v2] uapi: update headers to v6.19
Date: Thu,  1 Oct 2026 11:05:58 +0200
Message-ID: <20261001090558.1131763-1-david.marchand@redhat.com>
In-Reply-To: <20260930095800.551314-1-maxime.coquelin@redhat.com>
References: <20260930095800.551314-1-maxime.coquelin@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: OwWvNkg-MJB105I8GMIcu4f1DB3GZd2xmbLXluvX5Ug_1790845566
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
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

From: Maxime Coquelin <maxime.coquelin@redhat.com>

This patch updates imported UAPI headers to v6.19, in order
to exercise the new compatibility define for __counted_by.

Since __counted_by is introduced by linux/stddef.h we need to import it,
and the headers, included by already imported headers, leading to its
inclusion.

One complication is that linux/types.h contains a guard that must be
sanitized using the same method as the Linux kernel.
For this, add a dependency on the unifdef tool.

We also need to fix net/nbl which does not include the VFIO uapi header
first.

Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
Signed-off-by: David Marchand <david.marchand@redhat.com>
---
Changes since v1:
- dropped wrapper on __counted_by,
- updated import process and added use of unidef,
- fixed net/nbl driver,
- imported needed uapi headers,

---
 devtools/linux-uapi.sh                   |  6 ++
 doc/guides/contributing/linux_uapi.rst   |  2 +
 drivers/net/nbl/nbl_common/nbl_userdev.c |  3 +-
 kernel/linux/uapi/linux/posix_types.h    | 38 ++++++++++++
 kernel/linux/uapi/linux/stddef.h         | 74 ++++++++++++++++++++++++
 kernel/linux/uapi/linux/types.h          | 58 +++++++++++++++++++
 kernel/linux/uapi/linux/vduse.h          |  4 +-
 kernel/linux/uapi/linux/vfio.h           | 42 +++++++++++++-
 kernel/linux/uapi/version                |  2 +-
 9 files changed, 223 insertions(+), 6 deletions(-)
 create mode 100644 kernel/linux/uapi/linux/posix_types.h
 create mode 100644 kernel/linux/uapi/linux/stddef.h
 create mode 100644 kernel/linux/uapi/linux/types.h

diff --git a/devtools/linux-uapi.sh b/devtools/linux-uapi.sh
index dbf3163bc8..f8b50cf8eb 100755
--- a/devtools/linux-uapi.sh
+++ b/devtools/linux-uapi.sh
@@ -13,6 +13,9 @@ file=""
 check_headers=false
 quiet=false
 
+# Require unifdef
+unifdef -h >/dev/null 2>&1 || { echo "This script requires unifdef."; exit 1; }
+
 print_usage()
 {
 	echo "Usage: $(basename $0) [-h] [-i FILE] [-u VERSION] [-c] [-q]"
@@ -85,6 +88,9 @@ fixup_includes()
 	sed -i 's|#\(define\)[[:space:]]*_UAPI|#\1 |' $path
 	sed -i 's|#\(endif[[:space:]]*/[*]\)[[:space:]]*_UAPI|#\1 |' $path
 
+	unifdef -U__KERNEL__ -D__EXPORTED_HEADERS__ -o ${path}.tmp $path || [ $? -lt 2 ]
+	mv -f ${path}.tmp $path
+
 	# Prepend include path with "uapi/" if the header is imported
 	for include in $(sed -ne 's/^#include <\(.*\)>$/\1/p' $path); do
 		if [ -f "$base_path$include" ]; then
diff --git a/doc/guides/contributing/linux_uapi.rst b/doc/guides/contributing/linux_uapi.rst
index b8febfc420..a3490bfbb6 100644
--- a/doc/guides/contributing/linux_uapi.rst
+++ b/doc/guides/contributing/linux_uapi.rst
@@ -27,6 +27,8 @@ Importing or updating an uAPI header file
 To ensure that imported uAPI headers are unmodified
 and sourced from an official Linux kernel release,
 a helper script is provided and must be used.
+This script requires the ``unifdef`` tool.
+
 Below is an example to import ``linux/vduse.h`` file from Linux ``v6.10``:
 
 .. code-block:: console
diff --git a/drivers/net/nbl/nbl_common/nbl_userdev.c b/drivers/net/nbl/nbl_common/nbl_userdev.c
index ec6840d60e..de7950c57a 100644
--- a/drivers/net/nbl/nbl_common/nbl_userdev.c
+++ b/drivers/net/nbl/nbl_common/nbl_userdev.c
@@ -2,8 +2,9 @@
  * Copyright 2025 Nebulamatrix Technology Co., Ltd.
  */
 
-#include "nbl_userdev.h"
 #include <uapi/linux/vfio.h>
+
+#include "nbl_userdev.h"
 #include <rte_vfio.h>
 
 #define NBL_USERDEV_EVENT_CLB_NAME	"nbl_userspace_mem_event_clb"
diff --git a/kernel/linux/uapi/linux/posix_types.h b/kernel/linux/uapi/linux/posix_types.h
new file mode 100644
index 0000000000..6c55afdf80
--- /dev/null
+++ b/kernel/linux/uapi/linux/posix_types.h
@@ -0,0 +1,38 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#ifndef _LINUX_POSIX_TYPES_H
+#define _LINUX_POSIX_TYPES_H
+
+#include <uapi/linux/stddef.h>
+
+/*
+ * This allows for 1024 file descriptors: if NR_OPEN is ever grown
+ * beyond that you'll have to change this too. But 1024 fd's seem to be
+ * enough even for such "real" unices like OSF/1, so hopefully this is
+ * one limit that doesn't have to be changed [again].
+ *
+ * Note that POSIX wants the FD_CLEAR(fd,fdsetp) defines to be in
+ * <sys/time.h> (and thus <linux/time.h>) - but this is a more logical
+ * place for them. Solved by having dummy defines in <sys/time.h>.
+ */
+
+/*
+ * This macro may have been defined in <gnu/types.h>. But we always
+ * use the one here.
+ */
+#undef __FD_SETSIZE
+#define __FD_SETSIZE	1024
+
+typedef struct {
+	unsigned long fds_bits[__FD_SETSIZE / (8 * sizeof(long))];
+} __kernel_fd_set;
+
+/* Type of a signal handler.  */
+typedef void (*__kernel_sighandler_t)(int);
+
+/* Type of a SYSV IPC key.  */
+typedef int __kernel_key_t;
+typedef int __kernel_mqd_t;
+
+#include <asm/posix_types.h>
+
+#endif /* _LINUX_POSIX_TYPES_H */
diff --git a/kernel/linux/uapi/linux/stddef.h b/kernel/linux/uapi/linux/stddef.h
new file mode 100644
index 0000000000..8ecf96def4
--- /dev/null
+++ b/kernel/linux/uapi/linux/stddef.h
@@ -0,0 +1,74 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#ifndef _LINUX_STDDEF_H
+#define _LINUX_STDDEF_H
+
+
+#ifndef __always_inline
+#define __always_inline inline
+#endif
+
+/* Not all C++ standards support type declarations inside an anonymous union */
+#ifndef __cplusplus
+#define __struct_group_tag(TAG)		TAG
+#else
+#define __struct_group_tag(TAG)
+#endif
+
+/**
+ * __struct_group() - Create a mirrored named and anonyomous struct
+ *
+ * @TAG: The tag name for the named sub-struct (usually empty)
+ * @NAME: The identifier name of the mirrored sub-struct
+ * @ATTRS: Any struct attributes (usually empty)
+ * @MEMBERS: The member declarations for the mirrored structs
+ *
+ * Used to create an anonymous union of two structs with identical layout
+ * and size: one anonymous and one named. The former's members can be used
+ * normally without sub-struct naming, and the latter can be used to
+ * reason about the start, end, and size of the group of struct members.
+ * The named struct can also be explicitly tagged for layer reuse (C only),
+ * as well as both having struct attributes appended.
+ */
+#define __struct_group(TAG, NAME, ATTRS, MEMBERS...) \
+	union { \
+		struct { MEMBERS } ATTRS; \
+		struct __struct_group_tag(TAG) { MEMBERS } ATTRS NAME; \
+	} ATTRS
+
+#ifdef __cplusplus
+/* sizeof(struct{}) is 1 in C++, not 0, can't use C version of the macro. */
+#define __DECLARE_FLEX_ARRAY(T, member)	\
+	T member[0]
+#else
+/**
+ * __DECLARE_FLEX_ARRAY() - Declare a flexible array usable in a union
+ *
+ * @TYPE: The type of each flexible array element
+ * @NAME: The name of the flexible array member
+ *
+ * In order to have a flexible array member in a union or alone in a
+ * struct, it needs to be wrapped in an anonymous struct with at least 1
+ * named member, but that member can be empty.
+ */
+#define __DECLARE_FLEX_ARRAY(TYPE, NAME)	\
+	struct { \
+		struct { } __empty_ ## NAME; \
+		TYPE NAME[]; \
+	}
+#endif
+
+#ifndef __counted_by
+#define __counted_by(m)
+#endif
+
+#ifndef __counted_by_le
+#define __counted_by_le(m)
+#endif
+
+#ifndef __counted_by_be
+#define __counted_by_be(m)
+#endif
+
+#define __kernel_nonstring
+
+#endif /* _LINUX_STDDEF_H */
diff --git a/kernel/linux/uapi/linux/types.h b/kernel/linux/uapi/linux/types.h
new file mode 100644
index 0000000000..912d458e3d
--- /dev/null
+++ b/kernel/linux/uapi/linux/types.h
@@ -0,0 +1,58 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#ifndef _LINUX_TYPES_H
+#define _LINUX_TYPES_H
+
+#include <asm/types.h>
+
+#ifndef __ASSEMBLY__
+
+#include <uapi/linux/posix_types.h>
+
+#ifdef __SIZEOF_INT128__
+typedef __signed__ __int128 __s128 __attribute__((aligned(16)));
+typedef unsigned __int128 __u128 __attribute__((aligned(16)));
+#endif
+
+/*
+ * Below are truly Linux-specific types that should never collide with
+ * any application/library that wants linux/types.h.
+ */
+
+/* sparse defines __CHECKER__; see Documentation/dev-tools/sparse.rst */
+#ifdef __CHECKER__
+#define __bitwise	__attribute__((bitwise))
+#else
+#define __bitwise
+#endif
+
+/* The kernel doesn't use this legacy form, but user space does */
+#define __bitwise__ __bitwise
+
+typedef __u16 __bitwise __le16;
+typedef __u16 __bitwise __be16;
+typedef __u32 __bitwise __le32;
+typedef __u32 __bitwise __be32;
+typedef __u64 __bitwise __le64;
+typedef __u64 __bitwise __be64;
+
+typedef __u16 __bitwise __sum16;
+typedef __u32 __bitwise __wsum;
+
+/*
+ * aligned_u64 should be used in defining kernel<->userspace ABIs to avoid
+ * common 32/64-bit compat problems.
+ * 64-bit values align to 4-byte boundaries on x86_32 (and possibly other
+ * architectures) and to 8-byte boundaries on 64-bit architectures.  The new
+ * aligned_64 type enforces 8-byte alignment so that structs containing
+ * aligned_64 values have the same alignment on 32-bit and 64-bit architectures.
+ * No conversions are necessary between 32-bit user-space and a 64-bit kernel.
+ */
+#define __aligned_u64 __u64 __attribute__((aligned(8)))
+#define __aligned_s64 __s64 __attribute__((aligned(8)))
+#define __aligned_be64 __be64 __attribute__((aligned(8)))
+#define __aligned_le64 __le64 __attribute__((aligned(8)))
+
+typedef unsigned __bitwise __poll_t;
+
+#endif /*  __ASSEMBLY__ */
+#endif /* _LINUX_TYPES_H */
diff --git a/kernel/linux/uapi/linux/vduse.h b/kernel/linux/uapi/linux/vduse.h
index f46269af34..6e4c67a00f 100644
--- a/kernel/linux/uapi/linux/vduse.h
+++ b/kernel/linux/uapi/linux/vduse.h
@@ -2,7 +2,7 @@
 #ifndef _VDUSE_H_
 #define _VDUSE_H_
 
-#include <linux/types.h>
+#include <uapi/linux/types.h>
 
 #define VDUSE_BASE	0x81
 
@@ -237,7 +237,7 @@ struct vduse_iova_umem {
  * struct vduse_iova_info - information of one IOVA region
  * @start: start of the IOVA region
  * @last: last of the IOVA region
- * @capability: capability of the IOVA regsion
+ * @capability: capability of the IOVA region
  * @reserved: for future use, needs to be initialized to zero
  *
  * Structure used by VDUSE_IOTLB_GET_INFO ioctl to get information of
diff --git a/kernel/linux/uapi/linux/vfio.h b/kernel/linux/uapi/linux/vfio.h
index 79bf8c0cc5..c2e4839f83 100644
--- a/kernel/linux/uapi/linux/vfio.h
+++ b/kernel/linux/uapi/linux/vfio.h
@@ -12,8 +12,9 @@
 #ifndef VFIO_H
 #define VFIO_H
 
-#include <linux/types.h>
+#include <uapi/linux/types.h>
 #include <linux/ioctl.h>
+#include <uapi/linux/stddef.h>
 
 #define VFIO_API_VERSION	0
 
@@ -905,10 +906,12 @@ struct vfio_device_feature {
  * VFIO_DEVICE_BIND_IOMMUFD - _IOR(VFIO_TYPE, VFIO_BASE + 18,
  *				   struct vfio_device_bind_iommufd)
  * @argsz:	 User filled size of this data.
- * @flags:	 Must be 0.
+ * @flags:	 Must be 0 or a bit flags of VFIO_DEVICE_BIND_*
  * @iommufd:	 iommufd to bind.
  * @out_devid:	 The device id generated by this bind. devid is a handle for
  *		 this device/iommufd bond and can be used in IOMMUFD commands.
+ * @token_uuid_ptr: Valid if VFIO_DEVICE_BIND_FLAG_TOKEN. Points to a 16 byte
+ *                  UUID in the same format as VFIO_DEVICE_FEATURE_PCI_VF_TOKEN.
  *
  * Bind a vfio_device to the specified iommufd.
  *
@@ -917,13 +920,21 @@ struct vfio_device_feature {
  *
  * Unbind is automatically conducted when device fd is closed.
  *
+ * A token is sometimes required to open the device, unless this is known to be
+ * needed VFIO_DEVICE_BIND_FLAG_TOKEN should not be set and token_uuid_ptr is
+ * ignored. The only case today is a PF/VF relationship where the VF bind must
+ * be provided the same token as VFIO_DEVICE_FEATURE_PCI_VF_TOKEN provided to
+ * the PF.
+ *
  * Return: 0 on success, -errno on failure.
  */
 struct vfio_device_bind_iommufd {
 	__u32		argsz;
 	__u32		flags;
+#define VFIO_DEVICE_BIND_FLAG_TOKEN (1 << 0)
 	__s32		iommufd;
 	__u32		out_devid;
+	__aligned_u64	token_uuid_ptr;
 };
 
 #define VFIO_DEVICE_BIND_IOMMUFD	_IO(VFIO_TYPE, VFIO_BASE + 18)
@@ -1468,6 +1479,33 @@ struct vfio_device_feature_bus_master {
 };
 #define VFIO_DEVICE_FEATURE_BUS_MASTER 10
 
+/**
+ * Upon VFIO_DEVICE_FEATURE_GET create a dma_buf fd for the
+ * regions selected.
+ *
+ * open_flags are the typical flags passed to open(2), eg O_RDWR, O_CLOEXEC,
+ * etc. offset/length specify a slice of the region to create the dmabuf from.
+ * nr_ranges is the total number of (P2P DMA) ranges that comprise the dmabuf.
+ *
+ * flags should be 0.
+ *
+ * Return: The fd number on success, -1 and errno is set on failure.
+ */
+#define VFIO_DEVICE_FEATURE_DMA_BUF 11
+
+struct vfio_region_dma_range {
+	__u64 offset;
+	__u64 length;
+};
+
+struct vfio_device_feature_dma_buf {
+	__u32	region_index;
+	__u32	open_flags;
+	__u32   flags;
+	__u32   nr_ranges;
+	struct vfio_region_dma_range dma_ranges[] __counted_by(nr_ranges);
+};
+
 /* -------- API for Type1 VFIO IOMMU -------- */
 
 /**
diff --git a/kernel/linux/uapi/version b/kernel/linux/uapi/version
index 966a998301..69f29b2320 100644
--- a/kernel/linux/uapi/version
+++ b/kernel/linux/uapi/version
@@ -1 +1 @@
-v6.16
+v6.19
-- 
2.54.0

