Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0A20CA0EFA
	for <dpdk-dev@archiver.kernel.org>; Mon, 25 Aug 2025 14:58:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D778040648;
	Mon, 25 Aug 2025 16:58:36 +0200 (CEST)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id A029B4042C
 for <dev@dpdk.org>; Mon, 25 Aug 2025 16:58:33 +0200 (CEST)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id E47CC211829A; Mon, 25 Aug 2025 07:58:32 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E47CC211829A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1756133912;
 bh=ONhGlOf2otYkjozM6YQq9FGZHRRZMdp5GVBj7h7sne4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=XZEBNTrMpf0st4EBdGwcnPZvM3tdejscJChiV+ggNaA/KRNgTlxMu9KM4h1DmKXMC
 XnAGnZ4c2ABcbfl/dxuv6SK26tBDut/gZkBSmA6YEdyt+s9STuKdO0h7o3Siw+mwRj
 MagTkKPrxc5faezhk6AdyT9pLDyPO0IlqktrziyA=
From: Andre Muezerie <andremue@linux.microsoft.com>
To: andremue@linux.microsoft.com
Cc: dev@dpdk.org
Subject: [PATCH RESEND v5 3/3] drivers: enable drivers to be compiled with MSVC
Date: Mon, 25 Aug 2025 07:58:16 -0700
Message-Id: <1756133896-9216-4-git-send-email-andremue@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1756133896-9216-1-git-send-email-andremue@linux.microsoft.com>
References: <1735243903-26857-1-git-send-email-andremue@linux.microsoft.com>
 <1756133896-9216-1-git-send-email-andremue@linux.microsoft.com>
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

Now that all issues related to drivers are addressed they can be
enabled to be built with MSVC.

Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
---
 drivers/meson.build | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/meson.build b/drivers/meson.build
index b62880db02..d98ef27f66 100644
--- a/drivers/meson.build
+++ b/drivers/meson.build
@@ -1,10 +1,6 @@
 # SPDX-License-Identifier: BSD-3-Clause
 # Copyright(c) 2017-2019 Intel Corporation

-if is_ms_compiler
-    subdir_done()
-endif
-
 # Defines the order of dependencies evaluation
 subdirs = [
         'common',
--
2.50.1.vfs.0.1

