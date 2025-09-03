Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FC12CA1009
	for <dpdk-dev@archiver.kernel.org>; Wed,  3 Sep 2025 09:22:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 17218402BC;
	Wed,  3 Sep 2025 11:22:56 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTP id C0EA040261
 for <dev@dpdk.org>; Wed,  3 Sep 2025 11:22:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1756891375; x=1788427375;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=T6Iub5c970yKhRuIo32/6AaZ2VRj4YFQSaQEQJhqyY0=;
 b=aGNtyHS2iHinnI4vow3h3iwgvV4bU8TMbSFIBi5Marrub0GgaQhg6RAA
 aPyx9lv7Q4S4xzm82uDuG5+Jxjq2dyCUhANCYFLnlQqzNINtFcAGobIJ+
 h4GZW5IKn9dTyz/BzuIQn0GcdQHFhZxDedNJ9TMcL1R6uLYBngW+0gHiP
 dmz6QJ5zzyFw+5yJKzyHNk7mLVA9rS1oUXJqp81+l37P9MYfOXXNcNvwH
 HaA0Dmeepak+VG0GomeUXXo+/adRrqUWstzX+qYF3Y4GFkeVRvjbtBWXL
 S3wWBe5ILp4BlFkunIWfJZYmt1HWu/8WrDTsVShWiCuFY4vt4TNUq5ovP A==;
