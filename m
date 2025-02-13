Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 007CFC02198
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Feb 2025 03:09:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C57D742D55;
	Thu, 13 Feb 2025 04:09:57 +0100 (CET)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2047.outbound.protection.outlook.com [40.107.236.47])
 by mails.dpdk.org (Postfix) with ESMTP id 8AA914111C
 for <dev@dpdk.org>; Thu, 13 Feb 2025 04:09:55 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CxjGf23S4KSF3LUsGoOy/oiR/qJov3D4W8X6kDjwyDA82U/PU4TIU/lD09pOVbll4fdo6qM6X7DmuheZ3ulH7sXvHKivSjGXlDtfgfaGbdP/vJKq3LoScf2C8XQ8kymJJey6+7Y2x2UJksgt5ClK2T/onci23A/OXELIEYpLQ+LUhpHM3FsgFfJ2uqhJSZ2x/SFWg1Umx5TgnC4ZG+f+lJiFWodne8KiPmK3EWmLlIS/h416EYiX0ywx8LTlWyNzXfxmLaCAri0ClXhndAxtlGfTViLyaBN7wfoxdULVNPNNSvesvXE6X9LOLSI3aq+IE3gZv8VuKuzPPBA7vo/yEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZWX8sf+RVyPBug4PGOyO8sEiIL07VC8HmuOdnQM4gbw=;
 b=ujqDLHJMHfvyfywQQguOATe0VZmL0p4c4YWQ0DwJ8fRcE7Ch8iuQgSn3ffvQBPB3ttFWQITyk27/3K6SVjOf8TyQCGcL2xm4FNXZ9EumWr1OHVmIHn9E5/ZSoqVpu5M8ax2HH2kur1j4ubNWvzurvPlFxHfixLFts65NmqqLykAxeq9bhDrkl+fUT5fm1wlVA1xJgUU3z+LcIqO0JQb/S/4LyyFf+Wa9iS2ShsJThtLdnGDj5tds24DaxS1rvKksYZTO3OmG5/GElClRwLpGuD9pboA2kaqz9OUdFB8YXdj0HgzBIlQ3KBGBVAvUW4+qDdR7sRBvL2K0osajh2UiSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZWX8sf+RVyPBug4PGOyO8sEiIL07VC8HmuOdnQM4gbw=;
 b=46mnyHj9RQid01KAriuvwtGFDTI3TdheyrlRwHGZv+7z7St8S4gOnI75N4aUlQtEhJNWxVtQ9R9tse4vXdtmmRxaPdlVmKnvdVZpEbhebx3Bh2iEBaz9fxQtlRYvrncagQAvULgyOi0X6o3Qi427h0ULcoFLaDppKER/goMIrGw=
