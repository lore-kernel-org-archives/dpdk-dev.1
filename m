Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71C58CD8C9D
	for <dpdk-dev@archiver.kernel.org>; Mon,  8 Jun 2026 16:32:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B8E09402DD;
	Mon,  8 Jun 2026 18:32:55 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id 4FCA54029D;
 Mon,  8 Jun 2026 18:32:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1780936375; x=1812472375;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=wLKPBd/pxdmbUs6rLVAhiVog4obUOiIhUZm3r+8n3VM=;
 b=cfVJhbty7++BcwzdrJ3Z5EeKE5PcPcf4OyG4sOWZx6/7WsjrFVv/kfWI
 /u+wVK+3xU3TMiMkknDbEe5ptbMCQBrfqapsxh06pOtSlubGlnoS2cKvG
 vtjBgNd+qJOlU8NPT1xUd+fbKFr8wpp9Yh8JBY2vxBjzWu6PlglaPlD+0
 wFO6O4qVHX5yCPmfW0ozVJgQ4RBnnjzt6aVFMUHjreuiCXJZ6e5vV4QJw
 r2ukVM4OctWYNyUViE18GlTqN9j5+gr1nz2u4ztI65Sm7Mv0dL+AEYl2L
 swMEMG4N921ZuBSZb6N1MFKJTBe7ju4yusB2hdf8EJRD1RPuyulFIHu62 g==;
