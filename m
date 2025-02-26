Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DECA5C021BC
	for <dpdk-dev@archiver.kernel.org>; Wed, 26 Feb 2025 09:13:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3A1434029F;
	Wed, 26 Feb 2025 10:13:14 +0100 (CET)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2045.outbound.protection.outlook.com [40.107.237.45])
 by mails.dpdk.org (Postfix) with ESMTP id 280C94027C
 for <dev@dpdk.org>; Wed, 26 Feb 2025 10:13:13 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yXd5CXg0V6mHL0vlmpqE5nzphUCqCM5vzLHmgCs8C66w/TLnZ/7HKbLXFQy6s0NM8GWqO1HjNRcQICoF92xwiI21jIiswvm8MYTMO+kBt8NLFBk3HPt4vpGwg4947N6NgB52f2yVnUM3XnMrRGutL/Q5zfDvaOxb1YVbIUVDJEk3ktyaedgUjXTgEvqRiHiFogU6+3vF7LVwwsusYl6P152SxXPkdbS0OCGvayUJb3xqStq2qaKhbZvEJRPacqc6ea9TG0Bj6UQIiYHgQDbeW0NWD1h5DJnWC6T+H7rt8Unv1tYDBVRyAg1GlVFfs+I6GItEGEL7HxJ1rRq60KLOIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g7+FaaLph50hmzUVfLOx8oobaOshyGxN8eCgi5zKj1g=;
 b=L1+3J+UH29wCWn4rO6wfETucIT204WyfO3eqcDUpmaiirodAtjGxUrdXsBm9i/0NKCRuKF+cJ+mjnegErfQmUqBycb7co10sX0j7UrCao8kpQAb4nrcTnBZmvDEVy7aZ6sBL7nJlB690ffLfZCjYNDczT9kAVQ72FK4jFpaMEQtKt7shmy0ldfYcMGSvtzL7H8yfvluisJhUUAMalZ81bpxuq8eLpFczZ4BEGU5CjdBEg6YrzD8+NvzmTm1RlZ+xQnO7wwyIchteuCG3FAtcfMGz4I/HGBt54cxY/w4BeeP5YFEVx7PI+VEBXQ1/3iChLg7W9fn6aP41EBdQt5lkeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g7+FaaLph50hmzUVfLOx8oobaOshyGxN8eCgi5zKj1g=;
 b=WuU28dDSgfHP3fbj3vHaDESL4++Ogl6QmjdHlKsQqIR9pnCAqMH6NFGXHVl9Z9/Ml+ZGLIMZHnN2KMIkX1Mz5yGPCvRSGa2z12tXzHc6ytj4a9NCicjo/KoGBULjyZ2SL/KnsliBLoMkVdX/KDfEHIko/UDXAITCZyU1EpJHYAtXo1iXMukiordtU5rH+cyOoyA8ZLW3VNghspS6n8JTAYGJyttjfpbkxz+BXCNvsh6pzPlWjIYt3ExWiSIRvwoPju0UmcYKLyFCSc0PUNDTgDctuIHU+ZbfkzMGHCQ/jfS0F05ynNAM6Tbc3db41tSLR+jKOP/uOzXMzbxciqOthg==
Received: from CH3PR12MB8460.namprd12.prod.outlook.com (2603:10b6:610:156::15)
 by CH2PR12MB9520.namprd12.prod.outlook.com (2603:10b6:610:280::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.18; Wed, 26 Feb
 2025 09:13:11 +0000
Received: from CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5]) by CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5%7]) with mapi id 15.20.8489.018; Wed, 26 Feb 2025
 09:13:11 +0000
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Ophir Munk <ophirmu@nvidia.com>, Slava Ovsiienko <viacheslavo@nvidia.com>, 
 Bing Zhao <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, Raslan Darawsheh <rasland@nvidia.com>
