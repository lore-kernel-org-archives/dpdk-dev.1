Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B00BC282E5
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Mar 2025 16:38:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8830B40613;
	Wed,  5 Mar 2025 17:38:20 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 7731C40275
 for <dev@dpdk.org>; Wed,  5 Mar 2025 17:38:18 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id B6ECA210EAE7; Wed,  5 Mar 2025 08:38:17 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B6ECA210EAE7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1741192697;
 bh=s1CUZwX/O0d8hiKj9MhNWsCGAYBY0/LoubP5yrfGnTQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=F1aZVpGRmyXGQzFb6RnncZFfcyMoyfI8WIifSVlW+SWyUjOuREFcxT/tTaYaJ29nO
 z1a4pMMxy7kGt7L0yYwbWXB57MVmebmm+AOnfZpKY5eC8XdLQXSOHzWEC2uHC98R3N
 N37To2li3Edlsjg+92wCJ8ibBi4L7dpJNlbZxwZk=
From: Andre Muezerie <andremue@linux.microsoft.com>
To: andremue@linux.microsoft.com
Cc: dev@dpdk.org,
	mb@smartsharesystems.com
Subject: [PATCH v3 3/5] doc/api: add portable version of __builtin_add_overflow
Date: Wed,  5 Mar 2025 08:38:08 -0800
Message-Id: <1741192690-26243-4-git-send-email-andremue@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1741192690-26243-1-git-send-email-andremue@linux.microsoft.com>
References: <1735857169-19131-1-git-send-email-andremue@linux.microsoft.com>
 <1741192690-26243-1-git-send-email-andremue@linux.microsoft.com>
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

__builtin_add_overflow is gcc specific. There's a need for a portable
version that can also be used with other compilers.

Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
---
 doc/api/doxy-api-index.md | 1 +
 1 file changed, 1 insertion(+)

diff --git a/doc/api/doxy-api-index.md b/doc/api/doxy-api-index.md
index b2fc24b3e4..48922054ed 100644
--- a/doc/api/doxy-api-index.md
+++ b/doc/api/doxy-api-index.md
@@ -227,6 +227,7 @@ The public API headers are grouped by topics:
   [checksum](@ref rte_cksum.h),
   [config file](@ref rte_cfgfile.h),
   [key/value args](@ref rte_kvargs.h),
+  [math](@ref rte_math.h),
   [argument parsing](@ref rte_argparse.h),
   [ptr_compress](@ref rte_ptr_compress.h),
   [string](@ref rte_string_fns.h),
-- 
2.48.1.vfs.0.0

