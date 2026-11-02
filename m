Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62321606A32C
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Nov 2026 03:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=OfpMyDj1
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6B40940264;
	Mon,  2 Nov 2026 04:10:16 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTPS id 7C1CE4003C;
 Mon,  2 Nov 2026 04:10:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793589015; x=1825125015;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=K/Lzz0r2zydwwDKCfrVjFh2awWwH5LGtIX3Km8MJLJs=;
 b=OfpMyDj1O67jxuCoC+H/RzvFX6sqgSFjm47GexwWdeEBzLSyUeIb+w/2
 M/9fhvnEp2C0WCsqZvjM0Mf9jrrbM6Xyk4/CCjO4sfjn/xrSPBtcJMUgQ
 cydz+4bFyk86fyhoghGp8fpuxgPpmiYBqA6pKLtWBOlYu+3sMTZQmhkUE
 jA0jP1IXQFmAdxT40FaX1W9lChPZM597ok+Of+eed2DvRgQ4yWg77/Ylc
 LLZyxreb6v1OPg12cZuBnu8mu75cWa43bheopxGnQVZYLO8RKhNhXIPBd
 XsVkguxvMUWC89Iw1sq2s+tEXR8tNNv4lUBVNa+vsUa/3s4WdIEANQblT g==;
X-CSE-ConnectionGUID: nupS5WQ7STGwqT+Iz7aBbw==
X-CSE-MsgGUID: FBLYQhxKRgq19QhXcQ9XJA==
X-IronPort-AV: E=McAfee;i="6800,10657,11953"; a="2148127"
X-IronPort-AV: E=Sophos;i="6.27,190,1787036400"; 
   d="scan'208";a="2148127"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Nov 2026 19:10:11 -0800
