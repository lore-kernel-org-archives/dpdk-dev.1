Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41A97FCC9CA
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Mar 2026 06:05:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7E8C3402B8;
	Tue, 10 Mar 2026 07:05:06 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 0913A4014F
 for <dev@dpdk.org>; Tue, 10 Mar 2026 07:05:04 +0100 (CET)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62A1vddP3215389; Mon, 9 Mar 2026 23:05:04 -0700
Received: from ch1pr05cu001.outbound.protection.outlook.com
 (mail-northcentralusazon11020133.outbound.protection.outlook.com
 [52.101.193.133])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4crj8qwsrm-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 09 Mar 2026 23:05:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VrHiT4O8AMeLFd427LKLqdC4T1DmQ1nn24fe8yu4MUPxFqmI7IoevYMtLVNa4+MM2i4pLL+JQG1Cr1/nw7XyStg3G9rWC+bV69gFJBxSF6d21Wc8CnMN2uCf4W9Vq71XHqYXCoeEbDDaRK8AYFSue4izPE/mw0v0g+pvsyBBLXZGEo7yqVmGuUsphaKA0NDdZxTnz/7R5+/6oIwjRWjdAveL7falr5/k2XMfXaWUzvDQMRA21t4KWgkcjrdOP9jHLQMOxLvq2iMcQWnESgWuo53LLF5VtN//lP/3AhWx0xb59V0fP0tktpEvMvkwIYRrVa3GKBjrY6JX7HCEjOKdkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=04v8h8Qh7M/brNa01PJyoao7lAiJfzDWGawo71tYr+w=;
 b=gQZchUbiDuXDIXwxEEGUDUoc0mcvnboQk7L3et2EtIywab5F5wWTWf6EwUQeierFJTFwvjOsgmNwwRRbLa3xLYQlSueKh3G5IkVfJJVIfw52UUtZX2e+rLmtVUMWbexRKwDjNM7dKpMY7vC2J1glrfQhxbA6eBVkeZiNucaX4UMEiRaHRcPnzyLgP3T+DR4VfA9+W4iqgUgDKohrWwFdXTZU2zQ4IWr0roN9egl2m2GyXvyYEcLIF67awrO/izQ43OTD6Cm/znwW/pY26VRuVUP+sGCwUdPdM+ND1LDIH5IchGKLzTRF2IsP4isSJPXJOJadIi4R66rbFHiHIPvRcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=04v8h8Qh7M/brNa01PJyoao7lAiJfzDWGawo71tYr+w=;
 b=sQ5IezR9yFFcDsn/v75hXkjAFEkT24QPJZ+ZgkKVTgyvUduAOlEfMGxiL2/52tZnC39slQsby+nIT9A48HTaqWQmnYsqvvJKG+NASJ+rIkbZqQnYgq1i7zIPgzoK4OMc7UqoGbg2yFu3NYFscGklZ/eGs8dHbUaHw+4HlRzXRxc=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 MW3PR18MB3625.namprd18.prod.outlook.com (2603:10b6:303:56::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.16; Tue, 10 Mar 2026 06:05:01 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17%4]) with mapi id 15.20.9678.024; Tue, 10 Mar 2026
 06:05:01 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: Akhil Goyal <gakhil@marvell.com>, "kai.ji@intel.com" <kai.ji@intel.com>,
 "pablo.de.lara.guarch@intel.com" <pablo.de.lara.guarch@intel.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "weid wei.dai@picocom.com"
 <wei.dai@picocom.com>
Subject: RE: [EXTERNAL] [PATCH] crypto/ipsec_mb: fix clearing snow3g digest
Thread-Topic: [EXTERNAL] [PATCH] crypto/ipsec_mb: fix clearing snow3g digest
Thread-Index: AQHcidPTJMSJpLGdo0mOfy1/GuANj7V8W3SwgCs4dMA=
Date: Tue, 10 Mar 2026 06:05:01 +0000
Message-ID: <CO6PR18MB4484A9157D8A409D0A9D9D8FD846A@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <20260120061234.137-1-wei.dai@picocom.com>
 <CO6PR18MB44843F6D8D644EDBD045B45DD862A@CO6PR18MB4484.namprd18.prod.outlook.com>
