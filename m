Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 041EEC282DE
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Mar 2025 13:08:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 60C76410F1;
	Thu, 13 Mar 2025 14:08:01 +0100 (CET)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2080.outbound.protection.outlook.com [40.107.96.80])
 by mails.dpdk.org (Postfix) with ESMTP id B28DF40EF1;
 Thu, 13 Mar 2025 14:07:59 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SITfymespoqVCWbQ2NNowupGSAAKUkEmLGG2/AKno9JUO6uxwQTSMB8B6plXvckTYPZC8XvG84MAGsGkdXgzK20xao+CQvDah4zytvTitHN85NAVsz0++rndAzAlB222HGLAZGivqY4W8FjN0QdxQ9xFJP4HcCUtMsNIvB2adww9RbZMQy0+0VT66E2+RFdoiCRPSUrPKGBaeoOhi/2Gl0yOHxgUu4MNeCYMy6T8AuyQ/M0QDjuDwG4UIexZ8eUkTBMfBWuQiX2iiwEPpcNM0MR1jZqBHFOW+l7qMkecXzJEqW7lpihEsrda9dI7iZh+uXtXwEunigwY0aQKGIlXTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J1fQOaduCmF2I42V1Hh+o+5BsRUgSKWoMNMkTUX6iwM=;
 b=MHkdTWDdqYVZ6SdXC53m5qWoFC487hqP503oTES2e2OQT6oiFH28/ewTnb1McuRsymdK4KEBuEXmwAinDptYTKo2b+aFPrqsBHLwbsYGMdlGOfTG2OS/9a5T4zlgPU2o9ddA/gelbf9chHG1CFmOqbWzczchGPEfo+0wzuFFmWRne6HouW/ueCjUnHVequo8Ap82tIXbpRlY5k+1UK3UDO1bgwQdo/4dy+gSajolDam0q0i1rWDhTiDe3tmnRLyQBfbu1rKIIa6ZRXgFvqQD+PyWk6oAb2waM5IaYtw06vuKL1i9r6etlycahPTiGipRbhBABdN7z4kwNrFbtvquZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J1fQOaduCmF2I42V1Hh+o+5BsRUgSKWoMNMkTUX6iwM=;
 b=pVpGXhD90BVw7Mp5taSpREMEMnJDRGKsEGmhUnS8TAtmSwH+Sl1nl0RPAyMVCfJ3bwDYIGXYS0SqFBM+ZHEe+vEE6NPHDRx9pXnPdmxOME3GUoLSJf0kwI3uWWUhAxywCehu8SpcqK7bqLueEB0Pkuig2zbXZu9Vi6rxq6Xia4mD8309+1KeL6Y5ew62XalhU81DLX7Sb5wrgg7DtOuE9gnEob0hWexsWtLE21Nsrgfhh4VqdIfXnA5QCJS8M8wbgfVThdH+vhDmF0RUC85lNC+PAYNQUUlfFS2UChHuV4IEFvib3lwXET2/MqkhW3tvhIbe3Hy/y/6/DGUkmUHLzg==
Received: from CH3PR12MB8460.namprd12.prod.outlook.com (2603:10b6:610:156::15)
 by DS0PR12MB8217.namprd12.prod.outlook.com (2603:10b6:8:f1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.29; Thu, 13 Mar
 2025 13:07:57 +0000
Received: from CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5]) by CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5%7]) with mapi id 15.20.8511.026; Thu, 13 Mar 2025
 13:07:57 +0000
From: Raslan Darawsheh <rasland@nvidia.com>
To: Dariusz Sosnowski <dsosnowski@nvidia.com>, Slava Ovsiienko
 <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>, Ori Kam
 <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>, Matan Azrad
 <matan@nvidia.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "stable@dpdk.org" <stable@dpdk.org>
