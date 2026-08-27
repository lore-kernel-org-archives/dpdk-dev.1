Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B359C61DB9
	for <dpdk-dev@archiver.kernel.org>; Thu, 27 Aug 2026 15:57:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C37244064E;
	Thu, 27 Aug 2026 17:57:48 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazon11013012.outbound.protection.outlook.com [52.101.72.12])
 by mails.dpdk.org (Postfix) with ESMTP id 6274540150;
 Thu, 27 Aug 2026 17:57:47 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eOgYxebNxHZsg6lSHDGUa4PtThStcqlN/qHTmJY8TX801rSlRVxrndX/xrxPWwpkcEt7a6SM0gHozTTqWHj0P1AqCNkTgeNGDBH4Vs3SFa5gKhMbbo68ymNZ5bzQOoqVoUGnP511/v97ERBTcb/fm0Kbzaka4jP4EtgRAZPBua0u1MZdisF1tbbll0I11NLfgp/VzQ7BS9YWb18rIzGqIKzhEyvcaN1iJkdUrPF7ra98uSmCMskyPDB5JvbsO8sv+kd+YTZH+qGX/9sQuRoPzPLZvqISDniuAJ/K809kN/dxtP+lhU1kDmBPcv0cDKAiCduZLJbA87uLsf5vPBp5dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cTzTOfdrXuNycq20Wa4mMADAf1RSN1k9GPTzfURZyeI=;
 b=eqe4qqWJSOOuxhjlWcDNr9omRuQjV84WVMxV3yz8tYugPzVQQzt2WXKbzDaQKXUCORzvYiQsGSm0EShmS3EWU9tn+dA6rIVPyJEvofeONCm2bG2jus6WvXDJpnhn/Y1wM0an3wQij2O6P384fmJ7OEnckgmNewHE3lggEqsi9BD7vZnmeqyY2AMHooeto4lKO1hCSkE3w8z6HBoXhlKeFSqefotrCIJROTyXmmMbLUyGrSfiHdj+S2T7ILhRAXcqbkDyQBmW3PzIqjXdJVeWXSP3xdDXEzBjqMxf17ryUplXoWb89RbJBvIMnGI8g6ZYLvFOzAr2qxge1KVHY8CFdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cTzTOfdrXuNycq20Wa4mMADAf1RSN1k9GPTzfURZyeI=;
 b=NLPZ13Ws9WdWkQqbds+0DsP2ATkec19/bSpNSxwESXRZnTCrkPUW/Qsypp8tkMWz/ZNfHzVruNlCaAKdFapTMV+zPaaIb5icZAAjBvkVNlRYk/VOwIgm5MhUy6nLIFC5qe0RWdFZ0Ed8SPaXPIoy6rhv24srTy8SrHVL5OMPd/EnARzTXneRf+qUuRZNvRoHT5bzWHUklfd7Ymhob9uEo++8aTKR+jhKd5/dM1WQlITt1LHokbdPD9SVKKBTBlrYNht6PKprXFUJQwCV/jzZgj/jcZcP47phTcdvVTgsMneabjIUDUNUjhACboBj44u5Kq35tTe2w7eODGobqBQ7IA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV1PR04MB10750.eurprd04.prod.outlook.com
 (2603:10a6:150:212::14) by AS8PR04MB8947.eurprd04.prod.outlook.com
 (2603:10a6:20b:42e::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Thu, 27 Aug
 2026 15:57:45 +0000
Received: from GV1PR04MB10750.eurprd04.prod.outlook.com
 ([fe80::9985:c5d3:961:2003]) by GV1PR04MB10750.eurprd04.prod.outlook.com
 ([fe80::9985:c5d3:961:2003%6]) with mapi id 15.21.0360.006; Thu, 27 Aug 2026
 15:57:44 +0000
Content-Type: multipart/alternative;
 boundary="------------H99oRIF4epCyv6hZ9IXUZwh1"
Message-ID: <46971371-5153-44ce-8e19-8be869876559@oss.nxp.com>
Date: Thu, 27 Aug 2026 21:27:37 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] bus/dpaa: remove unused qman_clk variable
To: Stephen Hemminger <stephen@networkplumber.org>, dev@dpdk.org
Cc: stable@dpdk.org, Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>, Geoff Thorpe <geoff.thorpe@nxp.com>,
 Shreyansh Jain <shreyansh.jain@nxp.com>, Roy Pledge <roy.pledge@nxp.com>
References: <20260826235933.194681-1-stephen@networkplumber.org>
 <20260826235933.194681-3-stephen@networkplumber.org>
