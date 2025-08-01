Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90078C87FCA
	for <dpdk-dev@archiver.kernel.org>; Fri,  1 Aug 2025 10:20:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B070840263;
	Fri,  1 Aug 2025 12:20:42 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id E8FBC40156;
 Fri,  1 Aug 2025 12:20:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1754043641; x=1785579641;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=7l/bDUFFcQl/NjeB5cf9e+mU/lAUnh3wUP+91C5AEn4=;
 b=F/UhBYUTYmY7z/HCTX7mzQc6E3+Cex1FkZVkdVzssQ7tRckV6efXgHHJ
 kI9/LbrO7D12NmiBFT/Hny+I3T9/jv8eLh2oQRQZsBVhE81sZzl9PZQsu
 887bUwgeWu/nWNnEWtrNZPJtmkhN5i7b/1x6csNHo3RrVjIg+9FfSgEzw
 L0CtlGopptsIL+5P2uPdgMVh+2RBYY5L/mIe3W81aBV0uQcZKZFRYNjLh
 ul5cLxVElXEewt/juU0DYiSGuh3ET7Ow/dL1g/avy+VCB6RBbmnI+3uFm
 CPmionbhMwJt9ocvIOBDjlWDIjyT25p+527Prs9D7xxcSXk5lW9y6LGv7 g==;
