Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93E90C02193
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Feb 2025 07:16:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 814EB400D6;
	Tue,  4 Feb 2025 08:16:01 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id ABA0E4003C
 for <dev@dpdk.org>; Tue,  4 Feb 2025 08:15:59 +0100 (CET)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5146xI47011064;
 Mon, 3 Feb 2025 23:15:58 -0800
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 44ke3yg0xv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 03 Feb 2025 23:15:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=igNV9wGAP4gKv3l+93MNO3SFdte4Erw3w9e7iQC2TBWkh9eB1iZvULqWqYQ+QzT1I+Ht1935Ek+FwQooT+IEcOO+fB1fpZvB/LtCN9HHWU125gpAapeaVKNXMwKT1GZmqvRpdTnkd60jZuZ3S27V3sZ84bkNDdX47p1LbOLtu1hC7JJlAZ+9ofMy0ZfdJnsmtAGapunSy/hBJyDcFdpY4KJgDRUBArSDQogmH19nVvFmNI5hRfcZ38mvD2Zk1uVV5z3V8jeIKOnQuvjTccJH8eV6qtTC5jjHLHsyeuuQyBh7IX+yNI6ZvM+iIT3aUPCnUZbyVDayzdAgiJgib9vDQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aOZw4HmoKgL+4qRvZi8H+WSHP48pfGB6tSMx8LdLwRU=;
 b=WU01FePTtiZoALNVNvFUKdJhnB2meTDxGk2CeXpXbYt2bddJWWx1RIo38gsQT6Mw85NyEHG87AkljdrLl0OPwylZ/1U08EkZLGUN/yya10bIcK/6auoPi0oKC49K9HuYUQ02yjt5dK65ack6YWPRptov0hhqj7cSW5TY9OeobexWVBRoomdn7Vm4e6QzUz2guKcexhovsRyiFYt9vVgzgJghMY7iPgrEkUYtBHaSMV8JxtD+rleTTu292qvzbaNbT4xbNiZvQiD2O79eXqGJooGM5pgzW7djvWo2Xka5nuhNbggsTjCQXky19sPFU1BUrwezKkq32Gch39mNSF3vcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aOZw4HmoKgL+4qRvZi8H+WSHP48pfGB6tSMx8LdLwRU=;
 b=sr+drud2NAd0G1cHHufsqaJN5T7IGXl30b6EEnqwVZF5Ts9VuFzNIz5+QQt2CscLR0Y8ZnpneYNjGGMjrACZgASnqN+JvJ1MEf1QZCE9SVXr166Z8ORxoa9sLGec7rBwx6UA92XXzfMXyDDVuHjgi2xvngqCptQlZLnPwhBL3OI=
