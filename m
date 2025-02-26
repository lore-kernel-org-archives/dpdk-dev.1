Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12B69C021B8
	for <dpdk-dev@archiver.kernel.org>; Wed, 26 Feb 2025 08:38:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 662B34029F;
	Wed, 26 Feb 2025 09:38:52 +0100 (CET)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2066.outbound.protection.outlook.com [40.107.244.66])
 by mails.dpdk.org (Postfix) with ESMTP id 0BFE74027C;
 Wed, 26 Feb 2025 09:38:51 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HcUgX7DkeZ/qnfrPsERxZ9vtzn4yjqCSPvkLoZuZItNg/h4BAmzp8EcfHyWahnqqQmFzI6XbHOsM5Oqe8wgDvb1v1hz5qfoqR8raVYSUj7P2lM7SU95YSwDDRT2sNSNmIcFDdEDepo8nASFDPfV/+ytSfy/uyMHulIv0tGZJ31ueF7IMBa4xYFn0u6MlCwtsNM/bOmzVVOazQ8beHb07tMzmJb3lCGch/3gdIVD3X2uPg/G8/vLnePebsxoJ/UqC1BoYlUGgKW5iQV+YNDfQ7sMb+ThW6WHpWgOXBrBmzqsQu4hn1nc/xBv1RitCcoyFI/8+VmNI2NAbf44zFruAQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8qxO7dHId+dHUSZdO5G+cv9Sb4guOglfLyBR/7YXK1Y=;
 b=qF3qrV7Eee+NzBbNVaR4pNceh9n7s3ny6Hd0q6hK1xWvpsBTYPTJ5Lsx2tgoaHhx/Bls4pSov5vzqKMrgxW6KYPzQwZxP1ToXO/qqhAg+XITr2kD5LstPdflfL9qNM0xPRx9NSGR3ZVHHvzYxoL3Mwn882rxQ1XpETZIE9s1PcNaZj7N25QluEhp6ojn5y2T7/nTnCUKWmw3lZKHcgNFFrdHi/d1gMdVr1HiIlC0ZgC+eWTpjLqBxX5o+hKJ9yKVvqRN4WlFJt/wenuE2cnI48FCkJxscPyAuiCAOzq9aGPkbuKcWnWKRjzW2vfbnZIOfOO5orDteKVGLDf0jrb7vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8qxO7dHId+dHUSZdO5G+cv9Sb4guOglfLyBR/7YXK1Y=;
 b=c5I/MUUWYuYpg2FHla0wRH2KAlC1Mo1OF3moiOzAvrNIfd9DUZMfcy8AckUb/pvWgw9qAxrDmRspeOdhTPMp3AX4ggpM5Qhu3QS3QaLYmF2Pp9jSQqMeT1WDB1rm3mbRINDNfE128iJqB/VAsvLFPXpsOMuA7zKT6v1dGmTby2ea0qOx/Q15zZJb/npcoq1hMlVOrtdikacP84RDRNaZrcX2uLoOsCmMx8qriCKVNuaxrnwoQia3+ecWyDLehblNltfEk2cJ9HcscsAC6c5wPaxCeY7lLh7BE5GtORjaSpVR0lxkoOwLiTQxWUEzwONFJ9FE5OzDSkmwDU7cMsZhfw==
Received: from CH3PR12MB8460.namprd12.prod.outlook.com (2603:10b6:610:156::15)
 by IA1PR12MB7565.namprd12.prod.outlook.com (2603:10b6:208:42f::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.19; Wed, 26 Feb
 2025 08:38:48 +0000
Received: from CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5]) by CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5%7]) with mapi id 15.20.8489.018; Wed, 26 Feb 2025
 08:38:48 +0000
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Gregory Etelson <getelson@nvidia.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: Gregory Etelson <getelson@nvidia.com>, Maayan Kashani
 <mkashani@nvidia.com>, Raslan Darawsheh <rasland@nvidia.com>, Tamar Mashiah
 <tmashiah@nvidia.com>, "stable@dpdk.org" <stable@dpdk.org>
