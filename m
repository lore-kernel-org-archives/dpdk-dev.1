Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17D39E9A03B
	for <dpdk-dev@archiver.kernel.org>; Thu, 19 Feb 2026 10:59:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0B9AE402AC;
	Thu, 19 Feb 2026 11:59:04 +0100 (CET)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazon11010003.outbound.protection.outlook.com [52.101.84.3])
 by mails.dpdk.org (Postfix) with ESMTP id 6E9F8402A2
 for <dev@dpdk.org>; Thu, 19 Feb 2026 11:59:02 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O4qIWRu1zt0dZHCsYvr0kaM1TwHr8MTVLjZ19U6U0RCt5WowDuE7kCFEFJh71fpzC4+08xPMnXAN5HBKYLwFEueiu66UAz2k+nA37VF//feyNfC77sm+T2HKKe5y2bBvP9NSYvljzPRov+wM5aLgeSqxXk+o6lWmnh1c0ejZFsqYOz028rigp00WsycRxSlmf/WWbbDTgw1T2A39DPVOWDwFUJqK3790x050+d1ddy7zme9kM2l41AKVBEZ/vtk1wLc1Llpw2JFtWq6bjySDrBMkz/00P2xdKKkd3mzzeiweg1QNTjGAt0bUL5xoND259SQdhVEqAa2VQj6ajVrM6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e2cBlK0qIqibF+HkyzK6SZ0TXPxJnhbzwlNS7poovZE=;
 b=Qe5UhkA4cbC8+a9wbLHouZCJYJinGX0hfojCbXn+agAngB0ec/bwzIk9uW60ENKab2sbNVUFcJJiAS4CVIPdSVAA6/6JNDAN1slcNKjUJDIOXtbux6IlJ1S8PY3swgaMwQyhE2+PEv1Z5AHKE4gN1meuFU4PgBlGEuOYwJna0XD/8gz2hRD0Qzc0++z5ucF7lKl2nUAaRA34Mw/vu4v1P0uCCOtIqfmvv6laTtsbB2dqBnfe2AeWejVlwa/Cx2u4z6vZcyH8y4dOO0atGLqO8qGv0XuMSoNUExR9Zhvjh1lyM5ncyGt5GX/kdTxZPnA0ys1BIjVfEQDK1d8cyRYZbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e2cBlK0qIqibF+HkyzK6SZ0TXPxJnhbzwlNS7poovZE=;
 b=gRA5zNl/iF30lyQQ1OucaI2Ru3kiYGsSR6U8NwTggOJYXnVVj0Xdachi6+MW0f3DNwMZjWRREnPoX8GvW2Rn0jyFreA4ksSQsfXi2VhOM2z+SptqufYcSFWOF9bjrrAf38Sd2zO1J/9NRdtu+GKDCocMUJeXzJV6DDUL4njbP1DlfDlXgvStPwo8xoxM9YnOKnNmTvnxc6LkDbsZ1yaAVsCDfjhSktVLThR/O33jSrmU9/CMGY942kuvEdBSFFHyafOtrzc3zAB9fyNBscnSpDd1n6FY0BntxA45EUQDggSXP1x+SJteVMkBW68BYQzfI3kT3/0c0hjBe/nAGux2AA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV1PR04MB10750.eurprd04.prod.outlook.com
 (2603:10a6:150:212::14) by VI1PR04MB9809.eurprd04.prod.outlook.com
 (2603:10a6:800:1dc::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.13; Thu, 19 Feb
 2026 10:58:59 +0000
Received: from GV1PR04MB10750.eurprd04.prod.outlook.com
 ([fe80::9985:c5d3:961:2003]) by GV1PR04MB10750.eurprd04.prod.outlook.com
 ([fe80::9985:c5d3:961:2003%5]) with mapi id 15.20.9632.010; Thu, 19 Feb 2026
 10:58:59 +0000
Message-ID: <44acfb6d-d9c5-4f14-b39e-6dfbee827d39@oss.nxp.com>
Date: Thu, 19 Feb 2026 16:28:53 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/11] net/dpaa2: warn on rx descriptor limit only in high
 perf buffer mode
To: Maxime Leroy <maxime@leroys.fr>, hemant.agrawal@nxp.com
Cc: dev@dpdk.org
References: <20260218160453.142311-1-maxime@leroys.fr>
 <20260218160453.142311-4-maxime@leroys.fr>
