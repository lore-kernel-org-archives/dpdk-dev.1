Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57EE6C624A4
	for <dpdk-dev@archiver.kernel.org>; Thu,  3 Sep 2026 14:07:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8EE9B4279D;
	Thu,  3 Sep 2026 16:07:12 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id A9AFD402D8
 for <dev@dpdk.org>; Thu,  3 Sep 2026 16:07:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788444432; x=1819980432;
 h=from:to:subject:date:message-id:references:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=IlDsfwyEzRY/+kwCZ3M5Vg8dixH9hlt6Qwr1DVkcxoc=;
 b=RoapeyEEpBncnPm+bXoXJ+9uSUNL+K5VXyaHpvdAUVpKwV5Zv20lTkCl
 Ilu6eopIJDLHGYLD5tzc4vPMw+LvEEMystocqEeGYTz02Ll9SKZXuAOEC
 cqOEaTeHlVzxQ22tTb/QbBvnFiez4ueL33ZIaWgHtwhmHNfRF/KxFiViJ
 b0SQT6dPfXjBd5i/BHS4mf2v5nnWdHOEz+5hEZVAOsiq8Y1CbjgE+HhGW
 GFFwkO7kqxOx5BJHCEv+R8K+x9G5VOYBCGNG4u31qrfKbom0gtXWy9gzQ
 96ULyQ+jgbnCdYABOLVo7sktFyPGvt56gYNGvV4LLfi9xFucDB2JWtwGi A==;
