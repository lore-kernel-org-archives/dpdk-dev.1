Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60E64CA1013
	for <dpdk-dev@archiver.kernel.org>; Mon,  8 Sep 2025 06:35:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7388140264;
	Mon,  8 Sep 2025 08:35:40 +0200 (CEST)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2052.outbound.protection.outlook.com [40.107.92.52])
 by mails.dpdk.org (Postfix) with ESMTP id 24F8C400EF
 for <dev@dpdk.org>; Mon,  8 Sep 2025 08:35:39 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tVJT3J1Ct6eM6IRhCwMq2JgwUyVM3rNvLtJ1ou2EU9Bi+HKXUWr2YwSS6Y4qG7Dy511q0Br6sF1GeJjy93X8Xf1BSWoGWD7mCW6B4G6KLA6oo5vvnyI/Cvb8+eaI+MgqB2JyB1JCbotAUc6hrqdgUmEanFm0lJYtnytEd1LqPZqJyT/04KB8IxJ3QPn1n+/rgBb1XJraGtAyBGLSIM8wZAhcds8VjvGYcGC2oxoNw9yMZxOuaZPc7CUUhp8WahpstAsk5SK2h0Fzwzrj6v7ho+b5M7nzRwdtQaRWwGm6qE0RhbPmr50st48MFhTV7BjzzfNDKwtkhOc3LgyYXNLkGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vVih4Dmtsx/wk02YreQoA/isUCW38EA1moK6qqCqb5Y=;
 b=uWjQNvNgz95AyIxXm5QHShqzKdChZPHiaCMH9+EcwCOIx9M+Pg+LpppnDmD9S56s2Y3phAomTYZ4uCTzkggW+5XSLI0q40sHcRGqx0nEfTPJHPFTATsUksJl8leSgEJx85hvrHjPcyxvCGbzjTPdymps1y1PZmDoU3sQMa2Ln/INMhsJ91lvTG8QUGA0GuqynCZNZn9EzOcBR/Hy4SwG+FnzahEE+y92tB9lsVl5YOUUTGkd9+auyE0KIJO3M0AVbldoQ2QkKNRbH+lsSNzX0hLU1lD+8YrMsEII4vVomsrA0roj6YKrJgFnwV6PK8nHsOrYaDlfeobZro0UJ6/GtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vVih4Dmtsx/wk02YreQoA/isUCW38EA1moK6qqCqb5Y=;
 b=g1K1cmHLdWkGy+M68iBqE6AgU3lbS5nGDKfP0s7r9f75VnfDxa8l3jDE0LMYmCbHof6S7HV1T5wqOS4TXUD61LW80R34KskgB2RyU0A64D6b5HY8GMR8wD1hdDVNNVTdtObvh3JH0VZvggjP24tQXHW6brsdjwHywNkAfurf9rSEMUQqolQg//YwdVRAbwiFUG1vAtcxeF+5xD1lSzq5Ae9TTdQtYNJ52gD42ZvXWZBqUmHeeSjZ9JmIAUKJsf0kqqKrfiWGmLEh3JCqkb9zsDhhuISHSkXYLQFnDsVFmVUzzQPmPmhlwNt9OA29mXUwn2lSFRw2OvkVL5dXXJnUZA==
