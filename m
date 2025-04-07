Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F070C36010
	for <dpdk-dev@archiver.kernel.org>; Mon,  7 Apr 2025 22:17:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 26AEC4026B;
	Tue,  8 Apr 2025 00:17:37 +0200 (CEST)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11023076.outbound.protection.outlook.com
 [40.93.201.76]) by mails.dpdk.org (Postfix) with ESMTP id E4AA9400D7
 for <dev@dpdk.org>; Tue,  8 Apr 2025 00:17:35 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cCpbx7HOUUUwEUcptHzLX2brjkB+W6RwlqVnLey2Iz/fw/onxjbA3mRw0VIFxTTW4Ate1d4+ufGPH4cfz8cXb5+ktzWq7xunjlLDQjLhCRugcyBSJVBZaYR/cY9iTIZZWDDpJa0j4LeoBSXR/XbSzD8i0Dr2l5uu1TISJHK5lK/by8rCBhftmcs50Y+W8TDdaz3aVl26FMOoO0wLgBF8fEmmdpsGCGMcsW7UovGi6SVeEIz+MuYhqNhxHP7QJ7oY2HaZnwP6aELV6iCSXMzpyTyQoe+O5g5yyKg4k8z/i/DI/in9mEv4/qxzP437NUfcpt4Egdk0qSRVZg/lTECxsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6jzw2rGxZnPQXfQgdGSTISlIMTpCQ7BkzBRjSJl4Q0Y=;
 b=kvKh0HfAjlBKvpM4e65nZndGEq2k9HwdyMKbzAydO42Tzg0XaqUgvFY+pUDCocpjV3NYDqPt9joguDPkFFfYxAmQU1vY+ty0xjO7pD1ezGo2sT6Qu93xp6MBqZ/XYEeNp+GOMwEoERPkjV4vxi+1tHfGdpXvm5QfnuwhGdf0boYEoUQ7WjymobLJPAE4G5Io1j0j7cM0vFPVQaAYNVlZDqItbhuesrZoWITM3wUCBuXEemyC4NZsuBhwqhlmsJdrmOZhIk7MYq2DhRWXK21OXBeGbYQ0ZHstUkEp/BhnEn4BVlwA9xj9ZszD15g+iU6oiej87jx+MNr/zU2fRRuUcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6jzw2rGxZnPQXfQgdGSTISlIMTpCQ7BkzBRjSJl4Q0Y=;
 b=OW7IbFwoIA+wvODMbnaFMOgZjlib5bbkRb7oAueUFTJDUA5NXkj11V/msRVepOfmdNWJpokhtjDetdm2zVfIe1izU3GZNMhd1513vTMFGsPAzW7Oot7YknDqkR/7xzubQBCuOGV1uBYJjXNDXPIkxHonAB0wSlBGVxBQiRiilTo=
