Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 707C6C636A0
	for <dpdk-dev@archiver.kernel.org>; Sun, 22 Feb 2026 15:31:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A220B40663;
	Sun, 22 Feb 2026 16:30:56 +0100 (CET)
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com
 [95.215.58.172]) by mails.dpdk.org (Postfix) with ESMTP id B955A4060C
 for <dev@dpdk.org>; Sun, 22 Feb 2026 16:30:47 +0100 (CET)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=danielg0.com;
 s=key1; t=1771774247;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Dm7YtWQoVaKQSFnMASIHXE3jzuDaec+eH5QL/hZd6jQ=;
 b=j+37VD8wemX4Y8P/xBBlk2+OYr5tpRk5xPSRXYz5cJMfM5Jni2S32dpx5NhoumidzUp6Tw
 FP/5tfhd2YUKC9bASpKtdZTfoksEJx5y8TJm1Q0D6+I04jMEleQFe5IWRsIpCAkboBei6p
 UA7u77frvHQn6+OOr2tis029ZZLiJAM=
From: Daniel Gregory <code@danielg0.com>
To: =?UTF-8?q?Stanis=C5=82aw=20Kardach?= <stanislaw.kardach@gmail.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 David Hunt <david.hunt@intel.com>,
 Sivaprasad Tummala <sivaprasad.tummala@amd.com>
Cc: Daniel Gregory <daniel.gregory@bytedance.com>, dev@dpdk.org,
 Punit Agrawal <punit.agrawal@bytedance.com>,
 Liang Ma <liangma@liangbit.com>,
 Pengcheng Wang <wangpengcheng.pp@bytedance.com>,
 Chunsong Feng <fengchunsong@bytedance.com>,
 Sun Yuechi <sunyuechi@iscas.ac.cn>
Subject: [PATCH v4 07/10] examples/l3fwd-power: use accelerated CRC on riscv
Date: Sun, 22 Feb 2026 16:30:01 +0100
Message-ID: <5b8ae7aa5839e390471123e5a0b19e211600e5a9.1771772598.git.code@danielg0.com>
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
---
 examples/l3fwd-power/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/examples/l3fwd-power/main.c b/examples/l3fwd-power/main.c
index 02ec17d799..58cd36473e 100644
--- a/examples/l3fwd-power/main.c
+++ b/examples/l3fwd-power/main.c
@@ -273,7 +273,7 @@ static struct rte_mempool * pktmbuf_pool[NB_SOCKETS];
 
 #if (APP_LOOKUP_METHOD == APP_LOOKUP_EXACT_MATCH)
 
-#ifdef RTE_ARCH_X86
+#if defined(RTE_ARCH_X86) || defined(RTE_RISCV_FEATURE_ZBC)
 #include <rte_hash_crc.h>
 #define DEFAULT_HASH_FUNC       rte_hash_crc
 #else
-- 
2.53.0

