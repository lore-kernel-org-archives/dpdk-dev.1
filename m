Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5588E67497
	for <dpdk-dev@archiver.kernel.org>; Mon, 22 Dec 2025 17:44:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EC00F40265;
	Mon, 22 Dec 2025 18:44:00 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id 9BB8140264;
 Mon, 22 Dec 2025 18:43:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1766425439; x=1797961439;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=SQ1kD+fGMlBhxM7F72snZH2yJNaH5DhRb9lc4aLvFHM=;
 b=aDfTrqTUKnlZb0vifJ36A0qRF1V7rpvQtsy+hiujy4QqdM76ZR7yni+W
 AV6JAL3BWMWt2kD3vK9j8ATagNLfIu7YYYADGkWYygsaT0zi9ZGCf+tgV
 pWwCL7iYblYOeIB4xxT3AYDb0nXQkPxmchbiE4VJV21Ma3M4Sulm+LKQI
 pyUFIGNFj6Akf9bK6f/3XS07QHBHLVxWExf9cHD+g24LXMjBS5dRdj2/g
 fUN1r5WWg3D8j74rGPqnvvwQNOJr4g+G1QVXpqFK2SNzODX/D71/ET6cY
 a8Fz4yt73JWAmDtDoKiruWA5dFbprv5v5eKVCv5+Gf4Zr0xOncQ073irI Q==;
