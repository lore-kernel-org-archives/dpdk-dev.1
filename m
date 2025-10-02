Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D871CAC5B0
	for <dpdk-dev@archiver.kernel.org>; Thu,  2 Oct 2025 10:34:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DA899402F2;
	Thu,  2 Oct 2025 12:34:53 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by mails.dpdk.org (Postfix) with ESMTP id D61F74013F
 for <dev@dpdk.org>; Thu,  2 Oct 2025 12:34:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1759401292; x=1790937292;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=iQs+wz/Vnj+WM4q5kF813/KoF1lvo70Zsz8bmBlOxPE=;
 b=Rgmw0Y2sUnYOWV3H5FjDe4mfLXRqdYzJ8UpjMCJ2wRPWf6IqYvtp+tNj
 W/bkgyJSUkK36Ti3qfgH/pOt4CxqRrmcULxbpz1R7nKxXvxFBhprvPWu0
 J9He+c9081WKkAjMntR8PGUk+OuExl/glTf39uJl/mn6a4YtswdmH008S
 vnSTk6HH7MY1I0K+JJ5JYUiG594pBxbdJt19CEn9934Fhx42D9D9lJWcl
 MqYKFXOrmLfSP2rK1Yb8zwvXsVk+jO2opeO7yU47Hwa+yNpdY2jyX3ecB
 ImAxV202LiBLedfZHpIWm7xwb8BxLunsJcD/v4e5jvxdLlGuXKRdXXqrL A==;
X-CSE-ConnectionGUID: X4sB4BjfTp+mXISi9dNPFA==
X-CSE-MsgGUID: yL1PfjmyR7+UXKOvJHpWIw==
X-IronPort-AV: E=McAfee;i="6800,10657,11569"; a="61728862"
X-IronPort-AV: E=Sophos;i="6.18,309,1751266800"; d="scan'208";a="61728862"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Oct 2025 03:34:50 -0700
X-CSE-ConnectionGUID: XwoC4HXORq+kNXQ4xxZzuQ==
X-CSE-MsgGUID: g7WI8U4dSLOPcG/2vHxtFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,309,1751266800"; d="scan'208";a="216128790"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Oct 2025 03:34:50 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 2 Oct 2025 03:34:49 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 2 Oct 2025 03:34:49 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.4) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 2 Oct 2025 03:34:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WkywUGkxRSl55Y8LRx+2WP5HKey4vg0v7/NaPsNQML7m8UXWEsGno+rsG+C2UIoUtqrczgDyfx8COGhustlior2jrSBF6fwWLH/tObuDLXi6oOlqx3TVQceKrx0QXGEhWZ2M+B7AOV101NULIhYPYzCIU5lMZmkE5g/gxS8ieARoQ6j33Kc41Auowo/qn+CpaH1SVKDBgNCOhFaTdm7LTlrn2wkyYp2mHLH/7THq7DQyOvbrvYGrx/8ITXjCRDuj8LjMw4Mgqk0zDCiPNNzvwWQX/XFEl/SM/twG39nREgB6rRpeES1kkrIp+MvA3f50/qfpOgTaK3jrxk8rSigqOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BDCFkWHJcbUbkWcFPbTu7fvgsQJoWyt0xdo6/A0ZXjU=;
 b=MYLBUSfvY5s1ADemnRNZSwbXh+38z30LeShzknub7icR2tNVBBurObEqGP9rDokk/PQKYquKt9OWnr90nbwNVbgeGC/8TjtuJ0ZZ4vferTy9TZDAm4jfCQhGSmHTM4/DVImKzilCy5l73njzWfkS+tIodL7dz3555oB/dX0djdKJ8vQjurepHKf7yoSCUlgeTCxRxN2F6FSDXFIJ+n+UnB109mrYBBl6oTsBuofcCciV+bU/YHEuySHFeOZtRT1ODkqTzgEkkpmdze1A6upoyWsJSsrEr8pv0O9eaH4HiHv92Ly6dfKky4A2vkQaQXDwEUo+8nc0937mUAe/xaLARg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 SA0PR11MB4542.namprd11.prod.outlook.com (2603:10b6:806:9f::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9182.16; Thu, 2 Oct 2025 10:34:38 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a%2]) with mapi id 15.20.9160.018; Thu, 2 Oct 2025
 10:34:37 +0000
