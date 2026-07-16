Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF021C4450A
	for <dpdk-dev@archiver.kernel.org>; Thu, 16 Jul 2026 09:57:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 79E6640270;
	Thu, 16 Jul 2026 11:57:10 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id 2C164400D5
 for <dev@dpdk.org>; Thu, 16 Jul 2026 11:57:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784195829; x=1815731829;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=gawXfp7sTIh99BmmEB2v4yXRB4JyiJ4Sb1cqqu9CSY0=;
 b=Zh5n82McMRcVadFDlWGYqopAco+BP3ftwCOJQdWOEyCagmy04NGyMJ+d
 2RaWEowAiN4i5yPlmBOMHri9Qp/JF/uNSHYxp6AL36jifNasW35dATFji
 atflLqa+ls0US4R3JGVEVGAZ+53u1tzekM12nIZMxYY6QTmDhDj8rOcXR
 e9m4ojXkQTs+P9dgIOhUqFW9m4lek0mOD6ITlEHzodQC6IF/WjxI0YL2G
 j9k0ePFAhrp6eak8blFJ9BWp19HQNjN5ZkFi7ZMsLpHbH8zSxfJFaMoDZ
 0783FIz7cevJuUUHUI01to3+YgvBE04ChL0TrKJb6hms7cIC5KjubkjCK w==;
X-CSE-ConnectionGUID: oKAB4RBSTjKcThsKagmd1g==
X-CSE-MsgGUID: vI5VYy53Sr+s/mOCLwmsoQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11847"; a="96215585"
X-IronPort-AV: E=Sophos;i="6.25,167,1779174000"; d="scan'208";a="96215585"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jul 2026 02:57:07 -0700
X-CSE-ConnectionGUID: oYc52otQQymD3IwHsIzf5g==
X-CSE-MsgGUID: 8TFVsVF3TDSSQ2GUh4ns7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,167,1779174000"; d="scan'208";a="252475025"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jul 2026 02:57:07 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 16 Jul 2026 02:57:07 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Thu, 16 Jul 2026 02:57:07 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.5) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 16 Jul 2026 02:57:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vap4dXJKCXY/hcehLLiPPrMPOQwlALefsNiRffdwXJcC618zblVGQ1FdytuDuQ3oDy4iOtutSjfKfxDoTkDAqMxwXJJ4NkIILVryuLvgyDOIkLrly3jueIsDUeJHcPB9e7TCVNNo6ZKH2GYbvCGyMWLHxKWaf06JfMgoDO6SJr2Lu/AUIhwbEqjv7w7bh2T3j7lPXHlqkI5LNv/gHfJO6qzYh90BX54Zj7VoINtkf4LA3mXb8b5SM2vL/MR6gzWgd0OFUYJiPWuZTMJy0uyhaGeI26PMeF3ku9LNm0P2qvFVasASWK0a1LBKyJp+4p1iA35nY+IYKaD4VQ8/81JX0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GcOoz2BMK7uxGNkzDJPOLI7vXmz1Y9Ca4tCFLHSlEOg=;
 b=LkliNOQC0fecIDZu6UuWOSf2eF22+Vg+YrmuMp2g3TuWsFTWNtrnBxPpJ7xvJL3ajcz+be3Se/b5uvcgzF+coVNXrvGJ8HyRwa1RH8N9a4iylGJdAxQslUBIX7aJPni/ZbqWakdxlQVrB8raRP/JXg3w1652OTpdHrY5aEjWag3c9NPbpKkG1Tis7xkXV7CqnwSvOoJZm63YPpb8+yzaDYlSi4zT407zAS3GCQ4NpJz8wIMUt0SkTq2KrjwLkr9RKBjlo5kIGmWysKbdvYn0hD9u65uK5lEhfuMmxSYES+kPjICv1f4/PFq9YoEJgCZzDEfA9gOgEzE/ZWF30eVSBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA3PR11MB9421.namprd11.prod.outlook.com (2603:10b6:208:578::9)
 by SJ5PPF50B3E12BC.namprd11.prod.outlook.com
 (2603:10b6:a0f:fc02::828) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Thu, 16 Jul
 2026 09:57:04 +0000
