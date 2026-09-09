Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD438C79FAD
	for <dpdk-dev@archiver.kernel.org>; Wed,  9 Sep 2026 11:51:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BB54740A76;
	Wed,  9 Sep 2026 13:51:25 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by mails.dpdk.org (Postfix) with ESMTP id 5801540684
 for <dev@dpdk.org>; Wed,  9 Sep 2026 13:51:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788954685; x=1820490685;
 h=message-id:date:subject:from:to:references:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=TR0DAqykkW+XqwBvbL1H8toJt8SIuflFlglT0mtFZYU=;
 b=TFE+OPKt1h6Dezf0BgkaNgPWUEnl0hGuIGLiipDpWfoaCqT2DeK5++Au
 2nqRPxltpIGxMdHyiVPv7D7f/LBcyOBhBUH92JF0ZKpK+YJylpJ05H88B
 fFIfe8+jQn3TcAqoo23aK+7T3jXsMP6Z/EQgRgxwfIHE/AEr75Y0tu8Qz
 RpFs0uC+TS9FOi9FBcKb/OLL/Q4V5bv/T+oDCpAebrOwhjziiVSQmCrv3
 ZCESsi2jbg2L9Xt8oTm60hSZcCCzqlIglBmqaJim3WdelbAxd1KHKl5EJ
 tpd86hoFGKCF+xPzph798cKt8TpjLY7cxkOoTwChgsP9oVR88be5q/dSP w==;
X-CSE-ConnectionGUID: f9TbR+dkRmSrXYWn22OoYg==
X-CSE-MsgGUID: ML6uksXzT4OW1FrGioXXhQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11900"; a="114922342"
X-IronPort-AV: E=Sophos;i="6.25,270,1779174000"; d="scan'208";a="114922342"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Sep 2026 04:51:22 -0700
X-CSE-ConnectionGUID: G4c5xFRiTGmc4FDnI+dFsQ==
X-CSE-MsgGUID: yOokPaXTRciyeA1uOGBxlQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,270,1779174000"; d="scan'208";a="274822802"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Sep 2026 04:51:22 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 9 Sep 2026 04:51:21 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Wed, 9 Sep 2026 04:51:21 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.71) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 9 Sep 2026 04:51:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gzKuu2TfDV/rHB+Yp2L0c3h3QBf9j9zTNli4l+58G5fVCwAUUHjMb6gmMH+jO76aAxFeVL1TI43r0Jqv8CTjKSEXa5dm8HxzfqcPBsOdxQyuihznG2Q/b+wmcap0sMTlvPY48DYd3FYIizHGiJUoSwDcL6OihQPwVCa7o90l0oP6rwPhAyH7e4f6xujqEf0FgD4isNHeTn1RVWEWWeTHzpwBGSkHPSgTSXYRflUbXt6vU9Z4q4np/VlYIy5q3+KxbRBI8jq6TZFUn8DJdFEQUPxiDG64DqqXOKhZAyFlAxL7mPS7drtPtzbV3loZLyEo0VR2tFA1BLONCMSIi/0FbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zo4qJ0fYJEz/1YiUWJq81p3w0iYN6/ywGGTm5ZsWMQs=;
 b=x4ONCludTBb4T8gbqlseXi6kl4k0Ufd6QXD8vF9MZTaaTUZZWe4nrsypdKCUOfOUwSMvu9U12QfzZHhn1nWHI/ti/BzfWVrhgNgpzLINB5nyjK8PJlWQSXcHhmMO/ynf6Dz6oRkzY80mIxlvOCsWfVkeGpU4QFNe0xqKPkwldxjsWLNkep/D50gVFYSRAX5Z+wh2CGn2CRY06tN5gkIOt3ndhNg5SASS7VL9BviL2j11CaxvXSNj59KW+QJjhmkwhOpFUJz96XIHyPoMkd/HS9Zjz0h1c/W8MZJymCJ+ZLmaU8kTCIcs4Ymj6dgKX0FHsK/jJPm3IT8E+QmcgF6Y0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 SA3PR11MB7627.namprd11.prod.outlook.com (2603:10b6:806:320::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Wed, 9 Sep 2026
 11:51:16 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4%3]) with mapi id 15.21.0406.005; Wed, 9 Sep 2026
 11:51:15 +0000
