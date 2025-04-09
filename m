Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E527C36002
	for <dpdk-dev@archiver.kernel.org>; Wed,  9 Apr 2025 10:08:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6BF3D402D5;
	Wed,  9 Apr 2025 12:08:44 +0200 (CEST)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2048.outbound.protection.outlook.com [40.107.223.48])
 by mails.dpdk.org (Postfix) with ESMTP id 1AFFF402B7
 for <dev@dpdk.org>; Wed,  9 Apr 2025 12:08:43 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EGb8yCDRU69gwTyPt2wYPse5YJEuSbEYMadYmdYaLHz3DnB88Dnw6q4aUkX2O5hEq3jVUNiKlEDWWlDjqlR2CvYS3wNPEHPyTLgV5gDUbvGV1SBdlG0HPxaoElwXq6qkRBCUNFErJPOdOFwyeV6o2dkBMtoer8n2M9SdI2LE4D+XXE8lml3GZODnMcEtKSQC7KvWrfna7iTz2IAViH220Bg9ZUMQqLRbLy06hMTYP99lXAhs5qsFE8iUnM8ZvyBqIix1E75p7AdGItRHdJrL4E/GAsdgqqRKJnzDYejjsX8rA9x8vkkMD6JQeU6K/vyBGONb3UzKlApm1I96gK/t9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ISKL5HaUrgMJb0UFR8X9z2Qq5adqptzcbnsDfn4l6QA=;
 b=chOYDv3aqXAatvl81jKkgpxFmm/Z5EG0k0kx0GFev6lOxX9zfLn82WSyYGDcQrxQL5BNcp8v3TljEivb6yBFFEh6EroyTMO8Gv6hQ0Xq8cvjbsJ0aZdYLUpKKTuXTAUyMnJWc1ZSsXv7JcOkE0LbJ7zK9H7mkaPQZ6R55ST0stM6TbLy2u+29XreVMlGiUFvSYhISvxkMFDGKCAOj0OvUsutt/Q8yJU3Zap2WAqxeJDoiyYxn8XW8AYpMkTVXAMcEKXatpSuPNSmOY4lN9ie0BJ6oRnEDiyuxdzyNOXkjg8IB3h9MSTJUrYdgUZUpO1eU3nxthAApSG7jtOZOIzxbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ISKL5HaUrgMJb0UFR8X9z2Qq5adqptzcbnsDfn4l6QA=;
 b=YrS/WtdYigK3OAHRBgm2r0kUUujt1TIRYcecSI7M2y5CJKXA8MAsYrMB7yqq8mvQhdoxuwydHlGjrvhrPubM4EvaHdhmHteoHs66VphdKFVJaPxEhmq3zTjBDmSXO2q0W2HSgk+C2DT5S7bCzK4bGiJ++F9Fu7blx6Z4UzpoP5Y=
