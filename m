Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D15EC87FD2
	for <dpdk-dev@archiver.kernel.org>; Mon, 11 Aug 2025 10:30:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8DFF140649;
	Mon, 11 Aug 2025 12:30:31 +0200 (CEST)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2043.outbound.protection.outlook.com [40.107.244.43])
 by mails.dpdk.org (Postfix) with ESMTP id 9FA60400D5
 for <dev@dpdk.org>; Mon, 11 Aug 2025 12:30:30 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OSaZ3SgDXo9M4NM5IDI7m5C+tyrdAONJjqfEisxrDJYfrtuqHBd4oK2DJ49X8OSHHAYHJXLsnd4Xf2F46nL7oaMgEd0jC30VxZX1+6qGzkrAI0/YwTPPN6nsjDooiborJrpy9iQYdplIKf7dA0XqzLK5m/0rMrkl1kSpkiawOndVspe2PJOHMbaCxBoaDojb6p81N/+HvXZxJU+0UA9Yv8PYsqzKznr+IhlPyIwjhP37ct/LAcNL88mFNTmherGSB6chLeya2ByC9+mwFi8mETpuiLbnJRxg1TVFUUnc4DrnXP1QnZIcD5QJ3Yx2LPv9dqmwGM//lSvh8wnmRPNTfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mEMKp8exgX2mP/GMmgmRbJ6N5u3qA49zRjzQIQrNab0=;
 b=PSWIHX+IpyG07XKg+fpCEo2EA2mv8vunkSW3FezIymElF8O+9KfKtLcHoNzJbxUdFPbIk5M5mlSnybeZRW4Mp0nvOgZdgn7Q2ove93iLlUuLjdwrl9x1Jt6Iha23p4J9nNKqdGiWZ+YNvzciXhTKUOygcTZxYznEqGSYcY1o2hRKKe1tCTaL+LeDTyfCDSEz5buSdxrNdrdOXxn5kZG97jCzsS+BZO7DQl+jlG+3HMzWebxidGa2Pse+y8F8oA/lBck86E5lJjYek2G9eO6APF1aRL1HfyQhAyewsKxQHyckP/K3C6GnwKNkkTaB8f32lCIvuN6HuKGjMupvpoK0ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mEMKp8exgX2mP/GMmgmRbJ6N5u3qA49zRjzQIQrNab0=;
 b=mdV9G5mMmfHnextXnIQT56untMHHCAKGbTICBPLZiRmzGDyuyMyYOyjKbs0CWq+zpFt3APGP5DurND1ciHPpridEjwbtUAVstIWRb7ajwNEanFgXL6dXAgFjkk46h/f7SkB/t6dAF166GYiEXk2fkJv0W4jMLy63Z2lulh5kCVg=
