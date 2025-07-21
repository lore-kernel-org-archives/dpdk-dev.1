Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 338A0C83F1A
	for <dpdk-dev@archiver.kernel.org>; Mon, 21 Jul 2025 15:25:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C93BC40696;
	Mon, 21 Jul 2025 17:24:56 +0200 (CEST)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 35F5C40669
 for <dev@dpdk.org>; Mon, 21 Jul 2025 17:24:53 +0200 (CEST)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id 654F92116DDA; Mon, 21 Jul 2025 08:24:52 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 654F92116DDA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1753111492;
 bh=96AsHZxwA1eTjvmLeNC+b6h9wod9UECV16RGJXlvINs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=qrnfE5Ee3LU2aJKyHJRHkqWuk1vWZW0VyF/FhupkgRkF85/tGBP9J5DyFmFcFvJr9
 z1s3JtpxGPxHLxBei62e3alFdwORT/H0UZm7kjvkyGr70weSoYAh7Ujc2nyOsAnyUL
 b9YxupsLBk8Vqrjuy6DLbEaTnzVQ/Q4YEVaNDwvk=
From: Andre Muezerie <andremue@linux.microsoft.com>
To: andremue@linux.microsoft.com
Cc: dev@dpdk.org
Subject: [PATCH v4 3/3] drivers: enable drivers to be compiled with MSVC
Date: Mon, 21 Jul 2025 08:24:44 -0700
Message-Id: <1753111484-27021-4-git-send-email-andremue@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1753111484-27021-1-git-send-email-andremue@linux.microsoft.com>
References: <1735243903-26857-1-git-send-email-andremue@linux.microsoft.com>
 <1753111484-27021-1-git-send-email-andremue@linux.microsoft.com>
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
2.50.1.vfs.0.0

