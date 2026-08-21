Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76B67C5DF93
	for <dpdk-dev@archiver.kernel.org>; Fri, 21 Aug 2026 16:11:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5FABF4028C;
	Fri, 21 Aug 2026 18:11:38 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id 061A04027B
 for <dev@dpdk.org>; Fri, 21 Aug 2026 18:11:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787328696; x=1818864696;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=O+2uCXhNtgR4zdiuZOtbASyS2r0VsTXaGrm1190PdQk=;
 b=Fmo1zXZbd13yYeYXrVQsLd6uiyS7LVnKX1Mc9kcw7JXLlC2dTrrrKOay
 LCan3+J5HjaKGzORg7WSR1TbktcFwbsPeEA6RRhKDFMsFqgoL8nrvDRZV
 RKKaR72fbWCZklkxka4/QahHP6Hcmvx+81YMUBOIlL0/qrFAqlpEMXjtF
 rnnglkmInZg2YCA7c+Q0o5awPj3Cz1Glv/XlbtALhoZUC9VUsHqPpTq1q
 ZmVxq73hmfS9AMCP8Y2Peagz2kZO4J+vYEn3Rh+yMkEETxFtSD1WNXvmw
 OetW2EjmmlUj27Do72vjArHgUBUBx1UkqtNlYqmnX7dL42nZVRDyAJtR5 g==;
X-CSE-ConnectionGUID: wa7wz0rJTjmx8w9MNBrisA==
X-CSE-MsgGUID: kZP5PQx+TIW8SUbXfYKyLA==
X-IronPort-AV: E=McAfee;i="6800,10657,11882"; a="105260424"
X-IronPort-AV: E=Sophos;i="6.25,235,1779174000"; d="scan'208";a="105260424"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Aug 2026 09:11:34 -0700
X-CSE-ConnectionGUID: 6Z+VKl85RaGGgNtD2yFoAA==
X-CSE-MsgGUID: puwaEPXSQ+SoQLe7+bXteQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,235,1779174000"; d="scan'208";a="268331678"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Aug 2026 09:11:34 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 21 Aug 2026 09:11:33 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Fri, 21 Aug 2026 09:11:33 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.42) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 21 Aug 2026 09:11:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LkNa8Jg87a1EMIXdoCgjSmpSEWT8AcnspUi8aAJzcC2hZROPzmpR8ezS9dj8p5N2jwnZaZYl/BFpK0r0ig4b47DrmXzvSpd7j2JAvlz8UjJ/JsL2RV5W7/nF/jpjn5B8CGzuoIXxEIfh5cE8yF8YENfCmfZSzyZ9lGy7Dzuwyqemibf31XEqfJ9LlDNVb5FDqKosKcNjrPvcKflU6GvgtTa2Q551gaSE4bf6zxSqoc6YIzG30VNrAoppv0bTOUV+k69MrRzsE4X2G+TmtWG/EUFByqmdV3tAhBtzgJw11NbAf1dQkKoGCMNPklcmPNqYPAVohhru6bOAXrWg3BUzDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vR+nAhRGOGCe+qZXqps8H6PIppa8wFE8g84nF5mi4s8=;
 b=kAbKBnYmaK5AqDckSvRD03CyCg5PtSGBomfKCZH2Y+hrRdnmmeJjzedGovr14ywZ/du3ZR9iqcBdg/V1f+d2qK7yjY/BZSSuNGjin6MEyGq5zlFbFAqZpNWvQqiila03t18MZATjdRPG9w7Mwepf/zv1HaoxAdUvJ8ut5EU2Gc4zD17NoM9m6VzaQKFxaXWq1CkipHbu+3KvleklIS3rhU5eYzaqNQgyOqdAq7gWOVjKRHjsIf6UG0SAi43DEAZK+RlLd0at914O76A+P2jeYaW1SvOZR51Hlsn8aJnMd+JARMn/GUf64C3M7vAGqRdwBK6AWKnBjjYTeOEDAaFXzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA3PR11MB9421.namprd11.prod.outlook.com (2603:10b6:208:578::9)
 by CY8PR11MB7083.namprd11.prod.outlook.com (2603:10b6:930:51::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Fri, 21 Aug
 2026 16:11:30 +0000
Received: from IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f]) by IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f%4]) with mapi id 15.21.0339.010; Fri, 21 Aug 2026
 16:11:30 +0000
Date: Fri, 21 Aug 2026 17:11:25 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anatoly Burakov <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v2 1/2] net/i40e: do not use flow RSS conf struct
Message-ID: <aoh4ramhYPg0JA38@bricha3-mobl1.ger.corp.intel.com>
References: <cover.1787303683.git.anatoly.burakov@intel.com>
 <cover.1787303683.git.anatoly.burakov@intel.com>
 <f7d315f9310b362e46e7a1e342ed20b6576d347e.1787303683.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <f7d315f9310b362e46e7a1e342ed20b6576d347e.1787303683.git.anatoly.burakov@intel.com>
