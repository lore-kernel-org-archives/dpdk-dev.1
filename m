Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B8DECA0EE8
	for <dpdk-dev@archiver.kernel.org>; Wed, 17 Sep 2025 09:24:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2C1634025A;
	Wed, 17 Sep 2025 11:24:40 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mails.dpdk.org (Postfix) with ESMTP id 03C2E40144
 for <dev@dpdk.org>; Wed, 17 Sep 2025 11:24:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1758101080; x=1789637080;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=G9rVZxK5agdJgim840N2m8N9jJsBIvvmp3US9iwnivU=;
 b=FQR27XUQrBFWJzKlOg4wiofF4XvjMXBMRPzV138C7a1Tq8Qswr/8LEmA
 Qu7a1CRlKXTBKcnx06xHZagTF6IsAEKdzdA3SR5mwSy+fWkcvh+KxzDQf
 3eZuIdbXHQRqvCFGQoq3nPC5eS0dyaC3taJIvwygOc6QFZwvLbT7t2dsL
 GLPMhbc5PGzFLkcGSZS/2OctCb6TJRdvER3u+OLCgpy3OPQVU3xMk12D8
 l1m2pQ724OF4PaxWhBPONwbeVwqvaVHyc5bL3JFxEzjWs3CjUpz0OGpyz
 uNtfXRcg5cRkeneHe7UIlI2e4a5/OUNReWMU37kcgZmSxFWCbtqkGAyqG g==;
X-CSE-ConnectionGUID: o/zuV651Tr+WrU8GGyHOVg==
X-CSE-MsgGUID: cAEOl7eCS0O4jmXvNt7ssQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11555"; a="71504588"
X-IronPort-AV: E=Sophos;i="6.18,271,1751266800"; d="scan'208";a="71504588"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Sep 2025 02:24:39 -0700
X-CSE-ConnectionGUID: X4D0ck+IRQOzquekEB8sCw==
X-CSE-MsgGUID: Gk4mPPjsSSyAP6fGCSGGsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,271,1751266800"; d="scan'208";a="174302521"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Sep 2025 02:24:38 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 17 Sep 2025 02:24:37 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Wed, 17 Sep 2025 02:24:37 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.56) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 17 Sep 2025 02:24:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PgrxF/uXVD0k0ir5hpIw4nTf7KGE/HbzTBEV68yvaJSrNvJLNhFUbSyGgnYZrRmthTS+YuzR7XBKzQwU/UGoj9D5v/GoO684RPCJkItZGUsaS2wpZOP73nZcjlW0X3z069d0k+OEgZgAcxl9CrYRiFxTsMZ404eR1aSARsSQ8Vruxp4HTfvz2pveuSua25YqUMP1rouXT8I9rDlxQOouSeffhu3LYfYIgOD7snZFCmy0QWE6cxaQDHHwDA42seUQi4Pun3+Ud26s/zMgtQBVpsbuCbofS0ou8iSSYchQnKGNgUWlazZ4k2aTnETTfFC6gU213SAMZwm5uqiir4iSNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b3ywwfU2w6mEq2AQaa2aJfHmmsAn4WsNVV3aRGEU0aU=;
 b=MLrgqeboZ8fhahUf5RpAhnF3JGkJLoWuZqiSzg1BWF93NCTLIWVdruz9Tq9Yztzw6BCjnyF1M0IVb1zpYstYG/7030dpYESUowJBMZqRpljbQz4SvqEQcnO+quUeRwrJ2k8LOpd6qpyobzgWNMM+wr1QnMo+ij5E6iCBykJ2AC6YjvfqZKEDZtLkI6y6dAcFpZu2xukoBI+XpUIOXxMTzhSJIE7sdr9JmH12gQQpRWSQl12Rlb0KO62q1w5cbw5qwplpUe0weNJ4sWmmzgyMDuVgOAj15d/+jyo8RIsjYAXrqnHsO6Ve3bwT/vvpKHhPXNw8gxXSWLEa36woNWWUXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by CH2PR11MB8780.namprd11.prod.outlook.com (2603:10b6:610:284::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Wed, 17 Sep
 2025 09:24:34 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9115.022; Wed, 17 Sep 2025
 09:24:34 +0000
Date: Wed, 17 Sep 2025 10:24:30 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Ciara Loftus <ciara.loftus@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v2 1/5] net/intel: add AVX512DQ flag to AVX-512 checks
Message-ID: <aMp-TiprZqZJiMl5@bricha3-mobl1.ger.corp.intel.com>
References: <20250911143145.3355960-1-ciara.loftus@intel.com>
 <20250917091731.3632520-1-ciara.loftus@intel.com>
 <20250917091731.3632520-2-ciara.loftus@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250917091731.3632520-2-ciara.loftus@intel.com>
X-ClientProxiedBy: DB8PR09CA0012.eurprd09.prod.outlook.com
 (2603:10a6:10:a0::25) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|CH2PR11MB8780:EE_
