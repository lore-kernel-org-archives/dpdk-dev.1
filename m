Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02FB9D2ED11
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 Jan 2026 09:33:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4FB1340DCB;
	Tue, 20 Jan 2026 10:33:30 +0100 (CET)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012036.outbound.protection.outlook.com [52.101.48.36])
 by mails.dpdk.org (Postfix) with ESMTP id C47834013F
 for <dev@dpdk.org>; Tue, 20 Jan 2026 10:33:29 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZDnRS0/shKwQFj8I/wReos4t3PhdtLPPHelbq9Rncp7H7KFShk+gCH2EjV9iKh4LXHScxwnoeSjEKm1bDyi6+BTnCt8xF4Swe2HjftqdNnFVPGt7jmz89urQn76F073Hcl08jUbD0PMfvzdkJMFGtk7Ghcp0/owAIHDIDQRZgu8MrUBQVY3aRg4lddhCro1omoe0b12tlVkABKyNwOFWNIq5XdYSKxl9paUCTek95DOp1ygyIAmVUHHm/ZVaSvc1tf0Wo1ZVucu6m9vEZig9KgVJgo3p3JMMCoF6giIUIhgpE2kEDIv1CMn31kVUI6QYifr1oVCkdTDJgeUvOd5INQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yrTqgmK9ffcKyd0yhoYEGmfGS1zzmTg2Is/iEb4fVvk=;
 b=lZbhNA5MoPbayOvrgELNjNL0/vanHxMv8Fd+akD7usRnTgv5krolCpR0GQD4Q/79k62qTHWfhpi18B63c77G1i30l7/FFWNeMQ/5+LElC6HElt8VSsdfhPKjHP4udQ6aOD9VbQgfFMaX5xMbscWWHDPBko2hjfGO3xuKnGhanzZjvCNHtr++sw6UrVuWSTt9nIy1YRXzd/b0VG/i3mUA2mc2ipic9D7QHl1WTU1qjpE8x0a9hV2eE+6fa+ddRlbqeS2kAZCkLwP24bEP5FEkdMKDIwXesqfAU/X8c/lwvXeN3KaLAQrNYB1zyRTL0vmzChAF2marwh+5e6yxpyCk8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yrTqgmK9ffcKyd0yhoYEGmfGS1zzmTg2Is/iEb4fVvk=;
 b=vlMzx+tx2dHgNQL1Jkg/oBywCLAfdfdTy8j+PdHSfsZq4wgsxcvtUYJNKnbdwR3zLxND8PjD3oqkyYAGZIqKOIbWgmBaNWgmqgmdMFxB1db9UQWT6txb4fAkasxyf1BpdLQOQ9g9HdnfRWF02HUbSS0sdBPacdXt2ISl747ilhE=
