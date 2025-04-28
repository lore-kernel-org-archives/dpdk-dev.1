Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 549CCC369DC
	for <dpdk-dev@archiver.kernel.org>; Mon, 28 Apr 2025 14:14:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1F983402A9;
	Mon, 28 Apr 2025 16:14:07 +0200 (CEST)
Received: from MA0PR01CU009.outbound.protection.outlook.com
 (mail-southindiaazon11020115.outbound.protection.outlook.com
 [52.101.227.115])
 by mails.dpdk.org (Postfix) with ESMTP id 373DF4021F
 for <dev@dpdk.org>; Mon, 28 Apr 2025 16:14:05 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kXUyHjOKtCKTl6zBdCjNJ2yWZLAB2At0FZ9cRvhFilGKlMKk5mm+Q5ytfYzNbEtalqRoetUzgzvvsMHV67t/vxoSDwz/Qyx9cZcZc2cpb0oiEYXhNEUuMjUUZPPpiO80pJhR8YbySQnD2qN/mjq//Dw3VPzCAe3F4NLSuqzXvZYBjxPxjiYcSkfPKzzRbvF5YM7T5pukbqeA2x3xTNs/XwJEZ979YKn0f+xiEgZnzhFua2yB2INnD9Pg7yvPSZuQjTk3elwjgDpdkeAjsp1YmqTYXKwr1Ug/f4YcIzTrNoDzQW8dJ8x4h290stckEQuh5EDQW/uCm5dQUy/HvnjlKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OZ8/tqty8SxsC6AZC5QRow7c/c+8VRFFUJ9NM65IhCw=;
 b=G6z5z4hbVdHkOXPZhF5pbckfoH2uREfNzcEI9izGwTOhD8dpPoQOYt4sExg3ptkvFi51OBX+brNF3dohTrUKARVHq3quFJ/kE/TF0wCVj6MYbSI/9fIEzPNA26+YuHmMjVzy331SDuw/CTo7krrryWyzzDMcMcDWTVCad0bAhu2NVfMYvrN+kSoq5ftU5oBIt8jO6xZLUa01t8hi/ZCRmmmNl6A8JQICqSd6GxZ92qb+SU0PyD4vzn1F1YPZLX6zJ6Z2V/pVIthGHAeabXHtNW7AIg9wWoC4MTmhNij1t0zMlrejLpY+hCF+GLmUxfni8LyUd+XFJOCdmucNX/4u/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=iwave-global.com; dmarc=pass action=none
 header.from=iwave-global.com; dkim=pass header.d=iwave-global.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iwave-global.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OZ8/tqty8SxsC6AZC5QRow7c/c+8VRFFUJ9NM65IhCw=;
 b=E9AKqTZD7vy6v3HD7YJII8TFN872e23LK0V8Y44QcJFwJAf7tYuKCmpnMVyXvV4kGdHheZI5x5iqnbzLkKvITqpbnpki54UWTOBN6COPYQhhK/NIAJ8VEqw3zTOfyfSDtsatyuvcsVivgDaesVsaV+m0GRUXvNctbezBC0Y590xjD1xmyBuRwpP8w/JVLZ709ojx/qX8ayNOPg+4IEb63090MJdSWgIrVWsVKm3RNCNj3zejjQIG4mF2l+SmJYrcdg+cxUDdfLWCJIg0AMLExgGWTocUA1wo9MLYzXsZiMXRHGqwIV9o0kHXfGZAWanF5pTe7TRpk5X0tmLVXuBywQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iwave-global.com;
Received: from PN0P287MB2531.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:1ff::6)
 by PN0P287MB0701.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:164::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.33; Mon, 28 Apr
 2025 14:14:02 +0000
Received: from PN0P287MB2531.INDP287.PROD.OUTLOOK.COM
 ([fe80::1c15:d45a:75b0:af44]) by PN0P287MB2531.INDP287.PROD.OUTLOOK.COM
 ([fe80::1c15:d45a:75b0:af44%5]) with mapi id 15.20.8678.028; Mon, 28 Apr 2025
 14:14:01 +0000
