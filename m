Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC74DC021BC
	for <dpdk-dev@archiver.kernel.org>; Tue, 25 Feb 2025 13:27:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DB5B9427C5;
	Tue, 25 Feb 2025 14:27:46 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id E71B841101
 for <dev@dpdk.org>; Tue, 25 Feb 2025 14:27:44 +0100 (CET)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51ONUjKG008228;
 Tue, 25 Feb 2025 05:27:44 -0800
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2172.outbound.protection.outlook.com [104.47.59.172])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4512gd1n2r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 25 Feb 2025 05:27:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ut000wABipILs1BeXUiHWj0sUI4bnQux7bJXcuYI3kN1+llyLIFaPiKdXZeOV45jkno8xaPzL7IqnV9dBGwRwTwE3LUJhjU/9T7qC9RP0J5lXyMGYR9bU9ewt17Dk9gOwRi0WPIHgmiaAkp8s7eOS6o3iEeCtgLwaVbuk6otdlIs/WBwHiiwYbMqUU5OCey1gnmJx+zHkNjfda1KNC4eLRliSMC0HWUm335rzrbF19qrsenbHCKuTsgbZ7VP9ZsOfGU1efXQbBvnYemIVeUntruKFY37EAUwaRw6y/JBGrEA5aIXr7OaKtYh8nmncw5bFm16xBoN2jGXF9YK95tGIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yIRvLYbc7PdTOaEtRKhukRViEZMbPAXyhQQuUiP6AJg=;
 b=TPvXm2ArRazog3CU3l5gYvorYmeNP/qiWrUvNMRGwGkSk4UHxKJzxdo9MuQZC3reykjpA5GO3rOK0EawAfBZODiHc9DBqnQx6JwAM8IToZEwLMX0rAiG4E8ujvIwBpDPQS9NOMLFkBMIfnF6npdpWe/rogPBFlTkpSXB9yiFQrylhD83Nlk2OnpGuJJxgBqRqPk1nuJjccwCs/apkztBTmn3/j/G3e+PfOTPihz48HxhxtjAP8aIQ3N2p9KotH/wShJO2he0PlG5T2eKpp/LZsdej5IpqUIJ3f5byEjyf5rzE/MaXCf7vWv5xx4f5smkLrbZAeoZgBKqbgc3g5ppLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yIRvLYbc7PdTOaEtRKhukRViEZMbPAXyhQQuUiP6AJg=;
 b=D9o0UjI+GinvHKa69BFRagle/zSL389BNl/G6wvXx2ryYMRkPryo0FliULiMyzODSxF9YEsr1yj+O4KoJu+nm0nTp6Lh7xp3ValwspBGTw8HLK7ZZk2O98rBZ79gC7Up9FNlZw8WFvn0CKjuM+VFvMGmgADWEtU4QgDz40svFpE=
