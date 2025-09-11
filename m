Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F2CFCAC58E
	for <dpdk-dev@archiver.kernel.org>; Thu, 11 Sep 2025 22:07:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D6DF140285;
	Fri, 12 Sep 2025 00:07:18 +0200 (CEST)
Received: from mx0a-00154904.pphosted.com (mx0a-00154904.pphosted.com
 [148.163.133.20])
 by mails.dpdk.org (Postfix) with ESMTP id 3DE2640268
 for <dev@dpdk.org>; Fri, 12 Sep 2025 00:07:17 +0200 (CEST)
Received: from pps.filterd (m0170390.ppops.net [127.0.0.1])
 by mx0a-00154904.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58BHuEmt028565;
 Thu, 11 Sep 2025 18:07:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=smtpout1; bh=1
 VOg3BsDDRjwF1eCyAZh8uyZu8YnDGnJlzh/QnfzYuQ=; b=WxGtMUPybKQA4Chqi
 +h9qxaTeh9J0mqQRXycIln9pTHSMzOgDqointku0FkyFPhnKc/ydbL3YId8pLt8g
 4We/hLfTWMdPI3UbQLOiWCIWb1bHcUg97TQKYLvxzIogGwsNcYJ7NrKVC1q3bnJI
 PTWAhL8a+yUhuuHLR296qwi3qT418NHlgpuw5mF8dOYYMnvr9IGDmxzMgXUDk15m
 aGm2W9xZDIN6EU2VDmIccuOOZz99P1+JpqA4sutVdvel95DB/1n6JYERzZffwFno
 pWL6do8TtPCUmgkR4kq/kBgX7R34jmEmzjBLPzjlK8aP8HC70tfiLsELyWVKtcj8
 BzFTg==
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com
 [67.231.149.39])
 by mx0a-00154904.pphosted.com (PPS) with ESMTPS id 490xh2kha3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 11 Sep 2025 18:07:16 -0400 (EDT)
Received: from pps.filterd (m0134746.ppops.net [127.0.0.1])
 by mx0a-00154901.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58BK3XNe006463;
 Thu, 11 Sep 2025 18:07:15 -0400
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2063.outbound.protection.outlook.com [40.107.220.63])
 by mx0a-00154901.pphosted.com (PPS) with ESMTPS id 493tp8asfw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 11 Sep 2025 18:07:15 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T8Le3GZ3sCzsFrZs3hT02XH86oJWr4MGbIEIoqgp6SXdlzeOAwdgXEWgtpoMZIsD4OpoNZBwLQaSebqzuLuoO3SdYfgCdDV02kH9WnT+JsBAyGjYiP1YwbLfBCc9SclsDDkodew3OFRQlpQjyKoHSH07D6S4oPgFK1/MGEJHZwC4/MbdmDBhgzHWZsCb6/s3s7xt9GcBn7Nm9qvJpc1i0zwfcs9iM6Py9UjfJ4YM3sds7IcTMWdwpaQcSRvJDEJiOzE5upex80aj9rACEg0DpfeEAWuW60O3kAvdBVDeNOhvjkWg0NrvKOrzMxv6Tzo0dwnNfpats2PjAWfmrASc4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1VOg3BsDDRjwF1eCyAZh8uyZu8YnDGnJlzh/QnfzYuQ=;
 b=tSkpoodhPdY4EMfCEa4xxAe625VN+mbzsnU6g8kmgqppUFzXYxv1Tnxg13kb3orOTi8++U9reuUP8qWxRaaeqG93LDZJx6gACAwVsqu892tcbEcxoW6WhBuMSlOilVyjW6I005vdZyorxAehGvPnsMRikUn1L5rMz+P05qyw4bbUEPed+3hp+ITOKiwBSMxZ9fm3ILl7Mp5vqAyVuIA8pMK/Pn9EaeKPraeOf+0DIc0tbU/5U86zMcc+xxl+9//6nE5Rx5q3f8obgJL0pI+GYpLFUwOpSTY6D4qONcQtVpwTFzw/U3I7E/MhpUwkAJ6MTVtwIa09ptDqc/gGSQxuLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from SJ0PR19MB4606.namprd19.prod.outlook.com (2603:10b6:a03:289::22)
 by BL1PPFAFDB08C74.namprd19.prod.outlook.com
 (2603:10b6:20f:fc04::ecb) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Thu, 11 Sep
 2025 22:07:10 +0000
Received: from SJ0PR19MB4606.namprd19.prod.outlook.com
 ([fe80::8938:6218:a89e:ba8e]) by SJ0PR19MB4606.namprd19.prod.outlook.com
 ([fe80::8938:6218:a89e:ba8e%3]) with mapi id 15.20.9094.021; Thu, 11 Sep 2025
 22:07:10 +0000
From: "Bathija, Pravin" <Pravin.Bathija@dell.com>
To: Maxime Coquelin <maxime.coquelin@redhat.com>, Bruce Richardson
 <bruce.richardson@intel.com>, David Marchand <david.marchand@redhat.com>,
 Chenbo Xia <chenbox@nvidia.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "pravin.m.bathija.dev@gmail.com"
 <pravin.m.bathija.dev@gmail.com>, Thomas Monjalon <thomas@monjalon.net>
