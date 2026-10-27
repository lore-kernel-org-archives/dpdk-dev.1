Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0892606A31A
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 Oct 2026 10:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=mXbqYKHA
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 093B24064E;
	Tue, 27 Oct 2026 11:57:12 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTPS id ECD9340613
 for <dev@dpdk.org>; Tue, 27 Oct 2026 11:57:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793098631; x=1824634631;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=I2idLwlagOs2RO3k2KCh/JlQ2hkvZ+hgled69wmT0cw=;
 b=mXbqYKHAnYfkObe/DxgO8b+ULlfQutuqJ0lZ7B3eDdyWXXA/si+h1YQZ
 cd6zJcj7URbbuUMnFRF5hnYCNzEzNiCVufsQir63ddwhSGl8uMk7OHSHS
 lBLKNMIoSgc5IVbs2hUvvFvgFlf9Zje/9rqfI519bqR0qXYW56qWoFIWL
 E4JCCvIiLPi2f2OtnnbxNtohQ3Vl8D8weiUGVSljT5oZ376Rr1q8ohey3
 6A9uYb10p4FbwGGtyTkcq2t+AfQRJ23qOIdHK7mrgDQg/Z/7E0meTZnx9
 bCrFrG8Zaq+ioYCCLAfgETDH0zTu/QJE3Kc34UlMKh/wEgv26Rs6Kc8cc A==;
X-CSE-ConnectionGUID: 9BVq9vAWRNKvErb7Ha7yqw==
X-CSE-MsgGUID: i3L/K8EeSTeyJThqULagHg==
X-IronPort-AV: E=McAfee;i="6800,10657,11947"; a="1825467"
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="1825467"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Oct 2026 03:57:09 -0700
X-CSE-ConnectionGUID: r8p0YBRoRPmONa2ukYN4vg==
X-CSE-MsgGUID: IXXffpj+T3KbO0c4VaOeGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="4597749"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Oct 2026 03:57:08 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 27 Oct 2026 03:57:07 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Tue, 27 Oct 2026 03:57:07 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.33) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 27 Oct 2026 03:57:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BBY78X2BnG+tT+XgA5Mp8+YP9CaobDTg9mHieJbiI6MXYPJH4t3wr58MkKtuSbgYBXtOs3q3qCtWHWprbWvjXK2QGV3TKw58+T7xWFH9XDJWAw5IDYHmCdcxpnJHjxFqxFlNsOjW17/1AhPHn5FBuOyvS1MQD41c5BWJbwU1Ls0Vk1p+aJGwVN6DaZz1c+CyxcZRa5+VihZaSPkOlUO6OHQihD3FVR/xg4SK5EBNjD53Vi8eNugopxNWb2GZ98Pe5Sv8T6ZoUN8//Vd1HC/9geSIdLJZ45BuG2jmegkw4DIPzC9r3yTdE7cDwamhYnQ4fxCMGdozZKsz6g7JsHawlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h49IwNWsG+KAm9hyWDatR7H/oAzTECgspoSg0I1SDgE=;
 b=M48vKYwFSmvgWcKMzPntIiV4uhILCMZiqiihwmoLd/Zv6wupm5AZu9Gky3h00V63v/45NvqZi1kPB/eu12fmD9hWtHfttxwwedtVWB4T7QUN95B4imCEgWj2bg30OA9uxW0KJ+C8lYMzvTrxXg+tgmbJX4/VIFtWjXJ+imiTCObvuh1E6kvaHEdkA3Z4iIxzbo6ETVNW62adL0v+C1Uon8p+DMKantOD6wTuuDssSDOWy5N/sBvWNv1+xg9I6isym6gEOzpiR13V6agEHsjSeg6mG3pYCdksoJoUjoYoGBZHv1GmFi4vrrnvEZGkyS54PFXEfq7R0IeGhbjlvBQsnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 CH8PR11MB9457.namprd11.prod.outlook.com (2603:10b6:610:2c3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 10:57:03 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4%4]) with mapi id 15.21.0546.017; Tue, 27 Oct 2026
 10:57:03 +0000
