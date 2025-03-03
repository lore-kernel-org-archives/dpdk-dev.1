Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18DDEC282C5
	for <dpdk-dev@archiver.kernel.org>; Mon,  3 Mar 2025 09:06:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4ACB840280;
	Mon,  3 Mar 2025 10:06:15 +0100 (CET)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2066.outbound.protection.outlook.com [40.107.100.66])
 by mails.dpdk.org (Postfix) with ESMTP id A6468400D7
 for <dev@dpdk.org>; Mon,  3 Mar 2025 10:06:12 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JdIOthPzbUj5I9M27BAtE60SAbJXKM7AauYZEXnDOtfSKxncdu7/le4xjSfbtd8yC6sNUEK//etDWbLbS4r5lZNvCwoX2jAJGGjRnvZ+jj4cHg+weXf/aZ1KVeaZ4RBNqa2QATrgefSPn4OYYRt4z8d7/X/lLdQDT6b80Q0ohBNvDTSQbTCdQ4FG8glvI+dkvpOGtZ5E/HKhp6FSLIvs1VKpW3kuL/UmSzCLuMk18NxsMM0HagLRYLo4f0aw2/40fFG15mHICla0AwRau25tr8vV6K5RscP24oKQrgYXuG98+kn8l1fDXQrF7YzDBddNZ+YsshY8GAa8qbcPa2OcOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5E1bsfXF9kp990jjBVUCY7dHjy3ssoa93cgQfcYTx+E=;
 b=wwn/QqgU/pQ/hRBtRw58vZvl4SpokJ4ccSnI1Opa+IT4A0DQeDBhYbF1MiW3ehp4M4Pjc7GsAjvNCDxrDfBvbhk1gOcD3cJvo2RE8ukPvlD7PrEBfaYywkACBNHcxC81DZLoVSQuPONQgs2vBDqb7q+ix1A0B8HDy57VmdYoaOJlMBedNa6zFmM8wHtAcTWFUlOPsFdiPjX8E0viB+yq3wXIgHx15rEReasTVF8NBr3npcKngZk/IOAspjFmh1oZQIU7HHcowVmSoIAcm12cwKqA0j875Dg7a0gCJjHLgtbxYQ5+6yycB69vYJPgrNIgo6UA6CL+3ROVtRoNxgZFrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5E1bsfXF9kp990jjBVUCY7dHjy3ssoa93cgQfcYTx+E=;
 b=LVGoOdi6/twPXUdprvz4WuRvnFcSypPlBUp9+BEj0DsC9e1DbFZLDlHlB9A7hVJei7Ynnop5zHVYdAy7II12jAVIh1IGGI/nssa0hPZ8VEY9WCj/TUr3GprQH+qIN9AW6K5bYxSgp+iKXsyOUlT3SEXmDuHksQsg7879WdGH1ms=
