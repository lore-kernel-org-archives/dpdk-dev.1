Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DE39E909B6
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Feb 2026 14:41:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B215340261;
	Tue, 17 Feb 2026 15:40:59 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 0C1FA400EF
 for <dev@dpdk.org>; Tue, 17 Feb 2026 15:40:57 +0100 (CET)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61HAlYpp4193773; Tue, 17 Feb 2026 06:40:54 -0800
Received: from ph0pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11021137.outbound.protection.outlook.com [40.107.208.137])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4casenn31v-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 17 Feb 2026 06:40:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fNrVLrG9yFysv29slT2zc9+QjXmFoQOt1wDnMTJY927IPubHI9YDJLynhQRHkLeigqOX6ebrbo0nNOYcmkQLoD1tqxBbfmms7CrMuBW1xZZbaa1QcS1ZsGcwNkoOuC7BNOwSWMq8zUVOqGBJfslQhRwvmiByjma02KQ8AuPkbyTF8DJ3AYHiGbBc6xmj+FLyr2/a6yKW037/LlCfOGImis8cU5l4ViLbY19hSOsJxyLp0tYNj+EOH3pwNx41zsBS058NqmQl+JYoiOgYt4nv7DmROcK2EKYh5G2Wk/suplofdG/XQSYPZb+BoKi3X30LzqRRLedHRd2spqyAk3Vx2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3lYu0P0J4fypXnwrCY6pbzxpSdA5WOIyuKcNp/EmuWI=;
 b=hQ+VArd52hEMzArPsjTeKR4dgOu3ykA2BiStmGR9foqNQjDdjEneNFyA8mEzYKUroNXbkrN93cCPMv7S8LjoHq02P3w2wbP8UWAXDCvRlL7MeJAnJbFa0dJDI1oRzOMMF5Oba3Jh3hME282X3X1Ly3B22Y29uQvFVkZZ7W7IkNTXuFDgY54UW04gHTf5NvXGTXSIykN1ZIwwJrSvKFdtheZAhcK4nNYU1SpYYa+7Zks3kyJmMROfadhB3tF/1Tgz9kTxDmp8dRuu0oDelUv+hFFDp/ASXgHn3cwKz3juCErnORUkSIZD3Nsx21YxGFUgULCuJhGwh5E1yY0FrL6KsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3lYu0P0J4fypXnwrCY6pbzxpSdA5WOIyuKcNp/EmuWI=;
 b=sP3PMq7DGWilLhEq3OH39xLEJ9FZ/E9MrbrkcTf+A1D5PacvObxQf4PWNC92rRxEF5CBfcOvk9nJf/ojyTCHLNhcKpeu5bebMM99Vx3CizPretCzS7HUoAZoN9HppjcKCpALUUrIUHdXZAim+H1pJtpVaccYdLDKlaFUJmA7+Ek=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 DM4PR18MB4334.namprd18.prod.outlook.com (2603:10b6:5:399::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.13; Tue, 17 Feb 2026 14:40:51 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17%4]) with mapi id 15.20.9632.010; Tue, 17 Feb 2026
 14:40:51 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: Emma Finn <emma.finn@intel.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "kai.ji@intel.com" <kai.ji@intel.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>, Anoob Joseph <anoobj@marvell.com>,
 Raslan Darawsheh <rasland@nvidia.com>, Sunil Uttarwar
 <sunilprakashrao.uttarwar@amd.com>, Andrew Boyer <andrew.boyer@amd.com>,
 Jack Bond-Preston <jack.bond-preston@foss.arm.com>, Vikas Gupta
 <vikas.gupta@broadcom.com>, Pablo de Lara <pablo.de.lara.guarch@intel.com>,
 Nagadheeraj Rottela <rnagadheeraj@marvell.com>, Matan Azrad
 <matan@nvidia.com>, Jay Zhou <jianjay.zhou@huawei.com>, Hanxiao Li
 <li.hanxiao@zte.com.cn>
