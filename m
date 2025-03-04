Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CC16C282C6
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Mar 2025 01:55:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E4A3640156;
	Tue,  4 Mar 2025 02:55:21 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 6A50740041
 for <dev@dpdk.org>; Tue,  4 Mar 2025 02:55:20 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id 7C659204E5B9; Mon,  3 Mar 2025 17:55:19 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7C659204E5B9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1741053319;
 bh=WvVYCtsFoNHDI0IKctXc5No5Kc7KM6SiMNbLGmN7R6k=;
 h=From:To:Cc:Subject:Date:From;
 b=TRy03nmhHJzytiGfOVe3TDLT/JMvjBv0QIiC5004VeuEMq6eGS295tyon+kvJaHcY
 vNohY15RgZQu59iL5tMOF+1YkXhLEbHe6k3Tfg1/PK/3zILlKoUpXsanjhRwNEnmBS
 94wP8BencdI0g4MZ1pNXaeWURDBejcTuVQNydSqQ=
From: Andre Muezerie <andremue@linux.microsoft.com>
To: Chengwen Feng <fengchengwen@huawei.com>,
 Kevin Laatz <kevin.laatz@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org,
	Andre Muezerie <andremue@linux.microsoft.com>
Subject: [PATCH] dmadev: enable lib to be compiled with MSVC
Date: Mon,  3 Mar 2025 17:55:04 -0800
Message-Id: <1741053304-9891-1-git-send-email-andremue@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
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

With the outstanding issues preventing dmadev from being compiled
with MSVC being fixed, the lib can be enabled to be compiled with MSVC.

Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
---
 lib/dmadev/meson.build | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/lib/dmadev/meson.build b/lib/dmadev/meson.build
index e66dcb66b0..62b0650b9b 100644
--- a/lib/dmadev/meson.build
+++ b/lib/dmadev/meson.build
@@ -1,12 +1,6 @@
 # SPDX-License-Identifier: BSD-3-Clause
 # Copyright(c) 2021 HiSilicon Limited.
 
-if is_ms_compiler
-    build = false
-    reason = 'not supported building with Visual Studio Toolset'
-    subdir_done()
-endif
-
 sources = files('rte_dmadev.c', 'rte_dmadev_trace_points.c')
 headers = files('rte_dmadev.h')
 indirect_headers += files('rte_dmadev_core.h', 'rte_dmadev_trace_fp.h')
-- 
2.48.1.vfs.0.0

