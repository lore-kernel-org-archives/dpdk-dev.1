Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 269D9C636A0
	for <dpdk-dev@archiver.kernel.org>; Sun, 22 Feb 2026 15:31:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AE4A24065D;
	Sun, 22 Feb 2026 16:30:55 +0100 (CET)
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com
 [95.215.58.183]) by mails.dpdk.org (Postfix) with ESMTP id A1C004042F
 for <dev@dpdk.org>; Sun, 22 Feb 2026 16:30:45 +0100 (CET)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=danielg0.com;
 s=key1; t=1771774245;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FsOfGOAa8JnOGcmzN+peeU/pvasPoSMs0KsV5ACnTGI=;
 b=IDvf55OR9948QljHQ7q3KGjMdwAayXKYtmz5pj9vPEjC0md5Mg1kd1TqleH1/geZkFw0PV
 MDo+4Q+h1ENlO386o9e8zutj13UMDvgcJVSXzwIRw+DCaKqVP4+1699eQOTAPPwE3U79qz
 mP+z4jV3UuQuCll/Bl/rpuqU0CctDGQ=
From: Daniel Gregory <code@danielg0.com>
To: =?UTF-8?q?Stanis=C5=82aw=20Kardach?= <stanislaw.kardach@gmail.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>
Cc: Daniel Gregory <daniel.gregory@bytedance.com>, dev@dpdk.org,
 Punit Agrawal <punit.agrawal@bytedance.com>,
 Liang Ma <liangma@liangbit.com>,
 Pengcheng Wang <wangpengcheng.pp@bytedance.com>,
 Chunsong Feng <fengchunsong@bytedance.com>,
 Sun Yuechi <sunyuechi@iscas.ac.cn>
Subject: [PATCH v4 06/10] ipfrag: use accelerated CRC on riscv
Date: Sun, 22 Feb 2026 16:30:00 +0100
Message-ID: <4508943b3cbdd6fdae7867693c58a2c78de7a758.1771772598.git.code@danielg0.com>
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
 lib/ip_frag/ip_frag_internal.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/ip_frag/ip_frag_internal.c b/lib/ip_frag/ip_frag_internal.c
index 7cbef647df..19a28c447b 100644
--- a/lib/ip_frag/ip_frag_internal.c
+++ b/lib/ip_frag/ip_frag_internal.c
@@ -45,14 +45,14 @@ ipv4_frag_hash(const struct ip_frag_key *key, uint32_t *v1, uint32_t *v2)
 
 	p = (const uint32_t *)&key->src_dst;
 
-#if defined(RTE_ARCH_X86) || defined(RTE_ARCH_ARM64)
+#if defined(RTE_ARCH_X86) || defined(RTE_ARCH_ARM64) || defined(RTE_RISCV_FEATURE_ZBC)
 	v = rte_hash_crc_4byte(p[0], PRIME_VALUE);
 	v = rte_hash_crc_4byte(p[1], v);
 	v = rte_hash_crc_4byte(key->id, v);
 #else
 
 	v = rte_jhash_3words(p[0], p[1], key->id, PRIME_VALUE);
-#endif /* RTE_ARCH_X86 */
+#endif /* RTE_ARCH_X86 || RTE_ARCH_ARM64 || RTE_RISCV_FEATURE_ZBC */
 
 	*v1 =  v;
 	*v2 = (v << 7) + (v >> 14);
@@ -66,7 +66,7 @@ ipv6_frag_hash(const struct ip_frag_key *key, uint32_t *v1, uint32_t *v2)
 
 	p = (const uint32_t *) &key->src_dst;
 
-#if defined(RTE_ARCH_X86) || defined(RTE_ARCH_ARM64)
+#if defined(RTE_ARCH_X86) || defined(RTE_ARCH_ARM64) || defined(RTE_RISCV_FEATURE_ZBC)
 	v = rte_hash_crc_4byte(p[0], PRIME_VALUE);
 	v = rte_hash_crc_4byte(p[1], v);
 	v = rte_hash_crc_4byte(p[2], v);
-- 
2.53.0

