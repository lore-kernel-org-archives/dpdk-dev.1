Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82018CC6B0E
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Oct 2026 08:27:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6B73E40272;
	Tue, 13 Oct 2026 10:27:37 +0200 (CEST)
Received: from out-ham1.mail.syseleven.net (out-ham1.mail.syseleven.net
 [151.252.42.30]) by mails.dpdk.org (Postfix) with ESMTP id 4A6DF400D6
 for <dev@dpdk.org>; Tue, 13 Oct 2026 10:27:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=syseleven.de;
 s=2022n001; t=1791880055;
 bh=Kn/IQp4ORWXBorZUeF/X1sIKlu0myCP5DIjcw11WJMk=; h=From:From;
 b=Dvb0QkR/8egoXH7TT0ICVSnK8cA21198G5WSWOEbC2b5ObC2dIcLPcfHbT/goA0qP
 fuPtV4RAQ9+qwjAOMVy2r3iZ3+Pck3qaJTJg7UnkKymikMaRMxMHbBjSv8C760OYX5
 gLoh8PsTrFu9HdbSM3Bk+9nKeR67zU7aPTp/PLSc76oGO9tR5eZBs4f6HTTq1O+PFF
 Nxy6xEHFUvLTK9Aid5WDxWxD3vcQWL9LNMPOGLi6+bdoc4mXTSWXISW4cesz3ouDfQ
 EjsJg19W7OjBBoKNkEwYd9EU81lKpXk8nahHqxA8af6FcL9hgTGyK3kcZL4L6+i2bX
 wjh5Ne1apJWRg==
Received: from 127.0.0.1 (localhost [127.0.0.1])
 by out-ham1.mail.syseleven.net (Postfix) with ESMTPSA id B408A40BE9;
 Tue, 13 Oct 2026 10:27:35 +0200 (CEST)
Message-ID: <54667e512558ee763d5161cc2cae8eb10a23eab2.camel@syseleven.de>
Subject: Re: [PATCH v2] build: fix cross compilation to x86_64
From: Adrian Schollmeyer <a.schollmeyer@syseleven.de>
To: Thomas Monjalon <thomas@monjalon.net>
Cc: Bruce Richardson <bruce.richardson@intel.com>, dev@dpdk.org
Date: Tue, 13 Oct 2026 10:27:33 +0200
In-Reply-To: <gO2lw07QSVubxmsBdHTdeg@monjalon.net>
References: <20261005125943.678879-1-a.schollmeyer@syseleven.de>
 <20261007092637.916513-1-a.schollmeyer@syseleven.de>
 <gO2lw07QSVubxmsBdHTdeg@monjalon.net>
Organization: SysEleven GmbH
Content-Type: multipart/signed; micalg="pgp-sha512";
 protocol="application/pgp-signature"; boundary="=-dkeNd+0eZ1F3YbNShl3b"
User-Agent: Evolution 3.52.3-0ubuntu1.1 
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


--=-dkeNd+0eZ1F3YbNShl3b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Am Dienstag, dem 13.10.2026 um 09:49 +0200 schrieb Thomas Monjalon:
> Can this change be in config/x86/meson.build ?

Unfortunately, I don't think so. In case of cross compilation to
x86_64, cpu_instruction_set =3D=3D 'x86_64' at the location where I put the
conditional. This causes the arch support check a few lines below my
patch to be triggered and fail. The arch-specific config is only
included later in the code. Thus, a conditional in the arch-specific
file would still cause the Meson error.

--=20
Adrian Schollmeyer
Cloud Security Engineer
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
Managing directors: Andreas Hermann, Jens Plogsties, Andreas R=C3=BCckriege=
l





--=-dkeNd+0eZ1F3YbNShl3b
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErl0Mi1pV5uGCoyMrfIq1KN9YvTsFAmrN63UACgkQfIq1KN9Y
vTv7Dg/+NKe+HIteilKf1bchPAAMps25CjRU67ZvcCcswN3PAwQXfrG1WgjCoHkN
hsmhO0m/GRwOIR4NogmSsZfJJBA7cznkH9gT0dZSaHEsKC62qmA/jI5yazAfL4zO
r0bvJNtIFtDkWIZfw5bJigadEFtlLwzg4LY9j8ghMpCJe1khPzrLhTp1z2h0LS1L
dMtuncK+lY5ig8IlVWd8iUQZBjq//cFoG5zRKHa8odXXyM//eYXCF7IJ0KluJvEy
6p0nEe6vyIlvQm7e4x+R6iXFDwqcpX9qvzZpMjZoNt5TRU4ohlxp1+5LpF/L+ggo
cbdso4s9+GvRYdamoMvI7nIf94ifWxHaVOAxJai9uKefsmzVu0fS9Daz+Zs7uA1R
+uC0omxqk4Fp1jPQfLGeMkqcl2mrMNLP81DbQfqBFb0zxGFREQlb4B+oLzbt1MU+
N1t76as5/Ky5B5P4jh2B/kWXoD0v0IesGkK+mjuaRWXwiRJD1c4y1cS02qGGQTAQ
frsmnqXti9Bs7ivhNm2iPd3V/iPAMARyptv795ylmW8EiCDGZtcm8sW87nGvQfLG
KM9XGGZqL8/8TLCfNjXt2wPkkb9uweWdsNINGyOLYb2LkX7tVWA6qBd7ki74YHle
kFlMZkF9MhwhRbsz86sdKAfPcgCRir1SiFkfNudY8/+fhTGlOOA=
=klmw
-----END PGP SIGNATURE-----

--=-dkeNd+0eZ1F3YbNShl3b--
