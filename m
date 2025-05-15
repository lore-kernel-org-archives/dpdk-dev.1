Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D9CCC2D0CD
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 May 2025 12:37:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5B50B40E4B;
	Thu, 15 May 2025 14:37:48 +0200 (CEST)
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com
 [209.85.214.180])
 by mails.dpdk.org (Postfix) with ESMTP id 8604240E3E
 for <dev@dpdk.org>; Thu, 15 May 2025 14:37:47 +0200 (CEST)
Received: by mail-pl1-f180.google.com with SMTP id
 d9443c01a7336-22e331215dbso14176115ad.1
 for <dev@dpdk.org>; Thu, 15 May 2025 05:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1747312666; x=1747917466; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=JXXOxJt+xCUQjAmzzLcn25aG5US/yTsZtLfKGmbsoqY=;
 b=GApdnPqX3OOHzW8MDZvl6fdA5DcCsl/+FLRYKzuXNH7+yroVApn7lV4m9zEaRDNIPO
 +d0jcZ8K5mYG9xviIdg4bdN6u5mNc/FY26L0gTISSVqLLhhH+4zPd0xsu//IKpmVQfX4
 yuDMG539+dfwzYqccCliwkTn0zgk6+dcJ+lJU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747312666; x=1747917466;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JXXOxJt+xCUQjAmzzLcn25aG5US/yTsZtLfKGmbsoqY=;
 b=I1FWsDbBiQe9p7kQihLG4cRNssKk6f9xOVVUy3SQRP5FDbIEHo2q3xuddI0Ab0RM/m
 KXBRTzJ++4zqKlMZpiHjHIR9pKWj9evZhhnZy6AFmlL4GGJajLWE05pxmtwR2CfVXHfI
 y/titj+QbndTMyu0a/EWsqPwbSR+XvwJbwtYa8fSFsqkrH+Ag3L6c+H59vxcdYQ9wbKD
 oEwjShT6JnBupVwn4ochEQShJg81AD71mTckIL9UZmNnjqUGYYyweRwdfS0OR9Eiyl2B
 FqWJhkDbu8uymnwJ2ZnjVa2/fypqcE7Z+HTWlnLzhD+14KwQ8yGWkuD9nsfJoTF5UIJ8
 uRRw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUifjWSTQhVOCQx67LDmRRiF9oHH0p3jQa3e1mgmQw62/GYVJwNIb06dTLxAPDtKCfJMLY=@dpdk.org
X-Gm-Message-State: AOJu0Yy0EsPPZyeAft+487w1YMobRDnnZcLcc98ScjDpJZlJ74ZumZ5g
 FQbNnJSOilczIsCBqTt0Hy61hK05lW2zR3qD3UC9poW+P9eHADXEp4UKnSAzim33IR8IqIFppii
 XC9CSoB+YZwUlrh/33fnaEKdrvusR0PyW085jjHqcyjupO1O2
X-Gm-Gg: ASbGncvT5NFeI768T4mVLWK4ih8USHPxIeUn2j6Rkf8Rub51CvpcLv6+hjBiEg32No/
 pp+AVGSB0kNArpmGYakRc82O/47dYhzNawlf5o0wP9yGxOlizAtXYSUxNAv1HXSbLwdLVBddLOR
 cu8rISRaPG4wvbcTaAJtzbW6/zCCla1r5xAeCo0vsV7C41sEV5
X-Google-Smtp-Source: AGHT+IFyPr3oGXbgNkzs6j3vJmgPo1BlVl7OSSsaFyzOy4MjXVLr75VAjrpF8G+11SISXtrA1RzCimx05Dp7I2xiLiY=
X-Received: by 2002:a17:902:f546:b0:231:7fbc:19f3 with SMTP id
 d9443c01a7336-231b398f88fmr49525315ad.12.1747312666430; Thu, 15 May 2025
 05:37:46 -0700 (PDT)
MIME-Version: 1.0
References: <CAJFAV8x_u9-PHh_1_3qimFDGseSYLbZBprty0jhKUZxehzOo=g@mail.gmail.com>
 <CAJvnSUDxPDuFyZytko1mxnE=6UQHvJ1OTbYBYnd1xM7zozsfsg@mail.gmail.com>
 <20240322163430.444bed0c@hermes.local>
 <CAJvnSUDZF9oTtj9yg12WuYRAQSVLsqxdFbdtFNu5Om1S1sWB4g@mail.gmail.com>
 <20240401174624.124d2f2f@hermes.local>
 <CAJFAV8xyZnjXVdbi3hsiSKMN5200H6tymEpxZ3O38X-Mh_dsFQ@mail.gmail.com>
