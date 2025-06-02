Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20BEBC5AD49
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Jun 2025 23:17:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1B6C04028E;
	Tue,  3 Jun 2025 01:17:13 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazon11011041.outbound.protection.outlook.com [52.101.65.41])
 by mails.dpdk.org (Postfix) with ESMTP id 196434025A
 for <dev@dpdk.org>; Tue,  3 Jun 2025 01:17:11 +0200 (CEST)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=dMT63Vt+w5KH6zgqI48RrsWkXwR6Z7m4vTVU0cGkPJ2MJoQNU4ULnHd5CJ3Yj5ZZbgX7+hcSnJGKqqZeeF3GJZwy0zyAVmCpPwtqwC1MTwcNJqeHBDjFNPhv1vwcGSrgsglHsmUNpCwNz9eCzetlLMPM7MSGN42UB+PjsMtvxZUjFqUYUrvTVeCMDaPewRSsxNRfprwiOE2fFn8/Ogcg7VUU/vu5XtjRkYza3uPZ/mXyE7pzJoyv0QnFwLVHIEQzzux9ufQ1cMlK2/e9pz3jaxiUPoT0CEuKuifoZ2shIIyIc3TFj70JnZrvagDemKwLNrfZTDtUOdSHOWTyC7Aing==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MYq2IAqmM/IjuoVBNIXGFXqueH3R1zGyt5PKPkhnS3s=;
 b=WgjrL7EgzCamcwDZxom//zBsd7HrCW/3AkYNZD76HMxf/1u3gUtaynqC1mH0rNVqH7S52AiQcMC5tq4S9gL8RxuwEKwtX74b3an8E69BsJ/Nr7yx4Jk1kuF47olfgqD4uHTVT8KMcZdUP+FdpDS/Vf0RibR/IfvjWvEV+II9jC3iSCdGfvJlT0NI+DHcLKquhMd8VzBflXaQ+iv/z81mDP4LyNSGG6VNeiH7u3gLMXNXOn+v5wOAfAdm3n2sct6chffpmI21YHMGX9OHd/k84rua++fArBKvOu7OzVYnrH3nMaAE0K1/0Fu8ZCV3EMaT9d8DnetY0Fbiv+TrZ5sqxA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=nvidia.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MYq2IAqmM/IjuoVBNIXGFXqueH3R1zGyt5PKPkhnS3s=;
 b=B6UZaRFNhyG1wnv2ro53RLjozad+NPpbb+dqef6jbEs9YE4Xzgg6NS5OB0AayBH7G5EtfhAaCnDsRijGvrkYfaLL//auVdbNB9WxOf0bTSTCVzbWtJOw27SUDyv5ALutydmMuimgLGbTGg0Al5Js9N+hgzzl8LiGOTQkpYsRKx4=
