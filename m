Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71E0ECDB46F
	for <dpdk-dev@archiver.kernel.org>; Mon, 22 Jun 2026 20:57:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 40825402D7;
	Mon, 22 Jun 2026 22:57:39 +0200 (CEST)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11021124.outbound.protection.outlook.com [52.101.52.124])
 by mails.dpdk.org (Postfix) with ESMTP id 0D6A340269
 for <dev@dpdk.org>; Mon, 22 Jun 2026 22:57:38 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A10hHJ/XJP7cmycXNUK+c/NWI8oHLhnnJ/VcaWOoS2ArYY21cmkB0ZSpCgPGZG33rCSMAA66VlkSnEDULYiGs/+aRidi9mTU7R6D4nAqy4PZw+QTWmJxx4D+5YtqSwOedVAP70xXv2aw5+3LtddQT4PZEhfSRgPAGgiQ+Bc38KN3KIRbQX7Q60lIVwwkgGKF0PmOSbU6y8p9vd0C8IZ/az1sd0kSPLYIkEoy+nLg5Kmr5WVgMhpcDkntXghmGOTdgu4p7IoPcdVd9/uG85zFcCR8JhVrllUw7NuoPkoUctw2Hf8eCBpt4oBwzraGw/kZSjSZUoLhRUGW9H+61Lpx2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bI97AHBS2zLUPbrk91tL8CwcWVwom7lPbHc1jlNj41U=;
 b=FaP3Os8UCNS/mY1PVD8Ttnsf83cR1OWVfScyllkt9kOdTwh5PlurICQw+rIBQhedn6Nni+htwYVwXed0fMKSsKl6R0QV8FiNM2ITBEIqdGpX4t6HYM/Nr+GGbt24J0Ey8gz2wPeH3g6tWEelUe74/wJzJnIOi/9xFz431ufun/D8mpcj/dp+6+EndJzoDBfhnjswuqN0SupA4fQqIoowz8HfkHaqEBhluNzxpNqEJWo+xlBl9SAHxvC2jdcz5ZxkKLllK3oZppgPpxPoCUI4NSW0nU1aYF0yfVI3NPgeJV1wS5lGeWuHk7G4CawJXSHtd3Xyvkju6A/U7005MnAYWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bI97AHBS2zLUPbrk91tL8CwcWVwom7lPbHc1jlNj41U=;
 b=apimoxlOEN0xTC7jeYQEcBSdk43o8hVmivhH+c848/p78h9sI25YR2sA9kmaBAEtODRIi1JzeBU0KHWdJFGsefGSZFehLHqj2cL2hF8QxnEJzpVIOAmr5fxFGzCE5ImVNoKXkxPNH2QnnCMbNeUKMjQIKYGb2QpphfvQO3h13gc=
