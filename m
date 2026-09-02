Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDF83C624D4
	for <dpdk-dev@archiver.kernel.org>; Wed,  2 Sep 2026 15:58:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8653240E4B;
	Wed,  2 Sep 2026 17:57:51 +0200 (CEST)
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com
 [209.85.214.174])
 by mails.dpdk.org (Postfix) with ESMTP id 583DF402DE
 for <dev@dpdk.org>; Wed,  2 Sep 2026 17:57:50 +0200 (CEST)
Received: by mail-pl1-f174.google.com with SMTP id
 d9443c01a7336-2ce98cb8165so109485ad.1
 for <dev@dpdk.org>; Wed, 02 Sep 2026 08:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1788364669;
 x=1788969469; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=LruBeSJdK2nlnb8HPUhHMPzlmZm/ZMdeik9pkslYDyQ=;
 b=0Z0FiU8mBqKROENpPYlR/p7Xo0nK659a5vHHShmTd1vzqPgARq8ydmASvEAVcAn/Qn
 qO6IFxXjcxGb0rRyB218qUFbwn5ixuVYMOaeRvGHAOPhx2HVGRrW/pUdavfFXvdNrmbe
 zEyPYIkNgr24O1sNcDoFAI0Iwrs7rneFK5i6tY45XcYovZOE7absvJw1UQ5TKL37BJD4
 gqnF6pw24seMlPERVfbAqjbgrp0Q729bj0ZaELSvblUVM3BRpegOETPZAeMu8W21rrvZ
 TRsHqz2KlBLlcEvLegEkYoD7ZKjnbqye3dGJyxkky/a+Y3F099N8HDIK1HnJ4UTAurJM
 crkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788364669; x=1788969469;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=LruBeSJdK2nlnb8HPUhHMPzlmZm/ZMdeik9pkslYDyQ=;
 b=JzX+B6EgI9nlfP8fU+btc6b6wI6fsU1kVe+mb0nGtg2oMHjA/00pb4Z2jH8mHGXND9
 87MC2ISF6bw5Wa5MYj4ayn2TBNoHME+op3t0+FLIfx2ttbnafpCEJPrDDcRyruI8YHT4
 z2U8Rfz88T+XlFmAdkq1HNeuvI3XavjKCmqSR4cfvQ0ZqHDY4jRQ7nhty4ryWLHFEm7W
 v03qjn4AxkAKNzMxmLosB1hulOBocb1oKxAMGMLqe5aNYOortJuJAC/eyUwgCGLtIizq
 ArqWkU6uc4aiEyHavR7YZSztAv6QICV4DkXFdmcuJ5kuI3f0SiMSKu52f620p5NCcucq
 P8pw==
X-Gm-Message-State: AFuF++lasqFeOBkhaEvpsEI33wPe7wD15J+ECsdlTrrFW307EpQQ5HHA
 inscx/6OdfAoLZLNNPKT6vRu191kNKsVn3TM1Q78qUwW1E6YRVW5Pn0O4O/b2w6+aBJp5Hz1XvK
 h61+n
X-Gm-Gg: AYBFou3wq0gbk/QAvmlF97+bHFoycpd6d7kjDt5VrhMcPUAiohrG5JR1j+uFhNiiX8B
 pyyczzivKrfO9cOEgBqLBMYrKNGHOgXuy1ffaNlSGPaKNsepnpUYnQY0rXsriGms/5PUvZdYmKv
 I9YdpAhXSeQ2Z+QSuSIAfEPqwbqs3B6mvw6IqoFmndpq7DNbftOp9uLWvnnv2tadGUv763ciRjl
 aBtc3Sn9LhNGGA2yscMpSc8bUms1PxOe++dymdNCmgkgwoa34cMlRGkqvO95zwyAtp0ac5oatHP
 ZJfLgAWjfCeL17d/la0Fn+uIHhJXPGCR5CxFEcl7OKDCz+jXyPVxCsw3uebcQxMmnq1ApEMzPEn
 soxrAvFZnv/a+ksDMWeDG7AhsLG/kdEUHnJKcllN0nE7uKiN2otjzLGRGZH1D841jzLipLguh4T
 DRQHbU/f1gkojeueEQL/02lND6yaGrNFwEbkzFYM+lD4lCl25r4nbwE8IT5v8zwvXJWV8KzeaAw
 AIyXF7ruu3zHG/7hhAALVnBhxQ=
X-Received: by 2002:a17:902:ce8e:b0:2d8:d4d2:d138 with SMTP id
 d9443c01a7336-2dafb136d0emr1074385ad.20.1788364667595; 
 Wed, 02 Sep 2026 08:57:47 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2dadd4bc2f2sm15778695ad.71.2026.09.02.08.57.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2026 08:57:47 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Jerin Jacob <jerinj@marvell.com>
