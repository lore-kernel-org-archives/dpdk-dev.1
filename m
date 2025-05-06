Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DD48C3ABBC
	for <dpdk-dev@archiver.kernel.org>; Tue,  6 May 2025 22:57:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 975AA4025D;
	Wed,  7 May 2025 00:57:10 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on2072.outbound.protection.outlook.com [40.107.22.72])
 by mails.dpdk.org (Postfix) with ESMTP id 5AACE4025A;
 Wed,  7 May 2025 00:57:09 +0200 (CEST)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=j7unHpUtdga9N7rUzlrdxOHy8N2sM1XugRmxJLg5joV/12+9fOfxTLNKMz/CXQ43JF9s3QQOf6d4qTdfIy/dxp2MdjJvNw5d1X6yJW++1X3eGFEc4tR1eBB3fWTg6ovVTv2sgTrqi+KjrrbM8XwUJ1dP0JUVjfhk9S9F4Ku7nKrDX3zFhwLNIEsvSQFGBW6dy2xkUl72I7PhhSl1PK3MCmmFofn2WEGVnTTveEaMQBQDXvuJaVAHAxlWaQtKh6siRYOGpW4vqIWdV/ho4fCYc9o1lJC4VfiRjDuoovO8XQQgTZFDw20LPZtoEgvWX5pZ3pRa74r2jzhq7/xjipv2AA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/lKZfFC7YxUpUgmkLvDjZSCRCMXZ3dryJZwuEpzmsyU=;
 b=MYZ5WH6cevlaWgtMxnQlsMJWZm6k9YpYzU3AOU1fxgKHDQvJzVLfEqYU6Pd6odK0K4NuPgg7DnuHNuzb5B8BsnwBniayyQ4OD4rEdds7pbJxPkfy2LVQnT/ClcwY/Krevmj8PzRl2OcRTbGb2m75kV56PoZwc6Iij8Pa7xapJtbtXdohHVs/Dd0+hzeJ2austNfPcS7OZAFcasyscWCnDzQx+KY4kB2YHMislr5CkLKuO/gOH6se/Qp7H57l3zzqMoKM9s+eVypR86UAA45qtf0YxUePi6nZhPT9wcdMbdybIWpNhrRN+7F884fDv1TYmsI3pnrbbddCDyaFBeSZ5A==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=dpdk.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/lKZfFC7YxUpUgmkLvDjZSCRCMXZ3dryJZwuEpzmsyU=;
 b=QdLZdh3zjEZhdFgBDfUk8tadLVjMvHSBRgNNULdzLlUamQ37kyiJjBc0HEE5LDE7oLOyVeDQI6HCJ2AIPrePsEJE41JAU5/RsPVHHaHkCOzFTOFszXNAD3hLVe1lWP8puBTnlt+kXJsncSlOCy8KEmVTybXMJ7CjaZZ6f1gLiJM=
