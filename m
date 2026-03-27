Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E299E10ED66D
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Mar 2026 12:33:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4494242E02;
	Fri, 27 Mar 2026 13:33:35 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id F1F61402C5
 for <dev@dpdk.org>; Fri, 27 Mar 2026 13:33:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774614813; x=1806150813;
 h=from:to:subject:date:message-id:references:in-reply-to:
 mime-version; bh=U9qZCNItYOGqeB6nvsCR9lxEthHX5C/hcd+YYnDs6Rs=;
 b=ewSJwuXRQJo7amZWTcmoFVBsKlcCr0zErp9ee+Lpk9/IsNeisJbjIvxF
 BwiTDMIRN9TNyj6Tby8zQJe83SS/ez0ij0DSq4fiLyED6a38OJKI5Srk1
 9nfNTs3ygvexhOUJS97AeHcEHzjqH3ByVG0Pu/hi7AkHdUTr84fQVfrkw
 ArA3PhifBn1vztI7PupjzRpeblZH0IP6YwHF6+7/qkWkr8P91GUn+TIff
 b3MX/Y7jBetNjNtsPFODdtglxXFFWOuOjI//GBz2Vk0/D6no6WZapoW1E
 1E06b58zZVPzFHSFcDZGKk5ldLM2VqB5HDxAl6RaP7TZ6PdcHQrVH8yfa w==;
