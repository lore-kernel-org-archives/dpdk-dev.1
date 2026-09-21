Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E39BC982E1
	for <dpdk-dev@archiver.kernel.org>; Mon, 21 Sep 2026 08:40:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 148ED41156;
	Mon, 21 Sep 2026 10:40:37 +0200 (CEST)
Received: from SEYPR02CU001.outbound.protection.outlook.com
 (mail-koreacentralazon11023113.outbound.protection.outlook.com
 [40.107.44.113])
 by mails.dpdk.org (Postfix) with ESMTP id F25574025A;
 Mon, 21 Sep 2026 10:40:35 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cEbGIfR8AMytl4qxgDsoo9xm/rONLd/7i0KwYqKc8yfSHswZ24cKa+9HxtUKRLfFOtJBc7l+7uyJPTPd+iFWpp55jpUh8E7rOCbJTcAOlzsNt6myVxIXP4dxM/IXtk2qZjLbE0jbWwYf05GM9JeyydNX7St8/JTuE7w5juh35RnxWcnmtsJ+xBNBhoUAeMrlh6WrwdyoYseKZznzTyV9U5NkTujet1DbBsZZLdzx0YBwBOw1q/pRPmYjIyDMalOllrnWCrso4GVRNzGKQoqzepOAzdJqvc6MQUebRyKMa9myV0f+blk0fo1GDolKy0QxR2rF+3r/980xs/jddRg/wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:MIME-Version; 
 bh=uSs57xo0ypwTcBoB/yk4M5pAo2mfhSuFNDJ30+k8A8M=;
 b=DvJjzTxDMLZb2Qbb012hs4pWKhno/VuAd9jyJwJ0zm1LO81JAVVqcwoH8EEfIV52pq1kFLGuwpK+yrg+NipQqMEx042HoBQBeyC0u/iEWTUCmgD9Fp+idcFIjqcZcvBUTBSSxjQkOm0iP5IHHQ1cnT/hDA3wbZbcEaxf9k/rAZlEb5wk3VXpPG/IRkvSI33LQrYeFshk9kb/Q8pxGiJab/djtHZs7dRzwZAJhEckN89/DKC25dpIVtMKs84RhBbFhIkHiKxgV1TwSGX9EcL8baaCrEdeopVuMFNd8sVInYpWtQZZaq5FIAsMp3ttI/P0Pks6FSXtCuOFWmuYaF/eGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uSs57xo0ypwTcBoB/yk4M5pAo2mfhSuFNDJ30+k8A8M=;
 b=RznV+wXJu4AErHWtCDjA3yjMqODlL5NxzJ/yCD44mcvfu9V105q1s91b5NYzwz+/gqnbxq9dj/nbRWDdIDdreFveTdkamxFUaKMK2YW/q0F3ylm4WDJRpsOJigCjQQcyO2FlVJckhtZIJsvKWrlhYuH2kmOUMhTzNHJqjlUwGqQ=
