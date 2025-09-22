Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C8D8CAC5A7
	for <dpdk-dev@archiver.kernel.org>; Mon, 22 Sep 2025 11:49:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0F33040673;
	Mon, 22 Sep 2025 13:49:01 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 4C49B40672
 for <dev@dpdk.org>; Mon, 22 Sep 2025 13:48:59 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58M9irZq018954;
 Mon, 22 Sep 2025 04:48:58 -0700
Received: from sn4pr2101cu001.outbound.protection.outlook.com
 (mail-southcentralusazon11022081.outbound.protection.outlook.com
 [40.93.195.81])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 49b43786tc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 22 Sep 2025 04:48:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ygpo2Yd8B/mbON1UbaxLDq7zUKK2b2+OmDNFlgCzRfEgmMDV4uBfjOOh/tjwiEDrpZUQe1aGK1KbZ0Ood9iUtF60V4taCrNmYEwqmplSidAZv3sb87A/NYyi8sKyTYllYUQdzvn2esKDdh2nr2yE+ffvhfPGBVco1mpcMIPHA8q7GHeDFn2qZU9ezAfHCpGS5GLddlF4T7+a6qrcRInt46YfbaOBpgcbCmCmKGJec1C0aXOHuaBSTL3Ni5mPUnutzs8vuLOvuObuF6tjGn0AA902sXHaycO2J/ATXpfkwFT0e4iR2gqYxU/14NPofY7OBOz1MnOozBatR6PvGgwTBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+WA+K3tv/OMIfO5GIDXhJ1ctDc5P9SPt7eTeKeKK6w8=;
 b=ca/jevxs/EFQSkDoQ7jSLBb0/Hnk++cQtjQJ6AMyOfTbVIkMw+A9Un5cI++DOlU16JOlxyZbTUO/G+7VwTy3BXKtCreu83Vp2/M7q6Ibh2dLhLiNYnnYlYx9oAezfVoye0ag6XXhtfgXDc/8Z5792E4dM3UeJHv2YzaF1RVdJQUVg51RJk+g0g22gl13Czg9N1utdGwrvDy0D0UmUfz686nA7gi7DSR1TiXpxVQwtH4642hHhfTJJzFnbvko51wuPP+KOpX/T06FrdqlzKpMsZz2Qs+IjSaneBcKomN0qf9K9ecnaDOoyF+oAIlzr43/PHZu3350mgOu1I4hT24qhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+WA+K3tv/OMIfO5GIDXhJ1ctDc5P9SPt7eTeKeKK6w8=;
 b=FFnvKirtQt3SLLa3xcHS6YlAcHCFzoMAaHAU/DVwfOy7XH18nwVjJCcICPbqTsq/bh0sxkYnCeh/ND5xxVl4crYV4Gwv6MQiOWdkEBfd0iDlGd2bcCn+k1JvSlS3rLa0d1SfMn0ZYrnR8Bb0kmwUoTMrUC0rntE7Cp1v+QuqytM=
