Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 825F6EFCD7C
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Mar 2026 10:20:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CEDD440281;
	Mon,  9 Mar 2026 11:20:51 +0100 (CET)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id D58BF40261
 for <dev@dpdk.org>; Mon,  9 Mar 2026 11:20:50 +0100 (CET)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6290HcST2801685; Mon, 9 Mar 2026 03:20:50 -0700
Received: from mw6pr02cu001.outbound.protection.outlook.com
 (mail-westus2azon11022120.outbound.protection.outlook.com [52.101.48.120])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4cs898sre2-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 09 Mar 2026 03:20:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hXS0OBSZYuhSd890Qv0BZPfRq+jT2WZ60bv3hhAY5YZ/cr+mV/876p0Tz4qMdcnWiWbtrKDo5qCo+nklSae2ceN1VjxVUAHgLoDG7qdWp9Be61q2IxGEerOh0CFqAIEyd45+S7fe2d2niedNaC8VYgHf5GvdhPzydayoMgFpcCXVnOP9UV2XZ46KU9rFSZ08SRN3+kE7RcUSs5wr47gRstAqD3M9sLrDE4qaZRuzFUDs6i+1gScl2HGoU0mbgZaio3pkwdmp+iyGD9UZEbJlsqlCb3ed+eLFZvkJJtYncuTabbvLkODAgMSbKU349G/2hXvqV9EjqKP7u28RARNFog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JjCIcaFgQ08OzAGa5QwxJaM91V3M2WhLT6jY1qDTN8o=;
 b=H6/FH1L6KnCDdyRS1VpTkhQEpG+tgv6GAnSb8MZ4SLEKlWp5TqiwQAukF7BJABklDl8ZOyWw6q3wKmrfbPFxnPknMUNhexhYDsuZvwZ9ySv1atIU0LLHF4gPCp/nI2b5Dt9G/O15hYsIXRDd16dC5UyWzncA5TsNoG3kWffqlbgK/jixx8PaHfk0w4lw6NN/HOfDL27GWkLu+oW1IcwHYfGfBLA735CUmsqsHDkbn6uRS9n4hTSABQ9ycKYMl52Q4KoHN0qo58QQKxvymsqE8fsN0iohUrlweI+3W6LOazLgLMC1y5e2Zq5K8JZjgMY8NLcnktKSDf22lFcW0+jdgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JjCIcaFgQ08OzAGa5QwxJaM91V3M2WhLT6jY1qDTN8o=;
 b=unOoZ8eohfhUVVfRpMiQgujD4nujY239RZBlrd0fDKfMd8bCux8v1/bbaG3EjdsLLLaRHBM/iH3IMjeME5Mf94LXvKDi0/3swnia00XgOrI+sLsDm/iDmPAtmRiu4RdQBu3ONC5FktsnWGeitt+mqHAvQC/7rfHwuddmQLM56rI=
