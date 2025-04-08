Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3922AC369A2
	for <dpdk-dev@archiver.kernel.org>; Tue,  8 Apr 2025 17:11:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 567E540267;
	Tue,  8 Apr 2025 19:11:16 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on2050.outbound.protection.outlook.com [40.107.20.50])
 by mails.dpdk.org (Postfix) with ESMTP id DCA8040264
 for <dev@dpdk.org>; Tue,  8 Apr 2025 19:11:14 +0200 (CEST)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=xJvUSfpdWW3hEGIr+Ya1ScyHD2e/mP+h14pcQwKcjJEpKcmjsO+xfucUU/XAXNL5+cFPgz2AcTncDX0Ra8XuHBbMw8wAD1MdS/XHiFS+A43o2Jc2IW7KFlNBbJdW/1ITpEaXOKWWVEjIDRLUxcdN8BfX4jZP2EJjc/HFt9P8mImJ4UxwPdPsaW8plaCUkyQVQQfjY3fGJsEscZLDpuQ9yaapXuqrq9NbyQaPORL0QI8DtQqIuTpKYTkW2gcaJk0VMVdTo2z802p1427PX4MiOoXd32ygemoETG8rV3pCa7hmzCvr9APQMsalsD/QnEYtdLS8gHlvl20flTSedCGt0g==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=12YL1QcuIcGjY9lcfKIfIU1mMw6J4tLSksMjFChn9TI=;
 b=u5274HshmHrQe0b23Ss+ieR0Kz+/pIWW7FBKbZ4UskjUauJBSuSWVJ5HvduBy39jcnl8VqTr9LjChcmAWJqiqDZvDyFrHpmiI1vuXcAc9jFWjccj7x89o050Ib6ECOH9C2+WINGfNYRc8Qg8gvE1gmEvzrQfHaZBF7iDEveyG07SGfRj3b+7OF7e8yy6RbIOGoNUMUjJyru868iD8TAeYPlkPV3MYrOG1DDukK0OYVch1C1QOPRPKP2LTet3NP7Nn81HXjO/pBsDKeDnuHmsR3OoXEWzg1wOqXCTwxUR5Aia8zctNA4viyKaBmyWl2kNq3gdoYQluJZZ10vT3PWiqw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=permerror (sender ip
 is 4.158.2.129) smtp.rcpttodomain=redhat.com
 smtp.mailfrom=arm.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=12YL1QcuIcGjY9lcfKIfIU1mMw6J4tLSksMjFChn9TI=;
 b=lrqnLqSEfy+QJ6V8CUjxrGEwRfQLHj/vGvDXeDgpBLOzDcPyLo/L0skA0XOOMPapElJGYQAfjQ7iQHaMv2F8QQUT8CKD3ABpFlQftP4fNq7RsF2R0SZa1xDoS96fP5VK5C5Zi+2tZjYGvLyeofBajzxaj2Pjk9m35YDYTB/1gk4=
