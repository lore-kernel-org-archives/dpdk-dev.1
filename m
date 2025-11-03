Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DD95CCFA00
	for <dpdk-dev@archiver.kernel.org>; Mon,  3 Nov 2025 01:07:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 29BD5402EB;
	Mon,  3 Nov 2025 02:07:11 +0100 (CET)
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com
 [209.85.214.175])
 by mails.dpdk.org (Postfix) with ESMTP id C8C0940299
 for <dev@dpdk.org>; Mon,  3 Nov 2025 02:07:09 +0100 (CET)
Received: by mail-pl1-f175.google.com with SMTP id
 d9443c01a7336-2958db8ae4fso7234925ad.2
 for <dev@dpdk.org>; Sun, 02 Nov 2025 17:07:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1762132029; x=1762736829; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/5Co5N3x8pekugilinkAYLwIxv153xY8+e6RHELmc64=;
 b=gzh/9WzD277Stxys7oPya9Q5y647MMGDdMwetVBdFxVfGDZQ4UB5KZQPmJAjksIV4+
 /Q6Jt1c7PWeQgRu1MVkoIUlX/px4lB4XCiOz6xdS1j/nMzrwZSTNsoSM/HyHGFy9jd51
 7+nQcMqeqEibwfNb2ADNE94eeqLus/rjzDxa4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762132029; x=1762736829;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/5Co5N3x8pekugilinkAYLwIxv153xY8+e6RHELmc64=;
 b=WOuD1bNei9p5fUVdvmjiQKXlNMpgAKSZdqfyLy4be7+T0V4I8g3nm20r0hzEmAA1Vc
 20mLiK2aUM/zsAmcMClTziR8MqniuV0tecuR1x9uqFMyt7J2YZtcrUukCpRhXiLzgWWh
 MN1euWhjNVwKyx37QO1sh0gthxtt23/Jt/T67OX/1CbgMgOA8SgCqWaD8+dFhaRXF0Zt
 W/AwZZmbdTQfY77ZiDo6s0KNYUQ3BlrJgcCTYzYtk0cE7ZpleXf5oM8rqQRPFrBpVI7/
 CKAMIJxzFVQ+qBZy6UfX22KMP46kDw8Bkic8FRDvTRL3xVVU35Aggm5wX/gQgmBxPVKH
 W/5g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXN9icJ/aJ66uWDKLfCSs+ALKSrcg7TU9WISgydd/jBD5xnO7mWYw0wEjfCBdDBuzs3/P0=@dpdk.org
X-Gm-Message-State: AOJu0YxaG+Qvxrf23PmmB1iWkmUr7IKU7DD5HYFzIHmyL+pHrBFLAXnv
 EzTTKeIRNSZGOApFepz4U2129LZO7DDlWu0e8aO5hAkWO5C33tIvABd9lcXSwhS0tkJqHRzOgFV
 kL9xPwXtewRJ30jkY1RpJfBZtTkbCqebctGeRIg2yKw==
X-Gm-Gg: ASbGncsKZN9cq6SS0QoS8TnM2mXUir2Jwbsgjc/Lh/CTatdSwiruopI0nSKrg6E+zjo
 I4L6y0+g3qJe+1GbJ6kQw5+65wUWjO48Ih7DlXIrRSaORVylrkdgB8drVJ3Jw9M3qp85vw4J1K9
 GoAiUIyc0h9P8+Dj1aBF98TXGeD5c7ZqqFN037Ex7xfF9PA9+zUCdNi1Z1ct+s5OtU7Nv3jsyY0
 wqX6L/A7VudtcJ2seXB+kAk63n7XwIanJ/hjYEDtTR6MEXs+JE19fgNBBnVGfmR6/TuSI+vlLjA
 0KDR7oTd9dyfwLxg
X-Google-Smtp-Source: AGHT+IHXpUc2N6tyBq01hY0M9+/CNQwA9fGPgHfYbqFINVFbtgt6SbHAule/Zoiibyfxqx+XFK5MFj1tdLbnyjOw6S8=
X-Received: by 2002:a17:903:f84:b0:295:523:691d with SMTP id
 d9443c01a7336-2951a5b960fmr155312275ad.46.1762132028739; Sun, 02 Nov 2025
 17:07:08 -0800 (PST)
