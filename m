Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28765CCFA18
	for <dpdk-dev@archiver.kernel.org>; Sat,  8 Nov 2025 12:59:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0EDAE40261;
	Sat,  8 Nov 2025 13:59:36 +0100 (CET)
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com
 [209.85.222.175])
 by mails.dpdk.org (Postfix) with ESMTP id 44DA540264
 for <dev@dpdk.org>; Fri,  7 Nov 2025 10:51:43 +0100 (CET)
Received: by mail-qk1-f175.google.com with SMTP id
 af79cd13be357-8906eb94264so62950485a.0
 for <dev@dpdk.org>; Fri, 07 Nov 2025 01:51:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762509102; x=1763113902;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mTIj8EliqdXUWa0KGp4Jy/hf1p1P+uPkiIWQFfZ64Xo=;
 b=NkEG8F6s9UfMNIQcOWkMwG2L2ShK1jztF5ZhDUBGAwJd0sq6abiUPsgHyb4nTXzouH
 pOvO/gRqfXpjwmNxq1bY5JetW+pQLPpfoPXAvgC2Zsp/TMkg6O0JYtq4JlzWGCgtgK0u
 4jnArB2yQ0AVFB7bA9ZRXuuzsMRN4eDHTI1N0HGP5B3WIf8xUwPtda2ZM4/F4HyNHgKu
 QLVOapHyuuJcQYjJekQaxmr5UUjy/vBsx2uz2jWHVlkdPyrOTakKbHFalTa/yKoPoZYx
 fSmnLA/QvHaprvpm8ecbsHJ1w1n2TaCLtFCdcxLq8a/duIIQvq8n6QjXCm/idGlDJ2+H
 qmXw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWpEGomSnAM8yISqSZTKElZHKXkxM2ga32biG3I9pAeZ94nPPQhL9EI3Di7pY3Mdl+uYlk=@dpdk.org
X-Gm-Message-State: AOJu0YylrfXX0b1zOxnUaO+6b7ZpdlzirL/zseQqtaCCoNZCgPC34o50
 gJo5urNDjOAl2V2D3LKqx0gHyEPCz6QV/VOBcwaOjfPrDlNQPfHYu5chLbGb9UkRi9FaoUkLU1q
 WbkKZnERwR6pXREwJ/rFmTon0B5Gyg4s=
X-Gm-Gg: ASbGnctFNDHECM925PNK6lmx5SNZ0EW75/RCSDcvdlbT05wUEc9uDXyjq+jO9cgzez0
 c7IEkMPEUN9nAzSSlehyU7c0Exh22CiFay140lVfUp4nOrHG8Y738fgM/h/zLxkYisUITttJbdK
 ZxW6Lgf8eKPuo5xDKwzmP8+xm/f5MGLshZ/P3Cl43BlGFaG6P4+aUmRMehh8c5U+OgIPzS18q3w
 BV2vIzZrFeR7mxf6FshTp3T4rX3nLVFSUxQWf1s6c0uT5AB4JXV+AddHq1rmqK+wYRGYDNMiBjR
 qD57T2cMH1ggfdCFrQ==
X-Google-Smtp-Source: AGHT+IFxC5VlQQYivM2sz9s3MICTdv9CSiW7yD7GN+I9RNS48FcrOh2Ce7aa9NsQAl6BiF7yiMS6Ff+7obkKJJra3W4=
X-Received: by 2002:a05:620a:1aa2:b0:84a:d3ce:c749 with SMTP id
 af79cd13be357-8b2453520b1mr301017185a.64.1762509102474; Fri, 07 Nov 2025
 01:51:42 -0800 (PST)
MIME-Version: 1.0
References: <20251106163807.201451-1-hemant.agrawal@nxp.com>
 <20251106163807.201451-2-hemant.agrawal@nxp.com>
 <20251106112911.0c50107b@phoenix>
