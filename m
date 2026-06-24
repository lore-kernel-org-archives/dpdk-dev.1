Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12AD3CDB479
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Jun 2026 09:21:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4ECEB40616;
	Wed, 24 Jun 2026 11:21:18 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id 617C2400EF;
 Wed, 24 Jun 2026 11:21:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782292877; x=1813828877;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=rmPGDrenw3U70/aGhtLsTnBCu0EPVdkP2To7FKAPQNI=;
 b=nIzaDhcUpfwyRBl/Fye0+XN512NFXPFFOB8KKZE/G9xi8eIKLO0qCRJ4
 v38l7GztqBS1OGDJA8xlWD/gwqdBJZ70CLOA25m4+vhG18yDL0RSyVB6a
 rOzJ1lxChxHWvIWxSsC4XMI5GzDmJG+KH438L5YWn4/QKcj5kj/DIAmyy
 8JQzEMFk/tXuuhxwAqs+k+N9GU6blnnsP0kBWGqabshOZR9JwLyhT1/as
 o4VEMAYvH4Xw2aiCAyQMbV+GrSj3Xy6WxwEvQBPoDezh+7ZAJGyweEF2K
 2j3KNMzNQysvGsoxFp8p86P73voia0W+ndF2a/3IXtDQ8FjwLReB32dsL w==;
X-CSE-ConnectionGUID: 7rPKnRjkTcK1oh20g2YBEQ==
X-CSE-MsgGUID: /wZF2TCmQ22zCSKqON2dWg==
X-IronPort-AV: E=McAfee;i="6800,10657,11826"; a="100473393"
X-IronPort-AV: E=Sophos;i="6.24,222,1774335600"; d="scan'208";a="100473393"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Jun 2026 02:21:15 -0700
X-CSE-ConnectionGUID: doM+QG8fQWizp/3/GcoT9A==
X-CSE-MsgGUID: Gq80uxBBTHKfclekPKoNrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,222,1774335600"; d="scan'208";a="248887314"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Jun 2026 02:21:15 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 24 Jun 2026 02:21:14 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 24 Jun 2026 02:21:14 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.2) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 24 Jun 2026 02:21:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aeZ+LuI/JRGcO6DpjOpMF1Ht3o6qG65qs2CaYJcn+656xj2jMKJjT+AOb4LnJSBgKu/wOmuQM00Yt3MK6O6un0c1zcsOUy9MTLZWGxi9NefqR9Cl1JVwpoaCmR9hZ+3U5mZnYFCv3av8px9EoKD9clQbN9DnDMhaUtcKHAWBBefHJ1ELV7jZnNn0dZpTeR/qlY3zgMX118Xua15kTtRcFFZBKcqmRrrNzYWZmgt2iRxHxZgRMoX2B/qBw9HMYaUdVsTv8XHD+/bXjydDMTaHaWBZ2H1xmJ5M05ZWnbY/eDN+325RxB0BGjMyOqOQT8oDGF8sdgdWkaHHLDhqUriunw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rmPGDrenw3U70/aGhtLsTnBCu0EPVdkP2To7FKAPQNI=;
 b=Hkv3LKIykgSfq2Zeintbxo6Z2Cq5LlKd0FDr/3A506iCzdl9wiTcnOhe9SNci4ivzv6mxYH7UZr4PmNdeTXmZSliGEsaOP/oRAksqisVS0Z4iR4LUx0asb8wU9v/s9vznQMyGc1NTuGyB+niJbdtdPs/KD2W35BhdCUqNWcNWQqdhi9cshjH+y3uM/3PQCo/R9LXedvBp3utxcOGYsiz57PNtw6TU57lEuleq0nKHVNqhOttPnligLwcd7F8Bo7WaCYTY9u8ux7KF0Eu80kLkVG9DSD1qG2PSRhmlVDRBI0dCkFSqdboghcUBJbL+bcHt/R1WGHSxa72g3KApvqIgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM8PR11MB5653.namprd11.prod.outlook.com (2603:10b6:8:25::8) by
 CY8PR11MB7687.namprd11.prod.outlook.com (2603:10b6:930:74::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.13; Wed, 24 Jun 2026 09:21:11 +0000
Received: from DM8PR11MB5653.namprd11.prod.outlook.com
 ([fe80::74e3:c0eb:29ee:fffa]) by DM8PR11MB5653.namprd11.prod.outlook.com
 ([fe80::74e3:c0eb:29ee:fffa%6]) with mapi id 15.21.0159.012; Wed, 24 Jun 2026
 09:21:11 +0000
Message-ID: <045cbeca-a62d-400f-9ad1-26fe4496537d@intel.com>
Date: Wed, 24 Jun 2026 10:21:06 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] examples: use strlcpy and strlcat
To: Bruce Richardson <bruce.richardson@intel.com>, <dev@dpdk.org>
CC: <stable@dpdk.org>, Cristian Dumitrescu <cristian.dumitrescu@intel.com>,
 Akhil Goyal <gakhil@marvell.com>, Fan Zhang <fanzhang.oss@gmail.com>,
 "Anatoly Burakov" <anatoly.burakov@intel.com>, Sivaprasad Tummala
 <sivaprasad.tummala@amd.com>, Jasvinder Singh <jasvinder.singh@intel.com>,
 Sergio Gonzalez Monroy <sergio.gonzalez.monroy@intel.com>, Ferruh Yigit
 <ferruh.yigit@amd.com>, Pablo de Lara <pablo.de.lara.guarch@intel.com>,
 Declan Doherty <declan.doherty@intel.com>, Alan Carew <alan.carew@intel.com>
