Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB8FBC43458
	for <dpdk-dev@archiver.kernel.org>; Fri,  3 Jul 2026 12:51:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0D2EA402DF;
	Fri,  3 Jul 2026 14:50:31 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazon11010020.outbound.protection.outlook.com [52.101.84.20])
 by mails.dpdk.org (Postfix) with ESMTP id 6971440696
 for <dev@dpdk.org>; Fri,  3 Jul 2026 14:50:29 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YzfUDiXpK1pQd77g3BVglPa7Y6oVi3FSBscXajH2K62DqWqiB365gO/HmiPxUJ/kjEHzyDb9YaXzTQKFlaVtioSNG3SpV7nGCL3rJkJoP6OvDGIH90Vu9RuBs16TETE6hwSB2oXStxx9nXCvoZOqovxEHmDFpqkM+aTXA1vRuF7ATopQnSGXKGkm6OJZn5r/d/3DVyojL7FUAGzdEUdzmS/tdts/g/eORggary4vshw3xiepPlj/uvPj7KJKUQ87g6U3AVRNqPMhxkHseCAVuAhxAV7UXzAKVe0nO2plCB2/08X1bbNH8GbTFf+iyzfR0nAYEzDQhXzUtzVUhQePzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YpAsl7U6fC1ME8MCZ9ZOdcUo8i8M4tgqrwYosvgsv+U=;
 b=SkV+uASRZUlSeyMj5m8WYLyukPVAyVVdy1jqd1s7ypzyveev00oaDgWtwjv/9FpMBuyhbJwag19M9jj/78IsFCy3QQOjbRI7u0b7aF/yONtb4FAvxRsURevt5KkrFB41hON4y02B0vdyzXkVVg97t3bN6mmjH0DFZ/ghY3nCl0IpIRRfDLgmDdax9bWI6Nna81cY5+c/r+JIwgyR68NEDayA7VFXrOTRBL6OqHu8j+lAn9bWMG3dCnjXEXBFFLcqY0UiE8dqx04Se2w72NORquJQTLCzTjOE1SbkfJlHy9q8xD6xiYmbxJ3oYvPaWvdSFKYOA2NKz5h7PWfpqQRt5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YpAsl7U6fC1ME8MCZ9ZOdcUo8i8M4tgqrwYosvgsv+U=;
 b=fRSgzlbgWnNseJmZAzJEX6EZ3EOp233vG/BTsSm0zbALWlK47sJdIDQW+3woAhX+/+BfcgQBtapwtoBhHYNB2c3ObohlGICaaZSabPbwCgcBR0P7nI2rV0aZVTgn1pfJ3od1HEzVT4j+FGcmj9NXjgspu110SRIARzEilbpSrGusZ7mREO++fGquvzUbLTBvY3EwXRIpo4hwAqc58w3a3uoED1wFVMdbTVztUqeJFQPKClBl9rGkOQ9v1w3fzRSZPJ03u8A1IdONV6VFiRb3NeJFAnZUlXNTtfteJnpE5UpggGY2ZWyPBhj8817i7aCljmOiIuVZ0vvWmZL32FXuYw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV1PR04MB10750.eurprd04.prod.outlook.com
 (2603:10a6:150:212::14) by AS8PR04MB7992.eurprd04.prod.outlook.com
 (2603:10a6:20b:2a4::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Fri, 3 Jul
 2026 12:50:27 +0000
Received: from GV1PR04MB10750.eurprd04.prod.outlook.com
 ([fe80::9985:c5d3:961:2003]) by GV1PR04MB10750.eurprd04.prod.outlook.com
 ([fe80::9985:c5d3:961:2003%6]) with mapi id 15.21.0181.008; Fri, 3 Jul 2026
 12:50:26 +0000
Message-ID: <2cb80512-f15e-4bce-8b37-5a87659d26df@oss.nxp.com>
Date: Fri, 3 Jul 2026 18:20:17 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 00/19] DPAA bus/net/mempool/DMA driver fixes and
 improvements
To: Stephen Hemminger <stephen@networkplumber.org>,
 Hemant Agrawal <hemant.agrawal@nxp.com>
