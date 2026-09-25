Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E957AC98321
	for <dpdk-dev@archiver.kernel.org>; Fri, 25 Sep 2026 10:46:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9FAB943246;
	Fri, 25 Sep 2026 12:46:34 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by mails.dpdk.org (Postfix) with ESMTP id AE84240DD3
 for <dev@dpdk.org>; Fri, 25 Sep 2026 12:46:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790333193; x=1821869193;
 h=message-id:date:subject:to:references:from:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=/Pez2gYQMMGRh1iaV9tR4lu2rePY/iXvnuAwl2o7H2k=;
 b=hJT2eykXqRW04nGjsi5pemfG19Y0X4/GQ15YtUTQGXMISeHLgRuToTC5
 /z705KajzqLEHgrURLB3fsAD7XsbQPpZr2GIy407cxrcYjl6tLK0UuO0f
 jxROqyGlCrrYiSwId3o6vTK5/rGil4ohBgSAbrUJFWdXFoIIaczR0SO9S
 4FM0c1nnq+OjNBbQGtkjkIAdSJjQD35AudyJ2Gb0lU35S8GxoDVa+2lv/
 AWNAgQ74cJGl1c4I/NBoV93yawPqePI8CPdhZANTrIG4tzJ1IuQDe9iwf
 lfnaKBvPRjQiQUG4ijOudYNTgwj/She4jIWB/hbdimGYIgv2cXhKe3Jqm w==;
X-CSE-ConnectionGUID: cLSCWnyZQCWhBr0okk8s4Q==
X-CSE-MsgGUID: 4r1V/4GoQVyszNND80X3KA==
X-IronPort-AV: E=McAfee;i="6800,10657,11915"; a="90177741"
X-IronPort-AV: E=Sophos;i="6.27,122,1787036400"; d="scan'208";a="90177741"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2026 03:46:31 -0700
X-CSE-ConnectionGUID: fJZYRWwyRYmq6rZJDodarg==
X-CSE-MsgGUID: Q8k0RjLgSv2cKDXfj84PDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,122,1787036400"; d="scan'208";a="277472668"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2026 03:46:31 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 25 Sep 2026 03:46:30 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Fri, 25 Sep 2026 03:46:30 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.40) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 25 Sep 2026 03:46:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w6enkMfM+HM1OZeN0iWBE6xDxJ77M+AL3s1SHDSuHCFzB/SUHFZ6RcQ/ZM0htb6+/0fEOQVnuevhGQ0VCJg/LKj2xvskRrQMQhHpaUSQ/zr+bp5kdb82pKVO/4LJgdvBVkV+ZO09ObAFsKOyv9KjsGsgJctT1TcjkEBsXVFtph+w+iCdFjuLQxP4eW+VrxWOA7K2V6TxmX9esmzSQ5syczx1rexPjZh7mJBgTeFZSMk8AMX9YO5JpXQIVrJ7jpCcMbSuOshciWwEwJ64UwEsTulcbmzGGzOdPUKzedeAjJ2pCJ+dMQ4tE5Z23HljsbTVI1KXYVn67887tfTM39G+4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tRfSdNbNT5Zp3ZibCREzASZbVNw348SqF2lariupzuQ=;
 b=CBLk59mGp8PrhBc7BX4m61vbjZdKhzJ2qc0Ymdjaa0i8Ft6YfHtcSZJl03+GXeeUSZPfEvLOOC/ztFmI12EKsnBMVKB/q/fDeY/gZTMicpEO9mBaPBJCyepjUCX0v9/I7c6YXVev/tJW3GiPLIyvQvfzTPnr/fjxmVU+zm7E1W8pWjXM75ZGlpmHzf95nvTG75bXpyZ8rteQRopByvIXq+Mg18fq5AF7BumL/iCA3RfGoHN6dgvlBTXBcLkQqt7D2prEmKmSiKWNHDQj5Zlf+hXztxVy0+seiSiwDc9FGnpiQJvMo5eDXbmPsIz52f+n+8zQlMXtlROjOC6tNxYGjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 SA1PR11MB8474.namprd11.prod.outlook.com (2603:10b6:806:3ac::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.19; Fri, 25 Sep
 2026 10:46:21 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4%4]) with mapi id 15.21.0451.014; Fri, 25 Sep 2026
 10:46:21 +0000
