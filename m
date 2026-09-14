Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4DE1C88E73
	for <dpdk-dev@archiver.kernel.org>; Mon, 14 Sep 2026 14:34:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2494340A87;
	Mon, 14 Sep 2026 16:34:24 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTP id AAF99402F1
 for <dev@dpdk.org>; Mon, 14 Sep 2026 16:34:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789396463; x=1820932463;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=YUpp1bXfHDGrXUygFSQTIlg2n8OoCot+PvNlydvPPLw=;
 b=NfQOwpLcw9JAU4iC7ZN2gIlPYeAOXIKPGeknhLnHxC0FSkjZf/WWgv9q
 Up53bbBrivzQ/YWptUCrfm2nDXZIsLoPxArtd+cQdx+5zNbtBIxlV1s3J
 ZhIg4eEG8zjdcCFbYKyIm97SF144lELk48vN4ZyWSrLqyQkyNkliCdOx5
 45RiOmK/ggVRr6D1y6YN8wqJCMxlGUv4V8b5Azu+6pTg1GbPxGn4ocpvC
 WV/YJB1ks8fG04FncyrizKcFGviqiGS48fSF4N4G8drpBx+RoNukOdkWu
 vTmcNfpPqjAMtBFsk6DVqw7eKEBHAmGYbQKw9w1nqNPKpY8Qcam53JuNW Q==;
