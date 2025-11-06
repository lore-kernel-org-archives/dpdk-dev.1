Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9530CCFA13
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Nov 2025 18:01:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0B7AB4021F;
	Thu,  6 Nov 2025 19:01:42 +0100 (CET)
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com
 [209.85.210.177])
 by mails.dpdk.org (Postfix) with ESMTP id 830ED4013F
 for <dev@dpdk.org>; Thu,  6 Nov 2025 19:01:40 +0100 (CET)
Received: by mail-pf1-f177.google.com with SMTP id
 d2e1a72fcca58-7a9c64dfa6eso1102096b3a.3
 for <dev@dpdk.org>; Thu, 06 Nov 2025 10:01:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1762452100; x=1763056900; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Tds+UbPqqsx2rMkxSkf18PfWcxX2BUfVzgWLxtRXddw=;
 b=gzweklUU5n++vXI56nCDk44bRlZRIoY+phGEYx6V75T15IbTY7DsOd+TqfkHjiHH02
 iBTeOm3FBSPFBBm4TxGxaDPi3pw38AgFVTbqSw/tzGZ3cTvQjh9p+T41q2n8m0RvLiKh
 Pi48OjeGaWjato3Zmc8fqXCGeFH+tTr7C3w4I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762452100; x=1763056900;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Tds+UbPqqsx2rMkxSkf18PfWcxX2BUfVzgWLxtRXddw=;
 b=tvObS9xBoGA5E6F1zPYbNeB7ZcDJQAmLO3jf8HLDQsVQ2/mjIgFFB13vB7hM1X3ATc
 uw5RFwnK7oB+62zi2DF4Pe+B0AolTjCCugUbsL8oREwsg8AQCq5H+7O6NgBj5lAU7yT7
 jpmnNcq6o7vm8Q4MOIU6GN6kQO0TDlzLMFSG0mZB8XP3I6Xb0rZZJArzQvTCAt1TLrpi
 raS555OP+DUTCPLXDb32IZtN2HINPnbOdWL0LLUnRhcYadJFZS7jHfM2l24j20SQ0Zg6
 k5Aa/FVGT17snDQexNvswi/VRhFUaxfRvQ1e+z/fpSy6SRaxjZo/9MH03feIWtTox6dG
 hTKg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX1DV1BOlSarFQCwtJqfhNak5s1DdwqRQ+Pz2oHXNveGtf2uTvORRtP7kpl0eAZXYk4jJE=@dpdk.org
X-Gm-Message-State: AOJu0YzNNkIzjB0ON6R6bdNcN2G6HkSYVKtlO2dLjXwV0FzAjLl9rhZP
 DCU1juvOvxCh/tAYzts0zXY6gNmvzXL4a+5ZGmGpwoCqQTITgJ2BcEnYROPewOq4bKGnQXdmFLP
 /+ou93KmJQskoGALhieTrvGOwHJkL6HqrBWstu7tUBw==
X-Gm-Gg: ASbGnctVfkgYJmRDMiG1O0Mm6pa159RG4Jn7XX3hdwXH3FKpf2PxD5gvBlkpZe+Enu9
 LoWDots9kfb97uevPASI/pChY4eBi+WbOvD8AzUiLSCbij3w3eTd9EvL/cRt6h3Xc+F6fTXa9Q2
 XIHCOUO05o3Iy9TErphciJbH1T9WbB750Ly5C2BwvXnOt7EVV/tT1K3/0CvDPVMmv07DCZg/UFs
 1DvSMKuaKj29mVdYaR+1XHgZwSZ2gvXy1pmm0Wp3raFm5aX3YrxPJ6df6ScsyRiXHO8N7eBuUDp
 S4gGqvdIrJn9f/It2fJvC+V2U7o=
X-Google-Smtp-Source: AGHT+IEAJpv1v/QzfSSsNt5jSkCVXtnhmlsSfZVuZ2ET8/KoAC3Umn7J8IBhCSZtNlgxXVEwCMWbEaHu+2oiBg5Ljwg=
X-Received: by 2002:a05:6a20:3d86:b0:341:84ee:7597 with SMTP id
 adf61e73a8af0-3522a76d896mr556699637.47.1762452099336; Thu, 06 Nov 2025
 10:01:39 -0800 (PST)
