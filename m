Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01E3BC87FDB
	for <dpdk-dev@archiver.kernel.org>; Mon, 11 Aug 2025 11:07:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 48B1240B8F;
	Mon, 11 Aug 2025 13:07:21 +0200 (CEST)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2087.outbound.protection.outlook.com [40.107.244.87])
 by mails.dpdk.org (Postfix) with ESMTP id 59E344013F
 for <dev@dpdk.org>; Mon, 11 Aug 2025 13:07:18 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BfJPkQY8Ux+ad3drAzJr4pj6/uU76K53WRU1z6ogMzLJHmYf0YfVf2+286En3jixq40M3DVPkkBPv5hqOxxx8gXDKuVF59Q/6SVphsCBGPgpH7Rxnh5m607hroLb5CuRt2NTMnUjXJpYXgT3b3M1RuXDuK5Us8rC4nFXfhoQUwT0pwOfJITLEZGVSM+/K7hyU7yrbs+bO7EgAO9eW3cB5jrcFvJQBj/3MOFMm0RtYnW0GEeu+XHDsIET+yfeBheOyQSeWxZYASgh1hD+hAd4W45BbNXrwe50FFBy2AC71vAKoaUFo4naSpRiu8ZSqR46W0zum/wT9Tf4hixaUPql1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HWYBoraxBg3Tpg5DwUFr3e8OnZXyo1kSPli8HOfd+rU=;
 b=mG+H36o/mptsbyohHz0kRkWDX9BKxEvWsRxoj/Lk9lCKrYaByVqammllm3OWqdI4x/9FTuGkXD35WBiF316NCBkamGAv26q3sFdmKSyGad2arGXisNK3MmeQ8Z0C6SFTWQJ4mR5dWSQilBN+/uVEzJYnRiP/WxiIaP5PE6bv80eHmpQklioJFPfTPS5Ih8ilh63uV1K0dvKMAF7ySZ/ffrk5RmKtrq29pBvSwLp6SF8k7Cae2XQNjUxWqkiVCiglrW8I0cQUv75e5ouM2VMn7GLBK3fr2yMju3iyCb7SCfropMO9x9cExRXXdM03+fqGhCjoXUnGxSKVT41TEUtj1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HWYBoraxBg3Tpg5DwUFr3e8OnZXyo1kSPli8HOfd+rU=;
 b=M/iZDxAdqRDME6UtpPUzVJvmp4wVre/rjlhWlncJW1Hcx/phJ86NYPXkBIbMnVBIxH9u6TeCGJbzNvY9hqFyhX9pms6BptRsxSjMgoevufMER4ecNaRZHTlQuIEBP6GA6FINn0kulUaIgvtOLLWpXPbYECeFCQssYRjrLtEqeJs=