Received: from DS0PR12MB8561.namprd12.prod.outlook.com (2603:10b6:8:166::8) by
 DS7PR12MB8083.namprd12.prod.outlook.com (2603:10b6:8:e4::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9094.19; Mon, 8 Sep 2025 06:35:36 +0000
Received: from DS0PR12MB8561.namprd12.prod.outlook.com
 ([fe80::9b96:73cf:f78:e41f]) by DS0PR12MB8561.namprd12.prod.outlook.com
 ([fe80::9b96:73cf:f78:e41f%5]) with mapi id 15.20.9094.018; Mon, 8 Sep 2025
 06:35:36 +0000
From: Slava Ovsiienko <viacheslavo@nvidia.com>
To: "Minggang(Gavin) Li" <gavinl@nvidia.com>, Matan Azrad <matan@nvidia.com>, 
 Ori Kam <orika@nvidia.com>, "NBU-Contact-Thomas Monjalon (EXTERNAL)"
 <thomas@monjalon.net>, Dariusz Sosnowski <dsosnowski@nvidia.com>, Bing Zhao
 <bingz@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, Raslan Darawsheh <rasland@nvidia.com>
Subject: RE: [PATCH V4 2/2] net/mlx5: add support for flows targeting
 multicast MAC addresses
Thread-Topic: [PATCH V4 2/2] net/mlx5: add support for flows targeting
 multicast MAC addresses
Thread-Index: AQHcGMS7z7lwRX9kOE67zHbZQFrrarSI4+BQ
Date: Mon, 8 Sep 2025 06:35:35 +0000
Message-ID: <DS0PR12MB8561250125A16D0F42069D4CDF0CA@DS0PR12MB8561.namprd12.prod.outlook.com>
References: <20250825141322.974335-3-gavinl@nvidia.com>
 <20250829090830.1049176-1-gavinl@nvidia.com>
 <20250829090830.1049176-3-gavinl@nvidia.com>
In-Reply-To: <20250829090830.1049176-3-gavinl@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB8561:EE_|DS7PR12MB8083:EE_
x-ms-office365-filtering-correlation-id: 3e369f03-d9f9-408d-2126-08ddeea1eb3e
x-ld-processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?f4vh00Pbl2bCyn4JQj5Mfb6wjWxT3fys6ZG5uhPlyfZZwXHXJ4yt6rGVxCE5?=
 =?us-ascii?Q?Cmwq3Pcmwb/zFl7KYcQKhXAFwSKiDFizpLHO4D7CJftu5wMwnAdPXxZhVyY5?=
 =?us-ascii?Q?5Pj1MpR8xV9s2zZ9TUmNr3tu2VQhIdpAHqOvz8YO3PmQPJr/UE7khz4cHblX?=
 =?us-ascii?Q?c5ydCDVC3iyRKBAbhM9J10mQQSif6KSHODsNhONFgv3JwAc1d4b1ySwbK9EX?=
 =?us-ascii?Q?eOJ+VjKwW36nEP3ZPcb0RMMrCtfKZauUM4ACu9Jva3IS6V1lkCaPywpPIxgK?=
 =?us-ascii?Q?l/Lc2MZlI0HgCswAUJP6T030RqTTiQvYZf/j1azygtqa1AFJmE5qC6l1/Vyc?=
 =?us-ascii?Q?H6wsg4BNxg1gGQqEeEVj36/5z4DYSiVom10PZebg9RHIyp0LhD+KBDDlTLT7?=
 =?us-ascii?Q?MvOVV6JGGxmE7/Ihuyrwj0/bsBpWvYPpcqcOwJ+29z24nMcXXEztjA8OE8qX?=
 =?us-ascii?Q?mDyxR1Ov1GeJmA5AKFJ+cHGyO1vJcbbCe2p9B5bsN4NgMvxJMaIGILrTxaRE?=
 =?us-ascii?Q?ZTptmpTxRJn8X017lQjb5mYaDQ49XENMEfBV1aHxaYmeE4eXo6R5WL3qDsrB?=
 =?us-ascii?Q?Cc6ZcV14gPYS+S/x51kGSsptuAlS2RoLjtxW8JLsDPIQjLSArM0MiWH7j3EU?=
 =?us-ascii?Q?/+X4YQ8gc6z/UvdasKhapjFAgrUf1LRxSX2szWZoE75Md1sUEo00ktVqnopj?=
 =?us-ascii?Q?LfqHwgUXdQHa8ym7hXyQIpm1n2VWwDLRwHQJDiHs4MBUmK5y5cC+m+5TTYx+?=
 =?us-ascii?Q?YcHxrK6udndI2doEKE3r8lsNMX2a5Do+ep3L1ohBYZ9VLZmMG6NoK4K5AfDM?=
 =?us-ascii?Q?w3SHylEelSdUIxkY0hk+qrlV3QNwAv8yyH6o137qvRPD1jSeO5CLXtKQ1bwA?=
 =?us-ascii?Q?/XNwunTrk7URBmpmm4d4SuSGvYWU+m9x8yn+TRtwCxH07CsdB5rlpblYO9FR?=
 =?us-ascii?Q?oI0akPgqEuubqZ4RFts7cZ60210SfraNb6yf+i3z7XBXtmXD9py0Y5X3fFCI?=
 =?us-ascii?Q?4GTG25TJR2+srX1KfN404x87p2P3A6lURQauKXhxqWi6sRSACdRb16kYb9r/?=
 =?us-ascii?Q?LlHyu6Pr5rI/dwlVu8bepwWQ0RjH4SSB5okGnSGeHAy993otDYRV0rFDTef6?=
 =?us-ascii?Q?h5+h8uODpNeTLlUOHWs0TJ5BtaeMjGWVOtHJfTn8y0xxLdxBqslOJoZ2hJn6?=
 =?us-ascii?Q?aiHdR/7Bfg0X/4EO9AYE1TijzxZtTUU3YrvfAJYvY0HuI3U8w/5t54u/r12+?=
 =?us-ascii?Q?DnaN6RMU24c1lFPTSZ2O0cs1NmIzqy7/+MrkYIpJq6rbiASJ0A8W6CnqoiYo?=
 =?us-ascii?Q?5lkrB951mz7oF8qKY5PE9d362cBGvZDLrMaeSMy3w2BzfMTfEA6slKA6tIb7?=
 =?us-ascii?Q?POEnetBAwJR7d7VXHEl/NQ2I3NP3+g72kCRsD3X1Fx66y32N78GNjxJjM99S?=
 =?us-ascii?Q?L8HFk5dfns8vB7gKXc4+PsEvV5jAfbilP+27CdjHIrwEIUIHhWNukQAz1nqC?=
 =?us-ascii?Q?MTkcrhsAeLHsOIw=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB8561.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?GiB/Hp2y2WSdFD4E4aH4juWlbLsAggUU/dh6iyJze8dCEGPo8NMTejOGv8Zb?=
 =?us-ascii?Q?EO821T1hy0j8H/Rd2F1/QJxYV3s9Rkm07hwb2xHGwYIbhkpmE1Ey6ki7tzD2?=
 =?us-ascii?Q?5brorGDxz2wYtPNqfMYCMMzRJmNX9ck9l+rsPhQUidQ64zzq8unaA+17yQ2U?=
 =?us-ascii?Q?vH5ThJXiXC8o+k3V5/aCHt+MWlZiaGC+k+VJhMvZHJDNCQZ1vpvzh4K4c6XU?=
 =?us-ascii?Q?B81ubp+nPZoE3lPADkqnsMQVcOGfMfJ/vPgmfzBQrerigc2Yt5Gjrr71dsxJ?=
 =?us-ascii?Q?+O4UNV/tm8US6e4fV9HjtWjmwIQdnh1a3O+/EKJV5rJTi9rtdBq6RAJX8Tou?=
 =?us-ascii?Q?3CYWvMtJPg0G6L62gzrF7p0mcC3Y2pcE4fuH/Ug3fuO9SQdnPSRIm+LLiIto?=
 =?us-ascii?Q?GHfPXf5XUyOAvU6eMtE1DtDkWOyUK0KksL48aIaS65JSjFPvKH1Qs50jQ6lI?=
 =?us-ascii?Q?VB8TjgOn/NvxfS6iwRqFlVlBOXiCNrg26O5DHl1s/aEMe4xDVkwVCn7zfHFB?=
 =?us-ascii?Q?L9GONLHF5QeMtiA+cXRdBNTmubboVHsdtCr5p5vndoJIkUdbO+Xl2l14+VLn?=
 =?us-ascii?Q?B6qBGnPQvC1QFVXhMgLQfzeTUpXVxNm3DBoiNoHPkmN2KxQGBKocc0pEcYtf?=
 =?us-ascii?Q?2qNzTAQ1pKzzhgDdETBqdk40UwvA4CHkFEx4GBPNwqiOMDTuSFEu/rrmo6zS?=
 =?us-ascii?Q?yFqVBRHsdsjs6Zm+Av7P/OWbAUBdu+j8cKwhhzANVGL++2N8jABFZA7n5MoC?=
 =?us-ascii?Q?CSvDKqBqIBS+n0ylw1quWsom3JrGteaQYtAsFzrnk7j4zRMeL5wmF82PMbN9?=
 =?us-ascii?Q?e2HGh4mfkQGtt7vDknJOUSHWkBU100TSRrfQig/bZs1D5T5L+dL3iazT64y7?=
 =?us-ascii?Q?tUJypWkqQaXbCA/SA/GBjqLZBTacVvNo/g8hfZeuQxNuZPS+ZHn1yBMgUn5k?=
 =?us-ascii?Q?RJJKOQDPlVHzqJhs1iSotSkBy5Wf3NEGMPmdOetVoAB3ZnN2/EKtIoKyqr2H?=
 =?us-ascii?Q?nuPyE9mFBAjrg9pu7JCtvuEmwmrdlM5Xzq6hTZlglQqW2fKy3SH2GjcpX/dt?=
 =?us-ascii?Q?PRYCcHQNlNoPzDLNR25AezdU/3+Unw2jfnvCsR5wUOgzf1AozCMe15Yn+2of?=
 =?us-ascii?Q?Lq7FMcxFUx2XUHJ6EZV+5QJMldZ6DW6HhOvhBjwYWE7qjnmtGQiKqwPLi9kI?=
 =?us-ascii?Q?JiYbW4QfXUjSTDlTNTcp4oCjfsmaU1CLIkGvI9T2z61ETPmbWJcmfYWbTJ3w?=
 =?us-ascii?Q?qXzllpYorujFDHydJr3Jtxrk9+DcB+9nD2E75wy2cE0dFdM59GHlntKuGlX8?=
 =?us-ascii?Q?q4efynR1BQw1CjCp2DYgr5IkQ7b/pIBrynRZlVB9W//0qMUD+9FFwXzUwhT7?=
 =?us-ascii?Q?x3OWYSCnLanhlOdch2iNdTdkMKdsEnKhWfJGrDMbRX8EUgn1hrrJEo9IZ1qv?=
 =?us-ascii?Q?qQZ+uzuqtUHs0TYl9X+vGhNye8eXeWTWPpYed94KKvee1oN0cyJP1AYugvs7?=
 =?us-ascii?Q?aBy8KckFfy8CPVy3yuOxKtEofZtfKL7UE2NRwSj6T1mUJ6+14Y57/1EdCKhJ?=
 =?us-ascii?Q?dOHLTDCx+Ny9oIkdAqpNqQ08i9QJvk+Lm22jFRu/?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB8561.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e369f03-d9f9-408d-2126-08ddeea1eb3e
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2025 06:35:36.0105 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: brm9o6UGfjtYY4ZUE5pqxv0taivmuXEkgb6YTU6PacSBmL8yGuBJuu+epe/fD//2cxbTZdu294UlpIXKZtBnEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8083
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
> From: Minggang(Gavin) Li <gavinl@nvidia.com>
> Sent: Friday, August 29, 2025 12:09 PM
> To: Matan Azrad <matan@nvidia.com>; Slava Ovsiienko
> <viacheslavo@nvidia.com>; Ori Kam <orika@nvidia.com>; NBU-Contact-
> Thomas Monjalon (EXTERNAL) <thomas@monjalon.net>; Dariusz Sosnowski
> <dsosnowski@nvidia.com>; Bing Zhao <bingz@nvidia.com>; Suanming Mou
> <suanmingm@nvidia.com>; Minggang(Gavin) Li <gavinl@nvidia.com>
> Cc: dev@dpdk.org; Raslan Darawsheh <rasland@nvidia.com>
> Subject: [PATCH V4 2/2] net/mlx5: add support for flows targeting multica=
st
> MAC addresses
>=20
> Device multicast MAC addresses are managed using the mac_addr_add and
> mac_addr_remove APIs.
>=20
> In the mlx5_dev_spawn function, devices such as PF, VFs, and SFs obtain t=
he
> MAC addresses configured in netdev via netlink and store them in the PMD
> device data, which also includes multicast MAC addresses. Default rules a=
re
> created for each MAC address to filter traffic accordingly.
>=20
> Previously, multicast MAC address flows were mistakenly disabled, which
> caused mac_addr_add to stop functioning for multicast MAC addresses,
> resulting in missed multicast traffic.
>=20
> To address this, default rules for multicast MAC addresses created by PMD
> should now be set up within mlx5_traffic_enable to properly update and
> manage multicast MAC address rules.
>=20
> Fixes: 2d0665a7f771 ("net/mlx5: align PF and VF/SF MAC address handling")
>=20
> Signed-off-by: Gavin Li <gavinl@nvidia.com>
Acked-by: Viacheslav Ovsiienko <viacheslavo@nvidia.com>
