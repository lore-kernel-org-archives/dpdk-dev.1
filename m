Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09223CCD194
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Oct 2025 15:32:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DF97140667;
	Wed, 15 Oct 2025 17:32:52 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazon11013021.outbound.protection.outlook.com
 [40.107.162.21]) by mails.dpdk.org (Postfix) with ESMTP id 3B4FF40273
 for <dev@dpdk.org>; Wed, 15 Oct 2025 17:32:51 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PgK/gk6Y9YOLc23z4brRCKRAkBlShMpSfIab+Rf2MVxqHsPmov7/z9gfz+k6cX2x3HvXTic+t8WiRaoyMglzEft9h63HhThIjAXvs4HjJ5VuaW/UiJXAD+RJ2Ztw2umZNkCVV8Kfwz6S9Uc2Rm8IKAE0TtQMqRgYBu11rxuHBPb3ei5YEscln41UniN2iOvWX7ChI5VLzAjtJslddxIBOLuEplgED7LDqzcFyUAZ4boDWQdtcuf/uZwZLE6O+C1eb3VvFl6NoVJe9idlsMNMe3McODddMGbPFskjA5xYQLXat7YRwxqg2w5fBGSy7jnwocKV0Y+dGcajWYKtD6HIyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zjQ8MGK5ugTI6LB1rlXqTR6XyQKTMu63qebsEMywZHY=;
 b=DasIoDjcGz0SLXT+YxPWj0jiYnit0hlU/uOURnUU7J8aoL5Sz0+wpcmVbG9A7+cyul2YwJ24SpjEgSuWBMldrA4PTpRY8F0wKJ+IR6mvhIsOtfDvLYtyMXR0PsIdndg7DFLHO/m3EEUoTiVZsvnKx+KUO7iErFtaJLO7n40d+mYna7SEKv+s9yBFT7BhR8vNtjx59D5JyNw4+27k1sD/OQnT84nKLpoIaLIcV5q9tDu8/3X896KhNkyg+LEm25dAvD1RI1HIJBwJD93II+zs3fRmnni9+m6tgqoCEeYsyGNnowpzH7eCrWEKEfPg9uy2O/fWl9NSghPAUHOL3BZiUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zjQ8MGK5ugTI6LB1rlXqTR6XyQKTMu63qebsEMywZHY=;
 b=APnfDy79NrJ7h7VOQ1Y9k0xD7yQjQKkteILohuNitu3BT5Prl/Syae22TtaH/Z9EAAcSsuIEwrpxIhHaW3BDusf6uQyRsPPXBwkhWroTgRaocinx9Tq50C6LTr3AauzNedkukMVCPO1zjp5JAv52YFRZ9aHxpiHjwk37dqzSW2xvXAc8nSMJMeT0/rq/9e7i9WKtchWj0fYxmBhm7iJWOjx+g9w6PDHcDMnZmcUvkTT8IGOPe1djNnHQDHUtBHmycOT7FeLlVmfbw/geznZlfYyCCBZHWARduV6Qlz2+wI2LA5ZVkB7iAIyvCXuaXjGXK2QZIVG4FP8PHw915RtQvA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9328.eurprd04.prod.outlook.com (2603:10a6:102:2b6::15)
 by DU4PR04MB10363.eurprd04.prod.outlook.com (2603:10a6:10:55f::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.13; Wed, 15 Oct
 2025 15:32:47 +0000
Received: from PAXPR04MB9328.eurprd04.prod.outlook.com
 ([fe80::f268:adb3:8817:15e1]) by PAXPR04MB9328.eurprd04.prod.outlook.com
 ([fe80::f268:adb3:8817:15e1%4]) with mapi id 15.20.9228.010; Wed, 15 Oct 2025
 15:32:47 +0000
Message-ID: <34cea533-b8f9-489e-bbd0-444fbb16b7ad@oss.nxp.com>
Date: Wed, 15 Oct 2025 21:02:40 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/5] bus/dpaa: add FQ shutdown and improve logging
To: Gagandeep Singh <g.singh@nxp.com>, dev@dpdk.org,
 Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>
References: <20251008043519.2461707-1-g.singh@nxp.com>
 <20251014101716.2885563-1-g.singh@nxp.com>
 <20251014101716.2885563-2-g.singh@nxp.com>
