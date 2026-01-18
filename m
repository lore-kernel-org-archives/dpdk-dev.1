Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A558AC9832F
	for <dpdk-dev@archiver.kernel.org>; Sun, 18 Jan 2026 19:18:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DE47B40ED3;
	Sun, 18 Jan 2026 20:14:51 +0100 (CET)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com
 [209.85.218.52]) by mails.dpdk.org (Postfix) with ESMTP id 4608742E97
 for <dev@dpdk.org>; Sun, 18 Jan 2026 20:14:50 +0100 (CET)
Received: by mail-ej1-f52.google.com with SMTP id
 a640c23a62f3a-b872f1c31f1so471973366b.0
 for <dev@dpdk.org>; Sun, 18 Jan 2026 11:14:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768763690;
 x=1769368490; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PPnphyI+ucJPONnM4EWPNpGPB2uXOV4uwI+4MdxP87s=;
 b=ifXiLNJZtgH7rGke2SK6iBLfOU46P5rCBkGODx+psFU2GilRymWSt5gr7M36/xUs5E
 OjhoHNzPaBxnb0kXuQb/6ahxIk/5kZ9IbzDrdQblp5tJdaJiI03tLOwHUvRl2YTFDXSf
 dxiAZePI2OvUSlx/cmDHcuJB2Kvd8si5zgmTUKw7XoyTVJTvq1deXS9UaTOxk41YoyKR
 QE7iuJBowtmGWKRwAS9mrhHx7AQmu67Uk2NzZJpJiuRfoIrqVA3gRhufy5o78RM2gj02
 QeLURZO//sfPzsRjuwYkicO3bFEltnnjp4Zz2wzdRVePWyyWWBVteZ5EXZwqQnPPaisB
 1MEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768763690; x=1769368490;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PPnphyI+ucJPONnM4EWPNpGPB2uXOV4uwI+4MdxP87s=;
 b=OBSjRespARn7I9JqVfTtUiqeVHNcVYPoHOuVcfcbKaAQoYKrcTkB6RCGFkgNP8Belb
 VHIlTrd/SguXLyx+sbZDR5hCVXKO1fjL5Pob1y3mPvC4TnntOgrxzrMsgd0f7l7udxRF
 PYtqPiDHl2/Ke5Ce3rCfFtudhUaE8FqilXebUnn+eQ4cNvfN6iGsenTNS9iPG9BR3DIX
 DSHyuRdWBSe79FdzwYAg44N4WSROY2NRiJ1ELNIMNhxuCBlHtjuMrsc/lVq7+oL0NhLe
 FuACVDBbTTP4qZnqqd1hAFB1LQnDz3vbBB8kxrjyQ96xMY8b01vkTfY+i9y+OfYqkkRN
 a++w==
X-Gm-Message-State: AOJu0YwUnA6zkiZrFRpJd7MbGpd/enFB9MB1cwmBzudQiLtN0d3/xFH5
 WfJKR5X/mukDpyafOVNvS324vium5J5NK9RYRNMrG1LhhDVKb0d+7c9wioA/1zs9V2fyX8O3aJC
 KamsN
X-Gm-Gg: AY/fxX5QMH9R9YID6l/XrN5ZQawkt9QqWqeAAU8pjBQKS9g7u9qHfAXHjECM3Z59Wa0
 QJsVXpsTxSKnELBb0HT4+DU0PTOCxomM9gXTQ58oZEDVa1foRrgPSqJVGOWgRP26yMmnaiKuJ8B
 GAVR9siMa2Uf20ONE3pWnKI7irPsBw37vtXOitzzHaWiRTPaxUhc4RBX1rp/IkTJv9ht3r6SQfj
 0O8I3Pre8OpJPZLz6JdZB3kDlku4Rw4oMw3vrEx0/edauARxpP9Ufswf3zVG6KzWeCCQYLcIQkT
 bXrcM+yaTyJpJzzi3VC0/0s+kG5LKZixMcNloMXJnzgNq054y2+S3mt52rQ6ymWjm678N6M3nrW
 zQntfVeQGKWGlhpae1nwtshNvzp0dw46vPPNP2dlyk0XVU2Nyrv28Eco0HL0H5PLoBZ5yo4hQqr
 Gsrl1UPzpiVt1Gw4ASLDpiXrWJUMqRvcmwV1waXlUosmP3cI4crA==
X-Received: by 2002:a17:906:d552:b0:b87:2f29:206e with SMTP id
 a640c23a62f3a-b8792dce01emr755616566b.16.1768763689780; 
 Sun, 18 Jan 2026 11:14:49 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b87959c9f8dsm886287166b.36.2026.01.18.11.14.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Jan 2026 11:14:49 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v5 53/54] doc: correct errors in vhost library guide
Date: Sun, 18 Jan 2026 11:10:56 -0800
Message-ID: <20260118191323.241013-54-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260118191323.241013-1-stephen@networkplumber.org>
References: <20240513155911.31872-1-nandinipersad361@gmail.com>
 <20260118191323.241013-1-stephen@networkplumber.org>
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

Correct various issues in the vhost library documentation:

- fix "In another words" to "In other words"
- fix word order "for given a packet" to "for a given packet"
- fix "to be dequeue" to "to be dequeued"
- fix typo "pkmbuf" to "pktmbuf"
- fix plural agreement "application that doesn't" to "applications
  that don't"
