Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51BD6CA0FF2
	for <dpdk-dev@archiver.kernel.org>; Tue, 26 Aug 2025 18:47:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3CDDF4060C;
	Tue, 26 Aug 2025 20:47:18 +0200 (CEST)
Received: from mx0b-00154904.pphosted.com (mx0b-00154904.pphosted.com
 [148.163.137.20])
 by mails.dpdk.org (Postfix) with ESMTP id 0B3CA4060B
 for <dev@dpdk.org>; Tue, 26 Aug 2025 20:47:16 +0200 (CEST)
Received: from pps.filterd (m0170394.ppops.net [127.0.0.1])
 by mx0b-00154904.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57QC65Kh029403;
 Tue, 26 Aug 2025 14:47:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=smtpout1; bh=H
 pKPkh60k478V1bK4w/+rTdmNJ2++mgdeTpe5E7H53c=; b=YnlKd2r6fG024l6dY
 hCUEFzHG8hIXxZAI8maI6Fad6ntF1wuMlYCn6VZ1VTmI6LRYAHvrc9C+JjSITD5R
 4hpGLsCasoDQ4m2qlg9VyU+h/m2HjR6XkOqOQ6XoDV5CVXWFqwLDL+uAtWYpimNS
 8jVwiiNt+ocOxj8JgYC3uEGBcL6BV4X/g5xrARQvqXAn30jWOYo+Cz+Bdpk/FNjK
 sd/BQCojJwTZwK+yw3WTUqNKLixmq3Fj0KooFQUn90IGRoYiCec7RKbs0YEgbhj4
 au3fhvVjsSirkob0MJ31ewk5sHwrQMGyr902M82ZXK4GLTz9obr27Qvu51I+Kw4J
 WtYjw==
Received: from mx0a-00154901.pphosted.com (mx0b-00154901.pphosted.com
 [67.231.157.37])
 by mx0b-00154904.pphosted.com (PPS) with ESMTPS id 48q876x20v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 26 Aug 2025 14:47:16 -0400 (EDT)
Received: from pps.filterd (m0089484.ppops.net [127.0.0.1])
 by mx0b-00154901.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57QHpmJk012386;
 Tue, 26 Aug 2025 14:47:15 -0400
