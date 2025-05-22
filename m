Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F37BCC54ED1
	for <dpdk-dev@archiver.kernel.org>; Thu, 22 May 2025 22:04:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B6B7D4025E;
	Fri, 23 May 2025 00:03:59 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on2067.outbound.protection.outlook.com [40.107.21.67])
 by mails.dpdk.org (Postfix) with ESMTP id 1A6634021E
 for <dev@dpdk.org>; Fri, 23 May 2025 00:03:58 +0200 (CEST)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=JDFwXDOUAQ1VcgCtomgyCQUfWiYjh5d7AknEkTKX1QtgMRiIrtwvdMwIBEWvQPJ9rf2yvffNeKmQbfxZtI/TXqr/LZx11pDK5h2fpyS5t4k0LMFRiTJqNR2xfaoKXKc9+pD1xWCQI3bib08Q7SQ89bw/gpZk9TAwScSlGcd6BMK+L8r/A0Xf52/0zb71oegW6klNX1l0iYON98+BzMsHfcFapUhWQ8GQqL2P4mG5KJ1vg5ss6gXex1nKE+X2KtB7S8QSvak5R+51Y+/SBZWTdz0frp/N/XtCdo3xYZAa9xuKtB9XhKy0OgOzX2zd18LJDCtfXrRXl0V2i98xZjmj6A==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9NMDjWgb7ppYCCmH7flwbryv6f5RNUpjOOH/fTUTot0=;
 b=js3e/EnqDmKmiZM9JYT8/sExy6olSBP+qibWvqEOQqSlA/TdgntDAeoqInMfybK9f32UbeL9J4SVXVK0MbyXvypN1xYjQa9WUJYxzP99VZXxjYWIFpwjAu3kQVd4wXvS491NaX0K00zzqXJ78BZt5nV5x+WQTcMbIx+twnWp53L0aNaw5fguxoA9Gc4Z3a8P8X1qc+iMCljAxqV0uuYZZXI8QN5bvlqzq3lIhCJe5+zWYfpEzF7tAN6FqX6G4c4l1lZZOIcD9W0BytkNeyB3eF6i6GEzk4245uqgiUzD8uD1uYzZaGBO8u1AHrjiymBHDibJivFE7nLc+ZmL223pzg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=huawei.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9NMDjWgb7ppYCCmH7flwbryv6f5RNUpjOOH/fTUTot0=;
 b=hTSHD6eSNO/lWeetHoK+tD0Hzc0qFD7htMoLgqHArStD5jxNJmOo7I8g63u0812KD9tF7f6xI4GpuxLQEh0Lyq/3RsTzGMgG7BrAy10++QZtwykIhtD0w6EfsGLwBtBbgpvbQrRn4EOOk4/ml0eerrGoFx2FqKHKbSMx8lZb564=