Received: from SA6PR21MB4231.namprd21.prod.outlook.com (2603:10b6:806:412::20)
 by SA1PR21MB2018.namprd21.prod.outlook.com (2603:10b6:806:1b5::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.15; Mon, 7 Apr
 2025 22:17:31 +0000
Received: from SA6PR21MB4231.namprd21.prod.outlook.com
 ([fe80::5c62:d7c6:4531:3aff]) by SA6PR21MB4231.namprd21.prod.outlook.com
 ([fe80::5c62:d7c6:4531:3aff%6]) with mapi id 15.20.8632.011; Mon, 7 Apr 2025
 22:17:31 +0000
From: Long Li <longli@microsoft.com>
To: Stephen Hemminger <stephen@networkplumber.org>, "longli@linuxonhyperv.com"
 <longli@linuxonhyperv.com>
CC: Wei Hu <weh@microsoft.com>, "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [EXTERNAL] Re: [Patch v3 6/6] bus/vmbus: set event for channel
 without monitoring support
Thread-Topic: [EXTERNAL] Re: [Patch v3 6/6] bus/vmbus: set event for channel
 without monitoring support
Thread-Index: AQHbpw41wZ6tLppZZU2QKZyIO8/F/rOYx0uQ
Date: Mon, 7 Apr 2025 22:17:31 +0000
Message-ID: <SA6PR21MB4231F5F74EF9F234090388F1CEAA2@SA6PR21MB4231.namprd21.prod.outlook.com>
References: <1743813338-28238-1-git-send-email-longli@linuxonhyperv.com>
 <1743813338-28238-7-git-send-email-longli@linuxonhyperv.com>
 <20250406090853.78499346@hermes.local>
In-Reply-To: <20250406090853.78499346@hermes.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=f4c33ef9-42e6-403a-a4d5-e573a91824ba;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-04-07T22:16:26Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA6PR21MB4231:EE_|SA1PR21MB2018:EE_
x-ms-office365-filtering-correlation-id: 37d912ca-b393-401b-1f69-08dd7621fd56
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?ORjEaCXvRMaquHDW70Chb0iyOGCj2vl7906q/A2FmPhmyKK/BEonWo7/Jbr8?=
 =?us-ascii?Q?56HITLvpMHD8CR2dB9fJBhHGy8NzHMu2P1ojh1q0YY50Bc4O1B/Fb82Z1wGV?=
 =?us-ascii?Q?AzDazszQbAF7FACmIhMUFERdviJTPwD5X3ctmIsWe/rFQldpafmVFnp2bmgR?=
 =?us-ascii?Q?x5j0tcZ9ncP4WrI0Oc3RV5y8t/AUtzDl9u3UKvNpnYH6oufNKjA01itAArjB?=
 =?us-ascii?Q?5lUx4mraDKPlrDyTdBcH690fsr3c42cVOXt7IEhN+uJtn/HVpFz5RX1dywhr?=
 =?us-ascii?Q?RQYf8Fv27JqaGW1gNLLIAeeLIqmoJezWx/z8YcgJRyOY054OkgphPk+Lj/wn?=
 =?us-ascii?Q?c3H3IuIQSivSPg9Uebq2OiE9At77KpyQCq1pf+AOg1T9YDTJBoiHJ6NOspbD?=
 =?us-ascii?Q?So8xdmVwJS9ResTRiz5E6s5uQbfKD8SlZSsvi2sWmTRQiXIDRS+9oVBbdNfe?=
 =?us-ascii?Q?UfXBoUrglSapYMvnAjdCu+ou9pBQZ7I+ku2l7ywJd65WhCqg01fNHG8ObsKq?=
 =?us-ascii?Q?DHLfO2+GRUoEPKD12qcr1JJDvdQiiaFywLcjcihs72xG62wB3uynqmZ9EHhh?=
 =?us-ascii?Q?fCwqEa4YM4Yqyebs8g9zqg9GX3/5NJyEqWyLPPQ/H7VHBE3+r1QG6PAE1ZDE?=
 =?us-ascii?Q?sOjHm+3bTrnspD0rE7Jq70FTw8qvajIiun0vhORcuGc7NHdeeRc9UAKojx1e?=
 =?us-ascii?Q?ZJrEsOHjRxTKRbfIcrC427wZ+1fWV3pZtdJrhsOhoTVfreMoF/hSr3Cf0i39?=
 =?us-ascii?Q?x+1O8dv+gANCbVs3LaYqGRROZXEOzM0ucUSr0tKJW8Bge3Pe9EDcPUuO+eL6?=
 =?us-ascii?Q?oj9GECSj2SAOa7h5pcBF0ghY4Q2xzx5otS00MS9kYKoM5S3MuatPLyrHmfWj?=
 =?us-ascii?Q?5VR9oXvA3XXxOgLkja3cExQflsnDvDVZrNyPtyDm8fIToqYBUM5YGzmrVwra?=
 =?us-ascii?Q?ZoO3Jl77z+nVq5QXA3UK8nq9QjtuBGEJGHvpwUBCNzgq33KJlbPojT5p7sua?=
 =?us-ascii?Q?nouBB3taxWLcSJz5yvECPP+l9JL4u4qQCsUEJ2LFFtjChF/3ZFxRNfBqHNxO?=
 =?us-ascii?Q?kq4kUWDUFAbHxEeSwRTfb5AhW5fnziVWVtl/EU5x4kSlBD2Z5xtlOucN0iH6?=
 =?us-ascii?Q?DASJH8X59yH/UUcFW2WIPptErF1UvV5B+pvVqiZft7ltxfiMfQfijBY/THZV?=
 =?us-ascii?Q?oA11a6WWJnkgJb31T0xVqP7p1kZaOGxAhUSMUqyYrMCqSQ+LmEB5VPitPrA2?=
 =?us-ascii?Q?19IYY9AW9LGGjhH8Z8KxXXJWlVUE+MS1we3H7PEj734UV0Qtwf2X5dVBXFB1?=
 =?us-ascii?Q?+0Mg/0oVTjJAeqC0vhjrK1jImHdw5y1FrSGkm8czMkdS3WeKvSsMTtjkPme3?=
 =?us-ascii?Q?8z2qFcQS/owJx9hHi/bF/gpmPslMmsA+YnPhLFpJIx/iIiLnaNCn5Bt1rTvE?=
 =?us-ascii?Q?WaeqKbcqXbiJ7ZxhoPmBbRv6+c3cSvo/LzTA3j4p2zBQCjpcaN6vAg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA6PR21MB4231.namprd21.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?TaxTTTViAEgcW6xti4rzGAj8ouWwYmrehj+/yESC/aNmNf66KhMF43Dof3Wz?=
 =?us-ascii?Q?UzD/OFZp9M+Vq3G4sMODygKUhcq2cmeFpiebRlNYsJWNw2bO0KY0X101SfmO?=
 =?us-ascii?Q?NRtyoXp63Z8/pa5g0IIMq1dgyn9EMeuJBnCp8NuIWabZkxIVh2fhKR5E8De5?=
 =?us-ascii?Q?gl8XnrBmLdlIat3AqUdFhXMoZEQvsWbD1J+4Drlk3XndTDM2264/hvRl/mEz?=
 =?us-ascii?Q?skwzWizEdHvJLcCX2T5WwNdkI/7f4UAgq9/72+cwWL7cdLjt3VKBgOD2eBX1?=
 =?us-ascii?Q?aHW7EgEV0/jqdLePGVDRPCLzw7WIfK4d0BY5kAmQGT4KV4+YK/4+UC6Vau9K?=
 =?us-ascii?Q?wUA5OIIT4dfOXtd9B0dZoprD4wuH9viYgfXWxtZaigSPDUWeaVjAI52G91D4?=
 =?us-ascii?Q?cY+8ZnASU62gMS4tGKyCd0+BgDO6rSs2X9v1NSIJUemva9H1FsWq23ak/9T0?=
 =?us-ascii?Q?zDYrbBcWN0drdCv+I5xzCuN0Wemtxt/le0kVlDI8c5pMuZFUq5ui8PpZY7wh?=
 =?us-ascii?Q?ZGXwGVIOcryCxLaasqo+kS4Q3fyTnzfunKGqEdvp1PEY14BZtyUh02oMpg70?=
 =?us-ascii?Q?PNpHAmtLn2WgCCDgglE7yHDBYWVMzEvXy8S3sbPDt30Qw8nTozOLnx1oRDYX?=
 =?us-ascii?Q?rh3PsrOpiYjVVV4Pswg3RjvPcnRA3W0dnmDAPJPv6x7vw1C5Je4ESEBpCEZG?=
 =?us-ascii?Q?3y59GSF6GHge1wJ0CDzFU9SmovQ1kB0fhcUQrcYQ+jUA/3FxgQVbgsXHMphK?=
 =?us-ascii?Q?b2vCdvTBd8ckOYJiTNgsPpK5Q1CrpPupunVMV3hpCQ1mNH0v5dtX12NvusKI?=
 =?us-ascii?Q?gM4OqoWKNaXUCVMv0lRxyEDbcl3iDVQ3II982793y0tSZ+D3sv5YJgQywHHo?=
 =?us-ascii?Q?i5nhPyX/eWXuZp15gZjVOu8SJb/sc77x8vgWImWyL7ZlWtFvIs7KLzESs3QU?=
 =?us-ascii?Q?/dnfHc32RoVpktq7GP3FiXahLkfmUFsW4Vby4/xBEJZXgTJkikXS66Z3WD2C?=
 =?us-ascii?Q?HoIIXN7Ne5IALutSCi1ReWyiyb+phGUVIP3ypU6N5Yfd/hmo4Jf4wT0d9yCK?=
 =?us-ascii?Q?mDo2+AIPSgvJmfXrX58OWUIKi0d2FqqNama6/N29qDPnbQ5/49MiXyIGkN1+?=
 =?us-ascii?Q?li3+MlPkQMsw9Oj7McjjkLjv7aMsIsy1Zxg4BWXmqFxgl2qFdk4+yqA8Nyum?=
 =?us-ascii?Q?ucibY9BnLCpZLaws33VC0BiA5idhSAazdZxjSMTDqPLvMabeFEifHK45bdPo?=
 =?us-ascii?Q?z9KzSFLoaWn57vmrswhNzs5UagSdT3Zf8xB/nucc1PGtoDc69Tuf85VAtTtU?=
 =?us-ascii?Q?9u9dECK32qXXiodyEQslqvAk+a/mYoO8Da4hBtlVfr4QUimzkh5divqlx/82?=
 =?us-ascii?Q?+X/8cDqKxrVNcfRVDhVSZxKn2egftnB1AmNXEFr3rhyZD0ow+Dyf2jOt7mTp?=
 =?us-ascii?Q?ORJeRsA1E0wA0TC8GrxSVfaIO1YDh8ud74xzvPJjYJEjBJn5k85Fj+oKppF5?=
 =?us-ascii?Q?k3k1VmQ1lOh4TnvYnHl0fa/ZpdAM+l3RawND9LzdD/7lwD4duxbjByGMbjDq?=
 =?us-ascii?Q?pyX6uNv71/Pm2VDND2hmeeSl6Nf0dy1ajeZiPfBp?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA6PR21MB4231.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37d912ca-b393-401b-1f69-08dd7621fd56
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2025 22:17:31.2481 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CV8QMgJh5nM2B3WL3r1YRLaQcogQfGB+8TjZj+m1XbaJHuvgsHKA5sV1Q1JjxC84rsWbm5ZCTm5VBCBX6qJY2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR21MB2018
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

> Subject: [EXTERNAL] Re: [Patch v3 6/6] bus/vmbus: set event for channel w=
ithout
> monitoring support
>=20
> On Fri,  4 Apr 2025 17:35:38 -0700
> longli@linuxonhyperv.com wrote:
>=20
> > diff --git a/drivers/bus/vmbus/vmbus_channel.c
> > b/drivers/bus/vmbus/vmbus_channel.c
> > index bccef168d3..81e8096190 100644
> > --- a/drivers/bus/vmbus/vmbus_channel.c
> > +++ b/drivers/bus/vmbus/vmbus_channel.c
> > @@ -24,6 +24,19 @@ vmbus_sync_set_bit(volatile RTE_ATOMIC(uint32_t)
> *addr, uint32_t mask)
> >  	rte_atomic_fetch_or_explicit(addr, mask, rte_memory_order_seq_cst);
> > }
> >
> > +static inline void
> > +vmbus_send_interrupt(const struct rte_vmbus_device *dev, uint32_t
> > +relid) {
> > +	RTE_ATOMIC(uint32_t) *int_addr;
> > +	uint32_t int_mask;
> > +
> > +	int_addr =3D (RTE_ATOMIC(uint32_t)*) (dev->int_page + relid / 32);
> > +	int_mask =3D 1u << (relid % 32);
> > +	vmbus_sync_set_bit(int_addr, int_mask);
> > +
> > +	vmbus_uio_irq_control(dev, 1);
> > +}
> > +
>=20
> This part doesn't look right. RTE_ATOMIC() is just a macro to add the _At=
omic
> attribute.
>=20
> Can it be simplified like this?
>=20
>=20
> static inline void
> vmbus_sync_set_bit(RTE_ATOMIC(uint32_t *) addr, uint32_t mask) {
> 	rte_atomic_fetch_or_explicit(addr, mask, rte_memory_order_seq_cst); }
>=20
> static inline void
> vmbus_send_interrupt(const struct rte_vmbus_device *dev, uint32_t relid) =
{
> 	RTE_ATOMIC(uint32_t *) int_addr;
> 	uint32_t int_mask;
>=20
> 	int_addr =3D dev->int_page + relid / 32;
> 	int_mask =3D 1u << (relid % 32);
> 	vmbus_sync_set_bit(int_addr, int_mask);
>=20
> 	vmbus_uio_irq_control(dev, 1);
> }

Thank you! You are right it should be RTE_ATOMIC(uint32_t *) not RTE_ATOMIC=
(uint32_t) *.

I'll send v4.

Long
