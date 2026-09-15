Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 328B6C88E53
	for <dpdk-dev@archiver.kernel.org>; Tue, 15 Sep 2026 13:20:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 73C4340DDC;
	Tue, 15 Sep 2026 15:20:33 +0200 (CEST)
Received: from mail-pz2-f25.google.com (mail-pz2-f25.google.com
 [74.125.228.25]) by mails.dpdk.org (Postfix) with ESMTP id 5417B406A2
 for <dev@dpdk.org>; Tue, 15 Sep 2026 15:20:32 +0200 (CEST)
Received: by mail-pz2-f25.google.com with SMTP id
 41be03b00d2f7-cc1cebad4aeso2853834a12.2
 for <dev@dpdk.org>; Tue, 15 Sep 2026 06:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789478431;
 x=1790083231; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=T+lmEmTRysZIsnz6krrmoC4z/ghIb0pp5bfkBb5YTdo=;
 b=wH1dTBv79r5MnRcFMm1VmEQnQVf5vtN1xYcmP2m2KlKJ7wCxjKb2aKFLXhkMsWCuLJ
 FXR1RlwHlI9S2GUIYtqjff2ZACZilYwe9IfwHXfgdNq5hplC1kB5lMyDLd3JAVOIsoiM
 6FAA2B4tHrgXuSRvROnTA4SQTVqDaZB//E9zKNJgtIayq4ygqO9DBXRyzFqEunok8kEi
 TYt13DHDeelBWcOSz8tvVrbGkiEWM0giS6oJeMfzuREkihFZd52m7MFMspKOAceA1CNc
 zwR9ixSme5Y5Lv5Mgogc9rVwzinbhJ60sm0N0GatuU6BMANDpU99t+Lc5GhLPNQW1Dsj
 gO0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789478431; x=1790083231;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=T+lmEmTRysZIsnz6krrmoC4z/ghIb0pp5bfkBb5YTdo=;
 b=yYqj0PS2na3XeDPK4c9tOh5qabr7WI6NrjLjAnSwEzrnksxZUK5p83xnZz6R4NM23Z
 zGdMMJAAcKpNCiwreB9Z9T8HQPK0W2oISVROri1Hq+PrVOBeSnFQao848I7HUNvLny18
 FTK63oScuafRB5/YqcAFKx+80MLDQHqXX+oDurrdmKL0bzrUuRQ2dr/1Kztm4GwLAP7j
 Fk+dMUKKgiSWYlP5Kd6u+5V+Q+HNI+fU+vRGDjjQ2lKK4RPNmPSnqlOEC32sUw1b1tWV
 K3Qjsj+7ouqe43OXaQ3UpIrRksxCsS+uto+U5jeiAmUnlX0augtqsh6Zcb4TZTf4m+vY
 APSg==
X-Gm-Message-State: AFuF++nSnzehRZHfR9PRSqnYbvV5GVR4B/6n+ONvy2pTP4xITySy2Hsd
 aLFXTOACD6a45nrXPt6fdr0HclcdYArU7bp6Qy5p4YaS3fvalhz1FZRZ679f/AIc5pQ=
X-Gm-Gg: AYBFou3gFYhvmcJYuDCiIhqJ0JOq/xJ8irSwsR+tGEAMMsM6b/6mlBoQ7Iv+W+9V6Zq
 mInDQd2MhQxd1WUSIeyO5Ic6oAFyL/IBis99OIb2sTL3QHtzcqfAS8X7QD0ULXmmfj9BsqEUeLj
 NLfDHFder47H2RbBDP/z5o3hORvlw2xQ6rmhFTe250ZMcYldrl/SwmLx+FrGbgX4kZPx2y5yF+o
 qSCoiyTcFxNN7qHw7MsnZ+uwCZX2TdPqBOOYu3ijU7FGTEQpH4oHeeoMpznhKV+KrPjNhhSYdGM
 al4ePFsi6zCBpFl+5/I6kmbkRvwn+JkRGiU+sdtn57hIq/UMtcIeOkB3W5f3evHGv0SjuS6JWJ2
 xOiknIzYClxL0lnNqwvRzog233IJ1YqYcAZ6J7Oc7HPc5Udt36TtJggdVCNAx9kTCEckHrNndnF
 lCM6cI2W7nOZzVpCk07QgSak0wtRJJIZsIdEBOd9onx3JkYtUIR1WqBydDgzmwEt/Ainqe+Bi6m
 XYuiNpmcLtEsW47dKlyOnnPL/phmfFwVNiZXR+d
