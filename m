Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F21D5C3ABB0
	for <dpdk-dev@archiver.kernel.org>; Mon,  5 May 2025 15:22:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 41D344025D;
	Mon,  5 May 2025 17:22:50 +0200 (CEST)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 72BB54003C
 for <dev@dpdk.org>; Mon,  5 May 2025 17:22:48 +0200 (CEST)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id 5ECC62115DB9; Mon,  5 May 2025 08:22:47 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5ECC62115DB9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1746458567;
 bh=x3bsGRCugXhNA/ucvcNToxnWmYB1jf3oQrCfvi5lJl4=;
 h=From:To:Cc:Subject:Date:From;
 b=etqITCoS1MZNf7RuOvelJXEi4szxocmynXX2wvgg5mQtLkZwFR9fRNvqULlFDMP1S
 80zHSKAQXNCfqWPO2BOv3A+n3NbgzNEx8G/a3j7smsO/bWr+56sadBD7Rd+swHXYg2
 Cdy9S9XTOqzOS6IXyWP2uK2sTOlEM3zTwLmSbivk=
From: Andre Muezerie <andremue@linux.microsoft.com>
To: Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>,
 Bing Zhao <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>,
 Suanming Mou <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
Cc: dev@dpdk.org,
	Andre Muezerie <andremue@linux.microsoft.com>
Subject: [PATCH] doc: update parameters to use for mlx5 on Windows
Date: Mon,  5 May 2025 08:22:41 -0700
Message-Id: <1746458561-13525-1-git-send-email-andremue@linux.microsoft.com>
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

The linker parameters to use with MSVC and Clang differ.
Showing explicitly what to use with each in the documentation.

Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
---
 doc/guides/platform/mlx5.rst | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/doc/guides/platform/mlx5.rst b/doc/guides/platform/mlx5.rst
index ab3107209a..7a5bea3b49 100644
--- a/doc/guides/platform/mlx5.rst
+++ b/doc/guides/platform/mlx5.rst
@@ -268,14 +268,26 @@ configured by the ``ibverbs_link`` build option:
 Compilation on Windows
 ~~~~~~~~~~~~~~~~~~~~~~
 
-The DevX SDK location must be set through CFLAGS/LDFLAGS,
-either::
+The DevX SDK location must be set through CFLAGS/LDFLAGS.
+When compiling with MSVC, use either::
 
-   meson.exe setup "-Dc_args=-I\"%DEVX_INC_PATH%\"" "-Dc_link_args=-L\"%DEVX_LIB_PATH%\"" ...
+   meson.exe setup "-Dc_args=-I\"%DEVX_INC_PATH%\""
+   "-Dc_link_args=-LIBPATH:\"%DEVX_LIB_PATH%\"" -Denable_stdatomic=true ...
 
 or::
 
-   set CFLAGS=-I"%DEVX_INC_PATH%" && set LDFLAGS=-L"%DEVX_LIB_PATH%" && meson.exe setup ...
+   set CFLAGS=-I"%DEVX_INC_PATH%" && set LDFLAGS=-LIBPATH:"%DEVX_LIB_PATH%" &&
+   meson.exe setup -Denable_stdatomic=true ...
+
+When compiling with Clang, use either::
+
+   meson.exe setup "-Dc_args=-I\"%DEVX_INC_PATH%\""
+   "-Dc_link_args=-Wl,-LIBPATH:\"%DEVX_LIB_PATH%\"" ...
+
+or::
+
+   set CFLAGS=-I"%DEVX_INC_PATH%" && set LDFLAGS=-Wl,-LIBPATH:"%DEVX_LIB_PATH%" &&
+   meson.exe setup ...
 
 
 .. _mlx5_common_env:
-- 
2.49.0.vfs.0.0

