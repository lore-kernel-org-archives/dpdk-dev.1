Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E16C2C021A9
	for <dpdk-dev@archiver.kernel.org>; Tue, 18 Feb 2025 03:01:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ABCEF4014F;
	Tue, 18 Feb 2025 04:01:18 +0100 (CET)
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com
 [209.85.221.173])
 by mails.dpdk.org (Postfix) with ESMTP id B50A6400EF
 for <dev@dpdk.org>; Tue, 18 Feb 2025 04:01:17 +0100 (CET)
Received: by mail-vk1-f173.google.com with SMTP id
 71dfb90a1353d-5209437e773so896946e0c.3
 for <dev@dpdk.org>; Mon, 17 Feb 2025 19:01:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1739847677;
 x=1740452477; darn=dpdk.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=wQ6efYizHYW7UtFju12cTQPxfU6Tx3sTyJSw9/BwJAA=;
 b=WALMxrhmCHqRkfYIP7l4bbUoORz9qIIHPbtM5LJ1UG7jhP7c20sR8EDxMZwzez2gew
 lJhV9ZoMfxEW0eUZPwG98l2JlseWr2HyqzEgPwvoP1vCRTrM0daAvBG7rB/paVtOwJ1U
 5yskrYNnXCk3eU5JUuaW0Szq8mlUNwfct1l4TfZgZ5ejQiq1bNWWOw5c3aV/0YXMwqRK
 mlBTWrZ+VnmXqKD0lk7RUbpKQ2OUwSuR5Ky+HaySUAYFxnxy9ME0JPAypC7ry1l/B4GP
 i0nlxht42PcaJdbdGaaZIICOnTyuRf9JLqg5mVDZLgtJNgpENYbYgz0EYKFnKLSnRC4W
 CTVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739847677; x=1740452477;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wQ6efYizHYW7UtFju12cTQPxfU6Tx3sTyJSw9/BwJAA=;
 b=Ec8L0cUE8J8i7JOIXSPzqku/FggD4UpXrs/IcOcZPuDuLaxepk2ZZkmcCrCiVp5xqC
 ltQlBUh+lHMW4yahh7H/GwFCJsicJGvqX70ajqx2z5ngof9bHU46/+mpnlFxD83vrlhK
 8/5EISApKa1TgfF3JIxE6ar3ZW+uSMJwBVcNXW2PUWSpOuy0n3wePQYAZrt0//xLBIts
 zaP365/D3k45bECmH8EblT1KimNgEdtpbfoaacN1ZvT4SPLXq35vMxs9hfGMxD0/4u0t
 cZqmtfD2TxMlm3IhaP1RQkNQ2duHeB5UoLWWDAi0zw2rccfzDJLY0GYnRgG8PKT20ost
 yfnw==
X-Gm-Message-State: AOJu0YwW4WM38rYL4W2GnWDmkDQKfalfmnrg6UXlHncymgN6TcJ6cqPO
 JsUiC04J7Todzuey8MCP9HAmwxC9FAAmTUIvWTaVN8RsLJiMi0qOVZvcwQjHZz5yRnEBGWQwKHQ
 8w3xf5EJwiaIpZDLxztrDk1/5AE7IysvRWMyUxRkQygDSmTSlpCE=
X-Gm-Gg: ASbGncuo7t6TqfzXx9FjZhAn9hDZV2cF35beWAagQd8Taz4BnF/CGjwFCdyJSAFsh0p
 WW49yM9jX1U9hxjsGLdDfo0YqiBs4rtshqZFqnSTZGmeedd79N82qBDHWgNy5/Qt7eONBylS+ht
 aTum35O8pEhMzXAamdn1WSIcKcbtTs3A==