Received: from SE3P153MB1848.APCP153.PROD.OUTLOOK.COM (2603:1096:101:340::5)
 by SI3P153MB2029.APCP153.PROD.OUTLOOK.COM (2603:1096:4:29d::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.2; Mon, 21 Sep 2026 08:40:13 +0000
Received: from SE3P153MB1848.APCP153.PROD.OUTLOOK.COM
 ([fe80::8f4e:575a:4706:a56e]) by SE3P153MB1848.APCP153.PROD.OUTLOOK.COM
 ([fe80::8f4e:575a:4706:a56e%6]) with mapi id 15.21.0472.000; Mon, 21 Sep 2026
 08:40:13 +0000
From: Wei Hu <weh@microsoft.com>
To: Stephen Hemminger <stephen@networkplumber.org>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: "stable@dpdk.org" <stable@dpdk.org>, Long Li <longli@microsoft.com>
Subject: RE: [EXTERNAL] [PATCH v2 04/33] bus/vmbus: fix missing acquire on
 receive ring index
Thread-Topic: [EXTERNAL] [PATCH v2 04/33] bus/vmbus: fix missing acquire on
 receive ring index
Thread-Index: AQHdSSvUNi085DfTbU2p30GUZmpSMrbYtzyg
Date: Mon, 21 Sep 2026 08:40:12 +0000
Message-ID: <SE3P153MB184826ED6E3BF94250EF2DE9BB842@SE3P153MB1848.APCP153.PROD.OUTLOOK.COM>
References: <20260729175715.165120-1-stephen@networkplumber.org>
 <20260920181347.747210-1-stephen@networkplumber.org>
 <20260920181347.747210-5-stephen@networkplumber.org>
In-Reply-To: <20260920181347.747210-5-stephen@networkplumber.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=24b05aeb-0e8e-4e22-824b-50c4632c18c0;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-09-21T08:40:00Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10, 3, 0, 1;
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SE3P153MB1848:EE_|SI3P153MB2029:EE_
x-ms-office365-filtering-correlation-id: 824cc23d-ce6f-44e8-1fe3-08df17bbf3f3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|42112799006|1800799024|23010399003|376014|366016|38070700021|4143699003|56012099006|11063799006|18002099003|22082099003|10067099003|7146999003;
x-microsoft-antispam-message-info: cOQS1zgKkY3mq6fCf1b6HwHp9KVwg+mSsj4VQaG00CPlD6kktnUL5oNtkHqFhef29fj38qjhQKipLXe72y6LDtSTqIyUxESPJs5PB4/S401Xf21OTXI9tvhkTaVUn0sbMDFHo4OjFXaL9ExVFoIC1A18nunWSKwyI5gc/JT3QHR15yvv0kqOkHlx7qMijikqtS+opskNW9l98JpkxEXOY0WAlPZi3YnmjhXWqxxKREB/xTCQHbGGLN9qsVRFGxtor0EpSZ20H2Gl+WEAzjTYC4s3ZpkWwbPQ0mmKfNYMS3otQcxMK1v5pBUc33NULCv5sxu4NqemJYYWIjmqDb7ypqOo0Rc2yWcOCjlWex+axYsjq2K7joSOWYwnESb6hzKZeG78seKSzTlr3vVtKoTmLVDFuMpBFwetic8qJfqIOO51gusoH2DbqaP5TG5jsGuGFcj9XIp/wUEt05VvPAx9MAw5yRvJdBCwnsMCace69x10xWBjOknuGCHj/KZK5Lk8ZyBVfZBkZ7+KYrgTUROif/JAk3swpav7B4h6qwsEmNlZW3XxwGNyP9xX3U/ojExrJiEJlWiAvszuplYSoFw2w4o5yaXyGQ6Ss4xm0g0w4dq6srOaipE7zk/JdCfNVWe4Cz3OU0Na6Mjcy0TldH1xg7zkDID3DXidfv4SoZp/Q4p8qdQ0VfzZtg6eN1I08Zrr/wkYdUtofTm1isSSjnX3gYP6TCcCNhRc8L61ZCv+PEE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SE3P153MB1848.APCP153.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(42112799006)(1800799024)(23010399003)(376014)(366016)(38070700021)(4143699003)(56012099006)(11063799006)(18002099003)(22082099003)(10067099003)(7146999003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?FVMP0cd4lsJTCFQjWlFxUbGUGpOP8qhY3q/SDO9ATs36RDQ7CY6me4qkhl6g?=
 =?us-ascii?Q?m3+GMklSupVMqPzNaT9maAeX16dxEzqIKQnDOip8oHxsDFd1YXu3Uvd0rptk?=
 =?us-ascii?Q?3wmo4z4N0RDtApaSn4AlysFPSxEFMvvGfMzLcEnWcdXY/gWO3H5FAHbLFSp0?=
 =?us-ascii?Q?0mwYIGPUAsdVYG9/Nlzsu8Q90j2G/hKRoS4VzdkeDEcC4/pznHcwiWrsUyol?=
 =?us-ascii?Q?dpfE8lF8ZYwxisb0xDwOlGTQxvBXB5iln/0vtRXE8owS7QRI270DrOGRV7D1?=
 =?us-ascii?Q?1nRxeCuD/252+S9t4c6UkX+DgMsGJ5Gv8ji5zR5efFZAOdikRg+CLIk+FX9u?=
 =?us-ascii?Q?KrMslcvP+a9fGEH/XFCNYTi8VMGqloRQ24JCsD0jkR9w8IIaR6RlR/HqKrOe?=
 =?us-ascii?Q?ZNA0tl4r5oIbj8i4n2sPdFPPgK2CUzxevKZs6oWXVoKVobiVkdmpjRVn2SGF?=
 =?us-ascii?Q?PCZeVILpoa6uuOvto47kqYO2Bjj+A7vgR5YRJSJhXk+Si7iqyeVOJouWMnSX?=
 =?us-ascii?Q?zNFuLR4C+eeyWSz0gfVICHCz6PU6Cm+VfngrfFymxjb+cdi5xrOgwNTAqsCP?=
 =?us-ascii?Q?kbd9DjpVDHZxsUJkCfaHqIDMaEfiA6u/a6znKYhdwFnB7D2XqAnfk5OKteBD?=
 =?us-ascii?Q?q2NLCMGTDn8neHvIhmkZrDMWk9rCRvX180Y1+duzHJF2PW2NZxdAxabVb0ej?=
 =?us-ascii?Q?oyVf9Py7G38Mqjn5iLC07eNP6EuJwbHjBhVhgebsf5FHKmgWs6JP+Us8rXP7?=
 =?us-ascii?Q?RSbGs7rYIY9jBUT3U95ZSHEHEcy9CH1TaPcwv+/yyseldzQ/NJWGHmNn99zL?=
 =?us-ascii?Q?SR1AVH7P5j3rdVneeGjxU5hgGXy5h/rn/N0/jb65ygCUP/Oo49VLdOzFQFP4?=
 =?us-ascii?Q?vBoFgqmsw5zGZh0ON4NbujZSm3xDNND4Ky5DrebYXmsvA6fU1GX0Q6TfRzix?=
 =?us-ascii?Q?zq0rGJKdrSyQRmGaWOH+rtuLIXNYK8aRMQ0vNZC5dv2q8U6uqqjxVXZ0wDcG?=
 =?us-ascii?Q?EeH1oZwJKZ5Ym8GS+nWm7AhsD+MfBrO7A5lCNn6DEHL4CKQJE6HLeVfbYI/M?=
 =?us-ascii?Q?P9vd+++oTQXbWs+DMfYr6r9B0pkt4xBdw+4gfzpbL7IJDGAKDMcNj7QPR2Tz?=
 =?us-ascii?Q?ic96X68y26AB1AYWYyVLrcM7rTzszk1IwfzsA0hKeP6b0/vTNj1vqeRmUQsG?=
 =?us-ascii?Q?45JxaDkdR2Kio4EtU1R6zAQrNrT04yI5YaVxfRx4yTyd7UPlMx04Rw835r0n?=
 =?us-ascii?Q?nLu5RPAjoQSr9djB9rhNiRxCjY+S6wLQ1OCpNzUHiRPIRmHhgyS6bOZ96yH7?=
 =?us-ascii?Q?FBbfRwcL0jjaOGYhYiFvZgYNRmlYne1hWt0aSK3vKZE/hzSn+eq9Tkvw/P2D?=
 =?us-ascii?Q?/m3tnwmo0nZIBRMIHVnaH0HRR5vUG8N3FY3fhMkmtGVpKl+2+UI9mdlaFkh+?=
 =?us-ascii?Q?Y8cXcixBVyI6T8sZuRAiBfyhk1aF/vetFvHMWtX2cXxouXM6siS4UsgLCODs?=
 =?us-ascii?Q?lL2+Ar7g4kSZ/cn9r2P4I1awApI7Lc0hXgSsHPJ3wyeX5JYAAejv3VoBZlUA?=
 =?us-ascii?Q?SlOjY2DPSjqcCNwt48vCLHju6F2JtAw8ro7ejmDA4IHECBmqVy4a+TomJj+0?=
 =?us-ascii?Q?OZ08ywyMfpx+zzrcPAaaHqen7z76ofjwCu7I0MWR+Mk53tWx2SW7mq1tLWGQ?=
 =?us-ascii?Q?5osh48rwv2eSgZloHKYFHg/H79ocFEnNiL9rqo+bQ/gTtY1Z?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SE3P153MB1848.APCP153.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 824cc23d-ce6f-44e8-1fe3-08df17bbf3f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2026 08:40:12.8809 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8GykTHSLvtbRyje8lr1WWV0Jo5YQxIcNgOIOvFGv/Ph5quwb23lWokrIx9nJOTGIHYoRUEoIkCu39aWcQ7L+bw==
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
> Cc: Stephen Hemminger <stephen@networkplumber.org>; stable@dpdk.org;
> Long Li <longli@microsoft.com>; Wei Hu <weh@microsoft.com>
> Subject: [EXTERNAL] [PATCH v2 04/33] bus/vmbus: fix missing acquire on
> receive ring index
>=20
> The receive path checks available data by reading the write index and the=
n
> copies ring data. The link between the two is only the comparison, a cont=
rol
> dependency, which does not order load against load on a weakly ordered
> architecture: packet data can be read before the host has finished writin=
g it.
> Load the write index with acquire, pairing with the host's release store.=
 This is
> the equivalent of virt_rmb() in the Linux hv_pkt_iter code. No change in
> generated code on x86.
>=20
> Fixes: 831dba47bd36 ("bus/vmbus: add Hyper-V virtual bus support")
> Cc: stable@dpdk.org
>=20
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> Reviewed-by: Long Li <longli@microsoft.com>

Reviewed-by: Wei Hu <weh@microsoft.com>

> ---
>  drivers/bus/vmbus/private.h | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/bus/vmbus/private.h b/drivers/bus/vmbus/private.h in=
dex
> 6efac86b77..aca5b534f9 100644
> --- a/drivers/bus/vmbus/private.h
> +++ b/drivers/bus/vmbus/private.h
> @@ -12,6 +12,7 @@
>  #include <bus_driver.h>
>  #include <bus_vmbus_driver.h>
>  #include <rte_log.h>
> +#include <rte_stdatomic.h>
>  #include <rte_eal_paging.h>
>  #include <rte_vmbus_reg.h>
>=20
> @@ -130,7 +131,16 @@ vmbus_br_availwrite(const struct vmbus_br *br,
> uint32_t windex)  static inline uint32_t  vmbus_br_availread(const struct
> vmbus_br *br)  {
> -	return br->dsize - vmbus_br_availwrite(br, br->vbr->windex);
> +	uint32_t windex;
> +
> +	/* Pairs with the host's release store of the write index;
> +	 * ring data must not be read before the index.
> +	 */
> +	windex =3D rte_atomic_load_explicit(
> +		(volatile uint32_t __rte_atomic *)&br->vbr->windex,
> +		rte_memory_order_acquire);
> +
> +	return br->dsize - vmbus_br_availwrite(br, windex);
>  }
>=20
>  int vmbus_txbr_write(struct vmbus_br *tbr, const struct iovec iov[], int
> iovlen,
> --
> 2.53.0