X-CSE-ConnectionGUID: w3LiggzWSNaR9CyYCuJvyA==
X-CSE-MsgGUID: 40r3O1uUS16v6Yeq3lglJg==
X-IronPort-AV: E=McAfee;i="6800,10657,11904"; a="92258174"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="92258174"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Sep 2026 07:34:22 -0700
X-CSE-ConnectionGUID: tfJNdPjPQZehOQdOvU8cGA==
X-CSE-MsgGUID: gYxprcllS/a53GZ9smBRyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="297670993"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Sep 2026 07:34:21 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 14 Sep 2026 07:34:21 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Mon, 14 Sep 2026 07:34:21 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.31) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 14 Sep 2026 07:34:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bDHT0BbDfjVOElRp3XNXMriSfXXWQL4lyL9hGN0mC0fxNmDu/RQRh3uADePODaOj62BZgWUKdURqw+pTE8PKuY3HGOdWGzNgT1saJwaEQ3tQfydtZIHtcdLGz7sxV1Z2Bs7PpLbtl3o3Dd06ccemZK1/6BbX4IirDlXmk7TWwK6APvq8k/m3z88GXvksOoKGVEAxFaLXAc2xpllPmnPXwuXNFAnyzXWtJlZWpcrGGHNEC0xwt1KYndtt+Fhjr3DYVV5BVGVvQGC+7Xsv8cWsOCX0f9hhxDwecBqPT3UJiJpKkyTq3aw8QN8bguLuiXuNuaQA5SBRlr+4+jPPvxCcFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YUpp1bXfHDGrXUygFSQTIlg2n8OoCot+PvNlydvPPLw=;
 b=DvtqI09onz7vKq3VvuWjNwT/NDxtpUelELopODw4jV6JnM0SkYw1vzOAfdILf3TpPXOoOF2Vf/Lp/kBHMUHnzittogSbkbvF9ZV9V2Tq03rJmwqzpXIY8ATXe42UXlHlrPD7oSK75/2XHkD9TiCAV8MOlEV1xAhXkJ4C6ZWMhEXS3eDcfokbvt4Ez0gJ6q616kkbX2+AGoP4HU4DUi2hCJ4yjHRKDn4xFlMsWuvUbwIEO4BygYMfMSAs42Bm8mTWT54rr6l2kFs+c0e5jYuCZpqe38JoVqyJnkp8AS2yGVE/9HDyqxeS7jfhGrpuR+vChlttU+h88A1E8fxMsdVskQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA4PR11MB9278.namprd11.prod.outlook.com (2603:10b6:208:563::12)
 by CYXPR11MB8709.namprd11.prod.outlook.com (2603:10b6:930:dd::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 14 Sep
 2026 14:34:19 +0000
Received: from IA4PR11MB9278.namprd11.prod.outlook.com
 ([fe80::9bef:c20f:571f:7057]) by IA4PR11MB9278.namprd11.prod.outlook.com
 ([fe80::9bef:c20f:571f:7057%6]) with mapi id 15.21.0406.007; Mon, 14 Sep 2026
 14:34:18 +0000
From: "Loftus, Ciara" <ciara.loftus@intel.com>
To: "Richardson, Bruce" <bruce.richardson@intel.com>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: "Richardson, Bruce" <bruce.richardson@intel.com>, "Medvedkin, Vladimir"
 <vladimir.medvedkin@intel.com>
Subject: RE: [PATCH 06/13] net/intel: move iavf descriptor writing functions
 to common
Thread-Topic: [PATCH 06/13] net/intel: move iavf descriptor writing functions
 to common
Thread-Index: AQHdQQa7HnGPr5T7G0aOIOLwYp5Ln7bOKjAw
Date: Mon, 14 Sep 2026 14:34:18 +0000
Message-ID: <IA4PR11MB9278EC6FC5EEFE5E3D650B168EBB2@IA4PR11MB9278.namprd11.prod.outlook.com>
References: <20260903170140.360477-1-bruce.richardson@intel.com>
 <20260903170140.360477-7-bruce.richardson@intel.com>
In-Reply-To: <20260903170140.360477-7-bruce.richardson@intel.com>
Accept-Language: en-IE, en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA4PR11MB9278:EE_|CYXPR11MB8709:EE_
x-ms-office365-filtering-correlation-id: 2342ef18-918c-4f45-3afa-08df126d426c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|38070700021|6133799003|56012099006|11063799006|4143699003|18002099003|22082099003|10067099003;
x-microsoft-antispam-message-info: R47lJztEfPeYJuL0a+MoVjxRfl6W8UlvsHu7n6EF1oDp5f4HZM3OaWwtnDRxjQiqPK68n0l/1LOS5gaBy5wZ3JmhiNNFgA83tfnlo6FjvY3+47g3C4VtYdlwRkCk6A1OuYunIlCzAcAA4caB0jBN44rHeOUWFAU4K/3aRC9TCOhZeAVgE9gkwBSZ2dlVIA1KRrF/q1EE22Qz0f6nM8aH+zuMMBUxr6c7nwgawqBa8r0erAFv8petBCnVfAfTg0u3WLm65uUkTyB9zEpyZmuk9CtlukvjNqQUTEgsDkSUTRtvdTeQq07aj0283Q4Uzm9o7a+zll6mcE8f1b46AwxA5gWUOijO05EDr9kLti1zxSt1DHmClsM6QLClcok+IAbdIIq67vzdFi3F5CnzI2TnzE8Xi0VPkzsXufs2NQK1GOwVTT/+xiQfSmHQWvY5/aiA2gTAmQOIbNodR7vv+YYzVFS3vbbmAE912omlhVy7B1aIQJD8gOkN+8Tu6swnyQ+IqAWI82DOiH+SwwaYxovIEO0LEIuIoCd4OkY1J23TZHuuZ1PSakBoLGi0xMdZ00ow9Uj9O0Z+WrX38FJ+ApzetXLB4x/Jxpif+/Ncpa3ffbqQ2wW5S2RX8i41dbkVpGSipaLVe/7EwbdQrOJoqewwGWGBDZmbEOZ9rvr31pOYjERz/lDbJBGRVca7SdqMbJd2h+ky9stCRv+8ikwHuUzrpY5WJLeqapR0zGCGiSBylvo=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA4PR11MB9278.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(38070700021)(6133799003)(56012099006)(11063799006)(4143699003)(18002099003)(22082099003)(10067099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aVFLdEl3M3YxcHlpcjZ1cXBsTE9TYjE3bTNYSjB5bndUdjZOOUdWUkV2OFIr?=
 =?utf-8?B?K0h4VnFwbDBhdThaUFBQRDRhM3ZYL2l5OHY3czlxcFRvWWhHYW9TakJGNnJp?=
 =?utf-8?B?WXh2QytOZ09IK1hHdlVscTZYM3I4dzVMZnpndTh6bkNmZVNFTHRiM0Q1dXM5?=
 =?utf-8?B?dGM5VUE0TmFQUFBYNkFIeFZRaWg0anl3OGhCZUxhYnMzSjMzMVhOeUY5TUlo?=
 =?utf-8?B?YmkrNCt4ZGlhcXEzSTRWb0FGVjBZOE5scUF0MFRuZitWVXEvY1N1MkRobHR6?=
 =?utf-8?B?bUs2SFoxYU5Bc2dETXJNVlBVWWVudTY3K2pSV1A2U0srMEg1UVZvQU9qT3E3?=
 =?utf-8?B?OUM1OUpTSzM3VXJCRHhiMkV3RjhhRjhPUEZJWEJBeVpTNnNQdHU1STJBL1o4?=
 =?utf-8?B?L04zSjFlUVVYVmhLa000MUJuOWxybmdKNzNWUG1xVjd2cHVUNHJMeXFONG1F?=
 =?utf-8?B?bWpqT0Rjd293TUtqb3BjMGM1OTBIaW1HaXNqV3E3VkpiNnU5aUdhdzVhWHNG?=
 =?utf-8?B?c2FMRURkOHNsd0xMaWxiRVI3YndxSEdOanRpdXNBUm9wQnhHb1ZQYkZSUmd3?=
 =?utf-8?B?SmJGME5zZ2xKaCs1M0srUHEzUXBDODBCeWlYejNNZjNTWXdKTy9ZMnZMeGNa?=
 =?utf-8?B?YldaWXVFL3lUSFJVMnlETDQ3dU4rdzcrcWNtSHBGam5HNEpUbVh5NWpQSmRa?=
 =?utf-8?B?Z05jSVFpQ3VhUjZEclQ0MElUVURtRVVVaUFNL1A0TG54M3d3dDlmUEprSkFv?=
 =?utf-8?B?YkFNaSt1RldrSGlzZndJVjlEWEFCUndIM24xRHFtZmsxM0VnTHEyZXprQ0Jv?=
 =?utf-8?B?V0s1MHdMK1kzNTgxbjRkZzFZUVhYRUc2bEJWeWtNYUE1aXJsbHY0NXphL1lJ?=
 =?utf-8?B?dS9CQW1kbUpRb2lvNjNabVE0VVl0bURGUjdIWnNDMkZ5UXJwQTJFd0ROZlZj?=
 =?utf-8?B?R1djYk54dDRscFR0d2NVTU1XelZ3TVZ3dEdIRUNqVXBkaDJXbFM2RTNqWmE4?=
 =?utf-8?B?VzFpNXNQdk9JeWpYVTRJS0x2V1hwa0lNYUFMRUpEZzMzb0QvUUJvUitpK21p?=
 =?utf-8?B?VGpiVURQblhlYm1kM21xWDN3MCsxdmVJNnUyUmlVREphQnZUWTFkbEFoMTBT?=
 =?utf-8?B?NjlmdTRVZmhiV3hYMHIzSjBGTXdTR2QyMHY3eU1HdDZrMjdmN1RtTFZQVVNG?=
 =?utf-8?B?c0FTaTByUDRhT2NTQ1I5TzIwNkpZRmJFTm4wVkVqRlV3cmMrR2pUa1RGL3ZW?=
 =?utf-8?B?Zk02YVh4VzRlNTRQaGg4MEtycSszc3IzWXZwZmlCV1RRN3hHMUFoSk5RWTRk?=
 =?utf-8?B?S0YxZFNQQkM2eUJZTjRYNXJ2L3Ftb2R3YW91RGRqbXNTcHBmKytTdTYxM1ho?=
 =?utf-8?B?TVZkUTBONVlsaVZHU2dBNFdpeEF1ZUxWS1ZTRHR2UDdWUUJ6SDh3bGR5VFJK?=
 =?utf-8?B?VmhxZXF5eFVsU3FJWnRtSENrV0lSczhnalRZcjNjTklrZk1CWC9qaityUmRv?=
 =?utf-8?B?NlliQUVkY0tXbldxS2JRZnNJdGg0ckcvRGZRN1VoVTIwcUJSNFdGbys1eUta?=
 =?utf-8?B?SGhUMTFtNVVZcWFSUjFSQklYd3lnQi92a0h3Vm1OVDVRdm9VRVgxUVVjbnV1?=
 =?utf-8?B?ZEFFNWNrVEJDRWlZWDVWVHBOWXU5YTkvNGxKWGgwcHRaL2hlZ0dkMVdtOG90?=
 =?utf-8?B?bW1TQzkyYWZ0dWw3akNWVEdvM2hFNkhqWGNPVTRMOEpTNnVTSmU1bG9yMm53?=
 =?utf-8?B?OUU5ZkJBL3c3Q1VzVEVRUWNOOFAwQjVCMzdKTTl3UWlHYzBRejZLLzJydUc3?=
 =?utf-8?B?RmYrMndQUkFaNnMwLzdGaEljUldaZjRkbkZ1bXVIc3lmUDdXeVFoSUF5aXUy?=
 =?utf-8?B?N0pJUTMvOUdFVkxnVytJdGNIY2NaVytOc2JiQk1MTWtkOUdEbjBOL2xBS29C?=
 =?utf-8?B?ZTcwbGlKdXNLTlA0TGRZM1VsdGtQTUd6WitOVUhsVVkrd2p0L08wS0wrUXVz?=
 =?utf-8?B?Mnl0OTl5QWhEVWRCVUQ2OVpwSjdsZ2RnOUEyM3FQK3lYdXhOc09nNmVYeXUz?=
 =?utf-8?B?ZXFoMU5mRWlhMHJHdkhIWVBSTDB6T1BWZDA4cXJxemkwS04yZjUzOWZVOVpF?=
 =?utf-8?B?eWFtdkFEajVNM0hrcEpWQkhuWm16RExCcHdBWGtiWEplMzQrV0g0blA1S29P?=
 =?utf-8?B?NkNvVFhZVS9rUGUzNGtlZDEvK202dzliS0NNOWZNRTcveS9DekY0ZHQwUEhy?=
 =?utf-8?B?azRTVEZCSU5WUmlsc2Y2UjVkOTVpU3A5WkkzWGZzU201K2hRZzlzVUluV3Ba?=
 =?utf-8?Q?OwzFY9sBy86/1/zfrG?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: ToqWrLPRpYbUmiUxbIB40M4pZIjUiylged/hYny/ZQUhFh7XSA4i1EleKB1ZERKJINdAe39Bl139cIqBt27AXAvtI29aNcgXsSuNkLNhWsbvCKbAqTrC5aooi4vPufBw6UbdLRp4gA506cKgvmpMIQOQAu6fNpvTDEygKYqG2Lr9z80x7+BwNPEPsp422oaqhR7eUzIrwhJrNuKd5YAi71TlyYxIOQV033rmsb+V06SA7jigGEXlM6+UCzn8adnPDuRsb8MiU3okQNmyvLeLidli6qCRT+ne/W5jTkq2RfLXb5cQXCxGvZlFnkacEQnpPcufNu00/T+99YLXtWq4gQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA4PR11MB9278.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2342ef18-918c-4f45-3afa-08df126d426c
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2026 14:34:18.4636 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QllY6zQm7iHinJAbgp7eYMxIvtvSrESDaA/ttOlvZ8TwjGf5Bv1SAXrJ3cDYVcF2iVrGlVLmIzJ7umOeCKqxUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR11MB8709
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

PiBTdWJqZWN0OiBbUEFUQ0ggMDYvMTNdIG5ldC9pbnRlbDogbW92ZSBpYXZmIGRlc2NyaXB0b3Ig
d3JpdGluZyBmdW5jdGlvbnMgdG8NCj4gY29tbW9uDQo+IA0KPiBJbiBvcmRlciB0byBwcm9tb3Rl
IHJldXNlIG9mIGNvZGUsIG1vdmUgdGhlIFR4IHZlY3RvciBmdW5jdGlvbnMgZm9yDQo+IHdyaXRp
bmcgZGVzY3JpcHRvcnMgZnJvbSB0aGUgaWF2ZiBkcml2ZXIgdG8gdGhlIGNvbW1vbiBmb2xkZXIg
aW4gYSBuZXcNCj4gdHhfdmVjX3g4Ni5oIGZpbGUuIFRoaXMgd2lsbCBhbGxvdyByZXVzZSBpbiBs
YXRlciBjb21taXRzIGJ5IG90aGVyDQo+IGRyaXZlcnMgc3VjaCBhcyBpY2UuDQo+IA0KPiBTaWdu
ZWQtb2ZmLWJ5OiBCcnVjZSBSaWNoYXJkc29uIDxicnVjZS5yaWNoYXJkc29uQGludGVsLmNvbT4N
Cg0KQWNrZWQtYnk6IENpYXJhIExvZnR1cyA8Y2lhcmEubG9mdHVzQGludGVsLmNvbT4NCg0KPiAt
LS0NCj4gIGRyaXZlcnMvbmV0L2ludGVsL2NvbW1vbi90eF92ZWNfeDg2LmggICAgICAgICB8IDUx
MyArKysrKysrKysrKysrKysrKysNCj4gIGRyaXZlcnMvbmV0L2ludGVsL2lhdmYvaWF2Zl9yeHR4
X3ZlY19hdngyLmMgICB8IDI4NSArLS0tLS0tLS0tDQo+ICBkcml2ZXJzL25ldC9pbnRlbC9pYXZm
L2lhdmZfcnh0eF92ZWNfYXZ4NTEyLmMgfCAyNzIgKy0tLS0tLS0tLQ0KPiAgZHJpdmVycy9uZXQv
aW50ZWwvaWF2Zi9pYXZmX3J4dHhfdmVjX2NvbW1vbi5oIHwgIDc3ICstLQ0KPiAgNCBmaWxlcyBj
aGFuZ2VkLCA1MzIgaW5zZXJ0aW9ucygrKSwgNjE1IGRlbGV0aW9ucygtKQ0KPiAgY3JlYXRlIG1v
ZGUgMTAwNjQ0IGRyaXZlcnMvbmV0L2ludGVsL2NvbW1vbi90eF92ZWNfeDg2LmgNCj4gDQoNCg==
