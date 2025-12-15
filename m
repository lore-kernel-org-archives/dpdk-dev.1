Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15775D5B17C
	for <dpdk-dev@archiver.kernel.org>; Mon, 15 Dec 2025 14:58:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3E8914029A;
	Mon, 15 Dec 2025 15:58:33 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by mails.dpdk.org (Postfix) with ESMTP id 597F840151
 for <dev@dpdk.org>; Mon, 15 Dec 2025 15:58:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1765810712; x=1797346712;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=06YjeT5bi8akGvKPm3S6CCAIUKaucM8FQZtbNZYqPNs=;
 b=jBLjagNT6SXAL+dxlKJTl5cosLzsleg4P6aCjHGHrAbHnRzxzwqgvhuc
 XwAOsN4awYkD5Ue/jaqJGKAsSwYZU53xd7ByXVjWaMc+kXa/pOuIDGhoL
 h1IkBjurYE2aQgW0aYXj/G7wVXPMXozallKED73bjirvlN2dON0uaH9sc
 jjmd3R/jHr8f5HmUT4xkk6Ibc7Uvg9F/rhxoKRW95cbXVsS7lVeojqhuV
 AMG4iKqW0Zfu8r2vImLGzoEwZtvT9e7Mp1X26pDH8XieTHASuGi3RcGN4
 G0FXZxm8JrorA5+2bxr9wmP1lAbpvVbMa/RPJ1AtOq48+TR0HiivpaqBF g==;
