Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66564CD342C
	for <dpdk-dev@archiver.kernel.org>; Mon,  4 May 2026 11:28:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 41B95402B2;
	Mon,  4 May 2026 13:28:16 +0200 (CEST)
Received: from mx0b-00154904.pphosted.com (mx0b-00154904.pphosted.com
 [148.163.137.20])
 by mails.dpdk.org (Postfix) with ESMTP id 918714029B
 for <dev@dpdk.org>; Mon,  4 May 2026 13:28:15 +0200 (CEST)
Received: from pps.filterd (m0170396.ppops.net [127.0.0.1])
 by mx0b-00154904.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 643JwtYB542178; Mon, 4 May 2026 07:28:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=smtpout1; bh=B
 TZV6/nHIVGndrAJirtUxUGg+IhN2nNIdl71EM/UqdU=; b=Va6glsrl7TnUvYvOV
 X88QofLN/5cFhcanv3UXHjGm5oHqU/IxK47CoM2chJQd1jLr1oIycGq9PpByIfh4
 6AYGV5iezV53RFN+7flfA+xN0bNKPN0c1ROgm/EZt1iFd3p8tYID5RzmPEp8HNf7
 6wWXPhtmQ+So2vS2ezs57jjavcg2cLWp7kiNlVukYf0HymUmRVoexHhPTIcB2NEM
 ZXRElU2jylwUxI1I9YooYxLp6hhIiMzto8JerhaPZh8rnIPwt6PEW6ZAWEYAHQ6j
 NhU+S39JzWT3P77O/qnkrYYJVqlfmYkugn1nQtftcADCUVa5R+tD4Rd6agsQGdo6
 1IJwQ==
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com
 [67.231.149.39])
 by mx0b-00154904.pphosted.com (PPS) with ESMTPS id 4dwd3unp91-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 04 May 2026 07:28:14 -0400 (EDT)
Received: from pps.filterd (m0090351.ppops.net [127.0.0.1])
 by mx0b-00154901.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6448Qr5a1395160; Mon, 4 May 2026 07:28:13 -0400
