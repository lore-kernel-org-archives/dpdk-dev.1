Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FD36CCA463
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 Oct 2026 03:12:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 74CFE40291;
	Fri, 16 Oct 2026 05:12:31 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by mails.dpdk.org (Postfix) with ESMTP id 685C7400EF
 for <dev@dpdk.org>; Fri, 16 Oct 2026 05:12:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792120351; x=1823656351;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=lEZbrfX9ilhG+GoqiPX2JMWbz+s/93oQFW1PN9p86qE=;
 b=W+LY0Ao9XQlRZu2KuzHIIGc1s7K+gdeAm7rSq2r+lU7qu7RX0M1QiqRA
 lm9n95EDl2eXBL5w8t6wiTQ2p153vlpuGoflFMxkCQLY8fw6Bn5VoN6z5
 8ZyeueKd0cTavzq3adAbqEcF/QQQtD/Jr71prxpD2Fhx1yaFmc2h/vZzA
 G129Uf5FEVSdAVzuXQN+1GjeWCBLs9ATeNjLiOi+aWVIjYVNYW6f8a8kl
 7FM47gphvXqA6j6di/oiA2IFKt1tfZf1kKwGTK4PICxBjhoNZTxK3b46K
 214RCPXY5OUE7ay2bOOAPe2qhYrCtMUVfS+aCnz5DysAcmYuOp1WJKdGn g==;
X-CSE-ConnectionGUID: PGqfO2YgSf27PzZmHZq2TA==
X-CSE-MsgGUID: CjYz1eDKQqeu5xdsCXeXQg==
X-IronPort-AV: E=McAfee;i="6800,10657,11936"; a="1005047"
X-IronPort-AV: E=Sophos;i="6.27,161,1787036400"; 
   d="scan'208";a="1005047"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Oct 2026 20:12:30 -0700