Cc: david.marchand@redhat.com, dev@dpdk.org
References: <20260626065655.279742-1-hemant.agrawal@nxp.com>
 <20260702053359.3243907-1-hemant.agrawal@nxp.com>
 <20260702093259.33f2151f@phoenix.local>
Content-Language: en-US
From: Hemant Agrawal <hemant.agrawal@oss.nxp.com>
In-Reply-To: <20260702093259.33f2151f@phoenix.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR04CA0004.apcprd04.prod.outlook.com
 (2603:1096:4:197::22) To GV1PR04MB10750.eurprd04.prod.outlook.com
 (2603:10a6:150:212::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB10750:EE_|AS8PR04MB7992:EE_
X-MS-Office365-Filtering-Correlation-Id: 27aacc4b-301a-463a-87d2-08ded901a7ac
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|19092799006|11063799006|4143699003|18002099003|56012099006|22082099003;
X-Microsoft-Antispam-Message-Info: r+ixv228VS/W1GSo0Lvb3CHtfgTn+gg+p4i3Zt43vE6wCSzoLDpErUh2okJi2jbM0g2Gf/i0sI4L87fpv8KmkQVaIofa/AH7O2PpCOHNQrLfLO8RTuIT2b1W/NHZ4VpL6G8H7+GYFm6vfwBAlRUe8E/WDUeGnS1yVA/33kugr28cGAk5WdD1m+dsrkqjF4Lt5K1N7kGk+SphERhmndI3qp+sfEAOmHN38u9IBTqNZnVckfnJjec6tQMHbSTVdx7aLfkrkwWOjASkLgs14cq9fQJ31hOhFgGNCdzIbwiexCrNtTlfr9xP7TKsf6nqBNxKG9DWfPkNkRxLAb0cD8zeAxS1dMYKKKmKcNG0yn9OBu1GiS9J3ovcRSqlDxx80ZnMKyhOHAzbLtE5Vhb+S1W0t9OqklmcsOZ30eNwR6gyBGwosVjrF1XTGBkmyxoy6lQhIMw19UM44pl+jY59zrqYMAInLezEswzG/41Xphuxv8zvRIQq08D9+w9fwjrXScvEfdgDJQ2ZpMoRLWMYfZ2iEeFByDfP5PKpOU0DgSqQQx1waHcXuGGxgaqUsxiWuR1xrRllae6nEfHjqSomvD8fbAZQGxatmCkYIbQyPDmFeJTbTajRPfWBae5EcAkqRjgHXvFP6f7YMw42/ZOkyhRBtRa+pzz4v7bJXJPOjVpe8l4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV1PR04MB10750.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(19092799006)(11063799006)(4143699003)(18002099003)(56012099006)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MzZxT2VrZ3hYMnNjcWd1dlIxQ3hsdzBFeGFDNmgyQnlsTDYrVEdtTVBNWWN0?=
 =?utf-8?B?dzF6WTNmSmpEMmdUbHh2S1NxQzhuOHV4Q1M1QllNUzlWUjVMSU1DQU1RaExq?=
 =?utf-8?B?amZpaDhaalh3dWFEMDdxTmJJZGpIMnViKzA5RnBBOGJmTERWZklNTDU0UEdO?=
 =?utf-8?B?bU9sWDROR250N3RkekZOMnl1SW40NmZqdUxWbWFtUmZ0NGc2SGkzaUVGYXE0?=
 =?utf-8?B?bzdvWm50QVdtS3p2TUVUV2J4SHExTEZodVNvcGUzNC9UVDVCaWRDcUtiTVpI?=
 =?utf-8?B?MXpOVEJVSTJrd3lvN2ZoUXhFSFFQYWVmNnkyRWFEWGRxVjBJdFRSY3BwMmd4?=
 =?utf-8?B?ekhKbE9mQmdwUCtVa293Z2VnZ3VGNWU4NEM5MjNBdFVVcUQ3S01ML29pMnlM?=
 =?utf-8?B?bG9wL01nKzA5TzFqOXJwTG9iMVRqdm1hRkxPNElHOGRqTEJ0amNHSTluSDJE?=
 =?utf-8?B?QWhJMHdFOE5aM2M1MWREaHlHbTdnTGRnYmxLbDNML3lzRzNGTllYRUpmTXA2?=
 =?utf-8?B?dlpmMGFhWGI0NlVXdWh6UjFaUkpCSUJPMXVrN1RYSWNUaWdJWUlPdTdWakZG?=
 =?utf-8?B?U0xNNVhlakNTWTVwWXNoR201WFZyaGJuVjZad2czdUUvc3FiNG44REVuRE9s?=
 =?utf-8?B?aFpDa3ZUZi9tQk5ZQzF0bSt6RnRXTzQ3aFlXakVOZzNwZUZENmpsTE1kUzgy?=
 =?utf-8?B?UkJIalhjOXNhMm5BRU11UzI4OWswTDBrWHJtNHBLRFJkemNmYzJ3Rm1PN1hT?=
 =?utf-8?B?WGlZc0ZVdUxUY2FxK2ppVmFyMjNuakN4V1hwMGRpVXZzMWhKYVNndnR3MXVP?=
 =?utf-8?B?eC9wb09VbXFnUEo5UHViR0JXcHFBWVhnTjZ4dEtNcTlaWjdUcmtDbjNaa1U2?=
 =?utf-8?B?MmRnT1o3YnZTalozdDZ3UW14QjlYa09KckN4WWkxZEU2cnM0bW4xUUN3Z1Ju?=
 =?utf-8?B?ODBOaVV2ZkFpNFJqSG53dWxpQWVjRzFuQUFVcVFNK0hXTjFCUEV2aEUxK0lJ?=
 =?utf-8?B?Rmk5aEJSOXhybWg1Y0VQR1MwSnl0djFCUjhQUkNXV2N4S1FLc2dwRExSUjZi?=
 =?utf-8?B?dkZXd0ZzU0VNNjZab3REaFpGUC9zNC9aSW1PTmZ0K1hBWkljZzZaNlpFc2hT?=
 =?utf-8?B?WkZ6MUlmVmZMVFltSWt3MUJwclZ0NUJSNnpEeWlhaE9ld1NEZWtDbW5tbjV1?=
 =?utf-8?B?KzhXS2pIemRUczZCa2txQ1Q4eE5wc1BnSzVsemszT2pFWWtBQmN3dWFyTTVq?=
 =?utf-8?B?UU4wS2tRViticzMyMzlKbStoU0k0bXA1VEtjK1hyZ09HNkFVYnAxN29ENnVH?=
 =?utf-8?B?MEI3MGl2ZSt6NGZac1lTUzZFMVlDZllLcFFDWEw4OVFZbHo5RjlKRlVTQVRj?=
 =?utf-8?B?LysyckphSit4S2ptVDBranJIZngxT1kzSmZIdlAydlB5d2x5U2dJZjlSdFc5?=
 =?utf-8?B?T3RCODhhb3RSSkxsVkxzOVYwMUxsN0RENnRKSWttVHhNakErUXQ2OVZPWU1Y?=
 =?utf-8?B?aitkNjNMNWE3N20vRW13ak9TYWl0Sm1aTitTWHBhSFlCa1huTjdIZDJCRXhV?=
 =?utf-8?B?ZG5Wb1pzbDVUUkZYUC9OTTk1eDFEQU4zNHRYb1JqV0hoajhzQml3Uk0yOUU2?=
 =?utf-8?B?aVBhejlNWDhEV0VubmtEYkdBbExCS1ZsQXVGMHZOY1ZOTnloQW9keWtBOHBl?=
 =?utf-8?B?SmRkSGwzdTFNc3o5cnNQZ0pMOEoxNkFpZ21CRUdRdUU5Z0xCY1l0OEg3UUZL?=
 =?utf-8?B?M3hRM1NUcE1NaGdtby9odXpna2dHZXE4amVQS2R3cTArUkZSUUlSK3hFeDBo?=
 =?utf-8?B?VnUwOUdrcDFNVFB5K3FmSlRQdXl4alRSdVhUVzNUNFF6bEIxYUpVdTJOakhY?=
 =?utf-8?B?Rk12em9aRkZvcGdwL3VPQXI0eDhpUXdPS1JEdjZCMDlxY2lRMTVNWlhka0VP?=
 =?utf-8?B?UUZxUldVN0trNzZZYkRlMmxKRjUrenNZZXprZjI0ellTcE1haWpkUXVLS2VH?=
 =?utf-8?B?TTFLeGxobmZSbi9tMmg5azJLL1lJVDlFU0lDTkZMbkZqYlRYeWk4RWNPTzAv?=
 =?utf-8?B?NU9DWkx0Qy84Tk8vc3oyc2tESDNPSmVmNG1pV0tvMzZQdlFHcnV2Tjg3V1Jt?=
 =?utf-8?B?UTc1RXB2ZE93eFZxc01IV1c3YnlqajlZbURsS2Zya0puTXkvTU9Hd3RVVWFw?=
 =?utf-8?B?Y3F6NzRyalk0QW83VGVocjRMZWZxeHRZL0I2bCs4VHAzZ2RQUGU4S2o1SGFY?=
 =?utf-8?B?Snp2R29ROGt6MlJVZlVyUnBjVklraUM1OXJobTNLR2haaDB6djh6NHlDUHN4?=
 =?utf-8?B?QnRZU2ozdTVabm1sZk1reTlCTDFVTWVVWjN0TjhIS3V1YnNxcmFuenRsVnhs?=
 =?utf-8?Q?q37tUOG7yjmqrmLs=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27aacc4b-301a-463a-87d2-08ded901a7ac
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB10750.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 12:50:26.8311 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qx9+xmvqx0mBf5eeKm6ytwzkuFO5o2pIMPYFwmmlyeKecgXG3/A1OYWDO6LzN2AJNl+mungoJaLITSltI7V57g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7992
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

> Thank you for the thorough review. All findings were valid. Here is a
> summary of changes made for v7:
>
> > patch 04: s_data_validation, s_sg_enable, s_pci_read are used in
> > this patch but are declared only in patch 18 -- bisect break.
>
> Fixed. The three static variable declarations have been moved into
> patch 04, where they are first used. Patch 18 no longer re-declares
> them.
>
> > patch 03: BMI Tx counters are read from the wrong buffer in
> > dpaa_xstats_get_by_id() (copies from values_copy which was filled by
> > fman_if_stats_get_all, not by fman_if_bmi_stats_get_all). Also,
> > bmi_count = sizeof(struct dpaa_if_rx_bmi_stats) / 4 omits the 4 Tx
> > BMI entries.
>
> Fixed. A separate bmi_values[] array sized for both Rx and Tx BMI
> stats is now used in both xstats_get() and xstats_get_by_id(). A new
> function fman_if_tx_bmi_stats_get_all() fills the Tx half.
>
> > patch 13: dpaa_bus_dev_compare() has side effects -- sets
> > dpaa_bus.detected and calls pthread_key_create -- but returns 0 for
> > all calls after the first, breaking multi-device enumeration.
>
> Fixed. dpaa_bus_dev_compare() is now a pure comparator using
> rte_dpaa_bus_parse() + strncmp(). The detection block remains only in
> rte_dpaa_bus_scan() where it has always lived.
>
> > patch 08: unreachable "return -ENODEV" after do { } while (1) in
> > qman_find_fq_by_cgrid().
>
> Fixed. The dead return statement has been removed.
>
> > patch 17: RTE_PRIORITY_104 is defined but RTE_FINI_PRIO uses the
> > literal 104 directly.
>
> Fixed. RTE_FINI_PRIO now uses RTE_PRIORITY_104.
>
> > patch 18: s_hw_err_check changed from bool to int without
> > justification.
>
> Fixed. Reverted to bool.
>
> > patch 19: commit message says "add ONIC port checks" but the patch
> > also changes dpaa_port_vsp_cleanup() signature and refactors
> > dpaa_flow.c.
>
> Fixed. The commit message now also describes the fif parameter removal
> from dpaa_port_vsp_cleanup() and the dpaa_flow.c refactor.
>
> The series is now 16 patches (v6 had 19; three patches whose content
> was subsumed by conflict resolution with adjacent changes have been
> consolidated).
>
