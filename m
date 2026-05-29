Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5258CCD6E50
	for <dpdk-dev@archiver.kernel.org>; Fri, 29 May 2026 14:35:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3EC594021E;
	Fri, 29 May 2026 16:35:41 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id DF3F6400D7
 for <dev@dpdk.org>; Fri, 29 May 2026 16:35:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1780065339; x=1811601339;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=OOKDvanVBznYSEERBxQ6GILASBL2ZwAbiYylLSEXcIk=;
 b=c7kN3x6Pfd1755Py+y1uFtmi2leTin0xJXLIGZroNuLmJ4kfLb+LUhJv
 7zDzN/bSekTbUI1ADboS6rbrO+JFdNoXD9iOeh2hT69vGycgseiis965H
 URTO0g+8kA6DKCeARq/tMiLdIlylBCpN4y6u+xD3XXUKdLlxHi5KK3oNL
 WIn5AOS9FGTiU1s7/MoX3NTqiQwEPMQz8drvG91V6QItEG/bcUK1lNtQd
 6K6Afbi+LpBMQod6juULsFJ15MsNDzxuH5SYBErdRsUE2mcv8goJK2rCt
 vKa7HcRjJHrhhCVmgo1QJnGnejIM7WDy9WWAy0pAMZqT0BtTtPbrWb5pN A==;
X-CSE-ConnectionGUID: 9dTjQYwORZOsr0FTQ/AgJQ==
X-CSE-MsgGUID: bCUmbTSXRHi5UH3XxfZj0A==
X-IronPort-AV: E=McAfee;i="6800,10657,11801"; a="91601634"
X-IronPort-AV: E=Sophos;i="6.24,175,1774335600"; d="scan'208";a="91601634"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 May 2026 07:35:38 -0700
X-CSE-ConnectionGUID: vvF4ptv9SDSpXpXWm/+g2g==
X-CSE-MsgGUID: 3vGVSuAYTE+U0B06eq/H2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,175,1774335600"; d="scan'208";a="244692716"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 May 2026 07:35:38 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 29 May 2026 07:35:37 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 29 May 2026 07:35:37 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.18) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 29 May 2026 07:35:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YnzxYcd6b8fkYBM2wbQbQVabUdBpTGMjfctGcqK4x9n/6soUPut8XmhdLMB17fzW7/eHiPtYu6+dvr29ID9S3hxTP+YFdtsvPkxolMi/Fg8mMFGhno1QxH4A8kJT+h1rvXK8OwT/mmGx7EAo02TpNSELL8H0a9l4BTl+qqxy7+Qte9gdyiBA4LUXl67cxKutu+6Ue94nAsUjyg1Dkr0ERp2s0+RIjxgOA1vF2PRlP8Vr5VVAWsKmMLewGNa8c+RCdKU1OyIvCndfAhR/NsYo5UrAOKS5+DShTvc1XsUBj3M1e8OmQKqB0mrC26dFkxJMSOfNrp+THM/5Jm3x7heUWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DED5004z3igKltiUSAFzgiC08TxzdEEax/7qeIu1r/w=;
 b=VjaVQmPsC3S3NwaMyeDZknda1LpjGOivLepfUrVsILy/+nhrs6V6JNBvcgBuQbpyjjKgWvwlDuGyGlj56afvK1y++gSghUMFLv4WQbotgltaTXJ2cc5oE3mmqBBOvRg+N9Vz5LsuU56PdfuKuCGG43HIt7rvWk4EvJfeuvdlGtzMXBa43EkLhdwj7j9H5H3EpZ1McAAXsomY2zVLAcJtyOJTv/2I/AgltcBx39zkz8jhDgAPcPsdcPx3BD82nciybB71LEsbv0OeCcTI7xTIuOZs1nkMee1IUSstTWpJnv+G4ODoYRva7Bh1BYtGyJiKtYQ3zRGT9ZyNlZMTijPYPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 DM4PR11MB5311.namprd11.prod.outlook.com (2603:10b6:5:392::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.14; Fri, 29 May 2026 14:35:33 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4%3]) with mapi id 15.21.0071.014; Fri, 29 May 2026
 14:35:33 +0000
Message-ID: <336ace81-3a38-4bbe-b5d2-003fcf7b4f17@intel.com>
Date: Fri, 29 May 2026 16:35:27 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 03/27] net/intel/common: add common flow action parsing
To: Bruce Richardson <bruce.richardson@intel.com>
CC: <dev@dpdk.org>
References: <cover.1779717943.git.anatoly.burakov@intel.com>
 <cover.1779717943.git.anatoly.burakov@intel.com>
 <00d686796ef0440ca63220d468ed3d15ccf4894a.1779717943.git.anatoly.burakov@intel.com>
 <ahbwtDTZDcztR9zl@bricha3-mobl1.ger.corp.intel.com>
