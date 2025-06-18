Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B55D7C7115A
	for <dpdk-dev@archiver.kernel.org>; Wed, 18 Jun 2025 22:58:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 90D0B40264;
	Thu, 19 Jun 2025 00:58:28 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by mails.dpdk.org (Postfix) with ESMTP id 4BE894021F
 for <dev@dpdk.org>; Thu, 19 Jun 2025 00:58:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1750287506; x=1781823506;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=cgFxQ/DjrNbsMf0c0PVujyMtSf5xVbp4BzwwkDNZM8A=;
 b=LP+l+7iqaidAg++SUbFO+Iig2pAHjuBEuby96L0KvfP/F227B13DeD9g
 oPW/Q0dsyiRpLxEbujGZIQhiC09gGMwD4kedD1FfIbN02fEjlVQT7Yk2y
 uYoBaOYfg/I+kspJU5ECjZ6vC7rKJKvP51rNnbgk1BmkPCFkJNSdhu2eF
 R1KGwM6zdwN0YxqIltb/Dyk4F6ezrcEexgU0Y/UD/eAxFMrQGjgpDiHip
 9RImL/V1DXqPPaih7+SorwVszs46S0f/7tnGlbtfxECS/GLPcj8uS5haZ
 CcUkJLWWIdgqtBVnUh42ToL29eLK6ljFgB7+6iF2yUxx6/QpFrRbRxqsk g==;
