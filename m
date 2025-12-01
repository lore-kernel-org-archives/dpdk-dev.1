Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25DF5D116F1
	for <dpdk-dev@archiver.kernel.org>; Mon,  1 Dec 2025 22:50:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 433D2402E4;
	Mon,  1 Dec 2025 23:50:05 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id 6DBEA4021F
 for <dev@dpdk.org>; Mon,  1 Dec 2025 23:50:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1764629404; x=1796165404;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=mklcOUnngLLQVBol1wkF5z045T35zCjsG4k99g9n2NU=;
 b=M5mXaPx4bAigaeqNeX1mQI8qDnXRpRDIDkJvhVS8LyYCaCuwIO6/Vuhy
 yim/GTyGuQsVsbofYpDyS1vmQSFWSYQzOXiS0Q9fjIMEDl1WERWFlb/Oe
 fZdSGf9xMfCD6FRZbBWAeZUqfadXzWuWtQXPl1a4xtjsfnfdIFPf/XeYP
 Qqi1BB787TDBvNML601WmSdhxNNE6cpUyuTXRPZOz2KnwF/7ga11bRELX
 P38C4xlBQuplI+nZLP8Nzs7SqEpEbRl0BxU8xGqN7aJ7leOPbbsKkJkrs
 m0FgJem2RPsQ21M51ivR7Pe0PlQQJz/Ge8l1lAXzq/YsJXGCn3CAIZuhL Q==;
X-CSE-ConnectionGUID: S5mKLa+qRHu1CpQynORHJg==
X-CSE-MsgGUID: BzyZxXZeRDasr0Uh+8KAAg==
X-IronPort-AV: E=McAfee;i="6800,10657,11630"; a="78049701"
X-IronPort-AV: E=Sophos;i="6.20,241,1758610800"; d="scan'208";a="78049701"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Dec 2025 14:50:02 -0800
X-CSE-ConnectionGUID: rmoR+djRT1yvcOdyheJfIA==
X-CSE-MsgGUID: 45wANpV4QnuZt0epbfvRag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,241,1758610800"; d="scan'208";a="194190662"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Dec 2025 14:50:02 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 1 Dec 2025 14:50:01 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Mon, 1 Dec 2025 14:50:01 -0800
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.36) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 1 Dec 2025 14:50:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FP3rnkxBkejAqrXKaLKM9ne7AbW6q89ZyWT4QN9x4ronsC+OgpQbQUuln9axNl6FzBjhj+JTm8mHffBuNocWRMnE7nbOaCFEa0dC3SkcioWCA32kYWPOu8bqrZGm+14p+5xQE8o1GqmDkVIocndkExbKotuX4naghZkjxRg1P3s6ah3noWL4YfHj1GZLkDUA5u1RjXU/q3p1I09/cpPb4uzAeRtNUAZCJDkqKseFzqHlg7Egb4C9A8GactNxg6ryJ+XeJLuyQnv17U6hVXzKdhkkx3BDjTxeDDOjODR0G3IU505shX5pDHCXe/4RsabF07GxFnoJUgj7dMoYViRCKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VdoRrrWe8TXv5+g7cxqU4O89b4x2fIcykJuIHhkugh4=;
 b=Apnpwivg5l3TAQM1N3noPMf5Bre6E1wTdaA1VHhvW1hr0PhOomuk1SXXTuF+DPKtGExOgzZAWgzoyIlfIoFP9OB4eTyVd9fv7qeyTsV/PBfdZMIyGMc4qHD44174G4OLk3daEl84Q43mhj5ojao8pezkc+Gmzq66pRXjZuu4dZOeDC4usSyX85vmEBKFjY2yac/1xCKXjghfsi5yb5cyJBcrfuzazYdoUCojWkvACeXF8NXFJm2g6RyBmIPt+SUon7rZi4q8gkZr81ir7u2WU7NRTxmulDC0RDElGMD/LmTYMaSaQOF2WwC5FNXrP3eMHjBRKhkS9xU5fFQCICNgng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SJ0PR11MB4992.namprd11.prod.outlook.com (2603:10b6:a03:2d4::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Mon, 1 Dec
 2025 22:49:54 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3%3]) with mapi id 15.20.9366.012; Mon, 1 Dec 2025
 22:49:54 +0000
From: "Keller, Jacob E" <jacob.e.keller@intel.com>
To: "Richardson, Bruce" <bruce.richardson@intel.com>
CC: "Hore, Soumyadeep" <soumyadeep.hore@intel.com>, "dev@dpdk.org"
 <dev@dpdk.org>, "Greenwalt, Paul" <paul.greenwalt@intel.com>, "Medvedkin,
 Vladimir" <vladimir.medvedkin@intel.com>, "Jiale, SongX"
 <songx.jiale@intel.com>
