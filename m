Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8551CA5FFC
	for <dpdk-dev@archiver.kernel.org>; Tue,  6 Oct 2026 11:42:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A295B402B0;
	Tue,  6 Oct 2026 13:42:19 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id 42F38402A2;
 Tue,  6 Oct 2026 13:42:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791286937; x=1822822937;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:mime-version;
 bh=wLEdJVwNDm1Qv7pnHObdE8NLO+udKt2Ja11RWqj34po=;
 b=DUWShS7RO9d1+V3QRymtQMbi4tqMnR5DKDRfnv3hXdfUikBxpy6cQ4sL
 TN/T82j+QZWvNWZpjqA8jbvc3VW58Eggmimw5oH6ryKQ3q58G7Do4OXZH
 Eg9yGkUOWxKOx7BKLDC/2HduwqMwXc6RElLpPFnB/Gvf0aEdA3eAXc2Mu
 MZQv9eP2rDCAE4XXxn9n0D5fomIcWskY86DSoAQYwLWaWZBOacKiz32k8
 bDWkc22oj3U7zkYtVSOdA5y8tWrkKL38Gx65OBCPxZINpC/KKJSoPxl1L
 e/UtK6OV6yC4yL0g8HyO0/K4rZko+tJKnfHJXpLOMyxqMTI5dXCp6afQz Q==;
X-CSE-ConnectionGUID: Cn+lAjoEQ6GuTVqbJgdW/w==
X-CSE-MsgGUID: GH7eaihbQS62ZoqapQ0OEw==
X-IronPort-AV: E=McAfee;i="6800,10657,11926"; a="108346945"
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; 
 d="scan'208,217";a="108346945"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Oct 2026 04:42:16 -0700