Subject: Re: [PATCH] net/mlx5: fix NAT64 register selection
Thread-Topic: [PATCH] net/mlx5: fix NAT64 register selection
Thread-Index: AQHbkzRaai1ePGSSkkO75cCRw3Mh0bNxC2Om
Date: Thu, 13 Mar 2025 13:07:56 +0000
Message-ID: <CH3PR12MB8460CB6585782E5E6F4F8B4BCFD32@CH3PR12MB8460.namprd12.prod.outlook.com>
References: <20250312095108.105978-1-dsosnowski@nvidia.com>
In-Reply-To: <20250312095108.105978-1-dsosnowski@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB8460:EE_|DS0PR12MB8217:EE_
x-ms-office365-filtering-correlation-id: 78b31b54-c480-48de-a2d8-08dd623012bc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?sQLMM02pUXse0d1mHf3E6xhB7ttxQ8JyEGipz0kvRQtw/ByrJyi24pRw33?=
 =?iso-8859-1?Q?6u78MK9Arq+M2vVHIJlluppPU4I9R4iIryCOGT06ljEoqKRQ/9X0z/eghP?=
 =?iso-8859-1?Q?9K8AMW71AdOtnRANFqsJNkh8n9Ap10VUb+cmE3GUKv2D6bRvYGhnMRBDMR?=
 =?iso-8859-1?Q?R7vyWq2SVoSIvhL4p8D6QE/70B9/29MBvq1I2aMKM7fUvhaYi6snolcEvP?=
 =?iso-8859-1?Q?s5pe8Fx29WDyKbyfsb6rTkfecPTKYxHfgfXX34QFcj3Bb1NpQYdkz08xO8?=
 =?iso-8859-1?Q?8h7AJWxFtowT0OfByYQPHVN8qlcNqQQ/6Koy3GA3Fjsjh4yWE0Kc17mxdk?=
 =?iso-8859-1?Q?1RsHuZ6//nMEGfk65TQ5LzsleBsa3I+gcR8F5FgDSXZ7xou9+YTp2SRTDz?=
 =?iso-8859-1?Q?pIF7JDSp6WQbhQ819hCQoqB0iehWF0Wre6k4rgBRj8twtiQFiBJs9tBYzA?=
 =?iso-8859-1?Q?FpXEtI2MYwlYrO9Ai0LWrZeATbD3GF6hB35Z6LbM4/cGVzrbqXPYwzJ52z?=
 =?iso-8859-1?Q?gU7O0LikW+f2H2aAtrDgatK5c2HvJYC3RGiL9ntAm/UjSUek2mxNuVhHxs?=
 =?iso-8859-1?Q?UpGsdiIy0n6X5exYM3u6bOesppteALg0B8h8uZz9glyj0S56zh067Yr07N?=
 =?iso-8859-1?Q?mZDJzRiHGbJ7hMg3JRJQeNw5eurQZ/CF2rSUrQ5N/W60uoFMgwcwAd3Skz?=
 =?iso-8859-1?Q?q0LwD0341kYrEXr0R5VR6gJEUg0SNQEvy/s05szkveDfGSXMSLixOXL6+j?=
 =?iso-8859-1?Q?+dnh8L8RV0ycUpr9qqFQBAsA7XZpza08Vyn7pi9w86md3VoYyLK8X6/maw?=
 =?iso-8859-1?Q?sriCEhyLv8FhNy1f5D78SIsNencaw6/7/CajWWPMyEvSbJdBdtx2qMFqr+?=
 =?iso-8859-1?Q?47H0LzB+NYQJMI6g/FkX2JWodouyhX+vErl03uHY5IXJZn37LXCvd+P8Ds?=
 =?iso-8859-1?Q?9z9InWqzQ0SPFsrkUos2pOlwa2jQQRX1QGtGEVtihhTjiI8YIww0wEiDmG?=
 =?iso-8859-1?Q?f0Mqb65HcVZp8yEkMCO3Ker5jzRRogE3bqwef+A7fSi69NNk9xCFdyg1/j?=
 =?iso-8859-1?Q?1/LhE2rPqAJJA2WKdWiIOy4TIWND3cLUrZbwjc6ANrM0dLwBb6za0gW2k4?=
 =?iso-8859-1?Q?QQhn+LYEwya2M83ELTZawVEpFbJz7mHr6cf36MpDdOWrJHSPxnn9xXLign?=
 =?iso-8859-1?Q?fegtkpHyhMoz/SmB10xoO2XV898fBOAICrlrWya4n6yDV52qh4yUTHw/Zp?=
 =?iso-8859-1?Q?rW1sg8Bdi8cxigYlq0j958O73LbDKe4qlYBzuqorZyNiuUPl0L+IPbuUS8?=
 =?iso-8859-1?Q?+rh29rUaQgeR77tps4B1lxyL+1NLXxawVn6jdrwXI+4wh+ptk+s1tPacWn?=
 =?iso-8859-1?Q?K58Cs3Kz8maJwCvDCliTJiZ0N13i4QUHfMBdiULnBaXkApz7wO7FZbvQ58?=
 =?iso-8859-1?Q?5mVuaDVMhChezSoUIMnlcPKLamdDrBmwUY86b5/njRQ8NG6tGLNzBTM/jp?=
 =?iso-8859-1?Q?9gK+VTpMnm/RJPOPL4u1UD?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8460.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?fQ8hsaT+jrtydX13Ij9Da5CslmejI0sS8Gs+jDW4f69OoZEd2NRc7Unbb9?=
 =?iso-8859-1?Q?O903UyGfjcn0W6pqOdnr+1huNGSjGBK0Hugfaz9/0FJ6j0LdaViRZutnzg?=
 =?iso-8859-1?Q?knYShdKTKquKcSje32n3WM7/y8xKrLN2aM2koLuWOSvfbo/tJJxg9O0eQs?=
 =?iso-8859-1?Q?lR5YCMO+1f8tXFnTIoBdHUreZ5ewlI9xPbHdxSfx2Slf2jYFhjJYd0OsSy?=
 =?iso-8859-1?Q?KJ2KDVvsW0kr83iXFEbyBJBYHE4Qy/7Tq9Oh02ebpeT82ZP+EIsPr7oUxC?=
 =?iso-8859-1?Q?PKYKMwYjx9DLWcihMU7mVFexV927VbUY+qRmgGKy7o+CFtoChWwMm2dbbJ?=
 =?iso-8859-1?Q?NKrXGFl8FTDNta+RosmCgnSgAe35QoySEjd+zdYT12H7WsnOudC22KUGAu?=
 =?iso-8859-1?Q?wpdHM+Nzlx49eYOWysl5Ou1QOGScI1fS1PjTxIykJ8TF9ZPr/k4v2aKCkG?=
 =?iso-8859-1?Q?Lrl2Zm3qSnOFInpts8zvl3f2k54QJkZgB24E627M0tLI2ZCfJv59tZ3M3B?=
 =?iso-8859-1?Q?GcY30H9YgoMi9McmmhU0329bBRJ/ZntBF8boZpuoc8zO0PHSp1h9dKxj2O?=
 =?iso-8859-1?Q?e3Ya4UaCoGghl259yjo4yhxgwRmQnh7fhc6/rI71ZwA5AKfGpzDE5Xy3I0?=
 =?iso-8859-1?Q?13rY+Ag66/5GNOcbGfI5Ciu6yOwHhAqVsN53Tx5gE1RlcoNFMtTlSuhcCx?=
 =?iso-8859-1?Q?k+SOT1IrK6GTAABa1iucsh4+DciE5femlLOCrgi+vey77N67T3cNhRP5S1?=
 =?iso-8859-1?Q?HV36QOs3inwxusLC5QdMXHzSvJ2toJbdHkAlPq8DAe4Ocp9Ihs2MuRFWPW?=
 =?iso-8859-1?Q?lXnC0LBtQBm1m1lK1CpEF3mSi53ZPHtPpvxdxubXY2CdSThXI35/cyN9Zj?=
 =?iso-8859-1?Q?JM3MA/Ruzbk8BaZ6mVF2lxWE0Bslauyjl9eN9pVQMdMQ4xBTkSxJHC9Ep9?=
 =?iso-8859-1?Q?QeME4Eq6JgV+zKB/BtcKdJTExK0bK3LRt+V0oX5nxmCA//231iFSGTF9eb?=
 =?iso-8859-1?Q?K+9BG3IrWeKytLmMT+0dszCoA9563+pNpbL1BhICKViYBOovwCvlutthKX?=
 =?iso-8859-1?Q?vnkQLtPmd/zoohd1o7k68VvUer7rht79bjykXDeyBM/qAu0zSpsgset5Uo?=
 =?iso-8859-1?Q?l95BWVI7VW9PWskYu14YNMGk3YEqGykZc5uQkjds1ijuhiQKwfUfFWLAS7?=
 =?iso-8859-1?Q?U9dn+vfZXUqtKQYAJk3jE1ygj/ofsqBbrMebIIvFYF41bNsXy6VbKqtovV?=
 =?iso-8859-1?Q?LEF5WMvZMjOQLslyxhAMZCfOfRfX85mYNjiyDvm8muyjgMlLSPYTpE4XoU?=
 =?iso-8859-1?Q?ueCIKaecctrDL5VaFGzXmYTNCT4ucM8YI9UV+jRbpWYhtxsFbyvkBubteK?=
 =?iso-8859-1?Q?AieM0ck3ZSmowEyUFV4s45NmUH43Dua5WoJmUpUa1qrDb7GqbkVRhYi6SB?=
 =?iso-8859-1?Q?YhFzXKvjNs4bLvQ8xzeodNaucKF1ikdBQte1rR4to8/cz3/lyeMEbBguXg?=
 =?iso-8859-1?Q?ytAhjb9gTJnMFawGfHS4VE0NVwjN7tl+6HzWafjwD/N/ht3c1e25q+HPSB?=
 =?iso-8859-1?Q?n0794iufeQ9q3NvUCNRtE0aogBPcvbCLNP9MCbi/+dZt+vsUe15e7gx28o?=
 =?iso-8859-1?Q?TArFwFWuG0jBUyn6xzhnya55KqUE8wG3Zl?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8460.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78b31b54-c480-48de-a2d8-08dd623012bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2025 13:07:56.8578 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7HYZfOUR+QrqL+yt4f4cNpJ4q0h/Mj3uzublZMU8LxxX1WP9rdu4lOA/0kdp65guXt/rqSl0w7u0WjntFfisqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8217
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

