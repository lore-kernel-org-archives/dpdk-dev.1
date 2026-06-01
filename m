Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E03ECD6E4C
	for <dpdk-dev@archiver.kernel.org>; Mon,  1 Jun 2026 04:33:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8AA1340264;
	Mon,  1 Jun 2026 06:33:55 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by mails.dpdk.org (Postfix) with ESMTP id 75A0D4025F
 for <dev@dpdk.org>; Mon,  1 Jun 2026 06:33:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1780288434; x=1811824434;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=8Yfcxs0wbAMGuw0xcXmcK4T/FX1QnUUF1n0fi9C3nlo=;
 b=XZN8hKIsT3tbCwruu3IeiLD8X87/DBy6moJCEv0itMXQW2Kaa+D59quY
 1GO+6TNUypzn3/KuqxSimvnyvdcmIjPzFyt3y6SFST96Su7wqhwXRkOVL
 L8WTm4D9C1EyoCRxQ02Bi1K4kP4A6wac2n0ByrqSnCJPmxB3gF2kOV4GC
 ueDGsqQL96KEtlDU5nwqEfBmQvQto7Da7AifLp0UVfN2qHwZLZa0fgShC
 8rFhulx4rI5EMHybc0x433UuJ46jmEieSu5gT3CaV10Tn/grKmBeR5fqF
 ArEB5KPvr9Lo1Pv+KB7qQDKo8jA+0AkLrGMcF0C9pfouNWbKczUPbtiW9 A==;