MIME-Version: 1.0
References: <20250908014154.82938-1-probb@iol.unh.edu>
 <20251105194925.1507334-1-probb@iol.unh.edu>
 <CABD7UXOSvFY65O7djZCH7K1C9jwxNNwAq6QJktS1FJDGS2yuaQ@mail.gmail.com>
In-Reply-To: <CABD7UXOSvFY65O7djZCH7K1C9jwxNNwAq6QJktS1FJDGS2yuaQ@mail.gmail.com>
From: Patrick Robb <probb@iol.unh.edu>
Date: Thu, 6 Nov 2025 13:00:30 -0500
X-Gm-Features: AWmQ_bkXLafUygRCtq_IAXKCtJVkYkRjkMFxwOgjuRyrqk0R590x_7S7m-mKaVE
Message-ID: <CAJvnSUAXH8cv0JvqV2o6iiQ6x=930P2bnuCd4714QQetXSvJJA@mail.gmail.com>
Subject: Re: [PATCH v2] dts: testpmd link check on port start
To: Dean Marx <dmarx@iol.unh.edu>
Cc: Luca.Vizzarro@arm.com, dev@dpdk.org, Paul.Szczepanek@arm.com, 
 abailey@iol.unh.edu
Content-Type: multipart/alternative; boundary="000000000000509c6b0642f0db50"
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

--000000000000509c6b0642f0db50
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 6, 2025 at 12:15=E2=80=AFPM Dean Marx <dmarx@iol.unh.edu> wrote=
:

> On Wed, Nov 5, 2025 at 2:50=E2=80=AFPM Patrick Robb <probb@iol.unh.edu> w=
rote:
> >
> > In addition, the interval in
> > between checking the link state has been reduced in
> > order to speed up the execution.
> >
> > Signed-off-by: Patrick Robb <probb@iol.unh.edu>
> > Tested-by: Patrick Robb <probb@iol.unh.edu>
>
> <snip>
> >              if "Link status: up" in port_info:
> >                  break
> > -            time.sleep(0.5)
> > +            time.sleep(0.25)
>
> What's the rationale for changing this, just wondering?
>

See the commit blurb above - there will be many function calls to functions
which are decorated with _requires_started_ports during the DTS execution.
That means every time that happens it will enter the block you see above.
If we add .5 seconds to each of these function calls, it will slow down the
execution. It probably isn't a huge deal but the downside of decreasing the
time interval is pretty much nothing.


>
> Reviewed-by: Dean Marx <dmarx@iol.unh.edu>
>

--000000000000509c6b0642f0db50
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Nov 6, =
2025 at 12:15=E2=80=AFPM Dean Marx &lt;<a href=3D"mailto:dmarx@iol.unh.edu"=
>dmarx@iol.unh.edu</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote=
" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);=
padding-left:1ex">On Wed, Nov 5, 2025 at 2:50=E2=80=AFPM Patrick Robb &lt;<=
a href=3D"mailto:probb@iol.unh.edu" target=3D"_blank">probb@iol.unh.edu</a>=
&gt; wrote:<br>
&gt;<br>
&gt; In addition, the interval in<br>
&gt; between checking the link state has been reduced in<br>
&gt; order to speed up the execution.<br>
&gt;<br>
&gt; Signed-off-by: Patrick Robb &lt;<a href=3D"mailto:probb@iol.unh.edu" t=
arget=3D"_blank">probb@iol.unh.edu</a>&gt;<br>
&gt; Tested-by: Patrick Robb &lt;<a href=3D"mailto:probb@iol.unh.edu" targe=
t=3D"_blank">probb@iol.unh.edu</a>&gt;<br>
<br>
&lt;snip&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if &quot;Link status: =
up&quot; in port_info:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break<br=
>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 time.sleep(0.5)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 time.sleep(0.25)<br>
<br>
What&#39;s the rationale for changing this, just wondering?<br></blockquote=
><div><br></div><div>See the commit blurb above - there will be many functi=
on calls to functions which are decorated with _requires_started_ports duri=
ng the DTS execution. That means every time that happens it will enter the =
block you see above. If we add .5 seconds to each of these function calls, =
it will slow down the execution. It probably isn&#39;t a huge deal but the =
downside of decreasing the time interval is pretty much nothing.</div><div>=
=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
Reviewed-by: Dean Marx &lt;<a href=3D"mailto:dmarx@iol.unh.edu" target=3D"_=
blank">dmarx@iol.unh.edu</a>&gt;<br>
</blockquote></div></div>

--000000000000509c6b0642f0db50--
