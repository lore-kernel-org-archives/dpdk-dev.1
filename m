Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7A09CED24E
	for <dpdk-dev@archiver.kernel.org>; Tue, 18 Nov 2025 09:51:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D876640281;
	Tue, 18 Nov 2025 10:51:17 +0100 (CET)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013054.outbound.protection.outlook.com
 [40.93.201.54]) by mails.dpdk.org (Postfix) with ESMTP id 2146540150;
 Tue, 18 Nov 2025 10:51:16 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NTxI/2jYE1l43aX8GXl4w5qK//mq8273gfUL9yFAAMFZsQV6Ad4EmzVT5mf7Wyz2QBpOr/SpjsxIX+OPryIgStRzi+QFMdxufJ9SpYmBk8NiS74f3ts95I6/3ryh7RJhGvSY6Vu6Z5WpsH2AqCGJ5xKy/fbtDK6suonT6+nPFWQnirF2bwKTOzVZsGyRhApbc2bHO8WD6WEnzhGQME2Qg99+3EzWPV+A5bIjS5ipCh5F7AgJSh/6MaROG7k4bKp4fGDvjFI4mDLdlqNqL566LylMKV6PAmhpNWhrzMQOMmZl9+To6C3QlEdMwf9VQUdZk1FH6Rkfk/RkAdzypxKBNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OIaNZPxU1AnqAIWG1bP6lWYL0eUbeJpcmw1Phs0NUUw=;
 b=QnKxS5a8dRhUIvJD/4afvHMSztTYDty6p5tuZnVgCl6ODr/CZGNYcd6FFCVu7zIu8FdSD+yidRbmLO2yu3pI6+z8/rb7T+mCEJ68zQoRZgYEriiyrZU+MJjBGdjBLEUnok7zirAVe+rpgzW+WqLCdOEfY8WF2WtV0bJH7jQiWDJ1DsDOtfJV5RqHPLwrpq9eTSOw4VzeEpilKfxAPyfYuYUvgseH4/iXZbbE25J7J1d970AkJklubBnhUKndsont6LsAoW67lO8quCtXl60fvoCSl04XlKZ9Uk4aoIq5bAvdlUUEEY0SkHNvE26sRYTikIK9epRRpqaFJXN6RwUx2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OIaNZPxU1AnqAIWG1bP6lWYL0eUbeJpcmw1Phs0NUUw=;
 b=kDFKsMEbuFMcQOwfsk5OXJl79t02i4C0Xl3bvG98C7jH5cY0IKRAvPZBJ3yAe4DANPXSGc5ch2SBc705jYC2TyeEhKGqZJAIB6k4++y+yxHZtnheqwFNYVa1QrEzeVpdPgSp21ZffiLwIXe/vY9hMHtfMxGXO5gDuI6pISdIzbD0RxQNoCAZeUpdu6wTdLYhIdJn2QYhZc7txhyCjO8IFn82Y/Rpmy7JZa3VGZ39wpqeBGM1eWZKJ43l2WgqucneA4IFmKpzdeYCAR5UtXZ16P8bSFOIvF+V8TKqqlZTpdSMr0DVIIZ6HBm/0s+zfT+bO6WQ59XZ7i+yuAy9tQMhHg==
