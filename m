Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C026EC7115A
	for <dpdk-dev@archiver.kernel.org>; Thu, 19 Jun 2025 10:56:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D92C342E65;
	Thu, 19 Jun 2025 12:56:54 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id F255A4025E
 for <dev@dpdk.org>; Thu, 19 Jun 2025 12:56:52 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55J8TTcV016338;
 Thu, 19 Jun 2025 03:56:52 -0700
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2112.outbound.protection.outlook.com [40.107.94.112])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 47cf2u8b6q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 19 Jun 2025 03:56:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vf9OajKqxTRlRXuaF98rhScMTtor45HbIXgf7AAqlyxpP7OVwDQooNSuy+FXw9s0c4QZIU1ty22bzpF7Uti9bHjV+ktGAJZu2TWMWrIrjI1U2yfbdxFsscNw+x4Vn81UzciWe/qcQN0AGjpbZVrD3NYxVKWskpHS8/nRWUtVF5izNuX3WIaFAlOeO9a8JF0h643x1mPqrLcZkG1TCG4HJVL3ydBAwFl4jInoZ5mCVpnGKjfU2tZhIQy0O1Qnmp0TURRkc/S4LYkCKjzUSbqs/qeZ1WCrQ+8UluOzwbV2Bs8n4y9qUbumDP51FkY8uRkeDcREueD6I3TFCpljaEYUKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R1SPMm3+5Mufq7RjsKWaZ3Wo5ybcC/3TFymoq9Trta4=;
 b=L4ANT4h6J429t2FsdlJieLztcuKIuzODHxOYeGfW7bz3SiHzLwaWqpGyhJYYs/kguTGL/DDJy1raHO+x2u+z033XoA1k9IhUeA/zdvg0VZmVZmcLQauHf7j/rzMks9IO69tGCHKUA2VcGlgKTluVNqX2muez11eNZR43FzKk/qv8jx8aD2ML4NPWP7MT45fDZRuRgjZ5rI/N9jfHQvjfW4P0uzEv6PKWqJTDmkXrN7pS1RzpkIXBm/5RbRLFvu3SF5zNBJjVCcRRFVhEIrMbkh7Ifw/fpqwr9jTlogqWLFiCWiG4L2mnyKwLK9HFjWfjiWNjhowKYb+p16i9BltuoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R1SPMm3+5Mufq7RjsKWaZ3Wo5ybcC/3TFymoq9Trta4=;
 b=DQD+oI4g5PhORNND2VRuwMDnNMoc8//WEcb30UM093QI46K8mHt6DJ4cp3wO7i8kAayJwnUxbrIH8pZY6mHe8rUjCkS5SsAb/SPNSWdawmOwOANpMNAgFj2Fbe2wXpGyjhaJuiW2vOLb49OaaCETevFkpAXILXFR4OToOJERZhE=
