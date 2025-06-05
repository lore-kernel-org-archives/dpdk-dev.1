Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11144C5B543
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Jun 2025 14:31:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2778F40281;
	Thu,  5 Jun 2025 16:31:37 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazon11010011.outbound.protection.outlook.com [52.101.69.11])
 by mails.dpdk.org (Postfix) with ESMTP id A7AC240150
 for <dev@dpdk.org>; Thu,  5 Jun 2025 16:31:35 +0200 (CEST)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=VaFMmuFqmXJQM+npL3iXjBIuj31XAbh7HuodrTQiIykrTLwe9jMhcy09OOeXOPRwQopp2upjSCGVdWwHWuja9psSn8o66ctiZ7XQor0xth6vGKzqCxv4+RG4DzTjvuvBjAwTFp3b61NW4FVzHQEuPqKjFNAn0ngSqq/54CxPtpXJu0vSsIwc48konHzEppzaD+jaOLorZysUB/fTFXxYYQV1hoMTEINLBcdU2wNgdA5LiFKOzBSkax5zaRI76Qq7cxApk42+fzGilLlHdA/Lhq+zEPBfHSgfGYYcHevz/EnwTY0xFREqCiIaL8OQl3tKiVtGWfo3niBXHMhiUsNzIw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pVodjAdEQfIHo3jOtHuXRWNwOecbCYupNDcL//vCaI4=;
 b=bWoqO094+o+HezuyS7jIzf3w1xxzbd4Zr/YPeNKZ/ZonWf9TDqJvK8LcSt8dWBr/LV+JZIAdHJfcrn0OLUZUSkwQ3LpDaiQeEekEVyofEpwKerJdXfjtrlP5s0IK+moGoLGl+zC7Okzh3Fn+2kWbUnu7pLaQahkl2bb/XM+oTsigTro4A2HxW4RnJ9wz/K52IUJ8nMJc8hKXv2xf3kyOonhJWFXMFrla4tAQR39wQyPSyY9TXyc/qnyrM0ctMhLFE9BVb1JanIY81r8He/sMBSPFjSnxRRhNn8maFqssEcwdgqEvKkr94ucnpmyqFjbdwzHc//5vkw2IwIQmHhMmAQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=intel.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pVodjAdEQfIHo3jOtHuXRWNwOecbCYupNDcL//vCaI4=;
 b=PFujyKyrKG7S0YdXPNXHOBD+gCL3zcBaT+mmepWWUOp0mF5FdySPkx/uWQpyFqQH940YBmwXaWdkSPR0HG746DL9RCnR6uWcOmGch7iRyZvW1V9a0PBBHb7NlTJ3IvM8N0CyCHAcXvxt45HezB+ltWbd78J+N4N/inLqPxbCDEU=