X-CSE-ConnectionGUID: ZK33NfF6Qnu8TtslN7BSrQ==
X-CSE-MsgGUID: u+vtbYDaT7eLYYUEujQdWg==
X-IronPort-AV: E=McAfee;i="6800,10657,11895"; a="88805097"
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; d="scan'208";a="88805097"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Sep 2026 07:07:11 -0700
X-CSE-ConnectionGUID: /LxdfVLwTNyorS0rdjXjWw==
X-CSE-MsgGUID: 3/yFqk8pTyyDdhOlM0kKNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; d="scan'208";a="266504099"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Sep 2026 07:07:11 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 3 Sep 2026 07:07:10 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Thu, 3 Sep 2026 07:07:10 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.54)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 3 Sep 2026 07:07:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KyferC3Nk+kObDcMCStdm4Erhi5DJyOHa7b9jm4Sw+p2LFtulODSY054qwNoivAO1ePNg48YrUgYxAFyWupryV39SPLLQ1MjytO7iU7emH+HVB63bVpeFrbI1DuHjpl+MwZAREfu7bRPoothPG0qgYAbEuVjiGMZSVO3xm11D+brWSqLIgp7tJ9fDWoX6146JqKbv4NmRTClK7i9e295d53h/R4RU2hXOLWgQzz3ngGZnD4/bOvtLclqf4uRoRxI83UtTT6IXkg6TvYDZrYSDuAn55S3ooaMV2oVdMzWm3PV21ySvWq2raPlvhjoZVw0Wzrx0Zd7W9Hj7PJI/9MjQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0bmD6OKODZY+/ze0dGKzeQANPLN4/e3metfuHaoec6w=;
 b=tiPiEAzQ+9dqfIaVLQ8/+aGN9oV6eDXL7wtu/VIgSjApjHk+C54qq+4Z+/270M9xXvE5Mwzk36GerMEV4WyicTeYTo3FqseLQZuRE/R961R7VpFJK5tc2b54gH1Bzdc93zRwe+1r3dt/c6JQCS/H58Iq1SlWc4w9iW504lIZEhYapsySzXwavXdTGtmB4abgbCTyfBAsJZuqpSSxDdLBQSkwWhC4R95KDEwRMstpsduTgFgSFcq8uTu3rzFdTIYa249yZXQ6nUlq0OJZShBaANrh3bGZ761NRIQgVhgrIW5aVcsiUcvG3ZMdiRSpSgzEP6JLM4ax5wYRZCLcLw/Lzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA4PR11MB9278.namprd11.prod.outlook.com (2603:10b6:208:563::12)
 by CY8PR11MB6892.namprd11.prod.outlook.com (2603:10b6:930:5b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 14:07:02 +0000
Received: from IA4PR11MB9278.namprd11.prod.outlook.com
 ([fe80::9bef:c20f:571f:7057]) by IA4PR11MB9278.namprd11.prod.outlook.com
 ([fe80::9bef:c20f:571f:7057%6]) with mapi id 15.21.0360.008; Thu, 3 Sep 2026
 14:07:02 +0000
From: "Loftus, Ciara" <ciara.loftus@intel.com>
To: "Richardson, Bruce" <bruce.richardson@intel.com>, "dev@dpdk.org"
 <dev@dpdk.org>
Subject: RE: [PATCH 6/7] net/iavf: fix missing outer QinQ tag for tunnelled
 packets
Thread-Topic: [PATCH 6/7] net/iavf: fix missing outer QinQ tag for tunnelled
 packets
Thread-Index: AQHdOTNQ5MVodLxPWkibK2wk227QbLa85r6g
Date: Thu, 3 Sep 2026 14:07:02 +0000
Message-ID: <IA4PR11MB92783134D7AA19E674754B6F8EB62@IA4PR11MB9278.namprd11.prod.outlook.com>
References: <20260831102621.495759-1-bruce.richardson@intel.com>
 <20260831102621.495759-7-bruce.richardson@intel.com>
In-Reply-To: <20260831102621.495759-7-bruce.richardson@intel.com>
Accept-Language: en-IE, en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA4PR11MB9278:EE_|CY8PR11MB6892:EE_
x-ms-office365-filtering-correlation-id: 38464bd3-6dff-43ff-c33b-08df09c4a0a6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|10067099003|22082099003|18002099003|11063799006|56012099006|4143699003|38070700021;
x-microsoft-antispam-message-info: CETmJg8M8pElP7PdEzGQeRroyhZjNAAnGB1NYDGHatHf0AmJdkjIAmaOKkJR7x4DLSie0QdqHp3iRdpG+gpRBfg8o7vQXMUrSxiOl4ITZd2EOFlws67SONUFsK4oGhuMWGs+sXxfjERpt9ioGsoeDhUeH/OrEWgiNXftviE0mUnN+IJ2BgaMyOPwyWDkiVNFSxirKC27c9W8vslDhWA8FsgW0Y6FroqOXmIM+afl5DuPDHgWUB6csDi3YRVBjY14dkUQWvi+tMxfS8yA933zajGvX0OPPfm8sU6Ij2jTdTivip5kfdrX/ayjBcS5DuG2+rcmd64JtkPzxYR5Jq1Dm7/RBAOPzWx7eGk6G3ANKCL5txvAqChhEoUKBaENo80GDu3tc8IUlxuJI2lID1Oguy0Rr2aBi4dOz8bAzXc/ATzHo6DJnsiElO4lOtKPm4z0MtLu6Li0tPPeitLQFrGYC1XR/RpTEeyHxhnaOU8I27gCora6BNybTI3eWU8oQmKSeKJ9g3cYMS5Tka6SIVyypUhBvxmSOH6jhyN17zRXZpqGwIBAVYtqP9PXYb9DXoQE1Hlf3UjfdKsvkyA5Fg18ShIPw+VmS2940KdLxYNeOVzBlk6lAys82Yeb644Kyt1kKn/E8vEJ9LkoJXXD2GzvzFVADej3j9g+C/RieF+ycGu8HB7e3vqXJyAjFLzqdVWkxbB0pnP9z9Uzv7e/VqFPymlQiS4LSxDdl/NZ2YK3nlA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA4PR11MB9278.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(10067099003)(22082099003)(18002099003)(11063799006)(56012099006)(4143699003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?wptQH9F7P6kzQAxdeaLBV081sUgXVpOGyTSOHYGsHGRaV+6RbubtsdDLEqHs?=
 =?us-ascii?Q?fOFvt4Qbmf7uSkYjMuMFdDmDqjzcds7rwWliX4DmCsyPJyjMqfsB0wT81wZd?=
 =?us-ascii?Q?Z3B7g++KpCgshgNbvr5KuXzlI4DlivTD8xytHj32twTm+w8i3Mj3f2SsffAk?=
 =?us-ascii?Q?9G6v2VFXgEEwNQBqQ5rCyZHlpzMu78lreoanli1MKWDDzemCChSd+npV6Sy8?=
 =?us-ascii?Q?5JUJNl5+p56yC+5xmGHpxOQuYPKhP4wSEuvCxnpGt7HMpHzZq7lVDToGIrPb?=
 =?us-ascii?Q?3Hj37zo+x2ih1T6sXd0KjmiaVsBPC4M3QjhBe1+JsWXgM743UseJw8mfaoqd?=
 =?us-ascii?Q?frSO+rPLJOL0VvIWong2kv8FQ7tvxZFl/HADVG4MeBTgUG4osm8Eo3HeMGMc?=
 =?us-ascii?Q?lJd1mwSgiRD+m8GeWfP5fb2euAnrQ8g0b+NakP0T17ZDA4wRWPzHy/g+8tZc?=
 =?us-ascii?Q?zUvBnkRU9xLHx381N3oCE0DDeCVba8hi8RuB/3gNkWFvnUHzTNTlm3nOPsOG?=
 =?us-ascii?Q?03TFNKy816p5NHABLk4JsgbI7v52anWGLOyJxnHYyP3GO26KCrhdz4X62hSd?=
 =?us-ascii?Q?HuAquFpyjku7K13Y9OvZMDxdYtK6m41804meHGbNFsx2hjjEQz4/GTI5Le3W?=
 =?us-ascii?Q?eDwdIb/rTllvXrYZABX/6snobC226jWjYXru46R/jqvts3KOnoF6rXoKBsVG?=
 =?us-ascii?Q?MVlNMmbZuTyBofSDrFxQmBsrRc+33QR+RgKMdz7CFEfAAXlhyj5pQ9HaRPbq?=
 =?us-ascii?Q?OeUryhMQ0b7zjDyDEpN9f2ICjCqPYb9eHTk18TFIFNtNKqW6H+i6pciBzzxx?=
 =?us-ascii?Q?iiWIWutA4wxkjQUjZYsveQsgzX7bw6gqxzYNSZOFnvqnBt8AaHBGk20muJy7?=
 =?us-ascii?Q?d4fqmlUvuLO8NGEWgM4KyThfBEMnsUMEIreXxCpYHAknekNVmFxv/YKwX/3Q?=
 =?us-ascii?Q?4nrJDWMmbMQUOWC+eq4Sr9IJtJ3uyYWZqwFMMiLTRjPRAeo7mSiwv5WyTRzA?=
 =?us-ascii?Q?MikzH/X/vdRazQMpe7PG/oMAprYm9a/pZeIL+gqov3CKb+ydaGlCaVw3IpFe?=
 =?us-ascii?Q?2LcGHK0LMXXR7Pu1f+cpohk2UIsFb0W5PZArgd8w89GcdMY2/cv4CbiHEYBG?=
 =?us-ascii?Q?egqe/hEG7AQMlv+m1UH0iT3O53mWwbuT6C1T5GOdzJr15ufxlQSAyF+eZIiA?=
 =?us-ascii?Q?Y5az4dSHtVPhbAl0E8UXmmN0YQ6Bo91Hanyta3YOiLLO9EWTwFZGZCdGsnXG?=
 =?us-ascii?Q?Yb4xZaV678mQOUUkFhx6yBPgJxrvKoOBbZBPbLgGYXQc6KEKgGLt1aOuBU2x?=
 =?us-ascii?Q?CZfuZ1oRQpejnweEu5UcQI1QZi0YIUdCKabBzOjuL4v9uMSysqqpsoFyTaCC?=
 =?us-ascii?Q?KhQFjZ14F9DKCevpJSz8glscXNnDPcF6Ppc6/5Sw95bEvJJyKlUTQ1nVsYka?=
 =?us-ascii?Q?PV1T5YRPHFHKCnmjzXtk/xLTTTV36jwfAXJquLMfuPUy+YkeLhjbZpb6W2e7?=
 =?us-ascii?Q?86xBwHHadOX3xMiAczNFlRpZvNm/7C1FiV/3PFong9JB3cs6U2OFdu1OkwIi?=
 =?us-ascii?Q?xTUwSVEx7fJMat4i11Qu5+2Mxhc0uqyaaMCZm3jIemmxD4PgjJwFYvTf95jX?=
 =?us-ascii?Q?8qOShvisWnhDCB+B5n0/S8zvKi+2HoX3osK82V3vnIAjNi5qBUJDCb9m62sL?=
 =?us-ascii?Q?+kGQ/+VCY/Q1XN4Paxo7MqPu5wVcotD3Coq0w6ha4v8WuR29?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 5ICBav/H4RGC1UdIn41FqIxU01qclT4bB9JpZFaSbziMbeEofkywpziVqsr12iCDd/QXytxKfDg+TGUJyBz9L267TqywEB6NbxzXhyny8srUP6AumzrZO+JqA8nM3UTgw+sjc8Be95bYrzucpNHWEk6vTdIMLu+9U889SSb+33iskYoyxsVlQUom0XbncBnU97NPNVldDAI7RC+60LBCXdv99REmmnFotC6Vdq/IjhxjMGdCJ6jW7tabHJ8c5GdT1NvDT70V8YEBJaP3a8XJcZ5yfawTYgdjWOduiIJ+ThSeUMJBGzR/XV8VMtqccf/MZdb7kGLdNPey77+9eRttKQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA4PR11MB9278.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38464bd3-6dff-43ff-c33b-08df09c4a0a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2026 14:07:02.3330 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5o+VWZNFFIczTDMMabuaAIX44741aLKJCvRFTFDxWl7+b6mOEHCCQS6RKSGXuMNndRbeM8WqG9cRT6OwIHNBoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6892
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

> Subject: [PATCH 6/7] net/iavf: fix missing outer QinQ tag for tunnelled p=
ackets
>=20
> When the QinQ feature was enabled along with tunnelling support, the
> tunnel options were written directly to the context descriptor quad-word
> rather than being merged in. This leads to any QinQ tag in the context
> descriptor getting overwritten.
>=20
> Change order of operations so that the tunnel options go first and the
> QinQ tags are merged into that.
>=20
> Fixes: 4f8259df563a ("net/iavf: enable Tx outer checksum offload on
> AVX512")
> Fixes: 70baceadabf2 ("net/iavf: fix AVX512 Tx")
> Cc: stable@dpdk.org
>=20
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>

Acked-by: Ciara Loftus <ciara.loftus@intel.com>

> ---
>  drivers/net/intel/iavf/iavf_rxtx_vec_avx2.c   | 6 ++++--
>  drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c | 6 ++++--
>  2 files changed, 8 insertions(+), 4 deletions(-)
>=20

