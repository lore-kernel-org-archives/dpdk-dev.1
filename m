Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD8AFC7EE2A
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Jun 2025 18:28:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8844E40DD2;
	Wed, 25 Jun 2025 20:28:00 +0200 (CEST)
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com
 [209.85.210.202])
 by mails.dpdk.org (Postfix) with ESMTP id 002D9406A2
 for <dev@dpdk.org>; Wed, 25 Jun 2025 20:27:59 +0200 (CEST)
Received: by mail-pf1-f202.google.com with SMTP id
 d2e1a72fcca58-748efefedb5so230126b3a.2
 for <dev@dpdk.org>; Wed, 25 Jun 2025 11:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1750876079; x=1751480879; darn=dpdk.org;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=xmZF/K1ll3t/VkD6pu3/bTPD6pyia8hUbgKYQygfQAs=;
 b=L4ooxDbEOrq9BY7lrfb6T9UEciTKNMiLB35dUnIPow617OKNddrxTt8/wAGAvO6Brv
 hJjHAQvmoLexvPEQoaM5LKIMTK4n9H/gGY7XbcqM8LUcbwHF15CpMtMkXxwm5Y8GjjIM
 oMG7H+6Gn/Vlf8jyPHiUTxcSHsIVY5UbA1Y1Np0+qjWffYmZvmz9txExbdi5RRgKk0yo
 OXI1cMaalULIJNLCR3mKo2PYhMRE8EkNnPEkBOTm3XkZ5MLtLNVnYbFALVBn7EphqJMc
 pZ5r465jBhu9wiDGz+H3P6jPOH7wbNKatTAuLihA2L1OzukUrz1OZ6p6+aVHLnIXdWR+
 j9Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750876079; x=1751480879;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xmZF/K1ll3t/VkD6pu3/bTPD6pyia8hUbgKYQygfQAs=;
 b=jwBWgx1VrJ7IlpoDbxQG4J+DSpjZXgTRRNVF3qC+NsX4+0ARkfdRz7pvVBCjYijVUA
 S7HjVk4+D5ux0Y0CQICOloK0wtZElC5gxzj9A8Jnn1oiWJ4XqV10FHGI78CzFJF7oPpn
 vE9JXYQ2umRR4tfVotHTJczZRls5cyZGw5YmeTv0qGiJqLI1H1OaNSq8L8rPArkQ2N6Q
 QRRWtlnpSAicbDLC5ORVqT15p4HIGsulGKdG3fNA2oeFbDHmN/EiH1S5qAqLdQZftYxN
 IeLOILZwGQckmr4+6fbzKgnQt4Hukp/cGYfiz4t3Rbbi5wTlmsDtFnVcFOJQE5kFW70r
 VZxw==
X-Gm-Message-State: AOJu0YxnA80ZLyUafuRyZKop76trzQv7INq5y1KzsnbQBl0fw/lY34sX
 mUHIPl1ZVwct4vTZCKpuG9vALYVNZBEVCTjYAuOEyhFMdRAzSZpSyX/MlmcBY5KHrfxXFh7L4QV
 h6B79Vvv/92zLt+eXaCP8nApyGQ==
X-Google-Smtp-Source: AGHT+IEeXJs+SqCsNqRSYS6W1xt1dMv3PE+gaARBD9FSpvbT0iDC33+3o2UDgycrmvmU3dejPx+F4OUdaDKsZwtIiQ==
X-Received: from pfjf20.prod.google.com ([2002:a05:6a00:22d4:b0:746:22b3:4c0d])
 (user=jtranoleary job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:b93:b0:21a:eb6a:b84b with SMTP id
 adf61e73a8af0-2207f289b52mr6969224637.30.1750876079075; 
 Wed, 25 Jun 2025 11:27:59 -0700 (PDT)
Date: Wed, 25 Jun 2025 18:27:51 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250625182751.1936925-1-jtranoleary@google.com>
Subject: [PATCH] net/gve: support gve driver on FreeBSD
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
---
 .mailmap                         | 1 +
 drivers/net/gve/base/gve_osdep.h | 2 +-
 drivers/net/gve/gve_ethdev.c     | 2 +-
 drivers/net/gve/meson.build      | 4 ++--
 4 files changed, 5 insertions(+), 4 deletions(-)

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
diff --git a/drivers/net/gve/base/gve_osdep.h b/drivers/net/gve/base/gve_osdep.h
index 5eb33930cd..365d44fdba 100644
--- a/drivers/net/gve/base/gve_osdep.h
+++ b/drivers/net/gve/base/gve_osdep.h
@@ -25,7 +25,7 @@

 #include "../gve_logs.h"

-#ifdef RTE_EXEC_ENV_LINUX
+#if defined(RTE_EXEC_ENV_LINUX) || defined(RTE_EXEC_ENV_FREEBSD)
 #include <sys/utsname.h>
 #endif

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
index ed5ef0a1fc..14a17db4bf 100644
--- a/drivers/net/gve/meson.build
+++ b/drivers/net/gve/meson.build
@@ -1,9 +1,9 @@
 # SPDX-License-Identifier: BSD-3-Clause
 # Copyright(C) 2022 Intel Corporation

-if not is_linux
+if not is_linux and not is_freebsd
     build = false
-    reason = 'only supported on Linux'
+    reason = 'only supported on Linux and FreeBSD'
     subdir_done()
 endif

--
2.49.0

