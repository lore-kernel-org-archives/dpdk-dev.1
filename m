Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32242C3600B
	for <dpdk-dev@archiver.kernel.org>; Thu, 27 Mar 2025 13:49:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 85F7340A71;
	Thu, 27 Mar 2025 14:49:32 +0100 (CET)
Received: from rcdn-iport-4.cisco.com (rcdn-iport-4.cisco.com [173.37.86.75])
 by mails.dpdk.org (Postfix) with ESMTP id D41AA4028A
 for <dev@dpdk.org>; Thu, 20 Mar 2025 10:38:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cisco.com; i=@cisco.com; l=3839; q=dns/txt;
 s=iport01; t=1742463501; x=1743673101;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=K2Ogc1AEfM/ehgHg7qg91i5O1HdwUp4/T0u7ObXdk0o=;
 b=edlgFSdnXs+Nhgc7fh0C5lrN3CSqhszBVDJKsSBD6zlvCWjSZj4tonsL
 qIZMI9RPR/yNds9mCFH5a9tqHo8eCafRQ/PUa0+2b+8lDL9hYvuqMooXe
 4mjxL7GAK9A4kU/UVCxlMqT0oTntVo4tqJhl1bTzbtcETZO7mU02aMpOW
 i3/Qr0oPgTPvA2CkFqcux52ajjeqWG7YP0dJBy94fcdnaVYSNUYM5O/ip
 9zCnHgxnIxIQVZYQBmpLYtTmx/IcwXhiBC6J1es6Ka4lGkwktI6HE4NzU
 MqWDQhImjrBdD5MGd2yezV4s77FH6IxcmV4PRPBi/KFtRaXQl4ezj0QlJ g==;
X-CSE-ConnectionGUID: ktR6+oRyTsG97E7giZ4J2w==
X-CSE-MsgGUID: FfCnFW+rTkea93vaWUmyOg==
X-IPAS-Result: =?us-ascii?q?A0BPAADq4Ntn/5H/Ja1aHQEBAQEJARIBBQUBQCWBGggBC?=
 =?us-ascii?q?wGBcSooB3aBHEiIIQOETl+IdgOeFIElA1YPAQEBDQI5CwQBAYUHAosgAiY0C?=
 =?us-ascii?q?Q4BAgQBAQEBAwIDAQEBAQEBAQEBAQELAQEFAQEBAgEHBYEOE4V7DYZaAQEBA?=
 =?us-ascii?q?QIBEig/BQcEAgEIEQQBAR8QMR0IAQEEDgUIDA6CYYJBIwMBEAahPgGBQAKKK?=
 =?us-ascii?q?3iBNIEBg2xB228GgUgBiE8BhWyEdycbgUlEgRVCgjcxPoJhA4E2KwUrg2OCL?=
 =?us-ascii?q?wSCGBdFgSQBg0COU4gIE5NfUnscA1ksAVUTFwsHBYEpQwOBDyOBIgU0CioOO?=
 =?us-ascii?q?CmBY2lJOgINAjWCG3yCKIIXgjaEPoQ/hVCCEYFcAwMjgjBvdRyEPT2EYC1Qg?=
 =?us-ascii?q?kEdQAMLbT03FBsFBIE1BaJGATqFFkMiAk8BSDUbMRgKAgmSd5QFij+VEgqEG?=
 =?us-ascii?q?4wYlWYXqleICpB0jgWbBAIEAgQFAg8BAQaBZzyBWXAVgyJSGQ+PTwELh1OyS?=
 =?us-ascii?q?HgCOgIHCwEBAwmPaIF9AQE?=
IronPort-PHdr: A9a23:5/8r5xA6cCXPpjpsDBaQUyQVXRdPi9zP1kY9454jjfdJaqu8us6kN
 03E7vIrh1jMDs3X6PNB3vLfqLuoGXcB7pCIrG0YfdRSWgUEh8Qbk01oAMOMBUDhav+/Ryc7B
 89FElRi+hmG
