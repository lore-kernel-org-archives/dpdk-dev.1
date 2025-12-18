Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8671AD68BDC
	for <dpdk-dev@archiver.kernel.org>; Thu, 18 Dec 2025 05:38:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5D6B540281;
	Thu, 18 Dec 2025 06:38:08 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTP id C015840268
 for <dev@dpdk.org>; Thu, 18 Dec 2025 06:38:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1766036287; x=1797572287;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=RPvj7Pr5RDagFWXQgw73yq1f1XNCCUUvrFtOJMZ8yEI=;
 b=cvviUS2F4PWSQ/N/n8CUIgxg9B7s8FxmdAGPwOkiRxOoRLU4ogwkLUF3
 kEu0TWn3qgphWRNmgmvvrFRibLh66IImxSKPMfgL59ANa6hhzmATnlNl9
 mTkq82TUXiJ2ighQYpeyd6dbSsXVu5A7zO3Lg9+klZpTAtolX0yG7/5Mr
 Wb0W/zfgRFuyc1ueXEhONGHf17SeY9qyTPoLBKiyYTuS7QqyFeFO42T0C
 C0Qlt+GvwSXx9yQLJJ1NmWpj19QTd1INGc8V8RyiWmS+EgR3lsXCKkj8V
 cLZ9YFue1UPfturqoenzUEPE8NRPL1z77KqggvRz3qCkpUSLwPXiWJqng Q==;
