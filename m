Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64FE1C43458
	for <dpdk-dev@archiver.kernel.org>; Wed,  8 Jul 2026 07:55:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6087040264;
	Wed,  8 Jul 2026 09:55:07 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id 3E18E40041;
 Wed,  8 Jul 2026 09:55:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1783497305; x=1815033305;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=vMq7arYpknDxuppXVzL6rcDecinomR47Cch/9huZZxY=;
 b=agmg9d7m/b9bwJGc2SooTTZwBzqKcprIAlx/3bOjMkFWOWaFCHrH5rbo
 1IF95955mkUbTbNzyCQxCMrznPDfKj9wUxpwd69bm3xxPNeJdEYCwL4aO
 8DJ7pWlnEnS1wqP5LOkgOAIP4d0998V12mzvNIcjEA8CzQLd9w1v0QQXi
 bLO4qZS5ckj+/+AEx+PxZ16IjooiWQ0R0sx3lrVHJdAi7EmIllfEzI84f
 G/K1defW2BolpAKwvzOsgjAfUZATNzFtkxk4bZb9d/Gw7TG88GtnGz7RT
 hRnvwuhx2mD8usnUCdMw0pKGBC5+f5/rp2EF8vA41XaAmrwbRrWRD3h4e g==;
X-CSE-ConnectionGUID: WWBADBVwR0eES13Mis8yDg==
X-CSE-MsgGUID: +iS/lKgGTnWMuyR6CmtdEw==
X-IronPort-AV: E=McAfee;i="6800,10657,11840"; a="95530818"
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; d="scan'208";a="95530818"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jul 2026 00:55:03 -0700
X-CSE-ConnectionGUID: fG1KeRPqTemu0l4D+VAM6g==
X-CSE-MsgGUID: tBJj+6kiQBSGifgz82PQ6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; d="scan'208";a="254861185"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jul 2026 00:55:03 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 8 Jul 2026 00:55:02 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Wed, 8 Jul 2026 00:55:02 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.6) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 8 Jul 2026 00:55:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=afRoRSkOHmv5VBzdhq0jaSO/PSYpQ02ox9R9j4tcykiMif1ASLQ094YT69LyQXh652BSne+PcvWjvox6jTh5Se0wAudwNjC3wzMNOTAQ0U+TvqM7+i5FbaBjIPP+FQPlH2EZM9Utdoh9/osMK7s0UYXIXQz13Q0ZLT9uROubD1q6kWaao8s64asxz5b7H2FL5WVt9GQRPEAj6hcfpnqtRqUAzoZEScVxhqprKdenn3hDKqiLBmG0koM12lv1j8FoWNypmVerdjFKHQzVg2oNAMAC68MrjuGkVtG1IELmeOTahzHNfsjIml9J7dy1T/n+tteYYnzFcNNckWBZcSvgfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y4ppx/BQUar4jO2C99di6zT/e6uxyh1k6oWMcUat5aU=;
 b=gqCg0uxy/OZVPBv45GLIBai6OEg9Wwv5VaQ4YlvBQYibzpaesh+alCeR29D0YPHSn04hcnUzqCMsyjAyTtCbAgywlYMrGqmy5D/W5pNFDgQCfvwDVpPPmCcXI+ozh6Xgss7l9XfXSUfH7HIVEV+8uXVKeSSuO2TSjJ8ws/QU8CinlpOBNnl8bPA+TsJaxpaXyi39gBFyEIJHwQ00ZEF7BqPqBrMXO7tlaCvKINrskSpi8UTiJKioBAdN2HH2FFfUPxNtffhxAYfl2rlvxg6F/rhrjewyyg4OQFbD/OdhoV8UUSznNiblJQpu9oPN1BlyDo4eXQQlgRMn5QzVYby1yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA3PR11MB9421.namprd11.prod.outlook.com (2603:10b6:208:578::9)
 by PH7PR11MB5766.namprd11.prod.outlook.com (2603:10b6:510:130::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 8 Jul 2026
 07:55:00 +0000
Received: from IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f]) by IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f%4]) with mapi id 15.21.0181.009; Wed, 8 Jul 2026
 07:55:00 +0000
