Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0EE2F532FA
	for <dpdk-dev@archiver.kernel.org>; Tue, 24 Mar 2026 09:04:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E6DC2402BE;
	Tue, 24 Mar 2026 10:04:53 +0100 (CET)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011060.outbound.protection.outlook.com [52.101.52.60])
 by mails.dpdk.org (Postfix) with ESMTP id C824F4025F
 for <dev@dpdk.org>; Tue, 24 Mar 2026 10:04:52 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OlVCitmpal3OkYBbFJ+O0cWUnJoJWq/Ec0wZ+cXa2Btlq6Uzr3PjIkNWuNvZZ7pkXVVsbX07G83M8t0/JEpc1/2Dk+Hq9dCFRqNZReQCGxqYCABi6pxSpzHr0i5+hv5f2gs2TqB0z1RNOdzsXRYpRVwECHed7oEMugpUaxgkC8HjTFnqW1BeW/2K01a+9DPvejrvr+6CdIxVqrW+gNDVAvj6v404M+k986gOZMFCuxosqVZ1VBAJMX5bDO0l6BlaEFfxV+6TDEbaLg/e2dk3V+pqVd4izOSoysxxrSfPH+ZFj2O8nN/HLr8te5lMW0et+qX7Vi7EpHLmL07tKdWwGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=312niJD8CGlUCRhnfohYNZhjPlh2aYDwVwK6yudBLXQ=;
 b=uQ+NSt17pBFmbsI3pmrZKMMvbuX2U7RbfqsGtTs6rrOX3/NS+GCbNyIT4zIZ+V8PyO6YAPFDn5YVgTNv/EBVaeE2Jycj1Dp6PlykmhSdwFgHyRzNRS60THC/lUjXvIowdPekqBz6m3qmDzFVBLYxmI2AdQLQsArizh4zsq3ZaJJ0WzWq7oypwQAzXmsxciTnjWEq7e+xDurQQ2VCV4PulG6AhMZWAQO0h5RUu0mZZetUMjeshUnpwxw1iyEAOLgk+M2SSiypdA8egXkRskcRMVB7oc07LKbLYXCl7DZXQd2b5El8Zq7Hc9kg7Aqu9a1W94I8laCNTMjDnA52ZKHhAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=312niJD8CGlUCRhnfohYNZhjPlh2aYDwVwK6yudBLXQ=;
 b=CLasDsjT53L9j8v19DT6rHxk+vNZZuafEbVZVzrIRqj+LqOPjibCiR/LP/izJRCmsBuQaA/y+jl4ZWROnIF1x2dQoGyvJ+X6ggWAvWiSTNJulFUP+imxbI2rwsJTLLnHxibhyBfPPMVulE189jtQnqZhftXFGQGl7B4r4vMGa1GlUTxf0c95VNw9uEgzCiIljV/5D03jjIxNZLHMoE00rmxpbuntEqqd28FQyXDvCbZnCLdFZ64UDSrTPFxW1lw0xkFR0i5F5ol+MNCE8D2QisEYJOdnEbod0xGYc3Iaml2dyYtzTtaCGWZQImYgqCgBMUUeGIPCKm3MtgEIfVifhw==
