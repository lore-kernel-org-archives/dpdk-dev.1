Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4E07C021BB
	for <dpdk-dev@archiver.kernel.org>; Wed, 26 Feb 2025 01:07:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A881F40611;
	Wed, 26 Feb 2025 02:07:09 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 310FB402D6
 for <dev@dpdk.org>; Wed, 26 Feb 2025 02:07:05 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id 43DC9206940D; Tue, 25 Feb 2025 17:07:04 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 43DC9206940D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1740532024;
 bh=xju5xPkUwaOn4UkKQAI1orS7kc1oAWzgeoPXMCDGOcE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=k8+eBjpra9TvjkUdshVo2eqkeQHTVVsa9qU4j79kF0+GwJMqRHJ36zB3xqKzugqyw
 RsS7I/2FDE5nqgadCI85eWQCMWstawqsbllshdKrNYUP1wf1qewrvRbBAf1Fi01xLc
 TFm1yWKDdoh+5whaUpnmBeDhcf7YFSsu4EzVJzf0=
From: Andre Muezerie <andremue@linux.microsoft.com>
To: andremue@linux.microsoft.com
Cc: dev@dpdk.org
Subject: [PATCH v2 3/5] config: create top level variable cc_avx2_flags
Date: Tue, 25 Feb 2025 17:06:54 -0800
Message-Id: <1740532016-6789-4-git-send-email-andremue@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1740532016-6789-1-git-send-email-andremue@linux.microsoft.com>
References: <1740430879-17874-1-git-send-email-andremue@linux.microsoft.com>
 <1740532016-6789-1-git-send-email-andremue@linux.microsoft.com>
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

Top level variable cc_avx2_flags was created and set according to the
compiler used. It is used in lower level directories.

Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
---
 config/x86/meson.build | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/config/x86/meson.build b/config/x86/meson.build
index 47a5b0c04a..941d4d921f 100644
--- a/config/x86/meson.build
+++ b/config/x86/meson.build
@@ -1,6 +1,12 @@
 # SPDX-License-Identifier: BSD-3-Clause
 # Copyright(c) 2017-2020 Intel Corporation
 
+if is_ms_compiler
+    cc_avx2_flags = ['/arch:AVX2']
+else
+    cc_avx2_flags = ['-mavx2']
+endif
+
 # get binutils version for the workaround of Bug 97
 binutils_ok = true
 if is_linux or cc.get_id() == 'gcc'
-- 
2.48.1.vfs.0.0

