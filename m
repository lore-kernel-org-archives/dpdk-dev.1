Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEA62CAC5B0
	for <dpdk-dev@archiver.kernel.org>; Fri,  3 Oct 2025 10:29:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 192874028B;
	Fri,  3 Oct 2025 12:29:27 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by mails.dpdk.org (Postfix) with ESMTP id 2049C40262;
 Fri,  3 Oct 2025 12:29:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1759487365; x=1791023365;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=sJJ3oQb2A+GB/4N+DHitCyYyOY+INe8WGC3xhIbW7ok=;
 b=U3Nmyl5mw0n9MoMHzajbmo+4POZWAdLCEZ5jPabRUdhCa9mkehlr2zn3
 /IRsEL8gMwKg3+hacZ/Da0wFVAI+Ud8oJ8wlxDcS+/hY4YKdBih8FQUaO
 7Pc49AN9EspWwHZbP4+iRXPiVQ8FrZ+sccn1nxOsEn3zoi7RNROZSnM3C
 H6q6rGfYHLPAzV3UL3HmOiNnnt1KHT6v9iJJ7CjerNu5cXS9L9yreKeEp
 rDx9x9AvkI7349WmIrZhSp+CMj27U61tgllK0WAZay28l2C/sjynyi5Dx
 JuuYTPdsod49ZZguDx1RyL2Hso/iwDjGQgPgWxMdGeLsGG6Xn0bhGqXXN g==;
