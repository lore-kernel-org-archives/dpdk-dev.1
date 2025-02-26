Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6540C021BC
	for <dpdk-dev@archiver.kernel.org>; Wed, 26 Feb 2025 09:12:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0B70D40611;
	Wed, 26 Feb 2025 10:12:34 +0100 (CET)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2076.outbound.protection.outlook.com [40.107.220.76])
 by mails.dpdk.org (Postfix) with ESMTP id 9163A4060B
 for <dev@dpdk.org>; Wed, 26 Feb 2025 10:12:32 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aeppznUYbzJZrAYv5cOys1tyIg209G3TjiYHa/s87/NI9ZDBCqSvdJH2okjQv94RLei2Y+s1scn6LL0CrsQwBvFkVlemr1BDt01SgpUVPLHlp8FeSskBah7PDPOps6954Alnl8pZF8TNWwhWEAVDcxny7wM1haYmDGWUmtb4tffWepmh27XfhugUrKbpTcgkT5NAqmuZDPR/kV+QutwxymvDkVcMC/l0dutorcEcCHGjxb0g4L/jcxQszIv7Ck5fDowjPcw7hZ3ZhLjhGNsj+mSj2f2SdlLaKAka1SL6PdTAZOt3qMqFt/+nnjRD3OtsVCd77n66B+pi4M/0CYYENA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XqZvVTuGV9MkDwRQIKK0VfZCe073cy1VFbwZVZqsXCM=;
 b=lGD+R6/iReYbmz8T9UMSBsX8IxUqevgAXKMhCLw+8ukEeRPzTuAISDjHhTwPtO3BE3xz3cL1ZpiEFF3nCvkCytH3FCUtOSlTr7qrMlHZlS/L8dyG8LjHpSGuEtgOeZTJUzyc8gXTAM0dlu1ugpkG33udLD/DyrZsxi1ZSiuwKoFpGucjYZK/BPyjaSQpbY8iJx7isyzx1YwD+Hvvi1OhQWuzH6Gmy3qQzHI0PHjkzprCiWVtjviw3xJ5Bm3uCIQkSGVsi/2bEBfxdYgUa1w3YTQd/g6nVNBRNRU5CyHthOhKx02aUbzLVF9Y0l64I3sACpUmKQO7uPlcZXBUDf8NSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XqZvVTuGV9MkDwRQIKK0VfZCe073cy1VFbwZVZqsXCM=;
 b=YNWVWKilGGZ0TLyNQQjoyJUGumKknltDquIjaIqoXtDbBEqNZL8MlmrQLR6ZyFRELQYZYwECuKIXzLzsK/XLo+gdvKVsNdfu1FldhxyTpCP3RS6pCTwRimgzxV+dPgLqBVObkLyKlpM0VS5HnxFaP4hZ6tvquKAvy7PJRgoimf7d6oEg58l+XuHvjr8SjVhNaDDS++iYPBk4MOg7VLn83s3bminczLMkQVQ3ECq5ZzAfEQmrojXgnR82gAKMO54FwtcWUscdXfpfkdD2swiBZFZwQwKZdDY7eXdMeXJONUrc7iF4j4p7aTbuwDTvjFRbclnTSdTIHypeOCPkE0Znbg==
Received: from CH3PR12MB8460.namprd12.prod.outlook.com (2603:10b6:610:156::15)
 by CH2PR12MB9520.namprd12.prod.outlook.com (2603:10b6:610:280::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.18; Wed, 26 Feb
 2025 09:12:30 +0000
Received: from CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5]) by CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5%7]) with mapi id 15.20.8489.018; Wed, 26 Feb 2025
 09:12:30 +0000
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Ophir Munk <ophirmu@nvidia.com>, Slava Ovsiienko <viacheslavo@nvidia.com>, 
 Bing Zhao <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, Raslan Darawsheh <rasland@nvidia.com>
Subject: RE: [PATCH V2 1/4] common/mlx5: support FDB unified capability query
Thread-Topic: [PATCH V2 1/4] common/mlx5: support FDB unified capability query
Thread-Index: AQHbiCn5BwrDeStQ/kiR6q7by74DnbNZTKTQ
Date: Wed, 26 Feb 2025 09:12:30 +0000
Message-ID: <CH3PR12MB84606CF17CE1FDFC2318D98BA4C22@CH3PR12MB8460.namprd12.prod.outlook.com>
References: <20250225120213.2968616-0-ophirmu@nvidia.com>
 <20250226083846.4023622-1-ophirmu@nvidia.com>
 <20250226083846.4023622-2-ophirmu@nvidia.com>
