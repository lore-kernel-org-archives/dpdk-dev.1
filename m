Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C929C0219B
	for <dpdk-dev@archiver.kernel.org>; Mon, 10 Feb 2025 01:13:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DDBC5402B7;
	Mon, 10 Feb 2025 02:13:32 +0100 (CET)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2094.outbound.protection.outlook.com [40.107.93.94])
 by mails.dpdk.org (Postfix) with ESMTP id BAF7F4021F
 for <dev@dpdk.org>; Mon, 10 Feb 2025 02:13:30 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HmX1rov1JDmHxchChshQb0bHVzAN0Tfg5OGZHik5S7HWl8iv0ekyGReuXJkF8HgBvahdBOy9RBrKnxQDez3qm42YCJxKoSkbJEBGSCSVmjmyEP/YWYNC0I8+RFJZbappzGGZDw1/zzuhYdJuLFzFlr5WOXnA15oT8esF9vcutxSJSTNjS9xobeY9uCCN4vdqVon7sSd8uw+a863wQae6qI9KlGoRl0Jzjbk5cIwAs6ZP1VehvOw0SCDX6q2PmNItK7Qs/wAdG4qWl07nT/vATMRpuLrEn6395LS3fpyg0fAMOQn9BM0Ic2J6kJmQB/1O3L+qykYp5iun0kJSj0pxBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xUzmd91OtJxUgibBAvmIKi3w5QOI27A7ZvFZd3VDjpw=;
 b=mZrtt9RT6SAepTpn3lT0dHlNmTP072v2RJnLse18gEz1ojQOGxQrHm37p5qjo4kwrPabNaBb94mOf5GSCPT8y2oFv1u2z6LAvI0ZHr+SUE4XwVx+uiOi6FG50mCZVFiL952sE/2jQahXOHinsDnyNDIpxbuFM1b1+6+Erbxqu6bam98p+C112giJ6FA8vrHvjVj6oE5s2D0Ilqy7jB42dOgOeJUc2gQvuYu7NZ7ThfGqXPJLgBzuqvdnrnOyjKPCiBZQhpRaKKH8jrvWM26/E/qcbxzHueP69fy4IsLeWwLrJo31d550oQ6Ypik+E05o/RNn2sIuWjXBoNtAgnbFEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xUzmd91OtJxUgibBAvmIKi3w5QOI27A7ZvFZd3VDjpw=;
 b=qEfL8MrpyK8FUSppuNHfxTc+SZjHpC34x/HlRARnVii/5brWKVAJq5b8Cg15MUHSQlDSvRWiVcVR+tD8FInBb71F3Kmqrd7hvc6CB1wE+cFTdjTBCZGnX4CB0BV+RJ5t78f4hB1Fj/2DyJIFZbMSAwhjuSwe4klJYI3yDm9OOq0=
