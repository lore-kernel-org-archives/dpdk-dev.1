Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DF19CD5BB3
	for <dpdk-dev@archiver.kernel.org>; Fri, 22 May 2026 15:10:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 70F274029F;
	Fri, 22 May 2026 17:10:38 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by mails.dpdk.org (Postfix) with ESMTP id 88CBE4003C
 for <dev@dpdk.org>; Fri, 22 May 2026 17:10:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779462636; x=1810998636;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=EJd/SwzuzR5978NFrNW0hkRcCRi8v9KcxlmoQ1G+1vY=;
 b=Zx04JSzyOKtU1uUqpnCJC5N5KVhoYttbogillvPOG2EIQgo4l3eSSfNW
 lBCUkelxPe2I4hjrmXxIcqkZWBHKYOmIk5s8NE6KHvbLmWRSO0ZMwf+z8
 8NcZRCHjIcMqFxKcHA0gL+m0rMMQ4heuvL09dMGM2DtVsmTaS9upZfo+0
 sgeHEnRxdQjcF+qboqyfgMl8Px0stN5mcC426mmauPFx0UmVAztCieHtO
 icG8LPmyOu3wUO1fpgtBTmTXxHcq6N/AjAAIadyeiP+542ahJ3AiWr8zc
 IjwWSG1+iOsJPqQQEvc6AmS+Oa7lQ80EGlhz4cCLebuoCmZweYjmOCH/0 Q==;
X-CSE-ConnectionGUID: qqytClbKRtO/nklYfNIz7g==
X-CSE-MsgGUID: FjPLSKTpQTWA1rhrx4vlKw==
X-IronPort-AV: E=McAfee;i="6800,10657,11794"; a="80297329"
X-IronPort-AV: E=Sophos;i="6.24,162,1774335600"; d="scan'208";a="80297329"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 May 2026 08:10:33 -0700
X-CSE-ConnectionGUID: 2mOT7E0UTL+xcvj3ci7oGg==
X-CSE-MsgGUID: mI399KoJRtyh4qhxSQigbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,162,1774335600"; d="scan'208";a="271283088"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 May 2026 08:09:51 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 22 May 2026 08:09:50 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 22 May 2026 08:09:50 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.18) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 22 May 2026 08:09:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NaO64I1sY8rXbbRV+ZXrHMx0sQ/d7D9dDbtIbXm1DzrmM299Pb54EUPogy5vRQZ9empSkCyemIfVyFm/NgZpPK86uSGrZDBoYdoeUpb68bYah0p1BP5uwXYhEJQYMwBvTSPjX6T8KfvfcMXt0Q8nT1PpcV+hTl+e1dOcp/XK/hKzqX0meMufmPEJqgqZmRXaic0TmGLTlPvQ0mlgEN9v6X2X4+onDR9nzEGsBtl+z8AYbdqOsZaJDaoV8qQOpsDqWeyxaCGEsla1VTU55MVEBvkv8zTMcJwXGXq6m0mPo0UDEt+ZyX9+P/eohoFjmYtH1+bEBqe4jxI3XQBfnMxzig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eyRpcMejObjbN4eP17Kf+higOEpSD2g6XMGwo35Mm5o=;
 b=nAUesZxK19CUwREr3PRHumKpEarNPvBSfiEJZdPzreYnpfSQ7bB484gXxaiS3HwIDCPkQurUFqyirdieV44PkbdRIaW2SDcIBvnv9dok9Wq8WUHMt7ozOSBqv9OwGhrnUlm8Ng/sWFX7SKkHogvp/XpQuWHfUYMIPB9UAK7sdd6pifmYqpIiJ6jXS3v6hEqRieS7gij+vQGWxkRIUFC//ARYYYa9xLFL6qtxl138KCRWASrbTP1c0wOrhovSZuNSNGXt/sR0SfvrG91VXn5MICyMoR42n8zv82TA7Bp2WgWZ0xk3KT77fKpvJZXT2vY9aoMUwYDhTjjkK+grDOJaoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by CY5PR11MB6438.namprd11.prod.outlook.com (2603:10b6:930:35::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Fri, 22 May
 2026 15:09:47 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%5]) with mapi id 15.21.0048.016; Fri, 22 May 2026
 15:09:47 +0000
Date: Fri, 22 May 2026 16:09:42 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Soumyadeep Hore <soumyadeep.hore@intel.com>
CC: <manoj.kumar.subbarao@intel.com>, <aman.deep.singh@intel.com>,
 <dev@dpdk.org>
Subject: Re: [PATCH v2 0/2] Update IDPF Base Code
Message-ID: <ahBxtjkwdaxXSyD3@bricha3-mobl1.ger.corp.intel.com>
References: <20260509015408.29188-3-soumyadeep.hore@intel.com>
 <20260520220306.85273-1-soumyadeep.hore@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260520220306.85273-1-soumyadeep.hore@intel.com>
