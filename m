Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DD1EC5DF94
	for <dpdk-dev@archiver.kernel.org>; Mon, 24 Aug 2026 15:21:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E4D3C40270;
	Mon, 24 Aug 2026 17:21:50 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id 41BDE400D6
 for <dev@dpdk.org>; Mon, 24 Aug 2026 17:21:49 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=a0kXG39IhVm7fd8AiNslUQrFg/ZeWH+lJBt/MvYvOQI=;
 b=tW7HXJnEtBKGRFM9o6elyergAZLd3KLXR7Vh6S5aR86O2MngWlJMvf8g9XaKk3f8wsHOLSo/I
 VGfQfx6EJzh4a1cmb1mcJm1Se8WVefwmEJ9vRZ78b/XeGgkrwfEJYL8RJJBd0fDb5Q+fyNdulrK
 rE4SWpWr/QXTqGYIzccsiuE=
Received: from mail.maildlp.com (unknown [172.18.224.150])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4hTF4B25v0zHnH42;
 Mon, 24 Aug 2026 23:21:14 +0800 (CST)
Received: from frapema500001.china.huawei.com (unknown [7.182.19.243])
 by mail.maildlp.com (Postfix) with ESMTPS id 44B0840571;
 Mon, 24 Aug 2026 23:21:44 +0800 (CST)
Received: from frapema500003.china.huawei.com (7.182.19.114) by
 frapema500001.china.huawei.com (7.182.19.243) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 24 Aug 2026 17:21:44 +0200
Received: from frapema500003.china.huawei.com ([7.182.19.114]) by
 frapema500003.china.huawei.com ([7.182.19.114]) with mapi id 15.02.2562.045;
 Mon, 24 Aug 2026 17:21:44 +0200
From: Marat Khalili <marat.khalili@huawei.com>
To: Stephen Hemminger <stephen@networkplumber.org>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: Jerin Jacob <jerinj@marvell.com>, Konstantin Ananyev
 <konstantin.ananyev@huawei.com>, Akhil Goyal <gakhil@marvell.com>, "Anoob
 Joseph" <anoobj@marvell.com>
Subject: RE: [PATCH v4 07/23] app/test: include headers directly
Thread-Topic: [PATCH v4 07/23] app/test: include headers directly
Thread-Index: AQHdJWHmXYDGtX+eZU64ejD8r1eoF7ata2Iw
Date: Mon, 24 Aug 2026 15:21:43 +0000
Message-ID: <069d44fabd2143148fc49bbdccb97c65@huawei.com>
References: <20260803165304.289869-1-stephen@networkplumber.org>
 <20260806051004.166778-1-stephen@networkplumber.org>
 <20260806051004.166778-8-stephen@networkplumber.org>
In-Reply-To: <20260806051004.166778-8-stephen@networkplumber.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.206.137.78]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
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

> -----Original Message-----
> From: Stephen Hemminger <stephen@networkplumber.org>
> Sent: Thursday 6 August 2026 06:09
> To: dev@dpdk.org
> Cc: Stephen Hemminger <stephen@networkplumber.org>; Jerin Jacob <jerinj@m=
arvell.com>; Konstantin
> Ananyev <konstantin.ananyev@huawei.com>; Marat Khalili <marat.khalili@hua=
wei.com>; Akhil Goyal
> <gakhil@marvell.com>; Anoob Joseph <anoobj@marvell.com>
> Subject: [PATCH v4 07/23] app/test: include headers directly
>=20
> The test code was getting network headers indirectly via inclusion
> of rte_ethdev.h. This will change in the future, instead get the
> headers directly.
>=20
> For BPF test, use the tool "iwyu" to get more complete set of headers.
> Replace use of htons() with equivalent DPDK byteorder macro.
>=20
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  app/test-eventdev/test_pipeline_common.h |  1 +
>  app/test/test_bpf.c                      | 20 +++++++++++++++-----
>  app/test/test_security_inline_macsec.c   |  2 ++
>  app/test/test_security_inline_proto.c    |  1 +
>  4 files changed, 19 insertions(+), 5 deletions(-)

Acked-by: Marat Khalili <marat.khalili@huawei.com>

All of the new headers seem to be defined by always-enabled libraries,
something worth mentioning in the future.

