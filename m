Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39B92CD98C7
	for <dpdk-dev@archiver.kernel.org>; Wed, 10 Jun 2026 09:43:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 19C0340270;
	Wed, 10 Jun 2026 11:43:30 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by mails.dpdk.org (Postfix) with ESMTP id CA7B94026D;
 Wed, 10 Jun 2026 11:43:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1781084608; x=1812620608;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=QBpYmEZDt1PBnO27SiTAHlpHLD03DmHhzABsXXBEyHo=;
 b=iKX2m7kM7SbU1ZaGJj7uxzUkY9CFIDHYzLgek0Rjcjs8NoKN4hjrxeR8
 dfEWWPL4t0UjZzVcVeJO3ddPfOIChaAnR3AbumWrGU9xesbsK8IK9+KYS
 SAPNuVei1PrTRYWOO66T6q/DMl1egHSfh2Bd5ORPfPHhJfbSMrUAhGNxw
 pAlai7zXmebaZnHWVtzRxXWPF/CAGBoX6Jgf7GmqzJaXW7Ea410EO7xl0
 kOkQU2SXdSjcxbEbB0PFNLFqWXWTksB9hw35nemTbJ3syl2M3YO5jfP/F
 vO0W2uWDvXs5dQM7+96U0TsCxIRM4YWM1mbF7F0d++TZxLIDrUjP9G/Qd g==;