Received: from CH2PR12MB9541.namprd12.prod.outlook.com (2603:10b6:610:27e::21)
 by IA0PR12MB8648.namprd12.prod.outlook.com (2603:10b6:208:486::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.15; Tue, 24 Mar
 2026 09:04:50 +0000
Received: from CH2PR12MB9541.namprd12.prod.outlook.com
 ([fe80::1085:eeb0:9e9d:837]) by CH2PR12MB9541.namprd12.prod.outlook.com
 ([fe80::1085:eeb0:9e9d:837%5]) with mapi id 15.20.9745.007; Tue, 24 Mar 2026
 09:04:50 +0000
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Stephen Hemminger <stephen@networkplumber.org>,
 "a.schollmeyer@syseleven.de" <a.schollmeyer@syseleven.de>
CC: Aman Singh <aman.deep.singh@intel.com>, "dev@dpdk.org" <dev@dpdk.org>,
 Thomas Monjalon <tmonjalon@nvidia.com>, Slava Ovsiienko
 <viacheslavo@nvidia.com>, Raslan Darawsheh <rasland@nvidia.com>
Subject: RE: [PATCH] app/testpmd: warn on shared rxq switch mismatch
Thread-Topic: [PATCH] app/testpmd: warn on shared rxq switch mismatch
Thread-Index: AQHcXfWYKbIVKjLhH0u4CkmIiSEsE7W9BSeAgAEXE6A=
Date: Tue, 24 Mar 2026 09:04:50 +0000
Message-ID: <CH2PR12MB9541F8CC6EBE612A415B8B59A448A@CH2PR12MB9541.namprd12.prod.outlook.com>
References: <20251125102207.428661-1-a.schollmeyer@syseleven.de>
 <20260323091725.3440ad89@phoenix.local>
In-Reply-To: <20260323091725.3440ad89@phoenix.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR12MB9541:EE_|IA0PR12MB8648:EE_
x-ms-office365-filtering-correlation-id: 659023af-b619-4a9a-3cc9-08de898467d4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700021|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info: mGZH0VjMD7NKXU9WuA1dX3KkyUw7XeZt0Z9Yvj3bJ0w26rVotBIcSpn+Vj02TX0SHNqU2NhC7+YSF3XKZi0n6I+4vGxXQDG12W1QksEmGEMQEtUBrLHaxiq0oWwuovngJEaho9qLNallh2UKxSXIGqKk6+bNiLwNqzdJKJ1eJxWNGdBjLvHWXQ4uSl2MJb5mWabWfktwST7aEzyp7pK7XrUo+q0tVOVacWXOXEuj6sLpbKGl9Yart01ALKDXtGUwSCqcftp3jLqi7VG+SWSDaUdpGyYLTZ4q/CZrF25pVyiMAl5UjdTsLOiWBO9qMDzAk+0DaHfJodNnbUgAAuOxQYRHPPHCecS/K8yP1sTpQeeeeU+tL7nwM/vPAMZvnN3amYAXDCquJ4bX7TXpQo1Jc3vObGkJvU5pz7kH7EsMAsqkc8afLt+YjBGtP9Vbl2FS4jR8J85g3I0IILhY/sl5P3K+RMCuMNgCiW4mv+Nlld0TTyaeoi3Sog/rEAr6zA1R/95TC57qaPndyiRNTWYshRwYSclRofBaR7rFCY1R9OiS99teeD3YL/SQIPM0pHxInMVTbpihlw/q0Bs5xyS7C7DKYTnRsqDBt7rPspRektIeQPq1m1u9yxjypVLUzeyftAwFuz5nIpjJUwu5AkgRZUSu9mMgaN0QzjkvTnkqymQhS4iBAKmxP12Mmig7F/qIO0fKvnxaEZ42HTNycpdAalwkOIy4zIJo764Ih1QasjZK+VjiVMt38NunoAruLWZR81OcMmDuKkMWZDYp+rAoSEWJedwRS7K475Z4e7DN2GY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB9541.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?WnPS630uKv35fGkTAZ9xBl5Ai1w51fqmPq4hrScnpg/NpgxxjydJMog1mU8B?=
 =?us-ascii?Q?9LfuCTuLu7zlKYqSV9CX+tXxL9vglS3okoHeCp7XOYM4VzbfDi1zfuUO3cQA?=
 =?us-ascii?Q?425i/G/k9JEj3nac5eL5IZMqWrEYHvfY6AjaoaZJ7lAwWxYjjvNUuRefiHtr?=
 =?us-ascii?Q?oZnWc6mL1DvMoXN7y7MJGP0316KLWnmc/c+EGukLWgx1DDHeVzNjTeg62KIT?=
 =?us-ascii?Q?2laLvQMLDDdNphyqDXRL25w6nh/xDRPjuUcG2DbmdXp0YI1nwifCPP5BVUli?=
 =?us-ascii?Q?1RJ3zIwfK0SC9EIEaWG6aRrFjU7HjDJu1+qTuBrFx/TkTRt9Hozu5v0D5j87?=
 =?us-ascii?Q?U18qHMR0G1TFf0fz9hDhF0Vr1RAyhCL4Y6CI4ywrDX8rAIDG90bI5s9xLXzB?=
 =?us-ascii?Q?lgFAvR0aHfovEe7ZQlM+lblz/0R5j72dyyD88OigU1T1qEAoAvG2oxmJY7+O?=
 =?us-ascii?Q?+kDd8dJWCdgBAvfdogl0vV+gdAuPbm2LoNoYkiIravaGS9cE4YmPG8x5ODmh?=
 =?us-ascii?Q?6MCjIybbKu5ZDsZ/fgns4eC6R+YQhdyDrdPLC/kyTkLxIgKrOKJk0vUtUou8?=
 =?us-ascii?Q?8Fevc9PwLh5ZOFNF1NgTIBLOhVUMExkhzLjEO7zEGN4x4DxhNXMxwTTdcVST?=
 =?us-ascii?Q?W1EHyzl9KIEXG0UoIPlsF5qgRA22QPxxyMc7gAUWLDUTTOKmBCaBNHFrcu3m?=
 =?us-ascii?Q?sqCA6dsY3QYQr0dOEYnQZDm1xcY2vz/Y8tar8IZfbk+DOLBvCK3GCdZAVjhI?=
 =?us-ascii?Q?xf0s6LlmLot94R2Jn0IH43OrfOTjWy1zQ1cS7cAb0p+BoidKIGDoRUdP8CEc?=
 =?us-ascii?Q?iT72NaS0RY7Boz4g/giLHoaFpjijQrx+jr40skTxi2fCsnG+3omQvun5G/jo?=
 =?us-ascii?Q?PkRysliCRLB/NmZqdgo5TONwgjR3bM4fZ7tdyMLt6bnebP3btcCNaZL6ELG/?=
 =?us-ascii?Q?HmWjI4V4xXKLVsXctrvyYXqgizCW3Y42/xTCH+Ad/JNOoEBkQPCl2bUx12Ks?=
 =?us-ascii?Q?iOecdxtsPRpIL/bEv/C8MfSLySu7naBkF7pISlIqwirrWNZTtd99rxcxbblk?=
 =?us-ascii?Q?UrZemdTYlYum3HKwNLfHA/rynqW/q4jmwJGL6102trhb6ollqjeZLHf7edTo?=
 =?us-ascii?Q?f0DC2MnVaRPuRSVs1ipR0mUnUkhAUe97+LluBFGUvLney1QXePSlJYlviMXN?=
 =?us-ascii?Q?uD6PcfNIAaLU4ri/15KeYSTBUMyuALb6wB84TdyhgVj2ghc7gfJVVHN/ZB0D?=
 =?us-ascii?Q?PCDgQXyqmS+yCEcLUvb/a5W35Dtws7gMCVst6+2+V5b1xJXd8el2dnG1LE3O?=
 =?us-ascii?Q?e911ORIIabKqPsVd/RIuyn1p3EZPRbj//wy1S2iaoCYHfon02WMycET2f9m8?=
 =?us-ascii?Q?B+GgiJSZvt/gpw7yURAH6Dwz/rhqEo/C6X9KgpI9ZHIYcrgCAntkEXqEbVW7?=
 =?us-ascii?Q?icTNujvtzUCmOLhjhl9aUH1vTqzI9c/yJ5K9Iu76qjF1fpKriAfnEjuMPFzd?=
 =?us-ascii?Q?WZm6bScK9FOmNLMzAqc2hgxN2c0cNIwjwtFVv7RedBoGNsubcAKZDQh/HKas?=
 =?us-ascii?Q?iHRvfF1vHx+gLxowMdse9LAzRF3wRH2ZDG3qZ6Ze/3wMKGj1U6OZ68WxjUo2?=
 =?us-ascii?Q?FC0ePJ8rvPmsLBKHJfzpwid/biXyQB2M02N43SEV5iL195QuIalQAJAgTDzr?=
 =?us-ascii?Q?Rdtkb9XY77nbLm3NcI9L/s8th7257wmvJJtq14w/EtauZh4UDGe3TPyMYxQ6?=
 =?us-ascii?Q?421PnFrXhA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB9541.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 659023af-b619-4a9a-3cc9-08de898467d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2026 09:04:50.3361 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 91jJ4p+gFORY+fyDF9SB73QPfONsU1wLMx+8A0TBcHKKmqlP9UO575KeKWeep0g/ACugbshF/ABn0fhHJZRDvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8648
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
> From: Stephen Hemminger <stephen@networkplumber.org>
> Sent: Monday, March 23, 2026 5:17 PM
> To: a.schollmeyer@syseleven.de
> Cc: Aman Singh <aman.deep.singh@intel.com>; dev@dpdk.org
> Subject: Re: [PATCH] app/testpmd: warn on shared rxq switch mismatch
>=20
> On Tue, 25 Nov 2025 11:22:07 +0100
> a.schollmeyer@syseleven.de wrote:
>=20
> > From: Adrian Schollmeyer <a.schollmeyer@syseleven.de>
> >
> > Shared Rx queues do not work with every combination of ports. Besides
> > requiring the corresponding device capability, shared Rx queues also
> > require all ports of one share group and queue ID have the same switch
> > domain and Rx domain. When these fields do not match, shared Rx queues
> > are not properly set up and queue sharing may fail silently. This can
> > happen even in some less intuitive cases like multiple VFs of one
> > physical NIC.

Adrian: Could you please elaborate what kind of issues have you faced with =
shared queue configuration?

> >
> > To make debugging issues with shared Rx queue configuration easier,
> > this commit introduces simple checks and warning messages for all
> > members of a share_group and share_qid to warn whenever there is a
> > mismatch in the switch and Rx domain.
> >
> > Signed-off-by: Adrian Schollmeyer <a.schollmeyer@syseleven.de>
> > ---
>=20
> Why is this not handled at ethdev or device level?

Are you referring to share group index logic?

Based on current implementation in ethdev and mlx5 PMD,
assuring that share group indexes are unique is not needed.
Share group index is not required to be globally unique since
sharing works only within the same switch and Rx domain [1].

>=20
> Testpmd is just a test program. Real applications might make same mistake=
.

Best regards,
Dariusz Sosnowski

---

[1]: https://inbox.dpdk.org/dev/yotjxacqrodttraqrr3r6ftut4cty66g6cjnr5ughsw=
tatapgh@gqqkftskp3qq/
