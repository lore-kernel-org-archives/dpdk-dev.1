Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 365B2C5AE59
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Jun 2025 14:32:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DDE2140281;
	Thu,  5 Jun 2025 16:32:47 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazon11011036.outbound.protection.outlook.com [52.101.65.36])
 by mails.dpdk.org (Postfix) with ESMTP id B436E40150
 for <dev@dpdk.org>; Thu,  5 Jun 2025 16:32:46 +0200 (CEST)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=EfH4cyabUGVOXzGHalx1JY+8uhP1btJDJj4Ii+14sAn+DVoBuXWc6+6SfoMMLMpul3PGu40v0oZuZUvqQb+liapoxm7rwqSfSncZXI+aJXKaUVALwIHvLMJbs9ALd3Ilk051VWVNU21H2WTqbXJ3S+tgEN7tbiX5/BBeTMEhV0htltYcIPxYyaWrdBC9HhMhGDNvf7UXo0Sp/AemukTTttxG2eUHOpxvOefWCXdwwThv/PbCbYBGQMzKIHq/AwHKdK5oFB4O1Z3DtKXI6u1ZJBVNc/IfFyvnkEWboDZDOIhbeeDQqcKM5DTVLEQqKHvHPf4C87cDrgXDN2Ar42MXiA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2YhcrtqzObuRuY6s/eY4cupnSYCRWHG2t1j2ymaP4ss=;
 b=nNoA/Gpl9uQe1c7ArRNNZW6gZD6aQ2Mg1XpQYloPgsZL/2Ido8L+9j7Q+EBvCOqkbhYxYiMiXY0AfWog4gokup5X+gilg8/NU71jN0jYpnyulNqS7A/9TkwRwWi51eYrowGMbpK8e99L0wkGXQOodc08KFwJBi3sjgmH3bDNZmiNDHI5wb62isyXPQYWjgiffqwLrL2E/a37NTnMvbzYSwix8AX+/3JomUltSNyN4WjE0+7SAHVniDPntVsdgvZoJlBneN5EnxPFVeW3qrEDRkgQ8B5WbNEOCu77Srv0j8GZqL5Bpu0QlDeUWQFdUSu/zXyKzAFQ4504BqCzfRwtDQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=intel.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2YhcrtqzObuRuY6s/eY4cupnSYCRWHG2t1j2ymaP4ss=;
 b=ji1NTjN6ROrLu0uT69SIZROGQAnAg+76wxWfi5AplS1aTVghFBvozVbfL8XVYt1qeNcDgU5f0+eA5WkW2XFX4zwO9RwAS5VFM5T0ConSjTIwCFdHclYrg1kX+N108hdvUZfFFH33vPZCpDmlakq1Mcian6qUmEERotaytZED0JY=
