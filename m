Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C091C43458
	for <dpdk-dev@archiver.kernel.org>; Tue, 14 Jul 2026 12:11:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D970940289;
	Tue, 14 Jul 2026 14:11:10 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by mails.dpdk.org (Postfix) with ESMTP id 1BD104026E;
 Tue, 14 Jul 2026 14:11:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784031069; x=1815567069;
 h=message-id:date:subject:from:to:cc:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=ldfJHiHmC1A8axi5+YZGwqBexZ9p7LAKRhrghSEu7jg=;
 b=hyQLBnRtlXIt+Ssgx/+4Gr1vPqdjZuh8u651UnGXCNfMcnsgsKvFZTi+
 Yw+D0t6hvo5tMKesXnDGhTyDdbZ78708PRHQqXn2zBwt13NH0/1OGZfcI
 T3SzoMS/yWIFm2u4EOY1F0zDknrAeqcFmC03HY2WjO1yQ0QoHDxQ1l4L8
 kDcXdnx67UzfTf2OMWJTQKqIIgcVhKWB3vnWvPJm7nyWbN88knOr23JZs
 c//DFKzPUUcxwEfU2lFuxsOJqyfoIXzKLtWgWK+guJGeGxiRSO0InkZKA
 Z4yrBBak7iJykaT1t0Du4OANBFWMsrNeMaDf9UE+/oZUHHELA+mRiNXOy w==;