X-CSE-ConnectionGUID: LlAJp+RMSk6nC0i3k5FFYQ==
X-CSE-MsgGUID: V1M7yI5sSP2CoMf7RKzjBA==
X-IronPort-AV: E=McAfee;i="6800,10657,11541"; a="69459446"
X-IronPort-AV: E=Sophos;i="6.18,233,1751266800"; d="scan'208";a="69459446"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Sep 2025 02:22:53 -0700
X-CSE-ConnectionGUID: c7NCu/wYQKOYDP/aqEc3/g==
X-CSE-MsgGUID: xL2HLGWYSeOPbzoyS+m5LA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,233,1751266800"; d="scan'208";a="195169393"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Sep 2025 02:22:53 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 3 Sep 2025 02:22:52 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Wed, 3 Sep 2025 02:22:52 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (40.107.93.73) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 3 Sep 2025 02:22:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x3PWhT5nTg2XUy/n3hX8lQy510pBUPdAmAtMGzDmktwTvmzXsQ38Dw5cBxsqDJ7bkio58Ske6K95YmdmERWKy4NmXr+OcUHv0AJG2KilD1ETSLALb8hZfH4JTCuaQzLjcVXsL9r0KMjwn2d02LnIP/iY/jCSGrvtNTzu9TBVFrYTmD+anDymGJfQMfNGT5EG24wsiVcxWUzmFVIzAEksA2jwFBT0bbDGbNQDUo1/HwM/OWMnomJwc4uO1vfuGNp5vemMyMzMSTBHv/8+oM53zq1miryXuejyaYXp43HpFq2Uaa23tRm+sGgeMCFQ/vyXreciiJM2bRGR4XWo1rbe0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T6Iub5c970yKhRuIo32/6AaZ2VRj4YFQSaQEQJhqyY0=;
 b=wpFBpoe4u4jEejtZTmv7C+6dG3qHc9FJe4oOztmiK+jogxs0tVf6VIelmswAq0imxnDsr2kuyh/1jE6YnVqyv9xV4ljUqjA0kkIruE7OaWj/ByhGtdAns5T1oNj2SNNS/vuPJ6CYNdFS7aOEviqglqjr3e0dDZknIY8XR5tcl+awS7MyPIzRvWpojtL+XZlwjLDh43uCk3PAgAOxYs4rV7v40gSYP1cWwmGN63Il7xc7peenTsRY6njeeeHX90mtn/uxqDY+e/qSWTQAnRGQiPfsv4z5Ch+5hoOfZY1b8wvt7qhFIo3W0dAamFcvYuiuorMzSyxFGYsy4UXFzRNDAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM3PPF7D18F34A1.namprd11.prod.outlook.com
 (2603:10b6:f:fc00::f32) by SJ2PR11MB7425.namprd11.prod.outlook.com
 (2603:10b6:a03:4c0::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.29; Wed, 3 Sep
 2025 09:22:50 +0000
Received: from DM3PPF7D18F34A1.namprd11.prod.outlook.com
 ([fe80::e891:61bf:88e7:bd9c]) by DM3PPF7D18F34A1.namprd11.prod.outlook.com
 ([fe80::e891:61bf:88e7:bd9c%3]) with mapi id 15.20.9094.016; Wed, 3 Sep 2025
 09:22:50 +0000
From: "Loftus, Ciara" <ciara.loftus@intel.com>
To: Ivan Malov <ivan.malov@arknetworks.am>
CC: "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [RFC PATCH 1/3] ethdev: add set link state on close API
Thread-Topic: [RFC PATCH 1/3] ethdev: add set link state on close API
Thread-Index: AQHcGO2cSLwYNevyYk6rxQI+k1asQbR5vtYAgAd3QKA=
Date: Wed, 3 Sep 2025 09:22:49 +0000
Message-ID: <DM3PPF7D18F34A1CAF2F4F05ECF6EABC8A58E01A@DM3PPF7D18F34A1.namprd11.prod.outlook.com>
References: <20250829140224.1748255-1-ciara.loftus@intel.com>
 <20250829140224.1748255-2-ciara.loftus@intel.com>
 <3f8ed682-28d4-c90a-8547-8d1e98595f79@arknetworks.am>
In-Reply-To: <3f8ed682-28d4-c90a-8547-8d1e98595f79@arknetworks.am>
Accept-Language: en-IE, en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PPF7D18F34A1:EE_|SJ2PR11MB7425:EE_
x-ms-office365-filtering-correlation-id: 422f6e5f-65c7-44c3-6d2f-08ddeacb73eb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?VsJii7qCAR2JZxfmvVF+A5lw0AXrDTH+OfASBr80nl6dMRhECa1yMQzdNqrd?=
 =?us-ascii?Q?zPar6Qr/6GXrUqz3iayRFmAnRI7n+d9s8ldv97fKrgPKukd/jFaH+k5k6XqP?=
 =?us-ascii?Q?xHLxDCGdbGDj9JMRn2m68ylWtgJgXef9U7+cdtlS8t9cli+XDCgtfTwZS7/l?=
 =?us-ascii?Q?8nMae8MPwsnyKPPte5mj/ynIPjZrVXvNo6vCHSv2w9Du8Qru2FBve2Q5lKNq?=
 =?us-ascii?Q?FImVWRN87yvt92bZqKP8raRJ1W/y2Dl7wShhec0Lc9rRVrCIt2E0h1bTbLoR?=
 =?us-ascii?Q?E/qyA59LO8Sqadq6ReKcgD2fcgypCQGOq1Ty6+CWJ8JHaVAB/Wh26tpRDcW7?=
 =?us-ascii?Q?ljU8wj3u/7vWWc/dDSThkUnxy3s74AYeR5oIXzqQpL0cFUTwVQ0sj6lp7QOn?=
 =?us-ascii?Q?T4jQVd3sBPY2h6+l1YQyQ77bzmXcV0fH1evd6bDuHfZAot4P9gelBpeNSSks?=
 =?us-ascii?Q?kagSrD0LosvEE10rnPlGDBNvaSaMx66lmoDi9umCS9E8taBj8R3F0yek1N/I?=
 =?us-ascii?Q?SeYOSFynj/ESEhxRbMF1RF8KD6tCkZ/k3yPphKOwz154dw1HI0Priumha4MY?=
 =?us-ascii?Q?rYeM1OxirmO9Vqq5loBFxNDIxGZt3bEKaxbobjooHZyuDfwg+J7qal/e/N8X?=
 =?us-ascii?Q?vJKEFUd/kxIjwPg+jYzmQuQpxGZjweC73l/S9GLXou1yp/Iq0p7OijH7ONLq?=
 =?us-ascii?Q?jErRRhQINw2/7E1e8CByCLWYp8Pt8Nnhe1wqbU69XRYHyQe3wDVkkMR8gt/f?=
 =?us-ascii?Q?C4Sfg/G51GW6KJ0M8+FW9HhmGjI0RvRtS2Py4TEb2FQdBnaZofwWcbKcukck?=
 =?us-ascii?Q?07Jb2t4c/Td2k5sV3eyrirXSMy0ecucFnWMfPR54gKlJEuSVW2N1dDpOpGRk?=
 =?us-ascii?Q?soaIooM6Sabf4qNNyNutiybYZMGp7LWfF7IznwewiqfYqqCNaChlkJNGR+44?=
 =?us-ascii?Q?An+6c0sN0xB5uSWpap6gN4vOvyTkhd2o0WEFggaqHaoiyMhxMpXyazgsu7lH?=
 =?us-ascii?Q?0Tr4cXIBxuLk9adYbEAdXOSj4G8+0D4pSS9NlMReeR+q2D+IEyWrLCzIC91Y?=
 =?us-ascii?Q?TEttWbpd7JJx8BdlFvFyj1IB1bLEV4vRkYRNfWulFCxvdSEX0iHbRJAZYiEG?=
 =?us-ascii?Q?H1eogd9o7Z1K5pdO1FWPAM58qDaXLsea5QZcRz1Q+Y3jLxYGCNGrUD7f+vqq?=
 =?us-ascii?Q?kMHnL+Umo8HaElwV9BSK1bGhbZMolfmkk5YU/xvh7A3Kh2VUKMPPnyWrcHmZ?=
 =?us-ascii?Q?35nlR2NNTyJeJ6IFK2DfER2JK56pZp9E4H3jSUFwjQB4Fe25cahBoVIrJA6A?=
 =?us-ascii?Q?jliHEjHSNVEejkDWAn+3e3CKeOUSn7sjZ22NDjD0kh1SLiTX4wImD8xBH4T+?=
 =?us-ascii?Q?nPVuQO0LPbDdzNCjjuyMZw84S9lIRXjxIrQQ7yXa/81n2lqtms8JiAkQ8+3J?=
 =?us-ascii?Q?j+A78ccdO94Pc7bclnVUQ8khh8wr3DE2qOfnX4TH/M0rbqoN2ZivZA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM3PPF7D18F34A1.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?5fd970T1y1qWqcUXvPrUuxF88o5Q3w/PReAUt9Ha8AX/LvL+EusZv9F0XTOK?=
 =?us-ascii?Q?VN3WwV7RMLKEk0bnTlioyrjWcDYTYJy2SVYgUcUKvmz1Mh3wCa625+IiIEvS?=
 =?us-ascii?Q?0QjDLlESKmJBlFYETHMPULDalkxyZp5N1fyq6I6TMDH8jTHxW3JvZNDC75HK?=
 =?us-ascii?Q?pCu435rS87x766Ke7EwAk2ZcjXapD0Y/sXltjbqkyRzmrsQ4Eli9pzltfKjr?=
 =?us-ascii?Q?KtQMqTNJ874roQktJlY5KlTNrgkcncBOqhXK9zH2R0bJeYo832toNrxbW97G?=
 =?us-ascii?Q?8QBeJ0Aikt0JqAKTu/S9Ie9a5YWb9PjAqSgNW7AXcGEjNtwnQZMYoKPCFp60?=
 =?us-ascii?Q?tcEhVzSakMAeaBftLjLijMuueYDKPimTjvG94rUd8aYs621uk8PgL4aDVb4t?=
 =?us-ascii?Q?L1zByNfrSz/V71bH6fbWyVBdY1oWlZeiD/QwaOhK9fmRwTdTHm6DHxjJRN8H?=
 =?us-ascii?Q?WQ+vOfyDtO4CULtWm41791JWTX/LO6N1woBnpUQ1W4ZTQqdstbxVSMnFmKDm?=
 =?us-ascii?Q?daYTPEl00v8KGqgkVyY644DcWhFG/Gyl9sgqqVliQ0VxLVF2Jahct3REJe50?=
 =?us-ascii?Q?680HwobyiIDNb6bJDRd5rHp7sTG8S7BRWdU5OFs+1XVQ1lpxLxp08uXif9Ob?=
 =?us-ascii?Q?0zcSM17dnYQl7wQXkx4Z0xDcKkp2dxDjzsFbhlIgcugjo3+QavNHyagSfQdv?=
 =?us-ascii?Q?vSYOenT87v/a/exrhtblBIaLXfk09cRAZZT7dWIAhQHKnXUOvLPvGh1cdP/t?=
 =?us-ascii?Q?DmxNnd18lUReItfnpu8YmYOMK8p/WymIcATf3BVSMdRkxMihx+SDw0TgR1JS?=
 =?us-ascii?Q?iIEz7EWUxxhgK3ZanDm9bp3LbopGCurrXNCF9CQl1cpmbj7WpC4pC3Tey2c8?=
 =?us-ascii?Q?VItxEC6q0Ia7f3Fc7JTXN2UHunQ+8w/DBCu1GO5eNY9KUSsPmhzR2oEuQabI?=
 =?us-ascii?Q?KgDW9z7b6JI9FESIYIzBF2J2mh2YCFm3Vgcb0YVtFhm86N9n8V9N7eKlu0u6?=
 =?us-ascii?Q?XD/1d6hMu1VQjKTsKf8Crb51wcZE6Te2f3TQUtLXZYzJBQTeQdrFxq3B/kiM?=
 =?us-ascii?Q?9rQ3fFgkx0pi21d44F06YN6WBcbKVjCvr6kr0Y27R5zoWDuS208qoyRht746?=
 =?us-ascii?Q?Ixg24IilXDXEYavmK0/qmkdOd2xdI0ahj3DxT5SkGrib8p/gHQCaNGLyxzxc?=
 =?us-ascii?Q?Upvu31cg2FIZvwDAQNFVCZWspsbBR2L7CxiVhoyjneW7h/m9IqVeguE8FJZJ?=
 =?us-ascii?Q?GAfKT6gmzB+QylrmhScatZTKCR4zsGoQ9SEY0p3KwWQwo3ziIwTJgLelSceD?=
 =?us-ascii?Q?I0tAmV7xsyS0wEcSsLMcEBhctgPUbhtUJmnAWJrHNZk+JYzUX6tBj0bsxcmn?=
 =?us-ascii?Q?Xxy3hWq0ZE5639Cbd9JUW4kykFyBripIdqpSKDnKyWDTpp5u7osGqTVj/eHu?=
 =?us-ascii?Q?d7Yuwh84Y5lFDsR5zzjdQExBloj0UNtFnkxkeNu2eEf6KeG4sNSq6B1Drb+w?=
 =?us-ascii?Q?R/6ViKuWWDJPfoeA266vQN6AjOJ1BUgKidLQGdzvhrsu5m5+JxlfTLF1cVwe?=
 =?us-ascii?Q?iYeG6VaVzbkHNgPFmwsZR8/P0zQRzJ0DvRMT2izE?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM3PPF7D18F34A1.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 422f6e5f-65c7-44c3-6d2f-08ddeacb73eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2025 09:22:50.0295 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jTztELuvoaZ2LPYiZ/pwWKI1cxnPSBzwnADM9zsK1HJw8JXyrVxe/B/0Afo3q1idNxi8iohmwJC7elFvupxvtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7425
X-OriginatorOrg: intel.com
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

>=20
> Hi Ciara,
>=20
> On Fri, 29 Aug 2025, Ciara Loftus wrote:
>=20
> > Allow the user to configure the state a link should be in after
> > the device has been stopped/closed. Make this configurable
> > through the new experimental rte_eth_dev_set_link_state_on_close
> > API. Three states are allowed:
> > 1. down: bring (or keep) the link down
> > 2. up: bring (or keep) the link up
> > 3. initial: restore the link to the state it was in when the device was
> > started.
> >
>=20
> Perhaps it pays to name it 'status' instead of 'state', as the latter is =
not
> confined to just 'up/down' but also includes the speed, technology, FEC, =
etc.

Sure, I think this would be a logical change.

>=20
> As for the three cases:
>=20
> (3)
> When the driver gets probed, it may discover the link being in some state=
 that
> the previous driver left us, (A). Then if the user does not invoke any AP=
Is to
> tweak the link settings and proceeds straight to 'rte_eth_dev_start', the=
 link
> will be in some best-effort state (B). Otherwise it will be in other stat=
e, (C).
>=20
> Which one is implied by 'when the device was started'?

I think what we want is (A) - the state the previous driver left us in. I w=
ill
look to improve the descriptions if there are further revisions.

>=20
> (2)
> Does 'keep' describe the link being up prior to 'close'? If so, then if t=
he
> link is not 'up' prior to 'close', this commands to bring it up, which ma=
y
> not be possible if the link partner is gone or the cable is unplugged.

Yes, I guess this is conditional on external factors such as link partner e=
tc.
The documentation can be changed to reflect this. "Try" to bring the
link up.

>=20
> (1)
> This is OK. If the driver is capable to force link down, in electrical id=
le,
> it will do that. If it can't do this, the whole API won't be supported.
>=20
> Thank you.

Thank you for your feedback.

Ciara
