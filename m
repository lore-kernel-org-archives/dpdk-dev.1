Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7362FC021B2
	for <dpdk-dev@archiver.kernel.org>; Sun, 23 Feb 2025 13:03:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 424E8402C2;
	Sun, 23 Feb 2025 14:03:31 +0100 (CET)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2044.outbound.protection.outlook.com [40.107.243.44])
 by mails.dpdk.org (Postfix) with ESMTP id 10822402C1;
 Sun, 23 Feb 2025 14:03:29 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mA8/3dz8Fg78pSuBbtd+FyGbKXz82mo5BM8PBVvvKNAFTr0ql7Oj3qbSnx1sHJl9kbShAWzKnZA6o3oNC7sdO9y/xG1VN16tZUFPohVoH5FuCcOD5NfM38MQbEqKVXWk9NRtYot39HQE8x88MSjVN2CsZBDxJbW2ByAAW21jPCyr6AqVL0YW4eqQhJusQxsPCJjFwR0QHAjyp1iJCw3EhRwcjLXd2ze7f45ic50zR6/jNUyHqbGmHKwCGnagizAH95dU/z7uY0zO8A3drD/NKNjlIoKjQPJozBbu5p76OBgi7GW0u/gAtsg5a5DDYyFMGU1HYw1mydXyIFBHg+FlHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6yyZ7bWEPell7r6tj1nfkHKaKJZEg4dd0TLbrkl+jJE=;
 b=BW+YuYXa4NIqh6IsVrSsQfS467RlGvkC2TnmqP5Tsos8xO3mKeksbx2bFXnJ9KWq5rUXNN06TZ1hkCWOypUPawmbQmWipCSUL6EdtOeQ39+CuU70UFZHOX5WnXwi7Oo2VUFBM2tpe9y7g86CVTdQZCLnpvtYYs4Y/wVTOLAvtnNY9m0HY0C5O5omFCNDIAiDGE9LL+Qsf0ZQGDeWpfxG3kNhhDn7IP3d+vLtw2Nxkbtl+tnbdxRs9t3iwFmlw5KU5LGwQrMdmUKUClZ7Gl68qd0BSbNBomw+cRwl3vQgajZiiaVAqUHFTNnh3v4bIFCrNbKXNZLWpzedaQwW+dpsQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6yyZ7bWEPell7r6tj1nfkHKaKJZEg4dd0TLbrkl+jJE=;
 b=C/fzcTPYP4+w7Rt1kQwc1LwiqdHY7oZyydH5S6gLQJRC9mQoKuoOcp3j6R9hxi3f9eL1kJdCvhJ31CBGUJxDLel7zx9gE/JLTk+5bkPD16lGqfwVpujXq6len6lcF0kcoDYC2mq6njzMcLdYzag0u+enuXdhsFgJ8op9bt+srv7Dw5sU0XMZlaELa2iICbn0HMU3Lsbds1nW5yflSg2POGfrHIB+CVDYibx5uQgzMu7csk/oTNv/Y+BMOpwju1yI455QfIOXuCiQunPtXMjXtLoNXS/FKO5wMokquQGy4PbGopox4hIfPFjQNMiZiJBmRUJkEZIdOdqoCWoNlSdHSw==
Received: from CH3PR12MB8460.namprd12.prod.outlook.com (2603:10b6:610:156::15)
 by PH8PR12MB8432.namprd12.prod.outlook.com (2603:10b6:510:25b::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Sun, 23 Feb
 2025 13:03:22 +0000
Received: from CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5]) by CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5%7]) with mapi id 15.20.8466.016; Sun, 23 Feb 2025
 13:03:22 +0000
From: Raslan Darawsheh <rasland@nvidia.com>
To: Alexander Kozyrev <akozyrev@nvidia.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: "stable@dpdk.org" <stable@dpdk.org>, Slava Ovsiienko
 <viacheslavo@nvidia.com>, Dariusz Sosnowski <dsosnowski@nvidia.com>, Bing
 Zhao <bingz@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>, Michael Baum
 <michaelba@nvidia.com>