X-CSE-ConnectionGUID: ZIegnO+bT0CpN4dG2TYK4Q==
X-CSE-MsgGUID: YgwxfvNNRzy2hGZmj38jLg==
X-IronPort-AV: E=McAfee;i="6800,10657,11650"; a="79736202"
X-IronPort-AV: E=Sophos;i="6.21,168,1763452800"; d="scan'208";a="79736202"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Dec 2025 09:43:56 -0800
X-CSE-ConnectionGUID: 1fGOnjNxSvmFGuzRMGMDhw==
X-CSE-MsgGUID: JMQk3e8nRnmlj7WNn8aSTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,168,1763452800"; d="scan'208";a="199491774"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Dec 2025 09:43:56 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 22 Dec 2025 09:43:55 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Mon, 22 Dec 2025 09:43:55 -0800
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.37)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 22 Dec 2025 09:43:54 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dHnfBJK/lStx3U4RKODOewGqgxabwaQ+G7/9EBcgrbhQvlPEne/wzb4raBGaBEXAFQUV6vaMZYFteXMCHAXkrBQe4Cyh+gXoWecwdKeekZlBDAowLZoVosP1q7TXMa3nxqd3VbIAiuR06XOc+lGY1nxjm1fgpReoowTspKkywbK9O5W/76JOSKEOqysPr/s4Jl/DN06kbGlb1Wxwh5WdA0FLgeRSmtPPnrIAsGy2kGmdtrjWKVtG6bwSHsQWSL66kMagGjphSnIq6AoIHusZwEK8R4azzDFj5nD9X+Cim3QhMlVDUMMNrRRkhc6IqX/n50LVBxD28T+i++Vweagvxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sn8jeII1EDHM2CgFvEH2Fscx9T+pRP4G647aWdpQeh0=;
 b=zMiL7oAWAb/YInsEcFKMsAl84fJ8q1TPhxD53zWZZy2j55n0uuiiCX5eKS8vJ87Gu+JTxkvl056zUatEl5O/yEFfO73bKsp2dNduKWo5r1UdJRE6uJEb4PoU/BU+/acaKEFCyn1VuuiJPaVzzi/n/njtRUYzmFCPelGQ2VFTsvwGwsufSXWB5KGwh0N13XnzfIVvgh4tji0wVHH5ExRblQGmQKKhLMzN4yME/XrtBfNiu+SV647KMsWD5/NVWUxdmqCUS8HhhqT1lBTuAAiriRhjIsmeuJnpWvfL8JCNQaBh4zvUVPTOvVZqRIP5Xm3kkwsY9eIjoPgEQqw0/irapQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by CY8PR11MB6915.namprd11.prod.outlook.com (2603:10b6:930:59::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.11; Mon, 22 Dec
 2025 17:43:48 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9434.009; Mon, 22 Dec 2025
 17:43:47 +0000
Date: Mon, 22 Dec 2025 17:43:42 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Morten =?iso-8859-1?Q?Br=F8rup?= <mb@smartsharesystems.com>
CC: Konstantin Ananyev <konstantin.ananyev@huawei.com>, <dev@dpdk.org>,
 <techboard@dpdk.org>
Subject: Re: mbuf fast-free requirements analysis
Message-ID: <aUmDTsLxNN-GOGDC@bricha3-mobl1.ger.corp.intel.com>
References: <98CBD80474FA8B44BF855DF32C47DC35F655E0@smartserver.smartshare.dk>
 <0d1645e1c83f4ec4ad676095b910845c@huawei.com>
 <98CBD80474FA8B44BF855DF32C47DC35F655E5@smartserver.smartshare.dk>
 <d290adf103244ff7be53844ee32bb6d0@huawei.com>
 <98CBD80474FA8B44BF855DF32C47DC35F65601@smartserver.smartshare.dk>
 <4ef23a6663774a119d3087fb21ede984@huawei.com>
 <98CBD80474FA8B44BF855DF32C47DC35F65608@smartserver.smartshare.dk>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F65608@smartserver.smartshare.dk>
X-ClientProxiedBy: DU6P191CA0059.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:53e::16) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|CY8PR11MB6915:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f6a3121-fe11-404d-13c6-08de4181a928
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?1w3Mlse8tZL517iR5jqKUrsSsdBR9sVVW/LCdo3P2cYvN7q6BzVLGLd1sR?=
 =?iso-8859-1?Q?NCnLN88ByIXp+7gzELDzequpx/jyHXgtDPxNgrcw5bC8c2OaWI6LxNTTd/?=
 =?iso-8859-1?Q?UjepDpyw+2czQ+RCDk/FKHP2qLJcuGyMyiwIbBVrJ22Zr9Ioc1uuA93iFS?=
 =?iso-8859-1?Q?B5v91bsfOOC5WNiDiTrVR6D5TPrLbRyXrGwv9xkQN1KIAXLDHWaaOQA/AC?=
 =?iso-8859-1?Q?g6xTbfNsYb1Ve+Oi0NIftrXwF4BL03eACaHGqV1uyZ21avFcor3+o76bwy?=
 =?iso-8859-1?Q?ZMrcAtYHLfospHkyM/2BghVDG5eCv13dS65CWZY0vIgjxJP7bb2xUsnvlK?=
 =?iso-8859-1?Q?MrF3Y3lk8W4RVZKt7uW9R54AmuvdeKSsA44CBbOhBAd1ppenKBWM47uAME?=
 =?iso-8859-1?Q?Z+s2CoGC6fSpz8d6dIZejFSdmkf0XsBMgXpIRztWlEN8YEZXwfCbxVtJOm?=
 =?iso-8859-1?Q?d4GXStloT1RQIDTD0Yvv9jYyCTsOQnT9V9r/xOlshfLHWc45Z0BElZo+s3?=
 =?iso-8859-1?Q?MTd3CAhG5hn4IWA19ePei2mqw5hqE7o937iNhfNNp8Xq9gNSKwHxUBZA7c?=
 =?iso-8859-1?Q?m1601PdOJbva2id5rINU0Uj2ZJ6p1/zrLk43rOC4rO7LZtkhh1q3z+1fZ3?=
 =?iso-8859-1?Q?7li/YHFr4G/8+ZgeTwBry59KUvopJVZn6GlgPig+BP0RlgIygfssjl2Igg?=
 =?iso-8859-1?Q?UOU5pGu7Qa23Bwys3/KQ+caannmKTlSW6FppDifEV9O1kS+WtQgBuHLONH?=
 =?iso-8859-1?Q?R15FvPHGy54z9CkRxsu9uGTu9sARjKMAd9BN/+QuAE6CCffrYySX/f0Qx1?=
 =?iso-8859-1?Q?77VUYfPmuqGDFCbq01Wis67Vksf7QMtftMu+6dklxmaPqykwASmRxBkmn+?=
 =?iso-8859-1?Q?54Ej/iFLBoqCygyeUN7T6bH7i69cejyhW+7mWYz7gpHvKcOb9Ag1jUVioq?=
 =?iso-8859-1?Q?yX0OJWQjBjTMMUaCe3+URyFuMTy++LuINUVDvHHfh6OV59QBz0unkSddz8?=
 =?iso-8859-1?Q?ziBXkzsPC40H0Hd+IuSVTkmhLi+NxtHZthmU2/i7Ni0u/hS9ZxPM1veqFD?=
 =?iso-8859-1?Q?g5J8PNpUwCNRLixIKNJ/u9/MvpBinIT39OSjhDjRJQeDgiSy/vyZRRMKnO?=
 =?iso-8859-1?Q?OaiWxd3SNnhQg2nU5eo7QyiXKEYzKZ37iFVSZk5Oq0yNj5L/lgy0QkMzVe?=
 =?iso-8859-1?Q?L6qR2bsOqdPLeJuMgnITu9CIpx4bss5UN7exrqner8o4dryXDO3qfXCpTo?=
 =?iso-8859-1?Q?whNOOS2NvGyvl/Y85acEPfaAOsIu5vaBoos3rK4JwR5q20DbY01sjAoyB9?=
 =?iso-8859-1?Q?rvqX1eTFN6ioyEZNOZOjRLKYAMiqTk/f53B44VBOCZKz2Tj/9bj8YaUYKm?=
 =?iso-8859-1?Q?z+E1rk4zr2Ttmz2eivi8nQmZR1GPOjYYNp2/6AH0khgOftanKNUkJ/Dj7f?=
 =?iso-8859-1?Q?639LfVocPee828FiaTtrLGFl/pO1s+PSaai8NJ4/P544FxWSweMw3FErSJ?=
 =?iso-8859-1?Q?XmRVk3KQjKcw/TH4uW2X5D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?LwWOpeu1j3D4sY5jALQTHxM8b3KkFTyztVmhaDAsQ63gRr3aa3AP0JjqiO?=
 =?iso-8859-1?Q?bILwDP4au+vSDJqj7yNLMYHH7KfjZcApXnMkJ8rvTf0Y97XfB/jJ1orgIT?=
 =?iso-8859-1?Q?YDEbGXrzfJw3iPVYC5Q2pyZW1IyPLOxynJUUE2AkihOmLap9k4kvrSIv4i?=
 =?iso-8859-1?Q?KxtRHiMy8qFAtz8a9mrfddyVA/QUAd7hltn2yI0k4FdNiwJuWC8rQoOsFj?=
 =?iso-8859-1?Q?QtPqngNQG/WSlbJjuctg6U0WKdxCzfBkL6YIg0qN+w94YUDhenG3ycm4Qf?=
 =?iso-8859-1?Q?uC6E3TF7loV4k8SzSzn9CMsaOwS04n3xTVdfSp1lVZGq9e1sgKIQhcj3xg?=
 =?iso-8859-1?Q?EGmhi0Krc65UGD8M7FQ2CwJZ191TBl205wAUug0T9afoJFP8Y1vHws1deh?=
 =?iso-8859-1?Q?K1Tjs7fBKKztOFpnkS8XBIhP+wd/V/7Fl+lST8i/SRfb9RDWgtnCEOhG++?=
 =?iso-8859-1?Q?84e589qfPf1KyzE9E3w57kONdrPha7cdmdK9cXvL4uxOHQ7Oy0uJ9/hVpT?=
 =?iso-8859-1?Q?uHq9y3OgCDi/JsssCwQHXgQ1J1MYT3/+Ll3yu31r73SZsgK0N1NF8bDQqR?=
 =?iso-8859-1?Q?iYLmNNdy9q64oSZ9LrhkFTLngPhJQR9rpRd0bOn5ip86hyDsRJrjAHng99?=
 =?iso-8859-1?Q?1KKXpbeTrQxxzrcmOQRlVgLolz9IrsUARJqMiUwuBe1egqlE2ToV67uYvE?=
 =?iso-8859-1?Q?L91P+VA7dWoSmUe411Dx3SN9gEYDlLk53jFb1Dbpk2mlKqwvw2w3ad/++b?=
 =?iso-8859-1?Q?VB42/FZH2G1WLdLUEioJSWXhUJSpNAwVuvlucUkQTGlZYdGqmIPDWuQ6mv?=
 =?iso-8859-1?Q?QJciJiitO4mT3WWwubiH7lkbMn0/jkejupLwSxck+S88tJUVnkMsI40nYu?=
 =?iso-8859-1?Q?C84qHS7kToszEm8jl51fqdaq7x7SOFB6Veu6M0G4U9O2kpS7oM8luqsDla?=
 =?iso-8859-1?Q?ssWvwmWjutvBVYN3zyzGoPiy/PzL8ZM1km3Cu9TahvAdy5D5faLVzyU+KY?=
 =?iso-8859-1?Q?PnR9QjpQb23AiEbrsvtn4d4xs5BY2BBhaktgTPu/RGEeMgeWKXrHRkHdyn?=
 =?iso-8859-1?Q?vv5HIVfItlAAQ71Y4MO7xwT3P58HDy/wzyC6z0/x3mm5wI8jeNg5PIBokG?=
 =?iso-8859-1?Q?FlAE8HcUZ93IDUbi9Bp0C26tOSfaVtickgi1yO06lsx/5E34VknS4Yoi9k?=
 =?iso-8859-1?Q?G79BAaWKM+JFGY6ksbZkaeODqKbKNcc38roNJaPnDHLUJcY/uhb2B4hoEU?=
 =?iso-8859-1?Q?ga/K/mGb/TYyVrk3HoRitDOkmwRleOF65HSwDFBJq+BqtlP7LNPGKxdSvj?=
 =?iso-8859-1?Q?XJZYBKsTeF4cUypVv52318MoKW/L5kxadJ/aE6DLiGZnsiGXnnLZclDx+l?=
 =?iso-8859-1?Q?p0w2oz9Lu54UcIjHbitX8KzB60uQhZUtWQkc+tGYpbSOOx78roweiDjcCs?=
 =?iso-8859-1?Q?NffYjSyma65j9FYroeBQQaq4Chy2y6mOSTOzMfH7CvKpiaj3Ed4Zdhi88r?=
 =?iso-8859-1?Q?Xe/NlwijaFV0gpMwkGTxqNvan1kzjXLz/eQIvhHW0iwmG3o/YIkC4e299t?=
 =?iso-8859-1?Q?74V/GmVLNULO6KlXEVC9q5ja1pG9Ehd7lRk/MQNtPG1HeZEiq65tCJtLPs?=
 =?iso-8859-1?Q?BoSFmOaSXoDC3WFhmdp71dNiEuoHD/AYMR8ZXeMh6cAtCX6Cu1yZX+Xs4o?=
 =?iso-8859-1?Q?3kLlBzbRmrx9y7JcyEcR0/gkuD7dah6zZsO/ihig3xO0Mnr9RtaLpp7V9v?=
 =?iso-8859-1?Q?weWlphl0zNbabcKdP7d+xBoRFd6rVh0zTeVmkKVAKvkxNAPWBx8x3+CWJP?=
 =?iso-8859-1?Q?/wDroZEHd8CswKnF1l315E5iKaIK+KI=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f6a3121-fe11-404d-13c6-08de4181a928
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2025 17:43:47.9607 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UeJNXIbk5Y+VPubbLXGitJnKF3mipYOcxCv0fo2AwyRPfSkOKx72GPTxi7Xk/N+9Vvaw1mMfWzPFLraJcDmPZOMM2iqJpzVqAarWMg+YEnM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6915
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

