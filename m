Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F272F606A32C
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Nov 2026 15:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=ka7rv/UF
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2E640402A4;
	Tue, 17 Nov 2026 16:33:35 +0100 (CET)
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com
 [209.85.215.177])
 by mails.dpdk.org (Postfix) with ESMTPS id 1F37C4029E
 for <dev@dpdk.org>; Tue, 17 Nov 2026 16:33:33 +0100 (CET)
Received: by mail-pg1-f177.google.com with SMTP id
 41be03b00d2f7-cdab8873d9dso2317593a12.1
 for <dev@dpdk.org>; Tue, 17 Nov 2026 07:33:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1794929611;
 x=1795534411; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bVMNjFfmN960L5/svwrJbozLrk/nZn7Dem9WWCiBZUk=;
 b=ka7rv/UFTmWRxBieCQhYHDi0wiN98zuhJbZMhg1auBxTx3HOc8fNuU2PfEdCiNiTY/
 8AzDkIaBCMu9TAQvkUIDNLJi4B7D+rd7ZCNdxG19jtT79PiqFW6Lm6R98RKnbkAhfqhD
 4s0ND63RCDLAueA2d7J/WT6+2HzvECKUSWoVQyHpnz8PQe+lWebi7b5VdaupZYsR4D/z
 6KlkJR322VhB2wffq7abBTg/DnlfKWX5Y9LN8XCDmrbcZA+xke3R3msc1l0rYHyMi/AD
 +VbMH/hQQ9KiJH+PqqN+GrAj0N7jQWly5sOrmtQY76WFEYuEPOVBB53D8gfY0e372KBs
 h2Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794929611; x=1795534411;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=bVMNjFfmN960L5/svwrJbozLrk/nZn7Dem9WWCiBZUk=;
 b=wlqtBEEO92gPFiJdbxbhm5thR6SPnEliBRsNNYERkrv4gyDLz8zeHR9S5z0Hp+qQwY
 BgJIZZSqMPuSl9g77n2qdG2ZcZI4I2So3MhXPsx4mnUJiA5YfwvL+jfLqR4F/8yCZ9MG
 5lS6HxwyeZUda1P1HMH5Q5Vkfa94rlGs9iKazEeugmn5LuIFvT4CIJBzzUK0Or0x0yf1
 32AsUDyL2B8QpZnpl3/T2KaP2LagTiiK9C3qvnB+3dUGZpY8a0WKiJtNXecLwkck7OhZ
 K4cd4xMKiqaNN2O0zWUIi/4nibVIO0NrjMqLWIvBWpQSFb9iig/RO2b3FU82ycuDQeYe
 vOXw==
X-Gm-Message-State: APuU4Z9e6O/S5MsItZDRcrkvFgSApqRSZ0/BikyH4oZDo5cnqiI1ikYM
 1Jg4ONiG/24BYi1ncvLHMfJnQXyUtl2IqvSBv1HJPQYq0kxCbY4JiJmnmU0MCReI9RbhtYmR8O5
 3gFQqZMI=
X-Gm-Gg: AZFdTZcoKjJF+O8PunpwrOhmdqro+0A9U6ekaXrI/Tl/kPVe6JESRCwDiMElXdyyobc
 pCpjSMYNk+eF5gzEPouTI41CR7smAtTf3Z2X1yPClhTfH1zGWHdm9fGJ/QwBMA+arzCvyJPyboW
 Bo4AfKkOnLyFE7VgpsQ5cM8UxdznanErNrGWhxLzV0M3TmgpHfgYRMwUMaRTK1EGFCzFs9SH8SJ
 BYw70x8+Ez2EGRDClqa6eWen+2UuSVksJ+5lL14JujoOYyGTu7vJng43ECwrHTRmMpKT7JsJWlb
 lbVV9S1nVfLjZg1/E2CVmRi/U4sRTB7WwAwCnaUOIfslUvXsYrl1AEz6uY4qxkjbDhZYb/adeqG
 EuEkQI1ct3NMHRERwb0ceEIse0zLPMnu/edRESmgVvG2ejdkhpt2h8SryiJ0FjT1IQiTuSCPfRE
 x54qJ7zgzVLZBvNpSa7sWeRLLs2TLMDTg0L4tGl59sJblaZUiWc/BuNUTypybC/BJ3HFHcAToIr
 qZRmW8pAGabPnvLynYwKux5y3h2cmpqeM0d55KjUbj5GTyX/OruM+jdkuF11TrpxJZ1KYXw7Qfa
 3QDzELh1if0dMEnG1Cy/faRkB5t9fsjlGWEBd/4zdpyvZINUAPwkLFSKEzC4061LFt7HVKQ=
