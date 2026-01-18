Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DC00D4A5F4
	for <dpdk-dev@archiver.kernel.org>; Sun, 18 Jan 2026 11:40:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2402940297;
	Sun, 18 Jan 2026 12:40:24 +0100 (CET)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010028.outbound.protection.outlook.com [52.101.46.28])
 by mails.dpdk.org (Postfix) with ESMTP id 98E954026D;
 Sun, 18 Jan 2026 12:40:22 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q9PPCLmse1uYS5ZKmd3uD6voOyJqMKpPAZ53V75zkC/Gw0vbjw44HjMSosjkHrv2O//VagUxw1MASmbs+1db9NQUPGhC8BuD/KEV/tT1Ac6tKUEx0jVLHpZXSzjJGC1JP2gHJRUMQ2g/7UKGy7dmmgi7/JB4IaIB2ZIlqjnsGY58B2tQSn0guZ/OSDa/wrTIo5mEj03RKyx8yagijZ3SqgyWQ8pKGFzSAjx6Dh29L8fqNhdlsPF1E6xY3Z1Oxtgzc9tWPoQBgoWmIMHuTuykKTxMCDABiwevCsirWJD5ptIofOfIGk69rXZZwGJSd/Rir1Z8z7zNVPKbErkDXRvJFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pZutQRC1jO8T/0C66I2ZDqmK2o+aQr+tM79bkkXcvDQ=;
 b=SbQn0dR5ah7HH82udv4v8KistmNRsVGjk2R4tOqA/iTYOXM92BbikhxWe+5Sgc+fJgYsAy7zOf+vlz0McdCPvcKuX+Fzi9sQ7a2zBwuvgaYFPk6D1Ragxhp8HLIIXKFZJ0+obY4K+Hybv3SV7RainW9q3Gdgc8FaTG38KNDqnkI4IpiMY9zCuK8X0QQitlkIvRVKVclEKZ3m8I2f4AJ1pcvv6qwZdnSROFeHiTOsoxd/aVfqtJxrbsWD5GxdbFhLXHxNkLqvoTLVmIVZUerfGuH264/Blj/a1KatTiOV6/re8qY9gF4cSzuJH++r/QVaSFawHQ3scs2t2UOAXR4XrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pZutQRC1jO8T/0C66I2ZDqmK2o+aQr+tM79bkkXcvDQ=;
 b=t0hsitahAoaQmyNjtWlT1osxwvv5P/DekSLZ/ZebIEZGblGQSApzja++oRxrz55evn2pcrT4QwQlJ0P8zX2Aupv7wQk8OOIx6dxL2+sZ84Eh7IXU3yL0Bsg3eGt9gncfFpY7mtRENevwlHSSqX3059OrXU0qz4sh3+WCR6Bzt8Avi4JeT271bzXYStw/V0Z12WxccG4EtPmuwL0DZce8j2KE66WikImEGitE+pbyEdmH51L+IkHRgtIVGSx86lfVLoPWhzwaOE6njDNHtVqWdurBVX4TjT/DdC08M8bCtZdPhoq9I3EXt2b0btip3h8Rw7D9GQzo+CdonKGwJVT3GA==