Subject: RE: [PATCH] net/iavf: check PTP capabilities during init
Thread-Topic: [PATCH] net/iavf: check PTP capabilities during init
Thread-Index: AQHcW0ArmBW1ueqF+E20tzsNrmuh7LUDNpOAgAAtGQCAALRAAIABHhoAgAg8+2A=
Date: Mon, 1 Dec 2025 22:49:54 +0000
Message-ID: <CO1PR11MB508974072FCAB71DE941AF1CD6DBA@CO1PR11MB5089.namprd11.prod.outlook.com>
References: <20251121-jk-dpdk-iavf-rx-timestamping-fix-v1-1-21c9a337a6f2@intel.com>
 <CY8PR11MB774717DEAC152077562DB837F9D1A@CY8PR11MB7747.namprd11.prod.outlook.com>
 <aSWrIkJwhbsf7YvI@bricha3-mobl1.ger.corp.intel.com>
 <c6635526-a576-44ec-89f1-985779ba0ee0@intel.com>
 <aScyVljrA4myMP9K@bricha3-mobl1.ger.corp.intel.com>
In-Reply-To: <aScyVljrA4myMP9K@bricha3-mobl1.ger.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB5089:EE_|SJ0PR11MB4992:EE_
x-ms-office365-filtering-correlation-id: 3e817455-b605-4b0e-f97c-08de312bf1e8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?09rS00A/UUdq7+k3ToHuw4PMrCv1LQsw5VLi2OZbSbE9kWJAFTD7T6MNfC6z?=
 =?us-ascii?Q?XF2Wv+/PMFro5NKUiR+Mn6UEb5XJRDcPtFZqYqqm1m6Gqc42jNss0TxaQPyY?=
 =?us-ascii?Q?EpM/QdJJTrUibDuiRNYuPu+h7T+Wu4WuUIMnszr7D5oe+ksSzdemoEuL3rzI?=
 =?us-ascii?Q?fanZwqa6wZGhsfZPGuj7zFNlcnzDQw6b5WLhoOtamccudy3bqyplW9YU/56K?=
 =?us-ascii?Q?u77p26Y77h2gkaEO4HyEzt4idAe2tATSDs4RvOwblolE8p8DMuI0V2GCp9Ly?=
 =?us-ascii?Q?/ku8RR2gJ6C7z+3eKWUtrdi+mEYhbi8GZpDrFOYwdvIUWRg4EXg+N3zZ7+zA?=
 =?us-ascii?Q?HWnwCQM7wDZxY7TX8tjFkbtY5HQSbB9BLG4nMjKEvlOLo5j2f40ZOZZEAWWP?=
 =?us-ascii?Q?bGKfjN7Tc48lmyzMpC9Yp/7oqDVCTEMu17fNVYYVQWW37E0idnWsO9mahGGV?=
 =?us-ascii?Q?gRVEJW7RSFljTEt/Ffsr14KRC3nePoq9fAjS0yLGFxxt22cN5lubvDLQkacr?=
 =?us-ascii?Q?933NPJ1rRLA8kcNMPm5IxhqZ8NTVwd60moNKrT6hYNRqMjA9lEGOR0xrbvpe?=
 =?us-ascii?Q?1AiRqD1cAAZyE4H/LuKTKXT6N92XuOidN8Hx+gYt+H3g3GPWGJf9DjkBJLWZ?=
 =?us-ascii?Q?Y1pYgr7cI/ecXEQJffPXJM7zInl1pezpU5WYwdkn99r12jTiVKYaFJEqQYEU?=
 =?us-ascii?Q?zX25X1SjF2TIrW/gsSz6rorgH8e2AyNIJ+HSWiW0kecTh8b3f5NeRAWVgprl?=
 =?us-ascii?Q?miNlaenEPAqV8l/qTxMO3cl6mAg03btIbgSjQS+g8inoOoR3WnYipme84G5K?=
 =?us-ascii?Q?7BqzkUdNi4xdOXPEo0scvR2SxNIyv/p4UElHzLdF8IViPNqSPsAg9Xf+bcUL?=
 =?us-ascii?Q?xE6F+csDsoCNSFLR660ckU3bNMpjJtFLdiudIrcAMXL3wnz1oDPuZ8x/uoWm?=
 =?us-ascii?Q?fWAkCok8Z+gj+kgIXNs4ld3znx3AVp3ASCCpq/HhGdull9kFE8zTBCuwvDwV?=
 =?us-ascii?Q?8wsrHwLXB5bwFI6UI0Arp+bV0PqjvS4OBnxBy2y5Wog5Ikd73bCyf5zgL5BR?=
 =?us-ascii?Q?iYDbianqDeN2UxxeYvrnul6smYkMSQ913q+jZHogkL+jd86yurj59SeepiBR?=
 =?us-ascii?Q?oFGP8lbxo1rW4i3555qwF5A+z3Qxg2t5NWhBsGOuufjpYoAa4G7qRMWnw2eC?=
 =?us-ascii?Q?dBEDuqSxD4o1dmBL3UVTKuTu9XnUZKEV9CJrpk4kMfAPK1U7d+l8A5qpgCrD?=
 =?us-ascii?Q?ZFV4mU+s93L04X7zLnXRic0b7a16IPH0pMwzanVs+OwxiM5HTnUoSX9kXdLu?=
 =?us-ascii?Q?st/dQRnGzC94M3Lb24oujD6NwEKy9dcTGXFg6u+qh/OCz1QwJhQ0hsz/q8NB?=
 =?us-ascii?Q?ESq/lo/DLmG+vyBr20RCqAN0Bqul8Upqc/Udwd0fSc+gxjpDpHYN/v8nx0V2?=
 =?us-ascii?Q?K+0/ROkThVKrfrMyC0jnK9W7lpCo23JkVzQzpMq5ceVUj408TJFMb25R4B7Y?=
 =?us-ascii?Q?vvahOL313HcDD8ORvH8Iq0V9iMX7U7l800x9?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR11MB5089.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?pvQGQTqcxPulElPqZXMnE5wlaSwYlArTWhJTvTf/Hnptz9Zc7KhH02Ty5V/k?=
 =?us-ascii?Q?6soM3I6qOwudtJO3TDxW8QY6PWDN00UiE2ezJUdE8Ffw85JaI3Gd301cv+Ad?=
 =?us-ascii?Q?34kVnyxJ+viQYdH8EGkKPhxuWhe+nafdI//lW5ORY1VgwDQJCWDL3DCwgB2u?=
 =?us-ascii?Q?MYVZmNGH7P50/mj2dkQ2kzDPPHdTcKkuZXBbG5H4o5iyu6elHt0fdQ2SUWot?=
 =?us-ascii?Q?m41zct3tZ+ZSoEhl4ICEcGRTP3ZWAaxtLJr3uliB8+zR4v70dUPWXluYiXnt?=
 =?us-ascii?Q?e5wtHhSOrPyz5OatDq+D9/Xt1voL9f5+0vUK0AOR7wS9u3lyyR6eaQtqoIbt?=
 =?us-ascii?Q?pkZMqP15t608G9U12okHpOsjEaYKOQWQhDhqs9tsADGhHSTRJZ62BCL7TS1a?=
 =?us-ascii?Q?tFBF4ttHpdcNpF2+DM9lca7AvhU9CAulh81NhuyKjilKaqCnwfPOo+Ag7PAH?=
 =?us-ascii?Q?eYhbfizAO2FWXuQGJUhgmXX5s81w8jQEhzF8XvtEDGfzgWwI73uZnOlWgR6y?=
 =?us-ascii?Q?uTQHx9z4rUwENHhuWyT2LsX3WWUGDT6CAmzRbjiPAcA5yyrnyqUdMu4UGqQ3?=
 =?us-ascii?Q?yT3G7v2RfeMBeTlur+XnjTZ/uc0k/mLshJ3ysQu6kOmyxW4Z5xcxGpYN3Is6?=
 =?us-ascii?Q?isVXWgs328Phol4sbDPJoJP6noNVy5fpv+Fj0tDxRNb9cjEWu/71Px0cfMpo?=
 =?us-ascii?Q?TKq1j+/WNSgpyEdSLw4TTWbohPXHb6pYxyvF7QoKUPrA2zll3BLImU2Rsyl4?=
 =?us-ascii?Q?W68YLy8vkxWC3T9Di/0On41qZohAGaMGpJyGBRIMaMXcopK8R+GouUU3uXZM?=
 =?us-ascii?Q?zIANiroWpoODcK3vNWyfn7NPTHk47dUxsRZ80QZShRhkx5LtxN6JBCHJ4NGp?=
 =?us-ascii?Q?rIUD9oe9sMXqsdfJsdgl7JdqNy0VvxnIU53N/6U5TsL1vbFYckkCv1U+NgKw?=
 =?us-ascii?Q?yqtXp0j27YJP+sfF2ASwIi/TnrWO7K7gE3b6dOHPd5/0c/M4Xi9kYjIuxenn?=
 =?us-ascii?Q?bnK4tslQmWILmZrufkLJb4pJvJwz9OxUUD0jlKnUPBtxi6bo57ZxgM9zTmm7?=
 =?us-ascii?Q?nCvV05HL/WbFwCtP5aWMIQqvXFuv5feH3iOCCytKAVc7933WnBnjd9P98S0u?=
 =?us-ascii?Q?5zxT9GPJUUgUBAuEoTWmYzSYuoxfcxSngYvEiczkxW87MVm0vLG3Uzr0eiKR?=
 =?us-ascii?Q?wZmyzDJ+t2/RzdQgeO50MG0jwLAq6FRzLRwUDVh4RLTAymLfEwV3VovvrVfu?=
 =?us-ascii?Q?5380Rlzn4q6+2qn29pHvIoBm1tcW7NNfvjLn50riKGPIJLtwfqDYfpN/lhiq?=
 =?us-ascii?Q?hL52xgO4lktusxI7jf0NjpLsCOfhqHIbDXPqoj+oq/NrO2ZhX0Z7B6mvKTQ4?=
 =?us-ascii?Q?3ApBh+yHN9+0RB07K+2RYbZiImvTkWIZkt9pgyostFSKbFdVXb6AL5xrSqAu?=
 =?us-ascii?Q?WIwyW/2TWNFSa6S/sT+UlCkaWSRPc8WQxaWdZxRggDP9tzh3L+sYwaY8DlmD?=
 =?us-ascii?Q?8au+Nq/2ygmvfdWXTjpK3MLXU6hZvnLQsij2xmuptSZWsMaPRMUF4pibAa7R?=
 =?us-ascii?Q?nSuybuaSt6hq/dYC/3y3wln4X5riVOfDUxTkCiDN?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e817455-b605-4b0e-f97c-08de312bf1e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2025 22:49:54.4836 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tweuSIHkD/R/Xana9JZ+UpJ1NQ/0PapFFowln+IrKG+PfeBs02Znw7h6mytj4fTOmaFEzil48tWtnRAR292eDWuPp2gH6foMnilK1Wjb8+Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4992
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



