Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3839AC54ED1
	for <dpdk-dev@archiver.kernel.org>; Thu, 22 May 2025 23:37:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E60EC402E6;
	Fri, 23 May 2025 01:37:05 +0200 (CEST)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 7BB73402D5
 for <dev@dpdk.org>; Fri, 23 May 2025 01:37:04 +0200 (CEST)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id 4935C211CF90; Thu, 22 May 2025 16:37:03 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4935C211CF90
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1747957023;
 bh=V0SuCHigD59ylRf7U5Ugg6O0Jp3oeF3RgtcL5w8+pmg=;
 h=From:To:Cc:Subject:Date:From;
 b=k0a+OcdyTczdMW6HoxVLdXkEUAh/iXjZ0swhQZpfJkC5lwHOBJq0Gd7/zlAckhD1s
 Ehb/qSY+1zbimRGs1M36Zx6egbvvXP7t6w8JQucdw12IwC7b+IZNj7Wtm6NRqO7IAo
 KIsJxle1I1jB5safl2GL8Dh/2ruDsENHpfrwT6Y8=
From: Andre Muezerie <andremue@linux.microsoft.com>
To: 
Cc: dev@dpdk.org,
	Andre Muezerie <andremue@linux.microsoft.com>
Subject: [PATCH] rcu: add deprecation notice about limit on defer queue
 element size
Date: Thu, 22 May 2025 16:37:01 -0700
Message-Id: <1747957021-2581-1-git-send-email-andremue@linux.microsoft.com>
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

The functions rte_rcu_qsbr_dq_create and rte_rcu_qsbr_dq_reclaim establish
no limit on the size of each element in the defer queue. With DPDK 25.11 a
hard limit will be set (``RTE_QSBR_ESIZE_MAX``). This will allow fixed
C arrays to be used in the functions' implementations, avoiding VLAs and
use of alloca().

Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
---
 doc/guides/rel_notes/deprecation.rst | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/doc/guides/rel_notes/deprecation.rst b/doc/guides/rel_notes/deprecation.rst
index 36489f6e68..78b2a27b52 100644
--- a/doc/guides/rel_notes/deprecation.rst
+++ b/doc/guides/rel_notes/deprecation.rst
@@ -17,6 +17,12 @@ Other API and ABI deprecation notices are to be posted below.
 Deprecation Notices
 -------------------
 
+* rcu: The functions ``rte_rcu_qsbr_dq_create`` and ``rte_rcu_qsbr_dq_reclaim``
+  establish no limit on the size of each element in the defer queue. With
+  DPDK 25.11 a hard limit will be set (``RTE_QSBR_ESIZE_MAX``). This will
+  allow fixed C arrays to be used in the functions' implementations,
+  avoiding VLAs and use of alloca().
+
 * build: The ``enable_kmods`` option is deprecated and will be removed in a future release.
   Setting/clearing the option has no impact on the build.
   Instead, kernel modules will be always built for OS's where out-of-tree kernel modules
-- 
2.49.0.vfs.0.3