Subject: [PATCH 5/6] eventdev: promote link profile API to stable
Date: Wed,  2 Sep 2026 08:53:58 -0700
Message-ID: <20260902155722.577747-6-stephen@networkplumber.org>
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

The event port link profile functions were added in v23.11 and have not
changed since, so remove the experimental tag.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/rel_notes/release_26_11.rst | 3 +++
 lib/eventdev/rte_eventdev.c            | 6 +++---
 lib/eventdev/rte_eventdev.h            | 3 ---
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index 01aef74d0a..5db51c4f6a 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -108,6 +108,9 @@ API Changes
     ``rte_event_crypto_adapter_runtime_params_set`` and
     ``rte_event_crypto_adapter_runtime_params_get``
   * timer adapter: ``rte_event_timer_remaining_ticks_get``
+  * link profiles: ``rte_event_port_profile_links_set``,
+    ``rte_event_port_profile_unlink`` and
+    ``rte_event_port_profile_links_get``
 
 
 ABI Changes
diff --git a/lib/eventdev/rte_eventdev.c b/lib/eventdev/rte_eventdev.c
index a6f6b6879e..6211679b29 100644
--- a/lib/eventdev/rte_eventdev.c
+++ b/lib/eventdev/rte_eventdev.c
@@ -1031,7 +1031,7 @@ rte_event_port_link(uint8_t dev_id, uint8_t port_id,
 	return rte_event_port_profile_links_set(dev_id, port_id, queues, priorities, nb_links, 0);
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_event_port_profile_links_set, 23.11)
+RTE_EXPORT_SYMBOL(rte_event_port_profile_links_set)
 int
 rte_event_port_profile_links_set(uint8_t dev_id, uint8_t port_id, const uint8_t queues[],
 				 const uint8_t priorities[], uint16_t nb_links, uint8_t profile_id)
@@ -1122,7 +1122,7 @@ rte_event_port_unlink(uint8_t dev_id, uint8_t port_id,
 	return rte_event_port_profile_unlink(dev_id, port_id, queues, nb_unlinks, 0);
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_event_port_profile_unlink, 23.11)
+RTE_EXPORT_SYMBOL(rte_event_port_profile_unlink)
 int
 rte_event_port_profile_unlink(uint8_t dev_id, uint8_t port_id, uint8_t queues[],
 			      uint16_t nb_unlinks, uint8_t profile_id)
@@ -1267,7 +1267,7 @@ rte_event_port_links_get(uint8_t dev_id, uint8_t port_id,
 	return count;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_event_port_profile_links_get, 23.11)
+RTE_EXPORT_SYMBOL(rte_event_port_profile_links_get)
 int
 rte_event_port_profile_links_get(uint8_t dev_id, uint8_t port_id, uint8_t queues[],
 				 uint8_t priorities[], uint8_t profile_id)
diff --git a/lib/eventdev/rte_eventdev.h b/lib/eventdev/rte_eventdev.h
index 4e13a38d89..e8d0ef59ac 100644
--- a/lib/eventdev/rte_eventdev.h
+++ b/lib/eventdev/rte_eventdev.h
@@ -2209,7 +2209,6 @@ rte_event_port_unlink(uint8_t dev_id, uint8_t port_id,
  *  RTE_EVENT_QUEUE_CFG_SINGLE_LINK to more than one event ports)
  * (EINVAL) Invalid parameter
  */
-__rte_experimental
 int
 rte_event_port_profile_links_set(uint8_t dev_id, uint8_t port_id, const uint8_t queues[],
 				 const uint8_t priorities[], uint16_t nb_links, uint8_t profile_id);
@@ -2261,7 +2260,6 @@ rte_event_port_profile_links_set(uint8_t dev_id, uint8_t port_id, const uint8_t
  * the rte_errno accordingly, Possible rte_errno values are
  * (EINVAL) Invalid parameter
  */
-__rte_experimental
 int
 rte_event_port_profile_unlink(uint8_t dev_id, uint8_t port_id, uint8_t queues[],
 			      uint16_t nb_unlinks, uint8_t profile_id);
@@ -2351,7 +2349,6 @@ rte_event_port_links_get(uint8_t dev_id, uint8_t port_id,
  *  *port_id*.
  * - <0 on failure.
  */
-__rte_experimental
 int
 rte_event_port_profile_links_get(uint8_t dev_id, uint8_t port_id, uint8_t queues[],
 				 uint8_t priorities[], uint8_t profile_id);
-- 
2.53.0

