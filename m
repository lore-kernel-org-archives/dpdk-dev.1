Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E40D2606A31E
	for <dpdk-dev@archiver.kernel.org>; Tue, 24 Nov 2026 10:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=glO8fObS;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=Ykl5OvTu
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EE2FE40297;
	Tue, 24 Nov 2026 11:24:49 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTPS id 5A8064027A;
 Tue, 24 Nov 2026 11:24:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795515888; x=1827051888;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:mime-version;
 bh=NnSBiUKFo5dxy65v12AAfukphSLcsQwKSdQpPYIKoqY=;
 b=glO8fObSnYgoWb2W20zY0LYOzQUnBvWAyrRdqDjcGuRV+/YCCBYi7PVh
 zJv/CGE50vnHKZm79cObg91+gqrcTN4xad/Sn1OIWzp6xNrRliERboLHY
 D0seqczmcE24ZRWGH7G7tihWWoLIceSCB5VkkQq2heOZzB261DNeoLtCO
 c1S0tRJmhWSnb89PlL6hpzz0FnYWJ8pIVFtu2mFIVbqr3bzRVMuNmDYQ1
 ijjdf9ZKxoGPaNv+hCbiQEqlEtn6K3OEExXHmt3yY7D1RHwwUouGZnEj2
 OQl27f8sBuyZ/8sV4bEAHLlwLszTPj7MoB1NEcEa1xXeVByIV47Cyp1pg g==;
X-CSE-ConnectionGUID: hjZy8cFLTkOi2Y89vUDIHA==
X-CSE-MsgGUID: t9sKmWfoT1G5ITqZ/ErACg==
X-IronPort-AV: E=McAfee;i="6800,10657,11975"; a="4243928"
X-IronPort-AV: E=Sophos;i="6.27,230,1787036400"; d="scan'208,217";a="4243928"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Nov 2026 02:24:45 -0800
X-CSE-ConnectionGUID: rZBfkoseRY+pzAG9kTnXTw==
X-CSE-MsgGUID: IIdbKyAvQfe5coEzfMjayw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,230,1787036400"; d="scan'208,217";a="11551426"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Nov 2026 02:24:44 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Tue, 24 Nov 2026 02:24:44 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57 via Frontend Transport; Tue, 24 Nov 2026 02:24:44 -0800
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.23) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Tue, 24 Nov 2026 02:24:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qH7ItGeo4irrLerfn3qEPZ22lunHnjm3/MKqrSFxPxb8uTIkKWg16j4kK7FQT1rKaa5I1xOXV/LWBF3kuUjttM0D/TKjKiWAMJjdTlmx/Y9Zs6SrLqpwG56ll71iReYlQqJdQ0+YIDndKaEBlxGLOCBLSfYV4BxC8skA3mYJ6DB8eQFKGEytA/6zKuMx2tnFNzf1nIx2dsjzWEGXgCsPNR7x/ZSS0TOkBVA1M+odlLP/KPwnxs52HXa8U1WFj18f4zhhSkRjpgp/DePC2zAbfXztNYct36qRk2pnia2ygCQR2V/iXtfJXHXgaReWITl4WO1JJ1VkZkrO7C41eo1pqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LODR+W5VcFaCktaCvV5ilrTXMsTjUHh1PAvCnhlH4Ps=;
 b=FEWsmX9O+QTYtOcEsTcJQ4QsMwl6SBSx8nA9bexI3IXfG4ibzUTlHywuKrXkFOyBszCNpe3KA723PSK+PsHvcH5twzmHZtqmJSXL2qX9bq87wLdNhFvEYR2BYEUDDPNYPIGYOE074iYGx0KWJjAJIgz+57QXnJ70tbXKKDpEuMNMFP/jBhTs53xM5OvKMpViCxiVPdeTaCgTfZj6C8HLW7/V6PpS7Cw0c2STL+YsmzJBVdERmOWDC6QxfP8d8NMLW3WbqP8sZLuiDwYAWF2oH9ehyJkDc53l8O7WBoe6ae0NxfQeRNNbduK074363b5PnqPf7QDlXJnYObQoht1bmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LODR+W5VcFaCktaCvV5ilrTXMsTjUHh1PAvCnhlH4Ps=;
 b=Ykl5OvTu1lnTX/ex+tU6IAPVkXZ68v3/+Wh6FArmMZ3XI+m/FvjItZuF5PFE6ZGAKcbZLUjcK1BjfoKHP0aD9piJTvEIUvrgL3U2hln/BZ8NLRO10wQVNQUFCPv4qN6o7tKVJAPPxMehhIGqiGc8Q/oOEJrzDPrB2AUh0a2IVag=
