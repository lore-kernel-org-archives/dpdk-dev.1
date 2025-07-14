Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFC45C83F1B
	for <dpdk-dev@archiver.kernel.org>; Mon, 14 Jul 2025 05:25:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A32BD4013F;
	Mon, 14 Jul 2025 07:24:59 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 9879940041
 for <dev@dpdk.org>; Mon, 14 Jul 2025 07:24:58 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56E4do9l027812;
 Sun, 13 Jul 2025 22:24:57 -0700
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2090.outbound.protection.outlook.com [40.107.220.90])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 47vu2f0296-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 13 Jul 2025 22:24:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=imEjWgTK3A5+8vQ0OBEGZVAloUXphmqdFzfqgAHxo/RYY6D8t4Yxf8G6TyujN93tIuPbbDaHonRB228ndci4fj8H/HmGXBpH2wM+/93bpIIu92kVAMPe5gnrd9+kCYKTrQ66TH54y3wkvMh04QxmF+Gkz3F4nn0+Z6BUkp+/SIzIZjyh+mP4iz64RT7WcoLbeLV+YvJXVJ5KDMcRWf32RwkDfavliht/1ej2RO4jJWuqgW8XwE7AD+aFz+Dph4ldqwAhSZnEU2iFAIJJQdBFXfHs4+cH/XX9egoUffG/MymGv0angiAj3HsC7solXHpRHxvgidmI5n1822r9M5II4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0FMu3DA9G/btqcHKufCuYyMrhZUsgRtACaxnoS5d0CA=;
 b=F3PI0dnK83csfI9rwZAwbsZx4Gh+QNs/ZASlgppQ7tKD0f8rpmyIcGhSdM7MZ0iMWCX6+9jMkV/EHVlRPcjTtCPKTVrrYvUN976y3Hax5DZ4eLQKHmDzNKdL9aSp7+pbdw83/70aaggbl4kj9c4BM7E8JChUWT4jd8atKaco43LpB5iY9CkmuG16Pn0Oaec4Zsn4FV9dfpPrv3iEdf4fc0vXm4pShGYvj8sbuvqY1WzFWVPRW08BOBnvJ7v+rTcNt3C0fr2UdyF5S9xpl9AbpmBCwfih1KD26fbSef6lIjBsL1dPArwpsLmwW8XejdpPDKuZ/jS7e2OMX3CIviNtuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0FMu3DA9G/btqcHKufCuYyMrhZUsgRtACaxnoS5d0CA=;
 b=MjFA8BT0hSOuljxnYyB6FMMSEKFNpYW1I3rN1hd3P/lpydpzzEqm1/ryoHOmxICcZBO1GZxMwTpJ66GDYAG84f+EnOQn7C1nzj+2OHaLkG79L44uTHmcrRWTAmNenIIHCiVaK4iPEjG71Ax6L1utRbr4XHYZoRVvJ79UzabGpCU=
