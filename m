Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EB69C54FD2
	for <dpdk-dev@archiver.kernel.org>; Sat, 21 Feb 2026 02:47:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E754B4025A;
	Sat, 21 Feb 2026 03:47:13 +0100 (CET)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11020130.outbound.protection.outlook.com [52.101.56.130])
 by mails.dpdk.org (Postfix) with ESMTP id F20FE40150
 for <dev@dpdk.org>; Sat, 21 Feb 2026 03:47:10 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BKCZQ32NPmktcIq39YZK1h6nHzL3YPoN9XJIfH5gLRi4skZNRUff5Pm19kh+30w3AySx6mLZYu18sLBuUI2oEVdMME0hdsmlBy8Uro5mUrvxs2juAnDtiaeHKmnS8VClF501kz8FGpo93r5XXPwGHTuDCTu3xrXqExA9rViy/S4VNV2/rFBmDMXYFblH8Rx3TCu8g550Jy+pnmSUcPdL1XT63w89xysPcVCZ48pjdKSokUI3gKgsRiuuMQNqxjUtCrZw8qZKS3xmnUMJx+4t0XZe+izW4TU9AJQkhw0kuKc8kvRGlehUqofNytWI/bfYGbRtv2636yBmqzOIUqEPDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LzPlCq6zvub58B8MU3t9Cz2r498hlJRVejESFmcHLgw=;
 b=iKItiOpHFqCIyvinV7fxTnTUoM1sfi6lH7boiZ7q29P17C8HI8jfiadYqp/q11Iiy6RGGzC1JDCCVTPICne9s4lAbsONVQ0mcPvBbdv0wFccZzgn0yTnIOKb7EfGGkxoYhD7i6yoYZZcOPfQ5rADiaO+4PULD51FjfS2Sg9bhSg9rh8kqbgiyuRbZjJyzgMeoWzmK/vpNyr9ggnRiCoEEEin+MzU7ym6smX6uFcApMeCRjKBmaDO83eKzYFIHkDufbkXIXCdwkQDHGAfvZE2N09hphitgoWsfEb+DO5vPT8xE68sQdM2EPZPqg2u+23x3uuXtquDdE3hYEPHClhjnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LzPlCq6zvub58B8MU3t9Cz2r498hlJRVejESFmcHLgw=;
 b=J7/Wo8vJRFf3ZKkCN9T0oZiVRgEiRKg17UIGevCihmWIqEe3XfhlIp9Dl19li+wpJzKpNEWdJv/BuE+RFkoSLncu8cRl/fnExTuKOajhLOHJZL6GeekhAFT5K1rGoZpDrEECVfXg3rfdi66UwfljiHXnN0HSgD3fzAmMgooHjsY=