X-Received: by 2002:a17:90b:2642:b0:3ad:eb38:9778 with SMTP id
 98e67ed59e1d1-3b1b0ba1f42mr12244064a91.48.1794929611043; 
 Tue, 17 Nov 2026 07:33:31 -0800 (PST)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b1b3a21769sm11985548a91.4.2026.11.17.07.33.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 07:33:30 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, Wei Hu <weh@microsoft.com>
Subject: [PATCH v2] bus/vmbus: make driver interface internal
Date: Tue, 17 Nov 2026 07:32:45 -0800
Message-ID: <20261117153328.315306-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261008191046.703485-1-stephen@networkplumber.org>
References: <20261008191046.703485-1-stephen@networkplumber.org>
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
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The vmbus bus API was exposed as public API, but it is only usable by
the netvsc PMD and DPDK core. As announced in deprecation the vmbus
specific symbols are either made internal (or if not used removed).

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Reviewed-by: Wei Hu <weh@microsoft.com>
---
v2 - remove unused code and incorporate AI review feedback

 doc/guides/rel_notes/deprecation.rst          |  3 -
 doc/guides/rel_notes/release_26_11.rst        |  6 ++
 drivers/bus/vmbus/bus_vmbus_driver.h          |  2 +-
 drivers/bus/vmbus/linux/vmbus_bus.c           | 27 ++------
 drivers/bus/vmbus/linux/vmbus_uio.c           | 25 +------
 drivers/bus/vmbus/meson.build                 |  7 +-
 drivers/bus/vmbus/private.h                   |  4 +-
 .../vmbus/{rte_bus_vmbus.h => vmbus_api.h}    | 67 ++++++-------------
 drivers/bus/vmbus/vmbus_bufring.c             |  2 +-
 drivers/bus/vmbus/vmbus_channel.c             | 29 ++++----
 drivers/bus/vmbus/vmbus_common.c              | 16 +----
 drivers/bus/vmbus/vmbus_common_uio.c          |  2 +-
 .../vmbus/{rte_vmbus_reg.h => vmbus_reg.h}    |  0
 13 files changed, 59 insertions(+), 131 deletions(-)
 rename drivers/bus/vmbus/{rte_bus_vmbus.h => vmbus_api.h} (89%)
 rename drivers/bus/vmbus/{rte_vmbus_reg.h => vmbus_reg.h} (100%)

diff --git a/doc/guides/rel_notes/deprecation.rst b/doc/guides/rel_notes/deprecation.rst
index 02b495f6a8..d2c272ee66 100644
--- a/doc/guides/rel_notes/deprecation.rst
+++ b/doc/guides/rel_notes/deprecation.rst
@@ -103,6 +103,3 @@ Deprecation Notices
   will take a size parameter as well as the string buffer.
   This will detect and prevent accidental overwriting of caller provided buffer.
 
-* bus/vmbus: Starting DPDK 25.11, all the vmbus API defined in
-  ``drivers/bus/vmbus/rte_bus_vmbus.h`` will become internal to DPDK.
-  Those API functions are used internally by DPDK core and netvsc PMD.
diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index d3ab3662dd..8a55660d7f 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -510,6 +510,12 @@ API Changes
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
index 779ea50b92..a52e8afa22 100644
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
@@ -375,9 +375,8 @@ vmbus_scan_one(const char *name)
 /*
  * Scan the content of the vmbus, and the devices in the devices list
  */
-RTE_EXPORT_SYMBOL(rte_vmbus_scan)
 int