>=20
> diff --git a/app/test-eventdev/test_pipeline_common.h b/app/test-eventdev=
/test_pipeline_common.h
> index 61370fb799..e9f20e7f62 100644
> --- a/app/test-eventdev/test_pipeline_common.h
> +++ b/app/test-eventdev/test_pipeline_common.h
> @@ -12,6 +12,7 @@
>  #include <rte_cycles.h>
>  #include <rte_ethdev.h>
>  #include <rte_ether.h>
> +#include <rte_ip.h>
>  #include <rte_event_eth_rx_adapter.h>
>  #include <rte_event_eth_tx_adapter.h>
>  #include <rte_eventdev.h>
> diff --git a/app/test/test_bpf.c b/app/test/test_bpf.c
> index 3205afaa63..5b71f94a71 100644
> --- a/app/test/test_bpf.c
> +++ b/app/test/test_bpf.c
> @@ -5,16 +5,28 @@
>  #include <stdio.h>
>  #include <string.h>
>  #include <stdint.h>
> +#include <stdlib.h>
> +#include <stdbool.h>
> +#include <stddef.h>
> +#include <stdalign.h>
>  #include <inttypes.h>
> +#include <errno.h>
> +#include <limits.h>
>  #include <unistd.h>
>=20
> -#include <rte_memory.h>
> +#include <rte_bitops.h>
>  #include <rte_debug.h>
>  #include <rte_hexdump.h>
>  #include <rte_malloc.h>
> +#include <rte_memcpy.h>
> +#include <rte_mbuf.h>
>  #include <rte_random.h>
>  #include <rte_byteorder.h>
>  #include <rte_errno.h>
> +#include <rte_ether.h>
> +#include <rte_ip.h>
> +#include <rte_udp.h>
> +#include <rte_tcp.h>
>=20
>  #include "test.h"
>=20
> @@ -30,8 +42,6 @@ test_bpf(void)
>  #else
>=20
>  #include <rte_bpf.h>
> -#include <rte_ether.h>
> -#include <rte_ip.h>
>=20
>=20
>  /* Tests of most simple BPF programs (no instructions, one instruction e=
tc.) */
> @@ -1331,7 +1341,7 @@ test_jump2_check(uint64_t rc, const void *arg)
>  	uint16_t eth_type;
>  	uint64_t v =3D -1;
>=20
> -	if (eth_hdr->ether_type =3D=3D htons(0x8100)) {
> +	if (eth_hdr->ether_type =3D=3D rte_cpu_to_be_16(0x8100)) {
>  		const struct rte_vlan_hdr *vlan_hdr =3D
>  			(const void *)(eth_hdr + 1);
>  		eth_type =3D vlan_hdr->eth_proto;
> @@ -1341,7 +1351,7 @@ test_jump2_check(uint64_t rc, const void *arg)
>  		next =3D eth_hdr + 1;
>  	}
>=20
> -	if (eth_type =3D=3D htons(0x0800)) {
> +	if (eth_type =3D=3D rte_cpu_to_be_16(0x0800)) {
>  		ipv4_hdr =3D next;
>  		if ((ipv4_hdr->dst_addr & rte_cpu_to_be_32(TEST_NETMASK)) =3D=3D
>  		    rte_cpu_to_be_32(TEST_SUBNET)) {
> diff --git a/app/test/test_security_inline_macsec.c b/app/test/test_secur=
ity_inline_macsec.c
> index a929ff5326..43672ef237 100644
> --- a/app/test/test_security_inline_macsec.c
> +++ b/app/test/test_security_inline_macsec.c
> @@ -8,6 +8,8 @@
>  #include <rte_ethdev.h>
>  #include <rte_malloc.h>
>  #include <rte_security.h>
> +#include <rte_flow.h>
> +#include <rte_macsec.h>
>=20
>  #include "test.h"
>  #include "test_security_inline_macsec_vectors.h"
> diff --git a/app/test/test_security_inline_proto.c b/app/test/test_securi=
ty_inline_proto.c
> index 0b1f7fbbab..99111e5432 100644
> --- a/app/test/test_security_inline_proto.c
> +++ b/app/test/test_security_inline_proto.c
> @@ -7,6 +7,7 @@
>  #include <inttypes.h>
>=20
>  #include <rte_ethdev.h>
> +#include <rte_flow.h>
>  #include <rte_malloc.h>
>  #include <rte_security.h>
>=20
> --
> 2.53.0

