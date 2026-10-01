Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59114CA5FCB
	for <dpdk-dev@archiver.kernel.org>; Thu,  1 Oct 2026 14:13:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6D0CE40144;
	Thu,  1 Oct 2026 16:12:59 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 4EC3F400D5
 for <dev@dpdk.org>; Thu,  1 Oct 2026 16:12:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790863976;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NaHq6vk65mpyGBqmbjTIdqEHDHaeT1B9MbQUUcS7anE=;
 b=USE+fNlJSTk85+xB8wXFtZrgpFs+clEx1+2Zk/g105XMTFr4kQ/4XYC7YZWEtK3+nE1qx7
 1Sz9jvLkkyzYFbCmo0aHkAUwnlPD3h4kojI3dCr31WyaeCMDN37aaYSYvGN5vKap/mNdYk
 GA0oUdak8EtHEXFpAfYuxykIeoyJkMo=
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-30-HJyX7IjNOg-hid2EsBlywg-1; Thu, 01 Oct 2026 10:12:54 -0400
X-MC-Unique: HJyX7IjNOg-hid2EsBlywg-1
X-Mimecast-MFC-AGG-ID: HJyX7IjNOg-hid2EsBlywg_1790863973
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-33713e5e6daso9399724eec.0
 for <dev@dpdk.org>; Thu, 01 Oct 2026 07:12:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790863973; x=1791468773;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=NaHq6vk65mpyGBqmbjTIdqEHDHaeT1B9MbQUUcS7anE=;
 b=SnAjFtnYQYidx7SGDLvV5+Q6qYyaIemYYygtY5agiyFPQio32GyiZenhw4kF4kRN9z
 twIqe3NCbPff15MWRYaXfcoiE9iKAgVmvsj8u9+Js+dBeaYxGgjoUH/yxF5aJUSsNQBP
 B6RDAWGebVz9VF+87ACOrjHtF7YTD3it5hLXv/3vwscojXGNhOL+OyEalZkp1gCbiVVL
 7eoBP5WLm5Rof0L7CMV6l7gipRIDi9t5nsEUJRqxRyP6Y2X8bXULHHMmwjprEzMGz4Kf
 2PW5Mxye37EXNjubyqYcKnPVuAlZdk/t4kpDXnQgfQZA8/T8Ro7/B2UiO7o27V0J1pf/
 NSLw==
X-Gm-Message-State: AFuF++nOj11NM2JAEirDOrfTfm0qaBxSR1LH28QfOqQR/y3uBTEg0qma
 uw1uNu+eyfvVfpyc+2rWLpNVTfhVPuy60PxmFPeiHhOKcDhO8jvghza8ueZPRIa9dw4ola8wZkt
 DBBlQbHA57e4E5HeoRPZnJ5rDXxgeM5NeyEs9oaGsB7gAsDJxhDLfd5dObscc0LXVy5LDQ3IXMz
 p8lcLCgV1eAeHr99jUDt8=
X-Gm-Gg: AYBFou3tDq6gZ2MCzozhu6SfgDkcfo4CMYZs1UpygIKC6VeuvLJe/Z3S9alWFWXoegf
 EwM0yhKDttHiTli1gnTbNyZE3hSyTOeAPQYnUrJLvOCR7hfBkOClQUhmZMvvVkkyL2eGZbRIPZu
 nMdKhZesnMgLrvzMGHblBgwJQRveWd1adoIACpvjzbC+MjNBcJYm8M8NS/vG0IMZ00QYHIgECxq
 HrhI1VEuOJ10acz2n5FNpr6Hdbdlb5OfGFSTgIkRiAziCeEjIMo+GbUSHb0QFrJ7vGRlMKtvSa1
 5TSk5yJxyZLl/bmPFLQ6bkkLHV1A7zrhQqgSB8+TPeQ=
X-Received: by 2002:a05:701b:2515:b0:144:ddf7:2570 with SMTP id
 a92af1059eb24-14d33684f13mr5543560c88.39.1790863972655; 
 Thu, 01 Oct 2026 07:12:52 -0700 (PDT)
X-Received: by 2002:a05:701b:2515:b0:144:ddf7:2570 with SMTP id
 a92af1059eb24-14d33684f13mr5543532c88.39.1790863971858; Thu, 01 Oct 2026
 07:12:51 -0700 (PDT)
MIME-Version: 1.0
References: <20260930095800.551314-1-maxime.coquelin@redhat.com>
 <20261001090558.1131763-1-david.marchand@redhat.com>
In-Reply-To: <20261001090558.1131763-1-david.marchand@redhat.com>
From: Maxime Coquelin <maxime.coquelin@redhat.com>
Date: Thu, 1 Oct 2026 16:12:39 +0200
X-Gm-Features: AclHuK-h329E_muDwY_TmmWmQhrcT6uxKN9SOehgDGic9xr0OWTaoFxHLlq7Nt0
Message-ID: <CAO55csz38p3sfK7H5x9vevKCQN1fUkw52QCqyEdCcX9PN7RFYw@mail.gmail.com>
Subject: Re: [PATCH v2] uapi: update headers to v6.19
To: David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org, eperezma@redhat.com, thomas@monjalon.net, 
 stephen@networkplumber.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: fFP6f31T1cx-Tv2XXnOyPJQGYl4yAOE9QE7bVZVGyjw_1790863973
X-Mimecast-Originator: redhat.com
Content-Type: multipart/alternative; boundary="000000000000e24d3b065cc80248"
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

