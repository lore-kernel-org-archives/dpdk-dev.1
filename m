Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF049D111A8
	for <dpdk-dev@archiver.kernel.org>; Thu, 27 Nov 2025 16:51:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B578340658;
	Thu, 27 Nov 2025 17:51:51 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by mails.dpdk.org (Postfix) with ESMTP id 049274013F
 for <dev@dpdk.org>; Thu, 27 Nov 2025 17:51:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1764262309; x=1795798309;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:mime-version;
 bh=Nwo4/999CchcUk/HL/aYxoXiCoqxnv9yZHLUuIk6cDk=;
 b=i1XNzu5iMDPfhj1XEzp6YtDRc6AawqpM+sOMmLNT7aCZpdoBzKW0I+OH
 YAdZAoDhBs4dQtCWtbHs/hCrU/B2sJ3dY42lwjtnT4evlfvNRqDIbG42U
 g1K/xSo+WwH1zy07sWNNR2lo/W0J3Au+0eN/AqaJ57ekyjrhqMglHogOC
 9xYwWVZTop4yHmYMujUb2oGj4oM5i+G9tWp8oXdXGmmBRdeSm5B/TvE6b
 DbzwRPWipjTfdZw1GNCWFlkHUIhNVn6KIGw5kEvnZH7LPtvevIxOKnf+i
 6j7rC++uQprMh/NignIHLPpbHysNFKB0d4YC/o8o8PvPWw/ovfz0Wxmoi Q==;
