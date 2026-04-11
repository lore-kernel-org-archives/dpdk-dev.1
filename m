Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AB30F3ED44
	for <dpdk-dev@archiver.kernel.org>; Sat, 11 Apr 2026 10:24:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 68F02402D7;
	Sat, 11 Apr 2026 12:23:59 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id A3A83402A3
 for <dev@dpdk.org>; Sat, 11 Apr 2026 12:23:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775903037;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/fsiiaQVxfkKANqwU7HBtpUx1yCa3+PB0nD0Nk6uEE4=;
 b=H6J2mu8yqkoiwLl9Tk9LLKyou/sZeK+naHjFvEQesVLF89h26BHu56IfPhdMNLJWJJIJbe
 PFItfmHrZrOhG2GaAeAJGoi/Zs8bqOPxwuUPsE+4PgBeyDFauBkuvD2hBT7PDQY9S75FGk
 HuttKZeTL74WqnlZ3ICNhcUznz/mbMM=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-OUPZh6huPAqVxTMg-acgVA-1; Sat, 11 Apr 2026 06:23:55 -0400
X-MC-Unique: OUPZh6huPAqVxTMg-acgVA-1
X-Mimecast-MFC-AGG-ID: OUPZh6huPAqVxTMg-acgVA_1775903034
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-59e16c11f49so2430458e87.0
 for <dev@dpdk.org>; Sat, 11 Apr 2026 03:23:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775903034; x=1776507834;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/fsiiaQVxfkKANqwU7HBtpUx1yCa3+PB0nD0Nk6uEE4=;
 b=kgUa9pQwmkq/xcHc6NVWKUl5dzJRp3pN1Wvw1LL2/ynvr8G6WShDYYHVkhddsXDlRY
 GQrfpadq50n0sRO2O/QT4/Y/oi8UtKg3etTB8wWCWD8DOXkO9SeKpwfxDSeYS7LNU2gU
 j1aTyrq4rLbld+C2Q94KZQvXFV4j8HtiitW5LXU9ptogGRCyUmdJDoAROb1kwstfnPuh
 3CZL5k7FdKEU6LHBQluA8Z652JxN6TsZMGvB8QrwDZunWxT6SpwhIhjSquX9cJQd9Hrm
 yztrYM1hmiJuea50nY/zs0VwFSdk4hMgYVxJDLxoUR5PUEU00CyLieKS3nNg0tLNgDKv
 2FgQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU4kIlbZ/fonE9CsnNpNBmnW9Smietr+Fz42rYrAC3Tcuf12ANNiGekDUJbw7hYUzPvTdw=@dpdk.org
X-Gm-Message-State: AOJu0YzW4/s/EfROSa2Q6S0JQDxWsAXvj7poG9xMfbqw2EiJe4oQ6Lhr
 GeNxrp+lN+xDj6M94e0vpJ0f6nX42U5UqAohNlOuT5UM242KEDp6DGZol0r8Fy7A+Nu7WYB8raP
 jwMAEsBeWpiPMf5l4YbnWiAGWbO3pN8keYHCVWMewok4paHoFXx3pR2qNdSmak6BS0Kwo9F5363
 snzXoAGhz05ZEI458Wg00=
X-Gm-Gg: AeBDieuejP0WIZBNXJEJ5YDnpsPJ1KGLxzHCiBZK46nFPBI+zNqDsqIyV79s2Y4nUZW
 5mQp7Bg/wGXP+BO+TY7Fy2l6tRxZWFcr3VDkqx7k91Ard5mDen/k7nIysgUp0oSic4i7Iv6VOa5
 6E0Gf6guKX3tb7JdgY4F7MjpJgvarZNe15/UdXzIcn+JRiZm6bqOQtIcozpWtVHZvaN5Z1YzB1+
 RF1LEOso7a+5qMmgivFOHAWuniui3Q+rlCbTPv4V2aGWQCJpDUsCYtmMMJDq0kv3oTtpw==
X-Received: by 2002:a05:6512:3b0e:b0:5a3:d2ef:2f9f with SMTP id
 2adb3069b0e04-5a3efb2d330mr2671216e87.20.1775903033960; 
 Sat, 11 Apr 2026 03:23:53 -0700 (PDT)
X-Received: by 2002:a05:6512:3b0e:b0:5a3:d2ef:2f9f with SMTP id
 2adb3069b0e04-5a3efb2d330mr2671201e87.20.1775903033435; Sat, 11 Apr 2026
 03:23:53 -0700 (PDT)
MIME-Version: 1.0
References: <20260323105306.1531689-1-david.marchand@redhat.com>
 <20260407115211.1903623-1-david.marchand@redhat.com>
 <98CBD80474FA8B44BF855DF32C47DC35F657DF@smartserver.smartshare.dk>
 <CAJFAV8xPCsHY4OFLy19jDv4KgVbZotn1pobNGhokbuQcY1AniQ@mail.gmail.com>
In-Reply-To: <CAJFAV8xPCsHY4OFLy19jDv4KgVbZotn1pobNGhokbuQcY1AniQ@mail.gmail.com>
From: David Marchand <david.marchand@redhat.com>
Date: Sat, 11 Apr 2026 12:23:41 +0200
X-Gm-Features: AQROBzD5hOd0eUlsY5n-8xbwpRf3wozIPAnbq1HtEh90hPe9olHNVxuMIxcTlxI
Message-ID: <CAJFAV8yNpbuK=34NdPQsiZoT7aS=eeen0_rB53q1gsp9ZEumrg@mail.gmail.com>
Subject: Re: [PATCH v3 0/7] Rework device probing
To: =?UTF-8?Q?Morten_Br=C3=B8rup?= <mb@smartsharesystems.com>
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Robin Jarry <rjarry@redhat.com>, 
 Hemant Agrawal <hemant.agrawal@nxp.com>, Maxime Leroy <maxime@leroys.fr>, 
 Kevin Traynor <ktraynor@redhat.com>, dev@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: imLbbokIL1-UCHTHvyvLhv0S4UvT6BkeebPDuuf8woI_1775903034
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Sat, 11 Apr 2026 at 12:10, David Marchand <david.marchand@redhat.com> wr=
ote:
>
> On Fri, 10 Apr 2026 at 16:35, Morten Br=C3=B8rup <mb@smartsharesystems.co=
m> wrote:
> >
> > Is there a workaround until this patch is added, if I don't want rte_ea=
l_init() to probe any devices, but I want my application to probe devices l=
ater by calling rte_bus_scan() followed by rte_bus_probe()?
> >
> > It's not something we really need, so if you don't know it off the top =
of your head, don't spend time trying to figure it out.

Some (untested) other idea... write some "plugin" loaded last (via
-d), that would list all buses, then unregister all of them (or a part
of the list, for buses known to be a problem..).
IOVA discovery would end up as DC, so probably fine (and we have an
option to force it if needed).

Then after call to rte_eal_init, the application would get a hold of
this list, re-register buses... ?

I think it could work, but clearly hacky...


--=20
David Marchand