-rte_vmbus_scan(void)
+vmbus_scan(void)
 {
 	struct dirent *e;
 	DIR *dir;
@@ -406,21 +405,3 @@ rte_vmbus_scan(void)
 	closedir(dir);
 	return -1;
 }
-
-RTE_EXPORT_SYMBOL(rte_vmbus_irq_mask)
-void rte_vmbus_irq_mask(struct rte_vmbus_device *device)
-{
-	vmbus_uio_irq_control(device, 1);
-}
-
-RTE_EXPORT_SYMBOL(rte_vmbus_irq_unmask)
-void rte_vmbus_irq_unmask(struct rte_vmbus_device *device)
-{
-	vmbus_uio_irq_control(device, 0);
-}
-
-RTE_EXPORT_SYMBOL(rte_vmbus_irq_read)
-int rte_vmbus_irq_read(struct rte_vmbus_device *device)
-{
-	return vmbus_uio_irq_read(device);
-}
diff --git a/drivers/bus/vmbus/linux/vmbus_uio.c b/drivers/bus/vmbus/linux/vmbus_uio.c
index 2285236eb9..906989319b 100644
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
@@ -38,29 +38,6 @@ void vmbus_uio_irq_control(const struct rte_vmbus_device *dev, int32_t onoff)
 	}
 }
 
-int vmbus_uio_irq_read(struct rte_vmbus_device *dev)
-{
-	int32_t count;
-	int cc;
-
-	if (rte_intr_fd_get(dev->intr_handle) < 0)
-		return -1;
-
-	cc = read(rte_intr_fd_get(dev->intr_handle), &count,
-		  sizeof(count));
-	if (cc < (int)sizeof(count)) {
-		if (cc < 0) {
-			VMBUS_LOG(ERR, "IRQ read failed %s",
-				  strerror(errno));
-			return -errno;
-		}
-		VMBUS_LOG(ERR, "can't read IRQ count");
-		return -EINVAL;
-	}
-
-	return count;
-}
-
 void
 vmbus_uio_free_resource(struct rte_vmbus_device *dev,
 		struct mapped_vmbus_resource *uio_res)
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
index 33545b6614..d07c9a924a 100644
--- a/drivers/bus/vmbus/private.h
+++ b/drivers/bus/vmbus/private.h
@@ -14,7 +14,7 @@
 #include <rte_log.h>
 #include <rte_stdatomic.h>
 #include <rte_eal_paging.h>
-#include <rte_vmbus_reg.h>
+#include <vmbus_reg.h>
 
 extern struct rte_bus rte_vmbus_bus;
 
