Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F503C36018
	for <dpdk-dev@archiver.kernel.org>; Tue,  1 Apr 2025 10:21:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3197D40DC9;
	Tue,  1 Apr 2025 12:21:16 +0200 (CEST)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id A3B364067E
 for <dev@dpdk.org>; Tue,  1 Apr 2025 12:21:14 +0200 (CEST)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5317AaSo015173
 for <dev@dpdk.org>; Tue, 1 Apr 2025 03:21:13 -0700
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 45rbgq0b2q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Tue, 01 Apr 2025 03:21:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e9eXne4QHqXk/VYVjLWMjKM0FmaLzFCxtjPobIiM6/azHZ+ipMWf/4D/UaqVXW9ihuSJXeB5PZUUfqpoKxfS0tJL73I0BDuvcX/QHgZ39FOLsuzFOEbE4lXBfH/DY/W/UvCUTge6A09+igrWEvGwG5xB1GE3Vo53nPJpuGaWVyIGAws1Pegaodb4DbjzqFhv5msrpw1Ma2C56agXtpqUfOEWG/JV7+3zR2+mv9dalhCpbOJwWurl2UGHhENWhK0K1RYlTfmzkdnahUhtwi4ACA6yPy5s3JXCpjSm5OyQDayDx1OW7Wf/bKfv/Cma2oPtfmGlj7zB9EPtkE661VZ+YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jTOxqYkr6rWb9YXkfii7d+0fY+k6XJU9tgzReqKqJuI=;
 b=c9vaOPyn+DQtXYQL25ngsAoNS792Ygnj+h6ITKpBu0H7SCFQRXzf/g2ODGVGJ/sVU591dc9lIVPpOUb/g9Pq8X0aIWZ20CO2a3CWMNqGkwYCjhcp5+/pnh8uT1CXkd2d26LXB8RBF6Sfsa4gw9i2gn+nGtBXyMLa33gzOe5xnFiReHROwNkgObaZRb1YEo7/VKv4nBRFO7lWqWefel3nHeqQ0D7W6x+273fXFauetZp4/uek7hQZof6N1ZshH7/5DhNEaqRsDIjjkWZwLbUNMbnYykmQbGkxCNHmDAQpgmI8YDDnijokVT1sLvv5ulHGeCkEFHqPI+uSD84Ga7ezsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jTOxqYkr6rWb9YXkfii7d+0fY+k6XJU9tgzReqKqJuI=;
 b=KTdwe+ae2aM44ByirZYl98IQmWH1ysmIGE2mZJX2riV4GPpO1ZNICTrYzqfdToZ6thpkDYi5yxdwLKCxnsjGc4/T34VAsFKjlpH0SGNXLlAKTnSL3oCzMtl41wdC58jEMNFYLP8ggCTguQZM+co3Bld8dOuhJwKiEze37tb418k=
