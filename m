Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D6CEC021B8
	for <dpdk-dev@archiver.kernel.org>; Wed, 26 Feb 2025 13:54:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 30C5740649;
	Wed, 26 Feb 2025 14:54:38 +0100 (CET)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2077.outbound.protection.outlook.com [40.107.220.77])
 by mails.dpdk.org (Postfix) with ESMTP id 0B1F14026C;
 Wed, 26 Feb 2025 14:54:36 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w/5eOOapiICNACpvtB6EIbnAdMipCpJSEbOHahD9Qpo+KDNj+sQhyaP03LPn0FELHktiOBSfXpCjhbTFAtpO6dkWkzYXWhIpNjlwHuxOH1qlsFmTLS+zWc8v0N5pCHv1FP/oPza/VXlToKxgvf0JtP0/67wshPYotMlS1ucgbkEOc36zZ9JnbuMihnlM+p/4bKhwwpDocBBb91BTPTAhqn3/qJK/kcg/yX7cUD6fNEV+5TLjMga06TRRY5E0xvPVqZGfCsdGm5XmIDLCQGATk8u/+5j7H4+HpGBAosSdhsRqQTHXzlnDq9d6FcpexpXRrIYpqMdgFfmGma9SWzoHiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jotjI1CjeDv2xRW/BSfk3BlsOCxwqClOdN1iB1UaHa8=;
 b=KdsctrH83TkrI5YnGVpPR20lfhgvYXTTtDX1/Ooeq1JvoZcDpCdIJcfEWLYSgcGFSTnSPy0fjC743ijtrgT4cuNfTr2axMZcGLfGoG6scUyLaUrALNJiDeFu1XFAcfG1TiStuzmLtWiJxMd9ATmLrtp+NyPJrOIXwrLdLSLk2eHUC6RBzlx+m+pVK9YClwyuvVuvUdWMq5AYg7/iNI8cWW4UtKcix/iWg1Eir/1XsyhawNmosqwivYwytp+wUvBubXDG+Jgy0D7TeEPlmtMKY2yvMVicVJCU84xHGUffAmucIESpsYYyL9zA4OhTAlJ8pwouAkFKX4HBj5QLls2voA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jotjI1CjeDv2xRW/BSfk3BlsOCxwqClOdN1iB1UaHa8=;
 b=hUtegxlCeGjxHYS4TaKihwJ8pnj2AdA/yhWzyDJSIRTmgiYcCoiMkZw5VJstr5Iuojylv6HUbvy7jz75nU+C55AJJbVJKY16rdU0BH75SIexR7hfPzkgwJ1kjkE1SSksS19WqARMV1k5oxhZXXMTKh8C0r4mPkXpQejCM0JGg0Vz6Q2fV0aI4li4fqf+JRjaDxIi1iyZgkDKthFVSSU24jpoNQyXMSuugvhOZLvgyo7PHRuYA1ndLqJBCw2oou+MmxHcyMRdZaacBF+VGDHH+8PbWe6d+dU3nRYczfCMgZXptYTpinvOI0WYkNJwYg4qfa20zx/iq2Yq8Yl3x7DG4w==
Received: from CH3PR12MB8460.namprd12.prod.outlook.com (2603:10b6:610:156::15)
 by MN0PR12MB6126.namprd12.prod.outlook.com (2603:10b6:208:3c6::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Wed, 26 Feb
 2025 13:54:32 +0000
Received: from CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5]) by CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5%7]) with mapi id 15.20.8489.018; Wed, 26 Feb 2025
 13:54:32 +0000
From: Raslan Darawsheh <rasland@nvidia.com>
To: Gregory Etelson <getelson@nvidia.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: Maayan Kashani <mkashani@nvidia.com>, Slava Ovsiienko
 <viacheslavo@nvidia.com>, "stable@dpdk.org" <stable@dpdk.org>
