Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2C07CAC5B0
	for <dpdk-dev@archiver.kernel.org>; Thu,  2 Oct 2025 13:02:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BE1F940BA4;
	Thu,  2 Oct 2025 15:02:24 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id A779040A84
 for <dev@dpdk.org>; Thu,  2 Oct 2025 15:02:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1759410144; x=1790946144;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=YS1Q55adYJqAVqZquS/2dVQoubwJrzbVBB7/t7I+zhQ=;
 b=dTFkVOGOlBQ6zaE21OhLiOsrnCB9ETgzY2IgFHhh/WG4tDdCTt2XK1UL
 CG+afaXLq7/IjTPflMlrORZgyJEE/fWVC5BKpfMM6sqTmYUNQ8zBVRB49
 GIlwSeCNCuyFjt9KHWzUX5n2dBa5pq5iVEU3j2LMNIYQBTZI0SNLoQtcT
 Tm1qFl8a3TkHfdcbevcusLBR0jd9q22rjMtIziHzX8jZuaoy7JCEs11Is
 gRV3N34LoWUqVq7rKVNgHXWFEmkjO7mutAIjmi8ihr7XmxUrHBiBICbGP
 wC0PGM29Ao2mc4CpmHcpUcNq3Vo/BQO4oYUBRO+Zx5S2S4hbaKT73PhIc A==;
X-CSE-ConnectionGUID: 6JD61g68SL66RJYoJ2KNGA==
X-CSE-MsgGUID: 5nXwxShVSy+vU4KEBD/RRQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11569"; a="61600241"
X-IronPort-AV: E=Sophos;i="6.18,309,1751266800"; d="scan'208";a="61600241"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Oct 2025 06:02:23 -0700
X-CSE-ConnectionGUID: KUetl2KiQ3+/frKxq4XzRQ==
X-CSE-MsgGUID: WeZds6i/TkK3CufAIvDywA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,309,1751266800"; d="scan'208";a="183443518"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Oct 2025 06:02:23 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 2 Oct 2025 06:02:22 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 2 Oct 2025 06:02:22 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.40) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 2 Oct 2025 06:02:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lGnGDKi7ST8OdgzY4i9EAM7uN3oq9OJ3Ttd+jSqj/66gUyGJFNU/cnWJun5HcgBrjJKLBdXD/AeU1RS7CUkMa73oky2ZpU4uQZ3PcCiL/vGzv79nqt1nKRcWu9dp9moGkoEvVnC7HyLIGrzGApJNInrQs+cUv3aLYzq3XmH8QbdmgdDc3UnQD0toQphW3tCXwd4NKLJSsF2s1Qgvno3S+1CnVvAjNJubL9kR8v9FaL+gUOKQ4r+xeu0ErvBaDtWxlFBTnn1vU4JIRoE/JpF8boTn3AWytfKXS6bPcCQ18yazLpK5feNjLakkwcDuDACxBksNzx6nANZUdTxKojUHtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QT3XMG0N4z+RqSI7Pu4bNg3QantJ1zac9LzbyIr2lKI=;
 b=EPd9ezhCZMWBCrG8c5ibdx9QHKspqO+4pOl1YfXMt3AgWrgWkClHrTKc6cJbG2di5HNsdO9zMo9lO3ZED1eyGB2oEDVLrim4xW+T2iyc9GPA5yareRLIifRtjt9HhAj7q7kx3hfJjILQFQkJA34r7blxi+9rnItjesWfht+E4xwavDfW68ut1tVv3hUdAOE7LC/5RJe3nHL5iuB+IlPUMoIqTeXxyFmB40/ar8AtfDhr53Dl2A+NSTaQP8RrlmwirxhlxhghJCc03M2L6opvVIKnJxwWUPSoUU+pjPyxUsWyIcqLy8F86chhmnOTPTBasx9679QefO/marG3fWNvhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 SA2PR11MB5129.namprd11.prod.outlook.com (2603:10b6:806:11f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.18; Thu, 2 Oct
 2025 13:02:19 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a%2]) with mapi id 15.20.9160.018; Thu, 2 Oct 2025
 13:02:19 +0000
Message-ID: <66133397-5ab1-4d6f-adfb-f55d9ea609cd@intel.com>
Date: Thu, 2 Oct 2025 15:02:13 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ci: configure Coderabbit
To: David Marchand <david.marchand@redhat.com>
CC: <dev@dpdk.org>, <rjarry@redhat.com>, Aaron Conole <aconole@redhat.com>,
 Michael Santana <maicolgabriel@hotmail.com>, Thomas Monjalon
 <thomas@monjalon.net>
