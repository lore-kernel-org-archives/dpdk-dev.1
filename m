Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB66FCD8CB2
	for <dpdk-dev@archiver.kernel.org>; Wed, 10 Jun 2026 14:13:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0FBD44066A;
	Wed, 10 Jun 2026 16:13:34 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id C0EE44026D;
 Wed, 10 Jun 2026 16:13:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1781100812; x=1812636812;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=eHc87a9JRLwUVH8WrUC5clY0WHN/uBWJjJoG81063Q0=;
 b=eKuVhSbDf91QAyFvfG/GefvXBsPgOA7WLuNEufyK2LW5PrClUIMgrG0+
 egQcUhXgSqvfde2AyEPcXLtlV/ThUsJeiicH+VTZGswFNwetQxWOy1aTc
 mg5hiMv+oSbQZzM2hnFz09XFbXI/QppCMGALUBWgAHS+nNtcOSo+Ci5Yv
 7JHrLF7wJ5bfbBEqUlum/MiT6oJIYHZRZqdb9AFMZkAAfOT8z2+Yjtaot
 GsGVbtw8yHQHklXbfYtGy3BJIkOKI9Te1eI7ZsEKuynXBHSzbpUX42UEm
 VkBgl5NZzT/zLPMFnoYE+fnC+aMIfIrCfAVWMaPLZrz9zW9GfGjm+Dquh Q==;