Received: from PH7PR12MB8596.namprd12.prod.outlook.com (2603:10b6:510:1b7::6)
 by IA0PR12MB7529.namprd12.prod.outlook.com (2603:10b6:208:431::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Mon, 11 Aug
 2025 10:30:26 +0000
Received: from PH7PR12MB8596.namprd12.prod.outlook.com
 ([fe80::a011:943d:7291:8069]) by PH7PR12MB8596.namprd12.prod.outlook.com
 ([fe80::a011:943d:7291:8069%2]) with mapi id 15.20.9009.013; Mon, 11 Aug 2025
 10:30:26 +0000
From: "Varghese, Vipin" <Vipin.Varghese@amd.com>
To: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>,
 "stephen@networkplumber.org" <stephen@networkplumber.org>,
 "thomas@monjalon.net" <thomas@monjalon.net>, "Yigit, Ferruh"
 <Ferruh.Yigit@amd.com>, "andrew.rybchenko@oktetlabs.ru"
 <andrew.rybchenko@oktetlabs.ru>
CC: "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [PATCH v7] app/testpmd: monitor state of primary process when
 using secondary
Thread-Topic: [PATCH v7] app/testpmd: monitor state of primary process when
 using secondary
Thread-Index: AQHcBTOmTMs4cZesWkSBbj/ohPqRp7RYGXxwgAArOwCAAFY/MIAAD4mAgASfR7A=
Date: Mon, 11 Aug 2025 10:30:26 +0000
Message-ID: <PH7PR12MB8596259B1F736357A7E9A3EB8228A@PH7PR12MB8596.namprd12.prod.outlook.com>
References: <PH7PR12MB85968E4B05D92C12C963F1E2822FA@PH7PR12MB8596.namprd12.prod.outlook.com>
 <20250808114909.1606758-1-14pwcse1224@uetpeshawar.edu.pk>
In-Reply-To: <20250808114909.1606758-1-14pwcse1224@uetpeshawar.edu.pk>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-08-11T10:24:15.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8596:EE_|IA0PR12MB7529:EE_
x-ms-office365-filtering-correlation-id: cb43a2bc-dbc4-4cb9-537b-08ddd8c21626
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?Zxbz/ceJhE2AWLhBatWXUUJoq/Bo+Ov87QVmzTdsBABCuktoj9/YerV9qdnJ?=
 =?us-ascii?Q?F5cH7F6Axwp4peiUexX80RPfgQsxzWzf/mqZ6RjnC9D+PP11PpKfYDM2ozY+?=
 =?us-ascii?Q?MesUCnTFQsSV4tpgKg//sg6WU5IZ0Q2NqW5LQknV4RIUrvv3H+xF5B1C8uoQ?=
 =?us-ascii?Q?mqAbF0220T8XGEVwjkCA9KkL7Gm6rkXlmbhHp18RZ8zK5IWQT1lysDTp870v?=
 =?us-ascii?Q?6TsceLOdXex1UPT9F+bp+l/N14e9U2/r+/0OHmoWGqpNG6O4KPF6g68HJPHp?=
 =?us-ascii?Q?OAEuAeN1o2kEtvpp9m2i2vsJjNmEq+y2StLLfoeugst/RmyeByEP6zz7LsHu?=
 =?us-ascii?Q?V6vLlXvAEMZyr/GkiDRbZhYFMTL2bkc7xvEcQBMxjA3lXMS1ikW6UM329nsO?=
 =?us-ascii?Q?idnVEZxrdr+eGdOkiCf0bBEr8kJBrvDKN0Ta4wGnpHOeRYmubTmx4Arxvwfi?=
 =?us-ascii?Q?rD8PhlZFvrZdx+LQ+vZdQb5IFiCCPC1NDEwSbM4LuloPsvVKNg/lgEYHx2U+?=
 =?us-ascii?Q?5D6TtUXBjD/fZC5yv4JOC/FNxAW4SNgKmyR9X/15dm6GtStRv5ZyOHGLlktD?=
 =?us-ascii?Q?kuj17LgXBZEgBy3zFvHD69GTVRUCOObclRgcuGyWB4NLyxGMAVmRJ4dzR2Pi?=
 =?us-ascii?Q?BZjURhEJiQr0s60QsM4BR7NDoxpzlM4TG+Ap80Evzce1x3tzkRDhdj/zgKFG?=
 =?us-ascii?Q?BCncTVheOep7E8LWEU/ovTbAFBVVUL4plksSSXFKz39RGmDjzTZbU0upzLRz?=
 =?us-ascii?Q?rRtWj2lE8M5wKgZm5Lp0RULn7iOhrkY9gvq2DnWqpYjLE+F/cPIAegvosGTv?=
 =?us-ascii?Q?1CyPW1RGy0CJVbg/kTWkj9SeUlrDpCAiXUxaZ549rMMFKPXrkZDLGi2eu9GK?=
 =?us-ascii?Q?0mgC5uyHXanldv/eoEvzEM2a2/iR4Q+gq9M8ka4/RjuG8mUVZcD1aPpk+vUp?=
 =?us-ascii?Q?s5jZ+EdkjSzFNZt3ncIu04HQYzAkRhgJSHrwfw9G+vKfO+f/UW91LDdZjMba?=
 =?us-ascii?Q?8UXGYUNnxXw9oHmdJMYbFnyr6AB495BKxSiKTONeYEb4jve4R6QgFnR1bILw?=
 =?us-ascii?Q?W4auCUZxucrOn+Mff7Og79cg1qprhJ/ATNfzHcVdPFO66B+hhil9626fW8Fu?=
 =?us-ascii?Q?GKJzhZgkDZNwqBi93HSnYquQSacW7+GNH1LZXLcZIzrvvWZ2Ul7n/tJaJLBk?=
 =?us-ascii?Q?w1HB805qZ4W1IDw1fMlYS5MQFsm27ItHR2TAoK8wlJtLeV/CdyAHIOhO9gCu?=
 =?us-ascii?Q?irlvVKQiUoJ9XvvJOfw4USNnquQHoO6XksAdTcLu4IcgYjHolj2NmUNh96n8?=
 =?us-ascii?Q?ftVmk4jB5ukd3waMkL/dJmWGfS7lGfihNVFsdBc4xRBWxwEoTlh7kh2a6xXq?=
 =?us-ascii?Q?aIdUB48VH9jviLNjuJCxx38EH0BJFSp2Nb6GW59xMuJwHbR3SsmnC94zjME+?=
 =?us-ascii?Q?XMlTjApW0tKg8YsiesS+nQNopqd78SeRFmc7j6bi6P6aVHZWZcxz3h8VJsL0?=
 =?us-ascii?Q?WEYauBgQjL8Vo1U=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8596.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7k8BnqOM25U0pbAmS/8pI07nTHZXEk+SOTEga8esqq+GtN/Lqx8o4SYmD52/?=
 =?us-ascii?Q?FVW7TInV+4j3yDHqZhhUDkqmC9dIlDo1i+64p3htf2oGM5TdOtfCKSeHiuoV?=
 =?us-ascii?Q?zFOvyl4JGEinMWYQx2gARabHBkQhKsGiO3DfYnFZdXDQvNfBROhYP63fK28X?=
 =?us-ascii?Q?R3R87n426yj4DxEYpsJK8trZrE4j9+WbAr2go4X3r/plEZdwzhkoa0eyFD3z?=
 =?us-ascii?Q?dZE2eukyDjcJPPcRHbDMg4pGZ0vQwRH/1jzwtlAvTq+76lh3jkfOijG/wPoF?=
 =?us-ascii?Q?n+cOhCKmPScXoCQKCdBL40QBSbdNOctCrWniXxd8WhLxV84tgrY1K+GTmQDL?=
 =?us-ascii?Q?uz+9PUNQQNT8egXLhiQeQ3c8ZJJsdq/LG/FW/H6/2ix0ioV2Ma0nW5E6NwDQ?=
 =?us-ascii?Q?I2z7SNYv75NZFnJoiIFhqgfuW93UhWmuD/LiQkiN03oS/ALvr2wLw1wOch8M?=
 =?us-ascii?Q?L6VNVri2FvcDkNgoTGIPaymFNq7ZC3PpvT9LFRRP6SfxWr3GKRZYpnApHpvn?=
 =?us-ascii?Q?QOnN4aWoA3278SPoUcBHhvWX1FFGMq1Fp3h4ni5x6qG5z10CCSGk7UsG3TW9?=
 =?us-ascii?Q?cw8TBb+DN56qV18pnmamPuytxY1L+uaUuFDJOR7vJLVRm6ia+7mPr7uN8B4I?=
 =?us-ascii?Q?B0VXTD47qVeE1Q9bPXsF0HJzgDm0Aqcakr9TZFAonImdyz907r4O05KJSq77?=
 =?us-ascii?Q?WTJHyVgXocZ2KEhu1VhuHTEdwbMbtZKZGLw8Ilgg2tzA9MDfCI4nVh62GZ/G?=
 =?us-ascii?Q?PvkdkuYj2gT53Rw8Mh3hiK+71mWxkplcS4uBX1DuwJJUAvhtDR5P7Tc21ywl?=
 =?us-ascii?Q?yrKooTAoOXn+mwACzYMbVE4e9y+u3ylNQamkt91L+sPtGiK5AtC5inx2x2Dl?=
 =?us-ascii?Q?vNKLpBKtQ4fUwj+1cczStieHLxwPOaqXkQ0SdHYKyzOg9+A5hBUP3XLF+rZG?=
 =?us-ascii?Q?37JwSxyG736jcc+lao+d2f8DbZDz6aDlzbf2zc7lYw4Abfbwzke+urWVrtAa?=
 =?us-ascii?Q?2+RXj0Q5EqECU/1vrmqsjMEy6AxlvX/p6JrCjw72AwMLD3GfsXaYaEhi8xYA?=
 =?us-ascii?Q?2qWl58Uzcw+gV9c37OFAwiI+wgIBVb3egtlSUW9lwsU5npMZzVPxMlsteSQc?=
 =?us-ascii?Q?KyQ9rCsHtmU0TeSZXyLcw+nYa4bdM2EyeRynTFDWbnCDBGnr+pcRdjCKnajg?=
 =?us-ascii?Q?P5JwHM4NjVkGTfnF3Epf/x8xA+dTvA5w0LOL+UYtluVdatZWQxBxDLJUTr2R?=
 =?us-ascii?Q?u75PLRDE94o62IpmN4/of1EIeEa1x7NcWgSd0w6DUGcwxLiSKbq7OPO7yFuN?=
 =?us-ascii?Q?w40EwtbvrtNGqO7h9OMdOV/ErxvgbnIInqRI/OcRvhcxmosXC/TyPbDlbsSQ?=
 =?us-ascii?Q?BhPhIefI+hhKIUWqRcV8JF4BSyBOIj0AtIxgeqAPgKI+OQWifSFT3yZ2h0p/?=
 =?us-ascii?Q?P3RZnMcL+oWw0VBnQ6jJWRrk0gxss0yG8dVSDdLGZU+8ZIxjHBSBEIGnnRIW?=
 =?us-ascii?Q?v4orXCyFE7mlYS+XZf6J2by+2fjpPJxTP3ZmMktxAkkdadGBzs70cBNtVtFN?=
 =?us-ascii?Q?5aFMUQ/r4ZSXhHKFb3E=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8596.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb43a2bc-dbc4-4cb9-537b-08ddd8c21626
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2025 10:30:26.3314 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3AwT/pb+wup26t+Tpobyfdo5/LIbh720XqPfTB6JlfNMUOSvnfxYiU6Vi4iTZnOfPjR9Nst794dE7Y9tyOSKlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7529
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

Thank you for sharing the details in this thread,


Snipped
>
>
> The crashes are on 22.11, 23.03, 24.11, it is on all dpdk stable versions=
 and 25.07
> as well.
> Please first close primary testpmd before secondary testpmd application a=
nd try to
> close secondary or execute any of the following commands,

Here is my problem, these were working at start of 2023. So something has d=
efinitely changed.

>
> "show device info all
> show port stats all
> show port xstats all
> set fwd rxonly
> set fwd txonly
> start
> etc"

Have you started the rx-tx of the device in primary or secondary applicatio=
ns?

>
> We are all agree that these crashes exists. First we were tried to preven=
t the
> crashes at PMD level, but it was not possible to add checks in each PMD. =
Then we
> tried to add safety checks in ethdev layer, and it was not suitable as wi=
th primary
> closing all reference to device information (pointers) would lead crashes=
.
>
> Then we agreed on secondary process monitoring for primary process exitin=
g.
> and it is now resolved on application level, i.e. on testpmd.

This is where I am not clear. You have attempted the fix in `testpmd`.
Please help in understanding the cause and impact

1. is it only occurring in testpmd?
2. does other applications (Example) also faces this issue?

I still remember, where solutions were designed for network customers where=
 primary allocates and manages memory.
While secondary does rx and tx burst. We ended up in creating service threa=
d in secondary to check aliveness of primary.

>
> Now, this solution is working perfectly. We can add eal_cleanup for grace=
full exit.

