Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2813AC54FB3
	for <dpdk-dev@archiver.kernel.org>; Thu, 29 May 2025 12:41:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 70587402C1;
	Thu, 29 May 2025 14:41:37 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazon11010049.outbound.protection.outlook.com [52.101.84.49])
 by mails.dpdk.org (Postfix) with ESMTP id 9310F4021F
 for <dev@dpdk.org>; Thu, 29 May 2025 14:41:36 +0200 (CEST)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=Iyu5lnC7Ab+5iVB8mxBJzX+qoZBoHpAnquPgAKBZIK25qqJ4MjOP5iPR58vGcaHG66sR5yNP6Sk5aInv8hEXZ+TqxnbpzagL4K1SVrrYwnuPxXVVu0MS19EEu1FZ9rMsybhCR51/sITJ/nMR99mcpkLGcQjXnVzhnt1/14tGK8uj8qZtA16UelR0wzEPgBei4uWDYYmla6ghJMX6tmb4OuK+L6bNMbLYPF95lnKrfkuanNaZ4FBnTnjpFY7cjpW01yVAEucieIaDD8baTwpz4lY8fwDcRETfJ2W017tRSjh0jHee+iMvKiJHe3GM/GbrTusNrxuuZjYuPuOnSQKTfg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VCdIh26K7rf0y+pawG9uqWa4MMH8G/Cot7bV953qoKE=;
 b=E6V/0cLQiWNOZ4n1TdMxgJM4ywW5RNeLrcJ7tgvY2JqgOZ6RsSb9mUIqTo2DTSI9uDy9zXpkM4jcuPCDt3hEmtxZ3tMwYYIEC58+gtGBHXsFWsepWQ8U55/QF5CYHIkIyStK5W8Z1hLCquq7hEVs8mgGwdaqW+EJZsVIcSeZZD9ppm5zR0bJM7cuctZqN8sJUOHV4g9tlKbEMRSzCip6hd+TdeBtka7jZE//FFxWgwKUpAtQ2cqV3y3WgD0eBbaOAcY5gmCcaI+TciKopEZ8iVv+mJMPhoMu1i1AOv0TEjCkqkOLOghlv83PxDTKn3T6JZArO57dSHbXX3nQv2wn6g==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=iol.unh.edu smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VCdIh26K7rf0y+pawG9uqWa4MMH8G/Cot7bV953qoKE=;
 b=quQz6HgJrhkHsZoYWBjn1YdbZutVlLACg0Qzz90GUUetzuZqVDugCas5BLPZ25L984Qu8dlyYL1rZh0dpCAi+e5w5ZiTyExE+Rn5VptNWMEel0mWK9OHQ/kqhN6keHI5FUPk46CqRy/oXHgtI/gRwtjQFhZNZcHmtSqHOSc7fvQ=
