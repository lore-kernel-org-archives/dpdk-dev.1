Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DA03C636A0
	for <dpdk-dev@archiver.kernel.org>; Sun, 22 Feb 2026 15:31:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A84494065A;
	Sun, 22 Feb 2026 16:30:54 +0100 (CET)
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com
 [95.215.58.178]) by mails.dpdk.org (Postfix) with ESMTP id C1963402EF
 for <dev@dpdk.org>; Sun, 22 Feb 2026 16:30:43 +0100 (CET)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=danielg0.com;
 s=key1; t=1771774243;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9xCVOBzAGCzkXds/UBVHwQqynAYzGDbChwzRajFiOAY=;
 b=AtY3yoA7Ygv0f9ln8jb04oykbsKDMIBSzWMZoetD6ND90D/UJb7ypLSGz728TysbwrEP1K
 Z+Fe5pWC5kgL8qcHXWqE05MzqgAAD7/d6rL8ZZg0wyCXfWzGU+DY8sCeCmSiWXUamz0NUc
 TMiMAhVsNIAppjR5NYXgaz4SOiDX1OE=
From: Daniel Gregory <code@danielg0.com>
To: =?UTF-8?q?Stanis=C5=82aw=20Kardach?= <stanislaw.kardach@gmail.com>
Cc: Daniel Gregory <daniel.gregory@bytedance.com>, dev@dpdk.org,
 Punit Agrawal <punit.agrawal@bytedance.com>,
 Liang Ma <liangma@liangbit.com>,
 Pengcheng Wang <wangpengcheng.pp@bytedance.com>,
 Chunsong Feng <fengchunsong@bytedance.com>,
 Sun Yuechi <sunyuechi@iscas.ac.cn>
Subject: [PATCH v4 05/10] examples/l3fwd: use accelerated CRC on riscv
Date: Sun, 22 Feb 2026 16:29:59 +0100
Message-ID: <44937a842ce1151d697581d0651c05315ac884e8.1771772598.git.code@danielg0.com>
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
 examples/l3fwd/l3fwd_em.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/examples/l3fwd/l3fwd_em.c b/examples/l3fwd/l3fwd_em.c
index 58c54ed77e..6965421f47 100644
--- a/examples/l3fwd/l3fwd_em.c
+++ b/examples/l3fwd/l3fwd_em.c
@@ -29,7 +29,7 @@
 #include "l3fwd_event.h"
 #include "em_route_parse.c"
 
-#if defined(RTE_ARCH_X86) || defined(__ARM_FEATURE_CRC32)
+#if defined(RTE_ARCH_X86) || defined(__ARM_FEATURE_CRC32) || defined(RTE_RISCV_FEATURE_ZBC)
 #define EM_HASH_CRC 1
 #endif
 
-- 
2.53.0

