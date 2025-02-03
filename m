Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 034D2C02192
	for <dpdk-dev@archiver.kernel.org>; Mon,  3 Feb 2025 19:00:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5FF064029F;
	Mon,  3 Feb 2025 20:00:58 +0100 (CET)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11021092.outbound.protection.outlook.com [52.101.62.92])
 by mails.dpdk.org (Postfix) with ESMTP id 7C9ED4003C
 for <dev@dpdk.org>; Mon,  3 Feb 2025 20:00:56 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tIOZHtB93PRYZvca/SMRoSgoM2Pyht+BWhrbR7SZkE7RWx3/DHMng6wQWwj/NgfEnvr7ur6P+rDaRI3Yndx0YI9SwcSwNiyqeN44AkUrlogevNhlPstq6ZsGCyZAAJtsYY1Xl6K92LzG1ydWSUkcJRdyLVcNiT/hLnEZWGC9vsB2cWz01Ic9sDYHou/aX0Gx3Yxz++6vvG+f6wWj1pSALnkClhOaUYtx//IbQVus6I8i5ffxsenjZKfhyENblTnlznxz1qypZYLa0z4u7PQ8F0hnhM65KBycor9Yx5fa//R+UDeQb8uKxbMOFrgqZTqcWq/KOREJtVdPHQqzZH8EJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HyENrrWLeTdzI05TcBZleimWErPpRX2zY1zx1ArJAMo=;
 b=M0s/x+9ZUq8CgLtF6FXzViuToRiNhHI1kwColkPRMF1RPC358sQ7mRD7HoG10GI5WVvOdcukwZXHTjTeHEPjARQZCYF9dy1z0qi41ruitBaMWCTfCg+gPMTNETlA2Hj0cvmadiqxIAmvv+kHs3BO6zW9ojNh3pcyTiM1EI2uO+zCz401NFgR/aqU99tLpKPVF+oVxu3/AuEITS6AROxLKciKsHk2A90Kj7kmSXo1nYhVheNtRGnmYp7gplBUYbQ8O0pjj3hIV1W6QXW8qwupzndTK7ZZORiaHHf9DiZEwgv7DuIazDg9HHeBgdG13bpVeEuR0QzR1oKk61yMR80gHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HyENrrWLeTdzI05TcBZleimWErPpRX2zY1zx1ArJAMo=;
 b=RqaNgpoTBrvzE4HVip5rEIDad/2eEC/FbGWA/Vac7Sue1AMr311LdvKZMbmpD1cAQXvSxHNhY5hsb5I/y/T552JqJcv1xVZ98eg5kJ73pD5/X8dT/3jedngfPOsa4z2DUn2PAoypUYw6aGdRBymZAePhw+T3n/QxocpvQ9vAL74=