In-Reply-To: <CO6PR18MB44843F6D8D644EDBD045B45DD862A@CO6PR18MB4484.namprd18.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|MW3PR18MB3625:EE_
x-ms-office365-filtering-correlation-id: 8eb99bc2-3ad7-44b1-ddae-08de7e6af74a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info: gl6D4LBWzwuji3Vg+wBLpV8hvjhkbxuXfl1L1122kuVm4vlov7yFdYofTZK4Cna/lCJFDwDI99Jxw7x5OEkySV0V+c85rhZ5DjWyZcwWEZbYGsr/bNCnq3oP2k926TY4tTqvzmnt+NYOg+PSP3qJNT/B0vlYH78yANxkpXgVf+Ie8tVJxZcHXpdfFJzxis7v3wGLqg6USdHdEnkFf/FGzP3klLNSUmhCTkqNppQqg/A3j6cc7TMlqAxb7CbXMgPfwLefKuwndWXW0bgY5Y3Obv6XwsAgF1Rkn7Bqeso0pPYHiPnesgpT9I5v7ZOVsu+B8kIQkvD4mUdAI6rYCKjteHQzR80/Qkcm3jKcVNpUHUKHw/5aaOPBL3DIarHn4mE/xQPefPg/MAK9BC5TiuVDTMG4EnzPxddnTz3tWnlw6U+MWFBTOVO5fGihjwHr8CC2V/AMrr7fuzag0CnLRHGLW9LiVG2EG5PfUugtJuTmmh0fpWZmhfqArrMyWor7i3rnp6JrueAvaFiHc+bTJMve9MV4665Jc83hi6oqUqUUnagk/buqO+t43vBO01wbovWXDklT+arZzO/S3DUrZEcN6ZVtwhVozayLVJcLadEKRBgFzFvs/lAGjc8LfNlVeBB9daw84XvF1+5/HZlFBGoCHU4dsXTdwnGAhul0FrBupZ18ljtG+sSLaJFWmg2/UNBVIX5Fg6IdGifGx2kuBsPuIcpkNcaUFJRqk0XUeRrcrbAR8bSO7lG7CcGdeYY6cxgpvZu/QlklelOpmFWWPVfj9CcJI9R/dZu2WmwUVpm1mWs=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UGNIdjRXT0RNeUxNd3I5N1JiTEw5WWxvUjRGOVlmZEtCVWtickREOE1ZWnRL?=
 =?utf-8?B?T2VUSUF1RTE5SE4vcXQ1NjNoSEl5OVlsbHB2S0t3MVFTbHFDbFZvRm93VGc1?=
 =?utf-8?B?enMvdjVSZjVWckFwSERPYktac2pYRGEySXRTdGFPd3NzS2RsbndsQUZ5Z242?=
 =?utf-8?B?SzdsYUJXenBhck5tYUNjNzZvQVdHaXRQNW5wZmtsQXY4MkhSb1BvMmVkTGxt?=
 =?utf-8?B?TVhoalJTYXRmZTBEaGpqbTFxRkVFVXprb21jYk9jMmFHTG1rMHhaZXNYSXFz?=
 =?utf-8?B?eHFOOUx1TjBSdnB5MUJzdkxIOWxub2RvQWU5aWNBdWo0Nkh1RE5IVTNJUWtC?=
 =?utf-8?B?WHYvdXM1TzJXMHRnakpwWTFCcGtrdnBoM3FERjJzVXVzbXNxeWZUT2VTZkVP?=
 =?utf-8?B?VzBBOW4vR0FSdHpjR2NiSkZYS2ZscEk2aS95K1pyZlFEbFkvTEtMOWtGZEla?=
 =?utf-8?B?eHlpcThaYzhMN3YyZjZWTXBRQmNZY0NOMjNjeExqNmEwbE0rNHFNbXhSZjk1?=
 =?utf-8?B?VFdhVXJTUFBpbi9UU2xoaUxHbG82dDVFS1VlbW5HdDZrS2pkMEd0TnZWM05T?=
 =?utf-8?B?d0VpZXZRR2g0K3krd0daeENjaDlxSE9FVjI2aE9FT2FQV3VXOHVIckRGUkc1?=
 =?utf-8?B?cFNhREsyMTAxcDROdmluUGxBOG1sSzhYWlRvWndkbHpsRDJwZWpHaHRnTDNt?=
 =?utf-8?B?SkNvMEtZOEFrc3NqQ3Z5a3M1bXkzb1pWK24rS3Z0K3NMaE9heXQvNVlZcWE2?=
 =?utf-8?B?azhPSDQ2b3cxRXEvY29uUUFLODh3QzBwVExMVCtxdjNwZ3Fzb0pOblNtRXBJ?=
 =?utf-8?B?azdKZjFldlBuMXZ4Mjl0c25UU1kxTXBYWWhGNVBLRHVrUC9MZ2E2R3o4MFFM?=
 =?utf-8?B?NGNsa1IyT2wrYXRUQkpEemgwN25uT25BZHFrZ3lWSERacy9Ud3QzTTlhZHNN?=
 =?utf-8?B?WmRVRmRhTUVrT0FXdzU4clByWTNGblVPMmluQUJkaThRWTM0dXMvRTRQMGZC?=
 =?utf-8?B?QXlNaURCM3B4MVUxNTFIaXNoOGhXTHFlMWRsVXlVV1R1WEw0YjVhb0prVE1o?=
 =?utf-8?B?NldMdUJuQy9vYmZVOHNhVitCSkNEUldmZExaWkIxMUpzbUEydzI5dk5Kci9K?=
 =?utf-8?B?RGNKVnZvbHFsWXVoYm1rTTN2ZnBiZFU5bys0NDZsS0pTVlhmTThNTkUwVmlR?=
 =?utf-8?B?Vkt4Zm5FUVAzWnRTMmN5dVExcnM2cTVxdlVJcTAyME0yYlBKNE5OL0NRWkdC?=
 =?utf-8?B?V0cwUy8vNDBWM1dFbzlnMWVsSy9jYXc5WkVkbFM1cHFEZ3I0dEhUZTRmOU9w?=
 =?utf-8?B?TEZabzFZQ2RHbkVDdDdrQlBya3NMRitpSCtyWW9sSWRHMy94UERRZzQ3UlAv?=
 =?utf-8?B?dmNFaUM0dlFIRDZMNXA4RnhUUEJzeitQQnhha3lMbGZyODM3VjNCUWl0TThM?=
 =?utf-8?B?Sm9BYU1Wc0V3Tk44N214czRza2xZcWVtVjQ5T0p4NkNIa2ZrS1ZtUjNaaUth?=
 =?utf-8?B?SWEvNFhaRXN2NWwrWTVQQ2VyMmRBUklsdlUvY3NGdUlCc3lmaGx4cTZjMDVD?=
 =?utf-8?B?T0ZQSy9SZnRsVmo2ZFNzN0RaeTB5UWN6azBoRlY5QUh3SjBVT0thZkJBbkwv?=
 =?utf-8?B?ZDRhVUQzU09BOWFLT1BCbWlMY283YjhDcDBkL2RlWXNrV0VLM1NvemFEM3J5?=
 =?utf-8?B?MUVnK1c4TlFlTGZxUzZaRENpbXR0Tit4UFEvdjVYL1dKd3Z6bXk4eEIwRHVU?=
 =?utf-8?B?SXhhSVhaM1NOMjZaNHJ6ODlETlZDUktyV2MyNzZLdjBwNEdQckJTSG9uaFVT?=
 =?utf-8?B?a0JvNWdQMHhTcmJDcHVpQjFCZkNwS2p1dE9MNjY2TlllM2QyeHJWV2VMVkpL?=
 =?utf-8?B?RUU2SjFkYi9LeW9DSS81SVB2NlVSY0pQYzVJYlFVSmpwcGFMZnpMRXU2Z2t1?=
 =?utf-8?B?Y2FIUTYrc3l3aFdVL2IveHo0WUp3VG9SU2JJU2Y5Rmg5eE9McEVYZ0VKSWlV?=
 =?utf-8?B?Wk5vUWllaVZIOFpVZTRDQ2ZKb3l5M2ZUUko4cXp4bzlTRkhIYXlyeGU0VTN4?=
 =?utf-8?B?ZGE3UTJPNGhHRGs3VlYvN3lFcmJMdVM1Q2hXOGNhRUF4b2xUQW55QVVIVEJG?=
 =?utf-8?B?dzRyQ2xHbWxYakZyMHdDWUNzZ2F5OGxFZ0F5NE5MdXFSNE5nVWEzaWJZVTda?=
 =?utf-8?B?SVpoRWxlNHBZVGx6di9kSGR3UWd1RnNNNW5TNStRK2JyQXFNTFpUcW5rMmNx?=
 =?utf-8?B?UUNuTWtJL2d5WkVVZmR4VHdvZzI2b3FCb09XaFZkbXV2Y3g0SHBFVUN0QU03?=
 =?utf-8?Q?2FoIOzxrn+Xf67uKrv?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8eb99bc2-3ad7-44b1-ddae-08de7e6af74a
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2026 06:05:01.3313 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /Djz3w2L+pGLZ55vBZAJfvJGxzms4VbQsCcPg8V+9N5qlZXCm57XEWB7lild1pWXRYnRSFm4VFX5lfh1CpdZIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR18MB3625
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEwMDA0OCBTYWx0ZWRfX9UrEFoiVUtz8
 TudUiE9XzeUXdXfQF1ThxSeDxdKPQeeUe+1w+R4KqCR+Ch0cDG6P93ZgDbKD/J7f1HH3gKGOtsw
 iQyZjsIer7/uOzHe4RgQVgfkgpqn6heHTIynVYXKXqIM2bzM04hoPMdqzk7u9GH73gFhaUN+7iP
 hLk1sJ2T1xFqXrzYeklFgt+aCBUkqEMtzKE8t7+IJ6UK3Web/D8cVeG9kmKTrANn87pl3Lf2FjB
 IVmwyn5aA54qJ6uIMqsFDLfXE9E9SyOjDLkgzMgcOCLZcgvKTKJBKaVDtM9PGzMuoUlLkAJ9a9e
 ZwKTMbLNqyv3UA13Ww9SaBGKODAxM+lJ4XtCTXLyKCFu3ucRD5iG7QQBN4sEysiuGFmg7IXi6rx
 rwusLHsW2e1tiSDcDpneQWaAyybsX3OD6Xnr5ghEBX5QTteIReDh+UEJPlY9td5SZND4HoLGgFJ
 hDMPDIXsSYLdn3ClyrA==