Received: from sn4pr2101cu001.outbound.protection.outlook.com
 (mail-southcentralusazon11012008.outbound.protection.outlook.com
 [40.93.195.8])
 by mx0b-00154901.pphosted.com (PPS) with ESMTPS id 4dxjafndec-2
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
 Mon, 04 May 2026 07:28:13 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=COtySmtdKuTpJUVq8zwbsvNuiX9UovTe+vRwXqV3LG/tGl9HoPibvxuSoJVtCCjol75p5+ipiHz7ivVXCJ0n17bnYCmfGPwGCerehfk4XMzD6+sMO1pwAbhTjre6X1ssIjKbJAO3uHXAInJek6gpu2OiCNnBfjxE8BweIGHhdWMXRRgFJmBNv7w1CcudXIfCg2+eqsCxy06jRFur/8Qxuzz9ZbFjm+1kU+zltor9LI2CW5gUnBCQU6zAJDcRJXXTy94OrAV0EBJTgaI3M2sp1q+fRIzxgbrugYOMvkYDdHpWYtFeWd4UmiuK4xjTJhMKpznZm+G0Vft4QmjzynSLeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BTZV6/nHIVGndrAJirtUxUGg+IhN2nNIdl71EM/UqdU=;
 b=kp1FiZWNd11kkqgdj5jcCEIfaTSjCPykzF/d8956H9uN3zO3PqCLTlP9dVK/yDjBWPR/Z6N8Vn2Kz3xn5fUlRyp4gwNh+hCjHzFSIAOkQ+Z3xAZBLwrSewVe8KQ2HF++bxb8xS3UedpuGvzFPzqFzzr+5IE5USU+jc3z8J04pQt7MBWtPAodOBUZNc6U9uCi6MQhX6zPCyewVgLHV7REEIWvEt8CoJatBVvcK0Z+K8henm+dp6Ln5YiYWUKa2to1kDOvdaEaHjoot91m1CloOFfPnk5JYmMfDoUNuNieuxL6hxsWTdVA4cna8H6EaZmnvDxAZPWKnT2x+KsOybg++Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from DM6PR19MB3564.namprd19.prod.outlook.com (2603:10b6:5:1dc::21)
 by DS6PR19MB997245.namprd19.prod.outlook.com (2603:10b6:8:367::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Mon, 4 May
 2026 11:28:05 +0000
Received: from DM6PR19MB3564.namprd19.prod.outlook.com
 ([fe80::2e01:84e2:ad83:1afb]) by DM6PR19MB3564.namprd19.prod.outlook.com
 ([fe80::2e01:84e2:ad83:1afb%4]) with mapi id 15.20.9870.023; Mon, 4 May 2026
 11:28:05 +0000
From: "Bathija, Pravin" <Pravin.Bathija@dell.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: "dev@dpdk.org" <dev@dpdk.org>, "thomas@monjalon.net" <thomas@monjalon.net>,
 "maxime.coquelin@redhat.com" <maxime.coquelin@redhat.com>,
 "fengchengwen@huawei.com" <fengchengwen@huawei.com>
Subject: RE: [PATCH v9 0/5] Support add/remove memory region and get-max-slots
Thread-Topic: [PATCH v9 0/5] Support add/remove memory region and get-max-slots
Thread-Index: AQHcxmVhNUZdPluV1E6Mg3NnSRxJOLXTps4AgACLzxCAF+QHMIARzKkg
Date: Mon, 4 May 2026 11:28:05 +0000
Message-ID: <DM6PR19MB35644B84B365CBED572CC3AEF5312@DM6PR19MB3564.namprd19.prod.outlook.com>
References: <20260407080636.3878354-1-pravin.bathija@dell.com>
 <20260407072118.341cdd6e@phoenix.local>
 <DM6PR19MB3564A625FEE9BC61A71FFCA5F55AA@DM6PR19MB3564.namprd19.prod.outlook.com>
 <DM6PR19MB3564006D08FDAC801E213299F52A2@DM6PR19MB3564.namprd19.prod.outlook.com>
In-Reply-To: <DM6PR19MB3564006D08FDAC801E213299F52A2@DM6PR19MB3564.namprd19.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Enabled=True;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_SetDate=2026-04-07T22:41:41.0000000Z;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Name=No
 Protection (Label Only) - Internal
 Use; MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_ContentBits=3;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Method=Standard
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR19MB3564:EE_|DS6PR19MB997245:EE_
x-ms-office365-filtering-correlation-id: f7b2786a-bf6a-4b1e-30a5-08dea9d035ae
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|786006|376014|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info: xD8kUuI2svryeHq9u8TdiPibzdSBPTJTNQf0ZYr2p3e+6Vo0JFlh6mx4WLmvLoYxDmtbEKhy1WzmZacjnM7vFX/1+IlJKyfXgDN8F1HuMR1kcgf30jXYPU9dUwvKbeUqsAndRB4z/Oil0WRwlTuM+LzQ4lrfaSP++57ex+bCnAd27u6GKFiVpd+Nu6dfWkMo7LyCm2EbLx6eWfggxKJnIM6J1KBvH4yOV3XzYEPfWhn/RZ7vj+tpTk3lpH302g0P2PTPcD+HPh+AnT8aI+w/4B6v0oIXowOEiCseo7AoIvC1no1rlwKgfGnZHH8Kk0shc3TRpYo38Hf9L2l1YQsT2odZql7BxztzVkHTzU9AsOu/MROs65xUT2VsbvADQsHQJsK9I7IB86wOysZennHsUUwnDA3hjhJDgVVsv4IXMtKp0lglqeTwZ3D5teDHDqefQIbeKXLK+p04U5PI9VVEk7X4b6uTcxUfGSlyf7T/8FH99TpFvH1IDxgfyF0Fp2AX7E4/CRf09izHI9ZRbb4LCv7RLRky4kC2N4UNLmCVFYnqcZeY1EaVKZlhzLriBWDME0WVa39sVvMUzdlGvnZbUlOvnGdu5G4mn9KzxMWO0ytfyR+LOWJIB3sfzTTe6PZayS7M+Aic9geQ8bfE8xhmdCuIsLmD5koZEcQjsC+VZi8vtUyiPkYU232KFYQCPeoSlTWE4ODmUU3Or0V08GwP+vH+ezL1b+s2rHHS9HhX3WNs6fJGIxBEd4a+0FEBoYea
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR19MB3564.namprd19.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(786006)(376014)(38070700021)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VzZCT3lXbFBsYjVpNEhWZWtOajQyc1ZRWE5iQlFJMFJUSjVMazdXU1lQSUlB?=
 =?utf-8?B?SWVVbjFLTUpaTE00c1M3d0pSSExSTjIyM2xmSjZpM2FLYXVXZ3draU9RUnB5?=
 =?utf-8?B?UmxyT0FZUTVmMy9VYU5XSEllaDVEcHdjbHFxMm5ucHhLcWs0SFQ0QkZKNEM2?=
 =?utf-8?B?bnFJU1FzdkluaGFlMjNPMTlEYUtDUUJGMmdZVTVzSkdhdE1qS3Q4bFZhYi8r?=
 =?utf-8?B?UDVjT1hXMnNoWEpmeEZmdnFJbzRFKy9uT1lMRXNOM054VGVyemVqSnFuRUQx?=
 =?utf-8?B?R3MvRWxhQXB6LzNTdVBxeTdKb2xPYU9yakNvOFhVU01maFJKWElyNXJJeTVW?=
 =?utf-8?B?L3NBRUR0OVlyc2NjOURKd3N6NW9pRWFNNlBmNDI1MUtic3F3V2ZYZ2N2eWNY?=
 =?utf-8?B?T1d6Tk9PVmFzUGRzcDJ3eldWWktEMW53UEE3c0FvNVJQRXJHdzZCeFk5R3Ro?=
 =?utf-8?B?SEUyTUNZTnZaNTRlYjc0OS8yVFpEOTZyU3M4NnNONVduOU1VR3VqTHQ1dXpp?=
 =?utf-8?B?YXgzSFQvRTlaZDRKWmQvRDZWQUZjcWRvS2tnaEI0ZkoxaVZHRTdWQmdIOUcz?=
 =?utf-8?B?dmI5SEJxdUVCZFk0Q0w1Q1E1VDJIRXZwVzJRdEVVYkFnNWkydStGcHZnMmVJ?=
 =?utf-8?B?MEVONHZza3NacGlXSHBuTVFhSmx3bEVsNFBjcEhYSXl0dThUODVnOFdkVi8y?=
 =?utf-8?B?K1lxREJXK0MvRC9HVDBtMEdWZ2VtbU5LZlgrYUxRNUFYTGZEaUsyVWJ6dnB1?=
 =?utf-8?B?VG1PMkZnTWFFM3FsQkxydXlXdlB6N29JcFdaeWkwc282NHp0MkhYUEZBLzdN?=
 =?utf-8?B?MWJtdEluWlljMEN1NXRPcGhBN3BIWllRMzR0OTR0MVNHUjBSSXc3am95b2Rq?=
 =?utf-8?B?dytCUG9xT2hFWWJoNm8zcGZqYWs4bmxwTXJWN3NpaTNURStPRlQ3SFdVeFBM?=
 =?utf-8?B?OUpFVm9QKzlsT2orRGtBVDBLSHNSK2FVU25QNEM4V29SWjZnaXNSaU5NVGdE?=
 =?utf-8?B?N2hEdkUrRWcrMU1GNHRQYXpUTWM3WktZbUVHRVFwcWNxRS9qcmlLMGhkaHFh?=
 =?utf-8?B?b0dpVnM3OC9wNzQ0Z3lvUmV0WUpwM2hlVGZrU1gzaUh6OTI3YWdzaFprNDcv?=
 =?utf-8?B?c2VCREFhanBvc0VVeTZ5MXZqVEs0bm00ajZIajlwWHdmZm1vNEQ2M1ArOGlj?=
 =?utf-8?B?MHUvWU1UWm84eHYvYklNK1dkeVFHVzFIWXhWSldEUW9TNkQ1R0dqbWo1MkVR?=
 =?utf-8?B?L3dkY2pEeW5ZRVFtenVKakQ0VWJKVjJReHdweEVBVGpZbXlqV2FzR3p0Z2R6?=
 =?utf-8?B?eVArSTJPdHFwdVMrei9raUJYa2xLa3JwQmQ2TnhJMndQdUNkN1o5WXdtcjh4?=
 =?utf-8?B?VVhJNTRBTFk3cDRidWFadTZJOEpSY0svdG9EL3dFWnJHTmpUOWpBUlZranFL?=
 =?utf-8?B?YjJMaG1ZUndzZDFQallUa00zUnF0NzY0bWcwMDY1YUl3bm5wWGtYUnBZVXdY?=
 =?utf-8?B?YTFWZHowOUpXTTFrNE5QSEdQRUgrYVdvZHhZR1UyVDJFZDlPSDloT3NWQ2l2?=
 =?utf-8?B?Y1NJd21iaWd5Qi90a1lPejB0Uk90QjVWNnRUK01pRElrTy92YXYvaW5qdnZu?=
 =?utf-8?B?VnhkZnB3c1hoaHpjRWhoK2J1SUg5MVJuK2dqWm9UQ1F1WE13T0NDRWVqVUJq?=
 =?utf-8?B?YzBPU3M1RDNwRnF2YlVyNC9KakNNM0RwWXFQeVNVRUZmQ3FMVVlIaUgvOG05?=
 =?utf-8?B?dGowKzBvQ1F3OTdZOGZnME1mNms0cDZzZzYyOVpGR3RCK09kSnM4WTJUTUsw?=
 =?utf-8?B?K2lQbHZXdGd0U0ZSMW9qdEJqUVZSTDE1YXgvVFRwQ2dheHJWalVQODhWSjU3?=
 =?utf-8?B?VUF2VWV4QUtSRkJpWHpVSTBFWkptMHVab0hEL05TRFM3eUtGSitmT2dvU21j?=
 =?utf-8?B?d1VMUHFIU21FWjR1ejIrVSt1c0tLUHN1L1FFM0JQVEpUTjQrdjUvYWhTWFpR?=
 =?utf-8?B?RXJkR2NralQ1Vmx5ZXhHSkNSUkgvVFRZS3BkSTVGMjBySVhCOEhYcGcvRzA4?=
 =?utf-8?B?NnBNY3VRS25pbXhZTXdIV3ltaGtSNS9XR2lkOVRYSWlRNDB0MW1PTW5SZmNm?=
 =?utf-8?B?bDFXMzREWjA0VGFRN2w5Z2F0dFpHb05OZG5ibXVoZmgxbW0zNmpoQzZzZ0hI?=
 =?utf-8?B?Q09ML21mOExJY0xlNGg5dkxzS3F4WWt4bitQY3dlZjZnSGlHS3NBemNRcWlv?=
 =?utf-8?B?dWM5YTUzOUNxUkZJbzU2eS8xejkvMVpzRDFPdzRocWFBdHhIVjJtalRmc05v?=
 =?utf-8?B?R0d5NjFCdGIvSGpVLzAyVldSOXpuRElSZVlTYjk2MEVXbkRMd1dpUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: E/QRUxnPK8Px24WZ+dZ0lazkhOJvVddYD1TvFuw/rE+rRfwVC05UMDcOKZhE5G2z8Is4AYLpB11rx0roFAofwCWhMe/zapVmZETHDgeRzxvZHj3L7cy8GncCj0Jd3WShOO0o7PWNrYs9KS84Y9Q8KMFZZNsFb0lblRQFotOWbxbSLfVzpLbzYs5BC3qfUx23a2Qf0eixerAntHGVLkgOzXGqLObRbruRoStZITBmUAwRP7OHd51plNrzXu+pExGbLb9HDr8vEwuB4x2IHXfXMh2YnG3NhcTyXS7XQ9JVithKkUEjpQL0naGYKfNAl9vIcQupl7GivGVyIsIRJvmU+A==
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR19MB3564.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7b2786a-bf6a-4b1e-30a5-08dea9d035ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2026 11:28:05.1625 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hy6ysxHDMXiqKEcusIhguijCflGq3VJgMcPJEd11sH2F4MUJBA+WLxRDukgiRVr4mUrSwb/294OUpvjqNf0BFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS6PR19MB997245
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-04_04,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 clxscore=1015 bulkscore=0 adultscore=0
 impostorscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605040121
X-Authority-Analysis: v=2.4 cv=DNe/JSNb c=1 sm=1 tr=0 ts=69f882ce cx=c_pps
 a=j0++y401J6f/BxNAf5EDow==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=6gNNCFAoQcIphELLPWWu:22
 a=fe1keu9KhAX5AoWrZvs2:22 a=8rWy6zfcAAAA:8 a=iLNU1ar6AAAA:8 a=jZVsG21pAAAA:8
 a=bt5KbKNvAAAA:8 a=20KFwNOVAAAA:8 a=i0EeH86SAAAA:8 a=vQLWAySDSLBx36eXB8kA:9
 a=QEXdDO2ut3YA:10 a=gbU3OgOOxF9bX48Letew:22 a=YjdVzJdQTyZRADMV7wFX:22
 a=3Sh2lD0sZASs_lUdrUhf:22 a=a-zEBD5cKgE7DNtTSb7C:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA0MDEyMSBTYWx0ZWRfX5EKqdj+R2iw4
 tSeB5hmOHj9ad1zH572g7hBCAzNKWS5tj6rMU+vA3AhLINzuGUx0Q+vp7/eHdGA2JeP0LOEIh1s
 YndLSkj4HSIkveLFbXbGDtWFkIFd2LawRfYad5R+Uc33Vl7O+xUdITvt3EoAnyOWWlgofPNuNRg
 zigAKErldfvX+GJR3lYNcGGuN2jGPEL7rT3q84FSMD1GB+nApxupiGX3fOEXS44dYoQlavL0Q18
 MWqR6zpCp4oghWfXE22kBgOujo2SZ+ftSUhvrEzz1ccCkafZb0dVLRJTFAylxRjSxgP4U+B+yhm
 lysek3LtW+vkhmuIjlwwEhQI3vp3On5o/4QRazx3oKsIfrI0Fpf9XMeetFiilLt7lYRzdhpJLbI
 FmzjX64ZKsfdjTCEGLGJwyJW/aambybnQnayDucNslXuMx0S5P0uMx7HGLOBwRe1D85eyBv5UkP
 pHjSlUxmBhukqbRkN7w==
X-Proofpoint-ORIG-GUID: NQ0YfF0k-xLvpbtL_W7_n-WKDADapRoo
X-Proofpoint-GUID: NQ0YfF0k-xLvpbtL_W7_n-WKDADapRoo
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015
 lowpriorityscore=0 impostorscore=0 malwarescore=0 bulkscore=0 adultscore=0
 priorityscore=1501 phishscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605040121
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

SGkgU3RlcGhlbiwNCg0KSSB3b3VsZCBsaWtlIHRvIGZvbGxvdyB1cCBvbiB2MTAgb2YgdGhlIHBh
dGNoIGFzIEkgZml4ZWQgdGhlIGl0ZW1zIHRoYXQgeW91IGZsYWdnZWQuIEkgaGF2ZSBhbHNvIHRl
c3RlZCB0aGUgcGF0Y2gtc2V0IGFuZCByZWdyZXNzZWQuIEkgYWxzbyBqdXN0IGRlbGVnYXRlZCB0
aGUgcGF0Y2gtc2V0IHRvIHlvdXIgYXR0ZW50aW9uLiBQbGVhc2UgbGV0IG1lIGtub3cgaWYgdGhl
cmUgYXJlIG90aGVyIGl0ZW1zIHRoYXQgbmVlZCBhdHRlbnRpb24uDQoNCmh0dHBzOi8vcGF0Y2hl
cy5kcGRrLm9yZy9wcm9qZWN0L2RwZGsvcGF0Y2gvMjAyNjA0MDcyMjQyMDUuMzkxMDgwMy02LXBy
YXZpbi5iYXRoaWphQGRlbGwuY29tLw0KDQpodHRwczovL3BhdGNoZXMuZHBkay5vcmcvcHJvamVj
dC9kcGRrL3BhdGNoLzIwMjYwNDA3MjI0MjA1LjM5MTA4MDMtNS1wcmF2aW4uYmF0aGlqYUBkZWxs
LmNvbS8NCg0KaHR0cHM6Ly9wYXRjaGVzLmRwZGsub3JnL3Byb2plY3QvZHBkay9wYXRjaC8yMDI2
MDQwNzIyNDIwNS4zOTEwODAzLTQtcHJhdmluLmJhdGhpamFAZGVsbC5jb20vDQoNCmh0dHBzOi8v
cGF0Y2hlcy5kcGRrLm9yZy9wcm9qZWN0L2RwZGsvcGF0Y2gvMjAyNjA0MDcyMjQyMDUuMzkxMDgw
My0zLXByYXZpbi5iYXRoaWphQGRlbGwuY29tLw0KDQpodHRwczovL3BhdGNoZXMuZHBkay5vcmcv
cHJvamVjdC9kcGRrL3BhdGNoLzIwMjYwNDA3MjI0MjA1LjM5MTA4MDMtMi1wcmF2aW4uYmF0aGlq
YUBkZWxsLmNvbS8NCg0KDQpSZWdhcmRzLA0KUHJhdmluDQoNCg0KSW50ZXJuYWwgVXNlIC0gQ29u
ZmlkZW50aWFsDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEJhdGhpamEs
IFByYXZpbg0KPiBTZW50OiBXZWRuZXNkYXksIEFwcmlsIDIyLCAyMDI2IDg6MzcgUE0NCj4gVG86
ICdTdGVwaGVuIEhlbW1pbmdlcicgPHN0ZXBoZW5AbmV0d29ya3BsdW1iZXIub3JnPg0KPiBDYzog
J2RldkBkcGRrLm9yZycgPGRldkBkcGRrLm9yZz47ICd0aG9tYXNAbW9uamFsb24ubmV0Jw0KPiA8
dGhvbWFzQG1vbmphbG9uLm5ldD47ICdtYXhpbWUuY29xdWVsaW5AcmVkaGF0LmNvbScNCj4gPG1h
eGltZS5jb3F1ZWxpbkByZWRoYXQuY29tPjsgJ2ZlbmdjaGVuZ3dlbkBodWF3ZWkuY29tJw0KPiA8
ZmVuZ2NoZW5nd2VuQGh1YXdlaS5jb20+DQo+IFN1YmplY3Q6IFJFOiBbUEFUQ0ggdjkgMC81XSBT
dXBwb3J0IGFkZC9yZW1vdmUgbWVtb3J5IHJlZ2lvbiBhbmQgZ2V0LW1heC0NCj4gc2xvdHMNCj4N
Cj4gRGVhciBTdGVwaGVuLA0KPg0KPiBJIHdhbnRlZCB0byBjaGVjay1pbiBhYm91dCB0aGUgdjEw
IHBhdGNoLXNldCBpZiB0aGVyZSBhcmUgaXRlbXMgdGhhdCBuZWVkDQo+IGF0dGVudGlvbi4gIEFs
c28gc2luY2UgdGhlcmUgYXJlIFNQREsgYW5kIG90aGVyIG9wZW4tc291cmNlIHN0b3JhZ2UgcGF0
Y2hlcw0KPiB0aGF0IGFyZSBkZXBlbmRlbnQgb24gdGhpcyBmZWF0dXJlLCBpdCB3b3VsZCBiZSBn
cmVhdCB0byBoYXZlIHRoaXMgbWVyZ2VkIHNvb24sDQo+IGlmIGV2ZXJ5dGhpbmcgbG9va3MgZ29v
ZC4NCj4NCj4gUmVnYXJkcywNCj4gUHJhdmluDQo+DQo+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdl
LS0tLS0NCj4gPiBGcm9tOiBCYXRoaWphLCBQcmF2aW4NCj4gPiBTZW50OiBUdWVzZGF5LCBBcHJp
bCA3LCAyMDI2IDM6NDQgUE0NCj4gPiBUbzogJ1N0ZXBoZW4gSGVtbWluZ2VyJyA8c3RlcGhlbkBu
ZXR3b3JrcGx1bWJlci5vcmc+DQo+ID4gQ2M6IGRldkBkcGRrLm9yZzsgdGhvbWFzQG1vbmphbG9u
Lm5ldDsgbWF4aW1lLmNvcXVlbGluQHJlZGhhdC5jb207DQo+ID4gZmVuZ2NoZW5nd2VuQGh1YXdl
aS5jb20NCj4gPiBTdWJqZWN0OiBSRTogW1BBVENIIHY5IDAvNV0gU3VwcG9ydCBhZGQvcmVtb3Zl
IG1lbW9yeSByZWdpb24gYW5kDQo+ID4gZ2V0LW1heC0gc2xvdHMNCj4gPg0KPiA+IERlYXIgU3Rl
cGhlbiwNCj4gPg0KPiA+IFRoZSBjaGFuZ2VzIHlvdSBzdWdnZXN0ZWQgaGF2ZSBiZWVuIGluY29y
cG9yYXRlZCBpbiB0aGUgbGF0ZXN0IHBhdGNoLXNldA0KPiB2MTAuDQo+ID4gUmVzcG9uc2VzIHRv
IGNvbW1lbnRzIGlubGluZS4NCj4gPg0KPiA+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0N
Cj4gPiA+IEZyb206IFN0ZXBoZW4gSGVtbWluZ2VyIDxzdGVwaGVuQG5ldHdvcmtwbHVtYmVyLm9y
Zz4NCj4gPiA+IFNlbnQ6IFR1ZXNkYXksIEFwcmlsIDcsIDIwMjYgNzoyMSBBTQ0KPiA+ID4gVG86
IEJhdGhpamEsIFByYXZpbiA8UHJhdmluLkJhdGhpamFAZGVsbC5jb20+DQo+ID4gPiBDYzogZGV2
QGRwZGsub3JnOyB0aG9tYXNAbW9uamFsb24ubmV0OyBtYXhpbWUuY29xdWVsaW5AcmVkaGF0LmNv
bTsNCj4gPiA+IGZlbmdjaGVuZ3dlbkBodWF3ZWkuY29tDQo+ID4gPiBTdWJqZWN0OiBSZTogW1BB
VENIIHY5IDAvNV0gU3VwcG9ydCBhZGQvcmVtb3ZlIG1lbW9yeSByZWdpb24gYW5kDQo+ID4gPiBn
ZXQtbWF4LSBzbG90cw0KPiA+ID4NCj4gPiA+DQo+ID4gPiBbRVhURVJOQUwgRU1BSUxdDQo+ID4g
Pg0KPiA+ID4gT24gVHVlLCA3IEFwciAyMDI2IDA4OjA2OjMxICswMDAwDQo+ID4gPiA8cHJhdmlu
LmJhdGhpamFAZGVsbC5jb20+IHdyb3RlOg0KPiA+ID4NCj4gPiA+ID4gRnJvbTogUHJhdmluIE0g
QmF0aGlqYSA8cHJhdmluLmJhdGhpamFAZGVsbC5jb20+DQo+ID4gPiA+DQo+ID4gPiA+IFRoaXMg
aXMgdmVyc2lvbiB2OSBvZiB0aGUgcGF0Y2hzZXQgYW5kIGl0IGluY29ycG9yYXRlcyB0aGUNCj4g
PiA+ID4gcmVjb21tZW5kYXRpb25zIG1hZGUgYnkgU3RlcGhlbiBIZW1taW5nZXIuDQo+ID4gPiA+
DQo+ID4gPiA+IENoYW5nZXMgbWFkZSB0byBwYXRjaCAzLzUNCj4gPiA+ID4gLSBSZXN0b3JlZCBt
YXhfZ3Vlc3RfcGFnZXMgaW5pdGlhbCB2YWx1ZSB0byBoYXJkY29kZWQgOCBpbnN0ZWFkIG9mDQo+
ID4gPiA+ICAgVkhPU1RfTUVNT1JZX01BWF9OUkVHSU9OUywgbWF0Y2hpbmcgdXBzdHJlYW0gc2Vt
YW50aWNzLg0KPiA+ID4gPg0KPiA+ID4gPiBDaGFuZ2VzIG1hZGUgdG8gcGF0Y2ggNC81DQo+ID4g
PiA+IC0gQWRkZWQgY2xvc2UocmVnLT5mZCkgYW5kIHJlZy0+ZmQgPSAtMSBiZWZvcmUgZ290byBj
bG9zZV9tc2dfZmRzIGluIHRoZQ0KPiA+ID4gPiAgIG1tYXAgZmFpbHVyZSBwYXRoIHRvIGZpeCBm
ZCBsZWFrIGFmdGVyIGZkIHdhcyBtb3ZlZCBmcm9tIGN0eC0+ZmRzWzBdLg0KPiA+ID4gPiAtIENv
bnZlcnRlZCBkZXZfaW52YWxpZGF0ZV92cmluZ3MgZnJvbSBhIHBsYWluIGZ1bmN0aW9uIHRvIGEg
bWFjcm8gKw0KPiA+ID4gPiAgIGltcGxlbWVudGF0aW9uIGZ1bmN0aW9uIHBhaXIsIGFjY2VwdGlu
ZyBtZXNzYWdlIElEIGFzIGEgcGFyYW1ldGVyIHNvDQo+ID4gPiA+ICAgdGhlIHN0YXRpY19hc3Nl
cnQgcmVwb3J0cyB0aGUgY29ycmVjdCBoYW5kbGVyIGF0IGVhY2ggY2FsbCBzaXRlLg0KPiA+ID4g
PiAtIFVwZGF0ZWQgZGV2X2ludmFsaWRhdGVfdnJpbmdzIGNhbGwgaW4gYWRkX21lbV9yZWcgdG8g
cGFzcw0KPiA+ID4gPiAgIFZIT1NUX1VTRVJfQUREX01FTV9SRUcgYXMgbWVzc2FnZSBJRC4NCj4g
PiA+ID4gLSBVcGRhdGVkIGRldl9pbnZhbGlkYXRlX3ZyaW5ncyBjYWxsIGluIHJlbV9tZW1fcmVn
IHRvIHBhc3MNCj4gPiA+ID4gICBWSE9TVF9VU0VSX0FERF9NRU1fUkVHIGFzIG1lc3NhZ2UgSUQu
DQo+ID4gPiA+DQo+ID4gPiA+IFRoaXMgaW1wbGVtZW50YXRpb24gaGFzIGJlZW4gZXh0ZW5zaXZl
bHkgdGVzdGVkIGJ5IGRvaW5nDQo+ID4gPiA+IFJlYWQvV3JpdGUgSS9PIGZyb20gbXVsdGlwbGUg
aW5zdGFuY2VzIG9mIGZpbyArIGxpYmJsa2lvDQo+ID4gPiA+IChmcm9udC1lbmQpIHRhbGtpbmcg
dG8gc3Bkay9kcGRrIChiYWNrLWVuZCkgYmFzZWQgZHJpdmVzLiBUZXN0ZWQNCj4gPiA+ID4gd2l0
aCBxZW11IGZyb250LWVuZCB0YWxraW5nIHRvIGRwZGsgdGVzdHBtZCAoYmFjay1lbmQpIHBlcmZv
cm1pbmcNCj4gPiA+ID4gYWRkL3JlbW92YWwgb2YgbWVtb3J5DQo+ID4gcmVnaW9ucy4NCj4gPiA+
ID4gQWxzbyB0ZXN0ZWQgcG9zdC1jb3B5IGxpdmUgbWlncmF0aW9uIGFmdGVyIGRvaW5nIGFkZF9t
ZW1vcnlfcmVnaW9uLg0KPiA+ID4gPg0KPiA+ID4gPiBWZXJzaW9uIExvZzoNCj4gPiA+ID4gVmVy
c2lvbiB2OSAoQ3VycmVudCB2ZXJzaW9uKTogSW5jb3Jwb3JhdGUgY29kZSByZXZpZXcgc3VnZ2Vz
dGlvbnMNCj4gPiA+ID4gZnJvbSBTdGVwaGVuIEhlbW1pbmdlciBhcyBkZXNjcmliZWQgYWJvdmUu
DQo+ID4gPiA+IFZlcnNpb24gdjg6ICBJbmNvcnBvcmF0ZSBjb2RlIHJldmlldyBzdWdnZXN0aW9u
cyBmcm9tIFN0ZXBoZW4NCj4gSGVtbWluZ2VyLg0KPiA+ID4gPiByZXdyaXRlIGFzeW5jX2RtYV9t
YXBfcmVnaW9uIGZ1bmN0aW9uIHRvIGl0ZXJhdGUgZ3Vlc3QgcGFnZXMgYnkNCj4gPiA+ID4gaG9z
dCBhZGRyZXNzIHJhbmdlIG1hdGNoaW5nIGNoYW5nZSBmdW5jdGlvbiBkZXZfaW52YWxpZGF0ZV92
cmluZ3MNCj4gPiA+ID4gdG8gYWNjZXB0IGEgZG91YmxlIHBvaW50ZXIgdG8gcHJvcGFnYXRlIHBv
aW50ZXIgdXBkYXRlcyBuZXcNCj4gPiA+ID4gZnVuY3Rpb24gcmVtb3ZlX2d1ZXN0X3BhZ2VzIHdh
cyBhZGRlZCBhZGRfbWVtX3JlZyBlcnJvciBwYXRoIHdhcw0KPiA+ID4gPiBuYXJyb3dlZCB0byBv
bmx5IGNsZWFuIHVwIHRoZSBzaW5nbGUgZmFpbGVkIHJlZ2lvbiBpbnN0ZWFkIG9mDQo+ID4gPiA+
IGRlc3Ryb3RpbmcgYWxsIGV4aXN0aW5nIHJlZ2lvbnMgVmVyc2lvbiB2NzogSW5jb3Jwb3JhdGUg
Y29kZQ0KPiA+ID4gPiByZXZpZXcgc3VnZ2VzdGlvbnMgZnJvbSBNYXhpbWUgQ29xdWVsaW4uDQo+
ID4gPiA+IEFkZCBkZWJ1ZyBtZXNzYWdlcyB0byB2aG9zdF9wb3N0Y29weV9yZWdpc3RlciBmdW5j
dGlvbi4NCj4gPiA+ID4gVmVyc2lvbiB2NjogQWRkZWQgdGhlIGVuYWJsZW1lbnQgb2YgdGhpcyBm
ZWF0dXJlIGFzIGEgZmluYWwgcGF0Y2gNCj4gPiA+ID4gaW4gdGhpcyBwYXRjaC1zZXQgYW5kIG90
aGVyIGNvZGUgb3B0aW1pemF0aW9ucyBhcyBzdWdnZXN0ZWQgYnkNCj4gPiA+ID4gTWF4aW1lIENv
cXVlbGluLg0KPiA+ID4gPiBWZXJzaW9uIHY1OiByZW1vdmVkIHRoZSBwYXRjaCB0aGF0IGluY3Jl
YXNlZCB0aGUgbnVtYmVyIG9mIG1lbW9yeQ0KPiA+ID4gPiByZWdpb25zIGZyb20gOCB0byAxMjgu
IFRoaXMgd2lsbCBiZSBzdWJtaXR0ZWQgYXMgYSBzZXBhcmF0ZQ0KPiA+ID4gPiBmZWF0dXJlIGF0
IGEgbGF0ZXIgcG9pbnQgYWZ0ZXIgaW5jb3Jwb3JhdGluZyBhZGRpdGlvbmFsDQo+ID4gPiA+IG9w
dGltaXphdGlvbnMuIEFsc28gaW5jbHVkZXMgY29kZSBvcHRpbWl6YXRpb25zIGFzIHN1Z2dlc3Rl
ZCBieSBGZW5nDQo+IENoZW5nIFdlbi4NCj4gPiA+ID4gVmVyc2lvbiB2NDogY29kZSBvcHRpbWl6
YXRpb25zIGFzIHN1Z2dlc3RlZCBieSBGZW5nIENoZW5nIFdlbi4NCj4gPiA+ID4gVmVyc2lvbiB2
MzogY29kZSBvcHRpbWl6YXRpb25zIGFzIHN1Z2dlc3RlZCBieSBNYXhpbWUgQ29xdWVsaW4gYW5k
DQo+ID4gPiA+IFRob21hcyBNb25qYWxvbi4NCj4gPiA+ID4gVmVyc2lvbiB2MjogY29kZSBvcHRp
bWl6YXRpb25zIGFzIHN1Z2dlc3RlZCBieSBNYXhpbWUgQ29xdWVsaW4uDQo+ID4gPiA+IFZlcnNp
b24gdjE6IEluaXRpYWwgcGF0Y2ggc2V0Lg0KPiA+ID4gPg0KPiA+ID4gPiBQcmF2aW4gTSBCYXRo
aWphICg1KToNCj4gPiA+ID4gICB2aG9zdDogYWRkIHVzZXIgdG8gbWFpbG1hcCBhbmQgZGVmaW5l
IHRvIHZob3N0IGhkcg0KPiA+ID4gPiAgIHZob3N0X3VzZXI6IGhlYWRlciBkZWZpbmVzIGZvciBh
ZGQvcmVtIG1lbSByZWdpb24NCj4gPiA+ID4gICB2aG9zdF91c2VyOiBzdXBwb3J0IGZ1bmN0aW9u
IGRlZmluZXMgZm9yIGJhY2stZW5kDQo+ID4gPiA+ICAgdmhvc3RfdXNlcjogRnVuY3Rpb24gZGVm
cyBmb3IgYWRkL3JlbSBtZW0gcmVnaW9ucw0KPiA+ID4gPiAgIHZob3N0X3VzZXI6IGVuYWJsZSBj
b25maWd1cmUgbWVtb3J5IHNsb3RzDQo+ID4gPiA+DQo+ID4gPiA+ICAubWFpbG1hcCAgICAgICAg
ICAgICAgIHwgICAxICsNCj4gPiA+ID4gIGxpYi92aG9zdC9ydGVfdmhvc3QuaCAgfCAgIDQgKw0K
PiA+ID4gPiAgbGliL3Zob3N0L3Zob3N0X3VzZXIuYyB8IDQwMw0KPiA+ID4gPiArKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKystLS0tLQ0KPiA+ID4gPiAgbGliL3Zob3N0L3Zob3N0
X3VzZXIuaCB8ICAxMCArDQo+ID4gPiA+ICA0IGZpbGVzIGNoYW5nZWQsIDM3NSBpbnNlcnRpb25z
KCspLCA0MyBkZWxldGlvbnMoLSkNCj4gPiA+ID4NCj4gPiA+DQo+ID4gPiBBSSByZXZpZXcgaXMg
bW9zdGx5IGNsZWFuIG5vdy4NCj4gPiA+DQo+ID4gPiBQYXRjaCBzZXJpZXMgbG9va3MgZ29vZCBv
dmVyYWxsLiBPbmUgaXNzdWUgaW4gNC81Og0KPiA+ID4gSW4gcmVtX21lbV9yZWcsIGRldl9pbnZh
bGlkYXRlX3ZyaW5ncyAod2hpY2ggY2FsbHMNCj4gPiA+IHRyYW5zbGF0ZV9yaW5nX2FkZHJlc3Nl
cykgcnVucyB3aGlsZSB0aGUgcmVnaW9uIGJlaW5nIHJlbW92ZWQgaXMNCj4gPiA+IHN0aWxsDQo+
ID4gbWFwcGVkLg0KPiA+ID4gQW55IHZyaW5nIGFkZHJlc3MgdGhhdCByZXNvbHZlcyBpbnRvIHRo
YXQgcmVnaW9uIHdpbGwgZ2V0IGEgcG9pbnRlcg0KPiA+ID4gdGhhdCBiZWNvbWVzIGludmFsaWQg
YWZ0ZXIgdGhlIHN1YnNlcXVlbnQgZnJlZV9tZW1fcmVnaW9uL211bm1hcC4NCj4gPiA+IENvbnNp
ZGVyIGZyZWVpbmcgdGhlIHJlZ2lvbiBmaXJzdCBzbyB0cmFuc2xhdGUgb25seSBzZWVzIHN1cnZp
dmluZyByZWdpb25zLg0KPiA+ID4NCj4gPiBUaGFua3MgZm9yIGNhdGNoaW5nIHRoYXQg4oCUIG1v
dmVkIGRldl9pbnZhbGlkYXRlX3ZyaW5ncyBhZnRlcg0KPiA+IGZyZWVfbWVtX3JlZ2lvbiBhbmQg
dGhlIGFycmF5IGNvbXBhY3Rpb24gc28gdGhhdA0KPiA+IHRyYW5zbGF0ZV9yaW5nX2FkZHJlc3Nl
cyBvbmx5IHNlZXMgc3Vydml2aW5nIHJlZ2lvbnMuDQo+ID4NCj4gPiA+IEFsc28gbWlub3I6IHRo
ZSB2OSBjb3ZlciBsZXR0ZXIgY2hhbmdlbG9nIHNheXMgcmVtX21lbV9yZWcgcGFzc2VzDQo+ID4g
PiBWSE9TVF9VU0VSX0FERF9NRU1fUkVHIGJ1dCB0aGUgY29kZSBjb3JyZWN0bHkgdXNlcw0KPiA+
ID4gVkhPU1RfVVNFUl9SRU1fTUVNX1JFRyDigJQganVzdCBhIHR5cG8gaW4gdGhlIGNoYW5nZWxv
Zy4NCj4gPg0KPiA+IEFnYWluIGdvb2QgY2F0Y2gsIG1hZGUgdGhlIGVkaXQgdG8gdGhlIGNvdmVy
IGxldHRlci4NCg==
