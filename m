Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B02BC3ABBE
	for <dpdk-dev@archiver.kernel.org>; Thu,  8 May 2025 11:23:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6C2764026C;
	Thu,  8 May 2025 13:23:25 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by mails.dpdk.org (Postfix) with ESMTP id DCDAF4026B;
 Thu,  8 May 2025 13:23:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1746703405; x=1778239405;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=SDesSlOrA9rph8O94DK8oEolepDd0wBAfUOBIl7/zM8=;
 b=ZL8FRDXdEqP24m7okMwyJh/tWUE06YUnktQJI6r85AlO1ZMF7YW+cUAH
 jOhUfdBpjIB+Y6CnyB793yqnAs61cPz3xb6W14w7lIm7ZPeMlL/fsXOXv
 4ePB4YPrwhqcT5DRK14Ux2kO4SVbc9GxOESvrkeVYbpig0fZ/4w90vFGK
 KEWYEMYEqyqDBXO4LPeAskNGS2wVoEK6DBz1zasOhKTyBNam4Uz/Z/RDa
 j7PBXvorirmhVuVVc6gazmcbs0HIiF8qvfntOYuskTrYu7bWRE2SVKOaU
 9GeoJG+0eCGECJHBL4JuA4es/wc6R84g81RngA+UKPpdhGtiM8huH45sX w==;
X-CSE-ConnectionGUID: vLb5LtpEQn6sxJ2/scn/pQ==
X-CSE-MsgGUID: JwZU88G7R7OqXceevdM9Jw==
X-IronPort-AV: E=McAfee;i="6700,10204,11426"; a="48385149"
X-IronPort-AV: E=Sophos;i="6.15,272,1739865600"; d="scan'208";a="48385149"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 May 2025 04:23:17 -0700
X-CSE-ConnectionGUID: zfNAmE7dQUy71MaJsWDuEA==
X-CSE-MsgGUID: xwtEjT2ITzKH7sdm8DqAsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,272,1739865600"; d="scan'208";a="136758070"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 May 2025 04:23:17 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 8 May 2025 04:23:16 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 8 May 2025 04:23:16 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.177)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 8 May 2025 04:23:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H2IUigV9JuguSKNmpoOLuxbXYzytgDk8QLsbmVMm0IHDx1MjkTat/TskPMBKipmXydGMyFh3lHp4kjhDxZq9lNZ8KXfGXCkOPVSRvBSrkpTO2QRPsmUEuE6sxUBGCSygu/UYm1myv18Colzzk6JIejcSVSqJ0HDWLRsRMEZv5zpRPk6ghIKhZd/VrBUuoWJzq5i293a6oMykuM41jzAbzARAl3XwA6ic1KC0GY+Bh3lSxWtBvhrCA2Ui2LmhwzrbixnRwhX8RoJTcoarYUvm9nruHLW/ZgjClU74NurQ3SDw1BjGhSmcHCLi5/u2yBcpLPyzpzDmv9e6uNXgUkuWhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6AgPYxElaAkUjbbj/9KQmXab/TAGLXbfVV1f2AGVld8=;
 b=hTjd1VMIJEOx/LxJlrMEMFyW7+4QcXGP8SWFRV4T5MFjbI36JV+pjxVkaE1gQqj09phgNOU0PgDKVnHYKmpCah2iABhte6QSKCh6AWhflp6g3ptOHfRcDmemU5yqhw11i5y9PNDzXfQ3of3ZxWfcMnZ4YeYFTaBSO3ElcBjipqfK7HBDjxVJ/oN1hXUDcH+UUM1ZQOXY0Jb666B+vqZgIVEor4laY95Ts/p+ECMCfxhOFMs20LQ6m5dh6PabyBxp4703jln8oSD0g8NuD0DLEu3XiOIUsWW5q3yp+wexKnMpRXeN7p007R6sfJb4wmePv2btqCbqSv17dXz99G65pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 SJ2PR11MB8421.namprd11.prod.outlook.com (2603:10b6:a03:549::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.21; Thu, 8 May 2025 11:23:13 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a%2]) with mapi id 15.20.8678.033; Thu, 8 May 2025
 11:23:13 +0000
Message-ID: <cad488ce-440c-4f43-a55b-39e16e17f4ee@intel.com>
Date: Thu, 8 May 2025 13:23:07 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] eal: warn if no lcore is available
To: David Marchand <david.marchand@redhat.com>, <dev@dpdk.org>
CC: <bruce.richardson@intel.com>, <stable@dpdk.org>, Tyler Retzlaff
 <roretzla@linux.microsoft.com>, Jianfeng Tan <jianfeng.tan@intel.com>, "Neil
 Horman" <nhorman@tuxdriver.com>
