Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B58A606D83C
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Nov 2026 17:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=N0RcXXLX
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CD6A5402E3;
	Mon,  2 Nov 2026 18:27:54 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTPS id C330B4028D
 for <dev@dpdk.org>; Mon,  2 Nov 2026 18:27:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793640473; x=1825176473;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=4WWOdk7ynM1HQsQAQP6dRAXeohbDNz/k2K8U55ZrasQ=;
 b=N0RcXXLXa36he2aawc3UEFjeFc8F2jlFjoN1Q1w4pOA17IUqqtLYtxup
 unOpdvBHfWLHRif901BHJkpBK0ogFW6Sim4KXxDyV/y0TizdEeUNlf6s2
 jO7cl6M3EQyX6L6RZnfPbZZYDy3XbK4XWEae4fjaFwmmnsvagMPiOD3OZ
 yJeL483dfdWeTbxeHzz//RgyZRBgvQcUKTZ6DBbMdCs9/dSCXR8DxK202
 s7V5xLZAAD64DgQb17Q7ZFC2c/89B2y3r0m5H6zdBWQ0dqKPZrsmZENa7
 PQzOvNMZbt2D6kdzy12B5G7du1ICe+8KCwROqsS6oYPUqYVnsuEbSsOx9 w==;
X-CSE-ConnectionGUID: 1SdLjz55TomrznEio2iSOg==
X-CSE-MsgGUID: r/AWBbvqQ+qg5RglH7zTmA==
X-IronPort-AV: E=McAfee;i="6800,10657,11954"; a="2222951"
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="2222951"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Nov 2026 09:27:51 -0800
X-CSE-ConnectionGUID: u5TUahHDRhiV/0MGd5YEoA==
X-CSE-MsgGUID: ig6+4vC2QoaFN/J7ca9d3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="6513981"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Nov 2026 09:27:51 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 2 Nov 2026 09:27:50 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Mon, 2 Nov 2026 09:27:50 -0800
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.33) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 2 Nov 2026 09:27:50 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gR3a0xagK4g/FXl/xNeiSNVgojVrLbBS6sp44qbodmuKTlYIfZ8X4sDNP+/G/35v8l4nIQxq3OOgBQ5Do1ZHwRUJNhKh/g4I2xwu483m5ArxCb2UYAMbdIUcK2iA3RRyLm06M3TC4iAZoWAXNcYxIhslQz0MRcwy5SmGO42/UhS1HOT17CEawb9fxsMhkIaGGVHW/1nC1YyB9Ft4F7NMGvkmVFSt8KSmk/uxV1RTPsD1uIxc0NtGI34QBTadx4g0VA2U1OQKCpv7Ai9NFi+iW2A0j/Yrx/8txuMfCRZOA0/9uOxVbACKfMMH8io+0EzSfNI9H0lai3JKCX+/b+ncAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AePbywJkxI/NnNWiXlO1fV0QqbzlW+OBIaQMoDtQNYk=;
 b=fmLmB0elQE+ZQAUv3N5Fe/MbZin3Qq1rsMzFs6QE8ydRfwU2i+0Dknnoxw0yBnYgfB30Nri/MaPmCaDaHPFn4+ZlhoeDupngRMbP9ts+VVgL8vf/v1BAicQCoqG2LaKLq7QcqPMR+lFxUwfXAyU9+GAhMBH617CXBcMsZlYI5T5tnzaD/Df9Gb9esd1jdcsF/cYxvVEz8qcvGlpFfmGqXpqVBhz0jGMQ9tRddTFtO8AyDCeUfjvGTuGK4R74gofUIlLKR4q+AnRam3aAltiYAJJrwzVHjVKXMrlmHfBWEQfEm5EYhWzbnFKFzksgd8kqkLLGIKPU5wT25BVS+S4BwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by SJ1PR11MB6130.namprd11.prod.outlook.com (2603:10b6:a03:45f::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 17:27:48 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0569.011; Mon, 2 Nov 2026
 17:27:48 +0000
Date: Mon, 2 Nov 2026 17:27:43 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: "Loftus, Ciara" <ciara.loftus@intel.com>, dev <dev@dpdk.org>, "Burakov,
 Anatoly" <anatoly.burakov@intel.com>
Subject: Re: [PATCH] net/ice: add explicit control of link auto-negotiation
Message-ID: <aujIDqccaREkWHG_@bricha3-mobl1.ger.corp.intel.com>
References: <20261030132616.2066712-1-bruce.richardson@intel.com>
 <IA4PR11MB927804496D3ED9C0A512C97F8E6A2@IA4PR11MB9278.namprd11.prod.outlook.com>
 <auiuHAy8DjGUbaXm@bricha3-mobl1.ger.corp.intel.com>
 <CAOaVG15Ft8dr43T+NOoiLLQOa+4HNsg+SJmAJj08+uZUPzq70A@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAOaVG15Ft8dr43T+NOoiLLQOa+4HNsg+SJmAJj08+uZUPzq70A@mail.gmail.com>
X-ClientProxiedBy: DUZPR01CA0350.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b8::22) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|SJ1PR11MB6130:EE_
X-MS-Office365-Filtering-Correlation-Id: 53551f5b-e4c5-4504-9c4c-08df39069d27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|6133799003|10067099003|18002099003|22082099003|261102123227099003|56012099006|4143699003|261021130227099003|261026121527099003|261022115727099003|261021135927099003|11063799006|261026130827099003|261022105027099003|261022113327099003|261022075727099003|261026140227099003|261009223027099003|261028144727099003|261021123027099003|261021121427099003;
X-Microsoft-Antispam-Message-Info: 6AJikhZ/Y+9XXESKcbfoWC5Hsa7Hjf4HVVB7eNdcE7hpl4F4rQRLiYHxTmnbdOWZIJFwPy+3M5FnnfQ+8Plb/YbqiSlX1naiIKusRj13F5hyLi7v6V7eBOJhGrD3TZPayFjYCpdqhoi4ez/wbTG6qCp4hPLMaMCObVPHrU+zhGF8XWS7MI6Um/c9O3zcYojfF8GaqA/EzyAtt0kmyaKyGRiuuOb+bzwI7HSAnP8SrJlskABGdUo33mby9G0ufQkQjSbZYoJEZ5B0SBuIvqkVWfG21dsXJXIPZgdaM4t1IqC95KJ8wM99+25EzAXJdS6dQhG7XbTUZBaJA8xsOgFJ2njUvAew1Tzh85nVokvrkZVUdJhdr46l6vJFaNFq6QvTMqFIcwgG4YPN1/Qz1YMWWdblfLbwtY9x2H1HB5XIKGE/CBn+fg637bMfW44rAm4N2eyw81fFaW8Ex/aQcrrjfrKLx4yxuKnv4uEKjR1bdyjSeeaCU/d671PdM8mEw9nDLH+znhQlN9JvT95XSot6XRuy5SPBTFoz+v7FUJLAojC5dkJfDyccYsuDVGS+pYtXEMvtmYxWQWpolsXGcNORmF12ArcFH/6krU87PSDlijFivkril7TnQCfpafqXwy2GtSEZJI5PWxI0mw6y4nAKRfg1Mz/YpQDsCoCUE8cmhb8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(6133799003)(10067099003)(18002099003)(22082099003)(261102123227099003)(56012099006)(4143699003)(261021130227099003)(261026121527099003)(261022115727099003)(261021135927099003)(11063799006)(261026130827099003)(261022105027099003)(261022113327099003)(261022075727099003)(261026140227099003)(261009223027099003)(261028144727099003)(261021123027099003)(261021121427099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?D2qGKZsJfDXZ2a3ShdgCEP+n3I3GGhottTDcBbg/KeC40EYlODCk8LKPXTSs?=
 =?us-ascii?Q?kyMTxC8LzwZuOVJDJh0KL/5z08EHrqxtcaUjoV7UvdOfXdCIb3C/5VgEkMnf?=
 =?us-ascii?Q?60ywIkd95/RAMhQna4KCwU1XKHP0s34g4+WvvRAHCWwL5DYv3cK4MEejexlo?=
 =?us-ascii?Q?stqvb2hc78XYMCnRJgC16culqMe1TxEFFaSZSR0ZGnJgAUcq1dJL9IUG+7fm?=
 =?us-ascii?Q?/M1roDO+2S10Ru6l9372Eg1H92vi03rKXQ+2uVCJUNBnskbQFnkpshNwBl24?=
 =?us-ascii?Q?SgwykmjdOJFEAKgoOEt0YaHZqzVY0XsYST1r45l4NP1NtIQaCt+5Kut0Rxf0?=
 =?us-ascii?Q?1JahfTr0qWVDGCRV37Q1iG4XfsHJdQfPPToXyRzuXZEVWoZpBY4JKeVPiU5V?=
 =?us-ascii?Q?DwL72Ww0/w91Gdc15kdWMvrmxK3c/It/rPYTCHD0Ak4TjgatKL9eEoEDyGMa?=
 =?us-ascii?Q?uzWl6l/HumBnUwGk0XHifB62fR70eay+Nwg4CH9hEsNBolbFmjehvEz6deRF?=
 =?us-ascii?Q?HRhVW9yB0CVvK+nubwvWMe19e1Ago1iqsjBMVPALa7dnTmOZ4EXbjGG7cYvK?=
 =?us-ascii?Q?HpJHnNEDnMjCZVUWkhPouYW4FUy2EADUO2fHnXjFiI8DFS04BKFxIEZ2v+7M?=
 =?us-ascii?Q?Zvl0aCudQjmI/uJSjsHfaJEsbVNZ/iC4/L1fIq/NEAco0caZg+W7BA5HUzZP?=
 =?us-ascii?Q?CI1iwmhgnL3TSkkbG9xu6H8m+3sNbw9wS4SZOxe9zaAVgCtykPzmKwgQNZbp?=
 =?us-ascii?Q?dNMxcUxXidXDADM4SY1dygIuI9fMZ7t7sqLleG3wxMzd4ZKsLjpUB3LkVDEt?=
 =?us-ascii?Q?Rk7wukj2XPTirRaXf87nUq8VuGyf0GhGFhN25b7QxE+3R6m3zb08QEn4He9u?=
 =?us-ascii?Q?iTEjy7ohPjmYLsl+FiJz1vh21gV9YMTpDqjkHRB+oecUmaGpmRNTpZC2HQiQ?=
 =?us-ascii?Q?dTi60xS6tooFOohu3qiTqfcXX4gqgUdFRqUvD28LFCg+eBNsSx0cWmpsEHDg?=
 =?us-ascii?Q?vJv4gsGV8M7c7d3e2EMdjVfMGA2AaDZ6CwBmr4+LA+QnDLneeTJS5imG2rU8?=
 =?us-ascii?Q?6t3IJ6Sp+u3GKQ0BoT8PPuAz+/ngbbHwAqJQugcR/OrH393+T94wo1oqoD3y?=
 =?us-ascii?Q?CVN4C05LN0oFSvGDAxtOlQfl++cl2DIkR7SBqtRtCr/r3B0HXckxlpFYfe1V?=
 =?us-ascii?Q?+V6FtRcSmoXXyaInsHZ29a+yWDW1hU2UutZe3SL2FKVU3Aeyb+zOoCIAzHJl?=
 =?us-ascii?Q?7bJUBHu4pAItotrkEbp3ZVa6O+1czcuYy16FJmlXp84xj2uZmW7kftWjOoe8?=
 =?us-ascii?Q?zlqKaL55AQRI+M+Zz66iqFpON7UA2g+XOhPstkjT0+tvpkoSyyyWesi8dOMz?=
 =?us-ascii?Q?eIr7v9dr9vuflbdybCZsGoiUucSyM0u/OvS1wwTnh+9HLO0/P4xOcUokRUbC?=
 =?us-ascii?Q?SrFTgthQu3rmQ+p9V+CgEw/BWGi207lhB3SMhNj6Nl1km3Ks+Att+uZMN8Lw?=
 =?us-ascii?Q?yFWp/miRsv0+xXWNMJ1KJm26EIwxpyRiKmbJhbVaqSI85jUq3i/4s4s0/4v+?=
 =?us-ascii?Q?4pRiX7I+ppOC/IMe+J032gbWSFQkkUaP+zYmN7PuFmdE/x0RNxS2eZ+uFM8L?=
 =?us-ascii?Q?6qpEDUNY3c5jPdyf9HzQeHwnFl8IhG6sngnFQXDn9puquH7QdiDc6xwiZPtS?=
 =?us-ascii?Q?kKe+mE7PsAPAG5dSqcHLFRgM6z3f0/kIfjRsse7BEWwbFFMfQVmy11N0RFE8?=
 =?us-ascii?Q?A1ifEBK/H3a5i0rSkJok51KH5uYfJ3A=3D?=
X-Exchange-RoutingPolicyChecked: 0SVchXb/jAqdxMvFNH8mVxaYyeVayda+xOCYl+i1ssNE8CQxyC8FyKgdb5pXvKHqh6iGcfvhrJ6ZC9yCvD029Ffa/ZzjPGSkgIwIpOo/g8f0dD7+Jxomb3o/ivtVXpODBBFsAjt83U/vVmym3xWQb3Usy31cRHXtLfh5GhctN+Ww2Sy4iKe6WYccZNh4la3fKK3ol9kXbraN+U4vYab2S2y9l2Busohi3ZFNHOadcSNQWYp38YLbqyeCWCaMq8Ho+DNUuKM4kfUr0MJOCt6fabSn5MleexOFQb4kau/nTRldt8+NfY3yyMuKiQrOWwhlnPpnRRPySAmvJFL2/eRixA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 53551f5b-e4c5-4504-9c4c-08df39069d27
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 17:27:48.1204 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SRv7g1pCari1fOYy2nh/lywxXW6v30z7vDZ32h1+/eOcNUwOcMgHN6WVsfmaMLbmK8vMl8ivFw5oClrf7ER3nRxEP4Oam4J/dljC5xPvpIQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6130
X-OriginatorOrg: intel.com
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 02, 2026 at 05:26:24PM +0100, Stephen Hemminger wrote:
>    why is auto negotiation disable a devarg rather than extending relevant
>    part of ethdev? my opinion is every time a devarg like this gets added
>    it means the ethdev abstraction is the real issue
> 
Yes, it could well be.

Digging more into the ethdev API and drivers, it may just be that the
limitation is simply one of documentation clarity and testpmd's use of the
APIS.

Specifically, what does it mean to specify the RTE_ETH_LINK_SPEED_FIXED
flag, and what does it mean to specify a particular speed without the flag
being given. From what I see we have 3 options:

1. autonegotiate speed setting, e.g. choose highest supported of 10G, 2.5G
   or 1G for a given 10G NIC
2. allow only one particular speed but leave negotiation still enabled, e.g.
   set speed to 1G but leave AN37 enabled. This allows setting to 1G when
   other side has auto-negotiation enabled
3. set to a single speed and disable negotiation, e.g. set 1G fixed with
   AN37 disabled. This would be for compatibility with links not supporting
   negotiation, or where both sides explicitly set the speed.

Setting #1 is default and well understood. However, the difference between
settings #2 and #3 doesn't seem to be called out anywhere explicitly in our
docs for ethdev. I would imagine that #2 is where we specify a given link
speed (or maybe speeds), but without RTE_LINK_SPEED_FIXED set in the bitmap.
That would mean that #3 would be a single speed setting passed and
RTE_LINK_SPEED_FIXED set.

Unfortunately, though, testpmd always sets the FIXED flag when we specify a
link speed, meaning that scenarios #2 and #3 are indistinguishable. Asking
AI to do a quick scan of the drivers indicates that some will leave
negotiation on with a fixed speed, others keep it off. Some ignore the
fixed flag and never check for it, and some just don't support disabling
autonegotiation completely.

Would a good solution be to extend the testpmd command to allow the FIXED
flag setting to be configurable rather than assumed as part of the speed
setting? That would at least clarify the behaviour and allow testing the
various options

/Bruce
