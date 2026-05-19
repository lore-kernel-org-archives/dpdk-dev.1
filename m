Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73AF3CD4F5B
	for <dpdk-dev@archiver.kernel.org>; Tue, 19 May 2026 09:34:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6309B4068E;
	Tue, 19 May 2026 11:32:24 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id 7F42A40696
 for <dev@dpdk.org>; Tue, 19 May 2026 11:32:02 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.18.224.83])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4gKTvJ0W7NzJ46bN
 for <dev@dpdk.org>; Tue, 19 May 2026 17:31:24 +0800 (CST)
Received: from frapema500003.china.huawei.com (unknown [7.182.19.114])
 by mail.maildlp.com (Postfix) with ESMTPS id 61FD740569
 for <dev@dpdk.org>; Tue, 19 May 2026 17:32:02 +0800 (CST)
Received: from localhost.localdomain (10.220.239.45) by
 frapema500003.china.huawei.com (7.182.19.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 19 May 2026 11:32:02 +0200
From: Marat Khalili <marat.khalili@huawei.com>
To: Konstantin Ananyev <konstantin.ananyev@huawei.com>
CC: <dev@dpdk.org>
Subject: [PATCH v2 25/25] doc: add BPF validate debug to programmer's guide
Date: Tue, 19 May 2026 10:31:28 +0100
Message-ID: <20260519093131.52022-26-marat.khalili@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260519093131.52022-1-marat.khalili@huawei.com>
References: <20260506173846.64914-1-marat.khalili@huawei.com>
 <20260519093131.52022-1-marat.khalili@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.220.239.45]
X-ClientProxiedBy: frapema500002.china.huawei.com (7.182.19.148) To
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

Document the new gdb-like validation debugger API, outlining how it can
be used to set breakpoints and inspect register states during
validation.

Highlight its primary use case: writing robust tests for the eBPF
verifier using the harness in app/test/test_bpf_validate.c.

Signed-off-by: Marat Khalili <marat.khalili@huawei.com>
Acked-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>
---
Depends-on: series-38149 ("bpf: introduce extensible load API")
 doc/guides/prog_guide/bpf_lib.rst | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/doc/guides/prog_guide/bpf_lib.rst b/doc/guides/prog_guide/bpf_lib.rst
index df37825088..08ea187687 100644
--- a/doc/guides/prog_guide/bpf_lib.rst
+++ b/doc/guides/prog_guide/bpf_lib.rst
@@ -118,6 +118,37 @@ For example, ``(BPF_IND | BPF_W | BPF_LD)`` means:
 and ``R1-R5`` were scratched.
 
 
+Validation Debugger
+-------------------
+
+The DPDK BPF library includes a validation debugger API designed primarily for
+writing comprehensive unit tests for the eBPF verifier. It allows developers
+to introspect the abstract interpretation process step-by-step to guarantee
+that the verifier correctly models the semantics of eBPF instructions.
+
+The debugger operates using a gdb-like approach:
+
+1.  **Initialization:** Create a debug session using
+    ``rte_bpf_validate_debug_create()`` and pass it to the loader via the
+    ``debug`` field in ``struct rte_bpf_prm_ex``.
+2.  **Breakpoints and Catchpoints:** Before loading, use
+    ``rte_bpf_validate_debug_break()`` or ``rte_bpf_validate_debug_catch()``
+    to register callback functions that trigger at specific instruction indices
+    (program counters) or upon specific validation events.
+3.  **State Introspection:** Within the callbacks, the API provides functions
+    like ``rte_bpf_validate_debug_can_access()``,
+    ``rte_bpf_validate_debug_may_jump()``, and various formatting functions
+    to safely inspect the verifier's internal belief about register bounds
+    and memory states at that specific execution point.
+
+When adding a test for a new eBPF instruction or fixing a validator bug,
+developers should utilize the harness provided in
+``app/test/test_bpf_validate.c``. This harness encapsulates the debugger API,
+allowing you to define the expected abstract domains (signed and unsigned
+intervals) for registers before and after a tested instruction, generating
+the necessary eBPF bytecode and breakpoints automatically.
+
+
 Not currently supported eBPF features
 -------------------------------------
 
-- 
2.43.0

