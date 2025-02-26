Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5529C021B8
	for <dpdk-dev@archiver.kernel.org>; Wed, 26 Feb 2025 13:31:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B81F04029F;
	Wed, 26 Feb 2025 14:31:37 +0100 (CET)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2077.outbound.protection.outlook.com [40.107.93.77])
 by mails.dpdk.org (Postfix) with ESMTP id 138674026C
 for <dev@dpdk.org>; Wed, 26 Feb 2025 14:31:36 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FDV5EQMWH2r3NUA3gGlpoT8yNLYPOWF2s0PrfHQcR53MxwUtoGaLKe3z1c/RqIE+KLQW6L2A5itnEIAX5PozR4/f/kf0G8K+NJZ/4lJwCmmY2wU0cv3zuFYSW7R56cSVHoB41uQlPy3oRTHzER8vxxE/H+q+8XogUWakwn3qK+G2vIi6yQgrEEjewNDZQWCDdKPGR5RTrT66LKcFAnJH89AfD9zlngcPWvHS/KAr91UImt/FV3QwhBq8bEE1niuj3/jNh0FDHNJGC2GSaC4z74/UtrQ10aUMu8xk11Iat2PgD1d0wNbZts0RnUDlxXa0h9gFRK8oyCK2vSJ2GIo5QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=119DyneUUWXjh4gEsbKc97EEhhGnrNM+3wtaLQCVYDo=;
 b=b+3FqdAL8jPBOZTDElbHGP0uxyI4mf1vfBfzboMD/HJ1qWue/8itZPXPVCAgDUi/TXxydqdkjdt/hF/i2rW/Rf6REWcji3f1/6GrwHOzgO7b/7wApWDrRVz0pFdbW8QGPeq4XfVLqEXFPdmPM6dK0FROAL4nRB9rR9Li73891t6ekNemKB7ojX5qLgmB05vlk7zLMSPCKXx2nYR4c7CZ2A0Un/I81yTFDuH/01THHE9zmfBxASIiKnbrpDzNZYOsr+T2kv36k/xl8njUWraYW4Md7EhkYpRJqhLGYbRF3IxGGiIW398S4KrYljIP7z2X1OqlSFVDA11I4OkOmlu+Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=119DyneUUWXjh4gEsbKc97EEhhGnrNM+3wtaLQCVYDo=;
 b=jHRpbKA44bnhlruPxgbMjPJVSdkOvh8Ug/ghFLJuhcZO+4hPgrUQBA0jB5FF/JTEUyppzcJdbAdxV4yAnYxqjNiV/OPuTods85qrabUGuTad3qyWhpnIA/CDVNIjPpP/qco/HrHaPzdO23YJVT55ZP/mL0BLe8VjFZ0vL0l52akbvSKEj74iSRBq3xaRDze1JuY+ggOPN8uc4u0F1hqzimVIbcluQbujxV4nAzsMCOHWWDInz1C6Cb68is5OXDOi3/w+bzcyIauyZ6osKzTLN7kNsUKhgefuxp7MD222cQ+6T8P2HThQI9Yc3m/mKVTQu6TN+d8eJZX0D0lJtIfLnw==
