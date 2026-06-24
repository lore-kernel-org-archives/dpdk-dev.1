Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85961CDB47F
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Jun 2026 17:58:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C0A084067D;
	Wed, 24 Jun 2026 19:58:33 +0200 (CEST)
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com
 [74.125.82.181]) by mails.dpdk.org (Postfix) with ESMTP id DD723402BC
 for <dev@dpdk.org>; Wed, 24 Jun 2026 19:58:26 +0200 (CEST)
Received: by mail-dy1-f181.google.com with SMTP id
 5a478bee46e88-30c6c8d7503so2722737eec.0
 for <dev@dpdk.org>; Wed, 24 Jun 2026 10:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1782323906;
 x=1782928706; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tDOdGOJn5bAn/d6RwJNUCzJvgRxnQpV6nRBQc0jYU9s=;
 b=UMvMwneYY9W1p2ETeNwFdOZsACNb71KH/KmUOaZgX7UuL+1u7KtuIrpF2zai264uvR
 OAdY5TUqYJ7uNyJTA1egxc2Wls3VVaAuDrgqt0WWHPtU6lPN7qvuIG/PeW7yKEAzI4DY
 pzBlurgoBWgK2ab0SfP6pgMwcUSVoNB97yKhCVYBS4sMD4d5FTPrrAF8JvMeyyvzspN3
 Jl/sLeiQElO5Rua3l6rH1XLq91wwUpG29Lz0DC+PMumg5lTSj+jkNwtYL5fizB4v5DK6
 5UllMtqWjUNULph0fak59evcKepq8SNOW2lHxYH3g3bcchLIJkcqZStkU2DfzZfnLNFZ
 qheg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782323906; x=1782928706;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tDOdGOJn5bAn/d6RwJNUCzJvgRxnQpV6nRBQc0jYU9s=;
 b=DJOIk6UOdP3PB5o0BMPaIUUBXinYB/7EQ1cLCA+Nn1siJFVH11QUO22oZssy22q+Pp
 41xS1DH2Z4B6e2N6IWk+GSvxn6mIJjoEvGIJrM8WwhJPPDFJMvb5wlMtXtvwKTOGG39u
 3RaIZNphp5HzIAnPg2xl/aHk7L23+2iP/7+MJw14Exmz8gtSRBdVyweqlVMZl2VDGCGi
 sUMksCBTgamISMdSQM/4nqJVinTyyLkX63Iy2HJZyt2A/iw1nQfc5CyOKqeHVdVOqr3l
 0U++sdx3od94jBgNIo1Mhg0VOJYtiujJ8aW6fSMSPqIiMyjAoh5gx9AUSD1fhEmfxhbk
 Cgug==
X-Gm-Message-State: AOJu0Yx7XBXIhJXFJFo6meux1H6z4jUNh/Nbnejip1rxcPHkPDv9kUOR
 akexDwHUYi4dggYj5glMaRGRXWHTyCVs9NDVTcZqC8W35YmKDxsj3reTG/rM/Xd8lwcmehQA9Pg
 udsR1
X-Gm-Gg: AfdE7clzS53uxCvhrdUwXRHIR+2lMb8676J1ZzZ0gC89u8ipzrfH2/P/WsnJv7tkdxn
 XabfmcDp4AndWiigVRai+qyx9wilG7ZZeuIim5gUDfvr6+72CCJY7703dlwTOuLJRFd5WLgjkXw
 opTFNuBi0bhld+pInyte5l2v3AyO0OYJILTwNou+8ra2j/m+PUTPvJaoGhG9+dvIs5tt+Ykm8YU
 pYbjQ8BLHVfEar9z6UDatfZwVCA8wopUD6hxHhIoVJsLJers6XZ9xOFKEgGoPXjQWAqz4L81JgA
 YnECsS8cZF8DYeFvpU+++fxaOHlKpkb3j5VFw6TiCdGNytt1laG0tWl9UoVv6XTgfqfyBziG/wa
 qjYy+38DJ7aaEYczTPdT4EkCciodU31kbJnh5j901IVn2LIwUPw+BEhMleVMsS1vfgxL5hOLRD1
 hO46mvOAELiluRypkQlnfTfHdP1avwlMnc7rEZT/8MFmZymNu2uV8=
X-Received: by 2002:a05:7300:372b:b0:304:e865:f7d1 with SMTP id
 5a478bee46e88-30c6934c210mr3915951eec.25.1782323905922; 
 Wed, 24 Jun 2026 10:58:25 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c7cab08c2sm696325eec.29.2026.06.24.10.58.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jun 2026 10:58:25 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Christophe Fontaine <cfontain@redhat.com>, stable@dpdk.org,
 Stephen Hemminger <stephen@networkplumber.org>,
 Marat Khalili <marat.khalili@huawei.com>,
 Wathsala Vithanage <wathsala.vithanage@arm.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Jerin Jacob <jerinj@marvell.com>
Subject: [PATCH v5 6/9] bpf/arm64: fix offset type to allow a negative jump
Date: Wed, 24 Jun 2026 10:55:05 -0700
Message-ID: <20260624175815.673064-7-stephen@networkplumber.org>
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