Message-ID: <37ddc317-fa9c-44bc-9256-16de74f84dc9@intel.com>
Date: Tue, 27 Oct 2026 11:56:58 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/5] ethdev: fix flow conversion with null buffer
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>
References: <8fa05595f3596e9355dd90df7fc278b104beb20b.1792757739.git.anatoly.burakov@intel.com>
 <5698ccb3daeebd1d50346d5a3bd8471468056463.1792849824.git.anatoly.burakov@intel.com>
 <20261026095108.7ea124df@phoenix.local>
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
Content-Language: en-US
In-Reply-To: <20261026095108.7ea124df@phoenix.local>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0037.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:468::15) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|CH8PR11MB9457:EE_
X-MS-Office365-Filtering-Correlation-Id: b1b17a71-3346-446f-1ca4-08df341908b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|261009223027099003|261021121427099003|261022105027099003|10067099003|56012099006|3023799007|261026140227099003|6133799003|22082099003|18002099003|261026121527099003|5023799004|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: 39P8Bm6Mup8wspCu4izXAGeOXOOWhW7cDd8dz1ZVLlxGUFcZcMfUBVL794P7zvG0nj89QixAi4VqhgL5fWc0XOHse6IxfHDafGdkxNjTxzKAjUcNLB9peB/m944Den1QhsSQFZ3kXid1OoHsnogfOpBxxAo90xdDC1Bo9oQRyfbHGFJ0ZOAaFTziB7PeZ16hjGeLbMplfUFoJvnLMLA2wngVivRnYhRvny/Cm/IMwJR7scm0mW19mII//egakpL5VaeX0eLY8w5hDeMV9+cnVSwCK6g4xRMeLBT3p1l3M8G7pa4TYlJXURng9FkydEAmu2KMy4W9FVwBAvnMQgBzXNQuxeK8Ckf8Jmsia3FksRV5qiZh5Un7CCIjZx9uUFajtwtF5MoOASMBWbIRQdcWtIRXB0FUOQJRqFvP71+7Ag+7zgTM8qfNQwiZnDnz4knSDe8H9InqKejctVUxt5ZhxJ/djkAqIPLY/K6qG/4rJpWmOA5Xy8DqMzeTuJ0twz5TQZUhoDMTvmHRE37Ax0sEwhaaiwdBZK7qqYLbemPbCqKd6UqzMqFDnH7jdzxpL6vbMHOah+Teenha9YB1vQLKmqZihhl+njFGxtBxc5SX79ewXXauGiDijxq+z3mmdYia2xIYDW9SmA4fhxYWbfZsMFhPCY4UcTNDM23jfRNu3O4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(261009223027099003)(261021121427099003)(261022105027099003)(10067099003)(56012099006)(3023799007)(261026140227099003)(6133799003)(22082099003)(18002099003)(261026121527099003)(5023799004)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Nk11dWFFWGpnU0NwRE5YMlRyL01DSnVRTWw4ZVBhd0dlVGFUYk5sQ25kUzV2?=
 =?utf-8?B?MG9NdjlNSDIwNTVIeEc4K1BLVnNoUWFQQnlMRXMzcW5jYUJLYzhPcnZpVDVx?=
 =?utf-8?B?TUhQQ3RCL0tPVTZnb1JmUmxHTFhEeWY0eC9DWWt6WW1Zd0JMSitpQUo5cXJL?=
 =?utf-8?B?bUdSL1FGUU5LcE1ZY0YzRHdITmNBYUcvZGFmQjNDdG5TV0owcVY3Y0YxcG1j?=
 =?utf-8?B?amN1MXZabDBzektRYjR0L2ZJU09QL2FHdDVWekVvYmhmMXpyNSt3QmZORHlW?=
 =?utf-8?B?NzNreG9PVVE5dGEzcVdEc2FqSXY2ZUZaODA4R1ZDS1dUVGRsOU9wRzdvN2NG?=
 =?utf-8?B?cTZvekpCWWowK05zdGNqZnNZbGVPd3RkWFByT2t2Wmx3NmVQekxuQ1V1UUty?=
 =?utf-8?B?M2o5cEN4V0xSRGx2TmRBYXJGQ0ttSTRiZTEzemV0NWZ1TitiMVBBYUlJSHdI?=
 =?utf-8?B?YXpsekN5VXFJd0RuL2F4MHk5TmRhanRuOFhIRHVFNjRMOTN1R0VhYVhBRnp1?=
 =?utf-8?B?anBjZ3Q4OUZaS3FDcFNmelUrOGJXMDhhL0diME5mMnd2d1kycURJeTlhNzNT?=
 =?utf-8?B?Q1E2eVFNWStYNjVlcDk0bS8yU3hyNXBtZ24waVVqY2xXQ0k3U3RDOUl4VFVR?=
 =?utf-8?B?M3dNcG9lcjZrNkVwL3BabXhoaHVLMWJSZVpyeXUyS3hiUHN4NGxIeGRGUnZq?=
 =?utf-8?B?NFdmYzlDVXhVc2hTT0ZEajlDdlhhNm00NzZEcHlucEJFbllSVGlaaHBuL0J6?=
 =?utf-8?B?ZnA4RlJDMVhuT3VPOEdHTFNabU1pejlzTld4a3RZU3NlQzBQMXF6VkZiU3Y2?=
 =?utf-8?B?RDdXVGsxZnhsYlZZSjNzRUhQU21oUCsrM3U4a0c4dE1wRU9qS1E2MU92d0J2?=
 =?utf-8?B?dXlVSi9JVFoyeFdJUEtCQk15ZlVndkNmWUMzZ2lINUhBUitOcEhCQWhjckg4?=
 =?utf-8?B?M0VaSHpTUlgvMnl5cndYUnhYZ1ZDVkFzWWFFd0NMTFhwcTg4MXM4SjVuWlg3?=
 =?utf-8?B?YlU0cE0vU2ZyZGtSb3VRcVRzVEpWZmhQejE0VGExdU9EWnNnU1pvUWJ1cTQw?=
 =?utf-8?B?STBzWFFxVHI2Zk5COWFmbFdFZnhuTkdPVUh0aWpVdTEwUWFrTGF0SlRiLzkz?=
 =?utf-8?B?Y2ZRUzNtb0xBNVMzSkNHUGIxeFZ3MzFHWG1RZTE1aU13RDhkaWdaMkROQUE1?=
 =?utf-8?B?UEZRRWFUdmd4SUIwS09sS0tuYkY4WDF6U0VpYWxOalpJUERnQ0tGV1pRZHFp?=
 =?utf-8?B?QkMwV3h6eEVoa082emVnSXJhRWtwdWppc3FUSVB5dHpTVkFybExMWHZPVjlU?=
 =?utf-8?B?OWlqOVFWV2hZeVlMYzU3TXFKeGdVWGpTTFBXRzNkZnJjeTBFNVBnbnZYUk0y?=
 =?utf-8?B?ZlFsSS9VRCtpeGFLRkNpeVlqZXpqZlhTdnZVMWtVTDIrS1d6V2N3T3BuY01x?=
 =?utf-8?B?QnVtWW1veDg2RmU2YWdzZ1lPbnhadzQyMkhKbDcvWDAzVHhzN3FYVVJCcmpM?=
 =?utf-8?B?eTN2UGVXdk1HL05Ic1hnakFqeC9mQjU1WUpkOGxjdVB3VE9uTitNQ2xseS93?=
 =?utf-8?B?RnFuc3FRd1pyUFFUd3JheGNxOEwyWDNYVXdFWGpOdWM0WDZwY1B3SmdCSEN2?=
 =?utf-8?B?K24zZVpkbzJoWWl4allleGJ0cGVCOUp1SEE5bFJTR3YzUTBOVFBQN2JsRTd1?=
 =?utf-8?B?eW1CdW15aFY1STJ1R1RoSDZDMUcvV3BwU0FHd3UvTDJlMi9pNk5jbGN5WHBs?=
 =?utf-8?B?WVdxUE5Gc2RFanBCSUptajltZkk5eFNMM0xtR2g1TWd3dnpJd3JiTWFDQ1p5?=
 =?utf-8?B?N1EzaTc5OFk4K3hrOHFKTGxOSEVKcHR5T3d5ZjcwbWZxWmRPandFMFViL0dp?=
 =?utf-8?B?Z0VHeEV5c01HVmgwT1VTV3JweVArWFVJMVRFZXB0ajUxR3lsYUlnck12Z2Q1?=
 =?utf-8?B?QnJOSElMQ3BuWmx1SXFWL3BOZlpwUHpHVDAxSi9YWi9qSVpnNW5oQjYrRW9R?=
 =?utf-8?B?ZVB6VENSRWZyTlZXdStxVEoySUJmcUxSckV4RWRtZkJ5bXlXdU5GU2NpSUZh?=
 =?utf-8?B?d2JqZ2x3Umx3WVVla1Z0aENNS0ZOTVZXUkZLazUvSlJ6OW5PR25NYWVWMGZv?=
 =?utf-8?B?dk1WT1F5dElQT3Baa2pFM1I0UDhYbndjSlZSY2ZsNThwZkZzQkQ5a0NkUi8w?=
 =?utf-8?B?MzhzcnMxRG1zelJVaGNEMXVUc0VldklIODJkTS85aGgzTDNkaXoyT3ZBUUt3?=
 =?utf-8?B?NVI3ZVFVdjBjOHFkbmxiQzVWNUR0OGRYWFhOUzhCQWE4UWFEc0htVmMrYWVL?=
 =?utf-8?B?aXp5cGlseVNNOG9jYnpFcWVsZUF6bW8wRHd3Sk5IdVAyYlBZY1ZkMUxFbHYy?=
 =?utf-8?Q?oDFO3MLXx65MW4I0=3D?=
