Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C2F8C2D0CD
	for <dpdk-dev@archiver.kernel.org>; Mon, 19 May 2025 17:56:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C0CA340651;
	Mon, 19 May 2025 19:56:21 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on2051.outbound.protection.outlook.com [40.107.21.51])
 by mails.dpdk.org (Postfix) with ESMTP id 5B8FB40612
 for <dev@dpdk.org>; Mon, 19 May 2025 19:56:20 +0200 (CEST)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=iiyHAqN+MJrVGnsTJqWeOTzV/iQt01/CqABukkX76nmeb9kc58iyoc837yBLwI/UjWZnhZhYrgXvPLMXhL5V6cPqQpK/3V98vhTJLETDt5qPcEhtn/Y6gBEN8x1eeVlYgKhj+MoXB8OKMzD1dDR65lkGs+5h9i3TMD0pivEJKBxWqzLSOOqFMxDma2IqDY9FKxHaXthddKo++ClvgXQtY24Sj2Y+utgbMmJPpFNnoJ8Ij3mA5r23b/oySbcCve3QB9vb72s/RY+PeUqjcUp0oHh7xbc5/qxOPgZkQ9jgC8w0smcXAfrERM0LMzWSVpR/K3RHNsSvogMHDXnU4SH23A==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0X4E7VHdmnPkQ4FDTYG/qnza5QPNKE+eMQiFlpiRY08=;
 b=Qd9XV4w9U62rFgbJ1C6AUBTIo48WWkElslJi9jNV0tRQpipHV1YQOs1VQIBqzDe1OJUVIBk+BL9sOtIhh6FFewUX2L75I07SCjukkgbQTbZXkQYZ9bj70foZOvytMIGZo3SGLQPqzfX3IhmI0NJ50E7OpDykxc07eZJ1CoB7bQ30QGYgxPDK1gGLHNOhSwlZGs0ASTiqJo2O2fKZ37h5Zjhu1LmhJr2dDn6PpfhFfT0votcTAt3RpX/EcTgAshy+Iqn2nBKH0xaWaSHJF7as25cOy7zCzE9KPxpXuQlKjW5DxYaxrSOS8n2skRjb+4hTUxEqEu/L060Ib2DMRDaRlw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=redhat.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0X4E7VHdmnPkQ4FDTYG/qnza5QPNKE+eMQiFlpiRY08=;
 b=EK6vZkxydEQtirMg5WJreF52GlAPzLxrDtj4misY9ocJjB+8lnKmbNIJLDN0FdVgc80FWcWoL7fvqbjWP8KUp8DD/acbqh94dy146bXYqQo6/8IgQ+5VPIiN+ZtQrreYejRJgzGKjEw4NmWz1bi5ck+Q1v0i6iayJpcZcOjCI5M=
