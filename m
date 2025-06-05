Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1156C5B543
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Jun 2025 14:25:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8B2B740281;
	Thu,  5 Jun 2025 16:25:41 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazon11013012.outbound.protection.outlook.com [40.107.159.12])
 by mails.dpdk.org (Postfix) with ESMTP id 4522C40150
 for <dev@dpdk.org>; Thu,  5 Jun 2025 16:25:40 +0200 (CEST)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=KqAbO3TXBkjgk9hcN+E8cNvDWC0yEpkq0aU0AGyvpx64nnY5S7mJRgDG7RrBFnV5XJWtY2tczE2wzkRf/5cZ7+6atoIijHlwqei1Fz8EoxsRdmiObIizqT7WJS1BrESqWwJ9o1qCccQsDePVMKXL1L5DKN/I0qlbU9X+EbLv4iEtOF+QFmjukxuZqUnL6LBIIzJ0HGrl4nbOlk4BrCK53Lhgm0t1Fb7iaaqQ1f+6urpZRV9Sm9YEz/oG6XovssKhB0QiUueyXjIAgbAmF2MKq3xuJN3AcsvO60wtixQGff9C2ZQpPeidZCLMmvyQlLErPa9ye+P55V4MyN1LPa1iXA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6nJb67RbaMBzrIAaolLeArOHa5cRr4XE2Z3ASWT1VIU=;
 b=gPyGrDTHZczB9HV69zWdD6DFvQZ7IxoGhJh6+YYAeaG7jvJkxvURqwlStcsb3gpv4N/yGfpzDL3P58YyLmdvIq5pYI5mvZsmyHfdCE4Ov1EtbtCyxgwz7rK9uuILpxGhjzXFh6UAFrAD5Ds5V28UgzIwZOkX5EnZ3U2+DCE67S0c9rMgEUJQxkQ2JPwb+kndHcBqQChjf39/XS49lSLydnbC9HZpwVapFinVCBVub4gZDNnJT1fmnbF2DUQmd/hzLSWpBRk48CKVtIDngp9PG4LdOs69ZdfOhsxrGCshOnWR8LZKEFDd64xSceGkUC2ZAmjMo9w6QwKU2q6T7hQu0w==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=intel.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6nJb67RbaMBzrIAaolLeArOHa5cRr4XE2Z3ASWT1VIU=;
 b=BuU7Kn5ohTKpkuzNUs4SCim+esDElEpilfotg+i22cbI6KPnZSRT+5h5wrwt+tOzrIjrmmHg9OXSY0K86tx5BxK7m5tJNtMn77cBm75K51Vp4X8Kq7vBostZVRRKhmZgelMyVlb31BTGlvBvRyvAE4EKLazsaDH4Xx1m/NZHz4s=
