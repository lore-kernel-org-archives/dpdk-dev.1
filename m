Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2213DECD6D0
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Feb 2026 17:57:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 39D3E4026A;
	Wed, 11 Feb 2026 18:57:07 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mails.dpdk.org (Postfix) with ESMTP id 50439400D7
 for <dev@dpdk.org>; Wed, 11 Feb 2026 18:57:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770832626; x=1802368626;
 h=message-id:date:subject:to:references:from:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=bEHYz9ra/0OJSvdPHH4i0IwYNPdIQWViJs0XUZfJWQA=;
 b=fSIHoAY6HisUPNun+XG50wvvpZQ+fzQVxf8smPUJF0HXtWOF9ot9uwa5
 SAw/oWu1OYxOrHPYhjBIMnreZOLLzldTDC6yrm6IK+qI44JrrNBrxpS9Q
 Sdx453znqtknTy99pX5uUpjEdy3ZsXir2QNICpeExYtX+zTw6zfGmu2w8
 WOxGOY9M2JE4NBWNUPd53zMYhQImcMcGyPSrrteh8T3/GHRInY9Y4086y
 R6Dx5IoWvYRxcqGsJ4Wr8X40B8xDqEOGkQy6rEeyPYuuKeyoTykBjm5cW
 aJe3uf+c305oaSWRUAZ6ngBlj5TDC2bylxalED1nnegGffSmdg4PZcFjH w==;
