Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2958CD6E79
	for <dpdk-dev@archiver.kernel.org>; Fri,  5 Jun 2026 14:44:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 24362402E1;
	Fri,  5 Jun 2026 16:44:58 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id 4AB58402BA
 for <dev@dpdk.org>; Fri,  5 Jun 2026 16:44:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1780670697; x=1812206697;
 h=message-id:date:subject:to:references:from:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=bFO9Y5KjTyN8mJ4YGErL3ia8o8GlveQRBuJR00Jj7Jg=;
 b=W3DIOPWR0/3kIvq/K176iihKQzgXMmUlcumDkEQl+gB4dZzRSAdhgcTT
 L+pMb/iTavW2YEJHhCVWjcg4CGfqjK/93QC18zWXbFmNCnYQ6tsKjIFZb
 GRCfeNaQggSGQSXdIAjevQB0W1g/rGDKAlwUfcVIROZdCDcU6y6w+Dumh
 DeBFMZv7GCcBvULcw4vLjHnV3hmJ6ZLJ+2sFf9mYdlZ8diPrw/Dilrnw8
 iJk3LnUrJz3SGHyAG/f4hX5fuonWbisSvwCLAEfO1hfg+e95+2EWd7Bdt
 waI7OXme/3auh5KC0lgfX7QS/86wUvgT1drhb6SW9MkJRi/PJ0wQwrSKj g==;
X-CSE-ConnectionGUID: 65KDD680SM+B1onWdpYfqw==
X-CSE-MsgGUID: Rj0mkEf3TmSlLn34yiJLgg==
X-IronPort-AV: E=McAfee;i="6800,10657,11807"; a="92879217"
X-IronPort-AV: E=Sophos;i="6.24,188,1774335600"; d="scan'208";a="92879217"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jun 2026 07:44:55 -0700
X-CSE-ConnectionGUID: ZydIsYV2Ty2RSC4eR1xKAA==
X-CSE-MsgGUID: b4h8o/2eQnam+F3ZX8aN9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,188,1774335600"; d="scan'208";a="244025965"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jun 2026 07:44:54 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 5 Jun 2026 07:44:54 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 5 Jun 2026 07:44:54 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.53) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 5 Jun 2026 07:44:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DPjZMaBzSrX7pTVuPYgcmUU5jPSjiVnn3cGJyy2rvZAf1yHxBDpVCs0fXy2Lr61G9nBUMhOkyqovb/6yr5h+ejbcjf3hSIBIKiK8Fmo2w/L6Bht/TdEgWGATxyuJtOtipzuUT/8cGRppibr+jr+ckhXxGJvGhtyM1LPTBvupPiEphK+PFPqHt6R+LRxe5nsukQbhmSHZrjAl39fYgIL5YfNFnGdfsu8bBx8zAG77UQT9oMsHuwWFsvNEOPMEvL8UWaUeF7uV57bVymKbFZAFGvYuX/gdFw5c9skle+GJ96uo4fQubXPQ4FAQhrvYIuC1//lMy/MDeNR8QGfy53KeSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TbS7sMWcNfMcx616Beh9mIxYiTB6FJyWIs4EKN0trOo=;
 b=woG7Rk7xsc2VUVd+l9Yrjc69oujcH+D0xS45jzy52tyVhm4RJUneUFuu1n+EV3gOicnMJboKNywi0Xnu8sG1BbzhGzkfOQ6R6gYPe6MahPwAWv7WwCidJH8890Cmoo7xK8KPPC46FI+dsjiNw+qxyOsfI55RaEPcEozRubD0x76Z1UFoAZIHl1EL8TP6ZT+MsM0CEKjYhKU5xjjFIfSqpGIaRj9d7+5MPguklgrELn04lgaDjXtFtxLF0i41w8asw9+Oc13MqcNR5KnS2G0lcskLnq21HHLoQj9ZZdp2WIm0NGTaGZNZEEZ75sKEFkZ5pksgKT2TFrcK2yjGJbTNPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 DSWPR11MB9714.namprd11.prod.outlook.com (2603:10b6:8:354::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.8; Fri, 5 Jun 2026 14:44:50 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4%3]) with mapi id 15.21.0092.007; Fri, 5 Jun 2026
 14:44:50 +0000