Received: from PR1P264CA0125.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:2cd::12)
 by GV1PR08MB10931.eurprd08.prod.outlook.com (2603:10a6:150:1f3::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Mon, 2 Jun
 2025 23:17:05 +0000
Received: from AMS1EPF00000044.eurprd04.prod.outlook.com
 (2603:10a6:102:2cd:cafe::2d) by PR1P264CA0125.outlook.office365.com
 (2603:10a6:102:2cd::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.23 via Frontend Transport; Mon,
 2 Jun 2025 23:17:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AMS1EPF00000044.mail.protection.outlook.com (10.167.16.41) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.29
 via Frontend Transport; Mon, 2 Jun 2025 23:17:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=igWN9M84TwFBEnuOT7Gl3l9ltDeRe5LgtlUIdWjK23hTnk0JuHnKbnQzq7f/LV3dIfXqW7HnK3SppRVdS9PYlVgs3j6XUoulftz75QrhMSiDg4Fi4egxFTC85b5MAr8b8P3+HQHSUTZgba5Fhr9Sn4EsW6qoDXS75JaS6C3Yh8anQEwaDtOVEhiAPo2VAu1zsRGV8mywe7tGQ6oPY4TIX9CMOU9oMtd5d6K1ZM/RzDh0cnfGfypWPfC40bS8vhLrAghqfGd2KsFrmUjRBM9sG8CQ25C2NsvU6uxJorca9TLGuQMHT3ldq6tZ5jwIEe+aXMZyMG4miXpZJdunkAgyPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MYq2IAqmM/IjuoVBNIXGFXqueH3R1zGyt5PKPkhnS3s=;
 b=hLe0p4btErn5KQAuqbPUNhMxzLdrHTZ3RF0sDIFYtQ5YPfXxYXGmhPEFpm+wEg+pBf4Wjxp4IByVmNCPbkwikQVhb0vxwxCJpgS5i6cZ2RlAqSpmSmtaYC3bRaTgae4r/QHqP8YmnmSvDUqlgWaY8BUnT1lBBymf5rs53OJLP6a4OEYW+KX4JOZ2wzNqzar4MQlEXU2APtuF25HBN7NH0eEmKO+e9g40/zXyKRpMo9Sb+3C5PMwYnWGxKmdWR41IicKk/1sZntqPIj/+QKEBSURYQG8u4xSM6A/2MnxkRC0GCFEZ6W1yMHx42hDeUYY4CMjzoRuhtBIjwNoBhIiv6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MYq2IAqmM/IjuoVBNIXGFXqueH3R1zGyt5PKPkhnS3s=;
 b=B6UZaRFNhyG1wnv2ro53RLjozad+NPpbb+dqef6jbEs9YE4Xzgg6NS5OB0AayBH7G5EtfhAaCnDsRijGvrkYfaLL//auVdbNB9WxOf0bTSTCVzbWtJOw27SUDyv5ALutydmMuimgLGbTGg0Al5Js9N+hgzzl8LiGOTQkpYsRKx4=
Received: from PAWPR08MB8909.eurprd08.prod.outlook.com (2603:10a6:102:33a::19)
 by GV1PR08MB8058.eurprd08.prod.outlook.com (2603:10a6:150:96::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.37; Mon, 2 Jun
 2025 23:16:28 +0000
Received: from PAWPR08MB8909.eurprd08.prod.outlook.com
 ([fe80::613d:8d51:60e5:d294]) by PAWPR08MB8909.eurprd08.prod.outlook.com
 ([fe80::613d:8d51:60e5:d294%7]) with mapi id 15.20.8792.034; Mon, 2 Jun 2025
 23:16:28 +0000
From: Wathsala Wathawana Vithanage <wathsala.vithanage@arm.com>
To: Chenbo Xia <chenbox@nvidia.com>, Nipun Gupta <nipun.gupta@amd.com>, Maxime
 Coquelin <maxime.coquelin@redhat.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, nd <nd@arm.com>, Dhruv Tripathi
 <Dhruv.Tripathi@arm.com>, "thomas@monjalon.net" <thomas@monjalon.net>, nd
 <nd@arm.com>, nd <nd@arm.com>
Subject: RE: [PATCH v5 1/4] pci: add non-merged Linux uAPI changes
Thread-Topic: [PATCH v5 1/4] pci: add non-merged Linux uAPI changes
Thread-Index: AQHb1A8JRtUOnyoET0aK/WKZvcZEebPwfn6QgAABk0A=
Date: Mon, 2 Jun 2025 23:16:28 +0000
Message-ID: <PAWPR08MB890996ED7F3B2420F58E2CE59F62A@PAWPR08MB8909.eurprd08.prod.outlook.com>
References: <20241021015246.304431-1-wathsala.vithanage@arm.com>
 <20250602223805.816816-1-wathsala.vithanage@arm.com>
 <20250602223805.816816-2-wathsala.vithanage@arm.com>
 <PAWPR08MB89093235AD3B7FB8AB6EFDAA9F62A@PAWPR08MB8909.eurprd08.prod.outlook.com>
In-Reply-To: <PAWPR08MB89093235AD3B7FB8AB6EFDAA9F62A@PAWPR08MB8909.eurprd08.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic: PAWPR08MB8909:EE_|GV1PR08MB8058:EE_|AMS1EPF00000044:EE_|GV1PR08MB10931:EE_
X-MS-Office365-Filtering-Correlation-Id: f3b83064-b1a3-4510-9a15-08dda22b95f4
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700018; 
X-Microsoft-Antispam-Message-Info-Original: =?us-ascii?Q?LhmmkMPtJLD9uQRaSvRpeRqbJcOfjpMpcozHaNiUoOOdyd/kzu1OR35zTjEX?=
 =?us-ascii?Q?jmcoVsWYBatMUyf8k/YWiOW+/JIzNl0/86zDxjn1snDWHfpw/T8GfxLvS4H5?=
 =?us-ascii?Q?l43eP+OyE6qfR6v2gMtyjRZwiIFTCBOvSM4riadr7GaQGEF5BTKhZ0y6W3fk?=
 =?us-ascii?Q?oyW6zKhxsuxIekX+36uZS6h65vGlIjO2YwbZELmOlHbUhEWsUzS5G9ryg1qu?=
 =?us-ascii?Q?5sdgtmLMu5rAF9vZwndn464bIgZXFyjQsYIgumb+khE+PT/yiAkUAJ0LjEVm?=
 =?us-ascii?Q?KztYedEpRFIlaFSpiWFGag1eJTpykY6xCov403NOtxr0yXBSka+cXW+EeTzU?=
 =?us-ascii?Q?PkO4miewIiMwrY1dM6TGcBzvPG7tisN1X8OL/whly5aeJ47QBWISu87wH+Dx?=
 =?us-ascii?Q?UOSV/l7OaXneFOAR1avOm1woQjFonQmYY1X9HYA7qXSfblX4hCsTtELpYsqL?=
 =?us-ascii?Q?qLZzHY76QI9x0H2A3P+P7g3am81U7jROOMdPL1sZd53OqzhkmuAh/iI8AyRs?=
 =?us-ascii?Q?okoPWWvkZj22CRwZk8OdWQ7KE3FABYRKYNCikZPIRQotiiSEsOnlC/u+EVZC?=
 =?us-ascii?Q?ZZwRaEtJANAP/E2VXZQT8OWUym2gAbnh3zLVI0EeTFUS051hjVxtiwUKdK4i?=
 =?us-ascii?Q?ia5NiqOgjkyxYhqo7brHfZ82soRYljAuImch8FQOXUAl6SmN0tm+ZwRZdAfD?=
 =?us-ascii?Q?KSAL14jtzLO3o7CWbdHXeG2NsvPWIFTTvnIOTuGbGK+zyvgIKTsrImcK4smV?=
 =?us-ascii?Q?fP+i6JCrH3ZZODAa0sr7G6YrENnL9ieELwXpChlzULMRJqwPnlbTnTMMlV1+?=
 =?us-ascii?Q?kv/XVfYCUXR6uf5sSU1H8bT28iGgPD0L9RgEce/zJaXclO/WifOf+I3p2J3j?=
 =?us-ascii?Q?BxfZWM+brMe7uteOQ5tHTBxImQD99yIcrkdIx5wnHWwwGZDnjyDmyiJHT81s?=
 =?us-ascii?Q?//tpreQRC2QcFjcyKxoI0vwyGm+68Lp94RSYRDwAjtb2M1nXw5J/ATetMVq6?=
 =?us-ascii?Q?8bHenacdtVKBMF9nM2UPNX9WNqGmlyakZ4TpOhZ/PvKL8tkzxDZp4+KMNo5p?=
 =?us-ascii?Q?VCOM8z5o+WPcJTrD7CYRa0wdD4gR9H1HJwUTcwsde5LWSgOYpH/J59//rNod?=
 =?us-ascii?Q?p5G9GvKMh05ElXb4Yj6Vxf2PPjbqKU5affyMuLKiewcJOm0lwKhAKWruoz6W?=
 =?us-ascii?Q?JNzw40Ehmc+ENwhApI4bE3bNnn9ZdSwJII2/+Ga3ybg7IXBZJIZi4TLMpp6P?=
 =?us-ascii?Q?45PILyAqCgDNt7B/5UlV/n01hb5FLeDxlS1NTHv0R2NezJ7bXXRIMdi9qyeh?=
 =?us-ascii?Q?qGthdfTJIe33bHrq/6gzPqNSbODRdQNus/gd8OuhnMdgM6wyu8AOc+fhe/Ba?=
 =?us-ascii?Q?SGSNTrTmXs1iKNmhbn9jpamsfOEAiuSVyMIv0BsAM0VHvHIa8iWEFN/oKO+2?=
 =?us-ascii?Q?l+hpEWx7gcAxcW/H07HK35QvV56HOks2?=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:PAWPR08MB8909.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE; SFS:(13230040)(376014)(366016)(1800799024)(38070700018);
 DIR:OUT; SFP:1101; 
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB8058
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AMS1EPF00000044.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 03835fa8-e113-40d6-d3ad-08dda22b80d3
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|35042699022|36860700013|82310400026|376014|14060799003|13003099007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?veqNyL+pILcmfdVLSJi+joFvM1yOyBq5qNSSDPj7sv7qKjHKDXHrRmIFLtVl?=
 =?us-ascii?Q?prTT4H74oVjeCqmIM0Pf6jc+8TuTZrQ/T5XpQRKgPiRALw2cDo9NsavJ8JWt?=
 =?us-ascii?Q?Jqrz6xic+PTSV3qLLp8LE2jibtVa4/A5KR2+iV0QN+CmqxeFu8RP5IIG1iGP?=
 =?us-ascii?Q?g8QRu+oDmVKDElJdNGSHVA7+9rPb9ZUTLv6JQ3vsyY0JbpIJWsybRCbWazdE?=
 =?us-ascii?Q?vfc73hQo1OfVaujRi/rxPBycs/0swP15R39CSFHjRpZRXmkueogBwBnBEPIO?=
 =?us-ascii?Q?30X8O51wOxn+jIUpGmt4q2fI/Ns2dN34LL7vPHLQHuTA2b3yroLqWdRNd8yT?=
 =?us-ascii?Q?pKXmLDMagGALC8Se9nKkYPt9Zynfvbth/DwCIm2KgaFupvahW6RVdxBoQDwP?=
 =?us-ascii?Q?INTcI/hffnFOaLWAaHT1bbvAhQL/inr9PKj0m7QA9oRpSnk6hNiLwEdsPYm2?=
 =?us-ascii?Q?ivzWZOz5GnlefvCK5W7XNLrZgBqHbEnMUqTIzfV02LdJFspJOn9XdTH7EnlV?=
 =?us-ascii?Q?+g+sSplKuvoVPYSOQjTqGYRLgA+Hvm57gPruA71XRTN4UEG8/R2ucnlly0nr?=
 =?us-ascii?Q?evOTFPI5iffMNxawo8eetTcc5AwxXr5VzL8jxg2eetqZPsy1UER7a2Y0zItX?=
 =?us-ascii?Q?gsn1CrznPkCc8Mi768M5pTKQV3fOBPZTuJYec91GU3bQ/Lz5w2oh1JlhLSsd?=
 =?us-ascii?Q?THY1X7aI9iU16i6+fYtekVFRUnh/szaFwi59WlFRjUQBX48VQ8tVI9yzR293?=
 =?us-ascii?Q?tQZEITJe2ENievRE02W/J4T5at3kyFTgL+lRpSSQsEycL01sMMXQTPUAgWTK?=
 =?us-ascii?Q?TuKjLozQ+2VOp44qZyDw3aXRQn/7ytIiPNShwY6pAmNIz3Uw0goce78aBrDk?=
 =?us-ascii?Q?lwShUniUhmVmQjlcICLV8EkvrfhkQnbReQXU/rTLXFAHvWyHdngQ1880W/XG?=
 =?us-ascii?Q?GFi90gooEFBL3pw9Lrw9xEDDnrY+TJmySjzP9HjvshfYvc3EkMu6S9gR/Y5L?=
 =?us-ascii?Q?Cp+SQFQNau/ZnmPFNxbq0jvjhdxWhbJhjZSfuW6UevxxpvzfTNSJ3TDMVlZ8?=
 =?us-ascii?Q?pnV0/8ZkPoGWK3qnrmxU41bRMujh2AosdsLI6GExjbwgFsdA/nbcIt2jeYse?=
 =?us-ascii?Q?kHDlOAnZ6bPNwlZxDvlvYSE4WKNVMKIfSnrbbRC4vXolns4pEAEt8kkHoOVY?=
 =?us-ascii?Q?B9TAN+vlgSmH2YkKml4DKkvks9UwDE2nm/9J4/24t9cQWJTtHpEYLvWuMD3B?=
 =?us-ascii?Q?UecodohhvEtEkK7FpI2SM/Fq85r7Iww8tolWJ/i2BzShlO0FvjU4MQ6/vKxX?=
 =?us-ascii?Q?KKGqUEZKH/0wCpg3RS+aImdT5ryQCJqNT7AuZSB/X5xgBnwAab/7tYuiu3KW?=
 =?us-ascii?Q?cgf3ag+DBilReSWk0Z7ZHZ9CdAT5Y15HR8xtVz5P/uXe75i582ndVDRXiN17?=
 =?us-ascii?Q?T8GQlc++wyQssz+OB3IpAnXgnJU/4OjXuY0bh67V6Tp/KdkyoweC/A=3D=3D?=
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(35042699022)(36860700013)(82310400026)(376014)(14060799003)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2025 23:17:03.8767 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f3b83064-b1a3-4510-9a15-08dda22b95f4
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: AMS1EPF00000044.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB10931
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

=20
> Hi Maxim,
>=20
> Here is the link to the kernel VFIO patch you have asked earlier (v4).
> https://lore.kernel.org/kvm/20250221224638.1836909-1-
> wathsala.vithanage@arm.com/T/#me73cf9b9c87da97d7d9461dfb97863b78ca17
> 55b
>=20

Sorry, here is the correct link to V2 of the VFIO patch
https://lore.kernel.org/kvm/20250221224638.1836909-1-wathsala.vithanage@arm=
.com/T/#me26a385f781002dbe330ce03a63cb20884200e91

--wathsala

