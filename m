Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCF23CD8CA8
	for <dpdk-dev@archiver.kernel.org>; Tue,  9 Jun 2026 10:54:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3D1BA402BE;
	Tue,  9 Jun 2026 12:54:04 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by mails.dpdk.org (Postfix) with ESMTP id 51AA84025E;
 Tue,  9 Jun 2026 12:54:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1781002443; x=1812538443;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=jsLmUKD5LttGsx//vW41zgCGUSjUSusEmjk/hBuM1iQ=;
 b=cr298WDxjwCRS6IjatADbtmiqRmesZrNmGQy1LeFRlSiSPQmR6+qqKw4
 ytBkObvrLbCcz3OZEhQhps7P1reczUJrUATGBJuqj+BunDcxCaLCNAB+C
 bAxPWFnzClAjq3kJvyBEEY+G4uYk9crJe992j+TVL3L6rNidXOlq/NI4B
 FBIVUFPbzcLhZTnOqL7XpGf7da/GarWn6k076x5osdJGwaMhMoclI9Mmq
 Mk0g7WET4AzkEMpR0cjudkTCHcCMmEtDJ0gTXHLZe0/2TwgjtONyTvjgi
 /S2LU6lKKxQOBLzRHCrcv1jUv8Xjz6ZdIxOz+l/NA04py+93psajTxotM Q==;