X-MS-Office365-Filtering-Correlation-Id: 8455bfa3-4d84-48a4-5805-08ddf5cc0406
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Izj1Bwn8wzZqk0eU3/+yK5EKuHzAxhbfRldKzTWcj0VvcH4gQxlZpKyYT+V1?=
 =?us-ascii?Q?sfnRBOPNCo5fydtuyonthoRmLkhGraMVYTQ8/aXIvQ8Bm4KDZJCA8wRV8Q5d?=
 =?us-ascii?Q?YGjd9c8/LKWC6Wjo5viFS/7tRvlFayy7R5N39NILNIQTmONeDUc1Ka1oCZ8S?=
 =?us-ascii?Q?C1pzcOZ85XbubBxgbaMOujfWVmhoKs0APVITm8QzV9Jxgn9fqjOekK84Cr2b?=
 =?us-ascii?Q?35g9Nc0Z9ISKE8GXmZINEmK47J3TS/mbq1mxc1FmekSguZVR+5lExKG+Uv7W?=
 =?us-ascii?Q?YCvEe/ErHL4g7ErpQkRBfc530jFQvqGghu/y5Z6MaRxV+YaCZBuUYd203JjB?=
 =?us-ascii?Q?SXBWHmD1aeWowzYLEedFMOAnlDy9/5p4Ve6hH/RoYxGPEqKSjpU20ef+p0YX?=
 =?us-ascii?Q?a+WRCk1k4yH5JJcmGNFp+TPa0vkomO1B9X5rByHXJ2t5Y2koQ6sIzyLSAZ8a?=
 =?us-ascii?Q?vzmfViBtMXl/NIi4fXatdWdt82M9WR0Ntuf73v2ZGXnjelTnkV3bMT+wwB97?=
 =?us-ascii?Q?ytEjKj6WnbgZdgqDuE1aFrA+zJaN70etshi28jOrd74ATSBZ5UV+4rAvHldG?=
 =?us-ascii?Q?IGuSJtCrA/AcYocax5atT82i+vtqQc/0DinzEadBNwW3U7R4KHhWjz/cKsEm?=
 =?us-ascii?Q?VJhZoRhRVrCGVE2LHMhpxRhEzHCvVO7KafnXsf017igXlofobctKEHMuQ7Qd?=
 =?us-ascii?Q?mLMcRa//Oj+pssj9EM9nt66cktIjCN6+XevPY1xBzvPIdTQP492MBYl+AJk2?=
 =?us-ascii?Q?e3TCIJYu/Nq0J9oZYtVK3fILjC0NU75OOca7ewXjJfQrNTFicJy1ZEeyXcoj?=
 =?us-ascii?Q?36kyGRT6Onyxf8+55221S44qsTHJQNSQ7vQeRlNzDmpd3R0Oxq0ixPLmDzuU?=
 =?us-ascii?Q?1CB48c9CblERFIkn6JRcjJd/8c1eEtSXcp4ddQ8VeA+KHu/0YLBlWN4M+YA9?=
 =?us-ascii?Q?7YEKikxfpUKXG/0oqHlCzL8AGkLVTgU1PAcnkitLUnEE2makF+yi/77ZBt11?=
 =?us-ascii?Q?GnCT8GnjJnPcHRxQ2ZqFIx+M5EAVk/RWhdA60hhIYOUz0v9dWow9iQdZx5N5?=
 =?us-ascii?Q?NGrHQltVanF/eU8skKrAwAJTmpZMXgsPg9ou+tu3Da/VhWlxmER8gdEbWmfQ?=
 =?us-ascii?Q?GbUh7AJsg8XY9/hpmq1C37IXhFNIUeQsjndry9iiT7V0YnfkKkrDKi+2JbKu?=
 =?us-ascii?Q?0cqbVXFCK1rvMqgd5yEetEZsEGygYJ1N2gUrMNd0eCF4kKDrqM6RuR34m8K+?=
 =?us-ascii?Q?pVLswW3SHf6ytDUcoTrQtM7ggjRLM9nmEQI7rS06wk0pUsGNZtWbFYEJPbpM?=
 =?us-ascii?Q?RRg7NnJnI1DP1G2LjLOvzLiu+P51U/qq8y7JTizR7DQJQ+PWvzuM2RNrAAeo?=
 =?us-ascii?Q?HPOeLlgdqzaLDBec5wAiMMgGu0nXcr0akI45/wWqNv8vALQEa4+NcFyWUHnL?=
 =?us-ascii?Q?0O3aBP1oBIg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oylXVSm/NIPBsBm8m+L2bbQBDvMrhYfqCc9EOYm6+iUkM+FRUaQuxDL5ERV7?=
 =?us-ascii?Q?+QAvE8RhdY0dumk427zUNIPIFu2AL9zXZQwVGJDtwSfsU4DDqw2A2vZqHcd7?=
 =?us-ascii?Q?ZPeJI3HJSxKEkuQTSd4Bku/qKyyNcwHoHAXXofgESu+Q6Hk79l4/n3KPPbPr?=
 =?us-ascii?Q?8rP7yuUsJCKJu+q+avkoBba6DPHuxiSZ+cD5JkWhLOMDA8zAPuUbcxPp0Mbu?=
 =?us-ascii?Q?mJ8U3jHjQBbdR6eepKptoMVP6FbDXOt1VeHo6VBFTtPOc2sabWhfzQISvsIV?=
 =?us-ascii?Q?Kc0116lFJYe6AjplyRl2JMyEp25wXfwRDup8cPpBj+FVf8XkgTEZwKAh5GIS?=
 =?us-ascii?Q?m+WFlEMI4G3gVArHRkP/mc+zS1heouCnFI6gD8uNINeZ3qKrl0x1aW9g9zW8?=
 =?us-ascii?Q?D2jvjC921Fv/S6VUpVBa/rcNhjd0hznyPr3x3ibguBi14DUmHggc88FG/c5o?=
 =?us-ascii?Q?hkxNoPV9Vn7DfvOuR6SW0T2F5Bn+FTdMFyw8r5Gvl41rd4PaxtYscA3kL1sN?=
 =?us-ascii?Q?G6ab4iMLKPweuJc/klxx3d9zTbo7XuFRJFSH67djtbbLaZ9Fo/yC9WevpPHO?=
 =?us-ascii?Q?2QKRgudyqPwDOtKIn4of2yNzMzInPPDXwPwAgJ48BF2crLy+mWQNwGz7p/eA?=
 =?us-ascii?Q?ASToXsF2QiOq5EfgeDcHtMFbU8iVoZpehzphqnyAucrDsqKuT7Xe22hloIFI?=
 =?us-ascii?Q?4yQsmJmM94ww36ink2tbdaDQi4uoJh/PMdtJvQhwfP0BEkySEpzhtNE34Zaq?=
 =?us-ascii?Q?KLSnpUEFboS0rmCirN9eZ17iaCAlmuraTIlyPa6J88bUgnSvAR6Tb3s/haNa?=
 =?us-ascii?Q?WxHWDuAZ7PDCaLamCEtMdCuzbvcSIjWiENz/Wh7HZe2777vNOfPmUKWnTDeM?=
 =?us-ascii?Q?4lYHnDMILqzv5TzMxGmn4zssRhVJJkMhxopBJbRmuosGCIgdTzFPRio0B2EA?=
 =?us-ascii?Q?t0AY2J4hcHsvLsTKFjR3Spe1KZfXIYc8MfceiD5RjVfLQAy2pm4bWNy7qojq?=
 =?us-ascii?Q?iFJtSqvsFf3DzGN4/TG/OSkz3Lh+HMhi2hRBELRckyCQja+xyJHGqPJfjl/t?=
 =?us-ascii?Q?SlZ+tIyay0pWlra3ry0KRKVjUeAZGeUI/z0J9iMyUSj5LBuYS0Mgb5KZXWP4?=
 =?us-ascii?Q?JY2NquYaQKmFBas+fP7LVF0yUvOmVXgbLoKcaCccbgt4IrP28+vewdfhYQmm?=
 =?us-ascii?Q?wM697NyGUyOL12JSRCqwF0V0ySkgjF1cfG71QfupQ8Vu/TDe+JFmAxtuQS9O?=
 =?us-ascii?Q?Bsk0olvGiLOkahNaeSnDg60Bc1Nryubdb1c1ogVCqApxkNiov8mIT/G/YF30?=
 =?us-ascii?Q?jVPAfMdqgf04l06d3LjkoOb14cTPPHoVae5UJcqttK0qb/EQQgmqItXDIORD?=
 =?us-ascii?Q?cQ0mHMcPsh8xhgx1zmo8hkKQbZJ1QOHpftMoatvW2Hv257iRMd+AGpJnhMRa?=
 =?us-ascii?Q?c70LBwwACE0fY5n2vZFGdNOi0yhc5IdYQWBQS8QGJsXIt+oiYs8GDgyGOXan?=
 =?us-ascii?Q?I3cGpeDoE+FtXsRDeEr42g/AGqkugEr3bnKRoNYU7uMbsc+QN+NLPIlOXeeI?=
 =?us-ascii?Q?SfCnTjyi2dyF8fBe6hGzWAuS4btuymD3z5zjOl0mJdrKowHRuUDe3VBaqj+n?=
 =?us-ascii?Q?Xg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8455bfa3-4d84-48a4-5805-08ddf5cc0406
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2025 09:24:34.7293 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lMZ3dJui9F2Bjjq2PB9vy1JdMHWOzcbF3ux7+NKr67KAYJJYQZZNu8LocaKUQGJlSatrwbcwtdkx9WumY7/mU6Z2UZDCNsVkBH/2rrZyNKY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR11MB8780
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

On Wed, Sep 17, 2025 at 09:17:27AM +0000, Ciara Loftus wrote:
> Add a check for the AVX512DQ cpu flag to the x86 vector capability
> function. This flag is required by the idpf and cpfl drivers which will
> soon use this function during their rx path selection process.
> 
> Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
> ---
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

