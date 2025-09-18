Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C79D3CAC5A0
	for <dpdk-dev@archiver.kernel.org>; Thu, 18 Sep 2025 12:18:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A9B5340288;
	Thu, 18 Sep 2025 14:18:04 +0200 (CEST)
Received: from fhigh-b3-smtp.messagingengine.com
 (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
 by mails.dpdk.org (Postfix) with ESMTP id 498B04027A
 for <dev@dpdk.org>; Thu, 18 Sep 2025 14:18:03 +0200 (CEST)
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 669127A0344;
 Thu, 18 Sep 2025 08:18:02 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-12.internal (MEProxy); Thu, 18 Sep 2025 08:18:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
 :to; s=fm1; t=1758197882; x=1758284282; bh=YHP0GzsAD3Ccq15L025pN
 pWgErpiNW6v5LrIcz6zip4=; b=Oy0ZNiyWgovbhBeTNusRaM4c6jZXgzn0MJ46t
 vMeAOUJxbgpAhYZCDf9XSWnzJdGuXDEqsvlio27xXxE1kfVrhq8n+SMgzmrPBBVq
 wCXDrCO1GFZo7kI+l7Ps8K2uIuA80i+HZZY73Odr1mPKKbuAyeXd+zHEXdHFKyCT
 zC81MQ3o5VAs4F3zirdMAk+VgIbS88ZUSg14CoXNNHIL7/PYe7gZ+zJWO5Tv3XMl
 WoUzhxf34cmHqYSpwpPAZDVbyC8CJGkNGYS/ErWs3y6LH4JWm6rmZx4cqKWHCNuF
 MF2CnovEdw0q3qcXDu7DwVgJsL8cdVuRefdHV/z8YrUV6CTNg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
 1758197882; x=1758284282; bh=YHP0GzsAD3Ccq15L025pNpWgErpiNW6v5Lr
 Icz6zip4=; b=BP40NgKoCdanjbd15a2E9mEcI4r1kMzn3Bw6kkPTZlm7Y4wCVws
 Po0/7qVMgWDESFNN0Rwt7F8O37L8f+Q1+WWcLiAE/I7p0w4HfTdYuMvesCNu48Hq
 vYKab61qxPN8tDa0lHTA3kmX0yQWFkN4EnxNSCXxydpx5QjIbTY+H/NL+Lv/bOnU
 ugWsoE1F8dsmonlmga4CoYXmfC702h2HvRdm6ASmEZE1ZIZ5Y1lWLrh3UGTb4pOS
 4ErocqLSVfAJcnB7fvpVA0QvxOKlIVq2JmrismBI1QLFQEHlQNSNJ2TM5hblIYkV
 d9XdlnsqS68gQlS9gc16oI+fdjyiO9s5Pwg==
X-ME-Sender: <xms:efjLaMM_C9D2UqOlMqs5DA8LD5YByH2CExC8TzIhcptw6kqLM5yyMg>
 <xme:efjLaNhlwf-7sP1-vs9GZgUTQ4spXuy191fLRQ-9hIIRIPqY173RmPcehezk4b1fS
 gPLH7a0kyNyYt_btQ>
X-ME-Received: <xmr:efjLaP16GLN03aWp3JR_BQJw3BSIzK5o1snqhEjvRhLTiYaB9D_Qr8bLcL6p1vZRbxYNcLuPb_gYEuuKuBT2hNh3ZfCYg1c>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdegieefudcutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefvhhhomhgrshcuofho
 nhhjrghlohhnuceothhhohhmrghssehmohhnjhgrlhhonhdrnhgvtheqnecuggftrfgrth
 htvghrnhepveevfeevieeihfetudekgeekleeigeffueekveduteeuffeiudevteeiudek
 feelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepth
 hhohhmrghssehmohhnjhgrlhhonhdrnhgvthdpnhgspghrtghpthhtohepgedpmhhouggv
 pehsmhhtphhouhhtpdhrtghpthhtohepuggvvhesughpughkrdhorhhgpdhrtghpthhtoh
 eprhhorhgvthiilhgrsehlihhnuhigrdhmihgtrhhoshhofhhtrdgtohhmpdhrtghpthht
 ohepmhgrgihimhgvrdgtohhquhgvlhhinhesrhgvughhrghtrdgtohhmpdhrtghpthhtoh
 eptghhvghnsghogiesnhhvihguihgrrdgtohhm
X-ME-Proxy: <xmx:efjLaHjhaLQxk_mIFqrIha9KdQIENCDj8dEtOqp6R0UnJQefFI039g>
 <xmx:efjLaPcdcET7FbmvhodOirmFLYZN8Zysxp3cFult_28ulb63p3q-bg>
 <xmx:efjLaKm_Rzj9BRoGdOfUxAS9VrjrJ32JCnYqgyc0rFJ1EGniF0HV6w>
 <xmx:efjLaItXt8WYvdgv3J6sn0P7xq1rlT5Zp3VNy_OPWFIFJsnjKbnHBw>
 <xmx:evjLaM3J6nNkZOYLa1qyVggt3DK-5n4wi5fgfw6wYSg5-MF3t5kQVqnL>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Sep 2025 08:18:01 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: Tyler Retzlaff <roretzla@linux.microsoft.com>,
 Maxime Coquelin <maxime.coquelin@redhat.com>,
 Chenbo Xia <chenbox@nvidia.com>
Subject: [PATCH] lib: fix include guards
Date: Thu, 18 Sep 2025 14:17:51 +0200
Message-ID: <20250918121751.1552714-1-thomas@monjalon.net>
X-Mailer: git-send-email 2.51.0
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

Fix the namespace of include guards by prefixing with "RTE",
and add a missing include guard in rte_eal_paging.h.

Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
---
 lib/eal/include/rte_eal_paging.h | 11 ++++++++---
 lib/eal/include/rte_keepalive.h  |  6 +++---
 lib/jobstats/rte_jobstats.h      |  6 +++---
 lib/vhost/rte_vhost_crypto.h     |  6 +++---
 4 files changed, 17 insertions(+), 12 deletions(-)

diff --git a/lib/eal/include/rte_eal_paging.h b/lib/eal/include/rte_eal_paging.h
index f4431bb349..a05cf41ac9 100644
--- a/lib/eal/include/rte_eal_paging.h
+++ b/lib/eal/include/rte_eal_paging.h
@@ -2,9 +2,8 @@
  * Copyright(c) 2020 Dmitry Kozlyuk
  */
 
-#include <stdint.h>
-
-#include <rte_compat.h>
+#ifndef RTE_EAL_PAGING_H
+#define RTE_EAL_PAGING_H
 
 /**
  * @file
@@ -13,6 +12,10 @@
  * Wrappers for OS facilities related to memory paging, used across DPDK.
  */
 
+#include <stdint.h>
+
+#include <rte_compat.h>
+
 /** Memory protection flags. */
 enum rte_mem_prot {
 	RTE_PROT_READ = 1 << 0,   /**< Read access. */
@@ -101,3 +104,5 @@ rte_mem_page_size(void);
 __rte_internal
 int
 rte_mem_lock(const void *virt, size_t size);
+
+#endif /* RTE_EAL_PAGING_H */
diff --git a/lib/eal/include/rte_keepalive.h b/lib/eal/include/rte_keepalive.h
index 9ff870f6b4..04d96947b0 100644
--- a/lib/eal/include/rte_keepalive.h
+++ b/lib/eal/include/rte_keepalive.h
@@ -7,8 +7,8 @@
  * DPDK RTE LCore Keepalive Monitor.
  */
 
-#ifndef _KEEPALIVE_H_
-#define _KEEPALIVE_H_
+#ifndef RTE_KEEPALIVE_H
+#define RTE_KEEPALIVE_H
 
 #include <rte_config.h>
 #include <rte_memory.h>
@@ -146,4 +146,4 @@ rte_keepalive_register_relay_callback(struct rte_keepalive *keepcfg,
 }
 #endif
 
-#endif /* _KEEPALIVE_H_ */
+#endif /* RTE_KEEPALIVE_H */
diff --git a/lib/jobstats/rte_jobstats.h b/lib/jobstats/rte_jobstats.h
index bdd85fe000..08549be35f 100644
--- a/lib/jobstats/rte_jobstats.h
+++ b/lib/jobstats/rte_jobstats.h
@@ -2,8 +2,8 @@
  * Copyright(c) 2015 Intel Corporation
  */
 
-#ifndef JOBSTATS_H_
-#define JOBSTATS_H_
+#ifndef RTE_JOBSTATS_H
+#define RTE_JOBSTATS_H
 
 #include <stdint.h>
 
@@ -303,4 +303,4 @@ rte_jobstats_reset(struct rte_jobstats *job);
 }
 #endif
 
-#endif /* JOBSTATS_H_ */
+#endif /* RTE_JOBSTATS_H */
diff --git a/lib/vhost/rte_vhost_crypto.h b/lib/vhost/rte_vhost_crypto.h
index af61f0907e..adfd5cfab0 100644
--- a/lib/vhost/rte_vhost_crypto.h
+++ b/lib/vhost/rte_vhost_crypto.h
@@ -2,8 +2,8 @@
  * Copyright(c) 2017-2018 Intel Corporation
  */
 
-#ifndef _VHOST_CRYPTO_H_
-#define _VHOST_CRYPTO_H_
+#ifndef _RTE_VHOST_CRYPTO_H_
+#define _RTE_VHOST_CRYPTO_H_
 
 #include <stdint.h>
 
@@ -134,4 +134,4 @@ rte_vhost_crypto_finalize_requests(struct rte_crypto_op **ops,
 }
 #endif
 
-#endif /**< _VHOST_CRYPTO_H_ */
+#endif /* _RTE_VHOST_CRYPTO_H_ */
-- 
2.51.0

