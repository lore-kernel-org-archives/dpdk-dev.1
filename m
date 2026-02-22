Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CB40C636A0
	for <dpdk-dev@archiver.kernel.org>; Sun, 22 Feb 2026 15:31:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ADB6B40665;
	Sun, 22 Feb 2026 16:31:36 +0100 (CET)
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com
 [95.215.58.183]) by mails.dpdk.org (Postfix) with ESMTP id 82E114064E
 for <dev@dpdk.org>; Sun, 22 Feb 2026 16:30:51 +0100 (CET)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=danielg0.com;
 s=key1; t=1771774251;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0YeVP2eP1IicOR1i/Id4X8iBHQFvAYMFRviFhnt2Aws=;
 b=PWt300AXCPFdreKSXqKVU/lpt7rIfSqUir0CxnNg4lujHbkN7lCm2mY4tVJsTtxi7RFhTZ
 3JGiJU/dcmySWNQRLTtYKYM/LaIAEMQmZlebY9tuqhblmblUtZGYvvqNWDhcfqBSRacHu+
 sZVKgxeviQThvNvi3HuHhEiA4jpM55Y=
From: Daniel Gregory <code@danielg0.com>
To: =?UTF-8?q?Stanis=C5=82aw=20Kardach?= <stanislaw.kardach@gmail.com>,
 Yipeng Wang <yipeng1.wang@intel.com>,
 Sameh Gobriel <sameh.gobriel@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Cc: Daniel Gregory <daniel.gregory@bytedance.com>, dev@dpdk.org,
 Punit Agrawal <punit.agrawal@bytedance.com>,
 Liang Ma <liangma@liangbit.com>,
 Pengcheng Wang <wangpengcheng.pp@bytedance.com>,
 Chunsong Feng <fengchunsong@bytedance.com>,
 Sun Yuechi <sunyuechi@iscas.ac.cn>, Daniel Gregory <code@danielg0.com>
Subject: [PATCH v4 08/10] hash: use accelerated CRC on riscv
Date: Sun, 22 Feb 2026 16:30:02 +0100
Message-ID: <631b9506edd5fa5dfc61f98aae4d5a8fd4d2857d.1771772598.git.code@danielg0.com>
In-Reply-To: <cover.1771772598.git.code@danielg0.com>
References: <20240827153230.52880-1-daniel.gregory@bytedance.com>
 <cover.1771772598.git.code@danielg0.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
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

From: Daniel Gregory <daniel.gregory@bytedance.com>

When the RISC-V Zbc (carryless multiplication) extension is present, an
implementation of CRC hashing using hardware instructions is available.
Use it rather than jhash.

Signed-off-by: Daniel Gregory <daniel.gregory@bytedance.com>
Signed-off-by: Daniel Gregory <code@danielg0.com>
---
 lib/hash/rte_cuckoo_hash.c | 3 +++
 lib/hash/rte_fbk_hash.c    | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/lib/hash/rte_cuckoo_hash.c b/lib/hash/rte_cuckoo_hash.c
index da12825c6e..ce45760b3e 100644
--- a/lib/hash/rte_cuckoo_hash.c
+++ b/lib/hash/rte_cuckoo_hash.c
@@ -460,6 +460,9 @@ rte_hash_create(const struct rte_hash_parameters *params)
 #elif defined(RTE_ARCH_ARM64)
 	if (rte_cpu_get_flag_enabled(RTE_CPUFLAG_CRC32))
 		default_hash_func = (rte_hash_function)rte_hash_crc;
+#elif defined(RTE_ARCH_RISCV)
+	if (rte_cpu_get_flag_enabled(RTE_CPUFLAG_RISCV_EXT_ZBC))
+		default_hash_func = (rte_hash_function)rte_hash_crc;
 #endif
 	/* Setup hash context */
 	strlcpy(h->name, params->name, sizeof(h->name));
diff --git a/lib/hash/rte_fbk_hash.c b/lib/hash/rte_fbk_hash.c
index 45d4a13427..4266bb5198 100644
--- a/lib/hash/rte_fbk_hash.c
+++ b/lib/hash/rte_fbk_hash.c
@@ -148,6 +148,9 @@ rte_fbk_hash_create(const struct rte_fbk_hash_params *params)
 #elif defined(RTE_ARCH_ARM64)
 	if (rte_cpu_get_flag_enabled(RTE_CPUFLAG_CRC32))
 		default_hash_func = (rte_fbk_hash_fn)rte_hash_crc_4byte;
+#elif defined(RTE_ARCH_RISCV)
+	if (rte_cpu_get_flag_enabled(RTE_CPUFLAG_RISCV_EXT_ZBC))
+		default_hash_func = (rte_fbk_hash_fn)rte_hash_crc_4byte;
 #endif
 
 	/* Set up hash table context. */
-- 
2.53.0

