Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 627B7CCD185
	for <dpdk-dev@archiver.kernel.org>; Thu, 16 Oct 2025 05:15:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 19E4940B94;
	Thu, 16 Oct 2025 07:15:05 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazon11010066.outbound.protection.outlook.com [52.101.84.66])
 by mails.dpdk.org (Postfix) with ESMTP id 0D75340269
 for <dev@dpdk.org>; Thu, 16 Oct 2025 07:15:04 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bdwBjP9Mu6ET2MJgntAlGSlYOa+HOUUT0PXUJOILQSZJL1U5p5iBXL6yT/AlgmWsQXrsYgdewAJzhVWURRxbrIkHHtYVeQS5ad4akjOm1gL8lGchF8AklHbL84LwRfMUit5Hgu4rEmZKrh3sd0klou1MPI//CbJvAYJSS6u7NCY8tJZzYtcBvZba/hX8a8T9n/yETvm8Zij6ED6JNFnd8fpBzd0lQM0gRLyR+7gwViZ9AvAhMffRzHK+uYRIfG88fpEsv+O4YNa68G4CXP1qKKK66HtpGTVfdGGqM8TN/3xyyj5qJ8hvl7CLi9XgKY2x87TDlSfUStjRhXVYWsHZkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sqRzrxP3kGUFsdl1sbO/MsJSIvMl9/Xk4JV6dhOikwg=;
 b=fwwWnIVVffT64LGktGSu/SR3XNCzu0/FQfVSCkgRAo8+2t5J0h7jnYotBjIuGzMOEijyvJM9/+i8TbbC2s9KfK3aX+UjshslELxXG+U9M0Ucd7oBbwmuPbe4H1/ddsy3gjbMhS8MT3egqWb2T0X1z7xoBUwwjDRFFMwE6PRQo24GSOLDwzS1RqNNWJEBrqyZ/thmBfFgLX45x4jZBzt6AbtIYUT5QdLTrrOLsIofw+PbWOf5bDyva+UcWpdqh+thjXp2O4NFcVzhmcGdNrsGInWI4AjEiSB5sgU/JFJ4zrr9/C/TNO+VFFRG42xuBlbKha/VfSV9YBx74DqnAxmcKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sqRzrxP3kGUFsdl1sbO/MsJSIvMl9/Xk4JV6dhOikwg=;
 b=jjUNVaF/XRXDoHTQzo+sHIbew7qH9w6AhPh+M6uBjkmyZJXHCAJyEn1FF5IdZIIZ3XtRxFvU0PRglQiPMnfCBEhVsBScWpktwy5ObEJ48ZCI2UambxHQZbrIEwfqkjBmoEmgjLWtvlllAgI+qAvet8vuDteQaWnnPVIsQl5hiuEBcKXndVc3zRV/WlbEPSei6BMOjdcWdIin60wYY2o7R+j5MCSNCZ184fDIntU1H/+cEuSRZZIpdeJYt6Njac5NRTUjue8kYIr4uUcQ/kaKpcPn4HYSJK6ti1L/zgpwJuVxbzq+uSxXJeUt0ElP3FcOR5dff4kjAz92iMyF/0579Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9328.eurprd04.prod.outlook.com (2603:10a6:102:2b6::15)
 by AM7PR04MB7029.eurprd04.prod.outlook.com (2603:10a6:20b:118::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.11; Thu, 16 Oct
 2025 05:15:02 +0000
Received: from PAXPR04MB9328.eurprd04.prod.outlook.com
 ([fe80::f268:adb3:8817:15e1]) by PAXPR04MB9328.eurprd04.prod.outlook.com
 ([fe80::f268:adb3:8817:15e1%4]) with mapi id 15.20.9228.010; Thu, 16 Oct 2025
 05:15:02 +0000
Message-ID: <a9731c85-129f-4169-8e8c-246f1c4b90ad@oss.nxp.com>
Date: Thu, 16 Oct 2025 10:44:55 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [RFT 2/3] net/dpaa2: make local array static
To: Stephen Hemminger <stephen@networkplumber.org>, dev@dpdk.org
Cc: Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>
References: <20251015230933.875860-1-stephen@networkplumber.org>
 <20251015230933.875860-3-stephen@networkplumber.org>
Content-Language: en-US
From: Hemant Agrawal <hemant.agrawal@oss.nxp.com>
In-Reply-To: <20251015230933.875860-3-stephen@networkplumber.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR06CA0018.apcprd06.prod.outlook.com
 (2603:1096:4:186::8) To PAXPR04MB9328.eurprd04.prod.outlook.com
 (2603:10a6:102:2b6::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9328:EE_|AM7PR04MB7029:EE_
X-MS-Office365-Filtering-Correlation-Id: 5cce6616-ec0f-47e6-faab-08de0c72f581
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|19092799006|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WGRwT0RGVGhNZVQ4bXZjeDNOR1ZkQ1Y0SDBGRmExYnUyazEvRVVYQUhZWlJI?=
 =?utf-8?B?NG50dUg0Wk0rQU93RTEwcTBzMzZ3VFo3L1dSNWJHcTY3aDFhTjZNMUhGa2Jt?=
 =?utf-8?B?RjAyUGpZZ3VQcFhnVzBGRkRmYjVYcHQ2dDl0aUttMDQzcURkdWxmYlBMaWVK?=
 =?utf-8?B?Um9TYk9kei9nc3ltSE1RNEpSZ3QzS2l2bEcrKzRRK1o2eWc2eTZuT1JXOWFK?=
 =?utf-8?B?ZEgzeE1hL0hqa1RzZy9EVzBQQWd5QUJoc0JDckhwV2J3VThoZ2E4K2tSaU5t?=
 =?utf-8?B?SXU5a2lDL3AyTzRyS2JDN1lPVVp4eE45RFNOR2NZVmE2ZXJ5aW9JS1BuWDdw?=
 =?utf-8?B?S1FjQjBQL0RhSHhtT1c1UHAwaFBwM3ZmY2tJLzBJV0huVUtEbURENWJmWVlm?=
 =?utf-8?B?c0VwZGsxZGEvaDVsVG9VVXYwS1JLVnFRVmUrZVhnSmFSYWRmOHJFWkN6M1cz?=
 =?utf-8?B?MW0vRnROS0Y2ZEJ3U0RPL01mQWpiQmV5K0xaNFQyZWlwZ0ZncC9aUWJvZGE3?=
 =?utf-8?B?VkEzWGVPTWxEeVE3WmZZZURqRUtIb21Xb1JjWjU5VDBPcjF0QTlHWHZNVjNX?=
 =?utf-8?B?VkZ3YjN2N3hCR3ZuTVM3L2JQSHA3UUhCaW1EUXFVQkpKME8rKzF1NmpJbXJE?=
 =?utf-8?B?Z1V3Z3ROT2dwL0kyU2d6QWVsQVFOK2VZcDQydVh2Vm5vZncvSkZSQ28rNDFZ?=
 =?utf-8?B?cVRrOVM2RVgwR1ZWYXlybGJyZzdNMldkcjEwY2RUNlFiU0tGYXZJaVB5em5F?=
 =?utf-8?B?ZHdvbUR5MW90bXlkc0FPSW9aS0Q0ZEZCMXRLWTVKVGpkUC9EWlkxN3JQUUpr?=
 =?utf-8?B?MEJDVkFOdEErUGlQcUlTdzhFWHVqbmhTbm1nZ25CQjNBQ0o1a1VWdkl6ZWE1?=
 =?utf-8?B?MjFhREdRL2NFS1cvUDFvOFl3WHVFVUQ4MnN2RHBUMUFEeG11d09Ca1BGdW51?=
 =?utf-8?B?a0ZxOElrYmN1dGJkSDJ6djhCOVlqNVhCK2hXeEREOXl4aW9lSmxhM0l6NmJn?=
 =?utf-8?B?MzZISHdibzAzVyszdVIrUGR2a3Rtc2orWGt3bDBmaGZWVW1CMllsUUFNOVJj?=
 =?utf-8?B?cHRmOHlIcGt4K1JXL3Z2RlZyZ1cxaWRLMTk3WGJySHQ5alhudHNyb2dmSWtP?=
 =?utf-8?B?ZWlEUWhGZS9DMkJST0RBTWR1UDZqRzVGd3pBSTZiNXEvVHowL1VPbm1ub3dO?=
 =?utf-8?B?OXlrSFZjbGZzK2tzRFV5WndFRDU2TDl4WGNsYm9UWTNvaTM1OFNqamZ6R0VZ?=
 =?utf-8?B?Wkd4YWJNeGVGOU1nMnNWQm5nREpPSGFTUmY0MmV0OGwzRzg0SmUwR1pkUXF6?=
 =?utf-8?B?aXVJUE1jM0FuZUtGVGJ5RWQ3TXcxZ2cyUGdvYTN4b0Z2Ujd6c1I0WlFqbnRE?=
 =?utf-8?B?VHIwaHluSDhOVS9iek03V3hiVGg1bFNzUGd3UE9HbFduT1lmY1c2SGxvdE1G?=
 =?utf-8?B?SGQ1MHNUVVNGSzJOOWFRdUpaQzlWU1dOZCtFRnNES1dBS3ZQRG1EU0xUSGd4?=
 =?utf-8?B?WlNOK0VaM3JVeERmblpwOGhNbWRwY0VGVEhudmR6bHZNTGZwb3hJYm5sS2Qv?=
 =?utf-8?B?YmtIUHhPOFJ0U1dGRURjZmFmSG8xbVQrbHBxN095cDF1U3QxYXBvMlZvQ0hl?=
 =?utf-8?B?VWQ4eWRkU2JLaGYxb1h1MDFmbm5WZjVMWjJPTVVXZW81cjZtbUtQK0Z3dHFj?=
 =?utf-8?B?MDV6ZjBtR2hIc0xGZXRxSUgyR2pXTFJSa040Y25zV0dyRGoxRWZhY3NZRU5X?=
 =?utf-8?B?VnVLV1dyRlk4QW5Sbm8rbEU5M2dLNURRRUUrNjRjM1NOR0svRmVHQ3ZjVVh1?=
 =?utf-8?B?cTBqem9iTXp3Yk9GeWxNNG42TUlDdkZRVmQ3SE82TzNzSXU4UDFnMlk3TERH?=
 =?utf-8?B?NmtiVVBiSkFuTXExN3NGZnlYUmphMTJvVldXbFR4cStNMVhkMkRDa1h2WWRp?=
 =?utf-8?Q?kn1lgNekQhp4KeG1oO13C3fluqDxR/gV?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9328.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(19092799006)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bU9mUEJ4NVNQNUkrNVJtTENVUzRBeW4rcm1sdXpFd0g0UkRWYkV6S3pnczV0?=
 =?utf-8?B?VWRnWDJPeG5rSXJSTlVETEUzYmltc1Z6dVVZQll2MjlMam91RzJyV3d3azNl?=
 =?utf-8?B?bTAzOG1lT000WUFuTWFQV29jeFJSKzV0Mm81cFUvVVRoNkRwZHR6b1ZTQWNU?=
 =?utf-8?B?MzF0VURQTTl5T2pmVk9OcXJJL0g2VlBXTG1LMWxUeWhtaVlKTWdOK3gzZGlQ?=
 =?utf-8?B?TGV2SFJMMTBYQlVVa3BPVFQ4K3JwMDRtZ0VSTlhzK2RHOUlBRE1Dand2VWVH?=
 =?utf-8?B?NWN3L1dvaVpQemNzb0hEWWdUcExVU0xSWWNldExmN2lnd1lON2I1LzVoTjRL?=
 =?utf-8?B?ME1vZ0d6dG92WVdpeGxDaktMZW1uMEpCTlJUakRzaUswZ2c1M1VtS3pjTS9h?=
 =?utf-8?B?L2t4eW9ZMkM5ak9VZnExL2NtMDdQL0FNVHQvN2VGNTlZYVM3OTlTNXlvcStD?=
 =?utf-8?B?NG1nRDNSRVUzeVRWTVFjRERjQXdWSEhVTGpiVWxmb1diUFErY1BaRnVwYVBB?=
 =?utf-8?B?Z0g2UEFQa1VzSUFCb0dGbFE5MG45dk9mMjJzUGVKUGV5alA0aXUwajVLZXJi?=
 =?utf-8?B?aHBWdERPeW1tZHE2NDFzbmg4UmF4Z1FkU0xKeVVTenlaL3QvaUJLcW1NRXY1?=
 =?utf-8?B?TGwvZHcvcTNhY0YxZEhUL0NoVG1pdkJaanVRWlFrSjJIME02RlhtSzRJV1Bj?=
 =?utf-8?B?RlBnSUVMa2k3S3YyUm5FbGxLSnR6UGpLMmJrL1lqd1grWVNvSjJWRmlLN2ND?=
 =?utf-8?B?azIrT29uN1JyNFhZU1NZTVdVREJOYitPeVpMSnpMd1ZKd3pGWTFkRHdVYXdu?=
 =?utf-8?B?VXVQL0d2ZGtnaFU5N3dXVmswVWw1MGk1d29RWFhReWMwZjRqWmE1VjJSb25k?=
 =?utf-8?B?YmxZMHFlYmxFZjVsZWZNSmtkdjBFTTFWY0V5OURESjV3UUNROXhodTZyYVYw?=
 =?utf-8?B?eVV4M3krNURra1QwT1NZdk5ROS9ybW9qUWt3N2hxOUxCZXhNQ1Q2dHRGbFJQ?=
 =?utf-8?B?UzNBZnJzTU5DcmVaR2t3MVVXNlRyaGh6ZjJtQzBOVXNEcWE4NXowRVVKQ2Jk?=
 =?utf-8?B?NTh4aEJhN0VOUVJRS21KVXorUGJKWUVoQjkyNGo3bzVibHY2K3RnandSNHZt?=
 =?utf-8?B?WnhiUERrdUNCYm9CRm5aTWt4VWt2TXgzMWYranRudER3TUM5b1dZb09Xd2t1?=
 =?utf-8?B?Sjl0VUlzZDFRRG1icng4TEZKT2RsQUErcTJ6eWpnamN1ZEFVL0RNdTlLbUxO?=
 =?utf-8?B?N0FGY2E3eFduaWt4R1RucXpkMVZlMGk4aUMwVFVYM05sQmRBMENhRmxBMjNW?=
 =?utf-8?B?MUZRSHVlNjJLM0s5WlNSdkRyZjh1OG9CNDR6S2lTUjVOZ3BNdVg5RGE3OTA2?=
 =?utf-8?B?aWhaMUJwY0ZCbjJ4Vnk3VFZZSklpNDVVL3U5ZUpxN3hpUnUvRHRva2VqNTVD?=
 =?utf-8?B?QjJSUDdaUHYwWnJoRlVIWmZ0T2dJdGZoU3hhVzZWMTNDZ25tNUsrU2p6VmI2?=
 =?utf-8?B?OGJBMlJuK093WlVHZjQrcWw1ZDVOVnBJNUFTN0lGQ2d0Zk5YV1VCditvZ2lo?=
 =?utf-8?B?VXN1WW9RVERHSWxvbmdGWGU4T0FXamtYbjd2QURwbGp1ZjlYZjRSVU9WazlF?=
 =?utf-8?B?SHZtZWM3Nyt1SDE5MFkvbFVCU3pCekxJRzJEQVJHRkZBb0JrYjlySTNQQXdZ?=
 =?utf-8?B?Tmd0Sk13MzJLR0Yya3pBRWVQY3o3ME84SjNhWFdWSEc1S2Vua2NtZ2VSMThN?=
 =?utf-8?B?anEyMmIwMVlRWUxJdUxzandYY1dqeWRIZDBFTkhxUmpNRzkzTmNkWmVSNnpt?=
 =?utf-8?B?NnRpekc2bnc5a283NkkvbFEyOUg4Q0czSW5MRnYxSmtseUdDbjN6Q3lNcFNs?=
 =?utf-8?B?RWU2SjN0bGQxRWYvN1RMeS9YM00wRDNVdGVDMFg4MHc2aW0vcmkwVng3Uzli?=
 =?utf-8?B?Tlp5a05WdFcvbEUvakV4UEpYdUxDY1MyWWpNdDJuUGwyQ1RGTmxpK1VXdGt6?=
 =?utf-8?B?bkYrcU5lSE1wcTFOK24wbEF1OVI2SkQvLzhBWnNWUnZTeDBPa1E1QmMyc3Jl?=
 =?utf-8?B?NUsvQ1NFa1dPbTNHS3pvdnlPeVk0SkswRTNUWG1UUG5FakZIK0Y0UWRleFBK?=
 =?utf-8?B?OWNSRkM3aVlYMzY2SVdnalRaTmUwbzZVTk1vTVUvN1B2ZFpxOG1LZmdiM1Vi?=
 =?utf-8?B?Smc9PQ==?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cce6616-ec0f-47e6-faab-08de0c72f581
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9328.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 05:15:02.2413 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hFCuzz8Mg1aSWUASmq2FZLf86IEZQOwps0SDzm8YzYKgoXi+8Aez/HCRcdxMztbYiqnZf1g7JuJuADSBAj9pSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7029
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


On 16-10-2025 04:37, Stephen Hemminger wrote:
> The table wriop_bytecode can be static to avoid name conflicts.
>
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>   drivers/net/dpaa2/dpaa2_sparser.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/dpaa2/dpaa2_sparser.c b/drivers/net/dpaa2/dpaa2_sparser.c
> index 0b3e9f1920..6c3e6eb573 100644
> --- a/drivers/net/dpaa2/dpaa2_sparser.c
> +++ b/drivers/net/dpaa2/dpaa2_sparser.c
> @@ -23,7 +23,7 @@
>   #include <stdint.h>
>   #include <inttypes.h>
>   
> -uint8_t wriop_bytecode[] = {
> +static uint8_t wriop_bytecode[] = {
>   	0x00, 0x04, 0x29, 0x42, 0x03, 0xe0, 0x12, 0x00, 0x29, 0x02,
>   	0x18, 0x00, 0x87, 0x3c, 0x00, 0x02, 0x18, 0x00, 0x00, 0x00
>   };
Acked-by: Hemant Agrawal <hemant.agrawal@nxp.com>