Subject: RE: [PATCH 0/3] vhost_user: configure memory slots
Thread-Topic: [PATCH 0/3] vhost_user: configure memory slots
Thread-Index: AQHcCzGgtkGye+sTHE2EwlyJqW9UY7Rp5H4AgAQgPWCAAFHO0IAEzWMAgAI4A7CABBa+UIAAAoIAgAAQwYCAABzsgIAVFL6g
Date: Thu, 11 Sep 2025 22:07:10 +0000
Message-ID: <SJ0PR19MB46063A3CAFB46D661EFB3A3AF509A@SJ0PR19MB4606.namprd19.prod.outlook.com>
References: <20250812023358.2400020-1-pravin.bathija@dell.com>
 <15537925.JCcGWNJJiE@thomas>
 <SJ0PR19MB4606D8D898219FE2296C7FB4F53DA@SJ0PR19MB4606.namprd19.prod.outlook.com>
 <SJ0PR19MB46063FDCC149084AFBD7C4E1F53DA@SJ0PR19MB4606.namprd19.prod.outlook.com>
 <8391ac53-0b5c-468c-ae38-341842f5c492@redhat.com>
 <SJ0PR19MB46063A880B831758A7455613F539A@SJ0PR19MB4606.namprd19.prod.outlook.com>
 <SJ0PR19MB460649E8A3D39B224CFB4469F53AA@SJ0PR19MB4606.namprd19.prod.outlook.com>
 <ab711389-82ca-4aa4-9796-55106d5fc00b@redhat.com>
 <SJ0PR19MB4606EEE4D44D487ABBD8FCC1F53AA@SJ0PR19MB4606.namprd19.prod.outlook.com>
 <51a55a38-3ca6-4a68-9869-478a2fa8e500@redhat.com>
