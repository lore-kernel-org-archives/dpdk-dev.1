Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DE78C54F30
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 May 2025 07:02:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DAFA0402ED;
	Tue, 27 May 2025 09:02:35 +0200 (CEST)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 7C3A4402D6
 for <dev@dpdk.org>; Tue, 27 May 2025 09:02:34 +0200 (CEST)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54R6Xndr024968
 for <dev@dpdk.org>; Tue, 27 May 2025 00:02:33 -0700
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 46w88001h5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Tue, 27 May 2025 00:02:33 -0700 (PDT)
Received: from m0431384.ppops.net (m0431384.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 54R6xCmu032404
 for <dev@dpdk.org>; Tue, 27 May 2025 00:02:32 -0700
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2123.outbound.protection.outlook.com [40.107.243.123])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 46w88001h4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 27 May 2025 00:02:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zDlmn0tYF2YasbuYcJcP2IVz1aJdyp6sNGs5VQqLHLUoUASy6vJwzAvMZs6diX1+8oD5sLcJI2lrOKSMiAOKOY+KDDKSEVTu2+caBhcmsw/e/7CTRwRhLhFXZnCqD7AkvUK9XPh0tfugQlPzsYHG/JiLY9qbdTrMxL2qilebmCH2720HJgIiyv+PswkXKD0As9KXy2pE66pOWxhazox3cnUNqo0KwaGvbQd2HwwEHAV3l83fyOammAlRgBhu366b2uH8WsNgAwqDOpxUIW0/SQbLrNtKmpybPUth9HpPGbmWlh1grbVttQmBWIqh+r/CbT/NrkiWoyI+m4CKIIxV0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HUJhPRn7ZbTH9uZdd/Xn6QRi1VKXCeKx9x6/ZNCpH2U=;
 b=DJDDIyX4ISBFBrWfL7SDuWPGPhPQ1Z0BH393NF3v2MfkOKDof/SfvO8bJ3sHosEQrBD/nMmmpEqGO2/vP8CtyVNI/6VECVeFjnswEilO2nPxnhhjsUUqVqGqY4kJIn8ONtnDv6xyy9R3o5Ju2bonI80sDRXIv6iy+l8XZIb3rPWmWuLxLhKEwy7C42BcJwdlxq/+MHpjTE9O95wC5uWtPDNYqZteLpuEGRv9brv4HLA+CmSE0HxUVoKUwk6EB+5037Mad1dLgj94fiYNCZcZ334kmOHyTIJp7bSi/yAqssZQXDlAEqv+TOFaqEX2syynCPOq0rjCn6Q0UGXh7l9qAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HUJhPRn7ZbTH9uZdd/Xn6QRi1VKXCeKx9x6/ZNCpH2U=;
 b=RX7iZYoi8tKt5tQx865OuoLN6IIBIa0wVyqg7oD6nBOj5iuskn+wX4VOfzzSPuTyZzOqD3utWTYwzwZrSC9WXanB8gtd4L6gE2U9B4g3IH6lteJyI0Syo3rnx554lsVsmLGSF1a3Gx2KLAIME5bcLBm9INq/0qPEMdd0TbeMsNA=
