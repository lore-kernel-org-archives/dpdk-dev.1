Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C678CDB475
	for <dpdk-dev@archiver.kernel.org>; Mon, 22 Jun 2026 20:43:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E6E9C402D7;
	Mon, 22 Jun 2026 22:43:34 +0200 (CEST)
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11021113.outbound.protection.outlook.com [52.101.57.113])
 by mails.dpdk.org (Postfix) with ESMTP id DA6C140269
 for <dev@dpdk.org>; Mon, 22 Jun 2026 22:43:32 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TR4tFsbfPo+0rBYvrJHGxBe8FVMsiCE6a/kwS7CiDD7L76C7PnvXJdAzp96FvMxcMxrfwiBQqfCq4UPVmMYsLwiBvtfqgw6017OTDb/N4OY1clTI9ndVhnUE/fuJy0KjRMnSMfKCfw82Uhn6sDDCvRyTCzE9XRNHbm33f87Tb5IDi4+BaTJdEfpkiop9mPKFjYZAQ9p5hiyJUUnpu/Va713bykCfnHR6SLs7BNAkvDp0FU888h+FC0OdqDurkmLvggW+jkxmWZMm40SgN24yy6aY7pPCoapvP6o2FmqpdB+KKQgb73RS8fCyfsa4u3fPCiIQ0VIsYYh+zz42VOk+Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AixfekP7kUJsK4K8jd92bfpc8NhyjaTus3LCJl2kfto=;
 b=sSvOkTRU9srYmB3NMaSKO7i0ZG44d7cTaKivslSMU+c5IsSNgKg1jYLI5m2egKyNYZ5iaJPZpCzO0VOpYJ2ewV9B/9ZqnlRl8ZRaszp/AC6COHW1aVQNGDBDssZ9efuPthQuT07AZEZ1JAwxAYyuWK+fA6TOVbX7bZJevLGU50hPAG8xRzyuSwERZkrvvKpZIkpFkmpv1OW7uBmp1KeYzbBTbCCHcitEDxtyFipYcYJavwKvlup4+ehowwKW1NI4uQG7MwmnmndmlA/Y0gWncDLZrJRZP2qkNSrK4mXkmnkCCox3e8J/tNHJuBwBc46r0KbYb2iGxhi1njUNegAVHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AixfekP7kUJsK4K8jd92bfpc8NhyjaTus3LCJl2kfto=;
 b=Qech+Nv2vSK2HYt9uja04Fitos0fTH3j45dmc7O6VD3qgJfOoX2O41oCqhdKRbghNYbSKIqle6lLvjuLG+91jCeWP1H/ycnMgpB5k6IYXcVdng3nt36f825nzB0q0g3b9W6DhCiDSHYRRjX2hqTwNqF8vpttiUIEXFRyJSOHeJE=