X-CSE-ConnectionGUID: QizyYYxURjSvy9CEZVN8WQ==
X-CSE-MsgGUID: 5fRq8fQ+TWa4947ebYPmnA==
X-IronPort-AV: E=McAfee;i="6800,10657,11508"; a="56324133"
X-IronPort-AV: E=Sophos;i="6.17,255,1747724400"; d="scan'208";a="56324133"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Aug 2025 03:20:40 -0700
X-CSE-ConnectionGUID: jois7XCYTxG4jkGu1PTTEg==
X-CSE-MsgGUID: h2eIY8iDTuKh41lZfHIVzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,255,1747724400"; d="scan'208";a="167742497"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Aug 2025 03:20:39 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Fri, 1 Aug 2025 03:20:39 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Fri, 1 Aug 2025 03:20:39 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (40.107.244.51)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Fri, 1 Aug 2025 03:20:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P+ajPx9V1bKo+3WW9zjTzIL3QMoF+0aVcgoKsxlMU5YyjZ0zjBJ/3/UfA0lEGgW6FcFGckigap7WpJHuyOdnhtWvGoebgTyCcbtd1489diLLutgxGQZbEkfOSBHx3S6ZXFeCd1jxzemnMeTDh62vBcAdC4Br1KCgm/4Yb0l0spqMMiVvnkevfpyI8K+SdPqDqcODz01Lp3DcqjVH1m8vU1lyj7Po9BZ3Eqp0xC0Ers4BeONAo4FQIyUUvK9asj6mjW9iZ5OXEv/ZusFx51g+OMOJghc4C1CCjzzRN9mT1ndTuJz/eH6v2cBjMM5IdtX3xNHlFPH5jYTyUiUJGLZzkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GKj1O+pV8ZqY3Ghee5pzF49hPlpQH7EQql0uaCq0zh0=;
 b=RYeZ0mTDmYUMhCosQA17mXLXUvMfERpNjotUnWwwZ0ZCiPDWRJfPYwXszhQOm8bx3nK1PmTHFKtLmtR1MfpOjyX/SmJkB5sGbcS396SidFuDoP/RrCnzj895S6OpdKYmMzydy+Lti0aJDIzbzgktytiuIpE7H9Z/M+Vu1Cw54oatwYcMwBOI8j9gGaryehzvsbrz22uz4DAOtvNE83OqESdDJCfJ/BowzIIPTMKuwU2QNUs+8XXqcaYkQACZv7ydj1QCi/TQAMRT+eRzOrtHgi363Gq1xhBNf8QXhYBnRKf6CBU/qu43Wvc+f5dGdfVP+Sn1bLn7/brh6lf7Uu6g8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SA1PR11MB8318.namprd11.prod.outlook.com (2603:10b6:806:373::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.11; Fri, 1 Aug
 2025 10:20:37 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.8989.013; Fri, 1 Aug 2025
 10:20:37 +0000
Date: Fri, 1 Aug 2025 11:20:31 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Morten =?iso-8859-1?Q?Br=F8rup?= <mb@smartsharesystems.com>
CC: <dev@dpdk.org>, Dengdui Huang <huangdengdui@huawei.com>, "Vladimir
 Medvedkin" <medvedkinv@gmail.com>, <techboard@dpdk.org>, Patrick Robb
 <probb@iol.unh.edu>, fengchengwen <fengchengwen@huawei.com>,
 <stephen@networkplumber.org>, <jasvinder.singh@intel.com>,
 <thomas@monjalon.net>, <aman.deep.singh@intel.com>, <lihuisong@huawei.com>,
 <liuyonglong@huawei.com>, Dean Marx <dmarx@iol.unh.edu>
Subject: Re: [RFC PATCH] doc: clarify VLAN and QinQ stripping behaviour
Message-ID: <aIyU74btZ88cn0d9@bricha3-mobl1.ger.corp.intel.com>
References: <aHgBs5DGU48mTnwz@bricha3-mobl1.ger.corp.intel.com>
 <98CBD80474FA8B44BF855DF32C47DC35E9FDB8@smartserver.smartshare.dk>
 <CABD7UXPccao=o1O=SessoAdEKUyA-dXP6HG5mnkpFSVNL_3dxw@mail.gmail.com>
 <aHoEUmesrg9Y8qtM@bricha3-mobl1.ger.corp.intel.com>
 <CABD7UXOqkROef0_BreD1GHC_R+7EwxRTL8LF-fXQJBECp7J9SA@mail.gmail.com>
 <98CBD80474FA8B44BF855DF32C47DC35E9FDCD@smartserver.smartshare.dk>
 <aIeTCX3KbnxIvDJP@bricha3-mobl1.ger.corp.intel.com>
 <98CBD80474FA8B44BF855DF32C47DC35E9FDCF@smartserver.smartshare.dk>
 <aIpWP6FCcMXktUvq@bricha3-mobl1.ger.corp.intel.com>
 <98CBD80474FA8B44BF855DF32C47DC35E9FDD6@smartserver.smartshare.dk>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35E9FDD6@smartserver.smartshare.dk>
X-ClientProxiedBy: DB9PR05CA0013.eurprd05.prod.outlook.com
 (2603:10a6:10:1da::18) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SA1PR11MB8318:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d3e747b-7297-46e9-c816-08ddd0e50ea8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?z5upAr1oRlmXTlEYJYPoKSkpmAF343bODi05f2DB7zxtiOwxNf0W/IIUVs?=
 =?iso-8859-1?Q?cjczmtaXUi9DreEljo8sGJ1dkTmNU1JL852CLEcZAgt38xS8JYa1nrJbMA?=
 =?iso-8859-1?Q?31+eSBEGDOMMrtTcO7Ae6pTsEtN2CEWQVczfMG3cvVmpUOdA6mPSjdHXwQ?=
 =?iso-8859-1?Q?K7qogG9xLLyUwI1E4Xaq1JDzoNCoVQK4cyao4aw4Dv0rNd+1weTrU8Jdiq?=
 =?iso-8859-1?Q?EY+x8WvKyT9GLvvJbAq/Ep142uXwL79RP6lHMsfvp+RRmusmdOptFb/4CS?=
 =?iso-8859-1?Q?kcyJY46OCVPz81e8Uzrmr2p4Hc/QgFCKghSdAiIw48sExWArEUqpMERnIo?=
 =?iso-8859-1?Q?IHtBa6QKDCgH40l5uQeiy6a4FP0sF1YYHYH0Clvu7zDQN4+1xCaL2iP0XC?=
 =?iso-8859-1?Q?wK4HNjTktIAVgXX6O6cll8OViv+4jlsNceewqIEOJLmn5RBiIaRnfDXRm+?=
 =?iso-8859-1?Q?TanMltyodAzShRLWXEKRtFtbtD0Af1vuhMfjRMHLJmR749gbk60GG12RD0?=
 =?iso-8859-1?Q?f61G7PuVxn2750XrpRfwZkwCIQ/PNyYUYCyvRMN0Iw/cip3JYjSRdwy6/l?=
 =?iso-8859-1?Q?teIsQD65ePqIMTAGuod9svHy71m/+4kXs7iX7r6oOA5TFdlUzqwtH8J8E5?=
 =?iso-8859-1?Q?N6DIyNf5ABLQfT8ZQvEnamwkHNNkTuFQaP0DQISuYmDoEPSXCAE3iCmROu?=
 =?iso-8859-1?Q?pN9xpUGASonwIHR4/aHj6Kp1vpRhLXR5mZuwAUIvNUhGIh2XHZ4+TGGgnB?=
 =?iso-8859-1?Q?xumIHizJiy76WREOdhNeK+nswHEYjAops2mxFokztwOqoyjZ0d3yo18HY0?=
 =?iso-8859-1?Q?/85SZHqb62t1Ea+ix6peuLtwQBYs24dYG48sHrTiFtEqlZjCAy1NQVaN3d?=
 =?iso-8859-1?Q?Be/FNl8t6sZCzMYec6Q/CgTp94laDGW9X4CWD8BvPPmcrPpCNFOYOsTyz5?=
 =?iso-8859-1?Q?iVKkwO1fhoWTYZumd0KuugmaEWxwyQU5W4lMBnLbp8NFCsy3JW9xENmP8s?=
 =?iso-8859-1?Q?9sLAycu9qFQDq4mzOij5A/KaWGI6Z/mXrxAdMQkzqUMaKfjViQqlA0Yqdd?=
 =?iso-8859-1?Q?9D632OeCFTiSIEDRuEOhFunLTvPjpqIEA+qgWhVQ8x6N4/yFKIKNKysnpJ?=
 =?iso-8859-1?Q?U/9nAHbFgcPPJelWsd+IwPTdxQt5VYuyQO/yUxILnq/lh+ZOkYKeleJUCm?=
 =?iso-8859-1?Q?CzjylH9PcRODTGLDoDf+fuo4PJYjvSq0Wg7TskBVZ2S/0KwM1M/wkQ5Lhj?=
 =?iso-8859-1?Q?UaNuzgXDOae6UQw7ZZw2poOVI0zRiQKXU2R6c6GzrLtFUVz/YW2SYBGuso?=
 =?iso-8859-1?Q?rGeij75Crtn3RVJszIWUCLF2Noa4a17UuSzPdESq6gkl3+XL/cs7DHgR23?=
 =?iso-8859-1?Q?5h2mZ2g+QQl9l9SRClvKM8SWEnbLlYLN3L7OrDI6ueKtzib1e1MU9gSE3M?=
 =?iso-8859-1?Q?O4Y8/6F7vtwFKhFKcGdKTAW1VsXvhI2UbE1gt1AZZ79RjaSX4l/V9lO78R?=
 =?iso-8859-1?Q?c=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?O+8MZnEoXkjuQNV1XeeHRA4+7mkRYqFquqbGGTEVk+loCwPEd9bxlIoXCR?=
 =?iso-8859-1?Q?Sj1YpUGImXCqLXiifkW736RXH3dnkhbrcps1OaLoRgrmwq6YjoFQEws/wa?=
 =?iso-8859-1?Q?aay6Ba+WQPnvNKHqpHiWbbb8+wihk+BJRh0VmZ8GvmFHWH/Zwbp/srslxJ?=
 =?iso-8859-1?Q?AiyPx9mZ5An19cj2mt8+TIaXSARo2OFt04l1ItI9hmX3fTEXQ6l8HL9lhw?=
 =?iso-8859-1?Q?y1aNrZdU1NJ9+WU6pppGGdh2NC9arElGPz4SgNGq4zjhmGclfUyDpI3Cnn?=
 =?iso-8859-1?Q?xDJDx/Ay1C8r+mGchtW2uaqPbLj/rDLOudyDF96VFXFEPf7dN6S9LlbqvW?=
 =?iso-8859-1?Q?zzWb7XgAG6Tm5TBSb06Rp47Wa2Ne6LNihjVQ14sA1t1O9dCTYyrT3vIgt0?=
 =?iso-8859-1?Q?pdRqpnpxfFG1g0z+HiJSaJZx+q+BtzH8xRmxEK7CQB5HD3tZKh8IImcnf2?=
 =?iso-8859-1?Q?jlTe/Uk9tznFnTnX2CVbp3sRNUFXO2mJGTXWly8CoXHUiKtss8FodIH5EG?=
 =?iso-8859-1?Q?cTpw9CECuZhPgH0tSfyJVgy+FtTadF2cUWsywda7Q0+yVEKE5SP7kXMRrt?=
 =?iso-8859-1?Q?pee5sVwI0SPI2WRdEv5/8rAjk4b3b87MZM4UprbIXRvf1BADuIEMM+NvK1?=
 =?iso-8859-1?Q?E0tt5niC6mv1EsaW7SQ+PsclSv09Kb/gD/7E9zxU2qNJmrad/nbz6hV6UI?=
 =?iso-8859-1?Q?zalemcXNgFOyqVQ/fAC0XlHNQT4mbFZL5T7NrQOBzgAx/hJZtXpkW+pKyz?=
 =?iso-8859-1?Q?7Hmx30UAQlsAwlxZVZBAa3Ox9JSJ0TCDc0j8fjMMDVjXFmk/UX38PKChyL?=
 =?iso-8859-1?Q?PBiCz3WIVxlmWSvfT/afNbngeX5X4GmEQxuNqPMJz4Fq8i3aoPc9HqZdER?=
 =?iso-8859-1?Q?lNHRtwvotc/EQFdX6jj8kVkTqy2MJtaUdiJwZZ2Y0L25Vgg1bl58agMfAc?=
 =?iso-8859-1?Q?MHgvQOm1YVlCjYksXg+NBKnI/PmDxJGpP8ENEFJuuYj7ZejuqfGLikHWwV?=
 =?iso-8859-1?Q?+E2MehfTiM6JaqNR+0u8eI+MCBoskft8FC5m6S11mBmAM8VGAE2QKRgqy7?=
 =?iso-8859-1?Q?H4mD/hZkK99lMQiLuUK+hpffMysA6fhs8zj16uMxDOg96ldUOVM7Y80hdp?=
 =?iso-8859-1?Q?5FCFKXaNzZ0p6GEDW0+n+LZFsouf7zwBJteuGi5+rM93quxk64CJNO7kR7?=
 =?iso-8859-1?Q?NescpCxsgTTITA3UPyvZ2fp55FaTG58O6C/taPwUSP5G7hCOkAOvlw8k0I?=
 =?iso-8859-1?Q?BafpwlEmFRzackQ2TqBEBaWFhQq/A90WhHgkQ/tjOG6RuqJY2Dzm8lb444?=
 =?iso-8859-1?Q?vb+MbXm0xSJ93dW/kX2oD07U0EdQSEzYKbB8gZPCDdWQjn5z+8jiSbMKuP?=
 =?iso-8859-1?Q?t9wViyFKQtGqb5kr9CMZ3pV8KZhxeR678jMaBCaOtbCLQWU0PLZw2Te55I?=
 =?iso-8859-1?Q?VeGw+DhtU+UVTfbfA1dq2HcKwg8EmvGW2dnZe/Quoi2Mfyl92eIzkdwIVm?=
 =?iso-8859-1?Q?kwJK0FspYGEna8jbwYwE/n3n2E7Gh93cyi5WW8Q5df3KamLUAdOMLUnm/2?=
 =?iso-8859-1?Q?kBJqKwgnzqeE0MCZXXmSqXLdAEf9sDHb0xrpOXCixSwoTKDVo3dTDmtkpY?=
 =?iso-8859-1?Q?wOhzf0HwbFEE4spTYMtpR4NtRMV0mTKWQrxNF/Ph9Le4ZSvxEAc1JwwA?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d3e747b-7297-46e9-c816-08ddd0e50ea8
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2025 10:20:36.9945 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I0JNoGP93qkAtAw4uje9z3mwclIEezbSATamrTsw562ZNzchJX5lXVvozpX+gvHFPoeNDvIqK1NFu0yXp/KBB6lScdN41ABYlimKCnlJIiE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8318
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

On Wed, Jul 30, 2025 at 10:10:42PM +0200, Morten Brørup wrote:
> > From: Bruce Richardson [mailto:bruce.richardson@intel.com]
> > Sent: Wednesday, 30 July 2025 19.29
> > 
> > On Mon, Jul 28, 2025 at 07:48:53PM +0200, Morten Brørup wrote:

<snip>

> > > 2. For more tags, start by strictly conforming to the IEEE 802.3
> > standard.
> > > QinQ is EtherType 0x88a8 and is associated with the outer tag (S-TAG),
> > mbuf->vlan_tci_outer, regardless if an inner tag (C-TAG) is present or
> > not.
> > > VLAN is EtherType 0x8100 and is associated with the inner tag (C-TAG)
> > or simple tag (VLAN tag), mbuf->vlan_tci, regardless if an outer tag is
> > present or not. (Note: When disregarding the outer tag here, this is
> > exactly the same behavior as for VLAN in bullet 1 above.)
> > > This defines placements of the tag IDs in the mbuf and the default
> > EtherTypes used in the packet headers when parsing/stripping/inserting
> > tags.
> > > It also defines the purpose of VLAN and QINQ
> > capability/present/strip/insert flags in the ethdev and mbuf offload
> > flags.
> > >
> > 
> > So based on what you say above, having a VLAN strip setting separate
> > from
> > the QinQ strip enabled setting doesn't make any sense, right? So we
> > should
> > decide and document that when QinQ strip is enabled, VLAN strip must be:
> > 
> > a) always on - which makes sense if single tagged 0x8100 packets are
> > still
> >                stripped as you describe above
> > b) always off - which makes sense in the case below where singly tagged
> >                 packets are treated as outer tags
> > c) ignored - which is a bit of a cop-out, but avoids any issues with
> > backward
> >              compatibility for apps.
> 
> No. I'm saying something else:
> With QinQ stripping/insertion enabled, the VLAN stripping/insertion flag controls what to do with the inner VLAN tag (if present):
> Enabled: If inner VLAN tag is present (and outer QinQ tag was stripped), strip it.
> Disabled: If inner VLAN tag is present (and outer QinQ tag was stripped), don't strip it.
> 
> Think of a conceptual pipeline:
> First stage on RX (if QinQ stripping is enabled), the outermost QinQ tag is stripped, if present. After this, the packet has no outer tag anymore; the outermost tag has been removed, so what was the inner tag before has now become the outermost tag.
> Second stage on RX (if VLAN stripping is enabled), the outermost VLAN tag is stripped, if present. After this, the packet has no inner tag anymore.
> 
> When QinQ stripping is disabled, or HW doesn't support it, there is only the "Second stage".
> This is what I was trying to refer to in my bullet 2 "Note: When disregarding the outer tag here, this is exactly the same behavior as for VLAN in bullet 1 above."
> In other words: The VLAN stripping engine only considers the outermost tag (possibly after QinQ stripping has made the innermost tag become the outermost).
>