Received: from BY3PR18MB4785.namprd18.prod.outlook.com (2603:10b6:a03:3cc::18)
 by LV8PR18MB6231.namprd18.prod.outlook.com (2603:10b6:408:258::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Tue, 1 Apr
 2025 10:21:11 +0000
Received: from BY3PR18MB4785.namprd18.prod.outlook.com
 ([fe80::4f9f:e101:dad7:c576]) by BY3PR18MB4785.namprd18.prod.outlook.com
 ([fe80::4f9f:e101:dad7:c576%3]) with mapi id 15.20.8534.045; Tue, 1 Apr 2025
 10:21:10 +0000
From: Jerin Jacob <jerinj@marvell.com>
To: Satheesh Paul Antonysamy <psatheesh@marvell.com>, Nithin Kumar Dabilpuram
 <ndabilpuram@marvell.com>, Kiran Kumar Kokkilagadda
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha
 Koteswara Rao Kottidi <skoteshwar@marvell.com>, Harman Kalra
 <hkalra@marvell.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, Satheesh Paul Antonysamy
 <psatheesh@marvell.com>
Subject: RE: [EXTERNAL] [dpdk-dev] [PATCH 2/2] common/cnxk: defragment MCAM
 bank during allocation
Thread-Topic: [EXTERNAL] [dpdk-dev] [PATCH 2/2] common/cnxk: defragment MCAM
 bank during allocation
Thread-Index: AQHbmkZxVDJn/my7dkupNEWShUwV4rOOquvw
Date: Tue, 1 Apr 2025 10:21:10 +0000
Message-ID: <BY3PR18MB4785EB21B8FDB8BC0EC6CAF7C8AC2@BY3PR18MB4785.namprd18.prod.outlook.com>
References: <20250321094820.3311252-1-psatheesh@marvell.com>
 <20250321094820.3311252-2-psatheesh@marvell.com>
In-Reply-To: <20250321094820.3311252-2-psatheesh@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR18MB4785:EE_|LV8PR18MB6231:EE_
x-ms-office365-filtering-correlation-id: 11e53f81-9a6c-4dba-4e10-08dd7106ec6d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?utf-8?B?bnVIam43ZVdXbTVvVWJrMnhqWG5HWVBUd2I0MzdkdkZZTGgxdFVOenJXckds?=
 =?utf-8?B?NUFIME9CeW5ONHR5VnIrZWhOZ1E1RFNpN1BnaktvVlZaeU5xZ1Fha1l2UkZi?=
 =?utf-8?B?NXp6bENwL1B2bFkycXVxQmZseVlDUmxJdmRCVWZuSzlGZ21WRUQveHY3WFFw?=
 =?utf-8?B?Znk5VDBwTFVYTWZHaHQzSmp3a282ZEM3NDYzRmwrdXVGU1JtZGphNFkzcG5Z?=
 =?utf-8?B?aWRMRE03Mkd4bERkMjVYbGNoYnhPcEo2K3RYNmdCTGk2b2ladnE5aUFnVks4?=
 =?utf-8?B?SkUrUk1xdGJ4WE9XaC9zeVhJemFvMm16R1dVeHZLWWFRTndjeVc1cU5MMUZQ?=
 =?utf-8?B?dUlnZFFKR0R4OU9ORG4yZVBwcEhZYlMzRThZRXAxZlIzNVowclJyZ3hsZ3pH?=
 =?utf-8?B?Zmh1bmFUVGU1Nm5ZTlhOUlpwS29Hb1cxRXllVW5KZnA5SExBU01ybm1ieW5u?=
 =?utf-8?B?SDREaXpXd28rQUhqZjcxa0pybnJBNklSeGhEeXpmTUNEblp6cGcvaDNGcXFm?=
 =?utf-8?B?UFpmWVpyUHJJMEhZMXdPOGNvbzJnbVBGMEtISjYwUW0xZWVjRXZ5cmkwZTlW?=
 =?utf-8?B?VkMxeWpMOGo4UVNhOExESVp2enlob1NrMWFndnJ1UlhURlp6eVJsTXVkWVIz?=
 =?utf-8?B?VG5DRUErS2ZxdllTbVZzbHh1c05YaHhlLytuVW02dnpDVTVXL3ZlemV6M3hZ?=
 =?utf-8?B?YXBObEJIekNhMUg1NzViNGJuVmVzYWE4RnZhNE9jQk0vMTlKRG1JVHlxK2pL?=
 =?utf-8?B?YmFQUnZUWStNT0ZyUnlPK2V1R20rcVF1N0hEeVlYdFZ6TitaR1hSZjZINXJt?=
 =?utf-8?B?WFFpRWZBRTJvRkM5dzhYdUVheUV6ZkxjeFVzb1pFQmE5bGh0VklmZk1yRnhY?=
 =?utf-8?B?ZWVQekNmUFVtZ2NRTnRlVHd5MGI5M2s5QnBZMHlKb3BUSUgvSkZMYVh5cmJV?=
 =?utf-8?B?d1pkWlF4cEMyRDZDRnNHWTRiRmMxL0djdFZGRmptVVJTTGJKQ0lhQ2tsMm12?=
 =?utf-8?B?UlZjalgxekxJVk1seGRZdjlFRGdjbDkrL0tpNXdVNEpURmdRUkZpUVAyS1Fi?=
 =?utf-8?B?OFBuMnoxaVEzMFVtZ1FtS25FN2NQc0VFNWlHa1VQOHYrZGRqRUpobFE3SS80?=
 =?utf-8?B?dW1oNVRObEZZK0tibW9YYlFVUElvbEdJRVhqTHlGaXN5MGs1aGZ4aWRndjJI?=
 =?utf-8?B?VmlzVFZSVXJLYklRS1lWZ3lYditwU3ZSVzFVeWdrZHBlWEczeFIxNGQ4UHlr?=
 =?utf-8?B?NklZbURhOUMzL0RidjJ0QS9ldDA0TnNTcGh5V2I4TjdpTFBWZmhaV2djVnJT?=
 =?utf-8?B?YlpJOVk1VWptRUU3dzFjNUtGMEJnM1dhRzhsU3BCOXJ5WTlBTXRBWXZZOVdT?=
 =?utf-8?B?ZXJMTDQ0d085SXczVUt4OWVaK3ZiNzVDWndRWTN6MWpGd1JheG5ldC9RdEtM?=
 =?utf-8?B?cDNCb3MzSDBnRCtYWVA3djFsRmVTdC9leWZac0k4QVdMeWtoQjhxSXVySWR0?=
 =?utf-8?B?RUxab2pRUzh2UlhqU1JBc1huZE5nRHU3aE4vNlNFOVJLeEFvUmtQdnp2bDRo?=
 =?utf-8?B?Z2Y3cEt2c1NvWE12eTFuYm9OcUsrNUQ2YVNjYnQxV1Q5cHQ3ZWRCYzYxQURW?=
 =?utf-8?B?WGFnWmg3T1hJYVVjM3BJamlybWQrZHBRZ2lTWDN3RGRjZXRuWnpOMDZnVE12?=
 =?utf-8?B?UUZDTnVwN2xqK3lPdWQ1clJsM3NTVmJNZHFRSkFWVVBVYjhmc1A1LzBwVE90?=
 =?utf-8?B?N0U1NEVra2xpYzdvby8yNnUwaG1PS2RyZnZYWGt6Z2luMnNmeUpuVXFnNWVh?=
 =?utf-8?B?TDY2ZzFmdXJ6akMrd05LNnNiNnZZbndOWDNoeG14NTk0c3dDRTN6WUs0L0Zm?=
 =?utf-8?B?YmM0ZDN4eFkyMFFhWHQ2TEIzaTdhc28raXFXSFFJd0tDdkE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY3PR18MB4785.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018)(7053199007); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QUVQVE5EK3pTemRJdjZLbkdzRXQ4SFB5bTdmbEViK09ka1ljVG0yclRtOFg2?=
 =?utf-8?B?YzIwK2IwZUxJN2ZNWWNnSlRUbG00Ykt1YUJDeDg1U0hDSG56aDJ5V2lxM0JJ?=
 =?utf-8?B?K0t1ZlhUS0Q3YWRkRERFRGVDcnB0L0p4ZlJLUWd5c1pxdTVuM1RLNXRtUFc5?=
 =?utf-8?B?ME83V2ltZElYU0sxQkJtL3ByQXdYL0s1R21XOXhXK1JHSTlMQnpJTHRCNUIy?=
 =?utf-8?B?Nk5DN0lFQ21oWUtadGJ3dzBWS0RFdUdDL0tNa2ZibzV2UFNSNXFXYms2S3No?=
 =?utf-8?B?WTFxNTNVY1RkQnNZY2swT1Q3b09NN0M2K3hCWEJMamJFbGduUk5DR3BUbWwy?=
 =?utf-8?B?Qm9mTzQ3M1d4bDlXWndLN2JQOVgvclNYZ1cyK05raEVZbjJxTGdGbDJ0blo5?=
 =?utf-8?B?OG91K0lhTUxrNWVTUk5UV2RYdUFIa3V6anJjV3BPdXViaDAyOThyRmNDOTRz?=
 =?utf-8?B?UWdjTTdVU3VHVElrNCtyaEpUeDJuVE5idmtQM3plVXdXVXk2NWcrSGRFdUJC?=
 =?utf-8?B?QWR4QlhvMXpLUzMrdGJRdmJacGhkTnh5cmtxcWd2M08vZDRPRzg4U20rTE9m?=
 =?utf-8?B?QXVzRkhvbFhwNThtUlZpamFLQmRpU3h2VGE0ckw2dm53UkFUcDhmYmlsZXNQ?=
 =?utf-8?B?elh5MnE4eGorNmcwRHBzaVIxZ05lRE5VdWg0UUtSYm9INVRkOTZ2MDVSQlNV?=
 =?utf-8?B?N1lwSzVSYWhKNjlJdWNXVG91eGY3MmJHNldwZ25lRklFMlRKY0g5cGQranpw?=
 =?utf-8?B?TGR1bEVHb1RHVXpCU05XMUlxbkk4cm95L2ZxbWdVUHJkbXY3cGVkdG5KcXBT?=
 =?utf-8?B?clZBUzdHbE1sVnltSDBWTVk2MHJNOXNRdkZjQUNXOWNLT09pSG9yNDBrdUJN?=
 =?utf-8?B?RUI0SkFwZmxCQVAvcVcxZXh5UE1NRWF3aDRmZzgydGhWcC9yZi84cytqNHZL?=
 =?utf-8?B?MHI2a1lOY1hvbkdMZGlIOUNjNS9TMFl2TGRhV0NSSExvS29TUnoyY1BaMnZk?=
 =?utf-8?B?N0NaSXVFRk5zLzhEeExKQkdtKytzbWpxNlkyWXZsL3ltTXpreXovd1g0Tmdt?=
 =?utf-8?B?cUhJUEoxQkR6YmpVMXBTMDBxUmt0V0NPa3NSSFl3MTkzajV0L2ZFSVlQU3NF?=
 =?utf-8?B?a25wa0gyR2lvdVFPMmpnbHRXK0NHc3BmMHdUQ3ZsT2JqV3c5V2lxOUxaV0Ns?=
 =?utf-8?B?UGhNSWpYdDNxRnpleFEyMk9OK3ZHc1hGai94YitrRUNVZHlPVGtKRFcvVFgz?=
 =?utf-8?B?blh1KzhFT1Y0dWRFNmlQM0NVYXBKNGNwZ3NpZklNQkhsRDg4Q2hKSjMrOTdj?=
 =?utf-8?B?YTFJQzY3ZUtzdTlzdnp2MTlPVlMzL2U5Vzc1VUVEMXlEU1llR3VJZ2dOTUtl?=
 =?utf-8?B?U2E3Vlp2Tmd2ZzhzT1NTa3YxSVJPYklQQkh2SEZxalMrT0dmVlBGVThiRUp1?=
 =?utf-8?B?NUp4RkxReE1WTU0wMGhEN1k5R3A2ei9mbWFNSHZBaVl1RWJhMFR3cjE3NG1q?=
 =?utf-8?B?VURYOU8zSGVxdStBRHJuOXZaZUZJWEFkT2VqcVR2MTg0VG5ZVDBpYUdRMU1Q?=
 =?utf-8?B?TjFGSGVDZS92WUZsWmRiek05ajJ4Umd3Nng2WDgvUnNnaUt5THh6TlhjWENq?=
 =?utf-8?B?TDBuVlgyY1JrSmVTbk1mZEhRTUY1emNXMG1nUTlVVk4xWjZvMEhCYy8rOHB4?=
 =?utf-8?B?WTZMVWVmeitnbDdNNGR6dU5SbXY5UUk0bkZYc2svQ1FUaURyZUFjckU1UkFS?=
 =?utf-8?B?Y2hTbTRsejhnVXhKTTc3V1JYUW9aSHNvQm9pYVlQcEZPZHVRalZXNWpmb2Vr?=
 =?utf-8?B?NzJzaEVlRVdWMHVGMURsYTRkQVVpb3Z6VFJSaDQ4bW1tZndFWCtJZ0JnNG1B?=
 =?utf-8?B?azBCUW9MTnRiWnpMaWdxb2RoU1ZvZFlYeEwwdWpCZ1R0aU45QzlsS2lJc2lj?=
 =?utf-8?B?Vkx4aTQ1YzlTRnlEcU5oenFGS0l1UlQvcWtZNFNtTENjRGlXRFp5UC9UWmph?=
 =?utf-8?B?ZlhhTkFHMzhXc3Vkc1VhZHF1TkZoZkRmNG4vQ3U3cFdaN3ZLWHp6eTNNVzZQ?=
 =?utf-8?B?ajNWbWhIVkdFQzZ0cjVUemM0Y1hNUWJiSlZhSGt5b05uR1lTcDFJUE1rdFht?=
 =?utf-8?Q?CREY9CO+ZchVlLTnsXIw83Sk1?=
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR18MB4785.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11e53f81-9a6c-4dba-4e10-08dd7106ec6d
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2025 10:21:10.6626 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ta8PPd8Tx3YG0MYBhfrq7sSvGktuvlG+Ck0xSHWU+Kr9iYy6uw19mnfs/qQ9IYufQSj4Gc9jFe7sm+sxg0SBwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR18MB6231
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=TLxFS0la c=1 sm=1 tr=0 ts=67ebbe19 cx=c_pps
 a=gHjWyi4SN+6fNgZLRl0D7Q==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=XR8D0OoHHMoA:10 a=H5OGdu5hBBwA:10 a=-AAbraWEqlQA:10 a=M5GUcnROAAAA:8
 a=8rWy6zfcAAAA:8 a=RpNjiQI2AAAA:8 a=zSJyLDGILjiGCiDo06oA:9 a=QEXdDO2ut3YA:10
 a=OBjm3rFKGHvpk9ecZwUJ:22 a=YjdVzJdQTyZRADMV7wFX:22
