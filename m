Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 324C1CD6E68
	for <dpdk-dev@archiver.kernel.org>; Tue,  2 Jun 2026 17:11:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 78795402AB;
	Tue,  2 Jun 2026 19:11:55 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTP id 641CE402A9
 for <dev@dpdk.org>; Tue,  2 Jun 2026 19:11:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1780420314; x=1811956314;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=LQe/3DySP9oCE+g5oPCZpD+GRL5Y810if90uGeLqhVM=;
 b=ZedlIM/RxssCc05joON/F0nPEH+2u31OJLq2Syahmpf21uBVNPPM+Dqa
 efmMdWbSu0kKEsyn+ve/XtfpdzkzvewtYgTXFW7zcSUxbrmkh85VI+Tub
 1waMmsxNafUrUg+MainePjQqh8uY/gp+ruuhAgmGCSZbJd6fg/+bBw/Uv
 FaFxbTVoAnzHHCLME4o3sKUXPMeDca4UtR+Z079rxt7yLsbAdhid4RCy5
 jRsirWq8o3bpTRuNdcfeXkjwNuWFSCE/9ll5684mbKpi/8GpF+bTHjZ2r
 LrfD+sAV+pq9LOJ2qLw3T9d2gNtEdwVbFITgem8xs3Qqjqrb/jtJoSLGO g==;
