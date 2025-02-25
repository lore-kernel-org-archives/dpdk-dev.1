Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB803C021BB
	for <dpdk-dev@archiver.kernel.org>; Tue, 25 Feb 2025 12:11:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 324C642E79;
	Tue, 25 Feb 2025 13:11:22 +0100 (CET)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2089.outbound.protection.outlook.com [40.107.94.89])
 by mails.dpdk.org (Postfix) with ESMTP id 34B9242E73
 for <dev@dpdk.org>; Tue, 25 Feb 2025 13:11:21 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aWLe7ZumYXXzr/FvYDYkRdGiRuLTEin7MMdwNudCdvhUbROcOm4dTaxRDi57MOMqj65lk/icEE63tUzvG7ugF+JZvvT1P7fESZgdIDod0KJNzywK6DazmEDqVGbWmqc2ZnsA1xd4ymA5WRewnixfNKvhSUG2ANTFx88GBAzZMaUYXUgOBAlqZdU8EeT2zxUliea9HJlXhsWZwHmkxSCcefFMtyWNqB6voS55yA0OvRbF1B7tUCZndPCmXdQobXZZrGEkKEqH75TU+nf+dEM+jzI8zBFBHKjbZ6GVtbUYE0kzNXrAUs6Mdeko2w2Gs6idBhSzFJX15mJTzDdEPX+L8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vaae0yKM0uOuqfe1H3tH4lRk4hL0KlRzZ+yNSZIUpUo=;
 b=N55u0fGOIxHi8unxv9QRfQP4ZkwrWTUWJpt5e5klMbv4lLjrbtou8wEYJJ4e861TCJLlISHQ3tCezNVtEijzCluzszK38ucDv06T9tRdb9Wp31TBGoAHbE3JNx4GwaW7TCV//cEWAmp9k0iS+hLh1KZkRDhMXOPLQBeOTbRTcmY+bWTnMgM6fhwjdilIH98oBhGTjRjHPyrF+Re9XDbO/Yjy6++PV8seDNZ4Cb+EazCDIihEmNF/UxaXskLJyBf1HxW1QgN0FZl0ccuPbQmLzSAFh+U2r7OZzdmcirmjya4akHHiagGzZZdirdDY8KnzSaxTBygD8FgAY2qF6Fv59Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vaae0yKM0uOuqfe1H3tH4lRk4hL0KlRzZ+yNSZIUpUo=;
 b=VKccbbr88NgpHIVPosyBLSp4T+m8x8TQDqmxeIde+GdQgu32SndUMdrqI1D6UQhw2iZJEhwqeWkfN2ov829iyyvL9+56cuuj+4bTcvLlwsPkN2ZHtBL6n12efTFyiXydvOMzliy34A1sBBmtTMKBAqdw0emto9m76vhQc6n0dC9cFyHFGGa3jYICrRNjZDVmNtG0GYWRfnTsSMCn3hQkVEytmyJTVdqzd39ZrAsSpCLiJioiNQujkdNJAxkGeW5o8mYXTdTy5AkA3/Ow4HTDaZNMlMWp6dy1QKsmCl1pUAXCxEEsxvpezzmXwuXsbUn9m8rd4mQwdY9CCXNrhPkDUg==
