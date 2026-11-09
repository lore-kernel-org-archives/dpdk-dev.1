Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 447F8606A31C
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Nov 2026 19:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=marvell.com header.i=@marvell.com header.a=rsa-sha256 header.s=selector1 header.b=j/JO3eyn
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8DB7A406B6;
	Mon,  9 Nov 2026 20:37:54 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTPS id A88164028F;
 Mon,  9 Nov 2026 20:37:52 +0100 (CET)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A9HKABp789397; Mon, 9 Nov 2026 11:37:51 -0800
Received: from sa9pr02cu001.outbound.protection.outlook.com
 (mail-southcentralusazon11023129.outbound.protection.outlook.com
 [40.93.196.129])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4hujfgrm1h-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 09 Nov 2026 11:37:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZNJS0ylmadi9biEVrbSCB0xETsPi2yJXezA3pld/mjjGjm6gsDZFGtSRwrV+TzWTNuOTsmuuD4vaKJs68jKnZjrQXeYQgkyuafMfsD85qNVAqZ3iU34EZXLiZbwn6mIDSHWchmwayIoBryTZROICX6NDz3tT20mQAMbUbN5omqN//b62FmZI1e0fsaOGUaTXAhDv1rhNDraoDwpXiZ8QuiWtzX/XygP3/738RJnnfWliQDdr69As9Knx1fk3vWGS7u9gR3ZoEOwu8/QMY31jrKhPPb4JPBdc4ALoH8hPHC+cue24VoaGZh2mYi0XiegQPWr7U0z9b82Gh3Gy8GlCtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=InM03R+1QRLSUGe/V1vPTDD9k8ibtxfLIij9G40fZz4=;
 b=dHwoE+rPT9plc+THLdnCUTg1RuqcJlshOnPbD0b5ez3/OOmbwf1PpmsIeNJAe9lS0Mn9TalHttSb8fneff/HsJpNDijBIo1q6pW2ayMn39e+vFrCBA13BUMssj1bMEbsjwh0gg5/qNuRD4Bw3PR92HhXCDFfJqc9P6xmFkEVFAMSIxy1Ji20w6WzuqVkKpn7VEzZMNUYysAgusO0avk64U6GhMIszwLAAC8eH4aqL+yV9LCqRMGKvDX3UufI80EVUld+DAkVjDhY3i1GM0ZVdhKbv2qpT5pY0kp1bpWuBciIRFkF19jk2YMUoh6ezsKVLKmAYZsonq6/9DWNMjqa5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=InM03R+1QRLSUGe/V1vPTDD9k8ibtxfLIij9G40fZz4=;
 b=j/JO3eynD8qqBnCZq61RQhVS6NbEicVHRC/9J40/NyoBwXL6xL35bz/P6g7NfFRxRWKXktH5B9DvvWS6OiqW3fDwtyT8YK0NSpgmzSSAa4xj9vE4q0ZlAq5KQPH93b7uTkh/qJ42B7y7r+6POtG/c8z8pYuF7iszYWGW5K9hW3M=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 LV1PR18MB988635.namprd18.prod.outlook.com (2603:10b6:408:3f2::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Mon, 9 Nov
 2026 19:37:49 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17%6]) with mapi id 15.21.0592.012; Mon, 9 Nov 2026
 19:37:48 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: "Ji, Kai" <kai.ji@intel.com>, "Nicolau, Radu" <radu.nicolau@intel.com>,
 "dev@dpdk.org" <dev@dpdk.org>
CC: "Alexander.Konyukhov@kaspersky.com" <Alexander.Konyukhov@kaspersky.com>,
 "stable@dpdk.org" <stable@dpdk.org>, "De Lara Guarch, Pablo"
 <pablo.de.lara.guarch@intel.com>, Fan Zhang <fanzhang.oss@gmail.com>,
 "Doherty, Declan" <declan.doherty@intel.com>
Subject: RE: [PATCH] crypto: ipsec_mb fix OOP SGL for NULL cipher
Thread-Topic: [PATCH] crypto: ipsec_mb fix OOP SGL for NULL cipher
Thread-Index: AQHdVYfIJx0kOJU5GE6AOe0RZBnWlLcmWFqg
Date: Mon, 9 Nov 2026 19:37:48 +0000
Message-ID: <CO6PR18MB44843463168D025FDB5735FED8732@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <20261006105329.1630257-1-radu.nicolau@intel.com>
 <LV2PR11MB60454B9D75343634C26D473C81952@LV2PR11MB6045.namprd11.prod.outlook.com>
