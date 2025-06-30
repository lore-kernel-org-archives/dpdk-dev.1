Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6704EC83029
	for <dpdk-dev@archiver.kernel.org>; Mon, 30 Jun 2025 13:32:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9817940656;
	Mon, 30 Jun 2025 15:32:02 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by mails.dpdk.org (Postfix) with ESMTP id 7486F40291
 for <dev@dpdk.org>; Mon, 30 Jun 2025 15:32:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1751290320; x=1782826320;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=nhE/G7FlMZNAaVU8+s4wBgzRTyfe/kRkQvA3Gdspilo=;
 b=bzbNHPwIbRXI8bmF1SDtXOwnnubNna0vspt4EDE+MmwmOVoMVlqm6D1l
 pshT8QEBD4IfBjPt6expmM7M+/yj7gvjggCq8NZcwDSEKw5GiKUSHOV5/
 oRJ0a6l/z3E6Vaz0EjE72jW0Jf/I9o3G+xl+FrxeLSwCpY5aB2Vcz2R7N
 uHlB1UZHkk0p9pocTLAF4WefXRK5MtYgVSEG8zD/XNbobLkdmruGgCY5s
 4TYGyuLCdFdGMneHNP01EpSDo5dAVsAz8y8jYNKbPrLElteFSxMN5MRap
 a46ElCYuVLvB0xcxCu0dpju9mHSSkV/O8mz6pMjSSxY2jk2ZXHyQVq7Mn g==;
X-CSE-ConnectionGUID: J59E6UB1RDSejXONfjrJaw==
X-CSE-MsgGUID: EgbHG15JQYm0wqTXmEV/iQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11480"; a="57321849"
X-IronPort-AV: E=Sophos;i="6.16,277,1744095600"; d="scan'208";a="57321849"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jun 2025 06:31:59 -0700
X-CSE-ConnectionGUID: FNLw1Ku1Qf2ffuD4D/KnzQ==
X-CSE-MsgGUID: AOOkp60HTHqIATKnx8nxXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,277,1744095600"; d="scan'208";a="177126955"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jun 2025 06:31:59 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 30 Jun 2025 06:31:58 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Mon, 30 Jun 2025 06:31:58 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (40.107.93.89) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 30 Jun 2025 06:31:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dxn3kFr/EMD5lwnATj1L1TRLmcxiIxvWmB13nrRPS6hE0DzOauAO8GuxAy594KchV0eB7tDBuqYOGFs8L9Ei5yDo6JntrHv5AWH1HMveqy3IUweeAzfuWVxPwz9nQIcK4D9MEKSiNHLJLMQUDXJggiMNX9JKFF4TzR0OI3AhOFVlOXH9By+qn+07/V4XWdWSFrxoU/UlpO6Llw0jKXPORl2b5qXCDEZIT0JMMoa+AnV7Kmd5d4U0NvhXttQ88Vb1BzVioH8ds+QTbxFZ5AGeRPMqR/NN8savspnokjCY+t9UPixQ284Pe7JmO9SdFmEHhKyMB/zVOY0z4ymea1+1YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Xt9UYBXVsoLxvMV9PZAr8Tw5H3DVChUV/oEK5oUtpA=;
 b=IktqhNiUkI3WtCYP8sKCRSXJxYRFhLNEea+pP4XvvDDYrSNsgKi/v3rkBCwY5lnMRpoZzXaTm6ct5e0oIIbgbYvVtYgOCgp4js9IWNlfMhxq37WGqruAprq5+BJfk+3eDSLrJbxviKIsvx/EhkPe29xHQaEK206D9TyoIpI4tgbGzeH9UQaolaIemANJfO8i/5MBZPJYwUk1T4oF37qAJu1pZpN3skiyXwsTC6Awz1vcwOv//6k+oVbC3foKIvscAFU8pktqDNcx+t/23WY/tCSxGrq95tg1gS0+A4AETmOgZ13k5+1khMiERgYNg6beATRPrs22cEjr4c+bX3BEeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SJ5PPF8A49C4DF4.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::83f) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.25; Mon, 30 Jun
 2025 13:31:56 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.8880.027; Mon, 30 Jun 2025
 13:31:55 +0000
