Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D393C636A0
	for <dpdk-dev@archiver.kernel.org>; Sun, 22 Feb 2026 15:31:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9A7384066D;
	Sun, 22 Feb 2026 16:31:37 +0100 (CET)
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com
 [95.215.58.172]) by mails.dpdk.org (Postfix) with ESMTP id D56AD4064C
 for <dev@dpdk.org>; Sun, 22 Feb 2026 16:30:53 +0100 (CET)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=danielg0.com;
 s=key1; t=1771774253;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Gwe4Wjx12AEvwgT/qwlB6plTxxvcygRv2t/haIucsAo=;
 b=RoUfjdrncMPZ+BjnerjB4OKqWC10BLGGTTJzUON0HGaAkgwv45BqC+zdGbpnxP2OGe/XXN
 s5HJ8A+oUzNSgpHD5Wxa09bQKeeZv8RfO1qXQBSiBSDAbcCjT1jiBK6afOmTCJ3AZjbrXy
 TjTWPowa6I3xY/u9bP7YC7ngT//yXBc=
From: Daniel Gregory <code@danielg0.com>
To: =?UTF-8?q?Stanis=C5=82aw=20Kardach?= <stanislaw.kardach@gmail.com>,
 Yipeng Wang <yipeng1.wang@intel.com>,
 Sameh Gobriel <sameh.gobriel@intel.com>
Cc: Daniel Gregory <daniel.gregory@bytedance.com>, dev@dpdk.org,
 Punit Agrawal <punit.agrawal@bytedance.com>,
 Liang Ma <liangma@liangbit.com>,
 Pengcheng Wang <wangpengcheng.pp@bytedance.com>,
 Chunsong Feng <fengchunsong@bytedance.com>,
 Sun Yuechi <sunyuechi@iscas.ac.cn>
Subject: [PATCH v4 09/10] member: use accelerated CRC on riscv
Date: Sun, 22 Feb 2026 16:30:03 +0100
Message-ID: <4ad0a26fa5a02032fb3e44c43c68fbc2c4af5775.1771772598.git.code@danielg0.com>
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
 lib/member/member.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/member/member.h b/lib/member/member.h
index 96003f7543..0950709eb6 100644
--- a/lib/member/member.h
+++ b/lib/member/member.h
@@ -12,7 +12,7 @@ extern int librte_member_logtype;
 		"%s(): ", __func__, __VA_ARGS__)
 
 /* Hash function used by membership library. */
-#if defined(RTE_ARCH_X86) || defined(__ARM_FEATURE_CRC32)
+#if defined(RTE_ARCH_X86) || defined(__ARM_FEATURE_CRC32) || defined(RTE_RISCV_FEATURE_ZBC)
 #include <rte_hash_crc.h>
 #define MEMBER_HASH_FUNC       rte_hash_crc
 #else
-- 
2.53.0