Content-Language: en-US
From: Hemant Agrawal <hemant.agrawal@oss.nxp.com>
In-Reply-To: <20260826235933.194681-3-stephen@networkplumber.org>
X-ClientProxiedBy: SG2P153CA0008.APCP153.PROD.OUTLOOK.COM (2603:1096::18) To
 GV1PR04MB10750.eurprd04.prod.outlook.com (2603:10a6:150:212::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB10750:EE_|AS8PR04MB8947:EE_
X-MS-Office365-Filtering-Correlation-Id: 95a3ec0c-4706-4cbe-aa2a-08df0453eed1
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|366016|376014|19092799006|10067099003|11063799006|4143699003|56012099006|8096899003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 4F0jdvEgIvcSDO6pe0PaVPtZ5YAPaVoKHmEa+0Wm3S8gr+9TIrUEVprI3BJl9Ssm0tHsKh7yRPwp1aP6R35XcmWV0cJyoVTrJBqoa7TRHbFF2aLqzGQevkX33+7PHT2Y2RTdO7yF2w/Jrp5pHNy8HpMNHm+Kjahx3TAyektR0b4A331MEy/3COM03B0NjNVSFDK6/f5DYvnJptdmaAnCmwOxk8rEoWJUDe+NCbsqlkoAV2K4w7PfyyBRG8uG9xJFBSGNwehHIqGFWqWQ9YEbTdE2JJszWX6cmvZSj5zluvWoot8nZcEIS+zKOeLYSJDR0pwI+KbbvHo2eLYH1/cqOSi7xcB6qQzQOTfrTtQzMvz4RosaYS4b1tBzQsgQQNoZg1loJx/vOYSr5mHzX9bv4BtJdDoZj/GfcJ+wFyDFZFzTn5Kp2htyGNEa8vqVAWF7HwBjGGq7+J5Uux9K3h5xM1DBhpWrponMQvUTqlit6DAdCkZbvo0QjUDCOwyB+reO+P3AtVDpICeJKD3WFBy7QZXrGO3LHq/kz9hcaclXVlLDdIxoEfH1+slzsTZlplb9PKyiCLcay6NKZ4o1lrmlE2UB8kpEt1Y2oADyJCTSyMjwNqFB6YheB5pBOBZ1/PL/5X0OPNcXTghu7sGEzSTnQd2a3aGs6cfWXuav+sNbmu0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV1PR04MB10750.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(19092799006)(10067099003)(11063799006)(4143699003)(56012099006)(8096899003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U245RUF5S3hsUzM2VzlxOTRwZW4zMktLYzdrTitPbjNKTTJPZHZCNWJ2UzRo?=
 =?utf-8?B?OHo2eFdRWWVodWNKOVFBZC9KVjNkMmZFRy9XU1JvN0VNckJjdENRMkU4SU50?=
 =?utf-8?B?bHA0bGdpSXNyWXN5Tk9OWFhLN1IwYVB1OURtdCtUYWRjaU5BeFRBcW9HUmxj?=
 =?utf-8?B?UXByVmNUM3hLSGVIbkpNSlgrZ1cra1VOUlZtdTRWdzlvS2RTeGFyS01NNkV6?=
 =?utf-8?B?cEtjQ3I3bmNXSU1vY090RnVkZm92bnkyTlJ0NEkxdk9HTE5mV2xQZGlwS2FL?=
 =?utf-8?B?Q3l4a2diV01DWE10R2syNGxtaEtEUTBEaDJHWUc3UytaT0FTL01MNlFVRjVJ?=
 =?utf-8?B?Y2xyQVBmVnNyN2xyNHRGcHhka1N2b0RBVFBoZmx2NjNNOWZSakY5bmVDR0NO?=
 =?utf-8?B?aEIxSG5SVDQ1aHk3REVmMHgvM29QODBhWHhpaVNTanhGdjRydTMzb0psNGZ6?=
 =?utf-8?B?S242VmRSYkRNbzRxaThDSDlMcGg0cjhMVCtsUE5USHlra3BxU0J1ejgyb3k5?=
 =?utf-8?B?OSszdTBxK0lMQnRlWjBLUHYvOURpYmFYQjZ5REE0SnlPdllWWjVuck9vWFFH?=
 =?utf-8?B?QzVKYWppaklCZVBwcm4ySXpNdGoraDFMbktvd2FPVUM1VmpaRTJWYnp3bkdW?=
 =?utf-8?B?S0lhSVM1ZmJnckJ2WEFyWGJocmNhamowSlk3QWM3WUpTZ1NkWW1iOGVJSCtW?=
 =?utf-8?B?RTk1aTlLRnM5T3BRK1BaZi9mamduR01xVDhid2FzSy9YR0laM2NoRng3MWtR?=
 =?utf-8?B?cTcrYTNEQXlqa3NsTVNiYnlFaDE4U2ZEOUF2LzdWREZGY01vb3BBeEVpdTJp?=
 =?utf-8?B?dzZZVUswa0RwK05tOXlWLzJheEhBTFBCQ29LajJ1LzhuTXNqS0ZWaE96bmFT?=
 =?utf-8?B?ME02Q0Rsc24wZVNpRldtOUV4N0hReU1pYUdlWk1zVUxHZW8rWWYyV0Fqa2Yy?=
 =?utf-8?B?alpSemtzZEh0R25YVU1iN2lTczNDbEYzTGx2L3RkRHh1L1NLVE9CU3N6Rmky?=
 =?utf-8?B?STMyVWxiT2N6cmpRVS91aytYRkJpd0lIWS9QZEVtenR4ZnlDWmdNSEJHbWl2?=
 =?utf-8?B?RU8wOVVVbjFITVJJTU5QUG1yeGRKK2lyM2ZWb3pweldtTkMzY2V3Vk1zb0Vq?=
 =?utf-8?B?aWdxaEVIMVd0TlVlbEk1anp4aDAwNHpyZWxueEZCb2VrVnVhaFJRSHQ1WHR1?=
 =?utf-8?B?cGFjOExvbGh0UzJXUlFEaVFPZlFyQzdFT1h3Q28xc1I0Q1AzVEhwMkJRZWxT?=
 =?utf-8?B?aE1xcGVlVG43SlBCcnczZzd1OWdPN3kxbXJLVFZRRUZBRGZQTmZQNTZYVlln?=
 =?utf-8?B?L0VKTVVudVkvZFYxMG5sUG8rajUzTEYvUjNyaUtvbThIWURTUzFyZDdCSTZi?=
 =?utf-8?B?MXNmY2dsbHVSa2VLUk5FTTNGQXpnSTN5UDlCOHZrZEdrb1dKREJQWGNpOE5k?=
 =?utf-8?B?ZmFtT0FyczlsODZDWHlHYkVlS2loL2pUcnFWd3JzQVlLVzcwYVd3djdBNitY?=
 =?utf-8?B?ZVp6UDNkdUt6TlFlY1lSVFpkTDk2RTRpTDZkdVJNNE1Idk5iajNQQlM4WThz?=
 =?utf-8?B?OHk3cVFacnZUVnpFU3Y4UHB0aWhraXZXMEYzWXFJck5HU0JRamVsUmxRVWh6?=
 =?utf-8?B?V2wyN1ZjZGF1WHlCS0hsVVdGSmRKUzJHSWgyd3RxZWNrR0tJK3FLUDYzZHJh?=
 =?utf-8?B?Q1VMa3NQYmMwTmFaa3pDSldWVTNTbHFZZ0lrVVN4eTZVSEh1UnpZa2JyTU1N?=
 =?utf-8?B?OHRhLy8vWEF5OTd2c3hRMEg2UEtqS3hrc0NzYnF2Qms1NnFJZk16UndUMUZH?=
 =?utf-8?B?R29GVSsySzVyZStZRDlONnFXb3BXQVdsR0NlTkgwcFFCTCs3SXFpdGJtME83?=
 =?utf-8?B?KytFUW9IODZpZ1BKdGtFU2NIMlJCa2lxdi9zYldvNnJtQzVudzhMbUVzbkRO?=
 =?utf-8?B?ZEU4eFlTVC9KSSt2Y3ZZeDAvTE1MMFQzUFZ5NWZqbWRmc1EzOG9mV3NnQSsv?=
 =?utf-8?B?Y2VpRWpWaUErbHprcGRBaUhIdmhxaWswUkp5Z1B4d3Y1MGN0WXp5NjBpRFBy?=
 =?utf-8?B?TlAwVSsyQm5WZ0Z5d2RnVkIvdjNndTlUcGd1enFXTm5nanc4MFZ1THozdkwz?=
 =?utf-8?B?VVQvRVJYMGJzZ0FCaUc1ZGVZVEZYckNXbWMrN0l6RWQ5SWx5SmtpOGl4L2lw?=
 =?utf-8?B?dTFFM2oveTFKMGNSTCtBbGZCQ1FtV3hBdjZZb0V1M0JoMUl4UmJ0ayt0M1ov?=
 =?utf-8?B?RU1Ka2lUQzliK3FZTGI3SDlCNGpUZ0hBamF1N2NYM2lJaVFwbTBnUlNnc3Vi?=
 =?utf-8?B?cHdVdlFkZ2M4QmRLODhOVFAzSU1rRGlwRFZQVFkzQzEvZzM0NzF2NjVTWWhp?=
 =?utf-8?Q?LhY6qJXkP0vQVBx4=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95a3ec0c-4706-4cbe-aa2a-08df0453eed1
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB10750.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 15:57:44.8419 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F10ZCkc62Cw5JV4dnnynnjwimldfqElwZ5RAyzU0Jprb/ZulSW8Rge1DkDT4N1Yd1uYoENYANCPFo9YJ9HcFNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8947
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

--------------H99oRIF4epCyv6hZ9IXUZwh1
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Acked-by: Hemant Agrawal <hemant.agrawal@nxp.com>return 
qman_setup_fq_lookup_table(CONFIG_FSL_QMAN_FQ_LOOKUP_MAX);

--------------H99oRIF4epCyv6hZ9IXUZwh1
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p>Acked-by: Hemant Agrawal <a class="moz-txt-link-rfc2396E" href="mailto:hemant.agrawal@nxp.com">&lt;hemant.agrawal@nxp.com&gt;</a><span style="white-space: pre-wrap"> 	return qman_setup_fq_lookup_table(CONFIG_FSL_QMAN_FQ_LOOKUP_MAX);</span></p>
  </body>
</html>

--------------H99oRIF4epCyv6hZ9IXUZwh1--
