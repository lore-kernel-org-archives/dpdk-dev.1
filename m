Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70384C021B0
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Feb 2025 04:59:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 58C304014F;
	Thu, 20 Feb 2025 05:59:53 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id 8206840041
 for <dev@dpdk.org>; Thu, 20 Feb 2025 05:59:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1740027592; x=1771563592;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=tabze6Jjwbk9AAbvcKc0kqtsnI5WBlDc8dzbFKrSoMk=;
 b=EiSReGIEr39P3ZMZhtoI7y2cgrenJT2Ff11x52pj63wqBCfewzwJdv0C
 BaIRFBmBikw86J30D9uYsvJPMj4QhW7yYKqo7EJblgPyLARf50iX/lTmS
 fPBXJyh3twFdONE46iWw8ehUWv3n512mmQrxJh1lmngym3/QEUDndsMDd
 YvsElDvE0lEzIhXdBZ5XId+IqBf3lLILqqoytEmpJnb8+3e7jMQiPJwAo
 CRdjGbvMta/1llnKiWbGKJY8TOuoSdKF5DggED7RjA4pvLwQ4uXOZgH0Y
 LP0rYI2c1z7TCjqLbZ2A0lyreo8lX56JjdmLA0W7W7kuEdY6xwGAhbz5X g==;