In-Reply-To: <20251106112911.0c50107b@phoenix>
From: Maxime Leroy <maxime@leroys.fr>
Date: Fri, 7 Nov 2025 10:51:31 +0100
X-Gm-Features: AWmQ_bm__hLfi56Cez46NQYRDr2Bo_tUeEclA3hyVwHkxJt2bfdnNSSZzLtvSnc
Message-ID: <CAHHRULVJe45=gNq1in6eHo5yEq-+QguxeDGfVHeC8D3KgMDdqQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] net/dpaa2: clear active VDQ state when freeing Rx
 queues
To: stephen@networkplumber.org
Cc: Hemant Agrawal <hemant.agrawal@nxp.com>, dev@dpdk.org, jun.yang@nxp.com,
 stable@dpdk.org
Content-Type: multipart/alternative; boundary="000000000000f768eb0642fe2062"
X-Mailman-Approved-At: Sat, 08 Nov 2025 13:59:34 +0100
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

--000000000000f768eb0642fe2062
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le jeu. 6 nov. 2025, 20:29, Stephen Hemminger <stephen@networkplumber.org>
a =C3=A9crit :

> On Thu,  6 Nov 2025 22:08:06 +0530
> Hemant Agrawal <hemant.agrawal@nxp.com> wrote:
>
> > +static void
> > +dpaa2_clear_queue_active_dps(struct dpaa2_queue *q, int num_lcores)
> > +{
> > +     int i;
> > +
> > +     for (i =3D 0; i < num_lcores; i++) {
> > +             struct queue_storage_info_t *qs =3D q->q_storage[i];
> > +
> > +             if (!qs)
> > +                     continue;
> > +
> > +             if (qs->active_dqs) {
> > +                     clear_swp_active_dqs(qs->active_dpio_id);
> > +                     qs->active_dqs =3D NULL;
> > +             }
> > +     }
> > +}
> > +
>
> Why not use RTE_LCORE_FOREACH() here?
>

For the loop, I did it the same way as in dpaa2_queue_storage_alloc(), to
stay aligned with the rest of the driver instead of using
RTE_LCORE_FOREACH().

Thanks Hemant for upstreaming my patch. However, you added my email in
.mailmap as a new entry =E2=80=94 it should instead be added as a second em=
ail
under the existing Maxime Leroy entry.

>

--000000000000f768eb0642fe2062
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">Le jeu. 6 nov. 2025, 20:29, Step=
hen Hemminger &lt;<a href=3D"mailto:stephen@networkplumber.org">stephen@net=
workplumber.org</a>&gt; a =C3=A9crit=C2=A0:<br></div><blockquote class=3D"g=
mail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-l=
eft:1ex">On Thu,=C2=A0 6 Nov 2025 22:08:06 +0530<br>
Hemant Agrawal &lt;<a href=3D"mailto:hemant.agrawal@nxp.com" target=3D"_bla=
nk" rel=3D"noreferrer">hemant.agrawal@nxp.com</a>&gt; wrote:<br>
<br>
&gt; +static void<br>
&gt; +dpaa2_clear_queue_active_dps(struct dpaa2_queue *q, int num_lcores)<b=
r>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0int i;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt; num_lcores; i++) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct queue_storage_=
info_t *qs =3D q-&gt;q_storage[i];<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!qs)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0continue;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (qs-&gt;active_dqs=
) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0clear_swp_active_dqs(qs-&gt;active_dpio_id);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0qs-&gt;active_dqs =3D NULL;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +}<br>
&gt; +<br>
<br>
Why not use RTE_LCORE_FOREACH() here?<br></blockquote></div></div><div dir=
=3D"auto"><br></div><div dir=3D"auto">For the loop, I did it the same way a=
s in dpaa2_queue_storage_alloc(), to stay aligned with the rest of the driv=
er instead of using RTE_LCORE_FOREACH().</div><div dir=3D"auto"><br></div><=
div dir=3D"auto">Thanks Hemant for upstreaming my patch. However, you added=
 my email in .mailmap as a new entry =E2=80=94 it should instead be added a=
s a second email under the existing Maxime Leroy entry.</div><div dir=3D"au=
to"><div class=3D"gmail_quote gmail_quote_container"><blockquote class=3D"g=
mail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-l=
eft:1ex">
</blockquote></div></div></div>

--000000000000f768eb0642fe2062--