X-Google-Smtp-Source: AGHT+IFLErhkisHE9RUMLsuhJaGwggdvVu6mAIYYZV31F5tG1GpIEkTeXW3lQFoF5K3CLNHw+2Kf863ouebQB8gcRVM=
X-Received: by 2002:a05:6122:65a8:b0:520:3536:feb5 with SMTP id
 71dfb90a1353d-5209dd21cbfmr4389915e0c.11.1739847676753; Mon, 17 Feb 2025
 19:01:16 -0800 (PST)
MIME-Version: 1.0
References: <20250217185743.169778-1-stephen@networkplumber.org>
 <98CBD80474FA8B44BF855DF32C47DC35E9FA48@smartserver.smartshare.dk>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35E9FA48@smartserver.smartshare.dk>
From: Stephen Hemminger <stephen@networkplumber.org>
Date: Mon, 17 Feb 2025 19:01:08 -0800
X-Gm-Features: AWEUYZk05j5icBuSpIdN0m0bLpOxlqHAWkA-CH10athNDYHov53jgeKSmh9TD5g
Message-ID: <CAOaVG158gujFK6fWN98JFLdetVgSOvcvzFiVE+FCNeHFGu-q7Q@mail.gmail.com>
Subject: Re: [RFC 00/11] Fix dev_ops dereferences
To: =?UTF-8?Q?Morten_Br=C3=B8rup?= <mb@smartsharesystems.com>
Cc: dev <dev@dpdk.org>
Content-Type: multipart/alternative; boundary="000000000000bc98a9062e61daed"
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

--000000000000bc98a9062e61daed
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I found a bunch more cases will send V2

On Mon, Feb 17, 2025, 12:24 Morten Br=C3=B8rup <mb@smartsharesystems.com> w=
rote:

> > From: Stephen Hemminger [mailto:stephen@networkplumber.org]
> > Sent: Monday, 17 February 2025 19.54
> >
> > A common pattern in DPDK internals is to have an array of function
> > pointers. When using these pointers an unnecessary derefence is done;
> > this is allowed in C because of a historical quirk but unnecessary.
> >
> > The PVS Studio checker flags these as:
> >  https://pvs-studio.com/en/docs/warnings/v516/
> >
> > This leads to a large number of warnings marked as High severity.
> > This patchset simplifies the source and gets rid of these warnings.
> >
> > It should have no impact on the resulting binary.
>
> +1 to this RFC.
> The code becomes much cleaner to read.
>
>

--000000000000bc98a9062e61daed
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">I found a bunch more cases will send V2</div><br><div cla=
ss=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_at=
tr">On Mon, Feb 17, 2025, 12:24 Morten Br=C3=B8rup &lt;<a href=3D"mailto:mb=
@smartsharesystems.com">mb@smartsharesystems.com</a>&gt; wrote:<br></div><b=
lockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-le=
ft:1px solid rgb(204,204,204);padding-left:1ex">&gt; From: Stephen Hemminge=
r [mailto:<a href=3D"mailto:stephen@networkplumber.org" target=3D"_blank" r=
el=3D"noreferrer">stephen@networkplumber.org</a>]<br>
&gt; Sent: Monday, 17 February 2025 19.54<br>
&gt; <br>
&gt; A common pattern in DPDK internals is to have an array of function<br>
&gt; pointers. When using these pointers an unnecessary derefence is done;<=
br>
&gt; this is allowed in C because of a historical quirk but unnecessary.<br=
>
&gt; <br>
&gt; The PVS Studio checker flags these as:<br>
&gt;=C2=A0 <a href=3D"https://pvs-studio.com/en/docs/warnings/v516/" rel=3D=
"noreferrer noreferrer" target=3D"_blank">https://pvs-studio.com/en/docs/wa=
rnings/v516/</a><br>
&gt; <br>
&gt; This leads to a large number of warnings marked as High severity.<br>
&gt; This patchset simplifies the source and gets rid of these warnings.<br=
>
&gt; <br>
&gt; It should have no impact on the resulting binary.<br>
<br>
+1 to this RFC.<br>
The code becomes much cleaner to read.<br>
<br>
</blockquote></div>

--000000000000bc98a9062e61daed--
