Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70E0EC021BF
	for <dpdk-dev@archiver.kernel.org>; Wed, 26 Feb 2025 13:52:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 870DC4029F;
	Wed, 26 Feb 2025 14:52:21 +0100 (CET)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2070.outbound.protection.outlook.com [40.107.212.70])
 by mails.dpdk.org (Postfix) with ESMTP id F0F654026C
 for <dev@dpdk.org>; Wed, 26 Feb 2025 14:52:19 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IPRTa3rz/xHH2kfV5DlTnnqK4hdLiJsV2nb6Qt6J3OT7nlbKg3hgU3mh7DYznXnt28PxsrU0mrEcOqbByeZZ8MOmd3g1xRSvK3VHewc4LOgJzlKCSwX+2FeNEYUcV858lUWpF5HBfCVvTyibJeSmyFgz3krf+rkKPTUnabuOQV+OFtVg35+QVD4ybtbZLt1w/hlU8uOtOQEnNJpp4/ndmSyMIdRDT/vvBtQO9XalKWh8S5XvjxT1uvsQgKIQHYHfLMyIV2xOBbHN6wtmox7Ca+x7ou59cfqbUQ0QpmZ29KzwHTs3aS81gW401hfFbsMfj+hj5YTwBklo2egHCcOBsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7dVdMy4cRykxn3XOmV2mgSQ16/c23AIPLWr3Fv+hNhc=;
 b=vNYnRJp20qg6LAOY31Zp8Om2DiDA4ZnZfHlcWMh9zIFz/hBV1fVtp+QKKL8ysYhtjBOvO4qatAxYWX58Z6tMbH1JQ37RivS0EU9yC/933c+K6Fq0lPOgDDrzi+JAwqS4HN0IUk/8/vmDf8Cu4KVPW6U+xsdDZEG38Kp9bF0hTNkgAvSK6o/uQ8edd5IJ8F/uBS644xOCZojsVBnf9X0FGa57MYKKfFVBwlEkUd2At3Z/KueMfIg94pVm6LWe2Nx8aNWolCtVm4d13ewncQdwtuvWvZwtudRgbQ2MQTn826p6W0WANokOLAwS6u5Oj6nsca19o87pQNjBSj2aWKxXJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7dVdMy4cRykxn3XOmV2mgSQ16/c23AIPLWr3Fv+hNhc=;
 b=aDmpYq3F2CyJn5Hxdp7afiN96ApfNDbprp1eS/7WH4ADIpgYN+oSA/M0TcYf9cklXmFIEEHWoPhUgIe99vngEUMF5wLGmx4/4EZk7172eb/02tbWFs3YJBNhCmeK2EZC935i5FVVF5foww/Zs5uRGKZRE+0q2ooEwRSR0qdYR7ierkvIJIWh/MowvUe8cEV8wrE/NIQlxAJOqjtiARpNunDMxi0AGdJotPl/Mgs7ygUYIq9vLkYei5feozFh4kD9wrBaQ5JRaDnMannC6ZqJOrBzamLEe4mtIKaYYO2hZr2hNXizJCEniaYrc8pZoFNHso/WIcRiPV3Q36hK1nxDQg==
Received: from CH3PR12MB8460.namprd12.prod.outlook.com (2603:10b6:610:156::15)
 by CYXPR12MB9425.namprd12.prod.outlook.com (2603:10b6:930:dc::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.18; Wed, 26 Feb
 2025 13:52:17 +0000
Received: from CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5]) by CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5%7]) with mapi id 15.20.8489.018; Wed, 26 Feb 2025
 13:52:17 +0000