Received: from DM4PR12MB8452.namprd12.prod.outlook.com (2603:10b6:8:184::18)
 by DM6PR12MB4236.namprd12.prod.outlook.com (2603:10b6:5:212::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.21; Tue, 25 Feb
 2025 12:11:18 +0000
Received: from DM4PR12MB8452.namprd12.prod.outlook.com
 ([fe80::b341:6309:cb1f:5b6a]) by DM4PR12MB8452.namprd12.prod.outlook.com
 ([fe80::b341:6309:cb1f:5b6a%5]) with mapi id 15.20.8466.020; Tue, 25 Feb 2025
 12:11:18 +0000
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Ophir Munk <ophirmu@nvidia.com>, Slava Ovsiienko <viacheslavo@nvidia.com>, 
 Bing Zhao <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, Raslan Darawsheh <rasland@nvidia.com>
Subject: RE: [PATCH V1 4/4] net/mlx5/hws: allow different types in miss
 validation
Thread-Topic: [PATCH V1 4/4] net/mlx5/hws: allow different types in miss
 validation
Thread-Index: AQHbh31WDUq6X8Eg102K5xBsvnA2P7NX7b2g
Date: Tue, 25 Feb 2025 12:11:18 +0000
Message-ID: <DM4PR12MB845242F98FC25C576C49D79EA4C32@DM4PR12MB8452.namprd12.prod.outlook.com>
References: <20250225120213.2968616-1-ophirmu@nvidia.com>
 <20250225120213.2968616-4-ophirmu@nvidia.com>
In-Reply-To: <20250225120213.2968616-4-ophirmu@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB8452:EE_|DM6PR12MB4236:EE_
x-ms-office365-filtering-correlation-id: f387431f-81e2-458b-7eba-08dd55958290
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?o+nLZFDgQOLsLjgklqLbDIVfCLHQpJGH+P/NZX3aNrVOV8xk3OIQkaL5nzvZ?=
 =?us-ascii?Q?ekeMPqLT7rZJuhhegcIL7TmLgVBA97MM8SirS+vtP5KLaDt0hR3kiqZymkfs?=
 =?us-ascii?Q?FpiGDL4er3n21SHmKSUEtZnpFiUGRh6EBH6L56kt4Lo8JaHkIT4iEKS2C63c?=
 =?us-ascii?Q?c8UTYY81K9iqd4G/Acv3mo0QrkJl/eNvRV5620U08fmm16SOMpY4U4DNJVY2?=
 =?us-ascii?Q?7k7DTO4ntXwjgYCrHAjzQPlQFI+dVOFB5+TyEZqrFvIyNpiWvPZ6tViWW1lX?=
 =?us-ascii?Q?PcFGftvn8T4bzNYZbjb7J3ku7CVnwsAjXqd8M9Ergdp/BahZMGIelwE2wx7e?=
 =?us-ascii?Q?HxAARULyX7uLDOlWIg3ePEbRxQYwlSjBE6C974FWi9DVTq2Oar6SODDlwes0?=
 =?us-ascii?Q?MD3urssQGQwP4ViCPzxGp26B4DwrT7lSHk+TJGDLRGS7z+c8UPerbRjmT74h?=
 =?us-ascii?Q?kT0uplBTrdS6WfAVN7sRfQsXBnAJNs8relDquZx6h0+X9tdbBktd40jALdvl?=
 =?us-ascii?Q?7gvoX196rO4E6f+T1p/TU/xmFOEQjg99psK4X3GLwbLm+7cyC2lgudjXU8pj?=
 =?us-ascii?Q?Jet4ZtWTm3h4SFEnamiSHM4MskhLqMKuwZQWfLvQZJkhh/hiaoExFBOaVF8m?=
 =?us-ascii?Q?8HQJgY95Dh082rpvMtYee377AuNHoL3tmBp/X5QmUd3yZFF/PReOEWbtT8oG?=
 =?us-ascii?Q?iVcYezVC4729D03d+a7u2yTtvkGeTpq7dAzU/WYrpvJL4/C6Gd9lr+swnlor?=
 =?us-ascii?Q?cb7cruW8n/pnycWa4hgVmEg2+E6/+KklHYuy8MxsfLH6xEzeNT9CJvz/U8Wo?=
 =?us-ascii?Q?aiiUhdyiOZOE/gjAxsrAc+f7fPPbnEe68s161r6FrHZpBv2M2TjsmtSQih6H?=
 =?us-ascii?Q?kT1iZ/TAvvSZoOQy+r5+BK+dGT4zDOfWgFHtWm6Uk9vSoj38ANozoWwSIMSg?=
 =?us-ascii?Q?gJgQDTumTZIi919Xwps58Ez0Uill2iPFGBnyh7w4N17fjjigkcStqI2OZ9lU?=
 =?us-ascii?Q?czpugnyaJz77ccljt86EcOs+OluXBEye/9n1nw8R1WAaYZ+INtt01CA4x9sB?=
 =?us-ascii?Q?exxDMkxQhiC7OCgr8BSjABDnC6Yqd2Dadk6XGUEDsuufc3KzEsYpS7hlTnHb?=
 =?us-ascii?Q?xWFDnNtXq5wpF9bF8ir5fB5rz5/RhJH+vdwFjf1UcNP5ROYKtOdKwRF2jmpd?=
 =?us-ascii?Q?+ahtsoDLA0ptcZvcwpeSUWQ1tHHDrGh5QwcjwP7ZMuaRH39UiMfAyI5YD0rl?=
 =?us-ascii?Q?wOs4bJIWLL/2QJmWFJZ8Qz9gKQVqTBtk4kfxzVc+Nu1qxA0Uusb02aVGXsyC?=
 =?us-ascii?Q?lXztMdGkLW4oov5ivzGdC3YL/f2HkpNjeZofSkU+Yg9BemxMZ3Rav+FTi+rc?=
 =?us-ascii?Q?6+wFYMzUmHkkHIBjeaQr9+vLznotkuty8/CT4RbyiFiaj8mw4cLd25Vxfxeg?=
 =?us-ascii?Q?WWhFVGL0ax2xaLJdPeK7bLktooXWR1oW?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB8452.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?bfZkyfcgB8rjj/2CH7oALh6//TMOgRAXUlRx89Vmanv7nWZwKLYlOmn7WPcr?=
 =?us-ascii?Q?lQ94dWk5tKNhMYqkeMlaCZLdrESGefxX1upBv+Qh581B+zu7kvgAhaD8Vpkk?=
 =?us-ascii?Q?5RAntR6gVpmOjtwtRFCvgL8lhOu3NXeXqvUvjHY6MnML6VG/9KKaMufmr86G?=
 =?us-ascii?Q?j3tUiVGUl184ywMuGGxvFQQRYqmrst9e7ja2vRvuV8OjuRKM1i+sY1YFhXvN?=
 =?us-ascii?Q?k1t7yhwFSPFS4Kz1u59uyJ+Ld+qsNJ0Yjn563ZJqFCgmB+2miZMtLXPgT2KK?=
 =?us-ascii?Q?X4UGhCN1d1tOUSLDBxAKCW8RW0PzSAVugIYpeeSOouyoPRQ1XEyg3CbiFw4c?=
 =?us-ascii?Q?70O4bVsBSONKU9DyseWsGJCadXdhENlu7IVloqxqNl/Wv1JYyR2tV0ZwOezv?=
 =?us-ascii?Q?+8adtaqkraIacvkl+zJdqOBDU8V0ztjvTXsYSc83wlymT+gvAorhvx2cZpao?=
 =?us-ascii?Q?0fL6GAqvuAYW2Ss4MxuEqlriotYyFDgOGY/xfryrhGdnykTZh4vqE7i7RPi1?=
 =?us-ascii?Q?dF85qISd8jylvNI9AZ+A0p83krcf9f4DBvgOYiVv46SyEwSXCWHCUScc+QVT?=
 =?us-ascii?Q?IdsO4fG9nEBJ6O+Ajlbz753qeBLcNu1B4tlaPYTmVWBut43HgJGUsJvdY5jY?=
 =?us-ascii?Q?QlRoNcOEBgV9EXBHbXYa+t83Z8vANMAyMz6EeodMZtALlvvubqxlvcRnPVpa?=
 =?us-ascii?Q?KCrcenGKJEo3b3XZ5HT9NViel2n7ukevCfhQPYFgKjh4AR4yB59DVsuoldn9?=
 =?us-ascii?Q?RcNSQQxKhgnaFUcBei+7ZUKFysgeTFveJSUMoUsPxxsAi02bdqGXjV3pdu1l?=
 =?us-ascii?Q?mu+LElECRoApr51THXIy1DBStpmmOerDW9g/O0ord1QrGMD/k6XzjaZX4vMR?=
 =?us-ascii?Q?/7+m2mViJ3TvdD5VKAXgvYH2mA7ZI8o948yD9v6qcMBvxYm0kiSzV81BByqp?=
 =?us-ascii?Q?adU9Va7DOtaYyQ/8NhQonVOUzjFdbX4eXCdgk/2W8O/cSn9LUn28A/FSe/YB?=
 =?us-ascii?Q?av4VWNb3VprsxyC5VYd0p9gvL0J5MtQxk0Jr7NuNfa5tecqG+fUOEFYBLkk8?=
 =?us-ascii?Q?kiHTbnQQnIYirMFn0ZTyFF9oACQDX8ybWeFTGuzwJKPGojLKWmXMzZyXmIG3?=
 =?us-ascii?Q?NvWAi3yjpzUl7iq4Tsg9A+81M/SswULFIxUAQhna7TuA7OmYnJuyvxVeOVwq?=
 =?us-ascii?Q?byCMq/5lUP5zNu/EcSyduGQfS9V1/94FwbfiLbgtv3uoOF43M8v8NcuLw1jh?=
 =?us-ascii?Q?qairVAu2r7h8YdLECwV/mJBABp39vc5WBSL1ACT6PIS8JI/yyifUJzps66q7?=
 =?us-ascii?Q?6ubcmQzQnijxypPCHSdf0WNXEdn+T+2+AFIHo+RjiYm4lAcyKqHY3GwT9/vY?=
 =?us-ascii?Q?vJ+CHwpOiWKHnKGRRrXvQx0eALeg2apAD0pT6swstjufdFobi9wvDdR95zFA?=
 =?us-ascii?Q?JVh1HKUGPljv9pqITGQXg9hA9NJW9t1Gj3vtZ3sPXoqHrb86ozuRblKaHdWA?=
 =?us-ascii?Q?tyQFmpAMN0tHOildjgw2BpAUQoQQ0aHrCCiVZgPPzIGOnSLnIV39zvssDqyR?=
 =?us-ascii?Q?jEI7ZAl9g0q/dxrD8uPl1CcxAWXsVkn6qoS6YWi1?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB8452.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f387431f-81e2-458b-7eba-08dd55958290
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2025 12:11:18.4899 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qH/RSW3gJTUQS7UUuXIdrei3qfq/wokBW4tQxXjfFIDDQBz0e5kdhJJ2I7GBc3xVD39N+bNyc+e14GVZJJfbGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4236
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
> From: Ophir Munk <ophirmu@nvidia.com>
> Sent: Tuesday, February 25, 2025 13:02
> To: Dariusz Sosnowski <dsosnowski@nvidia.com>; Slava Ovsiienko
> <viacheslavo@nvidia.com>; Bing Zhao <bingz@nvidia.com>; Ori Kam
> <orika@nvidia.com>; Suanming Mou <suanmingm@nvidia.com>; Matan Azrad
> <matan@nvidia.com>
> Cc: dev@dpdk.org; Raslan Darawsheh <rasland@nvidia.com>
> Subject: [PATCH V1 4/4] net/mlx5/hws: allow different types in miss valid=
ation
>=20
> In validating Jump from group A to default miss group B DPDK requests tha=
t both
> groups types will be identical. In practice jumping from FDB_UNIFIED to F=
DB_RX
> or FDB_TX group types (or vice versa) is allowed.
> This commit enables this jumping between the different types.
>=20
> Fixes: b81f95ca770d ("net/mlx5/hws: support default miss table")
>=20
> Signed-off-by: Ophir Munk <ophirmu@nvidia.com>

Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>

Best regards,
Dariusz Sosnowski
