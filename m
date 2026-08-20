Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 516BDC5B572
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Aug 2026 01:41:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F108440663;
	Thu, 20 Aug 2026 03:41:45 +0200 (CEST)
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11021112.outbound.protection.outlook.com [52.101.57.112])
 by mails.dpdk.org (Postfix) with ESMTP id EF9534014F;
 Thu, 20 Aug 2026 03:41:44 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G3hAVd6bT7q805j18URW+i4fAlTq8tr9LYrEurfa+AWFx9fmx6ghCg4quEwgY/b0pJvZnlDMq82KXM2Qh7/gRvM2yCxl2nTJVCi/SqOVzbAsc8bVXdac60TQPoLIg/tD0Ca3nkF9Xj1cjKLuzb9feKh6sLp6Q6MUG/4wrqnunRLQ05bd08seUMlMdEOOPfPsR5IoiEfjGUSrIbDhImGa0IMyJYS1u6uzQUHMXAY/UUPYdliQMYoQomJgVzga8THTH2hR/57aW1D0RGf//hxP6KQI9XmMxX75vdzk0wDsBHRC6M3+ORHJoudeiucbBQ0Xp8KeYJgra+6rvy33l2otVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3dBDThBGFfjn1MI/L+cwzFXSibHy20mVirMGTk6pfFQ=;
 b=eqsR6bpKFMNKjzlJbratQWhqWYw7FZTMEiy3xl4sM/DehZul9CAK73Hyoplrm3c1+esBukcPklKRYaDIENEzHToioIn1tSKzSlQfu5le97g2Qme48OKYt4kXF6lTgoOlWzCB2Mc6PQcWbSJ1U2KmjVflQlE4+XjEsg13IR1x36b3u66Y5XwZmfTgTmVvhcTajxoWi8uDOpGoeQeRp14A+Y7JhiJlw86kglINqP/2iRXXsdaEvyV6dxx8LYzf053aIG3IkZRXGosR40qE76XVKwtdNowTrRUh2f6kBCxDf2Lx+P71EG0/jnU2mJCRWhj1+OBrcv/FoRzq8W0DlDGrfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3dBDThBGFfjn1MI/L+cwzFXSibHy20mVirMGTk6pfFQ=;
 b=hbcMbj1JqMCxfqQ+o2fZB/Qc9Xj2f55Bch4d/2sFcJErnU/IbnH4BbxtUrtSVws/rDE76ibLKNDB4Fous81l3fllJ2v7Q2GuRnZBMjMYW7nlk8egIjGu8xbGrlTD+1weueVgKIMaPy/y/h5pOP0THUQnV7ItDCDOFGivHmsHva4=