Received: from CWLP265CA0450.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1b7::23)
 by AM8PR08MB6370.eurprd08.prod.outlook.com (2603:10a6:20b:361::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Mon, 19 May
 2025 17:56:16 +0000
Received: from AM2PEPF0001C70B.eurprd05.prod.outlook.com
 (2603:10a6:400:1b7:cafe::a7) by CWLP265CA0450.outlook.office365.com
 (2603:10a6:400:1b7::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.29 via Frontend Transport; Mon,
 19 May 2025 17:56:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM2PEPF0001C70B.mail.protection.outlook.com (10.167.16.199) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.18
 via Frontend Transport; Mon, 19 May 2025 17:56:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EkRUrNzrXu39So+9qUJBE72lH2tHjTxj2jRhH6uGxMM1lvhbJ6tlvK5kAHx7/8FO/k6LdLl1DdxLxrn9RgR33edFGSg3riKe0U3Jz9RkaWigbaRhRpajgZh0cTlZHlDnH4BCgkpZwNDCk9kt9rLBsz07lY2tbGsjx4fpw+vB2v7zkg8GSe7ihvx8jXIBB/2FNxXplXC7UWoIQD45IRdNkdnQEicP1azVHJh3Cg0/AlI0WppiHRnisZerHzMLXgIjFoCsZ+9DCl7jhjtyt8DvhvKTIRsMF0yTWGWtYxgGCwYuQzjVKYun6EHceBEmN1pcvRIQJcK2cwHSd4b8qPYFCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0X4E7VHdmnPkQ4FDTYG/qnza5QPNKE+eMQiFlpiRY08=;
 b=HEYlxoPNyR0mY8ZcKd8hg1qQzjlF6MzS/Z7a1hoxb28AqL6htKaV9xAe8p72LvoUntlKMr1xfQL9/Xazu9BEppJxA/GAczte7VmA9KqL/q+O9829aoZi4jyjQgAgw2AaYz3Bt7o331kkUQ60BwZg3FYiEQTks9Srn2KBx6wp9G3kK21+4dZ3/ZB5CxojgDsJt3Zqd42l/EXLxq3ivIp+uMUycfRB3vCY7S+EKTozNtA92Rl5MS2U4A+/gTPzctDavP06MGMSsAosStroqMdtwSTRBJiz3QGmJELOlGkbbd3QqdRIBv+cNbWZimXRT3xuFi+s4n6TLnRUalwq55e38Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0X4E7VHdmnPkQ4FDTYG/qnza5QPNKE+eMQiFlpiRY08=;
 b=EK6vZkxydEQtirMg5WJreF52GlAPzLxrDtj4misY9ocJjB+8lnKmbNIJLDN0FdVgc80FWcWoL7fvqbjWP8KUp8DD/acbqh94dy146bXYqQo6/8IgQ+5VPIiN+ZtQrreYejRJgzGKjEw4NmWz1bi5ck+Q1v0i6iayJpcZcOjCI5M=
Received: from PAWPR08MB8909.eurprd08.prod.outlook.com (2603:10a6:102:33a::19)
 by PR3PR08MB5852.eurprd08.prod.outlook.com (2603:10a6:102:8e::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Mon, 19 May
 2025 17:55:43 +0000
Received: from PAWPR08MB8909.eurprd08.prod.outlook.com
 ([fe80::613d:8d51:60e5:d294]) by PAWPR08MB8909.eurprd08.prod.outlook.com
 ([fe80::613d:8d51:60e5:d294%6]) with mapi id 15.20.8746.030; Mon, 19 May 2025
 17:55:43 +0000
From: Wathsala Wathawana Vithanage <wathsala.vithanage@arm.com>
To: David Marchand <david.marchand@redhat.com>
CC: Chenbo Xia <chenbox@nvidia.com>, Nipun Gupta <nipun.gupta@amd.com>, Maxime
 Coquelin <maxime.coquelin@redhat.com>, "dev@dpdk.org" <dev@dpdk.org>, Dhruv
 Tripathi <Dhruv.Tripathi@arm.com>, nd <nd@arm.com>
Subject: RE: [RFC PATCH v4 1/3] pci: add non-merged Linux uAPI changes
Thread-Topic: [RFC PATCH v4 1/3] pci: add non-merged Linux uAPI changes
Thread-Index: AQHbxz7chx6XUzTdHk+OriL/e8Bqk7PZg5eAgAC4+fA=
Date: Mon, 19 May 2025 17:55:43 +0000
Message-ID: <PAWPR08MB89093387F0988872596A15739F9CA@PAWPR08MB8909.eurprd08.prod.outlook.com>
References: <20241021015246.304431-1-wathsala.vithanage@arm.com>
 <20250517151736.2565461-1-wathsala.vithanage@arm.com>
 <20250517151736.2565461-2-wathsala.vithanage@arm.com>
 <CAJFAV8y6ZXpvZW-HTMC+0rqOeSRMm+15micF=XOvCFsN7kGWmg@mail.gmail.com>
In-Reply-To: <CAJFAV8y6ZXpvZW-HTMC+0rqOeSRMm+15micF=XOvCFsN7kGWmg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic: PAWPR08MB8909:EE_|PR3PR08MB5852:EE_|AM2PEPF0001C70B:EE_|AM8PR08MB6370:EE_
X-MS-Office365-Filtering-Correlation-Id: 7be9ea79-ebca-4ad6-405a-08dd96fe73a9
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|1800799024|376014|366016|38070700018; 
X-Microsoft-Antispam-Message-Info-Original: =?utf-8?B?ZzdrK1ZyZTVKWTFsdndBaEgvS0JyK1F5NG4xY2ZoLzNXY0puM1NxQXlzR2J0?=
 =?utf-8?B?THBqSHpGSEhpT3BUM0pNb3Vtd1lNVkxlcEQzSmt0djI3eGwwSUxtVEdiOU9H?=
 =?utf-8?B?bDJjRDRzNnpNY2tPcDJENmpKOUJyTTdTS2o4QnhZVWFZWVkzeHk4U0V4VWlL?=
 =?utf-8?B?VDluTWRkNHpmOUdlWVltRG0zTXRNUkxZY05lYlF5ckJYZVlaMkdmbUZPSkd5?=
 =?utf-8?B?ZHhHOVpRY21FNTI0WlROQjluUy95S2lFUC9JRnJuMlNZYjZUbW1aTmxFRm4v?=
 =?utf-8?B?cTd3S3ZxM29jQWlYMUU1eHc2RXdxcnpNaDIxNml0RW4zYmxvRXB6SDVDK0Ft?=
 =?utf-8?B?QlhsdmJkT2VCOTJ5OS9GWGxsZmxoQnZ3dDJBbE9Ob0FOMWRwTjNqUHlUeGhK?=
 =?utf-8?B?am4zT2xSVmkxbis4VThIRUxLWGkxK0M5T0tnZVhkTEtqZzA1OFJWVFZvZ3Rk?=
 =?utf-8?B?Rmk2K0cvZGo1T3dWNmkyMGFKYUtZR2RTa0MrOWxyZFdBbjNOd2h3MWJ3UUV4?=
 =?utf-8?B?N29lQ21JU1NYMDhyNkF4RE5RWmN5ZHJGVXpkSzd6ZVI4SW5zdTJaVXBCTVlQ?=
 =?utf-8?B?d1o2eDdncXQ0SWxDOW5Qc1JOYS8yWWY4Qm83dkdIZmhzZUNjbE1tajNKNlVH?=
 =?utf-8?B?MlZlRG1RVUJTRkxVaGIyOU5oTXZLWXRjUFZUM2R0ZmlvQXhmNjd4dGU4TG5Y?=
 =?utf-8?B?Z015cTYxNFVJRkdqSC9zMjc0bTRUaTN6SHVTZnBFZjVjMWZ4Q3RodFdiV1BY?=
 =?utf-8?B?aFpDOTJGL3JWdnFqODIrcklsMGNHeXIyWklTSVpobXQ0UjV2aEI2Zk1DQTJF?=
 =?utf-8?B?clBURWNlNGNsa1pkWlE3L0t4MjdPbUU5UVN6VEVocGtvVCtWcXFQaVVqQlN2?=
 =?utf-8?B?V2xvSCtqWTFsZmV2a3hDWGErSWluVnJNZjdMZklXUGExdkpGeHZMUlJ6RUFt?=
 =?utf-8?B?V2Z4YXUzanFybEIzWlhrYmJ5QWJsZWlIMVNFcXNFeVJxekNIc3ptaVJveTVU?=
 =?utf-8?B?a2l6ZlR2U2ZNT2wxYXFibEhWZHhua2hqejZKOUFLeUgzNkRWZ2VneU5odlZo?=
 =?utf-8?B?b2dvclJKT3E5SitCUjdFZEs1RmZteEt5bGVJV2JHak05dVpzZEV3S044eUpP?=
 =?utf-8?B?VGo3RkhNZGhkTFVHbC9taDhZMXJoWUNqK0JPcm1DSjZNVFpXV0RNamFKbkQ4?=
 =?utf-8?B?YVlWQUhTOWpTQkV3VlNPUWMzcGs0MHcvMmFaS09JQjFjbzhjdjRLTWR2b01l?=
 =?utf-8?B?akY3V2dmRWhTczB5bXVIcllsMVYwTCtWWHUrRTJmQWZmb3FaejlESi8ybC9U?=
 =?utf-8?B?QjBFYkU3cE90YUpYMHQra0pxTm42SmRHMCtQR294VnBnbW1TdnlBalk1KzZU?=
 =?utf-8?B?Zkk0VlF4VWFMOXRZNThHMXN1ZUlDTlY3bnFDVFdlTkZUcEFQeWllcXU3Q0Ex?=
 =?utf-8?B?WXlSaGlpRmkrWHlwRnFocHo2bEJDdlcvZ1ZwaWNTa0EzRnRZYTY4MkxhTmla?=
 =?utf-8?B?NzdudnFZZUxCMjBZcFQzVkRGNlZUam1NSEUzYWZBL1o1N1pzUVM1QXdIOUhD?=
 =?utf-8?B?YkY0ODVKVVNKN1ZvQ2JSakJlT2hpRzdhRm9RUGx3N0hkM1BoOXZwSGFHbzhr?=
 =?utf-8?B?NWR4WFZSTEZtRG5jOHhvNllKMnhWLy82dTNDWnhpT3U1dktid3BZZW9FcFgz?=
 =?utf-8?B?RkxCWWo5TlljVWJrV2tjOVM2SmRPSnQvVXg3UHRETlZsUEdwQURxVEp2MXZS?=
 =?utf-8?B?bVhIWFo1bjkyMTJjNzIrUmFlSjU0S3h4ZGF0eW9xdjdHTG4xRTdUVm1rSXlH?=
 =?utf-8?B?YlY0S0RMSUlzOEJQSStwZGdrMDZCZFFUeks3YXF2OVZScVMwcS9rd1BCSXgw?=
 =?utf-8?B?UW9iYlVmSklHOG9STUVzTFFFTXJIRHZxQngxU0pkYWdQNzVlZnNaT2diUWc3?=
 =?utf-8?Q?hUISeOPmjFk=3D?=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:PAWPR08MB8909.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE; SFS:(13230040)(1800799024)(376014)(366016)(38070700018);
 DIR:OUT; SFP:1101; 
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR08MB5852
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM2PEPF0001C70B.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 76306bf4-5cdb-48f2-6241-08dd96fe6007
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|35042699022|1800799024|376014|14060799003|36860700013|13003099007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?blQ2MGlGQmdGVmdpYllQME1oS1pBUGtCZ0lGUkdRNmpJVEx1Z05OV3ZyUlMx?=
 =?utf-8?B?NWNXRi90cW8zVGhzSUJLRmpSeEwxQWRFM0ZWby9LSklXdEJlV2FHQ0ljTXJN?=
 =?utf-8?B?cFJPc1Vjd05hdjVpcHk3b3NMZGxEb2tjbXYyMktsVFVGd1ZaVFlCWGx3QTRz?=
 =?utf-8?B?dHIzVXBLQjhDb05uMnZBK2tmeS9BeU9jZVIvbTJ3Yk9rem5SLzhKTm4zMWpG?=
 =?utf-8?B?S2lvblBVZGtKSmR6Zjh3dHl3OHE4TjArUllrNkN1bDhybWtUS3FtTzUwU2lO?=
 =?utf-8?B?SlhTSCsvVXh1UE5WK0ZDNnc5UXBBV2hUSDh3SGN0bFJXcnhjSi9rdldKaVZE?=
 =?utf-8?B?dUo5akhycGlEcHk5bDc1QTlxNzJCK2dQRUdOVUNsYnVHQUVud05yS0RtSktY?=
 =?utf-8?B?MTArLzdDNFNPblMyZ2UvUmtIQ1FoaXRUYkN3aWVFVVFOb0JSck40WkFOck1w?=
 =?utf-8?B?Sk5qZWtsdzV1RVFralIvSzVENHNWRHdIWWFmTmpRenQyclVKbkhxL3MwUi9K?=
 =?utf-8?B?TDRSWmkrQjJIL3FobHVpQXdBdExiWmpDUU9rdzBzK1hxZGppOFpyaGxpc1Bv?=
 =?utf-8?B?eG1oOU81NUZrS2ZrVzdnNDU2SUZ5YUlHUFRCUjhKb3pJNjIyajQxWklHYWpF?=
 =?utf-8?B?TGU0MzFrWFFrQ1Y4aTBNMHVydDNFN3J6YjhlU25JM1lFSGwwM2YvQ1FLMUpa?=
 =?utf-8?B?b0VxRi9RTy83cWhqK3RYUFAxN3J1eWh1Z0t6SmJwOWZBcFcvTk4zcXBtQVBK?=
 =?utf-8?B?RTJ0TVBBZmdEMzhMOGU0TnorbEo3bGx6enpIS1RibmFVdFNvZ2Q5WEt6d1dZ?=
 =?utf-8?B?c2hpMVdXRHVRUGZEUlFQSFJxMWREamptdzF5ay94dU9kMkwvb2JuMUwwN3Z4?=
 =?utf-8?B?WC9HT0EvRGo5dTZQaEQ0bzlKdWc4bjhuL0JHUHhxcDNyYWwrVk55NVFQTkdv?=
 =?utf-8?B?VVdZS3VKOXVEb0RpWi9SUDRBMkY0QUNUWE5xQytJU1k5ZGdBdlpQRVg5eHMz?=
 =?utf-8?B?Z01aS0pmcWZodGh5OVVJaEdsZHo0QTN1UFEzcUpNd0UzM1FtZlNBTWVISWxT?=
 =?utf-8?B?VzFaaS9WWEw0SGRFUWsyNlUxeElhTGRBOEFsdHVlNTBjeW8xMXdDaUZKTGNp?=
 =?utf-8?B?L1pIYXlLaFlzOFNKTWJZTmNrWmdsMUt4bkNPUUprMU5JQWhPcGFyYVluQlNi?=
 =?utf-8?B?VGkyZXFPMmZUZ3VxKzhKWE9IeDJvYXN5dkJPeFRvd0dMN3pvcGRadzBKZk1L?=
 =?utf-8?B?L01uVWNZQkV6dkhOTW8rclNoSW9NajRXamRBMGMvdEpzQ0RYZEZQazZZSlhE?=
 =?utf-8?B?ak52WmpHL3NSSlRtWGp4cU5uN0Q4V2I3ZmdtaXNDSG9LOXdFc0tGL29FU3lq?=
 =?utf-8?B?T2V2cnVLQ3pJMDFjQmxGMERVcmlmTUNzcytDOVk2bkZreWM5djMrTkVEYjdY?=
 =?utf-8?B?SFVVdWd5cEZlQk1QTll0YU1VNERRNS90VU1JWUI1SzQvakVCcEUrbmhyRGM4?=
 =?utf-8?B?Wk5xUStHaGg2dEZUNTFBQnl2eU1JQjlRaWVXMXRqeEJVek5YOUNPNk5UaC9U?=
 =?utf-8?B?YjlDdHU1ZXdySG1HcVV4cXllNHZQbWN0RFdGaG42Tzl3UmV1TnNyVktDQUk5?=
 =?utf-8?B?RHYrMmhBL1lPT2hpQUxsNUdMY2V5MzdSeXJwVEt2c0J2TXhuQWgvazF1MHVw?=
 =?utf-8?B?ak85RzcyUmFEQXFacVEzbEQ2ZjlVc2hDcE13L3JtL0kxaGNVaVp6QTVoenRH?=
 =?utf-8?B?eURLbUtuOUFJMDE5QllURXhWUUN3UHdDb3Z5Q3lFcXoyTDN1VUlFY3BTZTRX?=
 =?utf-8?B?U2JrZUw4cm82dTQ2MkVlY3hFeStGNTBKSUo5T3BMQ0o1ZytpN0wvS3RvbDYz?=
 =?utf-8?B?UjlHRXI4SUxRK1NjcCtHc3BvdEZoaUZtSGl3WlpFczM2SlJGRno2aUhuZzAw?=
 =?utf-8?B?RjI1VTNaRlhRRkJGUTlOZmZWY05TK1p4K1Uvcnc3S3V6cnpjK2FtalpJQWVp?=
 =?utf-8?B?d1pDZEliQm5RPT0=?=
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(35042699022)(1800799024)(376014)(14060799003)(36860700013)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2025 17:56:16.1861 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7be9ea79-ebca-4ad6-405a-08dd96fe73a9
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: AM2PEPF0001C70B.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB6370
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

TGludXggdUFQSSBjaGFuZ2VzDQo+IA0KPiBIaSBXYXRoc2FsYSwNCj4gDQo+IE9uIFNhdCwgTWF5
IDE3LCAyMDI1IGF0IDU6MTjigK9QTSBXYXRoc2FsYSBWaXRoYW5hZ2UNCj4gPHdhdGhzYWxhLnZp
dGhhbmFnZUBhcm0uY29tPiB3cm90ZToNCj4gPg0KPiA+IFRoaXMgY29tbWl0IGlzIGEgaGFjayB0
byBwcmV2ZW50IGJ1aWxkIGZhaWx1cmVzIHRoZSBuZXh0IGNvbW1pdCBpbg0KPiA+IHRoaXMgcGF0
Y2ggc2VyaWVzIGNhdXNlcyBkdWUgdG8gbWlzc2luZyB2ZmlvIHVhcGkgZGVmaW5pdGlvbnMuDQo+
ID4gVGhpcyBjb21taXQgc2hvdWxkIE5FVkVSIEJFIE1FUkdFRC4NCj4gPiBOZXh0IGNvbW1pdCBp
biB0aGlzIHBhdGNoIHNlcmllcyBkZXBlbmRzIG9uIGFkZGl0aW9ucyB0byB2ZmlvIHVhcGkNCj4g
PiB0aGF0IGVuYWJsZSBUUEggaWNvdGwgaW4gdGhlIHZmaW8tcGNpIGRyaXZlciBpbiB0aGUgTGlu
dXgga2VybmVsLg0KPiA+IFRoZXNlIGFkZGl0aW9ucyBoYXZlIG5vdCB5ZXQgYmVlbiBtZXJnZWQg
aW50byB0aGUgdXBzdHJlYW0ga2VybmVsLg0KPiANCj4gQ291bGQgeW91IHByb3ZpZGUgYSBsaW5r
IHRvIHRoZSBvbmdvaW5nIGRpc2N1c3Npb25zIChtbCBhcmNoaXZlIG1heWJlKT8NCj4gVGhhbmtz
Lg0KDQpIaSBEYXZpZCwNCg0KSSBpbml0aWFsbHkgaW50cm9kdWNlZCB0aGlzIGZlYXR1cmUgYXMg
YSBWRklPIGZlYXR1cmUgSU9DVEwuIE1haW50YWluZXJzIGRpZG4ndA0KbGlrZSB0aGF0IGlkZWEg
YW5kIGZhdm9yZWQgYSBuZXcgSU9DVEwgZm9yIFRQSC4NCkkgd2lsbCBiZSBzZW5kaW5nIG91dCB0
aGUgVjIgd2l0aCB0aGF0IGNoYW5nZSBzb21ldGltZSB0aGlzIHdlZWsgKHBlbmRpbmcNCnJldmll
dyBpbnRlcm5hbGx5KS4gSSBzZW50IG91dCB0aGUgRFBESyBwYXRjaCBiZWZvcmUgc28gdGhhdCBJ
IGNhbiBsaW5rIHRoaXMNCnBhdGNoIHRvIHRoZSBjb3ZlciBsZXR0ZXIgb2YgdGhlIGtlcm5lbCBw
YXRjaCB0byBzaG93IHRoZW0gdGhhdCB0aGVyZSBpcyBhIHJlYWwNCnVzZXItc3BhY2UgdXNlIGNh
c2UgZm9yIHRoaXMgZmVhdHVyZS4NCg0KVjEgaXMgbm93IGxhcmdlbHkgb3V0ZGF0ZWQgaGVyZSBp
cyB0aGUgbGluaw0KIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2t2bS8yMDI1MDQwMTIzNTIyNS5H
QTMyNzI4NEB6aWVwZS5jYS9ULyNtZTczY2Y5YjljODdkYTk3ZDdkOTQ2MWRmYjk3ODYzYjc4Y2Ex
NzU1Yg0KDQpUaGFua3MuDQoNCi0td2F0aHNhbGENCg0K
