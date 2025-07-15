Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CECDBC83F17
	for <dpdk-dev@archiver.kernel.org>; Tue, 15 Jul 2025 06:57:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CFE46402D8;
	Tue, 15 Jul 2025 08:57:48 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazon11010065.outbound.protection.outlook.com [52.101.84.65])
 by mails.dpdk.org (Postfix) with ESMTP id B3CF54013F
 for <dev@dpdk.org>; Tue, 15 Jul 2025 08:57:47 +0200 (CEST)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=p1XAJKzXvYjONfxm67b2EgYlLUKPwJuhTC74rcisSExOvQeyf5DyOxSczQQCGPE0DSxnm1PQyTIfWZL0Etnquy/Kd7MlO21jTB+9kmet5YSasshvkbNlxzdO409Yz6iAT0iu5g4kd25tzriHldSghlXpbKv5P+HVKIzJc9gtX76yY4QOW9m6Pq3KY5VShoKzmFMgGtb8eWkH3kZNsIRhNfP4l2nY2cTxlGO8D85zuKed/NdZJFUm9U31JnwgLZeVUzt6eCzlbLyyVsx8r1I4LKpmGDfI99DwRTuW3etOvj0r0BeLwEUfMPgsp08I/Ys+ob4Kc5jJ6MkVaSPpuZNdHQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bH6wJonKouPBCMDGG6U7H5Rhl5fZDw7C2lXiVACjky0=;
 b=M3Tmgb38uTgI8LnLTTUYECddnRqvI825Ke34y7XHSfS1Y1TTsTiPQiT1hBJC9j6gQaAynh4LICTdcF7MyTqntzjdoB2nF5GzityEe5NYRAXaFnwOhSKkNL56bdYGpretOv4R0jVcPHmYIlauClxmJNUdWw4IL5XnX3v6vh8/IMzBy4n12JUmI/lHjPKl2CkiaJFq/MVsy5zZ76k9NDWvZjC+FW08VmlmAN19E9qoD19fb3fwr9FKXOMiuMrhqGSJxn2OaH3HnJ2xFablWYI1qhiZ4EdY5/f4icVGNzSVgx7nLdI3X/E7gVXKj9QoIX1UmvDrtI3VqjwdfwfUGDFxQg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=dpdk.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bH6wJonKouPBCMDGG6U7H5Rhl5fZDw7C2lXiVACjky0=;
 b=gRThQczuZME7Gs30cD75wGq0p3eTrhyQJ+fCNEgok/sZnXbQOCKBVgtM0O9OTegBPnky40NXBOaELI9ZkiBZydKIHQgcO407ZTrK+PHaS2ShR1FVqjzjd7nxBiqq/7AcZ7w7dt3UIDjB/Y0+bDDR2nM6gdEmJ8/K8JvqvW+Q5Zw=
