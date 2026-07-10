Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 029A2C43458
	for <dpdk-dev@archiver.kernel.org>; Fri, 10 Jul 2026 13:19:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C0A484029B;
	Fri, 10 Jul 2026 15:19:47 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by mails.dpdk.org (Postfix) with ESMTP id D19C9400D5
 for <dev@dpdk.org>; Fri, 10 Jul 2026 15:19:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1783689586; x=1815225586;
 h=from:to:subject:date:message-id:references:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=atELbSmMeelb5Tf9Kcf+OA2CXcKZF1bMAi6bKFLA/2w=;
 b=j1YFpOb9NVN2VZPS0g9FYSB+ou+ayJUmG2QZ4tlpl/K7LiK3bzkmiAhG
 MOlYIgsKCmnnegyE/keW+KA224Gap2orns9f9vQr88RQExHGw3XsgiHLG
 f7wgcHJGoC2TGsW3MAPZ/z7vHOP4jZ/uLJTttNVDbdXi1zGPJsMpFSTnR
 NRPTjh1qIOg8u68Dm5kB55Hf5uiLGJXgW6P0t5yZg/Kgfp5onWukvQGqh
 5Y5uGLunAwQPlSxgncBTBOBcjf4Yrb03iLM8ZD5tczwxSACfwPrjxakRl
 OS5sHsBhELbyepQ0YrpzaUsWsGRTJsF3GAkiec06v1MkH+N8k7OEIX4hQ A==;
