Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEEBBC982E1
	for <dpdk-dev@archiver.kernel.org>; Mon, 21 Sep 2026 09:46:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9B1CA4029B;
	Mon, 21 Sep 2026 11:46:09 +0200 (CEST)
Received: from TYPPR03CU001.outbound.protection.outlook.com
 (mail-japaneastazon11022090.outbound.protection.outlook.com [52.101.126.90])
 by mails.dpdk.org (Postfix) with ESMTP id 601154021F
 for <dev@dpdk.org>; Mon, 21 Sep 2026 11:46:08 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WzU6MJ0wKK/4sYH1C3R6Jfdu8gezsxcgpGwnvBd45YHODE8yQxultOoSUJcVvYwSMmLTexAuhboDSj3RZqklZI/p/32pbvt+/+QjAx9MBP/9pFehX2jhKulh6+SVQZ2fycRE9l7dTepoQBWAVI5eVdhWxKBICZXWvJaaD+8nFQwD8T4gEr89n1qjVQ9pMBnvS2zWtnyoFETlTWq+7PR2VrvZlkhKm0VWNA8nE8K00crlWelM9eBX+iMu9ROQvxD36gjBeaV7ej5Eygr5WChckGFYCzHi/VUFCe9AfvlGw9ZPXK2RqEJ6iZ1S2KQUeEQ5b1iNmCXVxXDbfBJv+oE3Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:MIME-Version; 
 bh=5Fy64IexjW4YyuWozBnBvvQEKkTQyEc6uWHzX+eUC68=;
 b=FdG5YL0zkDV2TzgDF+q9PSG5G8thmM3kF4FM7qaKIwBdqLDQ2zmR85phbqNYwJEQX45qEYsxTYCGxcmLn/0z5w4MdM0ogL5S4gGYSux4AN2DAk9i44Ea1qKMqmiH8nOOPHoBkgNGvPwHeIwrzFNKtdr9HKRzE7zHgRyM1RF1RsCzYv/0uEH3bjlBm1xTDJRqzywLvWGl7/PlSC7YXlYBGy0XbqBMLSgNPdPLnacpmwljaj3r6bbXwM07Med55iSvORJSsb9Kirb77fWmQx8R5lEt3Hx8pz/7dytlmyphWKr+DEutHqFc4cjf8qKoNLm6VgaSjQnSfzZv0b5y5Rai6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Fy64IexjW4YyuWozBnBvvQEKkTQyEc6uWHzX+eUC68=;
 b=hHMJgu3pe6rLZruUJ0Rp+Pb+rocTeyHFaE1syhiKv/jGGUeqYIGFMqsO+alb48i5WCt/Fs8WNgj5aFeQWixObL/GKPRJxOsneJENt8RaK1mEHyYiggY4eeCqgtCQPskSqDfPGTu9bi3brMdmtIwa8Cb/KLy//rL4ANOir8allrc=
