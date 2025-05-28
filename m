Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 902B8C3ABB2
	for <dpdk-dev@archiver.kernel.org>; Wed, 28 May 2025 17:55:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6625040667;
	Wed, 28 May 2025 19:55:38 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by mails.dpdk.org (Postfix) with ESMTP id 8F23340156
 for <dev@dpdk.org>; Wed, 28 May 2025 19:55:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1748454937; x=1779990937;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=iVIaeO/jyh/Pz/pNJ+4/Lx5EysHeQjBLwxcxO36Uuzc=;
 b=fkYjR06TB9XKMOHJjCM2H0449oqxGzl9raMTZISTnubJTP+rpOdPPvsc
 B7lBY+0tvtvEN3kr96WPPQjsN/XW2WDFe/ooyUBqxnNXBqzPsFKygcQqm
 csVCM/ue/OzNPiYQ8g65JwOatkVENAd9yXxvdtvPmseLqhiR8px92gSD/
 nXC/JZzvF+VmysTBa4qjlf12M4OZUhxYonvgBLTMe0aWTnZL+gAlYP7ba
 ZVBOzlVcLNXlVaHWhpzKnOAmsB9GwR5/TVwM6yrHQoFWoTQAApvu4pjUG
 090bf8jdJ9j85KAzqzliF2/IumPCcBFnG+ONon+cvYWfxG2STucXpsoLu w==;
