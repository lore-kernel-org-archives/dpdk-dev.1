Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1353ACA5FD4
	for <dpdk-dev@archiver.kernel.org>; Fri,  2 Oct 2026 11:29:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DD8714026C;
	Fri,  2 Oct 2026 13:29:28 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id 7F7AF4003C
 for <dev@dpdk.org>; Fri,  2 Oct 2026 13:29:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790940567; x=1822476567;
 h=message-id:date:subject:to:references:from:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=n5rDYEHM3Ug5ob2olkqQwiuvJ8MG3Ev9DleJjS5rdVU=;
 b=cYXPJk0dfv9/caiR0PpR5Y+lfXUSUZDuzv8nTF26iJG4IizlaT+tze+b
 Pir9VvU1c4seYaIt1hxvvvmcCOKH52ITDGSejJMNJ0un26+grBAjnCiJO
 gLijcT8J+6nXksYOizwOlqQnZaPwmU+IoLrJWMLNclGjyi4nI1CjX4hvp
 jR4VMRqSC/0E0z1A04cjt+KkqjjkkdlR+n0Z6rv1uRQ9DA9v51kkA2/p7
 G+9PrBf5o3xksvzY+mzQLj1hANJW/RBhv0rCoyoeRBhbGkTTd8cXMVEre
 b6gqpGHolnyO9WCK6hnGEfOaXs01T1a4QLzN4TQLuGJzmYIh1uKayVq9v g==;
X-CSE-ConnectionGUID: Qx0HqMvrT62lGNPJRJ99Nw==
X-CSE-MsgGUID: KcN550orTzq0DF2zFXcFwg==
X-IronPort-AV: E=McAfee;i="6800,10657,11922"; a="94417296"
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; d="scan'208";a="94417296"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Oct 2026 04:29:26 -0700
X-CSE-ConnectionGUID: 6tu2ByVNQ3iDhZJ5QMaQdg==
X-CSE-MsgGUID: xRnV2c8ETPGb/rWZr91paw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; d="scan'208";a="302485607"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Oct 2026 04:29:25 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 2 Oct 2026 04:29:25 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Fri, 2 Oct 2026 04:29:25 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.0) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 2 Oct 2026 04:29:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pgB4Feo4oWDevBVnZAlBiPul1kG2QGvWmfVN9TX76OeH6Dlp1fSogxguxwQIn/8Pd3DW76gfhSbJ6dtH0OoDR91E7auv2fZ9NtHDeVUhDhi7UBsv3JaNs3CilvD7/n8g9odHms6aprfRpw2/Qan5l5UCcJodDYAHkkXCInF0FKyTrKKgL5C5Dk9kWRQXp6yUJhMUW68KFEMWhip9WYKpEOy1v9xIDg+F+cg8Qu7ji/KNwa8B94wuttXY+vR2nk6/+Yu6Q18fZc5YHQsFq+EuH6mai/J5YzDvikYQW5a+7BzC+Fjpnpm4qZahkJ0W8HLU1XfOr/p2vY2aV1MSdLlzkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rb6kpKSAWYiRA6LDaKtS//L6gcn3kmmTEz+jyOSXdVk=;
 b=TCY6SnaViMojhAhEYDzviRv2Zb3j0BiHCwY7iIAXZj+my0YeLw8xhyI8L6B3f8D+5JcWXuLhK1K+qK4KyJfZTejnd9FDzU9RUrFuULIWpDjl9JtzHHUsghb0OqDr4ouGHqMyxe0tjAYqkvSdyPFFn3Wo2yUDOkUEasFqVmXjVHnItafFTzQKtHUS4Lp4VuyU4dYG5uqMdiDN0tuljdxykO3mciZoMAuStl6BoQN2v7kgKs4l/v/1TIMsHZ+0XX9nXqeckkYRF1od+i0Ui/7IttzL81dHkqiTTLDvpKu93vpY0vSCgqwskKzBzTi8BuBAX/Jl4Y9tVEYxBv1skM0CHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 DS7PR11MB7690.namprd11.prod.outlook.com (2603:10b6:8:e6::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.15; Fri, 2 Oct 2026 11:29:22 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4%4]) with mapi id 15.21.0472.015; Fri, 2 Oct 2026
 11:29:22 +0000