So the basic configuration testing table - if we ignore the API for adjusting
the tags recognised as inner/outer - would be the below.

NOTE:  I'm including tag 0x9100 for completeness as an unrecognised tag,
and also because if we do expand to testing the API for setting
inner/outer, we'll probably want to use it. Since this table can be used as
a testing input and we only need one packet for each type, I'm also
including all permutations, even though many should never occur in real
life.

Does this table match what you have explained above? Anything I need to
update on it? [It could probably serve as input to have an AI automatically
generate a full set of DTS VLAN tests, if we give it an example
implementation of one case.]

/Bruce

VLAN Stripping Behavior Table
=============================

Input Pkt Tags       | VLAN Strip        | QinQ Strip           | VLAN+QinQ Strip
---------------------|-------------------|----------------------|----------------------------------
0x8100               | Tag in vlan_tci   |          --          | Tag in vlan_tci
---------------------|-------------------|----------------------|----------------------------------
0x88a8               |        --         | Tag in vlan_tci_outer| Tag in vlan_tci_outer
---------------------|-------------------|----------------------|----------------------------------
0x9100               |        --         |          --          |                --
---------------------|-------------------|----------------------|----------------------------------
                     |                   |                      |
---------------------|-------------------|----------------------|----------------------------------
0x8100 0x8100        | Tag in vlan_tci   |          --          | Tag in vlan_tci
---------------------|-------------------|----------------------|----------------------------------
0x8100 0x88a8        | Tag in vlan_tci   |          --          | Tag in vlan_tci
---------------------|-------------------|----------------------|----------------------------------
0x8100 0x9100        | Tag in vlan_tci   |          --          | Tag in vlan_tci
---------------------|-------------------|----------------------|----------------------------------
0x88a8 0x8100        |        --         | Tag in vlan_tci_outer| Tag in vlan_tci_outer &
                     |                   |                      | tag in vlan_tci
---------------------|-------------------|----------------------|----------------------------------
0x88a8 0x88a8        |        --         | Tag in vlan_tci_outer| Tag in vlan_tci_outer
---------------------|-------------------|----------------------|----------------------------------
0x88a8 0x9100        |        --         | Tag in vlan_tci_outer| Tag in vlan_tci_outer
---------------------|-------------------|----------------------|----------------------------------
0x9100 [any]         |        --         |          --          |                --
---------------------|-------------------|----------------------|----------------------------------
