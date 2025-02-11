Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B97F6C0219E
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Feb 2025 08:53:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 02878402EA;
	Tue, 11 Feb 2025 09:52:41 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 5335C402B9
 for <dev@dpdk.org>; Tue, 11 Feb 2025 09:52:40 +0100 (CET)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51ANSPsN031783;
 Tue, 11 Feb 2025 00:52:39 -0800
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12lp2174.outbound.protection.outlook.com [104.47.55.174])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 44qu5ngx4h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 11 Feb 2025 00:52:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CMQ6x/htefoOLLP4LbE3WS7BJol95RQa9VZisUBRLJ72PxE4dus8y6ulMOoQETdz7m9B1xpcwyPeiJShrY597nNJElSUs9zQdWFHEaozStJ/i6KtIMg/ofcY4nKlXRjpmHg5ogVJr8gSD9PiBBsICCM4hbjpWwsoAJSNvcDk3T828b4btX1p2TAzlwFAmWEiZrmkvG1qVzb74sye0apzzJAflXO7XPykVoNfxWkhw9hbvi18bE83fBzOCiGNcGDqIaA1MpVRrYAaIcTIuRLUDsOlrDSsRITZ3VfjtAhrWBAOREIjGuHoK3IEWCfCzxDo5OnIFk/NdcduYaF6vWqx+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MUHlSduBYMfmGO8OfBjbdHaA8R9EFfidmaiweAwvnVA=;
 b=qOX9f4rxkAl2tZGg3OQTbeixXgrxMfTHkv4glWVu4a7avLSDjKPdWgBPj5uixebV+HxNlyqgWE4ejL7wV+jm35Q3aeo0WbrwWl0hnqkK4VtsqZRfw/lRo88ycYfC4aqa5/jHiYAejwGMjrFAetmpxdgOS/y050aS7z++wld67GSOrjPvnzsxU1VCJQHsOLQtVUDEF7I0ITV5e9Ff9Y49eoiAhnYAmNIp7mADWaZXF3gfRvhdOHlF76zBqZvmHT4/Cgweb57d0bPoEwF28kajXouB83bK4NVkRK7izFlzRAsIQbDS02CQnRGd4AQtmCV1/7z0pFXNheUmhZOmgjaFfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MUHlSduBYMfmGO8OfBjbdHaA8R9EFfidmaiweAwvnVA=;
 b=txzs4apGgv5TJXOCFNzpD0AS0uNZlP1+XaewShfMGSXHEks51grpgo7gPXwbfe6IpT7NCnHMU0+mR0dN3f+CBGMIzp0JnuNnM9fAnkMq6AzYNTCkDXMl7hmOGtCpvOBEAp++cEgWbcdho4vKE2xxic7GiY5b3NOkoXHmomjVx8g=