Hi=0A=
=0A=
From: Dariusz Sosnowski <dsosnowski@nvidia.com>=0A=
Sent: Wednesday, March 12, 2025 11:51 AM=0A=
To: Slava Ovsiienko; Bing Zhao; Ori Kam; Suanming Mou; Matan Azrad=0A=
Cc: dev@dpdk.org; Raslan Darawsheh; stable@dpdk.org=0A=
Subject: [PATCH] net/mlx5: fix NAT64 register selection=0A=
=0A=
PMD statically assumed that REG_C_6 is always available for use=0A=
with NAT64 HW flow action.=0A=
This led to PMD configuration errors on FW versions which do not expose=0A=
that specific register.=0A=
=0A=
This patch fixes that by adding a check for REG_C_6 against FW=0A=
capabilities, when registers for NAT64 are selected.=0A=
=0A=
Also, if not enough registers are available, PMD will not attempt to=0A=
create NAT64 actions.=0A=
=0A=
Fixes: 7a26bfec06a4 ("net/mlx5: fetch available registers for NAT64")=0A=
Cc: stable@dpdk.org=0A=
=0A=
Signed-off-by: Dariusz Sosnowski <dsosnowski@nvidia.com>=0A=
Acked-by: Bing Zhao <bingz@nvidia.com>=0A=
=0A=
Patch applied to next-net-mlx,=0A=
=0A=
Kindest regards,=0A=
Raslan Darawsheh=0A=
