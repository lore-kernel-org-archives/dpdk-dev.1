Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8A53CD3439
	for <dpdk-dev@archiver.kernel.org>; Wed,  6 May 2026 17:39:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B0DD440A79;
	Wed,  6 May 2026 19:39:24 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by mails.dpdk.org (Postfix) with ESMTP id B8C3140658;
 Wed,  6 May 2026 19:39:17 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.18.224.107])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4g9jK73cXqzHnGjR;
 Thu,  7 May 2026 01:38:19 +0800 (CST)
Received: from frapema500003.china.huawei.com (unknown [7.182.19.114])
 by mail.maildlp.com (Postfix) with ESMTPS id 9A2A540584;
 Thu,  7 May 2026 01:39:17 +0800 (CST)
Received: from localhost.localdomain (10.220.239.45) by
 frapema500003.china.huawei.com (7.182.19.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 6 May 2026 19:39:17 +0200
From: Marat Khalili <marat.khalili@huawei.com>
To: Konstantin Ananyev <konstantin.ananyev@huawei.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>
Subject: [PATCH 07/25] bpf/validate: fix BPF_LDX | EBPF_DW signed range
Date: Wed, 6 May 2026 18:38:25 +0100
Message-ID: <20260506173846.64914-8-marat.khalili@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260506173846.64914-1-marat.khalili@huawei.com>
References: <20260506173846.64914-1-marat.khalili@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.220.239.45]
X-ClientProxiedBy: frapema500008.china.huawei.com (7.182.19.65) To
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

Function `eval_max_load` copied signed range from unsigned regardless of
the mask (operation width) producing on 64-bit load nonsensical signed
range 0..-1 that breaks invariant min <= max relied upon in multiple
places (e.g. signed overflow detection in `eval_mul` only checks `s.min`
to make sure the range is non-negative and so on).

E.g. consider the following program with the current validation code:

    Tested program:
        0:  mov r0, #0x0
        1:  mov r3, #0x0
        2:  add r3, r1
        3:  ldxdw r2, [r3 + 16]  ; tested instruction
        4:  mov r0, #0x1
        5:  exit
    Pre-state:
       r2:  %undefined
       r3:  %buffer<24> + 0
    Post-state:
       r2:  0..-1 INTERSECT 0..UINT64_MAX (!)
       r3:  %buffer<24> + 0

Part before INTERSECT represents signed range, part after INTERSECT
represents unsigned range. Unsigned range is correctly set to full range
0..UINT64_MAX, but signed range copied from it becomes 0..-1.

Fix loading logic to only copy unsigned to signed for non-full mask.

The test will be added in subsequent commits since it depends on other
fixes.

Fixes: 8021917293d0 ("bpf: add extra validation for input BPF program")
Cc: stable@dpdk.org

Signed-off-by: Marat Khalili <marat.khalili@huawei.com>
---
 lib/bpf/bpf_validate.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/lib/bpf/bpf_validate.c b/lib/bpf/bpf_validate.c
index 41dca2fb7673..391be9cbb474 100644
--- a/lib/bpf/bpf_validate.c
+++ b/lib/bpf/bpf_validate.c
@@ -1220,10 +1220,11 @@ eval_max_load(struct bpf_reg_val *rv, uint64_t mask)
 	/* full 64-bit load */
 	if (mask == UINT64_MAX)
 		eval_smax_bound(rv, mask);
-
-	/* zero-extend load */
-	rv->s.min = rv->u.min;
-	rv->s.max = rv->u.max;
+	else {
+		/* zero-extend load */
+		rv->s.min = rv->u.min;
+		rv->s.max = rv->u.max;
+	}
 }
 
 
-- 
2.43.0

