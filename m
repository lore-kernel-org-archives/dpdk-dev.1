Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34EB3C54756
	for <dpdk-dev@archiver.kernel.org>; Mon, 19 May 2025 17:58:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EB68440651;
	Mon, 19 May 2025 19:58:18 +0200 (CEST)
Received: from EUR03-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur03on2060.outbound.protection.outlook.com [40.107.103.60])
 by mails.dpdk.org (Postfix) with ESMTP id 9C2D540612
 for <dev@dpdk.org>; Mon, 19 May 2025 19:58:17 +0200 (CEST)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=d93CL5HOmiUdBqGwYlNcJiHIUyTmUoHlzNXCcrtKXu+7Nf998MpMZu7VLhWZGBCBXYsXkBQpvUzgI+HjfxHeIoc+CsfwIuaYwl1s1crmGJEPwKojpLhh+9kipw1emx4epBZk7fcy0e0GBrndj2aNFNPZnwllsRglTgMhbMQ4QY2umZur+FiDmFp2MK0hIlGKD5j6L3qj7QxHQHGVoxonuCwvmq2AWbDQz6K2xPh8ZhFA5paPRoAGxZvQD4vGoTLkFPmTtYyZpjdPTc0LjiC0RCJ0zUCB7uI3QvvZCHuE5w0zYJ0WTZZLH1tk+jVHWfij1bGYrUAl/rxkgpgcW/CLPQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YWUhLej8Po/JcHqAD1B6e2t9OB8ANE/Wbi5wnSiT140=;
 b=b6mE8fAtxqTTjaybbRjH6q0ettoNYcjgNyOSGiRcjdus6hlBAcf1bNUpqwOLCIXyBqLeqOmwej9qmi4uKXSUxNGvswh8No3kHTxTaRLoHa0fnrBUrXvkTN95a4EOFJ1nh2C8EF6XUHbBQEbZ4Dtds9DB2yijcTqXe61vf8knWTwzB1wD+c2erFPpktfLgLfSiSs1JlxSieiKkQ7pGnknNbcHReVc0pzgAYeLolziZ6AiHEbFEqeXRf2pQN1zU7rlCEsbkNydXwCLKk6a0xy7+k8NRr90jUStXvz08Hes1VR/5M7lFoHyWEqBlTHxKQovyI3ReoK5AXLnWFW5qlSIuw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=redhat.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YWUhLej8Po/JcHqAD1B6e2t9OB8ANE/Wbi5wnSiT140=;
 b=H9ZLGRgI8Ne49LUkncF7DkvQm+78GCy/qpWIRTYUsEvblePU8jjlh2PTmYaEshIQWNIf4uumrEGecxVWPVXWweMmCBMbaxcnNpM2ro1CKpyTQOkJsiXsX1AvGkAXobEzJhfomoScjVzlXipVWx/mp5XyhB3JSAIIjIXL231F39U=
