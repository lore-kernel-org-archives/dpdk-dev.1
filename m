Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE930CDE001
	for <dpdk-dev@archiver.kernel.org>; Thu, 25 Jun 2026 17:33:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6AA9340609;
	Thu, 25 Jun 2026 19:32:50 +0200 (CEST)
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
 by mails.dpdk.org (Postfix) with ESMTP id 7163B40651
 for <dev@dpdk.org>; Thu, 25 Jun 2026 19:32:41 +0200 (CEST)
Received: by mail-dl1-f49.google.com with SMTP id
 a92af1059eb24-139a5f4ca15so150436c88.1
 for <dev@dpdk.org>; Thu, 25 Jun 2026 10:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1782408760;
 x=1783013560; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tDOdGOJn5bAn/d6RwJNUCzJvgRxnQpV6nRBQc0jYU9s=;
 b=Qh48FtySgDsfm7SEQcgSswHahsPDCo7dS8q8cR/a3u0Aqr5VyGRK/wCkkwjNR0Ivlb
 teQyJKifPC4B+EztZR285EZbK9OvaxYD4aAtKFZoxzO+eSuxfJVYosIh6kBkgnJsIxDB
 CclynnOyNJSpG15iyyaA7CDQZ4zEeVOkPsgODiJ3YSwjavpFxdCps74HK9N8sLWGWXuD
 /xqZzMclEPxTbJ/rRrFy+c1TWIuZaixHrzb7PM9WzbZDtKYmUqNS5Hpk2JYZY97npzGT
 PeS+JEbPH/4H7Y0vWppqSaxuQ+TJcq2/IQ0K0FCaKoZBYErRD4lNroJo3kVyBfmL2yYt
 C5qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782408760; x=1783013560;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tDOdGOJn5bAn/d6RwJNUCzJvgRxnQpV6nRBQc0jYU9s=;
 b=O6eIKRhkXaetNIX4a566NmYLQjYOIXYD/DBg0U2+E6t5whzqLULQ/2Z5/ox7wZxczW
 oEOlGlphfnplVEiKkA4pAEWUxrNw/q1WSWhKCj2nGnEf9e7DaZavYA2TJKFEHxDRabSU
 6CxOy2Vmq5PcrhmxgSu2LKIGE/A72aDCjOWY6o55cB8LrJqHqDfEYxNrb+kXCGhdrkjZ
 5ak8fr7IBeAmBNChdxIsU2oMC7koYeuRfOWCr6NWa0AYE8E9f0Lhr+V7sruVcK+RlCeG
 cxQPdoDRAKTXH3rH7g8aG9lh3r2Z+ZMvF92uJyZ9V4xQX5Wv2arGSrrctyfrqaS/xqWx
 9nww==
X-Gm-Message-State: AOJu0Yyk3sTOWEcTELOPsxebwt51WwFxDSqi1emJ+tcjCPiyxZRWnkR7
 Lk3UpygDbUnhDp6W1cWzvC0YzpQTAq08O1oLggUpF0lKxZlxWH0a4SSwtCl94HSzOZAhw+CfLMs
 nPJ50
X-Gm-Gg: AfdE7cnznHQPXZtBZVmju4lTw/GldDWyMZLBqdPJ3fApHWjRLW1PF0LkEIvEIwrleZQ
 jlEe1TQctwZVNu+VNIhSfUkZqCxdLuPPNbgYFCWS0u3/p17tjcq/LlNqA/lNqRMuavXvvvirQvc
 MRk3HAnPum80QDsuYm64QM20ntmUoFQmc4imC5wZjuoBjrldppgFgyIgm1/J3CF0k1HrbMiPrSU
 h+hgO+l1HIAvmXz7t9TkdZG0/N31RgUvHqG308NOJKvldXYTDpFwSL4t0eeDB+fV7Yu+qTvdxXi
 sYz8944lLQkY4yZriDicDtJPPF90Ivq9BISfaakqR0Wu915nSldHKcr74WrHGHHYDpX+prZw6mk
 f/usr07YiHNcdf+MFxNaxZtjturVsNpb+aMWJfWnfZJGYg7m8e1u2CDhBDF5w5O6DAmAEZdSwe7
 Qygk13elEz0cprv/ESPSUQyfqME3wuiw9glSMm5/AQEU4UM7L2F2g=
X-Received: by 2002:a05:7022:ec0e:b0:138:3613:dc6 with SMTP id
 a92af1059eb24-139dba644ddmr2915878c88.14.1782408760326; 
 Thu, 25 Jun 2026 10:32:40 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-139d8f6acf9sm10218165c88.6.2026.06.25.10.32.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 10:32:39 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Christophe Fontaine <cfontain@redhat.com>, stable@dpdk.org,
 Stephen Hemminger <stephen@networkplumber.org>,
 Marat Khalili <marat.khalili@huawei.com>,
 Wathsala Vithanage <wathsala.vithanage@arm.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Jerin Jacob <jerinj@marvell.com>
Subject: [PATCH v6 6/9] bpf/arm64: fix offset type to allow a negative jump
Date: Thu, 25 Jun 2026 10:30:16 -0700
Message-ID: <20260625173231.216074-7-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260625173231.216074-1-stephen@networkplumber.org>
References: <20260608203322.1116296-1-stephen@networkplumber.org>
 <20260625173231.216074-1-stephen@networkplumber.org>
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

From: Christophe Fontaine <cfontain@redhat.com>

The DPDK BPF JIT standalone test test_ld_mbuf1 fails on arm64.
It does:
	r6 = r1                    // mbuf
	r0 = *(u8 *)pkt[0]         // BPF_ABS
	if ((r0 & 0xf0) == 0x40)
		goto parse
	r0 = 0
	exit                       // epilogue E0
parse:
	r0 = *(u8 *)pkt[r0 + 3]    // BPF_IND
	...
	exit

emit_return_zero_if_src_zero() returns 0 by branching to a function
epilogue. The target may be a previous epilogue so branch
might be backwards; therefore the offset needs to be negative.

The offset was stored in a uint16_t, so a negative value wrapped to a
large positive number; emit_b() then branched past the end of the
program and faulted at run time.

Fixes: 111e2a747a4f ("bpf/arm: add basic arithmetic operations")
Cc: stable@dpdk.org

Signed-off-by: Christophe Fontaine <cfontain@redhat.com>
Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Marat Khalili <marat.khalili@huawei.com>
---
 lib/bpf/bpf_jit_arm64.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/lib/bpf/bpf_jit_arm64.c b/lib/bpf/bpf_jit_arm64.c
index 7582370062..51906c7f0d 100644
--- a/lib/bpf/bpf_jit_arm64.c
+++ b/lib/bpf/bpf_jit_arm64.c
@@ -965,10 +965,12 @@ static void
 emit_return_zero_if_src_zero(struct a64_jit_ctx *ctx, bool is64, uint8_t src)
 {
 	uint8_t r0 = ebpf_to_a64_reg(ctx, EBPF_REG_0);
-	uint16_t jump_to_epilogue;
+	int32_t jump_to_epilogue;
 
 	emit_cbnz(ctx, is64, src, 3);
 	emit_mov_imm(ctx, is64, r0, 0);
+
+	/* maybe backwards branch to earlier epilogue */
 	jump_to_epilogue = (ctx->program_start + ctx->program_sz) - ctx->idx;
 	emit_b(ctx, jump_to_epilogue);
 }
-- 
2.53.0