Received: from PH7PR12MB8596.namprd12.prod.outlook.com (2603:10b6:510:1b7::6)
 by PH0PR12MB5629.namprd12.prod.outlook.com (2603:10b6:510:141::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Thu, 13 Feb
 2025 03:09:47 +0000
Received: from PH7PR12MB8596.namprd12.prod.outlook.com
 ([fe80::a011:943d:7291:8069]) by PH7PR12MB8596.namprd12.prod.outlook.com
 ([fe80::a011:943d:7291:8069%5]) with mapi id 15.20.8445.008; Thu, 13 Feb 2025
 03:09:47 +0000
From: "Varghese, Vipin" <Vipin.Varghese@amd.com>
To: "Varghese, Vipin" <Vipin.Varghese@amd.com>, "dev@dpdk.org" <dev@dpdk.org>, 
 "roretzla@linux.microsoft.com" <roretzla@linux.microsoft.com>,
 "bruce.richardson@intel.com" <bruce.richardson@intel.com>,
 "john.mcnamara@intel.com" <john.mcnamara@intel.com>,
 "dmitry.kozliuk@gmail.com" <dmitry.kozliuk@gmail.com>, Thomas Monjalon
 <thomas@monjalon.net>, "Ajit Khaparde (ajit.khaparde@broadcom.com)"
 <ajit.khaparde@broadcom.com>, "Song, Keesang" <Keesang.Song@amd.com>
CC: "pbhagavatula@marvell.com" <pbhagavatula@marvell.com>,
 "jerinj@marvell.com" <jerinj@marvell.com>, "ruifeng.wang@arm.com"
 <ruifeng.wang@arm.com>, "mattias.ronnblom@ericsson.com"
 <mattias.ronnblom@ericsson.com>, "anatoly.burakov@intel.com"
 <anatoly.burakov@intel.com>, "stephen@networkplumber.org"
 <stephen@networkplumber.org>, "Yigit, Ferruh" <Ferruh.Yigit@amd.com>,
 "honnappa.nagarahalli@arm.com" <honnappa.nagarahalli@arm.com>,
 "wathsala.vithanage@arm.com" <wathsala.vithanage@arm.com>,
 "konstantin.ananyev@huawei.com" <konstantin.ananyev@huawei.com>,
 "mb@smartsharesystems.com" <mb@smartsharesystems.com>
Subject: RE: [PATCH v4 0/4] Introduce Topology NUMA grouping for lcores
Thread-Topic: [PATCH v4 0/4] Introduce Topology NUMA grouping for lcores
Thread-Index: AQHbL22WzCqF9Lj5SUqurJMDjBRIs7NFKZjQ
Date: Thu, 13 Feb 2025 03:09:47 +0000
Message-ID: <PH7PR12MB85960CB35BB467CEBBC2CA2F82FF2@PH7PR12MB8596.namprd12.prod.outlook.com>
References: <20241105102849.1947-1-vipin.varghese@amd.com>
In-Reply-To: <20241105102849.1947-1-vipin.varghese@amd.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=fb7a7ed7-b7a1-4825-80be-b45df6564a4d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-02-13T03:06:07Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8596:EE_|PH0PR12MB5629:EE_
x-ms-office365-filtering-correlation-id: ade89d15-17e6-4621-457e-08dd4bdbdf72
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|366016|921020|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?UGpJUFdVQW9lSE9pSDdRekNCd2Z0Y2kwZzdnaVJTZHNWbmU3ZHpBbUtJQzdY?=
 =?utf-8?B?c2o3OXRHQlUyc2Y0dEN4aE0wVEMxcTlrUXVuRTQ4LzNudjdzb21WVXE1S3Na?=
 =?utf-8?B?QXhPYjh6OEVOVHkzd1lwV0VvZ2tzRjJ4d1RlZjd5Nkxjb2lCU0xpTlRyd2ZD?=
 =?utf-8?B?aCtBZ1ZiRFNYc0xFS3p3bWhxK3pGV0NvOUl6V1VhUG9SMmdPWkJPc1NmTzYx?=
 =?utf-8?B?SU1jNUkrYUxhc2t4MmZmK3hkc1hHdEhhMHREZVorTk14RExFSFdZRjd2Wmo2?=
 =?utf-8?B?QWp1QXA3bERtUTdoWUlzWGFvYWNQNkJVUy9ReG84RnhQYWNCc0F2eEN6MElD?=
 =?utf-8?B?cWoxSkIrcWM3SHU2UHA4NEJWV0lacDViYXhGZ0U3TWRpSk1wOFZCNHp2SjhK?=
 =?utf-8?B?R1pyQnJPVEU2azJZYzBNcEdCY1NUbzgyNFpoemlaWFNyUFdyYWJGT1JXU3JE?=
 =?utf-8?B?MUJZQ1paUVBBb1RScTZiczI0UkVzZHdzZUFRQ01TY3NrRGZQNHd3MWtQSGFh?=
 =?utf-8?B?VDAxc3JJYXJXYm9HTWtrSmlyeVNsTnBCellYL3dpdlgza1p3ekZlSVNyTjh6?=
 =?utf-8?B?S0xnWkIzV1JuQkVoQ0t6c1kxL3pRdTF2MENKOWNZeGN6UTBBR2s1Ty91Mk42?=
 =?utf-8?B?NXNDL2hxUVZ5MDRPUzJEVElGdXM4WEN3NDdtNDRmdVFOY1VMUUUzblRCYWFm?=
 =?utf-8?B?T05oT0NBMWF5bkdCOTdsNUxvSDdURU5aTjNHdEdRT09qSGFrZDBpekNZU3hG?=
 =?utf-8?B?TzJPVW9oWTI0NUNKNmplcmhyTnJZRWs2TjRJZStKNlE0Wmd6eGFiU0MwVFhQ?=
 =?utf-8?B?d0FDdzNGR1YwZklEckJuY042QllIcDhMNldIWjk4M0hGY2dJa2lMK0UyM25J?=
 =?utf-8?B?am1iS1pyK3NHcWp5d3IyTEtNVTJzUVJGZmYyL0pXRG91UWFKRG8wVHVFdG1r?=
 =?utf-8?B?UlN4ZzRHblJuSTdsVHZkT3VjTm9YM25KOHZUMWx0SEZKY0ZxWmVqa3ZFRkZl?=
 =?utf-8?B?M1MvMVhpdEVwc21oWDY5UWhOd29pdDVKMTVwYkRYN3lTVm1qOHl5TGQ0eGoy?=
 =?utf-8?B?d0g4ZTl2YzVKeS9pbjZiNHFDSjlBTEczaDJSK05EdW1jaU5TYkJQdzBTYWUr?=
 =?utf-8?B?VWRxcGZDbkRmTVlvQ0M1dWRoQ0ozeXozbDVLcTZzTER2V2F5QjYreWpQaUY0?=
 =?utf-8?B?N0t0eWd0NDVvbDZIQWpZc2FVWUQzb3hhNDJtUDdMQ05GUW44K2JSMHFGbzQ2?=
 =?utf-8?B?cnVZSlJWdHhBQWN2aFE2Y21nNXlLSWZBUU5sbGE2SzRWcTh5NldPenczbzY5?=
 =?utf-8?B?RDF1bTM4bFBXWElSQmV2T05RcG5PL2RKSmtQYmMwcVZQNTM4UWRWRHFVTXNX?=
 =?utf-8?B?QmtVeGJyT29qcTFBTzdVaVJ2cFVzcVQyMzIyaXZEeU1WWHZObjgvbExrYTRM?=
 =?utf-8?B?eHpGaGRUQzVHcGM4RWhkNWRmazdGanozNW1STUJnSTJtR0ZibHQ3V1pJN0h3?=
 =?utf-8?B?OXAxVElwVExrenExQ2VjS0tzbnRSend2RXQ1Y0I5aGF6akJmUXp3ZG50SmI3?=
 =?utf-8?B?cGh4VGZ0Z1RLSEY1ckZoOHUwMXBONTFpYlg2cFVUcUo4Nm96U1RNbE1GTTcr?=
 =?utf-8?B?a2tncVc2Z1dXOVVJdHpuU1lPdlp1VThCdnNOTndZblFBZE50UmE3SGNNWXVD?=
 =?utf-8?B?dGZDc202bzJMWnhlZ2NjRkg3UmZEL3BOa3hXK3FEemVYQmZ2em5NdThTWWp3?=
 =?utf-8?B?NlM1alRyUGM5UjRKR2pSd3dhREFVaXF6VFhXUTdGYjlpUXlJc3FoTDVjUzVv?=
 =?utf-8?B?dDYreFhzczVYWWxMSngrSWJsVFdIbXQvNXQxQXVHbXBzVE1pZnMxaXFsakRL?=
 =?utf-8?B?bmJJUlRqbFNYdHNjVkoyVSszZUZ2Y29kLzF1cC9aNWs2MmhQN1l5NlRMeS84?=
 =?utf-8?B?SURtcVZkNmdyaHBKaGtJMTFDbWZ0YkMweVpWQ2dSTWNwSDVzVHRwbjdHeDJy?=
 =?utf-8?B?QVd2aTJRRnF3PT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8596.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016)(921020)(7053199007)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aWxYU0pQK1ExZi9oYVVyakh2YndkeXJVbzdaV3BnQ25SMUk4cEh2d21LbzRX?=
 =?utf-8?B?RWR2cG8xeWIya243YjNwMGhOSWZ3dThiVHI2YUd6U1N5MzlXbW8wb09zZE5V?=
 =?utf-8?B?Z3BHOFlZSUluaW0zTS9UdWtjSnBOYTAzYlJrTVd4aUc1UGM2SkdYcDdHalFB?=
 =?utf-8?B?YTJxRElkMDlYREprZ1MrRktraXI2QzhCMVRhWnM4SUh5cGRkL04zUWZ2bVNL?=
 =?utf-8?B?L1lQTWZEUUh1aG45N1dZK1JST2Z1N3NYNjVVSmhHaHdPWTNWWnRXakdqelJs?=
 =?utf-8?B?em9VWUpxSS9MUzU5WUpQaHJMaFNKS2JyeWl1bjc0Z0lPVEFpOThyV0JSMzkv?=
 =?utf-8?B?ZGVaQThHYmE1V1RzLy9vanFDdjE3ZEZTc0hxUHBEMkcrZ3UweWNJcFcxeVFK?=
 =?utf-8?B?b1RtWFVFTEF4cjlsRUZzR1FuR0UvRUdxQ0lHVUNSZFlaRno3NlROdklNYXhI?=
 =?utf-8?B?bFM4OENxUnEyNmFwL1YxVmxIcDIzRUUySjN6QUhpZzUrVC9IWEc1MWdndjRL?=
 =?utf-8?B?Y0t4bGdhem1MNXFBVFBpS3o2RnZQdW1NcVJtUjlmY2k1N0tlNUpxNkRRa0l5?=
 =?utf-8?B?TjMxRjRUQXFGcGlwOXY5S2ZJVzZiZzJkcnZiYXkyMkhOWDBSM1lpaW52SjN1?=
 =?utf-8?B?ODhDSmt6a0RzcmNKYWdPV2VKN0ZyaFNTSU5ya3ZEOC9qbEZocEpPUks0NUNp?=
 =?utf-8?B?bVA0RFlYZmFpUktrdU5LR1F4ek5qNjAyT2lzSnN4a2NaLzhmMTFUczdQOFpB?=
 =?utf-8?B?SVV3T0FlVVFCQldZRGMxS0g4NGxmbFFTZS9YcEJJbVR6Ym92LzllY1NxTHhY?=
 =?utf-8?B?SkRqV1o3aTBBbkF3TnNUY2hnV2VHY2paLyt6dzZnR2Y3M2ZEVGRoTklMQ3VB?=
 =?utf-8?B?ZVplc1V2K2pNUXZ3SHRsRzRXYUlYRU96UTF4WnpVdytSajJIeDI3ZzgzVUpT?=
 =?utf-8?B?NVlRK0pOdFVyMTBHZWJOYUI2QkhKV1dvNHVyS1piWnllcXB1dVN5K1h1aEZU?=
 =?utf-8?B?cnBqc0k2VS9kZlpBMGZoanF1aWpzVG1CbGViVjhUSFQydEFhSklJNnI1UG5y?=
 =?utf-8?B?Um1zY1lmMy8xSjF4SVBIYkJQTWJVR2lvdS9HVnVwR0N5NmViSVVsNHk5ZTRM?=
 =?utf-8?B?WkFWY2FkQ0s3MmtsbHlKOTNReTNuQzZVbHpPRHhlb3p4bXh1clJuNjdYUFUv?=
 =?utf-8?B?c09NWk50RVBXYnJHTkhtaHZVcFFGVjhjYnBpeUdmdFRROFYzUUlyQU9jWnVF?=
 =?utf-8?B?RGFsTTRnZHk1UmliTVI1VThSRWFPalcvc3d2S3VGLzF2U1B3em42RDN3a3l3?=
 =?utf-8?B?enRpczdRR2xJN2VzdDIvQUJtdnBVcG5Oa0tDYnlUbnJhUlpwdG5FemczUFNn?=
 =?utf-8?B?aWZlMEdGVHAvRU5DOE92ZEpyeVR4VjZIemo5SHdWMzBtN21BbytRcWF0MkVt?=
 =?utf-8?B?Vy9UN3VvRkhuRklwZ3JENjBaOTlWcWNlNGQzYnBCNkFDWUJYQXpoSTZhN3VN?=
 =?utf-8?B?S3loS0Y3OVpuMkJBQzdSWTRENTVCdlNKUjB0MW96cVYrWmNOeGkxUDdRUGZo?=
 =?utf-8?B?NysvakxkVnFSVW03L0tod2ZaSG4yWU5UKyt3djhrd2w5bm4zU2Z5ZDZZalpx?=
 =?utf-8?B?b0NkSE5mdlZlWlNYTkxIVlhQc0piOFVHUHR3MTUyN3pZQ1JoVVFGY1NtdVR0?=
 =?utf-8?B?cnRPVXJXZ3dIQjNGbjRaSUFTdDVkbDRzTUdnSXB5SE9KSnVaNXE2SXMrM3oy?=
 =?utf-8?B?R04rMWZ1Nm8yaDJRaXF3dFFsVlV6Mjl6YmJpb2lRV3hjVXJ6QitTY3VxajlK?=
 =?utf-8?B?ekdSTytDK3NJZnJCNHdMd3VIdzdZUmgrMGk4SHFndXp1SmJpL3FYWUtwalh2?=
 =?utf-8?B?TXZsK2hiUEEvMzVqNmJydWJZVU1OckozeXBOendHRHU4SEdicnA0STdZMXJi?=
 =?utf-8?B?L1pFelBjS2ZHK0c2VDdhOC9uYkRjUVZmNHUwOE9mc3NYcVBGc3NnU2hQN3U2?=
 =?utf-8?B?RmFGSlBCTjVhR3NlVWtNNHBLc3ZHZWFKUWFhcThlOUVzNGtwV2FEb3pNOTZi?=
 =?utf-8?B?ZjZjL1cvT2plYVlTNHBSUlErSnRyRHhqMUMzcnNRVGZOVmF6QnJGVlN1ZzFs?=
 =?utf-8?Q?QSToO2/blR9YYM+p7s44+D4M6?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8596.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ade89d15-17e6-4621-457e-08dd4bdbdf72
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2025 03:09:47.4333 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vtfWnOnqYC3P9RSAQF4ML+7B7p8/As+BuFyy8kX7HgqFtRbTSqxBDbPV9HK4jlt3H8ikeAhgJ6cHQHB95wh8IQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5629
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KQWRkaW5nIFRob21hcyBhbmQgQWppdCB0byB0aGUgbG9vcC4NCg0KSGkgQWppdCwgd2UgaGF2
ZSBiZWVuIHVzaW5nIHRoZSBwYXRjaCBzZXJpZXMgZm9yIGlkZW50aWZ5aW5nIHRoZSB0b3BvbG9n
eSBhbmQgZ2V0dGluZyBsMyBjYWNoZSBpZCBmb3IgcG9wdWxhdGluZyB0aGUgc3RlZXJpbmcgdGFn
IGZvciBEZXZpY2UgU3BlY2lmaWMgTW9kZWwgJiBNU0kteCBkcml2ZW4gYWYteGRwIGZvciB0aGUg
ZXhwZXJpbWVudGFsIFNUQUcgZmlybXdhcmUgb24gVGhvci4NCg0KSGVuY2UgY3VycmVudCB1c2Ug
b2YgdG9wb2xvZ3kgbGlicmFyeSBoZWxwcyBpbg0KMS4gd29ya2xvYWQgcGxhY2VtZW50IGluIHNh
bWUgQ2FjaGUgb3IgSU8gZG9tYWluDQoyLiBwb3B1bGF0aW5nIGlkIGZvciBNU0l4IG9yIERldmlj
ZSBzcGVjaWZpYyBtb2RlbCBmb3Igc3RlZXJpbmcgdGFncy4NCg0KVGhvbWFzIGFuZCBBaml0aCBj
YW4gd2UgZ2V0IHNvbWUgaGVscCB0byBnZXQgdGhpcyBtYWlubGluZSB0b28/DQoNCg0KDQo+IC0t
LS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFZpcGluIFZhcmdoZXNlIDx2aXBpbi52
YXJnaGVzZUBhbWQuY29tPg0KPiBTZW50OiBUdWVzZGF5LCBOb3ZlbWJlciA1LCAyMDI0IDM6NTkg
UE0NCj4gVG86IGRldkBkcGRrLm9yZzsgcm9yZXR6bGFAbGludXgubWljcm9zb2Z0LmNvbTsgYnJ1
Y2UucmljaGFyZHNvbkBpbnRlbC5jb207DQo+IGpvaG4ubWNuYW1hcmFAaW50ZWwuY29tOyBkbWl0
cnkua296bGl1a0BnbWFpbC5jb20NCj4gQ2M6IHBiaGFnYXZhdHVsYUBtYXJ2ZWxsLmNvbTsgamVy
aW5qQG1hcnZlbGwuY29tOyBydWlmZW5nLndhbmdAYXJtLmNvbTsNCj4gbWF0dGlhcy5yb25uYmxv
bUBlcmljc3Nvbi5jb207IGFuYXRvbHkuYnVyYWtvdkBpbnRlbC5jb207DQo+IHN0ZXBoZW5AbmV0
d29ya3BsdW1iZXIub3JnOyBZaWdpdCwgRmVycnVoIDxGZXJydWguWWlnaXRAYW1kLmNvbT47DQo+
IGhvbm5hcHBhLm5hZ2FyYWhhbGxpQGFybS5jb207IHdhdGhzYWxhLnZpdGhhbmFnZUBhcm0uY29t
Ow0KPiBrb25zdGFudGluLmFuYW55ZXZAaHVhd2VpLmNvbTsgbWJAc21hcnRzaGFyZXN5c3RlbXMu
Y29tDQo+IFN1YmplY3Q6IFtQQVRDSCB2NCAwLzRdIEludHJvZHVjZSBUb3BvbG9neSBOVU1BIGdy
b3VwaW5nIGZvciBsY29yZXMNCj4NCj4gQ2F1dGlvbjogVGhpcyBtZXNzYWdlIG9yaWdpbmF0ZWQg
ZnJvbSBhbiBFeHRlcm5hbCBTb3VyY2UuIFVzZSBwcm9wZXIgY2F1dGlvbg0KPiB3aGVuIG9wZW5p
bmcgYXR0YWNobWVudHMsIGNsaWNraW5nIGxpbmtzLCBvciByZXNwb25kaW5nLg0KPg0KPg0KPiBU
aGlzIHBhdGNoIGludHJvZHVjZXMgaW1wcm92ZW1lbnRzIGZvciBOVU1BIHRvcG9sb2d5IGF3YXJl
bmVzcyBpbiByZWxhdGlvbiB0bw0KPiBEUERLIGxvZ2ljYWwgY29yZXMuIFRoZSBnb2FsIGlzIHRv
IGV4cG9zZSBBUEkgd2hpY2ggYWxsb3dzIHVzZXJzIHRvIHNlbGVjdCBvcHRpbWFsDQo+IGxvZ2lj
YWwgY29yZXMgZm9yIGFueSBhcHBsaWNhdGlvbi4gVGhlc2UgbG9naWNhbCBjb3JlcyBjYW4gYmUg
c2VsZWN0ZWQgZnJvbSB2YXJpb3VzDQo+IE5VTUEgZG9tYWlucyBsaWtlIENQVSBhbmQgSS9PLg0K
Pg0KPiBDaGFuZ2UgU3VtbWFyeToNCj4gIC0gSW50cm9kdWNlcyB0aGUgY29uY2VwdCBvZiBOVU1B
IGRvbWFpbiBwYXJ0aXRpb25pbmcgYmFzZWQgb24gQ1BVIGFuZA0KPiAgICBJL08gdG9wb2xvZ3ku
DQo+ICAtIEFkZHMgc3VwcG9ydCBmb3IgZ3JvdXBpbmcgRFBESyBsb2dpY2FsIGNvcmVzIHdpdGhp
biB0aGUgc2FtZSBDYWNoZQ0KPiAgICBhbmQgSS9PIGRvbWFpbiBmb3IgaW1wcm92ZWQgbG9jYWxp
dHkuDQo+ICAtIEltcGxlbWVudHMgdG9wb2xvZ3kgZGV0ZWN0aW9uIGFuZCBjb3JlIGdyb3VwaW5n
IGxvZ2ljIHRoYXQNCj4gICAgZGlzdGluZ3Vpc2hlcyBiZXR3ZWVuIHRoZSBmb2xsb3dpbmcgTlVN
QSBjb25maWd1cmF0aW9uczoNCj4gICAgICogQ1BVIHRvcG9sb2d5ICYgSS9PIHRvcG9sb2d5IChl
LmcuLCBBTUQgU29DIEVQWUMsIEludGVsIFhlb24gU1BSKQ0KPiAgICAgKiBDUFUrSS9PIHRvcG9s
b2d5IChlLmcuLCBBbXBlcmUgT25lIHdpdGggU0xDLCBJbnRlbCBYZW9uIFNQUiB3aXRoIFNOQykN
Cj4gIC0gRW5oYW5jZXMgcGVyZm9ybWFuY2UgYnkgbWluaW1pemluZyBsY29yZSBkaXNwZXJzaW9u
IGFjcm9zcyB0aWxlc3xjb21wdXRlDQo+ICAgIHBhY2thZ2Ugd2l0aCBkaWZmZXJlbnQgTDIvTDMg
Y2FjaGUgb3IgSU8gZG9tYWlucy4NCj4NCj4gUmVhc29uOg0KPiAgLSBBcHBsaWNhdGlvbnMgdXNp
bmcgRFBESyBsaWJyYXJpZXMgcmVsaWVzIG9uIGNvbnNpc3RlbnQgbWVtb3J5IGFjY2Vzcy4NCj4g
IC0gTGNvcmVzIGJlaW5nIGNsb3NlciB0byBzYW1lIE5VTUEgZG9tYWluIGFzIElPLg0KPiAgLSBM
Y29yZXMgc2hhcmluZyBzYW1lIGNhY2hlLg0KPg0KPiBMYXRlbmN5IGlzIG1pbmltaXplZCBieSB1
c2luZyBsY29yZXMgdGhhdCBzaGFyZSB0aGUgc2FtZSBOVU1BIHRvcG9sb2d5Lg0KPiBNZW1vcnkg
YWNjZXNzIGlzIG9wdGltaXplZCBieSB1dGlsaXppbmcgY29yZXMgd2l0aGluIHRoZSBzYW1lIE5V
TUEgZG9tYWluIG9yDQo+IHRpbGUuIENhY2hlIGNvaGVyZW5jZSBpcyBwcmVzZXJ2ZWQgd2l0aGlu
IHRoZSBzYW1lIHNoYXJlZCBjYWNoZSBkb21haW4sIHJlZHVjaW5nDQo+IHRoZSByZW1vdGUgYWNj
ZXNzIGZyb20gdGlsZXxjb21wdXRlIHBhY2thZ2UgdmlhIHNub29waW5nIChsb2NhbCBoaXQgaW4g
ZWl0aGVyIEwyIG9yDQo+IEwzIHdpdGhpbiBzYW1lIE5VTUEgZG9tYWluKS4NCj4NCj4gTGlicmFy
eSBkZXBlbmRlbmN5OiBod2xvYw0KPg0KPiBUb3BvbG9neSBGbGFnczoNCj4gLS0tLS0tLS0tLS0t
LS0tDQo+ICAtIFJURV9MQ09SRV9ET01BSU5fTDE6IHRvIGdyb3VwIGNvcmVzIHNoYXJpbmcgc2Ft
ZSBMMSBjYWNoZQ0KPiAgLSBSVEVfTENPUkVfRE9NQUlOX1NNVDogc2FtZSBhcyBSVEVfTENPUkVf
RE9NQUlOX0wxDQo+ICAtIFJURV9MQ09SRV9ET01BSU5fTDI6IGdyb3VwIGNvcmVzIHNoYXJpbmcg
c2FtZSBMMiBjYWNoZQ0KPiAgLSBSVEVfTENPUkVfRE9NQUlOX0wzOiBncm91cCBjb3JlcyBzaGFy
aW5nIHNhbWUgTDMgY2FjaGUNCj4gIC0gUlRFX0xDT1JFX0RPTUFJTl9MNDogZ3JvdXAgY29yZXMg
c2hhcmluZyBzYW1lIEw0IGNhY2hlDQo+ICAtIFJURV9MQ09SRV9ET01BSU5fSU86IGdyb3VwIGNv
cmVzIHNoYXJpbmcgc2FtZSBJTw0KPg0KPiA8IEZ1bmN0aW9uOiBQdXJwb3NlID4NCj4gLS0tLS0t
LS0tLS0tLS0tLS0tLS0tDQo+ICAtIHJ0ZV9nZXRfZG9tYWluX2NvdW50OiBnZXQgZG9tYWluIGNv
dW50IGJhc2VkIG9uIFRvcG9sb2d5IEZsYWcNCj4gIC0gcnRlX2xjb3JlX2NvdW50X2Zyb21fZG9t
YWluOiBnZXQgdmFsaWQgbGNvcmVzIGNvdW50IHVuZGVyIGVhY2ggZG9tYWluDQo+ICAtIHJ0ZV9n
ZXRfbGNvcmVfaW5fZG9tYWluOiB2YWxpZCBsY29yZSBpZCBiYXNlZCBvbiBpbmRleA0KPiAgLSBy
dGVfbGNvcmVfY3B1c2V0X2luX2RvbWFpbjogcmV0dXJuIHZhbGlkIGNwdXNldCBiYXNlZCBvbiBp
bmRleA0KPiAgLSBydGVfbGNvcmVfaXNfbWFpbl9pbl9kb21haW46IHJldHVybiB0cnVlfGZhbHNl
IGlmIG1haW4gbGNvcmUgaXMgcHJlc2VudA0KPiAgLSBydGVfZ2V0X25leHRfbGNvcmVfZnJvbV9k
b21haW46IG5leHQgdmFsaWQgbGNvcmUgd2l0aGluIGRvbWFpbg0KPiAgLSBydGVfZ2V0X25leHRf
bGNvcmVfZnJvbV9uZXh0X2RvbWFpbjogbmV4dCB2YWxpZCBsY29yZSBmcm9tIG5leHQgZG9tYWlu
DQo+DQo+IE5vdGU6DQo+ICAxLiBUb3BvbG9neSBpcyBOVU1BIGdyb3VwaW5nLg0KPiAgMi4gRG9t
YWluIGlzIHZhcmlvdXMgc3ViLWdyb3VwcyB3aXRoaW4gYSBzcGVjaWZpYyBUb3BvbG9neS4NCj4N
Cj4gVG9wb2xvZ3kgZXhhbXBsZTogTDEsIEwyLCBMMywgTDQsIElPDQo+IERvbWlhbiBleGFtcGxl
OiBJTy1BLCBJTy1CDQo+DQo+IDwgTUFDUk86IFB1cnBvc2UgPg0KPiAtLS0tLS0tLS0tLS0tLS0t
LS0NCj4gIC0gUlRFX0xDT1JFX0ZPUkVBQ0hfRE9NQUlOOiBpdGVyYXRlIGxjb3JlcyBmcm9tIGFs
bCBkb21haW5zDQo+ICAtIFJURV9MQ09SRV9GT1JFQUNIX1dPUktFUl9ET01BSU46IGl0ZXJhdGUg
d29ya2VyIGxjb3JlcyBmcm9tIGFsbA0KPiBkb21haW5zDQo+ICAtIFJURV9MQ09SRV9GT1JOX05F
WFRfRE9NQUlOOiBpdGVyYXRlIGRvbWFpbiBzZWxlY3Qgbid0aCBsY29yZQ0KPiAgLSBSVEVfTENP
UkVfRk9STl9XT1JLRVJfTkVYVF9ET01BSU46IGl0ZXJhdGUgZG9tYWluIGZvciB3b3JrZXIgbid0
aA0KPiBsY29yZS4NCj4NCj4gRnV0dXJlIHdvcmsgKGFmdGVyIG1lcmdlKToNCj4gLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0NCj4gIC0gZG1hLXBlcmYgcGVyIElPIE5VTUENCj4gIC0gZXZlbnRk
ZXYgcGVyIEwzIE5VTUENCj4gIC0gcGlwZWxpbmUgcGVyIFNNVHxMMyBOVU1BDQo+ICAtIGRpc3Ry
aWJ1dG9yIHBlciBMMyBmb3IgUG9ydC1RdWV1ZQ0KPiAgLSBsMmZ3ZC1wb3dlciBwZXIgU01UDQo+
ICAtIHRlc3RwbWQgb3B0aW9uIGZvciBJTyBOVU1BIHBlciBwb3J0DQo+DQo+IFBsYXRmb3JtIHRl
c3RlZCBvbjoNCj4gLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiAgLSBJTlRFTChSKSBYRU9OKFIpIFBM
QVRJTlVNIDg1NjJZKyAoc3VwcG9ydCBJTyBudW1hIDEgJiAyKQ0KPiAgLSBBTUQgRVBZQyA4NTM0
UCAoc3VwcG9ydHMgSU8gbnVtYSAxICYgMikNCj4gIC0gQU1EIEVQWUMgOTU1NCAoc3VwcG9ydHMg
SU8gbnVtYSAxLCAyLCA0KQ0KPg0KPiBMb2dzOg0KPiAtLS0tLQ0KPiAxLiBJTlRFTChSKSBYRU9O
KFIpIFBMQVRJTlVNIDg1NjJZKzoNCj4gIC0gU05DPTENCj4gICAgICAgICBEb21haW4gKElPKTog
YXQgaW5kZXggKDApIHRoZXJlIGFyZSA0OCBjb3JlLCB3aXRoICgwKSBhdCBpbmRleCAwDQo+ICAt
IFNOQz0yDQo+ICAgICAgICAgRG9tYWluIChJTyk6IGF0IGluZGV4ICgwKSB0aGVyZSBhcmUgMjQg
Y29yZSwgd2l0aCAoMCkgYXQgaW5kZXggMA0KPiAgICAgICAgIERvbWFpbiAoSU8pOiBhdCBpbmRl
eCAoMSkgdGhlcmUgYXJlIDI0IGNvcmUsIHdpdGggKDEyKSBhdCBpbmRleCAwDQo+DQo+IDIuIEFN
RCBFUFlDIDg1MzRQOg0KPiAgLSBOUFM9MToNCj4gICAgICAgICBEb21haW4gKElPKTogYXQgaW5k
ZXggKDApIHRoZXJlIGFyZSAxMjggY29yZSwgd2l0aCAoMCkgYXQgaW5kZXggMA0KPiAgLSBOUFM9
MjoNCj4gICAgICAgICBEb21haW4gKElPKTogYXQgaW5kZXggKDApIHRoZXJlIGFyZSA2NCBjb3Jl
LCB3aXRoICgwKSBhdCBpbmRleCAwDQo+ICAgICAgICAgRG9tYWluIChJTyk6IGF0IGluZGV4ICgx
KSB0aGVyZSBhcmUgNjQgY29yZSwgd2l0aCAoMzIpIGF0IGluZGV4IDANCj4NCj4gU2lnbmVkLW9m
Zi1ieTogVmlwaW4gVmFyZ2hlc2UgPHZpcGluLnZhcmdoZXNlQGFtZC5jb20+DQo+DQo+IFZpcGlu
IFZhcmdoZXNlICg0KToNCj4gICBlYWwvbGNvcmU6IGFkZCB0b3BvbG9neSBiYXNlZCBmdW5jdGlv
bnMNCj4gICB0ZXN0L2xjb3JlOiBlbmFibGUgdGVzdHMgZm9yIHRvcG9sb2d5DQo+ICAgZG9jOiBh
ZGQgdG9wb2xvZ3kgZ3JvdXBpbmcgZGV0YWlscw0KPiAgIGV4YW1wbGVzOiB1cGRhdGUgd2l0aCBs
Y29yZSB0b3BvbG9neSBBUEkNCj4NCj4gIGFwcC90ZXN0L3Rlc3RfbGNvcmVzLmMgICAgICAgICAg
ICAgICAgICAgICAgICB8IDUyOCArKysrKysrKysrKysrDQo+ICBjb25maWcvbWVzb24uYnVpbGQg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgMTggKw0KPiAgLi4uL3Byb2dfZ3VpZGUvZW52
X2Fic3RyYWN0aW9uX2xheWVyLnJzdCAgICAgIHwgIDIyICsNCj4gIGV4YW1wbGVzL2hlbGxvd29y
bGQvbWFpbi5jICAgICAgICAgICAgICAgICAgICB8IDE1NCArKystDQo+ICBleGFtcGxlcy9sMmZ3
ZC9tYWluLmMgICAgICAgICAgICAgICAgICAgICAgICAgfCAgNTYgKy0NCj4gIGV4YW1wbGVzL3Nr
ZWxldG9uL2Jhc2ljZndkLmMgICAgICAgICAgICAgICAgICB8ICAyMiArDQo+ICBsaWIvZWFsL2Nv
bW1vbi9lYWxfY29tbW9uX2xjb3JlLmMgICAgICAgICAgICAgfCA3MTQgKysrKysrKysrKysrKysr
KysrDQo+ICBsaWIvZWFsL2NvbW1vbi9lYWxfcHJpdmF0ZS5oICAgICAgICAgICAgICAgICAgfCAg
NTggKysNCj4gIGxpYi9lYWwvZnJlZWJzZC9lYWwuYyAgICAgICAgICAgICAgICAgICAgICAgICB8
ICAxMCArDQo+ICBsaWIvZWFsL2luY2x1ZGUvcnRlX2xjb3JlLmggICAgICAgICAgICAgICAgICAg
fCAyMDkgKysrKysNCj4gIGxpYi9lYWwvbGludXgvZWFsLmMgICAgICAgICAgICAgICAgICAgICAg
ICAgICB8ICAxMSArDQo+ICBsaWIvZWFsL21lc29uLmJ1aWxkICAgICAgICAgICAgICAgICAgICAg
ICAgICAgfCAgIDQgKw0KPiAgbGliL2VhbC92ZXJzaW9uLm1hcCAgICAgICAgICAgICAgICAgICAg
ICAgICAgIHwgIDExICsNCj4gIGxpYi9lYWwvd2luZG93cy9lYWwuYyAgICAgICAgICAgICAgICAg
ICAgICAgICB8ICAxMiArDQo+ICAxNCBmaWxlcyBjaGFuZ2VkLCAxODE5IGluc2VydGlvbnMoKyks
IDEwIGRlbGV0aW9ucygtKQ0KPg0KPiAtLQ0KPiAyLjM0LjENCg0K