In-Reply-To: <CAJFAV8xyZnjXVdbi3hsiSKMN5200H6tymEpxZ3O38X-Mh_dsFQ@mail.gmail.com>
From: Patrick Robb <probb@iol.unh.edu>
Date: Thu, 15 May 2025 14:33:05 +0200
X-Gm-Features: AX0GCFsqfMiIouAFSQlYf1Oljs4sv2Qtu83aqyLV54Mf-hCuCE3YpLSANH4YyEs
Message-ID: <CAJvnSUCXns=JXV0FsWENqsifNzCA2NQhqJBCwDsfh=S4BbWy2A@mail.gmail.com>
Subject: Re: pcapng_autotest unit test false positive
To: David Marchand <david.marchand@redhat.com>
Cc: Stephen Hemminger <stephen@networkplumber.org>, dev <dev@dpdk.org>, 
 Aaron Conole <aconole@redhat.com>, ci@dpdk.org, Cody Cheng <ccheng@iol.unh.edu>
Content-Type: multipart/alternative; boundary="000000000000cb654006352bee67"
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

--000000000000cb654006352bee67
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Okay, I'll make a ticket for us to look at this again and raise it at the
CI meeting this morning. Thanks for the heads up.

On Thu, May 15, 2025 at 8:59=E2=80=AFAM David Marchand <david.marchand@redh=
at.com>
wrote:

> On Tue, Apr 2, 2024 at 2:46=E2=80=AFAM Stephen Hemminger
> <stephen@networkplumber.org> wrote:
> >
> > On Mon, 1 Apr 2024 18:26:44 -0400
> > Patrick Robb <probb@iol.unh.edu> wrote:
> >
> > > Another idea - maybe multiple timestamps are gathered from different
> > > CPU registers during the same test, and they are misaligned for that
> > > reason. Maybe we can try reducing the cores for each unit test to 1
> > > and checking whether the issue persists.
> >
> > TSC is expected to be sync'd between cores. But of course packets can
> > arrive out of order on different cores.
>
> Just a note that there was one more occurence of this false positive toda=
y.
> https://lab.dpdk.org/results/dashboard/patchsets/33170/
>
>
> --
> David Marchand
>
>

--000000000000cb654006352bee67
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Okay, I&#39;ll make a ticket for us to look at this again =
and raise it at the CI meeting this morning. Thanks for the heads up.</div>=
<br><div class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=
=3D"gmail_attr">On Thu, May 15, 2025 at 8:59=E2=80=AFAM David Marchand &lt;=
<a href=3D"mailto:david.marchand@redhat.com">david.marchand@redhat.com</a>&=
gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0=
px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On Tu=
e, Apr 2, 2024 at 2:46=E2=80=AFAM Stephen Hemminger<br>
&lt;<a href=3D"mailto:stephen@networkplumber.org" target=3D"_blank">stephen=
@networkplumber.org</a>&gt; wrote:<br>
&gt;<br>
&gt; On Mon, 1 Apr 2024 18:26:44 -0400<br>
&gt; Patrick Robb &lt;<a href=3D"mailto:probb@iol.unh.edu" target=3D"_blank=
">probb@iol.unh.edu</a>&gt; wrote:<br>
&gt;<br>
&gt; &gt; Another idea - maybe multiple timestamps are gathered from differ=
ent<br>
&gt; &gt; CPU registers during the same test, and they are misaligned for t=
hat<br>
&gt; &gt; reason. Maybe we can try reducing the cores for each unit test to=
 1<br>
&gt; &gt; and checking whether the issue persists.<br>
&gt;<br>
&gt; TSC is expected to be sync&#39;d between cores. But of course packets =
can<br>
&gt; arrive out of order on different cores.<br>
<br>
Just a note that there was one more occurence of this false positive today.=
<br>
<a href=3D"https://lab.dpdk.org/results/dashboard/patchsets/33170/" rel=3D"=
noreferrer" target=3D"_blank">https://lab.dpdk.org/results/dashboard/patchs=
ets/33170/</a><br>
<br>
<br>
-- <br>
David Marchand<br>
<br>
</blockquote></div>

--000000000000cb654006352bee67--