Received: from DB6PR0301CA0098.eurprd03.prod.outlook.com (2603:10a6:6:30::45)
 by DBBPR08MB6186.eurprd08.prod.outlook.com (2603:10a6:10:204::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.20; Thu, 5 Jun
 2025 14:31:33 +0000
Received: from DU2PEPF00028D10.eurprd03.prod.outlook.com
 (2603:10a6:6:30:cafe::27) by DB6PR0301CA0098.outlook.office365.com
 (2603:10a6:6:30::45) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.29 via Frontend Transport; Thu,
 5 Jun 2025 14:31:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DU2PEPF00028D10.mail.protection.outlook.com (10.167.242.24) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.29
 via Frontend Transport; Thu, 5 Jun 2025 14:31:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lpoLTdBzTWWQMHqLty8CbLAa5EoRRJrSBCGClpWak8JG0zKzoSOVwpv3K6zbj9e8tfN15Rh9v6SlJMW2tAPvZPPC6bZMiYi0MC2NydeLImrFi4BMy+2FsGS6K8zN4r4Zosnlt1W/Zlk8Te6SLnZH/YiWPBpf2Q0EnvMaKnmxhe7gt4YM2jvT7FXUv3zN8zFXuhzjF4G+eBDQvYMaDBihJZ16jy5A9c9r5p4EZIyCrZgKbB/tFxzwVVQo+hzIBmkbPwIVYeYmD+0/tk9mDAcvJd4mzQsBMXTfk2YUThs+pWOyLEXm0XyMXw7Ov6dyKW9E3LT2vI5MCT78OQqyWMq8cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pVodjAdEQfIHo3jOtHuXRWNwOecbCYupNDcL//vCaI4=;
 b=JKJQOLWMoHZz5sxKmXeTJF8gNLsBquZyAZg5+sybxSaxa3yqHYWeHEWgdnHIqUoEPmUPNnJe1T2f/sswsNKjH5LCZzhsfG/k5eXpnh9wlLT+JhAUg2g3lzWUy6KnDqmRZvWHqju5QWPdQ0v14QU6h0hFJYaTO09xopMyUMn2F81VogZ7xEuNhqFiY700aQXRtmtN8cJPmvN2vh7caaWMaTAMtp1fUFJgfIw0F8HIHBzV5lviLiLeMXO9BTPDfFyaka2HCUYdx1LFL2Yd10RiY9vN9GnDwKRdGs7PCJqAlQVWIjp2tBi6rzjtZZx4s0MN8xtemF6Bdrw4GjaS+KgJyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pVodjAdEQfIHo3jOtHuXRWNwOecbCYupNDcL//vCaI4=;
 b=PFujyKyrKG7S0YdXPNXHOBD+gCL3zcBaT+mmepWWUOp0mF5FdySPkx/uWQpyFqQH940YBmwXaWdkSPR0HG746DL9RCnR6uWcOmGch7iRyZvW1V9a0PBBHb7NlTJ3IvM8N0CyCHAcXvxt45HezB+ltWbd78J+N4N/inLqPxbCDEU=
Received: from PAWPR08MB8909.eurprd08.prod.outlook.com (2603:10a6:102:33a::19)
 by AS2PR08MB8286.eurprd08.prod.outlook.com (2603:10a6:20b:555::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.20; Thu, 5 Jun
 2025 14:30:58 +0000
Received: from PAWPR08MB8909.eurprd08.prod.outlook.com
 ([fe80::613d:8d51:60e5:d294]) by PAWPR08MB8909.eurprd08.prod.outlook.com
 ([fe80::613d:8d51:60e5:d294%7]) with mapi id 15.20.8792.034; Thu, 5 Jun 2025
 14:30:58 +0000
From: Wathsala Wathawana Vithanage <wathsala.vithanage@arm.com>
To: Bruce Richardson <bruce.richardson@intel.com>,
 "stephen@networkplumber.org" <stephen@networkplumber.org>
CC: "thomas@monjalon.net" <thomas@monjalon.net>, Ferruh Yigit
 <ferruh.yigit@amd.com>, Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 "dev@dpdk.org" <dev@dpdk.org>, nd <nd@arm.com>, Honnappa Nagarahalli
 <Honnappa.Nagarahalli@arm.com>, Dhruv Tripathi <Dhruv.Tripathi@arm.com>, nd
 <nd@arm.com>
Subject: RE: [PATCH v5 3/4] ethdev: introduce the cache stashing hints API
Thread-Topic: [PATCH v5 3/4] ethdev: introduce the cache stashing hints API
Thread-Index: AQHb1A8Kkg6K6E7oCUG+LajjxjjcyrP0WfwAgABJldA=
Date: Thu, 5 Jun 2025 14:30:58 +0000
Message-ID: <PAWPR08MB8909982D8234CB4001B6A3949F6FA@PAWPR08MB8909.eurprd08.prod.outlook.com>
References: <20241021015246.304431-1-wathsala.vithanage@arm.com>
 <20250602223805.816816-1-wathsala.vithanage@arm.com>
 <20250602223805.816816-4-wathsala.vithanage@arm.com>
 <aEFrYvpyc_-Ji5U1@bricha3-mobl1.ger.corp.intel.com>
In-Reply-To: <aEFrYvpyc_-Ji5U1@bricha3-mobl1.ger.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: stephen@networkplumber.org
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic: PAWPR08MB8909:EE_|AS2PR08MB8286:EE_|DU2PEPF00028D10:EE_|DBBPR08MB6186:EE_
X-MS-Office365-Filtering-Correlation-Id: 67404928-0f87-48b2-18d3-08dda43daad6
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|1800799024|376014|366016|38070700018; 
X-Microsoft-Antispam-Message-Info-Original: =?us-ascii?Q?xlPQ+6GbkqHtAkwSEUX19nbBKB8/bC0FyTIh7yZ/pk/RnvzrfnrnTLVZrgU/?=
 =?us-ascii?Q?Ho2JGukQkWytsP3Ziar2T+60Fk3kar+r+5rWjYkP91sKoCENKFMRRIjib7Ej?=
 =?us-ascii?Q?k/bAqYAeZlEwqc9brCYztMKS+8nobohLjEFeLSIn/E52+P5rdxoodG83pixy?=
 =?us-ascii?Q?d5YE3DBtmKxmgvWQI0hQjLMOcLUjLmr+SK6YVBoO3HiROCs6y4njyJWr1Im7?=
 =?us-ascii?Q?qiG3Lk8zW+lNtFU8oUKAsR4JE/LZTzj0VFACnOOHR/qH40NOapZFC3VMzwR/?=
 =?us-ascii?Q?fIqSFK1YmTkEUrlqhWZF6jI0N3bZqHhR4SBxODCm78UU5gGU4O7Yf2Fr/4tx?=
 =?us-ascii?Q?83EhthNaf66ybOhTlDMx6jYTFApUL7R7BD0n7//DLjWuIMV/owkilENuSxEo?=
 =?us-ascii?Q?dXJuJ3mput36dW0+LYpNBJ/9W4QAlFYi5CJ7eAH9VZ8d1HTQCIPo3UfzH0eb?=
 =?us-ascii?Q?jPDn0Qb9SachY4Ru29vQB+hexGOBlLp4RPOdGngD+7gR7UtyIVgea6znHUHV?=
 =?us-ascii?Q?MHqZL9zv5WRDXHbMQqOckWFzye5WCb3R4XZMGdM5d2aSW/rKAX92PSMNaHds?=
 =?us-ascii?Q?z0N0TVSCXjuvXo5NqLH/INK6QSyMRD/WdXNvFN0nOhcu5k6hIrxd85ojw+pn?=
 =?us-ascii?Q?pRMs12mlipjazJlf/uAHuSDgwWFh+daXCzu+WE3a3V/7rSqGBZpGQj4rouAu?=
 =?us-ascii?Q?TBpPG1D7qYtGzDxHA2y9Iz3emKTz/jtiOQhdOP322gJIEfqTIPNGvP5U41lr?=
 =?us-ascii?Q?259esgKJKGEAwpMGbiVa1DvrEngWjXP54DpIgBdJXCZUESO40HLXk9yj6JLr?=
 =?us-ascii?Q?yBAWFuU6Ti+rdL8m/tBemve6RyDlXz7jZYQoMDFrzdSE6S19SPPB/eGyzYgU?=
 =?us-ascii?Q?fqx27ta6rjmTyzkuNGz4L9M2X5YLGOdj7V+gm6+dc9Iv6C/0M1HbTvY1dpLN?=
 =?us-ascii?Q?U0Smj5UDtKiYNOF2O+j3pV6kSh0df01bH1JclKO1zxDLVmQq2Va0WDi4KGn5?=
 =?us-ascii?Q?ApV5nHgpy/Q0QW8ldCTQKlkgOI7kwB34kN26E055Dpl0ArCL9AOX+N1SRct/?=
 =?us-ascii?Q?GwbME/gxyktQbFBOMfWTrwu7OLYyOBUksuSZJWCXFZvUTbz7qus3v9vFuzFO?=
 =?us-ascii?Q?CXsqAGg9vHRD7cDRJ6ODULx2Xsi05xCOGoY0SYqqdXyoHwmK4r9s0BlOt79Y?=
 =?us-ascii?Q?qSBKm8whKXD1R3WPbC6q59a0L32HzN9FSjjXTDsd/cKnvY+aaSfmfbKu8f9U?=
 =?us-ascii?Q?RF98CWqCcojMryRAPJZWztEMoYLZMXUefOj8Dy0oR0ZY0IYe83s+vliXZbwE?=
 =?us-ascii?Q?qOwqpSuMWWI5B6aXv3ZogecXKL3ceogbfvZgKVAEG8qFURFxOp9rEmXra0Pz?=
 =?us-ascii?Q?EKgGuVLkrG5/qqsgDWMpqv3t6n5UEiZLURhrz6IYXugCK8otniLqILx7BGIq?=
 =?us-ascii?Q?gGVWMAQY/sSKuSSsKr/4NFWUtPACkTvw07XWrh7lDslEXEeWs6HF8lkvIA8C?=
 =?us-ascii?Q?a2Gu0YreT0Qhg5A=3D?=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:PAWPR08MB8909.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE; SFS:(13230040)(1800799024)(376014)(366016)(38070700018);
 DIR:OUT; SFP:1101; 
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB8286
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DU2PEPF00028D10.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: ee29069b-6222-4cc3-d1a1-08dda43d96d7
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|14060799003|36860700013|82310400026|1800799024|35042699022;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?EuxAhHX0FfYcWhBO9r5GKtG6h2MLdFul9jAyYiOQbcU71YpuSdUnJ/Q3k3YV?=
 =?us-ascii?Q?xJWmHIN5xb8Mimeenf1wi862eZU6vE+c9yb6HTrfzOEOxbvb3mHwmVQM5EBK?=
 =?us-ascii?Q?LwUT6DwLPBOMgJVjo+ZMb+wZqFxuiFz3HTskEzQWUPz5RBadnOFRKgjY/xfl?=
 =?us-ascii?Q?AxbKz1zzp+zabA8HHMkltRHTBbG57Qdu53Rr5HYxSNrnWXiYIV0Y117k/BJe?=
 =?us-ascii?Q?BKPNwoByRARpEPKRg0TKQjzOY8mv2twDMdkMZfN8OYHJYfbvmvFg1j4c/J2Z?=
 =?us-ascii?Q?8ozBH74gstU01exXW9IQvc8L9qbvF3joBfRUIq1PvVVdjiVVRBXyppYz8QRU?=
 =?us-ascii?Q?zLqr4uBpWRlRiFWUxtmUoUaUiHFsvDn4gp1ICqp7k2FEQ/2ciurX9lCykLYJ?=
 =?us-ascii?Q?K9quN9SpL7J0WH0Pr2tuAzCo8jlYz4q7lKvKTnbxDaJb9D7ry1J8dtW2rm/t?=
 =?us-ascii?Q?waIqsrWh1PGU9u+k7C6fxkDgyvL6M7iHp+DuOCuWj0SEmFpVk8yDTmCYpNQl?=
 =?us-ascii?Q?Qj9O1aqivZ7KcTkoEHE/c4VuPv4UjtL4nH8PSNy8BCkGSrlrsexcdWyoKoNu?=
 =?us-ascii?Q?Wci/Ttdavy80p0GigIdctbAnxOUxVYpCyBNptik3BIXqBik6H/lKOAyxQIng?=
 =?us-ascii?Q?YW15IYEcm2vnHr00rKXO8UPpI/IlImBvtCjByusmvcQZmImhN7XePOkatmQ5?=
 =?us-ascii?Q?3HDKkZcZslnLKJnoDyAihjl3SOpM8vqMWtzrEZrlvkSoANP/YmRGZGTZ0/tB?=
 =?us-ascii?Q?du3/lxdIuvp3Ppk2RflgGTOAPUWsusB56flPVUM8rYuWFTxgJWHk7X5hQwMv?=
 =?us-ascii?Q?coiyYo19rQxqBc31dn1jf4MvH5kSv/+n+KdFT1x9VYWKZEmH3xaAlzTkisKf?=
 =?us-ascii?Q?rFmbljQK2tRGaoyqnLHr7oN8qxFJSdIwc2ZNUV3vQ/2+QaGtNLG7jCvivTf2?=
 =?us-ascii?Q?jvqBeQcKsS0DCAILXAJTsDWlVfytlJ09T3xcyyjra7VRN/lbnTcpE8RL1MCL?=
 =?us-ascii?Q?DykIBgEOKpTOBRHo5xjXsQjKTSsJ3zZdUAQoEkjJWe9YSVspjY9cj+zC0NkY?=
 =?us-ascii?Q?yM2sPK123brP1mS6rlOj0VOa2pgKSL0rdWHbgHWWBCqeMCFABD9411QidGl9?=
 =?us-ascii?Q?u9IBNiRs+5EKRkUsxtjBtbd3UFdPY+Lk+gCLzpoOY8bjof63+Jp0l0Xm8TFj?=
 =?us-ascii?Q?mGynHz8v5p4e+mBrACFMlUKS7apUsocYPLB3N5y+T8Q8eYJ8gKIOvGn9cvkH?=
 =?us-ascii?Q?kddUg+uOiz/fAYe7ku+qmUnta0EX9n6MfBvc936G0TJ9I54qA3H30RZsGq3W?=
 =?us-ascii?Q?T6aKqMolhg4g5Wa3Oh5DVHGzhWkQH/tS9LkMuVDsK8xszdTVKOzSS+QdFDJL?=
 =?us-ascii?Q?14ZkEz/5CenT/flEFga2LryTuJhrD/+4mTRCd4h9CAkE4LmarLdtI5/0gkvx?=
 =?us-ascii?Q?Lu9HjXJxXeGFaHh8xWXbJESfK95l16HOAgBCZShF6tT+d6KQeZqMBAc20pBR?=
 =?us-ascii?Q?3wDiFjDBpC+Lt1nPAbe/dqgfH6PAuX4rAaNW?=
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(14060799003)(36860700013)(82310400026)(1800799024)(35042699022);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2025 14:31:32.1510 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 67404928-0f87-48b2-18d3-08dda43daad6
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: DU2PEPF00028D10.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB6186
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

> On Mon, Jun 02, 2025 at 10:38:03PM +0000, Wathsala Vithanage wrote:
> > Extend the ethdev library to enable the stashing of different data
> > objects, such as the ones listed below, into CPU caches directly from
> > the NIC.
> >
> > - Rx/Tx queue descriptors
> > - Rx packets
> > - Packet headers
> > - packet payloads
> > - Data of a packet at an offset from the start of the packet
> >
> > The APIs are designed in a hardware/vendor agnostic manner such that
> > supporting PMDs could use any capabilities available in the underlying
> > hardware for fine-grained stashing of data objects into a CPU cache
> >
> > The API provides an interface to query the availability of stashing
> > capabilities, i.e., platform/NIC support, stashable object types, etc,
> > via the rte_eth_dev_stashing_capabilities_get interface.
> >
> > The function pair rte_eth_dev_stashing_rx_config_set and
> > rte_eth_dev_stashing_tx_config_set sets the stashing hint (the CPU,
> > cache level, and data object types) on the Rx and Tx queues.
> >
> > PMDs that support stashing must register their implementations with
> > the following eth_dev_ops callbacks, which are invoked by the ethdev
> > functions listed above.
> >
> > - stashing_capabilities_get
> > - stashing_rx_hints_set
> > - stashing_tx_hints_set
> >
> > Signed-off-by: Wathsala Vithanage <wathsala.vithanage@arm.com>
> > Reviewed-by: Honnappa Nagarahalli <honnappa.nagarahalli@arm.com>
> > Reviewed-by: Dhruv Tripathi <dhruv.tripathi@arm.com>
> > ---
>=20
> Few small comments inline below
>=20

Thank you, Bruce. I will address them in the next version. As asked by
@stephen@networkplumber I will only send it only if kernel piece makes it
into Linus branch.

--wathsala

> /Bruce
>=20
> >  lib/ethdev/ethdev_driver.h |  66 ++++++++++++++++
> >  lib/ethdev/rte_ethdev.c    | 149 ++++++++++++++++++++++++++++++++++
> >  lib/ethdev/rte_ethdev.h    | 158 +++++++++++++++++++++++++++++++++++++
> >  3 files changed, 373 insertions(+)
> >
> > diff --git a/lib/ethdev/ethdev_driver.h b/lib/ethdev/ethdev_driver.h
> > index 2b4d2ae9c3..8a4012db08 100644
> > --- a/lib/ethdev/ethdev_driver.h
> > +++ b/lib/ethdev/ethdev_driver.h
> > @@ -1376,6 +1376,68 @@ enum rte_eth_dev_operation {  typedef uint64_t
> > (*eth_get_restore_flags_t)(struct rte_eth_dev *dev,
> >  					    enum rte_eth_dev_operation op);
> >
> > +/**
> > + * @internal
> > + * Set cache stashing hints in Rx queue.
> > + *
> > + * @param dev
> > + *   Port (ethdev) handle.
> > + * @param queue_id
> > + *   Rx queue.
> > + * @param config
> > + *   Stashing hints configuration for the queue.
> > + *
> > + * @return
> > + *   -ENOTSUP if the device or the platform does not support cache sta=
shing.
> > + *   -ENOSYS  if the underlying PMD hasn't implemented cache stashing
> feature.
> > + *   -EINVAL  on invalid arguments.
> > + *   0 on success.
> > + */
> > +typedef int (*eth_stashing_rx_hints_set_t)(struct rte_eth_dev *dev, ui=
nt16_t
> queue_id,
> > +					   struct rte_eth_stashing_config
> *config);
> > +
> > +/**
> > + * @internal
> > + * Set cache stashing hints in Tx queue.
> > + *
> > + * @param dev
> > + *   Port (ethdev) handle.
> > + * @param queue_id
> > + *   Tx queue.
> > + * @param config
> > + *   Stashing hints configuration for the queue.
> > + *
> > + * @return
> > + *   -ENOTSUP if the device or the platform does not support cache sta=
shing.
> > + *   -ENOSYS  if the underlying PMD hasn't implemented cache stashing
> feature.
> > + *   -EINVAL  on invalid arguments.
> > + *   0 on success.
>=20
> What about on failure of the underlying ioctl call?
>=20
> > + */
> > +typedef int (*eth_stashing_tx_hints_set_t)(struct rte_eth_dev *dev, ui=
nt16_t
> queue_id,
> > +					   struct rte_eth_stashing_config
> *config);
> > +
> > +/**
> > + * @internal
> > + * Get cache stashing object types supported in the ethernet device.
> > + * The return value indicates availability of stashing hints support
> > + * in the hardware and the PMD.
> > + *
> > + * @param dev
> > + *   Port (ethdev) handle.
> > + * @param objects
> > + *   PMD sets supported bits on return.
> > + *
> > + * @return
> > + *   -ENOTSUP if the device or the platform does not support cache sta=
shing.
> > + *   -ENOSYS  if the underlying PMD hasn't implemented cache stashing
> feature.
> > + *   -EINVAL  on NULL values for types or hints parameters.
> > + *   On return, types and hints parameters will have bits set for supp=
orted
> > + *   object types and hints.
> > + *   0 on success.
> > + */
> > +typedef int (*eth_stashing_capabilities_get_t)(struct rte_eth_dev *dev=
,
> > +					     uint16_t *objects);
> > +
> >  /**
> >   * @internal A structure containing the functions exported by an Ether=
net
> driver.
> >   */
> > @@ -1402,6 +1464,10 @@ struct eth_dev_ops {
> >  	eth_mac_addr_remove_t      mac_addr_remove; /**< Remove MAC
> address */
> >  	eth_mac_addr_add_t         mac_addr_add;  /**< Add a MAC address */
> >  	eth_mac_addr_set_t         mac_addr_set;  /**< Set a MAC address */
> > +	eth_stashing_rx_hints_set_t   stashing_rx_hints_set; /**< Set Rx cach=
e
> stashing*/
> > +	eth_stashing_tx_hints_set_t   stashing_tx_hints_set; /**< Set Tx cach=
e
> stashing*/
> > +	/** Get supported stashing hints*/
> > +	eth_stashing_capabilities_get_t stashing_capabilities_get;
> >  	/** Set list of multicast addresses */
> >  	eth_set_mc_addr_list_t     set_mc_addr_list;
> >  	mtu_set_t                  mtu_set;       /**< Set MTU */
> > diff --git a/lib/ethdev/rte_ethdev.c b/lib/ethdev/rte_ethdev.c index
> > d4197322a0..ae666c370b 100644
> > --- a/lib/ethdev/rte_ethdev.c
> > +++ b/lib/ethdev/rte_ethdev.c
> > @@ -158,6 +158,7 @@ static const struct {
> >  	{RTE_ETH_DEV_CAPA_RXQ_SHARE, "RXQ_SHARE"},
> >  	{RTE_ETH_DEV_CAPA_FLOW_RULE_KEEP, "FLOW_RULE_KEEP"},
> >  	{RTE_ETH_DEV_CAPA_FLOW_SHARED_OBJECT_KEEP,
> > "FLOW_SHARED_OBJECT_KEEP"},
> > +	{RTE_ETH_DEV_CAPA_CACHE_STASHING, "CACHE_STASHING"},
> >  };
> >
> >  enum {
> > @@ -7419,5 +7420,153 @@ int rte_eth_dev_map_aggr_tx_affinity(uint16_t
> port_id, uint16_t tx_queue_id,
> >  	return ret;
> >  }
> >
> >
> +RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_dev_validate_stashing_config,
> > +25.07) int rte_eth_dev_validate_stashing_config(uint16_t port_id,
> > +uint16_t queue_id,
> > +				     uint8_t queue_direction,
> > +				     struct rte_eth_stashing_config *config) {
> > +	struct rte_eth_dev *dev;
> > +	struct rte_eth_dev_info dev_info;
> > +	int ret =3D 0;
> > +	uint16_t nb_queues;
> > +
> > +	RTE_ETH_VALID_PORTID_OR_ERR_RET(port_id, -ENODEV);
> > +
> > +	if (!config) {
> > +		RTE_ETHDEV_LOG_LINE(ERR, "Invalid stashing configuration");
> > +		ret =3D -EINVAL;
> > +		goto out;
> > +	}
> > +
> > +	/*
> > +	 * Check for invalid objects
> > +	 */
> > +	if (!RTE_ETH_DEV_STASH_OBJECTS_VALID(config->objects)) {
> > +		RTE_ETHDEV_LOG_LINE(ERR, "Invalid stashing objects");
> > +		ret =3D -EINVAL;
> > +		goto out;
> > +	}
> > +
> > +	dev =3D &rte_eth_devices[port_id];
> > +
> > +	nb_queues =3D (queue_direction =3D=3D RTE_ETH_DEV_RX_QUEUE) ?
> > +				      dev->data->nb_rx_queues :
> > +				      dev->data->nb_tx_queues;
> > +
> > +	if (queue_id >=3D nb_queues) {
> > +		RTE_ETHDEV_LOG_LINE(ERR, "Invalid Rx queue_id=3D%u",
> queue_id);
> > +		ret =3D -EINVAL;
> > +		goto out;
> > +	}
> > +
> > +	ret =3D rte_eth_dev_info_get(port_id, &dev_info);
> > +	if (ret < 0)
> > +		goto out;
> > +
> > +	if ((dev_info.dev_capa & RTE_ETH_DEV_CAPA_CACHE_STASHING) !=3D
> > +	    RTE_ETH_DEV_CAPA_CACHE_STASHING) {
>=20
> Nit: check if all this can fit on one line under 100 chars. I think it ca=
n.
>=20
> > +		ret =3D -ENOTSUP;
> > +		goto out;
> > +	}
> > +
> > +	if (*dev->dev_ops->stashing_rx_hints_set =3D=3D NULL ||
> > +	    *dev->dev_ops->stashing_tx_hints_set =3D=3D NULL) {
> > +		RTE_ETHDEV_LOG_LINE(ERR, "Stashing hints are not
> implemented "
> > +				    "in %s for %s", dev_info.driver_name,
>=20
> Don't split error messages across lines. Text strings are allowed to go o=
ver the 100
> char limit if necessary to avoid splitting.
>=20
> > +				    dev_info.device->name);
> > +		ret =3D -ENOSYS;
> > +	}
> > +
> > +out:
> > +	return ret;
> > +}
> > +
> > +RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_dev_stashing_rx_config_set,
> > +25.07) int rte_eth_dev_stashing_rx_config_set(uint16_t port_id,
> > +uint16_t queue_id,
> > +				   struct rte_eth_stashing_config *config) {
> > +	struct rte_eth_dev *dev;
> > +	int ret =3D 0;
> > +
> > +	ret =3D rte_eth_dev_validate_stashing_config(port_id, queue_id,
> > +						   RTE_ETH_DEV_RX_QUEUE,
> > +						   config);
> > +	if (ret < 0)
> > +		goto out;
> > +
> > +	dev =3D &rte_eth_devices[port_id];
> > +
> > +	ret =3D eth_err(port_id,
> > +		      (*dev->dev_ops->stashing_rx_hints_set)(dev, queue_id,
> > +		      config));
> > +out:
> > +	return ret;
> > +}
> > +
> > +RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_dev_stashing_tx_config_set,
> > +25.07) int rte_eth_dev_stashing_tx_config_set(uint16_t port_id,
> > +uint16_t queue_id,
> > +				   struct rte_eth_stashing_config *config) {
> > +	struct rte_eth_dev *dev;
> > +	int ret =3D 0;
> > +
> > +	ret =3D rte_eth_dev_validate_stashing_config(port_id, queue_id,
> > +						   RTE_ETH_DEV_TX_QUEUE,
> > +						   config);
> > +	if (ret < 0)
> > +		goto out;
> > +
> > +	dev =3D &rte_eth_devices[port_id];
> > +
> > +	ret =3D eth_err(port_id,
> > +		      (*dev->dev_ops->stashing_rx_hints_set) (dev, queue_id,
> > +		       config));
> > +out:
> > +	return ret;
> > +}
> > +
> >
> +RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_dev_stashing_capabilities_get,
> > +25.07) int rte_eth_dev_stashing_capabilities_get(uint16_t port_id,
> > +uint16_t *objects) {
> > +	struct rte_eth_dev *dev;
> > +	struct rte_eth_dev_info dev_info;
> > +	int ret =3D 0;
> > +
> > +	RTE_ETH_VALID_PORTID_OR_ERR_RET(port_id, -ENODEV);
> > +
> > +	if (!objects) {
> > +		ret =3D -EINVAL;
> > +		goto out;
> > +	}
> > +
> > +	dev =3D &rte_eth_devices[port_id];
> > +
> > +	ret =3D rte_eth_dev_info_get(port_id, &dev_info);
> > +	if (ret < 0)
> > +		goto out;
> > +
> > +	if ((dev_info.dev_capa & RTE_ETH_DEV_CAPA_CACHE_STASHING) !=3D
> > +	    RTE_ETH_DEV_CAPA_CACHE_STASHING) {
> > +		ret =3D -ENOTSUP;
> > +		goto out;
> > +	}
> > +
> > +	if (*dev->dev_ops->stashing_capabilities_get =3D=3D NULL) {
> > +		RTE_ETHDEV_LOG_LINE(ERR, "Stashing hints are not
> implemented "
> > +				    "in %s for %s", dev_info.driver_name,
> > +				    dev_info.device->name);
> > +		ret =3D -ENOSYS;
> > +		goto out;
> > +	}
> > +	ret =3D eth_err(port_id,
> > +		      (*dev->dev_ops->stashing_capabilities_get)(dev, objects));
> > +out:
> > +	return ret;
> > +}
> > +
> >  RTE_EXPORT_SYMBOL(rte_eth_dev_logtype)
> >  RTE_LOG_REGISTER_DEFAULT(rte_eth_dev_logtype, INFO); diff --git
> > a/lib/ethdev/rte_ethdev.h b/lib/ethdev/rte_ethdev.h index
> > ea7f8c4a1a..1398f8c837 100644
> > --- a/lib/ethdev/rte_ethdev.h
> > +++ b/lib/ethdev/rte_ethdev.h
> > @@ -1667,6 +1667,9 @@ struct rte_eth_conf {  #define
> > RTE_ETH_DEV_CAPA_FLOW_SHARED_OBJECT_KEEP RTE_BIT64(4)  /**@}*/
> >
> > +/** Device supports stashing to CPU/system caches. */ #define
> > +RTE_ETH_DEV_CAPA_CACHE_STASHING RTE_BIT64(5)
> > +
> >  /*
> >   * Fallback default preferred Rx/Tx port parameters.
> >   * These are used if an application requests default parameters @@
> > -1838,6 +1841,7 @@ struct rte_eth_dev_info {
> >  	struct rte_eth_dev_portconf default_txportconf;
> >  	/** Generic device capabilities (RTE_ETH_DEV_CAPA_). */
> >  	uint64_t dev_capa;
> > +	uint16_t stashing_capa;
> >  	/**
> >  	 * Switching information for ports on a device with a
> >  	 * embedded managed interconnect/switch.
> > @@ -6173,6 +6177,160 @@ int rte_eth_cman_config_set(uint16_t port_id,
> > const struct rte_eth_cman_config *  __rte_experimental  int
> > rte_eth_cman_config_get(uint16_t port_id, struct rte_eth_cman_config
> > *config);
> >
> > +
> > +/** Queue type is RX. */
> > +#define RTE_ETH_DEV_RX_QUEUE		0
> > +/** Queue type is TX. */
> > +#define RTE_ETH_DEV_TX_QUEUE		1
> > +
>=20
> I'd prefer an enum for these.
> Why are the necessary since we have separate rx and tx functions for the =
caching
> hints.
>=20
> > +
> > +/**
> > + * @warning
> > + * @b EXPERIMENTAL: this structure may change, or be removed, without
> > +prior notice
> > + *
> > + * A structure used for configuring the cache stashing hints.
> > + */
> > +struct rte_eth_stashing_config {
> > +	/**
> > +	 * lcore_id of the processor the stashing hints are applied to.
> > +	 */
> > +	uint32_t	lcore_id;
> > +	/**
> > +	 * Zero based cache level relative to the CPU.
> > +	 * E.g. l1d =3D 0, l2d =3D 1,...
> > +	 */
> > +	uint32_t	cache_level;
> > +	/**
> > +	 * Object types the configuration is applied to
> > +	 */
> > +	uint16_t	objects;
>=20
> What are the objects? That needs to be covered by the docs, or make this =
an
> enum type so that it's clear from the typesystem what it applies to [thou=
gh that
> would require an array of objects and count, it may be clearer for user].
>=20
> > +	/**
> > +	 * The offset if RTE_ETH_DEV_STASH_OBJECT_OFFSET bit is set
> > +	 *  in objects
> > +	 */
> > +	int		offset;
> > +};
> > +
> > +/**@{@name Stashable Rx/Tx queue object types supported by the
> > +ethernet device  *@see rte_eth_dev_stashing_capabilities_get
> > + *@see rte_eth_dev_stashing_rx_config_set
> > + *@see rte_eth_dev_stashing_tx_config_set
> > + */
> > +
> > +/**
> > + * Apply stashing hint to data at a given offset from the start of a
> > + * received packet.
> > + */
> > +#define RTE_ETH_DEV_STASH_OBJECT_OFFSET		0x0001
> > +
> > +/** Apply stashing hint to an rx descriptor. */
> > +#define RTE_ETH_DEV_STASH_OBJECT_DESC		0x0002
> > +
> > +/** Apply stashing hint to a header of a received packet. */
> > +#define RTE_ETH_DEV_STASH_OBJECT_HEADER		0x0004
> > +
> > +/** Apply stashing hint to a payload of a received packet. */
> > +#define RTE_ETH_DEV_STASH_OBJECT_PAYLOAD	0x0008
> > +
> > +#define __RTE_ETH_DEV_STASH_OBJECT_MASK		0x000f
> > +/**@}*/
> > +
> > +#define RTE_ETH_DEV_STASH_OBJECTS_VALID(t)
> 	\
> > +	((!((t) & (~__RTE_ETH_DEV_STASH_OBJECT_MASK))) && (t))
> > +
> > +/**
> > + *
> > + * @warning
> > + * @b EXPERIMENTAL: this API may change, or be removed, without prior
> > +notice
> > + *
> > + * @internal
> > + * Helper function to validate stashing hints configuration.
> > + */
> > +__rte_experimental
> > +int rte_eth_dev_validate_stashing_config(uint16_t port_id, uint16_t qu=
eue_id,
> > +					 uint8_t queue_direction,
> > +					 struct rte_eth_stashing_config
> *config);
> > +
> > +/**
> > + *
> > + * @warning
> > + * @b EXPERIMENTAL: this API may change, or be removed, without prior
> > +notice
> > + *
> > + * Provide cache stashing hints for improved memory access latencies
> > +for
> > + * packets received by the NIC.
> > + * This feature is available only in supported NICs and platforms.
> > + *
> > + * @param port_id
> > + *  The port identifier of the Ethernet device.
> > + * @param queue_id
> > + *  The index of the receive queue to which hints are applied.
> > + * @param config
> > + *  Stashing configuration.
> > + * @return
> > + *  - (-ENODEV) on incorrect port_ids.
> > + *  - (-EINVAL) if both RX and TX object types used in conjuection in
> > +objects
> > + *  parameter.
> > + *  - (-EINVAL) on invalid queue_id.
> > + *  - (-ENOTSUP) if RTE_ETH_DEV_CAPA_CACHE_STASHING capability is
> unavailable.
> > + *  - (-ENOSYS) if PMD does not implement cache stashing hints.
> > + *  - (0) on Success.
> > + */
> > +__rte_experimental
> > +int rte_eth_dev_stashing_rx_config_set(uint16_t port_id, uint16_t queu=
e_id,
> > +				   struct rte_eth_stashing_config *config);
> > +
> > +/**
> > + *
> > + * @warning
> > + * @b EXPERIMENTAL: this API may change, or be removed, without prior
> > +notice
> > + *
> > + * Configure cache stashing for improved memory access latencies for
> > +Tx
> > + * queue completion descriptors being sent to host system by the NIC.
> > + * This feature is available only in supported NICs and platforms.
> > + *
> > + * @param port_id
> > + *  The port identifier of the Ethernet device.
> > + * @param queue_id
> > + *  The index of the receive queue to which hints are applied.
> > + * @param config
> > + *  Stashing configuration.
> > + * @return
> > + *  - (-ENODEV) on incorrect port_ids.
> > + *  - (-EINVAL) if both RX and TX object types are used in
> > +conjuection in objects
> > + *  parameter.
> > + *  - (-EINVAL) if hints are incompatible with TX queues.
> > + *  - (-EINVAL) on invalid queue_id.
> > + *  - (-ENOTSUP) if RTE_ETH_DEV_CAPA_CACHE_STASHING capability is
> unavailable.
> > + *  - (-ENOSYS) if PMD does not implement cache stashing hints.
> > + *  - (0) on Success.
> > + */
> > +__rte_experimental
> > +int rte_eth_dev_stashing_tx_config_set(uint16_t port_id, uint16_t queu=
e_id,
> > +				   struct rte_eth_stashing_config *config);
> > +
> > +/**
> > + *
> > + * @warning
> > + * @b EXPERIMENTAL: this API may change, or be removed, without prior
> > +notice
> > + *
> > + * Discover cache stashing objects supported in the ethernet device.
> > + *
> > + * @param port_id
> > + *  The port identifier of the Ethernet device.
> > + * @param objects
> > + *  Supported objects vector set by the ethernet device.
> > + * @return
> > + *  On return types and hints parameters will have bits set for
> > +supported
> > + *  object types.
> > + *  - (-ENOTSUP) if the device or the platform does not support cache =
stashing.
> > + *  - (-ENOSYS)  if the underlying PMD hasn't implemented cache
> > +stashing
> > + *  feature.
> > + *  - (-EINVAL)  on NULL values for types or hints parameters.
> > + *  - (0) on success.
> > + */
> > +__rte_experimental
> > +int rte_eth_dev_stashing_capabilities_get(uint16_t port_id, uint16_t
> > +*objects);
> > +
> >  #ifdef __cplusplus
> >  }
> >  #endif
> > --
> > 2.43.0
> >
