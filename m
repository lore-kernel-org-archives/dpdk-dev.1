Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF52DD2ED0F
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 Jan 2026 11:19:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0D78F40268;
	Tue, 20 Jan 2026 12:19:34 +0100 (CET)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010044.outbound.protection.outlook.com [52.101.56.44])
 by mails.dpdk.org (Postfix) with ESMTP id A07C84013F
 for <dev@dpdk.org>; Tue, 20 Jan 2026 12:19:32 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rpbCMWafIfqZf1UJE5xRoydzodzV2qF7Lc0xGdZi1G8HD6BZQvmXBQnjvffZCLO1Jhr2ciNnTk0rnPWRsMY06PrwrH7vWxXsSjc2wcuMMhicmYTGavJFu1YjH/Dxv46+tUlycf/D6wl9ZYlB9rorHXbaAHW/2luXBFZNd/TxtZNYRubgrU0xaKtNfZdTQ9K/JBgHa5aJT+8G8zcxKNfHLYatITnIWGCn4PnzH8TWayOeN8rT8zC6rmJ0ZUBdmSnUWreOLShaN5M+3O5SHKWFw0/rdpUcxnK5R0xKeJiSOpAlLZ8ts0fz7L/Ib8AdlVjqa/HqP7dnLE1HC82+1bT/Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3JkIy5bKpcctxRAqSJug3tQoFcMLmr2SUWoCj9CZcJc=;
 b=iLFPI4xEbeZGXj1byvXmtz8OoK1VpzVL92xWWem9Eq5RM4dNe9KBeZPCWYY6MTg5Q2NWg6/0TdCRzcxLPxwxO5w1PfOt23bg+SZIgUQ+CSvjp+AaVQ2ykzZXQ77HjnnA9IIewIZWh5Vg26cpFEXSCePYcFG9cacCQE/mzmtY2QmqHI+sZj3L+DPF+4U9y8TfRPrvnw0PYCRT2ORjd3j29n6a+4PCbHt74va3xnwIC3APkMXKKMfy2WdYV0gGJkDGxGNPO77cUwA2LEb0UQ0qcNgTkqYCkPopXhH67ntH7LeEsSSc0M9fs1JgD9F7OU2gAkCSI4g4rD/5bEhmwuXHOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3JkIy5bKpcctxRAqSJug3tQoFcMLmr2SUWoCj9CZcJc=;
 b=s/zLZHy0jc9jlPTgpJfh33TnyLUNPOOsxdTEN20+dJF4oRauXGn662nXRCZt59g8zLJcy4E2wy8lOjdk/NGpzMKOozGPFGYCiWdV2YHkRpopg2mpBhtn5u//o/IuGK2O/5XMTg+KUmSMAMqNr9QdmTj+/7HxadweKu00Mxuq1QU=
