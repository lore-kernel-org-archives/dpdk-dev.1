Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1568B606A31A
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 Oct 2026 17:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=VJsDT2Bd
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0460C40151;
	Tue, 27 Oct 2026 18:06:25 +0100 (CET)
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com
 [209.85.214.176])
 by mails.dpdk.org (Postfix) with ESMTPS id C7195400D7
 for <dev@dpdk.org>; Tue, 27 Oct 2026 18:06:23 +0100 (CET)
Received: by mail-pl1-f176.google.com with SMTP id
 d9443c01a7336-2ea1e7fad99so88095ad.1
 for <dev@dpdk.org>; Tue, 27 Oct 2026 10:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1793120782;
 x=1793725582; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Vy0PFNc5x1sp1B1gflVkkKZC4MAkmSdF0vmyaVGm4uc=;
 b=VJsDT2BdKbL0pX4ii8zT3nqqJjTn8kt4lhLrPl9UTuZ11gQxkuFL0ub/3r/y8h2mur
 OWmu5VIylrTwvjMGp5lY5Q6pSPxT1988oPcEjqA16+Y+jLE0xohjmGNrik5dPShnQzfk
 YjSDQPxqevScipAS0xP/7jOIBdqhVQtujgreRvB00cf6pfMLG5L3BiMj0EXTfeStPoPl
 UwtKyjAvA+rj3/hnbp+B5+hv9PFV5DNeHopj0l8BlesIV+QdzS9Okt8zFiB7wIEejCL6
 XGfNl+qkv6/vpxE1GgIwdwEWpZ0HLBHyezugirQLXp0soPahB0gayVzBSTQ58FB9Bn0j
 PGCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793120782; x=1793725582;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Vy0PFNc5x1sp1B1gflVkkKZC4MAkmSdF0vmyaVGm4uc=;
 b=vycLmDAc5E6IZifj1KJTu0XUhHFDkolRHWo5Bt+tTU1OqYpc1MY0HpoSjK1/C3sPx4
 mF0i2DdQD8j4bj03zRXyDmwUZaVFq8CioedsTr8Et3ktbWmSAZbWZ1NdzCjs+7BdAuk2
 sRSh0Pttc5Pfq2rrmBfKb4ndX1tcCt9tZFzUObzde2eE9V3v898sYxOjIQ3335qACOlm
 0u2bpE13PVfucjHqr3cweaijgcSPdaPSV5ImR8l+DUztiu4oEFf02bCE4K5YJUtwHeT4
 tuccTCy4JtqqeIbA6JiDwCds4TNIIGiVzV0wcR8Z9gatr3QrUv0wdYB1XtRJHxJKXHCB
 W2Kg==
X-Gm-Message-State: AFq9FYKFcb1gUuaO/wK+3RjQeTAX9vmNCZGojZjUh5toHG/vPmhd9uTn
 8DJmvRxZNJOu9lupDbVfCm4R2dKExXtdQinHTX3I2FQi+zFdX0qqNUafDS4hO6kWLA3JOe1OnwI
 jW1s2yIg=
X-Gm-Gg: AYBFou09zv6dBiGNv/t8kjf1TvvCFeohnoM3DbyiqSLj2ZBt0ARt7HLI1U4LB4rh7KA
 l+YUvDmnStVF777cNSAvAPWQYAFx+a/aPuayfJsI9Zmab6gE5CZjwn7liTzFx03Kb6jzmN38kVd
 7HzhjZg2Stuhbd2ByjLX1JFeDmf1AFDXxDPiRNeAl3CgMsYgrV0V8aKMQgzHE23uwrhUMqzoJ8a
 69SwXWDcTptlwBLFeF9rY6TrY8WIy75CQLAPsv/ihJBCd4JXHITgedbCiD5+N6M7XTKhmEh8z0N
 46YwKpzBkjI4rHdNVps9zcNrsIAaAxYONfGOK3p2WK1vcLoMUCTAmLrGkUe5jS1QOR2R2/MGIdL
 lCENPJHt3eUYnRXRBTdhTMkWVwLB1qGzfe9hWa/tfyJcnTAXT7FIonqWlpuekn+QGSleVpMTAOM
 Cr8bA3eTNaHqMd7/A+j9pv/XDmqPetv/DtGsr2GvcZXYBGOGNLc4as/Hh56ZhIf3y36YdEvICc5
 UAUCW8I6EjpY0T3sLpXy5gGhlQl5bOH1IpoElmxpRXnhumPkOa96AarfUNB4HY2UjIrg4icGKaU
 Vxbt8Btyosj8DfFuJxA=
