Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC889C021A4
	for <dpdk-dev@archiver.kernel.org>; Fri, 14 Feb 2025 15:59:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B6AB04064C;
	Fri, 14 Feb 2025 16:59:39 +0100 (CET)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id AC37940647
 for <dev@dpdk.org>; Fri, 14 Feb 2025 16:59:38 +0100 (CET)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51EAO6ax021584;
 Fri, 14 Feb 2025 07:59:37 -0800
Received: from nam04-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam04lp2041.outbound.protection.outlook.com [104.47.73.41])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 44t41n8h0f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 14 Feb 2025 07:59:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jG06f+xfSAQlgg2ogvO8VVD25t6KWcdLABm2wTSR+KM25MdkZHbxXJODmx8Euah9D9E5PqisUuEuSxrSxQ9H+GR5ZndX4zsUN+qhk9MU21hhFAWTNPTbBmx9CPOjw2ELfH4BLJUCc1VuQIm8Z6X0jVWX90jgy+xTIAA+hhbFvrxmQpNJjU+wT6hvX51M3b1iTTolFtqQHHbUDSHod2wCdyr9K506zQzxnlb4WRjwv2TKLXyHJmE5RzSpVGAVT3dgKxDxHxylCh7rf/5kKduB5YAxnnRooau9DQ9r/byS0wVrEA3T461oJ4xSbQsBqaFWpXjAON9LIs3MypkkeXBXZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ComiOjsknWE34AfzKETiiTXmp3UttlUtP9SzkEKybCA=;
 b=l9eejE/PPySycfSgKQgMQFshRFgGFFvo4KjmlZYE8Qoy4I0/6mB5Y88k+PGF01tpF1y1Xe+tq10vNRSKeuq6BG3ZKM1U0HUKTPaB3Cnn5uRM6cy71LrxFRnnjV6ymMQIqisbsQpp90KnIQqdqpUl/RlN8gcCs7+oriEQxMd9dObv3UHBEoF3U2aT4RY8PvctNixO4L4W+ZZRndEu3ZgyJjWrhcUO5J9APjve0tmYbHMRu7Z+XxMspnh5LV/TsW4mcYi34Y7e+4mexmcc06gHC4lswsZbZGKXzydoLUFahecM17KqlEDO9M4zgf0W627BcZwHc3s9CtMJqFC8+Hum3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ComiOjsknWE34AfzKETiiTXmp3UttlUtP9SzkEKybCA=;
 b=KGRJEDqioziDJk4hknAhxTyrwJQRfgMs3+bTL/Dw8Z+4HxeVAwmRYVlh5RCqKpbVeZyYFmQqvug7etPs6NWOKayUWw2Z5T6igiRmN3qEwsFKqi3X98m2opnTI20MSiyP9ulwdmmjJd0bvySSDWtNihfr0qVIjHrDykQfr4NxocM=