In-Reply-To: <51a55a38-3ca6-4a68-9869-478a2fa8e500@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Enabled=True;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_SetDate=2025-09-11T21:56:58.0000000Z;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Name=No
 Protection (Label Only) - Internal
 Use; MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_ContentBits=3;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Method=Standard
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR19MB4606:EE_|BL1PPFAFDB08C74:EE_
x-ms-office365-filtering-correlation-id: 271883cf-2008-44f0-cd27-08ddf17f8df6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info: =?utf-7?B?L2xHM0VFTGtBSzJodWNDM04zVUo3MnZFQUlqWUdGVUFsMjBLTkxQL1hQZ3Fm?=
 =?utf-7?B?STdUQTFpVVQxUE5TSS9salRjVTZ1Nk5GbzVSSystQkplcjJBWHNuVFBpN29N?=
 =?utf-7?B?dU1JYmliL1ZWZjNieHZ5eExEMFJmWCstTHNqWWpRMjN0MnJYaG11dWVPUWhU?=
 =?utf-7?B?YlRKWm9WZk1vNUk0R2tXbFRpVzZIU01ibjJFeDN6Z1pndkltMVByYXozMTl0?=
 =?utf-7?B?azJDZll6V3UyRWx0TXRPUUU4dUJKSXJ2UENFOUZVTExiZVpOWlV3TmFrVU03?=
 =?utf-7?B?WUs1cUdJVXdZcktaREZKYTBpTmJxT0VLRVU1S0hjbWtUSFVmV25kV0FwMTFG?=
 =?utf-7?B?NERwRWxURDNzQTEycExTVVYxNnBKWXViTE5pVXU3b09BTTEybjJYbWxhdHZz?=
 =?utf-7?B?bzc1dlZNRzk5alY1OHdZYVVQV0c5bystKy01NWRzY2IyMlYxZnVxd0VVbG5Z?=
 =?utf-7?B?bWxxNystaXlpcHdCZjZqQVU2Q1dnaG85RnhQUHpXT2RlKy1WMEZpVXpYdkdP?=
 =?utf-7?B?L2lUeW00QS85M0NNRzllS2FZTXF0aVZZbnlNUU5qVC9RdmFqbWRuQ0d4Y2JV?=
 =?utf-7?B?WkhvZ2d0dDVTdmRMREIvQk5LS0lza2Q4eXc2YzNlTjJLM3JoZFExdTFrNjls?=
 =?utf-7?B?bHJrbncvdzFJV3Z6TzNFcUZTRXpZRlo2N1lxMjdkUDU5bnZVcFRHdU1RQWtZ?=
 =?utf-7?B?QystbWFqRWZFYm9PZHQrLXVSL1l5akp3SkZnQjlKTlVhQ3Foc0JIRzdhbkZZ?=
 =?utf-7?B?L0VDUWhVL1BLeU94azk4QzZhR3ZxOTdiWXJJeXRFZnkvL05XdHNuQnhSMDZr?=
 =?utf-7?B?SEYrLUpjbTN3Qk51ellVbEhlZXRIblIzM0hheEJBeXhXNzFoa2RuRDF2aG9E?=
 =?utf-7?B?RnErLW9qOTJRYVFoSXVLWXV1ZTBOdXpKcmVQTVU1MldvKy1OZGg3ZkY0S1la?=
 =?utf-7?B?eEhFbm16ckRlQ2dOcUdKUWZlU25xNktlWU0wY3hIY1ZuNDFkeXA0Y0FxRnYx?=
 =?utf-7?B?VWtvMFloR0RvKy1pd1dRa0VCNkh2aXpBeHR4WistRW5wSnZqdThBMEJQamwv?=
 =?utf-7?B?SzltMXRoanlvdnZvT01Mb2d1Ky1PZEJLdFU1cXJwNkg3Y1BndUxtMzRHRXox?=
 =?utf-7?B?d0xRWFM5NWZCQXduWlB4dkJld2NlTTNkSGxud2ZoTnFNbGZ4NkY3NlEwblNZ?=
 =?utf-7?B?YXgweTVlL3dEdXN2ejlxeGxhNnFWZEptRGZvWjJxcGRFSGlIUXQ1dUxsaGJt?=
 =?utf-7?B?Ky1wbGl2VHdtQUhMeC9xenVhQXZNVWU4N2toM2ZrKy01bWtyRWNlVFlTNHU3?=
 =?utf-7?B?eVRWdzRwRmRueDNMcndMbEtraGlaNUtsTlVoZkUxY2w2WVZxRmpaV213b0ZQ?=
 =?utf-7?B?VVZrWUZ5ZDUrLXpyUGtsR2gvKy14TDA0SWpxQklmYXhMUlllSmtTTUNqM3Vl?=
 =?utf-7?B?d2txN2NuYnlBNFRQQ041ZVVHWHVKS3NTZW41Z212VVRxWW01bUgrLUJpcXpI?=
 =?utf-7?B?VlZTOGc0TjhWQW5jOE9QQTk1SFB4alY2VFFCTWdQSjVBSnFyNmRoa0lZcXRO?=
 =?utf-7?B?QVM1TlZhZisteDh1cEpBVDhTWm1DSGtseGh5UkljcE13NFY0cEVYS3pmUlJB?=
 =?utf-7?B?QWpHeDhUZEFpMHNTL3NVZWRzejVjT2JMYzRrNHdYcnZHWUVTNWVMbk1YMEVM?=
 =?utf-7?B?QjV4YmJPb3FVU0ZkL1BadE81ZWtMVzJCOFcwTTVoc1RXanBHcjBHdlBEREtT?=
 =?utf-7?B?cHlUMjRDelJyMVBrbkdaUE1MQUxWNnlmNldocG9xOXpwQ1JaNGtKRThBTEk=?=
 =?utf-7?B?Ky1Oa1NJS2JvT1M4UkcxbmdqMFB6Qjc3cndsOVpNM0lXRUR3TXFLVFFFd2pG?=
 =?utf-7?B?OVJyRmRaNzVFUVNtbDV3ZmJ4ck5ZZEZ3a3RyS0M5eElSVVhNR0ZWUFhRakly?=
 =?utf-7?B?S2RhZ3pLaFZzM01ZbFcwSmV0UzIvN2hwQTFoTWdYV1VVK0FEMC0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR19MB4606.namprd19.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-7?B?dWxEV09KUjlKVlhmcVMrLWpjdk1XVE55RWxxb1lRNE9mdSstL2p2dThqWVFV?=
 =?utf-7?B?dGgvQlVyaEFldlM4Y1M0S3dmZnpOQXRlRXNraWJVMk0zR2dGNmpCN3JCbURh?=
 =?utf-7?B?dXZ2RVpNaE9FQ0R0ZFZweEZSdHFqWi9UYW1lNG5LdjU2WkMza1dnSFQ3TVRJ?=
 =?utf-7?B?dXVCMVVNMjhDa1RxaDFMT2F3Ky1qaktFM1BmRHRKd0tXY0RwZEg0WlY0ZkNa?=
 =?utf-7?B?anBzMlFaNW9SMzl6ZDBjV1RNSXpIQkF4cDBKaEgyKy1EQ2Z1U0dWZnRvUjhL?=
 =?utf-7?B?by8xODZMcDBzKy1BRVFjeklIV0M5RE13QWlZOTFHbWt4aVZ6VWdLQk1BUTZ0?=
 =?utf-7?B?VjQ4dkM2OXlLU2JkenlkM2EyWDROVEJtZXpJSlA3S21mMjhEMENyaWNDQURk?=
 =?utf-7?B?TSstUm02d0haWWNGWVk2cmNuRjZmR1hGMHFDVldubERSRWVUdEJUaHptZll5?=
 =?utf-7?B?TTg0RGwyd2xZUUxEQ0o2VnMzcFhaRU16QnZxdFU3QnlaVURHMFpRMVp2akp0?=
 =?utf-7?B?dERxbjdHQUpmZ0R6YmQvNzdXQVZRKy1iUnpFaXJWZzUrLVN6Vm1HeFVtRyst?=
 =?utf-7?B?dmZ2N2JWVVBzeFE2elgrLThqeUZ1UVZ4bHJpckxZYS9acFVndW40OHlPdlA4?=
 =?utf-7?B?Szl6eHB1TVNlS3FoSVVJRVAxMzhhZ05TcWQzWldiZG80SWpRbkNtWDFBcTE2?=
 =?utf-7?B?Zy9pQkpsbXdDTzh1ZmdTNVFEU1hFdC9KYmxEbUR6ekJkUFBleVpPbUEvOHow?=
 =?utf-7?B?UzFkSzBaandVUUFaY1hBb256WXN1T1N2TjQrLS9SdnFqQzE4WlBVUlFwcGt1?=
 =?utf-7?B?R0dXN1BQWmcwelFrRDhud1dIQnQ3Q2g5OGRIQUxoVUswMFRPVTFTWFBscWdH?=
 =?utf-7?B?QTJPN3Z3ZHRVMk1uQTNpS01wZlAvYnorLTdqMW1HWVk1ZjV3US8zd1NGUkdq?=
 =?utf-7?B?eVJZTjRlaFAxUjhpRW9LaUh6TWRIZ1lTQmxESzVCRTZBN3QzeCstdjlkZnM=?=
 =?utf-7?B?Rystem5SQkt6MVM0V1QrLTVlSistME5uV2UrLWhOcTl5dy83WURvNjI4Rjds?=
 =?utf-7?B?VjFaeistNmZ4b1Y1alNldm85SW1TWVBxM2N1RDhQZThNOFcxZGtVVmVmTWJH?=
 =?utf-7?B?S0x6elpSOGNxQThSNmQyMVFQOWNRSUNCQXY0MnZ4N1Z5S1B1MGszSmJLRzRu?=
 =?utf-7?B?UmZXREVBcjZjWHdGeHdzMzI0RnVJcFE2TXBrblN4MFd5cnJENjB3WlFZRTNW?=
 =?utf-7?B?eVBydHQ1YVJidmlMb2lOQzBadUlDSXhKZjVyMDZZQ00yZWw0RnB4ZXJWRjlt?=
 =?utf-7?B?dmM1anJhWHcwbXdVSENjR29qRkFrR29yN3loTC9Ka0NGRlJTUnc2Z1M2SWVJ?=
 =?utf-7?B?dDJmdzJQa1h6UUdMMk8vQmNkUGtrMWpEc2x3ZUdhOGxMb25KcFgxRTVQUist?=
 =?utf-7?B?TG1NY08zUy9RUWRaSkxsY3EzMHB1S2doMHZUZGpXdnEyeUcyOTZaeXdkMDJx?=
 =?utf-7?B?a3JzYjh2WExPNmdCeWM1T3Z4VENQaGpRYlNRWW9HWlhLdFh5Z3FzT2VheE1R?=
 =?utf-7?B?VlZ3ZUFVaHdiRUJadU4zeW9hUEg4QlhzN0t1ZEwwa1dPUHJKRklqTGU4dSst?=
 =?utf-7?B?WFAydWtpV2wxM0hpTFZnMXp6MlhKMzhOMystZ3UyRmJ2UEs1OExGdWJ0WGV4?=
 =?utf-7?B?OGkvRzFJZnBuN0hRQmZJblh1YW9ycm9aZmRLNWRqZEpvQzRrUDdyeHV4VU96?=
 =?utf-7?B?aHNTU01pejlVUlNmSUlFUmlxYy9CVWE4cTFZRDYydmQ5Ymp3WDZIQTZqdEFS?=
 =?utf-7?B?dlRqNDZzTk42RmdSYXJyWEJVNC9yRlJFcXY2cGRYME5JMVg3Sm5zOFY4VFVJ?=
 =?utf-7?B?Z0MxVXpxcGZVMkU5QndkZGpwWnUrLU52ZC9USW1HV3lHYW5GaystRDd4c20=?=
 =?utf-7?B?V1ArLWRsQ1dIZHhUSnJwWkwwM0hSMU9nRFI1NS9ya0s1S0hJS1JSQ2ZEdG9M?=
 =?utf-7?B?Ti81N2czaGlTWWMzeW9NRkhzMDlWR0VxYnZIL3drZEdobG5yVSsteDV1Tlpz?=
 =?utf-7?B?cXZUWCstYURrN1VZRTZFLzJ0OU1Ec1FXaGwxaFhTKy10Qlo1RGxNdER2ODN6?=
 =?utf-7?B?endxRUZYVHVuSHE5VkNvQ0JtL1VwU203ZTQ1SUF2T0JITVlRQ0tpaHVleDUy?=
 =?utf-7?B?T0NPTkxHT3NC?=