Received: from PA7P264CA0019.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:2df::15)
 by PAVPR08MB9436.eurprd08.prod.outlook.com (2603:10a6:102:316::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.24; Tue, 6 May
 2025 22:57:05 +0000
Received: from AMS1EPF0000004E.eurprd04.prod.outlook.com
 (2603:10a6:102:2df:cafe::8c) by PA7P264CA0019.outlook.office365.com
 (2603:10a6:102:2df::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.20 via Frontend Transport; Tue,
 6 May 2025 22:57:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AMS1EPF0000004E.mail.protection.outlook.com (10.167.16.139) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.18
 via Frontend Transport; Tue, 6 May 2025 22:57:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UqYSVu58fQGG98XJJLpM/8ZpF87qyQLe74y1Lol0KS4fQjQTz2I+H9Tvs2COTSd8ZLWrtu8b5ClTYFBGrVQh7bKLTQQMrbrO8Zj8yy/h6SmpF6+tDCDesHezToEYAyRxH792kOXMmZ74mNskwIkcDxMGTzWVT5sPRKWq8g6/hFfunekkql0JI7gJlDgjhH9lXie6asDBftVmqTGJE4Yexl4Bqd46M4SGCaVoYhfu+qgibUxj3mKWwGExrzbHzqlJZPtSkW0HKxFmO1zrJGKIykRfXuOgMIXObYvABJ5UeEJOo0v+5t3gUi/ux4V0fJ0YRAsHCNH8aBy6aH5/3fzX5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/lKZfFC7YxUpUgmkLvDjZSCRCMXZ3dryJZwuEpzmsyU=;
 b=Xq8hhwCFzOYTs3S7NMeDt/Ca36DfV6hm6kDryVJ04cIvkYVzNi0YCntHo0V9Z+6/OqcyibbhVndOUmgjqZS52KII2bynsRw5lJT8aQ5IyFNgsMKP4BO8YE7/BylZCuunlbY5UyikPmHCzp+mL3uW6+cQR6uxYeZj2rS9/A8XBefaV6yKjILdfq1Kl6FB4UZNrmF/3CKkxUoSawlZ2nBH9nml9KOyxllVB1+sVo6eRWa85VmQKZrxN6Y0r+cj9WqSdiBcVjbhjlcQc0jB6tnpql99IBJYXxdfCMz7K+nOM15LfgdrJHKoG+EVa9OD71Uy5QyVEUfungMZ7yJ/JESO/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/lKZfFC7YxUpUgmkLvDjZSCRCMXZ3dryJZwuEpzmsyU=;
 b=QdLZdh3zjEZhdFgBDfUk8tadLVjMvHSBRgNNULdzLlUamQ37kyiJjBc0HEE5LDE7oLOyVeDQI6HCJ2AIPrePsEJE41JAU5/RsPVHHaHkCOzFTOFszXNAD3hLVe1lWP8puBTnlt+kXJsncSlOCy8KEmVTybXMJ7CjaZZ6f1gLiJM=
Received: from AS4PR08MB7806.eurprd08.prod.outlook.com (2603:10a6:20b:519::7)
 by AS2PR08MB9128.eurprd08.prod.outlook.com (2603:10a6:20b:5fc::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.31; Tue, 6 May
 2025 22:56:31 +0000
Received: from AS4PR08MB7806.eurprd08.prod.outlook.com
 ([fe80::f47:c79b:336b:3072]) by AS4PR08MB7806.eurprd08.prod.outlook.com
 ([fe80::f47:c79b:336b:3072%3]) with mapi id 15.20.8699.026; Tue, 6 May 2025
 22:56:31 +0000
From: Honnappa Nagarahalli <Honnappa.Nagarahalli@arm.com>
To: "techboard@dpdk.org" <techboard@dpdk.org>, "dev@dpdk.org" <dev@dpdk.org>
CC: nd <nd@arm.com>
Subject: Tech Board Meeting Minutes - 2025-Apr-30
Thread-Topic: Tech Board Meeting Minutes - 2025-Apr-30
Thread-Index: AQHbvtobl9xJBWDId0uPypFTWwCBRQ==
Date: Tue, 6 May 2025 22:56:31 +0000
Message-ID: <9BC07B23-7A1E-4AC7-8C2A-98A0F478578E@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3776.700.51.11.1)
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic: AS4PR08MB7806:EE_|AS2PR08MB9128:EE_|AMS1EPF0000004E:EE_|PAVPR08MB9436:EE_
X-MS-Office365-Filtering-Correlation-Id: be7710c3-55fb-4101-c7db-08dd8cf15164
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|366016|376014|1800799024|38070700018; 
X-Microsoft-Antispam-Message-Info-Original: =?utf-8?B?eEFNQ1M4VFdOUjNRVzN4eW9sMksxcVlyd0pQa3ZoZVZoNE5IU2Jna3BQbGdP?=
 =?utf-8?B?bm5mZTB0blcvZUFWbGxhSDFsTEJ4TVZMaTZ3SGZJUzVUY09iNGlONkhtNi9M?=
 =?utf-8?B?d0xoclRjWHhabTZSQTBwVlZ1cThaSVNsbkk1OVpheDBmZytLdWM4ZWlHV1dI?=
 =?utf-8?B?Y2E4OWVTeDNjWEl4T1ZnT1NaN1RibnRhS1VDSFlONGRMdmEvcDV3NS9IaGFK?=
 =?utf-8?B?WlFaYkNvWXhqNFFlRnNyYWx2eEZxVUFHdW0rM0w0aHVSY0syd3FTKzhNMWU4?=
 =?utf-8?B?b283V3krcUhmNU4wdVBmaDNaQjdDazJXZzdnYVV2alFGeG5oVXExekNLRlFs?=
 =?utf-8?B?S2VwOGhMam13WW9MeFI4bGVwUVBmYm5NeTJhREI1R3h5M1oweHpPOXBrZE5p?=
 =?utf-8?B?cnM2YUpaUEZXV0ZuV25lQVNKb1lCZnloNitudFhyREZQTU00TlhaSG00dk43?=
 =?utf-8?B?UmhrV2VTUHZmQXUzMWVPT1NMay81ZjBzdW43Qm80T01xZk5aUVBaM2RqQVZC?=
 =?utf-8?B?cXRHRmdaZ2hBNno1M01ORGZaQk02YmNqM01kMFBRWXN4N1c2WTg5dGdudVov?=
 =?utf-8?B?NUErb1c5TTBFRFp2OVRCbncrWGhLUXVUTXRMK2lVRWtxbEE3V1VFc1A5VmE2?=
 =?utf-8?B?TGFkSDd1bWZjczhtTzZoZXpQaWNCTHg3UXE2K0RKSkZIWk1VTmFwYzM2Vkw5?=
 =?utf-8?B?TjlrMmcyRUc5UmJIVUFVNFNwY3RZSUpmTVlJNjBxN1lpaDlmalU0NjBpLys1?=
 =?utf-8?B?QnRVWkZOK0U2Ty84VmMwc0pwYVRtdmF5bk9SbWtxTlFWK0U0V2txWFdaSm1v?=
 =?utf-8?B?MjZWTUJyV0NSUFRaTGFUNThEcXRKWEZVZ20xb2lNQTA5cW9WU3BScEkxQWRl?=
 =?utf-8?B?eGY4OHFVbTNreUZlSjdpL0hOOFRTZFp5V3ZlZ3BqT1h2WGl3SWErUHAxa0No?=
 =?utf-8?B?UkZORU1IWXBzMGE3bjJvT3V3MjU4aVR0NlpNU25EUzdMckFPNlVqZnQrNEdC?=
 =?utf-8?B?a2hPdEpFVVVaQXNDaW5rdTF6RjlDeElvOTdzOCtibUdTK3gvcWM3MnRHVnpM?=
 =?utf-8?B?UEtEYzNmaXV4dk1mNUdVTWdJUGxqczNKblhXTnQ4cEZFaEJqbWNhQmJnYTZN?=
 =?utf-8?B?NllOUWkrS0FDZ1pveHB6Z3pPY1pFUHErSnA1TnBIOFlHSndYZm56Q1VqOGhN?=
 =?utf-8?B?ZlczQWJPNXMzRzhDTzF2UUpkTHh3a2FJTGY4WDJ3UHJ0anUyVEdPanBtOC9t?=
 =?utf-8?B?NExZVXFoWTNXc1RBSEdzU0lxRDN1aFo0dXhySzNkQmQ1aUVJSEFkQXhNMkUy?=
 =?utf-8?B?WWdoWFYzbENRbjdHc1UyZHNLUEhYenozL05JVVlYejJCaWpxUGxJUFdEZGUr?=
 =?utf-8?B?NVRmRE84aGxnNjluV296bjd6RU1YV0xGTnB5QTBBS0I2YkFTWVd3eHgvNXhT?=
 =?utf-8?B?bXcxZTROZEh1c1ZlbEJLUiswb1VCbUd3TVZqRlF3TWJUWUJHQ3UySU1PRklw?=
 =?utf-8?B?UzBQTkM4cG1nb0NaV3d1SmxJVGRSdVJ1TzlqelRaMEx5VFIyT2dYL3gvbzdQ?=
 =?utf-8?B?d2UxK1pBZUlieDJVUEdjaVc3THhKUGxvZmFvNEFtYWJqdEJwbmtqT0NXZVFR?=
 =?utf-8?B?MFpiM3VPTjRVQ0R4VmJxakdWTFY2Q2VIcVFWNEZFc1hYanBkR2h4bFd6QVJW?=
 =?utf-8?B?UzJDc0dVOWlsVDJjOWUvU09WZTZXSnBZNmxndEhmY2RNRk1KdkZqbTBhQUNI?=
 =?utf-8?B?Mmx1R1UrZXBMQlNtOVg5S01WWDdLWVdmajFyNGlHTER2dWd1TGRrMytEUTRi?=
 =?utf-8?B?aDFzMFdoWVhZb3Z0U1Joc3pTT2dneGs4U0Z3ako1U2ViWHh3K3hibGZGYkYw?=
 =?utf-8?B?b0xEaU5QSnp2ZXJqeWh3MjRFUFFCK2Qvc2pRaTNGN3dPL1NORFh1TnlZeEtQ?=
 =?utf-8?Q?1FY9i4pxO806N14SQJT9LAB6G17rGLq2?=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AS4PR08MB7806.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE; SFS:(13230040)(366016)(376014)(1800799024)(38070700018);
 DIR:OUT; SFP:1101; 
Content-Type: text/plain; charset="utf-8"
Content-ID: <9AE8821BD829F54D8CDF0003A9EF9360@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB9128
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AMS1EPF0000004E.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 544ceb93-a0b4-4c9a-7ab6-08dd8cf13e27
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|14060799003|35042699022|36860700013|1800799024|376014|82310400026|13003099007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SWNYUXVGcFducVBueDBiU1h2VkhoZFdRQks4M1ZWbDF0UkFJNDY0bGE0TUlN?=
 =?utf-8?B?TnAvU0pubVIxVDJLcWFGNEZ5TXZNMDFMKzdnZUxsZkF6SjVYS0pLck1QbWxv?=
 =?utf-8?B?YTRpV3FVSmlrNDVTdUZxRWIwN3VsQUlscXlZOERMbjB3Nk5rREdTdVBuYWhJ?=
 =?utf-8?B?dzNQSHRKOGZYMERIaGc0dWRtWWsxVUY1c05JT3FzeDdqRXN0N09NM1FpcFRk?=
 =?utf-8?B?emJKUFF6MTdSaFpSR2p4RXZCVGl3Q05iWmg3a0UzbDFFN0xid3hjUmxTaFYr?=
 =?utf-8?B?UGNDbTFWMWcvTE9TZG5nWEgycDFNZ1FxRjNIWGtrVDdvTDdOdTJuUnlxMnAw?=
 =?utf-8?B?Zng4ZU1BbUNwWUtOM0VLOVRzdGRJUUFEelZOUVoxWVMrN280RXlWRVVHbkpO?=
 =?utf-8?B?ZGNnQ1NwTksrR2k0KzJZS2MwZ3lWYkl0MWxiQTVGVnVwc0poMGFIUDdOZEhw?=
 =?utf-8?B?cHI5R1YwV2xGeXRNTWZuRElWby8yQ1RZNnJhdmpSZWJLNFk1NHVqT3R6UVpz?=
 =?utf-8?B?Wm5mbVdFdXlPN1BEbXhINjJUc1p3WFZDckoyZ0RYc1U1NDJXcTVWSFdhQ2M1?=
 =?utf-8?B?QnhMNVV5c2VCVE1GZEx3djU4WVBEV1FMNmo0SmtnbDU4R0YreDJ5L2FiU2hh?=
 =?utf-8?B?ZStWcUZqN29sL3cxUU85WEppTjRPSUFSa1A0ekg4ZkZUaXdHZWFjZmUvR1FV?=
 =?utf-8?B?MUFrRHcrb3hmdVlENFJUMjNvUnI1MFZ1cmgrZW9ybWJnR2hJdi9OUHJBUzQ0?=
 =?utf-8?B?UVI1dFZCdG5acDJVK3gwUkJxendWYmVDbWQ4MWgvdjZQc3BaenBJc29ybDRI?=
 =?utf-8?B?cVl2NGJ4RzBVKyszbUJyK1NVUVlSZFlQMDNsdW5JcWoyNTkya01MdFlSTmQr?=
 =?utf-8?B?UWtiQlYzMDRocGlsNXlaMXdxYlNzU09YMXExWHd3bGQ1L0RQcHhrcFhjTFVY?=
 =?utf-8?B?bWwrRGR4Y1lnTkY0KzVySGFHdno3aFcwQndVVlovMWVKblFsZGtYNitnbWR1?=
 =?utf-8?B?VXJKV3M2SFhlY1ZpcmlPa2NTMFdDSFpNV2xBR25YYkRLMkhSeC8wYzJDK3ha?=
 =?utf-8?B?SzV3ZWdoeGExejN3NnYzSFpzMHZ5UlFrcmZUaHYrRFNsK3ZYd3ZCVTVTZSsr?=
 =?utf-8?B?Nm5BNXIvdzBVUHptWHo2QVJ1QVhwYXdhZThHMGNCU1ZRV2UxSmpVV1lBSEtp?=
 =?utf-8?B?akc1SE5xNGRBMUYvTUFwN1BsRWxvR3hXL25YUnVzcFNpaHVnZ1NUenVoeHRQ?=
 =?utf-8?B?Z25GY3lONHF6MzlsMnBTVUlEUUtISUZMN08yQU1Hams4YWhZcU9BVmZOV0cw?=
 =?utf-8?B?U1ZvMXNjbEk3a1lSdFJBS1ZVZUZSYytLVGVUZjFkWUdMakNnV2k1dW9DUkFI?=
 =?utf-8?B?Qi80aHUyY2RycjNFaTJYM3l0MzY5SEY2WFpTOFAwV0pLUDFSbHF1R3BnekNQ?=
 =?utf-8?B?S2JSc080Q1lXQktEU1N0UGxyL0VwaFRIY29ZdjkxRjZEYldqc2NoWUErTVJM?=
 =?utf-8?B?M2lZd1RHdkVsR1pmMkdxYVNtSkdjcm9wc1hOSUxZN0FBQ2luaDZmNTB6LzJW?=
 =?utf-8?B?aGZKbGFzbExOQi9iSDJqUGpsdXZZbjF4YWdkUlR1OGdUaDdvQnZZOWdTc0Qy?=
 =?utf-8?B?MVVrbWNwR3o2UXRhMnBsZkg3N0NUQ3M4bjREUmdkbDNyUlhYTzQwQXo2Q3FB?=
 =?utf-8?B?T1BoaU5LYjdGRUxBUjdyVC9RS3plbjRyODBSVzUyMGoyM3huSzNhb2t5Tlh1?=
 =?utf-8?B?a0V2ZEpZZDJ3cUorenUvNmRPMjhFVFZhZ1FrTnpHd2dGa2h3QUxmNkhkTEJs?=
 =?utf-8?B?M3BBMWMyYzc1UHViWW8xWjVMYnpMQVdaMHZGNi9IcjZzaWowM1ZHeGNWaXpa?=
 =?utf-8?B?WnhzMGZYLzE5aHpXaXMza3ZacTNGcSs1UnRsQ24zSUlQWkdrYnZOcEdWUkJW?=
 =?utf-8?B?dlhtYWlJTUgySytIeCtRV2U3eHk5aVdTV0M5K0hCendyR2JoVUlUMm1sVVlD?=
 =?utf-8?Q?KKxEmcTSzuEos4weM2mTP4chXIjLtU=3D?=
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(14060799003)(35042699022)(36860700013)(1800799024)(376014)(82310400026)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 22:57:03.6594 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: be7710c3-55fb-4101-c7db-08dd8cf15164
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: AMS1EPF0000004E.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR08MB9436
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

VEIgTWVtYmVycyBBdHRlbmRpbmcNCi0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KQWFyb24gQ29ub2xl
IA0KQnJ1Y2UgUmljaGFyZHNvbiANCkhvbm5hcHBhIE5hZ2FyYWhhbGxpIChjaGFpcikNCkplcmlu
IEphY29iDQpLZXZpbiBUcmF5bm9yDQpLb25zdGFudGluIEFuYW55ZXYNCk1heGltZSBDb3F1ZWxp
bg0KTW9ydGVuIEJyw7hydXANClN0ZXBoZW4gSGVtbWluZ2VyDQoNCk5PVEU6IFRoZSB0ZWNobmlj
YWwgYm9hcmQgbWVldGluZ3MgYXJlIG9uIGV2ZXJ5IHNlY29uZCBXZWRuZXNkYXkgYXQgM3BtIFVU
Qy4NCk1lZXRpbmdzIGFyZSBwdWJsaWMsIGFuZCBEUERLIGNvbW11bml0eSBtZW1iZXJzIGFyZSB3
ZWxjb21lIHRvIGF0dGVuZC4NCkFnZW5kYSBhbmQgbWludXRlcyBjYW4gYmUgZm91bmQgYXQgaHR0
cDovL2NvcmUuZHBkay5vcmcvdGVjaGJvYXJkL21pbnV0ZXMNCg0KTmV4dCBtZWV0aW5nIHdpbGwg
YmUgb24gV2VkbmVzZGF5IDIwMjUtTWF5LTE0IEAgM3BtIFVUQywgYW5kIHdpbGwgYmUNCmNoYWly
ZWQgYnkgSmVyaW4gSmFjb2IuDQoNCkFnZW5kYSBJdGVtcw0KPT09PT09PT09PT09PQ0KMSkgQWdl
bmRhIGZvciB0aGUgVGVjaGJvYXJkIEYyRiBtZWV0aW5nIGF0IFByYWd1ZQ0KICAgIC0gRFBESyBB
UElzIGZvciBVRUM/DQogICAgLSBUb3BpY3MgZnJvbSBsYXN0IG1lZXRpbmcgLSBSZXZpZXcgZXZl
bnRzLCBtYXJrZXRpbmcsIHdlYnBhZ2UgY29udGVudCwgZG9jcywgdGVzdGluZywgYnVnIHRyYWNr
aW5nLCBwYXRjaGVzLCByZWxlYXNlDQogICAgLSBEaXNjdXNzaW9uIG9uIFJ1c3Qg4oCTIE1heSBi
ZSBhIEJvRiByZXF1aXJlZD8NCiAgICAtIE1vcnRlbiBzdWdnZXN0ZWQgdGhhdCB3ZSBzaG91bGQg
ZG9jdW1lbnQgdGhlIGZlYXR1cmVzIHdlIGxpa2UgdGhlIGNvbW11bml0eSB0byBpbXBsZW1lbnQN
CiAgICAtIERpc2N1c3MgY29kaW5nIGNoYWxsZW5nZXMgYW5kIG1ha2UgZGVjaXNpb25zLiBTZWUg
dGhlIGNvZGUgY2hhbGxlbmdlIGl0ZW0gYmVsb3cuDQoNCiAyKSBBZ2VuZGEgZm9yIGpvaW50IFRl
Y2hib2FyZCBhbmQgR292ZXJuaW5nIGJvYXJkIG1lZXRpbmcNCiAgICAtIEFyZSB0aGVyZSBpbml0
aWF0aXZlcyB3aXRoaW4gZGlmZmVyZW50IGNvbXBhbmllcyBvbiBzdXBwb3J0aW5nIERQREsrUnVz
dA0KICAgIC0gUmV2aWV3IHRoZSBzdGF0dXMgb2YgdmFyaW91cyB3b3JrIGhhcHBlbmluZyBhdCBV
TkggbGFiLiBOYXRoYW4gU291dGhlcm4gd2lsbCBjaGVjayBpZiBQYXRyaWNrIGlzIGFsbG93ZWQg
dG8gYXR0ZW5kIHRoZSBtZWV0aW5nIHRvIHJlcHJlc2VudCBVTkggbGFiIHdvcmsuDQoNCiAzKSBC
ZW4gbmVlZHMgcmV2aWV3IGZyb20gdGhlIFRlY2hib2FyZCBvZiB0aGUgdW5pdmVyc2l0eSBvdXRy
ZWFjaCBzbGlkZXMgWzFdDQoNCiA0KSBCZW4gbmVlZHMgaW5wdXQgb24gRFBESyBhZHZvY2FjeSBz
bGlkZXMgWzJdLiBTbGlkZSAxMCBuZWVkcyBpbnB1dCBvbiBzdGF0aXN0dWNzIChsaWtlIHdoYXQg
aGFzIGJlZW4gZG9uZSBpbiB0aGUgcGFzdCB3aXRoIG51bWJlciBvZiBwYXRjaGVzLCBjb21taXRz
LCBjb21wYW5pZXMgZXRjKSwgQ29kZSBpbXByb3ZlbWVudHMgKGNvdWxkIGNvbWUgZnJvbSByb2Fk
bWFwKS4gVGhlIHNsaWRlcyBuZWVkIHRvIGJlIG9yaWVudGVkIHRvd2FyZHMgZGV2ZWxvcGVycyBy
YXRoZXIgdGhhbiBjb21wYW5pZXMNCg0KIDUpIENvZGUgY2hhbGxlbmdlIOKAkyBUaGUgZm9sbG93
aW5nIHRvcGljcyBuZWVkIHRvIGJlIGRpc2N1c3NlZCBhbmQgY29uY2x1ZGVkIGF0IHRoZSBUZWNo
IGJvYXJkIEYyRiBtZWV0aW5nIGluIFByYWd1ZQ0KICAgIGEpIERpc2N1c3Npb24gb24gdGhlIGR1
cmF0aW9uIG9mIHRoZSBjb2RlIGNoYWxsZW5nZS4NCiAgICAgICAgQ29kZSBjaGFsbGVuZ2VzIGJl
eW9uZCBhIGRheSBhcmUgaGFyZCB0byBtYW5hZ2UuIFRoZSByZWNvbW1lbmRhdGlvbiBpcyB0byBk
byBpdCBmb3IgYSBkYXksIGJ1dCBub3QgbW9yZSB0aGFuIDIgZGF5cy4NCiAgICAgICAgVGhlIGNv
ZGluZyBjaGFsbGVuZ2VzIHRoYXQgbmVlZCBtb3JlIHRoYW4gYSBkYXkgY2FuIGJlIG1vdmVkIHRv
IHVuaXZlcnNpdHkgcHJvamVjdCBsaXN0cy4NCiAgICBiKSBMb2NhdGlvbiBmb3IgdGhlIGNvZGlu
ZyBjaGFsbGVuZ2UNCiAgICAgICAgSXQgaXMgYmV0dGVyIHRvIGhhdmUgdGhlIGNvZGluZyBjaGFs
bGVuZ2UgY28tbG9jYXRlZCB3aXRoIHRoZSBzdW1taXQgdG8gYXR0cmFjdCBtb3JlIHBlb3BsZSB0
byB0aGUgc3VtbWl0Lg0KICAgICAgICBIb3dldmVyLCBmb3IgdGhlIFNhbnRhIENsYXJhIHN1bW1p
dCwgd2UgbWlnaHQgaGF2ZSB0byBkbyBpdCBpbiBhIGhvdGVsIGJlZm9yZSB0aGUgc3VtbWl0Lg0K
ICAgIGMpIENvZGluZyBjaGFsbGVuZ2UgY291bGQgYmUgYXR0YWNoZWQgdG8gdW5pdmVyc2l0eSBl
ZmZvcnQgYXMgdGUgZ29hbCBpcyB0byBhdHRyYWN0IG1vcmUgZGV2ZWxvcGVycyB0byB0aGUgcHJv
amVjdC4gIDYpIENocmlzdGlhbiBmcm9tIE5hcGF0ZWNoIGRpc2N1c3NlZCB0aGUgY2hhbmdlcyBi
ZWluZyByZXF1ZXN0ZWQgdG8gdGhlIFBNRC4gVGhlIGFza3MgYXJlIHNpZ25pZmljYW50IGNoYW5n
ZXMgdG8gdGhlIGNvZGUuDQogICAgICAgIEhlIHJlcXVlc3RlZCB0aGF0IHdlIHNob3VsZCBkb2N1
bWVudCB0aGUgcmVxdWlyZW1lbnQgb24gUE1EIGFjY2VwdGFuY2UuIE1lcmdpbmcgaW4gMjUuMTEg
aXMgZmluZS4NCg0KWzFdIGh0dHBzOi8vZG9jcy5nb29nbGUuY29tL3ByZXNlbnRhdGlvbi9kLzFL
WmdETXdBLVhSa0JKQm05azA0S1htU0lsTDJUSlJ6aXR1VlBsWE05WWZVL2VkaXQ/c2xpZGU9aWQu
ZzM1MjM2Yzg5MzgzXzBfMzQ3I3NsaWRlPWlkLmczNTIzNmM4OTM4M18wXzM0Nw0KWzJdIGh0dHBz
Oi8vZG9jcy5nb29nbGUuY29tL3ByZXNlbnRhdGlvbi9kLzFmaDYtOVBZMlBiQm51UFlGc2VYZzh0
NDlzaXRfcUdjTy9lZGl0P3NsaWRlPWlkLmczNDQzOGE2YzEwMl8wXzE3NyNzbGlkZT1pZC5nMzQ0
MzhhNmMxMDJfMF8xNzc=