Received: from DS3PR21MB5735.namprd21.prod.outlook.com (2603:10b6:8:2e0::20)
 by DS7PR21MB3271.namprd21.prod.outlook.com (2603:10b6:8:7f::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.0; Sat, 21 Feb 2026 02:47:08 +0000
Received: from DS3PR21MB5735.namprd21.prod.outlook.com
 ([fe80::a3f4:6107:de7c:5925]) by DS3PR21MB5735.namprd21.prod.outlook.com
 ([fe80::a3f4:6107:de7c:5925%4]) with mapi id 15.20.9654.000; Sat, 21 Feb 2026
 02:47:08 +0000
From: Long Li <longli@microsoft.com>
To: Stephen Hemminger <stephen@networkplumber.org>,
 "longli@linux.microsoft.com" <longli@linux.microsoft.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, Wei Hu <weh@microsoft.com>
Subject: RE: [EXTERNAL] Re: [PATCH 0/8] fix multi-process VF hotplug
Thread-Topic: [EXTERNAL] Re: [PATCH 0/8] fix multi-process VF hotplug
Thread-Index: AQHcogWJOprk6jArrkiuqF+yY7W417WL22OAgACZGdA=
Date: Sat, 21 Feb 2026 02:47:08 +0000
Message-ID: <DS3PR21MB5735238B253266105AB0F3AFCE69A@DS3PR21MB5735.namprd21.prod.outlook.com>
References: <20260220010859.595260-1-longli@linux.microsoft.com>
 <20260220093825.079fa673@phoenix.local>
In-Reply-To: <20260220093825.079fa673@phoenix.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=0eb5fcbe-2e15-48f2-afad-385e192fc2a7;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-02-21T02:46:22Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS3PR21MB5735:EE_|DS7PR21MB3271:EE_
x-ms-office365-filtering-correlation-id: 273a58b5-5d40-4f1d-031d-08de70f38151
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?YlhNTnk5ek9iNFk2bk1kcjc3WXAxNnNmRWdZSzhOUkxFcXhtM1R3V2JCR0lq?=
 =?utf-8?B?ZlRUbG90bjljK0R5R2dkdXVjVlFYdFBaZXUyWnhpYkhmbmxiN2RSMGJ5TkxT?=
 =?utf-8?B?L0xTMTk4WDBWd25xWlFEdkhkemZvVEZBVVhKaHZrckNXemozSGk0YUlMNFQ3?=
 =?utf-8?B?MmtZVXE0MGUrSlFxSXZRMjNpUUhzSm05cmlsamRpZGNZQi9LS2c0Qk1raXow?=
 =?utf-8?B?bERkMXZJUjlPOWFIeWN6aVBlcWw4MjAvbmhxQnUwendRSStSWVlidlVYV3lr?=
 =?utf-8?B?TUNKMFZrN2xxTk9aeUE4b2JwU1ZhZ2d6QzFzZmp4NkZPZjRkanh4eDNQNXp1?=
 =?utf-8?B?dTVmUjQxenJFM25HVWJpaUE0SEthdDZRR3d4dGdERVRwSHJGc1Q0Z1BvcFN4?=
 =?utf-8?B?TCtUN0RndXNjcFRmQjFpMFU4TFNSWVErQWY5MmtwWngrSm51MzlBRUlyNnZ5?=
 =?utf-8?B?cXpZNzBQaWdkTTZPMXJ0QXhCemN0dHdEamk2YnhNcUdWWmVNQ1JzRTd5NHRF?=
 =?utf-8?B?ZXo2a3lqb0IvL0k0K1piaUJHVjAzQ0s4MGhTS2dRRW9MeVduZGR6MTA2YTZE?=
 =?utf-8?B?aUJySjlzOVo1VmUzWkxRMXljNmtreWlCcFN2YWdDSDlna2cycktvWFJ0Zmdq?=
 =?utf-8?B?N0Z0SURPRVFKQ1dsT29KdjRCbmxsdVI1SnZQYjNHZHhsd2V3OFh4U3AyVWJN?=
 =?utf-8?B?dlB4ZzdvZjRPc2FNa0tnZUpiSFkwa01lQjNxdVlOYnhZMDJPL3RlbWZpbFZu?=
 =?utf-8?B?OUhHZUZqZWdpQjBweFFtbTdDRnU4N25vZUJxeDlQRTI2L2lWb0dCQ2ZwbzIw?=
 =?utf-8?B?NVc0ZVV3UmpUZWgvOG1FcW53L1dXN2gwaFQ1Z3k5Y1BVZkQ4L1U1U2VPcEM5?=
 =?utf-8?B?eWVjbllMSWtJYmxsVmcwblF2aFEzbUV3K2lRVkFUaGovYVRnWXljeXFrSXZD?=
 =?utf-8?B?U1IzNzVEUktUdkxSWWtUcHpXRjlQVGVxUE5Ma1hhZzN4ZTNvdUhKSmxqY3Q2?=
 =?utf-8?B?b0p5eDNaR3IvUEdLd3ZtZTVJR0x2bHF5SFh0V1VQdVVkREJ3K3FaREs3SHAy?=
 =?utf-8?B?NlY1NzJtK21SUStONkJqQURPdTk5NWtlWlFOYnNESWYvRFZsUUczeWFBSGtV?=
 =?utf-8?B?UkhYeDQrNUdqR3FVOEVHYjlodnlGWCtMVThFTDdLTTdPNEJHRXVNTDB5YnBI?=
 =?utf-8?B?aUZZTWZIamNqcm50N3czOWhUU3JzL0pEcEUxZkQ4WGxvMWthWC95QXgwdjkw?=
 =?utf-8?B?Y2dla21QUGxicS85akNhV1dDeTJYbXR5empNMGZFWWJ1dFpldVRWaVZCY1VV?=
 =?utf-8?B?K0NrMjZYMHJhZlZ1Y3ROVUNObjBSVjdOdFVYNUhwbERvb1FzRFd2Q1hCZUlM?=
 =?utf-8?B?UmFqWFVhL2NkakRaTFROWFhQMklVUTFYY1pnMDZRNFl4UzR6aXlYTlBsYzhv?=
 =?utf-8?B?VFNTbGNRZ1VxUWxjUEM1eWVVb08zbVB4U0ZEVDFSOFZibXNUNWV4UWNCL2JH?=
 =?utf-8?B?WUZGZEhaenlQam5KRS8rVmhFRWR1OThGUHB4cms5b3RBZlFUY294VFhueVJQ?=
 =?utf-8?B?VE83Y1RGcENyS2ZlclZNZlR1K213THBmamRpRllHL3kwdVE2R3hPc0FZZ0hk?=
 =?utf-8?B?OTNEbktHMEpnZFhTVUk3Yk96UU1iQkVqdDQzWEUxcDZORCtYMW5IMjJockZo?=
 =?utf-8?B?Z2kyT1NqRFF0d1U2RzBhRXg0c0tva1FnY0RFenJzQ041Wms4MWdhSG1WOEkv?=
 =?utf-8?B?OWFhRTh4bmloNDlMTVpzcXd2b05GTnZsNWNiS3dWZ09qM3RSWWxUNUQ0VVZG?=
 =?utf-8?B?aTBOc25xM2ZPMlZIcFRydEtvQ3dLNCttdk1rS1M2a0JJbFFYcE1ZbExMbkky?=
 =?utf-8?B?eXJ5WW9PVUNOdVdBZHlVUGZWQnppT1lNTGI0RktIRWsrR2U2dFZkNWJ4NytS?=
 =?utf-8?B?VnZXS3VCcUZMZlJFemNLSXQ0ZzU5djVHL2ZUNkpwcVE2bXFYRWRyNjJEVDRW?=
 =?utf-8?B?YVVkOHFpdFRXNTBCdW9CTjNreVc0djNqTkRPdFhIYVR6VlFWVyt3N2ZXeEli?=
 =?utf-8?B?b2c0ejdCNGxiVjhGTmZPbi9yeW5RZHhYeWtDVUlHUHVFOHhYY3pmY29TOURz?=
 =?utf-8?B?K1dPaG9sT1JqazE3ME95WEI1OEJZcVRkZ3d1Qk1pb0MvWHN2b2EzQ0VmeWpw?=
 =?utf-8?Q?alSFRR4VlBEjUjyrpFB3V8M=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS3PR21MB5735.namprd21.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y0hxSHpqeVpVWSszdjJwUWhmWitBb2N4a1FiZ2tySXhBQS9QOFIyYmFwZ0pI?=
 =?utf-8?B?RnJSTE9iNk5tY1JGQUY0cVNtSWVtNUpaYVQzWW5YUHZVSnR5bURwaW1DL0ty?=
 =?utf-8?B?ODN5VHJLQjU1bko1RXA3TmUvZkVhQk85SDN2NlJyNjF6bmpMMFcrVms0aGZQ?=
 =?utf-8?B?RkQ3c2gxWUR0MVVOOVoyK0JHWUdRMkhlL2M5RGFDZFdxVkJxMVBHdjFIZHQ3?=
 =?utf-8?B?ZnhYTGZKZERMYlZEVmlzSjI5THAwSFNDOWpVdVFkSjUxOFZrcWxHb2thWkh3?=
 =?utf-8?B?eUo0UFNpSGZxZHVwa0w0QitpclZDVmlkcHdZR3lnQi9BeEdPWWpVVGdyWWkw?=
 =?utf-8?B?NUMrcVpBSHBVbXdSY0hVbU1OdFNYWEFrSDJOVnUzU2RaYUo1OVJDYU5oZzFH?=
 =?utf-8?B?ZDJVR0xSN2d1ZzdhdmFEdXpsSzgreEN0NnJ6WEx5SFY5UVZoOXhvejZpZFlk?=
 =?utf-8?B?bkFNRnV2TFRIZHBPTUFxN0N0Q0RJRDJSaTZvcHFYdkQxNjd5SEF0V3FmdlBv?=
 =?utf-8?B?Vk51a0U5OC8wcFE5cU04Q2xqTjgrMXZFTG9BNGRrMmxOTHRGWXhiK3ZGcDdY?=
 =?utf-8?B?Tk9GbWhoako0Yk9xSUNTVG00VUlvcHZQQll5MmQ0MjlNTmlNK0x6bjQwRWRw?=
 =?utf-8?B?bEpZSW8vTHpXVzl5R0VKWjBReC9uVnVhK3N4dW5veXN2azhXWDF0QXo0WStE?=
 =?utf-8?B?WitWRDZnb2JJcnVqOFRXeHJpMU1pbUdINVl4TWxhZnVhR0JnWGo5VUpFaWJN?=
 =?utf-8?B?Rng4MmFYd3Y2WDh5TnNoK0xFcHQybnJBc3l0Q3Fwb0h2RElUT2xBR3F1OTFP?=
 =?utf-8?B?R1Rib3N4cE12dWlNblJpRVcwd3NUdithc2p3UHNNbGFsVW5WOWV1MWxXZVBn?=
 =?utf-8?B?WGo3WE1BMThUNG1rK0VreTBMU2RqN25WNUFJWUVEN1hicUpPM2NJaG9lbEdR?=
 =?utf-8?B?TmRMRURLMTJjdWdzRE56MWdWb2tDYXo3eURlaHJRbEowN3NSTnNlcVZ3eEgw?=
 =?utf-8?B?RWVVVjVrcEhsRXV2cmtRYVExZDdkWjBvV1hzMXl5aklGS0pHWXRMLzFqcnV4?=
 =?utf-8?B?bnhQWC9Cd0Nya2V0R3JPK0t3djRCYVBDMVVKT1ZtOGsvK0VsdXVlZTJPTkFp?=
 =?utf-8?B?aXZBQkVob1hReGRzWjVuLzNuVVEvbWhraUUyKzdySVR3NkQrYXVvVGlzV01s?=
 =?utf-8?B?Q0cxWlhPN1l6NTNLQ2w5YkQwUDV6Z25jMVpkdXU0U0JZeksrNmNOT0M3SlE1?=
 =?utf-8?B?dW5KZGFkUnVLNDhHU1g3YXlOc0xPaDJqdVo2TXl3N3dsZ1lNeVZCdk5qVldV?=
 =?utf-8?B?NTZvM09WUnJtUUhWK1A5RVoxMmVDSm1VZVh6RkVncENVcUp6QjJTdWpNWUM2?=
 =?utf-8?B?MktTOUcyN2hyR0ZOYUkxUmNwNWhrS3lmdEVOaEMzUmJUWTVTRUtxSmxjTnlS?=
 =?utf-8?B?SGh4OXNrdlBjUEdWZGRuZWtxRldRQU94eXM3dC9LSjB4OVJRWGh5RDMwT3Za?=
 =?utf-8?B?VTVxRUdrZFQxSFpqS0U4MDR3VnVaVUFqMHI3c3psR3JLVCtUaDMrTGl2TkpB?=
 =?utf-8?B?TXNraWVNZDJKbStEY2g5YTNFN1lSd3RZNEkzQWNVTG1DbGRtdWUwUklkSGFQ?=
 =?utf-8?B?dlNCNCtLU2ZWeFEwU1ZLNHA5UFZPendSNXhaWFN0eStTNzhLMzRyTWJsY0FX?=
 =?utf-8?B?QUtvWUt6cnU5VTlDem5mc2Q2Q1JkQ1hHalZLWklROThqb3AyWGl5SjI3bFh0?=
 =?utf-8?B?VHlrK2dUYWZOaUtuU2s3SURFeS9qWmVUSlZWQkpJTlVyRVBLNk5vSkFjZVJm?=
 =?utf-8?B?aUUraWtQT3locmlWcWtSTk5KeXltUTZmUzJqaElLWm56cmhWbmxVdEhQQTRW?=
 =?utf-8?B?L1d4bUY1ZWIzd0VNbDRoQjhJQkcyb09DYkl4Sk1SdUxjblBNdE9MemV4aHhy?=
 =?utf-8?B?MGQrdmpaMlZUMnNWZm5GMUZ2OFFzYTZjK1FXWjdOL29SMTQwbTZFNGMxREV4?=
 =?utf-8?B?VjB0RVpOaU5MdGRCOEcxYWNCbXc3cW56M2NUaG1ibEhta1g5bGZCam9KcmRZ?=
 =?utf-8?B?YUlJOGtKRDkyYkNNcmZ5eHhhSTd5U1RaVnZYakV6ZVRyRGlvMEZrcUJvRHJy?=
 =?utf-8?B?QnpFNXdhOTl0eS9kRkRlbUh3Q2hLNDNidFE4dDkyVkU2R1RKUXczdkliQmNz?=
 =?utf-8?B?T08vV2ErOUJ6c2pRUlQwWjBVckcxZUFHV0J6cHV2T1YzOEhXWGY4RldvYnlC?=
 =?utf-8?B?SzFCV1hFeXBYR21sSjVmY3NKUW5PNGN3UDRreVBzWXdKVmMrTzNXMHpHOFFL?=
 =?utf-8?Q?KX4hgZ9Pr2ndV6YXwn?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS3PR21MB5735.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 273a58b5-5d40-4f1d-031d-08de70f38151
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2026 02:47:08.1610 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2Xv4ffUrvK8lGVdXrAYM16FrQbzSbCZns7aHw6zwrpySLpfCc0hs4p/8TysaxcVaHmHFilcOo0NtcGEpMYJmdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR21MB3271
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

PiBPbiBUaHUsIDE5IEZlYiAyMDI2IDE3OjA4OjUxIC0wODAwDQo+IGxvbmdsaUBsaW51eC5taWNy
b3NvZnQuY29tIHdyb3RlOg0KPiANCj4gPiBGcm9tOiBMb25nIExpIDxsb25nbGlAbWljcm9zb2Z0
LmNvbT4NCj4gPg0KPiA+IFRoaXMgc2VyaWVzIGZpeGVzIG11bHRpLXByb2Nlc3Mgc3VwcG9ydCBm
b3IgRFBESyBkcml2ZXJzIHVzZWQgb24gQXp1cmUNCj4gPiBWTXMgd2l0aCBBY2NlbGVyYXRlZCBO
ZXR3b3JraW5nIChBTikuIFdoZW4gQU4gaXMgdG9nZ2xlZCwgdGhlIFZGDQo+ID4gZGV2aWNlIGlz
IGhvdC1yZW1vdmVkIGFuZCBob3QtYWRkZWQsIHdoaWNoIGNhbiBjcmFzaCBzZWNvbmRhcnkNCj4g
PiBwcm9jZXNzZXMgZHVlIHRvIHN0YWxlIGZhc3QtcGF0aCBwb2ludGVycyBhbmQgcmFjZSBjb25k
aXRpb25zLg0KPiA+DQo+ID4gUGF0Y2hlcyAxLTMgZml4IHRoZSBuZXR2c2MgUE1EOg0KPiA+IC0g
UHJldmVudCBzZWNvbmRhcnkgZnJvbSBjYWxsaW5nIHVuc3VwcG9ydGVkIHByb21pc2N1b3VzIG9w
cw0KPiA+IC0gRml4IHJ3bG9jayBtaXN1c2UgYW5kIHJhY2UgY29uZGl0aW9ucyBvbiBWRiBhZGQv
cmVtb3ZlIGV2ZW50cw0KPiA+IC0gQWRkIG11bHRpLXByb2Nlc3MgVkYgZGV2aWNlIHJlbW92YWwg
c3VwcG9ydCB2aWEgSVBDDQo+ID4NCj4gPiBQYXRjaGVzIDQtNSBmaXggcmVzb3VyY2UgbGVha3M6
DQo+ID4gLSBNQU5BIFBEIHJlc291cmNlIGxlYWsgb24gZGV2aWNlIGNsb3NlDQo+ID4gLSBuZXR2
c2MgZGV2YXJncyBtZW1vcnkgbGVhayBvbiBob3RwbHVnDQo+ID4NCj4gPiBQYXRjaGVzIDYtOCBm
aXggYSBjb21tb24gYnVnIGFjcm9zcyBNQU5BLCBNTFg1LCBhbmQgTUxYNCBkcml2ZXJzIHdoZXJl
DQo+ID4gdGhlIHNlY29uZGFyeSBwcm9jZXNzIFNUQVJUX1JYVFgvU1RPUF9SWFRYIElQQyBoYW5k
bGVycyB1cGRhdGUNCj4gPiBkZXYtPnJ4X3BrdF9idXJzdC90eF9wa3RfYnVyc3QgYnV0IGRvIG5v
dCB1cGRhdGUgdGhlIHByb2Nlc3MtbG9jYWwNCj4gPiBydGVfZXRoX2ZwX29wc1tdIGFycmF5LiBT
aW5jZSBydGVfZXRoX3J4X2J1cnN0KCkgdXNlcyBydGVfZXRoX2ZwX29wcw0KPiA+IChub3QgZGV2
LT5yeF9wa3RfYnVyc3QpLCB0aGUgc2Vjb25kYXJ5IHJldGFpbnMgc3RhbGUgcXVldWUgZGF0YQ0K
PiA+IHBvaW50ZXJzIGFmdGVyIFZGIGhvdC1hZGQsIGNhdXNpbmcgYSBzZWdmYXVsdC4NCj4gPg0K
PiA+IExvbmcgTGkgKDgpOg0KPiA+ICAgbmV0L25ldHZzYzogc2Vjb25kYXJ5IGlnbm9yZSBwcm9t
aXNjdW91cyBlbmFibGUvZGlzYWJsZQ0KPiA+ICAgbmV0L25ldHZzYzogZml4IHJhY2UgY29uZGl0
aW9ucyBvbiBWRiBhZGQvcmVtb3ZlIGV2ZW50cw0KPiA+ICAgbmV0L25ldHZzYzogYWRkIG11bHRp
LXByb2Nlc3MgVkYgZGV2aWNlIHJlbW92YWwgc3VwcG9ydA0KPiA+ICAgbmV0L21hbmE6IGZpeCBQ
RCByZXNvdXJjZSBsZWFrIG9uIGRldmljZSBjbG9zZQ0KPiA+ICAgbmV0L25ldHZzYzogZml4IGRl
dmFyZ3MgbWVtb3J5IGxlYWsgb24gaG90cGx1Zw0KPiA+ICAgbmV0L21hbmE6IGZpeCBmYXN0LXBh
dGggb3BzIHNldHVwIGluIHNlY29uZGFyeSBwcm9jZXNzDQo+ID4gICBuZXQvbWx4NTogZml4IGZh
c3QtcGF0aCBvcHMgc2V0dXAgaW4gc2Vjb25kYXJ5IHByb2Nlc3MNCj4gPiAgIG5ldC9tbHg0OiBm
aXggZmFzdC1wYXRoIG9wcyBzZXR1cCBpbiBzZWNvbmRhcnkgcHJvY2Vzcw0KPiA+DQo+ID4gIGRy
aXZlcnMvbmV0L21hbmEvbWFuYS5jICAgICAgICAgICAgIHwgIDE0ICsrDQo+ID4gIGRyaXZlcnMv
bmV0L21hbmEvbXAuYyAgICAgICAgICAgICAgIHwgICA2ICsNCj4gPiAgZHJpdmVycy9uZXQvbWx4
NC9tbHg0X21wLmMgICAgICAgICAgfCAgIDQgKw0KPiA+ICBkcml2ZXJzL25ldC9tbHg1L2xpbnV4
L21seDVfbXBfb3MuYyB8ICAgNCArDQo+ID4gIGRyaXZlcnMvbmV0L25ldHZzYy9obl9ldGhkZXYu
YyAgICAgIHwgMjg4ICsrKysrKysrKysrKysrKysrKysrKysrKysrKy0NCj4gPiAgZHJpdmVycy9u
ZXQvbmV0dnNjL2huX252cy5oICAgICAgICAgfCAgIDUgKw0KPiA+ICBkcml2ZXJzL25ldC9uZXR2
c2MvaG5fcnh0eC5jICAgICAgICB8ICA0MCArKy0tDQo+ID4gIGRyaXZlcnMvbmV0L25ldHZzYy9o
bl92YXIuaCAgICAgICAgIHwgICAxICsNCj4gPiAgZHJpdmVycy9uZXQvbmV0dnNjL2huX3ZmLmMg
ICAgICAgICAgfCAxMjIgKysrKysrLS0tLS0tDQo+ID4gIDkgZmlsZXMgY2hhbmdlZCwgMzk3IGlu
c2VydGlvbnMoKyksIDg3IGRlbGV0aW9ucygtKQ0KPiA+DQo+IA0KPiBJIGRpZG4ndCBzZWUgYW55
dGhpbmcgd3JvbmcsIGJ1dCBBSSByZXZpZXcgc3BvdHRlZCBzb21lIGlzc3Vlcy4NCj4gQWRkcmVz
cyB0aGVzZSBhbmQgcmVzdWJtaXQuDQoNClRoYW5rIHlvdSwgSSBoYXZlIHNlbnQgdjIuDQoNCj4g
DQo+IFByb21wdDogVXNpbmcgQUdFTlRTLm1kLCBkbyBhIGRlZXAgZGl2ZSBwYXRjaCByZXZpZXcg
b2YgdGhpcyBwYXRjaHNldCB0byBEUERLDQo+IFZGIHN1cHBvcnQgaW4gQXp1cmUNCj4gDQo=