Received: from PH7PR12MB8596.namprd12.prod.outlook.com (2603:10b6:510:1b7::6)
 by CH3PR12MB9100.namprd12.prod.outlook.com (2603:10b6:610:1a8::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.33; Wed, 9 Apr
 2025 10:08:38 +0000
Received: from PH7PR12MB8596.namprd12.prod.outlook.com
 ([fe80::a011:943d:7291:8069]) by PH7PR12MB8596.namprd12.prod.outlook.com
 ([fe80::a011:943d:7291:8069%6]) with mapi id 15.20.8606.029; Wed, 9 Apr 2025
 10:08:38 +0000
From: "Varghese, Vipin" <Vipin.Varghese@amd.com>
To: Jan Viktorin <viktorin@cesnet.cz>
CC: "dev@dpdk.org" <dev@dpdk.org>, "roretzla@linux.microsoft.com"
 <roretzla@linux.microsoft.com>, "bruce.richardson@intel.com"
 <bruce.richardson@intel.com>, "john.mcnamara@intel.com"
 <john.mcnamara@intel.com>, "dmitry.kozliuk@gmail.com"
 <dmitry.kozliuk@gmail.com>, "pbhagavatula@marvell.com"
 <pbhagavatula@marvell.com>, "jerinj@marvell.com" <jerinj@marvell.com>,
 "ruifeng.wang@arm.com" <ruifeng.wang@arm.com>,
 "mattias.ronnblom@ericsson.com" <mattias.ronnblom@ericsson.com>,
 "anatoly.burakov@intel.com" <anatoly.burakov@intel.com>,
 "stephen@networkplumber.org" <stephen@networkplumber.org>, "Yigit, Ferruh"
 <Ferruh.Yigit@amd.com>, "honnappa.nagarahalli@arm.com"
 <honnappa.nagarahalli@arm.com>, "wathsala.vithanage@arm.com"
 <wathsala.vithanage@arm.com>, "konstantin.ananyev@huawei.com"
 <konstantin.ananyev@huawei.com>, "mb@smartsharesystems.com"
 <mb@smartsharesystems.com>
Subject: RE: [PATCH v4 0/4] Introduce Topology NUMA grouping for lcores
Thread-Topic: [PATCH v4 0/4] Introduce Topology NUMA grouping for lcores
Thread-Index: AQHbL22WzCqF9Lj5SUqurJMDjBRIs7N4JwKAgCPluoA=
Date: Wed, 9 Apr 2025 10:08:38 +0000
Message-ID: <PH7PR12MB859601B11BE68F7DB30C64D082B42@PH7PR12MB8596.namprd12.prod.outlook.com>
References: <20241105102849.1947-1-vipin.varghese@amd.com>
 <20250317144607.118a40b0@coaster.localdomain>
In-Reply-To: <20250317144607.118a40b0@coaster.localdomain>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=4ebd66a5-b19f-4180-a1fd-74a128e26712;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-04-09T09:57:25Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8596:EE_|CH3PR12MB9100:EE_
x-ms-office365-filtering-correlation-id: 9a8965fb-08ee-46c7-eb70-08dd774e7f73
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|366016|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?iURPBJHsS3o3IKvyyRfYWqif9oKsb1Pu78kYhmKIKmFiWjZifn5fyG2dMVC6?=
 =?us-ascii?Q?4AB9k6EaT/2LFbBn0Zac0Y/ooQ1z+lRB/D3aRWz+7OhQzQJkOG3pDp4deVfC?=
 =?us-ascii?Q?rm7bYllLBw8H45bTKj2MRbfHN0vZmBh+9kkdvbo8459wi27hgc03d5+2KUVB?=
 =?us-ascii?Q?HBBIfCDRcfG57ldl5hDsuEunpcLXI0fheGSYh7O9/ElmLEw11sdQqj0IEMTG?=
 =?us-ascii?Q?rhGqQpaaO1IEP9v84GVm6KEAIiSVGFI2GD/3U7q5fF1eGpY43M3/2hFma+I/?=
 =?us-ascii?Q?R3TQFflR4Z/wuG3hGs2diMv8am5Us6SpMoBt+tUnlQV6FkDouiW/huR2Gcys?=
 =?us-ascii?Q?uTtL93JxVwKvEHib9mBXTfbqRtswGmjxEVyAEwcs/2qHz+w1VVHAQS3fQEg7?=
 =?us-ascii?Q?WHTcn2IQhdlNd08sz0bLtSstrMy+r3jCPxalMYtTdfPcXxTs+WmqRaA89R4K?=
 =?us-ascii?Q?cTfmKjHrpqyyi/F/+Uqzv5a2UvKeLd9U2HtewGpI00fNmbC6EquxiHtND/19?=
 =?us-ascii?Q?Ge4N4quizgOlrdgIZmMqKaLgcV4GKP50s5GUpuEIP6flVq4uTFouvTDR5XsP?=
 =?us-ascii?Q?E6Bco2zSHvp7VMXfjO3bNC6pp5eu6I1pl2DsjfDEnQA9Wxq/GDH0SBpGwF26?=
 =?us-ascii?Q?5U4vH5Nmih4TUIkcRCgtC3cXuWxleuMaLqmJDum4ppVfkeVTidnoFDElPuwx?=
 =?us-ascii?Q?NWWTVGDetKANUl5/OkisWZRk0jgB0iqDLEkmSABQc+2svmX4ypXyc0G6lDUa?=
 =?us-ascii?Q?YsrmN+rvvxkJx7WJNosbrD5xNAaoT+Lyr41Hym7JbsHRTKxfhskQjvbUfvuE?=
 =?us-ascii?Q?ZorvNGa4xkoD8RGN03C8dimCtGTra6c8D6w5x8Vok5zZmkh7tNXeos4Ff9Pu?=
 =?us-ascii?Q?p6ABeaYJlBeM0ZPDXFJuAf5mIus3GtxGSjgX/oZQ7Wrbn3cabQn960mkCRyu?=
 =?us-ascii?Q?e/OiRcBx8HtwdFW7YE7aTsfNAhSHWEoUMj+G1CugJq/bJyX4vX4tUPFzS0jb?=
 =?us-ascii?Q?WxrJTYqNHdzAhVF/5ah7gcmAQq5GESdH+H1pJGyL9dXS3LsQ2SzlK/nkKxFG?=
 =?us-ascii?Q?BhTXwE11pvrQI9EbPaVbTzDrCfIzsmCkO1nO1fDx9EySVj1M2bae3hofWZCy?=
 =?us-ascii?Q?8iZ4Z3tOQNflqoGqn4Qugicw1nLS/+OGLF72suh30XBsjHDHVZaprpeDY7jq?=
 =?us-ascii?Q?IDLWKN9ZhVIzGAK7Va8RkrzqWvqTTDy3ZeXTTfmvX3TZ/+nO4FcwXSbb1hVZ?=
 =?us-ascii?Q?U6lmZaKEeygk2vtjHNT6osZfHBkzB0gpT1Tf4rPAOB1r5R+nIp4fnt15VH29?=
 =?us-ascii?Q?zSmOlViU/B0e7E/efWlLxhBrodKbdZByg4bo7G2xGIAba7qSCaazJS0/hCs3?=
 =?us-ascii?Q?lCusu5d7tbGLK7jfWQhU10Sf4APcAeFfAbQMSfaplifzoRld6LnRNz5uP3FP?=
 =?us-ascii?Q?oi4gmZQeq7tltDEElmmYTsJAzsT1a2Pczc3TzYNSgxVS0BTRv1xSDFGSeHON?=
 =?us-ascii?Q?09+9I6TD8iYASHU=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8596.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2r7jdePgAlKs/vv7z4EdOgGOCGNICqR50x5f+8eLoIR9CCGZoYcaAYGWf+mi?=
 =?us-ascii?Q?SDLxJ6gBNDm4mkmXLBvkmi/mOCadiQMlOj6jUU07mH8o4Ts5aPW13xWsGsOQ?=
 =?us-ascii?Q?2XWl2lN3W0F9Uq+mpF5le6pnGdjCmyawQnXhXFXHQfYpyS1syL3GnGQWy/ID?=
 =?us-ascii?Q?J7LfRLGBADbb5Y6wobQv5KADS7tWP/NVBxnS2BwOtOIlY9NyfbmZc/+Sp3DN?=
 =?us-ascii?Q?Zf6KnIwp6UWZreFxMy7MU3CbiCZod/LGt6rJDIxB+Xs9QGKr7/CNHDA0PQOD?=
 =?us-ascii?Q?tsQtWkgYYrgv1GCCAFJBn9Ze5/UEZ0hODjzyZglbYrlcXF2Ycxlvb8QcEPzG?=
 =?us-ascii?Q?4lwxK/nWj7jEQ1U1JjqklPtOCror/GWBSzGoy4Hj/pDB0zGWD/mDU54XASDM?=
 =?us-ascii?Q?DU+F1dudORK7PYHEEjKyB76mV4RwBcs00915W2aecWALB7YGyydVvSs5NzNy?=
 =?us-ascii?Q?Lfy4WATwIJUFCEppFOKrbjN/RdJspHyHAQShbb6lfPAcb2BtRZvq6V5sjAOR?=
 =?us-ascii?Q?oS/NuzoFTx00+h0In6i6eXbEPINTmPvodHyD5/TTC3EhRsmYBK4lCnqGutXO?=
 =?us-ascii?Q?1CZgCPF6KkqoU4Tmtx4i/qLdHa25XuN5hWdqeWFerUxXNgfDGlnZMYOSdmNv?=
 =?us-ascii?Q?RcWrYlO+cu4yIv1tMTc2wXWdAUSBBYRIBJhQvyp/eOh2IAdPG5z+ffFHhnFS?=
 =?us-ascii?Q?A9fQOyAIVLZUm71fzcChx1oNFqq/3D25z7842FodgD6DRzp+onjlSatUpQzM?=
 =?us-ascii?Q?tJElTnEc5Mkm4Vh8qKQ2gAOUS155tVijgZN+/gHsywxEon5MkApnhQwAvmHu?=
 =?us-ascii?Q?4emqnEy6Eb81SU6J0Ukpujp9TTFg9mS7zijYg75jkh00OdFPvOymGR6+fLzj?=
 =?us-ascii?Q?Q2Hk9+wnToh1SFuz4x2uGDoCRm+30LMAiNriShZmmHF9vxeCIrpqXTqL4pNZ?=
 =?us-ascii?Q?9u5PLR60zwZV0MAQYQtjSoy4+A6aeyw3yllgAAatFYb5D3uN1BxXBkql3BWa?=
 =?us-ascii?Q?LTlgWmODF6ys4ZUfazMJ0drba5D0f+zKAOd5N94/nbVHXasUL6ZPub1lpngD?=
 =?us-ascii?Q?ooanJHJpDDC1v3Q/Gb2bc6tC69TfC9z4sUhCZgaib/N9aNKvhgOGMhl5aWQ+?=
 =?us-ascii?Q?nxIvkWauY1TgFUgn0moG70e//1/d9B0acaeRAsLojWQkQVDSErmm9ptkFldV?=
 =?us-ascii?Q?xXIVizZzBa6Kexm0wcimICkuaK43HW06hYl2rLRWqhV9vUmmYUXsoqh4p+iy?=
 =?us-ascii?Q?t8VbIHmK0K6tjZQP/RZz2eC8hIO0lMjEX+ft7R1YKmDLDMYPK95wDI2m8fZ4?=
 =?us-ascii?Q?zTheg6F7zxwiCf5o16ZaPR6fprFyiETFiV1GGGwpdmViSLf/BUhCA+eqZB+H?=
 =?us-ascii?Q?rS8OXDR6WrkuTVof6AOQazkLq4pXQKXga3ToGU85CCrvme2CQ/MscW6bCc6n?=
 =?us-ascii?Q?oI6CBz2YovHhDLrfvO1AyfxEuGEW13j4PVpJdrMcZD+ogQiii0Jp47KD9Khw?=
 =?us-ascii?Q?+98CAbltSip0gn/lq6e6oK9ltCL/to7k5WQ1KfPQi9lCfmoLo96ADBofsn3f?=
 =?us-ascii?Q?e6SWOV78oPGKyJ/4eZ4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8596.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a8965fb-08ee-46c7-eb70-08dd774e7f73
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2025 10:08:38.5542 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q5VamjU+Wo2DEWZk3F4vPS38Mp1FWwf+6IjPHprANUMRznv8+CMY0SCpRwyCFQLPXVwkrvQdonyYxQFwTN/ynw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9100
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

[AMD Official Use Only - AMD Internal Distribution Only]

Snipped

>
> Hello Vipin and others,
>
> please, will there be any progress or update on this series?

Apologies, we did a small update in slack, and missed this out here. Let me=
 try to address your questions below

>
> I successfully tested those changes on our Intel and AMD machines and wou=
ld like
> to use it in production soon.
>
> The API is a little bit unintuitive, at least for me, but I successfully =
integrated into our
> software.
>
> I am missing a clear relation to the NUMA socket approach used in DPDK.
> E.g. I would like to be able to easily walk over a list of lcores from a =
specific NUMA
> node grouped by L3 domain. Yes, there is the RTE_LCORE_DOMAIN_IO, but wou=
ld
> it always match the appropriate socket IDs?

Yes, we from AMD were internally debating the same. But since there is an A=
PI in lcore API as ` rte_lcore_to_socket_id`, adding yet another variation =
or argument lack it luster.
Hence we internally debating when using the new API why not check if it is =
desired Physical Socket or Sub Socket Numa domain?

Hence, we did not add the option.

>
> Also, I do not clearly understand what is the purpose of using domain sel=
ector like:
>
>   RTE_LCORE_DOMAIN_L1 | RTE_LCORE_DOMAIN_L2
>
> or even:
>
>   RTE_LCORE_DOMAIN_L3 | RTE_LCORE_DOMAIN_L2

I believe we have mentioned in documents to choose 1, if used multiple comb=
o based on the code flow only 1 will be picked up.

real use of these are to select physical cores, under same cache or io doma=
in.
Example: certain SoC has 4 cores sharing L2, which makes pipeline processin=
g more convinent (less data movement). In such cases select lcores within s=
ame L2 topologoly.

>
> the documentation does not explain this. I could not spot any kind of gro=
uping that
> would help me in any way. Some "best practices" examples would be nice to=
 have to
> understand the intentions better.

From https://patches.dpdk.org/project/dpdk/cover/20241105102849.1947-1-vipi=
n.varghese@amd.com/

```
Reason:
 - Applications using DPDK libraries relies on consistent memory access.
 - Lcores being closer to same NUMA domain as IO.
 - Lcores sharing same cache.

Latency is minimized by using lcores that share the same NUMA topology.
Memory access is optimized by utilizing cores within the same NUMA
domain or tile. Cache coherence is preserved within the same shared cache
domain, reducing the remote access from tile|compute package via snooping
(local hit in either L2 or L3 within same NUMA domain).
```

>
> I found a little catch when running DPDK with more lcores than there are =
physical or
> SMT CPU cores. This happens when using e.g. an option like --lcores=3D(0-=
15)@(0-1).
> The results from the topology API would not match the lcores because hwlo=
c is not
> aware of the lcores concept. This might be mentioned somewhere.

Yes, this is expected. As one can map any cpu cores to dpdk lcore with `lco=
re-map`.
We did mentioned this in RFCv4, but when upgraded to RFCv5 we missed to men=
tion it back.

>
> Anyway, I really appreciate this work and would like to see it upstream.
> Especially for AMD machines, some framework like this is a must.
>
> Kind regards,
> Jan
>

We are planning to remove RFC tag and share the final version for upcoming =
release for DPDK shortly.