Message-ID: <fb27d286-cfff-e70e-651b-fb72d80cfb22@iwave-global.com>
Date: Mon, 28 Apr 2025 19:44:01 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Content-Language: en-US
To: dev@dpdk.org
From: Ayshathul Thuhara <ayshathul.thuhara@iwave-global.com>
Subject: Virtio-PMD speed limits to 100Gbps, while hardware supports 200Gbps
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN4P287CA0114.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:2ad::6) To PN0P287MB2531.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:1ff::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN0P287MB2531:EE_|PN0P287MB0701:EE_
X-MS-Office365-Filtering-Correlation-Id: 616e8d9d-ee6b-48fe-6241-08dd865eed04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VjRsREhxRmxRVUJ3UkQ1SU84bXc0ZkprZlFhZHZTR2xndi9zdDE3Z3JLZ3ZK?=
 =?utf-8?B?Wi9hZEg1NWsxTFgyc2I3L2tXbnk1R01MTGZjWEJxTGExU3BnUk84bTVKb1dN?=
 =?utf-8?B?UXFub1hWNVAxVlpHd08xWlNEeWVUdVR5NUdQTSt6UlFtNDZMSGJ2YlhoOUpO?=
 =?utf-8?B?RC9zN09nTXpjS1lHekMzVXpVZGdUVlY4eHd5eStHc2xKWlplOGMvWm02by9n?=
 =?utf-8?B?d2licXBaQ2RBbEpCN2RTcW9Bc2poeUt4dWZtVlhKMDNLWkQvNUhNU1h4cytD?=
 =?utf-8?B?N0g4WHV1N0xHWnc3LzlLaXZSaFh3cWNwM2I4dkI4VTI0UGpWY0NRQjc4cTN6?=
 =?utf-8?B?VEl6YkljWUlvaEFxQU55QjE0UkNaNjR2eGwybXJ1cVdETnh6cTQ2R21YSy9m?=
 =?utf-8?B?MEJOaE5YR0ZpY0hFQzNlZGQ3a3JidmdhVXR5OGZ0VDEzWFJ6V2xaY2NBZWxX?=
 =?utf-8?B?RGl4eWtPWjk1d2dkZWRVTHJoamF2MjZLM2lkZlljd1RNK2VJWklyVFBDeUd0?=
 =?utf-8?B?Z0E4eDk5NjdxcmpvdnBoeDJ5N2xnRDB3azhaNFplRlhCcFhTSzJSRExrK1hm?=
 =?utf-8?B?cmY5VUEzVFM3aWNHbzl1ZzRrbTlsM3prejdSSEJybjk3WTFLVitDMGZsaE1W?=
 =?utf-8?B?UGRlL09kR1RCT3NISmpyOHovVkZRVytXcG8xZWhtUFpHL2Y5Nm1aSUkySUlw?=
 =?utf-8?B?OTVzUWhqUGhqQjVFME85SHRlZTczNWpnRzJHUStLYjN5TzFuSFJIN3M2aGhT?=
 =?utf-8?B?ZzBpd0haK05qOGg5OFJsRVN5K3krdmJZTkdRNGQ4c0VpQkRJeVRIRGFaMkYw?=
 =?utf-8?B?V1JZeWZXeEkwUHRMc3hTNVRob01yOXVtSmRaUDQrQzIveFQ5UjBYbXlDZFlM?=
 =?utf-8?B?U25VQkgyZ3JVd2VocnJkUXY2Ymt4NFRBUTV4bjJjVUliUmpGSWdDZnhhYzZn?=
 =?utf-8?B?ZXhCSGZXYUU2aWdaZm5ZV2RKQ2E4ZENlZmsvWERrVVVoUzAzZE1XWnI1Mnli?=
 =?utf-8?B?SzFjaDhnWTJhUVJkUDdpMXV0VGRFZWxGUnIrTVdncU0yTzArbk95RUFDZHpG?=
 =?utf-8?B?dWRZYnBOZmN2dU5QdFM2QnBvRW16dk5kZUZsbzBudkVoeHVseXlsbWRnS25Z?=
 =?utf-8?B?UEhMUXFsVFVnWVhlSFFEenZqY2tKSDZQakJrUDBCSlR1ZERrYlBzcjA4NDJm?=
 =?utf-8?B?Szl5dUtEaCtzMCtkM0d1NTJ3S3RFOENBUEhFTXI3aU9hZmlUelVUVmZCYURT?=
 =?utf-8?B?ZkR5a1dMRHFRQUNFaThoSDVibzBibkZZb2EzVnhLNlRGNEs3bUk2bDVKT1FN?=
 =?utf-8?B?Vk1yWG56eVpJNXplUTVhYWY0YkxaU3h1Mm41NWdHQWphdzFYYmkzdy9RWllD?=
 =?utf-8?B?dWcwaE1sNlYyS1lEb3VjUzhaZnNqdUluOHQzdmV1bE5oSmdlSmVTOUMrZnRI?=
 =?utf-8?B?TFNwbTFwY2dCY3pGeldwRzd6UjV3dkJ0c21zZU9iWlRuM1FpNVJES0RnMk5q?=
 =?utf-8?B?VjBETDFSUUFiQktDc2J2V3FVaWgwejluTG1wdDVCM3ZadDlWMWZ4OTFzRktK?=
 =?utf-8?B?UERyekM4WGRwcGpVQ3BCaGZpQkxST3cvSzUzZUNXWE1aVWhqZldaTnVGRkVG?=
 =?utf-8?B?SXhlSGh1NUo0UjhlbGRkampDMkQ4bTQ3d0YvTFJVUjVrVnNmaFoyeEFyS093?=
 =?utf-8?B?K3FaNGRKL0llOERHdk1zQXE0Mlk2cGpjOHJUcjU1MEJZa3BRcmZqdXUzUlNK?=
 =?utf-8?B?VURSTmRrMkF4SXlyNHoyajErYy9yU0V6a0FFM0pNLzdNbFlpSU5VVk00SktZ?=
 =?utf-8?B?SmQxWklLdk9sZUt2dTh3VHNBeWFhUkN5a2ZDWG5KQ2tqRWxOWlFNTXJxRG15?=
 =?utf-8?B?RzlPVW5XUnBpd3lqZzM4Q21Bai8wVWxhWVhnS0h4eUZqQ0crcnRRQTZiQVk1?=
 =?utf-8?Q?asAktpOCZxI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PN0P287MB2531.INDP287.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SFczNE12QVZOYWxuQkVJOXQ0TE9HU2VWbnJKdnlEdzJzY01CV3NYY3NSY09S?=
 =?utf-8?B?TzlsTUkvbGdmQnYxL1AvWjBRSHduME02ZGg5VWFhQi83ZjBoM1YvNE5GQVF0?=
 =?utf-8?B?QTRCekNJb0tiOFRPNCtWek40Sk9GSGhYTk9SYXNmKzNqZVhFU1VwQXo4Wm1D?=
 =?utf-8?B?UHlma3ZqZEVNbTF6ZjlOT0Q2Z1V3K2t2NEJ3aGhqdzhXM2JPRWIxNzFtTVh0?=
 =?utf-8?B?d0xnYUc4NnJTM0NHZnhXZWhnK2syTnZCMlExUFpRVlhLZjFUWnpZOXRZekRi?=
 =?utf-8?B?aHk0S2RhM3B5MUJKcmpXTXpPT0JGSFlhaDJERDNsQ3JQNnVWb2FudU1DNURC?=
 =?utf-8?B?cW5adWRKcWVvdmlqTHhGUFdqQUpsY0h6K1BHdkFTUW9zeGUwUFpFR2ZqN0Rj?=
 =?utf-8?B?aG9JclFQNUN5WHNHLzhBVnBhUzBCSXVldllqcStFbWV4VjllZGR0YWtlb3c2?=
 =?utf-8?B?Qlc5Q3dnTzM4Vkpubmd4YTI0dDh2bzlnWTR0LzJiK3o3V3BZU1Z0RnBXd3Zx?=
 =?utf-8?B?ZUliSjNJekFtc2NUSm0zQ1VvVTM0aDUwU2FlekdVRStZaHZ6YVk2VHc2K3Fo?=
 =?utf-8?B?cFlkV296cytWTEp3RFM2NDJaWXRBd0NYVWd0K0ZNMVV3d1lYYVdwU2wzWVhE?=
 =?utf-8?B?MmZua1lxRTZYd040enRxMk13TUdpMjNSaldFNHk2eTFjRWVIbzIzRlIvVUlp?=
 =?utf-8?B?UHJIUWNJcVN1REdhcTVIM3UvVWF6LzB0RXdhQVhqS21YUTBrcFVJVU5EdHRv?=
 =?utf-8?B?MExaVVBaS08xaWtxSlAralplc3Z1QTFWdFlXdzRnZG9yYnFtNy81aU5pNmhN?=
 =?utf-8?B?NTFFUWRlNFpWZXBSSkhpR2VYME9jMU45MGRuTlRkOXJjL1hUYTMzT1NteW5H?=
 =?utf-8?B?OWlodjdBelI2TWdLRHE5N2dRNTJNd2ZGUnZUU1lXa2NJbmtoSEF4N050L0ds?=
 =?utf-8?B?ZWlOeHFLRUxYVFJ6d2crMmgzL05NL2twQWtPSHFNR1dMTTNiZUZlV0YrK05Q?=
 =?utf-8?B?RXNncW5nV293UzNXUS95UmhwSzAvUWt5Z1lWekJUOWpweVVldUcrRml3bVE4?=
 =?utf-8?B?QlBwK1VXQ2FXN3FmVVlySG5La3NIUEVHY2RrLzlTMmhlbTkyYTZUdUxMVVhL?=
 =?utf-8?B?OFFMNk5la2pheFRSTGhqUFdia0RSMXBvblg0T3M3ajduazNaWHpUMHB0Vno3?=
 =?utf-8?B?cXZSMXUvMVJsczJRS1IzUFhpdmZ3NEpCa1ZnZnZhMFhkdGw3RnU3ajNUYmhr?=
 =?utf-8?B?alhJRGZhaFY5Z3dIUm51QnFhRVZmc0ZWYlY2eE1kMEFTcjg5eng2elo3T3VS?=
 =?utf-8?B?czd3TFQ0R1ZNcWlLMHNhQkxFcWFlM2VYNStsbjBUdFlFTk1pSFZ4emUySkdG?=
 =?utf-8?B?ZjdSN1pkWGJzMTdibVdEVWhQWUg2K3l2MXlKbUt4MUZKalIyN1M1N2Myeiti?=
 =?utf-8?B?bHMvZWNNZnlZVElpUWdkQnFscDhQWXd3clVab09CSjlESVh2TlJnbUNQL25G?=
 =?utf-8?B?V2wxcENNQTJwMTE1MnVoR1NUUlNNeU96a29JTkpqWkQ0Ty9mRTl3U2tUL01G?=
 =?utf-8?B?bHYzb0NhWWp6Z3NYemdxWVRyb3R5UjhKMHZIR0JLV3R5NVE0QnM3eHJNbUVX?=
 =?utf-8?B?NG1xOWZXc09jYTJLVElYZTh4RTdMRXNLTVNHK2JSdTVYbmI3eUpjRFVYaW5Y?=
 =?utf-8?B?Q2UySjBSRHFEWGF2L1FINE9Gb3J4UkFYNkorNUxyRkxtWjhLcUlGOGNGaTRr?=
 =?utf-8?B?QUZRTENOM0Z5bEVXLzlpMlRvTFJRUGZMMVRaLzNONXo0STVKSDRGWXVxdUxr?=
 =?utf-8?B?WXo4bkJIWGU4TzFGYWFIVHdxdVZNaS9aZGRtRjdIZG5VOHg0Y1RKOVVIdC9z?=
 =?utf-8?B?TjM0Qk1zWFJRVlkvYUdWTGFyZEp3MlV6YUJScUw4STcxSlorMGJVcW56RUx4?=
 =?utf-8?B?ZGZ2N2VqWlk5Mjh0T0FsaWNYcHFQUjh3UGJzYkd5dGxHTXd6M0VSL0xzeGcr?=
 =?utf-8?B?TGU1WFNQaTd2cnNTcFpuNzg2cFNjRFlCVk9waDFBcmtWbXlEM1g0RHZ2a0xU?=
 =?utf-8?B?dE9sR296TndiczhKMjFvcTZLNGdQM2Eya29OQ0ZtbnkxeVhIMi9iTjNVU1FM?=
 =?utf-8?B?V042ajdjanFTdldCUW1pVnVEancxVmVoVHNsNWNGenlhMzdkdnRQTHROcmQz?=
 =?utf-8?Q?HVVGB4O45AX9nZlcrNPyC7o=3D?=
