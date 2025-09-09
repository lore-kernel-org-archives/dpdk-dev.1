Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBB03CAC583
	for <dpdk-dev@archiver.kernel.org>; Tue,  9 Sep 2025 15:51:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 212E140652;
	Tue,  9 Sep 2025 17:50:55 +0200 (CEST)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id E77C740615
 for <dev@dpdk.org>; Tue,  9 Sep 2025 17:50:51 +0200 (CEST)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id 1955D211AA18; Tue,  9 Sep 2025 08:50:51 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1955D211AA18
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1757433051;
 bh=votPu+7rNVODrrrz1+GnRlS/SQh6+TEg9+fHYh+wFwk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=CUDJUIbWHybT9KkrFNM7RFzTVVf/iBnhrnVHN5Hq7oNp46JLMBDFnEFgsIGluR0QT
 Cq1OOnVjLQ/1DTf3Ah3eYQV8s7HsM76RuWbYlQbWlTY1yQy1aZlntJ8yPBEAokN3UW
 e7UhWuNclSSDcVGUa2PFF2wPLgDxikU2/b5K9jQE=
From: Andre Muezerie <andremue@linux.microsoft.com>
To: andremue@linux.microsoft.com
Cc: dev@dpdk.org
Subject: [PATCH v6 3/3] drivers: enable drivers to be compiled with MSVC
Date: Tue,  9 Sep 2025 08:50:48 -0700
Message-Id: <1757433048-18537-4-git-send-email-andremue@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1757433048-18537-1-git-send-email-andremue@linux.microsoft.com>
References: <1735243903-26857-1-git-send-email-andremue@linux.microsoft.com>
 <1757433048-18537-1-git-send-email-andremue@linux.microsoft.com>
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
index 2760f4d593..f25f425565 100644
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
2.50.1.vfs.0.2

