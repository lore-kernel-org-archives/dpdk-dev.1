Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7B16CDB479
	for <dpdk-dev@archiver.kernel.org>; Tue, 23 Jun 2026 14:35:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6413840DD2;
	Tue, 23 Jun 2026 16:33:38 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id 197894066E
 for <dev@dpdk.org>; Tue, 23 Jun 2026 16:33:03 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.18.224.150])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4gl6wc3jXGzHnH6J
 for <dev@dpdk.org>; Tue, 23 Jun 2026 22:32:32 +0800 (CST)
Received: from frapema500003.china.huawei.com (unknown [7.182.19.114])
 by mail.maildlp.com (Postfix) with ESMTPS id F01D140574
 for <dev@dpdk.org>; Tue, 23 Jun 2026 22:33:02 +0800 (CST)
Received: from localhost.localdomain (10.220.239.45) by
 frapema500003.china.huawei.com (7.182.19.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 23 Jun 2026 16:33:02 +0200
From: Marat Khalili <marat.khalili@huawei.com>
To: 
CC: <dev@dpdk.org>, Konstantin Ananyev <konstantin.ananyev@huawei.com>
Subject: [PATCH v4 24/24] doc: add release notes for BPF validation fixes
Date: Tue, 23 Jun 2026 15:32:11 +0100
Message-ID: <20260623143215.95318-25-marat.khalili@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260623143215.95318-1-marat.khalili@huawei.com>
References: <20260612104743.6465-1-marat.khalili@huawei.com>
 <20260623143215.95318-1-marat.khalili@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.220.239.45]
X-ClientProxiedBy: frapema500003.china.huawei.com (7.182.19.114) To
 frapema500003.china.huawei.com (7.182.19.114)
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

Document hardening the BPF validator.

Signed-off-by: Marat Khalili <marat.khalili@huawei.com>
Acked-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>
---
 doc/guides/rel_notes/release_26_07.rst | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/doc/guides/rel_notes/release_26_07.rst b/doc/guides/rel_notes/release_26_07.rst
index 8471966a4992..9376e7acad24 100644
--- a/doc/guides/rel_notes/release_26_07.rst
+++ b/doc/guides/rel_notes/release_26_07.rst
@@ -164,7 +164,7 @@ New Features
     for installing already loaded BPF programs as port callbacks
     (as opposed to loading them directly from ELF files).
 
-* **Added BPF validation debugging API.**
+* **Added BPF validation debugging API and hardened BPF validator.**
 
   * Introduced a new set of APIs (prefixed with ``rte_bpf_validate_debug_``) to
     introspect the BPF validator. This provides a mechanism to set breakpoints
@@ -172,6 +172,10 @@ New Features
     (such as tracked register bounds). This API is crucial primarily for writing
     comprehensive tests for the validator, but also serves as a foundation for a
     future interactive eBPF validation debugger.
+  * Fixed numerous bugs in the BPF validator's abstract interpretation logic,
+    including incorrect bounds tracking for jumps and arithmetic operations, as
+    well as fixing several instances of undefined behavior (UB) when verifying
+    malicious or corrupt programs.
 
 * **Added AI review helpers.**
 
-- 
2.43.0