Received: from PH0PR18MB4086.namprd18.prod.outlook.com (2603:10b6:510:3::9) by
 MN0PR18MB5998.namprd18.prod.outlook.com (2603:10b6:208:4ca::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.19; Fri, 14 Feb
 2025 15:59:34 +0000
Received: from PH0PR18MB4086.namprd18.prod.outlook.com
 ([fe80::ed37:4ea0:6359:f717]) by PH0PR18MB4086.namprd18.prod.outlook.com
 ([fe80::ed37:4ea0:6359:f717%3]) with mapi id 15.20.8445.016; Fri, 14 Feb 2025
 15:59:33 +0000
From: Pavan Nikhilesh Bhagavatula <pbhagavatula@marvell.com>
To: Luka Jankovic <luka.jankovic@ericsson.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, Jerin Jacob <jerinj@marvell.com>,
 =?utf-8?B?TWF0dGlhcyBSw7ZubmJsb20=?= <mattias.ronnblom@ericsson.com>
Subject: RE: [EXTERNAL] [RFC PATCH v6 1/2] eventdev: add atomic queue to
 test-eventdev app
Thread-Topic: [EXTERNAL] [RFC PATCH v6 1/2] eventdev: add atomic queue to
 test-eventdev app
Thread-Index: AQHbbka3xSZpDZj+OUa6u1PPzCklObM3YdVAgA9PrICAAGSnEA==
Date: Fri, 14 Feb 2025 15:59:33 +0000
Message-ID: <PH0PR18MB4086E14E19F6767BD7D3B499DEFE2@PH0PR18MB4086.namprd18.prod.outlook.com>
References: <20250115133844.1403623-1-luka.jankovic@ericsson.com>
 <20250124095937.1436673-1-luka.jankovic@ericsson.com>
 <PH0PR18MB40860FA2D8B571B3F0FB0818DEF42@PH0PR18MB4086.namprd18.prod.outlook.com>
 <8c8c0d1f2a82ff5097cd6dd0d8395c4a2741df66.camel@ericsson.com>
In-Reply-To: <8c8c0d1f2a82ff5097cd6dd0d8395c4a2741df66.camel@ericsson.com>
Accept-Language: en-US, en-IN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR18MB4086:EE_|MN0PR18MB5998:EE_
x-ms-office365-filtering-correlation-id: b36ee74a-8237-48a3-16f7-08dd4d1092fc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?SllaRGhtWXcxK2pPbldPOU9Xb01ieitJWVdiZ3JScE56UThVVStVWGp6cGJp?=
 =?utf-8?B?UGhlTVNZclhDNDhNdys5a3c2M3FYbno1dUFpMmIvOW5abWRlWkgvTWIrU2RZ?=
 =?utf-8?B?NSt1b0F2TitPUFIrT0FaOWx4TWdMSUpJaVUvMlRGMzlPMEhBOUNFRFBULzlD?=
 =?utf-8?B?TjlZemxhZGFMQVRsR1ZKak4zakVuUkJIWUsydWZFQWtiOE81N0RRM0JNL0M4?=
 =?utf-8?B?a2h0cXdOb3ZYMkp1MHFRZ3I4MXNMdi9xVFpmTUdONnJ3NUpVWitxbUlQQVlU?=
 =?utf-8?B?cm9NV3dQVXVTV2NLK2hhbU55aDcrbkhvWnA0WFFtU0VIUG5zUzBXOUlRSldK?=
 =?utf-8?B?Z2JZT2RVeVl4RmdKaWlPOW45dzdNcktETHRlWkNOTG9RUWM3U3U4VzhPWklP?=
 =?utf-8?B?SzBVcit1R0xyWFRGeFEvRjZsbGpzOXZCcHU2VFRUcWd3Z1RENTBzWWd6SVY5?=
 =?utf-8?B?ZXp0Qm9rV2JBZHc5azdaeHp0ZlhCR0g2U1RhWDZzL2NQdGdPSEU5em5lenk4?=
 =?utf-8?B?SWRyNTBFVUtRc05Xa3ZvTE9BWkhDMXRzdnNLVFlOSlQxNXVyRVErRytmWkhY?=
 =?utf-8?B?bUpiWE94dTlmOFArNTBzWVJRNzBNem85bUQvTHp5R3hrWENBc2ZEdVlGSk1v?=
 =?utf-8?B?NGIzSHVsbXVKYzh1ZkFTU0JaOHNxOVNTTjFPNDEwZmpIa2xCNURqUEs4U0FP?=
 =?utf-8?B?RkNtcXNaUEI3cTl4Q3FHM28wcWtqa3EwQndBcWQ4LzZwMkNEdGFBK2x0eDlj?=
 =?utf-8?B?SURTM2dhMzV1WHRBbWt1S3Fnd09Xa1pUYmNQdHVEVUJiUjYyNmRSdWhhS3N0?=
 =?utf-8?B?SGJkbTdRRUQ2MFZ3MitzczQ4QmhJNWl4MW5mdXJQT01ZSS9JbmEvWm5xLzBv?=
 =?utf-8?B?dFNFV2RzWXVrbGswUURXY2VTdndRU0VjdE5nN3F1MytEckdYRmVSQUVSbzF5?=
 =?utf-8?B?VnplSW9JaFF5NkVFZTZXdzZidG5NQklLTDZGMFFpMVBQUGx0SUQ3cXpGaldB?=
 =?utf-8?B?TVp4dmhlWklPMWgzeUEvenBTeE1pRSswTmxZTTBBbjJhdkVSZkU3cy9la1hI?=
 =?utf-8?B?MjBrNzgzSExXMmNaQmFtUzI3c2FERDJDM215U1J4RmppV0lMVjJZWlQ4cjRS?=
 =?utf-8?B?Y3pnUW5hWm1iTmYyZ2pQYk5XTUswVUdCaG14TlRMby84MGRJQjF1R3JSczFU?=
 =?utf-8?B?NTh6MU5XVGpQR2E4a1ZEZnFVL1didGZmS3BVc3Z5MEdUeVh1R2F5QUlrTWIx?=
 =?utf-8?B?NGlvcG9RQVVLekdoTHNubHRaMWloMUNxRzFldnZEMFVQTWJoeWpBclVvMlVx?=
 =?utf-8?B?UTRuSVdQNHlqdmFFUUVxNTBjUGsxcGxXN0QzUmZnY3lucG5LakllUkpNVEh3?=
 =?utf-8?B?Z0E4ZDZkS2dFN3FnZ3NxTy9SeGpCU3R5RktQRXlRZGxVN3pIbUZJRjB0MzN5?=
 =?utf-8?B?c0tER0ZzZHpFaTFHcGdOUHBhbmlRb09FK3lXMXB5ZEJYN0pkQWhuUHBCT3Jj?=
 =?utf-8?B?N0ZCTm8vbWM4bUU2T2daWTIwNHcxTCtVMXlHTFF1VzdZTzJVbmxZTzdmS2h2?=
 =?utf-8?B?VjJla3lRRm5zMlQvRFltTzJMM3hDdUMzVitRanJJd3o5eDI1b1B5bFZrTkpy?=
 =?utf-8?B?WW4ySEFPRFZLV1k1UDQyY2twZUoybFloZm1tV2pQRlk1ZHRqdTBLUS9vSmox?=
 =?utf-8?B?NzdXTTNoL2FNUEtXb3RGdktRaFR1eUlKak9MVm1ETjBUcW9panFGR3dYU0JD?=
 =?utf-8?B?TC9meWV3WnhLS042eG1zWW03OHpzSWJxc0ErbnYwaDAyWFZ4YjZkNmNFSml3?=
 =?utf-8?B?RExqTWFibW0rZW1DTHE2K1pzWWFIYnArU2JaUU5EUXNPRTBBQUVtQU51akNi?=
 =?utf-8?B?Y2lwS1U4VWhzN1E5L0Zwb29xWlZZbGlvVWJtNEpOOUlSR2FXMWxWaDF2bHVB?=
 =?utf-8?Q?IK45D3MgCK9G3sJSP5XpjDGvdvQscNCv?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR18MB4086.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?akY1aXdkSWpMNUxQQjQvbzIwT1NHNzR5V1RyMEEwa2RlZS9GTnJET2dHQnBN?=
 =?utf-8?B?Rm9BWjhob1YwM0x6R1VKMmJqTzk3SFZleERWdk5CZzhpTFFFT1piQzVraDll?=
 =?utf-8?B?RnlWR051dzY5RkRsY1cwaDNJTC9jWGtzZnNpaldUTTUwbXowbHJsbUFISXE4?=
 =?utf-8?B?dXFVQjJFaXdCcVBJdmZJT0NFZFh5Tk9zMU5oS3dWdHJNY0FER2FyVDd5VXRi?=
 =?utf-8?B?eTdxSVVTV1IrVDdoZFUwNVZ1Vmg0OElHODhNUitjUFJmRDBOanFHWVNSMllS?=
 =?utf-8?B?SGNVeG4xNmxpTkV6MVpralZ4YXFUTHB0d1Iwb05RWE43Y0szaFFJOUo0K2Z3?=
 =?utf-8?B?Rk1SdFliODlsVTFlOGh2eEJxa2RMM2FDa2pHbHhRRUZFcXRkS2hkbzU1empX?=
 =?utf-8?B?N1QxN1NncjF3em1sbDdIMFJhZVh5NlI2QUorSUdGWUIrSUdQSFowdndtKzFt?=
 =?utf-8?B?Z0FxWVRFWDNqSmR5WUs2TnVFTnBvaVlkUWI1K1ZrN3JTQ0lyNHhkWkNhczFF?=
 =?utf-8?B?Q0dtZlBUNzl5d2xTNDdXbk9iUmxUUGVUU3hSL2pJR0tDd0FLM1Vva01LMmd1?=
 =?utf-8?B?VmM5N1h4WmFNVlRkdG1hQjJCejBQQ3F1WXoyNlg2dE9EcFl1Q1dzNlROaS8r?=
 =?utf-8?B?K3VCSWJUaWRneVIvOEdLU05xVWg3K0RmcUNJZGpxTVBpMDhFb0JlcWNxTXNu?=
 =?utf-8?B?bHlMcHFXREtNcTIxSHJFd1dRaFhKWVNSVjNpbnJTUXZ4UzRQeG55TmhJdDJ2?=
 =?utf-8?B?N2JMeElVelNFMU11WlEzMlVSZ0xQR2t0RytJc2JVUlVjMndrNjRVMExuOEpG?=
 =?utf-8?B?aDRKQzdNY285S25hRk8zdkNmM0VWT2Z0V3FDbEx0TldlNjU1L3JYV01VQk5W?=
 =?utf-8?B?MXFTWTVPeHRsbVBzZjh6em95bXRXK0MwMkJrc0lqQTFBVDQrZ3FSZVgzbXk0?=
 =?utf-8?B?MnFVQU5kaGRVRHBLc2JuWXhqQmxLSit2bDZQZFVhVjJ5cnMyWFQ5WXNHbnhj?=
 =?utf-8?B?VkRIWGtLWGlzZG1sUGxsaytHNFdzdUsxNHBoa1FUbEdXNEQ2ZE93RzlLc2kr?=
 =?utf-8?B?V29GU015K2pyZldzYUpVZEgxZjJUYzlVdDBtMFBhd1luM1VDSy9qb2hrVnNK?=
 =?utf-8?B?VVE3cFNZL0xOdzZkVGJCby8yVk50c3V4WTUyTDdXRWpoR0J6N0RvcFpkaFli?=
 =?utf-8?B?OGJZMTl1UDBqS05IOGo4aDFTNVlhWU0rNUVTcHFISjc2T04yUE1LZHpDNDJo?=
 =?utf-8?B?Si9nbFNjOEUwMnVYZGFzSjdCdlhHd01KdnZNNHlzb2hhZmdCeDlBZVc5U05D?=
 =?utf-8?B?QUNiaktkRG1QZHNGbm9XaGIwVVBFTzVkbE1XTWNrSXBqN0tNblRsK3B2K3B1?=
 =?utf-8?B?Um5tNG1OckgxS3hNZWFhRW8xYUlhQU1ZVHg2bzE0bndCaVA5dDU1U3FPd1o5?=
 =?utf-8?B?QXNKek9vS2padkxjQUtnYURmOUY1aTczODRseHBEeDdEa1FSSVlRalUrNmY3?=
 =?utf-8?B?ZEhNRDBVQnFTUnZ5ZGdvUGxoSVN4NS9qVzZtQVQwOWl2RlExV3JFSXJaUHIy?=
 =?utf-8?B?d09wZ1dmT3B1dUlYcVBBaFd2ekZrekhSZnl6dTJ6cms2a1NZYWg1QjBvemoy?=
 =?utf-8?B?Z1hJU2xlOC80R0JUb1huQmg0NzMwV1J0aER0a3VDcW8zd1I2d0Z5STRtR2Iw?=
 =?utf-8?B?NTNhN0Y0a0pGZ1RtdWJRekZaaS9tNmFvaGJLdW5UbHRQK0FERmFFQ2I1ZmRh?=
 =?utf-8?B?L2QzdThOMzBlU3JYd3podTdxWGRIeWh2U1J4T1FnMGd6Vk11cGJOSlMyRVg0?=
 =?utf-8?B?RjZ0VWM0N0NOMVNiZkhJKzJ4WjBTQk96cUhCakdmVlhLWnJxSG5WcDZEYytv?=
 =?utf-8?B?bUNXcHJDYTQ0d01nRFFXc2tRcS93enQvR2RadE5vbHFaUG5rbkJGQmUzUW1X?=
 =?utf-8?B?QnkzdW1lWWVjWWJGMzBDWk05STUvWWxvZTdYajBxdVFiMVh4RGppeE1GeVBz?=
 =?utf-8?B?VXd5T1gvbmVzc1VmY244WEpNelRCOVJwZ0JyNnNTNGVsT0ZzMk8rQmtxbkh2?=
 =?utf-8?B?Vis2elRLN1pmckZ6N1lkc3NOU1pNUHlSaWMxaWI0M3IwdEJEd1djMC9GNmhY?=
 =?utf-8?Q?kn3Ih6uGYnv2vzKDvXW7Rmlw8?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR18MB4086.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b36ee74a-8237-48a3-16f7-08dd4d1092fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2025 15:59:33.7161 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qCunGfkxaPNr9zgY4k2NQGGa1NO2tnOjhcd8tz4sBUB2LabWBnWevv34iBY8BYNo1hXzdQc+NOQnH77Z9eEBXtvV7+ncCI2GqqhMEM1hOBA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR18MB5998
X-Proofpoint-GUID: AsJ7zuy_rwj2J4SV2h441X-0JI8PjM_g
X-Proofpoint-ORIG-GUID: AsJ7zuy_rwj2J4SV2h441X-0JI8PjM_g
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-14_07,2025-02-13_01,2024-11-22_01
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

PiBPbiBUdWUsIDIwMjUtMDItMDQgYXQgMTY6MTEgKzAwMDAsIFBhdmFuIE5pa2hpbGVzaCBCaGFn
YXZhdHVsYSB3cm90ZToNCj4gPiA+IEFkZCBhbiBhdG9taWMgcXVldWUgdGVzdCB0byB0aGUgdGVz
dC1ldmVudGRldiBhcHAsIHdoaWNoIGlzIGJhc2VkIG9uIHRoZQ0KPiA+ID4gb3JkZXIgcXVldWUg
dGVzdCB0aGF0IGV4Y2x1c2l2ZWx5IHVzZXMgYXRvbWljIHF1ZXVlcy4NCj4gPiA+DQo+ID4gPiBU
aGlzIG1ha2VzIGl0IGNvbXBhdGlibGUgd2l0aCBldmVudCBkZXZpY2VzIHN1Y2ggYXMgdGhlDQo+
ID4gPiBkaXN0cmlidXRlZCBzb2Z0d2FyZSBldmVudGRldi4NCj4gPiA+DQo+ID4gPiBUaGUgdGVz
dCBkZXRlY3RzIGlmIHBvcnQgbWFpbnRlbmFuY2UgaXMgcmVxdWlyZWQuDQo+ID4gPg0KPiA+ID4g
VG8gdmVyaWZ5IGF0b21pY2l0eSwgYSBzcGlubG9jayBpcyB1c2VkIGZvciBlYWNoIGNvbWJpbmF0
aW9uIG9mIHF1ZXVlIGFuZA0KPiA+ID4gZmxvdy4NCj4gPiA+IEl0IGlzIGFjcXVpcmVkIHdoZW5l
dmVyIGFuIGV2ZW50IGlzIGRlcXVldWVkIGZvciBwcm9jZXNzaW5nIGFuZA0KPiA+ID4gcmVsZWFz
ZWQgd2hlbiBwcm9jZXNzaW5nIGlzIGZpbmlzaGVkLg0KPiA+ID4NCj4gPiA+IFRoZSB0ZXN0IHdp
bGwgZmFpbCBpZiBhIHBvcnQgYXR0ZW1wdHMgdG8gYWNxdWlyZSBhIGxvY2sgd2hpY2ggaXMgYWxy
ZWFkeQ0KPiA+ID4gaGVsZC4NCj4gPiA+DQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBMdWthIEphbmtv
dmljIDxsdWthLmphbmtvdmljQGVyaWNzc29uLmNvbT4NCj4gPg0KPiA+IEl0IHdvdWxkIGJlIGdy
ZWF0IGlmIHlvdSBjb3VsZCBhZGQgYXRvbWljLWF0cSB0ZXN0IHRvby4NCj4gDQo+IEkgd2lsbCBh
ZGQgYXRvbWljLWF0cSwgYnV0IEkgb25seSBoYXZlIGFjY2VzcyB0byBzdyBhbmQgZHN3LCBzbyBJ
IGFtIHVuYWJsZSB0bw0KPiB0ZXN0IGl0IGxvY2FsbHkuDQoNCkkgd2lsbCBoZWxwIHlvdSBvdXQg
d2l0aCB0ZXN0aW5nIG9uIENOWEsgd2hpY2ggc3VwcG9ydHMgYXRxLg0KDQpUaGFua3MsIA0KUGF2
YW4uDQo=
