Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16E9CCD8CA8
	for <dpdk-dev@archiver.kernel.org>; Fri, 12 Jun 2026 10:06:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2C49C434B7;
	Fri, 12 Jun 2026 12:06:38 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id D3D9740279
 for <dev@dpdk.org>; Fri, 12 Jun 2026 12:06:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1781258798; x=1812794798;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=J5P+scHb48MCClpXSZtQMGkGFOA9F2lcutlPbsMCLDE=;
 b=liuUO58+c4EzDxteN7GEuJns1fQ4exPrZexax8bzc5NZJUGue7/IuVEq
 d2V3/jxTc0PnKcFRoqZmcCpG65LeuiDir85DFClpq0bA4/V9mpMr5S096
 e5U25BYQyIzegoUUufiBzHY0S1Vbw+dy9i++hG1/ZsUaQRh2d8LMVbAHU
 0NDrQnvtu3CjBIuR8sjM9z0sZrQS6IoCJeaBoAz6MFvGgTGUshrLceP8K
 LHRYuslLDZsGhDQ1wJUBxMej73bdzqJYmXBsTWU5f++tccle0BVlFtzdA
 BcgWHAnaz2mBq6gTJR+jeVXZEEDhApG3Ksh3/jM1YhZcnlmMJAZQOGdfq A==;
X-CSE-ConnectionGUID: Be+9W5KcSASnEOxk9bxjfw==
X-CSE-MsgGUID: sHGX1/t9S0+992TN+IJN3Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="82071509"
X-IronPort-AV: E=Sophos;i="6.24,200,1774335600"; d="scan'208";a="82071509"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jun 2026 03:06:36 -0700
X-CSE-ConnectionGUID: LWNCmhfSQWmysXyQNUII2A==
X-CSE-MsgGUID: q9dggyauQpSpZ961TAQauw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,200,1774335600"; d="scan'208";a="270445609"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jun 2026 03:06:35 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 12 Jun 2026 03:06:35 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 12 Jun 2026 03:06:35 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.60) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 12 Jun 2026 03:06:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AHp12TvmjL8pM9TWo4yXJAJSsfwGro1nEct97lGA5XXMzIbgm9Rkxa8maRhUV7VMYruwnb+DtIk+0VmxjJ1kswyXqmAvjvlf97VBC+1CWVMTCUjBo3MIiOme3NSw2/3F8UXdgBOpgoxFLNGNMdVfTB5o/inUdi2D5owzGLf3kTc+E4S472Bm/AsH8i/i7D9mKP0EQ+4kVZRMWunGhjTmYE2i5TiBFA4qz+pUSXplmtrW6su3o22ube/XMNcUtyfcz2qaY17eYuayPgVNJlmi+iodbjiR9mi1e1SlU2EhDpiEIhQHZr4s94UDWhlvInQidkFdFbBJ67majnwYnPGH9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J5P+scHb48MCClpXSZtQMGkGFOA9F2lcutlPbsMCLDE=;
 b=mNtPwKadcFByBdCXbfUwP+OG2t1afyGgfv8Y5c/mA6V3AP4lyNdSA7XtzWq9joDm2p1xr4S0wVVPMyoEFDE7rOPUGHI4OyHLJb4dL5ErsB21I22hOZWPDP2PTcAKOiK98c9w6zsgGGHWtfeNKK1qBmelsg/mGxttI6ORRFUUymv8S16RO7QVyNEH3TCh8akEZhs+DN5dxcmeHeoXLh4fJ35tDWfiMeU9VNAmV/AvCcfj9zJZKnMtOXNH4e1UQpu1Yud2trLPak+JNt6kwtqvtsJ88Hsi1yBvSavrCa/EY5QUa2wxc9duWCb8vJapvYHPsZux/gKG+30vh85nmTybZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM8PR11MB5653.namprd11.prod.outlook.com (2603:10b6:8:25::8) by
 BL3PR11MB6411.namprd11.prod.outlook.com (2603:10b6:208:3ba::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.14; Fri, 12 Jun 2026 10:06:32 +0000
Received: from DM8PR11MB5653.namprd11.prod.outlook.com
 ([fe80::74e3:c0eb:29ee:fffa]) by DM8PR11MB5653.namprd11.prod.outlook.com
 ([fe80::74e3:c0eb:29ee:fffa%4]) with mapi id 15.21.0113.014; Fri, 12 Jun 2026
 10:06:32 +0000
Message-ID: <7b7c32b6-c2b7-4587-956f-0c85a83fdd7b@intel.com>
Date: Fri, 12 Jun 2026 11:06:25 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/15] doc: correct grammar and punctuation consistency
 issues
