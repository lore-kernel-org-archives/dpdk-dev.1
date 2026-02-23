Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53D16EEC2A4
	for <dpdk-dev@archiver.kernel.org>; Mon, 23 Feb 2026 22:31:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4EC00402C9;
	Mon, 23 Feb 2026 23:31:49 +0100 (CET)
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11022089.outbound.protection.outlook.com
 [40.107.200.89])
 by mails.dpdk.org (Postfix) with ESMTP id EA0EB4025D;
 Mon, 23 Feb 2026 23:31:47 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V7ETl+1VQWAIUblNCwGmEdFS35jXr3cBOd1AlLmgqm8GAR8FNmQTOLG58rlEsnP2Y0r5sGF4bvG0/gt6u5gUsz5ThIZta8Q6+elBTUgRYTpu2tNjG+zwHbzDgL/HdXBdYXa85DcR1t89e7DHC4hZyxlFLyMRSzS5C6wDSbZ2iSnVfKNXCUQzHw0/6Xx+epM6BBLWlyRd8GYJ3BslrVCDnAfsbF0/7kBiZWn/4HAWP8ha+yIaQvkRqOdBFgal4swq0yeEanoJai/+ktwZrpKsLPMrI8S/vc6x25SimH9v1iiqBXN4ON45rHOwcA237oQ7pqEevZ8c0VxHWc7GcpveRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3eetSxf8VlgNSriIU6MfL4q4aedA+FouHFxufrILibg=;
 b=gUJIPo9m8uVhCe2WXBe8cikQsoHNNoqsfp4RcjY0A/r73lV4aK6xb2/ookWfottJsUsho3mP1tInnPMh+eNu+TktPH3PS7nU88cXKRx8Uve2TljrsKFAFTERgd+6MdHEfQidiM6a+5uWxONOBYMTNrmdw/PE15RJ9IiunPOrfhljG7VkfPQnpuJrvn67Aj2xThUYFjMuLfaD2exELW3aI8ogGb1Aq+AX9mn+7K7INMlInC5l/oAaF4Us81NBF9FcW7Xvcob4j5Loy5p6jLG3qJObBCvpMa/F9ghJvjPArZtfyC7WjSeJByi62PH07P1ajfP37RHAYTtXNeIEABe75w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3eetSxf8VlgNSriIU6MfL4q4aedA+FouHFxufrILibg=;
 b=HDXj1Ryqdg8mmetQG+QeOHzV85rnEEj9N5TehfNvdPxBYgqUoHlprL4+ihfiVkyyaAB4cLf0BHeLSSAgAS4VjJtJxUVYzPyoRkWc3nLrmeIFF6iAQwuFan3zDzCjH+SNdtKjrbDZXnXjJ3zpnBRz2r7sRWmorfc8SsNTXcUwgLo=