Received: from CWLP123CA0069.GBRP123.PROD.OUTLOOK.COM (2603:10a6:401:59::33)
 by AM7PR08MB5302.eurprd08.prod.outlook.com (2603:10a6:20b:103::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.21; Thu, 22 May
 2025 22:03:54 +0000
Received: from AM4PEPF00027A63.eurprd04.prod.outlook.com
 (2603:10a6:401:59:cafe::3) by CWLP123CA0069.outlook.office365.com
 (2603:10a6:401:59::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.29 via Frontend Transport; Thu,
 22 May 2025 22:03:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM4PEPF00027A63.mail.protection.outlook.com (10.167.16.73) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.18
 via Frontend Transport; Thu, 22 May 2025 22:03:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tsxKucFfJVoWRlg5hkGe/knNF9ShpAJuwGKJurxu99Q4LVHlDPCZF5O0vCNy0/rYP2Jgvr22k7HPdjqrItb7A1eLaQZaFn6UeKcRUkKJVQ0p0vlCYIoaZUBuYo5AyrpoCHzMuv1aueaKyWIXS0ZWvHlRb2h7EUuHc4quXDeCZiMc9o4FgB6xbhSecCG4Nh4fgUFkvBnWzDsSrXCn30fNLoEG20oGIPRsIp5P6k1R7PhhbF2/MqCIzbwEuaTXWV/XrZdX8c8LGCuGa74OWBRQgUzlZOcnz7FIALAq/GibLW/L1bDLH0lHVyt1Q0sWWiNGaE/N/4LUZ+3sQbkzKcblAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9NMDjWgb7ppYCCmH7flwbryv6f5RNUpjOOH/fTUTot0=;
 b=JNG69foE7zWb+hqAz1swiPa75EgIbqkDnBpFPdlAwS8zMkOUJ61Lve6dhfPF2GrA/PMDCsqfqfHn854OOMZEZ6pssCKms+CVGCL4wS/fagQxC8suyzGnbpqBrJDY8AX2hgsORpT44fHPmE9tsh71Gd76Tf7fGStItqsOWEFoHypx9sGpas9GaQ6Gt+eOLXTJXAgvwLEBuwBSMIR3r0QgtcV0ltK4pcFMa2BNOIPNsf1LAdE2dFXudMJIt7i07A68QDNXBqTextBQzGHorTFA+lo2H4oHqYUJpg6pzerfMEEeGKz/Lr2pZm0rQn9zN9N18uM+Phykeo5vJGtobow2eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9NMDjWgb7ppYCCmH7flwbryv6f5RNUpjOOH/fTUTot0=;
 b=hTSHD6eSNO/lWeetHoK+tD0Hzc0qFD7htMoLgqHArStD5jxNJmOo7I8g63u0812KD9tF7f6xI4GpuxLQEh0Lyq/3RsTzGMgG7BrAy10++QZtwykIhtD0w6EfsGLwBtBbgpvbQrRn4EOOk4/ml0eerrGoFx2FqKHKbSMx8lZb564=
Received: from PAWPR08MB8909.eurprd08.prod.outlook.com (2603:10a6:102:33a::19)
 by AS8PR08MB6725.eurprd08.prod.outlook.com (2603:10a6:20b:394::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.31; Thu, 22 May
 2025 22:03:20 +0000
Received: from PAWPR08MB8909.eurprd08.prod.outlook.com
 ([fe80::613d:8d51:60e5:d294]) by PAWPR08MB8909.eurprd08.prod.outlook.com
 ([fe80::613d:8d51:60e5:d294%6]) with mapi id 15.20.8746.030; Thu, 22 May 2025
 22:03:20 +0000
From: Wathsala Wathawana Vithanage <wathsala.vithanage@arm.com>
To: Konstantin Ananyev <konstantin.ananyev@huawei.com>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: Honnappa Nagarahalli <Honnappa.Nagarahalli@arm.com>, "jerinj@marvell.com"
 <jerinj@marvell.com>, "hemant.agrawal@nxp.com" <hemant.agrawal@nxp.com>,
 "drc@linux.ibm.com" <drc@linux.ibm.com>, nd <nd@arm.com>
Subject: RE: [PATCH v1 3/4] ring: fix potential sync issue between head and
 tail values
Thread-Topic: [PATCH v1 3/4] ring: fix potential sync issue between head and
 tail values
Thread-Index: AQHbykGnqwbK+3U2jEmKxyxFWCOr77Pe8sVw
Date: Thu, 22 May 2025 22:03:20 +0000
Message-ID: <PAWPR08MB8909895DF398ACB52C8D66719F99A@PAWPR08MB8909.eurprd08.prod.outlook.com>
References: <20250521111432.207936-1-konstantin.ananyev@huawei.com>
 <20250521111432.207936-4-konstantin.ananyev@huawei.com>
In-Reply-To: <20250521111432.207936-4-konstantin.ananyev@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic: PAWPR08MB8909:EE_|AS8PR08MB6725:EE_|AM4PEPF00027A63:EE_|AM7PR08MB5302:EE_
X-MS-Office365-Filtering-Correlation-Id: 480c5429-f83f-4044-008c-08dd997c8aa0
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700018; 
X-Microsoft-Antispam-Message-Info-Original: =?utf-8?B?Vm9UQy9kR3d6MXhUcGVmOXlSRE4rVTA3YTFHNDNSK0NvRlZHdjZrSi9aL0Jv?=
 =?utf-8?B?QWlZYUpNMFhodHBweUYzTGwwdnVYaUdybkR1MWZsZUNGd1ViUWcxTFUzcjlw?=
 =?utf-8?B?bGlSM0xFMm5Rc1drdmhlVnpxdHBiZEhkNUFrY09jNDN4b2IwTHFVaXdpS2RQ?=
 =?utf-8?B?eTExT0VIY0NhUDdGZDRjeTZWR29YY3hJOFBnbDNHSDM2b0V2SWVFdElKSk1u?=
 =?utf-8?B?T2VYUGxpVktnbDJ0cmlVd2lrV3p6bWtvOGloN2g3NWMyZWJzQ0tKN3ZSKzUz?=
 =?utf-8?B?WmxsN3JMRWZ4Z25nMXgzRVU3YjZ5T3RmRE1TSldzczBhUi9uMkpVZXpMVW5N?=
 =?utf-8?B?L212MDdVUGl4SS9WQjdDU0pnM0dCKzcxTGFtZ0IyYzVCWXV3a1cvSGVTRmk2?=
 =?utf-8?B?NTJkdzZra0FEenVnQmc0NytNREQ1L2d4VEpVUnd5VTM2WmlFelJOUVh6clBu?=
 =?utf-8?B?ZzUvR1N6T0xOZFBsRzkyNFRQaFgySkFFRFlqb0FRMDhncmo0ODUyT0svZGht?=
 =?utf-8?B?VFA4QlZIYzUxUm1jM1NMVkNIaWhWZUdoVUxaTmRBSUttKzRTeUVZWGxWSVhG?=
 =?utf-8?B?SVE3bmtLYUFhN1hUZlNlUE5EbjBxUTQ2U2RUUG9tZ053a1RZaWg0MXB5WHI4?=
 =?utf-8?B?b3djVUw3T1FFcjlUMlV5MzJ1RmlhTEF6bXNWdU1WbDZzbnlndUJUdldBeG10?=
 =?utf-8?B?RTRZVVlEcldMVUMwSVRmRlg5S1o3TUhraDEvQVM5Z3NGRnY2Q0FucTR5REpx?=
 =?utf-8?B?MXJOKzBtOU5qa1Q2anNaNHZXUkNjbEJhZVVHR0FsZk10YTAvWDJSZi8vMFJq?=
 =?utf-8?B?MktzNit0QUF1Uno0SzBkd2xSdVcwNWJNN01nQnBxbFp5QkZFaDJIQy9HUmY2?=
 =?utf-8?B?QitwVzBKN0twdFppVTdVVkJhbVZwMXhqanVYOTJsbU9LTGVZVmlUZVArSjY5?=
 =?utf-8?B?S2Zod0VjVXVhQnREMUtyb0Z3RjQ2TnZJSlhKMzIyc2xFaEU1YmxCYWdtNXU4?=
 =?utf-8?B?OXpZVkRUc1NlMXpCSXNLOVV5Rk05ekI4bWhGUUZySmFTTktqMzVHbUIwL1dR?=
 =?utf-8?B?RlFZQUVIcWFRVzVQaUhYTDVaanJXV09zUnIrdWF5dDhJZmlZSUFuSXRScGxa?=
 =?utf-8?B?S0Q3WXR0dGpoTHdGYWhLM1NkTnRsYnNYN2YzbGtobGRIcGxpdWJmQlBCQXVL?=
 =?utf-8?B?M2o0L3FmaGNEZVdySnBXRmZGaitVL2E0MFA5amlMZ09LUFhER0FoV1ZkZm5U?=
 =?utf-8?B?a0JHOUt5eHNrYllQZ1NrRnI4WENueEdOdTcwbENGRnhObEJadjN1Ull5V2Fv?=
 =?utf-8?B?UFBteER4Nm1pYW0zL1U4ZFBjdWQyQzRES0JaTk5USG5YTnN3M1Uvak41UGVM?=
 =?utf-8?B?TVdmNnF0RDFpQk1DK2ptOFE5Qm9xb3ZtYzh3ZzNiK20wOEx5WHUwM0tkdnNo?=
 =?utf-8?B?cG9rMlVpaytCWXFaWDkzU3dqeWllNDhtb1pJMjRMbUpnNldsaUdkWk9SdklE?=
 =?utf-8?B?b2NsM3M0UXhjb3YrVFdsSmVHMWRNcmhvd0xTa051TDRIUmQ4a0hFeUhYWEMz?=
 =?utf-8?B?Z3NlS1Z6RlhKT0RZOHhkUEZPSVBRdURRRWpaUHllQXZvVlk5d0VmUHE2d0ZN?=
 =?utf-8?B?OWk5RmhkYnhRTzhjaHhkS2ZPUlNVb1djZlphVGhRQVhBT3BNWEVzT2x4ZkdM?=
 =?utf-8?B?R04yUzM4QUtTcDFWZE5zVTh0SXdoQXo0Y3MzSlNLZDZUUzNXbi9zMm5veFBz?=
 =?utf-8?B?R3pkV2ZqbnljZmRvanNmY0RMaGdiQjUwY0RpUzNCRXRFcWF5cUp6VXRqTklX?=
 =?utf-8?B?V2JLUUtCZkdIOHNIQlFic2w0ZnBCRnZRaDFWZTBRV096TFJ2VUd3RUFOMzJL?=
 =?utf-8?B?RGx1eG84Zk5lTWNyT1RoQ3lQV2w2RWJnT3NnUXRVSGN3RVYzQXhLd0FpTys1?=
 =?utf-8?B?c29PdldMaGswMWdsN3BKYmJoQVpkN3p0bXoxOUJ5Z3FjMjJKZVNTeEltME9u?=
 =?utf-8?B?elB1V3VPdFd3PT0=?=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:PAWPR08MB8909.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE; SFS:(13230040)(366016)(1800799024)(376014)(38070700018);
 DIR:OUT; SFP:1101; 
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6725
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM4PEPF00027A63.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 8bc55afb-dfd7-49d2-ec78-08dd997c76dd
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|35042699022|82310400026|14060799003|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ODE1TG10TjNVN21ZZm5qODFXRnJwZWlzN3VXMWxkS2dTV01FY0Q4WTBqQW8x?=
 =?utf-8?B?SjVjOUhoQVp2S2dVQ0tHVmgrTytNVytFUGp5amJOcDlZT2kyWmNETnNNc3hn?=
 =?utf-8?B?UXpUZThuL2lFVUNhUjRQRzZxNUZJWUptVUQwLzZNVFNOZFMrbi9WVCt0REs4?=
 =?utf-8?B?RFk0MWUyUnVoZ1dRN1luYzJuSHRwcmpkTnJKWnloOW1MQThxNVVlVWwxTFVi?=
 =?utf-8?B?ZFpEMHJ5UmdVYnlHOVlJUDhHdDZKQ2V5NW1xeFR0cFpzR21TaVVKOE9aZlBX?=
 =?utf-8?B?TE50SlNwWDVrdHhySjVwWFhvZHJzVkRnYmwxejBsUDZsMTBDbDJUNmJ4Sitq?=
 =?utf-8?B?czFieUR5SjNvSkJmV3c2TlJMUkpCcUxieHE0UnJRNW1YWkV2Z0psTjVDTmxi?=
 =?utf-8?B?eTE5Q1VqUU0wQVJRNitBN3g1NXlFUmdlL0xkVGo3QnlNYk01ZTduTkZTQWwv?=
 =?utf-8?B?ekFJTmRoOFBlK2w4d3lGKzVHbUhYeWNXWFRFY0R3cnlQWWU4UHJVQnlTTjl1?=
 =?utf-8?B?aW1MOU04bkRrWUNHdTFWTmxKTDd0dk9ZL0Ryc1JHRWI3ZHZDM3ZJbVV3ZXR4?=
 =?utf-8?B?RjVkT01mbUYrY3VxTjl0UVM3bUkzUVliMFB4cTV5emtOdE5temJlNlc4aFFR?=
 =?utf-8?B?dXRIYktyaXZQT1Znbnk2MUd4akRlK3ZvTkxzZEFCak9wQTdIQ2lNdSttZXBR?=
 =?utf-8?B?TkQ0ZGZmYjkrNC91SjVVTXgySkkrY2hUcUxJeFBTZ0o2R0NNNVJhcnNWbFBZ?=
 =?utf-8?B?ZUNIYWViaDdqclRTYlpQZVpmc2dxUVZHdWM2OW1NSlJBK3FzSi9xN3dGMnIr?=
 =?utf-8?B?QVlUbXRsTGRaMjlQbGNIM0JUYWxpL3h3bnhESEx6SzNqSHN0ZXV2U0tuMHlJ?=
 =?utf-8?B?R21OeUsrKzNPL0k4V0pXeTgzbi9hTHRlandLOW1NT2tnMUpoQXRWODcwRUt6?=
 =?utf-8?B?NVpEY2ZXKzgrK0R3S0NyVlJhV0tTUVUxN3JVU3FXOWdyVjFZM2MyVlQzVHVV?=
 =?utf-8?B?MHVDUWx5WVg0UkpVaCtFekgycEJ4Q0ZoUU9JU0I5dE1CTC9RL0ZBOXZNVzI5?=
 =?utf-8?B?SG1COE9oT2NlYyszQ3NFTHhWMG1EaTRHZjdESkxDRGNwVGZUeU54MWQ1T0Vm?=
 =?utf-8?B?ZkFTdnB1Mlk2K0o0bnhtaW41dHlCKzRqaU1ERFE2OTFNMjE3WkJ2Q2I4U1No?=
 =?utf-8?B?UFBVeUUraXhVenNoak5GbFl3VGx5Z2E5ZGxYR05HOXFXWlk2dTJDN2VsT3RQ?=
 =?utf-8?B?VmpncitSbnRCMHJYbGpQWm5YbU5XTHZGTm9qSE1UamFEUHEzMzVqaFFxY21R?=
 =?utf-8?B?L2ZiZEQxdVFUclZQd0ZtVVNsNExEYnpXVVJRejZqZ0Y1WUZ3RWJtVU9IYndK?=
 =?utf-8?B?N3k4T0prZWdTOGlnTC9TdjhveDVGbFhWUWNBYjJBZ011Nkl6OUVmYldQS1NK?=
 =?utf-8?B?aVB6Q0VFTWc2alFXQm1nejhOUmxGcjlvTVZSOCs0ZDdiUzlNd1BQc3dzNkc2?=
 =?utf-8?B?M1hsbDJqbDRGeHlOdDIxbzNrcUd3a1BVZkxDKzV6WVVncVF5SFFrYVZTbTY3?=
 =?utf-8?B?L1dyM2J5Mnl2UVFpQXA3YkFORG1CWjEwVzVkTUlnb0xLTGljTnNPUGIwWnc3?=
 =?utf-8?B?UE4yWHZ1Yzh3RXFPRUZZZEIvaHprN2RIWVZWZTQwcXFocnJRQVVETXRtZWJ0?=
 =?utf-8?B?QktwYi9iWXpGcTdrNW5TOGEvOVp6RGNQN3hNWjlBeHZXYXViWkVVVWQ1KzZJ?=
 =?utf-8?B?eVlDcUNNaUhYSnlZRWtkcTNuc0tKOXRNNWV1UDFZdDkyYlNOOEVIU3Zla0hr?=
 =?utf-8?B?QUxqQmdJNWlzQVpuM3lTWVpJT3lPaks1MHdzZTBjbm9UN2cxby9YdTJiZ0VR?=
 =?utf-8?B?S1hRbGNSelE4bU1seGVsaTh5eFhhZXRQY2tta01kM0ExSHI4SVBIM0NXRWpL?=
 =?utf-8?B?NGREZk9aeUdScjFDUktmUHdCMjhwSjkwZEdMdXhBSHVPTDBsUnR0bGdwL0w4?=
 =?utf-8?B?THcvY3NoQjNDZjl3YVB0UWl1SHkwVDFUaW14RHlEM0FyRzFlRktnbmpoYTlY?=
 =?utf-8?Q?rturAu?=
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(35042699022)(82310400026)(14060799003)(376014);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2025 22:03:53.6222 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 480c5429-f83f-4044-008c-08dd997c8aa0
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: AM4PEPF00027A63.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5302
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

SGkgS29uc3RhbmluLA0KDQpJbiBydGVfcmluZyB0aGUgc3RvcmUtcmVsZWFzZSBvbiB0YWlsIHVw
ZGF0ZSBndWFyYW50ZWVzIHRoYXQgQ0FTDQp3b24ndCBnZXQgcmVvcmRlcmVkIHdpdGggdGhlIHN0
b3JlLXJlbGVhc2VkIG9mIHRoZSB0YWlsIHVwZGF0ZS4NCg0KU28sIHRoZSBzZXF1ZW5jZSBvZiBl
dmVudHMgd291bGQgbG9vayBsaWtlIHRoaXMgKGNvbWJpbmVkIHZpZXcNCm9mIGhlYWQgYW5kIHRh
aWwgdXBkYXRlKQ0KDQpSZWxlYXhlZC1sb2FkKG5ld19oZWFkLCAgTikgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAtLS0tLS0tLS0tLS0tLS0tPiAoQSkNClJlbGF4ZWQtQ0FTKGQtPmhlYWQs
IG5ld19oZWFkLCBvbGRfaGVhZCkgICAtLS0tLS0tLS0tLS0tLS0tPiAoQikNClN0b3JlLXJlbGVh
c2Utc3RvcmUoZC0+dGFpbCwgbmV3X2hlYWQpICAgICAgICAgICAgIC0tLS0tLS0tLS0tLS0tLS0+
IChDKSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgDQoNCklm
IHdlIGxvb2sgYXQgYWRkcmVzcyBkZXBlbmRlbmNpZXMsIHRoZW4uLi4NCg0KKEIpIGRlcGVuZHMg
b24gKEEpIGR1ZSB0byBuZXdfaGVhZCBhZGRyZXNzIGRlcGVuZGVuY3kuDQooQykgZGVwZW5kcyBv
biAoQSkgZHVlIHRvIG5ld19oZWFkIGFkZHJlc3MgZGVwZW5kZW5jeS4NCg0KU28sIGRlcGVuZGVu
Y3kgZ3JhcGggbG9va3MgbGlrZSB0aGlzDQogICAgICAgKEEpDQogICAgLyAgICAgICBcDQogICB2
ICAgICAgICB2DQogKEIpICAgICAoQykNCg0KVGhlcmUgaXMgbm8gaW1wbGljaXQgZGVwZW5kZW5j
ZSBiZXR3ZWVuIChCKSBhbmQgKEMpLCBJIHRoaW5rIA0KdGhpcyBpcyB0aGUgaXNzdWUgeW91IGFy
ZSBicmluaW5nIHVwLiANCkV2ZW4gdGhvdWdoIHRoZXJlIGlzIG5vIGRlcGVuZGVuY2UgYmV0d2Vl
biB0aGUgdHdvLCANCnRoZSBzdG9yZS1yZWxlYXNlIG9mIChDKSBlbnN1cmVzIHRoYXQgKEIpIHdv
bid0IGRyb3AgYmVsb3cgaXQuDQpUaGVyZWZvcmUsIHRoZSBhYm92ZSBncmFwaCBjYW4gYmUgdHVy
bmVkIGludG8gYW4gb3JkZXJlZA0Kc2VxdWVuY2UgYXMgc2hvd24gYmVsb3cuLg0KDQooQSkgLT4g
KEIpIC0+IChDKQ0KDQpJIGhhdmVuJ3QgbG9va2VkIGF0IHRoZSBzby1yaW5nIHlldC4gQ291bGQg
aXQgYmUgcG9zc2libGUgdGhhdCB0aGUNCmlzc3VlIGlzIGR1ZSB0byBzb21ldGhpbmcgZWxzZSBp
bnRyb2R1Y2VkIGluIHRoYXQgY29kZT8NCg0KVGhhbmtzLA0KDQotLXdhdGhzYWxhDQoNCj4gVGhp
cyBwYXRjaCBhaW1zIHNldmVyYWwgcHVycG9zZXM6DQo+IC0gcHJvdmlkZSBhbiBhbHRlcm5hdGl2
ZSAoYW5kIEkgdGhpbmsgYSBiZXR0ZXIpIHdheSB0byBmaXggdGhlDQo+ICAgaXNzdWUgZGlzY3Vz
c2VkIGluIHByZXZpb3VzIHBhdGNoOg0KPiAgICJyaW5nL3NvcmluZzogZml4IHN5bmNocm9uaXph
dGlvbiBpc3N1ZSBiZXR3ZWVuIGhlYWQgYW5kIHRhaWwgdmFsdWVzIg0KPiAtIG1ha2Ugc3VyZSB0
aGF0IHN1Y2ggcHJvYmxlbSB3b3VsZG7igJl0IGhhcHBlbiB3aXRoaW4gb3RoZXIgdXNhZ2VzIG9m
DQo+ICAgX19ydGVfcmluZ19oZWFkdGFpbF9tb3ZlX2hlYWQoKSDigJMgYm90aCBjdXJyZW50IHJ0
ZV9yaW5nDQo+ICAgaW1wbGVtZW50YXRpb24gYW5kIHBvc3NpYmxlIGZ1dHVyZSB1c2UtY2FzZXMu
DQo+IC0gc3RlcCB0b3dhcmRzIHVuaWZpY2F0aW9uIG9mIG1vdmVfaGVhZCgpIGltcGxlbWVudGF0
aW9ucyBhbmQNCj4gICByZW1vdmluZyBydGVfcmluZ19nZW5lcmljX3B2dC5oDQo+IEl0IHVzZXMg
QWNxdWlyZS1SZWxlYXNlIG1lbW9yeSBvcmRlcmluZyBmb3IgQ0FTIG9wZXJhdGlvbiBpbiBtb3Zl
X2hlYWQoKS4NCj4gVGhhdCBndWFyYW50ZWVzIHRoYXQgY29ycmVzcG9uZGluZyDigJh0YWls4oCZ
IHVwZGF0ZXMgd2lsbCBiZSB2aXNpYmxlIGJlZm9yZSBjdXJyZW50DQo+IOKAmGhlYWTigJkgaXMg
dXBkYXRlZC4NCj4gQXMgSSBzYWlkIGJlZm9yZTogSSB0aGluayB0aGF0IGluIHRoZW9yeSB0aGUg
cHJvYmxlbSBkZXNjcmliZWQgaW4gcHJldmlvdXMgcGF0Y2gNCj4gbWlnaHQgaGFwcGVuIHdpdGgg
b3VyIGNvbnZlbnRpb25hbCBydGVfcmluZyB0b28gKHdoZW4NCj4gUlRFX1VTRV9DMTFfTUVNX01P
REVMIGVuYWJsZWQpLg0KPiBCdXQsIHNvIGZhciBJIGRpZG7igJl0IG1hbmFnZSB0byByZXByb2R1
Y2UgaXQgaW4gcmVhbGl0eS4NCj4gRm9yIHRoYXQgcmVhc29uIGFuZCBhbHNvIGJlY2F1c2UgaXQg
dG91Y2hlcyBhIGNyaXRpY2FsIHJ0ZV9yaW5nIGNvZGUtcGF0aCwgSSBwdXQNCj4gdGhlc2UgY2hh
bmdlcyBpbnRvIGEgc2VwYXJhdGUgcGF0Y2guIEV4cGVjdCBhbGwgaW50ZXJlc3RlZCBzdGFrZWhv
bGRlcnMgdG8gY29tZS0NCj4gdXAgd2l0aCB0aGVpciBjb21tZW50cyBhbmQgb2JzZXJ2YXRpb25z
Lg0KPiBSZWdhcmRpbmcgcGVyZm9ybWFuY2UgaW1wYWN0IOKAkyBvbiBteSBib3hlcyBib3RoIHJp
bmdfcGVyZl9hdXRvdGVzdCBhbmQNCj4gcmluZ19zdHJlc3NfYXV0b3Rlc3Qg4oCTIHNob3cgYSBt
aXhlZCBzZXQgb2YgcmVzdWx0czogc29tZSBvZiB0aGVtIGJlY29tZSBmZXcNCj4gY3ljbGVzIGZh
c3RlciwgYW5vdGhlciBmZXcgY3ljbGVzIHNsb3dlci4NCj4gQnV0IHNvIGZhciwgSSBkaWRu4oCZ
dCBub3RpY2UgYW55IHJlYWwgZGVncmFkYXRpb25zIHdpdGggdGhhdCBwYXRjaC4NCj4gDQo+IEZp
eGVzOiBiNTQ1OGUyY2M0ODMgKCJyaW5nOiBpbnRyb2R1Y2Ugc3RhZ2VkIG9yZGVyZWQgcmluZyIp
DQo+IEZpeGVzOiAxY2MzNjNiOGNlMDYgKCJyaW5nOiBpbnRyb2R1Y2UgSFRTIHJpbmcgbW9kZSIp
DQo+IEZpeGVzOiBlNmJhNDczMWMwZjMgKCJyaW5nOiBpbnRyb2R1Y2UgUlRTIHJpbmcgbW9kZSIp
DQo+IEZpeGVzOiA0OTU5NGE2MzE0N2EgKCJyaW5nL2MxMTogcmVsYXggb3JkZXJpbmcgZm9yIGxv
YWQgYW5kIHN0b3JlIG9mIHRoZSBoZWFkIikNCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEtvbnN0YW50
aW4gQW5hbnlldiA8a29uc3RhbnRpbi5hbmFueWV2QGh1YXdlaS5jb20+DQo+IC0tLQ0KPiAgbGli
L3JpbmcvcnRlX3JpbmdfYzExX3B2dC5oICAgICAgfCAyNyArKysrKysrKysrKysrKysrKy0tLS0t
LS0tLS0NCj4gIGxpYi9yaW5nL3J0ZV9yaW5nX2h0c19lbGVtX3B2dC5oIHwgIDYgKysrKy0tICBs
aWIvcmluZy9ydGVfcmluZ19ydHNfZWxlbV9wdnQuaA0KPiB8ICA2ICsrKystLQ0KPiAgbGliL3Jp
bmcvc29yaW5nLmMgICAgICAgICAgICAgICAgfCAgNSAtLS0tLQ0KPiAgNCBmaWxlcyBjaGFuZ2Vk
LCAyNSBpbnNlcnRpb25zKCspLCAxOSBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9s
aWIvcmluZy9ydGVfcmluZ19jMTFfcHZ0LmggYi9saWIvcmluZy9ydGVfcmluZ19jMTFfcHZ0Lmgg
aW5kZXgNCj4gMDg0NWNkNmRjZi4uNmQxYzQ2ZGY5YSAxMDA2NDQNCj4gLS0tIGEvbGliL3Jpbmcv
cnRlX3JpbmdfYzExX3B2dC5oDQo+ICsrKyBiL2xpYi9yaW5nL3J0ZV9yaW5nX2MxMV9wdnQuaA0K
PiBAQCAtNzcsMjAgKzc3LDE5IEBAIF9fcnRlX3JpbmdfaGVhZHRhaWxfbW92ZV9oZWFkKHN0cnVj
dA0KPiBydGVfcmluZ19oZWFkdGFpbCAqZCwNCj4gIAlpbnQgc3VjY2VzczsNCj4gIAl1bnNpZ25l
ZCBpbnQgbWF4ID0gbjsNCj4gDQo+ICsJLyogRW5zdXJlIHRoZSBoZWFkIGlzIHJlYWQgYmVmb3Jl
IHRhaWwgKi8NCj4gIAkqb2xkX2hlYWQgPSBydGVfYXRvbWljX2xvYWRfZXhwbGljaXQoJmQtPmhl
YWQsDQo+IC0JCQlydGVfbWVtb3J5X29yZGVyX3JlbGF4ZWQpOw0KPiArCQkJcnRlX21lbW9yeV9v
cmRlcl9hY3F1aXJlKTsNCj4gIAlkbyB7DQo+ICAJCS8qIFJlc2V0IG4gdG8gdGhlIGluaXRpYWwg
YnVyc3QgY291bnQgKi8NCj4gIAkJbiA9IG1heDsNCj4gDQo+IC0JCS8qIEVuc3VyZSB0aGUgaGVh
ZCBpcyByZWFkIGJlZm9yZSB0YWlsICovDQo+IC0JCXJ0ZV9hdG9taWNfdGhyZWFkX2ZlbmNlKHJ0
ZV9tZW1vcnlfb3JkZXJfYWNxdWlyZSk7DQo+IC0NCj4gLQkJLyogbG9hZC1hY3F1aXJlIHN5bmNo
cm9uaXplIHdpdGggc3RvcmUtcmVsZWFzZSBvZiBodC0+dGFpbA0KPiAtCQkgKiBpbiB1cGRhdGVf
dGFpbC4NCj4gKwkJLyoNCj4gKwkJICogUmVhZCBzLT50YWlsIHZhbHVlLiBOb3RlIHRoYXQgaXQg
d2lsbCBiZSBsb2FkZWQgYWZ0ZXINCj4gKwkJICogZC0+aGVhZCBsb2FkLCBidXQgYmVmb3JlIENB
UyBvcGVyYXRpb24gZm9yIHRoZSBkLT5oZWFkLg0KPiAgCQkgKi8NCj4gIAkJc3RhaWwgPSBydGVf
YXRvbWljX2xvYWRfZXhwbGljaXQoJnMtPnRhaWwsDQo+IC0JCQkJCXJ0ZV9tZW1vcnlfb3JkZXJf
YWNxdWlyZSk7DQo+ICsJCQkJCXJ0ZV9tZW1vcnlfb3JkZXJfcmVsYXhlZCk7DQo+IA0KPiAgCQkv
KiBUaGUgc3VidHJhY3Rpb24gaXMgZG9uZSBiZXR3ZWVuIHR3byB1bnNpZ25lZCAzMmJpdHMgdmFs
dWUNCj4gIAkJICogKHRoZSByZXN1bHQgaXMgYWx3YXlzIG1vZHVsbyAzMiBiaXRzIGV2ZW4gaWYg
d2UgaGF2ZSBAQCAtDQo+IDExMiwxMSArMTExLDE5IEBAIF9fcnRlX3JpbmdfaGVhZHRhaWxfbW92
ZV9oZWFkKHN0cnVjdCBydGVfcmluZ19oZWFkdGFpbA0KPiAqZCwNCj4gIAkJCWQtPmhlYWQgPSAq
bmV3X2hlYWQ7DQo+ICAJCQlzdWNjZXNzID0gMTsNCj4gIAkJfSBlbHNlDQo+IC0JCQkvKiBvbiBm
YWlsdXJlLCAqb2xkX2hlYWQgaXMgdXBkYXRlZCAqLw0KPiArCQkJLyoNCj4gKwkJCSAqIG9uIGZh
aWx1cmUsICpvbGRfaGVhZCBpcyB1cGRhdGVkLg0KPiArCQkJICogdGhpcyBDQVMoQUNRX1JFTCwg
QUNRVUlSRSkgc2VydmVzIGFzIGEgaG9pc3QNCj4gKwkJCSAqIGJhcnJpZXIgdG8gcHJldmVudDoN
Cj4gKwkJCSAqICAtIE9PTyByZWFkcyBvZiBjb25zIHRhaWwgdmFsdWUNCj4gKwkJCSAqICAtIE9P
TyBjb3B5IG9mIGVsZW1zIGZyb20gdGhlIHJpbmcNCj4gKwkJCSAqICBBbHNvIFJFTEVBU0UgZ3Vh
cmFudGVlcyB0aGF0IGxhdGVzdCB0YWlsIHZhbHVlDQo+ICsJCQkgKiAgd2lsbCBiZWNvbWUgdmlz
aWJsZSBiZWZvcmUgdGhlIG5ldyBoZWFkIHZhbHVlLg0KPiArCQkJICovDQo+ICAJCQlzdWNjZXNz
ID0NCj4gcnRlX2F0b21pY19jb21wYXJlX2V4Y2hhbmdlX3N0cm9uZ19leHBsaWNpdCgNCj4gIAkJ
CQkJJmQtPmhlYWQsIG9sZF9oZWFkLCAqbmV3X2hlYWQsDQo+IC0JCQkJCXJ0ZV9tZW1vcnlfb3Jk
ZXJfcmVsYXhlZCwNCj4gLQkJCQkJcnRlX21lbW9yeV9vcmRlcl9yZWxheGVkKTsNCj4gKwkJCQkJ
cnRlX21lbW9yeV9vcmRlcl9hY3FfcmVsLA0KPiArCQkJCQlydGVfbWVtb3J5X29yZGVyX2FjcXVp
cmUpOw0KPiAgCX0gd2hpbGUgKHVubGlrZWx5KHN1Y2Nlc3MgPT0gMCkpOw0KPiAgCXJldHVybiBu
Ow0KPiAgfQ0KPiBkaWZmIC0tZ2l0IGEvbGliL3JpbmcvcnRlX3JpbmdfaHRzX2VsZW1fcHZ0Lmgg
Yi9saWIvcmluZy9ydGVfcmluZ19odHNfZWxlbV9wdnQuaA0KPiBpbmRleCBjNTllNWY2NDIwLi5j
YzU5MzQzM2I5IDEwMDY0NA0KPiAtLS0gYS9saWIvcmluZy9ydGVfcmluZ19odHNfZWxlbV9wdnQu
aA0KPiArKysgYi9saWIvcmluZy9ydGVfcmluZ19odHNfZWxlbV9wdnQuaA0KPiBAQCAtMTE2LDEz
ICsxMTYsMTUgQEAgX19ydGVfcmluZ19odHNfbW92ZV9oZWFkKHN0cnVjdA0KPiBydGVfcmluZ19o
dHNfaGVhZHRhaWwgKmQsDQo+ICAJCW5wLnBvcy5oZWFkID0gb3AucG9zLmhlYWQgKyBuOw0KPiAN
Cj4gIAkvKg0KPiAtCSAqIHRoaXMgQ0FTKEFDUVVJUkUsIEFDUVVJUkUpIHNlcnZlcyBhcyBhIGhv
aXN0IGJhcnJpZXIgdG8gcHJldmVudDoNCj4gKwkgKiB0aGlzIENBUyhBQ1FfUkVMLCBBQ1FVSVJF
KSBzZXJ2ZXMgYXMgYSBob2lzdCBiYXJyaWVyIHRvIHByZXZlbnQ6DQo+ICAJICogIC0gT09PIHJl
YWRzIG9mIGNvbnMgdGFpbCB2YWx1ZQ0KPiAgCSAqICAtIE9PTyBjb3B5IG9mIGVsZW1zIGZyb20g
dGhlIHJpbmcNCj4gKwkgKiAgIEFsc28gUkVMRUFTRSBndWFyYW50ZWVzIHRoYXQgbGF0ZXN0IHRh
aWwgdmFsdWUNCj4gKwkgKiAgIHdpbGwgYmVjb21lIHZpc2libGUgYmVmb3JlIHRoZSBuZXcgaGVh
ZCB2YWx1ZS4NCj4gIAkgKi8NCj4gIAl9IHdoaWxlIChydGVfYXRvbWljX2NvbXBhcmVfZXhjaGFu
Z2Vfc3Ryb25nX2V4cGxpY2l0KCZkLT5odC5yYXcsDQo+ICAJCQkodWludDY0X3QgKikodWludHB0
cl90KSZvcC5yYXcsIG5wLnJhdywNCj4gLQkJCXJ0ZV9tZW1vcnlfb3JkZXJfYWNxdWlyZSwNCj4g
KwkJCXJ0ZV9tZW1vcnlfb3JkZXJfYWNxX3JlbCwNCj4gIAkJCXJ0ZV9tZW1vcnlfb3JkZXJfYWNx
dWlyZSkgPT0gMCk7DQo+IA0KPiAgCSpvbGRfaGVhZCA9IG9wLnBvcy5oZWFkOw0KPiBkaWZmIC0t
Z2l0IGEvbGliL3JpbmcvcnRlX3JpbmdfcnRzX2VsZW1fcHZ0LmggYi9saWIvcmluZy9ydGVfcmlu
Z19ydHNfZWxlbV9wdnQuaA0KPiBpbmRleCA1MDlmYTY3NGZiLi44NjBiMTNjYzYxIDEwMDY0NA0K
PiAtLS0gYS9saWIvcmluZy9ydGVfcmluZ19ydHNfZWxlbV9wdnQuaA0KPiArKysgYi9saWIvcmlu
Zy9ydGVfcmluZ19ydHNfZWxlbV9wdnQuaA0KPiBAQCAtMTMxLDEzICsxMzEsMTUgQEAgX19ydGVf
cmluZ19ydHNfbW92ZV9oZWFkKHN0cnVjdA0KPiBydGVfcmluZ19ydHNfaGVhZHRhaWwgKmQsDQo+
ICAJCW5oLnZhbC5jbnQgPSBvaC52YWwuY250ICsgMTsNCj4gDQo+ICAJLyoNCj4gLQkgKiB0aGlz
IENBUyhBQ1FVSVJFLCBBQ1FVSVJFKSBzZXJ2ZXMgYXMgYSBob2lzdCBiYXJyaWVyIHRvIHByZXZl
bnQ6DQo+ICsJICogdGhpcyBDQVMoQUNRX1JFTCwgQUNRVUlSRSkgc2VydmVzIGFzIGEgaG9pc3Qg
YmFycmllciB0byBwcmV2ZW50Og0KPiAgCSAqICAtIE9PTyByZWFkcyBvZiBjb25zIHRhaWwgdmFs
dWUNCj4gIAkgKiAgLSBPT08gY29weSBvZiBlbGVtcyB0byB0aGUgcmluZw0KPiArCSAqICBBbHNv
IFJFTEVBU0UgZ3VhcmFudGVlcyB0aGF0IGxhdGVzdCB0YWlsIHZhbHVlDQo+ICsJICogIHdpbGwg
YmVjb21lIHZpc2libGUgYmVmb3JlIHRoZSBuZXcgaGVhZCB2YWx1ZS4NCj4gIAkgKi8NCj4gIAl9
IHdoaWxlIChydGVfYXRvbWljX2NvbXBhcmVfZXhjaGFuZ2Vfc3Ryb25nX2V4cGxpY2l0KCZkLT5o
ZWFkLnJhdywNCj4gIAkJCSh1aW50NjRfdCAqKSh1aW50cHRyX3QpJm9oLnJhdywgbmgucmF3LA0K
PiAtCQkJcnRlX21lbW9yeV9vcmRlcl9hY3F1aXJlLA0KPiArCQkJcnRlX21lbW9yeV9vcmRlcl9h
Y3FfcmVsLA0KPiAgCQkJcnRlX21lbW9yeV9vcmRlcl9hY3F1aXJlKSA9PSAwKTsNCj4gDQo+ICAJ
Km9sZF9oZWFkID0gb2gudmFsLnBvczsNCj4gZGlmZiAtLWdpdCBhL2xpYi9yaW5nL3NvcmluZy5j
IGIvbGliL3Jpbmcvc29yaW5nLmMgaW5kZXggN2JjYmYzNTUxNi4uMjFhMWEyN2UyNA0KPiAxMDA2
NDQNCj4gLS0tIGEvbGliL3Jpbmcvc29yaW5nLmMNCj4gKysrIGIvbGliL3Jpbmcvc29yaW5nLmMN
Cj4gQEAgLTEyMyw4ICsxMjMsNiBAQCBfX3J0ZV9zb3Jpbmdfc3RhZ2VfZmluYWxpemUoc3RydWN0
DQo+IHNvcmluZ19zdGFnZV9oZWFkdGFpbCAqc2h0LCB1aW50MzJfdCBzdGFnZSwNCj4gIAlydGVf
YXRvbWljX3N0b3JlX2V4cGxpY2l0KCZzaHQtPnRhaWwucmF3LCBvdC5yYXcsDQo+ICAJCQlydGVf
bWVtb3J5X29yZGVyX3JlbGVhc2UpOw0KPiANCj4gLQkvKiBtYWtlIHN1cmUgdGhhdCBuZXcgdGFp
bCB2YWx1ZSBpcyB2aXNpYmxlICovDQo+IC0JcnRlX2F0b21pY190aHJlYWRfZmVuY2UocnRlX21l
bW9yeV9vcmRlcl9yZWxlYXNlKTsNCj4gIAlyZXR1cm4gaTsNCj4gIH0NCj4gDQo+IEBAIC0yMTks
OSArMjE3LDYgQEAgX19ydGVfc29yaW5nX3VwZGF0ZV90YWlsKHN0cnVjdCBfX3J0ZV9yaW5nX2hl
YWR0YWlsDQo+ICpyaHQsDQo+ICAJCS8qIHVuc3VwcG9ydGVkIG1vZGUsIHNob3VsZG4ndCBiZSBo
ZXJlICovDQo+ICAJCVJURV9BU1NFUlQoMCk7DQo+ICAJfQ0KPiAtDQo+IC0JLyogbWFrZSBzdXJl
IHRoYXQgbmV3IHRhaWwgdmFsdWUgaXMgdmlzaWJsZSAqLw0KPiAtCXJ0ZV9hdG9taWNfdGhyZWFk
X2ZlbmNlKHJ0ZV9tZW1vcnlfb3JkZXJfcmVsZWFzZSk7DQo+ICB9DQo+IA0KPiAgc3RhdGljIF9f
cnRlX2Fsd2F5c19pbmxpbmUgdWludDMyX3QNCj4gLS0NCj4gMi40My4wDQoNCg==