Content-Type: text/plain; charset="utf-7"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR19MB4606.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 271883cf-2008-44f0-cd27-08ddf17f8df6
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2025 22:07:10.1298 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jFehnbdrmCfNyBf5yHimvyUweDoY7SuqwZ97QMwWyT39j9I50i4XJqW6SsSyfBbX9xgj9sF4Jsk2//vO1ICtIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PPFAFDB08C74
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-11_04,2025-09-11_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 suspectscore=0 spamscore=0 phishscore=0
 clxscore=1015 malwarescore=0 adultscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509110072
X-Proofpoint-GUID: APOugTNFmh4fgB0wkDq4YFF13s0oWhVw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDIzMCBTYWx0ZWRfXw7RvyaECXJfc
 gHN1QlDaaohVw1uWtfEjMAOENzNmYlcwZXq1XTGYJD8mdZKvtBu54Fq35++IwcINo2glWpIRx+k
 18tKLuRpPVhGyqUFRVYAv4JKH7xowa1lIZLY172+65RCGWeLUMO6fd0hSMuS12wfIWaFNjGgQ46
 AWyJrtqlbAby2cGrcSaSRx+YJNgucprimorvhL8kw7OKiy1T9ILXnb/7jUQPtu09YohRTzYhOXQ
 APjTa1NGd4kQ94+iv5sTy/Leib2Ekner/2EIp1J5/oKM8rntmyF7/8TvcFHENmiNgXTB4ibFkk2
 3cKWj4ZY6oUVS1FEKGAEgxhXFY1uOxqpq6pz02QM1AUWucF5ILAYM2mclIt5Hhk4goygpbgk2JT
 1gvWR5AX
