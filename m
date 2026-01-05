Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C31AC2A079
	for <dpdk-dev@archiver.kernel.org>; Mon,  5 Jan 2026 09:11:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 39C264026F;
	Mon,  5 Jan 2026 10:11:35 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mails.dpdk.org (Postfix) with ESMTP id CE47640267
 for <dev@dpdk.org>; Mon,  5 Jan 2026 10:11:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1767604293; x=1799140293;
 h=message-id:date:subject:to:references:from:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=O7VcH/6LrramWYHWdxjdLwZSu7WWtC04gNZkKcd8Mmk=;
 b=cGgaeCBUy+RQZGz1rni7aDDgScmV4gb0zFT+QN9fxp4pONGGEfKXY1Fw
 hAY+1nDNdSbBTYp6Bzb7G10kVvXanPg0k5n32d87MIk34BkxAAUyC6Snh
 8Hht7rt5f6ojMo0WTskozRA7aY2+CJ33z09ep60LWYLYDZVm30XnfcRan
 N3AIP+JsSflIYjBNf4DkrxT2nDE+ibuZaqQjscXQ65lykYEhbwD4F/l4+
 faMYI9m5nPvt3TubUSuZXpE3F4+fQKJAMtY7U9QcXmaYXE6upLd9kntT6
 mYKkTysEaWrS7bFnTR5AnHHObnG3DbFaS2D4vSwCzfXxmobml9wYhc3kd Q==;
X-CSE-ConnectionGUID: LKtIVplPSCWf2FmYL1Dd9w==
X-CSE-MsgGUID: hdDfCD/hQdKAI4QWypxIQA==
X-IronPort-AV: E=McAfee;i="6800,10657,11661"; a="80087308"
X-IronPort-AV: E=Sophos;i="6.21,203,1763452800"; d="scan'208";a="80087308"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jan 2026 01:11:31 -0800
X-CSE-ConnectionGUID: 0Q2oK7ToTIyLwxi1bYP2Pw==
X-CSE-MsgGUID: D94SguETR4OTr11QJT4o+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,203,1763452800"; d="scan'208";a="239820131"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jan 2026 01:11:32 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 5 Jan 2026 01:11:30 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Mon, 5 Jan 2026 01:11:30 -0800
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.44) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 5 Jan 2026 01:11:30 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JFgU6UOXikjDB1jhFlonlIZtqPhYf6Q3PAx74KiqlATuN3K6S1NkPja9IE8sVKq5/+I+doWxXoEbhFDk+aHIwz9G9MRbBBjcjLOQKCdmpgCPYpwoIKgEvgoTE9hP3sCiPB1vjz62cm4yupbdl7Iv78HpGfGYFPgPjDHL6L7KJN/S61SSyU9HTtWBC+PB0LiMkMxe/Skzt+70x1TmRmYavQp74ci+3YAFe5hYWoYGh7LFa0uSYh7/YIqa5yBbomOEtMTtST/YJ0HqB9UZmSAFkKuwKxk6UA0BvnXfXTYDxAm5ZlFM+zuYRB7lBscGSbVwP+HiEJMZIRckfFwjieHejw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XL1fUqYtpVAUTW9/AlJjHcVbAznUfB0GrrA2GTcaqVY=;
 b=jfXzv+UXzOSQ9f03YfpLpaLw+GRuRnKCQhDgtX6aMK/G1X4OhxsPnxrd4Iq5R+1zQVF0X6q1Xyo1cklh5e0mNVnNA2Krdeq1DFOKV8qlr5fv6+4oCs4Do/THs6QTyGw5G+Kk0udKGuD6V9zRkZVTO1KV9iiemuM4yjQpqEs8SMr2kfTmzBtqGgfyj88mzLAZ19A22qAqI2Ev6x+QPPbfpSzjbcvBxWkz2oz9arBqUCuJzaI58nsB5co52XZ918Dwx8rJunD1En1TlIIOBCCxmMZGG6zbFBNT72pb/viltRSHrD6ZaqZlLDbJ2XfQ+nmTFkhrEGktDNvGxZyFCh5udA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 SJ2PR11MB7546.namprd11.prod.outlook.com (2603:10b6:a03:4cc::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9478.4; Mon, 5 Jan 2026 09:11:29 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a%2]) with mapi id 15.20.9478.004; Mon, 5 Jan 2026
 09:11:28 +0000
