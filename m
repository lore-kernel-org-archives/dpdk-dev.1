Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70BC1C021B1
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Feb 2025 20:32:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 38C3440648;
	Thu, 20 Feb 2025 21:32:14 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 3345F4026D
 for <dev@dpdk.org>; Thu, 20 Feb 2025 21:32:05 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id E222A204E591; Thu, 20 Feb 2025 12:32:03 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E222A204E591
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1740083523;
 bh=yz60ntRP+z3fEpAzI9HiVdZEH5lU7X8s9ehHlgLkPsM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=M40ESwxlhnw+i1U+9rs3CX6b4DWlCBefP6u0s2C47ayvtTGEkkD769n+oLGv2ybxY
 1fyjduOyr+qVq3TestJT1T/87SHBjjzhGLcvD9MlkPoMdRT+F0p3iZ+QlaFGspgrnG
 2schK2RbVt1Zx+L0ujJWyk6Fl7PLwGIjDveHkAI4=
From: Andre Muezerie <andremue@linux.microsoft.com>
To: andremue@linux.microsoft.com
Cc: dev@dpdk.org
Subject: [PATCH v3 6/6] mbuf: enable to be compiled with MSVC
Date: Thu, 20 Feb 2025 12:31:48 -0800
Message-Id: <1740083508-6703-7-git-send-email-andremue@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1740083508-6703-1-git-send-email-andremue@linux.microsoft.com>
References: <1739224265-4158-1-git-send-email-andremue@linux.microsoft.com>
 <1740083508-6703-1-git-send-email-andremue@linux.microsoft.com>
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

Now that the issues preventing this lib from be compiled with MSVC
are fixed it can be included in the compilation.

The "net" library will automatically get compiled as well as it
has a dependency on "mbuf" which will now get fulfilled.

Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
 lib/mbuf/meson.build | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/lib/mbuf/meson.build b/lib/mbuf/meson.build
index 2cee9057a5..0435c5e628 100644
--- a/lib/mbuf/meson.build
+++ b/lib/mbuf/meson.build
@@ -1,12 +1,6 @@
 # SPDX-License-Identifier: BSD-3-Clause
 # Copyright(c) 2017 Intel Corporation
 
-if is_ms_compiler
-    build = false
-    reason = 'not supported building with Visual Studio Toolset'
-    subdir_done()
-endif
-
 sources = files(
         'rte_mbuf.c',
         'rte_mbuf_ptype.c',
-- 
2.48.1.vfs.0.0

