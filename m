Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 548F6CCA470
	for <dpdk-dev@archiver.kernel.org>; Wed,  1 Oct 2025 06:45:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B884840695;
	Wed,  1 Oct 2025 08:45:46 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id C56F34065D
 for <dev@dpdk.org>; Wed,  1 Oct 2025 08:45:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759301144;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c+PvB76s+kYiYhlphM3EjqTGup4Fn7Mar1qb79pUTPk=;
 b=A4OjOZKcN8ZBTXpG1Ku7aAEcnwK4Br16sfF23dFNFwW55E80ArdlozDZq35eCXaruAPxSF
 eEipBgGmgZPRDurGmKcULblgpHrhZDhq6PHUdwE/C+aZJ32I5b5LeEX0llG9U8XktU/yv9
 I3ZhdcAH5lPPm2hfuk/SyTGlXma5aF8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-601-h8kpWXyuN9a2lfhxsRBeJg-1; Wed,
 01 Oct 2025 02:45:38 -0400
X-MC-Unique: h8kpWXyuN9a2lfhxsRBeJg-1
X-Mimecast-MFC-AGG-ID: h8kpWXyuN9a2lfhxsRBeJg_1759301137
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6001A180034D; Wed,  1 Oct 2025 06:45:36 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.45.224.213])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id F02CF19560B4; Wed,  1 Oct 2025 06:45:31 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Akhil Goyal <gakhil@marvell.com>,
 Nicolas Chautru <nicolas.chautru@intel.com>,
 Thomas Monjalon <thomas@monjalon.net>,
 Srikanth Yalavarthi <syalavarthi@marvell.com>,
 Sachin Saxena <sachin.saxena@nxp.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>, Ori Kam <orika@nvidia.com>,
 Anoob Joseph <anoobj@marvell.com>
Subject: [PATCH v7 2/9] drivers: drop export of driver headers
Date: Wed,  1 Oct 2025 08:45:04 +0200
Message-ID: <20251001064512.2539269-3-david.marchand@redhat.com>
In-Reply-To: <20251001064512.2539269-1-david.marchand@redhat.com>
References: <20241127112617.1331125-1-david.marchand@redhat.com>
 <20251001064512.2539269-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 05pUiJzaYKlvbFVN3jK6aNmA9XrOkhhmTiLuzoUiJ6E_1759301137
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

Many classes are exposing driver only headers as public headers.
Move them to the driver_sdk_headers list.

Signed-off-by: David Marchand <david.marchand@redhat.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
Acked-by: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Acked-by: Akhil Goyal <gakhil@marvell.com>
---
Changes since v2:
- rebased,

---
 lib/bbdev/meson.build    | 14 +++++++++-----
 lib/ethdev/meson.build   |  6 +++---
 lib/mldev/meson.build    |  5 +----
 lib/rawdev/meson.build   |  3 ++-
 lib/regexdev/meson.build |  3 ++-
 lib/security/meson.build |  3 ++-
 6 files changed, 19 insertions(+), 15 deletions(-)

diff --git a/lib/bbdev/meson.build b/lib/bbdev/meson.build
index 2e48d5f3da..002fc3f1ac 100644
--- a/lib/bbdev/meson.build
+++ b/lib/bbdev/meson.build
@@ -1,10 +1,14 @@
 # SPDX-License-Identifier: BSD-3-Clause
 # Copyright(c) 2017 Intel Corporation
 
-sources = files('rte_bbdev.c',
-        'bbdev_trace_points.c')
-headers = files('rte_bbdev.h',
-        'rte_bbdev_pmd.h',
+sources = files(
+        'rte_bbdev.c',
+        'bbdev_trace_points.c',
+)
+headers = files(
+        'rte_bbdev.h',
         'rte_bbdev_op.h',
-        'rte_bbdev_trace_fp.h')
+        'rte_bbdev_trace_fp.h',
+)
+driver_sdk_headers = files('rte_bbdev_pmd.h')
 deps += ['mbuf']
diff --git a/lib/ethdev/meson.build b/lib/ethdev/meson.build
index f1d2586591..8ba6c708a2 100644
--- a/lib/ethdev/meson.build
+++ b/lib/ethdev/meson.build
@@ -26,11 +26,8 @@ headers = files(
         'rte_ethdev_trace_fp.h',
         'rte_dev_info.h',
         'rte_flow.h',
-        'rte_flow_driver.h',
         'rte_mtr.h',
-        'rte_mtr_driver.h',
         'rte_tm.h',
-        'rte_tm_driver.h',
 )
 
 indirect_headers += files(
@@ -42,6 +39,9 @@ driver_sdk_headers += files(
         'ethdev_driver.h',
         'ethdev_pci.h',
         'ethdev_vdev.h',
+        'rte_flow_driver.h',
+        'rte_mtr_driver.h',
+        'rte_tm_driver.h',
 )
 
 if is_linux
diff --git a/lib/mldev/meson.build b/lib/mldev/meson.build
index 0079ccd205..39f1fba927 100644
--- a/lib/mldev/meson.build
+++ b/lib/mldev/meson.build
@@ -26,11 +26,8 @@ headers = files(
         'rte_mldev.h',
 )
 
-indirect_headers += files(
-        'rte_mldev_core.h',
-)
-
 driver_sdk_headers += files(
+        'rte_mldev_core.h',
         'rte_mldev_pmd.h',
         'mldev_utils.h',
 )
diff --git a/lib/rawdev/meson.build b/lib/rawdev/meson.build
index 7dfc3d5cf9..ccfd922fda 100644
--- a/lib/rawdev/meson.build
+++ b/lib/rawdev/meson.build
@@ -8,6 +8,7 @@ if is_windows
 endif
 
 sources = files('rte_rawdev.c')
-headers = files('rte_rawdev.h', 'rte_rawdev_pmd.h')
+headers = files('rte_rawdev.h')
+driver_sdk_headers = files('rte_rawdev_pmd.h')
 
 deps += ['telemetry']
diff --git a/lib/regexdev/meson.build b/lib/regexdev/meson.build
index 7e12d8cd6d..2684da3825 100644
--- a/lib/regexdev/meson.build
+++ b/lib/regexdev/meson.build
@@ -2,6 +2,7 @@
 # Copyright 2020 Mellanox Technologies, Ltd
 
 sources = files('rte_regexdev.c')
-headers = files('rte_regexdev.h', 'rte_regexdev_driver.h')
+headers = files('rte_regexdev.h')
 indirect_headers += files('rte_regexdev_core.h')
+driver_sdk_headers = files('rte_regexdev_driver.h')
 deps += ['mbuf']
diff --git a/lib/security/meson.build b/lib/security/meson.build
index 1034a7a299..d5431d472c 100644
--- a/lib/security/meson.build
+++ b/lib/security/meson.build
@@ -2,5 +2,6 @@
 # Copyright(c) 2017-2019 Intel Corporation
 
 sources = files('rte_security.c')
-headers = files('rte_security.h', 'rte_security_driver.h')
+headers = files('rte_security.h')
+driver_sdk_headers = files('rte_security_driver.h')
 deps += ['mempool', 'cryptodev', 'net']
-- 
2.51.0