Received: from DS3PR21MB5735.namprd21.prod.outlook.com (2603:10b6:8:2e0::20)
 by DS2PR21MB4894.namprd21.prod.outlook.com (2603:10b6:8:2b5::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.10; Mon, 23 Feb
 2026 22:31:44 +0000
Received: from DS3PR21MB5735.namprd21.prod.outlook.com
 ([fe80::a3f4:6107:de7c:5925]) by DS3PR21MB5735.namprd21.prod.outlook.com
 ([fe80::a3f4:6107:de7c:5925%5]) with mapi id 15.20.9654.007; Mon, 23 Feb 2026
 22:31:44 +0000
From: Long Li <longli@microsoft.com>
To: Stephen Hemminger <stephen@networkplumber.org>,
 "longli@linux.microsoft.com" <longli@linux.microsoft.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, Wei Hu <weh@microsoft.com>,
 "stable@dpdk.org" <stable@dpdk.org>, Dariusz Sosnowski
 <dsosnowski@nvidia.com>, Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing
 Zhao <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
Subject: RE: [EXTERNAL] Re: [PATCH v2 2/8] net/netvsc: fix race conditions on
 VF add/remove events
Thread-Topic: [EXTERNAL] Re: [PATCH v2 2/8] net/netvsc: fix race conditions on
 VF add/remove events
Thread-Index: AQHcotwvGs3rNY/u8kq5pa6jSv3rWbWQkkEAgABPpxA=
Date: Mon, 23 Feb 2026 22:31:44 +0000
Message-ID: <DS3PR21MB57352423897B07D12A851040CE77A@DS3PR21MB5735.namprd21.prod.outlook.com>
References: <20260221024540.659098-1-longli@linux.microsoft.com>
 <20260221024540.659098-2-longli@linux.microsoft.com>
 <20260223094358.58f5b0f4@phoenix.local>
In-Reply-To: <20260223094358.58f5b0f4@phoenix.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=bd5d4943-0dde-4f63-9a81-e31d15bfddfb;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-02-23T22:29:03Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS3PR21MB5735:EE_|DS2PR21MB4894:EE_
x-ms-office365-filtering-correlation-id: 4d8192dc-5519-4f4e-1244-08de732b5307
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?YkFzQlJBZ0xBdTNlT0NKWDZWVURsWmtqNzQrdGFzNTBaR1h1RzhOM2ZvK3Jv?=
 =?utf-8?B?eU54UHlSRFFhNnBmZ2J6Nk9wZEZxbVJYWVlnNVdTMkljcXR2YmFTcGdHQVFQ?=
 =?utf-8?B?cmI0Njc0ditIbzl4c2pUbXl6cnpiS0hYRVFpUzlISm56cGNRVXVOejNyNzVM?=
 =?utf-8?B?NmNpUzAxMkwydU9JNnYxa2QrVzBDSVRLU1BsNVBvSHQ5Y2VOZVhiZERTNjNj?=
 =?utf-8?B?bnR0dDlydVlHR2EzQkVHajFIK1J5Qkc3Q2FOdVd6SDhKR0hYNElteEhBTm1L?=
 =?utf-8?B?OVlTRE1NK0cwRkFhZVVqRmVMa3hubHRZUW02T25zNUZucUVQSGorS2o3SWJt?=
 =?utf-8?B?aXc0d0ZIM3QrNjhpaEFhUUE5R1EyZGpxbjVCRyt5N2pxNWIzRExiME9OQ2tj?=
 =?utf-8?B?ZHJXVHlzb25RVlZjcWgxNDBibjJtclNXTUJlYVpYbHlwK3BBV05VbVdPNW5w?=
 =?utf-8?B?SE9KMGVNQ3lsM0orSXRRR2tsdnlJaWFPUGxkVDBsdGRsaE9qVytrajN2RC9Y?=
 =?utf-8?B?MGhyU1JJMHlZZHJYaWVsMEV0SVBTc2o4Y3BhL1NrSzRzWFM1UmRkN0trSnY5?=
 =?utf-8?B?TnlOZ1FWQ1BMLyt6dTdNaG9QZUMwdE5oYVNuS1dtWEE2bmxVNUtPY0Y1dEJv?=
 =?utf-8?B?K0JTTWwxNWRsVkI5U3pLRXRjdUZjSStWOFYxaWpSTVdWYWMzNmNITVUzb0Za?=
 =?utf-8?B?Q1p1K3NneUNtcWR2QTdHSkZrcS8wTndwWnVma2lvZkJ2WUdhRGM0NElrUmpr?=
 =?utf-8?B?dEorbHJML1dvQUlycG5XSjlsUHU2MVY2TFJJaXViQTkzak5MaTNkYXpFUkJn?=
 =?utf-8?B?M0NZYU5zeGNPOFgyK1RLZ2l1cXNhdzNZdXNLazV6d3BXU3JkTmkrNE1Kc3ZY?=
 =?utf-8?B?bHhJOThHcTdURW93SW4xNER6aG9FWlYrcnY3TzA2ekg4U05vN3M1bjBTZWtG?=
 =?utf-8?B?VDRvTkdPM3JxaFIrK3VHaHE5V3Z6M1Z4QlN4M1J6bFlCeURiMWJjeXZUTHBr?=
 =?utf-8?B?QzduRm9WMEhDeWI5dUNvT3YwVEhnLzBvbGFmTy9lcXZZQ0RLaHdtOXUzcmxh?=
 =?utf-8?B?cU8wSlQ4TDJkLzR2TUgvN3dBUXF5STBhYVZNdUYrNEM5ZC81Ty93STliVjVw?=
 =?utf-8?B?Z1ZFak1mSnpIOFcvNG5LZFEySmVzWFpQUjJJU1B2L0xWMXBFUmFRRGc1UzdH?=
 =?utf-8?B?L3dkczRyL2E2ZW5MVEtwdEdqejE2MFBIZGJGa1NKMEJOSThQZklaVHNpWWtC?=
 =?utf-8?B?Z3g3ejArSG9oV1Y1R3h5OWhEakVmeG1zak9DUjEydkQ3d09oWnoza095VGNx?=
 =?utf-8?B?U29BdDB2aGtUZmQvblEzWVFIQTZEUUd1djlEenVZdUVTN0dSRUFwMXVDcUlh?=
 =?utf-8?B?MkNCOFB4RmxnVmJXalljVm9XQThUMjhXamVvcDVDckkreFJjSm9YVTQwT3RF?=
 =?utf-8?B?Q2k0Qnd4cTRvRXlhWVhaempZSHFJQ0R4b3NLR2w0eEpRSG8zY25OU1NHV3B3?=
 =?utf-8?B?SnYxSU9ycitueVI1NjRiNUN5MWZtL1hreU9ZN2dkdVNyWTlMdkN6ZjN0K3lO?=
 =?utf-8?B?MkRlQlNWQ1FWOFlRSVNTLzNsTERSQndnMmQzamIrTTNZeDloUnJEclgyRkJU?=
 =?utf-8?B?Y3VIdFVjZE9VOGJ5WFB1QldqRXhNSldJZUpiRmt5U3owSmVpQ0dNSDRlY0Rs?=
 =?utf-8?B?Tyt0SW1BWXdycGVUK3BCS2NUWHQ2bVIxTXhQRkZaT3oxL3VVQjM1WjNIamlk?=
 =?utf-8?B?c3A4OEEyNGxqT3lKOUxLUEtLTDNIaVpmNUp5MHFvemJ3WGY5bmRXZldGQmZY?=
 =?utf-8?B?WmhTL0NHUnp1SzkveGttamFxRUFWbWx6ak9HKzNINW1sUkV0NW9LR0xrZWpW?=
 =?utf-8?B?aDdtL2RMT2pZcER0aWljMlBPenBTUE4zMzlZUkE4a3VNN282aXJaVzFkSnhN?=
 =?utf-8?B?OHV0OTY4Nm8wbkppYVFMUUZVOTQ5K1ZyTVYvMnpqdDVGeHZyaE83Vkp6Tytk?=
 =?utf-8?B?cUFoKzljMDRDZ0k5cEFBaGJPR3grdGJFVlJKc2p3dnZoeXVzc2E0dlVVSjVn?=
 =?utf-8?B?WlhWL2xXcjlGSUxzeThFUDNBY3BLNVRZeUZVNGRtclFrQ2llc3FIYUF5dzZO?=
 =?utf-8?B?eDRidDlWbUF1TmxsQVpHaFZLU0lHelBjWmRvQlZsNjFuYVdTdWhCZzYzR0FO?=
 =?utf-8?Q?+gWDHOJLsEFTI/jCD0VCvVo=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS3PR21MB5735.namprd21.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M0VZRFR4bVFPV29IMWMvMmdQV1UxQW9JT1RONDZQM2N6NHZDNGczQXZSV2k1?=
 =?utf-8?B?QU13dkVrelpOYi9UTVVDTGJRdDZvT1NaLzdGUUo0MlRHUUcxc21DLzdEd3dk?=
 =?utf-8?B?L1JIOCt2TUtpb1M2SjdEU1h5MHUwYlhGalZnTkZoUDUzWVhwN0YvWHY1eU1z?=
 =?utf-8?B?WHJORFBQMUlPTnhWWmJOYjNvWmYraEVtUDA5VU5uTnBWVVhVUFFOWHJaS3Rx?=
 =?utf-8?B?L2VEOE1IQUIrMUlQUmQ4ZFYrNEQva0R6WUZ2R0w1bWliWnU1MVFzdmVIUnNM?=
 =?utf-8?B?cG14WWlmdlJxc1M3REZyRXc1YlcxRzRLdHhKMjRXSkNTaUphQXZhWG03bnAy?=
 =?utf-8?B?Y2tGbko2cXZCRG1kWUo5dk54SVN6WWd1WVFObFBHRVhnbXFKc2g5MzhVUlVO?=
 =?utf-8?B?dHBpOGR4SUlkd2J2aVFrVHZHNmY2T3BIZ0dIelhsTEk0MVh0YVdoQ3IyUUJx?=
 =?utf-8?B?NHhZTnNCOGNDM205RU5YU2pZRFl0VUowOVd5Nm0vRGpzUFRIa05zS2VZMXhP?=
 =?utf-8?B?NHpyKy9aZDdRd1JjVUN2QjVWZ3RlRGhKWE5lRTZvR29qb2Vua0ZOT0dpQU9K?=
 =?utf-8?B?bzlHUDNiUjRYOHBxbUtmdlFqdFRWMUt5TkoxSG93S2ZQMER4QjdDcnFjSSth?=
 =?utf-8?B?VVRlek11M0RIb2VtT0pjaUdMdnRIcndmdU8vcjZwNVdrVFB1YWFoTUM4djc3?=
 =?utf-8?B?WlJROEpsT01JdHpvQWJ6WGtBT0tvc1V2Rm5za0llN0JNTW1wTlNPbG5YTkFz?=
 =?utf-8?B?WDBJaXZ5ZVNBKzRyaFM4amRzNlJhUHJrNElCTU1nWlZnWjdsSjZaNk5vTkJZ?=
 =?utf-8?B?WnhPOXl4bmE4blJwc1hMdmhxaVE0aDlYdlBobEV0SkpjWStuWGVxU0JNbTFs?=
 =?utf-8?B?WW5EMGJRNVhtQkRiL1lSRzJ6UjdtQXliR2JuQkhhcXduRlJIRXFvck9sVkFF?=
 =?utf-8?B?ZmZoRU5FVnluTEF4OWQ2Ly9aR0poWFNDZFNGQjJxNHhPdGtjRmxwL09TanRS?=
 =?utf-8?B?RGxzNzc0NlhqeElrc05NUE5YZTc5SGlHWVlzVW9KV0Jpd05xMFAvb0dSeVV1?=
 =?utf-8?B?eEhNOTRidFExU0FaQU1ldFp6VFVlZytSaTlyNFJVNjJKTERwL2RBRGNjMW1U?=
 =?utf-8?B?MkZnQThuSWlQN1ZJWGtQRWM0M2tlcjQ5TmtrSjV1UXA1ZkhlaUh6VXY1Zksw?=
 =?utf-8?B?bjZURE1Mc0FITGt3TkdhMWlZdEtmYWVQdzdYMlZQR2txcEIzeVJpYjBIdWNS?=
 =?utf-8?B?QXVEdWtnWGlqc3NuNFpqazRteHlTa0hjMVdTSXQza25ESkVpdElkNnJkYjkx?=
 =?utf-8?B?a3RFdUxwSThidEpUaGhVQW4yTExUTC8ySzVQVmdEalFYRURhYWpCcVdpRzha?=
 =?utf-8?B?UGt3dFdYcVVid3dmdWhORnMyVzcvSXV1aWJPQmJmQnlkdFFxc21jbUxZSWpO?=
 =?utf-8?B?anhjMEIrSXk5c25GU1RhVXJwaWNSZ0t3dlQzeDJMdHVTdWdzL2k0N2pRSW9y?=
 =?utf-8?B?UUpFdEF0d2RPMmE1aEdIYW9qa0x0L1BwVHlpU2d5QkJ3ZUJKaVRRVFRMTk1z?=
 =?utf-8?B?eTM0cnV0MHI1V2NEQjIrUEFwbnhLMzFNL05qZXdYWHBwZE5GRmV6QTZ4VnM2?=
 =?utf-8?B?cmJtdUR5b25aWllJRjdZL2twTGZ4THkxQjdDd25GWkVZSEw5MjhEaDhjSjdN?=
 =?utf-8?B?V0hoY1VpNlE0Ym4rV3hiSE5EVkc1WjBTRCtPejN2cmNYZmVDTXI5a2VxcFlV?=
 =?utf-8?B?TEt5YVdpRkNiWndMRGhHWWhUMUR0K3Z2Z1VjenNSY2pxcU9DbmowV0tXWHZy?=
 =?utf-8?B?RHZERWhXaU9VNWV1dEwyMVREcklVaU5HS3FTeHRaVXBSU01VTmJYVWZIQUhQ?=
 =?utf-8?B?WFQyY0VaUUtLTGoyYklubTg4VnlORWpoaHhJTm1QeUVOUGZzY3h6ZjQxd2Nu?=
 =?utf-8?B?emJxQkdlU1k5U0lWRW5MOFVKOTJpZC9CckwzZmNZKzhsSWMvdWdBL3FQN2da?=
 =?utf-8?B?WThsVjNsZXZ5VmtaN0Q2eTFOcTFmMWRmcHp6SVZpNWRMOHhzQWV2T2NtVHE3?=
 =?utf-8?B?V1VOL0VlckwvNXRLaVIwZm43UEgrZXV2bWpRYmRCQzN5VzlKV0hJL0RDQkdo?=
 =?utf-8?B?R2RkQ2pCeGxiQ29zN3hhQzg3aGk3VWhhRXJ5SkU2TGwraFAwWThNSWsvdWU4?=
 =?utf-8?B?SkpWb28xdEVGdmphd1IyOCsxY0piQ24zR3lMTHZQd2tnRnVqRHFsUW5SZTFy?=
 =?utf-8?B?RnEyWWJJYWRtbEJiN3NxaHM5eVdSTnN2bk5hSjhkTzJBY3FNRFN6VDhQb1NP?=
 =?utf-8?Q?uxa/TbJ/fLlRiN5jAl?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS3PR21MB5735.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d8192dc-5519-4f4e-1244-08de732b5307
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2026 22:31:44.6676 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DUmcI0lSeJ8jAl80pvNldIFb6BVzz+oTcf5KMiso9jjUYscyLb9LHOv1Yk4I+/7Fl7BGUxjDD7/vxwcSpD6C8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR21MB4894
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

PiBTdWJqZWN0OiBbRVhURVJOQUxdIFJlOiBbUEFUQ0ggdjIgMi84XSBuZXQvbmV0dnNjOiBmaXgg
cmFjZSBjb25kaXRpb25zIG9uIFZGDQo+IGFkZC9yZW1vdmUgZXZlbnRzDQo+IA0KPiBPbiBGcmks
IDIwIEZlYiAyMDI2IDE4OjQ1OjIxIC0wODAwDQo+IGxvbmdsaUBsaW51eC5taWNyb3NvZnQuY29t
IHdyb3RlOg0KPiANCj4gPiBGcm9tOiBMb25nIExpIDxsb25nbGlAbWljcm9zb2Z0LmNvbT4NCj4g
Pg0KPiA+IE5ldHZzYyBnZXRzIG5vdGlmaWNhdGlvbiBmcm9tIFZTUCBvbiBWRiBhZGQvcmVtb3Zl
IG92ZXIgVk1CVVMsIGJ1dCB0aGUNCj4gPiB0aW1pbmcgbWF5IG5vdCBtYXRjaCB0aGUgRFBESyBz
ZXF1ZW5jZSBvZiBkZXZpY2UgZXZlbnRzIHRyaWdnZXJlZCBmcm9tDQo+ID4gdWV2ZW50cyBmcm9t
IGtlcm5lbC4NCj4gPg0KPiA+IFJlbW92ZSB0aGUgcmV0cnkgbG9naWMgZnJvbSB0aGUgY29kZSB3
aGVuIGF0dGFjaCB0byBWRiBhbmQgcmVseSBvbg0KPiA+IERQREsgZXZlbnQgdG8gYXR0YWNoIHRv
IFZGLiBXaXRoIHRoaXMgY2hhbmdlLCBib3RoIHRoZSBub3RpZmljYXRpb25zDQo+ID4gZnJvbSBW
U1AgYW5kIHRoZSBEUERLIHdpbGwgYXR0ZW1wdCBhIFZGIGF0dGFjaC4NCj4gPg0KPiA+IEFsc28g
aW1wbGVtZW50IGxvY2tpbmcgd2hlbiBjaGVja2luZyBvbiBhbGwgVkYgcmVsYXRlZCBmaWVsZHMu
DQo+ID4NCj4gPiBGaXhlczogYTJhMjNhNzk0YjNhICgibmV0L25ldHZzYzogc3VwcG9ydCBWRiBk
ZXZpY2UgaG90IGFkZC9yZW1vdmUiKQ0KPiA+IENjOiBzdGFibGVAZHBkay5vcmcNCj4gPg0KPiA+
IFNpZ25lZC1vZmYtYnk6IExvbmcgTGkgPGxvbmdsaUBtaWNyb3NvZnQuY29tPg0KPiANCj4gQUkg
cmV2aWV3IHNwb3R0ZWQgcmVsYXRlZCBpc3N1ZS4NCj4gDQo+ICoqUGF0Y2ggMiAobmV0L25ldHZz
YzogZml4IHJhY2UgY29uZGl0aW9ucyBvbiBWRiBhZGQvcmVtb3ZlIGV2ZW50cykqKiDigJQgdGhl
DQo+IG1vc3QgY29tcGxleCBwYXRjaCBpbiB0aGUgc2VyaWVzLg0KPiANCj4gKipXaGF0IGl0IGZp
eGVzIGNvcnJlY3RseToqKg0KPiANCj4gVGhlIG9sZCBUeC9SeCBwYXRocyBoYWQgYSBUT0NUT1Ug
cmFjZTogdGhleSBjaGVja2VkIGB2Zl92c2Nfc3dpdGNoZWRgIHdpdGhvdXQNCj4gdGhlIGxvY2ss
IGFjcXVpcmVkIHRoZSBsb2NrLCB0aGVuIHJlLWNoZWNrZWQuIEEgVkYgcmVtb3ZlIGNvdWxkIGNv
bXBsZXRlDQo+IGJldHdlZW4gdGhlIGZpcnN0IGNoZWNrIGFuZCB0aGUgbG9jayBhY3F1aXNpdGlv
bi4gVGhlIG5ldyBjb2RlIHRha2VzIHRoZSByZWFkDQo+IGxvY2sgKmJlZm9yZSogYW55IFZGIHN0
YXRlIGNoZWNrcyDigJQgY29ycmVjdCBmaXguIFRoZSBsb2NrIGlzIHByb3Blcmx5IHJlbGVhc2Vk
IG9uDQo+IGJvdGggcGF0aHMuDQo+IA0KPiBUaGUgdXBncmFkZSBvZiBgaG5fdmZfY2xvc2UoKWAg
ZnJvbSByZWFkIGxvY2sgdG8gd3JpdGUgbG9jayBpcyBhbHNvIGEgcmVhbCBidWcgZml4LA0KPiBz
aW5jZSBpdCBtb2RpZmllcyBgdmZfYXR0YWNoZWRgIGFuZCBjYWxscyBgcnRlX2V0aF9kZXZfY2xv
c2UoKWAuDQo+IA0KPiBNb3ZpbmcgY2FsbGJhY2sgcmVnaXN0cmF0aW9uIGludG8gYGhuX3ZmX2F0
dGFjaCgpYCB3aXRoIHByb3BlciByb2xsYmFjayAodmlhIHRoZQ0KPiBuZXcgYGhuX3ZmX2RldGFj
aCgpYCBoZWxwZXIpIGlzIGEgZ29vZCBzdHJ1Y3R1cmFsIGltcHJvdmVtZW50IHRoYXQgdGllcyBj
YWxsYmFjaw0KPiBsaWZldGltZSB0byBWRiBhdHRhY2gvZGV0YWNoIGxpZmVjeWNsZS4NCj4gDQo+
IFRoZSB1bmNvbmRpdGlvbmFsIGNsZWFyIG9mIGB2Zl92c2Nfc3dpdGNoZWRgIGluIGBobl92Zl9y
ZW1vdmVfdW5sb2NrZWQoKWAgaXMNCj4gY29ycmVjdCDigJQgaWYgdGhlIFZGIGlzIGJlaW5nIHJl
bW92ZWQsIHRoZSBzd2l0Y2hlZCBmbGFnIG11c3QgYmUgY2xlYXJlZA0KPiByZWdhcmRsZXNzIG9m
IHdoZXRoZXIgYGhuX252c19zZXRfZGF0YXBhdGgoU1lOVEhFVElDKWAgc3VjY2VlZGVkLg0KPiAN
Cj4gKipPbmUgcG90ZW50aWFsIGNvbmNlcm4gKH42MCUgY29uZmlkZW5jZSk6KioNCj4gDQo+IElm
IHRoZSBWRiBpcyBzdWNjZXNzZnVsbHkgY29uZmlndXJlZCBhbmQgc3RhcnRlZCBidXQgYGhuX252
c19zZXRfZGF0YXBhdGgoVkYpYA0KPiBmYWlscyBhdCB0aGUgYHN3aXRjaF9kYXRhX3BhdGg6YCBs
YWJlbCwgdGhlIGZ1bmN0aW9uIHJldHVybnMgYW4gZXJyb3IgYnV0IGxlYXZlcyB0aGUNCj4gVkYg
c3RhcnRlZCBhbmQgYXR0YWNoZWQuIFRoZSBjYWxsZXJzIGRvbid0IGNsZWFuIHRoaXMgdXAuIFRo
aXMgaXMgYSBwcmUtZXhpc3RpbmcNCj4gZGVzaWduIGlzc3VlIHRoZSBwYXRjaCBkb2Vzbid0IHdv
cnNlbiwgYW5kIHRoZSBoeXBlcnZpc29yIG1heSByZXRyeSwgYnV0IGl0IGNvdWxkDQo+IGNvbmZ1
c2Ugc3Vic2VxdWVudCBhZGQvcmVtb3ZlIGN5Y2xlcy4NCg0KSSB0aGluayBpdCdzIHNhZmUgdG8g
bGVhdmUgdGhpcyBjb2RlIGFzIGlzLiBBbHRob3VnaCBWRiBpcyBzdGFydGVkIGFuZCBhdHRhY2hl
ZCwgbmV0dnNjIHdpbGwgbmV2ZXIgdXNlIHRoZSBWRiBzaW5jZSB2Zl92c2Nfc3dpdGNoZWQgaXMg
bm90IHNldC4gVGhpcyBpcyBzaW1pbGFyIHRvIHdoYXQgbmV0dnNjIGRvZXMgaW4gdGhlIGtlcm5l
bC4NCg==
