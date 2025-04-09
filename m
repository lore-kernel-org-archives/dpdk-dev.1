Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82188C36002
	for <dpdk-dev@archiver.kernel.org>; Wed,  9 Apr 2025 05:50:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 43EAB402D7;
	Wed,  9 Apr 2025 07:50:34 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 94294402D3
 for <dev@dpdk.org>; Wed,  9 Apr 2025 07:50:33 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 34756207CB;
 Wed,  9 Apr 2025 07:50:33 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [PATCH] doc/linux_gsg: update recommended compiler versions
X-MimeOLE: Produced By Microsoft Exchange V6.5
Date: Wed, 9 Apr 2025 07:50:30 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35E9FBA5@smartserver.smartshare.dk>
In-Reply-To: <20250408171835.2833766-1-bruce.richardson@intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] doc/linux_gsg: update recommended compiler versions
Thread-Index: Aduoqkia3f1MZKeIS1GbE1jJ/Mg5YQAaPezQ
References: <20250408171835.2833766-1-bruce.richardson@intel.com>
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
> Rather than specifying a minimum compiler version, update the docs to
> recommend a particular compiler version. In other words, earlier
> versions may work, but are not officially supported, or may give
> reduced
> functionality.
>=20
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> ---
>  doc/guides/linux_gsg/sys_reqs.rst | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/doc/guides/linux_gsg/sys_reqs.rst
> b/doc/guides/linux_gsg/sys_reqs.rst
> index 4c9d0c55c0..0acd26f260 100644
> --- a/doc/guides/linux_gsg/sys_reqs.rst
> +++ b/doc/guides/linux_gsg/sys_reqs.rst
> @@ -28,7 +28,8 @@ Compilation of the DPDK
>      For details on Linux distributions and the versions tested, =
please
> consult the DPDK Release Notes.
>=20
>  *   General development tools including a C compiler supporting the
> C11 standard,
> -    including standard atomics, for example: GCC (version 5.0+) or
> Clang (version 3.6+),
> +    including standard atomics, for example:
> +    GCC (version 8.0+ recommended) or Clang (version 7+ recommended),
>      and ``pkg-config`` or ``pkgconf`` to be used when building end-
> user binaries against DPDK.
>=20
>      * For RHEL/Fedora systems these can be installed using ``dnf
> groupinstall "Development Tools"``
> --
> 2.45.2

Acked-by: Morten Br=F8rup <mb@smartsharesystems.com>

