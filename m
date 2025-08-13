Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F2C0CA0EC4
	for <dpdk-dev@archiver.kernel.org>; Wed, 13 Aug 2025 00:26:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 47AE04025D;
	Wed, 13 Aug 2025 02:26:24 +0200 (CEST)
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com
 [209.85.219.49]) by mails.dpdk.org (Postfix) with ESMTP id E9E8A400EF
 for <dev@dpdk.org>; Wed, 13 Aug 2025 02:26:22 +0200 (CEST)
Received: by mail-qv1-f49.google.com with SMTP id
 6a1803df08f44-70744e8ed6eso49760486d6.2
 for <dev@dpdk.org>; Tue, 12 Aug 2025 17:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=uetpeshawar-edu-pk.20230601.gappssmtp.com; s=20230601; t=1755044782;
 x=1755649582; darn=dpdk.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=lKYFw9ybHcGJOBtmXsoN1Qr/Pa9iI8asnLibfWr4pt8=;
 b=1s+TgwwL4d0YidANONUDAUCJr7zy7Qox5DP8SVuZI3b/ozOfzgyh74/xceI8Nf87Kj
 BdvpKU0FfohnxRKvFZHSvDZ8fYW9jsgnHJRYO7T0qNP9yaPXBjxomLa2IcM5qBR+GkCH
 iNdSBeD9fMK+417aSrgkNfDhkvB5MxNsj3rcEknDgJZtpRjxUaxApJ0JRh/GGG8PKIp1
 XavpMzFhLmS/Ou14Fb3GXXBBF4+JldfHYN5UyCl2Y/9/B/VnODayRVR/0BzvDcoV9NKJ
 4NXbWhs0i5VmVnNP3uNQoM0lTprUT8xUNjhSNAEVlqeCJTQM98z2VHwpFbBE5JDcPZXg
 4U4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755044782; x=1755649582;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lKYFw9ybHcGJOBtmXsoN1Qr/Pa9iI8asnLibfWr4pt8=;
 b=h44tB6wmWQaHPX1oPhegnl/N2320KpxalNdyixnmLat25dEnshnPBxwHxFg2csOLPy
 ZKZn49URePEsLToWZd0rR/k+qNdQbndRvKp/vYcqXURnAiyUDVIc3+46GHR2EKHHrPdb
 FR8ocggsYpYj8PNMgGBcy+xEKTNdeuz6w3MCBYQbMlbyUzrXjEBkdTrjsXuMuuyQWJl/
 OYWsT5j05jQw1hLM0x4UWDgJqGE6tjMyAELiitRYKGNdR6LJ58lvXfaIGGjbQbeJAN6r
 Owlh4P+mlIH5PeHYB3MukhZVK48qHMa3CpPo5i88Q+h0YudTjfH9NcEDrUeIaGUce+A0
 RfQg==
X-Gm-Message-State: AOJu0YxyZKEeX7YEyqGnCbEIzhEDZVw1rpXcTfG4uHMdEWA8iYVvaWsr
 y+MKnMLjr57QzP7BpBiYZsmmpSVpzIIJs6DUrphwcCwibq+YwMnaGkmJkaGMkH24YD5tOpifyKd
 nyd/mf7EJdxLUvBE2e+bxe0cSF9mcHz7FfaXZ5U/g+w==
X-Gm-Gg: ASbGncugim6xahQ7aVKgIFFER26M5IRUnyvs8ywfb5i+tlACXeOeiV20PQ6f8DvPm8D
 T2krZCpNMuEwESD0sPwhr7VXbgCV126eBfuTGy7b+j+2z1MNZxBYCfSDoYESNPgVDH87WzebUMc
 Iz5BlZG9x5q40LAIOaB5Ic+Sz8rPKRShB58a4yhv1pEwqSi4EegmsCu6BN9Iyuto5xqB7+pBmgP
 wpm3SABml8+Fr5zI5vX9V2iMnPMiYSXpXciusPLpg==
X-Google-Smtp-Source: AGHT+IFk6CYI2my0Ahnmfp9z3OlzbAnbsb0cgleDhl4UK0js8Gyg5lIbYII9zlycfKWn/W3iKh1rG5AfgShyyQ75zgo=
X-Received: by 2002:a05:6214:300d:b0:709:b94b:a6ad with SMTP id
 6a1803df08f44-709e8916beamr12125296d6.29.1755044782159; Tue, 12 Aug 2025
 17:26:22 -0700 (PDT)
MIME-Version: 1.0
References: <20250812144249.316120-1-thomas@monjalon.net>
In-Reply-To: <20250812144249.316120-1-thomas@monjalon.net>
From: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
Date: Wed, 13 Aug 2025 05:26:09 +0500
X-Gm-Features: Ac12FXzFwLnhEWGiVPD_2xw0Efml7nqoh_2ArjiY4smZxYAMSsPa2INBRZprSqk
Message-ID: <CA++2-x40Z9TrGgf2TSWgurbxN-n=Y8-DXx8uFTyjQFmesyKCHg@mail.gmail.com>
Subject: Re: [PATCH 1/1] ethdev: add link speed 800G
To: Thomas Monjalon <thomas@monjalon.net>
Cc: "dev@dpdk.org" <dev@dpdk.org>, Aman Singh <aman.deep.singh@intel.com>, 
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>, 
 Maxime Coquelin <maxime.coquelin@redhat.com>, Chenbo Xia <chenbox@nvidia.com>
Content-Type: multipart/alternative; boundary="000000000000ce4d6c063c343497"
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

--000000000000ce4d6c063c343497
Content-Type: text/plain; charset="UTF-8"

Acked-by: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>


On Tue, Aug 12, 2025, 19:43 Thomas Monjalon <thomas@monjalon.net> wrote:

> There are some devices supporting 800G speed,
> and it is well standardized in IEEE.
>
> Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
> ---
>

--000000000000ce4d6c063c343497
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><div><span style=3D"font-size:12.8px">Acked-by: Khad=
em Ullah &lt;<a href=3D"mailto:14pwcse1224@uetpeshawar.edu.pk">14pwcse1224@=
uetpeshawar.edu.pk</a></span><span style=3D"font-size:12.8px">&gt;</span></=
div><br><br><div class=3D"gmail_quote gmail_quote_container"><div dir=3D"lt=
r" class=3D"gmail_attr">On Tue, Aug 12, 2025, 19:43 Thomas Monjalon &lt;<a =
href=3D"mailto:thomas@monjalon.net">thomas@monjalon.net</a>&gt; wrote:<br><=
/div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-le=
ft:1px #ccc solid;padding-left:1ex">There are some devices supporting 800G =
speed,<br>
and it is well standardized in IEEE.<br>
<br>
Signed-off-by: Thomas Monjalon &lt;<a href=3D"mailto:thomas@monjalon.net" t=
arget=3D"_blank" rel=3D"noreferrer">thomas@monjalon.net</a>&gt;<br>
---=C2=A0<br>
</blockquote></div></div></div>

--000000000000ce4d6c063c343497--