X-CSE-ConnectionGUID: Rt748YDjQjWo3JY9iK92iw==
X-CSE-MsgGUID: LkmLFD4+TnqxWdst2ZPggQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11645"; a="67952810"
X-IronPort-AV: E=Sophos;i="6.21,156,1763452800"; d="scan'208";a="67952810"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Dec 2025 21:38:06 -0800
X-CSE-ConnectionGUID: RToYdzNMRyq9SX3W3UUEIg==
X-CSE-MsgGUID: 7cMJlF4USNyieS6IWASozg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,156,1763452800"; d="scan'208";a="202679211"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Dec 2025 21:38:06 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 17 Dec 2025 21:38:05 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Wed, 17 Dec 2025 21:38:05 -0800
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.11) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 17 Dec 2025 21:38:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hA3nTzvELCoFC9Gvgui5M0/o+Vgt4v52aPnLqlssUa/7zKUvFSc3u20wIZgv+ZvBFQ6ItttPjolWpNpa75O16xJMzedIcIR/EKWcNf9Vg6UhK3zE/QozJQh5LAUFY9qq9cWdtJWwhCS9T6fEC2fuRRFX4KInoF1OM2ueCoFJcYkzOhOajQF6phc1FNf2ljsC47MHDvrTYVO0dAjxJZT8di+EGnm9qTh9Gx+CNtVBxGVbyzrTg9weLaCwXtJhWXIgLEYaEJ+aMY1zv04KJSRiH0OkG0n6zH+wFRY8YfaAz3JFLshL6hcIF1K3sQMLO1NdG55mTb5M/Gbr0dK1QeKQeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e1zBGXxxohmBaPZw5AfzkZRfZiRGzUi7WiNZp+OzPzs=;
 b=QYacAqrMbLJFn/i2jQ3T348OCqYDzwn12PQA0VJwxvDvIgQCbeF3FCYt6YJ0uEMfNp0aeRVV86WNI/5k65En1qgCLruPhKNNmrptaEOlqf8jG83xxWWAVW1fgw/j7OSf10pmNm02rgbU47DeuVyXm3n3CPwVzA8EpkxCHgFfocVL1ryXYOm/0ZLeyKpf69QSuGmaPLIGuI2cwt/01+2WQjx/If7DhVUGtAHhHMjtyhn2soDmE6Ighy3/E2d9FsapwUKwU7VF8PMRgRnx12JhBpxE+UPMK2GDsjh1H4UoY6PQnKpwNB0K8LY14KM0n+2IzCbATkCDSlmdmqJ27ootMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY5PR11MB6116.namprd11.prod.outlook.com (2603:10b6:930:2b::14)
 by IA1PR11MB9518.namprd11.prod.outlook.com (2603:10b6:208:5b0::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Thu, 18 Dec
 2025 05:38:03 +0000
Received: from CY5PR11MB6116.namprd11.prod.outlook.com
 ([fe80::2b59:d9a6:8854:e9b9]) by CY5PR11MB6116.namprd11.prod.outlook.com
 ([fe80::2b59:d9a6:8854:e9b9%4]) with mapi id 15.20.9434.001; Thu, 18 Dec 2025
 05:38:03 +0000
From: "Mandal, Anurag" <anurag.mandal@intel.com>
To: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>, "Richardson, 
 Bruce" <bruce.richardson@intel.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "Burakov, Anatoly"
 <anatoly.burakov@intel.com>
Subject: RE: [PATCH v3] net/ice: add MAC anti-spoof option
Thread-Topic: [PATCH v3] net/ice: add MAC anti-spoof option
Thread-Index: AQHcZEGAPn5qQK3460OIGurf0zTObLUPyuyAgAAkB/CAAA4vQIAMnksAgAkzcYCAAAxfAIAAEziAgAAHv4CAAQBQEA==
Date: Thu, 18 Dec 2025 05:38:03 +0000
Message-ID: <CY5PR11MB6116D8BEE614E50DA3DE42A8E4A8A@CY5PR11MB6116.namprd11.prod.outlook.com>
References: <20251113105914.34949-1-anurag.mandal@intel.com>
 <20251203104126.75935-1-anurag.mandal@intel.com>
 <98CBD80474FA8B44BF855DF32C47DC35F655B7@smartserver.smartshare.dk>
 <CY5PR11MB61160E99ADCBFDE1182D6BABE4D9A@CY5PR11MB6116.namprd11.prod.outlook.com>
 <98CBD80474FA8B44BF855DF32C47DC35F655BA@smartserver.smartshare.dk>
 <aTrhuMI14CVK27aS@bricha3-mobl1.ger.corp.intel.com>
 <aUKZmzuLWYguKOlE@bricha3-mobl1.ger.corp.intel.com>
 <98CBD80474FA8B44BF855DF32C47DC35F655F2@smartserver.smartshare.dk>
 <aUK0GxJjmJDB0ojE@bricha3-mobl1.ger.corp.intel.com>
 <98CBD80474FA8B44BF855DF32C47DC35F655F3@smartserver.smartshare.dk>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F655F3@smartserver.smartshare.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR11MB6116:EE_|IA1PR11MB9518:EE_
x-ms-office365-filtering-correlation-id: 42c7a0ae-4181-4143-4d7e-08de3df79d4b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?MN9NvJq6JIxjZLlmjB59/Iwaf5fuGRwJEeAfundyyDsvqYRz2RGdxa4bq3?=
 =?iso-8859-1?Q?SgYmo7Q4Kc+K73PIrAmOFTq2Bw+W5uuJMTVbDfcNwAgX0MBF4ka/NstZHe?=
 =?iso-8859-1?Q?typSp+jCt+WQ57UifqUUH48OSeNBsRfNGvUS8ON6YqEaJSITuThU02ue69?=
 =?iso-8859-1?Q?mGHSvfnOQ32OwWbP5a+nM7drxjKZHeY8orbuzVYKqiCTWe03gCn1qpPmg+?=
 =?iso-8859-1?Q?GDyI/S8KS43Go4H6J144rkw74XWT1lIz1Mmc57WaPN3t8uZ5EgnU/eSKmN?=
 =?iso-8859-1?Q?lo7JFmlJqNzPNPzbEBZpyblB4aFOHfNGNWRJBnd7B8co8Qu53BMFtZX9KJ?=
 =?iso-8859-1?Q?8ULTZZrSlwmsTJEBktQ/RGB7b5sSC/LqXMcL0VqPbWaJcLBN1YbseCWWJe?=
 =?iso-8859-1?Q?MWrn+el5ZV2cxKKs1H88O77NCjWzwDv1YBWYa2Vrhp9eOAFYifet4DrLvd?=
 =?iso-8859-1?Q?jA1Hk2mxAwkuQdN9Dpo6LSpoi4ltL9FQ/hJdg5/UKSlAYrpGUQANeHdGQS?=
 =?iso-8859-1?Q?WN4hbGApiFgjpk9a9Ud2QJiDjgnM4GDRF41vpekg5AP0KR1iZ6mNxWm6Ag?=
 =?iso-8859-1?Q?xxxQXtRGC7pM8CApXL0RnzAOPaSMZ1/HgiAyJT1LPn07sF9qy21nySJaez?=
 =?iso-8859-1?Q?xiAsgspffqk8+bRv7/TuaQmgg7PIT/A+pZzooXkUK0CzCoyPVmGNDBKsqq?=
 =?iso-8859-1?Q?sb9/SuXleAZ9m/hx5+DNvXM5pgJCmqjwtQmJkwx8poUBqbCc5mNQ3WkHjO?=
 =?iso-8859-1?Q?Z27eW2V6ATBirSJtZEljuW1XPB/57AVX4aeoKmvnLjnQbJFko+QvIDfuy+?=
 =?iso-8859-1?Q?x2KUEfD0ZBEm/+Aw7jBSI/wXCQO8eQoakNFCIQdSX+IC6T12gQByawv6vZ?=
 =?iso-8859-1?Q?Y7LFZcmxIpVRr3oZEGtHYkdHDI6ykjc1Efo1yd4/H4W+PLmG9MiuPxJjfN?=
 =?iso-8859-1?Q?WLSBHgsb2J6nAP9TQOIM0YOmUYhRn38m6KvZUlfdYCIJne6tviltQsHLeo?=
 =?iso-8859-1?Q?2h17GyhVI4ryFxo10X68oyjemAquDQf2TQze94lXm1bFpn40Ez//rjxLet?=
 =?iso-8859-1?Q?86yP/IsN9qheKw1amP0GRFJua5lIZK+a4XKKqXIzRc4V0HBdIpQFcCyMib?=
 =?iso-8859-1?Q?2u9UOA28doaASG6pvcJRPZ+Kg0kJqAbTya1SEfCKm8BUNmKKwoMa8Ggsmv?=
 =?iso-8859-1?Q?QZrEv8b4iyBIrYhA73TcGBRMFjXrGebS7U74sC5a2J9FFl7YujMzOIMbEl?=
 =?iso-8859-1?Q?7kUtfzqgTt2OqKi8N1IYzrOZQ/uE84RCm9im2oB/yle2+N9OfhFTmRz70B?=
 =?iso-8859-1?Q?uETkkRCPy/ids0+g5DBrKbiXLn/PJPv3r2cuQqA+RIYGuODRnS0hQGtAsf?=
 =?iso-8859-1?Q?hlgGj1lYAFKN//WO3RZiaUSSARKgZRyzpC06Z2dnZT3L8EtAaaRHmMO+xO?=
 =?iso-8859-1?Q?/GpitA0YUP4j5pziuK65cHisf3SdG90S99A+NpxVmOFMTxg2AK0YixRzqp?=
 =?iso-8859-1?Q?PY1nkzSwJIpWPnC99htzePzWAizgUBT1C8fd1jna6DWQ4NHscFfN2rZGWv?=
 =?iso-8859-1?Q?sK/MHd6fS4ReN5Hv+bWduEtEaA9x?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR11MB6116.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?NJi4neqXijwF8UaAmEqRwtU2RrmkMyMHWaaaR4geC9rSQ0gkfV01S8aoCr?=
 =?iso-8859-1?Q?Xazh7sujhn8MJaiNu+AeWMIAQ640L3UN4H3djDYHJB8ELglzGJCmb4N/UX?=
 =?iso-8859-1?Q?D9Iz9MjOvQzL0jl+ouf+I/D1pwA1TIN9vrk13cA8yvaNHO9QzJ7PhNyI3U?=
 =?iso-8859-1?Q?tYavHldq8xpTHed4p3GgtLCXR3WfrwKVYrWUHyaCDAvaGEBRZXA0GSGrDG?=
 =?iso-8859-1?Q?KWkOe/1XF2z8q5Gixia6sqHhhW1wwECVbBpa4MSV2Z6UDzGMxu26WpO0Ll?=
 =?iso-8859-1?Q?8SoNls/Gk2jvKARsMD4TRpfzXVAMQEe37QbOEDhA/X8BIgSbihbB+XUS7v?=
 =?iso-8859-1?Q?nUHBejkFJClb7QNJUruzDz+wwumTyokdwUz60gWoNZmjm2JGCcWbiDp5l6?=
 =?iso-8859-1?Q?6nu9d7NbDUEBmFzj8vEKIFvae8cn2KWUm4dcaBXa0wpbVbH/Kym3Ol0lmK?=
 =?iso-8859-1?Q?Ygj+LbiHxW98XBoTWpdSIGouHV0OJP0RQf0m5CLMT/ajg5JN/x4v3l4IMr?=
 =?iso-8859-1?Q?vN3PmfeRUzyeA1EtjSPgZ1zonLEbb/qwK+nJ9gZ4xvIubG7wxEauRZCNM7?=
 =?iso-8859-1?Q?gTCV2yWF+FTd2MJm5EsH8W7HCG5zB4hx5Ts1VAqnzoQpCO/FgHe1dihhcW?=
 =?iso-8859-1?Q?1QsIGpg6Yki3bUPRa7faN/Sy8VSxMiI2g67LsWuOKuz5FLP2lTQLGzNu7R?=
 =?iso-8859-1?Q?YgkDuQrJYJihCxRnwAc89UCdIfoAjU6JYDmMg8EV/KEMivq1RfXiNskl1N?=
 =?iso-8859-1?Q?2wmZnxacLnLHFmlJunkDowelhDnxFNo0KjGK8zdMMhIdtQFS5IDS2HodXR?=
 =?iso-8859-1?Q?Y9NV+1FhPlSjN2mKXeqtcqVpP8i2cSYY/KfZlEAPPJXwaYqWREtQN3yWYC?=
 =?iso-8859-1?Q?sURKvvRQaSyIVMIS3IpIfcyVzqzngQj4Jim5ngThVfMwNnp9S3eqSzYFAS?=
 =?iso-8859-1?Q?kdsOpAENchyqPLpe/t/cCGqsZD3YGjcUOkU8FDNs+zHNHcKNkLbMCIyyD7?=
 =?iso-8859-1?Q?y3nYPBIhjAPMeuIJeT7iI5jydWeEXECiPJ7YzSk8JgRleiFACUiw93/4BL?=
 =?iso-8859-1?Q?WzkEZB+JKPF/MsBYKxt+AFMwCjRXzTpN44cBuVMf7d/R6SUsbuDPHvvclY?=
 =?iso-8859-1?Q?nY4LH46smADcgPlCdPXdac0UeXy2R01+3H3mtM8nMslaXaXyai92wj+5GA?=
 =?iso-8859-1?Q?Y6ll6RAIsDjQp6MouOIMrS8+QRfRCRLyQkTANs+0I47C3S9nC7Htvvf+Dl?=
 =?iso-8859-1?Q?0rRmH6cqhL3IpoPG2bqpm/BoTMZ02qovh0FKi9jIFxMlgZotiwOK+Ic9XA?=
 =?iso-8859-1?Q?0VWkeC1BMOIt6A7jRVSqwS+FTL817REKS3ySIL6dtTrHV9EvgV68A8Yrm7?=
 =?iso-8859-1?Q?o2VHjdCu6h1T9g15QdXx1J6gfLDfQjsctwbtCzfZmN2riYGqmynE27Up5N?=
 =?iso-8859-1?Q?bBwuD92DVqW+A0jGGSSq6+JiyYdQwk8Zb5Cmix0Abvt75oDACfI7Yy/8n9?=
 =?iso-8859-1?Q?TVLKcQdYMn6zbKLhEoJ9OE/FNNbVHzXNHRKSfXZqZqjVAisJMaGow4f3cP?=
 =?iso-8859-1?Q?8sDvNxUJkOjXKaRD/v+pWks2qWW9MY6vNbbT/nsoJKmXxJaruv4pOHGeat?=
 =?iso-8859-1?Q?SLjVQvFqSz85IolBXxHA2IZWmAv4TVMQty?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6116.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42c7a0ae-4181-4143-4d7e-08de3df79d4b
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2025 05:38:03.8132 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PSGfRpkxAejIPEr5pBbbmJZ+x7j0CyTaroLIAminCSFh/Cgw80BllFPAn1uSDTyKuqmL0BOwgfjz0ajs/YNb4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB9518
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


From: Morten Br=F8rup <mb@smartsharesystems.com>=20
Sent: 17 December 2025 19:44
To: Richardson, Bruce <bruce.richardson@intel.com>
Cc: Mandal, Anurag <anurag.mandal@intel.com>; dev@dpdk.org; Burakov, Anatol=
y <anatoly.burakov@intel.com>
Subject: RE: [PATCH v3] net/ice: add MAC anti-spoof option

> From: Bruce Richardson [mailto:bruce.richardson@intel.com]
> Sent: Wednesday, 17 December 2025 14.46
>=20
> On Wed, Dec 17, 2025 at 01:37:16PM +0100, Morten Br=F8rup wrote:
> > > From: Bruce Richardson [mailto:bruce.richardson@intel.com]
> > > Sent: Wednesday, 17 December 2025 12.53
> > >
> > > On Thu, Dec 11, 2025 at 03:22:32PM +0000, Bruce Richardson wrote:
> > > > On Wed, Dec 03, 2025 at 03:47:08PM +0100, Morten Br=F8rup wrote:
> > > > > > From: Mandal, Anurag [mailto:anurag.mandal@intel.com]
> > > > > > Sent: Wednesday, 3 December 2025 15.36
> > > > > >
> > > > > > Hi Morten Br=F8rup,
> > > > > >
> > > > > > From: Morten Br=F8rup <mb@smartsharesystems.com>
> > > > > > Sent: 03 December 2025 17:11
> > > > > > > @@ -1761,13 +1763,39 @@ ice_setup_vsi(struct ice_pf *pf,
> enum
> > > > > > > ice_vsi_type type)
> > > > > > >  		/* Source Prune */
> > > > > > >  		if (ad->devargs.source_prune !=3D 1) {
> > > > > > >  			/* Disable source prune to support VRRP
> > > > > > > -			 * when source-prune devarg is not set
> > > > > > > +			 * when source-prune devargs is not set
> > > > > > >  			 */
> > > > > > >  			vsi_ctx.info.sw_flags =3D
> > > > > > >  				ICE_AQ_VSI_SW_FLAG_LOCAL_LB;
> > > > > > > -			vsi_ctx.info.sw_flags |=3D
> > > > > > > +		} else { /* Enable Source Prune in Rx */
> > > > > > > +			vsi_ctx.info.sw_flags =3D
> > > > > > >  				ICE_AQ_VSI_SW_FLAG_SRC_PRUNE;
> > > > > > >  		}
> > > > > >
> > > > > > This looks like a bug fix related to Source Prune?
> > > > > >
> > > > > > Ans: Not exactly.
> > > > > > Initially, Source Prune was disabled, and MAC Anti-spoof
> check
> > > was
> > > > > > enabled by default. This was done by following:- Source=20
> > > > > > Prune is disabled by setting local loopback with=20
> > > > > > ICE_AQ_VSI_SW_FLAG_LOCAL_LB flag in the Rx direction.
> > > > > > ICE_AQ_VSI_SW_FLAG_SRC_PRUNE is added to prevent transmitted
> > > packets
> > > > > > from being looped back in some circumstances.
> > > > > > Now, MAC Anti-spoof check can be disabled by clearing both=20
> > > > > > ICE_AQ_VSI_SW_FLAG_SRC_PRUNE and=20
> > > > > > ICE_AQ_VSI_SEC_FLAG_ENA_MAC_ANTI_SPOOF flags and setting Tx
> > > loopback
> > > > > > with
> > > > > > ICE_AQ_VSI_SW_FLAG_ALLOW_LB flag in the Tx direction.
> > > > > >
> > > > > > As we moved to making both source prune and mac anti-spoof
> check
> > > > > > disabled by default, I thought no point to set=20
> > > > > > ICE_AQ_VSI_SW_FLAG_SRC_PRUNE during source prune disable and
> then
> > > > > > clearing it to disable mac anti-spoof.
> > > > >
> > > > > OK. Thank you for elaborating.
> > > > >
> > > > > >
> > > > > > Thank you.
> > > > > >
> > > > > > Regards,
> > > > > > Anurag M
> > > > >
> > > > > Note to maintainers:
> > > > > This devarg is like the Source Prune devarg.
> > > > > If we want to elevate these exotic features into proper Ethdev
> > > APIs, it should be done for both devargs in a separate patch.
> > > > >
> > > > > Acked-by: Morten Br=F8rup <mb@smartsharesystems.com>
> > > > >
> > > > Applied to dpdk-next-net-intel.
> > > >
> > > Unfortunately, this patch causes changes in the driver behaviour=20
> > > leading to CI failures. These issues can be seen with testpmd=20
> > > where packets
> are
> > > looping back inside a nic port unexpectedly.
> >
> > Can you please elaborate "packets are looping back"?
> >
>=20
> When testpmd is configured for mac forwarding, sending in a single=20
> packet leads to a constant stream of packets being handled by testpmd.
>=20
> > If the packets egress on one physical port, they certainly shouldn't
> ingress back on the same physical port.
> >
> > However, if they egress on one virtual port, and are internally
> switched to ingress on another virtual port on the same physical port,=20
> I would consider that expected behavior - the same would happen if=20
> those ports were physical and connected to the same physical switch.
> >
> > If they are ingressing on the same virtual port they were sent on,
> that would seem like a bug in the NICs virtual switch. A physical=20
> switch normally wouldn't transmit packets back out on the port they=20
> ingressed on.
> >
>=20
> Not exactly sure what is happening internally, it needs some=20
> investigation.

Sure sounds like it.
Let's hope it's only testpmd, and not a broader issue with the NIC/driver.

>=20
> > > Therefore, this patch
> > > needs to
> > > be dropped from next-net-intel.
> > >
> > > Can you please do a new version adding the feature you require
> while
> > > still
> > > keeping the existing default behaviour.  I'm going to move the
> patch
> > > status
> > > from accepted to "changes requested" in patchwork, in anticipation
> of a
> > > new
> > > version.
> > >
> > > Regards,
> > > /Bruce
> >
> > This sounds like the CI needs to be fixed.
> > Why does the CI expect this kind of filtering to be enabled by
> default?
> > I wouldn't expect other NICs to perform similar filtering.
> >
> It could well be a testing issue, or a combination of incorrect=20
> default behaviour and a sub-optimal test case. However, until that is=20
> fully root-caused, I'm backing out the patch for safety.

> A new patch with reverted default behavior seems like the proper short-te=
rm solution.
> While investigating, we can live with the wrong default behavior, as a "w=
ell known bug".
> And the configurability will be helpful for root-causing.

Hi Morten & Bruce,

As mentioned above, I have sent a new patch v4 with reverted default behavi=
our w.r.t MAC Anti-spoof check.
https://patches.dpdk.org/project/dpdk/patch/20251217201143.155053-1-anurag.=
mandal@intel.com/
Kindly review.

Thank you.

Regards,
Anurag M
