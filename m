Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72D3AE6E807
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Feb 2026 11:21:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 93E0E40281;
	Tue,  3 Feb 2026 12:21:21 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTP id 294A8400EF
 for <dev@dpdk.org>; Tue,  3 Feb 2026 12:21:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770117680; x=1801653680;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=XswKSVpv+w2lpsYLxh78QffXEtkv63smOvywXrFSzjI=;
 b=b2FwJ3lYxAeIBC9ELCRRD/sAivrOHubJleDkSSq2KKfZb+97S1vQtjtx
 aUozokz7Kt4pBg49uRL9plvpRo1rgZf6iiZqOoBso2R7+W60wYoDvHcSb
 kJ4V3ouHDpFYhMGEb8U+oqUPfAxObPkTB47muPKCm/CT8ztL5sW26HGyu
 hVplLMcLF7icFSoG+3P4UUe2hJk6IOQGAQFLAZwpbNxqMPoiEJIirHo8z
 Dgbt69Ajtw06heJ9i9qKAZdTo+d+GK+yGVfG2joLv5gdAR5UN0BgfqB7n
 5pyBPNGvFwvhoh9BhUUXlwZbVjoD32p/HdOrruqTcOWh+i9bjAjlTNDbt Q==;
X-CSE-ConnectionGUID: m8ZjpEBpQSqJ9lX+3yauag==
X-CSE-MsgGUID: STF9rpZNS1+27eEaKiP4fQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11690"; a="71340239"
X-IronPort-AV: E=Sophos;i="6.21,270,1763452800"; d="scan'208";a="71340239"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Feb 2026 03:21:19 -0800
X-CSE-ConnectionGUID: Y2vi9DiNT2K06TFB/p+Iow==
X-CSE-MsgGUID: zJtTIbVrRfq5gX+htfDnDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,270,1763452800"; d="scan'208";a="214588358"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Feb 2026 03:21:19 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 3 Feb 2026 03:21:18 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Tue, 3 Feb 2026 03:21:18 -0800
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.60)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 3 Feb 2026 03:21:18 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wWFQM7jjGTrTSDBRCO9SMQfTUdxlQjog3diRMeUcIhwJTc2M9Cx3K0Ur0XVef0o832GJb5PX3/V0VlV+vf3Fxy0k8eyB7kaJjj2HrjM6sfgI76IVUenmeS0gXCktmkZQN5GCQeKL1Hmpp4rh05DSDL5IvCfSDS2lmruP32KZCzMrZxo/4AJnuLYCeSph0C0mgKByXK922YTn1x0MGPPDQPcQ4knCnd8sYu9034CYtG2F8z6W80AULOAc95VgoCwnKbEE2Ida/Kj9NMxiWfdZAEoJ3NZ30tFYHgC2yjRhP6cZHy1Y5OeVE5KZmSXTRa/0L9iMzRIJPZFPEKNFa4A6lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0BZRngbPzTwtFn/N2WbRZuc8G2dhHZakmKwxc1ysP1E=;
 b=l+ycS/U3NPa6p9uHGPSte4apQ1ylmC1xHmPKmixejWlP1XC5ZqzJQFynwssgOyljc35Z1tLplKalqS0mQU0r7vB0Nq8qPx9dfU7fEmXvETEGIHGNUO3K23J9zEsTi7CQqlUEh5LTTBYYqfLH97yY0zHWlmb5ZfZ8t5dpsKNGZ1XwAbslDQqBW9j+NixwRCr23SgJGGeSlnSexohoY0z4zQRHKKy3msoZGNqCAeXzEmnxTueKCkamSxqJq3eEfreYJjRw9BVjezTgfhVL00NcTTN1rwR/QVGrEDyyLZbV2wjhZ1Ijyys3Mdg9JyToy9OaIHjb1xYHfMvNDFhe6d7p0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM8PR11MB5653.namprd11.prod.outlook.com (2603:10b6:8:25::8) by
 PH7PR11MB7002.namprd11.prod.outlook.com (2603:10b6:510:209::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 11:21:15 +0000
Received: from DM8PR11MB5653.namprd11.prod.outlook.com
 ([fe80::74e3:c0eb:29ee:fffa]) by DM8PR11MB5653.namprd11.prod.outlook.com
 ([fe80::74e3:c0eb:29ee:fffa%5]) with mapi id 15.20.9564.016; Tue, 3 Feb 2026
 11:21:15 +0000
Message-ID: <24de76ab-f274-4f6f-8910-fd0899ae427e@intel.com>
Date: Tue, 3 Feb 2026 11:21:11 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [EXTERNAL] [PATCH v7 2/2] test/crypto: add tests for 256-NxA4/5/6
 algorithms
To: Nithinsen Kaithakadan <nkaithakadan@marvell.com>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: "kai.ji@intel.com" <kai.ji@intel.com>, Anoob Joseph <anoobj@marvell.com>, 
 "stephen@networkplumber.org" <stephen@networkplumber.org>, Akhil Goyal
 <gakhil@marvell.com>, Fan Zhang <fanzhang.oss@gmail.com>
References: <20260107105649.1708347-1-radu.nicolau@intel.com>
 <20260129120001.73511-1-radu.nicolau@intel.com>
 <20260129120001.73511-2-radu.nicolau@intel.com>
 <PH3PPF1E92D74AAA2929CD056723554B9B2C99FA@PH3PPF1E92D74AA.namprd18.prod.outlook.com>
Content-Language: en-US
From: Radu Nicolau <radu.nicolau@intel.com>
In-Reply-To: <PH3PPF1E92D74AAA2929CD056723554B9B2C99FA@PH3PPF1E92D74AA.namprd18.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU7P250CA0018.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:10:54f::31) To DM8PR11MB5653.namprd11.prod.outlook.com
 (2603:10b6:8:25::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR11MB5653:EE_|PH7PR11MB7002:EE_
X-MS-Office365-Filtering-Correlation-Id: c740fea1-6e9d-4ed8-a083-08de631657dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UmhvQmhweUZxZVRtcFEvK09PclZsYzVHY3REb1dzNEFhdHN6UzBGQm94YTRG?=
 =?utf-8?B?Z1lnRzFrNmRiVlo5R09rUkVlYWxaT2EwMURJVllSQU9xVTUzVXUxODh4YlZt?=
 =?utf-8?B?cy9MRElZN1p6UC9vbVkvWHY0ZVVhU3JhQUxYOWM1QzRKaGt6SnROamowVk1h?=
 =?utf-8?B?ZmQrZ0g2WHNsajErUVBqME1IRytQL0RvQXR1TXhLTk1LRDdjQ1h4S21FVjRw?=
 =?utf-8?B?Q2JDREpSME5GNE0xWlBubnFIM0NXMzhXa3h2OEFtRVY4MjluVk5samNDSWMw?=
 =?utf-8?B?bVQ4aU5aSGpVeTdhem9qMVBMR2paczNkb0RBYy9SK0ZzRDE0eXVRRjZnR1FX?=
 =?utf-8?B?TzdlbWtuMGVGdjJSWjhMOUpQTzhWRkIxcm9EYnZzcldXZ0YvQmN1b2dSa1FM?=
 =?utf-8?B?MTFnNEo3R0QwTHdjaEpUY2EwVHkxL0tPenhtZzBkMUR2blU3MWovMG8xdndx?=
 =?utf-8?B?bVVIbFo2N09lQjBUQU5DUnF3ak9meDdBZ2lsbnkxWGdUZXQyanFxOGYvUVN4?=
 =?utf-8?B?ZzRzdU9GbXZlNWpSQWd4ODNpTmdIREZGZHJBWkFKS0FwNk5sK2lYTVpzZ3BB?=
 =?utf-8?B?ZjZ5ZHdMWjlCQUVqQUVPcWhoNzM0aG5sVHZqZTk1ZUJVNnRyaFVrZnZPUnVi?=
 =?utf-8?B?a2ErTWpWVm8rR1lHaFRoVldFK0RoRHFjdi9GZytZWjEvQklaUEZkUDhlVVFF?=
 =?utf-8?B?OXNLTSszY0YzTElQWnRMRklxSExFdHlLem9uZm9DTkRYNlMxSTN6cklid3pi?=
 =?utf-8?B?VWhzOUZxN3gwZnBxQnltQ1ljN2F3K3JSSzhHbXNCMGxLbDU0SkV1K0NlN2Uz?=
 =?utf-8?B?bzZON05kRkRKdkY3QUswcng2Vzg3WWxxWDRJWHJjL3g2TXRFWXdJSHFPb0FB?=
 =?utf-8?B?c3RpbWd4SHBPZFV2TWR0Q04reXluY3FJbE1sZ2tSS1ZadXJ1NCswaXQ2cUZZ?=
 =?utf-8?B?QXorV0dIRHRFc2dIUXlxenZLNXowa2RQanBvVmdQTWdxSzF6eDAvZjRQbjYr?=
 =?utf-8?B?UXJoTUkwb1VERnIyaXVieWFaQVgvTVJSNUUxZENpTkNmMG9PTGFkemdFTGtY?=
 =?utf-8?B?WnhGYkw2K1FNMmo0RlEwTjIyb2dpYWhJZk1ORlB0U3U2Kzg3WUdSS2pMaVNQ?=
 =?utf-8?B?TDRrREVLOTZZTDJBT2hOd0NZOVQya0ZmUHF2Q1dBalcvVldKQ0c1NlRSbHll?=
 =?utf-8?B?ZjhTaFpzc0NXYmhMaU9ScUJiNGZtR1pSeXVGay8yTGdzeFhkVTJYSm9Xazln?=
 =?utf-8?B?bGJ5SlVHVGJBRGppVjNqVGlNYnFBNVYwT2o2QmdqZ2xNeERiY3ZOYzgxay8w?=
 =?utf-8?B?cnpwL2N3b3VnS3g4amJtTTNTV0NHSG9VaHZwS0lPbzQwbktzRWI1a0ltWG5G?=
 =?utf-8?B?WnkxcjhVQmQzMUEvTmNkVHFobGJsV2lOU2h6TWtjZW96RXZWQU1NNWNUam5T?=
 =?utf-8?B?Z3BpVCtYbU9MeEZxT2ZsejZiSGhNekdUemJORGNHZFQ1aFBldnlybDB3c1BF?=
 =?utf-8?B?STdBZVJCUmNxckhJMEJpN0ZmZG1NSG5DQnlmcm9rV2h3NTRxWk1xS3hzUFpQ?=
 =?utf-8?B?c3FmL3lzbUZUUWR6OTFBV3MvM1ZjZnQ3c3RuNXVVajVSeDZSa3BabUFMSXBx?=
 =?utf-8?B?RVFGZEpBYXd5eWk4V0JqNlo4QWtxdjJybm9VNUdFWWF0SXFyeHlzQm00WGwr?=
 =?utf-8?B?NmR5dFZpZjlHYitqZTZTakFCS013ZDN6RVlFTlJDbjhub01xbnE5bi9zb01F?=
 =?utf-8?B?V2lmRkpMRUNMYnE3aUQ4QTVlbzJqamltTWU3ZUoycG9mWEZkY0d3YkxIUklE?=
 =?utf-8?B?bXVpZzJxVW5Scm5uUFd3RWhOV2VnQnpiSUJ1NTJHWG1OTldnUm9nSGp5d21H?=
 =?utf-8?B?YWp4UkRKMGZSYjVEVGhpbjNrQnN5UHUvQTdGQkhpeDEydkhRMVFlelNJK3gz?=
 =?utf-8?B?TGxwWUkvWTM4T0RzRUhtZlF1N0F6STNxKzlSckJ0N3o4WW5VaEhTMmZnclJL?=
 =?utf-8?B?UXQ4YWlkQnUzL05RK2pzcGFGVWRRWk01RTJENk9GS2crcTI2SDNJY2NiamVz?=
 =?utf-8?B?SjRzSFpCbHVWNEw5aG1CVWZrZ29RcEVoSXNZMEVvZ1ZiTjN1bGVlc3lDQ3Z1?=
 =?utf-8?Q?MDoc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR11MB5653.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SkszaVJJb0x1ZlBlRmpFNkZ4OW5VNnJsR2laa0NjeWlhQVF2T3Q3dUN0RG50?=
 =?utf-8?B?K0VYYWM5UGE2SmpFSXAzblRwQWIvdjNrcnVhRys3U2FoWHJubmduWUZWK2F5?=
 =?utf-8?B?YmEzSCtxZ1UvZ2hPNmhUWlYrWXhNN2tieVR5WWFFMUhkNUhuOUxKSWNOalRw?=
 =?utf-8?B?bWJwbjZTVDRJNjF6bTZqS2MyZzNnUmNZeDBqVEZYVTE2WHVBdkVLOGp3MElK?=
 =?utf-8?B?SnpNb01OREdFN28rV2UxNmtieVdPaTdVYVVlL1NtR0l6anBFTzludEI3SkV3?=
 =?utf-8?B?S29HYjdJUG9sMEJFQ1hsNlhUYURleXNXUW9obW0yOWpCSnk4OVFWekloWXlW?=
 =?utf-8?B?WHkwT1NwZlhWSkxuVUpsZjFhbmR1K1BrOExoOWlKZkk2Q0F1VTJvcU5kU2pz?=
 =?utf-8?B?UElHUXRncUVJQmRHd21PZ2F5YktJNzUvL3cyc1pjZUlqM3FmYllOVHRzYUxC?=
 =?utf-8?B?cDNwTVVYS1QreXQ5YU9FazVCSGlwTlRaNzYyR3JKNk9VekdTb0o1QUtEcTBF?=
 =?utf-8?B?WTdROGVaVVQzVE1RMEYzWXZST0xGdVdFZHRNQU56dTFralJBUGt5UmtIeURk?=
 =?utf-8?B?SlhnMXBDZ08yalVXK0FJYXJNQ1lMVVhaUXJ1T3RCUGFEdTMxQnB5Mm9CWE5a?=
 =?utf-8?B?NzNRcTdaeGJhQXJpWHhma2RrU1NDOTJ0QzlsL25TbUJwMklxVldJR3BFZE9G?=
 =?utf-8?B?VHcraEhBVFlrV091R3h2TURKOTJLUGV6U2VKc25Dc3J5U2NVVDQ1SnZHVTRq?=
 =?utf-8?B?YzM4blZxVlh1Sy9tVlhMZzFCSXdmZ3FEaStmbmU4ZldJd20xSEJadEgwSWk3?=
 =?utf-8?B?eU0xWG9MN3k1MFhqOVRicjBKWVpvV3lOd3E5NVlJb2tTaEk5bkdjNTNTU3R5?=
 =?utf-8?B?NkdSWXpndjZ1ckNrM1U2YmU5S3V5Y0VDM1B4bkZhcHRIN3RhUmhoSGRqemRp?=
 =?utf-8?B?SmRUVFBoN3JVMWY1NS9Ja2lZL2R6dENVTUJpSVhKSXNqSVh4SlQ1WlQ3T1Zy?=
 =?utf-8?B?WnZUVlpWdWhOUlBFZ09UT2xUVjcxM1ZIbzl4RUMyVVJmZVpLNVA2Ris2cTJi?=
 =?utf-8?B?MWxZNDJXTGh3SW5hajZRZEx2cjVZUnpTcVlycWNOVHEzblc4SDMybXZzc2lZ?=
 =?utf-8?B?NUZwRDY1ZmRMbWFYSy9hdzR4TjltZXlxdUVRTG80NW1WRURaSHBCVGV3cXZI?=
 =?utf-8?B?YUJzanRVQnl2UU5XYlIyMG9tMHdSVUFlZFlZT2tsQ1YzVW1RbElscUhRd1Jn?=
 =?utf-8?B?QWFrZHBmK0w2MVpwbDRxQzJnUDNKeFBVS0hyUDlzZXRuUWYzRWFQekdJQ1Vu?=
 =?utf-8?B?ZVFmeVd5MWdvUFVLQk1laEg4YmxxNGFMZUthNHkyTmQ1REdWYlZ0OWwxOUFk?=
 =?utf-8?B?QkFJTDl4M215V0trL2IvOUlSdWZLZVkyYjh2TmlLRkFTdjg1TnQycjJqczFa?=
 =?utf-8?B?T1QzSmh5ajJrQlREZmFMTDF1bnFIS3ZSeS9UZytobnpYVEt5SUZTWUF6MmVs?=
 =?utf-8?B?aFdkMjJ4NUx2TklyamVuNnVZOUlGMnpuQlZLcXpEMEZJSUp1QkJPT1RNR20w?=
 =?utf-8?B?engwTlVXdVZ4eGtmZTBMdnMwaHNRWG4zRFB2UHJqRTdlMzM4RnloTmlnanF5?=
 =?utf-8?B?RkZRVDZVTlFpU0dpS20wLy9QcGRpaHpvQVFjaGpzOWRNN0swQXFVSTEzSTBj?=
 =?utf-8?B?TWRHanVFYzYzUmkrWjE2Q0FGRjhRK2UrL2xUOVpqaTB1NVhLQ3daa0RoTThn?=
 =?utf-8?B?L2hJNXpXejh6bTNqWVdyTU9nTzU3WXZ1dEtyTU1aZXlCZ1F6M3d4L01ZZ2kv?=
 =?utf-8?B?cnFPc1F6NG44WisyNkxhOTlWTUkvVWNiQlhJc2Z2djlUUFlhdDVvUGUvcHo4?=
 =?utf-8?B?V2YzK3NpYm1PaVZHWWlweWo3WWxEdFhYU0tHTEtxK3kyK2UydThYVk1sTVJD?=
 =?utf-8?B?dTk2UWtaanFlcVQxKy9sa3ViR1lSMk1scDJSN1NqcUlTaHdIWkpYWFJ1VU1a?=
 =?utf-8?B?NGlyUmEwMC9Uc2J2ckVxK1YzVFlCTk1wR1R0eHI4QUJOM1pCeExxVU1qL2Zw?=
 =?utf-8?B?V1RBQXNrdk0xOXNDUW1hUjhyLzV4a0RZYkw4bWlrZ1AzMXRaS1kyOTRjaTNp?=
 =?utf-8?B?YS90ZHgvMEtEQVluTFlRQUdwWE16SnEyaTBVMDBIbUhSQmJKNk80Z1RQTkxO?=
 =?utf-8?B?dFdSTXNLSEFtcU9Gc0NtVlpCTHM3TmJZVXZKQU5lTm1CMUxrdzZqRENvUll1?=
 =?utf-8?B?RHN6bkJyYmsrRnNNLzJqWmZMRFIzaHNiTDlCMTZDR2t4eS9QaFgvbk1XTmt2?=
 =?utf-8?B?TThLa2ZPZGFwV1RBTWFQVGVLWWVoTk1KZ1RsK3JFSUZackFpUXdZZz09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c740fea1-6e9d-4ed8-a083-08de631657dc
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5653.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 11:21:15.2940 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w6SrAD+VQbruxeFOICIcz7XVW803IlFfdIQEIkhwt9Hdz8V2rPKjxuXES3YyUmAc57JqjbfPyihmD7jWjmTSLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7002
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

Hi Nithinsen,

Updated as requested, can you please review and ack it?

On 30-Jan-26 11:12 AM, Nithinsen Kaithakadan wrote:
> Hi Radu,
>
> Just a minor comment. Otherwise the changes looks good.
>
> Regards,
> Nithin Sen
>
>> +		return TEST_SKIPPED;
>> +	}
>> +
>> +	return 0;
>> +}
> [Nithinsen] Here functions are not separated by line space. Same applicable between nea_testsuite_setup, nia_testsuite_setup, nca_testsuite_setup
>
>> +static int
>> +nea_testsuite_setup(void)
>> +{
>> +	return nxan_testsuite_setup(RTE_CRYPTO_SYM_XFORM_CIPHER);
>> +}
>> +static int
>> +nia_testsuite_setup(void)
>> +{
>> +	return nxan_testsuite_setup(RTE_CRYPTO_SYM_XFORM_AUTH);
>> +}
>> +static int
>> +nca_testsuite_setup(void)
>> +{
>> +	return nxan_testsuite_setup(RTE_CRYPTO_SYM_XFORM_AEAD);
>> +}
>> +
>> +static int
>> +test_NEA_helper(
>> +	const struct nxa_256_test_data *tdata,
>> +	enum rte_crypto_cipher_operation op)
