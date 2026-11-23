Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB29606A31A
	for <dpdk-dev@archiver.kernel.org>; Mon, 23 Nov 2026 13:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=COFzFmhh;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=KNywTBSE
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CD9B14027A;
	Mon, 23 Nov 2026 14:23:18 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTPS id A64C640262;
 Mon, 23 Nov 2026 14:23:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795440197; x=1826976197;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=QtkauMG7P2k2RI8tRCe3/h2hab0OdlyM0r4tW5SOjs4=;
 b=COFzFmhhwako5RYTDj6rK9YDgbixOphTCmJFnAPeqyQrTVr3z5skRJGl
 kNi4M6FZjaDBrelPSUnZh8zjg61nnoATesIiKC/eTlH0oLMWpb+KImXs0
 ds4AhUmvb2fwf+MtkgqwmgzUVnQiScMcmE96LpBOebAC+Mt/BTWXZRAm5
 e5+jQKq76ZOqOTz9BA+QzeqkFd0ESPkmM0prnvQJCBz2Esa2UDkxueIZd
 YQM6OmHi4XlsT2p+v+TZX5Ef2bplv2zULDh4X11PS+cB0HxVpzxhaR6aA
 dcsnD4kvrNO1H9GX5/QSw9j+53uIUx1cKG3aASNH+P37FuMGOhlP8tD0+ A==;
X-CSE-ConnectionGUID: KjwuQFbgTHyQcZ1gAweS/g==
X-CSE-MsgGUID: 7RuVsFL/TP2zxzu2jVQfcQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11975"; a="4120858"
X-IronPort-AV: E=Sophos;i="6.27,227,1787036400"; 
   d="scan'208";a="4120858"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Nov 2026 05:23:14 -0800
X-CSE-ConnectionGUID: 96BOJ8shSrq+IY+ct3elMg==
X-CSE-MsgGUID: SVq8BEx1TUSWI7YG4tyP0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,227,1787036400"; d="scan'208";a="13286837"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa013.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Nov 2026 05:23:13 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Mon, 23 Nov 2026 05:23:13 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57 via Frontend Transport; Mon, 23 Nov 2026 05:23:13 -0800
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.62) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 23 Nov 2026 05:23:12 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZVR3V1VXFXYuKXnjO+R1sD45JaXcVm6BgwFFpNzhodvbvv7TGMVSM6noguRMljcG3klM95oV4xZd1e4ZJdk9ml2NXGvgqk8C73/9FeXDFo6dhVcbEH/NUBEB2GN9R6iOdsFXEuW68QxaZVi+CT45gmjv9fhtNncHzNMrSXp5F9D0czIGAfkn4zmDVNcMGh7Ax/1wIqyYMoGt8Cpx1I1dC0//4XF0O9wf0gWSJeCbhH8b85SHwkJzSZN9FAvNEFGFvjF9aDpuTP8Cwo7NIQLHTTbOfhIzN+Kv3KhH0L7ZUGQGsj7kOLvxsSrIYOT3152UYSE70Cd/bb2tR/cRDdl3BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QtkauMG7P2k2RI8tRCe3/h2hab0OdlyM0r4tW5SOjs4=;
 b=B32udxxv3hzG3mrHCfq0xb1MDc/mOoJpHlvsFJqtJGAetyJcN/vkqifuoqdw2n16830BA0C7hMHmdLG6d7arwtQEVtb03WxdI9ADJ+s9CbuEwJnTfs+NB27kwoYev5mTMU6Y+y9mDdpSvoJ75L9rRlekTHyziuOYZ8PRWoIYeHBZNTtbX60ZHmBaj6PRo2SXnBbJzAwydJ4x9PJpvzEXOwhOi5h6IGACobcGeayiHGEpi5AxHT2YA3UxN5lfcpGiM2i6hLjWuCarTGHN7SFhPi7EAX5LyObPwuPxptRt8ihQgRJUXOdljQj96/VD8St2C5UQJ9JYcmYo8cO+B0I/FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QtkauMG7P2k2RI8tRCe3/h2hab0OdlyM0r4tW5SOjs4=;
 b=KNywTBSEsofVXuzIXx2O6Oa/Rku9X++SjIXCIwAMBdM827BNQqDVoCcQDHRwwyX6XOyX7Mw3FFy5Zbb5ilNFZDt99q7aXx6VWKYSox2Yh0KUjJ02CSQ5FGDYiovutbyg+/xsVEyVRslKN3E2RFagMonSo0c3dygUUEjE87GpN94=