X-CSE-ConnectionGUID: 7cXF/7EQSq+V54t/MXxAhg==
X-CSE-MsgGUID: vY4TTMeATmykTTjma7d9/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; 
 d="scan'208,217";a="285231955"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Oct 2026 04:42:15 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 6 Oct 2026 04:42:15 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Tue, 6 Oct 2026 04:42:15 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.8) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 6 Oct 2026 04:42:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dLSHb02AMTwAc4kAHRgnDPe0T4BpiHvo3Oa0tfO0WYPbWBovVZN9dC/7F4ry/x5e4/SvVnAJVfNPS6m5aJwd74NjrAGxmrqxQ+6K7q9efoMM86uez8b5jeo/e6OhTrwk30E3n93Jxu13nZ3osRhyGgD6V9AzYy36QEx5USJIlI9Cps6AtW/knKc2esQyp2mUCXNycAtnFY7O+Kj4MQDTg2HdlBd1m28CS9a0shZSOA6zgys47bqd6bZHpbHzLcTKrpxXU5kCzFNOSYLhAjDo9yWC86+FaxbgZj1V9ZZ9zf5UvDQ1Ut8U3qkGSKd9R3JIAzpWiGZjH19j5bmfeVWv7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4l7DJyhD5mqWDYQ07qq712z6PHZuRklJttRCrmEGENA=;
 b=V25E1MnODJpmqS+7S2PsLMR+DjNELUOi0sN6QM5a0eeFmJUhukKN0NZDqAAgoXNtMzaZaq2HUrA6jmJ0Uni5yPWSzDaZ+5kptWqLP14ji82fkY2BXTVcwUVL9i4/NUJ7GhT9bESnTKE/m9lWNM/6lB5I3l+t0wEm522M1CL3n4zDgYSIJWY9iGzw52PkwJ2m7zld8BTxpKGQlx6G90NaLL++E5EO712Hn9kkU/i4QPRQVsy3IlR8ldZQwA3VZWmT8OZnpZUlcTvu2Hh7xCc02hxCvLekXJwJh0gT4qXXiIT9StpiQ0LfFjMUI0GDhwnxJw8U5YC3qUnhTL6XfGPPbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV2PR11MB6045.namprd11.prod.outlook.com (2603:10b6:408:17b::20)
 by BN9PR11MB5290.namprd11.prod.outlook.com (2603:10b6:408:137::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Tue, 6 Oct
 2026 11:42:12 +0000
Received: from LV2PR11MB6045.namprd11.prod.outlook.com
 ([fe80::1f72:3d49:b6ba:91ae]) by LV2PR11MB6045.namprd11.prod.outlook.com
 ([fe80::1f72:3d49:b6ba:91ae%6]) with mapi id 15.21.0472.015; Tue, 6 Oct 2026
 11:42:12 +0000
From: "Ji, Kai" <kai.ji@intel.com>
To: "Nicolau, Radu" <radu.nicolau@intel.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: "Alexander.Konyukhov@kaspersky.com" <Alexander.Konyukhov@kaspersky.com>,
 "stable@dpdk.org" <stable@dpdk.org>, "De Lara Guarch, Pablo"
 <pablo.de.lara.guarch@intel.com>, Fan Zhang <fanzhang.oss@gmail.com>,
 "Doherty, Declan" <declan.doherty@intel.com>
Subject: Re: [PATCH] crypto: ipsec_mb fix OOP SGL for NULL cipher
Thread-Topic: [PATCH] crypto: ipsec_mb fix OOP SGL for NULL cipher
Thread-Index: AQHdVYDzcI5lH+8hg0uG+cVpb7MpJrbwZE+j
Date: Tue, 6 Oct 2026 11:42:11 +0000
Message-ID: <LV2PR11MB60454B9D75343634C26D473C81952@LV2PR11MB6045.namprd11.prod.outlook.com>
References: <20261006105329.1630257-1-radu.nicolau@intel.com>
In-Reply-To: <20261006105329.1630257-1-radu.nicolau@intel.com>
Accept-Language: en-GB, en-US, en-IE
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR11MB6045:EE_|BN9PR11MB5290:EE_
x-ms-office365-filtering-correlation-id: aa5b2561-2c2f-4867-3320-08df239edc6a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|42112799006|366016|376014|23010399003|38070700021|11063799006|8096899003|10067099003|56012099006|18002099003|22082099003;
x-microsoft-antispam-message-info: 3E6PnXiuyW36VGC5GpegR947Pz2jUN+x4nDuEwJGUUYNxTltr0MzmFsqneZ5Mw6RatfCuGzRkntLTPVTtf8UKTEbkcmDun6PgtwPL5ewWw7ZZx+WI+fe4cF5l7tCB6cVrcrb6OXfn7R8+k6jiJFHo4ygWgJt5OlKgfX21abCfFhCETKMHCWAJx6ISQIu46GcwtTcuC4r/CVCOHMvEHZmLxngr+l9xrlE7Yx1JKIS1O8DDQFZ/SZjwNuL++svSk4ScO4VLNZQ+ALbcnB2U5hbdfSE1kKwgfwzUhllJHIOTFrvv8/Lg/dWcDaFgwgbwczrFNkkMBG+oolPV8VUQ1kYuD6tr/DpZ1VNZMhMXd4MAsU+FnQ0dJJupiBIqNY9gt6ghw7qL8Aey95Y+mesEbga0meZr8LdAvB/l9lfNapUkWZvzOJE+HAX+2S68u/GQDth+2L6qUwu0T1hdAYDsrvyTfYx7SDkIQ72tMHkzQ54ISN/J2J7N/nSJLzypupyrkD8of5UQiAZM9FJpqrZs4rG/JYQMMmGY/zhJegtmWKpGzWt0RgRnE7ip3WG8cK5wT2GvhZKbQz4VPj+Js+6XFCmYIUfUPe86iHRHLVTyVErRyN/fu+Ke08s9nOZcfaI8+IvHXPmI8+3NypLBUGR127S0TdLoM8yzchjWUiclu+luaUBuZc8Q0wdEQPPP+evHACewoQFnVtP7WF2DOXQiXxhzuWmq6E2dzUPUspbPpuyegk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV2PR11MB6045.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(42112799006)(366016)(376014)(23010399003)(38070700021)(11063799006)(8096899003)(10067099003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?BN1yqnBIWAFV/p8o860ZDZQhZepjn1qkJyePd1vnHiOiCth7Bb/KiqI2SW23?=
 =?us-ascii?Q?OvvAIUrmG4DHTqrgr41cQWvDTGHXhAcMJu4pfPIXI9lYmv6psLJJr560Vmfr?=
 =?us-ascii?Q?Q9bHf7E8jb3fghqmw2VCAvbIcxKv/FZfhSZltff6iqLPTJPHtkEQ6dg0SIpD?=
 =?us-ascii?Q?hGzlblnTZ6G6AdbdJB6KQTQAWNlYa7zbePVd77vmRhvbEzuT6qlGWDU3Ra7t?=
 =?us-ascii?Q?cgRHVf96/tuV+ZldIgVwETDiwBl4R7L0CBzJvyTK3XEFEHuZ2I5w4Vj8O2sF?=
 =?us-ascii?Q?4sQVCVcInKlHpOFTY7JwGo7kFcUnOl3di5APYdHDS1Uml2hJAi+1WTgXhhDN?=
 =?us-ascii?Q?FEAzpIZf+o0guJwzc+48GQ52GeHLkyPZgu01yESRXYcl1coYScnqkaFHykww?=
 =?us-ascii?Q?imRiZ9ilvoKevTyWJn5ImLaoX48V89XW8Atl8Zs7TVegdHlcI85sLKBHiACP?=
 =?us-ascii?Q?c5U8H/EOCii39A3nNZ+Hvt88//y0r00jlUKZRU4pGclScW5W7LhXE+tQ26Wj?=
 =?us-ascii?Q?gBDxYn3fFzIflS5KEPE73X4n6I+NrN3orNxrOJtUviZwWPjmVxi5uG8EKbhd?=
 =?us-ascii?Q?N6IhEOzE9LNBEaskATIgnX6Ne6bTJQ4XdRmRYaazqlcyRw6AOsJFmBtHkTOa?=
 =?us-ascii?Q?qMOppU7dwAhvHQ5us81A2uJ+KILrG1+j0H5cqbx+wYyg3CTAoNflr6eup/kx?=
 =?us-ascii?Q?1NZkuoce4goi9JP54GVKZE2kSh+SpItgFT9+RvRO/0N10+1QPxfk5yGi1dNY?=
 =?us-ascii?Q?Gp6qO4degwW0ivAip3WKsA4HMsteXgfRnMj7C1kXbzz8u+aoo0ScmClK0Gh2?=
 =?us-ascii?Q?KPKM9EDWPr+CAjHcnHzojsXPgnFSfoVpAQ0fTFkXILk8aZrU9oHv8iWlyejI?=
 =?us-ascii?Q?DDJdBQXSfdVuDAwvDjvLaFh1FtrfSrRZ3953VcLXGnzYE9kV4ZSdpt2BhRRV?=
 =?us-ascii?Q?ne/sZ0Ju1nCyBbX8eZX9B4ywDG7TWVJ95g5OEV6WYHK0ncT9hnCSK4s1g6hx?=
 =?us-ascii?Q?6Q9xbCjDROJ7GOxLXFIDhj7Fnf692iksVK2J5EthiPd6oejBoMCahHXMgpZm?=
 =?us-ascii?Q?Ji8K63QG1FUCZkzaaYkGTLbC8wa4RN1aqU8PtIyEoG2/9VzxfgfOFv6wB+MC?=
 =?us-ascii?Q?3ooReqNXBQQnNvT3mFmvOuc7MVgHw9odyGLPR1vJN53jccPqFN0yh8sg9KPC?=
 =?us-ascii?Q?arjuhOkqGujnZBEA3YM+u8IM1bEU3/u9Ho3u0KQ8/fHzM7MYjVNQbPF+xk6p?=
 =?us-ascii?Q?kCZVk/74c1YDZM/szojHBQWbR4gX4QJA1Uu64a9GCrSzkvGG0XV7EbnjFvt2?=
 =?us-ascii?Q?+c8CHXFpVAam/LjMEjDyEPWk0PMbheX7z/EqlTNi6gTrQkr+QeUgvtIzm+xv?=
 =?us-ascii?Q?QoaBX663BdSGhkUcgeeWRcLbqRREfRyRIRuOb5PZDUsg4PuXGD1p8KLcZyoI?=
 =?us-ascii?Q?zuF4OGIbkKV+c7EG4Hd5LesBUuGV4Mb4gJqxGbupxoXV3HS/C8Ml4hmGLOqR?=
 =?us-ascii?Q?wfD8d2gYiVOamyLEq9BoXoEmG4joDFvmfTeTEnbRld/94Mf9hm0UolIO00mr?=
 =?us-ascii?Q?qcMarjH3+mJGclwcOeLOfMfTK0zEEgEfdbT4D1eXPe2dCy42hJkuPAECiQDF?=
 =?us-ascii?Q?rTFocRO4YYmwtCw7KnoK53hX3G/AVg4HuhjLhbXq0Cqganirw6Cc5OrjRsWw?=
 =?us-ascii?Q?Mog2gfQ1TBdUtQzM/0q9+e8vBW9YWT5OecY6s+NZ0ZuoHmLT?=
Content-Type: multipart/alternative;
 boundary="_000_LV2PR11MB60454B9D75343634C26D473C81952LV2PR11MB6045namp_"
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: zulmAg7zo0fTUT5bLdrDO/BPTj9DB+q+QxDBkp/M0bClVxhzgesRbKOLdkI8QhCuJXZo33shgoqnMgOU5MCcBQf19ObWaPqtHWoiLdfgjcyW5GVcmCi6cuhNRzXisVJFCVuBmPHaoqDfnfoUxxmkTumPePIZKtWKRFYmXsSPi7wg6xWuVWuMRhLZN7EUE8WMEHRGKAs+Y2SyGz00Bpqp23phX/juHzuRGQN5CJAggV2FvLjGzfR1uv/W6TXfA/68e/sG6lDiEXqbNoXDSph5klSH16aA7DGdAcllM3agSk49mXJ09VYJy3dffLunXvxYL8NpuiDYN381dYLk+uuUZQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR11MB6045.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa5b2561-2c2f-4867-3320-08df239edc6a
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2026 11:42:11.9146 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qU4eyIN2PW4I3jVDGJbg8g5hlgtcfYj6JtAlgDos3YwT73BsLLsRlp11Bm+iKlTgv3ldXvP8EHoBsLgzEG6TwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5290
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

--_000_LV2PR11MB60454B9D75343634C26D473C81952LV2PR11MB6045namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Acked-by: Kai Ji <kai.ji@intel.com>

________________________________
From: Nicolau, Radu <radu.nicolau@intel.com>
Sent: 06 October 2026 11:53
To: dev@dpdk.org <dev@dpdk.org>
Cc: Alexander.Konyukhov@kaspersky.com <Alexander.Konyukhov@kaspersky.com>; =
Nicolau, Radu <radu.nicolau@intel.com>; stable@dpdk.org <stable@dpdk.org>; =
Ji, Kai <kai.ji@intel.com>; De Lara Guarch, Pablo <pablo.de.lara.guarch@int=
el.com>; Fan Zhang <fanzhang.oss@gmail.com>; Doherty, Declan <declan.dohert=
y@intel.com>
Subject: [PATCH] crypto: ipsec_mb fix OOP SGL for NULL cipher

For the NULL cipher OOP SGL case should be handled
by the linear buffer SGL path

Fixes: 03944ff5e3df ("crypto/ipsec_mb: support null auth/cipher for aesni_m=
b")
Cc: stable@dpdk.org

Signed-off-by: Radu Nicolau <radu.nicolau@intel.com>
---
 drivers/crypto/ipsec_mb/pmd_aesni_mb.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/crypto/ipsec_mb/pmd_aesni_mb.c b/drivers/crypto/ipsec_=
mb/pmd_aesni_mb.c
index ab65316978..90989c9a69 100644
--- a/drivers/crypto/ipsec_mb/pmd_aesni_mb.c
+++ b/drivers/crypto/ipsec_mb/pmd_aesni_mb.c
@@ -2142,7 +2142,8 @@ set_mb_job_params(IMB_JOB *job, struct ipsec_mb_qp *q=
p,
                 job->msg_len_to_cipher_in_bytes =3D op->sym->cipher.data.l=
ength;
         }

-       if (cipher_mode =3D=3D IMB_CIPHER_NULL && oop) {
+       /* NULL cipher OOP SGL case handled by the linear buffer SGL code *=
/
+       if (cipher_mode =3D=3D IMB_CIPHER_NULL && oop && !sgl) {
                 memcpy(job->dst + job->cipher_start_src_offset_in_bytes,
                         job->src + job->cipher_start_src_offset_in_bytes,
                         job->msg_len_to_cipher_in_bytes);
--
2.52.0


--_000_LV2PR11MB60454B9D75343634C26D473C81952LV2PR11MB6045namp_
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
<div class=3D"elementToProof" style=3D"font-family: &quot;IntelOne Text&quo=
t;; font-size: 10pt; color: rgb(0, 0, 0);">
Acked-by: Kai Ji &lt;kai.ji@intel.com&gt;</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;IntelOne Text&quo=
t;; font-size: 10pt; color: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Nicolau, Radu &lt;rad=
u.nicolau@intel.com&gt;<br>
<b>Sent:</b> 06 October 2026 11:53<br>
<b>To:</b> dev@dpdk.org &lt;dev@dpdk.org&gt;<br>
<b>Cc:</b> Alexander.Konyukhov@kaspersky.com &lt;Alexander.Konyukhov@kasper=
sky.com&gt;; Nicolau, Radu &lt;radu.nicolau@intel.com&gt;; stable@dpdk.org =
&lt;stable@dpdk.org&gt;; Ji, Kai &lt;kai.ji@intel.com&gt;; De Lara Guarch, =
Pablo &lt;pablo.de.lara.guarch@intel.com&gt;; Fan Zhang &lt;fanzhang.oss@gm=
ail.com&gt;;
 Doherty, Declan &lt;declan.doherty@intel.com&gt;<br>
<b>Subject:</b> [PATCH] crypto: ipsec_mb fix OOP SGL for NULL cipher</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">For the NULL cipher OOP SGL case should be handled=
<br>
by the linear buffer SGL path<br>
<br>
Fixes: 03944ff5e3df (&quot;crypto/ipsec_mb: support null auth/cipher for ae=
sni_mb&quot;)<br>
Cc: stable@dpdk.org<br>
<br>
Signed-off-by: Radu Nicolau &lt;radu.nicolau@intel.com&gt;<br>
---<br>
&nbsp;drivers/crypto/ipsec_mb/pmd_aesni_mb.c | 3 ++-<br>
&nbsp;1 file changed, 2 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/crypto/ipsec_mb/pmd_aesni_mb.c b/drivers/crypto/ipsec_=
mb/pmd_aesni_mb.c<br>
index ab65316978..90989c9a69 100644<br>
--- a/drivers/crypto/ipsec_mb/pmd_aesni_mb.c<br>
+++ b/drivers/crypto/ipsec_mb/pmd_aesni_mb.c<br>
@@ -2142,7 +2142,8 @@ set_mb_job_params(IMB_JOB *job, struct ipsec_mb_qp *q=
p,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; job-&gt;msg_len_to_cipher_in_bytes =3D op-&gt;sym-&gt=
;cipher.data.length;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (cipher_mode =3D=3D IMB_CIPHER_NUL=
L &amp;&amp; oop) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* NULL cipher OOP SGL case handled b=
y the linear buffer SGL code */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (cipher_mode =3D=3D IMB_CIPHER_NUL=
L &amp;&amp; oop &amp;&amp; !sgl) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; memcpy(job-&gt;dst + job-&gt;cipher_start_src_offset_=
in_bytes,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; job-&=
gt;src + job-&gt;cipher_start_src_offset_in_bytes,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; job-&=
gt;msg_len_to_cipher_in_bytes);<br>
-- <br>
2.52.0<br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_LV2PR11MB60454B9D75343634C26D473C81952LV2PR11MB6045namp_--
