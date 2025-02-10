Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE4C6C02198
	for <dpdk-dev@archiver.kernel.org>; Mon, 10 Feb 2025 10:39:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 177A740EE4;
	Mon, 10 Feb 2025 11:39:45 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on2070.outbound.protection.outlook.com [40.107.22.70])
 by mails.dpdk.org (Postfix) with ESMTP id 064A540268
 for <dev@dpdk.org>; Mon, 10 Feb 2025 11:39:43 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lV41rRoxK5axFNuF9RTGS6PU6ZnikJ92YkUjq9+INCL2xZ0wR5tgbzh/z47M8yL9E79dT2MTDrfs0JTWAifHc2ApLdGObtTIsOhJqgiezTBiPwzIq8KvZSwrwK4pUdAFeQlh+0us3Fk906KVZjlGD33b7VU3E0lQuiXHxOqEzND4Re/BCWf19BP9UN64JPAtOOFv6PNtqHa9b4gfZyXLQYsOcXO+yyY8o5Mxlq5SLh2xpAH8s0XHVYNkAKJvGhVaD+IlPf/ol6y0usfatJlBDuWnfLBm5asKWdV1TXJpb18dKeXyw7dmjqbXERf0z3ThIWpK3tS+1TEQuTOCeKqb3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TgK5zXE8xDYrJQ6Tne4kEz5XZnPW81Le6PAIfbdskyU=;
 b=dFBxyzcUrj7VUL+YEexxwnmZH3pOZHCapL7rfBUXrTPIs5+dSYKnOTGl91KRxzHgPK0vLE5lNZZBNm0Qp5QJ1JBXwZG/PQavcwDhelxq4um/+jul2dDynCDB2FvIOhxT+Oba12AQq1GityumGgvmhwz/FcEy4MaS2IXKk2iPOACswbkW0n5a10oUsPXQxkQrhHx1U1bpkdtkmlC9IBG3MRYy+npEiOncfphrlc56JSUs5hQU4aL8nRQAH0rYIqphkn8m7zNJoz83wE9R69k5o2yVKB9G7PE8QW4wEnLrm1bnwvXDwbNMslwSBdfjFUCKUR+XHQNvKnK4U5xmPh9T9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TgK5zXE8xDYrJQ6Tne4kEz5XZnPW81Le6PAIfbdskyU=;
 b=QLCPGH4y8/8jh/54A5ZBHT7d9VmbtFzYHknXBygp/GWmN4dVTvj1aRaABpTcqsaghXP2XBpjnSDKVL2FQE9GO60KWSdpALqJKSyoc+XiiBF66r+55+7ukYUUU2Wq5zDj41FL5XcN6sZKm7lQzl6NAEEoRyJiF+18Ao/AxL0Z5xafdyJMe4wZteJ2lcYdn+HBvmyCz94eV1MsRZCY92XTZwGJ15vfWjOV+qpCAkocvMvH9meZQMfaklQ6xrbjyMu68+NwAlXPp82RXyUr0wgQMqSBFMJu43rZWk5RDevIHFPn488HVRmktxDCcXgQ0JJBv7dl4wd2Loj+DoLMt29ytw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9328.eurprd04.prod.outlook.com (2603:10a6:102:2b6::15)
 by DU2PR04MB8936.eurprd04.prod.outlook.com (2603:10a6:10:2e3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.19; Mon, 10 Feb
 2025 10:39:41 +0000
Received: from PAXPR04MB9328.eurprd04.prod.outlook.com
 ([fe80::367:d59:375:fb87]) by PAXPR04MB9328.eurprd04.prod.outlook.com
 ([fe80::367:d59:375:fb87%4]) with mapi id 15.20.8422.015; Mon, 10 Feb 2025
 10:39:41 +0000
Message-ID: <d5293c42-0a07-f347-b127-8dbd7d609ea6@oss.nxp.com>
Date: Mon, 10 Feb 2025 16:09:35 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 19/32] net/dpaa2: replace memcpy with assignment
Content-Language: en-US
To: Stephen Hemminger <stephen@networkplumber.org>, dev@dpdk.org
Cc: Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>
References: <20250208203142.242284-1-stephen@networkplumber.org>
 <20250208203142.242284-20-stephen@networkplumber.org>
