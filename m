Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ABD0CED25D
	for <dpdk-dev@archiver.kernel.org>; Tue, 18 Nov 2025 09:52:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 67DA540281;
	Tue, 18 Nov 2025 10:52:25 +0100 (CET)
Received: from out-cbk.mail.syseleven.net (out-cbk.mail.syseleven.net
 [195.192.142.27])
 by mails.dpdk.org (Postfix) with ESMTP id DFCB240150
 for <dev@dpdk.org>; Tue, 18 Nov 2025 10:52:23 +0100 (CET)
Received: from 127.0.0.1 (localhost [127.0.0.1])
 by out-cbk.mail.syseleven.net (Postfix) with ESMTPSA id 0AEEF3F0D4;
 Tue, 18 Nov 2025 09:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=syseleven.de;
 s=2022n001; t=1763459541;
 bh=BS55MFfihoy2FQ31V9aZL/M8QIAzeoZwUKCjRytihzg=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
 b=UNarQqDBPMJ0riYoS5/rsgfZ4rw10izLcbmxMetUpNXtSx9ji8cZ04CpIUXSxMHjz
 W7P8ZDtYoVsYqmtqixDEFGhi9woB1MBHqg8tWHR3InAYR7KtBulUlVZsEU9WHwjsnW
 fAU3+dB9qJ2lA/1Odw3vFL8R4tgRqTUveQ9qivckuGVro+20Jk9oH5Loc8SpXACw9p
 o/ewfiNA5J3pU3my4VhyDydakrms1b4PNLYsv2KJUXEj5LZEHab4smLKfrpcYuSTwU
 zhcbsmnHgkDNm7MaMyrKk4xwKYcIy0VSh84JgaA7/NqHCGYQtI/1v1e90YfK+qXRIl
 HRbDivyqUwXyQ==
Message-ID: <fc77013fe328b69749cab274ad89c7f1d15f47c0.camel@syseleven.de>
Subject: Re: [PATCH] net/mlx5: update stored Rx queue MTU when port MTU changes
From: Adrian Schollmeyer <a.schollmeyer@syseleven.de>
To: Shani Peretz <shperetz@nvidia.com>, dev@dpdk.org
Cc: rasland@nvidia.com, Dariusz Sosnowski <dsosnowski@nvidia.com>, 
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao
 <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
Date: Tue, 18 Nov 2025 10:52:18 +0100
In-Reply-To: <20251117073937.1514124-1-shperetz@nvidia.com>
References: <20251117073937.1514124-1-shperetz@nvidia.com>
Organization: SysEleven GmbH
Content-Type: multipart/signed; micalg="pgp-sha512";
 protocol="application/pgp-signature"; boundary="=-KS9u2zJHxtEA425GYSvH"
User-Agent: Evolution 3.44.4-0ubuntu2 
MIME-Version: 1.0
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


--=-KS9u2zJHxtEA425GYSvH
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Am Montag, dem 17.11.2025 um 09:39 +0200 schrieb Shani Peretz:
> Offending commit added rxq_ctrl->mtu to track MTU at queue
> allocation time for validating shared RX queue compatibility.
>=20
> When MTU changes via rte_eth_dev_set_mtu(), only priv->mtu was
> updated, leaving rxq_ctrl->mtu with the old value.

If you read the commit message of the offending patch, this was in fact
intentional. The MTU at allocation time is relevant when joining a Rx
share group, as it is (to the best of my knowledge) the only MTU
setting that actually has an influence on the size of the packet
buffers. Therefore, it is the value which is relevant for sharing
packet buffers.

I've tested your patch again with the prototype I used to discover the
original bug and unfortunately it reappears.

Best regards,
Adrian

--=20
Adrian Schollmeyer

SysEleven GmbH=20
Boxhagener Stra=C3=9Fe 80=20
10245 Berlin=20

T +49 30 / 23 32 012-0
F +49 30 / 61 67 55 5-0=20

https://www.syseleven.de=20
https://www.linkedin.com/company/syseleven-gmbh

Current system status always at:=20
https://www.syseleven-status.net/=20

Company headquarters: Berlin=20
Registered court: AG Berlin Charlottenburg, HRB 108571 Berlin=20
Managing directors: Andreas Hermann, Jens Ihlenfeld, Jens Plogsties,
Andreas R=C3=BCckriegel



--=-KS9u2zJHxtEA425GYSvH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErl0Mi1pV5uGCoyMrfIq1KN9YvTsFAmkcQdIACgkQfIq1KN9Y
vTtcDBAArKGgggKoYbEzbhn5q7NptC8mpUoBz3PflbfoALpwon6xIi4seCnQ9w61
p1tVmBTQlFbhSGkavSVkuaJM6/lhx3JrxcIcPJdA9L0+2ff9GsXSKCBuXgRSsXDn
aqU+NSCmQJ23chWm6z6GGqrkFUr+t/b3qjfDh6OZveUjVr0rPmz6SB3DwbH4RedT
AtlK+KjPvpFu3wKeqbmHQu5KupOd5KE79/JKiROHLafYYvIea3LLqVBzONaotAeE
mYjzqwpp2WIz/ALx7o1Txo8lqxXqPmoE1Y2hO4uLKahMsNq7DlqhiIMD3aHUOrmS
v1KdOuCSDgEGtviIgvV5ujtJyfq16/4KvOttzHyi+Fh5W/Q7oWGnRVlhSBFJYqwR
9wJLZmycy7598Olro0djY+4OiNMvDsZCS/8UTn7upSzSxCXUDPVe8JXSYVbptC/6
f0+rjTM9D7aZGbTx8NN2VN3R7dLe0KbpVBEnTmNziAe/1SdgkfQE7Vswl9mmYlVf
jMRVKVtNbg7TwvgJkHIFUzP5SXw9JQa6+vVjFRuy4j16Z8/ZZrWaCeN1oVri2Dzb
hLooyTCrJ5P5fAGDZxVnnW48aKNlnFXztTb+u+GWy21oQhoUuu74pheLXBGnOyV9
fEvKYSr0FkW/O83c+YqwJkFwUvlqw71J5+QSOnu12HM+6FvY2ok=
=7ELa
-----END PGP SIGNATURE-----

--=-KS9u2zJHxtEA425GYSvH--