Date: Mon, 30 Jun 2025 14:31:48 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: David Marchand <david.marchand@redhat.com>
CC: <dev@dpdk.org>, Nicolas Chautru <nicolas.chautru@intel.com>, Anoob Joseph
 <anoobj@marvell.com>, Pravin Pathak <pravin.pathak@intel.com>,
 "Ashwin Sekhar
 T K" <asekhar@marvell.com>, Pavan Nikhilesh <pbhagavatula@marvell.com>,
 "Nithin Dabilpuram" <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>, Praveen Shetty
 <praveen.shetty@intel.com>, Hemant Agrawal <hemant.agrawal@nxp.com>, "Sachin
 Saxena" <sachin.saxena@nxp.com>, Gaetan Rivet <grive@u256.net>, "Anatoly
 Burakov" <anatoly.burakov@intel.com>, Cristian Dumitrescu
 <cristian.dumitrescu@intel.com>, Harry van Haaren
 <harry.van.haaren@intel.com>, Radu Nicolau <radu.nicolau@intel.com>, "Akhil
 Goyal" <gakhil@marvell.com>, Jingjing Wu <jingjing.wu@intel.com>, "Maxime
 Coquelin" <maxime.coquelin@redhat.com>, Chenbo Xia <chenbox@nvidia.com>, "Kai
 Ji" <kai.ji@intel.com>, Rakesh Kudurumalla <rkudurumalla@marvell.com>, "Jerin
 Jacob" <jerinj@marvell.com>, Srikanth Yalavarthi <syalavarthi@marvell.com>
Subject: Re: [PATCH 2/2] doc: use core lists rather than masks in guides
Message-ID: <aGKRxCS4QqMfHdzt@bricha3-mobl1.ger.corp.intel.com>
References: <20250624133409.550372-1-bruce.richardson@intel.com>
 <20250624133409.550372-3-bruce.richardson@intel.com>
 <CAJFAV8xFCZeU_dA7Q8KqjzWPU2O1+vgRqkhw0y4PVZG_=krb-w@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJFAV8xFCZeU_dA7Q8KqjzWPU2O1+vgRqkhw0y4PVZG_=krb-w@mail.gmail.com>