Received: from AS4P190CA0001.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:5de::7)
 by AS8PR08MB5928.eurprd08.prod.outlook.com (2603:10a6:20b:29b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Tue, 15 Jul
 2025 06:57:44 +0000
Received: from AM1PEPF000252DA.eurprd07.prod.outlook.com
 (2603:10a6:20b:5de:cafe::f) by AS4P190CA0001.outlook.office365.com
 (2603:10a6:20b:5de::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.17 via Frontend Transport; Tue,
 15 Jul 2025 06:57:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM1PEPF000252DA.mail.protection.outlook.com (10.167.16.52) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.22
 via Frontend Transport; Tue, 15 Jul 2025 06:57:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vpCPrXUJnwkbaEgBXI7jVSUSsaFJftt63aeRBqOpxLsQ1mwRlOwGK1sFIaNtgiL1gR1yINxUTaHH7KpdaamYObOsQ4NKXtzpZ6TIqzPtM0dfLFqpHaKNH85OTMy3Xi8tJIufGuF5fKyTPQN1UoCEHIENJDDMnS9jLPlUyzSRDDMIT9z5ZuMfa/QAGWIGeE1MRcEzkf3ybW4I7+9qFO2k9++BTfUZ5Vd+vZAVJ7lAspefNLZBjq6RBnKtJDTDyA/FY6983rFouNQmYV4i6J+qjdftP2zjYdXSvi8TGI43YMY5vXD/+XSQ8s7n1Lcprv7Q66NJAfAgZd2+IRcijHqqOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bH6wJonKouPBCMDGG6U7H5Rhl5fZDw7C2lXiVACjky0=;
 b=OVDWamRdtLDgpy42eaH95VgX5COagupCfWZfs/r7e7lZISaUtcuV8conOBCoeEkKsMACoa9rSfIFJX3fgppheT/g08OubVGmxWKr7eUth9lqReVg3omTwEY24lkvATOrJgl00R4BR7/GBJrKRvCLeDbcd99sKRAfeo/7oPFj3ZW8l0aihk6/KxG5oa1ExzTcAuh/L0LpYiAa8PfTtuCUQCjWua7vrfbIXqnyL4LmRmlLViIsXnF8YWD/iD3PhBFaI+LkC1v5iJGrvH6ScMjegr9/IiVwQZQWQ7tHbJ73/6jr3zScvaJ4zCnUc2KYa5Mbzkv7Zo5MPPHz+pHsXnkBoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bH6wJonKouPBCMDGG6U7H5Rhl5fZDw7C2lXiVACjky0=;
 b=gRThQczuZME7Gs30cD75wGq0p3eTrhyQJ+fCNEgok/sZnXbQOCKBVgtM0O9OTegBPnky40NXBOaELI9ZkiBZydKIHQgcO407ZTrK+PHaS2ShR1FVqjzjd7nxBiqq/7AcZ7w7dt3UIDjB/Y0+bDDR2nM6gdEmJ8/K8JvqvW+Q5Zw=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from DB4PR08MB8151.eurprd08.prod.outlook.com (2603:10a6:10:381::16)
 by DBAPR08MB5847.eurprd08.prod.outlook.com (2603:10a6:10:1a0::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Tue, 15 Jul
 2025 06:57:11 +0000
Received: from DB4PR08MB8151.eurprd08.prod.outlook.com
 ([fe80::2dd2:fd4d:8ff5:3733]) by DB4PR08MB8151.eurprd08.prod.outlook.com
 ([fe80::2dd2:fd4d:8ff5:3733%2]) with mapi id 15.20.8922.028; Tue, 15 Jul 2025
 06:57:11 +0000
Message-ID: <543e940a-6990-4cdb-a5eb-e036485a16e6@arm.com>
Date: Tue, 15 Jul 2025 07:57:10 +0100
User-Agent: Mozilla Thunderbird
Cc: nd@arm.com
Content-Language: en-US
From: Paul Szczepanek <paul.szczepanek@arm.com>
Subject: [RFC] Proposal for stable developer-friendly DTS API
To: "dev@dpdk.org" <dev@dpdk.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P265CA0257.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:37c::19) To DB4PR08MB8151.eurprd08.prod.outlook.com
 (2603:10a6:10:381::16)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: DB4PR08MB8151:EE_|DBAPR08MB5847:EE_|AM1PEPF000252DA:EE_|AS8PR08MB5928:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e064d57-17e0-45b4-a9e2-08ddc36ce609
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|1800799024|376014|366016|3613699012; 
X-Microsoft-Antispam-Message-Info-Original: =?utf-8?B?b2crYUg3VGdDRDhPSXZPS0oydVErUEh3eCtGTG81U3V5WkFSR003NUh6VVBx?=
 =?utf-8?B?b1VBYngwWGozYVJpa2xlcmNIdU5XcEZBM09QUHorZnZaRTNnY3ArakNJSk1v?=
 =?utf-8?B?b0I5c01vU1ZFWG5oTzhpbGNPQnZxWlJocjlPTTVoT3h6V29zM1ZYQ2dHK0N0?=
 =?utf-8?B?bXc5S0FEbFZZakF3YWVBUjBlcTR6d0NDVmZsM2ZsVTZENGNnV3RqdlIwUGlW?=
 =?utf-8?B?OHpJRHVqUzBPZjRZSlVobS9xVm1pTUlHUE5tNENnaWg3RVFYS0xEOVg3WHlS?=
 =?utf-8?B?d0hSdkM0YUkyN1pZaTdITTF1UE1yZlBLUTljaXIzMDh2emJvRVJsRHdLUmlI?=
 =?utf-8?B?dlJDbjZwYjFyTXh5c1pJcCt3cHBjVS9MVWVVdHlZR05sMXFZakdxbFBPQXNr?=
 =?utf-8?B?NWpNSFVOZnpXeUVvOXNNSkU5c3hWajJNYnorUWhvelU1OFp1REpJTE9JVE02?=
 =?utf-8?B?QS9vNFpySUpTL0pCTVVSYnBsTWgzVWloeGsyZUlUS3dWeTZZMUZrZjNEWTI4?=
 =?utf-8?B?bGJodmljYUdncktjbmtZYURVSFFHY045UnF0dWprSTlwRmxXZGwyNGFUN0VT?=
 =?utf-8?B?ZkJTa2Q1UHVsOU00a1cwWEhYOGRrSXhYdFg4UktPMUp3akxvUVY2SU9ubVR5?=
 =?utf-8?B?THFIa2Fubm1kV2pQZGdBOG4reEtqUnpTR283MGEyQitudHVsQjNwWURIRVFs?=
 =?utf-8?B?ckFiTW5pRWJpdnExY0NYM1VETkd1Zk13VVR3eTFRY2Y0T0VkWkxPMmRsZEZq?=
 =?utf-8?B?MGFQczY5WjVwajBqN3hDOE1KTDdhNUpxcEhwYkZlQ0hib1l2YnRYaVZ2a0xr?=
 =?utf-8?B?YUNCU1FKRXZXMTYrT0VlcUtRbk13Z1plMENMazZRTGtyaDV5dnB2NFREQzVD?=
 =?utf-8?B?cFpqN2lTelBVZlRabXVpWmFBTjZBTHkxdFlRdGttblZJdlFra1VleWtua3pD?=
 =?utf-8?B?dVlXZ0M4Vnorbi9YMUNpdDhNMnBKOVJXeHBZbVk4U1UwVWU2VjJjZkdLZjFE?=
 =?utf-8?B?ZDlQVlhmR3VsdVdMM2FTbkl4MTIzaDJwS0tyVW15RVdGaHhJemVkaUlBUFJw?=
 =?utf-8?B?dU9uQ2VNRHhWT1VlVW9rd3ppRUVQMkdjMGl3cDJnNUdkYkVEaVVKTkNBL3V2?=
 =?utf-8?B?TTJQaTdSSThBVWlkejljb2ZLb1k0RnRhSlBuLzhDNGJsa0lNVDk4cWx0MzVl?=
 =?utf-8?B?UGUxSDc1TEZ4WWlGZXcwd1BwejRCSytSYk1HUUxLRnJOY0g1S1cvZFdQNkZv?=
 =?utf-8?B?OFovbkxKR29ET0x4TTNrQnVjWkV2Q1RsMTIwQUdXTDVqRU53eGE1akFZS1pm?=
 =?utf-8?B?SFpuaTFoUVc0eVAvU1hDb2FmYXNnZU44b1AwZ0x0Z1ArcHFSTnhSMEVKUGRr?=
 =?utf-8?B?YkcwUnVJVDM1eGg1RVZDTU1ld3hSSFRCYlRObi80RytlTzNidENDV1RFRDVj?=
 =?utf-8?B?TWVyblhFMngwYTdpeXUvLzA1NjJGclhrTUVyb1pmNG5Fd21sWDRVZEtsbU9h?=
 =?utf-8?B?WXFvVStUUEZYaldycGtjWEJEa1gzU3M3b3ZWbE1aZWkwVjQ2NVlYTEJ0emJj?=
 =?utf-8?B?ZG9sb2dLM2l4RWxsZU9FTXU5ZnVxQS9obHpKbjhIZGlzR1g3ejJTSEZVeENX?=
 =?utf-8?B?S2tQRHNraFZ5QTlpY2FMVnhsOGpPb3VHakpxZmZkOFBBTUtxeGlVU29LUS9h?=
 =?utf-8?B?MUFwbGtncm01cFRNZHlDYysyejdyODlLdG5uVkFoVlVTcCtpWnRIRG9JUHho?=
 =?utf-8?B?TlRkMnd1cFJ3alNDOURIejQ1dU4xT01qTk1LV29vZ0NrMm9kK0h1TTRnZGlz?=
 =?utf-8?B?RTdXQldUUGR1d0srU05iK2FVWjhuT1F1bnF3dzZ4TmZuc2o0OFVNUENQRkFJ?=
 =?utf-8?B?VlVIcm44RUp3RUQwdzA5dHFtSjNWNGxoTzJCcFE0NDJKNGErS3dKQytjOGRI?=
 =?utf-8?B?Y01Nd3VKOUNIUU4vS295VEdTUG1Laldad0FmaTFDNUs2NlFFVmxBc21SSisx?=
 =?utf-8?B?V3BucHFZS29RPT0=?=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:DB4PR08MB8151.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE; SFS:(13230040)(1800799024)(376014)(366016)(3613699012);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR08MB5847
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM1PEPF000252DA.eurprd07.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 828b4924-fd16-4bee-2e8f-08ddc36cd28b
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|35042699022|82310400026|14060799003|376014|1800799024|36860700013|3613699012;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Tmh5UUp6a0FHd1NEZjM2WHdORi9uK3M2V1NwcUdiWXFSd29BS3ZyUFlnVXAw?=
 =?utf-8?B?UE5vSXJMVkdRVmJFMnNneXhuUG5zbE5CQTVDZjNoY3VUdVNHWGJFbU0vMmVM?=
 =?utf-8?B?citMMTdFaVBaRUZDeUlQam5QbGl1cW16N25SYUVwcVlJM0hTbzQvQ3Btbnkv?=
 =?utf-8?B?QmhLNDd4QStGRVZqL2VROHJsTnllSWZIQkJmWmhPWUFPakhvN29Nc3UwWDRx?=
 =?utf-8?B?Tmh3U2tRZGM3blFuTUZkbm1OQVQwMVpDN0JFN0JOcU4wcXo5WGJBRXlBRWRi?=
 =?utf-8?B?eGRrQUM1UWF2Uy9meFBTWUI3Wm9ud3BtdjhFdmR1OW1kS01VV1ZPZ0duZjJt?=
 =?utf-8?B?ZzFVWDJCaUtlUGZHRld2emg2ejA0d1ZQWDVtWGc2T3RCdkkyRXNpRDJpMzNo?=
 =?utf-8?B?MlNMUEhoVklmTmxaYmdjL2FoNjVFRjVtbjJkSWkvQ2Uxa1N0WkVBZ21EZ0px?=
 =?utf-8?B?RW5iSVR0S1VZeW5heTJOYUZreFZIeG50RUFjaWoxZ0Z1VzEyZXl0THd0UjZX?=
 =?utf-8?B?bVJ6K0c1NThld1FnRHVhbHBmQUoyWUdqME1ueVljcFdMWHVheGFTUmUyNVNk?=
 =?utf-8?B?N01hbjNySTJDK0tDR3prNlE3TmhJN2ptYzdsNUQ1TjM1SW9YQjlZU0k3QWVR?=
 =?utf-8?B?S3ErZnJ1OHNLUjczeExwTkRTQUlQMDZaTElZT0JwdzZJbGJTWDFCalljVk9D?=
 =?utf-8?B?SDd6WHV0UndOQmFaSk1GUFYzZDBkRHRBdCtUWVIzOHlvdkYwZ3dHUi9KNlpu?=
 =?utf-8?B?RitJRGtGVlFBamJ3elRwMUxWaWJMeXVJOURmbGxiNHNCa2RRdjVRM0lUV0hu?=
 =?utf-8?B?MEJLQ0h6WDMzRFp6d3BleS9RdmhyQ1NhakVITUkxT01IUitaQTJhSmZqSk90?=
 =?utf-8?B?dUhNTVowb3BxV3BpT3hUWHVnbHdnOUZVYTZiamVXcHhUai9pSjIvQ2U5QWM0?=
 =?utf-8?B?Sk4wZ0Q3YU95UTE3VFNibU5WNWkwSWd2N1RxcndQRFVjMEhxVkVHUWVLbUtF?=
 =?utf-8?B?RmJGelVyM083TEdza3BpTmFKTE5LSzVQN3lmUVJaeFVlaHpOWElqTUVCc2dx?=
 =?utf-8?B?UG43eXMzSTBFODI4bXQzMzByY0VJV1dpZXZ4ZStpSndDN0hEVnhGNVhWQUhr?=
 =?utf-8?B?RXhpU3Vvb3haL3MvN28yQXY1VENqZXZJVGdUV3dTMFljMkxpRzg2SG55WWQ0?=
 =?utf-8?B?WCtDQkVDaXpZbytDd1FoQ3NEMzBJODdWeityMTFpNmRVSDlxdTNNbmtGTUJR?=
 =?utf-8?B?VUxnZ1BGR1NzdytsY0xLcHZjbUJ3ZDZoK0cwZXhOWHJ2NHMzNDZqWUh4WHdI?=
 =?utf-8?B?SU5uUytnaEZxZFNUdnhzWGEyNG1QbG5YYzBKSVdHUWlqSkdnY1VrVCtoTk1M?=
 =?utf-8?B?dlEwY01jTXFlTWdBbDYzYUxlU2xZa0pCTkh6R3M4QTh0dHFjRHliY0ZXVWV3?=
 =?utf-8?B?N2t2cWp5R3M1b0o4cGo3aGZFWTY5N0xmWVdEVHpsQ3RBWThOZnNTRit6N3Ri?=
 =?utf-8?B?b1hoazd4NnA5WWhRMi9UZi9TSFl0UnJrc09ERVR0MFh2aW1WUHhIbDlCWUcr?=
 =?utf-8?B?L20rcEJ1UFZGbGJrSVl2RjZ2U2dlNTNnUjFZTGJrdHc3ajlOeExqU3p3V2Jx?=
 =?utf-8?B?OHhwYWp6cGNBbUIyMVhWa3p1T0tmV0FreFV6Ym1tYnhTejZWSFg2OS8zSTR5?=
 =?utf-8?B?dmV1VGZmZVBJaVlEYkI2T0FyS3FZeUZKU25oZXlUN2M2dzZJRGpBMVRLVm9W?=
 =?utf-8?B?K1lnYzhhTlV5bjZBTEVnbmdxek4xRFlKWGtLMWxRbHRHUS9qMUdZRVZodlpJ?=
 =?utf-8?B?SmZEenJpMDEwZjJDY1I0MmYzTkd0UnhST29RV1Q3ZXAzZzVmTzNwMWlucGpJ?=
 =?utf-8?B?V2R3YXJodldEYTRFMk5RUFE0a25GVUFpZElJT3NJT3F5MjYwcGlBMHlXdE5w?=
 =?utf-8?B?UUlCVVRXTklRdSs4VzgyT1VacWVPYnM0MVozY3E4LzNzNkNUV1orcG83am1h?=
 =?utf-8?B?NmprNitRWll2YXNqZFJJQXorS1o2VGZoYlR4R0hyZ2d6aisrcGErYUZFaEVt?=
 =?utf-8?B?RWh5c2gra0s3OGw1cGZjbjBJTFQ0SXQxdFd0RzNwQUk1aGFpV2lTcE1KWXlk?=
 =?utf-8?Q?Q2nw=3D?=
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(35042699022)(82310400026)(14060799003)(376014)(1800799024)(36860700013)(3613699012);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 06:57:43.9448 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e064d57-17e0-45b4-a9e2-08ddc36ce609
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: AM1PEPF000252DA.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB5928
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

Hi all,

Now that we've written a significant number of tests and developed a
consistent usage pattern, I think it's a good time to take the next step
toward project maturity: establishing a stable, well-defined API that
developers can rely on across releases.

We got some comments from the devs present at the last DPDK summit and
they are valuable guidance on what direction you'd like the framework to
go and we're taking them onboard to shape our roadmap. Very much related
to that we'd appreciate any comments on what you'd like to see in the API.

API proposal goal

Split framework internals from functions intended for use by test writers.

This API would offer:
- Discoverability of available functionality
- Clear boundaries between public/test-facing APIs and internal
framework logic
- A stable interface for writing and maintaining tests
- A DPDK-style release cadence and compatibility guarantee (i.e., write
once, run future-proof)

With this split, DTS becomes effectively self-documenting — users can
explore and use only what’s in the api.

Technical Summary

Introduce a dedicated api/ directory that contains a small, focused set
of modules exposing all the functionality needed to write tests.

All test execution logic and framework internals will remain private and
continue to live in framework/, where we can iterate freely without
breaking user tests.

The new api/ modules will be stateless, accessing test context via
get_ctx().

Users will import only what they need:

> from api import dts, tg, sut

and use it as module functions

> tg.send_packet(...)
> dts.verify(...)
> testpmd = sut.testpmd_create(...)

Because the modules are stateless and the context is already managed by
the runner, the changes to the existing framework will be minimal.

Initially, we’ll have three modules in api/: dts, tg, and sut. This can
grow as needed.

The goal of this approach is to provide a clean, intuitive developer
experience when doing API calls, with logical namespacing and good IDE
support for discoverability and usability.

Next Steps

Feedback is very welcome — feel free to reply here or on our slack
channel #dts-dev. If you would like to join an upcoming DTS meeting on
Thursday to discuss this live send us and email (or ask on slack) to get
an invite.

After initial discussions I will send a small RFC patch with framework
changes only allowing further comments.

I will follow up with a V1 patch introducing the new API and updating
all existing tests to use it.

Thanks for reading! I'm excited about getting DTS in more hands and hope
this will make it even easier for contributors and users to write
robust, maintainable tests.

Kindest regards,
Paul