Received: from DU2PR04CA0087.eurprd04.prod.outlook.com (2603:10a6:10:232::32)
 by AS8PR08MB8657.eurprd08.prod.outlook.com (2603:10a6:20b:565::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.20; Thu, 5 Jun
 2025 14:32:43 +0000
Received: from DB3PEPF00008860.eurprd02.prod.outlook.com
 (2603:10a6:10:232:cafe::4e) by DU2PR04CA0087.outlook.office365.com
 (2603:10a6:10:232::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.23 via Frontend Transport; Thu,
 5 Jun 2025 14:32:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB3PEPF00008860.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.29
 via Frontend Transport; Thu, 5 Jun 2025 14:32:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X7ilB+bcZsbObE9NKoO94OspI0LIDE2Lmk4ucFQscpSeHiCkNg5rCxKdTcOWDdU65xErY15Ty5GDk2h5fe/BvGTX2yLpJlwBgDb7xxeKfKcahyvtAK2S2DlV75J42En1gLLeosk5g1iWkBL1TdO30+IYnybSvdSKvy/Zz4pKeAJa9F38M29E66+qiBp34tG35GlY674yqwem5kEvoOTBqxFzQ7XbIfY6Mi2vKrfFqLhsVLa77YtmYdnPMB6eQl7+fKWqxVWQr4HzIEsgG7e9lyVm9WxvzrvsFt890/wJ/KZxaKbNifNslpHXJJe2cd7eNv/bnpHVhgNTgk9OnUN1TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2YhcrtqzObuRuY6s/eY4cupnSYCRWHG2t1j2ymaP4ss=;
 b=wK+5issAsymhFvr9OPRt4KfRCin1jHgGK/sjNj/XdYYBI/YqMpl9akFI6PJveTYp0knfPLIwBRohyae+lLVLb6oKhSDN9LV3Svzzt+490zwyOyLU/PJIeDDdbfCNrSpAUonk/Y2GnxlQMKYtYeaCeQVX7VCe4g3KuRilUrPDKR761qg9mVSoFwPbvomfi2H2Vd8VwWaSyNxeYRn8Ho06UWDtJGYCeT81T1Jb3lXtkwflca+weFCP7Bu5hOWFDSf6c1eAyigs225diMBMEcSnB3GMO96bwr1d/66EjXshUkoCXJBFtteEpGQhoi+SbyHE5hQ8NNxMKA5nxAhVYV6C6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2YhcrtqzObuRuY6s/eY4cupnSYCRWHG2t1j2ymaP4ss=;
 b=ji1NTjN6ROrLu0uT69SIZROGQAnAg+76wxWfi5AplS1aTVghFBvozVbfL8XVYt1qeNcDgU5f0+eA5WkW2XFX4zwO9RwAS5VFM5T0ConSjTIwCFdHclYrg1kX+N108hdvUZfFFH33vPZCpDmlakq1Mcian6qUmEERotaytZED0JY=
Received: from PAWPR08MB8909.eurprd08.prod.outlook.com (2603:10a6:102:33a::19)
 by AS8PR08MB6248.eurprd08.prod.outlook.com (2603:10a6:20b:298::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Thu, 5 Jun
 2025 14:32:10 +0000
Received: from PAWPR08MB8909.eurprd08.prod.outlook.com
 ([fe80::613d:8d51:60e5:d294]) by PAWPR08MB8909.eurprd08.prod.outlook.com
 ([fe80::613d:8d51:60e5:d294%7]) with mapi id 15.20.8792.034; Thu, 5 Jun 2025
 14:32:10 +0000
From: Wathsala Wathawana Vithanage <wathsala.vithanage@arm.com>
To: Bruce Richardson <bruce.richardson@intel.com>
CC: Chenbo Xia <chenbox@nvidia.com>, Nipun Gupta <nipun.gupta@amd.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>, Gaetan Rivet <grive@u256.net>,
 "dev@dpdk.org" <dev@dpdk.org>, nd <nd@arm.com>, Honnappa Nagarahalli
 <Honnappa.Nagarahalli@arm.com>, Dhruv Tripathi <Dhruv.Tripathi@arm.com>, nd
 <nd@arm.com>
Subject: RE: [PATCH v5 2/4] bus/pci: introduce the PCIe TLP Processing Hints
 API
Thread-Topic: [PATCH v5 2/4] bus/pci: introduce the PCIe TLP Processing Hints
 API
Thread-Index: AQHb1A8LVwjtBj2HM0KwVaHXGcaVP7PzOp8AgABXn0CAAKK3gIAAcAkA
Date: Thu, 5 Jun 2025 14:32:10 +0000
Message-ID: <PAWPR08MB8909292833451F5AC40AEE289F6FA@PAWPR08MB8909.eurprd08.prod.outlook.com>
References: <20241021015246.304431-1-wathsala.vithanage@arm.com>
 <20250602223805.816816-1-wathsala.vithanage@arm.com>
 <20250602223805.816816-3-wathsala.vithanage@arm.com>
 <aEB6VEFCKr-2t11p@bricha3-mobl1.ger.corp.intel.com>
 <PAWPR08MB89092A3A53CBFA874B1AEA729F6CA@PAWPR08MB8909.eurprd08.prod.outlook.com>
 <aEFMU-aeau_WOvCQ@bricha3-mobl1.ger.corp.intel.com>
In-Reply-To: <aEFMU-aeau_WOvCQ@bricha3-mobl1.ger.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic: PAWPR08MB8909:EE_|AS8PR08MB6248:EE_|DB3PEPF00008860:EE_|AS8PR08MB8657:EE_
X-MS-Office365-Filtering-Correlation-Id: 96afb2a6-6c30-45ca-f7cf-08dda43dd4b9
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|366016|376014|1800799024|38070700018; 
X-Microsoft-Antispam-Message-Info-Original: =?us-ascii?Q?qHmSXUvtHediUKXbp/Mbz9xB5U3TKNIGg7zGjRgRZsOSQPNdaQ2uL4X4pnxl?=
 =?us-ascii?Q?an7JjxJAgQEgjjowGpcS1sjXkvO0Bg4Gx+6ITwop1QDux5QpYkeS/mL7qxUi?=
 =?us-ascii?Q?OY2ugDO6xT5aaju6IlpkrX/lBcBVPqPsdvzTIR1aA077wUqzFHcM4HfLosUY?=
 =?us-ascii?Q?HPndY5FQOdWE1Pcqi243Ay2VQsiVk6eKH5KDq7TNTOKDYp3VKuLsvyix5Sb+?=
 =?us-ascii?Q?XFnDIdI7cOf/rY4Qc92Nqmy1nhxc9zGyE+DJKT3Tg5sROT/l51EKMTOiP2Ra?=
 =?us-ascii?Q?RlJjecRKBgJgZDEnHeHm0q8KMAP83Fb0tL/o9E72lnAJ8DvtiDl5rpYt6XmO?=
 =?us-ascii?Q?QG3al7JruuIZ12fiSV5++pohRH6F9L8MJ1XiVKDisikv21TB6jsBgQtmfJl1?=
 =?us-ascii?Q?4L1fZ5kF7GRqfVER7+kF+rxEhuVgJmrTn5MbvlQFJaHeByPKMdJydSI3zJRW?=
 =?us-ascii?Q?jdnB+ysUiAEBZRYTXJgvYj//2N36qnu432eiX1xvnYecPU49/NZn1gRlhr9B?=
 =?us-ascii?Q?mHAf2JbZ2hk8yr0eIZjBGtiLHiYb3Di0T2hGck4C5cuqDBjUAeMJrg//FitG?=
 =?us-ascii?Q?QltSHdktbZqkf7cWp24SzqGiZrXfXWZDRvfZeMQNZfVlrvRsah1uQAbOdiYZ?=
 =?us-ascii?Q?LmgbxvSK/T8CHLVspgcZDY3yG0HePkF6yn4BmDreW417IywVUT4QOn2LMiZJ?=
 =?us-ascii?Q?bIMc1cwIKrSymix/xIcCWfcnw8H3rbRcKNMSqWaqtObr7d61MtoM3knV/9Z6?=
 =?us-ascii?Q?NDhAiJNiPIbr8eZFP/z6XaoNjldSu4DaxnGvup3fSPT9SG07dem7CISObye6?=
 =?us-ascii?Q?mkzGmNjxE0BNxfEyJhAcH1Txd/pP/nlpFOcTHKoeAPoJEPunhOHuz9Soxzzv?=
 =?us-ascii?Q?nF3QLdNVU13bF1afNUGnrL12cFyHMVdW+n44oo7GioQQhl3c6oQ7JD5E57KO?=
 =?us-ascii?Q?H+gnRCcDzVOGpL5/72nd0XHV0TGHl9omrQM+A6ebYwkRK/JNzhwu55XsJlLM?=
 =?us-ascii?Q?D0Z6Aqey13Ug8ezxfnwG3eVfd5FgsN1NytfJmISuW4sqyvBUHPOSpw3xBm2a?=
 =?us-ascii?Q?VHrxDN5ADHdaenXKh7PBJBU74QDzLZEA4Deh94OPNJy7r0a/U842kY0jfUlC?=
 =?us-ascii?Q?aWDVwpPwGWgStcNi+3FQrh6KerFQqTgyqzEO1ygyaiQAZq556PnkOz5HvcHp?=
 =?us-ascii?Q?hg1QPKp0HltR0FGlEELC5JYuddgjz2oAcC8vHXT1dQNHbS1KjutWanhHcUVW?=
 =?us-ascii?Q?bZXMPPCjheiZ/CVbVC68XyVJdSbqDC0nWZ+SuIRpTIlNIe3jPIe54G5IrSTn?=
 =?us-ascii?Q?RsGQUQ4GzZ9MEQn7wdMkAKh7MGppBY8I0ACa8MU+uC7TNxVteKv30nIuhJJR?=
 =?us-ascii?Q?Es6kdz9e0swf54LgKkvuKSJmjSHA7ufKl+QnDRshtoYtXFH7+fOJBCLqDy87?=
 =?us-ascii?Q?lMShETYigCQ+7TBEyHHrk3C2AmFP27Cs23EhVhVBy2VFoiI3kZ0xPpnGgxs8?=
 =?us-ascii?Q?Xhnf1fFORVt3exg=3D?=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:PAWPR08MB8909.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE; SFS:(13230040)(366016)(376014)(1800799024)(38070700018);
 DIR:OUT; SFP:1101; 
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6248
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB3PEPF00008860.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 485e78fb-73aa-4ea3-886a-08dda43dc1a5
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|35042699022|14060799003|36860700013|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?GbDUyItS4EGsudvCFyNkW+Hj4MEHTeetkpd6ZteWl/wOqnrZTEzYXVnJH2CE?=
 =?us-ascii?Q?NOZU/eSFA+aw1AK+H4zzGrM58KlaHaCYAfrUb98zhV6x+dbZX7beNWveZZpr?=
 =?us-ascii?Q?GyA+AhHvidoKyahKlswLG6aiRFDUw5p1dy2hmf0qjtlJ0X08oh55MkHg710z?=
 =?us-ascii?Q?9VBt/gJMKNsj4a5bZlgUXBe9Rp6PCN47ZbKvnI2WPKKxBw0iRWknjctrOsxg?=
 =?us-ascii?Q?l4Y/Ggle+YdlG0c7NjHuxXQGls3KxcTHagtiF67OzB+SZfNQ629KFAYbJxkY?=
 =?us-ascii?Q?Ty8lo5fn1YKUglbkUZAmlFsmQc03JrgqhGF6ENotG3y//Wui8rwBqfhOf0ZL?=
 =?us-ascii?Q?tDzmqm1GLEdGZivzpPjCkFqdW0AOC4MHJjiWxv+bxqJ1ZzML/tBIEhdbIOg1?=
 =?us-ascii?Q?A/ddrt/YFL55CqH+VDK3mD6/PUdhEKtq8is6nvIsOooKwpOwdZirni1HLR/4?=
 =?us-ascii?Q?6FaCQ1vWwVrm1EUorIRU05aXPEw/ZdQl8lXCIgge22q0MFi3wE9LxLTNcFan?=
 =?us-ascii?Q?C3D+NMa2vjUFyFWfGKMyP0KGmJJzDJsdmAktjqwOt0KQNNsTMu1aTGt2X6J0?=
 =?us-ascii?Q?Uh+RiXNwjy98geYFeUkiKGA+4rbv04afMdfXwrUwCyXQqsZlpnlIPk2+DPR3?=
 =?us-ascii?Q?EJM37WAKu24luf5/htZ0EPKntPHMdi3XT6pLDw31PeiO/KxU5o2TYXHzYTit?=
 =?us-ascii?Q?pb7u6JscnPgZmSki6JjXopTHa7wJmguM3LnlM3Sz4xSKHEB0OckGyR8sepXJ?=
 =?us-ascii?Q?OkgW9gMIi7pOrkReSK+Sp+/H9TAn7Tru7l8JZ2NUh9PNQYIlOqr9+WiisAYF?=
 =?us-ascii?Q?bTYhADfPLIi/wmsAFL1MWwd0yDZbTPyEF8iCxOWhbRVV+IfMd2XLGSNtpHJn?=
 =?us-ascii?Q?JZjIrS0wAqsZ32UDMk9mne2kly/jFToWpsQJLCvpyH6K2ssl0lcfOjXai1Ad?=
 =?us-ascii?Q?ZSacIXzMPSTfVkHUht6/5Uw3rDTjjzNf7C6LbWzTCGET7bNbP8oqi1y6p2Cj?=
 =?us-ascii?Q?DLue/Pn4UntIlvh85uXHpuapH+wzv+56GzHQRYC0ea1LhV0ZkW6CLeB8c+iC?=
 =?us-ascii?Q?qSmF87WtArFy5gqeev0zNO/K42wDSXC7F730c/4hJdfqLeEFDS+P4wEZTLni?=
 =?us-ascii?Q?1Wq9BaYjF/QHed5D/vv3jmfjX5mHMyMss5WPOEW5g1+I2BeEUrLiuECqc0ls?=
 =?us-ascii?Q?NXCHiLUR4hlHUa+dEgf0evywlBX2BI+bhNjppIKRR78g8kdfC4AwGwKY+ZuY?=
 =?us-ascii?Q?ttQnejNCvSOeOZvDCAeM6cO65D5Jth9UKvtETlc605Pexuy4GTH9n/LBsv10?=
 =?us-ascii?Q?KAd1dvy7QVI3is3+jKX2LPZ1kau8I/MUKDd8kKIeJMqYTK0pEdAHAeyRAWz/?=
 =?us-ascii?Q?D+I7e7rGqFWjTUV1AVsroXlotkmgnnmKuDDU0zgnTZv8vm7EYoh8Cvi/eOxl?=
 =?us-ascii?Q?5+TcF5yGkZlS20p3PsmOUWr6QKoCG0PuHBO6uhCRGLyp3Yv+GioaofNAU7U+?=
 =?us-ascii?Q?9SAYrp2C/UgERnMSxF8X83YYYIPpHngvu4jr16svXQtadWCBgA3lOFtt0w?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(35042699022)(14060799003)(36860700013)(376014)(7053199007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2025 14:32:42.4388 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 96afb2a6-6c30-45ca-f7cf-08dda43dd4b9
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: DB3PEPF00008860.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB8657
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



> -----Original Message-----
> From: Bruce Richardson <bruce.richardson@intel.com>
> Sent: Thursday, June 5, 2025 2:51 AM
> To: Wathsala Wathawana Vithanage <wathsala.vithanage@arm.com>
> Cc: Chenbo Xia <chenbox@nvidia.com>; Nipun Gupta <nipun.gupta@amd.com>;
> Anatoly Burakov <anatoly.burakov@intel.com>; Gaetan Rivet <grive@u256.net=
>;
> dev@dpdk.org; nd <nd@arm.com>; Honnappa Nagarahalli
> <Honnappa.Nagarahalli@arm.com>; Dhruv Tripathi <Dhruv.Tripathi@arm.com>
> Subject: Re: [PATCH v5 2/4] bus/pci: introduce the PCIe TLP Processing Hi=
nts API
>=20
> On Wed, Jun 04, 2025 at 10:52:24PM +0000, Wathsala Wathawana Vithanage
> wrote:
> > > > rte_pci_tph_st_{get, set} functions will return an error if
> > > > processing any of the rte_tph_info objects fails. The API does not
> > > > indicate which entry in the rte_tph_info array was executed
> > > > successfully and which caused an error. Therefore, in case of an
> > > > error, the caller should discard the output. If rte_pci_tph_set
> > > > returns an error, it should be treated as a partial error. Hence,
> > > > the steering-tag update on the device should be considered partial
> > > > and inconsistent with the expected
> > > outcome.
> > > > This should be resolved by resetting the endpoint device before
> > > > further attempts to set steering tags.
> > >
> > > This seems very clunky for the user. Is there a fundamental reason
> > > why we cannot report out what ones passed or failed?
> > >
> > > If it's a limitation of the kernel IOCTL, how about just making one
> > > ioctl for each individual op requested, one at a time. That way we
> > > will know what failed to report it?
> > >
> >
> > The V1 of the kernel patch had that feature, but it was frowned upon,
> > and I was asked to implement the IOCTL this way. Please find it here
> > (V1)
> > https://lore.kernel.org/kvm/20250221224638.1836909-1-wathsala.vithanag
> > e@arm.com/T/#me73cf9b9c87da97d7d9461dfb97863b78ca1755b
> >
> > > Other comments inline below.
> > >
> >
> > I will address them in the next version.
> >
> > Thanks.
> >
> > --wathsala
> >
> > > /Bruce
> > >
>=20
> <snip>
>=20
> > > > diff --git a/lib/pci/rte_pci.h b/lib/pci/rte_pci.h index
> > > > 9a50a12142..da9cd666bf 100644
> > > > --- a/lib/pci/rte_pci.h
> > > > +++ b/lib/pci/rte_pci.h
> > > > @@ -137,6 +137,21 @@ extern "C" {
> > > >  /* Process Address Space ID (RTE_PCI_EXT_CAP_ID_PASID) */
> > > >  #define RTE_PCI_PASID_CTRL		0x06    /* PASID control register
> */
> > > >
> > > > +/* TPH Requester */
> > > > +#define RTE_PCI_TPH_CAP            4       /* capability register =
*/
> > > > +#define RTE_PCI_TPH_CAP_ST_NS      0x00000001 /* No ST Mode
> Supported
> > > */
> > > > +#define RTE_PCI_TPH_CAP_ST_IV      0x00000002 /* Interrupt Vector
> Mode
> > > Supported */
> > > > +#define RTE_PCI_TPH_CAP_ST_DS      0x00000004 /* Device Specific
> Mode
> > > Supported */
> > > > +#define RTE_PCI_TPH_CAP_EXT_TPH    0x00000100 /* Ext TPH Requester
> > > Supported */
> > > > +#define RTE_PCI_TPH_CAP_LOC_MASK   0x00000600 /* ST Table Location
> */
> > > > +#define RTE_PCI_TPH_LOC_NONE       0x00000000 /* Not present */
> > > > +#define RTE_PCI_TPH_LOC_CAP        0x00000200 /* In capability */
> > > > +#define RTE_PCI_TPH_LOC_MSIX       0x00000400 /* In MSI-X */
> > > > +#define RTE_PCI_TPH_CAP_ST_MASK    0x07FF0000 /* ST Table Size */
> > > > +#define RTE_PCI_TPH_CAP_ST_SHIFT   16      /* ST Table Size shift =
*/
> > > > +#define RTE_PCI_TPH_BASE_SIZEOF    0xc     /* Size with no ST tabl=
e */
> > > > +
> > > > +
> > >
> > > Where are all these values used? They don't seem to be needed by
> > > this patch. If needed in later patches, I'd suggest adding them there=
.
> > >
> >
> > RTE_PCI_TPH_CAP_ST_NS, RTE_PCI_TPH_CAP_ST_IV and
> RTE_PCI_TPH_CAP_ST_DS
> > are used by drivers. I40e patch uses RTE_PCI_TPH_CAP_ST_DS.
> > I will remove the rest, added here for completeness.
> >
>=20
> Having them all for completeness is fine. You can keep this as-is in next=
 version
> then.
>=20

+1

--wathsala
> /Bruce
