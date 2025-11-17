Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74EACCEBF61
	for <dpdk-dev@archiver.kernel.org>; Mon, 17 Nov 2025 14:01:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 41FE740262;
	Mon, 17 Nov 2025 15:01:19 +0100 (CET)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010039.outbound.protection.outlook.com [52.101.56.39])
 by mails.dpdk.org (Postfix) with ESMTP id 5A0ED4025A;
 Mon, 17 Nov 2025 15:01:17 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZmMEiWE2BiI9t6R68vQNN1AZ9+vd6/eHz1VFCoWIFliDT2wKBJD8uVyTLDGZTXVRfdQCwAJ6koMKPdOx/NI8FOsXZBjymIld3RHBYL27H+ZGGg0Akx3ALyQkTc/J54W5qIb8kzQSZIGree6ySjUY0drJhcUKMSDTo8KbcKthNmtPvpPGt3mZlPTzmrTFXHu2ao4CwZR4sfXHOJgpCquhpUNn4pwblmJs/8aibiK+XTX+gQzERZHj6s/nhIZ7d/VDiUri93xB4vf0PltOHlJivrlgyJyuwcCjf1IlApJ5AOdhBqm3mJxaZy73vLyKRacLocJgIsCc+na97DixWuDUCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zODOhjK3sK1rkGERyXVF607TQ2Nlc8NvqX+k8e0J/7E=;
 b=dRcNZiTaRRZCzioUBB0WlocUPsR1W0zns/yL9x0/vQs3QDHyfgf426/DTTXun9FrfPUg/wAyJ/pzMF6+hNjj2aMoqPlqCec5mPGukHcRBmS+01FOh0x124yeVQnxfB39Ba7TeWTHNF7dzCqAFSUdtKUugw20iYeJZjWKOxf50YnAH33Vs3rC0UiOIcWS74DQu9vDHh4fVRF26nlwgVEycLHmO7cOa9/zaf1b9I+K2gt90hBrIKyiwQHPFycytE12VtYCQMIi337E+cOZAqx2YqqqU075npSpHYtCggmDi+MLSSiqbe3WeW6Lb5gS0jy8nnWLEZeAu/W3BXPWMq4qog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zODOhjK3sK1rkGERyXVF607TQ2Nlc8NvqX+k8e0J/7E=;
 b=lMvltTK9llEdOOj1Cy6Ka9mVtrnUi7Ek0+KplHDMDK2FH3HnHYpHvO9hWH++mCmgwpFprINrYHNF9VfqY/yV7PmYBBblB9hpa2yOyyhSpKLGxOKE6j8PAFNEjLHPx9JDyzZG+wg36QJYcCkXXnH90bFB1YWFi7YbcGdcRdrBvyf7TozBsGalDgGo6vi0AL1iwM8ow8KtZqTnz4hN9I2MATwqKRb77UiEw/jeR6oONx79DBuW9/1X69XHHVSXcZq2XXFKeEk+CQJZtjcR8aM8sOfZ+WmHhDnT8oaXx3QS1D8LGfRXJTt4eAnHM2ad9tobvfVHZhAyxh8bXtnsOYofAg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8460.namprd12.prod.outlook.com (2603:10b6:610:156::15)
 by CY8PR12MB8412.namprd12.prod.outlook.com (2603:10b6:930:6f::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.18; Mon, 17 Nov
 2025 14:01:14 +0000
Received: from CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5]) by CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5%5]) with mapi id 15.20.9320.018; Mon, 17 Nov 2025
 14:01:14 +0000
Message-ID: <35424992-4e2a-4b3f-94a9-b8838b116b45@nvidia.com>
Date: Mon, 17 Nov 2025 16:01:09 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/mlx5: fix state corruption in dev start error path
To: Maayan Kashani <mkashani@nvidia.com>, dev@dpdk.org
Cc: stable@dpdk.org, Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>,
 Ori Kam <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>,
 Matan Azrad <matan@nvidia.com>
