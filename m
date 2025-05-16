Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3285DC3ABD8
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 May 2025 20:45:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6548640668;
	Fri, 16 May 2025 22:45:46 +0200 (CEST)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id C117D40648
 for <dev@dpdk.org>; Fri, 16 May 2025 22:45:42 +0200 (CEST)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id A9A8D201DB36; Fri, 16 May 2025 13:45:41 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A9A8D201DB36
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1747428341;
 bh=uUYre0UyHb4E0xBPoE2MR088RLAQE9HeNqVQJ0BDId8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=WqgL2zpoEMz7yHzLh++EpV3BvvSIWZ1NBcN7rrxI6scWbw8NvApa6p4WkSRX4tfiC
 PFhVfhnv6Y3Ltm+h2zTvBTQlzHn2m43GKfTMlgV5r3IVwN5dNrthHSS/j8kITlGVHX
 vXR7Ua3K19tDnRr7z7kI9akBbLIF7yyjYN6z77Bk=
From: Andre Muezerie <andremue@linux.microsoft.com>
To: andremue@linux.microsoft.com
Cc: dev@dpdk.org,
	vladimir.medvedkin@intel.com
Subject: [PATCH v5 2/2] lib/fib: enable fib to be compiled with MSVC
Date: Fri, 16 May 2025 13:45:35 -0700
Message-Id: <1747428335-3736-3-git-send-email-andremue@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1747428335-3736-1-git-send-email-andremue@linux.microsoft.com>
References: <1733281010-23780-1-git-send-email-andremue@linux.microsoft.com>
 <1747428335-3736-1-git-send-email-andremue@linux.microsoft.com>
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

Now that all issues related to fib are addressed it can be enabled
for MSVC.

Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
---
 lib/fib/meson.build | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/lib/fib/meson.build b/lib/fib/meson.build
index da82e017a9..6992ccc040 100644
--- a/lib/fib/meson.build
+++ b/lib/fib/meson.build
@@ -2,12 +2,6 @@
 # Copyright(c) 2018 Vladimir Medvedkin <medvedkinv@gmail.com>
 # Copyright(c) 2019 Intel Corporation
 
-if is_ms_compiler
-    build = false
-    reason = 'not supported building with Visual Studio Toolset'
-    subdir_done()
-endif
-
 sources = files('rte_fib.c', 'rte_fib6.c', 'dir24_8.c', 'trie.c')
 headers = files('rte_fib.h', 'rte_fib6.h')
 deps += ['rib']
-- 
2.49.0.vfs.0.3