Message-ID: <3048d3a5-c148-4ad9-afb6-9e334a53cd4f@intel.com>
Date: Fri, 25 Sep 2026 12:46:16 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/iavf: fix reset race condition
To: Ciara Loftus <ciara.loftus@intel.com>, <dev@dpdk.org>
References: <20260924084152.11089-1-ciara.loftus@intel.com>
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
Content-Language: en-US
In-Reply-To: <20260924084152.11089-1-ciara.loftus@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU7P194CA0010.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:10:553::13) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|SA1PR11MB8474:EE_
X-MS-Office365-Filtering-Correlation-Id: 70131d6e-33a4-4dcb-2033-08df1af23cb7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|10067099003|56012099006|5023799004|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: Co5Sgdajt0NW8+J+dXmK2gN/ySu92CQ86niC2O91qQNInfQmaLphTXsP1HdWMtGnyFHcEeQmGjDsh9ttoKUo3IXk+X7WctwgwJ441PJHbslIvW9w66bVLhet+XgmtA5+ApSJOhykuAKM3Dejtu08Gj/N2/j6r8ZgMKtXkd4nxrzHXhWAgw/I37SbE09VZBFdapXRXcuNA9aH5Os8o4AUMQsSKp/o+z+A3DNnDha9wMGqfc/qGOvWSoKSOAd3XOC8lePDP143WRiYzLFpxzejERZv7E75WgB2tztsMec4q4PBDk+n7ybMUg1lNgh+WMtfgFrLQhs6X4WOp0pjL+kfRjvClvsBbNppBY/e49tcKi4wuSPpyWW31H++BCBUZNKD0mfieOJn+AQfasGf7p+ZNqp6rDEsbAt25aNFZhKR8gfQnBYFJBu3oKII5+h7pb8SFBfuQ+b2Yk3ySy39gzzhucBEOVbluLoTsrxe9iadKUfxihnQEhGRUuQ0jjjBwBbnQoCnbFfRr9QoC/6rnqdNFibSB4ADnIoob780JvV9MnqQabKnl69iDNoV13vPVzppdk5U6axqjevPEqZQWDmKM4xe+g5Fak41ZnZnUXpq7leZIvSkOorPWz1zmL3ZU/xVVVm7/oEmnz0/Lo7ZrYocLDmf6H1vEdss9ztvC1x8snw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(10067099003)(56012099006)(5023799004)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cUZ4TnpVZVBwVHZvd21nZ2ZOS0Vwa3VJQXdNRHNGY3orODJZUnd0ZHV2Rnpy?=
 =?utf-8?B?bGdmSk5yOXlpcCtvb3FwREllbVY1ZGw2MWp4M0xndUsxbnltRmxGODIyTzFM?=
 =?utf-8?B?S3RuS3Q5dkRlcFRtblNSMDVQZzMvTDY1Tzh4a0UxZFBlWVRoc3hMMldWWVF0?=
 =?utf-8?B?RnVXL245b0N3dHNqd2x1b1RXa0RTMmNCMnJUWGFpM0FkckZmcU1pUy9ZcXVk?=
 =?utf-8?B?MGhlMmxJdW5HeC9oQ3pmdVJxcWd2RTBCL3JmK2NWZ0tldzhudWFmZ1lQQXNW?=
 =?utf-8?B?VDVMeURHOHBYcWhjSFQzRTNkaUZaRWZkU2tOOG9Nc2VkWUx3VFE4MTg1Q0M2?=
 =?utf-8?B?RjROMS9rbFdDOWRldHpDQXRmaCsxTWFYQStVMHRPbm1Hb0tuTTNVUjQzNk5L?=
 =?utf-8?B?L2VROXNNOTIweVk5UFpJeVFFSkY5NWR2dXh4cFlnUVlxSlFzditWQ0JyMGFL?=
 =?utf-8?B?UU9pNkpCK0V0ZU0zVG42NmtPOXJmY1FVVUpxeWNHdHdic0FPYTFYMFZudE5m?=
 =?utf-8?B?YlNRS2VkYm5VbkxaSFhqbytGVVNpZGJQUjRpNjNVdlZUeFB0djE3SDVQTytz?=
 =?utf-8?B?MEhaYVBVSDRHZ05kTUptbDMxdzBVQUM3V2lEMW5ncGNNNnBDbU1NSkVHeHFG?=
 =?utf-8?B?bXhvRGJMUXQybGN6M3kyUXI0b3lDU2V3WjFRY3VJNlJicnZyWkJLL2VnWXJo?=
 =?utf-8?B?QVk0VjQweXBwNHpuUjZGYnNNM1R0ZzM0YU1aeXliZW1LR3dCSDhLaDJJWHpB?=
 =?utf-8?B?cXVuK21zV0dURHkzU3hXVExKOEpzbG9GOFh1Q3ovVmpRRDRPSjBOc21SeVc3?=
 =?utf-8?B?YW9CMitnelZ3SzJxQ0h5c1lwazJkOTl0MG5hMkMzMEl6c0labVlJdnNaelFF?=
 =?utf-8?B?ZHJ0MWlVZ2ZkZXYyazZ5OHVZNHNsamZVTXBieWVvMzNhZTNucDYvaHpBZC9z?=
 =?utf-8?B?cVNuWEd0SzhaN1NMcVNLOUMxMTZMSEJ0dkNkaTJISFNIQ0FqQXRzZURIQW50?=
 =?utf-8?B?bGxhaWd1YmJkOG5wY1RxRWgwQnAxSitwWkFQMWtPa3FXMTR6amhMWjZqMlVE?=
 =?utf-8?B?MnM2aGJmK0lCaVpMbWdQT2RkM2ZrVXR2bkV6eFBUUHR5dFlFM1luVjV4S0k5?=
 =?utf-8?B?ellTZVBmK1pyc09xZ2ROYmpSS0VLYkxZQ1hlV0JRNktsRHQ0ZUJwdThuVWlZ?=
 =?utf-8?B?NXp3enRxd0FhL0VDSDFqY3NqNVZhcG9Kdmt4R2JSa3d0c1l5cStBeXQyNkQy?=
 =?utf-8?B?L3JVVHFyS3ZzYUJRUE82SUpQZmFNWHBZU2dBK0NMU05uazVZcUU1ZHJSODBp?=
 =?utf-8?B?Y09VMG1EeUNIcE9uQWZ2aWVjYXNEWkoydFlwWURtbXVscG1uamcvb1FUTEFS?=
 =?utf-8?B?Y2pPMU9sWStsaEhGREV6SmNPNzludVRzdlFiUFVrVysva3pTSFFNVmpQdno1?=
 =?utf-8?B?a1pMQjFGZnUxbFNYVm5aN3RYemtqWndOU0hMbzA2RWllN3duelVHYWhJeGhh?=
 =?utf-8?B?TGsrWDNjWHE0WEdwVTh4cWQwa1F0Sk5Jd0hZSTFuVTF4UVZndjJzTkpnTDJk?=
 =?utf-8?B?ak53M0d5cnE2dlpUNlIxRlZzZTM0R0VLYzJ0c1JpMVVhdWx4a1lXN0l4TzQr?=
 =?utf-8?B?VFlFdW5wM0NFRGtCZXU1TU4rYmgwTjYxclV3VjBMU1A1c1hyR2tCYklrYVlD?=
 =?utf-8?B?aGxyK3JIT3RCcGZrcHFGR0prbngvSkJrU0pCRHhHOVVzeUlJc0ZPaHZFWnV2?=
 =?utf-8?B?eTQ1VUtrNm5BZlAySWFETkY5UEh0SG0vczhldEd0aDZSTUxyZnozeFZiTSt0?=
 =?utf-8?B?MVpNbzNDT0tIWkV0QkJKck1jNjllb29FejRBS3dyNXQzOUlWYVVKSnlaNzNT?=
 =?utf-8?B?Yi9GYW4wNzhxRE1RSEd0Mm9RY3lIZzBSYWNoUXNnc2RGd2tRdEtLWjlWY1E4?=
 =?utf-8?B?ZjREamJYempqMFdNRW5LTFgrWDd6ZXNDYWpidHA1d3ZuRXZWMHVyTVNZcFd5?=
 =?utf-8?B?Z1FhMXdnYWNhMEMxZHRFMlNDQ2FQZXNTdkZzZ0t1ZWhla1NzTzQ2RmlSaHVK?=
 =?utf-8?B?USthZXU4dmo0U0VObWpTOWdFTTFpQ0cxVEZ3d0ptTGk5dzlEaDUwS3k5cW02?=
 =?utf-8?B?RDBsdDM3anBsNTBaYmhrSTdYYmROcXlqTjFRNm44M09peFBENXdidHZSWDVV?=
 =?utf-8?B?VkovS0diZ001Y0xsWE5tUmU0NWplaGRoS0NJZE9IYW45Yzc4all2OEpKZk5n?=
 =?utf-8?B?K3pHMHBiTVBuYUdGTENNUzFmbE5PZlp4dGdTcTVZUCtKRXlQNnVGV1FldDg0?=
 =?utf-8?B?YURiZE5EMWlORW05a1UyZXhQRkM3dFFQQnY0cjVJWXZoL1dmelcvb3RaVVRL?=
 =?utf-8?Q?/bI1wt9l6YuxNw10=3D?=
