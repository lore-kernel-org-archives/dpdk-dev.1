Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70168F5A8D3
	for <dpdk-dev@archiver.kernel.org>; Tue, 21 Apr 2026 01:44:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 587BD40296;
	Tue, 21 Apr 2026 03:44:10 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id 2B08A4028D;
 Tue, 21 Apr 2026 03:44:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1776735849; x=1808271849;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=66zhCemHJx9flCb/gJjeYwVbfwm7r08OWlmMwxp9dAA=;
 b=UIZ7bzr7eBiFUqfO4HLxWNyYXDmYvl48PB5iew/5boEiS6YckgWmtySF
 mWFxNxIm+mBloL+7AxqY5/emxno3Ud9jOdUmf+ps7qr42ePOF2x8mrR8Y
 GZRboO0Uiw2aKXMBaVdX9C/V9x5/Py+7OzuRmn7R1j9ryygRW2RG47OwI
 iG7uv1tnV35FI0Rl+ySSU/SGUmYkWKYcXsh70OeC52gfEBJPnZ9WGRG7t
 o9TYCtzCfKct2Ckc4Kkdkn6qOULX0Xy06VmI6EPj31R1g9hMGe7gn2xU7
 ZTIu8UHBO4EUc6LjwjgzDbJg9UIApxRqCJ4oUWZ+03IpWJ7kZOPyPFbRM Q==;
