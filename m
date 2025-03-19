Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A960C35FFA
	for <dpdk-dev@archiver.kernel.org>; Wed, 19 Mar 2025 10:26:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A65004026B;
	Wed, 19 Mar 2025 11:26:38 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mails.dpdk.org (Postfix) with ESMTP id 1407B4025A
 for <dev@dpdk.org>; Wed, 19 Mar 2025 11:26:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1742379996; x=1773915996;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=xVueCob/opow0a4S4vmlbAMEUnyrDOFBM/7nqymvLO8=;
 b=Yrf7dbB6KPRVvycO9NA6WmPKgkpwZENdroPRIn4fC3z3Vdm9ku8AxGDm
 rm5TB729SFjIObV1w4IBUvaPgT8pB1J/oQd97E/rhpRPaXz91t5bP0FpZ
 GOG7AU+eA5iZXfw7SpznOYoDh2PTP4YXTBLuBkeg8Qh8mYqEUPIGUbqON
 MBQccNU9yysRU1UKlURYNrMOyS3O+1ZV+nIY9onfCgnOIGEGFqry2QI/d
 +DoVXeNOfWuHnejm4KqyIVsCJ+m7qa9QTTYIWslxMRvrpoAq11QpRl6+u
 qq3mnfeq+6Dc+4jOJFECuwpnWoqnZ3/9zhXveC3ZHkgQG3fbiVIBx+DNd A==;
X-CSE-ConnectionGUID: 81496+sxTkyeLBVyaFAG8Q==
X-CSE-MsgGUID: BVCQrVLLR8ik/v8eALXzjw==
X-IronPort-AV: E=McAfee;i="6700,10204,11377"; a="54554613"
X-IronPort-AV: E=Sophos;i="6.14,259,1736841600"; d="scan'208";a="54554613"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Mar 2025 03:26:35 -0700
X-CSE-ConnectionGUID: dPBUXCn/Tyu/ihM6x0MVHQ==
X-CSE-MsgGUID: U/IaiJjZRIuyJU56WmkuOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,259,1736841600"; d="scan'208";a="122576743"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Mar 2025 03:26:35 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 19 Mar 2025 03:26:34 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 19 Mar 2025 03:26:34 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.45) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 19 Mar 2025 03:26:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pDhF0Ad2qauLbPpw5L8TChluJfQSMeTH4R5sAUHBOpqo1XfVVZOMuO919Gy4I3AveaGdZHm/4q7nDlypcTbNIxuqBt2CT511gWcd+XjEXSqD+tJiEyCaDRPk9DSpjWKelxt0diuPgk1XJr6WH18ja1D84vWBaSXUr9wmFVHobsNxZVYDDd2N2HWRnay1sUIX9GPIU2JdXOV4YwSPKaMOhlEKDao9S4+ZTzxWOCTqGvmg0NUMY2rTBbONaNvqTB+9J4xnzt6qwLFmjz0P8I3DsVQIdCmBFsLp+Lg8U4kF3U2pvtRrp4U9tb4vkYC6eiFWTg1nwSVl+aUab7/IY3g2HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A96W0hdMFDvwVt8O2ywFJ4DuYpzqwnM4+emuHg6xukk=;
 b=t1YFFbZ2OmLPHJnM/D/WCvwyUoI88R6UJ/nkGChX5rH8Dc+grsY71C/s6oBeJKfn95JwStc1EaI4fJmaqIKSfX6E/+BXsip/9zHmls07X53YcAmfBVLT32eCyZEch+qb9KyL5eoVeMwehwqC8+HVKmrjl0J4UgSloMkjJYLTW8NenUwnIQVMXWW1E1ecm5eDbW3/CrW/HyQ60gOs8iSyJRItXJwAwN4ydrSLmeezuSmI5DuUlcFx0VzFkaCSnGnOZ4KHKlPv+OgZ0LMsHTr3Yv6uaJkcIj/LHruAD6QszkBOiUrcyDIU1Wv99eZmEpaWPxy1k4N+mDF3Dl6TtPJXJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SN7PR11MB6655.namprd11.prod.outlook.com (2603:10b6:806:26d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Wed, 19 Mar
 2025 10:26:32 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%7]) with mapi id 15.20.8534.031; Wed, 19 Mar 2025
 10:26:32 +0000
