Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2620DCD6E79
	for <dpdk-dev@archiver.kernel.org>; Mon,  8 Jun 2026 20:33:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2E4134065B;
	Mon,  8 Jun 2026 22:33:28 +0200 (CEST)
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com
 [74.125.82.173]) by mails.dpdk.org (Postfix) with ESMTP id 305A7402AD
 for <dev@dpdk.org>; Mon,  8 Jun 2026 22:33:27 +0200 (CEST)
Received: by mail-dy1-f173.google.com with SMTP id
 5a478bee46e88-307263ad0cbso6261813eec.0
 for <dev@dpdk.org>; Mon, 08 Jun 2026 13:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1780950806;
 x=1781555606; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZsU7SPYXNGK05yjMjoFgFeuxiinEdEO0vGroxmk03xw=;
 b=sENCzKrNfYItAe6XPJbAtMpzG1f9KFaiOr8DYjVWCjMafV1tl7Jk8eLdPZ8CkCYWL6
 ji7DE41FG09MS71olaMTOWSRsCtMpVQSaPuqsrco/EaV2CNPFdyEsweME4CVdJrjSTMU
 V+j14AnrKyAJN5uvXRj7rXGgxRbw0gF7535EWCRVNKR/O5MZGT65xADluQ3khwRLhrrI
 8L7n9I1vG7Wt61vcaDF2gWwF9gJloC8Di7LMOENPZf/2yXtIhu2PP6K7tK26qor3VAss
 DhTGkrdiuJB6mHTi50/mGxA/rYk3HkgNh/tzq1ln4Go5u7tO+3OHE+65vleSySdxUQJN
 Ipww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780950806; x=1781555606;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZsU7SPYXNGK05yjMjoFgFeuxiinEdEO0vGroxmk03xw=;
 b=RFZjnPcGRngVjKg1H5Oz7H9HyCM4mcFRZBTuTzLVE90LqVxrNcJFGJHzh+dBMeiHyH
 qq0FJFD/cKEBQ+pNtizJIZTTv4Z5gxEQnsUP6o/0kfL+fTcBEf353ahirxdGpIO88agt
 gNLWls/Hw9A3etEmgryJN1rzpB/0qBCKSQLk9GKMIVbXk9R3kZlwzyrWVo0XBp5c3a6W
 IS0sw3xGZs7lZRu6gkPPDH6yNKK4Sk4gQQwZIa/NBspQNC+5i1FOhFWBMqbW3pSgvLYI
 am3mLBd01iaag+H+FACJ8thG4iB5I/uOC35XtU9lLJEcchezBd4kowTX/d1fpqB93b4o
 lFjg==
X-Gm-Message-State: AOJu0YzHR1kWupc5k65SMLaeX8PTSCd5kLqekSliZ58ZSz3sddOzKdzG
 LiMpFHSP2ePEClpsVHDpz8SdCEo94yuE3lC+GrWuIeGm4EKpXOEBzB5ZSA2ASVwvaVuiycQU5Nl
 QkG1n
X-Gm-Gg: Acq92OGtUxHDhccGceUkdWmuCB2MCFXKRhQtrmid3qPu1P2/IxJgmtdXUeXUVIaDSjc
 SVoglxMXsDneeSPbmp1QH8gcYpUZFmIzd7xdkTl/BnKs31WdWE/kXYUVQHvWOzcdDuc7xidHZDr
 e9xf/ANZqLhgQReIczwTmv4PpIuIfW6pL1cqlQAgkQgKsVsxKEWzpRXi8h8uDNck/d6d2jOq8D3
 GTDy9iTveg3pzQ2pIRCK1xFlSDeutvebDu5XCHUb5yVBti4VJ+MZ+O14q6EqcYsREaHlR1kyoLQ
 LirUgNy9v+0aVgnFSXpNflUD1OV89xR+liiof2TrkNbZ9MwGJn/zMIMD65geJfnnvCKCtB4C9bt
 d4koNYwdiuSisAdEH3BX+k/GWPDa9HnLV+Xrzp4KvnvwOrEZq6c8Mv6g/cy2zB9NQkI3640hWUq
 ROBNK2249INj/AosIwdkYNIav7gt6Yi0V4WIbJcWFnlMH4nqQ5Yi6/CAsjsdOHuwBAzw9zQBIg
X-Received: by 2002:a05:7301:5f14:b0:304:4f23:542d with SMTP id
 5a478bee46e88-3077aef8be4mr10068292eec.11.1780950806141; 
 Mon, 08 Jun 2026 13:33:26 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3074db560d7sm25804178eec.5.2026.06.08.13.33.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2026 13:33:25 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Wathsala Vithanage <wathsala.vithanage@arm.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Marat Khalili <marat.khalili@huawei.com>, Jerin Jacob <jerinj@marvell.com>
Subject: [PATCH 1/4] bpf/arm64: fix zero-return branch in multi-exit programs
Date: Mon,  8 Jun 2026 13:28:47 -0700
Message-ID: <20260608203322.1116296-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260608203322.1116296-1-stephen@networkplumber.org>
References: <20260608203322.1116296-1-stephen@networkplumber.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

If a JIT'd BPF program has more than one exit,
the branch to the epilogue can be backwards.

The current code assumed it is always forward:
emit_return_zero_if_src_zero() held the offset in an unsigned uint16_t,
so a backward (negative) offset wrapped to a large positive value and
branch off the end of the program, faulting at run time.

This was masked until now: the only test with this shape, test_ld_mbuf,
needs BPF_ABS/BPF_IND which the arm64 JIT did not implement, so it never
ran under the JIT.  The x86 JIT is unaffected because emit_epilog() keeps a
single exit (st->exit.off) reached from later exits and the divide-by-zero
check via a signed absolute jump (emit_abs_jcc), so direction does not
matter.

Use a signed offset; emit_b() already sign-extends imm26 correctly.

Fixes: 111e2a747a4f ("bpf/arm: add basic arithmetic operations")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/bpf/bpf_jit_arm64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bpf/bpf_jit_arm64.c b/lib/bpf/bpf_jit_arm64.c
index a04ef33a9c..099822e9f1 100644
--- a/lib/bpf/bpf_jit_arm64.c
+++ b/lib/bpf/bpf_jit_arm64.c
@@ -957,7 +957,7 @@ static void
 emit_return_zero_if_src_zero(struct a64_jit_ctx *ctx, bool is64, uint8_t src)
 {
 	uint8_t r0 = ebpf_to_a64_reg(ctx, EBPF_REG_0);
-	uint16_t jump_to_epilogue;
+	int32_t jump_to_epilogue;
 
 	emit_cbnz(ctx, is64, src, 3);
 	emit_mov_imm(ctx, is64, r0, 0);
-- 
2.53.0

