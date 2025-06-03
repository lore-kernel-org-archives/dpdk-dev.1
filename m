Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25495C5AD49
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Jun 2025 15:59:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 28BA040ED1;
	Tue,  3 Jun 2025 17:59:30 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id 871E640E3B
 for <dev@dpdk.org>; Tue,  3 Jun 2025 17:59:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1748966367; x=1780502367;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=vbyHFJin1zgQK00WHNW8JBuE2cgHBEM5nr3GvyFp4cc=;
 b=I5KcKTphBiLVOlj5WMD0XdFMn/E6KWgQNStZh5DBFn1HuFC+685jE5M7
 78u4+hB21dRxj+AChAN3TzQrDxMxhtABTdY26v5jMVWOwCDdEjSt985v/
 g80SZJI4rgGumKNOe32UvN+g8JWptyxks6IaDbKm1Lh+2KGdZwvjoUi8Y
 26fcoX8ZtMlAp2ajVBOurVWXLI0mbOhKp/NWoEy4NQkKHfZnqgB3ERbqA
 fTE6O3ZGaOVojh3ikO1V/fpTJPwlWmTZP5YpAhmeMLryUMDtoH3CSIK0g
 SqjP9kLMASBHFBgny7YwJFR0e2YAbC+S3jEJTRYpQNhUZqTTip7HhUohs g==;
X-CSE-ConnectionGUID: XRA12lx5QeuN6lisX66cdg==
X-CSE-MsgGUID: y2yWvETyQ8Gt6KNNnunRzQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11453"; a="50885987"
X-IronPort-AV: E=Sophos;i="6.16,206,1744095600"; d="scan'208";a="50885987"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jun 2025 08:59:26 -0700
X-CSE-ConnectionGUID: 1PaIhBAsQkuD7/RwrLSiQg==
X-CSE-MsgGUID: twobCqKMQcSi7Aap3u60MQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,206,1744095600"; d="scan'208";a="150186210"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jun 2025 08:59:27 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 3 Jun 2025 08:59:26 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 3 Jun 2025 08:59:26 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (40.107.244.69)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Tue, 3 Jun 2025 08:59:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FjQs6NsBZ4kBMu36a+mnqPsS/7niinfgdu4YN0LULny69KWnyonOC4Mg/aZGhdUl4FxVqv0A0G4T/hZkLBP74Y4VR2bN9cG4WAxYkDTLEQP0NVLCFpFVhxoFKav46Dq+/11u6ElVcIH0dkq7O/QGOC4AF/j98pGoD1wK73QGNIs+9zkOc/S6cVlzhEHHE0aqs7vHLW7tS2EzjjdKYzrNuyZFvIwboOx7M8JrmqbVlHbRihgqhCmLbdJaR8SQZN0JAGNS7IntlXtVrtJ6+OGz/IfvkfAdCtqY+wAaoIwZlwPgQWZMcYYQ1djVklH38rWTc8ikfvj6DPb7/djNxfRqfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fP+zvB5RbSmth/ijydINkbOFtaEgUubGred7+zZ4p9s=;
 b=xXwc6DeP6lQ0VTzAYw6T/xwLEPTClzlj7lS+r4mBDYVnJcRzJjr6yN3xG3V/21xPtNbBOpdhB5a1e2f5jAr8hC4IJp2GmVyYZNLQstVBtR9Tu5AV9qja11y8aJDtH8gUmGaUkE/KChjLC2SNZStq5dNBXzNS6wxzpgLPUYVN9n9kPZKRXLoj8B5C3j8HU/X3mhB0lJLTcNQ0GaQrOAKdM3LMH6K8cjqoEUd0eNMcPF5u9x0JWnhx7Y0IAGDsFHgifk2tul1AV/97fXZSnbSyWySMk71Fdfl+twU4SePGviit7Tl1avtez0NsikJpWYRhTR97vycIt1i4t41RasmG9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by MW4PR11MB5909.namprd11.prod.outlook.com (2603:10b6:303:168::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Tue, 3 Jun
 2025 15:59:17 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%5]) with mapi id 15.20.8792.033; Tue, 3 Jun 2025
 15:59:17 +0000
Date: Tue, 3 Jun 2025 16:59:12 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anatoly Burakov <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v4 07/25] net/ice: rename 16-byte descriptor define
Message-ID: <aD8b0KalUvWgw0-A@bricha3-mobl1.ger.corp.intel.com>
References: <cover.1748612803.git.anatoly.burakov@intel.com>
 <cover.1748612803.git.anatoly.burakov@intel.com>
 <2d5967581860a939537d27cda859b8626ff2b6e3.1748612803.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <2d5967581860a939537d27cda859b8626ff2b6e3.1748612803.git.anatoly.burakov@intel.com>