X-CSE-ConnectionGUID: r3d7Ya92TyCMggPmFlmXZw==
X-CSE-MsgGUID: LuvsrJnfSQyidBNmx1w1Ig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,161,1787036400"; 
   d="scan'208";a="1942304"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Oct 2026 20:12:30 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 15 Oct 2026 20:12:28 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 15 Oct 2026 20:12:28 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.16) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 15 Oct 2026 20:12:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WSJ/CTZT1siis4bz03/GVU7TjjIsrEvgSpK1i7EPXVYs17Kujd+S9Ptp6IVmf9+xeI5qoCbdsQBSB/vWs1BzQreYqYbQwCM/5JTsNH55D4kGDF3D864s9hKsgcklW2asg62yHcFFRLJlp//al4h9Zr77ayqGtq5lcl88MrsLCdsilO2hJm0Iq42t0U3crrgpiypcljeL+h4o8SPwFPDM5Uk+CXbiNRP2HVMPQfekTBp7cENjhlymms7ajVfbg4bXVLuUDlRpOFdLrS0xG2U6TV/h934t0EoWQBxwcDlAd/6lmGUKUPIFKtRIAVrnCHHH8M68XpX6iJ2ceWDHrNg33g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uou25RnTDC77Xww0JOp6IsNWH7CP76/Uzhki5v9G/qs=;
 b=TXXinD/FQIG9f+W7+JCyYFzXyIC15vEnAulWs6VbEflCHjdrkbIHQGu6FzJ7g9TcAAJMLW05SkUkyNFY/z1NRBB/PcF2WMd7iOEJDtK26TA45IlP0T9qCF7OsCiNB9O3uWrCZ+tGKXPzue8qW1QULDLeo3yFohWFnQS62BcCgGU8gQi2e/3ZfwL2gep5NTRNQ2kTKG+9n8o8+bJPu8PflcA2YQTnnQ8kei7aiVmdKAnPY94nWmm2XJhhCiAV2Qqak80k8+DckoIJsQsEdIRrn6yDE5jlCD/AzB+LAhBsaJnPC/Go9qBor6YFcg4iyMHU+NlE0tZcyI/lcjW6dC38xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from AT6PR11MB044526.namprd11.prod.outlook.com
 (2603:10b6:170:110::22) by SN7PR11MB7018.namprd11.prod.outlook.com
 (2603:10b6:806:2ad::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Fri, 16 Oct
 2026 03:12:25 +0000
Received: from AT6PR11MB044526.namprd11.prod.outlook.com
 ([fe80::4301:f255:af66:888c]) by AT6PR11MB044526.namprd11.prod.outlook.com
 ([fe80::4301:f255:af66:888c%6]) with mapi id 15.21.0522.013; Fri, 16 Oct 2026
 03:12:25 +0000
From: "Mandal, Anurag" <anurag.mandal@intel.com>
To: "Burakov, Anatoly" <anatoly.burakov@intel.com>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: "Richardson, Bruce" <bruce.richardson@intel.com>
Subject: RE: [PATCH v1 5/7] net/iavf: fix hash flow metadata leaks
Thread-Topic: [PATCH v1 5/7] net/iavf: fix hash flow metadata leaks
Thread-Index: AQHdW++L6/TSha6TRkSBzH9TKNv2w7b/gAnw
Date: Fri, 16 Oct 2026 03:12:25 +0000
Message-ID: <AT6PR11MB044526DC14053DED4A12805BFAE49B2@AT6PR11MB044526.namprd11.prod.outlook.com>
References: <cover.1791991100.git.anatoly.burakov@intel.com>
 <60442096f221bf2ccd30dcc2d19a7f9819a9a2c2.1791991100.git.anatoly.burakov@intel.com>
In-Reply-To: <60442096f221bf2ccd30dcc2d19a7f9819a9a2c2.1791991100.git.anatoly.burakov@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AT6PR11MB044526:EE_|SN7PR11MB7018:EE_
x-ms-office365-filtering-correlation-id: 03357e69-9e66-46d8-ad2f-08df2b334d96
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|6133799003|22082099003|10067099003|18002099003|38070700021|11063799006|4143699003|261009223027099003|56012099006;
x-microsoft-antispam-message-info: gjszKKfL5w94PHqszH7QEpBbjfrA0jknoo2oWWZA9kNFzY1tO79Aj63LjiEBV/ukkOk09tHKhjMgFHqmULgTm32e6xDh/+VwKMw/5gn+Fidx/aZnKOz9KTzA9rs1g70lu2YTum0327s/lrpn6kELJxoHMOfNj5g8fUEq+DLVnQnaDhNE1yI9O8TBZXEX55J/iIAFAjTN99WWvRy0fRAF8k4WN0DMgJhu9ljG7S49GWv/G+C2zb69m3HUW4o6fdQ0nvgOBaLquZ3M3+OibtS4ThLUGSK/cwFIC/lhKGNMutLcdHtYwRJs8FECPrMrJZGXiQ4lHAvPKVSw3UgQgaKwNe5JmpHN9LScuTXEMi/nKMyjE7OJzhLcCy0tKbpZPdFrZWipgZHx69XxMRjuDUPJ2OJKwhH+3YX6vfVLVT3a0t4oE8jebOJbwlZSNR3ygO0nnbxwijS+yoWXkp/VqqciLAesHKLLWRR0enrchTgL71XB4iLNfSZ1z16kM2ERU0v6gHQ6O3+SZHUm4FDclZXw/KA1/8TJL3TIOB9J8EQ5NqQLhxn02BOPlOrH9i3D8CRwGJlyeUVeK/nSWCm9UgyMpFwAUMgREBCawByAtiRNAS8l+uEQd1sBlbCy0IZvHiBdvEK6c8o6etj6CrOvLD33u244SRdbze7FwehTJECXvTY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AT6PR11MB044526.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(6133799003)(22082099003)(10067099003)(18002099003)(38070700021)(11063799006)(4143699003)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?cfZvf8P8xi9p0b+78SkXg3IMnZSWI8k1jGqN7lWD9OM8ECjC6tUilA+JA7rI?=
 =?us-ascii?Q?J02ML7JmLNMV843lN4fInKAbtxIZUpSXxjvLFPrgknMxaL5ILmKCW04skZVi?=
 =?us-ascii?Q?IZxK9w1uDhcdlY4CqkTXeN50k74DB3aVOTOdVlUBlosPNd05DbQ9dTllS1gU?=
 =?us-ascii?Q?RsxIMR0yY6MDlFXzg9SK1yAFq4XzYq4eKvAwuzbzGqpl9Uv0jHL1AWHq4rvz?=
 =?us-ascii?Q?gCYRSuYE6dQ8LMdKK2YwBZG6Cy1nkbrCHikR3nzGrSCcWZxQMI8AuZlfZBj4?=
 =?us-ascii?Q?4x3aRL8OITuxXZEku41+hEy3iNR6Co/XVsM4oyq3nxRjwv7dAZIkZVWoYgEH?=
 =?us-ascii?Q?V18P8ABZY+6sRxbnZxJkq6/g7prJBdeOQ4YWJyieUIWknePLC7/BMSvTh1LB?=
 =?us-ascii?Q?Fw5qDLrissZxkuN1cFpZxYcr87bAR8MFPhDsp6DRhEtKmmXyLZ66kiYRR/fC?=
 =?us-ascii?Q?YzitcABHBzCZOzjPZI8HGDn302koH0vfDKcVJj+9B5Z6ndEvYTkdZqH+2+At?=
 =?us-ascii?Q?zcX/zHJzJrEae8HMkyUj9i6s15FohJ7GkeMflUTC3FsJ/7/yW7jyedXnSEwD?=
 =?us-ascii?Q?+jVw2jHTLES6cGtG77260BIQmIKAhSDOdAAdkMwTJLG6WkUFOC0C+oEYcBP1?=
 =?us-ascii?Q?ODYxr8AzSr0BL5j5AT0Lp0GIUxyZJ88L9i0N9YuF+SC5W39RQfLlrRSZKmJk?=
 =?us-ascii?Q?dv/vDENAaO7+dRAaGKRJU4zvr2D/hrzB+NeRQRWzA+tFQfOf1jw/tWK5gcjR?=
 =?us-ascii?Q?iESGJU6PHLCWp1bfzAGASzmOt4EzUQQpMR9eTce6Y4CVvvtgP56PIJScdp06?=
 =?us-ascii?Q?p1yeSaM2B1km586IMqaxzV8QNBinlNdnftWjj1E/T8jI8fJMn0MfKGfNWyoc?=
 =?us-ascii?Q?3CKWpGkFJe8+6DpmeX03gTAPGvZJnffyse5WON/nq6d4dN7etUMSNJL5tXkY?=
 =?us-ascii?Q?NViO0Khld9lknNFGRSVYDRXAsFmtO0T6QjzphAJD755z5gtsTcg/gznxJ5M2?=
 =?us-ascii?Q?lzKFqHY09wvTTeXVSR9UHo6IeFD2y890STt6IMpjLbv/3Nij9CmmaJRgbFkZ?=
 =?us-ascii?Q?WYQye/eJLgDCWuZeMr/+30W3xbjoiZ0w7lwyFD6WY/9YfmZPq/9vdSJSaiWw?=
 =?us-ascii?Q?0nM/1+5VkirRrCTSSHkKJ/glOeFDqAngusqUgLIcH+wC6L7UXAjXqv1PiSFD?=
 =?us-ascii?Q?DXmcog9U8m5NJJnUTRlxHkCv44LEQ2jk2LzAhw/+fDl07fFjsl+M3xO/7mCw?=
 =?us-ascii?Q?41FkufTMk4OydPeSsafWshCFSm1Xgz7joU0a2FwZejUYGToVftafMIoWzTDd?=
 =?us-ascii?Q?T3MrhIm9iGaq7JZbgZ3MQBnwr3ckDEQmvomrL3D36szY0dNzC9TnZTWNlRnm?=
 =?us-ascii?Q?y1ePtoaJIRoGA/2BHB8z7nghpdvFyn801XsnSz4K5iVr0JU0FEussR4vQUb5?=
 =?us-ascii?Q?lSeUcIWEejM43yc0AmrSr9VcxGt0yu6C5FtdRLZnvJ+2pL/TYasDU8njI9lG?=
 =?us-ascii?Q?ekbJbttus45b0DTT49b43ngmEuxrknwYS3ghI7IyiVv9A3HRhQpWBvxYGkTv?=
 =?us-ascii?Q?LaGE7UITu+lMuBscVrL4uKP7g3z05Pi3iwMYl0lXZEv1bgiPa4EwQmvY8hiZ?=
 =?us-ascii?Q?mtUHyoKvNl8Lr94MmSoEojUy5rmutyd1QPOue/dcN1dzgJhUc5xzZ3o3sfvJ?=
 =?us-ascii?Q?L6ADjX8Wt91mD9xp+wwVAc9W5W7zKUpa0/CwdxiCc5b73XmxDat9PEu8Xs6v?=
 =?us-ascii?Q?WOQhYsXy+Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: UoI9P3QJvn5Kw/tII0F8ynV1f4164j02vHph1/J54hpnlyLKaD9gi0LGOs813cfwdINRdK0xbohGt5FyszoTC+S9tmfZZoVPoiYWVri4ZpQkbXbIOoqtd6nQS/6tuGjmwVMWuFHbmdE7cogFqCzR5rLO9H5dX2vStF3y/lwXHJnveaWZdEm8VRhow2H3ugg93H7BCzfzy2wszU5TogdxVC5/V2iKSNkYCXcwHZZqn+pL1ziRY914C8kZeHeyGNiTTQ5TncEYGCksUYtk3DbSaD3vLfZkkXt4A6DYf5vNcEJ7HQb0nhFnTFDRqzSQvxF3E1U+b491LXGLL89b8+to+A==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AT6PR11MB044526.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03357e69-9e66-46d8-ad2f-08df2b334d96
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2026 03:12:25.4454 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yVB9aB0guv9VM2aaqKKLnYmM97m+GpK55rpzS1Y/t1Je4J9sQp41Mlmc+BF/QLVStnsC9NuyxXYWIcwCMN0Y9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7018
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
> From: Anatoly Burakov <anatoly.burakov@intel.com>
> Sent: 14 October 2026 20:49
> To: dev@dpdk.org
> Subject: [PATCH v1 5/7] net/iavf: fix hash flow metadata leaks
>=20
> Hash flow parsing allocates RSS metadata, but validation has no callback =
to
> release it. Creation also leaks the metadata if rule allocation or the re=
quest to
> add the RSS rule fails.
>=20
> Add a validation callback to release the parsed metadata, and free it on =
both
> creation failure paths. Parsing already checks the RSS inputs; validation=
 does
> not add or remove a rule.
>=20
> Fixes: 7be10c3004be ("net/iavf: add RSS configuration for VF")
> Fixes: 215a247b5f33 ("net/iavf: refactor hash flow")
> Cc: stable@dpdk.org
>=20
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---
>  drivers/net/intel/iavf/iavf_hash.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>=20
> diff --git a/drivers/net/intel/iavf/iavf_hash.c
> b/drivers/net/intel/iavf/iavf_hash.c
> index cef30cd08e1..6787a380f8e 100644
> --- a/drivers/net/intel/iavf/iavf_hash.c
> +++ b/drivers/net/intel/iavf/iavf_hash.c
> @@ -80,6 +80,9 @@ iavf_hash_destroy(struct iavf_adapter *ad, struct
> rte_flow *flow,  static void  iavf_hash_uninit_parser(struct iavf_adapter=
 *ad);
> static int
> +iavf_hash_validation(struct iavf_adapter *ad, struct rte_flow *flow,
> +		     void *meta, struct rte_flow_error *error); static int
>  iavf_hash_parse_pattern_action(struct iavf_adapter *ad,
>  			       struct iavf_pattern_match_item *array,
>  			       uint32_t array_len,
> @@ -680,6 +683,7 @@ static struct iavf_flow_engine iavf_hash_engine =3D {
>  	.create =3D iavf_hash_create,
>  	.destroy =3D iavf_hash_destroy,
>  	.uninit =3D iavf_hash_uninit_parser,
> +	.validation =3D iavf_hash_validation,
>  	.name =3D "hash",
>  	.type =3D IAVF_FLOW_ENGINE_HASH,
>  	.rule_size =3D sizeof(struct virtchnl_rss_cfg), @@ -1579,6 +1583,15 @@
> iavf_hash_parse_pattern_action(struct iavf_adapter *ad,
>  	return ret;
>  }
>=20
> +static int
> +iavf_hash_validation(__rte_unused struct iavf_adapter *ad,
> +		     __rte_unused struct rte_flow *flow, void *meta,
> +		     __rte_unused struct rte_flow_error *error) {
> +	rte_free(meta);
> +	return 0;
> +}
> +
>  static int
>  iavf_hash_create(__rte_unused struct iavf_adapter *ad,
>  		 __rte_unused struct rte_flow *flow, void *meta, @@ -1594,6
> +1607,7 @@ iavf_hash_create(__rte_unused struct iavf_adapter *ad,
>  		rte_flow_error_set(error, EINVAL,
>  				   RTE_FLOW_ERROR_TYPE_HANDLE, NULL,
>  				   "No memory for rss rule");
> +		rte_free(meta);
>  		return -ENOMEM;
>  	}
>=20
> @@ -1609,6 +1623,7 @@ iavf_hash_create(__rte_unused struct iavf_adapter
> *ad,
>  				   RTE_FLOW_ERROR_TYPE_HANDLE, NULL,
>  				   "Failed to add rss rule.");
>  		rte_free(rss_cfg);
> +		rte_free(meta);
>  		return -rte_errno;
>  	}
>=20
> --
> 2.52.0

Hi Anatoly,=20

I had submitted similar fix  in this patch earlier.
https://patches.dpdk.org/project/dpdk/patch/20261010121255.528329-1-anurag.=
mandal@intel.com/

Thanks,
Anurag M