Message-ID: <9545cc31-aca6-46e3-abb0-018ffd761822@intel.com>
Date: Fri, 5 Jun 2026 16:44:44 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] net/ice: use granular PTYPEs for L2TPv2 PPP
To: Shaiq Wani <shaiq.wani@intel.com>, <dev@dpdk.org>,
 <bruce.richardson@intel.com>, <aman.deep.singh@intel.com>
References: <20260427023115.1225843-1-shaiq.wani@intel.com>
 <20260427023115.1225843-2-shaiq.wani@intel.com>
Content-Language: en-US
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
In-Reply-To: <20260427023115.1225843-2-shaiq.wani@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0006.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:3c3::13) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|DSWPR11MB9714:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f609b9a-a931-4df3-e1b6-08dec310fef9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|3023799007|11063799006|56012099006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 5NP41yHvRGicXkOLC5+KFV72VviPugQDdvQFDAVMSqkQS0/2W/OZnMgvCeT28G3Bhj49ETxvSI6KoHefNBlpg9fA2EMNgA9BMPGy4kmLSJXgHtlNtZOAFlx9FO80PDBFf/JRaAfPMEgz297R0Jn5yb2Gpd9pAR5LIwktQsxOP3xGga8QhD/tLyFADsYbfIvgEKAjydArHKjV5tlvmMuZALsSjFNYELdqYrK3h2msVwicyCInTe4pfzLVmFVR2w21XJQdwxfIm7k7Smk1rgmpmyPZCMaocHUCuT/DToJOt2QO5teF2AKw+s0ShDrqis4xeIEXf2qqPBaZiAzStQC08kkJA6B8LRptBRawCmckDtSxg/jWn8Diwf3Gg3ElETCn8pZRZMF9Zfz2vz/vNP559AFM4LgZObEkmAFhcK22mJyaeySsxkQ6iN5e7pMNzE6qSfAMiKqacbkfhOUGHc5i9eWg/1RyZySxzifnU5xPATFUD8+bWK8O8xSxctLN2uCh+pxnutJrNWhmr/utiJgIiZZ5NH9cIY/bmiRfokH1qepelkMFKvdBAiQfa1DrI3ScpcyZq/DAUfpSMf4ulHbOYvetocY5rz7FvhDFiayUFcmBVF0qYBN05v4GkwYx1EeA9T6ojxaPoTTCEIkWBZLkFJSg3ZwHE6Qu9FfVaTc5pHvHpluCg1ufYhstqMsUU2iF
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(3023799007)(11063799006)(56012099006)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SCtPTWxYQVpiRjNNUElYYnpVSEVVZDhiaTlrUDFVNlZqdFdWdGRPMzJyOTJl?=
 =?utf-8?B?OEVWTFJVam81WFNVYWRNMUhSdlVZZTVYdmM2K1FhVE9MbU5MbnUyVFpXM1F4?=
 =?utf-8?B?Slc5YitsRS9oUzROZGcvak00NVcra0tmK1d6cTdXK2R6b3B3eENJcHlLNnNs?=
 =?utf-8?B?dldjVzJ1OURSMXA2VmhRZyttS1Q0b2tiblFWNjZQcTZ5aVh1VDY0eW9YcDlj?=
 =?utf-8?B?OU0xQnE3anJkcEhGOE1kZ2tacTdsd2x4UEtPV2J5VFlGeGprbHN0WEdWaUVk?=
 =?utf-8?B?TVZKc3JNbThtSmIrRVA3dXJvVm9pVFNIUm1CSkQ2MVhTZC83TXFaRWNoNEdn?=
 =?utf-8?B?VHFZYW5ZMXprVzh3WWxtYitHN3VmeE1uVW5PTFE5cExUaEFaWlRvcUtHU1J1?=
 =?utf-8?B?ZEprR2g1T21tTis2NzFxMko1ZDV0YUR4NzhmRVRwSHV0QVhoY1hPeGFDQ3ZD?=
 =?utf-8?B?Y2lvQzBZSTE1VjJCa2graHhaZ2lUSDYxcUpNSDhvSE1GdlZQd2wzQW92RHA2?=
 =?utf-8?B?ZkJUQUNYTU82YnVrSXQxWVNMbXIwVjNKOXFHUHFGZzMvcTJwaXVaa21iUENv?=
 =?utf-8?B?bHlFU0h0Nk9tWVB1UDkrLzUrbWdkZTgzcGNWemsvMm44bXU1c3daWCt3T0I5?=
 =?utf-8?B?b2dKODJna0N1cUFYUk12S0hnRDB5MFNlOS8raHBVd040R1RORE9XYmhRRFNW?=
 =?utf-8?B?OWg5bXRuRWJYNjZvL2NCRHorVzNua3JsRjBlcWU5a0VxV3JsN2pSUTcxQ3Fm?=
 =?utf-8?B?NUFqc2hkdzlDZGZSd0tIN1pMd2VIMUhLUGRBaVNzZUtTdDI1ZGJiblhBL1hS?=
 =?utf-8?B?ZVh6UmJEbjZ3S0h0OUtRMU5zdk91WHU0WnBiemJoaWFsS2JFZ1kyUkdJdm9K?=
 =?utf-8?B?ZTcveWQzNW5pZGpWb0tMYWcvQUZpMVNzTGZUTVpPRXF2Z0tEbk9pL0tKYW4w?=
 =?utf-8?B?SjVKaDJUUHJ5MWJDSnlPRXdObHFJTlV6NmZtbENsK0dodTZHeWhzNE5BS0xR?=
 =?utf-8?B?dnBpd1BtRHdYQllzRHhqV0dlUUsvb1I2LzNRdFpBMElwbDVWZWtTSWQ3dnpt?=
 =?utf-8?B?NmFwVFBRRjJFUk44VzFxZCs1MElRU1ZNY3dkeUpxNVAvK0hwNnVIY3hvOFhh?=
 =?utf-8?B?SU5kd3lsUnFsdGxpN3lFMGtGSEdhc1JncHcrdHQ5d2pITjdqWkN6WEdPOGpK?=
 =?utf-8?B?SEwwTjNKYXlhRFI0RmZ6NS91NkpQdFdDRW5FbDRtMzZ4MEZPai9FdUJKZHo3?=
 =?utf-8?B?ZzNnZG1lRm15bzNNRS9UbVdhMGkzRHdlWGlkRGZ3dmx3cGxGdURHTmQxaUts?=
 =?utf-8?B?NVhmQld4TUljOEJaRFVGZ2VnblN4aEJsZUVRTVdSbXpLWWZROWMrUC8wZ2hl?=
 =?utf-8?B?SkdxN01XbVlSenN0NUdMNXlqTHZaYnFLN0kxUks0R1F2ZGp1dXVaTHFheEJB?=
 =?utf-8?B?VWt4YXQrZ1dMcGh4eStreVVGcC9TNnA4akZMa3pwdUlCRG5rRXF0bVlGQU8v?=
 =?utf-8?B?cTduNTZVWUdKU0EvUWpYNTh3YWNGaHVjQUtPWHZKK1dMRysvSXdhYUF1VWxH?=
 =?utf-8?B?SUJURU91dkNHUUY3Q2RxOFY1aFgwRWZFYjJKcDlSVURJMFVWWWJGbFo1VXZn?=
 =?utf-8?B?dlNsSS9wVWJtTjRnTXlhb3hjeU54LzBudHRPWlZwUlFKRWIxNlEvK3VLc3dr?=
 =?utf-8?B?YnFuZEgyWFF5WGlGT2l6NW51Y3hYYVNxNjRWbFJqU3FVditNbGo4Z2RvV0ZE?=
 =?utf-8?B?Sy9ieGZmNG82TkRXdWgvRGk2S0RuNjhxTkdpbTZCODFObWhmNU1STFlrUHBE?=
 =?utf-8?B?YWllZVNCS2s4UGY4NDVJRTJjT3IzSHd1OFZGc1A2UjVZSFVmVFZwcHZLKzNG?=
 =?utf-8?B?eXlHWlhIdE5DN2tDOWd0TkpBaUV6SXlYaUVFeFFLRzlNMEJwTHBEc2ZrcHFV?=
 =?utf-8?B?RjB1SEhLWlVEZXBCTzBqM1ZGcVlnOW9mVGMzdXZFUmxrK0kxMTBSWXpRdElJ?=
 =?utf-8?B?Nm9yNmxFbFVRWDA5RFVNbFhVMWc0UEtNZjVtNUFwNGZCMTlJVGJYcXoybngr?=
 =?utf-8?B?RGl2ODJlWmtNRmpaR0c4cEpXNkhpMEtuajhaU2g5Z05NOHJZV1E1cGRYRXJo?=
 =?utf-8?B?WmZadVY4T0dmMnY3QmNNZjlJVXBhRGxhNEk0WndMeHMwRzBZYURuRXlBajNy?=
 =?utf-8?B?YSttUVBoeG1rZ1luU0hiR2IrNDdQZVhaZ3RyQUhHTVBCUDU0d2E3TXYwQ202?=
 =?utf-8?B?RGF2QVJia3kxSDBCU25HdzJYSThEbzZ0Wjl3MlBYeVNQaG51Wmt2a3Bsc2pK?=
 =?utf-8?B?cEV1MmtOTXRlOTNkVGFkRFN6d2oyaTVmSjk2RWpHdG1oNjFnaFBpNWlRaEdR?=
 =?utf-8?Q?13KTeUswbDyTWkN4=3D?=