Received: from PH0PR18MB4672.namprd18.prod.outlook.com (2603:10b6:510:c9::16)
 by PH0PR18MB5211.namprd18.prod.outlook.com (2603:10b6:510:173::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Mon, 14 Jul
 2025 05:24:37 +0000
Received: from PH0PR18MB4672.namprd18.prod.outlook.com
 ([fe80::10cc:503b:935f:f61c]) by PH0PR18MB4672.namprd18.prod.outlook.com
 ([fe80::10cc:503b:935f:f61c%7]) with mapi id 15.20.8922.023; Mon, 14 Jul 2025
 05:24:36 +0000
From: Anoob Joseph <anoobj@marvell.com>
To: Vamsi Krishna Attunuru <vattunuru@marvell.com>, "dev@dpdk.org"
 <dev@dpdk.org>, "fengchengwen@huawei.com" <fengchengwen@huawei.com>, Pavan
 Nikhilesh Bhagavatula <pbhagavatula@marvell.com>, "kevin.laatz@intel.com"
 <kevin.laatz@intel.com>, "bruce.richardson@intel.com"
 <bruce.richardson@intel.com>, "mb@smartsharesystems.com"
 <mb@smartsharesystems.com>
CC: Jerin Jacob <jerinj@marvell.com>, "thomas@monjalon.net"
 <thomas@monjalon.net>, Vamsi Krishna Attunuru <vattunuru@marvell.com>
Subject: RE: [EXTERNAL] [PATCH v0 1/1] doc: announce inter-device DMA
 capability support in dmadev
Thread-Topic: [EXTERNAL] [PATCH v0 1/1] doc: announce inter-device DMA
 capability support in dmadev
Thread-Index: AQHb8XfWk/OlOkddGkewUd92sPYRgbQxGLBA
Date: Mon, 14 Jul 2025 05:24:36 +0000
Message-ID: <PH0PR18MB467232EDCA9A5B6BFB829585DF54A@PH0PR18MB4672.namprd18.prod.outlook.com>
References: <20250710085101.1678775-1-vattunuru@marvell.com>
In-Reply-To: <20250710085101.1678775-1-vattunuru@marvell.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR18MB4672:EE_|PH0PR18MB5211:EE_
x-ms-office365-filtering-correlation-id: a244c90d-a795-4428-bbdb-08ddc296b963
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?VDEvVFpISnZKUVFTQnlrc1RXRjBXb2todk5MTnJNT0RRNnhaWFBYQzRqYTBy?=
 =?utf-8?B?R0pyOFd5dWxHKy8yL0hVRFFtRTBxVW9pRFRGYmhxZCtOUGlvK2tDeGZOenlD?=
 =?utf-8?B?U1JCYjUrQ2Vab21QQmxVb1NDYnQ3NkEwcmtuZ0g1Q05JYmdpakRkUWl1bHhv?=
 =?utf-8?B?cTFMOE5iRnc0dkYvQU5mZGlTVmF1UGxVZTdxRTdvaVJkWEYxemgwU2wwVUZU?=
 =?utf-8?B?Wkd6bDNScDIybHF0Qit6d21Gc0g2dytidWN3QTNJQjJTK2ZYSzgyUVhKdUZ0?=
 =?utf-8?B?UXFGMVB5OGI5V0xUQ1VPejVMdUtWWkJnTTNES3RYMzl5dEJvRmNxMjgrMFBB?=
 =?utf-8?B?Z2E4MytMR0pJUDhta2pmY1UwOUJucW9hN2JkeUVuUVJCWnUxK3B3OEJuWXRL?=
 =?utf-8?B?SnNTRjZ0dktyU3BDQnZhZVN2Y3drRk9xTGVlVXFEL1RyRGJIVnRrQkVPbFpj?=
 =?utf-8?B?MlQ3eVNkZGowekg0QTZkS2J1d09LcDVVS0ExQmhWTWtFWkRubHVyVXFoVEFv?=
 =?utf-8?B?V2RFZ0ltcTA3aUpLNkQvZGEzekRMcHZ6dTJmcHcyVWR6NCtaTzB6bGxuN20r?=
 =?utf-8?B?cWxEZDNwTWIwaHJTREYxLzNaWnNhTDJBY2VxUjR5aEc5QTZVcS9hWVNZMXJT?=
 =?utf-8?B?Rmo5WmZUUkVGV2lqenZsNFBIY3l1ZUd0MnB2Q210L1dQTGJKRGE1VTdwVUNQ?=
 =?utf-8?B?bEp5NXFYUDI5Sm80QXp4VmxyVG1jOStOdWVzN3FBQ3RMYUFIYVUwT2EvalZQ?=
 =?utf-8?B?cGlBQnpTdm9sMWovZzlxTGsxeG5MZHJvMmdLMEsvWXdQVzVIR3JHT05TL2xo?=
 =?utf-8?B?Q0ZtbUplOUFzcElDcmpOemd3THZZcy9YSjhadnJROWpISU1nMERZeFhybkZ6?=
 =?utf-8?B?bWJjaEhsSEd5VlorREpaaERnTWhCYnljV1Z0YUVuc3NVS1hnK1d5M2lqTWwr?=
 =?utf-8?B?Mk9ZblQrZEMzMmJYMlRkdFRJbHZpZWtOcjIvY1RaWHFab1lrNTJvZHVBblRS?=
 =?utf-8?B?elpWRWp1YTlFU2Y5V3BINHNoZURyc0dtZllYdnpaZVlhUUNlaStLODNmM3VC?=
 =?utf-8?B?ejYyM1pHZjg3enZLK3dyODhDWXpkSWMrYnJyeUxPdHpoL2VLSWp4a3JjczM1?=
 =?utf-8?B?Y3RkVlFFUlJNTW5udGhkN2RSMmZnbU1FSEE0d3NmUnBjSlNzbVNwZXI0NzZQ?=
 =?utf-8?B?Tkk2QlhtdDFiY1BSYVdPVXJxdWQ5MHpRaXdkRkFlTXBrYmVQbW1ITGRxMEx1?=
 =?utf-8?B?MGlsdG1pa3hmSkRSMFZ5Yi9DcVhVNUFYNzFsa2VKM2djcXV6SFJ6TjVMeVFI?=
 =?utf-8?B?WUdRSEVKanE3cEorb3pGaWNTbnNEZjlGd3JzTVprZGFUajY5M3luMHVjakNq?=
 =?utf-8?B?QzhUdXMrMm9vcUl6N1B6VXN6NkRLVnBQVzFGYm9KeGswOFFIdE5FVm9NTzNw?=
 =?utf-8?B?aVZ2RGh0c0RCZGZQY0ZQNmVtcmlmUTZoamNZNDFyQjNuQ1hlRTd0RkVvdHBl?=
 =?utf-8?B?NDFHM1NQQzhqclhsVGFvbnNMWUxDN0xxeWJ4R0NGa3l3TkwzdlV2K09kUTZt?=
 =?utf-8?B?MmFWR2lEdGhkbkliYVVkOEVjRll1TWRoS1JzcXkyWE9OLzV5UVhUNGxPOHh1?=
 =?utf-8?B?Rm5ET0c2TWZsYnV2QjA1RnNGN3owWHNoT0x6WXhoN2hlZnVDVW05UVhISGdM?=
 =?utf-8?B?OFFod2ZaWHdFM2Z5aGx0MFltcWM3ekhBbjRCV0RGcFluYyt1dkt2Q0prcUNT?=
 =?utf-8?B?dEhTVVZCRSt1NkZGeXVwSFRTdm1vcEN4UWFTU1JIZmJDMitkelI1WkpTWnFZ?=
 =?utf-8?B?Z0FQUWl0eHpBd2RDY1hWc3d4VGxxc2RpdHE3R2hhemk4V2xpc3RXSTdSTEFh?=
 =?utf-8?B?K1pEOXVIY0hPV3c4RzFiRXlsemVwNDk3UGZhdEdIUGZUeTIwUVN4VUtqbVIv?=
 =?utf-8?B?QjZ2T0xLWXFxU1BKTTZGekphbGkxa3JlS2JmOUxZUWZGRi94ZFhnZUJHWkRZ?=
 =?utf-8?B?N1RwblpHQkZnPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR18MB4672.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dWU2em95S0VuSkhMSWFsT2xQd3RKTlRjMlN2ZDBXNkxKTmNzQ3NOY3gzSFZi?=
 =?utf-8?B?aWxVSFRMMk41M3NsZS9ESVFJemFqTGU0Rlgxalg4MklaUm03WnhETWJoOXo4?=
 =?utf-8?B?YlVBa00vcDZoSDVwUFIrR3o5NDA5aDBqYytTL1J0dzFsakdYczd3a2Y0TEp3?=
 =?utf-8?B?bHVnOWErOVZaU3gwTTV1ajJnUlljNkR0UHRrdldNUFNVWlcxRmdQVkg4UE9v?=
 =?utf-8?B?R3poRXdUQ0doenU4WmdZaTVWM1NaVWNWd1hGY0ZBQWwvSjJDMjVUdXJlTEw0?=
 =?utf-8?B?aG90WVk4NEFFYmpDSDl5QkNXWk9yRXhMQnM5RDJJRXAydDh0ZVI0WlppYmd2?=
 =?utf-8?B?UUoybHowYU13aS81bDVnbTUzQmJSazA5NEVlVkw4TVdVSEtMNUFaNFRKUG5z?=
 =?utf-8?B?UWNiVWx3R0Rxc29ob3p3YnRxN2V6OExnamlDZ1JPZThmWWRBSk9McFpSeDBo?=
 =?utf-8?B?T29pZlM4T3JXWkVKaDRFS1BvTUJCVXBudnpEUUpwbTJlUWJXd3FXcDdFMDZy?=
 =?utf-8?B?VVFrRi9tSmhKMW5WOUdTTG1TN1hVUkl5NW9IaEZxeElLUWx1QUhML3oyZnhl?=
 =?utf-8?B?aGVCdVl5MkIzUzF1SXBZWkp2cElYTWV2M0NjQ3NXdnMxU3FSUklUbW9ycllo?=
 =?utf-8?B?TWZrL0NSQWhKZ29KTW0vM1p2bXFxVlBzWjZUbVlUUXd4TFVVb3ZYaUtwRVVN?=
 =?utf-8?B?WEJNUTVBMzhCaTFET2ZMOEZBRmZzRnZyOVhHTUludFNia0dHYmRURlQwRFJX?=
 =?utf-8?B?RHdrcEVKZ042VzlWTTEzU0s2NXBLeUk3TWZKN1RZcExHYUdyditMOUZCTTRn?=
 =?utf-8?B?SFJpU1kwQ2huMFlOQWpjMldOK1hSekR1blNBTng1QWdmQ1REZEZUbWlaTmFv?=
 =?utf-8?B?OFJsUm42K1NDNmM2ZEJmMFZzVGw3MEh3K2tMV0hnYTZ0RnRlVWNDZHVZcHVC?=
 =?utf-8?B?L3paOVR5MTNZYmhTMXU4ZGRtV3RvWnVrK0p3N0NGeVRmOVh1N1JKcTBDRGh2?=
 =?utf-8?B?ZFpOUlJpaWUxNUVsNEMzRG5mNEMySGFLTUk3MXRna3JYL05Yci94eDk1eElk?=
 =?utf-8?B?NXRiN0w0byt1eFlOZVgrdkNOVzBUTlNwK0s5LzZ5MXBsUldVQm9LTEtWYjdC?=
 =?utf-8?B?REpXaHFJc2QxWnRqMUpDNGhzTjFyT3hZMm9IQXN3aGlLOUNXQTdad1gxTXlU?=
 =?utf-8?B?NHVTU2lhR01ubXBZUHFHMTFqbnRSR0dXUHd0U3VkYmlMcW53QjlTeVVrMkh5?=
 =?utf-8?B?cFhpNnBDdmp4Q0dwTkFzcWFpN1BNU2Z0R0MzN2FFaDJMZTJYNTZPUjczZXJy?=
 =?utf-8?B?eGV5emZMa3ZKa3RYTXYyTVFpQmZNbDQvOW1PRFJRdzBxSXZhaGNBYmNPMHBx?=
 =?utf-8?B?am5qVUJsa2tSUFNXK0J0Qld1b0MxNEQ1K3F1TnNSNVV3aEkrTDJxVnJPc2VP?=
 =?utf-8?B?UDlldCs0Y2tubDZwcys0UVBDREQ0aXNaK2RldGVhUE9UdW9VWU55VUZJQTRX?=
 =?utf-8?B?OWRPRW56ekZFSUpSdXZXa1I0NmdJZkhiUTFGR1l2eGRkdmM4YnJIcXRwNzJV?=
 =?utf-8?B?Mzgxc09LajNSODh0SVVBbnhxeFJLdjd2a3B5OGc5K1BqdUc2Kzh4V05PWnRq?=
 =?utf-8?B?aUVnSWlQdEF3d3YyanRDOHF1bWVJcFU1YjdMOVpLTGF3OVZ5WnN1S3lIVnE4?=
 =?utf-8?B?UHhKOC9vUE0yWG1oemFkM2tqVHhqdjRYMThUd0tnU2NIMDAxVkRFVWhqalp6?=
 =?utf-8?B?NmNxN2NpNm5XT2FoNDZDVndqSUhGVnNWMnVWVWlyakNtdE1HRzQ1a0hNMjJh?=
 =?utf-8?B?b2dWVWQxMnc3SUZZYVBteEFWaXhoZDRaUXlsaGlVZkllTU10TjBPdjFYa3lW?=
 =?utf-8?B?c3FrQmFSTjZkcTR1cHdicFdNNWRMMmoxMzErZnRzdjA0ZTUrdkNwZmF1SWZx?=
 =?utf-8?B?NUR6Z0lTTTVXTDROMy93cW91M0ltVmFpeU1QK3E4V2pYK3NVSnpMWkJTUTNK?=
 =?utf-8?B?S0xKc2ZNakJ6aWZrL1R3Y0tUVG9uNXVWRjhKTmpEVklSNnFuZmpwOXdVTXRO?=
 =?utf-8?B?RXZsTVdFQ3psRit1ZWpyQW1wbm9pSXVwVjJXdEhzL0dhS0Nod3p6c3dnVUsw?=
 =?utf-8?Q?flA0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR18MB4672.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a244c90d-a795-4428-bbdb-08ddc296b963
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2025 05:24:36.7233 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GKq3UWadzwwZ5A9U8M6w0O5BVhmQ3Van7+W3tdWk2P7xsyZ2Jy2L1ul271NZBDaGd7bkaf0EmlgL5soWDFaISA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR18MB5211
X-Proofpoint-GUID: tcdn1G0SlWXtbh4o58JaDzZrsa5rv4L0
X-Authority-Analysis: v=2.4 cv=MMxgmNZl c=1 sm=1 tr=0 ts=687494a9 cx=c_pps
 a=eP3E3ZTkTsKlbTiO5LW6cA==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Wb1JkmetP80A:10 a=-AAbraWEqlQA:10 a=M5GUcnROAAAA:8 a=dBY9QoYXJcgj5Qub9qMA:9
 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10 a=0lgtpPvCYYIA:10
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: tcdn1G0SlWXtbh4o58JaDzZrsa5rv4L0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE0MDAzMCBTYWx0ZWRfX7aPMbooVFQwB
 LHZBOhnpJnKU9IEeTsDohTxUldpmBx//+K5dtEFPzapIb6sBWjXIkTlhQghaRH/lMhHA4WKvrqF
 K4azSK9cJa66v5iXHLfC+1I6cyHhflvQxGLiyikgNGNTrRZeakVZ69U75SJMezsyrA/5mrTS3N6
 cF1HmdCJkiAmCyWDOWsnZgyZOv5oslgDTKvqk4lxNNxK0wvWpqFEJe+A82Aoigeb6YTmH6tdFP3
 /G9kOjeQc/5/3Dm4LiLR8DARgYtk+WZ97hd3Lzb518aLSJEaD07AQtT5bRlFA2QYQ+y0i8BE3pR
 9Y//U4ff39qYIC6LIoHhlrdrNgq/VbIa9/u3hOCAQ4Rv9+J0iopoM//kn302h6maLQfNFz47+Zw
 ZHU7rR7Ro7teqcrMg93llsUA4HiSsQUwVIhcdx0pmECHq4yzGCFQPEi5KWYMyx92O4uQyZsQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-14_01,2025-07-09_01,2025-03-28_01
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

PiBGcm9tOiBWYW1zaSBBdHR1bnVydSA8bWFpbHRvOnZhdHR1bnVydUBtYXJ2ZWxsLmNvbT4NCj4g
DQo+IE1vZGVybiBETUEgaGFyZHdhcmUgc3VwcG9ydHMgZGF0YSB0cmFuc2ZlciBiZXR3ZWVuIG11
bHRpcGxlDQo+IERNQSBkZXZpY2VzLCBlbmFibGluZyBkYXRhIGNvbW11bmljYXRpb24gYWNyb3Nz
IGlzb2xhdGVkIGRvbWFpbnMgb3INCj4gY29udGFpbmVycy4gVG8gZmFjaWxpdGF0ZSB0aGlzLCB0
aGUgYGBkbWFkZXZgYCBsaWJyYXJ5IHJlcXVpcmVzIGNoYW5nZXMNCj4gdG8gYWxsb3cgZGV2aWNl
cyB0byByZWdpc3RlciB3aXRoIG9yIHVucmVnaXN0ZXJzIGZyb20gRE1BIGdyb3VwcyBmb3INCj4g
aW50ZXItZGV2aWNlIGNvbW11bmljYXRpb24uIFRoaXMgZmVhdHVyZSBpcyBwbGFubmVkIGZvciBp
bmNsdXNpb24NCj4gaW4gRFBESyAyNS4xMS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFZhbXNpIEF0
dHVudXJ1IDx2YXR0dW51cnVAbWFydmVsbC5jb20+DQoNCkFja2VkLWJ5OiBBbm9vYiBKb3NlcGgg
PGFub29iakBtYXJ2ZWxsLmNvbT4NCg0KDQo=
