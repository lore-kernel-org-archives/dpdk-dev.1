Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54714C982DE
	for <dpdk-dev@archiver.kernel.org>; Mon, 21 Sep 2026 08:40:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5A3AB40E31;
	Mon, 21 Sep 2026 10:40:40 +0200 (CEST)
Received: from SEYPR02CU001.outbound.protection.outlook.com
 (mail-koreacentralazon11023084.outbound.protection.outlook.com
 [40.107.44.84]) by mails.dpdk.org (Postfix) with ESMTP id 52414427B1
 for <dev@dpdk.org>; Mon, 21 Sep 2026 10:40:38 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q5mdT4f3GdMOmrBfAeUKUfj186pMNV2MKJQCkiddEQYDiTu/g10Uep0yufzvNe19bBVIvIWshdM/1r3CZ3AhGqgZYZ3xCskTfhnf/gE43lluxzdszzOdB+GeG5T5CPZ2DSyfOqkkiJDQnxL/m+LFiqhMF5sPJcCyPZjzrF9K1xnpiuxU1XZlp/qyeyQWPbeNzGoCqLl4BOFir2mcuthOQNUxSJkbpHDqwqoxfhCBJINOdBrX2Hmvec7ulb7HNoAPNI2YsxFyif6gsX9P7pkFdVVh5yWod5sD5gy2RolV17Eubb9V8CswpkhVr3MkWKGD+qAlxISEM+14gKyqANey8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:MIME-Version; 
 bh=K6dmQw/BcMrhTCtMQdwiDJytO1eF9mvdOwXA1pOl1H4=;
 b=H1BhgE6Hi+KS3tvgYXiD3KidAy7wCck/HeiJTKE/ITR38whNNnih9bYNYzY1BjzaE4ij7okLvQjJPSuRPm82jMo1tzyrd+5fg1SyUUfL2pdMqh2FIBBXleYakbpRISz4Ot5GIaocBf7GMhixL+pcw9ouTmMrB69KW3CwuLScslCYffAWd28TtN1RGvMf9/Y0qlZc/sWeWz945gTdKFJXE4oCSvGB/qk/HfcsM3gvVASHsCCOWkv4wTd5H26tLtJ96crrIt7VAnTf9v8imDlmQvF8WnNOMahh97uT9rDJ6w4ze+OyMjBjkiAH6aQ4QLxA5T0T6oDSoE6J9BExF9anpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K6dmQw/BcMrhTCtMQdwiDJytO1eF9mvdOwXA1pOl1H4=;
 b=ZDdyaa6VxZ5GW8o9r8i4LLX8vRIUDBQb+YR/bLuRepOw9Qse0AOhyMTqwfYqma1Psa3FAAcUYh678gRs+SS1qbRgllGJaeIn4gSFkllrp7WiTKG32CC4s5LXQvatqe1DLyDJANLYd398Rtf6DObtlcMOg9T/nULeefWPWHFrZ/w=