Received: from PH7PR12MB8596.namprd12.prod.outlook.com (2603:10b6:510:1b7::6)
 by MW3PR12MB4345.namprd12.prod.outlook.com (2603:10b6:303:59::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Mon, 3 Mar
 2025 09:06:10 +0000
Received: from PH7PR12MB8596.namprd12.prod.outlook.com
 ([fe80::a011:943d:7291:8069]) by PH7PR12MB8596.namprd12.prod.outlook.com
 ([fe80::a011:943d:7291:8069%6]) with mapi id 15.20.8489.021; Mon, 3 Mar 2025
 09:06:10 +0000
From: "Varghese, Vipin" <Vipin.Varghese@amd.com>
To: =?utf-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>, Thomas
 Monjalon <thomas@monjalon.net>
CC: "dev@dpdk.org" <dev@dpdk.org>, "roretzla@linux.microsoft.com"
 <roretzla@linux.microsoft.com>, "bruce.richardson@intel.com"
 <bruce.richardson@intel.com>, "john.mcnamara@intel.com"
 <john.mcnamara@intel.com>, "dmitry.kozliuk@gmail.com"
 <dmitry.kozliuk@gmail.com>, "ajit.khaparde@broadcom.com"
 <ajit.khaparde@broadcom.com>, "Song, Keesang" <Keesang.Song@amd.com>,
 "pbhagavatula@marvell.com" <pbhagavatula@marvell.com>, "jerinj@marvell.com"
 <jerinj@marvell.com>, "ruifeng.wang@arm.com" <ruifeng.wang@arm.com>,
 "mattias.ronnblom@ericsson.com" <mattias.ronnblom@ericsson.com>,
 "anatoly.burakov@intel.com" <anatoly.burakov@intel.com>,
 "stephen@networkplumber.org" <stephen@networkplumber.org>, "Yigit, Ferruh"
 <Ferruh.Yigit@amd.com>, "honnappa.nagarahalli@arm.com"
 <honnappa.nagarahalli@arm.com>, "wathsala.vithanage@arm.com"
 <wathsala.vithanage@arm.com>, "konstantin.ananyev@huawei.com"
 <konstantin.ananyev@huawei.com>
Subject: RE: [PATCH v4 0/4] Introduce Topology NUMA grouping for lcores
Thread-Topic: [PATCH v4 0/4] Introduce Topology NUMA grouping for lcores
Thread-Index: AQHbL22WzCqF9Lj5SUqurJMDjBRIs7NFKZjQgABbpICAAAxrAIAcRJQA
Date: Mon, 3 Mar 2025 09:06:10 +0000
Message-ID: <PH7PR12MB8596C47BD103ADF3C275C10E82C92@PH7PR12MB8596.namprd12.prod.outlook.com>
References: <20241105102849.1947-1-vipin.varghese@amd.com>
 <PH7PR12MB85960CB35BB467CEBBC2CA2F82FF2@PH7PR12MB8596.namprd12.prod.outlook.com>
 <2097299.UkFFEUeh36@thomas>
 <98CBD80474FA8B44BF855DF32C47DC35E9FA33@smartserver.smartshare.dk>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35E9FA33@smartserver.smartshare.dk>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=6b2a6539-f8a0-4a1d-a2ba-9ff51dfaf7b7;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-03-03T09:01:36Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Tag=10, 0, 1, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8596:EE_|MW3PR12MB4345:EE_
x-ms-office365-filtering-correlation-id: ac42f05a-174c-47df-e38e-08dd5a32a41d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|366016|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?SE9tQzFVdmNmeHhUQnJYYWlCeHlBRUJuQThhNVF2dzFSN0NLdkt2SWc5c0F5?=
 =?utf-8?B?WnZBYjk3bnhQNXFQRC85a0llb3haNDc4VTZkejFNbXg0YkhaL3FSZWFOVC9m?=
 =?utf-8?B?emlpZTY5WGpxdEZFRTl2dlU5WVVFR1FtcGRKaFltaUp3Wkk2NlRFQjBiTHA2?=
 =?utf-8?B?ajVocXE1Y3N2RzlsS1JyeWNHQzRNbGdJVWtwZksrT0RxTVhGdjVPbFBBUEVq?=
 =?utf-8?B?WjNZWFhFd3RIdDdUQ1hSSVlTVlN2YmdXTXpYRXc1UGVzTzVHMFJFWkdjNVhV?=
 =?utf-8?B?QzMwZDBScTI3eHlkaUxDYVJjMVUyOTFzSHI3Yk1pckpWS3ZBRlBoeit4VWtk?=
 =?utf-8?B?M0FnN3E2OFExdlExOGpvRDlHY3JLbWNrYm1SN2ZNMExJbVgxYUFUNWw2R2hG?=
 =?utf-8?B?OFk5NEs4Z3VzNUxJYVhOK2F5bVY5YmpUWDhwUmlOQk5aWU9FdVlKakVmY1ZZ?=
 =?utf-8?B?V0xjVUpBTFVFUTVxd3dKSy83Wis2WGRyOS91KzN0TGVCM3pHRnpIbGUvQ0Zi?=
 =?utf-8?B?b1d2VytLYUR6aW9WeUZ6R3RUTUM5RVpUa0crWDRGelpqS3NLKzYrd2paQnYx?=
 =?utf-8?B?U0diRmZrMjNhQUVMaFczQ0pjUWVaaDl1L0hRZWR5Nnl4M3JFaHNuOFJkTSs2?=
 =?utf-8?B?MXBIZWw5bm1MRFZZMnBqZ3JWaStQUS9CS1ZSYjF1cVJyQ3NpOFpYemFtSDhj?=
 =?utf-8?B?VlIxYmovbGZDL3FFYWhZZDFsd21Ya0t2dEZ4TUlkOTY2Z1k0c0podE40R2ox?=
 =?utf-8?B?V1ZiQ3RNVU5mNmlSWWQvVkcwZGs3M3NGQ0YvR3ZpUEpmTzlHQkUrOXNRUks0?=
 =?utf-8?B?amR1bi9Yb1FYRUV3dlhZdmJvYVRMZFZ6M2VXaTNWZktLTUR6NGsvNjVCbGlz?=
 =?utf-8?B?SmxOMTc4QnBUZGJycEdGdGFhZENDRk02KzVBOEhINElPRDB6VG9oSUZseE5Q?=
 =?utf-8?B?V2dCZjN5bVAwS2FqVk5hYThsQ0hoalNpRTdCVEpTMU9OUjEybmY3QzM0UldC?=
 =?utf-8?B?ZmZPdVVsQy95bk1DWjhmaEZwTnpvcDBqaW96M3MrOHAwVjJVMWRhK0lTN3Z4?=
 =?utf-8?B?cWFrTEdFckpkNlRLZkJBZ1d2Q0hsZFlOcFo4akcwTjMxWFNGZkxJbkNJZ2FI?=
 =?utf-8?B?QWdxdkNmZy9wc1pIWmpSdmVUQS94T283UlB0dFBqVFV1Q05ZK1hTVXFjWXhM?=
 =?utf-8?B?VlAwaDJjSzNkWUsvSmdVS0RRNlpBYU41d0Q4UFg0Tkc3MTcwQnRPL1NvdVVz?=
 =?utf-8?B?SkJZbm5sR3ZHNEU0NFNWdHBaZTFJN2RMd1NIMFBhMFdpZHRXSVRsc3J6aGlB?=
 =?utf-8?B?R1IwRjB3ZzY3V0V0TmhnOVpCYzhwWXJmSHdqdlRadXQ4aDdqUm9pbHRNNmhR?=
 =?utf-8?B?eEJiNG1YdDlqT01XSVVLZUZLZE5jOGx3TTVjV2JwSW1EWUt2NThmMjNxZ1ln?=
 =?utf-8?B?K1hFbUJ6STMrVkZSeTFlYitMOFEyNWlwWCtycmJpUERyZVpiUjhrZGYwNlFm?=
 =?utf-8?B?V2lRQy9aTkdoZUltS3RUSURhakQ2MGh1M1pUOGlCSUlMRUtFK1RIZ21hNjNL?=
 =?utf-8?B?Ky9BeVIyKzkxRVVQMjloR0tldjVWakNyQ3BZb0ZaTlhsaGFOZFRvWEdoNGdE?=
 =?utf-8?B?akhxRHZMdEhSYUhUSGpnS3pld0xtQ0piMFlyTUY4bUJYV3gvdkNnS2VwUmhN?=
 =?utf-8?B?am8yY2NXUVBTWDhVYUhXajNYcWFVVkxJRjdpU2xkNS9LM1JRMUZ6dTQ1S3BM?=
 =?utf-8?B?ZU82aTQyUjBiVkxUOXdCKzNnQytWUjBFNUQwY05LTmdiV0srK2dyM1RPdXJh?=
 =?utf-8?B?eER6bHJPZ1JkUUpKRzkraXEwY0M1RVVUZ1NrOFlQanA2dVNiZjI5Mk9QSGJW?=
 =?utf-8?B?cWdhUmh1MzFuVnBENk84QTdVdkNQQmlXS0d2djJmcjQ3RldocU9FQW1KdnBu?=
 =?utf-8?Q?LmdozLbz8O1fRY8Ik86soQ9bRBiEk0zL?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8596.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VWJFTFkzRUhmUGVDUEhqV0ZIQittUjBrVC9aMEJBMHN4V3dnQkNNNXFFaXVZ?=
 =?utf-8?B?TTJXUS9qdWJsekxXellWWm5DK0tFeHRRL3NzdndpTU9BR0RDVGtKWVNIYkdI?=
 =?utf-8?B?WEtCaUlKTFVpMjRWU0NGQ001MjFRRDB4NnIvalI0VHoxQjNYOTZDL2VnQUY3?=
 =?utf-8?B?M0NtRHFSWlVpK0o3eG9xdk1jWThGbm9iWlVtckt0UnJQV2thQ1Q3UmJ2ZDVo?=
 =?utf-8?B?cVlBU1FGOTNGRlhkcTNuVnhKcm9vazN4YUxyTEFjRmtzZ2dpZ3lTM2Yzc2lD?=
 =?utf-8?B?SEsveTh2MS9KNFA2clQ5YXBHTytVN0lhb1BkNHNsckw0TGNxbjdvaE9mUEdD?=
 =?utf-8?B?K0VnSVFjZU14ajJJKzAwMFdHTXg5U21hRnkxMERyZjFoQ25TN3VXWllHd0Nq?=
 =?utf-8?B?YXRIVFo5SXh6U0Zab1ZoTlFYcnJRR0h2cDV0dXhvWlRsNWNycktYSTJrbHkr?=
 =?utf-8?B?TnpaZWpxL3B2bHpTOHRDTGwrSUNibE1xa3NKZ2haaHpid1dUa3FEcDBKZFNh?=
 =?utf-8?B?Tk04SkFvQi9tRm0vZXlhMmMva3N4dFprMytMRzhQelJBWU9MT25zRHBrSHVC?=
 =?utf-8?B?alphUDBhRHVpZ291UnNPRFd0ZkhHLy9DZEhtd0lUWlhlNjM2T09WYTcvL3ZD?=
 =?utf-8?B?YVZCcHduNU1QWXpmMk14UVNPZzhqVWhKbzRGVVZCY1BDVEpVZThiVUgyMlVl?=
 =?utf-8?B?eEdmd3c3QjIySDI1RzdRSXAyc0NqVXU2YldzUUpsOThUUGtacGRmTEFEMENW?=
 =?utf-8?B?dVlxaEVnUnV1alJKYXNVaFcvTUpuNlJuTXRuR0lubzdoT1I4S28ySkdaamMw?=
 =?utf-8?B?RHVYbldRY203a0kzMG40Yzl2VGw2aFBxOG1lVE5vVjg3NVY4YUVYeDZSNFpW?=
 =?utf-8?B?b0hiWGM0NjBVeEI5WDVHMi95VmZkclBWTTk5ME10SjlNdU45MmNqaTErbml4?=
 =?utf-8?B?NzdBSHpxYXVMRW14NE94ckhSUHRMZDdMQXMxc0ZjNDVRSlB4d0JMMXNydVpi?=
 =?utf-8?B?ZHRualdwbG9kdHpTeWlSazE0U3FNMmJwR3FIczNkK0w0bmdwSWxHUlRKRzVq?=
 =?utf-8?B?WlBEZXI1SlVKN1NnMWZIaU4wTEFMZUtJdUdreEZrU21ZK3NQOHFMTGg4NHQy?=
 =?utf-8?B?WHdZd0FUVWpqN1JIbi9tMVBDRXNjSTlGRzFPdzJTWEdBVFIrT1hnbFgzb2pp?=
 =?utf-8?B?VUdnNE5RNVRNNXpYVGpTUWlWQkpwL0wzaWpKb3dSQStZalBoOTh1b2NCUE5C?=
 =?utf-8?B?OFd3MlA2clJ5SG8rNFNZbkFseHVQVmFlb1FKU21kUGlkaWlSZngvdlJsUG10?=
 =?utf-8?B?RjlFRy9MUFhSWmxsSXhsaWtSSTFNTGRFVUVKditjMHBKYm5LVVNCRzZnL3N2?=
 =?utf-8?B?RHA5a25XZmoyTjB5UEtuRFBjczNNbzlHUHExVStlZnhCejRZa0tkRXhNalpq?=
 =?utf-8?B?SEU2ZXFYZDZuQzQxU01xb2xzcTJzeXowZm9BMzJYZUpFM2JnVU83cUdLNTZm?=
 =?utf-8?B?aVdPWWtpa0VuUnVJd09GbVB6RzQ1VmRkUjNrb2orano4b2RvdkhKU3BOVzBP?=
 =?utf-8?B?VlRGZDM0TkhxMWR1UEFmeUh3QkNFdmtWQ05pTG95ZHFjTFdJajBVRHBmVmdt?=
 =?utf-8?B?WHJpWmZsTVdSMlhKOHhkTkIwc2Ezb0RqMlR3T3E2UksxcERUOHVjb2RaWldn?=
 =?utf-8?B?c3lUWUpBaUdsZU5IQWx2YnR6VmVVcXJzRENMZi9zbGlvczlUSXJlYkJDSFpK?=
 =?utf-8?B?VWIwcS9YUGJHYW9lbXg2TWpTTlY2RU1QY3dRWGhCYjZENTIzUldhZ3QxbWtK?=
 =?utf-8?B?c01SUDBPM2JOdUpoQS80SWxjUjNrSEE1UzNKQ2RVYTk1d3Q0UldFK0liSzcx?=
 =?utf-8?B?L2QrYzRISDZ0SkhCMDlJUnJjVGt2amVpYjA3NzNpOXRBMHdvak5NWmVnSlVZ?=
 =?utf-8?B?NU1CZ1NtOE9CeStibDNKbXVpYnh0RUtXUDNRZzBodWxRcjhaSHFQQ0VRYjRP?=
 =?utf-8?B?SHlBMHk3REJiUTRGdEtUcVpPcWdFSy91VDdoVEF6ams5RmVFR093WXIveG52?=
 =?utf-8?B?ZTQ4M1MraFBsSXlTTXNzMWZ2RmIyYXNJUmVVQXMveG5qaE5YRC9YS1NLQzF0?=
 =?utf-8?Q?OWc4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8596.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac42f05a-174c-47df-e38e-08dd5a32a41d
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2025 09:06:10.4430 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l+PuUALlRLc+j+1Jb8kf7JeN/2LDxNazM8HlshTphJHsbbkaRUX+ysRneiyujVKEggfDqEmV8IlYfzqq7x78aw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4345
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

W1B1YmxpY10NCg0KSGkgTW9ydGVuLA0KDQpzbmlwcGVkDQoNCg0KPg0KPg0KPiA+IEZyb206IFRo
b21hcyBNb25qYWxvbiBbbWFpbHRvOnRob21hc0Btb25qYWxvbi5uZXRdDQo+ID4gU2VudDogVGh1
cnNkYXksIDEzIEZlYnJ1YXJ5IDIwMjUgMDkuMzQNCj4gPg0KPiA+IDEzLzAyLzIwMjUgMDQ6MDks
IFZhcmdoZXNlLCBWaXBpbjoNCj4gPiA+IFtBTUQgT2ZmaWNpYWwgVXNlIE9ubHkgLSBBTUQgSW50
ZXJuYWwgRGlzdHJpYnV0aW9uIE9ubHldDQo+ID4gPg0KPiA+ID4gQWRkaW5nIFRob21hcyBhbmQg
QWppdCB0byB0aGUgbG9vcC4NCj4gPiA+DQo+ID4gPiBIaSBBaml0LCB3ZSBoYXZlIGJlZW4gdXNp
bmcgdGhlIHBhdGNoIHNlcmllcyBmb3IgaWRlbnRpZnlpbmcgdGhlDQo+ID4gdG9wb2xvZ3kgYW5k
IGdldHRpbmcgbDMgY2FjaGUgaWQgZm9yIHBvcHVsYXRpbmcgdGhlIHN0ZWVyaW5nIHRhZyBmb3IN
Cj4gPiBEZXZpY2UgU3BlY2lmaWMgTW9kZWwgJiBNU0kteCBkcml2ZW4gYWYteGRwIGZvciB0aGUg
ZXhwZXJpbWVudGFsIFNUQUcNCj4gPiBmaXJtd2FyZSBvbiBUaG9yLg0KPg0KPiBFeGNlbGxlbnQu
IEEgcmVhbCBsaWZlIGV4YW1wbGUgdXNlIGNhc2UgaGVscHMgdGhlIHJldmlldyBwcm9jZXNzIGEg
bG90IQ0KDQpTdGVlcmluZyB0YWcgaXMgb25lIG9mIHRoZSBleGFtcGxlcyBvciB1c2VzLCBhcyBz
aGFyZWQgaW4gdGhlIGN1cnJlbnQgcGF0Y2ggc2VyaWVzICB3ZSBtYWtlIHVzZSBvZiB0aGVzZSBm
b3Igb3RoZXIgZXhhbXBsZXMgdG9vLg0KRXZlbnRkZXYsIHBrdC1kaXN0cmlidXRvciBhbmQgZ3Jh
cGggbm9kZXMgYXJlIGFsc28gaW4gd29ya3MgdG8gZXhwbG9pdCBMMnxMMyBjYWNoZSBsb2NhbCBj
b2hlcmVuY3kgdG9vLg0KDQo+DQo+ID4gPg0KPiA+ID4gSGVuY2UgY3VycmVudCB1c2Ugb2YgdG9w
b2xvZ3kgbGlicmFyeSBoZWxwcyBpbiAxLiB3b3JrbG9hZCBwbGFjZW1lbnQNCj4gPiA+IGluIHNh
bWUgQ2FjaGUgb3IgSU8gZG9tYWluIDIuIHBvcHVsYXRpbmcgaWQgZm9yIE1TSXggb3IgRGV2aWNl
DQo+ID4gPiBzcGVjaWZpYyBtb2RlbCBmb3Igc3RlZXJpbmcgdGFncy4NCj4gPiA+DQo+ID4gPiBU
aG9tYXMgYW5kIEFqaXRoIGNhbiB3ZSBnZXQgc29tZSBoZWxwIHRvIGdldCB0aGlzIG1haW5saW5l
IHRvbz8NCj4gPg0KPiA+IFllcywgc29ycnkgdGhlIHJldmlldyBkaXNjdXNzaW9ucyBkaWQgbm90
IHN0YXJ0Lg0KPiA+IEl0IGhhcyBiZWVuIGZvcmdvdHRlbi4NCj4NCj4gSSB0aGluayB0aGUgdG9w
b2xvZ3kvZG9tYWluIEFQSSBpbiB0aGUgRUFMIHNob3VsZCBiZSBjby1kZXNpZ25lZCB3aXRoIHRo
ZSBzdGVlcmluZw0KPiB0YWcgQVBJIGluIHRoZSBldGhkZXYgbGlicmFyeSwgc28gdGhlIGRlc2ln
biBjYW4gYmUgcmV2aWV3ZWQvZGlzY3Vzc2VkIGluIGl0cyBlbnRpcmV0eS4NCg0KQXMgc2hhcmVk
IGluIHRoZSBkaXNjdXNzaW9uLCB3ZSBoYXZlIGJlZW4gZXhwbG9yaW5nIHNpbXBsaWZpZWQgYXBw
cm9hY2ggZm9yIHN0ZWVyaW5nIHRhZ3MsIG5hbWVseQ0KDQoxLiBwY2ktZGV2IGFyZ3MgKGNydWRl
IHdheSkNCjIuIGZsb3cgYXBpIGZvciBSWCAoZXhwZXJpbWVudGFsIHdheSkNCg0KQmFzZWQgb24g
dGhlIHBsYXRmb3JtIChpbiBjYXNlIG9mIEFNRCBFUFlDLCB0aGVzZSBhcmUgdHJhbnNsYXRlZCB0
byBgTDMgaWQgKyAxYCkNCg0KV2UgZG8gYWdyZWUgcnRlX2V0aGRldiBsaWJyYXJ5IGNhbiB1c2Ug
dG9wb2xvZ3kgQVBJLiBDdXJyZW50IHRvcG9sb2d5IEFQSSBhcmUgZGVzaWduZWQgdG8gYmUgbWFk
ZSBpbmRlcGVuZGVudCBmcm9tIHN0ZWVyaW5nIHRhZ3MsIGFzIG90aGVyIGV4YW1wbGVzIGRvIG1h
a2UgdXNlIG9mIHRoZSBzYW1lLg0KDQo+DQo+IFRvIGhlbHAgdGhlIHJldmlldyBkaXNjdXNzaW9u
LCBwbGVhc2UgY29uc2lkZXIgZGVzY3JpYmluZyB0aGUgZm9sbG93aW5nOg0KPiBXaGljaCBBUElz
IGFyZSBmb3Igc2xvdyBwYXRoLCBhbmQgd2hpY2ggYXJlIGZvciBmYXN0IHBhdGg/DQo+IFdoaWNo
IEFQSXMgYXJlICJtdXN0IGhhdmUiLCBpLmUuIGNvcmUgdG8gbWFraW5nIGl0IHdvcmsgYXQgYWxs
LCBhbmQgd2hpY2ggQVBJcyBhcmUNCj4gIm5pY2UgdG8gaGF2ZSIsIGkuZS4gc3VwcG9ydCBBUElz
IHRvIGVhc2UgdXNlIG9mIHRoZSBuZXcgZmVhdHVyZXM/DQoNClllcywgd2lsbCB0cnkgdG8gZG8g
dGhlIHNhbWUgaW4gdXBkYXRlZCB2ZXJzaW9uLiBGb3IgU2xvdyBhbmQgRmFzdCBwYXRoIEFQSSBJ
IG1pZ2h0IG5lZWQgc29tZSBoZWxwLCBhcyBJIHdhcyB1bmRlciB0aGUgaW1wcmVzc2lvbiBjdXJy
ZW50IGJlaGF2aW9yIGlzIHNhbWUgcnRlX2xjb3JlIChpbnZva2VkIGF0IHNldHVwIGFuZCBiZWZv
cmUgcmVtb3RlIGxhdW5jaCkuIEJ1dCB3aWxsIGNoZWNrIGFnYWluLg0KDQo+DQo+IEkgaGF2ZW4n
dCBsb29rZWQgYXQgdGhlIGh3bG9jIGxpYnJhcnkncyBBUEk7IGJ1dCBJIGd1ZXNzIHRoZXNlIG5l
dyBFQUwgZnVuY3Rpb25zIGFyZQ0KPiBjbG9zZWx5IHJlbGF0ZWQuIElzIGl0IGEgdGhpbiB3cmFw
cGVyIGFyb3VuZCB0aGUgaHdsb2MgbGlicmFyeSwgb3IgaXMgaXQgdmVyeSBkaWZmZXJlbnQ/DQpU
aGlzIGlzIHZlcnkgdGhpbiB3cmFwcGVyIG9uIHRvcCBvZiBod2xvYyBsaWJyYXJ5IG9ubHkuIEJ1
dCB3aXRoIERQREsgUlRFX01BWF9MQ09SRSAmIFJURV9OVU1BIGJvdW5kYXJ5IGNoZWNrIGFuZCBw
b3B1bGF0aW9uLg0KDQo=