Received: from SA6PR21MB4231.namprd21.prod.outlook.com (2603:10b6:806:412::20)
 by SA6PR21MB4508.namprd21.prod.outlook.com (2603:10b6:806:420::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.3; Mon, 3 Feb
 2025 19:00:53 +0000
Received: from SA6PR21MB4231.namprd21.prod.outlook.com
 ([fe80::5c62:d7c6:4531:3aff]) by SA6PR21MB4231.namprd21.prod.outlook.com
 ([fe80::5c62:d7c6:4531:3aff%3]) with mapi id 15.20.8445.002; Mon, 3 Feb 2025
 19:00:53 +0000
From: Long Li <longli@microsoft.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: "longli@linuxonhyperv.com" <longli@linuxonhyperv.com>, Ferruh Yigit
 <ferruh.yigit@amd.com>, Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>, Wei
 Hu <weh@microsoft.com>, "dev@dpdk.org" <dev@dpdk.org>, "Matthew McGovern
 (LINUX)" <Matthew.Mcgovern@microsoft.com>
Subject: RE: [EXTERNAL] Re: [PATCH 4/4] net/netvsc: cache device parameters
 for hot plug events
Thread-Topic: [EXTERNAL] Re: [PATCH 4/4] net/netvsc: cache device parameters
 for hot plug events
Thread-Index: AQHbcce/rc9eOeRySEeaW83iwXBySLMs3iDAgAHU+ICAB0MBUA==
Date: Mon, 3 Feb 2025 19:00:53 +0000
Message-ID: <SA6PR21MB423122754AD8AFDD48AA94C6CEF52@SA6PR21MB4231.namprd21.prod.outlook.com>
References: <1738028106-25239-1-git-send-email-longli@linuxonhyperv.com>
 <1738028106-25239-4-git-send-email-longli@linuxonhyperv.com>
 <20250128130056.399a1dd5@hermes.local>
 <SA6PR21MB423184289E69944273AEC587CEEE2@SA6PR21MB4231.namprd21.prod.outlook.com>
 <20250129195915.758792b4@hermes.local>
In-Reply-To: <20250129195915.758792b4@hermes.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=b0be8a63-a656-4d55-bae7-20643d4f4250;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-02-03T18:52:52Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA6PR21MB4231:EE_|SA6PR21MB4508:EE_
x-ms-office365-filtering-correlation-id: 44043d48-338c-4464-86e1-08dd44851558
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|10070799003|1800799024|376014|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?bhnQqZhcvfCOLyoNHs/ujEsF72VilyVTjPsRyfzCprJURuqqZXYAFWPrM5oa?=
 =?us-ascii?Q?1ISEZF0lVeO9tjPwBZZ3JOwwGV+vLpoKhVjQ800G2lfJHs7sLZBW4Dg5YUzR?=
 =?us-ascii?Q?V2XmtsW8ZEezbi8MWK/OgA2I4fvBBDHmi4vErKOulfwlLULyI3kMttLgRvMw?=
 =?us-ascii?Q?aySLSaf44RVuHP2f+LwMbMjiMtlhDoE2H2FhMZSW2Ne2rsKytWXdFhGI9/dS?=
 =?us-ascii?Q?V9lrTLKMx1JKrMWTxgj/lXZr4GpNJO09eG+DkOVYBsv5wpThcoWsoJIuo83w?=
 =?us-ascii?Q?uLyHJ7mgC2jnw9mcg01re8kaSZgU1GIt3a6JqQgQmhUWhkzyzCB56aZtI9qR?=
 =?us-ascii?Q?GYe1pgRccS9XPiKdhRs4TQz4jfA42oAN+M8unmbQZGjYh9yRC+cvS9BI01yp?=
 =?us-ascii?Q?xRHJPhTdjegqe+WrTSX6+5X320MrPwHGPCMBf4fMDIMa8PixE7GJXtOvScZs?=
 =?us-ascii?Q?3YDq8vnT+/V0U940tegEByg42AYjs/46vL3+qL7tQdtpGdpwtRiDkjTnNOMN?=
 =?us-ascii?Q?KZ7mQWO1FeGC1c3RL3nnYSl55SV38XDeMEe6yEyFrViuZRyc0q9bjdBasYc9?=
 =?us-ascii?Q?UpZ96fUjgDZc6DDQktpITN7uPVRfnuljNrYhpLt7/d+jth9QVRBrzpd6VSsO?=
 =?us-ascii?Q?Xqo/bbkVwHxZRwGxBmPBufTHaikYZs3zaRiHtSzeKCU/ggpJyULVjGO9dkv3?=
 =?us-ascii?Q?OMIzben5rBdatjX5Fy9tUtNoaXlLlHKTF6uH5aeM+8LS5z6Lt+xXvbg/+tIm?=
 =?us-ascii?Q?xbKmZ00bDHVcmhixBCuopcNb5a8PzQxDczTJ7Aay1ykF8pKq5EFKlsix/UqM?=
 =?us-ascii?Q?7oAu/e5GxkfI/p6L3IlKUZdcifnF9oU6QQJXE3wtCRjFBGL1P1i5mS1pkveX?=
 =?us-ascii?Q?dmc4daGZmnY00Y33UiDRDIf8YOcE59dcC4PgA++zEd+CwNRCT8hMtqweuAAn?=
 =?us-ascii?Q?qdmgwC4XEzx+Z+rOkG+9fhnAuEBsD2+jiA1DAaVTmnhTiEBcTx3dKFIXLR6p?=
 =?us-ascii?Q?qudz4ZLjQ18AGxVNTlzKq8jyS4tqqO02zLMAI91XtY3HH3XmjOyDXXLQfkSY?=
 =?us-ascii?Q?TR2wvFenmfqstqr4J3ssjLw5jH0MzriWneMVXYtjp+SU2jdKUJGKkZ2B+wHh?=
 =?us-ascii?Q?ko2cKUiW315sbJ6aWsfseM2Ep818IEiVuPOySKs9QH6PMwf0wN3mA2QHM2Nq?=
 =?us-ascii?Q?uVK/1fFTyq2wZMsZX46avus1LH5m9utMXQQ3I8CXB5qkiMNXj3mEd6UmOzTn?=
 =?us-ascii?Q?1OgOOlGRiSeX27mFuUQIJ8vlLVbABRoGcNUw6EP+ilQ4jj0MeZnv7v4XbilS?=
 =?us-ascii?Q?BHQx3UpadZBexgsQnlUChfmYfq9Dw+7Uc0xKxQ8PfePIwfzMl3i5xqSIZj9o?=
 =?us-ascii?Q?jiWqk5gu9peJXMDgv2lLjj7C7t4UiIY/fcmC6A5uG3Mo6jkRvyLpU1an7dqG?=
 =?us-ascii?Q?9NQmzYRM/+Toy3rPHhKE7msaXu4BkDfx?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA6PR21MB4231.namprd21.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(10070799003)(1800799024)(376014)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?K+jbiyJz7tuosDbeipJNaffUgci5Cms4y8oxxlNY7iijFyILgX7BZjodKgfT?=
 =?us-ascii?Q?/z6rsSFNvdIGOG4BYX0jsZR+5hdmuxy8ubvszSA1wZhFr4ciapCnbEhsYGk8?=
 =?us-ascii?Q?AfhX9J/t4ngeOkpVVILyKCZraN4bhOc7yTosCAVFGLFqCPz2X3UdnRGfR8yi?=
 =?us-ascii?Q?yz5Va1z9bV/PdQl07pJMfQRlZ1ZqCOk0RUmnWBgVrFpIA6vmZJZHf63Gxv7s?=
 =?us-ascii?Q?LoqDBJ6iWwOofgMhKQ7e7wEjyjW7d/bRg87wWwmmN7IMdNVF4E4XuvQlP7rz?=
 =?us-ascii?Q?C6AkR5cdyk7YDoFBOVnQSHidIKvrbBB3r92Ux/CiQKHrHZB60HtMtLNPBy8V?=
 =?us-ascii?Q?/y1H4AIIBjGvPS7OU3QG+4rvU3cMYzbqH5BI0qFWEVkDvF1aJE0TKBwYjTvB?=
 =?us-ascii?Q?aVP9vVm7sIPC7i9InSWogvWE0ecuzqO80hz1r5RcYuGY+f5qGyg5TuN9mPO4?=
 =?us-ascii?Q?8WRb6riVho526mpr41R52RW8oiCbE0+gHgevHr99Fhc2+lUHNfBRxl5Pf48t?=
 =?us-ascii?Q?aa+QiW+UDNqaD4oGzd9tg6pIgL+drnpwZZxvQnmLVjUG4olAirX+M9nonEFK?=
 =?us-ascii?Q?z8w5Vz9t0gOLt+xozmvgDHJZSQekBFiJBPp6CyepHvcLwzVOlnp2O60KyOlo?=
 =?us-ascii?Q?JujI3yZPBb+qwWHG6CAlvdsOu63wuP8Lf0WQfcter0B5mtNaEX0T+vex3AEk?=
 =?us-ascii?Q?3fqDeek3yr1cwTPUgX/72t3lpLgYFaVKvKIqv4x36vEE47y7nIikJbGFYL88?=
 =?us-ascii?Q?94TQAxryWKqXNErEQ1bkxrGxgq1Op4+zwUlHYm0Od4jUphsgbZ1BJ+uztvOM?=
 =?us-ascii?Q?bdmuBFpwR4QjV39sy2W/Z0Kmqewa4LADq3zwFBtTMbaK6N2T0xhtF4vTVDrc?=
 =?us-ascii?Q?APfKk7xQqBItojtZYkXiYjZ0XHpEeU9QGzLSKlTqysFtLnymxxoK/DZNJUZg?=
 =?us-ascii?Q?pQAGAN7Dhvsz8rnueTYHf13aviPTCDf2gK0HnZ8XhX9/pvFR+uQsCrGlji7i?=
 =?us-ascii?Q?7if0SAAAqBnXUPHg0yJLThBMUTRSN+VE/j6hDpte4Bmi09TNtLTjiLpMl3xE?=
 =?us-ascii?Q?6uuI/dxqJDF8A/widz46/xfsFv5ggkjnmktdertg41p4cmU3A/FpXW4l2BjC?=
 =?us-ascii?Q?Dja3jRiMO2wE5Ftn2AEh7s0ljOuyD3VhdYNMqXkq8V2Y4IMlb978PuiKXiL7?=
 =?us-ascii?Q?ajhW5tumnzHzOvQUHtTE888HFrZ1CyJlDI0ImpZZiydaVFOX/2EyhLqjTMsr?=
 =?us-ascii?Q?/Na+IqYT1YMbyMczvCw8ROhYGXwRi9I6++kSbNfpvyoMijrMhfXR9ifDrAjp?=
 =?us-ascii?Q?IwaZw4EiwLthuiEEecdsYAfaoXpB5Q//uy0lOySo9LB1dMW4Rr9tsYrWE6S3?=
 =?us-ascii?Q?MNQ+ahjTogGR0UvRUG1JPOHEzDRinJN4BPx5yr7pqU+8W1IU5ZrWOHeVwYsa?=
 =?us-ascii?Q?pUmbDzlux5nuzAHIwxGixnqpwimasvRMwgqyFGLN7+0kD8IJm+NVervaqilo?=
 =?us-ascii?Q?4PLAb/MVzSdCYqnwPG/RMKXoVo3pvh9yYdXyl/T+rIVRx4OJdnLmWH8YljrZ?=
 =?us-ascii?Q?pEDKq02+HOQKm6GgKx9A82ub084oUe7L3zIBCm3sA8sD8U/rgazWRyBYMizI?=
 =?us-ascii?Q?a6uhJNX9pA3XbbQ+sl4OLNYgI12siklpdaLxDa18tBsu?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA6PR21MB4231.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44043d48-338c-4464-86e1-08dd44851558
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2025 19:00:53.5886 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rx/RutT1LzllcQ6VZ3GzIOmxlH4gftx7ZK0vGoBuAyOoCg7fMRD301H1g+6vQjbJhooCw4/ECDGlCk3pNLT3lQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR21MB4508
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

> From: Stephen Hemminger <stephen@networkplumber.org>
> Sent: Wednesday, January 29, 2025 7:59 PM
> To: Long Li <longli@microsoft.com>
> Cc: longli@linuxonhyperv.com; Ferruh Yigit <ferruh.yigit@amd.com>; Andrew
> Rybchenko <andrew.rybchenko@oktetlabs.ru>; Wei Hu <weh@microsoft.com>;
> dev@dpdk.org
> Subject: Re: [EXTERNAL] Re: [PATCH 4/4] net/netvsc: cache device paramete=
rs
> for hot plug events
>=20
> On Wed, 29 Jan 2025 00:10:12 +0000
> Long Li <longli@microsoft.com> wrote:
>=20
> > Another approach is to modify EAL to never delete driver arguments when=
 a
> device is removed. i.e., It doesn't call rte_devargs_remove() on device r=
emoval,
> instead keep those devargs for the lifetime of the process. Do you think =
this is a
> better approach? This will save work if other drivers want to cache devar=
gs list for
> device hot plug events.
>=20
> Agree, that having devargs be smart enough to maintain the list for futur=
e hotplug
> is sensible.
> Do other drivers that support hotplug have the same issue, or does no one=
 ever
> use devargs with things like failsafe.

This usage is most from netvsc and failsafe.  The other driver using it is =
ifpga. But it looks it doesn't handle hot remove.
I'm going to write a patch to have EAL cache devargs.

Ferruh, is it okay that the first three patches can be merged?

Thanks,
Long
