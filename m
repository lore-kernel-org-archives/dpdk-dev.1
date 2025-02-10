Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FCB2C02198
	for <dpdk-dev@archiver.kernel.org>; Mon, 10 Feb 2025 10:31:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2F07240268;
	Mon, 10 Feb 2025 11:31:23 +0100 (CET)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2064.outbound.protection.outlook.com [40.107.102.64])
 by mails.dpdk.org (Postfix) with ESMTP id B1C7F40150;
 Mon, 10 Feb 2025 11:31:20 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sTZ+gyokJbCfmYkD1MFUxW+jFEa1y48jy/krkoQ75nvYLxLEQ7Ozzc0+Fv9mRoMRZMw5GdTJOMg+nV1GVof8Nzjedr+TbFqsPjrogYy/No2AnVmoM03Z7LH4peAHqnmyThIvjJ1TZPwLxfXt6+vQMBj68ROuijWb1oghA20dk0R//RcRmd1xsUen/jRVCv46hB7Slr5n01Z+31b8JawrbAXZaR+K09hHFvvXoVK9T2P8i337vVQ55C1+y77QvY1e1LLoPfRkVS/ic20pau/oB7J2Tq/JDbMltRuQJYHcry3XjK9IokGk8/SxBc9BVjndR9amR1dGv+mgfVxzq5z1/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sG7hg/NcGEpd46QHaZkEC6CijgjCRp1t1mmVcmtRgxc=;
 b=cZOpB1WyQVJRPmtSVznUxnUoHsR3n2fBUg635ZEfwnTzxl+anfxpFuNjgaUUhHeGNrzj5KVm+Wj3abdx36+vXUYHYDhAFpapbndXU384Yb90h0O1amUxSZoZRKsw9HdTgxoRRmvcpPO9F/SujaldrwReVwRzLEFJcrAk2aq4El7DtQNb3H9i2WaciZXNas0FfbcXPs4pDO6PZ4wWLYozXF/6fVQhKb07B/zOpw1RXDFL6AADZdVhi8p3Ew95PZ/FJSMQXlF4Hq4Io+Sf+kwEsD3z0qU7zDaiAOw+vnIHrPUNYCcutD/Ch6ZErUXtuS1xPPg+asB84UuiAPqXP41n3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sG7hg/NcGEpd46QHaZkEC6CijgjCRp1t1mmVcmtRgxc=;
 b=kBCm6cVXWAmdgFg6BFDGJFvooh/Bn08SkqRCmqUzIR8ScuNTMgtDZuFt9VlEfMfuamqQRR+39mHRTwFbXk51dqWxh7dTOX7LTcSCdY0zoxnm7vj3RA0uxdG3ekwhp46DAOxksnn/5j5BWj8UPtHjC8YZ873CHAunaU03zzCftNUIvnbm9oS7+9EFwc+Pp5fUaYILo34z3PA3+TZxGNKeC0Rk73KV99TcSLFJySNnvCgBH7xWRuOxFWEt/VnRLg2LFfGTS6Rgq48S00YE0SuT1EtCGP9Tr+eD0C2V/6ZKr+awcb/GrLFsznXjFk+vDRFIrfY6ct8AssUZRt4WQzJ+mA==
Received: from CH3PR12MB8460.namprd12.prod.outlook.com (2603:10b6:610:156::15)
 by SA1PR12MB8722.namprd12.prod.outlook.com (2603:10b6:806:373::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.15; Mon, 10 Feb
 2025 10:31:18 +0000
Received: from CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5]) by CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5%6]) with mapi id 15.20.8422.015; Mon, 10 Feb 2025
 10:31:18 +0000
From: Raslan Darawsheh <rasland@nvidia.com>
To: Maayan Kashani <mkashani@nvidia.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: "stable@dpdk.org" <stable@dpdk.org>, Bing Zhao <bingz@nvidia.com>, Dariusz
 Sosnowski <dsosnowski@nvidia.com>, Slava Ovsiienko <viacheslavo@nvidia.com>,
 Ori Kam <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>, Matan Azrad
 <matan@nvidia.com>, Gregory Etelson <getelson@nvidia.com>