Date: Wed, 19 Mar 2025 10:26:08 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: David Marchand <david.marchand@redhat.com>
CC: <dev@dpdk.org>, Konstantin Ananyev <konstantin.v.ananyev@yandex.ru>
Subject: Re: [PATCH v3 07/11] acl: use common AVX build handling
Message-ID: <Z9qbwPNR5g3DLIFT@bricha3-mobl1.ger.corp.intel.com>
References: <20250314172339.12777-1-bruce.richardson@intel.com>
 <20250318173505.314529-1-bruce.richardson@intel.com>
 <20250318173505.314529-8-bruce.richardson@intel.com>
 <CAJFAV8wPvQKHNFgPvYa1k-L6Q46WcsRCq8O64Mxb9_AX34CgUA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJFAV8wPvQKHNFgPvYa1k-L6Q46WcsRCq8O64Mxb9_AX34CgUA@mail.gmail.com>
X-ClientProxiedBy: DUZPR01CA0265.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b9::15) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SN7PR11MB6655:EE_
X-MS-Office365-Filtering-Correlation-Id: b18971c8-8c09-4173-b6e4-08dd66d078ff
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?T2lMdldrZjBpb0hPZHZOcHFkaXUzZzRVcWYzTmFPZkJGRXE1OHpjV09sZ0NE?=
 =?utf-8?B?WmI4K1BLTVdPQWxDbzZQekRXcXkyUGsxNlhMRUVZU01qVHZnN2gvbTVlVStu?=
 =?utf-8?B?MEJ2RWFyQk5rZzg2S2NhQ2E3bzJPRnpEWFk4RWxlaFpKL1Mxci9idW9SMS92?=
 =?utf-8?B?SHR0SVZEaW9CdjhhMm55bUk1WDUzaUsyWHdXTFdDQTZ2cnR1Zmo0ZjEwckZZ?=
 =?utf-8?B?Qkt2YkRqZHRoL2J1RWZsT1RGRVphdUJTdGdWODE3U2h0clhJOTR0ZFVNSzVn?=
 =?utf-8?B?RjBFTTlpL2JDUm5yV0JnRWJUZkRSMVFiMnlrbkxSZkV1d2RJR0FDQWVPZ0lI?=
 =?utf-8?B?MmxhSTN0Q084dWlkdUQwWFBGQTE4bCtDSE9UUHU5ZGd5S0NzZ3lsOUl4Wm5s?=
 =?utf-8?B?Kzg0M1pCbXMyVngydmtHU09yTUdKcmkyWUo3ekhpd0hBZit1SklUZVN5Sms3?=
 =?utf-8?B?NkhXMElZa2N3WTFIVmlWN2IwaW5OUGVkK1h1bGNydVh6TmVBbWlxRlpmMnNS?=
 =?utf-8?B?R1NBSWNRaWM4anhaOUdpNDFoRWxTU255YzJEUDlyZ1RwT1pDeWRhZVhHR0ts?=
 =?utf-8?B?SGtYdVBXUGo1Qmc0WW1PZmpXaGdpTk5MUFZjZk5XSEdLcDBabmlWWUpYa2V0?=
 =?utf-8?B?Mk50ZEdLRDNTK2hHNk9hM2hqNzlrSGRLODJNdm1VK1VQNEp0MUIzb3dlbzBY?=
 =?utf-8?B?YngwUmpxZ2J5VjYrTmZqS0h4MUUrU0lFT1lRdy9GOUlHM2lqeHU2R3VWemky?=
 =?utf-8?B?WHNJYzNTQzdBc3o4SmgwSFQrMTVmWDZ5ZEIrNVlCa2JhRXpBNHpsRGY3amhJ?=
 =?utf-8?B?dUdkYnhmOXBkVDYxeVBYWksrWmZOODBDbFRBalZDbTc4eXRjNVkwSGFmbDBp?=
 =?utf-8?B?aXVhaUQ5NnM0a0xTc3J0UG5uSjZDanp1L1Q5eGRscTI4VnpyOWRoRzJ4U0FV?=
 =?utf-8?B?SzYwMXNKNHYvc0FLZERTclN4b3c1eG15V3NDYlZTK3JZdjFnVTVDUFpRdXRu?=
 =?utf-8?B?bkxZRjJwdW10TTI2SGt6UFh6OG4xbXlFcnpCUkt5WDg4MzZWNlB1ZExFUG9k?=
 =?utf-8?B?VDMwb1I4aEtqcG9WMjE3TkhYa2Y5WStMZ0g5L2ZDMjF2UG42NGt5Q05HcnlY?=
 =?utf-8?B?cmFqTFVWYXVPZEVOQWtLSXpiQmV1cGJnN0U2Z1FCWlIxSWlGYVY5WlZseTlu?=
 =?utf-8?B?YlM5bW9GcDh4Z0UvUUV4ZlZzbktGbC8wWGxZL0xIYXlTNldQaUdScXlaWURI?=
 =?utf-8?B?ZjlkT0xhc2Z0RzI4OC9aN0hMSTJ3NG05Sm03cXBXb1pBd3RreFpxbzBpcUxm?=
 =?utf-8?B?RDRIaDJCRWJYTWxIcHVtUVZBUk91cWtKQ0JFaGk5Q0lsTzY5K3YvVG1aTGwv?=
 =?utf-8?B?Sm1VMldvcVpGUWxQMG13T01ybm43NWRjR1lUcHlSVWRmZ3ZHZlNTd1ViVzk5?=
 =?utf-8?B?Z0hKb0p6ZTBwZzI4cDFyMEtLdlhXWGFybS9yR0dPWVZidGpISzl6S3BIQS9m?=
 =?utf-8?B?VVg5OFJxVTJpUFpNU2lOQlhEOEY5NGZMT0JicWNmMWw0U2s4Z1ZHWkpER0JO?=
 =?utf-8?B?NVdoZFk1ekxDeDRqRnVaanlKTkZ6VEl5TWZ0TVVHQTNURG9YZlNQcSt1UkZM?=
 =?utf-8?B?d3dNMllZY0xDMGVLeG5tTXgvNi9ybUZucGFvK1NSd2RuQ1pqTXR1VDhTRTJE?=
 =?utf-8?B?TmFwdUhHVHhKZzZQci8xVnhibllnVDVuNVNyM2xkRERBc2FUdjdDSEpWYnZI?=
 =?utf-8?B?WVd5WnM1UVBmZzlsSmtNRjRxZ3RDa01udS9Kc3daSHdLUGpsK2pXWWNKcGtK?=
 =?utf-8?B?ZW9FbnhiTGJ6YncxSWo2UT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QjNpZkpvNkF6SjRSUW1mZktzY05jVDhiekRvZG53dlNpUzdaZ3liTnVlWGZl?=
 =?utf-8?B?YklzSThMbjVaemJWaStBWFpQTnU5YjFkazI3YThtTXIvdTZ4MUNJTXptcUZr?=
 =?utf-8?B?ODJtUUZXR2VFeWgwTUNmcnFEejhEODhRYk52UFhqdDBWZGQrVnBYR1NuYndu?=
 =?utf-8?B?cGkzdWNzVG1abytrQThLWmRuSmNXNC9QVy9kRk5SdUs1aHErdWltTjB2UDl3?=
 =?utf-8?B?RGdENHBBQTlkWVkzK0hRQWtubnJ5anJWZC8zN0JxWjNQUHVPZmU3S2hTLzR5?=
 =?utf-8?B?NHg5NDluUW9HMnlpMFZnVERYMk16eWJpK3RSR3YvUVBZTkVwdWxHQm5ISTla?=
 =?utf-8?B?TTNiaGFFdjM2ZlJmQ0I4cTZaMUFNQ3FaYVdHWTJjVkVKRzA3ZlhzOGdJTkRR?=
 =?utf-8?B?OEVRV2NJZEdzdzlkM3d3WGxKOFp4Q3c4MU43RmF1bGZhcWdMRmQ0a3JjVFJI?=
 =?utf-8?B?RFNxeHFVMG5JNitoUnpWd2pNOWRZS3VkNlZLamkrWEFRSi91NjVEOXo4NWxi?=
 =?utf-8?B?MmllV1BNT2JIeVE3bWlBcjFadXIweUNSWEE1Skhqa0NWcGhSQkRycEc2Mzlj?=
 =?utf-8?B?YnZZZmFMTXVaTTZKcERGYTIxU1VtNEZFb2tXR1l4WHpRcllpMmJiSDNuNE5D?=
 =?utf-8?B?Qyt1Y2pmM3ZPVWNmcFZsZ2pkeVFxS2dzcmJlSzlFOE85bjZQTmc3Q3VjbTBu?=
 =?utf-8?B?TUhxN2NYajJZMUJYY3d5bWhGNWppRnk2QzZKS2xwQlg4TzRoVm5iQ21HSVI2?=
 =?utf-8?B?YVU0SnFDNDBDNzlpdHlaTDZxZUY4MjkydGFjWXR4VW1OMFBaNStEOXpDcW1E?=
 =?utf-8?B?RjhaVXhDNTJNdjQwWXFiUFR1RzQwNDdXNThtalZwbXB0eUM1Q1dtVlFMZXIx?=
 =?utf-8?B?blpoNFQ1UVljczl4MnlKSmE1eW5pOWVuYlFNb1BNdWxmdHROblBzeHVyMy8y?=
 =?utf-8?B?VWZKUXdObkRlZkxMWnBxdDRad2EwN2Z2cmlmcGJUMjllWUtDZlUvUlJ4dEpH?=
 =?utf-8?B?akVKWXB2MmZMejFPU2xoL1VJWDFQWnhib3kvVFh3emV4ZGpUZGhES0ZXM1BT?=
 =?utf-8?B?dUlSMnRyYWV3Uk15ZVo4OUxpcEppU21jcGhYK3RISkl2amxkdmZUSGZXYkx1?=
 =?utf-8?B?YmpkOE1QeVBxNGlBYmJMMktTSGFqckpENVFiNDdTMmNucjhJdm1KNmNibHlK?=
 =?utf-8?B?Zm12VDVWbEN3YmZRYmc4V3lTc3FnZ1FiUEppYWROZHRSenVHSldDY1duT2h3?=
 =?utf-8?B?TDVDUWRxc3NCQzhYMzkycUlpa0hyV1hFWjRpUEthK0hMLy8xT0NkbE9qYnRP?=
 =?utf-8?B?MEx2RzdWQnJST0lUZG1jbzJSSWp6cjRjVE95QmN0QnBRMmM2MTA5YXRFMmJQ?=
 =?utf-8?B?NnRWTFFwZTdlSGZDYk5JM3lvNE9qM1cyZUtvRHZxbG1FbWxqNkNMRHl4M3NH?=
 =?utf-8?B?cUhFdGZJSlVTRjlWTjBSR1FJckdRNThua0hCLzVmZldhZ0M4cU1RQmUzSWJB?=
 =?utf-8?B?ZnpvejlyS3pLUEcvVjc2MnFyejloWkJnWm13VGdRYm1lTGc0R1F2N2hvMEk2?=
 =?utf-8?B?Slh0bE1uc3REeEs2eklUelVFa1ZNUUxSL3JWL2hiN2pGMWE0RUR6VkhHSSs4?=
 =?utf-8?B?Ty9wbHArdEpQV2VVekV4NXBXVU5XTzg1aXhNK1laRDRSUnA5Nm1VTENQOEVY?=
 =?utf-8?B?RWk3cFhzb1hGbEQ2Y0NVdVVRWk4wQXdGYjlUOUx2M2ZXWG15eHdqNDNaUWFq?=
 =?utf-8?B?SXJMcGZNUFBvelViZVVEYjkvZ3RSZGNTZ0hPd2ZrN2t2WWViZ2lBN2pIMksz?=
 =?utf-8?B?c29IMTdXNFNMSlZ3VzQ0VWJMRCtOS1A2RDFOOUYxSHdLdWpVa05KY0RpOFNs?=
 =?utf-8?B?TW82cmtwVzg4WWNqZ3FudXM3bjV2VEEwU3Bvc1lueXhrek5WV3ZWenB0UGQz?=
 =?utf-8?B?ekRZUzB2Z0o0Zlc3VlpsRys4S1NmYTVISzcyNG5PckZKN3I4aWpveEQ0NTFn?=
 =?utf-8?B?WFBKVHpOSGZyQy83a2lLcGFXbnhZV1F2cjVkZGF3czBZVWpBL0lYY1diRmlQ?=
 =?utf-8?B?NndUWElGTTl2UjM0c2x2cElhcGxVTGloTjh2ZGZFaDRyQTllTzY2UFBvK1gy?=
 =?utf-8?B?NjYyOGdOVTNvS216azJCSUcvd0swNEdpemFSK2JpczlWMTVRN1lTMkxrOWNq?=
 =?utf-8?B?cFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b18971c8-8c09-4173-b6e4-08dd66d078ff
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 10:26:31.9666 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lFpUGdoRFlzxLZ0EgNGZlOVv884KFqy325ixGDlVCIAAXCYhRtLIvzox+9DgZGAP/rCcyDOcodSnT3wtdpgFb7bKNF91cDqO4qJ/J8iR9cs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6655
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

