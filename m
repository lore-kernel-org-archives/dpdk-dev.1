Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C22D5CAC5BB
	for <dpdk-dev@archiver.kernel.org>; Wed,  1 Oct 2025 10:25:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 707B540B91;
	Wed,  1 Oct 2025 12:25:05 +0200 (CEST)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com
 [209.85.218.53]) by mails.dpdk.org (Postfix) with ESMTP id 08595406B6
 for <dev@dpdk.org>; Wed,  1 Oct 2025 12:25:04 +0200 (CEST)
Received: by mail-ej1-f53.google.com with SMTP id
 a640c23a62f3a-b3f5e0e2bf7so598388466b.3
 for <dev@dpdk.org>; Wed, 01 Oct 2025 03:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1759314303; x=1759919103; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=doRjdA8Knb0gAZfsk8cMcFz/+fDV9dmS1kiNseWLgVU=;
 b=Vc90ugNWJGCogbpjg2QrxXodSTDtdiXVvbjxadrbD0Y/apCws21igWVujSB25KvxlE
 6nzVQO3AWY9WCO1B3WKCRGbWkNPJhsL7adjjhVqAgnJ7383DyjQwfqcG0urgXzqYgTzs
 jQbq8mvVAAKS6OvecNgvzmLp8O+SZaKm5C96Ee7R1QN2g+Tm16GR3w7h1eGZrvhgb7RC
 /uuQujyYwA5oI2buB3QE+w1JDFXJQhmaInF9BRu+mMnWbZoLbus67RQHodztCxtRsFMt
 bV18RZkSMKcgkLHVICWYSnLjcvUguVqEoSQzXdguIaIgQzO+2DI2eGkbKNXPC60dXZ6l
 0rQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759314303; x=1759919103;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=doRjdA8Knb0gAZfsk8cMcFz/+fDV9dmS1kiNseWLgVU=;
 b=ZyeYlXmcAtaEJUHSosiOU8xnLKuHDWy4qLLsYshUJR1NYnU9iMjYdzJ3fQ/SW6ARBJ
 3CqFQe1E291+8V80hbEoLrrdCnI+YkwOfB1mjnSMOQuqXfk4PoDkkml/cr3frsH8rfS3
 i3nqM37E7mKhUuShxlChR/8fCdFHL6is/0yrXk0v03YN/o2ghGwbZouuf1J3536bmp7K
 oCN+R3EnaGv2t5KpzdngaHsD4aqMRauyHOereU5wHrv9ZXlDoZDdbVRAd8z9CtmPnUIt
 NDaR7dVdsq5N55s/eDBdSYvfmZhtMbE8ib8LQfhnp0RK77YrUPuih1nZh5Rn6jBGAZ4A
 Ucmg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU0KdQcxQWPqHBw3rIwjOWF9mmitEuNVZjAy1p2m14JXPXMOrq/Ve/nsrrHC0ygpueFbho=@dpdk.org
X-Gm-Message-State: AOJu0Yw4aF8QAwOajBauSd8tJHthAgPfn0wQ1Z1zwg5JT4u2OtbPg0ox
 FZM2Zl0qbrKQ4wODWsMXdN5NYWvr9ZlaGaCnDZDwZ6Oy4Y7t6tpKOLLEM8I3GUDThk+LnK/OpV0
 mujkeQy/R78dy6IOzwnllk44NxmPNzmM=
X-Gm-Gg: ASbGnct0svdZS1XqvdNICDgJtkvWzEBVK7907EmfW3O2lsomY86bcoOEqe1c8O+796X
 pebpdn9kky5pA8h5ClxssVZ9uWE7dnvhJPWwPfIk+uqrGvpCKCO38vCFXEoWr+Q58waHsgXLxxN
 77JSUhoq0KWIblPr05WcprUocJ1XQhrIbmDlquEi8HDbRqfriQNK4tL55eU1ZYj7cDsXtgySV+W
 LLfghZaURh8UzF9RMOmCO96HpVBi1o=
X-Google-Smtp-Source: AGHT+IH3xnBNVD9IW2Oui2L+V8qDib9LweQLCwVQUCw0007+2WOX1pqX4a97+u467tDByTUiY8npsjnlz9rUTGocIWU=
X-Received: by 2002:a17:907:7f14:b0:b42:f820:b7c with SMTP id
 a640c23a62f3a-b46e82a2cfemr310616866b.41.1759314303144; Wed, 01 Oct 2025
 03:25:03 -0700 (PDT)
MIME-Version: 1.0
References: <20250716103439.831760-1-16567adigashreesh@gmail.com>
 <2664319.yIU609i1g2@thomas>
 <CA+-x59aDXS9-G=Yx3bUHj=XQX2Tjavkihu0w5r69P62y-g8Lpw@mail.gmail.com>
 <7068093.UjTJXf6HLC@thomas>
