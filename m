Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D2B7C021A9
	for <dpdk-dev@archiver.kernel.org>; Tue, 18 Feb 2025 08:47:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D6C41402D2;
	Tue, 18 Feb 2025 09:47:51 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by mails.dpdk.org (Postfix) with ESMTP id 32B85402BB
 for <dev@dpdk.org>; Tue, 18 Feb 2025 09:47:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1739868470; x=1771404470;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=VddZgkD2BmTsKmXC6UcgZj144fNuAvW70hdbWxi3gLk=;
 b=U9ATk3JHKBSgcvBs7lWoB6P7EJTttNbw9lBWJQUY98L/ZWBlcYiKH5Kl
 eCjotRAIycGmwlHhDtf9YT3f0HawJp4JntzfyGeuUovet3KCVlj9RHowR
 73W2gmbrb9e+KczMZutCfkmtOSro9oq8bXgVkYj33LX7svG3f8Tdeca76
 s9vVvqU/zXsI/zVYbXR26E6yv77kWAryL/EMnTVU3cjiqULUb2ocuLKiO
 DFXIliHpZIfP76o0fmBqNgfVTAKqUq4RQjtWWWSblOCqXRJwmj2ImIXYD
 qy7OzDf+3SXbKk7tTeZSFyzMYJjXhlXXDeQdS4vtzgLTPWgEAOy/oP7m0 g==;
X-CSE-ConnectionGUID: y0jbFQj/RKKDsT8fN3O8EA==
X-CSE-MsgGUID: oaa7QujjT8COmXwEGS/kTw==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="40258500"
X-IronPort-AV: E=Sophos;i="6.13,295,1732608000"; d="scan'208";a="40258500"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Feb 2025 00:47:49 -0800
X-CSE-ConnectionGUID: bimznFceS2mRGWTZBuPZ/Q==
X-CSE-MsgGUID: wBJTznXjQh2AQPiLlQje6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,295,1732608000"; d="scan'208";a="114074541"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Feb 2025 00:47:50 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 18 Feb 2025 00:47:48 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 18 Feb 2025 00:47:48 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.175)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 18 Feb 2025 00:47:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uV6FaGn3P+VLgnRwo5mbkEuRFQ3VGzoVtS624eOjqo3mjbBtA13tMLwiEr3WePr3g7Tz6dFLk8Xbfyk77NsfWto29sRcPEVd43VhBq8J/un2aBaNCImVFnaTsjgJSoovtBauFwuzv8m+yRE0kArOigoOtIK4Y/+EiSoUGsEQIwDUHxpF1zFFQi9CZBYM73jxGOCgtrNH0g1zJu2uvYzr0ZKnu6Vy9k3frS6CWmMqF1Ud4Uae1izjaXS6Mu9cnPkNQgRuIbqIe5eqCF+39T4J61U1Ce/I1IFll3CZkgxJ3j3lonkJNa4DAfZHCzGT0EeNEx67Oi0MDDAQenAHCdbXpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P0s8nlnYRcasEytapDAxyo5SLV6B89VGUWv10mCkVzY=;
 b=dwxT3iGoEJitOD9X50XiC62m5v0yodgHHEGG7aYFaehc+4ElSizhKqIJS1tmQICGJO999er02Q89OjmKS2sZz5UbSvXSOArY3T02OsgRWHB1e3incaMPPO0uXnAtjFP1qBqyYFEc0iy/p+yGD8quLGJG9ge5vvptdoB3X/zUlEVS/6nV1KGWvBzfNiLFEfbAhn9LVtpkM9iqto7bE8XDGL2iyfHNqr1VjnkQLNA/77IvtS2glWF1CKCRJe9++pI4IikrN5EtQwzsH/vIME4NOH3EkH5E1sYwKskKFBZEL9Qh5lWU1BtMWvA5a2nol5hlKtga+At7aqR6j5liVWbATA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by CY8PR11MB7778.namprd11.prod.outlook.com (2603:10b6:930:76::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.18; Tue, 18 Feb
 2025 08:47:33 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%7]) with mapi id 15.20.8445.017; Tue, 18 Feb 2025
 08:47:33 +0000
