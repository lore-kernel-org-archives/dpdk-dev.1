Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0068CCF9F1
	for <dpdk-dev@archiver.kernel.org>; Thu, 30 Oct 2025 11:21:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 92DC14027A;
	Thu, 30 Oct 2025 12:21:55 +0100 (CET)
Received: from out-ham1.mail.syseleven.net (out-ham1.mail.syseleven.net
 [151.252.42.30])
 by mails.dpdk.org (Postfix) with ESMTP id 447024026F;
 Thu, 30 Oct 2025 12:21:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=syseleven.de;
 s=2022n001; t=1761823313;
 bh=KxONzt7JVjD6AzfHFIiO+j1nB5Bo75OQjDqznQdI8Ec=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
 b=SODQD9m6Ia1wDCbdQQxVDvOiMItfz3WDIqocajixBblussJ616/A28qFj6RrX+32O
 NUy1ifucUHPlGMDzKifIwHo3GLc3qOVf0JvI2XRd5FI4DlaVgJtKgY55eEwou3CAXW
 jD2Qz2PS7FgBgGhuYdf2gaJqyHVPiOl6M4rnsZCegBy0556aI+etR7BCs1xR1QE3Vo
 kMRkIiH+ZPy8UNiLzCStwVP/OgVmOyIMhtL562BO7BpHSN3PDQ1ki7g7OcbU0ed7H1
 OMWDI+CuaMWYRFXnhmvd05BbxaCws4toOQ1SCRefCKYojyIkMii5pZIIXdKopWWpgZ
 OmhaOuqkixVCw==
Received: from 127.0.0.1 (localhost [127.0.0.1])
 by out-ham1.mail.syseleven.net (Postfix) with ESMTPSA id 3420545087;
 Thu, 30 Oct 2025 12:21:53 +0100 (CET)
Message-ID: <ad4b00f0597538b9a5ac5c8ef59b921bde2791a8.camel@syseleven.de>
Subject: Re: [PATCH v2] net/mlx5: store rxq MTU at allocation time
From: Adrian Schollmeyer <a.schollmeyer@syseleven.de>
To: Dariusz Sosnowski <dsosnowski@nvidia.com>
Cc: Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao
 <bingz@nvidia.com>,  Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>,  Xueming Li
 <xuemingl@nvidia.com>, dev@dpdk.org, Michael Rossberg
 <michael.rossberg@tu-ilmenau.de>,  Erez Ferber <erezf@nvidia.com>,
 stable@dpdk.org
Date: Thu, 30 Oct 2025 12:21:51 +0100
In-Reply-To: <20251030104009.cx74wmofh6ljsukv@ds-vm-debian.local>
References: <20251028100144.36284-1-a.schollmeyer@syseleven.de>
 <20251030091313.55152-1-a.schollmeyer@syseleven.de>
 <20251030102155.m2uk2us7vzgh3k7h@ds-vm-debian.local>
 <20251030104009.cx74wmofh6ljsukv@ds-vm-debian.local>
Organization: SysEleven GmbH
Content-Type: multipart/signed; micalg="pgp-sha512";
 protocol="application/pgp-signature"; boundary="=-aMbO+Vnlz2NZh43fLOGj"
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


--=-aMbO+Vnlz2NZh43fLOGj
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Am Donnerstag, dem 30.10.2025 um 11:40 +0100 schrieb Dariusz Sosnowski:
> Could you please change the state of previous versions of this patch
> to "Superseded" in Patchwork?

done. I hope everything should be okay now.

Best regards,
Adrian

--=20
Adrian Schollmeyer

SysEleven GmbH=20
Boxhagener Stra=C3=9Fe 80=20
10245 Berlin=20

T +49 30 / 23 32 012-0
F +49 30 / 61 67 55 5-0=20

https:// www.syseleven.de=20
https://www.linkedin.com/company/syseleven-gmbh=20

Current system status always at:=20
https://www.syseleven-status.net/=20

Company headquarters: Berlin=20
Registered court: AG Berlin Charlottenburg, HRB 108571 Berlin=20
Managing directors: Andreas Hermann, Jens Ihlenfeld, Jens Plogsties,
Andreas R=C3=BCckriegel

--=-aMbO+Vnlz2NZh43fLOGj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErl0Mi1pV5uGCoyMrfIq1KN9YvTsFAmkDSk8ACgkQfIq1KN9Y
vTu9bw/9FMWk7SAVmnZzJzxGrpumdYAQqdvZFOhN/22Nun6Tt9h+UJVtA5zTG4Eu
bv0KY0XSwvEK6/+iRkBn7ftjWmL8MlSUP14e1mMM/OIg7KxZfHmHRqDSljm5hQd2
dPoVJg4MIDFG9SysG66nRIcdIfU7ngFKgn00Q2AbtTn+ko7yXStTqxP4YRyYIGBm
n6rX1rWMlo/n2FPX1tcEJCC/DqCUSBgUahoeWe9Q9E0EYfA4kD97R39rMC8ri7hT
d19KXb2C1FU2KTBUZBY0K46Pl+1QhXO+m7uLiyTvRfTEdBYey6gceIfmpEpv7GHw
Y4v2GPxl9UGuUSFHwxNrmngHmxuQcWH49tIcH1KNi42LsxxzA76mXka9q3jrorJW
QEGBJFeYI72+IiHm6RVHqZl6+ADGtOq0rfzYQ9Qvo79uxPUZ+c0kaIWEwgGGcD/8
YwhHhAv6ELG/q3/fHoegJkfOmRYo3hEYI/K2W5qzRd/ecok5BXevPB8nznkbTFLj
N4Krr2flj3ujOcF5jgPsrubpQjykGp9bmBQ1f5inOlG3m1JNqpdIV7qezc7iIIrT
rQby4ppdmvegcUWGia87CQt5TTAk0la1Eo++nlO7GzlHqvXaKEz/80eAUgQhgEzh
L+hFVRBZZCrtikhAZCwoENj11sgM+sT7PqdI+iF7VakTc5QQ/8U=
=hVHH
-----END PGP SIGNATURE-----

--=-aMbO+Vnlz2NZh43fLOGj--