IronPort-Data: A9a23:F2IjlqOXzQu6EGfvrR3ilsFynXyQoLVcMsEvi/4bfWQNrUp20jZVn
 WAZWD2HM/rZYmH2LdpyYNzl/E9S6sTUn9BiHXM5pCpnJ55oRWUpJjg4wmPYZX76whjrFRo/h
 ykmQoCeaphyFjmE+0/F3oHJ9RFUzbuPSqf3FNnKMyVwQR4MYCo6gHqPocZh6mJTqYb/Wl/lV
 e/a+ZWFZQf+gWYsawr41orawP9RlKWq0N8nlgRWicBj5Df2i3QTBZQDEqC9R1OQapVUBOOzW
 9HYx7i/+G7Dlz91Yj9yuu+mGqGiaue60Tmm0hK6aYD76vRxjnBaPpIACRYpQRw/ZwNlMDxG4
 I4lWZSYEW/FN0BX8QgXe0Ew/ypWZcWq9FJbSJSymZT78qHIT5fj6/ZyNh91OrcJxv1YUD5jq
 vMZGmwvNA/W0opawJrjIgVtrt4oIM+uOMYUvWttiGmJS/0nWpvEBa7N4Le03h9p2ZsIRqmYP
 ZdEL2MzMXwsYDUXUrsTIIg3nuqngXT7WzZZs1mS46Ew5gA/ySQqi+m1aoOEJoXiqcN9sEizo
 Ez5vH7FARwTZYeBwAW492OLibqa9c/8cMdIfFGizdZmjUO7ynQfC1sRT1TTnBWiolS1V9QaL
 wkf/TAj6PBiskeqVdL6GRa/pRZooyIhZjaZKMVjgCmlwavP6AHfDW8BJgOtovR73CPqbVTGD
 mO0ou4=
IronPort-HdrOrdr: A9a23:OoldfK5hgXNS0W1QtAPXwYeCI+orL9Y04lQ7vn2ZFiYlEfBwxv
 rPoB1E737JYW4qKQ8dcLC7VJVpQRvnhPhICPoqTMaftW7dySSVxeBZnMffKlLbalfDH4JmpM
 Ndmu1FeaLN5DtB/IjHCWuDYqsdKbC8mcjC65a9vhJQpENRGt1dBmxCe3+m+zhNNXJ77O0CZe
 KhD6R81l2dUEVSRP6WQlMCWO/OrcDKkpXJXT4qbiRM1CC+yRmTxPrfCRa34jcyOgkj/V4lyw
 f4uj28wp/mn+Cwyxfa2WOWxY9RgsHdxtxKA9HJotQJKx334zzYJLhJavmnhnQYseuv4FElnJ
 3nuBE7Jfl+7HvXYyWcvQbt4Q/9yzwjgkWSimNwwEGT4/ARdghKT/aptrgpNScxLHBQ+u2U5Z
 g7ml5xcaAnVC8o0h6Nv+QgHCsa5nZc6UBS4tL7yUYvELf3rNRq3NYiFIQ/KuZaIAvqrI8gC+
 VgF8fa+bJfdk6bdWnQui11zMWrRWlbJGbMfqEugL3d79FtpgEw82IIgMgE2nsQ/pM0TJdJo+
 zCL6RzjblLCssbd7h0CusNSda+TjWle2OADEuCZVD8UK0XMXPErJD6pL0z+eGxYZQNiJ8/go
 7IXl9UvXM7P0juFcqN1ptW9Q2lehT2YR39jsVFo5RpsLz1Q7TmdSWFVVA1isOl5+4SB8XKMs
 zDTq6+w8WTWlcGNbw5qzEWAaMiW0X2ePdlz+oGZw==