Content-Language: en-US
From: Hemant Agrawal <hemant.agrawal@oss.nxp.com>
In-Reply-To: <20251014101716.2885563-2-g.singh@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0038.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::15) To PAXPR04MB9328.eurprd04.prod.outlook.com
 (2603:10a6:102:2b6::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9328:EE_|DU4PR04MB10363:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d85db44-1fea-4bb8-0bc7-08de0c0017a3
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|19092799006|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?L0w3T0p0WXM5VWRXVVljYmpjN1FEZHJTRnYybTdoQnJWcGxHMFZYa2ZsQURo?=
 =?utf-8?B?cTRqSEpOcXFUZmUyN1ZhUzI3KzN6bUNsSEJDRWl4ajF1aEYzbXNHZkNYUjIy?=
 =?utf-8?B?T0ZEMGMzcnArb2I2MWtjUFdiWVVJTExiRDdwZzFrM2dJcXczdkZxOWFyN28z?=
 =?utf-8?B?eFVzZTFGTDJjaUl0U1BwNnQyK1RoWklaQ2R1cHdTQlhPYzErUnp1WVpyTFlW?=
 =?utf-8?B?RENscndnSXpXWVZsSnJLMkRRT2ZIWWZwRTJ2NUlHWk1Iby9HbFdnd0tNM2M5?=
 =?utf-8?B?cklCT3BxVUtRUjFVVzM1SFdSbWxkREdqUDJHMzlDTjA2cWpxeS9rZWd6bVVk?=
 =?utf-8?B?amNnL3FaWG5XMTI2RDN6VUJkRUFnb0dZdSt4ZG1EWXkvYU1iN2h3SFpEQzhu?=
 =?utf-8?B?NjNqb2Y1Ui9ia2NvTmJyQVJ4bWpHSmtmNzE0VmRBYmtIOGxkMlJJT2VqUGhB?=
 =?utf-8?B?Q2FNRWxIdXlQaUFycmg2YzNJM0JTMzUvQUJTMGI0Wll0K1FCZ2xsSGlrY1dV?=
 =?utf-8?B?OFlBQ3dOcVNjN3lCSGtidUwzenU1a2ppak0yMmpvaXZyS1N5Y01Nbk94TGpy?=
 =?utf-8?B?MjFXSk43aVJvRXg1UUJheHdrU25pVjA2RjBZN2I0R0RBaE9tKyt3eVNiZXRs?=
 =?utf-8?B?dW44VE5HeVY3MEVNN0kxUVZUUHZtYmtDQzViK052TnMvNnZ6dmt4d3g0dW9i?=
 =?utf-8?B?SHl2bUR3OURrZDdhVFFSWGE1ZE1IdzJOWnpQNk9mYWlDazZmdFNXMFRISUwz?=
 =?utf-8?B?b1hsVE4rSWhuRUdBdU9yQ0hYOW5Sb0dCYzk0ak1UM3lVelNLWS9WUXMySStq?=
 =?utf-8?B?ZXlnMFhiR0ZEV282UExlWng1R1BzY2RTVllITm5aaStHdUM3bEt3ODdESnRV?=
 =?utf-8?B?QW03S2pjK2RCZlpNN1FwbWhRVkJJU1dyTThXUG5pNXQ1SGVsaTdudUNKYWhD?=
 =?utf-8?B?aDhEVlhkVkVvVHhod2xFTnc0UWZaWVByRkFXNjVDWDJEU05zckJrWDROVWpK?=
 =?utf-8?B?TCtuaTlRc0FsOFVsekJGMDBXYi9iWVdmQ3B6aERuam04YTkxMjRHTTNCSzVk?=
 =?utf-8?B?ZWtZTkVhb0VXdjJlc1VxNHoyZzJtejNKdFh0dTdIaWhaazVtUmVDMXh3bW9y?=
 =?utf-8?B?dUIzRHdiUittb282ZTVOcGNSNzdHRHR3K2VVNUplY01IVEFRUnBrLzJjWDly?=
 =?utf-8?B?RzVGS2grTXNvQ3dKNWhlZGlZL2sreTU5WUwrbzVXNmFjWGp2TFpqdTZBQmZF?=
 =?utf-8?B?dG9KS2pWcUswR211dmg0TmxZb2oyTjhNMnIwVGU4dHMrdkJ2Rkl0Tk5KZDY4?=
 =?utf-8?B?cnZpSzQ3ZUx4ZCtsNVlLZkRabW1pM1V3eDVQd0hwTUg1TlVnZEVFMjBORno0?=
 =?utf-8?B?MHhkMk1UTmkvTXJyL2MxK3RZanZXWEwybVBnZmJvbnNidVA1bkZMQmNKamM5?=
 =?utf-8?B?UWl6Z0xnUzMyTVEwS3Q1M21rT20xSzF4S3lyTkQvV2xLSTRCbldoVTgyNHVO?=
 =?utf-8?B?RC9VSUJ4bVY4K1FWNDVUcW1FV0NSV0VJbk1FODBZVmxEaFJOZnY4UXdNT1Ja?=
 =?utf-8?B?bm1rczRYRjlOOXducndpSHc0WUU3QmxEWHZVSnQyQ1ZrbmlZVGh3a2ROTFZs?=
 =?utf-8?B?Y1kwVkxpbGF0N3B4dTBCL3hwcTdNb2FWNTFJSVdrQ2V4Ym5Mck9hc0FWTFM2?=
 =?utf-8?B?TWVKbFpXOEZ3Z2MwQWlnUGd0Q1Z5K0NkSjJjNUs3UE40cy9tVU9wQUwwbEJo?=
 =?utf-8?B?K0E0aGp5SDFmeDQrVlY0bHJSbzczL1kzTTJlWUt2UVM0Y0lqZFpJOW1ZVDRy?=
 =?utf-8?B?aXN0Zm1hem5tTm1LOEdjY2RsRWROUzAyZnFZWUx0VzJjdnd1N0RFSUtvSjlp?=
 =?utf-8?B?RWRHaG1rdjhmelBlMzBERzlLd2ZUaWN5ZVYrVUhJN3ZibW03YmFVeHVWcENR?=
 =?utf-8?Q?lXoZkDlfo/USyLE+fYzs6atjCo2MW6I5?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9328.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d3lNRUlZK2FEMGhzYU5ldW1zeDNKa0QzbEc4djJ6YVluNC9vaUt3WVZuZVNR?=
 =?utf-8?B?RGpmNnIwS0pWdGFqejNsQ2o4Q00wZjczSjV1VFBYOFYrU1R1WWxaekZGdmZC?=
 =?utf-8?B?Rmhuem5GUDJBS2ZUNlhrNWQ3azFHV0N5NFpOMm9kNTd3M2hUT3VSYmU0M0Jk?=
 =?utf-8?B?NVN2cHVCMTh2TEpuODFEV1Qrd0xNTDFoZ3I3dlBoeWZHOGl5djRENjJBb1FH?=
 =?utf-8?B?V0VYTWpUYUYwU01oTFVPbUF2QTQ0WGhTR1RJL256cmt6OGRldEg0dGhQNVZI?=
 =?utf-8?B?cDJmTFpHUGM3RkFCOU1pMjRmYUZRc3N5WUJtSk10WXFXajZOS2x5dElFZEpp?=
 =?utf-8?B?RjVIaElkbjJsZmRlWWZucmRsQ3lSejBlZno1eWdTdkVHdHhuNzNsYmZ3bmVz?=
 =?utf-8?B?SDN2d09weUJyeFZydEpSd0NPaFlTVStJcG52d2E4aGtyeWx1RldZeUkzUk5O?=
 =?utf-8?B?M1BydS84SnBNNTBnTjYzSTRkSlVxazZ2Z1kwam8vYW9FUXFTUHg1R1c0SUR1?=
 =?utf-8?B?bzh6Sm9XaDR3Sm5tbEtSQUdVMFJ1Yzdwb011ZkxoUUowNDhxK0xFOVFLbVpm?=
 =?utf-8?B?R21pRzFLUVcra09oZlIwd0FnVVdZVW02bGlSWXVlQjZsbkYwTGoreFNkMTBW?=
 =?utf-8?B?NWVPczRWb1doRHlWQ053SEkrRTAxNTR5V3NHYzZ3eWpCRERuQjJmcjY2WWRH?=
 =?utf-8?B?S0dHbGt1YlJHL1NQQWVpTHFzemxKRGNxTGw3Zmo4WHhiZzljZXJkWVMxUldK?=
 =?utf-8?B?eDM3Y25ka2lHSi9uRURWVVBIR3BjamtreHJNU3BzUnlPMVdnQ1BIWFF6WFVs?=
 =?utf-8?B?NWUwTTJoZU92b0tNeEpHeTg3NFlJSC8yTlBhVUxaSDRBOFdVNkhwNDhxSk9O?=
 =?utf-8?B?U2ZGKzI1bHVwNy91YTl5WUljUTgzamlQd2h2SVN6bWpUMkljZjRoRnNGQ2Ft?=
 =?utf-8?B?aVJEVHdoNDNHZ0RTVzQ0TG40UW9JVWRhQnY0MW1pSnV0dkowK2M4MHV5Nysr?=
 =?utf-8?B?QmthcUV0all2UWhHUldYdm54V0tVYXNQbDJUdHVoQyswNEtHdHdVRklIdVB0?=
 =?utf-8?B?V2YybUFtM2NXSDFmNnBLNHozSjhyT2xZTFFDcVErdXF1WDRtL01lbzlSYmkv?=
 =?utf-8?B?RzJwb2NlMWY4b2dKckdqYnlTM3h4TjZGYzlkZlF5M0paQnYxbGlaRXVqTExE?=
 =?utf-8?B?Sm13YVc3UUZkTkgxRWZvK1grVVhIelVLYjN6cTlBRXNoZ0JzMTBTZzRQcmRU?=
 =?utf-8?B?VnlYQm1YbklCczhYSlE0QTlJdXlNVy9EdGFNYXpKMTI2SURnZXRkeHVmdGNt?=
 =?utf-8?B?cjIvTUwrYmsrT3l0REJmUkxkZnV3L1Y1em14bndLcnJ1TUhkODYxemttTmQ3?=
 =?utf-8?B?a3hnRGhUcTlKcmJVOFlFU1I0elRQYzZrRVNnUDQzNUswUXJFY0F6YWNTb3Vs?=
 =?utf-8?B?eWQ2NXZpWDM1V3dxV2FBUnFDZEZhdjQwQnVpdjdLQVFvVUlQOTBkTG0xYkw1?=
 =?utf-8?B?QTdNWVpndjliTW5uaWprWDZHSVltWTJIUFlYYkVyNXVQeUhyTUo1cFZxQTJj?=
 =?utf-8?B?KzZOUGJKdnFSSWZzMXhHcDZPVzFnckdrNEluaHphanpMTWV0NTZqZEpwK1pI?=
 =?utf-8?B?SzBIWDBVU0FPZE9ZL1dwU2dUUVZSRHV5SUR6MGkzU0lUaFRzeWFIMnArVDE1?=
 =?utf-8?B?NTU4VTFsanFZaDQycUxaSzNGWEpQWEEzWVE0YytqcS9YZmZzNlVmRy9obkI2?=
 =?utf-8?B?bDIrR3c4RzZxM0MxVytZc3VITjVSb1lJZ0UrZ0ZjL2NJMzJ5b08zOWJna2RY?=
 =?utf-8?B?bmpsR1k0NWZnaEZFV1FFd1o5QXZ4V2pKRG9tYTZvZTl1MGkvbXN4alpZTmU0?=
 =?utf-8?B?WUFFbnFDUlEzekF4d0gvYWh0RWxKalBoMUhsbTBKUldFTVZqZUI4VXFwTGJn?=
 =?utf-8?B?NFlDY2JpVXRrZDE2VGJ5WW5vcnVycmJtNEZKV1c2aTVNZm02WUdGVjNyamlN?=
 =?utf-8?B?NlhIdE1aYVVMT2ZkUXRjclJhQ1VCR21uRWxrQmZ1QldKT3FLVnFNSE1SM1Rt?=
 =?utf-8?B?NjNieGFRUFRwOFZYSE9lUEkydWRFR3ZRVVZXdFdMS1h1bFpITk5ma3c1aXZM?=
 =?utf-8?B?VTRjQlI0ZnBrVEpvK2Q2bFlFZ2h6ZW1tamJBNWRZV24zU2ltTmRqZ1hBUFRn?=
 =?utf-8?B?MHc9PQ==?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d85db44-1fea-4bb8-0bc7-08de0c0017a3
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9328.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2025 15:32:47.5371 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qq0AHfu97wwRsp7QsE9yyEHrMCrQ5dlJpkYQ8op+Pywd4pLXXzs7bkrhD/YuzF/O99RGhlbbKfTCBviTD2xO1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10363
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


On 14-10-2025 15:47, Gagandeep Singh wrote:
> adding a FQ shutdown functionality to ensure proper cleanup of
> frame queues during queue setup. This helps reset the
> queues reliably and prevents potential resource leaks or
> stale state issues.
>
> Additionally, update logging to use DPAA_BUS_ERR instead
> of pr_err for better consistency and clarity in error
> reporting within the DPAA bus subsystem.
>
> These changes enhance maintainability and improve
> debugging experience.
As commented before, please break it into separate patches for logging 
change and logical change
