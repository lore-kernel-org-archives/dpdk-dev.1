Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8003D606A320
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 Oct 2026 15:33:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C8B7840283;
	Tue, 20 Oct 2026 17:33:36 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 8E8654025A
 for <dev@dpdk.org>; Tue, 20 Oct 2026 17:33:35 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 63EAA2033E;
 Tue, 20 Oct 2026 17:33:35 +0200 (CEST)
Content-class: urn:content-classes:message
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [PATCH 1/2] build: disable GCC string op warnings when unoptimized
X-MimeOLE: Produced By Microsoft Exchange V6.5
Date: Tue, 20 Oct 2026 17:33:32 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F65ACF@smartserver.smartshare.dk>
In-Reply-To: <20261020145541.388371-1-stephen@networkplumber.org>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 1/2] build: disable GCC string op warnings when
 unoptimized
Thread-Index: Ad1goxx9mXv8OJYFSxCn+O7yY4l9fAABRZdw
References: <20261020145541.388371-1-stephen@networkplumber.org>
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: "Stephen Hemminger" <stephen@networkplumber.org>,
	<dev@dpdk.org>
Cc: "Ali Alnubani" <alialnu@nvidia.com>,
 "Bruce Richardson" <bruce.richardson@intel.com>
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> From: Stephen Hemminger [mailto:stephen@networkplumber.org]
> Sent: Tuesday, 20 October 2026 16.56
>=20
> Without optimization GCC produces warnings for unreachable code paths.
> They check memcpy() against the object size even on paths that are =
dead
> for the inlined arguments. This breaks debug builds of app/test
> with -Werror on lib/stack/rte_stack_pile.h,
> and has required local pragma workarounds elsewhere.
>=20
> Disable both warnings when optimization is 0. They stay enabled for
> optimized builds, where the analysis is flow-sensitive.
>=20
> Bugzilla ID: 2061
>=20
> Reported-by: Ali Alnubani <alialnu@nvidia.com>
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  config/meson.build | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/config/meson.build b/config/meson.build
> index 745097e8aa..bfac1cd93d 100644
> --- a/config/meson.build
> +++ b/config/meson.build
> @@ -378,6 +378,12 @@ if cc.has_argument('-Wno-comma')
>      no_comma_cflag =3D '-Wno-comma'
>  endif
>=20
> +# GCC's string/memory access warnings are flow-insensitive without
> +# optimization and produce false positives on dead paths of inlined
> code.
> +if get_option('optimization') =3D=3D '0' and cc.get_id() =3D=3D 'gcc'
> +    global_cflags +=3D ['-Wno-stringop-overflow', '-Wno-stringop-
> overread']
> +endif
> +
>  foreach arg: global_cflags
>      if cc.has_argument(arg)
>          add_project_arguments(arg, language: 'c')
> --
> 2.53.0

I replied in the wrong thread, here it comes again:

Also '-Warray-bounds'?

Consider making it a series, and also remove existing overflow/overread =
pragmas in the code (if viable):
lib/ring/rte_ring_elem_pvt.h - You did this already!
lib/eal/ppc/include/rte_memcpy.h

With or without suggested changes,
Acked-by: Morten Br=F8rup <mb@smartsharesystems.com>