- add missing period after NET_STATS_ENABLE description
- fix subject-verb agreement "features is" to "features are"
- fix verb tense "stored them at" to "stores them in"
- fix awkward phrasing in DMA vChannel cleanup description
- fix "which responses to create" to "which is responsible for creating"
- fix "to response" to "to respond"

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/prog_guide/vhost_lib.rst | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/doc/guides/prog_guide/vhost_lib.rst b/doc/guides/prog_guide/vhost_lib.rst
index 0c2b4d020a..345a621716 100644
--- a/doc/guides/prog_guide/vhost_lib.rst
+++ b/doc/guides/prog_guide/vhost_lib.rst
@@ -5,7 +5,7 @@ Vhost Library
 =============
 
 The vhost library implements a user space virtio net server allowing the user
-to manipulate the virtio ring directly. In another words, it allows the user
+to manipulate the virtio ring directly. In other words, it allows the user
 to fetch/put packets from/to the VM virtio net device. To achieve this, a
 vhost library should be able to:
 
@@ -73,7 +73,7 @@ The following is an overview of some key Vhost API functions:
     Enabling this flag forces vhost dequeue function to only provide linear
     pktmbuf (no multi-segmented pktmbuf).
 
-    The vhost library by default provides a single pktmbuf for given a
+    The vhost library by default provides a single pktmbuf for a given
     packet, but if for some reason the data doesn't fit into a single
     pktmbuf (e.g., TSO is enabled), the library will allocate additional
     pktmbufs from the same mempool and chain them together to create a
@@ -81,7 +81,7 @@ The following is an overview of some key Vhost API functions:
 
     However, the vhost application needs to support multi-segmented format.
     If the vhost application does not support that format and requires large
-    buffers to be dequeue, this flag should be enabled to force only linear
+    buffers to be dequeued, this flag should be enabled to force only linear
     buffers (see RTE_VHOST_USER_EXTBUF_SUPPORT) or drop the packet.
 
     It is disabled by default.
@@ -89,7 +89,7 @@ The following is an overview of some key Vhost API functions:
   - ``RTE_VHOST_USER_EXTBUF_SUPPORT``
 
     Enabling this flag allows vhost dequeue function to allocate and attach
-    an external buffer to a pktmbuf if the pkmbuf doesn't provide enough
+    an external buffer to a pktmbuf if the pktmbuf doesn't provide enough
     space to store all data.
 
     This is useful when the vhost application wants to support large packets
@@ -99,7 +99,7 @@ The following is an overview of some key Vhost API functions:
     rte_pktmbuf_attach_extbuf().
 
     See RTE_VHOST_USER_LINEARBUF_SUPPORT as well to disable multi-segmented
-    mbufs for application that doesn't support chained mbufs.
+    mbufs for applications that don't support chained mbufs.
 
     It is disabled by default.
 
@@ -137,7 +137,7 @@ The following is an overview of some key Vhost API functions:
   rte_vhost_stats_get() to collect statistics, and rte_vhost_stats_reset() to
   reset them.
 
-  It is disabled by default
+  It is disabled by default.
 
 * ``rte_vhost_driver_set_features(path, features)``
 
@@ -167,7 +167,7 @@ The following is an overview of some key Vhost API functions:
 
   * ``features_changed(int vid, uint64_t features)``
 
-    This callback is invoked when the features is changed. For example,
+    This callback is invoked when the features are changed. For example,
     ``VHOST_F_LOG_ALL`` will be set/cleared at the start/end of live
     migration, respectively.
 
@@ -200,7 +200,7 @@ The following is an overview of some key Vhost API functions:
 
 * ``rte_vhost_dequeue_burst(vid, queue_id, mbuf_pool, pkts, count)``
 
-  Receives (dequeues) ``count`` packets from guest, and stored them at ``pkts``.
+  Receives (dequeues) ``count`` packets from guest, and stores them in ``pkts``.
 
 * ``rte_vhost_crypto_create(vid, cryptodev_id, sess_mempool, socket_id)``
 
@@ -331,7 +331,7 @@ The following is an overview of some key Vhost API functions:
 
 * ``rte_vhost_async_dma_unconfigure(dma_id, vchan_id)``
 
-  Clean DMA vChannel finished to use. After this function is called,
+  Clean up a DMA vChannel after use is finished. After this function is called,
   the specified DMA vChannel should no longer be used by the Vhost library.
 
 * ``rte_vhost_notify_guest(int vid, uint16_t queue_id)``
@@ -360,7 +360,7 @@ vhost-user implementation has two options:
 * DPDK vhost-user acts as the client.
 
   Unlike the server mode, this mode doesn't create the socket file;
-  it just tries to connect to the server (which responses to create the
+  it just tries to connect to the server (which is responsible for creating the
   file instead).
 
   When the DPDK vhost-user application restarts, DPDK vhost-user will try to
@@ -469,7 +469,7 @@ Finally, a set of device ops is defined for device specific operations:
 
 * ``migration_done``
 
-  Called to allow the device to response to RARP sending.
+  Called to allow the device to respond to RARP sending.
 
 * ``get_vfio_group_fd``
 
-- 
2.51.0

