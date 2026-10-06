Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85EFACA5FED
	for <dpdk-dev@archiver.kernel.org>; Tue,  6 Oct 2026 09:23:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1727A40270;
	Tue,  6 Oct 2026 11:23:26 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id F16AD4025F;
 Tue,  6 Oct 2026 11:23:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791278605; x=1822814605;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=Oc3SGAJ/B+2zDN4+JFqMMSpGuycNYMJJrnVI0chQrsE=;
 b=mczoeKmXkm0Z/2FL6lWneB4Lz8dNftVSRWjk5pI2ALZ0qkFtAWv6yOUq
 g8ShYxdW4BBqDVnFq2Y9PsNVsJws80Y8wh6iMwjNE4Ch+mQoQ9OJjMOFy
 Hvqb3yNxMC1pqw9U7f/n270J/+h4oZOkiNh4QmCNpZUHAxd2aXD6zNvCz
 8RAGe5dwQDZNO4+49bmfphmlAEybHi3cnbfITRrK7JQ0JnMqBNlpVN87p
 J5dp1jIBBOhVXMIQPZL4KaXo0FtAAdfvJ+1rz+gCms6ONtfa1lD/UH8Zf
 1cmy8ExphLYpa09C6t/odSJXehdr0NzqUq/NOyWignWJqTH9f2guFjp15 g==;
X-CSE-ConnectionGUID: mhjulEWGTVe4yCmYOlOK5A==
X-CSE-MsgGUID: vwQKsuwLQ0O7EoeRG4bx8Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11926"; a="102482578"
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; d="scan'208";a="102482578"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Oct 2026 02:23:23 -0700
X-CSE-ConnectionGUID: Ihxil416TPWejun+1kdGpg==
X-CSE-MsgGUID: MS7HDLYnSaK5QtGKx4qnnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; d="scan'208";a="276626784"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Oct 2026 02:23:23 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 6 Oct 2026 02:23:21 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Tue, 6 Oct 2026 02:23:21 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.11) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 6 Oct 2026 02:23:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HMaLofMJ/5Oiz38EeeQpRdAsJzoPl//tWASGm/3y39kH2HJiK80rDDGGo2yuiXY4iR4ikDtk7kB4Hi+FnDfu1INJsajFNrUwQv9cD6wUIoheaIUuv4n+uTnqYxLeAskVHN1FEJoZ5FaTv23W/gwFWwEBYqZGrxrgSGeysGIH2wA+ohnCtc4Llvm5b/ZoX1SH5mO1Z0n9EOKWa/rsXZX4wshc6aQS5wJfnxF9z5Zb8Jw+lCT1QU+ZRH/DX8QQ2lVKbrWYlWnaCAYaFTXiLNN5ht5ZWmJgcODoA40l3rHn/Ic2pctTPfq6gqTpXCXt91ARBNyKpqgyKlzGsovlH/he6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rql+TMsm39+8L3k/Zvm8tHQ4F0bAy37o8c1dl+m7HVk=;
 b=oqGopssNCs6A3/lbRdm2iJKP85fTIzXQBZ208JHp5i3fcJv+tt9mvej2ucQWT5mVOqczNmQNNEyggLemNvE0U5qlWODdLlflBrMBJGPJMJ6nr8cL/F83dPuem/oSNUmn70Jh/6pUP4NQ1wR0ZGxlnT3F71id5W3QDWgR4xITkAXw92gLmaNA8QiLTX3AvM2HnO+H4L8Mh2ogfBtaHuv9btoVgO8QMLLncvX8ACftxQzlPgUrCQnDoLLphSWtq57p6C+E45C40G8he88/pwhngbaer4AAORtJDkEAeKvFm45xwz/VmrHfFb4js3kUx9NaEo3KlrvQ89ObGVBlBoXxtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 IA4PR11MB9251.namprd11.prod.outlook.com (2603:10b6:208:56f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Tue, 6 Oct
 2026 09:23:12 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4%4]) with mapi id 15.21.0472.016; Tue, 6 Oct 2026
 09:23:12 +0000
