Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D10ECCA5FC7
	for <dpdk-dev@archiver.kernel.org>; Wed, 30 Sep 2026 15:37:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E0658427A1;
	Wed, 30 Sep 2026 17:37:53 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 9F85D40278
 for <dev@dpdk.org>; Wed, 30 Sep 2026 17:37:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790782664;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3N4d5Z0pMdSZh8oR7eKNB1f+i0IQlELxEWS+/0f6A4g=;
 b=PLIHOP4OfDGWWgdZZ4vp2uLl+3PsnjDScLfhZZnMEglkZ8a4Hy+7QIMxzU/gpXmygscdUK
 O2prStdWCcJVrRueddxPEPVRJDFDSfAFn3aqvzhvwBL6TBjSter/XUEvmMnfdEcrHBm25U
 MnwNBuIN6W9ZNod7uduQwmvofRUzG7E=
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-317-gEM9D8gpNNekDMFI798Dwg-1; Wed, 30 Sep 2026 11:37:41 -0400
X-MC-Unique: gEM9D8gpNNekDMFI798Dwg-1
X-Mimecast-MFC-AGG-ID: gEM9D8gpNNekDMFI798Dwg_1790782661
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-343eadc0ff3so891910eec.1
 for <dev@dpdk.org>; Wed, 30 Sep 2026 08:37:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790782661; x=1791387461;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=3N4d5Z0pMdSZh8oR7eKNB1f+i0IQlELxEWS+/0f6A4g=;
 b=EjSf5crWndgmPvH2yEpIJVbCM2BDJC2xioeeNEPi8gNlLHcIpF9ub5mENFOXBrRwAd
 wtH4IAeFTdIN7v/IjIHtJTZ2vqKs5zl/sb0ivGQaS1O/YvUe1gyzxFplvoM8L7L+p8Qa
 IoUthbo9XZpdbK6ouItFLMI5fo/2I1xpHFQlGT4zFa7wRL52ofaGCaGkntEk6cVsgSYP
 FYSqasxVNBqWrNQ3WAJE62m1CYkyXl2vjvLtUbCGPk8a0bPV8sXrGEic5NwHJZB6P+Cq
 e+4dAHdAWtaDoaj3AiUTiV510lJMipCbMzx+KeYlUx5nQ8xVtlxWpkrg+cNFXKQSsJtt
 6YtA==
X-Gm-Message-State: AFuF++kxgxbSTKcPgte1EnL6kRA9BKpiOimxdCv93o4ByfPVln1vihO1
 A/qsarksc/EHtItmtHIptooZvDV8rpBOM8y/at0v/4djt42ctlcM/TdXVJyEiO33GqpvdHzFdv1
 FOC/atjzm7n0MjXD7mKEnKA5wuwYkveTqGgQoCldl6RVu7Zv8IzSg2+M33PZufML/YyriJXBmrN
 wRodk1OZJEQWWuIOIHPjk=
X-Gm-Gg: AYBFou2CVE4W9IZrWv4dPO7l+xDcCBP43gD65MVE4K2MeO36TraJS3yG0Y6gZF5Q2RI
 gDPLFj7+MaildFwcWlQ72FwrZ/2GDmjEM27gJ7MvFXDUgUleeT4x0ugFpTluHxQSHHUTNDlfpBh
 x1MhZiJz0qyC9wrLTlDgGXDsXjA7tqCdHuHf2s41JApFg2T81hZxkx4BCNJ/9DltElTrmsKIaj5
 xI2Xsfv4KHcq49Fn9l8hQnr6yZMuevML1xfLDV66Ny1d1lnIeObFbmOesticbdiABAVfOnnFaho
 NkTQ7uIkjEicXB52xiSg8bIbzdsLSaN4Mpt5I6gaSqs=
X-Received: by 2002:a05:701b:450f:10b0:143:f79:f679 with SMTP id
 a92af1059eb24-14dcdd512dcmr30960c88.1.1790782660389; 
 Wed, 30 Sep 2026 08:37:40 -0700 (PDT)
X-Received: by 2002:a05:701b:450f:10b0:143:f79:f679 with SMTP id
 a92af1059eb24-14dcdd512dcmr30937c88.1.1790782659751; Wed, 30 Sep 2026
 08:37:39 -0700 (PDT)
MIME-Version: 1.0
References: <20260930095800.551314-1-maxime.coquelin@redhat.com>
 <20260930095800.551314-2-maxime.coquelin@redhat.com>
 <20260930082638.0932a5e9@phoenix.local>
In-Reply-To: <20260930082638.0932a5e9@phoenix.local>
From: Maxime Coquelin <maxime.coquelin@redhat.com>
Date: Wed, 30 Sep 2026 17:37:27 +0200
X-Gm-Features: AclHuK95BhDa9uggdYpkauqBewY_eUubKNpjysLNrzQ16y-Jpeiu19qeHhXNMGw
Message-ID: <CAO55cszUi99k3vjKTQh31QArHxpq_65HK1sKS2AdTW4TzLSSwg@mail.gmail.com>
Subject: Re: [PATCH 1/2] config: add compatibility for old compilers with new
 UAPI headers
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, eperezma@redhat.com, david.marchand@redhat.com, 
 thomas@monjalon.net
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: PgaEateT4SpqBI1A8UfJ583Fv6K12ukdx3WzutbVaqU_1790782661
X-Mimecast-Originator: redhat.com
Content-Type: multipart/alternative; boundary="0000000000004e0350065cb51470"
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