@@ -83,12 +83,12 @@ struct vmbus_channel {
 
 #define VMBUS_MAX_CHANNELS	64
 
+int vmbus_scan(void);
 int vmbus_chan_create(const struct rte_vmbus_device *device,
 		      uint16_t relid, uint16_t subid, uint8_t monitor_id,
 		      struct vmbus_channel **new_chan);
 
 void vmbus_uio_irq_control(const struct rte_vmbus_device *dev, int32_t onoff);
-int vmbus_uio_irq_read(struct rte_vmbus_device *dev);
 
 int vmbus_uio_map_resource(struct rte_vmbus_device *dev);
 void vmbus_uio_unmap_resource(struct rte_vmbus_device *dev);
diff --git a/drivers/bus/vmbus/rte_bus_vmbus.h b/drivers/bus/vmbus/vmbus_api.h
similarity index 89%
rename from drivers/bus/vmbus/rte_bus_vmbus.h
rename to drivers/bus/vmbus/vmbus_api.h
index 2e9898ed7f..af2e7c9432 100644
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
@@ -33,24 +34,6 @@ struct rte_vmbus_device;
 struct rte_vmbus_driver;
 struct vmbus_channel;
 
-/**
- * Scan the content of the VMBUS bus, and the devices in the devices
- * list
- *
- * @return
- *  0 on success, negative on error
- */
-int rte_vmbus_scan(void);
-
-/**
- * Probe the VMBUS bus
- *
- * @return
- *   - 0 on success.
- *   - !0 on error.
- */
-int rte_vmbus_probe(void);
-
 /**
  * Map the VMBUS device resources in user space virtual memory address
  *
@@ -62,6 +45,7 @@ int rte_vmbus_probe(void);
  *   0 on success, negative on error and positive if no driver
  *   is found for the device.
  */
+__rte_internal
 int rte_vmbus_map_device(struct rte_vmbus_device *dev);
 
 /**
@@ -71,6 +55,7 @@ int rte_vmbus_map_device(struct rte_vmbus_device *dev);
  *   A pointer to a rte_vmbus_device structure describing the device
  *   to use
  */
+__rte_internal
 void rte_vmbus_unmap_device(struct rte_vmbus_device *dev);
 
 /**
@@ -85,6 +70,7 @@ void rte_vmbus_unmap_device(struct rte_vmbus_device *dev);
  *   - -ENOMEM: Not enough memory available.
  *   - -EINVAL: Regions could not be mapped.
  */
+__rte_internal
 int rte_vmbus_chan_open(struct rte_vmbus_device *device,
 			struct vmbus_channel **chan);
 
@@ -94,6 +80,7 @@ int rte_vmbus_chan_open(struct rte_vmbus_device *device,
  * @param chan
  *    VMBUS channel
  */
+__rte_internal
 void rte_vmbus_chan_close(struct vmbus_channel *chan);
 
 /**
@@ -104,6 +91,7 @@ void rte_vmbus_chan_close(struct vmbus_channel *chan);
  * @return
  *   Number of channels available.
  */
+__rte_internal
 int rte_vmbus_max_channels(const struct rte_vmbus_device *device);
 
 /**
@@ -118,33 +106,10 @@ int rte_vmbus_max_channels(const struct rte_vmbus_device *device);
  *   - -ENOMEM: Not enough memory available.
  *   - -EINVAL: Regions could not be mapped.
  */
+__rte_internal
 int rte_vmbus_subchan_open(struct vmbus_channel *primary,
 			   struct vmbus_channel **new_chan);
 
-/**
- * Disable IRQ for device
- *
- * @param device
- *    VMBUS device
- */
-void rte_vmbus_irq_mask(struct rte_vmbus_device *device);
-
-/**
- * Enable IRQ for device
- *
- * @param device
- *    VMBUS device
- */
-void rte_vmbus_irq_unmask(struct rte_vmbus_device *device);
-
-/**
- * Read (and wait) for IRQ
- *
- * @param device
- *    VMBUS device
- */
-int rte_vmbus_irq_read(struct rte_vmbus_device *device);
-
 /**
  * Test if channel is empty
  *
@@ -153,6 +118,7 @@ int rte_vmbus_irq_read(struct rte_vmbus_device *device);
  * @return
  *	Return true if no data present in incoming ring.
  */
+__rte_internal
 bool rte_vmbus_chan_rx_empty(const struct vmbus_channel *channel);
 
 /**
@@ -176,6 +142,7 @@ bool rte_vmbus_chan_rx_empty(const struct vmbus_channel *channel);
  *
  * Sends data in buffer directly to hyper-v via the vmbus
  */
+__rte_internal
 int rte_vmbus_chan_send(struct rte_vmbus_device *dev,
 			struct vmbus_channel *channel, uint16_t type,
 			void *data, uint32_t dlen,
@@ -190,6 +157,7 @@ int rte_vmbus_chan_send(struct rte_vmbus_device *dev,
  * Used when batching multiple sends and only signaling host
  * after the last send.
  */
+__rte_internal
 void rte_vmbus_chan_signal_tx(struct rte_vmbus_device *dev,
 			      const struct vmbus_channel *channel);
 
@@ -225,6 +193,7 @@ struct iova_list {
  *
  * Sends data in buffer directly to hyper-v via the vmbus
  */
+__rte_internal
 int rte_vmbus_chan_send_sglist(struct rte_vmbus_device *dev,
 			       struct vmbus_channel *channel,
 			       struct vmbus_gpa gpa[], uint32_t gpacnt,
@@ -246,6 +215,7 @@ int rte_vmbus_chan_send_sglist(struct rte_vmbus_device *dev,
  *   On success, returns 0
  *   On failure, returns negative errno.
  */
+__rte_internal
 int rte_vmbus_chan_recv(struct rte_vmbus_device *dev,
 			struct vmbus_channel *chan,
 			void *data, uint32_t *len,
@@ -265,6 +235,7 @@ int rte_vmbus_chan_recv(struct rte_vmbus_device *dev,
  *   On success, returns number of bytes read.
  *   On failure, returns negative errno.
  */
+__rte_internal
 int rte_vmbus_chan_recv_raw(struct vmbus_channel *chan,
 			    void *data, uint32_t *len);
 
@@ -277,6 +248,7 @@ int rte_vmbus_chan_recv_raw(struct vmbus_channel *chan,
  * @param bytes_read
  *	Number of bytes read since last signal
  */
+__rte_internal
 void rte_vmbus_chan_signal_read(struct rte_vmbus_device *dev,
 				struct vmbus_channel *chan,
 				uint32_t bytes_read);
@@ -289,6 +261,7 @@ void rte_vmbus_chan_signal_read(struct rte_vmbus_device *dev,
  * @return
  *   Sub channel index (0 for primary)
  */
+__rte_internal
 uint16_t rte_vmbus_sub_channel_index(const struct vmbus_channel *chan);
 
 /**
@@ -302,6 +275,7 @@ uint16_t rte_vmbus_sub_channel_index(const struct vmbus_channel *chan);
  *	Approximate wait period between hypervisor examinations of
  *	the trigger page (in nanoseconds).
  */
+__rte_internal
 void rte_vmbus_set_latency(const struct rte_vmbus_device *dev,
 			   const struct vmbus_channel *chan,
 			   uint32_t latency);
@@ -312,10 +286,11 @@ void rte_vmbus_set_latency(const struct rte_vmbus_device *dev,
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
index 95f03929cb..fd2e8c2592 100644
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
index 90ba3d1ef6..30e57e184d 100644
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
@@ -115,7 +115,7 @@ rte_vmbus_chan_signal_tx(struct rte_vmbus_device *dev, const struct vmbus_channe
 
 
 /* Do a simple send directly using transmit ring. */
-RTE_EXPORT_SYMBOL(rte_vmbus_chan_send)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_vmbus_chan_send)
 int rte_vmbus_chan_send(struct rte_vmbus_device *dev,
 			struct vmbus_channel *chan, uint16_t type, void *data,
 			uint32_t dlen, uint64_t xactid, uint32_t flags,
@@ -160,7 +160,7 @@ int rte_vmbus_chan_send(struct rte_vmbus_device *dev,
 }
 
 /* Do a scatter/gather send where the descriptor points to data. */
-RTE_EXPORT_SYMBOL(rte_vmbus_chan_send_sglist)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_vmbus_chan_send_sglist)
 int rte_vmbus_chan_send_sglist(struct rte_vmbus_device *dev,
 			       struct vmbus_channel *chan,
 			       struct vmbus_gpa sg[], uint32_t sglen,
@@ -205,7 +205,7 @@ int rte_vmbus_chan_send_sglist(struct rte_vmbus_device *dev,
 	return error;
 }
 
-RTE_EXPORT_SYMBOL(rte_vmbus_chan_rx_empty)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_vmbus_chan_rx_empty)
 bool rte_vmbus_chan_rx_empty(const struct vmbus_channel *channel)
 {
 	const struct vmbus_br *br = &channel->rxbr;
@@ -215,7 +215,7 @@ bool rte_vmbus_chan_rx_empty(const struct vmbus_channel *channel)
 }
 
 /* Signal host after reading N bytes */
-RTE_EXPORT_SYMBOL(rte_vmbus_chan_signal_read)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_vmbus_chan_signal_read)
 void rte_vmbus_chan_signal_read(struct rte_vmbus_device *dev,
 				struct vmbus_channel *chan,
 				uint32_t bytes_read)
@@ -248,7 +248,7 @@ void rte_vmbus_chan_signal_read(struct rte_vmbus_device *dev,
 	vmbus_set_event(dev, chan);
 }
 
-RTE_EXPORT_SYMBOL(rte_vmbus_chan_recv)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_vmbus_chan_recv)
 int rte_vmbus_chan_recv(struct rte_vmbus_device *dev,
 			struct vmbus_channel *chan, void *data, uint32_t *len,
 			uint64_t *request_id)
@@ -297,7 +297,7 @@ int rte_vmbus_chan_recv(struct rte_vmbus_device *dev,
 }
 
 /* TODO: replace this with inplace ring buffer (no copy) */
-RTE_EXPORT_SYMBOL(rte_vmbus_chan_recv_raw)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_vmbus_chan_recv_raw)
 int rte_vmbus_chan_recv_raw(struct vmbus_channel *chan,
 			    void *data, uint32_t *len)
 {
@@ -368,7 +368,7 @@ int vmbus_chan_create(const struct rte_vmbus_device *device,
 }
 
 /* Setup the primary channel */
-RTE_EXPORT_SYMBOL(rte_vmbus_chan_open)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_vmbus_chan_open)
 int rte_vmbus_chan_open(struct rte_vmbus_device *device,
 			struct vmbus_channel **new_chan)
 {
@@ -389,7 +389,7 @@ int rte_vmbus_chan_open(struct rte_vmbus_device *device,
 	return err;
 }
 
-RTE_EXPORT_SYMBOL(rte_vmbus_max_channels)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_vmbus_max_channels)
 int rte_vmbus_max_channels(const struct rte_vmbus_device *device)
 {
 	if (vmbus_uio_subchannels_supported(device, device->primary))
@@ -399,7 +399,7 @@ int rte_vmbus_max_channels(const struct rte_vmbus_device *device)
 }
 
 /* Setup secondary channel */
-RTE_EXPORT_SYMBOL(rte_vmbus_subchan_open)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_vmbus_subchan_open)
 int rte_vmbus_subchan_open(struct vmbus_channel *primary,
 			   struct vmbus_channel **new_chan)
 {
@@ -415,13 +415,13 @@ int rte_vmbus_subchan_open(struct vmbus_channel *primary,
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
@@ -458,6 +458,7 @@ static void vmbus_dump_ring(FILE *f, const char *id, const struct vmbus_br *br)
 			pkt.flags, pkt.xactid);
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(rte_vmbus_chan_dump)
 void rte_vmbus_chan_dump(FILE *f, const struct vmbus_channel *chan)
 {
 	fprintf(f, "channel[%u] relid=%u monitor=%u\n",
diff --git a/drivers/bus/vmbus/vmbus_common.c b/drivers/bus/vmbus/vmbus_common.c
index 4c64856abb..9c557587f3 100644
--- a/drivers/bus/vmbus/vmbus_common.c
+++ b/drivers/bus/vmbus/vmbus_common.c
@@ -19,7 +19,7 @@
 #include <rte_malloc.h>
 #include <rte_errno.h>
 #include <rte_memory.h>
-#include <rte_bus_vmbus.h>
+#include <vmbus_api.h>
 
 #include "private.h"
 
@@ -124,18 +124,6 @@ vmbus_probe_device(struct rte_driver *drv, struct rte_device *dev)
 	return ret;
 }
 
-/*
- * Scan the vmbus, and call the devinit() function for
- * all registered drivers that have a matching entry in its id_table
- * for discovered devices.
- */
-RTE_EXPORT_SYMBOL(rte_vmbus_probe)
-int
-rte_vmbus_probe(void)
-{
-	return rte_bus_generic_probe(&rte_vmbus_bus);
-}
-
 static int
 vmbus_unplug_device(struct rte_device *rte_dev)
 {
@@ -208,7 +196,7 @@ rte_vmbus_unregister(struct rte_vmbus_driver *driver)
 
 /* VMBUS doesn't support hotplug */
 struct rte_bus rte_vmbus_bus = {
-	.scan = rte_vmbus_scan,
+	.scan = vmbus_scan,
 	.probe = rte_bus_generic_probe,
 	.free_device = vmbus_free_device,
 	.cleanup = rte_bus_generic_cleanup,
diff --git a/drivers/bus/vmbus/vmbus_common_uio.c b/drivers/bus/vmbus/vmbus_common_uio.c
index 9765f5f609..ff5cda1fe4 100644
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

