Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50673C71135
	for <dpdk-dev@archiver.kernel.org>; Fri, 13 Jun 2025 21:53:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 12AC0402C1;
	Fri, 13 Jun 2025 23:53:45 +0200 (CEST)
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com
 [209.85.216.54]) by mails.dpdk.org (Postfix) with ESMTP id A2CE4402B6
 for <dev@dpdk.org>; Fri, 13 Jun 2025 23:53:43 +0200 (CEST)
Received: by mail-pj1-f54.google.com with SMTP id
 98e67ed59e1d1-311da0bef4aso2922832a91.3
 for <dev@dpdk.org>; Fri, 13 Jun 2025 14:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1749851622; x=1750456422; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=mi9OIlCYTdabNio6AptUnBHRXlsqNAk+0BVNK9IGsS4=;
 b=bpVR8x7E/eaIbOgO3FXdF6aqC9Fz6XzSRjljQ9Pd7G3qBMbfn6qDQXJAluEy2IbX9H
 Otr+QqJPMkBnaL2GegcvjUmXoXLj4JG9+V9FbAorpyoM+V+V7AgFs8EX1HdaIWwtR5+J
 6XWof6rH3ZTs0ro+6LYOHgvcTGPPohv/JVlZQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749851622; x=1750456422;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mi9OIlCYTdabNio6AptUnBHRXlsqNAk+0BVNK9IGsS4=;
 b=VBj62rPPdXQeMXjJWFd8LKb9SUIDPIvSfFG9u8FofWP6IyeCE9S3y4KYtgOeyoQLUO
 IqzLkG0vTaNq9SaVSxRqr21O7k5JeC+KdBnbN9+UdeO3gVKcFaYz+I1zdAnel3VGcLRI
 gQHNA+Gd9Ex3bYzw3EtYuJqUwXmAMBZS9lmt8o8tZUX6pVmW2XmLKuqKGEUj2gsi+Yb/
 Oc1WtaUbW3GFDvWhK8WZqt047aOOwbrfJpc4ePCtd2YKXF0eYHzn2rJCKNg8pQKY5vD1
 g1u256tJSkpBBXa2V2s9nVh9lFlmExosppmaBsVREcB0yPPF2plRxMUPcdurL1Ba3sPa
 l0zw==
X-Gm-Message-State: AOJu0YyFhIgRdciUmhYnlQ6+u/qIfy4DuHSTFuyKd7GK8wafGv/5NIay
 BX6fb/tOE0+90GbcneDDc/22sr4FWKzyvzp07ctUkxj/JfZtPbumBlwsnGS8qrGyQ2nxgwZxdTQ
 WsquX4qXViQSJ7XkOZsubRjdd0gWbZ44pmdr61CyxTQ==
X-Gm-Gg: ASbGncucm02kgc2M/1p1Cd4x4Pg3Je7L5Nyo+fpwIcRMu9Azu47W4WPod0xlUFbXgTQ
 Zkw4jzWUps25qwUHDQEK7whTIIyuI1w2V4Z1Q1rubD7RcnEiQSXJwh70k3PC+1+7a+yjrugiz52
 LPbVVgN0O8tG6cTAECLmyzTTnMEJej6DDYFNaSm6ZrCYijhAE0SOsC2Pm+4Qt82nrDrD+4xBfW0
 bA/
X-Google-Smtp-Source: AGHT+IFzrqabDbZO4mf11/DcQ9PeERfcNtwYcSmV8LZm9C0qMqXzc3oft5MjSxX8iew4JNHU9JG0nvslCuiIKySLVx8=
X-Received: by 2002:a17:90b:1b48:b0:311:df4b:4b91 with SMTP id
 98e67ed59e1d1-313f1ca77e4mr1944366a91.7.1749851622655; Fri, 13 Jun 2025
 14:53:42 -0700 (PDT)
MIME-Version: 1.0
References: <20250613081018.2790825-1-david.marchand@redhat.com>
 <CAJFAV8ziisXinUmbOSZ7r2EHoioqgEL-KS7Y1dCY=MH2AmnxDQ@mail.gmail.com>
