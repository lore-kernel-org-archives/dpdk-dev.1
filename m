Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A3CFCAC5B9
	for <dpdk-dev@archiver.kernel.org>; Mon, 29 Sep 2025 16:28:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8A6DE40663;
	Mon, 29 Sep 2025 18:28:40 +0200 (CEST)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com
 [209.85.208.50]) by mails.dpdk.org (Postfix) with ESMTP id 7584A4064E
 for <dev@dpdk.org>; Mon, 29 Sep 2025 18:28:39 +0200 (CEST)
Received: by mail-ed1-f50.google.com with SMTP id
 4fb4d7f45d1cf-6365c5704ceso621443a12.0
 for <dev@dpdk.org>; Mon, 29 Sep 2025 09:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1759163319; x=1759768119; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=hm26wC994YLvhkHvRgJqKe8wUTKTxmZIqToSyhDM2NU=;
 b=dJnF1e/F5WiBSwNYrwns12DUp+hwuhjF+vlsL9PLs49YsGhrG80BsATTjO68WTpVp4
 oNZ0y/Kv/+r1LimUGZ1p25aOlmmuoMZzjbwzkfCFbTudPEkAJxcwgjHt1AGqnVb6todj
 MzK7VjqGe1W7+pLujSy73cd9epSgViWQidazEC3Q7HVqMIcGBuARELrNUPS3aLABKNIg
 pEN8GLUSFcLm24Spf7/0FhNhmn+2DbzFF4Ll7VcJK85pwcUg+qKvypDhu+sbdbTHGzM6
 rzpE8HMG3JYX8/oWb9GlFuCe84uoTcsalUxMnNSWBLaxTAgo3Ty51phRUdQ8lm+3kaNP
 fm5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759163319; x=1759768119;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hm26wC994YLvhkHvRgJqKe8wUTKTxmZIqToSyhDM2NU=;
 b=Rb1UjVvndxqfSutGIuNHBp2EZV9zrgA6y/GF46e5cKPs4Vk8rCfLKYv2fQDjznIhmn
 IgrcbapOseTKAJeQPvtR30xOuXqcYhh6m4KT59sUA//cXm2UVFVxhvNwbbP8dHFnmFU/
 J/v9Sm5pLjirIYhkx/i3YMjTdH6hJXvxfqSVWQb3o2TS+PIQwm42ai4YhueVLvY+lh9k
 cQYEwjViadBTwppB0G0VYzelLGkxjXuQYw8nZJL8Y/frdOP/GnJFwtAgcp0IpKrn8V4E
 nqyPJ0T91k5BitvHt0qwGx110ifw+sS2r+R/L6qaExEmVBkOFTTmALfH8lMzCo08U8hO
 5fyA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXwrhbeWpTjtnXZk9ZfIgK9i1a1l//FupdEIvTts7OhO8S8hIKcc4Q4r/FJvTZ/4xoc6MQ=@dpdk.org
X-Gm-Message-State: AOJu0YxCTtiJUnUKvqFoUYmJsLL3ZKhdTcdeZkXdzx38rChtBthRsSoo
 D6zcQei9eEVmMlPWIrkOI26mZN7TqAyWYOhJ4mxdj9LzKOLxMzYv/NFzHdvVFPBP6YSte3tlpEH
 Gh8CZFbWQCwe7Lk/Sn4+V7CUR7sl+ZNM=
X-Gm-Gg: ASbGnctFq/BmfddOLJt1Jk0NEszNBVJGA50qGgtaeWYSuzyUuDr+3TKedFNBpU6zVu5
 twUuyKjqEsVdln5GiarwCdPd5tNSpbc0hXWxBB1diTK9Ibsxd0V7l4Bo0CgngR8NYEtMAvoUEJw
 +qrfkFU9oriwP1OGbz7iibTygcfUDLvS6BjvHBT6+clnzGCd6qB9ItSxHTxdLIvx4Y3/0tL1ejh
 lBIBWo=