In-Reply-To: <20250226083846.4023622-2-ophirmu@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB8460:EE_|CH2PR12MB9520:EE_
x-ms-office365-filtering-correlation-id: da1d5264-2a93-41e0-42f6-08dd5645b278
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?MDcVHh1L1w8eNJXFY8WMs4brvUslysK88cxQoORf27VfZ70pQrmiwboEtcYO?=
 =?us-ascii?Q?LKfAKIJ/+Kvxe8TuGJq+0sqaTPVClKKdQTRdGyfLDGTNkUTxkvFRMHVxhwU4?=
 =?us-ascii?Q?iV+Lj7yoHj2BBlOWnIQV9J85rDmXLhGVZB134xYHfDp4F3PvMrH69lJ7/Aw5?=
 =?us-ascii?Q?vg3ujG2Ld6co67Bk/ugViSX/JBvsgwyKzysWTjf4O9wsdJdHJJLzAg+z7hO+?=
 =?us-ascii?Q?5NKS56V3HSMNrsiqUGwPTwSNycfSLX7CiERxuW166vNc8+etzxX8OndRZGVB?=
 =?us-ascii?Q?BhZKYciUQezhyPEFlzpvyWrqILVK/FsH7JROoMyBWTWDtngrAhM2EhTmI8Kf?=
 =?us-ascii?Q?aErXaWzNsVAfQxa6RCnVubI60DpnJJZ/JqctF++InzjwwGbZrw4A3qVJf3a6?=
 =?us-ascii?Q?xK+iMA5hzgqvp09MZpYQVNTzARY5WSG+vtjz4RuxI6S3De/Ks+h9xTbJJPZR?=
 =?us-ascii?Q?f5QGfLLJ7+lQ/NoOBDIy7tbx5e+SKKvx2XjjAX9R/6UnDRld6upKcUfpp9AN?=
 =?us-ascii?Q?Gl0ADUSbB8XTULlA96dtiNKKiEK0NeZTQLSUpiQCcAKCAop9toKGkm7p9CNr?=
 =?us-ascii?Q?K+bbNvKK10iu1ZylWS9fIXSS60LKKWjIDeuiKb6jMcgjAb7i6EihZ0Gmu7sf?=
 =?us-ascii?Q?Zk/xFF4G1I/2UMBia+RkirYUsROSDrDCJ5nOxR3Mw8IJi78+X2EReHrCLPvZ?=
 =?us-ascii?Q?KisZBr9qz0Tq4HUOgWa6hDgsJsdpeKG6mCmou1EHqTZyC3AymS1CHZecDHyB?=
 =?us-ascii?Q?5Iibhbzgcn88gqXwF3z0Bv5U8ahJlY18+j01FhhOJcp2z7hOSL7bPxOWpfOq?=
 =?us-ascii?Q?m29Stbg0atrqYqcqM+/hfeymRisObxHjkhzDzn20QNLqqeUo2pwK9OR1uP61?=
 =?us-ascii?Q?QPSYbVHq8ob/wihoySqs29fm3AQLEiDTO4DIFRy/wxlRiwtA6IezNSbewX4F?=
 =?us-ascii?Q?Nu2nDdfA3uEMWS/1IdHUij5QwWq0VoC4NUYYk7DYfBKO+0zJwR47BkNKNL2K?=
 =?us-ascii?Q?mAD+mkkLbHcgrHoRoGmFH8mDBTZg5TBqgXOFFEyACzfWn1aqRgbEa9yj3PdM?=
 =?us-ascii?Q?wHty/slOpmy/VrPGRIR11ZFRwkHA/voiOQ/racp40cNFbyevAIyiG1ySGw1J?=
 =?us-ascii?Q?kS+5EwrPavHosjLUmx3efGwXMVCSuU8VuL0GDloDkYX3K0LrWEKnkNTLZnuB?=
 =?us-ascii?Q?NLUc3PpONEpHkQMNgcEyvMjyoZhxoiRI6ehhrEL0A1yGf36x63YAEMDhtvex?=
 =?us-ascii?Q?8x8DkW4HOD+dE0v25ljaBo88EmIFi8TERNUoIknGFddFby6thOnUkw8mXT/r?=
 =?us-ascii?Q?1zBjeg2gzDhxEcKK0GPxA2TQfhU3leDX5xjUGHBGKqfY8TU1dKrgujudblxo?=
 =?us-ascii?Q?GlRUhBF+4A2nHLmm2kHhUW4g93wPaZFEAqk4lcPio1+kMRXE1VfShO7Xp8Yo?=
 =?us-ascii?Q?VFwh038g938T+X7XAIiy9QHEuoT+8UIg?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8460.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ZFTCo+tsLv5wC697g5pH+6hylcSkD9qFWYSg/SHdynknt6brSIkr3UTDXTNB?=
 =?us-ascii?Q?girKDH6uqvvNPUYMfw4YJ5x/WhqGm0bWlzXVQD6zGZLiUs2LmYAWyGhRrg5p?=
 =?us-ascii?Q?5fUVTUyBdgpqtIe/eTHnCQwrSbamCciStTBRodOVNOSFx9ABq3BiQhFSEh3F?=
 =?us-ascii?Q?5Gw1vBl8+ygGjdq5rnIKPbcbrX16zsMo+YgJyB9yrjga16B7qE0oLIXh8vb4?=
 =?us-ascii?Q?RW60J2N9shHYmuRbuAU7W+8JL5i8gYtC2EAA50b8wlE9bkEBMpGAk42vqaw5?=
 =?us-ascii?Q?33HiRgaOShuFrntmhDZZEgnwuQzofaK5qkEwDl7LyJPrzWIvjYlTCSUpuLRN?=
 =?us-ascii?Q?OIsSnvHG/i6T8PjFeWwZ8PuPDC50zlCW8Xjb6VSrup1pZxFNhPbr5RSa8Ifu?=
 =?us-ascii?Q?FaCsf9WTWeQICxEdrGE87LnLs+wx7YitGrRgZUUgYzfRsuVexWFyDDNGAv6V?=
 =?us-ascii?Q?W1KaSBS64oYwDUfp6SAWWN4nP6G3U9M2F5yKUYJXZQHHSOiH+ECRmXRWP0L0?=
 =?us-ascii?Q?ImwlNY/Er1btcWW8pINK0Zniv5/6PdYqTcCY4opJ+vhGDE0c8I0LwzXnhk38?=
 =?us-ascii?Q?5bhF2RY1bzaYRrAk0Ects8FgMQFgnnIZvnzDX2RX5hojnAbb4BI0lnJTyGZi?=
 =?us-ascii?Q?nIdzHk56Mx9OuRtVe5AYX1EeFcG5v7hBsmS+t90rXaVX3nI+hraRj5THbH5s?=
 =?us-ascii?Q?fGI1OuqXIjsOXQ0DvutwTzHE2mzaHQYh5uTiGH4DUqsdhuXhS/OTpc2Fh5yl?=
 =?us-ascii?Q?HpSXti+5TO0P9NCADjYc1kot169uzv3LIM3HdwTo/C4ZicXswEjma9YnvSlB?=
 =?us-ascii?Q?4QoaXajjCrsZ9QiqcwMGojxHEYE9oyyJY/7K5ezgqvh66lFU8Oln2z1ITvjH?=
 =?us-ascii?Q?RlyRKT9p9ktuE7gN56xS+K1Onj2YBex7878EuKk8UhaiXc1egO0qarb3duUo?=
 =?us-ascii?Q?kgTK5Bv46vZSaE4eSpoo/EyqrMmHKxUcGwGHoT11Z/vaR7l4yEFugHfEkIcX?=
 =?us-ascii?Q?x0azm2ua6PUvXCli9EqG5RBEtckrBNTxwXUeQHSwZXBzqSRnpBbl00/BjPKi?=
 =?us-ascii?Q?pt8wP3NFkCoU1VngbLmNjo22YVaXq8cAjbGYgxslWBE4KV15F+56dwX7FxoL?=
 =?us-ascii?Q?NZ0Pnll9zPL3n8yQ+hUFoqKdbOHMg0i1Aya7w07AdRvX7vW699p6Rg8DXwJD?=
 =?us-ascii?Q?/ndU4Zrm+BiFo68NqDnMQmvejWXkd/EH1YjrelceTexFSYSKSyftEGKOJcH4?=
 =?us-ascii?Q?ylkzS/NDC5bwZIHO3VEa7cSDUSnwsmedbzzwpD/gCOnP71qh92+/18J3bGkp?=
 =?us-ascii?Q?THDlxToBAoWgn7puGUQXw5xHJz/wCQxDLFgPnbtZg3vFjCJUh8K50tpArIWx?=
 =?us-ascii?Q?aSh1TIbXcQsRLh8FmA6mnQyifCyyEPa4FUhgPJAojjBiNPpbl81eSIslM0dw?=
 =?us-ascii?Q?zcg22xscQ3zqjtGAMerA8DUWM/sLyjTptY+1qQ3wmdGjaLEkesRPGkMEzWNN?=
 =?us-ascii?Q?3BwsrBS1KHgLWpzPrwQ8x5UOP0vhZNlwO0dx/w9o5pJV7uRPFEEH2cVjHgIT?=
 =?us-ascii?Q?6eNZzg6zIqc0xmkQbPxnT/4+8VtoKfO8Rjz29BcC?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8460.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da1d5264-2a93-41e0-42f6-08dd5645b278
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2025 09:12:30.3139 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HGhPfCTU2zi3Yn6oUS3H0UCwkQcKYX/LQGqjIkILK5UilS6RgM/L12Io+0hCSYN92vF4Alfb8+R0Nw6KZVAi8A==
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
> Subject: [PATCH V2 1/4] common/mlx5: support FDB unified capability query
>=20
> This commit queries the FW for the new unified FDB mode and saves it in
> mlx5 shared device as fdb_unified_en bit.
>=20
> Signed-off-by: Ophir Munk <ophirmu@nvidia.com>

Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>

Best regards,
Dariusz Sosnowski