Subject: Re: [PATCH] net/mlx5: fix GRE open matcher does not match packet
Thread-Topic: [PATCH] net/mlx5: fix GRE open matcher does not match packet
Thread-Index: AQHbcVqebGtx+8SSGkuQXryUhkCIy7NAawdZ
Date: Mon, 10 Feb 2025 10:31:17 +0000
Message-ID: <CH3PR12MB8460A41FBAEC22888D579F28CFF22@CH3PR12MB8460.namprd12.prod.outlook.com>
References: <20250128075930.175636-1-mkashani@nvidia.com>
In-Reply-To: <20250128075930.175636-1-mkashani@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB8460:EE_|SA1PR12MB8722:EE_
x-ms-office365-filtering-correlation-id: b0053527-6131-4b9c-5c2c-08dd49be0dc0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?WVG35FayqVX4xtXSJnZ1g9Jhxtldpyit5F/wk5gxU04+5Vf48kiwEH3Fkx?=
 =?iso-8859-1?Q?Mvu5Nyf6Y/TKWq7dGtGo07369Mw7IKSxuhI9/3xUKR7uA2gBpz2qz1+gzf?=
 =?iso-8859-1?Q?6kyDWHDcIAs6hpQ0szqsrF6IcXV7/GB+cMusoCBX8/seO1KTQtTASuWCNz?=
 =?iso-8859-1?Q?vEjqOWhn4Q047OnBPA7MUAkvbvs/JVO8+4UbBSiBGoKWhETJEZPo83GCI6?=
 =?iso-8859-1?Q?nbn9euvUfqgyNGkpKcgm87XRv8xNEVGJ8x1mf29BG2QtcuDVl4A7QGktdM?=
 =?iso-8859-1?Q?6NClTs14N1Z4Y84vvohs5Dk4LwpXPM51eg1TeZnuHjXXqsLzYpAN7vRZU5?=
 =?iso-8859-1?Q?j24syKMmfd/tFf2ovQlQ86qNv/Nvxsi7V3g+yIYkI+lqHASDp0NwYcKpKP?=
 =?iso-8859-1?Q?eeUkeOqe4ACa307UU/SbYAqBdTz+YXhnl4l1YTzMauWgn+PJpfQ4M37lDv?=
 =?iso-8859-1?Q?OouEkreXBbHZVlhF0yGhZ+6mcGowjqUHe8MTAPBfGGfMu6o9ZeVEwUyOxK?=
 =?iso-8859-1?Q?0oJuq+QSYEpxwTRW6/H7C/zD1Cz5hYFAuXSlVq4zB+gZlcC7WoQ1goj+H3?=
 =?iso-8859-1?Q?6sB9itMMs0fIC6kvM2mQ75CGCrew6KlekmeGSnDRzUzbm20QgdtgpUePyw?=
 =?iso-8859-1?Q?pi95iGOynn1EwlgbKtHCrqFn7mYRePW6OYaNoRVe9STi68D59dc1IsE6TV?=
 =?iso-8859-1?Q?8YcxNz1DgLcIarcfpuYYiuUNWZpkmpjPbp+C+imElHlnuSancX64y16I/T?=
 =?iso-8859-1?Q?rLUlU719KKBM2WS5zZUpNj3ook7Z8JZJrBpATaW27rtrWAUnVU1bdjN1rP?=
 =?iso-8859-1?Q?/+N2OmGBCraJ61Mcau3E1UYtAWAiWLJL7+riINxF1tsxFvuw6vEaSOJtZM?=
 =?iso-8859-1?Q?7IuDdjz+E3JNTCeHBgtjteT2v8Wl2aWXItW2UdcolQFZHsRJt5dsm/LZu2?=
 =?iso-8859-1?Q?dn03ydWyWoVkahC+3nXVyfQmO2KCVqrinvX//Q5M8wbGzet2MAyfXSWoZk?=
 =?iso-8859-1?Q?tno/0NNss3WhVDjpUCXqr9bhBE8PAlyIUlrf8obMehKjGYTzHg4hcHtBzq?=
 =?iso-8859-1?Q?l8tfaG3fnvnXBoH8oHGhZsLZn8vhzK99Rdx6uGcijdWC8Tz+AnIUIRjStE?=
 =?iso-8859-1?Q?tw2oymGBge7bFY5UyGplYudFJD+UorsTtXpkK3MyQLN77U+aqrEMJXF9T0?=
 =?iso-8859-1?Q?8pOYZNZpDzK/xy6fA6wUNRU0a8skVwW41/rQT7QSg5Yq+u/0LTb647RMaK?=
 =?iso-8859-1?Q?1KOY0b4xYAn0lT/2GLsQE1Pw9kzdnUFqgqiI/h1JL5eKzGAs9fHcgVJqou?=
 =?iso-8859-1?Q?6SVg8oVH78Y+HT2i63bDsQQT5Ddfrm/MhSkQvODFLzUfUXNQCHG+y2q/En?=
 =?iso-8859-1?Q?AFK7nxk7fECdTElZ1DFrGZmgKJx2hrLoiY4DHuQKB5pyp+HuShxIiJ0CuE?=
 =?iso-8859-1?Q?xcbgeJ6hseEsYMcz+o4rh3K4sYOHfBPYQk7/ZDsU9fSZx0jaYeDCHiVRha?=
 =?iso-8859-1?Q?5RkhRJKxvW4eWQpJ3sGZpx?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8460.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?rNrbhJCLI1LbZafw5szFfDvVhFrqmOZalPz4wZ0t68X++ywLo/3lxzl72E?=
 =?iso-8859-1?Q?8erynt8oO5cYOQrNJXQXpo4G0oYcttUAffuEDtYkOB1vTvXVEBXXihxDD+?=
 =?iso-8859-1?Q?8NbkAZ7b3QSomZ2VYCYe7PmoKqsgh58kDPs2ZiiMz9g2xZzF4wlQkQ6EF9?=
 =?iso-8859-1?Q?NUafIw2jbA07SygWKmq8k62znZvrIpEzdDX+H4zDX2awUZrkftee3Zg2Mj?=
 =?iso-8859-1?Q?c4/3IYwFgCRXNtOyRrmFkVHF2SZGvPa3tvYVe/5jiguc3IAUIrlU/20bmz?=
 =?iso-8859-1?Q?05binop/NtobSRmCzcTGXp05d5tsFAON3u+ScxTjsqOCM0cWuwl6WF3ua/?=
 =?iso-8859-1?Q?XJ2YGn759KAQ3/B3kdMljRbmphPqDvnl1KL1d/kRjpkqdD/E0mVOBXBEUf?=
 =?iso-8859-1?Q?3fuQTAdWgcK7v885kGZbdskE4bqkory0gkfpp2AZGiFFliN3zAr1YG3XIT?=
 =?iso-8859-1?Q?BnAMdrWpFpFLXnjvxZD96KA9m0T++TdEsX9fcuiUGUffF85Qcy5yPrz6Dt?=
 =?iso-8859-1?Q?NF3/0796V9MbpAzyRvf37yled8HOsf5izzaNjc5DB1HgzNAEGMyEVhb3dz?=
 =?iso-8859-1?Q?pEw3T/0eyGUao8fWhCWpgKwtJRRsaAlEl6fIC9iYCKhXPIVTW0xAhGa+0/?=
 =?iso-8859-1?Q?lbMzS3NrcBYzxPPRpZ0yD2Ny/pitm3XJoykDaDZoIAkbQfycIhMnvMFn8h?=
 =?iso-8859-1?Q?nyeaoX8L292vpkKxhAXFpstKezAf6pL0c2WkC6qIIX9KIE0jHN35UkHiSe?=
 =?iso-8859-1?Q?7XnCzmA8SaZpiZe9xxCwzU4aW7f2ttJikXgsEu4yvtwNScYIvY5kqY2tPe?=
 =?iso-8859-1?Q?xMMTQXnHRRNEPUxaF2ELdVxRV4tjBXmck8Nz1FofxgV76WGtGeUGqgfDSI?=
 =?iso-8859-1?Q?EdJXvB5Q8mUV6ae2oBcUlyO+Yn/jgkb777Sw7d04fbAIvH1vpEnyOBeu8R?=
 =?iso-8859-1?Q?Plf+VMCfuw6FTPIqld7GpeU/9DolsofPGUT0adOfdY9tPLoJwm0oPPG5LF?=
 =?iso-8859-1?Q?ANd9han/rSvFIaw2Zf4X86Da/LQIGAUs7UyxCBkg8mXlVW0wfjMTpCg9o4?=
 =?iso-8859-1?Q?k1VjxNifJCyifPcvQkeJk2LRhyjw9ZPfpJMwmofK4RRmRnrpWvEfGiJTAN?=
 =?iso-8859-1?Q?Q4ALkCBMitMRvqRWHlEwLy9cKezHb58NpQa4W10DADpUKwVi9EI3xw+UpX?=
 =?iso-8859-1?Q?YcxPClpq8MmCfO6KfvVDlCUVyBJcbO5jZSUZ6gexI/mx3wHGoT7Jc4dbrF?=
 =?iso-8859-1?Q?25/nln0/3gwlIikZsYb9sEPP8fj9ljJNPdqHyhn+2+iNSz1gLVVY3I6aOR?=
 =?iso-8859-1?Q?lANfnRyQLGmOHDBLJXCg1eJgdC46zX1QEGHC4xkilQ2wcG/0tmADBVLiAD?=
 =?iso-8859-1?Q?iHdrxWmkY3pgy6d84WN4VsWJWlm27GoOYszQeVxk3qzHMUEpQJEG3wSJS1?=
 =?iso-8859-1?Q?QVk+FzNP/jLdj46FcVB0t9eOJKWH9QhYnio00cKGQ41m1R/8PgajUe8zhg?=
 =?iso-8859-1?Q?F1cjI853srS38+89mC8DJ+vd68DJDyWbaqe17k0ftKgWEZIIeGsdKv4gHH?=
 =?iso-8859-1?Q?34nIGAD9u/fKeX1XUDAXBuSLF3xckwgDkoWx7iORJN4UYH/8xg0pDlSSJY?=
 =?iso-8859-1?Q?VKpH8GI0NyQ2E=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8460.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0053527-6131-4b9c-5c2c-08dd49be0dc0
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2025 10:31:17.9384 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ty65PVUTZakO9BuPiTbUGhuh4CUp7FxyHcItIy8cboBUKJsn+lgdwvz18p/DnioW7xK3KtpN5auBlHW3lp8EMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8722
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