Content-Language: en-US
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
In-Reply-To: <ahbwtDTZDcztR9zl@bricha3-mobl1.ger.corp.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PAYP264CA0021.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:11f::8) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|DM4PR11MB5311:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c4cf8b0-9495-478f-a1ac-08debd8f8a4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|22082099003|18002099003|56012099006|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: TN8IEgnCYzs96kJloETSzvewRp/3J1awirDGGQWesEmIwCl1JU+ShG5RJQ9L/NfjIpIIu0SV18hn3lHwD5JgpkZsWEolwUKsZvVLSeO+4h7ruhuEVfg8JaICcDmKEMtlwB9xc+TByyrCMZeoP0ysH1svtZeB1oItJ2jqsjC8SsWrKRVl+W5YVGqyfVwPd3lo7ari97+ClCL/vuZF/ynzxNSJgnq9XlYLdh9l5pVbxdDx4drA63X/26tF8SEx+HkmnzgFgH/wTqIrAxI6DI104hwgA4Tut6RrLCdZazYuw9Lfs8EklwuTmSIrxVpAMLCM/C7Kvauo9X1D8+87/jGW5hmX0Q2Muz0QccVUixkbGCXei3NTw6B3xAfaczgq9dSXSGrE/mrB7MjNpAPRHM0MDxlEyimPNXgNmrFp9vD5/38xX/Tk1wpXW5VeFXPjSRIyTCJF9+gB3YxsuVL++e48hmgW663U0EanPpAaXbb15qTtqoLNBp6N3eXjEm/zuZMwdTtExIBbaOpGl0cj4hdxjKt/d2xMBmkpGkA2ny/JD2t8chrUEKf7WwslOHr5qE7P6K4KCpgFu3l/gFcpvdY+Hh/qnqOE5AfJoqV/ORg2XC7JmywUoiUPHtsey8RywPI7ITJXhKRCdFtXcOLHpURV858Koe+VXNvyreGgFQYXqtRykLi4P9O/gH5xOmpYMA8c
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(22082099003)(18002099003)(56012099006)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QlpGcG11WFhwR201Zmw4ZTlSQXlxMEtHam1kUHNaTWI2czhHaTh3NEVCc1RY?=
 =?utf-8?B?enhjbi9TcDIrQi9XbTAvTnVhNi9lWTF2Zm5hZEtzRUtzeDJqd0tRcnIrUGI1?=
 =?utf-8?B?cWJnazNpTnlPaGwrVVRodm5CVW9VUHdsQmVGMy9jYUVJUk5KQnpCMWVacWJa?=
 =?utf-8?B?MGZNMHo1QmhzeGFXZ1BsMXhyNU5OMG1WLzUwbmttMXZSNndGcHE0TUhCL2Ji?=
 =?utf-8?B?bW1rQlNNaW1nK1JDNFdCbWo4enJUeWxkMFBJNXhNRlpPc0tuNWRrTUdEcjBE?=
 =?utf-8?B?VTB5MU1vZmFyVlBCcC9vZDVNMGt6VmRCOEI0ZWtPWlUwY0FCNy9CcE1aZElz?=
 =?utf-8?B?eHdQNVE4d25SbnBYQ0xHdzE5RVMrSzdVNUxKbUpoWmd0ZUowSVBFSm4vOVlS?=
 =?utf-8?B?dVQyT1pvQWNZOWNrNjRVSUthem40R3dFQjVFeFdZUU9zNFExcGRENjVEb3FS?=
 =?utf-8?B?ZEhQYlJla2RRUk5VQ0lEZUp3UFRKM01jZVhwbHNacXVQVHlsUzRVSDBWTDZT?=
 =?utf-8?B?d3dJSlF3eE1BTERXbHNkbEhRSHhTaXdvcEllUE01RXgwUnY5UksvZ3VKZEx4?=
 =?utf-8?B?K3dvWStkOEVSZHo3cDFadGxCSVlRR21naE85Y1AranU0WXRWSVQ2WWVsOGY2?=
 =?utf-8?B?dlY1ZnBsdC91OGZiZG5kM2ZFYjVYZUJFK2IxL0xUenVkMW9iSGEvMGtKcE5K?=
 =?utf-8?B?RG10WW05UUFpbXZDV1pZdDhEcjJLQXZWaitGbEt5UFlqK0xaTWJtdHpyTzd5?=
 =?utf-8?B?ZmZHYXZYQWtYUnFPWmViL1NJV1F0cGswYm4vQmk4dGcxaWo4RkZTaXcrSUNE?=
 =?utf-8?B?U3RrL1FVRXdKbGxPSUlkTVd6Rk0wOU9DTC9OQUkzallsVDlEV3IwZjlzTzNo?=
 =?utf-8?B?dXNvTkxGbHQzQmphbVI0c0RSbDBVRGxKZ3dudkFjZ2krYkEvVjVpNlpsMVlz?=
 =?utf-8?B?L09VbmtSTTlLdWNPbHd1NHBnUnh6OWV2Nm9Jc3cxZEU2NE1oekw3YWk4cHBp?=
 =?utf-8?B?SDh5czVzTTNJbTdIMzNGRUQ2YW1IdGpjNHk4WHU3YmNvdFh3dXVLKzBKN2tN?=
 =?utf-8?B?Q2Q5aXhqQVhuM3lxcjlITHJ1bHFUd2czMTRvNnF0TFJqV2dvem5rRmNGVnZn?=
 =?utf-8?B?OStVallDb2pjN2pvWmJpNEkvOTM3NFZySm9uMGx5ZGx6OWRGcy9aM2NCYm1R?=
 =?utf-8?B?M3dpM3Q2RVUyZ0JmdFJjbTVCMWFvQW5jcUgvMnNaZHA4QU13OUpvdnBoUEVt?=
 =?utf-8?B?OFlsK2hxZWxWaUxIQUw1ckhNb2pWZXhJQ0Vka0pBRm05WVpXaG5HWWp1a2pD?=
 =?utf-8?B?aEF1Mk1sU3A1U3Q2c2s2YVBCVzVpRGxXbVFpaTlpaEUzazB5bW1YeXQ1dnpz?=
 =?utf-8?B?SE9MUExoVlArOEkwZ0RET2RHeHdUVVFxVjg3N2lsNDhGUG4xVEhJK2U2UlZM?=
 =?utf-8?B?bXYveXpMQmdvUnRHeW9Va1ZnRFZ2c2VxbVBFSitxQ01sWDBMU3RlZFpiSjJ5?=
 =?utf-8?B?MGhQSEwzUU9tU1NiZ3lidXhXL1g5TGJKMTlPbWhIOVB4UU9RK29NNFRHb1or?=
 =?utf-8?B?eXpQcVBmbkkrdklubVNmYUN1TDVZamduUUpra1ZIYXNBV2I3R3d3UmwwaG85?=
 =?utf-8?B?eUF2b3ZPRytaVUlTbTdxQUM0a29nejZwL2xSVUEzY1o1NkRIZUhZYlpjcTdt?=
 =?utf-8?B?dkFBSXNlTk5WSkt1bVZPaWtMMmZQOFBoaE9VRHhwcXU5UXpyaEhDY1NrUE93?=
 =?utf-8?B?UklVRDZXUFVrVlRpaDBEZ2F2RGhLeHhCRk1RRHF4SlhrT2dMWXJIU3M4RUlC?=
 =?utf-8?B?QTdUYm5GbUM1Mlp3Qk9Cc3YxWE1FbWZSbjUvVjRnZjd3RHdkenNKZ0xFdVlP?=
 =?utf-8?B?NjNmcHJXT2FlcUNlZ1hLaHo2RXlNRHMvenlRZ2w2VTNPRmlaOURZNjlCanlJ?=
 =?utf-8?B?Uk93UGF0OUR5NEZjMjdZY3d6ckFBU2xnRTlVTWdBK1RVQWVFNDFZVHYrNXNN?=
 =?utf-8?B?UElVMSt5RVVoVmlJbVY1SGdYVUdJWkFQOGxYbTRDcWQrcng3ajd4VmFjcFVz?=
 =?utf-8?B?c3JJZEY4eFdYWkphQlY5SmZvWE42Z08wemJHenlyU00zSGZ4eDA0N0Q3ek5L?=
 =?utf-8?B?Y3pmampPUXpOVldBY1pIa1FJb0RNdWd1ZnBHQVplMThjYmxJK0pqencvUXVr?=
 =?utf-8?B?WHdWbUVxQXRZTTk1a2lWcnMyNFV6L25UN1owU1Q0WHRhUzM0ck45MFp6d1VT?=
 =?utf-8?B?L2RiN0VBb1FmZ1hhL212SGREMDg5U0lsaHo2VDBtNGg0RGU3dkI5ZW5qWTlm?=
 =?utf-8?B?c1lZQzJ5TmpPR1NTc0I4MWJBWFRHNlF0M2IrbWg4NklSclY3MVFFRWs4eXow?=
 =?utf-8?Q?4gUwvGHDt8uJEFTo=3D?=
