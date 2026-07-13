Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49CCEC43458
	for <dpdk-dev@archiver.kernel.org>; Mon, 13 Jul 2026 07:05:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2BBB940298;
	Mon, 13 Jul 2026 09:05:13 +0200 (CEST)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012047.outbound.protection.outlook.com [52.101.43.47])
 by mails.dpdk.org (Postfix) with ESMTP id E89C74028A
 for <dev@dpdk.org>; Mon, 13 Jul 2026 09:01:28 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b7v7b16Xvrqaq6tnxPZXFu6JQ/5cVqnI16Ut13ygQ0qf602zxwTY1zG/5s5c6MyprAJvd8eDMBBPKFbdF+9p/KIDtRF/mrJHEiMhIuhWsL9t7/UTQcI/RNTkMrmyob0aeObtWMFf/BmwKWt1PubVaRowQxB3FRGvCCKJaJBK7LrCU7PfmwJqhEEp7D7JmBHfR0dRq4b5KH/+cwgtfaJE8BvKATuaxT/FyA6K0WXuOMgV4EitulW8CWnaPG0HDtunqelRpbTybU7ZC1YPfBVqxnfT+V21U2/GdQjKCpfAXejvir5YqjhheCVSlKf5mCVh8p4zWGHLLtLDCUvZ5qS2eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zp2CxIcrLVLKnjKYoG7kyJQydSA0cxusbREeaxc0XAU=;
 b=pYxlca2v8BJgP39xs9yD6zJEx8EyFoVQJg97ay5sMUJcttrVSRx2ZpnppYOJ1DLb/DFID5gtvyHPodulyHBvvXXNiwOT+mBao7PKyNGmdPZKMRKY/Q5uZPRbcxi0QgQxLfoJc+XxhTTCGWzctiddoJiv3Wb65WxWoHg0/fJFka56G3/89knRRdCl/525gtf8ScLeHHHRNVdoxd3BSyw+hP8QRWyvv+EiMk73FEV0bbDAz2HBIK5zymYbrL3N5/Vr1ImKe2X5D0mQezBRdZOuSNj2NOWL1fdjxVXluLYvUQNA5Dw3vDotiYhOEhvnEgYch7WYJ2KV283ica7x+LYybg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zp2CxIcrLVLKnjKYoG7kyJQydSA0cxusbREeaxc0XAU=;
 b=EM4cBvl30yaeL62GfdiFNRLRu9eCi/DmC9moWm7eiKCKOgeAmLkAb1hdoHDoCVbqc6Dq2UNFmdjKJkke8ZWDo1FQ2M0YhTlrC7eCIwE3eLAjJmjmBdOcez0/rs8EkEV6J36fsZ0TtRSztOsTjnCRMI5O+79meq7wO8eBP9l6tXE=
