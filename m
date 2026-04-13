Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7551FF34C5E
	for <dpdk-dev@archiver.kernel.org>; Mon, 13 Apr 2026 15:16:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3E5854021E;
	Mon, 13 Apr 2026 17:16:37 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by mails.dpdk.org (Postfix) with ESMTP id 3C03E4014F
 for <dev@dpdk.org>; Mon, 13 Apr 2026 17:16:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1776093395; x=1807629395;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=iqSTdj63POvAhqZFf3lE8ClvOwI0nRCtZnJXREvhJDc=;
 b=LbBMiWBql1PN7zHK/aWDGWe2sQ+xedoNH+iWG+CeWfyZ/h1PdmcSigl6
 M9/2+CQGIDA7U9vAsXpHNSQKht/mVM3JxGzYpd76NliKinnlxtt1rdfar
 5gw0VOj4VQjMfeGUOjgUSsdoSBaubU1hoOMKfRQM00zzLtB5WbLT1ubl9
 GC/3RdfjKvJ8hpkJ4R2ppZbVYN2pSyIjB/1epxgN1vuUhwJfJ+AqnYW+S
 8pr1AWCpe98VHmld8vPfSLum2QWY+0xOTb+FGeZCTTe/NqWUHA1ZCXuw2
 wLyRN3omquQi4g92s7p038j47b831SBAisn+8e1PyL/2GUhe0W7zr3Baj g==;
X-CSE-ConnectionGUID: GH1MQwzKSvyLUUx0xw5eOg==
X-CSE-MsgGUID: Wc6U+KBCQ+iDSx6XcTZrUQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11758"; a="64563270"
X-IronPort-AV: E=Sophos;i="6.23,177,1770624000"; d="scan'208";a="64563270"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Apr 2026 08:16:34 -0700
X-CSE-ConnectionGUID: xyQ92cEhS5ms0kgSGmjEEw==
X-CSE-MsgGUID: 6DTt7vYSQDSqWGPXVty3pA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,177,1770624000"; d="scan'208";a="234222699"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Apr 2026 08:16:34 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 13 Apr 2026 08:16:33 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 13 Apr 2026 08:16:33 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.29)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 13 Apr 2026 08:16:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m16kgusCbPIXEj8aBnboNpheKedB2+pw/RET/k7q0o+zH+3/7JkizgF/sXHQ3s6qxIknRU5dggj/6EKq5OxqKLAMP4Qhr4KdCWsNyoGlZG9pGsycb3bJBXjogoMfErg6gLNIebrKopaAPQN8NXllVpDf3Lk3rcvUp01MaOiL63FybZo+7xge23A1uWt2SEbNcMgSSGY+4ubrwgU0LpfdrlKxInjWfL9P4yF4zE21bL+reYnNaw3adaItjUc+PmK3+lnY1t7wV0HkmWjEw+F71miA5k5zaTWpVzxuTJHdNCXmAUDNp3v0LoQPSK4q25vkRS+kFG5MDncDvkscM04EIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iqSTdj63POvAhqZFf3lE8ClvOwI0nRCtZnJXREvhJDc=;
 b=US3kufdrKbJf+ByHsDRJHY2yy6DLZ6xT4yCermTYt70XO0w2QwPgSlVRKRroTvqOKfr0FaRpfj+Nj7ist1PKKJkiz7i5jYmitlnLOO3M6HUzRZH0Sg1sxC/0lxv9QUy/Q1zmqOSoHEegodaXHfiMl8JdykG89AuEtEDSa97SKD10vb29WusI2GtJhDrA32TsNQbJLKMen9In7l5/luj+fra8zWaUDYzV3ghqNTykRwXFxCM0T77OD1cLV5UVnhRwpqWxB/5/5S29GRcBR4q56Ed988VYodCmxUYdogwObEiw+VIiuWFqveyI8tiFiisYccsKCW5+xOJxYHIIrMRgbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM8PR11MB5653.namprd11.prod.outlook.com (2603:10b6:8:25::8) by
 DS4PPF07B018B9F.namprd11.prod.outlook.com (2603:10b6:f:fc02::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Mon, 13 Apr
 2026 15:16:30 +0000
Received: from DM8PR11MB5653.namprd11.prod.outlook.com
 ([fe80::74e3:c0eb:29ee:fffa]) by DM8PR11MB5653.namprd11.prod.outlook.com
 ([fe80::74e3:c0eb:29ee:fffa%4]) with mapi id 15.20.9818.017; Mon, 13 Apr 2026
 15:16:28 +0000
Message-ID: <a66f26c2-8c5a-4737-bfe4-d5a0bf491f0a@intel.com>
Date: Mon, 13 Apr 2026 16:16:24 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/23] examples/ipsec-secgw: resolve shadowed variable
 warnings
