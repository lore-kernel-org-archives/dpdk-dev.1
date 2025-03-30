Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38F3EC28B20
	for <dpdk-dev@archiver.kernel.org>; Sun, 30 Mar 2025 09:49:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EE0EC402AB;
	Sun, 30 Mar 2025 11:49:30 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazon11013056.outbound.protection.outlook.com
 [40.107.162.56])
 by mails.dpdk.org (Postfix) with ESMTP id E2AF6402A4;
 Sun, 30 Mar 2025 11:49:28 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G1HXpRMBP6jpCLsiiynAqR1eNmQnf/wkkWpbmLDVvB71MeMDuy3XRezpYvBZdkNFMFxGAU4rZGE1jVm/sB7JL9gkvy961NwAn6wP2AIZ/hdea/+UixB23aOTqWUPZpBWnSQtB6/sABuZRk5Hb+MqgsE3drdDClEpONHSNngiz/Zwb9KSarhQ8mQWxu243u3XtGK0KoUHTbNHrRc/5Nlca+HIQnd1H4YESyWpUGR5D+/5+oZcMpDJnhJGns/6FI4JHQr9ZXPr2ji5ovHBfoTEQ2ocW65bQtWIc0D/TfY5IyN11u2dsFFAbHiYsLeJ53xgzdIlzCxiUJ6aV2o0Ocv3iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fB8xIOh6qmugFdP+hPWjIYqsONqE62xBuk2lH/vgSVQ=;
 b=isf6yDxNHGJZ2KrOsW5BuwsS1jQO3Qy6vgbU3f+niv//26UdjjTPwFqOtpubNoNECqBvWC8Faa/Vxe1e0MDtm1Ptw14OKEsztFP2Z+fcBIKDaOm6fvyn36dF8c2Aw7yajKy6aqlDw86JzfQQy0czV2PUEMRZYeZ4+4BwYDOSshVm1oHB2f22gT9MRmwO6XjQan3pwf8Fhq9RqfyPpNHGDIEL4tWXS4gf3GWSZM4JBMYSJKqo4dYL80hA1YXbyF89F9F/ccVQe7UJc+WlCaNqR2iM6RP2SGGOzjqbOb81lK3cyY1VAi/0TEZMlnU3/zgG2ompQtnKxMyxJEJ1YEV/4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia-sbell.com; dmarc=pass action=none
 header.from=nokia-sbell.com; dkim=pass header.d=nokia-sbell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-sbell.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fB8xIOh6qmugFdP+hPWjIYqsONqE62xBuk2lH/vgSVQ=;
 b=Aojl/o+XnkvG0liVYtfJKlyqoJ65JLueVt0AHA9ULnMYIUpH5J/g2mCJmABLjDpMNsV/zWvfp8b86NTzErQsHVSjegt2kgB9L4vfqaOK3t5otgkcjqAD/kqCHGs54Wz/ElbvSdaGWkq21ReI00ks3leq/6RhTYg1lIel3jX2H9htdrcySC9YJZF0tOOcCwQuO+HiTmqHjF6/Of72O5TLmXweR46EuQBJVq6TJIYpgptVGAizM5lznqBddkwhxUvq50AbgsfN9TSnMaqSu7GGn4pp3qDj4M3mW85hxL6jV4rVHCvtDJ5UDtHkLmEeLTYIZh8cr038QTZZwYLExDv2YA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia-sbell.com;