Message-ID: <6398b1b8-b4fb-4263-abeb-663b16521195@intel.com>
Date: Fri, 2 Oct 2026 13:29:16 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/19] net/intel/common: add flow engines infrastructure
To: "Medvedkin, Vladimir" <vladimir.medvedkin@intel.com>, <dev@dpdk.org>,
 Bruce Richardson <bruce.richardson@intel.com>
References: <63c3a0cb245f38af6da4d14547aaac9a4789c850.1789560944.git.anatoly.burakov@intel.com>
 <cabd590e-46ba-40fa-803d-fb0c559fd655@intel.com>
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
Content-Language: en-US
In-Reply-To: <cabd590e-46ba-40fa-803d-fb0c559fd655@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PA7P264CA0202.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:36d::15) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|DS7PR11MB7690:EE_
X-MS-Office365-Filtering-Correlation-Id: 67d1df5f-add6-4ea6-700a-08df207867aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|11063799006|4143699003|10067099003|56012099006|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: DCuQNxgKFzv6IO1eTi0mStmeJXBC5GowZTm2dMlZVtfS6MliIzdpenfBlA095CHS2McH1468UzXjdtrH4oV15DTQ/dFoA5DmW25ili60szKL1wLZdn9Xts+CGb+vPtxqdOK3vYFUlVPs2kAbbvGRmzfLO2SA3VMIWjsvEpaSEkV0N2B+JqEkDViBJuOrSbIE4g6y4E5JVcGROQ8IrDyVHM5sozim1C5UQnkCQQeVAGdOX2gcHutCpWS0rmwF1/u70l/YutM5QE4PZGzPmgdiYmpWuGQgK42o+L/UF7OGVJ0d7G1BpnRP8/z6YwGXF+Ke7esyr+biSupu249MFcZeG0ydPBxLDddEKWnyeC9+DyEl4SYtxdDDY5iVtusKaNZ0IZbDjoysItl8WvGu4LFUupcM9teIAobuoQKyW/9GhwWrWgdnK/SIeNYLDjWcdtFdDrRTtSzLvi0Yk4mn32Z3HL1oAn3t9XkjvFSGNs7P+YB7O47k61D+dhGTz0Yr3rsTp10lFS4xz+foFeHEWwi1OI6eaf8t3yfXvIKBbyf7iDAon1PmjRYfYH+3FsS9cPyTdnyCNxJSM5Y64ui6ZhwnQcgtZw6IuEgYHCX7GRZvA8PpDxgRs6zDhe+3un2U7pr23Y/aYlY+lVWLvkgobH8tlMfseYkmpUollPSD3bynAvA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(11063799006)(4143699003)(10067099003)(56012099006)(18002099003)(22082099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eDVoMnhrNU9xVUU3MGRjSTVLTW5pUEVXd3VDNStLRUU3U2UvRWRHN2V1cUdm?=
 =?utf-8?B?OUZxaUpTbk9NaG9vMUZlSmZTRGR4WE93QlJ5d2pLRWxmOWk1VWFQMTZkV0pV?=
 =?utf-8?B?cmhscXBsbzhjcFpPQzJXSExRdEdxVG40eXVGVkRLNkluanhPUHhWamprbDNT?=
 =?utf-8?B?ZmxydC94Z1NlZXZyNEU1ZjRVR3JGMkp1Rjc2WHgzNTQyaU05a0Z2QlV0QkhO?=
 =?utf-8?B?YWRDVHlxeHVMbVhyZEhhempKSjgzL3JRbnJmZzZERSsyVHNnR09HTjc0NFBq?=
 =?utf-8?B?aThYVXhoczc3UlpBSXg1VUxvNHo3NUNPNThqQWhHa0ZMWFVadUg0UmdZVGNw?=
 =?utf-8?B?dnZyZ1ZWanUvM2NPbjY4RTV5bWhTU1RHbkgzdGFVTEt0YXU1MlBONHBia0dx?=
 =?utf-8?B?WUZ5WmRKY2pKR1NRQUtlbEtuRlZnQXU2NmFpU1I0TWQvMnNKSmRtcGF2T2NN?=
 =?utf-8?B?clpWUEEvMThkb2xMNEE3YnVNV3FidCtCRUcyTXdZL3J4SVIySENtMVdZbHU0?=
 =?utf-8?B?YWxsVGp5c0tBVERSUDVVcDFPdFg2RTE2dWp1ZzYxQ1BUNHhFa05RSzFFTHJV?=
 =?utf-8?B?Kys0eTRQYTI4VUxoZVNUNDhYTEVFZlRDNU5PVkVUNGtpSFNteExZZlNBMU4w?=
 =?utf-8?B?bndOMGFvVkYrNkgybVUyU0NVeWZUak5pNjRkalRYd3JENklmeEhmZmlBdTRE?=
 =?utf-8?B?Uzc4dEpodEN0OURIa1N0M0NvVll6b215UUg1V0VzYVB3ZUZuNzVCaG56R3Ir?=
 =?utf-8?B?d3FHcklWYkh2VWV1VzY3bFFpdmw5YzlKTzFjVTRtZjlpRWZ5bnUyVUlTNnNj?=
 =?utf-8?B?V3ZaRVY2Zjk0elFVWXJqd0xnSjhjZGxpSXRDRm5pcUppQ0d5MGhqcHB3cGp1?=
 =?utf-8?B?aHZRTUZJNlpTcWg0NHJnaSt3NmhJeDhNM2F4MDJPd1QvdUhLaUVYZ2N6M3M0?=
 =?utf-8?B?aGVEV2tKZzM2QUxTZ0ZQYzgyNU1uY3RRajhWSW81ZHRCVWxIMTVQTm5tV2hR?=
 =?utf-8?B?S3BKbkVHS1huTFVxcll3T1IxYVhGT3ZlVzRjeUJCSXVSczg4NkpLcytWQWlM?=
 =?utf-8?B?WGd1R0c3WXkvS0FqcEhERmREcmtVdi9ESkUybkZ0N1FweE5FTEY4RDYrdzlK?=
 =?utf-8?B?aVRzRVhaRk1MV3hJVHdLRjJ5YlZseU1VSmE1aTM0cmdxb1JwR3NrbDV4eDF1?=
 =?utf-8?B?OUYrMnRyeDFwZzZvRXdsRXlEOEtNM0pKVEN0S0FseUlGUW5NMW84V3o2bWlF?=
 =?utf-8?B?NE94N2ttdGFzaGVJVDArYlRkb0dXYkRmeVF4QjJsMXd3NjlnZzFIUzNKeGNl?=
 =?utf-8?B?WkZEd21WTzF1ZUx0VEtkZTNvc3ZEY0szck1QeUNKbnhjTTNPeUdLTVdPd3Vm?=
 =?utf-8?B?M3lSeVpxVnlJWjlNU2RKVkNmWXk5TlIyckt6ZENXVFdJcXQ5QzdJMVM4UGxQ?=
 =?utf-8?B?Nzk2TklLazNVc2lIV3NNK2p4bHI5U1ZVbHR2LzdnbTBPQ0RVcUVQSjFmbVRo?=
 =?utf-8?B?TG9hLzJXbExRNjRlekZtK1VsZnRTY3F2MTZwQ1dVV2RDN0tRUU5OWmppOThn?=
 =?utf-8?B?T3pDZ3V1U004bjBZNnkxQmVZbmFkazNyVVM1RmMzTGFIK3l0SE90MFJGNytN?=
 =?utf-8?B?R0cwU2Rjb0VmRllyU2JhK3JSeFNiN3ZQVm1RZzJuaHZKdTIvRW9pMkFLYkRq?=
 =?utf-8?B?WklUWDBtV2hvT2NLTWF2SlZCMkNLR2N4QTVqYUZ5U2RWcWZkak8yanZhZmlS?=
 =?utf-8?B?YWdFUnpvRTNrOE8zQWhzQmx6dFdXRENRdnVEV05jbmxSZ0xDWlhtR0lFOUc1?=
 =?utf-8?B?aVpEdzFqUU5za01CeXRVeVlBdnpUaEtQNXprc3UwYTVVVnBoMnAyTGxVVGZm?=
 =?utf-8?B?dVdua1hnL0VXcm9pY2k2SFNoWHlRNHU2bFRKcWI4emg0THFWVmdpYzVDbWhB?=
 =?utf-8?B?bzFqb1dxVFJlczBldFptNU9BK0lQek81L3ZlcXZRdjBQOUljQkwrRkpxeFRF?=
 =?utf-8?B?QnVMMUtMNWZoRjlRZ1NwZkdDcDFyRjZMTDRqNDVTVEc1YmJ4N0xqajdrRGhF?=
 =?utf-8?B?ZjNKZGVsZjlsWWtrUzRyZFVwb20vVkg5ejZ5OW5vK0Q3M2xFaWttdDhSVHBv?=
 =?utf-8?B?VDVDZHVEOWJENHBuaml5NENFN0xZMlFIN2syclJTZHUrYXBrSm1jTTBOak5O?=
 =?utf-8?B?VHQ2R1VpUWszTUs3K2QyazRhM2FmOWc2VWo4UW9pK1M0WVlGNnFzS3dhVFVO?=
 =?utf-8?B?S3ZNVmxEa0tHcVlkQUtETGtDeDBSWjRFczFhVTRkM3N6cWN2WW16Mi9ZNlVZ?=
 =?utf-8?B?aldMV3pad2tScEwwZjFHallldzZadFhjclJRQStDcDcvYmEvS01RQS9ydlJt?=
 =?utf-8?Q?E81pX+77sVqkYsNg=3D?=
X-Exchange-RoutingPolicyChecked: UKB5IDJfE3l8c7CZ10rUMJ19SEWOiNfiCwBUB0DNhfi2LhrgCs4RNaM5BqNBKlg4UQ4IoP34TH7rBJpl0NQP5LEYLzi4PDvF+F8PtoQIRl70wj30/sqaMg7Dp4tYU5GCOAl8WL2qe7Qa6BTDVzURm8sLkbC5sU93TJtN1wCHYn82/WkXmKgIT2b64HUjSriPE7Rz9bWq7tqeH7sSFjIYJJgY+msqBB5cQhFTAJzHJqaRR7H6vWw4DwSVlU1qOGDq/stdOVjw4csaj34TGV/XmhiHDlUmG8mTRoYGkdV/yZUAIErAQ9umSr2CTc4uo4a5uqfQlmwM0tUteo4CLQC19w==
X-MS-Exchange-CrossTenant-Network-Message-Id: 67d1df5f-add6-4ea6-700a-08df207867aa
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2026 11:29:21.9740 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oldAqfOuPvEO6gVshQx7RnehybIugG7Pvteu9bsWpL5LGYHkaR3rzNjBBdoa5EDb9oMRI2B0MJAac7zXWKmJAs86yo7IND35jSKc5GK7w/Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7690
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

On 9/19/2026 6:09 PM, Medvedkin, Vladimir wrote:
> 
> On 9/16/2026 1:18 PM, Anatoly Burakov wrote:
>> Current implementation of flow engines in various drivers have a few 
>> issues
>> that need to be corrected.
>>
>> For one, some of the
> seems like a missed word?

Not missed, typoed - should've been "them" not "the" :)

>> are fundamentally incompatible with secondary
>> processes, because the flow engine registration and creation will
>> allocate structures in shared memory but use process-local pointers to
>> point to flow engines and pattern tables.

<snip>

>> +
>> +    /* no engine could handle this flow */
>> +    CI_DRV_LOG(DEBUG, "no engine accepted the flow");
>> +    flow = NULL;
>> +    rte_flow_error_set(error, ENOTSUP,
>> +            RTE_FLOW_ERROR_TYPE_UNSPECIFIED, NULL,
>> +            "No flow engine could handle the requested flow");
> This unconditionally rewrites error string, don't we want to keep the 
> last reason why flow wasn't created? Same is applied for validate.

No, if no engine accepted the flow that means there are no meaningful 
error messages to be had here. If the pattern matching failed but 
should've succeeded, there is no way for us to tell whether it was 
*supposed to* succeed or whether this pattern genuinely needs a 
different engine. So, if no engine accepted the flow, we have no idea 
whether it's because the flow is genuinely unsupported, or because there 
is a bug in engine implementation.

In contrast, if the engine has accepted the flow (i.e. if *parsing* 
succeeded), then a failure on register/install is a genuine error, in 
which case we do not try other engines, and output a meaningful error 
message.

-- 
Thanks,
Anatoly
