Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A969FCD98E2
	for <dpdk-dev@archiver.kernel.org>; Wed, 17 Jun 2026 19:46:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D81DD40DDD;
	Wed, 17 Jun 2026 21:46:02 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id 2D0504066D
 for <dev@dpdk.org>; Wed, 17 Jun 2026 21:45:56 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.18.224.83])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4ggZ8T6dZKzJ467W
 for <dev@dpdk.org>; Thu, 18 Jun 2026 03:45:29 +0800 (CST)
Received: from frapema500003.china.huawei.com (unknown [7.182.19.114])
 by mail.maildlp.com (Postfix) with ESMTPS id 6F41A40575
 for <dev@dpdk.org>; Thu, 18 Jun 2026 03:45:55 +0800 (CST)
Received: from localhost.localdomain (10.220.239.45) by
 frapema500003.china.huawei.com (7.182.19.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 17 Jun 2026 21:45:55 +0200
From: Marat Khalili <marat.khalili@huawei.com>
To: 
CC: <dev@dpdk.org>, Konstantin Ananyev <konstantin.ananyev@huawei.com>
Subject: [PATCH v6 09/11] doc: add release notes for new extensible BPF API
Date: Wed, 17 Jun 2026 20:44:21 +0100
Message-ID: <20260617194425.12690-10-marat.khalili@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260617194425.12690-1-marat.khalili@huawei.com>
References: <20260612084219.38399-1-marat.khalili@huawei.com>
 <20260617194425.12690-1-marat.khalili@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.220.239.45]
X-ClientProxiedBy: frapema100003.china.huawei.com (7.182.19.100) To
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
index 5d7aa8d1bff5..3a151c8e83bb 100644
--- a/doc/guides/rel_notes/release_26_07.rst
+++ b/doc/guides/rel_notes/release_26_07.rst
@@ -155,6 +155,26 @@ New Features
   Added AGENTS.md file for AI review
   and supporting scripts to review patches and documentation.
 
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

