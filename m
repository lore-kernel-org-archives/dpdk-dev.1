Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03338CD342C
	for <dpdk-dev@archiver.kernel.org>; Wed,  6 May 2026 17:39:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8A6DF40A6B;
	Wed,  6 May 2026 19:39:23 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by mails.dpdk.org (Postfix) with ESMTP id 5DE9940666;
 Wed,  6 May 2026 19:39:17 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.18.224.83])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4g9jK70yVMzHnGjs;
 Thu,  7 May 2026 01:38:19 +0800 (CST)
Received: from frapema500003.china.huawei.com (unknown [7.182.19.114])
 by mail.maildlp.com (Postfix) with ESMTPS id 3EDAC40569;
 Thu,  7 May 2026 01:39:17 +0800 (CST)
Received: from localhost.localdomain (10.220.239.45) by
 frapema500003.china.huawei.com (7.182.19.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 6 May 2026 19:39:16 +0200
From: Marat Khalili <marat.khalili@huawei.com>
To: Konstantin Ananyev <konstantin.ananyev@huawei.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>
Subject: [PATCH 06/25] bpf/validate: fix BPF_ADD of pointer to a scalar
Date: Wed, 6 May 2026 18:38:24 +0100
Message-ID: <20260506173846.64914-7-marat.khalili@huawei.com>
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

Function `eval_add` preserved type of the destination register even when
a pointer was added to it. If it contained scalar, it remained a scalar,
and if it contained pointer, it remained a pointer.

E.g. consider the following program with the current validation code:

    Tested program:
        0:  mov r0, #0x0
        1:  mov r3, #0x0
        2:  add r3, r1  ; tested instruction
        3:  ldxdw r2, [r3 + 16]
        4:  mov r0, #0x1
        5:  exit

After the tested instruction validator considers r3 to be scalar and
fails validation with the error:

    BPF: evaluate(): destination is not a pointer at pc: 3

However, this code is valid as long as program argument points to a
valid memory area at least 24 bytes long which we read at offset 16.

When adding pointer to a scalar set type of the result to pointer of
the same type. When adding pointer to a pointer set type of the result
to scalar and value to unknown.

The test will be added in subsequent commits since it depends on other
fixes.

Fixes: 8021917293d0 ("bpf: add extra validation for input BPF program")
Cc: stable@dpdk.org

Signed-off-by: Marat Khalili <marat.khalili@huawei.com>
---
 lib/bpf/bpf_validate.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/lib/bpf/bpf_validate.c b/lib/bpf/bpf_validate.c
index 8dac908c394f..41dca2fb7673 100644
--- a/lib/bpf/bpf_validate.c
+++ b/lib/bpf/bpf_validate.c
@@ -647,8 +647,20 @@ eval_apply_mask(struct bpf_reg_val *rv, uint64_t mask)
 static void
 eval_add(struct bpf_reg_val *rd, const struct bpf_reg_val *rs, uint64_t msk)
 {
+	struct bpf_reg_val rs_buf;
 	struct bpf_reg_val rv;
 
+	if (RTE_BPF_ARG_PTR_TYPE(rs->v.type) != 0) {
+		if (RTE_BPF_ARG_PTR_TYPE(rd->v.type) != 0) {
+			/* treat sum of pointers as sum of two unknown scalars */
+			eval_fill_max_bound(&rs_buf, msk);
+			*rd = rs_buf;
+			rs = &rs_buf;
+		} else
+			/* scalar + pointer is a pointer of the same type */
+			rd->v = rs->v;
+	}
+
 	rv.u.min = (rd->u.min + rs->u.min) & msk;
 	rv.u.max = (rd->u.max + rs->u.max) & msk;
 	rv.s.min = ((uint64_t)rd->s.min + (uint64_t)rs->s.min) & msk;
-- 
2.43.0

