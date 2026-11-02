Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B7EF606B924
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Nov 2026 17:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=AxbT6lLX
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 80D2D402E3;
	Mon,  2 Nov 2026 18:24:43 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by mails.dpdk.org (Postfix) with ESMTPS id A4DEE4028D
 for <dev@dpdk.org>; Mon,  2 Nov 2026 18:24:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793640282; x=1825176282;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=EEguCfX3Ihco6AM/eK6Gw8VDg4HX9QFjMV+ok2P08k4=;
 b=AxbT6lLXQ0hjyyYKctR1Ra0K6Elb3t1omHYNHJFEch6Xo2tEnpQKkb3I
 8bKnVGa8W1CIjvogq+prPga4MeEbWPgktpOSUKGR56mbjlmXFv/aDDBCu
 oPRE9dHYFUXXIOMTigZ8EK9fcLbwMPXXmGOnKkJoPqNKlkxp0ePCZbkuW
 PD2zn28l3IUXHmGVVWYwNSisHSDq6SxqZfy9rqTtijOY73Kme8WzK7hXL
 pTfuF3l68l26BtIIwJyhvGsWt6sWF1DyStaPsp7gYdqIoBvrkkWXFqb3f
 yW+hTSWEhgJ9uhfkU5v94SOw7jUCuMGv1hOOWe4tzF3Np19QzTSa+fxA/ Q==;