Received: from SJ4PPFEA6F74CA2.namprd18.prod.outlook.com
 (2603:10b6:a0f:fc02::f4b) by LV3PR18MB6207.namprd18.prod.outlook.com
 (2603:10b6:408:275::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Mon, 22 Sep
 2025 11:48:54 +0000
Received: from SJ4PPFEA6F74CA2.namprd18.prod.outlook.com
 ([fe80::2a2c:7ed8:2041:544b]) by SJ4PPFEA6F74CA2.namprd18.prod.outlook.com
 ([fe80::2a2c:7ed8:2041:544b%4]) with mapi id 15.20.9137.012; Mon, 22 Sep 2025
 11:48:54 +0000
From: Vamsi Krishna Attunuru <vattunuru@marvell.com>
To: fengchengwen <fengchengwen@huawei.com>, "dev@dpdk.org" <dev@dpdk.org>,
 "anatoly.burakov@intel.com" <anatoly.burakov@intel.com>
CC: "thomas@monjalon.net" <thomas@monjalon.net>, "bruce.richardson@intel.com"
 <bruce.richardson@intel.com>, "vladimir.medvedkin@intel.com"
 <vladimir.medvedkin@intel.com>, "anatoly.burakov@intel.com"
 <anatoly.burakov@intel.com>,
 "kevin.laatz@intel.com" <kevin.laatz@intel.com>,
 Jerin Jacob <jerinj@marvell.com>
Subject: RE: [EXTERNAL] Re: [RFC] lib/dma: introduce inter-process and
 inter-OS DMA
Thread-Topic: [EXTERNAL] Re: [RFC] lib/dma: introduce inter-process and
 inter-OS DMA
Thread-Index: AQHcGzy5YkOIwkQZ3keJnCVDiFvIxLSaUdWAgATUAxA=
Date: Mon, 22 Sep 2025 11:48:53 +0000
Message-ID: <SJ4PPFEA6F74CA2394BA7980AD7F285110BA612A@SJ4PPFEA6F74CA2.namprd18.prod.outlook.com>
References: <20250901123341.2665186-1-vattunuru@marvell.com>
 <c366cdab-1538-4f70-8854-38f099b8990a@huawei.com>
In-Reply-To: <c366cdab-1538-4f70-8854-38f099b8990a@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ4PPFEA6F74CA2:EE_|LV3PR18MB6207:EE_
x-ms-office365-filtering-correlation-id: fc33b4df-e209-42ae-3efc-08ddf9ce0184
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?dGRjUnVSSWlkbDcrOHJ5RmNTMzcyaXRWK1FoMUJCN0VSb3lNWG1DcVJtQUxT?=
 =?utf-8?B?dWV2ZGtHVyszZHlZbnFJZVNEQ0h0NkR0RXl5QXJ1RzJTQ0dkUnIrb2NLNE1G?=
 =?utf-8?B?djZJZkgzM0FtZEdTZkRQaGhMK1A4aG1STDlTaUt3MG94V1RCcmdsM0paL3hK?=
 =?utf-8?B?TFZRc2lXVkJOQ1ZpcFQ3dnFtLzE5VG1kNFI5OEVGaWh0MkxxbFhXZ21tTmlq?=
 =?utf-8?B?UjJYNG1JL2xVYlN2Yk1GcXk5VFlTSjBtOWg4WnI5b0x1ZWVGenBWcWFqaFA5?=
 =?utf-8?B?TlVmQlM1RHNjMEVEdWxSeTJsUEdrc3MwdmFWLzQxY252bktzNFdBLzFoYTFy?=
 =?utf-8?B?bXQ5VldZdDR3eEw3WHVoOGpiTlZwSG00Qnc4RWF5a2FWRkVTeldNTVErYW9Z?=
 =?utf-8?B?a2ZsTjhwd1N1WThKNS83QnFzMXkzU0RtSk9IQWlNT2lOd1FFVmcwSTBCK0JX?=
 =?utf-8?B?MS81MG5wY1draEVseXlwK0dVYUkzejBUQVpVazdEOTNQeDdJN0JzZVovcUUr?=
 =?utf-8?B?UUJsOFB0TXlxSHF6dEJBNTNpU3pTbktRZzB1OFJsblJVT2tYNUp5SVNQQUZL?=
 =?utf-8?B?ZlJ0SFVVb3BuY2JKaWU2YlB6VHovV0hWajdvQzdUYVhMazMzOHhIY1UrQ1lP?=
 =?utf-8?B?VjlCS1Q0a0xiTjJMRGxrWTNUdEtMQkFSVDQrTDlzL2hDVkVtUzBIb0drQzRt?=
 =?utf-8?B?SERLeGFwUU1DbXV2a3FWNWpjYUZVNWcwdzQvakNHaGppKzlqcDRiWjk4bUk0?=
 =?utf-8?B?SVRKTEhrbW5lS1AyQ01YeXpPY3EvSFhRRC9nTHIvUmlOQW94UjI1UGVNTGpZ?=
 =?utf-8?B?dSthVTY2bjByK1pESXo5R3NlQkRaQlBFOFpBUCtNaTBaVFd6TkRXa0Nxb1pD?=
 =?utf-8?B?RCtKcmdGeGcxcmMzZDl5ektsSXdvWmkvQWpoN3kxNjdFMmsySmJyTjJ2VU51?=
 =?utf-8?B?dUwzM2R3Vm9lajJUYml5UVBqcTU3L3hNckorLzZOUEV2NEErWmcvc2JycW13?=
 =?utf-8?B?MC9KVjExcmJvQzA3cDJRM1FHUC9RcTNrOUk4Smc5cnp3VlFTcGxIbkRsR2Nx?=
 =?utf-8?B?UTBNcGF5WkFWcGYxc3dURWZBejV3Rzh3bFhNbjh1TSttMjB3cHYzaG5tbEZw?=
 =?utf-8?B?dnBhd0pId3g5M0tGZHZGR3IzYktrTkNTZ1p1N0E4eTk2Z1Z6WVJGRmlPNzg1?=
 =?utf-8?B?RlV5QS9mSGh4ZVorbzlHbnM5Sy82UzdJVTJaYTd6SU96SXpoeDZiVWg0TUtH?=
 =?utf-8?B?a2ZMY3Boa0dKYWFkZ3k4TXhMRTRFM00zRHhLa0J6YmJpeXlLbW5XbGpDNDEw?=
 =?utf-8?B?K3hpbHI1WlZiWEFtTjlpVktCeWZaZEJWTzZqWnhTL3VvVE9GMzNtMkhYNno2?=
 =?utf-8?B?YlByYVhWV1dnWVdjeUU5VlUzSjN5RFZFbHNBY2RUeHZuelZDa3NoV0FibVRS?=
 =?utf-8?B?cStWMGhqL05YWWJ2VkxreGhQb2ticG4wRWdjNUhxcjI3WlFnMzNwZzJUTnpr?=
 =?utf-8?B?VDZDNis0cnRBQmJ5OFR4Q2Q3UVZsWHo1ZjFnRWhuL3VjQUFYd1B5VFVVK2E1?=
 =?utf-8?B?d09YQkUzVFpHOWtzcUFjTVhpclcyWDY3c0JBbmh6aUN6aGxEV0RrZDRXYy9P?=
 =?utf-8?B?UERCMEJxVkV1aDNxV0VOUW1kL1cya2haQkU3WWtRZ0V0Y2lCRUU1cnRtdVlp?=
 =?utf-8?B?T2FpOWF2OGFJVzFVdUd1MnV0eXVjdDRZZlJnQ0ZTY2grVXAwNTdISmVSZkZs?=
 =?utf-8?B?T2dIcVpXSEVGRGs1ZFJHUnNIclp6M2VjdlZEYTBXUGlKYzBXKzJtV0ZOYUJT?=
 =?utf-8?B?QXFPRGZlb2wwdEN0eVN6MjZGN2IvVlZMcWljQ0hSd1N0azJyZCtmUzhJclJD?=
 =?utf-8?B?ekZDczJUSm9qZWF5VmZoUUdNNTRlWjZzY1QyWnlxblU3RHBvbnRWaVl0QU12?=
 =?utf-8?Q?YG2F0rz3bMPNC+Nwt2vzj2asgc3pKQF1?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ4PPFEA6F74CA2.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QlYzQWZvSGlENHh5RUEzV3JtTnJoQVp1blRmN1hoOWJBczFHVm4zSkxJbTE1?=
 =?utf-8?B?UXExeDZSVHRTczFXOWgvdHdHRGJlSG50ak5uMUVqN3BZQytTU05QTkJ2K3Ro?=
 =?utf-8?B?amt5TVZHQWRpbEVLK0RURlg4d0dBcHZTMjRDR3Q5MWRNNDNKbWROdUg3VTc0?=
 =?utf-8?B?UWdmZFcrR0ZTNk9Xb21tdTB2VTVZVnFqSm9aTktWbWtYZGJ1d0drejhsdFFo?=
 =?utf-8?B?czJxMG1nNThlMkVwbHRzc2dNUVFmcFFUajhscG1VSEVKZmMzalV6MC9OWi9T?=
 =?utf-8?B?TUxOYmdERE1FM3FPYVNmNnZTLzRnVEwzUi96L29GNFRhcFRQakh0MkZIK3lm?=
 =?utf-8?B?T25OWTQrd0pjNGRnWGpsVHpzTm1MRFkwRG5RUDNiUHVrSGx2bWlUaDlZZ0tj?=
 =?utf-8?B?dlVUMHhtYTlNempoN0t3NVZmYmRCWk9EdExXaGxZUHdiTmNBR2tYVEVyT1o1?=
 =?utf-8?B?cFRDWWxEaUZXZUVFMGpnL3VXZzdWTHk2VnNXdUJvbW1jLzAzR1hJU2kyZjZ2?=
 =?utf-8?B?aS9SekU3QWJtOGVEZVZGdWY3Q1V6eS9obzR1R3dJZGlTQnB5L3lqWWlUbHl0?=
 =?utf-8?B?TkdpblJMcy91R1MxQkdnR3d1Y3BvK2drYTE4SFhXbzNjMktBbEtxQTEvdm80?=
 =?utf-8?B?c3pXZ3lweG51UWlZVnNGMTdJZVZzR3prVHBXVU1rVkZGeXMrelUvbEVVejRl?=
 =?utf-8?B?VmdQRUpxSlhSMXZxeWxEWk85VGxuZU1ObUdnTzVBczlVVmc3dFp6WVpRWExt?=
 =?utf-8?B?b3dxWGpWcWovNHdrbFg3ZVVJMkJFQTdlbThnNU1DblpSL1lRUFRoUUR4eU1Y?=
 =?utf-8?B?L3pLaU9XKzRlTGtFMW43ZTU0UjlEZGp6RGd2c2ZsZkRxVHVnUXMyN3k2MHpx?=
 =?utf-8?B?cm5vSVFDamFkSWZJS3MyYnY3d0ZzNCswdUh3RHNnVy9JR1B5aTU5M24wbFE4?=
 =?utf-8?B?dWJ2ZkxrUnFsZmtNbkVZRnluMmlEblE0M2c4eFBtaDNkdXdtc3FsVG9LMnl6?=
 =?utf-8?B?NElmaGZUNjVVb0kzTHJUYURBOUdkS3QrQnJiRWs5dTdlVkdobUxySlYrekEy?=
 =?utf-8?B?MC9GL1dkZ2lid1E0UHYyVUw3NG5jbGJQVDFLRDF6Rkdpa2VGb1YybzZpak8y?=
 =?utf-8?B?WHFYUEcvZ2xObUErb01WM09KZlpyNUFhblpoTTEyZHNyLzV3VjdyeUZhZnNT?=
 =?utf-8?B?aXljQm5tT2V3cHRXR09ZQnMyakNqajdWRWlHRW1BS3h4b09FcXRNUkgvMk40?=
 =?utf-8?B?WloyYmxnZGZtdUV5UVlZcGZ4RDlHVUhoTDJUd1NxSE9nQ1BOMWdQdEpHZTE0?=
 =?utf-8?B?K1FDbW5qTlcrTFFvUVcrNERraXBLU2Zaczl5T2NqYXI3bXA0T2JpK2FYZ0Zi?=
 =?utf-8?B?dmwwNnZBMFdoNnhsY0tiY1lmNlJHUXdYV1JvdWJ0RTVSeGR1WS9EbkI2NE9Y?=
 =?utf-8?B?NHh2c0F1ZXZHdUNnRHB2UjhjREFLNG16R3hzOGdVUkJ1bEc5RXZWRGlneWJX?=
 =?utf-8?B?aEp0ZlJpYlJpeFYxUlBoa2dFMHdDeit6YzVPbm5iV3FMdVZCdktIaVk0M1Z6?=
 =?utf-8?B?TkFFQk45VWdwUktGeThGMHZ6R0tkK0p1Z0orVUNUOGxoMDY2NFFrc1c4dWQr?=
 =?utf-8?B?S1VBVmhSWWVlWlRQMDY2eWdUZ0YrRTRvL2I0YmQ0bnJSZDVWNjFxT2puQ0lk?=
 =?utf-8?B?OUNHNWlOa1hPWkdDeE85a3BZUm53YWU3SVVtblpLYzc3em1vdkxuQTArOVJP?=
 =?utf-8?B?bDNKQWhoZUx3VWVueDQ4QmFYVDFyMkttaDJneWJQbENRb3lpUFdFakY1aHR3?=
 =?utf-8?B?NC9jcGJWcTJVZ1BDank3dWJJUFNMdVlMUDl2M1JaWnhMSEJYQlpvN1U5OW04?=
 =?utf-8?B?enU4bS9ucExSMHdyTTZlNnhPZVF3d2NXSEI5VDA5QVRQNE1keGdpQWg2dlRD?=
 =?utf-8?B?Tzd3bG55M000S1F5cFRvOVA0S015VC9VQ1dDbkwvelJhT0xVeTZZUldpL0Vr?=
 =?utf-8?B?c3FvdlAyKzJqWnk3WDUweDVmNkRTcjl2b3hJdjY2L21HTW9BVFNTbHM1MHhS?=
 =?utf-8?B?dGUweWdZeWJ3SFdoY0QyakJidmxvU0MyTzFXTnFwajRnRWs0YUdQYzBBWlhY?=
 =?utf-8?Q?Kj+8FXv7ivQ5VI1Vs5/rpTAKi?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ4PPFEA6F74CA2.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc33b4df-e209-42ae-3efc-08ddf9ce0184
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2025 11:48:53.9895 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MV//Y8sQ2nYIYhrPOXXitbx1kBonTuyg2twLoy4A8t81bsUwbiQlAOjtAYz9RGWIqEUc5PY6EpVcWY6Q0eWAHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR18MB6207
X-Proofpoint-GUID: iVFsTkrTVJJJ8ZQjY9_7GKVnPZvpT9lf
X-Authority-Analysis: v=2.4 cv=Nt7Rc9dJ c=1 sm=1 tr=0 ts=68d137aa cx=c_pps
 a=kzlga8Pj6Xs+ezKxcisf3A==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=-AAbraWEqlQA:10
 a=RpNjiQI2AAAA:8 a=M5GUcnROAAAA:8 a=jviKVZdUj5MQZ8q-ytYA:9 a=QEXdDO2ut3YA:10
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: iVFsTkrTVJJJ8ZQjY9_7GKVnPZvpT9lf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIyMDA5NCBTYWx0ZWRfX0Su/y18mj8dI
 fG+AM80y5xBVBI7x6GsumayTJu3pnKNTENOLbLV1ZavFTMU+vyKAjaSgVPkKRInOyf2tflNXq3W
 QnUn7neG+Zw5Yb2M0FsEo53NB+ZOQrlj3LMZuWtFdjvWx5EJK22YOZdIs9N0EpbkeHKuyaVNopR
 D3SrqFUnhRLVR1u/7W1IW88Bb+p9xd4xR4A+i/CDfCWwFGX1foHaMr+sw7QeeV2fQUECpcspTkU
 c73erA4JCnA44l3xTZKpVkTxw3tDvvsjK5mGa+5ZEiUu6EJoIoXfChEaktiufjtj8DEgMcCgaIu
 OatWdt5yERYCAmJjSLKKNQ5Wy/db0SzhtAP3V/E1Z3MlP6Q7muQlUYGXmPJqN+ez1fiBPrKqjl8
 CAloWCGq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-22_01,2025-09-22_01,2025-03-28_01
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

SGkgRmVuZywNCg0KPkhpIFZhbXNpLCBUaGlzIGNvbW1pdCBjaGFuZ2UgaXMgbW9yZSB0aGFuIGRp
c2N1c3NlZCwgaXQgYWRkIGNvbnRyb2wgQVBJIHdoaWNoDQo+Zm9yIGdyb3VwIG1hbmFnZW1lbnQu
IDEuIENvbnRyb2wgQVBJOiBJIGNoZWNrIHRoaXMgY29tbWl0IGFuZCBJbnRlbCBjb21taXQNCj5b
MV0sIGl0IHNlZW0gaGFzIGEgcXVpdGUgZGlmZmVyZW5jZS4gSSBob3BlIEludGVsIGd1eXMgY2Fu
IGV4cHJlc3Mgdmlld3MuIEkNCj5wcmVmZXIgbm90IGFkZCBaalFjbVFSWUZwZnB0QmFubmVyU3Rh
cnQgUHJpb3JpdGl6ZSBzZWN1cml0eSBmb3IgZXh0ZXJuYWwNCj5lbWFpbHM6DQo+Q29uZmlybSBz
ZW5kZXIgYW5kIGNvbnRlbnQgc2FmZXR5IGJlZm9yZSBjbGlja2luZyBsaW5rcyBvciBvcGVuaW5n
DQo+YXR0YWNobWVudHMgPGh0dHBzOi8vdXMtcGhpc2hhbGFybS0NCj5ld3QucHJvb2Zwb2ludC5j
b20vRVdUL3YxL0NSVm1Ya3FXIXRnM1Q5Wi0NCj5VYUI5UTNrd2NtWDA3YlFodzc5dFY2bWx3bHJP
YjluM3ZJYWpGanhKNXNSQy0NCj5OejduNGlyZ1k3VGRIeVI5eUZkcUpMc0RoUWRFTi1LZjNUNE5w
a0Z2UlZ4OF9URSQ+DQo+UmVwb3J0IFN1c3BpY2lvdXMNCj4NCj5aalFjbVFSWUZwZnB0QmFubmVy
RW5kDQo+SGkgVmFtc2ksDQo+DQo+VGhpcyBjb21taXQgY2hhbmdlIGlzIG1vcmUgdGhhbiBkaXNj
dXNzZWQsIGl0IGFkZCBjb250cm9sIEFQSSB3aGljaCBmb3IgZ3JvdXANCj5tYW5hZ2VtZW50Lg0K
Pg0KPjEuIENvbnRyb2wgQVBJOiBJIGNoZWNrIHRoaXMgY29tbWl0IGFuZCBJbnRlbCBjb21taXQg
WzFdLCBpdCBzZWVtIGhhcyBhIHF1aXRlDQo+ZGlmZmVyZW5jZS4NCj4gICBJIGhvcGUgSW50ZWwg
Z3V5cyBjYW4gZXhwcmVzcyB2aWV3cy4gSSBwcmVmZXIgbm90IGFkZCB0aGlzIHBhcnQgaWYgbm8g
cmVzcG9uc2UuDQoNClRoaXMgbmV3IGZlYXR1cmUgbmVlZHMgdG8gYmUgc2VjdXJlbHkgbWFuYWdl
ZCB0aHJvdWdoIGNvbnRyb2wgQVBJcy4gSXQgd291bGQgYmUNCmV4dHJlbWVseSBoZWxwZnVsIGlm
IHRoZSBmb2xrcyBhdCBJbnRlbCBhbmQgeW91IGFzIHdlbGwgY291bGQgcHJvdmlkZSBzdXBwb3J0
IG9yIGlucHV0cw0Kb24gdGhpcy4NCg0KPg0KPjIuIERhdGEgQVBJOiB0aGlzIGNvbW1pdCBwcm92
aWRlIHR3byB3YXkgKHZjaGFuIGFuZCBmbGFncykgdG8gdXNlIHRoaXMgZmVhdHVyZSwNCj5JJ2Qg
cmF0aGVyDQo+ICAgc3RpY2sgdG8gb25lLCB0aGF0IHdheSwgc28gdGhlIGFwcCB3b24ndCBnbyBo
YXl3aXJlLg0KPg0KPiAgIFRoZSB2Y2hhbiBzY2hlbWUgc2VlbXMgaW5mbGV4aWJsZS4gSWYgeW91
IHdhbnQgdG8gdXBkYXRlIGNvbW11bmljYXRpb24NCj5vYmplY3RzIGZyZXF1ZW50bHkNCj4gICBk
dXJpbmcgb3BlcmF0aW9uLCB0aGUgdmNoYW4gbmVlZHMgdG8gYmUgcmVjcmVhdGVkLg0KDQpUaGUg
dmNoYW4gbWVjaGFuaXNtIGV4dGVuZHMgc3VwcG9ydCBmb3IgYW55IFBNRCB0aGF0IG1heSByZXF1
aXJlIGFueSBvdGhlcg0KYWRkaXRpb25hbCBtZXRhZGF0YSAocGFzaWQsIHN0cmVhbUlEIGV0Yykg
LS1zcGVjaWZpYyB0byBjZXJ0YWluIGFyY2hpdGVjdHVyZXMuIEhvd2V2ZXIsDQp0aGUgZmxhZ3Mg
ZmllbGQgdG8gYmUgZnVsbHkgdXRpbGl6ZWQsIGFuZCBtYXkgbm90IGFjY29tbW9kYXRlIGZ1cnRo
ZXIgZXh0ZW5zaW9ucyBpZiB2Y2hhbg0KbmVlZHMgdG8gY2FycnkgbW9yZSBpbmZvcm1hdGlvbi4N
Cg0KPg0KPiAgIEkgcHJlZmVyIHJlc2VydmVkIDE2Yml0IGZyb20gZmxhZ3MgKG5vdCAzMmJpdCBi
ZWNhdXNlIGl0IHNlZW0gaGFzIG5vIHN1Y2gNCj5yZXF1aXJlbWVudCkuDQoNCjE2Yml0cyBmb3Ig
Ym90aCBoYW5kbGVzIG1heSBiZSB0b28gbGltaXRpbmcgLCBlc3BlY2lhbGx5IGlmIFBNRCByZXF1
aXJlcyBhIGxhcmdlciBpZGVudGlmaWVyIGluIHRoZSBmdXR1cmUuDQo+DQo+WzFdIGh0dHBzOi8v
dXJsZGVmZW5zZS5wcm9vZnBvaW50LmNvbS92Mi91cmw/dT1odHRwcy0NCj4zQV9fbWFpbHMuZHBk
ay5vcmdfYXJjaGl2ZXNfZGV2XzIwMjMtDQo+MkRBdWd1c3RfMjc0NTkwLmh0bWwmZD1Ed0lDYVEm
Yz1uS2pXZWMyYjZSMG1PeVBhejd4dGZRJnI9V2xscllhDQo+dW1Wa3hhV2pnS3RvNkVfcnREUXNo
aEloaWsyamt2ekZ5UmhXOCZtPWx1Q2hRSUZiNG1ocDQ2V0R1UHNULQ0KPmxXdGw2UFdpMy05ZVVF
VE5CM1FLTlA3eHBLQjZYV0htekVqeDJTQS0NCj5vWGkmcz14MmJmZXRyeXV4OGJEcldwRzJLbkI5
RGY0YWJDQVFuU1V5MkNFcFVURHRBJmU9DQo+DQo+VGhhbmtzDQo+DQo+T24gOS8xLzIwMjUgODoz
MyBQTSwgVmFtc2kgS3Jpc2huYSB3cm90ZToNCj4+IEZyb206IFZhbXNpIEF0dHVudXJ1IDx2YXR0
dW51cnVAbWFydmVsbC5jb20+DQo+Pg0KPj4gTW9kZXJuIERNQSBoYXJkd2FyZSBzdXBwb3J0cyBk
YXRhIHRyYW5zZmVycyBiZXR3ZWVuIG11bHRpcGxlIERNQQ0KPj4gZGV2aWNlcywgZmFjaWxpdGF0
aW5nIGRhdGEgY29tbXVuaWNhdGlvbiBhY3Jvc3MgaXNvbGF0ZWQgZG9tYWlucywNCj4+IGNvbnRh
aW5lcnMsIG9yIG9wZXJhdGluZyBzeXN0ZW1zLiBUaGVzZSBETUEgdHJhbnNmZXJzIGZ1bmN0aW9u
IGFzDQo+PiBzdGFuZGFyZCBtZW1vcnktdG8tbWVtb3J5IG9wZXJhdGlvbnMsIGJ1dCB3aXRoIHNv
dXJjZSBvciBkZXN0aW5hdGlvbg0KPj4gYWRkcmVzc2VzIHJlc2lkaW5nIGluIGRpZmZlcmVudCBw
cm9jZXNzIG9yIE9TIGFkZHJlc3Mgc3BhY2UuIFRoZQ0KPj4gZXhjaGFuZ2Ugb2YgdGhlc2UgYWRk
cmVzc2VzIGJldHdlZW4gcHJvY2Vzc2VzIGlzIGhhbmRsZWQgdGhyb3VnaA0KPj4gcHJpdmF0ZSBk
cml2ZXIgbWVjaGFuaXNtLCB3aGljaCBhcmUgYmV5b25kIHRoZSBzY29wZSBvZiB0aGlzDQo+PiBz
cGVjaWZpY2F0aW9uIGNoYW5nZS4NCj4+DQo+PiBUaGlzIGNvbW1pdCBpbnRyb2R1Y2VzIG5ldyBj
YXBhYmlsaXR5IGZsYWdzIHRvIGFkdmVydGlzZSBkcml2ZXINCj4+IHN1cHBvcnQgZm9yIGludGVy
LXByb2Nlc3Mgb3IgaW50ZXItT1MgRE1BIHRyYW5zZmVycy4gSXQgcHJvdmlkZXMgdHdvDQo+PiBt
ZWNoYW5pc21zIGZvciBzcGVjaWZ5aW5nIHNvdXJjZSBhbmQgZGVzdGluYXRpb24gaGFuZGxlcnM6
IGVpdGhlcg0KPj4gdGhyb3VnaCB0aGUgdmNoYW4gY29uZmlndXJhdGlvbiBvciB2aWEgdGhlIGZs
YWdzIHBhcmFtZXRlciBpbiBETUENCj4+IGVucXVldWUgQVBJcy4gVGhpcyBjb21taXQgYWxzbyBh
ZGRzIGEgY29udHJvbGxlciBJRCBmaWVsZCB0byBzcGVjaWZ5DQo+PiB0aGUgZGV2aWNlIGhpZXJh
cmNoeSBkZXRhaWxzIHdoZW4gYXBwbGljYWJsZS4NCj4+DQo+PiBUbyBlbnN1cmUgc2VjdXJlIGFu
ZCBjb250cm9sbGVkIERNQSB0cmFuc2ZlcnMsIHRoaXMgY29tbWl0IGFkZHMgYSBzZXQNCj4+IG9m
IEFQSXMgZm9yIGNyZWF0aW5nIGFuZCBtYW5hZ2luZyBhY2Nlc3MgZ3JvdXBzLiBEZXZpY2VzIGNh
biBjcmVhdGUgb3INCj4+IGpvaW4gYW4gYWNjZXNzIGdyb3VwIHVzaW5nIHRva2VuLWJhc2VkIGF1
dGhlbnRpY2F0aW9uLCBhbmQgb25seQ0KPj4gZGV2aWNlcyB3aXRoaW4gdGhlIHNhbWUgZ3JvdXAg
YXJlIHBlcm1pdHRlZCB0byBwZXJmb3JtIERNQSB0cmFuc2ZlcnMNCj4+IGFjcm9zcyBwcm9jZXNz
ZXMgb3IgT1MgZG9tYWlucy4gVGhpcyBhcHByb2FjaCBlbmhhbmNlcyBzZWN1cml0eSBhbmQNCj4+
IGZsZXhpYmlsaXR5IGZvciBhZHZhbmNlZCBETUEgdXNlIGNhc2VzIGluIG11bHRpLXRlbmFudCBv
ciB2aXJ0dWFsaXplZA0KPmVudmlyb25tZW50cy4NCj4+DQo+PiBUaGUgZm9sbG93aW5nIGZsb3cg
ZGVtb25zdHJhdGVzIGhvdyB0d28gcHJvY2Vzc2VzIChhIGdyb3VwIGNyZWF0b3IgYW5kDQo+PiBh
IGdyb3VwIGpvaW5lcikgdXNlIHRoZSBETUEgYWNjZXNzIGdyb3VwIEFQSXMgdG8gc2VjdXJlbHkg
c2V0IHVwIGFuZA0KPj4gbWFuYWdlIGludGVyLXByb2Nlc3MgRE1BIHRyYW5zZmVyczoNCj4+DQo+
PiAxKSBQcm9jZXNzIDEgKEdyb3VwIENyZWF0b3IpOg0KPj4gICAgQ2FsbHMgcnRlX2RtYV9hY2Nl
c3NfZ3JvdXBfY3JlYXRlKGdyb3VwX3Rva2VuLCAmZ3JvdXBfaWQpIHRvIGNyZWF0ZSBhDQo+PiAg
ICBuZXcgYWNjZXNzIGdyb3VwLg0KPj4gICAgU2hhcmVzIGdyb3VwX2lkIGFuZCBncm91cF90b2tl
biB3aXRoIFByb2Nlc3MgMiB2aWEgSVBDLg0KPj4gMikgUHJvY2VzcyAyIChHcm91cCBKb2luZXIp
Og0KPj4gICAgUmVjZWl2ZXMgZ3JvdXBfaWQgYW5kIGdyb3VwX3Rva2VuIGZyb20gUHJvY2VzcyAx
Lg0KPj4gICAgQ2FsbHMgcnRlX2RtYV9hY2Nlc3NfZ3JvdXBfam9pbihncm91cF9pZCwgZ3JvdXBf
dG9rZW4pIHRvIGpvaW4gdGhlDQo+PiAgICBncm91cC4NCj4+IDMpIEJvdGggUHJvY2Vzc2VzOg0K
Pj4gICAgVXNlIHJ0ZV9kbWFfYWNjZXNzX2dyb3VwX3NpemVfZ2V0KCkgdG8gY2hlY2sgdGhlIG51
bWJlciBvZiBkZXZpY2VzIGluDQo+PiAgICB0aGUgZ3JvdXAuDQo+PiAgICBVc2UgcnRlX2RtYV9h
Y2Nlc3NfZ3JvdXBfZ2V0KCkgdG8gcmV0cmlldmUgdGhlIGdyb3VwIHRhYmxlIGFuZA0KPj4gICAg
aGFuZGxlciBpbmZvcm1hdGlvbi4NCj4+DQo+PiAgICBQZXJmb3JtIERNQSB0cmFuc2ZlcnMgYXMg
bmVlZGVkLg0KPj4NCj4+IDQpIFByb2Nlc3MgMiAod2hlbiBkb25lKToNCj4+ICAgIENhbGxzIHJ0
ZV9kbWFfYWNjZXNzX2dyb3VwX2xlYXZlKGdyb3VwX2lkKSB0byBsZWF2ZSB0aGUgZ3JvdXAuDQo+
PiA1KSBQcm9jZXNzIDE6DQo+PiAgICBSZWNlaXZlcyBSVEVfRE1BX0VWRU5UX0FDQ0VTU19UQUJM
RV9VUERBVEUgdG8gYmUgbm90aWZpZWQgb2YNCj5ncm91cA0KPj4gICAgY2hhbmdlcy4NCj4+ICAg
IFVzZXMgcnRlX2RtYV9hY2Nlc3NfZ3JvdXBfc2l6ZV9nZXQoKSB0byBjb25maXJtIHRoZSBncm91
cCBzaXplLg0KPj4NCj4+IFRoaXMgZmxvdyBlbnN1cmVzIG9ubHkgYXV0aGVudGljYXRlZCBhbmQg
YXV0aG9yaXplZCBkZXZpY2VzIGNhbg0KPj4gcGFydGljaXBhdGUgaW4gaW50ZXItcHJvY2VzcyBv
ciBpbnRlci1PUyBETUEgdHJhbnNmZXJzLCBlbmhhbmNpbmcNCj4+IHNlY3VyaXR5IGFuZCBpc29s
YXRpb24uDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogVmFtc2kgQXR0dW51cnUgPHZhdHR1bnVydUBt
YXJ2ZWxsLmNvbT4NCj4+IC0tLQ0KPj4gIGxpYi9kbWFkZXYvcnRlX2RtYWRldi5jICAgICAgIHwg
MzIwDQo+KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPj4gIGxpYi9kbWFkZXYv
cnRlX2RtYWRldi5oICAgICAgIHwgMjU1ICsrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPj4g
IGxpYi9kbWFkZXYvcnRlX2RtYWRldl9wbWQuaCAgIHwgIDQ4ICsrKysrDQo+PiAgbGliL2RtYWRl
di9ydGVfZG1hZGV2X3RyYWNlLmggfCAgNTEgKysrKysrDQo+PiAgNCBmaWxlcyBjaGFuZ2VkLCA2
NzQgaW5zZXJ0aW9ucygrKQ0KPj4NCj4NCj4uLi4NCg0K