X-CSE-ConnectionGUID: dEJ9guOUQFaJrkjXdgSKjw==
X-CSE-MsgGUID: 0fJ4Ph/RShinP9VXzSELHw==
X-IronPort-AV: E=McAfee;i="6800,10657,11643"; a="67781141"
X-IronPort-AV: E=Sophos;i="6.21,151,1763452800"; d="scan'208";a="67781141"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Dec 2025 06:58:30 -0800
X-CSE-ConnectionGUID: 8evNg2T+SQqLUVGF7B7LBQ==
X-CSE-MsgGUID: iyAJ9uJSSQuRTlu39kZCIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,151,1763452800"; d="scan'208";a="197741578"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Dec 2025 06:58:30 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 15 Dec 2025 06:58:29 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Mon, 15 Dec 2025 06:58:29 -0800
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.45) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 15 Dec 2025 06:58:29 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y4H1DgLBQl9nurCq9KFTvQWf3FS0S8XNqOC9rW7+52XSKFuid5KXQaloRKv2z4pYmCeto9E1HktBhLiiDYGaguIGwM0+oy/zVyU+cv/c9vStaW4oESqeDyyvukj5z7D4ICMT9lvMSva/h0ADJoSHysGTOkJ7nbUJvHNBr380byHYyos6axvk4JzaVT5PHGt3qDaUuj3F4mFX0198FAv/xexbIWojl0SPMAimzDFIHI01u6BCohQmpg9UN7RWBF/268UkFEU0cPR2aL+bgGWSD8tQh29rq32cyydbTlejA4RZ2zz5FMjn+cIcscFKTDefaoBGoj0hPjL5rVddWw+eVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zmyVnK3MJeeGcaRidnNVdsDJGph/WX3QM5fvdrQ3Us4=;
 b=rsrpV3OfjK9tiBhx72pn4MCNbnW54zaaB9LZh60iRstfFj614xU33nRxtEsa+f/kqCP99r3LIXTADS4TaDzLqGTbe0t6BgNgZ8KMzV32y5tmnX5Q3yA6eCGyxmAlqjPMWMh6lF4qtOLoVihIfdBRa7+qG+ZkG7QZ0Umz5TS97eDrr65VXJ0KJnUA/2ZdL5LeyS9xuJKolUbavynhcGPm1kZlyDPtTaG16YEQV+eIc6KohIOpgyBgSXgGHcjUq689vNpVJdEFoDiz6fanxPT8koOJMEN8eBFzQggTV99FmCK0OGURAvBqdHwKLIO0mBZ9FDJV1CwnvaDdu3PRDUGhNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by CO1PR11MB5188.namprd11.prod.outlook.com (2603:10b6:303:95::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Mon, 15 Dec
 2025 14:58:26 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9412.011; Mon, 15 Dec 2025
 14:58:26 +0000
Date: Mon, 15 Dec 2025 14:58:21 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Ciara Loftus <ciara.loftus@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH 0/8] Fixes for Intel common rx/tx path selection
Message-ID: <aUAiDdY6K5_ugFHb@bricha3-mobl1.ger.corp.intel.com>
References: <20251215140553.2283531-1-ciara.loftus@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251215140553.2283531-1-ciara.loftus@intel.com>
X-ClientProxiedBy: DB8P191CA0029.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:130::39) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|CO1PR11MB5188:EE_
X-MS-Office365-Filtering-Correlation-Id: 80a6441b-8371-4ccf-530e-08de3bea6687
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?7IV7mhLWGUg0+I8pxZZqXVT/O60Aq0sSQxKp6ekixTjZJCFZf4ZuQl1QuZw5?=
 =?us-ascii?Q?0C7vp7nxWz27q7tL0fV2GqEO022VidYuyS3pG9EsRAaeZ4dGOWTHhqACLQow?=
 =?us-ascii?Q?Dy36UHqMwYmTvUciHVUbohNngR+WLS0658yE63sLQMs1l+POS8wZI4zFvCaG?=
 =?us-ascii?Q?7dxxPgOf07soszrSE2S8pINYZy9k9RlkselIHqSNkJx1WU2Ou28EzFSyO1aC?=
 =?us-ascii?Q?LCaRgYDsj5i/8tYySQP2239nQN5JwMQO8HmfpaFiUY1VoyWkLYC5mlHy6ANS?=
 =?us-ascii?Q?VrlKpYaoItbwqZUSBz9996Xcmc+x1jJCwyxzACwodS/uQLliAn9/b9lZDlER?=
 =?us-ascii?Q?BDM7Uc8g5DvttC0uQD6w6LjWvga8ax6PUqPh1COKPViQbSPG8B41wy1CCNJS?=
 =?us-ascii?Q?m2RuGqEPjHI0A1IegNXeER5oARbi2ybIBfgOVxT1OsYY5NoKTlxMCxEvPzHi?=
 =?us-ascii?Q?SMjbzk1CLUBxk6d715TeBXHpPD2YACWz70mNGHG1Z2ImZwWgdCj38LxJA2K9?=
 =?us-ascii?Q?DxHk8qWV4IbwQOX/HK6Psid5R8oHq/tCjzpRexG86HY0E5e/pmAz37VBoGHU?=
 =?us-ascii?Q?QMJntZVywW/r59LtTQHSf6kYgmzqYsKvf4Ed++38a6noh8lNu9lu16Hf4icN?=
 =?us-ascii?Q?1p0RR54yzHxAHmGtf/fEdfXR1BFGVMUbxsVzroAI/M3NjY3V2BFg7UG909H0?=
 =?us-ascii?Q?e+KBa6ZBUBu8GBNxqKOkrkQckEvP8FGYYQSAQwuAeM206hR8VxpfIcbuUR68?=
 =?us-ascii?Q?d3iHFg7ZBUdUNI75KbJayh89Ja6YkW93bHsbQw7bDKQezzdH1i0WG2iAEL41?=
 =?us-ascii?Q?hHgJHsRs89G44NchEC1FdxcNwQ8/Slc6a4sCsYvqdfZOcn2gONVGvtvpXIdp?=
 =?us-ascii?Q?mjPgG8BEbcyX02krimDpYrGjvEO4HlBP28h7RRTIoCe0PFD+eFOx9XHbhwuC?=
 =?us-ascii?Q?mLAQx4Ns1lssVF4ps6ub+CN1VUAugFFyaJ/B8iZ5LpY0GN5tg3VauwtG/yUx?=
 =?us-ascii?Q?txy7aufkrICZvdDhAVjVFpy6AAyX6p/3FWWcQ5dHltJfBMuDFa6kpF1WMiIK?=
 =?us-ascii?Q?3/uL8yEM7Wpg8aUloa4o4QkK24AIAUViH8Bu8kwwDyVgOEMR6ESbfh6G4Lzv?=
 =?us-ascii?Q?Eb7TVFbGsP3zBeLt6tTa5WsVzqCogwvzJDWfuh/FygffhC8YcKLM4yhaUY9X?=
 =?us-ascii?Q?nzWlv0W8iRprPBcSKzKilmmfOLB2ElWo6H3SAbFQlCMfTztlUvCGPccmMibl?=
 =?us-ascii?Q?kH7MX1cg+EuhgFnUyTVLbMUc4zSZxYxSo3cvDQq++B19f1O0DLdwPHodUw6+?=
 =?us-ascii?Q?oRaYenOFIKBQJ1YqeB30/A4uThTRwPspHgd2At1cuWKG+oNgvy2kYu0sl0f6?=
 =?us-ascii?Q?tE6cPp9UFNc9QAKx5X2sQNwM9mJoWE0tPE5acGHhOltmG5Vr7Q4WjaeaprDN?=
 =?us-ascii?Q?l/ChttzI1B6NM8WWK8k6DhiGMjS40oVT?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5hyzasEaudPDHh/vl9tcQTmd6ZNFqPES2J4YBw2vZD+tKK0fVEp5HUcspc8O?=
 =?us-ascii?Q?9rpGRECNb1RNpC40Slexvl7ci0Omj5mOL6/6vjYu/nRxGXzQMfk+HalKMazG?=
 =?us-ascii?Q?BddyiMCtbsUvshASlUWItTpu0DcEBxmeS4zr/Q4cTVuac5KRFrdVP1C/EL8F?=
 =?us-ascii?Q?ElQOQtBtUMhDvedjOAokNR4fySlk6gE7ms7I0DMsQMSaveKvJAtu2vNN8lZk?=
 =?us-ascii?Q?sHPV3G2zuWbbmMWF3ePE1OkJlMZNnI1cGy2n7OX6KU1qjsKOgNc8o8yajlkp?=
 =?us-ascii?Q?bt4xgbTa4ruTTzQBpaHdlEGJjVYEUiFOhE2/APLa71FdZlqZFZDFEy8F4ncD?=
 =?us-ascii?Q?HYyxONSJ0Kg8Ny3Isp/OhsH7Nzo5g3oIXxNdMW5A/oS+0b4LMkZQB/W5vKce?=
 =?us-ascii?Q?Me01P9jCgUx64DceAxr/9ESMJ8DPHXsN9cWbRahopELVRQ4ShlDAAeXSq5xP?=
 =?us-ascii?Q?9Ge0Euu0hVVgBLGpyRahGHW7/f3aPCMu3JlXIt+bctLAd7bDpS0sa0c6RpkE?=
 =?us-ascii?Q?J2RmZhmwv8bMRqBtSb1GKs1Nbgj2WKKNTznqD+N2G45CEKkTHr1Cb0yvN5S6?=
 =?us-ascii?Q?WpLezA9Lf1BE7kXhSnxCL0gIzvWTjD8Z+UMY6NzKnaZPnGfYNNehEQptjTnr?=
 =?us-ascii?Q?YPPOA0ntilmHsL4UgjxnXP/Ve/VWgn4vQ0VzDIyt/KE8PPH4AX0oGc+kJbyJ?=
 =?us-ascii?Q?lpjhgLf9zmsQHFs0EJ2O4Yzhy052GAP+hOMm2lqnO31f4dcgmp/fBVxzjUJo?=
 =?us-ascii?Q?OmmA0YSR0aU9JUxwuAsxfu8YVpNhIKgIFqTbJ3Wsb9+7cNQM3x6klkoKuJ9d?=
 =?us-ascii?Q?eubO9J/OsoREvcqzMwheKhOyNlhBhU3M2mJ8lFvGLptsCiTyM5sRE7bkXdsU?=
 =?us-ascii?Q?64/a05g2bW2BKh58ST4yEbDkKgHZogk/PzcCSRomXNV3oHr7rRZCrz8JGY/9?=
 =?us-ascii?Q?yurbtM336tpEoq+hCiOYZ1qEud9OI9wy5VvT+suhbNn3KuF1ysZqh1CvTZLu?=
 =?us-ascii?Q?cerXq3NRCaSnuXfZzp49XBqqFICjocVqKaCck0AV9WHQJ3xgdoSzX3tMMlop?=
 =?us-ascii?Q?cUlWaop1PvMzLj9SdZEXbR19qEutbHKcVvew3uCFsvyjz+l1RGcLy0ZNYsQt?=
 =?us-ascii?Q?zbEHHmSoW+ekdkudIWXMn5doFrLw2Ekl9B00KuJkJpBPBAQ7KB7BVLV56O4p?=
 =?us-ascii?Q?MPULKk6LtzL6xO5jOxhsybfsM2qXxf+HOrM72t3Oo3XJzlVck1dlldhaKaP9?=
 =?us-ascii?Q?uKOYtZdfbbBcqwDDGQn86oIcFnMyukJwR2+uqcRx+L93AYmXAq3yGH3T64im?=
 =?us-ascii?Q?zZKP6Sp3ldQ9h6e4lgDqKDkjUfOb0SVJO5waWLWAHKmUf0S2ZYM9k4uUVk7/?=
 =?us-ascii?Q?2qM3ZW0+yEnCrv+icD8pPAw01gC5e0bQ6f6gLlRa4QlpLOvt8E3iKTLAsasp?=
 =?us-ascii?Q?J24OxMACDj1oR1ajgO/fjvdrTGYTz/rHQaAjAiSHWTQ5i5sEKm3lI3rnJnsL?=
 =?us-ascii?Q?+M3ic7VdH8pc78xem3GInutztBjND5fCCbdIAYiB4YBiKxRIkcdCsPAjclQH?=
 =?us-ascii?Q?ReG4KlMI+Ax026qenuvYFApDVJZhxt/N8ykOAMiDYGCSZnFE05qJQKXnYY5u?=
 =?us-ascii?Q?iw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 80a6441b-8371-4ccf-530e-08de3bea6687
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2025 14:58:26.3233 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R7NEpGmxkWSZ0nX21cHH1rV8rjHpqhUvG0vEmccYateZN3kNKmhkEvWJRFZbGFCgrW9WgrDH6cTSKQ3uwz8eZQlwAfNBMFaegrLB9k+kAdI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5188
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

On Mon, Dec 15, 2025 at 02:05:45PM +0000, Ciara Loftus wrote:
> An issue exists with the way Rx and Tx paths are defined and then used
> by the common selection infrastructure, which in some cases means not
> all paths are available for selection. The issue affects four drivers on
> both Rx and Tx paths resulting in eight fix patches.
> 
> Depending on the underlying architecture and CPU flags available, a
> different set of paths are defined for each driver. The path selection
> function iterates sequentially from zero to num_paths where num_paths is
> the size of the array as determined by the RTE_DIM macro. However,
> depending on the platform, some of these entries may be empty, and valid
> entries at the end of the array may never be considered in the selection
> function. Fix this by editing each driver's rx/tx "func_type" enum and
> only defining a value for the path if it is implemented in the driver's
> rx/tx "path_infos" array.
>
I wonder if there is an alternative/better approach that can work here. For
each array, RTE_DIM will correctly give its size, and the indexes are set
according to the enum values which are common across each platform.
Therefore, the remaining entries in each array are going to be all zeroed,
since they are not explicitly initialized, e.g. the AXV entries on ARM
platforms. Would it not then work to just check during selection for a
non-NULL pkt_burst pointer in each entry we are comparing and skip those
which are NULL?

/Bruce