Received: from AS4P189CA0068.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:659::23)
 by VI0PR08MB11136.eurprd08.prod.outlook.com (2603:10a6:800:253::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.33; Mon, 19 May
 2025 17:58:13 +0000
Received: from AM4PEPF00025F95.EURPRD83.prod.outlook.com
 (2603:10a6:20b:659:cafe::79) by AS4P189CA0068.outlook.office365.com
 (2603:10a6:20b:659::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.31 via Frontend Transport; Mon,
 19 May 2025 17:58:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM4PEPF00025F95.mail.protection.outlook.com (10.167.16.4) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.4 via
 Frontend Transport; Mon, 19 May 2025 17:58:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D722PAD+aZWfiqViZi8wyKZDVtNeyBiG3L0+sGClWKbkKFBDcvhefOC0Q9ts771M7msjyUMmI36zyrUHBuD+KNJ89xnfyc3LrmQSbxbkelFMQd7O7XjVJDOr2WTgGTbVlh/dl0UieXqjvctnntDxfCPHm+78cdYgVe2bQHpmqunzHWpKSDgJQqPY7b5vqLNz/XTSjcjVW+nPOlgPhupN6+YPBZEm5oou5N56cmJJ3upOr3PQllqyrtNNq3+Mmygkcsbqp8cBqCPMeKtWdThgQwGL/Sjqc47WSA41ZvJXsFw3GCyLbg1FAGPJPVznD1rcRVy7i5Og7zm+tnrj2J07sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YWUhLej8Po/JcHqAD1B6e2t9OB8ANE/Wbi5wnSiT140=;
 b=FMUi5659gvpWdiwQ5R1K3hk19sdgUCNwuMwA7mBMg3Nvib1Fwe1xqIdP2+oHyFy6EqyT1s4zESYT7nyTcLawEyZM7LW+86KbN9Kaiwxx9ExLSkOcnyNYcngkRNggHRVcoF/aAJAu30zmOqNDGxhCq88vqYKuBpRlRe/hHsNRiIhiChrHesLu/bGA8T7WMu3Zq12ADxfOgHbgNARd199rkSTeN9D1XU75Y9ZBV10Xwu9wJTr6NJ3cjlAVWhD/cKqaLRPAZzhvusWk+5nGrA9B1xvE02KlfI/U+iInAlGlToF0N4wIxDgXY/0cZF7arn1oioW8llgOpiBxtqttmnx1mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YWUhLej8Po/JcHqAD1B6e2t9OB8ANE/Wbi5wnSiT140=;
 b=H9ZLGRgI8Ne49LUkncF7DkvQm+78GCy/qpWIRTYUsEvblePU8jjlh2PTmYaEshIQWNIf4uumrEGecxVWPVXWweMmCBMbaxcnNpM2ro1CKpyTQOkJsiXsX1AvGkAXobEzJhfomoScjVzlXipVWx/mp5XyhB3JSAIIjIXL231F39U=
Received: from PAWPR08MB8909.eurprd08.prod.outlook.com (2603:10a6:102:33a::19)
 by PR3PR08MB5852.eurprd08.prod.outlook.com (2603:10a6:102:8e::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Mon, 19 May
 2025 17:57:41 +0000
Received: from PAWPR08MB8909.eurprd08.prod.outlook.com
 ([fe80::613d:8d51:60e5:d294]) by PAWPR08MB8909.eurprd08.prod.outlook.com
 ([fe80::613d:8d51:60e5:d294%6]) with mapi id 15.20.8746.030; Mon, 19 May 2025
 17:57:40 +0000
From: Wathsala Wathawana Vithanage <wathsala.vithanage@arm.com>
To: David Marchand <david.marchand@redhat.com>
CC: Chenbo Xia <chenbox@nvidia.com>, Nipun Gupta <nipun.gupta@amd.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>, "dev@dpdk.org" <dev@dpdk.org>,
 Honnappa Nagarahalli <Honnappa.Nagarahalli@arm.com>, Dhruv Tripathi
 <Dhruv.Tripathi@arm.com>, nd <nd@arm.com>
Subject: RE: [RFC PATCH v4 2/3] bus/pci: introduce the PCIe TLP Processing
 Hints API
Thread-Topic: [RFC PATCH v4 2/3] bus/pci: introduce the PCIe TLP Processing
 Hints API
Thread-Index: AQHbxz7eY9hdOfzfXE6Rz3fgMLmnm7PZhGmAgAC7meA=
Date: Mon, 19 May 2025 17:57:40 +0000
Message-ID: <PAWPR08MB89091411147A69E30D3841D19F9CA@PAWPR08MB8909.eurprd08.prod.outlook.com>
References: <20241021015246.304431-1-wathsala.vithanage@arm.com>
 <20250517151736.2565461-1-wathsala.vithanage@arm.com>
 <20250517151736.2565461-3-wathsala.vithanage@arm.com>
 <CAJFAV8zzDOqg7ENee+V=HxG2e3ZGtXmcX8CES3SD_oufsKy8mA@mail.gmail.com>
In-Reply-To: <CAJFAV8zzDOqg7ENee+V=HxG2e3ZGtXmcX8CES3SD_oufsKy8mA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic: PAWPR08MB8909:EE_|PR3PR08MB5852:EE_|AM4PEPF00025F95:EE_|VI0PR08MB11136:EE_
X-MS-Office365-Filtering-Correlation-Id: edd24363-b1c7-48e9-d284-08dd96feb906
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|1800799024|376014|366016|38070700018; 
X-Microsoft-Antispam-Message-Info-Original: =?utf-8?B?THh0QzdrTlFKa0s2VzhuQVdSMnpHV3NSR3pBRnVOZWpUYUsyRmsvbjk3Q1pY?=
 =?utf-8?B?bVc0bG9FQVFYZERJTDRqRlVXRkxrWFB2aWRzcHY2R0hZUnhJb2tYM3AzcEdY?=
 =?utf-8?B?NnVFOU9jMWVpMnpwWm5CT3FudVZEQXdCcmJzb2trZFFWVm9PZ0g0WkdBV2Vi?=
 =?utf-8?B?ZjBPa083Rm53SGxHMXA0ei83ckU1MTZKNTNaWDhEL21ZajJ5NklEaU0wMG9v?=
 =?utf-8?B?MWgrYVRMb3lhTm11R1RJYTF1akZhaE1FbXZDUkZrUzQxWTV5azZqbldEckVt?=
 =?utf-8?B?dFlodEZQcHFUNVZjSmNBU3BCWGQvMVYxZ2o3VXR6cityRTBTTEFqRUFqNnJm?=
 =?utf-8?B?aUU3MmJUVDhTTm5kWXBzVkxpWFAzVU1Jdm1teGhhZVgxMjRTemZOVWF3V3NQ?=
 =?utf-8?B?WGg3cmFoUGFBd2RpTE8vVElMK3o5Z21rWlVIbFpmVndwM0g0MXRYeit3U1I2?=
 =?utf-8?B?WUNNTWRIQi9aOXlseDV0K3IwbkNITm1LdWdMcVQ1eWQ0TFB5WStyNDBYN3A4?=
 =?utf-8?B?d1BZdCtSRWpSNXU3MVdXa0YzLzZHbi82ZlMySGV6cE1TUFEvMkw0RG1xY29P?=
 =?utf-8?B?OHl6bm50eURqYVFsQW45VEZ2WGlRUzRwSnhUU2I4VFArMEpkRURFUTBDUUZI?=
 =?utf-8?B?OEhsOWZ3bVl1SXVhd0R0TFQ3dzQrTmdOWlJMS00rL0Q5RUVJREpTTWlJeXBl?=
 =?utf-8?B?b2puczdQb3R6MVZ1cHJvZGhIbzB1OGhaSDBUNmpxN2ttdGdYSWVwYWZ4TkYy?=
 =?utf-8?B?aTZYRW84LzJnbktpbC9UQmpLRmEwNFVLQVlPZ3JRcEFMTWs2VzFvbTVwVVZM?=
 =?utf-8?B?QVhaMlFYSXdzakVUS0U4ZkNrb0c4RWhqMHZwZXFUU0h5TVR0YjBzQVBHZ3V3?=
 =?utf-8?B?eUtHcWlNaE9pbjJaanFaTmJGOEJ1UUhnWlFrcFpQVDNRNUc5NkNFWDNtdkpV?=
 =?utf-8?B?Ny8zSUdRaCtzQU5qanlWOW04NUROeDZXZ1pueVc0OHcxMVBFWnFVTG5CZHNo?=
 =?utf-8?B?QzBSQ0FRbUVTNUpEZzdKYUN3bUhjWjBQL1NaRjdhNjkwZjhxeENjc2VpeE9T?=
 =?utf-8?B?cEFsa2JialBvbkVnWVB6UUg1dEE4SEVFT044SGZFQVg2Y0Ryd3RtQTk0RlFm?=
 =?utf-8?B?Ulo4eS9teG81RUppUWZKRTVpNWFnbTVRNXplSTBQclZBOTZLZEN6dGRXNUVK?=
 =?utf-8?B?VjN2dURJdXozdHZPK0U2ZVVMVmxxUUo4WXlVUks1VW5kOFIxYUlJNTdsY1ZZ?=
 =?utf-8?B?b3B3aXhib0VqY3dEenVPRmFoeml4eVdyU00zK2l6UkVpaTZLRU53TnNjVGNE?=
 =?utf-8?B?UUxraE5Sa0pUREJ3L08zVHBUa29wRUJZckxpRVNRQlVwSDVHWHdNcXI2M2d5?=
 =?utf-8?B?SSs5K2ZlUFNwRDNiSmtFTElra1hjVmR4bUI4MCtCQm1oNDVFd2M4U0xzRnNr?=
 =?utf-8?B?SStWOUZZb1gxQ2RtUkFsdEJ4U292c1pIL1pBaUlPYXN4dzdkdWxXZWU5cWk5?=
 =?utf-8?B?emlDQjlSbkU3Unh2YXpJMWw0TWR5WGxwMGU2T00zM29BajFlNXk1Ly9DNWpU?=
 =?utf-8?B?RHE1bGlRcjNRbUlVbWMvdklwWUMzMjJHbXp5ZGhzS2hvMTd3bkMyUkZmTS9O?=
 =?utf-8?B?czViMFBMQXVvTDNKN2ZmTk5wNEZ1ZFpQZUVFdU9OOUlnM1JqdmRUU1VpTGN5?=
 =?utf-8?B?cVdLaWMxR0VBRHVZMlRIb1pKYXlibzRqVi94R1VtR2RNbjFJZ1dPQ3hYTkNp?=
 =?utf-8?B?VG16cVp0WmFpU1FxbUlzUyszdy9idExMMnhkR1hyQ0hRZitBZjcxNGc2dUJr?=
 =?utf-8?B?WUJSNC9WL0xtRDVIS1lMYmxBTmowalNjamU4MjhEN3RCMlc3VEpWZ1VZMGFl?=
 =?utf-8?B?VnAySExPQ052Vmloekcxa3RSaEVpTjA2UjRuWWt0VUx2RzQwcXY1S1ZGWXBD?=
 =?utf-8?B?RDkxeWxIL3kwMXVKVDl1NXZEN2pxOVQyRENWT052R2FleEh2MG1LZ3dCdUhk?=
 =?utf-8?Q?vEhPMieHkq73yKVrR9Cd8ZCGP5SfT8=3D?=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:PAWPR08MB8909.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE; SFS:(13230040)(1800799024)(376014)(366016)(38070700018);
 DIR:OUT; SFP:1101; 
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR08MB5852
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM4PEPF00025F95.EURPRD83.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 6b9991ed-47e8-4d42-cd70-08dd96fea61e
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|35042699022|1800799024|82310400026|14060799003|36860700013;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bmY1VC8rbkZ5Q3NDT1JkbC9EMkcxT2R2UXVaSEtKb3FoUFd0ZGZGVGJ6RmRF?=
 =?utf-8?B?blpPSytUVUx2UGFvU3lwZTZEZXZGOUtlQmlYbkJvbGhBdXh6Y1lNUmRsK1Rz?=
 =?utf-8?B?TnB5NEdQbEQ4L3ZtTmhlZElzaWV6VUlmK3J4dHlQM0tRUXdqcEtzMGVrMkZO?=
 =?utf-8?B?RkxLdTRWMkgxRk04ZU5vZ1oyMWNqQkFzNXY1T0xZd0RvSktteXQ4YkNoSGs1?=
 =?utf-8?B?SEdPTjhnVFFHT1I5ZU1hU0VBV2lpdzRRQ0g1UlZWSklnVnE2SFVqZ09FazFy?=
 =?utf-8?B?NHJ6VnpKUThPdzJ4STNSWnpWOFhEbU45TURUYzRBSEd4Z0xRWHFnR0pPVjZQ?=
 =?utf-8?B?VGEzOG1XZWhic04xOFI1amlYRzRKc1hhTXZ2MXg0Vm1kU2ZIcEZKbDN3TU1K?=
 =?utf-8?B?NDJlVC9LTUt1dWxna09QRjBzWjBwZlhpYlIvT01HSUFHbUVIL3F2N1dPcGtK?=
 =?utf-8?B?SjRmN3lpMWJFYWgycUkxRngrZ2pWQzk3ajdNeXFjbjEyWFlZVmlUTlM3bUJi?=
 =?utf-8?B?a0lCVFpZZnZjbERSUFBZd29iY3VwWXhnNWgwZXpJNllKL3lqQjZIWWZGRnJI?=
 =?utf-8?B?Y0FMUGpnZzZjWjFsV0ZKbjZNVFJIMEpnL0tNNTlDS0kzOFFDZUk5YnlxYjhw?=
 =?utf-8?B?bFZ4T0VLbENZdkFjMkltYS9RL2NlcGVyaVB3K3VxTlpiWW9WVGgwUnhNM0No?=
 =?utf-8?B?TXl4K2VwUGZaVEp4RVBJNm9DVitwenc5bmZ1dVZteGNxQmRTTlh5UkdXcGR0?=
 =?utf-8?B?aFpFSzZremVvWUNGT01vVWhoNDYyR2l5ZEh5ako4cTQ1dzZaOTZpckEzT25Y?=
 =?utf-8?B?ZlNmcTB3V0lUR0s4RTdwRXVzemtPc3hVRTJTRldhaEI0ZGx2bDFGcjhIWnpY?=
 =?utf-8?B?eWVHSDdUTFhRV1lGS202OUZBZ2xUa3htblZ5cmdRYzc4dUhOZDNOZXA2MjNQ?=
 =?utf-8?B?M1RkZkRKT01VNjkyZlZBVWlxMDg4RUw3cTM1dnVxamJiZ1JRSnRZZ0lVcTgy?=
 =?utf-8?B?MEsxZ1ZOZ3BjSVR4dnFEK3dHeFE0TmhKVWtIbURwdk9pOTNqcFJ0TVc0NHl4?=
 =?utf-8?B?SitSQy9PZzMrMGtjS1p3MDJIODc4OC9JK2VuRVZWUVBQaWlxYVVTcmdwNmNt?=
 =?utf-8?B?NVlvQlVYa29pWUc0UnE4TUhub2gxK0ozR3dLRVVPR09vNVJBUHUwaVBwSUU1?=
 =?utf-8?B?Q3FOLy9LR3lhZkljS3VUQkZHZVlqa2NVeWpRWGpzK3F0VTVUeU0wM2hpMCti?=
 =?utf-8?B?WTltSlNzV2h2Z2xieG9NNjhZV3FTZFlMUTEwd1Z3S1dsOSs0bS85bkdxanZG?=
 =?utf-8?B?RU5jUzFkYnI5SEtTWTNHOHVNQWwrZmhwZjFxNndlYW9ZK2E3NWw4elo3ZVNs?=
 =?utf-8?B?VEpIREdwRGJHUjY1UHJOTzM4cUNSSytuMGZidkc4RXJ6ZWFmNTBqSTZLOC9j?=
 =?utf-8?B?OEhUWEF1cjZyY0J5cE50dkdXOXhJTXlPbHpYQStrUnhndEhZV0JGK3JreHZk?=
 =?utf-8?B?L3V6UDhlRXpwdTBCbThSdFdUd0JxVGN0S3dKVFh5dzA4RnVVWU50ZW1oVjhJ?=
 =?utf-8?B?RGt2dWJVRXZyUFB3NDloV0pHUDQ4c0psL3RWbXFmWjdGVkdGOG1YNnRvUnZS?=
 =?utf-8?B?MGxTWVJJc2dsbEdWcTFyMjdEN24yanQ4bnhHWVlkVnl2Ym1NNkw5bWd0QkxJ?=
 =?utf-8?B?VGd1QnZVZmJBcHR5cWlSei9odkVJeU5JbjJtTjlqU01palRWK0ZPM1RWUXE5?=
 =?utf-8?B?UkZlVXpMbjVQZnlQcnEvZTJmRnpCdnV0ZUloYzhiUk8rS29sbGFvSWpMMjlH?=
 =?utf-8?B?SE52SHlaL0o1bUV4VGdpYUZIWjdjakpZeGx4VVRzUFFScHovRmlicmJGYTZO?=
 =?utf-8?B?SzcrQTFFcXhaM0dQNDBoQ0g4T2RzLytpNm5XTFpwUDY0dTNyV2pWSWFtZS84?=
 =?utf-8?B?aGVaU0Z5OG1uR3FJWkJQbjRyNUVXa2FLc252SzBhcGROZWFScGxDZWxOZFRj?=
 =?utf-8?B?RWJXUE0yUUxab1QwRDhPcW5lSU1YNDRyblBCbkQrdEhQMFpRbnJaL1IxWnVy?=
 =?utf-8?Q?xXOI8Q?=
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(35042699022)(1800799024)(82310400026)(14060799003)(36860700013);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2025 17:58:12.5596 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: edd24363-b1c7-48e9-d284-08dd96feb906
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: AM4PEPF00025F95.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR08MB11136
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

PiBIaW50cyBBUEkNCj4gDQo+IE9uIFNhdCwgTWF5IDE3LCAyMDI1IGF0IDU6MTjigK9QTSBXYXRo
c2FsYSBWaXRoYW5hZ2UNCj4gPHdhdGhzYWxhLnZpdGhhbmFnZUBhcm0uY29tPiB3cm90ZToNCj4g
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9idXMvcGNpL2xpbnV4L3BjaS5jIGIvZHJpdmVycy9idXMv
cGNpL2xpbnV4L3BjaS5jDQo+ID4gaW5kZXggYzIwZDE1OTIxOC4uNDYzYzA2YWQ2NCAxMDA2NDQN
Cj4gPiAtLS0gYS9kcml2ZXJzL2J1cy9wY2kvbGludXgvcGNpLmMNCj4gPiArKysgYi9kcml2ZXJz
L2J1cy9wY2kvbGludXgvcGNpLmMNCj4gPiBAQCAtODE0LDMgKzgxNCw5NyBAQCBydGVfcGNpX2lv
cG9ydF91bm1hcChzdHJ1Y3QgcnRlX3BjaV9pb3BvcnQgKnApDQo+ID4NCj4gPiAgICAgICAgIHJl
dHVybiByZXQ7DQo+ID4gIH0NCj4gPiArDQo+ID4gK1JURV9FWFBPUlRfRVhQRVJJTUVOVEFMX1NZ
TUJPTChydGVfcGNpX3RwaF9lbmFibGUsIDI1LjAzKQ0KPiANCj4gVGhlIHJlbGVhc2UgY3VycmVu
dGx5IHByZXBhcmVkIGlzIDI1LjA3Lg0KPiAobm8gbmVlZCBmb3IgYSByZXNwaW4gZm9yIGp1c3Qg
dGhpcyBjb21tZW50LCB0aGlzIHNlcmllcyBpcyBub3QgcmVhZHkgZm9yIG1lcmdlIGluDQo+IGFu
eSBjYXNlKQ0KPiANCj4gDQpZZXMsIHRoYW5rcyBmb3IgcG9pbnRpbmcgdGhpcyBvdXQuIEkgb25s
eSB3YXcgdGhhdCBhZnRlciBzZW5kaW5nIHRoZSBwYXRjaCBvdXQuIA0KSSB3aWxsIGJlIHVwZGF0
aW5nIHRoaXMgd2l0aCBmaXhlcyB0byB3aW5kb3dzIGFuZCBCU0QgYnVpbGQgZmFpbHVyZXMuIA0K