References: <20251001081825.2638077-1-david.marchand@redhat.com>
 <9acb2557-1f42-4880-ba93-020b14e6a0f5@intel.com>
 <CAJFAV8ynhCwV76W+1QVwDrzXFLiRWv+x9FiQkCGq+fw2f0CLJw@mail.gmail.com>
 <CAJFAV8wcEgvqdCiPefmxUSyP=QjfYoWiJ846EZKsDDnwa-b45g@mail.gmail.com>
 <99b9882b-d5a0-467a-be09-5bc88af2cba8@intel.com>
 <CAJFAV8wed4TtWKeD5D7dpxZB074NPLfOPhNvK7G8hXPZCeV2iQ@mail.gmail.com>
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
Content-Language: en-US
In-Reply-To: <CAJFAV8wed4TtWKeD5D7dpxZB074NPLfOPhNvK7G8hXPZCeV2iQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0246.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b5::12) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|SA2PR11MB5129:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d3f1b2c-5a5a-40a2-dfef-08de01b3eb0d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cXFtQ3MzSFNSYzcxbTU5ZDBLTVNITmxwVlljVDVhcU9WTnpCOTMzUUpEbDFE?=
 =?utf-8?B?am5nbndBdjFNc3llMUZGZkZiRGRVcDV3YU5WQkpMRFQxNmZuSndBQmFRZE9E?=
 =?utf-8?B?VjVvaXZtZ3M4SkJ2U25DL3RHaVUrTFBjNUFaYkZ4THB4MnhmTzk1d3pnUEVS?=
 =?utf-8?B?a1huMTBweGljZnlBL0VxbWJCRUJtZDY3QlNXajA2aUdzZDZhdGFnMUVudmRT?=
 =?utf-8?B?R3paQ3F6ak9ROEx0OHJvZFFHbFMxUExCdWt0U3I4NXE4VDB5RTIyUkdmZm50?=
 =?utf-8?B?SzVhWHZ0cGJGeU1aZXBKVCthWFY1MEVaV0xsbVIzT2laUVMxZE5TMFBmK2VU?=
 =?utf-8?B?QmIybVh3U0NESjBlQkQwZVZNUlk5T0VRbHhYZllMbzZBOHNtdHAvTE40bGtn?=
 =?utf-8?B?Y1dndTJRNHFGaHo2Rm16WkVWbjRkN1ozdU0yV1RXVEZhQnowR21WOUlSaTU0?=
 =?utf-8?B?b1l1OXZvQTRhdlE1SlRoK0FqYWdtczViSUYyZzVZYUp6MWg1VEFOMEdZUk14?=
 =?utf-8?B?UDRiTTVWc3BEOVErRjY2TWM4NVR1Uzd5UE5ya1hpRWY5bHFxc1JDQ3JUcjdO?=
 =?utf-8?B?TlZJUHlzam8zeE1QL1BFWmo1VEpsNkFjYm9BNGRCMmx3bkhwUTFFOXF5OVV0?=
 =?utf-8?B?cEJCY2VNQ2J0TW9LQ1k3QmVObVdJeVk0TEVGd0hXcUlxb1ErTTN6MlhWcDZO?=
 =?utf-8?B?TG1xZHF1Z2ZaR2dTS0U3U1c4c2lzeWpudnBRRVhkcnl5S0hRa3pDVlpOWVkz?=
 =?utf-8?B?dlNxM3J3Y0JLQlNCM1p3Q2c0VTFDS0x6RVhEUGdFaE9rZCtNc0JlT2ZqNUdT?=
 =?utf-8?B?SE9YOXFrVEc0Vkd4RVV6UkEyYkNDZWs5S2pKSzZCVysxblVuSjlhRlpnTDY2?=
 =?utf-8?B?N0VwYm8zTTlHcy9PYmFPeEg1dzlsOGpGSGJxZngrLzNTaFZzc0F0OTJtYXcx?=
 =?utf-8?B?VTl5N1RYOHRteHBUK1J2N01vcjhhTXRDUzQwMzJpNWt2cXpYVE55Vk03V0FP?=
 =?utf-8?B?cXMxNlFzT0FITGZxdmxSSEprZ1h3NzBuZjRLeFdobHVtaXFkNTZQRktiRzVv?=
 =?utf-8?B?ZFV3bkRoeUhBTU9VNnV5MzVUampTYXV5U2lJR2NndHdOMGZidmw3dERIajEw?=
 =?utf-8?B?YWRsNlUwT25pY0FXbU5rTUhLclN5dTEvcVNRdElhNFFKT3RkTTFkZEl2ckdw?=
 =?utf-8?B?VnczeE9LN1RKMEpubTBTVWJ1QjZJLzFFMzUxSkNZUHlCUmlteUdPNDZYcHpP?=
 =?utf-8?B?ZmFzcEhmZiszWWl0eFpoQktUbzl0S21QendZRlpWWDNmR3BwK1VCbVUwejRr?=
 =?utf-8?B?OUZOTHBYd0w1VUNJck9FbHBFYjZCZWt5a3FhMzQwdUtIQ0VQUWRqNFlaWCtV?=
 =?utf-8?B?NENZd2pidWJmSFlCU0xyUzkreTBKM2E1Rm9OcUtvQWI3OHJtM1VyMHpOWWFq?=
 =?utf-8?B?cHdPVk16cmFJSGczcUtSVEt6OEhpcTI0Nmh2WnlvcHZ5WTVOemR0eHhPVS9w?=
 =?utf-8?B?dC8wcnBmelpYK2dBVzFhK3BGUEJBejRDTGtpT09XN3FRaW1rVnVCdGRoTHpV?=
 =?utf-8?B?V3JKbFZyalFXQVl0b0xocEMvSTYxRDJTa2dVeXJhMkFFWkttNUFtTXJrT3FL?=
 =?utf-8?B?RUFRYTBDWkVqbEZ4dEY4NTk4VEs1b1d4aU9xWnlBSzVwSW9GeXdId204Mmhm?=
 =?utf-8?B?OUFCVjlrMFcyRUZ4NFdaRWdpYndQMWE3UzZudEhlVGJxeWZDVFI0Sk1lYmJi?=
 =?utf-8?B?SmEyd0ZRdnlxbGc4U0hXMVRXcWxjaHZReUpLQmtEMDE1ZEFFNSs5cS9tOHM1?=
 =?utf-8?B?OWNBeTlsbEMyWVdJRTNrUW82QXNCd1lXNER2ZDN0UlBoc2hNbDR3UEZ6SHhT?=
 =?utf-8?B?cnhEZzhCZkRZcng0WUd0S0d1SGwvL09BV0tMOVZJK05YdW13ZDQ1TE1jUzAz?=
 =?utf-8?B?ai84ZDRvTlVML05CZVZSL0RBdER3cVdnVUtEVkRCL3hMSlZnQXZ5ME1PMmNT?=
 =?utf-8?B?RUpubTJwWmhnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MTJScmJqbzZ0dmx5VFVSSGl6aEE5OHVyQ0hlemNLeTg5aTI0SkpnZ1dUaTh3?=
 =?utf-8?B?ZTI1ZEV0UTZuYTJFb1BOSWg2Vk5DSzVHV0x6dERvZExRM1dvNSsvK09KOXFq?=
 =?utf-8?B?djlVdUF5Y1VFZWkwRmlkUHM3Rmd0UDQrV1VCSW5EeE40b0E5dys3SnZWUUtI?=
 =?utf-8?B?UHJXNTVhTmpGWXN0TFcyVUczRFkvRVhsbjJvQnk2eE8yS1dCK1dGbE4yUkt1?=
 =?utf-8?B?NzJjVHIrTjFXOFFCQWw1dkdqcERFK0Z2VFY4bVZGRlRoanNqTHdYL0tDdUhF?=
 =?utf-8?B?QW9Qa1F1Nm5DQXI2ZGs0WXZORUFsai9QeUNqaVp2bkNuWTJ3blJINUZQNDV1?=
 =?utf-8?B?TlNIY1c2bUY3aDFDZDdqck93MTkxbCtMOUQ2SHAvYUZnNU5JYXhSdmpaRWFO?=
 =?utf-8?B?OWkzZVl5NlpHcS9yc0toNEZYZ1RjWnk3d3RPaUtiYWJiejZOM014bGdSZ2NF?=
 =?utf-8?B?Vm5XL3JTTWhGQUJzWTlQNFEra05QYWQ3T3YxNHQzdWkrbDhMcUdiQnBMenVI?=
 =?utf-8?B?Vko4bkxNakk0dmZOZndFR0JLbk4xVzR5cGxRcW9Xem9DaVRDWFAyL2FKeXlJ?=
 =?utf-8?B?WWZwNVVlYy8zUjJFcTltMXBQaHVXTXhMYlA4MEZGYVByODN0QzhaZEFhWnVG?=
 =?utf-8?B?cUlCbGFOYWFpRmpjNkV0WVhlN3V6WnpFUThCSExSenJkYWgxaERZcmE1UzhX?=
 =?utf-8?B?T2ZOaEloWHc3dERuN21veUhVM2N3bFg0c0VPY094OUF5VHVqTEtPQ2dkdVlq?=
 =?utf-8?B?U0NQOUtrQW9QSE45ZWJVTGlkTy9XZndpYlFIVXNvT1Q5UWRXaDRLaTZrUXl2?=
 =?utf-8?B?SkUrdjhtOExTNWdET0ZaaHZ0cmJvcEFhOUZUcGpkQlJXYjdGR3hFRXhWcHBS?=
 =?utf-8?B?Y21iTzZROXAwU0F3RDFsVWp5cVZocTdwcWhVaVdVQ005eXV4TGNxaFJ1N2du?=
 =?utf-8?B?VS92UGk5Q0lHVWNtSU5VdXRTTXhhcHJ2TFMxbTdXbW9vNitWSGZFQ2FwNmdn?=
 =?utf-8?B?Yk1Ld3VPVUt0SzVrZm91a2N3RFlDbUFYSjRvNDBlUWxwMEdud0F0SUVOa3py?=
 =?utf-8?B?VlN3NDFrMElRVHRSRys1VWduemgzTWw1L0d2SXM0QnNjMWpUMmhsWkJNeGtr?=
 =?utf-8?B?MEtnRWhIQm1tMkFKbWZjZDFvTENEaVpRTkUydEx0RzExRk9VaXo3akxUbW9E?=
 =?utf-8?B?NTdqVFA0WW5tMm5DYXhNWWlSd3kvQkJyNWhJLzR3dGg2S3VYRzhsSzEydm5h?=
 =?utf-8?B?RjJFNEVvUDlrYmNYQ05oQjBvL2hUcVY2SEI1dDZtR2ptUUdhWnRZL3dHSm1h?=
 =?utf-8?B?SHh6R0hyV0U3dWI1UFROVXVobUl0Z1JvMHdUdXlyMEQ1ZUR3cVN3OUw3L2pN?=
 =?utf-8?B?U3B5cXlrT3g2N290QmNNb3hYWlg0ellreCtzeVBJNzhZcEhHZXlmUXBtZSt6?=
 =?utf-8?B?c040VTg4QmpjTllEMWtqQzdJdFBJR0NNM3k5cTVqb3l0dUd5MkJkZUlORXcx?=
 =?utf-8?B?NHNWVElneDV5Wm56Q1ZLYXJQQVdqRUVVYmtGUy9KOWNNYWROcUZXNVVJVGp6?=
 =?utf-8?B?Qk9XWm5LMno0ODlnTmhUNWlQZ2hneENxWUR5a1JMZGRYWWVnQUlhWnNtbmsv?=
 =?utf-8?B?SlZTNDZ6eHZmelEyVzlMSWxURW13bVBDQUgxa0RkS3VmTUFLSXovcE5Tay9l?=
 =?utf-8?B?V2hOQ1lsME5rYjFxY3ZxdStFTVVxWXdsU2FlVmdrV3I4OUU4YTRDalFFd2tV?=
 =?utf-8?B?aFoyQkxYMEYwQjJURy9UazY1d2g4SGZvWFcvanFJMDBWNG1BazlnTnZENlYr?=
 =?utf-8?B?RzgvTjU2VytpT2J6aFlhZzNLekxueU9DMENpK3VrZ28zM0NCMWZhSnpQMGhY?=
 =?utf-8?B?UjNmK2xyZ1ZySnFSZDVtVngyU3QycnlwYkxXcWI1aEgzd1ZVNmZReE15NHU2?=
 =?utf-8?B?U1VMZHRsSTQrbHN4YVlUVno1TG1GZzBpNjM0ZTQxZFdBWlRvZzJrVVppd3RU?=
 =?utf-8?B?L0dpMmJrQzArU1dsNFBSV2pvVS8zNGg3M1NrbmxGamxFOFdLWjNFdHFFeVNj?=
 =?utf-8?B?c21VQkNrNUM1MkR1T1EvS08zUDlnMTlscmo0bE1tWnNINE04TWlIRzU3KzhO?=
 =?utf-8?B?anBnRGV0R2IrOE5adzZVK083OHl3UmhZTGZlYmhMZ0RxR0k5NU5ZNlNINHpI?=
 =?utf-8?B?dXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d3f1b2c-5a5a-40a2-dfef-08de01b3eb0d
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2025 13:02:18.9937 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mMuZV/HaqHg0p0+CoMUSUZl9QTtEbHlyw9KDUPuX8AF+odA66mapFkZ6Je/MsvaV+8NT2M1lgx+FM4oQ1UCTSZb+0VW3GKJX/51OjwvXrDw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5129
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

