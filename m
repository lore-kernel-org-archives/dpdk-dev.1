Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFB05CA0EE6
	for <dpdk-dev@archiver.kernel.org>; Wed, 20 Aug 2025 01:01:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C045B4026C;
	Wed, 20 Aug 2025 03:01:05 +0200 (CEST)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 5D91D4026C
 for <dev@dpdk.org>; Wed, 20 Aug 2025 03:01:04 +0200 (CEST)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id 95A882115A5A; Tue, 19 Aug 2025 18:01:03 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 95A882115A5A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1755651663;
 bh=ONhGlOf2otYkjozM6YQq9FGZHRRZMdp5GVBj7h7sne4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=UNR5gLyZn32oGdNjDwo+hj+9uqhc2TCKOTK+9z+Tajc0BEbxgp5Nf2bT7+t3q/i9L
 Rf51Sb6+Yt0izFHGK4T7wweLOPJ2eI9dk1vQhK/rQVkL4hPfyEr9uQPP56kedHYshv
 vAV0W9mMSPwdwZFWu2LI2o46eeRZnXHryY8h2VVI=
From: Andre Muezerie <andremue@linux.microsoft.com>
To: andremue@linux.microsoft.com
Cc: dev@dpdk.org
Subject: [PATCH v5 3/3] drivers: enable drivers to be compiled with MSVC
Date: Tue, 19 Aug 2025 18:00:58 -0700
Message-Id: <1755651658-13063-4-git-send-email-andremue@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1755651658-13063-1-git-send-email-andremue@linux.microsoft.com>
References: <1735243903-26857-1-git-send-email-andremue@linux.microsoft.com>
 <1755651658-13063-1-git-send-email-andremue@linux.microsoft.com>
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

