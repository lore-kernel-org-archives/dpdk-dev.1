Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E32ABCD98CE
	for <dpdk-dev@archiver.kernel.org>; Fri, 12 Jun 2026 10:50:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 186A14356B;
	Fri, 12 Jun 2026 12:48:36 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id E265F434E1
 for <dev@dpdk.org>; Fri, 12 Jun 2026 12:48:17 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.18.224.107])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4gcGSd15RszJ468F
 for <dev@dpdk.org>; Fri, 12 Jun 2026 18:48:01 +0800 (CST)
Received: from frapema500003.china.huawei.com (unknown [7.182.19.114])
 by mail.maildlp.com (Postfix) with ESMTPS id C61DD4058D
 for <dev@dpdk.org>; Fri, 12 Jun 2026 18:48:17 +0800 (CST)
Received: from localhost.localdomain (10.220.239.45) by
 frapema500003.china.huawei.com (7.182.19.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 12 Jun 2026 12:48:17 +0200
From: Marat Khalili <marat.khalili@huawei.com>
To: 
CC: <dev@dpdk.org>, Konstantin Ananyev <konstantin.ananyev@huawei.com>
Subject: [PATCH v3 24/25] doc: add release notes for BPF validation fixes
Date: Fri, 12 Jun 2026 11:47:38 +0100
Message-ID: <20260612104743.6465-25-marat.khalili@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260612104743.6465-1-marat.khalili@huawei.com>
References: <20260519093131.52022-1-marat.khalili@huawei.com>
 <20260612104743.6465-1-marat.khalili@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.220.239.45]
X-ClientProxiedBy: frapema100001.china.huawei.com (7.182.19.23) To
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

Document the following new features and fixes:
* Added BPF validation debugger API (rte_bpf_validate_debug_*).
* Hardened BPF validator with numerous bug fixes and UB preventions.

Signed-off-by: Marat Khalili <marat.khalili@huawei.com>
Acked-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>
---
Depends-on: series-38434 ("bpf: introduce extensible load API")
 doc/guides/rel_notes/release_26_07.rst | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/doc/guides/rel_notes/release_26_07.rst b/doc/guides/rel_notes/release_26_07.rst
index 3a151c8e83bb..d98e73b8340f 100644
--- a/doc/guides/rel_notes/release_26_07.rst
+++ b/doc/guides/rel_notes/release_26_07.rst
@@ -175,6 +175,22 @@ New Features
   ``rte_bpf_eth_tx_install`` for installing already loaded BPF programs as
   port callbacks (as opposed to loading them directly from ELF files).
 
+* **Hardened BPF validator.**
+
+  Fixed numerous bugs in the BPF validator's abstract interpretation logic,
+  including incorrect bounds tracking for jumps and arithmetic operations, as
+  well as fixing several instances of undefined behavior (UB) when verifying
+  malicious or corrupt programs.
+
+* **Added BPF validation debugger API.**
+
+  Introduced a new set of APIs (prefixed with ``rte_bpf_validate_debug_``) to
+  introspect the BPF validator. This provides a mechanism to set breakpoints or
+  catchpoints during validation and inspect the verifier's internal state
+  (such as tracked register bounds). This API is crucial primarily for writing
+  comprehensive tests for the validator, but also serves as a foundation for a
+  future interactive eBPF validation debugger.
+
 
 Removed Items
 -------------
-- 
2.43.0