Received: from IA4PR12MB9763.namprd12.prod.outlook.com (2603:10b6:208:55a::20)
 by DS0PR12MB7728.namprd12.prod.outlook.com (2603:10b6:8:13a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.21; Tue, 18 Nov
 2025 09:51:10 +0000
Received: from IA4PR12MB9763.namprd12.prod.outlook.com
 ([fe80::b979:500f:1457:eab7]) by IA4PR12MB9763.namprd12.prod.outlook.com
 ([fe80::b979:500f:1457:eab7%2]) with mapi id 15.20.9320.021; Tue, 18 Nov 2025
 09:51:09 +0000
From: Bing Zhao <bingz@nvidia.com>
To: Dariusz Sosnowski <dsosnowski@nvidia.com>
CC: Slava Ovsiienko <viacheslavo@nvidia.com>, Ori Kam <orika@nvidia.com>,
 Suanming Mou <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>, Itamar
 Gozlan <igozlan@nvidia.com>, "dev@dpdk.org" <dev@dpdk.org>, "stable@dpdk.org"
 <stable@dpdk.org>
Subject: RE: [PATCH] net/mlx5: fix higher flow tag indexes support on root
Thread-Topic: [PATCH] net/mlx5: fix higher flow tag indexes support on root
Thread-Index: AQHcVaPJWmroSbP15UCCFSOv5ZXyRLT4EpoAgAAjRACAAABoIA==
Date: Tue, 18 Nov 2025 09:51:09 +0000
Message-ID: <IA4PR12MB97631CBA8C0C309EADC7752AD0D6A@IA4PR12MB9763.namprd12.prod.outlook.com>
References: <20251114201720.1639238-1-dsosnowski@nvidia.com>
 <IA4PR12MB9763D2FCFBED63E2F52C7A2CD0D6A@IA4PR12MB9763.namprd12.prod.outlook.com>
 <20251118094904.7vubnbfaaa23kukc@ds-vm-debian.local>
In-Reply-To: <20251118094904.7vubnbfaaa23kukc@ds-vm-debian.local>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA4PR12MB9763:EE_|DS0PR12MB7728:EE_
x-ms-office365-filtering-correlation-id: 9ddd5961-588e-4c7a-c9a7-08de26880032
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?1x2H4caN69bOPqTlPdkBGlWf/q/bB73zD8D3jSUrT6341cjlym0R8A2uL+1Z?=
 =?us-ascii?Q?lgJB6n/D7Eisiv5I/+YIzDY1UbPC9m4PmE2l7LbcgJDmSd719HY8bB08c6Zf?=
 =?us-ascii?Q?1+whKwgsILFM9TfRSMci3DpiHE3/Mqn/Vw1iZoP3Qhc0SRJTPTiMLM4W+md0?=
 =?us-ascii?Q?TRDdgIKGKe1X28v0Hpg62sMq+W+kH3bWTM/16icZrS3bZ6QUbnWeaAqBcGph?=
 =?us-ascii?Q?I4oLdOcbCAMnQVrn6xsTenBk0u5HdjxyiSh/jR44XpTJXwOTtvewaB6/DSbi?=
 =?us-ascii?Q?Sr7GmdWDzIzr0IWnegAkcAnwQ4nlYZIrcce1mplw08Jeey1nRdK9Qti04fSo?=
 =?us-ascii?Q?XBK4mgB+nRmvTFeey4xnZKCFwYX2FWP4TGf7dba3Zboj2ZNeA1F0GSeOi6Uc?=
 =?us-ascii?Q?8pTOmDx6n+zuvz7CAr7Lu/5+M0l6tYVs21iXPdu1m10EtxY2qYrizOA2sSb1?=
 =?us-ascii?Q?0Sl3HoPiD3b7zQOLNkKofu+JXWb74EJv5iew2G3KLNBVr7+7PDu6edDtNNWP?=
 =?us-ascii?Q?V0hCucapx1cSaZfz267kooZ4opY4x59ssTa+xmhGl2RY59N9UidC17taM71B?=
 =?us-ascii?Q?MlCqF/8SlYT3ENipY9VyYVdmqOTdaGMOjwNx983lOsYWQQj4xn4EFehso0VW?=
 =?us-ascii?Q?42+ayJacRTLRIOT1jiGefJ5BpGMPUoDlZ9YLYf5xiJAo3QekMBbuEZLPpehw?=
 =?us-ascii?Q?tpQAipcBalQmYGokqJjry4Qc1+R+qCdq0cWHTY/fKs6iXw6VOhqQV52VpzxK?=
 =?us-ascii?Q?chFNZg9cr0o95nIHKQBnH63K1fzQCuZGZ7U7NXi1mNbH2IwBoMFkBRZqhUwl?=
 =?us-ascii?Q?ApQutxzfctPkzXj6o9yGWgrMEonxZGH3KUZm72kzGfslbUZwlkC11M7i/Lze?=
 =?us-ascii?Q?K0B5nr0oO5ZlnJXiYsHet/lNXqnOqysVvN9Wl6ktXhS9RsFtNazICaKA8kxa?=
 =?us-ascii?Q?Of+7lemf4bQvXQ215LOFMJFtVx937+WAxSLzlZWe4dnGkXNl6FATAG12F5pa?=
 =?us-ascii?Q?FWRn8CaLlxVHMTPcT31foIUWuTD2sN/SpI0D8l0yFOkbteqJqvqo7ZpW43Gt?=
 =?us-ascii?Q?z6HWGdv5E5KPSSZYyBDMSeNTX1ap/1c/KtTIyJHAwef3x8h+fdruDud5e6g/?=
 =?us-ascii?Q?iWOtbb0wtC5sgEIjtVv8ySjTACWxfd5arIaDUJC2DY4eo4cAktIvFJsm5Q1Q?=
 =?us-ascii?Q?p5JIlgklC6+UH4+i8GK0pNLuStyzUCfFrdOrC54hmbAmRk//pNigPRiJHFfX?=
 =?us-ascii?Q?PEPzdTT+Lce9BQej8xpjPOZiaFhC4erx7p2QWdFewjZsV9KmDn8arAzt+Pi6?=
 =?us-ascii?Q?Z/WcFHaLtUWSjHS7nbqEy1Jizj5plhN9gme98iE6nx/IaeSE8Y0tSBKXMSHb?=
 =?us-ascii?Q?vCUMhsEd2HNnfN436s2wfO2Jy+k94n4ajNbwV6W/Q0PaV17jgJAeU+q2sFuI?=
 =?us-ascii?Q?RVjXqsfF3ttduxKDPwyuS273ZGFvqcUG95RCa5b3gYk5J4d0I42wQ1EASxAU?=
 =?us-ascii?Q?d14QT4zdmsIKL8yiopBz1AN2umKE3RoKTBrX?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA4PR12MB9763.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?t4NHyR3WWUr91o59m4PYISKnfPJTc+5zxEujyHm32N2mO8Q9ZTGjtWLYjNzv?=
 =?us-ascii?Q?jxu9sNUgVSgCBK/QHb4V0ozTCvM69Gvneseyoc4Tficwmq06qpuLNTMJOFIS?=
 =?us-ascii?Q?8dZBjEUvfQ0bGgA1wsJXeh9wtdRE4Pc92uxq6Q/H9xc70xl+wzrU+zWk+zD9?=
 =?us-ascii?Q?gMD4ychr14CQoOfMRNWkVVppO8Y2s6k+olzoOBUprcOVZIzeAVHHmieqoDHx?=
 =?us-ascii?Q?EaBxnCRSGX0/oT8r5TbRV+9VEXLqs5TtVghX0AAfygilv3IxF0QXovb2+ear?=
 =?us-ascii?Q?X1Bz1e2i6h9Z4nP+O/7D/HSM24uWbHdlxibwG4zCvd/VF27N+pJmM4w6Ht2d?=
 =?us-ascii?Q?TPv9BsBL2JpC3rd8FaJ+JYctkaQRvmAc/VKp03sLKqomgqx11VF21EV/In+j?=
 =?us-ascii?Q?GeNBb4bd3GaKSjGvnWr7OTjNJ8zMd7pZ6UxTYnjYZaWGA5YKhhRdp3gnyTIf?=
 =?us-ascii?Q?lQ29o/hNZrQ2KOxwEycP2NvK3ADq+XL+RyPUuBceVIizTbGenYHCbyytGcy7?=
 =?us-ascii?Q?FkqBnSb/UVc6i55z9j1ZgwbT3wnslzUuK9eKCgpluRcYm+oRrBtxMW0Hh4+O?=
 =?us-ascii?Q?ld3Vd+ydbRm9fWiuloAMSOEg3JYjynKRkEbrojoi2tg9Am0kVKSx8cHZvMRP?=
 =?us-ascii?Q?8iUkDLXctkBCZutqQi+McoKjqL413HDr6nCw/LLSgFJjpL/ermJSVLDd0C5+?=
 =?us-ascii?Q?VuTmI1brXSRMLSUjV5dc1m10EZV0fjHmxeaAfjPsZ/gWF+jWCzB51918xCxa?=
 =?us-ascii?Q?ZpM+MQufXOJKBUDvDgikH1fkoSS0VCWnt2IA4HcNJP2cOiTtblYD6X4U5wGt?=
 =?us-ascii?Q?KmywgYp/413kEq/KtHTw52LdweSwt+19+yct0SG2g9vukkF4rQLI936+JqHq?=
 =?us-ascii?Q?Qs0F6tmMpqPD40j0QYR6+qjzTFDdW6iTuOtJqnuVUtTHhK0GzIhTgWw6LFLs?=
 =?us-ascii?Q?gk53SJVvUM47Y5eblw+nSszaQl/+hhEQqogX7krCCE2B5R4xtOU2JYPFctXL?=
 =?us-ascii?Q?bJhDG/PJVo4DLj0NyEBVBoE2u0s6CZqHVFq7v1mnf9/7SyChzhWBlx8sOl/f?=
 =?us-ascii?Q?lvYDTgT2dpFA1OtIv/MQ+hIXvb9rGIskNYafWJm6QEsMkIdih19GZ0ICL1dc?=
 =?us-ascii?Q?0hzajQOML/LJyiORXIfoJLqjy4wBfS97QJWK1Kb/hT0S6CfZOBr+oMpdkxSR?=
 =?us-ascii?Q?1ljOxYAl32Pne6jxYi5ee12FbWnHGvxRPYPRnLHigwgXx8kVvLQ8FE2y5VJ6?=
 =?us-ascii?Q?6fWfNjctGXYY38BogE2ARDrQBKkgPu0uKPM8AAHiE8kekO599/i9Mvgb6iwv?=
 =?us-ascii?Q?j8QqKh2VLXrYqMRPrMiF+cL2mIraKzAyCQcyw1uNE6bPyBkpIMBgFunvq32n?=
 =?us-ascii?Q?VftCkDkdW5c6tzv+xDwfujMwCBwGWX3f0CZnWYjrkrZcEmV9J0akGUeAVtSC?=
 =?us-ascii?Q?rF+mgNMUuzmUc/8j//CVDoJUncHYbcCPIx9MRRFFItvtDlKBxFrsuBINBS6q?=
 =?us-ascii?Q?QS/XsjyQYpASp2gFd9fWVz24n/gHyu5kWG03IM4am4PjG9VFEcWGmAjfsKFO?=
 =?us-ascii?Q?8gm/k0VZCZViBZfjpbI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA4PR12MB9763.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ddd5961-588e-4c7a-c9a7-08de26880032
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2025 09:51:09.3546 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5n/CeXgJF7nu7GjSiqXmLdZEl8qEYSGFqX5csnV7DFh1psF2jTW6/AqcgyWmuRlD8HoKL8X/XxHLY2RLNlejPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7728
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

Hi,

Now it is clear to me.

> -----Original Message-----
> From: Dariusz Sosnowski <dsosnowski@nvidia.com>
> Sent: Tuesday, November 18, 2025 5:49 PM
> To: Bing Zhao <bingz@nvidia.com>
> Cc: Slava Ovsiienko <viacheslavo@nvidia.com>; Ori Kam <orika@nvidia.com>;
> Suanming Mou <suanmingm@nvidia.com>; Matan Azrad <matan@nvidia.com>;
> Itamar Gozlan <igozlan@nvidia.com>; dev@dpdk.org; stable@dpdk.org
> Subject: Re: [PATCH] net/mlx5: fix higher flow tag indexes support on roo=
t
>=20
> On Tue, Nov 18, 2025 at 07:44:37AM +0000, Bing Zhao wrote:
> > Hi,
> >
> > Code LGTM, but I have 1 question. Does the root group really supports s=
o
> many TAG registers?
>=20
> Yes, but it depends on the NIC capability.
> REG_C_8 through REG_C_11 are available only in ConnectX-7 and up.
>=20
> >
> > If not, do we have a need to translate them and pass to the driver to
> get the return error code from the driver then?
>=20
> There's no need to rely on the kernel driver.
> mlx5 PMD queries FW capabilities to determine which registers are
> supported.
> Based on that, a map of flow tag indexes to HW registers is constructed.
> If given tag index cannot be supported, this map will contain REG_NON.
> This info is used to reject given flow rule in case it cannot be supporte=
d
> (in flow_dv_translate_item_tag()).
>=20
> >
> > > -----Original Message-----
> > > From: Dariusz Sosnowski <dsosnowski@nvidia.com>
> > > Sent: Saturday, November 15, 2025 4:17 AM
> > > To: Slava Ovsiienko <viacheslavo@nvidia.com>; Bing Zhao
> > > <bingz@nvidia.com>; Ori Kam <orika@nvidia.com>; Suanming Mou
> > > <suanmingm@nvidia.com>; Matan Azrad <matan@nvidia.com>; Itamar
> > > Gozlan <igozlan@nvidia.com>
> > > Cc: dev@dpdk.org; stable@dpdk.org
> > > Subject: [PATCH] net/mlx5: fix higher flow tag indexes support on
> > > root
> > >
> > > Offending patch introduced support for additional flow tag indexes
> > > with HW Steering flow engine. New tag indexes will be mapped to HW
> > > registers
> > > REG_C_8 to REG_C_11, depending on HW capabilities.
> > >
> > > That patch only handled tables created on group > 0 (non-root
> > > table), where mlx5 PMD directly configures the HW.
> > > Tables and flow rules on group 0 (root table) are handled through
> > > kernel driver, and new registers were not addressed for that case.
> > >
> > > Because of that, usage of unsupported tag index in group 0 triggered
> > > an assertion in flow_dv_match_meta_reg().
> > >
> > > This patch adds necessary definitions for REG_C_8 to REG_C_11 to
> > > make these registers usable for flow tag indexes in root table.
> > > Validation of flow tag to HW register translation is also amended to
> > > report invalid cases to the user, instead of relying on assertions.
> > >
> > > Fixes: 7e3a14423c1a ("net/mlx5/hws: support 4 additional C
> > > registers")
> > > Cc: igozlan@nvidia.com
> > > Cc: stable@dpdk.org
> > >
> > > Signed-off-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
> > > ---
> > >  drivers/common/mlx5/mlx5_prm.h  |  6 ++++-
> > >  drivers/net/mlx5/mlx5_flow.h    |  3 ++-
> > >  drivers/net/mlx5/mlx5_flow_dv.c | 40
> > > ++++++++++++++++++++++++++++-----
> > >  3 files changed, 41 insertions(+), 8 deletions(-)
> > >
> > > diff --git a/drivers/common/mlx5/mlx5_prm.h
> > > b/drivers/common/mlx5/mlx5_prm.h index 5db8d67cfc..ad3cca5bd6 100644
> > > --- a/drivers/common/mlx5/mlx5_prm.h
> > > +++ b/drivers/common/mlx5/mlx5_prm.h
> > > @@ -1205,7 +1205,11 @@ struct mlx5_ifc_fte_match_set_misc5_bits {
> > >  	u8 tunnel_header_1[0x20];
> > >  	u8 tunnel_header_2[0x20];
> > >  	u8 tunnel_header_3[0x20];
> > > -	u8 reserved[0x100];
> > > +	u8 reserved[0x80];
> > > +	u8 metadata_reg_c_8[0x20];
> > > +	u8 metadata_reg_c_9[0x20];
> > > +	u8 metadata_reg_c_10[0x20];
> > > +	u8 metadata_reg_c_11[0x20];
> > >  };
> > >
> > >  /* Flow matcher. */
> > > diff --git a/drivers/net/mlx5/mlx5_flow.h
> > > b/drivers/net/mlx5/mlx5_flow.h index e8b298dd1d..fa2af91d66 100644
> > > --- a/drivers/net/mlx5/mlx5_flow.h
> > > +++ b/drivers/net/mlx5/mlx5_flow.h
> > > @@ -1833,7 +1833,8 @@ flow_hw_get_reg_id_by_domain(struct
> > > rte_eth_dev *dev,
> > >  	case RTE_FLOW_ITEM_TYPE_TAG:
> > >  		if (id =3D=3D RTE_PMD_MLX5_LINEAR_HASH_TAG_INDEX)
> > >  			return REG_C_3;
> > > -		MLX5_ASSERT(id < MLX5_FLOW_HW_TAGS_MAX);
> > > +		if (id >=3D MLX5_FLOW_HW_TAGS_MAX)
> > > +			return REG_NON;
> > >  		return reg->hw_avl_tags[id];
> > >  	default:
> > >  		return REG_NON;
> > > diff --git a/drivers/net/mlx5/mlx5_flow_dv.c
> > > b/drivers/net/mlx5/mlx5_flow_dv.c index 95ca57e8c4..2a8bdd498e
> > > 100644
> > > --- a/drivers/net/mlx5/mlx5_flow_dv.c
> > > +++ b/drivers/net/mlx5/mlx5_flow_dv.c
> > > @@ -10560,8 +10560,8 @@ static void
> > >  flow_dv_match_meta_reg(void *key, enum modify_reg reg_type,
> > >  		       uint32_t data, uint32_t mask)  {
> > > -	void *misc2_v =3D
> > > -		MLX5_ADDR_OF(fte_match_param, key, misc_parameters_2);
> > > +	void *misc2_v =3D MLX5_ADDR_OF(fte_match_param, key,
> > > misc_parameters_2);
> > > +	void *misc5_v =3D MLX5_ADDR_OF(fte_match_param, key,
> > > misc_parameters_5);
> > >  	uint32_t temp;
> > >
> > >  	if (!key)
> > > @@ -10607,6 +10607,18 @@ flow_dv_match_meta_reg(void *key, enum
> > > modify_reg reg_type,
> > >  	case REG_C_7:
> > >  		MLX5_SET(fte_match_set_misc2, misc2_v, metadata_reg_c_7,
> data);
> > >  		break;
> > > +	case REG_C_8:
> > > +		MLX5_SET(fte_match_set_misc5, misc5_v, metadata_reg_c_8,
> > > data);
> > > +		break;
> > > +	case REG_C_9:
> > > +		MLX5_SET(fte_match_set_misc5, misc5_v, metadata_reg_c_9,
> > > data);
> > > +		break;
> > > +	case REG_C_10:
> > > +		MLX5_SET(fte_match_set_misc5, misc5_v, metadata_reg_c_10,
> > > data);
> > > +		break;
> > > +	case REG_C_11:
> > > +		MLX5_SET(fte_match_set_misc5, misc5_v, metadata_reg_c_11,
> > > data);
> > > +		break;
> > >  	default:
> > >  		MLX5_ASSERT(false);
> > >  		break;
> > > @@ -10825,8 +10837,11 @@ flow_dv_translate_mlx5_item_tag(struct
> > > rte_eth_dev *dev, void *key,
> > >   *   Flow pattern to translate.
> > >   * @param[in] key_type
> > >   *   Set flow matcher mask or value.
> > > + *
> > > + * @return
> > > + *   0 on success. Negative errno value otherwise.
> > >   */
> > > -static void
> > > +static int
> > >  flow_dv_translate_item_tag(struct rte_eth_dev *dev, void *key,
> > >  			   const struct rte_flow_item *item,
> > >  			   uint32_t key_type)
> > > @@ -10838,7 +10853,7 @@ flow_dv_translate_item_tag(struct
> > > rte_eth_dev *dev, void *key,
> > >  	uint32_t index;
> > >
> > >  	if (MLX5_ITEM_VALID(item, key_type))
> > > -		return;
> > > +		return 0;
> > >  	MLX5_ITEM_UPDATE(item, key_type, tag_v, tag_m,
> > >  		&rte_flow_item_tag_mask);
> > >  	/* When set mask, the index should be from spec. */ @@ -10848,8
> > > +10863,18 @@ flow_dv_translate_item_tag(struct rte_eth_dev *dev,
> > > +void
> > > *key,
> > >  		reg =3D mlx5_flow_get_reg_id(dev, MLX5_APP_TAG, index, NULL);
> > >  	else
> > >  		reg =3D flow_hw_get_reg_id(dev, RTE_FLOW_ITEM_TYPE_TAG, index);
> > > -	MLX5_ASSERT(reg > 0);
> > > +	if (reg < 0) {
> > > +		DRV_LOG(ERR, "port %u tag index %u does not map to correct
> > > register",
> > > +			dev->data->port_id, index);
> > > +		return -EINVAL;
> > > +	}
> > > +	if (reg =3D=3D REG_NON) {
> > > +		DRV_LOG(ERR, "port %u tag index %u maps to unsupported
> > > register",
> > > +			dev->data->port_id, index);
> > > +		return -ENOTSUP;
> > > +	}
> > >  	flow_dv_match_meta_reg(key, (enum modify_reg)reg, tag_v->data,
> > > tag_m->data);
> > > +	return 0;
> > >  }
> > >
> > >  /**
> > > @@ -14408,7 +14433,10 @@ flow_dv_translate_items(struct rte_eth_dev
> *dev,
> > >  		last_item =3D MLX5_FLOW_LAYER_ICMP6;
> > >  		break;
> > >  	case RTE_FLOW_ITEM_TYPE_TAG:
> > > -		flow_dv_translate_item_tag(dev, key, items, key_type);
> > > +		ret =3D flow_dv_translate_item_tag(dev, key, items, key_type);
> > > +		if (ret < 0)
> > > +			return rte_flow_error_set(error, -ret,
> > > RTE_FLOW_ERROR_TYPE_ITEM, NULL,
> > > +						  "invalid flow tag item");
> > >  		last_item =3D MLX5_FLOW_ITEM_TAG;
> > >  		break;
> > >  	case MLX5_RTE_FLOW_ITEM_TYPE_TAG:
> > > --
> > > 2.39.5
> >
>=20
> Best regards,
> Dariusz Sosnowski

Acked-by: Bing Zhao <bingz@nvidia.com>
