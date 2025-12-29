Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 160F6E8FDB1
	for <dpdk-dev@archiver.kernel.org>; Mon, 29 Dec 2025 09:12:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DE492402A0;
	Mon, 29 Dec 2025 10:12:04 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id 810ED40267
 for <dev@dpdk.org>; Mon, 29 Dec 2025 10:12:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1766999524; x=1798535524;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=tFASn0rUp1oXne5EkoEhawao+rsyMkBxgSOtMOJhTbw=;
 b=kYsQXgfFOMYswh3KiVW8SYrs8u5K8F64o6XeV00GfwY67hdBvvOO+20r
 i/dlNgxXUos0Jctcu+VZpwZz8CtztFG3CtHBnm5oHNRFi0LSjYxayfO3g
 QuwdsHxZyZHZTgNZvmEo6Wkz/VuRkxm5qqVgSRWLWlkjyQRjVDOmbzIiK
 +WFPsD4fl9j6Bao83z/iT0irz8pnDlyGsDDFlrl3QmiclxGcj1dNAfxeN
 I7Z8lccvVbio9ndt817HjvRRl0D2s2hdXRwR/9u0HaFtBYROH3Vjz0PI8
 InQzL0yOnheTVWSsP9VtlwXoSJfVvLZGLmWHk5NmO0ar0HDMPo1wYHvbO A==;
