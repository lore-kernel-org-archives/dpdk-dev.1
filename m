Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09AA3F532D5
	for <dpdk-dev@archiver.kernel.org>; Tue, 24 Mar 2026 05:15:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0E03E402CE;
	Tue, 24 Mar 2026 06:15:19 +0100 (CET)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazon11011027.outbound.protection.outlook.com [52.101.65.27])
 by mails.dpdk.org (Postfix) with ESMTP id 0A1E44025F;
 Tue, 24 Mar 2026 06:15:17 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GyIIiv4y6gPwcLKNtRLjCCNr3MQVeH6ZNxNCfobTVzx0jZAlq3lSyf4kH0t+Pl/3K9DyfMnibdxB6Mmc/4PXYnZIiosadL4O9odiym1SQ3QU3jKO5GbfxHiwl8qpievQFnyZ2gmEqXOOSCFLMd4hsdCsBbKSfSqVGg5EGWMLd441DdkeF56u78u28DN3w5cROur9AYA3ddnPG0CJnfuTW3eIe4hUj/QZk8V32chYUHht7WOVkXvQwPm2XCjhoYP3SDoiKEZYxzsIwg/j4YmToS1u3jbh/YwCmoN39NaoZ/L19nP2ifVsad/x+qE7a9k6If7Odk9drw+QjetOmcHUew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e2cBlK0qIqibF+HkyzK6SZ0TXPxJnhbzwlNS7poovZE=;
 b=szJaYsO1gojzuSxzsoEC6bjz5h30K/nQuj8FdEmG11oEYYTgMzUk0L5aCf2nxBpcdpqNdH2Dai3vRZVHvll7vSe+1HJDbs1TBRrve0vnYVwfktEeF09RmsztXWb45DeqbkdEJtRL7gTRfOv7iA1KPPzPqZuJ9fkjVP3Dn5Mgi917EUm+VWNSby+fwtPKta1NeHW0xLkIVE6mvtPOh2tSzeo7KPhUN8Ww8ghn+sAjw+qDnyeQK93poZ56lYleOhbqgQcP2XiKMEWIp/A2vgAsavP/sd+a1pUsoBz8fnr+nSs5z/QWx0b4m4Jfg7WsZPqWxQSa8jNHvv75LU3tYvTuCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e2cBlK0qIqibF+HkyzK6SZ0TXPxJnhbzwlNS7poovZE=;
 b=WOB6Ij91cG0Cg9kgPXN4rzB/KU8YaovQBwnDkNqPakIIf0FowOIPrLZ8sUp/KJ2q0KqPb4a9qPpJFmpGvCN6LZo/s/2MIp7wqyOb7o59ZIA0/xtHm/m3Y56t6WIqHN6B53vfq7IJtV1p/1TOmhHrGZ8yLIifhRrLoHp2hlzNjjcy/8IFUG4d6XIhUncbeAaRf9TuNqIPwae9U5fOPVEogwuUBO+WZrlVZj/9x70Grqqcwo69aVEpPQWk4Fx2rJLLdWpxagvE7xhyBiCpth3s3NjVcUN+VWw9YjJZOhJVRs1AwbJ1bd5C8fbPpjQPJHhIFPWCa/NwAOyl7mGi1mVYhg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PA1PR04MB10770.eurprd04.prod.outlook.com (2603:10a6:102:492::5)
 by DBBPR04MB7499.eurprd04.prod.outlook.com (2603:10a6:10:203::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Tue, 24 Mar
 2026 05:15:11 +0000
Received: from PA1PR04MB10770.eurprd04.prod.outlook.com
 ([fe80::944c:6b2:95a0:32d7]) by PA1PR04MB10770.eurprd04.prod.outlook.com
 ([fe80::944c:6b2:95a0:32d7%5]) with mapi id 15.20.9723.030; Tue, 24 Mar 2026
 05:15:13 +0000
Message-ID: <51899815-e099-4137-8455-0f74e4aea115@oss.nxp.com>
Date: Tue, 24 Mar 2026 10:45:07 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/8] bus/fslmc: fix bus cleanup
To: David Marchand <david.marchand@redhat.com>, dev@dpdk.org
Cc: stable@dpdk.org, Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>, Rohit Raj <rohit.raj@nxp.com>
References: <20260323105306.1531689-1-david.marchand@redhat.com>
 <20260323105306.1531689-3-david.marchand@redhat.com>
Content-Language: en-US
From: Hemant Agrawal <hemant.agrawal@oss.nxp.com>
In-Reply-To: <20260323105306.1531689-3-david.marchand@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2P153CA0006.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::22) To PA1PR04MB10770.eurprd04.prod.outlook.com
 (2603:10a6:102:492::5)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA1PR04MB10770:EE_|DBBPR04MB7499:EE_