X-CSE-ConnectionGUID: A9raBJGPRBC1ZQQ28LS7nQ==
X-CSE-MsgGUID: 8nT8kP0pQ5S4WXuOfd+n3A==
X-IronPort-AV: E=McAfee;i="6700,10204,11447"; a="50647983"
X-IronPort-AV: E=Sophos;i="6.15,321,1739865600"; d="scan'208";a="50647983"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 May 2025 10:55:35 -0700
X-CSE-ConnectionGUID: HE9HROc4TsqK1L3wqNrueA==
X-CSE-MsgGUID: WrBOjMQUQ+S8jJAPkpsb5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,321,1739865600"; d="scan'208";a="143305992"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 May 2025 10:55:35 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 28 May 2025 10:55:34 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 28 May 2025 10:55:34 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (40.107.220.55)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Wed, 28 May 2025 10:55:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CP3qt2RR9+3BLrDrtT+5TeRV6Ui7r2JKT5EtAhmqq4X8VEEo+6rWrcl2y8awYM7YqsnQF1o0uukNbpY2LBSX2afMCXSQZ5a7fpWRfW+vylfIMNGDsqj1lOPmwsvyNTjft2o9p+Sk+Zbo+Svuhdyzk5NTwpwDZbDVoz5F7m4tgo3hamOY7P9I8isPHZRG81eXCceRQbQkwbB18aHHgbdmMYDjV33kmoftBJX0+5F0m8q+WPBzx4TIPyoK46bnrBPWAlbG6W0uqDMs61ZF0VCzmqsroYqfRIF8Xd3ALUVRT0JAZLqX0cM4ZOJwKIRLRzzZGl+K06WlJxo5D9A7B4oNjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4ADIsen/Vd1O3JzTy8aGIzdCzktvcSvQL0CygImwxC8=;
 b=xtvqVM6Ma5B6B6F2QBlwH6sEwmiMnbkfNboeeiR0QafckGO10YYLPZA+Y89TLd++oemH4yXk/q1xyQxKEZJ/zya5lPpNfRrSWehb9pit8t4vvJYpI0BkprTnHv4Uc1NnmONsKUQIV5gzxZYSeHoukQjqK0NuXvLHPZgLg4Lye4cMIYoIEnYd22r1R5CZS+I3yUiL0a3MOe/kjpcbeiDFTjhcef/IcAbZC4u3E3hd2dpPyvXJrxaDrpk4bw6wWC337jsYXw8m1xCXHx56Qpx0g47I408jxLF7kdIxjWzkEjZtzzrnFrbkw28kiVTdeWhDqIL18dfaync86NgNPvam6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CH3PR11MB7763.namprd11.prod.outlook.com (2603:10b6:610:145::13)
 by SJ2PR11MB7456.namprd11.prod.outlook.com (2603:10b6:a03:4cd::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.25; Wed, 28 May
 2025 17:55:32 +0000
Received: from CH3PR11MB7763.namprd11.prod.outlook.com
 ([fe80::5218:aa67:1c39:9c74]) by CH3PR11MB7763.namprd11.prod.outlook.com
 ([fe80::5218:aa67:1c39:9c74%4]) with mapi id 15.20.8769.021; Wed, 28 May 2025
 17:55:32 +0000
From: "Pillai, Dhanya R" <dhanya.r.pillai@intel.com>
To: "Richardson, Bruce" <bruce.richardson@intel.com>
CC: "Burakov, Anatoly" <anatoly.burakov@intel.com>, "dev@dpdk.org"
 <dev@dpdk.org>, "Krakowiak, LukaszX" <lukaszx.krakowiak@intel.com>
Subject: RE: [PATCH v3 04/10] net/ice/base: set speculative execution barrier
Thread-Topic: [PATCH v3 04/10] net/ice/base: set speculative execution barrier
Thread-Index: AQHbzwnNTp/qfZnm+0G+FxGQY6DGBLPoBNWAgAAfNACAADEXYA==
Date: Wed, 28 May 2025 17:55:32 +0000
Message-ID: <CH3PR11MB7763D98B73F0841F0753D9AFB767A@CH3PR11MB7763.namprd11.prod.outlook.com>
References: <20250527131741.7606-1-dhanya.r.pillai@intel.com>
 <20250527131741.7606-5-dhanya.r.pillai@intel.com>
 <aDcKjfSrOShfJE1b@bricha3-mobl1.ger.corp.intel.com>
 <aDckum8YiGEObYUL@bricha3-mobl1.ger.corp.intel.com>
In-Reply-To: <aDckum8YiGEObYUL@bricha3-mobl1.ger.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR11MB7763:EE_|SJ2PR11MB7456:EE_
x-ms-office365-filtering-correlation-id: a9d6ebfe-402e-4a4c-ca79-08dd9e10d70b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?e6ALCTJk6/HB4KmYW+kbqSmevDApuScx1Po/p8qPrX2AtGZFxu2me0QFQGsO?=
 =?us-ascii?Q?MtH76NKKrnx2HjTjaVKmUUfdSkfitsiFd73gdUJtKmDNEvuD+pd4+nfuO7pk?=
 =?us-ascii?Q?w0BLzlDZa/RtZ/7mnX30YqfPOSShXqWXhrB/DbZQTjxYnL5/Js9dNqKdjYqu?=
 =?us-ascii?Q?YPvJ4PPn3JXCKAl8xHhqS/snawwqWy0wjgz3b2t2LedMplOFGrniQi4ErITs?=
 =?us-ascii?Q?PTQHlpQKHu8sZ1JdsbCICIMqQUWA4UAQbefI1rKFXmMlyglPORjyYz1atsXv?=
 =?us-ascii?Q?+1M57uWgBhEfE7oomJ+lbeNf2l/8xF4l0WjY7I5MChM6n9lGJBkNru5F/uJZ?=
 =?us-ascii?Q?Yv+/vQn+r9Sg3nWhYoRM88Y9cURsY2AL96fOX9C5XhnkgiPg80qj7Xr0EAWs?=
 =?us-ascii?Q?JQnjNfQcsI/qJ9bXxOLZLprae0I3sWAYb0+dBPagXZgXVM1JwSSVSIlupvqt?=
 =?us-ascii?Q?05oJXqrWjUlKPiPQgZ5MBpblIWqtVJGYSf77wFaJuN/A43dtEQZcUNspmDHq?=
 =?us-ascii?Q?70/rdOSVXkP+qqkFKES441v33QlVGvD+eKjy7UBx1tXztWbG3mqKfdnL+Pvf?=
 =?us-ascii?Q?LxzCSPqHHE2IPpQUKnpSL8fGMst0w5Riv5lne8S2OXYn2FW6PWWiUqn40PKQ?=
 =?us-ascii?Q?E3y9qUaYXSkpqC/zcF/VzFKqXK9xjP5gBtHq5aC7puAJLIqC3i3oRe8IpL5m?=
 =?us-ascii?Q?U37aiYen5Mcop1ezh0tsXQVLMoJ+bVtwDe9HFHV4NQyexZ4P8LrVu0pUb15Z?=
 =?us-ascii?Q?zoZtvGB5EAQCODq6gtl9wcGBHkFqAIzDHQv2+e6Io6jiATn3eD09mWmwxyR3?=
 =?us-ascii?Q?rmvuZLvAA12yvZWxocS+QmqetMJHBVPIYeUIBiZR/zMSm1+wKncEf+PFwb3w?=
 =?us-ascii?Q?GOhnxWuhAbS4TXDYgRGK/QbmP+MYqxIPmd4LkBikJMUHwXwvzMx25ThPkOUi?=
 =?us-ascii?Q?FKoP/GuS4SGShB+xW++/STOS7wYBW2OJ0RSw07/bhntKcHDlArE6Ld9xpl4E?=
 =?us-ascii?Q?d99WpPpk56Vhddg8ZO1o2+lX/oOZUZgYm4cB6Fq6CAaDSmYRoFOeD9jr8BIL?=
 =?us-ascii?Q?Dm4hsINSlYyRwbO6DaJHo6xYHOh+QKw91ovBv9QYib5AEG24cNQ4IQxuCwE2?=
 =?us-ascii?Q?JyhY1efgrb9MA4/cD4S3jCr6kaTouvHK4VFaiZH8nMfE+aWWMW/MLHl6AScn?=
 =?us-ascii?Q?xcAeZyLDofYQTnnimlOOckR3e5Av3ZKNQMXmkLcK7VqflS3ukc3cbR/oyL7A?=
 =?us-ascii?Q?+petPzULOF8gw8nNVqsEu/5EBVwjzTM8iSYnJ4eZOY8l8Xgw6kaGgJ6fkiVf?=
 =?us-ascii?Q?J5uaeXw7211Y/zn8ZrTKvmxhWDTxyKXEj2xUYBYOwo8dxTtwOXuM345gaWUT?=
 =?us-ascii?Q?bSYHGMMxZGp3guLyWQLYPbJt5Mg0ySCZTCP0QIVz5RPiCMEslzJJYRfxmHnD?=
 =?us-ascii?Q?bmLPF9yM6i8I6Vuk+HeKSLW5HcLkVfFJLAk2jAkyyTw9a38lLmBZdzqJc2Oh?=
 =?us-ascii?Q?WsqpO0L8uNH7Mfc=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR11MB7763.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?4UnzXV/LvCCo005iOf51aXU0hV9M00QXJWP8dGfggrZhceSPGVb6k1nYR7/t?=
 =?us-ascii?Q?Zps7l9fhhS4gorLFoKPZn8XkcIQWDUwb0T5H3e+kupLaMvz8TfJDlMJDU9M8?=
 =?us-ascii?Q?geUXNjcgFDvO/BrMzPUgCO8yOIPokf3QMEabboRF4r9iSnYvB2trp/L09TIq?=
 =?us-ascii?Q?4ep1/Ux6b+DA0suyjxt+wlXl42NtmqjtoufZe56HNkLM/Uf9HouFxP5f+DrI?=
 =?us-ascii?Q?yxm79B3KutRQ4sCY0oUmfOpPCm+dUbLpPsyrKJM6l7XxtVMm20n30Y1vKQSZ?=
 =?us-ascii?Q?7W4SbFcoFZEVtW1cXudMti3wYbrIE5MAhJpujiar/b/Hgheny6pxKdPEpxMC?=
 =?us-ascii?Q?8lVMN1mvySsP9KsCn9u79khbpBdBm4wc4Oiw2adOlMd2ZP3/w9cNuHtyPiKT?=
 =?us-ascii?Q?bBwQ+5KrpMXXVTRFf0es9CeVmvLP0wT5rEFTfEmT9RrUIJJDsSf7Pu6IUBiX?=
 =?us-ascii?Q?H1p/egRt/itTgdjW0gKhcrdC6KkDzKi11/YJ0dxzdOHhNFyEb5Ko7IDJZe5+?=
 =?us-ascii?Q?Fr94lBTNoxLgvyAmksLmZD5uNLA9UduvKG9CQrbHJne66dpS9AoVaePn8VQV?=
 =?us-ascii?Q?QUIXxdvh2HYDSo10aPX6yaOFF6ZFrFseMl1JBHpnRSlWnvbhTz9Twvuz6zyL?=
 =?us-ascii?Q?aPE3Gd+g7P5j/fJwNBAOb/dt84cKxKE7wSp5DVeGsZWhxgJ6GB/OELiaYjWx?=
 =?us-ascii?Q?m9xN20HrHEMIWJPDTBm3R4fgdu4k11CFExnnwVrLl8X9uL3k59BjaqRglGkH?=
 =?us-ascii?Q?lJI/5OxCMLd3wWpDoqsZMfrsINcXt82sOq0VzsJEgtIs1O6a17Q0Vpok1CgW?=
 =?us-ascii?Q?2r/p31A0ezOirnZuObwc9Unej29DfSOBkU3zuNZH1+6sTNUtSoNYT+lTFCFG?=
 =?us-ascii?Q?CtuagPV6UzmzuPHk8P2um11RPXxbzw1OSzRn0+sMuB/oLKuCx8/TkyzXDIky?=
 =?us-ascii?Q?tGRWF6KlFSv2+ecB6AT4HmpQFhpC/1F+u9WZZUC6g4lilxCJluzJJbvPknQ7?=
 =?us-ascii?Q?7fCvCZxjnxSFLJOJRZZXotnMCH3UuQGT/squO80o52f56Fy11IEv+w3uTucI?=
 =?us-ascii?Q?maigHLJps8W1Dm7LRjg4oa5vfaMBGybxc1iBIVCyzVDlxhs+45g8nTYmrkAi?=
 =?us-ascii?Q?tJIsr4D5DT8eMjADuKtsCuGROaqpD2WG2NJ6EIDq8X2AngEtoPIe3hb2VLN3?=
 =?us-ascii?Q?brQ66zjGAd7umi+eURsOQNEZOo8t41y7twR/c6sdxW9kl47MOLc7gqpTTUQ6?=
 =?us-ascii?Q?dO6WDHG7RtS020QoUMwCL8CaTILwQKeDNe7Mk9Btk7p6M8yISNnEeoVN45sQ?=
 =?us-ascii?Q?2G9nmzwqGG5RzVyuFF923JSX6jt6t7Rxff2QV4CcLuOK58JXhmZ1BE3J1N/l?=
 =?us-ascii?Q?FVOUxRw34pNAKh5jbaxo/ilIA90hsdTK6mGVfySVSzZw/8Hyhi5ulxGwBJFZ?=
 =?us-ascii?Q?YwV8wI8ceGJUsOxdNTfxtzRsSu3qkJ7JFla2oqrGgfSCc/G62jzwz/8yupoO?=
 =?us-ascii?Q?aSGKDtwcPoSRyZAOT7TO15qIrJuMgL8VOqtCxmwDhe2h53AYqUr2Z390PqE8?=
 =?us-ascii?Q?+f5nEzCdZBBayqSXw6eKiekiRWGsQsx3H2w5etY4?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB7763.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9d6ebfe-402e-4a4c-ca79-08dd9e10d70b
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2025 17:55:32.0949 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CpM1YTXEd9vzhZGQliFRqtYx0IpJIh4ankIZAkmbc8ztJSStd1lZDIjn3Zt4QoQNgmTsO6UOruJeRCeRo6JFO2tadVA/ssQWptaCciM8GNo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7456
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

Sounds good to me Bruce.

/Dhanya
-----Original Message-----
From: Richardson, Bruce <bruce.richardson@intel.com>=20
Sent: Wednesday, May 28, 2025 3:59 PM
To: Pillai, Dhanya R <dhanya.r.pillai@intel.com>
Cc: Burakov, Anatoly <anatoly.burakov@intel.com>; dev@dpdk.org; Krakowiak, =
LukaszX <lukaszx.krakowiak@intel.com>
Subject: Re: [PATCH v3 04/10] net/ice/base: set speculative execution barri=
er

On Wed, May 28, 2025 at 02:07:25PM +0100, Bruce Richardson wrote:
> On Tue, May 27, 2025 at 01:17:23PM +0000, Dhanya Pillai wrote:
> > From: Lukasz Krakowiak <lukaszx.krakowiak@intel.com>
> >=20
> > Fix issues related to SPECULATIVE_EXECUTION_DATA_LEAK.
> > This changes set speculative execution barrier to functions:
> >=20
> > * ice_sched_add_vsi_child_nodes,
> > * ice_sched_add_vsi_support_nodes,
> > * ice_sched_move_vsi_to_agg,
> > * ice_prof_has_mask_idx,
> > * ice_alloc_prof_mask.
> >=20
> > Also, Added memfence definitions.
> >=20
> > Signed-off-by: Lukasz Krakowiak <lukaszx.krakowiak@intel.com>
> > Signed-off-by: Dhanya Pillai <dhanya.r.pillai@intel.com>
> > ---
> >  drivers/net/intel/ice/base/ice_flex_pipe.c | 2 ++
> >  drivers/net/intel/ice/base/ice_osdep.h     | 6 ++++++
> >  drivers/net/intel/ice/base/ice_sched.c     | 3 +++
> >  3 files changed, 11 insertions(+)
> >=20
> > diff --git a/drivers/net/intel/ice/base/ice_flex_pipe.c=20
> > b/drivers/net/intel/ice/base/ice_flex_pipe.c
> > index 6dd5588f85..dc8c92e203 100644
> > --- a/drivers/net/intel/ice/base/ice_flex_pipe.c
> > +++ b/drivers/net/intel/ice/base/ice_flex_pipe.c
> > @@ -1280,6 +1280,7 @@ ice_prof_has_mask_idx(struct ice_hw *hw, enum ice=
_block blk, u8 prof, u16 idx,
> >  			if (hw->blk[blk].masks.masks[i].in_use &&
> >  			    hw->blk[blk].masks.masks[i].idx =3D=3D idx) {
> >  				found =3D true;
> > +				ice_memfence_read();
> >  				if (hw->blk[blk].masks.masks[i].mask =3D=3D mask)
> >  					match =3D true;
> >  				break;
> > @@ -1648,6 +1649,7 @@ ice_alloc_prof_mask(struct ice_hw *hw, enum ice_b=
lock blk, u16 idx, u16 mask,
> >  			/* if mask is in use and it exactly duplicates the
> >  			 * desired mask and index, then in can be reused
> >  			 */
> > +			ice_memfence_read();
> >  			if (hw->blk[blk].masks.masks[i].mask =3D=3D mask &&
> >  			    hw->blk[blk].masks.masks[i].idx =3D=3D idx) {
> >  				found_copy =3D true;
> > diff --git a/drivers/net/intel/ice/base/ice_osdep.h=20
> > b/drivers/net/intel/ice/base/ice_osdep.h
> > index ad6cde9896..7588ad3dbc 100644
> > --- a/drivers/net/intel/ice/base/ice_osdep.h
> > +++ b/drivers/net/intel/ice/base/ice_osdep.h
> > @@ -203,6 +203,12 @@ struct __rte_packed_begin ice_virt_mem { =20
> > #define ice_memset(a, b, c, d) memset((a), (b), (c))  #define=20
> > ice_memcpy(a, b, c, d) rte_memcpy((a), (b), (c))
> > =20
> > +/* Memory fence barrier */
> > +#define ice_memfence_read()
> > +#define ice_memfence_read_write()
> > +#define ice_memfence_write()
> > +
>=20
> I suspect rather than removing this, they would be better defined as
> rte_smp_* barriers. As in:
>=20
> #define ice_memfence_read() rte_smp_rmb()
>=20
Correcting my own suggestion - since this is a NIC driver, we probably want=
 to use rte_io_* barriers, not the rte_smp_* ones.

/Bruce