X-CSE-ConnectionGUID: dy9Lpf2tQ52SFyCQHLTYVw==
X-CSE-MsgGUID: ShSC8LzRRKawhfdWqFt5kg==
X-IronPort-AV: E=McAfee;i="6800,10657,11812"; a="93280969"
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; d="scan'208";a="93280969"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jun 2026 07:13:31 -0700
X-CSE-ConnectionGUID: fWuMaZf3SPCJ7jH/P0mtFw==
X-CSE-MsgGUID: CNNoq9G3R9qQZLxL0Fu42A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; d="scan'208";a="242051026"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jun 2026 07:13:31 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 10 Jun 2026 07:13:30 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 10 Jun 2026 07:13:30 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.9) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 10 Jun 2026 07:13:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RkFq03QDwu0wuHGchKxJ4UtZgMrkA2r65rJPtB+U+x3f9SyAmkuolU3MB3kmo0/JR7lzspNP7LfmqmYWc7hPsqXHokFN/xRlvhSbMcQO1DffNUWW9lXiYCKr1sr3OCNMquhKqK3Yd9gsnVwGOnhtr8znHDhzUIk1viemjE//XU8fdHzhaSd5zvDPJkvDRipFFPPm7aZsKzOzarb2NQkndTghQTXuh2hIIDN3M5EtCgjLIqb2ZaOYe2rlKKzutz9WkOvFl0YQ7477P9SlF2TaQdCqQT5eMdVh03r9jaqBjsPdhYztXmD8Ktabu2OLFYWYRNn7xosCd6PgVQhvDvDyMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Np2Jxl8QaL3Yk4R9ybdVTlYQnRy2RNmR6CLEPpUIzr4=;
 b=iDxv1yyfBCkg2BapAxVhZtw+5+XYC+wRdr/8vrfmoTexyxNtf70S1ToggYC7qMJtl0OqHixqUwsju0G44wb1r/KS8RivN3RQUkgpgI0kP1irjVp0izVwpZpl8MEc6EaGUrgr+B/6iTf75TZYd2KWRv/1R6kMf6fsiQriJJL1XdkAMq0VDS6qCSmuDC3DMZ+0A1hWscQ92kmeOMq1gWAa8epx0RN2QxLzXXrzynEBXUACx5wBBhZc5wnJAaCNjZ8h04KuVHEadcevIgPYPn8JlE0MQ5rgLGfJjGfAoKzY8cwe2F3Lyqf7syYZFpmk3hTWc0Xwz+NXEKxa+wADadFiYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY5PR11MB6116.namprd11.prod.outlook.com (2603:10b6:930:2b::14)
 by IA1PR11MB6417.namprd11.prod.outlook.com (2603:10b6:208:3ab::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Wed, 10 Jun
 2026 14:13:17 +0000
Received: from CY5PR11MB6116.namprd11.prod.outlook.com
 ([fe80::7243:ab06:2282:cd8b]) by CY5PR11MB6116.namprd11.prod.outlook.com
 ([fe80::7243:ab06:2282:cd8b%5]) with mapi id 15.21.0092.011; Wed, 10 Jun 2026
 14:13:17 +0000
From: "Mandal, Anurag" <anurag.mandal@intel.com>
To: "Loftus, Ciara" <ciara.loftus@intel.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: "Richardson, Bruce" <bruce.richardson@intel.com>, "Medvedkin, Vladimir"
 <vladimir.medvedkin@intel.com>, "stable@dpdk.org" <stable@dpdk.org>
Subject: RE: [PATCH v2] net/iavf: fix to consolidate link change event handling
Thread-Topic: [PATCH v2] net/iavf: fix to consolidate link change event
 handling
Thread-Index: AQHc+DbAN8sf51XCMEWZ17aHozJLerY3iriAgABLJbA=
Date: Wed, 10 Jun 2026 14:13:17 +0000
Message-ID: <CY5PR11MB611647E3AC6458BE45598015E41A2@CY5PR11MB6116.namprd11.prod.outlook.com>
References: <20260609001022.357509-1-anurag.mandal@intel.com>
 <20260609173822.364452-1-anurag.mandal@intel.com>
 <IA4PR11MB92788A795E02D08A3287C3628E1A2@IA4PR11MB9278.namprd11.prod.outlook.com>
In-Reply-To: <IA4PR11MB92788A795E02D08A3287C3628E1A2@IA4PR11MB9278.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR11MB6116:EE_|IA1PR11MB6417:EE_
x-ms-office365-filtering-correlation-id: f7a2e4c7-9693-4637-876e-08dec6fa6b0f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|38070700021|56012099006|11063799006|4143699003|22082099003|18002099003;
x-microsoft-antispam-message-info: TYdq9swPzgXm9UifoJaopLxxbxZkvYiof7cTNjSoghKJBgYGo7oA14m3QQzJwVXD3gesKfWaY+ylfbutlcgI1Ngtwz/Juc1bamfoa8uqMTfOoqwOkgjS3/e2fK2et/tBfTI1+wqcOto49Vkf2K7KlML8mBONEpzOFyvVVS0iA0F+q0q6TnvV/3PYPPUlgIxwrpoYPSV3Oy9imOrh1aiID80krRkLn3A2fEqkf7N6T8DUL4J9/8LuUnic/JZgvvfHqdvDRmmjgppQnZPhaNqmFA+phJ6550Is88O8MNfD25P9zc/7gFU1aCQ/duhPIAttbeDtj/mj8/FbnUFrJKvs4TbTSa9V+4bLqOfl07QcwQv7IM1Ad29tyrLuaSlXMbLaKBcp7vwSV5ucbmdZSaqmJ/D5jCZ3rFkWS73IPHE+sPr6zat20QGvdSBwkOMDSJKqpkrC37DXhmk7Zx6+bBObwj+aiskHlU0lrpiWwn1FK4+k3JFRZ4maWeKx68HzhvA7i5Ji8CxWgVqNLCMdVWx5byS9Q5KiO+2fD8oizbn7j5ui/9Y4nAruqa1xufK/OeAFOzJr0U1fOZNXdeQK9ASDQa5WVxG+SBGz1uP9UpyCmpV1Q1soSrWzoTqueE/jVORaK3/mZD3U1Im8fYzrsKj9h1wOJkGwRtuQ2lDUjDFZSXH5AhXEA5V5n0GAKI35vVvdxzEuwMLwBWzV5pOAhU5Qfis5/n9UcC1tzmlw6faNhicY1B1bd8Sxf47fwHvhmcoJ
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR11MB6116.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(38070700021)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?UXJroGNZLFIyPQqvU4sDWH386GmettGr+3WIbA9qXSgxKCVW0t3PT390tcfB?=
 =?us-ascii?Q?XQ/jlGieH0ufn0WtaLuJuMAQDM9qm2McIYs4ksTskbnYK+bAxMJPtSpPct2V?=
 =?us-ascii?Q?wIp4657cSL8ph0pEqM+VYncxAmh0hOyZWoA+HpZ5SATAafWfXJZVW3fWiZJY?=
 =?us-ascii?Q?MkLfsTBom8VXBhhSzlbzRuMO6zkNg68LGl4ENS4AxCLrEU/FGIbsfbl8nUTD?=
 =?us-ascii?Q?eSNcomZ0UOgsw457DpVCM/vtnLa+KI4RcRFv5g6gpeXIsSPTQXBu2i2kJwSn?=
 =?us-ascii?Q?tRwnQdLsybhVFUeLHTdVDOfTdAqvrU3bZRzcNooCofWnYQ0RUyhyEuYzvVIJ?=
 =?us-ascii?Q?VGG98QZZeRAKEyp88mnqGJGfIQmfbLFOh2kvF2AZySsayfIT2N0Zftuglseq?=
 =?us-ascii?Q?oc6iZbl4DyDK6HfXmDzf7Yff0uZDT3wSM5IsgODVDrBNW8eB0k64tWvnNkFM?=
 =?us-ascii?Q?/6/W9DgTqbB4iBy7/jNY8NoxuXmEsswgMl8Yy429jDX2e7FQYqpMyPrZdYNz?=
 =?us-ascii?Q?yDdd8XrhRGmQUxqxNXB1ORKxOY9avyH3I6MSkrewdi8ZlAOMYHxFuTshuZni?=
 =?us-ascii?Q?2kRdV4IPcyEkLlUnvwnnhimih5Cd1J73MsJ/jAycH8TM6CX3T+L+NbN6yGEp?=
 =?us-ascii?Q?DTGPLHw/8KjTColJBxpEX7gJsOetB1RhYXiiwR9uPd6t9dMgtShnvb2yVwCL?=
 =?us-ascii?Q?PoJMaXx4ldFZ/R/KiURh9VaAvoV6b4lPLgDuJCFURI1B/H8iMp36oULS+3bk?=
 =?us-ascii?Q?8vfUdPgSSybW/pV2i4/jFV74r7DFUP9CXOUQdMbF0fqAJY24LRVVRURLkFgZ?=
 =?us-ascii?Q?s/vss49sSqPd2ir+c+jrscGVgJVr+PvMTs9iH8VMoz7fRywG7HNOm0HhU4Od?=
 =?us-ascii?Q?MudNdd3RAg/4WDwf0hGHbdctWgv6n0tIJo69NdQu01IrYHjLVeoE8TEZNxHA?=
 =?us-ascii?Q?kecRlwRFo1+JrnOnU0casHKYZs2q1PQrIA+33tg0sBFBClaLjbOFSA0WvpdZ?=
 =?us-ascii?Q?RCuvb3q/yv/+H6hUoG99A/xKJiAQ0dvJj2RyUBc0zdMnSlLU5+CEI7nXTzXe?=
 =?us-ascii?Q?P38CshUfbvJtdJu8DED5ti8aTSeYemeEKMppqht+hqN5FCbaPncH9nfkX5X1?=
 =?us-ascii?Q?pvcL0GEj1i0AEFjpoDHXCgbYLHOsXWHagO09Q04hbxnw2Gi79Xjgvk3DD6Eu?=
 =?us-ascii?Q?hltlYw7Rg9r1qqPM4cZPuXSwkS9RDOpaIdy3/0l2ltuupNnTEj1l7uBoOJ56?=
 =?us-ascii?Q?AQVmgJzP45dniYh2ZzcFkQGLv0RQ0vLol6ippOPKK/Vkpvesof6aXPnmHZ1i?=
 =?us-ascii?Q?XBjfwwaDurxGVCa6nAHsd8HNMyYRxiRpshOh6gP5BdzPR1Iq9HWi4fPv6p86?=
 =?us-ascii?Q?NwoINYk+TfFV0ZHFfCtY42QrhKs2Pu2iT85CN9zUsQjizLvR1Ixk4165EFiw?=
 =?us-ascii?Q?ncMoooydZ94grU4Ucc3h0KHZj+NyhCjr4fiTsNkcpvAbiVq36WAoMQb/tvJ9?=
 =?us-ascii?Q?4qFAO+iI58xqLt8NcDP8Wc2OxzR6BAmxlwvB4GW7Gwwh9aTvptDbN+V3S/p4?=
 =?us-ascii?Q?VF5eVBdqvp4cSRCO6YEwP2hzBVzZA0T06r1563FmVn19PLA42A/++JFDbj8D?=
 =?us-ascii?Q?8e4TG/CAOig+DVKAfo3VHU/jVPLiHmr85XAVfR/hD29+oMymU1bApcyIZzPn?=
 =?us-ascii?Q?YTYC+6BpB+LzDeV3G8Pz4WRS1ycbI8LqG9QLU9Nuk9DYveipSVGAdSkJrPbO?=
 =?us-ascii?Q?JkoC9l8+rg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: D2E3Ghs2Y8g3wA7MATSELw+QiC+rYYgfMQKs1rowokD73vNVE/dPmw2BAPSQFLgLZ8yBhQzaCLKJp/e8W7jWjcwT9Mw9mjYifZD90aKDS8Y5mBtJaWfEqh/Cir2v40xz/hVYzD7oRAdnrLfVgUvBCY2Tn36RGeV2XkF4s2Fz+2rDcq2AsjBXspE8sIHioMPbBRTmLzu/tBDwmSNaJVzYgQ8HgDwui5iDTmzflbLTI2fmHQjmZFCribQMaEIyE12T7eIeDg9jl4K8/zyxuwL7Y38nWOr9J5DEMI2pGjjC26sYlLz5jUW9HBWgddQz/lta0B18d7BQkZckwUeM/VKI/g==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6116.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7a2e4c7-9693-4637-876e-08dec6fa6b0f
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2026 14:13:17.2309 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9va7bxFTrcw3BrD+HQYg0GXD+IOkbv8DsC6TPEFb216K6hs+/JQTG4WAah+SexZMM0hfro5hWboxbJykjDQIUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6417
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
> Sent: 10 June 2026 15:13
> To: Mandal, Anurag <anurag.mandal@intel.com>; dev@dpdk.org
> Cc: Richardson, Bruce <bruce.richardson@intel.com>; Medvedkin, Vladimir
> <vladimir.medvedkin@intel.com>; stable@dpdk.org
> Subject: RE: [PATCH v2] net/iavf: fix to consolidate link change event ha=
ndling
>=20
> > Subject: [PATCH v2] net/iavf: fix to consolidate link change event
> > handling
> >
>=20
> [snip]
>=20
> > +
> >  /* Read data in admin queue to get msg from pf driver */  static enum
> > iavf_aq_result  iavf_read_msg_from_pf(struct iavf_adapter *adapter,
> > uint16_t buf_len, @@ -249,38 +310,15 @@ iavf_read_msg_from_pf(struct
> > iavf_adapter *adapter, uint16_t buf_len,
> >  	if (opcode =3D=3D VIRTCHNL_OP_EVENT) {
> >  		struct virtchnl_pf_event *vpe =3D
> >  			(struct virtchnl_pf_event *)event.msg_buf;
> > +		if (vpe =3D=3D NULL) {
> > +			PMD_DRV_LOG(ERR, "Invalid PF event message");
> > +			return IAVF_MSG_ERR;
> > +		}
>=20
> This check can be removed.
> iavf_read_msg_from_pf is called from iavf_wait_for_msg which performs a
> NULL check on the same location (args->out_buffer) before passing it to
> iavf_read_msg_from_pf
>=20
> >
> >  		result =3D IAVF_MSG_SYS;
> >  		switch (vpe->event) {
> >  		case VIRTCHNL_EVENT_LINK_CHANGE:
> > -			vf->link_up =3D
> > -				vpe->event_data.link_event.link_status;
> > -			if (vf->vf_res !=3D NULL &&
> > -			    vf->vf_res->vf_cap_flags &
> > VIRTCHNL_VF_CAP_ADV_LINK_SPEED) {
> > -				vf->link_speed =3D
> > -				    vpe-
> > >event_data.link_event_adv.link_speed;
> > -			} else {
> > -				enum virtchnl_link_speed speed;
> > -				speed =3D vpe-
> > >event_data.link_event.link_speed;
> > -				vf->link_speed =3D
> > iavf_convert_link_speed(speed);
> > -			}
> > -			iavf_dev_link_update(vf->eth_dev, 0);
> > -			iavf_dev_event_post(vf->eth_dev,
> > RTE_ETH_EVENT_INTR_LSC, NULL, 0);
> > -			if (vf->link_up && !vf->vf_reset) {
> > -				iavf_dev_watchdog_disable(adapter);
> > -			} else {
> > -				if (!vf->link_up)
> > -					iavf_dev_watchdog_enable(adapter);
> > -			}
> > -			if (adapter->devargs.no_poll_on_link_down) {
> > -				iavf_set_no_poll(adapter, true);
> > -				if (adapter->no_poll)
> > -					PMD_DRV_LOG(DEBUG, "VF no poll
> > turned on");
> > -				else
> > -					PMD_DRV_LOG(DEBUG, "VF no poll
> > turned off");
> > -			}
> > -			PMD_DRV_LOG(INFO, "Link status update:%s",
> > -					vf->link_up ? "up" : "down");
> > +			iavf_handle_link_change_event(vf->eth_dev, vpe);
> >  			break;
> >  		case VIRTCHNL_EVENT_RESET_IMPENDING:
> >  			vf->vf_reset =3D true;
> > @@ -505,6 +543,12 @@ iavf_handle_pf_event_msg(struct rte_eth_dev *dev,
> > uint8_t *msg,
> >  		PMD_DRV_LOG(DEBUG, "Error event");
> >  		return;
> >  	}
> > +
> > +	if (pf_msg =3D=3D NULL) {
> > +		PMD_DRV_LOG(ERR, "Invalid PF event message");
> > +		return;
> > +	}
>=20
> This too can be removed.
> pf_msg resolves to vf->aq_resp which is a fixed buffer allocated at drive=
r init
> time. It cannot be NULL here.
>=20
> With those two changes I think the patch will be good to go.
>=20
> > +
> >  	switch (pf_msg->event) {
> >  	case VIRTCHNL_EVENT_RESET_IMPENDING:
> >  		PMD_DRV_LOG(DEBUG,
> > "VIRTCHNL_EVENT_RESET_IMPENDING event"); @@ -518,30 +562,7 @@
> > iavf_handle_pf_event_msg(struct rte_eth_dev *dev, uint8_t *msg,
> >  		break;
> >  	case VIRTCHNL_EVENT_LINK_CHANGE:
> >  		PMD_DRV_LOG(DEBUG, "VIRTCHNL_EVENT_LINK_CHANGE
> event");
> > -		vf->link_up =3D pf_msg->event_data.link_event.link_status;
> > -		if (vf->vf_res->vf_cap_flags &
> > VIRTCHNL_VF_CAP_ADV_LINK_SPEED) {
> > -			vf->link_speed =3D
> > -				pf_msg-
> > >event_data.link_event_adv.link_speed;
> > -		} else {
> > -			enum virtchnl_link_speed speed;
> > -			speed =3D pf_msg->event_data.link_event.link_speed;
> > -			vf->link_speed =3D iavf_convert_link_speed(speed);
> > -		}
> > -		iavf_dev_link_update(dev, 0);
> > -		if (vf->link_up && !vf->vf_reset) {
> > -			iavf_dev_watchdog_disable(adapter);
> > -		} else {
> > -			if (!vf->link_up)
> > -				iavf_dev_watchdog_enable(adapter);
> > -		}
> > -		if (adapter->devargs.no_poll_on_link_down) {
> > -			iavf_set_no_poll(adapter, true);
> > -			if (adapter->no_poll)
> > -				PMD_DRV_LOG(DEBUG, "VF no poll turned
> > on");
> > -			else
> > -				PMD_DRV_LOG(DEBUG, "VF no poll turned
> > off");
> > -		}
> > -		iavf_dev_event_post(dev, RTE_ETH_EVENT_INTR_LSC, NULL,
> > 0);
> > +		iavf_handle_link_change_event(dev, pf_msg);
> >  		break;
> >  	case VIRTCHNL_EVENT_PF_DRIVER_CLOSE:
> >  		PMD_DRV_LOG(DEBUG,
> > "VIRTCHNL_EVENT_PF_DRIVER_CLOSE event");
> > --
> > 2.34.1

Hi Ciara,

Thank you for the review. Removed those two unwarranted NULL checks.
Sent v3. Please check.

Thanks,=20
Anurag

