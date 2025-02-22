Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F651C021B2
	for <dpdk-dev@archiver.kernel.org>; Sat, 22 Feb 2025 06:59:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5B91C410E8;
	Sat, 22 Feb 2025 07:59:53 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id E64D24025E
 for <dev@dpdk.org>; Sat, 22 Feb 2025 07:59:51 +0100 (CET)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51M6uq6r002602;
 Fri, 21 Feb 2025 22:59:43 -0800
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2048.outbound.protection.outlook.com [104.47.70.48])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 44xnbgjapk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 21 Feb 2025 22:59:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pl0PuUliwX+zOKOg7J9YWiKUiCKVvHp7A5vRTZXjfuX0G4sjl3zaJ9egp4VITrXYXRmV2619ZHZOgDnpLZV9n6oJbtuteMRYOUOG2+1peQ7t9aW9mkEKKMK1SSHYSk9lgJK0cIhD6BpgpPamqwUESVjMFC+VX/HQrwZU6cvE7k5AEA+9XcNoDxPIeV4yib85SYfKzWcCUxQyDq8xUB3AQXdvMoUhLjdxbJZkn6Eem+78Cju8cHI7QxNbUYATVjExPtzd2R6caq8dlvn2j1vJyJpCoizJQBy2BZKUKxLgQsbhvt64Vv94h6pCyOKI0PhU3zBRUoN8fhygr7sc2LuDIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M/cGCIBIMhHL+wS05+85jPWC9Py+0gzcmYbkenacPys=;
 b=K1Tz4Itkc26YWU9XuHPZvkKU6pGFAhTnMMi+16uv88FLsTvhvSOH7HnipwRjwlb0BX+08ydCxIAp8WsQHricFJ54JzETmJyn2rRvRzHtTkkePoONRVj8qsnxf9oEnWTrOSotVa6DHpsukJEk6jtez0IxbCMDE5ArMxiiLB9MhBb40+ElsFHgtV5q2tZH6iZSUBWcqv3XI5zxfgNrBI0doTA42MzzmsEOM4ImUNP1RGBfvrfO04UK0mo0NPCUI9XiM+jbstfg86yqXeT37xnIZDuYTR+9+Znpi6yvjLOR/uLKrmSMbqGWrdOStmiavSV37MlFJw6Kj18n9/UbnPA32Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M/cGCIBIMhHL+wS05+85jPWC9Py+0gzcmYbkenacPys=;
 b=per++4ByvzwiVCeS4ILKkpIiyck+WtyNUIHu7NZ9XgWd+MdxC5Vo9NI5ri4nwDIA4Zji72aSyLT9XuI9N3McGtfgSTp247hGiL+nK+f0Ftag2D+cgNPUhNE3SSAP4XTPsFWe0/zVTUlgyVdwCQAiww/eht89r0JBWbigU9/Xy6I=