X-CSE-ConnectionGUID: Bk8yTvXCT4+oYljmQs2esQ==
X-CSE-MsgGUID: e6jwR08CSrCKG90Vat4tBQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11762"; a="89131446"
X-IronPort-AV: E=Sophos;i="6.23,190,1770624000"; d="scan'208";a="89131446"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Apr 2026 18:44:08 -0700
X-CSE-ConnectionGUID: Be2tW+msR0CiF2UN3hqj8Q==
X-CSE-MsgGUID: cF7oev6ySgu+x8TMtnRavg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,190,1770624000"; d="scan'208";a="233656699"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Apr 2026 18:44:08 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 20 Apr 2026 18:44:07 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 20 Apr 2026 18:44:07 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.1) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 20 Apr 2026 18:44:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CFkNoN15sMd+pWyrjUOaz7CLre3qW7UKJPtuXiUk5wIlpvnZL84vB7+DRlBMnJMB29M2D20rg3v9AqjqCmAnm0JrcWwFmYg/sJLySE9MvdTAWLxxos7dJFJhe+45li84EP7dI7OuFdn29jIWMSc4wh9toTWjzzPIKzJm/loJ0ExVd5QLk1ltydHepWqjWTj1x8S93WP/M9b2/TjMBTKDBDCOOgCJXpVFewQNE5BWXKnBt9vsfORmaOemgNbcSuMBFVS1MMQhnJrMF/fjHh2ML8wRjuaP/YMOdHeBjg+qiNWHmz4wyhzpmDHimrz9bi3dSZuMHHEreoLiZQ51Og/f4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=66zhCemHJx9flCb/gJjeYwVbfwm7r08OWlmMwxp9dAA=;
 b=l3TabEPCyDkX9006Tbsn366kgwL3K9AsFpycU29tPjSjDkNoAMGwsrBZs93f2OhDBh0cF024+3vb+vgw4PqdR3N3WJPKgpbRmZNd8b5rKogkji5cc+HQXe4Vfeiv4iYM7ycF0ehdmga8cWUZb4FmSSY/7Mbn/Pt5VK7Ng4a9O2g33B4yOm+BB9ovNJOIs9dWkdS98G/zu9ZHY4bHj7kk8phAXEBIhnLJkD8P47hGD7LjnWTcrdgl5YDkaMWBBiUCznqqWXBorlCgzM5wDwRrtQbfahAXEagyX9rhZO5LQVNxQet7DwPvpQp1Y642IMHR7UKFSzf6Zsz+M3JtDl0OBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS4PPF00BBED10C.namprd11.prod.outlook.com (2603:10b6:f:fc02::5)
 by MW5PR11MB5860.namprd11.prod.outlook.com (2603:10b6:303:19f::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Tue, 21 Apr
 2026 01:44:03 +0000
Received: from DS4PPF00BBED10C.namprd11.prod.outlook.com
 ([fe80::e1ba:9b4:57d2:3cf6]) by DS4PPF00BBED10C.namprd11.prod.outlook.com
 ([fe80::e1ba:9b4:57d2:3cf6%5]) with mapi id 15.20.9846.016; Tue, 21 Apr 2026
 01:44:03 +0000
From: "Xu, HailinX" <hailinx.xu@intel.com>
To: Kevin Traynor <ktraynor@redhat.com>, "stable@dpdk.org" <stable@dpdk.org>
CC: "dev@dpdk.org" <dev@dpdk.org>, "Puttaswamy, Rajesh T"
 <rajesh.t.puttaswamy@intel.com>, "Hosamani, Manjunathgouda"
 <manjunathgouda.hosamani@intel.com>, Abhishek Marathe
 <Abhishek.Marathe@microsoft.com>, Ali Alnubani <alialnu@nvidia.com>,
 "benjamin.walker@intel.com" <benjamin.walker@intel.com>, David Christensen
 <drc@linux.vnet.ibm.com>, Hemant Agrawal <hemant.agrawal@nxp.com>, Ian Stokes
 <ian.stokes@intel.com>, Jerin Jacob <jerinj@marvell.com>, "Mcnamara, John"
 <john.mcnamara@intel.com>, Ju-Hyoung Lee <juhlee@microsoft.com>, "Luca
 Boccassi" <bluca@debian.org>, Pei Zhang <pezhang@redhat.com>,
 "qian.q.xu@intel.com" <qian.q.xu@intel.com>, Raslan Darawsheh
 <rasland@nvidia.com>, Thomas Monjalon <thomas@monjalon.net>, Yanghang Liu
 <yanghliu@redhat.com>, "yuan.peng@intel.com" <yuan.peng@intel.com>,
 "zhaoyan.chen@intel.com" <zhaoyan.chen@intel.com>, Shani Peretz
 <shperetz@nvidia.com>
Subject: RE: 25.11.1 patches review and test
Thread-Topic: 25.11.1 patches review and test
Thread-Index: AQHcwsAnpbMlLwy8DEWbEQdsdnqy37Xo2sNQ
Date: Tue, 21 Apr 2026 01:44:03 +0000
Message-ID: <DS4PPF00BBED10C3C2A50F6C7CFB30360539F2C2@DS4PPF00BBED10C.namprd11.prod.outlook.com>
References: <20260402164454.669125-1-ktraynor@redhat.com>
In-Reply-To: <20260402164454.669125-1-ktraynor@redhat.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS4PPF00BBED10C:EE_|MW5PR11MB5860:EE_
x-ms-office365-filtering-correlation-id: ce310243-464d-4fb6-882d-08de9f4777bf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|1800799024|22082099003|18002099003|56012099003|38070700021;
x-microsoft-antispam-message-info: 879Wjl7W4+E6/ximyVzX7xdSRxJ+hPOecNo6UTZ+STvmlOGWCV+FNOENubE5thO/ksGdJt1Q9+iD/YniI2sLntZ9HYQl+/7BVEPlJHNv5GItzxUk1dCCRBOlazH7Xn6B2l8FDoUnID7qAftcEXCag+ErsjDE56D1atzctbm/ignor1qu//HBLvlS7u9kHqzmzvdojR7eefvvKg4p7vWQyD6RiwIejid97lxGMdcbre3RnlktFab5tsy6vCTJ7Itz3Mf8zj/K9GBmmirMaMh8eZf/I9QPPAF99VeIB9LVdvZJ/ym5+X+dQsnQFKyrC1vf7LGvI3pvqGPFfg6tnqtmRLfK3BAoLWLJVg4d270SoDxvlduFMD8v5cPNyDnxJ8/kyY+i5qAFdJtMb4UXDEePISOspJL3TTN2onxr0YtZzqEh15rcJA4rLVBS8bfhdrzcpg1JFgs7sGJqIfZEeW4+2Alyn6/tebtjXvHS2fJHJ2SoPfbSu1MUUTGSOYpO86mrqNbJaJlkVwhRehgcEYe+afY7qVx2Hq7+SObFs2fPXdbLhc9w8NEe2N08LbNXQvKEuwyREorZBZPxDMuX7zfvfv7/kqMtkDpHrkMEhaNUAJ62+Uii4cubKh9rQCkvJeJ51SR+e4tQbpRl9szp3Bd4sBo2XDRoWShT8X4qkHpnrnZfFpat0RaAQ3Zq6bQw1cwR34K8sKBXWcW6DLwRxbmmMrW/QU2COEg44z2DhdUIrPFodGzyB3cYoqNEWcB6W/qCqTrJ8BneQB+Xcp/K0hHHdf/GJZvSMRqwmjpmHEXZqsP9x+kKYwqi5YI+eW2In+2c
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS4PPF00BBED10C.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024)(22082099003)(18002099003)(56012099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dE5zdEpLMXpNTnIrcmhsUVJ4clBWc3MycFkzMFNNR003OUltQW00cDFGaVFx?=
 =?utf-8?B?VEFYRWFPQlFCcjZsWjZreFZTT2hMcm1LNFZGald4dlc2Z1Nna3UzQ1hVQldo?=
 =?utf-8?B?alcxaWp1WE45RGtXbEpWaUxwbE05QUtveE8xRWFHdEswNi9PdWlrNXhZOStE?=
 =?utf-8?B?clMwQUIycCtUY1VzNTYzOXhzY2xOUmRrdHBnRHNON0t4QnoyYUFoQkhEbm51?=
 =?utf-8?B?TmdVNUVnL0lzTTdiOGcwWktZQ0RmRkQrMUtmUzB1KysxdVcrVEszWG5iVk13?=
 =?utf-8?B?ek13KzF3bHFRcjRrMTVvQW9ubzgrM1d6YWpnVEFiQURJbzhvL1U4S3Q3Q2Q0?=
 =?utf-8?B?TkprSlF5R0ZoWm04NVBLL0ltUlFMMDMwNUx4azFsMFA4TFYyaWJTSVdQN1Z6?=
 =?utf-8?B?cGdzbWJ4WkplZkZuMTloeDBNUlBteTFTVmZNZEh6WEF6Y2VWS0paamo0Sk1r?=
 =?utf-8?B?RDRDUjFONmV0RjM5aEsrUVhWbEc1SUlWRWVVMUw5Z3FIT1kweE9Ydk9tc2dq?=
 =?utf-8?B?WmY0TVoydmw5UVZEVjJWcXpyTDg3V1llQlRPdXhyV0ZrUFM4UHBoNThmUFg0?=
 =?utf-8?B?eXZQVjJLcUdUZkVMOWhmM1oxZThiQzh4VjRrV2tsQkErU28xMlZ2akpsdmtG?=
 =?utf-8?B?SWhqakNGQW9NTVdoWkw1S1Y0V1Q2SWZxVFlXQVpKMlRrTWU4NVh3c2xQamlY?=
 =?utf-8?B?K0k4T0lQOSs2MVpySWpVYWI2TEdlVjF0dlY5Zjg1NnF3V0VweGZ5L050VFF3?=
 =?utf-8?B?eWtWQ1BabjFRZ1VwTUJpRXE4MitvQkswMk5jS0tjWkxPMEN3dnZYSlFTWWk2?=
 =?utf-8?B?UzVtWSs4OURTOHoxZGlUWGFNT2VHa0JadkdiMHJOZzM2UmtTTzBNZUVtQS9q?=
 =?utf-8?B?M2wwRWhxY1NvVnpwOHlaejR2bDJkWW5RVklLZmlxV1VZQktrcGdiTkgvWGtr?=
 =?utf-8?B?djVadlQ3Y3Z0STFXZHB3MUwrTXBKaFpLeTJ4ZjBCRTRMNmJzam5zUldXbzRU?=
 =?utf-8?B?a1pOeTA0QlJNTVJkSytLK0xiejlZdXVRTkpKRHFDNmtCLzVGZTM3QnZtRDhU?=
 =?utf-8?B?NGNvL295S2pCaktISWVRa0NEaHVOUHNLMmVjZFRWLzNVbHJ6c2xPbWVTUWxG?=
 =?utf-8?B?TUhta3RPMXoremZJUzM0M1hvNEhmTmRyRnpnWnhtMVJrVmZ3Nys3L3pmcnhK?=
 =?utf-8?B?T0hPZlc1Y2U1NVhJQkVJaE9BM09saFRMRXpnblFHT2Fqc1gxRTN4NnYwU0JE?=
 =?utf-8?B?dkZKRDRCV3QzRjd3RXA5bktnTFN4cFVyY3FmejlDWUlCWTUxTkFXbXEwMTBW?=
 =?utf-8?B?MzZJYWt5eGdRaUdlMTJ1VjNHdWFqWWQ0ekpjMFRveGVCWTM2UklDWWlBYTBN?=
 =?utf-8?B?UytVcFNIMWlTYjAzUFBjT3FvSjZHUFM1NU5iYllvYk4weGNMa25jMUk1MHpv?=
 =?utf-8?B?K2NHWDFMamtDclZGc0ZPdWhkMHpJNnNpWTRIVG0xWEQycXVQVHAwaS9WakRy?=
 =?utf-8?B?cmhCYWZlUnQyUFRKaDdNZHVRSHhlV1VMVy9nREl4RHFoNE1mRDg2YldKYlVO?=
 =?utf-8?B?Snl0K3p4ekJETUFUbGZBSVcrOExNS3hjUTlaNzdMRnUxbzlrekUySlFOalNm?=
 =?utf-8?B?VCtCekNQOVlqQ3pMMFJ6TmZpS1N4U3BtV3dBRUZnVkdqcW00RDJqSjc2VUkr?=
 =?utf-8?B?eHE0SjhjNjdwWi9tT3dnbFgya3kyeDUvbGVIRmtySHA1b0I4ZzNhU2xuaUJE?=
 =?utf-8?B?bXNWTGVBeWkzbHIvRS9KaDJ4bnRjMzI0OEhOWHhIZ28xOHRsSlk2NU1FSjk0?=
 =?utf-8?B?M1Yza0JRZlJjZHg3L1N6OTd6YUJiVUJnZVlBTWJGcnVjQnJ0V21RendaTVBS?=
 =?utf-8?B?NHJ5Z2pKV285R0VBOFhsSVRVNUdINDNZUmkyN3g3Wit2blB4cEdBSTBpTlZj?=
 =?utf-8?B?ZXVlekUzT2hKaXQvdkl1OGhLSnZOZWZFV250UmVnL0ZwT0IrR1Bkc285STFE?=
 =?utf-8?B?dVVnRm9KQmNmZGtqaGd4YW5HVVJxNWtYTTJ1NjExOGhvTE9TWndScmxGQ0Rm?=
 =?utf-8?B?aEozRDdzRHRGa3ZFbHlTbWhGaUowNkRjdXA0MHdxKzlzVWh1U0NjR1VjYmtF?=
 =?utf-8?B?cDBmV0d2akJvOXA4cnNrOE5PMHo5WDB3ZlBCODZSRGJDUndpNTlXSmlNVjda?=
 =?utf-8?B?TStXanNNZjFnWklTUzFRZEwzN1FSY1VremtGbnRuZEIxZ2pNOWdYM0JTNHVL?=
 =?utf-8?B?L2ZZaUNwczhPY21NOS81MlFBajVLSkRxT2IwZGlsanpMU3N6OVN1Mmg3NG5z?=
 =?utf-8?B?SDBZM1Exd0VZWjMwbmJRazhweDlzVi9hZEhPa1VrR1RKZFRhckE1UT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: D8fnsbEkR/mR45IKlT1A/1QaPoC0aMDpoyjtsOKPaR3FwhXKDC6K2hM7muv+6ZbIRnu6yAZOrTRR98kdKrGosU99fqtTlOR9n9edeW+otSC5g89ADnGrgKusmOmhgYeHVvzse6OSzKcJ08vCQ5kDMMVhkGDGoLG2G3mkmCuwvWEn0CPyBfmvpft1miXzdO9qwUQ6Aa+WaY76+mdClbjbNLtBnjQvX1jTm/fXyEqRpAUiPMIA6VJASRB7/oWtfUozf8Fwi4IL1lhqMN6roCq9btpnfM5ZSSCAyr4vvdnEOu2tLTWKQrEkvcTbHxFtfkx40KjG66PDJJSNAoCCEwTQsQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF00BBED10C.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce310243-464d-4fb6-882d-08de9f4777bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2026 01:44:03.3576 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 83Mtu0GWGTNStapZEZaBw471HxoLeMyuCuphsmSCCpurWPENI2kmovThzVMSHz6pv6YabnxTjRvtx9wdU6UxIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5860
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

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEtldmluIFRyYXlub3IgPGt0
cmF5bm9yQHJlZGhhdC5jb20+DQo+IFNlbnQ6IEZyaWRheSwgQXByaWwgMywgMjAyNiAxMjo0NSBB
TQ0KPiBUbzogc3RhYmxlQGRwZGsub3JnDQo+IENjOiBkZXZAZHBkay5vcmc7IEFiaGlzaGVrIE1h
cmF0aGUgPEFiaGlzaGVrLk1hcmF0aGVAbWljcm9zb2Z0LmNvbT47DQo+IEFsaSBBbG51YmFuaSA8
YWxpYWxudUBudmlkaWEuY29tPjsgYmVuamFtaW4ud2Fsa2VyQGludGVsLmNvbTsgRGF2aWQNCj4g
Q2hyaXN0ZW5zZW4gPGRyY0BsaW51eC52bmV0LmlibS5jb20+OyBIZW1hbnQgQWdyYXdhbA0KPiA8
aGVtYW50LmFncmF3YWxAbnhwLmNvbT47IElhbiBTdG9rZXMgPGlhbi5zdG9rZXNAaW50ZWwuY29t
PjsgSmVyaW4gSmFjb2INCj4gPGplcmluakBtYXJ2ZWxsLmNvbT47IE1jbmFtYXJhLCBKb2huIDxq
b2huLm1jbmFtYXJhQGludGVsLmNvbT47IEp1LQ0KPiBIeW91bmcgTGVlIDxqdWhsZWVAbWljcm9z
b2Z0LmNvbT47IEtldmluIFRyYXlub3IgPGt0cmF5bm9yQHJlZGhhdC5jb20+Ow0KPiBMdWNhIEJv
Y2Nhc3NpIDxibHVjYUBkZWJpYW4ub3JnPjsgUGVpIFpoYW5nIDxwZXpoYW5nQHJlZGhhdC5jb20+
Ow0KPiBxaWFuLnEueHVAaW50ZWwuY29tOyBSYXNsYW4gRGFyYXdzaGVoIDxyYXNsYW5kQG52aWRp
YS5jb20+OyBUaG9tYXMNCj4gTW9uamFsb24gPHRob21hc0Btb25qYWxvbi5uZXQ+OyBZYW5naGFu
ZyBMaXUgPHlhbmdobGl1QHJlZGhhdC5jb20+Ow0KPiB5dWFuLnBlbmdAaW50ZWwuY29tOyB6aGFv
eWFuLmNoZW5AaW50ZWwuY29tOyBTaGFuaSBQZXJldHoNCj4gPHNocGVyZXR6QG52aWRpYS5jb20+
DQo+IFN1YmplY3Q6IDI1LjExLjEgcGF0Y2hlcyByZXZpZXcgYW5kIHRlc3QNCj4gDQo+IEhpIGFs
bCwNCj4gDQo+IEhlcmUgaXMgYSBsaXN0IG9mIHBhdGNoZXMgdGFyZ2V0ZWQgZm9yIHN0YWJsZSBy
ZWxlYXNlIDI1LjExLjEuDQo+IA0KPiBUaGUgcGxhbm5lZCBkYXRlIGZvciB0aGUgZmluYWwgcmVs
ZWFzZSBpcyAyMXN0IEFwcmlsIDIwMjYuDQo+IA0KPiBQbGVhc2UgaGVscCB3aXRoIHRlc3Rpbmcg
YW5kIHZhbGlkYXRpb24gb2YgeW91ciB1c2UgY2FzZXMgYW5kIHJlcG9ydCBhbnkNCj4gaXNzdWVz
L3Jlc3VsdHMgd2l0aCByZXBseS1hbGwgdG8gdGhpcyBtYWlsLiBGb3IgdGhlIGZpbmFsIHJlbGVh
c2UgdGhlIGZpeGVzIGFuZA0KPiByZXBvcnRlZCB2YWxpZGF0aW9ucyB3aWxsIGJlIGFkZGVkIHRv
IHRoZSByZWxlYXNlIG5vdGVzLg0KPiANCj4gQSByZWxlYXNlIGNhbmRpZGF0ZSB0YXJiYWxsIGNh
biBiZSBmb3VuZCBhdDoNCj4gDQo+ICAgICBodHRwczovL2RwZGsub3JnL2Jyb3dzZS9kcGRrLXN0
YWJsZS90YWcvP2lkPXYyNS4xMS4xLXJjMQ0KPiANCj4gVGhlc2UgcGF0Y2hlcyBhcmUgbG9jYXRl
ZCBhdCBicmFuY2ggMjUuMTEgb2YgZHBkay1zdGFibGUgcmVwbzoNCj4gICAgIGh0dHBzOi8vZHBk
ay5vcmcvYnJvd3NlL2RwZGstc3RhYmxlLw0KPiANCj4gVGhhbmtzLg0KPiANCj4gS2V2aW4NCj4g
DQo+IC0tLQ0KVXBkYXRlIHRoZSB0ZXN0IHN0YXR1cyBmb3IgSW50ZWwgcGFydC4gZHBkazI1LjEx
LjEtcmMxIGFsbCB2YWxpZGF0aW9uIHRlc3QgZG9uZS4gbm90IGZvdW5kIG5ldyBpc3N1ZXMuDQoN
CiogQnVpbGQgJiBDRkxBRyBjb21waWxlOiBjb3ZlciB0aGUgYnVpbGQgdGVzdCB3aXRoIGxhdGVz
dCBHQ0MvQ2xhbmcgdmVyc2lvbiBvbiB0aGUgZm9sbG93aW5nIE9TKGFsbCBwYXNzZWQpDQogIC0g
VWJ1bnR1MjUuMDQvVWJ1bnR1MjQuMDQuMw0KICAtIFJIRUwxMC9SSEVMOS42DQogIC0gRmVkb3Jh
NDMNCiAgLSBGcmVlQlNEMTUNCiAgLSBTVVNFMTYNCiAgLSBPcGVuQW5vbGlzOC4xMA0KICAtIE9w
ZW5FdWxlcjI0LjA0LVNQMg0KICAtIEF6dXJlTGludXgzLjANCg0KKiBGdW5jdGlvbiB0ZXN0czog
QWxsIHRlc3QgZG9uZSBhbmQgcGFzc2VkDQogIC0gaTQwRS0oWFhWNzEwLCBYNzIyKSBQRi9WRjog
dGVzdCBzY2VuYXJpb3MgaW5jbHVkaW5nIGJhc2ljL1JURV9GTE9XL1RTTy9KdW1ib2ZyYW1lL2No
ZWNrc3VtIG9mZmxvYWQvbWFjX2ZpbHRlci9WTEFOL1ZYTEFOL1JTUywgZXRjLiANCiAgLSBJWEdC
RS0oRTYxMCkgUEYvVkY6IHRlc3Qgc2NlbmFyaW9zIGluY2x1ZGluZyBiYXNpYy9SVEVfRkxPVy9U
U08vSnVtYm9mcmFtZS9jaGVja3N1bSBvZmZsb2FkL21hY19maWx0ZXIvVkxBTi9WWExBTi9SU1Ms
IGV0Yy4gDQogIC0gSUNFLShFODEwLCBFODMwLCBFMjEwMCkgUEYvVkY6IHRlc3Qgc2NlbmFyaW9z
IGluY2x1ZGluZyBiYXNpYy9Td2l0Y2gvUGFja2FnZSBNYW5hZ2VtZW50L0Zsb3cgRGlyZWN0b3Iv
QWR2YW5jZWQgVHgvQWR2YW5jZWQgUlNTL0FDTC9EQ0YvRmxleGlibGUgRGVzY3JpcHRvciwgZXRj
Lg0KICAtIElQc2VjOiB0ZXN0IHNjZW5hcmlvcyBpbmNsdWRpbmcgaXBzZWMvaXBzZWMtZ3cvaXBz
ZWMgbGlicmFyeSBiYXNpYyB0ZXN0IC0gUUFUJlNXL0ZJQiBsaWJyYXJ5LCBldGMuDQogIC0gVmly
dGlvOiBib3RoIGZ1bmN0aW9uIGFuZCBwZXJmb3JtYW5jZSB0ZXN0IGFyZSBjb3ZlcmVkLiBTdWNo
IGFzIFBWUC9WaXJ0aW9fbG9vcGJhY2svdmlydGlvLXVzZXIgbG9vcGJhY2svdmlydGlvLW5ldCBW
TTJWTSBwZXJmIHRlc3RpbmcvVk1BV0FSRSBFU1hJIDguMCwgZXRjLg0KICAtIENyeXB0b2Rldjog
dGVzdCBzY2VuYXJpb3MgaW5jbHVkaW5nIENyeXB0b2RldiBBUEkgdGVzdGluZy9Db21wcmVzc0Rl
diBJU0EtTC9RQVQvWkxJQiBQTUQgVGVzdGluZy9GSVBTLCBldGMuDQogIC0gRExCOiB0ZXN0IHNj
ZW5hcmlvcyBpbmNsdWRpbmcgRExCMi4wIGFuZCBETEIyLjUNCiAgLSBPdGhlcjogdGVzdCBzY2Vu
YXJpb3MgaW5jbHVkaW5nIEFGX1hEUCwgUG93ZXIsIENCRE1BLCBEU0ENCg0KKiBQZXJmb3JtYW5j
ZSB0ZXN0OiBBbGwgdGVzdCBkb25lIGFuZCBwYXNzZWQNCiAgLSBUaG91Z2hwdXQgUGVyZm9ybWFu
Y2UNCiAgLSBDcnlwdG9kZXYgTGF0ZW5jeQ0KICAtIFBGL1ZGIE5JQyBzaW5nbGUgY29yZQ0KICAt
IFhYVjcxMC9FODEwIE5JQyBQZXJmb3JtYW5jZQ0KDQoNClJlZ2FyZHMsDQpYdSwgSGFpbGluDQo=
