Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35412CD4F52
	for <dpdk-dev@archiver.kernel.org>; Mon, 18 May 2026 08:50:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DDBD340687;
	Mon, 18 May 2026 10:49:46 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id D3D924065F
 for <dev@dpdk.org>; Mon, 18 May 2026 10:49:39 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.18.224.150])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4gJs1D22k7zHnH50
 for <dev@dpdk.org>; Mon, 18 May 2026 16:49:20 +0800 (CST)
Received: from frapema500003.china.huawei.com (unknown [7.182.19.114])
 by mail.maildlp.com (Postfix) with ESMTPS id B87D040571
 for <dev@dpdk.org>; Mon, 18 May 2026 16:49:39 +0800 (CST)
Received: from localhost.localdomain (10.220.239.45) by
 frapema500003.china.huawei.com (7.182.19.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 18 May 2026 10:49:39 +0200
From: Marat Khalili <marat.khalili@huawei.com>
To: 
CC: <dev@dpdk.org>, Konstantin Ananyev <konstantin.ananyev@huawei.com>
Subject: [PATCH v3 09/10] doc: add release notes for new extensible BPF API
Date: Mon, 18 May 2026 09:49:09 +0100
Message-ID: <20260518084912.57006-10-marat.khalili@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260518084912.57006-1-marat.khalili@huawei.com>
References: <20260514093713.90118-1-marat.khalili@huawei.com>
 <20260518084912.57006-1-marat.khalili@huawei.com>
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

Document the following new eBPF features introduced in this release:
* Extensible BPF loading API (rte_bpf_load_ex, rte_bpf_prm_ex).
* Loading and executing eBPF programs with up to 5 arguments.
* Installing already loaded eBPF programs as port callbacks.

Signed-off-by: Marat Khalili <marat.khalili@huawei.com>
Acked-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>
---
 doc/guides/rel_notes/release_26_07.rst | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/doc/guides/rel_notes/release_26_07.rst b/doc/guides/rel_notes/release_26_07.rst
index f012d47a4b..18810ab81d 100644
--- a/doc/guides/rel_notes/release_26_07.rst
+++ b/doc/guides/rel_notes/release_26_07.rst
@@ -63,6 +63,26 @@ New Features
     ``rte_eal_init`` and the application is responsible for probing each device,
   * ``--auto-probing`` enables the initial bus probing, which is the current default behavior.
 
+* **Added extensible BPF loading API.**
+
+  Added an extensible BPF loading API comprising the function
+  ``rte_bpf_load_ex`` and struct ``rte_bpf_prm_ex``. This enables new features
+  such as loading classic BPF (cBPF), loading ELF images directly from memory
+  buffers, and executing multi-argument programs, while avoiding future ABI
+  breakages.
+
+* **Added support for executing BPF programs with multiple arguments.**
+
+  Added support for loading and executing BPF programs with up to 5 arguments.
+  This introduces new API functions ``rte_bpf_exec_ex``,
+  ``rte_bpf_exec_burst_ex``, and ``rte_bpf_get_jit_ex``.
+
+* **Added BPF port callback installation API.**
+
+  Added new API functions ``rte_bpf_eth_rx_install`` and
+  ``rte_bpf_eth_tx_install`` for installing already loaded BPF programs as
+  port callbacks (as opposed to loading them directly from ELF files).
+
 
 Removed Items
 -------------
-- 
2.43.0