--0000000000004e0350065cb51470
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 30, 2026 at 5:26=E2=80=AFPM Stephen Hemminger <
stephen@networkplumber.org> wrote:

> On Wed, 30 Sep 2026 11:57:59 +0200
> Maxime Coquelin <maxime.coquelin@redhat.com> wrote:
>
> > This patch adds a compatibility define for __counted_by attribute,
> > which is not present in older compilers but required for recent UAPI
> > headers like vfio.h.
> >
> > Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
> > ---
> >  config/rte_config.h | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> >
> > diff --git a/config/rte_config.h b/config/rte_config.h
> > index 0447cdf2ad..307e7dac62 100644
> > --- a/config/rte_config.h
> > +++ b/config/rte_config.h
> > @@ -25,6 +25,15 @@
> >  #define RTE_TOOLCHAIN_MSVC 1
> >  #endif
> >
> > +/*
> > + * Compatibility define for Linux kernel UAPI headers that may use
> __counted_by
> > + * attribute for bounds checking. This attribute is not understood by
> userspace
> > + * compilers, so define it as empty if not already provided.
> > + */
> > +#ifndef __counted_by
> > +#define __counted_by(m)
> > +#endif
> > +
> >  /* legacy defines */
> >  #ifdef RTE_EXEC_ENV_LINUX
> >  #define RTE_EXEC_ENV_LINUXAPP 1
>
> NAK this is best done by keeping up to date stddef over in virtio headers=
.
>
>
This is for VFIO, not Virtio but that does not change the issue.

Problem is importing stddef in UAPI as currently done, does not work,
because the system version is included first so the imported one is
discarded.

An alternative solution I tested would be to include the imported headers
first,
but it means imported headers get silently intermixed, which worked in my
test
but could lead to hard to debug issues.

While not ideal, the solution proposed in this patch is harmless, we are
talking
about an attribute defined as empty.

Thomas, David, what do you think?

Thanks,
Maxime

--0000000000004e0350065cb51470
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Sep 30,=
 2026 at 5:26=E2=80=AFPM Stephen Hemminger &lt;<a href=3D"mailto:stephen@ne=
tworkplumber.org">stephen@networkplumber.org</a>&gt; wrote:<br></div><block=
quote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1=
px solid rgb(204,204,204);padding-left:1ex">On Wed, 30 Sep 2026 11:57:59 +0=
200<br>
Maxime Coquelin &lt;<a href=3D"mailto:maxime.coquelin@redhat.com" target=3D=
"_blank">maxime.coquelin@redhat.com</a>&gt; wrote:<br>
<br>
&gt; This patch adds a compatibility define for __counted_by attribute,<br>
&gt; which is not present in older compilers but required for recent UAPI<b=
r>
&gt; headers like vfio.h.<br>
&gt; <br>
&gt; Signed-off-by: Maxime Coquelin &lt;<a href=3D"mailto:maxime.coquelin@r=
edhat.com" target=3D"_blank">maxime.coquelin@redhat.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 config/rte_config.h | 9 +++++++++<br>
&gt;=C2=A0 1 file changed, 9 insertions(+)<br>
&gt; <br>
&gt; diff --git a/config/rte_config.h b/config/rte_config.h<br>
&gt; index 0447cdf2ad..307e7dac62 100644<br>
&gt; --- a/config/rte_config.h<br>
&gt; +++ b/config/rte_config.h<br>
&gt; @@ -25,6 +25,15 @@<br>
&gt;=C2=A0 #define RTE_TOOLCHAIN_MSVC 1<br>
&gt;=C2=A0 #endif<br>
&gt;=C2=A0 <br>
&gt; +/*<br>
&gt; + * Compatibility define for Linux kernel UAPI headers that may use __=
counted_by<br>
&gt; + * attribute for bounds checking. This attribute is not understood by=
 userspace<br>
&gt; + * compilers, so define it as empty if not already provided.<br>
&gt; + */<br>
&gt; +#ifndef __counted_by<br>
&gt; +#define __counted_by(m)<br>
&gt; +#endif<br>
&gt; +<br>
&gt;=C2=A0 /* legacy defines */<br>
&gt;=C2=A0 #ifdef RTE_EXEC_ENV_LINUX<br>
&gt;=C2=A0 #define RTE_EXEC_ENV_LINUXAPP 1<br>
<br>
NAK this is best done by keeping up to date stddef over in virtio headers.<=
br>
<br></blockquote><div><br></div><div>This is for VFIO, not Virtio but that =
does not change the issue.</div><div><br></div><div>Problem is importing st=
ddef in UAPI as currently done, does not work,</div><div>because the system=
 version is included first so the imported one is discarded.=C2=A0</div><di=
v><br></div><div>An alternative solution I tested would be to include the i=
mported headers first,</div><div>but it means imported headers get silently=
 intermixed, which worked in my test</div><div>but could lead to hard to de=
bug issues.</div><div><br></div><div>While not ideal, the solution proposed=
 in this patch is harmless, we are talking</div><div>about an attribute def=
ined as empty.</div><div><br></div><div>Thomas, David, what do you think?</=
div><div><br></div><div>Thanks,</div><div>Maxime</div><div><br></div></div>=
</div>

--0000000000004e0350065cb51470--