From: Hemant Agrawal <hemant.agrawal@oss.nxp.com>
In-Reply-To: <20250208203142.242284-20-stephen@networkplumber.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0051.apcprd02.prod.outlook.com
 (2603:1096:4:196::10) To PAXPR04MB9328.eurprd04.prod.outlook.com
 (2603:10a6:102:2b6::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9328:EE_|DU2PR04MB8936:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c3ce0e4-85c7-40fa-537f-08dd49bf3992
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TjllbHFnVUJScWFNMlVSRkpVWjF0ZG15RExObzNISDJ2QVp5QTlKbnRoVFoz?=
 =?utf-8?B?ZnUyV0Z6OTZqam45amJwVkEzdHFYR0lIblB6MUkxVFNROXQ2ZVhMK0x1dUFQ?=
 =?utf-8?B?b2ZIM3VXT2F4N0RJdnBxdUNzSmV0ajViRjRDYTN3SUZJNDlLelhYdm9oNHIx?=
 =?utf-8?B?TndLQ0cvN0Rpb3I3T2EvRFlGWng5MjVmSmpNU0ZsYXBaM0RCdmlmaDkwNDJE?=
 =?utf-8?B?aXp3OGFTVGVGYnY1bmR1VFhlVUFQVmJ3TG5mVTQxWk92WWJHUkRBaHhyaUVh?=
 =?utf-8?B?Ui9aYzlwTWIvM2pGL0ViQzAwT1RUVDRZOWx1cEFJcTMyeGhXcmdhZlU3T01K?=
 =?utf-8?B?cXRDY0VycFpLNHpKb0p1VkwrNmEwc2pRbWNRbDFtZUVrZHkraTBkQnVJVWNE?=
 =?utf-8?B?eUo0Ym0xTHcrZ0Q3QkVPR0I5eFBZSmNNSk1hblVOQnE1N3IreWZmRTQwcXlh?=
 =?utf-8?B?SGFkNGZIWVdJclhua0pyUzRFMUFXVlh4ZzVTRTUxL2FLUlFzaU56dU03S0xq?=
 =?utf-8?B?VVlYbG9WTUFUZzZKZTZFY0Z3N1d1Z2MzY1N2S1g0N1BmcFlJQ1p4eEp5TXNz?=
 =?utf-8?B?dUx0TnExNmFQR1NtZDVubzBJbUNmT2NrVGN1UVNCZkR1YzB3dUU0OHBIMXN4?=
 =?utf-8?B?cUlVdkZ2amRCdDdxQXhabk1hdWxjVERLNFlCOUZvcmtqenpaeDdoN2pxRGJn?=
 =?utf-8?B?Rm91Y1FvNGd1dDJTSThMdlN2U2t1NGpqWk9CUUhmTnBDWDB1dTZoZ3cxL2Jy?=
 =?utf-8?B?anV2by9oaTRWTHdsOTdhQ2hnSi8xd0VhSkkwY29tdkYxR2txby8zTHVWbmJW?=
 =?utf-8?B?Mk5VNVRqbkU3K0VZWmd1ZTVFdGlBNUxHRDBMTm4zdHU1dTk2ekg2QnZINnor?=
 =?utf-8?B?bzhJeEUxM0Zva21tZEYrRjIrQjNTYllUU1UyT3JGcWtpV0dZL1BKSjhZUDQ5?=
 =?utf-8?B?QmxwSTNKY0Z6cUtiOU1EYnpic1dmMmpSbG1Gb2VvL25vWWZ4Qy8wdmZYclpM?=
 =?utf-8?B?TU1vNVFNams5YjdER0JVUExQaFZTdXM1a1BtTU1mdlNSWGZVbWdJckp4SWJv?=
 =?utf-8?B?Sk5WUUZSb05haStOb2dmc3YvYTNBK1I4bWRaSU9ZVVBmN3V2eExqc0prdGpm?=
 =?utf-8?B?ZFhpT3MvOW9vWTFSMjhlU3ZRRHRtV0RxV1pkZDVTTG45MTFpeVRGdU9DVHhW?=
 =?utf-8?B?aGx0U24ySUJ2K3pYTmtEWkpmOWtXYVhQMjlzYWpNTW5WQ3JKb1RMZHVQaE8x?=
 =?utf-8?B?eDZpNyswTEZrUk9YN00zc1ZQRkJsbk9mbWtSSjJyUDJRZ3Nxcm5nMFJPbXUv?=
 =?utf-8?B?QnN3RzhWQlUzZVBZYUxMTGord0JYc0pReGNmYS9TQWswVmNJcGJObXpNVUV1?=
 =?utf-8?B?WFgzTWdXNjVjNS9OVXhPMXlUNXNJbStSTElDREtjUXR2VDJGOU1UUHRoU1BK?=
 =?utf-8?B?NG83OXEycUJlZHQ0WklSRkNwMElOcXAwTGp6NkIybmFxU0cxNmttYkt3cEdi?=
 =?utf-8?B?SW51bFhGZnZxRmVPdGZIR1N6cm55YTMyUS92VEVDM3ZzYjBLeEtoL3g0QVFw?=
 =?utf-8?B?MjZnRlp4ZlJhSDlFb1BtNGJSWGkxbkJQYndaTnNNTUZXR2toNlpRTnU5QUtw?=
 =?utf-8?B?TUtBN3I1RzdOaEdSNlJsT21UaEFyQUh0K2dDZDJLTEF4bFErVzVnMnh5UWJB?=
 =?utf-8?B?WmJWcjdkdERodHduOXdnZmVsYndCUmVxUXFPRmpQQ0p1bGJjc3A4ZVd0MlBT?=
 =?utf-8?B?Uk0yb0xwUGV6R0xURFprTTlTVHdrY2ovUndxUk1tWDU1MkxSU05oMEpXZlls?=
 =?utf-8?B?aE9TaWFFVkRKWjdqR0o1MVFaN3dRWEVRb2NEUnlvdkpDTWcydThRdGE3NlVE?=
 =?utf-8?Q?a6kfBEhFVzsoo?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9328.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SkhWUFZ0dnJqczVqM3hBOVd4YTZZSUtYWjFHRVBzdERtbEw4N0o4YmJkYVdW?=
 =?utf-8?B?WjN6WGNxbUNJU2VsbjNYYlU1S3U2WFJQd1cxMENKQ1c2bXFmWlFCOFRBTy9O?=
 =?utf-8?B?WDdlYm1acmpQVU5VWHNJdVErQUYxbnRNMG95Zy9pWUt1VUxjL1k0a1FnZHl2?=
 =?utf-8?B?Z3VMZXhkZ1hpbk51RnF1N2llSURhUGF1UnBDYTFVb0NFQUxuWkVYNnVQODNV?=
 =?utf-8?B?alFacnlGQTgxUS9MK25aTndqS3Vsci93QnE3c0V3UmJaeVZyK0hrVkxhYlpn?=
 =?utf-8?B?MlNkNnlGWkd3dW5xdWJjZTRrU05mcHFidnMvMEwwNGpVM3IweU1TQWp0bGlT?=
 =?utf-8?B?VmthVnpoMDF3ZW9pQ2Z6QUt2aGUvekVoT3lXWkdPNFQ4cytySC82NFpzd1E2?=
 =?utf-8?B?SmpJRm10b3V3eitnRXQ0Z0FHR2dhK2hvQmZZYVJwQ25WajVPbFZudlEwWUlH?=
 =?utf-8?B?ZHhiQUtMdEgvbmVPQVVVVFkxV0JZZEJQUTlPcjR6K0hVK3prbDZwSDVGTG5n?=
 =?utf-8?B?WlphLzlnSktPV3IrMUZScDd1anJOazhNNjRzZFllL3pzc0NOOXJSRE1PUWFp?=
 =?utf-8?B?ZlY2cXZ2RDVxbzdBSHFQTVUxWSttOHlpMDFGeFFYVVhoWWdBTEdkb1VRcWZw?=
 =?utf-8?B?VDlGM1VIRXRHMEpCUGgvS0xGQlRpbjA2cVM5STZRaEYyMFg3T2dudVg4MXp2?=
 =?utf-8?B?S0xtNlRYb1oyd0NCNzNsNnlULzYya25nL21lUm9NL2dRY3ZDbWowU0tVTXE2?=
 =?utf-8?B?UDF1aEx1eDVlbFIxbEJZTUk3OENFZjdVL0V6YVpYRVhONDVZcU1mWEJ4aGVF?=
 =?utf-8?B?VUcvbVBpUmZKeXdtZXVhQ1Z1cDNYUVRoaVZERVc2WTRHWENiQkdDY0IwYUJx?=
 =?utf-8?B?UWlaTk5LQWpWSnNBSTJtVUxZa1krTE4vL093Zis4eTJRUXo5dmk0cloyWHI2?=
 =?utf-8?B?emxvU0grZ2ZmbzA3MGVYY1Q0djZvOWU2YkVoejhidXBzdG5nUkF6b1E1M3Bx?=
 =?utf-8?B?VEl4TkQzQTFYUE9sbUU0cnladVZ4cXJEV3gwejUweG5yTldNNFoyNTBRNlps?=
 =?utf-8?B?bTVoKy9PRHNvTHVGcWMwMGVSRjBCcmRPbVpLY2YwTVVNamdqbFVPeXFpOEdF?=
 =?utf-8?B?RXBnQ3ZkeU54Z1NYa0VNM2d5ZS9PaWZ2V1ZjOGtLd01vNjZGeW96SFUyMFdP?=
 =?utf-8?B?SVp6OWprSXlhcjBTcWxSQytCdjkrVlZyTVd3OFU4NlNGQmhudFJFbjJWK3Ex?=
 =?utf-8?B?OW1SV0F0T1pud2REL0NvMTdZR3FpRFE4V1VFTEdQTWFnYUYvSVM1dEZpWWU5?=
 =?utf-8?B?d2JuWFZ5aWZzYWdyUDRialdMWVpLd3ZTU3Ixb3NHMk91NGc0K1ZteTQraVhD?=
 =?utf-8?B?V2pRbDhxcXR3QU5sUHFJcWRDck9LMXJXalhrcWsxYjRaWVR3T3hTcXZUUWZp?=
 =?utf-8?B?dUNrZ0RrTkduVjBMMVZZWVlEeXNkMzZudkNtZldQWUhSK2RVMUFuNFIvV1hP?=
 =?utf-8?B?ZXBSQnlSaHBsL2VUYjIvNE5Qd3lIS2VHNU1XVExFcWdrUXJ0ZHV0T1ZZL2NZ?=
 =?utf-8?B?dWNNdkVBUUVUWEFOWnJMZjVTMmtQNGNYcjM1TVhoR2hJa2JySVp5bFRLR0Rr?=
 =?utf-8?B?ZlA3ekFPRzNDekRpZURFR1RseUFhazdIOWQ5RTh3cFRiaGNPOStGSWcyYUdL?=
 =?utf-8?B?YUg4WTdwcVFzdUd0Z3IwbjE4c3BXRHVTUFllS0NVQnErM1p0L0taRU12SVU1?=
 =?utf-8?B?NlR4UVZsV082VytmWGV2Nng1NU95d3FGL1N1NWRpUjlVRG9CQW1wUnJMaHF0?=
 =?utf-8?B?MUc1eGF4QzlPODNiZGYrNlNDUU0rMEZUTHJpVlZ5REVBbndTVkUvYWRCTXV3?=
 =?utf-8?B?czhLSERKUEt1V0p4Nm83UGZFMU43MWtZam9tTnB5QjB4OGc2UjBTZW1nekZL?=
 =?utf-8?B?MWZvTGJVdzVWTHVUUW5SYXpELzFHeDdNa3RQeUEvRjQrMHdaUkZEd1E0SkR2?=
 =?utf-8?B?cEp2QUlvV0R6MURrZEExMlY0ZEUxUUtsMjk0cnZBNmVVN0VndEVybzR5cWNV?=
 =?utf-8?B?cGtHN0F2QkpzeWM5OXNZd0VaQTVjVGYyempJR3p2ZGphMTgrbTg1TEhESWp6?=
 =?utf-8?B?NjI0c3pueTliNTFXSUFOWTREVnpEWEZTVnNpZFFwTmhaZVcweXhsNWxObnJj?=
 =?utf-8?B?Smc9PQ==?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c3ce0e4-85c7-40fa-537f-08dd49bf3992
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9328.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2025 10:39:41.2606 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tHzwzgTpnyk1ruQPvAqwyuT6yhgc0272Jhxn2z6h3nFvtacQySTzw7qawHXL4gLH9cwICI9WlNIGYpN5JLz5Rg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8936
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

On 09-02-2025 01:52, Stephen Hemminger wrote:
> Prefer structure assignment over memcpy.
> Found by cocci/struct_assign.cocci
>
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>   drivers/net/dpaa2/dpaa2_mux.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/dpaa2/dpaa2_mux.c b/drivers/net/dpaa2/dpaa2_mux.c
> index 2f124313fa..3f259cd16f 100644
> --- a/drivers/net/dpaa2/dpaa2_mux.c
> +++ b/drivers/net/dpaa2/dpaa2_mux.c
> @@ -293,7 +293,7 @@ rte_pmd_dpaa2_mux_flow_create(uint32_t dpdmux_id,
>   				ret);
>   			goto creation_error;
>   		}
> -		rte_memcpy(&s_kg_cfg, &kg_cfg, sizeof(struct dpkg_profile_cfg));
> +		s_kg_cfg = kg_cfg;
>   	} else {
>   		if (memcmp(&s_kg_cfg, &kg_cfg,
>   			sizeof(struct dpkg_profile_cfg))) {
