Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58F84C5CFDB
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Aug 2026 22:45:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 092C840279;
	Fri, 14 Aug 2026 00:45:39 +0200 (CEST)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11022117.outbound.protection.outlook.com
 [40.93.195.117]) by mails.dpdk.org (Postfix) with ESMTP id E4A6B4026E
 for <dev@dpdk.org>; Fri, 14 Aug 2026 00:45:36 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b9GunNGnTN65vyCEJhSOgApwX8wmb79NvIc32lPQXLlEjIEXSdpgZVzWecxktY83z6WLFjQZHHtnJ+LEbruIuPrh3XvkxgvEqUtzstS9bYu2aj3px0OmfKW709JCTOcBT9kMbEQ61ZiuBu1VGFr0Z9MHxpbGx2d5c417jCR97V+WNt2N6JrD3eljhyQSt2fMyKEP5vsjudUQMG69NQ5Kb5pEsGMn+RpK/BeBFpIgQ0yN/3YOGpxDKaDQRezsyLmGQqyEmgDyJ4Q3RLYZxsDwq8hgXFzNl6ja6N1XCFIv8aMtOlktKt053u0h3h9Lbg6XdRmed2tOCK0F6pdDVsRNaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AixfekP7kUJsK4K8jd92bfpc8NhyjaTus3LCJl2kfto=;
 b=JmvFUHYk7eD4CKUuUIL+P/KPPGJJv2KA87ZJvXNXbYRLX0rQ5ESQnaqzA5o/8ye+CLlhhFq1JCdQGZ2V4EtNZkq6uLIc4xg0ChgDWP1Oe2YJChp5GA/8kD9D/whts7mT9JQSgFAk50EzBgantG46kYT2B9qlBAE8xj5T9EfknpZ8co704LraNcSFY9mrfqbqUwowI7yD4Liw9Oqa4MNoAsCpmfEPa3wXFvVBtGLF80HGHTl2k877fvVbLqVmmI301lEudZ5ndacXyqr+hXtYpnn3/pj/FlvNSjcte+cxlsgQw3rPE5HNxXmD1n9ynIadYvO25w5s4hWN6mAm9BGM/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AixfekP7kUJsK4K8jd92bfpc8NhyjaTus3LCJl2kfto=;
 b=TWIv5vvgVAZu3ON3VD50NsSSls0/g67bCr6BYlpFTqj2jedvUnBT8d6mPRIZ7L4Lxd2qRu2e5qQBiQpVd5qXPOgr13Fi6Ivma0dnM9vfqlpQ3YsaxJ4Nie3aFGWaOyn8SWOuaC8ddJYp2aUbi8OYrlI0LsZG8XymvX6KdDwrBp0=