X-OriginatorOrg: iwave-global.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 616e8d9d-ee6b-48fe-6241-08dd865eed04
X-MS-Exchange-CrossTenant-AuthSource: PN0P287MB2531.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 14:14:01.9207 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 507ae903-cc48-4d6e-bdb6-35278120a345
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f78a3e+sC3R4HhZ4dg6qNVLZFYmW030/XEqHExEegWfmbLVZIcCqh8a78CV0iVEnpM49ipOajlj+Iweg2bgi8H05zPLstf9e4UdkrBs/xvBn2QvyiyOpC1Gy1zpUPQHl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN0P287MB0701
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

Hi Team,

  I am using virtio-net, virtio-pci  drivers for a Bittware hardware. I 
could see the data is sent and received with the throughput of 100Gbps.
But the hardware supports for 200Gbps. I am not able to get the 
throughput more than 200Gbps.

I am using latest DPDK source files and I tested TestPMD application to 
transfer and receive packets. I have noticed the virtio_ethdev.c 
supports 200G, but while testing TX and RX shows 100Gbps.
I have increase CPU cores to more than 6 for each TX and RX. Still the 
throughput remains in 100Gbps.

Could you please let me know what changes to be made and what debug area 
I should look into.?

Thanks and regards,
Ayshathul Thuhara

