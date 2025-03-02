Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EEC0C19F32
	for <dpdk-dev@archiver.kernel.org>; Sun,  2 Mar 2025 19:14:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 10BA740041;
	Sun,  2 Mar 2025 20:14:28 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 5C25D4003C;
 Sun,  2 Mar 2025 20:14:27 +0100 (CET)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 522J0CSD007565;
 Sun, 2 Mar 2025 11:14:26 -0800
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2172.outbound.protection.outlook.com [104.47.58.172])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4542mu9ukt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 02 Mar 2025 11:14:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZSubEVyJHpDYloEruIBcWzEcOwYASaNEck3xejeADqhKGpBGd885EQeNCUpQLhtIhMrSQydj81x5pLNBqZwB9culBKtatgTwJFRIEmMWMn44FkSOIDo4CBmKBmXXlgv/rQ/HZ1c/QtarxeBXztCE7rXr4wQFj3o4WvQi/kCo8I8xwNu/aD7vOcY8k6alPxyDcRB2K9BHPAH0DcCrIUnAs583Kxtan0fSF1nqzwCEitLG9Te7nDXtoLiXI8Aii4gYWQngQvS929i32MCIlPGGWGBntTKi8+TJ4hmszNAXAPQhWs8Ow5Q393k/YmwDnAn5o9k/fi7xu1C/Jrmfo+RXFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6fITs4rSCvu7zDdlClHI/BWJm57EBYaA/OBoxFGD2Dw=;
 b=jfNKan4r+mjcpv78OBps/cpc0VbaoN5XcTlOTIuK96zWlE6Jea7v+oMVJrEQfi+40LLRLRPluYPkPMTy5tCGhEPyMN9CsLZTKXO7q8B6gNbLskUapUBJj1j+XwciXxate/e8sDN4JYLcqtKH/ep7cbABBfQ+M2loLzsNLC/5qM+9NspzXTCi1kOA5g4Ct89bFcNzUqPuxDMafY61sIm0DtytiLe+Df8r++RKM+nIcWZVXw+92oWYqfrLWGMpfq1OGQTP/OrMSwFUX966eI2CeqL1XbLnn8/iqT44k7Ol/5opCMsoJvLXZ89fihT1DZSwbIjIVGAguuJ5T3GZjpANDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6fITs4rSCvu7zDdlClHI/BWJm57EBYaA/OBoxFGD2Dw=;
 b=Q2Aq3Cq9o5Y23lchgxest127aKk0+KGSIcy91W+MnAZAJJPTTRq9Z6p1sLZzVUJgBr5BcR6TuSgKIAtFogaD0CfUJf9kqbsUcPWAb8oZRdz2WHqYXs+d9atYkEPnkfK1+K96gCtVk0UGXfnImrKy2gyj6UndsEM7WLBw3gOgWnY=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 IA1PR18MB5491.namprd18.prod.outlook.com (2603:10b6:208:450::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.27; Sun, 2 Mar
 2025 19:14:24 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::3c98:dd36:4897:a51d]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::3c98:dd36:4897:a51d%3]) with mapi id 15.20.8489.025; Sun, 2 Mar 2025
 19:14:23 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: "Dooley, Brian" <brian.dooley@intel.com>, "Kusztal, ArkadiuszX"
 <arkadiuszx.kusztal@intel.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: "stable@dpdk.org" <stable@dpdk.org>
Subject: RE: [PATCH] common/qat: fix incorrect size in the parser
Thread-Topic: [PATCH] common/qat: fix incorrect size in the parser
Thread-Index: AQHbgrKRdBD+/c3P80ufRRjk98vIprNgR4Ig
Date: Sun, 2 Mar 2025 19:14:23 +0000
Message-ID: <CO6PR18MB4484B7C04F71132E32DF2145D8CE2@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <20250207095832.4032332-1-arkadiuszx.kusztal@intel.com>
 <SJ0PR11MB50561E0071918CAB0166FE7B83C52@SJ0PR11MB5056.namprd11.prod.outlook.com>
