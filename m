Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB5E7C282EC
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Mar 2025 13:08:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 02EAB410F9;
	Thu, 13 Mar 2025 14:08:39 +0100 (CET)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2044.outbound.protection.outlook.com [40.107.96.44])
 by mails.dpdk.org (Postfix) with ESMTP id 9BEE640FDE;
 Thu, 13 Mar 2025 14:08:37 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ryhMtxX+67eRC6Clr9E8sPVI+eSN/XaE4UnsTrixsQNsk1xouF/qoOJaoE95hXUN8BP0ErqgN0WOf52LxwOsYHCUD+5R/s/xZn2P17Vm4WqyoVFsq0e0NkYKtOZbG5ZAEAmFZjWjUk4fqnn3+rbozfFK6mLroDqCvxifGXiU3LtRzWqx+FxVxm06NUeKJ1Wl+rrXUKu59o6u3IR/2nUAVlGOAms9a2/D+0Z4Ji+Kpg9W+r0CFe/VfmjmQawW37UriagYheyGqcp1wQFuIdXNedjIIY2ng5BNSYDnuVKRVijmPdpDsd1deAb9753V2jqUWFcX9JcrHgPiu4wpRKevFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BzwSqJ6MCWpKf1jd8KQmEca3qPMbkPBfz1e0N3HGk+Q=;
 b=jKRYbUmZOsVMTZOm1HOMM2IY/74dZ2ddvDLKCWwJqvAedrZhYtRf5ryY/dV++BRKAIV6SqPCbCCopCvD2AscjMGCoKaO/dAS2heHO4MwfNnTgmdBEChNUqdugQaTNZw0wa8OCnawnKi524slGREWZvEz4KjewhF91JWqV8Ba9C5m0PkaXoPbBQkAYPnykAbRbVlaxPd9+IpvqeVMyY4ihjOWubhXwmf60egRHBAHEDz1Gl8dzYbeRmshS6Ram37QAONlkkU5GcC5qJyYVgaj8zv1czqW1d6mLv3qekaJcSH6PZ4b65x7LKSBPBLJdy+riLHVMyXyRKrwSN4e4JrnOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BzwSqJ6MCWpKf1jd8KQmEca3qPMbkPBfz1e0N3HGk+Q=;
 b=gqOqv1+WDZpmsgadrDhJNMSrEus8ORi/lfY3KCtPnwDGZzmnZ0Y0u+7Ch9tmOmO2Wp1p0nGlTut3ruuGDKsmJZOxizkPBhZYXPirW/AmAcyFH1EQsIGy8jrpkO6ellr0p+cJTs76bS/p9agPQgYJTRQeQlTqi+HtOzd77VlOdmHzq7FpTZfB+A7ViUKv3IUx6xzrYWp1LRt5wpngtDT5AgPIfRcNdxUG0+LhBt3U4sV03BVua0nRAvPm2BmlvfL9A6qITlFvD6kM9nlOqh2LyaD93p/THQnA+06y2S9EimVNWDtBMBdDVxan/mULN6mat7QRuVE5AH2kb9tx1Wq4KQ==
Received: from CH3PR12MB8460.namprd12.prod.outlook.com (2603:10b6:610:156::15)
 by DS0PR12MB8217.namprd12.prod.outlook.com (2603:10b6:8:f1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.29; Thu, 13 Mar
 2025 13:08:35 +0000
Received: from CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5]) by CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5%7]) with mapi id 15.20.8511.026; Thu, 13 Mar 2025
 13:08:35 +0000
From: Raslan Darawsheh <rasland@nvidia.com>
To: Maayan Kashani <mkashani@nvidia.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: Dariusz Sosnowski <dsosnowski@nvidia.com>, "stable@dpdk.org"
 <stable@dpdk.org>, Bing Zhao <bingz@nvidia.com>, Slava Ovsiienko
 <viacheslavo@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>, Gregory Etelson
 <getelson@nvidia.com>