References: <20250508051915.226465-2-david.marchand@redhat.com>
Content-Language: en-US
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
In-Reply-To: <20250508051915.226465-2-david.marchand@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB8PR03CA0029.eurprd03.prod.outlook.com
 (2603:10a6:10:be::42) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|SJ2PR11MB8421:EE_
X-MS-Office365-Filtering-Correlation-Id: 20f778ed-62eb-41a9-15c7-08dd8e22b893
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RjVRcHdrVUpsV25UQXEybjZjc1loQzBndi9wN0pJL1ZpaE41VVZrWGhVTFpM?=
 =?utf-8?B?WmFJMkJ2dnoxK3czTk85OHE0U0dYWUpadDNiMDdqY0hubmt4TXZTZ0FObUln?=
 =?utf-8?B?UUxpU05tOUVUN0Y5Wjk0c1JuOEZ4Rk54S1dsWElxajVrb2RvME04TjJWNmVE?=
 =?utf-8?B?QnljQy9JeFhrdWpmVEtEMTR5Z2VrdzhCU1cvc05uYUJ5Qk5FQ01JanJIZnVq?=
 =?utf-8?B?MStVbnBwdzhtZklkMGMzQzFlWjF5N3RMRkJYVUZmZkhVSjNNU0pmUDRwR2x4?=
 =?utf-8?B?cDFFV0lOZkI3bUx1NVpuc1Bwd2FaemdXL05IQ3NXcXBpTFI5eDNlZ3phS2FQ?=
 =?utf-8?B?cEhpMWhhV0hsZlArek9qQTltcWIrM2tMbkxzU0IvYmIyd1NwK2RHVDlMNkly?=
 =?utf-8?B?TENWb1NJNTh3YXViYkFOdjhUV3pscjFIRytYejJZc25kdWpWSXArWDRlWVl5?=
 =?utf-8?B?NzN1M3VDcDhreFNxTy83QkMrQTBiZGlGMXhwUjkzZnlRZHQrbXU3MHVTMVBv?=
 =?utf-8?B?TjYwcE0zY2pGYmxoTU5qYWc1bGxVeW9ML0JxSm1BNFg0VjhxeDNvMzlBamxh?=
 =?utf-8?B?WDIzQzlNM1BLdUQrNGJCb3NUYWJ3bzVFd3RvVzhxbzVQb3EvdEs5ZEk3dmZj?=
 =?utf-8?B?UU5KYkV3ck9zODhqVjc1TDlzaGI0emorOFZVWDBzcURKc3hueGxHdEtrR3M5?=
 =?utf-8?B?cm9Zb1VuMUJ3NEFSanI2QVIrQXJCdHEyZlpVOUs0NUY4K2FWNHdJU0wyQW43?=
 =?utf-8?B?NkpoUUdGcVFhZ3pjNVQ1dXIvRnlIMkV0VEpjdURldFluVUJ2Nzg0endkZk93?=
 =?utf-8?B?bWN1WHpJMmMyZkcyMXlhcDB2Y09XNGtwajJuK1Q5aDVLRjJLZTh5Z3QzSWFw?=
 =?utf-8?B?Z0xWK0xQeGF4WW5NRUo0Y3laeHpMU1VrUFVSQXNpeFJSQlArU0ZhMXpZdVdW?=
 =?utf-8?B?V0RudHl0ZnFHbnR3RmlzeFhoN3RFZnVXOXk3S20xZ3ErRHN1RGVHRjZOL3hm?=
 =?utf-8?B?OTNGQ0hIWStsR3FPdlUvSHJ6T0hqN3YwUTdZMkpBUEE3c0pTQ1B4T1krM2NV?=
 =?utf-8?B?WDBDMUJsK0tuWk9aR2ViYkZDaGJRekZDTlo2ajRNNU9jNTZxOHp2UkNqR1V6?=
 =?utf-8?B?aXhNc3hPbzVhSHpwT1gyYVVwWWZzbHduVlNVS3lBNHppcDY2Zkw0OVVxK0VD?=
 =?utf-8?B?Z3FxL1E1d2xRRFZnakZ6VnNQTFcxR3E2aDF2T2ZuUHR1UERtZ01kL0J4Q2lQ?=
 =?utf-8?B?eVJGblBTcXZ3NmJqM2lPVWZGNncvbmZsYjhBOVBKcjZPTFMwWitqUWRKQ2dw?=
 =?utf-8?B?cFN0SUx6aUhORzI1Vnpoci84UitMa3ZCZGxRNUFUbVcwSGRSK0U4RHp6ZEFT?=
 =?utf-8?B?cUt5bHhjR2NhOWxBUGdiRUlVVXNCNkpFNTBDOFNKZEhpejNxNXYyRS9rclRP?=
 =?utf-8?B?NSsvR1NSYzlicVpEVzhVSjhzUmdBWWNKWWpQUjhsZExoSGtTemtBQzVRYUln?=
 =?utf-8?B?VExRNitVOTZ3N0lXRHlOcm5EbzI2TjFvL2xiS3p1bHUwUmp5b2ZiTldTajZE?=
 =?utf-8?B?RlY5Y2dIdWJna1dtOTRJLzZDbndaUks2TnpjK0VIOGQ4cFl0VE1COHFDRWFs?=
 =?utf-8?B?MDY0bTFoRUJZZ0dTSVIzZENjaGRTN2VXS2V1L0EyMytpd1RYS0pwd0hTSjJ1?=
 =?utf-8?B?bldaWEJycmJ1RG1DcmFHc2FOY1htWW5rTngwTFVYTTJtRFVjS2grQjRxbUR4?=
 =?utf-8?B?UFVuVFd5VkhFdXhVYXFOQml1cWIrRkF4bU51MlZXNm15bVE5RnBQMkE1VGEv?=
 =?utf-8?B?bzZyOTBBSnFtTkJQbnNlblRLc3ppK2ZYdUVKQnJJZ3ZmNi9EclBWMXNaZXF0?=
 =?utf-8?B?Wnc3bk1KbUpBMUxmKzRKRmFmSWtqVnR6N3crNUl5d0FVcnI0VGdmeEhxUkIw?=
 =?utf-8?Q?O+psPePjAiI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YTVvVU1vWmpKcURUZERZcTd2elhWQkRIWUhmOEl1Y3RoSmpLdlNTVzZQSjZx?=
 =?utf-8?B?eFZPOTZBbnN2ZUxvTjk0bmhCMVluc0VJVTcyUmUxRGRTR3RmMUNBb3BacFhx?=
 =?utf-8?B?Z2xpSW52OVVTQXFGeW1JVUQ1OUwzMFpVdmdNYzNFTXo3SFJkdC9vRlgzMnFB?=
 =?utf-8?B?RDhTamFOUVhUQ3lLM0RkbE0wWkgwWXprRFJEVWI1aGExcHhQK3F2R2p3Ry9V?=
 =?utf-8?B?M1BobG9zdHMxeUl2TTBJWjllREV0bHBMWFFYcDJOZVJQakF4Q1c0NnRpNVp5?=
 =?utf-8?B?bHVxZU5RVUpNbGhJL0toWWdpNkpJUmNIN24raThJbnNtdUoycjM5djBObjJl?=
 =?utf-8?B?dG03dVZWNCtjVDFMS3lEZVlhNXVicEhkc0hQV3FkbVhuc1h5QmwzZXk1THRl?=
 =?utf-8?B?cWs3bnpLcnJTNGZ5UmxEM3R5QWkzRlN1V1ltdTEwZ2dKYnpsVWRtUG1GYUQ4?=
 =?utf-8?B?KzRpbkxpTnFPNkh4ZnpiaTVIL0crRGozZWRDU3o3bi91RDhHQnNaTC85SDFH?=
 =?utf-8?B?dXlSbi9MQUR4TjhzeDVLWUJPUGJJdVM5Q0s2aHF2UTgxQkVHa0Y5dlhBMlFh?=
 =?utf-8?B?c3pQb0cwTVJCd01iOFIwVVVuNUVmbURKeEcwK0xvV2d0WVJ3Rzh1YUE1YTJi?=
 =?utf-8?B?d011RVBJRUxnczg3WjRROW5yOHdYa3NGTjFqY01zVWxUTmNmYnNKdThrajFw?=
 =?utf-8?B?bFFzVnozRWhDSW00a2N5c2dJa1RPUWJjUU5PZUd4Z0FLTnVabnRha0FaUFp4?=
 =?utf-8?B?VWFxN0MwNjZ2bVBQMUlRdXExaG1YcTZpbG1SOHdwSXhKZW83TUZMeGVCV0x4?=
 =?utf-8?B?eCtiRVVmQ05mZzJ0bTY1WEV2dlUwWHpVenVyaWJGS1F2Z0R0eU1kVXhUWGt6?=
 =?utf-8?B?YVA0ekZhcEU1d01DblpudmRiVy8yTGhlbzZRTU14enIyeDB4VEJiVVhENFpP?=
 =?utf-8?B?TENWOUJIMmNXT1pxN0FWL21XNlV3d2p6K0REdnliV3lUZURxejVPMVU0VmY5?=
 =?utf-8?B?UHllY3FaT2dzK2pFK0N0a2FPWVZFQjc0L3QvY1Rsckg5U25BSU9URHlJQk1h?=
 =?utf-8?B?Y1VadWdNdXp2eERQZ0JIWGFSZU9PaUdmVDBLZDMvOEFBUUovU1lxOWZsbEVw?=
 =?utf-8?B?RU95aml4RmEycjVQMHhwd2FNZ3NJaUFRbXF2VzR3MDJGeW01VXBEdllodnVZ?=
 =?utf-8?B?ZFZmbUZDaE92RmhlemRDYndVL0tOQzNpYis2QmNIQndCUzZuLzZpTGJKQndK?=
 =?utf-8?B?ajhmSGQzTWNGTE5UeDNZTkNFWmpyZ2RiS2hEbHRBVGxNeExRS0VVS245UCsx?=
 =?utf-8?B?VEJabkw4N2F1SUtaYkFPUDZ4TnpSeUtCSExOMDhJczNvZG9jVHF4N2doNmpW?=
 =?utf-8?B?Ymp1VVFBWHZsUnVGRSs1ZWFEamdpQXhocTl2UmxLSkcveHdTNGo1TXoyemFq?=
 =?utf-8?B?NGJnQUxqRGE0MUNJQlBxWDc4TENRdytqRWEwR0FhMllhMnR6S0RqZFJKMXU3?=
 =?utf-8?B?eFZwNUN4dWE3MStReGFCU1lrK05MUGhuNXNOVGE0YzUxQ0E0ODJiVGJscFVL?=
 =?utf-8?B?OTlsczNucExaQnY5N29hNjZlaFY5SnpLNFFFcnRUT1FtaDh1M3MrWGtUTnZH?=
 =?utf-8?B?L0tTMnJJYjIzNFV6S0dOdWEzYjg4bk1WNWM5aE5NTnUvbE53dG9SblljWFRM?=
 =?utf-8?B?S3FrdHhlYWRFTExzcUJXV2ZGcjE0VkJQS3hwYkQwZlZqNEtXZkx2SWJyRDRn?=
 =?utf-8?B?YXQ5MVhMaHBJemkzR05OQ0hqaE9WUGZkUnFHcjlvc2tNSzJtdm1OM1RGWGl2?=
 =?utf-8?B?S1Z1WitlNW9EaE56ejMxTWthc2lrRE95MzNlTERVdVZtNUNqam5zeUxJZVM5?=
 =?utf-8?B?MThyUmVidmp6VHRtSG1hbnlRbGUwSUIzQWE3T3lyZkZUZ3hyUndtOE85L1pz?=
 =?utf-8?B?TmZ4K2hKUjhTM0sxL0ZUSHpNWG0xbkJmc0tmcGExaDBRUkNZSVljQm04amxv?=
 =?utf-8?B?a0JVQ0JXeWFMdjgxTW1OWWM5TzRsU0hFVVdzTG1JdHJpUTcveWZRcGF0Tndh?=
 =?utf-8?B?VU9XOGl4c1FGaWgwNUpBY3gzOG9vdVovUDBWRU4wTzhNczlsSE5DNFJXU0Zi?=
 =?utf-8?B?WkovQktzZkcyQ0Nick1YbC9iUk9udENhak5valVNSzNtQndGZE5tZEZ1TlNi?=
 =?utf-8?B?dVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 20f778ed-62eb-41a9-15c7-08dd8e22b893
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2025 11:23:13.4144 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rwACDJH18DUptZrMILuleVeT38xzOWbTseQcHPUMDZpw0lY9dfosKZqmuJmQnaiR8C+GCxZBl4a2d9fsEGXsFzhsU/bJmy8fCxGEQSDBEhA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8421
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

On 5/8/2025 7:19 AM, David Marchand wrote:
> On systems with more cpu than RTE_MAX_LCORE, starting DPDK with
> cores >= RTE_MAX_LCORE ends up with an ambiguous error log.
> 
> Example with RTE_MAX_LCORE=8:
> $ taskset -c 8 ./build/app/dpdk-testpmd
> EAL: Detected CPU lcores: 8
> EAL: Detected NUMA nodes: 1
> EAL: Invalid 'command line' arguments.
> EAL: Error - exiting with code: 1
> Cannot init EAL: Invalid argument
> 
> Add a better hint to help the user.
> 
> Fixes: 2eba8d21f3c9 ("eal: restrict cores auto detection")
> Cc: stable@dpdk.org
> 
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> ---

Acked-by: Anatoly Burakov <anatoly.burakov@intel.com>
-- 
Thanks,
Anatoly
