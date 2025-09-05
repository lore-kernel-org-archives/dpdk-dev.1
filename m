Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB9D2CA1010
	for <dpdk-dev@archiver.kernel.org>; Fri,  5 Sep 2025 15:05:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ECFAC402E7;
	Fri,  5 Sep 2025 17:05:47 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by mails.dpdk.org (Postfix) with ESMTP id 92DF5402E5
 for <dev@dpdk.org>; Fri,  5 Sep 2025 17:05:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1757084747; x=1788620747;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=3tTGeZye1fEVlKNgodLIuKt5+kb10n4/PMZlWk4EKdA=;
 b=ZqNXsukIhWHgATlrTuqSOB9IkbsgeEqmClbhwqD/ThTfOUcHshDYkBSN
 Ff0Ru1POYU8UywlFMQXjb1KxgrKE6fh6n5SnoyznG4m+9GJeknMbuYaZs
 kvz/YL+9kqZLS+py/uspbp5gwUAawqHIYEVI4WKh0t0xsrU1VGwVnpwaS
 OyFNW1qDb4kGFGUFr1nCrqIi3gL+qdDPyJstsfPEQ944y5t8u+dY5tsZN
 uPvxDDO6mgvVtndV/wyODY2UoYftpM/eNsQ2SQA2yR8J0nZtODWhDROcf
 JRqNe39o8buyvA3CHLk5DHzMObPktjoSCSwWfP4ho4jzGVaj0hVoZwXlF A==;
X-CSE-ConnectionGUID: ecSYfADIR3aeFVsKR51coQ==
X-CSE-MsgGUID: 3P97dfNzSOmieFxYMXSetA==
X-IronPort-AV: E=McAfee;i="6800,10657,11544"; a="59135633"
X-IronPort-AV: E=Sophos;i="6.18,241,1751266800"; d="scan'208";a="59135633"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Sep 2025 08:05:45 -0700
X-CSE-ConnectionGUID: o6axcRtYRna5n6Nwh5JwUA==
X-CSE-MsgGUID: 5GMTTmD7QE+CDJ6rgs3Tuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,241,1751266800"; d="scan'208";a="171748383"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Sep 2025 08:05:46 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 5 Sep 2025 08:05:44 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Fri, 5 Sep 2025 08:05:44 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (40.107.96.55) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 5 Sep 2025 08:05:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hoWFIZaqMoQl8znoxN/7cCF6y3RNxeEoh32/K3XvNjwFQ/5NASrmqYSwwMHs4tZEd6oGn/umPymOIiNkqqA1Kx9bwpDEWWW8i99phPQvIdBreNnc4/uraelqOd0E1105KRD7twTn9pSyNEAmnhmq1mf0lG73jOSm1wlgOk1mpakTxKs4CJoxWXJpknpynKqHnOb6uel9IR++kWqRlEqXK5MPA4Wz5T8qxkQCoFMe/DMxKNAYr/E4FcEXfJpaZIJb39Djap4lG5L4Lxq3iKweQbyKUqZWOvmH144lnMJmS8NBqQ19QDiyAHKqVzc0hUwygRZMwEFC14cv4rkUtE2EqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BY8DI6P7JyG3yhYeNn4N7SnqdHVLXxJNeLM0GdqTln0=;
 b=CaCBBZLbUse8jRgJ+T8ZyJcv2ghlXWoXPuOkrlok5SB66/cLq7daehPN74SdObGHq6ziVF1R8ZOKfNB08AqtwKelRth81kSmdyGuRumAWoxCkMY7Wkk4HjciIfazSxvVKfiSe2+EU+f2/e0GiCMy+kSaj3bH2tMNCCmsKnW3HsAlUxVNyDbFDYncOFJD2g8qTnF9hQaqHCO/n0X8lJkXUF+pv47TREoEmRPNc+r1ZDpIeRiCkRuiNHu56zM3P42Ixu7VEyoEqvQ+C9k3+qLpKqX0GNcDm9W6/fR6V2xJkvDvYOvVFygGaSZEoN8KDatrvQ/KaCNQ0QFbtoW3Si8nbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by CO1PR11MB5092.namprd11.prod.outlook.com (2603:10b6:303:6e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Fri, 5 Sep
 2025 15:05:42 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9094.016; Fri, 5 Sep 2025
 15:05:42 +0000
Date: Fri, 5 Sep 2025 16:05:37 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anatoly Burakov <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v1 01/12] net/ice/base: add direction metadata
Message-ID: <aLr8QS7ITUV1jnTt@bricha3-mobl1.ger.corp.intel.com>
References: <cover.1756833701.git.anatoly.burakov@intel.com>
 <cd2a7623f02e88a0aff0200a41ad8f4de7543f57.1756833701.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cd2a7623f02e88a0aff0200a41ad8f4de7543f57.1756833701.git.anatoly.burakov@intel.com>
