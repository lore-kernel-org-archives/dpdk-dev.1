Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 640EBC369AB
	for <dpdk-dev@archiver.kernel.org>; Thu, 24 Apr 2025 14:26:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4B26B40156;
	Thu, 24 Apr 2025 16:26:35 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazon11011047.outbound.protection.outlook.com [52.101.70.47])
 by mails.dpdk.org (Postfix) with ESMTP id 5FBEF400D5
 for <dev@dpdk.org>; Thu, 24 Apr 2025 16:26:33 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XwoJOGMbJmBwmso6q+PkZt56YP4u+HgzaowbX/9L8og5eaQ8SkIW75PqttubraqJabdqCm98Dm3mOLRFDXMDcKXjH2QndlnxskNYrWSx7fPQTEtumVpJG+0SNtmD4KrhwknBLS+MMvS1eLgSAw0B3kMpjMXEJSc4cAT35GuYoUnc3XX8qhmr2E9eX+07yddmYRAOBMu8cCWL2Vr2qvy1KpUSuvFTBOXz8nPdjej69LA388l3wEulxoOob/awXeEXjturTfAs/xa5J7DkA10Q9eWlLG5+4CtdNxWQXGu6Z9iaZpJGfVER/wS3zDp+PGGo0tS0ISezkc71Y3hFwzZD2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SwsCA7LOtdxfEm571mFerpqWcsQpQTDSVETqt/pYc/8=;
 b=FwDIkYCGYKw3EZEK+9X/Fql80TV6GPBLSq1VrYWE4uSjdUK59xs0wcTlt/ZsraoTak2rWDo9nRy3+GW0Jfgx8dGPPBnCM8XpPXwSga6TdCQ/fG9+84itsNTs5a66uRsX3sBjADMMrXJKf75vscGlui1o4VJ2huRsZTXkUTHr5zA+d643K4svz14CLjBIdfj+nUickIBJhpHTmgjhBNus7tkmfDLncFuBLSpNXhoLoGSISSATbE548uSWCfsS0MVAmQP4KrbdVMmw/P33aoS1fNC59XzMzVpdIeeEYkqBSvolIgFZV6LKqpH6LAPElLfL+aB/LA50UTZJt99afUc1LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia-sbell.com; dmarc=pass action=none
 header.from=nokia-sbell.com; dkim=pass header.d=nokia-sbell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-sbell.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SwsCA7LOtdxfEm571mFerpqWcsQpQTDSVETqt/pYc/8=;
 b=bwYI0kNOuL6yo2I9wETBQ+/LvdYbV7pKf3woF6TJWf1dTrAxuQrkQsQVg3lMyYmCOoClEdHcPpyCP1zDdYVaQayytjdoKfA0YXemKkj05AKMP9UkiutZBcK9im1zT+fr2WNCydTbI3NKMifxEZ0/+AujoztlyrGR0zy4rJiljvxQx+h9/CrhL8g98D3zBaT154oaBYfUk2re2KsmbRu9vUGklEBcCWGfmPI7kUK+zMtphFeXCzImFAE4qx4wsSFmHhzcU4KQd9ma6uoOEqkzhu8yCXe5pmEOTf7EnHBQLsXuMGX+4dcFmn1eT3PUBXFuEQ2QsgvFP/jhjeFC+whtPg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia-sbell.com;
Received: from DUZSPRMB0009.eurprd07.prod.outlook.com (2603:10a6:10:4de::20)
 by VI1PR0701MB6960.eurprd07.prod.outlook.com (2603:10a6:800:190::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.35; Thu, 24 Apr
 2025 14:26:29 +0000
Received: from DUZSPRMB0009.eurprd07.prod.outlook.com
 ([fe80::4042:54db:db1f:139b]) by DUZSPRMB0009.eurprd07.prod.outlook.com
 ([fe80::4042:54db:db1f:139b%3]) with mapi id 15.20.8678.025; Thu, 24 Apr 2025
 14:26:29 +0000
Message-ID: <6d31ea07-8bbb-4e9c-ab88-be50e0132e31@nokia-sbell.com>
Date: Thu, 24 Apr 2025 22:26:23 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] crypto/ipsec_mb: fix QP release in secondary
To: dev@dpdk.org
References: <20250314103638.2198-1-ming.1.yang@nokia-sbell.com>
 <20250407052532.1913-1-ming.1.yang@nokia-sbell.com>
 <20250407052532.1913-2-ming.1.yang@nokia-sbell.com>
