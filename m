Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2829F106B530
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Mar 2026 13:04:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3E8A2402CE;
	Wed, 25 Mar 2026 14:04:36 +0100 (CET)
Received: from out-cbk.mail.syseleven.net (out-cbk.mail.syseleven.net
 [195.192.142.27])
 by mails.dpdk.org (Postfix) with ESMTP id 5A42B4028E
 for <dev@dpdk.org>; Wed, 25 Mar 2026 14:04:35 +0100 (CET)
Received: from 127.0.0.1 (localhost [127.0.0.1])
 by out-cbk.mail.syseleven.net (Postfix) with ESMTPSA id 7B2783F108;
 Wed, 25 Mar 2026 13:04:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=syseleven.de;
 s=2022n001; t=1774443873;
 bh=O15hQBv1U5G4IdaYTGVUiB8sAfpbOA8/JpVV8de5v2w=; h=From:From;
 b=Aw8mmOePy3INiVD7YrsLW1N9xN4IYZQESK42/O1m9+ARrMxMfNfXNjIUreGCZ4N7z
 LwHZbIBuUE37ey4FFUoLbij2E2Zac9X45Ln6OiFXFlWOqBqOHapbRjid5GGw/UkSUI
 Qi6LX3vUCWSxGOflXmmhqxzt4DlSwUAB8Yz5+7Jdj/JL9HI64AqJs4lYrqw4k+vZe3
 IHQVycaskuAyzufQF5OOlPTaBDy8a29PCP7zU0DoPA/l4A46D/0xaa0niEPkt/t/cm
 HwqqD2IuOE+Htil/+khwbCcRKcw4HZisKZmS2VMzP1al4fS7askLDBPwfssd5acH4h
 0/JPeWt1Q6ltg==
Message-ID: <feb6b06ea37a91fb798831696d4c7e234ebbb246.camel@syseleven.de>
Subject: Re: [PATCH] app/testpmd: warn on shared rxq switch mismatch
From: Adrian Schollmeyer <a.schollmeyer@syseleven.de>
To: Dariusz Sosnowski <dsosnowski@nvidia.com>, Stephen Hemminger
 <stephen@networkplumber.org>
Cc: Aman Singh <aman.deep.singh@intel.com>, "dev@dpdk.org" <dev@dpdk.org>, 
 Thomas Monjalon <tmonjalon@nvidia.com>, Slava Ovsiienko
 <viacheslavo@nvidia.com>, Raslan Darawsheh <rasland@nvidia.com>
Date: Wed, 25 Mar 2026 14:04:32 +0100
In-Reply-To: <CH2PR12MB9541F8CC6EBE612A415B8B59A448A@CH2PR12MB9541.namprd12.prod.outlook.com>
References: <20251125102207.428661-1-a.schollmeyer@syseleven.de>
 <20260323091725.3440ad89@phoenix.local>
 <CH2PR12MB9541F8CC6EBE612A415B8B59A448A@CH2PR12MB9541.namprd12.prod.outlook.com>
Organization: SysEleven GmbH
Content-Type: multipart/signed; micalg="pgp-sha512";
 protocol="application/pgp-signature"; boundary="=-rJcsL4IGd4byLFfQz6rR"
User-Agent: Evolution 3.44.4-0ubuntu2.1 
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


--=-rJcsL4IGd4byLFfQz6rR
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Am Dienstag, dem 24.03.2026 um 09:04 +0000 schrieb Dariusz Sosnowski:
>=20
> Adrian: Could you please elaborate what kind of issues have you faced
> with shared queue configuration?

For one, I find the documentation around shared Rx queues quite poor to
begin with. Back then, I tried to make it work on a regular ConnectX-6
NIC with multiple VFs. For lack of better understanding, I just tried
to run testpmd to check whether shared Rx queues works with this kind
of setup. Unfortunately, testpmd neither emitted a warning/error
message nor was able to set up the queues properly. Instead, everything
failed silently. It may very well have been me just using the feature
wrong, but testpmd did nothing to help me debug the issue.

Unfortunately, I am not working on this topic anymore, so I have no
recent experience with similar issues which I could provide. Also, as I
did this quite some time ago, I cannot remember all the details.

> >=20
> >=20
> Based on current implementation in ethdev and mlx5 PMD,
> assuring that share group indexes are unique is not needed.
> Share group index is not required to be globally unique since
> sharing works only within the same switch and Rx domain [1].

So if I understand this correctly, it is correct behavior for DPDK to
silently accept the same share_group and qid for ports on different
domains?

=46rom a user perspective, I see two issues here:

* The rx_domain and domain_id values are obscure magic values, whose
  meaning is neither obvious nor very well documented. Therefore, in my
  opinion, users cannot be expected to "just know" what they imply and
  and where they might be different.

  My personal assumption was that they probably differ from NIC to
  NIC or possibly from PF to PF, but from what I learned while
  experimenting with that ConnectX-6 NIC, this doesn't necessarily
  seem=C2=A0to be the case.

* Using the same share_group for two Rx queues intuitively means that
  they are shared. Since this feature is used to combine Rx paths
  across ports, I would expect that the identifiers are valid across
  ports, not switch domains or Rx domains. In my opinion, this is
  highly unintuitive from a user's perspective and I would expect DPDK=C2=
=A0
  to assume that the same share group ID actually means trying to use
  the same share group, no matter which ports are combined.

Therefore, I would prefer requiring uniqueness of share group IDs
across all ports. In any case, the shared Rx queue feature could
probably benefit from improved documentation.

Best regards
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



--=-rJcsL4IGd4byLFfQz6rR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErl0Mi1pV5uGCoyMrfIq1KN9YvTsFAmnD3WAACgkQfIq1KN9Y
vTto+w/7BE5IcqZHuz3suurN5iouQRBBO2hAvshguFh8iBfl+Qd0T8gZ1WO1qcPC
xPPBqru9UCXwJFfAjAwplxAOm4Du1+uFeANxnlGvE4QgtuG6sqqvbRgaoSSXe+uD
PRFNoyo8keNoqGlzG5bPxu2QiwpRMuwq5s5acNL5lMT7qZTZpyzsGl22g3LGPxAs
FXRhdV2RwwO8jlDfgQk5QXUIWlJ+6h/ffylNi+NJD4W8kNKO0Nrx8jVHA+CVRaJL
XpVm4WvnqC7Ys+fTuX++C4gWQFB1MJj4EeL3fa71Zo/zLuhZqm4/xKuqIFbfuNqN
orGQNEex8sZfXj5radmuZi5PR+3bsU3DrUyu3aDhBMJJV8vnt6shG2ndGRvkzuQe
gwa9kCA+JdLvKvPBAw/QHmgGILu+C1yhkTzsdEtuTqtR97cQGyaDlBcWXBQJ5Utd
Ig04VMnlzZgZKVPT5TiSYbqWAPVtI//fNP9TCHq/0cmsid0Pt/DB6Phr6PFO7Bqs
0FA8KYiniYVgaOQb+CQtcjLsQ1+9RGAudVDBqh/ICzWkJCVCXDlWGH2CBTxg2Q6a
I1CUrfPheB1vWRJmfw70CaNeto4ZIoT0Hg6I559jRATr5eE3PawxVcf4gamMuS/M
E/lPH7U3oBRS+1Yu6og+xJpeqqEBf+k43QwjVCxF8wXTESX/XWc=
=uGmT
-----END PGP SIGNATURE-----

--=-rJcsL4IGd4byLFfQz6rR--
