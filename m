Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81FF0C021AA
	for <dpdk-dev@archiver.kernel.org>; Tue, 18 Feb 2025 16:33:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BDFA940A6E;
	Tue, 18 Feb 2025 17:32:27 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 3CEFF40664
 for <dev@dpdk.org>; Tue, 18 Feb 2025 17:32:16 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id B98F220376F0; Tue, 18 Feb 2025 08:32:14 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B98F220376F0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1739896334;
 bh=vn6GfQCAj2RrgB+geIVCJLKWwQ+rnpDq/5tPKQ2dz0g=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=VAmbZiuvvQVXFMCVzZLmZoBayUqllicfYlP3O1y42ZTis4h4cthktc1z7584O1tkt
 XMaZOKMkbmXQ0V7CgPtsZoCWB6F6bJyDK2dayJuIx9sPwBCZhOvB0xT1YdIt1LdH0X
 y+YMCsFsHsC6wMh5ELvIlGQvM5aGVSm0XC8RBAjs=
From: Andre Muezerie <andremue@linux.microsoft.com>
To: andremue@linux.microsoft.com
Cc: dev@dpdk.org
Subject: [PATCH v2 10/10] app: enable app directory to be compiled with MSVC
Date: Tue, 18 Feb 2025 08:32:09 -0800
Message-Id: <1739896329-1946-11-git-send-email-andremue@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1739896329-1946-1-git-send-email-andremue@linux.microsoft.com>
References: <1739311325-14425-1-git-send-email-andremue@linux.microsoft.com>
 <1739896329-1946-1-git-send-email-andremue@linux.microsoft.com>
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

Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
---
 app/meson.build          | 4 ----
 app/test-pmd/meson.build | 4 +++-
 2 files changed, 3 insertions(+), 5 deletions(-)

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
index f1c36529b4..8e8863812a 100644
--- a/app/test-pmd/meson.build
+++ b/app/test-pmd/meson.build
@@ -3,7 +3,9 @@
 
 # override default name to drop the hyphen
 name = 'testpmd'
-cflags += '-Wno-deprecated-declarations'
+if cc.has_argument('-Wno-deprecated-declarations')
+    cflags += '-Wno-deprecated-declarations'
+endif
 sources = files(
         '5tswap.c',
         'cmdline.c',
-- 
2.48.1.vfs.0.0