References: <20260623154109.722441-1-bruce.richardson@intel.com>
Content-Language: en-US
From: Radu Nicolau <radu.nicolau@intel.com>
In-Reply-To: <20260623154109.722441-1-bruce.richardson@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU2PR04CA0204.eurprd04.prod.outlook.com
 (2603:10a6:10:28d::29) To DM8PR11MB5653.namprd11.prod.outlook.com
 (2603:10b6:8:25::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR11MB5653:EE_|CY8PR11MB7687:EE_
X-MS-Office365-Filtering-Correlation-Id: dac5564d-4327-4f55-57f4-08ded1d1eebb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|6133799003|56012099006|3023799007|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 6djUDzrE76AC7TGjtoL2SM3OHCvt44VCs6r3SH76bQiWpHtPBPVOdbP3nzG28kCUwsDoIoY/sRk0afyFvD8quIGxIhoQSM36/E9n9KtJHRsaXumqyB1KriP5YpuvEqxPNCie8Tnf6Ov9mbHQUsMa0lI4ygdl8Jz+niKsx8PXEZv4haw2sgJHWEuMUOJVvi/aMuyiQ2hxQ3794Ye1Br0yuCwc5NaXWYaPddxTrjU2fUtvZEpeAugxBVe3uwwT/WYo1Wg3U6ALm5/aXSEZeRqFHwXMOQunhIL3z9NzEBjTGDbwk3VxLXt+xXnR6oLX31z37dQn0f8+/33SrcwW1gWHgKHHbMQ83Wg8DGwywSikPuuO5p70kp6f2GDGTWW3Ad5dxTIybv6ov1Hfz3APbXmDqYI16/BRAclDIZTtQysohZeIGG2j2ARv1wDGpc7mZHoA4T17R+dWcDEiIh6zgkHF1m6a/XTzh2i191iFZB0l8eo3JE4H4C9zXmFAK9sZV+8VKpS2qUrDf2laM6vT2rryJGBoOaVvHnXGDwAIeqlFeJO0FggBjAyDyjTN34nW2C9m9p1Y1chn1tUUYe7YxqFVX+ODhv4V/rffpj5PXqZ4kqjum9zAG4iYoAu/YkGzx/Dr7m3HRFRmAjbJ/KxZYQ7RjHJ3HxAbI06gH+7r3DtP75E=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR11MB5653.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(6133799003)(56012099006)(3023799007)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S0FEMHE2ZXJyVkV6MFFxTUhFS2ZUaFU5YWpCSkF2Wmp0S2xidXhwZlhXZGxq?=
 =?utf-8?B?Y08zdFhzVHFHSFFaeTEreXZyR2xKQVU5YjMwR2VNY0NwbSt2clRlQ2dhTzVW?=
 =?utf-8?B?eHgzcngxZXQ1YWZrdWczK05hSDBhcTQyRlBnNmJFV0tSN2MvSzlEYnE0Y1M0?=
 =?utf-8?B?cVhRZWNKb2JTYnJ4SmQ5ZncrZzZOUi9qeVoxTXgxMDZ6VitmUTNZMmgrN0l1?=
 =?utf-8?B?VDFzRDhUdEhQc3liTXg3bkhJaWFUZHoxWEthckZZL0kvTDFMcXpzeGh5dHN2?=
 =?utf-8?B?YjNqZGVkVXpLYkppZTJlZ0V2ODVaMEdRMnY4RkdqaFpOK0hPNXFEaHFzcnVn?=
 =?utf-8?B?RHAwRWNQZlpJd0wwcGZmNUVDMGxqRlRtV3Z0bWVEaGpXQlJid1U5SlN5Q0Nz?=
 =?utf-8?B?RkhrWWxjMm1aSURPWEt3SkhYQU42ajNzWXFnZHlNRnBWSmZoaXpnV203NWpk?=
 =?utf-8?B?U01qcUo4K21TT1JDZDl3ZkpSZXBuRXU1OFVDTzNLUnNFQ2N4RENXODg1cGRH?=
 =?utf-8?B?dUhrbWpRektuWG1obHJtSk5EVmc0ZmEra2pFZjFUR2MwWFFJVGZmRE9MbVg2?=
 =?utf-8?B?T0tveVU2QmJCb0tyTnVTRFBSamlxNy9mcENFbmlSdmRrMFZZTEpFRFdwME0z?=
 =?utf-8?B?ang0RlpzYzd6YksvckVDdGVEbU95Q1NkR29OQVlQMlhLRjBtNTEzbHJlcU9K?=
 =?utf-8?B?SU5Sbm9pT2VVWkdzWTl0Q21STXc0dXpUaDRZNTdOWTBRcWVMb09NcXQ2N1Iw?=
 =?utf-8?B?S0dGQ0N0bG16U0tGV241K2xrcjBmR0xseFc0YlA2U1Y1dk82cFpKbE4vZkxm?=
 =?utf-8?B?MHdxQTREZFVSTEhGZzdvU2VCZlROZmVyME84S1lTblJqWlQxQ2JYd3ptTHlt?=
 =?utf-8?B?cjB2T0xXbmVKbU1Qby9seVdoYjM2QVBoc2l6TGxNRzdZTStuaW1iL2VRNzMz?=
 =?utf-8?B?c0lhcS94Rm1KVjZUVzlKd1RuTmlnTGNIVnJ2dHpYSmY4TURxb09RbVpENnpR?=
 =?utf-8?B?RStIalhwQXYzMEpkU2ptWVRHOVVPclA4SVNvSW9KNU9FZTZ4QlJQOGZ3UVd1?=
 =?utf-8?B?RFlnb3pOKzd4L0hDMEVJeHNvSTZuUGdjRlk1MDVjVVAyZVJyUkljeE1pdk9G?=
 =?utf-8?B?bUZhU2k2Wmg3SUlUZWpBQ1FVS1o3L050bTFFVVhUblhBVm0wWmQyUzZ1c2gv?=
 =?utf-8?B?Rk12ZEJzeWxhWHNWZ1dvSDhJTWozS013Q3J0ZDB1dkszeDVVbk1Ob2YraUNk?=
 =?utf-8?B?ZEREUnZ0T1VDdzhaVFQ5OU50OHYrY0FRY0JIZG5sSmMvdnpPSCtPUDZjclo1?=
 =?utf-8?B?N2lDNHpUL3FvNHdVS2orN3ovN04rUVVVc1RFemxhb3dCUUJZcjRNNkI1LzlK?=
 =?utf-8?B?WkdEWmtyTTV1M1pXYlFhcHl2SFFsRjlCT25WMkpGK1NXTXNTUWVNMUs0L3h3?=
 =?utf-8?B?bW5vejBFYzRRZFZXU3BlV0R4ZWJuM042M0Z4eVNIOGNrUkhqVlIrVCtiYVAx?=
 =?utf-8?B?eFlZNjVUZkprNCszNEVXL1p6bW1WMzlMUXFLOFg0SldwdEVCRTRZbDRmTkVt?=
 =?utf-8?B?UStlWUtwcXFvU3hsV0NNUjVFOE9BZUlQRnNqRkdQZldyNVRhYndhbHNtSTN6?=
 =?utf-8?B?ang3R2dKYk4wV2VZRStFVUl0OU9ZY09EVGxaTnFGeVYzb3ZlTkdRRXc0eWFi?=
 =?utf-8?B?RkdjeUpGbUtPQXpKUWJhRnh1R3NGMEN6KzdzU20wTUJ4YnM2S3lucVFQQmo2?=
 =?utf-8?B?c0xUUUFiczgxdkliSmpScUdWWTllQU9xYnhGajdMK1FBMEFZWXVmby9CUW1U?=
 =?utf-8?B?T1hycTBxbGdPNkkxVzAxaUl4OE5kZndORHV5SUVXcnUxVVNaaS9YQmNYRk9o?=
 =?utf-8?B?SllKMTlLTXp3bnUyZXBoWHZsU0xqeGFZQXNKR0NhSjc3WlFJSjYrYWgrNzR2?=
 =?utf-8?B?RHY0MXU0QXVPUzRpM24waXBwVjdYSXhoTkVkdzI0YUZHbm1FSWNEVUZlWWJy?=
 =?utf-8?B?c0lNZ2d3SmpvakozS2lDU1VrdjFBbzNVU1lFSllvQnFTUElLRzdnSWJpVGFN?=
 =?utf-8?B?V2dNclRwMHM5OUE5ZkwvVGZQWVREU0E2R2RHOGxnMzhqYVg5d1JZbXlFSUVK?=
 =?utf-8?B?U0JJOEM5WTM5UXdhSlZTemRQeE9LcFNPQ1dJaEY3YkZiYTFiMGFBd0dDV0oz?=
 =?utf-8?B?MEZjSjNkSndTQTVmVHhIRVJJYm0yN2xFUjZPaGZuaW9JcEdyNCtYSktDSGx6?=
 =?utf-8?B?NHo3cWttZ3hjc2hQRkU5aTcrRmxzZURKYUl5MDJ5Q0o1aFJOMHRtQzJ0MGFD?=
 =?utf-8?B?cmVYeW9NenQrTTBsY2NrbW5FTm9NaTZLUzRXbHJMOWVycXRVVDdRZz09?=
X-Exchange-RoutingPolicyChecked: CgTxQS9theN/Vfu2tfYcLUJtbBI/M2r/uQwgsH5ebVoel70E3PuTl7HKyvB3sMCNaYXuGH07mSugHP5mhKs4GxJKlL+Zs3+CksHE+GG6NNY6frabqHRA1QmzPea4WyZ5Lzxvy0Jwsz0hJ5/lNMmlJCEYZevgEF06S+2NkhN8/CUN6gI7gM/+i1RbMmkideBiWzR216E8WP2njO//+TDgv1+iXGPj+NX7s+dojWq/2qbb+3qSnrsLC5QUIMh4SIS2Q9Bftax983l22rzXw1FT5iuN4LRsmeg4RBgL6I3kPdKQEHqgqVy77a9D49FV1dNM9hnjfmRY/jmCpnAtSmbysQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: dac5564d-4327-4f55-57f4-08ded1d1eebb
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5653.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2026 09:21:11.8095 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2TmKn++5jFJugA/42hDDjF+ysLm97nJfrT2ZNk8HuPd/upULEH4GapmYig0nfIWVUVpoaNVazK/2pycMbnDg3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7687
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


On 23-Jun-26 4:41 PM, Bruce Richardson wrote:
> Replace strncpy and other unbounded string functions, e.g. strcpy,
> strcat, with the safer alternatives strlcpy and strlcat, so that we can
> guarantee null termination of strings.
>
> Fixes: 4bbf8e30aa5e ("examples/ip_pipeline: add CLI interface")
> Fixes: 5f657a7fbe86 ("examples/pipeline: add message passing mechanism")
> Fixes: 83f58a7b7b0a ("examples/pipeline: add commands for direct registers")
> Fixes: 0d547ed03717 ("examples/ipsec-secgw: support configuration file")
> Fixes: 63e8c07c7245 ("examples/ipsec-secgw: fix configuration parsing")
> Fixes: 41e97c2ea9e6 ("examples/l2fwd-crypto: extend crypto information")
> Fixes: e8ae9b662506 ("examples/vm_power: channel manager and monitor in host")
> Cc: stable@dpdk.org
>
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> ---

Acked-by: Radu Nicolau <radu.nicolau@intel.com>


