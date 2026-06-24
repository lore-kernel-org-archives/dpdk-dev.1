Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2514DCDB47F
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Jun 2026 17:58:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B7F6340677;
	Wed, 24 Jun 2026 19:58:31 +0200 (CEST)
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com
 [74.125.82.170]) by mails.dpdk.org (Postfix) with ESMTP id BB80440662
 for <dev@dpdk.org>; Wed, 24 Jun 2026 19:58:24 +0200 (CEST)
Received: by mail-dy1-f170.google.com with SMTP id
 5a478bee46e88-30b6dad2382so2381808eec.0
 for <dev@dpdk.org>; Wed, 24 Jun 2026 10:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1782323904;
 x=1782928704; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FhHwSwIorQ0jm9mERPeGWh9M+/cNs2iywCAXQV2VBvk=;
 b=WzJAJb3xRVFs6u0+zaUpieaERE8ouPKIT4ZlCKwGeIx34pAUsJLg8PYUSszJ7otwuZ
 16g39iTZ6xYJWT2JBPU2avktnCcXB1OVydl15O/1PpT95ROpWoLBKiCWlK/g8MAj3dCg
 XVrcdx5MyvduWdYANvEU97pc6/ZlzMOL1r86Iu0KmdNcH4VYdECslnWD+hKKHEqHcvzw
 sDFcsLpHtGfmdOZmNIeoJA3EMiu6IHaLQi2SFRqPv3sYW07SO3yBMm80ExvDqk61UDO1
 vHoq6g1se18WVITDnyHSschq87YK7mqr5z/vTDLtOYosOPq9tlRjIFqZAavsHMjqATVM
 RjmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782323904; x=1782928704;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FhHwSwIorQ0jm9mERPeGWh9M+/cNs2iywCAXQV2VBvk=;
 b=NRYCjQ7/ieBou1XaWY3Cfc51DbxFGJPWCgZ0L6btkgdOB/jnLI6aWn/rTMlRmy5qJ+
 rEc/p080VKwbF45YQiyovn12BNEM2nCFv2Sshls8LwJLwQGt8eKxRimxmrqW0k3a14Ut
 PyZptI6zLYWrqEQ9X2voFq3j1FyWSr/tmYFLhneFXSI5wI4TtRpWNli3OkZSNN4OcioB
 mptdQ+pIJYx/r90a/3CvRdEuPO3lrkaGOGWQUjZdSf/QyVgGY9MAoZjJqukznMT6JEw5
 3ZIeJF+6nLsFOp3bX+GD62hsumeEWf40podOVjOLlLTxRb+G3C6W6cMzsfGcU8cDAcJf
 WrCg==
X-Gm-Message-State: AOJu0YwBiGlOKk9NdGAq4jn034TaT4IeMKGUsDaq+p6NiW77WUIGP5ng
 tnWk1Bu8isQg2bPu2rHFqrCj61kDPcbrts5eFtYlFQ9fnSGnu+CgrWJ2KOHls4MILmZedd0/dvu
 k9plJ
X-Gm-Gg: AfdE7clgFqUXk4GiReP4hYVnfgl4lcA1M1UdWKvbMERMq3dshv/VpHWC53kraLRC+zJ
 i8vHfsixk8lzEz10VZMukaC3wPv6RZzhMqGlwmjiEoe8Hh40kiwDLXfJ5cXtcIfXCqVW/+TYf7C
 sZXUjB+d1Jft9yGA5d0tBGI2lFJbPYZRMVxmkTFddkPdisOSKYVHKJShuy6ifpu7icz6/DjMJGc
 f5DHjZVL1ugiY234OFYj0plcoE38GhOPhfMTXDm+au9h4KvP0JVzPSm41sZj+iT+dtq7s8fHnxB
 lLjhfn4YQHZO8NR7T1mb+v5flwfb3SFIqRngZFzZKKvXYb+WltBg8wZhlkhpQfdyPbnj7LMj+JU
 fiANN15hAs3K6/XIg5uLkn6eADbhokOQ6BDswJxRQrqFFQENTwOrIzaofhAI3G+73gFohHYi5WT
 UkwvIqdu+Sb3CgNHKbup6SB+G0IQFC1EPfaBDHrr5aiANRsD2i9oI=
X-Received: by 2002:a05:7300:1897:b0:2d0:239a:23cb with SMTP id
 5a478bee46e88-30c58c1b8d9mr7695721eec.16.1782323903600; 
 Wed, 24 Jun 2026 10:58:23 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c7cab08c2sm696325eec.29.2026.06.24.10.58.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jun 2026 10:58:23 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Wathsala Vithanage <wathsala.vithanage@arm.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Marat Khalili <marat.khalili@huawei.com>, Jerin Jacob <jerinj@marvell.com>
Subject: [PATCH v5 4/9] bpf/arm64: mask shift count per RFC 9669
Date: Wed, 24 Jun 2026 10:55:03 -0700
Message-ID: <20260624175815.673064-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260624175815.673064-1-stephen@networkplumber.org>
References: <20260608203322.1116296-1-stephen@networkplumber.org>
 <20260624175815.673064-1-stephen@networkplumber.org>
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

The ARM JIT was not masking the shift count as required by RFC 9669
(0x3f for 64-bit, 0x1f for 32-bit), so large immediate shift counts
overflowed the UBFM/SBFM encoding and failed the JIT. Mask the
immediate in emit_lsl/emit_lsr/emit_asr.

Fixes: 9f4469d9e83a ("bpf/arm: add logical operations")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/bpf/bpf_jit_arm64.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/lib/bpf/bpf_jit_arm64.c b/lib/bpf/bpf_jit_arm64.c
index ba7ae4d680..7582370062 100644
--- a/lib/bpf/bpf_jit_arm64.c
+++ b/lib/bpf/bpf_jit_arm64.c
@@ -545,12 +545,14 @@ emit_bitfield(struct a64_jit_ctx *ctx, bool is64, uint8_t rd, uint8_t rn,
 	emit_insn(ctx, insn, check_reg(rd) || check_reg(rn) ||
 		  check_immr_imms(is64, immr, imms));
 }
+
 static void
 emit_lsl(struct a64_jit_ctx *ctx, bool is64, uint8_t rd, uint8_t imm)
 {
 	const unsigned int width = is64 ? 64 : 32;
 	uint8_t imms, immr;
 
+	imm &= width - 1;
 	immr = (width - imm) & (width - 1);
 	imms = width - 1 - imm;
 
@@ -560,13 +562,19 @@ emit_lsl(struct a64_jit_ctx *ctx, bool is64, uint8_t rd, uint8_t imm)
 static void
 emit_lsr(struct a64_jit_ctx *ctx, bool is64, uint8_t rd, uint8_t imm)
 {
-	emit_bitfield(ctx, is64, rd, rd, imm, is64 ? 63 : 31, A64_UBFM);
+	const unsigned int width = is64 ? 64 : 32;
+
+	imm &= width - 1;
+	emit_bitfield(ctx, is64, rd, rd, imm, width - 1, A64_UBFM);
 }
 
 static void
 emit_asr(struct a64_jit_ctx *ctx, bool is64, uint8_t rd, uint8_t imm)
 {
-	emit_bitfield(ctx, is64, rd, rd, imm, is64 ? 63 : 31, A64_SBFM);
+	const unsigned int width = is64 ? 64 : 32;
+
+	imm &= width - 1;
+	emit_bitfield(ctx, is64, rd, rd, imm, width - 1, A64_SBFM);
 }
 
 #define A64_AND 0
-- 
2.53.0

