Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAF34CA600D
	for <dpdk-dev@archiver.kernel.org>; Thu,  8 Oct 2026 19:10:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 71941402B8;
	Thu,  8 Oct 2026 21:10:51 +0200 (CEST)
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com
 [209.85.215.178])
 by mails.dpdk.org (Postfix) with ESMTP id A73F7402B8
 for <dev@dpdk.org>; Thu,  8 Oct 2026 21:10:49 +0200 (CEST)
Received: by mail-pg1-f178.google.com with SMTP id
 41be03b00d2f7-cc4dbcf2b85so2735999a12.3
 for <dev@dpdk.org>; Thu, 08 Oct 2026 12:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1791486648;
 x=1792091448; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=QqT69xtFt2sddSfydF1ZzloCmvZ/LQD7Fy5JL7XlqAo=;
 b=LJISO2U8oiQhjdcr+K8k0A10Cdl993fN1imVLHxO01dnEK8t2aVdNBOPGt9AaauAEN
 flQrsWLJmOpE0rzcwZuDTZp94U/5Qbta+PjddZ4fOtfmbs/qdshR+kK46FgK2wm13FiZ
 MNO+oLIs65s0j+jLr4/xLTU2y3nPEQ3B2vQiXIPFcBGXGtZP7NNlCixAhbV2GYhPxAZN
 JamSTtfR3Nlk5wjMh6s/bRmmfg1Ln5sHqakBY9jh9B1CO5iuQXmUUGN+zNXFzwH5LTmU
 RFx5LU7U039fa760ZZc4DoSFfV0PwWy0oHk8NgCqRVZC+SY3UCxrbpWf7Tewosjhne+H
 TtFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791486648; x=1792091448;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QqT69xtFt2sddSfydF1ZzloCmvZ/LQD7Fy5JL7XlqAo=;
 b=wrVq16F83zzQhHqzlF6PG8rw+ft25s9VcV2eu1CmjbhYV2lD17zTdx3/wkHDp5vmtI
 TkJwCVdoeHivMmbLTDhbY+NNyBpoQ1KHHP25VI8uXu2+f5ZICZh6eHKjehKAWTA4Dcpq
 2kPanjYcNmSp7tImv4/HWy1V2HQSNS09oJLTqDvzWJclJgtqJkxE8kbzbvEdDJkaTxjB
 PltEnlFt4cy5UXrXsDEKaAYrfY3gpU7AOZKUYwuBky+RFAHAYvGNNLVFRgm+hgwhLevM
 POLkfwtkK61NUSuFVZHM6LdKi6udgcEUcJoQ0CzM3XocfkKGT+1nPrAT7DfQwNANbM0L
 /GCg==
X-Gm-Message-State: AFq9FYIs+VqpsM8D3ff8pi3Wcj+1jhGjtMSMnidYvtUj/Or5951bJmhW
 JpVWM/P1gagIsR8UuPTjQuRh413vQSPxsMUP725KkloXMgAKR2msCCWvD7NQu8JaIQPQ2R5hLFV
 +mbeJvxA=
X-Gm-Gg: AYBFou2gn84G4z//HwDOEwKZXhMHqF6dodXsnrAJRuOCJWvgRvDdm/E9xM1eVpmM2pd
 6c/6Zygg9Du0i96bEmiUPGw/7ENKRA7yUykh8bcdnlvWRA/6HduNxTGsLEq83adPon0iJ0HtgUK
 Lo+rg3G5qfDsmLkH2lBVdPvFsF/SpCnWutxRwgF3D4iD4uLHDBE1WXzXuR+PomomgHSEVgk9tyz
 0xAENfJLU33xHZq5h46GbT0FZV5BWw2VnVcpVtqtqCqRusn/NxQFgVXFdVoTr+Au9cbedwqSlUr
 PmWqEC8j9+7ULE98F08+ihOicLdloY42XKJwjjxzX4pV+ej6MAVzGYOP1XtrCbEga+apNPkqmUf
 BMdynTBmDKDbhRZa0DJf9C4EPE9nTCbgGYYzwFSNUjCppilJMFT3b4k6cXtfIOsmsrpzn6w2fGM
 X8Wr7t7oBjHY+gr/3END1EVA7osWWx0Wji+oHF96GJfXgJTbfNCerIiGJ93KOa6Y7iCBPu3ILjw
 BIhPl5YQvdTv0Fz8wTyAVznLrb5DidmXYNGNw==