X-Authority-Analysis: v=2.4 cv=W844VQWk c=1 sm=1 tr=0 ts=68c34814 cx=c_pps
 a=j0++y401J6f/BxNAf5EDow==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=wzW8d0FwaosA:10
 a=YU3QZWNX-B8A:10 a=yJojWOMRYYMA:10 a=uherdBYGAAAA:8 a=yLxAKQgpAAAA:8
 a=20KFwNOVAAAA:8 a=iLNU1ar6AAAA:8 a=QyXUC8HyAAAA:8 a=Ikd4Dj_1AAAA:8
 a=8rWy6zfcAAAA:8 a=pGLkceISAAAA:8 a=bt5KbKNvAAAA:8 a=XlRjxQ70AAAA:8
 a=LfxEVeEBAAAA:8 a=XFJw1KJJAAAA:8 a=BXszkKfDAAAA:8 a=eSb-bNSJAAAA:8
 a=QEEkIeqjAAAA:8 a=6-dRa9qSAAAA:8 a=niFt5ncZ9HHm1gisgMwA:9 a=avxi3fN6y70A:10
 a=gbU3OgOOxF9bX48Letew:22 a=zY0JdQc1-4EAyPf5TuXT:22 a=pu3MsO4jS0LNTy4EJMSl:22
 a=YjdVzJdQTyZRADMV7wFX:22 a=a-zEBD5cKgE7DNtTSb7C:22 a=1uMOUU2w0DxzEe95gQqD:22
 a=7k9nRlTqVbDGZ3p5_T00:22 a=DKZDSSD9H29Cdu8kcpdD:22 a=duu7wrcty9prphiCz_fF:22
 a=h7YW-pclpbZRD8svLbQ0:22 a=iapMWHAMLVzCBf0btcAb:22 a=NZk92sZ4hQKp_Sw8PGvT:22
X-Proofpoint-ORIG-GUID: APOugTNFmh4fgB0wkDq4YFF13s0oWhVw
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0
 clxscore=1015 spamscore=0 adultscore=0 bulkscore=0
 phishscore=0
 suspectscore=0 malwarescore=0 priorityscore=1501 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509060230
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

Dear Maxime,

As suggested, apart from the storage networking spdk tests, I have successf=
ully run the following additional tests with dpdk applied with my patch:
1) Bring up dpdk-test-pmd vhost back-end and dpdk-test-pmd  virtio front-en=
d and send network traffic back and forth
2) Bring up dpdk-test-pmd vhost back-end and qemu running Alpine Linux conn=
ecting to dpdk vhost, sending network traffic back and forth

Please let me know if I need to run additional tests. Also I'm happy to sha=
re the test commands and logs if needed.

Thanks,
Pravin


Internal Use - Confidential
+AD4- -----Original Message-----
+AD4- From: Maxime Coquelin +ADw-maxime.coquelin+AEA-redhat.com+AD4-
+AD4- Sent: Friday, August 29, 2025 5:01 AM
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
+AD4-
+AD4-
+AD4- On 8/29/25 12:26 PM, Bathija, Pravin wrote:
+AD4- +AD4- Answers inline.
+AD4- +AD4-
+AD4- +AD4-
+AD4- +AD4- Internal Use - Confidential
+AD4- +AD4APg- -----Original Message-----
+AD4- +AD4APg- From: Maxime Coquelin +ADw-maxime.coquelin+AEA-redhat.com+AD=
4-
+AD4- +AD4APg- Sent: Friday, August 29, 2025 2:18 AM
+AD4- +AD4APg- To: Bathija, Pravin +ADw-Pravin.Bathija+AEA-dell.com+AD4AOw-=
 Bruce Richardson