X-CSE-ConnectionGUID: Gsyye3lhRiqLmZJyd4sciA==
X-CSE-MsgGUID: h4PjKbklRfaPs72fKq7wiA==
X-IronPort-AV: E=McAfee;i="6800,10657,11812"; a="82064947"
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; d="scan'208";a="82064947"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jun 2026 02:43:27 -0700
X-CSE-ConnectionGUID: 7dklOmtlSaagOeW9JO/0PA==
X-CSE-MsgGUID: CTmor0uVQ5GvuE8W2OjMXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; d="scan'208";a="241697279"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jun 2026 02:43:26 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 10 Jun 2026 02:43:25 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 10 Jun 2026 02:43:25 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.4) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 10 Jun 2026 02:43:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NYdFfIl+YqXUEUxnKCVnoOvzLYPdmiXo1E6VR+Bq1nnsBB0CFfob6w1Mx8rM05W9m0GKk3TtzKbsUMQ7bDrUApP2HmTR7u9N9OHPxIPUNbPmfHC1fak+O3CBzC5NU9UEQOwFc6Xv7Px3xxwv+ym13NXQ/OHp2nG1W96R+6XWaakLBMT3z9/TpJGSuqUuLkfJC4zLDyZNdDrWQLjQetktN3RNephx2sMKezVED6pVYsPDzglV/vj8pr8ICwwLyKZHCO5+aV3gbDASgIqmhPmvrGwPArViAbBpodBQj1UbMaSFBj/psjajEnPBU9g7gDb9wwGtgAuU6GY3Z2DUgJaLOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HGxwE2loV5Wd+BSbPIwLkvI3/XXbSm35MsxjsFrO+jk=;
 b=ZJLB3LzMGTfMD0EDi+n9lkiDsTxo0/15/wWtpTl7Xj6oYdlqfipE6UeVSSjZ5lNbTsExtshqojawtNidnAaqIEK/chyv5SIRbIAVZFg3xtprfqUnQ146tODRaj/xOUKKIaAo8jdN+3lk8fJhfEvrsuhtmgh9A2+TzyEjEW/d2MqRCDT2RC4UUw7/8Hwg94Lel10RYSgVIWl+Emq9c7xuC8XmwRtSZz5H9eV7E3swOccE/Od0ZGHSJMC1HfDZg72VK9a1CPWIB6+VpLzfdX8lUzSq+2966PQKUIWtC/pedIiYoT0ekbWsXbcBEC9bJ1bwVYLRnDHSY8RLIhmUZKsWLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA4PR11MB9278.namprd11.prod.outlook.com (2603:10b6:208:563::12)
 by MW4PR11MB6715.namprd11.prod.outlook.com (2603:10b6:303:20e::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Wed, 10 Jun
 2026 09:43:21 +0000
Received: from IA4PR11MB9278.namprd11.prod.outlook.com
 ([fe80::9bef:c20f:571f:7057]) by IA4PR11MB9278.namprd11.prod.outlook.com
 ([fe80::9bef:c20f:571f:7057%6]) with mapi id 15.21.0092.011; Wed, 10 Jun 2026
 09:43:21 +0000
From: "Loftus, Ciara" <ciara.loftus@intel.com>
To: "Mandal, Anurag" <anurag.mandal@intel.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: "Richardson, Bruce" <bruce.richardson@intel.com>, "Medvedkin, Vladimir"
 <vladimir.medvedkin@intel.com>, "stable@dpdk.org" <stable@dpdk.org>
Subject: RE: [PATCH v2] net/iavf: fix to consolidate link change event handling
Thread-Topic: [PATCH v2] net/iavf: fix to consolidate link change event
 handling
Thread-Index: AQHc+DbAR8jb4uBnHEaIYVs+AihlnrY3g0SA
Date: Wed, 10 Jun 2026 09:43:21 +0000
Message-ID: <IA4PR11MB92788A795E02D08A3287C3628E1A2@IA4PR11MB9278.namprd11.prod.outlook.com>
References: <20260609001022.357509-1-anurag.mandal@intel.com>
 <20260609173822.364452-1-anurag.mandal@intel.com>
In-Reply-To: <20260609173822.364452-1-anurag.mandal@intel.com>
Accept-Language: en-IE, en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA4PR11MB9278:EE_|MW4PR11MB6715:EE_
x-ms-office365-filtering-correlation-id: e3ff1d93-a25c-48a1-2e3e-08dec6d4b566
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|11063799006|4143699003|18002099003|22082099003|56012099006|38070700021;
x-microsoft-antispam-message-info: vXf17JadkqWw81Fe5XtHMw+RmISI16ZYWt76UX3J26SG4Lgs03IuHJjCfCiFo1UFrG0w8r+H4L7ZatCiZR/8pFrLp7NII9mUvvMxW8CcWVy8lYtPdq7EM3AG1gxp9MSte9hMPajCLMF0yKdG4x4s0rMsWN8hMy1dT5PVSVCcU3ipj0VVMoPGQec5LcYxLsoXFw8CpM8MCt12JrIJw22c9xQMNTwflWjfWIDMK5LN/ac6BtfLXZBXbAUTze1lVmYwK+iwGEgeWS1Un2y7YB6KcTTFxfK6By4JG6fQmd9axvGCbftN9ajdkzqi1fi6X6CgW3LxePHekreZP3YUSQ0V+/lnbcIPZ82uKgWbJl4wrt8ftyLiRK51c1MmAZM8pY6ARbLXKDBQQ2LX9KBmY2nNqme7LvU56GNFW2pfPC0ucFzJSaT4gwg79R+Aslr34IdmX70C0uAGVvx9saibh3e+glMP1OijTrLdLvU0G5r9ktrMsEycD83yve5FYwcYL4Bx2qxweuIhkP+E+/BP9XCHl6RDbGQ9VzR5TCa9UA3IhLWsvOe7iML3zSvmkseiJzJMmjQQRec14WFv59uLqXsizJFpXrciBIbq2lCkEi7z4a47e9iM9foVbcaKGPyNIzR+L+SnEhjZMw8a/KwNlLii1ueDKu+qavr8NWOE6oL8O4IKfrPXI7ut5Q8XBb+z0ZoDZUbGS8SOGSgA64wbe2uJ6wyMCG2ICUqez46xorXgmTx+rKqT2iCaSBw/63Yxqk6a
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA4PR11MB9278.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(11063799006)(4143699003)(18002099003)(22082099003)(56012099006)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?M3r+yknoJQ3QZQjDLkyJSqHOYulOoUSN2+RuEo5x+GBm9wxhAnJuWri3HWOo?=
 =?us-ascii?Q?iy8S1utTMa2qbklEBovy4sz/HO4cRSd/NNKHZ9FfU2JsibQDTSyQvFLWgqFO?=
 =?us-ascii?Q?naDu4BKBKM52SDVwFB6074c4Dpuw/3jB/Bfa+d8Mo/OYTKyilxHF7fsK1BcZ?=
 =?us-ascii?Q?ddo+KUyI9f2GGy7bzj4lGld/o+6/W/Gdv31gROXhvOgxOAdea+AsmLpByv7K?=
 =?us-ascii?Q?RAcmnU+xyFcPm13JZEr/8QII+XHTVnemx7d9Zgx8Pj0ra7HuVGUrWKgb3up/?=
 =?us-ascii?Q?QqYCd+wq9uFs7KtJ0DYijOF8KaW/XhRndd4nEwQjAKdYzgEWHkfoFUf56oyg?=
 =?us-ascii?Q?3jYxgY90wSox6q0EXQbzCMUNvcFuThh6oZPfZWJTRc0gqYyJ7kpGtFmb6+K6?=
 =?us-ascii?Q?UB6u6ctmF5438fXxHCuQcbl0DZ3K7ORzJeS7shsiCdPj/KABwit4aA+GCiFk?=
 =?us-ascii?Q?BmYJzNh7UznBuFZaumFP2iN9ryNm5G1GztBGxU/9q1DtKf8GTMrGH44A2gFc?=
 =?us-ascii?Q?FurBvZdqe/hPabXfxo3DOSm24QLbrltuQoUbUZrXzN738re4GcAafvvnh+Ln?=
 =?us-ascii?Q?tvekoB32Xpny8VEr4Hmr6b8EdlwzHjvTQi/u+WOE4MP58H1IloAzK6n0f1De?=
 =?us-ascii?Q?3oVXbvFouJn7MbuXjMvX8OD4QSeI/n9Fl6sG3iOfdTn4U1fd9accewcObF2s?=
 =?us-ascii?Q?trIz37ni22kIkySLz4I9sa5oIxuYeZzoFJkfTEexREvnDWsrMqi9PNV9kNvD?=
 =?us-ascii?Q?W+gWb4RzIzL3OzywO3/COhqS1nb4IeJ2l9dsEmX9OB9iWesnXOJLmuG8DKkm?=
 =?us-ascii?Q?UIYbP8zWavKZmPUZYLPxyu5uWrJFIrcnlYdt7wZEbaS2wLFwED7LMKTcvAVg?=
 =?us-ascii?Q?GyBxgss/7995qmGqvKcgj+13Bkp44kF+9IqxLy5e9yc3ORjoO5Iy3xK5pnp6?=
 =?us-ascii?Q?7eA2lDhKR+AIcFfyYcmTSZCNmG7cd/X5tPGFHeBq3qZ1CjvwAfhq3dDkIm7b?=
 =?us-ascii?Q?xKAoJioNub4VoADF/1uuYnjaZaAnN0F4SNpMiaWI9BmwiDL7iLyJFh0rhXfr?=
 =?us-ascii?Q?qisjjcqgadH8wfbPiVQWuur0akhpVi1U931dHApZ7tl9L3aozZllMdc3PSki?=
 =?us-ascii?Q?sTpsAPagZxNc3Y//S2aUazG+ffltzFU/G8qUrtDI7V5mApQ58b9/V6L0mRKb?=
 =?us-ascii?Q?v/RrNdcLP8B1F78AAsHJajkvxMvF1Z69YfCMqxH1w/nNHmt1ZRR/V+W8ilPV?=
 =?us-ascii?Q?Ic0lu6Q1PdYKFoMuWMhZIRR6nDYI4NhEu4TqR1dytSV/F40s+1ERsytXowSn?=
 =?us-ascii?Q?AMN2QUpWQ7cX/55zqDm/Nb13chgBkmOM2l5n1H9Nem1I3al+2lo/rf3+gzML?=
 =?us-ascii?Q?QxRtTft1NGSkprWArx9grGToiXF0941jk7yVftcQstBS2gwgoMRHK46mY2gl?=
 =?us-ascii?Q?4zwjD6qPD1krBr5fiIoihy0vsWI33xqrgVQA3MkSKceml0UIi5l+TVqYEt5M?=
 =?us-ascii?Q?ITuy7emzqoVQbipbH00N/iu697ILSk2cz055zbPt3lG0AXwU25/QvOsqsR6p?=
 =?us-ascii?Q?i3LbPX0tnwyCEA3cMAwTzuPqcB/NNIvrHdC6JOKKqKEgMrU4zcCoK41BRSSv?=
 =?us-ascii?Q?yTqDwhUEhUdpNMD0/zD3ve5EXX0x7sBBE1MtY1e/J8GpqFxCBk+Qfj6Ga14P?=
 =?us-ascii?Q?R71LHrSGFmczhMVmwluT/jqlIVGL/E+G4KSLTbNf/Zf+V9Cw1kFMaEoGin96?=
 =?us-ascii?Q?TS78SBtxbg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: oOo10T+ZMD7407RFSQa8loZ+eiPYrlr7RaK47lkYa2pX7aAUVfp0g+ssr68v3EL4q37DQKar3oEmOlghkGtUKMjRELPRKnsxJPH/2PHeAnrWZDvQ9Dbvx5IzjYpifinucg5Fpb0fdxfm2kbgs4jYyLxqW/i5ZPr/08jVfohu3BDTp93kIOaLryGkGBK/NALyJXiQdRWJTRB6JmYWhYy8TxmBPeas2gALi2yVrWRXpWMvCYBdK82dlmI6N70sPhZM1C/0yxXYG/GNo5iiU7JZeyx9lNdlKejib5t2ZIxbrBO4CcIkD/mxZClg4Q+p3x0SKJqaUQZHrD5tfpJa/6JPyg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA4PR11MB9278.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3ff1d93-a25c-48a1-2e3e-08dec6d4b566
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2026 09:43:21.1582 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vt/kCfXDgbYUXWUykpiA9nGFKaFxUzQ9MhuF57DsM3SYr94+9wTqV9dqp96fLvdfLsGRhjg3pAU5q0KCj8hsmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6715
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

> Subject: [PATCH v2] net/iavf: fix to consolidate link change event handli=
ng
>=20

[snip]

> +
>  /* Read data in admin queue to get msg from pf driver */
>  static enum iavf_aq_result
>  iavf_read_msg_from_pf(struct iavf_adapter *adapter, uint16_t buf_len,
> @@ -249,38 +310,15 @@ iavf_read_msg_from_pf(struct iavf_adapter
> *adapter, uint16_t buf_len,
>  	if (opcode =3D=3D VIRTCHNL_OP_EVENT) {
>  		struct virtchnl_pf_event *vpe =3D
>  			(struct virtchnl_pf_event *)event.msg_buf;
> +		if (vpe =3D=3D NULL) {
> +			PMD_DRV_LOG(ERR, "Invalid PF event message");
> +			return IAVF_MSG_ERR;
> +		}

This check can be removed.
iavf_read_msg_from_pf is called from iavf_wait_for_msg which performs a
NULL check on the same location (args->out_buffer) before passing it to
iavf_read_msg_from_pf

>=20
>  		result =3D IAVF_MSG_SYS;
>  		switch (vpe->event) {
>  		case VIRTCHNL_EVENT_LINK_CHANGE:
> -			vf->link_up =3D
> -				vpe->event_data.link_event.link_status;
> -			if (vf->vf_res !=3D NULL &&
> -			    vf->vf_res->vf_cap_flags &
> VIRTCHNL_VF_CAP_ADV_LINK_SPEED) {
> -				vf->link_speed =3D
> -				    vpe-
> >event_data.link_event_adv.link_speed;
> -			} else {
> -				enum virtchnl_link_speed speed;
> -				speed =3D vpe-
> >event_data.link_event.link_speed;
> -				vf->link_speed =3D
> iavf_convert_link_speed(speed);
> -			}
> -			iavf_dev_link_update(vf->eth_dev, 0);
> -			iavf_dev_event_post(vf->eth_dev,
> RTE_ETH_EVENT_INTR_LSC, NULL, 0);
> -			if (vf->link_up && !vf->vf_reset) {
> -				iavf_dev_watchdog_disable(adapter);
> -			} else {
> -				if (!vf->link_up)
> -					iavf_dev_watchdog_enable(adapter);
> -			}
> -			if (adapter->devargs.no_poll_on_link_down) {
> -				iavf_set_no_poll(adapter, true);
> -				if (adapter->no_poll)
> -					PMD_DRV_LOG(DEBUG, "VF no poll
> turned on");
> -				else
> -					PMD_DRV_LOG(DEBUG, "VF no poll
> turned off");
> -			}
> -			PMD_DRV_LOG(INFO, "Link status update:%s",
> -					vf->link_up ? "up" : "down");
> +			iavf_handle_link_change_event(vf->eth_dev, vpe);
>  			break;
>  		case VIRTCHNL_EVENT_RESET_IMPENDING:
>  			vf->vf_reset =3D true;
> @@ -505,6 +543,12 @@ iavf_handle_pf_event_msg(struct rte_eth_dev *dev,
> uint8_t *msg,
>  		PMD_DRV_LOG(DEBUG, "Error event");
>  		return;
>  	}
> +
> +	if (pf_msg =3D=3D NULL) {
> +		PMD_DRV_LOG(ERR, "Invalid PF event message");
> +		return;
> +	}

This too can be removed.
pf_msg resolves to vf->aq_resp which is a fixed buffer allocated at
driver init time. It cannot be NULL here.

With those two changes I think the patch will be good to go.

> +
>  	switch (pf_msg->event) {
>  	case VIRTCHNL_EVENT_RESET_IMPENDING:
>  		PMD_DRV_LOG(DEBUG,
> "VIRTCHNL_EVENT_RESET_IMPENDING event");
> @@ -518,30 +562,7 @@ iavf_handle_pf_event_msg(struct rte_eth_dev *dev,
> uint8_t *msg,
>  		break;
>  	case VIRTCHNL_EVENT_LINK_CHANGE:
>  		PMD_DRV_LOG(DEBUG, "VIRTCHNL_EVENT_LINK_CHANGE
> event");
> -		vf->link_up =3D pf_msg->event_data.link_event.link_status;
> -		if (vf->vf_res->vf_cap_flags &
> VIRTCHNL_VF_CAP_ADV_LINK_SPEED) {
> -			vf->link_speed =3D
> -				pf_msg-
> >event_data.link_event_adv.link_speed;
> -		} else {
> -			enum virtchnl_link_speed speed;
> -			speed =3D pf_msg->event_data.link_event.link_speed;
> -			vf->link_speed =3D iavf_convert_link_speed(speed);
> -		}
> -		iavf_dev_link_update(dev, 0);
> -		if (vf->link_up && !vf->vf_reset) {
> -			iavf_dev_watchdog_disable(adapter);
> -		} else {
> -			if (!vf->link_up)
> -				iavf_dev_watchdog_enable(adapter);
> -		}
> -		if (adapter->devargs.no_poll_on_link_down) {
> -			iavf_set_no_poll(adapter, true);
> -			if (adapter->no_poll)
> -				PMD_DRV_LOG(DEBUG, "VF no poll turned
> on");
> -			else
> -				PMD_DRV_LOG(DEBUG, "VF no poll turned
> off");
> -		}
> -		iavf_dev_event_post(dev, RTE_ETH_EVENT_INTR_LSC, NULL,
> 0);
> +		iavf_handle_link_change_event(dev, pf_msg);
>  		break;
>  	case VIRTCHNL_EVENT_PF_DRIVER_CLOSE:
>  		PMD_DRV_LOG(DEBUG,
> "VIRTCHNL_EVENT_PF_DRIVER_CLOSE event");
> --
> 2.34.1

