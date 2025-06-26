Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E087C7EE30
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Jun 2025 21:19:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CD06D40270;
	Thu, 26 Jun 2025 23:19:45 +0200 (CEST)
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com
 [209.85.215.201])
 by mails.dpdk.org (Postfix) with ESMTP id 2CE5F4026F
 for <dev@dpdk.org>; Thu, 26 Jun 2025 23:19:44 +0200 (CEST)
Received: by mail-pg1-f201.google.com with SMTP id
 41be03b00d2f7-b31ff607527so1059954a12.0
 for <dev@dpdk.org>; Thu, 26 Jun 2025 14:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1750972783; x=1751577583; darn=dpdk.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=h0kr7+S+tm+kOd7TTUhI9uSYJjssZ04VlUTkJFTeMQg=;
 b=ElA0AvY9tZ9VKdMy+cpKiHr04tsPmOnCkhAcT1Jxje2P72sMQsL8fq1ilLaZpa6nOJ
 bshVFMjlY6gl7kHdxsWFrRtA753MmipETtwLm7E3W3R4n08NHrgHPJ/VvF59LRy8x4ot
 f+wFotmWCZgI0/pDQcorAaKm08sX8Be1Lfh9ZuMQ5TS0iBvgdPCuTtx5hVcALX4cT/5N
 0cUM9PwbG53+ssfoiC5L/7f+NnLyZtfML9VvSxsWybmlSdkYb36z9GeH0XGhguWSwVg4
 8PaoTkUkn8w5cQcJNLnHjJUYlyC2HQMbrDX++LlDBqlvBK+nsiD+Qw+x8vpqgB2FNrUA
 fKyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750972783; x=1751577583;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=h0kr7+S+tm+kOd7TTUhI9uSYJjssZ04VlUTkJFTeMQg=;
 b=eNGJBmOHCEiDbiK/xQ1YtyIcKmX9UW2zoC2zUS3gOMrbHnyRKfAP4KGT2ZIW8uwkR2
 3EwGeNGHabaUjRMiTTbA/EAAwTPIyybKrmsu2z2BXy45fueH06Vaab11hhfupcochbNR
 EO8EUXPJQpJTYedABcVoxo7NkC6nSKq78Xf14jf/11P/Og+lvEfMJ4N8t8UWi++qvUri
 BUYwHOHPA1aCJKcabG78P4w31PxGcMtX6Dm8XA3RLRQ2Mu4H5Z3RkYjUDgBgPvrJGQQT
 RXoRtXhazZumuXhr8MRkJiZ9nJcfN40gQJs4NjT9QUaGZ796Iwf/QfCu95GHHXNdqHmt
 Sxiw==
X-Gm-Message-State: AOJu0Yx3phCEMKmoZyImp6rL+CkwvD4SBaDERIDZ+7RTwTmYN0yHDoPH
 lkgzy88EQYlgZfI/sjgXpzfr8zcUevNmrwqh10ZGcg+Qxm78E00ENBF/dKfxGrf9jpPkpbPdi8l
 5dDzg3iRRlI+pPsGwrxhJh94jWA==
