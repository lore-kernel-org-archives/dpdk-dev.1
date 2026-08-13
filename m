Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF63EC5CFDB
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Aug 2026 21:41:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B730040658;
	Thu, 13 Aug 2026 23:41:49 +0200 (CEST)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11022108.outbound.protection.outlook.com [52.101.48.108])
 by mails.dpdk.org (Postfix) with ESMTP id B18AD4026E
 for <dev@dpdk.org>; Thu, 13 Aug 2026 23:41:48 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MbU/YVApbnZeiiKWf6hqHkUya9sK8Q12RLQD+u/2WNm1YmtfLtz7A8jONEzuWtbFzPNGirKLzMAMcJYfgZMAKudbtHYg623DHBr46t7TTPwTLS7J1iyNPUprwjErkCQjHYzVf6usRkJrC4AkVdnaxf+BTFcicc5QLcCn4LE1HBhxMcFa8s1DIMNuIfkDAbUCuIO5juyAOy+Uxde7Tvm+5LJ09KabPpbImN4weq9RK0XSVYdM68N/7CDqsKcnajxmMDRb+/CwoJ574DJX9ACsj4j/UG7DaD/ED7pQvzW75QsNkNpiZGKf6RFT1tt4NlwO9Rppif04OUP9braYBV0HZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qyfNMpp7j91AbQdrqFLicImXMXKvMme9NWCPPSAqTXE=;
 b=ZHoam/6ZiEouUDK0WODyQAoBP1IxycTXzE3Y860dOXuv/Pi7C25T69gMlmLXFcK8HnhbVk3s95q269GDcCyDVUjEVaSnonQn3cPM1sNua3ISsTkbWNp0UmnoiBesIi3ROkE7Cva7PJ5jXVGvKsW70s+w7aU5f9Hs2OqTKGW0gSPZwFUm9NV7qcIxIDG7DR5yDF7v/vIxjT6iuIUFi4UjcRLFjvDuaE0QQim9Sg/V3Am4jOGFOhVCu3ORKJUOHkBVjHquDMv3w5ESzY23v+P4NhlIQAPA7iP+tiN5DNTl1WAHzTv32/aTf9bMatpovViTJenIw3cYfFbkLHNUH/Gghw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qyfNMpp7j91AbQdrqFLicImXMXKvMme9NWCPPSAqTXE=;
 b=a+6/miJtWSKMz8W8QE2/JgNc54fyOf6226zB5iMh4n0XJOdIx+PGMbOi1DXdu7g3tZPRl9qiupEyV6GSAI1uoNeEfOZ9p3evg5IrnUa82UnWL0Lmsocwy2ndQkMjaIhMKMKpucwyju+7Z+pGd8R8Cu90F7L+cXxYtE+zZXK4lFM=