References: <20251113193711.7883-1-mkashani@nvidia.com>
Content-Language: en-US
From: Raslan Darawsheh <rasland@nvidia.com>
In-Reply-To: <20251113193711.7883-1-mkashani@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0004.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::13) To CH3PR12MB8460.namprd12.prod.outlook.com
 (2603:10b6:610:156::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8460:EE_|CY8PR12MB8412:EE_
X-MS-Office365-Filtering-Correlation-Id: 5eb16d94-e195-4557-8094-08de25e1c550
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VmtVSFl2amVRZHlsb3JkZGthVlJrelRkNC9OV0wvb0F2cW9QVmxlaVJmTVRj?=
 =?utf-8?B?Vml5a3pGMTdVVWZmYzdhY2dLYWUrbkt2enpMalRDQWdEVEtLR0xFS0FHdTF3?=
 =?utf-8?B?aHZlU0g2TiswMkNYWFd6eXBwTG5WMkVOb09FLzhqQTdnOFROcENVaXlxdXJp?=
 =?utf-8?B?NG1RK2szSStJbDIwY1pwM2tvTFhLNHNKaEo2Q2xXS1ZteTdPejVLM3FIRVcw?=
 =?utf-8?B?TFQ3OWVZRmsxMU1MRjJDVWhjK1JVSkg0Q1g0emlydk91Z3Y1WW5xTFlQeGM4?=
 =?utf-8?B?OG1sMnlKdmFhL1F1WW9Bck9idkN4bkRFVkd4VWVLWlFRYnhNejh5SVZDSmJo?=
 =?utf-8?B?WXlscGt2amtYNDR3alRoV0ZPWDNuaDRTRnJxU2RkZ0hXaW9Ha1kxV3J0YWR1?=
 =?utf-8?B?cEl1cnRpWUg0R2EzajhLbWxnWHNYNXVoOThTN1V6MCtsRjJJVGhxWStzRjAr?=
 =?utf-8?B?bVY0TlZvV1c0N0xJckVJNHNqcStxSWcwOE90VU1kQ2ZseWNkQ3dBb2V2V1JR?=
 =?utf-8?B?TlJyN2F2QzUxV3Rud0NvcFA0eHpZWktXWVk3Sm83NzFzNHVza2RRVTF6eklW?=
 =?utf-8?B?L1A3WkhZVTl2Qjh0U3pNMnpwUFlhL2N5bitCc0hjTFQxT0FLVXdSZVhibkN3?=
 =?utf-8?B?a0ZrbTJMNUhVNGNTL0hsME5manlOSC8zaHEyM3puY3RReUZSWmp2Q1BHMFcv?=
 =?utf-8?B?a1c3bHp3djVaSmo3S0NmK3RSeUpBcGVzZkJDbkRxN0NYT1VJSU1nZm5MTlJi?=
 =?utf-8?B?cVltdTYwZnp3QlkvNE9oWi9CdHNPT01CMmQvVjdaK1BldWxBNGJoQlI4STBv?=
 =?utf-8?B?L09LWFVrN2lzRDV0anh5bEZtdEEwektnUmxsTDNTR040L1N3MDMyWWNoaWl0?=
 =?utf-8?B?WnN1M1NkVDBKbWJScGtuOHZQMlByd1h1M1BLTHJmbG1KeTNhR0w3L2cxSlcz?=
 =?utf-8?B?MUdQNnFrNUdQNVE2QUpVUGxVV2pFY29mWUMyUmh0M2dXMWxiN2lLbEs4VDlX?=
 =?utf-8?B?bGVYV2hxeWEybGZTZVVxZjdTdzY4STE1Vy9kWGFjaW1yUkg2aVJSZ1BQbE1q?=
 =?utf-8?B?WjFDRUtaWHVvVmI2RWhvK1ZZOUI5Q2RmZ0dQUkdsSGZxc1BJSjJXNGdmY2ls?=
 =?utf-8?B?UVJUREFqMlNXQURzOE92aHd4S1VmYVBIVmt6TVBtTWYvOUFXTTU4Ty9vMzNI?=
 =?utf-8?B?cXlDd2YvTm1wTWZhQmYwa0JwbGZRcUpUcDZsYW9BcGk3Z3hYL1lNOGJxM1BP?=
 =?utf-8?B?dStTOWRpVVd3QU93TjJWMkN2b0FacEJNL09DaDF3OUhVbXNnTS9tYktXemhi?=
 =?utf-8?B?MzA0TzFlNkFIMmNSSWszdXBWbWYxUHFBbmVYSUpoMDQrOE5jM0ZscFZzMjls?=
 =?utf-8?B?bVdMWUhtVUI0S3pTOU94RkpyTGdpaVNRV2lCNGlVQjFBQk1yWVBJTGl5Q3Vx?=
 =?utf-8?B?cjJDN1kxbjBuUzNObmszUEVxSE50dWhoL28zdEtzSlBHMG9pTHQ5aVh1ZWlY?=
 =?utf-8?B?Rko5ZGVnRG93djg3bDJvM0wzcUdJUHlpWFBOeUlyL1dCZUg0OFZZekwrZ09B?=
 =?utf-8?B?bHlLZEhxYWZTT0JXRGtMYjBZTnBwQjRQSWdZZ3lCNFhER1V5NjRuK05hb2di?=
 =?utf-8?B?bEdERkV5dWxKWTJWOGZNdnlwa2hld3RkRUNoNnQ3Lyt2NXlsTzgrWTFNc2tm?=
 =?utf-8?B?dDV5aUQwNWw2WHpkU1dHSEd1ejlhTGFmTmd5UFNjVlpvTmVvbit4Z0FxSWx2?=
 =?utf-8?B?aGh6UmF2cU9kdmZPVG4rbytyMXBqSk05eXdyTktTOXZOczJuUVlCTHRJYjRW?=
 =?utf-8?B?a01vTUM0RENLVkxUV0RUWjdBNEZwN2E2Q29BMUZpTXNIeUlGdFNSSzdxa3hS?=
 =?utf-8?B?ak1xY2Jxb29NZXRhZDRaVllwN1ZNWDcyS1p6QlJmcUN1Y09EWkZuSk9rTERS?=
 =?utf-8?Q?01kpB/DWQnCP5cqRhCLtCBUpQ5i4j9tB?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8460.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aHNsNHhGMnhKQlkzd0xJVFFkUnh1TFkyRFFzbnM4cWZwUG16bG1vTFRFaDd5?=
 =?utf-8?B?Uk44T093MC9DUHdwWjJOSi9Bd3NkZHBqc0t6cTdVNDZJVlBZbjVUamxZQ1dq?=
 =?utf-8?B?UzRsZVhvaGZoekZGa3pMNEdCblNUUUQzczZWZ2hac1VqeHRkRUs2MmlYUWNK?=
 =?utf-8?B?K2U0L1N3SGcrNEtRTDVKTisxUnVtRjRoOFJPVTlqb2J2TVZFbGY1L210RWZL?=
 =?utf-8?B?SDhybUdzdW5zaEpwU1RSVW5may9PY3NZVkVCZzBVTFpOUFpxNGhzWHJFRTZ6?=
 =?utf-8?B?V1FjMWt4VlViaks2UWlrTTNMeG1LMEF6bEo2RUw1ek9jOGVMbEhkYVpORmtD?=
 =?utf-8?B?eHM1Ky9MQWg4dHhiWjNMdDVqMW1WeW9ud29TckpveitlelhmNUJtdWtQeG9i?=
 =?utf-8?B?WTlVSlkxZERzUWJYSDIyM3pLNUlSZnRXbjVKcDIwaVdYMGh6bzF1dXJwV1ZY?=
 =?utf-8?B?STFPU1czMnAyOGxKQzNZcm9kYTlXVTh1eUV2Z09KZS8rYVVld0VCUnRVZnJ2?=
 =?utf-8?B?WnJsYXZzbTNxbk1wZnQ3TjJjSTk5cTRIMjRaczJ6bDlsNGdhaEE2eFdUZVdM?=
 =?utf-8?B?VzhzM0xPWmFiZWVqNjFrRFkzS0xVNDl2KytuRHlrWld1QmMvbkxtWE5UdCtv?=
 =?utf-8?B?ZzRyUTduOCs1dVBVR1FySTNNbTJaTmhWbTdyc3lBZktuWTB5aHRhL0l5NjVo?=
 =?utf-8?B?TjF2ajNqYlZiMy9LYnBaeXlxbzdIYUlFVzFUSHZvdEhIamd1cVFRaGxqVU4r?=
 =?utf-8?B?TEViSWRXdnRJZSt4eFJSNHJaMDZBTERUMUp0cUovK1BiQmo1dTY1RlpCd2lL?=
 =?utf-8?B?cVF0QUpjYjhwSWx5QmVQMVNvZy9CVGU4bEV0YjVWemEzRnlRMDh6R1JiZHg4?=
 =?utf-8?B?SEJzVmdFcm15c29sR1pGUlN6ekNjRXFkTzNiQldxRGpzTWdrcHB1Y1JWSWpi?=
 =?utf-8?B?RlJqLzBtanR4akNFcUlzU3Bnc3ZYVHAyYzEzMjA5NUQvS011Qlh2cGlRMnMw?=
 =?utf-8?B?dzZEUmNnVnhsbGFoaCtiUDlIZHVIYWpMaWFRaWR0ZWFLUUg4eVdtUEY3WUNu?=
 =?utf-8?B?b1pxL2kyd3BUYnk1MFJWaDdRdFhiMm1zTzk1YkVrRDlCMG1oZDZqb2JOaUNW?=
 =?utf-8?B?WHRpeTRvZWpWMnBIYVZXNCtRcWI3bFBCenk2bUEwQmZNamFYQ05jNjRlS2Mr?=
 =?utf-8?B?cUZtNnA5ZFV2Y3pzRG5CajNGWS9DMzdKZUozK0UrR0I1R3ptcys2SHRPOVla?=
 =?utf-8?B?bkxhc1Y1OTFNTWhrZWFhWVFXQ2JPV1NCcWNLb3Y5N3hBS0Q2dUZXenpOZFhy?=
 =?utf-8?B?K1lsWTI0V1pHcTcxclBTdmk4TnZIQlhFNWlhSy9oQ0xITU94ODI0R2NlUmxH?=
 =?utf-8?B?RGRQWjZ5RlZNT3BILzBhR3liVDJXR0pHQjRoa0k0R3dIL01HTmNYMHduZnkv?=
 =?utf-8?B?U0pic3hxN25mb0pzczJSQUtQek9ScFZQOUQzclJXNDF6dTIydVNJS0ZSa21Y?=
 =?utf-8?B?RU9hVWU3ak9ONXYrTXVEdjZScVhiOHpod1JFdEdSUUFvRVFjcE0vWmM1bGJl?=
 =?utf-8?B?MmE1ZGVYV2tTQllseS9vNEtPa0Q3bGkzREJNeTdtaWVzMmpyQWtUbTVpcElC?=
 =?utf-8?B?REhXTDl4TXhRTFEzRzhIeVJVMTN0SXFUQU5JbFRFaTRWZ2I3dWJaWkJma09Y?=
 =?utf-8?B?NjdXTlhvQWIzTXYxTG5FUFRUQkltcWNBL1lZVHhIQlpGQ1p0TlpiYlYvdVRJ?=
 =?utf-8?B?WDkwZHE4RkJ5MmhhOW5DdUZ6M2x2eklRa0RHcTVBRnMzaVBmVzkvWk14UjIz?=
 =?utf-8?B?TzdrYVVTTTdvc092bkx4YmtaZk9qZ2dIUTVRT3ZZRG1DQTRoOE4xNkJCakFt?=
 =?utf-8?B?dThNdWRSM0t2V1lwYlVzQ1JUS1ZudU9lbzdBT3U5eHU3Y1B5TmZuMkJSSWhh?=
 =?utf-8?B?TmZnSlhtRGJGSzUwVDNCNHdKRVovWURIbGFwRndML3h1bWl3TUM4MmorSFBQ?=
 =?utf-8?B?TmJGZ2tOMlNGTHQwOXdWajNPL0V5RkFZcWExbzQ0bjQvVDYyZmlENXVzeDZM?=
 =?utf-8?B?YTRidEJFdGU1QzZBNXYzMGIxZUZsTldnemc3eWVwT1JJTjVmK2RQVG92TEN2?=
 =?utf-8?Q?hhiuE4qnJ1O5oHdfK3Wo0boxB?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5eb16d94-e195-4557-8094-08de25e1c550
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8460.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2025 14:01:14.3954 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2SKtiaB7wGqA7Nfh3TfEDOG5n8rPvqik8wS5bbyUA6htxAqRCiFCe+N49cEFvxKiRk8T7Jz2ycq9BZf4aq8Ovg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8412
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


On 13/11/2025 9:37 PM, Maayan Kashani wrote:
> When mlx5_dev_start() fails partway through initialization, the error
> cleanup code unconditionally calls cleanup functions for all steps,
> including those that were never successfully initialized. This causes
> state corruption leading to incorrect behavior on subsequent start
> attempts.
> 
> The issue manifests as:
> 1. First start attempt fails with -ENOMEM (expected)
> 2. Second start attempt returns -EINVAL instead of -ENOMEM
> 3. With flow isolated mode, second attempt incorrectly succeeds,
>     leading to segfault in rte_eth_rx_burst()
> 
> Root cause: The single error label cleanup path calls functions like
> mlx5_traffic_disable() and mlx5_flow_stop_default() even when their
> corresponding initialization functions (mlx5_traffic_enable() and
> mlx5_flow_start_default()) were never called due to earlier failure.
> 
> For example, when mlx5_rxq_start() fails:
> - mlx5_traffic_enable() at line 1403 never executes
> - mlx5_flow_start_default() at line 1420 never executes
> - But cleanup unconditionally calls:
>    * mlx5_traffic_disable() - destroys control flows list
>    * mlx5_flow_stop_default() - corrupts flow metadata state
> 
> This corrupts the device state, causing subsequent start attempts to
> fail with different errors or, in isolated mode, to incorrectly succeed
> with an improperly initialized device.
> 
> Fix by replacing the single error label with cascading error labels
> (Linux kernel style). Each label cleans up only its corresponding step,
> then falls through to clean up earlier steps.
> This ensures only successfully initialized steps are cleaned up,
> maintaining device state consistency across failed start attempts.
> 
> Bugzilla ID: 1419
> Fixes: 8db7e3b69822 ("net/mlx5: change operations for non-cached flows")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Maayan Kashani <mkashani@nvidia.com>
> Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
> --- 

Patch applied to next-net-mlx,

Kindest regards
Raslan Darawsheh