X-CSE-ConnectionGUID: EiTxUG2wTfqGqazBj/sSSg==
X-CSE-MsgGUID: kN3rxRGyQxSuifA0c5i/gA==
X-IronPort-AV: E=McAfee;i="6800,10657,11698"; a="83090685"
X-IronPort-AV: E=Sophos;i="6.21,285,1763452800"; d="scan'208";a="83090685"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Feb 2026 09:57:05 -0800
X-CSE-ConnectionGUID: oJn/HneUSC+RSsTfC2YZhQ==
X-CSE-MsgGUID: 5I9tkFFCS9yrP9O4W7/Tgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,285,1763452800"; d="scan'208";a="211905142"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Feb 2026 09:57:04 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 11 Feb 2026 09:57:03 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Wed, 11 Feb 2026 09:57:03 -0800
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.33) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 11 Feb 2026 09:57:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AMP9NDqgVF/Yo4KCYjfwRZc8zB27/RyFkDbRbRifznmLGghgRG0aRBsR1Uj1tB3i3P+9JkEedllb8oVJ6Q7WXC0wLr3xCnTqClI44Lz0yEKRHSHFt+dtkR885NdglANSmPsgWmdasPr9G2wvSdqMNGtxdqT46D+hPFGH14sGK4lsqefW7sebFfip6ZFKvIBjeD0AhbOHFg4HZ8azT3CLY8pUgkvYGpg3Lz3YgNU0aeMsN9Y71Sh8UGW4AYmmljJx5CVg18fNtLS+hG14mSBMMADE5kx4lFdgcZ9a9+0wqIwJWDEwN5ynORU+WTEGmaccidVbHsKOW0QhqHThgLs23Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a+wElVVqtM/+2WcO2r9KOO1BBMvgGlv5EDNH9ocfagw=;
 b=s1/Od7c6uUzqCS/4Tk1leGfICX/HEfV5x8jtmFPHG91v2DGOQ8X8PuSgPlkWyKhnBUKM442VKpOvOZ4CY2n7bhYJ/WAxTJIHa3LQ1jR5XNOMRQDf1Uktmqle9NNTB+Q9ulZCv/vSE/A2vsv7Xpu4cTCIJZ3DFYMmbQ4jqqLk+czDHIDr7rMLEZV5DDxt0jXMT+qGDlXDRKlP3PqEQSdeOwmPE4AuAl2foSYWZOF7oJPrsJ40PnhVUyuDI9plFCXZwf+7hKsqM0X6xFIBE6GjsLcULyONeswyKvNMEB8t0ODK3cSoNvQ0R1ar3Y/LCGDF1M5eX3GbX5HCLvW7CqI98A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA4PR11MB9204.namprd11.prod.outlook.com (2603:10b6:208:56d::16)
 by SJ0PR11MB4990.namprd11.prod.outlook.com (2603:10b6:a03:2d8::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Wed, 11 Feb
 2026 17:57:01 +0000
Received: from IA4PR11MB9204.namprd11.prod.outlook.com
 ([fe80::8560:b65c:231a:64a2]) by IA4PR11MB9204.namprd11.prod.outlook.com
 ([fe80::8560:b65c:231a:64a2%5]) with mapi id 15.20.9564.010; Wed, 11 Feb 2026
 17:57:01 +0000
Message-ID: <0e346d16-ff51-4c23-9e3f-98065cd667f4@intel.com>
Date: Wed, 11 Feb 2026 17:56:58 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/27] net/ixgbe: remove security-related ifdefery
To: Anatoly Burakov <anatoly.burakov@intel.com>, <dev@dpdk.org>
References: <953ecb0032fcd0e5c57f519bd4a5b846756b4245.1770817884.git.anatoly.burakov@intel.com>
Content-Language: en-US
From: "Medvedkin, Vladimir" <vladimir.medvedkin@intel.com>
In-Reply-To: <953ecb0032fcd0e5c57f519bd4a5b846756b4245.1770817884.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU2PR04CA0158.eurprd04.prod.outlook.com
 (2603:10a6:10:2b0::13) To IA4PR11MB9204.namprd11.prod.outlook.com
 (2603:10b6:208:56d::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA4PR11MB9204:EE_|SJ0PR11MB4990:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c86bebb-85ff-4391-9fed-08de6996f52c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OGxYOG14UUFnNWtSd1lLcldyWHRKUUFFRDNVTnRNS2VsNFFHekhSekpELzdp?=
 =?utf-8?B?cEVST0NkTGtIcGRRTWNNQUczWmtrc3U3dzVYVFpoTXZselNWYUI5RyszY01F?=
 =?utf-8?B?UGQ0NFZTempNb3U1SlB3SGZqV1ZoUGRBZDJXWVFHZjBNS2ZwNUxESUhPUHlp?=
 =?utf-8?B?Wm11dmljclgyWURXRVRUUUFLTnloUHFlaCswZ3h6U2gyc3MxTDFUMWhUd2NP?=
 =?utf-8?B?L0RyNkc0VCtzeG1kajU3Zjc4ZGNZT3pHbFh5cE1pQXRjamZwSkoxZXcveEQz?=
 =?utf-8?B?Q0YvcDhIWUFlSzFVa1VXcklubThQbzIyWkFnNTdEejJJN1Q0SjQ3cklhTEVG?=
 =?utf-8?B?a3FlQVJaRUpxN1k0K0hmSjNpNCtXSmR2cHQ1dzMxeXhpUDJ5NU9DdXl6Vzhl?=
 =?utf-8?B?dkxRZG1yWHVxcnRpTDE2dWc4REdwTWdFVStJajUyOUFpSC8vYk00SDJ5VHFI?=
 =?utf-8?B?YXJ5ZlZ3ZkdVQUlGbnV5cHN2SEJUbFRuYyt6dW1nczdEcWp6dUE5ams4Szd4?=
 =?utf-8?B?UjB6TVUxMTl6dkIzS3dMTVhLTGlYNmJTb0lBT2JIREgrVUJ4TlpxV3hQRVcv?=
 =?utf-8?B?emVUbnMwaTlpYjZVVG9oOEpMbXQwZ2pwcXEzRjZGYVRuSHNMZmFDejcrWkFo?=
 =?utf-8?B?V0E4cE1tZm5xME0rU3R5dzNiV2p5eHJNWUMwMUJ3VFhrdHoyUkdjM01yQitD?=
 =?utf-8?B?RU8rZjlYVHpPVWVZbGdYQXZ0NnVCRXg0RG9hUGhPTXdaUDdsT1QvQVV4U2xo?=
 =?utf-8?B?cG84aTFBSnBTVVdQSjI4b2lUWVZWTDZOWEwyWkhiYWFIS0dnREtXbnRRV3FB?=
 =?utf-8?B?RjBwdDhNRjVIQ3hNdlloRG5lb3pMcm16enE1NkR6Nk5OR3RSTFRVekZxbGtD?=
 =?utf-8?B?d3BSTWVwT1FVS2Z2NjNrcVVJc0tHWitoV21idnEvSU1JbjQwdkc4YmtROVl3?=
 =?utf-8?B?K0Rhdmp0M3RqRHEyOXJLOXhNdm5SNlhlOEFkNC9xOGtvZWRzRmgvMmdzaEF4?=
 =?utf-8?B?YkpGY2RPZWV3VUNoMnU0emxDRDBjU29BYWkxMW5wVzQ4YndTRVZCdVc2djBF?=
 =?utf-8?B?YjlkZGFkaHVpQVZOZzcwckdvb0xPNldUMmpwV25lQ2ZXQTRLUEJKNVg1R3FO?=
 =?utf-8?B?TmUwNmlTSHdicHQ0WG9Ga1NEYWFSUVh5N2MvQ1JNald2S0RhQXdPeTlSR2Vw?=
 =?utf-8?B?VHM0NW9aNE9PbmxPWXlzNkg1RzJOVGc2WDgyTWl0c3NzaW9Ma1VZYmVGc2I4?=
 =?utf-8?B?UnkxdjNuQkkzdkVlMVdWaE5iSGFGd1piQ3FOS1l0NEFCTnhySmR3SGY5c3Fh?=
 =?utf-8?B?TlAxaVN2dlozazY2MFRlTlc0Ym5IZitCa1dZTzdRZzlTZ1JOd3h1WGJWeldF?=
 =?utf-8?B?OHlCTDgrYk9vL2pzRFc0eExqU2NNTjU3TENYK0c1bjFabVh6Z1lwTUdZS3Bw?=
 =?utf-8?B?QVVKc3F3akNnSkxjSmZ1MlVnSzZHa0MvekJFNUpMWVg1a3BkSFJRSmZQSHps?=
 =?utf-8?B?VnBoUmc5Nmp6UVBINW5Peis4c3dITHRZdDZlSE9qc0JaRUlLOFZpOWhUTEFQ?=
 =?utf-8?B?YUlteko1ZHlQVDFWY2VSNDhHcUt4MTd3d3ZXYXI3YjFDZTB3YlFlN1Vpd0J2?=
 =?utf-8?B?S3JqcW5JV0JBRjYzYmprN2l0WjJ0VEs2bHB6SHFpaFh4azJhcFEwV1dVUzgv?=
 =?utf-8?B?U2tUTnlMcy9md1B1eFp6YWJxb0ZFUnZBQXlubGh1V3FuZzRVNlZkb0pJZ2ZM?=
 =?utf-8?B?SkZMb0pkQmRucXoycFlxOCthTFNkT2hkQ3Z1UzVPdDd5THZsYTNBeHZkN1cv?=
 =?utf-8?B?M3Mza2s1STdkajZURUR6YlhlZWpMSkhCbmJHZWFCaGJwMzkycjZNYkNUd0tC?=
 =?utf-8?B?OWlndys0VUpOMmFhVGFlenpvcHNuOGJ4UzdnM2R3OWJSekJoMFNqYzNFdjdj?=
 =?utf-8?B?QVo3ZXVZMGFUYldMUVVza1A0cVN5MHgwTFhNVDhrV09IOHdDeitodE1tOEZK?=
 =?utf-8?B?R211azV1YmFOeHM2bzhpb2hCS05vL2svbnBYMkVvMjREelZsWktXQnlKaWpz?=
 =?utf-8?B?cHlSbUYzTitTUnZQTVIwbi92K0FKREYvWCsvT1Fqb2tMRHcrMnY0aVovVml1?=
 =?utf-8?Q?RJtI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA4PR11MB9204.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MjFnY3NSZU9XS280UEpiNGNDb3UzZzVjam8zaGJMMHhDNURxYTgyLzRkZ01X?=
 =?utf-8?B?bEt3MXE4Y0RabTFtTW16STdic0FPTGorQXVWWEJsRFJORW5PdjNFenhJWkQ1?=
 =?utf-8?B?WStLNEVFN2dtV21KVVB1R3FBOHJCaTB3RzNKdWVnNEpQbGpPN21BTDhJaDhz?=
 =?utf-8?B?dnIza0RxcE5UcVhscVZtZG9yMjNZM2Q4bU5BdWpXRE4xanNKRjgvVGpDQzFa?=
 =?utf-8?B?RHFQaWxaWXVJZnRoQlVrN05SV0ZEVkhYaitJdzdyQ01TSHQ4QWJ0K1A3dkxU?=
 =?utf-8?B?c3ZGb09LSUtZTEpMelhnUXd2bHRkNEtXek85U051QjRoanpZQlpUU093dnc2?=
 =?utf-8?B?amVyVTlaOUZvNlcrL1B2QWhBcW4yMUlvc3VZNDVRcVpva0w1cldaSHMrd0Js?=
 =?utf-8?B?RlJLeUtwM1pxKy9QY2tRVnNhVGlVV2FkMWtHZXRGak1wekxpOUNWdGRCdUYz?=
 =?utf-8?B?aTQvYjNLUDFuemtmL25BZTZYZDRRWkg4MUxHS1J2RStaQWN1K3k1eXhNZ2FE?=
 =?utf-8?B?RHY1aldrR0FZTGVNWW5zSlAwVEh5NmN3K2dDZ3BhbURDM2R2Vk56a2p4Nmpl?=
 =?utf-8?B?cEgzQzBzbVpMMHpxSnFrSlZaYUJwVE9BbGNzWTE0OU5oZkhxcDJxditIZXZ2?=
 =?utf-8?B?NTFzQm5ZcW8vYTUxOFV0VUljc2Frd0FObTJLUFNHbHFUa3lyWHE5VXZhZFFt?=
 =?utf-8?B?bmlTN21rWVRBTDZ4Y2dzV0tSNjB4WC9tc2JubHN5c2ZsVXRycXIyMngyVTd0?=
 =?utf-8?B?NVA0NDErcVNDd3ZFVTlXa2cza1FOZ2R1L0hZUWlQVEJnRHVBQ2E5QWlZU2p0?=
 =?utf-8?B?OGZPYXZRbUY2dmFMbnJmZzRnNmQxN3pDWWlYak5ua2FGalZaREorQ3lqaEdL?=
 =?utf-8?B?MFd4UGhadEVoa2R2RGpnK1F2SlJaZ3pwMFhTSmJ5c0dSOFlhVHlJclR5VjFL?=
 =?utf-8?B?TTFMRlZER05UaG4wdklIYUtGVGJBblNHbGZHTXNRMktER1hFL2NZQi9nQ0l6?=
 =?utf-8?B?a1M1L2ZENHpCLzBERlFLak9XUVAzSVFpajhiWjN5SjE0ZDROaWpIRTExOHM2?=
 =?utf-8?B?ZXpBZUwyQmQ5cFF3eXpreUIyZkpLWG9ibVdRUzVNOEEyQ3FNTTZ6MTJBUHBp?=
 =?utf-8?B?NHMvTDJvVnY2bnFFV3RRSGVEMUZyV2V2RUg1Z1dMRU84VDBxVWk2M0svY2tm?=
 =?utf-8?B?bGRRbzA4WTlJenRKREtWcGNscEl1ODlud2ZPaUVIb0FEcS9ROWg1RGpDdmJ2?=
 =?utf-8?B?MDQ1YVJLR2dVZGtqUy9Uc0cxWUtHZ2gzN3JCNDNyVXNkY3NyR05PNEEwaEZO?=
 =?utf-8?B?OWFNRDRBSFBrZzlkT0xwaVhUWTVpbFk3azZFaGxBUkE5N3lFeTlRZTJkMnVu?=
 =?utf-8?B?MzdoSVAwdTkwbWF2dnBSN3Z0RjNBMlFnRTNWV3pjb25ZV2VKMllhK1IvS3FZ?=
 =?utf-8?B?V3UyQ2lLeHlXMXU0M3ZPQUxwclRXdXVsTlRudWFwcnMzK2R4SWJPZWFUQjU2?=
 =?utf-8?B?dzQwNWR1Z2ZSS3BFaXZjUjBRZStiSGNyUERSZGxKaVJEb2FVUVpYdkNPYXNC?=
 =?utf-8?B?elppUUNwdUNoV2J5ZXZ6bkluazY1YitzQi94Zy9kdGIzcVZmNWsySld2NU1u?=
 =?utf-8?B?NDBKM1N6VW1RSmVFdFV4WmFneVp0M2N3ZXBLeW96YzVtUjB0ZWs3ZXBLQ0t2?=
 =?utf-8?B?ZTJIbmYvbDZJN0FUZFh2OW5VMDZDTU1yMGVkcG1ad085dDdDeEMvd29wczda?=
 =?utf-8?B?Mi9wdGtzZm12eDVPVWRXZ3RWY0crUFpkTjlvZHJGNFpnYXhndlNwQ2hSemg5?=
 =?utf-8?B?UElVd0RoNGxlYnZscEMydEoyeDN0ay9yanlVVVN3YkJRS1hHck91eXY4N2Uw?=
 =?utf-8?B?OE9HS1BTNG9UMzhNdHIvOCtnT3l1alBjTnJQemU3TW1GLzdOcE1XNHpqQ2o0?=
 =?utf-8?B?ZWJIa1VCYlZ5dktqRDJNMWduM3ZkMkpiNlY2RWFucExPc3NvQVFSZm9Sa3Nw?=
 =?utf-8?B?ZkJNTkpTR2lxR2t5dVVRMU1EdU1aaVNDUnVzL3EvVm9hMFpQaXdkdWlmL2ps?=
 =?utf-8?B?UE9XamtHTUFLeHdmZUFxYVR4aFVGOGE2M1NHVjBUTXllWFBhQjFRamlsdkVX?=
 =?utf-8?B?NEJITS9tL2xtZkhYN2VpSVQwQzBuOVlvNkNQTnZiZ0VObXdzVmRoNTN1M096?=
 =?utf-8?B?SGNjbDg2TG1xTVZKU1IwMnVZT1o2UDdGTERGODRQa2lUeGJYZ0lJeG1TR0Zo?=
 =?utf-8?B?UWZUcXhNUHplOUx5cU9RL3kzTUZCNjlxaERyMk1zSXlTWWozV0xCb2pkZkJp?=
 =?utf-8?B?Lzc4NVR3NEZYblkzM0dMbkZxaXlLWkpYaWdFYW4xN1RneWc4Z2NpSVZ1ZElH?=
 =?utf-8?Q?mmYE3c9fgIlvgYvs=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c86bebb-85ff-4391-9fed-08de6996f52c
X-MS-Exchange-CrossTenant-AuthSource: IA4PR11MB9204.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2026 17:57:01.4467 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /W5Dc3jpnOnbT9uoi5NliFKUzS4fdlcvFjZ3P8k82v30g/grZUKxZC0b//HLSWGq6R0CBy9ZL1U/IKW4urgApqPeAQKTi893WYUmAr1+JJU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4990
X-OriginatorOrg: intel.com
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

Acked-by: Vladimir Medvedkin <vladimir.medvedkin@intel.com>

On 2/11/2026 1:52 PM, Anatoly Burakov wrote:
> The security library is specified as explicit dependency for ixgbe, so
> there is no more need to gate features behind #ifdef blocks that depend
> on presence of this library.
>
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---
>   drivers/net/intel/ixgbe/ixgbe_ethdev.c       |  8 ------
>   drivers/net/intel/ixgbe/ixgbe_ethdev.h       |  4 ---
>   drivers/net/intel/ixgbe/ixgbe_flow.c         |  6 -----
>   drivers/net/intel/ixgbe/ixgbe_rxtx.c         | 26 --------------------
>   drivers/net/intel/ixgbe/ixgbe_rxtx.h         |  2 --
>   drivers/net/intel/ixgbe/ixgbe_rxtx_vec_sse.c |  6 -----
>   6 files changed, 52 deletions(-)
>
<snip>

-- 
Regards,
Vladimir