X-CSE-ConnectionGUID: nSd9ojh7TpOo53q22NAV8A==
X-CSE-MsgGUID: N+MAeFXaSwanWr9GzzQPUw==
X-IronPort-AV: E=McAfee;i="6800,10657,11626"; a="66472575"
X-IronPort-AV: E=Sophos;i="6.20,231,1758610800"; d="scan'208,217";a="66472575"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Nov 2025 08:51:47 -0800
X-CSE-ConnectionGUID: 4EcRENLCSTW/tCAaFbaOfQ==
X-CSE-MsgGUID: jEbEt5fJRPylXFj91LgcZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,231,1758610800"; 
 d="scan'208,217";a="230549054"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Nov 2025 08:51:47 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 27 Nov 2025 08:51:46 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Thu, 27 Nov 2025 08:51:46 -0800
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.36) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 27 Nov 2025 08:51:46 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MJcqSulqGb7pKGbhG122pzTlx8PsOglfPBa2Fkmh2B2Uuyj3maM8ilk2cVlvv/vlEIA9pmlcqY1nepSorVmB6gFznD3cXx0gfLHtSOgYtyYrpVZVpWhaElM76NhzO5QClrfsopkhHYC0bSJVVP5l6IN+YAcoAiIRk8Rmhxu4gWW9wKeKx8Ui/M3lhc9mmHo6JCVcCwRBz14GCNqM0iE5Wa0iaI8zxUdXSKnqhbyVAsLjk9CB1CDorcRfofdmHvLj+hmzI6qgr4R0H3sktJdqx81Ro5MuHsdjVrUXO+7yl0FxTT2h9CcOyqrCIbeInRNsJlsW/eE8if1nW15UOYY40Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q6elXIySegsxZEDJrmP/ASYEtYlv3R2f5oEazf5nz2A=;
 b=eNPQ4RFLRvt4ngRSjyhJ5rxVgrrDUPu7LADe0kzAAFu7n/85/t6Nb4MzNSScFRcJlejLi8+ScIOIT2Ez6ZfDyWkSJf5wfnGJTPnKm1ifY0ZOSd1jLM+WqT1oapOW1tY5LRcjg8B44SG+G/yGOuy+cGmih3bOuxl2K3xQo3wbdOnEqJ18bSAxh4Vl/64uAeG+cTJphSIclOumO5EGDGrONVk1X0647+jDHVW0GyKHjenbeNHI+itvJ+Ia15SvzG7EMbNDDAcNqCspW9KXzUoVeYje+IkmgwxnD8wE/zrM5/6kxb1bNlvDT5JXgzb8p+puqJRpcGhvY+4ZWyzRPH1+iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB7458.namprd11.prod.outlook.com (2603:10b6:8:145::13)
 by PH7PR11MB8597.namprd11.prod.outlook.com (2603:10b6:510:304::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.14; Thu, 27 Nov
 2025 16:51:41 +0000
Received: from DS0PR11MB7458.namprd11.prod.outlook.com
 ([fe80::6d78:37d8:c835:540]) by DS0PR11MB7458.namprd11.prod.outlook.com
 ([fe80::6d78:37d8:c835:540%4]) with mapi id 15.20.9366.012; Thu, 27 Nov 2025
 16:51:41 +0000
From: "Ji, Kai" <kai.ji@intel.com>
To: "Finn, Emma" <emma.finn@intel.com>, Gowrishankar Muthukrishnan
 <gmuthukrishn@marvell.com>
CC: "dev@dpdk.org" <dev@dpdk.org>
Subject: Re: [PATCH] examples/fips_validation: fix dangling pointer for SHA
 test
Thread-Topic: [PATCH] examples/fips_validation: fix dangling pointer for SHA
 test
Thread-Index: AQHcF/4lsV8c1wl/2kOAiJRDCe/QbLUHTBnD
Date: Thu, 27 Nov 2025 16:51:41 +0000
Message-ID: <DS0PR11MB7458615495E52E6745A0DEDA81DFA@DS0PR11MB7458.namprd11.prod.outlook.com>
References: <20250828092822.2791101-1-emma.finn@intel.com>
In-Reply-To: <20250828092822.2791101-1-emma.finn@intel.com>
Accept-Language: en-GB, en-US, en-IE
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB7458:EE_|PH7PR11MB8597:EE_
x-ms-office365-filtering-correlation-id: fecbf91b-f127-4be4-5c8f-08de2dd53d72
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|42112799006|376014|38070700021|8096899003|7053199007;
x-microsoft-antispam-message-info: =?us-ascii?Q?DBN8XAscQnCfsx9Oc1Aj2R35Ibrqkw4XZTPxTsAARxE959oE4g9r00NjamQY?=
 =?us-ascii?Q?Ec91ophC45k6yVP/sP5szpcssH2mMf173BLCB+k/A6u/Bi+AbaC3MwwqLvQN?=
 =?us-ascii?Q?2Nm/SSuRo1M3kjBTqYerCMYuXM1EnoIWpLEQ1BszvVP8AYvgneWbF8ASWe+7?=
 =?us-ascii?Q?G462soSqdixGhEKg/c7loeOpABE88T20dypYQja8jbGPj6lUGOz9HBCCRZDw?=
 =?us-ascii?Q?T8+/qkcXfb35unTTJ13RP4jBwwwMyc9jk7lmR1uboeN5Lj9jFQHE6uFtWi0h?=
 =?us-ascii?Q?bALHmxyFuZsC27koPjtM+yeItJzcwIJHxtxtY/w/UD7NHAyTwMr0hwNn7mdu?=
 =?us-ascii?Q?/ei5x15bp7Y2ffkx4kbptIUKg33qR7/CzbN8JohWW2wXZHPa+/NPOoFAN4MP?=
 =?us-ascii?Q?YWrF10eOSEWKSB50QZHJFv83+JqTVAKUXnpvdH/Q/RpF6a4bpE3I74kKRyJm?=
 =?us-ascii?Q?nTymXs+XgVNAi5yYGWLCMaAheF9QPzB/rs5HnQCTY4N4uA2NYfOL7erbbRpQ?=
 =?us-ascii?Q?Mn4QWWntOMinfpOLm9qm1In34GgEDru1R3JEpgEZq41Tk4/mXoMGcmacGb5G?=
 =?us-ascii?Q?JdLa6OSQpbWHU4rwh7eL1mlv36nX7DNF1Tyc9ELrc5mjPBcidcEG0IGjzr83?=
 =?us-ascii?Q?mELx7ZsqjmaATSwGCbHNGwU8V0fzJe2EEZH0xXUy7OgMBvG+Croc0avCDVV0?=
 =?us-ascii?Q?jgt2TBOHhYmelPrGHJo+OtZVoaKxVU0SNE6nSkGkdeAmzwuD+xzCF2TLZXd9?=
 =?us-ascii?Q?z1ruxyGQoQdDkA5pC+Bcf8SCDEjTfNRKY8EodwsBxQVswDx1CKqlMjIZ0kap?=
 =?us-ascii?Q?fmIU9P74y04Ha3AzD61Ceh2w7qgc1AMzmDHflfBZI2/ykCDShAopLkc5Gc6x?=
 =?us-ascii?Q?U0Y/ijHeMJ2gUBasyAZBKX/6W1ywJEVX5gAqQtW25yz+vSgUA8sZu4W8pffQ?=
 =?us-ascii?Q?hDqCxqJaPGvWjLYkkakK9bOsPL+csAqwdxZyu/o4xrbWUvZ2V+e3s36WnNec?=
 =?us-ascii?Q?Wy8JK/tn5/Q6fqI1ldKR6qDDJfYKI/zx8JXt/WKxVGVgx6qXwRfz8IuSOyHq?=
 =?us-ascii?Q?xpF8tSGDDkgfEigCxLJdzWfwKHbg9cVAabuv/Y4xUTyrt8r8Q8SU6VyV3j7w?=
 =?us-ascii?Q?EkrpvzedWH4RNy9I6MUVZiD8bhkRtDjtQ95TdOkuAeHOlOb4MVAwBH+o1ng1?=
 =?us-ascii?Q?M2hxLRHZu7q4kqf5cJp66ekAOKTGe41LiIZlnhIp4ydrWHbNvDScFjyuiZK6?=
 =?us-ascii?Q?I41gyMPKPo/IPHNYusC94x0Yv3+UwyF7cnskDwpjsyBWKENq/8RRUHjyBE37?=
 =?us-ascii?Q?NT1XE0HIRqKZJ+oPiauBjOWOtXYjD9OhRAV8INMVbdN4XSySGmA29GzDBaNS?=
 =?us-ascii?Q?06OIJofN8k7XnLrHh1KCJtjAxqdZApZBnblV2BtNUgsDMIODnba00X6kueK+?=
 =?us-ascii?Q?MwFsHZu5myq327w75tb05zlZiJYItEPfTDM/2l9mwSqSjDBH9nAYwcmKDdAw?=
 =?us-ascii?Q?8wW4TUeL13BFbbguN+pK3dAIeSspB+Hdfl9y?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7458.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(42112799006)(376014)(38070700021)(8096899003)(7053199007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?tphnoDiJjOIsVX8ceJgpt75hUw85vTQ9Js2hVssYiKMw6S+Mfdx/3J/qFdoC?=
 =?us-ascii?Q?kdMdH5s7GkDA4615Vh5UxIQaWwICNeQVzpZe9Z7mw8594YDBNdYaH6i/O705?=
 =?us-ascii?Q?mbx9SdXORlz06q6sl7NCwBMC8dvyE29eS/8nGEY2zwLz0766cOxZah7FgrIU?=
 =?us-ascii?Q?A17k4kFJ57U9u9OnrRfJhJzuDxKvmU0UdcIk8Gy2RL1tm11sA1OR4yA5GHn2?=
 =?us-ascii?Q?oeKpuWQ0OsOn1RjWQG87kasFHcWWx5Xv4noytwTECDM+pxpc7LkevdKClWW+?=
 =?us-ascii?Q?uukFtM2SjMzMKma1zAEEDY96ulZPFMrAH8pS2+sDQD8Wybm7PZXGK62E/7G2?=
 =?us-ascii?Q?ERjZEhkf+S6Aj4JLXOxoFodfeROXvfwjzvT/nCZBHvi8hhfLfJfHA/RoavnX?=
 =?us-ascii?Q?nS4Jx25U+NF88quJW1XoBSn7JGN98QUm5D9o7jxnHmDvO5qQD7iHmiD89ckw?=
 =?us-ascii?Q?txzlbHzunTYN+79ocaGW0W7cg/U29tgtV/fJrNk+J371ZmLhW3lc7wcU0d6T?=
 =?us-ascii?Q?zLJUL1XEzs7LgZMMtbzuZnnuK5vWHUwWW0in5dyY90tMQoFNKALIltQjAChn?=
 =?us-ascii?Q?jaypxzNJb1hlKdSlQv1Rv1StH2sZ6o3YwHQW9pXN61io07oNl+E0s4fX8ABT?=
 =?us-ascii?Q?+1hpf0z/8xdtJRp6fCIUbozxvQY7ocMzRZJaRsn0o3hdEJWY7WGXS+625/eV?=
 =?us-ascii?Q?EgcIo4a33zF8j5UToVhUO+NBVO2RbkmpepXKMVFGEzrqP4m9m7z0bCznyD2f?=
 =?us-ascii?Q?BdDt/NTQWYoyJoErULVZ56JYtr8HWdKuKjQ4+NVNidgEqJ2Jshn8jtDD+fVQ?=
 =?us-ascii?Q?SAztI5/FT2iQ04W2FhlTJFEanRIPiRm4l/IsaLmPJPCRLDq3Ufv5WI3zeNIo?=
 =?us-ascii?Q?OWErOxxSmeIcFKHPZAoHh36IQEf9tUdgUPpqO+3P9MFwROE7ktp8mJQ1pp0H?=
 =?us-ascii?Q?D6aTxU998L212SqaXVQMFPtt/gU2DMZDfNaiHI/8FvAQFcHqpgbUJWUF/6Dl?=
 =?us-ascii?Q?QhJue7wT3ExUiKb/UuXlEZ5iJNYX1X84u2YblAiJ8A91enGlKn20UYTzU470?=
 =?us-ascii?Q?JDhinvn2QK1Bdr8r0ajb3O6Ubuclj/fa6GU8MnVtjxkMgqVJOhrM5CtLIZTO?=
 =?us-ascii?Q?MqDUEc44FWDgpxX9+MhBjWbwUnt512kdm8zqODcGNZXwe4Mrl/0wHhIQwuR3?=
 =?us-ascii?Q?an8W/TK/5pF9ytp56cLpJ8ZS/Iu5cxPFGmFIywG/lf2CSR4K+skT+WsYlzru?=
 =?us-ascii?Q?0zVPavtgmqEH9qX0mJWd8IMTr5iRCpqOz4SNQJqlkKsuaLjgZUotxYwrSXoa?=
 =?us-ascii?Q?K3VvADXcWHA0fFbdpoQLW1g+z5+5/oTcbFEpKA2kLatnsMLQ2PPHinVeFeaU?=
 =?us-ascii?Q?QAS8s7xiTnaY+jN8Ecwwc2M57o3rqbLbGDJ0Cyko/i90VSlCh7Y1N3psqPMw?=
 =?us-ascii?Q?KiJ+hbZlIzqE2oakywy2IoHrnshezuWFMmxcZndd9I11y+zswdolxNIz39qh?=
 =?us-ascii?Q?wlp0+44Sxxydhd7O3f1XTtlVMhDa4D/YfBX7a5QcRxfAEWs4lHRsjvfnJ5Cd?=
 =?us-ascii?Q?9JMeXAVMuf49Aa93lX0=3D?=
Content-Type: multipart/alternative;
 boundary="_000_DS0PR11MB7458615495E52E6745A0DEDA81DFADS0PR11MB7458namp_"
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7458.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fecbf91b-f127-4be4-5c8f-08de2dd53d72
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2025 16:51:41.4811 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KUu8rPBdKGFIU72wLz/hJkVifgbEtSpujLlm8oQfqrhizyiESNApS4sJNlQJp0oE2HTfFGx03r/40pfNca913A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8597
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

--_000_DS0PR11MB7458615495E52E6745A0DEDA81DFADS0PR11MB7458namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Acked-by: Kai Ji <kai.ji@intel.com>

________________________________
From: Finn, Emma <emma.finn@intel.com>
Sent: 28 August 2025 10:28
To: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
Cc: dev@dpdk.org <dev@dpdk.org>; Ji, Kai <kai.ji@intel.com>; Finn, Emma <em=
ma.finn@intel.com>
Subject: [PATCH] examples/fips_validation: fix dangling pointer for SHA tes=
t

Set vector pointer to NULL after free to avoid calling rte_free()
on the same pointer twice in some cases.

Signed-off-by: Emma Finn <emma.finn@intel.com>
---
 examples/fips_validation/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/examples/fips_validation/main.c b/examples/fips_validation/mai=
n.c
index f21826e9d7..60ee9f8dd4 100644
--- a/examples/fips_validation/main.c
+++ b/examples/fips_validation/main.c
@@ -2612,7 +2612,7 @@ fips_mct_sha_test(void)
                 rte_free(md[i].val);

         rte_free(vec.pt.val);
-
+       vec.pt.val =3D NULL;
         rte_free(val.val);
         return 0;
 }
--
2.34.1


--_000_DS0PR11MB7458615495E52E6745A0DEDA81DFADS0PR11MB7458namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family: &quot;IntelOne Text&quot;; font-size: 10pt; colo=
r: rgb(0, 0, 0);" class=3D"elementToProof">
Acked-by: Kai Ji &lt;kai.ji@intel.com&gt;</div>
<div style=3D"font-family: &quot;IntelOne Text&quot;; font-size: 10pt; colo=
r: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Finn, Emma &lt;emma.f=
inn@intel.com&gt;<br>
<b>Sent:</b> 28 August 2025 10:28<br>
<b>To:</b> Gowrishankar Muthukrishnan &lt;gmuthukrishn@marvell.com&gt;<br>
<b>Cc:</b> dev@dpdk.org &lt;dev@dpdk.org&gt;; Ji, Kai &lt;kai.ji@intel.com&=
gt;; Finn, Emma &lt;emma.finn@intel.com&gt;<br>
<b>Subject:</b> [PATCH] examples/fips_validation: fix dangling pointer for =
SHA test</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Set vector pointer to NULL after free to avoid cal=
ling rte_free()<br>
on the same pointer twice in some cases.<br>
<br>
Signed-off-by: Emma Finn &lt;emma.finn@intel.com&gt;<br>
---<br>
&nbsp;examples/fips_validation/main.c | 2 +-<br>
&nbsp;1 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/examples/fips_validation/main.c b/examples/fips_validation/mai=
n.c<br>
index f21826e9d7..60ee9f8dd4 100644<br>
--- a/examples/fips_validation/main.c<br>
+++ b/examples/fips_validation/main.c<br>
@@ -2612,7 +2612,7 @@ fips_mct_sha_test(void)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; rte_free(md[i].val);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rte_free(vec.pt.val);<br>
-<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vec.pt.val =3D NULL;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rte_free(val.val);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
-- <br>
2.34.1<br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_DS0PR11MB7458615495E52E6745A0DEDA81DFADS0PR11MB7458namp_--
