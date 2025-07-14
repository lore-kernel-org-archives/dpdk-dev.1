Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6615AC83F1B
	for <dpdk-dev@archiver.kernel.org>; Mon, 14 Jul 2025 14:16:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 730D54021F;
	Mon, 14 Jul 2025 16:16:19 +0200 (CEST)
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com
 [209.85.216.42]) by mails.dpdk.org (Postfix) with ESMTP id 6B952400D5
 for <dev@dpdk.org>; Mon, 14 Jul 2025 16:16:17 +0200 (CEST)
Received: by mail-pj1-f42.google.com with SMTP id
 98e67ed59e1d1-313f68bc519so3334781a91.0
 for <dev@dpdk.org>; Mon, 14 Jul 2025 07:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1752502576; x=1753107376; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zyS5JLjgmJZHsf6bh2GHhctZ0/chZMJokmNaz8n41q4=;
 b=L4Q1UvbdewPBVXCvVf0wLLP0CMZZ4NBod9WsE7h62p53iiUZd154UIR9vwAtuaxcuE
 abHGZonF59BFv6jWfVuHtoyuU5xmGRpZbnBnbARLCwHb3QJ502yzRQpYNnLwCj8h/0fo
 Yvi2yYQcxpCbZpRUsHgQdvFlm4Ma1ePlTxHp4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752502576; x=1753107376;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zyS5JLjgmJZHsf6bh2GHhctZ0/chZMJokmNaz8n41q4=;
 b=QISNiaEsm8lTiLaHZv6Rd5LTkQw8N+3KnUzAzcdrCKRV+rXdHq2NzbYV59O40CbwZB
 kK3f2Ar9hoY6BuvPzSW2vOotrc1BXV9xZyjJtUZPlFgWl12fb1ayg6io2AXqn7od8WNM
 m6uHrfcC48wk/tQ6vxVnru42f48TNP56F6Z16gNXfQ1skmiBuk/2RR1nxETnobvskA2E
 P02KYfowKe8H3AIh5ROAUO9b44LVcXl/UK91PQ3Cn5JgaiMzJEg/GpvbHqqZODVbVlAT
 927gDiUo8FgD2Yuvb60egWBWk+2QGguqbYUQ8bca/rXFuAUPx8Ew6AShSxiCCiW8D3LS
 Gg4g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVguoLlXaH2rXI2dQULrtL1pYlRN9GsGAp4XaDglkYdCGQGkhz6jXgrBsvOVECTpkdJzO8=@dpdk.org
X-Gm-Message-State: AOJu0YyG0L9Mb4NGlPr0hNAWryv3EiPjlzJtcFth8FVdqZCbJzVEsNvQ
 MMv5dNWO7eVPQfEPvsy3YMxYs6Jradg3WLnQNMFhsEPJz+friXr2mqq0UYicDiAgzAxlEEktCZ7
 rq0RGH26LCnnaqrp0lTynhLIm+MhsmEO5bzPDawgxBA==
X-Gm-Gg: ASbGncu5K0iwNREFDEmjeZb78mkxFbk6D7/dISJQbpYDI5ozuTdcOSspumlM6LvjPu9
 FZeBzndpaoPpX9Nme38wiZlGkxJxSyDLo7OSfozNn0D958TlmFrw7DdpMiNTsYyRuJBa5bdBwJ6
 YesoApzcXooJssDFKSnyHOSM4m/5lHhTYH+XtW/6AB5G1Va0H2eq4sDFqTVg0M7YKE9Xsr+xghu
 NXnGaIdZnCvAnhioweYyQ==
X-Google-Smtp-Source: AGHT+IGB4zCaOb8s8ii9i6ExtOABUQp24E1T9rRwNisyvNYzLyZoi8Ni7TUtn137L8o7MevaqxZIGii19iECDHIHDVk=
X-Received: by 2002:a17:90b:5144:b0:312:ffdc:42b2 with SMTP id
 98e67ed59e1d1-31c4f548690mr17611354a91.23.1752502576263; Mon, 14 Jul 2025
 07:16:16 -0700 (PDT)
MIME-Version: 1.0
References: <20250603172827.458725-1-dmarx@iol.unh.edu>
 <20250711172534.540416-1-dmarx@iol.unh.edu>
 <20250711172534.540416-2-dmarx@iol.unh.edu>
In-Reply-To: <20250711172534.540416-2-dmarx@iol.unh.edu>
From: Patrick Robb <probb@iol.unh.edu>
Date: Mon, 14 Jul 2025 10:10:27 -0400
X-Gm-Features: Ac12FXzqEhWX7dhvhTGh6S0vEMpLYq6B2rVo6EXCLQogg2glBWMT1TOPLFcdYME
Message-ID: <CAJvnSUCBFzOeQbaStZE+0PwHoHC_UrVHeCSt85DGUeTJz3G9Zw@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] doc: rephrase terminology in dts.rst
To: Dean Marx <dmarx@iol.unh.edu>
Cc: luca.vizzarro@arm.com, yoan.picchi@foss.arm.com, 
 Honnappa.Nagarahalli@arm.com, paul.szczepanek@arm.com, dev@dpdk.org
Content-Type: multipart/alternative; boundary="00000000000086eb550639e44d7a"
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

--00000000000086eb550639e44d7a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 11, 2025 at 1:25=E2=80=AFPM Dean Marx <dmarx@iol.unh.edu> wrote=
:

>
>  System under test node
>    A node where at least one SUT is present.
>
>  Traffic generator
> -  A TG is either software or hardware capable of sending packets.
> +  Node that sends traffic to the SUT; can be hardware or software-based.


Not to be a grammar nitpicker but I believe semicolons separate independent
clauses. Maybe just change to:

Node that sends traffic to the SUT, which can be hardware or software-based=
.


>
>
> 2.49.0
>
>
Reviewed-by: Patrick Robb <probb@iol.unh.edu>

--00000000000086eb550639e44d7a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Jul 11,=
 2025 at 1:25=E2=80=AFPM Dean Marx &lt;<a href=3D"mailto:dmarx@iol.unh.edu"=
>dmarx@iol.unh.edu</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote=
" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);=
padding-left:1ex"><br>
=C2=A0System under test node<br>
=C2=A0 =C2=A0A node where at least one SUT is present.<br>
<br>
=C2=A0Traffic generator<br>
-=C2=A0 A TG is either software or hardware capable of sending packets.<br>
+=C2=A0 Node that sends traffic to the SUT; can be hardware or software-bas=
ed.=C2=A0</blockquote><div><br></div><div>Not to be a grammar nitpicker but=
 I believe semicolons separate independent clauses. Maybe just change to:</=
div><div><br></div><div>Node that sends traffic to the SUT, which can be ha=
rdware or software-based.</div><div>=C2=A0</div><blockquote class=3D"gmail_=
quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,=
204);padding-left:1ex">
<br>=C2=A0=C2=A0<br>
2.49.0<br>
<br></blockquote><div><br></div><div>Reviewed-by: Patrick Robb &lt;<a href=
=3D"mailto:probb@iol.unh.edu">probb@iol.unh.edu</a>&gt;=C2=A0</div></div></=
div>

--00000000000086eb550639e44d7a--
