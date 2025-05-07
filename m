Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAF6DC3ABC5
	for <dpdk-dev@archiver.kernel.org>; Wed,  7 May 2025 08:59:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 24DE9402AB;
	Wed,  7 May 2025 10:59:15 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by mails.dpdk.org (Postfix) with ESMTP id 9E5AB4025A;
 Wed,  7 May 2025 10:59:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1746608353; x=1778144353;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=5dDQboHMGj5Sk4UOICcYwKpRcB75MI0DNu0/OHQAa88=;
 b=ikRc0T90Be8ra6vySCzkW2dihSEpY6pLTPxBUimAhKD5FPQql4B7oSWV
 SkeYieN2fDhNiJzo83lEl02eLgbR7o48dEzj/sqvZfU16zCYvfMzziTVG
 RC3gfZu+CHInOJNaLCUS6/eN9XiLL+PbyZjWZnBR0M8lqAwMpsugevuQB
 GBtKC8g2RPBv9yGxCmFGcBB5YgfLJ/Ant69ezGlK/pzugyMZDb9l+xk2U
 5VELT+0pK7p9V/lGmGO0Fd5+EBMeTBTd50MtctsWZBY2qas3FCXcoV4d1
 chdqUplH0uU0iSRTBIc9V8g6nv5dqsW9FJm3SbB0khRKHtVoYrVYRJ4zv A==;