--000000000000e24d3b065cc80248
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 1, 2026 at 11:06=E2=80=AFAM David Marchand <david.marchand@redh=
at.com>
wrote:

> From: Maxime Coquelin <maxime.coquelin@redhat.com>
>
> This patch updates imported UAPI headers to v6.19, in order
> to exercise the new compatibility define for __counted_by.
>
> Since __counted_by is introduced by linux/stddef.h we need to import it,
> and the headers, included by already imported headers, leading to its
> inclusion.
>
> One complication is that linux/types.h contains a guard that must be
> sanitized using the same method as the Linux kernel.
> For this, add a dependency on the unifdef tool.
>
> We also need to fix net/nbl which does not include the VFIO uapi header
> first.
>
> Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> ---
> Changes since v1:
> - dropped wrapper on __counted_by,
> - updated import process and added use of unidef,
> - fixed net/nbl driver,
> - imported needed uapi headers,
>
> ---
>  devtools/linux-uapi.sh                   |  6 ++
>  doc/guides/contributing/linux_uapi.rst   |  2 +
>  drivers/net/nbl/nbl_common/nbl_userdev.c |  3 +-
>  kernel/linux/uapi/linux/posix_types.h    | 38 ++++++++++++
>  kernel/linux/uapi/linux/stddef.h         | 74 ++++++++++++++++++++++++
>  kernel/linux/uapi/linux/types.h          | 58 +++++++++++++++++++
>  kernel/linux/uapi/linux/vduse.h          |  4 +-
>  kernel/linux/uapi/linux/vfio.h           | 42 +++++++++++++-
>  kernel/linux/uapi/version                |  2 +-
>  9 files changed, 223 insertions(+), 6 deletions(-)
>  create mode 100644 kernel/linux/uapi/linux/posix_types.h
>  create mode 100644 kernel/linux/uapi/linux/stddef.h
>  create mode 100644 kernel/linux/uapi/linux/types.h
>
>
>
Reviewed-by: Maxime Coquelin <maxime.coquelin@redhat.com>

Thanks!
Maxime

--000000000000e24d3b065cc80248
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Oct 1, =
2026 at 11:06=E2=80=AFAM David Marchand &lt;<a href=3D"mailto:david.marchan=
d@redhat.com">david.marchand@redhat.com</a>&gt; wrote:<br></div><blockquote=
 class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px so=
lid rgb(204,204,204);padding-left:1ex">From: Maxime Coquelin &lt;<a href=3D=
"mailto:maxime.coquelin@redhat.com" target=3D"_blank">maxime.coquelin@redha=
t.com</a>&gt;<br>
<br>
This patch updates imported UAPI headers to v6.19, in order<br>
to exercise the new compatibility define for __counted_by.<br>
<br>
Since __counted_by is introduced by linux/stddef.h we need to import it,<br=
>
and the headers, included by already imported headers, leading to its<br>
inclusion.<br>
<br>
One complication is that linux/types.h contains a guard that must be<br>
sanitized using the same method as the Linux kernel.<br>
For this, add a dependency on the unifdef tool.<br>
<br>
We also need to fix net/nbl which does not include the VFIO uapi header<br>
first.<br>
<br>
Signed-off-by: Maxime Coquelin &lt;<a href=3D"mailto:maxime.coquelin@redhat=
.com" target=3D"_blank">maxime.coquelin@redhat.com</a>&gt;<br>
Signed-off-by: David Marchand &lt;<a href=3D"mailto:david.marchand@redhat.c=
om" target=3D"_blank">david.marchand@redhat.com</a>&gt;<br>
---<br>
Changes since v1:<br>
- dropped wrapper on __counted_by,<br>
- updated import process and added use of unidef,<br>
- fixed net/nbl driver,<br>
- imported needed uapi headers,<br>
<br>
---<br>
=C2=A0devtools/linux-uapi.sh=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 6 ++<br>
=C2=A0doc/guides/contributing/linux_uapi.rst=C2=A0 =C2=A0|=C2=A0 2 +<br>
=C2=A0drivers/net/nbl/nbl_common/nbl_userdev.c |=C2=A0 3 +-<br>
=C2=A0kernel/linux/uapi/linux/posix_types.h=C2=A0 =C2=A0 | 38 ++++++++++++<=
br>
=C2=A0kernel/linux/uapi/linux/stddef.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 7=
4 ++++++++++++++++++++++++<br>
=C2=A0kernel/linux/uapi/linux/types.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 5=
8 +++++++++++++++++++<br>
=C2=A0kernel/linux/uapi/linux/vduse.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=
=C2=A0 4 +-<br>
=C2=A0kernel/linux/uapi/linux/vfio.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0| 42 +++++++++++++-<br>
=C2=A0kernel/linux/uapi/version=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 |=C2=A0 2 +-<br>
=C2=A09 files changed, 223 insertions(+), 6 deletions(-)<br>
=C2=A0create mode 100644 kernel/linux/uapi/linux/posix_types.h<br>
=C2=A0create mode 100644 kernel/linux/uapi/linux/stddef.h<br>
=C2=A0create mode 100644 kernel/linux/uapi/linux/types.h<br>
<br><br></blockquote><div><br></div><div>Reviewed-by: Maxime Coquelin &lt;<=
a href=3D"mailto:maxime.coquelin@redhat.com">maxime.coquelin@redhat.com</a>=
&gt;</div><div><br></div><div>Thanks!</div><div>Maxime=C2=A0</div></div></d=
iv>

--000000000000e24d3b065cc80248--