X-Received: by 2002:a17:90b:2dc3:b0:3ab:311e:97bd with SMTP id
 98e67ed59e1d1-3ab311e988emr430061a91.49.1791486648235; 
 Thu, 08 Oct 2026 12:10:48 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ab36dddac2sm41159a91.16.2026.10.08.12.10.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2026 12:10:47 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, Wei Hu <weh@microsoft.com>
Subject: [RFC] bus/vmbus: make driver interface internal
Date: Thu,  8 Oct 2026 12:09:33 -0700
Message-ID: <20261008191046.703485-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
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

The vmbus bus API was exposed as public API, but it is only usable by
the netvsc PMD and DPDK core: the functions operate on vmbus channels
and devices that no application can obtain. Exposing them commits DPDK
to an ABI that has no external consumer.

Make the interface internal as announced. The public headers
rte_bus_vmbus.h and rte_vmbus_reg.h are renamed to vmbus_api.h and
vmbus_reg.h and listed as driver SDK headers, so they are no longer
installed for applications. All rte_vmbus_* functions are marked
__rte_internal and exported as internal symbols.

rte_vmbus_chan_dump() had no export annotation at all, so it was
declared in the public header but never present in the shared library.
It is now exported as internal like the rest.

netvsc needs no change: it already includes bus_vmbus_driver.h, and the
bus driver dependency puts the driver directory on its include path.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
I don't have access to Hyper-V or Azure to test this.
Was generated by LLM based on the intention in the deprecation note.
Please test on proper environment before merging.

 doc/guides/rel_notes/deprecation.rst          |  3 --
 doc/guides/rel_notes/release_26_11.rst        |  6 ++++
 drivers/bus/vmbus/bus_vmbus_driver.h          |  2 +-
 drivers/bus/vmbus/linux/vmbus_bus.c           | 14 ++++-----
 drivers/bus/vmbus/linux/vmbus_uio.c           |  2 +-
 drivers/bus/vmbus/meson.build                 |  7 +++--
 drivers/bus/vmbus/private.h                   |  2 +-
 .../vmbus/{rte_bus_vmbus.h => vmbus_api.h}    | 30 ++++++++++++++++---
 drivers/bus/vmbus/vmbus_bufring.c             |  2 +-
 drivers/bus/vmbus/vmbus_channel.c             | 29 +++++++++---------
 drivers/bus/vmbus/vmbus_common.c              |  4 +--
 drivers/bus/vmbus/vmbus_common_uio.c          |  2 +-
 .../vmbus/{rte_vmbus_reg.h => vmbus_reg.h}    |  0
 13 files changed, 66 insertions(+), 37 deletions(-)
 rename drivers/bus/vmbus/{rte_bus_vmbus.h => vmbus_api.h} (94%)
 rename drivers/bus/vmbus/{rte_vmbus_reg.h => vmbus_reg.h} (100%)

diff --git a/doc/guides/rel_notes/deprecation.rst b/doc/guides/rel_notes/deprecation.rst
index 56a67c372e..08875f1d0a 100644
--- a/doc/guides/rel_notes/deprecation.rst
+++ b/doc/guides/rel_notes/deprecation.rst
@@ -135,6 +135,3 @@ Deprecation Notices
   The graph walk functions will process nodes in topological order
   using bitmap scanning instead of the circular buffer.
 
-* bus/vmbus: Starting DPDK 25.11, all the vmbus API defined in
-  ``drivers/bus/vmbus/rte_bus_vmbus.h`` will become internal to DPDK.
-  Those API functions are used internally by DPDK core and netvsc PMD.
diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index 16d3a90723..fb195be54b 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -235,6 +235,12 @@ API Changes
    Also, make sure to start the actual text at the margin.
    =======================================================
 
+* bus/vmbus: Made the vmbus bus API internal.
+  The ``rte_bus_vmbus.h`` and ``rte_vmbus_reg.h`` headers are no longer installed;
+  their contents moved to the driver only headers
+  ``vmbus_api.h`` and ``vmbus_reg.h``.
+  All ``rte_vmbus_*`` functions are now internal to DPDK.
+
 * eal: Improved pointer arithmetic macros.
 
   * ``RTE_PTR_ADD``, ``RTE_PTR_SUB``, ``RTE_PTR_ALIGN``, ``RTE_PTR_ALIGN_CEIL``,