In-Reply-To: <CAJFAV8ziisXinUmbOSZ7r2EHoioqgEL-KS7Y1dCY=MH2AmnxDQ@mail.gmail.com>
From: Patrick Robb <probb@iol.unh.edu>
Date: Fri, 13 Jun 2025 17:48:30 -0400
X-Gm-Features: AX0GCFvL8NoHSjTxb-00ioWKZCt0dTMvZxNG1-cmbEBwHBocuhNog4j7pqnHwyw
Message-ID: <CAJvnSUD8aW-y_qdLN_GnRQfUns9H2QZcbKjg3TtauRXJ4Ojx4g@mail.gmail.com>
Subject: Re: [PATCH] common/mlx5: fix dependency detection on Windows
To: David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org, andremue@linux.microsoft.com, 
 Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>, 
 Bing Zhao <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>,
 Suanming Mou <suanmingm@nvidia.com>, 
 Matan Azrad <matan@nvidia.com>, Thomas Monjalon <thomas@monjalon.net>, 
 Tal Shnaiderman <talshn@nvidia.com>,
 Tyler Retzlaff <roretzla@linux.microsoft.com>, 
 Manit Mahajan <mmahajan@iol.unh.edu>
Content-Type: multipart/alternative; boundary="00000000000060dc4e06377b1436"
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

--00000000000060dc4e06377b1436
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Good catch David on this system having a partial install of mlx5dev
header/library.

NVIDIA guys, do any of you have a link to the current install procedure or
package? If not I can probably find whatever is correct. Thanks.

Either way we'll update devx on the Windows system Monday - thanks for your
patience.

On Fri, Jun 13, 2025 at 5:42=E2=80=AFAM David Marchand <david.marchand@redh=
at.com>
wrote:

> On Fri, Jun 13, 2025 at 10:10=E2=80=AFAM David Marchand
> <david.marchand@redhat.com> wrote:
> >
> > Don't *require* mlx5dev library when testing its presence.
>
> For the record, this was seen in a UNH env that seems to have
> partially installed mlx5 dependencies.
>
> Has header "mlx5devx.h" : YES
> drivers\common\mlx5\windows\meson.build:10:0: ERROR: C shared or
> static library 'mlx5devx' not found
>
> >
> > Fixes: 85c51a4ffab8 ("common/mlx5: get Windows dependency from standard
> variables")
> >
> > Signed-off-by: David Marchand <david.marchand@redhat.com>
>
>
> --
> David Marchand
>
>

--00000000000060dc4e06377b1436
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Good catch David on this system having a partial install o=
f mlx5dev header/library.<div><br></div><div>NVIDIA guys, do any of you hav=
e a link to the current install procedure or package? If not I can probably=
 find whatever is correct. Thanks.</div><div><br></div><div>Either=C2=A0way=
 we&#39;ll update devx on the=C2=A0Windows system Monday - thanks for your =
patience.</div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=
=3D"gmail_attr">On Fri, Jun 13, 2025 at 5:42=E2=80=AFAM David Marchand &lt;=
<a href=3D"mailto:david.marchand@redhat.com" target=3D"_blank">david.marcha=
nd@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddi=
ng-left:1ex">On Fri, Jun 13, 2025 at 10:10=E2=80=AFAM David Marchand<br>
&lt;<a href=3D"mailto:david.marchand@redhat.com" target=3D"_blank">david.ma=
rchand@redhat.com</a>&gt; wrote:<br>
&gt;<br>
&gt; Don&#39;t *require* mlx5dev library when testing its presence.<br>
<br>
For the record, this was seen in a UNH env that seems to have<br>
partially installed mlx5 dependencies.<br>
<br>
Has header &quot;mlx5devx.h&quot; : YES<br>
drivers\common\mlx5\windows\meson.build:10:0: ERROR: C shared or<br>
static library &#39;mlx5devx&#39; not found<br>
<br>
&gt;<br>
&gt; Fixes: 85c51a4ffab8 (&quot;common/mlx5: get Windows dependency from st=
andard variables&quot;)<br>
&gt;<br>
&gt; Signed-off-by: David Marchand &lt;<a href=3D"mailto:david.marchand@red=
hat.com" target=3D"_blank">david.marchand@redhat.com</a>&gt;<br>
<br>
<br>
-- <br>
David Marchand<br>
<br>
</blockquote></div>

--00000000000060dc4e06377b1436--