Received: from PH0PR18MB4086.namprd18.prod.outlook.com (2603:10b6:510:3::9) by
 IA1PR18MB5470.namprd18.prod.outlook.com (2603:10b6:208:447::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.28; Thu, 19 Jun
 2025 10:56:47 +0000
Received: from PH0PR18MB4086.namprd18.prod.outlook.com
 ([fe80::ed37:4ea0:6359:f717]) by PH0PR18MB4086.namprd18.prod.outlook.com
 ([fe80::ed37:4ea0:6359:f717%4]) with mapi id 15.20.8857.020; Thu, 19 Jun 2025
 10:56:47 +0000
From: Pavan Nikhilesh Bhagavatula <pbhagavatula@marvell.com>
To: Jerin Jacob <jerinj@marvell.com>, "thomas@monjalon.net"
 <thomas@monjalon.net>, "david.marchand@redhat.com"
 <david.marchand@redhat.com>
CC: "dev@dpdk.org" <dev@dpdk.org>
Subject: Re: [PATCH] test/event: fix event vector adapter timeouts
Thread-Topic: [PATCH] test/event: fix event vector adapter timeouts
Thread-Index: AQHb2y7fNIDECG7XfUGV2qcv15f9VLQKWsPi
Date: Thu, 19 Jun 2025 10:56:47 +0000
Message-ID: <PH0PR18MB40860834C1DE674B225A0AB7DE7DA@PH0PR18MB4086.namprd18.prod.outlook.com>
References: <20250612001338.71098-1-pbhagavatula@marvell.com>
In-Reply-To: <20250612001338.71098-1-pbhagavatula@marvell.com>
Accept-Language: en-US, en-IN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR18MB4086:EE_|IA1PR18MB5470:EE_
x-ms-office365-filtering-correlation-id: c0b8b973-a13d-465f-67df-08ddaf1ffc82
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?gcOWZo4jMW/EYsBn4c3yr+B5BiNUAZLqTyu94JGDhPvfiPcF9lleEuOvuB?=
 =?iso-8859-1?Q?yGIY0ZYY/s5T1eGWR7NmBtygGSPp3WQ/Xc8/M+brgWCwKho8/6RxVOGqSp?=
 =?iso-8859-1?Q?PUBPOpTScD3wxrOUnUAE8APfJ8npVTtlWWGyIoBj5n+2ObC2crB//vXeQE?=
 =?iso-8859-1?Q?d631OXFIjyjQ6QHas5OCNup/w1uJWY1QHZJ4jb23dSlRm6hpQuL4MYoUlm?=
 =?iso-8859-1?Q?C9E4NTO6a7QMwrEXjN/2mP55tuEbcmgnXPcPQlbQcAnK5eSfFYmUsyAoMt?=
 =?iso-8859-1?Q?hlHgiSKyhrwyTfLUYWRydIJRO5Q5fPfJnYQu3z2bwA1r4TwnufkPJHNoA/?=
 =?iso-8859-1?Q?zaecIgjv2VUYKf33b0FgKCEFfjxlG+S5yizq97YlPzGJjMpQaEAbDyMM4w?=
 =?iso-8859-1?Q?3+A9G3XpUgwN41vwww+SszHI69ivn6SK3fINMlZz+PulzUchZxPXBEHDJu?=
 =?iso-8859-1?Q?Yv0Xdb4G9eXIujOO4rbssrG2y7fK1vSyDlBA2NPwOsoeKVzuicgqZSqx0i?=
 =?iso-8859-1?Q?3sTHWpXzf2O2+dQCjp9XhYA5rRAT7pQmcYtFcNxpa9M8BkJG0CMZK/jwOh?=
 =?iso-8859-1?Q?IgQuPNbZI/is5RrMnZgHJVhUtZVu6/5pYh+bUlEuiEsaBbwwIgK6TEoLUm?=
 =?iso-8859-1?Q?tUBUXBF10j5Bx7uYdRQApnFV2OKFD+jXZ7rDN9pgLi6nip5l/b8H2hpJID?=
 =?iso-8859-1?Q?r3gHZlioGYyZSg93bRAYwaOqPs/zYQMxl0yEwlw0+cnBfacmI9POd9ynvl?=
 =?iso-8859-1?Q?lSVa4bdX74+ObomzS+loSlehb8G4sU6pgttP9TD9Ll1KpNgDmxe3cAIM1m?=
 =?iso-8859-1?Q?rVeNeG/j0iVlCrUcA8IjH4rFRXlkt34jvxVe4BVHq5LS9wuAJ/vwIJ1pwu?=
 =?iso-8859-1?Q?JQbQtzKz/E+nqZqYSsWlcHKJ7P9yPz4EKcrMeqxNrhHOmgNejqXUC5sGNO?=
 =?iso-8859-1?Q?JHjEUDTnmcIGZwOyiL7gbUQmtcZ3EsnRJxQ6UZawcctS3OI1kP2afrgB2x?=
 =?iso-8859-1?Q?UkLai4srDYcguWLBRiWz65bnDFhjTZ5lqcCiE/JWnFPHy91Qjui79mGYac?=
 =?iso-8859-1?Q?0vkzNWuEKnQ4pqroeUDPNEg4FfZC3Ya2ykBc967cdvMBaWsXke0FPvcL2n?=
 =?iso-8859-1?Q?WjZYFS53xeHDy3nOp4H5NNEBz81Y+W0JyQXL+350aQNzV7uF0vGgGrhWDG?=
 =?iso-8859-1?Q?x6XTRT348Hp62p9HXH6i4VG5v/fktxnGQZvJdC+vtFz0P7YyWs1H2E5Xdi?=
 =?iso-8859-1?Q?+t/XFX6LhX9wPRhDAdX1xAz1qne7pIAk9IPptXTayvsCYdpuPlIuG9gB7h?=
 =?iso-8859-1?Q?KmaXzCmHpbbLV+1OPYZXO4+DaPW9cqAArqw1nVbcKXLW/jix2WgkYFuuQa?=
 =?iso-8859-1?Q?qpPdQyXniedQpwTmbU20mnYO4m0ykVRrgaKMuwUpNXM2isORJ2L93F6RtY?=
 =?iso-8859-1?Q?Kj9enJfgKD4zdvtRoqadiyv4eSWeSPHTAI8SCrttbm4HYEFsj3YFa0VKg0?=
 =?iso-8859-1?Q?aU1rkQ3AcD7qOsBU1Sy6HLr/uBGYHV91b5XFsLHrp93N6ngWRdLpPcGZU/?=
 =?iso-8859-1?Q?7E9csbA=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR18MB4086.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?/Ga9eAIddFsPyQw3lGGhJp8tjF7W6Sf/x9e8cIFl6iS+WGcVye53VqjanK?=
 =?iso-8859-1?Q?B7AopPSADwyTqmiGBnTAhSaWXFq2WTj/IP5mEVYSN5iaVBAPjymzacvhSJ?=
 =?iso-8859-1?Q?zLrKhlQ6WMUMpaymJUZCJGU53CVbbAUcQpDUnigxpB1YO7D/k2OZPTV621?=
 =?iso-8859-1?Q?c+PH9ngcy3wczrTaxBjRnjmuC0Iw5siKXDE6MnZj8+lkzqTabb4ezAnScL?=
 =?iso-8859-1?Q?KpwTarn2EO88fkUCATZp8k9wTlWglRsxCiplrss6bbgFuIfxeDbKHi3fog?=
 =?iso-8859-1?Q?/xqKHJhnsVk/dCRz+H8sd/F7L29mgqa5dsHc8SKKfFN9l6N3qFVqOJtiXK?=
 =?iso-8859-1?Q?bqsIk+uFPb2QG2OaoGrYg3/T6PCO2YYaXSUIVo/uEMoh5n60oCgsrCgSgd?=
 =?iso-8859-1?Q?oKmi1b2qx8j7norf0lhUi34/tRtQo4d/J+ZexgWO/1g8dg6bDel7sODN+t?=
 =?iso-8859-1?Q?mk0n802MWFIFU/Qs/D2t9uuljWzaVPK+9T/9gxgilny7ZZNhh4h/b1QtfC?=
 =?iso-8859-1?Q?RNLo8qxgqKIgYELdzt4UXn94bDl5ygzufewZaIhcGIk0uM9KBtNx/KHtqY?=
 =?iso-8859-1?Q?fbf3D4mmX291zi+p95m02isvCwK6c57kANd4qX3XPw/w8I/S7Ci/a5zIXE?=
 =?iso-8859-1?Q?9RGAwRSYRaGMb+Y0FrrRNXKn7BcUEbHxjWPo74fJe+SFUe2e3w1+LnCImz?=
 =?iso-8859-1?Q?bF/lCtsuI9qPke0b9trjBrWhKOQN6TWi8fa7BwGbMUPMn7mp7ou1gNl4BT?=
 =?iso-8859-1?Q?GBWCaHKQHDIgKzPy4OUQRyJRJltjJzBeQc4ptne7yizlWcQuA/txJyEdpL?=
 =?iso-8859-1?Q?wxNFM40ajT0bjidBSxj4VtStsOjcFFHD0m4nWrmEl37184/pIFZAfaJV+J?=
 =?iso-8859-1?Q?/SjePUELSboGUKYydUd5eEEmAXqYBvUJoq8Ie7LToSP+qq+TAThOwQ9OW+?=
 =?iso-8859-1?Q?gr2bzs2liruL7TDIfLPjWCM49tpiogYz3o4JUxcdOTahOBMyF+OV1JxP5G?=
 =?iso-8859-1?Q?V6wX1WJYL5q7HBZ73rUzbzCV1+fZ8mQiwzKpm3qRZ2ZqOKYO0+WM24WfEn?=
 =?iso-8859-1?Q?QR4yrA1GbM6lW1k4N+kBzjYn1yIQajP3u6484mM0jM6jzCtMu8gti2uXcR?=
 =?iso-8859-1?Q?bNa5PqCIF9DEioLIiFCKh+qJByr040tdQmFam8cxWUxtwkNcp2pZ0A1lPR?=
 =?iso-8859-1?Q?r/f1THQ7OjVcHCiAPeT13y2HLTnakOgxHs5nILbeqC9ZZ0EGQIQzHMdA1Q?=
 =?iso-8859-1?Q?aa5umBWlL5ApRd6c4ItQO41vp+DwRMDPsAAcC4pf1v+QGNPhX+LZqMl7fL?=
 =?iso-8859-1?Q?iq+JaN9yCz+32MLlC5L2D1lIMbXyQpGsTaHZkX5BLadot0MoKsQFwDqXF2?=
 =?iso-8859-1?Q?d6NdLyzDpm7VECzDcf/Y6nMwUP/ljXMbLFFvvQ/ZcOmbkEf/vuKGKrNHqe?=
 =?iso-8859-1?Q?7s5Aro4Oq7VulN0gYNolJF9aVwynOc8Aeyr24pTpxMH+ywvTrF8DJGsYFF?=
 =?iso-8859-1?Q?arvheQZmpKLNkrzmFG9ehn8ho3KS7bzYYX8OwCWZyXbEC62gG/8c7l/Vqu?=
 =?iso-8859-1?Q?SVLeawR8SYft9tyxEs08npUciWhB5QEp1v5HN7SVAbVV5I+YBTd9Yt1Mtc?=
 =?iso-8859-1?Q?SmfEkezVm35P1+ChIYpm1u0FX92rSYcqIK?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR18MB4086.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0b8b973-a13d-465f-67df-08ddaf1ffc82
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2025 10:56:47.1225 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WclWKeSeo283nbKZ/00ro0Ajdydln2j2U2Y1QOmTAeo9b1HU5rt3WomqrvqI2mCxqeX85Q2lNRA6BcAa7m+oNcbeXhfGN6dBb2W+1eO/okA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR18MB5470
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE5MDA5MSBTYWx0ZWRfX/E54j9eOB8gJ
 KjoghsSDfdXWS7bNroThBeNSfsH+zcSjcYuMaKwzRADrVMqwaZL7FL+hu7cWgullecGmUejH/vR
 yPuZKmAV+6Zo+eyg+OIa31zUWxvGCQPnOXRZA6+ItFnRFO5RUsulCxXqaZKCEeNrNUP0EljVNf9
 ZoJmPxF3bia3YkjL3F3JQbcI5ZYC3w95JeE+merVyD4wPoPgZMSiet59T7orqQG7AjIhFV6FWp2
 UUn8Dx3hK8+2eX4ldnEcm4xqKQ3n1l2VqAWm+2f+DaN6dizN/3GoyBdc/IuIrRzUXj+RbwSmLLo
 5jOmvwegnncS/uEcUVz2+tB8ehaIzjsOiJUWHQ2C3NqTd185gkQ9WRfVD6zPiJvXP/ek93DVwej
 onDCmI5maRNX4xQ5lqupbFXp0wG1gsPFlXqlg3r6gNACj/jiwhOhvkdyNEO+WIXicI0iGA4R
X-Proofpoint-GUID: OjmTjfRjcDBn6oM-PSIix5JeBaMLCfbp
X-Proofpoint-ORIG-GUID: OjmTjfRjcDBn6oM-PSIix5JeBaMLCfbp
X-Authority-Analysis: v=2.4 cv=dsXbC0g4 c=1 sm=1 tr=0 ts=6853ecf3 cx=c_pps
 a=7UXMxuOBat4+6yczhndhEg==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=6IFa9wvqVegA:10 a=-AAbraWEqlQA:10 a=bt5KbKNvAAAA:8 a=20KFwNOVAAAA:8
 a=8rWy6zfcAAAA:8 a=M5GUcnROAAAA:8 a=u1_aABfc5XYKXDQ0dvoA:9 a=wPNLvfGTeEIA:10
 a=a-zEBD5cKgE7DNtTSb7C:22 a=YjdVzJdQTyZRADMV7wFX:22 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-19_03,2025-06-18_03,2025-03-28_01
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

>Sent: Thursday, June 12, 2025 05:43=0A=
>To: Jerin Jacob; thomas@monjalon.net; david.marchand@redhat.com; Pavan Nik=
hilesh Bhagavatula=0A=
>Cc: dev@dpdk.org=0A=
>Subject: [PATCH] test/event: fix event vector adapter timeouts=0A=
>=0A=
>From: Pavan Nikhilesh <pbhagavatula@marvell.com>=0A=
>=0A=
>Update event vector adapter test to depend on service=0A=
>core cycles instead of system cycles when waiting for=0A=
>events.=0A=
>Reorder event_type check to make sure event received=0A=
>is a vector before dereferencing vector structure.=0A=
>=0A=
>Bugzilla ID: 1720=0A=
>Fixes: de09387f1313 ("eventdev/vector: add default software vector adapter=
")=0A=
=0A=
Recheck-request: rebase=3Dmain, iol-unit-amd64-testing=
