Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 813C4FD8FF9
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Feb 2026 18:29:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4A2DD4028F;
	Thu, 26 Feb 2026 19:29:16 +0100 (CET)
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
 by mails.dpdk.org (Postfix) with ESMTP id 6E8634027F
 for <dev@dpdk.org>; Thu, 26 Feb 2026 19:29:15 +0100 (CET)
Received: by mail-dl1-f51.google.com with SMTP id
 a92af1059eb24-126ea4b77adso1584881c88.1
 for <dev@dpdk.org>; Thu, 26 Feb 2026 10:29:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1772130554;
 x=1772735354; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J1oLWde4hCnwrcwBK4qwcN+7pBE2tTeXtAeW+heDnjw=;
 b=HwRgTLyo63M1Nofhkt4cDL4aeD7Qw9bG7mXtTPWeykfbYatsLrow0I8sAQiFsKcACw
 0tj8VmtQ8k4Sgzx5mTfmfeXREwJsU9Bnea0sFuVFpbJP5YxBXs7OQ65dnmsTDcQlw8hj
 TesVOhhjB9POckynHRoCJQ3Vp5ycF1i7jklDK7ytV9ITe1ZfXSIj5ZXWOGA9mHn6bQWL
 28HLftdMN22V2Be6EBiXoOtwMkt8UNXo7+Ckcal38OQAp3MMZW7ce6HFIa1stnKgc7Kg
 K20DGvIlRkHV9Y9Kr4rgHeEs57UP1Ps1O/gJMpFjzPxP0a0JPcbb75OkfCBSGEoha9Df
 3Bwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772130554; x=1772735354;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=J1oLWde4hCnwrcwBK4qwcN+7pBE2tTeXtAeW+heDnjw=;
 b=FfX48OFjrEhS7NI2EDfR3KqWejRc6/CUgqF1IbII5GQiXR11T8oXVzv0eKpHA4kWJq
 4yDxQZdqgQrgE89qbqwT9AMJFWxIhzqI4Zwz/oXSdlLID1/nPt3OZua8AALfixpjEKyw
 A38wGViOmlhs8YkZMFz2bRR0zrjxJS1m/M5quRFjlAaVbHDCZkOgvm8TN6fkpwPsGb7d
 xF/xcfBAZuqsrg8Ex8Wa/szVIK0kCagkXEAKHdNsbNeQYAhSfHCyZPqVUcIkOmvV/Dnx
 degll2har6PGu2l9fjaxkoc4z/uXickMv95ooBvwJZpIw+L1uffciEHne2ziBcU/l/Yh
 IxCw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXC+K9rqZjZEaBt6arJ9h11yczOLZSEgFwRsaaQD063edK5PLFKUGjz6nlSNhOcLCyH180=@dpdk.org
X-Gm-Message-State: AOJu0YyDfweXtdDh5tQbUF13mzqB9gqYMh+6glLcpexR4qTHCDKkSNMr
 GqPE/kIujQ5hUPuTz2ONf8iViZhAizSyLFxHhAd10quSYYZF64LX0njck4Y1s4fy4lA=
X-Gm-Gg: ATEYQzzbTBJq2i3ve4i2Y2mQKnlCuLVNK9dFK1un5NqaDzQDav1h9saWGzoPcrfvUGt
 bYUxMJBXjNz3/R9Z3ILbHKz/wSzhaUOn+XE1gRraQNxZ3k6hVgq/oGdeaU9BJcFXm3TheumWcUs
 NcvxKm9ZYSvYMAOm7USG7kTAi34vymT3bVj2Cxe4iKmr6cywmGp2PxHclF+piemH1oz5BkIi7o0
 XCGIO26AK8zrnAACxZeINfnFZ14uAQugzzuAQGDTYXdJINgNDpGHxTowLYTCW8ath5kJibsleVJ
 lx9bNXl/6iokfF+oSypg4bK1z42SqXP+TAk1flNKKmohPYhqsF6XnTX1gf1bdq/Luzm7Vfhc/Vf
 3MYm6jd4NkJxKNGWaIIs76cTfTYEhZy68ZtRuOJ+LxG3DRqG2uzHw0QTI9q4+aKDfH+3lURLMPY
 odTuuWe0kKJfndxdhKiFZHNuHjIV4djUGioOD1uD2W2o3ccrba2P8v5W3UjjO+6Jx+