X-ClientProxiedBy: DB3PR08CA0015.eurprd08.prod.outlook.com (2603:10a6:8::28)
 To DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|CY5PR11MB6438:EE_
X-MS-Office365-Filtering-Correlation-Id: 73fc9e4b-516a-496c-4d9b-08deb81429af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|56012099003|18002099003|22082099003|11063799006|6133799003|4143699003;
X-Microsoft-Antispam-Message-Info: hLc+KL55sFYXPrkiisxIBRmi4vEbr2bRRmXBu6epEVLkZta08gjr2drhy+TKvhNMXPU4iFHS9p6BpSR7PsrUe+CIzccXm3H+h5btcAOY+OZp9gSbsAaY0bMV/9lE0+hxIa65e385bmZvz9zljYwFz/WK/ZI2Ed5p7hcAjhNFinAFqModhdeCXyYUHPDc6k9EMLix8jEuVbPtoiaAKAJMV2wQK1eJo/CGBt4AsuFG3OZJ/yShWsbq2xMSA/9XGvhxBjWu+vr0z2GL9xz/Q0jpG/g/eVyOYKS4vQLbc08TE8WLgRa3WDJ1KIJwzNT0seVn5k5sFDwlZoM2UyMMxyCA34aDoHYr8KhLxbBl9Z27GJX5im0Z71x0haop4F+/P6FFH1foDdNxx+CXJz4s3AWEAZMwic1VtoMEERO8MVZffZ7Va6WbArJPDqnDaqO6pwy6deBQHrUg1p6aATg1/7iyUSIN+radzCVktNmD6nSATiY1WVO9UlUVlpwQrzkwoWXyG4CQhRG63u45X7q6UJotLDu9RYtdLBWSI0NwqpLG0LdVnBqnI2gtrss+t0FnaJanvbIRMyVauOENHc17HOJb2R2a00qMhpCl9K5PSuVVWxRds3kO2fBsrOxIG5nvPS3hfm5Y1oWKbNRmqL8DTrig4pLeT9HiReUGAju3GiMIQR8EiWr6vxT5yBZ08rzy06ze
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(56012099003)(18002099003)(22082099003)(11063799006)(6133799003)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mGqAYd0qZAAgf4kIU/ddDCPhISaUwJ3Kvf9aUl/FT+43OHsG6O13kG+c4wYu?=
 =?us-ascii?Q?OehN1LKyoZS8OPSVoHEKxT36SAieHRu9EgFP1PFzfXHrgJBDqs06mARZ/FYT?=
 =?us-ascii?Q?CyE/Jyyggz2aOYPXm+Ot4qiLt892ETVtw5CG/amnGg2zYfeHCY1gTGE2amkF?=
 =?us-ascii?Q?77iiI6xI0FLbAcvWHQCb9vO1HyTtqWwSaCuCIUmgS1Tz5aBlz2Wm36ZUWyjr?=
 =?us-ascii?Q?Yhn6cZ4MKEh3ZHGXG3irBE9wo3JPAS8KDMT6U7NYnywIMWHYx/YIkWE3w779?=
 =?us-ascii?Q?GQW5SCcXSVEd4Peg72LpDRlJC7SCGS0o5aLrf1lKhTaFUdbLqH8WYqkHcOb5?=
 =?us-ascii?Q?qLmpUbUo6h3NpgxVof5PDTNNxUiODmW4CFmtopABmqQVZh+0SqbJWT4HWiwO?=
 =?us-ascii?Q?pjnjrsAeu9KsDfWRjnS32hWR05Heub7hlbkTdwQaeZOpe3l81lcF9Q/gtEDL?=
 =?us-ascii?Q?7fEJDB94tSsy21ULwag2nMTPXjth3oG03wN/vr4iFZrf/+0y6Za9GLIAslXG?=
 =?us-ascii?Q?hxUhUd3alSCYZldeFwy39oK3dMX17yhgNVHEpSXy3+txBaNyLUHEPTxy03oL?=
 =?us-ascii?Q?mXzhfqR/5N5ajQigE53R6yEK8GCwGhVo5o7Gr3KTNwhNy+EYYfAoeH86AdaR?=
 =?us-ascii?Q?2ixGhZVfJI59bsXtIG4bOfC2BVq1eDXfecHmTGXrr6ZKJhpu6Ql2G84OScdv?=
 =?us-ascii?Q?ak3pxLSBFOkUqVwToCC6iKXb/IpeK6Q0894+kZkFLgSaRNswEaf7kRdX0XM6?=
 =?us-ascii?Q?BF3vV22/yMf9C+E1pWMBWAGjal0zmyLdYsuzjn1siqgmGJXmUSgnTYitBSXB?=
 =?us-ascii?Q?DSEKBZr+JEE4aHyQ3vyLgy28I52NYc7OC7OCmnbVZPMNRoi8LBjXuGTk2VcE?=
 =?us-ascii?Q?4Sft45z1t2rRf8Smqw85/xf2gp8rG76EgjcO+jks4ok0avYlqReBd9U22TA1?=
 =?us-ascii?Q?T3M7Y4s1H73MrD9Nh1twXVqp16KOk4oEucfp9jYVzb5Q/McbladaU0zF0Etw?=
 =?us-ascii?Q?lTVFbF1XiWlNYYlvsMrq8n+cyn4BQVyJvzi4UgDUpspxIcc6hmMa5xiQfDGv?=
 =?us-ascii?Q?Y65xc3YwWOSddFpFKgTvw5ciK+ia/m5+4IvfrNgPwCcho7r1QEXszjfEuZIa?=
 =?us-ascii?Q?/XW0fuj+/TsnO3Sakt1KWJ8iZjNYxy7JkNVPTx6lpW+Dfzsa8VyhekuOF/L4?=
 =?us-ascii?Q?irc4LJJjOKRxwC1x58BZtw6xSu/wtQXYu4v/e58+5pedprDlvO95zoXDKxFn?=
 =?us-ascii?Q?efSd/XepZtze5epGhUntLfeaWdo5RHISMLPxucfBhHbCF+dmx4740x0Q5hTg?=
 =?us-ascii?Q?CcYm8Rsr2m0gYy9INEE3xYlo54e6LSaphiLO/EknpgS0tZ5TrLtYNJzsybjT?=
 =?us-ascii?Q?4VskS2plwO2I60CLLMGOcgNtr76XhvrENW9DLZuzpvculVxA88CvZ+wcYpJV?=
 =?us-ascii?Q?uslMFAdh516m1ERAqUXpLK71cUqd3XnyJgXlmKGl1k5lHlfv8nWMIyYOk+xY?=
 =?us-ascii?Q?b/2MPQEU1ZkTEY/+qtrVjJigDE6I8n3xmd3jOSmgb+3mCXihXFXMhQQLew+M?=
 =?us-ascii?Q?A1crtzh9X2zCp3M1jOH+cLombKNlDF1Q2DMDLLG97ta8z2wZSsxSMIC84ho5?=
 =?us-ascii?Q?CHajT7lR9flH0JPVyJ8UXvIFP4VafQ9+o5bUIn5ZtwKp8fEJLctANHzOWgRF?=
 =?us-ascii?Q?ceW0f/erK2zkw8azL09PHkIfDqyweKTdulgCfoCgb6XXTkeGPngp5OsWuJ4q?=
 =?us-ascii?Q?nnlAD3qurPU1NvVfHsKyq2O0hzwfczI=3D?=