To: Stephen Hemminger <stephen@networkplumber.org>, <dev@dpdk.org>
CC: Nicolas Chautru <nicolas.chautru@intel.com>, Gowrishankar Muthukrishnan
 <gmuthukrishn@marvell.com>, Bruce Richardson <bruce.richardson@intel.com>,
 Akhil Goyal <gakhil@marvell.com>, Anatoly Burakov
 <anatoly.burakov@intel.com>, Jingjing Wu <jingjing.wu@intel.com>, "Rajesh
 Kumar" <rajesh3.kumar@intel.com>, Cristian Dumitrescu
 <cristian.dumitrescu@intel.com>, John McNamara <john.mcnamara@intel.com>
References: <20250216230903.124496-1-nandinipersad361@gmail.com>
 <20260611212119.1026721-1-stephen@networkplumber.org>
 <20260611212119.1026721-16-stephen@networkplumber.org>
Content-Language: en-US
From: Radu Nicolau <radu.nicolau@intel.com>
In-Reply-To: <20260611212119.1026721-16-stephen@networkplumber.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0025.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46b::13) To SJ0PR11MB5661.namprd11.prod.outlook.com
 (2603:10b6:a03:3b9::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR11MB5653:EE_|BL3PR11MB6411:EE_
X-MS-Office365-Filtering-Correlation-Id: 01a86b79-83c3-4fef-7ead-08dec86a4626
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|22082099003|18002099003|3023799007|11063799006|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info: LWI+hIFtIEAZU6jPPRGcfyR6LoHUMdZCMlXCAcyUEnf3lIVviXs0ElMSULo/a1ddTmShERKhW7WttswU9Pw+wLCJ2iJtMULvtcNv4AUkvmba0jQcZ7+oWjhD0xgQIRyGPUOwOkFxd4I/eLN80qVfC5tjttSX0hJU8qQxcV5VbM/hKAcdh04esIJa9h/BnFpC7+KZkdRRyFBZi+xqs6R3Gv6Mjve+rWJnSx4+YqfBwUHtrE/+U9PFAbxt93hu1mW/yr1sVWbPkaLV0EF93x2rkLmP7gzz4D8MprO6UxVOz5U7u/oYqxXRcc+M0UxCf6htbWcQzdbcgV2XGPVe1kZtPWWgNilxSJMQ5bgxzJY4N9+PXLXacyS15NHJ4XMJ/8EqBJ67AhdoyVU3I3tQUG1ZpqVUaWKY9iTx/oqlI7KsqR7nI5QWhIIhYlT3k3gTx89YoUfMX6dE75D5P00hP3IrN1SchV5xumfipzYmKrbfQw4s0E0ROniBT6qKJ3mQr4T5Xc/SHjSLewoKxEADlyuvQsb8so2zOHUmgMFOiky2rXUIHFLHL6bH1nwyf67hVOtS9Zz57/3q5p0nfCucT4NMiOnvP5I4osN54VyNNNzh69xTUoSG6J9CXLpByixqQIibkaEVL7k/QELHSyGum39OAZsDAtMdDgT78/rRAbVoIxZmojhMiHID5Q81V1pBHjHD
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR11MB5653.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(22082099003)(18002099003)(3023799007)(11063799006)(56012099006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b0JPZjlvbEVVWnFxbVlMbEFVZWxTR3VjZHc3ajN2aXdmNk9JS0VncjlxUTdV?=
 =?utf-8?B?QUJubVVTYkcxcG45NFlxSmZ5LzRSVHQrSTU5L0hnWXVRbWlmLzBPMkZ4NTJT?=
 =?utf-8?B?SWtwak85aVNMTzJDeGFLeERsRDdvTTRUcDc3VTBxeUIvZ1dXYmNucUxvY2Jo?=
 =?utf-8?B?ZFRtV1FOVzJiLy8vUjVvSjdqYzE5a1Njc0ZRVllPelFpWGZxSjVrVDc5cGN4?=
 =?utf-8?B?OFFFdy91TjRaOE9CVWd3dDN3Z1lJSjk1NE4zV0pRMEwweXhST3MwUXltR3Ex?=
 =?utf-8?B?REFFVU5oeXQ4d01HVkJEM2dqMENNanAwQVVjSDM3VEMyaUxlakhMSGZPaVNM?=
 =?utf-8?B?cVV2cUUySjdNb2E3eVZOZUlCaHpVTkZUZUFQT21RR24vQVVMVEdkaU9tZFlw?=
 =?utf-8?B?amNncHZpSHJRZ1J0UExrRGpkRFJoVHd1eFRnYkxkM0tkSXNQMEQ3T3RIeXhk?=
 =?utf-8?B?ZllkQUdrZXhiY3FISU9rK01vU0dOeE9RVUlhN1JwRDZwVjIxT2pBTThocDE4?=
 =?utf-8?B?ci9oUzJ3Q0d1cU82Zk1mSWt5eXFDRGNvWURoY1VhR2ttR2M5VXMrUWpweUhz?=
 =?utf-8?B?Uy9kWlJBZWM4aWsyS3prOGhub3NJK0tZYmlRd2tsUGRSYnRVY1NBM0o1VkJG?=
 =?utf-8?B?TmhyVWc2bW9GcG9xRUhBcXE5WWVkS3FURVI1cFNsUGdkUkM4QjkzUFEyNElk?=
 =?utf-8?B?clBnYWpSTm8ra3lKUHZCSnZUWE5mZU1EOFlsSGk4L0tZR0tqbTJwb2E4dGQ0?=
 =?utf-8?B?SW5mV3kvYXE1dFNKbDc3VCtRcnhJMHZVOVZ6Qk82NndwZ0xhajlERTl3ZEpP?=
 =?utf-8?B?SHVIWUp2VHBsUE9sMDRIRG1zVnFqL1dWZVpTMkIxNVhYN0FCdGJDNmtjclFM?=
 =?utf-8?B?cE9ZbGtwWXlDb010RDJFOC9QRWZmdHhEaVdXNStVaGthZzVlRzJjZVV3YWw2?=
 =?utf-8?B?UUFkVndaZVVQSENnMmFvUXNROW9PUHo1NTRjMmZWMGdxemZRck9NdnZ3MVl2?=
 =?utf-8?B?OEVxUDJOYUJJMnM0LzE3WkcrQ0lTbnA1YzVTNDVBdUtaNEc1TllpTmwzdUl3?=
 =?utf-8?B?QnNUS0RuNGR3UU9HMG1qUlA5amtzN0hwcTJ3VUxIT3NuNGxHWEtpUE5JK2x1?=
 =?utf-8?B?ay9KVE9ZQzl5WnFIdWplMW44TWlZZy9kQ2lxWHlPLzVaczRUUllMbFkzTXM5?=
 =?utf-8?B?Z21tY2dJZVdHaVZFdTdDQzBCbTh1UVdYQUwra3MrS3Ywc1VLcEF6eGNySDhU?=
 =?utf-8?B?VUNrOWxrNEU1NFJrbTd6RHhEVXJBd1gxVit1NGZrNXNvcGNxcWVzM0dkN2xU?=
 =?utf-8?B?amt3VHVCZ0o4UHM2N0hsWGFJWE9Fbk01RWR0SW1YZE1mcE9UQjdhdjhWZHA2?=
 =?utf-8?B?RUxXZ3JxZ0tsMUx2R2ExZkNyaEdkUzg5QXlDZEZYK04vZWVwaW5YbkEzWGRH?=
 =?utf-8?B?Skk2VFlsZEdxUmdrTkVTV1pTMm5TQ3lNUE9SYjU0L0RYY3V6cWoyVnJjNTJs?=
 =?utf-8?B?QTdqTHg5YUdaV0RYblc0cXhhNnpTOENYNnlzd0xWOFRaWmhBSGVGU1pyMTFQ?=
 =?utf-8?B?aEgwTUM3bVZlUFlzMGE2QWpZT0s3UVdjaFM5SVJzd3NSWFZDcnVHVG9NbFR4?=
 =?utf-8?B?ZjlVRCtVK0RtZ1JiTGxXQTVDMXRkQlJqODh4QmtpRWVnb2RJa2RHWjNSNGVK?=
 =?utf-8?B?a3FvR0hDd1lZS29ueW9seHdZb1d3K3kzZmdBTGMwN2E0NXZNNVQ3Sjc2Z1Yz?=
 =?utf-8?B?bDh5Y0RNK1JBYUlKelArRUFMVkNlS0J2V25sOG9TVmJuMHZyRDhua1dBTXBE?=
 =?utf-8?B?VzBlcnNxNTBOYWdJSjJ1SnZFM2tuK2lIUzhoZTZBYWp6T1YxQ1BtUHU5UVZW?=
 =?utf-8?B?aWYrMm5hMHp3dFkzc29zbnJLRmpXdW9GNmJxY1JOVW5ESkt0dFBnamV3V1RP?=
 =?utf-8?B?VEN5VmR6YitJRnhnbHdNTmFrMmh0NTZyNi9qL1NGYWI1bUhnR1ZLSEtsZ1I0?=
 =?utf-8?B?ZW8vOE9ScGIrMGFQcXdHVE94Tkl5Qkp3Rnk1Y0U4amVncGRUUVFkakIyZzEz?=
 =?utf-8?B?VGR0OUJHTGozREczWEYvVW10eTlPZE5kM3BUNTVVTjlVbTJHZXdzd1prWkFG?=
 =?utf-8?B?Z2E4WHJkU1VXbUpMQzFsZXJPQk5mbFdnZ0thbUlSRHd4M043aFd2S2J2bDZB?=
 =?utf-8?B?UTh5UTNEcHJ5eis5SWxJREdFUFdtemh4MzdGZm9JNWZONkY3RU1kczNiZHJJ?=
 =?utf-8?B?aDQrOUFMaWJDYWMvdVBHQkpMcFYzYkpSWDYxcW4waCszNFRBZUdTZ1RUcFdo?=
 =?utf-8?B?ckt1blQwekZwWmNNMUF3TDhNT2N3ZGluSzlvSm5jZzlTTTV0WEhIZz09?=
X-Exchange-RoutingPolicyChecked: l3h/HWuQRypVXQifYq9utj/Z3UoLrtmtFkEkEN6FyYdXnH6Vc2PGM3to7E5Q5Wb5FDlpn4rADT8LvSZEOsXEUI2BbVGgU8AuwOG635uOnfNbobUOZXycniCfpXH0nadyUkevGok3b9x0vF6JS2/iaGrrPetTItQKBHHXLsv/R5REVR5c0g+XfpzUBwyeP93G1jwOKcQBZlKV/MAShb7SdSjiDZ4yTLRPrvvEefs2KzNbK+gRk5WSS10DfWzMPcUeTAeLWLYKR3D+vZQg1joQryDI0XbmfisT5SEbTLEHNOJMY4MFEKxbwvxt0Q5vQas8VuT19bc6YGNryqxo2ghQbg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 01a86b79-83c3-4fef-7ead-08dec86a4626
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5661.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2026 10:06:32.6890 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nQdNCL68mMfvuWdk6EQHxi977W8sB1IdxhVh7J9J4/boO0GLVzg5pYrR5JGCkiMC04Lv5Ot5J1VrtF3ILccX8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6411
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


On 11-Jun-26 10:18 PM, Stephen Hemminger wrote:
> Correct grammar and punctuation issues across sample application guides:
> - Added missing comma after "To compile the sample application" in 11 files
> - Added missing period in cmd_line.rst compilation instruction
> - Fixed capitalization of "Linux" (was lowercase "linux") in 4 files
> - Fixed capitalization of "Ethernet" (was lowercase "ethernet") in 2 files
> - Fixed "then" to "than" in comparison contexts (2 instances)
> - Fixed subject-verb agreement: "specify" to "specifies"
>
> These changes ensure consistency with the style used in other documentation
> files and improve overall readability.
>
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
Acked-by: Radu Nicolau <radu.nicolau@intel.com>