Received: from SE3P153MB1848.APCP153.PROD.OUTLOOK.COM (2603:1096:101:340::5)
 by KUXP153MB2044.APCP153.PROD.OUTLOOK.COM (2603:1096:d10:ab::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.2; Mon, 21 Sep
 2026 09:46:03 +0000
Received: from SE3P153MB1848.APCP153.PROD.OUTLOOK.COM
 ([fe80::8f4e:575a:4706:a56e]) by SE3P153MB1848.APCP153.PROD.OUTLOOK.COM
 ([fe80::8f4e:575a:4706:a56e%6]) with mapi id 15.21.0472.000; Mon, 21 Sep 2026
 09:46:02 +0000
From: Wei Hu <weh@microsoft.com>
To: Stephen Hemminger <stephen@networkplumber.org>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: Long Li <longli@microsoft.com>
Subject: RE: [EXTERNAL] [PATCH v8 14/25] net/netvsc: replace rte_atomic32 with
 stdatomic
Thread-Topic: [EXTERNAL] [PATCH v8 14/25] net/netvsc: replace rte_atomic32
 with stdatomic
Thread-Index: AQHdRuDDdyCp0ZeyEU+gxCpA4ofw9bbYzhbA
Date: Mon, 21 Sep 2026 09:46:01 +0000
Message-ID: <SE3P153MB184886D4FC455B0340C4351EBB842@SE3P153MB1848.APCP153.PROD.OUTLOOK.COM>
References: <20260521042043.1590536-1-stephen@networkplumber.org>
 <20260917201119.2168234-1-stephen@networkplumber.org>
 <20260917201119.2168234-15-stephen@networkplumber.org>
In-Reply-To: <20260917201119.2168234-15-stephen@networkplumber.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=72c1c929-5e7f-477c-b92d-fe869e906664;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-09-21T09:45:22Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10, 3, 0, 1;
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SE3P153MB1848:EE_|KUXP153MB2044:EE_
x-ms-office365-filtering-correlation-id: b98c3e71-fe4c-472a-1f26-08df17c525ac
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|42112799006|1800799024|23010399003|376014|366016|38070700021|6133799003|4143699003|56012099006|11063799006|18002099003|22082099003|10067099003|7146999003;
x-microsoft-antispam-message-info: GEptokg2ayKZReYsRYPatTySpBRxHCB5aiHRkVmZnJ07QIcNcX0RqBVaAKlvb3jPepSSSIcyLa2A2TDmkP12SsY72XBy8bqARQnqU3zI5TQKBaP3FgOM4vjrJUXRcwpOucIy9cETezNTl0P9pm0HYDv5HY0TdOuXiXYJK8R01UQ3VKBF1Li/akCUnoEKXVLP4yUuTaeOJlt1Bp1qlqXmnoVIFRoqQYM9A/7RdbmEJZKR2VA+B6S74vrzz8mlOR/dBE85hdxAW1VNowVK6Di2uXn3x1/YxfSbdfecNUoXESp7TdymQX5WK4upw6naRtxutqypML3GviFSv/s9STbZT3dUZjn1wm50+KYTtuGopg3J4z/UXvxNsIoDW0N53mFGXjWNldUJBhh4cDEpKeJ6yCJCRAtfPTtaX1UYoB2+eeGyQf2QU5ZyCu5giB1eXyT1Xp9e6my0uCmez7IZLdUyV3ApG83A6HCDep7tF/ZjG40wqi+YOLzSUql89TPCORSE+fHBVJqClRYtIuSkIFb5oLN5uT12edke949mr2d+ERz928Z2R8p9o1NLnMk/U5eMelq0Q6vzM2eZ221i01fujPfPLHyRSrA4yAWMRuoHtPnoGJWgWZOi/zhcAwQB2KODPFLcLJPgnFONBT+aSXDg1k1pxdX0Ft2bN1AHPgB/cVGfntXNP+2dmyqhCK21MeeN7Plzo1H3lSCwaNxWcoqq68vIYedk/cj+GIZQXOShIEQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SE3P153MB1848.APCP153.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(42112799006)(1800799024)(23010399003)(376014)(366016)(38070700021)(6133799003)(4143699003)(56012099006)(11063799006)(18002099003)(22082099003)(10067099003)(7146999003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?pPvKmhqZ5AKjrEaiGqa+dbcE+l625HEvhYBIYNA8siSOVrx6kW1UAEUM1YQm?=
 =?us-ascii?Q?a2jM0WIxmRsPZ9etAzj707oi/FWeNb/CT41IjCuL4dj98tirUhaqIH2gH04M?=
 =?us-ascii?Q?kv3e/3+2LbxZPrhS2Oy1agNLfawCetwr3K0pJio4ePoz2pEKjD4AFFKE70xa?=
 =?us-ascii?Q?QpQzlDbNuQerVktwtdH//CPK2uQUp+ixylTuGddkBIoIOeOYaWe82HwFDxrB?=
 =?us-ascii?Q?O/a7MIXfiQ/zg88WvZZkmPRqfv+LEdeAkWeQg+fLSwUOIlkl0TN25o19Sdti?=
 =?us-ascii?Q?cD2agG8uNGEpJ319j82i2M8eeE2dqmW3bIwwGukweXwQRZMlcSm30jzTd+L2?=
 =?us-ascii?Q?8e6FxUKtt9gIBmMZW3eCdVxQ+M9u+/qgwr+W45wc3Nwa0LO9wbGudc/EaAOo?=
 =?us-ascii?Q?Wb50tx4hT2VK73Jc6hx46WHSODN5doSKe84bznxJyvtRA0Koa9L9BheqE9C7?=
 =?us-ascii?Q?FkvJ/ZKnO5E0+/K5vS74zziWotER8K0/3PDcTtEvNn3HFiyElswf6fTcR9Ph?=
 =?us-ascii?Q?6snV1gEO3MErPhHSHc37zh6Aa1P2wbu1oa+tU+Mdu6hYgzzo27kfjs5mlAy+?=
 =?us-ascii?Q?6p0zlOisLmQITijankObPhWsyTVec+h58isXSQj5DVLIBIihGuQL3rS1NrEy?=
 =?us-ascii?Q?adL6Y4lD245GHH4cU1ndkgio8ZKEleVUDzIleYdajJA2DljMr8jx/gf2knCy?=
 =?us-ascii?Q?8eXP1SlIuu9dz28ZRiTnOx7iF6XZHCeEARAZLSUex4fYGRMC2mKlfgwP8Pcq?=
 =?us-ascii?Q?88azzSz2jIcAURbyfxP6Z3Ta40Jv8kneMW53TdvJA5DYWK4qg+EgNTJByRB1?=
 =?us-ascii?Q?WwMuglz0JIjjCy2vACv+imyZXVEMiaq0I1y5b3k5v1zOuhdrVrwgMsjqeaAR?=
 =?us-ascii?Q?1m6tofUrxEcMZGGLERA8JAoQKG8STOTDt4Qv++7lXPS0DREgxuCjnaX+B9ca?=
 =?us-ascii?Q?CX9jUR5HjpVbb+ZhTD4qV+ByhlmbYGHxxLi+VybYyuJWpRsMf7aoImks0wZG?=
 =?us-ascii?Q?yzkipKPIFy7uCTnoSvD9hl20rar8NeJ8R4e9q4VyFVX8azZHgG1GxBN2ahgr?=
 =?us-ascii?Q?raKQlqxJBlwHnQHv/0XApio5DkfhnLIn2Us+0sg+Xv0g2h2Xco8YvWIKrE0P?=
 =?us-ascii?Q?Kz4LZil9vcZcU5m0j9uq7sYikABglA5OtYqKtHiK8wmrOG78CCEIm0TsZkEz?=
 =?us-ascii?Q?ORgBBPFpPdzjBt+iZMmLJYxihCAZuBlfNkPZAtYl3ga9f/2fs6TW/NMOIfBi?=
 =?us-ascii?Q?cDRd8tyrX2MsIusNE+7W4JW0kbdXDnMSzoRnQI5mj8c2k/ptJgPehCewIubi?=
 =?us-ascii?Q?0gXa8Br/atJ8zWAhNQuaNg+g0okheHsO90lCkw3nltuA3+GMk2yB63Nm7p2Y?=
 =?us-ascii?Q?z02Pvg40F+tR+S1A3nT1dwcRDDWwFa9yO20Y3XWLI0w+PJXt8JAdp0rqriba?=
 =?us-ascii?Q?Z1/MS4vNGnP2dt76SOKQwDut3NT4gahvofe0QXKJEe0+4hA/o5ZlNHI2enRH?=
 =?us-ascii?Q?X/FwtwRKLTPV9bnd0q8e/gS7omsbtC7Y0XdKVjKlH7VRKBB/ow+BkeRT2x3t?=
 =?us-ascii?Q?h/hZsIeFJo8LXOdmV7Fc+SnFIrG0BwrcNrc2hAOz5JeM3sAYj0IbcAV0QLNp?=
 =?us-ascii?Q?7tlK1zVyobwikONRSWte+wSsX6+6h4nBjWXlovZtfQgMaWJv1tOitX56UCCU?=
 =?us-ascii?Q?AML5VhRM1UrWK6dTwC+MWdsPEBchJzhqxv3QDJcHx5C36eHc?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SE3P153MB1848.APCP153.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: b98c3e71-fe4c-472a-1f26-08df17c525ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2026 09:46:01.7742 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G0hWzdQRrUIgnk3COphp3pJETh6CWMQEa6J7oV2iu42h2L3lxXTcE2GUHQ8EXWwmUY4yvsRRVx1FiObk+PMQyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUXP153MB2044
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
> Cc: Stephen Hemminger <stephen@networkplumber.org>; Long Li
> <longli@microsoft.com>; Wei Hu <weh@microsoft.com>
> Subject: [EXTERNAL] [PATCH v8 14/25] net/netvsc: replace rte_atomic32 wit=
h
> stdatomic
>=20
> Change the rndis transaction id and buffer usage to use stdatomic functio=
ns.
>=20
> It also removes rte_smp_wmb() and relies on the release ordering of compa=
re-
> exchange.
>=20
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> Reviewed-by: Long Li <longli@microsoft.com>

Reviewed-by: Wei Hu <weh@microsoft.com>

> ---
>  drivers/net/netvsc/hn_rndis.c | 28 +++++++++++++++++++---------
> drivers/net/netvsc/hn_rxtx.c  | 12 +++++++-----
>  drivers/net/netvsc/hn_var.h   |  6 +++---
>  3 files changed, 29 insertions(+), 17 deletions(-)
>=20
> diff --git a/drivers/net/netvsc/hn_rndis.c b/drivers/net/netvsc/hn_rndis.=
c
> index 7c54eebcef..4e13d7c38f 100644
> --- a/drivers/net/netvsc/hn_rndis.c
> +++ b/drivers/net/netvsc/hn_rndis.c
> @@ -17,7 +17,7 @@
>  #include <rte_string_fns.h>
>  #include <rte_memzone.h>
>  #include <rte_malloc.h>
> -#include <rte_atomic.h>
> +#include <rte_stdatomic.h>
>  #include <rte_alarm.h>
>  #include <rte_branch_prediction.h>
>  #include <rte_ether.h>
> @@ -59,7 +59,8 @@ hn_rndis_rid(struct hn_data *hv)
>  	uint32_t rid;
>=20
>  	do {
> -		rid =3D rte_atomic32_add_return(&hv->rndis_req_id, 1);
> +		rid =3D rte_atomic_fetch_add_explicit(&hv->rndis_req_id, 1,
> +
> rte_memory_order_seq_cst) + 1;
>  	} while (rid =3D=3D 0);
>=20
>  	return rid;
> @@ -357,12 +358,14 @@ void hn_rndis_receive_response(struct hn_data
> *hv,
>  	memcpy(hv->rndis_resp, data, len);
>=20
>  	/* make sure response copied before update */
> -	rte_smp_wmb();
> -
> -	if (rte_atomic32_cmpset(&hv->rndis_pending, hdr->rid, 0) =3D=3D 0) {
> +	uint32_t expected =3D hdr->rid;
> +	if (!rte_atomic_compare_exchange_strong_explicit(&hv-
> >rndis_pending,
> +							 &expected, 0,
> +
> rte_memory_order_release,
> +
> rte_memory_order_relaxed)) {
>  		PMD_DRV_LOG(NOTICE,
>  			    "received id %#x pending id %#x",
> -			    hdr->rid, (uint32_t)hv->rndis_pending);
> +			    hdr->rid, expected);
>  	}
>  }
>=20
> @@ -388,8 +391,11 @@ static int hn_rndis_exec1(struct hn_data *hv,
>  		return -EINVAL;
>  	}
>=20
> +	uint32_t expected =3D 0;
>  	if (comp !=3D NULL &&
> -	    rte_atomic32_cmpset(&hv->rndis_pending, 0, rid) =3D=3D 0) {
> +	    !rte_atomic_compare_exchange_strong_explicit(
> +		    &hv->rndis_pending, &expected, rid,
> +		    rte_memory_order_acquire, rte_memory_order_relaxed)) {
>  		PMD_DRV_LOG(ERR,
>  			    "Request already pending");
>  		return -EBUSY;
> @@ -405,7 +411,8 @@ static int hn_rndis_exec1(struct hn_data *hv,
>  		time_t start =3D time(NULL);
>=20
>  		/* Poll primary channel until response received */
> -		while (hv->rndis_pending =3D=3D rid) {
> +		while (rte_atomic_load_explicit(&hv->rndis_pending,
> +						rte_memory_order_acquire)
> =3D=3D rid) {
>  			if (hv->closed)
>  				return -ENETDOWN;
>=20
> @@ -413,7 +420,10 @@ static int hn_rndis_exec1(struct hn_data *hv,
>  				PMD_DRV_LOG(ERR,
>  					    "RNDIS response timed out");
>=20
> -				rte_atomic32_cmpset(&hv->rndis_pending,
> rid, 0);
> +				expected =3D rid;
> +
> 	rte_atomic_compare_exchange_strong_explicit(
> +					&hv->rndis_pending, &expected, 0,
> +					rte_memory_order_release,
> rte_memory_order_relaxed);
>  				return -ETIMEDOUT;
>  			}
>=20
> diff --git a/drivers/net/netvsc/hn_rxtx.c b/drivers/net/netvsc/hn_rxtx.c =
index
> 0d770d1b25..6f536610f2 100644
> --- a/drivers/net/netvsc/hn_rxtx.c
> +++ b/drivers/net/netvsc/hn_rxtx.c
> @@ -17,7 +17,7 @@
>  #include <rte_string_fns.h>
>  #include <rte_memzone.h>
>  #include <rte_malloc.h>
> -#include <rte_atomic.h>
> +#include <rte_stdatomic.h>
>  #include <rte_bitmap.h>
>  #include <rte_branch_prediction.h>
>  #include <rte_ether.h>
> @@ -558,7 +558,8 @@ static void hn_rx_buf_free_cb(void *buf
> __rte_unused, void *opaque)
>  	struct hn_rx_queue *rxq =3D rxb->rxq;
>  	struct hn_data *hv =3D rxq->hv;
>=20
> -	rte_atomic32_dec(&rxq->rxbuf_outstanding);
> +	rte_atomic_fetch_sub_explicit(&rxq->rxbuf_outstanding, 1,
> +				      rte_memory_order_release);
>  	hn_nvs_ack_rxbuf(hv, rxb->chan, rxb->xactid);  }
>=20
> @@ -602,8 +603,8 @@ static void hn_rxpkt(struct hn_rx_queue *rxq, struct
> hn_rx_bufinfo *rxb,
>  	 * some space available in receive area for later packets.
>  	 */
>  	if (hv->rx_extmbuf_enable && dlen > hv->rx_copybreak &&
> -	    (uint32_t)rte_atomic32_read(&rxq->rxbuf_outstanding) <
> -			hv->rxbuf_section_cnt / 2) {
> +	    rte_atomic_load_explicit(&rxq->rxbuf_outstanding,
> +				     rte_memory_order_relaxed) < hv-
> >rxbuf_section_cnt / 2) {
>  		struct rte_mbuf_ext_shared_info *shinfo;
>  		const void *rxbuf;
>  		rte_iova_t iova;
> @@ -619,7 +620,8 @@ static void hn_rxpkt(struct hn_rx_queue *rxq, struct
> hn_rx_bufinfo *rxb,
>=20
>  		/* shinfo is already set to 1 by the caller */
>  		if (rte_mbuf_ext_refcnt_update(shinfo, 1) =3D=3D 2)
> -			rte_atomic32_inc(&rxq->rxbuf_outstanding);
> +			rte_atomic_fetch_add_explicit(&rxq-
> >rxbuf_outstanding, 1,
> +
> rte_memory_order_acquire);
>=20
>  		rte_pktmbuf_attach_extbuf(m, data, iova,
>  					  dlen + headroom, shinfo);
> diff --git a/drivers/net/netvsc/hn_var.h b/drivers/net/netvsc/hn_var.h in=
dex
> 574b909c82..d7124a7df9 100644
> --- a/drivers/net/netvsc/hn_var.h
> +++ b/drivers/net/netvsc/hn_var.h
> @@ -85,7 +85,7 @@ struct hn_rx_queue {
>=20
>  	void *event_buf;
>  	struct hn_rx_bufinfo *rxbuf_info;
> -	rte_atomic32_t  rxbuf_outstanding;
> +	RTE_ATOMIC(uint32_t) rxbuf_outstanding;
>  };
>=20
>=20
> @@ -167,8 +167,8 @@ struct hn_data {
>  	uint32_t	rndis_agg_pkts;
>  	uint32_t	rndis_agg_align;
>=20
> -	volatile uint32_t  rndis_pending;
> -	rte_atomic32_t	rndis_req_id;
> +	RTE_ATOMIC(uint32_t) rndis_pending;
> +	RTE_ATOMIC(uint32_t) rndis_req_id;
>  	uint8_t		rndis_resp[256];
>=20
>  	uint32_t	rss_hash;
> --
> 2.53.0