> -----Original Message-----
> From: Richardson, Bruce <bruce.richardson@intel.com>
> Sent: Wednesday, November 26, 2025 9:01 AM
> To: Keller, Jacob E <jacob.e.keller@intel.com>
> Cc: Hore, Soumyadeep <soumyadeep.hore@intel.com>; dev@dpdk.org;
> Greenwalt, Paul <paul.greenwalt@intel.com>; Medvedkin, Vladimir
> <vladimir.medvedkin@intel.com>; Jiale, SongX <songx.jiale@intel.com>
> Subject: Re: [PATCH] net/iavf: check PTP capabilities during init
>=20
> On Tue, Nov 25, 2025 at 03:57:10PM -0800, Jacob Keller wrote:
> >
> >
> > On 11/25/2025 5:12 AM, Bruce Richardson wrote:
> > > On Tue, Nov 25, 2025 at 10:30:37AM +0000, Hore, Soumyadeep wrote:
> > >> Hi Jacob,
> > >>
> > >> Currently PTP features are not enabled in DPDK. We only have the Rx
> timestamp API in place. Typically the change that you want needs to be
> implemented in ethdev_ops.timesync_enable(), which is not implemented.
> > >>
> > > At this stage we are post final RC for 25.11, so taking this patch wo=
uld be
> > > risky anyway. Let's target 26.03 for this, and then look to  backport=
 to
> > > 25.11.1
> > >
> > > Thanks,
> > > /Bruce
> >
> > Sure. In that case i think we need to revert the other change that
> > checked the RX_TIMESTAMP flag as it corrected one issue but caused a
> > regression in Rx timestamp offload when it *is* functional.
> >
> > I think its commit d21c2fe6e5a1 ("net/iavf: fix check for PF Rx
> > timestamp support"). That commit without this fix will incorrectly
> > prevent enabling Rx timestamps.
> >
> I've sent a revert patch now[1]. Please verify that this revert is correc=
t
> and ok for inclusion as a last-minute fix in final 25.11 release.
>=20
> Thanks,
> /Bruce
>=20
> [1] https://patches.dpdk.org/project/dpdk/patch/20251126165943.1536164-1-
> bruce.richardson@intel.com/

Looks good to me, and thanks for fixing my mistake quickly!

Regards,
Jake