+AD4- +AD4APg- +ADw-bruce.richardson+AEA-intel.com+AD4AOw- David Marchand
+AD4- +AD4APg- +ADw-david.marchand+AEA-redhat.com+AD4AOw- Chenbo Xia +ADw-c=
henbox+AEA-nvidia.com+AD4-
+AD4- +AD4APg- Cc: dev+AEA-dpdk.org+ADs- pravin.m.bathija.dev+AEA-gmail.com=
+ADs- Thomas Monjalon
+AD4- +AD4APg- +ADw-thomas+AEA-monjalon.net+AD4-
+AD4- +AD4APg- Subject: Re: +AFs-PATCH 0/3+AF0- vhost+AF8-user: configure m=
emory slots
+AD4- +AD4APg-
+AD4- +AD4APg-
+AD4- +AD4APg- +AFs-EXTERNAL EMAIL+AF0-
+AD4- +AD4APg-
+AD4- +AD4APg- Hi Pravin,
+AD4- +AD4APg-
+AD4- +AD4APg- On 8/29/25 11:11 AM, Bathija, Pravin wrote:
+AD4- +AD4APgA+- Dear Maxime, Bruce, David, Chenbo,
+AD4- +AD4APgA+-
+AD4- +AD4APgA+- Could you please help review the code ? The goal is to mer=
ge the
+AD4- +AD4APgA+- changes
+AD4- +AD4APg- before September 18 when the merge window closes for SPDK v2=
5.09.
+AD4- +AD4APg-
+AD4- +AD4APg- I will help review the code, but there are no guarantee it w=
ill be
+AD4- +AD4APg- merged in main branch before September 18th.
+AD4- +AD4- Thank you for your consideration.
+AD4- +AD4-
+AD4- +AD4APg-
+AD4- +AD4APg- Can you elaborate about the tests you have run?
+AD4- +AD4- - Run I/O tests using fio and libblkio engine to SPDK vhost use=
r block
+AD4- +AD4- targets with multiple targets and different block sizes
+AD4- +AD4- - Custom system tests defined within SPDK framework
+AD4- +AD4- https://urldefense.com/v3/+AF8AXw-https://review.spdk.io/c/spdk=
/spdk/+ACo-/26395
+AD4- +AD4-
+AD4- +AF8AXwA7-Kw+ACEAIQ-LpKI+ACE-nQ+AF8-7qq10Gy3KLQB0sGNsLi15QuRrmxDpIq6d=
o36yuGMxY3T1iXey
+AD4- U6wQer
+AD4- +AD4- Zs7xZbVMtiozXTR7XAwqUJOi3Mf9hsM-gghA+ACQ- +AFs-review+AFs-.+AF0=
-spdk+AFs-.+AF0-io+AF0-
+AD4- +AD4- - QEMU bring up with SPDK Virtio block device
+AD4- +AD4-
+AD4- +AD4APg- Have you ensured it is still working properly with Vhsot-use=
r/Virtio-net?
+AD4- +AD4- Yes tests have been run to ensure this as listed above
+AD4-
+AD4- You have only run storage tests, not networking test.
+AD4- So the DPDK Vhost datapath has not been exercised, neither the IOMMU
+AD4- AFAICT.
+AD4-
+AD4- Maxime
+AD4-
+AD4- +AD4-
+AD4- +AD4APg-
+AD4- +AD4APg- Maxime
+AD4- +AD4APg-
+AD4- +AD4APgA+- Regards,
+AD4- +AD4APgA+- Pravin
+AD4- +AD4APgA+-
+AD4- +AD4APgA+-
+AD4- +AD4APgA+- Internal Use - Confidential
+AD4- +AD4APgA+AD4- -----Original Message-----
+AD4- +AD4APgA+AD4- From: Bathija, Pravin
+AD4- +AD4APgA+AD4- Sent: Tuesday, August 26, 2025 11:47 AM
+AD4- +AD4APgA+AD4- To: Maxime Coquelin +ADw-maxime.coquelin+AEA-redhat.com=
+AD4AOw- Bruce Richardson
+AD4- +AD4APgA+AD4- +ADw-bruce.richardson+AEA-intel.com+AD4AOw- David March=
and
+AD4- +AD4APgA+AD4- +ADw-david.marchand+AEA-redhat.com+AD4AOw- Chenbo Xia +=
ADw-chenbox+AEA-nvidia.com+AD4-
+AD4- +AD4APgA+AD4- Cc: dev+AEA-dpdk.org+ADs- pravin.m.bathija.dev+AEA-gmai=
l.com+ADs- Thomas Monjalon
+AD4- +AD4APgA+AD4- +ADw-thomas+AEA-monjalon.net+AD4-
+AD4- +AD4APgA+AD4- Subject: RE: +AFs-PATCH 0/3+AF0- vhost+AF8-user: config=
ure memory slots
+AD4- +AD4APgA+AD4-
+AD4- +AD4APgA+AD4- Answers inline.
+AD4- +AD4APgA+AD4-
+AD4- +AD4APgA+AD4APg- -----Original Message-----
+AD4- +AD4APgA+AD4APg- From: Maxime Coquelin +ADw-maxime.coquelin+AEA-redha=
t.com+AD4-
+AD4- +AD4APgA+AD4APg- Sent: Monday, August 25, 2025 1:49 AM
+AD4- +AD4APgA+AD4APg- To: Bathija, Pravin +ADw-Pravin.Bathija+AEA-dell.com=
+AD4AOw- Bruce Richardson
+AD4- +AD4APgA+AD4APg- +ADw-bruce.richardson+AEA-intel.com+AD4AOw- David Ma=
rchand
+AD4- +AD4APgA+AD4APg- +ADw-david.marchand+AEA-redhat.com+AD4AOw- Chenbo Xi=
a +ADw-chenbox+AEA-nvidia.com+AD4-
+AD4- +AD4APgA+AD4APg- Cc: dev+AEA-dpdk.org+ADs- pravin.m.bathija.dev+AEA-g=
mail.com+ADs- Thomas Monjalon
+AD4- +AD4APgA+AD4APg- +ADw-thomas+AEA-monjalon.net+AD4-
+AD4- +AD4APgA+AD4APg- Subject: Re: +AFs-PATCH 0/3+AF0- vhost+AF8-user: con=
figure memory slots
+AD4- +AD4APgA+AD4APg-
+AD4- +AD4APgA+AD4APg-
+AD4- +AD4APgA+AD4APg- +AFs-EXTERNAL EMAIL+AF0-
+AD4- +AD4APgA+AD4APg-
+AD4- +AD4APgA+AD4APg- Hi,
+AD4- +AD4APgA+AD4APg-
+AD4- +AD4APgA+AD4APg- Please try to fix your email client so that we can f=
ollow the replies
+AD4- inlined.
+AD4- +AD4APgA+AD4-
+AD4- +AD4APgA+AD4- Thank you for the input. I have made the necessary adju=
stments.
+AD4- +AD4APgA+AD4- Please let me know if there is anything missing.
+AD4- +AD4APgA+AD4-
+AD4- +AD4APgA+AD4APg-
+AD4- +AD4APgA+AD4APg- On 8/22/25 9:33 AM, Bathija, Pravin wrote:
+AD4- +AD4APgA+AD4APgA+- Dear Maxime, Bruce, David, Chenbo,
+AD4- +AD4APgA+AD4APgA+-
+AD4- +AD4APgA+AD4APgA+- I would like to follow up on the status of the pat=
ches and when
+AD4- +AD4APgA+AD4APgA+- we should
+AD4- +AD4APgA+AD4APg- expect these to be merged into the mainline.
+AD4- +AD4APgA+AD4APgA+-
+AD4- +AD4APgA+AD4APgA+- Please let me know if I can help answer any questi=
ons you might have.
+AD4- +AD4APgA+AD4APgA+-
+AD4- +AD4APgA+AD4APgA+- Regards,
+AD4- +AD4APgA+AD4APgA+- Pravin
+AD4- +AD4APgA+AD4APgA+-
+AD4- +AD4APgA+AD4APgA+-
+AD4- +AD4APgA+AD4APgA+- Internal Use - Confidential
+AD4- +AD4APgA+AD4APgA+- -----Original Message-----
+AD4- +AD4APgA+AD4APgA+- From: Bathija, Pravin
+AD4- +AD4APgA+AD4APgA+- Sent: Thursday, August 21, 2025 7:48 PM
+AD4- +AD4APgA+AD4APgA+- To: Thomas Monjalon +ADw-thomas+AEA-monjalon.net+A=
D4-
+AD4- +AD4APgA+AD4APgA+- Cc: dev+AEA-dpdk.org+ADs- pravin.m.bathija.dev+AEA=
-gmail.com+ADs- Maxime
+AD4- Coquelin
+AD4- +AD4APgA+AD4APgA+- +ADw-maxime.coquelin+AEA-redhat.com+AD4AOw- Chenbo=
 Xia +ADw-chenbox+AEA-nvidia.com+AD4AOw-