Content-Language: en-US
From: Hemant Agrawal <hemant.agrawal@oss.nxp.com>
In-Reply-To: <20260218160453.142311-4-maxime@leroys.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0043.apcprd02.prod.outlook.com
 (2603:1096:4:196::12) To GV1PR04MB10750.eurprd04.prod.outlook.com
 (2603:10a6:150:212::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB10750:EE_|VI1PR04MB9809:EE_
X-MS-Office365-Filtering-Correlation-Id: 78b8e998-5e8f-49be-12f9-08de6fa5e257
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|1800799024|366016|376014|19092799006;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RkhwTjV5ZHVKb0ZPbExEMzM0WVBWK3lsNDI2Y0FLaFZpcUh4Rko2OFpXYWcv?=
 =?utf-8?B?SzNYNHhkU0MxUnRpT015ZW40cUlNdFc5ajVYYzNXc0VxcFJLdnhGWkY4cS9l?=
 =?utf-8?B?ZUJVVmpreXR5RGxXQW9ueTJ4Z0txbTNzbWZncjBwci9GR3FsUkpsOXA3aE1w?=
 =?utf-8?B?dU16RVhEWGtESCtkejg3WkdiTzNJamhIMWVuVC9KRFRwdzVwcllDVW5QM01Z?=
 =?utf-8?B?L3o1UG9MMytXWWRxUnhJdVFDTXRVTnpKcEZjK0d6UG9ERHFtMXpnaWN5L2Vt?=
 =?utf-8?B?MUpZVTJ1bTFTK3N3TkUrRFFmRUNiY2dIMXRPdHhyYXI4Qk1IdCtVUDFLaHdw?=
 =?utf-8?B?T0liMU9walF5VVEyOVgwcDhTc1Zhb2lIazJ3VFllQ3p1cnUwWlI0dGZvdnVE?=
 =?utf-8?B?TkFDc0NhVWRpcUZjR00zVEV3Z2JRTE84Z01hTXdrWkF4K1lvb1JNQzlxSFNr?=
 =?utf-8?B?dW0ybFF3a2c4elVzdWYrN1Z0NTJLbk94c25DTzA0ZnNHaFFEc1l2SStmL2E4?=
 =?utf-8?B?TFdHSjNZYmN4cXhjZzhHSnIrR0hhMWdySGVnSkFIZmIvbDNnb3FHTm9rOGtz?=
 =?utf-8?B?TTdSVnF5Z2F2Vmh1ejYrSzNsVDdkd3I4MnNET2w0MDl0eTlEYkpsR2JVL2th?=
 =?utf-8?B?bFVZbHZ3SHN1ODI4cEhKelhnYTF3bXBSOGF1T2gvOURydVVlVDBIeFppcjBU?=
 =?utf-8?B?S1prS210Qjk0dTJ0RTNId0w3VTZ1M3ZRd1Y4c21ranBxVTdWM0lPVW1qMGtX?=
 =?utf-8?B?akNkMUdFMFpPcTNzU0tuNGxkcjk2TVIxZXM3SE4vQXE2ZHRDbWVkdUtOM2Jj?=
 =?utf-8?B?cVlJQk5TRTZvNmJiUjBycnhmeVJXazczeVhrWnkyOENXa1Z2azVMRWtJRVB6?=
 =?utf-8?B?UDYvZTRHN2pMTkJiSExWTjZjazFWa2RXeGxYckpRaU1LenVNNWx1NWN1alFs?=
 =?utf-8?B?RGVma1pUZlpBaUhJb2tQdUVFc09QdVd4T1dyeEM2cEoyWFNWSWFVeC8yUHRs?=
 =?utf-8?B?QVdWdmREUHdTc20za21aUmJtY0haOWJrbEZGcnRMcGdVOXhOQUNMTjJMd3VS?=
 =?utf-8?B?Z2s0dUh2WHZvZDhQZ3BEcXBWcEJDMWVBWUVSZ2M0R3pTVGxnZEk0bUFGbFFI?=
 =?utf-8?B?WVMyWG93Ty93anNDVWZtbExNT0ltVVl0bXY2bHpFR2tKNUZNTjRRZ2RXWUUw?=
 =?utf-8?B?dWM3dDR3cnlFNlpPR1BmWUR5WENkNjlZa1RJZkVqUDlmYXpobTBtTkpCNGZM?=
 =?utf-8?B?WWJhdmR0NEo4c1F4dUhiVDdIbzZvdlQ2K3BYd1V1Y1l4MkUyNWF6UlBiNzcw?=
 =?utf-8?B?MHN2V3FRQ1BVUEhqZmdwbXc1VFJNQzVVaTd2cngrNCtETEJIakJpVk9EYXk2?=
 =?utf-8?B?Q2tWci8xZG1IVXVteTExM2Qzb2xZbmZpVHh5UUR0VDJQOE1KYXNFQWFxeTVL?=
 =?utf-8?B?VFJ1SU1FNFMrOHEyUXhQU2JUdUR6SXA5WU1kV2htR1FueUVrYVAva1pMbGlR?=
 =?utf-8?B?WEVxRUFyWE93QUI3ZHJwcHpyUExld1lock5NRVhCUklCRFgzaHVXL2ZnVVNH?=
 =?utf-8?B?ZVBZWXViTldyYy9jVXZTbGU4V1hjWDNVWFpmWDBnQnhxREo5MmhXWk1iMVFx?=
 =?utf-8?B?SlNPcTVraUgvOGIya0xEWTJvcnlZS2VYZ3YxenpHMnFFdUlQS3hVYWtIZFc5?=
 =?utf-8?B?SjhNQWxJY1ZjUjRlZXkxMHAzNElsd3NmdlhUTkp6OVBZUS9KUlhoMUFBWTFm?=
 =?utf-8?B?WVQzQnVvaklpWTc3MXdHbWdzR3NwajdlSXVsY2ZoUEVWcTEyMmtZQXE5MHc2?=
 =?utf-8?B?b2JQaFVBY1hxa0grUzBWZWxsQmxuVkFINTdMRldBZnk1WUtBblV1LzNiTnBQ?=
 =?utf-8?B?Q2lMZ0tHNUtzN3A1cEdpKzRWR3VQYUxseE53L0IvZkpNalNZR0xXdmV1am1w?=
 =?utf-8?B?VFk2enFWNUNwYVE4Qk1kU0ZBcHdhYnZ6NU8rcjZ2WlhCeG5QTVpDcjZUM09K?=
 =?utf-8?B?dnlvS3c1TWk4aEQzOGh1c3JieVRUWTdCVERhejd4L3hhNUowVWJyUXFBK1hj?=
 =?utf-8?B?T0FDUnRkVnhtRzNNUnNyWllwNU5ORkdDZmcydnlSa2tHNWMxRldiMEdlUFd1?=
 =?utf-8?Q?8yIs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV1PR04MB10750.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(19092799006); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aHhKeENKa1J5RXJJcGdLMmNvenVpRHdLczQ5REphQ290SDEyNWl1R2kxdnRX?=
 =?utf-8?B?alhLQ0hZQzdWclkrMkxJRS9RNkhUUGlRbGVzL0xMRDlhWkNXeWluWWEzSFha?=
 =?utf-8?B?YngwdzFZaGZqd2pHOGtHcDQ3d1dYU0RCdmRiMWZWTEQzSVpJUnhzRkdNdisw?=
 =?utf-8?B?czhSVVVQVGJuUW9wM2FZVWNaMENSRmtoVkEwbTdQSkF3R2tEN0pjanI2RkFN?=
 =?utf-8?B?WVEzZzU0Q2ZGU2xBc2VhTllEU1ZRL2hkNmFFd1o5emhuSW10Rzg4YjA0Q053?=
 =?utf-8?B?RE45Njkrd0E4R2FnVXVGKy9obVhDUWFYeGZ2Rlh6c2pCQ0UyVUxJQ3NzR3d1?=
 =?utf-8?B?YzJvNVYvZ0UwL3locFZSb1kvaEhGeXJKdm85OStiZmVqOHJOQnRzZDVGOXFk?=
 =?utf-8?B?N3U2WHRIQS9vdG41RXFhd2dGeVZDaHRWZjB1ZGdnTnBmSEFUSVBkdUVNVUN5?=
 =?utf-8?B?WVQvR1ZkRExFQ2RqSjNvWmxBSHhYTklIZU95SG56aC9SVHgyeDdmMUhWQ1ZQ?=
 =?utf-8?B?blVIZkE5S3ByUzRaWGpkL25jbU5sdDNYSkg5WDdOTW5GTXVpMFVKbDd1QnVQ?=
 =?utf-8?B?THNHTDJXV1VRNlBHUEF0ejkxRmlUam5PeTVwc1E1T2g1RGlTWk9iYUNkYkxY?=
 =?utf-8?B?ZDFXR2V5NmdVbXVURzZZVDg4d3FuU3dtcmNxTnYzMmhGZ1p4M25kUCtTbU82?=
 =?utf-8?B?MW1ja09PcFpjLzVwSGdEM2F3R0dObnkrR2tsbTRXK1JScUJQNFNtZmlZWEo3?=
 =?utf-8?B?azMralFUam1ad0RqSllBRHpYMzBTM1Z1aDJBYkhiRXF5UWNHeWJ5cFNseERt?=
 =?utf-8?B?WHE1end0OGdsTDFyRnpiVkxPNVBnMWxkOURYVUFJeFhUR2lJVjFFS2RTbGxy?=
 =?utf-8?B?THBQWWhCS1A0VGw1QnFIeHh4R1J0WkxqSDN4YkM2Y1ArRHlJYS9XeFB6MzBS?=
 =?utf-8?B?MmU2a0dzbi9WTENCUm5vbGJ2Q1lraHIyazJ2ZEpoeG9JMnI3c3RJRE40Snpv?=
 =?utf-8?B?L2FHZ0dQa3VabG1JRTIxUnBHQmdTcnlIVU5PZkE1azRUcXdZVXR2Z0tkL29p?=
 =?utf-8?B?RlVaNmF5RmNXcjVYTURIeUZObHBzMy9lakZscHgwcllqYjFIUjJYeGRNSjk3?=
 =?utf-8?B?ZSs1UjNVQWxCV0xSUExaa042NmU1enBzS1ZtbnBiamlUWnhiV3h4UDJ5Si9S?=
 =?utf-8?B?cXJ5ZEwyVzFzeG51SG43Tmx4cHY4OFRvbzNHMW93UmFMN2JncW52T2NJcGF4?=
 =?utf-8?B?Vm5FWnE3S0ZXNW5hZ2g2aUJiQ3MxaUZoSGswUk9YT1pGbWdRemFpRVRXZmFs?=
 =?utf-8?B?Wit6TkgwQnl5bEVHQTJYbWZ1WUVqNU11WExDVUtKRzJ4Z2xKWEtPaXVFRUhs?=
 =?utf-8?B?azNzT1pWdVJqZkxUUkc1M0N1WW1TUEd2d3hRaDdhNEdmM1hkOU1QNDhkSkZr?=
 =?utf-8?B?TWFKNjQ0bTZORlFpY3JQK3dVNEJvWHNFSG1qbUI4U3kzaXpsZ3lIT29NUnF3?=
 =?utf-8?B?L1hsUmlJbWRQWFU1NlF4cVB5bkNlZnAvRmtyZEdDeFEzUmxZa3IxaCttZDd3?=
 =?utf-8?B?TUd6ZlhnVjUxUlVkeDQwWllsUytlUEo3bDIxVWZnVVRZdXd6ZGdvVEtpS0Nj?=
 =?utf-8?B?Slg3cERFNmxTSkcvbWJQY1VKV2lma0t2YmhJeEM3YzhsZjlITzY4TFhGem1Y?=
 =?utf-8?B?VTRVdi80S1liM0dwUTJMU0UxRVBMaXpFSFNqSWZwMThvWG9hMGJCbThjMEpv?=
 =?utf-8?B?aTJlRWpiNEp5NHc1eUtTTGNVby95ZHhEY2o2TkJhK1FrVjR4ZEF1ZjJ1OE9x?=
 =?utf-8?B?R3NGbGloTXZiK0tsbElaNnBBWlNWTWlVbThBenovTnN3MEdocE5CbzdxdVJ5?=
 =?utf-8?B?cFBxVER4YlJWWFRQZU56SzZ4TXE4YlVwSzlXdGl6MDU5QmJjRzVmUk1TMGJ1?=
 =?utf-8?B?U09mTG5uM0xxMERKSjdBZTg1ZzQwV2VXdlM1eWZtUGhEZk9OLzZNM2lwNmFL?=
 =?utf-8?B?RkJoL29WejVwZWx1cDRUVWh3dEFveCtCN2g0V3hSM2JCNUZvTDNIUzd6Q0hY?=
 =?utf-8?B?Wm9jVUtNM2RnSC9ZVDUwbTlqRHpYckNobUpvbzMySndOUjAvTnNIbnNFa0Iv?=
 =?utf-8?B?aGtUY3p1MzA0NThEN056K2Nob2NiWWNSbnhKOFdYbGNHdUFBR3Mxd1g2SUJK?=
 =?utf-8?B?d3liVGwvUW5qOFJsRG50RnE3MVk1MzBXaU90VmplbHFrT2tzMWpJRWxObHlO?=
 =?utf-8?B?TFZKM1oyVkhQNDNmeDlDakhGN3A3Mnp1TnZvUkVEME1taTFrb2JXbXRLV3JX?=
 =?utf-8?B?ZFZjb1pMY2ZBNjE0a3pxQnpJd2dWWVBSWmJIUFpXRnpDZ1RicGhYOHhGR3kz?=
 =?utf-8?Q?LymKe0tsaXg/VyE4=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78b8e998-5e8f-49be-12f9-08de6fa5e257
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB10750.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2026 10:58:59.4241 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: juOBg9M8c3usO5Ovx9wK6uuwn19PLpkcQCkKvvpu+NEc8jSLADYqfmoYNdmj8k6srlYrI29Qs3ZGEUBa5HWKcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9809
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

Acked-by: Hemant Agrawal <hemant.agrawal@nxp.com>

