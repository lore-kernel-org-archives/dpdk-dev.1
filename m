Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 572FEC5CFEB
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Aug 2026 13:24:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 609C5402AC;
	Thu, 13 Aug 2026 15:24:56 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by mails.dpdk.org (Postfix) with ESMTP id 667F240298
 for <dev@dpdk.org>; Thu, 13 Aug 2026 15:24:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786627495; x=1818163495;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=vKbfbT+xxc042rkCkkwLCOADs71N8vV7GKNBtJSj+Ho=;
 b=SREkl0zIrbqsa6OTFDLgoyMa7Sl84j6wbVLjKeRywKHU173oPybrkeDP
 ghn4Tm1bVcf0fWRsWu5I0WdRj+8TrW4IvIbsjNpIKs0K3E6gLRcf38MMV
 rxmUqQ3o/HhDg1ZpktLF4g2pMXWKGZw0FdHzS4EoVeEJUfwknUXnGcUtx
 ezjd66zGI1jip2mREWh7bC6bDjGjZMm7IaUymDvJ71ryCSnD7c1mMFQVn
 JRfxLlCfkAqdNygap1mX6MmJprwvHIN1+WeAoC05mWJk/q72e8bQPC8zS
 lGnR7T5lfq/p9ZVzMFxHayUfKNuN7lRm5QDqMioqnoDk4/GNe8EvGTCrv g==;
