Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69191C021BE
	for <dpdk-dev@archiver.kernel.org>; Wed, 26 Feb 2025 03:10:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 33D66402E0;
	Wed, 26 Feb 2025 04:10:24 +0100 (CET)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com
 (mail-am7eur03on2069.outbound.protection.outlook.com [40.107.105.69])
 by mails.dpdk.org (Postfix) with ESMTP id C869F402DC
 for <dev@dpdk.org>; Wed, 26 Feb 2025 04:10:22 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DM/9Q/uQ2vO25MIxR13uAbYALAtbzBW88/Q8yZ7AdtncWKFaeIZwg5489SQB77NisUkePi5Nwpvgi3nX9VjAPAPQItv9eCPHpYRWXh34xYbt+lg/+tdY2jAmcexd+kiPX4TLJMPpcGTWjiyVJtpprrmOSaUFjc/GQSDsZe+RjpdWIXKWzymSzFueV4BPpmdCmi0CQPzIO1WO3BOra0A3vN9B98lcDvMfFa+8t70zvrH3aW836fanXs6Xixn6ObYE+V58T9i2v/A8LSJdZMpQOSOKhoTcXl5w5E3t45a3+uhu6Ve2bAz2Mw0/rKs7Iabd/rw/oJEv0QKozwHcMXMmFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kVkNMbnOeqtIUhRvTVm+3xVfE2dTXnjaIOajAz1UkbA=;
 b=Wi7X/uhEQ0Z+XDOTTcMcSWHOEK4FxaiRrZ0NMwtJrFfpXosh0ZdBxzCkrDZzhT3LkcW5Ur+ODEMf14sgTXKZ8QWbQm3SCOAzo0nRF7GsghfzT2rP+45arh06ugGaBI9EgSoPyVFpEcDdRA+6730SKqT5vWcmlfXdHvRYii8H7LbT7jzFNwaWgp6+NYvxlp+F86z1PuB+sz991ZDcNcUOpyVi+XPm8HvPlRhHp499uQg778DPoEBU9kk+NvgyBTHJsk5zxkjSKgQX1WPD4ZKeXccNhujcop4eSSzLE3Yp4hQ6yzZjASJdfinegFMKXIF/eoapoSmLv9mGXEeIMUB0lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia-sbell.com; dmarc=pass action=none
 header.from=nokia-sbell.com; dkim=pass header.d=nokia-sbell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-sbell.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kVkNMbnOeqtIUhRvTVm+3xVfE2dTXnjaIOajAz1UkbA=;
 b=jH9dhxFqD0LJlmp4XYeepacEuWguxiN1YZQr1vWDUvyt4xroyHbnoxSZie55lB6wJe6X7uNPphKm+G0tYgFbzDUFhwm25QrabZRG+JZuQeOYQ3YafyEnNX8WHdA9oFLYxgofCzG1/YsNPlj7dZ4tHzu1USJs0rZTTJ+HqJ1ZrQlR3EJdQcKjXZ6HxUdYzTB8RywpChPe31cwHQzx5kC6G/8rlHGJDoDpZJ9Pr6fwHVgNuV+qwFjIUx3AqA5l+enH397i7iZUHC6IuO0ArgBk9Oxx2jKkWVonmCZwGCym8+/Eg/ghgJZQ5IBpCIM2bekRrNwmfGI/h3rkQQvJBZFgxA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia-sbell.com;