X-Exchange-RoutingPolicyChecked: Zmg83q/DIPxHG3rNci1ZQyDRIFQEY/W2DBsZJwRkCOslT423c/G1H34SWUhmrqqK2RbPIpZUAHRFy1r8HNrDy++Xxj5czQvK6Es2luITgrC9U/SKxnBtiWXzM5ufqNhLcAV+YNbv9sVcrBkPoWiV3kfSkHcZUb5NO0/m+u9txVTAfHs1ZSrRLBhosV5pTRPuhaVi4+bBZGZ50DzUYcxQpRcY16O9uhq+ZpF/CfWUoqVgCSG4EONxAQLMdW0OzvIMo8WiQeDFeQ1e28NuFh6ZWIeT7MEEguW2bDPXjnYE3rXpKqojdPiuAe9WYDA27aRUeYJMMcQHzLULqriiq2DBwg==
X-MS-Exchange-CrossTenant-Network-Message-Id: b1b17a71-3346-446f-1ca4-08df341908b6
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 10:57:03.6858 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 53FBcthx2FEYeIc27tnLI7My8G3zE8ZjSqxCRCiJwY4XD6HV0Boa0625//WMGAO6b0tvPcMbsm9MetsBGi2/NI2sOr+Tv5VbBGE+aJRxy10=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR11MB9457
X-OriginatorOrg: intel.com
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/26/2026 5:51 PM, Stephen Hemminger wrote:
> On Sat, 24 Oct 2026 14:50:28 +0100
> Anatoly Burakov <anatoly.burakov@intel.com> wrote:
> 
>> rte_flow_conv_pattern() and rte_flow_conv_actions() document that the
>> destination buffer may be NULL when the size is zero, which is how
>> callers query the number of bytes required before allocating. Both
>> functions nonetheless walked the destination with ++dst in the first
>> pass and dst -= num before the second, regardless of size.
>>
>> Pointer arithmetic on a NULL pointer is undefined behavior, and is
>> reported by UBSan as "applying non-zero offset to null pointer" for
>> every RTE_FLOW_CONV_OP_PATTERN and RTE_FLOW_CONV_OP_ACTIONS size query.
>>
>> Keep the destination pointer fixed and index it only inside the
>> size-guarded writes, which are never reached when size is zero.
>>
>> Fixes: 063911ee1df4 ("ethdev: add flow API object converter")
>> Cc: stable@dpdk.org
>>
>> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
>> ---
> 
> Manually run AI review sees some problems.
> 
> Subject: Re: [PATCH v3 0/5] ethdev: flow conversion fixes
> 
> Series applies cleanly to main and each commit builds with
> -Dwerror=true. Descriptor tables now cover every item type through
> COMPARE and every action type through JUMP_TO_TABLE_INDEX.
> 
> One correctness problem in 3/5, plus a pre-existing out-of-bounds
> write on the same code path that should be fixed while here.
> 
> 
> [PATCH v3 3/5] ethdev: fix missing flow action descriptors
> 
> Error: SHARED is now accepted but its handle is not preserved.
> 
> The new entry is MK_FLOW_ACTION(SHARED, 0) with a comment saying the
> handle is stored in conf as for INDIRECT. rte_flow_conv_actions()
> only special-cases RTE_FLOW_ACTION_TYPE_INDIRECT. SHARED with a
> non-NULL conf falls into the generic branch, rte_flow_conv_copy()
> copies zero bytes (desc size 0), and dst[i].conf is set to
> data + off, a pointer into the output buffer instead of the handle.
> 
> Before this patch SHARED was rejected with ENOTSUP. After it,
> rte_flow_conv() and rte_flow_copy() succeed and return a corrupted
> action. Handle it the same way as INDIRECT:
> 
> -		if (src->type == RTE_FLOW_ACTION_TYPE_INDIRECT) {
> +		if (src->type == RTE_FLOW_ACTION_TYPE_INDIRECT ||
> +		    src->type == RTE_FLOW_ACTION_TYPE_SHARED) {
> 
> Either that, or leave SHARED out of the table since it is deprecated;
> but then the completeness test in 4/5 needs an exception for it.
> 
> Please add a SHARED action with a non-NULL conf to
> test_flow_conv_actions() and check out[i].conf == actions[i].conf.
> That would have caught this.
> 
> 
> [PATCH v3 1/5] ethdev: fix flow conversion with null buffer
> 
> Warning: INDIRECT conf write is not bounded by the buffer size.
> 
> Pre-existing, but this patch rewrites the line. In the second pass:
> 
> 	if (size)
> 		dst[i].conf = src->conf;
> 
> Every other write into dst[] is guarded by size covering the entry.
> With actions { QUEUE, INDIRECT, END } and size equal to
> sizeof(struct rte_flow_action), the first pass writes only dst[0],
> then the second pass writes dst[1].conf past the end of the caller's
> buffer. Suggest:
> 
> -			if (size)
> +			if (size >= (i + 1) * sizeof(*dst))
>   				dst[i].conf = src->conf;
> 
> This also covers SHARED once 3/5 routes it through the same branch.
> 
> 
> [PATCH v3 5/5] ethdev: add flow item structure size query
> 
> Info: the NULL name checks added to rte_flow_conv_name() and
> rte_flow_conv_item_default_mask() are hardening for the strlcpy(NULL)
> case described in 2/5 and 3/5. With those two patches applied there
> are no gaps left, so this is fine in a feature patch. If you want the
> check backported, move it into 2/5 instead.

Thanks, these seem like real issues so I'll take a look.

-- 
Thanks,
Anatoly
