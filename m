Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A44FCD4A5EE
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 Jan 2026 03:11:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DCD4F427A6;
	Fri, 16 Jan 2026 04:11:52 +0100 (CET)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012018.outbound.protection.outlook.com [52.101.48.18])
 by mails.dpdk.org (Postfix) with ESMTP id 2BD8F4014F;
 Fri, 16 Jan 2026 04:11:51 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=phsQK5Gt88t6TkMcn0kN3DurzhkSzTJ80kGtds/LsKxmvHr6sG1qyH5+q5eHaOGwfG+r9os5Icl7JU44yscTGeKV0JcAp1EThtKRdoKQU14M5iTiByVXIfpEekm5tlFt3KN4uzRTJWIHi13bBxvTPc0K9U5JVBBo9b5c4KO8P6lgR1za0QUwQUlN9WeilEic2vdw7k7mmBLUm/wjnEM9o6xNGN1PLpwlNaVdDCepCkMryeq/luymUMzTGkAe6W9n1JTqWBdpKHfpeGvimiIJsK+F5LUxyP8D8cYGyFOdu3FcVYQW7wsJT7ad346cRvA05/FN91fMmi/f2fyD1bWUxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FRcOCE/Bl+73MGKnM4ky2WbC5cMM2r3MdGmftrd0U50=;
 b=e/fQ/1yxCHs/8dECQR8asqaRwIFyITfcI/C4VFykPC6cNJfBamZ/SFmLV0//TFrfxsth3SB4VT88A/QyI4UvQRYP3v9P9SBW44TNuV7l08xsaHPUuVQJg94/gHLN+N/cwRSkAvwwgzYsXcc/RneF1tQq3SttMShM7Oz89ysdY20cx94nVEhhdFab4f9iZYoqt9DeGBqB3pr6S88CGJw96NtLI5e7V9WkVaSrL2AjlqIfLsOpuNKJM9ABi6mXXTsG3NMAnE4VbDtISKHzC5ihUJpvD0wsphdvca2a0TrkeEeToC9899B2fQshDv3YjbQONzL/YB1UUXwjAQEdkhn8VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FRcOCE/Bl+73MGKnM4ky2WbC5cMM2r3MdGmftrd0U50=;
 b=lnvUCGhbz2PAi42xD9i9qbx6DXZ3yccqf2O2Zg+MZ2Knhc1x9Y2GJXtMrN3Jkoy/HnG8WfUw4MrFzTh8Wtc0tYajFGLLsS/TlB1J+F96Q5jeqAD8lV811bUIkcXjq9BGgNyToSxdHVM3MyDWt8n9RMIdB2iHOUcPVGC4h3/xXZfGgNjJ9f/wZWFwzR4WlPQ20HcG3JaFaqrE6DvR+LkTGlkNcOTDkNTnDkU3J7/Iwq2JWmPARjtpmF/ZhMYgFX3fA/AxXlnR8tPfSK1o0yJq1wQix13h4kcjXBDUxx0aShojxN4MKNcWMKpTiMpeXvPPdjj0Nuzmc3VZlDi0JefN3g==
