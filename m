Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E29D6CD98F2
	for <dpdk-dev@archiver.kernel.org>; Thu, 18 Jun 2026 21:00:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 216D040613;
	Thu, 18 Jun 2026 23:00:36 +0200 (CEST)
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com
 [74.125.82.177]) by mails.dpdk.org (Postfix) with ESMTP id 029564028C
 for <dev@dpdk.org>; Thu, 18 Jun 2026 23:00:32 +0200 (CEST)
Received: by mail-dy1-f177.google.com with SMTP id
 5a478bee46e88-30bf8b2bd20so1903382eec.0
 for <dev@dpdk.org>; Thu, 18 Jun 2026 14:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1781816432;
 x=1782421232; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E3EmkC3Hc98n7MeOQI3axdLDM6TN5jua/tnyuzXpkN0=;
 b=ddjyHXvuABgI5Klmx/Lgx2hz3j1YIDpEE1R4RXvRLJ3K7Ap/iIDwt/SVE1GSO1ZzCR
 fb4rkNLRExQLbApK8Lh/9JvejsQi9BmB6+9wOg3xKzjUC4FkIsNRJNcMWG+tCbIjWr5S
 OsaRyQVxpUnsVekQI9Xx68iqY78gHvRkY1eqOtaw6iFxCK8dPLqhn5sH5f32IF4JSwHG
 PdKpBolS784e3Rn7tUTppLGBDZi+BjpUGWkT3UzMrpDIIjPg8MgrUZaKHBhHFOKTJIE7
 dZq2lNJ9bC93mF7TDaEdsocqv4RHmJal+riQNpODkI9wYA81FWnGR5fcNH5ll3LFfdzH
 guHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781816432; x=1782421232;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=E3EmkC3Hc98n7MeOQI3axdLDM6TN5jua/tnyuzXpkN0=;
 b=oizCROWNeH1HygbUqU8W5EN91NShz2mRsxPWOeNDNF5Cmo6yARLQGv0Q3cd4VwF/hu
 TTPCKoIbQivzwlx2OAH+aXO8uXB1pjPQFiydvCzihcCQT2DWuAMyXYRovK0SbbI+85Eo
 NNxXKPOyMoq4rxXeDjssko72g/lpIrCwd6rAfr3vtAor3N6oIHdR5j4QreDGqepRTH+Q
 mAU2/CasDAI4XVHyYhwKofVuL4R5o6iWMmTEe6Nr/p3GLCqUbT8WzG8NiVHul3Qq5jR4
 MKbnXmLu7R6XU2/xvK0fAp3lMIMwBvzirNVkUWsgPEp5MNmTujEAmd6Q8rk3X1hg1iQg
 L8aQ==
X-Gm-Message-State: AOJu0YzG9Fqc36NmbsTB4ijqBVUINTZWxGvB+lx59M01ie9r+z4ua8gt
 qB7g4DGWqfKI7zd5rtt30I1V3IzQPJyv0jxrha9nb1ijmoPPKa+KIG5Zl3GriNlIRNFn703p+Sq
 EINca
X-Gm-Gg: AfdE7clY3IN8vjz43T3Uu+gC1c75DmWubp4IDA0MgylOcC+Uq0Ze6rI7PFLOX3kWPVi
 ySOfE3KDcixG8h+nEIBUBXHu7hoGq97Bz93f8svUIFKBcsw4mtieJCQoKNBuWjC+Sl7zEBVB5yB
 6TnwaBAC8JzvuvBSRlt7BD0jmdETpOSThkDtsSLzAYQF/21StO/TCHuCncuODLmyX9BhU9GKmie
 NxecD8fyBzNOSc3n5iL8IzgOOzFegby0Jq5MzrZIfbEkd8oTm+Gmuh9SS7GVXcVxCJGkfR1899r
 HZQB5ngjBwoPIkJNDu0ldz82+PZpAz7MkQoDK+8GbftUonBsHx2bf7ba3sCWhiEzqjhGn1n9Q+y
 js9uPhJHLTmdhmydlNP9VPBtc7VKgrOukVQ4kio3q1WID1VvPUaNCEAVNN0VzXgLYI6d+DIiJtn
 +sS4zpLwToEAKO9dhvcTWgzPaw93NhuWCCS12mjmU3EesrCbEJxyo=
X-Received: by 2002:a05:7300:3091:b0:30b:dd58:e134 with SMTP id
 5a478bee46e88-30c071dfef9mr785767eec.21.1781816431963; 
 Thu, 18 Jun 2026 14:00:31 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c06d6766fsm863387eec.29.2026.06.18.14.00.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jun 2026 14:00:30 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Marat Khalili <marat.khalili@huawei.com>,
 Ferruh Yigit <ferruh.yigit@amd.com>
Subject: [PATCH v2 1/6] bpf/x86: fix JIT encoding of BPF_JSET with immediate
Date: Thu, 18 Jun 2026 13:47:05 -0700
Message-ID: <20260618210026.430288-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260618210026.430288-1-stephen@networkplumber.org>
References: <20260608203322.1116296-1-stephen@networkplumber.org>
 <20260618210026.430288-1-stephen@networkplumber.org>
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

emit_tst_imm() emits TEST (0xF7 /0) but sized the immediate with
imm_size(), which can return 1 byte. TEST has no imm8 form; it always
takes imm32. A small mask like BPF_JSET | BPF_K #0x1 then produced a
4-byte instruction the CPU decodes as 7, swallowing the following Jcc
and crashing.

Always emit a 32-bit immediate for TEST.

Bugzilla ID: 1959
Fixes: cc752e43e079 ("bpf: add JIT compilation for x86_64 ISA")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/bpf/bpf_jit_x86.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bpf/bpf_jit_x86.c b/lib/bpf/bpf_jit_x86.c
index 88b1b5aeab..0ffe3783ff 100644
--- a/lib/bpf/bpf_jit_x86.c
+++ b/lib/bpf/bpf_jit_x86.c
@@ -921,7 +921,7 @@ emit_tst_imm(struct bpf_jit_state *st, uint32_t op, uint32_t dreg, uint32_t imm)
 	emit_rex(st, op, 0, dreg);
 	emit_bytes(st, &ops, sizeof(ops));
 	emit_modregrm(st, MOD_DIRECT, mods, dreg);
-	emit_imm(st, imm, imm_size(imm));
+	emit_imm(st, imm, sizeof(int32_t));
 }
 
 static void
-- 
2.53.0

