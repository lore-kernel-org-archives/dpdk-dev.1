Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15B0EC624D4
	for <dpdk-dev@archiver.kernel.org>; Wed,  2 Sep 2026 15:58:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 729AC410D2;
	Wed,  2 Sep 2026 17:57:53 +0200 (CEST)
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com
 [209.85.214.178])
 by mails.dpdk.org (Postfix) with ESMTP id 3AD47410D2
 for <dev@dpdk.org>; Wed,  2 Sep 2026 17:57:52 +0200 (CEST)
Received: by mail-pl1-f178.google.com with SMTP id
 d9443c01a7336-2d91ff7d9acso12618235ad.3
 for <dev@dpdk.org>; Wed, 02 Sep 2026 08:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1788364671;
 x=1788969471; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HvaVeEyZg9JfV+2L2XX8DBXtv6GQ+xAUotrNf7LY2hk=;
 b=vtQC3hqNKxIf55DLG7XUxXvEbQck2OmRatVvpy0/hRgm1NAoUeoHX2IRgDbW3kvXHM
 69eKy3a3pQrBGcAnrCF8NV0HVmrR2ONfSULZZN64IUF4vC7CNXaVN736LQFDALFRfNRt
 5enW1XAHjccz0jvP1NNYkw3NYSuDrTTgPEjcFnWwqGs76RGm2SSBzzcm0FhBb7+q+KRt
 qaZCS3HMl8TBVeq4MLHALPDf29P2DkAbbEOm1sRuJLtPDJEnZhzYrmPXPTmt/YEMwsJa
 1pEl9DF2izPW9PPze3aaeUU9TwtPgRVRQEEITa6UEqIDkP9/3W0JZiSUet9B2evKGfWi
 OpKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788364671; x=1788969471;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=HvaVeEyZg9JfV+2L2XX8DBXtv6GQ+xAUotrNf7LY2hk=;
 b=TaNMKtrvJPzUmzWplM3dgbEo3lPifEYCx2ddlMve5ChVPchyZqEGr67K6FWd09+k1h
 hSJpAnPss81AkLg+cBBlLN8JNzdoZM5H9T52C48aGzMfNlEFKg2Z49msungPoC6dKkHI
 ND4U4x6iG9/xocrUWkitjrUEMD9qTIkiIpScOpIzmtrStRKkFRdzwAfp0K8FqQqdZSg1
 CGWtQammW4i8K0W68Dyc0VlL2iRWpHiTmNUdrcM1Si9+I+3Diwu72uQoB3R9yuHflD5T
 cODOG33yUHWF3wrXF+2EwPZmpbhALTjJfAuUP3YZxmeyGpgpbFW54uMMadblw+BzkiKo
 5OFw==
X-Gm-Message-State: AFuF++kicWZDvMGDIsPYx4ATpyduF/vKORdw4z1vgHipgdDX/1ABCtP6
 17JnAZz3wS+KrMKQ5c1riyYBUH/t2LGDY3Utu1notSHa0fgr3mBKv3kNm3mx/titrEJBF8MJM5J
 LFiUn
X-Gm-Gg: AYBFou0WwD0p39LWDfq7wvuZBmIi7a8/PLNsizAc6Mh4//Yt/7SFbriNaVRDmzzaHoU
 r8+DlB6O9UzOltK/hysWA6EBmKPs7j0+/A5viXMLVdThILZJekraFIoUe/1F251meBIPLm9Pl7y
 MCh6eMWcTCXEczvuhuiJjtJLRsaL3Yj/laE+V2p4487L+7FV77vOyMm29PnH7QKhOsOaKDCx5D5
 OQEaW2nyzifJmtTgDwmVRArYMWAdoDO+Xf1c8YAdFtQK6kp40ku5P461z0jnKxSq5Ssub1U8gn5
 BSmaQ8enKoGIDIrx3oxdb0D65PMJXQK3MMgV7VpzS4LuApiJ222I7CX9hIohSvBgDcJGBEk/25m
 raIyIuqJ4kcsOhV5wMyVY8T8wr+ogHi8eJSpEOUBPb5CAODKfuxUw4qGg+APvEm75WZ8d8tAjND
 fmDOtGjSU38Xca54QLZLvd652AnmnOSqZ/T9fkwcIkThW7rzj3rT91HgR9+wbaq5ARr9Wxvc6SS
 MMhn1y/1BxAnFqI36GXZjRkG5o=