Subject: RE: [EXTERNAL] [PATCH] doc: deprecation of OpenSSL version 1.1.1
Thread-Topic: [EXTERNAL] [PATCH] doc: deprecation of OpenSSL version 1.1.1
Thread-Index: AQHcm1Cs6+bPx2YOj0KS5qjfEVxjOLWG/vVQ
Date: Tue, 17 Feb 2026 14:40:51 +0000
Message-ID: <CO6PR18MB4484DB317E6B27712F68EC2BD86DA@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <20260211121916.2598788-1-emma.finn@intel.com>
In-Reply-To: <20260211121916.2598788-1-emma.finn@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|DM4PR18MB4334:EE_
x-ms-office365-filtering-correlation-id: fcc97e6b-e3b0-4d04-c019-08de6e328c3d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|1800799024|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?SXdTZEhEdHliMWp4V2NFUEtqVzJwTXhGMjFsQmVhVEUyVkNlbVBiaGNVbHh3?=
 =?utf-8?B?cVA4dk8vQ3JmS3RHNWxHRXkvQU5od2lhd1AwSkNVQ0RqWTlEcDRLMUpKUkRm?=
 =?utf-8?B?MHkrZ3ArMFVlZHh5ckE1VnVkeUVCbXlQTVA2Ung4VkdTY2E0Rm05aE9MWkIv?=
 =?utf-8?B?TVFrOXFXaHU3TUJYUTM3dkZiODB4MEM5dGQrSFpZUmh6ZkQrN25LRC83bDBP?=
 =?utf-8?B?RzVDZHRMbXZXTFY2U3Bwem5pSGxUNFByZ2VPM2JSY3BQQWJ2NWdXVVhmL2Zu?=
 =?utf-8?B?Y3JNb2JBOEtwcHhTYWJ1TlI2dEJ0bTlOZWxJdkNESnpXOERSdVBOclluZ0Ix?=
 =?utf-8?B?TE9vOWJtOXJaTGxGWHNIdUh4MkZjcFB4S04vWnFraExLN0p6SStVMlhqL1hu?=
 =?utf-8?B?eER4YUs1Z1VpeUFUT2dLZjh5ZGd3d3luYjB2ak1EMEhCMUNoWWpKUm9IUUpy?=
 =?utf-8?B?WTVraHp6dDZYS0RnS1lCMXZHNTUwcWI0T1B0Uko5d2RhN25uRm93N1FmcUo3?=
 =?utf-8?B?MlI0R2toOXNXL1lrSVBWYWZKbXpLRVRiT0lHZE8xTTdoRnNod25FcEJGWlpm?=
 =?utf-8?B?SUp5QUdJZDFaQzZXb2xzeEs4Rkp0OTZCU1d0S2hQcmdoenV0OC82VkRIZjhw?=
 =?utf-8?B?UlZJeW9mZnQzUGJkVUI4VW5jR2YzbFhUb2NTRytPbFdNU3VETVNsaUd3bnU5?=
 =?utf-8?B?UUVSK1Nxd2k4WTg5dmE3WitDVU5JUGFaajlwT2l5V3dFc2JEdVBOU3VCUDZw?=
 =?utf-8?B?R1lHWEJ5NmlNSVJac2JCeGM0SW1wc0RFUlZ2Ti80T01YNElJZ1k4d3AwaXlP?=
 =?utf-8?B?a1hmYXNsM3MwQnVuTFRJTVF4M0NGdHVKejRUa3pzSFgyaUg4YlZCV0g0OGVr?=
 =?utf-8?B?L0F5TWFsTStXdlNWenFQUG1NaWdIQ3JoUFRORnU4bzRabXlKUDQ4Q05ZVVNE?=
 =?utf-8?B?TzA0dzNGUjFLZFdKWkxXMnBod0dTRTFMb0E3R0xNL2NaMTJKTnlkYUNDRkYr?=
 =?utf-8?B?aml4MHEvYVd6SDRtTnpxOHA1YVZzaUtZUHNLaktzVy8yOVJQT21UNFpCeFF0?=
 =?utf-8?B?dkVtbHRueEl0YmhWdlRsczBQck0weFU5S3A4ZE5vVXVuSGQ3THNyUmdydGhr?=
 =?utf-8?B?THRBWFY2bWt6OVY3Wmw2UkdRM2g1VXc1aE90VFZWb1pCd2tHcEdUV3Y4MDA4?=
 =?utf-8?B?cGtPM2xadUM1YWF5Tzd3UDFVMWFvaWlIdUI2cS9UbG1LUG44MzYxYWU4ekxJ?=
 =?utf-8?B?cUVSSVVxT2xFSjlRbVc0dHZaZ01TcUF5VDA0U0dvSkFzVTJFVkQ5MXNzdm1T?=
 =?utf-8?B?VWt6aTBLcTVqQlhUZ2RDRWswVllpdmhnQkhEOFVrOWxWdTNqaUFIdXdneW1O?=
 =?utf-8?B?cXJwdkcyaEE0L29hek1pdVR6YUEwSUt5WWRMWlZURjVKMXRINmxSRDZwNzNX?=
 =?utf-8?B?eVNPakdaVmVDbkxvSHdHWFNGbUpvMXJhcjJsL2NLYmc4V0ZzUFpIMjlXL3hx?=
 =?utf-8?B?WTVvbW1pT09KQnBiS1dBQkc0cVB3Y1puRGpFU0Y4TnBwZjRldUMyS3VyOGR4?=
 =?utf-8?B?WkkzSW5weVJkalVFMk9xY2d2V0FrY0xHQ2hmcjFLK2NkMlA2L3BFMDBJUTFB?=
 =?utf-8?B?NGw0WXQ5MDA3RGE0K04wbzgrbGo0YzJzMXo0aUM0WGJjRmVYTG1sN2J5S1o1?=
 =?utf-8?B?ZjBnYVZvUXFncGdrYnJsZHk4dkYvZW1wUmppUnBFNGZxaDhxZzZvdlk4alZr?=
 =?utf-8?B?S0U3K0U2RUtuYmdhcnc3L2k3SE1neFZiSWpITXZNMWxXTmtrVHRFSkxXdFla?=
 =?utf-8?B?V0hEdWhXWk5vck9MaS9PRU1IdEhjYU9sQUw3dG9nVTZhakljcXJTMVhjQU14?=
 =?utf-8?B?QUordjVoRSs2TlU0L2R4SXd2V0RXelZNNEhZbURRcEF4RzR5WnZuYk1uaU1H?=
 =?utf-8?B?VldxaElCbHE3ZUlXT2JmeDJHaC90VWYydUNmU3lzWDVJK1hnZDFsOGJtN0RB?=
 =?utf-8?B?MGcyTVZRYmZMeEp2d2c5U0FpV2ZnWmo1aHQxai9rY3FDazdaUnliMHN1RXpr?=
 =?utf-8?B?YkVoOENPUDNCOG5WV1VGZ2pSd0l4U3RzT01mOUZ3dWxtRG0vMzRlUDI3YkJK?=
 =?utf-8?B?N0lkdWtpNS9jWFUwMk5LRlBLaTIwOWtmNEsreEZ2cllzZTNYL25PZGczN1Zk?=
 =?utf-8?Q?lfIxMtLXHtl29HLqbvDHBNI=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700021); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eFFHU1d6S2dORTR0T1hra041dTRoMU4vODhZWTN6KzhST0haOVV6NHZScUN6?=
 =?utf-8?B?YjFyVjZOQ05UREc3dXJNUjRPU1cxbzltK0FpQ1dVbkVjVXo2Vm9oYldNMnRa?=
 =?utf-8?B?SUk2ZjliQm9ldThpdXFkM3RtUmEzRDhQNGw1bitaVnB4OXUyVno3bExZLzNI?=
 =?utf-8?B?TnRCYjl0NGgvbXFYc05vNUpkTU0ydXE4UWNOK3FselowQzBEb1ZmUVV5akxv?=
 =?utf-8?B?NDdqM1lsNFc1WU52Mzd1Q21oNVU0RFduZXdOOGoycEp5NTlQSjliMTYzQXlj?=
 =?utf-8?B?RERvOHVqZ3V2VkVRRjVIcHN3UU5VTE5vMG1ZR0xqNzNvbWNKbHBwbEFDV2NV?=
 =?utf-8?B?TjdoWkJVYmgzcTdBT1p5em01azJWZ3FibVltUUJXWTBSN1BmbFJac25RSHRK?=
 =?utf-8?B?VnlZVFpyVFhvUzVESU1sRGVSUDdJKzJEa1RlK0tWZ25MOGpaNWl6dEpUYXVy?=
 =?utf-8?B?MW9nSTVGTG1wN0JKZUx0ZCtOZFUrek9IdGhCdkR3N2hBbWx1NTJwdUtmLyti?=
 =?utf-8?B?eVkzVlJiR2R6SXJuT0MwRlVLeVBVaTdYOFRxd0ZBVUxyclN0dHFWdVRZL3h5?=
 =?utf-8?B?aU5HVmhMY3JYUG5ORGdDMWU0a0NnTXFtLzBaNzQxQkRxM3YxRWUrSzRYVFBH?=
 =?utf-8?B?TDdDczc2Z2NJNXRwOTM1NmJZYXVvVDRFSVltSmhLWUdpT0ZkNXVSSE0yelhZ?=
 =?utf-8?B?VGREeWVwN1UwMUlSZERhekpOSC9laCtRRXJ3a1grT3JVak9vNG1oVDNYYzA3?=
 =?utf-8?B?WVBLS0JxMzdjNlFBYVpwVEdvc1N0TkpyN0w2QThXOVhKanQ2ay9ycW1abTdH?=
 =?utf-8?B?bWJnbzlDQlNDbXNDSjJ4OVFlanFXMFhmd0hWN25rMkFKeVpYcjArMjR2T3Nk?=
 =?utf-8?B?M1IrenNnRVZYT0w1RmpYd25kRkoxN3JSdkFjNHlvbytaTjQ4RVVjUGViMzl3?=
 =?utf-8?B?akFPYzlDQ21FR0pIYnkzeXRjZDBuMWl3TlRIT1EreHp0ZEVld0N2dGxXd0gr?=
 =?utf-8?B?M1JlWFhMZ0VaSWZvVFpQZnIyUkFDelNyeGVER3dpMTFJQkQxNms5dnVtTVdJ?=
 =?utf-8?B?b1BvWXBja3VpbDh3dS8wZGNrNms5MThCY0Izc0hQYXNkT2p0aEZXR0J0cWZL?=
 =?utf-8?B?YWsxSTNmTGdlQlQ5K2hCZFR5T2hka3RmMUwyeUJLMGx4VmhKckFKRzFhNW9p?=
 =?utf-8?B?VVNqVGliM1hRSndwQlZVa2cyT3VTWWFVRDV5aU5TTU1lRlc0MGgzd0U5Q1Vy?=
 =?utf-8?B?akgxcGNtQzVRdHBlNXVjVm1aVWN4Tm1mRlhIM0xnT3NIMDJOTVZvcUlZc2ox?=
 =?utf-8?B?N3RtNmFSakhKNnNOK21YV2NsUkY3d1FhOS9xTEZiRTBXb0ZraHgwRUdXTmFW?=
 =?utf-8?B?WnprY3FFVEtVcnM2UXNYbzh1aWpxYnc3dE1tSWw1WlRNSE9nbUltZEI2OE9u?=
 =?utf-8?B?c2Rvek43RGdXWEVaUnRQVms1bWZncUJpbGZrRlFwdVd4UmNpN2xLaWRaVk1k?=
 =?utf-8?B?VmtJTExVV1EyZWplYVh1aW1lTlRiaWhCdXpaSEY0U2hwTXhrR1BsTWVaTHZt?=
 =?utf-8?B?TU4zTHJrYWVURVhmWTZCMDc1MmxhY1BFWHpQOXVtUmJjK3pkbjRUTUdha2wr?=
 =?utf-8?B?VHZ2SlV4MkNUdUFmemxPNVN1Mnc3YVpuUlJMMmVKUVBMV2V3OTVXQlF4dFBm?=
 =?utf-8?B?N0E2R2ljbkM1cmcvRm13Mk9ObDRobFFGNWQ5YStGOGlWcVNoUllIWU8xdHVJ?=
 =?utf-8?B?ZnlOM1F5WEpydDdpaGh3d0dMWHV3aVJrcWJYTEdXZXRuSEJ5eTlXVkQrUndt?=
 =?utf-8?B?OTJ5ZG9Rd0RZN0dsYVBCRUZVUWRSLzNsNkFicVpFNk45WkIzZTZuaFhva3V4?=
 =?utf-8?B?S2JtK3EzOGQvR0pDMEp3NzBZZG4yS0Q1U1IrdEMzZGNma3hZV0VpMVBlNkd3?=
 =?utf-8?B?REpsbVhwRTBIVUZadUZ1Y1dUT2FSWjJ1RFpsRis2LzVXM1VGc3VFSEhOZWhy?=
 =?utf-8?B?K1RZNmJ1SlFJbjJ4WU1qWFlyQk1yeTlTbHorS2gyWEgzakpQeDFLOXJMZTBn?=
 =?utf-8?B?QVphL0k3R2RhRTl4bFptOW1YMERpRk1lS2k1MmpHaFlERjRtbnE4MDFPc2lQ?=
 =?utf-8?B?NVkvTmhKY20vVUFod0hGcXFJanM2OFllSDRsWnRSVHkwa3pBbTBjaGMvRFFw?=
 =?utf-8?B?ajBjRHVuSFpGdkN5MXFGLzkranBMblJlS1ZxeGhtSXd1VjlzRytCYnFEMEFB?=
 =?utf-8?B?MzVsa09TRWN0MTF2ZkN3TUZmSWpZVS84QjByd3pLK0hCbldNbEUreTczSkMr?=
 =?utf-8?Q?FnDzoItekbnS48kOkq?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcc97e6b-e3b0-4d04-c019-08de6e328c3d
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Feb 2026 14:40:51.3192 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NiSd+KO446U6TlazRXi0dpEOvh5+aQUXAm2n8Co5bSkPjaHJI921hX4kU5vJQuQT2etcdlaAWnmUFOcRKyIS2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR18MB4334
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: HAW9GAtQMAekFEFPTX3dpHYnXJNT2IL-
X-Proofpoint-ORIG-GUID: u26_GpyLDEffM4h5XIVKxA42G2Ja0KhE
X-Authority-Analysis: v=2.4 cv=SumdKfO0 c=1 sm=1 tr=0 ts=69947df6 cx=c_pps
 a=hxVrj3tyWKw8/06b28h1JA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=QyXUC8HyAAAA:8
 a=M5GUcnROAAAA:8 a=gTdF9xx14QCBtil9qakA:9 a=QEXdDO2ut3YA:10
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE3MDExNiBTYWx0ZWRfX2YCNre3ppnKv
 IPyCKI31Lt0OSlIChwmaB/kbRo5vIwcuZSRmmwgdWc9mx5CBX9a8Oz+J5gOfBaBfctPxX2GoG4Y
 dAPPDBYqCUFiZ+DmLZtlNf3jjxmB/jxj0g6K+iPg3lvuXzuFzftZQd7LSJzN14dE6ECvSqz4v3D
 lkZcIJH7jwEtylu2m3rF6fK/PO2EGA71psFgdy304j2qZlq70UC8ceSRi+nHVYEZfOQGVtwjLtU
 cVCvX+wskrKbDi4wWOLM3jQNAkBAg3KDkpId2V+NOlZJjbYoBu23LzkXYwsF/xGPi8pMdJ6D5Iz
 +qaKIFaTmkcoCY/pKTA1S200imLsDQNrIY/KEKmjl86REaUX5rm5Jrw1sYdhMjYXEEH8rvnsG33
 87zSMmh4MIu3Wk6JTGT900VcwZGzqKQF8ZLPgd+rqaHKKIw+syA5RHrOwMMt0Wj/KRruLLUb3Zy
 EgJoQ+MXqe57B1ouAgA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-17_02,2026-02-16_04,2025-10-01_01
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