Received: from CWLP265CA0367.GBRP265.PROD.OUTLOOK.COM (2603:10a6:401:5e::19)
 by VI0PR08MB11017.eurprd08.prod.outlook.com (2603:10a6:800:250::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.31; Tue, 8 Apr
 2025 17:11:09 +0000
Received: from AMS1EPF00000044.eurprd04.prod.outlook.com
 (2603:10a6:401:5e:cafe::6d) by CWLP265CA0367.outlook.office365.com
 (2603:10a6:401:5e::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.19 via Frontend Transport; Tue,
 8 Apr 2025 17:11:09 +0000
X-MS-Exchange-Authentication-Results: spf=permerror (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com;
 dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: PermError (protection.outlook.com: domain of arm.com used an
 invalid SPF mechanism)
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AMS1EPF00000044.mail.protection.outlook.com (10.167.16.41) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8606.22
 via Frontend Transport; Tue, 8 Apr 2025 17:11:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CgYlFN0vJSwpWUrxvW+SE+cu/zHRrOHAEWOw17lS2b5WqqVYW67ouRRZDeEulFGDadbCGoDCpYj/Vz/KYYwZ47XPVWnbEbIGBYEdf6tUmt1stnu8gl1fTY9GsuNxYYyzmJYAj8w3sMqYKOgBPjIK3j3UkVt6pbYcvIQBXenaYw8iyd7OVxZqupbUFAToTEujAmwidKkhy4B+Ds6G5nn66PgV1GS+FaEm2Tu8m50ldMMu7hRxefvTROTV6TJZS/92+P2DWi7ajANu7beIrYzQr2+69cqVt7aMnlpCKxCBwzzRP4Sf++0pRMWCukxvDl3ZD4jgsa7lqTqe0udkCW4lmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=12YL1QcuIcGjY9lcfKIfIU1mMw6J4tLSksMjFChn9TI=;
 b=GUH5oGnAJ3WnTp5RofsEIWRYf1hyd8f3/EKPMllAnFYyKjxljH2I0VS3FOuZR4pgKBNxgBbDiRLe7Fk8ktAXJr1WOqCZ7UJFm89Y0txBkneDIRWOia2j/v9GfPmlNvxDOt5TuWrTVMw2EB2+TuQqYRH2jZX9r9+syMhYXV6iXSTZLCGsKSTOP3QayYjgMrb0YDzRn6v1eId7Zdz+7CTnqrLLRfjOqdBBKoHyEjw8waRlALjfPZuv7MdU03uVMMfFjZy7pyxZUMqrg53jeiORar8xbl/EEGhnr5ziDY3oab5HNr32lS8haixKwSmSefhIBIqXPYfeljRS9Hkjt8trmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=12YL1QcuIcGjY9lcfKIfIU1mMw6J4tLSksMjFChn9TI=;
 b=lrqnLqSEfy+QJ6V8CUjxrGEwRfQLHj/vGvDXeDgpBLOzDcPyLo/L0skA0XOOMPapElJGYQAfjQ7iQHaMv2F8QQUT8CKD3ABpFlQftP4fNq7RsF2R0SZa1xDoS96fP5VK5C5Zi+2tZjYGvLyeofBajzxaj2Pjk9m35YDYTB/1gk4=
Received: from PAWPR08MB8909.eurprd08.prod.outlook.com (2603:10a6:102:33a::19)
 by AS8PR08MB9243.eurprd08.prod.outlook.com (2603:10a6:20b:5a2::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Tue, 8 Apr
 2025 17:10:36 +0000
Received: from PAWPR08MB8909.eurprd08.prod.outlook.com
 ([fe80::613d:8d51:60e5:d294]) by PAWPR08MB8909.eurprd08.prod.outlook.com
 ([fe80::613d:8d51:60e5:d294%4]) with mapi id 15.20.8606.029; Tue, 8 Apr 2025
 17:10:36 +0000
From: Wathsala Wathawana Vithanage <wathsala.vithanage@arm.com>
To: David Marchand <david.marchand@redhat.com>, Bruce Richardson
 <bruce.richardson@intel.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, Jie Hai <haijie1@huawei.com>, nd
 <nd@arm.com>
Subject: RE: [RFC PATCH] drivers: add generic build of SVE files
Thread-Topic: [RFC PATCH] drivers: add generic build of SVE files
Thread-Index: AQHbp9HZnOCpyajjUU+X9pfSDNIxvbOYWa0AgAGUY9A=
Date: Tue, 8 Apr 2025 17:10:36 +0000
Message-ID: <PAWPR08MB89091370435B1BF51D90E08F9FB52@PAWPR08MB8909.eurprd08.prod.outlook.com>
References: <20250407152857.2203839-1-bruce.richardson@intel.com>
 <CAJFAV8zKFof8+_mDc7_Nmf=QkTdVDgBVYY2rc+DVZKXDoR8s8A@mail.gmail.com>
In-Reply-To: <CAJFAV8zKFof8+_mDc7_Nmf=QkTdVDgBVYY2rc+DVZKXDoR8s8A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic: PAWPR08MB8909:EE_|AS8PR08MB9243:EE_|AMS1EPF00000044:EE_|VI0PR08MB11017:EE_
X-MS-Office365-Filtering-Correlation-Id: 0937c1c7-243b-4594-4367-08dd76c05b3c
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700018; 
X-Microsoft-Antispam-Message-Info-Original: =?utf-8?B?QU9Za2ZsSVc3blRYWUNMT1RHSzFnWTRiMmptWkZYYUlxdElqbFlPK1Q1U0wr?=
 =?utf-8?B?N3BxbGNzVDBkTGl1ZWJSOTFtSUlwZ3VhNGZYYlZmckQwSmU5NjF2RVV1TlN0?=
 =?utf-8?B?WG0vcHh5OEVkdDl2UVNxb1dzTVJ4aGVDaUt5bHUxOW14YklsQXpTUUl4elBQ?=
 =?utf-8?B?SlhWSk1GeFRuSk1BT3U0QkxSR1lqOFpuUEtoL2g3T00rSEl2Y3pLMFFtL0hZ?=
 =?utf-8?B?QU8rdm9iK2dtQkdCWUVwdjdxM1pmaFIyYzczVVJsWlkzM0pDTE1KV2JqY0JS?=
 =?utf-8?B?RDE2R25nMy9lSnJHdEc4M0w5Zll2NHZLL3NFOWVZTnZTOGFFTEhKU3RhM1NQ?=
 =?utf-8?B?clE5Ump6M3NocWlGL1RlWlZvbDVTT3JyZThPVE95R3lBeWRqeEFzUUo4Lysy?=
 =?utf-8?B?VW5WaG8vOXRZNWF1dGpDeGZJQXNsNWZNdGF3dWdMdThFaUpsNjJDL3lkcENp?=
 =?utf-8?B?bnBtZ1VtWjN2WjJWYmJSc3c2Zm1uMTBrNDI0b0laRTA4ZkFLdTljMFpuMmhk?=
 =?utf-8?B?azJtUEpDYjc3RDRla244eUFiVlMydXFNa2NZVzZCZTlFdTBRSHhhcTg4T0dj?=
 =?utf-8?B?b2VCZy9nRm1QOHF6azdFL2E1L1ZJbldOYzdicVZXdWpKaDJXN3NBWXBoTHBj?=
 =?utf-8?B?NDB3ZE9pN0dJS1hBY0tEYXBoOGp2Nzk2ckFrcWFRZGltKzU2V3JHTTc5MkNI?=
 =?utf-8?B?RXVDNnMwL3krTllUV3dJZ1c3SjNITjlETm45OTgvb0FpUGZQMWVNcnlRRWFG?=
 =?utf-8?B?SW1UZGxLSmVCeVVuZCs2VlNON2Q3VmRZdUZQazdzdlNkRkJITjZROEhRT2ty?=
 =?utf-8?B?ZS85QkR5VVZQSlBtMHdXeHhmRlhEQW1STWx1aXU0VnJXVHEyUXlqbnY3WG8w?=
 =?utf-8?B?VjlPTVFwTDNkM2hQVnZEM2RMQWc4SUFjZFFWNElKZy96MzNuQ3FJblRxeTFu?=
 =?utf-8?B?ckM3bTZIRG42aDg3VFR1RGFmMk43MjFqbXVWejBDQWZvN2NQOThDU3hRNi9q?=
 =?utf-8?B?cHJzazhsalZjMjNNRnZpS2Y2aWdEdWhycXh6WTBKNkNxaFNmZlMxZXgvL05h?=
 =?utf-8?B?UEpEUkZZajVjdTBIRDFqSzRPK2Erdk1zL1FqSHVFZFM0bTZTQm9zNkJMaHp5?=
 =?utf-8?B?Q2l1dWVaQUxZbGY2UU5sem1CbUhJdmdnalQ5ZEx2R0VOanltTG5iTmNuSFc1?=
 =?utf-8?B?TTRLeDQxc3BlbHZLbXhtMy9nOXZTemxGc3B0ckZlTk9hS1YzWlpIY2lxVmVa?=
 =?utf-8?B?ZjkyNGUrTVA2NWZJMThmRERKUWR2ZXFBVUlvZDdIaEZNejFCZVpWUVJsLzJo?=
 =?utf-8?B?dzkyVjl3RUU5SytHS2p2cER3MExxb3ovWGlkenFtaUNyeFZOckU1cXdhUVR1?=
 =?utf-8?B?QTFyK2tSK04wOVhESUJMTGJRa1RjTmJLcTExSThaSGlvSXFodk15OXZuRmw5?=
 =?utf-8?B?R1Z3TUZtVFh0RExKM2lPd1NTYmQ3SmJBNDhyZ3J6SlorRlJRMnVmYmlocEZn?=
 =?utf-8?B?aERxeVp1VjhhWVdicHVleDRGUEpFeGJJRnBhd2YvNHlWbDhIQTdhTm5wbWhJ?=
 =?utf-8?B?aUpXTmdnV2tDbzNWV3hpRlg3dU1DS054NjBiU1hYdVFMb3VKeFI2eXVKam91?=
 =?utf-8?B?aWhRRXY2TW05MWdqQ0VwQkNlTmxib0syWXZQODRUa1huM0hVUXB1bGJ2dnhk?=
 =?utf-8?B?bGpCaG4vNndVY2xBVFEyTTdmLzBRV2xjVDgzTUVabjJ4dWFuZjUzT0hoaWVm?=
 =?utf-8?B?eU9zc214YVZqYmxnK2dmbGxlb3hOWXpUUXNRYUxjSTVxNTJCZ24rMzZlQkpt?=
 =?utf-8?B?U05KMWQ2TXBVOVlMS2V1Ly9Rbk51Y21zQ1VHU2ZqdGpRZTFYUjBwWWdHb01O?=
 =?utf-8?B?NWN1YUJkc2NSY1FSZ2RBVndwMEZLSkliRWhpMlljVytrYXpkdkpSdHdZSFBJ?=
 =?utf-8?Q?qbpkN9IcfjEi1SOr+qu5sJ/BK7H/UlDm?=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:PAWPR08MB8909.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE; SFS:(13230040)(376014)(366016)(1800799024)(38070700018);
 DIR:OUT; SFP:1101; 
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB9243
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AMS1EPF00000044.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 761af68c-40c7-45cf-e7b0-08dd76c04796
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|14060799003|36860700013|82310400026|35042699022|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SGxUVW0ydHZVMjd5Z1NCZFJKYmZFOUFwUXBmdGovQURlTlYvZTNTSURXTE5x?=
 =?utf-8?B?SmFxdFkzVXljQWhla1IxbUQ3ZDRrSm9QWGRZOVdGNHkyTUdRakRCaG1VNWNl?=
 =?utf-8?B?akgwMVN0Y3N6aTVLWEdTYTZqQzl5RUJOY3Y1ZlNtOGVrLzN1RjBMMEd0Wm95?=
 =?utf-8?B?WlpnSmMxQmQ0V0x6cFdueERHZDA5Zjd5N2lYNWllOE1LWGxnb3NoMFJvbzI5?=
 =?utf-8?B?N2FVODdnWHppWTQrYjZvM0dXZVFMR3NvTG9FY3dWa0xSRDBHdXN4cTEzRG1p?=
 =?utf-8?B?STdCQU9aN091MHo1RXg5NmFEMmR1QmFvL0VLUXBlR1lCa2FBRlNXcDNoelYw?=
 =?utf-8?B?RlNDcVU0cFhtNW90OFg2Nm5QZi85Q2dCMVJWV3FORmFjZ1ZBTkhsdFFOeEQx?=
 =?utf-8?B?dmtCc1pYOTJkTlM0YnEzck1kMS9WNm0rdk94Wi8vSzh1UEJHRVJaOUYwYkJS?=
 =?utf-8?B?WDFtcWlETGd6NXVGRE50a3A3L0xrTjVLT2w5dXlucWw4ZUxDMVR4Ykd3N082?=
 =?utf-8?B?alV2R3g1dmhnTmJrOTF4NUR6V3Y0RlFQUGVEY1VMWGluNkFGRE9tWGZVMFFw?=
 =?utf-8?B?NjVLVnZWb1hFNjE4VC9DY0VpWHYybEVtOHQxbVNqNEZZUkJZY1BBQTZlVHE0?=
 =?utf-8?B?RUZWOENKUnFlTU0zNHVHTWZhQ09xMmFkdEJqeGVOMXFGZHh4V29NbmQxS0U0?=
 =?utf-8?B?MWpjT2FKYmlsaEt1WlJvcHU2QnhGMG9mUjA0NlpJdlVsSGJNeDlSQW56SHhZ?=
 =?utf-8?B?eTJLM1B0d0hGYjFQMnI3VExVSzFwV1M5MGVlOHpNSklQd2kzOWI5THJHOWVE?=
 =?utf-8?B?L2tlSlVyY3BCa0gwYWRzbytBV1lmSm1HUnBhVHE3NDdpcUhuZzZLb0l5UUtB?=
 =?utf-8?B?dlk3UVVFQnRSK0h3ODZ3MGljN0kwYWRULzNYTDdkZEd4bmRNT1BoUkFOOXRv?=
 =?utf-8?B?OGwyV1ZGYkIvV2UrNnA4cVRyL1dBOTFpZEhoOEJjbDdzMVJobjNXRmdMUnIz?=
 =?utf-8?B?UTZDOXpyMDJJN1pWYnVFYmw1UVZ6WkEwV2M2QnJWK2RxZWk0dmNjcTNzazdk?=
 =?utf-8?B?YnJoQVV0dGNZaXhlWnVzWDBtQWJzSnROS01zckxqUW91VFNRTTg5RUZBQnRw?=
 =?utf-8?B?NWQ0VnpTRXB2R1kvV3BocHZGVnRpUkZaQjFjaDMvdEZjM2hDNXd2TDR3Q3pJ?=
 =?utf-8?B?TGYyYzhob0NmVkhKSS9RUnRWTG41Nll1ZU4yZ3RLODFFNzh3amVkZTBvaUtP?=
 =?utf-8?B?WUVtUEplbGNqYzFkaHIvcHBLSTRIVlVyY1hpa3NwRExaL2MycllYY1ZCYjQw?=
 =?utf-8?B?RlZtMFhobHhJa1AvVjJZREFCUVQzSmM2V0pCT3FLbC9qSFFuQ0FJQXN3TDlT?=
 =?utf-8?B?SXV4ckI0UUpZOHRNM1FwS3F4THM5dU4yVzdudFpGZ09mRTNMWklMbXF3VlVC?=
 =?utf-8?B?L3lHNmVCRzNETUpDMVNhak50VFU1OTU4blllOTRpeDZtdzZ6anRaOWdpZmdO?=
 =?utf-8?B?K3d1eU1JbUhuL1RyWWVZZnpMYVlORkgyYldGcjVjYU9lYS9vSzlET2xvc240?=
 =?utf-8?B?MVhhUS9VYlFWVG9aRGZEZzlpNmJvd2xwZWtmUDBVckIrbC9yU3k2K1ljdm11?=
 =?utf-8?B?UXlxaW5jTEZySitoRnRBVm11blN3RkRRdHVVcTRuL1F2M01nelIyMSsvREJR?=
 =?utf-8?B?MFp2VkdBWXFzSzNDSFpDeFlDdVlMeWZ6ZjZMNTZRcDZHVUZCWk50WFZyZE4r?=
 =?utf-8?B?Mkt4UEFyRWtUb3d2L0tPdGI3MENFcVpyZUdJMjg1ODJjalJGVFduUEQ1cnhC?=
 =?utf-8?B?S1oyWHdRRHlPTXEwMEQrblRUVWdxYWpEWi92UVBSUW94OFAxY3RLQnFucHgx?=
 =?utf-8?B?c0VHd0JQbTlPbHROZk50emh1OEZ6eHRRLy9Kdmx1TWNhcU5WUjFFWnBSOVBT?=
 =?utf-8?B?M2RjVWUxL2YvTHpsQjVQSUtHK0xHR09salMya00xQlZRY01Mc3lZRUVKNTJr?=
 =?utf-8?Q?Uk6QiQm6BKpn9PdDDerraF+AGuPJxY=3D?=
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(14060799003)(36860700013)(82310400026)(35042699022)(1800799024)(376014)(7053199007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2025 17:11:09.1546 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0937c1c7-243b-4594-4367-08dd76c05b3c
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: AMS1EPF00000044.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR08MB11017
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRGF2aWQgTWFyY2hhbmQg
PGRhdmlkLm1hcmNoYW5kQHJlZGhhdC5jb20+DQo+IFNlbnQ6IE1vbmRheSwgQXByaWwgNywgMjAy
NSAxMDo1MCBBTQ0KPiBUbzogQnJ1Y2UgUmljaGFyZHNvbiA8YnJ1Y2UucmljaGFyZHNvbkBpbnRl
bC5jb20+DQo+IENjOiBkZXZAZHBkay5vcmc7IEppZSBIYWkgPGhhaWppZTFAaHVhd2VpLmNvbT4N
Cj4gU3ViamVjdDogUmU6IFtSRkMgUEFUQ0hdIGRyaXZlcnM6IGFkZCBnZW5lcmljIGJ1aWxkIG9m
IFNWRSBmaWxlcw0KPiANCj4gT24gTW9uLCBBcHIgNywgMjAyNSBhdCA1OjI54oCvUE0gQnJ1Y2Ug
UmljaGFyZHNvbg0KPiA8YnJ1Y2UucmljaGFyZHNvbkBpbnRlbC5jb20+IHdyb3RlOg0KPiA+DQo+
ID4gRm9yIFNWRSwgYXMgZm9yIEFWWDIgYW5kIEFWWC01MTIsIHN1cHBvcnQgYnVpbGRpbmcgZmls
ZXMgZm9yIHRoZXNlDQo+ID4gSVNBcyBmcm9tIHRoZSB0b3AtbGV2ZWwgZHJpdmVycy9tZXNvbi5i
dWlsZCBmaWxlLCByYXRoZXIgdGhhbiBoYXZpbmcNCj4gPiBlYWNoIGRyaXZlciByZS1pbXBsZW1l
bnQgaXQuDQo+ID4NCj4gPiBUaGlzIHJlbW92ZXMgdGhlIHJlbWFpbmluZyBidWlsZCB0YXNrIGZv
ciBkcml2ZXJzIGluIERQREsgd2hpY2ggaXMNCj4gPiBiZWluZyBkb25lIGJ5IGEgZHJpdmVyIGl0
c2VsZiwgcmF0aGVyIHRoYW4gaW4gdGhlIGdlbmVyaWMgZHJpdmVycycNCj4gPiBidWlsZCBydWxl
cy4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEJydWNlIFJpY2hhcmRzb24gPGJydWNlLnJpY2hh
cmRzb25AaW50ZWwuY29tPg0KPiANCj4gVGhhbmtzIGZvciB3b3JraW5nIG9uIHRoaXMgYWRkaXRp
b25hbCBjbGVhbnVwLg0KPiANCj4gDQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvbWVzb24uYnVpbGQg
ICAgICAgICAgfCAyNyArKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gPiAgZHJpdmVycy9u
ZXQvaG5zMy9tZXNvbi5idWlsZCB8IDIyICstLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gPiAgMiBm
aWxlcyBjaGFuZ2VkLCAyOCBpbnNlcnRpb25zKCspLCAyMSBkZWxldGlvbnMoLSkNCj4gPg0KPiA+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL21lc29uLmJ1aWxkIGIvZHJpdmVycy9tZXNvbi5idWlsZCBp
bmRleA0KPiA+IGIyZDI1MzdkYzguLmE2ZjA2NzBhMmYgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVy
cy9tZXNvbi5idWlsZA0KPiA+ICsrKyBiL2RyaXZlcnMvbWVzb24uYnVpbGQNCj4gPiBAQCAtMTI4
LDYgKzEyOCw3IEBAIGZvcmVhY2ggc3VicGF0aDpzdWJkaXJzDQo+ID4gICAgICAgICAgc291cmNl
cyA9IFtdDQo+ID4gICAgICAgICAgc291cmNlc19hdngyID0gW10NCj4gPiAgICAgICAgICBzb3Vy
Y2VzX2F2eDUxMiA9IFtdDQo+ID4gKyAgICAgICAgc291cmNlc19zdmUgPSBbXQ0KPiA+ICAgICAg
ICAgIGhlYWRlcnMgPSBbXQ0KPiA+ICAgICAgICAgIGRyaXZlcl9zZGtfaGVhZGVycyA9IFtdICMg
cHVibGljIGhlYWRlcnMgaW5jbHVkZWQgYnkgZHJpdmVycw0KPiA+ICAgICAgICAgIG9ianMgPSBb
XQ0KPiA+IEBAIC0yODUsNiArMjg2LDMyIEBAIGZvcmVhY2ggc3VicGF0aDpzdWJkaXJzDQo+ID4g
ICAgICAgICAgICAgIGVuZGlmDQo+ID4gICAgICAgICAgZW5kaWYNCj4gPg0KPiA+ICsgICAgICAg
IGlmIChhcmNoX3N1YmRpciA9PSAnYXJtJyBhbmQgc291cmNlc19zdmUubGVuZ3RoKCkgPiAwDQo+
ID4gKyAgICAgICAgICAgICAgICBhbmQgY2MuaGFzX2FyZ3VtZW50KCctbWFyY2g9YXJtdjguMi1h
K3N2ZScpDQo+ID4gKyAgICAgICAgICAgICAgICBhbmQgY2MuY2hlY2tfaGVhZGVyKCdhcm1fc3Zl
LmgnKSkNCj4gPiArDQo+ID4gKyAgICAgICAgICAgIGlmIGRwZGtfY29uZi5oYXMoJ1JURV9IQVNf
U1ZFX0FDTEUnKQ0KPiA+ICsgICAgICAgICAgICAgICAgc291cmNlcyArPSBzb3VyY2VzX3N2ZQ0K
PiANCj4gRG8gd2UgbmVlZCB0aGlzIHNwZWNpYWwgY2FzZT8NCj4gDQpjb25maWcvbWVzb24uYnVp
bGQgc2V0cyAnUlRFX0NQVUZMQUdfU1ZFIGZvciBhbGwgU29DcyB3aXRoIFNWRSBzdXBwb3J0Lg0K
Rm9yIHN1Y2ggU29DcyBSVEVfSEFTX1NWRV9BQ0xFIGlzIHNldCB0byB0cnVlIGlmIFNWRSBBQ0xF
IGlzIGF2YWlsYWJsZS4NCkhvd2V2ZXIsICBmb3Igc29tZSByZWFzb24gc29jX2NuMTBrIHNldHMg
UlRFX0hBU19TVkVfQUNMRSB0byBmYWxzZSBldmVuDQp0aG91Z2ggU1ZFIGlzIGF2YWlsYWJsZSBv
biB0aGF0IGNueGsgU29DLg0KDQotLXdhdGhzYWxhDQo=