X-CSE-ConnectionGUID: hOVlIHMlTbSlCwyFm11rRQ==
X-CSE-MsgGUID: W1oXs5RnQ5KjrBZfQ6RHfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,190,1787036400"; 
   d="scan'208";a="6383205"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Nov 2026 19:10:10 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Sun, 1 Nov 2026 19:10:10 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Sun, 1 Nov 2026 19:10:10 -0800
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.23)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Sun, 1 Nov 2026 19:10:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KlnqxstloHv/A1PO1h2uyMN3Xky1S5VRHshBoHh+AkVvDPFp/wgch04srPixs+20kaBcdmfQdQ/uwiShn3LmD4ZAN7vL8Vc+TvGtU2AEJcznmsBzujzGnUFqTwFCwB6OzhtgaMlgqgE/IIJQrjflZ979xQhQ6avN4N39yM+J6fToG+FanL3BcrSGxyGiJ1FN5SnRbaMuDJYJMNZMvOnXwnKU4pZJcOS58QZokerpJmjvC2VwGltzJU18dE4osp8KKZg4Lf5b9vdzshF82EN/+Q4ozTDqCPPegcNmQeRjdx1TX7nw4tTZ8pGSDVzEtOs7D3mQ0f9iXjihCSmp8t2g6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nMsIM42FTqBDJCFaKHANfrwBVmAvtXcZJRAONH+xafM=;
 b=vX0hZltzxKFECL8R7TbJVaC5gAv2vt+XnCDT74wOVMT0fR08PhpOUJydKBe01YDdWr5tKJfRaa9UOp+NWgzuaWG6SliPfNDWdHheR74fv9RNlYSZgLfKV4b5SjJnByrXslgck8gG3hW3CanxvfXLYAjw29Zi80EwWM9GgHxJL9dwI20Smi0YjJjwv4hXKQaecHl6Ew/5wutXDW7rOcnmb2jdW3CKRugwYQvQLyKrWM2EX9kN3IpQ4hPqQzsqqoZRKyDYu7Q6W5doTcRCvDUCYtQcSI4mgYYJ9BoRRVld2e5eJjA1Cx72GGHVrPI9Lb6U3agouvHwJK6BqLO4JXgUlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA0PR11MB8336.namprd11.prod.outlook.com (2603:10b6:208:490::22)
 by PH0PR11MB5142.namprd11.prod.outlook.com (2603:10b6:510:39::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.10; Mon, 2 Nov
 2026 03:10:07 +0000
Received: from IA0PR11MB8336.namprd11.prod.outlook.com
 ([fe80::7cba:57f1:37d7:723c]) by IA0PR11MB8336.namprd11.prod.outlook.com
 ([fe80::7cba:57f1:37d7:723c%4]) with mapi id 15.21.0569.011; Mon, 2 Nov 2026
 03:10:06 +0000
From: "Jiang, YuX" <yux.jiang@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: "stable@dpdk.org" <stable@dpdk.org>, Maxime Coquelin
 <maxime.coquelin@redhat.com>, Chenbo Xia <chenbox@nvidia.com>, "Richardson,
 Bruce" <bruce.richardson@intel.com>
Subject: RE: [PATCH v2] examples/vhost: fix hang on exit
Thread-Topic: [PATCH v2] examples/vhost: fix hang on exit
Thread-Index: AQHdZ8adgCjrQoe3LEmxbx5P460037cU0C6AgAVPPUA=
Date: Mon, 2 Nov 2026 03:10:06 +0000
Message-ID: <IA0PR11MB8336C63B4877F6D9D48D4871FE6A2@IA0PR11MB8336.namprd11.prod.outlook.com>
References: <20261029144727.119072-1-stephen@networkplumber.org>
 <20261029165729.1081754-1-stephen@networkplumber.org>
 <20261029110357.543ab245@phoenix.local>
In-Reply-To: <20261029110357.543ab245@phoenix.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR11MB8336:EE_|PH0PR11MB5142:EE_
x-ms-office365-filtering-correlation-id: 4337102e-1542-461b-bb97-08df388ecbc6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|366016|18002099003|22082099003|38070700021|56012099006|4143699003|11063799006|10067099003|261028144727099003|261022105027099003|261026140227099003;
x-microsoft-antispam-message-info: zs8RUMxXtMlQ2WbBfbv2LCnYZuyAHfNL/fjwwgZmgzNClOENWyacwseYffLnmX2A8U971io0rtbOkDayzXb1u4+4nez78tioF8F0YtdG9utP9YUV6K0y3BJStGjB5ReO9reB+cIU6N6aw5pSKgKjQYMuJBtsy1KrpnUdhz44HkLnui8oNS44yGiJ5zEo2Ue/NAhuoR61XMrKzyiXaLKFo8CB8BUOLFnsAfSPqyaK0U4UVz+rbcT/WXDj3l+4YjxRNoYBnEpj+GGKBL/Q48Gb+sEpjc6zoDhvSji6PP7wEhjal9OGIxLLaPPyCaDX3VxVl5NHnu8ohOu8VUYOQhyU3byKxayy2mlaRidrNTogQV9qsZXgziYbGHmzEpP24qETGTL/c+XbPXSCLTluhN45ACDjLxcPKLN/hws4sLQ1XhbpRmkeo0rkiMhrZCtvz+c5E6j9IRdZDz7sbtsnRmDW8AFWt+RCiZYP0piNg+0R9wNr+k94uOGZB1CF2tlRPKC7NnlkUo0AY8d7orBDavernRU0SiJF8xTJqBHAX2vaMAWb5LtmugR6hHPyPtL/9gQ1imRq0+DMLFAQjknTTJ03kaUSSZO4wWjOXKJCBWVaRvV204KiybeTozdNWodI/kiEjKz7Vu0DqqvM8Q9Y5qjdIsnexqcFg1AZt9ko+/jg/VQzMNZdhIcxJ44LldOU8Nd0VbL9ciyh6Yj4xrgjXb1KXug9UdgPGqUHFqzt/gliiyQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR11MB8336.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(18002099003)(22082099003)(38070700021)(56012099006)(4143699003)(11063799006)(10067099003)(261028144727099003)(261022105027099003)(261026140227099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?bSqAJfg2O+i7mXgzXE+LvmRVEJMDovYYizviPmYBaq/2oG018e/8MUCO5zFS?=
 =?us-ascii?Q?wWwwE9mRW0TTqIaxh4ezb0FtQpu5Isj4EKFx40Wqc6sjMSspV2NgnZubhtzd?=
 =?us-ascii?Q?GZCQDoleL9o9zoR5QPdYjUkMEVRzVhs04bJbJq8PpcRBeVaDYdB49UveMDbF?=
 =?us-ascii?Q?D3ggRcnrnKrpCFhEN7YBcTXcfEhTFLk4z5koqWH+n6UrVWjLTzZUWj94ypoV?=
 =?us-ascii?Q?p2L2RXUJDJCP6pvsnNtBOplMUOe01TtzTAtf3v9TDVz68xsDrYJ4xR4BXTcr?=
 =?us-ascii?Q?zthKhDlq4zaLM8MpdDgl8KNQ3h4r8cMl+QmI/xJ3xx7+5vp19NQdOgQMUiK7?=
 =?us-ascii?Q?nZpENfKwt9TVtjaGwNeRU9czJS8CV1n+S0swR1wMzE1innnjm+C1ErcmnEDb?=
 =?us-ascii?Q?A8IPpIXVde/duyXWxMK5LEGc+lrtZmbd4fqMfPzyERT1+zatAjguGURAZ0uF?=
 =?us-ascii?Q?mjbW/vxYXBWp3OFRTtCrRgbbVPojcthYHmCRhwTI/2EcB+dc3YBnOLTDErYQ?=
 =?us-ascii?Q?lOFayVeuEJU4erOpA/AvfMyX2+4h6LhSvJvoQW/hPtTZ0np/nxSks0ZouxAU?=
 =?us-ascii?Q?g2D0UgvrbYEOVPL+rjLXGHlZhe9gRIKsjB6bm5TmrLfD8DvI6G5vtQYELeFM?=
 =?us-ascii?Q?di367dQFQADpNfp+1A/AnUMeHKBCKxu5XOT0IEqEe5Tra7kEosCGmcKMKqhx?=
 =?us-ascii?Q?8fQDuc2nDGTkvDja7Gxf0hXLEQaxkbCY9HNJHsXM4yo91Wlp2PqJ5hQKVgZu?=
 =?us-ascii?Q?M4JMt/pp/V3VkOseP8uEXxVmWQ3XneEUKOOLTghJ8PVrD3rGl0D8xAoxp0i5?=
 =?us-ascii?Q?vxaFEqwi7ORVu/FiRQAeRBCsKzh/UlJFLTJFXMITxuWSNRkg6zbzwg7hdyNP?=
 =?us-ascii?Q?B2W95bjNb/xZMKBqn70czPrcA/JQ2kJWJGftfnAQ/bgh1FdlqJPqpbvt/I+q?=
 =?us-ascii?Q?bnm5AEcbSY0U/qv0q+DjLlyiWXZCTQjFKWd3LCj7x2OwUpbBxcK3yVic49dy?=
 =?us-ascii?Q?LpDIjsz1PAYirb+pkm7Uy93ttFozxTDefmSxhmn3P9mctE+p7UWSnFLGWKbh?=
 =?us-ascii?Q?y3SCJsfNeKx+ps5GZNRhts/jXRKrhkpLBJPefBsuVk8Ks3CdGkD0lk4dIYiB?=
 =?us-ascii?Q?3Aqv1rKq20uBh9r64HQlHQ+JWIXJTxYriOfsHIktHRZw0nKFVpRKirCZB3Sy?=
 =?us-ascii?Q?7beqlb8uEFEoaZ8Ytf2+8VBCGiv9qj767FwrVdmyQKpPt1H+VwKPYeBm0RDJ?=
 =?us-ascii?Q?o0v9e66+GJGpFk9e4qDdmZ17SX49WQgCuvCOSiufn573RQFxKVuBUfzs0m84?=
 =?us-ascii?Q?WQFIdISyvhBB01JZGx91hW6Eua2SJR5yZLhEPIBtQrItPD8L7jIWnPM/TBW2?=
 =?us-ascii?Q?tjLp+VmtW1GxA/XRm6Mlz6u4I0iRtBnb2uWMYoGU7rxGCcvv0XcYbDkpgu8n?=
 =?us-ascii?Q?boCnppwEq93j4OlhuVKW53JWdqReudrKX8DLnniocxQdks+4LzE+9JF5vZxJ?=
 =?us-ascii?Q?ESDN8am9dCe5UaQ+YEL3oWQZiLxw462sVkZj3QAfgd1gJGX7MFkdr2xtEVgL?=
 =?us-ascii?Q?xNrtxfnshFPdd/UCIPECsUNQNq2KjR/KSQaMESpRestutOIrIgWvvvJvCOs9?=
 =?us-ascii?Q?EPmRw91wIFlzJo0i/6mbtZNCPSoBOBjVLg4NsaQUvGziaKNYw7up9q/nZZgy?=
 =?us-ascii?Q?7fp8/UDulQrFauQ24h76UeQ+3Nolbw1wvMFV59pc3GZmEG8l?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: jAmF2VA5ZcE+IlP3naua2/M/EiFFtBmS14oRojoGTuKC9C1DoX8g4GkYFq2BgCHOy5d7g221uX3bf5j9WHCMcB2x9Gfx+CyL8GM7y32TlNfDOoTNmm6uoHP2ghCIMw3F67wEOskc7/+safHBmpGWdVdnGrvfjhbrK4X2eyGHF+clEQhTqBRIX1fWlHJ1iJXk637dFqn9kzCwBV9FYT9YUqV6yU35sfchUfYDTKJql/uTczWfEcgjcygJ/8wgDXyo4QZp6kFmuSmaBm9TAQxrAbpjWM6UmUz8krV+Af9+Q8Wt4zpi+0SqHIqCH3BTwUe4FDr7TZcwLhy92K4jueGjMQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB8336.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4337102e-1542-461b-bb97-08df388ecbc6
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2026 03:10:06.5060 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TXpBEoPbfIjzoPepgsuK9UFXpkk4Yfq6vZ63WcX8jrqrwCtOAVkaWA6DphjLCgJTuSPiUBZDm4iVFHXDAs92uQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5142
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> -----Original Message-----
> From: Stephen Hemminger <stephen@networkplumber.org>
> Sent: Friday, October 30, 2026 2:04 AM
> To: dev@dpdk.org
> Cc: stable@dpdk.org; Jiang, YuX <yux.jiang@intel.com>; Maxime Coquelin
> <maxime.coquelin@redhat.com>; Chenbo Xia <chenbox@nvidia.com>;
> Richardson, Bruce <bruce.richardson@intel.com>
> Subject: Re: [PATCH v2] examples/vhost: fix hang on exit
>=20
> On Thu, 29 Oct 2026 09:57:29 -0700
> Stephen Hemminger <stephen@networkplumber.org> wrote:
>=20
> > destroy_device() waits for the worker lcore to ack device removal.
> > Since the signal handler rework, the workers exit before the vhost
> > drivers are unregistered, so the destroy callback spins forever.
> >
> > Maing thread now blocks SIGINT and SIGTERM and uses sigwait to wait
> > for one of these signals. Then unregisters and tells worker threads to
> > stop.
> >
> > Bugzilla ID: 2071
> > Fixes: 5ffa8fafcbd3 ("examples/vhost: make signal handler safe")
> > Cc: stable@dpdk.org
> >
> > Reported-by: Yu Jiang <yux.jiang@intel.com>
> > Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
>=20
> This is compile test only, and needs ack from Maxime or submitter.

Tested-by:  Yu Jiang <yux.jiang@intel.com>

Best Regards
Yu Jiang