X-Google-Smtp-Source: AGHT+IGbo/sbVKPpph3tHcHIwlhpqH0LdSQzar18LT8E7LgtRjJQoDgJXHrnnPNmTzpt6KgHNcCf22+emHjp56uXdw==
X-Received: from pgb12.prod.google.com ([2002:a05:6a02:340c:b0:b2f:64be:6881])
 (user=jtranoleary job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:9194:b0:1fa:9819:c0a5 with SMTP id
 adf61e73a8af0-220a1277105mr695644637.11.1750972783286; 
 Thu, 26 Jun 2025 14:19:43 -0700 (PDT)
Date: Thu, 26 Jun 2025 21:19:21 +0000
In-Reply-To: <20250625182751.1936925-1-jtranoleary@google.com>
Mime-Version: 1.0
References: <20250625182751.1936925-1-jtranoleary@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250626211921.2291937-1-jtranoleary@google.com>
Subject: [PATCH v2] net/gve: support gve driver on FreeBSD
From: "Jasper Tran O'Leary" <jtranoleary@google.com>
To: joshwash@google.com
Cc: dev@dpdk.org, "Jasper Tran O'Leary" <jtranoleary@google.com>
Content-Type: text/plain; charset="UTF-8"
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

This commit adds small changes so that the gve driver can build when
FreeBSD is the host operating system.

Signed-off-by: Jasper Tran O'Leary <jtranoleary@google.com>
Acked-by: Joshua Washington <joshwash@google.com>
---
 .mailmap                         | 1 +
 doc/guides/nics/features/gve.ini | 1 +
 drivers/net/gve/base/gve_osdep.h | 2 --
 drivers/net/gve/gve_ethdev.c     | 2 +-
 drivers/net/gve/meson.build      | 4 ++--
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/.mailmap b/.mailmap
index 8483d96ec5..4ce891b223 100644
--- a/.mailmap
+++ b/.mailmap
@@ -650,6 +650,7 @@ Jaroslaw Gawin <jaroslawx.gawin@intel.com>
 Jaroslaw Ilgiewicz <jaroslaw.ilgiewicz@intel.com>
 Jason He <jason.he@broadcom.com>
 Jason Wang <jasowang@redhat.com>
+Jasper Tran O'Leary <jtranoleary@google.com>
 Jasvinder Singh <jasvinder.singh@intel.com>
 Jay Ding <jay.ding@broadcom.com>
 Jay Jayatheerthan <jay.jayatheerthan@intel.com>
diff --git a/doc/guides/nics/features/gve.ini b/doc/guides/nics/features/gve.ini
index f18b829eda..ed040a01dd 100644
--- a/doc/guides/nics/features/gve.ini
+++ b/doc/guides/nics/features/gve.ini
@@ -14,6 +14,7 @@ RSS key update       = Y
 RSS reta update      = Y
 L4 checksum offload  = Y
 Basic stats          = Y
+FreeBSD              = Y
 Linux                = Y
 x86-32               = Y
 x86-64               = Y
diff --git a/drivers/net/gve/base/gve_osdep.h b/drivers/net/gve/base/gve_osdep.h
index 5eb33930cd..c47ce4da85 100644
--- a/drivers/net/gve/base/gve_osdep.h
+++ b/drivers/net/gve/base/gve_osdep.h
@@ -25,9 +25,7 @@

 #include "../gve_logs.h"

-#ifdef RTE_EXEC_ENV_LINUX
 #include <sys/utsname.h>
-#endif

 #ifndef u8
 #define u8 uint8_t
diff --git a/drivers/net/gve/gve_ethdev.c b/drivers/net/gve/gve_ethdev.c
index e471a34e61..bdb7f1d075 100644
--- a/drivers/net/gve/gve_ethdev.c
+++ b/drivers/net/gve/gve_ethdev.c
@@ -1366,5 +1366,5 @@ static struct rte_pci_driver rte_gve_pmd = {

 RTE_PMD_REGISTER_PCI(net_gve, rte_gve_pmd);
 RTE_PMD_REGISTER_PCI_TABLE(net_gve, pci_id_gve_map);
-RTE_PMD_REGISTER_KMOD_DEP(net_gve, "* igb_uio | vfio-pci");
+RTE_PMD_REGISTER_KMOD_DEP(net_gve, "* igb_uio | vfio-pci | nic_uio");
 RTE_LOG_REGISTER_SUFFIX(gve_logtype_driver, driver, NOTICE);
diff --git a/drivers/net/gve/meson.build b/drivers/net/gve/meson.build
index ed5ef0a1fc..add431c2bb 100644
--- a/drivers/net/gve/meson.build
+++ b/drivers/net/gve/meson.build
@@ -1,9 +1,9 @@
 # SPDX-License-Identifier: BSD-3-Clause
 # Copyright(C) 2022 Intel Corporation

-if not is_linux
+if is_windows
     build = false
-    reason = 'only supported on Linux'
+    reason = 'not supported on Windows'
     subdir_done()
 endif

--
2.49.0

