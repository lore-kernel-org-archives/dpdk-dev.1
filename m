Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3CD1606A31E
	for <dpdk-dev@archiver.kernel.org>; Mon, 23 Nov 2026 09:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=dTY7WpdY;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=VfYtoCj2
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E92534027A;
	Mon, 23 Nov 2026 10:40:00 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by mails.dpdk.org (Postfix) with ESMTPS id AB04840262
 for <dev@dpdk.org>; Mon, 23 Nov 2026 10:39:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795426798; x=1826962798;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=5Ox2uPWQ07f56kOTobnhLLQ3qW15sWmW8m2i6Jn0uEM=;
 b=dTY7WpdYj0zmi1Bub3V49I1K1YgfiNuJHadPBb8j7xniva2DJnxXVwDY
 6Odw+GqRTxezCmgwijfgpWvuKYErHJEdaNkb2oJJ39UdfE7FbeFxJuJqg
 mrdEp+HSd4Y5Ut+dJGbkEF3M52Fuh20qswsD2Je7MT2iDD0zYq3NeMy5F
 VQuW8Lp9zILThP6VDiuzQfkB77PsFr/EpigDQhGvu3UZVcMvnOA2WmKkd
 JsxG5GbQmtiDFgYLppZGdB+yQkD6LkIEXcJo8DYq+SKyFrkA7Kq2Zb2ap
 X87we5D5qaxZT9jbvqDcfwlhEUy+54CS7K09WWZ+Ag2io/qrmo4TzWrFI w==;
X-CSE-ConnectionGUID: tybPxsdTT/C1ok6Vc9MTZQ==
X-CSE-MsgGUID: l7PK/AqRQF6WjNoMh6Gx3A==
X-IronPort-AV: E=McAfee;i="6800,10657,11974"; a="4075209"
X-IronPort-AV: E=Sophos;i="6.27,227,1787036400"; 
   d="scan'208";a="4075209"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Nov 2026 01:39:56 -0800
X-CSE-ConnectionGUID: i4ZtqhDSRfKxYtk9lzg/vw==
X-CSE-MsgGUID: 2GKnapOBR+CNBr5lRmF/UQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,227,1787036400"; d="scan'208";a="11590393"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Nov 2026 01:39:57 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Mon, 23 Nov 2026 01:39:56 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57 via Frontend Transport; Mon, 23 Nov 2026 01:39:56 -0800
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.10) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 23 Nov 2026 01:39:55 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Riwxg2GsCifeIr7Puyjbuk9lcSejT2mYEWPJIt4EwuEuwBp3Xmr7+ifsxy/mHfKWVOSCd3tWiuQ2LAZwy/GH0CkMUpV4pIRkfA+UrBhhk3pEruOk2kpyod6/3Y6WwyHcV8xY004R+HblVdWq9mkPFVqm+3yUbYOypl1SIAZciwZSbC4e1jXUfTtlU7zrVTgr9ro5BDiLLGa2JMgG/nfJSbvBs/yraqCBJi8qCE11G8l0g87TToq1sKZEO2DqVYP0ue4gSWy85I26jmsgiJMfXrtqzY+4sd0dlB97API1Q7wNUKi2BRC+mHEZWjvVb6FQVOiAC+7TvfCLf1LpJh7rbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Ox2uPWQ07f56kOTobnhLLQ3qW15sWmW8m2i6Jn0uEM=;
 b=DQQuev7A4Hngv0BF8BJvdY7Hcft/bW/gsZSG5CNWMH0KSsqEY81n0QwLRg1VLEX78zhvokhRDI2bZC/bZrFdjGDFLl43Ep7Zars9a+tmvUdPPNu2n/G0MU2azBUbVDk/05hwN7PRi9z78vekWi5fWP2pV3BYKT3XT0Kkbiwpe+o4s5mWXrdaWM8sPEmLb0ICqt+6y4US2DgQvdR3liCliDLhUTZ08mCQneh4I1NxlC/AXX2+z+yXHy5oAaQyJXVnRNMzdf8DaTNEWxSfrxOiLAvQil/vl9qhJxqHQWfbGhLxO5fw3yp7vBhghyS4qsXrlbJeXEwAkKPVmIPRgNOMIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Ox2uPWQ07f56kOTobnhLLQ3qW15sWmW8m2i6Jn0uEM=;
 b=VfYtoCj2+uBFshdcy7g8/H6iodjKvfi17Lsd0S+L2qp1q/v/iBcgKNEpDRdxaG/8MoUrCKxGKqL7gUxh/2lc4dc0mxHdL7KU9BNd2WZeWhD/JZx/W+5oFVoKA4FPziabuZQKP0Mu68os3gUte+cu9eNrLo9jcrGQckNdF9gtJJ4=
