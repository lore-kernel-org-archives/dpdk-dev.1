Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0878CD98C7
	for <dpdk-dev@archiver.kernel.org>; Thu, 11 Jun 2026 08:52:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C0F3642F3B;
	Thu, 11 Jun 2026 10:52:53 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id 5595D4026A;
 Thu, 11 Jun 2026 10:52:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1781167972; x=1812703972;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=IrCyfXdyGHL+TExdbTaFcy9UHDCuOdy9EmsLiJ03SAQ=;
 b=LEK6vXIeCil31rV18+BIYYRfoiqYASmkATtSv+zFGIM/4vIG8I8Rkvxn
 3uG/ditcUoqbSFhYXkAmZ34fX+GL5XSQ1nuStvv5YuvbU69cerz0rOYUx
 ZBQmtLOJmnZMyY921ZeY1JthNXASWwootjVCL6fTeUZzYauLU0u/Hsc4C
 stWJVqiut8SMy9qpMB9ZVTuN57UkZlDkDUCa1K6MrsJJ/RPRMysmJhBhL
 v2cIvj0gxayKQdVof1bTKXoouvx7QYv9rNUhEXyIxf2Q9R0aKo4DnqB0N
 AhJAAvVl0MavyW6m/T22qzIwrkFTi7nvoLjG63d5wdXf6BsCvqdsx7zs7 A==;
