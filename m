Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9180C9833F
	for <dpdk-dev@archiver.kernel.org>; Mon, 28 Sep 2026 10:01:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1406C40269;
	Mon, 28 Sep 2026 12:01:11 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by mails.dpdk.org (Postfix) with ESMTP id F2A8540041
 for <dev@dpdk.org>; Mon, 28 Sep 2026 12:01:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790589669; x=1822125669;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=/0eO7WKBRyhbtEJMN1wefmo4lOZ9rw+ccBIbgmqEjfk=;
 b=E47sgEKiijlRXXDyL6gElruPPbiehdTT51pWcwC+1+W5IehzTN5Dz85Q
 5Csnn2Xzxndn0Y5X09ZfUocaHhsD8WxlhBJVZsRdT/m1eab9Z6++nPYb4
 x+4EO6qcSOf8mzySyKTz+g4L8kJAikjc25kgJkz2tFCAXr3QpBlAhVkDA
 cYR4pDAkJHdnSnRcK9qQ8198ufWHeM4gyEnh50BProQflfKPw8ksOt8pV
 39G+iG5nYjyRqcBBmmchwPqxsqKWPh/IMxaO4KjtDNKqQ4FyymkuTZKl2
 l4vgUFcZmVmKnigy+JZH82jHeFXAO3ZVAu33Txti1Fjuvs7SU/k0c8teX A==;