Received: from SA1PR21MB6683.namprd21.prod.outlook.com (2603:10b6:806:4a4::6)
 by SA1PR21MB6009.namprd21.prod.outlook.com (2603:10b6:806:4a5::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.0; Thu, 20 Aug
 2026 01:41:42 +0000
Received: from SA1PR21MB6683.namprd21.prod.outlook.com
 ([fe80::8bad:6294:8a07:fe18]) by SA1PR21MB6683.namprd21.prod.outlook.com
 ([fe80::8bad:6294:8a07:fe18%6]) with mapi id 15.21.0315.008; Thu, 20 Aug 2026
 01:41:42 +0000
From: Long Li <longli@microsoft.com>
To: Stephen Hemminger <stephen@networkplumber.org>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: "stable@dpdk.org" <stable@dpdk.org>, Randy Tice <rtice@cisco.com>,
 Jianfeng Tan <jianfeng.tan@intel.com>, Jeff Guo <jia.guo@intel.com>
Subject: RE: [EXTERNAL] [PATCH v5 3/4] eal/linux: report uevent socket overrun
Thread-Topic: [EXTERNAL] [PATCH v5 3/4] eal/linux: report uevent socket overrun
Thread-Index: AQHdMA55HVznrmW6BkK/PP5GLLeuUramKefw
Date: Thu, 20 Aug 2026 01:41:41 +0000
Message-ID: <SA1PR21MB6683CD698B27DA7C7C31DAF9CEA42@SA1PR21MB6683.namprd21.prod.outlook.com>
References: <20260817201602.120526-1-rtice@cisco.com>
 <20260819191036.679330-1-stephen@networkplumber.org>
 <20260819191036.679330-4-stephen@networkplumber.org>
In-Reply-To: <20260819191036.679330-4-stephen@networkplumber.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=25b1decf-0b0c-44cb-bec2-de8dfe71f3da;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-08-20T01:41:23Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB6683:EE_|SA1PR21MB6009:EE_
x-ms-office365-filtering-correlation-id: b68bcbf8-9f55-4760-4be4-08defe5c2f79
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|18002099003|22082099003|56012099006|38070700021|10067099003|7146999003|11063799006|4143699003;
x-microsoft-antispam-message-info: ewtjvULyjgOZ0cXgLJgiHoBEVWlKDWJWA5m5kEB6mrF0MeLEMNSmTcqi+gpwnK7hBkgMKMj72bMQ2s7E7TnKmZ7ua4DXZbaVEL9F+laHix/Zzbrg3wUxdOULbJa093kNgX9yOWMr59RqhLtvCZhvVAdIvFOZwD6iEfznYCZLKNXPM/9pxfTjkqUvFm94G7H4FXFEAdXzK+u4HdST39eo6/w/ma60KH8KuWaQZ+FrdR9PZ8treyh/rqnJlNShxHjCmmeExhRdd3fgAYP76TqSOJTp/mvFXP972/eRsBol0c98b/yuRAa66QQbxWsauntStx6qC/GzqF/5CScHWabcfTA1XjsK6AjSjjux6kdFIhFxYKAUKGyCkJIMLHE52wpIbiTjhU4M4Q5cfbX0ghcJcRjlSz9mJ0m3vvKXmfMrt82nnUiB8bHBKPLGPPeuNv/QsMPr4dmYFfslIOOt3IicxrLF4Zdoww0GhWRfOisXRs49tmTvGyYwhIWfggDcjqLIJlp++iRBf9ro/QUHgXoqfytJhafdU0+hH9g9b/uZpIpKXZQMvXPOrOIvwdeZQqUIQ91WN2HQz7S6DAMGKRzUsgmaYagvwgyuSOEOz4GSYOr+LmRzssnSyB04Ewj4qafWR9AV4VyRlN3P1IyayB7/GUYEitU+8El/zDptMfciWMk9Qu9tGnAtSnDVrzKa1IEZhBHxnI/m1gI4a83VGOoQeCHyPHOWtozPQCa5noMeuAQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR21MB6683.namprd21.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(18002099003)(22082099003)(56012099006)(38070700021)(10067099003)(7146999003)(11063799006)(4143699003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?sciaLIHlM/2SAcm+fysvyRXCJl7/qiaPmX+600w+RXcRuZjfh9haHVjFl2ZA?=
 =?us-ascii?Q?PANHNJ9zqc0h81yBc1jnhc4lgViVJBOes7n73NCl1+0bj5NkoXvYfGlOZS5S?=
 =?us-ascii?Q?bF/X6IXwkqi8kZNatnWJXy8x3LhZx7DrhOazdsWk5qIoY4bodGW8hvC/CE+M?=
 =?us-ascii?Q?yy97/X6pH1RDo0JQ8/4XKfFGpCUt7jmu/yLTGRkZLXWOBO0kSHyAWc3XTU7k?=
 =?us-ascii?Q?FEOB5Qr560lwL3LpVGEOCpsxTWotEkm4mGi7C91snXgO2mwmf96AsVGJLUlr?=
 =?us-ascii?Q?Wdh7llmE6L4aCB77ZPJvNmXZeT2TEUjsCf3SLpM9C7gciYBew0ougz+vxgOK?=
 =?us-ascii?Q?xD5SyskZdy1AWBPtVG/HMzupeOtuTLH4ca47NEFYPeQbuczjAQD8tcNrJ8Kq?=
 =?us-ascii?Q?9sDAuiTiteXQ0gKRTHgQgszFsCcJms917TxWyEQmv3FTR0G6H0WGZIJ8cCQt?=
 =?us-ascii?Q?DKKpiDbbZlORfz6yjTJszr1GTYaQnMkY4FAiIm4kvonJoL9gME3LmgDQpyvV?=
 =?us-ascii?Q?ro5xyOofJHU/ii14sse2EpsmSNebmOClsmWQjKb5w/4h7GXQOnYUIeMMCHXp?=
 =?us-ascii?Q?RfZVZGc9PXNsLqsfRB1AusCn5QlcAA9IW9YPGcXQcANwy4ETRXG42BUJ/8qA?=
 =?us-ascii?Q?RT6j5SD1bt0ZSGlDsxlCI59vhIoJzjdkwkr8qxdph7DOomMjuUIkNhCXMmqN?=
 =?us-ascii?Q?AWjekRdTQcGrxetR+IfxnRD96KYaF43wNpe4o01WgADh0OwORFdLSI46xxSm?=
 =?us-ascii?Q?LKtpDozef7MUM3h6qvw4fa6BjypNUCJf+dydMoVYsxkfKgk07DtGCB7CfVsg?=
 =?us-ascii?Q?8UgMk4pb+2KzoJxK+RXQW4KQv14PePSyhv8dwXcDrL9qpjSJ3Bl87CDkCAqj?=
 =?us-ascii?Q?D9U3qpgL3dMwkp0ZTR9gQeUcbc/okxm635X42Wji+YQD3XK0Jkm/Uil0xrGZ?=
 =?us-ascii?Q?+dWFxIQ8oCjMk75q5kVQVMp24+PC7bqq0NlPnGmnYeXkrMrusknjUx5lQNfv?=
 =?us-ascii?Q?p7Vt5lMQiyJvqzDelH4+zTGiVz99eFIJIz2eu2sHy7/y5oOmwGmdVrzE4zqa?=
 =?us-ascii?Q?EsxceSHd26eUIsCeCsvDJmpwzo1ku5Cwq/enjtclZAbeyHkvJh/rummO25AO?=
 =?us-ascii?Q?5TU2DLmaDxUmxBqJ4Z1AnNvurJ2G+wlwUAJ7U2IpxuGCbgtSGq3w0P5pezxr?=
 =?us-ascii?Q?s519x4Vsw+/hjMcCzKicahhFhX5KFSCUsfjVyEZ6ntJeSsLW2FN9LMonF78L?=
 =?us-ascii?Q?H0St8xi29wjiai9MYMdOc532DxjlicT4Xku8PKsel1xTkOdbIuiSg6cLxMdn?=
 =?us-ascii?Q?I9H0T8PljFtAU7VH1UJ/gnbYNOPavJI6KrWw6dMfEHTD0iOWk7E3eO36QmN9?=
 =?us-ascii?Q?i7WcTXQR9xZAgX/7iVmnVdhvFlrw43ioAsmwpF9Rr0QQX8E6vLisHkCIdifc?=
 =?us-ascii?Q?4wrDMls/60n1SR9ka0+f7fd126q7DwukZudyewaO67PPhkC06Yd/Hadyl30u?=
 =?us-ascii?Q?iUVJgh2VtzUwUUQepTO3s0k/JDBW1AE2eRVoqaxKQxj+tKgsYQ4EFL4J/2WJ?=
 =?us-ascii?Q?G5zZCbEm9qSzFBz3G3ZBDfFlfNleMh/BA+QLTx3KCyNSy6w8Rb1od3NaqsPc?=
 =?us-ascii?Q?k8LDONOyhFjWm5hEU83alq0mJSUSKHVSlNmKS6HfqQdMYLyicJY933DSnW/Z?=
 =?us-ascii?Q?+eIr4GHagZlPnOcixiJYm5P5iB6/5S2blT1bfcrfCnpMBd2d?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB6683.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b68bcbf8-9f55-4760-4be4-08defe5c2f79
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2026 01:41:41.9821 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bcbiPMzvDkRd5s5tcbI5eyP9ZQ5bCWtH0xczSWxTJEhCoBagfYgAfY+dFi4eLdKY1t8yWgvEcPxuac1RI+NYxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR21MB6009
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
> Make uevent handler handle case where kernel netlink receive buffer is
> overrun. If this happens the DPDK device state will potentially be out of=
 sync,
> but better not to give up.
>=20
> The code already handles the case of kernel sending a zero length message=
; it
> just ignores it.
>=20
> Fixes: 0d0f478d0483 ("eal/linux: add uevent parse and process")
> Cc: stable@dpdk.org
>=20
> Reported-by: Randy Tice <rtice@cisco.com>
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>

Reviewed-by: Long Li <longli@microsoft.com>


> ---
>  lib/eal/linux/eal_dev.c | 19 ++++++++++++++-----
>  1 file changed, 14 insertions(+), 5 deletions(-)
>=20
> diff --git a/lib/eal/linux/eal_dev.c b/lib/eal/linux/eal_dev.c index
> fb5c8bf070..b535122ff6 100644
> --- a/lib/eal/linux/eal_dev.c
> +++ b/lib/eal/linux/eal_dev.c
> @@ -270,11 +270,20 @@ dev_uev_handler(__rte_unused void *param)
>=20
>  	ret =3D recv(rte_intr_fd_get(intr_handle), buf, EAL_UEV_MSG_LEN,
>  		   MSG_DONTWAIT);
> -	if (ret < 0 && errno =3D=3D EAGAIN)
> -		return;
> -	else if (ret <=3D 0) {
> -		/* connection is closed or broken, can not up again. */
> -		EAL_LOG(ERR, "uevent socket connection is broken.");
> +	if (ret < 0) {
> +		/* transient error */
> +		if (errno =3D=3D EAGAIN || errno =3D=3D EWOULDBLOCK || errno =3D=3D
> EINTR)
> +			return;
> +
> +		/* kernel netlink messages lost */
> +		if (errno =3D=3D ENOBUFS) {
> +			EAL_LOG(NOTICE, "kernel receive buffer overrun");
> +			return;
> +		}
> +
> +		EAL_LOG(ERR, "unexpected error on uevent recv: %s",
> +			strerror(errno));
> +
>  		rte_eal_alarm_set(1, dev_delayed_unregister, NULL);
>  		return;
>  	}
> --
> 2.53.0