Message-ID: <9d10d4e1-c931-482a-b3ac-b8d2a2c37cd6@intel.com>
Date: Tue, 6 Oct 2026 11:23:06 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] net/ixgbe: fix repeated Rx packet buffer shrink for
 FDIR
To: Zhang Tengfei <zhtfdev@gmail.com>, <dev@dpdk.org>
CC: <stable@dpdk.org>, Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>, Dongdong Liu
 <liudongdong3@huawei.com>, Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
References: <20260916135827.116145-1-zhtfdev@gmail.com>
 <20260927042545.45152-1-zhtfdev@gmail.com>
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
Content-Language: en-US
In-Reply-To: <20260927042545.45152-1-zhtfdev@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU2PR04CA0289.eurprd04.prod.outlook.com
 (2603:10a6:10:28c::24) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|IA4PR11MB9251:EE_
X-MS-Office365-Filtering-Correlation-Id: 05d81bde-0789-4c93-cd9e-08df238b716c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|6133799003|18002099003|22082099003|10067099003|4143699003|56012099006|5023799004|11063799006;
X-Microsoft-Antispam-Message-Info: AyC9fFj36qu0yPZrfqzQz2z0RdOJ9MFQlCc57SHI6h411lv+JgsT8EQlvlNZwmCpu2moyWUnXjtY+D2uGB2igVcznqnCidyDQMHc1L/uqAA8Utv+98L7wH80PPqlsEZHzPj5Es0U5v+FkfUGc3rYBDmX7ASpGjwgIPyQU8ArqqdJdvRx5ucCPbyF5oNjxVr2ojhV4ivDasv3+8iugLw2OPYwGKMPNbKdShXpH0r3m2mI1NKYCDrnXMCJxh1kOQY9OCzrpdFE7UsbvBLiFDfwqeFrRpIc7RXRGrHHZC51SMEzc9WwV1THEICvbMGNGxisxotThU456Zizgg65qRucUmISyl5gbT/66CHm7bd4EM1o1ZPT1SIpQbP6OCYwSLZAeEO1ewvTwxF4yiNx6V6RV3v1ey1h58704JPLbJ60YeGtaYjZRRkul4hy5LmlB4OAK8N7GkLWinLCACZkeA5BgFfuCzlO5SKfdczOnLiW+nOJVlOgDSaJQ+4Q8IHZQIXyJK5zO5zKgOlLe1S4R7zWY3Ke2/4GOaD/rRg9JBSXJBAcKICzmg3UlHFWmfzZp9hglrhTyTvDuRit8Cz0n0CqaPmmVhqVhr4uhIzwyF5eG+ZvKwVlvU9Sq22xT122iG9N2osPhTiYDuImnLDRwfcGlZacjwnbXyya1/tFsSYM0L8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(6133799003)(18002099003)(22082099003)(10067099003)(4143699003)(56012099006)(5023799004)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cWJrY0xnUDJ0ZXc2dEN5U2VvWlh5Y3lFd1c4REI1Qk1YazE1MGtUbzJRMDJ6?=
 =?utf-8?B?K0I2bVFoOVoydTROM1hWVjhEdWxTbUJsUW9zZE5sdGpkcldLZWJVL1dmYVJL?=
 =?utf-8?B?SlRtV2wxR3Z5d0cyQU1sTGova0ZJdzliSW1rVmRudXZRN01DVFJZcnJYOGYx?=
 =?utf-8?B?YjUzR1pNSytCQ0xvVk12d2dVb3B5dnBWZzNDUW8zYUNxNWx5Z3Rwd0FyUjc5?=
 =?utf-8?B?U3RWZkJzR0xhYVdLRkVYN2g1dnRRMUZmNTdsazFOS3c5QVRCZWs5OVo4VDBQ?=
 =?utf-8?B?NkZVUzZYNDhiQmRrTlZhOGZTY2gzLzkxUyt5WXFjUjcxWHZRVFJzTG5TWkF3?=
 =?utf-8?B?R0JJdFZucitqU1VhaHFKbXlEczI3d1pVelpWVFFQUHR4T3NnWkRBZU5mWEpq?=
 =?utf-8?B?YlYvWVU5Q3RVUDh3Ky80Rk1EblE1a05tbUFqNFlXVW9pNzY5L3MyMTkycnI1?=
 =?utf-8?B?R2dSZnB3UnlWN1FOQmxVS09NaU8wc3hEQmhkTFg2NTdFZzRTRTh0cnVySW1L?=
 =?utf-8?B?eWFlYkFTeGtLbU90UVFuQVQvOU5TUGhxYU1uSDUvY2g2ZkZrWDFoNTN4WDhI?=
 =?utf-8?B?dlJwdit1VWRxbk8ya1h0amNiVVBjOWZGSGs4QzBSeUQ4eDJlV1Q4ZURGV0hH?=
 =?utf-8?B?NW1UelBreW1zbkRaWXpTRGhTWXdwZ0N0aEN6dHBrNnlScU5NK29SdXk4blNx?=
 =?utf-8?B?SUc1aWZkVjE1Sk5acnErWHlnN2NLMEhnRDZOK3J3SFRObVZuN3E3R1BycUlk?=
 =?utf-8?B?S0hzeGx4OWFMejVuS1d0a203S3hWYmczR2drZjJ1U01DOWJUNWl6aXl0REIw?=
 =?utf-8?B?K2xJUFViMndiL3hDWWYwVjNBTlBRWVpEVWpqMUNla2JYVElkZVp6N21DSnlX?=
 =?utf-8?B?SGJ3K2k5SVZ6MGVsdUI1bkUxRHhuRWdxa1RiWUJ6TnUvdWtXaldDTkhQUCs2?=
 =?utf-8?B?anZUT1l5L0RranJrSC9Xc2F3WU1ic1JWUk1GdWxYTVpldzJrc2F1QW90akJD?=
 =?utf-8?B?N09EdEQyYUw4Qi9DNFdKVlRVOTJTa1JJTXZ5RjlxZjZYODdGL1BaOEtLSXJW?=
 =?utf-8?B?QXVHbG5jNGVIcnNPUEJneWIrTDUyaTU0d0VJQUtheGpKVE9kWUhXdjBSakhZ?=
 =?utf-8?B?a3ZFNVV4Y25IK3VWdStKUUJMa2xOditPTmxNc3F3WVBoUi93NU1wZitRWjAy?=
 =?utf-8?B?RFV0WDNCTUQwRm5DeVI1S2NtM2E3Kzh5RzAvNWMyYnNtMkwrNy9IY2dleGdT?=
 =?utf-8?B?RFpLZmRqOWFEam9Ub1pxK0FiUlpNcXFoOWQrVnhhaEdQV3BWRmpBZTFJZGFj?=
 =?utf-8?B?N1JaSUpLbFdFcVVaUHdSWFBxUUFKbjlZTG1WN0srMWc3M014SG1iUmFEclVU?=
 =?utf-8?B?MzVZdkNsN1ZtR3ZBdVlONWNuTXdtU1dnZlJDLzR5UGpqbjAzNzZoazl4cGIw?=
 =?utf-8?B?T2d1STVnL1AvTnhMTkFUb2huMmJZS1VCWXluU09GOC9aQ1NFYm9vSkx4TUt5?=
 =?utf-8?B?QUozMmVZYisxMWtsWk5VN1hGK2lyNTEzcmxkY2FVNkJiRUY2a3A1bS9QZDFH?=
 =?utf-8?B?bDlNQWhVNEozQkltQU9tSDRZS3Y1ZEt2M1FtRXh6YUVLcDE4aTkzcFFKUTJ3?=
 =?utf-8?B?eXQveDFBMXR1UWlESUdWL3dqL2Z3MFZ0aERwVlpLa0RHeGlCdGxSY3h6R053?=
 =?utf-8?B?YXRNR2pBWHFFTGhOM3JoSVdxOFRZL2M4bEtwTFRxSkFaZ012SkdtbWFNSGdB?=
 =?utf-8?B?cmw4UDZDekdNdVJ5MHlSZTFxOUdvV0VSb1YzQklFUDlWb0ZhczlTNXpsWFFi?=
 =?utf-8?B?MTdwN0xrQ3ZPUXJLQ1E1TElWSUVyTVIvU2JMSXgza3JhYndXdEhxemgvN2dC?=
 =?utf-8?B?YksxR1AxNXpiZVdHSXhia1dVQkxjb0Jlc3ltYXFETnY1RDJ0UGIzbklMZTFG?=
 =?utf-8?B?end2bjUrMnlYS29MNVMva3RMTjVuTklIb1NUVDUzR1VJMzFPNUwzYU1aQm1s?=
 =?utf-8?B?VzZoSXVvMlR6cEU3ZWovLys2bnFTZjZzb3JJVGF3Tnl3eGVwOUxnNDZ3S21a?=
 =?utf-8?B?UzhWZFkrK3UvMUo3QWNhUkFkRWQ2NHpBcVhPQ2RXN29ETElqcXlUaVdCRVl4?=
 =?utf-8?B?Qjg0NFk5T3dTWUtWdVBrR0ZrakhnRlV0S1pEWXQ4RzVsd2w5a0dicjZNU2V2?=
 =?utf-8?B?cURUaFZQckVhQnQ5VEZjSXlnbHFtYmVrNUdBTjNUdUo2elpFVmNZWVk2WnBS?=
 =?utf-8?B?TDhmQmZ0UkQ4Z2dUNWtoUDRMbzUra2VvYlJzNXVRRHM3aWJmZFJqQWVybE5q?=
 =?utf-8?B?RHFnR21nbngyYmZLRmo5ZDMzQ1BSZmQ3SlE4UnFHMTlTeGQ2VjdkWWpnQmdv?=
 =?utf-8?Q?FghXfg/Oe/vtKMt8=3D?=
