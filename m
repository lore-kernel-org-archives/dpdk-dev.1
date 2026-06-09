Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E293CD8CA4
	for <dpdk-dev@archiver.kernel.org>; Tue,  9 Jun 2026 12:30:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 13238402BE;
	Tue,  9 Jun 2026 14:30:56 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mails.dpdk.org (Postfix) with ESMTP id 3BEE04025E;
 Tue,  9 Jun 2026 14:30:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1781008254; x=1812544254;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=H4gq83p5alZvyOdf0jTC+VJjWCG53pLme1rYa4XW1IM=;
 b=aqYNowBn5eMbzmUZOoTT9DwQUg7FleNHvcJqGmjUCZwadeo0bMohyvmR
 8DJ8OMyTo8pNlYKozSUr0Bi2BErHGsLuV0es3hCCL8ezUCXkXFUC386BP
 HZy20I7d3rQGDDCLxAhfKHn71Zzt6p5kHnsRswJ65aW5a6kbF3gh660b9
 QEJBriMfKCwqv2ym+5tA+P5cjnBENdNdMxFrAuRJrL0VAIvMzuuIHkNt/
 n5UXCebCwmI+f/2LaeCP1sxe4AsZusTlFuPBia8rVhlDz6CMcDKKSnuhN
 E9u8k+EcWg3bDtQU/qnJBnF/k8CVSwYrvZwim4VA8yrpQIwE2eGDDBf5U g==;
