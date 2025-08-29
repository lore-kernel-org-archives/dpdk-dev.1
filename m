Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A06B9CA0EED
	for <dpdk-dev@archiver.kernel.org>; Fri, 29 Aug 2025 05:36:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5FB3640276;
	Fri, 29 Aug 2025 07:36:50 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazon11013042.outbound.protection.outlook.com
 [40.107.162.42])
 by mails.dpdk.org (Postfix) with ESMTP id 6AE3C40263;
 Fri, 29 Aug 2025 07:36:48 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UmlIJ4rYeOt3j+EweFFvJA5Qea/Vq0j5GMjmFsH1LYrKYOTsZTUl24tD7J04DTna13eualDWGwwnwecmPhhwMDTaFK7woS15Vze6LoKM0Bo+CGyH1LyWVeEMnnhHoUSquniWMWDvoirFXiTMXmKKW069CZhNEGT0qYIWJIqzaCmO4oaQw67e2xllVUhsI/KjS8ok5GUzI/kovAOMfGz8UEQ/1jawlM64dlJSaCgg8g1/U3u37+vHbAMxurKo+3SP57ez4/K5v9s+5ynpkFxGmxtdIjfAJQRowfCPuXRtIRWcx5Yjvh5n5hc3KkeaDEMXaAUF0uEm3drvvt7az6nugw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e2cBlK0qIqibF+HkyzK6SZ0TXPxJnhbzwlNS7poovZE=;
 b=HvWwDahtQ0x0cYa1ruMlk0tHdqwoEdD2gfMwWs2Gi8WXV9UTRxoRYeWQJYw923fLa75oiptZmwUOhl+vTt6zaxqhYTGPXzXp/J7ilxvObGBQcVzJThxNpVF725SeFc+nckCh0Y5HdqaPjjfWkP+/uClbOzD3xHxBUpz9PijY3KgQcYgYtw5ibRNYncgD3y5IT5A5aiKaARtJUAkpr6Mq3RAjx47Bno2Jiih6otwpRLM3qtDFYUDHa7JUbp38oXU1IjerCWnHvPe1X01/3GOwh5TMZQ5jO8piDWvFtlAEgverydcZmG8SqfVZiRW2W6LJlTAQLeG/SIUtvaTJZQvoPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e2cBlK0qIqibF+HkyzK6SZ0TXPxJnhbzwlNS7poovZE=;
 b=xbMWkt6dECVnREYKF+Ul8jXhMwOrZ6ZrAT/dvF16T40H/B572fj+bcBRQVctZp22WTPZmgULbk+HEMGBK1U5lmz4EqkQ0XftDbSkGo7iDQUcbfW+nbriSFqnQJYwd7UhlSvJQL9Pb2jsQcNbQkYCYLbr+r1YtiHz0whI7puqv312zRZ4d+9S+Yg2CzLQ7IG4J/k0sB/Mtas6CVzIlahKFQJRJPQ4QCaOL0yeHUrnsfLalA8FnqMm3QUF9tzCw3/oYKKzT3Wb4h3S3ZqX1OE4oOvc0CDPMPG3+TjBCtcvUzYtaqxpQpTi9oNxOE6eTXy0FsGELfEtj+bj5gSHyZgUWQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9328.eurprd04.prod.outlook.com (2603:10a6:102:2b6::15)
 by PAXPR04MB9491.eurprd04.prod.outlook.com (2603:10a6:102:2c3::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.10; Fri, 29 Aug
 2025 05:36:46 +0000
Received: from PAXPR04MB9328.eurprd04.prod.outlook.com
 ([fe80::367:d59:375:fb87]) by PAXPR04MB9328.eurprd04.prod.outlook.com
 ([fe80::367:d59:375:fb87%4]) with mapi id 15.20.9073.010; Fri, 29 Aug 2025
 05:36:46 +0000
Message-ID: <67a82c9f-02e5-4722-b6ed-761363cf6e11@oss.nxp.com>
Date: Fri, 29 Aug 2025 11:06:39 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] bbdev: wrong fix for MinGW 13
To: Thomas Monjalon <thomas@monjalon.net>, dev@dpdk.org
Cc: bruce.richardson@intel.com, stable@dpdk.org,
 Nicolas Chautru <nicolas.chautru@intel.com>,
 Maxime Coquelin <maxime.coquelin@redhat.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>