X-ClientProxiedBy: DUZPR01CA0281.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b9::9) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SJ5PPF8A49C4DF4:EE_
X-MS-Office365-Filtering-Correlation-Id: 4bcf8361-a344-4114-f87c-08ddb7da7b31
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RFFvQmF0VG5Kdm9tN3YrcW5yNHV4V2IrU2R6YTN0TDlwYzFwS1BZMVlOYi8x?=
 =?utf-8?B?aTM1Tm1CQ2tDL01DTlhQUDFvWlNObzl6V1hzcEF5aGxjeDZTMWlkT3BodWVo?=
 =?utf-8?B?OHhqYjFTcXFwUE10cml6RkRDUTIwTUFJM2lnazJqNXBIenVFQmIvQkZVbFhF?=
 =?utf-8?B?RWRKQkJlaGVrcXdFWjlxQ1FCU2ljVXFkTFMzdHBYZGRBUFR2aGRKVjR1eGY2?=
 =?utf-8?B?dUF0K1BXQkxlazVJQ1dlZWdGbzJsVGNEM0h2QVY3cXRWNktqUFNaUTluOG1w?=
 =?utf-8?B?RWk3T2hFc1BwWExnQ0RYZ1JBL0tsdGw5RXM2RmNPRkhpcVRQTHpNaFZPbW05?=
 =?utf-8?B?K29rQzk2VW03VzJicGtkNERzdFdRMk9rYVE0NHFWZ1MySlg3dE5ReWhuUmY2?=
 =?utf-8?B?a29hbWM1Qi9OOVBsTldkcXltQWh1UjhtY2g2bjVGSHlkbTR3SXliUXVMcCtn?=
 =?utf-8?B?V2NFeERNWGZFYi9MUjNqbWlFRFFHa3VneUM5MjRGNEVkSk1mbFg1Qitydk5F?=
 =?utf-8?B?VWpabUFoT2xXb1NkTTd1MHhmZVFsRldQK1ptYmtLSjV5cFF0dFI4SElJT1hy?=
 =?utf-8?B?bVZ3K2ZrdCtCUXhUQVNYWTdnMFVTMm1JRUlrVmZzSWxFNEJNN01hcVU0bHlC?=
 =?utf-8?B?Nk1MZEtJbnpZZnpVSkJnTTBoTWtLYUxoL2s1cy9Ldm82SXp0bmgxNXVTZlJ0?=
 =?utf-8?B?TUVaLzdQZUp3ZDVZclpmZlA4aXhqMkd4a2JjZEMra0VHTnVkR2VSbGFiNENV?=
 =?utf-8?B?eXJrSEkzRkpSQkFMZm5tZEVIbFoyZ1duMmpHWGJSYUJPbStXMEFCQXE4YUpQ?=
 =?utf-8?B?UkJ5WFFwTkYxbmNQVGNJSnc5by9McmF2a2VoVnRYSmRjenE5Z0JOREVKVU0v?=
 =?utf-8?B?NEpSbzR5cnNwdmsvMmxNQVM4bDR5U2dnd2FkWGc1Q3VUSU43UXI0RUtQaVZN?=
 =?utf-8?B?QTJBbzc0S0N1ZXVoeFdLcjFCRUVpUG1FZ0sranV3dDdJVDNIaFI0QkwySEVD?=
 =?utf-8?B?VmZCcWozMVpMSFIydDRZdmJncXhpWXNTMVRQTDJrRU0ydzlHeVlLVXhvNmtM?=
 =?utf-8?B?OEhkNVB2S3llVk1EcU5DUkRjZmF5QWZVV2dZT3VjREI4dGRhdXFHTWZubUli?=
 =?utf-8?B?TXdOSFVCdlMwcnFpcmFyYmxMQkRoZTViRWVXdzVteEtucnY3cDBXMnJzN0I0?=
 =?utf-8?B?UW8vc0dMVzBFRDFKMTM0VmhJNzU4QnpqNVQ4allCdDIwdTMvMW1OYUMxd2Vk?=
 =?utf-8?B?WUR1OFhzWElvUXQ3U2VxZDFoY3JPeGJnMHVVNzY0NllIQXJxWjkwbmVibVow?=
 =?utf-8?B?VHhKdkp5RmkwdHZoaFIzTHlaWnNEb1Z2amFiVVFuVnluYkgyeFUzeFZBTm1k?=
 =?utf-8?B?bUZtVUJJVGREQU40Q3V2cXNaU2hDODdFVi9nbmdUeWJYOHU5Z0dSRUlSaElU?=
 =?utf-8?B?dkhOY2VaZ3UzMC9hWW53cmU5K1F5c2Q1N2V1QUlscHZvaHJmZGRaRGJlTkd3?=
 =?utf-8?B?S0o5aGdwaU5Gc09rRkpaUUgyYWduMlNHSGdaTEtmTmhUZEQxN05rU2dUeFhw?=
 =?utf-8?B?NjJheG94YTdMSnhJUEU2aDYwZDhVN0Rma1drYUxyZ3ZodldhbkowU3hud2ZG?=
 =?utf-8?B?TFY1eTFWSDdhUmhMWStWRS9yRFpXMlpVVkF3UkhjUVpHVkFaanMxUWJRV1V2?=
 =?utf-8?B?Y1V3OSswbS9raFljQkVWNGFBV25WaGFjdC93VkR2TktaOS9zVUMwTHl5eEx0?=
 =?utf-8?B?T25QZ2FUemFrVVN5dWNsOE44T2h6Uks5MzM4Y2g2V0xTMnZBRmZoR0FsVks2?=
 =?utf-8?B?RVNQcWdYT0ZiQjNhcFJPUHhXQXBSaHNrVEM4eVhGZUg5d1RlYkU3S0EyTTcr?=
 =?utf-8?B?dnNGaDJ4OFdhaFpXQzVHVTVsVkVZT2dOQkVxYk1NanMwaEE9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TFU1R1kvL1dtT2psNlYzT2dnM0RvOVNHMjlCeGFzWFBzMFVsRm80ZFhoVC84?=
 =?utf-8?B?aU5FbE9SYlhLNHNaRWFCa1lvaWJhMDRucDljaDk1NVp1VzlUUWJoNWRoNzJy?=
 =?utf-8?B?WWhqVVRudnZ5NERweWRBMDM4VjZGVmI4L1dUcVJsS3BaSnI0WXJlZTRtTWFY?=
 =?utf-8?B?WHhUMnVLV2dVcVFjZXlOL3liTm5tbXYyS2hRN0UwbUhMUUhJV2pWK3VoYnIr?=
 =?utf-8?B?QklZODJZUnU3QnRaMytkcm5vQzNheUFhcURwenJ2c0JFSXdkdVo3K21Lc1Bz?=
 =?utf-8?B?TlVyM2JBQVVlR2xoTFhwWDl6ZVhxRk1FL3RHVmR2a3BXQ3ZxTVgrazQvRXc1?=
 =?utf-8?B?MVRiSVFLT0tMbllJRnRqY2hTTGNMSDVHQTUyWElHWmhaZjJnWCtCazRSdm5F?=
 =?utf-8?B?bnVJeDViSElTNkVEWnNxQSt6WUJQemxoSEQ0K0dIaDMzbVRUSkJYdjYvUTVB?=
 =?utf-8?B?TDRLeW1nT3Bld284ZTJNK3RvZnUvT0h2UU1oTC9JeU96RVQ1cW1BRGJuL1V6?=
 =?utf-8?B?NkV4NkJtNTAzcE1ndTlsZHNzN0hBdzU5WlRMYWdZbENNTU9uTGhwSDhOd1J5?=
 =?utf-8?B?eUE5ZmlnU1Z2MGRBQml2eTE3UFlMbTdlR0hORFhTR1puMTBKcVJJNEJSOWg5?=
 =?utf-8?B?ei9TMmhDbnllYWIxckJPc2VhV1VqWWVmdTU1bHZMMWZ2SnRTeUtFMG1hRG1O?=
 =?utf-8?B?L3hHekJjclh4c0ZtSkFFbGV4dFhRNU92UCtodS9qRFE1RzFJZG5qYUdYZTVw?=
 =?utf-8?B?LzdBSWFFVnllR3lQb2dKMzI3bFQ5NVZLQS9zM3JUU1Y3TVBxQy96bVhtaXk0?=
 =?utf-8?B?a2syMjh2NVNYejFXTDR4VXBBWVVsUXVPQlJSSEc2Zm4vekVGQVRVeHdUeWVa?=
 =?utf-8?B?VkNFeDRqS0VRelBGRVNaWjJ3eWNrandCNEMvTnRKVVlhNnoxOVBRUktpSWxO?=
 =?utf-8?B?cld1RW5acUllRWN3ZE4zNFVlS09kaDdqZjYwQWpTN1dWOC94QmJSbFNCYzR5?=
 =?utf-8?B?Y3VqRDA5Yk9vbFlpMGpTQ1RYcUpRMnRFSWZ6TXozWkFkTFhRaW1aMDVuOGlz?=
 =?utf-8?B?Tld1YkVHQXdNTDVVWUZRT3NYWldqNDNveVNGRG5zMXhUcnpuYUdhdVNLcU5Q?=
 =?utf-8?B?QU0yK3J1Y3Z5MU1MOEpiUVhVNTVicG9JOEhHUWlLM1lIZExXSmx0alBGWVV3?=
 =?utf-8?B?dWl0c2FmYzBZOWl1VVRzb2pyNzZLc21rWEdKdVBYVElidzFlZjBrQXJrNnhs?=
 =?utf-8?B?M0tUQk1mRnNYTmx2cVZLVFJpeGkvZlQ3OVhqQlpQRWg2SkNPTCszOHJzWGJo?=
 =?utf-8?B?TnFrditxSkZFamRLSnkvWXplR0c1L2w3N0ltUWx6aDNqZVI2aE9SdDRtUjBQ?=
 =?utf-8?B?Nk1qR213TE9YMDB6ZnJwQVpUbEdSR2twQlpPcERKNDVJM3A2TkYxYWR3WGRy?=
 =?utf-8?B?dnBWbjZjcVZDR1lWbDM2OVIxMjVJNEhvTXNXMEVsMVVQS2Z1TFZLc01ieGo4?=
 =?utf-8?B?bkQ3OG9uWEJFbUZ5dUlCL3JCWjJLUW9peEc1V0oxaTJCYTJ5OVplWW92cXNp?=
 =?utf-8?B?WFJOMFlFaUVXWHF5ckpWZDdsbWpTUU8rU29ZV1ZFZ2psaG1Va3BBT29nQ0Mz?=
 =?utf-8?B?ZUNIcndKUVU5RVpQV1VHWGdIUXdVQVBJQ1l5dDFJMHJ5blIzbmY1QUd4dmdN?=
 =?utf-8?B?MnJpd05nVENDSkNraXBQZEM2eEljdVpqSnBhZnJacjNVL2dob1BycUt0UVRB?=
 =?utf-8?B?VlZkWHBNaUs5V09nRHIyUEV5VEJkRFFwb0F3Z00yT1lsZ1ppTGlMYUxld28w?=
 =?utf-8?B?M1c4bElwbS9EaVN6anY5d1dFa3J0bkFqVXVibENmUGFJUTluZmJLRjZTb3E3?=
 =?utf-8?B?NmlMYnBmYkRwdU9UOE5IeTMydnl1M2xicjRyM2hyMm03b1FjL0pXdEovQkxw?=
 =?utf-8?B?UHA4MHcvU0xVNC9FaEtUbDlhNUZ6R054MzJDa21aMkpUeThBUVNZNFkvMC9G?=
 =?utf-8?B?YVFzWWlvbThpSVNqNHR6NWU5bzYwWkZaUFhmeDFadmM1aHpVeEd5cHdVRldr?=
 =?utf-8?B?eFo1eG5Nd3NzWWIvb0lydFI0UnpQQUdtYjR2RTJIVzMwcTcySVcyRU84aWhT?=
 =?utf-8?B?dmtETXlIZlJxRnRKSlBSUHp5Yzd5WjNvanFUcUJYbGtNWEplQ0lsc1gzSUl2?=
 =?utf-8?B?YXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bcf8361-a344-4114-f87c-08ddb7da7b31
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2025 13:31:55.7884 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HDvJTdq9LKzHYJGuDcKrxhCDiSqNWABah/u8BJKM2pI923Zk3WKTcZG73CqKajknxC8qoEooJZ8dfurT/+12LbWqOCM4ihAn1A0QQgGxw2k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF8A49C4DF4
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

On Mon, Jun 30, 2025 at 03:11:30PM +0200, David Marchand wrote:
> Hello Bruce,
> 
> On Tue, Jun 24, 2025 at 3:35 PM Bruce Richardson
> <bruce.richardson@intel.com> wrote:
> >
> > For the guides for applications and examples, use the "-l" flag rather
> > than the "-c" flag to pass in core lists rather than core masks. While
> > for the trivial examples given, core masks work fine and may be easier;
> > in real-world cases, with potentially hundreds of cores, core lists are
> > a much better fix, so update the docs to reflect this.
> >
> > Similarly replace instances of "-s <service-coremask>" with
> > "-S <service-core-list>".
> >
> > Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> 
> I have a few more changes.
> 
> I can squash them when applying if you double check them:
> 
Yes, those look fine to me. Thanks for catching these.
I forgot when checking that we could have masks without the 0x on them.

/Bruce
