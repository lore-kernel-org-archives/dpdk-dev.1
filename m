Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FEC3C71136
	for <dpdk-dev@archiver.kernel.org>; Wed, 18 Jun 2025 00:26:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 42D5140E4A;
	Wed, 18 Jun 2025 02:26:57 +0200 (CEST)
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com
 [209.85.214.175])
 by mails.dpdk.org (Postfix) with ESMTP id 836A440279
 for <dev@dpdk.org>; Wed, 18 Jun 2025 02:26:55 +0200 (CEST)
Received: by mail-pl1-f175.google.com with SMTP id
 d9443c01a7336-234d3261631so42506095ad.1
 for <dev@dpdk.org>; Tue, 17 Jun 2025 17:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1750206414; x=1750811214; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=D6P9nhr9oyUJhJlmwvkfY6K4XRSITwp5hl39YEqj6Mk=;
 b=DVsefGYUsGbBLOo8sA8whtKZzny9ycc2MTFmirk+DFUZqRvGVQ77+oyurarteaXsba
 FE6EwbM7ae9hHMxNpyKMb6xNDamCLcHQIhW7CosPaXcAG9GPv4/FE5070B1ZvvELPXRT
 DiJhzztF5eTftPASHRrf9OsCMa9MuEnxr2rDg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750206414; x=1750811214;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=D6P9nhr9oyUJhJlmwvkfY6K4XRSITwp5hl39YEqj6Mk=;
 b=kPH5MV1XccehJEdOiMXvGemIpTIizK83bkLosSQCP9CRusA/X+5+RoSvg1wX3bjeB5
 ohDWPKS1Dfs+JFePY6LR80Nxyuku5sxqIMWKBDYfUDeq19HRdlI3oZm2960ss/xKNXlG
 0zXt/Cxn2GAqUHdFlq0TPLz5ANMUgnCM48y0h88awIXsH6BbRq5qsZ7D7UEABpmtHDtt
 HsZhosyI72peEi7PP2wyRyvzJo4GWj8PX97Of3/TOPLFTqYa2rRUATVCl4v2Wxa9h3oe
 pK46fAc4SIpCvVMz+lcetE8z4U5YlXOOVMsHs1imywXae3NN0k8j5oml8B25YyF64w+g
 Bwdg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVNlqrOAd26BcdFA/VGayuIHSnlvxY1ZTBpzK9rzIvH8JEniEIEhwh/JUtK8raFTmeUGpE=@dpdk.org
X-Gm-Message-State: AOJu0YyPneVreecxl8HsO7hP3zC+GGEqpAtIClJqfHZIBPNQJvQkaL3x
 bnaPVHJzCVFbzt+mNU7iKlzqAMczd49NgWs7Y+mbJUwSpTfrBthKZ9kKrC6Er5qfgjvHt7IZbd6
 Q3IFYxLRu6eminvpyGHuJ4MEVjP8nx3FQ3QbmXvMJxw==
X-Gm-Gg: ASbGncv2K2a6XcWrIymErRAF/nCFjXQWA6yC0QFVolwHxZyimznBf/5ex8hwutCYM/v
 uxvQ5EWNJ4SJKAAohAXT+KhBaTQuzl1TCVwKnEjH5b7qzcg9dM41rNtV/lxfh0M1ZX2oLqjbHCF
 WKWR9lRwh5GE9dX8TuI+FGA47DghqZtEGafoKyoBKwmMPZ+H1Vloj/Jon6gmo=
X-Google-Smtp-Source: AGHT+IGOQfa7dpa9R/DZWQEAhzuNbrpLJoP9ggK0r4LMEbWJVStC9q++hqsoRN/aIcC6ONa157h0H8IYPjV5BsQZMKU=
X-Received: by 2002:a17:902:cecb:b0:234:986c:66f9 with SMTP id
 d9443c01a7336-2366b00f255mr258089915ad.22.1750206414615; Tue, 17 Jun 2025
 17:26:54 -0700 (PDT)
MIME-Version: 1.0
References: <20250612201220.614724-1-dmarx@iol.unh.edu>
 <20250616183859.646384-1-dmarx@iol.unh.edu>
 <8b266009-ff64-4052-aadc-9364159f8702@arm.com>
In-Reply-To: <8b266009-ff64-4052-aadc-9364159f8702@arm.com>
From: Patrick Robb <probb@iol.unh.edu>
Date: Tue, 17 Jun 2025 20:21:38 -0400
X-Gm-Features: AX0GCFvMw_BaBX4JQxwkyyHYYntdNVq9tcyymbyEEd6RTg5XaMhuc28xggOT0nE
Message-ID: <CAJvnSUDO4JHNKpAkskoDcQAWnszBDPo7XTN3dBZH5w1OYJFy_w@mail.gmail.com>
Subject: Re: [PATCH v2] dts: fix devbind initialization bug
To: Luca Vizzarro <Luca.Vizzarro@arm.com>
Cc: Dean Marx <dmarx@iol.unh.edu>, yoan.picchi@foss.arm.com, 
 Honnappa.Nagarahalli@arm.com, paul.szczepanek@arm.com, dev@dpdk.org
Content-Type: multipart/alternative; boundary="000000000000a0a9880637cdaf92"
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

--000000000000a0a9880637cdaf92
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 17, 2025 at 11:18=E2=80=AFAM Luca Vizzarro <Luca.Vizzarro@arm.c=
om>
wrote:

> Looks good to me. just a small nit:
>
> On 16/06/2025 19:38, Dean Marx wrote:
> > +        test_run.ctx.topology.setup()
> > +        self.test_run.ctx.topology.configure_ports("sut", "dpdk")
>
> no need to do `self.` here. Outside of this:
>

Good catch Luca. Thanks.

Applied to next-dts with the git edit per luca's comment.


>
> Reviewed-by: Luca Vizzarro <luca.vizzarro@arm.com>
>

--000000000000a0a9880637cdaf92
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Jun 17,=
 2025 at 11:18=E2=80=AFAM Luca Vizzarro &lt;<a href=3D"mailto:Luca.Vizzarro=
@arm.com">Luca.Vizzarro@arm.com</a>&gt; wrote:<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">Looks good to me. just a small nit:<br>
<br>
On 16/06/2025 19:38, Dean Marx wrote:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 test_run.ctx.topology.setup()<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.test_run.ctx.topology.configure_port=
s(&quot;sut&quot;, &quot;dpdk&quot;)<br>
<br>
no need to do `self.` here. Outside of this:<br></blockquote><div><br></div=
><div>Good catch Luca. Thanks.</div><div><br></div><div>Applied to next-dts=
 with the git edit per luca&#39;s comment.</div><div>=C2=A0</div><blockquot=
e class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px s=
olid rgb(204,204,204);padding-left:1ex">
<br>
Reviewed-by: Luca Vizzarro &lt;<a href=3D"mailto:luca.vizzarro@arm.com" tar=
get=3D"_blank">luca.vizzarro@arm.com</a>&gt;<br>
</blockquote></div></div>

--000000000000a0a9880637cdaf92--
