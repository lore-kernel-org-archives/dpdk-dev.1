Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9140C021A4
	for <dpdk-dev@archiver.kernel.org>; Mon, 24 Feb 2025 21:01:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 126D4427CC;
	Mon, 24 Feb 2025 22:01:47 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 006B2427B5
 for <dev@dpdk.org>; Mon, 24 Feb 2025 22:01:42 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id 3317C203CDE3; Mon, 24 Feb 2025 13:01:42 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3317C203CDE3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1740430902;
 bh=D2+Ei274Ev8XsxG+5e7gjCJJEq21UC3hiH6krVwlTnE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=m8zxhZuyl5DE/H1Yd1uBuUb3jbtW9Ls8V++/1grdG+NwaLD4+aZ3EwX8ej8NfCGpU
 6iLgQSBhRd6St1T4CgjewdjAzTeP5p254wjPmkJu1SMG4Zg9tOM6WNfK635a4dNE6c
 jIuQEzVwpbi8aBJ/qBN9UTB5BCf/feFFNmVAwYqk=
From: Andre Muezerie <andremue@linux.microsoft.com>
To: =?UTF-8?q?Mattias=20R=C3=B6nnblom?= <mattias.ronnblom@ericsson.com>,
 Tyler Retzlaff <roretzla@linux.microsoft.com>
Cc: dev@dpdk.org,
	Andre Muezerie <andremue@linux.microsoft.com>
Subject: [PATCH 1/6] eal: make compatible with instruction set updates for MSVC
Date: Mon, 24 Feb 2025 13:01:14 -0800
Message-Id: <1740430879-17874-2-git-send-email-andremue@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1740430879-17874-1-git-send-email-andremue@linux.microsoft.com>
References: <1740430879-17874-1-git-send-email-andremue@linux.microsoft.com>
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

After the instruction set updates for MSVC the error below poped up:

../lib/eal/common/rte_random.c(6): fatal error C1083:
    Cannot open include file: 'x86intrin.h': No such file or directory

The fix is to not include header x86intrin.h with MSVC.

Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
---
 lib/eal/common/rte_random.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/eal/common/rte_random.c b/lib/eal/common/rte_random.c
index 8e62578176..9354358818 100644
--- a/lib/eal/common/rte_random.c
+++ b/lib/eal/common/rte_random.c
@@ -3,8 +3,10 @@
  */
 
 #ifdef __RDSEED__
+#ifndef RTE_TOOLCHAIN_MSVC
 #include <x86intrin.h>
 #endif
+#endif
 #include <unistd.h>
 
 #include <rte_bitops.h>
-- 
2.48.1.vfs.0.0