X-CSE-ConnectionGUID: LOVw6nl2RRS6AcmlkuqCVQ==
X-CSE-MsgGUID: XZQFboiuTTylUYYlQKOkIw==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="84487438"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; d="scan'208";a="84487438"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jul 2026 06:19:45 -0700
X-CSE-ConnectionGUID: qCQQYbbpSbKEKtTsUMhgNQ==
X-CSE-MsgGUID: K0ARqYNGSxugWHz12EWXSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; d="scan'208";a="284985188"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jul 2026 06:19:45 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 10 Jul 2026 06:19:44 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Fri, 10 Jul 2026 06:19:44 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.44)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 10 Jul 2026 06:19:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CKazxEQVz+Du+/n66nCMiR5hcuowmMCeLNMnBhQ8hRaD1a31JTnWx/rqNbfoNQPQ655i1K7LhikMnmU8fIUPOz6hjmlkY8+TSO3a68tLgdUuCcr+XZGRDEFlZWf4ZOBZ+gTzf+MexaSLaEuLXpmkeFA3kOcixPcJ+Dp8lAQk1imDoXWevSBvM31WPwJ/eQue49YZCeXpbfCAXMal7BD7LGbrqq/yi6Kz5TzW6IOydPF/cLHPA5miyoi6byAI0negE4tbli5cgcQWNLjf/uF0kfwwa2xCTY9WwDwGZcocpnGyYihf++ymanaylbSOKCxLdgVwd5kFWaM3ZHH1GCX7ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=acwoGPHdW/yBX+xPHQk/wffrFcw81LysK/NFOq+JfVE=;
 b=g4B3UCyneE7MfwD70gxrR/Cu14t5tTWxT/0Bw5TZa6hbjByjX4Rk6hjJP0J07FENT7k36pwUUstZf0W2Z8mVUO5QNjCEKPC9sBag7KpfIHVmIEEz5wfr7+epipbfIb8HKtq1wbYt2Z22UJseaJY3B+BwS8nsZj8G253jW+l4Opxn03L49MdsIAk6OtFuyW61RkHk5je0yCx6zjGsZ4k/zWGTG/uEMbr3roiyO72SX5AczgqYlaUpN+y8+/uqMzSNbTbRQJIO/0L5e5EeEHyyYwDWTNynVMs9EEsU3nJ6DNjnndzdU7EUeZFtIDKtvmKjDcNBah8JbNL50oAxxuWmVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA4PR11MB9278.namprd11.prod.outlook.com (2603:10b6:208:563::12)
 by LV3PR11MB8529.namprd11.prod.outlook.com (2603:10b6:408:1b3::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Fri, 10 Jul
 2026 13:19:34 +0000
Received: from IA4PR11MB9278.namprd11.prod.outlook.com
 ([fe80::9bef:c20f:571f:7057]) by IA4PR11MB9278.namprd11.prod.outlook.com
 ([fe80::9bef:c20f:571f:7057%6]) with mapi id 15.21.0181.014; Fri, 10 Jul 2026
 13:19:34 +0000
From: "Loftus, Ciara" <ciara.loftus@intel.com>
To: "Richardson, Bruce" <bruce.richardson@intel.com>, "dev@dpdk.org"
 <dev@dpdk.org>
Subject: RE: [PATCH] net/iavf: check for NULL pointer before dereference
Thread-Topic: [PATCH] net/iavf: check for NULL pointer before dereference
Thread-Index: AQHdEGwBvQpaEv9KekqLYHCqN5W5fbZmu+FQ
Date: Fri, 10 Jul 2026 13:19:34 +0000
Message-ID: <IA4PR11MB9278059BD42DC2B3CF4470DF8EFD2@IA4PR11MB9278.namprd11.prod.outlook.com>
References: <20260710125940.1572978-1-bruce.richardson@intel.com>
In-Reply-To: <20260710125940.1572978-1-bruce.richardson@intel.com>
Accept-Language: en-IE, en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA4PR11MB9278:EE_|LV3PR11MB8529:EE_
x-ms-office365-filtering-correlation-id: 6e5ea07d-3e2f-4e0c-544c-08dede85e291
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|10070799003|366016|376014|38070700021|22082099003|56012099006|3023799007|11063799006|18002099003;
x-microsoft-antispam-message-info: 2npM6Nk+htXfJfvs6Q/BWwvbnu2gCRwOCRE6BwrDFAq0UcOLA6TVPstGpshlC6TBX67dWFGIBsGSVVXthRFPZcl7IWxerg4SDmf22rahaQg4CrX/IvjIlo48p3LmM2yI3q3KmxA9n05Z0SA1WM0YcF8maFJuKnhZYHw7S+TNcJhwAy3zO6dmOnKLIEHdGYoJKdonHLZxoW6ZoOOqomYCv/PdIcK68Y6TaESlguULylhH23KKqpfLjEy4BJEViC1sSQs2xAzDusLgOISkuCUjxN/O/DWthHVkld7g3pw3DwIO+tnHg4fEPAp06XcCQYMW4XXmIMTE0SHmxOLS2fo/m8bFSgkko2V2/HhjID8eMRdCtItTq9Y1i1sx9cEdLPUzgMmmdh8Ck2dZGWxt3a7uY0pbOJ0hTotlh+w/1BkxQDaPbzuUovaFkU81/0qizyrSwDomuCZ+j4cWWIkKM+Rgcx5LaHxZ2oL8AyLPduWCw51ICZltd8RHMxUTCUyK9hx9YeXSc6bPGBHurSXNlUgsLUysl0Xs7Pi5UOcNBSXMEItsvmf+UBbWwn1nrPstib4fH32ypOdUwAdJlLC/HtOlSbr0UBRLsYAnxQnvmboDbXK1LqpJTYzpj5dd/8XRzMDIH0TZxr5cnuwk6ai71HRfjw5iS86odWlhgSzykGtxZXhFNR1+7o+3Ejur1sZJn+e734i0D7ONpGF85n1bYfZX/JEunT+egjmYMxmYXxFbBPY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA4PR11MB9278.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(10070799003)(366016)(376014)(38070700021)(22082099003)(56012099006)(3023799007)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?f4ONGC3ZxmXh1A0oCQbaPpVbG9R9K6kxpTgx1LEu3x7sMWPV2VyseHzw/iSB?=
 =?us-ascii?Q?71KzWhbCRouI4EPH8SvYE9qmoGIwQ2iVNJenVl80JuawiP1ZGoEekGBFwF0o?=
 =?us-ascii?Q?OrlAl91vCOLXyLzXIgK865io8fkB0OQH3ibt+5Q3zdPC+nld81m/z6NZPIo/?=
 =?us-ascii?Q?MuaOcVPI9zK5S3bWNS9EjcLH2DVq74sGb/DbuQEnv3BFMjbz2pg0asRMt/+z?=
 =?us-ascii?Q?4EvY/XKYzoWq65tyftl1wE52jOVmQngMWJiVZbdH0hnEXijjaMd0vdNnRB14?=
 =?us-ascii?Q?qKOZLvoXAjxgaolZ0A5vkVvzajSXhhOLc3Q+RlcCpMsaeq5n4luLvK5XqE67?=
 =?us-ascii?Q?mCsAcLfqoT5Sc3O2h75rU0mkXO6PqNqFdRAIdU715jSkIibNBHijKYXF9jcP?=
 =?us-ascii?Q?Hi17nW9F+OeVuqkIu3kg/J/mBGs7a7taGZvJ9NZb8k+RYnLLeDlRr/Te2EOp?=
 =?us-ascii?Q?II+J+xP77CbsMxGiH2UL3huVFfqWC5WgPLeh/Tb0+cJAq+hAt9ltQ4xJqYdW?=
 =?us-ascii?Q?ajzZzrKEGZUGNrL9KdrqHEAI1YvKiKgpkbYODAR1Nw3SUZSy1iIppq6ibkBl?=
 =?us-ascii?Q?1JOqmq2ShM9f1Jv41eA2HUO4buDN6W1XHyqC7Eihhj2dGX0Fu8EElc4qYmAk?=
 =?us-ascii?Q?1PTsji+s81RECtbu3JA3lDvKmf8om1LLewK3us8W9mL53vhgV6m7mn5X1w7Q?=
 =?us-ascii?Q?BrtWKZV40xWxAi06WFM4zVO34eN2/I5v0SbtnP03UelimJcCGHr+yMDsSwAf?=
 =?us-ascii?Q?P0K3iDu4977rEc+3oqxZUIMncKlC11x8VyI/JMeWqahfjeLTSsx9gAxx1Orn?=
 =?us-ascii?Q?cS01xJnrZGXjZhlD9AQDm07HAbbQU3BKXbQ9zHhOxJ1GXvFXo0qmsAp5h0Es?=
 =?us-ascii?Q?D6bXYMqXdumHlkyq/0wpOzmRZ5cbtwjiAFm+GcJ1f6fK8KDLpTJbl3bO/l1O?=
 =?us-ascii?Q?6gVq/NvgP8RW3nP59kgz6o83vqLbpIST6wQ46WA/xpXyvMH37DaQh/vp7crU?=
 =?us-ascii?Q?yyljaUf6bHV32SSPQAi7aYC7ATp1weqJFRIH6OWinu99igppb7zUa8CSVuNw?=
 =?us-ascii?Q?QgWU2VYIw3AN1CQr5wq7EIvyC0y2KAbnFN5TKcOgYSN0aUABbteS7JRUyeOr?=
 =?us-ascii?Q?h65qx52Vl+wH+yw9yis/zpTSX6rNvdMbyiMt1/sqTj7nI95TYHsoWhOKNrOC?=
 =?us-ascii?Q?Mo52XeV9IDi6NKB2G2ZPRV5tomsq5knJD2L75tebi/ivKA/NzQ27hkEq1el6?=
 =?us-ascii?Q?E+1oe5zEvcaVRrsoI6ISNgB3nA7sW1HdmGybWC+57x8SU745OVnKX/QNIICS?=
 =?us-ascii?Q?X+CVKA/SW0ebnO1LeQJbVi2WmRuwEJswLSYT/o8SWanDEok7nvCtiuRkROwM?=
 =?us-ascii?Q?kp7LwHo9iPbrHf/8faAQ/Rdn8OLxfCrReaRuEgHljbpaq4W0/4skSBEkkWBm?=
 =?us-ascii?Q?wseAX6QIllUXYoMB0DS9eMa5MXy1vhbZ+aM+Vu0YfwtEhg6GjNjt9X0UDubY?=
 =?us-ascii?Q?5CElnb7JiooZitSQbM4IrcsRjYirC6Q0aYIVHFNIDT7lEx1uDpovUUygwbLw?=
 =?us-ascii?Q?tRn34hYv8S8RiuOrpam8Jr3xKxhus+ngh0reDBxAhcYxNk4WvTQz7aKq2gas?=
 =?us-ascii?Q?/p0EhUvjB1YrvyvS1veLZuhtCyMXBrLN/1CEvyfzhCxp64h9hf9RRCQ/9Rg2?=
 =?us-ascii?Q?2T17/veqxqbmeQNs+qA4ZH/wMCBtCozXxreM10e35c2xX7gAmD19QtQ4krVO?=
 =?us-ascii?Q?VSkV/ZKQosELEBxAAwT8OvBuSecttl34/h9gZi7x9IJ0aRgx8lZTXQhX/4GF?=
x-ms-exchange-antispam-messagedata-1: QEQHgJvVOEgF6Q==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: iMvQKg1We3GYcrZn3JrxgSG5iM2+joQ+iAoJVnGgJutT/Js1zJxURJ8oWD/sl8uXkqrs0QfAqBGD3O9KoS0KIkUVK9WytzcmSyp9oNKd5FT/m1EfOaeODOGKNU34yUcsMKoJShpqYPqag4PUEtTy9/62JrlK49vF5p5Tih4Mvbku4Rg7EY3U3zx72B/BDJit3OTgdvTQG3SeEA0MhKwwIcE1uzuEG/jjT3DrsleEXcWqQJLmsA0wGKf8PrBIT6L/bOYFMcBY4ZfCh+VrU5Hf+Kvvo82mpDib+a2WBOCKy2XgnKvqDQdekLEmMVwoV7ECTchMeAr33lWMwQ4wVWFw9A==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA4PR11MB9278.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e5ea07d-3e2f-4e0c-544c-08dede85e291
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2026 13:19:34.6084 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U5ErdqQZMl+5NM3uHCoWFAKcODrJF87REoALQeXf88tBAOFsmEtn5JM8BEiFWq9xURiG6c4xtp5JPxV3xxLANQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8529
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

> Subject: [PATCH] net/iavf: check for NULL pointer before dereference

check-git-log complains NULL --> null

>=20
> Static analysis with Coverity flags a possible NULL pointer dereference
> of "hdr1" when handling IPv4 or IPv6 fragements in
> iavf_fdir_parse_pattern.  This is likely a false positive, since the
> flow pattern protocol sequences are checked before this function is
> called, so all paths leading to a hdr1 dereference start with an
> ethernet protocol, which sets hdr1 to a non-NULL value.
>=20
> However, this is a rather brittle situation, so to prevent any future
> issues if a new set of allowed protocols is added with IP but no
> Ethernet matching patterns, add explicit NULL checks for hdr1 before
> it's used each time.
>=20
> Coverity Id: 503768

"issue" instead of "id"

>=20
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>

Acked-by: Ciara Loftus <ciara.loftus@intel.com>

> ---
>  drivers/net/intel/iavf/iavf_fdir.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>=20
> diff --git a/drivers/net/intel/iavf/iavf_fdir.c b/drivers/net/intel/iavf/=
iavf_fdir.c
> index 8940132dff..ea620863ca 100644
> --- a/drivers/net/intel/iavf/iavf_fdir.c
> +++ b/drivers/net/intel/iavf/iavf_fdir.c
> @@ -806,6 +806,14 @@ iavf_fdir_parse_pattern(__rte_unused struct
> iavf_adapter *ad,
>  				 * ethertype, if the spec and mask is valid,
>  				 * set ethertype into input set.
>  				 */
> +				/* ETH should be present via pattern pre-
> validation. */
> +				if (hdr1 =3D=3D NULL) {
> +					rte_flow_error_set(error, EINVAL,
> +
> RTE_FLOW_ERROR_TYPE_ITEM,
> +						   item,
> +						   "Missing ETH header before
> IPv4 fragment.");
> +					return -rte_errno;
> +				}
>  				input_set |=3D IAVF_INSET_ETHERTYPE;
>=20
> 	VIRTCHNL_ADD_PROTO_HDR_FIELD_BIT(hdr1, ETH,
>  								 ETHERTYPE);
> @@ -911,6 +919,14 @@ iavf_fdir_parse_pattern(__rte_unused struct
> iavf_adapter *ad,
>  				 * ethertype, if the spec and mask is valid,
>  				 * set ethertype into input set.
>  				 */
> +				/* ETH should be present via pattern pre-
> validation. */
> +				if (hdr1 =3D=3D NULL) {
> +					rte_flow_error_set(error, EINVAL,
> +
> RTE_FLOW_ERROR_TYPE_ITEM,
> +						   item,
> +						   "Missing ETH header before
> IPv6 fragment.");
> +					return -rte_errno;
> +				}
>  				input_set |=3D IAVF_INSET_ETHERTYPE;
>=20
> 	VIRTCHNL_ADD_PROTO_HDR_FIELD_BIT(hdr1, ETH,
>  								 ETHERTYPE);
> --
> 2.53.0

