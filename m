Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71E85CA101F
	for <dpdk-dev@archiver.kernel.org>; Wed, 10 Sep 2025 09:52:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D99D7402E9;
	Wed, 10 Sep 2025 11:52:55 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTP id 103EB40270;
 Wed, 10 Sep 2025 11:52:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1757497973; x=1789033973;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=AwaMNU4O53/RU49ksN67pdzQ+2OXR+NR3Kv28lyaaco=;
 b=ChfCiiSdIZwKZcDIEKtV5NYGv8x8HDPjP+bMkpL71oy6NrlglQlO/WQA
 L6x25e9IDL0mHpJsySzh8CXuaNEkGU2leVfuVu0hcSjD/lcxTB9/HnCwc
 /h1QBcpC1EioPazhWFUBqUt5iKQbSHmxY7gdSauAwSqyNx1d85kzEjWtC
 FNqs/vlWk+Rt3qEYwixAJXZDZCh5cl8PsUMSmo4CZA0VbvaKJnEYxPo/4
 enqyXBBgCe9WCm9yUApRA243X3ugsJGht62oHTzzEWe5St30H8w2AVeRW
 Gmkw7flUR2FaarIqv2vey1xS/jXchljAAKpihwflstp9A4wMlXXzHYk/8 w==;
X-CSE-ConnectionGUID: ruFpp7V9TOqo8B+Z7bNSvw==
X-CSE-MsgGUID: VM09lWX7S/WHKVghHV6Wgw==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="59750629"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; d="scan'208";a="59750629"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Sep 2025 02:52:47 -0700
X-CSE-ConnectionGUID: 43Ok+E6LQ9uy9w2tcxVznQ==
X-CSE-MsgGUID: 0wxc0Fn2TPKJWoRuqzp48A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,254,1751266800"; d="scan'208";a="172916248"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Sep 2025 02:52:37 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 10 Sep 2025 02:52:33 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Wed, 10 Sep 2025 02:52:33 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (40.107.102.48)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 10 Sep 2025 02:52:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=InCnfLeBK4aI/0DacAcdmcS/LXe4H4t3XRpbePhpLzBDuVo4SdjoR3yT4pqNFCNJm5si+1qKD7xzricc4ugCN4FUL5dG2ZXP6vWLWstGnKMGVGw1NIofniHLXfJW0xt7vWBD0xkVJ6a/GSBGO+i/N2LKeu/p9BMVWnVjPzQRcXNXjkc3c+ja5+RMA7xxfUlAknLITh1DUdACnN2qCWkfd1pSap3gn2Qj7qsj1jg1voPjTcMxwNVSZcdj03kizzcmxBtvlH3xBKH7v57FFEWP3wF5tDXL3h8dnidnFvGBgHL6ZiR0Vs0Y+J8eMu+ytimIj5MnNUmq4/WXwMmP8pYeOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xPjdlouVs+q6Cd+Hj3/nKPB86IxDMO3OXTLfGcP+Hgw=;
 b=YcIfXrq7pPnBfAp2TFhZnpi7lWfDGhY6oC2e4RoGM9y95WChP0NDh2iSOBHk494gHzCtscG2I/scOApifBPhaFHlKcU+Ie65763ll4Ff/fnAaiCgfhE0iowjyiQhuxAIk6Lxtipvg/f7yWjdbSyZoT49SrxLjLyshVfzMTiJef0gKZ18YcY+DUapc7hIbDEHJMRKf7QpSplqgeh3xk0tCbPkbga3REwdwgUWzFgHwjeVwBf/Lp0TvfxjFmzUYmJyCh7dxZGr6ThyKDwcMrfL8zhSQ4SQBLFtg91MXYJ3DomIZtkL4Um6Fp5Pn/jthYpCODa3wDtyHHoaoYnFsrgdrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8965.namprd11.prod.outlook.com (2603:10b6:208:582::16)
 by MN6PR11MB8193.namprd11.prod.outlook.com (2603:10b6:208:47a::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Wed, 10 Sep
 2025 09:52:31 +0000
Received: from IA3PR11MB8965.namprd11.prod.outlook.com
 ([fe80::d6ad:760c:6c44:f9bd]) by IA3PR11MB8965.namprd11.prod.outlook.com
 ([fe80::d6ad:760c:6c44:f9bd%5]) with mapi id 15.20.9094.021; Wed, 10 Sep 2025
 09:52:31 +0000
From: "Wang, YuanX" <yuanx.wang@intel.com>
To: "Richardson, Bruce" <bruce.richardson@intel.com>
CC: "Burakov, Anatoly" <anatoly.burakov@intel.com>, "Medvedkin, Vladimir"
 <vladimir.medvedkin@intel.com>, "dev@dpdk.org" <dev@dpdk.org>,
 "stable@dpdk.org" <stable@dpdk.org>
Subject: RE: [PATCH] net/ixgbe: fix port mask default value on E610
Thread-Topic: [PATCH] net/ixgbe: fix port mask default value on E610
Thread-Index: AQHb98RS6ifOpOkhPEalajc4j0gmY7RdiAIAgC7v5uA=
Date: Wed, 10 Sep 2025 09:52:31 +0000
Message-ID: <IA3PR11MB8965CDBED1E28B23A6543093850EA@IA3PR11MB8965.namprd11.prod.outlook.com>
References: <20250718090907.649202-1-yuanx.wang@intel.com>
 <aJniegZL1dok1nk0@bricha3-mobl1.ger.corp.intel.com>
In-Reply-To: <aJniegZL1dok1nk0@bricha3-mobl1.ger.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8965:EE_|MN6PR11MB8193:EE_
x-ms-office365-filtering-correlation-id: 0e455c33-8e53-4241-cf21-08ddf04fc267
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?ijV/nzon39kc2m+wAFoePO/Pqrrzm/K7xVpr1v8yZ2HWhiCNlE9x056aqf9d?=
 =?us-ascii?Q?1gAeZkYjnaUosur219oZG0O4ogRHUn7h35G9z3OmgsmXybtHDeSuoZSZSO44?=
 =?us-ascii?Q?4othp7tpis8If56/RWurU8D6qqXzzqlfUmqrya3lNte0nKEYuOYP4fcwLhNV?=
 =?us-ascii?Q?iNhsQpX/7qXEXKJwCGoX0N/OzbMMEuGUP8cYx72Yrb6qP7ID/3lt5dzwF/l8?=
 =?us-ascii?Q?ogvG5uUWuBANStaBi77lB3CWqtjQ08faRqoA1fnlcsE6JwWxyhN2J6P8iy1P?=
 =?us-ascii?Q?Q298TPoa6KXVk3vO9HFWMitUXf3vupIiow+0xx6N2k3UClh6+iwbH9ioFZZO?=
 =?us-ascii?Q?F2xMqkUdNe+CR9pQFVhM8PaYkNfdj+aZ4/ZGuEPk71Aczn7xc1Wo+pX8ibRp?=
 =?us-ascii?Q?Jq0fiD7d/elOuJs6yN3wRudlsv33ZeFqVj8X52qk2t22tAHnIfImrkPE8QPz?=
 =?us-ascii?Q?xbf1xcmdpGVH4kd8zCrvLxLl0DoBZAvIe1sI0nozspB4Zan1SoO/qDVekgG7?=
 =?us-ascii?Q?GAKJq92k4y3Q+0KlkqWrbI0oK25BRSNOwT9G6qRmWB/SR1Lk6F5h3BpEV5r4?=
 =?us-ascii?Q?2neudtmQTNGMFEpEdeXJc9XUNwzpvsQ2gGhOHn4Qfcq4u5UBd7rcEkf1P1/m?=
 =?us-ascii?Q?yUTSePOgYi9v3idHaVAMpl1heqb4w7A3z2XbZYP00zjqMSOAXa5PYTNWfMED?=
 =?us-ascii?Q?9gZlk/MIV0A1EXX4eEcXQPFQcnVJRqfkZCixkCo9y1ALrrBERj/Fg5LLwKIz?=
 =?us-ascii?Q?roiH56U3z8JnLmUZSPqlzO60c8evfj041ai9VT4QS/vmoW4RFVCOvAk9XiIm?=
 =?us-ascii?Q?G16frjf9HokNtkOXgRcxFLqHTlBtVmyylurVALzpqYz39Ym4MlMdHK20fLLh?=
 =?us-ascii?Q?Icassf7536UeXKCboSkfL+pNEN3DXdG3XLWyI0GHhQSZjdAlnu3TzjakKWhm?=
 =?us-ascii?Q?VQLxE0mBBm+myXyWNMYqfB+3JYbOGgYRGgBIFFf7NQYKE6JojsWWJBzBHvRT?=
 =?us-ascii?Q?AOXSv3DaTfHYVmWTzDUe4f9QEBJngsZ+pKqKiiAjLQWS+kQAaBVyNXNC2rk4?=
 =?us-ascii?Q?nVlweqCdYcFA27oBxQ1lw7Dx9vNaS6168j17EoB9w0fxPLjPSEmeRlHJAnfZ?=
 =?us-ascii?Q?zCpisg/SnqasYcOvBVLvodCOD0SO2S8XL7ZDiXiBVZyIRmqU+VIaWQZsTOqu?=
 =?us-ascii?Q?yvhh6adcAwCuSMdTPmv5kc1OrPKXUEXVJiRgsq+LJT4Hh7UmqukombWKrjdU?=
 =?us-ascii?Q?jngwyXpD9x1Uql23zFKmClABEbDZErnpdBUyn0Ap6z09BjwzDjPGy/0fhFh/?=
 =?us-ascii?Q?Qx3dQVW2xknkjYz815X6E3XWLukiGazfQ/5/wPB44wAGLvexnE8rkm6UqJ64?=
 =?us-ascii?Q?95b2NFnu5GvD6mV/nIIHf3dBR/JAL6Cpoyp4kMLcVPEavj7fTXFden7bWX0r?=
 =?us-ascii?Q?QGQEFm88Jjyc6gnFhRPgTfu5aDF8IOTdIZkaFyBa54G5ZuYFyMUL0ChAF9Fa?=
 =?us-ascii?Q?iX+bh/d/oKsDcqM=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB8965.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ZkoKTeno+EPl7L87D5xd0rurXrcHZ+c+8JmWGCJKOdKTxCReb5yh2MJntauh?=
 =?us-ascii?Q?rY5BfJ2UDmI1s8fkWsnvjvnVh4teZw1N2QHf+f/1ROnqr81sdudN/ng3sCPY?=
 =?us-ascii?Q?bqMgK8rvIpuRLXxayHAzYJTpUFF+rNyK0NOBhln8OmAXAmdO7qykLw3CDyQ/?=
 =?us-ascii?Q?SveSo//WnawQeK/BP4v3qbfxwWUH/FilITRRJJKQqRMFgffsRNQrpf8MRHm3?=
 =?us-ascii?Q?Dlu0L/gtNKSUfX+pHTr4LdwYSHwhglhzGso3P0vBiN+gJ+AWROogW2vP2Efa?=
 =?us-ascii?Q?NGCWQYNLOpHiY2pareX1pTIiBTX432QdoCQjCiKqSFAeQdWXjXmNRDkcWXrU?=
 =?us-ascii?Q?f6vxL2Gi99Rhgr/m0RAvRlFCsFU8Hq60E4Lg2x3tcluXnUAKTFOVwMUJUgxg?=
 =?us-ascii?Q?lcA69VzcjSw9TMqIpYJJ1CFMJpK1WevnZbKPlekW+6KORWM650GGoi7PEG+G?=
 =?us-ascii?Q?D/fYvJlZwHHKAIZ94RKCe/aA5tRy1Y388Nsp9fktd3SkxNIcXa/miwLy87f6?=
 =?us-ascii?Q?tuY178FoGn6ckBfrjEO9u3niln5vkEU90TMQghaZuTW/fkmTP/VxhaExX4w6?=
 =?us-ascii?Q?eLzYlbKbIAizB9AulOqZW+Fei73Gh3Mvqxw4VG8dfnJVwiOVugEzC9vFF+9J?=
 =?us-ascii?Q?CaCkfBcNO2yHHa3ZBRHG3QREwChziNYnd1RQMzV/GwTusaZCThbDJTuoeEuc?=
 =?us-ascii?Q?/zsReHOpUiCc5Fmc/+3POMvXRkBxr++y8ig+qBJYxNtxjW5vJPUlri/INDCA?=
 =?us-ascii?Q?Pha8OEsaIEebw81D5tCKuhZCMX7C2QkA/ww1GK2xiPSQm2lJHCes8uKdseJX?=
 =?us-ascii?Q?uY1aAi+PWrXcvFiabv8knNw+Rs0ycR/0bfIRF8ITBr1i7B83F1dCidP/V1dy?=
 =?us-ascii?Q?DZMLtHhhnvg0kEhp+21v4UKxDV9mtSGy5j9aOuuMtjFG/QjlFGYdFg9ZUG3I?=
 =?us-ascii?Q?6yKmqf/EyqVNeCqgk5tR+uMAxsHWnh+q2zhwA7pfcnQiEaLfTsnupsJ828tT?=
 =?us-ascii?Q?CFz1dUV27AIu3uS/lhfmNeUlst43isF8iywEKYLmmEiB9myatllYKQI62S0h?=
 =?us-ascii?Q?xuSDEuHIOxu4pGHKcmJe9SiLffdkh14kOTrq6ZRAu9O6QUJdFi18GyOFOa5y?=
 =?us-ascii?Q?Eeqg6/FCcrUzJTJX/qH1dBd3YfRWyJXfjFwurwN9mJaX4Wfgq6jqvdmI9dNO?=
 =?us-ascii?Q?EkN8kVNemnwGc2Mpr6mxJjjt6YogICJl3QP5MInrZGgbwEJQeptj/ZN4x1zn?=
 =?us-ascii?Q?3bo/O37SUCCj5ku0xCXUq800UzaeMt0SCJjFVquYyX1pehC5yDyytd8jTyAH?=
 =?us-ascii?Q?NRatXdK6JAWsf/aeUzu3SzzR5GIRgIog/IMHxIQVHgR0F+nQVM1bthJNEIg/?=
 =?us-ascii?Q?8F+5MiV/AJsPaAv+6waGqunb9BNAFG/bPvmA3W5YLzMs58gpWcvGLciwEzxw?=
 =?us-ascii?Q?qDvWA0JN6iN/22DeGhlDx1189w1gh3R0TMl/0XDVW34PWno7eKUZWJKTf63a?=
 =?us-ascii?Q?werD6Bpufyi0+ooLVFTZCsNIBdLtkQHapJ7IuwOnjtLpij9ZynPDH7MEdqij?=
 =?us-ascii?Q?/IgT/i3ozNA34yAbHysuzuF1t2vB59BIBj2Uaf6S?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8965.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e455c33-8e53-4241-cf21-08ddf04fc267
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2025 09:52:31.0840 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V/sRDTmSFpyZ2FIpHEw1odqEsyJ+M58NQP5E9eA7OwiPPl7WPSXFgPdJguZhcHbf2x8NXkUFCroaDCXD+WIQoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR11MB8193
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

Hi Bruce,

Sorry for the late reply.

The purpose of this patch is to prevent issues introduced after values are =
initialized to zero, such as the failure to create a second rule on 82599.

I understand and agree with your concern. I didn't take models other than E=
610 and 82599 into account, so this patch will be dropped.

Thanks for pointing this out.

Best regards,
Yuan

> -----Original Message-----
> From: Richardson, Bruce <bruce.richardson@intel.com>
> Sent: Monday, August 11, 2025 8:31 PM
> To: Wang, YuanX <yuanx.wang@intel.com>
> Cc: Burakov, Anatoly <anatoly.burakov@intel.com>; Medvedkin, Vladimir
> <vladimir.medvedkin@intel.com>; dev@dpdk.org; stable@dpdk.org
> Subject: Re: [PATCH] net/ixgbe: fix port mask default value on E610
>=20
> On Fri, Jul 18, 2025 at 05:09:07PM +0800, Yuan Wang wrote:
> > Modification of default values should be limited to E610, as 82599
> > handles raw IP well.
> >
>=20
> Hi,
>=20
> I think you could do with clarifying the issue here. The patch title seem=
s to
> imply that there is an issue with the E610, but in fact the code change i=
s for all
> NICs except E610. What is the observed behaviour on an X550 or an
> 82599 NIC vs what is desired? Is setting the default masks to zero not ok=
?
>=20
> Thanks,
> /Bruce
>=20
> > Fixes: c81daae2383a (net/ixgbe: fix port mask default value in filter)
> > Cc: stable@dpdk.org
> >
> > Signed-off-by: Yuan Wang <yuanx.wang@intel.com>
> > ---
> >  drivers/net/intel/ixgbe/ixgbe_flow.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/net/intel/ixgbe/ixgbe_flow.c
> > b/drivers/net/intel/ixgbe/ixgbe_flow.c
> > index 1bf0af330f..71b11f9e70 100644
> > --- a/drivers/net/intel/ixgbe/ixgbe_flow.c
> > +++ b/drivers/net/intel/ixgbe/ixgbe_flow.c
> > @@ -1644,8 +1644,10 @@ ixgbe_parse_fdir_filter_normal(struct
> rte_eth_dev *dev,
> >  	memset(&rule->mask, 0xFF, sizeof(struct ixgbe_hw_fdir_mask));
> >  	rule->mask.vlan_tci_mask =3D 0;
> >  	rule->mask.flex_bytes_mask =3D 0;
> > -	rule->mask.dst_port_mask =3D 0;
> > -	rule->mask.src_port_mask =3D 0;
> > +	if (hw->mac.type =3D=3D ixgbe_mac_E610) {
> > +		rule->mask.dst_port_mask =3D 0;
> > +		rule->mask.src_port_mask =3D 0;
> > +	}
> >
> >  	/**
> >  	 * The first not void item should be
> > --
> > 2.47.1
> >