X-Received: by 2002:a05:6a21:b94:b0:3d1:be60:2816 with SMTP id
 adf61e73a8af0-3db404f0f54mr18494670637.10.1789478431081; 
 Tue, 15 Sep 2026 06:20:31 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc4f6aa2767sm2654901a12.1.2026.09.15.06.20.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 06:20:30 -0700 (PDT)
Date: Tue, 15 Sep 2026 06:20:23 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Mattias =?UTF-8?B?UsO2bm5ibG9t?= <mattias.ronnblom@ericsson.com>
Cc: <dev@dpdk.org>, Mattias =?UTF-8?B?UsO2bm5ibG9t?= <hofors@lysator.liu.se>
Subject: Re: [RFC 1/1] eal/x86: replace inline assembly prefetch with cc
 builtins
Message-ID: <20260915062023.76099932@phoenix.local>
In-Reply-To: <20250223125215.358925-2-mattias.ronnblom@ericsson.com>
References: <20250223125215.358925-1-mattias.ronnblom@ericsson.com>
 <20250223125215.358925-2-mattias.ronnblom@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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

On Sun, 23 Feb 2025 13:52:15 +0100
Mattias R=C3=B6nnblom <mattias.ronnblom@ericsson.com> wrote:

> Implement the 32- and 64-bit x86 rte_prefetch<n>() functions and
> rte_prefetch_non_temporal() using compiler builtins, rather than
> inline assembly.
>=20
> This change frees the compiler to do certain optimizations that
> otherwise wouldn't be possible.
>=20
> Signed-off-by: Mattias R=C3=B6nnblom <mattias.ronnblom@ericsson.com>
> ---

I like this getting rid of asm is good.
AI review did spot some things worth addressing, I don't think benchmarking
is needed. But moving to arch neutral file is good idea.

Subject: Re: [RFC 1/1] eal/x86: replace inline assembly prefetch with cc bu=
iltins

The patch still applies cleanly to main. Codegen checked with gcc 13
at -O0 and -O2, x86_64 and -m32: locality 3/2/1/0 emits
prefetcht0/t1/t2/nta, identical to the current inline asm. Worth
resending as a non-RFC after the items below.

Warning

The comment in rte_prefetch_non_temporal() is a copy/paste leftover.
It says "1 sets target cache level to L3" but the call passes 0,
which GCC maps to prefetchnta.

The same four-line comment is repeated in every function. The
locality argument is also not a cache level; the mapping to
prefetcht0/t1/t2/nta is the x86 backend's choice. Replace with a
single comment above rte_prefetch0(), e.g.:

  /*
   * On x86, __builtin_prefetch() read hints with locality 3, 2, 1, 0
   * generate prefetcht0, prefetcht1, prefetcht2 and prefetchnta.
   */

The commit message says the change "frees the compiler to do certain
optimizations" without naming them. Say what inline asm blocks
(it is opaque to the optimizer; the pointer must be materialized and
loops containing it do not vectorize) and include either a codegen
example or benchmark numbers. Also state that the generated
instruction is unchanged.

Info

With this change the non-MSVC x86 code is the same as
lib/eal/loongarch/include/rte_prefetch.h. Consider providing the
__builtin_prefetch() versions in generic/rte_prefetch.h and letting
arch headers override only where needed (MSVC, arm, ppc). That drops
duplicate code in two arch headers.

Unlike the asm, __builtin_prefetch() emits nothing on 32-bit x86
when SSE is not enabled (e.g. -march=3Di686). Not a problem for DPDK
builds given the SSE4.2 baseline, but applications compiling the
headers with their own flags would silently lose the prefetch.