X-CSE-ConnectionGUID: cgmmBE2WT7eCLqMlKU5oCw==
X-CSE-MsgGUID: FTDRkLgkR0u0NCzrNK0sAQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11425"; a="73715400"
X-IronPort-AV: E=Sophos;i="6.15,268,1739865600"; d="scan'208";a="73715400"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 May 2025 01:59:11 -0700
X-CSE-ConnectionGUID: UAGx+5n0Say+LTpxeRkcTQ==
X-CSE-MsgGUID: R9qV18VlRyqCxLMAbtpxVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,268,1739865600"; d="scan'208";a="135796076"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 May 2025 01:59:12 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 7 May 2025 01:59:10 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 7 May 2025 01:59:10 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.172)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 7 May 2025 01:59:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L1acWSAColwPwDNBPFM+ThOXZlKfAU9T3qAnUEbWlnKzXLz4P1idtsSEiL+vCZkwByD8Jv/ORm/ptQTpZ33b3fvdmEdUVIIqexO9/2cpEpnqW93tw6pTGBT3djJKZGMLC0x3yH8qqoWkeNt0TGc1AYldjwBSUrfEn+zq00CK//oUuJDFgHjV8GsMd0+NF4MFnmjmXG+eR3DUiqAXJ5RRHKt8Bl862tgjU5FQXNrWR7LbNIaeTzku31518qPpLeMmWx4mHY5DxaBGLkPLrtLc6GnETlhpZpWSVwTU4BhZnsBepx8grpVNOObRXd8AY6CR/2RNf7q/BkAJIVY9hAvBlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=08I7/uyC/K3h9r1GvkvocWOD3ppWNTZ+948btEYta6Q=;
 b=RU8bn/Z2rhACDUacfaO4Rb3Y14+szLLaElJfwiN/3DhnA/TSmcxN1Qf9P7FSLEHyas7yakMWja98w5J35IcpfgvQXyOhIiLNF314BAx2JrD3K1XZ2ah0DdpkcHyOwzGm+Ceq+3hYChCJF1buSiIJfW0pGAR/txnMR3ZXiw/3298WRKaH00C7b39a74ebvuNWgk6ciTT9ymeClhvfCIl+KuVW3LoRyR1MU140dC60+/UQZQdttpOla3pNaK9Wr8Gz/FOhDJLsoygxstVgAEqN/6tIwLCgL5vc0ENh7H1K9AgMdvmQ/aO78bECWYgbUKT+v2mO0XVKH5Gl7dpIpMMJJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB7853.namprd11.prod.outlook.com (2603:10b6:208:3f7::8)
 by CH3PR11MB7818.namprd11.prod.outlook.com (2603:10b6:610:129::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.21; Wed, 7 May
 2025 08:59:04 +0000
Received: from IA1PR11MB7853.namprd11.prod.outlook.com
 ([fe80::7efd:f6ce:fbaf:1c73]) by IA1PR11MB7853.namprd11.prod.outlook.com
 ([fe80::7efd:f6ce:fbaf:1c73%3]) with mapi id 15.20.8699.026; Wed, 7 May 2025
 08:59:04 +0000
From: "Deng, KaiwenX" <kaiwenx.deng@intel.com>
To: "Richardson, Bruce" <bruce.richardson@intel.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "stable@dpdk.org" <stable@dpdk.org>,
 "Zhang, Qi Z" <qi.z.zhang@intel.com>, Yaroslav Brustinov <ybrustin@cisco.com>
Subject: RE: [PATCH] net/intel: fix igb tx queue offloads capability
Thread-Topic: [PATCH] net/intel: fix igb tx queue offloads capability
Thread-Index: AQHbrSNmXLQgoa7d+EeEpD6Q9E3YvrO5SACAgA2SvrA=
Date: Wed, 7 May 2025 08:59:04 +0000
Message-ID: <IA1PR11MB7853D99DFF2993A5E3F1C4828E88A@IA1PR11MB7853.namprd11.prod.outlook.com>
References: <20250414085353.848901-1-kaiwenx.deng@intel.com>
 <aA-c2XuK7SFVKqqZ@bricha3-mobl1.ger.corp.intel.com>
In-Reply-To: <aA-c2XuK7SFVKqqZ@bricha3-mobl1.ger.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB7853:EE_|CH3PR11MB7818:EE_
x-ms-office365-filtering-correlation-id: 09f4b959-8373-4fe5-2576-08dd8d456b13
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?JUqxAT/g5V6D/euhP4/lkWHAFW/NnxqnsKpGSRl83j4qQOd3XaqStzuNuEsG?=
 =?us-ascii?Q?kmn+P9FGRG5XyoT87SkGJqrOomphen8cxW1UDolhm9GspCfrSE39TjQIy+b5?=
 =?us-ascii?Q?dvlwSIWeQVsSkZfGpTvCRjpxx0ue1FWqsOfQYMFPk+fmu6Rb0ce3NxMszPio?=
 =?us-ascii?Q?ut3OU9pY6q9BlNswSkEA6N1yXKoKg9D8cbdfEzCeedQS0ujnf44BzdAWa6Zb?=
 =?us-ascii?Q?O2HIFoO98EmzFf9JGZdeELwMIWo8RPsozG2ApEfkT9HN9BdG1sQSFT4NKb6q?=
 =?us-ascii?Q?TCca0TTfwP8ieNNmWOuJvuLkdNOWihJyuRk6ebR61UWBfRy6hrGVZdEOM5bo?=
 =?us-ascii?Q?x9N41aR2gpVHsKW35waHq5fKEkigi2I71BDRBnq07BOGnMnK7yghks2WTIi0?=
 =?us-ascii?Q?MvwU1AANSNC6WY0/GlXQYuonMz4LFlapsIt/Gor8JqsExNVB1N7DFr7hotS1?=
 =?us-ascii?Q?cQBE7sb3mvIcpgrem/5JFp6KzdlfBZbCjSU1e7pD7Pwv4TUSwnox4C/soDuo?=
 =?us-ascii?Q?eRv3PjPx8XaU8qT3G8aZUZxNWOUn8lLnRXUrsysP7Z6oldv2xqB9Vs/FtAPq?=
 =?us-ascii?Q?YmzwVRiUyD9ymx06Jomd4EL54hZhihEjZ+YzdGws9BC48jS48GgQYRaQCcps?=
 =?us-ascii?Q?wx1g+cEUhrD6Qg0zP6kEp9PIMCLERnkGz5csE9CldlOadEn/YOJPXAX9g4nM?=
 =?us-ascii?Q?wd1Ezl9Iy8KsrHDg6EloLKKjfF7vtmmX/vIjwFWoYdOR0xa73nbr7y51Z6ze?=
 =?us-ascii?Q?0VauoUF9k4d4aWJS/V+ZFOGtwYE7Njrj3TYCjDrPTLj6Pn/uaKj15JjHIN8c?=
 =?us-ascii?Q?/U8EcggMv8d/wmC19wxgMBwKr8klyxkzFLQMV3Co5IwnjY9CMa/g3p97G5lm?=
 =?us-ascii?Q?JVRsgjzauPlGf3axMGlDMf8iCMOIpjuWLERpj/B8OZnZTLpBrAk2g1xsjSPs?=
 =?us-ascii?Q?9DpgdqE/dFcD+z3cF577jhunZGivYM9JpfrJ3Wkiahw3tNmE+YPf5JIx01yp?=
 =?us-ascii?Q?IOT5hIAlpirLPIVAswIAAqYhrsBM07xqBkvXyKg37w3BiDAw+3hwrluTu6Mj?=
 =?us-ascii?Q?Ty9AkPOXo0ccTQ/34AekojiCW3iCS/je4p3qOmTySAuku3LPAoxKv+yEB9bo?=
 =?us-ascii?Q?FrloswDu80XIwYhMOTn5S3aDbB9QUv1EosVXcqF2BI/+04xodaeqL7vexTX+?=
 =?us-ascii?Q?W0VlG+K7XVdmagsiCuZyvght4BJW+JIPCLpshETkB24ibf/VfYAXf7W0kSB7?=
 =?us-ascii?Q?TIZ7qc+lmwsQ/9XWws5WuG7Q+bKogBSeRFRWJPkmgDGz9kZU30ZC+fDdASgU?=
 =?us-ascii?Q?hlTkKOryQQVpwuuVc/hh36iUVTK7q2YrWk1LL1+lm+HmLv43LrNDqLO0RR1w?=
 =?us-ascii?Q?s9h+aHEfIzyXxIN9jDGNK2XJzAfUpOrQFP5H1LL/1tiR9fj28l2POOcYE8rM?=
 =?us-ascii?Q?IPfmwDTgpQPvW41tYuGjBIYu3LPxr/uaS2SrlkxOwIilP5Lh+3/EIw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR11MB7853.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?smWGKQ2QmozEXtUJEZFJeWSvS40HoUq5+zuMa8WIk/aqWwLHVLdsNGcFXCEd?=
 =?us-ascii?Q?emzN6D6Bm3M/JE0Sz4tTiVarvrUAl+mYHl0PYLEWh7Zq6a1Ol1EdTMOGcx7/?=
 =?us-ascii?Q?x+pA1o41M7d/+kGyP3Hy8Fd1+5bN0cwYWDQqQfmWx6YuFYoRO16q+Ei50m2i?=
 =?us-ascii?Q?zaYn1+YLmURcSUrYy93DONo+lfR7OGj2xt49bJ/huFyBxUftsU3Yj8XHWdOc?=
 =?us-ascii?Q?baGCLxvW1nE8rd/VHd+fdfIQyCu0ORLebZd/1OgEwR6p6268ORkDiLz8ZWwS?=
 =?us-ascii?Q?Sf+GG2OsGhJUr2AyCD6uKeD/oQkAsp0z57BtLDT1GPuN3vl/nJsku4yKH9s/?=
 =?us-ascii?Q?L2Kd/6g1r/JQtpcFdmZktI1IPSUEysEilRa7lt5fcYtUJRRSokZMB8N6zFON?=
 =?us-ascii?Q?ofGHrBstSYlOGGhyc4X5Atei4fHE3asxiMxaDWD46ieUwHRnWaJFdgBdWyKk?=
 =?us-ascii?Q?W4rDp8GGPJa7Oay5MMpGUC6CxINxCObUmunxXZ0eXl+em6JwCwkSDzR5/jgp?=
 =?us-ascii?Q?6J/wMGWugQim8+FZdhLZMFghMySoiwVhJQ82rwUmkjDXLMBk/ds5/SG3J8ng?=
 =?us-ascii?Q?jfcqA5yTny3OeOWXSWZETJr3WzNy4tpuugkaizKc5NHPTV4rse6hRcE9Fc/d?=
 =?us-ascii?Q?mkoWjQV23MQEFAOIQp5CrLoimB9cGO05oLBgGbZM2cO+YtjEghRxvHqsEpi2?=
 =?us-ascii?Q?OAz44NOUlo/3WAPMazGIb5X2OvgPcs7gK+1VfxLB41Aho4dbppRxzHrcQ+v5?=
 =?us-ascii?Q?TzI+M1EEcGS1PMu/OafdqpQ/ucRGDTsnr7Fy4jy1TeBOm3IBD/q+vKOCzRii?=
 =?us-ascii?Q?ybh/jH2Uz3a2Iiyssl/nQCoLuA7zKhH//JtbcPLRk5qQ4wFr6B+x5XrQshdE?=
 =?us-ascii?Q?toAK9Z20Wd9yHizdPKNY5FT74jJfiJZemPmP23gsI41PQoQBNiTqqakayIn0?=
 =?us-ascii?Q?B5sgmZUhmzmyopQ8DGtispFVFXDa5vCPJarro/QBGyTpmG8sXs9ol8ClpE/5?=
 =?us-ascii?Q?GcJvwylJx31vHWNdC1V0XUWR0rJ/6sXqF1trZ8Cy/rMuZ1OxS+i64nnsVh2Z?=
 =?us-ascii?Q?4h23rrhOWcxgQnX/O9mSl55wHkVIuwHxdqDS6PdhWSJbRoo0meB+kx/ZSvne?=
 =?us-ascii?Q?fRXxbb8cRSlZBCc/3GkuZvqs5GHMJm00h98vx91VvbJoor5P1djmzqyNk0Kw?=
 =?us-ascii?Q?rTkhmranA0IuDhDmdawXyweeD36CO1x6J1WybzTZYQ0nm1Fc8o8Aiwz76611?=
 =?us-ascii?Q?cxvMnQy5Pir8hDGOXJHqMNJTs5yDL2m18KJsJR302rzp3f7CqcR/y7DXxD+p?=
 =?us-ascii?Q?np6y6bdEEw1FBkXJ7eA7WCwAz17cHvzMHzhI9331TFqV05Yt6DH+P8Pzx3kt?=
 =?us-ascii?Q?G9njy71nj9nNqGVOf/XI665Ih80lgavy8CsgD8+vGnYgRTqvzW8UdTYLAryy?=
 =?us-ascii?Q?IVUuOs6ahPNz6YtxxBcnxh5xWxoaBYxHOcwbGOvw1eUC/iiBnCEC6Je6Saf7?=
 =?us-ascii?Q?Wiy2LbXhQeK57RDP5E9jLhB9NWx0m43bDyRN0kc6d5fqogmV/GLEkmSQZjUH?=
 =?us-ascii?Q?xySo/TYYumNruLa0nhQIkrGTIx9GHBxZ7Rf8wLDt?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7853.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09f4b959-8373-4fe5-2576-08dd8d456b13
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2025 08:59:04.4549 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aRUoNio952Mybq7uCA7cC+9iMs6QA3eYTMV8QEjhaScu8M28CU3GkqY8WnrvZrO568qNYCmmlyhkU04chq9TsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7818
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
> Sent: Monday, April 28, 2025 11:21 PM
> To: Deng, KaiwenX <kaiwenx.deng@intel.com>
> Cc: dev@dpdk.org; stable@dpdk.org; Zhang, Qi Z <qi.z.zhang@intel.com>;
> Yaroslav Brustinov <ybrustin@cisco.com>
> Subject: Re: [PATCH] net/intel: fix igb tx queue offloads capability
>=20
> On Mon, Apr 14, 2025 at 04:53:52PM +0800, Kaiwen Deng wrote:
> > The igb driver assigns the tx port offload capability to the tx queue
> > offload capability.
> >
> > This commit will fix this issue.
> >
> > Fixes: daa3b0833f08 ("net/e1000: fix Tx offload capability typos")
> > Cc: stable@dpdk.org
> >
> > Signed-off-by: Kaiwen Deng <kaiwenx.deng@intel.com>
> > ---
> >  drivers/net/intel/e1000/igb_rxtx.c | 6 ++----
> >  1 file changed, 2 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/net/intel/e1000/igb_rxtx.c
> > b/drivers/net/intel/e1000/igb_rxtx.c
> > index 4276bb6d31..b63de2354f 100644
> > --- a/drivers/net/intel/e1000/igb_rxtx.c
> > +++ b/drivers/net/intel/e1000/igb_rxtx.c
> > @@ -1490,11 +1490,9 @@ igb_get_tx_port_offloads_capa(struct
> > rte_eth_dev *dev)  uint64_t  igb_get_tx_queue_offloads_capa(struct
> > rte_eth_dev *dev)  {
> > -	uint64_t tx_queue_offload_capa;
> > -
> > -	tx_queue_offload_capa =3D igb_get_tx_port_offloads_capa(dev);
> > +	RTE_SET_USED(dev);
> >
> > -	return tx_queue_offload_capa;
> > +	return 0;
> >  }
> >
>=20
> I suspect there may be more instances in the code where we do this. For
> example, I see the same pattern used in em_rxtx.c in e1000. Can you quick=
ly
> check our other drivers to see if the same mistake is repeated elsewhere =
other
> than "igb" and "em"?
Hi Bruce,
After checking, the same error is not repeated anywhere else except on "igb=
" and "em" .
However, I noticed that there is only one txq available for the "em" device=
, and according=20
to the comments in the code, This design may be intentional, as port offloa=
ding and queue=20
offloading are practically the same in the case of only one txq.
>=20
> /Bruce
