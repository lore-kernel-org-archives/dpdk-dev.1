Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B7D2F30273
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Mar 2026 06:05:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 84FA84025E;
	Mon, 16 Mar 2026 07:05:45 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mails.dpdk.org (Postfix) with ESMTP id B01E7400D5;
 Mon, 16 Mar 2026 07:05:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773641144; x=1805177144;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=SBT1SuE03KplX/MwUOlEgDXug+rQEugMuDQPSVOnH1M=;
 b=lKfGzyGacXmxclVHkd9WggRSuNCyP1Kcg6poZF4Cn8AyQtLmuNXJXMCN
 xpQj3+4S8xzPpd4PBAPKIQp8v5qsPwg/14KXR1mPHvWsnEwKiaO/vfoa7
 ggBwqNlpasuQk4hZI+gm8ZWh4i/D2KjeVoa9YNxDE2gfKrGVUsoi8MODM
 gMQedsPWyoMIiaaOvKDMpKpbEVy+UTLdbCniEH4PM/YJFSO/MthuI4tPA
 oCXzJtVEoxeQemmn9A4SHIajLazffvmuo0+cPxj6GtlA8AuqzNEWjiSlR
 giDsFVqE3PEkjYCArDwpKQnk5pYvjyV5tDOPMu1p57aJzvAZEfxSp2im9 w==;