Received: from CO1PR18MB4714.namprd18.prod.outlook.com (2603:10b6:303:e9::18)
 by SA1PR18MB5791.namprd18.prod.outlook.com (2603:10b6:806:3af::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.25; Mon, 9 Mar
 2026 10:20:46 +0000
Received: from CO1PR18MB4714.namprd18.prod.outlook.com
 ([fe80::4e2:8a80:85b:4920]) by CO1PR18MB4714.namprd18.prod.outlook.com
 ([fe80::4e2:8a80:85b:4920%6]) with mapi id 15.20.9678.023; Mon, 9 Mar 2026
 10:20:45 +0000
From: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
To: Emma Finn <emma.finn@intel.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "kai.ji@intel.com" <kai.ji@intel.com>
Subject: RE: [EXTERNAL] [v2] examples/fips_validation: fix dangling pointer
 for SHA and SHAKE test
Thread-Topic: [EXTERNAL] [v2] examples/fips_validation: fix dangling pointer
 for SHA and SHAKE test
Thread-Index: AQHcr6z8yedzxasllEyFfv3HyTsiu7Wl/Qkg
Date: Mon, 9 Mar 2026 10:20:45 +0000
Message-ID: <CO1PR18MB4714C82F9395DB538D891D08CB79A@CO1PR18MB4714.namprd18.prod.outlook.com>
References: <20250828092822.2791101-1-emma.finn@intel.com>
 <20260309101025.958736-1-emma.finn@intel.com>
In-Reply-To: <20260309101025.958736-1-emma.finn@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR18MB4714:EE_|SA1PR18MB5791:EE_
x-ms-office365-filtering-correlation-id: a3b2bdb4-7933-4db5-b05a-08de7dc586db
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info: lQK4dW/WrwFGnZn0jS+VhjRRMLjLJnQZ7oTZfMoEL5VE3MRjzyoYlx7UkmramoyEkeS/tbwaQBr5Wba/5tcxPeYXSjsF2oTP3FYte4delGSTo2kNjlXI3wKkU4GwUpZF1hpfzJ7k9hUBqSILh7Lxejwau/FbvRcv5CTp/5Ehm5G9pJBEDn/zlO0WmCK1Dn4rHgK8n9SUx8IX9T9F68f7/2+VEy+hRzu/fPAV5kGjrEqytklQtMNy62hJiJojNZiJZkTzH9KDmuPKY4DMmxQf+uDUF51DPQA4C+6wjPsVYaRG4FeNxUHtjcvVjM5v/J4pnP4X3uFRGyoZA3JNITVfv8IWcTQO7KPBmFN9Y46xHuP7Ihwz5GNVlHd00RrwtnpL4esXdXukVOEa1nfvbrxw9+dYXaa4GsXKKT4yJkiJoLJW7AEscu1oK5LxBr/tJjL4iZtceeRshRHYuUPnf/clKBpHICzGWIELzWLKuyRRMVJ0su3bm8AM+up3RhrD7PtiPlqLCk3XpTk9SIVkjjicQVuIsMgwCo30sjigtWbKlBtwtzLyneVeDm9+ZkUn2adzOJqdlMeAiqWbzPJdeb55bvLTHC37qsB/EjNg1wyX5TH3KH8+glCSB2lTJ069daDjQQ8VIR2RM1OG48PqZ1xMCX6N7aznLeLadYEDl7VGT85Era0F5jVkgvW7RRVW5UmYljr8bqL9Qr1LClnBATZEuD7I1TEoEjiyhgaGxfKAsYnqtvFLOegzlE3i/PQif8EYlJ22Zi4JwMtzliSk1w62VTZwfn79YYFlXLKbJKIGSTo=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR18MB4714.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NS9OWGlyVVdCQ0Y1VDZGNGF6b3BGVm9SUmw0K3lxNW5ERTJBNWRucTRNMXdj?=
 =?utf-8?B?R2gwOGtxc28vSDd5YjNFYjJjTDM5M0w1L3M0SWs4azRkb3QyR3pVbDlHSElY?=
 =?utf-8?B?NEtGZlJ6L0psRGFwUUdualc0R3dUd1RIWU5QNDlWa0xNNS8zNk9FWE5vZ3lS?=
 =?utf-8?B?Vmw2MW5YVEVWZTFITjBBQmlvU25XWmNkUWh6TldESjhIY1c1cVkwUmV2T0t5?=
 =?utf-8?B?cWtwRldSMitMd2JFcFVNYUZFMmlhZUxUUGEzS3ZpMzdmU3VHUFhiNllJUmNs?=
 =?utf-8?B?azFESlo5NGIrS2NRTVVSZjZkWVoyL1JmQnkvK0V0OVVzd2ZNbVJxcERqbkV4?=
 =?utf-8?B?K0hEcW1ETmcycVZqMHF0cThNU2VBQXhBYmhDYzQ0dnE0UnlPM3FDdmw2QmNa?=
 =?utf-8?B?Uk9rbUVVTjl6aU4yWGV1ZlhZQkpIYkVjSlI4UVhJTk9hazRDVGM0TXE5R3Yv?=
 =?utf-8?B?aFNIN0VUMWNLVXlGeWlrdy9IdXRlRUxxbjY2SjNkS1lEUy9ieVFlVmlYd2sz?=
 =?utf-8?B?QTNQL1dDRWg1SXNaQlloWHZaK2VpM3cvaVcrd0lHT0JkOTBmSm04UjdCVVlV?=
 =?utf-8?B?M2IrQVRSdUdlVlJsYXNNOXVxUmJpalhiQnhRWUV6Z1luMGJxRlZUR2NKQmdE?=
 =?utf-8?B?RS9kTEdBMWNHekY3UjZZcTkvOTNqazJwZ0VIbCsyeEVhdmh5TVFmTEVqaXJs?=
 =?utf-8?B?R1MzbEtPTk5wWVl5eDgreXQxZmR5b3Q1UE1VcGNCeHBad2N0bTR3L1d5am5F?=
 =?utf-8?B?aEJabmNIK0liSkdRczZIUTk4anpkdU0rbkltekdNTDVrSlpsMndXaEl4am5E?=
 =?utf-8?B?NmZDbEpNeVo1dU9PTjFzRXhELzB5ZThTM0hQZTlXTmsxWmRHeFUvWkNKYzkx?=
 =?utf-8?B?ZUo5b0NQeFJOV3pjTDN0RHh2LytLVWtrZzAxeGVTR0Q0TWROREs1SXIxRUZr?=
 =?utf-8?B?VkFteXdKb2ptNFRta0twcVp0a0QwaVpxeWxtNk5Lb24zY1kzU0dEdzNJQ0Rn?=
 =?utf-8?B?WVB1SFFRdDVEQTh1cTNjV1Zvejl3Y0NES3FOY0c5WUIySWpWVU83YitIb3hv?=
 =?utf-8?B?NERDMGNsbldNZEVUUjlUYjJOTFpPcTB0bktQT1cvdFdlZUlTejZ0TFlLZlds?=
 =?utf-8?B?Rk5lM01Ma2FqRTUzU2ZxaHlzNWxsbHcreVV1UTVUL1BVMWE1K3Q2b2Z0djRv?=
 =?utf-8?B?WHFzdTN4NEwvVmVEdkJla2taVUd2Nm5HUEhrektmSDFZWXpQMThiRHB1YVdp?=
 =?utf-8?B?OHlPQ0dZTUduNDNqWWQvcmN0bTR5eXJ6NnlzdENVKzJxVmRZQ3NEenhWS1Zr?=
 =?utf-8?B?QkFPdUtON3ZEcFppMUVmV1VjaWVCQm1TRVI4ZXdGcUZ6TnVaWFpxdTE5NDBV?=
 =?utf-8?B?a0hySTFuNXhBTHF6dnNGWW5ZT0F5cnBUS0RLdXR3NVZPTGFjY3dyRXlDUUY4?=
 =?utf-8?B?WXdCczFSMCtRellhUVh6ZUZnMzI4ejM0K1pJK0VkeDg4bTJMUkxZUE15TXVK?=
 =?utf-8?B?UHRxMGhuVmpJRE1Vd3U3MWduOHVXRit3RzdpREo4b0pBK3BVd0lDYURMbHpj?=
 =?utf-8?B?VmdFS3lrTmdiVzNOZVYvTnFKRkFjcGNtU0ZKQjdweGlZeXZLbTUvRi9UZEFI?=
 =?utf-8?B?SnU4aEpsalBLSWFQZEdOQTFXTSt6STVhTEFHRVBibWQ5cnpOMUhGNSt3ZUZ6?=
 =?utf-8?B?MGtGNURqNWZWV2FEbXpRWm9ZYURmUG96SXBhdjkvbGI3MmcycDZqUEJsTlBq?=
 =?utf-8?B?dmszNzAwOE13b2kwbFFtTnUzY3JnMWNBRURNZHEyN2RHTGtPc3EwZWZOajdi?=
 =?utf-8?B?WXZNdnNJYi9OSmZZSHJsbFVHc01LTHczWSt6VVRJYVRJTjNqdHRlWXR5Z1or?=
 =?utf-8?B?dGorUXhqS1ljRzR6YzB6TDFHQTJhVzVOSkREWm9TbmZaOXQxM3hWMnEzSEVt?=
 =?utf-8?B?dkRCZHFERWNOVWNoK1NrU2ZTQWd6R0FQaTFDY2dsbXJOaUxVWFRIcTRLNEZ0?=
 =?utf-8?B?aC9PNjdtcEc2TW5nTUtCdThIWFg2c3RUWHVkOVNjVWdscm90SGp2bld3aUpi?=
 =?utf-8?B?Y0VNRmNQRCtTRDN6OEsvTHlreFllV0R3WTZKcEJVM2VjRUI2aUJGblkwbVlH?=
 =?utf-8?B?ZDdaUG5mNVN2SmxFYmR3YzNsNDMzREVjNjRmSVlyc05PUzc0Y0hCUDlGbVo1?=
 =?utf-8?B?SloydU0rQ0o5NFR1bnVpeGlMaTk4amwrUnFsdDEwazNEM04zNTJCVy9PSXBL?=
 =?utf-8?B?c2NGa09iUCtsQmpRYzcwbmVaVHNjM0tQM0tIazBWV0F3a1NZeEVzRGhMUTUz?=
 =?utf-8?B?REJUdDl4aG40T2h2NUZrM0E4VnBkeUZrNEJ0Sm81SDF3TnRBeVdOQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: iMY5lYTx6lKSH3XK1R0VhCCjFvq3UGnupyPTqUMNSumnuFvk0b7DZQhPfRhfWXa+jqtZ3cNLd35RyqtzmrIVOv4LHdcAQp3kh5hcbCYd4WS6+O7Wy82Gm3NHs4Dr3tkmFAYj0Ihq9uHDqyFovLv3EPGZY9N2CT9PxWxwQfc4IbC0YBJXjmfO1RXgpMP/b0hE8eg5jTLO1gnfcxhvS0ptq8IIEO0IIjUO0BQwraJVNJEgejXSQxnQHrcypkcnWs4FgTWYdaJ3YSbMpME8Dwp/aiedk+Ux0aF/Hzwh6egF4//tHDcNnkuO8VoRlRtcLHoC3nITJTWjA1+OCGYX8O/2dQ==
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR18MB4714.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3b2bdb4-7933-4db5-b05a-08de7dc586db
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2026 10:20:45.7479 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TzGovpAnBPB4quJ4jKp3NIzpB7y4IyQeY6gQY9W2EacebYJ4vFo4VX3MgK3F8owe9Lh5jO5cBXDvfoKKF3gJmZgjniXs4iBmHqsXDj/heYg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR18MB5791
X-Authority-Analysis: v=2.4 cv=L+cQguT8 c=1 sm=1 tr=0 ts=69ae9f01 cx=c_pps
 a=MceEdFpa07MrPAxPau0EtA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=TtqV-g6YmW1Jfm2GSLaY:22 a=QyXUC8HyAAAA:8
 a=M5GUcnROAAAA:8 a=HPHI9znyKSCyADc9sIEA:9 a=QEXdDO2ut3YA:10 a=qi3Z4-g4bRcA:10
 a=zZCYzV9kfG8A:10 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: slbEdLeGPXpGmxMH66nxwTqN0s3lpqYX
X-Proofpoint-ORIG-GUID: slbEdLeGPXpGmxMH66nxwTqN0s3lpqYX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA5MDA5NSBTYWx0ZWRfX7pzCTCfYvwmE
 LS5RBZtAGlAv5BDe6X7ll8jTCw8MaXgRwvM6I9KiRho+nXMb5GPImI1x/i4tpWYD1HGw+mUBvDg
 LTqsxgSXRRWoeEsJtaJf7vOMul7tCJe8dtvbn5s1oKi1HzFhzW05occQaDToqb5ZoV9Uq0qT0Hi
 eMd/oVZPvpdbP/RFZPC6ZJcEJwHMqx/OtqU0ItlW/aPkkS5bBwl7KDa3MSGBQylXaBVfWib4esR
 JCpcDo9QhnOaN29MRF4nf1zraelB0owJQhg/Si63hx+8QQ3wfQrWXG2qPY29ofJYVTj7qlzxE6n
 bNSH78cv+cCQlG7qisZfWW8Fj5MK8Yj2rVysTV7YpASv3qh+L14lRzH3hHWMBa5+9pH2X3maWUR
 jqXBCN+C9QIhx7jaYvX2Rl6yi5CRX7rr+MlxbKNOXh53SQjrNOReOjPOwjYGISGb/Dl+HfU+519
 ORDOdKWgZT4vmgmfnFQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-09_03,2026-03-06_02,2025-10-01_01
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

PiBTZXQgdmVjdG9yIHBvaW50ZXIgdG8gTlVMTCBhZnRlciBmcmVlIHRvIGF2b2lkIGNhbGxpbmcg
cnRlX2ZyZWUoKSBvbiB0aGUgc2FtZQ0KPiBwb2ludGVyIHR3aWNlIGluIHNvbWUgY2FzZXMuDQo+
IA0KPiBTaWduZWQtb2ZmLWJ5OiBFbW1hIEZpbm4gPGVtbWEuZmlubkBpbnRlbC5jb20+DQoNCkFj
a2VkLWJ5OiBHb3dyaXNoYW5rYXIgTXV0aHVrcmlzaG5hbiA8Z211dGh1a3Jpc2huQG1hcnZlbGwu
Y29tPg0KDQo=
