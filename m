Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 159D4CD98C7
	for <dpdk-dev@archiver.kernel.org>; Fri, 12 Jun 2026 03:02:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 35D81432AA;
	Fri, 12 Jun 2026 05:02:22 +0200 (CEST)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com
 [209.85.218.54]) by mails.dpdk.org (Postfix) with ESMTP id 0D2444027F
 for <dev@dpdk.org>; Fri, 12 Jun 2026 05:02:21 +0200 (CEST)
Received: by mail-ej1-f54.google.com with SMTP id
 a640c23a62f3a-bef1e6423e7so59107966b.1
 for <dev@dpdk.org>; Thu, 11 Jun 2026 20:02:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781233340; cv=none;
 d=google.com; s=arc-20240605;
 b=IoUG5J/sILs2mgWh0oFgA3Fx3GrN+OpoEzqZUze+zwyVH5XjiLCTeL+s3Pivhf4qmm
 aL3ktl/VDWa3OwyGgMEQOVV5fA4PT81NLiJif3j531m4vYGxLNnU3ll+F6Eyjq0qwIJd
 Ta0QZFo+RQf42F1WSEbXoe2jBlQmQqkGUPvydrX028na0V8+0/3ZN3XTXeC20r8QyGue
 l6+AO1AaBdIDqqLPpyZBv5TGbDGUmiqOvKE9VEs82txgW+kvz+Uy1ZYWWvIwvcOr/MEE
 Hgemblx94CQJuth7zwFLJW0ooGN/M6oS9mdZTkqzLWnchCmq/VZsyEVPbuHUJshffXXy
 excg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=VvLSN6xPJpzEEl5r2+NIzlR0jPfz3YvZeHNY2BJUblE=;
 fh=M8xNWDaMrbFOHJsBsYkPSczreA0Zgf/SguluWTOFcwE=;
 b=Y5HqpU9RlncYU/R1QAU9vNIdCJ8ufHfSF7efc/MniRQFLAe6ueqGla+aHqj8tLP9SM
 a5LWKcszvkdwPRalcNSJE3zK7JjwdA181wzSTbV2Jd7Gb7nB9tRHOBLFu2Kgoq7dF9oS
 qDgUTV7NdbavwIWSwkNfXCi7wDUsd9DoSTo80gEheAKvBjlIs0pScxgQIBC40Pjb2q8i
 Cd/o3nDr0KjI2/Tk6wpZgbizXNl41pli68aXwV/zcCpyhVszBlxFPpoMWrixwep+XeE9
 kOs58RSdhC3uoKjShHdtu8lQXpRiEe53pb47wpzgl4AHPFZsRnaZNVzAEQ5hYnuKN4eH
 wVcA==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781233340; x=1781838140; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=VvLSN6xPJpzEEl5r2+NIzlR0jPfz3YvZeHNY2BJUblE=;
 b=Gc5tik1IHxthEzP5owmE9RK32lqkwyyxqVtHY5bCdWS0K3vwSOxWDW9hRBnq6XlXFz
 qvCZKU/fTKDjCpZcQSY3PcteY7dH2rWNO9fO9uv6BuagVZSTKiLcUWSINCZNMOjONrMn
 RpcI1WT0GQ12nAgW0qHO9k/AY3sX2usym24NxX+QcnKbLRxTXcW6oLlvub4e1AAr9ax0
 VD9ZqwLikDxBbLJamrDwIKCWwEFVN8iZ2c0wcF4hRD1ObZ2iagJ+2naxGbnQAGiV1+Rr
 6v6JqIVPCMGo9uxTNuW158LC+AdOgxuNfbepFA16P+DVWQtVIW5u3GzbMVjeGDWjHXFQ
 BMOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781233340; x=1781838140;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VvLSN6xPJpzEEl5r2+NIzlR0jPfz3YvZeHNY2BJUblE=;
 b=aKdMmLSjkgWErRwQXaNF3qKFqoPhRNG7WJwbNxxbS4fRcwRV+2Q+/p4cM3dM0pOQ1J
 6IIn+ndBTAod13K10z8DE97tn3TbTlwm5HqtjHLh8CPjg2vHy8P4hrHSn5OI57Jl2r7n
 p0RsKaJlma3Or59ZUJtW4z9tuQci1mAVcQwGda6BzHlmKDT7cEC5amgk0a/0HI4VbzXd
 GpQ87FnT3UAsIniHZZ5nx9yIshLq5Trae1uBtKOdAFXogCLN4X0kRBlZg9QhB8RnaTWa
 0n/nwJ2mANcR6+WkaqSShyvCZKgg/+HarXtjxN9zdNXZ+DJqvxjkrajUATfO5Ekhn6nV
 tNgg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9KhMQdEN8YTW9gyAj6/0M58ClFamF7Uf0x56lp8TNCdzWuGS7cI/tbT9SmQbKl+AGIIqg=@dpdk.org