Message-ID: <bebe0731-ef9c-476a-8106-aea411abd29b@intel.com>
Date: Wed, 9 Sep 2026 13:51:10 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 01/26] net/nbl: fix use-after-free
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
To: <dev@dpdk.org>, Dimon Zhao <dimon.zhao@nebula-matrix.com>, Leon Yu
 <leon.yu@nebula-matrix.com>, Sam Chen <sam.chen@nebula-matrix.com>
References: <75e8e3b8ff4d0647e2a5216dcde0d93f3856e821.1788947937.git.anatoly.burakov@intel.com>
Content-Language: en-US
In-Reply-To: <75e8e3b8ff4d0647e2a5216dcde0d93f3856e821.1788947937.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PA7P264CA0317.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:395::21) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|SA3PR11MB7627:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e2be5c1-287b-4a2e-9064-08df0e68a76c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|18002099003|22082099003|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: dtkt3TmCNY860VwkYzD/7kiyd2cdeeGwoL4FZ6YN+2ecQT+HvY7iyCzZc3xTenn/J9aPm6R6Rvns9ked/UKqdh90GbdZS5OwW9CKUXNjUaPBY7mA3gi2+v1JtoTE9VEZ2eAcmUzSS462WffdHnf+EyFaqMUryXqETLx140n6NdcbSIfOt0O8HAcJOkvmnHSrRfWgxewUZspSnDacQzwrXYlgoBLDYjtKGyE7ZkfDb1Akp62ZcTav3adR+DK7zEH0iWrLxbrOvtm6EB3jeVtpumjz6DxLkyreom7VZ1jcgTQzrqECsMzn9ZRz81wkz1qhLfizDsYEUpTfRnSWaO9XJHTrZzXBRVMdZG3t0LHf0q833nqQU4ezraPpSa3t8xJ+7hXA+e3wvJQ7TyVOr+SidTwJapqXrIvvCARUyXisUg+SSiiLcTNjaQ5eblMRt/P9GVse4dy4vU1wJ146YLKDgdmpzLA7iuMuZMCrztrAeWU0SpE0N/JlKAP2YjpGo75FgPx3C39moZWCUmSVqe1LmuFSALQw869Th20aX/o1bRexjzmLpJzWtKikysjKK2uw2S1C/zG2e24KedvJzMS0aDMGPf9payEMCUTkqdxJCS3cq52msjS9ZRvn22sPTNQ8030gOwTayKm/L0JH5TZC5eW6WEfXZE4Gwnu9dtnRk1s=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(18002099003)(22082099003)(11063799006)(56012099006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U0lQbDlWSExiRENoUWgxM1lZT0RmUnduRFJiZTVzczE5aDhVek5yN3VzWFJT?=
 =?utf-8?B?NUtxZVN0eG92ZzFKaU53c2cxa1lFY0YxaGszRzNDaCtBUzFNSFFPUzJWTVkr?=
 =?utf-8?B?NGdTUVYzaThpbEh1Nkw3VGtvTDU5SExzdmRKL2UxazE5UXhFbzJZK2ZncGp5?=
 =?utf-8?B?eGdKM0pCRlU5eG9Xc0QybDhhcXluVC9kMHpyOSs2MU9KN0J1bXovUGhhNFpL?=
 =?utf-8?B?VFBxVjd5UE55cW5DWm5XTmZrQ01KRDZMNVNsR1ZqdGsxZUF5eEVxcVhpaHlm?=
 =?utf-8?B?M00rYW9Eck1EaXJ1ZVlSVnltWVVTdFRnTGEzQ3orL2h0S1dMWlVnaHJrV2pX?=
 =?utf-8?B?OWhMOVNSVis1OEVxOEpZVkJOMHZybVp6bkkvODhoUWpuaEJJMFN5cmVHZ2FC?=
 =?utf-8?B?M1EwWi9VNWx4MXNmbVlwZlMzZndMNUpSVnB3NkhYNFNodlVXemtHcytWY2Zy?=
 =?utf-8?B?OFJFcHl4b25WcnZFSXJiRThPdHVxeUYvcE53ZXgwSEN0UWt6MWlJRHd0OVlV?=
 =?utf-8?B?M2k3QklsSUs0RUUxdDI1YnBWSzdDSUc5emNENGJHajBxTWF4eHBmN1hKcnJH?=
 =?utf-8?B?NWpQelh3Z0IzWTBLZHE4SEI2TnRpTzZQQkFXb1ZXblN0K213Z0hnSjQwQU05?=
 =?utf-8?B?a3o3bElVZ2c3YjVKNW1uckgrY1pveTVPMVNLWEtGc3JzdTZ6aFZuOHBDRjZy?=
 =?utf-8?B?d29kek0wTkY1RFB4dTIvbHcwc1hmaHZ0a3l1OGU5cjJ5ZHpEZko1Wll6U0ly?=
 =?utf-8?B?azE3RjZ3RzAza2tsc0VWUDNSeVRoZVZWNjB3a1lrMkVwS1VsdTVKOWZ5cVpy?=
 =?utf-8?B?L0Z5QnFhVkxYQWNNZmNGYUFDTXp3M0VCZC8rQ1hOclRjQllqWXJhdCsyMkFz?=
 =?utf-8?B?M0t0UUlBcDZPNTVXcEI2amxhSVFwYTlXRlRqYzVmOE1WeityQ005RExvN3pO?=
 =?utf-8?B?Rm1LTThPYjdHZWlQYUhrUllRd08vdTlBbXViUTdPT09xYzB1WWRZUEx5NGJG?=
 =?utf-8?B?bWRUdUJLUXBOSlg5SGNyN3NsM0dhL3Q2V3lLaFA0YllLZ1lRWWFKWnpURkph?=
 =?utf-8?B?YjBwN1BsVEdFeUdXT2dQdFVDMjFMa0hyMnBsUWlQY0pqM2o0bCtqTlFJYmhC?=
 =?utf-8?B?MnRTQzJnQVFHaE1rcFY3U1JuOG05MVBhVUhxemFFbFd5RnMyWHFjK3BJVWF4?=
 =?utf-8?B?TXloYmw1N3EvUGR6RUZqN1JacWhvK2FuRTVBR2dhMUgrcytyNk90aC94QllR?=
 =?utf-8?B?VmJwTTI0VTh0UEhEL2tHU0pvdDVoTGExM1hxWmxCVzdxVTVMWnV0aW9GTFRL?=
 =?utf-8?B?cmJQOHphM0U4cVIyZmlyY0k4Ui9Kb1J5cmhmUnM0dTZWYmtXMkUzVHY0VmJm?=
 =?utf-8?B?b2ZObjh2eFdGRkZCZlBBSG1tUmxDK0x3Z05qbUxvV1plR2VYMlNoZTk2TGx1?=
 =?utf-8?B?RFh5YlpRZEEvTGk4SmVKVHg3aGlwZm0xMkdEeWd1V2pidG1TcTJyNmJ0NFlY?=
 =?utf-8?B?M3UzeGY4MFVpd1p1ZGRzdEVBc2lGelVYSFhkQjFwOC9abVlEcXVOTDQ1Vi9x?=
 =?utf-8?B?MS83a2R6M2lwTTM5N0diem40ZXhLbjRuOVdEWlI5K2Iwd0UwQnhTaDl2SW9Y?=
 =?utf-8?B?cnF4QkUvTXJxZmRsWVY1bU1vN2I1N2xBOHl5ektuYXhLb0MyZzNzSTVLTUQ3?=
 =?utf-8?B?WHJpNk5tdlBhWUxRRUh2UDlIVWVRcU9PK1FaUHJQTXp5WUt2d1psaFJZUTYw?=
 =?utf-8?B?NWppRjlmMU9XNndSS1JOUnovbWM4ekVKKzgwWk8rY1VKYVE0azJsSk1uWklj?=
 =?utf-8?B?RnYwMzhIYkNGWE83RXVDRlVET21PYnJIYTN2aVAvYm9yRFdvVjdQZnc1RTNs?=
 =?utf-8?B?elh2NjQ3aEx3aGVVL011YmxvS3ducUtOVGdOaTFkUlRHakpibitsakZCM2hS?=
 =?utf-8?B?VTZjdk9nREV2SUdNcmJQOWJHT0pGYWlIeGRXTHUvMTR3Y0xEcjdFd0EvWWhq?=
 =?utf-8?B?WkU0My94Lzhha0wrM2VVeXI0RGhKNFpDYkQweGhFVmNUSlhnSjVtTUhVMFhh?=
 =?utf-8?B?V1BuSlJ1SGorcC9UL0M3TWdCQkNLMjRqQ2VwVFcvYkQyT0Nhbm12L2xZOWp0?=
 =?utf-8?B?Wi9WTS9BWHk5QnNKQlFkd2ttL0RPaVRUQjhlNFRwTVQydU1EYzdWQ25mK2Nu?=
 =?utf-8?B?WFlScUllOUtOdG0rdFdSeVMvMHUyVlZnaWlHQVF2RVRwWEd6WWtBV3IwdjF4?=
 =?utf-8?B?ZldsYUxMZlREWDcyZDNVeFc1bWM2UWI1a0xRZTIxcVkvd0Y0bGRyaXJxcjR0?=
 =?utf-8?B?RG1YWDVBMVdjV0RqU2RRWW1XWmwvVzdJcmRaanN2VTFEeEVDZnVZa2QrYjRh?=
 =?utf-8?Q?xNymRCqfQqhDDWQE=3D?=
X-Exchange-RoutingPolicyChecked: Um0D/8HOzpIf+lPGcTyACDjJ+3Ssy9purhELdnKh8+PCvB7p8dI3DOW2jhwuvcMCcBnVRZqWlvmaTP3747qC9g9CaCnjhqN5Jbo8ZsZb41lIyQrM1g+VCtEYwkvtYe7YNkLIP9mjQp7eevyf2eOIaJOdIfMY90Zyrd526YiclnExXlW70OTR3mSahrnq+XPg6/B6nyMyC3ODC2fPNq/op2sEYK9giWhpdJup5MxWXKeZxN/Xuo1WIF4leREVxbmuyxuFucSigGBVHRW0lxceHggJaP3kaBL+aOyU1Us25de4yR6CQwQTYsWnAVc/hnZhbCmUDj7FBRxwOX/S023lSA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e2be5c1-287b-4a2e-9064-08df0e68a76c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2026 11:51:15.9210 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CL2HBMipUq0nH8fekAHpathAQVUCKDhBqbP97pDcez2TwkfMNhP5LaLXzdgah7Y0YBypsJjd/GI1xmRAkg2+qroVj+E/9A1kESbik2shU7o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7627
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

On 9/9/2026 12:01 PM, Anatoly Burakov wrote:
> When unmapping a device, the device is not removed from TAILQ, which may
> result in attempting to access this devices' data during subsequent mem
> event callbacks (as they are only disabled once all devices are removed).
> 
> Remove the device from TAILQ on unmap to fix it, and move the device fd
> close under the memcfg lock to avoid race between a mem event and fd close.
> 
> Fixes: dc955cd24c8f ("net/nbl: add coexistence mode")
> Cc: dimon.zhao@nebula-matrix.com
> Cc: stable@dpdk.org
> 
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---
> 

This patch was also sent separately and is currently "awaiting 
upstream". Sending it as part of this patchset is a workaround for CI 
not being able to use Depends-on tags correctly, it is not meant to be 
merged as part of this patchset.

-- 
Thanks,
Anatoly
