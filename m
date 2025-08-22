Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20DD7CA0EEB
	for <dpdk-dev@archiver.kernel.org>; Fri, 22 Aug 2025 07:34:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 25C4A40662;
	Fri, 22 Aug 2025 09:34:06 +0200 (CEST)
Received: from mx0b-00154904.pphosted.com (mx0b-00154904.pphosted.com
 [148.163.137.20])
 by mails.dpdk.org (Postfix) with ESMTP id 4EC884065F
 for <dev@dpdk.org>; Fri, 22 Aug 2025 09:34:04 +0200 (CEST)
Received: from pps.filterd (m0170396.ppops.net [127.0.0.1])
 by mx0b-00154904.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57M4VxPS009117;
 Fri, 22 Aug 2025 03:34:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=smtpout1; bh=+
 wlEA1igUB+lGtLGYWuZybauMgev+yMfDE/CoYBM4V0=; b=bjkTKYZU25pa9tipL
 nK2CmaUPWRp4EUZWOaVCPm1wIAyKEoBb8mmpX864hkOjwp5J5wiTvhvOewPJ+YJ2
 D84tSHZjRmDFlFX6HACR/e74k7azXIqAzvKtry31xNHC8F5yvafCCxl78ztGnu4M
 05GU+z+IVDuvzh/+0QpqZs7RGl4FqAucf6zvGLK5vg9A0jXzhhcr++AEhYT1G1eI
 y2zdKE1S4bee3ZWguwLolnPCkTQw+H/hdQ/GpqN2coBZ5coxXvafD8NCszkTMMN1
 LL4Qt8r0Pg89pUl3klSKHGjPNfOcAakiZc/tMYVXT3kJk3TWFO5CqqqJVQ/4D6Bo
 85e0A==
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com
 [67.231.157.37])
 by mx0b-00154904.pphosted.com (PPS) with ESMTPS id 48n0v78a6k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 22 Aug 2025 03:34:03 -0400 (EDT)