Received: from BY3PR18MB4785.namprd18.prod.outlook.com (2603:10b6:a03:3cc::18)
 by MN2PR18MB3541.namprd18.prod.outlook.com (2603:10b6:208:24f::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Tue, 4 Feb
 2025 07:15:55 +0000
Received: from BY3PR18MB4785.namprd18.prod.outlook.com
 ([fe80::4f9f:e101:dad7:c576]) by BY3PR18MB4785.namprd18.prod.outlook.com
 ([fe80::4f9f:e101:dad7:c576%4]) with mapi id 15.20.8398.018; Tue, 4 Feb 2025
 07:15:55 +0000
From: Jerin Jacob <jerinj@marvell.com>
To: "Naga Harish K, S V" <s.v.naga.harish.k@intel.com>, Shijith Thotton
 <sthotton@marvell.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: Pavan Nikhilesh Bhagavatula <pbhagavatula@marvell.com>, "Pathak, Pravin"
 <pravin.pathak@intel.com>, Hemant Agrawal <hemant.agrawal@nxp.com>, Sachin
 Saxena <sachin.saxena@nxp.com>, Mattias R_nnblom
 <mattias.ronnblom@ericsson.com>, Liang Ma <liangma@liangbit.com>,
 "Mccarthy, Peter" <peter.mccarthy@intel.com>, "Van Haaren, Harry"
 <harry.van.haaren@intel.com>,
 "Carrillo, Erik G" <erik.g.carrillo@intel.com>,
 "Gujjar, Abhinandan S" <abhinandan.gujjar@intel.com>, Amit Prakash Shukla
 <amitprakashs@marvell.com>, "Burakov, Anatoly" <anatoly.burakov@intel.com>
Subject: RE: [RFC PATCH] eventdev: adapter API to configure multiple Rx queues
Thread-Topic: [RFC PATCH] eventdev: adapter API to configure multiple Rx queues
Thread-Index: AQHbUehzjqiIJ0+TDEqaWKCLlR4kPbLyeVCAgBDXeoCAEXJrgIADdKCAgADj1gCABoKngIAAjp+AgAJJBACAAI1GAIACf7cAgABmvgCAB4kVgIAAKwXwgAIWRACAABGRkIAFgUiAgAG+XUA=
Date: Tue, 4 Feb 2025 07:15:55 +0000
Message-ID: <BY3PR18MB47856C34DBA48627A26DF525C8F42@BY3PR18MB4785.namprd18.prod.outlook.com>
References: <20241219073405.1724200-1-sthotton@marvell.com>
 <SN7PR11MB7044FFA1C3149366743582D5A1012@SN7PR11MB7044.namprd11.prod.outlook.com>
 <PH0PR18MB442538A4025B3D772339B792D9142@PH0PR18MB4425.namprd18.prod.outlook.com>
 <PH0PR18MB4425F0653E17085E9693E0D2D91F2@PH0PR18MB4425.namprd18.prod.outlook.com>
 <SN7PR11MB70442D9156537BA7C5D918A7A1192@SN7PR11MB7044.namprd11.prod.outlook.com>
 <PH0PR18MB4425814723E192FC21969FA9D91A2@PH0PR18MB4425.namprd18.prod.outlook.com>
 <SN7PR11MB70443CFCC150DC9CC8E6866FA1E72@SN7PR11MB7044.namprd11.prod.outlook.com>
 <PH0PR18MB44252131DAFCCBF239A70D5FD9E72@PH0PR18MB4425.namprd18.prod.outlook.com>
 <SN7PR11MB70449343834D079E93AD1FF3A1E12@SN7PR11MB7044.namprd11.prod.outlook.com>
 <PH0PR18MB442573F6CCB0FCB357F9F360D9E12@PH0PR18MB4425.namprd18.prod.outlook.com>
 <SN7PR11MB7044B9FAAEC54BF9693ABCFCA1E32@SN7PR11MB7044.namprd11.prod.outlook.com>
 <PH0PR18MB44258D0FFF8EEA33B8D85337D9E32@PH0PR18MB4425.namprd18.prod.outlook.com>
 <SN7PR11MB7044ABDDB1DE072EFD383671A1EE2@SN7PR11MB7044.namprd11.prod.outlook.com>
 <BY3PR18MB47859D0FCDDF968D5D3239EEC8EE2@BY3PR18MB4785.namprd18.prod.outlook.com>
 <SN7PR11MB70449DF4A1C35B08BCEDF50EA1E92@SN7PR11MB7044.namprd11.prod.outlook.com>
 <BY3PR18MB478566CF43724C43539D7395C8E92@BY3PR18MB4785.namprd18.prod.outlook.com>
 <SN7PR11MB70445F6A08B056028D812E3BA1F52@SN7PR11MB7044.namprd11.prod.outlook.com>
In-Reply-To: <SN7PR11MB70445F6A08B056028D812E3BA1F52@SN7PR11MB7044.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR18MB4785:EE_|MN2PR18MB3541:EE_
x-ms-office365-filtering-correlation-id: 358215c7-38f6-434a-3cb4-08dd44ebc3ff
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?WVp6TW5MaXZBbVlqQWhDSGU4MzdIejFUTTNpMXdpV0lyRERkYk83SE9pc2ZX?=
 =?utf-8?B?SVFRQjZlY1p6eisxK1AyRFBvTmR3SVJiY1h3TE1QUktKMlU2UGp1SkZUd0xj?=
 =?utf-8?B?NWp2NVA4Wk1mU2pES1FOZTRoY3lTeitYT2pVaE1tNGNuTUEwV2kyOURLb3Vp?=
 =?utf-8?B?QU01Ny9vdXRrd2pEVG9NUFh0Z1Bwc3k5b2tDMjdhU3Mxd0tFa1hCZlVCZGFW?=
 =?utf-8?B?MGhlU3VNeDM3QnRpdmdXa29vdVRBS3hsWXRMSFFlRWNra2V5UFBqUUdtVmMx?=
 =?utf-8?B?dHRENTBsTDZxUkF5V0NnS0FSaEdDRGloRnN1Y01uaWpRcEFQeW9EL2Zzc2s0?=
 =?utf-8?B?b2V4bWVPMHBKTmh0ZE8wVUxWZ0xGSVBXUExUTm1maDhWbTBvWkYxSk5IaWZV?=
 =?utf-8?B?aXl4YUF0VkNvalBVVGpLZnpyZTZiQ21ZSUFNUmcrMVFrMkNmaWErY2hMNi9v?=
 =?utf-8?B?SzZFUEVlb3psZGxLVjhKdXlRWk04NUI2Rnhta3RKM3RmYlIwTFpONHVNM2NN?=
 =?utf-8?B?N1M2ZE1ZTC90dXZYSzVsM1VQR3g3UDJpdXpwaUZIaXM1dzhPU1VtdlZTenpZ?=
 =?utf-8?B?cDE0WDNoSmFnQlNMZ2hQZUR1RjlSMkJYNExDLzk0aWZlUjdrblJGZEIvK002?=
 =?utf-8?B?ZkthZ29NZTNVcml6SHRVWHlGalJXbXE5aTFYWUJkQzVyQXFoalQzZGhWRldi?=
 =?utf-8?B?YjR2VFplc0liVnZOcUtNa2RmNDhwcG44emg2b0pIa0s5UCtEVmZZaU5zS0lV?=
 =?utf-8?B?MDlOaDFUM1R2MXZpK0h4dSt4V1ZJTUdzdFJSWWNSVE5CZ1dNYkRHNlphQ0pj?=
 =?utf-8?B?QUNXc2FtOEZDcTBlRXR4b0dETkptSk5JandqQU5IMU5PTnhRcXJUUWlxT3V0?=
 =?utf-8?B?a1V2TlZVcW96TXdMd1Y4NU1xeXpUd3RhRWs1Q0R5Ly9IRjhZTURkZy9lMWlH?=
 =?utf-8?B?YnVocFlBNGJ5Sm9QbjdPWU1pT0RocXFxME9rTGlaeVhLM3pROFJFRnM0MG54?=
 =?utf-8?B?MlQ0TjBpZVEwM1NFQjRqSXlPTFJwc0w2NDFOc1RNb2d0MDh2d0g4cGFXSURD?=
 =?utf-8?B?dTc1Tk8rd01wK1lpUk5nM3BYTDVOdzhMaVQ1ZkF2cnBQM3BkRnpNK3NlUStR?=
 =?utf-8?B?QTNRdDFneS9QNldpbTFIZTMxeWV3cEh3S1ZPMUp2U2kwVFpzUXY4QUtESE95?=
 =?utf-8?B?YXhxb3Q4RSszcWZkRVBUTnpJZFZ2VDVDZlJTVWhvVHdwcXpSZUhKYUV6MThn?=
 =?utf-8?B?dTRWaWh5WHN4eG4rKzczdUxkODhFeWo0MnNuUlZ2U0tJK3lZUEd1dy9UUlAr?=
 =?utf-8?B?T2tZWkMwNm1kc0xrTzBET1JQWmtxdG94S1J6a3N4RXpYbjlUREtnbDJzTk0r?=
 =?utf-8?B?VUxOeEd5L01aVXRZaDIxSzFlMXNxc0VXY0lTV3Q5VlZrM2xNbVRIaFdkQ1Nv?=
 =?utf-8?B?aEE4ZVFkL1dBdUJMRTRPVW41cUhKTGNTNXU2V0FwbWRIamJGemdEdU4zL1Jt?=
 =?utf-8?B?RDZtUXhzSmxaeldOL2FjczEyYWdVdzJTZ1BoYXpLb21saVZmaTBYNk1VL3kv?=
 =?utf-8?B?TElHd3F2RnE5VmxhWFZUSENFSXFrNUloaVpObTl0TVpDNFhvanRzOWlvNUZF?=
 =?utf-8?B?L1RYczZpaU1BTXR5a243Q3lqaFNKb2E4QzljcnZRVWMzTkhMMFNBTXYyU1FN?=
 =?utf-8?B?TmN0enlDQ0dNR1ZjMWIzS2VUS0NUakVyRG16ZzZxQ2VrSlloYVlWanVoYWVB?=
 =?utf-8?B?WStGRHh0WGpJcVdQQkk0dEtheHViU2lWWi9sTmQxVWZkL2FoSU1sOUdJQ3Zn?=
 =?utf-8?B?Zm1kNUx6WFAxMlE0M3BRNStxSjFveU9OQnpadlBENmJvT0k0TEIwM0Fhd2ly?=
 =?utf-8?B?Y2U3NGdUNmRqSFRtSkQ2MGlicUwzR2dycmhmbW5meHZIS0E9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY3PR18MB4785.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c1QxeFR4K216RUxnbkFyeGo5V2hxbXgwM0lLY3RXTHVoYXMyM0JyalVzSkJ3?=
 =?utf-8?B?NWhSNVFHdm80QlJlU2E4UUhCVlZ4WU4wVUprM25vNkhJMGMxa0ZzTkVUcE5t?=
 =?utf-8?B?RU9rRWRLbXBsNEZXM0Uwc1hsdm9xTUd4KzVaLzl1bWtIUHEzOHBDN2ZMam9q?=
 =?utf-8?B?azVCM25oZlJhYmRiNkR3c2ZNallYa2hHeHhSS1hHZUhnUzczMlEzTEh3U09t?=
 =?utf-8?B?eW9zVFBuYndXb2Y1VjlkUnFMT1l2ZFZEZ3loSWtiSmVrLzd6L1Y4MFZQSS9W?=
 =?utf-8?B?bWgwZmZyUmpxV3Q2eGU1ajQ4cEVTNjNvOWxXa3JUcjZaYUs1NnFaY3ZxY0RC?=
 =?utf-8?B?czM3TkwyelY0dzdPeVc1UHBvWkhib0ZvS2ZCZlkxd1NKSXAzakl1VFR5a2pW?=
 =?utf-8?B?RG5vS1hSdWU1M2o5b2RqemxlcFFRa0lRWTU0NUNOQy90VE9YK0lNWTdFZGhN?=
 =?utf-8?B?Yi9NT29zYzFEM2FKMXQyeEpZOURBaUphaXdlc3VZaFVYY2UrSVNpZXQ1VVAx?=
 =?utf-8?B?MjA0SytWZnRxa2xhSXA1QW9FcUMxVHh4T29OeUhTREE2Q1N3dTU2MlZxR2NV?=
 =?utf-8?B?OGFmRzFjdTRCT29TVTVWK3g4VE15cFFWMFdBdXY0VGppQ1NNTnQyYjZkS1ZF?=
 =?utf-8?B?Z3pQZFBXRHZoL2libThRWS9LQ09jME5JaVowd3h0Ymw2NjdnNnJLYm52dDNv?=
 =?utf-8?B?a0YxblIwNDlJQVVnZmgxOXpaOG8vRFBXTmJUUGtNVHFlNTI1aDdXbXU1dmEw?=
 =?utf-8?B?RDhjRitBS2hHblg1dlB0bXBaRW1kNnBJekwram1RK2dXeDJCTmRoSzM1cWFq?=
 =?utf-8?B?dFBTNDlUenN1NHhhKzBLZWdBUGhNM2hxRFBqNU1KK1ZhUFEzRFdaN0ZjWlRy?=
 =?utf-8?B?aWIxM2NVdldXWC9EUEN3ZWpRTDZoT0NySVJvellWMzhmdVU4RU9nL2E2L003?=
 =?utf-8?B?QnBRdTBBNXhwcm4zT2dsbUVaSHlkWlBWRGsxc1A2cmVaNFMybTJEN3dXQWJh?=
 =?utf-8?B?UGtCVm1BRlBxV1dzSGxjZzBreXhYL3RLa3REZjRERm1tcWEwVyt0VWlrNlY3?=
 =?utf-8?B?V3hsc0txQ1RLYVJYdzlheHNzblFiRGhzNXJ6NnZHOFdKKzU3ZkY3eEtGR0dR?=
 =?utf-8?B?cVE5d0FIbHlwaHFENGVCYlU3TWxQd015emw4VThrR2g2QnJ3emVrOXhzZmU4?=
 =?utf-8?B?SGNDTVc2UUQyWXR2VEVYZGlKWmVhajhpT3ZFcDJvV3pUeGl5ZEFrRFBya0xP?=
 =?utf-8?B?c1BGbXFEREdtWHQrS09JOUV0VUZGN1RXdVdJZ0VlNG5SVzh0bkNSR0RPTWNX?=
 =?utf-8?B?SkRWc2pJMVNLdTBxaWE0MTZtOE5wbXNDT0xIK0hIakxGRVBpMjdSSzlEUzNC?=
 =?utf-8?B?cEpWNmlxK1dwQkNIRVNVMk94WGNVQ3Znc0U2K29hd0kyc2hWUllwWXlFNU0r?=
 =?utf-8?B?SzJEYlAwVjlIbWJZQWd1K0NreVNyWDZLT1o1bkgzUHRRSWRpL1NOblVoakN0?=
 =?utf-8?B?TGd0NWZVemg2QnF6L2hEbW9Jd2E4WjhZQitEVGQ5S1VtaVFPY3BKaVBvS29W?=
 =?utf-8?B?bzBabGFYZ2JWNzkyaTkzR1ZBalA0ODNvV29HSnZTaDUxc0NqUG1FbUVaVlJl?=
 =?utf-8?B?SEU2eTNQYllIVkdCWnQvUjhlUUtkUnJaV3JoT3Z0bkZJK0pYZUZnYXo1SVNm?=
 =?utf-8?B?dVNmZERmQkNRSC9oQ0twaFd4MFFWaFJNWEhGcWtBQzVodkQzM3hqV0UvZXo0?=
 =?utf-8?B?UnFobno3cUlHSzExa1k5SWsya01oMXlmVGZjQ3dHMUtVNFExM3A4cm5ORS8y?=
 =?utf-8?B?d0s4QStjNVhzemVvY05PRzEzQ1lsTVJHWmJjdklIc3RxZ0IrSWVRekRFaTZj?=
 =?utf-8?B?L2JMSmdGUmZkRlc4VEdPNmNiczIxcFBPTmhKWnZMNGk5Yk0rRnlodXlTM2dl?=
 =?utf-8?B?Q3cvTXArbGRZS0xMNXhMNWdsMGtvTEx2U2FDdWZrY2l1a1p4Ulh5bzRGNGRQ?=
 =?utf-8?B?VWNEM3IzUkVzb0M4UDMwVVkzSHVrZSsrVzFtUEFrZUNRYVlrQmhlOFdSdzRQ?=
 =?utf-8?B?cVRWMmVsa0dHZzR2VFZqK2pNYmRVR1h6NlNBT1ZDdTZoNXg3YXdBUTRrdlBJ?=
 =?utf-8?Q?K53k=3D?=
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR18MB4785.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 358215c7-38f6-434a-3cb4-08dd44ebc3ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2025 07:15:55.2553 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KpCfadLZeJoT6HsjYzeJY7FvQ4OCZV+PI810yCTDNguO5DFn8636DE60ZFtO0gO05Gi0AicoBdFu8dp4nkJw6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB3541
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: JolHpo7umfTpds7QglKJ6wSrqNJ7ZUqj
X-Proofpoint-GUID: JolHpo7umfTpds7QglKJ6wSrqNJ7ZUqj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-04_03,2025-01-31_02,2024-11-22_01
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



> -----Original Message-----
> From: Naga Harish K, S V <s.v.naga.harish.k@intel.com>
> Sent: Monday, February 3, 2025 10:08 AM
> To: Jerin Jacob <jerinj@marvell.com>; Shijith Thotton <sthotton@marvell.c=
om>;
> dev@dpdk.org
> Cc: Pavan Nikhilesh Bhagavatula <pbhagavatula@marvell.com>; Pathak, Pravin
> <pravin.pathak@intel.com>; Hemant Agrawal <hemant.agrawal@nxp.com>;
> Sachin Saxena <sachin.saxena@nxp.com>; Mattias R_nnblom
> <mattias.ronnblom@ericsson.com>; Liang Ma <liangma@liangbit.com>;
> Mccarthy, Peter <peter.mccarthy@intel.com>; Van Haaren, Harry
> <harry.van.haaren@intel.com>; Carrillo, Erik G <erik.g.carrillo@intel.com=
>;
> Gujjar, Abhinandan S <abhinandan.gujjar@intel.com>; Amit Prakash Shukla
> <amitprakashs@marvell.com>; Burakov, Anatoly <anatoly.burakov@intel.com>
> Subject: [EXTERNAL] RE: [RFC PATCH] eventdev: adapter API to configure
> multiple Rx queues
>=20
> > -----Original Message----- > From: Jerin Jacob <jerinj@=E2=80=8Amarvell=
.=E2=80=8Acom>
> > > Sent: Thursday, January 30, 2025 10:=E2=80=8A18 PM > To: Naga Harish =
K, S V
> > <s.=E2=80=8Av.=E2=80=8Anaga.=E2=80=8Aharish.=E2=80=8Ak@=E2=80=8Aintel.=
=E2=80=8Acom>; Shijith Thotton > <sthotton@=E2=80=8A
> > marvell.=E2=80=8Acom>;
>=20
>=20
>=20
> > -----Original Message-----
> > From: Jerin Jacob <jerinj@marvell.com>
> > Sent: Thursday, January 30, 2025 10:18 PM
> > To: Naga Harish K, S V <s.v.naga.harish.k@intel.com>; Shijith Thotton
> > <sthotton@marvell.com>; dev@dpdk.org
> > Cc: Pavan Nikhilesh Bhagavatula <pbhagavatula@marvell.com>; Pathak,
> > Pravin <pravin.pathak@intel.com>; Hemant Agrawal
> > <hemant.agrawal@nxp.com>; Sachin Saxena <sachin.saxena@nxp.com>;
> > Mattias R_nnblom <mattias.ronnblom@ericsson.com>; Liang Ma
> > <liangma@liangbit.com>; Mccarthy, Peter <peter.mccarthy@intel.com>;
> > Van Haaren, Harry <harry.van.haaren@intel.com>; Carrillo, Erik G
> > <erik.g.carrillo@intel.com>; Gujjar, Abhinandan S
> > <abhinandan.gujjar@intel.com>; Amit Prakash Shukla
> > <amitprakashs@marvell.com>; Burakov, Anatoly
> > <anatoly.burakov@intel.com>
> > Subject: RE: [RFC PATCH] eventdev: adapter API to configure multiple
> > Rx queues
> >
> >
> > > -----Original Message-----
> > > From: Naga Harish K, S V <s.v.naga.harish.k@intel.com>
> > > Sent: Thursday, January 30, 2025 9:01 PM
> > > To: Jerin Jacob <jerinj@marvell.com>; Shijith Thotton
> > > <sthotton@marvell.com>; dev@dpdk.org
> > > Cc: Pavan Nikhilesh Bhagavatula <pbhagavatula@marvell.com>; Pathak,
> > > Pravin <pravin.pathak@intel.com>; Hemant Agrawal
> > > <hemant.agrawal@nxp.com>; Sachin Saxena <sachin.saxena@nxp.com>;
> > > Mattias R_nnblom <mattias.ronnblom@ericsson.com>; Liang Ma
> > > <liangma@liangbit.com>; Mccarthy, Peter <peter.mccarthy@intel.com>;
> > > Van Haaren, Harry <harry.van.haaren@intel.com>; Carrillo, Erik G
> > > <erik.g.carrillo@intel.com>; Gujjar, Abhinandan S
> > > <abhinandan.gujjar@intel.com>; Amit Prakash Shukla
> > > <amitprakashs@marvell.com>; Burakov, Anatoly
> > > <anatoly.burakov@intel.com>
> > > Subject: [EXTERNAL] RE: [RFC PATCH] eventdev: adapter API to
> > > configure multiple Rx queues
> > >
> > > > -----Original Message----- > From: Jerin Jacob <jerinj@=E2=80=8Amar=
vell.
> > > > com>
> > > > > Sent: Wednesday, January 29, 2025 1:=E2=80=8A13 PM > To: Naga Har=
ish K,
> > > > > S V
> > > > <s.=E2=80=8Av.=E2=80=8Anaga.=E2=80=8Aharish.=E2=80=8Ak@=E2=80=8Aint=
el.=E2=80=8Acom>; Shijith Thotton > <sthotton@
> > > > marvell.=E2=80=8Acom>;
> > >
> > >
> > >
> > > > -----Original Message-----
> > > > From: Jerin Jacob <jerinj@marvell.com>
> > > > Sent: Wednesday, January 29, 2025 1:13 PM
> > > > To: Naga Harish K, S V <s.v.naga.harish.k@intel.com>; Shijith
> > > > Thotton <sthotton@marvell.com>; dev@dpdk.org
> > > > Cc: Pavan Nikhilesh Bhagavatula <pbhagavatula@marvell.com>;
> > > > Pathak, Pravin <pravin.pathak@intel.com>; Hemant Agrawal
> > > > <hemant.agrawal@nxp.com>; Sachin Saxena <sachin.saxena@nxp.com>;
> > > > Mattias R_nnblom <mattias.ronnblom@ericsson.com>; Liang Ma
> > > > <liangma@liangbit.com>; Mccarthy, Peter
> > > > <peter.mccarthy@intel.com>; Van Haaren, Harry
> > > > <harry.van.haaren@intel.com>; Carrillo, Erik G
> > > > <erik.g.carrillo@intel.com>; Gujjar, Abhinandan S
> > > > <abhinandan.gujjar@intel.com>; Amit Prakash Shukla
> > > > <amitprakashs@marvell.com>; Burakov, Anatoly
> > > > <anatoly.burakov@intel.com>
> > > > Subject: RE: [RFC PATCH] eventdev: adapter API to configure
> > > > multiple Rx queues
> > > >
> > > >
> > > >
> > > > > -----Original Message-----
> > > > > From: Naga Harish K, S V <s.v.naga.harish.k@intel.com>
> > > > > Sent: Wednesday, January 29, 2025 10:35 AM
> > > > > To: Shijith Thotton <sthotton@marvell.com>; dev@dpdk.org
> > > > > Cc: Pavan Nikhilesh Bhagavatula <pbhagavatula@marvell.com>;
> > > > > Pathak, Pravin <pravin.pathak@intel.com>; Hemant Agrawal
> > > > > <hemant.agrawal@nxp.com>; Sachin Saxena <sachin.saxena@nxp.com>;
> > > > > Mattias R_nnblom <mattias.ronnblom@ericsson.com>; Jerin Jacob
> > > > > <jerinj@marvell.com>; Liang Ma <liangma@liangbit.com>; Mccarthy,
> > > > > Peter <peter.mccarthy@intel.com>; Van Haaren, Harry
> > > > > <harry.van.haaren@intel.com>; Carrillo, Erik G
> > > > > <erik.g.carrillo@intel.com>; Gujjar, Abhinandan S
> > > > > <abhinandan.gujjar@intel.com>; Amit Prakash Shukla
> > > > > <amitprakashs@marvell.com>; Burakov, Anatoly
> > > > > <anatoly.burakov@intel.com>
> > > > > Subject: [EXTERNAL] RE: [RFC PATCH] eventdev: adapter API to
> > > > > configure multiple Rx queues
> > > > > > >
> > > > > > >This requires a change to the
> > > > > > >rte_event_eth_rx_adapter_queue_add()
> > > > > > >stable API parameters.
> > > > > > >This is an ABI breakage and may not be possible now.
> > > > > > >It requires changes to many current applications that are
> > > > > > >using the
> > > > > > >rte_event_eth_rx_adapter_queue_add() stable API.
> > > > > > >
> > > > > >
> > > > > > What I meant by mapping was to retain the stable API
> > > > > > parameters as they
> > > > are.
> > > > > > Internally, the API can use the proposed eventdev PMD
> > > > > > operation
> > > > > > (eth_rx_adapter_queues_add) without causing an ABI break, as
> > > > > > shown
> > > > below.
> > > > > >
> > > > > > int rte_event_eth_rx_adapter_queue_add(uint8_t id, uint16_t
> > eth_dev_id,
> > > > > >                 int32_t rx_queue_id,
> > > > > >                 const struct rte_event_eth_rx_adapter_queue_con=
f *conf) {
> > > > > >         if (rx_queue_id =3D=3D -1)
> > > > > >                 dev->dev_ops->eth_rx_adapter_queues_add)(
> > > > > >                         dev, &rte_eth_devices[eth_dev_id], 0,
> > > > > >                         conf, 0);
> > > > > >         else
> > > > > >                 dev->dev_ops->eth_rx_adapter_queues_add)(
> > > > > >                         dev, &rte_eth_devices[eth_dev_id], &rx_=
queue_id,
> > > > > >                         conf, 1); }
> > > > > >
> > > > > > With above change, old op (eth_rx_adapter_queue_add) can be
> > > > > > removed as both API (stable and proposed) will be using
> > > > eth_rx_adapter_queues_add.
> > > >
> > > >
> > > > Since this thread is not converging and looks like it is due to con=
fusion.
> > > > I am trying to summarize my understanding to define the next
> > > > steps(like if needed, we need to reach tech board if there are no
> > > > consensus)
> > > >
> > > >
> > > > Problem statement:
> > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > 1) Implementation of rte_event_eth_rx_adapter_queue_add() in HW
> > > > typically uses an administrative function to enable it. Typically,
> > > > it translated to sending a mailbox to PF driver etc.
> > > > So, this function takes "time" to complete in HW implementations.
> > > > 2) For SW implementations, this won't take time as there is no
> > > > other actors involved.
> > > > 3) There are customer use cases, they add 300+
> > > > rte_event_eth_rx_adapter_queue_add() on application bootup, that
> > > > is introducing significant boot time for the application.
> > > > Number of queues are function of number of ethdev ports, number
> > > > of ethdev Rx queues per port and number of event queues.
> > > >
> > > >
> > > > Expected outcome of problem statement:
> > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > 1) The cases where application knows queue mapping(typically at
> > > > boot time case), application can call burst variant of
> > > > rte_event_eth_rx_adapter_queue_add()
> > > > function
> > > > to amortize the cost. Similar scheme used DPDK in control path API
> > > > where latency is critical, like rte_acl_add_rules() or rte_flow
> > > > via template scheme.
> > > > 2) Solution should not break ABI or any impact to SW drivers.
> > > > 3) Avoid duplicating the code as much as possible
> > > >
> > > >
> > > > Proposed solution:
> > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > 1) Update eventdev_eth_rx_adapter_queue_add_t() PMD (Internal ABI)
> > > > API to take burst parameters
> > > > 2) Add new rte_event_eth_rx_adapter_queue*s*_add() function and
> > > > wire to use updated PMD API
> > > > 3) Use rte_event_eth_rx_adapter_queue_add() as
> > > > rte_event_eth_rx_adapter_queue*s*_add(...., 1)
> > > >
> > > > If so, I am not sure what is the cons of this approach, it will
> > > > let to have optimized applications when
> > > > a) Application knows the queue mapping at priorly (typically in
> > > > boot
> > > > time)
> > > > b) Allow HW drivers to optimize without breaking anything for SW
> > > > drivers
> > > > c) Provide applications to decide burst vs non burst selection
> > > > based on the needed and performance requirements
> > >
> > > The proposed API benefits only some hardware platforms that have
> > > optimized the "queue_add" eventdev PMD implementation for burst mode.
> > > It may not benefit SW drivers/other HW platforms.
> >
> > The sprint is to have ONE API for all drivers(SW or HW). If one driver
> > is not able to leverage feature is OK as long it is NOT breaking
> > anything. We been accommodating ton of capabilities(like
> > RTE_EVENT_DEV_CAP_DISTRIBUTED_SCHED)
> > And SW driver specific public API(like
> > rte_event_eth_rx_adapter_service_id_get()) to have Common API. As long
> > as it does not break each other and application has clarity on the
> > usage (when to use the API) I don=E2=80=99t see any issue. Do you see a=
ny
> > issue with that forward progress approach?
> >
>=20
> This approach is fine, as long as it is not breaking the other platforms.

Agree

>=20
> >
> > > There will not be much difference in calling the existing API
> > > (rte_event_eth_rx_adapter_queue_add()) in a loop vs using the new
> > > API for the above cases.
> >
> > That is just A implementation view. Right? I have explained in the
> > problem statement which is the not case for some drivers.(Even SW
> > driver can leverage such burst function using SIMD etc, if one driver
> > wants to)
> >
>=20
> Not Just from the implementation point of view, but from the latency
> improvement also.
> Anyway, I am fine with the new API approach.

Thanks

>=20
> > >
> > > If the new proposed API benefits all platforms, then it is useful.
> >
> > See above.
> >
> >
> > > This is the point I am making from the beginning, it is not captured
> > > in the summary.