X-Received: by 2002:a17:902:cf01:b0:2d9:32ee:7b83 with SMTP id
 d9443c01a7336-2daec62361emr90978075ad.8.1788364671098; 
 Wed, 02 Sep 2026 08:57:51 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2dadd4bc2f2sm15778695ad.71.2026.09.02.08.57.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2026 08:57:50 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Amit Prakash Shukla <amitprakashs@marvell.com>,
 Jerin Jacob <jerinj@marvell.com>
Subject: [PATCH 6/6] eventdev/dma: promote adapter API to stable
Date: Wed,  2 Sep 2026 08:53:59 -0700
Message-ID: <20260902155722.577747-7-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260902155722.577747-1-stephen@networkplumber.org>
References: <20260902155722.577747-1-stephen@networkplumber.org>
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

The event DMA adapter was introduced in v23.11 and its interface has not
changed since.  Promote all of its functions, together with
rte_event_dma_adapter_caps_get(), and drop the experimental warning from
the file level documentation block.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/rel_notes/release_26_11.rst |  2 ++
 lib/eventdev/rte_event_dma_adapter.c   | 30 +++++++++++++-------------
 lib/eventdev/rte_event_dma_adapter.h   | 19 ----------------
 lib/eventdev/rte_eventdev.c            |  2 +-
 lib/eventdev/rte_eventdev.h            |  1 -
 5 files changed, 18 insertions(+), 36 deletions(-)

diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index 5db51c4f6a..4004f36398 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -111,6 +111,8 @@ API Changes
   * link profiles: ``rte_event_port_profile_links_set``,
     ``rte_event_port_profile_unlink`` and
     ``rte_event_port_profile_links_get``
+  * DMA adapter: ``rte_event_dma_adapter_*`` and
+    ``rte_event_dma_adapter_caps_get``
 
 
 ABI Changes
diff --git a/lib/eventdev/rte_event_dma_adapter.c b/lib/eventdev/rte_event_dma_adapter.c
index 909f351df9..da785483c2 100644
--- a/lib/eventdev/rte_event_dma_adapter.c
+++ b/lib/eventdev/rte_event_dma_adapter.c
@@ -341,7 +341,7 @@ edma_default_config_cb(uint8_t id, uint8_t evdev_id, struct rte_event_dma_adapte
 	return ret;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_event_dma_adapter_create_ext, 23.11)