X-CSE-ConnectionGUID: u/0Tg+KRT/mEZuwhSbe1/w==
X-CSE-MsgGUID: fAtl4KOOSO28+obMd3idXQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11655"; a="68502247"
X-IronPort-AV: E=Sophos;i="6.21,185,1763452800"; d="scan'208";a="68502247"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Dec 2025 01:12:02 -0800
X-CSE-ConnectionGUID: TdxyqsAcSEW/r6g5RpWLzw==
X-CSE-MsgGUID: iC5nmMeHTcSKXjlyxlJxWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,185,1763452800"; d="scan'208";a="205358210"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Dec 2025 01:12:01 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 29 Dec 2025 01:12:00 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Mon, 29 Dec 2025 01:12:00 -0800
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.47)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 29 Dec 2025 01:12:00 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gNTcCLhp+L9x3+vJhuxoOF9JTmxPwhFe46buxxdpLQh/QVf5UiRyNdHJF/fvdojiPtNRjj/32BFiI/sUV2BnisusMyMUc29NkI52FwcsLaZYtcmjXl3X1Yrfog5a/VUIO7GmCVNx+bzdLRFhoZ6V3Cj5r8X4He4odVSL172RraAM3juEzmnfrsoTY6wdnGRLMTpyY0OLBu85p17Vl49mj6d80bQPgmK32RCjIcBKYhYS/Eqo8gUbMXXS8xZuMkrf/kEzvmghDahyvO5UYFmxusqvgVYY+DU0+Qt6WKR6zWvVQaE3Rr68BgUbL1qhpSQJoLQzwJRYgokmNwiuZp5D5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tFASn0rUp1oXne5EkoEhawao+rsyMkBxgSOtMOJhTbw=;
 b=Sw83/QghC8qZGDcK9AbG+xdl3Ysn0BCaUyE84MW/uV1AdR5YADVtHHJKhp1nFCqDm5T6SSItDP3r+WlqHn7imVPzbQc58pt37Tx9v5ox6oidje9/FgMdes9SWQxQ0lnkvWuI1C51Z5BDCDraOhhne1VnOMf/jr3LKWtAHcfeEOmsHHJLGPzTQzf17RRrnd1qeuKJEu5gAA3r8JCEzMJkKN/mqgML4fMTwtyn5EhA4W+EVrziU1wJ3U+b23CBIjSuX64R2vYtdbiBFcQHBLBGw7ZQIDLeVN1hxaqgfH2f8ldYPM4EExOTIzf/5jO72Sn4AmrUERsD8/pLXYUcxozJXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY5PR11MB6116.namprd11.prod.outlook.com (2603:10b6:930:2b::14)
 by DS7PR11MB5967.namprd11.prod.outlook.com (2603:10b6:8:72::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.14; Mon, 29 Dec
 2025 09:11:58 +0000
Received: from CY5PR11MB6116.namprd11.prod.outlook.com
 ([fe80::2b59:d9a6:8854:e9b9]) by CY5PR11MB6116.namprd11.prod.outlook.com
 ([fe80::2b59:d9a6:8854:e9b9%4]) with mapi id 15.20.9456.013; Mon, 29 Dec 2025
 09:11:58 +0000
From: "Mandal, Anurag" <anurag.mandal@intel.com>
To: "dev@dpdk.org" <dev@dpdk.org>
CC: "Mandal, Anurag" <anurag.mandal@intel.com>
Subject: RE: [PATCH v4] net/ice: add MAC anti-spoof option
Thread-Topic: [PATCH v4] net/ice: add MAC anti-spoof option
Thread-Index: AQHcb5GByUbVlFXghEOSfv1n7+cOHrU4ZusA
Date: Mon, 29 Dec 2025 09:11:58 +0000
Message-ID: <CY5PR11MB6116F0CE4CBA351629849C90E4BFA@CY5PR11MB6116.namprd11.prod.outlook.com>
References: <20251113105914.34949-1-anurag.mandal@intel.com>
 <20251217201143.155053-1-anurag.mandal@intel.com>
In-Reply-To: <20251217201143.155053-1-anurag.mandal@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR11MB6116:EE_|DS7PR11MB5967:EE_
x-ms-office365-filtering-correlation-id: e1817faa-5177-4f62-3df2-08de46ba520f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?lca0lKTxTb9Nbe+xRScui7ekqpYNpCUBxO5B8oNWrvwnU5V4Bnhw3Gw4DMkT?=
 =?us-ascii?Q?MmFHh9l6zOCSLJCyjC9qHeTUWmrlm9znygwwhac/codotf6fL5p039DfYGg0?=
 =?us-ascii?Q?9wEjQeSKsAEArJ5vzzy71anj6KdZLlEm/EP60kTtXBRIidC+rXFZRHCMwEJu?=
 =?us-ascii?Q?XJPplG9/GAKIu6llum1T8r0TI1ceTfJHeEE+Z2CBXg7M9qytXn47YGX5nqOv?=
 =?us-ascii?Q?8O5xsEk6FX53iegeXH1F/uEeb3hJYZDcSnS8MwzeSI6qmLlg1iUM49fUlRPk?=
 =?us-ascii?Q?Z8VQaWA4gc37BPkAZ/QgfDaeeiP32Y/P6ll19MvqIVDXilj8W3Gw/znRWNhg?=
 =?us-ascii?Q?7DF03xCZTrvk2KFeFfCC6Cy2SuRWbf9a0KiR+lCp8u5HKzBebfUcA1cEjuNH?=
 =?us-ascii?Q?Zus1dFtYqhqcYPih4L4d1UNHLgjss0DID39bwMiL2at8u8bflF8/DG2wQljK?=
 =?us-ascii?Q?Ox2QpR1UwCs/a4ZLrD8toAu/0BlI/fMSyrQTb7Sta2XU3c5IZ/WI26KDcBg0?=
 =?us-ascii?Q?T4D1jQIgUXmct2R2XUsNuWq5OY1QYa8pziW5c4iczXsGsnX8sg3nzLyrnowC?=
 =?us-ascii?Q?72gvsF1t5nrlY+m8Md+dEzfqHaRH0JjFo7ipKi21FTwiwGGEfcpX+exOkcz2?=
 =?us-ascii?Q?gcKe5197dQWaH7XObYTtJvWnsb0VbUA9iojEzkNHU2rD8ACItykKzYDSB1hM?=
 =?us-ascii?Q?BW34ghsRZN45Elc8v0z92zL2o8Y0Uq1QkDGUuz3YryBIhZ06ImSWUGsDrnOl?=
 =?us-ascii?Q?9i6vWEE28gNdVh0jKxE6j7k7hcAvG9ikVKNMXCJVN2OecmuGfDuXGZjET7Fs?=
 =?us-ascii?Q?SnjZtnui0/THcpVbwAgIo+jgMuwYimvbwnBS7CfgdWv7ZfC2As0CB/57WZL2?=
 =?us-ascii?Q?/EmrRN0d/V0OxwbmzCaCNnIRzeYZRqTxA84tB8JI6FQd9XkYSm2hNuPMuhsJ?=
 =?us-ascii?Q?H1w4sUkEdBGJHtJcTMFM5TbzzDx65xaHDeS0MeL2YTbZ4dT7fls8LCXMqWEO?=
 =?us-ascii?Q?QOU4MVYB5G7qeSKV+cLuYIt7pM8wZhb6aUri96d4D6u6mVvu+5JoxPQw9Zyv?=
 =?us-ascii?Q?/NN8XqBS1Iw89PEXFbgq+HTbNLTnky2864Yqvd8TiE+9EAMl0FfbzZIl1ynV?=
 =?us-ascii?Q?0i6BEYRevmCRobEuY4/ROVv9QGFpqDjXm+Sj8aKSmbRM2v6uxKFFHAbTFw7S?=
 =?us-ascii?Q?qfBeMLwfPgKGURQpVbjCFN82m62RFTNLyGN/f5J8XcnZErkg9JxeePpDM0Ii?=
 =?us-ascii?Q?S5TSyHN4rmP8CWaAIdhlku723d7vCDUdafsfeiH1kijU3jcsB3gr5Il15RG7?=
 =?us-ascii?Q?eAXFtLvI4PjWvbTIid3XM5lO3wy7hZLzLgAGEQvIVcspO12sOyRx97lb//tI?=
 =?us-ascii?Q?ODh0oRb13cQ6scGv80/kxjho3E699N+Cd5U22WsJXMatrwHNXraXvp9RpsTZ?=
 =?us-ascii?Q?I470vJqnX+EXBng8+esA3e6DV342YDBVOJHyabX5BT+g/mu+m7u8Vvzguvhn?=
 =?us-ascii?Q?QM2s3uezHk/3/nSqeMlce9iGv9YhDqIOXvsT?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR11MB6116.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?aRUNylnfMMtG/t4s/0uWWhgSPq+IxbjV2eWoHPoUj9F68O2wlLDQwwu9jwwO?=
 =?us-ascii?Q?8gtugyp3SdmCJOzwyp7O/KJ86gSyO69cw466sU9McVmyvq5DkmpfmKF8efSp?=
 =?us-ascii?Q?6Gkag3NxEmEu5tH3co3tX6izOnH759gFgL+vbKNf1eI03SEGOolcSxKmyQZW?=
 =?us-ascii?Q?0PnRwToqy+9+rT8jG/jqAkEtZ6e59GZsjgOSWNKLCpdHklAlTwnrdau/M1kn?=
 =?us-ascii?Q?qv8lXeqHo7XaOVrFSvxfdAC3pAUBdZd9bIEwUYcFRnw/w49IF80TSFMtXLCb?=
 =?us-ascii?Q?nN2OW+WbuQuT5Dlvocomr0JVuFddZ33kle/SIFfd1kYXP+i5XVWnZtO+lUzN?=
 =?us-ascii?Q?EnZCpqpRrINRSLjI4qPlUuewpD79fXWr99r8tCKBbIGcYX96d2HtOWyxS2MR?=
 =?us-ascii?Q?H2Dd+DDN6Q35wDpG8qpvs5Ucq6bslyUd2Z4zRjcTCvbhV2Lnr5gT/mBpYcqD?=
 =?us-ascii?Q?Hbkc1bSWfY700sCNK2Vuu/lkyvg2GZsDlF34XXZMKIaMKAs/6/7HNqvMv2ku?=
 =?us-ascii?Q?97wVqUekLRTh2lMA/HhVJlIiGDrzzqx4kkLqDJsj4mLvhI1UDQ7L9up0fOdL?=
 =?us-ascii?Q?8tngE+c70uiameoWkQVjTt/dogscOGoZBRiL4G55UdUHZJqolV3thjD+oalR?=
 =?us-ascii?Q?GAG85u2y8fTOnEWbOFhZ/eCi6PHYiRdGHc/D7yy9+YBy4wD0QXaxjCSdBTMx?=
 =?us-ascii?Q?anJRl+IXCIRWmGRF9CeAYCqXL7+7U5U4cMNrdffcY6XufgiqCwqqreY4ODln?=
 =?us-ascii?Q?ADrG+DxTTQt/esM2TixYTcNDWuPbNb6uXoZrRhHdaZsZwVJMcc02Wg53B6to?=
 =?us-ascii?Q?GboWlrPb/Ol2wdHI+3T+c8TIvUEZ6L/EKncO9jDBmgTmFBMseoeUMDTpNNGU?=
 =?us-ascii?Q?IYl3CgTPBuimNFATqfA2gRChObZwdRVeW37qOhCnhoQ0zVdExqekXYKWp6jn?=
 =?us-ascii?Q?dSJKlt+6J8iFH+WrPdMO4AAjqShV2W7ssBr7Qupzfn2WyeXvvUqoX4BmUDMf?=
 =?us-ascii?Q?FMg48BR3MXCOWQDAjNSkwVjrNjQ6cOGE2QTexc4E+w0W4zg8dkHG2RGi29QM?=
 =?us-ascii?Q?6G0Wk03Zoos+kLRJKuwIoGwFSdUMI0IktyPDrUx6gXSSqXOzhsi9++0evHKF?=
 =?us-ascii?Q?x5HABuiPsJlUAUPFvVNPjNCKCx45yVPW986R8tur0d7JrxRMazk7MVWtQQGn?=
 =?us-ascii?Q?y3HHyBCivebIbiU8JIDep70DHEuOtF9LE4S4vsst/Xywc6Z3m5HTHLiTEE/l?=
 =?us-ascii?Q?uEvWk1oKLAX6ZGFdUaISFcsf0fF9I2njuRh/SR63xWQqpPKX7z+GaGJa/SQ9?=
 =?us-ascii?Q?Uq4kuPVzozdCIy8Pfof6daaq5GZWEgtXRKi8bOmaEzG+OGYOYWhi3Z30nT48?=
 =?us-ascii?Q?CuNfQRhjiI+LHLQlg3EEfZff5xWWLgBsYMRpn//W7nOr5kbnRVeGW/jG/BVl?=
 =?us-ascii?Q?5jgzGT7MmCguZIlOOmz/vzyCxLalk+kF8uxN8/1B/yS1NmOjnYh4pUoxhaVg?=
 =?us-ascii?Q?rPwlhBSbd1W6wmPo2eCYNgz+cpM+0Hz3ogCJrneEZxaofYNiSc+r07xOEmxy?=
 =?us-ascii?Q?s+uxfd3NKJS93jQX4FRTpeOBKASMYt76Cxk8HGugrhtVD47SrOmy3JtJ2Ldp?=
 =?us-ascii?Q?QZG7DW/ckYtmIFiQpYhSlH1deHkSmcK8GsafuCVX7UOP+pHOxgCCACHvnMLb?=
 =?us-ascii?Q?loqz0MItF0AgGJMF71cRtVe0VFPLzQZy5ctYT8ihaKJ8SFb8Tx5tDl9v2Lm2?=
 =?us-ascii?Q?XBP0cGrFiQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6116.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1817faa-5177-4f62-3df2-08de46ba520f
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Dec 2025 09:11:58.7543 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CEqENNksriRiTiTbZdQVh1VdOwSFH1XNSQfNIcnPJ90IfRxQMaIR2IYiLIVJxLk58zbEkVEk2AAKjtlCiHMtIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB5967
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

Recheck-request: iol-intel-Functional