Subject: Re: [PATCH] net/mlx5: fix failed to match on empty gre on root table
Thread-Topic: [PATCH] net/mlx5: fix failed to match on empty gre on root table
Thread-Index: AQHbk0FG2jo2vWVcrUa9UBIr5ezwqLNxC3IB
Date: Thu, 13 Mar 2025 13:08:35 +0000
Message-ID: <CH3PR12MB846088882D6672B27900917ECFD32@CH3PR12MB8460.namprd12.prod.outlook.com>
References: <20250312112348.61807-1-mkashani@nvidia.com>
In-Reply-To: <20250312112348.61807-1-mkashani@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB8460:EE_|DS0PR12MB8217:EE_
x-ms-office365-filtering-correlation-id: b2f6fa4a-1cd3-45c8-8870-08dd62302997
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?TgY0XtQZkh2AFcBOsqN9kQlcn/yXbqniOHeIL4yl88BUa8bEHFPzdELPmL?=
 =?iso-8859-1?Q?rjCpMm1895mBoWFwOei8Lb8qX0jYW2+KUl/ywVsPc70EfKmOHCEBR7x2IR?=
 =?iso-8859-1?Q?jg4aaBEqsPSla00UR3WtRH41Q/5apgkdPOemlzdkTgbPH4QwDPT8uX9l+A?=
 =?iso-8859-1?Q?ZGaGZx0A4QVl/VaVkaHQOhLaxD8azl3SmcleCla4sUPIeVSt6mVioK1Iov?=
 =?iso-8859-1?Q?FBQAlFtXVs9Am/GRmPrlgX6u/jgi3lAbY4EqlYThTCEyPv2l7sxN9Iwl9q?=
 =?iso-8859-1?Q?yL2hM+iOa85iM6F66zSW1/pKLUHNtHhGJPsE8VSBGvzegOtF2kY/8dterH?=
 =?iso-8859-1?Q?4EZpKzG1tLTLOHy9CBpwK6YF30Mg1xOUWd0yzvkhDhMQGg/k0LNva5qURU?=
 =?iso-8859-1?Q?OY3JUKyWqQrmvEHMoG9rWPWn5C8t1M1DgH6npDTMdDxY54I42vOijjfcFI?=
 =?iso-8859-1?Q?Fh9eLdeHDJ6eYEhiViG2WR61sbDojvwbBsNGAFfgydRwx6Cg5DX+VWR73k?=
 =?iso-8859-1?Q?8xzHucnYJSpYmPna0Q70OAiDQH1QEJE9JynTOU2FVIjJQOijEeVGY+2J/V?=
 =?iso-8859-1?Q?5CNJqHzLcuSeJYm7ouyqkrJpObMP8e4aGCSgRXfWJq6cAe5XuX4VnzSs52?=
 =?iso-8859-1?Q?s6ihw6Xz/fbHMWH0k6D9QSBMxeivppTtp35AvngNxOFsW7OmsJe5zpIX7z?=
 =?iso-8859-1?Q?oS+ilsLG+i2kdjX1s/Eu3+oLPjsX0TSZIOh9Kd3CY4V4uBd5m6qVGqQIMa?=
 =?iso-8859-1?Q?Cv8rhi0SIjdPKFNEL35OvJJ5WBll0qGtIdt+lg+2JfgNv1AW72yYn0hREs?=
 =?iso-8859-1?Q?YgNvoECaE+xRxMGTyJ7dkPjyWsR0/XkMsBIfXQVU2ImSDniKA8ZnY+6kSW?=
 =?iso-8859-1?Q?xSjTsKEkBAIVnaiHx5MWdLwuKPhqxr4L0V1zp3jm3FXnpFSvO+Rc8EOtXu?=
 =?iso-8859-1?Q?cDImdDIX977aaQVGkNOLoNG0Y9vb2gKjl4hAvn88o3XaiwKIZPnfWjXwVB?=
 =?iso-8859-1?Q?ZPB2e1IZ6KWMpBKYjLVqDwD6BURfP4ChLpGLkH0k/nUsbNeRKELiRv7PL8?=
 =?iso-8859-1?Q?wZ14dp2xk5Rl/INqUC3BwKDhsi0HyOs73yAJa5TtVjCHis0DlkrQuL43LX?=
 =?iso-8859-1?Q?+G46po4+46EC7wGa6JA8TmFohQNHWJNjasKotoHITQi59+UFQQwyYeof51?=
 =?iso-8859-1?Q?WO4QvfBu9k4uNFTakoh9bdn6ECB5oVnN3Q5iBGCios8MAj3ZVNk4jhFsvK?=
 =?iso-8859-1?Q?wwmheADhz9zK6hYEn7gbXXsrUdxrIhuAUS+rLaUsATyQtAvHI3u4Q10URB?=
 =?iso-8859-1?Q?UmIUKvTAtWglDNU0jPjErrktWPr89hXsWyb0XGr++uvDythYkZ5A0z916x?=
 =?iso-8859-1?Q?nPc2ArrQgrBHGcyk1hTpppPTU/Qchkn9FUS7ivUYgCmBeA1XBN7C4DUF/k?=
 =?iso-8859-1?Q?MjTPOXoFYuCv/AAx3gRi/IUaE8oS4hJvrxSUoB97bkt+LIiqAzn13aVyhF?=
 =?iso-8859-1?Q?vlpH+q8uU0jEbB7wmjahC2?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8460.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?lPVCvlIUJt6h9GC/PXWi79ihOcfICK2VD7cmWm76WVekR37q/4IjlszhS7?=
 =?iso-8859-1?Q?UbRLhuMmiNcO1BDW2S/DQ6S2xuJC7biExnci/FZzt0aRqvq4rbocZAcDOj?=
 =?iso-8859-1?Q?bcmUCROpi00e6MSnFivI5BDQM/kWli610yH+Q6M9XJibG+IABVOI8K4Cnc?=
 =?iso-8859-1?Q?xw3UVvmbCf3ziG/gulTCjMeqAQAJEeJiq4FbYoVfbSA4XtV07LvjtOQqJX?=
 =?iso-8859-1?Q?NgXtDrINpUdDHRtNz/CnXGooaUumpZLumkTZjtMGCxvvV27jIkKnX1M7Kb?=
 =?iso-8859-1?Q?n/TalM4l8v46TmXMBmqlsbXPjuhg/1UEOZ4UtmpY1mwAaicaAP32ZbIg5b?=
 =?iso-8859-1?Q?Q0u4MTyM3iz8O/j+IlNHevbyOaoiF0W6OT9tKtyn2Ay/Od0qf1pi1/6xID?=
 =?iso-8859-1?Q?FStNf309BMJnodLhvlyXqUpt+ppuEXnkMaq2KBGkcUzCKCMGpHWFYnInje?=
 =?iso-8859-1?Q?qmtsS314fWZi+qyLkhAor1NP43xhZuu+ctOVfb6hyfm2IyzzcE3VENXMzk?=
 =?iso-8859-1?Q?kLxO8S2Jy/vwDWankRuB9Plu1Evcqde9YntbZPyiemo0k9s2UJUTYXQa3/?=
 =?iso-8859-1?Q?RrJ1cvfZtXAKjuwe8PUBxZBKiZRtPLb7dXbWa21IuyX4dVOxoMAoc9gHxk?=
 =?iso-8859-1?Q?VV8vdWuKeqIxpT2hnjjpKhV+1TvosANjLPr9DwDj7YD+cLVsSjrTr5EUwC?=
 =?iso-8859-1?Q?61mgLmbVb0NxqRARH0/sEaFr07ju1BdvkH1j+RvSheZOsDoXrbWMW1DWmB?=
 =?iso-8859-1?Q?m7l8Q6l02SFAH+N7uw7M34oF9nJFv5i95C96Ui6FXiLYqLC129OPD2RjSk?=
 =?iso-8859-1?Q?WbsGnIdnDaFZgMjsX0joEezZRHX5yXq/DLcofaXVUb8VYlT2070pMuvUK9?=
 =?iso-8859-1?Q?i2MJ+ylQQTBun6Gw/bbTrjzsRSh7HXvggsew57inOXokcb9gxbijSZ9HLE?=
 =?iso-8859-1?Q?N9m5NzitXk0MH5slDd7WkHAIinVb1j8V9AzfZyNWot2KuqzWm2XOMUNhb0?=
 =?iso-8859-1?Q?MSrRvG1oUZDSTl4Jv7UR1FVlFK2F+8aIES2YkbelDjBE9esaS4o8jsGeac?=
 =?iso-8859-1?Q?8lqwB2IP6H2s6XwLl8Kqjscid6Nx1T5oCSGaPPgGcyf25G+82jvwP5Aamz?=
 =?iso-8859-1?Q?rOS8B+a4lwhRwto+JkdSUFCHzzS4c4e0vVTDuulql61wH4CFhpbDsn9/2U?=
 =?iso-8859-1?Q?1sTJq0sgkOI2HrHbcNaixts3jrYw6E1Zy66VQdiRWfpnp+P3Y6AqI05QFj?=
 =?iso-8859-1?Q?MsbQAjOT1VJAJHmOHeTlKu+tNMXPLThstbinRHXy4eG+++laEjgvD8OQaw?=
 =?iso-8859-1?Q?3WA93YNrmYeqqkZQfJ1O0eJDzzFYxoHvTOGdatnqMfvFthBymBEgWuAqFm?=
 =?iso-8859-1?Q?Gd7ODnMLF4sTQIgs1fzEL6Jv4UR4/ZFpzBDWq/9qkA5zikhe81Dxv4wcr/?=
 =?iso-8859-1?Q?k/bAWuz3dDIEy+nFQvOgwdTEXMkrFZ+XxkpxB+tY9GThsVOYpZhURxAd/M?=
 =?iso-8859-1?Q?4YrHbacE24UyNjABCoKFva0PHTq28Ffqbm/vvgsuBkTte2h/jdZCl+tlV9?=
 =?iso-8859-1?Q?VGFnpsPXSyum4lCsWphz1u7VfU7mb3fli9hfZz4bm6fjaRNOFjaMaU7gce?=
 =?iso-8859-1?Q?5g0w2xPI1AG4+NYmM3ZD/YCyjC16578yd3?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8460.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2f6fa4a-1cd3-45c8-8870-08dd62302997
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2025 13:08:35.1961 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RX6iWqzZe8pxRzaORvO1EQD8p/UfXJ6mgEb/Yc4pR0bEeOhEYAe3ZDE2TYQ38eOrohAxw9BO/pb7OdfUbAxz2Q==
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