X-Exchange-RoutingPolicyChecked: CzYg8upedz/El5ZnObWdl3XsACEsSuarPp1WTzMfFub9O9IqVpkWzIqRAd6eqyODtnfFGneNqRLzehURkPWH5zkBh2+bC8WhhLD/U9SqWkHU4okU7uCgwAEMKSZBPRE9sGtI/TPGp63MgIRsevuuNOaYsRb7yhaP93cVzUO0RNf9fxkDlqTjSUTy7h/223bJejdeqAqahXRiYVHRL5/toiXdHfHTfOSWUMZfu/GFdD+TOUG0xmG269uhmRh0crx6A8+NmhtSw9EfFc4n8KvqjH88Z0mUitCFJ7hUlyvAFCA+AT+eeGOyH3/penhf7p1DxXYJoSXz15u2XMD+ycZJVQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 05d81bde-0789-4c93-cd9e-08df238b716c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 09:23:12.3300 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4JkmPhqNgYv934yYOQP7Zdal0I0RsVV3pC+IXvHiB+0/OKGx2N6K0iE4S+BRvQasXFyj91w2enT6tkds6mpHroEWmroyEVJ/HWDPvGyoyY4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB9251
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

On 9/27/2026 6:25 AM, Zhang Tengfei wrote:
> Enabling Flow Director reduces RXPBSIZE(0) to reserve packet buffer
> memory for the filter table. The new size was computed from the current
> register value, and nothing restored it when FDIR state was reset. After
> the last FDIR rule was removed, or when the first rule failed after FDIR
> had been enabled, the next rule created enabled FDIR again and reduced
> the buffer a second time.
> 
> Compute RXPBSIZE(0) from the default packet buffer size, and disable
> FDIR and restore the buffer when the last rule is removed, on flush, and
> on the enable error paths.
> 
> Fixes: 301abd26b118 ("net/ixgbe: reset flow state on clear paths")
> Fixes: 5007ac13189d ("ethdev: remove deprecated Flow Director configuration")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Zhang Tengfei <zhtfdev@gmail.com>
> ---

Acked-by: Anatoly Burakov <anatoly.burakov@intel.com>

-- 
Thanks,
Anatoly