Received: from IA0PR12MB9047.namprd12.prod.outlook.com (2603:10b6:208:402::8)
 by DM4PR12MB8498.namprd12.prod.outlook.com (2603:10b6:8:183::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Mon, 13 Jul
 2026 07:01:22 +0000
Received: from IA0PR12MB9047.namprd12.prod.outlook.com
 ([fe80::1ff7:2ba6:caf8:1c99]) by IA0PR12MB9047.namprd12.prod.outlook.com
 ([fe80::1ff7:2ba6:caf8:1c99%4]) with mapi id 15.21.0202.014; Mon, 13 Jul 2026
 07:01:22 +0000
From: "P, Johnathen" <Johnathen.P@amd.com>
To: "dev@dpdk.org" <dev@dpdk.org>
CC: "thomas@monjalon.net" <thomas@monjalon.net>
Subject: Re: DPDK release candidate 26.07-rc2
Thread-Topic: Re: DPDK release candidate 26.07-rc2
Thread-Index: Ad0SlOvJK6LJejuGQ/qXoBvP9AybxQ==
Date: Mon, 13 Jul 2026 07:01:22 +0000
Message-ID: <IA0PR12MB9047B2E7710F4A4C51F4D6D3F6FA2@IA0PR12MB9047.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-07-13T06:23:44.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR12MB9047:EE_|DM4PR12MB8498:EE_
x-ms-office365-filtering-correlation-id: 045443a7-df2e-42ed-78e4-08dee0ac8c16
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|18002099003|38070700021|6133799003|56012099006|11063799006;
x-microsoft-antispam-message-info: xBCpJrEaR9RqYiuQ9tYjSufnB1skWbhBvqZl7FX7W+6Ztdrs9FnBKJD80dGL7SKaCSvWeoKQVRu5LN8SXLYUtLCf0+TVcOc6j4IGMziwigpGSi+te2WI5zZXIliG7uHp53+m5kejxTTLlezq8MyEgDnStCSW5iz1cXboeZzfUqqPPo53iDQ1SfZvvidYDdEMy2UstW8Pf1Klcaolu44xV/iODi2bjFt0lbPSAuEDpAnPBvOwlX+opnGZiwTh3EJ8+jKfsxo3n3j5HpBlNhisXVfAhbTQUd2RXZSsNoJucibHvn8Hne4ZyjGmKX0aPee0Sd1LUR83TifK9bLFDIhg1uvlgmJ/y0NxenUlYFgrXX6Ufxxhsl3Z9KjHZlbEBksvHfNLmzo02vWHOY83vpMRs7F1g1dHBn/CyY9pR0SqV43PJjicR7O9KECP9/3WSuO0WI3wQswH2jv5Njy/uXcwmq53Yi8ribikMBKhwPASRIFgrPAr1VeAIG0XxVxwzckf0K0wkHWGCz8+PNkteMHM+JENd59OBp9nkCQzDC7jbjLVnFJ6/09es4u+Cmr055J1pK/H6gwZL/TaSRo59fyqPaC7RgC0StyKAmIPveqEIM2sKxrTBnuH8IEaSqUcm0xmAJ31g/5X+pQckK56oJCUECs8wOOnmyKun3yE9s15dLxv8W2uY2kh9nvcOX6s41IthgzlO3uhV2OVUyWM/9P+484F68ida950oi6asZy/y+g=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR12MB9047.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(18002099003)(38070700021)(6133799003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bG9iZjc5Q0tvcXFldG93TDZqYUV5dno1Rml2N0hzTU5yWndWcmpCMHdiaWxL?=
 =?utf-8?B?SU5wbXRiQmY2UzdoUjlSdnpQZ0RWZVpTMFpnbndGdERCRmcyMExucVk4bjNG?=
 =?utf-8?B?R3JJZTVTajdlR2RiYjR3cW1UV01kb1JLVE8vRnVlbkFGbWFZRDExYkczRno0?=
 =?utf-8?B?NGRzazF3Q1FHeWRpRVdtWUFjNHpaRDRRUzR6NzZ0STJiSU1EYjBtWWV1NktY?=
 =?utf-8?B?eFdKWFBhY09VSFRGaytOTnJuNnQxRjR4elI3Ty8vQnM3b0dOWVptSTZ6bG1P?=
 =?utf-8?B?cklPbEc3UHlSbWNMQVRoSmdrckZzcEx2UUt4L1JtTW1PUXNOQkVWeFA2azU2?=
 =?utf-8?B?TmhlMnY1d29ZOXJFWUYwVVhJTGJVU0JxQW9nb1cxR2txellaUitSNnd2UlQ0?=
 =?utf-8?B?cjdTZmhSSW1xd1UzUnBUcnJmZ1k4RXZrS2Y5NUxUdEU1emp1bnFWQWFZSzNX?=
 =?utf-8?B?Q3ZoNUlMd0VjNlJOeWFHTC9QUExwVWxhalhoY0I0VGhUY1Jwb3B1QnJlVERI?=
 =?utf-8?B?K1YzMXR4VkptMENyeE5EM0UzTzc3RDlGdXFPSE9zdXcrREE5YTFxZFFBZ2JC?=
 =?utf-8?B?cE5VU245Q28rcW1kcEE4TUpTa08wQ0crTGhvL1BQV0hkcnlpY1hzSUFBM2Vq?=
 =?utf-8?B?OVF5RnBqcitERFZCZGlJaGEwT2R4RU00WUxiZXFrYnNpVDVSZkMwVkRtQVVD?=
 =?utf-8?B?dHpUbkM3WlR4TmM2bDJSOXpJakVTTjEzN3VJVVJ2c0JxeVBJMjJvUUc4aTdY?=
 =?utf-8?B?SWRjMVRNVlBNeExidjNwaW54T04yOXVjbkFlTEtQZmVZWWZrcmxKWk8zSXhX?=
 =?utf-8?B?VkFsTUMwN3hlQWZoeVpTc0E4TWpxQmZNR2RDbGE0QW10N2llYnZlZlRCa1Er?=
 =?utf-8?B?ZzQrSm8rTmdMR2tpZ29VUjZuMmQzM2c2NXJUeHlKcmFWRU9odi9odVdNVFkx?=
 =?utf-8?B?SkxNUWttcTgyc0hvVXBvUzE1VVRMOEdrZlhvS3ErNDdRSkhuT09ZaGNkR1By?=
 =?utf-8?B?V1ova1FDeWFkcUNrVGJkeE1qc3dhZEU3S0V1YkhVTlVLcVp4cnh3NDZvbER2?=
 =?utf-8?B?VWkrT0tTWmgvc2pnUmFteXh6ZU9BL2dpTDFZM1ljYTBkUDJHUWVEcm84QjRy?=
 =?utf-8?B?UXdBc0J1VkhIdG1TRHVBMi9jazlLMVc4K0EweGF3dGc3NEdWOHdMSXZvM1Uw?=
 =?utf-8?B?ZFNCK254a3FRV2xrbDlFRXBqbXhOV0pyMDJSby9nMjVkL0tHclpFV2dxdnpv?=
 =?utf-8?B?QW5FZk4waGw5OFhOZHhvSUxEYWNJU3RnWXJWS2o4UE1hY1JTbWlyZzBnalpr?=
 =?utf-8?B?ODYyTXJ4L2FxNEFzZDlEZXcwQ3pIcXVDbjJzR0xRTndYRXd1TW9jK0dtTmlJ?=
 =?utf-8?B?ZmVTcGlOM2xYRkpNTmZIem1VZUVScTRqVXYrWEVWZVJEOThwU0lYRWFhUFJR?=
 =?utf-8?B?KzROQmRjQ0VUZ1d3eXB4bU5VTGtpSkthSkhYYVpLeEdUcXo5RmF3dWlrU0Rq?=
 =?utf-8?B?M1ZjaWZjdnZYbmFuYXd5aE5ZYUtxVDlpR044eWRDeEVNZlZ4bkZoRnpSM3Ba?=
 =?utf-8?B?WHVCcStvUzhZOW9UclhGYi9HMnJFZ29EZ1lsU1FaVGlZWldaMHpVRTd0SjFC?=
 =?utf-8?B?ZjVRd2IwQ0pkR1Z2a3A3OHVlN3Q0bnhvbGdJMWdEUU40Uy9GWTU0ZHRRTGVN?=
 =?utf-8?B?M1dJbitJdGlwNHBTU3U5bzJmVTgwcE5zczkvemFDbDJpR3RhR3IySEVCKzh6?=
 =?utf-8?B?a2huSXpWdUUxbmNoQ2VZYldCcVR1TjdZYk01VmN6Y2lyTVJVOFE3WW1Kc21I?=
 =?utf-8?B?VGttZ1ZjYStOeUtrck9WeTJQaXorREY0cEVkSUdEVCtVMGJMTWlDRGxYUXM4?=
 =?utf-8?B?bE1pRDQ1MWtDUnFXalJJSk16YVFjYUxRMFpXQkROZWJYUEJuWTdhM2ZhSUxR?=
 =?utf-8?B?dXkwRzd5ZldIWm50U0NsRmEvdnpveGZ6allhMU1IVFlHcURZTC9yK1lneURQ?=
 =?utf-8?B?VnpRWTJQMzU1ZmxKV0VNUDlUcHRuMTRPZVl4STNrRmJ0azgycXUvOElWQW1C?=
 =?utf-8?B?UWZRazQ4K0dXeWk3SzkxSHpoS3o2WHo3dlQyWkdENStNZnZCelNKSkdxMW56?=
 =?utf-8?B?czhDWEJUUVdTazI1RE95dmx4NUozcG9HcW5wMkd6dEJybWVGL2J1U00wTGtD?=
 =?utf-8?B?V2NSMkw2eGI0VXlFcHBabWJSdGVCa1NGUUxNTUFLM3NNejZuR2tmK3VSQnB3?=
 =?utf-8?Q?EimhCoT5nQE+nk2xWSecJiV0zNEyGhvCJJuTtq9mGo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB9047.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 045443a7-df2e-42ed-78e4-08dee0ac8c16
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2026 07:01:22.2339 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9ZJNhFNQRxU585f9W1rFfA3LyndD1teOaCxnfe+pIB3HfjVWkdSbRhWsh0pbG9kq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8498
X-Mailman-Approved-At: Mon, 13 Jul 2026 09:05:12 +0200
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

QU1EIEdlbmVyYWwNCg0KUGxlYXNlIGZpbmQgdGhlIEFNRCBwbGF0Zm9ybSB2YWxpZGF0aW9uIHJl
cG9ydCBmb3IgRFBESyB2MjYuMDdyYzIuDQoNCiogU3VtbWFyeToNCkRQREsgdjI2LjA3cmMyIEFN
RCBwbGF0Zm9ybSB2YWxpZGF0aW9uIGlzIGNvbXBsZXRlLiBUZXN0IHNjZW5hcmlvcyB3ZXJlIGV4
ZWN1dGVkIGFjcm9zcyA2IHdvcmtsb2FkcyBvbiA1IEFNRCBFUFlDIHBsYXRmb3JtcyB1c2luZyBh
IE1lbGxhbm94IENYNyAyw5cyMDBHIE5JQy4gNiBvZiA2IHdvcmtsb2FkcyAoVGVzdFBNRCwgTDNG
V0QsIENyeXB0bywgQ29tcHJlc3Npb24sIExQTSBQZXJmLCBNZW1DcHkpIHBhc3NlZC4NCg0KKiBJ
c3N1ZXM6LSBOb25lDQoNCiogU3lzdGVtIFRlc3RlZDoNCg0KUHJvY2Vzc29yOiBFUFlDIDg2MzVQ
ICg4NEMpIHwgRVBZQyA5NzQ1ICgxMjhDKSB8IEVQWUMgOTc1NSAoMTI4Qyl8IEVQWUMgOTY1NCAo
OTZDKSB8IEVQWUMgODUzNFAgKDY0QykgfA0KRnJlcXVlbmN5OiAxLjYgR0h6IHwgMi40IEdIeiB8
IDIuNyBHSHp8IDIuNCAvIDMuNyBHSHp8IDIuMyBHSHp8DQpTb2NrZXQ6ICAxfCAyfCAxfCAxfCAx
fA0KQ29yZXMvU29ja2V0OiAgODR8IDEyOHwgMTI4fCA5NnwgNjR8DQpMMyBDYWNoZSA6ICAzODQg
TUJ8IDUxMiBNaUJ8IDUxMiBNaUJ8IDM4NCBNaUJ8IDEyOCBNaUJ8DQpNZW1vcnk6ICAxLjUgVGlC
fCAxLjUgVGlCfCAxLjUgVGlCfCAzNzcgR2lCfCAzNzcgR2lCfA0KRElNTSBTcGVlZCAoQ29uZmln
dXJlZCk6ICA1MjAwIE1UL3N8IDYwMDAgTVQvc3wgNDAwMCBNVC9zfCA0ODAwIE1UL3N8IDQwMDAg
TVQvc3wNCkJJT1M6ICAgUlNTVDEwMEFCfCBSVk9UMTAwNkN8IFJQVVQxMDBBQXwgUlRJMTAwREJ8
IFJTUzEwMEhCfA0KTlBTOiAxDQpTTVQ6IE9ODQpUdXJibyBCb29zdDogIE9GRnwgT0ZGfCBPRkZ8
IE9GRnwgT04gfA0KTklDIDogIENYNyAyw5cyMDBHDQpOSUMgRmlybXdhcmU6ICAyNC4xMC00LjEu
NHwgMjQuMTAtNC4xLjR8IDI4LjQzLjI1NjZ8IDI4LjQzLjI1NjZ8IDI4LjQzLjI1NjZ8DQpNTFgg
RHJpdmVyOiAgbWx4NV9jb3JlDQoNCiogQnVpbGQgJiBDb21waWxlOg0KDQogIC0gT1M6ICAgICAg
IFVidW50dSAyNC4wNCBMVFMNCiAgLSBLZXJuZWw6ICAgNi44LjAtMTA3LWdlbmVyaWMNCiAgLSBD
b21waWxlcjogR0NDIDE0LjINCiAgLSBGbGFnczogICAgLURjX2FyZ3M9Ii1tYXJjaD16bnZlcjUg
LU9mYXN0Ig0KICAtIEJ1aWxkOiAgICBBbGwgNSBBTUQgRVBZQyBwbGF0Zm9ybXMg4oCUIFBBU1MN
Cg0KKiBGdW5jdGlvbiBUZXN0IENhc2VzOiAgRm9sbG93aW5nIHRlc3RzIHdlcmUgcGVyZm9ybWVk
IGFuZCBhbGwgcGFzc2VkLg0KDQpUZXN0UE1EOiBQYWNrZXQgSS9PIHRocm91Z2hwdXQ7IDFDMVQs
IDFDMlQsIDhDMTZULCAxNkMzMlQ7IDY0QiAmIDE1MThCIGZyYW1lczsgYmlkaXJlY3Rpb25hbDsg
Q1g3IDLDlzIwMEcNCkwzRldEOiAgTGF5ZXItMyBmb3J3YXJkaW5nIHdpdGggTFBNIHJvdXRpbmcg
dGFibGU7IDFDMVQsIDFDMlQsIDhDMTZULCAxNkMzMlQ7IDY0QiAmIDE1MThCIGZyYW1lcw0KQ3J5
cHRvOiBydGVfY3J5cHRvZGV2IEFFUyB2YWxpZGF0aW9uOyBBRVMtQ0JDLTEyOC8yNTYsIEFFUy1H
Q00tMTI4LzI1NjsgNjRC4oCTNDA5NkIgYnVmZmVyczsgMTMgb2YgMjMgYWxnb3JpdGhtcyB2YWxp
ZGF0ZWQuDQpDb21wcmVzc2lvbjogcnRlX2NvbXByZXNzZGV2IHZhbGlkYXRpb24gdXNpbmcgemxp
YiAmIElTQS1MOyBMZXZlbHMgMS82Lzk7IDRLQuKAkzEyOEtCIGJ1ZmZlcnMNCkxQTSBQZXJmOiBy
dGVfbHBtIG1pY3JvYmVuY2htYXJrOyBBZGQvRGVsZXRlL0xvb2t1cDsgY3ljbGVzL29wOyAxQzFU
ICYgMkMxVA0KTWVtQ3B5OiAgcnRlX21lbWNweSBiZW5jaG1hcms7IGFsaWduZWQgJiB1bmFsaWdu
ZWQ7IGNvbnN0YW50ICYgdmFyaWFibGUgY29weTsgZ2V0L3NldCBjeWNsZXMvb3ANCg0KKiBQZXJm
b3JtYW5jZSBUZXN0Og0KDQpUZXN0UE1ELUlPIOKAlCBQQVNTDQpQZWFrIDI2Ny4wMCBNcHBzIEAg
NjRCIChHZW5vYSwgMTZDMzJULCBDWDcgMsOXMjAwRykuDQpBbGwgMzIgc2NlbmFyaW9zIHBhc3Nl
ZC4NCg0KTDNGV0Qg4oCUIFBBU1MNClBlYWsgMjY2LjAwIE1wcHMgQCA2NEIgKFNpZW5hLCAxNkMz
MlQpLg0KQWxsIDMyIHNjZW5hcmlvcyBwYXNzZWQuDQoNCkNyeXB0byDigJQgUEFTUw0KQUVTLUNC
Qy9HQ00gdmFsaWRhdGlvbiBhY3Jvc3MgNCBwbGF0Zm9ybXMgYW5kIDcgcGFja2V0IHNpemVzICg2
NELigJM0MDk2QikuDQpBbGwgMTEyIHNjZW5hcmlvcyBwYXNzZWQuIFNOT1czRy9aVUMgKDEwIGFs
Z29yaXRobXMpIG5vdCBzdXBwb3J0ZWQg4oCUIHNlZSBJc3N1ZSAjMi4NCg0KQ29tcHJlc3Npb24g
4oCUIFBBU1MNClpsaWIgJiBJU0EtTCB2YWxpZGF0aW9uIGFjcm9zcyBhbGwgNSBwbGF0Zm9ybXMg
YXQgTGV2ZWxzIDEvNi85Lg0KQWxsIDE4MCBzY2VuYXJpb3MgcGFzc2VkLg0KDQpMUE0gUGVyZiDi
gJQgUEFTUw0KQWRkL0RlbGV0ZS9Mb29rdXAgbWljcm9iZW5jaG1hcmsgdmFsaWRhdGlvbiBhY3Jv
c3MgYWxsIDUgcGxhdGZvcm1zLg0KQWxsIDE1IHNjZW5hcmlvcyBwYXNzZWQuDQoNCk1lbUNweSDi
gJQgUEFTUw0KQWxpZ25lZCBhbmQgdW5hbGlnbmVkIG1lbWNweSBiZW5jaG1hcmsgdmFsaWRhdGlv
biBhY3Jvc3MgNCBwbGF0Zm9ybXMuDQpBbGwgMTQgc2NlbmFyaW9zIHBhc3NlZC4NCg0KVGhhbmtz
ICYgUmVnYXJkcywNCkpvaG5hdGhlbi5QDQoNCg==