X-CSE-ConnectionGUID: A8l3TAk5RfGCn0xnfsTeog==
X-CSE-MsgGUID: yNGgXUmpQ3SC+uXtAgi7EQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11811"; a="92873066"
X-IronPort-AV: E=Sophos;i="6.24,196,1774335600"; d="scan'208";a="92873066"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2026 05:30:53 -0700
X-CSE-ConnectionGUID: LnO7hA79RlOJlmy9taIddg==
X-CSE-MsgGUID: 2JSvE5qHQJ+5EYYe00FI2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,196,1774335600"; d="scan'208";a="244998675"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2026 05:30:54 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 9 Jun 2026 05:30:52 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 9 Jun 2026 05:30:52 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.61) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 9 Jun 2026 05:30:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tw2Ft6+HQkoMZ3F5ngFXoXsUHuh6LTyX/XDjZlm1bbelVVWekIZFqayVnhNBNBT2eEiLGxP9JPa+qwEeHCVnSRneEeJQZGC7QNCKdLja7O9vkA6j049RsHVjYj3HJ1+Hiug2Bh1IorYWoVVx+jW01fVTZqbHbQQOd6S2jqnKlu1E4ZosLwBuKU7eyOR07rr/R/LKi3AeghYTpsFtn/R1f8HyfEnlmiLf128eg8ytprh8Mo/XD4x58YS0kJvlA+1hBpWyWBcdHpfZ1q0mmkLLJ91skGsqbNsmr6aOkDUQ6SImT69/qoVCbAXqT/UjDj7Gvc30NU83tnAC023eRCEehA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8odv9JrcKjrtBdUiZEA8gTR7+UmnnyyhNn60pzajl24=;
 b=Z612r4Yx9FD8FiapXnmKVrf5rlT7lXGtJXAnwWDn+k/Md1SbWb9TGJIldhNnA7IWEG1zrn1KB8xyPnO4yyTG3SN0KQuBlApkpreWWIkESQ0g96l8VK789cRHFcqUgC2P0hwN1ZCSO0rCnjoF2zrIe5IIsP3iXYVDBk+IEE3JBOD9n54CyFSOmG6/9DG7x6nPTlQq+prGuC/YyPu5O/daL01wq2HuXv58CS/SutO2Li7CfLLr+hPYO0tv2aCxyShRkr2NnO2KEP3MGszGJfLfPJEXksSfkEid52NhLgyWx3Xq+ms50gwxWwkzZJzooDIPK9u+DWups5IzNeU++c2RFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA4PR11MB9278.namprd11.prod.outlook.com (2603:10b6:208:563::12)
 by DS0PR11MB7441.namprd11.prod.outlook.com (2603:10b6:8:141::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Tue, 9 Jun 2026
 12:30:48 +0000
Received: from IA4PR11MB9278.namprd11.prod.outlook.com
 ([fe80::9bef:c20f:571f:7057]) by IA4PR11MB9278.namprd11.prod.outlook.com
 ([fe80::9bef:c20f:571f:7057%6]) with mapi id 15.21.0092.011; Tue, 9 Jun 2026
 12:30:47 +0000
From: "Loftus, Ciara" <ciara.loftus@intel.com>
To: "Mandal, Anurag" <anurag.mandal@intel.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: "Richardson, Bruce" <bruce.richardson@intel.com>, "Medvedkin, Vladimir"
 <vladimir.medvedkin@intel.com>, "stable@dpdk.org" <stable@dpdk.org>
Subject: RE: [PATCH v2] net/iavf: fix misleading AQ failure logging
Thread-Topic: [PATCH v2] net/iavf: fix misleading AQ failure logging
Thread-Index: AQHc+Ae/b96Ocu5zSEuP1K26w1Rh9bY2IWpw
Date: Tue, 9 Jun 2026 12:30:47 +0000
Message-ID: <IA4PR11MB92781E302F372E466C89501C8E1D2@IA4PR11MB9278.namprd11.prod.outlook.com>
References: <20260608171559.355521-1-anurag.mandal@intel.com>
 <20260609120050.360907-1-anurag.mandal@intel.com>
In-Reply-To: <20260609120050.360907-1-anurag.mandal@intel.com>
Accept-Language: en-IE, en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA4PR11MB9278:EE_|DS0PR11MB7441:EE_
x-ms-office365-filtering-correlation-id: 8febe4ba-285d-4911-4f97-08dec622ef4d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700021|18002099003|22082099003|4143699003|56012099006|11063799006;
x-microsoft-antispam-message-info: /1mWguSLamVGy5OUdlMXW5cKTbmCiq3EIRIbqXjPugspZ2inEj4taZr56UFtnaCeeG3T8ZePVAQGPlg5QESDBH35WKcq5yAVvTmjAheLp5sIaiFNlWK8QFBW6iiUDMcpiDtOBpiwCxrhbIgOJhZVLpkeFLihtADRwl223nfXS4dvtz1zuTdTvCnADDz4iSkfpplTInneOGjgcnUE9o1JNO2+RpxFOvdPw4BR98vIg1Z55TSY6qmOr4D1cgK9y3NZKwlijf7KYnJLzXHV0w0cDW7QXKUua4xGePnD8LJVOhjt8O5GEZVRDtSCPGiVOOecIXKb+bx+G9bLz8/MJnPbFV4Wz9X0XR8wjHRUHwj4nVfOVijihHGH5JI6qeCSSWYhZLevz7CDl+jQk2zuOFCwWYo4qZGzlrxrq266sXRwT2O7fHU0YwCKIUu7GDR/laYh8dkMT00rIrd9M9FciO7hWTKNvwGQlqO/UVMIcx6tE2WiglI1yBqby7g2qjo5jSOqChuaRSzPw2UfqSp0bOHkw8sHwYx+qeaTLqdX73AV1mGHS0lVc+b/oj7FLuma/ABIcRCrACria4ZL//0U7q46pbr2Dh8xoB7+04S932InAdafVlTY88oD2lot9x0HD3faxDqu3KL9PRhdPYSeJE+38DyJgLbTwWtYgmHB5qgr3dT0GBP6znwuc55Hx4SG83Zif3g121WJyA/6wgjPkOlpBiI0jNK12X/4ZkR5kGXDunobSdA/3aFVLDGSY0X6a2uG
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA4PR11MB9278.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(18002099003)(22082099003)(4143699003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?UYruCT/1rb95FCixT6ROJ4VY0qh/mWXa+UUJYMKtoDcA2ThHcFH3xYlGfeCO?=
 =?us-ascii?Q?ZyxCLlf/bxPIiyXrxRVlJYL+G/QcCrfVjrUM9D4/bDxp8sd8W/c7KTIo0iZI?=
 =?us-ascii?Q?yyCutJauv8HWHu2AV5l/rwpiPXs2BFbAS8KF7xzCxj8FWciD8of/5D8XD6xR?=
 =?us-ascii?Q?sp5Lmncd7kBuJ9ZP1y/IaHsfP7OrKnFHgkds1AiOmICJj8GJxXRc+G2S+spF?=
 =?us-ascii?Q?0gJxItYN6g3DZyYlClsF5P+PI5GLwjvoCgUS39ymqPaJfH4Ngv1YZ4NQcxqq?=
 =?us-ascii?Q?WVzWqFiXOF3o9/OLQWT1YC2OIGtZphLNwzVpv4x2ly0b4TJFR5kyAoiu3HHo?=
 =?us-ascii?Q?E+0Xm9wNYwCwIHS50u3bZGQvAADtCGaGXD8sh6acsI7sDARa69bW3yEAQc85?=
 =?us-ascii?Q?/EyUFPNCzyIfmKbT47WsQIXmEbnz+PFDlZqMWErjBkmrEQ8/P+DEjrmaaxOe?=
 =?us-ascii?Q?RiNr+H421gHMQQMRsFW71XvVAZBb7RHe0g5+OLg6laQc9FjRSXLj+8dn93Ps?=
 =?us-ascii?Q?9P+ttS9DdpFqKYShGEV1pQgwbGBc4jH3RFj87omuIGivH2ozmn8EzI9R6ZPz?=
 =?us-ascii?Q?wy/Bh946b8Nc5pbh6Gt1Wtj2NPRBLFaQmz7EIzZnB2W74l8ROBUJvD1xxj6K?=
 =?us-ascii?Q?5aRUsa1l4myMsJDcWiRuNdiBjmBWN5+4HYTXn902qzXvBDXoAaiMNkseqTIJ?=
 =?us-ascii?Q?NKNPXqg7LEvXt/9fwcQkmaf1buaOaeijZq45CgRKIfiC11v5gp78Xh8DtepT?=
 =?us-ascii?Q?rrjXyLEuNUbdGTcdZDXj7254DjIhyiKS8V/zWTqhSX3lHq86/WpCpxmqFasw?=
 =?us-ascii?Q?2ySqcOIR0v1267a9TilBeNVyqUjsZ/jtyY7QBc+oMLIb+bH+TNOuuJfMei+M?=
 =?us-ascii?Q?nESv/6WBwvAxnZdV81ub1kpiXt9jWak8cBFu2eqsRVCBOe3c+zZ/bLbyRD5L?=
 =?us-ascii?Q?ajcGAz4/UyB5hOwfECYMIA95D2pfV98ROcQOPUEqBgxOFKQ/889hlBXBqg5g?=
 =?us-ascii?Q?D3Lfvme2hDpishAXPR61fJLra92o2PtXxEVOOMMFddpegbZdJ72I8WiiC0Db?=
 =?us-ascii?Q?1rzOUmaRcAAo9DLqQiNtT0k0iOgzA4OejoeQKKJU30Z2ubQsxi4s0lzCL0F+?=
 =?us-ascii?Q?MVZf0b9JVE1DXLzS3I5cVkqE6UbDaTRaenHCxrh9oNJcnsMjcyYRPhyolyxm?=
 =?us-ascii?Q?/eMCxqO4SD9eAQ5EChjb03W1PaY+fkQkHZB+AvstFVYk2rGYc7ks2va2hb3H?=
 =?us-ascii?Q?q1vjoiFYfnxr/4OjqOsV+L4fsSaxzlczyNNKRfbzJXYqZg5YvZ7xo1aTdtYA?=
 =?us-ascii?Q?+o0G32EB0v/6RE2uKX+zWT1KIaWVqW3MiPGhnTvhWA5izHj+j0I75dM1xIYZ?=
 =?us-ascii?Q?0+305s9keFVsPqB4hqywx0DBibZCgXjacWTcnxA1iebVz+e/UdG4rSCobPki?=
 =?us-ascii?Q?kRCuwpTtdTZ7MTVRaflbKkr3A1gPqivotoalvsQeEp+AqGFvuXWHXejp7iDN?=
 =?us-ascii?Q?oopDvSxus2HHXKEq3cPwGj/BlvE+xDBOQPwjG+oLXikaUM0ChvdIBng4lRGq?=
 =?us-ascii?Q?3jZ4sfeK5HPopGEjf3HI6OsS0SlMEzGt//FWfaT+8J8NR8bcyAyy38tYo1Fi?=
 =?us-ascii?Q?8SU/DJNktFIiZhVzcSepg47QvCHcqSuPk2X5nCjDSZdI3QMd/l47cSJy/VMU?=
 =?us-ascii?Q?taVuEcoZUKVuLct81BTreq0GPaGHzgZ9oFveV7F5qPsGYKRyTwxidFTwtC+5?=
 =?us-ascii?Q?Z3IEQsUNqw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: QEixWGCYoOMh9ONOzVr/QtToAHqlqXPs+BRE+I2e65+AqgVkDVJ9PU0Om4yvmP7dvQuuwgHVnRQQ3lFSiI599RFn1NrBhKs1ke/UtWY/aOUrf6JLaXA8t/YtDtxbg7NPTa/tsvZ2cl27dxLhhwlWkSRA8exwMMzKhGuO7L+Zp10UjWA7XrlDLUewjLx7ZduaolO4tzzlMsWXK9+nlHVo1eDLtgGe5ku4uUKKKYhzBuw+zboxt9jD8s+Oa7d/DSwTakfrRvtEmJX8sWdDrzgxk+r4LhpuaWoWpNaQdwDrcVTvRNhKhh+3kDEdWEJRavKkpjoAtCQ3ntT5Elc/4ENjEg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA4PR11MB9278.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8febe4ba-285d-4911-4f97-08dec622ef4d
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2026 12:30:47.8803 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d48LCPIjLIzBh+EOR/9oo8az1CMEUddMEGR0WnHeAz5pznfxHc/bz8q8CRUuzZ4TY+y6BQ66LvndJCsfgGUwZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7441
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

> Subject: [PATCH v2] net/iavf: fix misleading AQ failure logging
>=20
> iavf_handle_virtchnl_msg() drains the admin receive queue in a loop
> until iavf_clean_arq_element() reports that no descriptors are
> pending. When the queue becomes empty, the base driver returns
> IAVF_ERR_ADMIN_QUEUE_NO_WORK (-57), which is the documented
> terminator for the drain loop, and is not an error.
>=20
> The current loop treats every non-IAVF_SUCCESS return as a failure
> and logs it as follows:
>=20
> "Failed to read msg from AdminQ, ret: -57"
>=20
> This message floods the logs on every interrupt cycle and misleads
> the triage during VF reset by chasing a real virtchnl problem
> seeing these spurious -57 AQ failure lines in logs and assumes
> the admin queue is broken, when in fact it has just been drained.
>=20
> This patch fixes the aforesaid issue by treating
> IAVF_ERR_ADMIN_QUEUE_NO_WORK in virtchnl message drain as a normal
> loop exit empty-queue condition and avoid logging it as an misleading
> AQ failure.
>=20
> Fixes: 02d212ca3125 ("net/iavf: rename remaining avf strings")
> Cc: stable@dpdk.org
>=20
> Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>

Thanks Anurag.

Acked-by: Ciara Loftus <ciara.loftus@intel.com>

> ---
> V2: Addressed Ciara Loftus's comment
>  -  kept 'break" for ret =3D=3D IAVF_ERR_ADMIN_QUEUE_NO_WORK case
>=20
>  drivers/net/intel/iavf/iavf_vchnl.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/net/intel/iavf/iavf_vchnl.c
> b/drivers/net/intel/iavf/iavf_vchnl.c
> index 94ccfb5d6e..39ebddff31 100644
> --- a/drivers/net/intel/iavf/iavf_vchnl.c
> +++ b/drivers/net/intel/iavf/iavf_vchnl.c
> @@ -571,8 +571,16 @@ iavf_handle_virtchnl_msg(struct rte_eth_dev *dev)
>  		ret =3D iavf_clean_arq_element(hw, &info, &pending);
>=20
>  		if (ret !=3D IAVF_SUCCESS) {
> -			PMD_DRV_LOG(INFO, "Failed to read msg from
> AdminQ,"
> -				    "ret: %d", ret);
> +			/*
> +			 * IAVF_ERR_ADMIN_QUEUE_NO_WORK (-57) means
> AQ is empty
> +			 * and is a normal way to terminate the drain loop.
> +			 * Log error only for genuine other failure codes.
> +			 * Incorrect logging like this during VF resets might
> +			 * mislead into chasing a non-existent AQ failure.
> +			 */
> +			if (ret !=3D IAVF_ERR_ADMIN_QUEUE_NO_WORK)
> +				PMD_DRV_LOG(INFO, "Failed to read msg
> from AdminQ,"
> +					    "ret: %d", ret);
>  			break;
>  		}
>  		aq_opc =3D rte_le_to_cpu_16(info.desc.opcode);
> --
> 2.34.1