X-CSE-ConnectionGUID: xFeFXGXURl+rCEaMxo27Rg==
X-CSE-MsgGUID: LVkoZNtHTpmN6HcDznGRaw==
X-IronPort-AV: E=McAfee;i="6800,10657,11954"; a="2354825"
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="2354825"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Nov 2026 09:24:40 -0800
X-CSE-ConnectionGUID: rkZVtgIMTNGutRnYm/CWtA==
X-CSE-MsgGUID: ipLafolOScaCcZa+6/ZoCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="6193005"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Nov 2026 09:24:40 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 2 Nov 2026 09:24:39 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Mon, 2 Nov 2026 09:24:39 -0800
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.9) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 2 Nov 2026 09:24:39 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RalfORaeL3CjuxqXk07JVghKMsASZb4OAPH+PtzVgZqiW2yVUYyxq9nSM7oB2APYTP7bycRCZJyRxAR1VXoeeyJZ9MHKr+uSOFKwNXcT6fjAtpRAwWOPQY7F7NpcWCLoW2ak12n1XsThHRc54giQiIg0ttDFf5ja5XAr5PlEam7z0ctfiM60YcJuNMiubf4u0Yx6LqZOuuxhiMqQZGB6txHJ7/Xh4wDQA16hqo11oriG5gOYEej8H0F5a638znxo9WaZO3kaCeq3gaL7JBOiNsAc/wpPN8rZ3GMwU8dAyPIhPJabw1leOShpNH5oxIWt0iJ/6W9gmfYW9Tk0iBF+tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FEiEeKyeRyOTFGj/o/LRrIVKYbbVcgnG0RNQMzrhfH4=;
 b=Vq7XqKpLwv2VtoNLpqPeviA+h7HcPkc+8NGMRfdF2zPrOCo8jrUxpNK+EXUQJO07JTyCKDHwq0Dcu1y1/BcU7Y8jLelcIzUawcad/YlcQgjhiEpRBeYeIxookteiwVQ1XJq+IapTjlXtxlsAYyE6MDpKgDgdMsBNxanzReA4GuX1AZssjwM7sJItTaQFQmfJ0tsB+Pbe7mNWLn6SuI/GfyjPwYsf0h6hZI+KYkYeFa2Ktna1sIv+5JTxU7DJm5pujC/CHNgWRjFZ/kYJzN9YTY1jjANcCgU9Z84eCUHtlM+ysffCX3S69UTZyLprk8qadR43/W33kq9R6Ao3ky6fIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA4PR11MB9444.namprd11.prod.outlook.com (2603:10b6:208:563::22)
 by MN0PR11MB6060.namprd11.prod.outlook.com (2603:10b6:208:378::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 17:24:35 +0000
Received: from IA4PR11MB9444.namprd11.prod.outlook.com
 ([fe80::8b6d:87bf:4926:f0c1]) by IA4PR11MB9444.namprd11.prod.outlook.com
 ([fe80::8b6d:87bf:4926:f0c1%5]) with mapi id 15.21.0569.011; Mon, 2 Nov 2026
 17:24:35 +0000
Message-ID: <86bc4512-892f-4b7e-95cf-f9fd322b92db@intel.com>
Date: Mon, 2 Nov 2026 17:24:32 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] rib: reduce node mempool memory footprint
To: Robert Sanford <rsanford2@gmail.com>, <dev@dpdk.org>
CC: Robert Sanford <rsanford@akamai.com>
References: <20261030161926.1185112-1-rsanford2@gmail.com>
Content-Language: en-US
From: "Medvedkin, Vladimir" <vladimir.medvedkin@intel.com>
In-Reply-To: <20261030161926.1185112-1-rsanford2@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB8P191CA0009.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:130::19) To IA4PR11MB9444.namprd11.prod.outlook.com
 (2603:10b6:208:563::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA4PR11MB9444:EE_|MN0PR11MB6060:EE_
X-MS-Office365-Filtering-Correlation-Id: d846c05c-726f-4601-9760-08df39062a56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|10067099003|22082099003|261102123227099003|18002099003|56012099006|11063799006|261022105027099003|261021123027099003|261021121427099003|261026140227099003|261026121527099003|261009223027099003|261028144727099003;
X-Microsoft-Antispam-Message-Info: FGnPxmR6UElQt4p5D2OzQNsqeS7zYzxqT4wGpqAIohAuaLhzgHuh2KbRumOx+NlSwYRuEioDt334hHDb1KkIudd/ZEazVDIFpN+yO+MZsI+4uzYTP8tmCBO0y0bBuRfh0hZuTJcDnpewFdZoS8nm3lJStxBBv0Z7eJIOyQKegJFpdGw3wCUSgjsE4uvx7iKp0OODdlgEDgr41l1tk4Mwg/RVCQ6ENKSyN5s/Pmt3eMqIOPbXK57/PoPgnj36zsge8w5fjBlQD+C4V2bk1kJDCF5qOMuOC00HlASkMNscXmUUBGyrJNLZfAvuCDMSAAjUHCKDy6zDaNMlzwYPpZjml7usxa1JEofIme1MeC5mM8mYaiAfVBMJDGtz93wJx8tVGEhn/GU/PNUNsvKXd9Dfi7XnVPS6bu1988HUHneADCSUGeSrIpQKo7UyGppg1bgIFC15i119uG7gq7b+0vXA1s6GMbliBYRDoCcQMQhgyIrb7Ya85MONXekKb59ly5ZqQxGJbrH8ZNeS36MZA3BEmqkd6x9m0CZbN9aSS7pxxWsSmxoNC7NAR7f57IC9NXbbcHTrAsqxd7x4LEgZeyR9xo4XqhH0XeK0+VpNZu5Lb5gmWViJxgoqLVGmXTPOuRSvLNWW7IkqE5d1tdcdyW0Squ2mNXQ2kGvAMgtDdJ+ejJQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA4PR11MB9444.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(10067099003)(22082099003)(261102123227099003)(18002099003)(56012099006)(11063799006)(261022105027099003)(261021123027099003)(261021121427099003)(261026140227099003)(261026121527099003)(261009223027099003)(261028144727099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eUpjRDA3U2lockZlMDlyd2R5RXRVaDlaK1NrK09tUlVVandxRUdBbVZOTndD?=
 =?utf-8?B?Umg1eFhUcUNva2l4SFRHbVdXenJ6ZENqcS9xa25uYlFBbzhML3RVTE5INCtC?=
 =?utf-8?B?TEplSFMyc0hQNXBJQ1FhKzZybVVGaEhkRVNJbExUTkx0aHMrWmZNL1ZSdVpF?=
 =?utf-8?B?MnZ6dllRa3l5VVk0cWpINVhUbm5PVW5qUWV3OVJZS3NnQm0rNDIwMENSa3M0?=
 =?utf-8?B?UDl3ZGkzWXFZdlY5NG9XUGpuS245Z0FXYytVU0o5azdDb0tmUkxBS3EvOElC?=
 =?utf-8?B?dzRqTEdUVVhSanlBM3ZJRkVWUit6b2YyYkpmd1pmdUdDTVpiWXlkeXR6RVhp?=
 =?utf-8?B?V3N6dHJ0aDNiMnc4bW84dmR5QkF3RHBmTlZTeVRyeU9ud2ZIdm5wVHpLMm9j?=
 =?utf-8?B?ZXlZVW5MakFHR0M5SS9hb2VtRjFpbyt6dHhjNmlIRzVVTU1vMGZZZlZiYTFB?=
 =?utf-8?B?TmpiNjBBQm5oSjU1Q09vZ3ExREFObC93bXk4enBucG45cFkrS1o0am9ldk1Z?=
 =?utf-8?B?dEMvdkJua2wxSm01eFBnK0dCV3ptMDNUOGdXZ0gveVkzMC92cG15TGlUR0tQ?=
 =?utf-8?B?dGZDODhVbFBRb3R0UU1vQzdURE95SSs2ODdUM0dTcUgzMTdTSjh4ZFNvQ1A2?=
 =?utf-8?B?NlFiVDVhcGpHWnNGY1pYSnpaTXhwcHhmdkdPblBvay9teUZwK1QrUWMxRS8w?=
 =?utf-8?B?TFVCazQ4TU9KTnJVZzI0Uy96emFBbG56cDg4VjMyUlAvdHdwckdHZW5QcHNn?=
 =?utf-8?B?WWp1Z3Z4TnZwOEpjOVNuTW5tYkUvRXQ2WERFSnpJRVB0eWhhREZmSUlrRW41?=
 =?utf-8?B?SzE3Rmc2ZlZmTElSWFVIS0lGamM5VzNpcXBtOWIrUU5ISlBOazR4SExXR0pB?=
 =?utf-8?B?R2U5Q2NGTi9QMWwyZytwaDdSUVlkMDFGVHJROEI2bVlXZXJKVng2cjV4bGl0?=
 =?utf-8?B?eHJkU0ZCaDdQYmF3U0JNVnIyS0JNZ1RSbkc4MzlrWEp1Q29UT3Z1UVhNMzVW?=
 =?utf-8?B?eUN0Z010RnNzTnBGMUowbFh0Kzk1cm1pZEZsZEZXU095d1dkM0R6MkdNY2Nn?=
 =?utf-8?B?cEJKSitCSWVsZGFaZlJzUzVVMFJMczhrNlk0QlNacHdpcE9qL05tU2pQQkh3?=
 =?utf-8?B?QU9KMm5iME9MUVQ3bDRqSGtyY0VrVURQUEFzWlgxUEFmUFFKSWdRRUpCbWVQ?=
 =?utf-8?B?TFNOUHhoOU9NRGMxYlNQMmxmSHFKZEJudXFFa1UxdjAvSVVuQVdKRDlON09M?=
 =?utf-8?B?ZjBFZ2JBR1djVGp3YkswRWxORzg1VU9LWGlTR3Y2Vi8wVGFwZHljdHlxT3Vw?=
 =?utf-8?B?UHdQeEdCRXd6enNYY3dLTmRSSnlnU1g5MisyZkpySEo0NTg3VEdDMkRtVjFV?=
 =?utf-8?B?Z3ZpcDdvNGh4Z0VQWHUvUDNtdk5SZ0lzZk1tZURCaU9kaHlOYzdnL2x0UzF6?=
 =?utf-8?B?TEFmRXNWcUFORDNwWWY3STdHSGhoNVc0OEtJMVl2ajZONkI3U3hlWXdtaSs1?=
 =?utf-8?B?S2gxRXExWGNkNi9jdzRNY1E1T1h2UktnOXoyRncrMDlnLy9FY2IwSWxLTzZo?=
 =?utf-8?B?dnhUVDQ4NDh3TTBHQlhiWXhKUUE4ZmNyOUJpWFYrdHFramNKRUlXK3pGbzhS?=
 =?utf-8?B?VFhaT1R5K0RJQzBUV09NZi8wRm91S283VUl0RE5KSzFrcTlYYWpKUUh0dEpC?=
 =?utf-8?B?NjAzeDZ0SlFMNDFGWE1lNTQ1TU9uSnJhZ21IbmdtY29Bc3VUY1NVbWVKNmlX?=
 =?utf-8?B?dFhuRW5IR3RTREw0ZllwK2FYa1hnUDNXcDFnYkhuTWkyV2svYmdQdE9GTG9o?=
 =?utf-8?B?M09JejF5Tm9hTVBVcWNOTURYbWJxbEk3Yzl6RVBNckJPZHR5SUVzYS9Dam1o?=
 =?utf-8?B?Mk5EVEFGUEZoS0prMTUxTm12aWxoOWY0cXpxK1VDOUx2ZnB1NGc2ZTNFYkVr?=
 =?utf-8?B?dnZSNld4eGgyMVpyVE1WMlVLK3FLYkltRFVrR0pxNHpiYTF1MEtnOS8yZWtr?=
 =?utf-8?B?ZGV5bEx6K3p2bGdmVVhMMU9uaWZKRHJEQVJMUGZiRURVbVprS3lLTDNZcm1V?=
 =?utf-8?B?UWs5KzNEWmxLSCtON3lOLzFFVTMzekUvaVUxLzJFanBWQXdBSnNjSTFKbTc4?=
 =?utf-8?B?Zm9wVUJjZmpRNDlEbGdaejMyME5vOEI0M0VjZW1UdUJJaWlvRkpBM3ZjOWJY?=
 =?utf-8?B?ZGRybEU4eGpkYm05MVJDZ20yMmppYSt3Qzd0aUdReTY1QkE4bHhTa2czNjNk?=
 =?utf-8?B?eTZVMld5cUl1NEU4ZXVRRElwWkt6b3NuQURsc3I2bk1HL0lHcnBPcVh3R2x3?=
 =?utf-8?B?RmlSREFBRVUzZzZtaXVuYXh2VmloalQ3aFRab0QyT3hFSWtrWGw3dlhMdFdJ?=
 =?utf-8?Q?zP5wXotsFRw2u+KY=3D?=
X-Exchange-RoutingPolicyChecked: yio3McE9ERS91R+HV4PbxHe7x/nntgzmMdNmK+nf64NuxjInv/iSANaw/9dslRGqyNIv9z5GpEzoRaVwHpxZFJ9flmDyeGWGKq9dtUpxxGSioygPJHa7bphzGCV2pemBC+5E3JppfE6wa/sxXvxTGT10pXLT8vQZDValwfFgP/T6ku0oINiuAHcYDK9Cyjf03OIZAysPaYJDXwB/OGaUYIegp+wkr4DZ0M+aGPpjaXvOV/+KF+CriwRWzt6BzXTd/I7qTRfRqcW/XvnP1CgrmoZSVqyQMvo1p6KSUxDCt0v+FkHxXvzr08Hwyl6QOyYl53a/gvbjWW6t8jNFqIkBQA==
X-MS-Exchange-CrossTenant-Network-Message-Id: d846c05c-726f-4601-9760-08df39062a56
X-MS-Exchange-CrossTenant-AuthSource: IA4PR11MB9444.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 17:24:35.4995 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sSDyXpt5prGVljKq69dTIjGzb7jkW5IrpZQwEvCQnhV7I1nf/4iz5BWCjNDVQWJ7JYO8jgPdif/SK0V0oYdkzkz4E5oOEooeeFpg5QckTCY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6060
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Acked-by: Vladimir Medvedkin <vladimir.medvedkin@intel.com>

On 10/30/2026 4:19 PM, Robert Sanford wrote:
> From: Robert Sanford <rsanford@akamai.com>
>
> RIB nodes are allocated from a mempool created with no flags, so each
> object is cache-line aligned and padded for memory-channel spreading.
> On x86-64, an object takes 192 bytes for a 40-byte rte_rib_node or a
> 56-byte rte_rib6_node. Nodes are small and only accessed by the CPU,
> so the padding is wasted. The whole pool is reserved up front, and
> rte_fib and rte_fib6 size it at twice max_routes nodes.
>
> Create the node pools with RTE_MEMPOOL_F_NO_CACHE_ALIGN,
> RTE_MEMPOOL_F_NO_SPREAD and RTE_MEMPOOL_F_NO_IOVA_CONTIG.
> RTE_MEMPOOL_F_NO_SPREAD is implied by RTE_MEMPOOL_F_NO_CACHE_ALIGN,
> but is passed explicitly to document the intent. Nodes remain 8-byte
> aligned, which is all the node structures need. The extension area
> returned by rte_rib_get_ext() and rte_rib6_get_ext() was only 8-byte
> aligned before as well.
>
> With 2M nodes (1M routes), the pool shrinks from 390 MiB to 128 MiB
> for IPv4 and to 160 MiB for IPv6. On an AMD EPYC 7643 with 1 GiB
> hugepages, fib_perf_autotest (about 1M IPv4 routes) shows average add
> and delete times 13 and 29 percent lower. Lookup times, and the add
> and delete times in fib6_perf_autotest, which uses 1000 routes, are
> unchanged.
>
> Signed-off-by: Robert Sanford <rsanford@akamai.com>
> ---
>   lib/rib/rte_rib.c  | 10 +++++++++-
>   lib/rib/rte_rib6.c | 10 +++++++++-
>   2 files changed, 18 insertions(+), 2 deletions(-)
>
> diff --git a/lib/rib/rte_rib.c b/lib/rib/rte_rib.c
> index 046db131ca..2ba46393ed 100644
> --- a/lib/rib/rte_rib.c
> +++ b/lib/rib/rte_rib.c
> @@ -425,9 +425,17 @@ rte_rib_create(const char *name, int socket_id, const struct rte_rib_conf *conf)
>   	}
>   
>   	snprintf(mem_name, sizeof(mem_name), "MP_%s", name);
> +	/*
> +	 * Nodes are small, CPU-only objects: skip cache-line alignment and
> +	 * memory-channel spreading, which otherwise grow each object well
> +	 * beyond sizeof(struct rte_rib_node), and IOVA contiguity, which
> +	 * only matters for device access.
> +	 */
>   	node_pool = rte_mempool_create(mem_name, conf->max_nodes,
>   		sizeof(struct rte_rib_node) + conf->ext_sz, 0, 0,
> -		NULL, NULL, NULL, NULL, socket_id, 0);
> +		NULL, NULL, NULL, NULL, socket_id,
> +		RTE_MEMPOOL_F_NO_SPREAD | RTE_MEMPOOL_F_NO_CACHE_ALIGN |
> +		RTE_MEMPOOL_F_NO_IOVA_CONTIG);
>   
>   	if (node_pool == NULL) {
>   		RIB_LOG(ERR,
> diff --git a/lib/rib/rte_rib6.c b/lib/rib/rte_rib6.c
> index 918ddbdfd3..808aac79ce 100644
> --- a/lib/rib/rte_rib6.c
> +++ b/lib/rib/rte_rib6.c
> @@ -488,9 +488,17 @@ rte_rib6_create(const char *name, int socket_id,
>   	}
>   
>   	snprintf(mem_name, sizeof(mem_name), "MP_%s", name);
> +	/*
> +	 * Nodes are small, CPU-only objects: skip cache-line alignment and
> +	 * memory-channel spreading, which otherwise grow each object well
> +	 * beyond sizeof(struct rte_rib6_node), and IOVA contiguity, which
> +	 * only matters for device access.
> +	 */
>   	node_pool = rte_mempool_create(mem_name, conf->max_nodes,
>   		sizeof(struct rte_rib6_node) + conf->ext_sz, 0, 0,
> -		NULL, NULL, NULL, NULL, socket_id, 0);
> +		NULL, NULL, NULL, NULL, socket_id,
> +		RTE_MEMPOOL_F_NO_SPREAD | RTE_MEMPOOL_F_NO_CACHE_ALIGN |
> +		RTE_MEMPOOL_F_NO_IOVA_CONTIG);
>   
>   	if (node_pool == NULL) {
>   		RIB_LOG(ERR,

-- 
Regards,
Vladimir