X-CSE-ConnectionGUID: /afFkPTiQZ6E5PaFGWgcXA==
X-CSE-MsgGUID: TcIECpt9SgGMEpJgvyvSbQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="81955897"
X-IronPort-AV: E=Sophos;i="6.24,198,1774335600"; d="scan'208";a="81955897"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Jun 2026 01:52:50 -0700
X-CSE-ConnectionGUID: 1by5lVuNTqK/RS5i0GvRcA==
X-CSE-MsgGUID: 6hW8rJGVTTe3tUxIX1A/Lg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,198,1774335600"; d="scan'208";a="243976182"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Jun 2026 01:52:50 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 11 Jun 2026 01:52:49 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 11 Jun 2026 01:52:49 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.7) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 11 Jun 2026 01:52:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oQYYRwadLpjakblQ88LtxJWsnpHnXyOnLFBkmVFLR0S6JFOM1byFyFFkKoNc0BOKvj1NbmZhJHgkSagNCEhfHzugaW8zaRL4LhHa5o8vH0tMcy8pVqFMZDYMW9gmwrPkBEV02u8SFMyCwXvsMflx2o4k4cZv+sZmvgGrkJBVE/GQdl64AKSCjr1OoL+BgH+72ilaJKJc6/cGkC1a0XhBS5G8W/IMTg/2Als8eSCOVQYbjFTE05hkjhxmxYjp9N0Lbmaz82DAmqhGvuPqGh/tRGP9y6MTf2lQTK1OregAPlYnbsT3dhBxREb5YaAKsLc0QL29Dww0Wh6cIUz9EyTgqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h3kQBTPO4VDg7IJBncu4FQbt/ANqClB99Avy9MMIx6c=;
 b=sDe6tZQSIKlq3qLZmbrjn8wMZBt08ENNY3v1V+ASLrJL9Wv2UKv+MOebKioSXP5kQ8+h8PGkRWmvjPwgsRwnSSMY202tqG5MJRGxmac3bf/JWoO3BvQmH8fDrF1QFjU/6k6VOKk6gfmrZ/eLO35ufKNNV2Thmw1qp59mK4hm/HsRvFWcOsMSdPQ69TFEBDjuEj4Iy4vrfYxsyP9RRd/5xloB3ayg/R3TP9+ibiXE+ylqebK3OcuNdQxDU4Z3X6PhfkHxnhvFv8NqaLrljrWo2GrAzuJXwinIsnD0voTHzWQfOZS9irE21vjbY8rvobBgXajXbS22+8rqU+OUVzBL+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA4PR11MB9278.namprd11.prod.outlook.com (2603:10b6:208:563::12)
 by SA3PR11MB7980.namprd11.prod.outlook.com (2603:10b6:806:2fc::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Thu, 11 Jun
 2026 08:52:39 +0000
Received: from IA4PR11MB9278.namprd11.prod.outlook.com
 ([fe80::9bef:c20f:571f:7057]) by IA4PR11MB9278.namprd11.prod.outlook.com
 ([fe80::9bef:c20f:571f:7057%6]) with mapi id 15.21.0092.011; Thu, 11 Jun 2026
 08:52:39 +0000
From: "Loftus, Ciara" <ciara.loftus@intel.com>
To: "Mandal, Anurag" <anurag.mandal@intel.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: "Richardson, Bruce" <bruce.richardson@intel.com>, "Medvedkin, Vladimir"
 <vladimir.medvedkin@intel.com>, "stable@dpdk.org" <stable@dpdk.org>
Subject: RE: [PATCH v6] net/iavf: fix duplicate VF reset during PF reset
 recovery
Thread-Topic: [PATCH v6] net/iavf: fix duplicate VF reset during PF reset
 recovery
Thread-Index: AQHc+O/RPxzKXnv44EW3L0NHVui2LLY5DT6g
Date: Thu, 11 Jun 2026 08:52:39 +0000
Message-ID: <IA4PR11MB92783284E084FA4FEE8422638E1B2@IA4PR11MB9278.namprd11.prod.outlook.com>
References: <20260605202911.314359-1-anurag.mandal@intel.com>
 <20260610154306.371431-1-anurag.mandal@intel.com>
In-Reply-To: <20260610154306.371431-1-anurag.mandal@intel.com>
Accept-Language: en-IE, en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA4PR11MB9278:EE_|SA3PR11MB7980:EE_
x-ms-office365-filtering-correlation-id: aa5c86a4-10b6-4b50-c3fb-08dec796cafe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|6133799003|4143699003|56012099006|18002099003|11063799006|22082099003|38070700021;
x-microsoft-antispam-message-info: F0R3TUjRbgoocYUapYBkoMwPjOac44JmbaAYKeW6b/oyq4eondrRLHdEj01AcLjPDwZ5GNiyM6KOwCYVLhL7/lEIO/h498rSMoBmjsEWiuzHSY2b6dDb8UKxt2tFvlvNe7mfgN4p6BcHD44i5UGonEZSZ89KbOnoO+IVquuPdoMpBrjqTBa3xzoKlMEKOU4Pyd0SO0C2IFA3JIBYfZAYFNWlyO9hCAYys8IFGJvJcqdt6emrNP5GZE3Xe48gwlCl4fScTD6Ysog6QgsDbhPCqf41/c1Syl4L9hA3bC44b91hIt128bzvO9wsrjU164xNMM//p7WSIBR/Jjc5KYSUuF2hsDA+i56MpSp/LVBcLJgj8pFAU/mzFTaL9fCgtS4fLHnwBM0VV594e9LvTqPIzFj3VVJ/fpKau0G7h/1M0PaxUrRMkvUIerteYzCtRPBv7W4Bc87mxRakUxfImN8Wv3oMdiQeN/b9qoU4NIpVWpM3jZlRUnV51TcGQNsR3QNZ+/9HqnUxfjp95LeHZrt0pDeVprg3tWPDqF48VdKwlJ88aGjaP9X8jGGEuVLl/vm2Ufh/t+HT/A0i0keVqKQiVNwyUmoYgOTXPeJSzClzvnR/XawMgvGl1sJ2ebFOTWxzoAzDm7g+/5vCdosC1W3G62s+Tegrq5BwThGWWdQTnN6hU24bA4tDUFNHz20yY2XeDuql/pyg3FCUlo4t3C3aNfqWj2vvaTDO20GO9KSYZKm0814FtyqfPQaNtgqxrgbQ
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA4PR11MB9278.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(6133799003)(4143699003)(56012099006)(18002099003)(11063799006)(22082099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?AKY3Asjr7FBKf6wiu03SVzTmAxIl9OxOS7JCIemG8Rzgd4yFNbbTfIDXqZbv?=
 =?us-ascii?Q?AK39DgKRWJWhdgguECSywlQr5XgA2WujqOVzC5T3zzbdwQ0B0/jemoF6TnFH?=
 =?us-ascii?Q?sn8MIlK3YMI5hbwi7MlKi1uN1FJIBut3OJkA97VMIxGxb4hHmSzLcHagAcxo?=
 =?us-ascii?Q?QidOgLYQKmdxg+yClfC2qsuHmZRmmJqlIR2anEnXOIvI+jYVq0QY57vWMbWw?=
 =?us-ascii?Q?uNAx6/DJ6eB3VGvF0O/W3GsrTdqZrCB9ibjd80jkGAhN5c6QhoNFIbvkd1/x?=
 =?us-ascii?Q?UuAQL4ExbZh9gn72zcShOecbo7f2F5RW9LtiqvdEsEcQ6WPBkXHtCX16mEie?=
 =?us-ascii?Q?8URqoxnABzrb3GOsjHGgFFMgz0rfCZSTuLdjZqANIoQoqWVfoTXhCrVfWD0D?=
 =?us-ascii?Q?9MSy0b3lXnNIOPHr9vz8aHMfiB3DcDHuCWeqO1ck6n31lcMqjWBn+RPWBPKl?=
 =?us-ascii?Q?nncpT4ll6r19qNoHTcF286scSKdQa1lPCnBu9DR+P7SDuMny1IfRBXkFyEKX?=
 =?us-ascii?Q?5GYj0SGP4VoHKyHlCCAxju5aFCx60qqTu70wu7ujwmIH6c7HM3B6dZR7et/a?=
 =?us-ascii?Q?towB4LnvZONLnKXBABCcQiTK9tuIFxn4nugCmpcH6kLIfP4FsiMSlbxI5nYu?=
 =?us-ascii?Q?P1wHOOvFKz+L0gSPYvkkEJvIW6f61NVK69ORddtMt0W4QW+r9guohaaCdJU9?=
 =?us-ascii?Q?IlYs7DRcURWrseuzDoOyWzMy4+bUMsLet+pZsQEJxcYE2vWhF4QjJ4cdRXqd?=
 =?us-ascii?Q?QpYE0A3CwjIqrCSoAgz6pD2cKVkI3qQp+qcS1aFoGdK47OhyxxnZ594EhjxS?=
 =?us-ascii?Q?i0v1q1GHnYUhCZIJn8zcTwZaZ6C5GJBjE3vR+sn8Us41Ot5UJ6q9t0nqXPbd?=
 =?us-ascii?Q?tzoD3KkFGsJihSFkVMWORJbLsxhtpKbLydhJxGFpP2er3NmASBXgIImqDi7M?=
 =?us-ascii?Q?vX1WuytgobnvRAg8GI7dJfKwoYVJ6WzRtRjEiesmyAYHRG7lNyWGomztiAkr?=
 =?us-ascii?Q?RGOWuCbrBTpQ/po5N3iQfiaNi9cDGz0QWaaYwa7yv/EYWAkXSUHJsPpHtRmh?=
 =?us-ascii?Q?fWoKcWvv/kBTTjqsRUkjDbTS6aNahT1FkoltwJKYmG1uGqEmehdoMiKxmyqc?=
 =?us-ascii?Q?QXAdL9WZjr72qUZQ+2HsK7zfkBE5H0G5QX/cgjrFCTLvWgAZSgvnrSNoKgxI?=
 =?us-ascii?Q?rro8LoQDgGqWZnAYHGgb+1t9R/HmWC942eYKyfuTJKTZdYkoAHSRY622518J?=
 =?us-ascii?Q?RJ9NSubtid9laXofjrLAVsLIW0wUtnit7LYcKAMhhzbu1kvLXYKzBYHhI3Os?=
 =?us-ascii?Q?QeyJjdFTKXVWmnip+pt5GbkRmEFHxVdpSqJ3DyFnaQrfVupxtQtqb2dmLrgM?=
 =?us-ascii?Q?nyZ0JiSjZNiFv0BVY90ckgn2I+NW8zUblWbyicrxCJgdFYZZzfQf18HZeVaU?=
 =?us-ascii?Q?3SOyC3lXVp23hk3tW2LV1OGmWYoogNOecGcpzkLyWxpw/pI8aoFc/i76otH3?=
 =?us-ascii?Q?BGNevqrsJtylRB/b6LbnL7OVKbE7sUfXrqZapbakbVZAITtS9wBTHaTbOBgD?=
 =?us-ascii?Q?whlfPGb656PDpZpr3SfvaYgikOMnJOnQ9CJ9AZRZCGKKgxhaU9w1a/GPe1CW?=
 =?us-ascii?Q?gpVG8jVbuijDA0eD8TDtgMlL/aoT1U7WmbU3Y2pAIapxA1R83yAAbyzC1NR4?=
 =?us-ascii?Q?83zCqiqGZsUEQ2/rtigvuM+GrbX5baK2LDuC9oozo/zjBhwCU3BKFz4Cn5sY?=
 =?us-ascii?Q?eD94xsh8CA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: QgtMa5P+Dyhc1t/+XTiA132Mhg5MDfQ5mm97sdk8pzVmsUJw3vJ/Ghu3dJiwiMYauZgB+3BgvngXyCnT5sQowLzx1Cnv0E6ptipC9wz5iHsTiu7P2mpQrHsViB4Rvbs14vkaGlMhJmnoaArXAPspIeDWm/Hys3FaG6FjmQ7juCgkNQH1nqlVOFLjsFOTr2JAcuAj/5U0tdbVSp+eH06Q+ENIRP/ujeBB9KMGSNVmVJI1YTqgQPVcxCcQQ4UK9FhTTyg87EiAmAKapqW1uAmeSwbcvGnHe1dB5GMPs0NSxb+4Ue/dlNPcnbiQ1lXvh7W4ol/aYUVZFRwsJeFx75Mr/A==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA4PR11MB9278.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa5c86a4-10b6-4b50-c3fb-08dec796cafe
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2026 08:52:39.7117 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /gUihbiti1S1dFJCfl+0yk6l38k4mi+QjmOp/0ZuK2HtIvYYt5zUnSVXaZZN8lwfn1qkLyqUw0zU0VnPutq8tw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7980
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

> Subject: [PATCH v6] net/iavf: fix duplicate VF reset during PF reset reco=
very
>=20
> During PF initiated reset recovery, iavf_dev_close() sends an
> extra 'VIRTCHNL_OP_RESET_VF' while recovery is already in progress.
> That second reset can leave PF/VF virtchnl state inconsistent and
> cause 'VIRTCHNL_OP_CONFIG_VSI_QUEUES' to fail with 'ERR_PARAM' after
> ToR link flap/power-cycle, leaving the VF unable to recover.
> This results in connection loss.
>=20
> This patch introduces a new flag 'pf_reset_in_progress', which
> is set only when iavf_handle_hw_reset() is entered for a
> PF-initiated reset (vf_initiated_reset is false), and
> it is cleared on exit.
> The aforesaid flag is used to prevent sending close-time VF
> reset and related close-time virtchnl operation messages to the
> AdminQ when PF triggered reset recovery is set.
> This is done to avoid duplicate VF reset requests while preserving
> normal behavior for application-driven close or VF-initiated reinit.
>=20
> Fixes: 675a104e2e94 ("net/iavf: fix abnormal disable HW interrupt")
> Fixes: b34fe66ea893 ("net/iavf: delay VF reset command")
> Fixes: 5e03e316c753 ("net/iavf: handle virtchnl event message without
> interrupt")
> Cc: stable@dpdk.org
>=20
> Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>

Thanks Anurag.

Acked-by: Ciara Loftus <ciara.loftus@intel.com>

> ---
> V6: Addressed Ciara Loftus's review comments
>  - changed to concise relase note
>  - removed unwarranted comment
>  - added proper comments in two places
>  - aligned commits with latest 'next-net-intel-for-next-net' branch
> V5: Addressed Ciara Loftus's review comments
>  - added separate flag for PF initiated reset recovery
> V4: Addressed Ciara Loftus's review comments
>  - split VF reset from other code changes
> V3: Addressed latest ai-code-review comments
> V2: Addressed ai-code-review comments
>=20