Received: from SE3P153MB1848.APCP153.PROD.OUTLOOK.COM (2603:1096:101:340::5)
 by SI3P153MB2029.APCP153.PROD.OUTLOOK.COM (2603:1096:4:29d::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.2; Mon, 21 Sep 2026 08:40:34 +0000
Received: from SE3P153MB1848.APCP153.PROD.OUTLOOK.COM
 ([fe80::8f4e:575a:4706:a56e]) by SE3P153MB1848.APCP153.PROD.OUTLOOK.COM
 ([fe80::8f4e:575a:4706:a56e%6]) with mapi id 15.21.0472.000; Mon, 21 Sep 2026
 08:40:34 +0000
From: Wei Hu <weh@microsoft.com>
To: Stephen Hemminger <stephen@networkplumber.org>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: Long Li <longli@microsoft.com>
Subject: RE: [EXTERNAL] [PATCH v2 05/33] bus/vmbus: replace SMP barriers with
 C11 memory fences
Thread-Topic: [EXTERNAL] [PATCH v2 05/33] bus/vmbus: replace SMP barriers with
 C11 memory fences
Thread-Index: AQHdSSvTc1k6QLrwtUCoSwqP0r0oM7bYt1Nw
Date: Mon, 21 Sep 2026 08:40:34 +0000
Message-ID: <SE3P153MB1848E07FEAE19ABC281902C0BB842@SE3P153MB1848.APCP153.PROD.OUTLOOK.COM>
References: <20260729175715.165120-1-stephen@networkplumber.org>
 <20260920181347.747210-1-stephen@networkplumber.org>
 <20260920181347.747210-6-stephen@networkplumber.org>
In-Reply-To: <20260920181347.747210-6-stephen@networkplumber.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=735837aa-f7d6-4842-981b-3597a8a217c7;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-09-21T08:40:19Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10, 3, 0, 1;
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SE3P153MB1848:EE_|SI3P153MB2029:EE_
x-ms-office365-filtering-correlation-id: a530f765-fec9-4666-2810-08df17bc00c3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|42112799006|1800799024|23010399003|376014|366016|38070700021|4143699003|56012099006|11063799006|18002099003|22082099003|10067099003|7146999003;
x-microsoft-antispam-message-info: leh8gq1sTfSx0ZuLC2InH1g+20CXJEL0xNzOyPAeqmj2IGkUj2CK9kNSlim3HD2MdmY9cZ2+UhAjnt3Ioal1rgYt6j6c7PpE3f2nwby9o9etbaNMvAD8mKAq0p9AzwbFqAU6DfmzQ5lEaJ0fGHv7ZPJJmmpn/ycduUXZsrNdHQ39rqbqAewNbQJ+uhWfpnZIaWcMG71fnltmZYd91SCwGxo5/iBbRGN6juVmV+nYsne1elRqqJXFKhPk6KyaM7qZergyDbc99PHoZeT1MeKL8RWXZihrTqJViDJ96rYs1c2GTxU0cURX5FB7K9uFfTNXuat+vVz63z2VXG5Imf4r51J2d1TI9+XV4TBPzhvr8znxLNjNUifm9Rg56RFiTsU/x8BWZIlJ2Auvizf/dR4OKRpwY2G8hqOBPTgd9Q6NBxfqfiyEv2AGIHLetXHaTbR5fvYXp/nyaKNopWoO47/66Hoq5cuMsSnkwCNp0MeAQbXVQuU+YodpBGeYmgsVNO04IM+nKEf2sgV6Bzxc+mJXX6kTaj9CJfnW3qReaFlZ+tNxzSImKoCnDQnZGkMDISo3TqGHPL6xHhjY/eTmOKBCizcN3Q8Icr+6tHTQxuHLzUFOsTsObwR8BS8VSm4H8oOlwOUgVIWhKqzaCCwM4559u93tf2U2FL1gfiBx3wANOn6P9wU/T9R2lP9toEJ0ubUKCMnAsDh55Y5o0pxs2RrjrHuDR2havwmp3okpAgL6hxE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SE3P153MB1848.APCP153.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(42112799006)(1800799024)(23010399003)(376014)(366016)(38070700021)(4143699003)(56012099006)(11063799006)(18002099003)(22082099003)(10067099003)(7146999003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?uv9wDKxeGHJsfyYS+7o2+772j38FWrnvW7ZqEZXkL4iTfnJZlgpthQVMhZe9?=
 =?us-ascii?Q?8CEKeoCSBJH3BLsBGjTJwoPLDEafC0YC9zsfxjUWeuNboGTPsSFj+EGPsmIj?=
 =?us-ascii?Q?MPIH/zS7a2yVLOCIIoiv4ViT1qChKdrLEnvDpnlPZZWOgj718+ocFGVzQDIy?=
 =?us-ascii?Q?8cAOHAcwS4zzCFIzslRIfSpCP2kQe9wpIfokMTS0EFA3Jy+D0Ff+IN9AHs0I?=
 =?us-ascii?Q?m6OVR11QuecxlfX/bWC6UCg25oVormRnPy0/KsK//uwS7gO3ZnCk9VNC3cuA?=
 =?us-ascii?Q?NiBwXmQOn/Ei7bZlEq6C19N+6SMhZtyMkvz9WzUayMVSOqJJaKElFXL554nn?=
 =?us-ascii?Q?fNfQMXmHVNClYCr8nb3pdCUL5gE+zQNfC0JEbyp1NtoF8ixntLUVrS53Qfby?=
 =?us-ascii?Q?UsdwrpxjPpAALnus+ahGKJjsZ1HHtS4uo6WCklobhnuhR/XSX6n7ACC86yzh?=
 =?us-ascii?Q?T5/3iwTtwjaflPkBOBrCGX3zF+RWe+MEP/4uNwfrs+ERBMeKF3mhE4H4WfAA?=
 =?us-ascii?Q?fdPxaWq3OxRUgjKJ4shZQhVTDh6m5ufWyze8vogq0ok/HwgzaEtEFYQJl+80?=
 =?us-ascii?Q?5KuYM+qJ73yrt6+IY3A5ukyXuzihnU4yEO6ADku/QxRItSm3r/+nlftQlV4k?=
 =?us-ascii?Q?TdiPRNZQ03ds2a09IrIVebwOhdnnBIS/ImByWkRDIRsRhsvdnAM9xLjryl+e?=
 =?us-ascii?Q?WEyAH9aCdOtMDuIGk9a+lnc70X1pbY9koPlPEenNaxaTdOr/MGazDy7QyM3X?=
 =?us-ascii?Q?GIKKBjhcjEJwKHfysD8XN75uADMeawImiwR19tYViVkTsBSa0pVUIHYtCS9p?=
 =?us-ascii?Q?KA6uOuoKmmgxrw1SUN8RlakAkVG5Wkx61PtyPN5PdaVSoQaOTLuDUSMfF3iu?=
 =?us-ascii?Q?dMvhh/6ZLewPR8p0AqHZO0m8VVI++yDtvZEokBEy3IOR/enqkJ+nSFRtpbVW?=
 =?us-ascii?Q?wc/OBSQlGwuQlrpDfNT8cKgvzAxCwvhyLdk+5RFUMurtyBapbAcjkUOBBTim?=
 =?us-ascii?Q?IpQ6x2p5nGtUhbP19KHal9FRdgUU1Z/PTmFUy9s5xg0kKZ3MtCAcg2ZQtUwb?=
 =?us-ascii?Q?mwpw1X9z3689TLHuMI34upFaewBVbDd9LgvSlsyNKrlwz07ZugPazGdBd4Qb?=
 =?us-ascii?Q?uIocRR/vXMflOA1Ak6Of6s7O2FRbdBGmU2gjqnWilnoY4tYsYrust2/YXdiC?=
 =?us-ascii?Q?pbQQkl84zX6JENEPd4LAXOnwARH2Rcs4+J6mv9Dhgl+FjmpZJdGOqUkjzIoL?=
 =?us-ascii?Q?vxkqfNSOgEMJluy3KhpPo1ZfjJqRfNESMdgryEMe3O+LWPQm4OeEC/IBGPkS?=
 =?us-ascii?Q?/I0kQ6ttfmzMgGNe9lEXLOn5GJ76Ts79qrmBxNsQL2k3wTUBgCGupfSHCTB/?=
 =?us-ascii?Q?TS2DGSbbmUPJRknzf005AAtHMa6RCvfl4wPmbe2QNcw0JL5p8xmFqD8A1qNF?=
 =?us-ascii?Q?U2nVqe5tTnFgO5Y5F9DC61caH7b5hcfs7IyjcXKik0gDeJ4rjrTAv4Ujo89m?=
 =?us-ascii?Q?eHF0o28Xzs6HcapUwHXw72oEoVDe70Dz1JCgnmkFDglDmG9XYNkHDRWNKed0?=
 =?us-ascii?Q?wl7ifjETCLsHkLKjsEV29lvyITh8TPcqpplQeoiHXdWJq8uVgyRwD+3uxmK/?=
 =?us-ascii?Q?DmCTj7NiZK5AMb88jxCcjiCBpbo+VBwxT3ogzR5m2Omny8MxDkfRCwp8r0aw?=
 =?us-ascii?Q?5Hcbz91uEVukGv9Z+CqtXRPjbL9KqOgVyK08YHZYJ/niZZq4?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SE3P153MB1848.APCP153.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: a530f765-fec9-4666-2810-08df17bc00c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2026 08:40:34.3812 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5Q1PbA5RSbLPrftQ729zBlMPv4vMkebmZU/XEEk8RMbq00PrTuW3XOtetoOJgkZajJMuUyylRunaVXyL1dWGfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI3P153MB2029
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
> Sent: Monday, September 21, 2026 2:10 AM
> To: dev@dpdk.org
> Cc: Stephen Hemminger <stephen@networkplumber.org>; Long Li
> <longli@microsoft.com>; Wei Hu <weh@microsoft.com>
> Subject: [EXTERNAL] [PATCH v2 05/33] bus/vmbus: replace SMP barriers with
> C11 memory fences
>=20
> Full barriers order the preceding index store against the following load =
of the
> interrupt mask or pending size and stay seq_cst; read barriers become acq=
uire
> fences. Same code generated on x86 and arm64.
>=20
> The write barrier before publishing the transmit index becomes a release =
fence.
> Nominally stronger on arm64, but it is immediately followed by a full bar=
rier
> cmpset; converting that to a release compare-exchange is left for the
> rte_atomic32 removal series.
>=20
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> Reviewed-by: Long Li <longli@microsoft.com>

Reviewed-by: Wei Hu <weh@microsoft.com>


> ---
>  drivers/bus/vmbus/vmbus_bufring.c | 6 +++---
> drivers/bus/vmbus/vmbus_channel.c | 6 +++---
>  2 files changed, 6 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/bus/vmbus/vmbus_bufring.c
> b/drivers/bus/vmbus/vmbus_bufring.c
> index f622869974..31478d3bfa 100644
> --- a/drivers/bus/vmbus/vmbus_bufring.c
> +++ b/drivers/bus/vmbus/vmbus_bufring.c
> @@ -58,11 +58,11 @@ void vmbus_br_setup(struct vmbus_br *br, void
> *buf, unsigned int blen)  static inline bool  vmbus_txbr_need_signal(cons=
t
> struct vmbus_bufring *vbr, uint32_t old_windex)  {
> -	rte_smp_mb();
> +	rte_atomic_thread_fence(rte_memory_order_seq_cst);
>  	if (vbr->imask)
>  		return false;
>=20
> -	rte_smp_rmb();
> +	rte_atomic_thread_fence(rte_memory_order_acquire);
>=20
>  	/*
>  	 * This is the only case we need to signal when the @@ -158,7 +158,7
> @@ vmbus_txbr_write(struct vmbus_br *tbr, const struct iovec iov[], int
> iovlen,
>  	RTE_ASSERT(windex =3D=3D next_windex);
>=20
>  	/* Ensure that data is available before updating host index */
> -	rte_smp_wmb();
> +	rte_atomic_thread_fence(rte_memory_order_release);
>=20
>  	/* Checkin for our reservation. wait for our turn to update host */
>  	while (!rte_atomic32_cmpset(&vbr->windex, old_windex,
> next_windex)) diff --git a/drivers/bus/vmbus/vmbus_channel.c
> b/drivers/bus/vmbus/vmbus_channel.c
> index 2648d8e3fd..10293f59be 100644
> --- a/drivers/bus/vmbus/vmbus_channel.c
> +++ b/drivers/bus/vmbus/vmbus_channel.c
> @@ -211,7 +211,7 @@ bool rte_vmbus_chan_rx_empty(const struct
> vmbus_channel *channel)  {
>  	const struct vmbus_br *br =3D &channel->rxbr;
>=20
> -	rte_smp_rmb();
> +	rte_atomic_thread_fence(rte_memory_order_acquire);
>  	return br->vbr->rindex =3D=3D br->vbr->windex;  }
>=20
> @@ -229,13 +229,13 @@ void rte_vmbus_chan_signal_read(struct
> rte_vmbus_device *dev,
>  		return;
>=20
>  	/* Make sure reading of pending happens after new read index */
> -	rte_smp_mb();
> +	rte_atomic_thread_fence(rte_memory_order_seq_cst);
>=20
>  	pending_sz =3D rbr->vbr->pending_send;
>  	if (!pending_sz)
>  		return;
>=20
> -	rte_smp_rmb();
> +	rte_atomic_thread_fence(rte_memory_order_acquire);
>  	write_sz =3D vmbus_br_availwrite(rbr, rbr->vbr->windex);
>=20
>  	/* If there was space before then host was not blocked */
> --
> 2.53.0