X-CSE-ConnectionGUID: sTKNTRDSQ3W/65bbE3ryOA==
X-CSE-MsgGUID: eA83BounTbCOpf8uzkYrhg==
X-IronPort-AV: E=McAfee;i="6800,10657,11811"; a="85303928"
X-IronPort-AV: E=Sophos;i="6.24,194,1774335600"; d="scan'208";a="85303928"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jun 2026 09:32:53 -0700
X-CSE-ConnectionGUID: s2taLPtfRJqb2P1ZZqvtlQ==
X-CSE-MsgGUID: QXY7FsmfRiOYnJeTGUUvoA==
X-ExtLoop1: 1
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jun 2026 09:32:53 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 8 Jun 2026 09:32:52 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 8 Jun 2026 09:32:52 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.24)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 8 Jun 2026 09:32:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TIXfprPB7/BcEsE1BqWRN59B+oCLbijvHpUsmi8RhH7MiVZBjkAnmjen4lQb0mpprAAaj8udxQ3nL/BSdnh3DlO1ZUqk5e+IboplZT7U/R08n8GlEKuJIwlxgVH+tSGG+lf29JCy72IG9Tr5UlFJFHF4IiofRs+kUe94d02ehtRuoyYiU/3dVuEyuVT1UKGuMkEvDXCFb9eL9C5cR37gFFfd8HjYNi8tJ9Id0jVTsJKHMytAvNgAM/U5coepxZwxcXwAYBKb6vZwl+OSooYzWd4LswDkNOIkXVMnraYSu8pnQnBbpvpf3iAsVNXMAuQOmMkhxV14NHgU11cqAoxR1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BPFf41habVLGddRMJ3L60Etvr7BArUuHVSb7y3fiR+8=;
 b=dcPeSVTewn9ATppbzfc+hOS2KpWpt6SL43JNzgmC0HxiS34oHJVGwLMXqNaRKpYwg4QOCUS3/q0RY49rr03aj0pZIuMEDctpqDDu7FtLg1ENVfIw1Sfb0KoJ9NQ68iac7EVRnIXiHvJTC3EdL26PuWDnLBF4tBiaPWX7hhzYzFv0rwnYok/QHqJhA8hM7qWJsRx7i+SJketQNs0GRqlLgGtlnDNwGzip6DJNmoQx6bWaaSuoR7H+tiDOWxUpEs8BmOu/WFq4DIyedQ8a8XOSJe/eDyaH92EQeovUWDC8BqpOYmpViut2IEf/9ZrZX2oQnde0mxutww8jK5cKsBJyrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY5PR11MB6116.namprd11.prod.outlook.com (2603:10b6:930:2b::14)
 by CH3PR11MB7842.namprd11.prod.outlook.com (2603:10b6:610:128::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Mon, 8 Jun 2026
 16:32:46 +0000
Received: from CY5PR11MB6116.namprd11.prod.outlook.com
 ([fe80::7243:ab06:2282:cd8b]) by CY5PR11MB6116.namprd11.prod.outlook.com
 ([fe80::7243:ab06:2282:cd8b%5]) with mapi id 15.21.0092.011; Mon, 8 Jun 2026
 16:32:46 +0000
From: "Mandal, Anurag" <anurag.mandal@intel.com>
To: "Loftus, Ciara" <ciara.loftus@intel.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: "Richardson, Bruce" <bruce.richardson@intel.com>, "Medvedkin, Vladimir"
 <vladimir.medvedkin@intel.com>, "stable@dpdk.org" <stable@dpdk.org>
Subject: RE: [PATCH v3] net/iavf: fix duplicate VF reset during PF reset
 recovery
Thread-Topic: [PATCH v3] net/iavf: fix duplicate VF reset during PF reset
 recovery
Thread-Index: AQHc9wne8jXjvuSnOE6AqYdI1JyuVrY0bK0AgABtm2A=
Date: Mon, 8 Jun 2026 16:32:46 +0000
Message-ID: <CY5PR11MB61161217C0F205EC2B1C52B0E41C2@CY5PR11MB6116.namprd11.prod.outlook.com>
References: <20260605202911.314359-1-anurag.mandal@intel.com>
 <20260608054433.351880-1-anurag.mandal@intel.com>
 <IA4PR11MB9278AB660100B34D0001DC478E1C2@IA4PR11MB9278.namprd11.prod.outlook.com>
In-Reply-To: <IA4PR11MB9278AB660100B34D0001DC478E1C2@IA4PR11MB9278.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR11MB6116:EE_|CH3PR11MB7842:EE_
x-ms-office365-filtering-correlation-id: 34198881-1c66-4dda-ba11-08dec57b928c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|11063799006|4143699003|56012099006|6133799003|38070700021|18002099003|22082099003;
x-microsoft-antispam-message-info: UTUPYC/OcGPMcH/IF2oo0cl6wmus6WOS1d+9ZESNjXjVxs2rl5L4sAB5MXfbrm+Nn/85STk2FK/FZE2Q5vPz9rAoduG527+dThu4byO0SkRbb/TpMyN/xXOGbnxAZg+1mQ0cqdAYqiKQI7IRTjXYUmLkZauXqecZYmxRCQrB1AgJ6z2Vb48P5oiDD9p4uc0oihRZvSuygu7nnB7pbl5atAX1RflXgDW3Vh5wAt2LNVhRVZTWcSso8vI1KXBnkhXJvQSr9vawfIKag3QgjTTa/iPgE5dK+c2NN7aiOr9VrB22L4G/DPoOH7UjdRE7yQgeB182nd9njAbAstzs8VyPtF3yMDBtFnijtPlY6NAIFAkaZno9nlcAPrIgYX/3P+C0Ka7d+nhVnwNEvlzULBfKf9peAfz9wG+mWSsPnm/BjOaq06NzD3SxjvMYHlvo52M3RJC9Ik4XpO2LgFRRtpvGUa2cmWph38bdKI7YaZNRZh8oGUy2GA6csquwiBB3jR7VAPpJdH0z/SyY97eDnoaKWoLV/sY6KYWvI9mB2G2/QiXU9cFdnjCs4fZZB9bh/pmUpsm6ME5j3IzJ/zNf/5inoeaOvv/XYGjmHVDug2qaZwnrrh7Lw542CNjfMdDent5b0tAalvjlzbE5d0WZNtBzkis5lrkdzyzEvnn7ksvHgLjt6MZyVyyfyvIZngbzzcvkf9EQyPAKqeikzikCBCAkISIYRvqPqI14wRdBw8Vjde6Go9JqqhdFqY2BIewDBMpN
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR11MB6116.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(11063799006)(4143699003)(56012099006)(6133799003)(38070700021)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?4AbK9dgfhJA8XEacZtMQv6RuDfAdLjplZDphaQ2n3a5gOv+vlfS/HtTmJ0H5?=
 =?us-ascii?Q?s6jZNqy5KYisVQ5G3DQBatoPEuLmJ33CN01UD823zpKsShAZXyC5ytVkG4MA?=
 =?us-ascii?Q?99AcFe6ZLQESMw64okp9meoqhc2cR5gbM5cieC8HMN8YtTSYVUpF9UjiI7+W?=
 =?us-ascii?Q?u1zgFTQSncztXh4QtoRuNwWjjiiVlG50NPtGIyEY7v7ovKABGTcV3x2ParfJ?=
 =?us-ascii?Q?/+E2OnKhqqqxz3b5PsPItf6rv2Gh76YeTbbiBUwLQs2jj3DYMejIwRYxo7Ho?=
 =?us-ascii?Q?kma3qC1FJMgicFzvf9dnGCyeHX2vqYaCfcgSsR9M7HqSXsQkNWcKVAXTv42X?=
 =?us-ascii?Q?NdFTu3UX0r8VpeZ5T0buN0roC1GLRTc1BCmlSQqPZBoxV9w2FXU2NG1R8DXU?=
 =?us-ascii?Q?HxVAhTYh8gXiHxrzTwJ/dUGs3EdaUIo5ncbd8gJpGb6nHDw5BdCk3gmLYxCL?=
 =?us-ascii?Q?VZu4CsfwGjuIsDZhooIKITlmz3w/wVmpbpBZ0ksSRouOjRwUpAMMyh+XlcfO?=
 =?us-ascii?Q?J9RDQt63m+gP+7U0DeaDUhoRheadbNQQrp2Tn7qeL4OXhkjDrl8SgeWUXcU6?=
 =?us-ascii?Q?UAA5oyDILRUAI1/ASbDvNZThveUsSPOxZQOLrxBiVWzf+upEzL3c0zy8hRof?=
 =?us-ascii?Q?OJLdQnF8FE3W8V68XMsz9RP8VAGW1ixqA5Uikko4zt+fu94uSB/SOu/gYM6z?=
 =?us-ascii?Q?tsGOwj75hpuDeGxNvVu1kciwczBWGKax2CTj+tpb0Ob+LI2ts0AphpD+UfQZ?=
 =?us-ascii?Q?kAxjwX2J436lhFLjgCVPrqlgxlv2ggS2XPE93l6hN6IwTe42y/DOMibkaTbS?=
 =?us-ascii?Q?zUfPvsL1nqB+ey60svmWwvO8Lo7BRe7yjQkhjD63adKLBChQeGG8x1nV9lai?=
 =?us-ascii?Q?f6y4+a3Dvwe0HWLNgCih5mD60WFFVQ9M48J4j62dpDG1itWJB37HVY3Jr5DC?=
 =?us-ascii?Q?7H+rSJrXDf+qkxgXiYpRegibOi9UN7ZpGFNCW6EB2OUyFOj5cbxXlq8wAZF1?=
 =?us-ascii?Q?5d0wmqKHZlAJT4PUIxmM4O1z2BzG9SK2thZXkSyM7IVNWP33lg9I/riBKgwf?=
 =?us-ascii?Q?8sbVXAkD26eqxywvnClpTI/Rsw/xL25r0LnEoX1TsUN7t4Hw85pHOj/MfGsB?=
 =?us-ascii?Q?Djp/b/A4deY/K+9boCXE/cZu+tR4/7hB5J/dOPhKlvek5hUA6h6IeE1kEkHH?=
 =?us-ascii?Q?oc7LBiWth/xF/+rWvGI2Ht5spjotDPh1SeKqpyjgKZL45oyQUxVFUiHNvoWH?=
 =?us-ascii?Q?UN9W/EL9mBcCjoB+u89LGwuBgcnFEAPAT4Y+qr/hZBiWcG+ATz+WcSUi2tIJ?=
 =?us-ascii?Q?nBUPLa++dulU7d77+XvLARBEHFVezpOAlTHdX2gNWYqtQr/K7KH3/Z7On0Bl?=
 =?us-ascii?Q?0YKSjqCF366A+45/+UQByaLVptIL0jWb/fazoSzZeQ2Nu6fzokYLnVteqLEa?=
 =?us-ascii?Q?GF5en8enLgcgedPmztFPG4LJ+Zkd4zRuRVK/cgO8feljM8UcVQUuRr7CZUXt?=
 =?us-ascii?Q?Tf6f5dLiMss65tIWBB1vk1aTZ+Gu7HmbQh1KpgUPvdf61UpL2xDHohmAQwCH?=
 =?us-ascii?Q?Az0/Pgs9mWuEGxuxF852KUVBl+rj6NcIraMvsHBwI//qdBvuy2wtHyprvp5X?=
 =?us-ascii?Q?1dlfNkRKlBPqW4yW/WjpLG0857W5rwzgFPegSWY0/I53PQXx7T3Ks8Wj1Kkv?=
 =?us-ascii?Q?pt763w4rNfsFiM5ZbTBlN/otuXrQ3coJqP8i2xTpjjNUQl8J79Ld92vqDQkt?=
 =?us-ascii?Q?ob0vqaoo7Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: oURbcQJiRlwtCaDdZ5CPxZliGsrpWyYdR5nqPOldArxrmA9RfMB7nLSFD7gd3ELL+6OWgslzzZ9i4mwe/dXTfjdHM+1eQywdDNYB6k1DD1t1lewa8cFyC8sEi9BfsIyHEf18edok0eNPwu6Iyw9yC6E/CN4ZJjuQFYPCvYvhvBjyc0rIWQLWKWqNHwKPQ1kHUXDImfum9wPi0ks4iMFlv7Yxkv0Pz1FSxT6Evay7D6SKRAO65hsmP52wUz7TcVprDKle4v2ClQ1tkPxZgTmPt/ZcQ/FSCr7HsVpaz2wbOtxIkkb92MkQtTkcvnXRZoDAOsj6c60bEbeGoRVWS+JTiA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6116.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34198881-1c66-4dda-ba11-08dec57b928c
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2026 16:32:46.3310 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oMuZYENIoHx8QLYuHeZ4oG+RXScSHW6cyiEEvQiF9rT/WHMWNkgtDAtZC5ynYy4Hh6zIb8kWt6h3jGpJLRtltw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7842
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
> Sent: 08 June 2026 15:29
> To: Mandal, Anurag <anurag.mandal@intel.com>; dev@dpdk.org
> Cc: Richardson, Bruce <bruce.richardson@intel.com>; Medvedkin, Vladimir
> <vladimir.medvedkin@intel.com>; Mandal, Anurag
> <anurag.mandal@intel.com>; stable@dpdk.org
> Subject: RE: [PATCH v3] net/iavf: fix duplicate VF reset during PF reset =
recovery
>=20
> > Subject: [PATCH v3] net/iavf: fix duplicate VF reset during PF reset
> > recovery
> >
> > During PF initiated reset recovery, iavf_dev_close() sending an extra
> > VIRTCHNL_OP_RESET_VF while recovery is already in progress.
> > That second reset can leave PF/VF virtchnl state inconsistent and
> > cause VIRTCHNL_OP_CONFIG_VSI_QUEUES to fail with ERR_PARAM after ToR
> > link flap/power-cycle, leaving the VF unable to recover.
> > This results in connection loss.
> >
> > Skipped close-time VF reset and related close-time virtchnl operations
> > when PF triggered reset recovery is set. This is done to avoid a
> > duplicate VF reset, and keep normal behavior for application-driven
> > close.
> > Handled link-change events through a common static function that reads
> > the correct advanced & legacy link fields properly and updates
> > no-poll/watchdog/LSC state consistently.
> > Also added IAVF_ERR_ADMIN_QUEUE_NO_WORK in virtchnl message drain
> as a
> > normal empty-queue condition and avoid logging it as an misleading AQ
> > failure.
> >
> > Fixes: 675a104e2e94 ("net/iavf: fix abnormal disable HW interrupt")
> > Fixes: b34fe66ea893 ("net/iavf: delay VF reset command")
> > Fixes: 5e03e316c753 ("net/iavf: handle virtchnl event message without
> > interrupt")
> > Fixes: 5c8ca9f13c78 ("net/iavf: fix no polling mode switching")
> > Fixes: 48de41ca11f0 ("net/avf: enable link status update")
> > Fixes: 02d212ca3125 ("net/iavf: rename remaining avf strings")
> > Cc: stable@dpdk.org
>=20
> Hi Anurag,
>=20
> Thanks for the patch. There seems to be multiple logical fixes/changes in=
 here
> and I think it would be good to split them into individual patches, each =
with
> their own Fixes tag where relevant. Having multiple fixes in one patch wi=
th
> multiple Fixes tags makes backporting tricky.
> I think at least logic which prevents the RESET_VF during a PF initiated =
reset
> should be split out from the link-change logic.
>=20
> Thanks,
> Ciara
>=20

Hi Ciara,

Thank you for your review comment. I have split the VF reset changes and se=
nt patch v4 for the same. Others, I will put fresh patch.

Kindly review.

Thanks,
Anurag

> >
> > Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>
> > ---
> > V3: Addressed latest ai-code-review comments
> > V2: Addressed ai-code-review comments
> >
> >  doc/guides/rel_notes/release_26_07.rst |   3 +
> >  drivers/net/intel/iavf/iavf_ethdev.c   |  37 +++---
> >  drivers/net/intel/iavf/iavf_vchnl.c    | 155 ++++++++++++++++---------
> >  3 files changed, 123 insertions(+), 72 deletions(-)
> >
> > diff --git a/doc/guides/rel_notes/release_26_07.rst
> > b/doc/guides/rel_notes/release_26_07.rst
> > index b8a3e2ced9..e7ac730369 100644
> > --- a/doc/guides/rel_notes/release_26_07.rst
> > +++ b/doc/guides/rel_notes/release_26_07.rst
> > @@ -89,6 +89,9 @@ New Features
> >
> >    * Added support for transmitting LLDP packets based on mbuf packet t=
ype.
> >    * Implemented AVX2 context descriptor transmit paths.
> > +  * Prevented duplicate 'VIRTCHNL_OP_RESET_VF' during a PF-initiated
> > +    reset recovery, which earlier caused virtchnl state corruption
> > +    and connection loss after a top-of-rack (ToR) link flap/power-cycl=
e.
> >
> >  * **Updated PCAP ethernet driver.**
> >
> > diff --git a/drivers/net/intel/iavf/iavf_ethdev.c
> > b/drivers/net/intel/iavf/iavf_ethdev.c
> > index bdf650b822..fb6f287d3c 100644
> > --- a/drivers/net/intel/iavf/iavf_ethdev.c
> > +++ b/drivers/net/intel/iavf/iavf_ethdev.c
> > @@ -3166,24 +3166,27 @@ iavf_dev_close(struct rte_eth_dev *dev)
> >
> >  	ret =3D iavf_dev_stop(dev);
> >
> > -	/*
> > -	 * Release redundant queue resource when close the dev
> > -	 * so that other vfs can re-use the queues.
> > -	 */
> > -	if (vf->lv_enabled) {
> > -		ret =3D iavf_request_queues(dev,
> > IAVF_MAX_NUM_QUEUES_DFLT);
> > -		if (ret)
> > -			PMD_DRV_LOG(ERR, "Reset the num of queues
> > failed");
> > +	/* Skip RESET_VF on a PF-initiated reset */
> > +	if (!adapter->closed && !vf->in_reset_recovery) {
>=20
> adapter->closed will always be false here so the check is redundant.
>=20
> > +		/*
> > +		 * Release redundant queue resource when close the dev
> > +		 * so that other vfs can re-use the queues.
> > +		 */
> > +		if (vf->lv_enabled) {
> > +			ret =3D iavf_request_queues(dev,
> > IAVF_MAX_NUM_QUEUES_DFLT);
> > +			if (ret)
> > +				PMD_DRV_LOG(ERR, "Reset the num of
> > queues failed");
> > +			vf->max_rss_qregion =3D
> > IAVF_MAX_NUM_QUEUES_DFLT;
> > +		}
> >
>=20

