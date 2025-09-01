Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ECC5CA0FF0
	for <dpdk-dev@archiver.kernel.org>; Mon,  1 Sep 2025 05:05:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4D0244029C;
	Mon,  1 Sep 2025 07:05:52 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 57D554028B
 for <dev@dpdk.org>; Mon,  1 Sep 2025 07:05:50 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5810vdNw022526;
 Sun, 31 Aug 2025 22:05:49 -0700
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2124.outbound.protection.outlook.com [40.107.237.124])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 48v0tha5v7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 31 Aug 2025 22:05:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M1PypunMnmZ0MxfDL8Du8pa6JV84Cj9aGVojM6HctDgmjuBI53vJzKAu+z0v8gywcO5sEwCUWxtHlTKMke8b8vmESq9JlZQn38rXYbavYpF9YoF9S3eT02nLZMrJ/deMB9M/l4faRpCoI5LopwmGN4reAVMHFsHmbNMKQby9Z7e+74Yg7+jlX0Mr2zYDnCjRHoSQ6lnBuM+RIY332YZVflb46s8/OBgixdnaqwnAC6nT+9zDUQ2VUwwei4+RPW30kWmucM9dfNhRlehHXY2z8FLbodG4ycMT+RoFRmbkuNLKOx9FXn2O7LPR0ks2KCgVDuhiANBdt+4DRryHVvIWDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gj93A/EV8I4+pcjZqhXnGgBzT7g3E7wKeT+5RXjtUps=;
 b=pec51iNvm6YEZ2ojQINbmEpepGWqwwJU3TIwGdXTpjz3zjut52LiC23JfhxTlu60edFTaGy4yj0WysPEdzSkIos8gajnEWrG1G0TlbiMPdTn3cYayQucEeCrA/zTWj5ocCBO+VhVNlKY+BcMbzHnwBSvPPb95ocELsYUW7Ku63lTwj6FAo1dNCq4too8yKl/WHQaZB5wIaeNd4QHhbEM/hRqZkS858kI1mGbJqadDgkpm4edfyshmL77tV7Jh9eiIs8CUkhdIU5uhOqR3n0ku3dH3lI5fO86c76Wc7DLM1Sit+xD0QFs9Q4y51GbygStU6f3kxr01/0YbjyX7Hzb+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gj93A/EV8I4+pcjZqhXnGgBzT7g3E7wKeT+5RXjtUps=;
 b=fG5g9Nw9g2GVqMV4j94RoY0Rc8Rtldph1kw6jZmkLG1esUxWnobNLO+RW7gIdPDjmSvfiJReYPJJJatt50xxemIhJ3HFS/+i8AuOSctJBMYm7VGl8lYBce8u2fMsuZ9bmMZk46ZOrlubeLKQvUI3BpAYZRZPRtQezKkQAGeym1c=
