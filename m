Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FB86C021AA
	for <dpdk-dev@archiver.kernel.org>; Wed, 19 Feb 2025 01:40:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DB3ED40A79;
	Wed, 19 Feb 2025 02:40:11 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 65A794025A
 for <dev@dpdk.org>; Wed, 19 Feb 2025 02:40:08 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id 5FABA20376EE; Tue, 18 Feb 2025 17:40:07 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5FABA20376EE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1739929207;
 bh=qRjjU6VA7xE2EPdFQDIwYi/ZGMgkOIoQ+DRie4YnGjM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=GFBZKel8pqY26YkVWyy4BZv4dvW211huxSduPqs0ub1Egnbq0zAE/cG0wqbPF/kVb
 DcSxJLFGKAwq/jFFPGldlSWVPbxy40TIjeAbjOZFMTrhEZWtVlTgRXj1MsbftYr/3r
 hGkzKE+el/mIBwZgZa3aAAzUeftVBlJHoTMVQ8fc=
From: Andre Muezerie <andremue@linux.microsoft.com>
To: andremue@linux.microsoft.com
Cc: dev@dpdk.org
Subject: [PATCH v2 1/5] doc: update guide on versioning macros
Date: Tue, 18 Feb 2025 17:39:54 -0800
Message-Id: <1739929198-28432-2-git-send-email-andremue@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1739929198-28432-1-git-send-email-andremue@linux.microsoft.com>
References: <1739224265-4158-1-git-send-email-andremue@linux.microsoft.com>
 <1739929198-28432-1-git-send-email-andremue@linux.microsoft.com>
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

Added explanation about new macro MAP_STATIC_BASE_SYMBOL.

Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
---
 doc/guides/contributing/abi_versioning.rst | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/doc/guides/contributing/abi_versioning.rst b/doc/guides/contributing/abi_versioning.rst
index 7afd1c1886..1179445da3 100644
--- a/doc/guides/contributing/abi_versioning.rst
+++ b/doc/guides/contributing/abi_versioning.rst
@@ -151,6 +151,11 @@ The macros exported are:
   fully qualified function ``p``, so that if a symbol becomes versioned, it
   can still be mapped back to the public symbol name.
 
+* ``MAP_STATIC_BASE_SYMBOL(b, p)``: Declare the base symbol ``b``, and map it
+  to the fully qualified function ``p``, so that if a symbol becomes versioned,
+  it can still be mapped back to the public symbol name. Used for compatibility
+  with MSVC.
+
 * ``__vsym``:  Annotation to be used in a declaration of the internal symbol
   ``be`` to signal that it is being used as an implementation of a particular
   version of symbol ``b``.
@@ -397,6 +402,7 @@ defined, we add this
         ...
    }
    MAP_STATIC_SYMBOL(struct rte_acl_ctx *rte_acl_create(const struct rte_acl_param *param, int debug), rte_acl_create_v22);
+   MAP_STATIC_BASE_SYMBOL(rte_acl_create, rte_acl_create_v22);
 
 That tells the compiler that, when building a static library, any calls to the
 symbol ``rte_acl_create`` should be linked to ``rte_acl_create_v22``
-- 
2.48.1.vfs.0.0