X-CSE-ConnectionGUID: jDd9pQMOSKi78d0C4nkJiw==
X-CSE-MsgGUID: u0bRA7r6RnSxAppdzaxaQw==
X-IronPort-AV: E=McAfee;i="6800,10657,11918"; a="90412108"
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; d="scan'208";a="90412108"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Sep 2026 03:00:48 -0700
X-CSE-ConnectionGUID: gQ2Reyq5TRWlCpeV+TQ/aQ==
X-CSE-MsgGUID: 2S+UYrY8SlGeKi+BOvy2vw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; d="scan'208";a="275136743"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Sep 2026 03:00:48 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 28 Sep 2026 03:00:47 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Mon, 28 Sep 2026 03:00:47 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.16) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 28 Sep 2026 03:00:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m77+3Jz1HqsttzzcfqGmD+pF6eBHxrIQuM13zNgo0tw7zVZKow9L5E9jd/QIKQkB9nX62hSggRwMT9w8mjfYe3BIAO39KPRP41Tw1A1xu1UHkdOSPoEGAdQ3skV1bPjkp70LPx3AeTPFbR8iW9YsXCdL9YHZeaH/lC4UioQyxcv/bhSl8VrWWRxM2oonu5W+2flZexXRDZD/wQujHduc8Acd0ut5I8ZZ6AhNL+mhc+3ETVgVJ5YM0XTpeTxbH2rYV/ncFpjmaLTOCPf0V63t1cuqo5pktWre5yDkX/BPNfCyiy/DNiTibLPz6hgx7/9TLPs8WZu82UAn0nfX+VqO0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pDH8ySEK4WeRFFHGoooBNLTK4rkmm7sFXzJaklKxnqI=;
 b=agM3wShn9wavUrfzzdh5O1BE3XUfHUow2dij3Inm56N+u2cEyHFJPvysGj9tE9mImhvh0svFYMnDtJq1esOVlyLBSN7A/3P+BxEQ+D0kmS/P6QjBlog4WWYMfw/LyoiFgsbLRnt4yTarePFpaNjP/8vcrYzAB1Vr4bV3x4B4f/cebz6OqDWSsop2WeSnYbyCAu/9nJIig321eVJ+cTtMZBq4HjVRcwdwtOsE5F0HC4ZYNdWgE/9r6BVv/OqJDYgi9KWZUpH1iCMyXdgwe1UoQppvcftCYs2MZ6CFtUnRGmYJJJB3qrrC5wflCkDfWvpRJUaUTeMuaYDYM87LJsLk3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by DS6PR11MB733940.namprd11.prod.outlook.com (2603:10b6:8:46a::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Mon, 28 Sep
 2026 10:00:46 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0451.014; Mon, 28 Sep 2026
 10:00:46 +0000
Date: Mon, 28 Sep 2026 11:00:41 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: "Medvedkin, Vladimir" <vladimir.medvedkin@intel.com>
CC: <dev@dpdk.org>, <anatoly.burakov@intel.com>
Subject: Re: [PATCH v3] net/ice: support link flow control
Message-ID: <aro6yK-xb8sU5qK9@bricha3-mobl1.ger.corp.intel.com>
References: <20260910112524.1547156-1-vladimir.medvedkin@intel.com>
 <20260922182333.2288005-1-vladimir.medvedkin@intel.com>
 <araM_ipV6MgpPqH8@bricha3-mobl1.ger.corp.intel.com>
 <dcd90574-9a30-4dcb-9fd6-bfd13916fbfe@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <dcd90574-9a30-4dcb-9fd6-bfd13916fbfe@intel.com>
X-ClientProxiedBy: DU2PR04CA0023.eurprd04.prod.outlook.com
 (2603:10a6:10:3b::28) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|DS6PR11MB733940:EE_
X-MS-Office365-Filtering-Correlation-Id: 51842f03-1937-408f-1be4-08df1d475d54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|10067099003|11063799006|56012099006|6133799003|18002099003|22082099003|4143699003;
X-Microsoft-Antispam-Message-Info: VxkrQuUez23SGDClpKajO2Zc8GsajvCICwCPSkyFEcPkRke1IIB5BkHl2Xk6mqrxNSTTzJs9jp/G1rOyI2BLcyOLmmgGPjY0sncDKoy5N0z09XAAhnzqyNxkDEm6fXa/PS9CMSyI6oYaXSLVUrQ1zSw/4kF8BvVka4yYsRayzpr1O9waUboVGtKaTfjHk7OnLmzkCHfjqN3WaBzwyrWPqvl9FZ0Qmnh2JTYpYtVzAPFb7fy2hveXmvx2Xtpd9+4OlLEm5HpitGldTHjF53qprwp+Oo9rtAWedTjOXs6O2l43aKHQt8apj99SxrMkIWuhtQDBCR1YAtq4RDhKay8MZ8wQRHIsymjKZ+XHA1ZoGyV03nHG5d9TECeG7reQh5lMk0JPQRTAZhT9LMq2MZcokSvt9bKY4gRKq9PDrOMwLJbm5wom6nY3vybEv2+laMiKRUr+aIz6es8sK2TO9BT9yDRP3yCMXzubx4bwP8pZiAJnyJjdbywMNGnxnFzhXTVek8JPxfwiP3uOtatkc5cQQgsOStvF7MatrVe/D0Cd/LOSTWius3s+zIVos9xCFMh+dgi0AzxyOjjhnwumt1OKa/Rm5KV0P7ucGHOGeetpV6TP1IixJ9FXvm3Toze07MJahgQ05/6oG9mImOP6ymTmS35WW+ST4rmXEk32IDc+pAM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(10067099003)(11063799006)(56012099006)(6133799003)(18002099003)(22082099003)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7MRSQUwtbmBs2TWEod+GyTkKzjanZNkiQiaQCzIl1vbfnB+AFI6r9waDgrOk?=
 =?us-ascii?Q?qlwAuHxO2ehOFhSDQElH/+WtUszKnkl413wa3o/iCgkXulsfhFHJ686iHR5l?=
 =?us-ascii?Q?RSvnSjjulZvoCbx2WnghmIVMs9vEp4BDtDbf4gsosljTrX8MrG3UTQsldSta?=
 =?us-ascii?Q?b+IoNvvf/XHifPivPhORobZZ5ux9oYIPdkOO9EhOtJZ0b4n6/+kOSSy5s6Oz?=
 =?us-ascii?Q?xY5ICho73PicDjMcY/CcUwqbTJMBmw2m6u76pCUgJ340WRWBs75ma207UPGL?=
 =?us-ascii?Q?hXyPPr19U7FYi1w3IuIVKWZWRDfWDVikeGL38qaW1Qg8mpCzb4VDN1mv0rml?=
 =?us-ascii?Q?94V7Eb6i7moiC8HgUnrUB/h1zl4Bh8rUI3rAgr1GzHJWh+1tNM9Mx8HCG7Fj?=
 =?us-ascii?Q?9eQklaq+21HYmiWgu1yD1rAgURurgZQmgstI5EXHTes3R7sLkpyqPCO+pvub?=
 =?us-ascii?Q?G9cOvl/s458Qt98rrRKOZsEApcm2Xe36wD87goHCXovebGcioJuPdJqJklR2?=
 =?us-ascii?Q?bAuah9FELNRbj/DPMUlmE8nMfLzwjwaAciEnDWJr7yYVH1NAVBY0/WqKvM+P?=
 =?us-ascii?Q?TWRaYAFmctfHraqC5tU8JL/ruQYTDKAUU3cT0vd/rhf+nQdOzj8RrNgrlJ35?=
 =?us-ascii?Q?wtUybMsi09JJAtYNxpsDkTlgjniEH+tpMgQS2MrDEmbvVak+9g1DJh1lju3H?=
 =?us-ascii?Q?/ooi9toJrPhyho0Go40L6gV4d4WFdj/z256YEGy3NM0qJYtp26CJoA6Eln8Q?=
 =?us-ascii?Q?3+QUtfTjx1vDH1rHTZU/nCnn4rZ/0rQbNc7vit3s4ZF6cDCQyXLigzrKXip4?=
 =?us-ascii?Q?B7rRQh7ZGmhuAjjfYGmk541eXgrm1MIIq86ag4N1GUkLkKCREwEzUIa7Qv9l?=
 =?us-ascii?Q?RwRvz+L2pW9tuxyRIbeNrhA/cHOSC16d/OOAtE83LDSH7Y73riNdlGrpRL9V?=
 =?us-ascii?Q?n2F1Jv7RPz+CxtRYAtavWqyT71/h9k5/bmGOxUgu+AO/vg0LpK5sO+2IbBOH?=
 =?us-ascii?Q?vTFIy/DF8uzSSE9403p2qcshh1GRomB3tWO9Jbov8NUHqM7TjIY9bT3Xthay?=
 =?us-ascii?Q?8K9mFHl+9m0EnDzGX/4G5jOdT67h/9JHE+/vVb9S7Dcayt/nAp9HJoZ8+5mK?=
 =?us-ascii?Q?o/q6vQsxCaASR1JeKNfzMOe4qnGdVlgCqqiBVw7+ypVCuJOJ2PjL6KDAqK9H?=
 =?us-ascii?Q?u5PEdz6ghBDQbuK0SuQbQ6GAN5I0X+V5ulljnwcobg06ip1mvsL/rbpXcLBw?=
 =?us-ascii?Q?U3dchK1GgnIPag/rV+EtTGIWfB0mG1NwboD13SCZgbEP5pUZtzvt+m0kiJZQ?=
 =?us-ascii?Q?Tvj3UcH3M4IxBa+SVj/Lbt98iOAbvfqQ6GoG5Iv6/w0A/ggB0COWH4JJ1VQj?=
 =?us-ascii?Q?NGHDXZGkYUeITBMQg2WEJwkfJvP9jhufO10psMcxBAwajf7eKya9pd4LfKGH?=
 =?us-ascii?Q?/kmzoBI5R0Xxdq4Zt9skrofoUTffxCj31cmW5e/s66vREPF2qjkmP/bTXwmy?=
 =?us-ascii?Q?BEtEqaBWWAspwNCJxGtTkVcEx/NdHecEslfQwnmWz6NSv6qqjt+U2sKeCBOW?=
 =?us-ascii?Q?l3/sRE+2JqKdGIso2grXZumaSvDzGQZ5qWLjt7JvQT5OLmNtjZFp56wWwyZO?=
 =?us-ascii?Q?3kNIL/MVkSPeTBOUr/waVxNXWatovfkrkYpMgzNICo3oKfHNTJJh7pZK13y5?=
 =?us-ascii?Q?G4jm8sei7MqugedbdctCnNK26tB0rK/IAEoaLvRuMT/h8P3B0D7LW1WqvfgK?=
 =?us-ascii?Q?K2VCh+CX164ucBsY9QEVj18rfuXYRjI=3D?=
X-Exchange-RoutingPolicyChecked: apS/mrQwaiiRLoGKq6ZdjizghYcRj+FTjUTHik+oJHCb5dfU1JA3HxklXbhYmPF69IfG1sxaWACuhGotr2/COQK+XCmYg3zCJ4p7AaLLUdHXk+b7oKtqDEnM6/zQLTZUKzTguRJlotXcCbwZYsUGERXPzIGZHIk8Iy/XllEGTXvIeZvkl9pO8T2s8XivJo1pOCmFCwcW7EIgBfUVTTZmwYWPM1hnengenV707VB9H/F8xdEpJXv+KM6NhtM8cBYX68+kMQW69gmm0dqyMns1EcCa6pm4rbskjWIYtOGQO96hQdGYzL8lB1V5n2D+VMnt00Qc0QFsUt0w9MpTH4WGvw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 51842f03-1937-408f-1be4-08df1d475d54
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 10:00:45.7115 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dlSHduPoxxaEkPNf0XZtf709OH4jWQ1hIltTE/ntoE8xV/luiCH1bECgleRLBs595KnqzeKR0LveDrPpTUZyxtOs9CgJqh1AqsGsje3MXq8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS6PR11MB733940
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

On Fri, Sep 25, 2026 at 04:40:39PM +0100, Medvedkin, Vladimir wrote:
> Hi Bruce,
> 
> On 9/25/2026 4:02 PM, Bruce Richardson wrote:
> > On Tue, Sep 22, 2026 at 06:23:33PM +0000, Vladimir Medvedkin wrote:
> > > Add get and set operations for IEEE 802.3x link flow control.
> > > Link pause is advertised only when requested, retained across port
> > > stop/start and re-armed on link-up. The watermark and pause quanta
> > > programming is shared with priority flow control.
> > > 
> > > Signed-off-by: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
> > > ---
> > > v3:
> > > - Address Bruce's comments.
> > > - Add documentation.
> > > - Retain LFC configuration across port stop/start.
> > > - Fix various issues.
> > > 
> > >   doc/guides/nics/features/ice.ini       |   1 +
> > >   doc/guides/nics/ice.rst                |  50 +++++
> > >   doc/guides/rel_notes/release_26_11.rst |   4 +
> > >   drivers/net/intel/ice/ice_ethdev.c     | 296 +++++++++++++++++++++----
> > >   drivers/net/intel/ice/ice_ethdev.h     |   1 +
> > >   5 files changed, 310 insertions(+), 42 deletions(-)
> > > 
> > Acked-by: Bruce Richardson <bruce.richardson@intel.com>
> > 
Applied to dpdk-next-net-intel.

Thanks,
/Bruce
