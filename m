Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B73B1CAC598
	for <dpdk-dev@archiver.kernel.org>; Tue, 16 Sep 2025 13:16:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C593A402C4;
	Tue, 16 Sep 2025 15:16:36 +0200 (CEST)
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com
 [209.85.214.182])
 by mails.dpdk.org (Postfix) with ESMTP id 94969402C2
 for <dev@dpdk.org>; Tue, 16 Sep 2025 15:16:34 +0200 (CEST)
Received: by mail-pl1-f182.google.com with SMTP id
 d9443c01a7336-26799bf6a2eso18230845ad.3
 for <dev@dpdk.org>; Tue, 16 Sep 2025 06:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1758028594; x=1758633394; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=dGoDq5IBq4wGVEjKZyp14ZePmtq4NXpK3riPzQ61s2I=;
 b=H2l2FCWAGwDHxFBcFDcbzo4oRbJVseJb2meJklXypMoChTOEbgWrcfziwsCBzQt68m
 iXYSar03SsPL1MVj9tang/ckOUMRjjmyQehYd1tuiDS0SQoYD6F3bLaUarK1tPA7a9aS
 jsjWkKODHuMu9cVvhRgb8OLJa2aLUVdFDF+LI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758028594; x=1758633394;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dGoDq5IBq4wGVEjKZyp14ZePmtq4NXpK3riPzQ61s2I=;
 b=WvowUI8lFSndnuwol4Z8pomTCiZh8yTLXGgziUVkNha1hs1+7b9RkkMEXeVe70BN4l
 CkjUBP9IqskG+4yLk1VL9nmQjmI5naZrhNV/TbnGHVdVyJ9SToal83e4liZYqHgcsQjV
 WZI/XaUd/ngM0aOjz4I5W/25tATU1qAntYD2+g+kV2Qm5qFQMRtIJjeJ/55nxB6rWAk9
 6YNOLIMrVWh41pqUy9UKVdnouFpdslwy2CEUUWlTuiB3zzVW8tBbzeeLQ7TcTwdmc2dP
 x6tu3wTotzphEZfu8pAoTdlnwTTFsmIJ9Pv1hDd1IWGNPhcmb3q5vTjFvZ18nCHYG25U
 m5cA==
X-Gm-Message-State: AOJu0Yy6b9X4wowbgD5+CwO81k896qHbXlB8WxeT0qKppqB1iVKsfNkt
 HqpYxftdGdUNn5Z2/jFqDBYBZkqP/vyZ1SZvjZS0mbGmvQXCdQyv3hhl9l6ukKyO/n7GwmLVPwT
 zaA3zKd4SuQotVUwpOmlqm9F01iPyePryKMeO+H4kzw==
X-Gm-Gg: ASbGnctYeedQiM+eQOFMjyrv5Ix43dcd6P9BHQipcu6GV3ynZ8f1hcZPtfEdygp605m
 TVRblNRzYXTAA76LjZHEArVcO2nPlVkpXK2EXdHb6z5knDsrwYIu5NYWJAXYyB6kRJ1BOI0laYa
 f8elGqkyY8makp5Pbb3gwyv5yDXwmNaDEwwPnMMAwRb3j9D1/uTQwKv80W7BFE0wfFXx1IpCJJ6
 q38StE54NVrjUwCQYjsw3eiDC9HgEQiVpgObRub
X-Google-Smtp-Source: AGHT+IHJiNXGn99qwfTuLJT5mrCXBAOjxy/yAK0z+efScXWMRVm5+A0Ah0V4cmvKuqoeQRbUPkqIMc2WdHOKFuw+m6Q=
X-Received: by 2002:a17:902:c407:b0:24c:784c:4a90 with SMTP id
 d9443c01a7336-25d24cac4e3mr230723985ad.1.1758028593686; Tue, 16 Sep 2025
 06:16:33 -0700 (PDT)
MIME-Version: 1.0
References: <20250916093550.1345901-1-maxime.coquelin@redhat.com>
In-Reply-To: <20250916093550.1345901-1-maxime.coquelin@redhat.com>
From: Patrick Robb <probb@iol.unh.edu>
Date: Tue, 16 Sep 2025 09:09:31 -0400
X-Gm-Features: AS18NWD_h3VXjq-ckZQEIfK50NMGWS5cFPQn0J8LT9WLWqqiwGADJo4i66FLcdg
Message-ID: <CAJvnSUARtZ=DRU+CawYP14R8Z51Ts3+nMfgpGOc3GipJQUMRJw@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] vhost: VDUSE startup workaround and fix
To: Maxime Coquelin <maxime.coquelin@redhat.com>
Cc: dev@dpdk.org
Content-Type: multipart/alternative; boundary="000000000000d4fed8063eeaedef"
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

--000000000000d4fed8063eeaedef
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Putting in a retest at the Community Lab.

On Tue, Sep 16, 2025 at 5:36=E2=80=AFAM Maxime Coquelin <maxime.coquelin@re=
dhat.com>
wrote:

> This series is a follow-up of the workaround to ensure queues are
> in a ready state before starting the device.
>
> It also adds a patch to ensure data passed to the kernel are properly
> initialized.
>
> Changes in v2:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> - Improve comments (David)
> - Initialize vq_info properly (David)
> - Add David's R-by
>
> Maxime Coquelin (2):
>   vhost: add VDUSE virtqueue ready state polling workaround
>   vhost: fix uninitialized VQ info in VDUSE vring setup
>
>  lib/vhost/vduse.c | 63 ++++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 60 insertions(+), 3 deletions(-)
>
> --
> 2.51.0
>
>

--000000000000d4fed8063eeaedef
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Putting in a retest at the Community Lab.</div><br><div cl=
ass=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_a=
ttr">On Tue, Sep 16, 2025 at 5:36=E2=80=AFAM Maxime Coquelin &lt;<a href=3D=
"mailto:maxime.coquelin@redhat.com">maxime.coquelin@redhat.com</a>&gt; wrot=
e:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">This series i=
s a follow-up of the workaround to ensure queues are<br>
in a ready state before starting the device.<br>
<br>
It also adds a patch to ensure data passed to the kernel are properly<br>
initialized.<br>
<br>
Changes in v2:<br>
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
- Improve comments (David)<br>
- Initialize vq_info properly (David)<br>
- Add David&#39;s R-by<br>
<br>
Maxime Coquelin (2):<br>
=C2=A0 vhost: add VDUSE virtqueue ready state polling workaround<br>
=C2=A0 vhost: fix uninitialized VQ info in VDUSE vring setup<br>
<br>
=C2=A0lib/vhost/vduse.c | 63 ++++++++++++++++++++++++++++++++++++++++++++--=
-<br>
=C2=A01 file changed, 60 insertions(+), 3 deletions(-)<br>
<br>
-- <br>
2.51.0<br>
<br>
</blockquote></div>

--000000000000d4fed8063eeaedef--