References: <20250813152829.457463-1-thomas@monjalon.net>
 <20250827151759.1448018-1-thomas@monjalon.net>
 <20250827151759.1448018-4-thomas@monjalon.net>
Content-Language: en-US
From: Hemant Agrawal <hemant.agrawal@oss.nxp.com>
In-Reply-To: <20250827151759.1448018-4-thomas@monjalon.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR06CA0008.apcprd06.prod.outlook.com
 (2603:1096:4:186::23) To PAXPR04MB9328.eurprd04.prod.outlook.com
 (2603:10a6:102:2b6::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9328:EE_|PAXPR04MB9491:EE_
X-MS-Office365-Filtering-Correlation-Id: 42024283-ce1b-4767-831d-08dde6be0acb
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|1800799024|366016|19092799006|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OUN6Q3IyNTlnbFNyMEhiWmNkMFFJTjR2T3dNak5ZNXNJOXk3WkY2TmZtMVV0?=
 =?utf-8?B?djVmbnpsaWpMSXpHZjNJNHRYaGhqSmJIcWlENzUwd1lWaEdkNEFOazV5Y3Rs?=
 =?utf-8?B?ZXBMZEtRc2dMTEJLUllFUUxwVnExckxXQmduZ3VzSG8xZTdic25pRVUvVEpv?=
 =?utf-8?B?aTN6b0hjNkU1L1ZrK0VjK0pQY2g2VDBvS1U2MGwyanhkbjNnRnZvdW9vS1lI?=
 =?utf-8?B?czNmSzdxd0lNUTNWZGVxOWNWcGdIL0R0LzRHaDJPYVFGQll1cDU0cHBXRzRG?=
 =?utf-8?B?amU5MEkyZXVkc3l0TTc4bzdUMXF3UUVjN1J5RXBXR2ZoYlUveFloeUkrbTRn?=
 =?utf-8?B?REZ0ZzAyNGVzZVZEdnU1bWJZUXk3RWtVL3NXS1VGK1BOYWZhd3hUNElqeFRq?=
 =?utf-8?B?WTFnVHZpb2RHcXAvOTJEejhZS1VkN240Ujkvd3ZubVVJMHQwdVR5ckZpVnFG?=
 =?utf-8?B?TnA0MmkwV2VNSEpnVUhHdURmSUNGNGpML1NFNmQ3bXdPdmRtYThsMHNQTkJ5?=
 =?utf-8?B?T0hXVWwxcUwwTTFmTVl1dk94OHlJNFMrK2Qvclh0aHZiVzFQUUVnSURBbXl0?=
 =?utf-8?B?WWtLSGdjbDl3b1JvRlpTbnRIVlNTRXFOSHBVNmtXeThmamkyUFVXemU2VmVZ?=
 =?utf-8?B?UXdMZlorMVJuaEhXOUxEN0hDaWhSMlhLYWJsUEFoTXNNL1NKRktjUVQ2d215?=
 =?utf-8?B?VmhmNDd4UFBNOENmbjlTQWR4UnJLYVVGR3ZvTjRXM0lYOGhuUkNVNVRZMWNp?=
 =?utf-8?B?dm5MYWpMVi9mbjNrQkIydTR2QkhsclVZKzhYdDI2RFlSYW1XeEtNUWpISFdq?=
 =?utf-8?B?N1UydS90SHA4Rm16M2o5QytJS1hHeVNPUzBua2NRUDk2aWd0Ti91N1NXQjli?=
 =?utf-8?B?MWkwMnkvLyt6U0E5UEpxaE5vMW1UNk9XR1Y3dUdYTXpkNWw0ZTZURnk0V0Rz?=
 =?utf-8?B?aWV5eVNpdjd3cmViS2owc25pd1E5aGtWWDZKQVE4bEdUR3JnNkRwLzlLWnBJ?=
 =?utf-8?B?Z0ZSVVhEbVp4Tm1CRUxKWFU3WWJLLzZ1R2pHNk9YOTRvb2ZSQ0lVdXFCR0Fx?=
 =?utf-8?B?ZTRyRnQvM0RhcE92T05FekJ5OWYyQXR4TDRSNkNobmVKMXVOajhmSzBKOFBP?=
 =?utf-8?B?SDlhVkJhdVR2QWxKNTB0cXIrZzJNdERNc3JvR3hRVGl4Wm9jV1A4WkJUajJp?=
 =?utf-8?B?ZkF0L1JKbVI1UW5Pc3NZWnFNZ3lDQWYzQXIrMVRNZVlCWXRMN2VINnRRWFhm?=
 =?utf-8?B?SXNMU09ZN1p6WlpwYWlBVTlqSmNnOSsrTENIWTFCT1pHd2hlNFNaakRIUzlX?=
 =?utf-8?B?c09BZ3o0N3grN1dsRjNnY3JhcHNKQXU3NG5nUkQ4bTdFV21hQzFiOUdjSTRR?=
 =?utf-8?B?M2NUMXBnamplUFYzZjlmaElUcjZrdC9mSUhmWnZqblNQeVVnOVVhWEpsOG9q?=
 =?utf-8?B?cFNKemsydTRHQ1ZOSGJWem1XbDZleDZGaGxzbXVhQzlpWllEaU5rVmxGaDhI?=
 =?utf-8?B?Z0RGZVBoa3NsdnkzZVVTMDNxSlQ3K1dQNUZzdkQ2YVdMall0Q09VZEJ3VHBX?=
 =?utf-8?B?MzBObkRUVkhYNGNwZnJQWFpWQUhGekwwdGtEQ3JqZHZTMTN6VEMvbXdFeE9M?=
 =?utf-8?B?S3l6ZHo2SGJFRGZycm45WG5IRTdHZG80TmJGZVBDTnhzZldTS1E3d3I2NXdk?=
 =?utf-8?B?cWlUY1V4WUMwRktQYmZ4ZVNYSWEvU1QxS2pFeWhObVVlZXMzNGo2eUZXanJw?=
 =?utf-8?B?MjdLZ1NpT0R3Um5rRDNqQlNpMUltTTUzREtHN1d1T0UxbHpjZzBnU21xVkZh?=
 =?utf-8?B?TkFlQjZGSVJib0FDSEFSUG9OczRmQ2J4UWZPYXE2QnVwRVpOZDhuT3RRVDYx?=
 =?utf-8?B?T1RPWXFyL0JiRmhzM3VuV080ZnlkdUI4WXZxa1BGOEorYnc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9328.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(19092799006)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y3ZVTVhQT0p4WUFTV0lsbjEzanFQRHNrTHFTTjlWU3crMktKaUhWdGdJdkVC?=
 =?utf-8?B?bThOcW5VT1NGMlUxbUNMTHVVRWJweU1FT005L2xQZlQ4NFdYSFhQTHVNcURW?=
 =?utf-8?B?bEJVRXA1SmF6czF5ZFBiV3JEKy9KcVZWM1kzZEloMzNaWkswclBoV3lDKzVD?=
 =?utf-8?B?M2wxWEZuVEFiUHlVTXFuSXZHSnB5djBEN3l6Sk0rZ1hnR09qei96azN0b3NF?=
 =?utf-8?B?SC9QaG5zWlRWUXhBWjNkTEQzVW94em9Iem5OejBwYklrK0x6bUV1UFdiK2NT?=
 =?utf-8?B?aWp5a1JSL2tLc2NzTVp5amc3NHJEbzhTUXhVbDZKajBuMFhDWWp3RHlTYjkr?=
 =?utf-8?B?YkNFSUFxa3FSRTZUbXNRRXNnaDFVdXJTQjRnbjlnUjRWYSs0aVJ4ZlZSR0dq?=
 =?utf-8?B?eW9VQ0lmbWwwQ0pCVHRKc2RoVC9QQTM2YzcxME1VSlRTM1V6RVFNYWxMVXFM?=
 =?utf-8?B?S2R2SU11djVYNFZWRUxJV245dXJTOGFjY1ZZbm5HcTdQeXJLNUhrRVBld3A4?=
 =?utf-8?B?YlZtK1JDT2pPbjU2VkJKYkRZS3hCSFg5dm4rU2lkenlMSEpNOUozZFdXeU8z?=
 =?utf-8?B?SkpPczE0N211c3g4dnlndjdTSytDV0t4K0l4WDJDMkdhbVNrNVNMNkRsVnJt?=
 =?utf-8?B?NnB2ZmJhOS9lbFVqZS9XQnRaakNFdGJzbHFXMU8raUROeGpWdGlaRGhWVUFV?=
 =?utf-8?B?ak94ZDkrOTBrNGVRZGV6SmpLUkkzVjR4SFhkQ1c5cUFMNmd3ZXNsM2kzM2wv?=
 =?utf-8?B?ekRsRjRUV1dNaDdXd2pzRkJDRGNFVkE3ekhJUjFla1VPdXZmRjh3Q29ZZ2sz?=
 =?utf-8?B?RGgvakJHdTN5aER2dzFWSkhZREl5RWxUVHdLNGdjMjAwbEVoZXNvVW41cXRJ?=
 =?utf-8?B?Q0lRS2Izd0t0eVRsaDAxY245M0hNdGRUMVVRRjlBUTJGZjhQQ1hGYlI3UHNQ?=
 =?utf-8?B?WUhsaUluUXE1T1hUZ0lxMzlkMk5DWENxcFlQNldiZG9FVEtQbS9KNGQvRTJB?=
 =?utf-8?B?NmJ5YXBXR0RSanNnYm9NeGtTL0dNNklDSVlaSTlqaTdtUS9ZZXRqY1owYmVZ?=
 =?utf-8?B?VXk4b1picncrbWx5UDJmWlZzWEVEc1l1am1XWkFXb2tWaFp5Uy9iM21TQ1RM?=
 =?utf-8?B?Y1htaFdnUTdTeFd5VmdqeW9pZkltQU1KbFYrcENJQjhRRHplMDk5MlJuSWVp?=
 =?utf-8?B?aUNnU0xQa3RVenFBdTVMUWxHK09UQzNySWszYndDd3Y1dzJOUzBZV0ZDRVdB?=
 =?utf-8?B?bHVEUmdSRVpqMGQ0aDdIenhJb083YnMxYUNkOTRoREFBYVFMb3hEWHpJRGZr?=
 =?utf-8?B?Q2psM1JvRDFUZ2pUYk4zYUxsRkpMQ3B0Vm1QaytpVTA2anVuVFJ4d3JMVTlw?=
 =?utf-8?B?aGU5M0RvNWtiNURKbzY5bG92b0cyaVcwREdnN3dVNW9rZXNiNVRBTzJuejBV?=
 =?utf-8?B?dEFxZi9jZGt6ZTV0ZDRodExYcDVJNkh0WFZ5UVduNFk1TjF4QjBHZ0dGRzFC?=
 =?utf-8?B?QncrcHY5RmRsb3NHQU9GZFpBaFQ1OElaRDFNR1BVZncxaU41MGpUVjFzdG8y?=
 =?utf-8?B?VFpURkxlamovRU1VKzQ5Q09TT0hWeDA3bWttempKK3QvMWNsTDRwQzdST1VV?=
 =?utf-8?B?ZnZjd2x6eDh4blJrTkJqWjgvdTd2VEU0eTVnOExlemxPVEVzT040WVNtcE9o?=
 =?utf-8?B?TzNJRjdHUmJTdEJLRUZzSkVKNEtTMWw1RkdZWTVTMkgzbVloaGdTRVlpYlBF?=
 =?utf-8?B?OThFS2I0TXU1K2tydXZHdENUdjcrUWNtWjZCNGpPWXY1L2hSaWNaZ0pFNmtX?=
 =?utf-8?B?dTIyd0NJRjAwQTRVNmJ4Qmlha2lDZkhhVUFSRnJDWlljUTVkVlloS0ZPVmdm?=
 =?utf-8?B?STlKaXpBRjBjaXZrc3Z0clVJaVJIbmE5N1BTTjlFL3ZwNS9KdW90NlRLUHZm?=
 =?utf-8?B?aEVZcnZBaXVJbjRJWXg0QkNGMnBVZFVvQ0hVeFpjS3RCWjRpQUorRitJeDFD?=
 =?utf-8?B?REg1LzVrbDB0VXl5U3dzK3QzRklDeEFKd05Jb0xGN0JMQUJYcFA4QUZoWWlt?=
 =?utf-8?B?UEZHZytKWG5lTnNtUVZUZEkrMHl5K0h3UHRYMWFHTzc0Rm11U3ZVRDZTUkc3?=
 =?utf-8?B?YVFPdWFjR0VzNGdReFUvaEdJaFA0VG90N3R6dEc2TzdQM0JxZTdmdkFiSlhC?=
 =?utf-8?B?ZGc9PQ==?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42024283-ce1b-4767-831d-08dde6be0acb
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9328.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 05:36:45.9925 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nVKP0r2M4MQelH9O/ALLkRxd2KaM0Wnpb8jOP7oEVo7v66IBK7+Fp5QX6hvIjwE1EOKzMVR8Haj3apL5ZlH3eg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9491
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

