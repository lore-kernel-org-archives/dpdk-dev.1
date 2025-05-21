Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CE20C54E71
	for <dpdk-dev@archiver.kernel.org>; Wed, 21 May 2025 13:57:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 87EC7427E2;
	Wed, 21 May 2025 15:57:46 +0200 (CEST)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com
 [209.85.208.48]) by mails.dpdk.org (Postfix) with ESMTP id 917CF427D5
 for <dev@dpdk.org>; Wed, 21 May 2025 15:57:45 +0200 (CEST)
Received: by mail-ed1-f48.google.com with SMTP id
 4fb4d7f45d1cf-601fb2b7884so5202351a12.2
 for <dev@dpdk.org>; Wed, 21 May 2025 06:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1747835865;
 x=1748440665; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OFrBGea4IMt4vg5i/HNcbVnhIEcypIyQTG6yQZXHHdQ=;
 b=Xgj6YlzWXSA98A7MSxk6EHuN9n+/4mWSwbNJNXR4TM1+d6ZZ0BsBLQzM2oBiOu5lwM
 asyeimDCqjcRj7WJqmC0JDK4RUQdWkHkGkk2mNrGLFWxC7BOKSDXTxTfOiSZ5D1fWkCK
 CTcfJxwgyBpb991qpiBn7VgNXzdQ77B6k0lxdei7Kxfk0tRwXKjHX1/DG2EZMmG+Avkz
 Vmde2V1vaCtYqj59fMqblgleiZgQClwfUofZnJVfxJCd/+J1/1p7wHfnZ+m9P6csb4c/
 TAT7NnttHAJfhiQSgnAn9Sci06Xo1B91PjdKqITC18O/HVYbrMmOuDOjcmsyyZ3yPkTX
 /SYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747835865; x=1748440665;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OFrBGea4IMt4vg5i/HNcbVnhIEcypIyQTG6yQZXHHdQ=;
 b=dbtDv4hgp1JAzlHQPp6VJ/KkfsJK3oe7lZhuR/N76GdFIkFMtoMAFyLUXsSZ5MbKjk
 vwqVvRtgsuKyFShPI9mBa7YZhRpdBm129MtiOBMUm6VoICgr9Uh0rcnnqgXAwifDiBws
 r50zjyTTK9LLxWTlKkinhyU7CGWMdHASbs+abCJ/pnJza6eibBVWI6m28LdledHJRcuM
 5F2u7JR7TZaHLztC2COGjTQpoPFRjyyJRlANX3lADO4tbPxauuG+9hNQo2Y2a1l2fd/3
 Gml/a0fSLSxEsNktkJsMHaWoWRCzz3MSiXJEuSscWdNYu0GLUHGl9UqIXTkr6ftyZPD7
 CPeQ==
X-Gm-Message-State: AOJu0YyS2j635vPZe/bg4NUMtauGgsWZbFzMfg0jUzJykpaoNYcL7Qyg
 4nZu2b/ukWxaWinkj4AAD4EkxO0M9hChQSCxZ45NluVmQkSjzM+HMUhhumUdSM0xn/LghbA70T8
 m+Khh
X-Gm-Gg: ASbGncs0/2vZWYHN0SoH747tBaVf+oeFriyKUwGDpb7TL1+SDe3wIG4JLNV5Ye0dooq
 0/RHnK0vztG+qEt14+i+DN8XtusTLuFWqkfi1eTrLKHlTev627euU3VMEg3rgaqMbojbeRxY3z2
 1GZ1iEWGbdCtLX4PgpTnqQgxKTpd05NaiWcZF/ufz2zbdBod66XRdGzh5aAsfMl5Rvi2OdQdp1O
 U6amS4N9EEbsMryNoRED56rXL55vyD1kSoT+T0rG9+OBTmYdRUGIiz+5XXAT4IPk8NP5OCvsnQL
 bnANn64N2QYUI5ABYbg2sdi3MrVpxmhyHtTe3Bvu+5sCTJ4sCg2whY6lnx01bMS2lIBnWvWdhFU
 6UwZUPJf8YVQJTuOJs/frK6qrjoWM
X-Google-Smtp-Source: AGHT+IFi1qAVQ+ROmbv1uUYqIJyq4KNqi4NCwKbhQU74xkUMBOUmVLuqci0OEB1ythKIPjyJV6OnZA==
X-Received: by 2002:a17:907:3e03:b0:ad4:c55e:ef8b with SMTP id
 a640c23a62f3a-ad536f9db9emr1701836166b.48.1747835864927; 
 Wed, 21 May 2025 06:57:44 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad52d4c9e56sm902511566b.156.2025.05.21.06.57.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 May 2025 06:57:44 -0700 (PDT)
Date: Wed, 21 May 2025 06:57:37 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Sunyang Wu <sunyang.wu@jaguarmicro.com>
Cc: dev@dpdk.org, thomas@monjalon.net, ferruh.yigit@amd.com,
 andrew.rybchenko@oktetlabs.ru, Morten =?UTF-8?B?QnLDuHJ1cA==?=
 <mb@smartsharesystems.com>
Subject: Re: [PATCH v2] ethdev: optimize how the values of the flag
 variables are assigned
Message-ID: <20250521065737.45cef281@hermes.local>
In-Reply-To: <20250521101531.34240-1-sunyang.wu@jaguarmicro.com>
References: <20250521101531.34240-1-sunyang.wu@jaguarmicro.com>
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

On Wed, 21 May 2025 18:15:31 +0800
Sunyang Wu <sunyang.wu@jaguarmicro.com> wrote:

> Set the values of the promiscuous and all_multicast variables
> according to the return value.
>=20
> Signed-off-by: Morten Br=C3=B8rup <mb@smartsharesystems.com>
> Signed-off-by: Sunyang Wu <sunyang.wu@jaguarmicro.com>
> ---
>  lib/ethdev/rte_ethdev.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
>=20
> diff --git a/lib/ethdev/rte_ethdev.c b/lib/ethdev/rte_ethdev.c
> index d4197322a0..c27d3e5041 100644
> --- a/lib/ethdev/rte_ethdev.c
> +++ b/lib/ethdev/rte_ethdev.c
> @@ -3044,10 +3044,9 @@ rte_eth_promiscuous_disable(uint16_t port_id)
>  	if (dev->dev_ops->promiscuous_disable =3D=3D NULL)
>  		return -ENOTSUP;
> =20
> -	dev->data->promiscuous =3D 0;
>  	diag =3D dev->dev_ops->promiscuous_disable(dev);
> -	if (diag !=3D 0)
> -		dev->data->promiscuous =3D 1;
> +	if (!diag)
> +		dev->data->promiscuous =3D 0;
> =20
>  	diag =3D eth_err(port_id, diag);
> =20
> @@ -3112,10 +3111,10 @@ rte_eth_allmulticast_disable(uint16_t port_id)
> =20
>  	if (dev->dev_ops->allmulticast_disable =3D=3D NULL)
>  		return -ENOTSUP;
> -	dev->data->all_multicast =3D 0;
> +
>  	diag =3D dev->dev_ops->allmulticast_disable(dev);
> -	if (diag !=3D 0)
> -		dev->data->all_multicast =3D 1;
> +	if (!diag)
> +		dev->data->all_multicast =3D 0;
> =20
>  	diag =3D eth_err(port_id, diag);
> =20

Code is fine, but the commit description is misleading.
It is not an optimization, it is a bug fix so that flags
are not set if device callback returns an error.

An optimization is something that is faster but has the
same effect.