X-Received: by 2002:a05:7022:2383:b0:11a:6424:f40f with SMTP id
 a92af1059eb24-1276ad44b10mr6445723c88.36.1772130553939; 
 Thu, 26 Feb 2026 10:29:13 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-127899d499fsm3961368c88.2.2026.02.26.10.29.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Feb 2026 10:29:13 -0800 (PST)
Date: Thu, 26 Feb 2026 10:29:11 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Marat Khalili <marat.khalili@huawei.com>
Cc: Wathsala Vithanage <wathsala.vithanage@arm.com>, Konstantin Ananyev
 <konstantin.ananyev@huawei.com>, "dev@dpdk.org" <dev@dpdk.org>
Subject: Re: [RFC] bpf/arm64: add BPF_ABS/BPF_IND packet load support
Message-ID: <20260226102911.1ab0e801@phoenix.local>
In-Reply-To: <e9264a6e2e934b3089b26d09b18bfd7b@huawei.com>
References: <20260223193522.323100-1-stephen@networkplumber.org>
 <e9264a6e2e934b3089b26d09b18bfd7b@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Thu, 26 Feb 2026 14:24:43 +0000
Marat Khalili <marat.khalili@huawei.com> wrote:

> Thank you for looking into this problem.
> 
> Some general comments:
> 
> * This needs tests verifying that instructions, both hardcoded in the test and
>   converted from pcap filter, actually load expected numbers from the packet
>   (or fail as required by specification).
> 
> * Instead of hand-coding corresponding logic in machine code for each
>   architecture, should we consider writing it once in eBPF and using only
>   minimal architecture-dependent code for insertion?

This is for JIT, so it is going to be machine dependent.
The biggest win would be figuring out how to share eBPF to JIT from other
projects. That is the redundancy.

> 
> About AI generation. I feel like I spent much more time reading this stuff than
> AI spent generating it. It does not feel fair. This needs a lot of work to be
> of production quality, and it is possible that many of us would do it faster
> without AI. Highlighting possible improvements feels very gratifying when part
> of a teaching process with an intern, relatively useless for an AI model. Since
> each of us has access to this stuff, I'm not sure what the point is in doing it
> this way.