Received: from SJ0PR13MB5545.namprd13.prod.outlook.com (2603:10b6:a03:424::5)
 by SA1PR13MB5489.namprd13.prod.outlook.com (2603:10b6:806:230::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.15; Mon, 10 Feb
 2025 01:13:28 +0000
Received: from SJ0PR13MB5545.namprd13.prod.outlook.com
 ([fe80::b900:5f05:766f:833]) by SJ0PR13MB5545.namprd13.prod.outlook.com
 ([fe80::b900:5f05:766f:833%4]) with mapi id 15.20.8422.010; Mon, 10 Feb 2025
 01:13:28 +0000
From: Chaoyong He <chaoyong.he@corigine.com>
To: "dev@dpdk.org" <dev@dpdk.org>
CC: Stephen Hemminger <stephen@networkplumber.org>
Subject: RE: [PATCH 22/32] net/nfp: replace memcpy with assignment
Thread-Topic: [PATCH 22/32] net/nfp: replace memcpy with assignment
Thread-Index: AQHbemiPEkLmGWyl506CMCXd7laRP7M/vPqQ
Date: Mon, 10 Feb 2025 01:13:27 +0000
Message-ID: <SJ0PR13MB55450C92D7D07AEBE435DAE09EF22@SJ0PR13MB5545.namprd13.prod.outlook.com>
References: <20250208203142.242284-1-stephen@networkplumber.org>
 <20250208203142.242284-23-stephen@networkplumber.org>
In-Reply-To: <20250208203142.242284-23-stephen@networkplumber.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR13MB5545:EE_|SA1PR13MB5489:EE_
x-ms-office365-filtering-correlation-id: f8d979de-cf4c-4594-f2e0-08dd4970200e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?jczleCJUvqNG+u2tqHCL/nAKv2Re/I2fgD8H7NNfJcTi+P3qWbKEvLAb9s3Z?=
 =?us-ascii?Q?+Jd2AVb4RxKgobE3J8nGSR9/wZ9dgRdLW6Xw61Nai1PMJAWfYddzt0oTSFmE?=
 =?us-ascii?Q?UZhJ4RezpJOLZA+hoSESPAa6XF93LkorXvkp8XEXHjVPRERjCedrpSXAAd51?=
 =?us-ascii?Q?nrwkGSqP+w9gEL2+RsuzFf+F94IYmMQTPSr8cBvhLYa2pmFaZNOmj+zyC2Oz?=
 =?us-ascii?Q?7oUcFyUIzKt5EU8VGZJLf4EXwl3Xti2D1YqRYTFql4a0BJZ0CIhMeQFJdycg?=
 =?us-ascii?Q?r3bsSR8Ahtt9KAFYA0brrN4huz6CpjjeWPGTLtCit2n0oOdJvOC91rKjTjIg?=
 =?us-ascii?Q?BZ2gO49CTgNqzBbZIvoi9tnl/I8YGW7qxU2959YoTWvySpzCtfeDPr4LjMFb?=
 =?us-ascii?Q?nvaY7DlE8yS0tbV9D13LS116nxTNl7yhvDAoY+LFx31IF8o+BKEBpVPEQUm0?=
 =?us-ascii?Q?TgFVVSI+5sVXYrdqhgSYhJFSH6zhSsay0COimr3/MJm00O/PuAC4ilOTEznQ?=
 =?us-ascii?Q?ZM/Ba57LVEgOUypjQI6Ow0eFCdWrUu6m0eJhh7UmE2DRA0+TjFn5Ajq45LYc?=
 =?us-ascii?Q?jJ/mHRb5XHehCUKnLN9opCGbkcZFuW3ECQcd65dsOtO+NUt0hgeefxiTUvnd?=
 =?us-ascii?Q?xEeMnHJ8TwH+CbfylUN6X4r4duOJx5Ga5RzMKiud4iyI21WFIJAUOrEkqkou?=
 =?us-ascii?Q?hABBmVVMxH7YpOMUd7Ic3ZWqBLZk8fuAbr55RXaFCDNF+jCgFRqPyvTJFyGk?=
 =?us-ascii?Q?XiyveiHwb2Pckg2n2zDEwkAWd2ndU/Ez+gA1gye+NuS/FR1ymaSJLKnCyYlj?=
 =?us-ascii?Q?xSq3X+LgLhbwISY/EuUi4r6cEyZKVmOjAvgOWZ91JMjaJnLN0gZE3t/lbFNW?=
 =?us-ascii?Q?3UOJUH1cQQdioO/xxWz/UsRE2L69jaoRfWp4cw29+R0BXZieUb6XRmscesE6?=
 =?us-ascii?Q?OrJTFzpUdjjDWaGAi85Bmtoc+ORRbzkJpeVPLT8ncHVoOiTJ7SCH+DV+YX2Q?=
 =?us-ascii?Q?TZU/oYu99Np+Q6thTpHQ6qNaQSfbXq8jC4UVFD29UuZ626J6B+uu8TPWg+9h?=
 =?us-ascii?Q?BgbKifQ89Zuqk0B1meYpB8hE9Il1NZdKSPCsJyfgxPQ3iUnq5oCkWdUnKR9D?=
 =?us-ascii?Q?6T2Xfp7kyKqLwNyhiFVwC3GajLENc/IihjCvh5F2vBZb7RswzVcklgOJfSpR?=
 =?us-ascii?Q?XbDVbzGHjsLeW/UJrV3F+tTP7T4ZBxLGe3cBVgFHtdWCPeNCWtzouo90h9vj?=
 =?us-ascii?Q?TvzotO7p7ggvHxzkqIvGUrAyLlBAm0XFtQT6sBbdluM8U2Te9+ZE1ufvRe36?=
 =?us-ascii?Q?ObMPBm6QDvfcFY4sPUKurOfpIfZBlbaySb84u4X8ayWyoNpBTONEPzV0hgoR?=
 =?us-ascii?Q?KOABfkVWNjUPeGRe9aXf3Y/fbi1fGHx4Ep6ntuWjfn08sccjT9spbz0MhH2u?=
 =?us-ascii?Q?HVlGHSCktY7q5q2aaQO5DKl4ULq43AFq?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR13MB5545.namprd13.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018)(7053199007); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ZLdLGGg92j1daOs6xXJzPJ8cL4aLe+UZdCS5OEqcqLh8bi/Ec9Uy1HQv1Oo0?=
 =?us-ascii?Q?eRybgJcVIWScqiN/l9fLBwgiK15D6vPCXdfEEyxtEM7W3z0qPYNe1kG0U/aH?=
 =?us-ascii?Q?/eFJScIfcypn1gRWTR+bqR4C+C7nQ+ARwfJz8iJ9W8TmTDYAxpODK/gEbkNy?=
 =?us-ascii?Q?UPoGRU7wCha5ugV0b1fZPQH99CpUusthH6Wm8X3kt5KY9rbcuc1iv+SbS1sG?=
 =?us-ascii?Q?OgIPLy8LFcxoUI9KWtb29KA51yjpYRMKW/n7799uPDJ7LWTzy8jsJKfbDOZU?=
 =?us-ascii?Q?ifID3Zh4kjD6HhHnrvuKAkPVPkhcLlDpWPf8G1ydrldT1tq84SgpyEgULlFX?=
 =?us-ascii?Q?gsKhtlb0ot2NZHtqTpuk8st55/VkbRO3i45hRTqqRpIWbbdzsi74EKyYpbNY?=
 =?us-ascii?Q?o2ILq9Er4ERMqNA1yF0+1YcKtNPPY8Mw59k/UVXonO385CRxvdKuF/7FbdsZ?=
 =?us-ascii?Q?uKK1MdQ3lZzkL57vrU6gEBTWtd9R1eHLkFz43vfizSWEN23UfP1gp+efgLH9?=
 =?us-ascii?Q?8H37YOA7c+QI8hHt7iO5cw7WsMaOCs7n11/ImJlhHtZqpJEFk6ov/ZuDAt0X?=
 =?us-ascii?Q?AeEaEfpgPKF0xEvJqHclUAm1XBWRsT/OWqrWo/DurMaHXwfN31PB/VxNa0ap?=
 =?us-ascii?Q?uS7epwXSu/uXaU4DPX/4DC+Vr8//CsuoaRdI9jS1/7Ae3fMAvgyYS05JidFH?=
 =?us-ascii?Q?apotcG2iEhJAkgRqY/hZ+k4ZtRIP+04hQ8MMzYRdmhcaScKTHrDRpypURD+x?=
 =?us-ascii?Q?mVtMbrYOmRpu7JmYh1hzDnPVonsboGU88mlWb6mXb0txw1qZjnRzBmKnAIi7?=
 =?us-ascii?Q?7QHSt65zN1SdPv/XjCKs4Wcbrf3Kpkjx0GoPzpdpopivvaifNo5RMYAogQwv?=
 =?us-ascii?Q?ZtI/PZZRhku2aiF2S/YN+hnkXHW/sV1QY6TTfqtzXL6Cz02A0jPR4C7azkLB?=
 =?us-ascii?Q?MYVW+wkSBqU8eZHoTJiLTtgki6cJ3UBv9yN+9fnNTdFKm2dLBu7XQwlTpSnC?=
 =?us-ascii?Q?JTNWjqaT0QbjI+Ek7bajYCyl3V/DB/iNMo84mB+nImmCYs/02qKBQiZro0is?=
 =?us-ascii?Q?lJULXvU+WQFzHA+ltazRYT7qnixwTgut7Dbe3d2ZZz31CyJ37D9seKhmr+JM?=
 =?us-ascii?Q?8ALUt0KzJfWLgH0L5IVEwGlu1AugElYsd8B8k6ys+Dx9z8I3hM7PN4uxEKdF?=
 =?us-ascii?Q?Nhn2p3kpFJULL64dYtIqfLNXj/c0ZGjDLI4sQS+HFBIve9SmHTXOlZw5J1ds?=
 =?us-ascii?Q?8S7Ie3LksvMMhdhCrJjhV8oWZ1ADXI87Ql5sJP4nPPf/qnSRKNIpS8Vees6X?=
 =?us-ascii?Q?tFsBHqp3nV9W7wQhZQxYv/hHcGQvtW/wHKOq2LQBc6yLuSnK7jwMr5YeMiB+?=
 =?us-ascii?Q?g+kkfSj4l5GgIoYGknbioY7GtCthTdSw040Pxq28yZY2SqyB+6IMdq6+akPj?=
 =?us-ascii?Q?u949xBdFuv+0X9Sj67D9lrrvdoHr8n2xLd+J7DwegHr5FbMHwUx+WxItrZtB?=
 =?us-ascii?Q?LK6HWvKRgRjNRD5HBxwHGkyBbEvplYdYAh9MIsNrM3OLNDsGZ3/8dB7o4uz/?=
 =?us-ascii?Q?741cbzKOqnb+8/mOdsA0ffcfUMGPghQJC9LW3efS?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR13MB5545.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8d979de-cf4c-4594-f2e0-08dd4970200e
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2025 01:13:27.9077 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YjfuhizIsBC6Xb3JAsB3inVFRBpD35K2MXb1wYF2e6B8gHoatQUc4e9IrkjBOKZoKcM7zqWfiKC9P5BaBLWpnt1edaOtw5d0+UrbcziJqHQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR13MB5489
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