+AD4- +AD4APgA+AD4- David
+AD4- +AD4APgA+AD4APgA+- Marchand +ADw-david.marchand+AEA-redhat.com+AD4AOw=
- Bruce Richardson
+AD4- +AD4APgA+AD4APgA+- +ADw-bruce.richardson+AEA-intel.com+AD4-
+AD4- +AD4APgA+AD4APgA+- Subject: RE: +AFs-PATCH 0/3+AF0- vhost+AF8-user: c=
onfigure memory slots
+AD4- +AD4APgA+AD4APgA+-
+AD4- +AD4APgA+AD4APgA+- Comments inline:
+AD4- +AD4APgA+AD4APgA+-
+AD4- +AD4APgA+AD4APgA+- -----Original Message-----
+AD4- +AD4APgA+AD4APgA+- From: Thomas Monjalon +ADw-thomas+AEA-monjalon.net=
+AD4-
+AD4- +AD4APgA+AD4APgA+- Sent: Tuesday, August 19, 2025 4:36 AM
+AD4- +AD4APgA+AD4APgA+- To: Bathija, Pravin +ADw-Pravin.Bathija+AEA-dell.c=
om+AD4-
+AD4- +AD4APgA+AD4APgA+- Cc: dev+AEA-dpdk.org+ADs- pravin.m.bathija.dev+AEA=
-gmail.com+ADs- Maxime
+AD4- Coquelin
+AD4- +AD4APgA+AD4APgA+- +ADw-maxime.coquelin+AEA-redhat.com+AD4AOw- Chenbo=
 Xia +ADw-chenbox+AEA-nvidia.com+AD4AOw-
+AD4- +AD4APgA+AD4- David
+AD4- +AD4APgA+AD4APgA+- Marchand +ADw-david.marchand+AEA-redhat.com+AD4AOw=
- Bruce Richardson
+AD4- +AD4APgA+AD4APgA+- +ADw-bruce.richardson+AEA-intel.com+AD4-
+AD4- +AD4APgA+AD4APgA+- Subject: Re: +AFs-PATCH 0/3+AF0- vhost+AF8-user: c=
onfigure memory slots
+AD4- +AD4APgA+AD4APgA+-
+AD4- +AD4APgA+AD4APgA+-
+AD4- +AD4APgA+AD4APgA+- +AFs-EXTERNAL EMAIL+AF0-
+AD4- +AD4APgA+AD4APgA+-
+AD4- +AD4APgA+AD4APgA+- Comments inline
+AD4- +AD4APgA+AD4APgA+-
+AD4- +AD4APgA+AD4APgA+- 12/08/2025 04:33, Pravin M Bathija:
+AD4- +AD4APgA+AD4APgA+AD4- - add protocol feature support add and removal =
of memory
+AD4- +AD4APgA+AD4APgA+AD4- regions/slots dynamically.
+AD4- +AD4APgA+AD4APgA+AD4- - this patch set has been tested with multiple =
instances of fio
+AD4- +AD4APgA+AD4APgA+-
+AD4- +AD4APgA+AD4APgA+- What is +ACI-fio+ACI-?
+AD4- +AD4APgA+AD4APgA+- Fio is an open-source tool to test I/O workloads o=
n disks and file
+AD4- systems.
+AD4- +AD4APgA+AD4APgA+-
+AD4- +AD4APgA+AD4APgA+AD4- connected via libblkio to spdk target backed un=
ix domain socket.
+AD4- +AD4APgA+AD4APgA+AD4- - please apply this this patch-set to dpdk main=
line as well as
+AD4- +AD4APgA+AD4APgA+AD4- version 25.03.0.
+AD4- +AD4APgA+AD4APgA+-
+AD4- +AD4APgA+AD4APgA+- As mentionned previously, we don't plan to maintai=
n 25.03.
+AD4- +AD4APgA+AD4APgA+- I understand you need it for SPDK, but I think SPD=
K should rely
+AD4- +AD4APgA+AD4APgA+- only on LTS branches.
+AD4- +AD4APgA+AD4APgA+- Is there a specific reason why 25.03 is required i=
n SPDK?
+AD4- +AD4APgA+AD4APgA+-
+AD4- +AD4APgA+AD4APgA+- When we do sub-module init on spdk master, it uses=
 dpdk version