X-CSE-ConnectionGUID: vhtzvHNcSemw86sZRomVJA==
X-CSE-MsgGUID: tNgROEXbSGW6ZuYZu2Q9ZQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11730"; a="85733642"
X-IronPort-AV: E=Sophos;i="6.23,123,1770624000"; d="scan'208";a="85733642"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Mar 2026 23:05:41 -0700
X-CSE-ConnectionGUID: PFA+wpAHQoKWYTicbUCCPA==
X-CSE-MsgGUID: +kjGD7oeQ8yKAVuRizy90g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,123,1770624000"; d="scan'208";a="219414308"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Mar 2026 23:05:40 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 15 Mar 2026 23:05:39 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Sun, 15 Mar 2026 23:05:39 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.13) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 15 Mar 2026 23:05:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=inYPdYT6UMbZB0cmtVUGMJQkelnwccc59IrEmGA+gomNJoXNCSB9rC3ZP4ABfmrQJlewnPukxv42ojkTu/i598Qvcs2APqRXJF7iBAOzWcE38/zI0HnGVPRDbB4SBL/D35VUt7khMyYwc3FC2S0G5lWRU4bhN6YT5jJ6Pu+QP4XwsdvFr7+LYNF7tZSxXqij0xUkj/DARPHILhUKSiLyatvW5h2J33iS0OQSaPXFSEI7UIQd/MMn6vf9Vy/w1cGG/isSKYNCPx43k15KJdBECeL2bXtJ+hqvJjAL4y3yqju2J7PvrxXWChvkXaK8komvShKSXu5QH4HjdcvheifUwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SBT1SuE03KplX/MwUOlEgDXug+rQEugMuDQPSVOnH1M=;
 b=AO76a9sJNJohR9L4zL/TufM2WmlB8rhMrbqlOD7ow4jk2lelIpMYsfdPZy3jM+tEQskoi1jg7XDxUJB3aXV74uB+sMNQSdWDh2QtYahhzt+kv5D1eiyABAKbnXezUdva48a5y9rD5e8Iug9vBw0AcArdG4w5UORQNlk321HgkJn2Tg6xjQzWWvQs/O84Z7lMbH4ztdKdbTI6B0t2xKMNAUs9i1bwwG7OX62qW4oymTIYAlkK84Pf9Px9YjF4yPpow+Y+SZMh9aqGbwbliYktCeD2uIPZqB+AV8ZBnB+Plq9F9C4/xgS6OAqhzgmyO3yXs7H/5WJyAIlEI2ThnL0Vgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL3PR11MB6532.namprd11.prod.outlook.com (2603:10b6:208:38f::9)
 by PH8PR11MB7047.namprd11.prod.outlook.com (2603:10b6:510:215::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.16; Mon, 16 Mar
 2026 06:05:35 +0000
Received: from BL3PR11MB6532.namprd11.prod.outlook.com
 ([fe80::d92d:205d:c23b:5d49]) by BL3PR11MB6532.namprd11.prod.outlook.com
 ([fe80::d92d:205d:c23b:5d49%6]) with mapi id 15.20.9723.014; Mon, 16 Mar 2026
 06:05:35 +0000
From: "Talluri, ChaitanyababuX" <chaitanyababux.talluri@intel.com>
To: fengchengwen <fengchengwen@huawei.com>, "dev@dpdk.org" <dev@dpdk.org>,
 "Richardson, Bruce" <bruce.richardson@intel.com>,
 "stephen@networkplumber.org" <stephen@networkplumber.org>, "Singh, Aman Deep"
 <aman.deep.singh@intel.com>
CC: "Wani, Shaiq" <shaiq.wani@intel.com>, "stable@dpdk.org" <stable@dpdk.org>
Subject: RE: [PATCH v2] app/testpmd: fix DCB forwarding TC mask and queue guard
Thread-Topic: [PATCH v2] app/testpmd: fix DCB forwarding TC mask and queue
 guard
Thread-Index: AQHcsg9/T0UaHeh66UGZchrRr592gbWrmfgAgAUTgFA=
Date: Mon, 16 Mar 2026 06:05:34 +0000
Message-ID: <BL3PR11MB6532E2AAD4A4AFA0002D0F2F9640A@BL3PR11MB6532.namprd11.prod.outlook.com>
References: <20260311083751.1107404-1-chaitanyababux.talluri@intel.com>
 <20260312103615.1282874-1-chaitanyababux.talluri@intel.com>
 <4fd815c8-4ce1-4182-af8b-57b7b92291a8@huawei.com>
In-Reply-To: <4fd815c8-4ce1-4182-af8b-57b7b92291a8@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL3PR11MB6532:EE_|PH8PR11MB7047:EE_
x-ms-office365-filtering-correlation-id: 1a793ce5-65de-4dbf-3e1e-08de832209d4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|10070799003|366016|1800799024|38070700021|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info: jkfvxh4/hZySfkHAQLN/GjctboMf2jl0tRZxAU53Gr3wjrT2yjFq+IqEASX8yixm3RCCntU8rpLo9josT65QXSAfQQSbhiYifUattzv8K71Af5ZcgJXpdXeT1MYt7CHiahkiMEhT8Bgha0XdKldyRbt0tMtuf5U4sVeiw3av2Z4qCmDnRoCFEHJ7BqjZkc3ajJhq1ksCVG2ZyO+5/7r8uFfC/Wq17m5R0mHqKTCLEgVe8lOaeaaIIe4whPrvjWme1VP8L9id95MSp6BPQlfj0pqKguMPnWqsTQb0Zp81ND86N6SfHNBn553kpQARaV+He9hkoBxlbkeqd3YcDtTiwRIepiovY/VsCZ10qXSgmrn0YhOdpIjS8uMGRio7DCn4xQ3ODEbWaOB3ddZHwf+0h7os8llnEqnY0Qnb0tmyUhTdZwk8R8LVdk8Za7d8dyPstkk98M+nzPVtQD18/6QwkxW5Q7eGdDmNvtuJFJ7Qg1t+plpn9vKizdrOsuKmAZZYn45BAPI+jYF8nWJw9Ls/dzn0rhHC5c//qW1GZWbRUliD8yJQ18kTysmrtc/g1eQaGeUdD5H1gJAs9WOjrG8ggj0JAME4kI4cluBdBuUdMS3kLai7QOoT9oHGsMBQv99oCy4X8IjosDodpTK3xDX9s1u/Iap9HhYn6wpMuh4PTs5nzp9Z+9pCFMfX8tzhGaWQK7DlLAXtea+dy9tP86jkVrv45i5Wb9mBZP8M0A/fJ62kTueeye5SIEgebllA8OFnRbZ1X8MMKkyTChdcC3Zkkx04gYIbEZHRYobP6GfOIho=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL3PR11MB6532.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(10070799003)(366016)(1800799024)(38070700021)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z2U2OWtOZDNCdkJDZ2VuTmZJdkZldHZzaW9GV0poQkJwbHdPSmpTTEhmNjZx?=
 =?utf-8?B?QWd6MlFJK2ROQ2cyK2xzamsrVFg2Nm0zVzlBVkdWanpDbEFIK2lWdUliTlJh?=
 =?utf-8?B?b3YvbXJkSzRnMGkvRmt3QXVpZkpzb0l0VUNMcjh5ZjhBbVBYQkxHekE2RVAz?=
 =?utf-8?B?OUozSmRQSWZGeW9saC9SSjBUTkpmRjZxVmE4bUhSclQzanU1ZnVFU3JLc1Y1?=
 =?utf-8?B?U0x3a3hwN3VXMnJGSGVQTStsdnlSdEp0bnpyTmJ3ckM4enBaOSsxOVk0S0tJ?=
 =?utf-8?B?c29URUNWMU12ZmsrWUc4cTcvd1FkMmVxVmJaRlE1OFk4WDlKaFZKRkFnck1o?=
 =?utf-8?B?QmlGckNuZDBtbHdVMWtUcElxdXRlOTd1YjF0b3Z0ZDVPVlMwNjZ4R3pPTnlY?=
 =?utf-8?B?aWEraDVBWHZWZ1IvenpxbUVNL3NLVFVvVGt4TkZDM0phcnIxNVZqNXovV0k3?=
 =?utf-8?B?cWNNUUhFZDlRdi9uTTVLWkZNcDl1M2pYcVFpMkVocEJoSEROV2xCV1c0QnJH?=
 =?utf-8?B?Vk9YWFRoVkhQekhLOVRnYVpxWHlNVXRLREJmU3JJZzBFNWE5dVpXTjU4MStv?=
 =?utf-8?B?WktRZFhDalBKcTBscnZyV1gwT2ZaY1ovYUkySWlKcVB6M3dvQUUyQlY0MWRx?=
 =?utf-8?B?Vlp5TXJMUHVHK2RWd29OWmVTSjZPMWhsSzhLalZ3ZWRBQnYzUXk2QkJZcmlY?=
 =?utf-8?B?dHNEaklnMXFoSmdscjlycytXYzFGWnlyaW9ZR2tTTlVWTWxWUVdRZmFMLzky?=
 =?utf-8?B?OTM5SmV5NXU3a3JqdnlmV3N4S1MyTjJMMitxMGVITFJwNGdBQUxZanEyU1hP?=
 =?utf-8?B?a3ZGYlhTWWRNZTFzc0kybGxHb1pDY2YzVXpTdTBUcDJZeENzUHhYZ1lBSlE3?=
 =?utf-8?B?WHU2VDZKdWRFT3k3cUZDWVVlWDZ2bUl5cCthM0E4SkFHVDJXR3VmYWtFUHZB?=
 =?utf-8?B?ei95ZldlaDJ2a3ZEMCs2R2hmalRuUkNjMkdpUmZ6YzMwMEM0c2hNTi9wR2dt?=
 =?utf-8?B?aEtaekhrMTdMblFpSHhMNmNXU1VlOWlienQwdXpCOVdzcGpEaC9GWUNrcitW?=
 =?utf-8?B?TGJYOHFGRjBuYlpCN2NwS2JKbmFFQ1lVQ09UbE5NYk5obFZnM2JVdnVWOHBr?=
 =?utf-8?B?c0JCeFdhampUSTNOREhSVEV4RkFLaE8wbm5QdjRYaktDK3VVdFBvc0dhYWFJ?=
 =?utf-8?B?eVZpUkpIYzFZSjBhNkticll1cElKQVVYdUNBYmVhYnRFOHhZME12UXE5Y29w?=
 =?utf-8?B?bmlzdngxaFJSQTZpWW41UURKUksvVEc1Z0wvTlFnbXVDTkVhcTRwTldDMm9Q?=
 =?utf-8?B?cWFIbXhjQmF1T0FuL3J3Y3ZTT2sra1VaK25uRWNVTzdDR29NR2hsVVpkWUpH?=
 =?utf-8?B?Y3Z6ckliVy9GeGM2NWkzYlU2S1pRcmFVSDhqTjl5SE15cjMvc2pkbHBSdkhy?=
 =?utf-8?B?SmI2SlFwRmpNeVpncDJ2VGlQc1FoSEttTVFrUUswNU81eXlMVWM3dS9pQ3Vn?=
 =?utf-8?B?Ynk4NHdIaTFadzZLcWRCQ2MrdFc1WjB2eDFkS1U3cTB5U0x1dlZsMlBVL2t5?=
 =?utf-8?B?TzcrN0N5N2gxYkRJZlB0bTBlQno0MGk3b0dlcTZudVg1WXhiNllRV0ZuS216?=
 =?utf-8?B?aWJ2WTBsOEJjUi9TdDlQNVpYSmZnNFpXR2lBYmJWTWhBTE52c2N4Q3c4T1l0?=
 =?utf-8?B?WDZReXVkRGdxU2pLNHBwaEpYZ2l5ZXd3Skl1VTJ0SUphVlB3aSswL2lpRWxi?=
 =?utf-8?B?L0VwTlcwRHJWYmdFc1hNRDFOZCtMZmRnUlQrd2d1ZzdabEZFMC9xaVloS0dB?=
 =?utf-8?B?SmZ1YjNMMEF4Y0ZONlNvQnhaaWhoeEpGa2RVZURvclJZN1Vqc0cxMG5HcmJm?=
 =?utf-8?B?Yyt5Q1BuUXE2T1h3WW9SSFBaUStxRmNwRTgxWno4ejFhdWZRa0hpQlNPRUwr?=
 =?utf-8?B?d2dYcG9jMEFuQnFhMUQ2UjlVbHFNVlkyUUhWMmVHVjJCVjdvQ3d2akdoVUZX?=
 =?utf-8?B?RFZqUW9tNFA4STV6eWdOVUlGblNOdGhDWHpEMDlCVUk4blc0TVE4YWg2M1VY?=
 =?utf-8?B?dGxlWWlJTWhjTTNGbnd3U2xEcVl6dGowaEU2am1NZU5pNDFTTDdRZkVIN2ht?=
 =?utf-8?B?Qk9uVHpHRW9nRGNsNW5KVXpUc09mQVhNbWdJWXdiMFU2Q3czWVR4aGMyTmdK?=
 =?utf-8?B?MG4vcEV6bXcveG8wekx5cTJTRFVYMnpUcUoxYXFJblcyMW96ME5nNnBlRERh?=
 =?utf-8?B?enN2eFd0WVpCNUpLazA5VHBiY3BibzloWjFSZ0NNRm0yK1ZETVV5ZGxBbEky?=
 =?utf-8?B?YXhqQlQwV2JWQldjejVwa3BSRWdpZXhqWGphMTZPaFcwcjUxOW10N1RSVldm?=
 =?utf-8?Q?vtG5ZPEPlvs1D6xTX52EaCj9zNvArHy/O2DyzgytlT6c4?=
x-ms-exchange-antispam-messagedata-1: G8pWw1Y8nF9sJzhWMDlm2qq6/YzZZezjISQ=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: W13GFPRBh2XqLU/U/jqzbBpAcqnI33Lac4ZWNrJq/4mWbS7Q1yf+82X3XykHZ3pI5RqeJYq9htoKlq7xDrLAS6FExGc8yAo9M3qzx1LH1kpseco7cOJwHjaaod59djjrnM4kwD2ghReesW/vquFTT2R8yC9inByzRxZj4MnOwoZUtgJuLTMerjUJQhrZ1S96Q6C75yZ6Ind5D6MkwnS5IUEIG0feHuvSO9atkaTkzU/Hb11EBOOJW2kdFiFU22YCJMyYWNDq8YjQ0o/dYUT3o2GT0AUccYRkt+l0o29MVJNFBPlfMdyEQAYGkYI+/JIz3HkBSzTE7+zeMHLXhHndqA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6532.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a793ce5-65de-4dbf-3e1e-08de832209d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2026 06:05:35.0149 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4seDKUElXsEqtgebxnK8kbxj9rkhtfMpLHKYK6hDTyjKX3zCnyz8bZu5tX6CMA5Xmd8Da0ihpoh4og1yEOgLpXTbaKhuiepLdbjw4x5tpgcoMtRx+YmT0HP17HlFSvCk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7047
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

DQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBmZW5nY2hlbmd3ZW4gPGZlbmdj
aGVuZ3dlbkBodWF3ZWkuY29tPiANClNlbnQ6IDEzIE1hcmNoIDIwMjYgMDU6NDkNClRvOiBUYWxs
dXJpLCBDaGFpdGFueWFiYWJ1WCA8Y2hhaXRhbnlhYmFidXgudGFsbHVyaUBpbnRlbC5jb20+OyBk
ZXZAZHBkay5vcmc7IFJpY2hhcmRzb24sIEJydWNlIDxicnVjZS5yaWNoYXJkc29uQGludGVsLmNv
bT47IHN0ZXBoZW5AbmV0d29ya3BsdW1iZXIub3JnOyBTaW5naCwgQW1hbiBEZWVwIDxhbWFuLmRl
ZXAuc2luZ2hAaW50ZWwuY29tPg0KQ2M6IFdhbmksIFNoYWlxIDxzaGFpcS53YW5pQGludGVsLmNv
bT47IHN0YWJsZUBkcGRrLm9yZw0KU3ViamVjdDogUmU6IFtQQVRDSCB2Ml0gYXBwL3Rlc3RwbWQ6
IGZpeCBEQ0IgZm9yd2FyZGluZyBUQyBtYXNrIGFuZCBxdWV1ZSBndWFyZA0KDQpPbiAzLzEyLzIw
MjYgNjozNiBQTSwgVGFsbHVyaSBDaGFpdGFueWFiYWJ1IHdyb3RlOg0KPiBVcGRhdGUgZm9yd2Fy
ZGluZyBUQyBtYXNrIGJhc2VkIG9uIGNvbmZpZ3VyZWQgdHJhZmZpYyBjbGFzc2VzIHRvIA0KPiBw
cm9wZXJseSBoYW5kbGUgYm90aCA0IFRDIGFuZCA4IFRDIG1vZGVzLiBUaGUgYml0bWFzayBjYWxj
dWxhdGlvbiAoMXUgDQo+IDw8IG5iX3RjcykgLSAxIGNvcnJlY3RseSBjcmVhdGVzIG1hc2tzIGZv
ciBhbGwgYXZhaWxhYmxlIHRyYWZmaWMgDQo+IGNsYXNzZXMgKDB4RiBmb3IgNCBUQ3MsIDB4RkYg
Zm9yIDggVENzKS4NCj4gDQo+IFdoZW4gdGhlIG1hc2sgaXMgbm90IHVwZGF0ZWQgYWZ0ZXIgYSBU
QyBjb25maWd1cmF0aW9uIGNoYW5nZSwgaXQgc3RheXMgDQo+IGF0IHRoZSBkZWZhdWx0IDB4RkYs
IHdoaWNoIGNhdXNlcyBkY2JfZndkX3RjX3VwZGF0ZV9kY2JfaW5mbygpIHRvIHNraXAgDQo+IHRo
ZSBjb21wcmVzcyBsb2dpYyBlbnRpcmVseSAoZWFybHkgcmV0dXJuIHdoZW4gbWFzayA9PSANCj4g
REVGQVVMVF9EQ0JfRldEX1RDX01BU0spLg0KPiBUaGlzIGNhbiBsZWFkIHRvIGluY29uc2lzdGVu
dCBxdWV1ZSBhbGxvY2F0aW9ucy4NCg0KU29ycnksIEkgY2Fubm90IHVuZGVyc3RhbmQgeW91ciBx
dWVzdGlvbi4gQ291bGQgeW91IHBsZWFzZSBwcm92aWRlIHNvbWUgc3RlcHMgdG8gcmVwcm9kdWNl
IHRoZSBpc3N1ZSBhbmQgdGhlIHByb2JsZW0gcGhlbm9tZW5vbj8NCg0KUGxlYXNlIGZpbmQgdGhl
IHJlcHJvZHVjdGlvbiBzdGVwcyBhbmQgcHJvYmxlbSBkZXNjcmlwdGlvbiBiZWxvdy4NCg0KMS5i
aW5kIDIgcG9ydCB0byB2ZmlvLXBjaQ0KLi91c2VydG9vbHMvZHBkay1kZXZiaW5kLnB5IC1iIHZm
aW8tcGNpIDAwMDA6YWY6MDAuMCAwMDAwOmFmOjAwLjENCjIuIHN0YXJ0IHRlc3RwbWQgYW5kIHJl
c2V0IERDQiBQRkMNCi4veDg2XzY0LW5hdGl2ZS1saW51eGFwcC1nY2MvYXBwL2RwZGstdGVzdHBt
ZCAtbCAxLTIwIC1uIDQgLWEgMDAwMDphZjowMC4wIC1hIDAwMDA6YWY6MDAuMSAtLWZpbGUtcHJl
Zml4PXRlc3RwbWQxIC0tIC1pIC0tcnhxPTI1NiAtLXR4cT0yNTYgLS1uYi1jb3Jlcz0xNiAtLXRv
dGFsLW51bS1tYnVmcz02MDAwMDANCg0KdGVzdHBtZD4gcG9ydCBzdG9wIGFsbA0KdGVzdHBtZD4g
cG9ydCBjb25maWcgMCBkY2IgdnQgb2ZmIDggcGZjIG9uDQp0ZXN0cG1kPiBwb3J0IGNvbmZpZyAx
IGRjYiB2dCBvZmYgOCBwZmMgb24NCnRlc3RwbWQ+IHBvcnQgc3RhcnQgYWxsDQp0ZXN0cG1kPiBw
b3J0IHN0b3AgYWxsDQp0ZXN0cG1kPiBwb3J0IGNvbmZpZyAwIGRjYiB2dCBvZmYgNCBwZmMgb24N
Cg0KVGVzdCBMb2c6IA0Kcm9vdEBzcnYxMzp+L3Rlc3QtMS9kcGRrIyAuL3g4Nl82NC1uYXRpdmUt
bGludXhhcHAtZ2NjL2FwcC9kcGRrLXRlc3RwbWQgLWwgMS0yMCAtbiA0IC1hIDAwMDA6MzE6MDAu
MCAtYSAwMDAwOjRiOjAwLjAgLS1maWxlLXByZWZpeD10ZXN0cG1kMSAtLSAtaSAtLXJ4cT0yNTYg
LS10eHE9MjU2IC0tbmItY29yZXM9MTYgLS10b3RhbC1udW0tbWJ1ZnM9NjAwMDAwDQpFQUw6IERl
dGVjdGVkIENQVSBsY29yZXM6IDk2DQpFQUw6IERldGVjdGVkIE5VTUEgbm9kZXM6IDINCkVBTDog
RGV0ZWN0ZWQgc3RhdGljIGxpbmthZ2Ugb2YgRFBESw0KRUFMOiBNdWx0aS1wcm9jZXNzIHNvY2tl
dCAvdmFyL3J1bi9kcGRrL3Rlc3RwbWQxL21wX3NvY2tldA0KRUFMOiBTZWxlY3RlZCBJT1ZBIG1v
ZGUgJ1ZBJw0KRUFMOiBWRklPIHN1cHBvcnQgaW5pdGlhbGl6ZWQNCkVBTDogVXNpbmcgSU9NTVUg
dHlwZSAxIChUeXBlIDEpDQpJQ0VfSU5JVDogaWNlX2xvYWRfcGtnX3R5cGUoKTogQWN0aXZlIHBh
Y2thZ2UgaXM6IDEuMy41MC4wLCBJQ0UgT1MgRGVmYXVsdCBQYWNrYWdlIChzaW5nbGUgVkxBTiBt
b2RlKQ0KSUNFX0lOSVQ6IGljZV9sb2FkX3BrZ190eXBlKCk6IEFjdGl2ZSBwYWNrYWdlIGlzOiAx
LjMuNTAuMCwgSUNFIE9TIERlZmF1bHQgUGFja2FnZSAoc2luZ2xlIFZMQU4gbW9kZSkNCkludGVy
YWN0aXZlLW1vZGUgc2VsZWN0ZWQNCnRlc3RwbWQ6IGNyZWF0ZSBhIG5ldyBtYnVmIHBvb2wgPG1i
X3Bvb2xfMD46IG49NjAwMDAwLCBzaXplPTIxNzYsIHNvY2tldD0wDQp0ZXN0cG1kOiBwcmVmZXJy
ZWQgbWVtcG9vbCBvcHMgc2VsZWN0ZWQ6IHJpbmdfbXBfbWMNCkNvbmZpZ3VyaW5nIFBvcnQgMCAo
c29ja2V0IDApDQpJQ0VfRFJJVkVSOiBpY2Vfc2V0X3R4X2Z1bmN0aW9uKCk6IFVzaW5nIFZlY3Rv
ciBBVlgyIChwb3J0IDApLg0KSUNFX0RSSVZFUjogaWNlX3NldF9yeF9mdW5jdGlvbigpOiBVc2lu
ZyBPZmZsb2FkIFZlY3RvciBBVlgyIChwb3J0IDApLg0KUG9ydCAwOiBCNDo5Njo5MTo5Rjo1RTpC
MA0KQ29uZmlndXJpbmcgUG9ydCAxIChzb2NrZXQgMCkNCklDRV9EUklWRVI6IGljZV9zZXRfdHhf
ZnVuY3Rpb24oKTogVXNpbmcgVmVjdG9yIEFWWDIgKHBvcnQgMSkuDQpJQ0VfRFJJVkVSOiBpY2Vf
c2V0X3J4X2Z1bmN0aW9uKCk6IFVzaW5nIE9mZmxvYWQgVmVjdG9yIEFWWDIgKHBvcnQgMSkuDQpQ
b3J0IDE6IDY4OjA1OkNBOkEzOjEzOjRDDQpDaGVja2luZyBsaW5rIHN0YXR1c2VzLi4uDQpEb25l
DQp0ZXN0cG1kPiBwb3J0IHN0b3AgYWxsDQpTdG9wcGluZyBwb3J0cy4uLg0KDQpQb3J0IDA6IGxp
bmsgc3RhdGUgY2hhbmdlIGV2ZW50DQpDaGVja2luZyBsaW5rIHN0YXR1c2VzLi4uDQoNClBvcnQg
MTogbGluayBzdGF0ZSBjaGFuZ2UgZXZlbnQNCkRvbmUNCnRlc3RwbWQ+IHBvcnQgY29uZmlnIDAg
ZGNiIHZ0IG9mZiA4IHBmYyBvbg0KSW4gRENCIG1vZGUsIGFsbCBmb3J3YXJkaW5nIHBvcnRzIG11
c3QgYmUgY29uZmlndXJlZCBpbiB0aGlzIG1vZGUuDQp0ZXN0cG1kPiBwb3J0IGNvbmZpZyAxIGRj
YiB2dCBvZmYgOCBwZmMgb24NCnRlc3RwbWQ+IHBvcnQgc3RhcnQgYWxsDQpDb25maWd1cmluZyBQ
b3J0IDAgKHNvY2tldCAwKQ0KSUNFX0RSSVZFUjogaWNlX3NldF90eF9mdW5jdGlvbigpOiBVc2lu
ZyBWZWN0b3IgQVZYMiAocG9ydCAwKS4NCklDRV9EUklWRVI6IGljZV9zZXRfcnhfZnVuY3Rpb24o
KTogVXNpbmcgT2ZmbG9hZCBWZWN0b3IgQVZYMiAocG9ydCAwKS4NCg0KUG9ydCAwOiBsaW5rIHN0
YXRlIGNoYW5nZSBldmVudA0KUG9ydCAwOiBCNDo5Njo5MTo5Rjo1RTpCMA0KQ29uZmlndXJpbmcg
UG9ydCAxIChzb2NrZXQgMCkNCklDRV9EUklWRVI6IGljZV9zZXRfdHhfZnVuY3Rpb24oKTogVXNp
bmcgVmVjdG9yIEFWWDIgKHBvcnQgMSkuDQpJQ0VfRFJJVkVSOiBpY2Vfc2V0X3J4X2Z1bmN0aW9u
KCk6IFVzaW5nIE9mZmxvYWQgVmVjdG9yIEFWWDIgKHBvcnQgMSkuDQpQb3J0IDE6IDY4OjA1OkNB
OkEzOjEzOjRDDQpDaGVja2luZyBsaW5rIHN0YXR1c2VzLi4uDQpEb25lDQp0ZXN0cG1kPiBwb3J0
IHN0b3AgYWxsDQpTdG9wcGluZyBwb3J0cy4uLg0KDQpQb3J0IDA6IGxpbmsgc3RhdGUgY2hhbmdl
IGV2ZW50DQpDaGVja2luZyBsaW5rIHN0YXR1c2VzLi4uDQoNClBvcnQgMTogbGluayBzdGF0ZSBj
aGFuZ2UgZXZlbnQNCkRvbmUNCnRlc3RwbWQ+IHBvcnQgY29uZmlnIDAgZGNiIHZ0IG9mZiA0IHBm
YyBvbg0KRmxvYXRpbmcgcG9pbnQgZXhjZXB0aW9uDQoNCkV4cGVjdGVkIGJlaGF2aW91cjoNCg0K
QWZ0ZXIgcmVjb25maWd1cmluZyBQRkMgZnJvbSA4IHRvIDQgVENzLCB0aGUgZm9yd2FyZGluZyBU
QyBtYXNrIHNob3VsZCByZWZsZWN0DQp0aGUgY29uZmlndXJlZCBudW1iZXIgb2YgVENzIChtYXNr
ID0gMHhGKS4NCj4gDQo+IEFkZGl0aW9uYWxseSwgdGhlIGV4aXN0aW5nIFZNRFEgcG9vbCBndWFy
ZCBpbiBkY2JfZndkX2NvbmZpZ19zZXR1cCgpIA0KPiBvbmx5IGNoZWNrcyBSWCBxdWV1ZSBjb3Vu
dHMsIG1pc3NpbmcgdGhlIGNhc2Ugd2hlcmUgdGhlIFRYIHBvcnQgaGFzIA0KPiB6ZXJvIHF1ZXVl
cyBmb3IgYSBnaXZlbiBwb29sL1RDIGNvbWJpbmF0aW9uLiBXaGVuIG5iX3R4X3F1ZXVlIGlzIDAs
IA0KPiB0aGUgZXhwcmVzc2lvbiAiaiAlIG5iX3R4X3F1ZXVlIiB0cmlnZ2VycyBhIFNJR0ZQRSAo
aW50ZWdlciBkaXZpc2lvbiBieSB6ZXJvKS4NCg0KVGhlIGRjYl9md2RfY2hlY2tfY29yZXNfcGVy
X3RjKCkgY2hlY2sgdGhpcyBjYXNlLiBTbyBwbGVhc2UgcHJvdmlkZSB0aGUgc3RlcHMuDQoNCj4g
DQo+IEZpeCB0aGlzIGJ5Og0KPiAxLiBVcGRhdGluZyBkY2JfZndkX3RjX21hc2sgYWZ0ZXIgcG9y
dCBEQ0IgcmVjb25maWd1cmF0aW9uIHVzaW5nIHRoZQ0KPiAgICB1c2VyIHJlcXVlc3RlZCBudW1f
dGNzIHZhbHVlLCBzbyBmd2RfY29uZmlnX3NldHVwKCkgc2VlcyB0aGUgY29ycmVjdA0KPiAgICBt
YXNrLg0KPiAyLiBFeHRlbmRpbmcgdGhlIGV4aXN0aW5nIHBvb2wgZ3VhcmQgdG8gYWxzbyBjaGVj
ayBUWCBxdWV1ZSBjb3VudHMuDQo+IDMuIEFkZGluZyBhIGRlZmVuc2l2ZSBicmVhayBhZnRlciB0
aGUgZGl2aXNpb24gYnkgZGNiX2Z3ZF90Y19jb3JlcyB0bw0KPiAgICBjYXRjaCBpbnRlZ2VyIHRy
dW5jYXRpb24gdG8gemVyby4NCj4gDQo+IEZpeGVzOiAwZWNiZjkzZjUwMDEgKCJhcHAvdGVzdHBt
ZDogYWRkIGNvbW1hbmQgdG8gZGlzYWJsZSBEQ0IiKQ0KPiBDYzogc3RhYmxlQGRwZGsub3JnDQo+
IA0KPiBTaWduZWQtb2ZmLWJ5OiBUYWxsdXJpIENoYWl0YW55YWJhYnUgDQo+IDxjaGFpdGFueWFi
YWJ1eC50YWxsdXJpQGludGVsLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogU2hhaXEgV2FuaSA8c2hh
aXEud2FuaUBpbnRlbC5jb20+DQo+IC0tLQ0K