X-CSE-ConnectionGUID: OmQ3IibzTrS8Ec4Qrb0g6Q==
X-CSE-MsgGUID: vP7Kw0RUSfuT/cZyasN5bg==
X-IronPort-AV: E=McAfee;i="6800,10657,11805"; a="91521436"
X-IronPort-AV: E=Sophos;i="6.24,183,1774335600"; d="scan'208";a="91521436"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jun 2026 10:11:53 -0700
X-CSE-ConnectionGUID: mH9JAQIZRbqcRvhK4v15KA==
X-CSE-MsgGUID: lLNReJ6wQ7WlnWVENpUX5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,183,1774335600"; d="scan'208";a="239523428"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jun 2026 10:11:52 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 2 Jun 2026 10:11:51 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 2 Jun 2026 10:11:51 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.36) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 2 Jun 2026 10:11:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BaHvi5nFYS5ZwvKwM1oNik9URhHcwPZTp/cMynXaC9/oj7KSVaq9JLYk6aWgN+I40XaGVvRjOT7w095raoUBBkslpUfIFB8xby6PTGDyLHEyztwfnyNWD/b2vPi+mUqt87fyFj2/AxFjKbESlzWibQUZdGGlNJGznlXd8kWZCtDNW0xiTYgQWWFl9kGtgGGF680BXedvhNlTzmMO8Bm9PnENz+reygsMj+4wI2AogDRJOgw8XGo0G0qaQml4libc4pB1CU1uKg1dXslGOQnx67MEoBatXpjqTU3ad+p8gNgHa1Ujy4MRSGF6DktKhAx1x2f6O4/vDaGLGBAUcXixbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LQe/3DySP9oCE+g5oPCZpD+GRL5Y810if90uGeLqhVM=;
 b=A/RLrUPjus2Fe3VlcVS++ryRv3l9lQYEe0q6apSLdg/qVX5HlzieIrCLWXHyrHHX0OvkpSdOvmo33C9/44t9dNsqbfc12PpM5bWq+4TwQFEvKJq+bj15BzItxy2l2E0W4InryNyjYsDY2E9j/FiXTY23eEc7MyQygSJyOvWNZpviZWSk8MR1GGJjndTQMt4UQ64+sWcys8gGynqrXuaDhQXzoOyOvS/nKtu9iP8sA/kRAlmY7SVlP0BCiV4astqoKQvOjB5A1gZf9xs6BQyXNJt9AyRRuDx1jPma6n7n5ZdIGmvnpxIK+7fxhBdIO0vzZ/6QFuHFJ3G21WbQe05esA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW4PR11MB5892.namprd11.prod.outlook.com (2603:10b6:303:16a::16)
 by DS0PR11MB6520.namprd11.prod.outlook.com (2603:10b6:8:d0::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Tue, 2 Jun 2026
 17:11:47 +0000
Received: from MW4PR11MB5892.namprd11.prod.outlook.com
 ([fe80::d917:88c1:d478:1857]) by MW4PR11MB5892.namprd11.prod.outlook.com
 ([fe80::d917:88c1:d478:1857%7]) with mapi id 15.21.0092.006; Tue, 2 Jun 2026
 17:11:47 +0000
From: "Ajmera, Megha" <megha.ajmera@intel.com>
To: Konstantin Ananyev <konstantin.ananyev@huawei.com>, Stephen Hemminger
 <stephen@networkplumber.org>
CC: "Richardson, Bruce" <bruce.richardson@intel.com>, "Dumitrescu, Cristian"
 <cristian.dumitrescu@intel.com>, "Shetty, Praveen"
 <praveen.shetty@intel.com>, "Singh, Aman Deep" <aman.deep.singh@intel.com>,
 "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [PATCH v2] app/test-pmd: add generic PROG action parser support
Thread-Topic: [PATCH v2] app/test-pmd: add generic PROG action parser support
Thread-Index: AQHc7UUE7t08lSBRb06Wxz6MeEO5F7YhmRSQgAAqm4CAB2Co4IABxecAgACgIQA=
Date: Tue, 2 Jun 2026 17:11:47 +0000
Message-ID: <MW4PR11MB589283F734826ED3A83EBC9B97122@MW4PR11MB5892.namprd11.prod.outlook.com>
References: <20260521055612.508916-1-megha.ajmera@intel.com>
 <20260521101354.726240-1-megha.ajmera@intel.com>
 <20260526122218.1c29d917@phoenix.local>
 <MW4PR11MB5892D90B2AF860214FB57F4D97082@MW4PR11MB5892.namprd11.prod.outlook.com>
 <03ab65f8b69a4018aad7afcc88f337e1@huawei.com>
 <MW4PR11MB589273F3A331E94D0876900D97152@MW4PR11MB5892.namprd11.prod.outlook.com>
 <c16b1b4c36184e14bb5dc335a405e557@huawei.com>
In-Reply-To: <c16b1b4c36184e14bb5dc335a405e557@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR11MB5892:EE_|DS0PR11MB6520:EE_
x-ms-office365-filtering-correlation-id: ac60b938-fcae-4fba-1bad-08dec0ca0777
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700021|56012099006|11063799006|4143699003|22082099003|18002099003;
x-microsoft-antispam-message-info: cMecehgqlZ7uzKVt6BJVso/JawG35EdVAjc/6VLOqEMqN/s2R8PzKsitynQ+tNHRaY/lX9G1WYZze/q3YbuDi3bXuCrLV7pnrFhN713r4q9NQMg5M2wgCR0fmM8IZmVVowN1RVPCKKRu1arvCnvr9xKpPTy+iyJtN3AoU4bFzKVe22J8L47GaacnEg84PlZ2FjaqzpY9YW0PUAKhmjcmT7nuAySxLHz9n7Qe2ErpiWwQsMjHQNqJ5bvkaeWaOBK+9FM50VdpVPXvMrq+gbbQ9Ad/IdYKj1XfT3VCXgc2IvKSLz07ixCdFMbdH6C2PaxyFBdVSgcHfLjjWnJJgZh2h1fUhOJF87aMezV8PEWyp0zz+P/jmY0kD8ujwZd3Tvj/UwbkTZwgRg1Q5r6iPPcfNx+zWDSVgLBUnjdEoc5KO+T3MgdeeWsbrCFuVJMtY5hyCEyV11KlviDKrBM6Zlzs9/dyJEvRxRQ6GzQDc3xY51pAwlBdPjunYI4WiTxT2hnaDW/gp+Puo6ooYLDRghjKld88mqyBjNmLfmFd2gcA5c0LnUh1HsRKsZOaiX7UVbJNHlKCGr/AWCHfr52noO6UCHhm34hPWwfzD7Hj2zEqb0LosKOGBMh66EjWCBdjzLCIdOLqXotJxZsAj4VbKfmGAi/LBlf5fL8487z/kw9hRxCYjJxhkoBRaQ0Apr+VxkOJD/pzFWZnv65dVMmkaUgdwiPUURry+kuAZfUJq6A7YvEh6k3v3KFbFGUUxnK9DsUW
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR11MB5892.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?QhBo2WApmySkV5OAnjgNx5dM7Bac7NtsiUcVBesDiX1X5C/BK1nxx80noTqR?=
 =?us-ascii?Q?zUeo0vn0F+OHHZe7G5wRmXZVW6NSCPcmWBDOKaogdIypAMpLKPiiwRzv5jDE?=
 =?us-ascii?Q?evp/BDbaEQUhtzEgf/5btlGNPGqgOsMUPS80N6BZe0BlQc674B3C7Jdpe0+G?=
 =?us-ascii?Q?AKPHRqHNfsYUhB5dp88vSSzvfxjyFZdwk6U/2UUP0g+HlNPJYCpeQ6Qaqr1K?=
 =?us-ascii?Q?TFVoY/ztr0t6P2U7OvOKB6sILLpjtVjY1hrwmB0bhLLCXNtKOsR2A+Iq2msC?=
 =?us-ascii?Q?upEM7b1GW8qKZobxGJDMd+GxOkKTJGrtazHMgnyisZxWhNVnO5U7UtPjyzP1?=
 =?us-ascii?Q?PN8P73M9xBYq2AAOoTGSXmR2I+9Bwip5qxuvq6fkjsBzzmzJjn5jePvR704M?=
 =?us-ascii?Q?x3AC/mP+z7H2vCarEtG7aJW5R7FvDt8L4lMDA4Vh1XCEzyQN5wz38rBH9m1S?=
 =?us-ascii?Q?v8L5OLAQTgiMaG8wQiKGrSQuNnU+P1mpMOClYP5VeCj8lSoHAFKM6DQOL8f/?=
 =?us-ascii?Q?SAawOv0DjaWIMUelKWTR30pbDRCA8KwhJrC/WDilnThuQk63vAh0VTlkgf/W?=
 =?us-ascii?Q?HrDe4aVYvfhJJ/YpiyvPlcpFieGgqAI1YMjEqNXCEjVLn/qzPKRvLM9HSgWs?=
 =?us-ascii?Q?mbNb6WawJZ84a38nHkdbW8fuVLqrQHfe3nd7wlVWhic01ZBqkFa+Y38dEbDZ?=
 =?us-ascii?Q?PRLEx7vppxS1tdwaPWNhsbbV2G51qDibgPv3BtzU6nB6ubXbjbbOqxq/oTOZ?=
 =?us-ascii?Q?M9DxUp5kkGNxL29rIsuFWpaaTSDNeuChaq7m8VI0qNoBNP3DbXKHRRgb4vY2?=
 =?us-ascii?Q?6hnOKjJMSD942DAW/Coqx0b3gPWWa9HGYXZQatY3P6kULsKKlzTL5yjwh1kc?=
 =?us-ascii?Q?3r+oC8H1k9ukcR92WH/QCoeRo8NfkcSJ75/AMwYUnInthhexF7WZ56XwaPSO?=
 =?us-ascii?Q?xG1NfyFIO6m6SlFyT8/pR3hKW0vZ+YYW7m6l/oWFfKShaDehYJP9H9BL/gcz?=
 =?us-ascii?Q?Gapd7MMsWetZgZByHZuDl+ITujau/qNIuKH3LfzYpO1dhChXLGHbEMEZ0aDd?=
 =?us-ascii?Q?hJuPpZoiDK4Wrgrmcf3/3wxnmM7inEyxMgK+QBWlhmi9khTKUKifmUddYo0+?=
 =?us-ascii?Q?7hsc3OfZbIS9UxWKon41SsbBRmXv0ZTGMdpMD/+nTi53r7Yfj5DIHTRZq87G?=
 =?us-ascii?Q?uYwehOTGJln9KMFSPTYbdG/Tw1bnJqWFNskm3LPn+NExgtzfuZvahWeXIR2S?=
 =?us-ascii?Q?wexsDx0Yx52mWpiPdlSO1EUgsOyJhHNjNas3gHyRvIJyUZUJz6hirHFz069L?=
 =?us-ascii?Q?fW6X7dzGBqAQxGRh1XUqhYh9A/xAe/t6qBnK7hD8auY6tw9JRkVFSFLK0Fby?=
 =?us-ascii?Q?/uEMNeAAco6t2VBG+LhV6CFgtayltMxvOiAd/7iOnQUumpe0TcNhJUu3Xhej?=
 =?us-ascii?Q?9sBjWVohLoamweymQxtSqt8B3L4pioA3e6K4/sbuzkkwTrKuy0FGTErnV4QM?=
 =?us-ascii?Q?25uSYhOo4eLzs++cNSVZSP/8a4pTxY1ukHA5/owlyJ9U1+GNMWnmKqbgDTiJ?=
 =?us-ascii?Q?um47PLQPnQnxCl5tIumliLSS5oEB5ZFcBRxth7/JEWC4xRGQpKjo3syYHQ+d?=
 =?us-ascii?Q?PxF7gk6VDPk8KdpeJPjEVzWuQeLVCvF4B8G0p8jU1EXaUJlbyIirGx3ckjvg?=
 =?us-ascii?Q?lwobfXeKfMJhQ9yWzIbLOy+c1949SRUxHnpzJfFAem2QP4dwHe4HTKz3VCNv?=
 =?us-ascii?Q?bh6OAKDCsg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: h0Ec1W5Bn3YYiGxAVLZARm5VVM2+wpcGsDi1d3VUTLgbupEuX/5iCsFyFDuGxhFCUWizzYNatJx4fPwQpSn6ivjAJP8Ls3sSuAJX8IQKBmkzo94FonutUlS6wBdq2cLbwU5g8gcqZ+QXByToMANsilH/BcC1OSuX/x2OfXHm4CwVWOtbBRclycCBMrRtL9noFT/u/FU1j4/TwFehRNY7EDZYpv2D1FbX/VN+96gwWyXpznZEiJ1Pb4nOZbFXfU8SRJz0U4lo9CJK3/xPmGaw9oVSReSMgi7fTboBCth/XgmJoy5KB/J1MBW3RrXnc/gXwoJyKFXfzPqfFeBMuUSLww==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5892.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac60b938-fcae-4fba-1bad-08dec0ca0777
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2026 17:11:47.3742 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 03g1xMEom5kJYmFK8zmzdDPyWPh0iZbufqasqS1e01jo6am79qjxOIlLU0YkLDyuvKWkuOpOT6HyKlUGSRVMxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6520
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
> Ok, so it is predefined by the FW.
> Then shouldn't CPFL PG contain a list of supported PROGs and their argume=
nts?
> Again, some tests/examples for it with testpmd/DTS.
> Or that's all will be the next step (patch-series)?
>=20
For now, this can be independent patch since it only enable parsing in test=
-pmd.
With this change one can use and test PROG actions for PMDs.=20