X-Exchange-RoutingPolicyChecked: eEv95SFMaHAVEizgXFHslK0xfolJF05Kk7jjOKhRlExmq0vFksjzZYu3bTaYQnk0/WjWlhDU1czicu35eoU3cqIInRlTGORJNvvxGmsKo4pIMFqeREgFFvqVNtTlMpYrJ6HgixbXVaI8WXH/7XUhz3ycxj316mO4ejvJ4FP9Cwcoa2daPcO1aHJLbvVk+2+zOdewXN/Qthv/FOyyqISrlcQKJZI1/jSdgYPsaYYTGt68NVMsnXKfq5AUYGMBqzU9M+XG/8SWNpkxsveOQb1QnBPOop8XzaNno16YSPxZT67a4osArn/n83gadHXKBOCE0CvD+WWZod7Vksva9h5FJQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 73fc9e4b-516a-496c-4d9b-08deb81429af
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2026 15:09:47.3243 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9eu1AOtWesR2BOdF5iKKYkhWgcQhZGugu2yIckZ8SPKdcZAhaVN1Xv9YjR7JnfY9S7tY5yHyzOy95llSpasNw/qEiIcIxQu4TFSjTGSphhw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6438
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

On Wed, May 20, 2026 at 06:03:04PM -0400, Soumyadeep Hore wrote:
> Update idpf base code with compatible configuration on MEV.
> 
> ---
> v2:
> - lists only LTS releases
> - lists releases in descending order, so that latest is on top
> - reworks table to use the new RST table format
> ---
> 
> Christopher Pau (1):
>   net/idpf/base: add MMG device IDs
> 
> Soumyadeep Hore (1):
>   doc: update recommended matching versions for cpfl and idpf
> 
Applied to next-net-intel.
Thanks,
/Bruce
