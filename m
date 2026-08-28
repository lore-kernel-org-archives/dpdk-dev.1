Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EC75C61DB9
	for <dpdk-dev@archiver.kernel.org>; Fri, 28 Aug 2026 22:18:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 65887402BB;
	Sat, 29 Aug 2026 00:18:48 +0200 (CEST)
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com
 [209.85.210.178])
 by mails.dpdk.org (Postfix) with ESMTP id 0F34E40151
 for <dev@dpdk.org>; Sat, 29 Aug 2026 00:18:46 +0200 (CEST)
Received: by mail-pf1-f178.google.com with SMTP id
 d2e1a72fcca58-84f3ab8750cso1237965b3a.0
 for <dev@dpdk.org>; Fri, 28 Aug 2026 15:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1787955526;
 x=1788560326; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=H2Wqh4jhN/94fzmUdk1Y4e7sUJ4i1X+D51bMa8D/RYk=;
 b=sd/Ko/EFCIIl+7pUwjpYIUUhCj0tiEwLEpTTXqg+IgDfmXu3OBggar+m042nAWg9pc
 aTzpS76ed1d1cxOZUuA6vk2UIMJpBYiRqe2MZZxt4Fi4yPPZky/iNd+AXfIG6EV6G68a
 PS/eeilJZglD9YnxxAAOREM6x0DMms7Jan/MTwGaHQDL/pCdo94ElGbTamX7sy6bKCIW
 OquEc+FTsBFPFR04JSkaPbk9a/0D9610W3WfNZwpvRpS4dGc/tDIiJBUCmYyj+Qf9OQh
 harnKHzruwOPF2gM4uYpp+sAiCLo1HA3wRpyc3ZMD8clXsa1+Zf6pVScEE/fYYxP++Z8
 1sig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787955526; x=1788560326;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=H2Wqh4jhN/94fzmUdk1Y4e7sUJ4i1X+D51bMa8D/RYk=;
 b=riUPhhEopnUIR89X2/quf6MNmBhf+GnWecCT075ngaDKyqdPwW1QRvkzf7UDPrBfUt
 DqRzJCsWgGwkVFwyeqAgExE7YShQcFbnME4TBCT4+dNPu/LBEfBj+EZ2P/qYZ37K3F1h
 Sq6pSwbNM1VMzAEo3u5seJNuZ40FX1de7njgpjhbNhdIIP+Hn+jGoH/rFSgkocGwPZSU
 rw/vNv4lG5iF6VnW7L+O63y9+AbiR2kbUQtwbseQm9mDKNfdj0I5tIVEKuINswCDvX5P
 gi1QY+R1BKZ7HMvOkM2ibMLu846thApAIuQJ5dOaZLNGDDs3zyvZ6RUE6QWGfWaRWJhG
 KF0A==
X-Gm-Message-State: AFuF++lHP4SQAiTX7E6bktgUngShCvgSfXA4mtcpmPdilI1msLtJJBYe
 6bIpDljXizEjYl7/ua1nqjDs3Cah0A73db8XIkGHbejVWNeZ6YUMFxO2q9f86VWNn0w=
X-Gm-Gg: AR+sD11ur1j0McAaOvsSOp4U/uQQn/01lgv37QI64aj6OiOhRWKVGi1NEAdHoAgmAje
 pSpWv0uIS+SnuSRpHAHH7ik6whLz5PtFw8Op+203LbPF9gpimJM4BI+vGENu+8VLtXDrIxf1X+j
 SBPL5mOXLY3Dj2E6M7icKOY56Mw/ZEwNQ7hLpBJ1Zd5bzYJKNC4SKo1CwDhRkvDk6+fyNFeujqt
 xC28EmduTjIzyd+sEj1uppVdt+CrMe36/7fujWusk0DbmacQKp2nypyZu9cbySxNg8V7PC1enhS
 ndzoYi6s8DUtENkbOH9OUJcz7IsMttk+A5HiXd+M+Ko0ClwxswelyUxWguL5Fi3P0L6pUOKXW13
 WtOz90mHETs3uslOrum4lrauEAlDcSxwgJ8D1C/RRI54zGwsCguYeqmukl8gdqyh9rj8MlGFQcR
 Vz549QGcLBUz+1A0L/vb9AtEOm47xcIkxX7dIscG/Dg/qLicn/luOh1vH8QZdDTk+x8q/8Y898R
 JNOxEif17AvRDv+XEGht+anQ6Oo2Q==