Received: from PH0PR18MB5071.namprd18.prod.outlook.com (2603:10b6:510:16b::15)
 by DM6PR18MB3618.namprd18.prod.outlook.com (2603:10b6:5:2a4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.18; Sat, 22 Feb
 2025 06:59:30 +0000
Received: from PH0PR18MB5071.namprd18.prod.outlook.com
 ([fe80::25e:7:91b:8f1c]) by PH0PR18MB5071.namprd18.prod.outlook.com
 ([fe80::25e:7:91b:8f1c%4]) with mapi id 15.20.8466.015; Sat, 22 Feb 2025
 06:59:30 +0000
From: Kiran Kumar Kokkilagadda <kirankumark@marvell.com>
To: Huichao Cai <chcchc88@163.com>, Jerin Jacob <jerinj@marvell.com>, Nithin
 Kumar Dabilpuram <ndabilpuram@marvell.com>, "yanzhirun_163@163.com"
 <yanzhirun_163@163.com>
CC: "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [EXTERNAL] [PATCH v8] graph: mcore: optimize graph search
Thread-Topic: [EXTERNAL] [PATCH v8] graph: mcore: optimize graph search
Thread-Index: AQHbeQEyZrXOyCppGkS95Q9XTSsXU7NS/Iew
Date: Sat, 22 Feb 2025 06:59:29 +0000
Message-ID: <PH0PR18MB507108E9C176A9D0DC0868A6ACC62@PH0PR18MB5071.namprd18.prod.outlook.com>
References: <20250206025322.2182-1-chcchc88@163.com>
 <20250207013939.1783-1-chcchc88@163.com>
In-Reply-To: <20250207013939.1783-1-chcchc88@163.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR18MB5071:EE_|DM6PR18MB3618:EE_
x-ms-office365-filtering-correlation-id: 17088113-2fa5-4aeb-ebc8-08dd530e7428
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?RkwvOCs0VGJpRmtMam5EbHZudGRZMWIwQllCVEl6TUtnVFByN1VhUS8zakp2?=
 =?utf-8?B?dlZ5Vjd1Z256YTIrWEs4TzZGTkVGUldEajVDZzJKZjlwZ2pEZmlqeWxUaFkz?=
 =?utf-8?B?MWRoZmV6WThSUk5xdVBabU9vNEprTmp4bGNIY3hITHZWK05YY2s1aFZFdE5v?=
 =?utf-8?B?VFJQbk9TL3NES3VnNG01ZDhuN3BOUHFvYTBJNXNta0d4STk4OUhqdUc3WGZQ?=
 =?utf-8?B?S3pJTCtBWnRBRlUzVHpRRnNtb2UyR3prclNRODZMN1dCR04zODNkcE9KYVVS?=
 =?utf-8?B?akdHbUcvWFFWSWRzcUZqNG95REZRYkQ4dFRsQVljSmdYVE85bTdLdlpFRlBt?=
 =?utf-8?B?RmRlaDRqK1pBSm9CREd3WmxmUlZRZ2laNHRxSDN6MW1SZVdaWm9tdktzSEtJ?=
 =?utf-8?B?RkZMZ3VUK2s3WHBFUCtDSEUwK2o3OUhHQklxWDUzcVNldkJGTDcvZG5LRUNS?=
 =?utf-8?B?ZldqUFdXRFQ2dWdGWmxkK0NqOUNvNDFMMjhqVHZraDZNYWErcWdwNkNNMyt0?=
 =?utf-8?B?ZGUrMVAvbzhRRkcvWU9YeS94cFJ6S1NiSm83cDFraFU5U2N3eWFlSW10Ukw1?=
 =?utf-8?B?RzMxeFFwRzM0YkhmUFdTcVZPaFQrRTZZcHlxOTZsczBUMFlTdXBVVVlDWEdu?=
 =?utf-8?B?eGNBNS9rVXNNR3NGVkdzSnVTYXYyTFloMmc2ZFNnYjZiOGI4OXd2UWxkL2Ez?=
 =?utf-8?B?UTBMazZKN1NQTUlRNkJlRGd4eHRXZnNYMXZNL1VOQTVEdlB5TWhTeW9sMW1l?=
 =?utf-8?B?WENnVWZXeVBBUXgyVXdXMld5VWVlZGE5ZERhRjcxMDV3UXZtTHUyWkJoR1FF?=
 =?utf-8?B?MDBtN2ZNaWJ5dStERVdoYjJoMHJhWkY2dWlhdzRUVkgxcmVEN2xPNG84QThx?=
 =?utf-8?B?OU9Sc3BDVFJBUFg4aXc0VEFGcEo5WEJuNTRRcGxabkxMVEJLSTlWUy85bFJS?=
 =?utf-8?B?MXplWCtabW1OOUFmWU9CNDN6UUl1UkdVaUt3WUp4QXNIeWdmaitScUV2dGNq?=
 =?utf-8?B?RE1RTW1kNldjVlNvaCtvVjhrakJ6UldhTWYyNTl5QzIrSnZNNlFlMnFBcmhU?=
 =?utf-8?B?ZHBFenJXcWNGZWlhQWVkQ3ZTblBuYnpTRlJGMkd2L3JHVFZUd2xYeVgva1FU?=
 =?utf-8?B?YzdFWDMxcG5xc2J2K0M4ZUx2TFBRRmtuMG5tRlNVNzZRd0lSUThJMGVvOTha?=
 =?utf-8?B?SGQvallMSzRqdW1kMTY4Rkt3QWpWWngvdnJXaEZRQWl5RGFIb01EL05OQWx5?=
 =?utf-8?B?bUtwSTNpMmo3M0pMdUlDNmxVRHRMaVRCQy9UT0pyQ0FzR0ltanRjcGpqdHB6?=
 =?utf-8?B?R2pjMTVadEozLzF1akZwU1VjcDhlWk1lQ0tvelgzbXVsUmRHSEtvM2VJUDRT?=
 =?utf-8?B?R3VESTkyc013WmtlVWZMWEpXY2ZFbGgxQjlaM2NPdmsxTkFLSCtEMVRERmJl?=
 =?utf-8?B?d2lTU1U5YzFremxvUXFabkFwOE1WSFB1MTIrVHAzREVkc1RtazNGODhMZHZp?=
 =?utf-8?B?UkwrYlFWK3BhdkRVeU1JZWVPVm40dFRnRjRZWE9NZnNJUGxscTJ5U0pjS3F3?=
 =?utf-8?B?WDZHUzI3MHM0RkowOVU0eVZ0VWpVbWNnR3k3SFk2bFh4a1dQZzlhRTJVV3A5?=
 =?utf-8?B?WG5saU00K1hVZkNpSXZuY3pxSHo3TmJhYnhxUlRNQ1BUL2hIVnF2QXl3MFdU?=
 =?utf-8?B?NXZlVzdaTjhybXdkSWJZTDUybFROVTg1QzZhMHdHL01ra2VSb05HNlAzZWNB?=
 =?utf-8?B?Y3hFWW9CNk9kWFl0QnczdVk3ZUFJdjg2Q1dVZm9oMEJDdytWMnRjWW1yUTFl?=
 =?utf-8?B?SWNiWXNURjF6Z3N3cXhBQnoyWlUxN2VuUW9ZWVVOSG5NM0JLNEV0MnhxdmNZ?=
 =?utf-8?B?MytmZ0ZJdUVHQjI1TEQ3cDV6YkhxS0tGVXZjcG5Xb1RycXc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR18MB5071.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S1h1b3dXRng1SGFtU2ZkUXFiejJNcEhWVFRkR3MzZ3BZa05kRlV1Skp5dThr?=
 =?utf-8?B?TlFTNWpBQ08rSW5RcHowM0RkZkRhSFRHWVZzYnBVa1U5eUZOcmdrMTQrTFFI?=
 =?utf-8?B?RTg2SzhUVjcrWmZ5OHdFOU13bFNFUXJDZ3k0T0NFV0VyZzArMTUvdEhrNEcz?=
 =?utf-8?B?L1JXNnYxZDJ6bFZFTXhBcW55NHh3MVJRZm04TXg1eFR6QWJvZXpMZEN3TVZs?=
 =?utf-8?B?V2VtMGlEVVFZRHk3eXQwcU9DQ2JzRXU3bUlHbmZDUkp3ZTFNTHdneEJ4M0pI?=
 =?utf-8?B?Zk9sZktUSmYxTWxTSThOQU5sYnJwMGkwYmlJS2VicFVERTVOOENKQWdwNmls?=
 =?utf-8?B?VmxoTkRnczR1VTNDVmFQQTc1K2JhNWFMdTdCekx0YlRXNmVzTnRYSFRueWlQ?=
 =?utf-8?B?ckNSL01jOTBEc0RnSm4rNTllSExtZFFKNXhBSWlib0prY3lYQzMxRXF2RTBY?=
 =?utf-8?B?czZiaXhzdjJXbWxjUGc3akdnOFhDMlMzYnNDQit4Q3hRN2FNQzNDT3NsaTQ3?=
 =?utf-8?B?WWtnZlhxWFpHMm5qMEVOU2w2TFJ0NEo1c3ZueklWeU1DdGRPZ0luYzNRQ1Z1?=
 =?utf-8?B?SG55R0xlYjZhN01jcy9sc3VHaUZVcjVKN09FUGpPb0hmdU45NjVpckV0L3Np?=
 =?utf-8?B?Yyt0NTVwcFJkanhjaVhtTEUvUzdYaUlhY2VyUWpUd2ZOLzMwUDZjU29xNlhX?=
 =?utf-8?B?dFl1QWFHVGdWUndkUUhKM2UxZ2I3RUxjY0F3NTU1OUpFWjEzdFh0d1pGOUtn?=
 =?utf-8?B?bmdpMWtNK3RlanVsTGpUSFA5N0V4NFdYYkdTQ0JzYU82bG9KVFUzNEh5SmR4?=
 =?utf-8?B?TnFRSlJGdTJrcjBWSVFlRnNaa2xSc0Z6Q2pWMks0eVYrK3gwZThhWTRMVk5W?=
 =?utf-8?B?Tm5tNW1ZK2VWR2VtVHFMMmUydXRhbldxU2ZmU05DRGxsUHA3WW1nVXlFeDFw?=
 =?utf-8?B?b0hoRUlZdDZUNHd4V0k0TThVR3ZlSzdGVTJsMnJDY3BjVENKRzdVTk8zYUdx?=
 =?utf-8?B?WmY0VFdaQ0pPTldGdGdDc2llTUZYS2dJUlFHUkRKOU15eitWWjZvbDVGL1lR?=
 =?utf-8?B?WXVLMjFqd01SUzg4d2JPWUkrRXpvdmdOeHhIQi90Vy9wbWpvQ2hMaWMzZkQr?=
 =?utf-8?B?clJrR1cwNVh5elJwVU9aSzZVR3Fod1pyWWdjUmVIS2gxeDRiV01FSHdOQ2xz?=
 =?utf-8?B?cnhmSSsvbFBOYTBwMGkxTVhpRk4xckYwZ1JjcHRKekpQSGc2cERtNWtqQTRD?=
 =?utf-8?B?aGtRQUV2T0labGx4MzNEZVRqNjJhY3RDc1N1QmFDcitnVEdGWnlsaXRxdGs4?=
 =?utf-8?B?ZWZqZnV2WnZQU1E1Ry9wdWJQUDNlbWpremtCZWdGdU95V3hVL24yYkwyRXZs?=
 =?utf-8?B?OFR6MERoZ00zZ1UrK2l2ZFFWaHVoUEpRQkVMZUtCZmRwSG0vWjVPVmF2OXRM?=
 =?utf-8?B?eUx5ck9pOEs5RXphYTN0amNwUlczQVlxdUVXM2tieklxME04VitOcWFHZDZl?=
 =?utf-8?B?a2V3NjVPZnpVT2lLTmxRSUppV0ZTWTFVcEd0bnZWZitKZm55QlE5UmRGUGpO?=
 =?utf-8?B?QkgwUVV2MmJCYlNUL0JrcWdZSXRHM2MxMUtIeWpCUHVORi9pMWFTZkNXVHFL?=
 =?utf-8?B?TGs2bXBBVFBLTWhjelRac1E4RllDNC9XUlRKd3RzdFJ1UmdPVDhXS0RaVlhP?=
 =?utf-8?B?a2NVa2p2eC9yc2o1and6MEF3UUtrTDg2aG11NVNwZExRN3JOV2hPUDc2RkVW?=
 =?utf-8?B?alR5NmljZTlVMS9na3kvL2d0VEJWajV6aENWa3Z6MFJXL3ZneUpLdDVIeTlz?=
 =?utf-8?B?OGdsRVFudEJQTE5aYjBQeEJrYkZER1d3K2FZeUx5OGpISlVpWlVMTjhrMjRr?=
 =?utf-8?B?V0h3T1J1T0E4VFdmY1BqMU8zcy9mY21hOGZJQlFaSmtEV2krUUxyR2lEbVJk?=
 =?utf-8?B?ODY3cXg0amlWYlYzRVFOTUtZNHZWcHlybHBwckNMODhSTW1rc01mc0tLWGl2?=
 =?utf-8?B?TGIxNlRHdjdQMERJZVo0SEtrdXBnWWJrZVI1cGxDSDNkM0xQNDByWStmNVBE?=
 =?utf-8?B?Sk8ydzVSZjhubFpLdVQ3T25XblN6OHFSMWw2OG9COEY5blVsZzZ4dVRlZVJW?=
 =?utf-8?Q?KhEBn2yNsuULUFpqWtLHCykRW?=
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR18MB5071.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17088113-2fa5-4aeb-ebc8-08dd530e7428
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2025 06:59:29.9484 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 14wvvN4Q5MKsC7Lo5j3XAlgCfpoeC45DJBsl4z8CWjfN0oE26V3L5eY05KmJWAThIWQ4yw5KiOVyh4OVbtpX7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR18MB3618
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: Kl_QuQE2h-y-DtOL6Sqs6fHZziB8RFRi
X-Proofpoint-ORIG-GUID: Kl_QuQE2h-y-DtOL6Sqs6fHZziB8RFRi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-22_02,2025-02-20_02,2024-11-22_01
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



> -----Original Message-----
> From: Huichao Cai <chcchc88@163.com>
> Sent: Friday, February 7, 2025 7:10 AM
> To: Jerin Jacob <jerinj@marvell.com>; Kiran Kumar Kokkilagadda
> <kirankumark@marvell.com>; Nithin Kumar Dabilpuram
> <ndabilpuram@marvell.com>; yanzhirun_163@163.com
> Cc: dev@dpdk.org
> Subject: [EXTERNAL] [PATCH v8] graph: mcore: optimize graph search
>=20
> In the function __rte_graph_mcore_dispatch_sched_node_enqueue, use a
> slower loop to search for the graph, modify the search logic to record the
> result of the first search, and use this record for subsequent searches to
> improve search speed.=20
> In the function __rte_graph_mcore_dispatch_sched_node_enqueue,
> use a slower loop to search for the graph, modify the search logic to rec=
ord the
> result of the first search, and use this record for subsequent searches to
> improve search speed.
>=20
> Signed-off-by: Huichao Cai <chcchc88@163.com>
> ---

Acked-by: Kiran Kumar Kokkilagadda <kirankumark@marvell.com>



>  devtools/libabigail.abignore               |  5 +++++
>  doc/guides/rel_notes/release_25_03.rst     |  1 +
>  lib/graph/rte_graph_model_mcore_dispatch.c | 11 +++++++----
>  lib/graph/rte_graph_worker_common.h        |  1 +
>  4 files changed, 14 insertions(+), 4 deletions(-)
>=20
> diff --git a/devtools/libabigail.abignore b/devtools/libabigail.abignore =
index
> 21b8cd6113..8876aaee2e 100644
> --- a/devtools/libabigail.abignore
> +++ b/devtools/libabigail.abignore
> @@ -33,3 +33,8 @@
>  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
>  ; Temporary exceptions till next major ABI version ;
> ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
> +[suppress_type]
> +        name =3D rte_node
> +        has_size_change =3D no
> +        has_data_member_inserted_between =3D
> +{offset_after(original_process), offset_of(xstat_off)}
> \ No newline at end of file
> diff --git a/doc/guides/rel_notes/release_25_03.rst
> b/doc/guides/rel_notes/release_25_03.rst
> index 269ab6f68a..16a888fd19 100644
> --- a/doc/guides/rel_notes/release_25_03.rst
> +++ b/doc/guides/rel_notes/release_25_03.rst
> @@ -150,6 +150,7 @@ ABI Changes
>=20
>  * No ABI change that would break compatibility with 24.11.
>=20
> +* graph: Added ``graph`` field to the ``dispatch`` structure in the ``rt=
e_node``
> structure.
>=20
>  Known Issues
>  ------------
> diff --git a/lib/graph/rte_graph_model_mcore_dispatch.c
> b/lib/graph/rte_graph_model_mcore_dispatch.c
> index a590fc9497..a81d338227 100644
> --- a/lib/graph/rte_graph_model_mcore_dispatch.c
> +++ b/lib/graph/rte_graph_model_mcore_dispatch.c
> @@ -118,11 +118,14 @@
> __rte_graph_mcore_dispatch_sched_node_enqueue(struct rte_node *node,
>  					      struct rte_graph_rq_head *rq)  {
>  	const unsigned int lcore_id =3D node->dispatch.lcore_id;
> -	struct rte_graph *graph;
> +	struct rte_graph *graph =3D node->dispatch.graph;
>=20
> -	SLIST_FOREACH(graph, rq, next)
> -		if (graph->dispatch.lcore_id =3D=3D lcore_id)
> -			break;
> +	if (unlikely((!graph) || (graph->dispatch.lcore_id !=3D lcore_id))) {
> +		SLIST_FOREACH(graph, rq, next)
> +			if (graph->dispatch.lcore_id =3D=3D lcore_id)
> +				break;
> +		node->dispatch.graph =3D graph;
> +	}
>=20
>  	return graph !=3D NULL ? __graph_sched_node_enqueue(node, graph) :
> false;  } diff --git a/lib/graph/rte_graph_worker_common.h
> b/lib/graph/rte_graph_worker_common.h
> index d3ec88519d..aef0f65673 100644
> --- a/lib/graph/rte_graph_worker_common.h
> +++ b/lib/graph/rte_graph_worker_common.h
> @@ -110,6 +110,7 @@ struct __rte_cache_aligned rte_node {
>  			unsigned int lcore_id;  /**< Node running lcore. */
>  			uint64_t total_sched_objs; /**< Number of objects
> scheduled. */
>  			uint64_t total_sched_fail; /**< Number of scheduled
> failure. */
> +			struct rte_graph *graph;  /**< Graph corresponding to
> lcore_id. */
>  		} dispatch;
>  	};
>=20
> --
> 2.33.0