On 10/2/2025 1:54 PM, David Marchand wrote:
> On Thu, 2 Oct 2025 at 12:34, Burakov, Anatoly <anatoly.burakov@intel.com> wrote:
>>
>> On 10/1/2025 4:23 PM, David Marchand wrote:
>>> On Wed, 1 Oct 2025 at 16:12, David Marchand <david.marchand@redhat.com> wrote:
>>>> On Wed, 1 Oct 2025 at 16:04, Burakov, Anatoly <anatoly.burakov@intel.com> wrote:
>>>>> Can you provide a little more details on what exactly you are proposing?
>>>>>
>>>>> On the back of this patch, I installed CodeRabbit in my IDE (VSCode),
>>>>> and did a review of one of my recent patchsets - it's quite interesting,
>>>>> actually, and the comments provided were basic but meaningful, alas the
>>>>> free version is limited to like 1 review per 30 minutes or something so
>>>>> it's a bit limiting. On top of that, I found the tool a lot more usable
>>>>> than GitHub Copilot reviews, which are attached to GH pull requests
>>>>> rather than Git branches, and they take a lot less time to boot, so I
>>>>> feel like this tool has potential.
>>>>>
>>>>> That said, I'm not sure what this patch is supposed to do - is it to
>>>>> have it set up to review patches automatically?
>>>>
>>>> The ovsrobot creates pull requests in its dpdk github repository, and
>>>> Coderabbit and sourcery are invoked on them.
>>>> Look for a link in patchwork, under the name "ci/github-robot-post".
>>>>
>>>> For example, this exact patch got a branch and pr in ovsrobot/dpdk:
>>>> https://github.com/ovsrobot/dpdk/tree/series_36267
>>>> https://github.com/ovsrobot/dpdk/pull/124
>>>
>>> Btw, you'll notice a bit of noise, due to how the PR is created
>>> against ovsrobot/main, and not the exact DPDK main branch at the
>>> moment the patch is submitted on the ml.
>>>
>>>
>>
>> Wow, I didn't know this was a thing! Sourcery actually seems like the
>> more impressive one in terms of summarizing the changes and aiding in
>> review, but those two in tandem look pretty cool indeed. Makes me think
> 
> Well, Robin gave better feedback on Coderabbit than on Sourcery so far.
> Coderabbit seems less picky on credits when it comes to opensource
> projects (I did not check in details, that's *my* feeling when looking
> at reviews in DPDK PRs where I see sourcery complaining we consumed
> too many credits recently).
> 
> One important difference between the two is that it does not seem
> possible to tweak sourcery with settings stored in your repo like what
> is done in this patch.
> This may be a problem for the DPDK github org, where we have DPDK and
> grout starting to use AI bot for reviews, and may have different
> opinions on how to configure the tools.

Well, sure, but I meant in terms of actual usefulness of the tool rather 
than the technicalities of its usage. It may very well be that 
CodeRabbit is more generous and configurable. I was mostly referring to 
Sourcery's ability to summarize review and provide context that, at 
least for the examples that I looked at, seems to be helpful.

> 
> 
>> of an alternate reality where we use GitHub (or something else more
>> modern) to review code :)
> 
> Erm, my personal opinion, the github PR webui is a *mess*.

Just about every review format is going to be a mess, but I'm comparing 
it to patches and patchwork. There's a lot wrong with web UI's such as 
GitHub/GitLab etc. but they do fix *some* issues with patch workflow, 
and there's a lot to be said for having reviewed code right in your IDE 
(which IDE's can do with GitHub integration) where you can debug it and 
provide comments inline. I personally find that to be valuable.

-- 
Thanks,
Anatoly
