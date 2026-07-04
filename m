Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAF7BC43458
	for <dpdk-dev@archiver.kernel.org>; Sat,  4 Jul 2026 16:12:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9F164402C6;
	Sat,  4 Jul 2026 18:12:09 +0200 (CEST)
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com
 [209.85.216.52]) by mails.dpdk.org (Postfix) with ESMTP id E51474021F
 for <dev@dpdk.org>; Sat,  4 Jul 2026 18:12:07 +0200 (CEST)
Received: by mail-pj1-f52.google.com with SMTP id
 98e67ed59e1d1-3817f800c8bso936268a91.1
 for <dev@dpdk.org>; Sat, 04 Jul 2026 09:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1783181527;
 x=1783786327; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pdH3iFZxbn8xK4YC0VpKnosblqwT6El8yEVtJ1+tPU8=;
 b=pUnkgwtluB9ZgS2phO53w0iBedrYsesT56P0cxvAoAxfZfZB5YiS5HJLP6rHNmZaJG
 s8yopTTB+slXdM3lHeYzIDKZq8WWhi0Qp0VhzcKrEnjoQaZlO167DIb9T5bunckRimLd
 c0GW804fRIxSLgQkxnzK1tDw7zy2l+pJLWFN0aZ/FQcDLc/j0w4YOjzdMhgQ8dEVg3Rh
 DQUMTaVHl1VRcn+HwPcjF0gXtgUmVL5no3vim/R6hNKh4xfDPSbXAVlqnJ+jJpo7txl1
 m4BXv8M21rMvkjq6ETM9mVJgYZNb7FqVuR0auegP+HnHptzyKdRO58RGzrwxsoVIczNE
 8pJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783181527; x=1783786327;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pdH3iFZxbn8xK4YC0VpKnosblqwT6El8yEVtJ1+tPU8=;
 b=FATNKHCXqSjAh5oIZcdotZEWB5T6dbWoXXJtcLdw6SonoSmufSBXx5eI8xddYkDFMj
 hwwOJbM8hrJK0L0EwAzqxLS4MdZ1FDcE3qDe6mTU/Hah5zf5ZoRRixVSTcqz3YgC5Dra
 b38T3y9PX/lWxg4vvmRKRXDe3GsJ3xZRLKaZWLh5IAADWIifHA8ARq00lwfpAg/CkkjW
 QH1IQWdCFjbDCj/osvoG7XlNGSr+mLM/K2RnskvUfelKoaDVeUtzfXC0hJfXGm2ZF6ZU
 wnU5QuJgIq4rfUqjzBGMQKrOHN4iCWl11G8P7OWXOtakHSYRO1NSEtNZcECRHjlKRqSc
 rX4A==
X-Gm-Message-State: AOJu0YzVTrxHTuAlfpkzmmvGq3l/BjcxXkweC3+4F3RH/B+KqxyvPhNb
 d9s+jU+98sCGh+3SFmD5p5UPLwUCsi1wAsYzGKzsGBaMmQGEVWA+hLp1wzoKJcE1P5/AsQCxsAU
 GcPeP
X-Gm-Gg: AfdE7cmlyPlOZ3l6d2vzVxYlqIE8NKjQcckY1cMNrE3PNHuDv43hLpCILePEyMsZ6NT
 oPs8y1ti7fJS7DzDJfRIAGDW/Dof1dTEqCWUAy12HPi7wjBi22L2nj+KM5ahnipK7oi4NpWqshD
 7quDC5sGHwmZbmnjK2uapQZuJbt91D/XZmiXQScK9J/lAfwrPHJvJsXq2er9WRZsPqIzfzM2ztN
 R/E6AT0MQmYhG4T1We7W58IREV6hpPXZzr2Os3inQp8Cpbovwp/xIttnCqTqKifEwX428alWdgu
 XoFy5FB9adB2t/EZ86TIxT+9FAWF5ebd4BP5/gFFgUuIWOmc8MGHcWibYVXEZ1+2nZLSrqB9w1M
 SNxpGYXEYbUOOKoyRGi97hmjRjAnue3EfqSUpkaat1218s/Jy//LiBDdZEkElU9YnXtmSWAFmrR
 odmdgaOgzcno62YykMPpAdco49i8zLzzDT/c33opJwFdwGZbpkitwCUSbzZwoPZbcV
X-Received: by 2002:a17:90b:384b:b0:37f:ceed:e1d8 with SMTP id
 98e67ed59e1d1-38280e98d05mr3703422a91.12.1783181526740; 
 Sat, 04 Jul 2026 09:12:06 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b446a766asm34397458c88.7.2026.07.04.09.12.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Jul 2026 09:12:06 -0700 (PDT)
Date: Sat, 4 Jul 2026 09:12:04 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Konstantin Ananyev <konstantin.ananyev@huawei.com>, Marat Khalili
 <marat.khalili@huawei.com>
Subject: Re: [PATCH] bpf: fix unitialized warning
Message-ID: <20260704091204.132d8a86@phoenix.local>
In-Reply-To: <20260704040322.157058-1-stephen@networkplumber.org>
References: <20260704040322.157058-1-stephen@networkplumber.org>
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

On Fri,  3 Jul 2026 21:03:22 -0700
Stephen Hemminger <stephen@networkplumber.org> wrote:

> Coverity complains unitialized use of structure.
> 
> Coverity ID: 504611
> Fixes: 17509d474226 ("bpf/validate: fix BPF_ADD of pointer to a scalar")
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---

Ignore AI review of this patch. The CI AI review is using weak AI
model and no tooling; it ends up hallucinating about code that doesn't exist.
Better AI reviewing the reviewer sees...

Coverity 504611 is a true positive. eval_fill_max_bound() sets u, s,
v.type, and mask, but not v.size or v.buf_size. In eval_add() the
pointer+pointer path does eval_fill_max_bound(&rs_buf, msk); *rd =
rs_buf; on a fresh local, so the struct copy propagates the
uninitialized v.size/v.buf_size. Zero-init at declaration closes
exactly that.

The AI review is quoting code that isn't there. eval_add() has no
rs_buf = *rs; and no eval_apply_mask(&rs_buf, ...) call. That snippet
looks reconstructed from the diff hunk header (eval_apply_mask, the
preceding function) rather than the function actually being patched.
Its central claim, that rs_buf is only touched via rs = &rs_buf inside
the if, is wrong: the uninitialized read is the *rd = rs_buf copy, and
rs then reads it after the block. 
