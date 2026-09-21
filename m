Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E04DBC982E1
	for <dpdk-dev@archiver.kernel.org>; Mon, 21 Sep 2026 09:37:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BF2214029B;
	Mon, 21 Sep 2026 11:37:55 +0200 (CEST)
Received: from OS8PR02CU002.outbound.protection.outlook.com
 (mail-japanwestazon11022132.outbound.protection.outlook.com [40.107.75.132])
 by mails.dpdk.org (Postfix) with ESMTP id D08634021F
 for <dev@dpdk.org>; Mon, 21 Sep 2026 11:37:53 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=omUmsW1u2ea1tjFIs2+OUZ+aVRo2SbijbHC0TC+z5JdjiDRY8+iBgLcfYsohR0r9wwk2X/P3b9z3zz56G89SlYZbw33bfF9A81gMc+lLs1phcLHZ1JAldbazhBKoLSCaBsu3MPzjENguafrCXzaBiyp3OJeCcCrcrHZhLncLWMvhXFMLs/hFzZ5D6sHs4FyJ9xmq2N7/P3VlW8lWG/NzyvJ0WPo59Yq8civ704vzquMsSxis4ujAMlMZXWOWcZSe+3WkAJkLgg00LfzmTDqCfhMo27s4Hlz+0EAhY1hEZr0YH4+lZfqxlYp3g/8FsxO12VKoN78L6LpLkCeU+ipPBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:MIME-Version; 
 bh=1rEHkBWAS8x+a11aKTpVY93e/ls2T9KcOmisu47sSC4=;
 b=bgNE8UErCClmJtjtcSpOcdhv6HU08j1GnijthzdRo/IwMVJpqrNiSB9KFsF8TuRfQQEdZgLnpkVrqfgKk7mdRCaKGjYASqdn+75AMzIoEv1o3hClZj3DhhIYBF4AmaHgBMa+QHFWZaPsflSMp4UCOHJJcspnKFAuRBXYFqwZVLZwWmCQNa7+jNpjrdMczuGBCCgumosW89H4sYITs6YTKLVEDqob8ytbeMl6vRcN1TNjbWdLdLGBNi1bE1iJ+CpY738R4XplN6cBXCuQllplbcoPehvfxhZ0JAw8xIoQWKSyRzmcqFqOvQGOnglVb9MbqzJBilUDk8EkRbzYgWZP4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1rEHkBWAS8x+a11aKTpVY93e/ls2T9KcOmisu47sSC4=;
 b=akZGoxGFcM9iJs80Eu3Wzt1FvG4kcoxEg+40M9iqbaUv51BuNENLhu0OLYjbAUwaQGQO+FTF2BH62PeuDO+IogqKJPwkj+M5x+eCpjTMDnKqNVP70SUIH7+KoOuE0kA0eblJhIi9DdDOfkzU3wmj2G7oRPVK++ofxwc10jM0gBs=