Received: from SA1PR21MB6683.namprd21.prod.outlook.com (2603:10b6:806:4a4::6)
 by DS0PR21MB4659.namprd21.prod.outlook.com (2603:10b6:8:1ce::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.5; Thu, 13 Aug
 2026 21:41:45 +0000
Received: from SA1PR21MB6683.namprd21.prod.outlook.com
 ([fe80::8bad:6294:8a07:fe18]) by SA1PR21MB6683.namprd21.prod.outlook.com
 ([fe80::8bad:6294:8a07:fe18%6]) with mapi id 15.21.0315.008; Thu, 13 Aug 2026
 21:41:45 +0000
From: Long Li <longli@microsoft.com>
To: Stephen Hemminger <stephen@networkplumber.org>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: Wei Hu <weh@microsoft.com>
Subject: RE: [EXTERNAL] [RFC 05/32] bus/vmbus: replace SMP barriers with C11
 memory fences
Thread-Topic: [EXTERNAL] [RFC 05/32] bus/vmbus: replace SMP barriers with C11
 memory fences
Thread-Index: AQHdH4O3F/ZKEFV0YEOuTHX+ZTK9Uracmfcg
Date: Thu, 13 Aug 2026 21:41:45 +0000
Message-ID: <SA1PR21MB6683D2C66C69A918DC596C65CEDB2@SA1PR21MB6683.namprd21.prod.outlook.com>
References: <20260729175715.165120-1-stephen@networkplumber.org>
 <20260729175715.165120-6-stephen@networkplumber.org>
In-Reply-To: <20260729175715.165120-6-stephen@networkplumber.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=0e0aeb9f-7427-4763-949a-88b519dcaba7;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-08-13T21:41:28Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB6683:EE_|DS0PR21MB4659:EE_
x-ms-office365-filtering-correlation-id: 0c7fc6cd-a5b6-4bd4-db6f-08def983abec
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|11063799006|4143699003|38070700021|10067099003|56012099006|7146999003|22082099003|18002099003;
x-microsoft-antispam-message-info: 4X5Tl19Ev7pKqm3oLQBdvNssNjkHyax6l0M0b6YUML4MuXKng2g9H8Tr9Yd1Tdx9zOAzy9XrpoNhscdOXd98aYGX+opfjr89XughPutJ0L2KZvbnbk2NnuToyFT/8OG3mxp+SHGuXxf/CF8U/QgYjQMWqgKgC71Y/3WaOD2XNNdlJuhx4Z/zwXqh5NF1MyfuEqAGtiQ5LxdWVAXqdZ9yLoaq1O45Fj+6sohocg52x/qVZ//7ZdYMSCpmMQNFZu01iv48y56eaitWj0N0tfn9Lwi2J0oUVlTBYUCQxAyZrZmj8wcVCIyxyG6Jg1cSwcn59i/LwRciu7Q5sbGK1Ji+SUf2RQANWb8Q8IOlnaIoHhc9qiv4uMmV/YDV5jTLl6pjZtkKe6QDaPHO5cnUcpQDpaFhc6zKpqFKKqTcGmdS1hs2Ay3MktdapoiE7xspsnjv0VJgLKtqviv+/aykvg+chZUw8LaP/7SyMXeSeqaTA6EFnJ8U03VmFne6eiHYr2NzdSzKCZJPYgAhJrXGmSgBxlJTdAz1E/rCwXDGaCcFLitTkVgxFcCSeYb/k1mKzeukaKiTpc3vcWxaJDKVTDA+1WrjUpNEm68t7TSuXGCCbT5lLQvYzsfnJxw5A9GVKM9swfNe9kI2oUPrBABC5PTPVdNkUJXu760eIiTWHMwLfhRQeYz3P0xf/swfAvcy5sWu2h99SEG9h2seXDaVsd21j9jLAk/b0Av4AbCRnERbaSU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR21MB6683.namprd21.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(11063799006)(4143699003)(38070700021)(10067099003)(56012099006)(7146999003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?S0JCg1aTLFwDV6KPAonygOQrHGvee5PD+KEAENOQQkr0zFFrq5TiATyhJLPu?=
 =?us-ascii?Q?kyaHsMyG8aGGJUa6xtzbjVQgDkEeiUZdxDOfPNZi/sbT1IE5t54XUGLmTZmk?=
 =?us-ascii?Q?tx+5GPl1z+Bo5Eil7MxDJbvWtLCYzwjuV3IhmZ+AwGbwnBdAaNam1iGZI7pa?=
 =?us-ascii?Q?m5XlazAOD4iqGlBizRN/EUs6FPhK2xODhlPO5IEjuwrnHX+NXJZ9RZmmwn+U?=
 =?us-ascii?Q?qXhmPpCCQDT6TeLMOUkmEp5PuMauD3g1+T2/z2ni+qEMYH8mSaujGffU1qgT?=
 =?us-ascii?Q?+1wPW9NxfJ6eDxstO5VbGns0HR/4SyyG2UQtsf0rB8e+X6lMOKuvcz5dHHSJ?=
 =?us-ascii?Q?iCIABc8f2arXTc1FF+piaAYCHBsRKmNAOvHqG8z1wnqPECTDThK/xYfGpXPq?=
 =?us-ascii?Q?eL0GlKgzPxTKge2V5dmRb5PdLMQqMLCNY5oZvIi2mYc3NB1zjx+mzaJ6Zmle?=
 =?us-ascii?Q?nlz+XsCyz4n6eejoGr2p/WslcqR+pOrt1Si26BWqlxoJ4PdLCDkdqnXV7d3H?=
 =?us-ascii?Q?360XLb1XNDWeJbpe26b3sY32JUU7B1xG7YEl4+c8z1taatQ+Wsk6lgiKPS0q?=
 =?us-ascii?Q?PnY6EcXZqgq7pWzFruhlN7520p5yiHmQndqbweUsWltc9g7p6Vp3hpi7OFcG?=
 =?us-ascii?Q?2BVcDqA8v9YqdX1zLJaYNmJtIWzyS56DvVuWaX9wN3cqQaImoWdiY6thqqt4?=
 =?us-ascii?Q?tSru/41n/yEaEFd4dBkCbSyyKHhaSoaY40RT4Cnxg8Gaof1jqLGIVyI8Yuw/?=
 =?us-ascii?Q?F9tSYB898lftAv/eL7apkzIRjO9J3EaBP6BtkY3FRhAEpzDpneHaXo9/pQU9?=
 =?us-ascii?Q?E7uvlSh8FaLFgocYCCuGPkzAN9EIP5YTUE2DfTDA56xcF6/bPFkwO1S4vSVl?=
 =?us-ascii?Q?y3F+LP201kjwDXCZi9Gt6ypTraAUlpl4vmkDLhp8DIjbjfLSdysbFEwX+7aQ?=
 =?us-ascii?Q?87f7Bn/uQs9j/A7dAan24FZKXZZTQS+RxEefIBbJ6QcfuoRHptS5ZmJzlIvW?=
 =?us-ascii?Q?7xmPhg4RXjeluLuvt/PPPAeOq/XGH9U8r0labGuGK3EMfPlgm9uq8rVgShUH?=
 =?us-ascii?Q?aidWvxmeTfJXO72TnLHeBPHHfXdoHjQpuHQ5otP9TeMPQ2v8qZJZ95uynDwe?=
 =?us-ascii?Q?LMir6RAe3xwakThnit4f9N15XCGcFrGQC6clXCEnQxEEhbM3inBLMkkmtkop?=
 =?us-ascii?Q?GfWtIxbQfe7tl7AJgUPPk3/z2wzcD2oZi3Snh0vWEpjYehUlkzHrYJyLPVKR?=
 =?us-ascii?Q?7uwWf3Jo5bOETYYDuOPPJoVys1XES/US8lSUMIerKRBNX5HzVP/5jn8QXbOE?=
 =?us-ascii?Q?gfRT7fkwpbgcmBtLvkOArt19vDixpGz1R2B4lZbUSYBt7NQjNDVgRPF+B+qf?=
 =?us-ascii?Q?4lmqnlrO2u/DM0vlYWu3u1p4EpRF3C4azRV1B9M5rF+xBT+rMIwJOTU7LPEp?=
 =?us-ascii?Q?mNmEpo6RheTBbGBhQKC050wL2k2OTTiAB+/cC0t3sT1VLRUvHkCsDGE6FsIg?=
 =?us-ascii?Q?anSkZOCMvTHMG5JTrgwpHFyhyY3mpu5LIWeafZgJM7X9shYya943ZDkmTA9y?=
 =?us-ascii?Q?GQlpbiYjM3VzpEUgFG7wHHPRN2cztFw8bKgSD1beQhKmkG0LOngcAP6iWIuu?=
 =?us-ascii?Q?BABJXBeeaMSEP5zuNWVVh/hspeYF8CkFsZKJShR5FTbix0s3imx773IWdqEE?=
 =?us-ascii?Q?CFiWN9XKgdkU2tSL18m5kBKiuiGaYVjOLekXVAovh6LVgJEd?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB6683.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c7fc6cd-a5b6-4bd4-db6f-08def983abec
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2026 21:41:45.2492 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jRDBnkSUEI5cyFxlBwrkUWf4VjwZz1jBxG8grkPMOE+DKCFcenrEijZ8yzkX0V8BPTtcU0a0aqdwH6RJkkJpMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR21MB4659
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
> Full barriers order the preceding index store against the following load =
of the
> interrupt mask or pending size and stay seq_cst; read barriers become
> acquire fences. Same code generated on x86 and arm64.
>=20
> The write barrier before publishing the transmit index becomes a release
> fence. Nominally stronger on arm64, but it is immediately followed by a f=
ull
> barrier cmpset; converting that to a release compare-exchange is left for=
 the
> rte_atomic32 removal series.
>=20
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>

Reviewed-by: Long Li <longli@microsoft.com>



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
> @@ -58,11 +58,11 @@ void vmbus_br_setup(struct vmbus_br *br, void *buf,
> unsigned int blen)  static inline bool  vmbus_txbr_need_signal(const stru=
ct
> vmbus_bufring *vbr, uint32_t old_windex)  {
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