Received: from SA1PR21MB6683.namprd21.prod.outlook.com (2603:10b6:806:4a4::6)
 by SA1PR21MB6897.namprd21.prod.outlook.com (2603:10b6:806:4a7::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.2; Mon, 22 Jun
 2026 20:57:34 +0000
Received: from SA1PR21MB6683.namprd21.prod.outlook.com
 ([fe80::8bad:6294:8a07:fe18]) by SA1PR21MB6683.namprd21.prod.outlook.com
 ([fe80::8bad:6294:8a07:fe18%3]) with mapi id 15.21.0159.007; Mon, 22 Jun 2026
 20:57:34 +0000
From: Long Li <longli@microsoft.com>
To: Stephen Hemminger <stephen@networkplumber.org>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: Wei Hu <weh@microsoft.com>
Subject: RE: [EXTERNAL] [PATCH v5 14/24] bus/vmbus: convert from rte_atomic to
 stdatomic
Thread-Topic: [EXTERNAL] [PATCH v5 14/24] bus/vmbus: convert from rte_atomic
 to stdatomic
Thread-Index: AQHdAFz6yyR28pcc2kCa3QxS8pbmF7ZLEq3Q
Date: Mon, 22 Jun 2026 20:57:34 +0000
Message-ID: <SA1PR21MB66835E6EA5899DD9BC052324CEEF2@SA1PR21MB6683.namprd21.prod.outlook.com>
References: <https://inbox.dpdk.org/dev/20260521042043.1590536-1-stephen@networkplumber.org>
 <20260620023134.42877-1-stephen@networkplumber.org>
 <20260620023134.42877-15-stephen@networkplumber.org>
In-Reply-To: <20260620023134.42877-15-stephen@networkplumber.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=ba7992e3-8e35-4632-a8ea-0753f065bc3a;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-06-22T20:57:13Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB6683:EE_|SA1PR21MB6897:EE_
x-ms-office365-filtering-correlation-id: 1d0b9780-5aa4-4929-b8e1-08ded0a0e297
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|56012099006|11063799006|4143699003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: Nv3MOXTO6G9jmsG7iEW8wPfx9hU7nhr+iJIqwiEOjIsDU0drVb0kOUU9D4uLtcvVhOZ6kmh1KfIjrH5WTheISasJBW22xTIyPGFKkx48cbMe/yE/BhDGfvUG97TdS6wOqP2M7dOSE0LdvTFOlhEpRMMHJ6LlQ1xyCdQsmMZg2UO138W21S1caEJ5LZMvs4pYH/igsUlAYkeevQPM53cX/EHA7blGdyClnuTA+VEQ14+ocL40Wgg7KMUSmJeqP9TAJXV10qG0JldgwABJb+rVZvNpseSWZ0LBZ8PcMUa1n6QoMJrcdPQMcugBoS1y7Tet0+EYPjsH8XIPxRdGvzKzYtbx3qmVa+HTSFU9GAwceNbltfg+FlmKHDeg5Br3O6Rr4RxxhCSEYVGyQnyhqUIhQ7LUnMOq35Na8nat8cWgKFQef2iRz9K64kxCWReNFqpEEtwDPO/UIHryjvJEa6cF0dan5gx2ppgUGguGW+GtjNNl3S9GRsW9Xp1bUpaUsz1REdXfaqNmEN72yx4SDyGdVYy0MGV9L7xdy8fqnPejmW/wWtZP/KgfdTP/GRcmZwIskTWdcuPon8/Ha5LkTSHH15w2Rb4Yk92zm5i//IStphkfgLio6KqNmcGwDKIu6+1cz4ceg1xKLMBR7j5p679UzrdH746nQj2LOo5HlHSXJekQmYH+UtCuXyjOX/jtbdIIanoS07DV4Yidf3ESfvhEMEpqS3dUshtbou4l3Kxw0Bo=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR21MB6683.namprd21.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(56012099006)(11063799006)(4143699003)(18002099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Fuglp3ZKK2XDSTr6KChR6mhhMPrR8IUBWtRCHeP7yfOvIne59Czcf9KyA3Fe?=
 =?us-ascii?Q?uqKBSjIwAdDBWjSNurBJEDGCt7SWOxyVqZ6U2VecKsCMYKt8kmcjbrGu12RH?=
 =?us-ascii?Q?tnLNN4i/OACXX+132tFoiBuKlgzANvfCfjeCDvkkRPjCFFGii55xf9xk5m2A?=
 =?us-ascii?Q?3+yy+AOnobUdPBjVYXc7RGkHIyOae3bNjxmPg2EYATXU90gDJYpDNG1UGwp9?=
 =?us-ascii?Q?fsYScH3gNSmrkN0h7FDNYS8SnFsxrmchSgDdXkAiww8BAqxwmhr5MReT2OtQ?=
 =?us-ascii?Q?VDacNtxol5/fXo+QCdOimZOrGxA42ptIvq1v/l9C8KzlGnjc0iT7lSdYzPvH?=
 =?us-ascii?Q?oIiYY/QmMQRVn18jRsKPBkzc4e/+vDBMrzVKLEZG7jvGHASM4xYclczDOM5A?=
 =?us-ascii?Q?xlMArQQO7D0fc5RO4XZB4i7AIv/z9K3D/xNlJ++ob1RuhyQgnXQxadAToLG+?=
 =?us-ascii?Q?8/S7xlhE2a3ELvMJYi3Hpgkpe5284WKTiiivfocqMKUdUkmHh4FSRX/mW3xG?=
 =?us-ascii?Q?MpV6y+03x9IEowoYYFBAYhDGzHax3jAES1TrCbZthSoh/8Gqw6SIb6R4EN3d?=
 =?us-ascii?Q?+Ali6rHva1vcjmt1uunO1UqBJoqVJG8CAiZ6lMgqyOZW813+lZvI5Y2MHyvS?=
 =?us-ascii?Q?3WQzXfVB+12F+XDVxL5uU1oL+jhlnRUkCHXEZvGDGzju05FWAw6b5IRlI1WD?=
 =?us-ascii?Q?NHVjkqi8GI3aK8gwMtB+/KA7hYXMKrr1b3ctx3x1Mp0r4rNtlIYKQKVnkAs8?=
 =?us-ascii?Q?+W3gAQiKsbmDJWXH29NU0l2VFG1kHVPb5w0ByykKJtR+QDAdmSFWDpg13j0e?=
 =?us-ascii?Q?F5OAgUllgrNg21uquEYnOtKMMqytsoWAlIZgfYvio8eD2BY/dZwtEIZbrd4X?=
 =?us-ascii?Q?shXtdW9sJZ5XWije0IfLq0GcS2fDOPZl9w1WB+sntpSqODbuBBIPA14ktjTZ?=
 =?us-ascii?Q?nIYdNV2KDSjexTn5Pomk9Uv0wqqtwTOiNeQQl1OPgpA+zC+wOo4AeURafKix?=
 =?us-ascii?Q?4wffejC967nvCtXbrfo7dQ1cZdZsf4JZvhYrEswc4nBcZu0xHj4pQCV1mMKT?=
 =?us-ascii?Q?D2JLLMcwQWv2qr2ZEhc3sarfKV6EI6joHeD+pLqBWVdUM54fegdrtzyBBwjx?=
 =?us-ascii?Q?4wk4PMeAr3ZJ3ajJ66SxwpBSDSjSqklMUVxd4MHEozVqUQ1OjAaka9Vql4d/?=
 =?us-ascii?Q?+lMEo7P1Xo9QCHgML2XSqAZDYIPv+FUZs6n5QCoxelPJKx7IBgwjqObLgcdS?=
 =?us-ascii?Q?CacdxyZReJxXVnnqRcYnHhUol6uQCtFKIPPoz4Hxaoe5U13zn3E5Ka2mZ7zC?=
 =?us-ascii?Q?8EABYiYTN/01xU8x0+DyZXejh4DYtPwwbFpqScwZxYBlu0FHRWnrb2eJ6d2C?=
 =?us-ascii?Q?4rMI3M5d7d8I3Fua6SfkmPC0Uq38JZ4LXz7XfKinfIPdnc2inwb2qcd7lCVP?=
 =?us-ascii?Q?3oU7lmTGmF31O6nZK1WFSMe/W7RkTsrApgtGBDzdDc1XBP3Kc/NLnz81Zo7T?=
 =?us-ascii?Q?bYThKfmertNtFVbfwn9ml7fjbgOWY8sPIFAWflp6BfEIhocUn4yZjiCgFcmO?=
 =?us-ascii?Q?3Xz3Pcewe5HUqdpgio2EeqyFOMGyxA/ZkNZMwVokHXKBPy//QdXwwHxdDJzj?=
 =?us-ascii?Q?umg4/NRO1rtOoECKqN7r62sHIpJ5/aLe+pkocR8d5o8Gx3axtQ5vU6VpXWgf?=
 =?us-ascii?Q?dk2Q0C8ZtlYnEv3BYOHMdbu8xVao309GdOHjiAZhSPEMsOMA?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB6683.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d0b9780-5aa4-4929-b8e1-08ded0a0e297
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2026 20:57:34.7628 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2i1FmKdzsdnLpQ+Ea2228LTsV845qcKJV+oIvGvVwMEbrg8rp/lj6eHDd34OlQEpGuYN7j+lkEkU7tYNuE4y+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR21MB6897
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

> Replace deprecated rte_atomic32 operations in the vmbus ring buffer
> producer with stdatomic equivalents, and replace the smp_wmb + CAS-spin
> publish with rte_wait_until_equal_32 + release-store.
>=20
> The two-cursor design is preserved: tbr->windex is the driver-private
> reservation cursor that lets producers reserve slots concurrently without=
 a
> lock; vbr->windex is the host-visible commit cursor, updated in reservati=
on
> order so the host never observes windex pointing past unwritten data. Thi=
s is
> the lockless analogue of the spinlock-around- single-cursor pattern used =
by
> the Linux (drivers/hv/ring_buffer.c
> hv_ringbuffer_write) and FreeBSD (sys/dev/hyperv/vmbus/vmbus_br.c
> vmbus_txbr_write) implementations of the same host contract.
>=20
> The memory ordering mirrors __rte_ring_headtail_move_head and
> __rte_ring_update_tail in lib/ring/rte_ring_c11_pvt.h: relaxed wait for t=
he
> previous producer's commit, release-store to publish. The rte_smp_wmb
> before the publish is folded into the release ordering on the store itsel=
f.
>=20
> The host-shared vbr->windex remains volatile uint32_t in the packed bufri=
ng
> struct; the atomic qualifier is added via cast at the access site. The (u=
intptr_t)
> launder on the store-side cast suppresses a spurious misaligned-atomic
> warning from the packed-struct attribute (windex is 4-byte aligned in pra=
ctice,
> at offset 0 of a page-aligned struct).
>=20
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>

Reviewed-by: Long Li <longli@microsoft.com>

> ---
>  drivers/bus/vmbus/private.h       |  2 +-
>  drivers/bus/vmbus/vmbus_bufring.c | 39 +++++++++++++++++--------------
>  2 files changed, 23 insertions(+), 18 deletions(-)
>=20
> diff --git a/drivers/bus/vmbus/private.h b/drivers/bus/vmbus/private.h in=
dex
> 6efac86b77..6b7782724f 100644
> --- a/drivers/bus/vmbus/private.h
> +++ b/drivers/bus/vmbus/private.h
> @@ -25,7 +25,7 @@ extern int vmbus_logtype_bus;  struct vmbus_br {
>  	struct vmbus_bufring *vbr;
>  	uint32_t	dsize;
> -	uint32_t	windex; /* next available location */
> +	RTE_ATOMIC(uint32_t) windex; /* next available location */
>  };
>=20
>  #define UIO_NAME_MAX 64
> diff --git a/drivers/bus/vmbus/vmbus_bufring.c
> b/drivers/bus/vmbus/vmbus_bufring.c
> index fcb97287dc..624fe8b6c5 100644
> --- a/drivers/bus/vmbus/vmbus_bufring.c
> +++ b/drivers/bus/vmbus/vmbus_bufring.c
> @@ -15,7 +15,7 @@
>  #include <rte_tailq.h>
>  #include <rte_log.h>
>  #include <rte_malloc.h>
> -#include <rte_atomic.h>
> +#include <rte_stdatomic.h>
>  #include <rte_memory.h>
>  #include <rte_pause.h>
>  #include <rte_bus_vmbus.h>
> @@ -114,6 +114,7 @@ vmbus_txbr_write(struct vmbus_br *tbr, const struct
> iovec iov[], int iovlen,
>  	uint32_t ring_size =3D tbr->dsize;
>  	uint32_t old_windex, next_windex, windex, total;
>  	uint64_t save_windex;
> +	bool success;
>  	int i;
>=20
>  	total =3D 0;
> @@ -121,17 +122,13 @@ vmbus_txbr_write(struct vmbus_br *tbr, const
> struct iovec iov[], int iovlen,
>  		total +=3D iov[i].iov_len;
>  	total +=3D sizeof(save_windex);
>=20
> +	/* Get current free location */
> +	old_windex =3D rte_atomic_load_explicit(&tbr->windex,
> +					      rte_memory_order_relaxed);
> +
>  	/* Reserve space in ring */
>  	do {
> -		uint32_t avail;
> -
> -		/* Get current free location */
> -		old_windex =3D tbr->windex;
> -
> -		/* Prevent compiler reordering this with calculation */
> -		rte_compiler_barrier();
> -
> -		avail =3D vmbus_br_availwrite(tbr, old_windex);
> +		uint32_t avail =3D vmbus_br_availwrite(tbr, old_windex);
>=20
>  		/* If not enough space in ring, then tell caller. */
>  		if (avail <=3D total)
> @@ -139,8 +136,13 @@ vmbus_txbr_write(struct vmbus_br *tbr, const
> struct iovec iov[], int iovlen,
>=20
>  		next_windex =3D vmbus_br_idxinc(old_windex, total, ring_size);
>=20
> -		/* Atomic update of next write_index for other threads */
> -	} while (!rte_atomic32_cmpset(&tbr->windex, old_windex,
> next_windex));
> +		/* Atomic update of next write_index for other threads
> +		 * Can use weak since easy to recompute and retry.
> +		 */
> +		success =3D rte_atomic_compare_exchange_weak_explicit(
> +				&tbr->windex, &old_windex, next_windex,
> +				rte_memory_order_acquire,
> rte_memory_order_relaxed);
> +	} while (unlikely(!success));
>=20
>  	/* Space from old..new is now reserved */
>  	windex =3D old_windex;
> @@ -157,12 +159,15 @@ vmbus_txbr_write(struct vmbus_br *tbr, const
> struct iovec iov[], int iovlen,
>  	/* The region reserved should match region used */
>  	RTE_ASSERT(windex =3D=3D next_windex);
>=20
> -	/* Ensure that data is available before updating host index */
> -	rte_smp_wmb();
> +	/* Wait for previous producer to publish their windex update */
> +	rte_wait_until_equal_32(&vbr->windex, old_windex,
> +rte_memory_order_relaxed);
>=20
> -	/* Checkin for our reservation. wait for our turn to update host */
> -	while (!rte_atomic32_cmpset(&vbr->windex, old_windex,
> next_windex))
> -		rte_pause();
> +	/* Publish our windex update; prior data writes ordered via release.
> +	 * windex is 4-byte aligned in practice (struct is page-aligned, windex
> +	 * at offset 0); cast launders the packed-struct alignment-1 attribute.
> +	 */
> +	rte_atomic_store_explicit((volatile __rte_atomic uint32_t
> *)(uintptr_t)&vbr->windex,
> +				  next_windex, rte_memory_order_release);
>=20
>  	/* If host had read all data before this, then need to signal */
>  	*need_sig |=3D vmbus_txbr_need_signal(vbr, old_windex);
> --
> 2.53.0