Received: from SE3P153MB1848.APCP153.PROD.OUTLOOK.COM (2603:1096:101:340::5)
 by KL1P153MB0962.APCP153.PROD.OUTLOOK.COM (2603:1096:820:cf::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.7; Mon, 21 Sep
 2026 09:37:47 +0000
Received: from SE3P153MB1848.APCP153.PROD.OUTLOOK.COM
 ([fe80::8f4e:575a:4706:a56e]) by SE3P153MB1848.APCP153.PROD.OUTLOOK.COM
 ([fe80::8f4e:575a:4706:a56e%6]) with mapi id 15.21.0472.000; Mon, 21 Sep 2026
 09:37:46 +0000
From: Wei Hu <weh@microsoft.com>
To: Stephen Hemminger <stephen@networkplumber.org>, "dev@dpdk.org"
 <dev@dpdk.org>
Subject: RE: [EXTERNAL] [PATCH v8 16/25] bus/vmbus: convert from rte_atomic to
 stdatomic
Thread-Topic: [EXTERNAL] [PATCH v8 16/25] bus/vmbus: convert from rte_atomic
 to stdatomic
Thread-Index: AQHdRuDETpQe0za8H0OakEHZhAk9hbbYy54g
Date: Mon, 21 Sep 2026 09:37:44 +0000
Message-ID: <SE3P153MB1848880C6F67309EA485B1A5BB842@SE3P153MB1848.APCP153.PROD.OUTLOOK.COM>
References: <20260521042043.1590536-1-stephen@networkplumber.org>
 <20260917201119.2168234-1-stephen@networkplumber.org>
 <20260917201119.2168234-17-stephen@networkplumber.org>
In-Reply-To: <20260917201119.2168234-17-stephen@networkplumber.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=9663cbe2-16b9-4c93-8edf-85cfbaa746e2;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-09-21T09:36:32Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10, 3, 0, 1;
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SE3P153MB1848:EE_|KL1P153MB0962:EE_
x-ms-office365-filtering-correlation-id: 1fddf9a3-7b55-4b34-2434-08df17c3fd82
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|42112799006|376014|23010399003|1800799024|38070700021|18002099003|22082099003|56012099006|11063799006|7146999003|10067099003|4143699003;
x-microsoft-antispam-message-info: mYlJ1MQCWYHnp8/nu0sATBLxE3bZPjN65wde2IGN5zyOu82Q8S+jvrmTT/fUEmPcQfcqgMLk28UfYdVvUiNtd6GsZRXD+Rq3WmQGdboHPfp/ITNDgsQU0s2C1UkXdjN0EBaRDb3+jVnhojsk9+24RNFqIJBE3nxgjQvzCnclSEyLbQ7RnU7gkix6jZ+QfGVQnEAUhEPsWjEnzxNuWPJF4GWPxLyznvLXrbPBiG8ftrWjpahKJxKSh2wX34Pp0RbnaRaRPtjnydfub+3Vqy4rcynOQeMmAwhOH2FR7YSK3QzxaA2lbFbegVzBTgeVp08l7o8w972FrdbL39siTUhlC+3k6uSV6ENdqXohk/vHWYw8eSFMi/oDklSmpM83yLl1tvYSmD+YQuLWg6IT/3BKB0WinhE1sE0kXRycwYFNPlt7YMQzyvDi2U9kWHxf7saCwnFnVDnf7rE45sVr0bFVorPOpDzrjwTnGDu+XkXFZuez/4ArysKuuYpwnr/EHI0oc9FsToY42eTbTNG0OzJ1Orsnj+Kp1rmpOa0pTvoLZLRFpd8wbc4mUI0YCDxuuzbVXqCz/WaR0AYWjjGNy0nN/MNpAyYVrKX+E41v72O219TUNHfRykusZMUqulg5+chfINPnzCjSAibaDgArRNcF9lzNgaxqifc2dEvj397ILnXo2Oy9Kg2HlHd3a+0GUUU/mIIq51d3tEmFrLXjxdritESiGQXjF983aXcQDpcHMsg=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SE3P153MB1848.APCP153.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(42112799006)(376014)(23010399003)(1800799024)(38070700021)(18002099003)(22082099003)(56012099006)(11063799006)(7146999003)(10067099003)(4143699003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?IJ/CXXOmj/dTOPgijrIKLB/TyWUpXodFln2oOqeUfA0/msTONQkKX+DOmvNt?=
 =?us-ascii?Q?rr0Ljv7GlhF3kCxnzMwbiUomT0SgBHCFZm32l2pqTspSv9mUYk/Lg3AB0jv2?=
 =?us-ascii?Q?PP586HFmYn4ZTf06gYXHauGeYCqdUCCzdxvr2X0eQIEyg1EcQBYxZDmQiWCP?=
 =?us-ascii?Q?o0GZ/iFr9VQAu5A/pF9lfTq6kINcOZ0BTXBwQIpMAuVAQz7bVqEp2D/Zjckw?=
 =?us-ascii?Q?7TWRoupSN2XOC227OALUW4j0BHTgf6p1iYtkmcisxnlq/mSK/fp+JK0ulK7C?=
 =?us-ascii?Q?hUbxgNwuE3mXnZrK5+9JlIfYkroGH/BXTzneDEHbi6gw2AjBCUMzrSlo+mN5?=
 =?us-ascii?Q?b/IQLvNirMUWUrStSPbbwkziEYiFI4Sr0qWfE/QnbuVg/Z3Yc8nodx8TtMy6?=
 =?us-ascii?Q?ms9hPvMKgTS8s9phEom3DxwVBjQaltNzPoQmDuWbjEemqtOCzdcXlhBDA9nJ?=
 =?us-ascii?Q?eH3HcY4FumS6sEjSGrCdo3E0UkLuEo4D1UeMIGTLKkYDtikDEuCCOW52AopO?=
 =?us-ascii?Q?/+THofEULWIGQV+NjCblQeXz3Fta3neEqMmJamXz4AgaTq/E7I3TK4Y+yUcT?=
 =?us-ascii?Q?3VuBvVHKeKGZINPE3G34v4QPi/zvOuSGnj86HtLzgKL6surqr/Bs9M6OanEx?=
 =?us-ascii?Q?PPr9K8uIhLc3biTABmPFy4Jf/mgehQH5IcAV1iA4TBvS4m4qDUPbfL9sZfcE?=
 =?us-ascii?Q?4VDEt8jQnmF6d4bd/YH6L2tuivY5AxBF3r2wPkHLdMvSfKNe9Dq5YYuwQynT?=
 =?us-ascii?Q?vTbKBbMpSWcC9vjocmEa9uOWqIdQzEKd8hAwpsZ2qVsM3zpiLLWhs40KJYVA?=
 =?us-ascii?Q?68nYxTKJx9BYF49AvEq1GhdHb9bV0yxfaJIt6ZnOBwzrBywnRuKkmF5Y9Uee?=
 =?us-ascii?Q?ZjdIiMrC8VBoqsv+cjCvpdtnhDPCDrwYY4fjQq3IbQw+BOFht10cPFaBUFF5?=
 =?us-ascii?Q?qjDm4YSNh+8yW6O1bfcLEMJYdPNvYWN/BRKK2jfzxggAhIuF+IVwGXYgktSU?=
 =?us-ascii?Q?KZGjYbV7AwIg32+fl++VyP2M5PrUI6IF6EYQinMkPcDoTtLRWP8t6PSVNviQ?=
 =?us-ascii?Q?8pOKq5vof3qR3V5BiXmNmi0L89jcLNXuzo58VO8xEiuwqeaf9hOBhOqoeEKj?=
 =?us-ascii?Q?YYH1IVItL1AGjXZFZNCAeVTghks0zMSyQ/KoUwgREbcSA0X1nGI5QipXvMU8?=
 =?us-ascii?Q?MGCripbWzhnKw1DCm+pjm60TJimaAHYWcUi1n1cs+J5kyQMUlMokrCMfXyid?=
 =?us-ascii?Q?72KQcwkBlPvasETb86I/zEdBlX2Wi+ORdO3pNMBfy0QTFtcqGfLGD/hmzhZ2?=
 =?us-ascii?Q?h+wux9BuBCGK37j7dVZsLta4867IWge1ZN1qj+PuhoFGl6bY50cqrgkEavDd?=
 =?us-ascii?Q?cfM2lPCSwjpKmk6wvS2rZV2G9tiL/zh/R2lm/w+tosjBrK2aPilCpmI5Nc13?=
 =?us-ascii?Q?h2MeELkDyOafyWBHTj1h+aHbrU3ZXkj9azTo14FHkVVgJ+dGVN60TU7fST6I?=
 =?us-ascii?Q?mSfL/cUQtHw/+lZTPhVANK1DD1l/gcbzyAso/0p5z8UlD2pvv86f6c+Molew?=
 =?us-ascii?Q?7XI10DTFZdVu0LZBUxo/VJ9Bdllb/B4Go1XqhUbE4Leu/bkUMfLVbwv6ZRZm?=
 =?us-ascii?Q?bX2DtR14w1zjQ6Fx7nZubwDliv13+Rd0ZntJbjKV0RhLlyV+JC79tBqJ73Sm?=
 =?us-ascii?Q?jA1ed8Rxmv1YuzRNA+udVBXpOhl2CrzA6CNtFGONmqKNHasw?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SE3P153MB1848.APCP153.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fddf9a3-7b55-4b34-2434-08df17c3fd82
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2026 09:37:44.8885 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VUFJHIDf036+e0QcUr6E5sZPDCJW699OzS9n5pAtd0Ud8jOEc9cfpIGCZAgVddkFOyVR4rjmi//kYJjnYdUPBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1P153MB0962
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
> Sent: Friday, September 18, 2026 4:10 AM
> To: dev@dpdk.org
> Cc: Stephen Hemminger <stephen@networkplumber.org>; Wei Hu
> <weh@microsoft.com>
> Subject: [EXTERNAL] [PATCH v8 16/25] bus/vmbus: convert from rte_atomic
> to stdatomic
>=20
> The tx ring producer uses two cursors:
> - tbr->windex which is driver private. It lets producers reserve space
>   concurrently without a lock
> - vbr->windex is the host visible commit cursor and has to advance in
>   reservation order so the host never sees it point past unwritten data.
>=20
> Convert the reservation CAS on tbr->windex to a weak compare exchange, an=
d
> replace the smp_wmb plus CAS spin that published the commit with
> rte_wait_until_equal_32 on the previous producer followed by a release st=
ore.
> The release ordering on that store covers what the barrier did.
>=20
> The wait on the previous producer uses acquire ordering, not relaxed.
> A release store only carries the writes of the storing thread and anythin=
g it has
> a happens-before edge to. Producers publish in reservation order, so when
> this thread stores its own windex the host may then consume the data of
> every earlier producer as well. The acquire on the wait pairs with the ea=
rlier
> producer's release store, putting that producer's data writes into this t=
hread's
> happens-before set so they are carried by this store too.
>=20
> vbr->windex stays volatile uint32_t in the packed bufring struct.
> The host is not a C11 thread.
>=20
> The atomic qualifier is applied by cast at the single publishing store; t=
he
> (uintptr_t) launder there avoids a bogus misaligned atomic warning from t=
he
> packed attribute, since windex sits at offset 0 of a page aligned struct.
>=20
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>

Reviewed-by: Wei Hu <weh@microsoft.com>

> ---
>  drivers/bus/vmbus/private.h       |  2 +-
>  drivers/bus/vmbus/vmbus_bufring.c | 40 +++++++++++++++++--------------
>  2 files changed, 23 insertions(+), 19 deletions(-)
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
> index fcb97287dc..dcd66390a3 100644
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
> @@ -121,17 +121,13 @@ vmbus_txbr_write(struct vmbus_br *tbr, const
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
> @@ -139,8 +135,12 @@ vmbus_txbr_write(struct vmbus_br *tbr, const
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
> +	} while (!rte_atomic_compare_exchange_weak_explicit(
> +			 &tbr->windex, &old_windex, next_windex,
> +			 rte_memory_order_acquire,
> rte_memory_order_relaxed));
>=20
>  	/* Space from old..new is now reserved */
>  	windex =3D old_windex;
> @@ -157,12 +157,15 @@ vmbus_txbr_write(struct vmbus_br *tbr, const
> struct iovec iov[], int iovlen,
>  	/* The region reserved should match region used */
>  	RTE_ASSERT(windex =3D=3D next_windex);
>=20
> -	/* Ensure that data is available before updating host index */
> -	rte_smp_wmb();
> +	/* Wait for previous producer to publish their windex update */
> +	rte_wait_until_equal_32(&vbr->windex, old_windex,
> +rte_memory_order_acquire);
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
>  	*need_sig |=3D vmbus_txbr_need_signal(vbr, old_windex); @@ -224,7
> +227,8 @@ vmbus_rxbr_read(struct vmbus_br *rbr, void *data, size_t dlen,
> size_t skip)
>  		return -EAGAIN;
>=20
>  	/* Record where host was when we started read (for debug) */
> -	rbr->windex =3D rbr->vbr->windex;
> +	rte_atomic_store_explicit(&rbr->windex, rbr->vbr->windex,
> +				  rte_memory_order_relaxed);
>=20
>  	/*
>  	 * Copy channel packet from RX bufring.
> --
> 2.53.0