Received: from IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f]) by IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f%4]) with mapi id 15.21.0223.011; Thu, 16 Jul 2026
 09:57:04 +0000
Date: Thu, 16 Jul 2026 10:56:58 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Kishore Padmanabha <kishore.padmanabha@broadcom.com>
CC: Morten =?iso-8859-1?Q?Br=F8rup?= <mb@smartsharesystems.com>, fengchengwen
 <fengchengwen@huawei.com>, Thomas Monjalon <thomas@monjalon.net>,
 <dev@dpdk.org>, Wisam Jaddo <wisamm@nvidia.com>
Subject: Re: mempool cache change
Message-ID: <aliq6kqGI2TfyFoH@bricha3-mobl1.ger.corp.intel.com>
References: <b54ad1f1692a0274da705d446972efd1@mail.gmail.com>
 <98CBD80474FA8B44BF855DF32C47DC35F6596D@smartserver.smartshare.dk>
 <e0b59e0b-1fb7-4a7b-84bb-9fc47f4feb5a@huawei.com>
 <98CBD80474FA8B44BF855DF32C47DC35F6596E@smartserver.smartshare.dk>
 <CA+BST0kV0w7teE2h8OVZ5Ont-BCrf6rSxw9+t+Bbn8hx6xUwtA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+BST0kV0w7teE2h8OVZ5Ont-BCrf6rSxw9+t+Bbn8hx6xUwtA@mail.gmail.com>