X-Proofpoint-GUID: lKn7jxYSDjkiL2etEWVxu4KzqJF2_uD4
X-Proofpoint-ORIG-GUID: lKn7jxYSDjkiL2etEWVxu4KzqJF2_uD4
X-Authority-Analysis: v=2.4 cv=WbwBqkhX c=1 sm=1 tr=0 ts=69afb490 cx=c_pps
 a=OkMMD3sknCYbbSSSOfdz/w==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=-AAbraWEqlQA:10 a=Zc_DtpmQZw8A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22 a=EAYMVhzMl8SCOHhVQcBL:22
 a=MQOVprpMAAAA:8 a=ybiJliHn3lduGZJhnfUA:9 a=QEXdDO2ut3YA:10
 a=plcQb93oC-aU43enslkw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_01,2026-03-09_02,2025-10-01_01
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

PiBIaSBQYWJsby9LYWksDQo+IFBsZWFzZSBhY2sgaWYgbm8gb2JqZWN0aW9uDQo+DQpSZW1pbmRl
ciBmb3IgYWNrLg0KIA0KPiANCj4gPiBGcm9tOiB3ZWlkIDx3ZWkuZGFpQHBpY29jb20uY29tPg0K
PiA+DQo+ID4gQmVmb3JlIHRoaXMgcGF0Y2gsIHRoZSBzb2Z0d2FyZSBjcnlwdG9fc25vdzNnDQo+
ID4gY2xlYXIgdGhlIGVuY3J5cHRlZCBhdXRoIHNub3czZyBkaWdlc3Qgd2hlbg0KPiA+IHRoZSBk
c3QgbWJ1ZiBpcyBzYW1lIGFzIHRoZSBzcmMgbWJ1ZiBpbiBjcnlwdG8NCj4gPiBvcC4NCj4gPg0K
PiA+IFRoaXMgYnVnIGNhbiBiZSBjaGVja2VkIGJ5IGZvbGxvd2luZyB3YXksDQo+ID4gc3RhcnQg
YXBwL2RwZGstdGVzdCAtLXZkZXY9Y3J5cHRvX3Nub3czZywNCj4gPiBydW4gcGRjcF9hdXRvdGVz
dA0KPiA+IHRoZSBjYXNlIGZhaWxlZCB3aGVuIGk9NDIgaW4NCj4gPiBydW5fdGVzdF9mb3Jfb25l
X2tub3duX3ZlYygpIGluIHRlc3RfcGRjcC5jLg0KPiA+IFRoZSBjYXNlIGlzIFBEQ1AgY29udHJv
bCBwbGFuZSBhdXRoIHNub3czZyBnZW4NCj4gPiArIGNpcGhlciBzbm93M2cgZW5jLg0KPiA+IFRo
ZSBjYXNlIGZhaWxlZCBiZWNhdXNlIHRoZSBsYXN0IDQgYnl0ZXMgYXJlDQo+ID4gY2xlYXJlZCBp
biBsYXN0IGZvcigpIGxvb3AgaW4gbGluZSAxNjcgaW4NCj4gPiBwcm9jZXNzX3Nub3czZ19jaXBo
ZXJfb3AoKSBpbiBwbWRfc25vdzNnLmMgLg0KPiA+DQo+ID4gRml4ZXM6IDUyMDhkNjhkMzBjYiAo
ImNyeXB0by9pcHNlY19tYjogc3VwcG9ydCBzbm93M2cgZGlnZXN0IGFwcGVuZGVkDQo+IG9wcyIp
DQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiB3ZWlkIDx3ZWkuZGFpQHBpY29jb20uY29tPg0KPiA+
IC0tLQ0KPiA+ICBkcml2ZXJzL2NyeXB0by9pcHNlY19tYi9wbWRfc25vdzNnLmMgfCAzICsrLQ0K
PiA+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4N
Cj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9jcnlwdG8vaXBzZWNfbWIvcG1kX3Nub3czZy5jDQo+
ID4gYi9kcml2ZXJzL2NyeXB0by9pcHNlY19tYi9wbWRfc25vdzNnLmMNCj4gPiBpbmRleCBiM2Mz
YjA1YThhLi4zNWZlMjNjMTU3IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvY3J5cHRvL2lwc2Vj
X21iL3BtZF9zbm93M2cuYw0KPiA+ICsrKyBiL2RyaXZlcnMvY3J5cHRvL2lwc2VjX21iL3BtZF9z
bm93M2cuYw0KPiA+IEBAIC0xNTcsNyArMTU3LDggQEAgcHJvY2Vzc19zbm93M2dfY2lwaGVyX29w
KHN0cnVjdCBpcHNlY19tYl9xcCAqcXAsDQo+ID4gc3RydWN0IHJ0ZV9jcnlwdG9fb3AgKipvcHMs
DQo+ID4gIAlmb3IgKGkgPSAwOyBpIDwgbnVtX29wczsgaSsrKSB7DQo+ID4gIAkJaWYgKChzZXNz
aW9uLT5vcCA9PQ0KPiA+IElQU0VDX01CX09QX0hBU0hfVkVSSUZZX1RIRU5fREVDUllQVCB8fA0K
PiA+ICAJCQlzZXNzaW9uLT5vcCA9PQ0KPiA+IElQU0VDX01CX09QX0hBU0hfR0VOX1RIRU5fRU5D
UllQVCkgJiYNCj4gPiAtCQkJCW9wc1tpXS0+c3ltLT5tX2RzdCAhPSBOVUxMKSB7DQo+ID4gKwkJ
CQlvcHNbaV0tPnN5bS0+bV9kc3QgIT0gTlVMTCAmJg0KPiA+ICsJCQkJb3BzW2ldLT5zeW0tPm1f
ZHN0ICE9IG9wc1tpXS0+c3ltLT5tX3NyYykgew0KPiA+ICAJCQlkaWdlc3RfYXBwZW5kZWRbaV0g
PQ0KPiA+ICAJCQkJc25vdzNnX2RpZ2VzdF9hcHBlbmRlZF9pbl9zcmMob3BzW2ldKTsNCj4gPiAg
CQkJLyogQ2xlYXIgdW5lbmNyeXB0ZWQgZGlnZXN0IGZyb20NCj4gPiAtLQ0KPiA+IDIuNTEuMC53
aW5kb3dzLjENCg==