X-Gm-Message-State: AOJu0YwFSQ1mKPs1WZiinDOdA4fczO0fEh8g5jmZs+DDCiXeI0XFvTEy
 8tD1k7gXwMgCItD4UPCBVzZJXaKX8BV8fHOR7eqYk82kB/GGrpC13BxW6CWGiif6ZRmGoduawhq
 YoQDCz/fuh+fEXiUHLz9aR2xtND9bul9HJPtRbRo=
X-Gm-Gg: Acq92OEuHvi+6US8XXhLqt3dSkDimltdYWhIXUIfYPW1SyS68VWmyJltWobzOdY1TIV
 eS+/cwbL5kTUiDA4YIPSaDN/r4U+KfqHi5+YULVntMQdNTVc+J+rL+/tJx3nhFKzyjg2XzPpfeH
 OoffXP5uEUX4Gl/au+JjVJVtK7aCxBJTOb65AIUc1xeX4NeV3xxlkGXO3rui4xs7UHUCvntTAQH
 XXVnBZ4HRqo1Tbc/eS7nQfMZ52/bdygiRJsZJ+jC+dr1toHOAnYTElXF7gakBktCBqE+0c16gX1
 o+3hHD9d
X-Received: by 2002:a17:907:6895:b0:bee:dce5:739d with SMTP id
 a640c23a62f3a-bfe2b9d0fd5mr16587566b.49.1781233340299; Thu, 11 Jun 2026
 20:02:20 -0700 (PDT)
MIME-Version: 1.0
References: <20260609075712.247286-1-16567adigashreesh@gmail.com>
 <20260611100611.17880d3b@phoenix.local>
In-Reply-To: <20260611100611.17880d3b@phoenix.local>
From: Shreesh Adiga <16567adigashreesh@gmail.com>
Date: Fri, 12 Jun 2026 08:32:09 +0530
X-Gm-Features: AVVi8Ce9jIPHQSN-JwTUmvUUYQmB90sQovXeB4a60TBlmjUugJuZui_n0QXaJwg
Message-ID: <CA+-x59Y0EozK0MdWc=SJ-XueQcS5wKkdDhUfx_9btuBr=o=Hzg@mail.gmail.com>
Subject: Re: [PATCH] net/crc: add 4x folding loop for x86 SSE implementation
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: Jasvinder Singh <jasvinder.singh@intel.com>, 
 Bruce Richardson <bruce.richardson@intel.com>, 
 Konstantin Ananyev <konstantin.ananyev@huawei.com>, dev@dpdk.org
Content-Type: multipart/alternative; boundary="00000000000082bdf2065405b4f6"
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

--00000000000082bdf2065405b4f6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 11, 2026 at 10:36=E2=80=AFPM Stephen Hemminger <
stephen@networkplumber.org> wrote:

> On Tue,  9 Jun 2026 13:27:12 +0530
> Shreesh Adiga <16567adigashreesh@gmail.com> wrote:
>
> > Add a 64-byte loop that maintains 4 fold registers and processes
> > 64 bytes at a time. The 4x fold registers is then reduced to 16 byte
> > single fold, similar to AVX512 implementation. This technique is
> > described in the paper by Intel:
> > "Fast CRC Computation for Generic Polynomials Using PCLMULQDQ
> Instruction"
> >
> > This results in roughly 50% performance improvement due to better ILP
> > for large input sizes like 1024.
> >
> > Signed-off-by: Shreesh Adiga <16567adigashreesh@gmail.com>
> > ---
>
> Looks good applied to next-net.
>
> A couple of nits from more detailed AI review, that you still might want
> to look at:
>
> The current crc_autotest does not exercise the new 64-byte CRC16 path.
> Its CRC32 vectors are 1512 and 348 bytes, so the CRC32 4x loop is
> covered =E2=80=94 but the largest CRC16 vector is 32 bytes, all three CRC=
16
> tests being =E2=89=A432. So the new CRC16 rk1_rk2 (64-byte fold) constant=
s ship
> untested in CI. My exhaustive test confirms they're correct, but a
> future regression there wouldn't be caught. Suggest adding a CRC16
> vector =E2=89=A564 bytes, ideally a non-multiple of 64 (e.g. 80 or 100) s=
o it
> hits the 4x loop, the single-fold tail, and the partial-bytes path
> together.
>
> In partial_bytes the comment /* k =3D rk1 & rk2 */ is now stale
>  =E2=80=94 after the patch k holds rk3_rk4 on every path reaching it.
> Not introduced by this patch, but the patch is what made it wrong;
> worth fixing in passing.
>
> I've submitted couple of follow up patches that should address the above:
https://patches.dpdk.org/project/dpdk/patch/20260612023745.275608-1-16567ad=
igashreesh@gmail.com/
https://patches.dpdk.org/project/dpdk/patch/20260612025135.298226-1-16567ad=
igashreesh@gmail.com/