X-Received: by 2002:a17:902:ef48:b0:2e9:6788:937e with SMTP id
 d9443c01a7336-2eb004e9a69mr39505ad.42.1793120782126; 
 Tue, 27 Oct 2026 10:06:22 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cd8cc9b216asm3234270a12.3.2026.10.27.10.06.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 10:06:21 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Marat Khalili <qm2k21@gmail.com>, Ray Kinsella <mdr@ashroe.eu>
Subject: [PATCH] bpf: fix index register for classic BPF indirect loads
Date: Tue, 27 Oct 2026 10:06:19 -0700
Message-ID: <20261027170619.2193021-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Classic BPF filters using a variable offset into the packet, such as
"tcp[tcpflags] & tcp-syn != 0" or "tcp[0:4] = ...", read the wrong bytes.

The indirect loads ldb/ld [x + k] were handled in the same case as the
arithmetic instructions, which take the source register from
BPF_SRC(code), that is bit 0x08. In a load opcode that bit is part of
the size field, not a K/X selector, so BPF_LD|BPF_IND|BPF_B (0x50) and
BPF_LD|BPF_IND|BPF_W (0x40) both yield BPF_K and the index register
becomes R0 (A) instead of R7 (X). The halfword form works only because
BPF_H and BPF_X are both 0x08.

Give the indirect loads their own case next to the absolute loads and
emit X as the index register. The interpreter and the JITs already
take the index from src_reg, so this fixes all engines.

Bugzilla ID: 2085
Fixes: 2eccf6afbea9 ("bpf: add function to convert classic BPF to DPDK BPF")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/bpf/bpf_convert.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/lib/bpf/bpf_convert.c b/lib/bpf/bpf_convert.c
index 37095eea52..a32e1cdd8a 100644
--- a/lib/bpf/bpf_convert.c
+++ b/lib/bpf/bpf_convert.c
@@ -301,6 +301,13 @@ static int bpf_convert_filter(const struct bpf_insn *prog, size_t len,
 			*insn = BPF_RAW_INSN(fp->code, 0, 0, 0, fp->k);
 			break;
 
+			/* Indirect loads index the packet with X: A = P[X + k] */
+		case BPF_LD | BPF_IND | BPF_W:
+		case BPF_LD | BPF_IND | BPF_H:
+		case BPF_LD | BPF_IND | BPF_B:
+			*insn = BPF_RAW_INSN(fp->code, 0, BPF_REG_X, 0, fp->k);
+			break;
+
 		case BPF_ALU | BPF_DIV | BPF_X:
 		case BPF_ALU | BPF_MOD | BPF_X:
 			/* For cBPF, don't cause floating point exception */
@@ -328,9 +335,6 @@ static int bpf_convert_filter(const struct bpf_insn *prog, size_t len,
 		case BPF_ALU | BPF_DIV | BPF_K:
 		case BPF_ALU | BPF_MOD | BPF_K:
 		case BPF_ALU | BPF_NEG:
-		case BPF_LD | BPF_IND | BPF_W:
-		case BPF_LD | BPF_IND | BPF_H:
-		case BPF_LD | BPF_IND | BPF_B:
 			/* All arithmetic insns map as-is. */
 			insn->code = fp->code;
 			insn->dst_reg = BPF_REG_A;
-- 
2.53.0