X-ClientProxiedBy: DB9PR06CA0019.eurprd06.prod.outlook.com
 (2603:10a6:10:1db::24) To IA3PR11MB9421.namprd11.prod.outlook.com
 (2603:10b6:208:578::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR11MB9421:EE_|CY8PR11MB7083:EE_
X-MS-Office365-Filtering-Correlation-Id: f4af8627-0dc4-4849-2564-08deff9edc46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|22082099003|18002099003|56012099006|4143699003|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info: BoGo4h1ATdYgQDFguImkl+aLu1TPdMMJQ+9ZYUy+2crE43fhSzviCmJRb/Qje2A8+WhBrNBdPkdkhuPa4VzgZ/+K9CeIGW9+hQRMIIZs+wPTbPbs3kWrNmCzHlPJ/RtW6OjZgcZjUMIgPmcxqSRDP3rIRN6zuuLsGcpcxk/t9DIbCVdkospjWZrz0CjpzOhRUu/+PJ0nGafD6tygPNw3Kafjy9N+jdp6nzhXj+JSbrBYuhxhDmEMInSueHMCjba/ZS+zGXeQkTdbRdWtvvwPblkhIkJzeFhKGSTtaFSWpjpQaZp1Cr+fWUOoPU+9+uJjO70XqCyIDJJehcbSX9VjSf80i/iMiB4KaDS2xMudIOkq9UsUnpP5qpZ19tWqp+siaBt1zK+MQnkyfuresAM5p/RRPbc3Dlxo19wwotfxgickUrJrMj3uMW7iLmCBwfKW0G7gteWGZDWdIbM8BPmc9FJD22AAB3W40rKuWPpFaRVD2ppm1NNlT42xEcUp9q0ArWdxQQ2PTzkUJ/psUCM93oZRRLuRXws66gJgxTCoinLqDt4oBF0bCllOC/xI5yVpAdjNiKco0vEaVGcsw6w4A14YceWq2R6hT8VU7hioMIOvInG7lY0Elgo/FDRNCsFlyLuRb1inw49v6NPsV8hAenSvx9v0ycp0uLNHCar7TBo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9421.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(22082099003)(18002099003)(56012099006)(4143699003)(10067099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/8ShONJKntFfNzhnr8WXOj6FpK80O6sl5PPw17ll22q1TRv2Y3scYhdLR94e?=
 =?us-ascii?Q?CMLKaifoMdpJaq9DKmi0fwYShjDSTI2NjI6+4auFxxPQ2cW3GGRAm94a7lLc?=
 =?us-ascii?Q?PlLrZ+/j6eOxCLDxDkMtNhrXQSO0GyrCFlh0M1IlWI/b9fYQfu1+xxRyKwo1?=
 =?us-ascii?Q?8zDRuTxRYYXG28ROlghejGxLbAmZKMCAfL7pwfQJOUgbKuP3jj08V5oWMAt0?=
 =?us-ascii?Q?xAI0nj68ipVU/qOIohbOgKB7efwLYf6rf+BHAZ4ACq1SG6YjAERogxbotOBm?=
 =?us-ascii?Q?qEIt8Moqns5ji/cvA8i7d2SH5wCBNK1Ojm0hTLsEC3GoxAKz1xsdC57cKN+a?=
 =?us-ascii?Q?NKWoO4nsJEsYQz3+vO/BHxkSeBQb3PmZtVxpxQLZ75FSpcKg6hAefHEGcjak?=
 =?us-ascii?Q?JLxZSG6M+M9mcjODSekeznswTFg7nqOKPvhdzXG2yYToDpfsG/NQuPBUdNvk?=
 =?us-ascii?Q?kkcIiZ+RyKiNBVqy4vzOuekjzE5XkRieQxs22b8lxIQFz/bglHxZ2zVBaSls?=
 =?us-ascii?Q?ZrQKdiZTYELBSZ9x0us2XpgLCS7hxLuOMpH2SXpz2zyiY2U8HhopQQ086e1W?=
 =?us-ascii?Q?/P7tUAPKvdy5Mzx6i2w/LVQbVSKHYQtydPtQeX9/qZMt+xbmNPJzNpdQimp1?=
 =?us-ascii?Q?MpHQgHzPC/XOJbzRTZxNMBfUeEoaIaLDh2ColZTvZl4U4xYfhHw3M1R6UvPe?=
 =?us-ascii?Q?ISVXh8jd2Lajf2q+PTTpQlgnXz5mssIBzyYgUBDwub1d8Ww6MsLmTtWAd3Ii?=
 =?us-ascii?Q?v7eXVTsqZddwA9KHeqbMHlD7O6vVl7MUeaqCXF7XC7cIkBtkDqrPEc9Q6mBj?=
 =?us-ascii?Q?msLeGEhjSawTT/Y2TVkq+LYl4PNHiUFQs4s8grCmrqz6odfF7148jfK2dBM+?=
 =?us-ascii?Q?U78KCKTkvnG7kEFPqv6h9GBTM2Ll3OYIO4f8hvUcW68ApxKMumlwXG3Zlgjn?=
 =?us-ascii?Q?ZEJDL9FguRBnlgVZLZsmWA38xBqxfzlB/AFItrhGVP4EK5xqn4HAZgzyUax/?=
 =?us-ascii?Q?6vr8IW5EfnxxAyHKBCUXTFWgRgE6HIEN05lxNpgW7ML3fVMtIKx+zBGPjWZh?=
 =?us-ascii?Q?2zRgHasbCJf/U5nPQz7UmXHdaFVSoTzrN2gUBqy3E7fz09q0W5OXlJOVL3JJ?=
 =?us-ascii?Q?i3A2jEKcUGKZ7SY0pK5B+K0SH6JD+xiAYVRreRj0AAI/LF+/hufwJ9hMYKpt?=
 =?us-ascii?Q?0rpb2vW6XT0RoDDhMjPsN0neyOv6CTi7mVfrinug/SnyhWa+aPEFlhpWFNAc?=
 =?us-ascii?Q?0DjEvMp/Ka2v6aMwbUIuO/eVeAB8XNBumrgzJHszNT8s0uDY0KeEf4KvLGHr?=
 =?us-ascii?Q?PEKxyObSXZTwYCzDMC1B686VCrBrbBpBARFlDQoFOruYnH3p01WnmNsJwDSt?=
 =?us-ascii?Q?nfSEcEmISR8VmWgcPTbhGM7i00yU4J9juCfILwYjC1lEqN2gpqsv5Mht9WJ/?=
 =?us-ascii?Q?k351OYuFjLAlF6D2wJyf+oISMJH2somO7B2hJvKCvHkrGm7BGE85FI14niTZ?=
 =?us-ascii?Q?CnTCe3mFLFhgGQ02zZwwxA8/oV6rFPjP94upcWYcm0b4No3myBstNx3X5skG?=
 =?us-ascii?Q?2A1TCADuzpiPOqNhCGLKsJACAa6C2w9e8edWGPqD+fgIms0E1ZcCdVjN1I5e?=
 =?us-ascii?Q?v954qD2bJF1xXHhVQtq6e8igpcW1FQe2CkgNNBKvgivuS/kFtLNCf82k/v0U?=
 =?us-ascii?Q?Evk+CjlA9cC0g3lE75c3AgBw8Ibx6ge1cG7RfJPfe+i9kDC4GIxABolBWKzg?=
 =?us-ascii?Q?gePKD7+H/afNekPXVe9KkhTejQqHCWw=3D?=
X-Exchange-RoutingPolicyChecked: MWxJ1j5VqHTh+KEDjMaGB48eaCqyy4SwgwFxS91tAVM8at7hvGgm7pfosWoMAbhz+vX/C0Mg4eM3mXUkCRlnwtNHakxFVNRPGBnM1/UrNCZOG4PCRXCLHuCPpundbeHbLWV4WURqh+IYjdZ6Ft8c9wkRud95TN6ZJFajLQTbSXDo7bJw0f5gFl4sadbrwQID3n5dua5k4pvm++IapyinN5hk2Fb7NwitjJFVXHlZjhtkbUfdssg1OwuwpOJudvSqasXYqVSR7Kq1hNVICt+vNT+au7dpKL4pB984erALA07vuS2v5mqPnogFCMfVVnN6PeJp8xe4buUtXOqK3cH1qw==
X-MS-Exchange-CrossTenant-Network-Message-Id: f4af8627-0dc4-4849-2564-08deff9edc46
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9421.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 16:11:30.0600 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HodFDt172LDOUQlPGY5FcGD8UpBg1grXoap9I/3jho+5ZwCQDxsPPPY/xCc8a5G37w1ZAtSE1r5rVRVopVwIrme14tPND3/t7nDYFwV0kPg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7083
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

On Fri, Aug 21, 2026 at 10:15:30AM +0100, Anatoly Burakov wrote:
> Currently, the RSS filter structure includes an rte_flow RSS conf structure
> directly. This is suboptimal, because that structure has pointers in it,
> which makes copying data out of this structure a non-trivial operation that
> may introduce potentially dangling pointers to queue lists or RSS key.
> 
> Replace it with direct members of the RSS config struct, and adjust all
> users accordingly.
> 
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---
>  drivers/net/intel/i40e/i40e_ethdev.h | 11 +++++---
>  drivers/net/intel/i40e/i40e_flow.c   | 13 +++++++---
>  drivers/net/intel/i40e/i40e_hash.c   | 39 ++++++++++++----------------
>  drivers/net/intel/i40e/i40e_hash.h   |  1 -
>  4 files changed, 33 insertions(+), 31 deletions(-)
> 
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