Received: from DM8PR11MB5653.namprd11.prod.outlook.com (2603:10b6:8:25::8) by
 PH0PR11MB5126.namprd11.prod.outlook.com (2603:10b6:510:3a::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.13; Mon, 23 Nov 2026 09:39:48 +0000
Received: from DM8PR11MB5653.namprd11.prod.outlook.com
 ([fe80::74e3:c0eb:29ee:fffa]) by DM8PR11MB5653.namprd11.prod.outlook.com
 ([fe80::74e3:c0eb:29ee:fffa%2]) with mapi id 15.21.0639.012; Mon, 23 Nov 2026
 09:39:48 +0000
From: "Nicolau, Radu" <radu.nicolau@intel.com>
To: Steve Rizor <srizor@qti.qualcomm.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: "Ji, Kai" <kai.ji@intel.com>
Subject: RE: [PATCH v6 2/4] crypto/ipsec_mb: add support for 256-NxA4/5/6
 algorithms
Thread-Topic: [PATCH v6 2/4] crypto/ipsec_mb: add support for 256-NxA4/5/6
 algorithms
Thread-Index: AQHdcQshDIV18bkfTU+7OiYeMT76fLc3XCGAgAQex6A=
Date: Mon, 23 Nov 2026 09:39:48 +0000
Message-ID: <DM8PR11MB5653E2BEB138549AA47E08F190452@DM8PR11MB5653.namprd11.prod.outlook.com>
References: <20261110120015.2937289-2-radu.nicolau@intel.com>
 <20261120184401.2954868-1-srizor@qti.qualcomm.com>
In-Reply-To: <20261120184401.2954868-1-srizor@qti.qualcomm.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5653:EE_|PH0PR11MB5126:EE_
x-ms-office365-filtering-correlation-id: 6d1c8b4d-a621-44b2-2822-08df4945b726
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|38070700021|10067099003|11063799006|4143699003|56012099006|261026140227099003|261028144727099003|261022105027099003|261022075727099003|261021135927099003|261021121427099003|261102123227099003|261009223027099003|18002099003|22082099003;
x-microsoft-antispam-message-info: OVcfD3UwT7hGyjOtzH8TeX9zCNBPA4GqWVBzbAlhTELUKEUDjNfsGEQz7j+Uh6kDQKHIXemqs9BcEa2GWw66+fpltEJCV8wOlc2pnDOmXPTfHtW7v6ieGCEG9Jx3XUUxyrf6JrnvD/IkIvFVblOpOQRrIXDMEO2QFFi+vlr1OEpJLchB6kCNo+DMzgb25G93F6PGPwaw94aoP1PnLg11W2OKJ3wMtGgFkmPvU4qJxBkJw58hT0Jz84usUN1VKcsNsqQuCtnqs8De20HumZu1uV5SYT3S76N0lPRZugb9eZKQ5mH8xv1LgbUZzUoo9vT3w0gPKgCurTrSyxzUwNkh+9b3FYHvA9egrZQV6X98lVidAePoGy/XZ91AtJTxTPuLxqUgghDWuob7P1oETgVRSmoPsMv/eBm9ZE4H5ME0vrtnvT7GpK/N2kawtVyFGrY7xuwQM+mpA3TITzy/h4UzSYHOFDT19FZyzQbb0huj+n2hZCfupcSdMPsIRot6CKVm+4lyEE9nHpxwKzoKxn08DP579SOihk/br+a2/iZdEHzV8sGhOWgZNBVVhC8Mx8IRprxp2M9/ojS7q+kzFT4mQNycfsSmi5nidqh8iHEpsj26NJUhgsTUZMKWQyB24Z/bRlXVBqDxGieNqDl9pTf2gGkmCQ/mAw+WOZfIbTsxBjZ512LzJfW0ciaXfX2Q6yJKbGZM1vPwZVJfScSIrmsaAhw/pE5tIiszDbPVn9SXxUY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR11MB5653.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(38070700021)(10067099003)(11063799006)(4143699003)(56012099006)(261026140227099003)(261028144727099003)(261022105027099003)(261022075727099003)(261021135927099003)(261021121427099003)(261102123227099003)(261009223027099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MGwyak96eGp4TjVodTNhRXExMDFISkJiSXBsLzlLeHdmOWZCdGh2Nk9vMjZl?=
 =?utf-8?B?WUxxamRhL1NxSU02azF4cU5LcSt1dmFpdUgzWitTOUNEWGxPU1MxSFJGNWF0?=
 =?utf-8?B?RUdRNSt0ZmlFa2lCUDRycVFIbGo3TmNXOWliRnlFOWZnSDQvSHpNcFZCQUNL?=
 =?utf-8?B?c0d4UWFLMjQzbU5iRVBYZ0REU0ZvZlFaT2VUSFNkYUpMcG9tR3RyZDJ2ZjlS?=
 =?utf-8?B?TndQTkpXNWlodFhYbzZpMHBCQlZSa1pvQ2xtWUhoTFQwM3VUd0JiOUJick9E?=
 =?utf-8?B?YlZLTlhHSzZENzNGcTl2RlVjNFQvS3YycW81WjI0TXNzVENXclB3d2EwTEZp?=
 =?utf-8?B?Nk5QODk3TWFKZHNYWlBSVlVCWDZ2YVppY3Vja2swS1J2VENSQ2pRMG4xTk5C?=
 =?utf-8?B?dmJZL1FmMG0rRmVjV2l5SXEyNk9IMk85OVd1Vm9yYVJ5N2VkS2R1cEFkNExM?=
 =?utf-8?B?RVlKL1ZiOEZqMk5Ud0Zsc3kzbVQwSXVSZ0VwWVRLd2NHVXEwaTE1STc2OXVJ?=
 =?utf-8?B?endQWERuOWdCd3o2dTFMMWNVVUFXQXEyTm9pYVVHTU1KYlcrOFRQOWhMWUc0?=
 =?utf-8?B?OENaSWdUUlYwZ0NjTjBNMW1hZzFXdXNmSUxWeWVlNkhoNTV4K3RPMzk5K0N5?=
 =?utf-8?B?aVN1TXRsZU9Rbzk5S3JyYTFqc05GODRkcUFFS1hwNE5NZFJNUW13UmtXYlo5?=
 =?utf-8?B?YlZQcThxcnJoeHU5T2JLcG5KZERydG1DeXB5U2Q5empxUkowVjMzVVZvOXpU?=
 =?utf-8?B?NG9pUGptTXpzeW5aU0dPZUF4U3R4YVRId3NWRXRlZitYYVd0WVhaaE9FYVNQ?=
 =?utf-8?B?QzkxNDkxaVEvZzAvNjRHamExNjNjYW0rbnFCN0VubUZBbDRYRzF1ZEsxYzkw?=
 =?utf-8?B?UzBVU01SNENoRUVFNngvMHVKNEdzamxBaE5EdXM5RXJTYWFzeDFVZEVoaWMr?=
 =?utf-8?B?SlNFSFRpZ0RMS0lBRlVrMURjZ3owbDk1TEZZbEZTcE5ZY25YQmxSQjR1TXJS?=
 =?utf-8?B?RVpyMlZVQ1FndHRvU3RuVFAxME9lQ2dWSUVBbmRySkxVbVE5SFd6T09qZ0NS?=
 =?utf-8?B?aEozUzlWM0l6Y2hWbGRmZmlaMW5KTWMreTdqM2p3aDRyajg1dTZlN3hodW5z?=
 =?utf-8?B?NWRtMUcza2c1Wml6WTdWd1VnZU0yMGd0Tnk4Y1VKT2JsZ01IejVaOUQ4MzdX?=
 =?utf-8?B?djlaZkhFa2ZDUnMyaFJEaHhNSUs0UlMvRWdRRThFRnpieU15QzhwZkR2L0s0?=
 =?utf-8?B?cEY3amJkTk54NHNCQnRRS2pFSXBlanpUZ0dsdS9jTVV2bCtSc2dLUEdKMmRa?=
 =?utf-8?B?ZTk0OWY1aGFXV0FURnNQQUxtZEwzNzZPKzE3WUdWZTQvVGtNMHRsUEJZSUJU?=
 =?utf-8?B?aFBUU0NvRkl4cVlPNU5PL1V5TStVb2d0cjRDM2VoeUdQNWlGMlp2SFFXVTZN?=
 =?utf-8?B?amhZNUtKUzh5SFpVVjVqUHJsNElEV0xoaTV6SFhGcnpZMVl2NERRZm8xQlJR?=
 =?utf-8?B?dEtVVVQ5SWlMUlhLaUowL091ZXJvcU1Hc0VFcHJ2am1FUWdwSHA3TzNBRyta?=
 =?utf-8?B?c2ZtaDJDbElWcDRnUXUxSlFYS0dIUDRvam9SblVOZHkzV2xDMzNacFVQdExM?=
 =?utf-8?B?Qit3ZW4yV21MeDN4ZHloMEdvYmJsRkY1MldmWlRqREwweGY4Q0orK2ovN2l6?=
 =?utf-8?B?cWJZQnM3SDlCT3owbk90M08zRUtSUVJQaXU0UWlybEMwVmdndG9OOUV6K1g0?=
 =?utf-8?B?bHJsVGRTUXBkbDlOam1Ga1g5bVJ3NVRIQXZMc0tWWTk5U1I4YmpkSTVVRm81?=
 =?utf-8?B?UzllNEV4S241NFBLS2VIekFVaHZCanpXS2sxenZxY0ZxUCtrTjdCQWdVR2JY?=
 =?utf-8?B?b3lObUNmNFBONEE4bU1JSDZZZktnSVYyb0p4dElhYm5jUEtiNlRCVXRRdXBB?=
 =?utf-8?B?d0lpVXBWWDVScS8zbTNSN29uWnE2Q2tZKytWYmpQNWhjaVJzUlBRSWpzN1JE?=
 =?utf-8?B?U04yWEFmL2o3R3djS1AwRU94ZUd2WUdlRHpJUHZiWHdpeTNmQWdVSExXSjlF?=
 =?utf-8?B?SWhGc3BBbXVGS1NrZWV5SFlVTmZDUXBMRDZiQi92SFQ4eHFmaUMreFhFNXhv?=
 =?utf-8?B?QVRwTi8xU1Eyd0lKK2IvNTdQUHI0b2RPbGhza21QakxNU213ekpja09MRCtp?=
 =?utf-8?B?Q1pEZEpjZUxuaUFKQWsyYk84YzgwRmhRMUY2d1ZKV3N2ZE9tWm5HYlpPdjJD?=
 =?utf-8?B?OSsvdk5vWU1KTUhrTko3MlIxWWNxcDlWYXhlelVQQUcxZzM2ZXJSdG42YzBO?=
 =?utf-8?B?ZFdOb3NYVlA3V0RQU093SmdKQ2FpVmppV0tkdjM4aWV1RGxpZkhRQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: eWvZYoeh0m0rekFiW/nRT3xSCsTRAPLHkKbZOtGSnOTzVN7SG82kDwt3UmLPI2bph2FpmNGSZ8X+81CjcC/Fc66eFEITAlcUGM2ptUHlTkD06obMwu/mrkI3GYuh15TifK1Xm0oQo2qz9icBql3WknSN0jpK7NP29yUqHpcHERezeoiiiWc0mcCx2LURyMaUpa1PfB2jEWMavS7QdjH1Lfj8FBAsB2/PwBnWO0f7/X9UagqN11aQlpDBKkrY3BwAG1oDeOOzProYhX3hrXEv1FK8mUt/4cLsVje/z+Kx/SagoXrKvcTTIyQ3i71lhCDTyVN1vZYxSt0SU2gKCwqQQg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5653.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d1c8b4d-a621-44b2-2822-08df4945b726
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2026 09:39:48.4159 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B++Aqgnzbt657eJhU/py2Tr7fW3zvtAylpb93rb/ljFWF4LPZV8ZZ4yHsA6JKmPOICZyZp/CmtTjOnWoDNpNug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5126
X-OriginatorOrg: intel.com
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

SGkgU3RldmUsIHRoYW5rcyBmb3IgZmxhZ2dpbmcgdGhpcywgSSB3aWxsIGZvbGxvdyB1cCB3aXRo
IGEgZml4IHNob3J0bHkuDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBTdGV2
ZSBSaXpvciA8c3Jpem9yQHF0aS5xdWFsY29tbS5jb20+IA0KU2VudDogRnJpZGF5LCAyMCBOb3Zl
bWJlciwgMjAyNiA2OjQ0IFBNDQpUbzogZGV2QGRwZGsub3JnDQpDYzogU3RldmUgUml6b3IgPHNy
aXpvckBxdGkucXVhbGNvbW0uY29tPjsgTmljb2xhdSwgUmFkdSA8cmFkdS5uaWNvbGF1QGludGVs
LmNvbT47IEppLCBLYWkgPGthaS5qaUBpbnRlbC5jb20+DQpTdWJqZWN0OiBSZTogW1BBVENIIHY2
IDIvNF0gY3J5cHRvL2lwc2VjX21iOiBhZGQgc3VwcG9ydCBmb3IgMjU2LU54QTQvNS82IGFsZ29y
aXRobXMNCg0KSGkgUmFkdSwgS2FpLA0KDQpJIGZvdW5kIHdoYXQgbG9va3MgbGlrZSBhIGRpZ2Vz
dCBwbGFjZW1lbnQgaXNzdWUgaW4gdGhlIEFFU05JIE1CIFBNRCB3aGVuIGNoYWluaW5nIE5JQTQv
NS82IGF1dGhlbnRpY2F0aW9uIHdpdGggTkVBNC81LzYgY2lwaGVyaW5nIGFuZCBlbmNyeXB0aW5n
IGFuIGFwcGVuZGVkIE1BQy1JLiBUaGUgc2FtZSBvbWlzc2lvbiBpcyBzdGlsbCBwcmVzZW50IGlu
IERQREsgbWFpbiBhdA0KYzM2YWEyZmZjZTc1ZDRmOTFhNGZlN2YwODJkYjc0OGUxZjg4NTRkMSAo
MjYuMTEtcmM0KS4NCg0KQWx0aG91Z2ggSVBzZWMgTUIgMyByZW1vdmVkIHN1cHBvcnQgZm9yIG5v
bi1ieXRlLWFsaWduZWQgaW5wdXQsIHRoZSBEUERLIGNpcGhlci9hdXRoIG9wZXJhdGlvbiBvZmZz
ZXRzIGFuZCBsZW5ndGhzIGZvciB0aGVzZSBhbGdvcml0aG1zIHJlbWFpbiBpbiBiaXRzLiBUaGUg
am9iIHNldHVwIGNvcnJlY3RseSBjb252ZXJ0cyB0aGVtIHRvIGJ5dGVzIGZvciBJUHNlYyBNQi4N
Ckhvd2V2ZXIsIGFlc25pX21iX2RpZ2VzdF9hcHBlbmRlZF9pbl9zcmMoKSBhbmQgdGhlIGNvcnJl
c3BvbmRpbmcNCnBvc3RfcHJvY2Vzc19tYl9qb2IoKSBwYXRoIG9taXQgTkVBNC81LzYgYW5kIE5J
QTQvNS82IGZyb20gdGhlaXIgYml0LXRvLWJ5dGUgY29udmVyc2lvbnMuDQoNClRoYW5rcywNClN0
ZXZlDQo=