Received: from PH0PR18MB5167.namprd18.prod.outlook.com (2603:10b6:510:168::7)
 by LV3PR18MB5804.namprd18.prod.outlook.com (2603:10b6:408:1b8::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.18; Tue, 25 Feb
 2025 13:27:40 +0000
Received: from PH0PR18MB5167.namprd18.prod.outlook.com
 ([fe80::fd38:dcb3:d404:a4b6]) by PH0PR18MB5167.namprd18.prod.outlook.com
 ([fe80::fd38:dcb3:d404:a4b6%3]) with mapi id 15.20.8466.016; Tue, 25 Feb 2025
 13:27:40 +0000
From: Amit Prakash Shukla <amitprakashs@marvell.com>
To: Pavan Nikhilesh Bhagavatula <pbhagavatula@marvell.com>, "Gujjar,
 Abhinandan S" <abhinandan.gujjar@intel.com>, Stephen Hemminger
 <stephen@networkplumber.org>, "dev@dpdk.org" <dev@dpdk.org>
CC: =?utf-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>, "Richardson,
 Bruce" <bruce.richardson@intel.com>, Jerin Jacob <jerinj@marvell.com>,
 "Naga Harish K, S V" <s.v.naga.harish.k@intel.com>
Subject: RE: [PATCH v3 02/14] eventdev: remover unnecessary deref on function
 pointers
Thread-Topic: [PATCH v3 02/14] eventdev: remover unnecessary deref on function
 pointers
Thread-Index: AQHbh4WfFCrAn+GL70iaL1q4v7UHj7NYAGuAgAABrNA=
Date: Tue, 25 Feb 2025 13:27:40 +0000
Message-ID: <PH0PR18MB5167A88AE385AFD4A6721BA4C8C32@PH0PR18MB5167.namprd18.prod.outlook.com>
References: <20250217185743.169778-1-stephen@networkplumber.org>
 <20250220165644.16421-1-stephen@networkplumber.org>
 <20250220165644.16421-3-stephen@networkplumber.org>
 <PH0PR11MB5832F523118C148BC6C9D52FE8C32@PH0PR11MB5832.namprd11.prod.outlook.com>
 <PH0PR18MB4086D9AD289E04DBB2DE8679DEC32@PH0PR18MB4086.namprd18.prod.outlook.com>
In-Reply-To: <PH0PR18MB4086D9AD289E04DBB2DE8679DEC32@PH0PR18MB4086.namprd18.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR18MB5167:EE_|LV3PR18MB5804:EE_
x-ms-office365-filtering-correlation-id: 594db26f-2b23-4aab-e5d7-08dd55a02d82
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?utf-8?B?bit5UnFUYmsyQ2JnQXIrY1pTejYzaEZGYzAwUEd0Y3ljRXJhRnYycUl5eEpi?=
 =?utf-8?B?ejB5SE5nUWptS0l6b1UyZ1BLZzFXTWNLRnE4cTlVMFp5R1N0TklSZTJ4WWF2?=
 =?utf-8?B?eWF0MGFtMFlmOTlabFloaXRBYVhLZTNrTExFQ3pyQVdIRnVpLzBTN3VrekFo?=
 =?utf-8?B?cERSc1cxVUcrMG1jb2RYcFRuaUIwcGdxY3pyZWpkVnNyc1BMVXJwRi9Kd2VU?=
 =?utf-8?B?elNlTStTbGtVZUlUclM0R3JRZFNYZDQ0SG4zZUZVZ0tQNytHV1dlWEEvUXhi?=
 =?utf-8?B?VXNPNFlqMVVOKzdNYmx4RkdtbkVDaEpqSUNRY29uU1Rjakh2WVZnbDh5MWh2?=
 =?utf-8?B?OUxYTmVlcGZieTI0MDVGekxuVTMya09HWGc3WDJkZmpKRms0NVI1REVVUSt0?=
 =?utf-8?B?VUxwSEJNemlvUWkzSUxLZEJLK0xObXdYVVVkdHpVVlg5MHRoN3FRNjQ4Qmwv?=
 =?utf-8?B?czRjeGViRDhnNG9SUkJUSCt3SUc3dmJsMGZwN2YrOVowODBjTmF1MlM1RmpC?=
 =?utf-8?B?dEtvdWVMOTVpRllhZDNDcSt4VTJSdHlUYnV3T2tOVmthSnJvalVNcENhYWl5?=
 =?utf-8?B?ajljRnNmVTVXQnRtN0x0ekMxTHFtcE9lL3h3Z0xKMkFOcmp1akYrUHlyZkM5?=
 =?utf-8?B?bGZQQWk3YWdjbUwrWi9sWnp4QlY1R3QxanBNN0dWSnlERjlUVkpjclRjSFZ0?=
 =?utf-8?B?UWN2WUhzejBPTmNUdklRdTNrOFVMemVra3hlVElKR0p5SHZHS2FYdVJPSDc4?=
 =?utf-8?B?T2pTVFZKaVVJKzZ1V2M1U2pZOHRDS2d0U09EKzZBV3pxaGpTWmZ6a0NzeVhi?=
 =?utf-8?B?L09PbVpBSW1OMHdmL09EbmxXMXAxc051VmtQTTlJRkNob3ZFbkg5R3FqL29t?=
 =?utf-8?B?SkdxV3BuQWpuSDJ5TXpHRkF2UmRqQzdFRFlHMUtxN0xHTENzcTZVQU1mdUYw?=
 =?utf-8?B?QkVzLzRIK2JQcFhQMEowc2JHaGdpeHZTaktNOWE2eDFEckd1OTF4VUw4NGxH?=
 =?utf-8?B?NjVMSDJqY3VuRXNJR1VDdDgwYUxEdzlZQ2hNbUIrQ3JMU3NBWDBLTDdES0tY?=
 =?utf-8?B?alkrMFBpVEV1UFJkWjBMZjBRcTBYZHZxYVZ5NGJLM040WURJS1hEYkppYWNF?=
 =?utf-8?B?NmoyQmI3aFJVNXNaOWR2MHZFa0wzdFoyQUNzU2xxOTRBc1lhNngwNkM2T3ZF?=
 =?utf-8?B?VytCWk5sWTZRVnZScVhDZmRxRnlZVWI1V3BQK2hWeTd0Y1p2SlEwaDdLRU9u?=
 =?utf-8?B?Vi9RVlFMU1NzMUt5TmpLZ3N4aTdDTXd3SFBTcEVsZjROZWNYYmZvQnh6VUNy?=
 =?utf-8?B?YzZrRFZxSjlyay9zUnJJT2Q2Zm5Wcm0yVDF0QmJ4bit5L1BzL1oyYTRHWTY3?=
 =?utf-8?B?cUVkZmhzQUxCUDFvOWlPUWdKSDNsZXlOZlhDOTZsS29jQ0VEOStvWjB2TTN3?=
 =?utf-8?B?VHpacHBrUGJaVFZmakN6MU81M0NaNEZPUk9HbXllN2RZcEJxK3R3ZzAvTUlW?=
 =?utf-8?B?eWpYOU1aVkVVOU52bHZsYzJkNWpKeXJFVU1TNTF2ZXRIcU1NZUNVZVZRUDI4?=
 =?utf-8?B?bHp3YTlvaHJReWVsM1lqWGJLNS9HZWh2ZDRJVnB3Qm8wRkhZWUxvV0g1ZEhK?=
 =?utf-8?B?WEt4WGNRMldOTzd4NFR3bjdpcFpZZGliQlI2WXBGUExBMng0VHJST245SkJm?=
 =?utf-8?B?VnkxdVRwRitBQkxnOVIzOXlyTGlLRjZpOXVIemg0eUtmUXBjUzNIUmFoMDQ3?=
 =?utf-8?B?OTNIWVp6blNoVUVuemZ1VEN0L3VTUUc0VktzUnU4bVlHMUFzcEJTbVdxNnEz?=
 =?utf-8?B?ZE9FZ2R3NS95Tm1nTlE4QmROVXdleUduM0NTUzhiVGIwYlpIKzJHWnc5QVRo?=
 =?utf-8?B?ZWtPZHhrbGdaYStPV1VjRTJLbExVOTBWT3M3WW00TE5PMFdFbEgrT2lpN3Vo?=
 =?utf-8?Q?ILul6fYRMRJpDmMfMcDdTHwWiHue+9P3?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR18MB5167.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(7053199007); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SWhRam9CZXFMb1k5OGlxN01EcWhkQ1BzNzBWMXMyRkMvVWdWNXdnM1ppRWVp?=
 =?utf-8?B?d0ZqS0ozZ1JBMDVvSk9kd2p4NWlMWE1NcldNYWlOVmJ0bkoyak1Rblgwd09p?=
 =?utf-8?B?MlZlN29KT3NiT0IyNXZCMlNXeWN1RjVPZ0hienVkTlN5WGJiRDhZRm1xTy81?=
 =?utf-8?B?Q3UrVXV3R0ZQb240Q0x4dkovSGtvZXZGMlZSZm83MVFFZm1GOVlRVHJaaUEz?=
 =?utf-8?B?N3R3WDlvVU8xYVQ5dDdPTmNEMDM1TFVoaUhhQStZV1NhSk9FdHBzcGtVQ1F6?=
 =?utf-8?B?cXBVT3l3bnlQU1JpdVI5clA5UFRFbG5uV1dxazZQMXRLRGhYY0Z0eWYvWlUz?=
 =?utf-8?B?UGZwZnFGVlFLWWxOajFMSzdWaUxGdVRwQ3NueGYvMWxFMmxRK3dsbDU3OW5G?=
 =?utf-8?B?TWlVYmN0OU5pYy9LZXVYSkdMeTlBMGdkUU5jYXBwUW03WW1YNFZUMTV3d1Mz?=
 =?utf-8?B?VHVia29GUjU1VkZEaXpIYWNvTUdxZHZWc1B1akdWdFZGSzFyU0lEa0J5dWJD?=
 =?utf-8?B?cGNmRFdCaTdrMXc3eFZFYXBJMFZpb0UzWEw2MXlZTEtOV0FnRTlPZmJXcEcr?=
 =?utf-8?B?T3d3ZXBUSzYyejJaN0E2MlFyMytVRTcrcnMyeDN4T1RKc1dBV09UOUJqeThR?=
 =?utf-8?B?Nkk3WUNZZmpTZ0Jqckk0Tm5wSk5XVVhITVlxYmZHcXROMXpxOGZnYktaZjVU?=
 =?utf-8?B?ek9oZS9aNWY0Nmt1clVQRnhNRkNYcHN4R29pVm00U3VXNVZTT1ZnNkdHYzcx?=
 =?utf-8?B?cU9Hdk8vY3lJbmlHMnQ1Uk8yeG1ZM2JaN0pFb0J0ZDNKZGdabFB1MkJxODVO?=
 =?utf-8?B?TlFRQmtCSnZVME40OTZQQXJZQVR2c0NCa0dyN3NERjdDVCsvNGczWVhSQzBm?=
 =?utf-8?B?YVR3THJ1VE5EcDM4THFwaTdMYTltNEdTeHN3eVVrSnJ6cTZ3MUZPd0V6blkr?=
 =?utf-8?B?bHp3cVZBdEZUc2VHRlBiTm5vdVRYNUloTnhMdlozYXZSb0p5ekplUDkwNVVZ?=
 =?utf-8?B?ZWsvaHlWWHFKdnRSQkFhbFFsS1dxNlV1eDdhRHNSQUM5YVFBOTBXamQ5YlF6?=
 =?utf-8?B?Y2VGaTBJRFZTZWViOG44UzEwbXBsYzZuY3I3b1pFVUZia1pMQ1g0UjJZUkRR?=
 =?utf-8?B?OGVPZWlFVHVLaTRXUXpzQU1PblJhYVBjaEN5MEtYTnRndy9oZGIyUlQxZDE4?=
 =?utf-8?B?clFyTWFLb1JORmlTUHNMdEc3dGpuUmhZY1JXcFZjMlRaMmhBU1hmenFWcVow?=
 =?utf-8?B?TmYwWTlxZnEydWpUSVhvbTlpRFRPbkJGakdlVUhSUno0Zlg3OTdYT0o2aVNr?=
 =?utf-8?B?WkJyVlE4YzhGVjFldUJLVDdoR3hLUUxyUURZRlBCcFZ0MXNCeWpFV2QrWUVF?=
 =?utf-8?B?VHF2MHlKb1l2ZUxWNnFxZGwrU1UxYTVxTWszS3N0SHdYWkpWMisvQU5EcVFC?=
 =?utf-8?B?bVN2Zm9RdVhQV1ltZjVqRWYxWHNQcWlsdU41SHdkNXF0djc4QWE0NGoxS2Nv?=
 =?utf-8?B?YmdTWjNtUjNOWG16STRKWnVjV3lFaTBtazhQUm5RQjJQcll1NXVDZEtVMlVt?=
 =?utf-8?B?QTV6SzNBTnZOZm9VRFVYUXdodlpERGVtY0o1bEdHbUc5NzJwaTZCWEZ2N05j?=
 =?utf-8?B?QVZIVUdzTC9sRXdSU0xoUVBibU40VTVyUHYwaGdGUzNmQ3F6bHRMYmllNjUz?=
 =?utf-8?B?anA3dXpTZ29CVmQ2cFJQNlpRZEh5UVJ2enZPY3d6RmU2OXBoM0Z1c0lVK3Nk?=
 =?utf-8?B?dHFqZjcrcHNTUVFtOGdYUWZRMno1Zm9kUlhzN3dLd1htcEFUcjhDSmx3aDVT?=
 =?utf-8?B?bTdoSUhIaWhHUi9FcVhtcnhxMW4xMFZoY1F6QURhbnhYV0ZRSytyNCtHc0lS?=
 =?utf-8?B?R0dlWE5obDMrSll4T1BkTFlLSzV6RFBiUWd2bngzMjdpNHhlSFhFWCtJWnhM?=
 =?utf-8?B?T2ZaZk9Gc3RxcERBRnZQK1hKQndNb3FWY0FkcXVOSHBKeGp4a2RwSENTbHhU?=
 =?utf-8?B?WUNwVFRncEtBbCtoa0dnL2IrVGVMYW92Y1h0U2lFQVNqcUE2Q0U4Q3lFQjkv?=
 =?utf-8?B?VktBZlFwN3NwQ3VqYzVJazVOelRiN25LK3IzNmp0NXdKZlhhSEJ3SHZ1WVR0?=
 =?utf-8?Q?5K/HoD3d6uCO2qozzcaYsV9ER?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR18MB5167.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 594db26f-2b23-4aab-e5d7-08dd55a02d82
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2025 13:27:40.2850 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y/v3iFMCWQtZPfmVdYSlq3eArBIg8Q63fe8D1gDcUudiruVHP+CV1b3YmBKZmNKj7EuvdPVqSKEE/F8ExNMMbw37nuNh148LgqomdIwQz1E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR18MB5804
X-Authority-Analysis: v=2.4 cv=BPRJrEQG c=1 sm=1 tr=0 ts=67bdc54f cx=c_pps
 a=GDxOUaUasxmcDRSC7gC2IA==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=T2h4t0Lz3GQA:10 a=-AAbraWEqlQA:10
 a=M5GUcnROAAAA:8 a=QyXUC8HyAAAA:8 a=jZVsG21pAAAA:8 a=8rWy6zfcAAAA:8
 a=n02bokGJAAAA:8 a=ryDdVIzpDwsqpYQOnq4A:9 a=QEXdDO2ut3YA:10
 a=OBjm3rFKGHvpk9ecZwUJ:22 a=3Sh2lD0sZASs_lUdrUhf:22 a=YjdVzJdQTyZRADMV7wFX:22
 a=rszdq1ld3peujIA30KyE:22
X-Proofpoint-GUID: 3pt4YWlp-zgdfNFMtEq7glGO2uAwD5G0
X-Proofpoint-ORIG-GUID: 3pt4YWlp-zgdfNFMtEq7glGO2uAwD5G0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-25_04,2025-02-25_03,2024-11-22_01
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUGF2YW4gTmlraGlsZXNo
IEJoYWdhdmF0dWxhIDxwYmhhZ2F2YXR1bGFAbWFydmVsbC5jb20+DQo+IFNlbnQ6IFR1ZXNkYXks
IEZlYnJ1YXJ5IDI1LCAyMDI1IDY6NDggUE0NCj4gVG86IEd1amphciwgQWJoaW5hbmRhbiBTIDxh
YmhpbmFuZGFuLmd1amphckBpbnRlbC5jb20+OyBTdGVwaGVuDQo+IEhlbW1pbmdlciA8c3RlcGhl
bkBuZXR3b3JrcGx1bWJlci5vcmc+OyBkZXZAZHBkay5vcmcNCj4gQ2M6IE1vcnRlbiBCcsO4cnVw
IDxtYkBzbWFydHNoYXJlc3lzdGVtcy5jb20+OyBSaWNoYXJkc29uLCBCcnVjZQ0KPiA8YnJ1Y2Uu
cmljaGFyZHNvbkBpbnRlbC5jb20+OyBKZXJpbiBKYWNvYiA8amVyaW5qQG1hcnZlbGwuY29tPjsg
QW1pdA0KPiBQcmFrYXNoIFNodWtsYSA8YW1pdHByYWthc2hzQG1hcnZlbGwuY29tPjsgTmFnYSBI
YXJpc2ggSywgUyBWDQo+IDxzLnYubmFnYS5oYXJpc2gua0BpbnRlbC5jb20+DQo+IFN1YmplY3Q6
IFJFOiBbUEFUQ0ggdjMgMDIvMTRdIGV2ZW50ZGV2OiByZW1vdmVyIHVubmVjZXNzYXJ5IGRlcmVm
IG9uDQo+IGZ1bmN0aW9uIHBvaW50ZXJzDQo+IA0KPiAgPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2Fn
ZS0tLS0tDQo+ID4gPiBGcm9tOiBTdGVwaGVuIEhlbW1pbmdlciA8c3RlcGhlbkBuZXR3b3JrcGx1
bWJlci5vcmc+DQo+ID4gPiBTZW50OiBUaHVyc2RheSwgRmVicnVhcnkgMjAsIDIwMjUgMTA6MjUg
UE0NCj4gPiA+IFRvOiBkZXZAZHBkay5vcmcNCj4gPiA+IENjOiBTdGVwaGVuIEhlbW1pbmdlciA8
c3RlcGhlbkBuZXR3b3JrcGx1bWJlci5vcmc+OyBNb3J0ZW4gQnLDuHJ1cA0KPiA+ID4gPG1iQHNt
YXJ0c2hhcmVzeXN0ZW1zLmNvbT47IFJpY2hhcmRzb24sIEJydWNlDQo+ID4gPiA8YnJ1Y2Uucmlj
aGFyZHNvbkBpbnRlbC5jb20+OyBHdWpqYXIsIEFiaGluYW5kYW4gUw0KPiA+ID4gPGFiaGluYW5k
YW4uZ3VqamFyQGludGVsLmNvbT47IEplcmluIEphY29iIDxqZXJpbmpAbWFydmVsbC5jb20+Ow0K
PiA+ID4gQW1pdCBQcmFrYXNoIFNodWtsYSA8YW1pdHByYWthc2hzQG1hcnZlbGwuY29tPjsgTmFn
YSBIYXJpc2ggSywgUyBWDQo+ID4gPiA8cy52Lm5hZ2EuaGFyaXNoLmtAaW50ZWwuY29tPg0KPiA+
ID4gU3ViamVjdDogW1BBVENIIHYzIDAyLzE0XSBldmVudGRldjogcmVtb3ZlciB1bm5lY2Vzc2Fy
eSBkZXJlZiBvbg0KPiA+IGZ1bmN0aW9uDQo+ID4gPiBwb2ludGVycw0KPiA+ID4NCj4gPiA+IFRo
ZSBleHByZXNzaW9uICpkZXZfZGV2X29wcy0+Zm9vIGFuZCBkZXYtPmRldl9vcHMtPmZvbyBhcmUN
Cj4gZXF1aXZhbGVudC4NCj4gPiA+IENsZWFudXAgdGhlIHJlc3VsdCBieSByZW1vdmluZyB1bm5l
ZWRlZCBwYXJlbnRoZXNpcyBhbmQgbWFrZSBsaW5lcw0KPiA+IGNvbXBhY3QuDQo+ID4gPg0KPiA+
ID4gU2lnbmVkLW9mZi1ieTogU3RlcGhlbiBIZW1taW5nZXIgPHN0ZXBoZW5AbmV0d29ya3BsdW1i
ZXIub3JnPg0KPiA+ID4gQWNrZWQtYnk6IE1vcnRlbiBCcsO4cnVwIDxtYkBzbWFydHNoYXJlc3lz
dGVtcy5jb20+DQo+ID4gPiBBY2tlZC1ieTogQnJ1Y2UgUmljaGFyZHNvbiA8YnJ1Y2UucmljaGFy
ZHNvbkBpbnRlbC5jb20+DQo+ID4NCj4gPiBBY2tlZC1ieTogYWJoaW5hbmRhbi5ndWpqYXJAaW50
ZWwuY29tDQo+ID4NCj4gDQo+IFBsZWFzZSBmaXggdGhlIHR5cG8gaW4gY29tbWl0IHRpdGxlIHMv
cmVtb3Zlci9yZW1vdmUvDQo+IA0KPiBXaXRoIHRoYXQNCj4gQWNrZWQtYnk6IFBhdmFuIE5pa2hp
bGVzaCA8cGJoYWdhdmF0dWxhQG1hcnZlbGwuY29tPg0KPiANCg0KQWNrZWQtYnk6IEFtaXQgUHJh
a2FzaCBTaHVrbGEgPGFtaXRwcmFrYXNoc0BtYXJ2ZWxsLmNvbT4NCg0KPiA+ID4gLS0tDQo+ID4g
PiAgbGliL2V2ZW50ZGV2L3J0ZV9ldmVudF9jcnlwdG9fYWRhcHRlci5jIHwgIDM3ICsrLS0tLQ0K
PiA+ID4gIGxpYi9ldmVudGRldi9ydGVfZXZlbnRfZG1hX2FkYXB0ZXIuYyAgICB8ICAxNiArLS0N
Cj4gPiA+ICBsaWIvZXZlbnRkZXYvcnRlX2V2ZW50X2V0aF9yeF9hZGFwdGVyLmMgfCAgNTAgKysr
Ky0tLS0NCj4gPiA+ICBsaWIvZXZlbnRkZXYvcnRlX2V2ZW50ZGV2LmMgICAgICAgICAgICAgfCAx
NjQgKysrKysrKysrKystLS0tLS0tLS0tLS0tDQo+ID4gPiAgNCBmaWxlcyBjaGFuZ2VkLCAxMTkg
aW5zZXJ0aW9ucygrKSwgMTQ4IGRlbGV0aW9ucygtKQ0KPiA+ID4NCg0KPHNuaXA+DQo=
