Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 187DEC43458
	for <dpdk-dev@archiver.kernel.org>; Mon,  6 Jul 2026 13:24:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3ACCB40615;
	Mon,  6 Jul 2026 15:24:24 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id 067D5402C3
 for <dev@dpdk.org>; Mon,  6 Jul 2026 15:24:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1783344262; x=1814880262;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=IljvyP8I+YTXwhGvrbIz2yVGGqIb9coefJ0/aALKvGg=;
 b=KPj5Wnvwgg/XEFXLgb1iPgfSNi9IlCSUFOspe6t3OqWfu8HEjJOq05iP
 W56pJ0KAbXxaN5Am4PJmAzu2VaZXW+grfZq1o+tj36Csi89s7dIEwzH2R
 f/1Pv9cqtNmUMInZZaspQlvGv4NdTh3L48Sx+9Dz1w9Lddmvv7EFOeNYu
 Yytgbewyo4zbg41vGeP6Xi7zLPNesVW57z0WZxF8TrwbM4nu4dOybk55X
 o88H1FyxiOiv5/YtqJPpFDE5xpZDHLah63O+RUh7EFfgoTJlJBkPc/laA
 1dmb0F6djTATNxqJvZ4V4v2Tg2Y5d05M9Gh46+RwtKE5QSYtMFecbsERs w==;