X-Proofpoint-GUID: pIzMBPS83OKJZSru_zf8TIYkU0anG-j-
X-Proofpoint-ORIG-GUID: pIzMBPS83OKJZSru_zf8TIYkU0anG-j-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-01_04,2025-03-27_02,2024-11-22_01
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
> From: psatheesh@marvell.com <psatheesh@marvell.com>
> Sent: Friday, March 21, 2025 3:18 PM
> To: Nithin Kumar Dabilpuram <ndabilpuram@marvell.com>; Kiran Kumar
> Kokkilagadda <kirankumark@marvell.com>; Sunil Kumar Kori
> <skori@marvell.com>; Satha Koteswara Rao Kottidi
> <skoteshwar@marvell.com>; Harman Kalra <hkalra@marvell.com>
> Cc: dev@dpdk.org; Satheesh Paul Antonysamy <psatheesh@marvell.com>
> Subject: [EXTERNAL] [dpdk-dev] [PATCH 2/2] common/cnxk: defragment MCAM
> bank during allocation
>=20
> From: Satheesh Paul <psatheesh@=E2=80=8Amarvell.=E2=80=8Acom> If MCAM all=
ocation fails,
> invoke MCAM bank defragmentation and retry MCAM allocation for CN20K.
> Signed-off-by: Satheesh Paul <psatheesh@=E2=80=8Amarvell.=E2=80=8Acom> Re=
viewed-by: Kiran
> Kumar K <kirankumark@=E2=80=8Amarvell.=E2=80=8Acom>=20
> From: Satheesh Paul <psatheesh@marvell.com>
>=20
> If MCAM allocation fails, invoke MCAM bank defragmentation and retry MCAM
> allocation for CN20K.
>=20
> Signed-off-by: Satheesh Paul <psatheesh@marvell.com>
> Reviewed-by: Kiran Kumar K <kirankumark@marvell.com>


Series applied to dpdk-next-net-mrvl/for-main. Thanks.
