Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BC4EC55184
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Aug 2026 15:53:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C74FC406BB;
	Tue,  4 Aug 2026 17:53:02 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id 5D7704068A
 for <dev@dpdk.org>; Tue,  4 Aug 2026 17:53:01 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=9XumaCsP0fZKqmTJpmwgb+/hShdPAS1fXA34B1sT2Vw=;
 b=nI+bnSSBGOcgRw/6TdHa5h5jKrCfgxH5Z3WuNj78XCfDlcaa18HffawNrGak1eG4t/OVlC2az
 4G1PVELo/FSMpaS3reciL0dYvsFXaXPSK9YOnKCHmaa8mTk9sSwPZgjsqbvxFsCiBKY1bDXiwnn
 neBgVGdSjBaIDolcDzYCbQc=
Received: from mail.maildlp.com (unknown [172.18.224.107])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4hDyjF3jWnzJ46ZD;
 Tue,  4 Aug 2026 23:52:17 +0800 (CST)
Received: from frapema100001.china.huawei.com (unknown [7.182.19.23])
 by mail.maildlp.com (Postfix) with ESMTPS id 1B2934058B;
 Tue,  4 Aug 2026 23:53:01 +0800 (CST)
Received: from frapema500003.china.huawei.com (7.182.19.114) by
 frapema100001.china.huawei.com (7.182.19.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Tue, 4 Aug 2026 17:53:00 +0200
Received: from frapema500003.china.huawei.com ([7.182.19.114]) by
 frapema500003.china.huawei.com ([7.182.19.114]) with mapi id 15.02.1544.011;
 Tue, 4 Aug 2026 17:53:00 +0200
From: Marat Khalili <marat.khalili@huawei.com>
To: Stephen Hemminger <stephen@networkplumber.org>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: Jerin Jacob <jerinj@marvell.com>, Konstantin Ananyev
 <konstantin.ananyev@huawei.com>, Akhil Goyal <gakhil@marvell.com>, "Anoob
 Joseph" <anoobj@marvell.com>
Subject: RE: [PATCH v3 07/23] app/test: include headers directly
Thread-Topic: [PATCH v3 07/23] app/test: include headers directly
Thread-Index: AQHdJChgFVKwz1XWc0Sq6L5N5IW2SbaOCdYg
Date: Tue, 4 Aug 2026 15:53:00 +0000
Message-ID: <5ae64cb06ec84589a713b563a719ad4e@huawei.com>
References: <20260803165304.289869-1-stephen@networkplumber.org>
 <20260804154549.148691-1-stephen@networkplumber.org>
 <20260804154549.148691-8-stephen@networkplumber.org>
In-Reply-To: <20260804154549.148691-8-stephen@networkplumber.org>
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

For the `test_bpf.c` part:

Acked-by: Marat Khalili <marat.khalili@huawei.com>
