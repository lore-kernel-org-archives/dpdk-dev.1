Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34A5DC5B572
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Aug 2026 11:48:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2623940B9C;
	Thu, 13 Aug 2026 13:48:16 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id AAA1B4026A
 for <dev@dpdk.org>; Thu, 13 Aug 2026 13:48:14 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 6FAB6206E1;
 Thu, 13 Aug 2026 13:48:14 +0200 (CEST)
Content-class: urn:content-classes:message
Subject: RE: [PATCH] net/ice/base: allow array bounds warnings
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 13:48:12 +0200
X-MimeOLE: Produced By Microsoft Exchange V6.5
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F659DF@smartserver.smartshare.dk>
In-Reply-To: <20260813111509.1446335-1-bruce.richardson@intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] net/ice/base: allow array bounds warnings
Thread-Index: Ad0rFQq4diJAPJQKSymfLs5KrHOxyAAAq5pg
References: <98CBD80474FA8B44BF855DF32C47DC35F659AF@smartserver.smartshare.dk>
 <20260813111509.1446335-1-bruce.richardson@intel.com>
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: "Bruce Richardson" <bruce.richardson@intel.com>,
	<dev@dpdk.org>
Cc: <stephen@networkplumber.org>
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

> From: Bruce Richardson [mailto:bruce.richardson@intel.com]
> Sent: Thursday, 13 August 2026 13.15
>=20
> Since there are no zero-length arrays in the base code any more, =
remove
> the -Wno-array-bounds build flag.
>=20
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> ---
>  drivers/net/intel/ice/base/meson.build | 5 -----
>  1 file changed, 5 deletions(-)
>=20
> diff --git a/drivers/net/intel/ice/base/meson.build
> b/drivers/net/intel/ice/base/meson.build
> index fd079c41cf..da961f0752 100644
> --- a/drivers/net/intel/ice/base/meson.build
> +++ b/drivers/net/intel/ice/base/meson.build
> @@ -44,11 +44,6 @@ else
>      ]
>  endif
>=20
> -# Bugzilla ID: 678
> -if (toolchain =3D=3D 'gcc' and =
cc.version().version_compare('>=3D11.0.0'))
> -    error_cflags +=3D ['-Wno-array-bounds']
> -endif
> -

Good catch!
Consequential workarounds like this are often overlooked when the =
workaround is not necessary anymore.

Patchwork should have a "fixed/workaround" state for tracking =
workarounds, so they can be properly cleaned up like this.
The root cause has been fixed, so by removing this last detail of the =
workaround the bug is truly "fixed/resolved".

Acked-by: Morten Br=F8rup <mb@smartsharesystems.com>