Message-ID: <99b9882b-d5a0-467a-be09-5bc88af2cba8@intel.com>
Date: Thu, 2 Oct 2025 12:34:31 +0200
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
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
Content-Language: en-US
In-Reply-To: <CAJFAV8wcEgvqdCiPefmxUSyP=QjfYoWiJ846EZKsDDnwa-b45g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU2P250CA0013.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:10:231::18) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|SA0PR11MB4542:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b298b69-121b-4383-0e57-08de019f4913
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bnpGa0tTSjlSVzdIbGNhMUF5UW5sbHZtdTRsaU8wV2R4clpqSHJtTGZQNHA2?=
 =?utf-8?B?bjdPV2JMWVYwL0Z3N2g2QVE5Zm5KZEljLzRONURjakdBZ0prdTV4d0dKYlJx?=
 =?utf-8?B?dFhjZVdrbGpkK1dFcFRBUGF4SVlXWXdMZzJGbXZNaWJhYjRPaW9iY0ZZaDJo?=
 =?utf-8?B?QU5Hb2lWYjlQM1pLc3hkcE5HdkVIM0FwcXAvNzR5YUNzUEJZRVRCK2d0eW9E?=
 =?utf-8?B?cVFzdG4rK1FFaHhFYlFJNnBqdHZHcFRtbDlyVy8zMGNvM2lXSEFJVTJ1TU5I?=
 =?utf-8?B?M0JtSnBhRzRRRklNV29kS1diT3NoZ3h2N0ZDeHpSVkFNT25ieFlROXMwK0d5?=
 =?utf-8?B?eFBLWjhGWFEwKzFOZ0F4YTlqWDVKK2dLc1NDZHVtajluU2xkd0dMSVBEZnFw?=
 =?utf-8?B?bzE5WXZTVXZ4Y3ZlNE1xazFMZlpiSUVJNmVVcVlKeVUwYlNZZ21CUXU0aE5o?=
 =?utf-8?B?TmNBWGdtZkUrQ3lvM2FxRjZScVo3bnE1dnJETHJEeVpoRDVocHRXdEVVczBF?=
 =?utf-8?B?VmZyNW5Va1oxSmlyRE5QeVpPUmpXR0lWNkQwSDMrb294eExtL1ZZNHk2c3lw?=
 =?utf-8?B?aVJISDQxSDVaMVRCVzJCbXdtZGI4TGFYSVYydE4xZ0V1NkFrRkQxdzFudmF5?=
 =?utf-8?B?MHA1ZGV5RmNUb01DL3hLUWM1eTFUb0ZaVlJLMHZjOWcvTGlFdnVPRDJ5YXdY?=
 =?utf-8?B?b2dHUDk0RG56aWJWZnI4MDkwQ2M0blJNV2JURzBOa0dFdTBNeDljRjN2TkN4?=
 =?utf-8?B?amZXdXRuK2piZkdYdVFuRnFEU1VBaVZHRm5CeEJ6MncxcjBnaVl4WHBpdFVS?=
 =?utf-8?B?QldhejJaRUJLU2lvS203S1BvS2RhWm93ZDNyS0o4U1dyc2FOK1phOThobDFW?=
 =?utf-8?B?VS9TT24zU3ZvT3pQMGkvQ3FGQ2FjUklqUXhvVmhiTGRGRlUyRUg1YVFRZmNp?=
 =?utf-8?B?QnY4WXUwUE1QZUlPb2dPNjJkTHRsaXcrQytYY2ZOUm4wb2NXbGNTaVp6M0JS?=
 =?utf-8?B?a2lTcnBDRTdVQVM1MDFSUm8vYkJqakNqbFBlNTdtcDRIeGR0SVJpaVE4bita?=
 =?utf-8?B?ODJPWEszcTgwWjlabTFIcHNhVHFva1NPb2FoL0lGYmFHYitFVEYvc3FCRVZP?=
 =?utf-8?B?WXhDTXdIK3pNenczRVdvYjJYYmxWZzVxSVU0c0NPQWtld3Jtay9NdlZpQzkv?=
 =?utf-8?B?OC9TNG9ySHl0WHlqYXNOenBBa3YxYnZ1dlp6c3VSSHk4eW0wU0FTNDh6RUVt?=
 =?utf-8?B?NnJWSUFQTDgxQjBZbXFnMUNHaCs3NnBNTG1GTHlOSjN2QXJldXlUZ2RzS1V1?=
 =?utf-8?B?T0FYaFMwbVVWZGlQQitNT05PSUVZa2ltdnE3THhKRkZ5cjk0U2hqK2pQS1du?=
 =?utf-8?B?VTJXV3RSbG1oU2NHNWtqMmJGbmNKSkdiRElXM0ZGbS95QlIyZjErbjNhK3hv?=
 =?utf-8?B?eXVILzZVeUhmNGlvUysxSVAvb0lwL1pBaWZDTFNUbVVjdWxjMTRjRDREVmNn?=
 =?utf-8?B?N1dxVmY0Nys3NVRZdlFUREkzenR0dFljbDZ5c2ozVkVLYjBVTHdweHI0Y3ZU?=
 =?utf-8?B?ekpKRFQ5VHBpdHkwSmNYTFlBWTB0SWtZOGJvK29Rem83cmJPSmF5UU5PUEhy?=
 =?utf-8?B?YTl1dUFWSzZISHpUWFh4MGl2QktRY0l4UEljWHJ3Z3dNNURSZGd2VXpkMkk3?=
 =?utf-8?B?RG51T2U0UlgwN2NDSXNXbTBSV1RIN0U2emRlTEZlSVpnYXhWa2VvajhOYXUv?=
 =?utf-8?B?eEVrbjdjU2tCVHcrUFNBR1lvZ3NUeG4wZFNSRTMrQ3NoRzBHTnlmckVMckRR?=
 =?utf-8?B?YWZlTkpSUDBOem1YMHBqUFd1blVKWWo3cTBEaTB5c01uZHVJY3l6Y1J5OXVs?=
 =?utf-8?B?am9Yem9SWkw1cUF3WGZLMHpZYit3VGFxaVVVNloyM2FiOHVQeUFmVDBpMG9N?=
 =?utf-8?B?bzdFSEI4bDZuSlR5dlVKaUhmTkxxVC80aGN6ZWh4SE5GVHU5a1M5Q0I0R3Rw?=
 =?utf-8?B?d1NTY0FZK3N3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dG9OaVJxMnR1Q1FkUjJxYlpsRVRxamxueFJ1cW5MVkNxNFJRR3VhUW9QTVVj?=
 =?utf-8?B?WnV3RVdaMDVJVmRTYndNYnVERVNRS3k2ZFFJc1RwWjlyMkVySVlCQUhENTkx?=
 =?utf-8?B?ZGZaY0FqSXV4TEJWVHRUSFlHdytxcGdHTVQ0VDgzSVVneFg1dlZ5MkltU05l?=
 =?utf-8?B?bjdGRDA3UXlSWVVWTll5amtuNHpzOXlpZGdqSXU3cGpNbDRkSEFlSGczRXNu?=
 =?utf-8?B?RkV2SVVhWllUajNVUGlkRUdzbGJaZ2lPdUxYdVM5OThlZzZTUnpNZnVtMDND?=
 =?utf-8?B?Z1ZCOTEyTXNnNnJtYnVnczE1b00veG9iRHJybDVSWEtUbGxBMFlnRjBVVXl0?=
 =?utf-8?B?YkxjVjJJWThhdmIrcFVNOWFRdU5wajdVZUZGZXNvRFN6NmlLTXFHSmV2b1pu?=
 =?utf-8?B?Q241Nk9PTnZ2dXIwd2hWRTg2NWVSOWU0Q2xYbyt1YnlrZTZNeERhcWpjM3hC?=
 =?utf-8?B?c2tuTkhrS01Ja0xpb2RlNng4VThiTldTQkY1d0loUHdnWWNzTE5nL2QwdTIw?=
 =?utf-8?B?TUtzbFFNWTRMSCtGL1FRWWZBaFBlY2Y2dCtHREt0NHc0SHB6M3E5cm9HN0ZL?=
 =?utf-8?B?dTYvR2FNUVlUeGZyMlJ4T0NxNUdGaFFLNElyR2xrRmhpTUczWmNPdGpLMkRR?=
 =?utf-8?B?SlZvVjljNlFsbU80T1FpMnh3ZmVmcGNtNHp0aGk3c1R3SFVXSmg1YkpsZnBY?=
 =?utf-8?B?d1ZnTXhQdmxsWCtaL2M5cG9MclRFL04wZlNRS1hjWTNQWlBES2JwVDJ4SFEr?=
 =?utf-8?B?TlE4VWp4a25OWFArSnFKdjZCVUpYYTU5M2ppWklwSmdkWmpXQXFZeGVsTS83?=
 =?utf-8?B?Z1FDeUxRSk5RM2FLSm9YVVdmN2FQV05zSEU4RjJlVXBHUWgwRVpkNVd1bFky?=
 =?utf-8?B?Vk82dlRIUlZxOHpMR21uTE9wU0Ywa0FFNkhqQ015bzdWdUdUOE9mRmQxamZI?=
 =?utf-8?B?REYxMG1zMzkrOU05SmQwNjlmWlZpOG5lbHlnN1ZEcFNWSlNPUnlDTmFjUmJt?=
 =?utf-8?B?RjEzSENUMytGdlZWckpwTkE1MzRHUHFIS29Jcm1mUFo5VFhldkNQK3E2Rmxy?=
 =?utf-8?B?VmQ4a3JXQ2drOFo5Nkwvek1PUk9LSk1OWC9WZURsNW5oVWpJUG5SSzFtdG9x?=
 =?utf-8?B?a1hKcWZVTlZHSHk5eHBaaTFJNVRTd2hJMlRkRHNINnlzSks2QXBJa21DZWIr?=
 =?utf-8?B?d3E0VXk5Y28rbTBXSXM4dFVneTM5bEh3YTR2enlCMjRIdTdlY3BaSnRuYjV3?=
 =?utf-8?B?c3VWbmg4Y2UrNFJLWXVpcUUySmpCamJQanFjcWpub25SNmw1S0lqNVB5UlVz?=
 =?utf-8?B?K05KK1NUUlJ4WWNFenNxOWZNSGZJcEVObHhONlZQK05hWUxTWnZ4Nnd1YTJq?=
 =?utf-8?B?UnJIbUZDcDZwQkdrL1dOYTVGQmpRTHoyQ0h2QU0zVlFlQnJneXI4OE5sdTVL?=
 =?utf-8?B?SEVHZ2tQeGJReWNqeENuODFkdUJYbjBkeFVkZXozbVB2SU1LU1dNR0hiaU84?=
 =?utf-8?B?U1VNYkpRRXJnYkJXcXlxZ3J3Yi9uVURmYUFmWHBFcExvcFFSci8xZmJuaDI0?=
 =?utf-8?B?QzFjbmdOWWYxYUUxTEp5d2hFZkFJc1A0OCtHTHp1dHFMNnZlcnFaaFVnaWp4?=
 =?utf-8?B?Y00yd1ZKYTkrQ0c4VXZiVXIrSkQxYmkrZjQzV0ZpSFRQdEp4U0FKYmNxNVhi?=
 =?utf-8?B?eFo3UWdKNXI2bjI2Rk9zY3lZT2FFbTJqZTRtT3psMUlmOExVYSsvWWtZSmx5?=
 =?utf-8?B?aDhPUDBKclFRdWxGSXlJSENGNW40VnBrcXZuRkc0V3BibTgyeFNkTkVMRFlB?=
 =?utf-8?B?aC9BNDcyTTd1d082QlFlV3JwRUxWQm5vNU04cEdSUDhLOGNrUmZ0NXZDNlFx?=
 =?utf-8?B?ZFVaNlVZMjZsZmZkVW5SRFBlN1hXK0tISkVQWTJhVER1MEVuTDEreHRtS240?=
 =?utf-8?B?YVdIakNXbmtBalBRVURLU0tKN05HczB3NUZQSFkwRHpKaGw1dkcwdEw4Nnhy?=
 =?utf-8?B?NXp4aWl1bkZZL0hHeHpFSXdnZW9UL2NtRFN3SEdUcDc0VXVGbmUwQUU0M1A5?=
 =?utf-8?B?RUxIUmdPVGQvNS92Q2drQllXd05YbFh1UTJucTZlbXRlZWpGc2JIVG9rVU8r?=
 =?utf-8?B?eVE3dGZ5WHFuKyt2UlFpVC9rQ1B6QWljRFB5QmZFdEpQYnU1d3RTTEkyMEhs?=
 =?utf-8?B?akE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b298b69-121b-4383-0e57-08de019f4913
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2025 10:34:37.7085 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DPL5G3n1cFl2Lya/9U7g9NsB0HfRtSvkZ2ky7LFm6H28R5caiBcNB+BZYvuzA8Wm9GN+8CWTL/+IdLBmHjzQF9XBfdubpieln0BT/8B8Kvg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4542
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

