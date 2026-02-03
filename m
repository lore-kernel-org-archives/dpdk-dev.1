Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E4D5E8B361
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Feb 2026 20:32:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 59D2D402EE;
	Tue,  3 Feb 2026 21:32:02 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTP id 97E6F4029D
 for <dev@dpdk.org>; Tue,  3 Feb 2026 21:32:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770150721; x=1801686721;
 h=from:to:cc:subject:date:message-id:mime-version;
 bh=lydBU/PzrB8DkuxSfPrIHSjaHGABrLL/+34n7f0+8GQ=;
 b=grBa8yi3PBh3wKKUPjvqEUAm39YLzVlEakunoSEzvDlGMVIPdNSxXW6P
 iBfCYjYwF6fD0RCReGTELaxNIaTk9xpx+lZj014ruJ5oHlsbHxyH5QO39
 SiIaIjApnFADbsCZjAzOv8mkKPhNFGV8revoq1YrKGw9kNbhu31tMw+fH
 mw+j8Ohh3OPFrRqLeiMp6KygR4Xl6WY9PrPgE7E6EQmlSbzLVhdZ6lqKS
 M8AQyZ8cuGINTM3vXxRwCOYU80ZNgiBXjgZQAOPQh3bNNtXFEEUGiToPl
 45mcNtNnGamJQqTDyZqLJAvRqaW3F9TfKU9aPxRRllcd4Fqzk1QA6wRYc w==;