X-MS-Office365-Filtering-Correlation-Id: 719acef3-de4f-4081-7fcc-08de896453ec
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|366016|1800799024|376014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: GukjOrYYLXrEFPxx40ldSZ4A08JgBCeyX3IVq18bagS5gIX0ShNLlud7c8J61/SWjLxVD1ASpXFMBLIXmAj9Eu5rWuB+BI7bEpJkPMgfxfRplVxDhzetsDVHIIxrDdby3NRvCrADSgaKzq4E1Ng/n+wLzCcW7nbv2EToOYiISV9U761TdBuDU539dkpyaSpVrXls0EEu1A0ISfpu6xT8Xn8QmdwFIA4v3D+8MTVCej+ByfZ3/u3wM78lPnghthG+fCY8YnnEb1E8ufVqs1vkPD3u0hD8qvnq0Qj3ADBGYbbI7z+kcF07BlZEoN8G7M2LQilg0f0KvTbOHQ+mRwh3Xa9CM1tXFM0quTK0qyZaT4m156yrHqQ0hIY0Wy0Z2i/h2c7gbqmAhIHA+ezlYlseogEFhUoO95uQ2byojdwXxZsSbTcUa3x1azyVdwUbU3Cb9GHEugQO82VZWyvrOoPDhxPPqty/vqNOGN4tl9r3aRgoSRgmrimN+hi1I4ggy+/xeguQ+S/PvnQ485FWk/WFAschOy8pAhRUb5tN3MsbzZGB5O8lZq/stZuM0XhNYorVe1xVvBwcQWXnd+mwRdwDso/Cejp2wrAM2sQ/IDL9q30zrZ/6OypApt1VDSB0VQKkWpPPZMxoe1cPyvqLZPEmqV2++WJaeLDe92OiWYbDqZUF2Hpq+zJSSf0vnyFjhR/4pbupmdFOYqn6wh8lpHE29gElfY3IPQuouv/NVp+4nlw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA1PR04MB10770.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(366016)(1800799024)(376014)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VWovRWR6SXcxZ1ArRWJKdWVwTkJKT0hNU0dqNVppRXg0dnNQOW5STWczc3pj?=
 =?utf-8?B?anNMVUZlODh3eUpLOWZYbWJlcWpKdjNaTXMyQTdCWkcvSkRMMmFBM0o5ZlJU?=
 =?utf-8?B?dDBlNXBxMmJ0a2ZRT3h6NXpkRzN3L0s4OTRTMlhvRytVbzVuQURwSFA1M0hs?=
 =?utf-8?B?S3lKZGNYbE5kQjI3MUtPN3YrdEIzcnIrYUNESUdTa2FjSktvNk9GZll4Rjc0?=
 =?utf-8?B?RjM1aWRJM2lqYVhCeUhXaEltaWU0dWg5eWdGdWJraTAzb0tLM1NIbmhhdEho?=
 =?utf-8?B?T25uK05QUk80VXpZMGdGdDZjNjZLTmVFQnpHbWNOVnh3Wjc2TSsxUnRKZHhU?=
 =?utf-8?B?OS93TkkzcnFSQ241U1huT3M1RGNnQmw0bkg2SG8rVTVDb3B5bWNSOUxjUXpo?=
 =?utf-8?B?TWlZUzJtWkUvVCt6VWtYMk0vZm1KQm1DcWp6dERBamtVdXJUSjIzQWFFK1Q1?=
 =?utf-8?B?THRHT3BSMkZqc25xbmc1QWhNNDk2UWQrS09DTzdqNXpkSUVpQXVPbWZUdTFl?=
 =?utf-8?B?ZFJoWml0UW9sME01OFhLNFF4U2N5NkNSaG8yKzd1bENJc09EV3hNRXAwcDBv?=
 =?utf-8?B?ajRGcUI0VFFMQVR1S09YdmJkeHQ5dGdtN2F6bVAybkpQQkdZM255R2QwRUJZ?=
 =?utf-8?B?Z29DV2haQ1hGZXV2aHdVWDhDQlphRzFGQmtmRnEyd0FEU2x1WnVvYVlTUFpP?=
 =?utf-8?B?dkhWelMwTW1OVS9YQ3RmZmJBMnFhamNOeFVDalZuUy9zN0hQZjY4blFMbUdF?=
 =?utf-8?B?SHFoY3AzN3didUU0dVVwTmJpRUFiQnZvbU9HQmI0czcxYWxESFRwT0hiVzY4?=
 =?utf-8?B?MlZoNERWTzRsNjZ5TFhSak43TGs3cGphYkgyWXU3eDd6a29qNW9EUjhxZVpK?=
 =?utf-8?B?bmR4YUVEWEZpMG1PeVlQR0hiT3VwZVFUcm5QKzYzY1JkdkFvL0Yzd09LQk5a?=
 =?utf-8?B?V2x2ekZ4d0JuQ3RVUjR4eVVEdU0yNFdhVURhTXBkSWdzaDFobnV0QUw5RGEz?=
 =?utf-8?B?RGVHRFl4ZXhMWjFkQ2xBQ2xtYllmTjhpM2ZvU0hJWjJ2a0RpanB2ZVk1MmRw?=
 =?utf-8?B?Z1NCZDFrcW1iOFZ3c3hJaTJXajM5TXIrb1dSRWJkSi9ubGxySzcrT2RHMGJq?=
 =?utf-8?B?NGY4TWIzQWpmSWluWGxTMGpWRnl0WHN5RHMyK25mSlRFWEVYbmhjalJtSUln?=
 =?utf-8?B?d250QmJ0eTl6MFZVb3Zzem8xbGF4eFhoczlyelI1OG1xUEdzeDN6MnYyQzdS?=
 =?utf-8?B?NldpaFRDUEFBVkNBaG1NZVJuRDJYTDluTDZ1cDZ4YWNNYkF3V0djRStXR2Rq?=
 =?utf-8?B?bUdkSTNaazBEa3hNdDF5QlN3bXlRZVZQVlIwNytpQWxKYlcyNHI2cXJFS2pm?=
 =?utf-8?B?TUpVclc0LzVJY1lYMjByUjNYNEVsSVlyeHZienB0clBHcHZISG43MVRuSDlZ?=
 =?utf-8?B?ajFId1V5TG8rNVJFVG5LcHMyMWZqNGJWZVB3NkxOcHY4WjY2Y0t6YWRzcHNY?=
 =?utf-8?B?eE00S0RNb0kvbCsrYnU3T2Q1NDF0VHpxWSt4MUFJVU9xb1VhTjgwY0psTXBm?=
 =?utf-8?B?cmJlTkthVnRzRnBhY0xhSlliaTB6dEZOWGluYUdMSW9kdGN5YzBSWHJabXQv?=
 =?utf-8?B?ZGljcTJwWUY2M2NrRnJMM0wyQ1VPeGk4L1ZvWG56S1RIYkovQ01UVit5U0lD?=
 =?utf-8?B?ZGZ2WHJ2Q1pCWmYyVW90dnk5SzZxRWtZa0pzMlVDTFVaK2lVb3BESkxRYTYw?=
 =?utf-8?B?TFR0LzNqSk1zZDBzb1ZFMENScDRZdWxWWXZsN0E3MHZzVVJuWlVtc05tSUwx?=
 =?utf-8?B?aHZ2ZjlQSEZBaVk0anp3RTJLL0lYOXpRc2o2TGZtQzhGRnV5dTQxYWt0bWVq?=
 =?utf-8?B?T2R2OFptQUlFUzgzaHlBOEhuY3QxUWZRYW0zZG40dGNHQU5CWUg1czcvODE0?=
 =?utf-8?B?WEE0MEFQYytJVjVQeDJZYVN6Um9VSm9YS2UwVTVnVGg0SE5FaVRwcDkyc3lz?=
 =?utf-8?B?OVJTQktPZ2JqZ2pkT3oyUWdnS24wTmpCNDhSUVJWWlVlenZMMGNQelVtR1Ay?=
 =?utf-8?B?dHMvS3hYRTN1T1Y2TjBMUUpWLytiWk8xRm9tc3dBUWU3aW82dnlmb0dJUElu?=
 =?utf-8?B?ZzF4K010dExQbkV6MUI1QkJyNmg5WCtBVUlXczI1NzcycFFoZVpodDhXK2dt?=
 =?utf-8?B?dkFUbXdTd2tPMDhLV3ltVGJwaDRGM2d0MkNKcXFqdXJJdkU2TkpLMEY1WTlo?=
 =?utf-8?B?T09LdWpzVEx1ck43YmFzWDJaY3ZZUkc3QzZjRHpnUkpya0UyZjJJYWVFSmdP?=
 =?utf-8?B?UXgvcHlORmtCYlVkcmZiZEFKTXU5WWRiVUYwblRXNVViZ0FwMG4xUWI0SFlO?=
 =?utf-8?Q?EEbaHlL724/fbmws=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 719acef3-de4f-4081-7fcc-08de896453ec
X-MS-Exchange-CrossTenant-AuthSource: PA1PR04MB10770.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 05:15:13.5469 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +AHipCxAVqFu4sz0m7dQ4vy3ye84jkG5gT4UKnF/vDdIS5kchQWAqcAISyQoemddlMfi63wltuq9XWhqVGMPiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7499
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

