Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA8C7CA0EED
	for <dpdk-dev@archiver.kernel.org>; Fri, 22 Aug 2025 04:34:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D54EA402A2;
	Fri, 22 Aug 2025 06:34:55 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 564C540292
 for <dev@dpdk.org>; Fri, 22 Aug 2025 06:34:54 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57LIINdw007065;
 Thu, 21 Aug 2025 21:34:53 -0700
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2097.outbound.protection.outlook.com [40.107.93.97])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 48nr3g3hu3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 21 Aug 2025 21:34:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lXfMI6XluMYc4AFL1Az0mzVGeES6nnSwlk3voGSFsgNHKtSI2Fli8DQMMRXbmze4hN92bfjy1cWpeEGl1jbsMGZW3+BmiQnpdLHqrYXv9PtDUrDYeTv+DWcn0UOqeVoKx4YU4m7Q5Bfrne1SeSZxswL4lQxzswit6Elczn/3exegzGMfKKAyXtTMorI47z3NsFcOh4oEJ5mAK2+PJ5tcoTBfovEQ9ozXR7ewWQtuRSW2JQ1Y9vmdioHfLYt9JINn/LRNpjK1qpoz+ruZ2vZwjkxhJZf8EwW2mU1/m7JI4bSgKLB8wAbpye+dHCPxHUzvnGUNG1Dk6xU9PEePD8RRPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v+4t3FRk7xQ9Qkqm9VKMeT98PrsNFuIGOITNr3K3HfA=;
 b=U5U3y0M95gr8nL/evZc7Q9lIESvs8LxXClOE8bOIMKYmiBFJ0fvXYf+YeFqgseqEhYUPP33ZWNFgnxyo9+0cU6apmdqLbR3Grt3235TnWGscbHHi4odo1oMCyTYXtQvNSPkwPlXTQWOOYbkysqgSFOXisZNzei5ynWk+iFL8S2lymi6X1i7I/XRw6brEf4J7xeDZ0J83Oy4rV167CRzlGJE7xczkcGNEQ1jPDeQ958GXYlzH53vF3n9PZXOkI+OS3kVzHMnKHSeNGlPWQEYcQi6b1sJLYBqRSx+XrmrQNsKhl2yduIISdvRtacQE5OIEFbpZTNl9IKTA+J/bzp9x+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v+4t3FRk7xQ9Qkqm9VKMeT98PrsNFuIGOITNr3K3HfA=;
 b=uerux5IFSWx+Fh4vRM5ljQahcTYLFgTnVw7DwECQ6EGnPFOagBDxYGLTZm/qVt+OxxdkLF2PO19OAdKTU46EATEFzbp2I/msIN5BFXuB5PrjKbIZx9/UvRqPxDTX1+ulFE+lY9FwBbokRIF2Wo5L1CdoFWM82l2XUvy7h7H+dZM=
