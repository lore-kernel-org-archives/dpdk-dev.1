Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 799ADC71136
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Jun 2025 14:17:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6C3FF427AE;
	Thu, 12 Jun 2025 16:17:28 +0200 (CEST)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 46B7E42791
 for <dev@dpdk.org>; Thu, 12 Jun 2025 16:17:26 +0200 (CEST)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id 5FAF9201C777; Thu, 12 Jun 2025 07:17:25 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5FAF9201C777
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1749737845;
 bh=JRVGgZXWt3uLYcx3BpgkLtvAzYk07lvjLQLMKuMxv5I=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=DNrV0vderGl7Y1rWkLCrgQT/tCdPyu6K+P3iopu0cjg8zl+LGjDwKZ/ZVlfIzy1RX
 gFXJbcsdAnbEioIH+ulxFDk+ECBOr96VO1uckHJZpnhB4dBcB3nmNuwVq18J9fAOuS
 cFfHPng3ha7JnlubyneHv3GkW5OkNJWvpzKM3qDg=
From: Andre Muezerie <andremue@linux.microsoft.com>
To: andremue@linux.microsoft.com
Cc: dev@dpdk.org
Subject: [PATCH v3 3/3] drivers: enable drivers to be compiled with MSVC
Date: Thu, 12 Jun 2025 07:17:22 -0700
Message-Id: <1749737842-30538-4-git-send-email-andremue@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1749737842-30538-1-git-send-email-andremue@linux.microsoft.com>
References: <1735243903-26857-1-git-send-email-andremue@linux.microsoft.com>
 <1749737842-30538-1-git-send-email-andremue@linux.microsoft.com>
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
index 7b7205dfac..07ff94ff26 100644
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
2.49.0.vfs.0.3

