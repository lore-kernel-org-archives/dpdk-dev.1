Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 390B8C54E65
	for <dpdk-dev@archiver.kernel.org>; Wed, 21 May 2025 19:47:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2AEB642E15;
	Wed, 21 May 2025 21:47:37 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id B34E4402CD
 for <dev@dpdk.org>; Wed, 21 May 2025 21:47:35 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 8034B206C2;
 Wed, 21 May 2025 21:47:34 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [PATCH v1 4/4] config/x86: enable RTE_USE_C11_MEM_MODEL by default
X-MimeOLE: Produced By Microsoft Exchange V6.5
Date: Wed, 21 May 2025 21:47:30 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35E9FC81@smartserver.smartshare.dk>
In-Reply-To: <20250521111432.207936-5-konstantin.ananyev@huawei.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH v1 4/4] config/x86: enable RTE_USE_C11_MEM_MODEL by
 default
Thread-Index: AdvKQanUScl1LzLPQFury3pqlIHnvAARI72w
References: <20250521111432.207936-1-konstantin.ananyev@huawei.com>
 <20250521111432.207936-5-konstantin.ananyev@huawei.com>
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: "Konstantin Ananyev" <konstantin.ananyev@huawei.com>,
	<dev@dpdk.org>
Cc: <honnappa.nagarahalli@arm.com>, <jerinj@marvell.com>,
 <hemant.agrawal@nxp.com>, <drc@linux.ibm.com>
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

> From: Konstantin Ananyev [mailto:konstantin.ananyev@huawei.com]
> Sent: Wednesday, 21 May 2025 13.15
>=20
> As an attempt to reduce legacy code usage within rte_ring -
> enable RTE_USE_C11_MEM_MODEL by default on all x86 platforms.

I theory, after requiring C11, RTE_USE_C11_MEM_MODEL should be the =
default on all platforms, and the legacy memory model should be optional =
for performance.

But IIRC, significant performance differences made the legacy memory =
model better for some platforms, so keeping legacy the default for those =
platforms makes sense.

If this patch series solved the C11 performance issues on those other =
platforms, we can get rid of the ring operations using the legacy memory =
model. Such a change would be suitable for an LTS release.

That said, we could postpone this patch 4 to the 25.11 release.
In theory, patch 3 replaced a rte_atomic_thread_fence() - affecting all =
memory operations - with some atomic functions affecting only the ring =
head/tail memory operations.
However, if that theoretical change is 100 % irrelevant on any x86 CPU =
in reality, then it's acceptable to not wait for 25.11.

>=20
> Signed-off-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>
> ---
>  config/x86/meson.build | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/config/x86/meson.build b/config/x86/meson.build
> index c3564b0011..5528eb4960 100644
> --- a/config/x86/meson.build
> +++ b/config/x86/meson.build
> @@ -21,6 +21,7 @@ endif
>=20
>  dpdk_conf.set('RTE_CACHE_LINE_SIZE', 64)
>  dpdk_conf.set('RTE_MAX_LCORE', 128)
> +dpdk_conf.set('RTE_USE_C11_MEM_MODEL', true)
>=20
>  epyc_zen_cores =3D {
>      '__znver5__':768,
> --
> 2.43.0