diff --git a/drivers/bus/vmbus/bus_vmbus_driver.h b/drivers/bus/vmbus/bus_vmbus_driver.h
index 706ff1fcf5..09a38058dd 100644
--- a/drivers/bus/vmbus/bus_vmbus_driver.h
+++ b/drivers/bus/vmbus/bus_vmbus_driver.h
@@ -6,7 +6,7 @@
 #ifndef BUS_VMBUS_DRIVER_H
 #define BUS_VMBUS_DRIVER_H
 
-#include <rte_bus_vmbus.h>
+#include <vmbus_api.h>
 #include <rte_compat.h>
 #include <dev_driver.h>
 
diff --git a/drivers/bus/vmbus/linux/vmbus_bus.c b/drivers/bus/vmbus/linux/vmbus_bus.c
index 779ea50b92..6c26f7e354 100644
--- a/drivers/bus/vmbus/linux/vmbus_bus.c
+++ b/drivers/bus/vmbus/linux/vmbus_bus.c
@@ -17,7 +17,7 @@
 #include <rte_devargs.h>
 #include <rte_memory.h>
 #include <rte_malloc.h>
-#include <rte_bus_vmbus.h>
+#include <vmbus_api.h>
 #include <rte_kvargs.h>
 
 #include <eal_export.h>
@@ -164,7 +164,7 @@ static const char *map_names[VMBUS_MAX_RESOURCE] = {
 
 
 /* map the resources of a vmbus device in virtual memory */
-RTE_EXPORT_SYMBOL(rte_vmbus_map_device)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_vmbus_map_device)
 int
 rte_vmbus_map_device(struct rte_vmbus_device *dev)
 {
@@ -223,7 +223,7 @@ rte_vmbus_map_device(struct rte_vmbus_device *dev)
 	return vmbus_uio_map_resource(dev);
 }
 
-RTE_EXPORT_SYMBOL(rte_vmbus_unmap_device)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_vmbus_unmap_device)
 void
 rte_vmbus_unmap_device(struct rte_vmbus_device *dev)
 {
@@ -375,7 +375,7 @@ vmbus_scan_one(const char *name)
 /*
  * Scan the content of the vmbus, and the devices in the devices list
  */
-RTE_EXPORT_SYMBOL(rte_vmbus_scan)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_vmbus_scan)
 int
 rte_vmbus_scan(void)
 {
@@ -407,19 +407,19 @@ rte_vmbus_scan(void)
 	return -1;
 }
 
-RTE_EXPORT_SYMBOL(rte_vmbus_irq_mask)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_vmbus_irq_mask)
 void rte_vmbus_irq_mask(struct rte_vmbus_device *device)
 {
 	vmbus_uio_irq_control(device, 1);
 }
 
-RTE_EXPORT_SYMBOL(rte_vmbus_irq_unmask)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_vmbus_irq_unmask)
 void rte_vmbus_irq_unmask(struct rte_vmbus_device *device)
 {
 	vmbus_uio_irq_control(device, 0);
 }
 