Hi,=0A=
=0A=
From: Maayan Kashani <mkashani@nvidia.com>=0A=
Sent: Tuesday, January 28, 2025 9:59 AM=0A=
To: dev@dpdk.org=0A=
Cc: Maayan Kashani; Raslan Darawsheh; stable@dpdk.org; Bing Zhao; Dariusz S=
osnowski; Slava Ovsiienko; Ori Kam; Suanming Mou; Matan Azrad; Gregory Etel=
son=0A=
Subject: [PATCH] net/mlx5: fix GRE open matcher does not match packet=0A=
=0A=
The previous GRE fix was meant to handle HWS behavior=0A=
and changed the behavior for SWS causing degradation.=0A=
=0A=
After the previous fix, in case of an empty GRE match,=0A=
GRE mask was initialized with protocol full mask,=0A=
Instead of the empty mask with protocol mask equals zero.=0A=
=0A=
The Current fix handles the SWS case as before the GRE fix,=0A=
and HWS according to the latest fix.=0A=
Also, combined common logic.=0A=
=0A=
Fixes: 25ab2cbba31d ("net/mlx5: fix GRE flow item translation for root tabl=
e")=0A=
Cc: stable@dpdk.org=0A=
Signed-off-by: Maayan Kashani <mkashani@nvidia.com>=0A=
Acked-by: Bing Zhao <bingz@nvidia.com>=0A=
=0A=
Patch applied to next-net-mlx,=0A=
=0A=
Kindest regards,=0A=
Raslan Darawsheh=0A=
=0A=
________________________________________=0A=