X-CSE-ConnectionGUID: BaZ4Spk0SI6dKda0j8dSCg==
X-CSE-MsgGUID: 0zaWR8KfQYqWEhSHLq+L0w==
X-IronPort-AV: E=McAfee;i="6800,10657,11838"; a="94623716"
X-IronPort-AV: E=Sophos;i="6.25,149,1779174000"; d="scan'208";a="94623716"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Jul 2026 06:24:21 -0700
X-CSE-ConnectionGUID: i/4be3bQRMi+acRg3tWh1Q==
X-CSE-MsgGUID: OHgjBjTpSducwXZEQyRwmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,149,1779174000"; d="scan'208";a="257297847"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Jul 2026 06:24:21 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 6 Jul 2026 06:24:20 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Mon, 6 Jul 2026 06:24:20 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.53) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 6 Jul 2026 06:24:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KWpaPEZ0pyjaV+Ud3pOxLc3CBX2oDfgz2m7OoAfX4qaJN9CF/bPidmGJzQyS1nEF0mUe1BsQDD/xD/Zs1jsIp5PrqEV0qlKZtkOw9VGcks3iKpaohHHk3T8tR6wkkrfgrAIjKleiUdoyD3YF803dWomLr3FHaCS8zTwqEY1puErigtoHRlf/hxkdHyY8/jl2oj9YtLkni9AgO/mrvut7k3LzBuEJY+jrPVlqCTtNK30RY3fu7u6h7bi3ib9ixQVgim1tfCcCzIcIw2M9uh2Q24qcTv7rTZYRWqWEfV63u5/IsE5efqm+9rzK9lRq8lIH6RHNNTevEz+TueYcMy7tsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O/wPYyDzEXkDRPhJf+Z5sBAmXHV80r1gQFbRWB4AVYM=;
 b=kvvmHTHXe8ZDpzya5Q8sxQbpTaLb9BW+edtV8nDt/gnA6p1aJIrrGerOEVtn7oRs309Dz0dj2aB+8W08K6ImuBKyihOp66grQdbR10ibtj0Pgqi+v0R1iH6MUi69WPD9u/rzPlc0koE4hcxAXgWG9ONboVwZWQpQbyhtQk4xBoC3F1OMppRw5SlWw2jDQg3z83n49TKhGAESzZcDLA1h/kbnmVYY7oVcI+rUbCtxyQU16Y74qoUuNH0G8EsWG0Mv4cvRnitytoBENeUwLLHlpGzP5J19LO7aW69vugCXs7yrn075BOIOz/Gg4g+Wc1yxuHeoi2qAQ3W25va2PBfjnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA1PR11MB6782.namprd11.prod.outlook.com (2603:10b6:806:25e::11)
 by LV3PR11MB8506.namprd11.prod.outlook.com (2603:10b6:408:1bb::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Mon, 6 Jul 2026
 13:24:16 +0000
Received: from SA1PR11MB6782.namprd11.prod.outlook.com
 ([fe80::cd29:ea71:32e6:ff0b]) by SA1PR11MB6782.namprd11.prod.outlook.com
 ([fe80::cd29:ea71:32e6:ff0b%5]) with mapi id 15.21.0181.008; Mon, 6 Jul 2026
 13:24:15 +0000
From: "Mandal, Anurag" <anurag.mandal@intel.com>
To: "Richardson, Bruce" <bruce.richardson@intel.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "Medvedkin, Vladimir"
 <vladimir.medvedkin@intel.com>
Subject: RE: [PATCH] doc: announce QinQ offloading operations in iavf PMD
Thread-Topic: [PATCH] doc: announce QinQ offloading operations in iavf PMD
Thread-Index: AQHdC7eAGx1mJNzCVUqhu6HpJigEPrZgWE+AgAAjWQA=
Date: Mon, 6 Jul 2026 13:24:15 +0000
Message-ID: <SA1PR11MB6782BFA57A468AE7454B679FE4F12@SA1PR11MB6782.namprd11.prod.outlook.com>
References: <20260704131730.457722-1-anurag.mandal@intel.com>
 <akuM15sJlImRdy6s@bricha3-mobl1.ger.corp.intel.com>
In-Reply-To: <akuM15sJlImRdy6s@bricha3-mobl1.ger.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB6782:EE_|LV3PR11MB8506:EE_
x-ms-office365-filtering-correlation-id: eb8de4b3-0651-4ec8-26df-08dedb61e08f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|4143699003|11063799006|22082099003|18002099003|56012099006|38070700021;
x-microsoft-antispam-message-info: UKnNWf2p0vd8MeSmhBJNBOjrTOysGcMg6w7Er5wpiARNrZIPJ6iYoEfCLVbOo9pG+4KYFMcAH2MdOACaolMC/6jQ0WkHN4H4iFElFyVTEPuYx41UvUaHUGw5xpDcMTfDj0rtmfNJxN4ksAHga8WcojmvzRClgKgnrFQFeKXTRds3N4DfCXv2Csy3WB2wS0hn9lyOOOA/noDmNOAlcnc6QnusvvxmzZd0mQYniv4gmOVB6F4XkeCaZ81/A4gQK8Tjd1N9cMBGsqqQVmBU8O4QcW9NxvZGHqiZDMOwsO6ayw7WE2IMmGAZpEFgK88USu9UcTsP8HXILX80AuVmp0ifXBdpox5hz3/wEgBLqY9fPiWYYOKtB/qJGuFpfyhZ2lQJ3qSvJiygJmTdbttqLiFE4n42AyDaXspJ1Lw50+LtffzFSYL16gCcowzVuPU31HxRtoBw5Y9fu5ijMLJiN5n53kHrdOmSJeJst9jMHtpWy1zad6PMzs3nIJOF7VLTCZAuzW1P3VduOsW3ZTPrBbEBdL+C4WliPFdOm0lySWJhKknHFE56ecMo12JDXyLZRNLSv2aqV6JOLm7OM9pH57F15cBARAvV2VnO3KY3llAYDyleuBYLQVtFTd+XVNUAtsFeBKjYHoAH2ZC3h0carQSi/HyCgZPfRevb7cClJbMEqdESXu4HwhHK/6niloKS5ZTaTg2jSaZ5VgLbmQHxCNLx7Q==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR11MB6782.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(4143699003)(11063799006)(22082099003)(18002099003)(56012099006)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?dch/IqEZXpzB1CspzSawdqjM0XFfCOk+bJbU0jh2CftI4UPout155FDJWaI9?=
 =?us-ascii?Q?rI3ajeu9l70hJVnAt/zzTOL2XhuaJDWukuL1Gfvc4DjlBf72E1bD9+Q032Nv?=
 =?us-ascii?Q?d/CfMqdFe+b6bPxEPko8r3mr46Z4cSjTt1l/f8HQV7d2uQA1OEUfYyXdxpRY?=
 =?us-ascii?Q?S/G7y1va+rScLYz/qD7Fz78b8fxK3kFug2t1vAUuLadwl4MGKir2gaU2mBgb?=
 =?us-ascii?Q?xRA4ZkSKL36HjCX0xR9fHFNVxgCtYdPvTMAl3ePNCbrNq3BD/IacB4lVKKyw?=
 =?us-ascii?Q?ZSNQk0n8/QY1WqUB0PmfyFC2BCkQ3aKsdBvCETlsh3N2m+inLhOtkv+LyjjC?=
 =?us-ascii?Q?YB0H46ifAP8xxoCLySQkX2LwVM9hdj0FfvDRPMt+FMOBAEXsf8Vvl+N0kqou?=
 =?us-ascii?Q?BAhXy1b8zszyhhj07b3pmC9UIwCPnWdfkqzwogj4Pjb4k0zR/mDexy+q9Kay?=
 =?us-ascii?Q?/2m1pszLnHWdr+rOvsgAiUgqe/CgOArwlXB7iHv5zrg/0urQGpgyI1VjDCv+?=
 =?us-ascii?Q?+98UZgAGQIsjS0eObt1gGDLswASR0F+ZOE1JULeGy3zjFUoAOUIBYlBzfaTs?=
 =?us-ascii?Q?g98+bWxFp6HaobxaoA2ajafaaw77sx8jQm6EtCthO3Z061yjhEjADptVY/8O?=
 =?us-ascii?Q?Ehyh/f//7qUG1xoCi1WlXtQMAANkDU8b9+KEUwraNxmwsGx0PqNRFfzxjKFA?=
 =?us-ascii?Q?TqwwVS/6QFsf13N27Vik8bXwKlB5FlpUwCbsSn6xrFA3D9YT2Sskppvjj/DO?=
 =?us-ascii?Q?EW3Tv0ZhKC1qzTZvT+fhIMR0Lp8T6x6ONNNl+Jc7q+aqo9u6QCpS4AS5Mcke?=
 =?us-ascii?Q?Hb5iJpt+n8F7MuMNTN7ojtPWbP/UiptyJmmnR3PwtiCiBbG8X+TIR6gdghNd?=
 =?us-ascii?Q?xQE5JA+LM4Dh99jgCjQIFVPKcd08JEn7ujtMxoa7pIl0RzduTBQVcSoUXD/t?=
 =?us-ascii?Q?vlHspPWCH7a9zzdXF3jmhBtRfkXHKbOfmKRozC8h7cwU4KSzy7140L4V2ler?=
 =?us-ascii?Q?AYbdgkqTZfSXWnY/RX1reYG9+M5sbOcXcqMqdnGps6bFbdNd42gYGoAwHN8+?=
 =?us-ascii?Q?bP6rDJkjTkF87HHuqaSkwhuEShpxmcZrq3aFG2NCEB1vXXOYuaDgiGDhVpuL?=
 =?us-ascii?Q?ffm2EUaHJ9uvkU9DJUMakoqt/bcg2qFA57m7kP0zRRpllSunVsWu3JOxIJMZ?=
 =?us-ascii?Q?iLaKzW1yvQkLkHAaq6vRzv/WU3oJsU7kpDKvOHF7XgzRPZc1GXZhqtg/4UjP?=
 =?us-ascii?Q?JuafNMzm6AEveQrRWSaEDh0AWpYpCLnfg3mzpWX23isgRDxWXVsMCJnmdGo9?=
 =?us-ascii?Q?N+guFz/96+PP8R93uYh/O4TLJmaRnJdk8XZW35YcAs0v1/iwnW3rX9jcQ+6g?=
 =?us-ascii?Q?T8D0bPwj9/fOD0SAXVjTZB1WCLa+42VdpmCWQ7iT6WBz1SUZK84aoDpgyg+s?=
 =?us-ascii?Q?gG8zE3Efig915HlfmURumugZ75ledycCx05uXEUJNz/edAu7HN1AWHx/Os25?=
 =?us-ascii?Q?5/cmkLBMbBb/zoKKogFzd69fC36yGxnO9gtqYnPDmKu1UI4cjaAjCxknTCKo?=
 =?us-ascii?Q?L0fp0mHTkRp8kTe4DEZhlVDDiohQZ/sum1lGzP8QgIdMznctHr0MjVBc+g1/?=
 =?us-ascii?Q?mrhjD1XLeGG8nKwkg4PbZZWtvWvh+Tc45YxcsNYu/4MNVevap+/okRQL+rJU?=
 =?us-ascii?Q?UWBId30bgQZgg6WXUdiA+aZuDgzhHwVhch7yiCZTBWIHUu11cxF5nsLFqzua?=
 =?us-ascii?Q?xxfkCLR6zQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: j7Xww/dtjzlA+cRKsMmDTx0Rdd5aubV/Vzv9UdSOFySMpEdahrDx4nsTmNyNEDqA3jKCTE1jPO6GOXC77vXb74/j7g/FuMPp5wnNBJ24KXCP69GAIP1QFOLaoSIQCn6jrahc11kPyx45F4il7M5gXrbMJS4oA9UpjdP8VEQxFsSOYtR9HKygp3vlhv9X98mki6I0mrTeFOibUMVqs0XjSX4akLW50Nd5h1Ledj1k6ywzcQCc+qX5EX0lqqrKKGpzADFupzA9JlUQ+UQVrhS81GZtLKBpRtYXQr0SzAOrd2guKtUHgNXTfjnHb1c6Sr/uXgT73gZzOCDI50/pHmh0fA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6782.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb8de4b3-0651-4ec8-26df-08dedb61e08f
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2026 13:24:15.8827 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UJ7jzWR37p34XvGzUK7vJSBSSgORY0z3i5nS65KhTr2iUsCHtYxxwevkVDO0gcYfzx3E0Bu/EFuvA0a+ipjeDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8506
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

> -----Original Message-----
> From: Richardson, Bruce <bruce.richardson@intel.com>
> Sent: 06 July 2026 16:39
> To: Mandal, Anurag <anurag.mandal@intel.com>
> Cc: dev@dpdk.org; Medvedkin, Vladimir <vladimir.medvedkin@intel.com>
> Subject: Re: [PATCH] doc: announce QinQ offloading operations in iavf PMD
>=20
> On Sat, Jul 04, 2026 at 01:17:30PM +0000, Anurag Mandal wrote:
> > The iavf PMD supports hardware offloading for all QinQ operations.
> > QinQ tag stripping and insertion offloads have been added for both
> > outer VLAN TPIDs: 0x88a8 (IEEE 802.1ad) & 0x8100 (IEEE 802.1Q).
> >
> > Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>
> > ---
> >  doc/guides/nics/features/iavf.ini      | 2 +-
> >  doc/guides/rel_notes/release_26_07.rst | 1 +
> >  2 files changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/doc/guides/nics/features/iavf.ini
> > b/doc/guides/nics/features/iavf.ini
> > index 0ba6f7dfd7..e324a7aecb 100644
> > --- a/doc/guides/nics/features/iavf.ini
> > +++ b/doc/guides/nics/features/iavf.ini
> > @@ -30,7 +30,7 @@ Traffic manager      =3D Y
> >  Inline crypto        =3D P
> >  CRC offload          =3D Y
> >  VLAN offload         =3D P
> > -QinQ offload         =3D P
> > +QinQ offload         =3D Y
>=20
> Not sure we can advertise full support. Checking with AI it seems we have=
 some
> gaps, for example, the legacy (non-flex) descriptor scalar Rx - used with=
 X710
> NICs for example - doesn't support reading two tags for QinQ strip.
>=20
> >  L3 checksum offload  =3D Y
> >  L4 checksum offload  =3D Y
> >  Timestamp offload    =3D Y
> > diff --git a/doc/guides/rel_notes/release_26_07.rst
> > b/doc/guides/rel_notes/release_26_07.rst
> > index cf79eb57bf..d864019244 100644
> > --- a/doc/guides/rel_notes/release_26_07.rst
> > +++ b/doc/guides/rel_notes/release_26_07.rst
> > @@ -139,6 +139,7 @@ New Features
> >
> >    * Added support for transmitting LLDP packets based on mbuf packet t=
ype.
> >    * Implemented AVX2 context descriptor transmit paths.
> > +  * Added support for QinQ offloading operations.
>=20
> Can we tighten this statement up a bit - "Added support for Tx QinQ offlo=
ad", to
> make it clear that it's only the Tx side support has changed in this rele=
ase?
>=20

Hi Bruce,

I have added support for both Rx (strip) and Tx (insertion) for QinQ.
net/iavf: support QinQ strip
net/iavf: support QinQ insertion

Earlier only 0x8100 was supported partially. These commits add 0x88a8 as we=
ll as tightens 0x8100.

Thanks,
Anurag

> >
> >  * **Updated Intel ice driver.**
> >
> > --
> > 2.34.1
> >