Message-ID: <c4554517-5017-41c2-8663-ab4b1ab1609f@intel.com>
Date: Mon, 5 Jan 2026 10:11:23 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] doc: add device hotplug documentation
To: =?UTF-8?Q?Morten_Br=C3=B8rup?= <mb@smartsharesystems.com>, <dev@dpdk.org>
References: <e3241bd4c2224616c60b7f4b0145d37ebf612344.1766150746.git.anatoly.burakov@intel.com>
 <e3bb33543d6a405874c89efeed15f01cefea3f83.1766150746.git.anatoly.burakov@intel.com>
 <98CBD80474FA8B44BF855DF32C47DC35F655FB@smartserver.smartshare.dk>
Content-Language: en-US
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F655FB@smartserver.smartshare.dk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PA7P264CA0273.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:373::12) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|SJ2PR11MB7546:EE_
X-MS-Office365-Filtering-Correlation-Id: 646f7b2f-b6fb-4c2a-edc0-08de4c3a68f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SFVPV1JyNWQxeVQ0dWNLV2ZWZjdTTlNBNS94dERlZkVuWmVsWFdQbXpxVFBG?=
 =?utf-8?B?WE5HUzJGNlVQNTJQclBDdmx2SW5PbGxGdktjeVRwS0NyK1dMMjMwWndLQ0N4?=
 =?utf-8?B?djltNDRDazlObExJL2JteXA0WWRsaHc0SlA5TDlqMG9kd2ltcG13SmI5OU9K?=
 =?utf-8?B?ZXhUeXYveXBOcmtHVmlNSWJZSE5tT0g1ek9pbk8wcFhDa1pONDJYbTlQb0Iz?=
 =?utf-8?B?V29zMk04Y29wWXhZK1JKQjV2YVBIVWFwekJpMTZMNFdaRzFTVjJ4TmxnT0lk?=
 =?utf-8?B?YThvcUdFT0F2Z1VCTVREWVBYUmFid09KNXhoc0Q2OW1oSU5oWXd4OXRNVUVz?=
 =?utf-8?B?eW9sY0VmaXdrY2I1VWdEZmQ0NlFXVTBMUDdQSEV3cGZxNDdKZEZVODFIUjR5?=
 =?utf-8?B?Y3NOTmQ5NVA5NkZLbCtGUG00eWszRVA0VnkwUTdpUys4cDdBVCtUdy9nKzU3?=
 =?utf-8?B?UUgrNGdubDV6NnU5QUNTOFZiaW9zcmxtY2xiNUJmc01idXkvZ0RDWDVxdUda?=
 =?utf-8?B?ckNRODVPZnozaytHTUhGSks0bDVaWmdOLzVrWllpVFdJWTh5TXRyZ2JSN0do?=
 =?utf-8?B?OWJraGViblRoRzJ6a09kcW85YUtWVTVrb2gvcm11QjEyWjcyOU9UNHMrbEZ0?=
 =?utf-8?B?QS81TEZjR1Z4NTdlUXNDZHBWSTN6V2hhMVpLT3Njd0loa2pLc2hjRDU2aE1O?=
 =?utf-8?B?RW51SU9DL3BzVDN4b0xzOTFJRXVyZXZMdldJRVdXQUgyTHhlY09TQ0JIb1lY?=
 =?utf-8?B?di93SGE5Z1pxcjVOOEQwRHJtMnAydU9wbHVBbEFtYUFOald3dWRkeVVCYmIr?=
 =?utf-8?B?S3F4S3o2ZkxuUTdvZXo0MHlLSnhjU25jVGNWUTRKUjU2Wk5xYjlNUTVKQlZI?=
 =?utf-8?B?SVpBbGJ1eWp2WDlMOVREenBjRUpUcEFWS3R0dGNPczhxY0dtbTFIK0dycldK?=
 =?utf-8?B?RlBxck9pZjY4dFIzQU52dHFBRS9LbTdBd3dHQk9aTFZkb1d1aDJtSmtuM2Fu?=
 =?utf-8?B?ZjFhMGNITFdPS1lUemo5aDBGRDUxbkNuZmltWjFhWnlKbDlWUUVOencrZXg0?=
 =?utf-8?B?SitqOTJLQWJxcjhyUVFvc1hwM2ZlT0xOL0V6SmtiYTNXS281cldBMENHS2tj?=
 =?utf-8?B?SHZNOUNlNjQ3Mjk4b3A5NUYwY0FQVVh1c1R1Q2QrYXpqU3BFaDN5b1RFZ0Rp?=
 =?utf-8?B?dC9iUWpDN3AxalhaekVkQzMvYXlFZldHeSs1N1lPVDVVaGdsUFF5ek42c0kv?=
 =?utf-8?B?c3lhMloxUjRFb0FiVktBeU9Ub01WYTJad3VrTU9lKzBLWm1HbkNPNnlnZ2hw?=
 =?utf-8?B?SXhkMWFQdUhSL1FCWEpySkI5L3ZhSVhCRVZUVG9BQkNZMlMwcnR3bXhMQk1J?=
 =?utf-8?B?T1hHNjlzWUxXNHQ2WS9TbW9hN0w1WkVzYTVlY0kwMDdoK056b0Z5Y25OY2tF?=
 =?utf-8?B?TGgySnNCRWo3N2pNeVVYRWplREdDYmdFemc4VkdFZEpZZXRJbDF6NVRBMDMw?=
 =?utf-8?B?TWVKV1QxWWxGTDR2Ri9lRXpvN2JYVGk0WkVzam5Wa0V1dGRWdUpoTkVRazU3?=
 =?utf-8?B?bHBSMnNnaTIvTnhTdDRIVFhhQ3cvUmhWUjdzRlZQS1dqajFkSWtvSlREZThh?=
 =?utf-8?B?WkdyUm0ra0tIMUZ3K0tMVno5UGhhQmlKei91WHAzWVQ1RnFhK0V3SzZIYmFO?=
 =?utf-8?B?eUg0N3ZpTGMwd2VpbzM3T2c5NEZqK2FLaTJzWUNKMzFwWnJSZGRYL0NBLzdx?=
 =?utf-8?B?dVYxYnd2SE5Fei9Dd1FWR2QraXdWVTdZQ3hDYmFMSWNrZzhYRWNNT3FFeTNy?=
 =?utf-8?B?L0s1Q3k0Q01UYzJPamVhcnhUaEFqZ05OdHFMRnJpQ2FsOEZPS05LYTAxMXox?=
 =?utf-8?B?dEhmMjVTbk15dXlFUi92dEF0T0QvNHEvdTJvUE43dE1jUGxCT0o3QlRWZFRU?=
 =?utf-8?Q?IkENV8Z91ogGIG3oSNoWioyOHVyc5Pyd?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WTgzZXh1d0w2d0ZaZXUvc1N2dUxQUnJ1VGFxbHJmdjFEb0FIUmhkWk9PZFlw?=
 =?utf-8?B?TjFKZW4rYnVqeWlhYkVWOTBuNldNUTdyTzM0R0Z6WjFjTWNWK2EyOVBJbUZF?=
 =?utf-8?B?RGgwMllwWkRudEdSemJrT0ZiUGtNdklTQTZuUW9iSVdpb3hSQzRnSEFpbkhn?=
 =?utf-8?B?cGk4NG9KWEc0YnZ3bmsrNVhFUzZDaUF2Z0tJQ0V6MDdhVEhNQzFLeWdQcWVF?=
 =?utf-8?B?aHFHYWtqcnB0OWRDVnErUm12WEdsMDB5d3VGbjFVSnprL0l2RVBOYXdDZUZ5?=
 =?utf-8?B?NzJIQkN5Q3QxZktnUFppdllML2JwaGsxOGQ2Wkord3Z6S3ZXdGtMZExYNHBi?=
 =?utf-8?B?eG9mZTVMdmljQlFCK2ZkTytLRXltODBsQTJXZUVrN3l3U3ltZ0FMV1J5eE4y?=
 =?utf-8?B?bDdRb0Y1emRNTjlZbnpMTFJyNTJCRzQrZ0RwbWU3SDNnL09CUjlQUFAreVVQ?=
 =?utf-8?B?aXFDTHRnQjRNV0ZHZ1lJZENMMUJkK0tweUdYMzZzbk9yUTNRaExuZmE4d3B4?=
 =?utf-8?B?OENZMHVFd09keWpwYmplei9SRnlsTC92SHc4WHJaS285OEIvYlRQaWFXMnl4?=
 =?utf-8?B?dUx6YzZ3NlU3eVRiRHArNWpHWFMvKzZCZUdRVGNNeWV2ZUdZU1Z0dzFiNEU3?=
 =?utf-8?B?dDQwTjd2em9YYnMxU3RpU0IyVE51aXJHUmVYK3BZSUg3NElhbndkbXcvaE9G?=
 =?utf-8?B?aFd1WUlPUFYwSlhKb096a2xKR2lwVWxqVEpZOEZlZDd3YW9tZHd2dUtUeWMx?=
 =?utf-8?B?eG9qY2hGYXdQM3VNWVRMelJyRWdiZUQ2QWlzcmlTQ29Eb0xBb0FDL05leWJq?=
 =?utf-8?B?RTltN3dmSUluQ21URXJocHVWd2QvbE9DUEMxd1UwVFdBNWtiWDhtODU5cWFY?=
 =?utf-8?B?b3VkNEpua21ob0o0YWVLWUFBU0Uwa0ZkUWdIODNPVDRNU3RPRXV3Y2V1WjM2?=
 =?utf-8?B?NHBsZEttMkRUN0s4SjlxVnlrRmIxeXM3Z1dzOE44MW1MdGZRM2tsS0NsRldO?=
 =?utf-8?B?YklualRkV2lPSUJySkdRWVQrMzM1VmJ1NWNEdXJHaGJ4T1JIc1diTEt3TXlt?=
 =?utf-8?B?NXZIYVlOb294K3R5cWxZbjV6bW9LYjJNVWpicVE5VVAwRm8zM3dqakRORXFy?=
 =?utf-8?B?a1YzcUtwdFJzTW4rSXh0U1UwS3kvenV3blF6UWJ3MlRhU2hKVUdTcncrQWo0?=
 =?utf-8?B?WWhoSzJGVDBjN296M2c0Q3UxMnhydFQzRzVuYWVvMWgxdWxXWkJoZnpmZkd1?=
 =?utf-8?B?aWpkRzliWUVlQXF0d1Vzb0VnTCtFWjNDMTQya2pQU01xRlJwWG9yVllraDR0?=
 =?utf-8?B?T3VPTndndzRwU0FTbzFnV3BOWVlKQzlDV0xuOVQ2NE9DdHBGU0xFQUdpaUJn?=
 =?utf-8?B?aFNoMTh4amxDVWpDK0hFbU9QbEtCeGpvZStGYjVmNDVPa3B1NFphb1RBb3ZG?=
 =?utf-8?B?dFMvL1lFMU5SbDlLMGRhZStUUVpTWjU2ZVY5Y2UxWEJ6dWdqd25YM0p0QUFo?=
 =?utf-8?B?aVVVeUdoenBRWEdVUVJEVUZzek9taEt4RG84eDVkNnR2N2t2L08yVWVxeEgr?=
 =?utf-8?B?WnJpeFMvN0pmVXVWWjFJb0JPUjZNVVVSV0oyYnFUMitsMmNUUzMxb290Z0VT?=
 =?utf-8?B?blowc21qU3hqRlZTeVlPS25EeHg2VmxSQy9JU1U2UllpNWlsWk1SbTNPWXV4?=
 =?utf-8?B?cEVsVDhoZEJFNTlsSS9aRDhRd1N5TkRqVUxBZ1YycVc3bUNQaGtvMDdEd0k0?=
 =?utf-8?B?VmlZcjFyVmtPelNHdUxENmZCdUREUk55ekZXaWJ6NTBic1htdktLeWZIcUxl?=
 =?utf-8?B?Rm9pb3YzaDZpMTRLZXpRc3Z4a3NSVFFTV0NNY3N2ZGwvVGhjbEhTdUdFRHo1?=
 =?utf-8?B?MDJqbUFTQnp5bVF2NkhaTWJjdkh2Z3VJejdqRFBGSWU4ODhUamU1cmo5SStt?=
 =?utf-8?B?UWJlTVlPNElaaEV4UGQ1ZUs0ckoxVlprNTZrV3JBalNqUkhZOFp2S3kzUjd6?=
 =?utf-8?B?Z3BJTEY5MUQvd1B6MUZsSm1QMjQ3TUR6amF0aGN1NXVXWjJieHd4cmxubGtT?=
 =?utf-8?B?dldvQ2NTc2ZYcU1XYzhhRkQyV1dhWk54aXJKdktBY1cvYUdVeFlPNUFGL01X?=
 =?utf-8?B?R3F6cllHeWJWYUdob3NXdFZMcUxNbmxUTzMrMmZXM3FqMTZUNVV2ajNQMkxD?=
 =?utf-8?B?V0Mvbkd0K3JrQjdOazVrQkJ2WmZUUWNrcDFUQ0lRSVZJeXBCdGpSblhIMzhX?=
 =?utf-8?B?SUhnc0RER04ybHZTL0hENDlwS09Zam9URUZxOU1sSmh5YjF6KzkvL3dpT2lw?=
 =?utf-8?B?N3ZOSCtZOHpralpCUmp3RUJPb3FHVEU2ZSt4bEM3U0hSS05wYXk2aURNeURz?=
 =?utf-8?Q?az9P+YE+wqb/fsYc=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 646f7b2f-b6fb-4c2a-edc0-08de4c3a68f9
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2026 09:11:28.8825 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nWyHzOjp4y3v9LXoitbRD66dsNj1jPDeEDQsJBt7E6RLMiL3V9fUMfIkspelqwRYrzpzsr1QbBy0NOzSjJoQ94pmYFl/2jhweSWObo2YjHE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7546
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

On 12/19/2025 3:01 PM, Morten Brørup wrote:
>> +Device Hotplug
>> +==============
>> +
>> +Introduction
>> +------------
>> +
>> +Device hotplug refers to the ability to attach and detach devices at
>> runtime, after the initial EAL initialization has completed.
>> +This feature allows applications to dynamically add or remove physical
>> or virtual devices while the DPDK application is running.
>> +
>> +.. note::
>> +   Device hotplug does not support multiprocess operation nor kernel
>> device event notifications on platforms other than Linux.
> 

Hi Morten,

> Does this mean:
> Device hotplug does not support "multiprocess operation" nor "kernel device event notifications on platforms other than Linux".
> Or:
> Device hotplug does not support "multiprocess operation nor kernel device event notifications" on platforms other than Linux.

Yes!

Jokes aside, it's the latter, and I'll make it more clear in the next 
revision. Thanks for the review!

> 
> Please make this note more clear. My English skills are not good enough to understand.
> 


-- 
Thanks,
Anatoly