Received: from CO6PR18MB3860.namprd18.prod.outlook.com (2603:10b6:5:34d::12)
 by BY1PR18MB6042.namprd18.prod.outlook.com (2603:10b6:a03:4a7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.16; Fri, 22 Aug
 2025 04:34:50 +0000
Received: from CO6PR18MB3860.namprd18.prod.outlook.com
 ([fe80::7a27:a7e4:65d5:7eba]) by CO6PR18MB3860.namprd18.prod.outlook.com
 ([fe80::7a27:a7e4:65d5:7eba%3]) with mapi id 15.20.9052.014; Fri, 22 Aug 2025
 04:34:50 +0000
From: Sunil Kumar Kori <skori@marvell.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: Thomas Monjalon <thomas@monjalon.net>, Andrew Rybchenko
 <andrew.rybchenko@oktetlabs.ru>, "dev@dpdk.org" <dev@dpdk.org>,
 Nithin Kumar Dabilpuram <ndabilpuram@marvell.com>
Subject: RE: [EXTERNAL] Re: [PATCH v7 1/1] ethdev: add support to provide link
 type
Thread-Topic: [EXTERNAL] Re: [PATCH v7 1/1] ethdev: add support to provide
 link type
Thread-Index: AQHcEftTdTR+/QHyaEK5+gbvzWTV97Rr5NEAgAClI8CAALBCAIAA3fFA
Date: Fri, 22 Aug 2025 04:34:49 +0000
Message-ID: <CO6PR18MB38604AED8D4F352E1A2090B3B43DA@CO6PR18MB3860.namprd18.prod.outlook.com>
References: <20250820111350.2992591-1-skori@marvell.com>
 <20250820175317.3063659-1-skori@marvell.com>
 <20250820115818.0a3628ee@hermes.local>
 <SN7PR18MB386917862951DD1A6ABE715FB432A@SN7PR18MB3869.namprd18.prod.outlook.com>
 <20250821082012.1264dbc1@hermes.local>
In-Reply-To: <20250821082012.1264dbc1@hermes.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB3860:EE_|BY1PR18MB6042:EE_
x-ms-office365-filtering-correlation-id: 7ea58ded-f436-4714-d7cb-08dde1353b4d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?L2JZN2Jpb0JSdEQ5Q1k0c3QzUnVGNlRSNzNNTi95bzJNK1kvZWJFWVFzbC94?=
 =?utf-8?B?ajhaYTJTcEFGWFdCbzlkMEQvc1N2d1dxaDljZ29WaDZjbUU2NjJwcXY3WXo1?=
 =?utf-8?B?eXd4aTNlV0tWS1pzM1ZsZ0RnM1FSNmlQdlpMZjhBVjNaTGNWVEdBZDZsUFBs?=
 =?utf-8?B?VHZjcnZDU2VPb1FiY2ZuVWVnRWY0S3VmMW4xWTYrajVSUmV2VGpER1hjTjYx?=
 =?utf-8?B?OCtxSEtMV0tIWHNpeE9id2paYUJJdUl5SnJWelIvZDBKRWxRdnU2aHFySHpT?=
 =?utf-8?B?TytSNC9TYlNnOHJMd0x1ak1pNjEwZUNOSU10Z1lMUnBCWFlSRFVjYXVqazNX?=
 =?utf-8?B?UHc3QmFsbDFIVUdreXFFOXdwTVdIaVJTTkVuOHRhNW5ucm93czhhNGZ1Z1VX?=
 =?utf-8?B?ckVTZUZwaE1VZlUxazZsTGRRbzFPWHR3S2hDa3VoRXhkZU82VDhEWHhtYVFF?=
 =?utf-8?B?aXlXMzFUc3JSdmxVKzdwaWg1MFIrN3FYZ1lSbzB2U1UxQUhwT0kyVDZMR2J0?=
 =?utf-8?B?ekhhNjAzbTdTVWplNmRWMm1jT1pwNm85WkdHNERPQUpuZHBRRTRUSXIvd2xI?=
 =?utf-8?B?OHFNTFVJSFhob3AvK3BZTS85VlpRZWk1YzVUUjhidmhqYmlDeThMby90SzNj?=
 =?utf-8?B?ejZWc1hLcXJIMmt3aERlR0pYRXk1bDRpUHkyRTBMbjlvRlU3b0FtTjdZMVhS?=
 =?utf-8?B?TkVqYjIyZFFqZ1JDUnpQUDc5VHNHOEJuWHpweTAyMWFHOHovOFJGSTI5NWxN?=
 =?utf-8?B?MVBJOHYrZ3hDRGJmZi9SUExoemJJSlpVQ3ZKZVMzMlVNK3pmWk10N1Ivb2tS?=
 =?utf-8?B?cVovMGR0UnVmb1NnWUczeGZwU0RkT09oTHRvekxHU1I5NFdMeGk5TnhSRUpU?=
 =?utf-8?B?OUVpdzJGeFJ1UUhqaXd4NURPSTlYc2pDWHJTd0xBdDJlM0VhM2lTNVplVndZ?=
 =?utf-8?B?MC9HbldNUDNNWEdXZ0dGejlJZXZnMnl0bERJblFYdDJJT0lVTFhzOG5xMi9C?=
 =?utf-8?B?RENXQXFxdVVCamRQQUQ4c0gzUXE2em5PZ094aTk0OHRWKzN1V2pTRnoyeERB?=
 =?utf-8?B?TzVVb1dLSVh6QzQwcG9hU0MyVVUyeGprSlpRemdMNW5oYjgweFRiVU9lRHdJ?=
 =?utf-8?B?STNYdlNxRUlidmRCNndpejY1aStRRFF1VXNsQ3RCL3JiUXNkSkk4SEhLK3JO?=
 =?utf-8?B?bzJmVlJyYkdCWU5Sa3NLWG9GVHBkVUhmMkVSRHBJeCtydHRMc2oydVhKby94?=
 =?utf-8?B?eUp0YWxkNnQ2M0FIMkdNNmp3aHNKb1ZpemFVWHo5RjBaMFpFZVhSdThJWFRY?=
 =?utf-8?B?MWp2dHluK3RiemJNSTU0QWtzVm1taHp2UHRnU045T2JzaTVOR1R1aVBvellp?=
 =?utf-8?B?L3FKZEhjeWJHYjNoRnNXREZnOHNDbHFMT3NGcVpZclRtWW5VVHkxMnhTamVX?=
 =?utf-8?B?S1ZkZGRYU3ZVQ3ZWZlJ5NTRRYStHUjNENGYwNnZzaHlBLzdLK0gzK2FETFZF?=
 =?utf-8?B?czVxY2ZweGh3SGgrWnpTNHFjM29WQUxUK2RnOFBMYitteDNSV3Z6Y3RQM1E5?=
 =?utf-8?B?cVh0N3JVRXZqek1XUzkwYmhTdG9FY3d1KzR0SUthallsNUoyb0dpZXVvbC9C?=
 =?utf-8?B?ZnhrcDRPa1BnUnNlNGZzODUvTXVBSHhxaG5oejdzWXBFVnZHbWFPeTJnNHI0?=
 =?utf-8?B?WklsamtyNkNjN1hOZGdBUDV0eXN3d2JuQjNXd08ybVVPWTlMSWFsZEVYRVNT?=
 =?utf-8?B?UEkvbkxWVkdZVDQySVpOdjRlQUhTNTJZeFBkcHJUc2lEam9QcjlPLzZES1Mx?=
 =?utf-8?B?TW9nVjh0bkRYNzRUdU1PMi9RR0lVRFI3Q1V0KzI3Qklhb1ROc1lSbkVzUGky?=
 =?utf-8?B?TUg4dnBjcFB5YVJwb1pqRkw2b0hrVk50bmZpc0V1KzZ3VFVidnR6RTNEb0tK?=
 =?utf-8?B?U1UxTWRrMk5CMFFMZ01VV04ybUVPSmZvckpQaDZYRjdIZkJ3QzJCa1gzVEg2?=
 =?utf-8?B?RmN4RmJ3UmFRPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB3860.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Tm91RTF3OTlLcXlnamZBbFRzdlc2UkE1ZW5yb1hjTXMzNnI1WnpXSUxnbUdR?=
 =?utf-8?B?TUVxUk9OcGxPY1RKNWQ0cUV3d2djNysrQXRMM3JGUE9CMDJpQ0xlWndDSmp6?=
 =?utf-8?B?TmFacnU4RUwwWUVQRFcxUXRJT2dhZnpLaVE0V2Y1UlVjU3JNUVRpc3grU1o4?=
 =?utf-8?B?dTdOcmR2OW9DRmNSazhwbmhqK0dtZkd4cmlkRnBzWnZmSUMxTmRZNWUxbnlo?=
 =?utf-8?B?VjhtRG9hSmVwVlBCRFRRU1JNbHgxN041SG1ZUGxRZ0N6WFE0TkM5OE5icWsy?=
 =?utf-8?B?U284blNSVllvcityUk5KQmpZQmY3V2JxdDlIMTFpVTl4ekducVFOWk1wMk1C?=
 =?utf-8?B?ZVUrdVVJZTY2dEFJdzJaYjhjQnhsa0R5WEEvWDZmTlZ4aUxmWkwyR1B5cldq?=
 =?utf-8?B?dXhUMll4QzZHYit2RjJoZTd6S3RwWk5kNzc3NmMxazExeW5FSEJoN0dUUXhY?=
 =?utf-8?B?NC9iVi9qLzdpTlluVkhxVlU2VjdscDVUQU85R1NITmZ3U3FScUo5Y0w0R3NY?=
 =?utf-8?B?NE0wKzNhckhkTkxtRWEwYkR6dWhoOWx3bWR2ekJTK0JyRm54OTBsSHczNnpu?=
 =?utf-8?B?Ly9FUUJyb1NnZVIrbzRBdHhZMU5tN3BKMW5xV0tEVWlPOUFIT20xNjBMZjBQ?=
 =?utf-8?B?ellVYlM4cWFNWExUT2NZV2pUckpiY2dCLzV2ek1FZ1RiOFl6M05vaG5Wbitr?=
 =?utf-8?B?S2x5YkdNSkFVc0VISFJGeXprakFKaThoODN6djZYTjFyc21URWNTMWRYWEw3?=
 =?utf-8?B?b3hVWWFlcFpXOXJzVVJ5dnROMkFOMnVGVmxaNUY4Y2Y1ajdsQ0J6cWVFczdw?=
 =?utf-8?B?aFgxTkVscjh3WS96ZzBPbGp6TkdPOW90K0txYlNGSEJvRytOUk5tcDdtLzl5?=
 =?utf-8?B?WFU4UFFIOFI3Vjg0dHBKbmZzVE9YcXI1SW9mVHJSQWRFMXVjQzlqQ0FmeGhL?=
 =?utf-8?B?MmIxY1M1NDFwcEZkNTZ5ZGp0ZDZCRW9EQ1djeklkbzBZeTF6UmdxOTVVZk0z?=
 =?utf-8?B?a2tTZGF0T0R0ZVJBUGw5ZjFZWTNBdkh6UnY1NSs2NjdBNHRCWHBNWUpjVWFk?=
 =?utf-8?B?ZVpabUdXeUNzTllwckZoL3hiNURLUllycUhpaGhOMllPSUNTaWVwYmI5UU4z?=
 =?utf-8?B?dlZSbkw5MWt6Yk0raVA5eTVkNllxZkI4T2psL3B0UTN4bXZsTlplWTk5T052?=
 =?utf-8?B?cmRwb1R3Ymg0NVNrdWxlWktQcHpnMmY0UmxNOFRKcGp1VVpsRkppRE9TYVk3?=
 =?utf-8?B?VUoyQ0pBb0ZweGx1VnY2SVNISnVIaXBsZFR3b1VBL1NBd0ZJRUNpcUgxUTRV?=
 =?utf-8?B?LzhrNnBJRFBUZllxRkk1anZGVVcxdVc2WVB0dVNjL1hmSzBNVFQyZ2RkcTFr?=
 =?utf-8?B?a1Mzc2hFbklpYnh0NFFLWC9uSHJQV29pZlp0U0ZYa3VSN2tyNmsrNUV6VTVl?=
 =?utf-8?B?M2pxMkdIRU12Y3Q0RElvbVFDR2VSUHl1TjZSdUc2cERDVFNHQWFUWGMvOXpn?=
 =?utf-8?B?a3ExQXQrZzVXYWZpbUdORldjSlRnSmNHRGdZVU8rZFVXOTFrbXpPZGFDQjJT?=
 =?utf-8?B?cFQyNXQ0RVFwK3BUc3BWZHhVR1BQWHE1VUZxdVhnSERnaXFLejRUeFBZVGNa?=
 =?utf-8?B?Z1d1RFZBZkRXakdlSDRVZ1RQVzAvSVg2Zlk5bHhXVmFsQzBocHM0a243YWdQ?=
 =?utf-8?B?UzErWWxidk5VSndIdlhhUTdYdkZtWG9OemFyQnpNTmVPS3JqeXdPUU9WUzFv?=
 =?utf-8?B?eEtZVDE1QU1uM2NIbnJZWWZIS3JyQVpxSmNMT3hHbmZreFJYS0F2ZGR1Sk1U?=
 =?utf-8?B?SFVwMUo0SU5CU0JNTEF3UWkvWTh6aUx2cGpCOUxya0N3VUxqUFY3M3RSN0Nk?=
 =?utf-8?B?ekYzeUNTWjgzckY2bXJrOU9NM3dMQ04yWmZaY1BidThRa3Q0empOYWNOUERy?=
 =?utf-8?B?UzAwN3ZBdmJmcWF1L0orK0hsQzlkVGx0S1JWWnlIQWxoVlJGZk1hQ0N3MkhO?=
 =?utf-8?B?azhGVXlza3BpRTliU0w5aStMR1Z4aHFBK2FyNGt3VFZRYURuMmJuY0tzc3BU?=
 =?utf-8?B?OHNEcE1FS0dVM2dtOE55N3FTbkFHZDhpTWZmWmEwSW13aXc2c1AxM25VejVv?=
 =?utf-8?Q?WZSg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB3860.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ea58ded-f436-4714-d7cb-08dde1353b4d
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2025 04:34:50.0134 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nH8OSzCQiTDoyW8jiAlAKXFfEEGynQwJhp5Cc/+EOsczb0S6IkuqO8p4vkWFK3s6mU3R+N9Ho7XJ1c2LFwjIGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR18MB6042
X-Authority-Analysis: v=2.4 cv=St/JKPO0 c=1 sm=1 tr=0 ts=68a7f36d cx=c_pps
 a=3zwJ+Acc3RxIQNi1sO625Q==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=-AAbraWEqlQA:10
 a=M5GUcnROAAAA:8 a=oHAml08aFo7Y-7yerGIA:9 a=QEXdDO2ut3YA:10 a=0lgtpPvCYYIA:10
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: RJpDsY6PtevO0Ixz7OAKkBKW1HSu6d9_
X-Proofpoint-ORIG-GUID: RJpDsY6PtevO0Ixz7OAKkBKW1HSu6d9_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIyMDA0MiBTYWx0ZWRfX6rxuQsWX3Dcp
 SUfLyDlFNAQ9uJneDt0UHsDe6B0PJSkceAaqm5NgsR9cEI1vzOtioXPwXKehHq5fYOQtB69b5UB
 tudS4ou35gT24E5wxik5J6kJGLoitdARJS/28H9RlhlYPwm2VCrF9B8IktsWW8ompQu5ar4cx/f
 fsYj/AEj3ww4YtVzLyG/GpCcbeiS3jIrG17BMYASnZQKFCg2M74PshmtY8DMVzJMRyCXEnseTFF
 DJvARqE+wWWbnjKvipIAqMEZCTiW3gyv1djha9g63VrbBb9QcYEaRBh2bEhXIOUN3STEgzqBB5E
 ZjalMb3/2Km+tiPF7ekPvO/WUCZU3U6pM8Mhiick+DdZnWAZR7wyfQj/UB99+/zrk/OB+0BA3CZ
 mOcdDQN48J7TgDFONnVNLzFeqmVzE872kmsNJ7RzOOdZ4BU9aFupbvYKQaWkdxtPKWJQ6iUp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-22_01,2025-08-20_03,2025-03-28_01
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

PiBPbiBUaHUsIDIxIEF1ZyAyMDI1IDA0OjUxOjQ3ICswMDAwDQo+IFN1bmlsIEt1bWFyIEtvcmkg
PHNrb3JpQG1hcnZlbGwuY29tPiB3cm90ZToNCj4gDQo+ID4gPg0KPiA+ID4gSU1ITyBhZGRpbmcg
YSB0cmFjZSBwb2ludCB0byBhIGhlbHBlciBmdW5jdGlvbiBsaWtlIHRoaXMgaXMganVzdA0KPiA+
ID4gZXh0cmEgY2x1dHRlciwgcmVtb3ZlIGl0Lg0KPiA+ID4NCj4gPiBBY2ssIEkgd2lsbCBzaGFy
ZSBhIHNlcGFyYXRlIHBhdGNoIHRvIGFkZCB0cmFjZSBpbiB0aGlzIEFQSS4NCj4gDQo+IE5vLCBw
bGVhc2Ugbm8gdHJhY2Vwb2ludC4gVHJhY2luZyBpcyBtZWFudCBmb3IgZGF0YXBhdGggYW5kIGNv
bnRyb2wgcGF0aA0KPiBvcGVyYXRpb25zIG5vdCBldmVyeSBoZWxwZXIgbGlicmFyeS4gRm9yIGV4
YW1wbGUsIHRoZSBzdHJpbmcgZnVuY3Rpb25zIHNob3VsZCBub3QNCj4gaGF2ZSB0cmFjaW5nLg0K
QWNrLg0K