Agree mostly. But AI does a good job of cloning from existing code.
The problem is that as you point out, it rarely spots where having


 
> Please see my comments inline to understand what I mean.
> 
> > diff --git a/lib/bpf/bpf_jit_arm64.c b/lib/bpf/bpf_jit_arm64.c
> > index a04ef33a9c..dff101dbba 100644
> > --- a/lib/bpf/bpf_jit_arm64.c
> > +++ b/lib/bpf/bpf_jit_arm64.c
> > @@ -3,11 +3,13 @@
> >   */
> > 
> >  #include <errno.h>
> > +#include <stddef.h>
> >  #include <stdbool.h>
> >  #include <stdlib.h>
> > 
> >  #include <rte_common.h>
> >  #include <rte_byteorder.h>
> > +#include <rte_mbuf.h>
> > 
> >  #include "bpf_impl.h"
> > 
> > @@ -43,6 +45,7 @@ struct a64_jit_ctx {
> >  	uint32_t program_start;   /* Program index, Just after prologue */
> >  	uint32_t program_sz;      /* Program size. Found in first pass */
> >  	uint8_t foundcall;        /* Found EBPF_CALL class code in eBPF pgm */
> > +	uint8_t foundldmbuf;      /* Found BPF_ABS/BPF_IND in eBPF pgm */
> >  };
> > 
> >  static int
> > @@ -1137,12 +1140,293 @@ check_program_has_call(struct a64_jit_ctx *ctx, struct rte_bpf *bpf)
> >  		switch (op) {
> >  		/* Call imm */
> >  		case (BPF_JMP | EBPF_CALL):
> > +		/*
> > +		 * BPF_ABS/BPF_IND instructions may need to call
> > +		 * __rte_pktmbuf_read() in the slow path, so treat
> > +		 * them as having a call for register save purposes.
> > +		 */
> > +		case (BPF_LD | BPF_ABS | BPF_B):
> > +		case (BPF_LD | BPF_ABS | BPF_H):
> > +		case (BPF_LD | BPF_ABS | BPF_W):
> > +		case (BPF_LD | BPF_IND | BPF_B):
> > +		case (BPF_LD | BPF_IND | BPF_H):
> > +		case (BPF_LD | BPF_IND | BPF_W):
> >  			ctx->foundcall = 1;
> > +			ctx->foundldmbuf = 1;  
> 
> Will set it for calls as well.
> 
> >  			return;
> >  		}
> >  	}
> >  }
> > 
> > +/*
> > + * Emit SUBS (extended register) for comparing with zero-extended halfword.
> > + * Used to compare: data_len - offset against size.
> > + * CMP (imm): SUBS Xd, Xn, #imm  
> 
> This whole comment confuses more than clarifies:
> * I believe CMP is a valid mnemonic in itself, no need to go too nerdy about this.
> * No idea what "zero-extended halfword" means here (maybe someone can help).
> * How it is being used belongs to the place of use, not function declaration.
> * There is no Xd in function arguments, so not sure what last line explains.
> 
> Comment to the next one is only marginally better. IMO before writing a comment
> AI should ask itself "what will be unclear here to the reader", not "what
> random facts I can add to make it look smarter".

The problem with AI text, is that it always thinks "more is better".
Which is wrong. More is more, and just adds confusion.

> 
> > + */
> > +static void
> > +emit_cmp_imm(struct a64_jit_ctx *ctx, bool is64, uint8_t rn, uint16_t imm12)
> > +{
> > +	uint32_t insn, imm;
> > +	int32_t simm;
> > +
> > +	imm = mask_imm(12, imm12);
> > +	simm = (int32_t)imm12;
> > +	insn = RTE_SHIFT_VAL32(is64, 31);
> > +	insn |= RTE_SHIFT_VAL32(1, 30); /* SUB */
> > +	insn |= RTE_SHIFT_VAL32(1, 29); /* set flags */
> > +	insn |= UINT32_C(0x11000000);
> > +	insn |= A64_ZR; /* Rd = ZR for CMP */
> > +	insn |= RTE_SHIFT_VAL32(rn, 5);
> > +	insn |= RTE_SHIFT_VAL32(imm, 10);
> > +
> > +	emit_insn(ctx, insn, check_reg(rn) || check_imm(12, simm));
> > +}
> > +
> > +/*
> > + * Emit a load from [rn + unsigned immediate offset].
> > + * LDR (unsigned offset): size determined by sz parameter.
> > + */
> > +static void
> > +emit_ldr_uimm(struct a64_jit_ctx *ctx, uint8_t sz, uint8_t rt, uint8_t rn,
> > +	       uint16_t uimm)
> > +{
> > +	uint32_t insn, scale, imm;
> > +	int32_t simm;
> > +
> > +	/* Determine scale from BPF size encoding */
> > +	if (sz == BPF_B)
> > +		scale = 0;
> > +	else if (sz == BPF_H)
> > +		scale = 1;
> > +	else if (sz == BPF_W)
> > +		scale = 2;
> > +	else /* EBPF_DW */
> > +		scale = 3;
> > +
> > +	/* imm12 is the offset divided by the access size */
> > +	imm = uimm >> scale;  
> 
> This is error-prone, need to either assert (maybe even static_assert) that uimm
> is a multiple of scale here, or accept already descaled number and deal with it
> at the place of call.
> 
> > +	simm = (int32_t)imm;  
> 
> This whole uimm -> imm -> simm logic is a bit hard to follow. Maybe my personal
> preference, but I'd get rid of at least simm, which is just an exact copy of
> imm with different type. It also makes one question if some edge cases with
> negative numbers are not overlooked.
> 
> > +
> > +	insn = RTE_SHIFT_VAL32(scale, 30);
> > +	insn |= UINT32_C(0x39400000); /* LDR (unsigned offset) base */
> > +	insn |= RTE_SHIFT_VAL32(mask_imm(12, imm), 10);
> > +	insn |= RTE_SHIFT_VAL32(rn, 5);
> > +	insn |= rt;
> > +
> > +	emit_insn(ctx, insn, check_reg(rt) || check_reg(rn) ||
> > +		  check_imm(12, simm) || check_ls_sz(sz));
> > +}  
> 
> These functions should probably integrate with and follow the style of existing
> ones like emit_cmp_tst/emit_cmp and emit_ls/emit_ldr. Even if deliberately
> duplicating some code, it should at least be copied verbatim, not re-invented.
> 
> Both function accept immediate as uint16_t for some reason, truncating it from
> uint32_t or size_t. This truncation does not seem to be checked explicitly.
> Should we accept ssize_t instead?
> 

All good observations.

The purpose of this patch was to get kickstart the process.
It is kind of what Linus and Andrew have done in the past to
get something out there to motivate a better solution.