--00000000000082bdf2065405b4f6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Jun 11,=
 2026 at 10:36=E2=80=AFPM Stephen Hemminger &lt;<a href=3D"mailto:stephen@n=
etworkplumber.org">stephen@networkplumber.org</a>&gt; wrote:<br></div><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:=
1px solid rgb(204,204,204);padding-left:1ex">On Tue,=C2=A0 9 Jun 2026 13:27=
:12 +0530<br>
Shreesh Adiga &lt;<a href=3D"mailto:16567adigashreesh@gmail.com" target=3D"=
_blank">16567adigashreesh@gmail.com</a>&gt; wrote:<br>
<br>
&gt; Add a 64-byte loop that maintains 4 fold registers and processes<br>
&gt; 64 bytes at a time. The 4x fold registers is then reduced to 16 byte<b=
r>
&gt; single fold, similar to AVX512 implementation. This technique is<br>
&gt; described in the paper by Intel:<br>
&gt; &quot;Fast CRC Computation for Generic Polynomials Using PCLMULQDQ Ins=
truction&quot;<br>
&gt; <br>
&gt; This results in roughly 50% performance improvement due to better ILP<=
br>
&gt; for large input sizes like 1024.<br>
&gt; <br>
&gt; Signed-off-by: Shreesh Adiga &lt;<a href=3D"mailto:16567adigashreesh@g=
mail.com" target=3D"_blank">16567adigashreesh@gmail.com</a>&gt;<br>
&gt; ---<br>
<br>
Looks good applied to next-net.<br>
<br>
A couple of nits from more detailed AI review, that you still might want to=
 look at:<br>
<br>
The current crc_autotest does not exercise the new 64-byte CRC16 path.<br>
Its CRC32 vectors are 1512 and 348 bytes, so the CRC32 4x loop is<br>
covered =E2=80=94 but the largest CRC16 vector is 32 bytes, all three CRC16=
<br>
tests being =E2=89=A432. So the new CRC16 rk1_rk2 (64-byte fold) constants =
ship<br>
untested in CI. My exhaustive test confirms they&#39;re correct, but a<br>
future regression there wouldn&#39;t be caught. Suggest adding a CRC16<br>
vector =E2=89=A564 bytes, ideally a non-multiple of 64 (e.g. 80 or 100) so =
it<br>
hits the 4x loop, the single-fold tail, and the partial-bytes path<br>
together.<br>
<br>
In partial_bytes the comment /* k =3D rk1 &amp; rk2 */ is now stale<br>
=C2=A0=E2=80=94 after the patch k holds rk3_rk4 on every path reaching it.<=
br>
Not introduced by this patch, but the patch is what made it wrong;<br>
worth fixing in passing.<br>
<br></blockquote><div>I&#39;ve submitted couple of follow up patches that s=
hould address the above:</div><div><a href=3D"https://patches.dpdk.org/proj=
ect/dpdk/patch/20260612023745.275608-1-16567adigashreesh@gmail.com/">https:=
//patches.dpdk.org/project/dpdk/patch/20260612023745.275608-1-16567adigashr=
eesh@gmail.com/</a></div><div><a href=3D"https://patches.dpdk.org/project/d=
pdk/patch/20260612025135.298226-1-16567adigashreesh@gmail.com/">https://pat=
ches.dpdk.org/project/dpdk/patch/20260612025135.298226-1-16567adigashreesh@=
gmail.com/</a>=C2=A0</div></div></div>

--00000000000082bdf2065405b4f6--