X-CSE-ConnectionGUID: jJiyA9mvTAqZ1Ey52AxlIw==
X-CSE-MsgGUID: svCJyP9UQvGJFkXfXbfZwQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11803"; a="80770370"
X-IronPort-AV: E=Sophos;i="6.24,180,1774335600"; d="scan'208";a="80770370"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 May 2026 21:33:53 -0700
X-CSE-ConnectionGUID: /cyYS/QKR2GziKxejWZfRA==
X-CSE-MsgGUID: 3LkbdQszTlGxc2g87YiRVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,180,1774335600"; d="scan'208";a="242644660"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 May 2026 21:33:53 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 31 May 2026 21:33:51 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Sun, 31 May 2026 21:33:51 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.53) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 31 May 2026 21:33:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JTKqeiFf014j4EOrsJXvEjcpOisQiZ6OKwUprfrtfa95cYv2lxudZYYaa7/EW+ZkD05ibAyp5NEUwX7t+WllDqT7WU2dmdlEl+Dmtbaukdf8kQTzumg8zIDiQEzrPM1MJrcqeWfkdK7+9OWxfB3oBfd3T+zNBA3oXQ23kekTgFp+jinfuNlr5uJYDa/dD/mnTxPWS8qh3IqDXYeh4/KZJhI5CDet1Gc0wkw0/YGZ933NgaMdLW1i1Ddf1RUKYTCb7V6kfcsIiP2YDuYF0+N6A5oT33XNyzOyZx+lQP+lgFPesQVeeORSCJUFco85YzhPTchEjWHf53ztSJ8Kk3HnYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Yfcxs0wbAMGuw0xcXmcK4T/FX1QnUUF1n0fi9C3nlo=;
 b=n1w4Mw9oN5LYEGEOCVisXSAldshGemd3nqYrHVXp/45UJIYjhwfQYN6Msdo69akmNut/NgDOxZ+sWHt3OchMrWbFZ/5QgBaggNMDzUXdUI/4ipx6nSJgT2GGJVmj4vdmr4Vi9n/X9Z7wFdjcMBwWGUueTLlmItnKpg0LRdp0KkQ1FzKzL0JCXcnj2xRNcaZbQ/VADEv05HyObD4MtTLMHMNXz4J0Fm+BjFt19sP2a01LQLmbq3RSE5UsEcqJd55n1simxtqhD1JMVMLa9+hSBsMXKmYZNR5DWGIikfsar24vyeXSexYx76szW4jHQpiINCBAU0EU9hMgKNO8lyrplQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW4PR11MB5892.namprd11.prod.outlook.com (2603:10b6:303:16a::16)
 by CH3PR11MB8210.namprd11.prod.outlook.com (2603:10b6:610:163::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Mon, 1 Jun 2026
 04:33:42 +0000
Received: from MW4PR11MB5892.namprd11.prod.outlook.com
 ([fe80::d917:88c1:d478:1857]) by MW4PR11MB5892.namprd11.prod.outlook.com
 ([fe80::d917:88c1:d478:1857%7]) with mapi id 15.21.0071.015; Mon, 1 Jun 2026
 04:33:42 +0000
From: "Ajmera, Megha" <megha.ajmera@intel.com>
To: Konstantin Ananyev <konstantin.ananyev@huawei.com>, Stephen Hemminger
 <stephen@networkplumber.org>
CC: "Richardson, Bruce" <bruce.richardson@intel.com>, "Dumitrescu, Cristian"
 <cristian.dumitrescu@intel.com>, "Shetty, Praveen"
 <praveen.shetty@intel.com>, "Singh, Aman Deep" <aman.deep.singh@intel.com>,
 "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [PATCH v2] app/test-pmd: add generic PROG action parser support
Thread-Topic: [PATCH v2] app/test-pmd: add generic PROG action parser support
Thread-Index: AQHc7UUE7t08lSBRb06Wxz6MeEO5F7YhmRSQgAAqm4CAB2Co4A==
Date: Mon, 1 Jun 2026 04:33:42 +0000
Message-ID: <MW4PR11MB589273F3A331E94D0876900D97152@MW4PR11MB5892.namprd11.prod.outlook.com>
References: <20260521055612.508916-1-megha.ajmera@intel.com>
 <20260521101354.726240-1-megha.ajmera@intel.com>
 <20260526122218.1c29d917@phoenix.local>
 <MW4PR11MB5892D90B2AF860214FB57F4D97082@MW4PR11MB5892.namprd11.prod.outlook.com>
 <03ab65f8b69a4018aad7afcc88f337e1@huawei.com>
In-Reply-To: <03ab65f8b69a4018aad7afcc88f337e1@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR11MB5892:EE_|CH3PR11MB8210:EE_
x-ms-office365-filtering-correlation-id: 6f7dc29f-c6a9-425e-6bf9-08debf96f5e0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|6133799003|22082099003|18002099003|4143699003|11063799006|56012099006|38070700021;
x-microsoft-antispam-message-info: y5durazmLwhC2DoyWf+o/KKpKCid1wjr4/eGTLb8ftQgaDl0T+UnRlrQmA2raNfABH8sLtm4IMCKAHYt1OF3pP86PD3POoPPAZ8/+02/pNJ6cA9FfYg/4TERMBF3iuK5r5UX5/pZu6UMyOXbn8dxg6Re7oScwLkAP+YROzflPNJF+3zRz+gBizPCP5QoF8iA3JWy2gaQQQX58jfS0NYNndr5Vs9m2sMwowl7OheN/jNzeeZ8b8lCPHYXxuRUe4AtJ2QzSQFTz845PvlS6I1j4c/YvoBcsJBDBCC0zdfPSOiHEcPqmZ7SDwSOXD3fEXL8EaQVZvYXaiXYfJWaVQ57YcYzlx5cOLRc7hhwa4bVxpYLwgouL2ucn3PD7mBD1pb61x69VQZ6fDUNIYZtbgbwWLDpzRPYCDbS0g+A0TjvpVAZcm3MJPzA6oms4N3Xy/cDexwjLwkdGVMC/PFQEe+OUbGvsJeWNZ7C8Jyku17c4SwmSgcbmWX9sQtB+dkhli0VpNBlFyoWKVwEVpEvsBIeb2AqZJR94Pv3SU8e0/DdccrX028PsRAd8DXemrMy9ASSt/nNQVvnrHmTZMz761opwBhquE+mSWj5wRHgn9FYv2EvhlChDcp+3K/KNthD+4cRafnZiMQJFO9qapdA/PPl+bGNYLSh563vFLMYSkGEjsaCu0mY44ZLo79352zun8dPzj9N0lorLSIcB8sLXHgfNv4Xpj1Ub5CO6/WXDgAF42IgN0oD3jmI650+Ruzb9e/g
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR11MB5892.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(6133799003)(22082099003)(18002099003)(4143699003)(11063799006)(56012099006)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?sXZxa9wQbT0P0T1agW9cQZLUogdayGY9u6vYQjfKoqR+rnX/dHya2MdCByq1?=
 =?us-ascii?Q?47wCI4vQqxis5U0iY7AElAANLMyC02ur0c/hfCBlh3GdwwI6NTQY3sars6ao?=
 =?us-ascii?Q?cKjLzQyKMN0+ZANtSPQnR3uNfncht3c3n4tDew3jkzSSk5P7uL9Hfm08cROa?=
 =?us-ascii?Q?2cZOLhmxVEhY6l5e0gRg486/C8S0dAqKHEg2F8j3y4tQUpxR10MPnzbCSvWq?=
 =?us-ascii?Q?F0XrA5WQZiE7TKmskZFcmW9GehwsW8UWvvzk08D/D2LgMTKA/IbNvH18P3V9?=
 =?us-ascii?Q?9eMuLs7gyg3acinJ2oYmEloLn3X5S0eDQke3oJ2ou7GiWN53L3UlW/ddG4R9?=
 =?us-ascii?Q?TUtptC4xAY82iq1f7AmuGem7+fR2/oo1A3ZV571dAGT3TJyv0HJASsedF0lt?=
 =?us-ascii?Q?GX5NcglAFnVblSUxZl9c3lN3JeOLRDiXOn8AHQjLxX5cHi9FZ5gSCRyrNW+9?=
 =?us-ascii?Q?WXbhS8Vtld0rfxX1Slr72F7A/cBeFnbOF1X8xHwWVdcmCQ6VM1PtS1PN4/t1?=
 =?us-ascii?Q?ggvLBPPFsBi8xBteoTLI9NgFjJ90SsesgsmVACc1wXaGm7QTZ0FK2qrMDNZM?=
 =?us-ascii?Q?4OQK6CtwQvw3n4rjd0vqDGiw3v+aDjr9FMxIAkbFbECmcgvgDtgLfj7pxhrQ?=
 =?us-ascii?Q?B/YwGcBPb7f++EeoPOvoUQzU5dTJynbshL1qOmPz2bt30+yhUBlEYLg1C0rA?=
 =?us-ascii?Q?9ieubpehTShQ95sGnwtCHy3y4aGmW39dsiL8wMvSElQHRdMhRxeZgzCHynGG?=
 =?us-ascii?Q?RApwb2ylmeEzTNdeMWswrEB3oe9XIFBo2blJuE1T3Jwy1FVKBvIBAav9oMWR?=
 =?us-ascii?Q?j9i6cMXxXAStqntA478Qtxc2uUoBiUmA/sh62p8YG9Bq0KSZfKO0pixLLA4t?=
 =?us-ascii?Q?94RugH4Z/lxnB2mjt+cHTwi2L6iCjJRWmdcJNnWNC7ipReTlD/uvYlSupP3+?=
 =?us-ascii?Q?xiIBtvgpR8sUR282ImElxlg24XOfj89ks2fwOsF7CUwv8iN48yIiBBJ3dy1N?=
 =?us-ascii?Q?86g4vxc5BVGgtCOTlGcfFyde1C77bzrVilqj+308rgFFFnuCaZJjaANmf2Aa?=
 =?us-ascii?Q?pVX9w5eYPHopyd9aE6oeO/RfOgEis5/MJnILJ6TxtHOjTiQIPZpXIKPhXT7m?=
 =?us-ascii?Q?/vB2FQtxMtjH8++LIZ9jREgUMiguP2mNDKVnGKNxd6/Gu6rqrAbv0OcyhoOs?=
 =?us-ascii?Q?56DR49BqVftCD76baaOHCQmWfiDbuvpLd2NpCqUHSwOBI6L0B6r8mdcoI84h?=
 =?us-ascii?Q?nxeIsuaHdafFCljOC5ZfmMlXwlJ8FpPEF3k6htfULFT3pjYMuOGq9SUne+Tm?=
 =?us-ascii?Q?xf/VbXKyLwGoAeVZhPwHfdoqW6yTC5vDNhFKGKwAcGTRZto8lUj5zZztFYkZ?=
 =?us-ascii?Q?oszK1UyZ0CUOyYEvzhJVPtoQr1pfDED9Yfs2m4F/6+U/mtKXIIJnxqK0FmKL?=
 =?us-ascii?Q?JxSxwG5IGLx/GladzJh06XIUnB97eFonE1UTFfaf2Io9kmQWjiuOyrWe2xG/?=
 =?us-ascii?Q?+9pdPLt2XHSawB5dsslhu73G8eeZjAguQCfQ4Ed3eE36U4SpN85ZLSY4Lulk?=
 =?us-ascii?Q?C7pmA4EKms8H3K8okSiAZWZ0lowCkP4DGth5okDsyDBK/iqXh6u1QzRz89/I?=
 =?us-ascii?Q?ohIAX50kVTEO+rRSQBKlpYfcpFoKqXH7ck1qluFuQ5X9L/OBG4P9QygwcOEX?=
 =?us-ascii?Q?5krTy5Disb53lXTWxl12G0/Bmy4G6F/+zoojxO2S3DWLuqcW/OMKWiOUQRV0?=
 =?us-ascii?Q?o0KyPFqaBQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: r55cw4RQ9kgnPff+JJ0H6mcUISXhCb4tCh6CI7CsK693GH/R7lv8Wd02rYekDUIHo7dEJ1JKRDc5Qcy8pUDoL2HyDJRIsAF5F3JGhC2uI4DbXUKi5yiBQV5n2wEj05NfhAIY7cLSvvOk+WkJ48PEnwl4HMNHfyrZ1GwC/E8/G8tLuIRzagSgIIhHnoDvPrs8Cnz1yfrLzqpKeAA7atW+nCmbBPEQ2mjH5kpCAPaLBNSa4HmTPeAxzkCayBRlG+g32mbB/WaXlNKeG6cFgQMfBHFRdF3wl8YX01hBVVX9iDTSQH3r8i1Egx/xJeBDhBw4HzRjcHxAg6G0jw5SEYexig==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5892.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f7dc29f-c6a9-425e-6bf9-08debf96f5e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2026 04:33:42.4291 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qOQJ5zJaF9okHDBBQ8S+d2gvWNAb1seGXNih6GI2U1LsfM06pLkMZabpuLNpzolT0EWPJIvJ+teMqrW8l1R4Vg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8210
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

>=20
> For my own curiosity: how user can define his own PROG action?
> Is it supposed to be programmed and uplodaded to the NIC by some external=
 tool
> (P4 compiler)?
> Or does it refer to the set of some predefined functions that given firmw=
are
> supports?
> Or ... ?
> Sorry for probably naive questions, but I found is nearly zero informatio=
n inside
> DPDK docs about how PROG action supposed to work.

PROG in rte_flow is currently a vendor-defined action interface (name + arg=
uments), not a generic DPDK programming model by itself.

So in practice:

1. DPDK/testpmd does not define or upload user code to NIC on its own.
2. testpmd just passes the prog name/argument/payload to the PMD via rte_fl=
ow.
3. What that name/arguments means is NIC/firmware specific.
4. Depending on device support, it may map to predefined firmware-exposed f=
unctions
5. If the PMD/firmware does not recognize it, flow validate/create will fai=
l.