Received: from LV2PR11MB6045.namprd11.prod.outlook.com (2603:10b6:408:17b::20)
 by PH8PR11MB8015.namprd11.prod.outlook.com (2603:10b6:510:23b::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Tue, 24 Nov
 2026 10:24:41 +0000
Received: from LV2PR11MB6045.namprd11.prod.outlook.com
 ([fe80::1f72:3d49:b6ba:91ae]) by LV2PR11MB6045.namprd11.prod.outlook.com
 ([fe80::1f72:3d49:b6ba:91ae%6]) with mapi id 15.21.0639.012; Tue, 24 Nov 2026
 10:24:41 +0000
From: "Ji, Kai" <kai.ji@intel.com>
To: "Nicolau, Radu" <radu.nicolau@intel.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: "stable@dpdk.org" <stable@dpdk.org>, "srizor@qti.qualcomm.com"
 <srizor@qti.qualcomm.com>, Wathsala Vithanage <wathsala.vithanage@arm.com>
Subject: Re: [PATCH] crypto/ipsec_mb: fix cipher and auth length calculation
Thread-Topic: [PATCH] crypto/ipsec_mb: fix cipher and auth length calculation
Thread-Index: AQHdezW9jKios/B6dEC2a9KXa3eoFrc9BWU1
Date: Tue, 24 Nov 2026 10:24:41 +0000
Message-ID: <LV2PR11MB60454F6F9304C01177AA92C781442@LV2PR11MB6045.namprd11.prod.outlook.com>
References: <20261123103025.3538549-1-radu.nicolau@intel.com>
In-Reply-To: <20261123103025.3538549-1-radu.nicolau@intel.com>
Accept-Language: en-GB, en-US, en-IE
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR11MB6045:EE_|PH8PR11MB8015:EE_
x-ms-office365-filtering-correlation-id: 552328aa-5047-4726-91ea-08df4a1526be
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|42112799006|1800799024|23010399003|10070799003|366016|18002099003|22082099003|261009223027099003|8096899003|261021123027099003|11063799006|56012099006|261028144727099003|261022105027099003|261102123227099003|261026140227099003|261021121427099003|261021135927099003|261022075727099003|38070700021|10067099003;
x-microsoft-antispam-message-info: 4aijJFi/K99ZcBtHIPZrgupl8sfR79rsnPlGObDDgLPcUvbK2SJp/p8/+vJt7+I7VI2NSCSiplbmWuORZUc1gORBA9YSNYX/3h82B+5Nu09PCqMwqn9DfSYwCjtn41P9HEL8YGDeETwECIcD0UxQSrrJC7PfISkHydcGXQbshyKZLzDU43A7uuUFCxriXCd0iKbxwsXhFjLfyRbq5qmEc9zIielFP5qTQU+hLnO6QZ7uhe5K9Z/TXo87/ffEmidWlN1p5nKTJ8TDYLxmQHhAx9PIl2j/lmtzr/1gF8hZMthvdX0Zr2XwqByyXanYbD9izJa9EzZYRleTCobtKltSO0gpzUP6FARMQI0mY6AeetnTxa5vjqwwr2rIOfRqWDl4e+yFzDO1JqV8JI9fVr8l0tQzWhH7CWGRfdUQCW4LPu2pZncuvH/gRognBBKGHOOJJTZT/0+VTLO717NV0tuj14ctIbv5HCYxarsx1VfMiXX/ZhnMU6ZEv0bh/u7ShXmTXaXUsTPBaZ1GjnBqg89ekp8vQhBB4NdwbCl08eBdkBL49mJaZKfyLIYghCCKynMtv8NgnqOTqANLxS/E9Taw8nUZrw7VoY5CXEMolwtVY4mB8xjtC6gXckDpOjS64i0Pu0PjE20n8htemmx/yYpK/wwb7IrjsMTyzRBBA7EcYvGD2hSdlcFqCFw0CBQf6itXGCFSt/7vSjsYkCEpkTSWPwjSeW1KXfsHe0SIsSFSbhE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV2PR11MB6045.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(42112799006)(1800799024)(23010399003)(10070799003)(366016)(18002099003)(22082099003)(261009223027099003)(8096899003)(261021123027099003)(11063799006)(56012099006)(261028144727099003)(261022105027099003)(261102123227099003)(261026140227099003)(261021121427099003)(261021135927099003)(261022075727099003)(38070700021)(10067099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?jh3Wo3qpWGyNJiYHcQgFjRFGX8ndboIUOxJWMDjbU8xui8nYLUs/0nhj6e?=
 =?iso-8859-1?Q?rPsp8hObX5XRfOTlroT0XHsojXJncS1L3oCV8GiBHX3ItjTs/Iiso2Xn+D?=
 =?iso-8859-1?Q?6NAjwZRiUzr53oAgUbbaK3Xb4KNfYEmoaU69AED1SNwMHVXBGF65gU85f4?=
 =?iso-8859-1?Q?W4+RTWiVmZ5fOfydWf6e7eSN1LTJ4X8UqI/zugzaQiV9llTknwnh0MxdR3?=
 =?iso-8859-1?Q?yq4jc8DNMub9kqw72OT0P54p7taAysmEpT7S4fw/KyrUZrbx5KNwsuj4TY?=
 =?iso-8859-1?Q?n9R1JEjTfEozynso+QvBVVy+1mVnJgtZEa3HtjCvUe/4NWoNjDmbKVzIe4?=
 =?iso-8859-1?Q?7c4eCjqS6gbxl1yv6vqQrBbYVgb3chh3f0/IjECeTj8pjOudTxE5a9xTNr?=
 =?iso-8859-1?Q?omTiRmZjHhCYxtzipLF1/ct5d5YRktoWA763sqLXUkp9Wjm4yle9KuUWeh?=
 =?iso-8859-1?Q?6s4sd965wNWqsfaXp//JMM3DwFZQW+zrjcnPttFIIeEYAmCLYGKvWY9vyv?=
 =?iso-8859-1?Q?iOrWXu2oOOyFA/Gaa9j2YS/Ofcq7Zpv/flO4UeuyPGlYihIjQ+Ss3W9O5o?=
 =?iso-8859-1?Q?6rCtTI9lWXU7JmuKBGPrTJ1e/D33QTTVMwZYb0kUwaSLghK4aOhnSqV/Nv?=
 =?iso-8859-1?Q?Pl1jISYD5c50wMw5LqBW7Y0YsNbGjP6Cl+eSDxEWnXYDN5BcrJE4dKFuGX?=
 =?iso-8859-1?Q?76ZxubVcR5/KN9pTR8dvXMafIZgrgV0LA3p33G2mCcNRcKtmyawr9n3yZM?=
 =?iso-8859-1?Q?0AcsxsTxRT1GvxoPWxooeCMQQ7TjBIDzsMXJexudY/Ueutj5+43NrWbc0F?=
 =?iso-8859-1?Q?iYujrc4B4xyfR2+EsC9qy7PuK6hElXN/9fC5/dIzpiJFpT96FvcBsLTQaR?=
 =?iso-8859-1?Q?VCyJdHIMLImJP1QmJSXfo8vQlycp3ymcA5Pb5Yf/Lp+tnhAvVlxhy7ExGi?=
 =?iso-8859-1?Q?R8rahnpNvYtYNLoLp7ZnX7tJUg3Nk/6mKWP/9Vp0JPUkUpRWuQ+TV4ADTi?=
 =?iso-8859-1?Q?xAD3zh+7rPIwbYvDCS9I3NuSXO6k6yOY6Mfp4G79QGUo5Nozrvsky9x1Xg?=
 =?iso-8859-1?Q?PfO6O7AQKrcCZK8O0WPeHPxYWYS1TaiJrNCkugXUbQffPrEUM8OgkrS79l?=
 =?iso-8859-1?Q?MJuVoIAivKu8zJ6q39gPyUjim03u70shRqeUxMaqlB+RngruUfWYHQ86ow?=
 =?iso-8859-1?Q?esnEmqzXCgK4u9rWlt9IBHZujgMBtpGDiLXPwQarLc6sYtZQiLZJaXcuc5?=
 =?iso-8859-1?Q?Uvr4R1E/FSdEW8zBmSoqsuhd5G4LA9piyM6GHshuNmy5GJuE1ZfCTRCqL7?=
 =?iso-8859-1?Q?pKJiEOCVLf3euT+NsbaHxIieqx/lqH87X5sUSR4flzf7FCB3oifIgSNuTw?=
 =?iso-8859-1?Q?juN+bq+pjjTWbdWGZb3Ki5fNS4/ASVAd1El4eNmDdsSdH3WsMpi4Sxnk1g?=
 =?iso-8859-1?Q?rkLngGJVh2d08YeC+ASVHDYr7KKqOe6EfiqDj6hHf6s7/6YQ39dUzaapCU?=
 =?iso-8859-1?Q?UKJlPyt+9RRILH6Z45RSpCU10joxPoj6kvbnO4vNuaVmYYNjY85203Vi0x?=
 =?iso-8859-1?Q?eXnafIgZG0FvUqflZXJBdMP7mvGGQcMNOzyuoLgwQuUxknUwEYQa46k0M1?=
 =?iso-8859-1?Q?4+Iol3M3s0uj0Xl2NJRszm2kpHjl8H5KvyRKiTWAZP8Lnmfc5NqsYcgW0w?=
 =?iso-8859-1?Q?iGSlkp9JmNw1HQU1ommrwIV+9gLW4+NpT5dGToiYOGdkCPODOF51ZDBiI9?=
 =?iso-8859-1?Q?2V2CH11LsWMRzfdctP6AfvRJcizLMSJ6qC2yqlo1YvQVwVW+MSP8OxlqbL?=
 =?iso-8859-1?Q?7Ze1l3Awi1Tc+ubeRUP0nQ5lF6nFQWHDfBu8isho5JCWw34ThN4rcQE7bS?=
 =?iso-8859-1?Q?6I?=
x-ms-exchange-antispam-messagedata-1: Rnv+usyfiruSzg==
Content-Type: multipart/alternative;
 boundary="_000_LV2PR11MB60454F6F9304C01177AA92C781442LV2PR11MB6045namp_"
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: XDsPmyQUr5FfXjrzQlLdG8LrQ8/i95QRSEP0mR740nnFwk5ICMfoW8HLL27cSZh+vSOq4d8sDcE41wrZkoi3aYdFGZhODRT7Z9fZiu/RN1Tus5U66++KCoFu7cjX0EUJXRZvywjnsygxTQQLH4XNUZBxXMlV9GREM5rPZO6sdQAUMJntyiOfv2q0xhmUf0k89GH9vZn4LPZiKvpht4z3CrAWadjh7U0jv4nJrej0xhL3cnq5cWPCAg156dkKVsF+eM64yIxAMjxEXO8D6MJ7E8Uqd8Vn/b4n/7my24XbsKKCl4jeJFyRbldQUrKuPjRLBUm57NtEYE42j9wWEF97tA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR11MB6045.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 552328aa-5047-4726-91ea-08df4a1526be
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2026 10:24:41.4450 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: szmjdj8TRdU03mc3kNZHZMPviikPKxCXA00lHOhG36J2LEEW79aQ1v0rZJBxAyHNWNdJIFecVpSGHGojg+7ASw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB8015
X-OriginatorOrg: intel.com
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--_000_LV2PR11MB60454F6F9304C01177AA92C781442LV2PR11MB6045namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


Acked-by: Kai Ji <kai.ji@intel.com>


________________________________
From: Nicolau, Radu <radu.nicolau@intel.com>
Sent: Monday, November 23, 2026 10:30
To: dev@dpdk.org <dev@dpdk.org>
Cc: Nicolau, Radu <radu.nicolau@intel.com>; stable@dpdk.org <stable@dpdk.or=
g>; srizor@qti.qualcomm.com <srizor@qti.qualcomm.com>; Ji, Kai <kai.ji@inte=
l.com>; Wathsala Vithanage <wathsala.vithanage@arm.com>
Subject: [PATCH] crypto/ipsec_mb: fix cipher and auth length calculation

Fix cipher and auth length calculation for new wireless
algorithms when encrypted digest is used.

Fixes: c7adee547cc9 ("crypto/ipsec_mb: support 256-NxA4/5/6 algorithms")
Cc: stable@dpdk.org
Cc: srizor@qti.qualcomm.com

Signed-off-by: Radu Nicolau <radu.nicolau@intel.com>
---
 drivers/crypto/ipsec_mb/pmd_aesni_mb.c | 54 ++++++++++++++++++--------
 1 file changed, 38 insertions(+), 16 deletions(-)

diff --git a/drivers/crypto/ipsec_mb/pmd_aesni_mb.c b/drivers/crypto/ipsec_=
mb/pmd_aesni_mb.c
index ab917b3fe4..d0f2f5aa62 100644
--- a/drivers/crypto/ipsec_mb/pmd_aesni_mb.c
+++ b/drivers/crypto/ipsec_mb/pmd_aesni_mb.c
@@ -1767,21 +1767,32 @@ aesni_mb_digest_appended_in_src(struct rte_crypto_o=
p *op, IMB_JOB *job,
         if (job->cipher_mode =3D=3D IMB_CIPHER_NULL)
                 return NULL;

-       if (job->cipher_mode =3D=3D IMB_CIPHER_ZUC_EEA3 ||
-               job->cipher_mode =3D=3D IMB_CIPHER_SNOW3G_UEA2 ||
-               job->cipher_mode =3D=3D IMB_CIPHER_KASUMI_UEA1) {
+       if (job->cipher_mode =3D=3D IMB_CIPHER_ZUC_EEA3
+               || job->cipher_mode =3D=3D IMB_CIPHER_SNOW3G_UEA2
+               || job->cipher_mode =3D=3D IMB_CIPHER_KASUMI_UEA1
+#if IMB_VERSION(3, 0, 0) <=3D IMB_VERSION_NUM
+               || job->cipher_mode =3D=3D IMB_CIPHER_SNOW5G_NEA4
+               || job->cipher_mode =3D=3D IMB_CIPHER_AES_NEA5
+               || job->cipher_mode =3D=3D IMB_CIPHER_ZUC_NEA6
+#endif
+               ) {
                 cipher_size =3D (op->sym->cipher.data.offset >> 3) +
                         (op->sym->cipher.data.length >> 3);
         } else {
                 cipher_size =3D (op->sym->cipher.data.offset) +
                         (op->sym->cipher.data.length);
         }
-       if (job->hash_alg =3D=3D IMB_AUTH_ZUC_EIA3 ||
-               job->hash_alg =3D=3D IMB_AUTH_SNOW3G_UIA2 ||
-#if IMB_VERSION(3, 0, 0) > IMB_VERSION_NUM
-               job->hash_alg =3D=3D IMB_AUTH_ZUC256_EIA3 ||
+       if (job->hash_alg =3D=3D IMB_AUTH_ZUC_EIA3
+               || job->hash_alg =3D=3D IMB_AUTH_SNOW3G_UIA2
+               || job->hash_alg =3D=3D IMB_AUTH_KASUMI_UIA1
+#if IMB_VERSION(3, 0, 0) <=3D IMB_VERSION_NUM
+               || job->hash_alg =3D=3D IMB_AUTH_SNOW5G_NIA4
+               || job->hash_alg =3D=3D IMB_AUTH_AES_NIA5
+               || job->hash_alg =3D=3D IMB_AUTH_ZUC_NIA6
+#else
+               || job->hash_alg =3D=3D IMB_AUTH_ZUC256_EIA3
 #endif
-               job->hash_alg =3D=3D IMB_AUTH_KASUMI_UIA1) {
+           ) {
                 auth_size =3D (op->sym->auth.data.offset >> 3) +
                         (op->sym->auth.data.length >> 3);
         } else {
@@ -2448,21 +2459,32 @@ post_process_mb_job(struct ipsec_mb_qp *qp, IMB_JOB=
 *job)
                                 aesni_mb_digest_appended_in_src(op, job, o=
op) !=3D NULL) {
                                         unsigned int auth_size, cipher_siz=
e;
                                         int unencrypted_bytes =3D 0;
-                                       if (job->cipher_mode =3D=3D IMB_CIP=
HER_SNOW3G_UEA2 ||
-                                               job->cipher_mode =3D=3D IMB=
_CIPHER_KASUMI_UEA1 ||
-                                               job->cipher_mode =3D=3D IMB=
_CIPHER_ZUC_EEA3) {
+                                       if (job->cipher_mode =3D=3D IMB_CIP=
HER_SNOW3G_UEA2
+                                               || job->cipher_mode =3D=3D =
IMB_CIPHER_KASUMI_UEA1
+                                               || job->cipher_mode =3D=3D =
IMB_CIPHER_ZUC_EEA3
+#if IMB_VERSION(3, 0, 0) <=3D IMB_VERSION_NUM
+                                               || job->cipher_mode =3D=3D =
IMB_CIPHER_SNOW5G_NEA4
+                                               || job->cipher_mode =3D=3D =
IMB_CIPHER_AES_NEA5
+                                               || job->cipher_mode =3D=3D =
IMB_CIPHER_ZUC_NEA6
+#endif
+                                           ) {
                                                 cipher_size =3D (op->sym->=
cipher.data.offset >> 3) +
                                                         (op->sym->cipher.d=
ata.length >> 3);
                                         } else {
                                                 cipher_size =3D (op->sym->=
cipher.data.offset) +
                                                         (op->sym->cipher.d=
ata.length);
                                         }
-                                       if (job->hash_alg =3D=3D IMB_AUTH_Z=
UC_EIA3 ||
-                                               job->hash_alg =3D=3D IMB_AU=
TH_SNOW3G_UIA2 ||
-#if IMB_VERSION(3, 0, 0) > IMB_VERSION_NUM
-                                               job->hash_alg =3D=3D IMB_AU=
TH_ZUC256_EIA3 ||
+                                       if (job->hash_alg =3D=3D IMB_AUTH_Z=
UC_EIA3
+                                               || job->hash_alg =3D=3D IMB=
_AUTH_SNOW3G_UIA2
+                                               || job->hash_alg =3D=3D IMB=
_AUTH_KASUMI_UIA1
+#if IMB_VERSION(3, 0, 0) <=3D IMB_VERSION_NUM
+                                               || job->hash_alg =3D=3D IMB=
_AUTH_SNOW5G_NIA4
+                                               || job->hash_alg =3D=3D IMB=
_AUTH_AES_NIA5
+                                               || job->hash_alg =3D=3D IMB=
_AUTH_ZUC_NIA6
+#else
+                                               || job->hash_alg =3D=3D IMB=
_AUTH_ZUC256_EIA3
 #endif
-                                               job->hash_alg =3D=3D IMB_AU=
TH_KASUMI_UIA1) {
+                                           ) {
                                                 auth_size =3D (op->sym->au=
th.data.offset >> 3) +
                                                         (op->sym->auth.dat=
a.length >> 3);
                                         } else {
--
2.52.0


--_000_LV2PR11MB60454F6F9304C01177AA92C781442LV2PR11MB6045namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div class=3D"elementToProof" style=3D"font-family: &quot;IntelOne Text&quo=
t;; font-size: 10pt; color: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"appendonsend"></div>
<div style=3D"color: rgb(0, 0, 0);">Acked-by: Kai Ji &lt;kai.ji@intel.com&g=
t;</div>
<div><br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<hr style=3D"display: inline-block; width: 98%;">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<b>From:</b> Nicolau, Radu &lt;radu.nicolau@intel.com&gt;<br>
<b>Sent:</b> Monday, November 23, 2026 10:30<br>
<b>To:</b> dev@dpdk.org &lt;dev@dpdk.org&gt;<br>
<b>Cc:</b> Nicolau, Radu &lt;radu.nicolau@intel.com&gt;; stable@dpdk.org &l=
t;stable@dpdk.org&gt;; srizor@qti.qualcomm.com &lt;srizor@qti.qualcomm.com&=
gt;; Ji, Kai &lt;kai.ji@intel.com&gt;; Wathsala Vithanage &lt;wathsala.vith=
anage@arm.com&gt;<br>
<b>Subject:</b> [PATCH] crypto/ipsec_mb: fix cipher and auth length calcula=
tion </div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-size: 11pt;">Fix cipher and auth length calculation for =
new wireless<br>
algorithms when encrypted digest is used.<br>
<br>
Fixes: c7adee547cc9 (&quot;crypto/ipsec_mb: support 256-NxA4/5/6 algorithms=
&quot;)<br>
Cc: stable@dpdk.org<br>
Cc: srizor@qti.qualcomm.com<br>
<br>
Signed-off-by: Radu Nicolau &lt;radu.nicolau@intel.com&gt;<br>
---<br>
&nbsp;drivers/crypto/ipsec_mb/pmd_aesni_mb.c | 54 ++++++++++++++++++-------=
-<br>
&nbsp;1 file changed, 38 insertions(+), 16 deletions(-)<br>
<br>
diff --git a/drivers/crypto/ipsec_mb/pmd_aesni_mb.c b/drivers/crypto/ipsec_=
mb/pmd_aesni_mb.c<br>
index ab917b3fe4..d0f2f5aa62 100644<br>
--- a/drivers/crypto/ipsec_mb/pmd_aesni_mb.c<br>
+++ b/drivers/crypto/ipsec_mb/pmd_aesni_mb.c<br>
@@ -1767,21 +1767,32 @@ aesni_mb_digest_appended_in_src(struct rte_crypto_o=
p *op, IMB_JOB *job,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (job-&gt;cipher_mode =
=3D=3D IMB_CIPHER_NULL)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return NULL;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (job-&gt;cipher_mode =3D=3D IMB_CI=
PHER_ZUC_EEA3 ||<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; job-&gt;cipher_mode =3D=3D IMB_CIPHER_SNOW3G_UEA2 ||<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; job-&gt;cipher_mode =3D=3D IMB_CIPHER_KASUMI_UEA1) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (job-&gt;cipher_mode =3D=3D IMB_CI=
PHER_ZUC_EEA3<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; || job-&gt;cipher_mode =3D=3D IMB_CIPHER_SNOW3G_UEA2<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; || job-&gt;cipher_mode =3D=3D IMB_CIPHER_KASUMI_UEA1<br>
+#if IMB_VERSION(3, 0, 0) &lt;=3D IMB_VERSION_NUM<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; || job-&gt;cipher_mode =3D=3D IMB_CIPHER_SNOW5G_NEA4<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; || job-&gt;cipher_mode =3D=3D IMB_CIPHER_AES_NEA5<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; || job-&gt;cipher_mode =3D=3D IMB_CIPHER_ZUC_NEA6<br>
+#endif<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; cipher_size =3D (op-&gt;sym-&gt;cipher.data.offset &g=
t;&gt; 3) +<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (op-&=
gt;sym-&gt;cipher.data.length &gt;&gt; 3);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; cipher_size =3D (op-&gt;sym-&gt;cipher.data.offset) +=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (op-&=
gt;sym-&gt;cipher.data.length);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (job-&gt;hash_alg =3D=3D IMB_AUTH_=
ZUC_EIA3 ||<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; job-&gt;hash_alg =3D=3D IMB_AUTH_SNOW3G_UIA2 ||<br>
-#if IMB_VERSION(3, 0, 0) &gt; IMB_VERSION_NUM<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; job-&gt;hash_alg =3D=3D IMB_AUTH_ZUC256_EIA3 ||<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (job-&gt;hash_alg =3D=3D IMB_AUTH_=
ZUC_EIA3<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; || job-&gt;hash_alg =3D=3D IMB_AUTH_SNOW3G_UIA2<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; || job-&gt;hash_alg =3D=3D IMB_AUTH_KASUMI_UIA1<br>
+#if IMB_VERSION(3, 0, 0) &lt;=3D IMB_VERSION_NUM<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; || job-&gt;hash_alg =3D=3D IMB_AUTH_SNOW5G_NIA4<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; || job-&gt;hash_alg =3D=3D IMB_AUTH_AES_NIA5<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; || job-&gt;hash_alg =3D=3D IMB_AUTH_ZUC_NIA6<br>
+#else<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; || job-&gt;hash_alg =3D=3D IMB_AUTH_ZUC256_EIA3<br>
&nbsp;#endif<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; job-&gt;hash_alg =3D=3D IMB_AUTH_KASUMI_UIA1) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; auth_size =3D (op-&gt;sym-&gt;auth.data.offset &gt;&g=
t; 3) +<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (op-&=
gt;sym-&gt;auth.data.length &gt;&gt; 3);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
@@ -2448,21 +2459,32 @@ post_process_mb_job(struct ipsec_mb_qp *qp, IMB_JOB=
 *job)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aesni_mb_digest_appended_in_src(=
op, job, oop) !=3D NULL) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; unsigned int auth_size, cipher_size;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; int unencrypted_bytes =3D 0;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; if (job-&gt;cipher_mode =3D=3D IMB_CIPHER_SNOW3G_UEA2 ||<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; job-&gt;cipher_mode =
=3D=3D IMB_CIPHER_KASUMI_UEA1 ||<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; job-&gt;cipher_mode =
=3D=3D IMB_CIPHER_ZUC_EEA3) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; if (job-&gt;cipher_mode =3D=3D IMB_CIPHER_SNOW3G_UEA2<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; || job-&gt;cipher_mode=
 =3D=3D IMB_CIPHER_KASUMI_UEA1<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; || job-&gt;cipher_mode=
 =3D=3D IMB_CIPHER_ZUC_EEA3<br>
+#if IMB_VERSION(3, 0, 0) &lt;=3D IMB_VERSION_NUM<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; || job-&gt;cipher_mode=
 =3D=3D IMB_CIPHER_SNOW5G_NEA4<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; || job-&gt;cipher_mode=
 =3D=3D IMB_CIPHER_AES_NEA5<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; || job-&gt;cipher_mode=
 =3D=3D IMB_CIPHER_ZUC_NEA6<br>
+#endif<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; ) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cipher_size=
 =3D (op-&gt;sym-&gt;cipher.data.offset &gt;&gt; 3) +<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (op-&gt;sym-&gt;cipher.data.length &gt=
;&gt; 3);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; } else {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cipher_size=
 =3D (op-&gt;sym-&gt;cipher.data.offset) +<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (op-&gt;sym-&gt;cipher.data.length);<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; }<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; if (job-&gt;hash_alg =3D=3D IMB_AUTH_ZUC_EIA3 ||<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; job-&gt;hash_alg =3D=
=3D IMB_AUTH_SNOW3G_UIA2 ||<br>
-#if IMB_VERSION(3, 0, 0) &gt; IMB_VERSION_NUM<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; job-&gt;hash_alg =3D=
=3D IMB_AUTH_ZUC256_EIA3 ||<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; if (job-&gt;hash_alg =3D=3D IMB_AUTH_ZUC_EIA3<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; || job-&gt;hash_alg =
=3D=3D IMB_AUTH_SNOW3G_UIA2<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; || job-&gt;hash_alg =
=3D=3D IMB_AUTH_KASUMI_UIA1<br>
+#if IMB_VERSION(3, 0, 0) &lt;=3D IMB_VERSION_NUM<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; || job-&gt;hash_alg =
=3D=3D IMB_AUTH_SNOW5G_NIA4<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; || job-&gt;hash_alg =
=3D=3D IMB_AUTH_AES_NIA5<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; || job-&gt;hash_alg =
=3D=3D IMB_AUTH_ZUC_NIA6<br>
+#else<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; || job-&gt;hash_alg =
=3D=3D IMB_AUTH_ZUC256_EIA3<br>
&nbsp;#endif<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; job-&gt;hash_alg =3D=
=3D IMB_AUTH_KASUMI_UIA1) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; ) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; auth_size =
=3D (op-&gt;sym-&gt;auth.data.offset &gt;&gt; 3) +<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (op-&gt;sym-&gt;auth.data.length &gt;&=
gt; 3);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; } else {<br>
--<br>
2.52.0<br>
<br>
</div>
</body>
</html>

--_000_LV2PR11MB60454F6F9304C01177AA92C781442LV2PR11MB6045namp_--