On Wed, Mar 19, 2025 at 11:16:09AM +0100, David Marchand wrote:
> On Tue, Mar 18, 2025 at 6:35 PM Bruce Richardson
> <bruce.richardson@intel.com> wrote:
> >
> > remove custom logic for building AVX2 and AVX-512 files.
> >
> > Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> > ---
> >  lib/acl/meson.build | 54 ++++-----------------------------------------
> >  1 file changed, 4 insertions(+), 50 deletions(-)
> >
> > diff --git a/lib/acl/meson.build b/lib/acl/meson.build
> > index a80c172812..87e9f25f8e 100644
> > --- a/lib/acl/meson.build
> > +++ b/lib/acl/meson.build
> > @@ -15,57 +15,11 @@ headers = files('rte_acl.h', 'rte_acl_osdep.h')
> >
> >  if dpdk_conf.has('RTE_ARCH_X86')
> >      sources += files('acl_run_sse.c')
> > -
> > -    avx2_tmplib = static_library('avx2_tmp',
> > -            'acl_run_avx2.c',
> > -            dependencies: static_rte_eal,
> > -            c_args: [cflags, cc_avx2_flags])
> > -    objs += avx2_tmplib.extract_objects('acl_run_avx2.c')
> > -
> > -    # compile AVX512 version if:
> > -    # we are building 64-bit binary AND binutils can generate proper code
> > -
> > -    if dpdk_conf.has('RTE_ARCH_X86_64') and binutils_ok
> > -
> > -        # compile AVX512 version if either:
> > -        # a. we have AVX512 supported in minimum instruction set
> > -        #    baseline
> > -        # b. it's not minimum instruction set, but supported by
> > -        #    compiler
> > -        #
> > -        # in former case, just add avx512 C file to files list
> > -        # in latter case, compile c file to static lib, using correct
> > -        # compiler flags, and then have the .o file from static lib
> > -        # linked into main lib.
> > -
> > -        # check if all required flags already enabled (variant a).
> > -        acl_avx512_flags = ['__AVX512F__', '__AVX512VL__',
> > -            '__AVX512CD__', '__AVX512BW__']
> 
> Not sure it is an issue.. CD is not part of common cc_avx512_flags.
> 
It is since bce754b5d942 ("config/x86: add more flags in common AVX512 flags set")
See: https://github.com/DPDK/dpdk/blob/main/config/x86/meson.build#L68 

/Bruce