Subject: Re: [PATCH v2] net/mlx5/hws: fix fragmented ptype match
Thread-Topic: [PATCH v2] net/mlx5/hws: fix fragmented ptype match
Thread-Index: AQHbUi/77V/je5leBEuslT1rhLpYIrNVQi5k
Date: Sun, 23 Feb 2025 13:03:22 +0000
Message-ID: <CH3PR12MB846020851648AE037D715C7BCFC12@CH3PR12MB8460.namprd12.prod.outlook.com>
References: <20241219160158.897255-1-akozyrev@nvidia.com>
 <20241219160553.897489-1-akozyrev@nvidia.com>
In-Reply-To: <20241219160553.897489-1-akozyrev@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB8460:EE_|PH8PR12MB8432:EE_
x-ms-office365-filtering-correlation-id: d0cc2bc5-3b26-4535-831c-08dd540a73d9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?ennFrq0MBV+Rl0hjthBfucNSwS6YxdwPPfMtwQ4Sm77xT9/Gq+NhMD4GPa?=
 =?iso-8859-1?Q?jhFWneU2CT5qlAPmOQdRGrxtFDdB3UhG+BN8tjIcU0H+7sxm6i3u5RysZy?=
 =?iso-8859-1?Q?hy3opTjiSKNssWHk1a8Zw7jtR5sgQf5e2Earohvfw/0hi9sb6UT+QAzlCn?=
 =?iso-8859-1?Q?nmTFfghnoaHvF6BGPp1HLrl7wUFdJlnPcQdjRRpAyaBcgIz1vZy0n6ReTo?=
 =?iso-8859-1?Q?ZyUfepVGZbKkanPcRdlN94498c+fgYJnY/lhv8q4WAuwUiVQbdxA3lWyBO?=
 =?iso-8859-1?Q?unDojnrgT8ck/TzVzeyo37mkrA44aeQha0da8XuxjRPrJDnOP4mTLAb9A5?=
 =?iso-8859-1?Q?YmwA7qnJjKxpHGAZRTq14jFamCc4yfxJ6D/r/zdt2WxJRXzfuyhvcoGzLK?=
 =?iso-8859-1?Q?VBjIgA8iMHEOHVBb/RNqCrMXCNXxim1GSrxWuMZTYLc1BJ5R+UqAFdLSxM?=
 =?iso-8859-1?Q?JAlj2LhPp4KAFTxrehLoOb4FvhLAeXxMvAQFqi01/Jwc91dqItozzOXqEw?=
 =?iso-8859-1?Q?dyKvUSTIKkdSGNOavfvc5vkUCDq5yATzua3Gh3W7YrKbVJAAETUoBcD6Y5?=
 =?iso-8859-1?Q?FXHQNFmscdBKQiB3V/avhs2Behjmd6jLFICRArQ+C6x78Y78+bM7nKLMRG?=
 =?iso-8859-1?Q?Kqf1fqBHoEy0hraT9KewfAY5aN+Zyqglmy7mh52mwjCmrUBC4naQUr6oF7?=
 =?iso-8859-1?Q?p0EjY4byZeRJsSt5dpalKe8uQ1M3EnOnHX4ef+mUDUkVR8LpNENurgoehj?=
 =?iso-8859-1?Q?GFTzqN91CcVd7I3M5+s8vkjG7mPIUbTTcRyMRuPYKdW6evLeD7wpHsy687?=
 =?iso-8859-1?Q?51b0MYDz6yfa+KOoQlctFwTJ2kkb+uqgWwB8HaLRgkgyLt/eCGForxOhIm?=
 =?iso-8859-1?Q?HoJo1scXkjBYISyrRYFta4a09NsNkKzk8odEAXxV0GqU/txBsv3/G6JvO+?=
 =?iso-8859-1?Q?QmIlfd5oITaOH8ggW+CCsAsWM/3IbO5njgtU4WOV/AETvNgWPi1l2A42jF?=
 =?iso-8859-1?Q?KSZy3QGKadTgapEI0S0S16Kamw7Ep8AejcECn1O0GeQRYxEBjwqHRsEoRm?=
 =?iso-8859-1?Q?DnpTKjpnHRdLi4RM2eV04GN6vjAIpKNSfIS28DcgIsaKJzQahQAPyF2yf/?=
 =?iso-8859-1?Q?XxAKl7OPzY5eEdI5sz6xisfKF8qbE4k+lJuJsQ/7DnhzRrq8EVQc8/8Uob?=
 =?iso-8859-1?Q?w1Cd+U2VuqGLOxcDc14XoHZlwew2zZik2yW3Ch2VeEFi/sMqYqrISQ4cPL?=
 =?iso-8859-1?Q?Z+aYmM/opO5WJofR80z74L81um6ssXoMvl0tvi59xavtaXQk/Jadm9AURD?=
 =?iso-8859-1?Q?ZlfvGSiZd2Uyhz+QmAo41yByCGqITIyWe66+sxhAAwwx7YDhnIxyRS36Z4?=
 =?iso-8859-1?Q?sBKa/WAISVf4JARq4+kzI7jVwEQDvsvXbRmVEYBhXYdP8sS9ZH6X//XAjn?=
 =?iso-8859-1?Q?cbNjTN4JnocZ5HVVezoRwV4qC1NYv6hQtLyTuzJ7QRtOViUa1pt5OapOKn?=
 =?iso-8859-1?Q?WfQrDYo50zvt/P/JbQtP9g?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8460.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?TZ9eoNXUdvplh6XZX7JN0Kf8FJIbrH20L/35XpHhKUezsFYBqPVTeL/78J?=
 =?iso-8859-1?Q?4+Du8IDUSE8T6KAyqUP9YqJZsW+vk6y1Yhy3B2V+o0JSkHx/cs5MhBbjiG?=
 =?iso-8859-1?Q?cZeD+HbpsDtg8zzfZfW+zqi01iWNyPVCpLFV8sH2C23kDIabEoggzU4c54?=
 =?iso-8859-1?Q?8/CcLBqQ4ookeaNSfT5IXlh2NWP7b3Nyq7gNR3r0kZzX1zgYJeU04mWDCO?=
 =?iso-8859-1?Q?MvjBllxIbe9rVASQF7ReKoeG7gptxGtoQqNcZ1Tca0e9Y5C+F54JKuilJq?=
 =?iso-8859-1?Q?JZaObTRPx0t4QJBT2YrKm0Mzgck7+/X5KMjuY/JyYYOEHrNErP8XgZJI2X?=
 =?iso-8859-1?Q?mnxGTESZ6HrCOgj8hMVN0d4Iv0fg6vajtvKU3S1hKHcv8tw9Yk03N5lmCq?=
 =?iso-8859-1?Q?D19eYk3Xdhhh4lXrCgdSTbFzwFms+vC4v6e/7s2aT5oG0LDfIfaj+HuaFW?=
 =?iso-8859-1?Q?C6mYPtIq27CwHx9flb68qXty44w0AoX6fvMtOV68rwbkaNI8qiPKwklmO3?=
 =?iso-8859-1?Q?1Khck4JF9QhITm/dqUtJIaN26mzpI2WlzejT18ua75KcfonAXPLl8O5osq?=
 =?iso-8859-1?Q?34sY6v2bg3bQkATRvgt2TdHshoYtFW9vtDGpjIL2evj5eO6mJzFeLG8yEY?=
 =?iso-8859-1?Q?eA09ONymKdSKC6+wqoYubTzXjuvpjEYYwnOUcT23uFB++JrjG49Ohg45s1?=
 =?iso-8859-1?Q?pobAY8So7nsHY6/q3qxtaj3b4K4f0hX/wvnmGZRG4T06JXwWgpJCD+wU+r?=
 =?iso-8859-1?Q?NQrbX1zB9Xb7fUbFEtgH+XPrH9l7/WtiD1FMwU/CzH2nduooQSK5Km9SEG?=
 =?iso-8859-1?Q?kCNHcVU0n6VegA1l6wmtygMn+81ogFjfMuN1Wj3Ea/PIBZvw4zOxhcmKe2?=
 =?iso-8859-1?Q?BH4Uv6PzB++dbRtinqjsiZQLveP9kIgIqlD3ya8ANFI5g8BncpXBc9CL2b?=
 =?iso-8859-1?Q?P/Ez8LmRVUlee2TMEF9DrMJNIRf6KVnglWqP823XRTnXQ4p8V3akC0xeoh?=
 =?iso-8859-1?Q?P3Oiin7EHY/aJ4aYgKZ82S1Mv3CPi8UcKv/LexfGSFf+f6ZDIlfXX5OxIx?=
 =?iso-8859-1?Q?6l/agctoTx1onXEi1UzR4H1ftdU3bq0KJP4JDGEx/Hv5j3sigFNX1lVgLO?=
 =?iso-8859-1?Q?Vutex3exYPomGEBZ52r1tj8rsqaIhshcp9xSwkQSXh2PhlS3iu/wFGpXgC?=
 =?iso-8859-1?Q?5VVgDe+r3/yGiY2iAUK2rKaKnv/H8H8OR0XeZiEgkjGQJNDxg15wmT651+?=
 =?iso-8859-1?Q?I5BonNJDW4E+vt+/W6jzUBsPvXCo3Vh1OysRyMEdOpqhevI0khp7Oomw+q?=
 =?iso-8859-1?Q?HdsjufO4llGYVVyh+zBdHXoeeSEviuTN2/p5YNNpVKuk0xhY+ZLa0NkTLi?=
 =?iso-8859-1?Q?1pzl1jyZyOYV9MxDKj7qL6QtGnu3tiLxCNUXb9asE7tsgMYZV+wrdHGbuJ?=
 =?iso-8859-1?Q?JjMrHIFZdyd0wAo1ztKXGqTSBcnP354nLRt/LIpg/4CJ8yD51kNMa9CqgG?=
 =?iso-8859-1?Q?8bf/T6kO76esWOH+OXwbt9fajqY4Y1O1CN1gA8UontDtgZXkBLrOf0HCvg?=
 =?iso-8859-1?Q?YbZtYHvFZx84Y9yyN/SOfk6RRICNZ4c4xV2GDBMul8o3QbexkWZfUjAoUH?=
 =?iso-8859-1?Q?KWDHMnH4zuxFw=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8460.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0cc2bc5-3b26-4535-831c-08dd540a73d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2025 13:03:22.6326 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fA+5Ktek9WRiHyeTafvRBsPdT0MdDfBxOFh33QUd2Rpc4bEXIhjcS/nvuYnklFvMN6jIQSk7yG5X+nkKLmdcXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB8432
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

