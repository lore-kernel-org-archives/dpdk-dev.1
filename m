Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A90FCD3439
	for <dpdk-dev@archiver.kernel.org>; Wed,  6 May 2026 17:23:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9B1B240A89;
	Wed,  6 May 2026 19:23:01 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id B8D2E40674
 for <dev@dpdk.org>; Wed,  6 May 2026 19:22:52 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.18.224.150])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4g9hyz1KQqzJ467m
 for <dev@dpdk.org>; Thu,  7 May 2026 01:22:35 +0800 (CST)
Received: from frapema500003.china.huawei.com (unknown [7.182.19.114])
 by mail.maildlp.com (Postfix) with ESMTPS id 992D940570
 for <dev@dpdk.org>; Thu,  7 May 2026 01:22:52 +0800 (CST)
Received: from localhost.localdomain (10.220.239.45) by
 frapema500003.china.huawei.com (7.182.19.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 6 May 2026 19:22:52 +0200
From: Marat Khalili <marat.khalili@huawei.com>
To: Konstantin Ananyev <konstantin.ananyev@huawei.com>
CC: <dev@dpdk.org>
Subject: [PATCH 10/10] doc: add load API to BPF programmer's guide
Date: Wed, 6 May 2026 18:22:07 +0100
Message-ID: <20260506172209.6805-11-marat.khalili@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260506172209.6805-1-marat.khalili@huawei.com>
References: <20260506172209.6805-1-marat.khalili@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.220.239.45]
X-ClientProxiedBy: frapema500001.china.huawei.com (7.182.19.243) To
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

Rewrite the basic operations list to focus on a typical use. Provide an
end-to-end example demonstrating loading from an ELF file, executing via
JIT or the interpreter, and properly handling multiple custom arguments
using rte_bpf_prog_ctx.

Signed-off-by: Marat Khalili <marat.khalili@huawei.com>
---
 doc/guides/prog_guide/bpf_lib.rst | 75 ++++++++++++++++++++++++++++---
 1 file changed, 68 insertions(+), 7 deletions(-)

diff --git a/doc/guides/prog_guide/bpf_lib.rst b/doc/guides/prog_guide/bpf_lib.rst
index 8c820328b984..df3782508829 100644
--- a/doc/guides/prog_guide/bpf_lib.rst
+++ b/doc/guides/prog_guide/bpf_lib.rst
@@ -15,17 +15,79 @@ for more information.
 Also it introduces basic framework to load/unload BPF-based filters
 on eth devices (right now only via SW RX/TX callbacks).
 
-The library API provides the following basic operations:
+The library API provides the following basic operations for working with BPF
+programs:
 
-*  Create a new BPF execution context and load user provided eBPF code into it.
+*   **Loading:** The extensible API (``rte_bpf_load_ex``) is the recommended
+    way to load a BPF program. By utilizing ``struct rte_bpf_prm_ex``, you can
+    load an eBPF program from an ELF file on disk, or load eBPF/cBPF bytecode
+    directly from memory buffers.
 
-*   Destroy an BPF execution context and its runtime structures and free the associated memory.
+*   **Execution via Callbacks:** Once loaded, a BPF program can be attached to
+    a specific ethernet device port and queue to automatically process incoming
+    or outgoing packets using ``rte_bpf_eth_rx_install`` or
+    ``rte_bpf_eth_tx_install``.
 
-*   Execute eBPF bytecode associated with provided input parameter.
+*   **Direct Execution:** You can execute a BPF program directly from your
+    application code using ``rte_bpf_exec_ex`` (or the burst variant
+    ``rte_bpf_exec_burst_ex``). This API allows passing an execution context
+    (``struct rte_bpf_prog_ctx``) containing up to 5 custom arguments.
 
-*   Provide information about natively compiled code for given BPF context.
+*   **JIT Execution:** For maximum performance, you can retrieve the natively
+    compiled (JIT) function pointer for a loaded program using
+    ``rte_bpf_get_jit_ex`` and call it directly from your code with the same
+    arguments.
 
-*   Load BPF program from the ELF file and install callback to execute it on given ethdev port/queue.
+*   **Cleanup:** Destroy a BPF execution context and free the associated memory
+    using ``rte_bpf_destroy``.
+
+The following is a concise example of loading an eBPF program from an ELF file,
+and executing it directly, utilizing the JIT-compiled version if available:
+
+.. code-block:: c
+
+    struct rte_bpf_prm_ex prm = {
+        .sz = sizeof(struct rte_bpf_prm_ex),
+        .origin = RTE_BPF_ORIGIN_ELF_FILE,
+        .elf_file = {
+            .path = "ptype.o",
+            .section = ".text",
+        },
+        .nb_prog_arg = 2,
+        .prog_arg = {
+            [0] = {
+                .type = RTE_BPF_ARG_PTR_MBUF,
+                .size = sizeof(struct rte_mbuf),
+                .buf_size = RTE_MBUF_DEFAULT_BUF_SIZE,
+            },
+            [1] = {
+                .type = RTE_BPF_ARG_RAW,
+                .size = sizeof(uint64_t),
+            },
+        },
+    };
+    struct rte_bpf *bpf = rte_bpf_load_ex(&prm);
+    if (bpf == NULL) {
+        /* Handle load failure */
+    }
+
+    struct rte_bpf_prog_ctx ctx = {
+        .arg[0] = { .ptr = mbuf },
+        .arg[1] = { .u64 = RTE_PTYPE_L2_MASK | RTE_PTYPE_L3_MASK },
+    };
+
+    struct rte_bpf_jit_ex jit;
+    uint64_t ret;
+    if (rte_bpf_get_jit_ex(bpf, &jit) == 0 && jit.func2 != NULL) {
+        /* Call the JIT-compiled function directly for best performance */
+        ret = jit.func2(ctx.arg[0], ctx.arg[1]);
+    } else {
+        /* Fallback to interpreter */
+        uint64_t flags = 0;
+        ret = rte_bpf_exec_ex(bpf, &ctx, flags);
+    }
+
+    rte_bpf_destroy(bpf);
 
 Packet data load instructions
 -----------------------------
@@ -60,7 +122,6 @@ Not currently supported eBPF features
 -------------------------------------
 
  - JIT support only available for X86_64 and arm64 platforms
- - cBPF
  - tail-pointer call
  - eBPF MAP
  - external function calls for 32-bit platforms
-- 
2.43.0