Received: from CO6PR18MB3860.namprd18.prod.outlook.com (2603:10b6:5:34d::12)
 by CH0PR18MB4290.namprd18.prod.outlook.com (2603:10b6:610:ba::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.11; Tue, 11 Feb
 2025 08:52:37 +0000
Received: from CO6PR18MB3860.namprd18.prod.outlook.com
 ([fe80::7a27:a7e4:65d5:7eba]) by CO6PR18MB3860.namprd18.prod.outlook.com
 ([fe80::7a27:a7e4:65d5:7eba%6]) with mapi id 15.20.8422.021; Tue, 11 Feb 2025
 08:52:37 +0000
From: Sunil Kumar Kori <skori@marvell.com>
To: David Marchand <david.marchand@redhat.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: Jerin Jacob <jerinj@marvell.com>, "fengchengwen@huawei.com"
 <fengchengwen@huawei.com>, Kevin Laatz <kevin.laatz@intel.com>, Bruce
 Richardson <bruce.richardson@intel.com>, Tyler Retzlaff
 <roretzla@linux.microsoft.com>
Subject: RE: [EXTERNAL] [PATCH v3 4/6] trace: support dumping binary inside a
 struct
Thread-Topic: [EXTERNAL] [PATCH v3 4/6] trace: support dumping binary inside a
 struct
Thread-Index: AQHbe+OKm8hg65o+IkuRjxYAWqduELNByw9w
Date: Tue, 11 Feb 2025 08:52:37 +0000
Message-ID: <CO6PR18MB38608A210D1A7ED6477A0700B4FD2@CO6PR18MB3860.namprd18.prod.outlook.com>
References: <20250124161408.310581-1-david.marchand@redhat.com>
 <20250210174424.3364021-1-david.marchand@redhat.com>
 <20250210174424.3364021-5-david.marchand@redhat.com>
In-Reply-To: <20250210174424.3364021-5-david.marchand@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB3860:EE_|CH0PR18MB4290:EE_
x-ms-office365-filtering-correlation-id: 8e057a4c-02e3-4eb7-4607-08dd4a796f4a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?aXFSUEd0VUdYL1FZVEpQanpmN1lON1U1VFl3eTZVeThINUdYa1VIbHFjak50?=
 =?utf-8?B?OTNCTGlxOXFTNmxGb2o0RitZbDdETmwzUW90ZWZ2T3dVS2lhQTAvd2wxMjVv?=
 =?utf-8?B?Q0loSTFlTzIwYXJBTkRwMnhEVTJCQ2R6aEVlZDl0L241TFRJQTE4dWU0N0VU?=
 =?utf-8?B?U3Z1WnZCbC9zVzE5NVlPTVZaQkswVFJXVi9XM3MvMzA2d2EzTThyNmYwWHdH?=
 =?utf-8?B?VndSVHBTUWVzTnlmNlZmdlNRckk1aW00MEs1aWRSODJHRVFkaENtbjUrSWVB?=
 =?utf-8?B?ejFITzB3MnlmcDV5a1gya1Q0V2JZbTE4RmF2TThtS21KTDV6ZFI1WUhkVW02?=
 =?utf-8?B?TEhQZDB2OXhWc2JjYmw2c0tnc0MyUm9tNE13ekF0SUtmUFZYa3hhVURJS2F3?=
 =?utf-8?B?OThTdWw4NHdaazhiVUQ1ZXRDTzJtdEhTbk9Bd2g1WmlQOUJGZDF4L2Ewd1Rh?=
 =?utf-8?B?UmMvUjdSM2NYS1NmeU1tOG5qdWJxdW1Hb2FBWUxNMk9zQkR6bXhjZ1lyVWdK?=
 =?utf-8?B?d24zbWIyV0cxdzh2S0RFTVZpTEFaMU9MRkRyRWR4RVhIeEUzMllYYXRzd0NQ?=
 =?utf-8?B?S1kwUVdEWWlqc2U4NGEyVHZNUm5nWjBTaEMzdnJUTWtkaXpOaytxUUgwU1F5?=
 =?utf-8?B?YU5EUUVuZnN6SlpUSFF0RUV4MjNFTUJ0dnFaZjhHUDZJYWFxakdzK3BaVlRJ?=
 =?utf-8?B?dUQzbW9qQlI2Tk9YM1VYbVJpMkppUytORXBWaTBvOGxMQnRGUkwwWjBBU2dj?=
 =?utf-8?B?TVYzN2xrSmNFdUlia1E3eVFQWDZ6SGNPUDg4eFdxd1JLbE9zZHpoNHJpSDZX?=
 =?utf-8?B?TnFacGVlYkdWdktaZlFtT0J2SXZZTDF5SVVFN0NiYUQxR1ZmTnJsNnhUanB6?=
 =?utf-8?B?azZ3ZHhMQm1jcEo3YXg0QmZWTTh0TzZ0eGwvb3duNENYMWVndjFuNDg0ZzZ2?=
 =?utf-8?B?WEZCMnd5cU4vNEpKR0krZENGbHJJeTRIVGhjQUFaU0p3R0wrai9FMjZselA4?=
 =?utf-8?B?SDRraXMwNUlsMWxnY0paeFZhUU1UY1RZVU5Yb2lWR2xVdXV2TUFadkJvc2dH?=
 =?utf-8?B?dzRMUzFUK3hFRXFycUdUckI5OEV4SDFJazVNR3F6ckc0TFRsT3JCa0dHREZs?=
 =?utf-8?B?TTZnaHVGWWtZUWswbGlmV1Y4WEI0UjRqc0x3bmxsMFRPK0o4RkVzTFR1UVVw?=
 =?utf-8?B?S0R3S3p0dURZL3VIMFlOcGlwTXdlam45K0dBUnQ3MkZaMVdvUkF4azcyR2pR?=
 =?utf-8?B?R1NBSGVMT3ZNdkw5MzVvR0QzN1kxek1XcWtNeVlMWnFxM20vUWZBUCs5SGZO?=
 =?utf-8?B?T3hJUVJTdkZWZ0MyNlNLbEp0eExjcU9xREx4RVMrZUVFdmhLcmtlWmw5ZzBp?=
 =?utf-8?B?KzdVWXd6VGxwTmsyRlpqMlFicDVGOXBSSmRUT1ZaVEdPRXdndHF5SHNoY2lY?=
 =?utf-8?B?ZzUvdTRzOGNpSHY0UUFUNVd6dmZtaTVvUEwrMTVnbUlYMUJYNVRBbDRBMVFP?=
 =?utf-8?B?eHREekRUN01tcWl2MTNZakYxT0RCQ2o0T2ZvZExrL254dXZmT2Z4THZEQXl4?=
 =?utf-8?B?bGJYZzJXZk1FZTBLUGh6a2FYYnhzNE1UeWNiRXRTaG5KZjAveFlQT2QvVW5w?=
 =?utf-8?B?MnJuOWtIN25FY212YVowUHNxTmo2cEpvWURWcVIyRFVvaDF2MDUxdk1rbzlY?=
 =?utf-8?B?N3FSSUVyS2E0NmI1TGVGNkx0VkFHWWRsOGZ2VkZwTmI4am9rMEdqaTJRS2px?=
 =?utf-8?B?Y3VRTW9vYkFUMFpxLy96SHpvdnd5TWdDVnRvck1BSkJMU1N0Qm1LSVRaOUoy?=
 =?utf-8?B?T1RlOStPUUFHbHYzbk9EYVV2TEJhUXlzNGJrSWJjQzRGTkQ1ZDU0MkxxRmhC?=
 =?utf-8?B?WTJTL0NQaElTVDVOeFRTdE54SHFadFlwZ3daL1RzZWN2WFcrcHdhTEpIYk5N?=
 =?utf-8?Q?uPoblHsAJIRUiV0aRMpnIpmweKok8esZ?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB3860.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T29lc2M5VU5VbHhUVG0zV2hZdmRnYytnOUdwcWVBOEYxcVM5alpzSFRHTzBr?=
 =?utf-8?B?cGdkazhCWXMreUNPR1VYR2NsbFhGYWpJNk54TGJNelFBTHdkdHhEeCtUQ2JS?=
 =?utf-8?B?YVQxQm05d2RJMjJRaFZ2eG5ucGNNd0F0dENUNHduMnI1VWlObmd5TE0yMTRp?=
 =?utf-8?B?Qmw0S253TGFMdGN4RzFyUXJzNHROS1htbDRITHpLdFZNRmVyQi81cmJqdnNl?=
 =?utf-8?B?NXE3aCtaWUZDK2t0azRvTU1xWmROYzJRQ3Q0d2pRQnFQYzlXM3NzcUpUdTFW?=
 =?utf-8?B?YzFuZzVRdm5malZkc282c3hEaDVvMzBubTVaZFo3MklrMnpoQ05MWXBUeTYy?=
 =?utf-8?B?dHo5N0xNb1o5U3dBK0lUZUZVMGR3SFJkM0tvNkdUM0ZhTHR3KytPYmhWdm9k?=
 =?utf-8?B?UmtRam1iTDJYZmNqZWlDQyt1UWh3L1ArdmtpTHdtYnBDeFNYODVuUkhtbWRt?=
 =?utf-8?B?Q3ByQ1BwM1I5VVZidDluamZUNnZDZlcrM1BMNG13THk3cVZCZllFSStoczVo?=
 =?utf-8?B?NjZTcVBEeFU1UHFtWUkzMXYvQWIvMnhjd3JZalo1Sm92Mjd0QTZOc1k2empS?=
 =?utf-8?B?K2JHV0RtMkdRa1ArTDR3RURUdWNQV09NYjhjL3c1V2kreElvSi8wUjk3WGk1?=
 =?utf-8?B?a3A5alVxUEpuYUpqdUdUOFVNYm9Tb29mb290YTcvWTllMEZILzFzTkNoWUM0?=
 =?utf-8?B?L3RBU3RLZ00ybmQxWHdNZ3dUSnhETEg3bkZreVBJY01BakZHY0xBRWRUdWJL?=
 =?utf-8?B?M2RlMmYvTzB6ZTFuV2RiU0ZNT2dleFRWWm5sY25hWGk2TVhXVFc5SnFvVVlp?=
 =?utf-8?B?TkZoZ1VyZWxrTlQwMHpoZFJPV2pUa3RwRTBuTWhWcENHQnBNU0k2YU9pTm5W?=
 =?utf-8?B?VGVKZVV2VVY0bExWRDNDUVBCRldKVSszdndkejVja2c2aHFJV1V4d2sxcS9G?=
 =?utf-8?B?eVlTU0pIRUQvUjk4NDNucUxlMnJpYWdUT0dhYXFZQi9RK2RTWTIzSmxhVmEr?=
 =?utf-8?B?QnlFN3pzUHkybWcxSGk1a3pDZ3hwa2wxV1NNSC9IQi9LbkR0WEdFTGUzMFgz?=
 =?utf-8?B?KzZ1NW9jZnNSck1UcnYwQmhDUmZRK0tNQ1BaOW82VDdQMlBVVDg5c292MW9j?=
 =?utf-8?B?bGc3WVlyTm5HRFJqdHlERkJvQnVvUXhMamd1cm9lN0prOGU5Vys3b20yRkRj?=
 =?utf-8?B?U0xJQ3FWNTIzZWNrRW1YcWlzaDBydFpENElqcUVxamJZSTg1Y1djN1U3czVy?=
 =?utf-8?B?cTFJZDRDQTVJZXFKZEhnOFZFa0t3dDJYS3M5eTFzWm50YllpNytMZEsyMU1i?=
 =?utf-8?B?N3dOUWxTVG50c1Q3YVNOQlc2V2wya1YyZlUyVG9EclE1QkI3SFpKZ1k0R3FG?=
 =?utf-8?B?UDI5bFQxQXdVQlUwRmRRT0RhZ3JMNWV3WUMyY3pSZ3BpcDdTYndIUkpNMExC?=
 =?utf-8?B?QmxXUW5LU3VWaUlrcnUzYmoybFprSWVhVTlrOXcvbXZ6Nlk4TEdoRGI2bS9q?=
 =?utf-8?B?K0Y4THR3VEJzaDhUVlJRNHFOSVBGa3JmU3VtQi8ybG51YjZmaGlJY0d5NEk2?=
 =?utf-8?B?VlB6Qk9OMTBEOXpudWRDSU9VRFd6YVFGN3pJaG9HTWF0NUFKWHE5WTNTaXFT?=
 =?utf-8?B?MjMxbGtGdDVXaVRhK2dnY1BlcnhKMU45bkZTbStma1Y5d04vdExWWFdGODVl?=
 =?utf-8?B?QVNvMkpDNnc5b1piVStHV09HbjI3eXBDR0x5YTlaelp6dDlKS1ZjTWxWcVVK?=
 =?utf-8?B?QVEwcGVNL0xoWWcwUXZMcGh5ZVNrSWFGQXd5TnVDemNVS1hZcHp4YUtRNm94?=
 =?utf-8?B?a2V6YnRkOVNLMFVwb2NVb1NnSmtKVFVjbk5RdzRyMXl4cEwxLzRFQkhPRWRF?=
 =?utf-8?B?TUtxd3pLbW5ZNWwwYVNyUGs3RFdHTkpNbVVTUmNKN2tvWEFjVHV3QllRNmlP?=
 =?utf-8?B?VmRqTUszN2NiWGgzOFpOV2ZUTHJKemN2ZVJ0UXllL1VhTnpwQ1hGN1JMTCtV?=
 =?utf-8?B?SENDS2lyTTlSc0cwNkFmRzlMTkg4S1ZzbFlRUStZaEhNN2ZmS05aUXo0SFJV?=
 =?utf-8?B?L0lVNGM0WnB3Tld3QU1WVUVqN00wVmpYYjJQY0llUDNJd1VjNmVkeXU0VldK?=
 =?utf-8?Q?U/wM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB3860.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e057a4c-02e3-4eb7-4607-08dd4a796f4a
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2025 08:52:37.4622 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Red3+BsQvFKyN/WLlJGQSnjWd9pK7fo3JwXC3nj89ntHT2vmlHdTBBDa6rRRtiTQ50t8wMoFdvQtU3WfdtQdgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR18MB4290
X-Proofpoint-GUID: c0I-_rIn483WavdLAUEVruFVqPmRoquK
X-Proofpoint-ORIG-GUID: c0I-_rIn483WavdLAUEVruFVqPmRoquK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-11_04,2025-02-10_01,2024-11-22_01
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

PiBkaWZmIC0tZ2l0IGEvbGliL2VhbC9jb21tb24vZWFsX2NvbW1vbl90cmFjZV9jdGYuYw0KPiBi
L2xpYi9lYWwvY29tbW9uL2VhbF9jb21tb25fdHJhY2VfY3RmLmMNCj4gaW5kZXggNmJjOGJiOTAz
Ni4uZDliMzA3ZTA3NiAxMDA2NDQNCj4gLS0tIGEvbGliL2VhbC9jb21tb24vZWFsX2NvbW1vbl90
cmFjZV9jdGYuYw0KPiArKysgYi9saWIvZWFsL2NvbW1vbi9lYWxfY29tbW9uX3RyYWNlX2N0Zi5j
DQo+IEBAIC0zNzgsNiArMzc4LDkgQEAgY2hhciAqdHJhY2VfbWV0YWRhdGFfZml4dXBfZmllbGQo
Y29uc3QgY2hhciAqZmllbGQpDQo+ICAJCSItPiIsDQo+ICAJCSIqIiwNCj4gIAkJIiAiLA0KPiAr
CQkiJiIsDQo+ICsJCSIoIiwNCj4gKwkJIikiLA0KQWRkaW5nIGJyYWNrZXRzIG1ha2VzIHRva2Vu
IG5hbWVzIGEgYml0IGNvbXBsZXguIFNhbWUgbmFtZSBpcyB1c2VkIGluIG1ldGFkYXRhDQpmaWxl
IHRvIGR1bXAgdGhlIHRyYWNlcyB0byB0aGUgdXNlci4gV2l0aCB0aGlzIGNvbXBsZXggbmFtZSwg
dXNlciBtaWdodCBub3QNCnVuZGVyc3RhbmQgdGhlIHB1cnBvc2Ugb2YgdGhhdCBpbmZvcm1hdGlv
bi4NCg0KRm9yIGV4YW1wbGUsIF9jb25mX3NyY19wb3J0X3BjaWVfc2l6ZW9mX3VpbnQ2NF90XyBp
cyBjcmVhdGVkIGluIG1ldGFmaWxlIGFuZCBzYW1lIHdpbGwgYmUgZHVtcGVkLiBCdXQgd2l0aCB0
aGlzDQpVc2VyIG1pZ2h0IG5vdCBnZXQgdGhhdCB3aGljaCBpbmZvcm1hdGlvbiBpcyBwcm92aWRl
ZC4gDQoNClRoaXMgaXMgdGhlIHJlYXNvbjsgd2UgZm9sbG93ZWQgdGhlIGV4aXN0aW5nIG5hbWlu
ZyBjb252ZW50aW9uIHdoaWNoIGlzIHVzZXIgZnJpZW5kbHkuIA0KDQo+ICAJfTsNCj4gIAljb25z
dCBjaGFyICpjdGZfcmVzZXJ2ZWRfd29yZHNbXSA9IHsNCj4gIAkJImFsaWduIiwNCj4gLS0NCj4g
Mi40OC4xDQoNCg==
