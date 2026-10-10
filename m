Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA130CA9EC0
	for <dpdk-dev@archiver.kernel.org>; Sat, 10 Oct 2026 18:31:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3D0EF40274;
	Sat, 10 Oct 2026 20:31:02 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by mails.dpdk.org (Postfix) with ESMTP id 032B34026D
 for <dev@dpdk.org>; Sat, 10 Oct 2026 20:30:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791657061; x=1823193061;
 h=message-id:date:subject:to:references:from:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=vm/6E3JabSXcCKxOp8+XQJOXXleEN2PI5fauzZTw4lg=;
 b=WcOH/7K6OnWgoWOtVHM6yIZg2jaT4nm1e2Xo428qeCA+QWRKI/ttp9ra
 /BtIfc/B44UXgi8D5BQ9VdYcyT1DY0bz/LBTD1wrWn06X5QuIIqzacYrE
 OK874Qi6GChCXdm+ZbWHxi+s3cUxAt0yKtGVj84zKNJjJZV2N0+Wj16Wg
 TndAVYY4ch5WinRPCRq1c7rxFo0Z5it0gxH6Z2E9VGt6rl7aq0Oph5s17
 qdYNjaRqIBVGeIhzvaKLjaZWELpclXvw823AR2ycFMyVIILpWFEVpy+U6
 eqQQyP1sEDiYYhCRI5CEj1QrF0EOunQXdXXWxnijA+eWIKyWBSAeGAJFF Q==;
X-CSE-ConnectionGUID: aWi3zNKVQnO98WwEsxblxA==
X-CSE-MsgGUID: QrsFpzslSPSQsH7W+dfd0g==
X-IronPort-AV: E=McAfee;i="6800,10657,11931"; a="521396"
X-IronPort-AV: E=Sophos;i="6.27,150,1787036400"; 
   d="scan'208";a="521396"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Oct 2026 11:30:59 -0700
X-CSE-ConnectionGUID: 7SYl2ik1ToOZowXtOgLYMg==
X-CSE-MsgGUID: pqM2KXQZRZGpPm+Vsp9k5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,150,1787036400"; 
   d="scan'208";a="2357307"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa012.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Oct 2026 11:30:59 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Sat, 10 Oct 2026 11:30:58 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Sat, 10 Oct 2026 11:30:58 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.56) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Sat, 10 Oct 2026 11:30:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PxXCIroWtcJn9gW0pO/T300LEF4tm9tUVthffsYBvzjmlouDefwfgpj74Sg+qoSKbEGc7afU/nWifWAd7glX89djjDo/iIpJi5fU31wDHnrTWObiIqD9cNL/p9GwsYlN5Pc0SaIVs4sjEM1bYADyhCZV26FfxfontuILmyP51w1O9+QjRZz39+pCE0QQTZIUV2vi98DD8+MpWzjJYw/E2xXeXmk7BSlyMCJDJsidE5fU1bEwUr4iMfFEYQHDNGddS2Zt5iT3qH+B/xHg7fI1Sn7MvgLSiM7gKMwfy9LzvlBivei4AcVJfZ5u3/ZIH1RBMtwvHRljjKRlrTNV0QsFHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yzlMcO/t5q4Rg8QYyqygOnmskJCOXFi5zGJCsQ6NgcI=;
 b=IC1Z1bpMuGkAm5uwm/cg1F56w9aSxRd3HInoNw/WNiDEQWHJmcbve6wvMCac31s2FTZF9XgMxGk1J2a0b+o6oLNh99CqF5WdnINjvVT4RXR9cqEWj/cK6AbFOp/NvxrNzKr0KEMeO5q7i20QcDH/s9kUW7OcV1MjX5nJXdzMdzLoC/efdwTpECZmdN3olgpf5NPZXBSaCaNOT0d7vsatrbvtiX4rDgNIbD6fPOzc+A+0ruGOD5TvnoO9xvorvo9td+z0co+AZZOc3H1ytxrA3/8+Gctt2VgaGvTtQf30Q6p1W47ncY+lRO34ZkVnSgZa4az+ruJK+UW+wyAZDAEN0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL0PR11MB2993.namprd11.prod.outlook.com (2603:10b6:208:75::28)
 by SJ5PPF524F3F9FA.namprd11.prod.outlook.com
 (2603:10b6:a0f:fc02::829) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.19; Sat, 10 Oct
 2026 18:30:50 +0000