MIME-Version: 1.0
References: <CAJFAV8yS3-_RMn-Ln7umJFt+wWVH7Fj7yFnmmjgUnpD1=VX9yA@mail.gmail.com>
 <98CBD80474FA8B44BF855DF32C47DC35F6551F@smartserver.smartshare.dk>
 <CAJFAV8yn0n2B32W1WUaZSKs1N3DbBPCGZxrT-ats4x0mo0Py-A@mail.gmail.com>
 <98CBD80474FA8B44BF855DF32C47DC35F65520@smartserver.smartshare.dk>
 <CAJvnSUD8pJJeXYQ1adxC0d5mUT9Zm7jODoufrDjePN+7gy3MAA@mail.gmail.com>
 <98CBD80474FA8B44BF855DF32C47DC35F65526@smartserver.smartshare.dk>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F65526@smartserver.smartshare.dk>
From: Patrick Robb <probb@iol.unh.edu>
Date: Sun, 2 Nov 2025 20:06:05 -0500
X-Gm-Features: AWmQ_bmyN8DVxkI9Ay-NsgV5wYFKS347LVUKjAKqmOEEckeXag18S3MviDbg2J8
Message-ID: <CAJvnSUCH2U5DgpkRXJEX1yJmpE1yhM6KHEE9_8Z8xghW52Tg9Q@mail.gmail.com>
Subject: Re: Disable SPDK testing again?
To: =?UTF-8?Q?Morten_Br=C3=B8rup?= <mb@smartsharesystems.com>
Cc: David Marchand <david.marchand@redhat.com>, bruce.richardson@intel.com, 
 Aaron Conole <aconole@redhat.com>, dpdk-techboard <techboard@dpdk.org>,
 ci@dpdk.org, dev <dev@dpdk.org>
Content-Type: multipart/alternative; boundary="0000000000009eed7b0642a655bd"
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

--0000000000009eed7b0642a655bd
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Okay I'll push this change Monday morning.

On Sat, Nov 1, 2025 at 3:47=E2=80=AFAM Morten Br=C3=B8rup <mb@smartsharesys=
tems.com>
wrote:

> > From: Patrick Robb [mailto:probb@iol.unh.edu]
> > Sent: Friday, 31 October 2025 16.13
> >
> > On Fri, Oct 31, 2025 at 6:02=E2=80=AFAM Morten Br=C3=B8rup <mb@smartsha=
resystems.com>
> wrote:
> >
> >> If we disable SPDK testing due to this SPDK bug, how will we notice
> when they fix it, so we can enable SPDK testing again?
> >
> >> One option is I can disable SPDK testing for the "per-patch" testing,
> but leave it enabled for the periodic (once per 48 hours) runs on DPDK
> main. That way patch submitters aren't left wondering if their patch has
> broken SPDK, but we will be able to check in later on the DPDK main
> periodic builds to see if the SPDK side is fixed, at which point we can
> re-enable SPDK for per-patch testing.
>
> Yes, please do.
>
>

--0000000000009eed7b0642a655bd
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Okay I&#39;ll push this change Monday morning.</div><br><d=
iv class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gm=
ail_attr">On Sat, Nov 1, 2025 at 3:47=E2=80=AFAM Morten Br=C3=B8rup &lt;<a =
href=3D"mailto:mb@smartsharesystems.com">mb@smartsharesystems.com</a>&gt; w=
rote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0p=
x 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">&gt; From:=
 Patrick Robb [mailto:<a href=3D"mailto:probb@iol.unh.edu" target=3D"_blank=
">probb@iol.unh.edu</a>] <br>
&gt; Sent: Friday, 31 October 2025 16.13<br>
&gt; <br>
&gt; On Fri, Oct 31, 2025 at 6:02=E2=80=AFAM Morten Br=C3=B8rup &lt;<a href=
=3D"mailto:mb@smartsharesystems.com" target=3D"_blank">mb@smartsharesystems=
.com</a>&gt; wrote:<br>
&gt; <br>
&gt;&gt; If we disable SPDK testing due to this SPDK bug, how will we notic=
e when they fix it, so we can enable SPDK testing again?<br>
&gt;<br>
&gt;&gt; One option=C2=A0is I can disable SPDK testing for the &quot;per-pa=
tch&quot; testing, but leave it enabled for the periodic (once per 48 hours=
) runs on DPDK main. That way patch submitters aren&#39;t left wondering if=
 their patch has broken SPDK, but we will be able to check in later on the =
DPDK main periodic builds to see if the SPDK side is fixed, at which point =
we can re-enable SPDK for per-patch testing.<br>
<br>
Yes, please do.<br>
<br>
</blockquote></div>

--0000000000009eed7b0642a655bd--
