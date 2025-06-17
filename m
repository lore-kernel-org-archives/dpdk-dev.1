Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C813C71136
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Jun 2025 21:13:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 38E2E40E44;
	Tue, 17 Jun 2025 23:13:29 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 07C73400D6
 for <dev@dpdk.org>; Tue, 17 Jun 2025 23:13:26 +0200 (CEST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55H9FojJ031732;
 Tue, 17 Jun 2025 14:13:26 -0700
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2102.outbound.protection.outlook.com [40.107.93.102])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 47b5jcsjje-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 17 Jun 2025 14:13:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uJFmEQGZGPHGgKgt0yuBJXyipucAuT+YMd9lAaAWaZqBfZbbucnmPFjmFiuBIuC+lSaB0ROhgXBjb71C2gb40hCwNGJvGEJMy/hdwLWBOffwftxL1mnHJ05YYbu1URFKnCYIgUkDfhlvH9WqKyh7Vu4xLLxsBbq6RycBNy8AxLiBZGc8q0HmCNXGaCiDe2niY1NqLyRpPCCQRSUTmjMB1GOuYsbH/DD8eluyuFIVKSWxi3h3ZZdA2UlV/EAjBw/60PpfoY/jA3WWGTC11/lG9hokC7KI8OuE2X/Qj/cv7mr0ajV7GggW1TwZm50rFcXlzSyo4T+3X2zAkdNIwptLcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6nWMtzfG+LbcbLtZzBw0vo0VUWVDtCqOCI0Q6STmrnQ=;
 b=e7HVO+w2kdQIZg2UAOLC5CTFrr6/WXnxt2xCdLUxXv76gGnDPXYVkThkAew5hiR9oHRWkdoIskHg3OP3qtqtadTmJuDozPOAvhMVixgygBfwKY0p2lH3fZUBQfVF2uqorZyl5Kp1DYEsRGCVA4ZOqJC5sghSjcdzlW63xfLBLF7kq5/gjYMqP4EPHg4U4bMkhWpyYY5fD6brCuMFaZpu4CrJjk1TPSz65s41JUUyFd7ixeluwyMzT6I7CzDSlbpQazC8Wkq4KpFOgXAbltMTeeIOfKE9XRaDRmBtH8XnMEyqtizhYPC/AGho2CUzYwpSfriPq0dNXwl9Igx8EHVjaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6nWMtzfG+LbcbLtZzBw0vo0VUWVDtCqOCI0Q6STmrnQ=;
 b=NZmchMtycrYXrjkP3k8mMfY8QmYau4T4lC3wyR++vNTMJKkkE3TLejbao+1jxRoNgplIs0wgUAhaxURaF7sFUsxbEZbG2TzruiTMBruXcgYDRn3pil/+5xJb/nxvaHKviP4MgVeQEUbxiqxOzFGopnvzJQp4Q86ePycLKW5yN2o=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 SN7PR18MB3983.namprd18.prod.outlook.com (2603:10b6:806:f7::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8857.19; Tue, 17 Jun 2025 21:13:23 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::3c98:dd36:4897:a51d]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::3c98:dd36:4897:a51d%4]) with mapi id 15.20.8835.027; Tue, 17 Jun 2025
 21:13:23 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: Zhangfei Gao <zhangfei.gao@linaro.org>, Fan Zhang <fanzhang.oss@gmail.com>,
 Ashish Gupta <ashishg@marvell.com>