+RTE_EXPORT_SYMBOL(rte_event_dma_adapter_create_ext)
 int
 rte_event_dma_adapter_create_ext(uint8_t id, uint8_t evdev_id,
 				 rte_event_dma_adapter_conf_cb conf_cb,
@@ -435,7 +435,7 @@ rte_event_dma_adapter_create_ext(uint8_t id, uint8_t evdev_id,
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_event_dma_adapter_create, 23.11)
+RTE_EXPORT_SYMBOL(rte_event_dma_adapter_create)
 int
 rte_event_dma_adapter_create(uint8_t id, uint8_t evdev_id, struct rte_event_port_conf *port_config,
 			    enum rte_event_dma_adapter_mode mode)
@@ -460,7 +460,7 @@ rte_event_dma_adapter_create(uint8_t id, uint8_t evdev_id, struct rte_event_port
 	return ret;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_event_dma_adapter_free, 23.11)
+RTE_EXPORT_SYMBOL(rte_event_dma_adapter_free)
 int
 rte_event_dma_adapter_free(uint8_t id)
 {
@@ -481,7 +481,7 @@ rte_event_dma_adapter_free(uint8_t id)
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_event_dma_adapter_event_port_get, 23.11)
+RTE_EXPORT_SYMBOL(rte_event_dma_adapter_event_port_get)
 int
 rte_event_dma_adapter_event_port_get(uint8_t id, uint8_t *event_port_id)
 {
@@ -988,7 +988,7 @@ edma_add_vchan(struct event_dma_adapter *adapter, int16_t dma_dev_id, uint16_t v
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_event_dma_adapter_vchan_add, 23.11)
+RTE_EXPORT_SYMBOL(rte_event_dma_adapter_vchan_add)
 int
 rte_event_dma_adapter_vchan_add(uint8_t id, int16_t dma_dev_id, uint16_t vchan,
 				const struct rte_event *event)
@@ -1103,7 +1103,7 @@ rte_event_dma_adapter_vchan_add(uint8_t id, int16_t dma_dev_id, uint16_t vchan,
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_event_dma_adapter_vchan_del, 23.11)
+RTE_EXPORT_SYMBOL(rte_event_dma_adapter_vchan_del)
 int
 rte_event_dma_adapter_vchan_del(uint8_t id, int16_t dma_dev_id, uint16_t vchan)
 {
@@ -1170,7 +1170,7 @@ rte_event_dma_adapter_vchan_del(uint8_t id, int16_t dma_dev_id, uint16_t vchan)
 	return ret;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_event_dma_adapter_service_id_get, 23.11)
+RTE_EXPORT_SYMBOL(rte_event_dma_adapter_service_id_get)
 int
 rte_event_dma_adapter_service_id_get(uint8_t id, uint32_t *service_id)
 {
@@ -1230,7 +1230,7 @@ edma_adapter_ctrl(uint8_t id, int start)
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_event_dma_adapter_start, 23.11)
+RTE_EXPORT_SYMBOL(rte_event_dma_adapter_start)
 int
 rte_event_dma_adapter_start(uint8_t id)
 {
@@ -1245,7 +1245,7 @@ rte_event_dma_adapter_start(uint8_t id)
 	return edma_adapter_ctrl(id, 1);
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_event_dma_adapter_stop, 23.11)
+RTE_EXPORT_SYMBOL(rte_event_dma_adapter_stop)
 int
 rte_event_dma_adapter_stop(uint8_t id)
 {
@@ -1254,7 +1254,7 @@ rte_event_dma_adapter_stop(uint8_t id)
 
 #define DEFAULT_MAX_NB 128
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_event_dma_adapter_runtime_params_init, 23.11)
+RTE_EXPORT_SYMBOL(rte_event_dma_adapter_runtime_params_init)
 int
 rte_event_dma_adapter_runtime_params_init(struct rte_event_dma_adapter_runtime_params *params)
 {
@@ -1290,7 +1290,7 @@ dma_adapter_cap_check(struct event_dma_adapter *adapter)
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_event_dma_adapter_runtime_params_set, 23.11)
+RTE_EXPORT_SYMBOL(rte_event_dma_adapter_runtime_params_set)
 int
 rte_event_dma_adapter_runtime_params_set(uint8_t id,
 					 struct rte_event_dma_adapter_runtime_params *params)
@@ -1320,7 +1320,7 @@ rte_event_dma_adapter_runtime_params_set(uint8_t id,
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_event_dma_adapter_runtime_params_get, 23.11)
+RTE_EXPORT_SYMBOL(rte_event_dma_adapter_runtime_params_get)
 int
 rte_event_dma_adapter_runtime_params_get(uint8_t id,
 					 struct rte_event_dma_adapter_runtime_params *params)
@@ -1348,7 +1348,7 @@ rte_event_dma_adapter_runtime_params_get(uint8_t id,
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_event_dma_adapter_stats_get, 23.11)
+RTE_EXPORT_SYMBOL(rte_event_dma_adapter_stats_get)
 int
 rte_event_dma_adapter_stats_get(uint8_t id, struct rte_event_dma_adapter_stats *stats)
 {
@@ -1394,7 +1394,7 @@ rte_event_dma_adapter_stats_get(uint8_t id, struct rte_event_dma_adapter_stats *
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_event_dma_adapter_stats_reset, 23.11)
+RTE_EXPORT_SYMBOL(rte_event_dma_adapter_stats_reset)
 int
 rte_event_dma_adapter_stats_reset(uint8_t id)
 {
@@ -1427,7 +1427,7 @@ rte_event_dma_adapter_stats_reset(uint8_t id)
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_event_dma_adapter_enqueue, 23.11)
+RTE_EXPORT_SYMBOL(rte_event_dma_adapter_enqueue)
 uint16_t
 rte_event_dma_adapter_enqueue(uint8_t dev_id, uint8_t port_id, struct rte_event ev[],
 			      uint16_t nb_events)
diff --git a/lib/eventdev/rte_event_dma_adapter.h b/lib/eventdev/rte_event_dma_adapter.h
index 6a32f84753..5c37f55d46 100644
--- a/lib/eventdev/rte_event_dma_adapter.h
+++ b/lib/eventdev/rte_event_dma_adapter.h
@@ -8,10 +8,6 @@
 /**
  * @file rte_event_dma_adapter.h
  *
- * @warning
- * @b EXPERIMENTAL:
- * All functions in this file may be changed or removed without prior notice.
- *
  * DMA Event Adapter API.
  *
  * Eventdev library provides adapters to bridge between various components for providing new
@@ -282,7 +278,6 @@ struct rte_event_dma_adapter_stats {
  *     - 0: Success
  *     - <0: Error code on failure
  */
-__rte_experimental
 int rte_event_dma_adapter_create_ext(uint8_t id, uint8_t evdev_id,
 				     rte_event_dma_adapter_conf_cb conf_cb,
 				     enum rte_event_dma_adapter_mode mode, void *conf_arg);
@@ -308,7 +303,6 @@ int rte_event_dma_adapter_create_ext(uint8_t id, uint8_t evdev_id,
  *     - 0: Success
  *     - <0: Error code on failure
  */
-__rte_experimental
 int rte_event_dma_adapter_create(uint8_t id, uint8_t evdev_id,
 				 struct rte_event_port_conf *port_config,
 				 enum rte_event_dma_adapter_mode mode);
@@ -323,7 +317,6 @@ int rte_event_dma_adapter_create(uint8_t id, uint8_t evdev_id,
  *     - <0: Error code on failure, If the adapter still has queue pairs added to it, the function
  * returns -EBUSY.
  */
-__rte_experimental
 int rte_event_dma_adapter_free(uint8_t id);
 
 /**
@@ -340,7 +333,6 @@ int rte_event_dma_adapter_free(uint8_t id);
  *     - 0: Success
  *     - <0: Error code on failure.
  */
-__rte_experimental
 int rte_event_dma_adapter_event_port_get(uint8_t id, uint8_t *event_port_id);
 
 /**
@@ -362,7 +354,6 @@ int rte_event_dma_adapter_event_port_get(uint8_t id, uint8_t *event_port_id);
  *     - 0: Success, vchan added correctly.
  *     - <0: Error code on failure.
  */
-__rte_experimental
 int rte_event_dma_adapter_vchan_add(uint8_t id, int16_t dmadev_id, uint16_t vchan,
 				    const struct rte_event *event);
 
@@ -380,7 +371,6 @@ int rte_event_dma_adapter_vchan_add(uint8_t id, int16_t dmadev_id, uint16_t vcha
  *     - 0: Success, vchan deleted successfully.
  *     - <0: Error code on failure.
  */
-__rte_experimental
 int rte_event_dma_adapter_vchan_del(uint8_t id, int16_t dmadev_id, uint16_t vchan);
 
 /**
@@ -397,7 +387,6 @@ int rte_event_dma_adapter_vchan_del(uint8_t id, int16_t dmadev_id, uint16_t vcha
  *     - <0: Error code on failure, if the adapter doesn't use a rte_service function, this function
  * returns -ESRCH.
  */
-__rte_experimental
 int rte_event_dma_adapter_service_id_get(uint8_t id, uint32_t *service_id);
 
 /**
@@ -413,7 +402,6 @@ int rte_event_dma_adapter_service_id_get(uint8_t id, uint32_t *service_id);
  * @note The eventdev and dmadev to which the event_dma_adapter is connected should be started
  * before calling rte_event_dma_adapter_start().
  */
-__rte_experimental
 int rte_event_dma_adapter_start(uint8_t id);
 
 /**
@@ -426,7 +414,6 @@ int rte_event_dma_adapter_start(uint8_t id);
  *  - 0: Success, adapter stopped successfully.
  *  - <0: Error code on failure.
  */
-__rte_experimental
 int rte_event_dma_adapter_stop(uint8_t id);
 
 /**
@@ -439,7 +426,6 @@ int rte_event_dma_adapter_stop(uint8_t id);
  *  -  0: Success
  *  - <0: Error code on failure
  */
-__rte_experimental
 int rte_event_dma_adapter_runtime_params_init(struct rte_event_dma_adapter_runtime_params *params);
 
 /**
@@ -459,7 +445,6 @@ int rte_event_dma_adapter_runtime_params_init(struct rte_event_dma_adapter_runti
  *  -  0: Success
  *  - <0: Error code on failure
  */
-__rte_experimental
 int rte_event_dma_adapter_runtime_params_set(uint8_t id,
 					     struct rte_event_dma_adapter_runtime_params *params);
 
@@ -477,7 +462,6 @@ int rte_event_dma_adapter_runtime_params_set(uint8_t id,
  *  -  0: Success
  *  - <0: Error code on failure
  */
-__rte_experimental
 int rte_event_dma_adapter_runtime_params_get(uint8_t id,
 					     struct rte_event_dma_adapter_runtime_params *params);
 
@@ -493,7 +477,6 @@ int rte_event_dma_adapter_runtime_params_get(uint8_t id,
  *     - 0: Success, retrieved successfully.
  *     - <0: Error code on failure.
  */
-__rte_experimental
 int rte_event_dma_adapter_stats_get(uint8_t id, struct rte_event_dma_adapter_stats *stats);
 
 /**
@@ -506,7 +489,6 @@ int rte_event_dma_adapter_stats_get(uint8_t id, struct rte_event_dma_adapter_sta
  *     - 0: Success, statistics reset successfully.
  *     - <0: Error code on failure.
  */
-__rte_experimental
 int rte_event_dma_adapter_stats_reset(uint8_t id);
 
 /**
@@ -543,7 +525,6 @@ int rte_event_dma_adapter_stats_reset(uint8_t id);
  *     - ENOSPC: The event port was backpressured and unable to enqueue one or more events. This
  * error code is only applicable to closed systems.
  */
-__rte_experimental
 uint16_t rte_event_dma_adapter_enqueue(uint8_t evdev_id, uint8_t port_id, struct rte_event ev[],
 				       uint16_t nb_events);
 
diff --git a/lib/eventdev/rte_eventdev.c b/lib/eventdev/rte_eventdev.c
index 6211679b29..53d17d7a00 100644
--- a/lib/eventdev/rte_eventdev.c
+++ b/lib/eventdev/rte_eventdev.c
@@ -234,7 +234,7 @@ rte_event_eth_tx_adapter_caps_get(uint8_t dev_id, uint16_t eth_port_id,
 		: 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_event_dma_adapter_caps_get, 23.11)
+RTE_EXPORT_SYMBOL(rte_event_dma_adapter_caps_get)
 int
 rte_event_dma_adapter_caps_get(uint8_t dev_id, uint8_t dma_dev_id, uint32_t *caps)
 {
diff --git a/lib/eventdev/rte_eventdev.h b/lib/eventdev/rte_eventdev.h
index e8d0ef59ac..38f0a43f38 100644
--- a/lib/eventdev/rte_eventdev.h
+++ b/lib/eventdev/rte_eventdev.h
@@ -1952,7 +1952,6 @@ rte_event_crypto_adapter_caps_get(uint8_t dev_id, uint8_t cdev_id,
  *     dmadev device.
  *   - <0: Error code returned by the driver function.
  */
-__rte_experimental
 int
 rte_event_dma_adapter_caps_get(uint8_t dev_id, uint8_t dmadev_id, uint32_t *caps);
 
-- 
2.53.0