Received: from SA1PR21MB6683.namprd21.prod.outlook.com (2603:10b6:806:4a4::6)
 by SA3PR21MB5679.namprd21.prod.outlook.com (2603:10b6:806:49a::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.7; Mon, 22 Jun
 2026 20:43:29 +0000
Received: from SA1PR21MB6683.namprd21.prod.outlook.com
 ([fe80::8bad:6294:8a07:fe18]) by SA1PR21MB6683.namprd21.prod.outlook.com
 ([fe80::8bad:6294:8a07:fe18%3]) with mapi id 15.21.0159.007; Mon, 22 Jun 2026
 20:43:29 +0000
From: Long Li <longli@microsoft.com>
To: Stephen Hemminger <stephen@networkplumber.org>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: Wei Hu <weh@microsoft.com>
Subject: RE: [EXTERNAL] [PATCH v5 12/24] net/netvsc: replace rte_atomic32 with
 stdatomic
Thread-Topic: [EXTERNAL] [PATCH v5 12/24] net/netvsc: replace rte_atomic32
 with stdatomic
Thread-Index: AQHdAFz4A5dp0POGzk+H3Ka4TPg7a7ZLDsKQ
Date: Mon, 22 Jun 2026 20:43:29 +0000
Message-ID: <SA1PR21MB6683471269E300584EA88AA6CEEF2@SA1PR21MB6683.namprd21.prod.outlook.com>
References: <https://inbox.dpdk.org/dev/20260521042043.1590536-1-stephen@networkplumber.org>
 <20260620023134.42877-1-stephen@networkplumber.org>
 <20260620023134.42877-13-stephen@networkplumber.org>
In-Reply-To: <20260620023134.42877-13-stephen@networkplumber.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=a6735db5-ab28-4c69-864b-8b154ef04b69;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-06-22T20:43:12Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB6683:EE_|SA3PR21MB5679:EE_
x-ms-office365-filtering-correlation-id: b524f91c-b742-405f-5b15-08ded09eeaec
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|38070700021|6133799003|18002099003|22082099003|4143699003|56012099006|11063799006;
x-microsoft-antispam-message-info: w3ZfVzK5l84XBok9CEMQL90JyTu2qRTcD5qxJUNgcMWsL3+oqdTOpES38XeegeXjOjQhx5IarB/KRCLLxZjP/wAj9j+2uiJTb8xCxuRpKsYbg7SjzFNTcYijXTPW2mRGoVj7MEvVaMGeziu2irBAdkzaq//RXcSWz5AxBiEiQPl2qZQ1Ow7i2Hb7LaKoSHGMqzDzyEw6D6tvMiDexR4PkhONSvo881IHx+6elsSXnoeyGqf5TfpD199oE83mnIAF68Zn3+NE7imiZKSqTH5IGvmr/UyVX9PKUwKIGIpjpThre/lnCV+mqKZTcRoZfNEt0iFExvh99LwLyQ6UJejs/8Oxy2kygafrqpo+5lEZM+VAd9przCi+ESevFgWSf4462rZqFe98CV1VLHKuhFfEFg6wlUYCwjQPfJDAd2t4fbkR/YIjSxNVYvfACKPVIpAs4q3RZEi2iSo8EwCEJMda6bXU/yHKJ23En4Y9bdYrgWuhLKFx6E7DdT1jaKAfHURpcLgCsSMptl+9ndGP7fhGLTqkk8j9WrrimnBP6WhaZiyrTZR+OPa5SdnqC8d/UiC6Hz8mY78fUgRRLf/pvwNBLJrmvedSrfUOzevhoR145Uj2Mi/WSZmj+mmjHPmtEv0Nh4veA12O6+S9iUYcFHTXmtChAxc2iOKTBAEySZgkxv9Xpox6eJUfMDQfjL8jzmZncYpwj814aicOcViHhbIpRBczrNtKKPxNhYRh5k3UWqY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR21MB6683.namprd21.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(38070700021)(6133799003)(18002099003)(22082099003)(4143699003)(56012099006)(11063799006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?K7KiaFjUD1ou1Q4gd0bFW9v4sx1tu9QGoPOUuiAAb6DchUibRitzaUqojvBz?=
 =?us-ascii?Q?q4JtKKRGlbSePh8bhzZCr2qWiMUgjsOPqZxpi0SJWXLSJhMVhu3Nfeyp+6wz?=
 =?us-ascii?Q?1PGYPic2fCXOFh1iSw353NVGcPoDSwQp0VPfL5i9ELg21cxYEkWzCln4fG9S?=
 =?us-ascii?Q?iv9Y0iS+TV4TOIRj5iQMTLlj3bhs4pJScOvIqu4Y6zXqScqP0p+zP2weDWVD?=
 =?us-ascii?Q?xFZUACGnq7tmqly7cS8VYdXf3TCFuz0uTBknrWQ2oIiiAhx3xxF4IPv/pT2e?=
 =?us-ascii?Q?djermkq6RBGvsLCVPCuVj7YeYVGgEOmuPMzdezqkLrUaiMUI6Kl9JSDGQ9w6?=
 =?us-ascii?Q?eEk2ek030AXMuyoRDW3EE4tVgjHO5JWHX2QkzJBkMjrRL6F8yaAXOz4SqogL?=
 =?us-ascii?Q?9iCmJZbGPSsw2O2CaFHYfofc2ynTXn0VZ9fIlQmZmIa7i+CgZN34IRJSPgi4?=
 =?us-ascii?Q?9b2QMt2XyedGsedIgPd5TA3U8Y65tqTgT8u5hBWHPlUXJFbUlVDeybNdHhHi?=
 =?us-ascii?Q?0z5hf32DI8V7oOWx/OQ/lmpKmGLIU8SPvWaOF6q2eSCwsijOoB9WvAzhgQJq?=
 =?us-ascii?Q?Ef+W0q+rLx/tcaIVBWSbxkwMnEKPl5FNGFfJvn/FG6DXmHi2jDrqWcBh4QSP?=
 =?us-ascii?Q?7D0Nr+kgZQ8sc5yyqXpFu8s20oWOuOMNdZUlkZphGhbQrLbik/W1a/w/yuNZ?=
 =?us-ascii?Q?p/SlTJFf+jHdokzXjdZiu2e0dvRG4uIyqHoyLvBtmq9ymSeB4FpZx/YsX7xi?=
 =?us-ascii?Q?hl+UYklWxglsiNIpkwA76uVzxHtT4WoXJCHwyGydxxXrvPh8L5T+95xXzRSh?=
 =?us-ascii?Q?JjzSJFq2+QhkMnb9U/fLjdyiWKRMLybnLYLYeahyxsSeBbyY4PCD2xguDoVx?=
 =?us-ascii?Q?1TQjLUoOBWcNv7QATE3rVGcHs37NuNcvWfzHSLWbj1OUetpIKu4KCWit+0RS?=
 =?us-ascii?Q?xSn6/GFBSbasJnHd2Buujk9hqMMe7zbE3ymCA15CoVGrxjfNw6OQKgCpzCwC?=
 =?us-ascii?Q?j/Xspjau4FXSty/qvCoGbuRnAwZ6iohfva6+sEog2WOH82UY7yl1L84LRpoH?=
 =?us-ascii?Q?KGL0y+odd54ThxkI+TWIKWPoJWRibvlRlJRh6JpHMA8Ltt0yW5Ddrx9nQxKD?=
 =?us-ascii?Q?JU4/PF7D5I88Tt20Hy7vbCSoTTwdf4TXL+9a53KFHxEVtognbfAA1aPHFNAE?=
 =?us-ascii?Q?k1bTg3vwL8GOE9xKBU2Vi39P0loz3VevJtGivHGrFWeejEQJh3GHTfp2aZEG?=
 =?us-ascii?Q?16uLXHTzyxAmtBvcWOE5kmbnfmt3obJUjhDs+dFURml22uhtzpmAXZVSUVti?=
 =?us-ascii?Q?/xBrUl91q1cjy7ER1lbgDlI0tL4uFV344evKAqfbVubbbN0gswDZ0x7UCWsd?=
 =?us-ascii?Q?5n+96UXo290atMHx7wP3Gb0sYZkRbAevwlkktKxmXSQabcJYYP9swoV387t2?=
 =?us-ascii?Q?gNu76ChdxmRwjcyt1ji6irD80lslU8pmdWQwFeieACHw89+bosiczE4fYRd1?=
 =?us-ascii?Q?a+RjC09DdZJ3QIjonN7WarPJr0ynoi+/mq8GtJ9fE6J6czMBqJmTlT82F61Q?=
 =?us-ascii?Q?vb0d30UDoD/H8gZ2inCtVk0HWZniQmLFblLkzyU3JLkPTOrNWJLNQCL0xpVE?=
 =?us-ascii?Q?3iQ435oqJnqkE/8J8ESZx9TrbdAgZmZJZG9cBYlJdAPg9C/iP5SZ64MjCkTF?=
 =?us-ascii?Q?RTfjr1IMopEKB1qLD+abfTZXKbZ+qcTYvHJYxxIB2AL3scoM?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB6683.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b524f91c-b742-405f-5b15-08ded09eeaec
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2026 20:43:29.7426 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CIm5ufMeZ7IbnB9iEMG+7DG9ihoPNycaByeXKQ/dBnLJ5kN1axoN2kHT/OLrQKT3wM/n7pU7oMs0K8n9UAVg9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR21MB5679
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