Received: from SA1PR21MB6683.namprd21.prod.outlook.com (2603:10b6:806:4a4::6)
 by SA1PR21MB6443.namprd21.prod.outlook.com (2603:10b6:806:4a9::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.9; Thu, 13 Aug
 2026 22:45:34 +0000
Received: from SA1PR21MB6683.namprd21.prod.outlook.com
 ([fe80::8bad:6294:8a07:fe18]) by SA1PR21MB6683.namprd21.prod.outlook.com
 ([fe80::8bad:6294:8a07:fe18%6]) with mapi id 15.21.0315.008; Thu, 13 Aug 2026
 22:45:33 +0000
From: Long Li <longli@microsoft.com>
To: Stephen Hemminger <stephen@networkplumber.org>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: Wei Hu <weh@microsoft.com>
Subject: RE: [EXTERNAL] [PATCH v7 12/24] net/netvsc: replace rte_atomic32 with
 stdatomic
Thread-Topic: [EXTERNAL] [PATCH v7 12/24] net/netvsc: replace rte_atomic32
 with stdatomic
Thread-Index: AQHdJVNQAj7ZY6c5jk2s8TeMSdb0HracoChQ
Date: Thu, 13 Aug 2026 22:45:33 +0000
Message-ID: <SA1PR21MB6683439834A66D604B642BE9CEDB2@SA1PR21MB6683.namprd21.prod.outlook.com>
References: <20260521042043.1590536-1-stephen@networkplumber.org>
 <20260806032544.21337-1-stephen@networkplumber.org>
 <20260806032544.21337-13-stephen@networkplumber.org>
In-Reply-To: <20260806032544.21337-13-stephen@networkplumber.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=a327ede0-c94a-421f-8f91-f4c0874ecdda;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-08-13T22:45:13Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB6683:EE_|SA1PR21MB6443:EE_
x-ms-office365-filtering-correlation-id: a4269694-ee55-4c93-9997-08def98c95cb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|38070700021|10067099003|22082099003|4143699003|56012099006|11063799006|7146999003|6133799003|18002099003;
x-microsoft-antispam-message-info: Zd3G7WT0xsb4atGVO35zRhwWE9Wp3vL5EsL54uBoTO0u6smBloNA1zo5LWzc5ukJupXh6gLhM203dkkCjLee4gwk/7FztUrQZFMHGQkVCjKeQwl9BL3wKDBnTCz8PYS65zaHQ1U/nUTk3oQX0kis/Ly6623mnG96Rck5NIB+YdRS7jzc5iSTAeUWT9i0TricPbqkGxqcOJgU+SuPdT0kwyZviPZvF0ffG9oFai4faGpZK+9w7Bn6opKvD7q0GGam9AVKwv0GhCWTL5dfHIpKOjls+TEWSnJSEvX2TIDhRlfSJ9pEBwtDWLBB6VrmNxX3K2omMXTvHz99ZOirLEK3u4kG+x5fK2I+wjKTc5YnSVsYvYHU5oS6ALgxnPGqJH3Ce/QAlu0iFFs9mX0RQ2ANaUJAl7aLs8sKX5SfA7EQKzmrtcHZUha5rtVNHSH5mw/iC637Umsn8U2ZOY6vCMu5M+VH1Z1TKxmwH7oM1vngovLGo9XQ5/R8+Shi0reh0ataIIOStKSIJ88TpbmdrSZNcrok2TOiSf/bZP5UyVNn1HxAm0/zU9hWs61YUjk/7EJbLNQN/zrllGsYRaTAnnFVDvBIyvjp0vmlHT7ABXKaldEqNF8+T92wZRESTC91djO0M2N6NcqKRi/oRtWrzpgk4t+MVgpiPFYCQH2oWZh2oElUQsk8xFxcRpdvq6GyT+iz3tHq6yDJGHQbocc0eq51s18qgDima6WkshfnM4MjHUY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR21MB6683.namprd21.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(38070700021)(10067099003)(22082099003)(4143699003)(56012099006)(11063799006)(7146999003)(6133799003)(18002099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?aEa+mZs8EZRk0+K8Nu5BDYAjwq3dI4OUGtPed0JX+0jOaqvqg8Z9BkLK+ffh?=
 =?us-ascii?Q?Hatvpg0kD1SItvwztXcJA4Mm4nKltTJ0naPCA5EMP+5gM1QlsOd4PDPNR0nx?=
 =?us-ascii?Q?MHJTU9g8bw3Tuzzvh3ODV+bY2YiVqgTP+Qisjalbgr3BneyIPaaOIfO/AJ0y?=
 =?us-ascii?Q?++izoBh8oUzn34IyCLFeIlPL5xB2JVuJ5e+BVmZ97Y84+2GjBBg0narEQJwK?=
 =?us-ascii?Q?bJldcw4xlBtWhgF741NbXMd1f8mN9P3u+swHL6yXCv8IXr+2fQo9i0alavil?=
 =?us-ascii?Q?mUfGT1iPEdG4LowEYyQZPepdpRyCxrB1XOGc8itNtBqp5kWPltv86tNbaFPl?=
 =?us-ascii?Q?qYjJZeMlF8MFLpGGAl8+wMeYodTNtEzwTjMepErVqcYkrih+xEO+hncOdAg1?=
 =?us-ascii?Q?PphA+YeACHBfe82t6a9BweyazbJpD8pIVGNZKUedpchTx22mV98IhfhJLdn9?=
 =?us-ascii?Q?Qm71p1irTNdL7PvRr0Oa2THbyz77RffZdkv8QaYftlI/V7nGkPudm6K4oPI7?=
 =?us-ascii?Q?muKhXxYhrym0a+UmNoAaY/JaurcVqfmofFUm1nQ7TJcl4mxmPiXxPsCF/RXP?=
 =?us-ascii?Q?25tG29oStEQatx4onp/mXhfg28WVyv/x50JnsfgfIVLWhmQ3I5Z1Z0sn1jk5?=
 =?us-ascii?Q?dAn/1RMuGO5xqoCcAKQ4t1ST/TnM0oKfz81LS1mDoMB4dTpszlZZakBVd/WE?=
 =?us-ascii?Q?VNMFJF8Cq/WZwKoqE9pDzocX6u6EDMbFyR/UNYp6rdYGH4Jm8NyJigSRzwm0?=
 =?us-ascii?Q?PHuiSBgjnogO9xIQSVjFpBkoP+LWPqlgzEtfOTgrJfGYj/E5vgZ/5A4l+brQ?=
 =?us-ascii?Q?CPlgQLH0UyKlkfx7An129l1Gjlt+I+2/sUsG8qvoCB/9eWpxX3rkDGbIomrf?=
 =?us-ascii?Q?K2/Sxd4Q4B45pJfKSjxS9dS42rLKHScU3KTD9K5OBA3ETfdm3vAABQ81/cV2?=
 =?us-ascii?Q?h0ySIc1bk/ueEIJm5jt2SzXKPPAMuDr0yyUJokgizcY2+5CN/fLA8oCNIKfO?=
 =?us-ascii?Q?9/JF3NcjUnNj9YYzU+2HqfNq8/I12Eyf/9Q4UIO+Rpo2ppOO3JAkFKPPOIpC?=
 =?us-ascii?Q?+SCYxZpw6+7OPuHgk2KXgbp1jeRW8gW+VGHbZGcoim5sP7ynfbvihp4BFwbf?=
 =?us-ascii?Q?LQuz+CG0ryGJawbk/5bnfgBnkbxaeZ7sLNExH58ZmMlCKFOI0+J3wfK+7bVp?=
 =?us-ascii?Q?6ZEcdCfgb8fj50kRfriTlUNwjzopF/fuc24EzqvLxA7sBHcJB5LClo0qdsQX?=
 =?us-ascii?Q?6Lq1ZbaY+qzjJR605G5tPrdYlpH8EaeDxes+WGFBcu5sAWjOTdzmnGCI5bVY?=
 =?us-ascii?Q?0EAKvTL0EoYwnKjIPncyFoQBhypVEUFfWzisrSMib9mrgmiZjqhdeUkCt3cj?=
 =?us-ascii?Q?Jn2MOhSMfv35PUUsmC2kF5n7y/Ed1OVxGToUUwOWGl5cfkLIyH4/h7N+8yxW?=
 =?us-ascii?Q?Jl8KODL6o01q7QqnPxaqzcQvGk4zVoJe68MUG9oLL+LNSQCnjrJAEMpx++hb?=
 =?us-ascii?Q?QHPpxNSYTv0B1vh13HbSrlfg/3tX0aXDEHvZzp+Ws4WRj/ny29PtzSPoRMAE?=
 =?us-ascii?Q?Slm4insutlk8kSBAx0Fg8k3moC42Q7lGnuUUmY9tNlbsUZqMrw6JQiT8dPt7?=
 =?us-ascii?Q?7C9EqGkN3HLdClQWPDnomU9gDhsLOQGrYT43kSnkVYKciudz3Xy+2PDrh1Vm?=
 =?us-ascii?Q?fkFd/XpCwP3MK6p8Do9uxiIvFuOL0hVbDEbyVFOiq95NEc2m?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB6683.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4269694-ee55-4c93-9997-08def98c95cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2026 22:45:33.6902 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 38nQFJ3KIdafSFJdVe0kzgWouM5yGSTBs2xNHMLP45oe0svgtFfhFmVa7kGa8ws5HG3GKeFPSA6jSl3vujzJxA==
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
> Change the rndis transaction id and buffer usage to use stdatomic functio=
ns.
>=20
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>

Reviewed-by: Long Li <longli@microsoft.com>


> ---
>  drivers/net/netvsc/hn_rndis.c | 28 +++++++++++++++++++---------
> drivers/net/netvsc/hn_rxtx.c  | 12 +++++++-----
>  drivers/net/netvsc/hn_var.h   |  6 +++---
>  3 files changed, 29 insertions(+), 17 deletions(-)
>=20
> diff --git a/drivers/net/netvsc/hn_rndis.c b/drivers/net/netvsc/hn_rndis.=
c
> index 7c54eebcef..4b1d3d5539 100644
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
> rte_memory_order_seq_cst);
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