Received: from BN9PR12MB5098.namprd12.prod.outlook.com (2603:10b6:408:137::8)
 by PH7PR12MB8014.namprd12.prod.outlook.com (2603:10b6:510:27c::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Fri, 16 Jan
 2026 03:11:48 +0000
Received: from BN9PR12MB5098.namprd12.prod.outlook.com
 ([fe80::78ba:2665:1445:6730]) by BN9PR12MB5098.namprd12.prod.outlook.com
 ([fe80::78ba:2665:1445:6730%5]) with mapi id 15.20.9520.003; Fri, 16 Jan 2026
 03:11:48 +0000
From: Chenbo Xia <chenbox@nvidia.com>
To: Maxime Coquelin <maxime.coquelin@redhat.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "david.marchand@redhat.com"
 <david.marchand@redhat.com>, "stable@dpdk.org" <stable@dpdk.org>
Subject: Re: [PATCH v2 3/3] vhost: fix mmap error check in VDUSE IOTLB miss
 handler
Thread-Topic: [PATCH v2 3/3] vhost: fix mmap error check in VDUSE IOTLB miss
 handler
Thread-Index: AQHchWteYuGwLdwqp0KAscObIBMFqbVUIM4A
Date: Fri, 16 Jan 2026 03:11:48 +0000
Message-ID: <1CC432C8-09E9-447F-AC87-078172EC10E1@nvidia.com>
References: <20260114153445.2751895-1-maxime.coquelin@redhat.com>
 <20260114153445.2751895-4-maxime.coquelin@redhat.com>
In-Reply-To: <20260114153445.2751895-4-maxime.coquelin@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5098:EE_|PH7PR12MB8014:EE_
x-ms-office365-filtering-correlation-id: 9e58d814-edf4-483c-d297-08de54acfc8d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?RFJrd0dZbi9iWUQvQWZDYnNlNTVVcnIwMlQ0aU5NbWV4UWltRnlTdkY3RGhU?=
 =?utf-8?B?Q0tROXBSODJlWG9zVEFQMnhRZVNvSUw0TnhWU3JpZGlCRDFYeE1QUjhEYnNi?=
 =?utf-8?B?ZER2b3JnVGlaNStDVldNRU5nYjA1QXppbTVQRWJPcU5TcnFISmpjZ0MrK2Q0?=
 =?utf-8?B?d1Zla0llRklWVS82MU03SGwzUmJZQ1QrTnJ1YjFGMmxJQUwxeVFOUmNGK1h2?=
 =?utf-8?B?Nk1YMWxPbDJPTGJxVVZKWWladUdLK0svR1hTM1BlbGZVM2lhdGVlWGRZcnBG?=
 =?utf-8?B?N0dhN2VtV2JCUmFkL3VVeTN4dmhFbm1aNnFuQUh0WFMvNW9YSUJMNFJRYVZm?=
 =?utf-8?B?MnBFMEtZOWFrcVhvS3ZIbm5IYXdGZm1qWlZsNEV0b0JteWlMNStoWUFubW9y?=
 =?utf-8?B?eG5QZmNQdW5URjNHeGNlZlVFUkhyRWVDbGlYc3RSRkhWUURjZVZlV0E3NEZm?=
 =?utf-8?B?STlCSk5QUUZjdGdGQ1pFbldWcFpEc1F2MWlzQWVzZHo1RUxUcHAxY1JaWm9N?=
 =?utf-8?B?anRBZzUySjhoNjBYZ2ZGbjZQWGNNYTlOOTdQT3EwM0pXb0wzc2U0Q0k4cHhM?=
 =?utf-8?B?TVBOOXpzRytDQi9iZDlUSlM4amR2ZnMrak43UGJMbmZTTlIvV2hEWW5jM0Zk?=
 =?utf-8?B?d0VMUjlwaTRHWjNWMENDcnA2QnhrUnBmbWJlRHFaTnU5dXU3L3V5OWd4ZU82?=
 =?utf-8?B?OW5vTTEzMTlGeTFpK2VVS1pKelZCcm41NzJLdXErWFpFQ0JLamFYNzMxTTZJ?=
 =?utf-8?B?blhlZ2hLT0Zkd3lyaUlWV2JOMHozd012RUdzeEJ5UWdLdWN5dktyZEZyVE5Y?=
 =?utf-8?B?UnBRTVgrNVZUNmIzTnRnejRFaUVxTmY5cG55UWplM0ZsM3dxcXFxZVU5RzE2?=
 =?utf-8?B?bnQ4Z3RCT2toUXpYcFJqQjg3SldiR3Z5di9qWjFwN29ka0prNkdab2U2bGZQ?=
 =?utf-8?B?cm42WVJzTWYvc2ZsWEpNeUt6b01MN2d2cDhHZFB2Mng0UWlIT09xMTlsUFpx?=
 =?utf-8?B?WE1wZWJBc2oxRU5NOGpIVVd3RmRjU3V3RnUwVXllcC9qUjRra1gzWGJMQnVW?=
 =?utf-8?B?Rm9wQVA4VmZzMkVJeXNJZElKTWRhNW9xMis2dm9VWVRTNGNJdHhQazJFYmh4?=
 =?utf-8?B?WWlpTytGNHRJV0tOSVE4b3lDOVNvWnAzKzRMSmsycGphcFZ2YWtBYnVQNnk2?=
 =?utf-8?B?bVJFOWM0SmdMdWNPTHB3UTV4OFNScXJoMVVqTjZRSnBqbHpEcXdDQTJUNWhO?=
 =?utf-8?B?SGpnemdvVm5tSlV4ckhiN3NvUXU0RHBPUG9CUUhHa3ZEb0ozMnhiMzExNkdX?=
 =?utf-8?B?VjFubGN3OUNwbWl0dXpFK0JWRzFJNHkzUlRjOXBrUG0zRkg5ZjJEQnB2MlBo?=
 =?utf-8?B?SUp1T2IwWkRYdnJnR2ZWSHVQaU5qZVhvZ0FwaFhGNCtlRkl3enhHTW9nM250?=
 =?utf-8?B?SllneU0rcTVUY1RPQURNdUJwZW4zMFJtMFloazVETXpEOHdFRUgyR3BrTUxN?=
 =?utf-8?B?NHN4MWpWaEc5Z1RTdFZjUWZOVUVQbyswUlR3b3VoUWtWL0ZSQmFhVjJEMU1I?=
 =?utf-8?B?cmlJQkJ1OW9NL1NsSFRwZ2liVXhqQUJaTnFzSXBONVhSelVBN3R4NTUzWFVX?=
 =?utf-8?B?THVDeEZ4VSsxNEZZWnZaSWlkOXhWZzh4aXo5NnluSXZXVjFRWmVCOFZhSHNx?=
 =?utf-8?B?SEhHM2thYlhZR082RHpqVW5TSm5kODBya0FETlphQ09HQi9DeHArSGZCQit5?=
 =?utf-8?B?M0hQZS9UVHVrMHBaaHEvQkU1blRlUi9CaVhBTUo5a3IvT3NWZS9MbW1vNmFW?=
 =?utf-8?B?WkRTUDNLdlBNa3JEKzBjckxIOTZoSExkR2daKzhnVnpCMGJpWVQzeHBZSnVo?=
 =?utf-8?B?VDNhYTcydFBlaDU3L0FlVWJYTGVrdEJvcXpQOW03QjhldktvMnFZVk1OSlhK?=
 =?utf-8?B?bGF3bjhLNkd3MThzYUxWRWNwM2VKYlRLMi85UkJVdGwvaEgyYmQvRlBXU2VH?=
 =?utf-8?B?ZDJaTlZLMFc4SkxhNVJNSnVUak56SXNEcDJkZkM4dEUwZzFub3EwYVNHODBs?=
 =?utf-8?B?TUZ6OGlONjJHWkpaSnBTQ0RiTldqOUZHczJlNm0zVFR2aWRFMnRJN1g3RDJ3?=
 =?utf-8?B?bVBzZVQ2ZGpLRGdyellPdXRueXA3VzIrRSsrSzBQVnBUMHRtMktlaDE5RTZX?=
 =?utf-8?Q?zmi7K7HglqJbWdvFoJjTGCA=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5098.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RTNRWVYzNGFqL3FXeUhVL2FNN2tpNEpNWFlXU2VxWFBPaHczajZzeFZuZWcv?=
 =?utf-8?B?a0VoQWxZRG9INEo4TkZsTHBIdDJKbXhqZ2tCMFAxaDhzVnN6Vlpmdit0bWkx?=
 =?utf-8?B?OXhxYU9EQ3JkVHFLS0t0cUY5bC9CK3pFSDBtaUtwd2UyVUYwM25MTS8zWk4v?=
 =?utf-8?B?eHNrQUJJZTRrUmtnUk9PbU1wdnp2RGxXY3l3ODdFclg1elNNbTU0VGJBbmhv?=
 =?utf-8?B?U25SVlRjZ05PbDlQejFLelQ5ckNqZDRCcXFiQWlFUVNVaW9kRTlqeExjMnVj?=
 =?utf-8?B?V2xqR2RycmVHTmoyaXBmVXdYc3lzeDlINnB4Q2pNT2wyWmwvTEUrZm5LeTY0?=
 =?utf-8?B?My9GUitBU1V3ZGx1OHI1WnR5b1gyVThaWEtBbEhqd2QwazlKa0RQV01PZ203?=
 =?utf-8?B?MEI5dlJxQm1TK2x4NWtUVXI0UDBlSkJJMmVuNkdNcUh3RGNTMEUzRW5wNFRE?=
 =?utf-8?B?b0M3SkIxTG4wQm40eDd0TFNldjJuOXlYNmkxVGRKY0FiQVIzbUkvZFhaaXRx?=
 =?utf-8?B?VDB3Sko4bDM4ZWFLa2dySGk3dmliUTRqTlRRQkFhVHFMYmE3RHoyS3pmVlp3?=
 =?utf-8?B?TlJ0NWN6MTNmNUhCaExzaVlpdmtINEkvbGhldHJOKzRiSkJ0VVJDRzAxUTdi?=
 =?utf-8?B?b3pUaWd5Yzh3YUwrV1RDOEJWeFQxR0VMN0hlQ2YyZjBseVd2eVIwQnlac3JR?=
 =?utf-8?B?YWM2Q212RS9DRzNIeHU0WU1Ob2RZaFR2QkdCQ0U5dUkrMS9BcGVUcktrM0tp?=
 =?utf-8?B?aTI2b05OeVBBNnNNaThLK3E3TFRGdzBOckw0dUJqVWZvQzdjSXVvY3pXYzU3?=
 =?utf-8?B?dnNxT3p2Zy9MeEoybkJJSmRpRzVRV2QrSzVlMUFKRnR2SFJVNnQ4ejgrK2dm?=
 =?utf-8?B?cDc1ZDArcmpXRGY5Nko1LzgxL1h4cW16WE1hdHBHcTJzekNYSG5nUG4xWFpn?=
 =?utf-8?B?SDJkcVRzR3oyYmhpb1NCeDBidjRYdGpZZ3dSTjgrRWxmbkcxRHlIaVBBRkQ3?=
 =?utf-8?B?NVhZLy9zRndXWlpUbWg2VE1ZQUxObnByVlF5ZWlYU096VnpscWhybWpYdTZZ?=
 =?utf-8?B?WTNDanRMR1FRZFhLbmE3QzBtd0Y2a2Z5TXU2OUNGWDJTTms5aG9zUnFTM2Jx?=
 =?utf-8?B?Y2toVDE2SHI5dWJXcWpkazQzQWVXT3drdzd1SUxCd0RUUGZkQm9ZdHJKcjZC?=
 =?utf-8?B?eVoxT29BY3NkcDhMdGhwdHZmQ0JjcHF6eS8rYlRXOXV2Z1BuRXdtVVRVYzZ0?=
 =?utf-8?B?VEpBblJHK1VVeXJYT1AzOVgrVC95YzBxbXlvQ3lYaEUrcEl4eVRYRnRoTW0z?=
 =?utf-8?B?RDF3VmljSFZVaDNFNzY1YlcrSmxHeTVmNXVDUnp6OFhNTjArdXZNZnU4UFhm?=
 =?utf-8?B?OE05THhVdytxaVBVV0orU05YaWlsU1IvSWFncnFyMEdHNzdDeldEc0gyQ0RY?=
 =?utf-8?B?cFZaUDJZb1hYbm5uRWc5eENEU2cvNVI2N0JoU211NVRSV2M2aStVSUIzb0sv?=
 =?utf-8?B?SFh5cUozSlVBUkFiZ0h4YlhSbm9MOUlJUS82SDErR0wvd3cxR0o2SCtJcGNY?=
 =?utf-8?B?VldBQUtkd0RCUnYxeUpvZzBDbUNaTS9xSEVLanBYelZIdFZHMGoreVVkeld4?=
 =?utf-8?B?QWRES3hlWkY3R29iS3BnRExrOTJHUVE5V1N5NEd5ZUw4Mk1Qd2JyNmxRTFJj?=
 =?utf-8?B?WXZWWEF4VEc1OUJrVWxlTzhWQ2pZc0QzN0x4SHNIY2k0S0d1OCtBQU1tSWlI?=
 =?utf-8?B?enJFVUlpc2ZrUWRvd0xjOUp3ZjVrTVhRVVY1NFFRSHV4WTVlSzV6UW4reUFK?=
 =?utf-8?B?RS85bURMbzNneWdpMVFsQ2JwcThUOGFGemp3WVdLLys2QTJLTXhCVS9OaUth?=
 =?utf-8?B?Y2Z5NnFhYUorcVlqeEV1eGZWbEpRbWxRTmFLQ0dFcGVHZWoxUUczSDROcWlC?=
 =?utf-8?B?ZHhaUHlTOUZXTTV4YnVOZGdhN0VSRlVocDRqK0wvRktvTmttY3N6UjByT3ZP?=
 =?utf-8?B?WmhsbnhLamJ3Z1luenJDUlU4VHVWZ2pFRDZGZ2hyOTNQMWJOMHpydGcremdI?=
 =?utf-8?B?SmdxNjFDSXFvOFNDOU5KcTU3WTliZFdCQW9qenlxSDVHZDhjR0ZBZVpieUxO?=
 =?utf-8?B?L1huNDVUaFplTTJNMWlCTkduS3R4OUZiakJJdGMxSmxRTUNtZ2lGR2Z1b1ZZ?=
 =?utf-8?B?ajRxUlE4cGJFRDNpSFFFSVRQcHhiQzMwQmZiNlo4eTllUnBvWTVRU2V1Vjlk?=
 =?utf-8?B?WG9JZkNwbFRFL0RvR0EwSy9mem9WNDZxdG1pdTIrendvS0N4c2xuaTFVT3FX?=
 =?utf-8?B?emlXSno2cjhRb05DM2psdXFsenNRRXVtZXBJR0Jzd21OMHd6Wldjdz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7AFB45527C869B459EC42DAC674A143C@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5098.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e58d814-edf4-483c-d297-08de54acfc8d
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2026 03:11:48.1182 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: A/Wtlb5fGJg5q6par/PhuQUCfGWTiDJsqSE/ikrs1kyS+hJ2nYWJ9BXDx/HVytIvPiXhJWDP+lpNypzZGQ1ggg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8014
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

DQoNCj4gT24gSmFuIDE0LCAyMDI2LCBhdCAyMzozNCwgTWF4aW1lIENvcXVlbGluIDxtYXhpbWUu
Y29xdWVsaW5AcmVkaGF0LmNvbT4gd3JvdGU6DQo+IA0KPiBFeHRlcm5hbCBlbWFpbDogVXNlIGNh
dXRpb24gb3BlbmluZyBsaW5rcyBvciBhdHRhY2htZW50cw0KPiANCj4gDQo+IFRoZSBtbWFwKCkg
ZnVuY3Rpb24gcmV0dXJucyBNQVBfRkFJTEVEIG9uIGZhaWx1cmUsIG5vdCBOVUxMLg0KPiBUaGUg
Y3VycmVudCBjaGVjayBmb3IgIW1tYXBfYWRkciB3aWxsIG5ldmVyIGRldGVjdCBtbWFwIGZhaWx1
cmVzLg0KPiANCj4gV2hlbiBtbWFwIGZhaWxzIGJ1dCB0aGUgZXJyb3IgaXMgbm90IGRldGVjdGVk
LCBhbiBpbnZhbGlkIGFkZHJlc3MgKC0xKQ0KPiBpcyBpbnNlcnRlZCBpbnRvIHRoZSBJT1RMQiBj
YWNoZSB2aWEgdmhvc3RfdXNlcl9pb3RsYl9jYWNoZV9pbnNlcnQoKS4NCj4gU3Vic2VxdWVudCBh
dHRlbXB0cyB0byBhY2Nlc3MgdGhpcyBhZGRyZXNzIHdpbGwgY2F1c2UgbWVtb3J5DQo+IGNvcnJ1
cHRpb24gb3IgY3Jhc2guDQo+IA0KPiBGaXggYnkgY2hlY2tpbmcgZm9yIE1BUF9GQUlMRUQgaW5z
dGVhZCBvZiBOVUxMLiBBbHNvIGFkZCBzdHJlcnJvciB0bw0KPiB0aGUgZXJyb3IgbWVzc2FnZSBm
b3IgZWFzaWVyIGRlYnVnZ2luZy4NCj4gDQo+IEZpeGVzOiBmMjdkNTIwNmM1OTggKCJ2aG9zdDog
YWRkIFZEVVNFIGNhbGxiYWNrIGZvciBJT1RMQiBtaXNzIikNCj4gQ2M6IHN0YWJsZUBkcGRrLm9y
Zw0KPiANCj4gU2lnbmVkLW9mZi1ieTogTWF4aW1lIENvcXVlbGluIDxtYXhpbWUuY29xdWVsaW5A
cmVkaGF0LmNvbT4NCj4gUmV2aWV3ZWQtYnk6IERhdmlkIE1hcmNoYW5kIDxkYXZpZC5tYXJjaGFu
ZEByZWRoYXQuY29tPg0KPiAtLS0NCj4gbGliL3Zob3N0L3ZkdXNlLmMgfCA1ICsrKy0tDQo+IDEg
ZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZm
IC0tZ2l0IGEvbGliL3Zob3N0L3ZkdXNlLmMgYi9saWIvdmhvc3QvdmR1c2UuYw0KPiBpbmRleCA4
OTdkZWU5ZjFiLi4wYjVkMTU4ZmVlIDEwMDY0NA0KPiAtLS0gYS9saWIvdmhvc3QvdmR1c2UuYw0K
PiArKysgYi9saWIvdmhvc3QvdmR1c2UuYw0KPiBAQCAtODYsOSArODYsMTAgQEAgdmR1c2VfaW90
bGJfbWlzcyhzdHJ1Y3QgdmlydGlvX25ldCAqZGV2LCB1aW50NjRfdCBpb3ZhLCB1aW50OF90IHBl
cm0gX19ydGVfdW51c2UNCj4gDQo+ICAgICAgICBzaXplID0gZW50cnkubGFzdCAtIGVudHJ5LnN0
YXJ0ICsgMTsNCj4gICAgICAgIG1tYXBfYWRkciA9IG1tYXAoMCwgc2l6ZSArIGVudHJ5Lm9mZnNl
dCwgZW50cnkucGVybSwgTUFQX1NIQVJFRCwgZmQsIDApOw0KPiAtICAgICAgIGlmICghbW1hcF9h
ZGRyKSB7DQo+ICsgICAgICAgaWYgKG1tYXBfYWRkciA9PSBNQVBfRkFJTEVEKSB7DQo+ICAgICAg
ICAgICAgICAgIFZIT1NUX0NPTkZJR19MT0coZGV2LT5pZm5hbWUsIEVSUiwNCj4gLSAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAiRmFpbGVkIHRvIG1tYXAgSU9UTEIgZW50cnkgZm9yIDB4
JSIgUFJJeDY0LCBpb3ZhKTsNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAiRmFp
bGVkIHRvIG1tYXAgSU9UTEIgZW50cnkgZm9yIDB4JSIgUFJJeDY0ICI6ICVzIiwNCj4gKyAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBpb3ZhLCBzdHJlcnJvcihlcnJubykpOw0KPiAgICAg
ICAgICAgICAgICByZXQgPSAtMTsNCj4gICAgICAgICAgICAgICAgZ290byBjbG9zZV9mZDsNCj4g
ICAgICAgIH0NCj4g4oCUDQo+IDIuNTIuMA0KPiANCg0KUmV2aWV3ZWQtYnk6IENoZW5ibyBYaWEg
PGNoZW5ib3hAbnZpZGlhLmNvbT4NCg0KDQo=