In-Reply-To: <7068093.UjTJXf6HLC@thomas>
From: Shreesh Adiga <16567adigashreesh@gmail.com>
Date: Wed, 1 Oct 2025 15:54:52 +0530
X-Gm-Features: AS18NWB6gsoeXWgbT3I-_zcnA5ohKNFMReEGwFKgx5Zyhl2SekMWISnAuoc0HGI
Message-ID: <CA+-x59aZzXLWACV17OaHCyUU_WnqfdGdJqjJqMeHmLX49G_2mg@mail.gmail.com>
Subject: Re: [PATCH] net/crc: reduce usage of static arrays in net_crc_sse.c
To: Thomas Monjalon <thomas@monjalon.net>
Cc: Bruce Richardson <bruce.richardson@intel.com>, 
 Konstantin Ananyev <konstantin.v.ananyev@yandex.ru>, 
 Jasvinder Singh <jasvinder.singh@intel.com>, dev@dpdk.org
Content-Type: multipart/alternative; boundary="0000000000001664160640164879"
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

--0000000000001664160640164879
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 1, 2025 at 1:25=E2=80=AFPM Thomas Monjalon <thomas@monjalon.net=
> wrote:

> 29/09/2025 18:28, Shreesh Adiga:
> > On Wed, Sep 24, 2025 at 8:28=E2=80=AFPM Thomas Monjalon <thomas@monjalo=
n.net>
> wrote:
> >
> > > Hello,
> > >
> > > 16/07/2025 12:34, Shreesh Adiga:
> > > > Replace the clearing of lower 32 bits of XMM register with blend of
> > > > zero register.
> > > > Replace the clearing of upper 64 bits of XMM register with
> > > _mm_move_epi64.
> > > > Clang is able to optimize away the AND + memory operand with the
> > > > above sequence, however GCC is still emitting the code for AND with
> > > > memory operands which is being explicitly eliminated here.
> > > >
> > > > Additionally replace the 48 byte crc_xmm_shift_tab with the content=
s
> of
> > > > shf_table which is 32 bytes, achieving the same functionality.
> > > >
> > > > Signed-off-by: Shreesh Adiga <16567adigashreesh@gmail.com>
> > >
> > > Sorry I'm not following.
> > > Please could you start with defining the goal of this patch?
> > > Is it a code simplification or a performance optimization?
> >
> > It is intended to be a minor performance optimization.
>
> Please could you give some performance numbers in the commit log?
>
I don't think that this change can be reliably measured. The changes only
impact
the last stage crc 64 to 32 fold and the last 16 bytes computation. The
impact will only
be a couple of clock cycles at best. Reducing the static array usage also I
don't know
if it can be reliably measured especially since it is not affecting the
main loop.
This patch can be ignored if minor incremental changes are not desirable.

--0000000000001664160640164879
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Oct 1, =
2025 at 1:25=E2=80=AFPM Thomas Monjalon &lt;<a href=3D"mailto:thomas@monjal=
on.net">thomas@monjalon.net</a>&gt; wrote:<br></div><blockquote class=3D"gm=
ail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,=
204,204);padding-left:1ex">29/09/2025 18:28, Shreesh Adiga:<br>
&gt; On Wed, Sep 24, 2025 at 8:28=E2=80=AFPM Thomas Monjalon &lt;<a href=3D=
"mailto:thomas@monjalon.net" target=3D"_blank">thomas@monjalon.net</a>&gt; =
wrote:<br>
&gt; <br>
&gt; &gt; Hello,<br>
&gt; &gt;<br>
&gt; &gt; 16/07/2025 12:34, Shreesh Adiga:<br>
&gt; &gt; &gt; Replace the clearing of lower 32 bits of XMM register with b=
lend of<br>
&gt; &gt; &gt; zero register.<br>
&gt; &gt; &gt; Replace the clearing of upper 64 bits of XMM register with<b=
r>
&gt; &gt; _mm_move_epi64.<br>
&gt; &gt; &gt; Clang is able to optimize away the AND + memory operand with=
 the<br>
&gt; &gt; &gt; above sequence, however GCC is still emitting the code for A=
ND with<br>
&gt; &gt; &gt; memory operands which is being explicitly eliminated here.<b=
r>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Additionally replace the 48 byte crc_xmm_shift_tab with the =
contents of<br>
&gt; &gt; &gt; shf_table which is 32 bytes, achieving the same functionalit=
y.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Signed-off-by: Shreesh Adiga &lt;<a href=3D"mailto:16567adig=
ashreesh@gmail.com" target=3D"_blank">16567adigashreesh@gmail.com</a>&gt;<b=
r>
&gt; &gt;<br>
&gt; &gt; Sorry I&#39;m not following.<br>
&gt; &gt; Please could you start with defining the goal of this patch?<br>
&gt; &gt; Is it a code simplification or a performance optimization?<br>
&gt; <br>
&gt; It is intended to be a minor performance optimization.<br>
<br>
Please could you give some performance numbers in the commit log?<br></bloc=
kquote><div>I don&#39;t think that this change can be reliably measured. Th=
e changes only impact</div><div>the last stage crc 64 to 32 fold and the la=
st 16 bytes computation. The impact will only</div><div>be a couple of cloc=
k cycles at best. Reducing the static array usage also I don&#39;t know</di=
v><div>if it can be reliably measured especially since it is not affecting =
the main loop.</div><div>This patch can be ignored if minor incremental cha=
nges are not desirable.</div><div>=C2=A0</div></div></div>

--0000000000001664160640164879--