PiBPcGVuU1NMIDEuMS4xIHJlYWNoZWQgZW5kLW9mLWxpZmUgaW4gU2VwdGVtYmVyIDIwMjMuIEZ1
dHVyZQ0KPiByZWxlYXNlcyBvZiBEUERLIHdpbGwgcmVxdWlyZSBtaW5pbXVtIG9mIE9wZW5TU0wg
My4wLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogRW1tYSBGaW5uIDxlbW1hLmZpbm5AaW50ZWwuY29t
Pg0KPiAtLS0NCkFja2VkLWJ5OiBBa2hpbCBHb3lhbCA8Z2FraGlsQG1hcnZlbGwuY29tPg0KQWRk
aW5nIG1vcmUgUE1EIG1haW50YWluZXJzIGZvciBhY2tzLg0KDQo+ICBkb2MvZ3VpZGVzL3JlbF9u
b3Rlcy9kZXByZWNhdGlvbi5yc3QgfCA1ICsrKysrDQo+ICAxIGZpbGUgY2hhbmdlZCwgNSBpbnNl
cnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZG9jL2d1aWRlcy9yZWxfbm90ZXMvZGVwcmVj
YXRpb24ucnN0DQo+IGIvZG9jL2d1aWRlcy9yZWxfbm90ZXMvZGVwcmVjYXRpb24ucnN0DQo+IGlu
ZGV4IGFjNjY3ZTkxYTYuLmZjYTU1NmQwN2IgMTAwNjQ0DQo+IC0tLSBhL2RvYy9ndWlkZXMvcmVs
X25vdGVzL2RlcHJlY2F0aW9uLnJzdA0KPiArKysgYi9kb2MvZ3VpZGVzL3JlbF9ub3Rlcy9kZXBy
ZWNhdGlvbi5yc3QNCj4gQEAgLTIwLDYgKzIwLDExIEBAIERlcHJlY2F0aW9uIE5vdGljZXMNCj4g
ICoga3ZhcmdzOiBUaGUgZnVuY3Rpb24gYGBydGVfa3ZhcmdzX3Byb2Nlc3NgYCB3aWxsIGdldCBh
IG5ldyBwYXJhbWV0ZXINCj4gICAgZm9yIHJldHVybmluZyBrZXkgbWF0Y2ggY291bnQuIEl0IHdp
bGwgZWFzZSBoYW5kbGluZyBvZiBuby1tYXRjaCBjYXNlLg0KPiANCj4gKyogY3J5cHRvZGV2OiBT
dXBwb3J0IGZvciBPcGVuU1NMIHZlcnNpb25zIGVhcmxpZXIgdGhhbiAzLjAgaXMgZGVwcmVjYXRl
ZA0KPiArICBhbmQgd2lsbCBiZSByZW1vdmVkLiBPcGVuU1NMIDEuMS4xIHJlYWNoZWQgZW5kLW9m
LWxpZmUgaW4gU2VwdGVtYmVyIDIwMjMuDQo+ICsgIFRoZSBtaW5pbXVtIHN1cHBvcnRlZCBPcGVu
U1NMIHZlcnNpb24gd2lsbCBiZSAzLjAsDQo+ICsgIGFuZCB2ZXJzaW9uIGNoZWNrcyBmb3IgZWFy
bGllciBPcGVuU1NMIHZlcnNpb25zIHdpbGwgYmUgcmVtb3ZlZCBmcm9tIHRoZSBQTUQuDQo+ICsN
Cj4gICogZWFsOiBUaGUgYGAtYyA8Y29yZW1hc2s+YGAgY29tbWFuZGxpbmUgcGFyYW1ldGVyIGlz
IGRlcHJlY2F0ZWQNCj4gICAgYW5kIHdpbGwgYmUgcmVtb3ZlZCBpbiBhIGZ1dHVyZSByZWxlYXNl
Lg0KPiAgICBVc2UgdGhlIGBgLWwgPGNvcmVsaXN0PmBgIG9yIGBgLS1sY29yZXM9PGNvcmVsaXN0
PmBgIHBhcmFtZXRlcnMgaW5zdGVhZA0KPiAtLQ0KPiAyLjQzLjANCg0K