X-CSE-ConnectionGUID: SRwKMgO2RbCBx15qhAQ5SA==
X-CSE-MsgGUID: lR1QwVDtTX2IaqV9lbu9eA==
X-IronPort-AV: E=McAfee;i="6800,10657,11846"; a="88550171"
X-IronPort-AV: E=Sophos;i="6.25,163,1779174000"; d="scan'208";a="88550171"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jul 2026 05:11:06 -0700
X-CSE-ConnectionGUID: 0pFaMzs8RcmtpEHpBfcj5Q==
X-CSE-MsgGUID: oqlatWinRemP/M0xste32A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,163,1779174000"; d="scan'208";a="280257338"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jul 2026 05:11:06 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 14 Jul 2026 05:11:05 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Tue, 14 Jul 2026 05:11:05 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.6) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 14 Jul 2026 05:11:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qH7wFHLesrahVpDLuMG+QhXYH8i9VNHC15BDBwDn4dcYXGzGcLYvAO3HfrSmn2OmR1zuMTkXGy6mhfCkR74EHAjH9ATRM5Jj9COyuofC1IKlM8xC5Xo7APIci2QrjARcPExVjToI7gDYpv65gXuhY3Fje+jx7Qp0/K6UqOLkex4qWCsPF5RAnCBNnj79gfyf/2fhYuuZmHaqL7FY1Byw/i4k9J5WHrrxUgOWpTXlpcW0mwL4w4vcY+Q8na+gPNELaQZW+jKGXgFFNsNAllSncMoAu1Y8zsclE/3qjchO3HGc0bwmyg57YaFhnaBAQskqwhDQnNNgymUPCB8Ze22vnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=slnst0LJWjrr/DPgUSeDgvdEZV89v2/KnVLT9qUkOnQ=;
 b=URnfxdk6Rsaw8ftO4/LnwgruorxeTFHZbhFd87432uB3i1n3ei4/jfBO98WHV3MaAEBgxMbtMieR3GNKOgLiD0x1RhWLzVcGIvjulaINKoRWIK7mEr6pjkASTVQ3fqzIs6cqT8IGTemHAXFcMJH2D2gaJ34q/DWYqM/ZuEpPWm+gjtBFkqt+mg+CuFQ3TCTJkpQ47hMwTJq6Ph/tn0RBkZgGtHpJrEkg6uZzojXsT0BVPk2y3Qw7Ln9nBEpLvCMVhsUhHCtj7giDU6oV/JFXjBt1R01Tc1F9rtVbfJGUXl8zChvCGXYaYYXdcSe22lP2LgTitsyV6G/uCMwIZhR6vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM8PR11MB5653.namprd11.prod.outlook.com (2603:10b6:8:25::8) by
 SA3PR11MB8022.namprd11.prod.outlook.com (2603:10b6:806:2fe::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Tue, 14 Jul
 2026 12:11:02 +0000
Received: from DM8PR11MB5653.namprd11.prod.outlook.com
 ([fe80::74e3:c0eb:29ee:fffa]) by DM8PR11MB5653.namprd11.prod.outlook.com
 ([fe80::74e3:c0eb:29ee:fffa%3]) with mapi id 15.21.0223.008; Tue, 14 Jul 2026
 12:11:02 +0000
Message-ID: <3a7dca2f-ed42-4471-9ada-df5c3a63de46@intel.com>
Date: Tue, 14 Jul 2026 13:10:57 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vhost/crypto: fix segfault
From: Radu Nicolau <radu.nicolau@intel.com>
To: Maxime Coquelin <maxime.coquelin@redhat.com>
CC: David Marchand <david.marchand@redhat.com>, <dev@dpdk.org>,
 <stable@dpdk.org>, Chenbo Xia <chenbox@nvidia.com>, Jay Zhou
 <jianjay.zhou@huawei.com>, Fan Zhang <fanzhang.oss@gmail.com>
References: <20260624142023.1525497-1-radu.nicolau@intel.com>
 <CAJFAV8wCno0t-oLAtVCmWjvYOdcxGEGohcxOb2JP_W4W3cr7aA@mail.gmail.com>
 <c2920f91-4c4f-4e30-8626-12f2606a20f9@intel.com>
 <CAO55csyCW5nms7=nCzLw9PA0kptGrGQgQARZ1HJEGBu_Ws4CFQ@mail.gmail.com>
 <dc3a218b-815b-4d18-838e-c3f463b4391b@intel.com>
Content-Language: en-US
In-Reply-To: <dc3a218b-815b-4d18-838e-c3f463b4391b@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DB9PR02CA0008.eurprd02.prod.outlook.com
 (2603:10a6:10:1d9::13) To DM8PR11MB5653.namprd11.prod.outlook.com
 (2603:10b6:8:25::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR11MB5653:EE_|SA3PR11MB8022:EE_
X-MS-Office365-Filtering-Correlation-Id: 71774c1e-728b-42a8-4b9d-08dee1a0f89d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|6133799003|22082099003|18002099003|56012099006|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info: tiHxwSIj25xs35aynlt28HyeH/q9hJ9cNCuszHTZqtLwVEJ6SregBBLCyFGTHl+W2QVr7VU+LuIeou+obhHseb+Zf9Sq7ivq6VYH+PibC3gOOWOfOTsMr+WD7+b7/nOYXYn7bP3JJdCUocNfIoX/pO27TMfQWbdMmncF0xx6Ree1XQsDF6HwX+qVrIWs2DlPL0Yzo64qCbH5/4CtWoiQvrke/L6m22lP7L11wP+ZpDYP12skjJqw9YvuIh6iKKjwQ3vaX5tOWDZUIZ+kranSV0ry4sTKv6zKIepSAnyyIpg8UMqLB59r1M2HWWhLAki3UndhLlFbmJydAuEKKJIHcomE+dYS/yVPsrlT+XJ688Aw6IbSgMUYqUZiu8bIYfw2OQzKEaJx2AKqdA+fnMd7ns+fYsFHQxBi6+vnLbenohIxAQBvpDUBhTjb8zLGiBIOXI8nCe8uB17Q5WVRO5PxW4nCAETh/r0RIfo2h1x+fheCPs5DPIBKh7uLu+Mszf9Fb1NZQwwQ5CHptvSsA9xV/qRqokNonjeWdLQqFXZMcQDz5KdFvlrodv4awCqwiTkfyPMgP8WFkcmi57pquMaKDS3aL8p50z2ZwlbBbUqanqfsh+OG+0zWI7pu74SBSMDcrrWPeQM0Evbw1y5hfodzzt2BTnNFvezvHr/SUOe0JLA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR11MB5653.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(6133799003)(22082099003)(18002099003)(56012099006)(4143699003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VTI3TFRqY1VIa21JU0hGMTRxZmRBVmZaakY2YjY5SmxqRU1JRmU0V2haWTdr?=
 =?utf-8?B?U1doS0hZN1JKbWN2Rjdwb3FaMVpnWEZndklBeGE5cDlNMWFOUkZ6enF4WUVH?=
 =?utf-8?B?c0p1RHpLdDJzTkllMFprcklDU3pVZXRma3RNZzNTZnJrSCtyeFgzMXJpQ2dO?=
 =?utf-8?B?eS9BSnUwMHFXTCthZTg5M3F3V09rdlN4bEl4WGhJb04wSE9ucVZCUmp6THpx?=
 =?utf-8?B?bmdPaUpYU01vcnlwYTlLdXBMWGZ3dStjcUVZdzZTUUJyUGpFZEpvWGdrUnRT?=
 =?utf-8?B?dWEzcG9PVThFTC9UZVRWNVRmYmdhei9GdThBSEE1M3VtbHFrVit0VU9aUWc1?=
 =?utf-8?B?Nmp6UnczdWpTVWtzUFVDbUNzN3l1S2RRMlBrck1lZEppZGVNbVBDNklXbU8z?=
 =?utf-8?B?OHVOaXVuWm1JeXdlQUo2MktFbzNMaHBCQlZIZU9GZkUvZzFEOWkvd1krK3RD?=
 =?utf-8?B?MXhjbytuY21FNkkrL1pKOWl5VG1BZmF4bk5tY2pOUGhQOHRSWVNrY3V2QkNv?=
 =?utf-8?B?S09iTHlLTDJDL0JSaGlpVlRjSWVkL1hzaVVVZVNiRnhJT0xFbGZXTERoSitx?=
 =?utf-8?B?MC90YnJJOGkxd0pvZStQd2hUVnlkSDlKMS9pd2pXV0xsYUJ3QlFaUEZvOHZN?=
 =?utf-8?B?UHlKMVVVSFdqNEY1QTAyeWdYM2pTcmVyZ2NjUE9QM3dXeDVHRzR2WjUxSHVI?=
 =?utf-8?B?cUxVVzg0YitmM2hLQ2MvM0tiMk1obVd2Rmp6SzBWWWRrdmd4WHpJQ2k2b3hm?=
 =?utf-8?B?UGpUSm1vK096MTdEOVpFSjQyeUZmNG9PbWdGUmYzYWlidUZ2b2JselRnazlK?=
 =?utf-8?B?N1ExNFNxcjMvajlUSjlmaFZTc1Z6akYwTmE5dllaaUV1ckhZM2lvT2s5cW5Y?=
 =?utf-8?B?NWVUWWhUQTJIM0I1UUV5RktGb0lGS05aamZnMTFhQ2d5RnJwRkNMOExaTDY0?=
 =?utf-8?B?M0dJMkxqY0duUVZhTm9EdnlYYVdxN1NnUkRkbXBJd2pQK2NKM3JvVkNsUmI2?=
 =?utf-8?B?WG5qQW9Nb0Z4R0tqWG9INjRPZE1IclVscVVxYjF3VzVCQkRQNS9hczdXbVQ1?=
 =?utf-8?B?OWpLV2NmbHBZdmtaWk93bnVOMzRKVEwxWjJyRjJTY3BzdlFBNmJwVllnOUls?=
 =?utf-8?B?SnJEb0F5SXlTZHBvVXBFTHU1WWZKWWtVeGszRExOUHpPRWJsZ1B3bkhzOC8r?=
 =?utf-8?B?dFd3c1JxT1ZhSmFEZ0U3VUUwa28xdU0vQXIwdUtRR0QzV0VhdHdFMWhpOVFi?=
 =?utf-8?B?QVlQVVZvem1YRUJHVFJqVWtINERQWkxzU1hzYnptVTdmQlpXYkpjVHQ1YmFE?=
 =?utf-8?B?S2dyTFB5U1pHd0dzMnd0TkUwT01zTUZTbGZDNGd0UW9lNjAvQU55OW1OTWh5?=
 =?utf-8?B?c2RWTjduRnhDU2dLc3FJTlI0RnU1OEtLdWVNTS9WVHlRSUtBSWJNZFJuMWR5?=
 =?utf-8?B?L0tKU2dCUjBqQ0RmRy9JT01zVFNwUkVjdjBLb3V0WDFBeVhpTDJzR3BHMVhx?=
 =?utf-8?B?YlQ5SWRGL3JIQWcvOTVmcXhKNlNmMkZPT1M3OEZtOFp1VUJDSEcrc0M1MjdD?=
 =?utf-8?B?UnpYc1RLOGdFWnN6S0wxem4xanNMS1VOUVdCSVRqZmNMQnZiT0NxbjFENFE1?=
 =?utf-8?B?RTBFQ0VTQjk4ck0rVjhrTVpFRWdUNjd6cEpxNFJ4Z0lpTmtsMzY1VjRIVWpu?=
 =?utf-8?B?cHpMRk9HcFJSdGRDU0VUYm5JOFZLV3hkdFlwU2dicWw1dSswSzRuQ1ZadHhs?=
 =?utf-8?B?WTBiTHJCUFRKRndxTFN0M0IxQXV1cm9MQmROMEZrak1QMGlCVnEvc1NIQmhn?=
 =?utf-8?B?S1M4eXl6VHdyUTZpRnMxTmQzaHRnQlhpb1cwYnNsVTd6VkpMRG5KYzF1YUhF?=
 =?utf-8?B?S0ljMzlSZzhhNzNqdlRYWjZHdGY3VkdSclpPUHBUZUJDY0lBOU9EWDI2T3gx?=
 =?utf-8?B?UUc0aFRXYzg5UDNSeFNpYlNEQzJpeFZtMmhNeVFHRDhsL2lkOEJUTDlQYlYv?=
 =?utf-8?B?K004dUpVT2VNT0RFR0ZXUE1iVktXWjlyemdiWGRUQk1lOHl0UjEzYzlsZHYy?=
 =?utf-8?B?aDd5SXE4TEgwL1UyRDZJenAxQ1NZZFdlVjc5U0QzeXN4UmcrZVQrS2QwOTFp?=
 =?utf-8?B?eHNLWkdTcWdHMGFOelFCeGdRMHVWU01wN2ZWVFJ5Sk1kTXFIZWZkcVNDZ1d1?=
 =?utf-8?B?eFoxV0VlNS9ySEcrbkRKNjRBT0Q3SURMY1lGMFRZZVdvdG9hczJFbU02R2Ra?=
 =?utf-8?B?dDdhMVkxTjBqaWdheUxUeUtMSVVrQXp2Ym0zS1N6SkdVblhTOG5od2p2U3lZ?=
 =?utf-8?B?ZDhETVp6MmtJdmdXZGpqNHM1V3hRZEg1cmtYVDBXVi9rcWU5NTUyUT09?=
X-Exchange-RoutingPolicyChecked: tJrKOt2KV2f/zjJrKOj5VpegJIjLsAVpvpIBLPraPMRjN4BpvGNsvzDIZ6+GP5ekqZYTMwnjsQckv+aAT6D5EPBc/E7gl8QzwrCpYVg3g1jbYbTq7d0SPuV8TMyu9i62ngDYPLR5AHAVz05bDF2V3+gHhJzH9fWFSu5FbmCDaLCOSufXvUvs+x1FzJO9QHoQjDUQdMdcV44jrXhD5cDgM7wRF7YwJadDQordDofSdymfiuhp3IoLZIrtW8BwsLegtrUBKS0pioDSRf5CN+BRMcqaIM42vupaNQaomT/Q5H+1w76UxI3kQ6khHC7FzjXctJr1PSG6otmtxVXuKvNK7Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: 71774c1e-728b-42a8-4b9d-08dee1a0f89d
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5653.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 12:11:02.6013 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RR3FsQtqtlEgRRFbs66DM/9eCKoAUGP9XIklIZ+alB4zQA/cjMboCKOsKy8uTPK2PtXoUul1TnujQyF3Z7lE+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB8022
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


On 29-Jun-26 9:35 AM, Radu Nicolau wrote:
>
> On 29-Jun-26 9:18 AM, Maxime Coquelin wrote:
>> On Fri, Jun 26, 2026 at 10:50 AM Radu Nicolau 
>> <radu.nicolau@intel.com> wrote:
>>>
>>> On 25-Jun-26 1:44 PM, David Marchand wrote:
>>>> On Wed, 24 Jun 2026 at 16:21, Radu Nicolau <radu.nicolau@intel.com> 
>>>> wrote:
>>>>> Fix potential call with dev->mem uninitialized, one common usecase
>>>>> example being running the autotest with more than one device.
>>>>>
>>>>> Fixes: 3bb595ecd682 ("vhost/crypto: add request handler")
>>>>> Cc: stable@dpdk.org
>>>>>
>>>>> Signed-off-by: Radu Nicolau <radu.nicolau@intel.com>
>>>>> ---
>>>>>    lib/vhost/vhost_crypto.c | 4 ++++
>>>>>    1 file changed, 4 insertions(+)
>>>>>
>>>>> diff --git a/lib/vhost/vhost_crypto.c b/lib/vhost/vhost_crypto.c
>>>>> index 648e2d731b..3679eaca1e 100644
>>>>> --- a/lib/vhost/vhost_crypto.c
>>>>> +++ b/lib/vhost/vhost_crypto.c
>>>>> @@ -1512,6 +1512,10 @@ vhost_crypto_process_one_req(struct 
>>>>> vhost_crypto *vcrypto,
>>>>>                   VC_LOG_ERR("Invalid descriptor");
>>>>>                   return -1;
>>>>>           }
>>>>> +       if (unlikely((vc_req->dev->mem) == NULL)) {
>>>> (Unneeded extra ())
>>>>
>>>> It sounds to me that some initialisation failed, or processing happens
>>>> without waiting initialisation finished.
>>> Indeed calling this function with dev->mem uninitialized is caused by
>>> some init/deinit state bug, but I still think we should keep this check
>>> in for added safety.
>>>
>>> I will follow up with a v2 to remove the redundant () and also I will
>>> look into fixing the root cause.
>> Or maybe this crypto backend is lacking proper protection between
>> control and data paths?
>> If dev->mem is reset to NULL asynchrously by the control path without
>> proper locking, then
>> the above fix is not enough. For example, the above check could pass
>> and dev->mem be
>> reset right after.
> 100% there is a deeper root cause for this segfault and I'm working to 
> find it, but it may take a while. That's why I propose this as a stop 
> gap fix, it adds an extra check but of course it doesn't remove the 
> root cause.
I'm unable to reproduce the segfault anymore, I will drop the patch.
