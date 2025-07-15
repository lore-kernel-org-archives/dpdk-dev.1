Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5583CC83F21
	for <dpdk-dev@archiver.kernel.org>; Tue, 15 Jul 2025 14:14:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8DAA14028C;
	Tue, 15 Jul 2025 16:14:55 +0200 (CEST)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id D6C134021E
 for <dev@dpdk.org>; Tue, 15 Jul 2025 16:14:53 +0200 (CEST)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id 33140201BA1A; Tue, 15 Jul 2025 07:14:53 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 33140201BA1A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1752588893;
 bh=dv+fbcKs18INWo4sFM+005kKjOVy4nOiTmNYmYcHiR8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=OpPlbQzmVu+3gEDcEuMgE1cyvUYoU5z/1Qn5tVjnSomGn6ppybLj/gBK5BEYDdIHi
 6hrIeWXHSTDkwvuwUUr6dq6julbPUugHNIdvrdn/OMqEWgMo7WSGvXKUkQwUckAUPV
 HTd9sbYd4sK37VhbZJyiUS2McL1AdVbbz5CzzRsY=
From: Andre Muezerie <andremue@linux.microsoft.com>
To: andremue@linux.microsoft.com
Cc: bingz@nvidia.com, dev@dpdk.org, dsosnowski@nvidia.com, matan@nvidia.com,
 orika@nvidia.com, suanmingm@nvidia.com, viacheslavo@nvidia.com
Subject: [PATCH v2] doc: update parameters to use for mlx5 on Windows
Date: Tue, 15 Jul 2025 07:14:49 -0700
Message-Id: <1752588889-27133-1-git-send-email-andremue@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1746458561-13525-1-git-send-email-andremue@linux.microsoft.com>
References: <1746458561-13525-1-git-send-email-andremue@linux.microsoft.com>
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
 doc/guides/platform/mlx5.rst | 27 +++++++++++++++++++++++----
 1 file changed, 23 insertions(+), 4 deletions(-)

diff --git a/doc/guides/platform/mlx5.rst b/doc/guides/platform/mlx5.rst
index ab3107209a..94ed59b170 100644
--- a/doc/guides/platform/mlx5.rst
+++ b/doc/guides/platform/mlx5.rst
@@ -268,14 +268,33 @@ configured by the ``ibverbs_link`` build option:
 Compilation on Windows
 ~~~~~~~~~~~~~~~~~~~~~~
 
-The DevX SDK location must be set through CFLAGS/LDFLAGS,
-either::
+The DevX SDK location must be set through CFLAGS/LDFLAGS.
+When compiling with MSVC, use either::
 
-   meson.exe setup "-Dc_args=-I\"%DEVX_INC_PATH%\"" "-Dc_link_args=-L\"%DEVX_LIB_PATH%\"" ...
+   meson.exe setup ^
+       "-Dc_args=-I\"%DEVX_INC_PATH%\"" ^
+       "-Dc_link_args=-LIBPATH:\"%DEVX_LIB_PATH%\"" ^
+       -Denable_stdatomic=true ^
+       ...
 
 or::
 
-   set CFLAGS=-I"%DEVX_INC_PATH%" && set LDFLAGS=-L"%DEVX_LIB_PATH%" && meson.exe setup ...
+   set CFLAGS=-I"%DEVX_INC_PATH%"
+   set LDFLAGS=-LIBPATH:"%DEVX_LIB_PATH%"
+   meson.exe setup -Denable_stdatomic=true ...
+
+When compiling with Clang, use either::
+
+   meson.exe setup ^
+       "-Dc_args=-I\"%DEVX_INC_PATH%\"" ^
+       "-Dc_link_args=-Wl,-LIBPATH:\"%DEVX_LIB_PATH%\"" ^
+       ...
+
+or::
+
+   set CFLAGS=-I"%DEVX_INC_PATH%"
+   set LDFLAGS=-Wl,-LIBPATH:"%DEVX_LIB_PATH%"
+   meson.exe setup ...
 
 
 .. _mlx5_common_env:
-- 
2.50.1.vfs.0.0