Thanks.

Acked-by: Chaoyong He <chaoyong.he@corigine.com>

> -----Original Message-----
> From: Stephen Hemminger <stephen@networkplumber.org>
> Sent: Sunday, February 9, 2025 4:22 AM
> To: dev@dpdk.org
> Cc: Stephen Hemminger <stephen@networkplumber.org>; Chaoyong He
> <chaoyong.he@corigine.com>
> Subject: [PATCH 22/32] net/nfp: replace memcpy with assignment
>=20
> Prefer structure assignment over memcpy.
> Found by cocci/struct_assign.cocci
>=20
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  drivers/net/nfp/flower/nfp_flower_representor.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/nfp/flower/nfp_flower_representor.c
> b/drivers/net/nfp/flower/nfp_flower_representor.c
> index 9601aa5f96..ae0f082eb9 100644
> --- a/drivers/net/nfp/flower/nfp_flower_representor.c
> +++ b/drivers/net/nfp/flower/nfp_flower_representor.c
> @@ -318,7 +318,7 @@ nfp_flower_repr_stats_get(struct rte_eth_dev
> *ethdev,
>  	struct nfp_flower_representor *repr;
>=20
>  	repr =3D ethdev->data->dev_private;
> -	rte_memcpy(stats, &repr->repr_stats, sizeof(struct rte_eth_stats));
> +	*stats =3D repr->repr_stats;
>=20
>  	return 0;
>  }
> --
> 2.47.2