X-Received: by 2002:a05:6a00:1151:b0:857:7384:b5f8 with SMTP id
 d2e1a72fcca58-8577384c289mr3729270b3a.20.1787955525850; 
 Fri, 28 Aug 2026 15:18:45 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8569cc4bba4sm965457b3a.0.2026.08.28.15.18.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 15:18:45 -0700 (PDT)
Date: Fri, 28 Aug 2026 15:18:33 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc: dev@dpdk.org, Guillaume Gardet <Guillaume.Gardet@arm.com>, Anatoly
 Burakov <anatoly.burakov@intel.com>, Sivaprasad Tummala
 <sivaprasad.tummala@amd.com>, Lee Daly <lee.daly@intel.com>, Marcin
 Hajkowski <marcinx.hajkowski@intel.com>
Subject: Re: [PATCH RESEND] examples/vm_power_manager: add missing
 <stdlib.h> header include for strtol
Message-ID: <20260828151833.1d4e92d0@phoenix.local>
In-Reply-To: <20260828215350.2861715-1-thomas.petazzoni@bootlin.com>
References: <20260828215350.2861715-1-thomas.petazzoni@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

On Fri, 28 Aug 2026 23:53:50 +0200
Thomas Petazzoni <thomas.petazzoni@bootlin.com> wrote:

> From: Guillaume Gardet <Guillaume.Gardet@arm.com>
>=20
> strtol is defined in stdlib.h
>=20
> Fixes the following build failure:
>=20
> ../examples/vm_power_manager/guest_cli/vm_power_cli_guest.c: In function =
=E2=80=98cmd_query_freq_list_parsed=E2=80=99:
> ../examples/vm_power_manager/guest_cli/vm_power_cli_guest.c:208:42: error=
: implicit declaration of function =E2=80=98strtol=E2=80=99; did you mean =
=E2=80=98strtok=E2=80=99? [-Wimplicit-function-declaration]
>   208 |                 lcore_id =3D (unsigned int)strtol(res->cpu_num, &=
ep, 10);
>       |                                          ^~~~~~
>       |                                          strtok
>=20
> Fixes: 0e8f47491f090f44a4956429cb27f6942b6618b0 ("examples/vm_power: add =
command to query CPU frequency")
> Signed-off-by: Guillaume Gardet <guillaume.gardet@arm.com>
> [Thomas:
> - retrieve patch from
> https://build.opensuse.org/projects/openSUSE:42:Factory-Candidates-Check/=
packages/dpdk/files/0001-examples-vm_power_manager-add-missing-header.patch=
?expand=3D1
> - improve commit message]
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
> ---
>  examples/vm_power_manager/guest_cli/vm_power_cli_guest.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/examples/vm_power_manager/guest_cli/vm_power_cli_guest.c b/e=
xamples/vm_power_manager/guest_cli/vm_power_cli_guest.c
> index 4114593cee..63a59c8b10 100644
> --- a/examples/vm_power_manager/guest_cli/vm_power_cli_guest.c
> +++ b/examples/vm_power_manager/guest_cli/vm_power_cli_guest.c
> @@ -6,6 +6,7 @@
>  #include <stdint.h>
>  #include <string.h>
>  #include <stdio.h>
> +#include <stdlib.h>
>  #include <termios.h>
> =20
>  #include <cmdline_rdline.h>

There is a pre-existing bug here. strtol() can returned signed value.
Probably should be using strtoul