X-Exchange-RoutingPolicyChecked: m6ncV/Kq60PyO8Y2V9LrfzBuMDbeqoMWDd8XLSGei/XWEm03pEBulaMVDOdQsaVf7dcRADQ8/mRC4cCjMrqRjR4fwfrmg4gFY4hnMUejJ/M6RSxEzTB6LIoMqgmzHzdsjZvqP2cf7QjPxXXAzrX9paTR2sdt1V15hgRl8w/6U+mX6ZaG6OUBU6WtO4e6FqCG+8zOihr87ZLXtZrIkHs5RLNExvCN4uP2ejhTXArvhlgOqfrBH/Z9dQZV3+cA5nQAe1PZJxtiDYJ8cONVHWqZI+iMTNLvDJpBPV14KAnKzH1GvyBR3VLTqjQApBNq8usfl8y6JejMDNpszkOzcQdnZA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c4cf8b0-9495-478f-a1ac-08debd8f8a4e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2026 14:35:33.4482 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RsGhjKeyIuP5STRsQEPylnUMxxeji4NEi0GWvqgYU7U5vw7YhPS9i4MXHcgmF8QdmAAK5EtfSipenrfkirW0aHQ5xoqZYZlzo4Pe2bRS/zM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5311
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

On 5/27/2026 3:25 PM, Bruce Richardson wrote:
> On Mon, May 25, 2026 at 03:06:22PM +0100, Anatoly Burakov wrote:
>> Currently, each driver has their own code for action parsing, which results
>> in a lot of duplication and subtle mismatches in behavior between drivers.
>>
>> Add common infrastructure, based on the following assumptions:
>>
>> - All drivers support at most 4 actions at once, but usually less
>> - Not every action is supported by all drivers
>> - We can check a few common things to filter out obviously wrong actions
>> - Driver performs semantic checks on all valid actions
>>
>> So, the intention is to reject everything we can reasonably reject at the
>> outset without knowing anything about the drivers, parametrize what is
>> trivial to parametrize, and leave the rest for the driver to implement.
>>
>> While we're at it, also add logging infrastructure for Intel common code,
>> using the new component name defines that are automatically passed to each
>> DPDK driver as it is being built.
>>
>> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
>> ---
> <snip>
> 
>> +
>> +static inline int
>> +__flow_action_check_rss(const struct rte_flow_action_rss *rss,
>> +		const struct ci_flow_actions_check_param *param,
>> +		struct rte_flow_error *error)
>> +{
>> +	uint32_t qnum, q;
>> +
>> +	qnum = rss->queue_num;
>> +
>> +	/* either we have both queues and queue number, or we have neither */
>> +	if ((qnum == 0) != (rss->queue == NULL)) {
>> +		return rte_flow_error_set(error, EINVAL,
>> +			RTE_FLOW_ERROR_TYPE_ACTION_CONF, rss,
>> +			"If queue number is specified, queue array must also be specified");
>> +	}
>> +	/* check if queues are monotonic */
>> +	for (q = 1; q < qnum; q++) {
>> +		if (rss->queue[q] < rss->queue[q - 1]) {
>> +			return rte_flow_error_set(error, EINVAL,
>> +				RTE_FLOW_ERROR_TYPE_ACTION_CONF, rss,
>> +				"RSS queues must be in ascending order");
>> +		}
>> +		/* if user has requested contiguousness, check that as well */
>> +		if (param == NULL || !param->rss_queues_contig)
>> +			continue;
>> +		if (rss->queue[q] != rss->queue[0] + q) {
>> +			return rte_flow_error_set(error, EINVAL,
>> +				RTE_FLOW_ERROR_TYPE_ACTION_CONF, rss,
>> +				"RSS queues must be contiguous");
>> +		}
>> +	}
>> +	/* if user has requested to check for queue contiguousness, do it */
>> +	if (param != NULL && param->rss_queues_contig) {
>> +	}
>> +
> 
> Empty block, and I don't see it filled in later patches. Is this for future
> use, or just an oversight? I see the check for contiguity done in the loop
> above.
> 

It's rather a merge rebase error...

-- 
Thanks,
Anatoly