X-Talos-CUID: 9a23:MrVohWEl8iCMERVpqmJk6HRKWccfY0HG4yaPDhC3CFQ1aueKHAo=
X-Talos-MUID: =?us-ascii?q?9a23=3Aov/vdA9PGgTLxZ5t6FsOPDyQf+lmyKKANwMXrZY?=
 =?us-ascii?q?LspjfKyVPBjKMqzviFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
Received: from rcdn-l-core-08.cisco.com ([173.37.255.145])
 by rcdn-iport-4.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 20 Mar 2025 09:38:19 +0000
Received: from alln-opgw-2.cisco.com (alln-opgw-2.cisco.com [173.37.147.250])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by rcdn-l-core-08.cisco.com (Postfix) with ESMTPS id 33761180001EC
 for <dev@dpdk.org>; Thu, 20 Mar 2025 09:38:19 +0000 (GMT)
X-CSE-ConnectionGUID: MO09m6HLRIC2sjfnb/uXzA==
X-CSE-MsgGUID: RqidhNrZS4ahAL9vpZROLQ==
Authentication-Results: alln-opgw-2.cisco.com;
 dkim=pass (signature verified) header.i=@cisco.com
X-IronPort-AV: E=Sophos;i="6.14,261,1736812800"; d="scan'208";a="19624665"
Received: from mail-mw2nam12lp2045.outbound.protection.outlook.com (HELO
 NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.45])
 by alln-opgw-2.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 20 Mar 2025 09:38:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AIgoMbeNXjwm20Agc3qBrjxcolB4dapfLm11ZiMBJnm8IPu49WTbp2znrQ7OjVP473p/RzSa7s0MpTlB0HtX1e7XIPkmiEuQAfMLRuu3nIQZJXe86rB7qZCYkB701BaGejvRffkeIkom5Yo25RuYUTJOZOb36GPSHDmurrzE1v+pZmFM6CwfcXcRE6zKsaCO5goQnSclDULymF02DEXZ09PMOoc7G+Thw064gUZHEOxX5TE2o5wmso3PrdSoIJK1OwlexHsGEWWo3O6/b+C76Y1Z6NrSNVPu1Gf3AAKlhqY4oQtihUat/gogzjbHKZM67x9Kmi6KlOMk1uwuL6LbCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K2Ogc1AEfM/ehgHg7qg91i5O1HdwUp4/T0u7ObXdk0o=;
 b=VLM5wrrkrUytUERl0MHzrgwy39KFpHMkQehowDINrR3DjG5eq+ZxFR9bn3ryYfFerpVbnY9z6gTqyAPZbVVz/jNXEVqkn6jHLlUEN4mh/+ZabMHaLaBYEF4/XuP29CSmCJKkwHT7aDbCgneQW4/5SyYPn2ihdafxUuvpQeXSFDrpHX+rKhDYzg5RR7sDsHTzpeIvLZdYp3q4d7FUeyZL1lm8DPQ01HcTWWWb8foE7+Z7wOZC+ulaOk/v5y5ZGGyOna/Wbs9S9XCovvpushGJFZmebKbJqjXz06vCFG2zudGvHpNmzrsEHscmh3bHd2Q6duAmpM9wSn0SFCABVUco8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