From: Raslan Darawsheh <rasland@nvidia.com>
To: Gregory Etelson <getelson@nvidia.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: Maayan Kashani <mkashani@nvidia.com>, Itamar Gozlan <igozlan@nvidia.com>
Subject: Re: [PATCH] net/mlx5/hws: change error flow on matcher disconnect
Thread-Topic: [PATCH] net/mlx5/hws: change error flow on matcher disconnect
Thread-Index: AQHbevlSldzdXh+fL0uz59aGgYN/LLNZtTdn
Date: Wed, 26 Feb 2025 13:52:17 +0000
Message-ID: <CH3PR12MB8460A59C69273D44961C6A28CFC22@CH3PR12MB8460.namprd12.prod.outlook.com>
References: <20250209134806.263338-1-getelson@nvidia.com>
In-Reply-To: <20250209134806.263338-1-getelson@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB8460:EE_|CYXPR12MB9425:EE_
x-ms-office365-filtering-correlation-id: f8d6502f-d9f1-4cf6-689e-08dd566cc871
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?ZOBOnyrStCWsHQ7dHaTJzaOWHIZiNx5dd13+BPSPqBe+KTuQeewi0G/BUU?=
 =?iso-8859-1?Q?fsL/XCNmqD6vfTSRwAuDXv8ReuVft13qFE+yfx/Q1+uY7vvwihFYrGK7cA?=
 =?iso-8859-1?Q?EXME+yaEhuCoWz6fwaMpnQu49v0ENk2739KkHFbSrPs7Yt4VqXT/xm5Rvo?=
 =?iso-8859-1?Q?nBgGCrwlQrpQ9az9pHiklNPRRrqXqz+cVp/88/bDeoGtYLPUo+T0Dpduqk?=
 =?iso-8859-1?Q?wLhJ3KjQuzNFDiRhNwxLsnPfx/KrUgAfe+9YfaJCSx53mo/I0J7Hb4HlcD?=
 =?iso-8859-1?Q?Sg04E3tvrOLiVPr5K7u0/+59QLlalJQjMUTjAapCthh3ZnXx6Fvbv4pdbu?=
 =?iso-8859-1?Q?LqvMAVPJxJKWDiMRjGVWUyRzJtvyJSDTZtky6X1RHIWaHTt1/20s4RveJP?=
 =?iso-8859-1?Q?4lP72Lxv8wBp7CgGSeUGN+k4j3aZXe9CRDMM10aZmEEwWx8eUC3Mei5KCA?=
 =?iso-8859-1?Q?b6vB3ikioATh8HUNTcFI6rHQ8scsN56jFh9VcQ9KHBaXSnIihpZQWE60aa?=
 =?iso-8859-1?Q?7kDJontFSftWGftelHHxcJc+DjzgBpNHdxRop5Dt2VDvmWxiMrGWAns5ud?=
 =?iso-8859-1?Q?SoyhyYbx19TQdwTTaz5Ef0Qg6j2ISHRJRd8Luvrftn7Kt/Qx8jBM/5pfwQ?=
 =?iso-8859-1?Q?ez8HHOC87LH2nV5kTY4y+n3VkPWSi206+zuBgaL/vXMw6wlAovnXlx8FRe?=
 =?iso-8859-1?Q?ooYIknp58dndQWpthnRTR1qNhUIBvVbb6DB4/xYW5DNYEI4rHiRXuxXdJh?=
 =?iso-8859-1?Q?ywDvuvQEe6nho2m76MC2IHztDOyX5Mh4ZboyUfUEEyYgWrpip6Wl8mjdu/?=
 =?iso-8859-1?Q?MRDMmxUp0+jLqNdydXdMv1SnitEjcL9fVRB8vt01qknXszGtCam1PK3Yoq?=
 =?iso-8859-1?Q?mF6ywkvEJWkkhPEGMtXttjEAwW6RbJNeItNyODR665C/GptDdMqecCUZjI?=
 =?iso-8859-1?Q?xgDoWl2ccVgOmfAnyuBqX4K7IPojXtdBoeSi2Vf+OBrdkmuaikqNuyCu6r?=
 =?iso-8859-1?Q?DAbpDBLthEgHDlRaqCuk6uBr4i75XLrchiR1RnRdlekocUroYuU5UAAcyN?=
 =?iso-8859-1?Q?5/Dww3dQGAb34Fd4dU3XK0poSr/L4J+Pevzl/O5fE1whD2RrPexo8qmmqo?=
 =?iso-8859-1?Q?RVOo9a54X7pA66J7dheXGd3VSemsmcxOl383l6hHBWt66vUHUml4suHz5e?=
 =?iso-8859-1?Q?QZ4VBbcEb3ODPd1cybqTJHqvwK/58uku8S3H3Q0lnjlmgkm5vlqFPyKAZp?=
 =?iso-8859-1?Q?I2jZZotqDLWTqw+O4mdqUCPgo9lzY2rugjX6DpZDC6Wg0saq1wRcBuumy6?=
 =?iso-8859-1?Q?1HBZXQP7evulLC0q3JN58J0vE0wqWM+xOCzW9VtFA3bIpahf1gPPK7OIMj?=
 =?iso-8859-1?Q?7un1ujh9bldaGhGcGhamJ9AO1Fv1btgGe8QiFfIM6qj9N11RS1C0RpZHuV?=
 =?iso-8859-1?Q?8lWYG64Ze51ciJjnt/HjevKkOZBFBVXIPZI8ZsGYM15BablXjbROwQgP0b?=
 =?iso-8859-1?Q?vOrVgiPIz/rcoQ455Br0tQ?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8460.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?XgBeAvTqWdiXIVRq1b4xa3M/2SJvjtStQN1qFC3hpgxC+5cPIF46nqa6Ie?=
 =?iso-8859-1?Q?c46jQIc0/+gX6MrWOh3aG1EU9+unXb4VF0Ws7zg93+3XS7oiLhx5sr8yhe?=
 =?iso-8859-1?Q?iv2qRo/UjD4Z88N0GgdZ8jwMW5AG9EXxbxxsGKhY2iOoAF0cgnWf/8ydUk?=
 =?iso-8859-1?Q?2qunDCNWapzxznkQ0YWoadeJETSonZ2x4OmVsFhRXY/jvSJeoGVmLK1UD4?=
 =?iso-8859-1?Q?ni+aC4pA/3ym3dT2SiRt8cLFuKJO4LSrpFa9qqyRE4gQTGjbmEWortwE1d?=
 =?iso-8859-1?Q?qYtOfInDa+cDtDKGUbF2WaoTHaljQs/9gnuV43Zf87NIb5VhOn6FATOGf+?=
 =?iso-8859-1?Q?zH18wOjZ2NuG9GZKzjfIbqY0MNSqGq1DXhWfDrNz0SYRQuL68ad94USXhg?=
 =?iso-8859-1?Q?LC2MOZiGg+R+T+LbUQwA+YjhDZOf4T+I0kOz+v4mOw19Gm+9FGseJFtL/Z?=
 =?iso-8859-1?Q?eQ42uaBXfgy1F55AMMVkG6dHWnQvwn9d4STiE+ByEdly8QZ6BOm/QA3iMe?=
 =?iso-8859-1?Q?4OoULvv4Xmbu9y9xtj2WZMDZUu7gtF+/MHKElN+Kix+YZ82MAlnIehwF1X?=
 =?iso-8859-1?Q?ZN+Q8rZ3yAs5pccU49/cYCS/1nc3hY/QIEPvpvWUKlnKkRsdUZXVBsfUtn?=
 =?iso-8859-1?Q?VO0u/wz4Ne4YvyvTWe80QtaUa74ntZMnDnf4NjdOTBT9vLZopoNpVjmI2l?=
 =?iso-8859-1?Q?EJ2d4UsgaKxqaBDtONiVElEAfHtee1bNhOHlKFFV/M/oKpGwiJZbAdNEjZ?=
 =?iso-8859-1?Q?I5HY+4IiP+eefwLLXSxbCytU0Zj8ZiBs0KXX1CiGSEIMwwEWBEXrCajjCM?=
 =?iso-8859-1?Q?vhWP0sipN0IAWSofS56OsanUAUl7YlLbE8jP1HKtPhQdSa+UnuxOlfBQGX?=
 =?iso-8859-1?Q?Hy26tQ99A6zHHUtNKPbDujCAykMem9G0ccCdur75h4Rltuscp7UO+st5MQ?=
 =?iso-8859-1?Q?lgzwsWO117uv1JSzZU5B4gOQTl4Dp6c5uqOE7+r/GgAY46HygJbIfPXzBq?=
 =?iso-8859-1?Q?Lk9kPrGUVVwRNRC1QahzjbXw2WeKmSZstu1m0va8ndSdh3eg4ArQX9BVWs?=
 =?iso-8859-1?Q?97rROCH7WPtsOsse0DZzniHIPcIYGpkfEqy4ged/wflas6tolgG+l9lpH/?=
 =?iso-8859-1?Q?KnifTkk2TQtUTyhBF3dNz3ypbFojHbFldJxZbD0LKUyLquYhsIAkyJSais?=
 =?iso-8859-1?Q?pBec0BbVCqp9LE095lIkrQXHDsRo3aVqPDwTZJGwE1PX3XTtvS0cpA643B?=
 =?iso-8859-1?Q?n4rdKKY8CXu3SVwOmxzSQoGscGJ06LYYV9iq8TylXkDmPeK91pPY+QGxM2?=
 =?iso-8859-1?Q?6EtXQUVGveZv2S0n44jAWkOpljzsCEBfBbc6U/go++DVW1y0YWUojXXWrr?=
 =?iso-8859-1?Q?uHVl+XU9vQrxZPWBBxLTlz2dlvL5VU4VBx3cZVGJ68f3Ov/Hb0dA/Q4Eck?=
 =?iso-8859-1?Q?50JOwDtWEnMKIg2MdYomMmLeYrQin0K1IScMiwlTAXNRd2hRf4qczQrk/f?=
 =?iso-8859-1?Q?EhhBbsnrWJdx3WPRWBKcFNTEg/lWmIW7tZ5X7PMFQbNJi+KFMPyktRa3t/?=
 =?iso-8859-1?Q?yza/y1AxD1uHT/3ew7dD1xEfqAM4JY1ZF19yW9Bylt8ndPxz3q8AfWknfs?=
 =?iso-8859-1?Q?oASa/g53Pt720=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8460.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8d6502f-d9f1-4cf6-689e-08dd566cc871
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2025 13:52:17.5589 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bdXEuiLXtYhnf+nVAtGtSJBMWR1nsb2AbWFwY+XV1wXmdiqD5iAlOygPKB5zYvgWHcV6pCUiURnWTYjER8rASw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9425
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
From: Gregory Etelson <getelson@nvidia.com>=0A=
Sent: Sunday, February 9, 2025 3:48 PM=0A=
To: dev@dpdk.org=0A=
Cc: Gregory Etelson; Maayan Kashani; Raslan Darawsheh; Itamar Gozlan=0A=
Subject: [PATCH] net/mlx5/hws: change error flow on matcher disconnect=0A=
=0A=
From: Itamar Gozlan <igozlan@nvidia.com>=0A=
=0A=
Currently, when a firmware (FW) failure occurs during matcher error flow,=
=0A=
the system attempts to reconnect the matcher, leading to a segmentation=0A=
fault. This happens because the matcher is freed but remains in the list.=
=0A=
=0A=
Example scenario:=0A=
Given matchers M1->M2->M3, if a FW failure occurs:=0A=
1. System tries to destroy M1 and fails=0A=
2. M1 remains in the list but is freed=0A=
3. When destroying M2, it attempts to remove itself and create M1->M3=0A=
4. This results in a segmentation fault as M1 is already freed=0A=
=0A=
Signed-off-by: Itamar Gozlan <igozlan@nvidia.com>=0A=
=0A=
Patch applied to next-net-mlx,=0A=
=0A=
=0A=
Kindest regards,=0A=
Raslan Darawsheh=0A=
=0A=