X-ClientProxiedBy: DU7P250CA0009.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:10:54f::13) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|MW4PR11MB5909:EE_
X-MS-Office365-Filtering-Correlation-Id: a0a09afa-d9b1-4ca6-3fb5-08dda2b79846
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+9C847aw2+WK2UpFUdYFBRL0sECKdeE2P5zujNcNSEDY2gX4iDwrzsWhqNwz?=
 =?us-ascii?Q?9h0Kdtc5nXpeQyPnc2X3wskg/Xw6lqVtH0QhSD2Wt/1BViOnpIpVVCZT/3kD?=
 =?us-ascii?Q?odJljA+6DrXkRxHcnWpFs1UzPGikTiJRUYsNt5S99m0wfzxSfTuorEQdgJkk?=
 =?us-ascii?Q?/7GtA3BDtiaHr9XXCSuF1uME3YKwkdmPwW2+4+bGmYTjXO/ue1/gmUntKxpO?=
 =?us-ascii?Q?rwCof1eGly7XEROODaksuZgYOqyWHJ1iJJt2p8/e3vkpjcdZaAwR1deZ16pf?=
 =?us-ascii?Q?/WprHL760tlqclISISOuggtYM/R/BAwBCUSFUeWFh4mAd+JZGDulqS8us5in?=
 =?us-ascii?Q?1jkXMLLJK1jSEfeqv944GlmofGQdeyq5hnnoMYmht6LTDcgafgEAtw6Q6chl?=
 =?us-ascii?Q?j2fKE45YbW1pwdVOzUOyx//6g3lk9BDr5ql1fUN5o7uN2nZM4hiOngmyvVUp?=
 =?us-ascii?Q?SblN17q+mWPs1Dszt+kJTHDY+aY5yCCQk74zMQABklubHt0zhnfGF87SfigA?=
 =?us-ascii?Q?dZ1KTE4Jt6uaevFmtuKu+IxuYkAERGUzEyWBHpVhq7uInfIVd4hsOBUHDquZ?=
 =?us-ascii?Q?nfSike8tflCrG5la3QH7vc584zSYiMWAQPCkJ+0AqQOKXdDfQQVECg5w4jKg?=
 =?us-ascii?Q?ZMdB/6bO0hLzMNpA0lWZ1D37SBkDGodOuTCpqCK1rWt8aYGCTzPUQFw2RmMA?=
 =?us-ascii?Q?eU/+DrkWWjbBZVnWuiBUJU9p0M9KOUUrQC7i/Fd8J7AiHp4i2ADR3W/44PWI?=
 =?us-ascii?Q?KwjZzawcqjZT+uhObY02eiDIz3owy77Tf6qKpRlqKiYkjd1TDHyN6Huv/045?=
 =?us-ascii?Q?oKHBnd1RolkAICPdFKFR3NyLhL66dSkobR3jV3C0mNTNSda/sb8FgdDqP2l9?=
 =?us-ascii?Q?sLcG7QC71XBqGpt8Ctk4I4mCe3+l6g+m1PpsWT4IfkQT7zAH9LNw2UyV0mdQ?=
 =?us-ascii?Q?NgzhkA2+swf7+w/qq1z6sQkXE1dDnEqW4fXcmEHeUP3bzHWCOupaKez4ztYC?=
 =?us-ascii?Q?u5if1/a8MK6Lg7VVfHq1LenLqCf/buVxWtxC/vzKRfQt5Sc2y6PZUbD7/N/d?=
 =?us-ascii?Q?M+QGnwblr8BwkFV1B68+SXMyjQd2O2yqGyJfdn+jyrxMYlIQMqJcAjAg9g6k?=
 =?us-ascii?Q?+TexJWE2MCq0E/4tspybhNgMP1l91itRPIWaP8M7MDbJiI0n4nZ0KytVpG6h?=
 =?us-ascii?Q?o4g8FLwOAJXl6WhBUsAQyCiHVVTNpUIN1XrVw7EibLGKG+ZzzgubXVgsItQx?=
 =?us-ascii?Q?BbMqU/j9YgQHPPZyIVa+MiKpEpZSDMP7aFH48wdda389Jr+ctp/wEIZWJIWg?=
 =?us-ascii?Q?4ymmroKVxQa0+9pSxvR8BcYLAGvdpyKC5VkDQHWxzfvka5dxVs15cWWLqKpD?=
 =?us-ascii?Q?ZlTvNBOBUqn2vPT4CxqCg15rP3mvuzfuTzrBd2MajYn98BTHhA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9ETANPUQoZFzeOLLAUi/eHI2/n39bgA/jt060VNwrN7mrl74kvuJptY2JDp6?=
 =?us-ascii?Q?fa+aE9vMPl82oqb5J/XhordSzLzEtDlXh4ydCuhUwUEEv4an+KgLEw4BpvcB?=
 =?us-ascii?Q?5ysG4FR4FGl/O+vVEbOJuK+GEBAds4p3233e1S1iCxX44S2V8xoMHLr6u8ep?=
 =?us-ascii?Q?1CuN+FPB7r87LbPM0mL4idxvyoNhoelZ2sXOk+MZD1NC83QQ/R7mMRqGQAs5?=
 =?us-ascii?Q?O6XpXF2iLygk02qYa2XzG2NLc2kQ22Y8GYsDdesr+2cY0Y++eQpW4MFARt85?=
 =?us-ascii?Q?joLaafrED3Ijlpgzx1bvKne1K89EEIBVA6/HU82V1+fvkv6j7XxP3A1mUGzF?=
 =?us-ascii?Q?FynS7H9JTrKsJ1uuiulL1c5RPRqb7I0a8T5juvwSP1iZkyWiVwdqdvvyzc4w?=
 =?us-ascii?Q?XOj+sW+VZjBjHjSfvLRlPgIgnRw9Rb3N6dDv00x0wZ70zoIu1WqWulOEm4oy?=
 =?us-ascii?Q?+7GMSOGHAJ/gZYZ4vMvxHkrRc8EfZaEZe9d12Ed7Lbcn5FWMakiornjhB92B?=
 =?us-ascii?Q?g6vPc2FTDZIuHmLYJ4qAXmQYVOg+CNWW8NxKmO6wpVr9hboVXTaBrrIRzxTb?=
 =?us-ascii?Q?OGNd6MI3+NGorPksPDsJZ4JC43js8AZOl7GtifeSHtnl4pA3FpSvbebfPRrs?=
 =?us-ascii?Q?fSwv6EXoR5fykJkGdZRCpu3wW+iRbEKD+5fKpibhi8YoPpF56HrKtUR7lqsm?=
 =?us-ascii?Q?G8VlS4PnyM3pt34C/yQ37SJOaTymc8MuBbeqzbr1LKRuaw5GsqkJyPqJmf/J?=
 =?us-ascii?Q?mn0IUEJMVzk8I/67z2soVAJVneMuk5LRII64KaDyPMwmPUWHmOc69Sc+O1li?=
 =?us-ascii?Q?c7PGzpQalIufLLWS8oRAXVH2JB0sb+8D8uT5fVtbK73EPMghZD/koiLASbcJ?=
 =?us-ascii?Q?nm29C8ZamJPT9Ktcm9n7CWVQTz2Hw+BhMGiTye3LQQ4awjEnSyZJalPPpm6H?=
 =?us-ascii?Q?nwOtx5MEOT0lz2dCgSJZEnBq5u5BURkrFO6MbZVT7wlz77R4hV8cG/oPGfMC?=
 =?us-ascii?Q?37bhq/Nr9dTBILw6PJQYkmex0D3Xsxg4faXF3NCqYpPz9lwq/zAWi3H0+cN6?=
 =?us-ascii?Q?r2xjRgaPWd/uBeTXYBKjJa0bEiFvD20hzECBWg2Q0S5hOql5ARfK6swOa96Q?=
 =?us-ascii?Q?Fav1mF+QwfzbtfsCTuZPrOZEDKj3whqP/1V/jGTZnLXrhAxyq9t9IGaTaaSt?=
 =?us-ascii?Q?VyHHPAXxRNkimL+c8OfXW0agiKw7GdriAih8Ryl+XAYmjIHQNhvp9Hay1s4T?=
 =?us-ascii?Q?jLnJD042QB4SSh4S3icf0BGrx/zB/x0a20jPuGKjh74nGIlEGdsfHfOuKv0b?=
 =?us-ascii?Q?rdJ0BK7tvhgq7FSYg3gefkoDjnsIvgPIS8EaA/krqMeUDGs2j91QqUMXgQfQ?=
 =?us-ascii?Q?GWS1mpZYa7TBrIa7rEZbDArRAI4zTtcaqmXYyRXbKKcjHuvfVxPSJYe2vF9p?=
 =?us-ascii?Q?Wmr1TRN+iOVsDVIhlmVY/uHlDnhIVLE5foOKd9ecrwzYp+v+S5oYHL2Lr4lG?=
 =?us-ascii?Q?0gY69tLAbzmXyA0wi8qWrOcSBU7nxEjIFRc0jiLIcN1YZLFKGtzTPa4xGrna?=
 =?us-ascii?Q?T6fN4Sgg2aalGF4qI52Zy2tI2nL3OFeOpmrbpHCbfRmA5PV8glEGiUO+UtE1?=
 =?us-ascii?Q?JA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a0a09afa-d9b1-4ca6-3fb5-08dda2b79846
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2025 15:59:17.6035 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: natEd+NALi42cI1RoLlZIJRV1A6qvt3V4h5Cf8U5gTc9dUHZmRWwTOgaDRNDWhlQp/bAz9LcJ5ibP4I1crQ7DDRI7JHHEH0TBiBKz2PY+AE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5909
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

On Fri, May 30, 2025 at 02:57:03PM +0100, Anatoly Burakov wrote:
> In preparation for having a common definition for 16-byte and 32-byte Rx
> descriptors, rename RTE_LIBRTE_ICE_16BYTE_RX_DESC to
> RTE_NET_INTEL_USE_16BYTE_DESC.
> 
> Suggested-by: Bruce Richardson <bruce.richardson@intel.com>
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