Received: from SN7PR18MB3869.namprd18.prod.outlook.com (2603:10b6:806:101::9)
 by DS0PR18MB5269.namprd18.prod.outlook.com (2603:10b6:8:120::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.26; Mon, 1 Sep
 2025 05:05:47 +0000
Received: from SN7PR18MB3869.namprd18.prod.outlook.com
 ([fe80::d55a:768f:3d17:7cfa]) by SN7PR18MB3869.namprd18.prod.outlook.com
 ([fe80::d55a:768f:3d17:7cfa%7]) with mapi id 15.20.9073.026; Mon, 1 Sep 2025
 05:05:47 +0000
From: Sunil Kumar Kori <skori@marvell.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: Thomas Monjalon <thomas@monjalon.net>, Andrew Rybchenko
 <andrew.rybchenko@oktetlabs.ru>, "dev@dpdk.org" <dev@dpdk.org>,
 Nithin Kumar Dabilpuram <ndabilpuram@marvell.com>
Subject: RE: [EXTERNAL] Re: [PATCH v8 1/1] ethdev: add support to provide link
 type
Thread-Topic: [EXTERNAL] Re: [PATCH v8 1/1] ethdev: add support to provide
 link type
Thread-Index: AQHcEl1IYZBEfr+HU0yxdVF03oDORrR6I56AgAOzI3A=
Date: Mon, 1 Sep 2025 05:05:46 +0000
Message-ID: <SN7PR18MB3869329D468C2785DC14F8ECB407A@SN7PR18MB3869.namprd18.prod.outlook.com>
References: <20250820175317.3063659-1-skori@marvell.com>
 <20250821053425.3227866-1-skori@marvell.com>
 <20250829133327.67ee8d48@hermes.local>
In-Reply-To: <20250829133327.67ee8d48@hermes.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR18MB3869:EE_|DS0PR18MB5269:EE_
x-ms-office365-filtering-correlation-id: 1820bd5c-be8a-491f-f4e8-08dde9153638
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?UjJmMnM3L0QwdWtBU1BtMFhzRUdNaXIxRjg3dkxWYmwvMzBCb3k5TEtER1Nr?=
 =?utf-8?B?emJhWGJFaEJjSkZjSWJ0d1F6NTZEUnkvWjk0VlZMU0hqZExWdzBTS244THpq?=
 =?utf-8?B?d3hoeW5BaUtaVDZQaDVydlAyOXZia2prYytqQkFvMU9vQlpvMkNxUG5xVlRZ?=
 =?utf-8?B?MjlTWDgrQWNqTFNjR1BwRDRBY256VXdrZ0xvUkRtQWRTaGxqVzVpMEJNTkxy?=
 =?utf-8?B?MCtNNTF3a2M2QWE1L2N0d1hSQnN1cmM1M1NrV3JyeHFpZlR0ZDJKanl1cXh0?=
 =?utf-8?B?eldpUmRQVDZhRUtWMTVZaDFaS1JWVFF0M0JIWmliS25scFh2bDJ5VWczVWVV?=
 =?utf-8?B?WXd0K2QyVS9McjFzUkwxQlZzeGNmWjZydDNWSjc5clBpRkNiKytObGMxWFg0?=
 =?utf-8?B?NnZHcVJycUlNd3l5c0tnMnByNCtsZ1QxcFhNckROZDZyRFdocW14M1ZmaHVD?=
 =?utf-8?B?V2drT05GSnA1cnZJZExDVHg5d0dyeVVOSWNuQ0NjeFBBTURjUllGd0g4NHZz?=
 =?utf-8?B?ZTNCTlhxb1Ftc3crU0RQSndyQlN2Qmt1VGQ4T0ZNY0FacHVWS3pxaUZkM0Ru?=
 =?utf-8?B?aDlxakFFTEpieG80TStxZGd2dVpkMFVXYi94SjMrTkFuUTkzNXU4WTBaaVlU?=
 =?utf-8?B?ajg0NXphYldKajBBbzlrR3IwTjh5Mmcvek9KVHpFRkhBUlNGM0Y5SnpDMXdk?=
 =?utf-8?B?SXloUDN6ZXYzTWhWeWJXSGtMYjRCNDJRSSt5a2pqREZLb3lPZ085RVNZYkdj?=
 =?utf-8?B?bnQ0K3d4amdlVWwzR0RIdzFVK0FFQ2owZWRRdjlyMkZNRW1rWlBsTjNNVlpo?=
 =?utf-8?B?VDE0T1lGTG5LYUhaVW1aS1dzdU5OTE5ldHNuOWd5QmY4OVlkbE55RXJOYzB4?=
 =?utf-8?B?MTVKOWt5cW1lWkoxQkJ5dnNZRkJZc0VFdEpzUE0xeXRFNzhiTDRBSFQ1L2dr?=
 =?utf-8?B?c2F0U2QrcHdGYXp3ZkI3RzNwbmQ3dUVPWkcyM3VDOVgwenRzbkg1N3dXbzFC?=
 =?utf-8?B?YmVUUUZ1V3dENW9WL3orSmx0ZUpKTWFmVExCTldvc3M2ZmZKSWozNE1yeU42?=
 =?utf-8?B?b0RDMXZLR3o4bmNVWXFKQzJjOEJaSWtYRXdxOS9ialhwaVBiTHpmS3ZRK0lS?=
 =?utf-8?B?U1pEWnQwZVVuYUo2UjJYZU5vdDlyVTMzbmRZK1R0RnR5NmRLRE50RzlxUWFT?=
 =?utf-8?B?NktsdlJxaW5RKzYrenhGaWcyVDBhQ1c0bjFEWGpQMWt6a3lUcXlHeXpNVDlu?=
 =?utf-8?B?S3pKYkNlakhzYnl3THl3dUh4Y045SzBrZEVQTDRNTHNqaWFkaWw4WEJpOE96?=
 =?utf-8?B?NFNTMkxENGx1RzIyOHVObjc1YlhyazZJVFBqK3NDTDZDNzhxUlp4aC9aRUNY?=
 =?utf-8?B?WktGc0prWU8wQWgvTFZiNWFwSmxnazVLRDRvRjJpNzV6WGR4MEFYYldzcmVG?=
 =?utf-8?B?NEw4WHpOQmI0NEZ2UW5Kc3N5bHgwb2RScDBzYzJMY0hBUFpEWWk1eGphMHh3?=
 =?utf-8?B?QUtDN0tyY2xpUkltbWZzVlVwZlhvSXZwNk1lb2tnV2hZdDd3eTQvSmh6Z2pH?=
 =?utf-8?B?WG5WQzMzYmZIc1hHbWpwOVdmSGtiSWJMMW5DcUVmQXB5aTZCS3dLSTlOWjRI?=
 =?utf-8?B?VHd6U1BwNzZXd1NNemJraERRQW95THNQUG5KM2QxWGNZNk1ZcC9zc2szUTdi?=
 =?utf-8?B?dmxxeWpaUXhwY3Rzb0hPR1pvM25BRzY4MFRuZTFoV2ZBU09Jd1NEd3BIYVJ6?=
 =?utf-8?B?bFZHS09YODVYM25QNi9IcHFpRnNJMVlKaENnVnBEMGdxemN5QkxOa1k5cDc5?=
 =?utf-8?B?ekNTYVBQeHY3bDU3azFwd0thTTBBMHpyTEdiVU5NWS9oY0t3eEt1VU9QK29s?=
 =?utf-8?B?R2tEUmNBb1FqZk1SQXIzRVJ4RjJzY3dUZWRFaU5JUWltYTRwWmMwWkpIZGc4?=
 =?utf-8?B?d1NFYmJFeFFKS1hYaVluRlhqMEFhZWRSWGZYSUFjOHRRWGFtUnVqeHBXeTVs?=
 =?utf-8?B?NElObGF4bHNBPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR18MB3869.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MWZpWFozdmNNNHgvZVA3cVVoOEEwaHJabFRMblNhb2xoZEI4bW5oSUc0eDJY?=
 =?utf-8?B?VFFmdnJyaU0yUnIrM2dsOW55N2xUKzdSSm9mSjFnK0RQVFZES1N3R1hDeHRx?=
 =?utf-8?B?MEl6ZFo0aXFvaHEvdkFFVm8rMXFpYktqbkZtM25jdWxsR1ZzWGxQOG9zRTZn?=
 =?utf-8?B?UlBDSUd1TC93TmNWZm1UU3B5NmRwZVRxY3VYZmEvTW5INWoyc1o2dGJYNHJF?=
 =?utf-8?B?akcvWUVpM0wwM3VGRDgwOWxzTkN2Qk11aVUvNVN4MDlWZWZQU1Y4c3hDT0pU?=
 =?utf-8?B?MWpmRzllRGk1OGx1THBvTFFDVUo1L2FZT3U5UndPRGUxWlo3TWd3K1B2SVkz?=
 =?utf-8?B?cEhYRDUyOTczSUlOWWtSMC9nWnZsN1J0MFZudkxpQzM2M2dlYVBzRDZROEl4?=
 =?utf-8?B?UXdPQTIrN05zZVJHbEowd3VEdWtrRWJvTG8wSlZieDdWRys4S2U3UThlMnN6?=
 =?utf-8?B?THgwVVJmRTdReWJaWEZOejlVVlV3cGVpMS94cmVxNlRkNW1wcTQ0NFVWeFVS?=
 =?utf-8?B?b1l3clZYeGMwVmxxeWEwWWdlN3BPeUoyWlVHWlJjeWpyY2NzMERtd1NJV29n?=
 =?utf-8?B?d1ZLZ2VsdXpBWk9EcXpaYnp0WXZCK3ZsSGg5NEYvRU1keVpIb2svZy9uam1y?=
 =?utf-8?B?M0FiUFhrTERUZWdCeXEyd1Z3VXMyM3ovRFJYbXFVdDRCWTRTRlIzL2pWR0FH?=
 =?utf-8?B?MVhrN090ZkZrT1ZKdVN3VEQ0bVlDRmdRb256M1g3dWViTlJac2VDeHMvTkZs?=
 =?utf-8?B?WGNLTERzejhCNXR3bHRKVjRaaFJ5bDdmQzdXQTBxZWNpU3JxTWVxM3dqUGVj?=
 =?utf-8?B?cmFEY2tDcGdtSy9vMS90MW4vZDhOUmFPcHNROFAwaHlUUldtdWJjRnVlQkpC?=
 =?utf-8?B?Ny9HRHlrMFVBWWpFVnhIaHNZd3ZkMy9od2JBZUYyWFAvU0JnT1RXN01kMHlu?=
 =?utf-8?B?M08yRUtTa1VSa2VMWjNIaVpBd2l6aFlKVWRDeXk4UXhjRVhvczdqTERMYm5H?=
 =?utf-8?B?UVNlOUJDSWhNRzlDWTRzL01SMGMvdmVYZlY5QkE5MG5HNVJHSmNGY2Vva1Rh?=
 =?utf-8?B?cGRtdWh3MlRIbXFGRWQ3ZWVlOHdDVEFyeDBndjQxZEo3VGEwazlQNSsyMzFC?=
 =?utf-8?B?N2lCSm1JZ2d1NkpPOTZwbFRqdUVzYjVVSzUvTmJSMXEwcUdaYytHWGQ1MVpm?=
 =?utf-8?B?Y21BbGJqejRqdkVhcWdiTkY3UjlVNTA3QXZmcE9uaFF5S0c5U2lZWThLSmJh?=
 =?utf-8?B?WURyVDJQQTYrU1RrTCtUb2xSKy9JSWhNSFRPWmxGRGdsVGx1Tm1WNE1KYTVB?=
 =?utf-8?B?eWhlc3lIT1h5M2Z4OExWQjJBNkNSVS9VaG51WGxyTFp6TUI1amdIT2tUR3B5?=
 =?utf-8?B?amJnUUY3YWdETHZ4VGRPeW15Nzh3QXFBVEoxK1d4Q1FrRXVRMXc1WVoybmtz?=
 =?utf-8?B?MzN6YWg2SWEzMTR5MlYxOFdhSXQvMkpiblRtY2NVeDdkRi9ISEM1MVFENlhz?=
 =?utf-8?B?Z2JBNG44MU1oRlZKVWpPSnErZDBCOWw2bWpYNk5rbWxiSk1heDdlYlg2aFZr?=
 =?utf-8?B?TmFoQ3g1ZFBobFhkeGVmZmUxcTgrTVBLQkRlamUxZFR1LzBSM2J6VGZOZjRJ?=
 =?utf-8?B?anFnRENVVndJalM4ZzNuQVRFU3J1aFJhVnFPYm53UGZqWjhzNC9Jem42TUg1?=
 =?utf-8?B?azhGVVZTR0Y1cytVZkxVdmViRWpodkMwSXVoZFFldlRma0tTTFlCOFpwTS9O?=
 =?utf-8?B?eFJQRDY2aWd5OXpXV1dTTVVVSzlobWdxcWdaYU05RytHcENkM0tQSUNRbll3?=
 =?utf-8?B?YXFWS0hFZDl4bzk5RmgyVWd0NGJDeTB3YzV1ZlFJM3dKa2YrOU9yY1JKN2Zv?=
 =?utf-8?B?bkNsSTVsd2lXQzlDM0NnOEFUOFlENk92c0Z1TXJmMHdLbXBVcG9PZG1UNmRm?=
 =?utf-8?B?bk9EZDd6cFd3OEpwWm5OSFE3dm1zZml3eHY0d3JrMzNwTS9BNVNsZXlXRG85?=
 =?utf-8?B?aTRIaEhGQTFUdmNobzlidXpDZEk4RnNycWV3VjdoTXBWL3VWVk1QU1JlM29R?=
 =?utf-8?B?NVY1ZnFGVlFzOVZjbUF1MXo3d2xsZzhQYkl3R2tLTzFWY0lBUkNhRXl5cGxQ?=
 =?utf-8?Q?zoHM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR18MB3869.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1820bd5c-be8a-491f-f4e8-08dde9153638
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2025 05:05:46.9468 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4v7Y/7a/AF7FFkrgoQelJBIcsDcTzH+SusB1Qeo2HY2BKF6fR+wihe9lgs3XGavKvta5USMlc0KcOzb454ZTUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR18MB5269
X-Proofpoint-GUID: 3gYbVCscjSW8S5dBiCIQjF4CJ82xeTTX
X-Proofpoint-ORIG-GUID: 3gYbVCscjSW8S5dBiCIQjF4CJ82xeTTX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDEyMCBTYWx0ZWRfX9p5f/hETXHcZ
 4Q2DBQ31IsiTbtaEwCybE+30rBMY7Nk8E0/cdSRbe0hvMhe2hF14hFT6jOkqxuCIEJ9XFBRlmcT
 M5q3wGOEUvG2xO0OJ5fRr5jogUY5ml52VqgqcipBkcC5bMnWAQ9BFXk5PxvGx8RFWWOlwTql15G
 x7FZ7+6CAEcsyJbN4wko1fn0TOUu6iQxBvefd9tM0gIwlH8VyXeC65DQuLUCWV21zw7kJnPGfkF
 FtlIqulLYomjCHziLT80DNrdkFu5S/MlxQXTjS5QPMd/vAlAsnitjS4LlC3q2I7TbHkYyHFL6CH
 nV3w4OHMwieu+L8pydp2gGlhZ3xMSCTRrZIz/sRuWWQzEPCSwRqq99alJ02AttQlmrQrSChhXOu
 gli7v7u9
X-Authority-Analysis: v=2.4 cv=N44pF39B c=1 sm=1 tr=0 ts=68b529ad cx=c_pps
 a=Bx4JecnaPChsX23rVfvkjQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=-AAbraWEqlQA:10
 a=M5GUcnROAAAA:8 a=ePXPjcMqR0n9aLrdoBIA:9 a=QEXdDO2ut3YA:10
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-01_02,2025-08-28_01,2025-03-28_01
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

PiBPbiBUaHUsIDIxIEF1ZyAyMDI1IDExOjAyOjMzICswNTMwDQo+IDxza29yaUBtYXJ2ZWxsLmNv
bT4gd3JvdGU6DQo+IA0KPiA+IEZyb206IFN1bmlsIEt1bWFyIEtvcmkgPHNrb3JpQG1hcnZlbGwu
Y29tPg0KPiA+DQo+ID4gQWRkaW5nIGxpbmsgdHlwZSBwYXJhbWV0ZXIgdG8gcHJvdmlkZSB0aGUg
dHlwZSBvZiBwb3J0IGxpa2UgdHdpc3RlZA0KPiA+IHBhaXIsIGZpYnJlIGV0Yy4NCj4gPg0KPiA+
IEFsc28gYWRkZWQgYW4gQVBJIHRvIGNvbnZlcnQgdGhlIFJURV9FVEhfTElOS19DT05ORUNUT1Jf
WFhYIHRvIGENCj4gPiByZWFkYWJsZSBzdHJpbmcuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBO
aXRoaW4gRGFiaWxwdXJhbSA8bmRhYmlscHVyYW1AbWFydmVsbC5jb20+DQo+ID4gU2lnbmVkLW9m
Zi1ieTogU3VuaWwgS3VtYXIgS29yaSA8c2tvcmlAbWFydmVsbC5jb20+DQo+IA0KPiBMb29rcyBn
b29kIG5vdy4gV291bGQgcHJlZmVyIHRoYXQgeW91IHNldHRsZSBvbiBvbmUgdGVybSBjb25uZWN0
b3IgcmF0aGVyIHRoYW4NCj4gbWl4aW5nICdsaW5rIHR5cGUnIGFuZCAnbGluayBjb25ubmVjdG9y
Jw0KPiBpbiBjb21taXQgZGVzY3JpcHRpb24gYW5kIGNvbW1lbnRzLiBEbyB5b3Ugd2FudCBtZSB0
byBtYWtlIGl0IGNvbnNpc3RlbnQ/DQo+IA0KSSByZXBsYWNlZCAibGluayB0eXBlIiB3aXRoIGNv
bm5lY3RvciBhdCBhbGwgdGhlIHBsYWNlcyBhcyBwZXIga25vd2xlZGdlLiBJZiB5b3Ugc3RpbGwg
c2VlIGFueSByZWZlcmVuY2Ugb2Ygc3RyaW5nICJsaW5rX3R5cGUiDQpUaGVuIHBsZWFzZSByZXBs
YWNlIGl0IHdpdGggImNvbm5lY3RvciIuIA0KDQo+IFBsZWFzZSBhbHNvIHByb3ZpZGUgcmVsZWFz
ZSBub3RlIHdpdGggc2hvcnQgY29uY2lzZSBzdW1tYXJ5IGFuZCB3aGF0IHVzZXINCj4gc2hvdWxk
IGV4cGVjdCBhcyBkZWZhdWx0IHVudGlsL3VubGVzcyBkcml2ZXJzIGNoYW5nZSBpdC4NCkkgd2ls
bCBzdWJtaXQgbmV4dCB2ZXJzaW9uIGFkZGluZyByZWxlYXNlIG5vdGUuDQoNCg==