X-CSE-ConnectionGUID: SS8/LxDrSB6jaxQlbYiOsg==
X-CSE-MsgGUID: /OnmbgjfRVuAkzuAyaNXug==
X-IronPort-AV: E=McAfee;i="6800,10657,11468"; a="52673104"
X-IronPort-AV: E=Sophos;i="6.16,247,1744095600"; d="scan'208";a="52673104"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jun 2025 15:58:25 -0700
X-CSE-ConnectionGUID: 4cXvJDGtRWW6J5KBuDJYIA==
X-CSE-MsgGUID: rJB09S9wQ+S56eysxlEmHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,247,1744095600"; d="scan'208";a="154188559"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jun 2025 15:58:24 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 18 Jun 2025 15:58:24 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 18 Jun 2025 15:58:24 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (40.107.92.45) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 18 Jun 2025 15:58:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=azFNcywMxTS1cL02BZWH99cZsrCV5KdTTFuU/AysPCyRNEcpWXoHk/becANVm6ELX0vO3opwGHHb4CaRXShBqSdPJT2cAYy3OaPk2TkX3reFERfbMpKXD+bBloeRkgcpx5D0zVK5RgBf2cDOFPGJmhFSAEKXLIJMMe+TOpCngCq4HMrItHRX6iQOYtmKYq8nv+zGunWxcGGdIhC44436+FsLNAQqHwvTaqrJdVnz9O65WfHeBN+HmBKtxT1SQoC64ivCgCQlrw2xFeqnYQQDtBhi8Gb8fzmOpDR/24F6tll7V2lm/X1ua/auZs+4tkiQnaiKn62gkuyncWBkH/7y4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cgFxQ/DjrNbsMf0c0PVujyMtSf5xVbp4BzwwkDNZM8A=;
 b=cS7l3JFjaPeloh1tz9t4yZjQM9JVu4t6Qf9Q98U8wXiLrZecahbN2pece+iJtK2Bs17oBlSugTd20mTNaCPfy4w5o5p9ztNcykME0TIM7mzHc8KLuPiIlj0yq6+jRJ9/jgcfFfTrSJy2P+lxJ+aQX04Vf0taS02LcYmhgdwZo2+HuyH0OHhvRDXqUBHTyYU2XfdyJUEIID0gKs8M7YCg0vqu1wOuLXYyln2G0fEvXBQvlacX4zHX3mGHswiKCInW4gJjlQ5D0RWqOOAkTq/1O1/KArA25LPcctKuNPY4NFlVXYTEwtic7R/NGaOj5NuusqKOV6O3YXoRN1okaECtvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM4PR11MB5472.namprd11.prod.outlook.com (2603:10b6:5:39e::9) by
 SA2PR11MB5131.namprd11.prod.outlook.com (2603:10b6:806:116::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8857.18; Wed, 18 Jun 2025 22:58:21 +0000
Received: from DM4PR11MB5472.namprd11.prod.outlook.com
 ([fe80::7412:385a:6704:3f30]) by DM4PR11MB5472.namprd11.prod.outlook.com
 ([fe80::7412:385a:6704:3f30%3]) with mapi id 15.20.8835.018; Wed, 18 Jun 2025
 22:58:21 +0000
From: "Pathak, Pravin" <pravin.pathak@intel.com>
To: Jerin Jacob <jerinjacobk@gmail.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "jerinj@marvell.com" <jerinj@marvell.com>, 
 "Chen, Mike Ximing" <mike.ximing.chen@intel.com>, "Richardson, Bruce"
 <bruce.richardson@intel.com>, "thomas@monjalon.net" <thomas@monjalon.net>,
 "Marchand, David" <david.marchand@redhat.com>, "nipun.gupta@amd.com"
 <nipun.gupta@amd.com>, "chenbox@nvidia.com" <chenbox@nvidia.com>, "Sarkar,
 Tirthendu" <tirthendu.sarkar@intel.com>
Subject: RE: [PATCH v3 4/7] event/dlb2: support managing history list resource
Thread-Topic: [PATCH v3 4/7] event/dlb2: support managing history list resource
Thread-Index: AQHb37VmfkpmPy+v5UOhrwb+1Fm8ybQIpqwAgADiPdA=
Date: Wed, 18 Jun 2025 22:58:20 +0000
Message-ID: <DM4PR11MB54725640D251A71DE79A366DF472A@DM4PR11MB5472.namprd11.prod.outlook.com>
References: <20250509042401.2634765-1-pravin.pathak@intel.com>
 <20250617182631.257612-1-pravin.pathak@intel.com>
 <20250617182631.257612-5-pravin.pathak@intel.com>
 <CALBAE1OOfvi-+2bnkWteS1TVYjjNT26asMCXCZ7rswOJTsCPrQ@mail.gmail.com>
In-Reply-To: <CALBAE1OOfvi-+2bnkWteS1TVYjjNT26asMCXCZ7rswOJTsCPrQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB5472:EE_|SA2PR11MB5131:EE_
x-ms-office365-filtering-correlation-id: 84bcf8dc-9d47-4e86-659b-08ddaebb9f44
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?aGprMDdKeDh4dWNXd3ZtMWVEUXBxeGF4c1BreWFvRzdYTlF2a2VBbWVsR093?=
 =?utf-8?B?TWFmN3pKWEpCdE5HMXdvOS9LWEZpYXFDY3h3azhRK2REa2lGa0NVN3pYSEF4?=
 =?utf-8?B?UUtEZDlFYmdrOEVRcDgrdTBqNHRhbkxwWHluRkxCS2NTRXJ4eFpDNlRqZE5F?=
 =?utf-8?B?bHpxTU5laFZ2dlJ1dFg2Y1RDa0tqVXJORmJsQ2QyZ0NFZWJYMHd5a1l0L1h0?=
 =?utf-8?B?WDVhMDh2cTQ2WTR3Y2Q4OUc4MUFibWtxSjA4SGFqbmkxdjkxVXBTQXVJeUhl?=
 =?utf-8?B?Mm9Xb3A1OEZ4S3pPRkhGL3hrQlJHZkczU0FmMXpQM0k3ajF5QTBNOU01dzhz?=
 =?utf-8?B?OHVKNldLd0tIbGZ1eTNKM09kOTh1Z00xWktYZGxlemo4UThkNW1rdW1aaS9w?=
 =?utf-8?B?T2hpUGljOXQ1UnM3akhic2prUXZNcHFnMk1semFvMElYWEpKaTZEY0lRMXJv?=
 =?utf-8?B?c3VEcnlpcEJTbitYbjFWODZQYzVwcUV6NGpBc1EyYzJMRVBQWUVCbzFBN3Fi?=
 =?utf-8?B?ZG1nRHhnNVUwakFpOVloWmlVSDFwSTBQdWltSWZuUTZLQTloa0pUd3REOUU1?=
 =?utf-8?B?UG52TURxY05MeHdFT3IrTi9IWDlPL0tKWFNXdEFXZHlPTEFRdzhVZFVLQWMr?=
 =?utf-8?B?c2dZTFFWSHhvdnZiMWlpZjliVzhuaUxUVFNLbEZ5SkF3Z2NjM2tnS0dWek94?=
 =?utf-8?B?NytsNEhVdDFVSFJlUGFQc0VjcFhpajFKTHozdUhZSFlua25ndmQ0TkZXRksx?=
 =?utf-8?B?YllncVFvSEl6RVpKejEwZnB2THhlSWxrTzZ3U2JPY09BdXFnWHN4YzNFdzBC?=
 =?utf-8?B?ejBqTWgrTVM0bmROa2NZU3htQnY4aGdTbEl0elZDYVJRbGtzUG1vbVhBKzZa?=
 =?utf-8?B?YXhlN3Z5U0Y4VVNnY1dCaDZFcGlqejFXWm9tM2F5OXFVQUUxY1J2bUI5WFYr?=
 =?utf-8?B?cFB6Z1hSOHNLalNCcXlJdWp5RW5ScE8yd1lpeERyL3ozUVlkWGRTbUtsd1dU?=
 =?utf-8?B?VjVwSmZORkx4Zk1GczIrNUVoTjFwQWUvcTRFck8yZTNmUTMzTE0zUHJuUWVF?=
 =?utf-8?B?UnU4VlVSbnM3c0VyUXZxTzlCNzZsZ3plZW9yWVJvODdGS3dEbm51ZjIwZXM1?=
 =?utf-8?B?azcySE1jbGhieTIvYlM3SjM1YW5vK1VYZG5XS3pxdHJ1czJBZmMzbWZUZ2VS?=
 =?utf-8?B?MW1SWDNycVAyc1JnQy9HSWRyOEtQSGFBMTBKSjNmWkdWNzNNR1JtaHMwaHY4?=
 =?utf-8?B?TWIvTnJEZUsyYXJEb2R6R0tlaEkxZTloY2ptVlEwRTViT3l5TkpCR1VnN1lq?=
 =?utf-8?B?QlpScW9mMUxid1lqTnM2RTAvZElJWnpvMlEyenYrRkszYmpjbG9qODQzWFkz?=
 =?utf-8?B?OThPVnpIMDR3SnBjNTRWbHNzQlo5TkczMjhYUUFUZ3VoS3pqRDJTRjZzakt4?=
 =?utf-8?B?K1BKM2ZHcUVGVGwzVytGamVscitHZHBQeFRvbXMycHIwZHpPbEdBSlVkUDV3?=
 =?utf-8?B?elVYUTBNeEtHUzUzYXNJVUIyU1FxV3pQcXQ2OUhKT3BTQ0ZaQ3VKZ2dlL0Zn?=
 =?utf-8?B?WnBySVR5L1BsNHdqOU1iQ3N5bWVkZHlPcmtlQ2plNWtNMTJrZFpDenVDK0RJ?=
 =?utf-8?B?Q25jTjV5dW1sbXJKL3AzWmwzakxQWjdRUjVFalZlb2VXZnNRYW50TE5aQkxJ?=
 =?utf-8?B?SlR5djRlWTROeWF0bWMzNmc3MC9BNWRibWc5dm45YUlnSXQ1SWxRY0o2d09W?=
 =?utf-8?B?ZTdyaTN5YXBaRmZDS1N4NGREWWZCVWFyZjVBK1hKMFFsL3hDdnhnVEhMaVhr?=
 =?utf-8?B?MTZrNlhhbW1QNWJNOTVQVGp6WFZmOE1Qd2xQb3FaOWdGV2oyVkQxQmxiTC9x?=
 =?utf-8?B?ZWhtZ0FVREppRFJFS2lObDRkK2tJRjVuU1kzYTNlRSsvampVNFRpRVZkd2dD?=
 =?utf-8?B?QnR0YUttcVBoaGdtdFlFc2RveVAxb1MwdW5nRFFRaG1JMEtQNGJ3UHJIQ04y?=
 =?utf-8?B?WHkybmp3T3BnPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB5472.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dVhISnVUSkNpdXBmMFF2TUNPL3YyOHAyaldwL2tCbG14VHFzNmdYOHRtcmRR?=
 =?utf-8?B?b0ZheExobUliL3JqL0RCcGJxYU02dTRUM3Y5MUxaMGZIV2trQWpRUE42YUN6?=
 =?utf-8?B?Q3JwVnRiS1BiUGdoeVo2TWo0WmZGcHRtSndaQkg0SVdLZjNEYkpuckE0Sm1R?=
 =?utf-8?B?ZkNsV1hoWXlsa0U5L3Y3Q1JHWFVrM3VzNEFVcW1BUlIwS0xSK2V4RUxQWjdo?=
 =?utf-8?B?N1ZFUlR2eDF0ajhGT0hmTC9uLytIUm5ybW5VaDdQekJFS3BqVi9wVVFpNStS?=
 =?utf-8?B?UTROYkRTMy9rdWtBWHZvbmRLbW5NRWhWdVI1UmZBaDkvYmp4Qnh5bUltUmY3?=
 =?utf-8?B?a09UWmgwMm8vY0R1Tk9SWHdlNmppUXBjclpvWUcyMzVrcmFEU2Q2QjhLblF5?=
 =?utf-8?B?cUhCd2twU3dHTHVVTW90RVR1UHFDdkR0dXluR0xKbklJeG1DcmtncUpLeFFt?=
 =?utf-8?B?ZndQRERiR3EvV3RIYUhjUlB6c3k3cnJQVGdKYTduRWJ2V0xaSmtzcGtUUTUy?=
 =?utf-8?B?Uk5HVlJxbGdmWnJpLzg0enBpV1BTbExQeCtVZXJGQWEzWEVxWU50MUYzUy9D?=
 =?utf-8?B?Y3VvMUJpcFQ2NDhUYlgxZ0JZaFdBcmxJYUpkaXc0NXRlTTFqTnRJVXUzbE5J?=
 =?utf-8?B?Z3pTMTdxUkx5U2ZNRHNLR0pxRHhFZTBYMW1nWnY1ZFcvU2hGUnhFUzUrYTlC?=
 =?utf-8?B?NDhPbU1ndXZ0WCt1bmhZN3RzWlo1TlZKZGZrOXcweTlnZFdiNGxGam1TdkZ3?=
 =?utf-8?B?b1M0NFN2QXNXRHVmWVVub1Y2ZW9WYitUZHplV3BINCtPbUh5d3MyZnJneG9N?=
 =?utf-8?B?Vm15MEhEektDNnZGa2dCMS9adXhYclM1Nm5PQlhnWW94Q0VJb05XU0Q1anlx?=
 =?utf-8?B?ckc3bTk4cnNUTzRnN3JWa2lvQWJIcSt2WGxPd3ZKNTNHbGo4ZWZ2STZIdjlS?=
 =?utf-8?B?bWFPdEpuZDhQOGkvVkVnWXFudUZKTWNDcHBndE5NL3dHWUMwL0J0VWRValNH?=
 =?utf-8?B?YUZlVmV0SkxkWGJjUk1QTUZqeXJNVmQrSys0MFZOVlBNczAzMC9XUE5GRG40?=
 =?utf-8?B?WC9jR1N2WXRRbmxsaFBaamhZQXJ3MVNzQVpDTkppcmxIOGZwM1A0eHJoRDF6?=
 =?utf-8?B?anFsbldZczhaVkRMSEo5dmZpWUc3OVVsZEZ1RzNPQjBYdzA4WUhvTndwRFBi?=
 =?utf-8?B?QS8zL09qeWh4SW9SMzF3cDFWY0JLUUFoSXlKYWprY1NldlNDdjR3Z1dLZHFr?=
 =?utf-8?B?QlRUQW5uODRJRnhsSjY1QVJHdktzUkR0WGNjN0JjSVlXTFV6WmJHYWUycThN?=
 =?utf-8?B?bnN5a1JrakxWR0VKK0x5ekNtUHlBRVlQdmJKc3EzRHdkMFV0UGMyMmZZU0Ni?=
 =?utf-8?B?RkVQRmRRRnRUM3R5K0QzUjFoeE5TRHk0ckVyc3JqMFVSc3RUZU81ZTZNWHZE?=
 =?utf-8?B?V3J0NkwvRzVzUnQxZmZxZUhqSnhLaE5PTElmbUxMOGlkR3llU0ExMzROcCsw?=
 =?utf-8?B?U2t1RnVMek45K1NRNzdWQWRLMmdWaTA2R1NiMjFjbldKRHZZczF3Q1hnSFdH?=
 =?utf-8?B?Smx2enl4bG1PUm9PMU1RSzRqNjdyb2RWaHd2N2pLQTN1ZTN1QkU4c0dFaFNH?=
 =?utf-8?B?L2ZIRDAxY0RSZjBQWFFLNGpxTHp5cjAvQjhXRW9Scy9yeHNHeGZuY282bjVJ?=
 =?utf-8?B?azdUMzVNcHlVTTFzams3TGZ1Q3FhNDVvZCt1Q0xqS1Zoa2RScGFST1BXNmFS?=
 =?utf-8?B?Q1g3bTJjaFIxRzVqUjhVeERJcWJPQkJZeHdEc0ZVNHZMNWt5YTFDV3FOeWdE?=
 =?utf-8?B?MzNxZ01LVHhybkhQMTdXZ2pMMVNnakZhSEpSdkhPQ2M1dkpjcFJLSFJXcUxC?=
 =?utf-8?B?Zy8zVVV3TTFhWHgxMnZ4KzdJcjg4Z2dyemRUQU9WUUI5WEQ2YkJpMFdsUDI5?=
 =?utf-8?B?NGcxdXpVTUQ5T0h4bGNvK1E1cmt2S0lXWXVSbGVadVhYL1dRc2h1bGREZGZ4?=
 =?utf-8?B?c3RlRnphRlR2MWx4V0QzWHk3Y0g1QlRzblRSalJTRjZNdUJ6R2czYTZEZU9L?=
 =?utf-8?B?THYwRGFaTFczR3lRcG9GSVZXZ2krTFh1NUVqQ0ZROCtJeWdKdTFlbXB5SUhU?=
 =?utf-8?Q?oe87Vuz84V40X/mP1ypnzzBdI?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5472.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84bcf8dc-9d47-4e86-659b-08ddaebb9f44
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2025 22:58:21.0128 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Vo6R3FYNer8yjGneEq/52/hwXY9gCO4emL/zy71FFShwsFasRQuWVcFjvWaSFqoZ3Kz/ORXIE72Z9pvh91WjtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5131
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSmVyaW4gSmFjb2IgPGpl
cmluamFjb2JrQGdtYWlsLmNvbT4NCj4gU2VudDogV2VkbmVzZGF5LCBKdW5lIDE4LCAyMDI1IDU6
MjYgQU0NCj4gVG86IFBhdGhhaywgUHJhdmluIDxwcmF2aW4ucGF0aGFrQGludGVsLmNvbT4NCj4g
Q2M6IGRldkBkcGRrLm9yZzsgamVyaW5qQG1hcnZlbGwuY29tOyBDaGVuLCBNaWtlIFhpbWluZw0K
PiA8bWlrZS54aW1pbmcuY2hlbkBpbnRlbC5jb20+OyBSaWNoYXJkc29uLCBCcnVjZQ0KPiA8YnJ1
Y2UucmljaGFyZHNvbkBpbnRlbC5jb20+OyB0aG9tYXNAbW9uamFsb24ubmV0OyBNYXJjaGFuZCwg
RGF2aWQNCj4gPGRhdmlkLm1hcmNoYW5kQHJlZGhhdC5jb20+OyBuaXB1bi5ndXB0YUBhbWQuY29t
Ow0KPiBjaGVuYm94QG52aWRpYS5jb207IFNhcmthciwgVGlydGhlbmR1IDx0aXJ0aGVuZHUuc2Fy
a2FyQGludGVsLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MyA0LzddIGV2ZW50L2RsYjI6
IHN1cHBvcnQgbWFuYWdpbmcgaGlzdG9yeSBsaXN0DQo+IHJlc291cmNlDQo+IA0KPiBPbiBXZWQs
IEp1biAxOCwgMjAyNSBhdCAxMjo1MuKAr0FNIFByYXZpbiBQYXRoYWsgPHByYXZpbi5wYXRoYWtA
aW50ZWwuY29tPg0KPiB3cm90ZToNCj4gPg0KPiA+IEFkZCBzdXBwb3J0IGZvciBzZXR0aW5nIGFw
cGxpY2F0aW9uIHNwZWNpZmllZCBwb3J0IGhpc3RvcnkgU2V0IEhMDQo+ID4gZXF1YWwgdG8gQ1Eg
ZGVwdGggd2hlbiBpbmZsaWdodCBjb250cm9sIGlzIGVuYWJsZWQgQWRkZWQgY29tbWFuZCBsaW5l
DQo+ID4gcGFyYW1ldGVycyAndXNlX2RlZmF1bHRfaGwnIChkZWZhdWx0OiAxKQ0KPiA+ICAgIGFu
ZCAnYWxsb2NfaGxfZW50cmllcycNCj4gPiAgLSBXaGVuICd1c2VfZGVmYXVsdF9obCA9IDEnDQo+
ID4gICAgKiBQZXIgcG9ydCBITCBpcyBzZXQgdG8gRExCMl9GSVhFRF9DUV9ITF9TSVpFICgzMikN
Cj4gPiAgICAqIFJlY29tbWVuZGVkIENRIGRlcHRoIGJ5IGRsYjJfZXZlbnRkZXZfcG9ydF9kZWZh
dWx0X2NvbmZfZ2V0KCkNCj4gPiAgICAgIGlzIERMQjJfRklYRURfQ1FfSExfU0laRS8yDQo+ID4g
ICAgKiBjb21tYW5kIGxpbmUgcGFyYW1ldGVyIGFsbG9jX2hsX2VudHJpZXMgaXMgaWdub3JlZA0K
PiA+ICAtIFdoZW4gJ3VzZV9kZWZhdWx0X2hsID0gMCcNCj4gPiAgICAqIFBlciBMREIgcG9ydCBI
TCA9IDIgKiBDUSBkZXB0aA0KPiA+ICAgICogUmVjb21tZW5kZWQgQ1EgZGVwdGggYnkgZGxiMl9l
dmVudGRldl9wb3J0X2RlZmF1bHRfY29uZl9nZXQoKQ0KPiA+ICAgICAgaXMgRExCMl9GSVhFRF9D
UV9ITF9TSVpFDQo+ID4gICAgKiBVc2VyIHNob3VsZCBjYWxjdWxhdGUgbmVlZGVkIEhMIGVudHJp
ZXMgYmFzZWQgb24gQ1EgZGVwdGhzIHRoZQ0KPiA+ICAgICAgYXBwbGljYXRpb24gd2lsbCB1c2Ug
YW5kIHNwZWNpZnkgaXQgYXMgY29tbWFuZCBsaW5lIHBhcmFtZXRlcg0KPiA+ICAgICAgJ2FsbG9j
X2hsX2VudHJpZXMnLiAgVGhpcyB3aWxsIGJlIHVzZWQgdG8gYWxsb2NhdGUgSEwgZW50cmllcy4N
Cj4gPiAgICAgICBhbGxvY19obF9lbnRyaWVzID0gKFN1bSBvZiBhbGwgTERCIHBvcnRzIENRIGRl
cHRocyAqIDIpDQo+ID4gICAgKiBJZiBhbGxvY19obF9lbnRyaWVzIGlzIG5vdCBzcGVjaWZpZWQs
IHRoZW4NCj4gPiAgICAgIFRvdGFsIEhMIGVudHJpZXMgZm9yIHRoZSBldmVudGRldiAgPSBudW1f
bGRiX3BvcnRzICogNjQNCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFByYXZpbiBQYXRoYWsgPHBy
YXZpbi5wYXRoYWtAaW50ZWwuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFRpcnRoZW5kdSBTYXJr
YXIgPHRpcnRoZW5kdS5zYXJrYXJAaW50ZWwuY29tPg0KPiA+IC0tLQ0KPiANCj4gPiAtLyohDQo+
ID4gKy8qKg0KPiA+ICAgKiBAd2FybmluZw0KPiA+ICAgKiBAYiBFWFBFUklNRU5UQUw6IHRoaXMg
QVBJIG1heSBjaGFuZ2UsIG9yIGJlIHJlbW92ZWQsIHdpdGhvdXQgcHJpb3INCj4gbm90aWNlDQo+
ID4gICAqDQo+ID4gQEAgLTkxLDYgKzkxLDUyIEBAIHJ0ZV9wbWRfZGxiMl9zZXRfdG9rZW5fcG9w
X21vZGUodWludDhfdA0KPiBkZXZfaWQsDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICB1aW50OF90IHBvcnRfaWQsDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBlbnVtIGRsYjJfdG9rZW5fcG9wX21vZGUgbW9kZSk7DQo+ID4NCj4gPiArLyoqIFNldCBpbmZs
aWdodCB0aHJlc2hvbGQgZm9yIGZsb3cgbWlncmF0aW9uICovICNkZWZpbmUNCj4gPiArRExCMl9T
RVRfUE9SVF9GTE9XX01JR1JBVElPTl9USFJFU0hPTEQgUlRFX0JJVDY0KDApDQo+ID4gKw0KPiA+
ICsvKiogU2V0IHBvcnQgaGlzdG9yeSBsaXN0ICovDQo+ID4gKyNkZWZpbmUgRExCMl9TRVRfUE9S
VF9ITCBSVEVfQklUNjQoMSkNCj4gPiArDQo+ID4gKy8qKg0KPiA+ICsgKiBAd2FybmluZw0KPiA+
ICsgKiBAYiBFWFBFUklNRU5UQUw6IHRoaXMgQVBJIG1heSBjaGFuZ2UsIG9yIGJlIHJlbW92ZWQs
IHdpdGhvdXQgcHJpb3INCj4gPiArbm90aWNlDQo+IA0KPiBUaGlzIGlzIE5PVCBBUEkNCg0KQ2hh
bmdlZCBpdC4gDQoNCj4gDQo+ID4gKyAqDQo+ID4gKyAqIFNldHMgVERUIHRocmVzaG9sZCBhbmQg
SEwgc2l6ZSBmb3IgYSBETEIyIHBvcnQuDQo+ID4gKyAqLw0KPiA+ICtzdHJ1Y3QgcnRlX3BtZF9k
bGIyX3BvcnRfcGFyYW0gew0KPiA+ICsgICAgICAgdWludDE2X3QgaW5mbGlnaHRfdGhyZXNob2xk
IDogMTI7DQo+ID4gKyAgICAgICB1aW50MTZfdCBwb3J0X2hsOw0KPiANCj4gRG94eWdlbiBjb21t
ZW50cyBmb3IgZWFjaCBmaWVsZCBpcyBtaXNzaW5nLg0KDQpBZGRlZCBEb3h5Z2VuIGNvbW1lbnRz
DQoNCj4gDQo+IA0KPiA+ICt9Ow0KPiA+ICsNCj4gPiArLyoqDQo+ID4gKyAqIEB3YXJuaW5nDQo+
ID4gKyAqIEBiIEVYUEVSSU1FTlRBTDogdGhpcyBBUEkgbWF5IGNoYW5nZSwgb3IgYmUgcmVtb3Zl
ZCwgd2l0aG91dCBwcmlvcg0KPiA+ICtub3RpY2UNCj4gPiArICoNCj4gPiArICogQ29uZmlndXJl
IHZhcmlvdXMgcG9ydCBwYXJhbWV0ZXJzLg0KPiA+ICsgKiBUaGlzIGZ1bmN0aW9uIG11c3QgYmUg
Y2FsbGVkIGJlZm9yZSBjYWxsaW5nIHJ0ZV9ldmVudF9wb3J0X3NldHVwKCkNCj4gPiArICogZm9y
IHRoZSBwb3J0LCBhbmQgYWZ0ZXIgY2FsbGluZyBydGVfZXZlbnRfZGV2X2NvbmZpZ3VyZSgpLg0K
PiA+ICsgKg0KPiA+ICsgKiBAcGFyYW0gZGV2X2lkDQo+ID4gKyAqICAgIFRoZSBpZGVudGlmaWVy
IG9mIHRoZSBldmVudCBkZXZpY2UuDQo+ID4gKyAqIEBwYXJhbSBwb3J0X2lkDQo+ID4gKyAqICAg
IFRoZSBpZGVudGlmaWVyIG9mIHRoZSBldmVudCBwb3J0Lg0KPiA+ICsgKiBAcGFyYW0gZmxhZ3MN
Cj4gPiArICogICAgQml0bWFzayBvZiB0aGUgcGFyYW1ldGVycyBiZWluZyBzZXQuDQo+ID4gKyAq
IEBwYXJhbSB2YWwNCj4gPiArICogICAgU3RydWN0dXJlIGNvYW50YWluaW5nIHRoZSB2YWx1ZXMg
b2YgcGFyYW1ldGVycyBiZWluZyBzZXQuDQo+IA0KPiBjb2FudGFpbmluZyAtIFR5cG8NCg0KRml4
ZWQNCg0KPiANCj4gDQo+ID4gKyAqDQo+ID4gKyAqIEByZXR1cm4NCj4gPiArICogLSAwOiBTdWNj
ZXNzDQo+ID4gKyAqIC0gRUlOVkFMOiBJbnZhbGlkIGRldl9pZCwgcG9ydF9pZCwgb3IgbW9kZQ0K
PiA+ICsgKiAtIEVJTlZBTDogVGhlIERMQjIgaXMgbm90IGNvbmZpZ3VyZWQsIGlzIGFscmVhZHkg
cnVubmluZywgb3IgdGhlIHBvcnQgaXMNCj4gPiArICogICBhbHJlYWR5IHNldHVwDQo+ID4gKyAq
Lw0KPiA+ICtfX3J0ZV9leHBlcmltZW50YWwNCj4gPiAraW50DQo+ID4gK3J0ZV9wbWRfZGxiMl9z
ZXRfcG9ydF9wYXJhbSh1aW50OF90IGRldl9pZCwNCj4gPiArICAgICAgICAgICAgICAgICAgICAg
ICAgICAgdWludDhfdCBwb3J0X2lkLA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICB1
aW50NjRfdCBmbGFncywNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgdm9pZCAqdmFs
KTsNCj4gDQo+IFdoeSB2b2lkICogLSBJcyBpdCBydGVfcG1kX2RsYjJfcG9ydF9wYXJhbSAqIHBv
aW50ZXIuIFJpZ2h0Pw0KPiANCj4gQWxzbyBmaXggZm9sbG93aW5nIGlzc3Vlcw0KPiANCj4gMSlb
Zm9yLW1haW5dZGVsbFtkcGRrLW5leHQtZXZlbnRkZXZdICQgZ2l0IGRpZmYgSEVBRH43Li5IRUFE
IHwgZ3JlcCBcKHZvaWRcKQ0KPiArICAgICAgICh2b2lkKSBlbnF1ZXVlX2RlcHRoOw0KPiANCj4g
dXNlIFJURV9TRVRfVVNFRA0KDQpBZGRlZA0KDQo+IA0KPiAyKQ0KDQpGb3IgdGhlIGZvbGxvd2lu
ZywgaWYgSSB0cnkgdG8gYXZvaWQgbGluZSBjb250aW51YXRpb24sIEkgZ2V0IHRoZcKgZm9sbG93
aW5nIHdhcm5pbmcuIA0KV0FSTklORzpNVUxUSUxJTkVfREVSRUZFUkVOQ0U6IEF2b2lkIG11bHRp
cGxlIGxpbmUgZGVyZWZlcmVuY2UgLSBwcmVmZXIgJ3FtX3BvcnQtPmV2X3BvcnQtPnN0YXRzLnF1
ZXVlW2V2X3FpZDBdLnFpZF9kZXB0aFtSVEVfUE1EX0RMQjJfR0VUX1FJRF9ERVBUSCgmZXZlbnRz
WzBdJw0KPiANCj4gIyMjIFtQQVRDSF0gZXZlbnQvZGxiMjogc3VwcG9ydCBtYW5hZ2luZyBoaXN0
b3J5IGxpc3QgcmVzb3VyY2UNCj4gDQo+IFdhcm5pbmcgaW4gZHJpdmVycy9ldmVudC9kbGIyL2Rs
YjIuYzoNCj4gVXNpbmcgJWwgZm9ybWF0LCBwcmVmZXIgJVBSSSo2NCBpZiB0eXBlIGlzIFt1XWlu
dDY0X3QNCj4gDQo+ICMjIyBbUEFUQ0hdIGV2ZW50L2RsYjI6IGZpeCBxaWQgZGVwdGggeHN0YXQg
aW4gdmVjdG9yIHBhdGgNCj4gDQo+IFdBUk5JTkc6TElORV9DT05USU5VQVRJT05TOiBBdm9pZCB1
bm5lY2Vzc2FyeSBsaW5lIGNvbnRpbnVhdGlvbnMNCj4gIzIxOiBGSUxFOiBkcml2ZXJzL2V2ZW50
L2RsYjIvZGxiMi5jOjQxNDg6DQo+ICsgICAgICAgICAgICAgICBETEIyX0lOQ19TVEFUKHFtX3Bv
cnQtPmV2X3BvcnQtPnN0YXRzLnF1ZXVlW2V2X3FpZDNdLlwNCj4gDQo+IFdBUk5JTkc6TElORV9D
T05USU5VQVRJT05TOiBBdm9pZCB1bm5lY2Vzc2FyeSBsaW5lIGNvbnRpbnVhdGlvbnMNCj4gIzMw
OiBGSUxFOiBkcml2ZXJzL2V2ZW50L2RsYjIvZGxiMi5jOjQxNTc6DQo+ICsgICAgICAgICAgICAg
ICBETEIyX0lOQ19TVEFUKHFtX3BvcnQtPmV2X3BvcnQtPnN0YXRzLnF1ZXVlW2V2X3FpZDJdLlwN
Cj4gDQo+IFdBUk5JTkc6TElORV9DT05USU5VQVRJT05TOiBBdm9pZCB1bm5lY2Vzc2FyeSBsaW5l
IGNvbnRpbnVhdGlvbnMNCj4gIzM5OiBGSUxFOiBkcml2ZXJzL2V2ZW50L2RsYjIvZGxiMi5jOjQx
Njc6DQo+ICsgICAgICAgICAgICAgICBETEIyX0lOQ19TVEFUKHFtX3BvcnQtPmV2X3BvcnQtPnN0
YXRzLnF1ZXVlW2V2X3FpZDFdLlwNCj4gDQo+IFdBUk5JTkc6TElORV9DT05USU5VQVRJT05TOiBB
dm9pZCB1bm5lY2Vzc2FyeSBsaW5lIGNvbnRpbnVhdGlvbnMNCj4gIzQ4OiBGSUxFOiBkcml2ZXJz
L2V2ZW50L2RsYjIvZGxiMi5jOjQxNzY6DQo+ICsgICAgICAgICAgICAgICBETEIyX0lOQ19TVEFU
KHFtX3BvcnQtPmV2X3BvcnQtPnN0YXRzLnF1ZXVlW2V2X3FpZDBdLlwNCj4gDQo+IHRvdGFsOiAw
IGVycm9ycywgNCB3YXJuaW5ncywgMzIgbGluZXMgY2hlY2tlZA0KPiANCj4gDQo+IA0KPiANCj4g
PiAgI2lmZGVmIF9fY3BsdXNwbHVzDQo+ID4gIH0NCj4gPiAgI2VuZGlmDQo+ID4gLS0NCj4gPiAy
LjM5LjENCj4gPg0K