X-CSE-ConnectionGUID: gv/l7YQTRPOmdwgDXqC5CQ==
X-CSE-MsgGUID: Ai10n40pRrqaLh6HY4KI4w==
X-IronPort-AV: E=McAfee;i="6800,10657,11811"; a="81944504"
X-IronPort-AV: E=Sophos;i="6.24,196,1774335600"; d="scan'208";a="81944504"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2026 03:54:02 -0700
X-CSE-ConnectionGUID: bXHNy1/VTruF9w9vMUsTRA==
X-CSE-MsgGUID: rv0HeT5yQKuCTz1ucr3d2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,196,1774335600"; d="scan'208";a="276016856"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2026 03:54:01 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 9 Jun 2026 03:54:00 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 9 Jun 2026 03:54:00 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.21) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 9 Jun 2026 03:54:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KeLOax6ryd6OFDloGuDhdaydkUebkJZ/OGp/PtCY8GcOKC4oxR8C0BAseCaLIpgKdCjtVuy1sbTeEfHfFi8TYU0M21MEPNFe/w/irEpSfWZiw2401ewKYbxxvEtYPyjhYPEwjaKgFz/MC8avMplC+mOiRTqBY3ajUSbIwwQN0rhfoRqGOlWWE4uIkPqHtbhBbZfLUCe1SRvRFDB7L5CZTq8KeaEOjN3jgVeM5h6UMscKCeWLGdm32ssfouSTQxZ2ONW4xvGeVyu5/ic7ctX2yFlOIxbdftMxfFFQWX19SbsFR6g+rmdd63DfYW2ctfe2x1ywgjJuUPIN52wFXEMoDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WEwqGpg3JuQOL+MW6cxIarpYfIebgjvqQ4nCFWzzP1s=;
 b=lRyYXiHtYYOLL1COiFKICEwkZHktyGnvEKP77vLkXEdNOOq0Pe8AyosfdwrcxjlJWZ1/25qLd7TljH8Qlu02Wsfhdt0cBlZObumwywgYE/OOuFRCGzqz92ADg4tN0N4XwFaPyJTSop6M8TYd7oUMAVQ1rX5fFqc0DMsJiBj+j9/WYPMbaorZkiYj2G/TuSLxFWayzumQkd6f58WZsAynIqSJRxmM55R1dTXFeulEYBpBG7Xb4lNuaecldA4af1q1HIkk0RsjL7Js94Km1f0Tc/35TDBhcX7gwymdXr4SQyr0AQmCrV+KSpFJeip5qaFavr6C/OGInVTW2qy+CkB2Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY5PR11MB6116.namprd11.prod.outlook.com (2603:10b6:930:2b::14)
 by IA4PR11MB9177.namprd11.prod.outlook.com (2603:10b6:208:569::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Tue, 9 Jun 2026
 10:53:58 +0000
Received: from CY5PR11MB6116.namprd11.prod.outlook.com
 ([fe80::7243:ab06:2282:cd8b]) by CY5PR11MB6116.namprd11.prod.outlook.com
 ([fe80::7243:ab06:2282:cd8b%5]) with mapi id 15.21.0092.011; Tue, 9 Jun 2026
 10:53:58 +0000
From: "Mandal, Anurag" <anurag.mandal@intel.com>
To: "Loftus, Ciara" <ciara.loftus@intel.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: "Richardson, Bruce" <bruce.richardson@intel.com>, "Medvedkin, Vladimir"
 <vladimir.medvedkin@intel.com>, "stable@dpdk.org" <stable@dpdk.org>
Subject: RE: [PATCH] net/iavf: fix to consolidate link change event handling
Thread-Topic: [PATCH] net/iavf: fix to consolidate link change event handling
Thread-Index: AQHc96RYhglbJRwunUu4iGgNKu0KGbY1/tUAgAANmLA=
Date: Tue, 9 Jun 2026 10:53:58 +0000
Message-ID: <CY5PR11MB6116C94D51C347DEAD15108DE41D2@CY5PR11MB6116.namprd11.prod.outlook.com>
References: <20260609001022.357509-1-anurag.mandal@intel.com>
 <IA4PR11MB92782B6A7F4F58953DE954DE8E1D2@IA4PR11MB9278.namprd11.prod.outlook.com>
In-Reply-To: <IA4PR11MB92782B6A7F4F58953DE954DE8E1D2@IA4PR11MB9278.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR11MB6116:EE_|IA4PR11MB9177:EE_
x-ms-office365-filtering-correlation-id: aef68cff-297f-4069-2f30-08dec61568a1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700021|6133799003|4143699003|11063799006|56012099006|18002099003|22082099003;
x-microsoft-antispam-message-info: eCX5m6u0n2Pw+DUTT8XPlabeXMzgdsusCjsvxiofc20D6qgTaOxstrrgcHXjRS1D6AvrCihcl/7FDihOMlX7fDDAyMrLhNeHuILSSfpErfvjWQWRe7HAxQsC3gQvmRHN00auRtnGn/qLSKFsdG8SQ5Df5VtJ+sg4A3LAr4BYFNQno6PrHKcJSD1EDDrEd4yrAyjSDIXPo9iUpQJ2Y7ygt69OX+jZuby/6JekRzz8ihTP4FXOa4xDYA1lKISM8cd+e1/ZO5fMgcmVCvev75GUzsw8ampFm0dCmu0sHRCUJtW47ZybnHsAt0Cijq5GAwqhTUjI1bsf4h+bC4TI5fPjW9sK/yB1E2OeTgj+j9lTgGmXX6Y5a/OvqEhRGj4Ec1z6CSw6B9bKU5UmwiVKaNQnXv+vazl0H0a+Hmr1mMpwInprc7UsKFbvmBCYKveWn2xNc94sMa5aqbz0W054u5mOqamp4o5fgFQldGHXwRYF9yLxMzcYOmzDNi70iqG0lB1xBd8A58DyyaZzbOTyV6x20BkFdww1DXjfvHDA8g+BgVCCoJOt80CtJDHySMjiCZsPMMA+9pGgmi/0DPZydT9ivo01cMU1z/VnWWpF+F1Sqs0s/qcvoB8dz0ne+wBaiZ3QPoK9flfDUMu0KaUWFhBEmxy2KuNlJHNH0K6WhM4UDuVCzC2eW3fQLzgTRI7JtLn4xQcWY6FTu8RL1/XJ8WS/xJ7LggkMjVnd9T0z+DKGLznBQFrYFqnfdyKqqp2H/zy9
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR11MB6116.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(6133799003)(4143699003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?osv0Bg0Fp3LWBaE5z4hQEkAqQuB0025HrYsC3Tbi0X5MhTWo7aR37vSPP7UE?=
 =?us-ascii?Q?ANLzXM5FUk5JWILaxldkyhUczfa+yRVpuK/cWqyQg/HYENug25tBEKDa5RxT?=
 =?us-ascii?Q?j9Tk1KuisF4QEUJf7dvpe34hSe1AHLLUL6vXVehYYDb8umgRsGRhsQL8ZlM0?=
 =?us-ascii?Q?eSGhcSRhGTj5ym2Lr1V86nM2MavGg6xTOlhaRC9UuDj82Ygwlg2QWyYoGgx9?=
 =?us-ascii?Q?nqae7Ru42PI8BjhJEsiUugE9UaRiNB7/IVrdVbgjx5dxYZQg80ktslQwVF31?=
 =?us-ascii?Q?m+gL8w+yYjw9XEnu1yA2951z6bvtdgznRQ/PToS8OtRwU9i2JsM9JS5BaTBO?=
 =?us-ascii?Q?VKbZ8Do2VkPfVHqJ05/1GE/ePMWXtVje6HocTfL0AC4RZmE3QuRytfesdWXl?=
 =?us-ascii?Q?KP7dWtL8s0BeHFRN/4Liij6PmPmwlpb1d9wlDUVOgpDIG7ALvrp7CCM/Bzil?=
 =?us-ascii?Q?Wy+3kB/WPel6OZyKgxp4v3uJ/cJ3nlHodHNxI/S8Kuh7GTE04Q61rISiXnft?=
 =?us-ascii?Q?wQROss6qutqh42puB9dbYg0R45tRuc8jQ9JrJ13EMG6OvN7FXBUsO/Xi4xnW?=
 =?us-ascii?Q?rhCFi+aecCbN0vef7xKphbT+RMoB6AsZVPiIm4FWT6Q5TGhAa5ygOXcOG4x7?=
 =?us-ascii?Q?hqXS0zOaP/LVP/rBBj0DA3jM1e0gO2d6xZaqRg4xCzIX51P/8PC+UqPPMBu7?=
 =?us-ascii?Q?eStKkgSuxd4Dq3bGea1+fMdMhTBEssxSnNflKeYgR+Ueogji+TZ7Bhj8eCc6?=
 =?us-ascii?Q?+jqSDgObZwrTi5udKoczvpaxouluLLQ+qY2rtC/S+7Ibi+GpP4ZOiKL+fzpf?=
 =?us-ascii?Q?gIQin0H4H5Ed81NDOzXjnsG8whaXrS8KKfRVVYaGZXGzGhTRSeILtSx35oV1?=
 =?us-ascii?Q?00oceDvQuXFncMV7vbCJjny5gGl5w2WqsIbrkhVbc70v/yzQPROU6Me/IJdE?=
 =?us-ascii?Q?oCeHCF/skCLb3b7bWWlUPC6qJN384duTx0xEKfd7uJLuMltBJpL55uiPK6Y8?=
 =?us-ascii?Q?Hs877sf7U/VpQO/dz45zVLt+pQ8Cb0TOBFYPgQz1Il+GglCf+gJj2GQXSKge?=
 =?us-ascii?Q?Dr7J9uxdkUAMEGw1+yGKVTEde5Br3u9bfjJkeC3Y4kLbuMBmrkxEqggTA8V/?=
 =?us-ascii?Q?X0ODJMJUgbJjg6u5S2bHbl6SCqWhLoFtpYUDSabrHiFwOYRcpDFw3W8ykGcX?=
 =?us-ascii?Q?pNTx05u8XdNj5e0042xUPtxLPIz6H4L4R+8G7BPE2jyrsBufODpLQks3Hx2v?=
 =?us-ascii?Q?IfQyzIFnHqxKLeBw0nX53XiJoV0s2KerkkyR3+TSy38nNfAyeNjtFBepWl5M?=
 =?us-ascii?Q?f1vNQm9cf51UIVb977BXO4cOX+3IB1s+axIHURc8cyU27/PbdvOD6d4bk7W8?=
 =?us-ascii?Q?FB9o6egz1uPAZD4iMTgphUVUb1DV5pxIaBv1VVCF5I2PpY+FkTdao/o2NzlE?=
 =?us-ascii?Q?PpJaYlHJ2mIjv5L/PiYU2rNo+mHbCMSFPAF3oZu53m03iehiDQ+nlzbBqO8l?=
 =?us-ascii?Q?aADR/XcMy3Q5t2ugTsNCpTuCFvHNXkvRuO2A3nZZbs7JG+A4vJXhGvcqGTnx?=
 =?us-ascii?Q?V8nEdarfcBKuj3WPdOND1eCFwY3XDCx24LG+IyRTbILEMmp/UjlgwQQBjz5b?=
 =?us-ascii?Q?bUE7rF5E/qw0bzTM0R0QHr+7FDd82Jcnjzqs0dPKVJseej+vXXnqBK4zQ5E8?=
 =?us-ascii?Q?tQXcYo1AXbSFcLHWZwJ4iMBtn2YuoKQ3CtsUh97/X7h9jKoLPcMLdHwz7zkk?=
 =?us-ascii?Q?G58IlUEcRQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: IHC54A0AGfL2ah+icvlvGmI+5obwfVVk4uU0z8fpedaO/fXQ+Qb2jZDm7RXzPfa5obyqpVN2HvYA8aE0SEcsHed5klqqXTcRNQXad9cnwf741Zd06qjBnCPnNC9xL1AYums5nt7Q5UwIdsyRL3e7s3ukdQ73oB8ZjflDfauJjEHEcVQmwZDJ0upbFJq+NeIQOx0D71ayvkjECf/9m0a5NRodPICjFCF04yqZywSd7fyoY725mpVsC4Kwuc2+CkVggNLxiTMNwpWi4cOm4k6j3JSZLCiku9+6M+mzptv5o+joGupvBGPw6fog/HSNQAnLDrvREu8QYeVTtsFOT1eQCQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6116.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aef68cff-297f-4069-2f30-08dec61568a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2026 10:53:58.4354 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +oCJBBJVDcd7ZWnMSNl1W9+LgdMp1T/D+5fWWgBFkqveeK6qYRD6WSmENsYjjP2lCkhp7qc55h+/OSf83BjLeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB9177
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
> From: Loftus, Ciara <ciara.loftus@intel.com>
> Sent: 09 June 2026 15:32
> To: Mandal, Anurag <anurag.mandal@intel.com>; dev@dpdk.org
> Cc: Richardson, Bruce <bruce.richardson@intel.com>; Medvedkin, Vladimir
> <vladimir.medvedkin@intel.com>; stable@dpdk.org
> Subject: RE: [PATCH] net/iavf: fix to consolidate link change event handl=
ing
>=20
> > Subject: [PATCH] net/iavf: fix to consolidate link change event
> > handling
> >
> > Handled link-change events through a common static function that reads
> > the correct advanced & legacy link fields properly and updates
> > no-poll/watchdog/LSC state consistently.
> >
> > Fixes: 5e03e316c753 ("net/iavf: handle virtchnl event message without
> > interrupt")
> > Fixes: 48de41ca11f0 ("net/avf: enable link status update")
> > Cc: stable@dpdk.org
> >
> > Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>
> > ---
> >  drivers/net/intel/iavf/iavf_vchnl.c | 133
> > +++++++++++++++++-----------
> >  1 file changed, 81 insertions(+), 52 deletions(-)
> >
> > diff --git a/drivers/net/intel/iavf/iavf_vchnl.c
> > b/drivers/net/intel/iavf/iavf_vchnl.c
> > index 94ccfb5d6e..6454632541 100644
> > --- a/drivers/net/intel/iavf/iavf_vchnl.c
> > +++ b/drivers/net/intel/iavf/iavf_vchnl.c
> > @@ -216,6 +216,75 @@ iavf_convert_link_speed(enum virtchnl_link_speed
> > virt_link_speed)
> >  	return speed;
> >  }
> >
> > +/*
> > + * iavf_handle_link_change_event: common handler for VIRTCHNL link
> > change events
> > + *
> > + * @dev: pointer to rte_eth_dev for this VF
> > + * @vpe: pointer to the virtchnl_pf_event payload received from the
> > +PF
> > + *
> > + * Handle PF link-change event: decode adv/legacy link info, update
> > +VF
> > + * link state, sync no-poll/watchdog behavior & notify app via LSC eve=
nt.
> > + */
> > +static void
> > +iavf_handle_link_change_event(struct rte_eth_dev *dev,
> > +			      struct virtchnl_pf_event *vpe) {
> > +	struct iavf_adapter *adapter;
> > +	struct iavf_info *vf;
> > +	bool adv_link_speed;
> > +
> > +	if (dev =3D=3D NULL || dev->data =3D=3D NULL ||
> > +	    dev->data->dev_private =3D=3D NULL || vpe =3D=3D NULL) {
> > +		PMD_DRV_LOG(ERR, "Invalid device pointer in link change
> > handler");
> > +		return;
> > +	}
>=20
> Thanks for splitting this out into a standalone patch.
> I'm not sure if all of the above NULL checking is necessary. Especially v=
pe =3D=3D
> NULL considering you've checked that for NULL in both iavf_read_msg_from_=
pf
> and iavf_handle_pf_event_msg before entering this function. It's recommen=
ded
> to avoid overly defensive checks that can never trigger so I suggest taki=
ng a look
> at this again. Other than that the changes looks good to me.

Hi Ciara,

Thanks for the review. Initially I also did not add. Then I added it as per=
 suggestions from ai-code-review run by DPDK. Funny thing is now, it is say=
ing " overly defensive checks". So not sure, which suggestion of ai-cdoe-re=
view to follow.
Please guide. Will act accordingly.

Thanks,
Anuarg

>=20
> > +
> > +	adapter =3D IAVF_DEV_PRIVATE_TO_ADAPTER(dev->data-
> > >dev_private);
> > +	vf =3D &adapter->vf;
> > +
> > +	adv_link_speed =3D (vf->vf_res !=3D NULL) &&
> > +		((vf->vf_res->vf_cap_flags &
> > VIRTCHNL_VF_CAP_ADV_LINK_SPEED) !=3D 0);
> > +