From: Maayan Kashani <mkashani@nvidia.com>=0A=
Sent: Wednesday, March 12, 2025 1:23 PM=0A=
To: dev@dpdk.org=0A=
Cc: Maayan Kashani; Dariusz Sosnowski; Raslan Darawsheh; stable@dpdk.org; B=
ing Zhao; Slava Ovsiienko; Ori Kam; Suanming Mou; Matan Azrad; Gregory Etel=
son=0A=
Subject: [PATCH] net/mlx5: fix failed to match on empty gre on root table=
=0A=
=0A=
The currnent implementation sets a gre mask with protocol masked in=0A=
case the user did not supply the protocol mask.=0A=
In template mode, for group 0, the gre translation was called=0A=
once with the mask and later with the value.=0A=
with gre open matcher(mask/value is null) default values were assigned=0A=
gre protocol mask=3D0xffff and gre protocol value=3D0.=0A=
=0A=
Therefore gre packet with protocol value not equal zero,=0A=
will not match the rule.=0A=
Changed the default protocol mask to be zero instead of 0xffff.=0A=
=0A=
In case of empty gre match,=0A=
this fix will ignore the protocol field matching,=0A=
gre will only be matched by the IP next header field in=0A=
previous header in packet.=0A=
=0A=
Fixes: 25ab2cbba31d ("net/mlx5: fix GRE flow item translation for root tabl=
e")=0A=
Cc: stable@dpdk.org=0A=
=0A=
Signed-off-by: Maayan Kashani <mkashani@nvidia.com>=0A=
Acked-by: Bing Zhao <bingz@nvidia.com>=0A=
=0A=
Patch applied to next-net-mlx,=0A=
=0A=
Kindest regards,=0A=
Raslan Darawsheh=0A=