To: Stephen Hemminger <stephen@networkplumber.org>, <dev@dpdk.org>
CC: Bruce Richardson <bruce.richardson@intel.com>, Akhil Goyal
 <gakhil@marvell.com>
References: <20260407035209.650419-1-stephen@networkplumber.org>
 <20260407151732.272195-1-stephen@networkplumber.org>
 <20260407151732.272195-10-stephen@networkplumber.org>
Content-Language: en-US
From: Radu Nicolau <radu.nicolau@intel.com>
In-Reply-To: <20260407151732.272195-10-stephen@networkplumber.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB8PR04CA0016.eurprd04.prod.outlook.com
 (2603:10a6:10:110::26) To DM8PR11MB5653.namprd11.prod.outlook.com
 (2603:10b6:8:25::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR11MB5653:EE_|DS4PPF07B018B9F:EE_
X-MS-Office365-Filtering-Correlation-Id: d8e870bb-5631-4355-1cad-08de996fa283
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|22082099003|18002099003|56012099003; 
X-Microsoft-Antispam-Message-Info: mzExLU6niDMQyZgGkBY2mKcZP4e8BRNWW0S1Xw+ApGN1kW8+afCYere0UqyMoJfKhDdHgyq4sTcexuX3cuD03/+JaNyFFdYJ7OQHg6FRsPxywPPWLHgMkXW0JC74Eh9x3ZNGDYx/0Zy/WJAJSqvOfxHa1P/43R9IEuELN6zIzvD6buW5NgDQFzsWsyEkCFbB+50vDlbonCpHr8oYCciyKIBq15/U7dLJ+za8f5h97+LYPSm1JFQt8ZV22f+JQWLXMrw3sQJ0PjJ6/8sQLHMwCHEqydUg2Bi9uyQ2YQf4qpQwqy+e0id4HepomtDElUN0hG/ewVz9kd9y+rJ+NgPWU+VfdwD8bwdCtTfQCi6yv0JepL65AE5OoGlEsgQoyF1HXieoWA205xLJlVsKuI8RQLgpT91JXunAvCR58aQKMTUYgvUzuTRq5JV+7vHOQCbik+AVzSEz3/CUbiB2wt7cxmT7zs3itLrAsQNYJ+eRf5qxk/cMx5pK3sgv4FeOvte0dTcnoefxblemnL2GnWhF9nFJnYE25pq6V7ypBcfCLegA+kn3i6JQje4Imjp7TGVkCX12xRuWKhHLev+OTp/DVGCpRk0//3AJ5bHRMeTFvySXCwBHBYlI2ks/LACkyOKfvql1tSSxHLApQsAo5HFUZsjYTKCC9jA+SWH14HUGkCNqDyDwLSN4Hm/f5FRvSVxXHJ5C4Z99ehdPAig5Gjw092CP+/jkxNyfctf/PAlv66Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR11MB5653.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NGFhbWJzUUMrSUZIRENjU1dHaVlxYnc5M0pwRFM0cGxMWVNFdFZwdkNYdW9N?=
 =?utf-8?B?ZTF0em1TM3dYejNOMUhESWZVRm9QZnRkYjMzRExIZ2V0dW55UG4xb3Z5UWtX?=
 =?utf-8?B?Z0tIb0tYcktXM1ZIdmRTeTZlR0svQUxZTDJ0TVZIRHQ3TTlBN3psRDErQk81?=
 =?utf-8?B?N2FCdWExbXFEeUdDYmtRS2NUNzZGalFabG5CQWRoa2hiUVpNYnRMa010OHgx?=
 =?utf-8?B?eVEzV2tNd1FiUTZGVEVnM2VLbm5CRkFLRkdhaGpYb2N0OElMM1VycGtjcGVm?=
 =?utf-8?B?Tlh3ODF6bGt6TWI2QlFRTkRsblJxdlZzSzlGZktTQ3pnVnpmdFRrWmtWa2Vh?=
 =?utf-8?B?TEV4KzJjaUluL2p2TGJLWExNOVVJZEZobzNkL1ppYmhNS3BpWVJISmswSU9G?=
 =?utf-8?B?WjF3YmdaVFAycmVKZE9NQjA0ckNwS2NlcGNsakRTa0w4bThyMUp6Uk9TbTM1?=
 =?utf-8?B?dHNxaitCU1prZU9mOWhxOXRpSENwTXVWKzUvWGdSNjhlRUJxMk9sa3IrY1k5?=
 =?utf-8?B?UGlzNjQ3dlVPeUNseFNRMGM4TVZmYVg4SXNVY0E0WFdCOHpNOS9EeFZyM3Rh?=
 =?utf-8?B?VDdNNFNTMmdqSFRNclZ6clowdVZRbHlqSmI1SWd5M1NaajUrQkdiL3pJR2Vn?=
 =?utf-8?B?RHlXZmVZUWU5TisxdVlkOG1XNG1wRk1aMm9Lb0k0V2wydkU2ZXRBdkIyektP?=
 =?utf-8?B?YUhqZS9vZWRaRzdQS05FWGZySUZyZVRRRkZ1eERqYzlUSHNvcHNFNy9UdU9X?=
 =?utf-8?B?VWlDUVppQkUyMmh3ekFVR1RicDcxbG1WY2JoWWljY0xOOGdTNENuMTNHSzdk?=
 =?utf-8?B?aXBGR0w2SEwwanBZdnlLRlJMSUhJeFlYSjZWaGltSkVPYm5Cc0w0UDJJbGY3?=
 =?utf-8?B?OWp6TjhwV29SbEpGVlhXdlkzSDBrQVBBOG9FRHcvRU9uRmpvU1lVMVBWK2kz?=
 =?utf-8?B?SEc4TGZ5b0VEV2FRU1pvNWRIZk9vZzRkQ2EycVgwcTFRZm51ZlpJK3pwZUpN?=
 =?utf-8?B?QXlLTllLTDB6b2xxN0tLem55bXdzem5VNi9pMTFYT3ZRRnRwZUw5YXg0YVdJ?=
 =?utf-8?B?UFVyc2NYRDFSNklaaktWalhrellIUXJPVDM0WHRWRndJSCtJbDFjVjU4Uis3?=
 =?utf-8?B?L09tUCtMekh5dXlhc3VaeVM2OVROVmJsalFzZUE1Mnd4N3hCMytoM1JRN3Er?=
 =?utf-8?B?ZGxySXRaRGxIWGZNZDNYdm5rTTROMTdLVU1jQVk0MlZCa2pQYXIxWHZYT2E3?=
 =?utf-8?B?aXNGTVFYUnBFTUw3ME40bDVpZUIrcVcyMWNCaUNJa0w2bWNNQWtZeElVdFRR?=
 =?utf-8?B?cUlubGlWK0pQbVk1c2E3K0lSdHZVaE5LUzZhQjQxRmszd09ZZUNlckdKRU1l?=
 =?utf-8?B?NTltUmlvRmVoOWRkTnRNZnNBeTNudGVFS3ZxTkZyTDgvT25aQTIrWWdmdFJu?=
 =?utf-8?B?bC91d0haMlJvY0VPaVpFSmRsS3R2N0R6Qk9WOXVQNWJ6ZjVWZnBlczNrQStJ?=
 =?utf-8?B?SXpLVjYwZnBlZkMvZjBvM3o3RDRNMWdlZWQySUxHd2tFcHhDT08xcWE2MHZ2?=
 =?utf-8?B?bFNVdExsaThzWnMvMW5VVTF0UkJFUHNJaGU3Z1VVOWV4SHhpR1JtZXk0Y3FI?=
 =?utf-8?B?RGIvajNjd2Z1TGVnRzR1dHMyZmNoTG5lbExueW5FVzFFZWJhc2VlV1F0R21q?=
 =?utf-8?B?d1BrREE1MFZNWjVYck5YS1A1TXBGbElJYXZXYjA3RVdyNHJjUmNScEdtTTRV?=
 =?utf-8?B?WFljc3pkRlJNWjg4eWlucUE0UzlJZkpTY3R3OEJqWEcwbjg1OW15cyt4NnI5?=
 =?utf-8?B?WE9raTBiVkdZT0wvSlI4Q04rMExhVjhOM2crQWR3bHRKTThEV1g3aTJqbGd4?=
 =?utf-8?B?YUpzQ1d0NmJIMG9BOG14VnhuLyszRzBjQkJYTXQ0ZTB3WjNydFVjdklaTVJa?=
 =?utf-8?B?YlFSMHN3UzBNRnhwVEJTbXpMSG1iWm81dUhNaGVuMTFPRVlFd243RUptZ1Yz?=
 =?utf-8?B?SUx1dUpCaEJLYkJBMFQ0ZWVjd0t6Tll5VFNUUEZMYllkMnE5V1UreVMwZW5X?=
 =?utf-8?B?bkJGQ1ZaZmIySnhkZlFnWmRGbXlLUDBXTEM2ZzJvc0xGYlYxVTZjdW5MK3BK?=
 =?utf-8?B?bDN2STVCekh1RFJzclkxd25WSUpqMGtQOVVEeUc0Nk1yOVFJVXNYY0lBRUUw?=
 =?utf-8?B?RnIvY09DSktLZndJUXI0YUFUSUV1bnIzc0hKUlk1UnFGeTBWenVzTnl0cTRM?=
 =?utf-8?B?TExpK0ZEV0Zia2dETzlaZ3JHMm5JVU9NSXh1YmNsRDNxVVNtaUFHM2ZpelBo?=
 =?utf-8?B?OWw1MUZhT240NkllU2RQMW0yQWZqdnB5NVlNSnI3dklEdnJGZ2Vjdz09?=
X-Exchange-RoutingPolicyChecked: hpHO0wiFhAZqMsS7xbS2RwaHo4fYACrY1M1g7lpDVV5fvPqevt9tRTxCjArVmxnOZ/xiWmHdJRkj+k/gwbKPIrVmddDbWjiMf9E42Q8bLqykvOGrP4u/bzDTFm7fxiieHn/FW1l4MU/q/Wy2ZioXKTX+e4/tD+DyC8mV7N46l77RynQUZdnw/n+8CMAPQdVIw4jCuFNOp3rJd9oWiSzb5F/WeS90Cw/Sa/PC8/C0eov9KZDU8LUfD6RLRABQb5V10B1sOcLU381yPk1w5YwZLaRHRvyDskEadC0QV7hYmUuwA1nDPJd8iSNTc+mL9LwxLZckw2oosra07xiRGau9Rg==
X-MS-Exchange-CrossTenant-Network-Message-Id: d8e870bb-5631-4355-1cad-08de996fa283
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5653.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2026 15:16:28.4194 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9iRsvp+fu/zz5V79P2y7ioy4jQ3n3v7f5JDsqtbMzkZfGG5MsLD5xX54fzQl90WlsVv+DN606/taBnWonKCS1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF07B018B9F
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


On 07-Apr-26 4:16 PM, Stephen Hemminger wrote:
> Rename variables where local variable shadows a global declaration.
> Remove unused lcore_conf parameter from sa_init().
> Replace shadowed optarg with parameter named arg.
>
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>
> ---
Acked-by: Radu Nicolau <radu.nicolau@intel.com>