+AD4- +AD4APgA+AD4APgA+- 25.03 from
+AD4- +AD4APgA+AD4APg- it's own sub-repo.
+AD4- +AD4APgA+AD4APgA+- Our changes for vhost have already been pushed to =
spdk master. We
+AD4- +AD4APgA+AD4APgA+- have also pushed the same dpdk changes in the spdk=
 sub-repo +ACI-dpdk+ACI-
+AD4- +AD4APgA+AD4APgA+- which is version 25.03. I was just ensuring that t=
here is
+AD4- +AD4APgA+AD4APgA+- uniformity in the 25.03
+AD4- +AD4APgA+AD4APg- codebase, whether it is on the spdk sub-repo or 25.0=
3 within dpdk repo.
+AD4- +AD4APgA+AD4APg-
+AD4- +AD4APgA+AD4APg- Ok, still, it would be better for SPDK to uses LTS a=
s we have no
+AD4- +AD4APgA+AD4APg- plans to add extra stable branches.
+AD4- +AD4APgA+AD4APg-
+AD4- +AD4APgA+AD4APg- Also, your series may be considered as a feature and=
 not a bug
+AD4- +AD4APgA+AD4APg- fix, so even if
+AD4- +AD4APgA+AD4APg- 25.03 would be a stable branch (which it is not), it=
 would not be
+AD4- +AD4APgA+AD4APg- backported against it.
+AD4- +AD4APgA+AD4-
+AD4- +AD4APgA+AD4- Understood. I would request that we merge my changes in=
to DPDK
+AD4- +AD4APgA+AD4- mainline before September 18 when the merge window clos=
es for SPDK
+AD4- +AD4APg- v25.09.
+AD4- +AD4APgA+AD4-
+AD4- +AD4APgA+AD4APg-
+AD4- +AD4APgA+AD4APgA+-
+AD4- +AD4APgA+AD4APgA+-
+AD4- +AD4APgA+AD4APgA+AD4- v2:
+AD4- +AD4APgA+AD4APgA+AD4- - fixed warnings with e-mail address
+AD4- +AD4APgA+AD4APgA+AD4- - fixed warnings with typos
+AD4- +AD4APgA+AD4APgA+AD4- - there is a warning about +AF8AXw-rte+AF8-pack=
ed+AF8-begin not being in pair
+AD4- +AD4APgA+AD4APgA+AD4- with +AF8AXw-rte+AF8-packed+AF8-end which on re=
ading the code turns out to be
+AD4- +AD4APgA+AD4APgA+AD4- false. It is an anomaly of how git-format gener=
ates the patch
+AD4- +AD4APgA+AD4APgA+AD4- and how check-patch checks it.
+AD4- +AD4APgA+AD4APgA+-
+AD4- +AD4APgA+AD4APgA+- When sending a v2, please use -v2 so it is reflect=
ed in the email subject.
+AD4- +AD4APgA+AD4APgA+- I will remember this for next time. Thank you for =
pointing that out.
+AD4- +AD4APgA+AD4APgA+-
+AD4- +AD4APgA+AD4APgA+AD4- Pravin M Bathija (3):
+AD4- +AD4APgA+AD4APgA+AD4-      mailmap: add user
+AD4- +AD4APgA+AD4APgA+AD4-      vhost+AF8-user: configure memory slots
+AD4- +AD4APgA+AD4APgA+AD4-      vhost+AF8-user: support for memory regions
+AD4- +AD4APgA+AD4APgA+AD4-
+AD4- +AD4APgA+AD4APgA+AD4-     .mailmap               +AHw-   1 +-
+AD4- +AD4APgA+AD4APgA+AD4-     lib/vhost/rte+AF8-vhost.h  +AHw-   4 +-
+AD4- +AD4APgA+AD4APgA+AD4-     lib/vhost/vhost+AF8-user.c +AHw- 325
+AD4- +AD4APgA+AD4APgA+AD4- +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+=
-+-+-+-+-+-+-+-+-+-+-+-------
+AD4- +AD4APgA+AD4APgA+AD4-     lib/vhost/vhost+AF8-user.h +AHw-  10 +-+-
+AD4- +AD4APgA+AD4APgA+AD4-     4 files changed, 296 insertions(+-), 44 del=
etions(-)
+AD4- +AD4APgA+AD4APgA+-
+AD4- +AD4APgA+AD4APgA+-
+AD4- +AD4APgA+AD4APgA+-
+AD4- +AD4APgA+-
+AD4- +AD4-

