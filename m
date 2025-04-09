Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A43CC36002
	for <dpdk-dev@archiver.kernel.org>; Wed,  9 Apr 2025 05:54:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CD11D40612;
	Wed,  9 Apr 2025 07:54:21 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 7ECE9402D3
 for <dev@dpdk.org>; Wed,  9 Apr 2025 07:54:20 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 0B828207CB;
 Wed,  9 Apr 2025 07:54:20 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [PATCH] doc/linux_gsg: remove note referring to old pkg-config
X-MimeOLE: Produced By Microsoft Exchange V6.5
Date: Wed, 9 Apr 2025 07:54:18 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35E9FBA6@smartserver.smartshare.dk>
In-Reply-To: <20250408171902.2833850-1-bruce.richardson@intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] doc/linux_gsg: remove note referring to old pkg-config
Thread-Index: Aduoqlg/MK4EjlIcSTev49ArhodPIwAaXY3w
References: <20250408171902.2833850-1-bruce.richardson@intel.com>
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: "Bruce Richardson" <bruce.richardson@intel.com>,
	<dev@dpdk.org>
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
> Sent: Tuesday, 8 April 2025 19.19
>=20
> Latest DPDK releases no longer officially support RHEL 7 as a target
> platform, so remove the note about pkg-config not working on those
> systems.
>=20
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> ---
>  doc/guides/linux_gsg/sys_reqs.rst | 7 -------
>  1 file changed, 7 deletions(-)
>=20
> diff --git a/doc/guides/linux_gsg/sys_reqs.rst
> b/doc/guides/linux_gsg/sys_reqs.rst
> index 5a7d9e4a43..4c9d0c55c0 100644
> --- a/doc/guides/linux_gsg/sys_reqs.rst
> +++ b/doc/guides/linux_gsg/sys_reqs.rst
> @@ -35,13 +35,6 @@ Compilation of the DPDK
>      * For Ubuntu/Debian systems these can be installed using ``apt
> install build-essential``
>      * For Alpine Linux, ``apk add alpine-sdk bsd-compat-headers``
>=20
> -.. note::
> -
> -   pkg-config 0.27, supplied with RHEL-7,
> -   does not process the Libs.private section correctly,
> -   resulting in statically linked applications not being linked
> properly.
> -   Use an updated version of ``pkg-config`` or ``pkgconf`` instead
> when building applications
> -
>  *   Python 3.6 or later.
>=20
>  *   Meson (version 0.57+) and ninja
> --
> 2.45.2

Acked-by: Morten Br=F8rup <mb@smartsharesystems.com>