Received: from BN9PR11MB5354.namprd11.prod.outlook.com (2603:10b6:408:11b::7)
 by CY5PR11MB6440.namprd11.prod.outlook.com (2603:10b6:930:33::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Thu, 20 Mar
 2025 09:38:16 +0000
Received: from BN9PR11MB5354.namprd11.prod.outlook.com
 ([fe80::5e9:ab74:5c12:ee2d]) by BN9PR11MB5354.namprd11.prod.outlook.com
 ([fe80::5e9:ab74:5c12:ee2d%5]) with mapi id 15.20.8534.036; Thu, 20 Mar 2025
 09:38:16 +0000
From: "Rajesh Goel (rajegoel)" <rajegoel@cisco.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: Dpdk-pdump not capturing packet for vmxnet3 device
Thread-Topic: Dpdk-pdump not capturing packet for vmxnet3 device
Thread-Index: AduYl47uBAWkTPkqQ9ilcJultX2k8wAVE4SAACPpq3A=
Date: Thu, 20 Mar 2025 09:38:16 +0000
Message-ID: <BN9PR11MB5354FF359EB7E5609CB494BADDD82@BN9PR11MB5354.namprd11.prod.outlook.com>
References: <BN9PR11MB53545D51138B2F27A402659EDDD92@BN9PR11MB5354.namprd11.prod.outlook.com>
 <20250319092753.210e92df@hermes.local>
In-Reply-To: <20250319092753.210e92df@hermes.local>
Accept-Language: en-US, en-IN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5354:EE_|CY5PR11MB6440:EE_
x-ms-office365-filtering-correlation-id: a46e7d88-0ae8-4be9-093a-08dd6792f151
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?1klf6N3NS2LXmsnrNJ0qTkLuxP/6tRnoX6boENgpMIFNRQdbtRJKRjXSIYeV?=
 =?us-ascii?Q?S9qE+OpkdSFjdgaWzHMsVhztpGgn0jO/7+Ku68SuiHCoibfZsd5d9A83bs5E?=
 =?us-ascii?Q?i8YZREl7MrvPtyjiVNPkH07Z8hIL2uDatv1+O8JSLw6zaGtve0Fgb3FTWEJD?=
 =?us-ascii?Q?pDUYZSYQlDi+7VjBgg9p/NlImbrB9obn0IrF5ZmXPmvmxHQu2chQRGbJOe2a?=
 =?us-ascii?Q?2H6UOnwjsUBlkbxOwprm1zoN+YVvwnJbRJpKGKjjTn2WmvAvSc24DPjZ772m?=
 =?us-ascii?Q?/PruHiJkkxQZiHMXDHkPwSdcYY/cy1nNfaOTCywY/PWs0G++N0Nq8AJWLlYq?=
 =?us-ascii?Q?fde9/N5OJlyqosg5hCsWgXn+3B7ZSL5QzxVTP+IYQVnTvIwR7EloIIr+N6S8?=
 =?us-ascii?Q?Q6k0/JOP1B2DhPLMt7N+p+LXZGCI5OpRziskC1+neyO4Yk0MoBovr09lGNjU?=
 =?us-ascii?Q?cTcxLjlEm7s9nHhZ8c6yZANsmS02L2Oheu4Vb2BjsWP+gOsYLcRrSDnJFN6c?=
 =?us-ascii?Q?KLVjGC/P/CwdlmmFKQy9BpaV2Z4jDL5VTsp0RezvcqrNouXjVeG5Wt4/VLhm?=
 =?us-ascii?Q?yEw+KpBOUJYjMjWAfNcr6fR35DNro2VV7ekZ2bE5NRd5GT2ZqkpCtjcUl7bC?=
 =?us-ascii?Q?uDa9nlIki4Kv7Dkdjf6dJdIt+fzWyHBqo70myYO53ZBFB6ReC86G75di2HzJ?=
 =?us-ascii?Q?BTPFkrrs1ABH8WsSeLYdy/5+neVQP+92j8GMl+XtZjBqTep3N/s/mntGgTuA?=
 =?us-ascii?Q?+8AF5g+1rDg1GnkuYnkCdx8wPdkvtUUF7Xjb1IlqrsNPcPzMdpaYbo4bu/x4?=
 =?us-ascii?Q?diaJmm8t+DwShP/ewuCmGhp4eomlr4MhOPIyIR0VrTnh1QW59jkBeF2TnEXb?=
 =?us-ascii?Q?Z81CrTV7Ak/ujn2YD6zkxHuNK2aCj0/VFehdID+1o5CmBFG7/OxFGAyuQqRC?=
 =?us-ascii?Q?vY+7N66PR2ZyJ+Jyj3MRciv5d3E73twD03MIpCLa+Ch65P380AHtCshx0rqc?=
 =?us-ascii?Q?NjJkt6iIQ1kXRuuUAr+aS9uXf04dL4cJ+g18Dqykt1BAcZHU6+0IRYSysJNm?=
 =?us-ascii?Q?1qkjaXk3alN6L+yWxVzDmloWBkOc73SEBJssldL0TdDe5qNBco6MP41NHNGf?=
 =?us-ascii?Q?M8sibNsgE0KW63kzc/ZxQsBafTy3TH5XpBacFzXKuLX6rE4ZxQWLrcInDbLk?=
 =?us-ascii?Q?4jfkhJlq7mUnUP/epJBK9IOaiTYvuuLU/acURXlKy2X4CGFqQ2hGeGviJyBj?=
 =?us-ascii?Q?o0qe65YcQJblwxA0o3P/trfZfYXjUAJbcsL2oEPc6PljVejgEP2faaH6LMFl?=
 =?us-ascii?Q?CYf5UBQ3jTqeV9z++6r3RJ4N2fsUuFaA3aWOAmWEXPFbs2k9boYfOwkUhRDW?=
 =?us-ascii?Q?cXkc4avzV76P1MbJMWqQ7fnFm2QAX2vskLhvAXGcU8XQGUsUyw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR11MB5354.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?rG5S01CQg4w++MSksHOr8jFaCXZWUfCiInW+RpdSahDxnnqLsEWQoADOMiNU?=
 =?us-ascii?Q?eO00r3SciRNWn1nJHkJwi/agYqQnSkM6HHllpQrILGVpOPTXrf34E/bEfmBt?=
 =?us-ascii?Q?jlt4GtfflWpXyISZsMSlMeOUzoa2AI2MgnE31cEZQTylYHei4TiAA61tlkf6?=
 =?us-ascii?Q?LReg66c2mkUS5wpYUQBzOFZyMDhkmwBsIecX91k7V2k0KYXxIhp3oSoX3Eoe?=
 =?us-ascii?Q?e8HrJ/r6Wnnfb5p56AVhPncaDMXzjw9/mHaK2BoJIZS1APyl/aTSW5A1VIC/?=
 =?us-ascii?Q?f6/ESe2ECKLDY2GENMSRvxsr7mIIZS55lGNAGz+tzVYgXdcnWQI0gZqmKMcj?=
 =?us-ascii?Q?gaIs0cFzc5uPvzeNS/BAMz0HqhsNxhakkvTiYTw0N62lGotW7F03Zz/7Iz2x?=
 =?us-ascii?Q?Vy4NUzZO8Fr31FdbcUufWwKrbJ6H3adciCLeqVGYSVH0/5AnQoyrEBUrnWRI?=
 =?us-ascii?Q?WagDD0FWfNUkEj4wZ7N0O2phPYwvzWN4iahnNBXCqDFyKNVXscW0fiZpzlbU?=
 =?us-ascii?Q?q9fWnKuz6ElDkbcxHMgG+QoJzGYrqSS5+Ekg17vJmQ5UMApHFVLUCWCXykFn?=
 =?us-ascii?Q?6RpDbQbTsGVjZf68MGR3i3/5QeyV5ed4BJZKER5vV+JgzGEnUf3p+TvyYSjZ?=
 =?us-ascii?Q?ZdQEc1K/7s7flqjaMyxupvSolqaLjtqeq7ad1OjTnQiG+rpGl67/XhWmKg5/?=
 =?us-ascii?Q?KO8uHi4r1eBQnal+0aOgCe33DFEpcXGv0oleanpnXzN2rvvxuVJmZ9syMqjB?=
 =?us-ascii?Q?MIHaodZmGgswZ4SoXrwzNJU7KdJ/KnM/IBOugzcWKmDIFvFlfCUFsco4vCa0?=
 =?us-ascii?Q?QL63zjl3sfJCiugz+UVaMtKOeVwC8AeI1ROpaO/cRxSXp4ShSYAe4nh3iiAH?=
 =?us-ascii?Q?4/rNxA8sSi+xAHKif5GNLpeZYpaMVPx+Y1E7P4TbaIYPvpEk5yZ78cYW7PLe?=
 =?us-ascii?Q?f24qAj7VeFtbZuNbd/DSLBD4cx/NrwmqLkRj6co4GpkqrmneaUXEnrQ9aCUV?=
 =?us-ascii?Q?OQfIYFaEniIesxdlIXDstuY3uKQxcfl1JX3dYQ53mYXiHCIi+1vN63wCRi+L?=
 =?us-ascii?Q?UFaS+r8hoCcPE4/kXF2lTFzE4/e5oMW28NYUrwVXCY8D6ru0ml0ma4QUd+Nb?=
 =?us-ascii?Q?52Ercya6k51dltpkZ4i1ZR6uO2jMrfvMEecNVtW7wFTbZn9dsZu8CmhDfD8H?=
 =?us-ascii?Q?6gpZzvRLqrhBwiCxglYaDz0Z09CnJwcewsbbAfVB/6yn7jG554WKbDIfKQP9?=
 =?us-ascii?Q?16NB0Zn7WRH3df8z19dbjpYjPxRDWfcZ7pGxlMsGTflpTA+aNKbQ1eiSmiPQ?=
 =?us-ascii?Q?KhV4GNDkBVOlH040hPQ2S5Xa6pP30fTBEt9P848y7AMTu6Sku4kC3vi1mAzQ?=
 =?us-ascii?Q?c9vVVUPqPk1jNPw5/gLrsMaWcWod9z3kkZH/k4qzy+JVjmay96NQNTqI08W6?=
 =?us-ascii?Q?hUruN2Jvx1/8oeAUktRgp7elC9oVw4bPr5j4S9ewfOkI60qyrAlfABLpBwqQ?=
 =?us-ascii?Q?Z+K/3bVD1CJ27oBZNmTAcyiGPaTEEAiRN6+fFWaIiHprKU9z8CaA1sZBIOgZ?=
 =?us-ascii?Q?0J5/QbiY2eI+FK5/eI0o27yO2xF62VdV/n/M3z+U?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cisco.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5354.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a46e7d88-0ae8-4be9-093a-08dd6792f151
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2025 09:38:16.7841 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HTIBlh2Qg+orcDHttUDQwsrbuF9B0PtqesC8x4qZNzzdJsYEoCjxrMxFU0xCvfy4vzkhEJ0DuSKQnzJN6apDng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6440
X-Outbound-SMTP-Client: 173.37.147.250, alln-opgw-2.cisco.com
X-Outbound-Node: rcdn-l-core-08.cisco.com
X-Mailman-Approved-At: Thu, 27 Mar 2025 14:49:31 +0100
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

Thanks Stephen.

I checked this module is not present in 20.11 dpdk version, but its in 23.1=
1
But can you suggest if I need to port this back to 20.11, any necessary ste=
ps I can follow or any dependencies with the new version etc,

Thanks
Rajesh

-----Original Message-----
From: Stephen Hemminger <stephen@networkplumber.org>=20
Sent: 19 March 2025 21:58
To: Rajesh Goel (rajegoel) <rajegoel@cisco.com>
Cc: dev@dpdk.org
Subject: Re: Dpdk-pdump not capturing packet for vmxnet3 device

On Wed, 19 Mar 2025 07:21:30 +0000
"Rajesh Goel (rajegoel)" <rajegoel@cisco.com> wrote:

> Hi DPDK community,
>=20
> I need some urgent help.
>=20
> 1)      Iam running my dpdk application on a VMware based VM. Iam using 2=
0.11.9 dpdk version
> Iam directly connected to the PCI device to receive pkts on my applicatio=
n.
>=20
>       :
>       EAL: Detected 16 lcore(s)
>       EAL: Detected 1 NUMA nodes
>       EAL: Detected shared linkage of DPDK
>       EAL: Multi-process socket /var/run/dpdk/rte/mp_socket
>       EAL: Selected IOVA mode 'PA'
>       EAL: No available hugepages reported in hugepages-1048576kB
>       EAL: Probing VFIO support...
>       EAL: VFIO support initialized
>       EAL: Probe PCI driver: net_vmxnet3 (15ad:7b0) device: 0000:04:00.0 =
(socket 0)
>       EAL: No legacy callbacks, legacy socket not created
>       :
>=20
> 2)      Iam trying to use dpdk-pdump application to capture packets.
>=20
>       dpdk-pdump -l 3 -- --pdump 'device_id=3D0000:04:00.0,queue=3D*,rx-d=
ev=3D/tmp/rx.pcap,total-num-mbufs=3D8192,ring-size=3D128'
>=20
>       EAL: Detected 16 lcore(s)
>       EAL: Detected 1 NUMA nodes
>       EAL: Detected static linkage of DPDK
>       EAL: Multi-process socket /var/run/dpdk/rte/mp_socket_644376_50d5dc=
20612f8
>       EAL: Selected IOVA mode 'PA'
>       EAL: Probing VFIO support...
>       EAL: VFIO support initialized
>       EAL: Probe PCI driver: net_vmxnet3 (15ad:7b0) device: 0000:04:00.0 =
(socket 0)
>       Port 1 MAC: 02 70 63 61 70 00
>        core (3), capture for (1) tuples
>        - port 0 device (0000:04:00.0) queue 65535
>       ^C
>=20
>       Signal 2 received, preparing to exit...
>       ##### PDUMP DEBUG STATS #####
>        -packets dequeued:                                       0
>        -packets transmitted to vdev:            0
>        -packets freed:                                  0
>=20
> This is the mempool and ring which got created in app side
>=20
>             ring <MP_pdump_pool_0>@0x10045db00
>               flags=3D0
>               size=3D16384
>               capacity=3D16383
>               ct=3D0
>               ch=3D0
>               pt=3D8192
>               ph=3D8192
>               used=3D8192
>               avail=3D8191
>             ring <rx_ring_0>@0x102802680
>               flags=3D0
>               size=3D128
>               capacity=3D127
>               ct=3D0
>               ch=3D0
>               pt=3D0
>               ph=3D0
>               used=3D0
>               avail=3D127
>=20
> This is the port output, port 0 is application and port 1 is created by p=
dump and no pkt is seen to be captured.
>=20
> Port 0 stats:
>  - link status: 1
>  - Pkts in:   50
>  - Pkts out:  0
>  - total ibytes: 4024
>  - total obytes: 0
>  - rx miss: 0
>  - In Errs:   0
>  - Out Errs:  0
>  - Mbuf Errs: 0
>  - Q Rx Packets:
>=20
> Port 1 stats:
>  - link status: 1
>  - Pkts in:   0
>  - Pkts out:  0
>  - total ibytes: 0
>  - total obytes: 0
>  - rx miss: 0
>  - In Errs:   0
>  - Out Errs:  0
>  - Mbuf Errs: 0
>  - Q Rx Packets:
>=20
> 3)      I see the same result while using dpdk-testpmd on the APP side.
>=20
> 4)      As per this page, https://doc.dpdk.org/guides/tools/pdump.html.
>       Is this applicable to vmxnet3 device here ??
>=20
> *       As of now the dpdk-pdump tool cannot capture the packets of virtu=
al devices in the primary process due to a bug in the ethdev library. Due t=
o this bug, in a multi process context, when the primary and secondary have=
 different ports set, then the secondary process (here the dpdk-pdump tool)=
 overwrites the rte_eth_devices[] entries of the primary process.
>=20
> Thanks
> Rajesh
>=20
>=20

Try dpdk-dumpcap instead. Pdump is limited and will not get any new feature=
s.
I am going to propose deprecating pdump in 25.11.