X-Google-Smtp-Source: AGHT+IFbsaqlHbrvKabyEiivJjRtsVQ1zqyLZGU+tuy2Hnto0jboI6mnmqTTjAlM9qtJHXP6uKPObpRtEQ9KJBsfsaA=
X-Received: by 2002:a05:6402:5622:b0:61c:8114:8832 with SMTP id
 4fb4d7f45d1cf-6349fa1c934mr12675563a12.16.1759163318818; Mon, 29 Sep 2025
 09:28:38 -0700 (PDT)
MIME-Version: 1.0
References: <20250716103439.831760-1-16567adigashreesh@gmail.com>
 <2664319.yIU609i1g2@thomas>
In-Reply-To: <2664319.yIU609i1g2@thomas>
From: Shreesh Adiga <16567adigashreesh@gmail.com>
Date: Mon, 29 Sep 2025 21:58:25 +0530
X-Gm-Features: AS18NWBCQEe4Bcm-KxIWVC3AGEG6sadezGYQT1Usm5izuM99cZHd33uK4CYzymU
Message-ID: <CA+-x59aDXS9-G=Yx3bUHj=XQX2Tjavkihu0w5r69P62y-g8Lpw@mail.gmail.com>
Subject: Re: [PATCH] net/crc: reduce usage of static arrays in net_crc_sse.c
To: Thomas Monjalon <thomas@monjalon.net>
Cc: Bruce Richardson <bruce.richardson@intel.com>, 
 Konstantin Ananyev <konstantin.v.ananyev@yandex.ru>, 
 Jasvinder Singh <jasvinder.singh@intel.com>, dev@dpdk.org
Content-Type: multipart/alternative; boundary="000000000000b85b55063ff32031"
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

--000000000000b85b55063ff32031
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 24, 2025 at 8:28=E2=80=AFPM Thomas Monjalon <thomas@monjalon.ne=
t> wrote:

> Hello,
>
> 16/07/2025 12:34, Shreesh Adiga:
> > Replace the clearing of lower 32 bits of XMM register with blend of
> > zero register.
> > Replace the clearing of upper 64 bits of XMM register with
> _mm_move_epi64.
> > Clang is able to optimize away the AND + memory operand with the
> > above sequence, however GCC is still emitting the code for AND with
> > memory operands which is being explicitly eliminated here.
> >
> > Additionally replace the 48 byte crc_xmm_shift_tab with the contents of
> > shf_table which is 32 bytes, achieving the same functionality.
> >
> > Signed-off-by: Shreesh Adiga <16567adigashreesh@gmail.com>
>
> Sorry I'm not following.
> Please could you start with defining the goal of this patch?
> Is it a code simplification or a performance optimization?

It is intended to be a minor performance optimization.

--000000000000b85b55063ff32031
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_quote gmail_quote_container"><div dir=
=3D"ltr" class=3D"gmail_attr">On Wed, Sep 24, 2025 at 8:28=E2=80=AFPM Thoma=
s Monjalon &lt;<a href=3D"mailto:thomas@monjalon.net">thomas@monjalon.net</=
a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0p=
x 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">He=
llo,<br>
<br>
16/07/2025 12:34, Shreesh Adiga:<br>
&gt; Replace the clearing of lower 32 bits of XMM register with blend of<br=
>
&gt; zero register.<br>
&gt; Replace the clearing of upper 64 bits of XMM register with _mm_move_ep=
i64.<br>
&gt; Clang is able to optimize away the AND + memory operand with the<br>
&gt; above sequence, however GCC is still emitting the code for AND with<br=
>
&gt; memory operands which is being explicitly eliminated here.<br>
&gt; <br>
&gt; Additionally replace the 48 byte crc_xmm_shift_tab with the contents o=
f<br>
&gt; shf_table which is 32 bytes, achieving the same functionality.<br>
&gt; <br>
&gt; Signed-off-by: Shreesh Adiga &lt;<a href=3D"mailto:16567adigashreesh@g=
mail.com" target=3D"_blank">16567adigashreesh@gmail.com</a>&gt;<br>
<br>
Sorry I&#39;m not following.<br>
Please could you start with defining the goal of this patch?<br>
Is it a code simplification or a performance optimization?</blockquote><div=
>It is intended to be a minor performance optimization.</div></div></div>

--000000000000b85b55063ff32031--