Received: from DU7P195CA0008.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:54d::35)
 by VI0PR08MB10825.eurprd08.prod.outlook.com (2603:10a6:800:201::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.25; Thu, 29 May
 2025 12:41:32 +0000
Received: from DB1PEPF000509E4.eurprd03.prod.outlook.com
 (2603:10a6:10:54d:cafe::db) by DU7P195CA0008.outlook.office365.com
 (2603:10a6:10:54d::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.19 via Frontend Transport; Thu,
 29 May 2025 12:41:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB1PEPF000509E4.mail.protection.outlook.com (10.167.242.54) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.18
 via Frontend Transport; Thu, 29 May 2025 12:41:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mph9110Q9Dfu6X9uTU9iKHohnAG+kheFoU8j+Z+bEQqJTt7dLBYTFhPPPfu0gbj5mjpitGd5J9AWanJateyEg4OueY/SXbacqN2v46CYEyluz0pzmuhQ2z3G/uqkbSqkS+XqUUjSUp+9rW5HrfiFwjl1mjkodANDK641FtuSE4bNNt/AK8FYtO+2GgAvZ/Zeu9TowGFKpyH2RzECaZ4SJhaeEsoP7xZoJOyD5EP9z4ujyq5/2WQAwfa+oFOqjAeKwxCfy/FBA3robDCaJRa3np7VR+UawCAbKtTaCdGjBhkdwnHmFb623SmnekQ2i+If+Oo6DsF8JUhDBPyQzLPX6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VCdIh26K7rf0y+pawG9uqWa4MMH8G/Cot7bV953qoKE=;
 b=hKuaQtsVrNyMcJjh6vUaxXxmEKeCJT/ozWXXa6p6MNoc9J6/9Gm0jhlVUQYd+VxADDk3dBtNQRdd2nPzR2rXRKnkA5vyz+qlk3kOzqDhsbjqaRZRf9v4r9fpihlSGMfaLk5zv/r4oZ9hhNtjEDgUsP6gEW46TXAhOVHIuf2VTtZEIDPXImdJHV4AuN0HXB7RaRONJ1y/jUEzIrwq2NPM0MvUnwteGLYg141S6NDx1PRWXMKRIcktnDGPsiLqngjuv/0xUQY2PlfJUKQH78GTRNZapjJ4BLANx2c56uJMYsmmjloJWdJk8KOyYwbNGedBy/bMeXM/6bw7gYYliEI4/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VCdIh26K7rf0y+pawG9uqWa4MMH8G/Cot7bV953qoKE=;
 b=quQz6HgJrhkHsZoYWBjn1YdbZutVlLACg0Qzz90GUUetzuZqVDugCas5BLPZ25L984Qu8dlyYL1rZh0dpCAi+e5w5ZiTyExE+Rn5VptNWMEel0mWK9OHQ/kqhN6keHI5FUPk46CqRy/oXHgtI/gRwtjQFhZNZcHmtSqHOSc7fvQ=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from DB4PR08MB8151.eurprd08.prod.outlook.com (2603:10a6:10:381::16)
 by VI1PR08MB10073.eurprd08.prod.outlook.com (2603:10a6:800:1bc::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.31; Thu, 29 May
 2025 12:40:53 +0000
Received: from DB4PR08MB8151.eurprd08.prod.outlook.com
 ([fe80::2dd2:fd4d:8ff5:3733]) by DB4PR08MB8151.eurprd08.prod.outlook.com
 ([fe80::2dd2:fd4d:8ff5:3733%3]) with mapi id 15.20.8769.025; Thu, 29 May 2025
 12:40:53 +0000
Message-ID: <4feefa38-e480-4838-b221-d1cef4fb735d@arm.com>
Date: Thu, 29 May 2025 13:40:53 +0100
User-Agent: Mozilla Thunderbird
Cc: nd@arm.com, dev@dpdk.org
Subject: Re: [PATCH v1 1/3] dts: rewrite README
To: Dean Marx <dmarx@iol.unh.edu>, probb@iol.unh.edu
References: <20250527153734.368235-1-dmarx@iol.unh.edu>
Content-Language: en-US
From: Paul Szczepanek <paul.szczepanek@arm.com>
In-Reply-To: <20250527153734.368235-1-dmarx@iol.unh.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0552.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:319::14) To DB4PR08MB8151.eurprd08.prod.outlook.com
 (2603:10a6:10:381::16)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: DB4PR08MB8151:EE_|VI1PR08MB10073:EE_|DB1PEPF000509E4:EE_|VI0PR08MB10825:EE_
X-MS-Office365-Filtering-Correlation-Id: f67a601d-5ae0-47d5-84ea-08dd9eae20f2
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|366016|376014|1800799024|7053199007; 
X-Microsoft-Antispam-Message-Info-Original: =?utf-8?B?MDY0djNuRlpodDM4bFlDODkwb3Y2MDhaYUs0alA0R2x1WkhGTkxONjhCWVJ2?=
 =?utf-8?B?YlZ2QlpHTDcraW5UcDFVeWtHMmMyM0lZSmw3OG5oNmtCN1ZCREhhOVpPYWpx?=
 =?utf-8?B?QXNQRElmTVJaSjVtUWhUUjZBemlrcWREdThpb0JYLzlPbGFBSWs5SldQcFpr?=
 =?utf-8?B?ZmhFNzZDb0dlYURDSTJGcTZnZGFCTWhqbWxHVStZVUc2TUhuNkVKMmVZVHBR?=
 =?utf-8?B?MEU3K25BdXRUUTA4RTlyUUZZaWZzZmQ3SFQ4MTF2dSthbG0rcHpxaGRjV0xz?=
 =?utf-8?B?QUhoMy9YRytCWjNVWjdYb2kyc2wzYzRLZGQyQW84d0lhYmt3eE1jSlI5WVRx?=
 =?utf-8?B?eHJYdzM3QWNGVEJmRWw2OERlMGFzT3pKb1p5MFpTbTNUWWxJOHlpWHkxSDZ1?=
 =?utf-8?B?ZVZKK21obWZDQ1RCUzIyUXliYmk4RGFBV1VqaVp5VXd6VGVVd3BnZ1ZacjBn?=
 =?utf-8?B?c3NxVW12MkJjYVczc0YvUmUxQ0RGUjd1ajlBVEQ3WllXZGZTK2VnNFVrV0ZZ?=
 =?utf-8?B?N1FDWm1wd2MwNzhtVUNnS1JPajJyaDEvcmhJZUI1T3pScDhnQjI2alpiMEcx?=
 =?utf-8?B?eENRSWUxM0tUSmJvSm5HNmlsdDQyeFBjbGUyTDJ5WUE1YjFRUTF4dXJDV0Vn?=
 =?utf-8?B?VXFkL2FEODdDalowMFNhNFNkcTlySVo4R1NabUdYSWpkK2RNaHZZTW90R09U?=
 =?utf-8?B?UE5PbURUSU1rb0luNThnMjBJZlJaSkJjSGpndURxZFh2Q3hPd3RVRFhhWFNO?=
 =?utf-8?B?TGE1d2VPYjlEOVZidTNDc1hXVnJNSkdDVUdYRnRtRVlVZWR1dm9WdXlBMzRu?=
 =?utf-8?B?MVVMdmU2eTJOSHJHQVhPWlJ1UmxTVkYxUHF3V29ieVY3dHlqTEtBSHJzTk1F?=
 =?utf-8?B?QVNNelp2ZTNPTXJTZ2JHTWhDbUpCZWc2WHF6UDNGTEZzOFFoNitydnV1N3No?=
 =?utf-8?B?SE1QMTM2K3lTdklWdzBQK0prUkMvS2JJdU9RMm9VOTJvMHhaenJqRXV1MzJH?=
 =?utf-8?B?NWlLVWVzNFZWRVZJaEwyWE5SSmNrRmdIcTJZeVovNGZvUUs5NloxdVpUZkcy?=
 =?utf-8?B?RWlYNkdVelNYYitVem5wL3crUFJNTm9YRVJwbHJaQzh4cDhIKzdCVkMvd0Rr?=
 =?utf-8?B?VUVnVTNOaG1LaVVRWVBUM29YZ3UrRHFNL1RCTldOQWo3WVQ5UTN6MEZ5VndO?=
 =?utf-8?B?bFJLdU9ndTVMa3ZuRi91NFRzNXlsZEdYYWVoaVp6MlJWY2gvZW9NSk1FYi9u?=
 =?utf-8?B?VFozam5MNDU1eUZ1U1dsNHgrcS8rVUxWUmcyeklkUDNuSk1sWG92alYySFpJ?=
 =?utf-8?B?djRuKzlZZk9vNXY2cXlwYTVmSG5YdC9QenpqN2N5RnM1S1VSWFU4WFdPY0lC?=
 =?utf-8?B?VGVPQlJVV0lFMEJwdTFxa01FUzJuNWFRMVRYVlRjUjJROWNvVnZGajhpVHZ6?=
 =?utf-8?B?VjN1MWs3YVpFUW05UVE1LzZ1L2I0VmVJNGhuWG9saU9vYkVxYy9kUFhRNm4r?=
 =?utf-8?B?UDhSZVlSdWtVYy96Z0xmQjdlbzM3Y0hKUE1OWk5rOVlOYzRTWkpLS3duSE96?=
 =?utf-8?B?MHlEZ2Ixdzg4WkdxUVdBdDVEWFh2dFhXSDRkVGZ0MFlqcEs3b2hvQW5jNS83?=
 =?utf-8?B?M3pGT2NkaGFvdUh3UTVQb0xvbmMzeVRuQkxBY2E5U3EzdGJkYmV0SlY1Sy8x?=
 =?utf-8?B?OW1mSlBESUVIeUprQ1NKYkk3QU94MmdGQyt6cWNoalp6aDRyVW1udmFTRm03?=
 =?utf-8?B?T2V0RUpXZlVQTFpwZCtBMmo3NkE4eUtsajM1ZitzaTJDdm5xbnRpNzRJMjlz?=
 =?utf-8?B?OW1kd2g2ZEtzQ2NITjBNUEIwZWt4QWptVXRtMTFYYUV1bnRQU0lRdGdpb3ZS?=
 =?utf-8?Q?E+PTBucnJkgao?=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:DB4PR08MB8151.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE; SFS:(13230040)(366016)(376014)(1800799024)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB10073
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB1PEPF000509E4.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 11711cee-8038-407f-f4b3-08dd9eae0cfc
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|35042699022|376014|14060799003|82310400026|13003099007|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?KzBrM2g1VjMrWEJpZTVlSmtlTXBlM2ZtSFc4WUJuWTlKbFNjM1RtYW1tWW9v?=
 =?utf-8?B?ZklaQndPMGJzUXlWOCtXcmpIM0p3OVNvNXF4aFJSTWpCSGNzd0txc3hHM3R4?=
 =?utf-8?B?UVhWZjRsSEhrRVQxWUN1TFRwcHlObE9LcHVpamdydUJpRml2czhuMjUvZFc0?=
 =?utf-8?B?Vitvd3FiNzJ2cXZhR0tGcjZQMmgxUmxMalV2MXVvcXNyelVwZkhiMVMwWGZx?=
 =?utf-8?B?cWRXeCs3V3ZpYVJYU2greEovY1Vud2pwVFFzMkpkWDBBMUQ3Z0MzblRpN0Jl?=
 =?utf-8?B?dEdxNTdvaStDZ2RtbTRLeGltSzFOWnhGY3BEQU9mZDMwakZ4RWJCTlpWUUZl?=
 =?utf-8?B?NXNnNFZWUVRRUTNiUkNqcS92Y0JNcHg1N3EvTjVIMWtTdnVOa1FkeWZXVXpa?=
 =?utf-8?B?L0M1RW5DVERhSDE2VkxsODFiYUtwMXkvOTZXR2puR2tGQVFTa3hNV2NuNVZK?=
 =?utf-8?B?amI5L25QWWo3bzFUU0F0MWlzeWZjMHA5dTJNZjMxbU1Za29TSk5BWEtMOWQ1?=
 =?utf-8?B?akxxbUVIS2lPd2JJTDBQbHlmR3RCOWhhOVZ4K05kUmt4RFdjNWNqUnF3Y0Fj?=
 =?utf-8?B?UkpsY21KVGJSSUFJaXcxZkhoMGV4cFpuMWk1VE1GTkpZS0tQa2hzNDIxVUF3?=
 =?utf-8?B?cWJlUjZiVC9mN3hyN1V0T1N2WGNLNzBUSnpheXlMZFdJUE1LU2d3NnU4UE8r?=
 =?utf-8?B?dFVtZTJrcjRhbStsL01qb3hNaGMwM1pJb3hsRjRVL1FSYkpJOFcwTEJ1L1Vq?=
 =?utf-8?B?N3dweWV0UlBMRDNTT20yKzQ4SmVEODlINnJmVDczUHZaT3lOaWNNNGdZUzVN?=
 =?utf-8?B?YXBPcmpwQ1hsdU9IZ0pSUXlGVnpzbjlDK29UZS9EQmt5dVkrZytVREVUUlBr?=
 =?utf-8?B?SUJGcnduQURmRU1nN2QzMHVhdFhHMWtaZU5vSStLWXA0NXpHRmQyUndFR3F1?=
 =?utf-8?B?eDRzMDBhS2JqbDUwZmdoMUIzWlJQSGN4WWd2ZlBSWnN2N3AwVFcwZjF5bm9u?=
 =?utf-8?B?YkZHNEdORTNoNmhxNGhFY2lrTm55YW9TMzdPaE9YRkdNWW5YakRQa3pBZm9R?=
 =?utf-8?B?eFFDeHNSWXY2WWs5Nmk1MXkwamNFZldLbFRhYzIzWG1JL3VhUUl1UlNUdlNQ?=
 =?utf-8?B?eGoxWmN3VThUK25ZbUVzTEF5UGl4aXI3T01rSlFJcFF0U2xWRS8xZWR2Q2tt?=
 =?utf-8?B?dC9nZWE2VWVJNThlbUxWR01yVHBVVTFFRWNPbGh1SkpFV3Z5SXpvYk5ONWJu?=
 =?utf-8?B?QjJDbDZsQUVpVWl6ZmJqWWVsSjFXMmE3OFpQRFV6MzM2UWtBakJ3OWtOUUJX?=
 =?utf-8?B?d0dZdERmcC9zNEgxWVpXYjByRHp2MmFVQStyK0lkb0NrQmxiemdBY3owUjRt?=
 =?utf-8?B?U1h4UFdGRU51emRZUXVxMWUwYVIyYWJBUFlQcnhyNndZMFhFdkNqMkt2UVFB?=
 =?utf-8?B?R055S01KREYzTkdNYXRYWU4rdEVFSzVDZHh6NFBlZXl6MjltQU42N1NXMXZU?=
 =?utf-8?B?SmtlMHBjWHBvWm9wazZyNGVmMzRkQXpzdnphVHBRV2dGd0xHc2ZGY3I0aGs1?=
 =?utf-8?B?TGZFbThqemxweUZtN3ZCaklVVTdOUDVxZzE0NitsaHNOUEluR0lqMnRiZU9B?=
 =?utf-8?B?TlI2RFpndTVXUVlKRDl0ak8xa1NoV3FuZHplK2c4VkVGTm03UDFpS3hSbGxo?=
 =?utf-8?B?dFRONTJXQi9WS0l4S3FxdGY1bTJlcTVncVVKcG1WcnFyKy9DZFVOcmlIcU53?=
 =?utf-8?B?MGZuTW1iRnZnQ1NjNnBtaTFER3kzalZNcG9kS1FRUGVFbUU4Q2c0TlJQTGxD?=
 =?utf-8?B?OUxIeHJTNy8rcnRsUWZyRmFlZWxCbmRnRWhaeTZtV2tETFFMNXVUMWV1VGJK?=
 =?utf-8?B?UzdoaUM3bG1QNjR1RHdGODBlcjlvZVg2UlJzTFF4QmowZi94d2NDQ2FTSFh2?=
 =?utf-8?B?VzFMK3lMMG5PV2tBWEVJWThHSnJMaDNkaXBYNFkxZkZnSHA2MDZReUN2WVVh?=
 =?utf-8?B?MEhXWlp0K0x3PT0=?=
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(35042699022)(376014)(14060799003)(82310400026)(13003099007)(7053199007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2025 12:41:26.9689 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f67a601d-5ae0-47d5-84ea-08dd9eae20f2
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF000509E4.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR08MB10825
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

Pls fix warning and I will merge

On 27/05/2025 16:37, Dean Marx wrote:
> Remove unnecessary information from README.md, and add new sections to clarify
> the purpose/use of DTS along with clear setup instructions.
> 
> Signed-off-by: Dean Marx <dmarx@iol.unh.edu>
> ---
>  dts/README.md | 104 +++++++++++++++++++-------------------------------
>  1 file changed, 39 insertions(+), 65 deletions(-)
> 
> diff --git a/dts/README.md b/dts/README.md
> index 2b3a7f89c5..879cf65abc 100644
> --- a/dts/README.md
> +++ b/dts/README.md
> @@ -1,81 +1,55 @@
> -# DTS Environment
> +# Description
>  
> -The execution and development environments for DTS are the same,
> -a [Docker](https://docs.docker.com/) container defined by our [Dockerfile](./Dockerfile).
> -Using a container for the development environment helps with a few things.
> +DTS is a testing framework and set of testsuites for end to end testing of DPDK and DPDK 
> +enabled hardware. Unlike the DPDK unit test application, DTS is intended to be used to 
> +evaluate real DPDK workloads run over supported hardware. For instance, DTS will control
> +a traffic generator node which will send packets to a system under test node which is 
> +running a DPDK application, and evaluate those results.
>  
> -1. It helps enforce the boundary between the DTS environment and the TG/SUT,
> -   something which caused issues in the past.
> -2. It makes creating containers to run DTS inside automated tooling much easier, since
> -   they can be based off of a known-working environment that will be updated as DTS is.
> -3. It abstracts DTS from the server it is running on. This means that the bare-metal OS
> -   can be whatever corporate policy or your personal preferences dictate,
> -   and DTS does not have to try to support all distros that are supported by DPDK CI.
> -4. It makes automated testing for DTS easier,
> -   since new dependencies can be sent in with the patches.
> -5. It fixes the issue of undocumented dependencies,
> -   where some test suites require Python libraries that are not installed.
> -6. Allows everyone to use the same Python version easily,
> -   even if they are using a distribution or Windows with out-of-date packages.
> -7. Allows you to run the tester on Windows while developing via Docker for Windows.
> +# Supported Test Node Topologies
>  
> -## Tips for setting up a development environment
> +DTS is a python application which will control a traffic generator node (TG) and system 
> +under test node (SUT). The nodes represent a DPDK device (usually a NIC) located on a 
> +host. The devices/NICs can be located on two separate servers, or on the same server. If you use
> +the same server for both NICs, install them on separate NUMA domains if possible (this is ideal
> +for performance testing.)
>  
> -### Getting a docker shell
> +1. 2 link: Represents a topology in which the TG node and SUT node both have two network interfaces
> +which form the TG <-> SUT connection. An example of this would be a dual interface NIC which is the
> +TG node connected to a dual interface NIC which is the SUT node. Interface 0 on TG <-> interface 0 
> +on SUT, interface 1 on TG <-> interface 1 on SUT.
> +2. 1 link: Works, but may result in skips for testsuites which are explicitly decorated with a
> +2 link requirement. Represents a topology in which the TG node and SUT node are both located on one
> +network interface. An example of this would be a dual interface NIC with a connection between
> +its own ports.
>  
> -These commands will give you a bash shell inside the container
> -with all the Python dependencies installed.
> -This will place you inside a Python virtual environment.
> -DTS is mounted via a volume, which is essentially a symlink from the host to the container.
> -This enables you to edit and run inside the container
> -and then delete the container when you are done, keeping your work.
> -It is also strongly recommended that you mount your SSH keys into the container
> -to allow you to connect to hosts without specifying a password.
> +# Simple linux setup
>  
> -#### Start docker container with SSH keys
> +1. On your TG and SUT nodes, add a dedicated user. In this example I will name the user "dts."
> +2. Grant passwordless sudo to the dts user, like so:
> +    2a: enter 'visudo' in your terminal
> +    2b: In the visudo text editor, add:
> +        dts   ALL=(ALL:ALL) NOPASSWD:ALL
> +3. DTS uses ssh key auth to control the nodes. Copy your ssh keys to the TG and SUT:
> +    ssh-copy-id dts@{your host}.
>  
> -```shell
> -docker build --target dev -t dpdk-dts .
> -docker run -v $(pwd)/..:/dpdk -v /home/dtsuser/.ssh:/root/.ssh:ro -it dpdk-dts bash
> -$ poetry install
> -$ poetry shell
> -```
> +For additional detail, please refer to [dts.rst](doc/guides/tools/dts.rst)
> +
> +# DTS Configuration
>  
> -#### Start docker container without SSH keys
> +DTS requires two yaml files to be filled out with information about your environment,
> +test_run.yaml and nodes.yaml, which follow the format illustrated in the example files.
>  
>  ```shell
>  docker build --target dev -t dpdk-dts .
> -docker run -v $(pwd)/..:/dpdk -it dpdk-dts bash
> +docker run -v $(pwd)/..:/dpdk -v /home/dtsuser/.ssh:/root/.ssh:ro -it dpdk-dts bash
>  $ poetry install
> -$ poetry shell
> +$ poetry run ./main.py
>  ```
>  
> -### Vim/Emacs
> -
> -Any editor in the Ubuntu repos should be easy to use,
> -with Vim and Emacs already installed.
> -You can add your normal config files as a volume,
> -enabling you to use your preferred settings.
> -
> -```shell
> -docker run -v ${HOME}/.vimrc:/root/.vimrc -v $(pwd)/..:/dpdk -it dpdk-dts bash
> -```
> -
> -### Visual Studio Code
> -
> -VSCode has first-class support for developing with containers.
> -You may need to run the non-Docker setup commands in the integrated terminal.
> -DTS contains a .devcontainer config,
> -so if you open the folder in VSCode it should prompt you to use the dev container
> -assuming you have the plugin installed.
> -Please refer to
> -[VS Development Containers Docs](https://code.visualstudio.com/docs/remote/containers)
> -to set it all up.
> -Additionally, there is a line in `.devcontainer/devcontainer.json` that, when included,
> -will mount the SSH keys of the user currently running VSCode into the container for you.
> -The `source` on this line can be altered to mount any SSH keys
> -on the local machine into the container at the correct location.
> +These commands will give you a bash shell inside a docker container
> +with all DTS Python dependencies installed.
>  
> -### Other
> +## Other
>  
> -Searching for '$IDE dev containers' will probably lead you in the right direction.
> +Searching for '$IDE dev containers' will probably lead you in the right direction.
> \ No newline at end of file