Subject: RE: [PATCH V2 2/4] net/mlx5: support FDB unified domain
Thread-Topic: [PATCH V2 2/4] net/mlx5: support FDB unified domain
Thread-Index: AQHbiCoHy82Miu79mEuXZ1L3IEX9ybNZTPMg
Date: Wed, 26 Feb 2025 09:13:11 +0000
Message-ID: <CH3PR12MB84603774A43EEFAA3702F143A4C22@CH3PR12MB8460.namprd12.prod.outlook.com>
References: <20250225120213.2968616-0-ophirmu@nvidia.com>
 <20250226083846.4023622-1-ophirmu@nvidia.com>
 <20250226083846.4023622-3-ophirmu@nvidia.com>
In-Reply-To: <20250226083846.4023622-3-ophirmu@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB8460:EE_|CH2PR12MB9520:EE_
x-ms-office365-filtering-correlation-id: 45f82f0b-8990-423c-4d76-08dd5645cada
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?mCOJRI2mFj29gpbyGY4g05wQ9ModXwBEaUpjqvsfVIIirk9k4wTpb5N1CXd8?=
 =?us-ascii?Q?kdcmELTgEMo3ftoVDFmDJMLrINAng+JE5+rzuIiyM0t0EbDlPmp1DnJtIV6i?=
 =?us-ascii?Q?N/eumjzkjhKwMVj9GUeDbRfn9X349N7Ah+TMrIAqN0ZtfnWtXcUIzGqvxe0H?=
 =?us-ascii?Q?Jq6vAqbn6YLzb5kW1PN456tMMvV6UxuG8/5U3+kCIKe5u014NHfFRLsO+bE4?=
 =?us-ascii?Q?JYZrR3749NWiQ7FknY+d2CuvqA+rMnG2U8661C3UduSfapCMgLHQiACIUr7B?=
 =?us-ascii?Q?ggci8G/KzbFEZmaSncEGmTU10P5EP88kA0BZd4Ovy+3PKb04vfP8RxyVs/0L?=
 =?us-ascii?Q?XcNkPbE1zxHsJLAp9Izg5mLdy2Okpjyy9OeLR6ViDs9tlctVRx9Zr5wfrHSd?=
 =?us-ascii?Q?u6ZXa8LQe4QCRNSbFdiKGtH3rk7Lxkgs7P62py7f+4jwaxqcG/Pgdf7Pc4L6?=
 =?us-ascii?Q?uDEx/IfIXYfgqPBoopclXqlt9pPJ/e0zZuLOjoRtGyMWqZAnxlMbopEyHjra?=
 =?us-ascii?Q?FJ3p8mj//FHNq/477TftbylO5FaBRzE5D7cDK/PfSZ+xe/UW4BGVVwHcDIGB?=
 =?us-ascii?Q?QdGXsfIa6EmkqZVHcXzcY3qpwpKh5oBan1PGKyhYlk3Uu3/jF369+vQotghe?=
 =?us-ascii?Q?ILC0q0pJ49yK5s3XST+xyUFTZHGorKXq/DFgKlfaQREVUhIZF/DG8mg/7vAX?=
 =?us-ascii?Q?upqKlKhGGptGN0M9d8MC/7BZwCy0S4jMy3EhPxcNp5v1vmJAcF4Zlq5SX0tV?=
 =?us-ascii?Q?qjEtjclXD04z2dcVF1cPk6RiavdKaLKNlW10yTvCOAwkPNm1TDsgxj8B3Nbq?=
 =?us-ascii?Q?BGi+XkH1HrQtOi/j2aOtM6wqGHdwbznEtf1wJAtTPbqMbdcV4W+IhKHYLYBy?=
 =?us-ascii?Q?wghfD2hbjAE8YynximfS66C2NPXr6yGhqDZ4xe5EbGq1soCOH7HHnn6WEMpJ?=
 =?us-ascii?Q?Z85Wb3FTRLzalwA+N9VdRZ3ZidZPLQ/nMmEE2k+1IDnVAJH0FbrUDvZxlN25?=
 =?us-ascii?Q?MSOQGT3ThdvRFsVBYHC+hR9Wl6ISdq0ccg1ZcWQtylUW8AOGlSb6w/O+wv5O?=
 =?us-ascii?Q?n4T03164KEO3vKWvuKK2jCwJ0LGsc52vBVMlYok3Sw2iQZTQwPOs5FLZiqdi?=
 =?us-ascii?Q?vs5mnk3g+0O1w1AeHrI9420RZ9OPvRFSOKXN3IHwi4nA/yruzWtyjmYSk5CM?=
 =?us-ascii?Q?rcqeObakyaAfpNceUhYy0E5ntaybvRWL2ZrjNce06h5E1F8SNf07VawLnMYF?=
 =?us-ascii?Q?lWLGDXdZqLJHN2eyIM8+1kS+JSENhy1/WPbdK60Tp4FLsAuX1cEa2XkMGfcU?=
 =?us-ascii?Q?zrLIrWjnRZnK8hwaftREk1EADL2s8gCqHPdms5FUjQxLmOKs34/w1mp428v0?=
 =?us-ascii?Q?5NMGsqZl2O9eoHmZgzfKyM3ooUUdXndK9w8FqZHeD4Ob9uP4Cy+o9ZVMh2pS?=
 =?us-ascii?Q?o/OUlpnDueSaYyjXCkmKGoy6Zwrxi3GM?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8460.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?uHTNiuaB9Jbi1/KY/PzO95takLrs+m6cy1LxQ4nQCA31M9bZk8xU/qYfN+vx?=
 =?us-ascii?Q?PdgPY1sO2mR1uRGclTPmZVvjOttOP/flf/PKKiLG4vNWN2Dx0PUAvGFOmVHz?=
 =?us-ascii?Q?UyT1CC3sbfQHjzK29nuFI2xjwAQaghSf6zO92uJBRrlnleiRu/kEtq2RUMSd?=
 =?us-ascii?Q?bBt4gN0aAYRLuH5pc43/4WebYXFChSD8psz/5D+CRwhKC+yS38jEsveUEol5?=
 =?us-ascii?Q?yRrPvaRjhA9V/xMtKLAUlAcuRG3YL5Y7E+Mu8PAOdIkBPIycaAWzdnMjntdU?=
 =?us-ascii?Q?dJXfmvr4lQxdgKBMysA5HwuZYJQIRqa2CmqrKrXaX1K+48JaXLukw9ZLGfur?=
 =?us-ascii?Q?FcndPmgHH4Pde/L5pItoq19o93yME1m6oXDWF/Abswd9HiXa9wxoi3ei/asi?=
 =?us-ascii?Q?a4boZNEOFnfwj8996Iub7BNcFbd4nLr1XFBA+D1ObD56sdJQnsnAGkOC9X6H?=
 =?us-ascii?Q?c3VYi/Qtfw6StUjbFgwGHfYl4BtXpx/IDaU5f5+vh5KNLfE6v9iAS+TyBqgA?=
 =?us-ascii?Q?tqK0ITvLQT5EhLqMmKEz6LDPmpZpvHqfKtC5AkNehIVs+i6cvtRQkZBdlV3A?=
 =?us-ascii?Q?sPXLeB0aS/o0JkDc1q4ZGSh1ipBGoB0cAQR1LJs373oZhwp3lYsRUp1QZxL7?=
 =?us-ascii?Q?HHePamhQQPdOsAqlvzpoZzBvyXzEHlOYBDt5koY8HJ8Vcr7GfNdVjGJWRfZR?=
 =?us-ascii?Q?36qzqvSR88+9SYaC+fmuHAYCTdSyjU2zZbcszPaTUmcQ2OU8yg+SLBAaCoAN?=
 =?us-ascii?Q?ZCBj6RrvPjn90WU66xDcG6FATP82h9afbrs7U4gxzXOEyunea/wFlfWqzUZx?=
 =?us-ascii?Q?Qlp9Yn2+/wxKD0ShtehSv1OZKsj0CsoTFC3ZaocrpIjeNbn/B8ODLRM0FKUR?=
 =?us-ascii?Q?oFgNOAxXFbI7isbKGjF2e2i1zD8WEXV/SSYVA9yIoHBcFeIsjOdOQAMnhtL+?=
 =?us-ascii?Q?mKEimndRxRRgC5zEY4fm1Pr2hcxjOR3lbLWmlhInCw42JoOYWuAEbWKvD6Id?=
 =?us-ascii?Q?01hMa3GX5XIuCRjcIe/0Kle6NRpOoqlkZ4Djf65tHAKdljvHsxkXNBjKliI4?=
 =?us-ascii?Q?7O8T1itc27ttLxw24S4AMT2VXXWrhllkOurRMzoOiqIPhlQ2H2gxb6vasJGG?=
 =?us-ascii?Q?X8618vBMrCcyeVDaHcGLJpQoatapkn96BLK0cN0vURwRjLAIBZBxOd4IsDk4?=
 =?us-ascii?Q?0CLrgK3586bVUjoHQlebk7DeMZYCZuZ7EuZiBMcZkXFo5znKiVidd3fjkyjM?=
 =?us-ascii?Q?h7HeCOxt3i8mhyVVK9A/dHd/qJwzq+OObPGW0VhvIRgB5RWTJkd3qwGK//Y+?=
 =?us-ascii?Q?Bwl/S60oHwpmJtRYIxauRW0+bWUKYcfy17zkCKaerIKIE+jhZX1PoZXZNeLP?=
 =?us-ascii?Q?U0HIa034Gfw5nXFeBjCsWNsK/1VtS73DV+O997oKBdey8SZ0hXNzU4/WA1wj?=
 =?us-ascii?Q?ofiJ83eaHfSeX2HB9qBktD0Aw27oazZYlqKCon10FnoN1su1l2AZnXktfu8q?=
 =?us-ascii?Q?t9LDcMwxuTw6VzYENiE7QLW4KSFrPjoTuBIIKB9Qc3Vctr9Lp3S9ylDyvZGR?=
 =?us-ascii?Q?NrntU9yvxUuSitVDwLHffQJc/HiRLC7zuBcwA6Tf?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8460.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45f82f0b-8990-423c-4d76-08dd5645cada
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2025 09:13:11.1959 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /NAPkUB9RjpG9/YIMwfK/LiwjsXDLhe8EBUY+DGlh0Ek5TWADfFOLTcCSPDYK8Fv07j2uW/MFfRdep3JMIpUXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9520
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
> Sent: Wednesday, February 26, 2025 9:39 AM
> To: Dariusz Sosnowski <dsosnowski@nvidia.com>; Slava Ovsiienko
> <viacheslavo@nvidia.com>; Bing Zhao <bingz@nvidia.com>; Ori Kam
> <orika@nvidia.com>; Suanming Mou <suanmingm@nvidia.com>; Matan Azrad
> <matan@nvidia.com>
> Cc: dev@dpdk.org; Raslan Darawsheh <rasland@nvidia.com>
> Subject: [PATCH V2 2/4] net/mlx5: support FDB unified domain
>=20
> Legacy FDB domain is enhanced with optional three sub-domains: FDB_RX
> FDB_TX and FDB_UNIFIED. Based on FW capability bit mlx5 will work in eith=
er
> legacy or unified mode. To work in fdb unified mode the flow attribute tr=
ansfer
> bit must be set and the fdb sub domains are determined by the table speci=
alize
> flags SPECIALIZE_TRANSFER_WIRE_ORIG and
> SPECIALIZE_TRANSFER_VPORT_ORIG.
>=20
> +------------+-------------+--------------+
> | WIRE_ORIG  | VPORT_ORIG  | FDB domain   |
> +------------+-------------+--------------+
> | 0          | 0           | FDB_UNIFIED  |
> | 0          | 1           | FDB_TX       |
> | 1          | 0           | FDB_RX       |
> +------------+-------------+--------------+
>=20
> There can be no two groups which only differ in their fdb sub domain.
> A table must be created in a group which has the same fdb sub domain.
>=20
> Signed-off-by: Ophir Munk <ophirmu@nvidia.com>

Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>

Best regards,
Dariusz Sosnowski