Received: from VI1PR07MB9898.eurprd07.prod.outlook.com (2603:10a6:800:119::6)
 by PAXPR07MB7885.eurprd07.prod.outlook.com (2603:10a6:102:13f::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.37; Sun, 30 Mar
 2025 09:49:27 +0000
Received: from VI1PR07MB9898.eurprd07.prod.outlook.com
 ([fe80::1928:4afb:4eee:1f21]) by VI1PR07MB9898.eurprd07.prod.outlook.com
 ([fe80::1928:4afb:4eee:1f21%6]) with mapi id 15.20.8534.043; Sun, 30 Mar 2025
 09:49:26 +0000
Message-ID: <941b7789-cbf2-472c-b61e-baec5569669b@nokia-sbell.com>
Date: Sun, 30 Mar 2025 17:49:17 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [External] Re: [PATCH v2] eal/linux: improve ASLR check
To: David Marchand <david.marchand@redhat.com>
Cc: Stephen Hemminger <stephen@networkplumber.org>, dev@dpdk.org,
 stable@dpdk.org
References: <20250228094405.1437-1-ming.1.yang@nokia-sbell.com>
 <20250313061904.1466-1-ming.1.yang@nokia-sbell.com>
 <20250313083733.203d132c@hermes.local>
 <9fa6a076-e187-461f-9899-a53e891efb21@nokia-sbell.com>
 <CAJFAV8wGCJhHBMTOz0+PYqZRzFRUrO_zy8UzF8s4EVyqG8N=rw@mail.gmail.com>
Content-Language: en-US
From: Yang Ming <ming.1.yang@nokia-sbell.com>
In-Reply-To: <CAJFAV8wGCJhHBMTOz0+PYqZRzFRUrO_zy8UzF8s4EVyqG8N=rw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYWPR01CA0046.jpnprd01.prod.outlook.com
 (2603:1096:400:17f::10) To VI1PR07MB9898.eurprd07.prod.outlook.com
 (2603:10a6:800:119::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR07MB9898:EE_|PAXPR07MB7885:EE_
X-MS-Office365-Filtering-Correlation-Id: a16673c8-2f36-4e91-254e-08dd6f702857
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RkVMSE8zenJ4V1RmVXFkSnZqN0MvU29FTGM2U0NsUW5jOEw2Nnc0aDRQQURl?=
 =?utf-8?B?VzFFbjVITGR2RXVITUhvSFNPMzFLSVBHSngvcjFzckJnRG1Ddmh4djhpYzND?=
 =?utf-8?B?Q0ZPUDl5WFAvbEtCS2pwYnZDYzFiLzV3OHhiQ0NGYVJBYnhudlZBLzI1dnBx?=
 =?utf-8?B?SmZ1WFhadmFTMXRhMXExaEJNN0dQSG1QbXFLRzVTZ0lFbGhMQk9iaXlRTWd2?=
 =?utf-8?B?ZzZwWVRCeUlNeVBJMkQzcXY3K3Y4QVNjZ1JNd1ZacXRxTEFnM01jYzh0SG55?=
 =?utf-8?B?Vk9oeGs0RitsK0NxK2xZMkZzT2MxRmVQRWF2WkFSY1ZONGJueUQ0VERsUUMr?=
 =?utf-8?B?UGFhdzQ4L1NkVm1RQUdvOVIvMHJ5ZnBLb0FmV0tyNGUrTlZrUWY2MWxhZ25I?=
 =?utf-8?B?RTM1VWUzNCtsRHBGQ0VvUk13OFlZbXVTdkRVOWIwM2Foc2ZRMmdIVlFrVngx?=
 =?utf-8?B?T2k1NXZpUWJMd0FMb0JBM2x3R0F6V3IzVGR1UVJVQngzK2g3RFFnTzFuV0NQ?=
 =?utf-8?B?NmVCWGJLQVB3bXlYTVpyUnBkb0xVTTQ0Z282NTZ2VkR3Uk9kZ1VHbCtmRVpP?=
 =?utf-8?B?b2xWNmFSR3dEOUlBc1plcklGUTBKWUV1S08rbGdvT0h4OTgrekl1cjVEa0U3?=
 =?utf-8?B?SXVDemxRL3lPRVNhWW1vMTFrVjJleEZhc3hxNndsRVFPZlhDbG1NYnZxNlpR?=
 =?utf-8?B?YTV0bERVMTlacEc1TFNVR3dpbGFOMC9HUXd3K0tOUDJqRFhJbFdueXQvVVZj?=
 =?utf-8?B?a0hZNXgrckpLYTBrVm1XeTRjaUdjNWduaGdTaWU1SFZwR1Y0SittL3kzRVJF?=
 =?utf-8?B?cTR0dnFHbUlNM1JoQWZDWk1HeUQ4eWlmbVQ4OXM3MlJ5U3NjbHFGM1ZxbDFP?=
 =?utf-8?B?QXc2NjIvNGRYaW92enJMaHVZZlBnU1I4L0Fwb1JpUldJeHhlbk5rZjFaL0c2?=
 =?utf-8?B?UzQ2MnFEZmJoVWlOejlmQ1NCSTVXQXp0RlhGaWU0QVJuUEl3QVZRQzhvRFhX?=
 =?utf-8?B?MVFzWXd2NE5wckl4bzR3bkpPRklMeTM2MTFVRGd5d1dlMWlwSVZVbDBmaTFB?=
 =?utf-8?B?MjNKYWhROHRYdVFPQ1RFWlJXMFAvOW5DREpDdmFiUWx4aVZLZm5KV291Q0pJ?=
 =?utf-8?B?STk1MFhXK3RVcTVEVW02cGc1SVJ0NGN4YU5EQmhtREg1TnU3YlcvWWVvUzdI?=
 =?utf-8?B?Q01DWkowT2MwSjVtckE3V2oxTXgwamZlNmJUUTFWKzhYN0djSzdSVEFOTWpx?=
 =?utf-8?B?UllKUE82ZnhOYm9GNi94YU9RUzlHR1JIMDlrSXoxNmNiMDlOZTdCSVZzend5?=
 =?utf-8?B?anEvR1pXNlBraXdxZkZYNEV5TmEwNkdWZXRPS2gyRVBSekw2N1lKa0lLTnk0?=
 =?utf-8?B?Q3hvRUIxcDJRUHhDTzVoV0tja0M2bzRjSTRyV3JFT0R3b1JTdElyTVIzNVc0?=
 =?utf-8?B?SnplTnRoMWhCOU5SaVp2MCt5a0pOYmNrQVhFOFA0V0N0djVHcmlMZFNtcjhM?=
 =?utf-8?B?UmZWM0NsdlF3Y3lFd3hVOHJkSTNKQjN5NllFQVBpRmdvQXN2Yy9jT2ozOHE3?=
 =?utf-8?B?L1JZZmpMb0RITDNOZi9HREJwMUFFc1pCc0doQ3RySFBrczlDdGFXdGIzd2RP?=
 =?utf-8?B?aHhjU09WQnVVUUR1c3VpOUoxNFBhYTU2blljS3dBUERZNEozbmNkZTM3MTRD?=
 =?utf-8?B?K0ZoSVhnT3RzWnYzeDBINlJTQU01cXF3R0NnV1FEdEdhVldIWEhFNGgrUisw?=
 =?utf-8?B?NldZcGo0SnFGY2tCcThrMDNsZE5GbERtUGtwOWZiVG9ZN2REOEpTNDl2OWtZ?=
 =?utf-8?B?a083bFZQRmYya2pjcmN5YnBkUWsxcTR0ZG5OakYybUZWWnVxaTI0S0RwblI2?=
 =?utf-8?B?OEVPQWxhc2pGNlc3RTlaSFY5RFBOc2tqd1NsajJuL0ZwV0JpQ2doZ3IzYnVN?=
 =?utf-8?Q?N1jA5jYY6zc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR07MB9898.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MkhoRERuY0VXalJLR0ZpeUloM3BQanp0ZmdCcmZFUWh1a0VmK3RrRmc1S1dn?=
 =?utf-8?B?QTNQUk9na1lzS0tuT0ZtWXUwSVhDa3VkRFJxeVJJd2UveHdLa0wrc3pHSHVk?=
 =?utf-8?B?VDRtMERVMC9vdzM0RlV6dGpPWU1ZbHF6enozbVcyb2hiTkRtQ2xDZ2xmZWtr?=
 =?utf-8?B?M0dMSmNCTWFsUFpmcWNzK01laTIrSWIrY05FVzArZXEwVU1oNzQ5aFBvMnhP?=
 =?utf-8?B?TFVTaW9nYmxpWFVFMnhjN0tGNlpJQjUva0hPM3NYK1UyYW5wQ0VkQVFjNmhY?=
 =?utf-8?B?cHU4VnJjUnlhQ2VwNm5UTmwzdW1CdkJhQmdwcy9MUnFVWlhUTjJpVGFXR01u?=
 =?utf-8?B?c01zbHY3VnNubkVTdjEydWlwcjhMRmhzZGZrTkZMZnhiSTFsaU9qN1lPcnI4?=
 =?utf-8?B?dTFDd3RreHZJc1lJNnJWNng3LzJmM0ZqQW1SSWM3L24xU0dNTjlJY1QxVzhK?=
 =?utf-8?B?Q0FtbVFhTkJPUVp1enpiY0EwMVdpMGhyRGZmNE16MVRvelprL21WczU0WTU4?=
 =?utf-8?B?VmIzZkhRRTFnR2ZwWTVBL1RtaSs1L2h0aHFXZ1F4WGUxbS9hc3J1R3pJUnd1?=
 =?utf-8?B?czEzUEdQR0F4NGNwbmpBSGVoNC9oeE13cThIaWJoc3FkT0c0ZEQ5andmZHBS?=
 =?utf-8?B?dVVLdzdXRzNkZzhjMlJaV3NwK2JRVnZpNXFDNmtaeEltTkQyVUVnYTYvSHVQ?=
 =?utf-8?B?RVRWYlgwZDlIaUpYdXlBOTlTa0lKV01NYStUMFVMYllvcW9jUzVRRGV0dkZo?=
 =?utf-8?B?ZjlUWHpJQW9WREo0MEN6OHlkd1RxNHJ5OWVpb25YQm9yNDRRZGdoeEV1UjRn?=
 =?utf-8?B?MmZpVDN3MDRNZ3pPY3UwVUR6aDU3UStmSUxES0Z2ekVhVzlpUXJMVWcva3VQ?=
 =?utf-8?B?aFgzSlYxczQ5VmVMU2JtZm16OEQ2QmQzc1RRd1BiTGtTRUNXZndySG5KL0kx?=
 =?utf-8?B?UzBiaUJUZ1EwbFY0VHV1L0Nwa1BNZ0N1MHViY3NiVVNWaWRNaGRYa0dzTVB1?=
 =?utf-8?B?N0V5RUx4Tjl2RHRZMDdDblMyU3BzZTFONnBFeVpHcStwU2RYY3FaeU9MeXNj?=
 =?utf-8?B?aVpnZGlrb3YwdklxL1pBOEtIektZUDVpdXF0TlF6ZVZMTVZ4UGV3NUN5ZFdl?=
 =?utf-8?B?ejVueDNZbWxNTGYyeCtabHdRVCt2WXNGM0tqWG05QlBaUU5EUUJCVW55bTJS?=
 =?utf-8?B?VUVJdWhsdGVBQ1NiMVY2SXQ5andDNE5rS0FYVTl2c0ZyYkZlN1REUFBvMktF?=
 =?utf-8?B?c210eERDOHo0cG5CelFUTmx5eDBxUnBuV2trZmJtcG5EcjdGTkk2VHNZcGFq?=
 =?utf-8?B?Sm05bE1udlFwYkF1OGRqcG1tOXhJcnRQNFFVNGhvK3pXTEljdzNQR1ZQeGZ4?=
 =?utf-8?B?dXkwRUpacU9vcGFqOS84cEdqWGlSS3ljT3JkbDVvNWdKTXBoTzU4cnVPNzlC?=
 =?utf-8?B?MzNsNWFNWFJlZUJ0THQwSUthWmlKUFZEWmMxaktmQ2crRzY1cG4yODBLVDhy?=
 =?utf-8?B?dzJHWE8xem96bWtQSGkzMUNRWDNNNm15SE4wWDlwRGxZdkhia1FzdDZ6Z0Nl?=
 =?utf-8?B?TzdqcGtaS2djZ0IrdENzWDZrYld0S0pMUmdaTW43bGs2VjZoMVl4VVpacWVH?=
 =?utf-8?B?VHVsSGI3VWMwL0dkQW9Lall4eW9hbENsVzNYREZuVVl1WFpTaEpObFc5cWl2?=
 =?utf-8?B?RExYdEQzM1EvNUtkenk0Sm16ZWlDTTI3QTM2R0o5UHptNjJFYUFqaVJrSCtI?=
 =?utf-8?B?MUkxS3JXTWFpMGNOMnBId09nZ2lTRUNlTUY0Y2FRTWpSdnhDd1NJZzFwY3hT?=
 =?utf-8?B?LzJlWWVUeXlmWmR6K3F1dVgvTUNLVDg5bWEycGRISmVpT3ZTOS81aFFnWkZZ?=
 =?utf-8?B?VllDUXc0M1cwTVd5eElIK1I1ZEJFQTNoK3k1QnovVnFYRGswcXFPVlZidjE5?=
 =?utf-8?B?bXYwZjNoek1kSjl0QTZabHNLM1VIeVhNYkpwVXNpR1dka3l0Tm01Z002M2Jw?=
 =?utf-8?B?VEU3dTNsUUtHbWRJS0pwZE1HNENqWGRTWFJmS0hVNzRjcVdoNGpjeU9hWkhC?=
 =?utf-8?B?dE5adXF5eWJrc3BGTUZlcUE5d21SQ0tsUW1SdXhucjBOZkl3dXoxTGhnWUJ1?=
 =?utf-8?B?aDRuQ0ZKT3dSdWdBcml1VFZYWTJsMmtBV2lnSmM3TEFUOXY4Q2ZrTmY5eXFi?=
 =?utf-8?B?MHc9PQ==?=
X-OriginatorOrg: nokia-sbell.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a16673c8-2f36-4e91-254e-08dd6f702857
X-MS-Exchange-CrossTenant-AuthSource: VI1PR07MB9898.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2025 09:49:26.4865 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TKtPiszUbvw8D/TSdsNaaIcjrd28WkWLK5nk/eIG7B7SFQAncNVmpj9fYf1f0Wal7hvK83M4smOsMcUAJAP0mgmQtiAW0J6v5grs+Q3FlAM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR07MB7885
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


On 2025/3/27 16:14, David Marchand wrote:
> Caution: This is an external email. Please be very careful when clicking links or opening attachments. See http://nok.it/nsb for additional information.
>
> Hello,
>
> On Thu, Mar 27, 2025 at 9:02 AM Yang Ming <ming.1.yang@nokia-sbell.com> wrote:
>> On 2025/3/13 23:37, Stephen Hemminger wrote:
>>> On Thu, 13 Mar 2025 14:19:03 +0800
>>> Yang Ming <ming.1.yang@nokia-sbell.com> wrote:
>>>
>>>> This change ensures that the current process is checked for
>>>> being run with 'setarch' before verifying the value of
>>>> '/proc/sys/kernel/randomize_va_space'. The '-R' or
>>>> '--addr-no-randomize' parameter of the 'setarch' command is used
>>>> to disable the randomization of the virtual address space.
>>>>
>>>> Fixes: af75078fece3 ("first public release")
>>>> Cc: stable@dpdk.org
>>>>
>>>> Signed-off-by: Yang Ming <ming.1.yang@nokia-sbell.com>
>>> Acked-by: Stephen Hemminger <stephen@networkplumber.org>
>>>
>> Hi Experts,
>>
>> is there any chance to review and accept this patch?
> I just merged rc0 which means the patch merging fest is opened.
>
> I put this patch and a few other EAL patches on my rc1 queue, as those
> changes don't belong to next-net.
>
Hi David,

Got it. Thanks for your update. Looking forward to seeing it in rc1.

Brs,

Yang Ming