In-Reply-To: <LV2PR11MB60454B9D75343634C26D473C81952@LV2PR11MB6045.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=marvell.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|LV1PR18MB988635:EE_
x-ms-office365-filtering-correlation-id: b735fa70-2a4b-45a4-4c9e-08df3e98ef53
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|22082099003|18002099003|10067099003|38070700021|4143699003|56012099006|261022075727099003|261021135927099003|261022105027099003|261028144727099003|261026140227099003|11063799006;
x-microsoft-antispam-message-info: 0+DfUAakk0LkeDRY1q+p/Q6+up6u+N4EHOvr+OnPZHSstAZFRYPupIlNazEBNUmBih+HIQ1J6RBdGLzlId7fVe4LGdC2YGvA9/2978oa4Sa+buyqGeOK9w1q8qS3k79Vi1VnCQCF77U3SaZ5Of6oT4c7Mr0Xncez7AgyO80XWG08MW79dGDY32VGwSRBdzOFCSnUuRtqEfOnzof/IUIe0+oe+7S6+kIQd6VgeSubs22zzkdRO+JZF+QfzDBYi1hcLUwDHeEUKb+Z8PpKwajwjOJ/DaQBt1pg+Mq+b2h+9BIP9NYThYFCpdvRDbYiZoaEBdkjE9SdW1l5ZbhzzgSSbF48UU8rH/8eAS49y/Jq3LoRdoHXZmVly2z1oMUtsYB4pDgWOhM88Yqp+/VKqQCDsrKGpGxAmNurnHOcd/0CWdmUbQjewNPN6K1Hg4DUx4V3E9HX83l5QKZOCJUAxmdAwdg3M0HtuXCLyjPRIs4w2hhKYQiNJOLQf35nb3QLXuDwSgAIdjI+k9PRyPkUL5Rc2Zpf1qS2yv+fXw9N9LjXFMlmU4n8N6pjRXVu0ilpPsHx8mM27aHMUCvjasgBOOIjIdJ18mc5+PdS0/VSjKGkofMUsU2Ox1Ozi5mOhKNiKPbcqfsXXhLupfGEBINYoWVRZvF/Dtg4mzRDIn/CvVXrp1/zmVq8g3zX9W/uxbmsJu1HVgPgEpRI6F5KQDcA0/9c5TSEJpmWU4KpWEFcKNbVeBs=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(22082099003)(18002099003)(10067099003)(38070700021)(4143699003)(56012099006)(261022075727099003)(261021135927099003)(261022105027099003)(261028144727099003)(261026140227099003)(11063799006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aGdML1pwWWlFdFJVWEc0cWNWSEFqSDFLU1o2bkRDMVJ2NlJCUjlvKzhPamR3?=
 =?utf-8?B?bWc1cjdZMnpnUHduRHF0ZXRIWUNTTnNpVWMxaExYQ3FmTGYvNi80Yk9IMThQ?=
 =?utf-8?B?b2VFelluMDZEZmphVlNxMnRlWUg2ZzErNGg2eE9JS2ZGVkpLUmp0YU02dk0r?=
 =?utf-8?B?QTU4ZXFteGxrOUgxYW1zd1JxL21DTHF5Smg1eHlUR2JlVzVNTklvN1NFdi9L?=
 =?utf-8?B?ejQveG1ES2F4QUhjNmdHVHFDbmZ3TWVrN3pZbVVDc2RScnV1MDFDTFBXVFBZ?=
 =?utf-8?B?bnB6cXF5NDhianpiTXUwcnhid1d4aDBDbTNiNFJtQTdvaFNvZm44SVRJT3VK?=
 =?utf-8?B?c2pNVnpoYmNBejlXbU5DMmxub3REeWVlTytxWERWUm9WblRUMmNPTGp0aGEr?=
 =?utf-8?B?MDFjUlFvR05TbEFEblRpWUptempJYnV5cGwxdEdKTDVGQjlVZDQ5MnU2UGRM?=
 =?utf-8?B?c09meWdsRGxvbk91UW9nYUVlek9GSGV5aWsrUlVZQnJxVTlxVHpudlJsY1dt?=
 =?utf-8?B?RDZwVy9EVU0yVDMyQzZaRmdoZDIxTmE5c2Z3N1hCeXRZdlhWS2hhd0RYM1U5?=
 =?utf-8?B?T0l0TXdhaXhBVFpvbVV5SzhvWUFpZVVEZ09WMmFmdko2ekNZQklvSklhTzVP?=
 =?utf-8?B?RzJ4Y0RNWE4zS3BJaFRNOEJjKzhJU3hSWWk0YnUzeDR2S2VmUStrckdMUUly?=
 =?utf-8?B?dHZNMUF6S2VWTEVLbnVnRk1qeXFOY3ZMY3RjU3RaU3RjWDBrTVM0S09NVncv?=
 =?utf-8?B?SzFaNlZQYXNrZmprazNVczN5dC8xZzNMZVhEUG1XcTNObU9XRWFBay91aG9K?=
 =?utf-8?B?MFc3S3pGL0JoUXFrcllqUDdmY2l3K3RneUZyMEFROWRMZ3lCUjl1bTY0Y0Zt?=
 =?utf-8?B?OFRKd0xmbFJaajhIWHFhT25WSnFSREtRY2pWcVBkei96MDZ6Vk9WcFpGUFZ2?=
 =?utf-8?B?c1ZBcENwSnhiVlhEUkt5YTZXMGJuN2N0MWtPYzdXY3JyN2xmOElkbEIrRmdi?=
 =?utf-8?B?YnlQVUJOTENmTCtCdmNPM2RVRHBlSm5Ja000N2FZK3BjUlpFcXhweW5jWXRC?=
 =?utf-8?B?T1NrK2tyeEZZN3FLSVIzdGJuS3N0SlUxT2dvd1ZMSDcwV3R3UiswYnRsNTg0?=
 =?utf-8?B?dHdQcldDSnMxKzF4QWpsVndTcmMvbkhXSGdrVC9qWkQ1aXZsYWlOdmxHU3F5?=
 =?utf-8?B?d2IrNERYeUZ5TnE0eUM5cUplTVR6UERucHZtZWpPKzk2dk5JNDhXZU5DSVNH?=
 =?utf-8?B?VGpyTzRCVzduV3BXdnVaaE1VWkF5YlRVVmo0Yk1jQXNNN2ZHTmZoRW9yOXZY?=
 =?utf-8?B?T3dWdERqNlNidFV2VmNqMGJ3VUdTUVlRRFhzTm84bDljZVc2a08wUmpWUmdC?=
 =?utf-8?B?TE1vUGZJVC9pWlZBRGNZSjlCSEFkdlArUWlaVERMa2VaaTl3bU1ZZ2hycnQ0?=
 =?utf-8?B?T2RTaEhiNWh6OGNSaDVwblRsdU43amZHRzhLMmlndU5HdEV1L0VhbFNpVWZp?=
 =?utf-8?B?a2haQWFKZ1cvUlB0LzRBMDZNM3hiaVBzZFRSMG50bzM4ajFGK0lPbkdHNHRi?=
 =?utf-8?B?K2U5Z2FEZGR0b01EcEN1Rk9Gemd6RTI4eHdXYmxweUliSFQyUElvbHRGZmxH?=
 =?utf-8?B?SGt0R3dBTmJoZUI3R2JMQ0JLTENlRHFVYVU0UDZRTmpoclBaOXQvNHNwR3hX?=
 =?utf-8?B?bWdqY1Y4RXZtN1JGVVpRMXNIOWpOWXRoMGkzWVhiaVVWZUF0SHI0Vk5jNERt?=
 =?utf-8?B?ZkFsTDAzTFBmZHNCcm9JN2ZuRC9aSkpaRDVGNXFOL1RxQjdGUlRNNzk2czRM?=
 =?utf-8?B?OUNUNm4wT2w2WDRQb2F1Y2sxVml0TitLZUlocmV2eU1BUDE3MkhTZU40amxJ?=
 =?utf-8?B?L0lnQVhTZk5RU3ZQLy9MZHlVSm55b2h1emlzSDNMQ2Z3a3RnNG9ZcFo4eCtK?=
 =?utf-8?B?b3lhV2VRVTJOUkp6R2U0ZU5Fcms3Z0EzV1FGU0JEekl3SFlhZlVnZDVuZ0xQ?=
 =?utf-8?B?bWZxZjlBb3dDemhwalZXR3VnQTFMSko0Q1lLTHdCTE9YV0wxditjd0VKbnQw?=
 =?utf-8?B?Y1dnZEVDbXBsbE9Sbm5UTFJDZW1vTkEydmNBZlh1U0I1Wlo2NnhlS1lGQWxE?=
 =?utf-8?B?bS9Gd291TC96VFU0L01RWkVqbEFJVVNsSUdiZW13bldNSXJUNmlTWUFVdGJr?=
 =?utf-8?B?MEJwdTZ2dEpJdVFpRFFuOHlyRWxKakJieWlxVVIwT1ljNE1BSkdZYm4xbmQ2?=
 =?utf-8?B?VCtRSXRyS2s0dk4rK0t1N28wd3V5dUM1bXlGeU41Z3pGaEVjdkZicGFHWEgw?=
 =?utf-8?Q?1hXmdGYn3dxnNYVB5o?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 4D4r5k7whq6pyWiHLsDabZASsS0ydr/wzrgsK+cSKx2kgZMjJG0K73Onc/URq7tTmw1VKQKkwOHGaSvToJN960JL1ATCxJWhACwoBOT0MqiXzjK7JerdqmEx6Z6PSzY/z9JI8i2KKFC5ZcFEv0Imvb8c71e9bAK+hkFQpFCv/erf7+iJFpHFtvmzFkolhG1fZgPBFLFL8o0XdRPke/fY4uOY4z+WMmVAqlv3cCh+mzJ/umEPPHvXXDvNuEW5Oi60VJFwLYXP6202BpOjYQeCcUTw0ADSTumOPgklewHRjLhT/VXcJzY6pLQSsi399e/9ky7WE8UoC5Mf6l0bvMLFUg==
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b735fa70-2a4b-45a4-4c9e-08df3e98ef53
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2026 19:37:48.0776 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /p0TALpt8WOBZFCg4eOAs512cV4ikx/ro0GauDnZbhQcYGOdeiwE3EHeSG8m/O9eKbdM9lNo8G75tuF0i0cDMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV1PR18MB988635
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDA3OCBTYWx0ZWRfXzZd3lKWwyUjg
 Udgi8rzz1nLkdgSSjO9IJsY95uIKklp03m3ULdQXu8/0RVatb9YC/SSpg2b+iYHILlEcf8Wq7gN
 fEHuJK+tXTHooo+5Wzz5GeYKyjPniHo=
X-Proofpoint-GUID: kTd2bA9hCosdBMnMLk-GAsgnD7Zxtpt6
X-Authority-Analysis: v=2.4 cv=F5nC5ahN c=1 sm=1 tr=0 ts=6af2210f cx=c_pps
 a=R6SrqWxOsMs7v49b6WFfjw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=QXcCYyLzdtTjyudCfB6f:22 a=QyXUC8HyAAAA:8
 a=8rWy6zfcAAAA:8 a=M0DsdacQdwr_EzhxK_oA:9 a=QEXdDO2ut3YA:10
 a=YjdVzJdQTyZRADMV7wFX:22
X-Proofpoint-ORIG-GUID: kTd2bA9hCosdBMnMLk-GAsgnD7Zxtpt6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDA3OCBTYWx0ZWRfX6TOww9IVi6Sj
 NUCelNIvEhj/a5Rrsdm0/Ip38LDiaX0s17xJNuL0F+AToT7IfRTEeKR9DnqhBdpEyl7g5zReHef
 eyKqQs1+68kAfW9hPpm02/G+kAe868ZDeoaFSpgbCTtg85Lz3bh+OXZGdIx6/GcXyJSq1bVEmw7
 9hNYlbKO98iXzdMnyoqI7nozqRxSrZflxK9W0uXijPZEgX21swVJ/UG7ySQ//SeURIP9ahiTgab
 RLpzDK2SWFSSGpgRBLFoS9I3iyK3O61XrhaWHg68JjovlY4d5ETOfYQsoRKU89V4AABFbiew0v3
 uIO/co0kLOK04jGvgqShPYYVWHtgAmq+Fr6UWn1TvrESGQhrzRuU3ZU0GIPIbswCB+sU2q4rB2P
 qAqiUMTbZbhTNWBZecwXJyghdEqUPRGNoGqUZbkDhDK6IZgsmY77EFX9aFB2tAADyGNRS4kkXX/
 XinxCdbdTp08o6lrVow==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_06,2026-11-06_01,2025-10-01_01
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

PiBBY2tlZC1ieTogS2FpIEppIDxrYWkuamlAaW50ZWwuY29tPg0KPiANCj4gU3ViamVjdDogW1BB
VENIXSBjcnlwdG86IGlwc2VjX21iIGZpeCBPT1AgU0dMIGZvciBOVUxMIGNpcGhlcg0KPiANCj4g
Rm9yIHRoZSBOVUxMIGNpcGhlciBPT1AgU0dMIGNhc2Ugc2hvdWxkIGJlIGhhbmRsZWQNCj4gYnkg
dGhlIGxpbmVhciBidWZmZXIgU0dMIHBhdGgNCj4gDQo+IEZpeGVzOiAwMzk0NGZmNWUzZGYgKCJj
cnlwdG8vaXBzZWNfbWI6IHN1cHBvcnQgbnVsbCBhdXRoL2NpcGhlciBmb3IgYWVzbmlfbWIiKQ0K
PiBDYzogc3RhYmxlQGRwZGsub3JnDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBSYWR1IE5pY29sYXUg
PHJhZHUubmljb2xhdUBpbnRlbC5jb20+DQpBcHBsaWVkIHRvIGRwZGstbmV4dC1jcnlwdG8NClRo
YW5rcy4NCg==