X-CSE-ConnectionGUID: YqlY8mwlQauJkXWex6SkvA==
X-CSE-MsgGUID: vMCAjmv5TaewQDOTs84WaA==
X-IronPort-AV: E=McAfee;i="6700,10204,11350"; a="40647038"
X-IronPort-AV: E=Sophos;i="6.13,300,1732608000"; d="scan'208";a="40647038"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Feb 2025 20:59:51 -0800
X-CSE-ConnectionGUID: qaXZwm0FTv2bdUDt8Iq4UQ==
X-CSE-MsgGUID: 4t3/7R5ITpqQkI/hnrAaCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,300,1732608000"; d="scan'208";a="115127968"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Feb 2025 20:59:50 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 19 Feb 2025 20:59:49 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 19 Feb 2025 20:59:49 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.47) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 19 Feb 2025 20:59:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lhRFe5FUdL5MvEmVUkq4VQ3v0GaMQT+AxlF6w63vO0xspQ/ULfRzY+TxnQcJD8GwRlgv47rUJY3hS66QWbISroPYfosr2/HWaJS+HrPrBwuH8j/jgBuqEeaxwKcznNyMXXGROzmgdxjkqufrGJhyE96f5WjMwv1J+p8QrxULwrr9OW7X0evayijnb6Bg9DsLVoeHqjDVvTgc8MzdZ/lS+k/k+R+91+4vBEl4OAWZbROk8EpBzQ6U3mJsrcYMtrc/MLFQVRMkeQjipApdy9pC9czx9wvJf/vSxdVGBBvPyc562yx3Y1jEtgL1KM/aS6+CHd2pqeYc0O7Shuyjxg3vHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dtl4TyTbFjZ1XuzV+DFaU6PUL+aU5rXuX0LOBBNfeIc=;
 b=CzKFCxdzP6D3eNAXA8+G8F2DNcIkLtPrwmyMp1ezCv5CU8QpfrggXpYgZ6/KS70us0DqI0s8LvpZu46GtowDE7FyfLnL71pAu8hX3JWueXCbT6F5G+HSl+cwURxRphtANSsSQGx14HCDi9g8W9cdnJaJTQMjbVN1TJUZurBVRXQmPvCMfWkbnO10NeQKzloiTuI3cgR8BG43QfH+AtZbNpOa4DeSxy9J75rCd/ugnF69T8WZiRZrTPFLCEzvb9W0QY56aMmXSwxF3mzNQtwrqRzsaHgnb0WEx1WE5EFsW4ULgJrdLjBdyQnQ43OamZBjtkwM4HVKpNfaFJEeGClkXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SN7PR11MB7044.namprd11.prod.outlook.com (2603:10b6:806:29b::5)
 by SA1PR11MB5923.namprd11.prod.outlook.com (2603:10b6:806:23a::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Thu, 20 Feb
 2025 04:59:41 +0000
Received: from SN7PR11MB7044.namprd11.prod.outlook.com
 ([fe80::79ff:96e:c439:d42e]) by SN7PR11MB7044.namprd11.prod.outlook.com
 ([fe80::79ff:96e:c439:d42e%3]) with mapi id 15.20.8445.017; Thu, 20 Feb 2025
 04:59:41 +0000
From: "Naga Harish K, S V" <s.v.naga.harish.k@intel.com>
To: Shijith Thotton <sthotton@marvell.com>, "jerinj@marvell.com"
 <jerinj@marvell.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "pbhagavatula@marvell.com"
 <pbhagavatula@marvell.com>, "Pathak, Pravin" <pravin.pathak@intel.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>, Sachin Saxena
 <sachin.saxena@nxp.com>, Mattias R_nnblom <mattias.ronnblom@ericsson.com>,
 Liang Ma <liangma@liangbit.com>, "Mccarthy, Peter"
 <peter.mccarthy@intel.com>, "Van Haaren, Harry" <harry.van.haaren@intel.com>, 
 "Carrillo, Erik G" <erik.g.carrillo@intel.com>, "Gujjar, Abhinandan S"
 <abhinandan.gujjar@intel.com>, Amit Prakash Shukla
 <amitprakashs@marvell.com>, "Burakov, Anatoly" <anatoly.burakov@intel.com>
Subject: RE: [PATCH v2 1/3] eventdev/eth_rx: add API to burst add queues to Rx
 adapter
Thread-Topic: [PATCH v2 1/3] eventdev/eth_rx: add API to burst add queues to
 Rx adapter
Thread-Index: AQHbgeXMA+0PH7+f30qRsjB2mTwN5rNPoa/A
Date: Thu, 20 Feb 2025 04:59:41 +0000
Message-ID: <SN7PR11MB7044A5445426212E5105C976A1C42@SN7PR11MB7044.namprd11.prod.outlook.com>
References: <20250207140910.721374-1-sthotton@marvell.com>
 <20250218091543.282270-2-sthotton@marvell.com>
In-Reply-To: <20250218091543.282270-2-sthotton@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR11MB7044:EE_|SA1PR11MB5923:EE_
x-ms-office365-filtering-correlation-id: c3cfb97d-5289-49de-7cd9-08dd516b626b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?bSeRVytV40kW1t+t8OwCdkwVIhmUs4AlIGrsxTf0lc5pac8V3UyMMvaOI9?=
 =?iso-8859-1?Q?GK1llj6rs18RLMxxr6VEzr5yfJ7cLECk3EOPEsZe7c7vNURr+vQKAlcl0b?=
 =?iso-8859-1?Q?ZxJC3cqflTWTrRDpKxmjnQEu18veIlBOhPelGiosj9LpqDPppqVnoPgaue?=
 =?iso-8859-1?Q?O0y96E4iwDQXIlNG7DhFwhlLno4JplUmm2yp9l9IV+6f6NOJlG/L1aXmej?=
 =?iso-8859-1?Q?HCKLX3DovyfAR6cP5E9THF+avDLo7a5spN0Zwrz2Q+Je2y9oE2VFWo8T04?=
 =?iso-8859-1?Q?QYOFg380HOueBkCbSts/ZDBx8SfmGCA8/rJAqmbn+A7puOKvOWxiIW/o3D?=
 =?iso-8859-1?Q?2JpSHxAxfcligwgVk3VXS/zkQUmFAoGlW2FJvBFGm1ODATzTGjHp0bBn9O?=
 =?iso-8859-1?Q?5Vg4LchDFg5WZgnAAm1wy8AUZia7geSHu5CXwY0w6ZR9z1McPfP2dp7R9+?=
 =?iso-8859-1?Q?a9Sec6C1FNZX9JcV0fIPjtwa0YqvwkF7nyWf2kYHIAYdghmCAjiBvnat8C?=
 =?iso-8859-1?Q?lCfg+uR1bOwYf/pY56efyo4pXsdhTaS8rQdP05gnCKAaqmMUFlH8ZUDpCS?=
 =?iso-8859-1?Q?LUej0u1KQXltky5uVjvFllyvtxXYZ0jyQN3/+LcU+oRRYxvDfnD5YDPeKB?=
 =?iso-8859-1?Q?FL911vqp7ICv5vO4eSRbcmGgveSCeuxbHy5W1YeSWo55VPis1dhgUKMu2V?=
 =?iso-8859-1?Q?/87EqpUVo4Wm4N5MMfYKqL1l0BaFI0p4Cw03noofjUM7MIwQxh7O7nEM9F?=
 =?iso-8859-1?Q?lkjzz7JV4ADW5qb+3OouHw190BGD2mpceKxVRTTfIlSzHLXps53Rhq7gNJ?=
 =?iso-8859-1?Q?47S3ghSvrOHatry5qEbv71hm4ww3FsYEAaioV6D9PS1dr9wsGi4G6jcD4+?=
 =?iso-8859-1?Q?kKLLF9FgVKLQrOgz2U8W/dPymVw/SrOIQz445dwcd7TjA2VEq9Hb0kbdII?=
 =?iso-8859-1?Q?AcoUD+kgL9lW60ilJn5Dz08RzW8u90sgZBz0Jamq1Vq6+kQJaZaQKyOnFd?=
 =?iso-8859-1?Q?wFAESKK0L5/+9G0YgVuZwLoc2PQfPGuTwZxScRpeGUOFOniPwzYmHsHjiC?=
 =?iso-8859-1?Q?R941xC0Qznp7iTwJWCGWOBKETogwPfqgakbIG+ktb0UcNTZL8kN13PLMdN?=
 =?iso-8859-1?Q?JgpPFuR1xMTb17/GWLcauvRzhgUILgmydZQezrnZQiHq34gL9Czy1GLnBo?=
 =?iso-8859-1?Q?TjAXR39FHxzMPuor4SXKHsblFzmIPjDk0MS2aKju47bH1n+8ru2Vi6l7r4?=
 =?iso-8859-1?Q?PH4vSuMp1Oyn+/z6gVbAQtFPZVuU6DF6LFzZU88+yu2w359yE+o8XDaIGi?=
 =?iso-8859-1?Q?46g7jhMpGc6yOPivDutLpFeywS6DGla6qdRpHfLzaUEZ/CtXjBWDttMonn?=
 =?iso-8859-1?Q?ZQenY5kyjthGtxCeJ0muqqIQEPvNegqki+ha3C/Rhrz8ADe8RsYVI4Gs+b?=
 =?iso-8859-1?Q?fLcGcdL/YMyeXitg0TVaTYRs/hTyN51BLaYS1cNc8kZaBfNDz40/j3Egdc?=
 =?iso-8859-1?Q?oGqxSr3Zz0neRFZYW+pqE4?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB7044.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?dOKA6L4xZgOU9Cl0hNMQNCTS5WyeO1HflVXGk5TAUaDUJvGsAipC/2U/IS?=
 =?iso-8859-1?Q?ibNX8CBEA3L9SXVTJqhYbwFE9UKItsBDFJwhH8cbMOAgm1VDWtyWpXyl3O?=
 =?iso-8859-1?Q?xtiOu/g/03RMVcG0mqDQHe0UvjUdwS9eBKTYGAYrw1nlCj/z5B7HeaK7me?=
 =?iso-8859-1?Q?Gnj1lZ5d1rGcVEULXGnQh7vPNndgbWXsds8ElPRnGRcCAPk5tpjiMVMllt?=
 =?iso-8859-1?Q?qIIAvLqTal67aoUtWZlJVGvZXJC+1t3Cc7Je8/DyJIiX6bFFv95SYquA7K?=
 =?iso-8859-1?Q?UZn/LJNvbJUKTUftRknqmyHRxq+Z8/9NYB67RvlCzZyA9QgMC6H1a7XGOw?=
 =?iso-8859-1?Q?56GRSB2io8TsFJlozE5nAuPOXxMw3Kn1E2MmPvU/VhJI4Q19azVQuq8L2q?=
 =?iso-8859-1?Q?SAsCdOwj71yc9NyFBtP0ng+U8DR0JyWhYn6avppLIBcEbN1TkkbLMoSiwv?=
 =?iso-8859-1?Q?TgWTZJ2MVI53YwxPbWCIw8E7ZwnkO60ZSV59zGWJ+nzlwK14gYzPTg3E/P?=
 =?iso-8859-1?Q?lnQLU3vM8y3Fv+cb4Umzma2B38oFFHJi1Vpo4gsJEf7SXM7NL0oefOOs60?=
 =?iso-8859-1?Q?BbSs36BKddUmAO/dfzQ3ouFkaWWwobW+YUZ9lao5oyWaQ1aadHDEXaiogU?=
 =?iso-8859-1?Q?sEqZRQCOvspCpr+0w3ixznHQrO4vAgShjyMEkorTZHyQQw1Fgi2F1/ih2N?=
 =?iso-8859-1?Q?xgObuQ51RlFi9zU/H8Co61xS2jyq2ClrP3Bq8hsS+n2LPLtNn11gtS+WF7?=
 =?iso-8859-1?Q?dJskbQz/c6irf1YFfKvFdeY12Ey8Qa1rEcl8+C+aUFSynRvz3oFv6SzCEi?=
 =?iso-8859-1?Q?uW14AGFFTVRzITRezkVUicOdCdXjUPlTVusfUZstGlrkLWKybrDJHejb4h?=
 =?iso-8859-1?Q?5LvnL1wXOE4rh/sUxiKFNeIXtA2gSPXqLdv8t9t663JP6AVPLqQKKp/NIR?=
 =?iso-8859-1?Q?3ApKuB582FTJOp2PA5ovTHaIj1qCEgirbJcNwmWxqpPWzaGt59Rwl5hE1d?=
 =?iso-8859-1?Q?tmx4wYDqGFME6ZwDDVJ4DwrDxriMTbMw2uH2V2W56k1YDbFKNrVfYDP0r5?=
 =?iso-8859-1?Q?k18R9xZ7VxdDjBdTsmLAy/8yjsshUsbhDcxi7iWXTv5MGXlLQriUp3XzRM?=
 =?iso-8859-1?Q?wBUCp7xxwK4AFBdAqnaDhdxCe/UWQV8aShW4R7bHvAWCYxxN8AcAWnSKAz?=
 =?iso-8859-1?Q?L67vKBFF15LfQJufBvN5N38yufWgP8QtqyDu6u5Y43KjtvbfLIqUdkz2OD?=
 =?iso-8859-1?Q?2GbTdYSUrHUf9eZWBed5umiBX5Ru/NB2WUXt975srganpHzd7G7otFK6pA?=
 =?iso-8859-1?Q?xxGEv+PB7YOuPR0nWsv7ujiQmsYS38x2fBH/TrLcAVcOeh/MHlp/dr3jOb?=
 =?iso-8859-1?Q?Ov0LZqdOSmmBy49+QLOL71PVvEfzSoJjjtfiDsSO7gVbAOO87EYWXosc8R?=
 =?iso-8859-1?Q?rWxJD2mug5RTaJ+ayr1gNXUKlLxzlSbAcKkHZroHypchoDfj8vMCyj0VGl?=
 =?iso-8859-1?Q?vSjgIiJV8hvzGLmKcD5tk9SvYCctaR29KXO9lVLw/Fl0AlCUmKKQxsl8+s?=
 =?iso-8859-1?Q?GnlRDYiYvvBKCZrXLnRllXhceyrvFra/i9qrJW5xlT6XwBZP2GWzaRJbuk?=
 =?iso-8859-1?Q?mvxKQG55QHhbOod8sjuQoGUTM3K6XVPHb4ysAI77zYEBlEG9V//Y4b8Q?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7044.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3cfb97d-5289-49de-7cd9-08dd516b626b
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2025 04:59:41.0957 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: O8ySLjj5ah4UC27UsHexDXxVkGyMz3B7ZTZSy2/fzDNh/BAZ3D2Pel+dpt/O8pWbdZh6ozuLQ2gadwexAzD+ssrrc4M2xB2wMhAAwoAhf6s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5923
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
> From: Shijith Thotton <sthotton@marvell.com>
> Sent: Tuesday, February 18, 2025 2:46 PM
> To: Naga Harish K, S V <s.v.naga.harish.k@intel.com>; jerinj@marvell.com
> Cc: Shijith Thotton <sthotton@marvell.com>; dev@dpdk.org;
> pbhagavatula@marvell.com; Pathak, Pravin <pravin.pathak@intel.com>;
> Hemant Agrawal <hemant.agrawal@nxp.com>; Sachin Saxena
> <sachin.saxena@nxp.com>; Mattias R_nnblom
> <mattias.ronnblom@ericsson.com>; Liang Ma <liangma@liangbit.com>;
> Mccarthy, Peter <peter.mccarthy@intel.com>; Van Haaren, Harry
> <harry.van.haaren@intel.com>; Carrillo, Erik G <erik.g.carrillo@intel.com=
>;
> Gujjar, Abhinandan S <abhinandan.gujjar@intel.com>; Amit Prakash Shukla
> <amitprakashs@marvell.com>; Burakov, Anatoly
> <anatoly.burakov@intel.com>
> Subject: [PATCH v2 1/3] eventdev/eth_rx: add API to burst add queues to R=
x
> adapter
>=20
> This patch introduces a new API, rte_event_eth_rx_adapter_queues_add(),
> to allow bulk addition of multiple Rx queues in the eventdev Rx adapter.
>=20
> The existing rte_event_eth_rx_adapter_queue_add() API supports adding
> multiple queues by specifying rx_queue_id =3D -1, but it lacks the abilit=
y to apply
> specific configurations to each of the added queues.
>=20
> A new internal PMD operation, eventdev_eth_rx_adapter_queues_add_t, has
> been introduced to enable this functionality. It takes an array of receiv=
e queue
> IDs along with their corresponding queue configurations.
>=20
> Signed-off-by: Shijith Thotton <sthotton@marvell.com>
> ---
>  .../eventdev/event_ethernet_rx_adapter.rst    |  60 +++++--
>  lib/eventdev/eventdev_pmd.h                   |  34 ++++
>  lib/eventdev/eventdev_trace.h                 |  14 ++
>  lib/eventdev/eventdev_trace_points.c          |   3 +
>  lib/eventdev/rte_event_eth_rx_adapter.c       | 155 ++++++++++++++++++
>  lib/eventdev/rte_event_eth_rx_adapter.h       |  33 ++++
>  lib/eventdev/version.map                      |   3 +
>  7 files changed, 292 insertions(+), 10 deletions(-)
>=20
> diff --git a/doc/guides/prog_guide/eventdev/event_ethernet_rx_adapter.rst
> b/doc/guides/prog_guide/eventdev/event_ethernet_rx_adapter.rst
> index 2e68cca798..bae46cc7d7 100644
> --- a/doc/guides/prog_guide/eventdev/event_ethernet_rx_adapter.rst
> +++ b/doc/guides/prog_guide/eventdev/event_ethernet_rx_adapter.rst
> @@ -96,16 +96,23 @@ when the adapter is created using the above-
> mentioned APIs.
>  Adding Rx Queues to the Adapter Instance
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>=20
> -Ethdev Rx queues are added to the instance using the -
> ``rte_event_eth_rx_adapter_queue_add()`` function. Configuration for the =
Rx -
> queue is passed in using a ``struct rte_event_eth_rx_adapter_queue_conf``
> -parameter. Event information for packets from this Rx queue is encoded i=
n the
> -``ev`` field of ``struct rte_event_eth_rx_adapter_queue_conf``. The -
> servicing_weight member of the struct
> rte_event_eth_rx_adapter_queue_conf
> -is the relative polling frequency of the Rx queue and is applicable when=
 the -
> adapter uses a service core function. The applications can configure queu=
e -
> event buffer size in ``struct
> rte_event_eth_rx_adapter_queue_conf::event_buf_size``
> -parameter.
> +Ethdev Rx queues can be added to the instance using either the
> +``rte_event_eth_rx_adapter_queue_add()`` function or
> +``rte_event_eth_rx_adapter_queues_add()``. The former is used to add a
> +single Rx queue at a time, while the latter allows adding multiple Rx
> +queues in a single call.
> +
> +Single Queue Addition
> +^^^^^^^^^^^^^^^^^^^^^
> +
> +The ``rte_event_eth_rx_adapter_queue_add()`` API allows adding a single
> +Rx queue to the adapter instance. Configuration for the Rx queue is
> +passed using a ``struct rte_event_eth_rx_adapter_queue_conf``
> +parameter. Event information for packets from this Rx queue is encoded
> +in the ``ev`` field of this struct. The ``servicing_weight`` member of
> +the struct determines the relative polling frequency of the Rx queue
> +and is applicable when the adapter uses a service core function.
> +Applications can also configure the queue event buffer size using the
> ``event_buf_size`` parameter in ``struct
> rte_event_eth_rx_adapter_queue_conf``.
>=20
>  .. code-block:: c
>=20
> @@ -122,6 +129,39 @@ parameter.
>                                                  eth_dev_id,
>                                                  0, &queue_config);
>=20
> +Bulk Queue Addition
> +^^^^^^^^^^^^^^^^^^^
> +
> +The ``rte_event_eth_rx_adapter_queues_add()`` API allows the addition
> +of multiple Rx queues in a single call. While
> +``rte_event_eth_rx_adapter_queue_add()`` supports adding multiple
> +queues by specifying ``rx_queue_id =3D -1``, it does not allow applying
> +specific configurations to each queue individually.  The
> +``rte_event_eth_rx_adapter_queues_add()`` API accepts an array of
> +receive queue IDs along with their corresponding configurations,
> +enabling control over each Rx queue's settings.
> +
> +.. code-block:: c
> +
> +        struct rte_event_eth_rx_adapter_queue_conf
> queue_config[nb_rx_queues];
> +        int rx_queue_id[nb_rx_queues];
> +
> +        for (int i =3D 0; i < nb_rx_queues; i++) {
> +            rx_queue_id[i] =3D i;
> +            queue_config[i].rx_queue_flags =3D 0;
> +            queue_config[i].ev.queue_id =3D i;
> +            queue_config[i].ev.sched_type =3D RTE_SCHED_TYPE_ATOMIC;
> +            queue_config[i].ev.priority =3D 0;
> +            queue_config[i].servicing_weight =3D 1;
> +            queue_config[i].event_buf_size =3D 1024;
> +        }
> +
> +        err =3D rte_event_eth_rx_adapter_queues_add(id,
> +                                                 eth_dev_id,
> +                                                 rx_queue_id,
> +                                                 queue_config,
> +                                                 nb_rx_queues);
> +
>  Querying Adapter Capabilities
>  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>=20
> diff --git a/lib/eventdev/eventdev_pmd.h b/lib/eventdev/eventdev_pmd.h
> index 36148f8d86..ad13ba5b03 100644
> --- a/lib/eventdev/eventdev_pmd.h
> +++ b/lib/eventdev/eventdev_pmd.h
> @@ -25,6 +25,7 @@
>  #include <rte_mbuf_dyn.h>
>=20
>  #include "event_timer_adapter_pmd.h"
> +#include "rte_event_eth_rx_adapter.h"
>  #include "rte_eventdev.h"
>=20
>  #ifdef __cplusplus
> @@ -708,6 +709,37 @@ typedef int
> (*eventdev_eth_rx_adapter_queue_add_t)(
>  		int32_t rx_queue_id,
>  		const struct rte_event_eth_rx_adapter_queue_conf
> *queue_conf);
>=20
> +/**
> + * Add ethernet Rx queues to event device in burst. This callback is
> +invoked if
> + * the caps returned from rte_eventdev_eth_rx_adapter_caps_get(,
> +eth_port_id)
> + * has RTE_EVENT_ETH_RX_ADAPTER_CAP_INTERNAL_PORT set.
> + *
> + * @param dev
> + *   Event device pointer
> + *
> + * @param eth_dev
> + *   Ethernet device pointer
> + *
> + * @param rx_queue_id
> + *   Ethernet device receive queue index array
> + *
> + * @param queue_conf
> + *   Additional configuration structure array
> + *
> + * @param nb_rx_queues
> + *   Number of ethernet device receive queues
> + *
> + * @return
> + *   - 0: Success, ethernet receive queues added successfully.
> + *   - <0: Error code returned by the driver function.
> + */
> +typedef int (*eventdev_eth_rx_adapter_queues_add_t)(
> +		const struct rte_eventdev *dev,
> +		const struct rte_eth_dev *eth_dev,
> +		int32_t rx_queue_id[],
> +		const struct rte_event_eth_rx_adapter_queue_conf
> queue_conf[],
> +		uint16_t nb_rx_queues);
> +
>  /**
>   * Delete ethernet Rx queues from event device. This callback is invoked=
 if
>   * the caps returned from eventdev_eth_rx_adapter_caps_get(, eth_port_id=
)
> @@ -1578,6 +1610,8 @@ struct eventdev_ops {
>  	/**< Get ethernet Rx adapter capabilities */
>  	eventdev_eth_rx_adapter_queue_add_t eth_rx_adapter_queue_add;
>  	/**< Add Rx queues to ethernet Rx adapter */
> +	eventdev_eth_rx_adapter_queues_add_t
> eth_rx_adapter_queues_add;
> +	/**< Add Rx queues to ethernet Rx adapter in burst */
>  	eventdev_eth_rx_adapter_queue_del_t eth_rx_adapter_queue_del;
>  	/**< Delete Rx queues from ethernet Rx adapter */
>  	eventdev_eth_rx_adapter_queue_conf_get_t
> eth_rx_adapter_queue_conf_get; diff --git a/lib/eventdev/eventdev_trace.h
> b/lib/eventdev/eventdev_trace.h index 8ff8841729..6b334d8bd1 100644
> --- a/lib/eventdev/eventdev_trace.h
> +++ b/lib/eventdev/eventdev_trace.h
> @@ -159,6 +159,20 @@ RTE_TRACE_POINT(
>  	rte_trace_point_emit_int(rc);
>  )
>=20
> +RTE_TRACE_POINT(
> +	rte_eventdev_trace_eth_rx_adapter_queues_add,
> +	RTE_TRACE_POINT_ARGS(uint8_t adptr_id, uint16_t eth_dev_id,
> +		uint16_t nb_rx_queues, void *rx_queue_id,
> +		const void *queue_conf,
> +		int rc),
> +	rte_trace_point_emit_u8(adptr_id);
> +	rte_trace_point_emit_u16(eth_dev_id);
> +	rte_trace_point_emit_u16(nb_rx_queues);
> +	rte_trace_point_emit_ptr(rx_queue_id);
> +	rte_trace_point_emit_ptr(queue_conf);
> +	rte_trace_point_emit_int(rc);
> +)
> +
>  RTE_TRACE_POINT(
>  	rte_eventdev_trace_eth_rx_adapter_queue_del,
>  	RTE_TRACE_POINT_ARGS(uint8_t adptr_id, uint16_t eth_dev_id, diff -
> -git a/lib/eventdev/eventdev_trace_points.c
> b/lib/eventdev/eventdev_trace_points.c
> index e7af1591f7..8caf6353a1 100644
> --- a/lib/eventdev/eventdev_trace_points.c
> +++ b/lib/eventdev/eventdev_trace_points.c
> @@ -65,6 +65,9 @@
> RTE_TRACE_POINT_REGISTER(rte_eventdev_trace_eth_rx_adapter_free,
>=20
> RTE_TRACE_POINT_REGISTER(rte_eventdev_trace_eth_rx_adapter_queue_ad
> d,
>  	lib.eventdev.rx.adapter.queue.add)
>=20
> +RTE_TRACE_POINT_REGISTER(rte_eventdev_trace_eth_rx_adapter_queues_
> add,
> +	lib.eventdev.rx.adapter.queues.add)
> +
>=20
> RTE_TRACE_POINT_REGISTER(rte_eventdev_trace_eth_rx_adapter_queue_del
> ,
>  	lib.eventdev.rx.adapter.queue.del)
>=20
> diff --git a/lib/eventdev/rte_event_eth_rx_adapter.c
> b/lib/eventdev/rte_event_eth_rx_adapter.c
> index 39674c4604..87bb64bcd5 100644
> --- a/lib/eventdev/rte_event_eth_rx_adapter.c
> +++ b/lib/eventdev/rte_event_eth_rx_adapter.c
> @@ -2793,6 +2793,161 @@ rte_event_eth_rx_adapter_queue_add(uint8_t
> id,
>  	return 0;
>  }
>=20
> +int
> +rte_event_eth_rx_adapter_queues_add(uint8_t id, uint16_t eth_dev_id,
> int32_t rx_queue_id[],
> +				    const struct
> rte_event_eth_rx_adapter_queue_conf queue_conf[],
> +				    uint16_t nb_rx_queues)
> +{
> +	struct rte_event_eth_rx_adapter_vector_limits limits;
> +	struct event_eth_rx_adapter *rx_adapter;
> +	struct eth_device_info *dev_info;
> +	struct rte_eventdev *dev;
> +	uint32_t cap, i;
> +	int ret;
> +
> +	if (rxa_memzone_lookup())
> +		return -ENOMEM;
> +
> +	RTE_EVENT_ETH_RX_ADAPTER_ID_VALID_OR_ERR_RET(id, -EINVAL);
> +	RTE_ETH_VALID_PORTID_OR_ERR_RET(eth_dev_id, -EINVAL);
> +
> +	rx_adapter =3D rxa_id_to_adapter(id);
> +	if ((rx_adapter =3D=3D NULL) || (queue_conf =3D=3D NULL))
> +		return -EINVAL;
> +
> +	if (nb_rx_queues && rx_queue_id =3D=3D NULL)
> +		return -EINVAL;
> +
> +	if (nb_rx_queues > rte_eth_devices[eth_dev_id].data->nb_rx_queues)
> {
> +		RTE_EDEV_LOG_ERR("Invalid number of rx queues %" PRIu16,
> nb_rx_queues);
> +		return -EINVAL;
> +	}
> +
> +	ret =3D rte_event_eth_rx_adapter_caps_get(rx_adapter->eventdev_id,
> eth_dev_id, &cap);
> +	if (ret) {
> +		RTE_EDEV_LOG_ERR("Failed to get adapter caps edev %"
> PRIu8 "eth port %" PRIu16, id,
> +				 eth_dev_id);
> +		return ret;
> +	}
> +
> +	if ((cap & RTE_EVENT_ETH_RX_ADAPTER_CAP_MULTI_EVENTQ) =3D=3D 0
> && nb_rx_queues) {
> +		RTE_EDEV_LOG_ERR("Rx queues can only be connected to
> single "
> +				 "event queue, eth port: %" PRIu16 " adapter
> id: %" PRIu8,
> +				 eth_dev_id, id);
> +		return -EINVAL;
> +	}
> +

If the adapter does not support en queueing to multiple event queues, why a=
re multiple rx queues not supported?
All the rx_queues queue_conf can be pointing to the=A0same single event que=
ue (queue_config[i].ev.queue_id).
Maybe all the "ev.queue_id"s need to be validated here to be the same?


> +	for (i =3D 0; i < (nb_rx_queues ? nb_rx_queues : 1); i++) {
> +		const struct rte_event_eth_rx_adapter_queue_conf *conf;
> +
> +		conf =3D &queue_conf[i];
> +		if ((cap &
> RTE_EVENT_ETH_RX_ADAPTER_CAP_OVERRIDE_FLOW_ID) =3D=3D 0 &&
> +		    (conf->rx_queue_flags &
> RTE_EVENT_ETH_RX_ADAPTER_QUEUE_FLOW_ID_VALID)) {
> +			RTE_EDEV_LOG_ERR("Flow ID override is not
> supported in queue_conf[%" PRIu32
> +					 "], eth port: %" PRIu16 " adapter id:
> %" PRIu8,
> +					 i, eth_dev_id, id);
> +			return -EINVAL;
> +		}
> +
> +		if (conf->rx_queue_flags &
> RTE_EVENT_ETH_RX_ADAPTER_QUEUE_EVENT_VECTOR) {
> +			if ((cap &
> RTE_EVENT_ETH_RX_ADAPTER_CAP_EVENT_VECTOR) =3D=3D 0) {
> +				RTE_EDEV_LOG_ERR(
> +					"Event vectorization is unsupported in
> queue_conf[%" PRIu32
> +					"], eth port: %" PRIu16 " adapter id:
> %" PRIu8,
> +					i, eth_dev_id, id);
> +				return -EINVAL;
> +			}
> +
> +			ret =3D
> rte_event_eth_rx_adapter_vector_limits_get(rx_adapter->eventdev_id,
> +
> eth_dev_id, &limits);
> +			if (ret < 0) {
> +				RTE_EDEV_LOG_ERR("Failed to get event
> device vector limits,"
> +						 " eth port: %" PRIu16 "
> adapter id: %" PRIu8,
> +						 eth_dev_id, id);
> +				return -EINVAL;
> +			}
> +
> +			if (conf->vector_sz < limits.min_sz || conf->vector_sz
> > limits.max_sz ||
> +			    conf->vector_timeout_ns < limits.min_timeout_ns
> ||
> +			    conf->vector_timeout_ns > limits.max_timeout_ns
> ||
> +			    conf->vector_mp =3D=3D NULL) {
> +				RTE_EDEV_LOG_ERR(
> +					"Invalid event vector configuration in
> queue_conf[%" PRIu32
> +					"], eth port: %" PRIu16 " adapter id:
> %" PRIu8,
> +					i, eth_dev_id, id);
> +				return -EINVAL;
> +			}
> +
> +			if (conf->vector_mp->elt_size < (sizeof(struct
> rte_event_vector) +
> +							 (sizeof(uintptr_t) *
> conf->vector_sz))) {
> +				RTE_EDEV_LOG_ERR(
> +					"Invalid event vector configuration in
> queue_conf[%" PRIu32
> +					"], eth port: %" PRIu16 " adapter id:
> %" PRIu8,
> +					i, eth_dev_id, id);
> +				return -EINVAL;
> +			}
> +		}
> +
> +		if ((rx_adapter->use_queue_event_buf && conf-
> >event_buf_size =3D=3D 0) ||
> +		    (!rx_adapter->use_queue_event_buf && conf-
> >event_buf_size !=3D 0)) {
> +			RTE_EDEV_LOG_ERR("Invalid Event buffer size in
> queue_conf[%" PRIu32 "]", i);
> +			return -EINVAL;
> +		}
> +	}
> +
> +	dev =3D &rte_eventdevs[rx_adapter->eventdev_id];
> +	dev_info =3D &rx_adapter->eth_devices[eth_dev_id];
> +
> +	if (cap & RTE_EVENT_ETH_RX_ADAPTER_CAP_INTERNAL_PORT) {
> +		if (*dev->dev_ops->eth_rx_adapter_queues_add =3D=3D NULL)
> +			return -ENOTSUP;
> +
> +		if (dev_info->rx_queue =3D=3D NULL) {
> +			dev_info->rx_queue =3D
> +				rte_zmalloc_socket(rx_adapter->mem_name,
> +						   dev_info->dev->data-
> >nb_rx_queues *
> +							   sizeof(struct
> eth_rx_queue_info),
> +						   0, rx_adapter->socket_id);
> +			if (dev_info->rx_queue =3D=3D NULL)
> +				return -ENOMEM;
> +		}
> +
> +		ret =3D (*dev->dev_ops->eth_rx_adapter_queues_add)(
> +			dev, &rte_eth_devices[eth_dev_id], rx_queue_id,
> queue_conf, nb_rx_queues);
> +		if (ret =3D=3D 0) {
> +			dev_info->internal_event_port =3D 1;
> +
> +			if (nb_rx_queues =3D=3D 0)
> +				rxa_update_queue(rx_adapter, dev_info, -1,
> 1);
> +
> +			for (i =3D 0; i < nb_rx_queues; i++)
> +				rxa_update_queue(rx_adapter, dev_info,
> rx_queue_id[i], 1);
> +		}
> +	} else {
> +		rte_spinlock_lock(&rx_adapter->rx_lock);
> +		dev_info->internal_event_port =3D 0;
> +		ret =3D rxa_init_service(rx_adapter, id);
> +		if (ret =3D=3D 0) {
> +			uint32_t service_id =3D rx_adapter->service_id;
> +
> +			if (nb_rx_queues =3D=3D 0)
> +				ret =3D rxa_sw_add(rx_adapter, eth_dev_id, -1,
> &queue_conf[0]);
> +
> +			for (i =3D 0; i < nb_rx_queues; i++)
> +				ret =3D rxa_sw_add(rx_adapter, eth_dev_id,
> rx_queue_id[i],
> +						 &queue_conf[i]);
> +
> +			rte_service_component_runstate_set(service_id,
> +
> rxa_sw_adapter_queue_count(rx_adapter));
> +		}
> +		rte_spinlock_unlock(&rx_adapter->rx_lock);
> +	}
> +
> +	rte_eventdev_trace_eth_rx_adapter_queues_add(id, eth_dev_id,
> nb_rx_queues, rx_queue_id,
> +						     queue_conf, ret);
> +	return ret;
> +}
> +
>  static int
>  rxa_sw_vector_limits(struct rte_event_eth_rx_adapter_vector_limits *limi=
ts)
> { diff --git a/lib/eventdev/rte_event_eth_rx_adapter.h
> b/lib/eventdev/rte_event_eth_rx_adapter.h
> index 9237e198a7..758e1c5f56 100644
> --- a/lib/eventdev/rte_event_eth_rx_adapter.h
> +++ b/lib/eventdev/rte_event_eth_rx_adapter.h
> @@ -553,6 +553,39 @@ int rte_event_eth_rx_adapter_queue_add(uint8_t
> id,
>  			int32_t rx_queue_id,
>  			const struct rte_event_eth_rx_adapter_queue_conf
> *conf);
>=20
> +/**
> + * Add multiple receive queues to an event adapter.
> + *
> + * @param id
> + *  Adapter identifier.
> + *
> + * @param eth_dev_id
> + *  Port identifier of Ethernet device.
> + *
> + * @param rx_queue_id
> + *  Array of Ethernet device receive queue indices.
> + *  If nb_rx_queues is 0, then rx_queue_id is ignored.
> + *
> + * @param conf
> + *  Array of additional configuration structures of type
> + *  *rte_event_eth_rx_adapter_queue_conf*. conf[i] is used for
> rx_queue_id[i].
> + *  If nb_rx_queues is 0, then conf[0] is used for all Rx queues.
> + *
> + * @param nb_rx_queues
> + *  Number of receive queues to add.
> + *  If nb_rx_queues is 0, then all Rx queues configured for
> + *  the device are added with the same configuration in conf[0].
> + * @see RTE_EVENT_ETH_RX_ADAPTER_CAP_MULTI_EVENTQ
> + *
> + * @return
> + *  - 0: Success, Receive queues added correctly.
> + *  - <0: Error code on failure.
> + */
> +__rte_experimental
> +int rte_event_eth_rx_adapter_queues_add(uint8_t id, uint16_t eth_dev_id,
> int32_t rx_queue_id[],
> +					const struct
> rte_event_eth_rx_adapter_queue_conf conf[],
> +					uint16_t nb_rx_queues);
> +
>  /**
>   * Delete receive queue from an event adapter.
>   *
> diff --git a/lib/eventdev/version.map b/lib/eventdev/version.map index
> 42a5867aba..44687255cb 100644
> --- a/lib/eventdev/version.map
> +++ b/lib/eventdev/version.map
> @@ -153,6 +153,9 @@ EXPERIMENTAL {
>  	__rte_eventdev_trace_port_preschedule_modify;
>  	rte_event_port_preschedule;
>  	__rte_eventdev_trace_port_preschedule;
> +
> +	# added in 25.03
> +	rte_event_eth_rx_adapter_queues_add;
>  };
>=20
>  INTERNAL {
> --
> 2.25.1