Received: from DU2PR04CA0083.eurprd04.prod.outlook.com (2603:10a6:10:232::28)
 by GV2PR08MB9375.eurprd08.prod.outlook.com (2603:10a6:150:d0::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.33; Thu, 5 Jun
 2025 14:25:35 +0000
Received: from DU2PEPF0001E9BF.eurprd03.prod.outlook.com
 (2603:10a6:10:232:cafe::45) by DU2PR04CA0083.outlook.office365.com
 (2603:10a6:10:232::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.26 via Frontend Transport; Thu,
 5 Jun 2025 14:25:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DU2PEPF0001E9BF.mail.protection.outlook.com (10.167.8.68) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.29 via
 Frontend Transport; Thu, 5 Jun 2025 14:25:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lZEE7RhxLG5cUtS4vG3Cd/IIGnL+ysJ/8Zki5AhevuxYcBBsfanrvSDTj7rBNsb3Dz2+VrNOM8EdeHoKjUxLsbutgatXEXsY8t1FF8rfuqhTPqefOWuGq90HKRMli8epd1ijGhuuZfuKthkd3yO3HPNWLE1dGY9owI1RNujjEKgvTJhfZyteWyTPq0f0b6K/ilEL5GXJNxIjxm+0kcd2VU4xM9JXXBbHWuznAPIrT34MuxrHOlgFKSXfztVCdgarUceFGOi80ZKuk6VjjgyJbqS8JBtUTMOqipWV/ZSVjWR+qqzg/VMDELd7mBlggSzQadYF8xtc12AiYz30GbKtnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6nJb67RbaMBzrIAaolLeArOHa5cRr4XE2Z3ASWT1VIU=;
 b=Oy8LbH2ZxZZhRal8sL0AzFefvvbjjjCRn7MRw6fIXfDEzKvsyEf3AlsbBeiGhL1mTnzk0fegIQtP6pXxMcNfOH+syFk75FmgqflOtk5wB99oZkxiwC+dOsONkq8zc5HrqtUrJ4B48ZK7MEC79M7Gh+oqamwrCnLL8h5r+C8Rbx2qX6c6BWW9FlRwXfSssVIZA3gfn2mjACK6Wbf/2lyymdZ91CS4AdNmfu2H99ZT5N5N2aRi+z2hcqvcZmyM6GcoTS0NJcmRDfGtewr7qw3EOn9n5lQxy79Tt6t7Qvi+rr5tUxNh1cEKg2Otb6CA+pmMod9summwryKhpXj5jCsn2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6nJb67RbaMBzrIAaolLeArOHa5cRr4XE2Z3ASWT1VIU=;
 b=BuU7Kn5ohTKpkuzNUs4SCim+esDElEpilfotg+i22cbI6KPnZSRT+5h5wrwt+tOzrIjrmmHg9OXSY0K86tx5BxK7m5tJNtMn77cBm75K51Vp4X8Kq7vBostZVRRKhmZgelMyVlb31BTGlvBvRyvAE4EKLazsaDH4Xx1m/NZHz4s=
Received: from PAWPR08MB8909.eurprd08.prod.outlook.com (2603:10a6:102:33a::19)
 by GV1PR08MB10670.eurprd08.prod.outlook.com (2603:10a6:150:169::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.21; Thu, 5 Jun
 2025 14:25:03 +0000
Received: from PAWPR08MB8909.eurprd08.prod.outlook.com
 ([fe80::613d:8d51:60e5:d294]) by PAWPR08MB8909.eurprd08.prod.outlook.com
 ([fe80::613d:8d51:60e5:d294%7]) with mapi id 15.20.8792.034; Thu, 5 Jun 2025
 14:25:03 +0000
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
Thread-Index: AQHb1A8LVwjtBj2HM0KwVaHXGcaVP7PzOp8AgABXn0CAAMwZAIAARDiw
Date: Thu, 5 Jun 2025 14:25:02 +0000
Message-ID: <PAWPR08MB8909C227E1E5906477B75FAB9F6FA@PAWPR08MB8909.eurprd08.prod.outlook.com>
References: <20241021015246.304431-1-wathsala.vithanage@arm.com>
 <20250602223805.816816-1-wathsala.vithanage@arm.com>
 <20250602223805.816816-3-wathsala.vithanage@arm.com>
 <aEB6VEFCKr-2t11p@bricha3-mobl1.ger.corp.intel.com>
 <PAWPR08MB89092A3A53CBFA874B1AEA729F6CA@PAWPR08MB8909.eurprd08.prod.outlook.com>
 <aEFvChZ-K8dJGcI9@bricha3-mobl1.ger.corp.intel.com>
In-Reply-To: <aEFvChZ-K8dJGcI9@bricha3-mobl1.ger.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic: PAWPR08MB8909:EE_|GV1PR08MB10670:EE_|DU2PEPF0001E9BF:EE_|GV2PR08MB9375:EE_
X-MS-Office365-Filtering-Correlation-Id: c50eeaf5-27b7-4be8-9b65-08dda43cd620
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700018; 
X-Microsoft-Antispam-Message-Info-Original: =?us-ascii?Q?pMBHy33AGzTfK/BUqG0FAjIkM8IWRzsySSw2+YSR8y6+nJPcL09QJmGVhI9V?=
 =?us-ascii?Q?OhcOXo7K0lMAubufW7HFus6YjhOcZqvysVYD41T4I12uTeza6ZE8g6E4Cams?=
 =?us-ascii?Q?GjcUA/9oxLa/W/ZHSG5NJFAAVvstLz1w6q6Y2uHVFivCZmnHxSnDwIhb4mvr?=
 =?us-ascii?Q?Y655alCfxgTLEG0vgitC4K1L2ZexbQwG79HYXha7t1baUCV1uxSG/1pp7OOG?=
 =?us-ascii?Q?yolUEGUug5NkcwGUBu2wVd2+1SJzf/lJn/n94gSQTwc3rlTraGt7nrzY2z7W?=
 =?us-ascii?Q?W8U/gt/cQ1lynZO5Ft5jCTBTo/s8KjK5C1yc+f4szGX/prbdREPkXJCnKTKI?=
 =?us-ascii?Q?H47vT+hnFSJwsnAoLvV0xeoPUK2nD5XQfdqV+vrloGoDETPN/Vt9jaaJjiB/?=
 =?us-ascii?Q?9VA1BXgCRBA6DCvirZPCl9y2x8KMypUvB1fzdFvEGKTjaZpYjI0E6zwsszkj?=
 =?us-ascii?Q?uO3OTSotDYdz4N1TH1rZRA8IgMiFcA87VbHCuPYL4V3ajVP+cJiRdwmRpIDI?=
 =?us-ascii?Q?31njEFoq0JQtXV3mPJuLAgO9Kuz8qQR+pxlEbmaH9xuQSgmHh5Bu8TCc+d/r?=
 =?us-ascii?Q?7v3Eo5iuq9B9GGoqwTl/9jv/9pWEZZQD2MM9fuvMhohPidu0dPeO2mcEAmmg?=
 =?us-ascii?Q?2/1HUnQf+SdD7WJbBZRK4wW1pNH7RA9OQ1O6vBhURDpHzPITFoWkmw7oSkkP?=
 =?us-ascii?Q?+h4WtrjvazARKMtRkbRwX27uHKOt6MD5WP8u4DQ1T+RUK8pYuEpkBVX3VPeH?=
 =?us-ascii?Q?fn2NrRmvaph+GieMKRabkHsnJj9V29JDeUdONu89b8nm/h0VurfB3eWfle5q?=
 =?us-ascii?Q?4McyRZrn3o7uWK/ENVI5mxpy+bajReP45caX8sOfjlDS5yfZMxxucR9xU/6m?=
 =?us-ascii?Q?8DjVf9nkfa6NmuzpiwjtaXclkGTNg3e9ohToRldYQaTvaXvLgCH6hCXa+wPI?=
 =?us-ascii?Q?5EoeJS44qRF0p1+J/atvzeopwRkQ2VtAuvNkjL0kKxyGjzfnyUpgk+0+umOT?=
 =?us-ascii?Q?pA7RH22nGajnK06AGKhv5WBpHhNBxd0QdQ3sWiyIs6IBgTTDN5vRzj3HmRJp?=
 =?us-ascii?Q?7YDkTC0vT4zTUqiXeAqm6r48inK2nNNBVr3rNJ9B0Es+VgbjGW8TF3+u6WRk?=
 =?us-ascii?Q?pQUwKITebZ4x1i8bAusI86wHNFhrMFRciOoQsGGGd7sHdS878btZCl30UCcN?=
 =?us-ascii?Q?hihTwzytn/w74hf0wPs1vbgiRMPicCs0icbD5LayX+qDDi/3LeLbgX0DTc5U?=
 =?us-ascii?Q?NaPla97j1Slct6Xhq1WWkfJDu4Yjv3FJpJ+ctoKDi/M69CpxluOa21PR4K2t?=
 =?us-ascii?Q?muA6vIcpMfYPhSkkS9iyPz/VUcsyh4Y5Or3d2REEpvopxu5oFGqit1UwZS2l?=
 =?us-ascii?Q?HwclWePrwwdt+FtPuIuEF9KP72Hk0ZC8Fw6BXOaYuHPUvEbMG0pwlzOwoTVe?=
 =?us-ascii?Q?WZDEEiXgJdRe7jFK0JEonwiSvFoHyn8NDjD9rT7HQ60haSQc7TQTUkQEHm/S?=
 =?us-ascii?Q?cjbQVNTaV/QC/rE=3D?=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:PAWPR08MB8909.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE; SFS:(13230040)(376014)(1800799024)(366016)(38070700018);
 DIR:OUT; SFP:1101; 
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB10670
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DU2PEPF0001E9BF.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 322c0423-67c2-4045-da4a-08dda43cc2c9
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014|35042699022|14060799003|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?X2UVKlJKvh8rhARuai/C2Hwepx59EqFZaMCOSHY6wrALIomlWZHyd9Lxf7it?=
 =?us-ascii?Q?8bAbMPJszpdWzb6VAe6CWZboU1D7SvgEZBh1YaGpVME/Mb6NVZLChT/fBsTp?=
 =?us-ascii?Q?gVo9VJDZsNk2aW61m66/2H7sfQXAdOQtFPY2YQnW8DM1ClRuFDbZZIjFjNN/?=
 =?us-ascii?Q?kVFRH1mkY1v+O4T2lZKZiSf1p3Ju+uhiePLtWgitRPK4fwgSu4fZHln9Ph6h?=
 =?us-ascii?Q?jrOhSBeE01qvGG3eFgNSxwuj6gSoveVSOCRWIhPX7v+obP9embMCc1xzFvZq?=
 =?us-ascii?Q?fb+ytaPnLGhyRowdW13z8OXjd/r5HF2uzWNsd7EDxLRwzFX8XXKt9nnegcpa?=
 =?us-ascii?Q?9dcr75kOA61F2bu7VWeSiWLo4NS3yM5u7uuALXJB6YVth0IroC49SS5D08Kg?=
 =?us-ascii?Q?+uw4azpny5Pol7ETpxW6slP0aIcbC8F09IF/pAE+pxZt1B6Lg+3Kk25+3g2O?=
 =?us-ascii?Q?cH0fE+iOx/ekcKPizaB3J9wFHR1PlSFhOIcSldVsfZsFxtYZqrISJtNvoRw/?=
 =?us-ascii?Q?EUOXfXt0+69hS/AZ1nJeRkrKRakNBAdYlMdAm1jhwrxo2QSH9SJdvPete1oJ?=
 =?us-ascii?Q?3JJ2RrxtH1YkHKi4566u0utf21rO4q1QRJvoiugvFXC6vHiUhsNx7Lw/LMlF?=
 =?us-ascii?Q?x+N+iFQMQSn2OL/vKlGYS5yTOY06KtwF1BkStrZNK0PYJhZXnxjoQVwIa9af?=
 =?us-ascii?Q?oyaLIFGKi5n/Z3NwtB+UWnIFv64WYNiaGGAcKna55WKyfkruhTMenxkvCL/C?=
 =?us-ascii?Q?vQygunvQG/fC0+BsZR64iUfqqd4CMTaxUJgFhSUWz2pZUK8XNicl3mZrdHm7?=
 =?us-ascii?Q?O5DaSRhM403hljFnSDWqzWd9hutwxyaRZT6lIg4SFQfSwzJULnRXvysV3B5D?=
 =?us-ascii?Q?Y5HHJvOvXzLF/QwkvQpi+gIM8c3oOF/ZGa2Z4S2In5Mop0SF6YFk2DzqtWD6?=
 =?us-ascii?Q?og9tDm1WAfvWERoygloQnKVsYRkHi9KI8NF2zxvFs4/bBEgTJ+NLK9DLmwHP?=
 =?us-ascii?Q?4yZPRqeeVl6eU9ZZAo/9XCQuH/GXYsKH2AwQfAD6mcfsFjD6XOEmwU3gpHJ3?=
 =?us-ascii?Q?GSd1tHSWgefaOwlPzCda7AFIHkbDek4hiVNgPnK9AeOFKw5+rLRIh99bcoOV?=
 =?us-ascii?Q?QhCEMC3yY4X9edZOn6fUMHfaXcOZTkn4y9Du3Er+pkuDpgeFUEJn4JoMczS9?=
 =?us-ascii?Q?+3E4xLsZ71DdBeyA4rNp6jRMqLzB6G2YYD0in8ciCmx9nZt0EX0QKksA9GS5?=
 =?us-ascii?Q?j9xW0uNUnFwYfazaKwpVBYhlNayh1mQJ5nchsfJ1gAwPWrXJDRkmRKESQ/6l?=
 =?us-ascii?Q?2VLyBdloHGa3jo/0jAysUMfALh+KcrDoI5zL6a4xJBOxfC9/aVGdLvGyE0mY?=
 =?us-ascii?Q?1ZHIWYUkBp1btG5xIgr4VUyDrf5SH6Rh8xU5DT12L9pECJrGAM2Ef7yTBsLu?=
 =?us-ascii?Q?AbK9KQ3mI86kwrKxa/+N4Yxe3dg66sJqEd5uPvXJmp2r1fOgZ+H4/v/4OwLm?=
 =?us-ascii?Q?7Cso99NLeqWGNkDZN+3vpaGLUn1ewcD7gDcDbKMgb/l+gBLpNbmElSansw?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014)(35042699022)(14060799003)(7053199007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2025 14:25:35.2948 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c50eeaf5-27b7-4be8-9b65-08dda43cd620
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: DU2PEPF0001E9BF.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB9375
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
> Sent: Thursday, June 5, 2025 5:19 AM
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
> Read the thread. However, from my reading, there is nothing in there that
> mandates having an interface where the user won't know the state on error=
.
> We need some method to have userspace know what tags were applied or not =
on
> failure. Resetting the whole device is not a good solution. Whatever API =
is
> provided, if it is going to take multiple ops in one go it needs to eithe=
r return the
> number applied on failure, or if just returning success/failure, it shoul=
d rollback
> the successful ones to give an all-or-nothing interface.
>=20
> /Bruce

I will bring this up in the V2 review. If there is a pushback we can altern=
atively change
the API to do one tag at a time.

Thanks.