On 10/1/2025 4:23 PM, David Marchand wrote:
> On Wed, 1 Oct 2025 at 16:12, David Marchand <david.marchand@redhat.com> wrote:
>> On Wed, 1 Oct 2025 at 16:04, Burakov, Anatoly <anatoly.burakov@intel.com> wrote:
>>> Can you provide a little more details on what exactly you are proposing?
>>>
>>> On the back of this patch, I installed CodeRabbit in my IDE (VSCode),
>>> and did a review of one of my recent patchsets - it's quite interesting,
>>> actually, and the comments provided were basic but meaningful, alas the
>>> free version is limited to like 1 review per 30 minutes or something so
>>> it's a bit limiting. On top of that, I found the tool a lot more usable
>>> than GitHub Copilot reviews, which are attached to GH pull requests
>>> rather than Git branches, and they take a lot less time to boot, so I
>>> feel like this tool has potential.
>>>
>>> That said, I'm not sure what this patch is supposed to do - is it to
>>> have it set up to review patches automatically?
>>
>> The ovsrobot creates pull requests in its dpdk github repository, and
>> Coderabbit and sourcery are invoked on them.
>> Look for a link in patchwork, under the name "ci/github-robot-post".
>>
>> For example, this exact patch got a branch and pr in ovsrobot/dpdk:
>> https://github.com/ovsrobot/dpdk/tree/series_36267
>> https://github.com/ovsrobot/dpdk/pull/124
> 
> Btw, you'll notice a bit of noise, due to how the PR is created
> against ovsrobot/main, and not the exact DPDK main branch at the
> moment the patch is submitted on the ml.
> 
> 

Wow, I didn't know this was a thing! Sourcery actually seems like the 
more impressive one in terms of summarizing the changes and aiding in 
review, but those two in tandem look pretty cool indeed. Makes me think 
of an alternate reality where we use GitHub (or something else more 
modern) to review code :)

So I guess this patch just configures CodeRabbit better. In that case,

Acked-by: Anatoly Burakov <anatoly.burakov@intel.com>

-- 
Thanks,
Anatoly