Received: from PH7PR12MB8596.namprd12.prod.outlook.com (2603:10b6:510:1b7::6)
 by PH0PR12MB7815.namprd12.prod.outlook.com (2603:10b6:510:28a::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.9; Tue, 20 Jan
 2026 09:33:27 +0000
Received: from PH7PR12MB8596.namprd12.prod.outlook.com
 ([fe80::5909:724e:563f:49d1]) by PH7PR12MB8596.namprd12.prod.outlook.com
 ([fe80::5909:724e:563f:49d1%5]) with mapi id 15.20.9520.011; Tue, 20 Jan 2026
 09:33:27 +0000
From: "Varghese, Vipin" <Vipin.Varghese@amd.com>
To: Stephen Hemminger <stephen@networkplumber.org>, "dev@dpdk.org"
 <dev@dpdk.org>
Subject: RE: [PATCH 02/11] doc: correct grammar in AMD platform guide
Thread-Topic: [PATCH 02/11] doc: correct grammar in AMD platform guide
Thread-Index: AQHchy13+xLc2gRUDUmXJSFRZw97m7Va0SSw
Date: Tue, 20 Jan 2026 09:33:26 +0000
Message-ID: <PH7PR12MB85966FF804E5944705E465048289A@PH7PR12MB8596.namprd12.prod.outlook.com>
References: <20260116211649.104776-1-stephen@networkplumber.org>
 <20260116211649.104776-3-stephen@networkplumber.org>
In-Reply-To: <20260116211649.104776-3-stephen@networkplumber.org>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2026-01-20T09:33:22.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8596:EE_|PH0PR12MB7815:EE_
x-ms-office365-filtering-correlation-id: 6cc062c9-3fe9-4203-acd4-08de5806f6f3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?XQOHZWEjVkmQrjhwKvydwrWn8qGTFew4rqkEUCtik1Nc6+GEFhuDGI2tX74A?=
 =?us-ascii?Q?hfyE3XW0W4t7HtVrASI/y/LYUVQo9FMhzyUY0Z8OVHYOdAWwN0qLOGkgJjDH?=
 =?us-ascii?Q?rzxWqsa+0zLIpLU2OGD0l8/DoRXpO7YFpPkBOTK+Y0+LnYs5FxVH88GdyNx4?=
 =?us-ascii?Q?22fAvtSdzbLfzUmwEj1iZ8ZHv2QrbsoMSVWqDLUMzhZVnAStrbhvjMu15UV9?=
 =?us-ascii?Q?bjAzWpXqWakQEP4YSIvlaZpSO/LDfTF0kKL8XCDJUD5y6e5dLGIwkXpADkAm?=
 =?us-ascii?Q?ZnSrfl0Xo/hz9afUHek5ONccdI1FJmhPP31zJp9Dt3AbQITwmexYx1mFYMWJ?=
 =?us-ascii?Q?uF6UaifaFGDZScv3q4eiA9uWe3IORJW4W5tCPK9nGckMVbh05W7IPJEK1V00?=
 =?us-ascii?Q?WtiJrqbSCZffHMOW2AdwxvxcEmF8/AWslKExesIV6SfhjfhJt8cEryBElxt/?=
 =?us-ascii?Q?7j/ezDvatqW1ng752KzIQGvFHjbpRSryuWhNaTV6p02Wg0zq6L0eHDLSFzLU?=
 =?us-ascii?Q?T60Fc8HwCDf96ER9NNjJGp7jBqABq/yg8lqkRFOPzVDl0mL+oVVC2hBOz7Pa?=
 =?us-ascii?Q?J+LGIpkvLm1Lei16fup5TwdmFygO/aCciYMr3yFcvmiIrsI3/W47ee7XqL+W?=
 =?us-ascii?Q?cF+k+Hl5JWg76GczbMgvU6930+SPsfALxpOM29SnNiAv/4AkxYutmqi95627?=
 =?us-ascii?Q?AaZlw05861j62Ya2VwHvhbpgC9TSkc4YHUFrqBUC0QYEEyDJxEp+gyj7VwuE?=
 =?us-ascii?Q?IZPz8erQrRzDejjit6Runzp1MPEn2YjeTaOorjqMEDbgF1YEIisLHAnTz7tD?=
 =?us-ascii?Q?/IdhM4e9eCVM3lzq0+KUEwfiqTvUgS3+gmoWLn4MA4oQjhXju8fnZ2x+D1R+?=
 =?us-ascii?Q?t4hRP/tvX4mnL1F/Uo8XIMYPjn1DG2QbjxkV0YzMQ2zXkN4bJI4raxoYqgJY?=
 =?us-ascii?Q?yPCxaCOi+4PTuXf3nBl18p4S4F04KrJV0tShs67BIwvUbpHDDziQvhdd6Zqg?=
 =?us-ascii?Q?6so2l1X479yPK+hrAYdZfuwdL32b9tDisGmlPv6myaN0NzOyw0vl2jiw2itG?=
 =?us-ascii?Q?oTjy7nGC0yB5SMwtB9bpUKOLZR+acvMFCaaO7gNhcxvhokWmcN9eKKH4Q4Hq?=
 =?us-ascii?Q?WicEJW/vDXmDV+wt/8DHCFYhWrjCvnCx1/nyzsGL1QYAAIs808GjzL4jKz5l?=
 =?us-ascii?Q?Nz0RAS9K+4wN2DFVuV6ZQnK4fOL88rXcY7XFI+qrSth29rcofZ8RcqY39brl?=
 =?us-ascii?Q?gNPvBzllLmVmC3iFcjp1XhaMNs/U8Svq7QLEvPmXPUg9akKvofhV+gxvLKav?=
 =?us-ascii?Q?LjTJQ4eM5hvlEioZ7qKphrBGiPVbISsqEI2uRutVlQsGnOcHvLKq4zkQAJRh?=
 =?us-ascii?Q?oEa1u5GBRQKoKucpaUfeM4rCbKFQVNJEU0lGarLKdfvyPUwmExsGDm0N6VAo?=
 =?us-ascii?Q?3oxvZc/P9mSmdpyuQtcufkEzaaxhIEuDdk7kioVnGukcu10PMAP++AL9qTqu?=
 =?us-ascii?Q?Ya56eZJ62GjEYqi7j0sB04dpPnT2OKb8BDzFL4iYhOxmva8FPRqGej6C5AJA?=
 =?us-ascii?Q?tLXtlmjpXI2fF01calJ8OjsP0eFPMkNDl1fwlSrCZgm4rzvIyZ3oqcjG+6r5?=
 =?us-ascii?Q?yaetjwoYnzZgtFa+FW3tZsI=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8596.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?FwY4J06QHiZJuztVbspwRPKuo6qikylxNgP98Z5KDlsW5NIDWPTIX1GW1YNC?=
 =?us-ascii?Q?9cPFNkU0KTOSaATwDxQNaHujvPupoOWt4sF29jrlIjVl2wPe7gR4ha07Kod2?=
 =?us-ascii?Q?o346Td4LV4ISzcJKaA1auOV6zpeO/JXK+3xy8+VemOZpGqEyTCibxwUeIn69?=
 =?us-ascii?Q?8zDOhvy77x5yAzOtACLgAMln91EHghjicDtskcR9wKuxRabYuOomu2jIq7C9?=
 =?us-ascii?Q?a6F/dJ7SLY670GpLUkhb5WkVXhjxDwQ1lrmvBYlvXdJbNWB8IGeSg806RRWL?=
 =?us-ascii?Q?ymtrHXNtYBMD1CnM8zkG50gjmA2j07Zm0+nvE8SrLJ+wkSjGct7TTEBfNWHs?=
 =?us-ascii?Q?XFBpNXXulw9bVniJxK+Jvq/nZ68MbxkNeSa1c1TAodflOQFrvpUNpYiKmE3V?=
 =?us-ascii?Q?f6/5hBE8ZQBiSTJqeeTZFglOMJ+CSVo79IhdFB3XBhJDsszFPefMfMts1Oy+?=
 =?us-ascii?Q?h+tg/A7i1evSyyDMjGi28wCkCis5tFjNZPcVLZ3n531vC433EQ/bsEru7Ngo?=
 =?us-ascii?Q?UD1GEEEZkLzA1BCe7Mcfa5xyuoCw9wsBrm10dm9PLtxNkXikyt72jWoq13gz?=
 =?us-ascii?Q?Xr2cfvAB8dRVl4fPHyGTL0O4aysPaygqsGs1YbhWlLjb8U9H7/7WFE/CG2YC?=
 =?us-ascii?Q?XcftxeJJSa8UpEkSEXfR0UcNHkQczplPlL3bXXJOGQ/X9AJn4si463mom0Vv?=
 =?us-ascii?Q?sr25bdYU1Y1hZOHTaH2J4UYAi+WQJRL+Aw//xiA2O5VSK7V0hZYv1NbV0keP?=
 =?us-ascii?Q?+tMtw5BjtDXafHlO7bF2R2p48pOHhRnUZRtfV4AgZKwlKC+hwaq8h0sfGpnw?=
 =?us-ascii?Q?sAHzlOjLsZ7Vq7dkBgVsXkEsg4B8+5SciJaaT8ToW0YjeHthXH14crC8tSB/?=
 =?us-ascii?Q?qtjILalJLRu26nywPqs2ATNbPnv7zJm9nty0d4t+jEFULE1gtglzSzkyqW5S?=
 =?us-ascii?Q?U3Az5nnGG9ccP57CiI/BX2lawWgZ3PzpMPq5Tt4Pr4DKfRbBsYho9zDAcoXW?=
 =?us-ascii?Q?yhsZG8G1Drv2jVIcEHPf9awwJJczLMyfiJ99y9/Rbne1We7sgfLw9203AbM9?=
 =?us-ascii?Q?AwEFJyFglve7PLSke6W+zdz00miNWfRyPqwVqkj3W9cZZQ0PVMrff4DGDbpD?=
 =?us-ascii?Q?IqIpYfNbVYkXrq0r/sSyZ9N3/EX9FEcTpBfsZKqGm87Savr9zvsxhlL2y3yV?=
 =?us-ascii?Q?uyvmR8uAoZB5Eo6kpd/QYTy7TRwbM5t3QXu4HYD7a4xAz8enJ2jEUe/l6r9s?=
 =?us-ascii?Q?x31ClCWOyyG/sviAQhDL53JnPOcLUAcLCY2yLys/V9opXZE67ZTv0INv8TN1?=
 =?us-ascii?Q?99UOzEYf1PcTAAVYYIF4kl8OHN2bxbrV4zqvaMXt0Z4ZWCCa1MMLbTfu03NU?=
 =?us-ascii?Q?KktP374u/p7hPbzQPC1xevEoi71XVq6KMzd1VRqC9TfDcPpjV1nxkVOhrRWY?=
 =?us-ascii?Q?2F299re0T3n7VdOhgX+fGnRn9aZG3GHzrK70bfcoAE4MlzrF16KEe5GVm2lg?=
 =?us-ascii?Q?a86G3DEetkYeCJp8+OFGOlQtc9tOhFNQ6wbZa8YBHH0PusjWices3e6q0mM3?=
 =?us-ascii?Q?pCa52ZxQet9UD+RoOb7b1HrybCdyK8RSZB9eYEDC5NP43Ok7gcq8/G3t1vHz?=
 =?us-ascii?Q?SPkZKW7wQmJPhYm4CKpsSiH9ZaPGaP9i4lyUYKkncC4xFg86wvSxiUOg3BV8?=
 =?us-ascii?Q?29KaC9UtuFdbPhYtITH418sup/zfhG5ILhX/kS0BuAFuY0e6?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8596.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cc062c9-3fe9-4203-acd4-08de5806f6f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2026 09:33:26.8828 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oix4VZENfBLNKON15NEpZughL0C5xt+RLVxOjFg73RKMLwuzVVorJQ7z02yUV+bIH87Nm7M7AfrA8yLx35qalg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7815
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

[Public]

Acked-by: Vipin Varghese <vipin.varghese@amd.com>