X-ClientProxiedBy: DB9PR06CA0010.eurprd06.prod.outlook.com
 (2603:10a6:10:1db::15) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|CO1PR11MB5092:EE_
X-MS-Office365-Filtering-Correlation-Id: 83691012-30ad-4865-19c2-08ddec8dae66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?zptG12tCsmSpd5rtVoMIj1Pld7usWm7+uqd1aEP1SNMDjhR/8Q53kXZ6Bs9f?=
 =?us-ascii?Q?1UUMdjB9kA1yWxdccEVBBVzTFvc4YYWTiAF75Bps9hONvoogyrrltzax4+NX?=
 =?us-ascii?Q?JsoN2cKrf8evzaREi66UOcknQtqFrThORqp3nFN31f9YV60pX55yPyfrfjFq?=
 =?us-ascii?Q?08x20KHSXBb+NMpDF3XglKAlfbclc+ka+B9Ji/qzodYdfq9RCroLMBSElsiA?=
 =?us-ascii?Q?VoSokNGKhDZw/0MSO4XFYZkZuJ5IX1V0LkBeMJ/LY5c3JdOWLIyX8ILEbdAI?=
 =?us-ascii?Q?h1InSLCfHgpygV036i1xcV/WXXPnPHTGQ4rGfPpssHxqt0uOTh2n3wiJWI4O?=
 =?us-ascii?Q?8Ii7lhBiPw5MiSL+opVSxKdlSjBoyLSCVnKT6oTHPRyLtVy1dK4rC6ivevHM?=
 =?us-ascii?Q?O2PlAiVrOJUABTI05RFx0AMhCKhrR59Z2E5dvUMx/73o4efbaTehhji26cJk?=
 =?us-ascii?Q?Lebp31sTdYsULI+VlmDnk6EC247Orjkl5Aw36V/cyrUGjMrZZWjC7qsWF+E0?=
 =?us-ascii?Q?u9kxPWsjqK1OiVLInFOogjbCvDhgRRu5yZxyawuuhQ0rBUZftOunguZug/O7?=
 =?us-ascii?Q?KhOzUYOicrMsBuqx+YSycXkyVPprSupkRnSCpngiJk6uyMay6PinXCBQC/V7?=
 =?us-ascii?Q?ARmCZKe2504rfBiitJVE62bRqGAhRbV9NbaN2eUjU63Ll13hrBfpLal0zh8P?=
 =?us-ascii?Q?nx9Mko6YdbT/+c2J6bhc3f1j8xq3EEBW4hzXQW/5f1tmi4n0NtyKHASVeem/?=
 =?us-ascii?Q?/B1xgjDOBQzFB6wN6Oqb0RUXd4YRkGhlj5SyPub3iTgjIBpa90bMxoc6sY6o?=
 =?us-ascii?Q?OjRlT6Wtno4W83lPZUt1lmB1BNITHNqVoN5vkWFnw47o1ck9ebl8+CVTe0Yr?=
 =?us-ascii?Q?Aowe1kjNvl1kOzQHjYXI26egyx1rYpF3cg3F4EBUAEeDMdR/JbpDB1KJp9QY?=
 =?us-ascii?Q?OeIYutyzXo3P6KOnjwrrL8IShsDJEDYFpLK1D58Hycr34MamXlklAoTqEo7Y?=
 =?us-ascii?Q?KasM3DI0IY31vAINjMg6mUG9c+KuaHQLFRDkBLZ/j2HWmaXfEM1qZwVUvW0k?=
 =?us-ascii?Q?XUpCfMwnQgTqeY/XTvXEbvlLNOFvAiAHTvhzg6MHSXS06Ix+VRL9kkegnvqw?=
 =?us-ascii?Q?fuWgpaxrnm9Igq7oTI6p85fPcIfcE7a01dH7yeRSvQUEPDihboIIA0yW4BqX?=
 =?us-ascii?Q?Jh7m2wIDdSB1i26GT9K4T3fohWMixEePW13j5BgIxDlUFW+m9yikbSIs5P80?=
 =?us-ascii?Q?IZzarkCpzGr0ltyVpkqcMtwSvjoaI+MnGitNW4nPCuHblD+7NPuI8YExAdfw?=
 =?us-ascii?Q?yG99RdmCPkMCm7PGwHOckppVlsHx1QwAf3NLShbqCDNWHaxSv0FmkJ0L+sxd?=
 =?us-ascii?Q?AaFjKyYS0prE1XZFCTtVgwTJQOcoTxyaO7sOWZJfpBiXkmzMjw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VH702Oj1dXOIK8H962GJXdPl8gxAiy3ZcMqYFvOHRbZ6S2BkFxwLXasz4yBn?=
 =?us-ascii?Q?8H3M7gQMT7P3Bz43Bd0Yy+Ocdvtn5VoPLoFNe/mQ5fuMa5V+/gynbEQ3MbFH?=
 =?us-ascii?Q?7Y4qt7AnQeUYOjdxSfW/uhqZ9WO5+cPEIk+Kel2THBoj/8FTmjCQKYiK3pLV?=
 =?us-ascii?Q?QfPItPpiQsjyY7QlxgSQfaOpsnO/+vtAvUvZayJ5wDM6uvYGnA++a4iWUKar?=
 =?us-ascii?Q?3xRhimhPmSlFoKf4epg+Rv+fRTQg2RxQKD/Y0/B10QOugAK0W/NDOakR2oAI?=
 =?us-ascii?Q?6jkdP1ItswepKyeabSne7brgjYQCcLEMnVRIyjoMW3xTE7jvuirpCTXBmFpN?=
 =?us-ascii?Q?5cLVleleuWd8yUY7DQYj67cg77YRulv/eAmG/28y64PZlIf3YGrnaWV0vEHq?=
 =?us-ascii?Q?y5DLkw4jCMrraCyHv8TY9SgWA9zh5H2PBEfs7N3P8351g+QCTRrCJJDXieLm?=
 =?us-ascii?Q?8XLFKvCxbcxYMwo8fbuRBuDKY4hdk7JEBr9c5NU2N1KwBvoahOk6w67TVZcb?=
 =?us-ascii?Q?N8G6SsBZ9YiIGW10DIUO9Ts/6fhSL1ieZBC/ol0T4DDiysLdtaP3LN/j+anW?=
 =?us-ascii?Q?prtW/Wp8/GI0sfd2wa0wzbJWyMaG+upvsGrW/hTXUkIAhYqhu0WqMGqoNfOL?=
 =?us-ascii?Q?IWQbdz9k0/6XssIC3mkvPJndvxa9h7DnNnT5HY+aHRIAEiZXuItFUSyEVnMi?=
 =?us-ascii?Q?ihpYD7CKqtOWo1vMlXgzdFhtaCbyuazxzqhGhXUTho9kgo25o4an9/pPzTis?=
 =?us-ascii?Q?EQjIGjUoQx+G4AGEYEqxro9j1dLSMW5nO1qv5updvgdwc9YcHEzL1vFzF3tg?=
 =?us-ascii?Q?oybJIriyGmRDH0S39jFFR21OI4tTz1VdJ17vMTwt8lAyw+YYUrtlpcNIvyOk?=
 =?us-ascii?Q?v/q5KQ+84u5UmQyNpwzNg6Okc1QLJaSKemQmPmZroY2IDN/nwVdbGUNM81cH?=
 =?us-ascii?Q?cPV2FGDkaB9dGRwumbqCwL43qYPxQi2sGFDJC1bxecTMM3uxQvkmPliTycV1?=
 =?us-ascii?Q?RXkPQS499a8RngT6r+t/TG76sv4pZhw4mXbk7KZsQSwihlIQd2vd+IGNeCob?=
 =?us-ascii?Q?sIGzs4b9m0ZDwPv5nznnBH5nkcbLLd9fdNFGbwg0c+6db2ZgWmhCxe73r+9i?=
 =?us-ascii?Q?z3a8gqjWLa4lQ+/RanKKDfjNMXj9XlSeq7I0R9qxd7eaH74XLuTX2zWx5bYc?=
 =?us-ascii?Q?7AL1pg04cr9/PmvTcDnBs/smWtylEnhJxSZnPUfOsl1eJ1ddroHUXUOZFFU+?=
 =?us-ascii?Q?NpnuBImXTC18QfO9TyBxT3ZpSoVVslmb3y3ekSRKeMNbm06xiGArN94+Abr/?=
 =?us-ascii?Q?dwj3dfPtGpElJ4R+tNZb7ltSzVXXW5KhoWZBcDcidkYYYlFz+oPm/ImZM5ZA?=
 =?us-ascii?Q?66F6GOkKbi3Vne6Km9DPAPibCMMn0W3YaxVhPYfN9h98T5HAZilnh5Z1Mglu?=
 =?us-ascii?Q?TCthFB5hW56xgnNOGEPC+VC+uWceky2UMWLUtXEaq0WhXhAscAcnHikNnKOL?=
 =?us-ascii?Q?BF+RUiQRrF6IgThBCLfR7RBph+PNRDJMeqmnluGvJF5WdVLONz4I0s0LWguJ?=
 =?us-ascii?Q?pGHxMQ9UhDC2hOtoTuKUbP/DRPTxhtWuL61cz2LQ2mDF+Gj+o1dydGAW1Wgw?=
 =?us-ascii?Q?5Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 83691012-30ad-4865-19c2-08ddec8dae66
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2025 15:05:41.9559 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cthjV4ydOtl40BWKG7O2UNR/IVi5x/Wt49wzi15fXR8/9ckNG+7ICMDevicMeFpBqB3l3t9P6yGBZHhJfR0E/lFqtDOFjDG5QTwE8vBdqUI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5092
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

On Tue, Sep 02, 2025 at 06:26:51PM +0100, Anatoly Burakov wrote:
> From: Marcin Szycik <marcin.szycik@intel.com>
> 
> Currently it is possible to create a rule which might break Tx traffic,
> because by default all switch rules apply to both Rx and Tx traffic. In
> order to avoid situations where Tx traffic accidentally matches Rx rule,
> always add direction metadata to all switch rules.
> 
> However, because we're adding a new piece of metadata to all rules, some
> rules might get too big and be rejected because they were already maxing
> out rule capacity. To avoid that, we will only add direction metadata to
> rules that are big enough to store it, on the assumption that if a rule
> is already big enough to max out the capacity, the rule is therefore so
> hyper-specific that it is highly unlikely to match both Rx and Tx
> traffic, and so the direction is implied by the fact that the rule is so
> specific.
> 
> Signed-off-by: Marcin Szycik <marcin.szycik@intel.com>
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---
>  drivers/net/intel/ice/base/ice_protocol_type.h |  1 +
>  drivers/net/intel/ice/base/ice_switch.c        | 14 ++++++++++++++
>  2 files changed, 15 insertions(+)
> 
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