Received: from PH0PR18MB4086.namprd18.prod.outlook.com (2603:10b6:510:3::9) by
 CH3PR18MB5404.namprd18.prod.outlook.com (2603:10b6:610:156::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.25; Tue, 27 May
 2025 07:02:29 +0000
Received: from PH0PR18MB4086.namprd18.prod.outlook.com
 ([fe80::ed37:4ea0:6359:f717]) by PH0PR18MB4086.namprd18.prod.outlook.com
 ([fe80::ed37:4ea0:6359:f717%6]) with mapi id 15.20.8769.019; Tue, 27 May 2025
 07:02:28 +0000
From: Pavan Nikhilesh Bhagavatula <pbhagavatula@marvell.com>
To: Jerin Jacob <jerinj@marvell.com>, Andre Muezerie
 <andremue@linux.microsoft.com>, Nithin Kumar Dabilpuram
 <ndabilpuram@marvell.com>, Kiran Kumar Kokkilagadda
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha
 Koteswara Rao Kottidi <skoteshwar@marvell.com>, Harman Kalra
 <hkalra@marvell.com>
CC: "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [EXTERNAL] [PATCH] drivers: remove __rte_used from functions for
 compatibility with MSVC
Thread-Topic: [EXTERNAL] [PATCH] drivers: remove __rte_used from functions for
 compatibility with MSVC
Thread-Index: AQHbpQOk6Y8dA8EHNUaYLMIT/vMIjLPmPyyAgAAhBMA=
Date: Tue, 27 May 2025 07:02:28 +0000
Message-ID: <PH0PR18MB4086220D295D076CD17E50C5DE64A@PH0PR18MB4086.namprd18.prod.outlook.com>
References: <1743731269-5936-1-git-send-email-andremue@linux.microsoft.com>
 <BY3PR18MB4785102E282A25D741443B84C864A@BY3PR18MB4785.namprd18.prod.outlook.com>
In-Reply-To: <BY3PR18MB4785102E282A25D741443B84C864A@BY3PR18MB4785.namprd18.prod.outlook.com>
Accept-Language: en-US, en-IN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR18MB4086:EE_|CH3PR18MB5404:EE_
x-ms-office365-filtering-correlation-id: 3636ed29-a241-4817-a830-08dd9cec719e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?TFd2MGRqTTVZelo4YTBmbzlWOExub3hmcW1UZGdHd2cvaE9vaFhZdndOajhF?=
 =?utf-8?B?MC9HN2xOWjVGRU0rRFlGVkc5cU8vYW5ZamtSVWhrbzd5L1U1dUdubWVTUFJE?=
 =?utf-8?B?anFwak5GWXVLQlMydnI5c2dINko2c21CSURJaEZUNVQvWEhrUlVOTFZWcVRs?=
 =?utf-8?B?N3ZBM21ibjdLdmdyTDREMjBiRFVGU1RuMW13a3dKelh3aVZyU3NqZ0F0d29v?=
 =?utf-8?B?M1NjYnAzNmk4dzl3dHVYaWhPcWthSlBOTE9WdmloVlBpQi81aDRMRCtGTHRz?=
 =?utf-8?B?cFIzOTZicWprY2dtdStsVkg5VzRKNSs2cGVuZkRPOGI5SWU5V3h0eUFURXB3?=
 =?utf-8?B?cVpyTTJ3bW8vam9tczU4ME01enRPd3ppbk1yZGZFaTVEQ1dVNGZlY291dTND?=
 =?utf-8?B?djZZNEl3eU1PM2RoelJLSkE3QWpid0JmMUxsa1VSczVndjRrRzlxSmdhdmIx?=
 =?utf-8?B?Vi9oSWFHaERKbW1xbHFYVG5hSzUveDQ1UjBmYkVhYkJqbnZxaDI5ZHpxMEx3?=
 =?utf-8?B?VURZNFN2azNQcUUwVkUxNVRKMmFxOEtYZGZicHh3YkJYR1ZPaE8vZk5UeUNw?=
 =?utf-8?B?VUxTbk11WmRicmxWbTJITnNOZVR0ZE14ZkM2cUdlRzZlbWM5YyttWUxQN2wv?=
 =?utf-8?B?cnF6NElVQ3pJRmNwd3ZTY3BCNVRTeUFaeStmRjJteDMvek5kMzI3ZWxkaGpo?=
 =?utf-8?B?amM3SFhtY2x1R1c1QWdzVStjcnlUdjRmdlJjZlY1VjhXcWRtb2QwQ0FuNzNS?=
 =?utf-8?B?VVlRNXM0YUJ1WEhEVzY3UGxXSnNSRVN0R0hRUEM1dVlsUDVQdHhkNXprakdh?=
 =?utf-8?B?SjRPYXJCZXppaEdZdWdoR2EvZ0EyZnpmQnc5Z2tFVFUyd3dQMTh0ZjZTZFRG?=
 =?utf-8?B?ZDhmUWYzS1llV1YzQ1g1Sno1Q1NBNmwwVk0wUkk3YSttMWdGbFJ2RjZxUVJD?=
 =?utf-8?B?bkgvUi9LK0hBcHMvblJ4cWVmT0sxblpoUkRPUzFkNkQvZG1yYXhOWllBdHl0?=
 =?utf-8?B?RGxiUUdXZzlaU01ySWdGS2dUWXgzbTBrdWdmWUpKZmVTTDkrUGJnTUVlN3p4?=
 =?utf-8?B?NlBBQ3RkVmgrU0YreXpvWkNFZUdyeVVlSzJhS0RIOVVWUHd6a3JCSVkxSHc2?=
 =?utf-8?B?eXdKMXQ0TGMrVHEwaGlrcnFjZXBOamQyMGFiOFBUMXBSTEVCK2tMcEhRZ2tL?=
 =?utf-8?B?emRXeER6Tml3NytDZER4OFJrQVZpdlJMTmxoMENpYnRHaXpKVFdzMnJ3K1ov?=
 =?utf-8?B?ck5QUW9ENEFoNlhZckZsR1NCMHpmNWkydmxTNzNrRnJzZTNtVkxPdWN1eGtV?=
 =?utf-8?B?TXlvT3VnWms4UWlzSFMxRDRSMWJWMHhTdUxFbmdTZnZBWWFxajZMSUpxZ0xz?=
 =?utf-8?B?dGdCVFk4ZThMdUlWMlE3ZENVTHpvVGwxY3lyV0xsZlYvTmhXTzYvRVBFbTln?=
 =?utf-8?B?MXJIbDlvTXBoS2haNGhIL25tT2dZdmJHeS81NUtOa3VmOVlyZ0JQcVFNOFpO?=
 =?utf-8?B?Tkp5TFBZSlFoenZSbnRlNE9XRU1VRGZNTUE0M0JGc3NyQmR0cDJrNVVKNTdP?=
 =?utf-8?B?RTQrYU1SSVJkVmdJYkxNNHJISkZLemRQNXVReE10c3I4QTBhUXZJbkl1Vmtz?=
 =?utf-8?B?MDU4YzIwNFZKSm9aZEZWeTd5SjZTdHloTk8zM2hLcy9kQm9OZVVScDFMKzgx?=
 =?utf-8?B?R3FWQy9TSkMxelBEY1ZRbUt3cktUTHZUWlFQVUJ4OUhkNENsbVczNzdON1Z1?=
 =?utf-8?B?bk5LWWJxaHRPd21ZeGdtZzI3Nkp0Q1JDRGlFMzRYUU5LNzFmbVVreEJOSG93?=
 =?utf-8?B?aUNyVTVwNFRpOXVuNGxsUXBGc2ZoRnlmRGJuOXVGZ2tOTlJSLzNLRU11Zm5p?=
 =?utf-8?B?TFlaL2k1NzNERXdIUDkyR3o1Y2dzV0o3b1JpNWhpOGozaXB2VFZuNlplN3FD?=
 =?utf-8?Q?0ERfiOdblhWefqd180xdKRPY9zYAuqjp?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR18MB4086.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WDRZcER4aXRRK0J3S1Z2ckpGd1RaRHNQN2FIUmFyNFpJaEFxOWwxVGQ2eS9h?=
 =?utf-8?B?SjM5VW5tcTlvUVV4RnBqR0xiS1pXUitPSVY2eURINjladlNkRFNFYVlQdnJR?=
 =?utf-8?B?NDFGUXVubWsxUlpqZ0JCZjN1TDJaUUpYRnVsenBRNCtBaFpJdXF1UUZFOXFh?=
 =?utf-8?B?VXZnNnhyMFRwaCtudXR3d1FOY09ocHVKM0JxeGY0MHBNYjUrOWh3bS9rdWs3?=
 =?utf-8?B?N21QMW9aUTlSNVh6R2VIMjJvV1Y2Z1R3cGdtYWVMeVYzSjV0RGY3dHpCTjBY?=
 =?utf-8?B?VFpnTHo0azRLamQrV0x1Y0hwL1IvNE5lZFJ2M3pFQjlmdXJGZEcyOTNRSEtK?=
 =?utf-8?B?SFpKWXNrU1hQMTRYczMzcVh2SXcvVkpadGF0V0o0bHFEZWd1T2ptQ0NYejZG?=
 =?utf-8?B?TWZFRmU2dmJvandxaW9ncE8rWk12dDhJREpyeDVQQ1d1aG1hdkhNZnFmN0NF?=
 =?utf-8?B?WS9uNVNTei95Sm5GL0dsS01vUlJWWlVaWmRQdUlXMWIrdXhYSUc4VTlHYVFn?=
 =?utf-8?B?TjZ3b3oyWkxPWjgxOVpkQytpRld2djZzcFBYWXR2TFV5eGZjTDlnNGtCN1Rv?=
 =?utf-8?B?cHJWUzd4TTU4TTF6U29jUFJ1YXJKN0xSN2ZKdVNMaDRlajBLRnljSG1nVTNl?=
 =?utf-8?B?Z0d2SlkrNzYyMnFuYnJES2phRXdNVnlnWjZBamZ0cDArQTJXNlRZeEFwb1Ju?=
 =?utf-8?B?QTdYbGdEL05tUHpocmdJV21VajJXMHl4VndvZHpmcUFyb2tDNnRMUmN5Zk9r?=
 =?utf-8?B?UVFlYzVUZU9qWllaR0poVmdsaXVFRzJzV3BNMFlCTkNuVnJUTThPMFdJQUhM?=
 =?utf-8?B?VmVGOWJuT2xlQkpTQmJzUURtTGtGK1hvOENpWXFnd290SjJ3M09hUlpNdGQ1?=
 =?utf-8?B?Mnc0VEdhUG9qd2dBL2tJZ0x0RVd2UldzcVc4UVozcXpJODZoSyt4ZUxUUjFM?=
 =?utf-8?B?d0NTMVhBMFduVDBkQlJ4djBXdVhLSUVkL0VHaXM0cEJCWnpSVDZzdGNFTXM4?=
 =?utf-8?B?aWptMzVnODA4TnNhajBqb0drUlRWRTErZ0dZVXUwRi84OE9JSzNvemJBZ2tK?=
 =?utf-8?B?OHZNL2VCd1MyVUJkZ0Q1aUlsVU82V1VabkJXSHNPbHdDL1h6NllLNG5YNkFV?=
 =?utf-8?B?N2FvRWJUdW9CaXN2bHMwdjZBbDVudHo1V3pyOGRrTVh4MzBSeU9oSjY5cHND?=
 =?utf-8?B?cXNqV1Q4dndici9JK3ZESTZjMDhEMDBUQnFZZjlBR2t5VW0rbHVSbUpGWExE?=
 =?utf-8?B?alVIdzJqWHhFM2FLTEg3dzEyOGhkNDFuNGpIc0ppbGdMYlp2NkdFSUNpVXMx?=
 =?utf-8?B?YjNqcnJxWTUveFcxLzNXU3M1Y0JWOFZqNHZaSWhLeXJmVm1VelBqYjRkdVpr?=
 =?utf-8?B?ZXBodFl6bk8wWlRsN29IR1dKLzF6Y0tkMythZzNtZXpuaGhzcE1HeENwd1Nx?=
 =?utf-8?B?Q3MwK2pOT3J4M29NNUN3bGtZWXMxZnFjQXNYU0ZPSG5uOHRKNDNhelBlcmtt?=
 =?utf-8?B?U1FjNVlsaGg3WU9rWkluU1Q4WmVNVzBZVmU2UHRqTDRkS3N5TThsR2F6TWV0?=
 =?utf-8?B?Uml5RGY4MnZsVDlFMjZDVVF0UldGdWNLL0l6VEhoM0QrT2ozS1pJNmY3RUNK?=
 =?utf-8?B?RURRSzdPd1N4MkRXajVCa0trSmVyZ2FDZ3BESzFEK1dIcVZCd2xaMStFY2c1?=
 =?utf-8?B?WTlYSC93cldLbCtOOVpIZHRhOWpTeWQ3d2tVOVk3elNQZ0tXVXdhUG1KM1gy?=
 =?utf-8?B?R25OZUVDNXFWbklReFgyRlR2T3BhMFlqSzBKdmRaUDdSVXFsU1JhcW9MeFRS?=
 =?utf-8?B?SThhSGdrejIrSFpyN2RRKzRITHNKNkJrK29ycE85eHQ0L0VQcVduSWFMc0ti?=
 =?utf-8?B?SkZCTTNLbFFKMFVudVpFZ1hlTDNlSWNPa3NwOGdsRmlSQitGNDlKbDR5TEZ2?=
 =?utf-8?B?Z3BUT0IrVmROSkJDRnJ5SXhKcXpVYXcrQUpyNW5sS0J6RjArdWx0ZUpObmNu?=
 =?utf-8?B?WW5nZjJRc2duOXdZclh3V3p2anA3V29vUVBPTkU5ckVvVkoveWZXSUt0MWdP?=
 =?utf-8?B?NXlvTGpxMFBRU25GTk5kc3Q3VWJYSUNmSUJYTVE2elFTbXJ1WDE0b2ZFRkcw?=
 =?utf-8?Q?aFumq7y1uGKG6ZBKf/TI44YXS?=
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR18MB4086.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3636ed29-a241-4817-a830-08dd9cec719e
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2025 07:02:28.8683 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dGBkMejttemvnYZl3C8X0dzsbaW+g1FymIT06vwIF20sdEEkAJMtmQaNJWhOosAgjXaZvqtGS1jpR+A1yNrb20R3DlCdLcY7B+mQcrOqaFo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR18MB5404
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI3MDA1NSBTYWx0ZWRfX6HS+kSeJ/rhI
 9qK1cNlD872VuHG7krgNeccFn2Nf6TCfh+8x/SwzoDBvIIXbwiOB/bgi+Gnywzk14XK9qiJQD0Y
 7X6zK3V0MoR//C6VS0Cs0BNTpjLQ4nedpWsHqHsh3EYxv90tFb9MwDhilXSzNbwlqos/2fOEquT
 MPbAGtXjJGdrDNiyuhOWxxY8E4zXcXGQw557RKVqj51CCIShgxhgZRdLsu1w3ZKQtR0SXikJ9/+
 JWlUDRL99T6yhLV7M5gjp74Ws3aYVTvpXLEfHJwPjkaf0Y5E4GLhZwO5QrEgewHnv39u6/XO38s
 zkH/1cMLE17WdlU5vE7Qb4A5+Nbt7OtWQ9/Xr81wxrK9K+6ZNTCWHGlEKrDnnr0pR76zLhVVqNc
 EzRKrB9MhrdWZhESKmciwd4Z4us7mekLZ9Rw5av35FdDaLzuud5jhqqn9C9LGGGzXXufI2hx
X-Authority-Analysis: v=2.4 cv=LZ086ifi c=1 sm=1 tr=0 ts=68356389 cx=c_pps
 a=yXZ1+FovyrT58tjj2uJhTA==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=dt9VzEwgFbYA:10 a=-AAbraWEqlQA:10 a=RpNjiQI2AAAA:8 a=yMhMjlubAAAA:8
 a=M5GUcnROAAAA:8 a=8rWy6zfcAAAA:8 a=WtUc2Sty7jUJBGBoxR8A:9 a=QEXdDO2ut3YA:10
 a=OBjm3rFKGHvpk9ecZwUJ:22 a=YjdVzJdQTyZRADMV7wFX:22
X-Proofpoint-ORIG-GUID: _JZ4PoidrgynCyP5eh0RZzfwZGU4cQln
X-Proofpoint-GUID: jMV5N2XS95YnASpqzXM9egoWiMFQNRqJ
X-Proofpoint-Banner-Trigger: inbound
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html; charset="utf-8"
X-Proofpoint-Banner-Convert: 7bit mime entity
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-27_03,2025-05-26_02,2025-03-28_01
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

<!DOCTYPE html>
<!-- BaNnErBlUrFlE-BoDy-start -->
<!-- Preheader Text : BEGIN -->
<div style=3D"display:none !important;display:none;visibility:hidden;mso-hi=
de:all;font-size:1px;color:#ffffff;line-height:1px;height:0px;max-height:0p=
x;opacity:0;overflow:hidden;">
&gt; &gt; From: Andre Muezerie &lt;andremue@=E2=80=8Alinux.=E2=80=8Amicroso=
ft.=E2=80=8Acom&gt; &gt; &gt; Sent: Friday, April 4, 2025 7:=E2=80=8A18 AM =
&gt; &gt; To: Nithin Kumar Dabilpuram &lt;ndabilpuram@=E2=80=8Amarvell.=E2=
=80=8Acom&gt;; Kiran Kumar &gt; &gt; Kokkilagadda &lt;kirankumark@=E2=80=8A=
marvell.=E2=80=8Acom&gt;;</div>
<!-- Preheader Text : END -->

<!-- Email Banner : BEGIN -->
<div style=3D"display:none !important;display:none;visibility:hidden;mso-hi=
de:all;font-size:1px;color:#ffffff;line-height:1px;max-height:0px;opacity:0=
;overflow:hidden;">ZjQcmQRYFpfptBannerStart</div>

<!--[if ((ie)|(mso))]>
  <table border=3D"0" cellspacing=3D"0" cellpadding=3D"0" width=3D"100%" st=
yle=3D"padding: 16px 0px 16px 0px; direction: ltr" lang=3D"en"><tr><td>
    <table border=3D"0" cellspacing=3D"0" cellpadding=3D"0" style=3D"paddin=
g: 0px 10px 5px 6px; width: 100%; border-radius:4px; border-top:4px solid #=
8d8c8c;background-color:#D2D0D0;"><tr><td valign=3D"top">
      <table align=3D"left" border=3D"0" cellspacing=3D"0" cellpadding=3D"0=
" style=3D"padding: 4px 8px 4px 8px">
	<tr><td style=3D"color:#000000; font-family: 'Arial', sans-serif; font-wei=
ght:bold; font-size:14px; direction: ltr">
	  Prioritize security for external emails:
	</td></tr>
	<tr><td style=3D"color:#000000; font-weight:normal; font-family: 'Arial', =
sans-serif; font-size:12px; direction: ltr">
          Confirm sender and content safety before clicking links or openin=
g attachments
	</td></tr>

      </table>
      <![if ie]><br clear=3D"all"><![endif]>
      <table align=3D"right" border=3D"0" cellspacing=3D"0" cellpadding=3D"=
0" style=3D"padding: 4px 0px 4px 0px"><tr>
	<td style=3D"direction: ltr">&nbsp;&nbsp;<a target=3D"_blank" href=3D"http=
s://us-phishalarm-ewt.proofpoint.com/EWT/v1/CRVmXkqW!ui3Vmv9YrjX7-6H8Odxarv=
_Zw1JD81gcd-C6xsoBvnm16iV3ibKEP2Q4vEy15LzPWnnRTe94Bc_mN96d-C_OxV3PrHQi_iudG=
eLpHir4nVufYToka1AcbwiIF7PX2Loxm0TVmvM$" style=3D"mso-padding-alt: 7.5px; p=
adding: 7.5px; border-radius: 2px; border: 1.5px solid #666666; "><strong s=
tyle=3D"font-weight: normal; color: #000000; text-decoration: none; font-fa=
mily: 'Arial', sans-serif; font-size:14px; line-height: 40px; ">&nbsp;&nbsp=
;Report&nbsp;Suspicious&nbsp;&nbsp;</strong></a>&nbsp;&nbsp;&zwnj; </td>
      </tr></table>
    </td></tr></table>
  </td></tr></table>
<![endif]-->

<![if !((ie)|(mso))]>
  <div dir=3D"ltr" lang=3D"en" id=3D"pfptBanner0k8x9no" style=3D"all: rever=
t !important; display:block !important; text-align: left !important; margin=
:16px 0px 16px 0px !important; padding:8px 16px 8px 16px !important; border=
-radius: 4px !important; min-width: 200px !important; background-color: #D2=
D0D0 !important; background-color: #D2D0D0; border-top: 4px solid #8d8c8c !=
important; border-top: 4px solid #8d8c8c;">
    <div id=3D"pfptBanner0k8x9no" style=3D"all: unset !important; float:lef=
t !important; display:block !important; margin: 0px 0px 1px 0px !important;=
 max-width: 600px !important;">
      <div id=3D"pfptBanner0k8x9no" style=3D"all: unset !important; display=
:block !important; visibility: visible !important; background-color: #D2D0D=
0 !important; color:#000000 !important; color:#000000; font-family: 'Arial'=
, sans-serif !important; font-family: 'Arial', sans-serif; font-weight:bold=
 !important; font-weight:bold; font-size:14px !important; line-height:18px =
!important; line-height:18px">
	Prioritize security for external emails:
      </div>
      <div id=3D"pfptBanner0k8x9no" style=3D"all: unset !important; display=
:block !important; visibility: visible !important; background-color: #D2D0D=
0 !important; color:#000000 !important; color:#000000; font-weight:normal; =
font-family: 'Arial', sans-serif !important; font-family: 'Arial', sans-ser=
if; font-size:12px !important; line-height:18px !important; line-height:18p=
x; margin-top:2px !important;">
Confirm sender and content safety before clicking links or opening attachme=
nts
      </div>

    </div>
    <div id=3D"pfptBanner0k8x9no" style=3D"all: unset !important; float: ri=
ght !important; display: block !important; display: block; margin: 0px 0px =
0px 16px !important; text-align: right !important; width: fit-content !impo=
rtant;">
<a id=3D"pfptBanner0k8x9no" href=3D"https://us-phishalarm-ewt.proofpoint.co=
m/EWT/v1/CRVmXkqW!ui3Vmv9YrjX7-6H8Odxarv_Zw1JD81gcd-C6xsoBvnm16iV3ibKEP2Q4v=
Ey15LzPWnnRTe94Bc_mN96d-C_OxV3PrHQi_iudGeLpHir4nVufYToka1AcbwiIF7PX2Loxm0TV=
mvM$"
    style=3D"all: unset !important; display: inline-block !important; text-=
decoration: none">
    <div class=3D"pfptPrimaryButton0k8x9no" style=3D"display: inline-block =
!important; display: inline-block; visibility: visible !important; opacity:=
 1 !important; color: #000000 !important; color: #000000; font-family: 'Ari=
al', sans-serif !important; font-family: 'Arial', sans-serif; font-size: 14=
px !important; font-weight: normal !important; text-decoration: none !impor=
tant; border-radius: 2px !important; padding: 7.5px 16px !important; margin=
: 3px 0 3px 16px !important; white-space: nowrap !important; width: fit-con=
tent !important;
	border: 1px solid #666666">
	Report&nbsp;Suspicious
    </div>
</a>
    </div>
    <div style=3D"clear: both !important; display: block !important; visibi=
lity: hidden !important; line-height: 0 !important; font-size: 0.01px !impo=
rtant; height: 0px">&nbsp;</div>
  </div>
<![endif]>

<div style=3D"display:none !important;display:none;visibility:hidden;mso-hi=
de:all;font-size:1px;color:#ffffff;line-height:1px;max-height:0px;opacity:0=
;overflow:hidden;">ZjQcmQRYFpfptBannerEnd</div>
<!-- Email Banner : END -->

<!-- BaNnErBlUrFlE-BoDy-end -->
<html>
<head><!-- BaNnErBlUrFlE-HeAdEr-start -->
<style>
  #pfptBanner0k8x9no { all: revert !important; display: block !important;=20
    visibility: visible !important; opacity: 1 !important;=20
    background-color: #D2D0D0 !important;=20
    max-width: none !important; max-height: none !important }
  .pfptPrimaryButton0k8x9no:hover, .pfptPrimaryButton0k8x9no:focus {
    background-color: #afaeae !important; }
  .pfptPrimaryButton0k8x9no:active {
    background-color: #8d8c8c !important; }
</style>

<!-- BaNnErBlUrFlE-HeAdEr-end -->
</head><body><pre style=3D"font-family: sans-serif; font-size: 100%; white-=
space: pre-wrap; word-wrap: break-word">&gt; &gt; From: Andre Muezerie &lt;=
andremue@linux.microsoft.com&gt;
&gt; &gt; Sent: Friday, April 4, 2025 7:18 AM
&gt; &gt; To: Nithin Kumar Dabilpuram &lt;ndabilpuram@marvell.com&gt;; Kira=
n Kumar
&gt; &gt; Kokkilagadda &lt;kirankumark@marvell.com&gt;; Sunil Kumar Kori
&gt; &gt; &lt;skori@marvell.com&gt;; Satha Koteswara Rao Kottidi
&gt; &gt; &lt;skoteshwar@marvell.com&gt;; Harman Kalra &lt;hkalra@marvell.c=
om&gt;
&gt; &gt; Cc: dev@dpdk.org; Andre Muezerie &lt;andremue@linux.microsoft.com=
&gt;
&gt; &gt; Subject: [EXTERNAL] [PATCH] drivers: remove __rte_used from funct=
ions for
&gt; &gt; compatibility with MSVC
&gt; &gt;
&gt; &gt; With gcc, the macro __rte_used translates to __attribute__((used)=
). MSVC
&gt; has
&gt; &gt; something to the same effect, but harder to use and with some lim=
itations
&gt; (one
&gt; &gt; being that it cannot be used with "static"). Therefore, it makes =
sense to
&gt; avoid
&gt; &gt; __rte_used ZjQcmQRYFpfptBannerStart Prioritize security for exter=
nal
&gt; emails:
&gt; &gt; Confirm sender and content safety before clicking links or opening
&gt; attachments
&gt; &gt; &lt;https://us-phishalarm-
&gt; &lt;<a href=3D"https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__=
us-2Dphishalarm-
&gt;">https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__us-2Dphishalar=
m-
&gt;</a>2D&amp;d=3DDwQFAg&amp;c=3DnKjWec2b6R0mOyPaz7xtfQ&amp;r=3DE3SgYMjtKC=
MVsB-
&gt; fmvgGV3o-
&gt; g_fjLhk5Pupi9ijohpc&amp;m=3D1VjiJp6BZRZ004EEbRgDWdnwVSxocf7eebwvsLHsSba
&gt; GED02QuAMX--cepxiabet&amp;s=3DXp1219TuPNnfOJWQk6-Il7LikxCZOexBfkdSm-
&gt; kmbuI&amp;e=3D&gt;
&gt; &gt;
&gt; ewt.proofpoint.com/EWT/v1/CRVmXkqW!t83ZtR_UwpW61E99mn37ThGThaB
&gt; 6
&gt; &gt; gt7spCdfZvP9Yz5DLa-AKWhfbPLLmgyDnTM_FczAEE3KDso8-
&gt; &gt; QC5MEstA0f8Xb8gLd9dJN3BVWrFMpv9DT2-yl2l$&gt;
&gt; &gt; Report Suspicious
&gt; &gt;
&gt; &gt; ZjQcmQRYFpfptBannerEnd
&gt; &gt; With gcc, the macro __rte_used translates to __attribute__((used)=
).
&gt; &gt; MSVC has something to the same effect, but harder to use and with=
 some
&gt; &gt; limitations (one being that it cannot be used with "static"). The=
refore, it
&gt; makes
&gt; &gt; sense to avoid __rte_used in some cases.
&gt; &gt;
&gt; &gt; The functions modified in this patch don't really need to use __r=
te_used.
&gt; &gt; Instead, these functions can be involved in same ifdefs used in t=
he callers.
&gt; That
&gt; &gt; way, they are only defined when needed (when someone is actually =
calling
&gt; the
&gt; &gt; function). Doing so makes the code compatible with MSVC and avoids
&gt; compiler
&gt; &gt; warnings about functions being defined but not used.
&gt; &gt;
&gt; &gt; Signed-off-by: Andre Muezerie &lt;andremue@linux.microsoft.com&gt;
&gt; &gt; ---
&gt; &gt;  drivers/net/cnxk/cn10k_rx_select.c | 6 +++++-
&gt; &gt; drivers/net/cnxk/cn10k_tx_select.c | 6 ++++--
&gt; &gt; drivers/net/cnxk/cn20k_rx_select.c | 6 +++++-
&gt; &gt; drivers/net/cnxk/cn20k_tx_select.c | 6 ++++--
&gt; &gt; drivers/net/cnxk/cn9k_rx_select.c  | 6 ++++--
&gt; &gt; drivers/net/cnxk/cn9k_tx_select.c  | 6 ++++--
&gt; &gt;  6 files changed, 26 insertions(+), 10 deletions(-)
&gt; &gt;
&gt; &gt; diff --git a/drivers/net/cnxk/cn10k_rx_select.c
&gt; &gt; b/drivers/net/cnxk/cn10k_rx_select.c
&gt; &gt; index fe1f0dda73..658a434d75 100644
&gt; &gt; --- a/drivers/net/cnxk/cn10k_rx_select.c
&gt; &gt; +++ b/drivers/net/cnxk/cn10k_rx_select.c
&gt; &gt; @@ -5,7 +5,9 @@
&gt; &gt;  #include "cn10k_ethdev.h"
&gt; &gt;  #include "cn10k_rx.h"
&gt; &gt;
&gt; &gt; -static __rte_used void
&gt; &gt; +#if defined(RTE_ARCH_ARM64)
&gt; &gt; +#if !defined(CNXK_DIS_TMPLT_FUNC)
&gt;=20
&gt; Please change to #if defined(RTE_ARCH_ARM64) &amp;&amp;
&gt; !defined(CNXK_DIS_TMPLT_FUNC)

With the above change
Acked-by: Pavan Nikhilesh &lt;pbhagavatula@marvell.com&gt;
</pre></body></html>