Subject: RE: [PATCH 2/2] net/mlx5/hws: add DROP action to multi destination
 actions
Thread-Topic: [PATCH 2/2] net/mlx5/hws: add DROP action to multi destination
 actions
Thread-Index: AQHbffH415TfMSNj/EOx0a6JdYXK4bNZV6vQ
Date: Wed, 26 Feb 2025 08:38:48 +0000
Message-ID: <CH3PR12MB8460DA69FB2D0E53FE27D652A4C22@CH3PR12MB8460.namprd12.prod.outlook.com>
References: <20250213083239.94360-1-getelson@nvidia.com>
 <20250213083239.94360-2-getelson@nvidia.com>
In-Reply-To: <20250213083239.94360-2-getelson@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB8460:EE_|IA1PR12MB7565:EE_
x-ms-office365-filtering-correlation-id: b03b7f01-23ce-418f-5e0e-08dd5640fd1f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?nSr5C87z2bHxD8NORKHB96f8t5137Vg0clMXzAcwEwyQKHFrPuSiO8CGmNH+?=
 =?us-ascii?Q?dH0nw5jLJX7VVMAK4+AJmNdYZoWMQV4im5Z0giLDlnpHOTLPHe+fuRWUGpxz?=
 =?us-ascii?Q?348vzR+WepmxU/smzZK0Q9eaZM43/RbZNVzUTYbgM1C+V9zMhRiDRCwaks2q?=
 =?us-ascii?Q?RwiLNz4mxejmRKHuOZoGBIH7HOcQLDPXDBAGNp/6+N0RmAhgCtLUEaNYJgdJ?=
 =?us-ascii?Q?Vz2Dp4rkAZM588O/zY/7JuQk0R5EG/3mtS0nHLWppJ9pcWCIZVio9mBIlf8j?=
 =?us-ascii?Q?hb9h2L3tjViroqvPe92Is8q/hkBb4IGYo7qoHpWXMoIgEaubVShmZOKjUnvQ?=
 =?us-ascii?Q?+p+Edqyl43W14b1FGyWRnP8VrTP2m+xC3gB+jnoNEKsfklDxI1NqMQlL18jM?=
 =?us-ascii?Q?RS83kQzKRAHVNTW2LpSoQyjg9rQWKaNPH4mrSh153wXZOoGD7a3AV9hfGIVl?=
 =?us-ascii?Q?nzAQafCYDNdTCaZFEjeXDCnWbKvBUjC2Meli3w6q7GMn4cA1u1apnsqs1cln?=
 =?us-ascii?Q?HnJygQMc3Qkz4lgqvmMsVLIhElTvsfTYM/5uSOkNxRgtVSHyNpqk9Pq7DYD4?=
 =?us-ascii?Q?rYInCeTm7tYkvVPNTjlWhVtBD7Q3JjqyHROxcXpGxmgY/u93d7QumCMzwGz5?=
 =?us-ascii?Q?XuB8XHQtwsXn2GK3P3P/iKIW/XBixtyV0fGQCyECNg+J9jo0qJNpWYdPxzbB?=
 =?us-ascii?Q?xdWqfC2qwLmenyfEZsnNRTcHnojvlxzee+vXBL9mJQIId+PXzH2I/B8Ez7X2?=
 =?us-ascii?Q?3Smm4tbDhCRnJlOZo+gVaWNgTxqxrJcIBAujdUEhP4O9lsPwAyydn8XfDwjg?=
 =?us-ascii?Q?vm62RjMKSKJz2dCMAZF6SU/ic08hw7uyLFruoizLUFWbMamIcmsAGTzD9Snq?=
 =?us-ascii?Q?jZK6WJcwxgwacHlzIlkunfu9n1+HX/hf7DECC5f7uqpcs+nIJR5ISe7fIwLA?=
 =?us-ascii?Q?kJV2hVh+DBjUE547goFFr5DdbJYpFtMedc8o285f/i7ZbTmNkj0ahvn9Afwe?=
 =?us-ascii?Q?WDQ3t7cGFWD/eOgBcXwurO+ppoRxrkpHfjOboubjGR7ELw1PKNv8QkP9KY+/?=
 =?us-ascii?Q?PityjFjvNErw0taXm91/ixd52u7WqfI9sTYCjvZ/oP28MSfA3MeHSSZvw/wZ?=
 =?us-ascii?Q?RFv0i15mf6rzFHTseQYF59CHwlxwMfndskDBNMHlho1C7ylZLWKujo6WbB91?=
 =?us-ascii?Q?0OMckkJ7ovSHVvhw8yAEQcpx+u9dH/a1Hqi2aCoCF7IZhbUHPH39NvyWUHbW?=
 =?us-ascii?Q?HBnUvBpxPyBgnqMSKtloV9J9cThwRDvH+7JLHvYQmnZNCn2LyeKdGKeJb7oB?=
 =?us-ascii?Q?mSOIclObyaQpXH1Z4hJAju3Xo2CnjFimSXw1pjqf0LqB3CDY/bpLPFivFxmb?=
 =?us-ascii?Q?HNOdC8LSMU8scJrPXqz5mImEKCOEz53xgMnAJW8hqTBfN2/jbiHKgZZsKNGT?=
 =?us-ascii?Q?tezufwXnoenUEwVv7Z8ThQAwBtyiTDOF?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8460.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?QXB9rbh5G6wyvKZBt6E/3GZP69TLa7gh/+cjoxyBZSUvPFTxPaWUDjbmaYM8?=
 =?us-ascii?Q?9lliPGA8Wam6Vl9aYLxkSt9QJ+DQcHX0Fa8gREwOoBTw9zsj3SA83Dv7vizG?=
 =?us-ascii?Q?kTiEPyJuRwAsqiru+1pSysJ5N6WoEQYryZoP7jWWLLEC8IYGwDmUtXbKtnRf?=
 =?us-ascii?Q?ZHKpFTUBvprM7O3o/KkIu0OPC832XjnVcsr/RGRILBNC2t8wcMJDfct9iptj?=
 =?us-ascii?Q?LaiGE63AHIGX6ngRsqqc6vN844nrqiZgMQ6C32VqpQQnvJwLH9bqbHycAD01?=
 =?us-ascii?Q?sXaT0RDw4KjPEfivufNQUOHreE7E78u6bxBntuAIDUUYqou9MTaf4MC2H/iz?=
 =?us-ascii?Q?xN6AdblHVvwJY2JxQ/IDy2xzodp25LCZAWeRvrxM8z98OSHZiU2obUDVP+cT?=
 =?us-ascii?Q?XBHzdrnbGz+KvbshwQ2wTQDc0mb5KLNjXpGs3uJfV6+jEDwT8hAVqAIVkFlo?=
 =?us-ascii?Q?rLBCdgYLQYV0dyLegZhdbJNXC7YKGptO7D3iZnrIVjC2dHkEWDnp/q8GkIH/?=
 =?us-ascii?Q?fcqgI5AJeXBR5G/K3qnbsLFqSdd5dZD7UthmxMF2TQeX3k25w2s1iBqLOKnt?=
 =?us-ascii?Q?FDEJ/AetpWjC30LzstZDrfgv3UohHHDYHPv8neD2+kYka2vRpMfmgSJ3VFJt?=
 =?us-ascii?Q?3yxP1X94Cbkj8h6W8hXAU4bQx1E8sfZeiTzaiG6iOFKQS6uovd4qkKin8Ouc?=
 =?us-ascii?Q?PxBZUvNf+s2XfZ/xTt7US/bG62uRnS+hFV80jkAMMiJbMtcz7QNZTmfZrCIl?=
 =?us-ascii?Q?cZkXx0EjzfYxsXMRLgPSYZA9memJMguGRoPP2/f7Z+My0jGVxwasp1KMC2Xy?=
 =?us-ascii?Q?ge9H67OlKinrju7N8MxLBncFuDATXLFX/rfcVUHvNtl993agmHlb3HBOVOMm?=
 =?us-ascii?Q?bHCojWrY1KeTZRQGSiMRwueN4+lJioKmsd3F+ThUqodVU342YuSr+Ywx0JFc?=
 =?us-ascii?Q?fGuSKkSsSDuewdIaCeDbKBMt6L0qPXIJHIP+f9bvDbxBojKDbxMLbTnZ6dZA?=
 =?us-ascii?Q?AGbkDKUxXGX8PbrN370mY4euZl93/1wJPLmDLGyhgVjvSrLnyJEKk5uQAVCV?=
 =?us-ascii?Q?+GSFMNXLpDWd1w+qQDIiLgMaGy1JItldrB13z4KmW48CiYPYFdBP42SA1lRD?=
 =?us-ascii?Q?Vlw0XIMJ4ZG+ZpbX2BTVyEsgEvnDo/+No3yNMp9J+exscnHUlpoIhr99vjTp?=
 =?us-ascii?Q?zl3BhV7kIUvnNl3APlPodt3I7gl0sQWL80ePA34A0kyF0/MTUdUj3X8NEpNs?=
 =?us-ascii?Q?S9hb3FsjV1jDsB+DwXvRxrWs5tYQLLuBpi4vTeUeeYM7gfrWLlFhLHSKUIwN?=
 =?us-ascii?Q?rPi4/QzY8W/4AjhLA8OpslBCob8LiRYCH5HQOHGFDppiKHFiZf6ziiaa7q55?=
 =?us-ascii?Q?jL2V4JqiaJA/K04yVy4iIbZ8rFX82RggXej47nNlywqeSRWYzxg36lPXk7EA?=
 =?us-ascii?Q?pv0/b70CcKIJAu5D5swF4HntuGnC9Tr381Qjisalyz9qai2Iur57oPcWhX+x?=
 =?us-ascii?Q?pPVqoH4WgeYhUjQU8rpgFH2ADk7wAHUh2yEEVa41wbl5IEyynZL5dXCK8dyy?=
 =?us-ascii?Q?qhFqJsD1q3ijm/9bTNeAODY9HsfgJ8uXtrj8CyaM?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8460.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b03b7f01-23ce-418f-5e0e-08dd5640fd1f
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2025 08:38:48.0862 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JvmeA4DMNQdbq0KThVlmbuEK0g+WeXCXVjTBFYhGDE7p4MsgBuAlFid/yMJZ4623Eu1AS/pB/PbC5qzlkI5AlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7565
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
> From: Gregory Etelson <getelson@nvidia.com>
> Sent: Thursday, February 13, 2025 9:33 AM
> To: dev@dpdk.org
> Cc: Gregory Etelson <getelson@nvidia.com>; Maayan Kashani
> <mkashani@nvidia.com>; Raslan Darawsheh <rasland@nvidia.com>; Tamar
> Mashiah <tmashiah@nvidia.com>; stable@dpdk.org
> Subject: [PATCH 2/2] net/mlx5/hws: add DROP action to multi destination a=
ctions
>=20
> External email: Use caution opening links or attachments
>=20
>=20
> From: Tamar Mashiah <tmashiah@nvidia.com>
>=20
> Add DROP action to multi destination actions, set NOP destination type wh=
en
> DROP is specified.
>=20
> cc: stable@dpdk.org
>=20
> Signed-off-by: Tamar Mashiah <tmashiah@nvidia.com>

Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>

Best regards,
Dariusz Sosnowski