Date: Wed, 8 Jul 2026 08:54:56 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Maayan Kashani <mkashani@nvidia.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, Raslan Darawsheh <rasland@nvidia.com>,
 "stable@dpdk.org" <stable@dpdk.org>, David Marchand
 <david.marchand@redhat.com>, Stephen Hemminger <stephen@networkplumber.org>
Subject: Re: [PATCH] build: fix libpcap detection with unusable header
Message-ID: <ak4CUC045a0BVzMI@bricha3-mobl1.ger.corp.intel.com>
References: <20260707133028.236546-1-mkashani@nvidia.com>
 <ak0KN_oZGU1WkPHm@bricha3-mobl1.ger.corp.intel.com>
 <MW6PR12MB70707673C99F020A595212EBB2FF2@MW6PR12MB7070.namprd12.prod.outlook.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <MW6PR12MB70707673C99F020A595212EBB2FF2@MW6PR12MB7070.namprd12.prod.outlook.com>
X-ClientProxiedBy: DU6P191CA0016.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:540::10) To IA3PR11MB9421.namprd11.prod.outlook.com
 (2603:10b6:208:578::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR11MB9421:EE_|PH7PR11MB5766:EE_
X-MS-Office365-Filtering-Correlation-Id: 86397125-dc13-471c-778b-08dedcc63633
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|18002099003|22082099003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: vbwJwUbHKUvm55kgiO+5l60lJvUwkHXDkOBelb1803nwO4eRWESnxWf380P7P1j0u/zlYPrgw84kG9pjQu1PBSo0MFYc3bdz4QTy+vioQhqA1+dJMbi6963c1vTggTzR/eY8pnRJhwHpU9rLEuo4HKeCQKESYIs7lx43gsC25JN10fP0VtKBnJjPDkJb98CkwRYyWcxZdfHUJ8xJUqBO0VfacxNIyJsCoxWAJfNXt4dTgfi8dCSHnWaNDk+SIRh5RB7h0zIoJFSEmPLZjdN4P+32pqM6CNRU9PWH8OcFycOtls7bekBITZj9NPn0W+WlcOcqYzjNx/yAaZ7558L2DFVgcjD2M1MxzA93B6xhO5DwfDiNzkiKfTrh6d94BcVwDPXESbRrPKhaA7b+lMgDSxBiE74ifVpkNZ00eEjX0kSqn3ZvQSzISZZJeOhefbfLPF5JmmlimIZa19ZX9JcwpsZurw2kNw4lUzB6wDSov+vqusTve/qS2M6Yzsozaqp3Hev945HktPshyZYT9BAEj77HMPnhcAdlIufQ4knNRfnGKcUyWf7ZtfVVrI4Q2C39AUvE/YD5Zm++yobwzUJ6qsBVaIgS4NUV8UEN6xyTUX35WGNku12tgyQyB025gnu3cF9usWy7qC5sAolCIz/SoQ0RZ7m1zNLOKQLd0bXCxLs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9421.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(18002099003)(22082099003)(11063799006)(4143699003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UzBER3lMd0ZqdmQ3OUt3TXl4QkZzaUpDWkNQVE1GY1FUaVZDNTAvYlhOeW13?=
 =?utf-8?B?cUFWY1VIblJiRFhXMnJXMFBRcHFDU1hwU05UcUY2UFZYR1Ivbnp3endCZ1c3?=
 =?utf-8?B?L1NYM1JBOWhJYmRzWXg0LzQ1ZHFxcUcrNVcvelNJSk1pU1NmUjVCbnZUcVVN?=
 =?utf-8?B?Znh0Wkk5MGg3R0tWVWJjbzgyMGNuSnpncTVZcXFLK1Qwd3lmRUtQUWcwbjg0?=
 =?utf-8?B?RlZBU0VOWHFBMnY2ajRMWXhobnhvNGNKNUFOaE03K0pac0lOSmNmejI5cHZX?=
 =?utf-8?B?TmlOeS9IZzF6dU9neEpVRkRsdHJweTZyZWl6MmZLV0xnSTViMXVVUmpZcTZM?=
 =?utf-8?B?SHp3dzZZVmV4MlhqQ2trRitFdzFGSzhPc21hUEFzUFVnSGpTT3NQaHNncDZM?=
 =?utf-8?B?OWU5MDBlUWxPNU1neTMrdURIQW1sUy9RSDdHZTByaWRCcEM5L0FOeDFPbkVk?=
 =?utf-8?B?RWVSUUdQMWp3UlZtbUkwK1M0UDJUWWY3SzMycnJWbmJEbkxCcDBUVVZvQU5X?=
 =?utf-8?B?NHNrMGlpT0hKTkFOWTN0eHB6emxCckpDQkRZTjNvNm5NdnQ3ZU5adHY4ZFNG?=
 =?utf-8?B?RTRrSXZKMVlVeHZOMzJkSXZTU3J5NE5JZXI2SkFsTUZUazY3WlBNQzBuSDNE?=
 =?utf-8?B?ZkVKZUhZNllkKzFqT2czb1BGeGVNVGprQlVObnY4VEhUWktOZVpDb3NQMXVt?=
 =?utf-8?B?VDB4eG1TeHBZS3FWWjVucmpCWDNCL2gyVk4wZVB4Y1IxSlJXZERGR0RYRUJk?=
 =?utf-8?B?VzJ6WHBEcnd5MHh6T0ZoOUlpWGFnTnlUSFU2T3VjNkdsUVd1Y2lqaDl3WkR3?=
 =?utf-8?B?Y25BUHdtOWl5dEFDRUJKNWh0K1Z4aG1NWGx3cFcxQlJhbzJjYmsyNnowWURn?=
 =?utf-8?B?b25FRm9TZUU5NCtNUGR5dklJZnhpdENoZUdlNlRhV2ltTkc0enplZExFaFhC?=
 =?utf-8?B?ZVgyTWp5ZDBZUkZLQ3o0eW1rK203UkxuWU5RdStHblVVQUg3dnRqREthWTFQ?=
 =?utf-8?B?aHVpang5cEhhVXBtaERIUFdrWVlDODFZV3JkM1ZQVERJNm9ZMjhUWDJqTlRZ?=
 =?utf-8?B?TVBGMnh5WU13bXIvZEgzNjdCaXgyVW1OVUw0a2hUbEhtbUNFTmorbGtuem9z?=
 =?utf-8?B?QnZmMWVaclpaSFN0THhOcCtUcm5LOGRSS1lOOCt2ajRZRk11UjdLMVJtaXUr?=
 =?utf-8?B?ZmVSZ2hDQUVoWVlDKzhoeFMweHJCekNMRXFKREU0OFFyQWpOd0lvV2RrNjdB?=
 =?utf-8?B?STliY0xBUDhtSXROcnM2K1d2Y1RyODRZRUY0eDgzam1BbnNCLzhTcG0yRkFJ?=
 =?utf-8?B?OWZhNDR1RWJBM2x1Y2pGVE93RFJaOXJqZ0s1Rm9VbmFEVVhaUXNVNFNyZHZM?=
 =?utf-8?B?V1c2K1J4QVB1Vy8rOTV6bTFnQjc3VG4xbkt5Q2JkaUJHb256Wk9qbndaUUZD?=
 =?utf-8?B?NS9Zajh4QjlCWXkveDZmMlI1TFVXdU9ZZzlsZEJxSUJQZjdSWEFocEx3Q1VI?=
 =?utf-8?B?cEEzdjdzaHl0K3UxNUwra01CaERTcUgyVVd4UkV1RmxOeGJFcU5QNFA3dVhK?=
 =?utf-8?B?T0JGeHYzMGdwSFJ5dGtrakx4LzNIRm1DYXdOanpmZW5SQ1V4bE5ybDdBS3gr?=
 =?utf-8?B?WUErSnhnV0x0ell3Yjl3Rk9uc2JIZlFFeFlaZ2dDa2JvcEdRc3Q2eHFTdzVV?=
 =?utf-8?B?T0FtaGFacXloTXNMSlRTN1RibklJSWJKeVh0MStTV0pTcHRhSU42cU1ZSGxs?=
 =?utf-8?B?UW1MYStvdlV0L3pINnVUNGhzbC9WZFBSTjBZVE92cEtpVlRUZzRTcXVuR21L?=
 =?utf-8?B?OStRdk9jcFNBS1hMeVREL0VtTCtCUGZUWGprOVdJRjJxdjF5QXFCQTRzQUVS?=
 =?utf-8?B?NnIyVUhqdmFYdFRjWkZsNzR0emFoVTYxanZXYlRDb0NKVm9WYUZBM1RIK1pT?=
 =?utf-8?B?Y0EvN2Z2MHNDTzJDOTZMWENpSHNQTDJJTFc3T0hKQ21jdXpWaXIxbEQ0NlFS?=
 =?utf-8?B?Q3gyeE5CNS9FK0dFVEpYbTNIVDdZWm1JME1xaVNORFVISWVtY3NKTTJrUDEy?=
 =?utf-8?B?L3BhNFdKQjlJcSs5UC9jVURGOStmQXZTNlhvd3ZWK3dVZkxDTjhRMHlmcVcv?=
 =?utf-8?B?VFdXei9yc0Z1Mnp0V05HZXdqOVM1dEZjMGUyVnlPMVpnOWdqUUpXZHZDMGpi?=
 =?utf-8?B?OXhpSFY3SzZpL1BnYlk5OFdFdG1TdXBETXgzVUs0c3ZCck9pZTAyRmJYdnJP?=
 =?utf-8?B?dk1JUktVZHpvTE9JNzZhRVhEMTNoak1DNVNkc0d4d0FRc3BhRjRrRUJwdWNq?=
 =?utf-8?B?MUxwWnVyRlp6NUc4WnRsOG03bzdFUzlRYWxVbEFRb2txZzVZbXVndDlBSWVG?=
 =?utf-8?Q?nRhP3LYOs7ThaMeM=3D?=
X-Exchange-RoutingPolicyChecked: I111lxYdRjGy90An+B05TFmFnUfh3ED8vl7BUiqdWBlMIwn4zhPQhXjgS1obk8Y2u4PdvK9anYD9nXJ3N7J/hn2fD65I0e6OmoB7guLS0Z7zJEF7fuHGLQcKgGJJReBDXQbNEAn8QhLabhHj1STHqYxS6AxGrxqtWIC5b23FHiN5dM8Od+pcRDYkLyxSfpcoasuvfF89i5iikNNvLOP6PoNYinwQ5tK1Q+jL0REzAt1n8CYCv9TXsIxnvH2HcSp4/ksNpsHG/3xVuA9JlXVemswO/c88SfTjhBM8fgpL2PMBhUNX+L19tq/lRjZCIvWNbcNQ3CUhcqkzZ0uLiUYGZw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 86397125-dc13-471c-778b-08dedcc63633
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9421.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 07:55:00.5867 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D8vOKm4atWNyE+y+RE8J13emRXpKX30txvFVY3eEa0trICM0FKs681ROuk1E/xKbvYsP/oQuq3kCeIWH3CNU25MP6yRdi7YMMq9eoAzFlBg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5766
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

On Wed, Jul 08, 2026 at 06:37:59AM +0000, Maayan Kashani wrote:
> Hi, Bruce, we encountered DPDK build issue on Tencent 4.6.  It is not
> expected; the package/image appears corrupted.  RPM verification confirms
> the headers differ from the packaged contents.  The DPDK change is still
> valid because optional dependency detection should test for usable
> declarations, not just file existence and library presence.”
> 
I would disagree. Following that logic of checking for broken packages,
you're only handling a very small subset of that. If we start checking
this, we really should check for each and every definition in the file that
we need - otherwise we can still have issues with a broken package, for
example, it's broken in missing one definition that we need.

IMHO, in all these cases its better to let things fail, rather than working
around them, in order to prompt correction of the broken package.

/Bruce