Received: from PH7PR12MB8596.namprd12.prod.outlook.com (2603:10b6:510:1b7::6)
 by PH7PR12MB7871.namprd12.prod.outlook.com (2603:10b6:510:27d::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Tue, 20 Jan
 2026 11:19:28 +0000
Received: from PH7PR12MB8596.namprd12.prod.outlook.com
 ([fe80::5909:724e:563f:49d1]) by PH7PR12MB8596.namprd12.prod.outlook.com
 ([fe80::5909:724e:563f:49d1%5]) with mapi id 15.20.9520.011; Tue, 20 Jan 2026
 11:19:28 +0000
From: "Varghese, Vipin" <Vipin.Varghese@amd.com>
To: "Varghese, Vipin" <Vipin.Varghese@amd.com>, Stephen Hemminger
 <stephen@networkplumber.org>, =?utf-8?B?TW9ydGVuIEJyw7hydXA=?=
 <mb@smartsharesystems.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, Bruce Richardson
 <bruce.richardson@intel.com>, Konstantin Ananyev
 <konstantin.v.ananyev@yandex.ru>
Subject: RE: [PATCH v6] eal/x86: optimize memcpy of small sizes
Thread-Topic: [PATCH v6] eal/x86: optimize memcpy of small sizes
Thread-Index: AQHcg7uDLBHaOyG5bUy6tdTsisR14rVQvruAgAouhgCAAAgkMA==
Date: Tue, 20 Jan 2026 11:19:28 +0000
Message-ID: <PH7PR12MB8596F1FE29BA757F8884E7A98289A@PH7PR12MB8596.namprd12.prod.outlook.com>
References: <20251120114554.950287-1-mb@smartsharesystems.com>
 <20260112120337.277331-1-mb@smartsharesystems.com>
 <20260113151943.31c58217@phoenix.local>
 <PH7PR12MB8596A21E5892BABF88665C5B8289A@PH7PR12MB8596.namprd12.prod.outlook.com>
In-Reply-To: <PH7PR12MB8596A21E5892BABF88665C5B8289A@PH7PR12MB8596.namprd12.prod.outlook.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-Mentions: mb@smartsharesystems.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2026-01-20T10:49:05.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8596:EE_|PH7PR12MB7871:EE_
x-ms-office365-filtering-correlation-id: 0cf1aaf3-08cf-43c6-8f78-08de5815c6d8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?bDNNM2tIOC9xalZKSitzTWJMZWlKK21EcmdyNUhKcXA0MVJoSXd6SzRzYmJw?=
 =?utf-8?B?NEhIaVFVM2dZOTJtdWJvRTRjN3BjUHpKWEMvRmlPSWR5SUg2NmRTQy9MVHZy?=
 =?utf-8?B?NHlaTDFEcVR6TWl1OWZUbjhEZnVCT0YwYXcwRWdtbWtsSlM5VE9QNDhjZGcr?=
 =?utf-8?B?MjU5cWs5b2Vvb1gvcFRUVWsyOVdYZnR0NEErY3RWNlk4Q3ZoYTVNL09QRVZN?=
 =?utf-8?B?K2JyZGZmd3puNGhoMHhHTkdoaU00TzRnVGRVeGdmcFpxMlhXTlhuampVbFh3?=
 =?utf-8?B?Uzdpd2w0R3AyRVhtM29yYWtzYWxhWnhxcy9iaWFPd1MzUEV0Yi96YjFuZElU?=
 =?utf-8?B?VnAyYng1YVBTZm95UEJ1eGZLMjU4RDVPaXduVEtZWDBwVzJ5UUJQUi9ONzJP?=
 =?utf-8?B?d2xtTnFtUCtDNE5jSGxYNy9lMDdaQmtMdDVWSGl5TUZaTm8rL0lEWEMvSU85?=
 =?utf-8?B?TUFhL3V1R1dnU3JLeVBwc0xhbGhJdjNidDY2RDhsYlQ0WkdFUUkrTEdxNW1V?=
 =?utf-8?B?WThxekNsOWxrTmRlWlROb0lGSzJjZWM1UTdUYjlmdEtkSWs2TGRpT1pWNVQz?=
 =?utf-8?B?MlNpeUFBYzJNRkU0bTBNekRsdmdDTXNmaHRkNzIzRHptTzlsa3ZDR3l0Qmxt?=
 =?utf-8?B?NkhXbHprTWx2V1BaTlJDU29YaDlxa1ZiZ2FjdTFNRlM4a3RNTjJsV2lmaEVW?=
 =?utf-8?B?cHd4YkhrNWdRYm5BZEEwTFp6U2YxY2JLdGtNQmtlT2UzSlhjS2c4Wld1SXg2?=
 =?utf-8?B?dG1hWUxYdzN5L2k4U0Y2U1ZXN0Z1enc2V2p6bUx2emVsdWE2bmg2MGMzUm5y?=
 =?utf-8?B?ZzBFc1FMd2xZeFlvcnBYZWF0cUR0Y1lUVDAwVlpBMmpybVpYSVRQZ3A3UytP?=
 =?utf-8?B?MlB2Wm8zTkkyZ0FEN1ErclltYVR5RXV5RnoycndpdWJ2ajdCVUNvd1E4YmtC?=
 =?utf-8?B?djBrTUtnaGxrYmNOODNrWHlINGNNTUdvMVF5R2RjUmJiNUJabTN0Z0J5b0RC?=
 =?utf-8?B?U2tlUHN5aTRUVUhtdVJ4NWtsWVdwZmplZ203dUJGeVF0bTFwam84RTZEazFM?=
 =?utf-8?B?T1lKdE1UVzVFMXRXdWF6Vmx1TFNhZE5jZTdaUmtvZkcvVXRlMFhhaEo2Zmp3?=
 =?utf-8?B?YUV1ZnFhaS9pSnlpcDgvWjFTcnkyM3EwZ0FxUnJiSEo4ZVJUMDVITHNKMmRM?=
 =?utf-8?B?dEF6Z0IyRjZhVUJsa3cwb2ozY25vY1pHRGRmbmYzOHlOWGpkY2NtdU5JSkp4?=
 =?utf-8?B?U3RieEFOUmNuRUFpbnRnRmErdGp2OEsrT25zZHdpRjZ0d0o2KzhYbHpsSmNj?=
 =?utf-8?B?TThXKytQRGNlTFV5YktqSm4zd0hWZ3pqWUN4VnFOUUtwQ2UxaTBEeUJzSWhz?=
 =?utf-8?B?VG9NN3FGQ1JiSVFPcFVMOTBRNlBQYmtIamdhaUFRdzVEN0pnZHUyaUkwU05v?=
 =?utf-8?B?WWQ1cVVuZ08zcGs5a21yckppMzFYck1kbmRRUnJ3WEduRmppU2J6Z2pSMlBx?=
 =?utf-8?B?dHJDTDRXRHJ2ajBlaE5WeXkvKzNVamtqZGs0ZkUvMko2L241SjBCb3cyVFBM?=
 =?utf-8?B?SUcranprcW1Hb2hXMUcrQnd5RlR3Q3ArTWFjSFErSEF3b2oyZ08xbHYwYm1F?=
 =?utf-8?B?VDI4c3NnM2Z4ZHQ2RWJCQWpOYVRMMUtWUUdWaStMZzd5bzRXWGt1TlhVY2NR?=
 =?utf-8?B?b0NJTHdteGk3NTFOOU95NUF3NWVYYVVpUmR2MnpsNm13cHZMTTRnTGp2elhk?=
 =?utf-8?B?aXlrd0prR2RkYSs2SFcxc2pPTHZ6QzlEaXgwd3U1a0ZCbWIrNSt3d0QvcTV2?=
 =?utf-8?B?VCtEbHBYV3J6MzZLeS9KNzByNUcvVUxaVDM4eEgxdXQyV1VCendmbUNsaXZE?=
 =?utf-8?B?MEh0OTllaDdqemhzazFhOFFoZEFkVHVhZlZqU3VYZFlkSjAvQ1RhYlgxY2Nw?=
 =?utf-8?B?YWsyVEgvMExWUjFQWmtac0dXOTdwZkNaMTErRGlOZGVLUUtpU3RXS3RINU1l?=
 =?utf-8?B?bGZCZzlWODUyblV6NThUY2lWYmhTR0RUUDlpak5WSmk0VU9ZVG5TV08vRTR2?=
 =?utf-8?B?YTRuN25JUEFPdjRLYUNQQkpXcy9lMUZJRHl2bDEyR3RzRmFoeG8wUS8zYmkz?=
 =?utf-8?B?Q280dGxKamxIV1JDS2xJSnFTd2NNQ1dXaGJyT3RzMVNDa25McGVYMUQ0VmZE?=
 =?utf-8?Q?qTJLty1P70vRNBPnEmYrNgo=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8596.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WUF1ZzJsWTllMXZHMjd6OE1zakJnVmZVY0l1S1RsY2FnV0w1Ti9qLzJDZDRP?=
 =?utf-8?B?ZnlhVGxBSU1iZGEvSlhPeWY4ZlF3Yk5QVWw0YlhKMnNnSDViK3ZWQjVpQUhn?=
 =?utf-8?B?K05BdktEa1NmRlo4VWtjRnNtQVNOZHVIWmxkQzUzWU1EbXVpbFZrc0N2Wldx?=
 =?utf-8?B?N3lLVmVwMVJFRVlkQXovM2ZUelRZTTI2VUNOektFNkUzNXpOK2xqUENJVFd5?=
 =?utf-8?B?SU5WekozSDlDcjFtd0t3Q0VNMXFLM1pvSW9oN29LS1dNZEx0TnpZYTAvR2k5?=
 =?utf-8?B?MkM4MzRNMGM1QWJVaEt5dEExRlU5bXhjanMwOGpHMDNQbXl1eFFzcWoydytP?=
 =?utf-8?B?aVhCMXhzUVo0UENTNzBaUmE4RWFBZ0llSU5PenluZWlpcElPd2NLMCswYWF0?=
 =?utf-8?B?QThnVzlNOWFUdFFUK1oxSUQyUEs4bGdXbktZRWdhSTZDM2F3ekZQTS9KZTRV?=
 =?utf-8?B?MXEvRnBDVG82and5bUtYQjNOWm5Ncnh5Ti81WlNVaGFoWkVDcmt3bGptM0lx?=
 =?utf-8?B?RUMvcmMrM0tER3JJb2FHT09vV09yRnMwenFRN0IyaXltUkNqRGJkVXdLMHRi?=
 =?utf-8?B?SEVsYSt3QlFnMlFIM1BQZGJ1eWxpamVkSTEzSHdJSHdlQ1dYWVVPRFFkbmQ3?=
 =?utf-8?B?N0dSYitMZm0vTmFxa2pLTEtybWdIL01KL1NSWE1BaVNRc0VSNUxVeFFzVXpS?=
 =?utf-8?B?M1N1QXNMTWZ0aGFDWU1ZZDhNOVBDRkRnQ1k1cGZVcVljZVRiajRiYUk0MnJS?=
 =?utf-8?B?WWtOVDRpZGUwbkRBWlBLYlFVRTJFbHNEcVM5d1dGRWs5QUNlREo5bjFDQ3o3?=
 =?utf-8?B?K2FZa0p5VEJzclNrMnVwT2dlL0tqS2VuUkVsSC9aTlNaazZiSDV4VkFyN2dY?=
 =?utf-8?B?ZDE5UWcxc3BKdEdHZTFlUlA5WTNtZk5INjk2c3BLaldkVWVkc09vNC94SHBv?=
 =?utf-8?B?NkgrYjR2eTUrbm45aW5vVStyVE9ZNkZ3UkdOSStjYlpENFZjS0UvVUdDbXRl?=
 =?utf-8?B?MWtHKzI0b0VrQmk3YkFJZVArM2VEZkw2dEsyZ0MxSGJDbTNIZHIyWjJtL05a?=
 =?utf-8?B?TDNkaXBxc2RHREFUUzFDM25SUlZibHVaZGhGSndCUDl6T1hUUUFSakVqV3lL?=
 =?utf-8?B?SUZnd216Q3dsdHM4cU9iRnduWjBhanQ0SFRPMndUTUhzQ0JZRUtFN01iT1JY?=
 =?utf-8?B?VWRESmhKYTFGYjFwWFo0UmMxbWhHMm9xdFhKQUNIc3VmSTQxdm9MT21NaEsx?=
 =?utf-8?B?emNEYWNSamNxWVJKd294UHVhTTJjc2lOWjM4TzBDQzhYQ2dLbTJCU09uOXFh?=
 =?utf-8?B?ejNjZHRucnU4clYvTm9JczFLODdQR2xhZjdSZU5ublNySnFHSHVaanJWSjds?=
 =?utf-8?B?ck9SeFFRNUpvSWJRVmVTMjVvWnBDai91USs3STZEbDdUK1FER1ZVQlJETzMz?=
 =?utf-8?B?NnFQRVFsamd2TW5wdjNLWmU0TkxKYk5TcmNtRHVjcklGbVp3NXNQU2daeFhM?=
 =?utf-8?B?dHFTZXlMZTFvNGc5bitlb1dhNzExZVF4S2R0UStZS3NkK1N1RDVxQndJdCt2?=
 =?utf-8?B?Y3hkOTF4djdHNS95Vy94MFFRVFlMRG83WXFzVEZuQ3JCMUhGUzErTHZoRi9o?=
 =?utf-8?B?Y1liQUtuR0Rsd1dFM0VpdE10TnUydW1MM240cWFneFlpNnRsQWR1amZLUE45?=
 =?utf-8?B?amkvQ1ZPMzI4aFBCY2c5Tks2R0tzdTlGSnVWZ05JNjR2QXFCVGdSZDU2NUFE?=
 =?utf-8?B?dkE1bE9qUW1vazZnRUIzV0R5cnV0T2V0YmU2YldQR1pDbVEvK0VFSEpXd0tm?=
 =?utf-8?B?QWxIeW4vUHNNVmRBcy9SUzkxM2R0eXc2WG1OenhXQThQNUtkc01JYzVMK0Fl?=
 =?utf-8?B?c09rbUpmYzlMMCtKWTVRVlF3ZkJPNUdlNURWSDJ2dmoxbzBaNWhGNFl4YW1w?=
 =?utf-8?B?ejZHVUN0V0c5S1NLZmg5VDlpUDBFanU3MG5tVHZydXdvdC8yTmtjWE9wVXVR?=
 =?utf-8?B?eGI0RFY5ZEdSZUY3amlQWXhZOWtNSThubkNxUDliWXVaZ0gyWmJKelZzYTVU?=
 =?utf-8?B?aUJEbFN1K29jUjQ3MUZ2S20vS0pkM0M2MkJOL1FtSVBhWXpFZmZxMmtxbW8r?=
 =?utf-8?B?YmcreXlPNUp0NHB5ZWhpWGY2R3JvVnBFRlBvVVl3b05YeHVNUWJ1NEFxQ3l2?=
 =?utf-8?B?cVhXbUlDWW9FVnUrVkI3aVBZeEttWTYyOXhYV3lWVmRDVDEwL3F6Ylk5NE9G?=
 =?utf-8?B?bmgrS1B6eTJ5U2NGQVlzNjlYVkV6ZDVCaDNIZXhVc0hjYkVYYW5vWDBwVFMy?=
 =?utf-8?Q?bcN4fR8oJJ3Bb3ZOQo?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8596.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cf1aaf3-08cf-43c6-8f78-08de5815c6d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2026 11:19:28.6328 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qCrN0amo0V7MzSyXzZ0Wv4YAapFf+b+7UciH6wjFN6JP7LX2UyjD7GYMPdMGSNboOhuA8PHuOFnBSjM2Ik3GQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7871
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

W1B1YmxpY10NCg0KSGkgQE1vcnRlbiBCcsO4cnVwLCBxdWljayBxdWVyeSBpbiBmdW5jdGlvbiBg
cnRlX21vdjE3X3RvXzMyYA0KDQpgYGANCisgICAgICAgaWYgKF9fcnRlX2NvbnN0YW50KG4pKSB7
DQorICAgICAgICAgICAgICAgaWYgKG4gPT0gMTYpIHsNCisgICAgICAgICAgICAgICAgICAgICAg
IHJ0ZV9tb3YxNigodWludDhfdCAqKWRzdCwgKGNvbnN0IHVpbnQ4X3QgKilzcmMpOw0KKyAgICAg
ICAgICAgICAgICAgICAgICAgcnRlX21vdjEoKHVpbnQ4X3QgKilkc3QgKyAxNiwgKGNvbnN0IHVp
bnQ4X3QgKilzcmMgKyAxNik7DQorICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gZHN0Ow0K
KyAgICAgICAgICAgICAgIH0NCisgICAgICAgICAgICAgICBpZiAobiA9PSAxNykgew0KKyAgICAg
ICAgICAgICAgICAgICAgICAgcnRlX21vdjE2KCh1aW50OF90ICopZHN0LCAoY29uc3QgdWludDhf
dCAqKXNyYyk7DQorICAgICAgICAgICAgICAgICAgICAgICBydGVfbW92MSgodWludDhfdCAqKWRz
dCArIDE2LCAoY29uc3QgdWludDhfdCAqKXNyYyArIDE2KTsNCisgICAgICAgICAgICAgICAgICAg
ICAgIHJldHVybiBkc3Q7DQorICAgICAgICAgICAgICAgfQ0KYGBgDQoNCkZvciBgc2l6ZSAxNmAg
ZG8gd2UgbmVlZCB0byBjYWxsIGAgcnRlX21vdjEoKHVpbnQ4X3QgKilkc3QgKyAxNiwgKGNvbnN0
IHVpbnQ4X3QgKilzcmMgKyAxNik7YD8gQ2FuIHlvdSBwbGVhc2UgaGVscCBtZSB1bmRlcnN0YW5k
IHRoZSBjb3JuZXIgY2FzZSBmb3IgdGhlIHNhbWUuDQo=