X-ClientProxiedBy: DU7P189CA0022.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:10:552::13) To IA3PR11MB9421.namprd11.prod.outlook.com
 (2603:10b6:208:578::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR11MB9421:EE_|SJ5PPF50B3E12BC:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ae9d6c4-de56-4d6b-86b6-08dee3209679
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|10067099003|56012099006|11063799006|6133799003|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: PTGD62bwV5UaQlU/mkHrbgBhEmjjH8MOYzuE/dDALXR0wDcJMm9gSukir7h7ZlKYnGa08tspbAzn0n0O9NFz447Uc1mr03g8hiOPyJC1Ep6X7VZK6rbQaM9NOPI/40R3uGtNS/Pq1CiXlbx6YSOxS1yLf1JMDLTAGdpgGvlUlKPRuzrjltp8sWQ/VMo7hjz0L7VrekVIBo8P20VAYKbJtrARDrB6Mw6F8ltzct2kqnHD09uwj37nWPU0v90YWBFLlCayYPAy2yuQ12cI7WJfgvUaTLvH4HM0uvAq+25Q43VR8dhxKweVal0jbTYNla7Mvb2+yowDzpdwbSAzVenSVjkorgpRxDikarFKSuxe8Ux1ffvxDSb9ln+eSdeujzo/3gKV11V50oYgWgl7YFiG4YPAG9f98Hm05NCCo34FGK7mFqe+VcD2mvRWhkMDd+sEjtxnYHnnE1fVS6K5jF5pNdz88AyfQcGFQ9oE59aZKPzMbIxzjOnbzjFfV2CIqeQi3zxz9udtFwAaEu9ekwhMJYrYmtOPMk7sY6n+YNS+1PKpmePfOdEZslM2XF098xMRpZNkGh/qbenPK8kmy1A2BeDiYKDDPVs805xzv36ZeQiBSKoyAlESp9tatJsRcZwlld0uBLd5Lovg1o+KEwCat+GB5ukFuWCrMMAqcm0QKns=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9421.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(10067099003)(56012099006)(11063799006)(6133799003)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?LzFHU3BKbG1KOUQ5emlBTWFZWGZ2MlpBT2VwV1RHbm9LZUtZRUdZQndwNS9E?=
 =?utf-8?B?bS83allzYmZoSFpKM05xYVVjd0dvdGlDUHpTWEFkUnYvUjd1cHdvOXlWTnRl?=
 =?utf-8?B?UkkrZzNYZDBXQzRwUlc0czF5ZmNRdHRxenpLVUVJRStZNVFFakpSZi82Rlcx?=
 =?utf-8?B?QUdzUzhsL2Z3NnB0TUVpV2lwdWdXN2M1aUFDRnNYYmhtZlFlMFM1R0plUWo2?=
 =?utf-8?B?dTVZOW5lOUpUWXlYTjQ3UDNhclYvUThiMHRSeVhNeEFPeEFuZXNJa3VQdVRE?=
 =?utf-8?B?WnRING5ZZXd1RlJmOXBlMGF5cytNWW85MDY3ZFRuSE9MTVZrU1ZlK25VL3FB?=
 =?utf-8?B?cDhOVnNLUUtHa29QQTBQQVVJWUZLNUk2YlU4bC9DVTVsZ0xNOEtIMnF2Q1M2?=
 =?utf-8?B?elJXNUEwNDVLcmpaN21kaWJodmFaeWM5c2dRWkZCek8wZG41YzdMc1ZIRHpr?=
 =?utf-8?B?Mm90UFN6NjVldEIrZkJ6MU9GNXEzYjRWU3phNmlKaGFMdkpTSXBnY04veFZs?=
 =?utf-8?B?aDNreGVPTWZIdjRWWDk5dWlJY29ycXNxZ0kwNlluZGxYbEFHTUNnS1BiS3Jx?=
 =?utf-8?B?RVJZVDltdk0rY0NyOGZDOU5xWEZPYmRvUnBicXBXT1NZamxnemZyWk9oakdC?=
 =?utf-8?B?clR6ZEswbStkNmMwd3RUSzFKak5ITkdieVN0Z2JTVkZ1ajV3WkwrVldwYnFr?=
 =?utf-8?B?OXhxOVI1amJ1ODBEVmpENURHTUwyNk5yS1lPWE1MRWt6S1lYTTFiN3A5ZGxx?=
 =?utf-8?B?Y0gybzB0YU11TzV6WDBxVE0xakp6NzhzRzE1aFBrc1ZvU1JZZ1FOLzlJVTlO?=
 =?utf-8?B?RUZVMXNLRSszVUFGSzhVamFKZmE1b25wYk11ZERndmVXNGpoaTJYR0wySWFo?=
 =?utf-8?B?SjN5Mm5UcG1mVjlJTGwwQU1HZll1cnYrUmI1SWtvUUhWQ2hvdHMySGJQQ3lJ?=
 =?utf-8?B?NnhqLytZZHNmMi9GZllrRmQyY0F6NTlLSE1tdkJGazlUOFc0Y3VYTUZmYVdO?=
 =?utf-8?B?elVnaTNtNkZaa002UkljbTg0bm9pd21TU0FmVy9HdzRVMjd0RVRBZzRFUDZm?=
 =?utf-8?B?a0NEbjEwc2RvbEtneE5QT0NKS2l4cC8xQjY1VUJqZ1pDckkwMExGMHEzdFMr?=
 =?utf-8?B?S1dNS0NjSGhQblpXUTF1N0hmcFlnczBPUlNwU2QyakRKVk1oa3pxdE5nY3hX?=
 =?utf-8?B?eEdBTWxIZ2FiaDVvUUI2UkdqazJlRi9qUUV6Uld1VnhkK3NZTHJWWjkzMHRR?=
 =?utf-8?B?S013NFhXeElvVVptVUFyK004THFCY3h4dm9BSHp1WGtzSk5uNzcvZ3ZXRTRT?=
 =?utf-8?B?V2libzQ4NDFrSUhZdUI0TkpuQVNwSnprbkswK2pJWVJHOHlseUppYzRoaWxM?=
 =?utf-8?B?Tjc0a3N4OG04bHhlaElUZmoySEpVRFN0UmZoVEpCUUcvVWFLK2lLaDVlQU94?=
 =?utf-8?B?bW9zeUxnbVRBQU5hWDlUeEtmT3JQOVpXS2EwOHU3SnFIVUowendQdnFGd3Rv?=
 =?utf-8?B?K1RVRklPY3JDeTBvc05SRG4yNnc5MFdaalMwV3BBWDg3NjVkNzc3Smg1Q2hU?=
 =?utf-8?B?RUVSckdTRGhuQnhlWGdZd0lITGpsc0VPWlpkUmZnSFhLdmxaTkhlOGtOZ2N6?=
 =?utf-8?B?WlV0UUpxaEhXYkRCRWVZcDJTRDBrbmFLUmdXbExncE44aHNDamhDUmh1ZnF1?=
 =?utf-8?B?OEJNejcyRkczSHowVy9CeHZQdUgxZ0N3bnJZVWk5cmplcHRqOUlnRHJkOTM5?=
 =?utf-8?B?b0RSUkpLRU8yNWhJek1hL3gzd05FZWtLODFqOWF3TUROTDNOMFVhcTQzVFpU?=
 =?utf-8?B?Y2UvSTdPWEQ4djhUdkdKUEVBWnJ6MTAyaW14RVAxZkZ0VVk3T2JaOUl0WGpv?=
 =?utf-8?B?bUpPQmpjb3RQU2F4VG9CZGN5SlFtcmpoMzRFM0duU1VmMXhmdnBKdHp3VEgr?=
 =?utf-8?B?S3B0R3FiYnIyWkdtRXo3RlI5eElsRFhuZ05VRFl4QkgrOExoVlc5NkZpdDhI?=
 =?utf-8?B?MEtGUmxsNjNpa2V2azczWElPem55ZDJVZDMxbDQ0RDRPSllNT2NMTG9JOTFr?=
 =?utf-8?B?T0YyMWxSOTVCeVh6RUIzcWRoeUJXczBDZ0ZqSldWdkdBSVh3R3MyQlE1M28z?=
 =?utf-8?B?bVAvMUhGbWRIc3pEY2lJY1BRSGJzSE5Lcm9EanRVWENxR2RMMVRWckdDcFBx?=
 =?utf-8?B?ZjlQUTNUdGQ3Ky9nR1pDQm5CUjI1eGtqRmNiWis3VGxKUXFYMDZwTEZUUm1D?=
 =?utf-8?B?VXNGUkUxYWtTY3EzT3Q3bEkzdWZvakZ1elJzckJEelJGR2xNR3BDbU9hUlln?=
 =?utf-8?B?MnN0SmorblFWbHA4TmZIL1lhRFBpUzJzNjMvbGhuUHBrREEyKzRQa2ZYdlNY?=
 =?utf-8?Q?deKPkreG5wxyLu9U=3D?=
X-Exchange-RoutingPolicyChecked: EV+0lx6Z2cNtGXSLU5ExCm6BAj4+y7bHElMJeeQD1r68P1dGZtBFK5l9LsWPKyJwoNhCbDNYIQ3mkQ6l2seJXq33+B9c3JrWVybhfpBeIei6TJu2atUkJUGmKny47mKwKGGcuL+WfJEGtMdn9mIZIVqmOCYY/Iygy6LRQ3c1W1cHvMsnnVs+jf6gc9vtjKD6DSVdQdJ3A1B96UxsO3kt/yIqfUVoHrUwt3Fr08cbiBhJQ6x6VEZIlMrOcxqc4bkYC20+f132nCv0A4w9BgF3nG0yMNJIY919rj1GooDqTaNSb2d/RI8HFt7ds8POM3Sk4y4wLlJsZJZ/RiyWaUQnwQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ae9d6c4-de56-4d6b-86b6-08dee3209679
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9421.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2026 09:57:03.9000 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7ixicv5MV064PELNqVl3pNsGhdzCUYI2GuzJyQKWRqzmT0Ez+oN5GxQ7PwbeXnKUC4r2gRzl8Pn6nmlFe7OK7Q2oNe0BJHxuuaBHav8sQYk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF50B3E12BC
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

On Wed, Jul 15, 2026 at 11:12:59AM -0400, Kishore Padmanabha wrote:
>    On Wed, Jul 15, 2026 at 5:02 AM Morten Brørup
>    <[1]mb@smartsharesystems.com> wrote:
> 
>      > From: fengchengwen [mailto:[2]fengchengwen@huawei.com]
>      > Sent: Wednesday, 15 July 2026 10.12
>      >
>      > On 7/15/2026 4:08 AM, Morten Brørup wrote:
>      > > Hi Kishore,
>      > >
>      > > For your testing purposes, please follow the guidance provided
>      to
>      > Wisam Jaddo:
>      > >
>      >
>      [3]https://inbox.dpdk.org/dev/98CBD80474FA8B44BF855DF32C47DC35F65964
>      @smart
>      > [4]server.smartshare.dk/
>      >
>      > We need to recompile in this case. We should try to avoid
>      > recompilation.
>      > I think it is necessary to adjust RTE_MEMPOOL_CACHE_MAX_SIZE to
>      768 as
>      > a default configuration.
>      Changing RTE_MEMPOOL_CACHE_MAX_SIZE breaks both the API and the ABI;
>      so it has to be done when building locally, where API/ABI breakage
>      is acceptable.
>      For DPDK 26.11, where API/ABI breakage is acceptable, we can discuss
>      increasing the default from 512 to a higher value. I do have some
>      input to that discussion, but let's postpone it until after DPDK
>      26.07 has been released.
> 
>    We should increase this value to avoid performance degradation, as
>    users may not realize they need to change it.  We do not have do it
>    right away for 26.07 release but we should it right after the
>    release.
> 

Out of interest, does adjusting the 50% fill/flush threshold to be a 75%
one, i.e. fill to 75% rather than 50%, flush to 25% rather than 50%, help at
all? Draft patch below, can you test it quickly, perhaps?

/Bruce

diff --git a/lib/mempool/rte_mempool.h b/lib/mempool/rte_mempool.h
index 50d958c7c6..2526a23903 100644
--- a/lib/mempool/rte_mempool.h
+++ b/lib/mempool/rte_mempool.h
@@ -1417,6 +1417,7 @@ rte_mempool_do_generic_put(struct rte_mempool *mp, void * const *obj_table,
                           unsigned int n, struct rte_mempool_cache *cache)
 {
        void **cache_objs;
+       uint32_t quarter, flush;
 
        /* No cache provided? */
        if (unlikely(cache == NULL))
@@ -1426,30 +1427,39 @@ rte_mempool_do_generic_put(struct rte_mempool *mp, void * const *obj_table,
        RTE_MEMPOOL_CACHE_STAT_ADD(cache, put_bulk, 1);
        RTE_MEMPOOL_CACHE_STAT_ADD(cache, put_objs, n);
 
+       /* A quarter (25%) of the cache size, computed with a shift to avoid
+        * a divide. Draining the cache down to this level on overflow leaves
+        * room for a burst of up to (size - quarter), i.e. three quarters
+        * (75%), of the cache size.
+        */
+       quarter = cache->size >> 2;
+
        __rte_assume(cache->size <= RTE_MEMPOOL_CACHE_MAX_SIZE);
-       __rte_assume(cache->size / 2 <= RTE_MEMPOOL_CACHE_MAX_SIZE / 2);
+       __rte_assume(quarter <= RTE_MEMPOOL_CACHE_MAX_SIZE / 2);
        __rte_assume(cache->len <= RTE_MEMPOOL_CACHE_MAX_SIZE);
        __rte_assume(cache->len <= cache->size);
        if (likely(cache->len + n <= cache->size)) {
                /* Sufficient room in the cache for the objects. */
                cache_objs = &cache->objs[cache->len];
                cache->len += n;
-       } else if (n <= cache->size / 2) {
+       } else if (n <= cache->size - quarter) {
                /*
                 * The number of objects is within the cache bounce buffer limit,
                 * but - as detected by the comparison above - the cache has
                 * insufficient room for them.
                 * Flush the cache to the backend to make room for the objects;
-                * flush (size / 2) objects from the bottom of the cache, where
-                * objects are less hot, and move down the remaining objects, which
-                * are more hot, from the upper half of the cache.
+                * flush objects from the bottom of the cache, where objects are
+                * less hot, draining it down to a quarter (25%) of its size, and
+                * move down the remaining quarter of objects, which are more hot,
+                * from the upper part of the cache.
                 */
-               __rte_assume(cache->len > cache->size / 2);
-               rte_mempool_ops_enqueue_bulk(mp, &cache->objs[0], cache->size / 2);
-               rte_memcpy(&cache->objs[0], &cache->objs[cache->size / 2],
-                               sizeof(void *) * (cache->len - cache->size / 2));
-               cache_objs = &cache->objs[cache->len - cache->size / 2];
-               cache->len = cache->len - cache->size / 2 + n;
+               __rte_assume(cache->len > quarter);
+               flush = cache->len - quarter;
+               rte_mempool_ops_enqueue_bulk(mp, &cache->objs[0], flush);
+               rte_memcpy(&cache->objs[0], &cache->objs[flush],
+                               sizeof(void *) * quarter);
+               cache_objs = &cache->objs[quarter];
+               cache->len = quarter + n;
        } else {
                /* The request itself is too big for the cache. */
                goto driver_enqueue_stats_incremented;
@@ -1557,6 +1567,7 @@ rte_mempool_do_generic_get(struct rte_mempool *mp, void **obj_table,
        int ret;
        unsigned int remaining;
        uint32_t index, len;
+       uint32_t quarter, fill;
        void **cache_objs;
 
        /* No cache provided? */
@@ -1592,13 +1603,23 @@ rte_mempool_do_generic_get(struct rte_mempool *mp, void **obj_table,
        for (index = 0; index < len; index++)
                *obj_table++ = *--cache_objs;
 
+       /* A quarter (25%) of the cache size, computed with a shift to avoid
+        * a divide; 'fill' is the complementary three quarters (75%), which
+        * is the amount fetched from the backend to fill the cache up to 75%,
+        * and also the burst limit for this bounce buffer (since the cache
+        * was just fully drained above, up to 'fill' objects can be filled
+        * and handed back to the caller in one go).
+        */
+       quarter = cache->size >> 2;
+       fill = cache->size - quarter;
+
        /* Dequeue below would exceed the cache bounce buffer limit? */
-       __rte_assume(cache->size / 2 <= RTE_MEMPOOL_CACHE_MAX_SIZE / 2);
-       if (unlikely(remaining > cache->size / 2))
+       __rte_assume(fill <= RTE_MEMPOOL_CACHE_MAX_SIZE);
+       if (unlikely(remaining > fill))
                goto driver_dequeue;
 
-       /* Fill the cache from the backend; fetch (size / 2) objects. */
-       ret = rte_mempool_ops_dequeue_bulk(mp, cache->objs, cache->size / 2);
+       /* Fill the cache from the backend, up to 75% of its size. */
+       ret = rte_mempool_ops_dequeue_bulk(mp, cache->objs, fill);
        if (unlikely(ret < 0)) {
                /*
                 * We are buffer constrained, and not able to fetch all that.
@@ -1612,11 +1633,10 @@ rte_mempool_do_generic_get(struct rte_mempool *mp, void **obj_table,
        RTE_MEMPOOL_CACHE_STAT_ADD(cache, get_success_bulk, 1);
        RTE_MEMPOOL_CACHE_STAT_ADD(cache, get_success_objs, n);
 
-       __rte_assume(cache->size / 2 <= RTE_MEMPOOL_CACHE_MAX_SIZE / 2);
-       __rte_assume(remaining <= RTE_MEMPOOL_CACHE_MAX_SIZE / 2);
-       __rte_assume(remaining <= cache->size / 2);
-       cache_objs = &cache->objs[cache->size / 2];
-       cache->len = cache->size / 2 - remaining;
+       __rte_assume(fill <= RTE_MEMPOOL_CACHE_MAX_SIZE);
+       __rte_assume(remaining <= fill);
+       cache_objs = &cache->objs[fill];
+       cache->len = fill - remaining;
        for (index = 0; index < remaining; index++)
                *obj_table++ = *--cache_objs;
