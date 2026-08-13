Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CEF9C5B572
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Aug 2026 23:03:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 284954028D;
	Fri, 14 Aug 2026 01:02:59 +0200 (CEST)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11023099.outbound.protection.outlook.com
 [40.93.196.99]) by mails.dpdk.org (Postfix) with ESMTP id DB83D4013F
 for <dev@dpdk.org>; Fri, 14 Aug 2026 01:02:57 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aVi9vKQxiNzl+LLiNYZgKtobFlzNz7ZBnx/RBWWPVei15NrM3wvSwurAvQjYeZf6huKa+Qnd0p1HJcNnhdQUHuNOPZePwLvK3q6S97F2vYsii8FVdBZM9824OdfMnsWK5C5WEGID/Xgixh72w7NGsxLRG2H2FN/pDfDNC8kKx0nTAOqr1swsvZ53Xso7BZXZM8yzMMeBmG+/TuYNLLprQD6nDGJ/Tvrcg0KTN8Y3Tr1WnrqjQkPY6zCSEonN+8ABiyum4Ha6WRQLOCXaFWlJmYc1HJFH68irtq1e3WpD33j5CaYUgSxdCkkRC+OKiLs38KKkjmtWK90bn903myvaeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TbBq1PKcN2CE4hssYagx0o6I/TZ85+DhU6LnrQUhB+k=;
 b=Xj77ZiJ1OmnREM0S38cMCB42Cqcry5V1DJT2TPhXWdYjEIGZt03mObHk/ItniHQWiXoDJq90TYsQpi3grFs+75miVkE58q05NuN98Il99kmhIuFr9zRc5HOpoEqkFlZY0vAjnPBHoHhM6ysWws5ntlkNOh9bXeknLJqmpumHzQlDj8IpmcyWU67pUIBM353MdgGOZMIqDh9h7j9y7NQ4m+FY7/9sTTiGwVIIF5rh8A8iJmSj4DPyZQQ+D1aZ2Qp1B47Hm7GRC9NU6O0KTRsibdlrtxTtnuo5iBkoACGT7HnU4PoLfkJXeBu1fDhanFILOzFHJ72qNphOczVdciWDCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TbBq1PKcN2CE4hssYagx0o6I/TZ85+DhU6LnrQUhB+k=;
 b=d0syI5SHHvh+ysPxS5KqwAXHf3OAxdaEuo/POY4dVbntSyw/bXP4dyAJTELqlNgMRPdLHQGoK2N8cJ+SzwtS/531gRaUGXa5d/UKx514aoMqLz+JBG31h+ylvnMgNtNqu90K0x3qtB2JT+OyYfMIA5CAOEMvcyGFeir20y/hjAE=