Received: from pps.filterd (m0089483.ppops.net [127.0.0.1])
 by mx0b-00154901.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57M62YrB015064;
 Fri, 22 Aug 2025 03:33:55 -0400
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2040.outbound.protection.outlook.com [40.107.93.40])
 by mx0b-00154901.pphosted.com (PPS) with ESMTPS id 48pjxbh1q5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 22 Aug 2025 03:33:55 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gM+gyTT6s1NFK2za5sBMXsPIhrkeWKFUogkH4GY5MkiNWweJA2oXJGf/uqbEcdqYLmsj4Xp8q5efPKxdwZfOYmxvqpW2ZD/X4mBh4I+iXSYk3L5kqIldCUH2FFzvQ3maHckRn6PExX4lICoIAS1DKxfO3QMprFhm3Yk+6OcdyTpvtbFhadfLJr8TXFski4HwEInLdePcXQzAg9gfQnp8sir2ySTJQIawMRaJP6KCGRrjBhoFzkii3sJkeClqCKVxcTrQ3CqBj9s42ujSOF24FHVnNfuG45dbFiU8KtmDXL323/9nwlJYZWTKcxOEatxkQ42yDo2HnfjbBw3JvS4KqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+wlEA1igUB+lGtLGYWuZybauMgev+yMfDE/CoYBM4V0=;
 b=QzvM/7wXnU86ca/9Dp7DZoyVexjD+M7vWLoPrtTuYqvfjG/kP6293cdvYMORR0I8KIDtjrSn1ST2QsJL6KJSFvs7B+gKDyPM6e+Wsfp3qDVxCDv/wgRCOMFJJLp7LL94we4xdGUo9H7lZHM0ap6gI7gkxyX8XW/zxHZP6wRJhdEdxrfCco+em1UA9RHQOVGoIcSaJLAZ2mg4llnZI4c9mErDrLUBe+sa92h2NOjlVbmmiLKGmPRnJQg6cJQTL8FeIuzDeMy35ETsGpluy6qjXmNjmtTFucVieh9/aRwJdTi9kgiIaA4BUxjh3/oHT89qlBOmkhJr4Mx+gb7u8joFAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from SJ0PR19MB4606.namprd19.prod.outlook.com (2603:10b6:a03:289::22)
 by DS3PR19MB9415.namprd19.prod.outlook.com (2603:10b6:8:2dc::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.17; Fri, 22 Aug
 2025 07:33:52 +0000
Received: from SJ0PR19MB4606.namprd19.prod.outlook.com
 ([fe80::8938:6218:a89e:ba8e]) by SJ0PR19MB4606.namprd19.prod.outlook.com
 ([fe80::8938:6218:a89e:ba8e%3]) with mapi id 15.20.9031.023; Fri, 22 Aug 2025
 07:33:52 +0000
From: "Bathija, Pravin" <Pravin.Bathija@dell.com>
To: Maxime Coquelin <maxime.coquelin@redhat.com>, Bruce Richardson
 <bruce.richardson@intel.com>, David Marchand <david.marchand@redhat.com>,
 Chenbo Xia <chenbox@nvidia.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "pravin.m.bathija.dev@gmail.com"
 <pravin.m.bathija.dev@gmail.com>, Thomas Monjalon <thomas@monjalon.net>
Subject: RE: [PATCH 0/3] vhost_user: configure memory slots
Thread-Topic: [PATCH 0/3] vhost_user: configure memory slots
Thread-Index: AQHcCzGgtkGye+sTHE2EwlyJqW9UY7Rp5H4AgAQgPWCAAFHO0A==
Date: Fri, 22 Aug 2025 07:33:52 +0000
Message-ID: <SJ0PR19MB46063FDCC149084AFBD7C4E1F53DA@SJ0PR19MB4606.namprd19.prod.outlook.com>
References: <20250812023358.2400020-1-pravin.bathija@dell.com>
 <15537925.JCcGWNJJiE@thomas>
 <SJ0PR19MB4606D8D898219FE2296C7FB4F53DA@SJ0PR19MB4606.namprd19.prod.outlook.com>
In-Reply-To: <SJ0PR19MB4606D8D898219FE2296C7FB4F53DA@SJ0PR19MB4606.namprd19.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Enabled=True;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_SetDate=2025-08-22T02:36:27.0000000Z;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Name=No
 Protection (Label Only) - Internal
 Use; MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_ContentBits=3;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Method=Standard
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR19MB4606:EE_|DS3PR19MB9415:EE_
x-ms-office365-filtering-correlation-id: 3b1e6b6e-dcf3-4564-ae0a-08dde14e3e78
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-7?B?Ky1BdFpGTFJxRFlkc2k5RWJsWlYzbDlSOVo4Y3dGVzVBQURJQ1EzVFM2dnpa?=
 =?utf-7?B?RSstSERuTDFhNFhWRTJaTEpXUjdJc0hLamJTN1BIRWZwaVhJaFl6TU5tWVlI?=
 =?utf-7?B?UVF4U0tVMnZFejZ5TExESEpmQU1vZEZLRFZ6TUFhbDBvMnVyNkVpYkFMZEYv?=
 =?utf-7?B?bGdDRDY0NFlUazVkb0ZGV1ZtRWNRWlBQZ3lxL0pDUmpUTnQya09KakdkUkNI?=
 =?utf-7?B?VWZCdGpvUkxGekxrbkNMeFBjYW0vNk1pRWsycXo0NCstcGRXdkk4bThncXlT?=
 =?utf-7?B?VVpHZDFvbURHMGsrLUExRUZnbXNwZlBWRG1oZkJiOHVZM2J3L2I2THVrT0Rz?=
 =?utf-7?B?b0ZkVWlTUnRMYy9kKy1yV3J5eEhBbFZod2JtVm95aXlwbWgvYWMvbWYwenBz?=
 =?utf-7?B?LzBkbE95VU00aTZzOU5LUystSGc1b0RHeEsxMzJRNFhJY1djdkVoL1pHTjFN?=
 =?utf-7?B?UklIWjFLTi9LaEJURVhXc3U4aHRBVzZ5TnJFTXNzR3NDa29HZHZwUlp0eXA2?=
 =?utf-7?B?dXY4TkV3SW9hKy1xbnloZi8vbistQXdyUWhtU0RRZFh3UHFyaldDb3F2R01h?=
 =?utf-7?B?N0xmczZqS2pCUkVCYjVrZ1R4bkdpc0UwWm5BZDF2d0VsWDU2SFE3RDhXaHVo?=
 =?utf-7?B?Nm9zQ2pXYXR3WGd2TmdOMW5UVndkcEwyaSstT0Y3SU5RcS9seUM2VVl4VG1k?=
 =?utf-7?B?U1l3aTVWUG9oT1JHV1BtT0xmQndrTGdTT3l3OFZiZXhiaUVraEUxbHlCRXlK?=
 =?utf-7?B?UGxxN1UvZ2xKMCstYy92Ui9oYmJZajNNR2JYZWdkbW1OcjVVZzFVQWhSOHB2?=
 =?utf-7?B?cUZJekxmRXFjREw2RHU0ejdiM0RkWUd0N1hUNm9qZ05tbzUyNE85aTdrU3do?=
 =?utf-7?B?VHZzS05oVjJ2b2tGWGV6a1F3RlB0dlNMVHlwb09lL2dFRE9KeDZ2eFhKRldG?=
 =?utf-7?B?d1RnR241a29CUHNNYUdZL2F1ZWN4ZDhodjRlU2gyRGZrUmhNQnFsN1hyNGRl?=
 =?utf-7?B?emVzMThEYjRRS1VzcG96SS84enRWdjZHYWducFhNcXZmQistRjFscUJjcVJM?=
 =?utf-7?B?VE9XKy1nV1NVQXhyR0dXdXo2RHphTzU3NkQ5OHdrSWFWQmQvYk5nZCstOSst?=
 =?utf-7?B?WlRJUkNERnNIZ2dzSkFML1lkSUg1ZmMyWTFsdUJ1Nk16ZXVUZFZUYmhVZ0tU?=
 =?utf-7?B?cGpoWkRkaVZ0cWd1cHlJT3FHdXBtL3FaeTdDaG9JNystRGFxQlB6MVg4U2tD?=
 =?utf-7?B?NmVNSWppU1c5R05Md3dUOHFEcFUycVVzYUoyTFJPbGY3Y00zVjc3UUZjN1Jp?=
 =?utf-7?B?MHo5YXIyWVZ1R05VSTUwSFBRdGlMSFgxWDZZbDFhNjVkNmx6MDdlbXhDUnRJ?=
 =?utf-7?B?WGhEN1J0VUhqZTJDem8ySWl0cG9GWFZPeDdqRlAwSHFTVHEvZVVDNkRRYURj?=
 =?utf-7?B?OTZ5TGxhWDZtdVJKamVuUW51NktqWERlekNQYTRQYlQvY21HV0g5S0FCQWdh?=
 =?utf-7?B?dXQwTExPODA3V0JEelVsWG1FMlkrLVo4by9XZTZVUUQ0SzlwVzNZcThaaFJS?=
 =?utf-7?B?VTNwNllZYlc4dFo1ZTZKKy1uU1VIUndTYkNudEIyamZJRlpFbWFiUlpYN1dN?=
 =?utf-7?B?S2w2QklMbmdFM09GdElqbnN1alpWU0R3clY4aFEwdjZ4RTFKM2lxWU53aHZ6?=
 =?utf-7?B?Ym9Ed0xFVFd4NGZhc0RvQk9DSGg3dUE1VlYvMENWa1ppNmhId25wYnRUb0ZC?=
 =?utf-7?B?YTk1bXR4RTNmek9GaG5yeEUvTXVMclY2UTBOUVBjNzJpVHlEV1hsYmE0QlNq?=
 =?utf-7?B?Z2lJV0E1bmVLaDBFL0Y3OFR5Wi8rLUkrLU1obWRFUFRBTEV5MXZUcWpBclRN?=
 =?utf-7?B?OEFtdldFMFU2czl0QWtnZWw4amcrLWhWMEVCVnladlRpcEp2ZVZCVkprdXBK?=
 =?utf-7?B?OWNCMkNXNystR284U1BlRnlNeWR2VUxNMkl3VGY3V3ExVHlveDFlYXBSejJk?=
 =?utf-7?B?SnU1dGRnQkFhb0ptTGZjY1RmRjJaQi9jZ3h3T1lnK0FEMEFQUS0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR19MB4606.namprd19.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-7?B?UlhwemhOYnBUWGV5OTJnV0Zlc2gxUDU3RFhxMUcxbi9mKy1iaDhpUmNYdjB2?=
 =?utf-7?B?SlBhWWZ6Q2hQZE5XZURBWDYyenk4blZyNkRpWGMrLXkvWFlKRGpkdystRDRy?=
 =?utf-7?B?djUzdHpDT25vR1dSbzU4TnU3VnIwck9nb0tXOWVlMzlEMGtmRVp5VWlrL1Bs?=
 =?utf-7?B?dFpEWHFiQk9DRFA4ZGFYQWZEd05EYTNQQ0t3dlh3aFFUZHhxbGU5ZnlZQS9C?=
 =?utf-7?B?Skt6cEZybDF3ZVdmUThLRnZHV01ESUVjbnV2NElocVluVENOSWR4ZXhqZHpV?=
 =?utf-7?B?VTIrLTJ6Z2dKdS9BQnZqaHgxSSstOEgxTTBLWSstNkdwWFpQaWZ4Rjg2R0Nu?=
 =?utf-7?B?enpiTmgzZ0JpZU9ycHZTV1FMdGN1cW9zRUg0dGZKWjFtQlBhYlVuSnl1V2VQ?=
 =?utf-7?B?M0xIWkoxUExnb3NvZW52cVk1UHZwNXVlTTZOUjR2RkgxaC9wY1MzTVdxdEtU?=
 =?utf-7?B?bE5CQ3orLW9aYXVLTTNmdVlVeFdycEVQNWJBSzBhczhyT0JPbGgzMGg1a3hD?=
 =?utf-7?B?UHZEVk55UEtQWWM2VmU0aTFaLzE2a0R2RXBRNjVmTm91aGdXL01hcHRwcjdF?=
 =?utf-7?B?VnVDTDI4NS9SZS9NYlpXN20wL3VVRmtFY0d1N29yZ1YrLXJJdXBHV1VUbVRD?=
 =?utf-7?B?YlVQenNBOE41bUxZblJyNGpiaVZYUzYvSzh5NFJJbmh2c0tSZ0tnbVpKNWg=?=
 =?utf-7?B?Ky1iUlJXaTdpMnBoZlRidXFTU2dURlVHYTVCRzM2eEdzYUxueUxNL0FYUVNR?=
 =?utf-7?B?V1NQUUtNenVPZ1JBT1BYaTJlSG1kOTJvRnBIQnZaWnlVelJvYjVkNUx6WEpL?=
 =?utf-7?B?dThVL0ZMWnl0bUdsVkZTbC9CdUtyZFl5QjQrLVg5eXVDM2hLazgvMystU2tL?=
 =?utf-7?B?bkpaZlQ5eistUXdhNmQrLW1SR09sNTJYUHo2VmhnbWt2OC9iOHJHMzEya21B?=
 =?utf-7?B?UTlzaUNIWEtmWTlYTkJtYUdKKy1NZVE2UGlXNzlWcmxsRXh0SEljM2o5Skl0?=
 =?utf-7?B?TVhiMEJ6OGc0N3lwcDlDZGFvWnB4UUpGclZyb3BmYkJuUXVkTUpwZ3JNc3lr?=
 =?utf-7?B?cDBuTWRTN1lNQ3diMTMxS0JmSm9UMG81ckFqNU4rLVVHU3kwZWRac2FXTlAv?=
 =?utf-7?B?a3ZFNGdSYTNlYTlrc1BMSHkyZ1dsWXlZRGtHU0xGMHZJeGhQeUtqM2FDVnhi?=
 =?utf-7?B?ZnU4SndHZWFOWDlTVkFSMDdpTkJONGZzeGhTMUFPSk9pWmM3QzdvcXZwS2R3?=
 =?utf-7?B?Ky1rSXd6MEhORkZsT0s0UFRsWkRwaGozN2Q5eXNoWWp6VEFKY1VKdkF5dk1S?=
 =?utf-7?B?TDlyNk43MFI5Ylh3aGdDMVAyb1UzZGlZL0ZFZGVwSFpzVFpDcEpZSFFOYUpz?=
 =?utf-7?B?Z2U3WU9KUDE4dEtYSm1tYm93aTVGa1FYaHZmSEVjbm9JbGhkSGVHUzBXVzZW?=
 =?utf-7?B?WXAwVlB0cE0wNktCeXVGaExSVThjMlUwWmF1SWFONVVSNU1KUUp3QjFjWjdv?=
 =?utf-7?B?QlRFakR3SGFWbndyU3lud1hrL3NjRGRjTkd2eE5BQ1NXNXdGRzJneHh2QlBF?=
 =?utf-7?B?aFZTMkUrLWJKMFV5OFNVam54T3VBYUFuN295eklNU1BaTWRrOFRDajBhZTQy?=
 =?utf-7?B?RTZiU3BtTWJXS0VkUHdjZWw2TmZCRURldjY4M205UDJ2ZVF2dHpWTEpubVds?=
 =?utf-7?B?d2JsTzlyZzVjVWg4Z1dKMnIwWjgzUzJjRW42Vi9vYi9GcFdiR0JnNS9hYkFV?=
 =?utf-7?B?eGRIQzhtakJtZ0V5UjZtalZRNFNGdlFKdy80Sm00bWlCNzhzMTRZNzhpL0NF?=
 =?utf-7?B?TEhlNWMxNS8xdG8xbEl3S2IzTkpHQTVqQ2tyWUVoeElMSk9RUDZKQktka0ZD?=
 =?utf-7?B?UUd3ZnJLdkgyem4xWU12QjZZM1hsM0pMY1pKTEYxNUtibEhTbSstTlBGTGxU?=
 =?utf-7?B?dGxuQ0FOV003N3FnSEVhVFNyS3dRTDdlQ1l1OG5sRDJEKy1LVDF2bkwwOTVE?=
 =?utf-7?B?c2FrSistN1MydkJ3RFZDaWVIaE8wQTdvV0RwRlVhd1grLW53eDBOVURJRE1R?=
 =?utf-7?B?bU1ERFNtMistd1lIVCstT0E1TVQxKy1kbUhsMystdzVOMDZrblp0N1hITHJo?=
 =?utf-7?B?U2Q5NTYrLXZZbVhaWkNCV0ZlbHkyQzk5a3lKREsyeVlsOWM0TVhzbUZOdHpI?=
 =?utf-7?B?TXpRM2RVeQ==?=
Content-Type: text/plain; charset="utf-7"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR19MB4606.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b1e6b6e-dcf3-4564-ae0a-08dde14e3e78
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2025 07:33:52.8141 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Sok/auVdEIGfdIWmhHJMFCb47eKRoIwroZJbo6Z5ckx9seJDXmg9+Sa3hAzg/+4rmyN/Zl2XvhFce1PPaVRoHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS3PR19MB9415
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-22_02,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 suspectscore=0 impostorscore=0 priorityscore=1501
 mlxscore=0 spamscore=0 phishscore=0 bulkscore=0 mlxlogscore=999
 lowpriorityscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2508110000 definitions=main-2508220070
X-Authority-Analysis: v=2.4 cv=J6vzLAnS c=1 sm=1 tr=0 ts=68a81d6b cx=c_pps
 a=Z2e5DKjA+8LiMDv5v6mwwA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=wzW8d0FwaosA:10
 a=YU3QZWNX-B8A:10 a=2OwXVqhp2XgA:10 a=bt5KbKNvAAAA:8 a=8rWy6zfcAAAA:8
 a=pGLkceISAAAA:8 a=20KFwNOVAAAA:8 a=Ikd4Dj_1AAAA:8 a=QyXUC8HyAAAA:8
 a=iLNU1ar6AAAA:8 a=6-dRa9qSAAAA:8 a=eSb-bNSJAAAA:8 a=QEEkIeqjAAAA:8
 a=XlRjxQ70AAAA:8 a=BXszkKfDAAAA:8 a=XFJw1KJJAAAA:8 a=LfxEVeEBAAAA:8
 a=hFdzx7lvkWrWweqtRCcA:9 a=avxi3fN6y70A:10 a=hlJyneSgMmFPbskH-t2w:22
 a=a-zEBD5cKgE7DNtTSb7C:22 a=YjdVzJdQTyZRADMV7wFX:22 a=NZk92sZ4hQKp_Sw8PGvT:22
 a=h7YW-pclpbZRD8svLbQ0:22 a=iapMWHAMLVzCBf0btcAb:22 a=1uMOUU2w0DxzEe95gQqD:22
 a=duu7wrcty9prphiCz_fF:22 a=DKZDSSD9H29Cdu8kcpdD:22 a=7k9nRlTqVbDGZ3p5_T00:22
X-Proofpoint-GUID: eRI-Fujqg56KYWviNoN_mjKrkkc9mipT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIyMDA3MSBTYWx0ZWRfX3JfoMzI9eFJX
 01fG9ND+rT4FyzCx6jd5WwzI3LO3gNBGPKuVC7CZE2AA1XtxTmukl2WQN9R7D7YF9FacQj+fFxu
 qg6qw89jKJB6wVChF8ZtK2xRD+BSdrP6Zh71oUO3EX1gENYMahBJ7zzOGIaXeycDQlwVasSTBSw
 kv3sQg56axnOtZyaA59IrTL9xHrZFxzovIPPZ5CDddICrnI9yng4rVokkGd6DwzqFPm3sZmDfmQ
 eRg7tbemxsQ5G6dajOSe5SMr1dxqUE3GUUBsEXQ9JPmlXT+hym1dCXND7fWmERKVHtUCtUdqO0b
 ogIVbnXaz3bW33Y5k8pvm7uoJgxGyiYhqsMh15v7HyQhsEVexquQ9phpzmNqqfEvJYipctzcXPg
 2p/+LFwH+zXiIMZHio+9xHeyRrktSHT5PzGHwK7+rjzsQe3DbMLA1OmSKT9FVR6LkO8GK1am
X-Proofpoint-ORIG-GUID: eRI-Fujqg56KYWviNoN_mjKrkkc9mipT
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 clxscore=1015 lowpriorityscore=0 phishscore=0 suspectscore=0 spamscore=0
 mlxscore=0 priorityscore=1501 mlxlogscore=999 adultscore=0 malwarescore=0
 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2508110000
 definitions=main-2508220071
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

Dear Maxime, Bruce, David, Chenbo,

I would like to follow up on the status of the patches and when we should e=
xpect these to be merged into the mainline.

Please let me know if I can help answer any questions you might have.

Regards,
Pravin


Internal Use - Confidential
-----Original Message-----
From: Bathija, Pravin
Sent: Thursday, August 21, 2025 7:48 PM
To: Thomas Monjalon +ADw-thomas+AEA-monjalon.net+AD4-
Cc: dev+AEA-dpdk.org+ADs- pravin.m.bathija.dev+AEA-gmail.com+ADs- Maxime Co=
quelin +ADw-maxime.coquelin+AEA-redhat.com+AD4AOw- Chenbo Xia +ADw-chenbox+=
AEA-nvidia.com+AD4AOw- David Marchand +ADw-david.marchand+AEA-redhat.com+AD=
4AOw- Bruce Richardson +ADw-bruce.richardson+AEA-intel.com+AD4-
Subject: RE: +AFs-PATCH 0/3+AF0- vhost+AF8-user: configure memory slots

Comments inline:

-----Original Message-----
From: Thomas Monjalon +ADw-thomas+AEA-monjalon.net+AD4-
Sent: Tuesday, August 19, 2025 4:36 AM
To: Bathija, Pravin +ADw-Pravin.Bathija+AEA-dell.com+AD4-
Cc: dev+AEA-dpdk.org+ADs- pravin.m.bathija.dev+AEA-gmail.com+ADs- Maxime Co=
quelin +ADw-maxime.coquelin+AEA-redhat.com+AD4AOw- Chenbo Xia +ADw-chenbox+=
AEA-nvidia.com+AD4AOw- David Marchand +ADw-david.marchand+AEA-redhat.com+AD=
4AOw- Bruce Richardson +ADw-bruce.richardson+AEA-intel.com+AD4-
Subject: Re: +AFs-PATCH 0/3+AF0- vhost+AF8-user: configure memory slots


+AFs-EXTERNAL EMAIL+AF0-

Comments inline

12/08/2025 04:33, Pravin M Bathija:
+AD4- - add protocol feature support add and removal of memory regions/slot=
s
+AD4- dynamically.
+AD4- - this patch set has been tested with multiple instances of fio

What is +ACI-fio+ACI-?
Fio is an open-source tool to test I/O workloads on disks and file systems.

+AD4- connected via libblkio to spdk target backed unix domain socket.
+AD4- - please apply this this patch-set to dpdk mainline as well as versio=
n
+AD4- 25.03.0.

As mentionned previously, we don't plan to maintain 25.03.
I understand you need it for SPDK,
but I think SPDK should rely only on LTS branches.
Is there a specific reason why 25.03 is required in SPDK?

When we do sub-module init on spdk master, it uses dpdk version 25.03 from =
it's own sub-repo.
Our changes for vhost have already been pushed to spdk master. We have also=
 pushed the same dpdk
changes in the spdk sub-repo +ACI-dpdk+ACI- which is version 25.03. I was j=
ust ensuring that there is uniformity
in the 25.03 codebase, whether it is on the spdk sub-repo or 25.03 within d=
pdk repo.


+AD4- v2:
+AD4- - fixed warnings with e-mail address
+AD4- - fixed warnings with typos
+AD4- - there is a warning about +AF8AXw-rte+AF8-packed+AF8-begin not being=
 in pair with
+AD4- +AF8AXw-rte+AF8-packed+AF8-end which on reading the code turns out to=
 be false. It
+AD4- is an anomaly of how git-format generates the patch and how
+AD4- check-patch checks it.

When sending a v2, please use -v2 so it is reflected in the email subject.
I will remember this for next time. Thank you for pointing that out.

+AD4- Pravin M Bathija (3):
+AD4-   mailmap: add user
+AD4-   vhost+AF8-user: configure memory slots
+AD4-   vhost+AF8-user: support for memory regions
+AD4-
+AD4-  .mailmap               +AHw-   1 +-
+AD4-  lib/vhost/rte+AF8-vhost.h  +AHw-   4 +-
+AD4-  lib/vhost/vhost+AF8-user.c +AHw- 325
+AD4- +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+=
-------
+AD4-  lib/vhost/vhost+AF8-user.h +AHw-  10 +-+-
+AD4-  4 files changed, 296 insertions(+-), 44 deletions(-)