X-Exchange-RoutingPolicyChecked: OSNNj2vzwG3biKAN3xNqTIC08WrtpS8+V97/aUTAG+tMXysx3CwOpWFGaO6Gg+axEpNXAwnetmo1mRrIQKdLvORDE8TKLigmgh4NFgaLuQQq5Us26doADlHJFU9K7ue63vnz5HD+AM7IclIIop1i+kL6fSh5pmny75SCxLB23lXqZdGBHvKd2HhJNxSUJ8wyzaDIH5L+QsJazoe3NrgDYH9ApaSOIq9pTZWOBmLWZ9Xm8cXR04DfmxVlPDn+X7BMK13U/YEZJv99PyaEj/M/gME4eWGUQAmEnZkRXZA0T+7s0qDPH1PFf8R9Vtaz6/6sjzYmlYMec5SDRFThXcVrMQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 70131d6e-33a4-4dcb-2033-08df1af23cb7
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2026 10:46:21.4262 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pOcZAfpt5UDyJh/bAmMdAlLN4mNXnybVTAnclNq3maIhYpA+iEk0ZtXmv23Rh+mTkS5/iqBzKTigHCDVoQxxrSKsUOAl0S08Pir70LnWFEw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8474
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

On 9/24/2026 10:41 AM, Ciara Loftus wrote:
> iavf_handle_hw_reset() can be called concurrently from the iavf-event
> thread handling RTE_ETH_EVENT_INTR_RESET and from any thread calling
> rte_pmd_iavf_reinit() (VF-initiated reset), with no synchronisation
> between the two. Make in_reset_recovery atomic and use it as a guard
> so only one reset runs at a time.
> 
> Fixes: 28a1a72eac26 ("net/iavf: add VF initiated reset")
> 
> Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
> ---

There's an AI review comment about a potential stale in_reset_recovery 
state when init/uninit fails in certain cases. I've taken the liberty to 
check this against the code, and it seems to be a false positive.

My own AI review flagged the following:

```
iavf_ethdev.c:3747: after observing false, this function reads 
start_pending, dev_started, link_up that the reset thread wrote before 
its release-store. A relaxed load does not formally synchronize with 
that release, so on weakly-ordered CPUs those reads could be stale. Use 
rte_memory_order_acquire here.

iavf_ethdev.c:3547-3548: vf->pf_reset_in_progress = false is written 
after the release-store, so it is not covered by it. A concurrent 
dev_close() on another thread that sees the flag cleared could still see 
pf_reset_in_progress == true and skip iavf_vf_reset()/flow flush. Swap 
the two lines.
```

However, if we're running two dev_close() calls concurrently we've got 
way bigger problems so I don't think the second finding is meaningful. 
The first one may be a "correctness" issue but not blocking either.

So, LGTM (with or without the above suggested fixed)

Acked-by: Anatoly Burakov <anatoly.burakov@intel.com>

-- 
Thanks,
Anatoly