Received: from PH8PR12MB7326.namprd12.prod.outlook.com (2603:10b6:510:216::7)
 by DM4PR12MB5841.namprd12.prod.outlook.com (2603:10b6:8:64::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.19; Wed, 26 Feb
 2025 13:31:33 +0000
Received: from PH8PR12MB7326.namprd12.prod.outlook.com
 ([fe80::6d76:9c33:d230:8264]) by PH8PR12MB7326.namprd12.prod.outlook.com
 ([fe80::6d76:9c33:d230:8264%5]) with mapi id 15.20.8489.018; Wed, 26 Feb 2025
 13:31:33 +0000
From: Suanming Mou <suanmingm@nvidia.com>
To: Bing Zhao <bingz@nvidia.com>, Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Slava Ovsiienko <viacheslavo@nvidia.com>, Ori Kam <orika@nvidia.com>, Matan
 Azrad <matan@nvidia.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, Raslan Darawsheh <rasland@nvidia.com>, Alex
 Vesker <valex@nvidia.com>
Subject: RE: [PATCH 1/3] net/mlx5/hws: support jump FDB Rx
Thread-Topic: [PATCH 1/3] net/mlx5/hws: support jump FDB Rx
Thread-Index: AQHbhx6126YAUjHOsEyKvXA11JIKW7NZZB+AgAAx7fA=
Date: Wed, 26 Feb 2025 13:31:33 +0000
Message-ID: <PH8PR12MB7326C6153644C76177BB97C5C1C22@PH8PR12MB7326.namprd12.prod.outlook.com>
References: <20250225004527.2066812-1-suanmingm@nvidia.com>
 <20250225004527.2066812-2-suanmingm@nvidia.com>
 <PH7PR12MB690511CADE485B9220DE5BBAD0C22@PH7PR12MB6905.namprd12.prod.outlook.com>
In-Reply-To: <PH7PR12MB690511CADE485B9220DE5BBAD0C22@PH7PR12MB6905.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR12MB7326:EE_|DM4PR12MB5841:EE_
x-ms-office365-filtering-correlation-id: e684f39f-a6f1-43d8-c7ce-08dd5669e2fb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?rpXiRnpjzdcjqyYgyTm029ybSwxHK33Ka+SICJiIBmAmPk4Rbl8FJWMVDFjk?=
 =?us-ascii?Q?n2Zq+8YPnoA827XylN0znZMllHLve7bHgzaETd+3RXsgSITb+pjLX6sUVVtQ?=
 =?us-ascii?Q?4JSQIWYhafl2IMxA18e8tJQChAmP8JbKMiXE9XS6zinBlgn66tQZhKCKZlJf?=
 =?us-ascii?Q?VN5jDf3WGaJZ4ZqF20jaguC0HdMARe0H64siemYsAJc6nQFCCOyCxRb1MwWT?=
 =?us-ascii?Q?XvvMXr6iTShNzNUTm6Hjb/nE2bmXCxf/ASVVbunfm3Kcs51ilmTTibi4wfu1?=
 =?us-ascii?Q?qMvV2zEaHfDRcmkBkx8KrCcpEM4yhsFVu5ZbC01SDQEc4OQY4HXUq4k7fFcL?=
 =?us-ascii?Q?ADs+qmAWZwhalE6rDKAI88m+ft9wdQktnQMaZ3Ahd3aVe+UReMtnh1IMN21m?=
 =?us-ascii?Q?gesQhgG4LYhoT6ls34AbRrMfDm+C+1KOBeSk7Jh6TYkwj8zY6CcCNiudk1Fz?=
 =?us-ascii?Q?TWVNabhHasl/U69cQ1Vhj0Hy0TrFqImxnCD3PoWGv0/UzIuvsVYsN2Qzpy+z?=
 =?us-ascii?Q?59KqCDqiRN9C60woNkbmnv/CcdwpMTkqaO29KjmWFmvr1IkI5Bqtx1zZuXe7?=
 =?us-ascii?Q?O13ayxDIe4jEmZSjxuwB3H9TpZnKbq/8efjgUPI0kjjfhezhO36CkO5JjiHV?=
 =?us-ascii?Q?A00A0Pl1peYtpuPOvZxR8fIjwyXYtPE6CgX7Tq6kXB7eFthsKau7cgNqRJrc?=
 =?us-ascii?Q?Rv8xUgHfWNlZ8ayxUM+Z+UoxW+la838S1IKQ7hoZ0aJfZLAgZv/7NV5xy0KN?=
 =?us-ascii?Q?khkPI7172fN8LQ8i07hC3S4EVicdXcMpcLRAt1HNFOT/5E7k7NbR33nrtNE7?=
 =?us-ascii?Q?hTUMtemW5Pz5bSNfj4cWytGBdzuAjflVCdMz6pwoUqgBacxD5ovK1ftTbWMu?=
 =?us-ascii?Q?Hi/0d5+UkHUXD1yYdIXmhqMnaENI/4m4Bso5vaGYYT9R7oVvpth1cBW80d6j?=
 =?us-ascii?Q?jyhqd1UXnb8rLcGN4ilnO5+U1rHc02toLESLJKOun9bcaGH5zaEMZGoV3gO7?=
 =?us-ascii?Q?NSYgQZFmlOUQOuQO94j2eRs2kVKztLHQ0kGlCtWhO0x7GkW1p0YgEQljCMzQ?=
 =?us-ascii?Q?WT8aGN0RYTZ0XEvlnn4E2hAPP1uV6IB4rfz4mQzPzlaT845jHrqldF26UMQm?=
 =?us-ascii?Q?Xp0AFMK4EDLdeioHFbFjz+F1eUNZ+whX+Kgv5B1WK6REYE5DMFpj9jGZOEV2?=
 =?us-ascii?Q?bMsuiIVAttGYf+FFD1sil6gRLUsZYww+SC5hH95yfH3Q8tk1iQ3hL71eR2yW?=
 =?us-ascii?Q?CtSHKGhep8JKioWx5HaxIso1LzysBFWFBua4WRXR7ewcuu5EmpB2Vswb1Fye?=
 =?us-ascii?Q?mIkAMRveNUblynTmHam2AFbHL6+2LaWTuJeAJff0aFDXozVYX0pAjiiS76bw?=
 =?us-ascii?Q?0oStuCjnZM0NM+jk+3ja81pl43R2En6GDmk3gsMvZ18k6Q+BKBPoque6JrXZ?=
 =?us-ascii?Q?ZZ2bgeT+TGTD0aYPMFHAIY6tewYkfKAl?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR12MB7326.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3D4H+szNLiClXv18j8KWz5CznetHrK+GrmtlTUGrrAaDZM1is06WNOtujGHH?=
 =?us-ascii?Q?3eY1n1k9aavycO4FmuIJdA42qasg4SMfGu2jv0+VQafvGk7L7hyIgu85omBG?=
 =?us-ascii?Q?9kgoHZdaG8TfcLUgOaBdU+UHiqv5gA8pRhQdqZR+C9je9WkwLw/+bFhp3vkn?=
 =?us-ascii?Q?ajjqIaN9KmE76IHwTDboCFpKu5juG9IjnY29w8hMoxTl0nzyH6b619xxlqsK?=
 =?us-ascii?Q?NR8OVLCJKT6i6ndJ07l+TX5vvt9BTdKrSyUHp7xvYeG7pnwLRdevJ0oq8gj+?=
 =?us-ascii?Q?mShPS9CTbUISP1htX93p4VHwTgPlCpAfr37oelzoa0XqH1O2DHPU2DrIYDAf?=
 =?us-ascii?Q?sk5Gel+5BujNomz+8VwbkZ+BNqHbIL0pX6B9YnGsIrtCsg0VzxuOHnmWExfI?=
 =?us-ascii?Q?4eytee4AyjSZMxuBIq/BLr3AKTdc7cRNfXJZ0X+uxTCBdJs3paSmazxzjusB?=
 =?us-ascii?Q?KoWjjKFgKuEBRo3SLoWOc2kDm3ItckxNrQJiBZoHouE3zKu3u6nYi9bGn2BR?=
 =?us-ascii?Q?BewSDGbNzU+Y/Cno6Nf1zdR+cXtG5FdB0bdxXGS4CrbwCx5xuvnIAU5/YSin?=
 =?us-ascii?Q?gcremeuP1Dq+DDHy5fN+Zmpu5Y0y0pvy3eFnTvh2vIRPFhqhtj7RczE4VfkO?=
 =?us-ascii?Q?dJJ+67SzsfOPMaWH/q/W8AX3Cl8bczGYRPjOpZmUw6rGlLUIovrVLNlZMBQR?=
 =?us-ascii?Q?cMsXg9EF7AWMwjPP7caxeOwGyB5ORRh895PG8SX9C7pKbdvkfIdxLQAC+jRf?=
 =?us-ascii?Q?31TqEb6OheLjf4bCOIvxS+Cslfmsxa1clZsfBJ88hRDA2gcHhw5Zkmt+EW4v?=
 =?us-ascii?Q?g9AIUkQnhvOdZ0eHcfLxdrpZAU49rAUFLMwMkARgLoavEMcwy0fTU3wBW++W?=
 =?us-ascii?Q?2mKGlgfAP74T6DqkdLpiSOTPad6Nh/G3IFqd/Txxj7R/WYN493XlonLHe9S2?=
 =?us-ascii?Q?CpVuPcf5mS1VKuphzrk5aWlu8/NIXUeI5THFa+y2s5Z8HPdt2g7XHO0EJzeD?=
 =?us-ascii?Q?nSFjDRrEkqQf/R47xtyMvTMG8YBcERYtIZjhCeC3cGBZnrcS0lSDm+CFokCY?=
 =?us-ascii?Q?SwUyz+Ziq/ZdomvmivggPuvdLKzuTANwxEDgnULOVslTlifQ3oxsAj0/AFUn?=
 =?us-ascii?Q?8E7sDzSYO9qNt8B3nS++VTZagWHzFMZEnWGQ4g14Qrz4lJOLsDlYnb1H7mUX?=
 =?us-ascii?Q?2TUFo6B/e0dN6OuyFkjAk44cQFA2RfyPCNLjt067iXFN5a/QHIsK0rp0SBRZ?=
 =?us-ascii?Q?bfZqL1VLUZg50VYKdEwfJVH6Xkd4C5pat6giSfkp7SCGwaD75lLEmOiigBUI?=
 =?us-ascii?Q?ryVozpZGECRhFzErDYl4NEQdsvFM9OLk43+JShCEv6xH0xhfBVxHexiYpU1g?=
 =?us-ascii?Q?d51+gkREmM6BvlJbP/05m/9LDPVGEGSKHcJoZfupoh4EL+3xiEmuKLuFSHrB?=
 =?us-ascii?Q?s9eEb29cRltKWkO6HuSVsP6oRrHzMXGZHonSZZ1xATiqZ0ggghZJJqQ69tVc?=
 =?us-ascii?Q?bGldnQMce3pEMs1e8arpP7vifcCkBHbR1rhIO34G1b67qfLerc2udvLAnlUY?=
 =?us-ascii?Q?6o26AejZP2X+CRX8n8pE+YFYDfwFvkcQHP8oNci4?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB7326.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e684f39f-a6f1-43d8-c7ce-08dd5669e2fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2025 13:31:33.5946 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u56U9JY9C1riQmwwzpazRTpTH9hzwM9qZZ+sS1t4N0nZ8PjKKb+3tkM1YIF8xvCXX+kWy1NO1sEcTq5D7pKhUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5841
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
> From: Bing Zhao <bingz@nvidia.com>
> Sent: Wednesday, February 26, 2025 6:29 PM
> To: Suanming Mou <suanmingm@nvidia.com>; Dariusz Sosnowski
> <dsosnowski@nvidia.com>; Slava Ovsiienko <viacheslavo@nvidia.com>; Ori
> Kam <orika@nvidia.com>; Matan Azrad <matan@nvidia.com>
> Cc: dev@dpdk.org; Raslan Darawsheh <rasland@nvidia.com>; Alex Vesker
> <valex@nvidia.com>
> Subject: RE: [PATCH 1/3] net/mlx5/hws: support jump FDB Rx
>=20
> Hi Suanming,
>=20
> PSB
>=20
> > -----Original Message-----
> > From: Suanming Mou <suanmingm@nvidia.com>
> > Sent: Tuesday, February 25, 2025 8:45 AM
> > To: Dariusz Sosnowski <dsosnowski@nvidia.com>; Slava Ovsiienko
> > <viacheslavo@nvidia.com>; Bing Zhao <bingz@nvidia.com>; Ori Kam
> > <orika@nvidia.com>; Matan Azrad <matan@nvidia.com>
> > Cc: dev@dpdk.org; Raslan Darawsheh <rasland@nvidia.com>; Alex Vesker
> > <valex@nvidia.com>
> > Subject: [PATCH 1/3] net/mlx5/hws: support jump FDB Rx
> >
> > Before FW introduced the JUMP_FDB_RX action feature, jump from FDB Tx
> > to Rx is not allowed. JUMP_FDB_RX feature introduces the internal
> > loopback for Tx case and allow the REG C0 C1 B be preserved as well.
> >
> > This commit adds the JUMP_FDB_RX cap bit check and use JUMP_FDB_RX
> > instead of FT for dest table FDB Rx case.
> >
> > Signed-off-by: Suanming Mou <suanmingm@nvidia.com>
> > Signed-off-by: Alex Vesker <valex@nvidia.com>
> > ---
> >  drivers/common/mlx5/mlx5_prm.h        |  9 ++++++++-
> >  drivers/net/mlx5/hws/mlx5dr_action.c  | 26
> +++++++++++++++++++++-----
> > drivers/net/mlx5/hws/mlx5dr_action.h  |  4 ++++
> >  drivers/net/mlx5/hws/mlx5dr_cmd.c     |  9 +++++++++
> >  drivers/net/mlx5/hws/mlx5dr_cmd.h     |  2 ++
> >  drivers/net/mlx5/hws/mlx5dr_context.c | 17 +++++++++++++++++
> > drivers/net/mlx5/hws/mlx5dr_context.h |  2 ++
> >  7 files changed, 63 insertions(+), 6 deletions(-)
> >
[snip]
> MLX5_IFC_STC_ACTION_TYPE_JUMP_FLOW_TABLE_FDB_RX_BIT_INDEX)
> > &&
> > +		    action->dest_tbl.type =3D=3D MLX5DR_TABLE_TYPE_FDB_RX)
> > +			attr->action_type =3D
> > MLX5_IFC_STC_ACTION_TYPE_JUMP_TO_FLOW_TABLE_FDB_RX;
> > +		else
> > +			attr->action_type =3D
> MLX5_IFC_STC_ACTION_TYPE_JUMP_TO_FT;
>=20
> Fix the long line warnings, same as other places.
> Also mlx5dr_context_cap_stc() seems to contain some calculation inside. I=
f
> the context and the CAP will not be changed during the runtime on a speci=
fic
> port. Can this CAP BIT checking be done only once and saved for later usa=
ge?
> Since the code is used in the flow insertion.WDYT?

Ack for the line. But mlx5dr_context_cap_stc() is planned as get other caps=
 based on the bit as well. And meanwhile that function is called by action =
creation, the jump action creation is done inside table creation, it is not=
 in the flow insertion routine, so we are OK here.

>=20
> > +
> > +		break;
[snip]
