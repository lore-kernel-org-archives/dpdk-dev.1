Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17572CA5FCE
	for <dpdk-dev@archiver.kernel.org>; Mon,  5 Oct 2026 13:14:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 429BD4028D;
	Mon,  5 Oct 2026 15:14:23 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id BCB604028C
 for <dev@dpdk.org>; Mon,  5 Oct 2026 15:14:21 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 84D17201E4;
 Mon,  5 Oct 2026 15:14:21 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [PATCH] build: fix cross compilation to x86_64
X-MimeOLE: Produced By Microsoft Exchange V6.5
Date: Mon, 5 Oct 2026 15:14:17 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F65A97@smartserver.smartshare.dk>
In-Reply-To: <20261005125943.678879-1-a.schollmeyer@syseleven.de>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] build: fix cross compilation to x86_64
Thread-Index: Ad1UyX6C13XCBjLBS3uQKSd19y5aNwAAYp9g
References: <20261005125943.678879-1-a.schollmeyer@syseleven.de>
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: "Adrian Schollmeyer" <a.schollmeyer@syseleven.de>,
 "Bruce Richardson" <bruce.richardson@intel.com>
Cc: <dev@dpdk.org>
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

> If x86_64 is specified as target CPU instruction set (e.g. when
> cross-compiling *to* x86_64), the cpu_instruction_set may be set to
> x86_64, e.g. if it is derived from a Meson crossfile. However, while
> Meson uses "x86_64" as name for the x86_64 architecture, compiler
> options accept only "x86-64".
>=20
> Introduce a conditional for handling this special case by changing
> cpu_instruction_set to the march-compatible value.
>=20
> Signed-off-by: Adrian Schollmeyer <a.schollmeyer@syseleven.de>
> ---
>  config/meson.build | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/config/meson.build b/config/meson.build
> index dcb84ebd13..238d6cae0c 100644
> --- a/config/meson.build
> +++ b/config/meson.build
> @@ -177,6 +177,11 @@ if not is_ms_compiler
>          machine_args +=3D '-mtune=3D' + cpu_instruction_set
>          compiler_arch_support =3D cc.has_argument('-mcpu=3D' +
> cpu_instruction_set)
>      else
> +        # Meson uses x86_64, but compilers expect x86-64.
> +        # See https://mesonbuild.com/Reference-tables.html#cpu-
> families
> +        if cpu_instruction_set =3D=3D 'x86_64'
> +            cpu_instruction_set =3D 'x86-64'

Not sure, but maybe: 'x86-64-v2'?

Ref:
https://www.phoronix.com/news/GCC-11-x86-64-Feature-Levels

> +        endif
>          machine_args +=3D '-march=3D' + cpu_instruction_set
>          # arm manages generic/auto config in config/arm/meson.build
>          if cpu_instruction_set !=3D 'generic' and cpu_instruction_set =
!=3D
> 'auto'
> --
> 2.43.0