CC: "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [EXTERNAL] [PATCH v2 0/2] uadk: realize async mode
Thread-Topic: [EXTERNAL] [PATCH v2 0/2] uadk: realize async mode
Thread-Index: AQHb3ml0uvchtcNpMkCYiG7JUafpcrQH3Bkw
Date: Tue, 17 Jun 2025 21:13:23 +0000
Message-ID: <CO6PR18MB4484CC09006031419CD1BBCFD873A@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <20250616025027.209883-1-zhangfei.gao@linaro.org>
In-Reply-To: <20250616025027.209883-1-zhangfei.gao@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|SN7PR18MB3983:EE_
x-ms-office365-filtering-correlation-id: 8b6238fd-789b-49cb-4f55-08ddade3cb30
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?cElFVXBiWk5pd0VGYkFMd1pqWHZ0RjlERkNOaHMraXRJbVJHODliSUY5R1pF?=
 =?utf-8?B?NFBaZTlQMTlyN1FGZXdDVGVZTldOd2E1WURiVDNwSnFuMkVCZVBIRmFBUnE0?=
 =?utf-8?B?empWeVJ0aitLOHI5WkdwY2EvUzJ6NkV5MDZ1UDJPcmxZN0FkRUNFQm9TVC9q?=
 =?utf-8?B?Z0dJN0ZNNW5LUUQzZjZud3kveGNqUGNlYUN6RnVDaE1ZRm1kTGVZWCt5bzFU?=
 =?utf-8?B?NWdKaTE0QVFKV21lMlhWeEZ2UFBYeUUrbmdtbTJvdktYVEduY2JnbXNjOWNr?=
 =?utf-8?B?Y1VkZUZwNUI5amtpYWdXUTAwV0drQlZkLzdMYU9xcVB2VHErejBJakZRR2RD?=
 =?utf-8?B?RnRHYzlaNTRxT1pudHc2ckRjTlJxMmRJemhmU2N2czk3NWhsNG9GajFVRFVw?=
 =?utf-8?B?cEtBbndlM2x1ZzJDVS9mZFpnZzB2bkE3VWlEMGFwSnBpRVJyRWJLODQzUUJY?=
 =?utf-8?B?cWpoVW9sUkJ1aFg5cXdBanIvdjZnOUJqZkdHWDd2QUMwSDBCYVhrc29VOU9q?=
 =?utf-8?B?Z3E0dzRmejZoQk1SUGZSNkNyQkNzdFBibVUwQVQ5dnlXNUlFdWtSdHVOWXQ1?=
 =?utf-8?B?NDFMUHVRQktqK1NZc0ZBUGNTVmE2OEY2bmFYWTVIWUdseVNGUG02YkFscmUr?=
 =?utf-8?B?Wks0RW9tcVJtZVlQdzRlamtEcTVSNEEzN0wvQkZnRFRvZTd1VXlpRUkvU1Zw?=
 =?utf-8?B?c2pKanc5MDl2eHBVYktCRkF3d1dKWlViVWhWbW5PL1RLYUM0blFtTmRkOWRD?=
 =?utf-8?B?cEtFZUxkaFgrcG92bi81Tks5NGxmNnlLUldoNzFQaFVnMFplZ0FHbVNiSUV6?=
 =?utf-8?B?a0hmdzBibWc0S253dDhSWERoM2xUbkhtb2x2WFdSMmF4S2VKL1dTdlpSTWpT?=
 =?utf-8?B?bEtOS21TU2hic2YycllKbENydmVOS1pUZnozazQrcmUwbE5COU1oUmJyd24r?=
 =?utf-8?B?L1dhMGd1dk9MbmhRc0c4a28xYUpTMFFobEFZTStCTWgxb2w4eDFqL291SXF4?=
 =?utf-8?B?cUo1RENpenBLaEQvZGhQd2FkcXFpQncvNUJSNlVneUpiUjFLcmVGQU5QU241?=
 =?utf-8?B?K3c3ZW9lcDlmOW1Gc0UraXlEQmlFMXUyOWxlZXFXZU9FaGQxUjlVeTFxaXJj?=
 =?utf-8?B?K2k3d3NoaGJhZVppY3B3b2pLKzNtUmJKcWRFYU5xUE5SNGFJcHVNNnNqNzI1?=
 =?utf-8?B?VlNOTCtUcXNQTVF5YkkyamxGWUhrK1V1TjVSQU1hSEs5VnU5ZUJONDVtb05T?=
 =?utf-8?B?dStBSEs5bDB2U0J0c2Eva1JDekx2elVZSFZicEx3VzMwTkxNQ3o2TVhtL2ll?=
 =?utf-8?B?UEw0U0tadmNZZGt0UDNXc1NLeGJudHFtZmt5VWo4LzVuKzRaK1RmYW05UW9S?=
 =?utf-8?B?K3p2dDBpcWc0UkNzVWNiUW5udTlHMUZ1RW9JYVNXcTAvWkNHeWd3MGFkZTdP?=
 =?utf-8?B?S3hsbHFnU0NoSDhsQ2JaUm4raXlia3RYSGJnV0FkeTI5THY5NmJzNWZUUGNj?=
 =?utf-8?B?TE1iSHF1UmluRmRzdkgzZ3FEUG5TVDZ1bG5CYnlubjNwUTc0VGpVeklOT0xn?=
 =?utf-8?B?U3cwd2pJZkhKY1ErVW53SklFRnJHWFdzRDAyczNnLzlTR3R6VTc4MHgxb29Z?=
 =?utf-8?B?ajhRd043RmFWaUMwMXl1U2ptSllqOE4rRTlmamFBb2oreXByd2ljTGRseEkx?=
 =?utf-8?B?S1h3cmZwZ0NKMnFuRThpOXJkOGN6bTdLcUFaMFRhQWJRZWxZTmRnak0yT1Zp?=
 =?utf-8?B?NitOYzRiNkxSSFY3ZzNGTWFKMTZPK2lDSGlPd2JHODRBcExIaWpQUTZMTDVY?=
 =?utf-8?B?cS9ISHIvcnM4Q1oxK3lCMkdNMXhUSjhwRWsvbG0wOUszRkRzYlVYbGNYSFhZ?=
 =?utf-8?B?NHRveVl2c3V1KzY1dHNpK2pyRWhzQy8zWTA2MVgwei9hb0hZNktQRVN2SFF3?=
 =?utf-8?B?WW1xbnNrNlAyT25aYnNLNUhBTFEzZXNOdFlRcW4wMFFMbnMwVlJnRWt5WFha?=
 =?utf-8?B?M1BuamRuSkFRPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RjJPK3BzYTdZZWFCYTB3WG5KQWdIOERKYUkzVHd5SWttWTBBRlR5SWNVdnBu?=
 =?utf-8?B?OUczNklPRmE5RFF5aHdWd1dNNGRzTjFUTWh1Rm9uUFIvdytVWitTanVGSUo3?=
 =?utf-8?B?UExGQVNEa2p6TGZwYTNtS1JYeFhKR3ZBek0vTUlvN0VUSnM3L1NZbHIvTWtp?=
 =?utf-8?B?ajh2RmJlTU5sVDVycjN1ajI5K09OTVVMNE8zMEcxRDVCVDdmVUdnZ1MvK0Vx?=
 =?utf-8?B?b1d6MnFNblBvUnFKdTloZ3M0KytMUWtTUm5TZTZ2eGRDa3BIb0hhUTRyY0xK?=
 =?utf-8?B?eFFTOXdqQXlnUmRRRmlRVWNobTlKOGlGMjlsVEdCZXYwOTV0eDlVRE1XWXZ0?=
 =?utf-8?B?Qmg2SVExMThqRE1MSDRGa3puOWhqQzgvMzlVbXJGb01XYXdnYmVNUWlRREU0?=
 =?utf-8?B?RG5nM1JGYWFZYXB0UFJQcmNPL25NT2h4RU80NGpaRWRaTEtnQXVBM1ZjYmov?=
 =?utf-8?B?MUJ2cEt6YjloT1hGcEhaT01DRVFrQitXUFZ6d1g5a2krOE00OGdrckdYejBv?=
 =?utf-8?B?YmtnRkdZLzE5bnl6SzZabU40b0ZEcmc4aktmLzYrYUVFMEdITE9Pd3RKMVA5?=
 =?utf-8?B?RWNDMlZ5L3VVVnU3NXFIMnVMZGpsSjA3Ly9abWhPcWF1a3lBaURRREJLUVJS?=
 =?utf-8?B?YVAvNGZ0YXRvQVFsUWZyTWM3UVRhUEdaWnJKNk5ZRGc3Zm1ub1BDVTBZRms2?=
 =?utf-8?B?RGhjYUUwRUpkeGpMN2VQbFFPNzAxVkhNclF2OGlHbm4yQ0VVdVlKR2VYMWQw?=
 =?utf-8?B?VVRsMjRSbUFVd0d1Yktma1lLbitFMUNMQjRMZG9hNWFlVWlpd1BObGRwNmM3?=
 =?utf-8?B?Mzk4VU1MeU13bGlFRGxWbmdRUWJjNUtkVGhGWXhHSDYyekV0VHFTM25laUN0?=
 =?utf-8?B?Z2ptMy8vMThTN3pOZHZPc1hXb2FJblhxRWhBaW1hVFNETGYzczgxRXBaMUEy?=
 =?utf-8?B?eFd0ZE9PVHR5M091ZkgyNTRHSTB3b0JWUmdZZjBHUkJBVlNKODNFS0FPa0dZ?=
 =?utf-8?B?N1RDQUxqREw3VUx3Wlh3dlRLQ0ZIWU9kTEE1Qm40NzdxdUlnMkpraFVBaGtq?=
 =?utf-8?B?ZHJROU42N0tqd3U2S0ZzSVgwYk1hY05JdUl2UzJRSzF2cENmeGF4cllobUNl?=
 =?utf-8?B?cmFGeXl6UmVVaWVKblk0R2tNUm9YR0ppQWl0bDlRd01mdDNMYWRaNDFSRnhB?=
 =?utf-8?B?a0EwMXpheHM4NVVuNUF4bkJaUEovK3FsR1ZTbll3SXVmOHh0d3dLbWpFeXJo?=
 =?utf-8?B?YjRTNzFOUVhHVnVwcWhRSHZITi80SUVmUXdSNEFuczBTQ0VNd2p2Wld4V3pD?=
 =?utf-8?B?ODZOdFBBa2NMYXFQZzFLNGd4KzlQbjJ4RGxneS9LcjRtRnlteERyUllxNWcz?=
 =?utf-8?B?eTh4RDJnRXNQMm9FUTZQREFPWkY4RVJPUFFoTXBlRFZJOEk2V1U4OXpGZHZi?=
 =?utf-8?B?elh6d05La1E4L2orSVY5MzN0Yzg1dXBiSm5oWGROaURFUnErRDBjd1FPY005?=
 =?utf-8?B?YWwwUGdCOHQwOHVsYkZmb3p5ZGJkTjFnQmRkQ1gvRm1TeE03bVQwOENKc1hw?=
 =?utf-8?B?UCtIUFV0NHZFL2hsay9yRzFSOUd4a25LanFKMGFnSm5abnNPd0ZRdzltcXdJ?=
 =?utf-8?B?SXp0OXFILzdidURaUEhoT0ZyRXdEYmpvcGlyVjRhSUhjK2xSOGh1b3RoRnRi?=
 =?utf-8?B?bWlFaFZ6L3hFQUhabmtVT2Z3ekU1ZmFzYm8rdzlTbHNlZ0UwZ3lzcWpoMWEy?=
 =?utf-8?B?NDdVbTk3RVRFNXhKUDB3dzk2ekR4VW9oQUhlSXNwZU9ZSzJ5YmJ3a0xPdlVJ?=
 =?utf-8?B?TUJsL2d6VjhzQWZ5NWt3ZVg4TDM3NGE4Uk5hSm8xdVZlZXNnc3YySEFCclox?=
 =?utf-8?B?OExmZVBGeVBPODhrcUFxMVJhT3h4Tk1TZEtaL3lVVS9mWEVxWC9QRUlncm4r?=
 =?utf-8?B?WktDMnRLdHN5Z29jdVkvVnNDZS84QUc5NWVzZDBoQ3AzZDFDTDNLZERhaVhu?=
 =?utf-8?B?aWZ5VzdiNEdISS9qQWJmZHhhNW1rUmJQR0tWeERQUm1XMU9tY0lsRDBVOUJF?=
 =?utf-8?B?ZmFEUFBhZFptaWZqRDkvWW1rSnFLekVlSVBPTzJHR1dBSVJ0NERPaDhnc1hl?=
 =?utf-8?Q?zCbI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b6238fd-789b-49cb-4f55-08ddade3cb30
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2025 21:13:23.3900 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q4b1yurmuvAwO+6JB6+kddRUtA/sTjDcvkSfaRI5JYYHEBg4quHXu+z/k1OuSEkAJCRgSwqzQ2vDQoIrh2nDVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR18MB3983
X-Authority-Analysis: v=2.4 cv=YaK95xRf c=1 sm=1 tr=0 ts=6851da75 cx=c_pps
 a=XxE+iQgRJJz70QjvVvSL0g==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6IFa9wvqVegA:10 a=-AAbraWEqlQA:10 a=b8ozR5EY9xnXAssgAEgA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE3MDE2OSBTYWx0ZWRfX78F5LHDRNONA
 oNkwqrrMHmy48my7jbobJhVJBt++712OMeECrNg6uUH97kj1de9MSqYEuP+ME4DlJkEssAijg4G
 /HVpQgyltVABbSkdL/k9IBURoVDWDp+TTHjfP2yKd35lcn1883K9gKoAoPFVVICTHiHSyKgWp0y
 qxnoH12y/XtJuyPca1w8erLt+qxapmFWBFQfkQoov3L0xdmnUig8y9XsRkQQHEM8XqhWrcd2qq5
 GuWLohC6G0500fPMlDdxW9bzcEzgUBTN7nWTMBb2tLBw2e7yuzSw+JWTeRhIsopvumDVpDcTodN
 ZEBrXTJkguY7iEaTu37fU9s5HCEHx7JTZRJvemhAwLD++sZBjueP9GmOGqspvcw76+kAhD/7jlM
 oxuVZBAagFVg7cyok3bZz2J7YYUAku+D3ezCngQb04xKw+SvFjcYkezGLqCAqx/PaWP7qlzq
