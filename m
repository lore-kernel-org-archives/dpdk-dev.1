Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AC44C83F17
	for <dpdk-dev@archiver.kernel.org>; Mon, 28 Jul 2025 14:25:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5A7B140291;
	Mon, 28 Jul 2025 16:25:26 +0200 (CEST)
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com
 [209.85.216.53]) by mails.dpdk.org (Postfix) with ESMTP id E3B2A4025A
 for <dev@dpdk.org>; Mon, 28 Jul 2025 16:25:24 +0200 (CEST)
Received: by mail-pj1-f53.google.com with SMTP id
 98e67ed59e1d1-31efefd2655so665606a91.0
 for <dev@dpdk.org>; Mon, 28 Jul 2025 07:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1753712724; x=1754317524; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=t7S50wzJSJTcNpgxaVz2n0yGvSxNzlQqAceSIQyJrQE=;
 b=VRB6L7REweGazVCfVImvPGNLEmahZxyxgecFferKJ8FIlJ2WQfDKGiwABp89clscAJ
 7m4hanM4X138xYBj3bsZk0QqAaCtu/KKC9va+QwoPmxvY/xBntifzAbk5xQldmbgMhRJ
 yHHeP6ZFEJ7SDZ/yL8hz8GHvHqKEkXjXrDniU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753712724; x=1754317524;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=t7S50wzJSJTcNpgxaVz2n0yGvSxNzlQqAceSIQyJrQE=;
 b=YnORsaq669EZHWYFdrW1KiadmcI51VZKmSohTU624MmAtPUIruNwcrKW8wD7+u8u2l
 9fTSghAPsrYfPtGTH2rz2B4Q+qjtTgzjZ9tzdUfiUB3xFaKRzeGKRCyerupu8nmcR8gW
 RXG6AjMDd8AhZ3beLzQ2041jlegpmkzGhSvBnsnLgG5WVIewlyHGDennwEGq8YGwvKyn
 ZoY8JA9d8WCDs/+G30qJUfX7+TOTs7tECrqPYpc1vPpylyTWJbtotmncCeSIVOvdDvpq
 Vr4Azet2m4FNKUFM3YJXzgiGYFMIHme9gr6i7CheRVV56P9hYn5mgoaGs+NejJE7JhwX
 p3qw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUFuvAH85xKPiIm5+zvAVCcgGN30fBWs6tU/+GqUnH9ZX3mxzYfnbp86fmzaMx0h3kps5k=@dpdk.org
X-Gm-Message-State: AOJu0YxrFhZ/IbEKJyYkMiCj7r2YLe0jt4wB9obXa4DB1Wix+CtYHMEP
 KJUy3M3ZDN0Qp51gmOhKqVDMn+Yzlnu47gjE8QgmoVKrZRr3XXQ/wGr8HDErB5JtRqPaE+9aBGu
 35lOi+goUnn/owEHr5xCsp/VtWzYJ9ZO8tQuCi7ubnw==
X-Gm-Gg: ASbGncvJ+u683Mrpg/q46CcmTJM8RVd7eca0FN/vUkpYA/TM19jzR4Hrry8Ze972kxE
 KHeN5h3PxPNQT7KMx45Iulie/rUbamCdg8k3l2UkXL17Br4sHW9QuWevknW5BrAZmbL7E74XcFK
 SYdtvXqYOyA/DKFNu2ILe/76Mtdokh8L2CphEzEYDFx7XfH24v6bsRYw06hc3Iqmc4DjJmroVTD
 OXaW51yShRui3r3H+Edv7HreJzdgHZS
X-Google-Smtp-Source: AGHT+IEqCTMsg4pj+bXMCg8pdNttPGWmoMEdIY67WA9BvYWBFPxwW5fgX3FYxdfDAFqDlelg4/SH4mShX8dbiYhUMYM=
X-Received: by 2002:a17:90b:53c8:b0:315:9624:37db with SMTP id
 98e67ed59e1d1-31e765aac96mr15755751a91.3.1753712723950; Mon, 28 Jul 2025
 07:25:23 -0700 (PDT)
MIME-Version: 1.0
References: <20250725200553.1262542-1-probb@iol.unh.edu>
 <b46a313b-048f-4a16-a274-3db9342d48fb@arm.com>
In-Reply-To: <b46a313b-048f-4a16-a274-3db9342d48fb@arm.com>
From: Patrick Robb <probb@iol.unh.edu>
Date: Mon, 28 Jul 2025 10:19:18 -0400
X-Gm-Features: Ac12FXxqiHb5tu-MfcyszOwXzhHxNberJ0EkuhFhprZcWd4ua-q5H_CRzQ0y1r0
Message-ID: <CAJvnSUBmpgOXD=5Z-8OCFfzrDJrRDnNrLWoJZ7Pb6hHve3q3zQ@mail.gmail.com>
Subject: Re: [PATCH] dts: call hugepages configure at testrun setup
To: Luca Vizzarro <Luca.Vizzarro@arm.com>
Cc: dmarx@iol.unh.edu, Paul.Szczepanek@arm.com, abailey@iol.unh.edu, 
 mmahajan@iol.unh.edu, thomas.wilks@arm.com, dev@dpdk.org
Content-Type: multipart/alternative; boundary="000000000000f317ae063afe0f31"
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

--000000000000f317ae063afe0f31
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 28, 2025 at 7:31=E2=80=AFAM Luca Vizzarro <Luca.Vizzarro@arm.co=
m> wrote:

> Really good catch Patrick! Thank you for this!
>
> Would it make more sense to place setup_hugepages under Node.setup()?
> In that case the method can also remain private, involving a single line
> change.
>

Yes, that makes more sense. I'll send a new version, thanks.


>
> Reviewed-by: Luca Vizzarro <luca.vizzarro@arm.com>
>

--000000000000f317ae063afe0f31
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Jul 28,=
 2025 at 7:31=E2=80=AFAM Luca Vizzarro &lt;<a href=3D"mailto:Luca.Vizzarro@=
arm.com">Luca.Vizzarro@arm.com</a>&gt; wrote:<br></div><blockquote class=3D=
"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(2=
04,204,204);padding-left:1ex">Really good catch Patrick! Thank you for this=
!<br>
<br>
Would it make more sense to place setup_hugepages under Node.setup()?<br>
In that case the method can also remain private, involving a single line <b=
r>
change.<br></blockquote><div><br></div><div>Yes, that makes more sense. I&#=
39;ll send a new version, thanks.</div><div>=C2=A0</div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">
<br>
Reviewed-by: Luca Vizzarro &lt;<a href=3D"mailto:luca.vizzarro@arm.com" tar=
get=3D"_blank">luca.vizzarro@arm.com</a>&gt;<br>
</blockquote></div></div>

--000000000000f317ae063afe0f31--