Received: from PH7PR12MB8596.namprd12.prod.outlook.com (2603:10b6:510:1b7::6)
 by MN2PR12MB4471.namprd12.prod.outlook.com (2603:10b6:208:26f::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.22; Mon, 11 Aug
 2025 11:07:14 +0000
Received: from PH7PR12MB8596.namprd12.prod.outlook.com
 ([fe80::a011:943d:7291:8069]) by PH7PR12MB8596.namprd12.prod.outlook.com
 ([fe80::a011:943d:7291:8069%2]) with mapi id 15.20.9009.013; Mon, 11 Aug 2025
 11:07:14 +0000
From: "Varghese, Vipin" <Vipin.Varghese@amd.com>
To: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
CC: "stephen@networkplumber.org" <stephen@networkplumber.org>,
 "thomas@monjalon.net" <thomas@monjalon.net>, "Yigit, Ferruh"
 <Ferruh.Yigit@amd.com>, "andrew.rybchenko@oktetlabs.ru"
 <andrew.rybchenko@oktetlabs.ru>, "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [PATCH v7] app/testpmd: monitor state of primary process when
 using secondary
Thread-Topic: [PATCH v7] app/testpmd: monitor state of primary process when
 using secondary
Thread-Index: AQHcBTOmTMs4cZesWkSBbj/ohPqRp7RYGXxwgAArOwCAAFY/MIAAD4mAgASfR7CAAAeCAIAABCeA
Date: Mon, 11 Aug 2025 11:07:14 +0000
Message-ID: <PH7PR12MB8596208E8AB5A8DF48455D6F8228A@PH7PR12MB8596.namprd12.prod.outlook.com>
References: <PH7PR12MB85968E4B05D92C12C963F1E2822FA@PH7PR12MB8596.namprd12.prod.outlook.com>
 <20250808114909.1606758-1-14pwcse1224@uetpeshawar.edu.pk>
 <PH7PR12MB8596259B1F736357A7E9A3EB8228A@PH7PR12MB8596.namprd12.prod.outlook.com>
 <CA++2-x40aBF8uumQ5zp18VwR4YZ5s9eUrYWi49CPyVz+97rrZA@mail.gmail.com>
In-Reply-To: <CA++2-x40aBF8uumQ5zp18VwR4YZ5s9eUrYWi49CPyVz+97rrZA@mail.gmail.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-08-11T11:06:11.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8596:EE_|MN2PR12MB4471:EE_
x-ms-office365-filtering-correlation-id: 9432d90a-c348-42e4-51f6-08ddd8c73a66
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|8096899003|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?OWpVbVh0aHlCSTl0VnM4ajFWd3Iva3VKLzNxZ1dtL2NUbnIrL1pUQnYvZWtp?=
 =?utf-8?B?Q285THBIaldtUG11dWV2V2cvQUh5RmtBK0l0czlQOFI0dmhGZTY2Y3g1SVc4?=
 =?utf-8?B?MzcxbHdRRXlaZlB6YTJpSlcvaWNmS1hvV0ZQSGxYOW5MYWZaRzlITEJHbTE2?=
 =?utf-8?B?VVUyWGlDaUl2Vm9QQmRmZmpDMGxFSlpNbUp6U1haSmgrcHdwNVRxcllXRFQ5?=
 =?utf-8?B?dzdUTlZkL2hoV29UTFphTkJRZ0hJaGt6bXZ2bHpUODFPQVl2QWttcXdhMU1i?=
 =?utf-8?B?NVIrN3BkQ3M0SWJObnprTmVFOWhiWTRJWml0cnpkV3Y0THBmSlJvU0d0Yjh4?=
 =?utf-8?B?T3RBOHFQUHhwS1lzeVlURUFyZVZaRmJTUHpOS2tqeEZUVFk3OUxjSWVXZkVQ?=
 =?utf-8?B?MWg5MVVncEdac1pmZHJKWFNTejZuT1Ixek9sZDJNNEhGVURJcE4rTUF1K3No?=
 =?utf-8?B?cjR0RHlJWFg5RjBqQ1hJRFY2aVdBYUJXdzAvZWkycUtJYzRGT2RZVFVzTzk3?=
 =?utf-8?B?VS9NcmtNdVp2SUF2Z3hKVzEwR2Y0bUQ5NFljNmp5REU4OTM2T1h3dHAycVhn?=
 =?utf-8?B?MUNYVFBXZkNqVGV4b0xkUkdOK0ZuR0N1UER4M0QwSlhoTE5VZzRybmd1WlRM?=
 =?utf-8?B?a3oxc0w4U0xmOWlSWElvU1JIcSs2Y3VLS3VCUUFXSUdzT3Y4cW9mZXQzc0lT?=
 =?utf-8?B?UDNvVG5NNjEzSFRPL0lSS1FQZWxiUFJRdVNLemR2VVlzdVAvd29qWFFGY1dX?=
 =?utf-8?B?aDYxNW0vMVcyQnZPb3M1R25wWmNzNWxPS0lSNk4wTXlmZlo5TjVXR0JkbkdQ?=
 =?utf-8?B?bGxCejBuNFRjQklWZnhVL3dHb0hyaE11YUsyK1pTb3ZEd3dpenlIRkwxQWZU?=
 =?utf-8?B?UU1RaFpvNnZlSjF5N1h0dWJVNkFQM0QzZlVjM0lScG0rVFpheXp4a2U1MmZ1?=
 =?utf-8?B?WVBDUC9oL3AvRlFmMlRHRHlhVjVlOEVRVWZQcDhONWFpTHJIWkJoOTFKMTVC?=
 =?utf-8?B?TllCMHRubEtpSjVoa0NvUDVRYlBWTlA4enRObURTbzlYUWJaWXZzVkJMemE4?=
 =?utf-8?B?c2hvb2xmUmRuTUFSS0MyVjY2VDAwK3ZocEVFN0dhUnc2RHZmRkdKR2ttQ2dD?=
 =?utf-8?B?SVlDVzBvTWx4dGJaMHlUdFFmY0VGcitpdmpJMFlEMXZnOGFib2p0a3haV2Nx?=
 =?utf-8?B?dTJWSFBFZktDVHQxSE1ncmJwTWRpQU5MZkdydkk5Nk5xZkdPcnZpYnNNaGRI?=
 =?utf-8?B?bHY0TzlpY0xZVS9KYjVzdzFPbmEyaFZ6bzV4dWJ6bGdnNFpURXhDZmlnQ3BL?=
 =?utf-8?B?SVhBR2hQKzlSK2dUOTdxc1kwWE5ydVhUT0I2bUtJNzQrc3ZkQ1NiUzlMd3ZX?=
 =?utf-8?B?Ly9JM3ZaTmo0S0Y4SHRTRER6UUc3eVFDMytyakIrQkxZdmFmcTNCUTlZR2cv?=
 =?utf-8?B?NEoyOEhYV2hiUEh2OXNQQVdnK0tiK0YyamJMSUdraEJHNTljVWdvVldHV2tG?=
 =?utf-8?B?UEt6enhuTktjNWlOOGVkR0JoVW5MZXlEQmF6NmtzNnNkK2craTkyTUVGQkxX?=
 =?utf-8?B?S2ZjWnVVRVl3RXZpdW5hVjlxaWJQWTdINHZiOFZkSkdBRkFIWDIrOHJCckNC?=
 =?utf-8?B?NllOK2JRM2RLcktkVmpRUjJsRWFpTE15ZCszeDZYYXVzY3QvU01RQUlFZmJ3?=
 =?utf-8?B?K0pEWmloc3VXYVl4VGJKemE4UkZmeHh5S1ltRWlCUXkxeDd6bHcwMDBsOUs0?=
 =?utf-8?B?UmYzeml2bmxuTnNNMVgxWVVtRTNJU1dXNWVIMnRBWFBxYlZoVTdJRFpkcWl0?=
 =?utf-8?B?RURCWG5tWnA5anpyVzBlSUs2QzdhSVB3WVRmQVdpOUFhdHJ0bURJQmE3dWI5?=
 =?utf-8?B?QjNnUVF3Rm9waUVYM3dPK0ZWVlhaalZnNmRhTmhRL21QeFNLcWdMcU01cHBs?=
 =?utf-8?B?U3Y2RVlCd2Nnd2hNbjlkd0tGaDBjT3RheTJKaVBSNTBjZTlZSkltbUQ4VHpB?=
 =?utf-8?Q?d0vHMg0baJCbDW7FHBAitRYKoDGykI=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8596.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(8096899003)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Ti80SllsaWVFWDlBV2V1S3k1YUJxaXVaSUhpUFgyK3hqbTRjbzdiZVJFWUdo?=
 =?utf-8?B?cmdvZ3ZNUndoNVphYVUrV1BJREp3NGIrVkZwd2hUWXlOMmlaYzlMenRtaTRj?=
 =?utf-8?B?Q0pHM3RLbUJRaW5HbE5uZ2JkSVhWVmV2ekhXY09VaDFBUlRtRFNtRWlKOWF0?=
 =?utf-8?B?aWtVbGQyNmxSQ3Jvc3Y1YnlPd1EwcVl1UFNQOTdJMGwyZmlqb1pVUDE1VWIv?=
 =?utf-8?B?MjRxSndEclJtN1FCVCtrazVtVnNmVE9ZSWFlcExmTExBcHVNdFRFR04yR3ZI?=
 =?utf-8?B?ME9VUlRRc2VpdEtRTVhVQmtJVmhiNHRoSHVmbUwrMDhBUmF3NXoxUXQwZFBW?=
 =?utf-8?B?SWx6VU9MU1BiMGRORnRqZ1hjaGprVjhVYnhHMEhLTXJ3RFByQzI0eldFMmQ4?=
 =?utf-8?B?NG5yUC8rZ3dpMHdDb1dhdTFYRUtEYnVQbTA3dUxOUTNhMWVKbTJ6MlhncU1P?=
 =?utf-8?B?a1ZSUmhWaEN3b2ovM0lKS2F1RnI2ZlU1UnJFZ3ZQc1RkTGpYRkNFUkdoaDJJ?=
 =?utf-8?B?MUViUGRoNUcrMGdqZTVqOEQwOVYzZCtGM3RsclVWNEFkWDZoVVNHeUtRVXZk?=
 =?utf-8?B?ZXcrUmdRelRNSWRNaU4xQmZoZitoRnpQZkNiN2Jjd3JpVDZBR0tweHJBbGcz?=
 =?utf-8?B?VCtMM3NHVnM2Qi9QdGxhaVVSR1FrWmVKSmxJWERZR0phL0c2QTZneFZSdTBV?=
 =?utf-8?B?VE5relNrWFdONnNQUFB1UmNJcm5rblZENmZ5ZkpqaEIrem5tdVhxd2MyZTBJ?=
 =?utf-8?B?c2czbFNnazk3MGVoZjdzUEJ1aW1EdEMyVmJQclJHQ09IdlVsR2VaRWhLVFNJ?=
 =?utf-8?B?bEN6Zll1WVZXNGdmMllpdlY5VTVxalNDbFRkV2ZZeWpLK2ZmUDFZTEgrSzdH?=
 =?utf-8?B?MklYcVl1d0ozejVmbWRBcnJnRkhrN1cwRC9rSVhkL3Vxc1ltTmNMUGRXbzNn?=
 =?utf-8?B?aVBEcGhnMjVUWkFUczNlYXNTdy85d0lzelVLVDlNVmoreWdEclFuM094bTl0?=
 =?utf-8?B?RjUwR0d2YlVlOXcySkhHRU5sQ0JlVXREWXYzT1o3eVZnelpzNGRQOTFGc3Iz?=
 =?utf-8?B?dUsyNEJuM1pUTVRhVVZ3eGd4N3JBdk85a1FZQkRCdWU3cnRDNDhaTkxNcGll?=
 =?utf-8?B?Z1pQZHpXNy9IM1Z6enVwYmlpamRIYjJvenN1ak5yV3R3VHp1Wi90bmZ3Nzdn?=
 =?utf-8?B?UWVUZmlOdHlFdWp2amtKdlgzenArSlduMnN6VmFjYkVoRHIyOUNyblI1MDFr?=
 =?utf-8?B?OU8yRXQxNmxnd2lRL3Y1RWw4ZE9XRHI3TGd1TFAyNm9zNjhVNGRvTmNtUW1K?=
 =?utf-8?B?QmZ6WE5qdjFMY1VZaCtYVC9mOExGQmdjNkw5TWtXMGhGMGk3MVhWL29adXo3?=
 =?utf-8?B?TkFYeXgzM1ZGbHB2VUxlM1NqTGRxREt3S1JEVjNqZDNRcUl6ZmJ2djc1SVhC?=
 =?utf-8?B?MTdheHFPVFN3Y0NUQ3RnZmE3U2REV1FkcElhZ0RNekhWdHZnd2xrc0dRYzda?=
 =?utf-8?B?QkNIekROK2E5Y0JzMGpFalFUd2tGTnd4dmJpNEp6ZG9wWUpVdGxJR3JkSzRW?=
 =?utf-8?B?OTF2WkY4elNiMFVyelAyUXJWVWJNcUV3VFVVMmtVcUNIdlNYblZZOXVyWm95?=
 =?utf-8?B?QStsaUtqeVpVbzlGeFdqTUNHR01DMUN4c2duZ0NVN0w3UmFBZGRqSmFvRE1X?=
 =?utf-8?B?bHErQitTVGdNOVo0T09sY285SnJFVzJ3Mk1oZ2pBTVM3cXM0M3cwbHNidnI3?=
 =?utf-8?B?bUtuNkxEb25YVkpMcE9rQWRZbnN4bVl0T0tuRlEvYnlCTU1XNmtybjZaVTNG?=
 =?utf-8?B?blNGbS9JQkRkQ1o2MGU3WkdEajVGQkRIK0JDeXN5ZThVdzhFYi9CNlN2TVFU?=
 =?utf-8?B?MW14Wm5XcDFLRytaZ0lxczVaNi9KelVOTDhNbkdNV0tEZnJKRTUyNy9XSmJr?=
 =?utf-8?B?Y0dDa05Fb3FORW5tOWphRUNnanBtRGprWHA5MXlSUnhZMWFqL2VoK2wyeG9D?=
 =?utf-8?B?YnBSM3lsZ29iWEE3dFFPZHRNaEUwWi91R1hMbDAxTGNtcXNzYS81dmJaTi9K?=
 =?utf-8?B?MENnVFlMQ2dGSFhkU0V1YjZRWTZGa2tuMUJNQVM2NmNQOVF4TWMwcHZwRG1R?=
 =?utf-8?Q?jeXsc38Hjhw0/tIs/1jCsk3yQ?=
Content-Type: multipart/alternative;
 boundary="_000_PH7PR12MB8596208E8AB5A8DF48455D6F8228APH7PR12MB8596namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8596.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9432d90a-c348-42e4-51f6-08ddd8c73a66
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2025 11:07:14.6061 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3VPo1Ac1Z2bLayQbEI2G5oYMHowT1fFh8uCVb1UC3JGJ+vDjQhQN/wqejG7s2cd8TCFvNDRQPrd+8esDaZxv8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4471
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

--_000_PH7PR12MB8596208E8AB5A8DF48455D6F8228APH7PR12MB8596namp_
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

W1B1YmxpY10NCg0KSGkgS2hhZGVtDQoNCnNuaXBwZWQNCg0KSGkgVmlwaW4sDQpHbGFkIHlvdSBn
b3QgdGhlIHJlYXNvbi4NCkkgaGF2ZSBvbmx5IGNoZWNrZWQgaXQgaW4gdGVzdHBtZCwgYW55IG90
aGVyIGFwcGxpY2F0aW9uIHdoaWNoIHByb3ZpZGVzIHByaW1hcnktc2Vjb25kYXJ5IHN1cHBvcnQg
Y291bGQgYWxzbyBmb2xsb3cgdGhlIHNhbWUgbW9kZWwuDQpUaGlzIHBhdGNoIG9ubHkgYWRkcyBz
dGFiaWxpdHkgYW5kIHJvYnVzdG5lc3MgdG8gcHJpbWFyeS1zZWNvbmRhcnkgYXBwbGljYXRpb25z
LiBQcmltYXJ5IGFwcGxpY2F0aW9ucyBjYW4gYmUgY2xvc2VkLCBxdWl0IG9yIHNodXRkb3duDQpi
eSB2YXJpb3VzIHJlYXNvbnMgd2hpbGUgc2Vjb25kYXJ5IGVuZC11cCB3aXRoIGRhbmdsaW5nIHBv
aW50ZXJzLg0KV2l0aG91dCB0aGUgcHJpbWFyeSBhcHBsaWNhdGlvbiwgdGhlIHNlY29uZGFyeSBj
b3VsZCBub3QgZG8gYW55IHJ4IG9yIHR4Lg0KDQoNCkNhbiB5b3UgcGxlYXNlIGFuc3dlciB0byB0
aGUgcHJldmlvdXMgcXVlc3Rpb24gYGFyZSB5b3UgU0lHS0lMTCBvciBkb2luZyBncmFjZWZ1bCBz
aHV0ZG93biB0byBwcmltYXJ5YD8gSUJvdGggYXJlIGRpZmZlcmVudCBiZWhhdmlvdXINCg==

--_000_PH7PR12MB8596208E8AB5A8DF48455D6F8228APH7PR12MB8596namp_
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: base64

PGh0bWwgeG1sbnM6dj0idXJuOnNjaGVtYXMtbWljcm9zb2Z0LWNvbTp2bWwiIHhtbG5zOm89InVy
bjpzY2hlbWFzLW1pY3Jvc29mdC1jb206b2ZmaWNlOm9mZmljZSIgeG1sbnM6dz0idXJuOnNjaGVt
YXMtbWljcm9zb2Z0LWNvbTpvZmZpY2U6d29yZCIgeG1sbnM6bT0iaHR0cDovL3NjaGVtYXMubWlj
cm9zb2Z0LmNvbS9vZmZpY2UvMjAwNC8xMi9vbW1sIiB4bWxucz0iaHR0cDovL3d3dy53My5vcmcv
VFIvUkVDLWh0bWw0MCI+DQo8aGVhZD4NCjxtZXRhIGh0dHAtZXF1aXY9IkNvbnRlbnQtVHlwZSIg
Y29udGVudD0idGV4dC9odG1sOyBjaGFyc2V0PXV0Zi04Ij4NCjxtZXRhIG5hbWU9IkdlbmVyYXRv
ciIgY29udGVudD0iTWljcm9zb2Z0IFdvcmQgMTUgKGZpbHRlcmVkIG1lZGl1bSkiPg0KPHN0eWxl
PjwhLS0NCi8qIEZvbnQgRGVmaW5pdGlvbnMgKi8NCkBmb250LWZhY2UNCgl7Zm9udC1mYW1pbHk6
IkNhbWJyaWEgTWF0aCI7DQoJcGFub3NlLTE6MiA0IDUgMyA1IDQgNiAzIDIgNDt9DQpAZm9udC1m
YWNlDQoJe2ZvbnQtZmFtaWx5OkNhbGlicmk7DQoJcGFub3NlLTE6MiAxNSA1IDIgMiAyIDQgMyAy
IDQ7fQ0KQGZvbnQtZmFjZQ0KCXtmb250LWZhbWlseTpBcHRvczt9DQovKiBTdHlsZSBEZWZpbml0
aW9ucyAqLw0KcC5Nc29Ob3JtYWwsIGxpLk1zb05vcm1hbCwgZGl2Lk1zb05vcm1hbA0KCXttYXJn
aW46MGluOw0KCWZvbnQtc2l6ZToxMi4wcHQ7DQoJZm9udC1mYW1pbHk6IkFwdG9zIixzYW5zLXNl
cmlmO30NCnNwYW4uRW1haWxTdHlsZTE4DQoJe21zby1zdHlsZS10eXBlOnBlcnNvbmFsLXJlcGx5
Ow0KCWZvbnQtZmFtaWx5OiJBcmlhbCIsc2Fucy1zZXJpZjsNCgljb2xvcjp3aW5kb3d0ZXh0O30N
Ci5Nc29DaHBEZWZhdWx0DQoJe21zby1zdHlsZS10eXBlOmV4cG9ydC1vbmx5Ow0KCWZvbnQtc2l6
ZToxMC4wcHQ7DQoJbXNvLWxpZ2F0dXJlczpub25lO30NCkBwYWdlIFdvcmRTZWN0aW9uMQ0KCXtz
aXplOjguNWluIDExLjBpbjsNCgltYXJnaW46MS4waW4gMS4waW4gMS4waW4gMS4waW47fQ0KZGl2
LldvcmRTZWN0aW9uMQ0KCXtwYWdlOldvcmRTZWN0aW9uMTt9DQotLT48L3N0eWxlPjwhLS1baWYg
Z3RlIG1zbyA5XT48eG1sPg0KPG86c2hhcGVkZWZhdWx0cyB2OmV4dD0iZWRpdCIgc3BpZG1heD0i
MTAyNiIgLz4NCjwveG1sPjwhW2VuZGlmXS0tPjwhLS1baWYgZ3RlIG1zbyA5XT48eG1sPg0KPG86
c2hhcGVsYXlvdXQgdjpleHQ9ImVkaXQiPg0KPG86aWRtYXAgdjpleHQ9ImVkaXQiIGRhdGE9IjEi
IC8+DQo8L286c2hhcGVsYXlvdXQ+PC94bWw+PCFbZW5kaWZdLS0+DQo8L2hlYWQ+DQo8Ym9keSBs
YW5nPSJFTi1VUyIgbGluaz0iIzQ2Nzg4NiIgdmxpbms9IiM5NjYwN0QiIHN0eWxlPSJ3b3JkLXdy
YXA6YnJlYWstd29yZCI+DQo8cCBzdHlsZT0iZm9udC1mYW1pbHk6Q2FsaWJyaTtmb250LXNpemU6
MTBwdDtjb2xvcjojMDA4MDAwO21hcmdpbjo1cHQ7Zm9udC1zdHlsZTpub3JtYWw7Zm9udC13ZWln
aHQ6bm9ybWFsO3RleHQtZGVjb3JhdGlvbjpub25lOyIgYWxpZ249IkxlZnQiPg0KW1B1YmxpY108
YnI+DQo8L3A+DQo8YnI+DQo8ZGl2Pg0KPGRpdiBjbGFzcz0iV29yZFNlY3Rpb24xIj4NCjxwIGNs
YXNzPSJNc29Ob3JtYWwiPjxzcGFuIHN0eWxlPSJmb250LXNpemU6MTEuMHB0O2ZvbnQtZmFtaWx5
OiZxdW90O0FyaWFsJnF1b3Q7LHNhbnMtc2VyaWYiPkhpIEtoYWRlbTxvOnA+PC9vOnA+PC9zcGFu
PjwvcD4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiPjxzcGFuIHN0eWxlPSJmb250LXNpemU6MTEuMHB0
O2ZvbnQtZmFtaWx5OiZxdW90O0FyaWFsJnF1b3Q7LHNhbnMtc2VyaWYiPjxvOnA+Jm5ic3A7PC9v
OnA+PC9zcGFuPjwvcD4NCjxkaXYgc3R5bGU9ImJvcmRlcjpub25lO2JvcmRlci1sZWZ0OnNvbGlk
IGJsdWUgMS41cHQ7cGFkZGluZzowaW4gMGluIDBpbiA0LjBwdCI+DQo8ZGl2Pg0KPGRpdj4NCjxk
aXY+DQo8ZGl2Pg0KPGRpdj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiPjxiPjxzcGFuIHN0eWxlPSJm
b250LXNpemU6MTEuMHB0O2ZvbnQtZmFtaWx5OiZxdW90O0NhbGlicmkmcXVvdDssc2Fucy1zZXJp
ZiI+c25pcHBlZDxvOnA+PC9vOnA+PC9zcGFuPjwvYj48L3A+DQo8cCBjbGFzcz0iTXNvTm9ybWFs
Ij48Yj48c3BhbiBzdHlsZT0iZm9udC1zaXplOjExLjBwdDtmb250LWZhbWlseTomcXVvdDtDYWxp
YnJpJnF1b3Q7LHNhbnMtc2VyaWYiPjxvOnA+Jm5ic3A7PC9vOnA+PC9zcGFuPjwvYj48L3A+DQo8
cCBjbGFzcz0iTXNvTm9ybWFsIj5IaSBWaXBpbiwmbmJzcDs8bzpwPjwvbzpwPjwvcD4NCjwvZGl2
Pg0KPGRpdj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiPkdsYWQgeW91IGdvdCB0aGUgcmVhc29uLiZu
YnNwOzxvOnA+PC9vOnA+PC9wPg0KPC9kaXY+DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+
SSBoYXZlIG9ubHkgY2hlY2tlZCBpdCBpbiB0ZXN0cG1kLCBhbnkgb3RoZXIgYXBwbGljYXRpb24g
d2hpY2ggcHJvdmlkZXMgcHJpbWFyeS1zZWNvbmRhcnkmbmJzcDtzdXBwb3J0IGNvdWxkIGFsc28g
Zm9sbG93IHRoZSBzYW1lIG1vZGVsLiZuYnNwOzxvOnA+PC9vOnA+PC9wPg0KPC9kaXY+DQo8ZGl2
Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+VGhpcyBwYXRjaCBvbmx5IGFkZHMgc3RhYmlsaXR5IGFu
ZCByb2J1c3RuZXNzIHRvIHByaW1hcnktc2Vjb25kYXJ5IGFwcGxpY2F0aW9ucy4gUHJpbWFyeSBh
cHBsaWNhdGlvbnMmbmJzcDtjYW4gYmUgY2xvc2VkLCBxdWl0IG9yIHNodXRkb3duJm5ic3A7PG86
cD48L286cD48L3A+DQo8L2Rpdj4NCjxkaXY+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj5ieSB2YXJp
b3VzIHJlYXNvbnMgd2hpbGUgc2Vjb25kYXJ5IGVuZC11cCB3aXRoIGRhbmdsaW5nIHBvaW50ZXJz
LiZuYnNwOyAmbmJzcDs8bzpwPjwvbzpwPjwvcD4NCjwvZGl2Pg0KPC9kaXY+DQo8cCBjbGFzcz0i
TXNvTm9ybWFsIj5XaXRob3V0IHRoZSBwcmltYXJ5IGFwcGxpY2F0aW9uLCB0aGUgc2Vjb25kYXJ5
IGNvdWxkIG5vdCBkbyBhbnkgcnggb3IgdHguJm5ic3A7Jm5ic3A7PG86cD48L286cD48L3A+DQo8
L2Rpdj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiPjxvOnA+Jm5ic3A7PC9vOnA+PC9wPg0KPHAgY2xh
c3M9Ik1zb05vcm1hbCI+PHNwYW4gc3R5bGU9ImZvbnQtc2l6ZToxMS4wcHQ7Zm9udC1mYW1pbHk6
JnF1b3Q7QXJpYWwmcXVvdDssc2Fucy1zZXJpZiI+PG86cD4mbmJzcDs8L286cD48L3NwYW4+PC9w
Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+PHNwYW4gc3R5bGU9ImZvbnQtc2l6ZToxMS4wcHQ7Zm9u
dC1mYW1pbHk6JnF1b3Q7QXJpYWwmcXVvdDssc2Fucy1zZXJpZiI+Q2FuIHlvdSBwbGVhc2UgYW5z
d2VyIHRvIHRoZSBwcmV2aW91cyBxdWVzdGlvbiBgYXJlIHlvdSBTSUdLSUxMIG9yIGRvaW5nIGdy
YWNlZnVsIHNodXRkb3duIHRvIHByaW1hcnlgPyBJQm90aCBhcmUgZGlmZmVyZW50IGJlaGF2aW91
cjxvOnA+PC9vOnA+PC9zcGFuPjwvcD4NCjwvZGl2Pg0KPC9kaXY+DQo8L2Rpdj4NCjwvZGl2Pg0K
PC9kaXY+DQo8L2JvZHk+DQo8L2h0bWw+DQo=

--_000_PH7PR12MB8596208E8AB5A8DF48455D6F8228APH7PR12MB8596namp_--