-RTE_EXPORT_SYMBOL(rte_vmbus_irq_read)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_vmbus_irq_read)
 int rte_vmbus_irq_read(struct rte_vmbus_device *device)
 {
 	return vmbus_uio_irq_read(device);
diff --git a/drivers/bus/vmbus/linux/vmbus_uio.c b/drivers/bus/vmbus/linux/vmbus_uio.c
index 0ef05c0096..34cfb63d54 100644
--- a/drivers/bus/vmbus/linux/vmbus_uio.c
+++ b/drivers/bus/vmbus/linux/vmbus_uio.c
@@ -16,7 +16,7 @@
 #include <rte_memory.h>
 #include <rte_common.h>
 #include <rte_malloc.h>
-#include <rte_bus_vmbus.h>
+#include <vmbus_api.h>
 #include <rte_string_fns.h>
 
 #include "private.h"
diff --git a/drivers/bus/vmbus/meson.build b/drivers/bus/vmbus/meson.build
index 86ad9cc4d8..47408bb5d5 100644
--- a/drivers/bus/vmbus/meson.build
+++ b/drivers/bus/vmbus/meson.build
@@ -6,8 +6,11 @@ if is_windows
     subdir_done()
 endif
 
-headers = files('rte_bus_vmbus.h','rte_vmbus_reg.h')
-driver_sdk_headers = files('bus_vmbus_driver.h')
+driver_sdk_headers = files(
+        'bus_vmbus_driver.h',
+        'vmbus_api.h',
+        'vmbus_reg.h',
+)
 
 sources = files(
         'vmbus_bufring.c',
diff --git a/drivers/bus/vmbus/private.h b/drivers/bus/vmbus/private.h
index 6b7782724f..20f6d16a9b 100644
--- a/drivers/bus/vmbus/private.h
+++ b/drivers/bus/vmbus/private.h
@@ -13,7 +13,7 @@
 #include <bus_vmbus_driver.h>
 #include <rte_log.h>
 #include <rte_eal_paging.h>
-#include <rte_vmbus_reg.h>
+#include <vmbus_reg.h>
 
 extern struct rte_bus rte_vmbus_bus;
 
diff --git a/drivers/bus/vmbus/rte_bus_vmbus.h b/drivers/bus/vmbus/vmbus_api.h
similarity index 94%
rename from drivers/bus/vmbus/rte_bus_vmbus.h
rename to drivers/bus/vmbus/vmbus_api.h
index 2e9898ed7f..f1078110cd 100644
--- a/drivers/bus/vmbus/rte_bus_vmbus.h
+++ b/drivers/bus/vmbus/vmbus_api.h
@@ -3,8 +3,8 @@
  * All Rights Reserved.
  */
 
-#ifndef _VMBUS_H_
-#define _VMBUS_H_
+#ifndef VMBUS_API_H
+#define VMBUS_API_H
 
 /**
  * @file
@@ -19,10 +19,11 @@
 #include <stdint.h>
 #include <inttypes.h>
 
+#include <rte_compat.h>
 #include <rte_uuid.h>
 #include <rte_debug.h>
 #include <rte_interrupts.h>
-#include <rte_vmbus_reg.h>
+#include <vmbus_reg.h>
 
 #ifdef __cplusplus
 extern "C" {
@@ -40,6 +41,7 @@ struct vmbus_channel;
  * @return
  *  0 on success, negative on error
  */
+__rte_internal
 int rte_vmbus_scan(void);
 
 /**
@@ -49,6 +51,7 @@ int rte_vmbus_scan(void);
  *   - 0 on success.
  *   - !0 on error.
  */
+__rte_internal
 int rte_vmbus_probe(void);
 
 /**
@@ -62,6 +65,7 @@ int rte_vmbus_probe(void);
  *   0 on success, negative on error and positive if no driver
  *   is found for the device.
  */
+__rte_internal
 int rte_vmbus_map_device(struct rte_vmbus_device *dev);
 
 /**
@@ -71,6 +75,7 @@ int rte_vmbus_map_device(struct rte_vmbus_device *dev);
  *   A pointer to a rte_vmbus_device structure describing the device
  *   to use
  */
+__rte_internal
 void rte_vmbus_unmap_device(struct rte_vmbus_device *dev);
 
 /**
@@ -85,6 +90,7 @@ void rte_vmbus_unmap_device(struct rte_vmbus_device *dev);
  *   - -ENOMEM: Not enough memory available.
  *   - -EINVAL: Regions could not be mapped.
  */
+__rte_internal
 int rte_vmbus_chan_open(struct rte_vmbus_device *device,
 			struct vmbus_channel **chan);
 
@@ -94,6 +100,7 @@ int rte_vmbus_chan_open(struct rte_vmbus_device *device,
  * @param chan
  *    VMBUS channel
  */
+__rte_internal
 void rte_vmbus_chan_close(struct vmbus_channel *chan);
 
 /**
@@ -104,6 +111,7 @@ void rte_vmbus_chan_close(struct vmbus_channel *chan);
  * @return
  *   Number of channels available.
  */
+__rte_internal
 int rte_vmbus_max_channels(const struct rte_vmbus_device *device);
 
 /**
@@ -118,6 +126,7 @@ int rte_vmbus_max_channels(const struct rte_vmbus_device *device);
  *   - -ENOMEM: Not enough memory available.
  *   - -EINVAL: Regions could not be mapped.
  */
+__rte_internal
 int rte_vmbus_subchan_open(struct vmbus_channel *primary,
 			   struct vmbus_channel **new_chan);
 
@@ -127,6 +136,7 @@ int rte_vmbus_subchan_open(struct vmbus_channel *primary,
  * @param device
  *    VMBUS device
  */
+__rte_internal
 void rte_vmbus_irq_mask(struct rte_vmbus_device *device);
 
 /**
@@ -135,6 +145,7 @@ void rte_vmbus_irq_mask(struct rte_vmbus_device *device);
  * @param device
  *    VMBUS device
  */
+__rte_internal
 void rte_vmbus_irq_unmask(struct rte_vmbus_device *device);
 
 /**
@@ -143,6 +154,7 @@ void rte_vmbus_irq_unmask(struct rte_vmbus_device *device);
  * @param device
  *    VMBUS device
  */
+__rte_internal
 int rte_vmbus_irq_read(struct rte_vmbus_device *device);
 
 /**
@@ -153,6 +165,7 @@ int rte_vmbus_irq_read(struct rte_vmbus_device *device);
  * @return
  *	Return true if no data present in incoming ring.
  */
+__rte_internal
 bool rte_vmbus_chan_rx_empty(const struct vmbus_channel *channel);
 
 /**
@@ -176,6 +189,7 @@ bool rte_vmbus_chan_rx_empty(const struct vmbus_channel *channel);
  *
  * Sends data in buffer directly to hyper-v via the vmbus
  */
+__rte_internal
 int rte_vmbus_chan_send(struct rte_vmbus_device *dev,
 			struct vmbus_channel *channel, uint16_t type,
 			void *data, uint32_t dlen,
@@ -190,6 +204,7 @@ int rte_vmbus_chan_send(struct rte_vmbus_device *dev,
  * Used when batching multiple sends and only signaling host
  * after the last send.
  */
+__rte_internal
 void rte_vmbus_chan_signal_tx(struct rte_vmbus_device *dev,
 			      const struct vmbus_channel *channel);
 
@@ -225,6 +240,7 @@ struct iova_list {
  *
  * Sends data in buffer directly to hyper-v via the vmbus
  */
+__rte_internal
 int rte_vmbus_chan_send_sglist(struct rte_vmbus_device *dev,
 			       struct vmbus_channel *channel,
 			       struct vmbus_gpa gpa[], uint32_t gpacnt,
@@ -246,6 +262,7 @@ int rte_vmbus_chan_send_sglist(struct rte_vmbus_device *dev,
  *   On success, returns 0
  *   On failure, returns negative errno.
  */
+__rte_internal
 int rte_vmbus_chan_recv(struct rte_vmbus_device *dev,
 			struct vmbus_channel *chan,
 			void *data, uint32_t *len,
@@ -265,6 +282,7 @@ int rte_vmbus_chan_recv(struct rte_vmbus_device *dev,
  *   On success, returns number of bytes read.
  *   On failure, returns negative errno.
  */
+__rte_internal
 int rte_vmbus_chan_recv_raw(struct vmbus_channel *chan,
 			    void *data, uint32_t *len);
 
@@ -277,6 +295,7 @@ int rte_vmbus_chan_recv_raw(struct vmbus_channel *chan,
  * @param bytes_read
  *	Number of bytes read since last signal
  */
+__rte_internal
 void rte_vmbus_chan_signal_read(struct rte_vmbus_device *dev,
 				struct vmbus_channel *chan,
 				uint32_t bytes_read);
@@ -289,6 +308,7 @@ void rte_vmbus_chan_signal_read(struct rte_vmbus_device *dev,
  * @return
  *   Sub channel index (0 for primary)
  */
+__rte_internal
 uint16_t rte_vmbus_sub_channel_index(const struct vmbus_channel *chan);
 
 /**
@@ -302,6 +322,7 @@ uint16_t rte_vmbus_sub_channel_index(const struct vmbus_channel *chan);
  *	Approximate wait period between hypervisor examinations of
  *	the trigger page (in nanoseconds).
  */
+__rte_internal
 void rte_vmbus_set_latency(const struct rte_vmbus_device *dev,
 			   const struct vmbus_channel *chan,
 			   uint32_t latency);
@@ -312,10 +333,11 @@ void rte_vmbus_set_latency(const struct rte_vmbus_device *dev,
  * @param channel
  *	Pointer to vmbus_channel structure.
  */
+__rte_internal
 void rte_vmbus_chan_dump(FILE *f, const struct vmbus_channel *chan);
 
 #ifdef __cplusplus
 }
 #endif
 
-#endif /* _VMBUS_H_ */
+#endif /* VMBUS_API_H */
diff --git a/drivers/bus/vmbus/vmbus_bufring.c b/drivers/bus/vmbus/vmbus_bufring.c
index dcd66390a3..9e8227a863 100644
--- a/drivers/bus/vmbus/vmbus_bufring.c
+++ b/drivers/bus/vmbus/vmbus_bufring.c
@@ -18,7 +18,7 @@
 #include <rte_stdatomic.h>
 #include <rte_memory.h>
 #include <rte_pause.h>
-#include <rte_bus_vmbus.h>
+#include <vmbus_api.h>
 
 #include "private.h"
 
diff --git a/drivers/bus/vmbus/vmbus_channel.c b/drivers/bus/vmbus/vmbus_channel.c
index 6887fbad46..a8768eab16 100644
--- a/drivers/bus/vmbus/vmbus_channel.c
+++ b/drivers/bus/vmbus/vmbus_channel.c
@@ -15,7 +15,7 @@
 #include <rte_malloc.h>
 #include <rte_atomic.h>
 #include <rte_memory.h>
-#include <rte_bus_vmbus.h>
+#include <vmbus_api.h>
 
 #include "private.h"
 
@@ -65,7 +65,7 @@ vmbus_set_event(struct rte_vmbus_device *dev, const struct vmbus_channel *chan)
 /*
  * Set the wait between when hypervisor examines the trigger.
  */
-RTE_EXPORT_SYMBOL(rte_vmbus_set_latency)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_vmbus_set_latency)
 void
 rte_vmbus_set_latency(const struct rte_vmbus_device *dev,
 		      const struct vmbus_channel *chan,
@@ -98,7 +98,7 @@ rte_vmbus_set_latency(const struct rte_vmbus_device *dev,
  * Since this in userspace, rely on the monitor page.
  * Can't do a hypercall from userspace.
  */
-RTE_EXPORT_SYMBOL(rte_vmbus_chan_signal_tx)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_vmbus_chan_signal_tx)
 void
 rte_vmbus_chan_signal_tx(struct rte_vmbus_device *dev, const struct vmbus_channel *chan)
 {
@@ -116,7 +116,7 @@ rte_vmbus_chan_signal_tx(struct rte_vmbus_device *dev, const struct vmbus_channe
 
 
 /* Do a simple send directly using transmit ring. */
-RTE_EXPORT_SYMBOL(rte_vmbus_chan_send)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_vmbus_chan_send)
 int rte_vmbus_chan_send(struct rte_vmbus_device *dev,
 			struct vmbus_channel *chan, uint16_t type, void *data,
 			uint32_t dlen, uint64_t xactid, uint32_t flags,
@@ -161,7 +161,7 @@ int rte_vmbus_chan_send(struct rte_vmbus_device *dev,
 }
 
 /* Do a scatter/gather send where the descriptor points to data. */
-RTE_EXPORT_SYMBOL(rte_vmbus_chan_send_sglist)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_vmbus_chan_send_sglist)
 int rte_vmbus_chan_send_sglist(struct rte_vmbus_device *dev,
 			       struct vmbus_channel *chan,
 			       struct vmbus_gpa sg[], uint32_t sglen,
@@ -206,7 +206,7 @@ int rte_vmbus_chan_send_sglist(struct rte_vmbus_device *dev,
 	return error;
 }
 
-RTE_EXPORT_SYMBOL(rte_vmbus_chan_rx_empty)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_vmbus_chan_rx_empty)
 bool rte_vmbus_chan_rx_empty(const struct vmbus_channel *channel)
 {
 	const struct vmbus_br *br = &channel->rxbr;
@@ -216,7 +216,7 @@ bool rte_vmbus_chan_rx_empty(const struct vmbus_channel *channel)
 }
 
 /* Signal host after reading N bytes */
-RTE_EXPORT_SYMBOL(rte_vmbus_chan_signal_read)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_vmbus_chan_signal_read)
 void rte_vmbus_chan_signal_read(struct rte_vmbus_device *dev,
 				struct vmbus_channel *chan,
 				uint32_t bytes_read)
@@ -249,7 +249,7 @@ void rte_vmbus_chan_signal_read(struct rte_vmbus_device *dev,
 	vmbus_set_event(dev, chan);
 }
 
-RTE_EXPORT_SYMBOL(rte_vmbus_chan_recv)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_vmbus_chan_recv)
 int rte_vmbus_chan_recv(struct rte_vmbus_device *dev,
 			struct vmbus_channel *chan, void *data, uint32_t *len,
 			uint64_t *request_id)
@@ -298,7 +298,7 @@ int rte_vmbus_chan_recv(struct rte_vmbus_device *dev,
 }
 
 /* TODO: replace this with inplace ring buffer (no copy) */
-RTE_EXPORT_SYMBOL(rte_vmbus_chan_recv_raw)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_vmbus_chan_recv_raw)
 int rte_vmbus_chan_recv_raw(struct vmbus_channel *chan,
 			    void *data, uint32_t *len)
 {
@@ -369,7 +369,7 @@ int vmbus_chan_create(const struct rte_vmbus_device *device,
 }
 
 /* Setup the primary channel */
-RTE_EXPORT_SYMBOL(rte_vmbus_chan_open)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_vmbus_chan_open)
 int rte_vmbus_chan_open(struct rte_vmbus_device *device,
 			struct vmbus_channel **new_chan)
 {
@@ -390,7 +390,7 @@ int rte_vmbus_chan_open(struct rte_vmbus_device *device,
 	return err;
 }
 
-RTE_EXPORT_SYMBOL(rte_vmbus_max_channels)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_vmbus_max_channels)
 int rte_vmbus_max_channels(const struct rte_vmbus_device *device)
 {
 	if (vmbus_uio_subchannels_supported(device, device->primary))
@@ -400,7 +400,7 @@ int rte_vmbus_max_channels(const struct rte_vmbus_device *device)
 }
 
 /* Setup secondary channel */
-RTE_EXPORT_SYMBOL(rte_vmbus_subchan_open)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_vmbus_subchan_open)
 int rte_vmbus_subchan_open(struct vmbus_channel *primary,
 			   struct vmbus_channel **new_chan)
 {
@@ -416,13 +416,13 @@ int rte_vmbus_subchan_open(struct vmbus_channel *primary,
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_vmbus_sub_channel_index)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_vmbus_sub_channel_index)
 uint16_t rte_vmbus_sub_channel_index(const struct vmbus_channel *chan)
 {
 	return chan->subchannel_id;
 }
 
-RTE_EXPORT_SYMBOL(rte_vmbus_chan_close)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_vmbus_chan_close)
 void rte_vmbus_chan_close(struct vmbus_channel *chan)
 {
 	const struct rte_vmbus_device *device = chan->device;
@@ -459,6 +459,7 @@ static void vmbus_dump_ring(FILE *f, const char *id, const struct vmbus_br *br)
 			pkt.flags, pkt.xactid);
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(rte_vmbus_chan_dump)
 void rte_vmbus_chan_dump(FILE *f, const struct vmbus_channel *chan)
 {
 	fprintf(f, "channel[%u] relid=%u monitor=%u\n",
diff --git a/drivers/bus/vmbus/vmbus_common.c b/drivers/bus/vmbus/vmbus_common.c
index 4c64856abb..63d8c0d8b0 100644
--- a/drivers/bus/vmbus/vmbus_common.c
+++ b/drivers/bus/vmbus/vmbus_common.c
@@ -19,7 +19,7 @@
 #include <rte_malloc.h>
 #include <rte_errno.h>
 #include <rte_memory.h>
-#include <rte_bus_vmbus.h>
+#include <vmbus_api.h>
 
 #include "private.h"
 
@@ -129,7 +129,7 @@ vmbus_probe_device(struct rte_driver *drv, struct rte_device *dev)
  * all registered drivers that have a matching entry in its id_table
  * for discovered devices.
  */
-RTE_EXPORT_SYMBOL(rte_vmbus_probe)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_vmbus_probe)
 int
 rte_vmbus_probe(void)
 {
diff --git a/drivers/bus/vmbus/vmbus_common_uio.c b/drivers/bus/vmbus/vmbus_common_uio.c
index c6e7e07302..974b01470f 100644
--- a/drivers/bus/vmbus/vmbus_common_uio.c
+++ b/drivers/bus/vmbus/vmbus_common_uio.c
@@ -13,7 +13,7 @@
 #include <rte_tailq.h>
 #include <rte_log.h>
 #include <rte_malloc.h>
-#include <rte_bus_vmbus.h>
+#include <vmbus_api.h>
 
 #include "private.h"
 
diff --git a/drivers/bus/vmbus/rte_vmbus_reg.h b/drivers/bus/vmbus/vmbus_reg.h
similarity index 100%
rename from drivers/bus/vmbus/rte_vmbus_reg.h
rename to drivers/bus/vmbus/vmbus_reg.h
-- 
2.53.0