Hi,=0A=
=0A=
From: Alexander Kozyrev <akozyrev@nvidia.com>=0A=
Sent: Thursday, December 19, 2024 6:05 PM=0A=
To: dev@dpdk.org=0A=
Cc: stable@dpdk.org; Raslan Darawsheh; Slava Ovsiienko; Dariusz Sosnowski; =
Bing Zhao; Suanming Mou; Michael Baum=0A=
Subject: [PATCH v2] net/mlx5/hws: fix fragmented ptype match=0A=
=0A=
Fragmented PTYPE matching requires setting the mask to the exact=0A=
RTE_PTYPE_L4_FRAG value to avoid conflicts with other L4 types.=0A=
Adding L2 or L3 types to the same mask should be allowed,=0A=
but there is a check for the exact value for setting the definer.=0A=
This prevents the fragmented packets from matching in case of L2/L3=0A=
mask is provided as well. Mask out L2/L3 types when setting L4_FRAG.=0A=
=0A=
Fixes: 761439a20f net/mlx5/hws: support fragmented packet type matching=0A=
Cc: stable@dpdk.org=0A=
=0A=
Signed-off-by: Alexander Kozyrev <akozyrev@nvidia.com>=0A=
=0A=
Patch applied to next-net-mlx,=0A=
=0A=
Kindest regards,=0A=
Raslan Darawsheh=0A=
=0A=