X-Exchange-RoutingPolicyChecked: fboi5HWmqZAdqTfYupvi0kVbXE4dbcnMUtWp4IkReTEpiwe5aGIyayZzRUSOPFSGJlGWV6HYa9TuTHuf9wbR9rkcoiJMHgPqsfdPCyJQG3b6502SFcpCBpecVddup49mG9eVZZb1DjMILuBYMBBKFhL/9CoseJJ1WL+BVMnlgg/u+kfQFZll62C+gB6dcMxMWlEkcSASXJ3SEjx7ZJGzcNDGqP44hmyrxNMRWF01wdmXUpBebJq9qBSeExWyM7bwO1TqGIHO6F2mKBKV12iifQoRzIHxpZV6fpjhVRhPJYbF2Rl0+VAEEqA/ZELle2dyfVGZlJsk64xxlkjuonIU4A==
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f609b9a-a931-4df3-e1b6-08dec310fef9
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 14:44:49.9404 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zCD2hnwNps1ciTF5pnx5zp/vlsqzCr8f7fAwtsYc0mtivQybww9QgfqBUx/Hwnlmq7M8ATO1yUmXrUv4C1XhCYqttM+V5QwKDdKoSuSKmiI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSWPR11MB9714
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

On 4/27/2026 4:31 AM, Shaiq Wani wrote:
> All L2TPv2 PPP variants map to ICE_MAC_IPV4_L2TPV2 (398), so inner
> protocol type is not differentiated, allowing cross-protocol flow
> matches (e.g. a PPP/IPv4 rule hitting a PPP/IPv6 packet).
> 
> Fix ice_ptype_map[] to use the 30 granular L2TPv2 PTYPEs (396-425)
> defined by the DDP package. Also add PPP inner protocol flow types to
> ice_fdir_gen_l2tpv2_pkt() so training packets get dynamically built
> L2TPv2 headers instead of static templates.
> 
> Fixes: 733640dae75e ("net/ice: support L2TPv2 flow pattern matching")
> Fixes: bf662653976e ("net/ice/base: support L2TPv2 flow rule")
> Signed-off-by: Shaiq Wani <shaiq.wani@intel.com>
> ---

Acked-by: Anatoly Burakov <anatoly.burakov@intel.com>

-- 
Thanks,
Anatoly