X-Proofpoint-GUID: As3fHWL7R9d14DEcgAUfFkG-p9cmkO0Y
X-Proofpoint-ORIG-GUID: As3fHWL7R9d14DEcgAUfFkG-p9cmkO0Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-17_09,2025-06-13_01,2025-03-28_01
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

PiBSZWFsaXplIGFzeW5jIG1vZGUgdG8gcmVwbGFjZSBzeW5jIG1vZGUgZm9yIGJldHRlciBwZXJm
b3JtYW5jZQ0KPiANCj4gdjI6DQo+IEFkZCB2ZXJzaW9uIGNoZWNrLCByZXF1aXJlcyB1YWRrID49
IDIuOQ0KDQpUaGlzIHZlcnNpb24gRE8gTk9UIGV4aXN0IGFzIG9mIG5vdy4NCg0KDQo+IEFkZCB2
ZXJzaW9uIHRhYmxlIGRlc2NyaWJpbmcgRFBESyBhbmQgZXh0ZXJuYWwgVUFESyBsaWJyYXJ5DQo+
IAl2ZXJzaW9uIGNvbXBhdGliaWxpdHkNCj4gTWVudGlvbiB2ZXJzaW9uIGRlcGVuZGVuY2UgaW4g
cmVsZWFzZSBub3Rlcw0KPiANCj4gWmhhbmdmZWkgR2FvICgyKToNCj4gICBjb21wcmVzcy91YWRr
OiB1c2UgYXN5bmMgbW9kZSB0byByZXBsYWNlIHN5bmMgbW9kZQ0KPiAgIGNyeXB0by91YWRrOiB1
c2UgYXN5bmMgbW9kZSB0byByZXBsYWNlIHN5bmMgbW9kZQ0KPiANCj4gIGRvYy9ndWlkZXMvY29t
cHJlc3NkZXZzL3VhZGsucnN0ICAgICAgICAgICAgICB8ICAxNSArDQo+ICBkb2MvZ3VpZGVzL2Ny
eXB0b2RldnMvdWFkay5yc3QgICAgICAgICAgICAgICAgfCAgMTUgKw0KPiAgZG9jL2d1aWRlcy9y
ZWxfbm90ZXMvcmVsZWFzZV8yNV8wNy5yc3QgICAgICAgIHwgICA1ICsNCj4gIGRyaXZlcnMvY29t
cHJlc3MvdWFkay9tZXNvbi5idWlsZCAgICAgICAgICAgICB8ICAgNCArLQ0KPiAgZHJpdmVycy9j
b21wcmVzcy91YWRrL3VhZGtfY29tcHJlc3NfcG1kLmMgICAgIHwgIDk0ICsrKystLQ0KPiAgLi4u
L2NvbXByZXNzL3VhZGsvdWFka19jb21wcmVzc19wbWRfcHJpdmF0ZS5oIHwgICAyICstDQo+ICBk
cml2ZXJzL2NyeXB0by91YWRrL21lc29uLmJ1aWxkICAgICAgICAgICAgICAgfCAgIDQgKy0NCj4g
IGRyaXZlcnMvY3J5cHRvL3VhZGsvdWFka19jcnlwdG9fcG1kLmMgICAgICAgICB8IDI5NyArKysr
KysrKysrKystLS0tLS0NCj4gIGRyaXZlcnMvY3J5cHRvL3VhZGsvdWFka19jcnlwdG9fcG1kX3By
aXZhdGUuaCB8ICAgOCArLQ0KPiAgOSBmaWxlcyBjaGFuZ2VkLCAzMjAgaW5zZXJ0aW9ucygrKSwg
MTI0IGRlbGV0aW9ucygtKQ0KPiANCj4gLS0NCj4gMi4yNS4xDQoNCg==