Received: from SA1PR21MB6683.namprd21.prod.outlook.com (2603:10b6:806:4a4::6)
 by SA1PR21MB6443.namprd21.prod.outlook.com (2603:10b6:806:4a9::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.9; Thu, 13 Aug
 2026 23:02:54 +0000
Received: from SA1PR21MB6683.namprd21.prod.outlook.com
 ([fe80::8bad:6294:8a07:fe18]) by SA1PR21MB6683.namprd21.prod.outlook.com
 ([fe80::8bad:6294:8a07:fe18%6]) with mapi id 15.21.0315.008; Thu, 13 Aug 2026
 23:02:54 +0000
From: Long Li <longli@microsoft.com>
To: Stephen Hemminger <stephen@networkplumber.org>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: Wei Hu <weh@microsoft.com>
Subject: RE: [EXTERNAL] [PATCH v7 14/24] bus/vmbus: convert from rte_atomic to
 stdatomic
Thread-Topic: [EXTERNAL] [PATCH v7 14/24] bus/vmbus: convert from rte_atomic
 to stdatomic
Thread-Index: AQHdJVNScxEUNUMsPEWBOoBUcEPWWracpF5Q
Date: Thu, 13 Aug 2026 23:02:54 +0000
Message-ID: <SA1PR21MB66834B4897A857A22CD5C4CACEDB2@SA1PR21MB6683.namprd21.prod.outlook.com>
References: <20260521042043.1590536-1-stephen@networkplumber.org>
 <20260806032544.21337-1-stephen@networkplumber.org>
 <20260806032544.21337-15-stephen@networkplumber.org>
In-Reply-To: <20260806032544.21337-15-stephen@networkplumber.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=73c3df55-df03-45c9-9505-ee926ebc416f;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-08-13T23:00:18Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB6683:EE_|SA1PR21MB6443:EE_
x-ms-office365-filtering-correlation-id: 4021b091-a509-4944-6f3c-08def98f0243
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|4143699003|22082099003|56012099006|11063799006|7146999003|10067099003|18002099003|38070700021;
x-microsoft-antispam-message-info: w7ax5fs6LPjMK2EOOvKejLiOHfE67HRshCAlIR0TH9u5xSD3VGuNtE4A39KMc7R2jFPVEf9ZbIYOr0IV2zfmsO0wPkVpuTQTu7eXeRz1/FtIHE05SxG5UUwZKqZnNUjRFXDxXEAvEvI9Dkbgf8rmmnGaCONrH918X9PR401DhhOAeyD+zqTSJO17RYh2MNWrYyd2cwN3BonipbBCSWu2Pm93z5Lggf8G/3kmRiJUsdpavSDdramrNvY6T+fWTen87gau0fEdixYHz3JX1pCYaFuEPjTfaN1+QAEB0n2NtVKg5tEp2NcMf/SwGBClKoMOG77fQS+YFg5ijT2AKb4zZjaBjcYW1/xfRoDT6fFUrpp9ffpqz5ptVo1KlgKWPj29EN0eI96eOgGSFo2/gVPATnaQfs0wqwE2gvGvXpcRguI3bMlD3mBaJ2waFJd+7GSIbh8FGNgGHLw7yYSec22sJTK7eUHbVm1mho0v27h7euCH5PeFBguS8ClvQHlOMSrR2mXxxKcvYjA1GGzL1IxcBqXuL7Pc0miis1c70Y6w9ienOk1N1IrcEXM4Fk4UZFxR04OZnIimF7rdV+buF1GjJUJDzObAhJ0IZ9dM2ifgQJzh6jlHbDLknqLNxfV9dstmzbiNDrNegZbLh4XYPwLqo8an7r6a5qfg+gI4bI6TO9Eg7r2sVu5JLtbd80fNhHxYMyEqO59LOEXW9jiyUvuJh0jOrGKRyljK67y1H4vihc4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR21MB6683.namprd21.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(4143699003)(22082099003)(56012099006)(11063799006)(7146999003)(10067099003)(18002099003)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Ia/lu2KtsCGRAX5Tnr9q/lkXLP7en21eL6mPlVIrWNmkfJbjrTjHFeDpL93e?=
 =?us-ascii?Q?hpQdYUK2cXVNmpnrgSQw3yXvc3yC8TbZZQbzSXxpSjrt7VmsGWAFvMwXy1XA?=
 =?us-ascii?Q?1UHvYlLAxiEev91K0vUzNXSKWafLW4nOZ7aERQCUICQhl02vFxvwNuRCpLXi?=
 =?us-ascii?Q?PHzXAmgcs6p5k/TQf0xOQ66Ab1zQL15e6YjgqflEPDoCQwO2o4X5Va06R6iW?=
 =?us-ascii?Q?b29/PmqwUADfaj+ku1eNz1YHuyKLQSuXHaRiJZ4JFGqdx2tbfnP7K6ULSwFq?=
 =?us-ascii?Q?IX9Z3qjIJP9kYRQi7YvCxW+gT5tcQ4p73YFEL7dzi9yS/nu10tcHSA74oAsb?=
 =?us-ascii?Q?sv8yDUgq+rI+HBdS2fkzyOhcE+8fojuESSUsy255s8+qpLsqa3PB15jyPjcW?=
 =?us-ascii?Q?otdTSmg/rbBN/W4VaOaliu3e3t6sZSF0P8TqzmyN09omTaudaVNOfAm/zDEK?=
 =?us-ascii?Q?d7dnqPPei3Y1/ibWk64LFzyGISDAdM744WkZ7pySwLQ+nPFAJptjcN0Arm6u?=
 =?us-ascii?Q?a4Gr/Ne2Bp7ku75pppacpyiDw/2WIqs6LEdDAmCVC68V6iFPG3gCxjvaCOSD?=
 =?us-ascii?Q?D337tP+2u333Zw/q9daKuaSb1WX9RGZvsBqsbqLovlDkkCpPGZLZzU+PZCBk?=
 =?us-ascii?Q?Wwc07l3nqJ9oSkkxLoHcuTi55pIshEEiItfXZGui7KfM3yulvuPWvm/4mUuR?=
 =?us-ascii?Q?n7gryOpnf4ZNagGw9I6pVNtwLpPBASeqwCrjWLOHoy3SqRPqK0UKb8AUV38M?=
 =?us-ascii?Q?VxI+sipsMDjQ3s0/dQr9+MMYQCtqryxKwJr8k/JMf7ETw6FTGSHei/K6mYEe?=
 =?us-ascii?Q?MD7G4mkeXcniUbkE/MmvlSA1izxaVO+ioLDAbsv2AqA44aIc2dpqNrb8f8Ng?=
 =?us-ascii?Q?d2/uCYJoimxnx2LOjZDOMY+94f3nhMZDJfU2NPm1u8zn4QCHKoTpGzuD/Lw2?=
 =?us-ascii?Q?idayZdebh9KQovo41ddRrtdPHziJTl5wByvZOeyLZEuZ9t801Bwn28W2lYE7?=
 =?us-ascii?Q?CRWCpxC0gqFIZgpMdKsW+TNss7xxo4JkHe8kUTtc/YHvpd9yQZyzNOM87kMP?=
 =?us-ascii?Q?o0my37niQzID6eMXfPTdzdaK8jUFQ9ErxG4WfDM1jIdUfFHWK6pRZBWoTUkS?=
 =?us-ascii?Q?BoSz+zkYNUA7cr1PbL463MXHwfM6Ql7G/zJ7xt1kRfc04oUFKtEr+gjr3w9o?=
 =?us-ascii?Q?on4No6Vguuw4aErWIOGwsNji+3EGCe/Oy1aiJn4DV899YN2xOetgrIsUuEB3?=
 =?us-ascii?Q?5GVIEwLxatANKhVZLok7rfJq5NS+QOlCweb8YWWKXC7pehX13ke6LxTOztbB?=
 =?us-ascii?Q?TlCw7NthxDriWYZF7Dqo0hOtYXcf4hSOc/nwDp0Fy20FYVkpR5LpuPoLDkwm?=
 =?us-ascii?Q?W8Pv25EsNsQOK4i4c/zx6kd6mxjKJCIdxg4PzUzAOxOoB9/+XDZZA/G0zEPe?=
 =?us-ascii?Q?L8we7Dec/wjFDr2sgzt0tx1CqFjX0C8/hKhHJLj/yftcbNlfaqiYw/9tFQOV?=
 =?us-ascii?Q?mb3GoxxSuCUXjvL7GQ6c6/qfIdgaVGGUUN4RTRLcn0xFHcVgnuqDhq4pXF3e?=
 =?us-ascii?Q?mRIUUfXkiqSfnZ8AgxUMHnsslAuY+RXXJhZAQBSNQgSOxqn792ARzdAwvrFL?=
 =?us-ascii?Q?0mNkXki/XHS71cBvGqhPk2HjyrrRBOZxwWmNyx5cgo2zgLbjZuwPqzZYJVzU?=
 =?us-ascii?Q?85MTnIn7LBP7gSwlaNoAFbS12rO30TsckOvtVNdIdieAJizh?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB6683.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4021b091-a509-4944-6f3c-08def98f0243
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2026 23:02:54.6590 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Qfr34Ezy8hfzfP4RjmLfAOHWIlhofBdjmxcuQqBK7rUuTNXErhFwnkNnQ/AqHzLYT1r1nnIJSjU1kP3reSrUrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR21MB6443
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

>=20
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


I'm not sure about this one, should it be rte_memory_order_acquire?

Thanks,
Long

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