X-CSE-ConnectionGUID: j5UPB+wJQUiGKKwtVAGVeQ==
X-CSE-MsgGUID: w/McGNEISMCrYfNpw4cv2w==
X-IronPort-AV: E=McAfee;i="6800,10657,11570"; a="72387578"
X-IronPort-AV: E=Sophos;i="6.18,312,1751266800"; d="scan'208";a="72387578"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Oct 2025 03:29:21 -0700
X-CSE-ConnectionGUID: A+bVGHo/SauX0BY00rslVQ==
X-CSE-MsgGUID: kgVzPBspTLCfXE4roAVrKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,312,1751266800"; d="scan'208";a="179696027"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Oct 2025 03:29:21 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 3 Oct 2025 03:29:20 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Fri, 3 Oct 2025 03:29:20 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.50) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 3 Oct 2025 03:29:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lyFEBx9IntWY+Bp155jR0vbHvs1mx8VIPqKlkKfSnFE4OGTgEM3C85cUwWwnlASCBDRuXangi/3WfC/mWESr6ssXGjMszMbvglQsTlCB/9j7w3KPY7jHi7/7SSlmV5hognf/da8Q/UeqXZaWFU7wCa1xqcukYNcTMMIT6emqj4sTnEgndRMXqx+8uyu+OcJcP+YsijAdJUIPloTdUtsL5J1l1h7JHRqfTRViJfE6jNrR/oMx/9j78UiZkQxfhVMhmg0rGcSECRVr7TVXgpeIaUpC1XYdeGiVPEBEY9svi0ijo6p+L2y8ExgFFHZ/SnQAwMnjtjiBr4/ppXbPDluoxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2v20yMv05w+qEg3vpG5wxXi/cmnRSL3wyhqgGWXHMY4=;
 b=coDE349+yQlAXGrGtVAM7efsEy/vQoq0ABtIfCJoMKB913teJOoonX5FPUc25eHCflh+Z7ZXOBgEhsecQLU+FlT+f73uRaHulJFCOXlI0iAA6xsVfoFAaROSrVrEZ1Cq1mCb359ir5EAS4d3ORyuskjFjezbdkUG98l/8hJcgWIv87xoZrzpzUgAReOeR4FXj9/DK+cQwHQ/BF9ZOY893PzHyz56TjCxUD1UYwtbkWSifltGOjysA6oxA+JW4ybuUZTWaGkoAdLouEeVo0ihD3YieJ5G93pfzUI8+IorK/0DR1isJsKokWTgM2WwfjPj6X6d8nZ/i0rohrj8xqk2Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM3PPF7D18F34A1.namprd11.prod.outlook.com
 (2603:10b6:f:fc00::f32) by PH7PR11MB8010.namprd11.prod.outlook.com
 (2603:10b6:510:249::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.16; Fri, 3 Oct
 2025 10:29:13 +0000
Received: from DM3PPF7D18F34A1.namprd11.prod.outlook.com
 ([fe80::e891:61bf:88e7:bd9c]) by DM3PPF7D18F34A1.namprd11.prod.outlook.com
 ([fe80::e891:61bf:88e7:bd9c%8]) with mapi id 15.20.9137.018; Fri, 3 Oct 2025
 10:29:13 +0000
From: "Loftus, Ciara" <ciara.loftus@intel.com>
To: "Richardson, Bruce" <bruce.richardson@intel.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "Miskell, Timothy"
 <timothy.miskell@intel.com>, "techboard@dpdk.org" <techboard@dpdk.org>
Subject: RE: [PATCH 1/2] net/iavf: support VF initiated resets
Thread-Topic: [PATCH 1/2] net/iavf: support VF initiated resets
Thread-Index: AQHcMU3AqHIGIyG6mU6GyIhfLzcII7SrcJsAgAGJkoCAA0L78A==
Date: Fri, 3 Oct 2025 10:29:12 +0000
Message-ID: <DM3PPF7D18F34A1B51E203D4A7A495540958EE4A@DM3PPF7D18F34A1.namprd11.prod.outlook.com>
References: <20250929143039.547207-1-ciara.loftus@intel.com>
 <aNudwFx7CPH3vWot@bricha3-mobl1.ger.corp.intel.com>
 <DM3PPF7D18F34A105FE85AAA7D7387DDD838EE6A@DM3PPF7D18F34A1.namprd11.prod.outlook.com>
In-Reply-To: <DM3PPF7D18F34A105FE85AAA7D7387DDD838EE6A@DM3PPF7D18F34A1.namprd11.prod.outlook.com>
Accept-Language: en-IE, en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PPF7D18F34A1:EE_|PH7PR11MB8010:EE_
x-ms-office365-filtering-correlation-id: 6bc35a03-80ff-4988-bcd1-08de0267b24d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|10070799003|376014|366016|1800799024|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?pHaZ7VlVb1du+7w3ERBZvVS+JOnlFnt5g+XXXT5ZKr04hoAyG7oogq4fHOgX?=
 =?us-ascii?Q?mfw0I7n5e++JukWSBiu5oAJaHkzfCt6vszie+UE/LU1iq8tXhOUFOBP5Hpup?=
 =?us-ascii?Q?6g6W4xge2h5q3QNwbCKUvbl3wI91xvRrfvhaGvw1yXnhj15aTA/AJMTvToXF?=
 =?us-ascii?Q?Vxpg41qsRUWbD/4rgO/tzI6w/w2z656Ijhmc2qhwkDFT2Nekt6d2l7r78sTZ?=
 =?us-ascii?Q?JvsjNE/ZnOPe/QL+gBLS5B5bqEWRQIUIQRjhQhF5n1pjlp6BjEiT8HCrUwzH?=
 =?us-ascii?Q?yi0ds3nGxM4ohFYSajms9/90zmeXb+t/L5RYjCekZp/0eOEy2+j3kwvOiEOZ?=
 =?us-ascii?Q?otqbPUWOCr9uwxkZiUEkVVIXdXZcZtC6ZLnp9c7L1+LWS17PNxXMHgQKBbX9?=
 =?us-ascii?Q?kxRN5usaaCnxGpD88D51vtnZxGiCYgBPpp1Uf62+l+UCXiO8IPUKlHdenA0h?=
 =?us-ascii?Q?yq1roAWLaKuhXBsFwLy+WBVX3Ng7jnmvBNmO6TBhg661g2gzk1Zw5qyh6+hJ?=
 =?us-ascii?Q?V3QnFqdIATATWiVFGLjFEaKMEzgo+e/gGvfWJY5kO+XfYVh+QnVY3L134lzE?=
 =?us-ascii?Q?csBKejAHCU7UTiEqXiDDkz/0q3G55iTDZ7m1mIhI38aIaIcbEMD7Lh6RJXS0?=
 =?us-ascii?Q?TWhSAX0orarR9+5qknYrDELeMAkUfE9YGnmIKnGr7ytSNKlL1ZcNCDsQVi9Y?=
 =?us-ascii?Q?g0IKdhDhZLYCnABFGpk2FckpejTeUbR8+bjeEJ04xbx2QAbtxQRPLsDgrAn+?=
 =?us-ascii?Q?YB/KjAd+6uHnZ4d3t9bLyjk+yz4ToIvmT98QuXMogQFT0TZ6WoQszY9tM0vW?=
 =?us-ascii?Q?cPQG5clB4eB/4KGmkxS7zhVfmM6sKbnm37RB57v2jYNsgCw51C7scmwmuOCn?=
 =?us-ascii?Q?2eFbOEzMHXQBl6cwCX3Y6Vmm1fqvK6LYWPcMpSsVJuiTnKJFXDnH1OG8KW9n?=
 =?us-ascii?Q?JsQU8NI9HYo0Z7tud8qdb7HD6DM5qumZDB/kHaBjU9lcK+x6R1IlbguZ+unk?=
 =?us-ascii?Q?L1PmED326uBf/gN//OtolmGpuxZa8ffKPnVaMOEJU+mP5d7ijdtKQaNO8vuZ?=
 =?us-ascii?Q?no3DS/NZVkaphEVIcLjtbe2+GEerDihReWjFLrZDdsVSUthn4cpxK1CPSyMM?=
 =?us-ascii?Q?hI4Fze+rmMCuBLAdMl7sOeq0yoOanT5hj3W0DOiZVHv3v2fVqulMA2uxkC/1?=
 =?us-ascii?Q?z5BDIa9TWXqCSfHaI0LERQotrncvSfiofeIgdNrhr5+5XceV1/585xYrFCfk?=
 =?us-ascii?Q?2DSzCrM2FktD++BpFgFMoSn5yKYQ1t8wgk3tNvSBoPRkBUd9W5krvnQ0iAAc?=
 =?us-ascii?Q?S0j2vJm6YeMg6O+S/h4kqbzTsGCULg9FIAaoYYV84It/LnUqvsX19HU53gif?=
 =?us-ascii?Q?2qAU3dsGFnuDtaqdGNYn9yVDxt0kCi+CvK6R3XbKPV+Z9hsnKJpHOEzElScz?=
 =?us-ascii?Q?DsiUFDzElPg2E62hjFukyMLHDlhYuM7GbCC4z1NxTCuXiaq6Gnw0tT9vfghn?=
 =?us-ascii?Q?hKv3wP6ay7fKSXHkXsWBCxuN72qGgPBLKMk9?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM3PPF7D18F34A1.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(376014)(366016)(1800799024)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?SiO3QrdmnUGiPr7XGHnBhHy3LFMjZIdYnJfnPMgHszAuo0evAa0V2oqx5FgJ?=
 =?us-ascii?Q?lTIvm0yzGVvXsvE96YTIrVDUp9uY9qv0EDQ4LA2sBPmaE9HwRsxOVVchsj+L?=
 =?us-ascii?Q?4q4g1PGU6IUIgKEtqE/fPsFpcqa1GUxXdCyr4GmtRItJyme0i6EvfEctU0Ub?=
 =?us-ascii?Q?y2Rno6fJl2zBnHUOwwq9jcxVCPlaD9eOjgYcYRsEPorA1J8MwfLV91iqbbu6?=
 =?us-ascii?Q?rb9/rEiuQAzgGKlSMs9CGF1iXGs24qDexKaZalTwIZd/1GceQhgxm9iMXvz4?=
 =?us-ascii?Q?DLTNtCP2ST5x7nT6wfeBWZiOV03ZJGuZuxxeNNhYFW/HgfaCnwCfVB6AmaBp?=
 =?us-ascii?Q?wKQN/CuS50i2jgQ3+NuACBQwnwSQ8x7x2pKrtvp33YwhOufDEvzsEDHOXTeX?=
 =?us-ascii?Q?w5TXAQGchX1KPPlp89jEX6LTpol01fKdaGILIpVRt1CcH7IvldZLpj51l83m?=
 =?us-ascii?Q?yXWtvOQdhVfV3KnzEud9NxIwF3tG2eGp2FTCjZMox24G+VfRgxjKQLpLEGp/?=
 =?us-ascii?Q?FngaTzSewFQQxuU+crN7RS8G+bJZS+I1xdahQIW6xHYi8/60uD3zQgvKSp72?=
 =?us-ascii?Q?2G7pceX8uF5p8EJfLBE7oeEf07nJmV2R1aWYIZ47lzX2p9oYwumCxHOoFCb5?=
 =?us-ascii?Q?WsjGsL5LVdqEwmnQVDITjTza2IrmgkwQUPz5ejAbXBGt7ZwxeiRPlLz0/cnZ?=
 =?us-ascii?Q?lR881565QjfMN9LEjji47nxWyQ4rViho/KN6VqWupnHqI/YsIdkVVWMtl+zm?=
 =?us-ascii?Q?EACWwFPhZW8IE5cEY5iATFgUWCT3Bz2e+eUxkz1ncDtdzAy3yGVLpazijK88?=
 =?us-ascii?Q?E/MLcmC+SHIqdZI0WamFk7h4aq7nEBRP0h8zxhOK91q7JhuWrGYTmBIw6EJz?=
 =?us-ascii?Q?Ustbko2gdgMV9RVCVOfeqItKIxjZtwrt+apLam/OaRfXdwiC5Vl7MU1zhzcl?=
 =?us-ascii?Q?Bn7deI0jIrL+QYTGU20QAGalmx8RobluCUgyiBCQ2znehzmUKQeD2sDufiyt?=
 =?us-ascii?Q?9sWkU3NrC/VD/Kxsu/hcq/inbu7fXNOmpgWzESqiGEMeN98owXaAh5AE00a9?=
 =?us-ascii?Q?qopUbs2zILb+vNtF19ELFbATzTZ/0Z/oitb6DrwWmVXkdi4Z+YVr0iqyIX13?=
 =?us-ascii?Q?CkiqMH+4VIhg0+2Tv6HiQzTA0toPVdw/K10+a1H7Jxbuxy5ILPWn1SOG2cj3?=
 =?us-ascii?Q?xv2v+dDWo+Cjv7FBx8ZR40xXGJg4mb1xJyH7aOY4nmYERUMI2/8z0A4pBR+Q?=
 =?us-ascii?Q?YfhFVmfDP66RmaRVGJZMW7chf953kVi9w7FDy153ILFXhGJ8lJ55O1pN5h9u?=
 =?us-ascii?Q?gACn5b66UZ4o31LPp7GFaGuxEOdAtT7O2a4NBpjew5Ws8M9cU3uth8YjV+zO?=
 =?us-ascii?Q?HheaTYswCCaznn+g7pceclPC5+dhbDT1BXqRFlmf6MZW2Ymy/LHM5cmR+ur2?=
 =?us-ascii?Q?RPVVc8je6Liu+j7Y8g7s8BZwVPCER6wA86xcUaCzzg4BMmZvokFVVSELLJQE?=
 =?us-ascii?Q?smXjULoXrdo3ZG/MzctcDMN9Ly20Z8s4lMr9VGlrYtz8Rh7BYrh5/bwMhSBl?=
 =?us-ascii?Q?2ocaTlEkp2+CgqOClMiX1epCCUgvokNLvqb8Edp6GBtSluoMcoLrkUjm0qOD?=
 =?us-ascii?Q?QTOaj5p64rr5tmM2gUXsCGbJetYic1zB/YPpG0nk0zEv?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM3PPF7D18F34A1.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bc35a03-80ff-4988-bcd1-08de0267b24d
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2025 10:29:12.9082 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3RWE2FdI8pNe+r4wPVEaJnvQa2bPKr3bhhBlmtjzOUfpYz3zQDIb7UPZpqKgnchOKD1NGNUnYHiT0hkdXbDLFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8010
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
> >
> > On Mon, Sep 29, 2025 at 02:30:38PM +0000, Ciara Loftus wrote:
> > > Introduce a function that allows a VF to request the PF to reset itse=
lf.
> > > This is useful for example when the application detects that one of t=
he
> > > queues have hung or any event where a reset is required and the PF is
> > > unlikely to trigger it.
> > >
> > > Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
> > > Signed-off-by: Timothy Miskell <timothy.miskell@intel.com>
> > > ---
> > >  drivers/net/intel/iavf/iavf.h         |  2 ++
> > >  drivers/net/intel/iavf/iavf_ethdev.c  |  5 ++++
> > >  drivers/net/intel/iavf/iavf_vchnl.c   | 29 +++++++++++++++++++++++
> > >  drivers/net/intel/iavf/meson.build    |  1 +
> > >  drivers/net/intel/iavf/rte_pmd_iavf.c | 33
> > +++++++++++++++++++++++++++
> > >  drivers/net/intel/iavf/rte_pmd_iavf.h | 11 +++++++++
> > >  6 files changed, 81 insertions(+)
> > >  create mode 100644 drivers/net/intel/iavf/rte_pmd_iavf.c
> > >
> > > diff --git a/drivers/net/intel/iavf/iavf.h b/drivers/net/intel/iavf/i=
avf.h
> > > index 435902fbc2..6e7aec1bb1 100644
> > > --- a/drivers/net/intel/iavf/iavf.h
> > > +++ b/drivers/net/intel/iavf/iavf.h
> > > @@ -565,4 +565,6 @@ void iavf_dev_watchdog_enable(struct
> > iavf_adapter *adapter);
> > >  void iavf_dev_watchdog_disable(struct iavf_adapter *adapter);
> > >  void iavf_handle_hw_reset(struct rte_eth_dev *dev);
> > >  void iavf_set_no_poll(struct iavf_adapter *adapter, bool link_change=
);
> > > +bool is_iavf_supported(struct rte_eth_dev *dev);
> > > +int iavf_request_reset(struct rte_eth_dev *dev);
> > >  #endif /* _IAVF_ETHDEV_H_ */
> >
> > In general, I'm not a huge fan of adding driver-specific functions and =
I
> > feel like this should fit under the existing reset APIs in some way. Th=
at
> > should avoid the need to update (or such a big update) to testpmd, for
> > example.
> > Some thoughts here:
> >
> > 1. we could add a devarg to the driver to adjust whether reset does a
> >    "softer" reset of the VF just resetting itself, or a "hard" reset wh=
ere the
> >    PF does a fuller reset of the VF.
> > 2. rather than a devarg, would do use a driver-specific function to adj=
ust
> >    this behaviour. The difference here would be that the driver-specifi=
c
> >    function would be an init-time one rather than runtime, so the runti=
me of
> >    the app, like testpmd, would be generic.
> > 3. the most generic solution would be to add an additional parameter to=
 the
> >    reset() function itself to specify a hard or soft reset. This would =
mean
> >    updating all drivers to handle the new parameter (shouldn't be hard,=
 since
> >    it would be __rte_unused in all cases by default). This also opens u=
p
> >    the possibility of other drivers - especially VFs - using it in the =
same
> >    way. We could actually document that the "hard" option "may be used =
by
> VF
> >    drivers to request a full reset of the VF by the PF".
>=20
> Hi Bruce,
>=20
> I did not make it clear in my commit messages the full purpose of this ne=
w API.
> Along with resetting the VF, the VF is also reconfigured and restarted
> transparently, using the existing iavf_handle_hw_reset implementation.
> While there is probably merit in extending the reset API to include a sof=
t/hard
> reset flag, I would still need this new API to fulfil the purpose describ=
ed above.
> If we wanted to make this generic I see two options:
> 1. extend the reset API to optionally reconfigure and restart
> 2. introduce a new generic API that performs a reset followed by a reconf=
igure
> and restart.

I've submitted a v2 and renamed the function to "restore" instead of "reset=
" to
better describe the behaviour of the function - not just resetting, but als=
o
restoring configuration afterwards and restarting the device.

I agree that it would be best to avoid a driver-specific function like this=
. After some
thought I don't think we can extend the reset API to include this behaviour=
, the
reset API should probably leave the device in a reset state.

I'm wondering if the community would be in favour of creating a new ethdev =
API
for restoring/reinitialising a device. It would essentially comprise of res=
et,
reconfigure and queue setup, and optionally device start?

>=20
> Thanks,
> Ciara
>=20
> >
> > CC'ing techboard to get some wider opinions here, especially thoughts o=
n
> > option #3.
> >
> > /Bruce