Subject: Re: [PATCH] net/mlx5: fix packet hardware ptype translation
Thread-Topic: [PATCH] net/mlx5: fix packet hardware ptype translation
Thread-Index: AQHbevszJtffxrJsh0ma/J+ed8w5k7NZtWRe
Date: Wed, 26 Feb 2025 13:54:32 +0000
Message-ID: <CH3PR12MB846005764D26CD0B3B382D4ECFC22@CH3PR12MB8460.namprd12.prod.outlook.com>
References: <20250209140106.264556-1-getelson@nvidia.com>
In-Reply-To: <20250209140106.264556-1-getelson@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB8460:EE_|MN0PR12MB6126:EE_
x-ms-office365-filtering-correlation-id: 27b7e928-313b-4b03-48bf-08dd566d1908
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?1SmUmOgJtM7KZlsNyjsXJCUoY2iFDt91axWZ10/pMWCQBgtJefRInHlLDB?=
 =?iso-8859-1?Q?PjtiTXNIT9Z5xHnsuzMzGsKxk9LCJPtCRL2Y4ITptMBsBO+kQO/J0Ihiku?=
 =?iso-8859-1?Q?+HoWMYJzW4OXky3pOJUpfoYYffd0C1e4iHmjyUblkEkBJ2GyfS0QexC3Sr?=
 =?iso-8859-1?Q?cROjGypUSp6YABL/26jWuMp2UZfq3AELdA1bckWLYkAoogmMCjTg5XZ9WX?=
 =?iso-8859-1?Q?zIhk5ettuhrxZZbUeP3HxZgvjUBk0+d27wFFy9ojs3CVmLmf3ioUWh6DHe?=
 =?iso-8859-1?Q?WEDznTkbPQ6Z/EjoZ5Com5u4BW2eKmtIaEcrQniLiQicp854rU7jUy+X4S?=
 =?iso-8859-1?Q?xvdajMeht72N7u5UqIZGfNNJQi5PuloFhulnO1L71MDERQ9/5+qXGyra0H?=
 =?iso-8859-1?Q?6G7UAAJ8sv49u1pP7Ex6H5y+8Jm2c/kRDuIO6TMVZxkO7ZpXqc6f/8f61p?=
 =?iso-8859-1?Q?DHvaJPP0KaryxcN8PRRQQ1hp1hmXp2DY89Vy4kg1xImchOxheC0/YFD5Yy?=
 =?iso-8859-1?Q?hfqzIKiYJiW37IUVifwcU8AyxdJBbMPjecR65pQeKSxgGYMk2lvNjiXHnK?=
 =?iso-8859-1?Q?IuAaEZJH4GCDnoIfIj3Py7uEaPDh9S4FxwDg1Oxp+0Yz+JukXTs4ljbSpQ?=
 =?iso-8859-1?Q?iMxOsA8UzYkqMywDYEBswxCHfzeGPb7f4ZN4+A8JQUyOAPfhDZrY3mxjoi?=
 =?iso-8859-1?Q?wJ+bqh+oVI73Bq/6IHvc27riyhDi485Vr751N5aI4Y0i/Ux/wf2Uo3M9lr?=
 =?iso-8859-1?Q?/w49xFXn1PBxVXI3Bzg3fNBGD4aKiQW8p3VNvduM0oTPPq8FpTMzaSND7c?=
 =?iso-8859-1?Q?UJsksBhVl5hKt9iBIGXo+gF8LOdqAhmt5cmSzS/TY01auXlF5y+q3lYilA?=
 =?iso-8859-1?Q?bkT/zKNPgjRgwdpeEL+laIPdTEf7C3BcFp4JYrCsl9Xd2ApCLJPwdg246o?=
 =?iso-8859-1?Q?E3ApbasXCsnZRrknpEFGcuYvjux/+KJPQSc3gjeRCRV6oZPjB4FYBOWHmQ?=
 =?iso-8859-1?Q?tgsluiHVUJj14gf/slfKA9cBgdZcxeyQlaMRfMnwm/E7LaojMYX5mFpEBh?=
 =?iso-8859-1?Q?IpgXSZWPe1wVf2VhQuOQ/H02IGaoj+QHMhbRV//7vKAaYEJKK3obd3z6hc?=
 =?iso-8859-1?Q?wI2T3saTLcJeo72lpPyg5o4sg6R7WVQkD1UAYkwrbdkClpiiJKoL4Yda4O?=
 =?iso-8859-1?Q?uDSQmfZuOeznWhafqD1hVgcUQzEUeQf0o9YUOJO4iZWOy8X0GJ1T7CCu8h?=
 =?iso-8859-1?Q?8GGoXd8GkwPuR26hPXH1aUnQ3waEvUYzWeXZvvnubpDJ4VlBfGl92yhMBI?=
 =?iso-8859-1?Q?ix0KxMmyterc2hYpnuG+4bsu+qXtSImfVoYvYi0y9APUQ43odwRwvquD5L?=
 =?iso-8859-1?Q?X1vXPWkMd0M9/UgMYppwW2qUhSZZEbG7o7NZxtRDfz8Vv1+gsVXc+6Wf8A?=
 =?iso-8859-1?Q?YrKpd3VXfm/2DWoxrrhHYp7FfB0LfkYx7BllS95TuKW/coqZXH6WiEMSdH?=
 =?iso-8859-1?Q?PHJufouA1Zio6XLrg64qAl?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8460.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?4RxjUFiQYeTe338+aKytwOhPq6hNv9FPFiknagyqyhW4a6oKEHxkd1SY9x?=
 =?iso-8859-1?Q?QTUwhYcAWfOWUnDbiNO3M8xyZlxcQi8MHGMWzFPCdb3ezFA32nilocIR5C?=
 =?iso-8859-1?Q?E0Yh8PlB7ClsojsorNGce7o4sOH4BaJh3yZAGiXtMr3ykoaUCjgQ3/a3xt?=
 =?iso-8859-1?Q?ZWH8U7jCRkwiPfl+U733yujFFa7PK8op9se9Y6Y7vn+fKw0ahvmjb9mOFI?=
 =?iso-8859-1?Q?l/wdLkLQjZFTSrEZGdwMyK19xDyKfH8rWQxv7sqw7npgjltT7Qm3AZTw53?=
 =?iso-8859-1?Q?fkyNNMrHq3BWHXVqAUL4TiQ2uyiMivBfM3/FPEv3C/8fIaUND3bYUKcrbq?=
 =?iso-8859-1?Q?/6b8wxuKBMwGyi40aHqqOM812zCBaLh/xYiFLL0XElMsUNNNjpftj8ovu/?=
 =?iso-8859-1?Q?/6CaDOZ+HLGj8B7LL9rBhtGta3UTCgpfDRnGkDkGIzDPABy9c0e5nkI30V?=
 =?iso-8859-1?Q?fKr2i7joUxM/jvyxhLtTQkkttLpDFStmE99v5/sYufBTkkUXcoMsMSbog9?=
 =?iso-8859-1?Q?OSsmLhYaydg/+LOrCVv9LsxuvyJoRCpkrgtkC9177XXa0Fgg8wdHLtMACs?=
 =?iso-8859-1?Q?k3jB9dA1gs642PEej4B+R1Q36Hn0+KDIlqVV1Vk7KP642TkBW+6VsPxerc?=
 =?iso-8859-1?Q?5ONQZuconB8i79vJ840YZkvqAQoWeqdEK5STSjnZoWjbX3WHxRjzp5HH1U?=
 =?iso-8859-1?Q?vBVfQVpGBtHa1t6lr0yDfz4TLsWpYlaC1u3gRZ67nluy9Ln9BEjv7sCpay?=
 =?iso-8859-1?Q?l6pMnIB1iYViQakQz5hCSbVKSVmEwx/E3ljKTm8sEsQvjGijQoCTa23VYQ?=
 =?iso-8859-1?Q?zENp6ZKVA/tI6qT/677O6a1b6De1zvfVNn993EKnH7QHH9U4NJponhfPdw?=
 =?iso-8859-1?Q?oJTliSGAqAqZbPG/AgwWqh4AVDcV9tOjOc38P6pF0MDImOh+GYD+B2Wl8s?=
 =?iso-8859-1?Q?IwqqoVcYsacTbZHyeVMEmvzjuoIRw1jvV0p0IBd4xUF4Wmr//gzxnsmPNQ?=
 =?iso-8859-1?Q?CNgWh+7j+FX8S2qQ1j3kDOFFcN/y2zpRKU99orYugeWKPjOSvyPwEhTROb?=
 =?iso-8859-1?Q?vmXZ1hkyXLwgxT67JTa+dGzucBsaDdy/dxeHb+mXydQ+Fzi1U85dqerXNh?=
 =?iso-8859-1?Q?un1wM4Fp9mV7ViJb9XteCpfpFfufDEwVCguhWaI1beJUDWxYqvjmebld9J?=
 =?iso-8859-1?Q?gqUrgdrNNPZQ7U8uvjJbDY/oJgHQbcUefmalnlnSrZSDk4SWX8uqoAaipQ?=
 =?iso-8859-1?Q?O22M6gYEIypM198VP2Ox6Ttv9baifTlJ8plz7MOUenabPB/B9k+D/dLu69?=
 =?iso-8859-1?Q?CmBw8ZjS0jbNnTw6ekF7RzCZ7J3Td6MPRWNxXDltjfWxXuxqm9BN71d4nC?=
 =?iso-8859-1?Q?vBWRXafOeHSi6o/VAq8X8GfOlE0zHhWkm3yf02Xx1ksI1uFKfOxgvF4UZw?=
 =?iso-8859-1?Q?ESu8642JmW329obRV1ZP8hpAxMrpy6jbedDymTjuOVDK3L+aoDG6zC3aj8?=
 =?iso-8859-1?Q?qGCo+QKYopI0SWKyLp9wriUucT8j5S2EYzhdxjZHbTOYXXqrucPJozwTKX?=
 =?iso-8859-1?Q?B/08/bbLhL9j66V4Gm2j7Wb0G0DNMgVAfTjssUesLCriKKAX3QYphJWbTJ?=
 =?iso-8859-1?Q?AYk/TMhS25Xmc=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8460.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27b7e928-313b-4b03-48bf-08dd566d1908
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2025 13:54:32.7730 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IDCnWBy4ah1Lb5NukbOoF114z5BHox+kWwMwv6jom9H3M93BT8Q6pAvKdDM23yMMePFJPR5TffDAegGyJl7kwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6126
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
Sent: Sunday, February 9, 2025 4:01 PM=0A=
To: dev@dpdk.org=0A=
Cc: Gregory Etelson; Maayan Kashani; Raslan Darawsheh; Slava Ovsiienko; sta=
ble@dpdk.org=0A=
Subject: [PATCH] net/mlx5: fix packet hardware ptype translation=0A=
=0A=
From: Viacheslav Ovsiienko <viacheslavo@nvidia.com>=0A=
=0A=
Since ConnectX-8 NIC the hardware recognizes L4 protocol in the=0A=
IP fragments if the IP offset is zero and reports the L4 protocol=0A=
type in CQE fields. This case was not supported in the ptype translation=0A=
table cause not reporting the ptype in the mbufs.=0A=
=0A=
Fixes: ea16068c0064 ("net/mlx5: fix L4 packet type support")=0A=
Cc: stable@dpdk.org=0A=
=0A=
Signed-off-by: Viacheslav Ovsiienko <viacheslavo@nvidia.com>=0A=
=0A=
=0A=
Patch applied to next-net-mlx,=0A=
=0A=
Kindest regards,=0A=
Raslan Darawsheh=0A=
