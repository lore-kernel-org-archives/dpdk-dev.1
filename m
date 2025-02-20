Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CAC3C021B0
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Feb 2025 02:02:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 325E940615;
	Thu, 20 Feb 2025 03:02:01 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 34686402C6
 for <dev@dpdk.org>; Thu, 20 Feb 2025 03:01:49 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id AAE08204E5BA; Wed, 19 Feb 2025 18:01:47 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com AAE08204E5BA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1740016907;
 bh=mpKdIy61gyRYiRcav3/U6fSEIAxqPTTlItLbLWXI+6M=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=CGmDfn+egRrVpqfBBJbeB0b8XAbIJCYu3FBT9sWNZydB1p46XN2+Y6j11baEMAyP6
 CATt+rh6O2KAXdNDymAvbIvO8P7YR5l6lWtdVbULY/SeOSody1gYbrcjPGPOOWcimk
 HkWzbFft/R5/Je/FbSIFEtnEyW1fM4S+7yGvJxd4=
From: Andre Muezerie <andremue@linux.microsoft.com>
To: andremue@linux.microsoft.com
Cc: dev@dpdk.org
Subject: [PATCH v3 10/10] app: enable app directory to be compiled with MSVC
Date: Wed, 19 Feb 2025 18:01:39 -0800
Message-Id: <1740016899-2817-11-git-send-email-andremue@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1740016899-2817-1-git-send-email-andremue@linux.microsoft.com>
References: <1739311325-14425-1-git-send-email-andremue@linux.microsoft.com>
 <1740016899-2817-1-git-send-email-andremue@linux.microsoft.com>
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

Enabled "app" directory to be compiled with MSVC along with all its
contents.

Removed flag Wno-deprecated-declarations which is not needed anymore.

Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
 app/meson.build          | 4 ----
 app/test-pmd/meson.build | 1 -
 2 files changed, 5 deletions(-)

diff --git a/app/meson.build b/app/meson.build
index e2db888ae1..1798db3ae4 100644
--- a/app/meson.build
+++ b/app/meson.build
@@ -1,10 +1,6 @@
 # SPDX-License-Identifier: BSD-3-Clause
 # Copyright(c) 2017-2019 Intel Corporation
 
-if is_ms_compiler
-    subdir_done()
-endif
-
 disable_apps = ',' + get_option('disable_apps')
 disable_apps = run_command(list_dir_globs, disable_apps, check: true).stdout().split()
 
diff --git a/app/test-pmd/meson.build b/app/test-pmd/meson.build
index f1c36529b4..000548c261 100644
--- a/app/test-pmd/meson.build
+++ b/app/test-pmd/meson.build
@@ -3,7 +3,6 @@
 
 # override default name to drop the hyphen
 name = 'testpmd'
-cflags += '-Wno-deprecated-declarations'
 sources = files(
         '5tswap.c',
         'cmdline.c',
-- 
2.48.1.vfs.0.0