On Mon, Dec 22, 2025 at 06:11:35PM +0100, Morten Brørup wrote:
> > From: Konstantin Ananyev [mailto:konstantin.ananyev@huawei.com]
> > Sent: Monday, 22 December 2025 16.22
> > > > > > >

<snip>

> > > > >
> > > > > 	__rte_mbuf_raw_sanity_check_mp(m, mp);
> > > > > 	rte_mbuf_history_mark(mbuf,
> > > > > RTE_MBUF_HISTORY_OP_LIB_PREFREE_RAW);
> > > > > }
> > > >
> > > > Thanks Morten, though should we really panic if condition is not
> > met?
> > > > Might be just do check first and return an error.
> > >
> > > __rte_mbuf_raw_sanity_check_mp() is a no-op unless
> > > RTE_LIBRTE_MBUF_DEBUG is enabled.
> > 
> > Yep, I noticed.
> > 
> > >
> > > Using it everywhere in alloc/free in the mbuf library is the
> > convention.
> > >
> > > And if we don't do it here, the __rte_mbuf_raw_sanity_check_mp() in
> > > rte_mbuf_raw_free() will panic later instead.
> > 
> > Why?
> > This new routine (rte_mbuf_raw_prefree_seg) can check that mbuf
> > satisfies fast-free criteria
> > before updating it, and if conditions are not met simply return an
> > error.
> > Then the driver has several options:
> > 1) Drop the packet silently
> > 2) Refuse to send it
> > 3) Switch to some slower but always working code-path (without fast-
> > free)
> > 4) Panic
> 
> It boils down to purpose.
> 
> The function is designed for use in the transmit code path designated for fast-free, where the application has promised/hinted that packets are fast-free compliant.
> Violating preconditions in the fast path (by passing packets not compliant to fast-free requirements to this function) is a serious type of bug, for which DPDK usually doesn't provide graceful fallback.
> I don't want to make an exception (and introduce graceful fallback) for the designated fast-free code path.
> 
> My answer would be completely different if we were designing an API for standard packet transmission, whereby some packets living up to certain criteria could take a faster code path for being freed.
> If that was the case, I would agree with you about returning a value to indicate how to proceed, like rte_pktmbuf_prefree_seg() does.
> 
I would tend to agree. The extra handling for those cases just expands the
code and adds more potential branches to the resulting binary. Lots of the
fastpath code just assumes you know what you are doing, and violating
constraints will lead to panics and segfaults generally. Therefore panicing
in this case doesn't seem a bit deal to me.

/Bruce