In-Reply-To: <SJ0PR11MB50561E0071918CAB0166FE7B83C52@SJ0PR11MB5056.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|IA1PR18MB5491:EE_
x-ms-office365-filtering-correlation-id: c374584c-607c-47bd-6f5c-08dd59be7160
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?SnhRZmRXRVUwNENBUktaVmpjZUJTWDljSVl6aUpld1h0SjIwa25VdjMrYWNW?=
 =?utf-8?B?Q29yZDQyUkF2RS81emxGTU5Cd3IwaWtxdlBlSmNJTGo1eGtvZ0JoR2ZmVnBL?=
 =?utf-8?B?RnRBbGJFdlFRMUpCZUpnVnJrUkZ2c2JNZVJGRE8xVFVVU3pKR1NnMVB1Z1Nq?=
 =?utf-8?B?UGVCOFRXNnMvcGExS2VxNnRPRVNNaGJ5WlVVbzFtaFBTMnM0dFN4OHdHMlpD?=
 =?utf-8?B?SC9ZTVY2QmU5Q2RReVc5cG9QOEVrZkl0emU2dlNmZWdOc2tvQ1RkYnRib1Zu?=
 =?utf-8?B?S1JUK3c1QTcvM090RHVWWTNLckk1T3dTNmZFZEJ6UTl3Qythak91NlU4V1Za?=
 =?utf-8?B?QXdsNjQ5ODhhNmVPYnkvcmpZREc1ZEFEUHBYeStDMk5Sc3dDeU1IaEFEVjBS?=
 =?utf-8?B?bElKSlF3QVZRZUdpRkowaHB3ejEvMEhLNlFKUnJGcmZyTWtnYTN1eXNpdGw1?=
 =?utf-8?B?cFdFeVIzZXBxeTE2UGxNYjcwOW5QMTB0NWJLb0MzeTZ6RXdGU2hLYXgzUEdH?=
 =?utf-8?B?Vzh6SFRJZG5aNHZ0L0VadXhMT0xaa0NyaU9QYXNVdk0wYW1GaWl6V1RFdEFo?=
 =?utf-8?B?cmlyZ2FCUi9VenRJUmtMQ3NXYituTDBpeWowOE5pRWUrbDR4OFJXQmRlN04v?=
 =?utf-8?B?Mlp3U2Y3dS84VG5rRDFab2xZeTFCQmdOZXNtdW5lUkxoSlJ6VXN0WXZqTFFj?=
 =?utf-8?B?WnpMcGp5UUhLL1I2Y1FaSTM0cjBYMU1lSU82dk1xWlN4SmhQWWYyVDFkMSsz?=
 =?utf-8?B?UDlMcWczVFRuUmM0ekZIeGN2d3hlNWtzUUx4Yktyc0lSbmtLd0VwMmxDbFdn?=
 =?utf-8?B?ekl2S1hlM1pVTHRzT29CMi9hdGEveVNEN2JPMC8vbERYRWFlWkRFaHVIc0E1?=
 =?utf-8?B?OGk3ZUdUZVFkWWVpd3A3KzNHbmcrUHJzOHpIVVdCNEx6MnMvRlZiK0owUElK?=
 =?utf-8?B?bDhDVFN1MkpEa010aC9vY3pUckJ4YkJ6UHpyZkpZNFg3eFFINHo4WkFvMWVJ?=
 =?utf-8?B?N2lOR1lpOERPL3VLbTBuc2dEWE5tdU9Sc1lwNXowVDdzVE4yWUhhSlJhWVFM?=
 =?utf-8?B?Qm1Nb1hOSEpXRXRYVWxkQ1E4L01KcTl2Znh6TXp1dzhXWmovUkxtMElmOHNS?=
 =?utf-8?B?eE91a2hXaWk2WnUxUVFnQmI5Sk5pK0FhZzlkVm40SW1BYkx4a2VONkJzako0?=
 =?utf-8?B?MnA5dENXQmpkdHhVQVlUWCtKV2tINXpqVVJjMlM2RVRjWGpsaEhCOU1wWVZh?=
 =?utf-8?B?ZHpVRUdPRkgvN1RVd2JIaHdIUTN6ZXRSb3h1Yi9VZmVQK21LQlk0aDFRR1Nk?=
 =?utf-8?B?STkyZjFZQk4wUnkzaTRUOUVTOForQ3F1VDJ1eGpOUUYwTFUrcDR4SkNvV2E3?=
 =?utf-8?B?UFZxNzVCOWh0VFNNZDJkVGw5V0VZTjFtNkpzUWUwcnhNaVl1YmxHUHNGK1lD?=
 =?utf-8?B?N3pGcnlvVjFDNllldXlId01LRDRrcDlBZysxWEtHdnF3YmErcy9hN3B0V25M?=
 =?utf-8?B?VDJ0UTJ0bFkwUGZJY2pWY000T1RlZHVvaEthcDRUNTZhWU0xN2J4NFM0c2J2?=
 =?utf-8?B?N3JhWWQwZ05UL3pLalpLUkJKcmJWRWg3bDJUOGhQQXhEQmI2TG1ZT2oxUlVm?=
 =?utf-8?B?N1R0NExkYWc2RW1YYk9SekNSNDJoc0RueVVuK2FVbi9yckt3MjZaUkRLbElq?=
 =?utf-8?B?U0hmQ2VHZWg5MG5rRzlBMGppMTg1a3pLOS9wMkxGVUlzdVAxWnhaMERCWGpv?=
 =?utf-8?B?VjVlYzBhd3BsMkg2dzRES1FyNzhVNTRmcW5zK2F2Wm01SWRaOVRmRDJGbHZZ?=
 =?utf-8?B?VG1hTVpvR0Z6T1ZoUzZYdGJEY2RrWnFaRU91eHh0c3c1cE1NS2c1eGI4Q0di?=
 =?utf-8?B?RUxSanlPdHhxR2dvTmYybjhVaUJKbElXMlJLUnd5ZG9wMDVhNTRpeEU1b0Rm?=
 =?utf-8?Q?wqFTpqaLrFWXLtnIHaZtcJIWvaNtBopH?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TjFzeUhVVVJPK3A4RGsxaEp6Nkhla3V4ZDRraHU4MWJtbXlMU1JRckhmOHdj?=
 =?utf-8?B?V3B6ZklLVGxPUmgrazBCc0NNd2V2Qi9QbW5DK3NBc1pxQllMZVdNNVZvejAv?=
 =?utf-8?B?eEQ2UmZTZnIvMElJWkpBY3B6NWVTeFArSEs2TVM4N1dINXAyNmtGTm15OTRn?=
 =?utf-8?B?em5ld1YzVWxCQmZhZFptM0JYSlhBM3JYeTR0c1pTWEo3cThOcG9pbXp4NnR3?=
 =?utf-8?B?ZEc1NjNjY0p5bi9Da3hqZW1VNDNYdTFHNFBEM3JlNEdZMXVWTzdOa3EwYnY3?=
 =?utf-8?B?MjVZNXhveXJPTVdhQVM2TVlRbUl1VWNBTUtReGllbWoweFQ5MjR6dlloRUYr?=
 =?utf-8?B?WDlZQ1R0ODZRaGhjRjh3eFRITzRrTWFLbTEvakJ0OW1iUkx2UmlHd1FrS1pV?=
 =?utf-8?B?Ymkyc2NQbnBtRDZJdXVlMFV6dnpyb1lIWnJwakRpaUkzRHNJc2ZLRy9UN3ZB?=
 =?utf-8?B?KzdSbUNiS2Vrd2pQREwzNGRvT1NoeXJSUi9uQVJwbE8vSFIrN21qc21UWDNU?=
 =?utf-8?B?Vi81YnUwamNId29XYm9KNUNHL1NiK1A2Y3d0L3dHVmoxaklpSWFCdjFpNTF5?=
 =?utf-8?B?bDU4cjExOUhIajBKbzFXYVZ0RDNlNEpKLzlveERqR0ZRNmRaUmJaREp3WUVW?=
 =?utf-8?B?UXo5MGhITEVUV0hQaTZpMUpHcGc1VkhlQThhelExWGVZS2xzUm1PRjU3K21z?=
 =?utf-8?B?Wmh0ZWZxOUFRRkRtQlVGTjQ2VTgxVXA4UWNUa1ZnWVdDakV1a2FMNTBqcGpR?=
 =?utf-8?B?bTBjMXcwM0ZscUtLV2hMalk2eXJuNGtLN096NDhpQlFwaU5scnFCRDJ1TXJR?=
 =?utf-8?B?MzU3K1FnZTVjeUYreHVYdmw5YUdEVXcvaXN6cmI1WWlJTVYwalZ2TFNnUHZ1?=
 =?utf-8?B?TjM4VE9vZHFaMEV4OEJjd1VmNmRVQlhBRzg0VkxuOHBkZlllTWEwNmRjL3dQ?=
 =?utf-8?B?SjkvdzNUNWxSY0dKMERlbnIxc1A5STZ2NXY3M2ZCMUlXYnJwMUoxdTRtODNl?=
 =?utf-8?B?aGRlNFZYRi9ralVOSUJNc1VGSlRZeitPdWZBRzFLOTFXWjlyWlZBNDBKSjlG?=
 =?utf-8?B?NUxRWE4zRm9qbUFvTUZQSEZ5cSs5VmY1c2pmeFgrNjVVU1U1WnJMOHBmMTdt?=
 =?utf-8?B?cEJxUFd0VnNlOWhZL1ZvZlhUdXRCNjRRMm5iUzgrUnJiTnEwYXAzOVNoVmFB?=
 =?utf-8?B?QnpFTlROVWV6VVBzQXEzdTRwbG1nMGowZm5jNmwzQXR4SUszSERXbVg5R21R?=
 =?utf-8?B?dURYdU1Lc0pxL2Q0RHhGWG9SZkdqNkF4YUx0QmMrNy9wQklRdGN4dnYzR2Iv?=
 =?utf-8?B?UHJWQUIwWSsvTk1kUy9TUldRWDdtd0hiaEczbGtOMThISnZjNzJ2cXppd1JS?=
 =?utf-8?B?aGl4d1A1K0pUSW1CcFRkR0F1d0JFcTkrZVFnK3NVQUxZejlsdlF1K1JiT3VW?=
 =?utf-8?B?SWxhUXNUbGl5akRpNjB0MXVxbHA2RGd0MWlSMGRWdDRqVmRTU0o5NXc0bHN4?=
 =?utf-8?B?ZFArbkwzTGVzVThBYUkrU09UYVUvTnV1TGRKSTB4UzcvV0tVcE02UDZocVNF?=
 =?utf-8?B?NklTWlVPYVVwVGp5LzBQMHJtMk95TUVCbzlsZTZ2Nmd3NFgyM25XejJQc2tJ?=
 =?utf-8?B?UHFpL0c5dmQzR0Y5TjhzTTFzbVd5dkw1MUZpOTgwaDY5aUxPL1ViUjYyclJ1?=
 =?utf-8?B?MlVNa3RnaXJNR1drYXI4a3pqZ0h3OXlhZmxGbmRNUWxKdVZpdWZiakRwejJo?=
 =?utf-8?B?WlFRNVFjbkhJYTh0eTFGd1pDdzk5NXN4TEI2RXgzV1NMS3FycWlYTVN5ZzA2?=
 =?utf-8?B?NFRPclVyaGRtalkzblYwMnB5dEcwN3YycWdOVkRCNHM1cGlEZzJSZm5mU290?=
 =?utf-8?B?cThwZUZmeDVpdVljYlU4MU1YdFQ3b0t5ZDVVK0dEbU02MHFUa2JCdVQzYVEv?=
 =?utf-8?B?WWRQS0hxbDd1ZDdSd0VONXB3ZDk5MEJLU0NPNm1ReW1UTHFjY1pNUXhDNWYz?=
 =?utf-8?B?UUVrVTJQVUJNcnJVZmU3UU10bkZlQTVuZytleklFSUp5aXhldSszTmR5TEFO?=
 =?utf-8?B?Rk9wNXB3OGhMWTZ1dkV1ejczalhidFpSa1ppUXFSOFdONE5acEplUUgwWEdV?=
 =?utf-8?Q?vDydurR3XJV7ee9M3LTEslTVe?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c374584c-607c-47bd-6f5c-08dd59be7160
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2025 19:14:23.7258 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pPjSkOgF20XAxFI+1Hd8qhQGnSjKz9tKHiLF3XPVfD9J5pb6k436Ehq1/w5dk+e524wPt0vbBtPO/ouucMse8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR18MB5491
X-Proofpoint-ORIG-GUID: OvExMX3TLXjq6JmmdD5CswUAvv1GrYXC
X-Authority-Analysis: v=2.4 cv=H6Ihw/Yi c=1 sm=1 tr=0 ts=67c4ae12 cx=c_pps
 a=1OKfMEbEQU8cdntNuaz5dg==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Vs1iUdzkB0EA:10 a=-AAbraWEqlQA:10 a=8rWy6zfcAAAA:8 a=QyXUC8HyAAAA:8
 a=-2dBd_Ko3_2v_Rk87-AA:9 a=QEXdDO2ut3YA:10 a=YjdVzJdQTyZRADMV7wFX:22