X-CSE-ConnectionGUID: GiPXOl7yRSqb+rLGSgG3Hw==
X-CSE-MsgGUID: wxgswSPRQEK+kvWg8IGHOQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11873"; a="91075206"
X-IronPort-AV: E=Sophos;i="6.25,221,1779174000"; d="scan'208";a="91075206"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Aug 2026 06:24:53 -0700
X-CSE-ConnectionGUID: 6oxdhHsQQPCLvpe8yaZy7Q==
X-CSE-MsgGUID: g8NSK1kYT12CoXxLs6y9BA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,221,1779174000"; d="scan'208";a="302201876"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Aug 2026 06:24:54 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 13 Aug 2026 06:24:52 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Thu, 13 Aug 2026 06:24:52 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.63) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 13 Aug 2026 06:24:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jH0kEVunlLe0MLiX0inlze1PboJeywlp4IdlIlRbAIgMGcZTOCzsxrc9m5kxn15bBvoBz9aUhwSASx4itOIbKF65B+XXaJVnaX5mGB1Xb0rfSZuPauDAnDOYzge+lTvgObQdCaBHAMjTjy4UXNPlkwcbmhtk8SFcqLV5xoh3A0kv/Om80qgLeinIz185ihVZDnSs6jIiHkP1AFIZwdNRNsRafqteMcSoJHPAJSxsmRLoTRmfdmiQKVLpO5k8BNmvq+Hwm09SEr9RneeWPaUMKz8Z2LLf7JPW+0vHYIfprAHbQQ5Kad854WwtxDn0LB1sLXMcukuym/muQurbOK2LYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vKbfbT+xxc042rkCkkwLCOADs71N8vV7GKNBtJSj+Ho=;
 b=af4+EBKwH8VuByxEf2eLaQSqaGwuDteNr+Hcr6OHzOIBuDRfzigvYgmpeb620FLZl38LQzvEmbvXzu/9tWD41glz1Nt7pabhR3PYJN0pmZljRitz2kYAugY9j4rM2Be/NzjvrNn5exjOqp3VLU2R3EQN+GULVaLcNqICUHqupp17A8ITXVaXCdlNqknQPBGvEkDcjEN9fUd/9WmOzcWtpIgqXipVdtPIE937G7XwpAQyr/7yd9tmlZPepDAK5fokg6odtCUr3U7rSFMDVyhC4uWAEwxySGTqMIZ87dXfoL+0339/53wpa3J1YkFPPChtJ2jP+UzRe+CnYrqYEudCkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA4PR11MB9278.namprd11.prod.outlook.com (2603:10b6:208:563::12)
 by LVUPR11MB9810.namprd11.prod.outlook.com (2603:10b6:408:39d::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.14; Thu, 13 Aug
 2026 13:24:50 +0000
Received: from IA4PR11MB9278.namprd11.prod.outlook.com
 ([fe80::9bef:c20f:571f:7057]) by IA4PR11MB9278.namprd11.prod.outlook.com
 ([fe80::9bef:c20f:571f:7057%6]) with mapi id 15.21.0270.016; Thu, 13 Aug 2026
 13:24:50 +0000
From: "Loftus, Ciara" <ciara.loftus@intel.com>
To: "Mandal, Anurag" <anurag.mandal@intel.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: "Richardson, Bruce" <bruce.richardson@intel.com>, "Medvedkin, Vladimir"
 <vladimir.medvedkin@intel.com>
Subject: RE: [PATCH v2 3/7] net/iavf: drain in-flight Tx before reset
Thread-Topic: [PATCH v2 3/7] net/iavf: drain in-flight Tx before reset
Thread-Index: AQHdKxENhxkEVTTXB0qDM9/jknn/d7ab9/DA
Date: Thu, 13 Aug 2026 13:24:50 +0000
Message-ID: <IA4PR11MB92788E981EA5071B9B9461CC8EDB2@IA4PR11MB9278.namprd11.prod.outlook.com>
References: <cover.1786617159.git.anurag.mandal@intel.com>
 <23c3da01137840cdd06bba5237c1b622fb7c1191.1786617159.git.anurag.mandal@intel.com>
In-Reply-To: <23c3da01137840cdd06bba5237c1b622fb7c1191.1786617159.git.anurag.mandal@intel.com>
Accept-Language: en-IE, en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA4PR11MB9278:EE_|LVUPR11MB9810:EE_
x-ms-office365-filtering-correlation-id: c1c2c1b1-a2d2-491f-0a24-08def93e4107
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|366016|10067099003|56012099006|6133799003|18002099003|22082099003|4143699003|11063799006|38070700021;
x-microsoft-antispam-message-info: DLGzbUw1RrKDTs1MJJiHHEZPcbLWlW7u4Aq10euBzmx+f8vjnVEc6y/3VoDdwUy7XRtzn0k4ZMuiT9Qydzp0A91qVTgCl+f8NMl9AxaHY0KkD/yZH6KxhcBv3sHiufZ2gqi9ym1w1tlVoBS6wCUK3B9JrGWNdQ2hgQwjGJvnoJWpPPjpelC1X4dMh9o7/km8SggN1zz2QpQXJc3xERsLdm/K+DueIbrhbhkPyTjjDdAFsz+U9bZrG1fD7U2XdLOsbrfzvbT2tB5vw3SP3lnMYIMnfmp4FyTAx/V6ogDEYY4u5HYsLSHTAomTWLo8oSkNZKCO1olwnHGoPTTQzHYWDwCFDgqS8tXNjoGfIucRryjCgOcxpD0rP0QDMnqf/suVmqWGm2cW/K7/CdsxDilvCVvFqDRX+srL8UDYLl/aZRqX9/Z5/TvGKl5GP86OsfmMyduhtmZ3p0/NSgUPH93SJxWJlpeMbvTRylJ8kEOGRQFMCb9GMocIwEDcpFVQ0E3Rd2o6ivz60un79dctcZm/XG9lMhzFFSoj8fhFh0EPU2prVEkxcOCQtDeHVoZwoD8CSn4NIjguK3xWzIUWbX6sx0Z6txGaFdaoefOoUnfPl8VOi4XKZbvbnF9tgRjN6tVff+n7p7iKppjMsW0JAD8WofI6IXHIGSfXt0Q9shu0bU7UHa3L7vgZtyD8Va5z4Cjz8ZGS6sdGwKX6wc0p/ZarUOCqW2kQ26RyLgprWV3OZ3s=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA4PR11MB9278.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(10067099003)(56012099006)(6133799003)(18002099003)(22082099003)(4143699003)(11063799006)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?wdxAkazOwW+K4o2sn5GLOjc/glfr2FpeIcm/FDMX3umpHUT7FmZt0sI9f2p+?=
 =?us-ascii?Q?nPcZn9U2v+kEmvm5Zf19kIvFRDcIaEbfQstTLU/D1iT/DfAGvem6DAQV11h+?=
 =?us-ascii?Q?rvhezWO39VPbMRmRG8LmSgeJEW+2/zATdGHkuiD2UtBoEm4HmwaKBa7IGxB6?=
 =?us-ascii?Q?w7BrrEJDdzkHJoAK8OrM9iZFSqI2S4SgdiZUR6S5i31fyizEqEwBuxNCRk3Q?=
 =?us-ascii?Q?r8kitS3u0VH3qtnqcG6rdCfaiw65+a4A7Q0v2pqCZZi3RpELfHhQ3cGfasar?=
 =?us-ascii?Q?b8KLEI984aVOmPmO/1Kxi/kP7JKNULvoJ/mbk95o11eB3fzjFUYf1187v/qT?=
 =?us-ascii?Q?uddrqDa9mf4tMOaTYsrUwIMujJNEvqSwFEBu1prJMRCl+8m2ZD8SP4yItusy?=
 =?us-ascii?Q?uVHxwj2UhD5cqq1AX1ZVpRb6X2Kc16tF84wlwmZDPOqk7NKRleWZ6iFwZMRO?=
 =?us-ascii?Q?dPQLnqYcANNiTOCi6pgSyU52DQPcUpFfMWDVD1OBBFiR9Djm6BjWb/GkdViP?=
 =?us-ascii?Q?s61BWg7aqdKWOBazMmUA35qeZ21nyjxSoWXP6ieTAIgWEr8tFFxB7jDrejPq?=
 =?us-ascii?Q?80IwU9vP/qDnIlHVMj8RsqiF/QML4x6T9Ug6Awbiv4OjGXwO2Zqb9RcPel3Q?=
 =?us-ascii?Q?PIoXJKv3uVEO2AqmIuuDRYCc5nbDHnx8/P5Q/s5MItHlgxHAPg1vhgnVrGn1?=
 =?us-ascii?Q?wktFdq7xY5l7bsKuXEenYjoFVkuCsewV0H07u2g2JwAfVZhs1ccRjyrUZ0CT?=
 =?us-ascii?Q?HpD1C6XlHdecWiNbYhFaj4oEoK11i+yyGg2rP3vNowa8ZKxXTXPvyc76MZ7Z?=
 =?us-ascii?Q?gahmpDhN+DDTj8+jAI4/9B1jw2eryac0l2AyL9ZIMOxeHlfgwRjhu6sOnsW7?=
 =?us-ascii?Q?PqaK5kNqzsedqFNWB60mtzHTf4/GvNeuRIFAuUenkXRcR1X7CmODX4UoCM2K?=
 =?us-ascii?Q?7HU0Y3i/4NH3uzjskOgS9HFL5YwHhhtfYj3/QwXj13zGvDWWVOQ55kzzOKGB?=
 =?us-ascii?Q?gFZ4Z8l/ndIWgJke36ddFmixgxc1biGuWh+qpjnEEJxmPxUicc9DZvBobX2z?=
 =?us-ascii?Q?YwnXq2iemzpyz4yYLD3EHbICkoFTYQXusgsiUbYIEFH/joh6n8GK6PRcSMBQ?=
 =?us-ascii?Q?5EamSL1iB0vbwRdXG+BKT44PX17myA3plcyvgxPn7jnRTg9bPGfSEs9Xm48O?=
 =?us-ascii?Q?NaO9BaLPB1JdCXU0VAEcdsZLAh6oH9JwPuvXM3+2wpeHceeHLL6j3F375W6V?=
 =?us-ascii?Q?2s2Sp/wh+4W7hTXn4h2+YFdjCV11ZWFqxfJuBAwAtWu8DAoU+W5wXMwXWews?=
 =?us-ascii?Q?XF9uFlXrcQ6sNbKk4PakB3oM62ecyXPdgNN/UmOTGkkbflZx+eHZd8IjOM0l?=
 =?us-ascii?Q?Qcrj2EY7PqmTcn2ETbsxmV0VzvWCMdTH9kDP2393V9U/aZAWBJXkka7OV7eO?=
 =?us-ascii?Q?Sap95b7sRS3aYot2WO87ADWkcfMoTf9HeTsdoJmzMzuj/ZcVds4cn+2fWmsK?=
 =?us-ascii?Q?/bVy3tAV/2UfOhZ/CfAkCLCtHr+3ScxA69dAmu1jKMx8sTQOZqifI4Z9LC5T?=
 =?us-ascii?Q?EMXFW+2jo3E5ao5PMQDGojzzpdNu129WpDF8c7JYEqLvfTg7EWxF3AyWoceO?=
 =?us-ascii?Q?mplItaJZnlHCxwmarlAYo85H10s9JoJt1RZRMy28AYSUNMIRqB1ouv5IwQLu?=
 =?us-ascii?Q?jMTxv7IqWUSxinoRfoK1GnAQZ82XsbsJo9iF2dTndsYB+QWtRNXUc6BS447i?=
 =?us-ascii?Q?8OVlwSbWSw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Uvw/DcDisb3r5t8G+HMWCsIYNREsh1HSOHIKDMMUcLsXDgz9AqzRmsu1AMFYcSX9ohPHxyvh3kn17fM1NCle7c3uxxWyLhvANnrJwZCODxSsRsFQ4x5qEkLhSoPUoshoaHle1oMerlfOgwLHejXuoK71viUae79NYRgqPX/ITl7sYKOu8PFxfTviGsaYc76RgZWs9XtG+0TPdZjQJwjzm8cIlURMAdd5WZFwwvsmQbLfX/HZMT7aYJg+51MAvexTix4/32KbyfqWvfnnjzdUQwfyF4B03d2a5N5ebXzSd01oi3LtaMoFRliN9phlCzBnTbi49bH/Jh6gTMAL5d7ujA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA4PR11MB9278.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1c2c1b1-a2d2-491f-0a24-08def93e4107
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2026 13:24:50.7241 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lMlgJzfEdeLjLZx/+c/kzz+Gr++xSEbpCFvSovo7Bx4KJuh4A9NR715HadIP8OZge9wCtnyrfvmua3hLUIKzNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LVUPR11MB9810
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

> Subject: [PATCH v2 3/7] net/iavf: drain in-flight Tx before reset
>=20
> On a link-down or impending PF reset, in-flight Tx descriptors
> were left pending when the queues were torn down, which could
> trigger Malicious Driver Detection (MDD) events and
> leak descriptors.
>=20
> Added iavf_dev_tx_drain() to let already-posted Tx bursts
> complete and flush the rings within a bounded budget,
> and call it on link-down and reset-impending events
> before teardown, preventing MDD events and descriptor leaks.
> The drain selects the cleanup routine that matches the
> active Tx path.
>=20
> Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>

Acked-by: Ciara Loftus<ciara.loftus@intel.com>