Received: from CH3PR12MB8074.namprd12.prod.outlook.com (2603:10b6:610:12b::9)
 by DS0PR12MB8786.namprd12.prod.outlook.com (2603:10b6:8:149::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.10; Sun, 18 Jan
 2026 11:40:19 +0000
Received: from CH3PR12MB8074.namprd12.prod.outlook.com
 ([fe80::e7f:6d00:5e86:274a]) by CH3PR12MB8074.namprd12.prod.outlook.com
 ([fe80::e7f:6d00:5e86:274a%5]) with mapi id 15.20.9520.009; Sun, 18 Jan 2026
 11:40:18 +0000
From: Maayan Kashani <mkashani@nvidia.com>
To: "dev@dpdk.org" <dev@dpdk.org>
CC: Raslan Darawsheh <rasland@nvidia.com>, "stable@dpdk.org"
 <stable@dpdk.org>, Dariusz Sosnowski <dsosnowski@nvidia.com>, Slava Ovsiienko
 <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>, Ori Kam
 <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>, Matan Azrad
 <matan@nvidia.com>
Subject: RE: [PATCH 4/4] net/mlx5: fix redundant control rules in promiscuous
 mode
Thread-Topic: [PATCH 4/4] net/mlx5: fix redundant control rules in promiscuous
 mode
Thread-Index: AQHcg6VnOiZ7slwoU0qOmI5XoFrmAbVX1wZw
Date: Sun, 18 Jan 2026 11:40:18 +0000
Message-ID: <CH3PR12MB8074E0D6F70C27BC3CBA9DC2B28BA@CH3PR12MB8074.namprd12.prod.outlook.com>
References: <20260112092439.14843-1-mkashani@nvidia.com>
 <20260112092439.14843-5-mkashani@nvidia.com>
In-Reply-To: <20260112092439.14843-5-mkashani@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB8074:EE_|DS0PR12MB8786:EE_
x-ms-office365-filtering-correlation-id: 8ac7d08f-b1ed-49be-6d74-08de56865b33
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|7053199007|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?aFExK2pUQjl6eHNrczkwNjVIcGw4UHFaUU9iN0lsZDRacldlYVNTTExjU1ht?=
 =?utf-8?B?dVlnWTNnaEpJYjNodzUwaFFuQ1g3SG9kaVoyL0dPSnBRWDRzMXNLUjBPTlpZ?=
 =?utf-8?B?eWJZRWJvQzNHbkNubzN1Tyt4cXJEMUV1aGJjTWhFL0ZTcjJ6bW9WYTBZYXhU?=
 =?utf-8?B?ejNQbHlFeHNpRTZ1M3NnczBQVDBZQUZkS2o0ZTJPM1lTTW1EbFZzaGhtQjZ0?=
 =?utf-8?B?YTdXRzZYODQvdU5pbTBnSVNHakFYcThtMFNoUFVEUzFjbXZObmhFU3BGYlNH?=
 =?utf-8?B?eUc0QXNOTW5QTkd0S1VraEN1QnU1azdaMENhQUxubVlycENURVQxcDFrdFR5?=
 =?utf-8?B?M0lOcnBnSXczai9HaWVmc0NoS1JNL0RWZ0pNK2xqWk93Q3RyNk0xbkUyeEV6?=
 =?utf-8?B?NkZWSm9kTkhlZ2JaR2RYV0JMUE54T2tpNFlqTzJnQ3FqMmp0R20rQUh3dDRQ?=
 =?utf-8?B?cEsrZkFxZHNBYW1tS3pDbzhpNnRSRWFnYlBJbnZnWEN6YTRJa0ExYU1pSjAv?=
 =?utf-8?B?L1Avd0doaGtRUFMvQWhpcVlCMTV6WG5xRFIzZC9ZRE5USDI2TnZsbWdiT21z?=
 =?utf-8?B?NjU3c2d2VE1BUzVRN3ljVXNXR2FabWdRWFc4SkdDYnJlL0VxKzZQeTF3M2py?=
 =?utf-8?B?V2RZMDVoMXFaYUZ4VEtpeHVFSGIrRFdGbHRhRGtSY1k2T0xjYnZmNUF1SFVD?=
 =?utf-8?B?QU82RjhGclNIS2sxYjR1V0hCTGsyUmUzUDNaOXpNVUVzUWxPWnhUU2VyclBs?=
 =?utf-8?B?eDRlMDVxbDB0aXFTa2ppRStIc3JIRTVTVThaRTEvYlRaaFJFZkdIRmZld1lJ?=
 =?utf-8?B?bVhJWnRRZW5aaER2TWVabG9ySW5xdlE2L2FyZlRMcWRqVExaY0h2VDcya2Qy?=
 =?utf-8?B?TkhtR0RZcDBOanNUNEhpMnBIc3htbzJWbGVNR3RhRHpURWZUcEN0Y3J3ZHFr?=
 =?utf-8?B?TXdTckcyUVlvZ0xlYTMxcERNSDlkTGpwM3dlakhoL2ZMelFLUVVnNTJGZjNJ?=
 =?utf-8?B?RlJFVXRKLzNlaGRDOEVuT2ZiNUZ0cDRaQUZCMHNwM3V0RXVZNUVkeFJJNDZk?=
 =?utf-8?B?Z3Z6dVpMSkhuOVdyd2o5eGNnckd4YnE2TjZzNVZhMmlVNUVzb2xXM2NWNFE0?=
 =?utf-8?B?VlZpeUlQNkhPbThCWUhQakxHcC9PQTdqZEZEYVI1S3FuSkRQb2RXdkdYVEtS?=
 =?utf-8?B?bUNvNVp2bFhxN1ZHdjR4RXg1NGUyRGI5SzlHbG5yczEyeEhpd3FocjlGZUlS?=
 =?utf-8?B?SncvL0JhOGdpeU5BQU8yUFE5cGFwb00zU2lxNkNjSUgyeW9SK0NXby9hNDZh?=
 =?utf-8?B?clNmV0pFTnp1aW1VaW9pU3Q1T2pHdDVZMFdYbEROU3RJRnN1cks3Q1BmL1Nk?=
 =?utf-8?B?N2NRa0Q2RDM3SGxwTWtTck0zUkJ2NzQ2ekFJaUV0NVhldVpjRTFLalVPZmJU?=
 =?utf-8?B?a094cjJEaVd4OVJlajJ0Ylltek5VekNPNTI4SjZGajhwMmRaSUp0Tk5lS3Ra?=
 =?utf-8?B?YlBXOWtzV1lRbjRVQVk4NTZMaXlaUytCcFozdUNmcTNyd2JPTnBvZitrSGVj?=
 =?utf-8?B?a3VmbjFkUFFqY01DNTlXV3RReGJwV3ZaeTUwOTU1OXVkMi8yVFp1RkVzUHMy?=
 =?utf-8?B?TnR2bFc4RmpSVldHWi9sOEVlUG9INHR5RjRqV1BJVmRBeTRHTklUa0NvbHBi?=
 =?utf-8?B?V1J3YlNISzA3Qkg0WGF5YzlicHY4bWJKMnZaTjI3cGZKSG14ellUMTA5ZWtU?=
 =?utf-8?B?S3UxODhDaUdNL3VLbWt2cjFmaU5ZQ3F6eGhXMFdHcnZnSnl5S1FiUTV5QlpX?=
 =?utf-8?B?WHdKaHVpMngxTC9LcStmTTZtZFNESHNXc05hak4wMDkzK2FBdXhtb1cvVmUz?=
 =?utf-8?B?ekloV3Rzb2pMd2Y3Y2dmTVZESXVzdVZ2SXgwYzVNSXlYYm1sOTZSb3FnTElm?=
 =?utf-8?B?RWpLeTA1THNheG5qcGFJT3VqakxVZ09pZXJHQUVXRzdSdkZHcFNHcndUQ1Fz?=
 =?utf-8?B?TU9PRWJOeVdKTFpWS05XVmZ1ajllSmo1K2xnUXNUSFd6K3pZZ0VidVk5ZlZK?=
 =?utf-8?B?QjNhYVRjSWJ4WEVMSi8zTWpja0JTbnoyMHMwZHFKRlA0T2NCQVRVV3BYN1lk?=
 =?utf-8?B?eUZ5c1pQVGsvdWljUTgrbDRYdEIzenJPZWg3T0t5ZjF1d1d1bTBjeVpqcHVk?=
 =?utf-8?Q?TCwVXUd3DS+hBj7WK4zhSZQ=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8074.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YVJWV0wvTEtvRGFhd0o0dXU3b0hoNWlmelU5MU94bnZ3d1ozdmFaZmRTUFRv?=
 =?utf-8?B?NFZYYjVGWnQ3ajRBYUlROTg4T05YQVpSdTJzUHRycHB2Y2t5T0x4eEJyamIx?=
 =?utf-8?B?OHhMekdlYjcyeDBBS2ZVSndZTUNWWW54RlBtWmJXT1dSa2lJWVRlbWI3UVhz?=
 =?utf-8?B?Rm5RQ0J1ajhVbUlDUFVxNUlJM3JMQnJiY1NHaUs1SzN4UlJkSUU0WmpqaWVs?=
 =?utf-8?B?YjRwMElaNlcrbGVkRndtOXhuTzZTaGl0ZDN1MXBLb2NzNlZuZmpHQnFYSTI4?=
 =?utf-8?B?QkhaV0RSYUFXWC9vR2pPMCtFazlFeEdjVGdQNXp5S1VyQXNEdU4yQ1ZwcjYx?=
 =?utf-8?B?N1laZmQ2QjU4ZFRlNjRWTnNHRDFVY0w4UllQYjNhZXkzbWZVeHRqVUNIU0tl?=
 =?utf-8?B?aDdqemcwVU14cTExd1VyYzh6Y25iaHkxcGsvb2wxV2FmczVaTXBjb2FMbm9G?=
 =?utf-8?B?ai9kdUw0S1oxYTJKTXZNTm1TTC9vdFgyWlVhczdxKytXa2pld2dMMDFsSzc4?=
 =?utf-8?B?cE1UOWlpUjVFZE1Rb1VJcUhySlp5MGhodytiSVczYWhSUnRZa3pjYmpNTklG?=
 =?utf-8?B?TnJSR1BxTTVJZVFSVXJ1ci9DMXJlUGZXUGhHTmV6Yk5hVzFjb21FNEc3dlBk?=
 =?utf-8?B?Z1pnWmE5ZUd0cW45cWI2SFpmODRPbzREU1BkaUVvMTh6bUlDZm1MNnppbzZH?=
 =?utf-8?B?VTdjc28ycUlTSThwK3RWSkcvaGMzQnVWTE92U1gwdXd3U0ZuYmdMNXkrbUwx?=
 =?utf-8?B?YjNJUDFyMXJLMmtTNmd2UXBuczVoTFFvbFFFRFZqQ3F1eHlKaTdnTGVmMTFn?=
 =?utf-8?B?alhoQnZMd3Uwc3NKU092Nk9VeFpoK0s5Qk1RYlo3RkZ2K0lFZjAweHh5QXZC?=
 =?utf-8?B?bEx4UGxPQkMzMnU5TUxqK3RWOEVPbFhjU2FLcCtUNzNTU3VMRWo5Y0FRL3k3?=
 =?utf-8?B?ajdRWUdpUUNLZ292eGhNUGUxdURKRzBTSG02bXNmbit6SUxEZjQ5RFVmVHFw?=
 =?utf-8?B?Sy9JSVNGSEw0U0Z0ZkR1dklkcTEyZWw1ZkpnZXUxY04yTDdIMGY3cTMvTlpG?=
 =?utf-8?B?QzJqTHFYMjU3NElBSkllWm1zTDBzTE1mOTNnekhGQ0FhT2IybXNhWGc0cGNy?=
 =?utf-8?B?U0xpMWJJMEtFZEZPYU5oazdPU1VyRFJNcFAzelhpMTdKZ2R6Z3JWY3Jwd011?=
 =?utf-8?B?K1V0cUJUZUNKOTNmL2hDdEh2ZURid1RtMzJKRkZKaHBTVXRveWhUTUI4UkU5?=
 =?utf-8?B?Wm9CYjMzMVNxbWZLUzFIODJiQ05QSktpb2k4dVdHOEJSckQrT0NNVVZUZDVy?=
 =?utf-8?B?ZHdsVW9PK3ladE44ajJQTDROUnNlM2ZtY3gwYmtyMHh4MXFwNm5wRlhydThZ?=
 =?utf-8?B?U0VYNForaW5WbWRYZ1ZmK3pEd084TXB3aHc4ZXZ1ZGtKV2NDY29VRlJ4b1h2?=
 =?utf-8?B?Um5pZ0NNSS82T0tTblF1M3RVTnorbXNLaW90Z05WenkzVEdjSkhrVjVldzBp?=
 =?utf-8?B?OXFidXU0WW1ZZlJmOFVJZUhGajlBQlg5RkZXVS9CZGZsSmpZd013NDFEeWhO?=
 =?utf-8?B?RnRGVnBEdFB4THRoRTRWWTd6aGJXRU5oY21iR2JPdFBYK2pVb1pETUdTaG93?=
 =?utf-8?B?dGJkQzhzZVNYbVV4WDF0aEYzN2dkdXZYZkdUcC9jOURtYW94UTMwNi9sT0Qx?=
 =?utf-8?B?aEpHZGdxTU5yc3poa0lXOVFiMHdlWjJzUDZqYmh4L3l5a3gvcDRxUjJsZTUy?=
 =?utf-8?B?NlRGVFBUNTg1SkJXSS9ZNlZDRCtFU2g5SG80QjliTlBLNTJaS0xpV2NuTVNG?=
 =?utf-8?B?Vm5wM01YcG5nNklCcU8ydEcrOUlzYytSMHFlNFUvV1BmUHRvcEtLVmVxb0RL?=
 =?utf-8?B?RjVCNmZkVHZyUyttdDZWbUVSRVBHVVV5a0Y4WFRDQmN2bUNzMHYzVis2bnVB?=
 =?utf-8?B?Mm8zMVNLTGpBcVZ2OEFKeHZ5UDZaYzBVZGVqM2JUWGFUcThGaUxuOXFtQjJ6?=
 =?utf-8?B?MUp2ZG14TjI5MnROdWNJek56NkZxd1BIZC9DWXZrWDdmOXJ2dmNxQlVxbjFT?=
 =?utf-8?B?UU1VanpWbEQrZitPbTdEQ09FS1hrVms5QlQ5WUs2VzFPOGFvdU1FRWNhc0lL?=
 =?utf-8?B?bXc5ZHRRbXZwRyttcHZHOElPVFFYK0hXaERaVDdKczhOOGwzcjVqSy83RDZh?=
 =?utf-8?B?Ynh3TWY2WFkzSEdzVys0MXIvYWZLT01lODFFVWRrU1lXSlJaRGQ4RTJnYkVN?=
 =?utf-8?B?SC9GV3lXVE8zSmZMSmY4N2tISXBuUFd2RGVJTmY2OTN1ZncxTVk1ak1wbmhp?=
 =?utf-8?Q?yHKV2VcFw0LX7CKbsz?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8074.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ac7d08f-b1ed-49be-6d74-08de56865b33
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2026 11:40:18.8835 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PcXwY9E7ZYwbyA208tpUouKR8sY0CV3zE8Ga2PFBz/NsGeyRlk2/qrncXVIdVh/YUzq9/IE/vVnmOMrdBY9Bww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8786
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

UmVjaGVjay1yZXF1ZXN0OiByZWJhc2U9bmV4dC1uZXQtbWx4LCBpb2wtY29tcGlsZS1hcm02NC10
ZXN0aW5nDQoNClJlZ2FyZHMsDQpNYWF5YW4gS2FzaGFuaQ0KDQo+IC0tLS0tT3JpZ2luYWwgTWVz
c2FnZS0tLS0tDQo+IEZyb206IE1hYXlhbiBLYXNoYW5pIDxta2FzaGFuaUBudmlkaWEuY29tPg0K
PiBTZW50OiBNb25kYXksIDEyIEphbnVhcnkgMjAyNiAxMToyNQ0KPiBUbzogZGV2QGRwZGsub3Jn
DQo+IENjOiBNYWF5YW4gS2FzaGFuaSA8bWthc2hhbmlAbnZpZGlhLmNvbT47IFJhc2xhbiBEYXJh
d3NoZWgNCj4gPHJhc2xhbmRAbnZpZGlhLmNvbT47IHN0YWJsZUBkcGRrLm9yZzsgRGFyaXVzeiBT
b3Nub3dza2kNCj4gPGRzb3Nub3dza2lAbnZpZGlhLmNvbT47IFNsYXZhIE92c2lpZW5rbyA8dmlh
Y2hlc2xhdm9AbnZpZGlhLmNvbT47IEJpbmcNCj4gWmhhbyA8YmluZ3pAbnZpZGlhLmNvbT47IE9y
aSBLYW0gPG9yaWthQG52aWRpYS5jb20+OyBTdWFubWluZyBNb3UNCj4gPHN1YW5taW5nbUBudmlk
aWEuY29tPjsgTWF0YW4gQXpyYWQgPG1hdGFuQG52aWRpYS5jb20+DQo+IFN1YmplY3Q6IFtQQVRD
SCA0LzRdIG5ldC9tbHg1OiBmaXggcmVkdW5kYW50IGNvbnRyb2wgcnVsZXMgaW4gcHJvbWlzY3Vv
dXMNCj4gbW9kZQ0KPiANCj4gV2hlbiBwcm9taXNjdW91cyBtb2RlIGlzIGVuYWJsZWQsIHRoZSBk
ZXZpY2UgcmVjZWl2ZXMgYWxsIHRyYWZmaWMgcmVnYXJkbGVzcw0KPiBvZiBkZXN0aW5hdGlvbiBN
QUMgYWRkcmVzcy4gUHJldmlvdXNseSwgdGhlIGNvZGUgd2FzIHNldHRpbmcgYm90aCB0aGUNCj4g
cHJvbWlzY3VvdXMgZmxhZyBBTkQgdGhlIERNQUMvbXVsdGljYXN0IGNvbnRyb2wgZmxvdyBydWxl
cywgd2hpY2ggaXMNCj4gcmVkdW5kYW50Lg0KPiANCj4gVGhpcyBwYXRjaCBtYWtlcyB0aGUgRE1B
QyBhbmQgbXVsdGljYXN0L2Jyb2FkY2FzdCBjb250cm9sIGZsb3cgcnVsZXMNCj4gY29uZGl0aW9u
YWwgb24gTk9UIGJlaW5nIGluIHByb21pc2N1b3VzIG1vZGUuIFdoZW4gcHJvbWlzY3VvdXMgbW9k
ZSBpcw0KPiBlbmFibGVkLCBvbmx5IHRoZSBNTFg1X0NUUkxfUFJPTUlTQ1VPVVMgZmxhZyBpcyBz
ZXQuDQo+IA0KPiBGaXhlczogOWZhN2MxY2RkYjg1ICgibmV0L21seDU6IGNyZWF0ZSBjb250cm9s
IGZsb3cgcnVsZXMgd2l0aCBIV1MiKQ0KPiBDYzogc3RhYmxlQGRwZGsub3JnDQo+IA0KPiBTaWdu
ZWQtb2ZmLWJ5OiBNYWF5YW4gS2FzaGFuaSA8bWthc2hhbmlAbnZpZGlhLmNvbT4NCj4gLS0tDQo+
ICBkcml2ZXJzL25ldC9tbHg1L21seDVfdHJpZ2dlci5jIHwgMTYgKysrKysrKysrKy0tLS0tLQ0K
PiAgMSBmaWxlIGNoYW5nZWQsIDEwIGluc2VydGlvbnMoKyksIDYgZGVsZXRpb25zKC0pDQo+IA0K
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvbWx4NS9tbHg1X3RyaWdnZXIuYw0KPiBiL2RyaXZl
cnMvbmV0L21seDUvbWx4NV90cmlnZ2VyLmMgaW5kZXggMDI4ODQ0ZTQ1ZDYuLmIzOGJhOTAyMmVh
IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL25ldC9tbHg1L21seDVfdHJpZ2dlci5jDQo+ICsrKyBi
L2RyaXZlcnMvbmV0L21seDUvbWx4NV90cmlnZ2VyLmMNCj4gQEAgLTE2ODIsMTMgKzE2ODIsMTcg
QEAgbWx4NV90cmFmZmljX2VuYWJsZV9od3Moc3RydWN0IHJ0ZV9ldGhfZGV2DQo+ICpkZXYpDQo+
ICAJCQlkZXYtPmRhdGEtPnBvcnRfaWQsIC1yZXQpOw0KPiAgCQlnb3RvIGVycm9yOw0KPiAgCX0N
Cj4gLQlpZiAoZGV2LT5kYXRhLT5wcm9taXNjdW91cykNCj4gKwlpZiAoZGV2LT5kYXRhLT5wcm9t
aXNjdW91cykgew0KPiAgCQlmbGFncyB8PSBNTFg1X0NUUkxfUFJPTUlTQ1VPVVM7DQo+IC0JaWYg
KGRldi0+ZGF0YS0+YWxsX211bHRpY2FzdCkNCj4gLQkJZmxhZ3MgfD0gTUxYNV9DVFJMX0FMTF9N
VUxUSUNBU1Q7DQo+IC0JZWxzZQ0KPiAtCQlmbGFncyB8PSBNTFg1X0NUUkxfQlJPQURDQVNUIHwN
Cj4gTUxYNV9DVFJMX0lQVjRfTVVMVElDQVNUIHwgTUxYNV9DVFJMX0lQVjZfTVVMVElDQVNUOw0K
PiAtCWZsYWdzIHw9IE1MWDVfQ1RSTF9ETUFDOw0KPiArCX0gZWxzZSB7DQo+ICsJCWlmIChkZXYt
PmRhdGEtPmFsbF9tdWx0aWNhc3QpDQo+ICsJCQlmbGFncyB8PSBNTFg1X0NUUkxfQUxMX01VTFRJ
Q0FTVDsNCj4gKwkJZWxzZQ0KPiArCQkJZmxhZ3MgfD0gKE1MWDVfQ1RSTF9CUk9BRENBU1QgfA0K
PiArCQkJCSAgTUxYNV9DVFJMX0lQVjRfTVVMVElDQVNUIHwNCj4gKwkJCQkgIE1MWDVfQ1RSTF9J
UFY2X01VTFRJQ0FTVCk7DQo+ICsJCWZsYWdzIHw9IE1MWDVfQ1RSTF9ETUFDOw0KPiArCX0NCj4g
IAlpZiAocHJpdi0+dmxhbl9maWx0ZXJfbikNCj4gIAkJZmxhZ3MgfD0gTUxYNV9DVFJMX1ZMQU5f
RklMVEVSOw0KPiAgCXJldHVybiBtbHg1X2Zsb3dfaHdfY3RybF9mbG93cyhkZXYsIGZsYWdzKTsN
Cj4gLS0NCj4gMi4yMS4wDQoNCg==