Received: from IA4PR11MB9278.namprd11.prod.outlook.com (2603:10b6:208:563::12)
 by DS0PR11MB8161.namprd11.prod.outlook.com (2603:10b6:8:164::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Mon, 23 Nov
 2026 13:23:11 +0000
Received: from IA4PR11MB9278.namprd11.prod.outlook.com
 ([fe80::9bef:c20f:571f:7057]) by IA4PR11MB9278.namprd11.prod.outlook.com
 ([fe80::9bef:c20f:571f:7057%6]) with mapi id 15.21.0639.011; Mon, 23 Nov 2026
 13:23:10 +0000
From: "Loftus, Ciara" <ciara.loftus@intel.com>
To: Maxime Coquelin <maxime.coquelin@redhat.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "stable@dpdk.org" <stable@dpdk.org>
Subject: RE: [PATCH] net/virtio: fix eventfd enable on device re-init
Thread-Topic: [PATCH] net/virtio: fix eventfd enable on device re-init
Thread-Index: AQHdezTkZTthmgeTrUiAeQUJT/4jLLc7nE+AgAAH6xA=
Date: Mon, 23 Nov 2026 13:23:10 +0000
Message-ID: <IA4PR11MB9278BCC1BC8DE9BAED6B218A8E452@IA4PR11MB9278.namprd11.prod.outlook.com>
References: <20261123102434.215799-1-ciara.loftus@intel.com>
 <CAO55cszUSTBDMM++h=d-OdUZK9SYZBW1oqeuXP+KVs_oiw81Rg@mail.gmail.com>
In-Reply-To: <CAO55cszUSTBDMM++h=d-OdUZK9SYZBW1oqeuXP+KVs_oiw81Rg@mail.gmail.com>
Accept-Language: en-IE, en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA4PR11MB9278:EE_|DS0PR11MB8161:EE_
x-ms-office365-filtering-correlation-id: c78bae13-cbc5-43c5-575a-08df4964ebab
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|38070700021|10067099003|4143699003|11063799006|56012099006|261021121427099003|261009223027099003|261102123227099003|261022075727099003|261028144727099003|261022105027099003|261026140227099003|261026121527099003|18002099003|22082099003;
x-microsoft-antispam-message-info: PFzvXjlLdatvp5qTZMfA/jxImXo6216VLlaTN/+yx6FBvras0d8NZMWXT2eNQgjGxoYHayaVZFDUqzTCNiESmIEAFjYOMi8XW1uB1UZfJQPUz7Y7/pJ/oo10BQdordYbI7kzO4Ew1s1lgLA4nvxmQz1fUg6rQqYJwuCfxhneuCF/ptapyANU2vB2LQuxLSo40pkg/77zxHTAK3p6Mte4PO9jCB+M5dfOVO4Nn00i+lfhW3fLAI1YoN5kpDItRV/4PSpHJHOHm+345/TGJQJqHW5uRlpQQEPAr7iEuRgVaz/Nw21mIRA/KgI7eF1W0NikWcH5xuBFXyXBeRoeyhtLfIAYsAFz1Aa7Bih/1nffL7CyYbz4nuZa33h2UGZF0mAx60ZwMNR1oshk6HCwcrhHWCHsYU6GyEYNGjV29hKEDvnG3ejYmOcXbprC3XrXC5cPqj+sJoYWGHelwW/0pZDTE6PHkhkLURGpKy0enslcInkOKG0qtM3ZjMekshE5Kcad5OgQpRt+s8ibQAzb+IFWbAigly341+qaWOwnFWNPeA0fC4tSlR98RVqpUf9RBiIib9MY4n+bPh5KFNkRUDGfZH2K3p+3Asvi3fzz3NM0WwP4xQgITtm/JRhs6Z61GlbzlCEBcCoAy4Q/DkJW2hkk9earNSjICOu2i9xox/5Fpk94yLmTp+4N2NlSNpegh9v0N5V5CkBhMsImHCTHBwvpbb+SnghaIWZHHGaN2i9zKzo=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA4PR11MB9278.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(38070700021)(10067099003)(4143699003)(11063799006)(56012099006)(261021121427099003)(261009223027099003)(261102123227099003)(261022075727099003)(261028144727099003)(261022105027099003)(261026140227099003)(261026121527099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UjltaThtb1RPaXZGU3BQRFQvQW5IdGRNOXBzSHhMNVFkYTluK0dUR1lLdVc5?=
 =?utf-8?B?TDRNc2QrREZxaVNOQmNpRjFYVkhibFZvTEFnQ01hblk0cWR0Y0ZSTEl1cFBE?=
 =?utf-8?B?aHRtR2lyTHlyQmUvak1xRDZ3bjZLd0tCcHRBc1dFWnpzS1paY05YMnU3ZlpQ?=
 =?utf-8?B?NFpFVEJucTl2V0Z4TE9LYmxmL3NQUFdsV3BJM3dzeEFJTmpweUJCaE5VeTdK?=
 =?utf-8?B?QzlEVFhrRDF5TXF1Tk40c1lhVWk5L0Y0eG5pb3JNMU1CeVF5MlY4TVhnTUhG?=
 =?utf-8?B?UXlxWG1GeEFpQ0ttanhud0RFNEo3c1l5SUxFU29KNWQ0b0dPbXFvWHI2ZStv?=
 =?utf-8?B?WmZ1ZndMc3U0WU9Wd0J2RCtUNEFHVFFsdWRSYnp2bHFSOVNHL2sveUFEVW1D?=
 =?utf-8?B?Z09reitBQVhIT1h5RGt1RlFoMkZyVDVCQ01DLzVEMWZhdTNMUzk4aUR3Q0Qz?=
 =?utf-8?B?RUUzaTFlcExWSEhkUTJQM25GVSsrdUlVNEZqS0FhYm84TUNmRFk0SkdxVzRo?=
 =?utf-8?B?d3o2emI0enFvc0tVc3Q5U0dFdDJUbTlEc3U5T2hrNytXR2cxSFh3eTdBUDE5?=
 =?utf-8?B?cU5OUUo1dFpCdUpPbUpWQWJpNGJpc25uQ3FiaSsxRmxmdkN1VUQzVXVjeGZT?=
 =?utf-8?B?c0M4dXdWSmJEY0I2MmhPdWZINWRBeTgwTitlWUZ5YzZUdlpveGxNdDg4OWZZ?=
 =?utf-8?B?QzJpV0p4RzdmdjgrMURuTXhtQzhPVGIzQ1prMWd0RXNmY3lTSjlHNnlEWG9N?=
 =?utf-8?B?QU52S0Qvb0krOEhleVJoZ1JVMFpvTVU2RHByemdtSG5RL0w4UHRuUkFiUkhB?=
 =?utf-8?B?Sm9naDdCVDJWNnhMSDI2UzR0bUV0MWtTd3dPL0o0UktYTFJvSGtMUmxjcjB4?=
 =?utf-8?B?WGJ4Q25UQUxWT0ptUTdiYWprQndKYXZnUDN5T1BjMFc5RmZyRkJLU25MK2Vw?=
 =?utf-8?B?S2txemlpOVNyMHRQNHV3S2EzMzYzMFVaSDJhSkQ5RFB2Z1RCN01CalpyaEpu?=
 =?utf-8?B?SnJ0RytQb25RSW5PWkk1UmMrbmdpL0wvOE8zQ2lsSWhwelI5VUY0aWdtd0Zy?=
 =?utf-8?B?emo5c3BmWHJZNjFyb1ExZkJkNDRHeHE0OW0vRzNyaHU0VEkrbVNzRXhLd2M1?=
 =?utf-8?B?aU84cWVIbEh6NlhFVEhMVmxZSGhlVW8xUmhkUVk5aTVRMGlKMU9DTGJNeFcz?=
 =?utf-8?B?S05tMWZ6Y1U2Lzd0MDc3YXdWMy80R2tSeVNVcVYxdW9IR2tYZ1B5N25ZT2RS?=
 =?utf-8?B?MlNWYzFOTDhtK0ttamNsMU91Vm8yZXlya241WDczbUtpdGZnT3lBbStzMG1w?=
 =?utf-8?B?SXl5T0JlWG9QdWF4N3FGZitSMStWWWI1SnZsMktiN1RIRDhBSFRjM0p3YVhB?=
 =?utf-8?B?THNPVWNWRzBOanpkNXhocWFlYkNRM3NKcVMrUHFSQ09ENHlUbE5KRHJUVjVX?=
 =?utf-8?B?UGpxKzVUT3lHRVFiUFJVdHRWWm54ZElvaWsremh3QTl3RDNobXNWVm1FaUNZ?=
 =?utf-8?B?c3dNQnNwTW15dUlDRVdhY2gzMU1LQUppWEhRbmJTTWtzcGxyUHRNUzQ1aTJx?=
 =?utf-8?B?dkxjc2w5QVdaNlpVS20xY1VRemNJb3E2M2JnMUpYWkRyUVBZWVZ4TVNNbllL?=
 =?utf-8?B?anoyOGM0SVFvWkZYYTlBSzZPU2Z0SzNaZTlaK0JRVUorTVJkTDFSK29YdnZ3?=
 =?utf-8?B?ejNwaTFRaVRPL292RVA5NFB3V3d1WlJsUTNtUVFqUFRVcncxeHZrR0QrSUxz?=
 =?utf-8?B?azBzVzZvZUJPd3l2a1VRaDRZUGxWRjZRdzc3a0krcFNoaCs0RlY0Y1E3RHhq?=
 =?utf-8?B?b0dFZ093Sk91OWRiYlhkZ0F0RXhnYXVHMGtxSG5MK3R0QWI1di9qMVA5cmls?=
 =?utf-8?B?OWxNZW9KaTBOek80MUhERjlMRWN0b0dFRmZTYzlleWF5M1VxVTI0M3lNVjA1?=
 =?utf-8?B?czBjR3JVdTREK2psdm1LaStyRnlseXBROEpYWFFzajJueDhRd3FDVXBBQXl3?=
 =?utf-8?B?YkF2cENXT0FaV2piWnpaTXViWitlb0M5d1d4bUhsK3hDRkNUQVhTdnFBSUk1?=
 =?utf-8?B?STRiRGNERGlCRzk2eldCcFp0SWs3NXB1NUlMcG5oNXpVQkN0NUNXb1BkemFW?=
 =?utf-8?B?QmhYVjBlckhweWFRZDFOV1JFZGowQTlubzhPSXBOQjJhVzRJRFhLaGIxZkti?=
 =?utf-8?B?S1c3U3JMUjhwZk9oQmhIVjd3eEc5Mnh4emhuQW9TKzlRVzV5akxRUmJpUGxN?=
 =?utf-8?B?c1U4U3dQanJWTEtqM010V2FSUm9CQVRvc2U1clFmbC9DN2lKUzZWdGdHWHpW?=
 =?utf-8?B?b3RkWlpKOGJhTXBDK0U1eXB3VEI2OHB1T1lsNy94NUVPU2EyRHMxQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Ah2qFS0MjkxfWfNq7fOL3MIA52tQYg5S71nUw6pB3FtTLwbe2cDugIiTmxdZKYhtq50cMrf0N2EopIEbstpRT1eEW35PHFTq8voG101awmY3HnbLw0Q+J46lU9keH7ape2wMLImKjk6CcMVt/OH5MHrQ5czcxFlrEE+jOdsauClsis98rabFtDah2P1BP8PbVYk+iw5K5X35QGyzV/bgrQqmQzPTjG4OfWwAAjLAN78HK9gL8tvaMhsdphncYsKtCAPFnvO8dntGQ2AYPWW3nhUr3DzpUSZPPeVDu3mVBHOuKGl5DKtbbssX401AJgDj6dOz2QHyPWwCNX0cYAVMwg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA4PR11MB9278.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c78bae13-cbc5-43c5-575a-08df4964ebab
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2026 13:23:10.9110 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4iUpeL3+nh0yx0OHYLHuyQeUr6XGpa8fxSb5AP2tSeL2j13hzqGlPSkfp0yOyXVV8ohD5NEOXONxVAjfgSMcig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8161
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

PiBTdWJqZWN0OiBSZTogW1BBVENIXSBuZXQvdmlydGlvOiBmaXggZXZlbnRmZCBlbmFibGUgb24g
ZGV2aWNlIHJlLWluaXQNCj4gDQo+IEhlbGxvIENpYXJhLA0KPiANCj4gT24gTW9uLCBOb3YgMjMs
IDIwMjYgYXQgMTE6MjXigK9BTSBDaWFyYSBMb2Z0dXMgPGNpYXJhLmxvZnR1c0BpbnRlbC5jb20+
DQo+IHdyb3RlOg0KPiA+DQo+ID4gdmlydGlvX2Rldl9jb25maWd1cmUoKSBjYW4gY2FsbCB2aXJ0
aW9faW5pdF9kZXZpY2UoKSBtb3JlIHRoYW4gb25jZQ0KPiA+IHdpdGggUnggaW50ZXJydXB0cyBl
bmFibGVkLiBFYWNoIGNhbGwgZW5hYmxlcyB0aGUgZXZlbnRmZHMgYWdhaW4gd2l0aG91dA0KPiA+
IHJlbGVhc2luZyB0aGUgcHJldmlvdXMgb25lcy4gVGhpcyB1c2VkIHRvIGxlYWsgdGhlIG9sZCBl
dmVudGZkcywgYnV0IEVBTA0KPiA+IG5vdyByZWplY3RzIHRoZSByZXBlYXRlZCBlbmFibGUsIGNh
dXNpbmcgZGV2X2NvbmZpZ3VyZSgpIHRvIGZhaWwuDQo+ID4NCj4gPiBGaXggdGhpcyBieSBkaXNh
YmxpbmcgdGhlIGV2ZW50ZmRzIGJlZm9yZSBlbmFibGluZyB0aGVtIGFnYWluLCBleGNlcHQNCj4g
PiBmb3IgdmlydGlvLXVzZXIgd2hpY2ggZG9lcyBub3QgcmVjcmVhdGUgdGhlbS4NCj4gPg0KPiA+
IEZpeGVzOiBlN2I5ZDFkMjgwNmMgKCJuZXQvdmlydGlvOiBmaXggUnggaW50ZXJydXB0IHNldHVw
IikNCj4gPiBDYzogc3RhYmxlQGRwZGsub3JnDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBDaWFy
YSBMb2Z0dXMgPGNpYXJhLmxvZnR1c0BpbnRlbC5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMv
bmV0L3ZpcnRpby92aXJ0aW9fZXRoZGV2LmMgfCA0ICsrKysNCj4gPiAgMSBmaWxlIGNoYW5nZWQs
IDQgaW5zZXJ0aW9ucygrKQ0KPiA+DQo+IA0KPiBEYXZpZCBwb3N0ZWQgYSBwYXRjaCB0byByZXZl
cnQgM2JhNmI2ODk4OTNmLCBzbyBpbiB0aGVvcnkgeW91ciBwYXRjaA0KPiBzaG91bGQgbm90IGJl
IG5lZWRlZC4NCg0KQXBvbG9naWVzLCBJIG1pc3NlZCB0aGF0Lg0KDQo+IA0KPiBUaGUgcmV2ZXJ0
IGlzIHBhcnQgb2YgdjI2LjExLXJjNC4NCj4gQ2FuIHlvdSBjb25maXJtIHlvdSBkbyBub3QgcmVw
cm9kdWNlIHRoaXMgaXNzdWUgd2l0aCAtcmM0Pw0KDQpDb25maXJtZWQsIEkgZG9uJ3Qgc2VlIHRo
ZSBjb25maWd1cmUgZmFpbHVyZSB3aXRoIHJjNC4NCg0KPiANCj4gVGhhbmtzLA0KPiBNYXhpbWUN
Cg0K