Date: Tue, 18 Feb 2025 08:47:29 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Morten =?iso-8859-1?Q?Br=F8rup?= <mb@smartsharesystems.com>
CC: Stephen Hemminger <stephen@networkplumber.org>, <dev@dpdk.org>
Subject: Re: [RFC 00/11] Fix dev_ops dereferences
Message-ID: <Z7RJIYruHSu9lGvR@bricha3-mobl1.ger.corp.intel.com>
References: <20250217185743.169778-1-stephen@networkplumber.org>
 <98CBD80474FA8B44BF855DF32C47DC35E9FA48@smartserver.smartshare.dk>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35E9FA48@smartserver.smartshare.dk>
X-ClientProxiedBy: DB8PR09CA0023.eurprd09.prod.outlook.com
 (2603:10a6:10:a0::36) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|CY8PR11MB7778:EE_
X-MS-Office365-Filtering-Correlation-Id: fce5bf8d-1185-47a5-da8f-08dd4ff8e2b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?EVIpP3rCk4e/jMwfcdVe1MY98/CdZjWNHfwWMkk3K746Gtpsbmenr/KUCv?=
 =?iso-8859-1?Q?E/aEa8+tM3OfK/6zC2H+9Gn8KKcb9pL/6xndKP5pz2cIhhM6CVC374bVjQ?=
 =?iso-8859-1?Q?P/erRXJoFBgMWAvfPyexU5Gv72hlr+krKOQTWtU0UkXFUG4dFnU4tZIfLk?=
 =?iso-8859-1?Q?pLQhKMDGG3q6Jqugk++9Ke+SKAVFQ4vsbeiR5VS8PIb2y0tgh+WSjHR+2B?=
 =?iso-8859-1?Q?NzSUt6cuKJksy0HkgU1AvMfLwaxdoBdqb4mrTxR+KlmSyPT8kGtMkn6UeT?=
 =?iso-8859-1?Q?x3WSUmy6RLAmBozpAC7lF2AsEpXns0+fdHfR019aYh7/TMeEAG3nWyLqVO?=
 =?iso-8859-1?Q?l2YLbaozymIwhVo01tBEFnnsURz6AuetRH89yHc4qiPI8DZmmoMMoM+rCu?=
 =?iso-8859-1?Q?0A/lk+NPmZpvojGG/gIYPRijDocwNiIZ/2+F8aU/rqtZ2LXMqKzQqBhjVw?=
 =?iso-8859-1?Q?eRaDl+Z9pSlW6Ag7vX23D5OJp+YxyFBNd6oABWb7tqDI73/o0hNGG17pN7?=
 =?iso-8859-1?Q?xWszFY4koR6tR9PrqyG4GzazDK5emxYL9BQV+5TIssLaCOmY99Xk3pykCm?=
 =?iso-8859-1?Q?pI0KMgc1zfV9JHxiiSBtEdUG+Zgex/VAZY/x+P9wXFYMbjUVWAo8bPQfO9?=
 =?iso-8859-1?Q?kUJF3d/zPs6vzbtsRdqMwqRxNwJEhU8doSVdYJqWS0yIprrZhRd/zBDfuj?=
 =?iso-8859-1?Q?Cs7r4DvlaLFsYI42gRGwCnTDzYtXYZtgTxrecdWp1pVPzt+z3RVOafeTnB?=
 =?iso-8859-1?Q?uO5XhFIchJB8RzOXlCN/SG2oC7zh1cVk6iFsGsNQHszkkfpDUvfBA8EV33?=
 =?iso-8859-1?Q?X2G0X1SeCgk8MWCip/rUoZKvtWUMxu2gba43+LpNpajDEpwCHDmWlfhCCQ?=
 =?iso-8859-1?Q?vfsK4ZH4rrZ+4vDoN8KvXlKnGAIz10YclZ2+iuuY22eK/2LNlf6/kgAQgF?=
 =?iso-8859-1?Q?U9TyaU+oC1x8ciocGEnMEfbpgl4hX31Sd39Y9wuXDuahSwaXb0Cd3oxTH3?=
 =?iso-8859-1?Q?NvTrs/OpvS/U17e1769H2pNlfWLRglSp2htwf58tT4WKTgbewWVJb+Bg+n?=
 =?iso-8859-1?Q?/iask5+MjCnslTM9ARI6SjVwItYvGelcw1vFxuT16uW4uQ/pQpu3vcHgXz?=
 =?iso-8859-1?Q?lfvqXv9JqDFzCZNngbgi4PF/BD28iXcHNQ57L4w95v8jm5onkWUOjfwL1e?=
 =?iso-8859-1?Q?BsNHQbhrhY6Vdjv3k3qXTHIFoE7zZjYAp36KKcWpPRq0pTAS/oTUp6jFFO?=
 =?iso-8859-1?Q?6yJS2ak5J+C0papGFlpzMLsIn7EjJmdMm/tXbQpQMemiuQVMsF45MhP68l?=
 =?iso-8859-1?Q?PXo5maaP9qIzDXlK3hanYu3m9xjJzOdwXYMp3XnwDKgzWQUMWCefza6Pa5?=
 =?iso-8859-1?Q?SKaqwwuKAL?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?47qOwBee9VZFNPf4M9k48f5RH1Shh1T3EKfXoLUY0CwYX+oEyZOf+GknVH?=
 =?iso-8859-1?Q?PL8Wo+qBQIXBKh5PJHn5MfoRNodrCUvrmCAmbea475f3+5fZ/M6YJiC8pE?=
 =?iso-8859-1?Q?jA9HwHsGY1i7U0lG+dQo2ejHxAcTstKfwTclhBeWGh9Mp99S+k0XR7rsMF?=
 =?iso-8859-1?Q?Z9hIqETQ10FzNQOh3+ALfa2TpOtekdiPrFNpXy3tGaOVMkhun0Z+oWdgpG?=
 =?iso-8859-1?Q?XgQTMzz1zttYIrLawTz9ddASKCTYJJMEdEg6F7fPZIEElUa3UNz0xY9QRJ?=
 =?iso-8859-1?Q?NdVm6xsI1Q9aC+ii6PlV5W/qlYovdnM9KuMYq6ATdVjANLDSsf8p8x1zaD?=
 =?iso-8859-1?Q?ByErbA1QTo7SkauzHaHtG17dkiyuECwoMXB3Ix/TPpoA3q7Zg45BKrbfYD?=
 =?iso-8859-1?Q?Lnkd4HioUqr2113QWBclQiTX8r++7SOLSZhbNOd1pQ1d0YDvLv68W+Z2MP?=
 =?iso-8859-1?Q?B5Dgc2Xi7qseg6+HO7X+IYEwMu/nmnIO3quj7qwEIq12nWX0cnFiVNxbVe?=
 =?iso-8859-1?Q?fs+aP1sGDp1dN+p6YSTmMtNAcSi2PZe4Vxm223vusL7PbmL8K+DNaEktKm?=
 =?iso-8859-1?Q?S0bDmt1ViaDfSM4UMJ+LdJM6GO2g+MgIw1s1dohhiV/l+CBg2J7h+qBr2z?=
 =?iso-8859-1?Q?BDRfHFVDj/QsgHulLKXYvkuPJeYRsnucjCFmPCiLyiL8vaeRnJh2nvYYGS?=
 =?iso-8859-1?Q?oRwYlG02lewuSDzE0vFwfgAsyGyHJLnYsMmQsIMBBIIF06b1Dnp6VMbmTh?=
 =?iso-8859-1?Q?gFjwZ9WBbrPXH+KDqMjpIbhlWsD/YSHWFTIN21uQEE5md2AUBMJHtRDDQs?=
 =?iso-8859-1?Q?T8WkO6Fzvi24N71OhDAXNy6l3JA9Q+M7msEzh4maBvJf+ZZJWhML5nVvwu?=
 =?iso-8859-1?Q?ROIzbI43EWGvuOTnwryFeD5c8hOoPWgAn+kQs/b+lEdUXounusLfHwVEaB?=
 =?iso-8859-1?Q?u/ttVWhYIfEPAUZEJvQvL0slo8g26bPj9gus5qYIMW+BQEeRKZrVdoaKYG?=
 =?iso-8859-1?Q?j+KBSNtcReSOwFKfo5mXmJ40U0iTelJlMT6zWi/fEoTqacXXV4ouEsEb6J?=
 =?iso-8859-1?Q?uR9VYeSH9mOA8UFHLrb6mLcQkadQfxiPSF8qj+rf2uuJbuSb0luHJ9XEgH?=
 =?iso-8859-1?Q?aeRgg9IYLSiVTEXQWAV/eIjC/F1mHlcxrNK1einQaciVF4hbGHl/EP9iag?=
 =?iso-8859-1?Q?0NOuJ8sjS8vXF0Afd81fE9+ko9VEM1oR4LlRBxgNLM0khHz06IsBR7Hgoj?=
 =?iso-8859-1?Q?21rhf3+lZV0rQw4QZuJn1NvpGwTPuz7MQ5hQDS3VnQjK7NYLILEml3KUDa?=
 =?iso-8859-1?Q?Dzb+BYIEg0Qy6KwiytDgarr/PnSL/ewnPN8N0nm2YTX/EI4YjMudO+KzwJ?=
 =?iso-8859-1?Q?+1bSRDUb9tOsr6f8xihn+dvqKNxJf82OdSkuYO5+bR4V3qR0zRMUATcRMF?=
 =?iso-8859-1?Q?9jiPE8s8uWv/f68gqAboi42sZ7/H8Xa0D5SjYY9nDx8R2xyLbD/+P2BVnC?=
 =?iso-8859-1?Q?UdwGsoEmXU6LudBwbgKMeh981XuRVgzyF+IHMlc9zU+phjk5OjPJ9sGM+p?=
 =?iso-8859-1?Q?3kHgu6rKF8KFjLbi/Lq2woac0GLSSYx0BhuPAh4fTfZqQGc3IlwKnej1+Q?=
 =?iso-8859-1?Q?7YfFYWt8z641yzHknnfB0PW8EBjXLC1RcgPP+JB6cxpstIXrL9qC18gQ?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fce5bf8d-1185-47a5-da8f-08dd4ff8e2b3
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 08:47:33.2107 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QgkxNA3xK1tVcLJjTp/fmwF9LMfjoW9EADO8FFiZR+eIbOueHxB9T7SUcsJ2pBH7upmjfmcjSukT1AJaMsglx8+VmR1gUSDyJLM99W/f9No=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7778
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

On Mon, Feb 17, 2025 at 09:24:04PM +0100, Morten Brørup wrote:
> > From: Stephen Hemminger [mailto:stephen@networkplumber.org]
> > Sent: Monday, 17 February 2025 19.54
> > 
> > A common pattern in DPDK internals is to have an array of function
> > pointers. When using these pointers an unnecessary derefence is done;
> > this is allowed in C because of a historical quirk but unnecessary.
> > 
> > The PVS Studio checker flags these as:
> >  https://pvs-studio.com/en/docs/warnings/v516/
> > 
> > This leads to a large number of warnings marked as High severity.
> > This patchset simplifies the source and gets rid of these warnings.
> > 
> > It should have no impact on the resulting binary.
> 
> +1 to this RFC.
> The code becomes much cleaner to read.
> 
Agreed.

Series-acked-by: Bruce Richardson <bruce.richardson@intel.com>