Received: from BL0PR11MB2993.namprd11.prod.outlook.com
 ([fe80::5877:2021:3cf1:1046]) by BL0PR11MB2993.namprd11.prod.outlook.com
 ([fe80::5877:2021:3cf1:1046%6]) with mapi id 15.21.0496.015; Sat, 10 Oct 2026
 18:30:50 +0000
Message-ID: <77a23ce9-8321-45f3-a4d6-ddf37b22a0cb@intel.com>
Date: Sat, 10 Oct 2026 19:30:48 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 07/25] net/ixgbe: reimplement ethertype parser
To: Anatoly Burakov <anatoly.burakov@intel.com>, <dev@dpdk.org>
References: <c88104cb21d97fe375c18574d2dfa72029b72b11.1791543154.git.anatoly.burakov@intel.com>
Content-Language: en-US
From: "Medvedkin, Vladimir" <vladimir.medvedkin@intel.com>
In-Reply-To: <c88104cb21d97fe375c18574d2dfa72029b72b11.1791543154.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0094.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bb::20) To BL0PR11MB2993.namprd11.prod.outlook.com
 (2603:10b6:208:75::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR11MB2993:EE_|SJ5PPF524F3F9FA:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f1ec7ba-cfd6-4c97-1d8d-08df26fc9c53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|56012099006|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: Ka847bFe4LABR3N0iLJE9xk9FUnQyqllwcqKTVy0cQ4iXX6R/grIhUf0+ZY4u3FPbgsBaDwNQ/011/cHee+8LgfBPeWqgLJB0Ks6Yfdw7DwdpmaPRoCgSJsuTf7ksTMHlpJFHmIMg6xjSpKlxLEBGoIcnEALz8pOfifW0YTRBCVuR/ydGcGW3QOL6/R26MHcUF/ear2V3IL9l5u37RLP+cJppvoo9xqBYP2BRaZXzUejlbl3aq5CUYwJijBnNu39hfHZSFmx42LRHl3S1mTiXoPjEcGWlKpnWM75Spn+lIGy1YK89bG8353g0hxAV/4myQ9bUr6EAeI2WcmOjX91VluJeASIln6XTCfp4X0xSfKsJ1o+inHHguS7OHmsvMls3n0/pza/AZFeKPE4lnZ5GKVs37HME6erW80kypYiMIzp9UO5CH/sU26HblMduenehXXicPBH2ff0NDZ6udjaiRNdqbyVupLZIoX5hWycFkabWPW9u3oc4zXbLZsZW0X2NlPl6Dofu7vVDk/CeKMk4zC66j+1vzp/Egsx6oqWbDVJNT272cUGB+LcusR6NaqW1ugPTvjx1kRefZMrZ18Kuw+TjVMiD0N8CJ0Ao09NeZOezeVk6rFAy49LQMh6K4qcrOTB8OQ4r46dVENgrAf+DnCAnPLuHjPKyOBQ+bCsIPI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR11MB2993.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MzkxdlNRY1J5T1AzZjh0WTh4MkNmMzFuWm9LNEJiNG9hWm81S1d6d0VSZFdx?=
 =?utf-8?B?VDhTVjBTZG9vM29MeDlmemppYTNsbC96VHI3M003ckErQVlCTG83cHZBbDJZ?=
 =?utf-8?B?WW5wdFRiei9jNnU3VFRueVJ1WEIxZGdldnBBYWUxaUFzZ3ljVU5VT0V1MGc4?=
 =?utf-8?B?ZVIwODJsU0d2RklFOExyMEZROURaem1ML0x6OXg1R3NEYnltUmtSWlQxMnJU?=
 =?utf-8?B?QUVRSEc2NXBhNXZVNnUxZE5VeG9qNmErMmVZM1g5RXVvcUFJTFZlTG5kdXZQ?=
 =?utf-8?B?cWlsbGUwamovTW9hVE9IY1g4RW9oQU5LaW1MMW9UZ056L2MrdWRQQ2ZrNlVs?=
 =?utf-8?B?b2Joa2w4WVF1WC9zOVZhdmZsYmd6bC9CSXpacVJycDJLd3haTmlIU21BQ1hk?=
 =?utf-8?B?Vkl1WGRWdGVQdDY3dlI5MzZINXBBKytQSnJ2ejM5ODVBWE9Cc1hxVFBYSXdz?=
 =?utf-8?B?Nks4TlJqTHhuRURHQ1gwTy9teGRmMHBSQzhHbmVUTkUxNUpFaExnMU13alRW?=
 =?utf-8?B?eUM2UVJmNCtOamdpVHdyckt5Y3hBL0dMbVpiTDJDeGl5N1VBTnhDTS9rUDFr?=
 =?utf-8?B?Mks3T0I1SmY3VjFUbDhWQjZlam5OOGd4Z1FqeEJiVmNCWnN6d3hvYnZBcVQ4?=
 =?utf-8?B?R3lFSThIMjRBSU1OZDBlZUhoUlZ3L1dDcW1XU1ovcHAvUXRFUFA2WkZaOG05?=
 =?utf-8?B?TU5waTk5b05FM1FGdUpnWThJR214eE1ISTB1T1lBZVpmUnhETDZpUFNmVmRS?=
 =?utf-8?B?Tm5IdTZYb2h1OTdBa2JTZ0FPeTJmSDRsa3M5RDNyY1ZFOEVKem96REdjaVpI?=
 =?utf-8?B?MUJqb1F4VnlOeGFNSFBzSkJZYTFPSS9jQWk4bWFnaUdZSmdPcW8xZGxrVHNl?=
 =?utf-8?B?RWFPWjlnd2oxT283dkFkWURBeXlVbXNIU3FIdzFMVjU2REVGclRtMWd3c01M?=
 =?utf-8?B?aHhHWGxJODZtYUVTSGw4OTJncDRlazdDUkIvVEFkQVFYa2JWME5xWVJMSCtM?=
 =?utf-8?B?THVLMTlieE9UTUh3YVBLSktGYmtXQkwxOEV4K05XTytDQ0hiT1pFcTVla1Yz?=
 =?utf-8?B?UGgxK0V1U2RhR2FvWllyYjdjZjR4Z0VIdzMwQ3JYOCtrU3VUaGJjMTZmaXFQ?=
 =?utf-8?B?SW9YYzQzNEFSeVhyMHdNV3o5bHRKTUNkcVJFdUc4MUJoQ3Y5a0E2SHZ3M2Z2?=
 =?utf-8?B?OWxoY3VrSWh0Mm13Sm96UjNuYVVBWkpzRmN3R3hmaExqblRyWnlqVnBkZE9a?=
 =?utf-8?B?U1hqcmNGNmxxZ0RUcTNxVkhyWDFmQXhncnFFWnhUak5nR2hRNVIwMzd5eEg5?=
 =?utf-8?B?TlQydnl1K3hJTW9PdXVZU1dRSGZDQ2Z2ZGdBZDBIbGttcDdlRWFIOVJISTR1?=
 =?utf-8?B?YmExaVduQ2poWGZNZGRaNzkvMVF2aWlEL0FTMGw0OTJicTdUWXNydlpiU0w5?=
 =?utf-8?B?V0NpQzAwN0pWbWFOTEc0WXFReVJVK3ZkbjBhc1V3am5rbWlYazlHZGZkc3ZY?=
 =?utf-8?B?YndnQjRTbDY2SU00TGpXbGRIb0NCZkwzOXU1N0dQTmd2WmtOQ2llT1oyUGRx?=
 =?utf-8?B?VkZ5Ui91b1Y0OUk3YjRxeElMUmowVXp3Q0JNY05KK0tqZ21PVmtsVG0yd3cy?=
 =?utf-8?B?dytlbXdOOFprVmFUc1hIUmQ2Q1Z2V29rSXZFSSs0ek9jQjJxbFc0NjY4Sm9q?=
 =?utf-8?B?U1JndWVaK01BRU9ZVWJPa2M4d2JnT3FvN2JWU0twU1Q0U2YyWlJia2lDdDJU?=
 =?utf-8?B?d2FuekVaWFBLUjRFNmhLQWJkOFo5YW9xa09lWkJIazJGNnA3K2ZCQ1B0c29n?=
 =?utf-8?B?azU2NzFsaDNPTU8xZWlZSHpxYmtyOTk3TVNKMGJoZmNPVE9pOElrVDlZVE16?=
 =?utf-8?B?RXBUakIzd2wzaVFocVNUWHlpeWFvNHc1eTdWczJ2VWtXNmJ2QkQ5c3hodURU?=
 =?utf-8?B?V3dFdEVCL3BURHBDSlkveXJ1OElwZGRUVHBybTQrS25VS20va0FXRkcraERn?=
 =?utf-8?B?aENiVFF0NGdzOVVDSFE5SXJmNWo1QVJjOUJsNEI2eVp2bDhrdTMzSDFtWnZI?=
 =?utf-8?B?NWlWQmdYdE9lRDJhSENoU2x2YUgwc2duV0dtczNHNGVrUHY1ZzR3TjNZUWhi?=
 =?utf-8?B?ZjgxcnJZaU8zL0NKR2kySFZITDJzYkZSRmpkRGZXTHZud2k3M0RIaGl5L2Ev?=
 =?utf-8?B?OVlrUnVaOFE3S1RmUjVTYjFmSmRtbnNJV0tlL3lwZGNvNHpWc0gxU25wY01O?=
 =?utf-8?B?Qm9tQXNnMmZOamJEbjF0S2JaajQ4ZlAvTU9HMHQrZCtYdzlwRUJma2kyS08r?=
 =?utf-8?B?Y1N3SmE0WmF3NlhZOEFhNytSekF5ajMvQ0o4aW1LeFNoY3ZwalJoMkp4Ynln?=
 =?utf-8?Q?F6n31QhXqLUhC4zY=3D?=
X-Exchange-RoutingPolicyChecked: 1hDv9IMXPsfFgF4aEXyqI7vJlNKbhsI48s1ZgEdOf/Xa6cgwssEY7fIoW0BMJyJ3QCDNjLMO1gyR+wtEsp7hmP6l3UPBB1VTA2tLUv9VfMrDLcgYSnlxmRCIi+D/ShfTeDhnqzzIFj4pv4vjZFwOQVkadZiQeZJUlUoU/kPK9Wd7F6yMukQcwddwTRFagVuofLemuG7mz02ncp0+aX5GN8xaUA88la30oNctqeyDaboODLSR3gPW746qmlFgOTAYTQK0GFoP6/7netJTAAtHOaLp0w8F6kFF5q6OS2tHTY4O2cCXCnD46001G+WRxAOD7QQL2A61SBvWWAMpDw5mdw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f1ec7ba-cfd6-4c97-1d8d-08df26fc9c53
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB2993.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2026 18:30:50.8137 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kuEA4y2SYfzapk3UStvXLKBnvFbH+HiKDhNb0Jpxu82Ycan9RoIxItowa9fjV+ILyFD5V13Qt3crtBNI7X1Tbcatlz+qY3EixMqXyGS5VGw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF524F3F9FA
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

Acked-by: Vladimir Medvedkin <vladimir.medvedkin@intel.com>

On 10/9/2026 11:58 AM, Anatoly Burakov wrote:
> Use the new flow graph API and the common parsing framework to implement
> flow parser for ethertype.
>
> The old ethertype parser was accepting certain things that were later
> rejected by the actual ethertype installation code, in particular DROP
> action as well as dst MAC address filtering. This was removed from the
> graph parser.
>
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---
>
-- 
Regards,
Vladimir