Received: from nam04-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2049.outbound.protection.outlook.com [40.107.101.49])
 by mx0b-00154901.pphosted.com (PPS) with ESMTPS id 48shpqrp33-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 26 Aug 2025 14:47:15 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vki1JEiGHLfih6qfqHtCOqxWur/uwtNoBP4D3j3g16frN25HBJ7nBEZ0wJvsrbKyRrtPvRt6TEovoQzrBJ6voz6W5XDvnSWR2IkDv7uCi851IRzxh23QdZEGSRUbxm8ZnBOU4sRMn84bfNYp4b4kylxPQ6HerYm+n5Gd5DNhnFtV6wsXD1s1UR2IaDOgVBm2aFDvAB8vHJN6OdESutzeiP1hFxxVrB+HfA/5ql6vkhlAchJVCs07VJ4gTdYMMdALc0/+oQ83YBDf+nkcILhBxzIlTZAVGN/u3NNhG3JbFL5BYVsYP0ULdx2zcmg7fR+4t0oSDs2yK8U/dZxevcawiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HpKPkh60k478V1bK4w/+rTdmNJ2++mgdeTpe5E7H53c=;
 b=X9FmK+4F9yaWCv1Ro5VD865ZJeJVgRtjUgSqHAlsfIOVWEo/jULpRfMXiadoZeGOE9ut/7qGPOcymycdWGOxBOLjoFKn4jdhZZtzz+yCqhMWI/yoYFn41+NswiL/9rPerwk5slqbb7mpYq8lGWni4BMaiUfsLNd9Wnk5eglcvG64beDSSfTcgFW3J9TlP6kkWfrX2MEBvOnv/DlNqIFjZvAZt6Uie5z9AMWVJKzOpNS4b8I5hRLECQ0OQrxjhE3CUHYoIYmpkqc6HTTxVZzdnEEhZAWZAe+SpKCvu/y65catXxu2dbg9RpMsfK+YGTXMlInB70X2pIaEeqFuNuXOjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from SJ0PR19MB4606.namprd19.prod.outlook.com (2603:10b6:a03:289::22)
 by SJ2PR19MB7593.namprd19.prod.outlook.com (2603:10b6:a03:4c8::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.15; Tue, 26 Aug
 2025 18:47:12 +0000
Received: from SJ0PR19MB4606.namprd19.prod.outlook.com
 ([fe80::8938:6218:a89e:ba8e]) by SJ0PR19MB4606.namprd19.prod.outlook.com
 ([fe80::8938:6218:a89e:ba8e%3]) with mapi id 15.20.9031.023; Tue, 26 Aug 2025
 18:47:11 +0000
From: "Bathija, Pravin" <Pravin.Bathija@dell.com>
To: Maxime Coquelin <maxime.coquelin@redhat.com>, Bruce Richardson
 <bruce.richardson@intel.com>, David Marchand <david.marchand@redhat.com>,
 Chenbo Xia <chenbox@nvidia.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "pravin.m.bathija.dev@gmail.com"
 <pravin.m.bathija.dev@gmail.com>, Thomas Monjalon <thomas@monjalon.net>
Subject: RE: [PATCH 0/3] vhost_user: configure memory slots
Thread-Topic: [PATCH 0/3] vhost_user: configure memory slots
Thread-Index: AQHcCzGgtkGye+sTHE2EwlyJqW9UY7Rp5H4AgAQgPWCAAFHO0IAEzWMAgAI4A7A=
Date: Tue, 26 Aug 2025 18:47:11 +0000
Message-ID: <SJ0PR19MB46063A880B831758A7455613F539A@SJ0PR19MB4606.namprd19.prod.outlook.com>
References: <20250812023358.2400020-1-pravin.bathija@dell.com>
 <15537925.JCcGWNJJiE@thomas>
 <SJ0PR19MB4606D8D898219FE2296C7FB4F53DA@SJ0PR19MB4606.namprd19.prod.outlook.com>
 <SJ0PR19MB46063FDCC149084AFBD7C4E1F53DA@SJ0PR19MB4606.namprd19.prod.outlook.com>
 <8391ac53-0b5c-468c-ae38-341842f5c492@redhat.com>
In-Reply-To: <8391ac53-0b5c-468c-ae38-341842f5c492@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Enabled=True;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_SetDate=2025-08-26T18:42:23.0000000Z;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Name=No
 Protection (Label Only) - Internal
 Use; MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_ContentBits=3;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Method=Standard
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR19MB4606:EE_|SJ2PR19MB7593:EE_
x-ms-office365-filtering-correlation-id: 950933ca-de88-4900-6dd3-08dde4d0f7d9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-7?B?a3NUMmZSWWdsaGV3NUhmUDlqUkpJUnJVU29MNERrcFlDWTh3TmpOeWRUL3hj?=
 =?utf-7?B?aHpIcUdwU2htc1hrY0xJMk9IaDRMVnNEVWRXVVhvempUazhPbTE4Q2JNUTJQ?=
 =?utf-7?B?N0E4bHByNjJJdXFtdEpCd3VDSGtDNU1KQTRnQkQ3Yldacm1FekpNcnhQOSst?=
 =?utf-7?B?SW9VREVMblJ3ZzNKeERRRTRuVnRoWVdQcEZQNExDSHIwMm04ZUowNzFlQmxv?=
 =?utf-7?B?UEFzWG1GQWRQY2RPZTVuZ1JBc3NZdVJpbERjTFNibWxIZjRja0xuZnRybklt?=
 =?utf-7?B?VnlSdVJwYkI0ZGs3TWxZb0FXUWhRTFBDUFFIWnlWZHlrSUUveGkxNzRIdENE?=
 =?utf-7?B?YzFtYkZtc0tJQ0xhbXVzei9VRElqYTR3L2dBQXJYNG9KZkdDa0xJOGtIcnQw?=
 =?utf-7?B?U0htUVhtU0NiTnViSmdIbURqdTJxTnMrLWRIMistZkhEcjZYQkgrLU9UNW5n?=
 =?utf-7?B?UW9MNGw0a0UrLVdtWjBlSG1tOU9TNE4weXBMajdwR2UzUElES3NUYSstNVRI?=
 =?utf-7?B?anZPbkJSYnpGKy1EdDZZVkh0SVpwV1dCUUJXWFhPREU5U3ZhUDBsNDJueWsv?=
 =?utf-7?B?S20xdGRubjZzNXdJQ3RHM0VvOHpxVnA1Um1XSTNubHNjaE1waWN1amhiQ21V?=
 =?utf-7?B?ekszY21oTUhKWmQ1eXVJVjEwR3M0ZXFTdlc4bGk4VElwbVJLY1dBQmdqZXJl?=
 =?utf-7?B?Yml5YnZLTlhUcDYxbVgyYm51em1kM2ZHcSstRFZLVEtvVDdBRWorLU4zNUtz?=
 =?utf-7?B?N3loQTVIZ0xKeWZiaUJQQmlYYlE3bk5aSXR3ZU8zUUNDbUN0aXZtNEtaRDZp?=
 =?utf-7?B?bTNIcUM1empmeENMVkw3TXh3SXlkN1BEME9zaGx3SnBEUExTbWJlTDE1RVFS?=
 =?utf-7?B?WUZoTmlvMHRvQlpodHMzaWgweFh0UTM0cjNET0ZCeWNPSHF5Nno0NDJrQy82?=
 =?utf-7?B?cWI1a25MYWJZeU4vRFdxYjlmQnFDQlNXZW9CMGZjUW1UcGl2RXVLUSstKy1U?=
 =?utf-7?B?Ym9BTUJKa0p0bFhiVnN5djA4N1N1WWluVHNuZ1lyT3FRMFpDaHJWVmt2b053?=
 =?utf-7?B?eVowRk9UcDZSM0k5R1M1NEVwd25Fbm9OUnJsWmNwSTFPWC91T1FYSkwrLVRx?=
 =?utf-7?B?ZUI2cno0SnBrTk54cjVFYmFhUU9YcjcrLTlrSHRVMFBkQmNFaSstd3hONkR1?=
 =?utf-7?B?Qk5zOVRwaGc4dkZLblhYbG9mZkVDdnQ5Y2pNMGN5aFRlbzh1MDhZbCstWFFT?=
 =?utf-7?B?bjNuNEVwZHlQVUdyR1YzbzlpS3VrRmJvTmFDQ2hPbGtGaTVCQ1hTeDJxajFL?=
 =?utf-7?B?RXdVSjZXS0Fja2xya0FKYkNnaDhkRm9jNWIyQWk2RllmZzZSSFFwUFE4UU9z?=
 =?utf-7?B?YU91WWNoc0lIcWlGSmZGVistSUZCVFBPVUVjdU1GbGVMbzZMNUFmekNyUGp3?=
 =?utf-7?B?UzNDcWN5UUN2RjJWeEVENE0wQ0NIejBmKy10RTNsNWNaRUsrLWMweG1GMXlI?=
 =?utf-7?B?cU5udTRzN2kvRENKWEkxaUZ2OGhWQmpIR242ejlqamZOcExNekx1STYwZVpS?=
 =?utf-7?B?YXI3MTBmRVg2ck5sZm5tcmt1Tk9VUEMzWVBoc01HL0cwQlNvbmpiSkdjMjZU?=
 =?utf-7?B?Ym16Ky1BMlZNam1pMllYZG92eG1wemNhVkdaZEZXLzBnMVo4N3loeWNRTjhm?=
 =?utf-7?B?YzZLZWUyYndPTjc3aHBSc1VLMjdFTkU1eGJ2aystQ01pKy1qOUNuMmpKL1BY?=
 =?utf-7?B?Q2pFeTJWZEF0VWt3Tko3d1N6eVFIZFRCOTUxZFRObDVKZDNZRkxQcERNM1ZL?=
 =?utf-7?B?VklYMnZQKy1nV0I5bWhialZXTFFVdEc4bVE0UUJ6ZElwOGVNMURvWC8rLWkx?=
 =?utf-7?B?eWprbnlrYWxHdWw0dUdUNDFGN3FLZ01pWkRtamtSR2xmM3pBM3ZtKy1LaWdw?=
 =?utf-7?B?czJWb1g0eTE2anl2L0crLXhYUy83Z0Y2TnNUYTd0M0xmbHVhTGFyRHV2Mm52?=
 =?utf-7?B?bCstNlZjUTUzamNOSlpYKy1KbjVnRSstUnBwM2RWTTI1cnBwZytBRDBBUFEt?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR19MB4606.namprd19.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-7?B?MVFKSlhlcGxRWnZ3SU1saDNaRXFMa05QU1pGWXQxdWtJM1pZaFpHaWl0V0pF?=
 =?utf-7?B?NjFaKy0yY2RRS2w4Tkk0enFKSG0vTlVrbFFuOGFhcnBYdWVFTEdLak1CcVUw?=
 =?utf-7?B?bllmckMvUmpqSHorLUNYcU9PWkxIZE10OC9SMVNLalZxWHZPY0ZuYzFncE5H?=
 =?utf-7?B?OEw2eUdid2xOTlM2bmt4Q2xNUjdISlZmS2FsZTFHWUFNL1Z5L09ES0ZiYm41?=
 =?utf-7?B?aWJNY25yMjZocXpOMmZNSUxFZHZwM0ViWk16bnltajUxUWR2Ky1IZHFMNnpR?=
 =?utf-7?B?bDZKcEN0MmZOem9SbCstRGVUV2dOdnBXY1V4WWFCTlF6QThtYUpLYlZ0a0NC?=
 =?utf-7?B?bUY4U25ZWW93VjVKQUVUMistMzdXZ016U3M2QTZKMmJpUjY2WUpuNXdhaXRh?=
 =?utf-7?B?MENyeWsxNC8rLWxiSFo3dzdlSWxOdUkrLXJWa3M4VmROZFZjMno1d1BrVTZs?=
 =?utf-7?B?N1F6WEtMckViRWpsOEhIUEZXdistdUhKKy1hU3lzVmpuc2RHWTU2RXhIclJJ?=
 =?utf-7?B?Z3hqZnZwb0p6TmZmb3VBVEd5RS9uOWlvM0czQVRMMGJjRWt3UGlvRzUrLWYy?=
 =?utf-7?B?dFFoQkZGb1dyeUZaZU4xQmJkZFErLWozOE9IYWhZQkQ4aVl4TDRmdnBlaW5U?=
 =?utf-7?B?V0RxSnVvVEE4YWU0Qy9ibEtoZVcxR25HQzd4elRtWTZJdS9uajdIaHYyRmxt?=
 =?utf-7?B?T1JVTTZBa1RoSy9lWnl1MDM2aGdPQ0VUZWRmcVhFZGRQOEVteGx5bistd2Yv?=
 =?utf-7?B?VmN6ZC9IVktnQVhoanRUVE1zZ01ISjJNNkZSMDVnZFNVMmxlQ2VFdk9EUnVR?=
 =?utf-7?B?V25qS2tTaC9zQlRib21LeXhpUEhlaGtNbWhqVUJ6QjdsbFBaN05UZW1WejFR?=
 =?utf-7?B?Q1NyeUtQZkVEUlpGdHRZdm1rQ2pxR1YxVXRiaXZMbHJ2RWJCRjBDUHZrcEpG?=
 =?utf-7?B?dG1rMGVEOHFXeHYvZFB2T3dEUmhIczE4ZDVXTXBiSGVhWGpzS2JYUnVHSGRa?=
 =?utf-7?B?aW84Y05IR2NZT0VkME1kZ1NvYzlrVGNwV1hGbU9yeE9nSzdESFh3UmN5RDhO?=
 =?utf-7?B?MUZmc3hWRXROWlVLT0JVNXFXTVltUFJMUlViaXNVZGlndXVUMnNvaGx0UDJQ?=
 =?utf-7?B?UWx2NHdSeWZIb0N6TmJGc01iM1NQKy15cnRpbVZmTmF3dGwyMWJJcVg3U0tU?=
 =?utf-7?B?S3B5dWpMMGNRRE96eU90STBjMTh1YnYrLUNuMDdzNjVpYWFrTVJXcEFKeGcy?=
 =?utf-7?B?TmxoSU1JWFNKWmx5cnJKb3d3SHgrLTFNdDFpSkRlcXk4QTEyWFFsMWUrLVQ=?=
 =?utf-7?B?R2wrLTdtWHdJYkg4UzRJaXg3ZzJYRWQxNU02RHJtcWJKc2xVaDY0S0F0L2dt?=
 =?utf-7?B?UzQ0SWUrLS9FVVYyc0ZwQi9JeFUyNW1sV09Ya3hGTVNxSENMNjdDZTdiRXUw?=
 =?utf-7?B?V3g5Ky1nTnJ1L2hpdktXNFBNV2NOeVlsZ2c5bzdFc25OMkVsNystWkY3UU9s?=
 =?utf-7?B?UlIvdmkwdDVvam1KZlk1RUVYdXZMblNRVzU3bVg4MXdLcFdxMDVvdW5OcGhp?=
 =?utf-7?B?eTFSaE42bVN4UlZBN0lETmtOZjB3S1ZyT1M2L1dVWjk4ZHNIQ2NTQzAyekJv?=
 =?utf-7?B?Tkh2VEFQQncvcUhPVWRsQldzN3JMQmd5d2lGRll1akhPRUNtTmpDeEFQb3c=?=
 =?utf-7?B?Ky14Y2o1QVVsdkwrLU0waWRNaHo4bGZtSUtnSlEzNU1tZ29oTFV5T0E3cWQ2?=
 =?utf-7?B?TjdISG5HUWFaU29ydXlGNjRqdFRORGtWUW5OSkE3S3J1WWZIUTRzWTdtKy16?=
 =?utf-7?B?cGtVSDl3UlB6SkhRQktBbTFoRHBvcXlWMU9rdGhiZEdMeVovelJ2c1JBcXdu?=
 =?utf-7?B?Smt5NTg3VnQ4NDU4OW5hd1A1V2xOS01CQ2VOb0JNckNHaXYyL2VZeFc5eUdW?=
 =?utf-7?B?NU8wN1FzSDFudlg3YXZoSzVKR0lYc0E5NldnaUlGeTJEbUhuS0N1Mk5jVTlD?=
 =?utf-7?B?WkkwMnJYc2V1d0drWWhyUDlPWHhuVmNpaE94T09oNzhQZFJqZGoxNWhRUTdM?=
 =?utf-7?B?V096MXRLZTdkRXI5RzJHblMxa0FQMmE0bnk4d3RyM0t4L0V6aWJiNjQ1cXd5?=
 =?utf-7?B?eTZsU21QRHlLYmRHSUoyQWJUVmlxNEFsTnA3L294WHlUbmRVL0pGaWp5blo3?=
 =?utf-7?B?YklpbGY=?=
Content-Type: text/plain; charset="utf-7"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR19MB4606.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 950933ca-de88-4900-6dd3-08dde4d0f7d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2025 18:47:11.8991 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SAEimcuYuKHfrKJqRL1YrKedTV2tXsPOAZiCzNtP12ftGkHmVKyaitz9hSKlklH3RbccgTC7PjcDbqvufc2Z1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR19MB7593
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-26_02,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 spamscore=0 phishscore=0 adultscore=0
 lowpriorityscore=0 malwarescore=0 mlxscore=0 suspectscore=0 bulkscore=0
 mlxlogscore=999 priorityscore=1501 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508260165
X-Authority-Analysis: v=2.4 cv=IdOHWXqa c=1 sm=1 tr=0 ts=68ae0134 cx=c_pps
 a=Z2e5DKjA+8LiMDv5v6mwwA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=wzW8d0FwaosA:10
 a=YU3QZWNX-B8A:10 a=2OwXVqhp2XgA:10 a=20KFwNOVAAAA:8 a=iLNU1ar6AAAA:8
 a=QyXUC8HyAAAA:8 a=Ikd4Dj_1AAAA:8 a=8rWy6zfcAAAA:8 a=pGLkceISAAAA:8
 a=bt5KbKNvAAAA:8 a=XlRjxQ70AAAA:8 a=LfxEVeEBAAAA:8 a=XFJw1KJJAAAA:8
 a=BXszkKfDAAAA:8 a=eSb-bNSJAAAA:8 a=QEEkIeqjAAAA:8 a=6-dRa9qSAAAA:8
 a=aDVyb4DoDCYEiLk3vRkA:9 a=avxi3fN6y70A:10 a=hlJyneSgMmFPbskH-t2w:22
 a=YjdVzJdQTyZRADMV7wFX:22 a=a-zEBD5cKgE7DNtTSb7C:22 a=1uMOUU2w0DxzEe95gQqD:22
 a=7k9nRlTqVbDGZ3p5_T00:22 a=DKZDSSD9H29Cdu8kcpdD:22 a=duu7wrcty9prphiCz_fF:22
 a=h7YW-pclpbZRD8svLbQ0:22 a=iapMWHAMLVzCBf0btcAb:22 a=NZk92sZ4hQKp_Sw8PGvT:22
X-Proofpoint-ORIG-GUID: voxLHOZ5sPNxp9O6v03o26z5CHe2L4Kk
X-Proofpoint-GUID: voxLHOZ5sPNxp9O6v03o26z5CHe2L4Kk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI2MDE2NSBTYWx0ZWRfX0X0YCbI5NsAh
 5AkEGaqQctBrWlxm0GwddCrdXQqhPVymUQj505Iallhv4XY8WKxcpEb0SMd37+TVsIxVIvokHRg
 tW5KP0z9Wf62x+4s8Yts1o8lzoUuuNgW5lpmk1pErOLPMyFkQEJnbmZIm6egjza9qURpzrq7U2/
 adu0jGvJIOQQ/KurMq7krDjI3a5XbQsNvtcv6r8d/EqklQALepn7hHaTo32psckjY1HPHh7nzAe
 eckNsCR7fnGXmeGeRrLLHvgR0M6x0BDhPZFWzyBsJPJriNZACEDovMWUnIXMyNuQXeC6m+zKRhi
 2D2Jgi1A2CZbar76lZXHQU4rp1LDZb1bydXAZcdhRmpqpIUXCjHt/kKRAxvTIJXzGndQPjaXlEE
 8g6czNE/ywgfv2l8NsCwwvbejV4jmTET/m0wtsjxc4TY3SXL1rbi77HsngPNVxHSSOR6NiLQ
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0
 lowpriorityscore=0 malwarescore=0 spamscore=0
 clxscore=1015 adultscore=0
 priorityscore=1501 bulkscore=0 mlxlogscore=999 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2507300000
 definitions=main-2508260165
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

Answers inline.


Internal Use - Confidential
+AD4- -----Original Message-----
+AD4- From: Maxime Coquelin +ADw-maxime.coquelin+AEA-redhat.com+AD4-
+AD4- Sent: Monday, August 25, 2025 1:49 AM
+AD4- To: Bathija, Pravin +ADw-Pravin.Bathija+AEA-dell.com+AD4AOw- Bruce Ri=
chardson
+AD4- +ADw-bruce.richardson+AEA-intel.com+AD4AOw- David Marchand
+AD4- +ADw-david.marchand+AEA-redhat.com+AD4AOw- Chenbo Xia +ADw-chenbox+AE=
A-nvidia.com+AD4-
+AD4- Cc: dev+AEA-dpdk.org+ADs- pravin.m.bathija.dev+AEA-gmail.com+ADs- Tho=
mas Monjalon
+AD4- +ADw-thomas+AEA-monjalon.net+AD4-
+AD4- Subject: Re: +AFs-PATCH 0/3+AF0- vhost+AF8-user: configure memory slo=
ts
+AD4-
+AD4-
+AD4- +AFs-EXTERNAL EMAIL+AF0-
+AD4-
+AD4- Hi,
+AD4-
+AD4- Please try to fix your email client so that we can follow the replies=
 inlined.

Thank you for the input. I have made the necessary adjustments. Please let =
me know if there is anything missing.

+AD4-
+AD4- On 8/22/25 9:33 AM, Bathija, Pravin wrote:
+AD4- +AD4- Dear Maxime, Bruce, David, Chenbo,
+AD4- +AD4-
+AD4- +AD4- I would like to follow up on the status of the patches and when=
 we should
+AD4- expect these to be merged into the mainline.
+AD4- +AD4-
+AD4- +AD4- Please let me know if I can help answer any questions you might=
 have.
+AD4- +AD4-
+AD4- +AD4- Regards,
+AD4- +AD4- Pravin
+AD4- +AD4-
+AD4- +AD4-
+AD4- +AD4- Internal Use - Confidential
+AD4- +AD4- -----Original Message-----
+AD4- +AD4- From: Bathija, Pravin
+AD4- +AD4- Sent: Thursday, August 21, 2025 7:48 PM
+AD4- +AD4- To: Thomas Monjalon +ADw-thomas+AEA-monjalon.net+AD4-
+AD4- +AD4- Cc: dev+AEA-dpdk.org+ADs- pravin.m.bathija.dev+AEA-gmail.com+AD=
s- Maxime Coquelin
+AD4- +AD4- +ADw-maxime.coquelin+AEA-redhat.com+AD4AOw- Chenbo Xia +ADw-che=
nbox+AEA-nvidia.com+AD4AOw- David
+AD4- +AD4- Marchand +ADw-david.marchand+AEA-redhat.com+AD4AOw- Bruce Richa=
rdson
+AD4- +AD4- +ADw-bruce.richardson+AEA-intel.com+AD4-
+AD4- +AD4- Subject: RE: +AFs-PATCH 0/3+AF0- vhost+AF8-user: configure memo=
ry slots
+AD4- +AD4-
+AD4- +AD4- Comments inline:
+AD4- +AD4-
+AD4- +AD4- -----Original Message-----
+AD4- +AD4- From: Thomas Monjalon +ADw-thomas+AEA-monjalon.net+AD4-
+AD4- +AD4- Sent: Tuesday, August 19, 2025 4:36 AM
+AD4- +AD4- To: Bathija, Pravin +ADw-Pravin.Bathija+AEA-dell.com+AD4-
+AD4- +AD4- Cc: dev+AEA-dpdk.org+ADs- pravin.m.bathija.dev+AEA-gmail.com+AD=
s- Maxime Coquelin
+AD4- +AD4- +ADw-maxime.coquelin+AEA-redhat.com+AD4AOw- Chenbo Xia +ADw-che=
nbox+AEA-nvidia.com+AD4AOw- David
+AD4- +AD4- Marchand +ADw-david.marchand+AEA-redhat.com+AD4AOw- Bruce Richa=
rdson
+AD4- +AD4- +ADw-bruce.richardson+AEA-intel.com+AD4-
+AD4- +AD4- Subject: Re: +AFs-PATCH 0/3+AF0- vhost+AF8-user: configure memo=
ry slots
+AD4- +AD4-
+AD4- +AD4-
+AD4- +AD4- +AFs-EXTERNAL EMAIL+AF0-
+AD4- +AD4-
+AD4- +AD4- Comments inline
+AD4- +AD4-
+AD4- +AD4- 12/08/2025 04:33, Pravin M Bathija:
+AD4- +AD4APg- - add protocol feature support add and removal of memory
+AD4- +AD4APg- regions/slots dynamically.
+AD4- +AD4APg- - this patch set has been tested with multiple instances of =
fio
+AD4- +AD4-
+AD4- +AD4- What is +ACI-fio+ACI-?
+AD4- +AD4- Fio is an open-source tool to test I/O workloads on disks and f=
ile systems.
+AD4- +AD4-
+AD4- +AD4APg- connected via libblkio to spdk target backed unix domain soc=
ket.
+AD4- +AD4APg- - please apply this this patch-set to dpdk mainline as well =
as
+AD4- +AD4APg- version 25.03.0.
+AD4- +AD4-
+AD4- +AD4- As mentionned previously, we don't plan to maintain 25.03.
+AD4- +AD4- I understand you need it for SPDK,
+AD4- +AD4- but I think SPDK should rely only on LTS branches.
+AD4- +AD4- Is there a specific reason why 25.03 is required in SPDK?
+AD4- +AD4-
+AD4- +AD4- When we do sub-module init on spdk master, it uses dpdk version=
 25.03 from
+AD4- it's own sub-repo.
+AD4- +AD4- Our changes for vhost have already been pushed to spdk master. =
We have
+AD4- +AD4- also pushed the same dpdk changes in the spdk sub-repo +ACI-dpd=
k+ACI- which is
+AD4- +AD4- version 25.03. I was just ensuring that there is uniformity in =
the 25.03
+AD4- codebase, whether it is on the spdk sub-repo or 25.03 within dpdk rep=
o.
+AD4-
+AD4- Ok, still, it would be better for SPDK to uses LTS as we have no plan=
s to add
+AD4- extra stable branches.
+AD4-
+AD4- Also, your series may be considered as a feature and not a bug fix, s=
o even if
+AD4- 25.03 would be a stable branch (which it is not), it would not be bac=
kported
+AD4- against it.

Understood. I would request that we merge my changes into DPDK mainline bef=
ore September 18 when the merge window closes for SPDK v25.09.

+AD4-
+AD4- +AD4-
+AD4- +AD4-
+AD4- +AD4APg- v2:
+AD4- +AD4APg- - fixed warnings with e-mail address
+AD4- +AD4APg- - fixed warnings with typos
+AD4- +AD4APg- - there is a warning about +AF8AXw-rte+AF8-packed+AF8-begin =
not being in pair with
+AD4- +AD4APg- +AF8AXw-rte+AF8-packed+AF8-end which on reading the code tur=
ns out to be false. It
+AD4- +AD4APg- is an anomaly of how git-format generates the patch and how
+AD4- +AD4APg- check-patch checks it.
+AD4- +AD4-
+AD4- +AD4- When sending a v2, please use -v2 so it is reflected in the ema=
il subject.
+AD4- +AD4- I will remember this for next time. Thank you for pointing that=
 out.
+AD4- +AD4-
+AD4- +AD4APg- Pravin M Bathija (3):
+AD4- +AD4APg-    mailmap: add user
+AD4- +AD4APg-    vhost+AF8-user: configure memory slots
+AD4- +AD4APg-    vhost+AF8-user: support for memory regions
+AD4- +AD4APg-
+AD4- +AD4APg-   .mailmap               +AHw-   1 +-
+AD4- +AD4APg-   lib/vhost/rte+AF8-vhost.h  +AHw-   4 +-
+AD4- +AD4APg-   lib/vhost/vhost+AF8-user.c +AHw- 325
+AD4- +AD4APg- +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-=
+-+-+-+-+-------
+AD4- +AD4APg-   lib/vhost/vhost+AF8-user.h +AHw-  10 +-+-
+AD4- +AD4APg-   4 files changed, 296 insertions(+-), 44 deletions(-)
+AD4- +AD4-
+AD4- +AD4-
+AD4- +AD4-