Content-Language: en-US
From: Yang Ming <ming.1.yang@nokia-sbell.com>
In-Reply-To: <20250407052532.1913-2-ming.1.yang@nokia-sbell.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0043.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::12) To DUZSPRMB0009.eurprd07.prod.outlook.com
 (2603:10a6:10:4de::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DUZSPRMB0009:EE_|VI1PR0701MB6960:EE_
X-MS-Office365-Filtering-Correlation-Id: 6880e9d1-5a96-4897-19db-08dd833c010d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bGpoM0JoQUgzTFc2ckRJbEY5b2loOTBwUURNMmYzOEUvNTRiSGdjWDZvK0k4?=
 =?utf-8?B?L3NlS0FrMjFqeG5WTDVaNW90a3ZMSExOYkNSK0hzMWtQSGFRY040WlV3eWlh?=
 =?utf-8?B?T2kxT0hlWTVueVBlcEQ4bTlNNWRXT0tIY0l3U2FwLzRiTndwSzlISTNsdzVx?=
 =?utf-8?B?NU4xU2ZTbXlBWlBhZURpWkVELzZrUnRXS2NKTUdzYWs5dmlUdSsza2VXUHFp?=
 =?utf-8?B?VDk2STJ6NkJFNUllOFl1R0tXa0ltamgwV1pGcys3ZytvQW04MjlMNmR1aVBY?=
 =?utf-8?B?NlN1eEZSZW9Fd1Q2dFIrdTBtaUF6N2dkR3RiRHI3MmdkT3N3VHNRcTF6VGxY?=
 =?utf-8?B?MktGKy9xT0hKd2JZbWJCS3htQXUwR1VCS2Q5bWg4TVJzWFlqM1Z2M3lsVzVU?=
 =?utf-8?B?cTFLODlrbkwxT2FQWWZGSlFvcVNUYTIrRmJJaXVFNUJsWVlkblZiZzVyZzhk?=
 =?utf-8?B?MGRWbnF3WU02YlM4Y0Z1OVhtdEdpckZhRUJWN0xiRWtJaFRBWk45eTBkdmxM?=
 =?utf-8?B?N1dZRmRTN3BKcGhvNXlTVVpnc1lmeTNtK0dGTzhBbjFvYUdHOG5CWFFaY2Z1?=
 =?utf-8?B?ck0xN2UzWndMdmJRU3MwcVRhZU05U2cvOHpZSWZOVWw0L1d3eUk1UlQwbXJZ?=
 =?utf-8?B?Uk5GT2hPVGJUU3VvZWFnNjRMcTkwNXRvYm5yZ1o3dUUvc1ArT3dYV3poTVhN?=
 =?utf-8?B?Q1p0RU9XVVRIbjJkamNJRkJPczNFZ2NwU1hSRVptdFZhRi9YYWpveFlVa01L?=
 =?utf-8?B?SUw0UitsOVhTRnlObXM3SzdBa3FHODVRWW4zZlZyQjFJU0IwVzBuZFFZaXlO?=
 =?utf-8?B?b29NUlAyZW1pR1F3T2tRd3R4Wmp0ZVhrOXVTVkdxOFFOU2ZYaDZaMjJJSzVT?=
 =?utf-8?B?S0dZOFZqSVNGMTRkZ2VnamF1M0c0MjNsazNjMU4yaUN6TzR2Slk5Z1lqSXVZ?=
 =?utf-8?B?aFo1a0UyN1JsMlhZK2tPVDdLUXJLRWFvWkUyR1dKd0NkSlE5aUF4TEVrL1JF?=
 =?utf-8?B?QzVnSTROVFgzalRLaHVBRDlZZEVrN1p1OS9aOWpkTlpSaE5wcHlyVzV1Q1Vt?=
 =?utf-8?B?cUhaa0FMVlRGNHUrMWhaZFR0UUd3UC80NlptMUcrU2hqOFhtSUFqKzhmVWts?=
 =?utf-8?B?WEIyM2RQODJmR2E4S0tubTNIcWFXSDVKMXVONVJEVXZOdzFsdUkrMnc5c1JK?=
 =?utf-8?B?ZjhXT3JScStqZnJiVjVuaDBXd1FOWjNuR294N1J1eUUyS3oxc3h6WHBLRm5M?=
 =?utf-8?B?WldkMVdDN0c1Q0VHVlVYUUJVcjVSYWI3OCtDeU5tSzJIOFgxRzFHeWRGWGRv?=
 =?utf-8?B?WXI2UHJmRXdFVG53b1NsNW52S3E3M0hUZ05RbmZ1WUxxMU5FRE5QL2c1ZzlO?=
 =?utf-8?B?UDNJMmpCY1NRNDR6eUowcUJwNzZBNzAyTU1NbER1ZzJ6WmsyU1pHaXJNeEh6?=
 =?utf-8?B?VXloeXFZdnNYcm51c0FFZU5YNG1nMmVRRjZaV3dNRHBteGJVQ0lac0NHMXNm?=
 =?utf-8?B?UVRtU2wrZWNvMG9LMFkyMjBzN3U4a01sWGRVWVJqYkZNcmxQakVxME5Qdi9Z?=
 =?utf-8?B?QmtmTnl3ZjhpdHhyY05XbWJEQ3FCVXNnZFdldlN3V3dsZjE2ZmxwVG43TGhx?=
 =?utf-8?B?U3JRTGh0MnIvQXlJb1FSRzY2TnZTYlNER0EwYXBZV0ZqMmpKYVVlWk1sVUFi?=
 =?utf-8?B?Sm9TeURaMEhUaUxSZFp0YWcwLzkxL0c5VHlLdVJqWDlqZ0ZGR1A0ZzhpMVYz?=
 =?utf-8?B?Q0JXbWF6QmZFZkN5cmw3QjdKTDA0ZE5yYU9vOEI4YUFMa0VYcjVPNFlIb0tx?=
 =?utf-8?B?OHVxVkFTZ2FSS2k2dy9yNmNwRkVlTVBFV3lKVldDNUZZSnRCZ05RRGZjclVR?=
 =?utf-8?B?cHlQUmFzby9XdWZKTWZJVjcrTEIrRHRpNHcxME1WaUY2VzA4alBuOWxXb3pN?=
 =?utf-8?Q?eCtjZOZpIiM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DUZSPRMB0009.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OFVUdkdsWnc0cHlpdXdzMkFsdWozb0hLeHB6cXZZWkVVYWNtRTkrY0xsdTd6?=
 =?utf-8?B?ZzdvRmdPTjQ0MmRIbVNXS2QrQ253L3l4M1FDU3Z1ckM0SWJPNXMxSnNQZ0Ny?=
 =?utf-8?B?V1FGcnp5cEowRkdteHlsaHJ0d2Q4aEt2U0JLbllVeVNzNUdOYVF2bG5ZVVkv?=
 =?utf-8?B?aGdjWnVmck5BaWZBbFlrWWFPVnU5QlZIQUoxZnNnRURrWmhPZm1jTWVoOWZv?=
 =?utf-8?B?bVV1emdkMFhRWkRKaWxKZ1J5YTM0cXBvai93OGZNbnJHMm5XejcyOGhMaXpu?=
 =?utf-8?B?NTY2R1ZkRndrLzVMYU1xVXlVSXhCTm5mMWhoTkJ2SkJ3ZHVERnRnRUU3RUl1?=
 =?utf-8?B?eHJrVXYvbDBEVVVNMDcydEt5RElINXFJb01BeTh6dkxBRGNnR0pkaStCOS9F?=
 =?utf-8?B?eHVKRkU4Q0RsZ3h2K0hOUlZ5U2l4dCtmVHk5ZTNtVGNOOEdFcUZLTitNMWRG?=
 =?utf-8?B?eWg3L3k2ajlEVmplOEhMVTNHcWFTczNXVjFmTkllVzMxNS9WUmV2Z0ZGVFlk?=
 =?utf-8?B?SlM3V2orZnV4eGxyVVFjZDdsYWpqSWwrTE9RNmN5SEsraUVXL0l4Q0ZWK2wv?=
 =?utf-8?B?ODFGVlc5Yk9pcDNkUTRjZ1ZuSTkvb1dlcE4rNGlpcG4vOEFLOTUwamQyajhW?=
 =?utf-8?B?WituQlk2d0VZQURqazREa0dkcWNBLzd2Qk81bVBUa0JLNUFtVGZYbkdhQjRt?=
 =?utf-8?B?YnlYK0VlMmxETW80OHBNMzV3ZHpGaU9Mbi9aT3pjNlMrUk12ZWVUaThFaHVj?=
 =?utf-8?B?WkVPelh6STEwaVY1dlpmekhZblNLekVXd1BBNlVkeVlBOXdrZXAydkE5V0l5?=
 =?utf-8?B?VWJVNnV1RU9LaXhvRUtYOGc1UCtjRmVDTUR4MUFRL0tvUXZ6S2V2R2QzWERU?=
 =?utf-8?B?VHJRbkVIaDNubEVtNXE2QzFuMExpWGVBSkdUcGNUSjVJdUZUVjdyOHQ4c1NC?=
 =?utf-8?B?aEs2bWQwWjZwWGR2dUpTalA4N2QyZkd2MStLcCsrWFBPOFo1ZVFIRjdqL1B6?=
 =?utf-8?B?ZGN0OU5Ed1h4OGdyRlRKNzhjcEM0UHg5d3BqTkxaMjE1REVnT3l6Q0JzWVk1?=
 =?utf-8?B?OHV5S2psSDBwRER3K0xlaWxzK3JyaHBYS24xZk5FcmxZM2wrNjhZWEJGa09j?=
 =?utf-8?B?MmY4R3MwTHZDWXBOUURwbWNwTzVCQzlNWnEzNWxwZmFoeGdPYlpoRnJmL3hz?=
 =?utf-8?B?M0RzeFcrQ2pTUGF2Z3pYT1lKWllEZVRJNGRnV05IeGk4cUpiVFduZWJHUnpT?=
 =?utf-8?B?Vm1ueXhqMEdBMUhZZTc4bEIzQ1lGOVdRSFFDRzFXcE5JdzdGZEdhcnZNa0JT?=
 =?utf-8?B?SEtjRHhPUkp4NXVZbFF4MmVRQWQ0SHU3K3hQZmhITXZWRkI1a1dOcGxYVndh?=
 =?utf-8?B?cTkrZlErY2ppUTJ1akhTNzFUbENnMm9yNGF3V3Q0NFZoSFJsSFpFcDZqTmZx?=
 =?utf-8?B?R2NnWXpmVUk4cWJFKzlrYmM0UHNkYlZDSTl3L0pndFRxQUhCOFhtSTUySUc0?=
 =?utf-8?B?eWRHUnd0MFpJcExqVVRHUGVPd1hoeTVsNk5XUlVRMEpwZFBOdXJsNEt5NmVV?=
 =?utf-8?B?NWhINEljeVY5NXd1Q0trWWR0QVNoTFhCT214Q2g0Ri9ldEtoRDljdDJyNlJS?=
 =?utf-8?B?MXlXaldXbmpMdkdUN0hRbUlweUhVVUJMOXpvWGRDNU5CV09IdnAwTGVaOXUx?=
 =?utf-8?B?Q2QxcFZGRm9HVmhRMU5aZEhQb002NHFZSFREb0lnYzRGc3lkVzYrd0xaZDNG?=
 =?utf-8?B?OWtyOVE1dG5rODhacGVDWHpXTjFaV00vMlFiV0F3V3ZGbE5tazJweEVrb2sr?=
 =?utf-8?B?RUlSNjJ0blE4WHAvYTBMc1VmVVlOeXBtUVh6RDc4VWVSU1JuYWJZT3I1OE5J?=
 =?utf-8?B?eHZWcjJBbzZ2cXZBYUdqd3UyRjVLMUV3cFppMW9wMElYcDVnSHZuLzUrQTF0?=
 =?utf-8?B?L3oyR1gxOFgvVDhmT0cyQUdrV1AzNDB1amw0YzdPSUxqN2tzOFdVM1VITmNR?=
 =?utf-8?B?UCtVUkR6WGFiNGFmamppTTMyQXJSanE4UVozNm13R1R1YndmZmxGd1VhdnhH?=
 =?utf-8?B?RUlHZGV4RnQwZWZJTGdGSjVmdDkreWdUTm12Rkp4dmIwbDAvK01UMHVVWktV?=
 =?utf-8?B?a29jVTlqU3lJYUM0VlhOQUR1d3ZPWVkzdStVQVNsdXhjVFNXcVFyZUZqc0hw?=
 =?utf-8?B?dkE9PQ==?=
X-OriginatorOrg: nokia-sbell.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6880e9d1-5a96-4897-19db-08dd833c010d
X-MS-Exchange-CrossTenant-AuthSource: DUZSPRMB0009.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2025 14:26:29.7941 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MaIndyTQz36Q2l5VpOh/udPIOzza+13hD2l2d4F+3D8NVB50rwhdZMgvnH8oPitx4K891giJn41GlwR38yenH0IDvnXklOEp+aHeC6wtOt4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0701MB6960
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

Hi,

On 2025/4/7 13:25, Yang Ming wrote:
> From: myang <ming.1.yang@nokia-sbell.com>
>
> When a secondary process tries to release a queue pair (QP) that
> does not belong to it, error logs occur:
> CRYPTODEV: ipsec_mb_ipc_request() line 373: Unable to release
> qp_id=0
> EAL: Message data is too long
> EAL: Fail to handle message: ipsec_mb_mp_msg
> EAL: Fail to recv reply for request /tmp/dpdk/l2hi/mp_socket:
> ipsec_mb_mp_msg
>
> This patch ensures that a secondary process only frees a QP if
> it actually owns it, preventing conflicts and resolving the
> issue.
>
> Signed-off-by: myang <ming.1.yang@nokia-sbell.com>
> ---
>   drivers/crypto/ipsec_mb/ipsec_mb_ops.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/crypto/ipsec_mb/ipsec_mb_ops.c b/drivers/crypto/ipsec_mb/ipsec_mb_ops.c
> index 910efb1a97..50ee140ccd 100644
> --- a/drivers/crypto/ipsec_mb/ipsec_mb_ops.c
> +++ b/drivers/crypto/ipsec_mb/ipsec_mb_ops.c
> @@ -138,6 +138,7 @@ int
>   ipsec_mb_qp_release(struct rte_cryptodev *dev, uint16_t qp_id)
>   {
>   	struct ipsec_mb_qp *qp = dev->data->queue_pairs[qp_id];
> +	uint16_t process_id = (uint16_t)getpid();
>   
>   	if (!qp)
>   		return 0;
> @@ -152,8 +153,10 @@ ipsec_mb_qp_release(struct rte_cryptodev *dev, uint16_t qp_id)
>   		rte_free(qp);
>   		dev->data->queue_pairs[qp_id] = NULL;
>   	} else { /* secondary process */
> -		return ipsec_mb_secondary_qp_op(dev->data->dev_id, qp_id,
> -					NULL, 0, RTE_IPSEC_MB_MP_REQ_QP_FREE);
> +		if (qp->qp_used_by_pid == process_id)
> +			return ipsec_mb_secondary_qp_op(dev->data->dev_id,
> +						qp_id, NULL, 0,
> +						RTE_IPSEC_MB_MP_REQ_QP_FREE);
>   	}
>   	return 0;
>   }

Hi Experts,

Is there any chance to review and accept this patch?

Brs,

Yang Ming