X-Proofpoint-GUID: OvExMX3TLXjq6JmmdD5CswUAvv1GrYXC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-02_06,2025-02-28_01,2024-11-22_01
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

PiA+IFN1YmplY3Q6IFtQQVRDSF0gY29tbW9uL3FhdDogZml4IGluY29ycmVjdCBzaXplIGluIHRo
ZSBwYXJzZXINCj4gPg0KPiA+IFRoZSBmdW5jdGlvbiBgc3RybGVuYCByZXR1cm5zIHRoZSBzaXpl
IG9mIHRoZSBzdHJpbmcgd2l0aG91dCBhIHRlcm1pbmF0aW5nIG51bGwtDQo+ID4gY2hhcmFjdGVy
LCB0aGVyZWZvcmUgYSByZXF1ZXN0IHRvIGFsbG9jYXRlIG1lbW9yeSBzcGFjZSBmb3IgYSBwYXJz
ZWQgYXJndW1lbnQNCj4gPiBpcyB0b28gc21hbGwgYnkgMS4NCj4gPg0KPiA+IEZpeGVzOiA5OWFi
MjgwNjY4N2IgKCJjb21tb24vcWF0OiBpc29sYXRlIHBhcnNlciBhcmd1bWVudHMNCj4gPiBjb25m
aWd1cmF0aW9uIikNCj4gPiBDYzogc3RhYmxlQGRwZGsub3JnDQo+ID4NCj4gPiBTaWduZWQtb2Zm
LWJ5OiBBcmthZGl1c3ogS3VzenRhbCA8YXJrYWRpdXN6eC5rdXN6dGFsQGludGVsLmNvbT4NCj4g
PiAtLS0NCj4gPiAgZHJpdmVycy9jb21tb24vcWF0L3FhdF9kZXZpY2UuYyB8IDIgKy0NCj4gPiAg
MSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4NCj4gPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9jb21tb24vcWF0L3FhdF9kZXZpY2UuYw0KPiA+IGIvZHJpdmVy
cy9jb21tb24vcWF0L3FhdF9kZXZpY2UuYyBpbmRleCBiY2E4OGZkOWJkLi43NDZkOGEyOGJiDQo+
ID4gMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9jb21tb24vcWF0L3FhdF9kZXZpY2UuYw0KPiA+
ICsrKyBiL2RyaXZlcnMvY29tbW9uL3FhdC9xYXRfZGV2aWNlLmMNCj4gPiBAQCAtMjI2LDcgKzIy
Niw3IEBAIHFhdF9kZXZfcGFyc2VfY29tbWFuZF9saW5lKHN0cnVjdCBxYXRfcGNpX2RldmljZQ0K
PiA+ICpxYXRfZGV2LA0KPiA+ICAJaWYgKCFkZXZhcmdzKQ0KPiA+ICAJCXJldHVybiAwOw0KPiA+
DQo+ID4gLQlsZW4gPSBzdHJsZW4oZGV2YXJncy0+ZHJ2X3N0cik7DQo+ID4gKwlsZW4gPSBzdHJs
ZW4oZGV2YXJncy0+ZHJ2X3N0cikgKyAxOw0KPiA+ICAJaWYgKGxlbiA9PSAwKQ0KPiA+ICAJCXJl
dHVybiAwOw0KDQpPbmNlIGxlbiBpbmNyZWFzZWQgYnkgMSwgYWJvdmUgY2hlY2sgaXMgcmVkdW5k
YW50Lg0KWW91IHNob3VsZCBpbmNyZW1lbnQgbGVuZ3RoIGFmdGVyIGlmIGNoZWNrDQoNCg0KPiA+
ICAJLyogQWxsb2NhdGUgcGVyLWRldmljZSBjb21tYW5kIGxpbmUgKi8NCj4gPiAtLQ0KPiA+IDIu
MzQuMQ0KPiANCj4gQWNrZWQtYnk6IEJyaWFuIERvb2xleSA8YnJpYW4uZG9vbGV5QGludGVsLmNv
bT4NCg0K