X-CSE-ConnectionGUID: 1pouPfVYTSGwkyTFGSNwPw==
X-CSE-MsgGUID: laMuEooMTrq5rZ5iVOIPDw==
X-IronPort-AV: E=McAfee;i="6800,10657,11741"; a="75589383"
X-IronPort-AV: E=Sophos;i="6.23,144,1770624000"; d="scan'208,217";a="75589383"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Mar 2026 05:33:31 -0700
X-CSE-ConnectionGUID: BMHarSgdQnSiII7cjCIswA==
X-CSE-MsgGUID: HOXvS+J3R2GKBzHAAf9hHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,144,1770624000"; 
 d="scan'208,217";a="229777780"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Mar 2026 05:33:31 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 27 Mar 2026 05:33:30 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 27 Mar 2026 05:33:30 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.36) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 27 Mar 2026 05:33:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e5n/TesC5d7DLRyydWyA6vBm6aNaR7OYsekiuvlqKqQEYatRnDtxL7B+QQHkld37AvqFlCReDWJxqCoCLGqKDHlTUpBegSKgL0jLkQTrkIEFVzUuBe5N0JWNGXAg6HWMbC1ugbblj1ebDPO5EZN/aH99rcppXxc7vSIzAyidW6lzPZyziCPovZquMWqbmRwsfqfZI+lJ7eIAOLyAJRrCTYK9fB3FCwucW5jsHRqxc1A8Y3BtcAKH+FNk5+wC/2T7EfAdL3XxTizUHw1TXs7BqHdOss+dmbTnc7pNFCwajRTls2OU1JcQ9BgmmQMD5N3HsKQ8Th8TR34OUdzlGed52Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U9qZCNItYOGqeB6nvsCR9lxEthHX5C/hcd+YYnDs6Rs=;
 b=klhDnizBUuJ89hVjhT9PZvg9KJYfCOftEcfJYSRI4HY9zFTzBpQf5XVcMeDgjwha6u3uFtTnbhx0gq7PG0V0PNPDmzs2cv/vAW9Zio2CVXKnclsdXYR6FsWTFR8CDBDxdO8ULIM1ekzdkqc8edoDFaDK8h0wVkh8pmcGJuOHsGeZtsY11a88m+exDIEmxkfREPrJ2fUc/Kq+jad4F0HsElnNvHPeDr84j2FqgzsaD47q5BgBqi5rdlslyZKQwYAws4G3RnLn//JB2s1SnL6h54tsgentJ+HIGM/gVIygUexv34nzC7Gebqil7+IsT2d3lzJCgnkvl2uvdpAZwffixA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY5PR11MB6318.namprd11.prod.outlook.com (2603:10b6:930:3e::5)
 by MW4PR11MB7127.namprd11.prod.outlook.com (2603:10b6:303:221::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Fri, 27 Mar
 2026 12:33:26 +0000
Received: from CY5PR11MB6318.namprd11.prod.outlook.com
 ([fe80::f4a9:9b9e:f0ee:84e]) by CY5PR11MB6318.namprd11.prod.outlook.com
 ([fe80::f4a9:9b9e:f0ee:84e%6]) with mapi id 15.20.9769.004; Fri, 27 Mar 2026
 12:33:26 +0000
From: "Mcnamara, John" <john.mcnamara@intel.com>
To: "Burakov, Anatoly" <anatoly.burakov@intel.com>, "dev@dpdk.org"
 <dev@dpdk.org>
Subject: Re: [PATCH v4 1/2] doc: add devargs documentation
Thread-Topic: [PATCH v4 1/2] doc: add devargs documentation
Thread-Index: AQHcpyQemRnkWBHbTku2mGpT4uRgYbXCfXOd
Date: Fri, 27 Mar 2026 12:33:26 +0000
Message-ID: <CY5PR11MB6318A5E8AB06EA501A07D6DBFC57A@CY5PR11MB6318.namprd11.prod.outlook.com>
References: <f9c79b16f3f90c3521acabdcaa96a9e61dca705b.1763122378.git.anatoly.burakov@intel.com>
 <17532da36934963d943f54de17c2d0d24dbfe8a2.1772112599.git.anatoly.burakov@intel.com>
In-Reply-To: <17532da36934963d943f54de17c2d0d24dbfe8a2.1772112599.git.anatoly.burakov@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR11MB6318:EE_|MW4PR11MB7127:EE_
x-ms-office365-filtering-correlation-id: 71145166-6d5f-47c3-10b5-08de8bfd0b74
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|8096899003|18002099003|56012099003|22082099003|38070700021;
x-microsoft-antispam-message-info: BTx45/HwXIR25DiVjw8nvqFwNX9D85SGUOBhWNxLtUOm1S7sDhNucIKdHBu/RjVjkCu5OXCQDjB1tcunknxbpEMBPfS6RkYEf/nBT/fyu2mRGYRi8aGSNGjGc/I+SEXhFS++4szifBXtJTyzLqoyo8j2zJqBYuhB49XMgc0UrcCnjqxQ5cx70fdA3klu/tq2+fFaw/Ly3wzxthXtAv+byrm3AmoxVi2+/mH3zeEwTYMg04kkT5qb0VvQtrd3c6WwA78X8tnfGBzF206ZxBFbsG4OLAJbZJuKvCNZOIHJXs28Sg1f77a4KHmIgyusCvr+MNnQda1pbFB6KwVuJCFXSKUKKX0sLe1TItjFvJDzav4+meCwOv6BzqkItYDJCNeHBZVFmC1eZI1xyyoIPHs7vxNS5Ssk0NUd0h6VoSMPaofkXL0rAP+ZvdPQcLIYa1CfvGLqqGybQ3dC/7NYg0bqoJ6gmON7fQcQQPK3fCuk0UjGCiAVB19q8HTmu1mtJV4ZnU1ZNwcvl8FpsXVe8uTbmY28HXgQtAOFpBXorR24J9jneo7uGVFjIFsG6ERPEE0+p9e3+w1pdLok2+0VIVNPib7AB4L4NrMD2Z6UzCvJEMGdtrixjH9mzipyuueoKoK71+OeFh7IW931hpRvNAx3N8nFj5WWvyZV2G2EsO/mrHfnCSbhUowVJ1XMT13kWKXLYfldP+Wv10b/1iJDS3IoUAsr/AMBWmodBHj66kQAZl7tunE3VxGtI4gm/gT65pu8cbYbAKFsnUVxtfcC0WhiJLYZNKskTeuF08bWC2U0lyo=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR11MB6318.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(8096899003)(18002099003)(56012099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?b8h4u459nbf+zOr6mPZhJOrhnXl/tYOw2Rt3vKNEz+NQoMMoug1iALF1XB?=
 =?iso-8859-1?Q?8ThpsqXGp3vrN9tPXD9BGmOYw2v5nvG06iHTQcjKun8u+YL6+7KIAUU+dt?=
 =?iso-8859-1?Q?jI2NCr3qh/EY1Kh36+rmfct0VuYg6oCez0HiLK5Sr/oIsq3JrjEKhWE8rx?=
 =?iso-8859-1?Q?E5AYrYebRoFxu4K3NRBjomFHoVYqlJxB42CMKh++Bj9kAU493JymYzXKoH?=
 =?iso-8859-1?Q?yZ2rgoU51XNO0L2PFmJlpGO1Y6UXS48hG12MmTOOYZVtCR16xiQXMn5L5a?=
 =?iso-8859-1?Q?7UuHk8P+X9OwMEz5iu0mtnpvJ44NeGMEyn59NRoovKN/7HddMlaR0uMHJM?=
 =?iso-8859-1?Q?YWBQThYI9xCmD7j4RxVX2ggDxnaV5HYsJbeQ8XpfPL/isSYDzHCwUg8XdW?=
 =?iso-8859-1?Q?3ZF64f+Ko3NYTOnnQP81uWBEgiKbMU4YHPCnaGuq2rkuQOhn6oKLQ3N/lj?=
 =?iso-8859-1?Q?X/KVYDHCnOOwg6RgAJaD84+CrAUH28PxZddATd1ea/P4/MamB43yk5ReBN?=
 =?iso-8859-1?Q?wVMvoK1+dnyc5CiKVH2D7vRk614ZDrFDXfb9iqS7koLnubUzl+DMIY69ch?=
 =?iso-8859-1?Q?ZVDPiIqBRzc1RP9gmXU+PymtSBI4VMlH2vFS0hEl3deGsfj30ySqelO05q?=
 =?iso-8859-1?Q?jo40fx8/wNJId7PQkPQaq5PfwZn0lOlA3yUEXrl0fZ9HpXiJrjjSt0/VmX?=
 =?iso-8859-1?Q?7H7Oq7Xs0wRw861mb63UFCsq4AFfNhjDJkiK+0wVENrunCiVOahYxU3pKJ?=
 =?iso-8859-1?Q?lI31NXA7ERAfEdQ69RPPf92Vx3WrGEyvxha2Z/5Ji1iLQW4jx82hn9mm1/?=
 =?iso-8859-1?Q?Inr0qRPQFjB55MLJtUy1hHOwf00740NaZpUgy5lUs+y0/PyH5Y+/5CuS0i?=
 =?iso-8859-1?Q?lItokxH68XeB9f+5MBa0ZwUPO0NVj30xXd7PuokNtKTcO4R6vLidfrh3+0?=
 =?iso-8859-1?Q?Jpm1ED6jDJ6CeSkV3X8/nRui3gPjm98I4dfKjjnEIlPpQV+4ta+5ifgb4a?=
 =?iso-8859-1?Q?Z3wjcWaLwgrIdRqQlD8HMZx9PtEmzWsGszZhNMaeJGk7xiCxcWuxBtrXQx?=
 =?iso-8859-1?Q?5V0ZjrFbZi8I54H8OZqjlgiKYfatPVBZ6deosVWTnd1IZj3gIyDeHH5X2P?=
 =?iso-8859-1?Q?zofuUcxqxvu8JH/RmF9xtf4Je7fNiuUpSL4xZzjG+nX3XLPXF0QW4jjK5u?=
 =?iso-8859-1?Q?bk1Y5MEgJIS9YBRjLC+T/Y06WBCbxp8lWBUrJu3F75BD2X7SnucjBxkId7?=
 =?iso-8859-1?Q?OkAMK0sXS0y1ik9W2xVTMlM6sNEzyb71wXNxtUuvDWccKJJFgjOld8Dq5c?=
 =?iso-8859-1?Q?FLQGJglg/RxL1Remr5RcJYF43NOYnZB8SoUKUSV6Y6mpPl5ss/OHDOfVER?=
 =?iso-8859-1?Q?+L3Krt7QQMW60xcpN1lb6SudJ1PL67BAd7G6fhkUlHEEHeSahl09qQGkul?=
 =?iso-8859-1?Q?v+uLLY6JlgAcKQ0cETDKBjYM5tX5b0ve8KUTXuZLoovvExEwFsLLrNf0A/?=
 =?iso-8859-1?Q?0RDQTxmUNpqWmUBzVYMFcBQmd9a9zCywG9zwQg9uPEhgQHq0xj8oEKVt9/?=
 =?iso-8859-1?Q?R1UZsphJk/ZIOogI9xLFO9N1EFXyoyJs+epj2JGiB+dlwumnvot00+ogit?=
 =?iso-8859-1?Q?MMp/Yo56xO/T7NdWouL7XnOdPdnRCYN1C+oOqO1j1PR8vypyOrRSR9hyGv?=
 =?iso-8859-1?Q?rmaSZtwDFbW2zhVgVjgXRIRxaBhH7VAVBPCTwBlYcJXjtXy3KcvH/EeD63?=
 =?iso-8859-1?Q?bc0kpVOJKz0ZiOx6fiKFi5O4S6mGjIh/8bgI5dPIxSaEVsSIekEgNZlvWg?=
 =?iso-8859-1?Q?P4vLYska1Q=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_CY5PR11MB6318A5E8AB06EA501A07D6DBFC57ACY5PR11MB6318namp_"
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: oD3VCEDhLHGmHS5gZgxu88vrcmANWuYa/eFdgpoxV+RRLxjegSujCF8Qn4ydPbudAaWxz8Vm6EwnOSc50Pz0m+IncwcA19Utqy3Om1qAjq5ICSm1KVOMgXZAqVjF5h4pDkbrdGDnAsTLPQwxbZOmZlCLu9NRT/tD+/zOmLyaI8Z06K0JaRcRNCbvzZNRNRSxCUY35GvBgPnGAQUz6ci741dvqnPRELgIjukqMm5ZTHIVtkL249OtDt78s6g1ObJGJgg6nUNDeKqTq4JLNMuSBpD+tttxSmD76illga55AesfwLwiBreK99lK8tCxTp4ekSRdce6oqKp6gG6zUcuTYA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6318.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71145166-6d5f-47c3-10b5-08de8bfd0b74
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2026 12:33:26.7820 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hA8qY77x6jX5hTYFkwv7nP84WIMN3bjiLA7TuHPXhQgilvJZJJN9J7JDCLrdtYmxnNjbQDdi13cbEuN2KOuhUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7127
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

--_000_CY5PR11MB6318A5E8AB06EA501A07D6DBFC57ACY5PR11MB6318namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable




________________________________
From: Anatoly Burakov <anatoly.burakov@intel.com>
Sent: Thursday, February 26, 2026 1:30 PM
To: dev@dpdk.org <dev@dpdk.org>
Subject: [PATCH v4 1/2] doc: add devargs documentation

Currently, the devargs syntax documentation is missing from the
programmer's guide, and is only documented implicitly through the devargs
API headers. Add a detailed description of the two supported devargs
syntaxes.

Acked-by: John McNamara <john.mcnamara@intel.com>


--_000_CY5PR11MB6318A5E8AB06EA501A07D6DBFC57ACY5PR11MB6318namp_
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
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"appendonsend"></div>
<div><br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<hr style=3D"display: inline-block; width: 98%;">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<b>From:</b>&nbsp;Anatoly Burakov &lt;anatoly.burakov@intel.com&gt;<br>
<b>Sent:</b>&nbsp;Thursday, February 26, 2026 1:30 PM<br>
<b>To:</b>&nbsp;dev@dpdk.org &lt;dev@dpdk.org&gt;<br>
<b>Subject:</b>&nbsp;[PATCH v4 1/2] doc: add devargs documentation </div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-size: 11pt;">Currently, the devargs syntax documentation=
 is missing from the<br>
programmer's guide, and is only documented implicitly through the devargs<b=
r>
API headers. Add a detailed description of the two supported devargs<br>
syntaxes.<br>
<br>
<span style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService,=
 Calibri, Helvetica, sans-serif; color: rgb(0, 0, 0);">Acked-by: John McNam=
ara &lt;john.mcnamara@intel.com&gt;<br>
</span><br>
</div>
</body>
</html>

--_000_CY5PR11MB6318A5E8AB06EA501A07D6DBFC57ACY5PR11MB6318namp_--