X-CSE-ConnectionGUID: epoe2aoSRPuHqd08f9Jz6A==
X-CSE-MsgGUID: FCDXW5IrQzO7RvvNqQSaJQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11691"; a="73934257"
X-IronPort-AV: E=Sophos;i="6.21,271,1763452800"; d="scan'208,217";a="73934257"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Feb 2026 12:31:59 -0800
X-CSE-ConnectionGUID: nzn99yVMTgqCRkz73cSkXg==
X-CSE-MsgGUID: tDEpuGECQgG4/KMSP4UrUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,271,1763452800"; 
 d="scan'208,217";a="240637551"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Feb 2026 12:32:00 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 3 Feb 2026 12:31:58 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Tue, 3 Feb 2026 12:31:58 -0800
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.66) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 3 Feb 2026 12:31:57 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a77DN52Kf1PFRwY0VkcgOmIhdf5MGNjH4urEt8Nc/qMTUlfmYbQgletn9Bj6rhogZomkEkRPgG91yBCUaVDM4+XZ/NKArO2/zS3AMD31ki4wftfCEjaDbw0YKnrAjVKAff90hJiovPSmQDacdCicXXGD9RoCsyHuWVacyJfIgZslDtPdsS8rFSn1GhwlQ2U7GBEyO1xzzkG7574tDHh/4GbE03IAug3xPwDYY5kMAbl53R0n+ZHou7vRU0RGH9HO7xHUd3pAfktZ+tTc/tTmivzL73I7ZQXxMTHvcNcPf5uQeyzkynE4KiIr/mm3hJ++YFWxjPYwmwGEAjNhT3DctQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ItITwE1tO36sAynKB/C/Fy4IZRBNHpHeQThzBrTnoSU=;
 b=nRUc2EYxRsXi0YJp4xvhjAWnAGXAowfNF/3rM08ro68izE0nYQeb27K2sR4KlXpTIYlgMY7CriY13VQZEL9FkPsYO1peMlLId9lMLBWVwyJa7GxRh6lExbMmS0IMFZ4o2M9vGuRSuZbij4/+yEGVUWUE0Ck3gLgWF6uvBsgSArxIDJNtTOGmc78F63TKCq1jsjS+5Su/0neQK+skKlxLYTg50CKgoRodtP4Cv8zCAQulbt1wEeiqSpZX0yvXBDBV0E+IwD+DJPhhNOWGS9S300VkHzQWfsVnXfNzBaIMoNyBUiGUqZBmKFvDFwRbKU4fJsCKHBYy70yszCoJj6I4Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY5PR11MB6318.namprd11.prod.outlook.com (2603:10b6:930:3e::5)
 by DS0PR11MB8070.namprd11.prod.outlook.com (2603:10b6:8:12d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Tue, 3 Feb
 2026 20:31:55 +0000
Received: from CY5PR11MB6318.namprd11.prod.outlook.com
 ([fe80::f4a9:9b9e:f0ee:84e]) by CY5PR11MB6318.namprd11.prod.outlook.com
 ([fe80::f4a9:9b9e:f0ee:84e%5]) with mapi id 15.20.9564.016; Tue, 3 Feb 2026
 20:31:55 +0000
From: "Mcnamara, John" <john.mcnamara@intel.com>
To: "dev@dpdk.org" <dev@dpdk.org>
CC: Thomas Monjalon <thomas@monjalon.net>, "Marchand, David"
 <david.marchand@redhat.com>
Subject: DPDK Release Status Meeting 2026-02-03
Thread-Topic: DPDK Release Status Meeting 2026-02-03
Thread-Index: AQHclUvuF9TKL3WJDkGBPCjob7Wu9Q==
Date: Tue, 3 Feb 2026 20:31:55 +0000
Message-ID: <CY5PR11MB63188D513DDC34981E160D98FC9BA@CY5PR11MB6318.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR11MB6318:EE_|DS0PR11MB8070:EE_
x-ms-office365-filtering-correlation-id: 31124a20-b41e-4453-b634-08de63634587
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|8096899003|38070700021; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?Mg2BJx7ID7E8gC9d/ySon2Bk00/dDxF0zkUpOMQDtYYoRJpB6mW1V6ZyP3?=
 =?iso-8859-1?Q?K880+cRIUFhqBLlqgL+H37evyyptzrTtxqgL0WFVzqp4ChVpwW+KZ+Au/J?=
 =?iso-8859-1?Q?6kyRwDnAITh4Zze3aN5WdRIvUzxNi9B8FS4BC/87wk3Vx6REnToBXHgT2T?=
 =?iso-8859-1?Q?3h9rBg4HCnKSHDDMj4klopOqqe9dGUfaJJNJ9Zvve+futRGpLOldVSAO6A?=
 =?iso-8859-1?Q?Ok0xvspMtWV+xu+J6ZMZUJQ+VFgsoBf9Bly7z3RA2BzuZgnQh3e87sXW01?=
 =?iso-8859-1?Q?Ie5WDbmM4PzTLOTmNDxmZ8jhIGCEqHwz9UXN9K7RjhZC6P3p22K6/iEau/?=
 =?iso-8859-1?Q?XsMuUDTcd0rHfX+oL2Gi/wyaQIawMTEg3caRBi+3UNHUfNi9XE0Ta9eOQK?=
 =?iso-8859-1?Q?FxgqBxdYVApuC1A4XoAUjZJuF7kJrIXKbK/wA2yJ7XPXMBmQJ4HdchedLA?=
 =?iso-8859-1?Q?oONaV1JoGcNaqsi3xjv65Irb4EBh365gGOb7z14ElCQlxp822DanRcc4eX?=
 =?iso-8859-1?Q?sZx5Gdrcne0ILNDZmk9ZtiNfrB7HmgEbrgO75iS6WxoRZVhFtzsdWsK9hM?=
 =?iso-8859-1?Q?dU+fB5WBqG2MJP+i3VzaesCY5+1tsqCxxEi8tXmXxdJpp22ESiaKY2eWy3?=
 =?iso-8859-1?Q?CSM/pZaG6HXcbcV4aDzdUcwROXX1K2dOJPeX4TwGYMr/85279Nb7nxrLnx?=
 =?iso-8859-1?Q?E4YEaP0qIQPvkTnuPyu8w0POCuwIkhD/NOd5qacDfNzvZEX/4YtBHdaYHK?=
 =?iso-8859-1?Q?5ef/VLjZnQQv0PeehFS+JxbC+mg2wzd6jrLwGkFeJ7TMsce+rIJ3fT5UsC?=
 =?iso-8859-1?Q?aL9nSuuz0UebBYwX9ELEnCoZA3b7Bj9oSCRyfKMui3HbZPC59pHz5vzu3r?=
 =?iso-8859-1?Q?M1pwbiQOtOwdneQoQCeRxGZwa4m3sRXF7tpb6lNrQMyslKpfESfpSy4e22?=
 =?iso-8859-1?Q?81MrxWm5DCqNmcqlrQl5YidSug5Rsg/Bjfsy4TKaoLbGf1B4DqilR1PrHc?=
 =?iso-8859-1?Q?KKdqWIlQrbl3LbaneUtHqdGAxFA8p4eQAqR+FfYLOhuz/NpIZZy3HNfYbc?=
 =?iso-8859-1?Q?eOSuWvKnCOTjSSLfLgWGzDZuWhyRham3/wyhbFs2kj0kAzH2E09zp9SEcq?=
 =?iso-8859-1?Q?m5TbQ5zQZt6ZwGU4nHa5cK6Hj59iRVmOR37nDmUKMxsHEo2JBmP/9UpxSy?=
 =?iso-8859-1?Q?vCVcl1bGv0u29fmYGa9P4RNIsaiX7jrbmSOTlDtf75rs7l57ZhALV2gePR?=
 =?iso-8859-1?Q?rAEkYVijt2pNWnvbHTA+yBsYOcgdLrmwqyoOtjfN+y8yAvw2J5nikTlm+Q?=
 =?iso-8859-1?Q?Q1BHPDAbg7gS9RHivVOVXmPVc0szGH4h9GrQYZL8ftUc9Zd3x6AEWmGlsk?=
 =?iso-8859-1?Q?zo/x24/GAzps0AmeAVk6se0rcQzmA5hBom305JiIBQr+np1OQUihWt1t/j?=
 =?iso-8859-1?Q?OOygCYb/LHeVV7IFxn3NDFbFqd02D4AAEKIoavXqv/v5S00w241Dj6kWbp?=
 =?iso-8859-1?Q?7t4OhDrinFhcqDpi6O6/Sn82BlsmfuANdfhB5DqAt3litJOtSOraSF6i9L?=
 =?iso-8859-1?Q?XXqZdxuwLurZ3WowOyK7ikPmZRd54rzcwxrwy8T+eybdxohGJLPll9ooQT?=
 =?iso-8859-1?Q?zAV4ODt9fGkx9Xs+VUqnUMuKhE28zrfkIF?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR11MB6318.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(8096899003)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?/q8p72fwECkKLo2fTCHV2nihD2FyIMJoXzAa7S/SYl2CKwDYDD0Vs8MYEd?=
 =?iso-8859-1?Q?xBV39bS1siMQKrNWkr4AU+0MwNvyny/zIDEEjBk8ag0mEaG1WPb5uftC3a?=
 =?iso-8859-1?Q?lwU1UOtiVmESwa8UO4RQEtNBSjDC7GlJAdKBPv58VomXv1iBk+D6kXOH/G?=
 =?iso-8859-1?Q?gkciJ6x0xcj1DH0wmtYRCpPZ56EM4dFm1WxG+7BJxSuLnW8uTqb/36xtd1?=
 =?iso-8859-1?Q?IlANwTiWPLNs5QTLiZw/DXlC+LWB4rff7VSvnLDutlEXoAHQoZAlbM7Zx9?=
 =?iso-8859-1?Q?AydksDE9nL0qhQT5ot4gMDgkGeqsBpzex2Hkxi7plenx34ZlBUaVlTEqBR?=
 =?iso-8859-1?Q?1lBRZ8G6AS01+h5mF4MX1VBKX+V8HXj/Vmaagwi1wwslNb12APX5GeaaTc?=
 =?iso-8859-1?Q?bp70jRMKjJhZVJGGnWqQQfdF+dYe0o1oHw2OaIhno/PuXrmOIhn0TueBp9?=
 =?iso-8859-1?Q?zVYXUag8x4BdBsyzUlzyQkNZ+DYTMIQE3GrnSPYo1xO2OX2omZ8y741czc?=
 =?iso-8859-1?Q?R5YUdJXaqBvNlolINNSJPiCcDnie9zboVG2Eg1fmpVxb40aZ2tnGzTGMY6?=
 =?iso-8859-1?Q?6NwnOBOySHIWlrMacol9dAuXUg2YwQsNfNeXjTbwkZzcM6Q5dMDteGG/hs?=
 =?iso-8859-1?Q?rOGkKObAF7vtOR97tCKwmTJa66S1zub2qK6K6UBN12AaPMD/4AB+jpS2ye?=
 =?iso-8859-1?Q?/LkCHM/WzvVWXBvsV/9LjfK1juXBr96IogvKJLrBWiu33XSJBp/EXXA5js?=
 =?iso-8859-1?Q?1LzY4w/0ae6Jf9DY7YZn+P6kgVigzeCP+1CZtGmgtOIOMLzJJkG7HD8EHv?=
 =?iso-8859-1?Q?powTMz+lXzNjhwG0rkHhC4rQx0M8LY1MMjdfWs27/b6xWS1GKoyKLAoW7n?=
 =?iso-8859-1?Q?1R9SVfW61EXYHYDeUcalQTcpCIpq6iyK3TrUCafov7NWF5QPw4RW+fs3nZ?=
 =?iso-8859-1?Q?bkFl6SxmsN/6DnveVrdVYdCp5OPLI6XHScj3/75ODL10q7BamKLf2uZBo/?=
 =?iso-8859-1?Q?SIDcn/ApYbx97m8sAo/q/Hp5WVcKT3tW/5uVvZRX9xWml5Bpux5S9RvgXI?=
 =?iso-8859-1?Q?06nLTDihhz82jb7FVDj1TvTr6pMZkwZPjugC8I4jel1A2jxV0OAvKO9+XO?=
 =?iso-8859-1?Q?6a+H8daaLilrtMkn6FDS7a40pz7PesJDnpAes7tV/1TmiIArUyn5Aey4Ma?=
 =?iso-8859-1?Q?2li7WM+YsvZCqsZ907J3Cbeo1HZGhgnPB7y39tIRTxdmKh3LnuLQz1nLT9?=
 =?iso-8859-1?Q?j06djIoWFOkDyYiXcVNwT/MY7m+55YKuTlfRkOlebzNhD1GCybMRYIYKNZ?=
 =?iso-8859-1?Q?3WUI6bkFInT5u4eX3ag1EP3CYM68V+HKn8OGFrxpTwqpakqI1QAueC3QFh?=
 =?iso-8859-1?Q?NOoF/nuUuYUCQrP3LMkoncQit7mFDiOLi8bSQFiaAMdSKqbmRKuVFrcxRi?=
 =?iso-8859-1?Q?gBVxqrlBWCzJa35H1C2MDOYF5FIRpKnVJPUQNQVmCBmfhNJo2/6hSmxItT?=
 =?iso-8859-1?Q?YR2KC14/9m+m9he34lhfaWMwoe+pdtIH92Hi69eYWXR/p/TLj+pYkbmk+v?=
 =?iso-8859-1?Q?5w/a+EzEG6w4YzIpqX4//I9SRmKUFqj6NiInIRiYGLvp18jTvD+WPdrHiy?=
 =?iso-8859-1?Q?wQPp/FQlAegngG2CEBxdKy4uIR2NBmgFPMlLJtgDopAHcgCFa42Db9+8gr?=
 =?iso-8859-1?Q?bAnMOjLGkdVKgInHGti5jnwUdZEUTvfZ/AzqrO40gZXzLIHqxrHi9wrXIV?=
 =?iso-8859-1?Q?H11j+FtnZAuORd92HXyaK4MfPwmSC++k45BarBNbBu+btAdltxnnHDSu+k?=
 =?iso-8859-1?Q?mXEWjV4/mg=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_CY5PR11MB63188D513DDC34981E160D98FC9BACY5PR11MB6318namp_"
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6318.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31124a20-b41e-4453-b634-08de63634587
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2026 20:31:55.2436 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pNKxLE/rGZUjkDcw8lipuC1Q4pAE6hi2jce8TOHhWl0IR60df1Op2HF4oqFYAge7ZD0VLo1iqXRvYIEmoTz2Ow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8070
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

--_000_CY5PR11MB63188D513DDC34981E160D98FC9BACY5PR11MB6318namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Release status meeting minutes 2026-02-03
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Agenda:
- Release Dates
- Subtrees
- Roadmaps
- LTS
- Defects
- Opens

Participants:
- ARM
- Intel
- Marvell
- Nvidia
- Red Hat
- Stephen Hemminger

Release Dates
-------------

The following are the proposed working dates for 26.03:


| Date            | Milestone      | Description                    |
| --------------- | -------------- | ------------------------------ |
| 5 January 2026  | RFC/v1 patches | Proposal deadline              |
| 9 February 2026 | 26.03-rc1      | API freeze                     |
| 2 March 2026    | 26.03-rc2      | PMD features freeze            |
| 9 March 2026    | 26.03-rc3      | Builtin apps features freeze   |
| 16 March 2026   | 26.03-rc4      | Documentation ready            |
| 19 March 2026   | 26.03.0        | Release                        |

See https://core.dpdk.org/roadmap/


Subtrees
--------

- next-net
  - 24 patches ready for main.
  - 41 patches in review.

- next-net-intel
  - Pulled to main.
  - 45 patches in backlog.

- next-net-mlx
  - Tree pulled.

- next-broadcom
  - Tree pulled.

- next-net-mvl
  - Merge in progress.

- next-eventdev
  - No patches.

- next-baseband
  - No patches.

- next-virtio
  - Tree pulled.

- next-crypto
  - No updates.
  - ~ 20 patches in backlog.
  - Zuc and Snow 5G algorithms introduced.

- next-dts
  - Some patches merged for main.
  - Some other patches under review.

- main
  - Some cleanup
  - Looking at string overflow/truncation patchset.
  - Some improvements on checksum under review.
  - Unit tests patches merged. Some random failures.
  - Mbuf and Mpool patches.
  - Will pull next-net this week.


 DPDK Summit CFP is open: https://events.linuxfoundation.org/dpdk-summit/pr=
ogram/cfp/


Other
-----
  - None.

LTS
---

See also: https://core.dpdk.org/roadmap/#stable

LTS versions ongoing/released:

- 24.11.4 - Released.
- 23.11.6 - Released.
- 22.11.11 - Released.

Older releases:
- 20.11.10 - Will only be updated with CVE and critical fixes.
- 19.11.14 - Will only be updated with CVE and critical fixes.


- Distros
  - Debian 13 contains DPDK v24.11
  - Ubuntu 25.04 contains DPDK v24.11
  - Ubuntu 24.04 LTS contains DPDK v23.11
  - RHEL 9 contains DPDK 24.11

Defects
-------

- Bugzilla links, 'Bugs',  added for hosted projects
  - https://www.dpdk.org/hosted-projects/



DPDK Release Status Meetings
----------------------------

The DPDK Release Status Meeting is intended for DPDK Committers to discuss =
the
status of the master tree and sub-trees, and for project managers to track
progress or milestone dates.

The meeting occurs on every Tuesday at 14:30 DST over Jitsi on https://meet=
.jit.si/DPDK

You don't need an invite to join the meeting but if you want a calendar rem=
inder just
send an email to "John McNamara <john.mcnamara@intel.com>" for the invite.



--_000_CY5PR11MB63188D513DDC34981E160D98FC9BACY5PR11MB6318namp_
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
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Aptos Mono&quot;, Aptos_EmbeddedFont, Apt=
os_MSFontService, monospace;">Release status meeting minutes 2026-02-03</sp=
an></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Aptos Mono&quot;, Aptos_EmbeddedFont, Apt=
os_MSFontService, monospace;">=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Aptos Mono&quot;, Aptos_EmbeddedFont, Apt=
os_MSFontService, monospace;"><br>
</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Aptos Mono&quot;, Aptos_EmbeddedFont, Apt=
os_MSFontService, monospace;">Agenda:</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Aptos Mono&quot;, Aptos_EmbeddedFont, Apt=
os_MSFontService, monospace;">- Release Dates</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Aptos Mono&quot;, Aptos_EmbeddedFont, Apt=
os_MSFontService, monospace;">- Subtrees</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Aptos Mono&quot;, Aptos_EmbeddedFont, Apt=
os_MSFontService, monospace;">- Roadmaps</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Aptos Mono&quot;, Aptos_EmbeddedFont, Apt=
os_MSFontService, monospace;">- LTS</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Aptos Mono&quot;, Aptos_EmbeddedFont, Apt=
os_MSFontService, monospace;">- Defects</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Aptos Mono&quot;, Aptos_EmbeddedFont, Apt=
os_MSFontService, monospace;">- Opens</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Aptos Mono&quot;, Aptos_EmbeddedFont, Apt=
os_MSFontService, monospace;"><br>
</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Aptos Mono&quot;, Aptos_EmbeddedFont, Apt=
os_MSFontService, monospace;">Participants:</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Aptos Mono&quot;, Aptos_EmbeddedFont, Apt=
os_MSFontService, monospace;">- ARM</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Aptos Mono&quot;, Aptos_EmbeddedFont, Apt=
os_MSFontService, monospace;">- Intel</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Aptos Mono&quot;, Aptos_EmbeddedFont, Apt=
os_MSFontService, monospace;">- Marvell</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Aptos Mono&quot;, Aptos_EmbeddedFont, Apt=
os_MSFontService, monospace;">- Nvidia</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Aptos Mono&quot;, Aptos_EmbeddedFont, Apt=
os_MSFontService, monospace;">- Red Hat</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Aptos Mono&quot;, Aptos_EmbeddedFont, Apt=
os_MSFontService, monospace;">- Stephen Hemminger</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Aptos Mono&quot;, Aptos_EmbeddedFont, Apt=
os_MSFontService, monospace;"><br>
</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Aptos Mono&quot;, Aptos_EmbeddedFont, Apt=
os_MSFontService, monospace;">Release Dates</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Aptos Mono&quot;, Aptos_EmbeddedFont, Apt=
os_MSFontService, monospace;">-------------</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Aptos Mono&quot;, Aptos_EmbeddedFont, Apt=
os_MSFontService, monospace;"><br>
</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Aptos Mono&quot;, Aptos_EmbeddedFont, Apt=
os_MSFontService, monospace;">The following are the proposed working dates =
for 26.03:</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Aptos Mono&quot;, Aptos_EmbeddedFont, Apt=
os_MSFontService, monospace;"><br>
</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Aptos Mono&quot;, Aptos_EmbeddedFont, Apt=
os_MSFontService, monospace;"><br>
</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Aptos Mono&quot;, Aptos_EmbeddedFont, Apt=
os_MSFontService, monospace;">| Date &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp;| Milestone &nbsp; &nbsp; &nbsp;| Description &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;|</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Aptos Mono&quot;, Aptos_EmbeddedFont, Apt=
os_MSFontService, monospace;">| --------------- | -------------- | --------=
---------------------- |</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Aptos Mono&quot;, Aptos_EmbeddedFont, Apt=
os_MSFontService, monospace;">| 5 January 2026 &nbsp;| RFC/v1 patches | Pro=
posal deadline &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;|</span></di=
v>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Aptos Mono&quot;, Aptos_EmbeddedFont, Apt=
os_MSFontService, monospace;">| 9 February 2026 | 26.03-rc1 &nbsp; &nbsp; &=
nbsp;| API freeze &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &=
nbsp; &nbsp; |</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Aptos Mono&quot;, Aptos_EmbeddedFont, Apt=
os_MSFontService, monospace;">| 2 March 2026 &nbsp; &nbsp;| 26.03-rc2 &nbsp=
; &nbsp; &nbsp;| PMD features freeze &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp;|</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Aptos Mono&quot;, Aptos_EmbeddedFont, Apt=
os_MSFontService, monospace;">| 9 March 2026 &nbsp; &nbsp;| 26.03-rc3 &nbsp=
; &nbsp; &nbsp;| Builtin apps features freeze &nbsp; |</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Aptos Mono&quot;, Aptos_EmbeddedFont, Apt=
os_MSFontService, monospace;">| 16 March 2026 &nbsp; | 26.03-rc4 &nbsp; &nb=
sp; &nbsp;| Documentation ready &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;|<=
/span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Aptos Mono&quot;, Aptos_EmbeddedFont, Apt=
os_MSFontService, monospace;">| 19 March 2026 &nbsp; | 26.03.0 &nbsp; &nbsp=
; &nbsp; &nbsp;| Release &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &=
nbsp; &nbsp; &nbsp; &nbsp; &nbsp;|</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Aptos Mono&quot;, Aptos_EmbeddedFont, Apt=
os_MSFontService, monospace;"><br>
</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Aptos Mono&quot;, Aptos_EmbeddedFont, Apt=
os_MSFontService, monospace;">See https://core.dpdk.org/roadmap/</span></di=
v>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Aptos Mono&quot;, Aptos_EmbeddedFont, Apt=
os_MSFontService, monospace;"><br>
</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Aptos Mono&quot;, Aptos_EmbeddedFont, Apt=
os_MSFontService, monospace;"><br>
</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Aptos Mono&quot;, Aptos_EmbeddedFont, Apt=
os_MSFontService, monospace;">Subtrees</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Aptos Mono&quot;, Aptos_EmbeddedFont, Apt=
os_MSFontService, monospace;">--------</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Aptos Mono&quot;, Aptos_EmbeddedFont, Apt=
os_MSFontService, monospace;"><br>
</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Aptos Mono&quot;, Aptos_EmbeddedFont, Apt=
os_MSFontService, monospace;">- next-net</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Aptos Mono&quot;, Aptos_EmbeddedFont, Apt=
os_MSFontService, monospace;">&nbsp; - 24 patches ready for main.</span></d=
iv>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Aptos Mono&quot;, Aptos_EmbeddedFont, Apt=
os_MSFontService, monospace;">&nbsp; - 41 patches in review.</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Aptos Mono&quot;, Aptos_EmbeddedFont, Apt=
os_MSFontService, monospace;"><br>
</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Aptos Mono&quot;, Aptos_EmbeddedFont, Apt=
os_MSFontService, monospace;">- next-net-intel</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Aptos Mono&quot;, Aptos_EmbeddedFont, Apt=
os_MSFontService, monospace;">&nbsp; - Pulled to main.</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Aptos Mono&quot;, Aptos_EmbeddedFont, Apt=
os_MSFontService, monospace;">&nbsp; - 45 patches in backlog.</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Aptos Mono&quot;, Aptos_EmbeddedFont, Apt=
os_MSFontService, monospace;"><br>
</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Aptos Mono&quot;, Aptos_EmbeddedFont, Apt=
os_MSFontService, monospace;">- next-net-mlx</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Aptos Mono&quot;, Aptos_EmbeddedFont, Apt=
os_MSFontService, monospace;">&nbsp; - Tree pulled.</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Aptos Mono&quot;, Aptos_EmbeddedFont, Apt=
os_MSFontService, monospace;"><br>
</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Aptos Mono&quot;, Aptos_EmbeddedFont, Apt=
os_MSFontService, monospace;">- next-broadcom</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Aptos Mono&quot;, Aptos_EmbeddedFont, Apt=
os_MSFontService, monospace;">&nbsp; - Tree pulled.</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Aptos Mono&quot;, Aptos_EmbeddedFont, Apt=
os_MSFontService, monospace;"><br>
</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Aptos Mono&quot;, Aptos_EmbeddedFont, Apt=
os_MSFontService, monospace;">- next-net-mvl</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Aptos Mono&quot;, Aptos_EmbeddedFont, Apt=
os_MSFontService, monospace;">&nbsp; - Merge in progress.</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Aptos Mono&quot;, Aptos_EmbeddedFont, Apt=
os_MSFontService, monospace;"><br>
</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Aptos Mono&quot;, Aptos_EmbeddedFont, Apt=
os_MSFontService, monospace;">- next-eventdev</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Aptos Mono&quot;, Aptos_EmbeddedFont, Apt=
os_MSFontService, monospace;">&nbsp; - No patches.</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Aptos Mono&quot;, Aptos_EmbeddedFont, Apt=
os_MSFontService, monospace;"><br>
</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Aptos Mono&quot;, Aptos_EmbeddedFont, Apt=
os_MSFontService, monospace;">- next-baseband</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Aptos Mono&quot;, Aptos_EmbeddedFont, Apt=
os_MSFontService, monospace;">&nbsp; - No patches.</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Aptos Mono&quot;, Aptos_EmbeddedFont, Apt=
os_MSFontService, monospace;"><br>
</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Aptos Mono&quot;, Aptos_EmbeddedFont, Apt=
os_MSFontService, monospace;">- next-virtio</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Aptos Mono&quot;, Aptos_EmbeddedFont, Apt=
os_MSFontService, monospace;">&nbsp; - Tree pulled.</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Aptos Mono&quot;, Aptos_EmbeddedFont, Apt=
os_MSFontService, monospace;"><br>
</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Aptos Mono&quot;, Aptos_EmbeddedFont, Apt=
os_MSFontService, monospace;">- next-crypto</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Aptos Mono&quot;, Aptos_EmbeddedFont, Apt=
os_MSFontService, monospace;">&nbsp; - No updates.</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Aptos Mono&quot;, Aptos_EmbeddedFont, Apt=
os_MSFontService, monospace;">&nbsp; - ~ 20 patches in backlog.</span></div=
>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Aptos Mono&quot;, Aptos_EmbeddedFont, Apt=
os_MSFontService, monospace;">&nbsp; - Zuc and Snow 5G algorithms introduce=
d.</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Aptos Mono&quot;, Aptos_EmbeddedFont, Apt=
os_MSFontService, monospace;"><br>
</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Aptos Mono&quot;, Aptos_EmbeddedFont, Apt=
os_MSFontService, monospace;">- next-dts</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Aptos Mono&quot;, Aptos_EmbeddedFont, Apt=
os_MSFontService, monospace;">&nbsp; - Some patches merged for main.</span>=
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Aptos Mono&quot;, Aptos_EmbeddedFont, Apt=
os_MSFontService, monospace;">&nbsp; - Some other patches under review.</sp=
an></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Aptos Mono&quot;, Aptos_EmbeddedFont, Apt=
os_MSFontService, monospace;"><br>
</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Aptos Mono&quot;, Aptos_EmbeddedFont, Apt=
os_MSFontService, monospace;">- main</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Aptos Mono&quot;, Aptos_EmbeddedFont, Apt=
os_MSFontService, monospace;">&nbsp; - Some cleanup</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Aptos Mono&quot;, Aptos_EmbeddedFont, Apt=
os_MSFontService, monospace;">&nbsp; - Looking at string overflow/truncatio=
n patchset.</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Aptos Mono&quot;, Aptos_EmbeddedFont, Apt=
os_MSFontService, monospace;">&nbsp; - Some improvements on checksum under =
review.</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Aptos Mono&quot;, Aptos_EmbeddedFont, Apt=
os_MSFontService, monospace;">&nbsp; - Unit tests patches merged. Some rand=
om failures.</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Aptos Mono&quot;, Aptos_EmbeddedFont, Apt=
os_MSFontService, monospace;">&nbsp; - Mbuf and Mpool patches.</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Aptos Mono&quot;, Aptos_EmbeddedFont, Apt=
os_MSFontService, monospace;">&nbsp; - Will pull next-net this week.</span>=
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Aptos Mono&quot;, Aptos_EmbeddedFont, Apt=
os_MSFontService, monospace;"><br>
</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Aptos Mono&quot;, Aptos_EmbeddedFont, Apt=
os_MSFontService, monospace;"><br>
</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Aptos Mono&quot;, Aptos_EmbeddedFont, Apt=
os_MSFontService, monospace;">&nbsp;DPDK Summit CFP is open: https://events=
.linuxfoundation.org/dpdk-summit/program/cfp/</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Aptos Mono&quot;, Aptos_EmbeddedFont, Apt=
os_MSFontService, monospace;"><br>
</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Aptos Mono&quot;, Aptos_EmbeddedFont, Apt=
os_MSFontService, monospace;"><br>
</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Aptos Mono&quot;, Aptos_EmbeddedFont, Apt=
os_MSFontService, monospace;">Other</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Aptos Mono&quot;, Aptos_EmbeddedFont, Apt=
os_MSFontService, monospace;">-----</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Aptos Mono&quot;, Aptos_EmbeddedFont, Apt=
os_MSFontService, monospace;">&nbsp; - None.</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Aptos Mono&quot;, Aptos_EmbeddedFont, Apt=
os_MSFontService, monospace;"><br>
</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Aptos Mono&quot;, Aptos_EmbeddedFont, Apt=
os_MSFontService, monospace;">LTS</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Aptos Mono&quot;, Aptos_EmbeddedFont, Apt=
os_MSFontService, monospace;">---</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Aptos Mono&quot;, Aptos_EmbeddedFont, Apt=
os_MSFontService, monospace;"><br>
</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Aptos Mono&quot;, Aptos_EmbeddedFont, Apt=
os_MSFontService, monospace;">See also: https://core.dpdk.org/roadmap/#stab=
le</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Aptos Mono&quot;, Aptos_EmbeddedFont, Apt=
os_MSFontService, monospace;"><br>
</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Aptos Mono&quot;, Aptos_EmbeddedFont, Apt=
os_MSFontService, monospace;">LTS versions ongoing/released:</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Aptos Mono&quot;, Aptos_EmbeddedFont, Apt=
os_MSFontService, monospace;"><br>
</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Aptos Mono&quot;, Aptos_EmbeddedFont, Apt=
os_MSFontService, monospace;">- 24.11.4 - Released.</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Aptos Mono&quot;, Aptos_EmbeddedFont, Apt=
os_MSFontService, monospace;">- 23.11.6 - Released.</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Aptos Mono&quot;, Aptos_EmbeddedFont, Apt=
os_MSFontService, monospace;">- 22.11.11 - Released.</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Aptos Mono&quot;, Aptos_EmbeddedFont, Apt=
os_MSFontService, monospace;"><br>
</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Aptos Mono&quot;, Aptos_EmbeddedFont, Apt=
os_MSFontService, monospace;">Older releases:</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Aptos Mono&quot;, Aptos_EmbeddedFont, Apt=
os_MSFontService, monospace;">- 20.11.10 - Will only be updated with CVE an=
d critical fixes.</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Aptos Mono&quot;, Aptos_EmbeddedFont, Apt=
os_MSFontService, monospace;">- 19.11.14 - Will only be updated with CVE an=
d critical fixes.</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Aptos Mono&quot;, Aptos_EmbeddedFont, Apt=
os_MSFontService, monospace;"><br>
</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Aptos Mono&quot;, Aptos_EmbeddedFont, Apt=
os_MSFontService, monospace;"><br>
</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Aptos Mono&quot;, Aptos_EmbeddedFont, Apt=
os_MSFontService, monospace;">- Distros</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Aptos Mono&quot;, Aptos_EmbeddedFont, Apt=
os_MSFontService, monospace;">&nbsp; - Debian 13 contains DPDK v24.11</span=
></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Aptos Mono&quot;, Aptos_EmbeddedFont, Apt=
os_MSFontService, monospace;">&nbsp; - Ubuntu 25.04 contains DPDK v24.11</s=
pan></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Aptos Mono&quot;, Aptos_EmbeddedFont, Apt=
os_MSFontService, monospace;">&nbsp; - Ubuntu 24.04 LTS contains DPDK v23.1=
1</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Aptos Mono&quot;, Aptos_EmbeddedFont, Apt=
os_MSFontService, monospace;">&nbsp; - RHEL 9 contains DPDK 24.11</span></d=
iv>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Aptos Mono&quot;, Aptos_EmbeddedFont, Apt=
os_MSFontService, monospace;"><br>
</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Aptos Mono&quot;, Aptos_EmbeddedFont, Apt=
os_MSFontService, monospace;">Defects</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Aptos Mono&quot;, Aptos_EmbeddedFont, Apt=
os_MSFontService, monospace;">-------</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Aptos Mono&quot;, Aptos_EmbeddedFont, Apt=
os_MSFontService, monospace;"><br>
</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Aptos Mono&quot;, Aptos_EmbeddedFont, Apt=
os_MSFontService, monospace;">- Bugzilla links, 'Bugs', &nbsp;added for hos=
ted projects</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Aptos Mono&quot;, Aptos_EmbeddedFont, Apt=
os_MSFontService, monospace;">&nbsp; - https://www.dpdk.org/hosted-projects=
/</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Aptos Mono&quot;, Aptos_EmbeddedFont, Apt=
os_MSFontService, monospace;"><br>
</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Aptos Mono&quot;, Aptos_EmbeddedFont, Apt=
os_MSFontService, monospace;"><br>
</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Aptos Mono&quot;, Aptos_EmbeddedFont, Apt=
os_MSFontService, monospace;"><br>
</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Aptos Mono&quot;, Aptos_EmbeddedFont, Apt=
os_MSFontService, monospace;">DPDK Release Status Meetings</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Aptos Mono&quot;, Aptos_EmbeddedFont, Apt=
os_MSFontService, monospace;">----------------------------</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Aptos Mono&quot;, Aptos_EmbeddedFont, Apt=
os_MSFontService, monospace;"><br>
</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Aptos Mono&quot;, Aptos_EmbeddedFont, Apt=
os_MSFontService, monospace;">The DPDK Release Status Meeting is intended f=
or DPDK Committers to discuss the</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Aptos Mono&quot;, Aptos_EmbeddedFont, Apt=
os_MSFontService, monospace;">status of the master tree and sub-trees, and =
for project managers to track</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Aptos Mono&quot;, Aptos_EmbeddedFont, Apt=
os_MSFontService, monospace;">progress or milestone dates.</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Aptos Mono&quot;, Aptos_EmbeddedFont, Apt=
os_MSFontService, monospace;"><br>
</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Aptos Mono&quot;, Aptos_EmbeddedFont, Apt=
os_MSFontService, monospace;">The meeting occurs on every Tuesday at 14:30 =
DST over Jitsi on https://meet.jit.si/DPDK</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Aptos Mono&quot;, Aptos_EmbeddedFont, Apt=
os_MSFontService, monospace;"><br>
</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Aptos Mono&quot;, Aptos_EmbeddedFont, Apt=
os_MSFontService, monospace;">You don't need an invite to join the meeting =
but if you want a calendar reminder just</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Aptos Mono&quot;, Aptos_EmbeddedFont, Apt=
os_MSFontService, monospace;">send an email to &quot;John McNamara &lt;john=
.mcnamara@intel.com&gt;&quot; for the invite.</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Aptos Mono&quot;, Aptos_EmbeddedFont, Apt=
os_MSFontService, monospace;"><br>
</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Aptos Mono&quot;, Aptos_EmbeddedFont, Apt=
os_MSFontService, monospace;"></span><br>
</div>
</body>
</html>

--_000_CY5PR11MB63188D513DDC34981E160D98FC9BACY5PR11MB6318namp_--