Received: from VI1PR07MB9898.eurprd07.prod.outlook.com (2603:10a6:800:119::6)
 by DU2PR07MB8238.eurprd07.prod.outlook.com (2603:10a6:10:277::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Wed, 26 Feb
 2025 03:10:21 +0000
Received: from VI1PR07MB9898.eurprd07.prod.outlook.com
 ([fe80::1928:4afb:4eee:1f21]) by VI1PR07MB9898.eurprd07.prod.outlook.com
 ([fe80::1928:4afb:4eee:1f21%6]) with mapi id 15.20.8466.016; Wed, 26 Feb 2025
 03:10:19 +0000
Message-ID: <c8c0b528-aff7-4d7b-968a-83deb70a6a5e@nokia-sbell.com>
Date: Wed, 26 Feb 2025 11:10:12 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Skip vfio in the scenario of non-privileged mode
From: Yang Ming <ming.1.yang@nokia-sbell.com>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: Anatoly Burakov <anatoly.burakov@intel.com>, dev@dpdk.org
References: <20250117072847.2741-1-ming.1.yang@nokia-sbell.com>
 <20250117084750.3259cfa3@hermes.local>
 <ba8c70c7-a738-4b01-8df6-2df5bb0e2d7d@nokia-sbell.com>
Content-Language: en-US
In-Reply-To: <ba8c70c7-a738-4b01-8df6-2df5bb0e2d7d@nokia-sbell.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR01CA0185.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::19) To VI1PR07MB9898.eurprd07.prod.outlook.com
 (2603:10a6:800:119::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR07MB9898:EE_|DU2PR07MB8238:EE_
X-MS-Office365-Filtering-Correlation-Id: b72533c7-e093-490f-b4c4-08dd5613199c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UUh3OHZobWxPcWU1UXhNbEtwNDB2WTlhVS9uZ1RtTzduVkFWZ0JUQ245cHVR?=
 =?utf-8?B?Z0d1N2wvRkFCdjRZUzBDQ0wvMURRMitpOTZyWlM3VDQyWUJqb3ZZdm5QcllV?=
 =?utf-8?B?dXJNclVnejhkaVdBamFuVG4rNkliRkU3V2JESnE0NHRSV1hZNUJNUnB1TjRi?=
 =?utf-8?B?Qy90U1BRSjdteGZsdjBYeDlUa2ZVbGNlMVBiMlhYU0Eycy9PWlpXZ1NrK1ZT?=
 =?utf-8?B?U0xvOVBvL2NDb29NdW1ob1Y1SDFGYnlYaW5RMEt3ZHF5aHIwUGhBNkx0eDgw?=
 =?utf-8?B?TzZOeUUyK2tYdnB5Q2N1dE5sMHpRQ09BTHZsTXBVemlLREVLQmlJVXdmOTVX?=
 =?utf-8?B?alRzT1pZZmpXT0hMSFV1Yit4ZklGV01yRWxMSlNSYjFjZHpFMy9HNy9vM0NO?=
 =?utf-8?B?dVp2QXg0WXhzNi9DYUxBMDQyZmd2K1N5TEcvRmVoazBMVU5QZnUzZXN6cldz?=
 =?utf-8?B?Slg5T1lVUy9wQTFlclBUOFU3S3htVC9aS3RaMkFoWDBSZkRwelJsVlVnZEFM?=
 =?utf-8?B?QVJDV3hNYkVTejNoSGRoRGlkNXdRMnRJNnBiN2tuWjkvdzRRS3cydFNZSzF6?=
 =?utf-8?B?bkFqTWd0VjVYZFA0ckRHK0VVVFo0dklxUWNVVGVWMjlUQjlTYjh0NmlJUmZN?=
 =?utf-8?B?ZSsxU3pIMkkzQWtVUUM2d0ZpeHdGdWxxeTAxVWhwTjJpVTIxcU1ObldVMFRx?=
 =?utf-8?B?QnZNOTFXei9YR1ExL21xMC92OE5aTU01M212QTJ2QkFrb1FwTnhHTC9HSUUr?=
 =?utf-8?B?NnNRNXBaSkttVVV0S1pMUVhsenM2bFplaXlTMnlzOUdFTEpyMzNhZlZZRGEy?=
 =?utf-8?B?aGl3ek0wbUhVM0htS2hxVnFpcndWdXRObXJ2cmNkcmwyTitmQ1ZXL0hQR3F4?=
 =?utf-8?B?TjZKSFRwd0RKVnhZTnNzWWl3TDFIdisvVUkrSHd0MDkvM09GSkVGZHRSdGVl?=
 =?utf-8?B?RnhiQ2NvRk9KSHp5dkpqaVlxSmhLbTM1S2Z0Yk1hM0JtUlRtRG5FV04yTTlo?=
 =?utf-8?B?M2JlSndNcElIT2k2M1dEMldQTHhtdWxOdjIxaG16bEY5WHVuZXdjcElITjBT?=
 =?utf-8?B?RkJuQnhROHZxemRobE1NK3UyZlZCOCtMQXM0S3NUaC8wKyttRUIxaWFRdWVN?=
 =?utf-8?B?M1JRWGdSMmJESVQvWHUxZktHU215WnJORm9JTFpzWEE0MnExQ1lDMGRpWDFs?=
 =?utf-8?B?MXFjbU1BL2N2UjEydDlLbDkrelhsODVCTStyeUgwMnB1QldMUytETzRjTkpw?=
 =?utf-8?B?TmVpVmVyNkRyWVBJVTlOa2lGREZKSElMa0J1a3VFMzBnMDJ5VFFBekEvb3Uv?=
 =?utf-8?B?c3JCL3lTSmNRaEdibTZ2ck5wTTVQZTJJbitHLzM5clM5UXU0TFZVbVFBM1pz?=
 =?utf-8?B?NzFPYVQzUjM2aG95bWpKbGlmbGg2amd3WTg2aU53Q0dwNlUyeEpsajR2R1BI?=
 =?utf-8?B?aTM1aVEwN1FWN1RKUlZ0R0RKcEl0MmFxcjVXMFgrZVlkTWt0R2dvelNjLzRw?=
 =?utf-8?B?QXRBa1hyUmI2eXc4cWxLWFJNanZ4cjRsYUlMTHNGSnk2MktxY1RSQ3FaTWdP?=
 =?utf-8?B?MW1tSGI0bVo1cEYrcXd3V1VteVBjVlphNjdJRmRNZjFrWkhlYUd2cDJmZTFG?=
 =?utf-8?B?Sy9ubnlERFNlSG1xWkM4N2hmYThBNDVJa3VibzlhNFVkTWpUNG1oOFZqQTBD?=
 =?utf-8?B?d3UxOUZGRllwNmdnUCt4a2dOQnhPS1RuQit0VFRSM242SkQ0YmhMZkpWQzAw?=
 =?utf-8?B?YXk1ajM5NUhsVVRIMjlORHNMT3FMeGh5ZEwxdjV6c0xja1FKUVhTbC94emNZ?=
 =?utf-8?B?UW5vT3EwWWlSczhydERNMEhwVWtReWJGZ2doR01idDc1cVMwMkFySExLdHBH?=
 =?utf-8?Q?bqFfUfPalZ+bU?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR07MB9898.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SFZ6bGpNY2VYckxYL3FQaGhSQ3g1dkkwY1kwdE52ZDRVbzVrc2YrQUsxRnY4?=
 =?utf-8?B?dDNITDRvMkJuWm8zek5SSlU0OGZpS05INkpmTXRnZ1pNNGZEeDZTYWxONWx2?=
 =?utf-8?B?R1hIaEdRcG9JTzJKajJXZUYzU2xvKysrQnc4TkNPWEpvTkJTSUhVd1EyUnVv?=
 =?utf-8?B?RmlZVllzUTRIQzRmRTJkSjBkdTlkSyt3ZWNuYjNZNlU2bEF0K1ZRZVBEK3lX?=
 =?utf-8?B?N2VxcmhzZXlmV1FCWllGZ0RTcHZ6eGNjZFNWVWtHSUZmUGQwblNjdTkzTmR3?=
 =?utf-8?B?Y1liR3pZZ1orM2dkR0ExbnJ4UTg0MzhCbGF1eUVNOGVjVUZKTnlhNjNJVko4?=
 =?utf-8?B?SnVRUTV4R3RKTGJvbC9VM0FYRk9kbkdwUTFxTFZ3N3V2L2tkWEEzTWFxYXNG?=
 =?utf-8?B?NlQ4bGV5Y2Zxdmp4Mnl1TFZFU081V21jZXMwdjJrd3BJOHAvZWFBQjltNEdU?=
 =?utf-8?B?NjYzT095R3ZCdFlqQWFaN3puU09xTHNPOVlSWGkwNjRsNWp4WStsZDA1anRz?=
 =?utf-8?B?czk0UW1IWmIvT09mZUVIZFRaSjJUT3BybTk2T0ZlOUNNbFlUakEydURVMmJY?=
 =?utf-8?B?WUwzaGh1cnBacUsrKzdaOElrZVp6L2Q0S3g3bFNUcXV6SnkxajUwUDFzWXM2?=
 =?utf-8?B?aWhMWWhmWHM1YVVpSDNaT05zUlFiNXI0NXFaZ0lJMG90bHNQSEhNYnQ3ZUNi?=
 =?utf-8?B?R2o2SlRNeUVFSlprSlRWTkJ4Snh3SW1XSU9rbUhHcU5KdjdKbXloOGtVcko5?=
 =?utf-8?B?RFhrOHZ5d2czbUVoTXZ5alpwS2N5OXZ5c05DdGhIUUlTYkdiYVh2TjQ2elpD?=
 =?utf-8?B?NEozZW5rVm1LWG9CNWJrL01Cd1Vuc0p0MHgvdU1xQkhpU3RhdXptN1MwVkJF?=
 =?utf-8?B?ZTc5cmJhRUZTWTM2d2FPYkxnVjMrS2dLK3ZTYk4rNHhrZnlXQ1hPQWpoSlNs?=
 =?utf-8?B?RnkvMGdzV3BUSTVHeTVZMjZoSFBoODUzODl1OG1IYW5sWkFJbkZtM1VEZEth?=
 =?utf-8?B?WUU0ajhyelY0eDM3dDM3aXdxQTVUTWZoVksvUS9KcDNkd1JaNHRVaTE5WTBv?=
 =?utf-8?B?YnFVR1FKbDdnbkhpT2ovK0Jmemg5STZMa3hmYjl3VzBXQnRqb1k4V3JxYTc3?=
 =?utf-8?B?K1ZMbUxRY2w3b2dudXhxVHVkVG5naWxaTEJvSHJnb0lLdVo4QUI1MHhYRzdu?=
 =?utf-8?B?cmtZUmZwa0xxWWlaUVNZYjJNdUNTQVI4SVhmT0g2OE5aVlJLeWhnWFJSc25L?=
 =?utf-8?B?ZU9aaXhBbnV6QU8xVC85MWt4MkJWU21nT3Q0Z1d2Rzd3MEdrR09aUTFsajI3?=
 =?utf-8?B?aksyRDRYRll0cmxYZ09keHBJQ1o5YkN1MlRtRG1QbHdUUSt3MFo3MTVoN3dL?=
 =?utf-8?B?SlJhQVpsdW53QmZqOC94QkRyWFQrcmZnWnQ2TVBQMG9JVWJFYlQ4TlBiUi9y?=
 =?utf-8?B?cVh0NVZmZ3NGL0RTNU9HNUtXRjVsWk83MzEzallrcjZIVzdRNUJCREY2N2k1?=
 =?utf-8?B?QXAxZ0xHZHU2SmhoSVpwRGxoV1ZvK05KZ21CR00rVlF3eUh5a1hHK2dEbmZi?=
 =?utf-8?B?MlNXc1VMQTZacTJSbS9GQk1NeGZIM1UrZkZnSnBhMEs2Y3RQcE1iWWU4Rk8y?=
 =?utf-8?B?VXVxa3F0MXdPbXdmRCs4RHRPNWRyWTRINWY5NnM1V0lkMlo3ZE5BZmhsMlMz?=
 =?utf-8?B?bERMZ1pjK3E1QXNSQ25mR3d1dnVWMDVEM084eW53dEt2R3ZpdmtoUGtiUndp?=
 =?utf-8?B?SVEzQ0RxaEdWa2F3eUx0VUlwVEwwbDFSbHNGNFJaQzAxUnNsUDNyMzVqUm5T?=
 =?utf-8?B?RmwyaHZ1NDJxdWxpdzJwS05MdHpBb2NwWnRXQjE0Z1F0VEE4YkFRTy9oQWdv?=
 =?utf-8?B?eWRlZjZBaXRZOG9qWnJUT2R5cHFPcHFqaXdHYnAzVGhkOWdNRXA1aWtUV3Bo?=
 =?utf-8?B?K2JMZzdYU1BHeWVqQm9WT09FN3VRdzRjc0Z0UEZzR0t6eU9NbjJ3eG04TEVL?=
 =?utf-8?B?akZscVp5R202ajF5U041eFVPbXFmY3ZuTnc0WXJEVHBaK3F1YWVlY09CWGxP?=
 =?utf-8?B?VDBVTUZScUhSOXFRUFNIa2gveno2ZnhVWkhzUmQzSWlFYklWZnFETXk1NFFi?=
 =?utf-8?B?a29wY3BueE9NdU9qT0JkL0preXNOYm1rY3dodjhMWXBzTjM2RmxseW01cHFI?=
 =?utf-8?B?Q0E9PQ==?=
X-OriginatorOrg: nokia-sbell.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b72533c7-e093-490f-b4c4-08dd5613199c
X-MS-Exchange-CrossTenant-AuthSource: VI1PR07MB9898.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 03:10:19.3822 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x0SdZakrBVqpCJjtwPgz2Q2OZzBL7S03Qnh+922yhcGJ6+gMniTUXstbydk1H/v1vC8bsnNylhIPaCOfP6C6TBWnhTEH2WstfNV6C1MPXCE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR07MB8238
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


On 2025/1/22 16:15, Yang Ming wrote:
> Hi Stephen

Hi Stephen,

Could you please confirm the comment above?

Brs,

Yang Ming

