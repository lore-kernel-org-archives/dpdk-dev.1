Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23620C83F09
	for <dpdk-dev@archiver.kernel.org>; Wed,  9 Jul 2025 06:56:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5050F402CD;
	Wed,  9 Jul 2025 08:56:44 +0200 (CEST)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2071.outbound.protection.outlook.com [40.107.220.71])
 by mails.dpdk.org (Postfix) with ESMTP id BA13D4021E
 for <dev@dpdk.org>; Wed,  9 Jul 2025 08:56:42 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vNHcibqEPanqzlAvVTeGI7E3BQ+l9qMxDINXpmrG51+RIa952AQ3c2WOj6x7EYQSFLwlmYJRDDyBSWa7TE4ivxBOxUhKvbSrbF4N6jDehgwIZZJXij1OJL4FIA+oqGJdv176SVuCJ7qEXuvejr4B6/zi7vgqICmnr0eG3fO4F8N6JK+lTfMXTHyBe7+occ2tTHe7Y1PhUZ9Vx0ouRFJXkSMPWREFRIsxgPSI/BMfd1LnlpR9UeSDv2hw0rPSQi98n2PgMC2yTVHez4OrmU+DJfgwr+wi5cr4KRv39GfXcn0GWfpuZMncwAUfN3DIGxnhYvZvF5BiKP+vXHqgHotqig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ebFrbECeE+4g+zfWjso0Li3E0oZzRkpJTcDcGF70gok=;
 b=IsHyGUlu6qvevvbSqFFddQUjnCX4d290g8IPZTWpRn85e6gxtmNMr2sSSyQuyfhyXEoBjt156kRXBEUHln6mxLG7q5VN/QVu1uwS2iEOdJIAU8aR7xWUmm+Hq05cIk3k4B5xUPWp8g1pnXS1E5dkRxOR7yMxPpXgnbZoCXtKbwbkiNvhsH88NcFWh1GBESpwumUCD2xVXy9CCOFVT4FsuU46Cg4CrjvcLrtkjOaOueH1Qt/9xVhvwvR7lE+ZjIis5Il91DulpHJ4M+3r84OjcvjsiZSdziJLK+u89Ooxycylw1fI+wwuWznFHZ11f5a2ZquJcxnq4TxqFisQ+B5jTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ebFrbECeE+4g+zfWjso0Li3E0oZzRkpJTcDcGF70gok=;
 b=Q7WoF+swDk8Cq6lt0bVsDnl1yDtoWrXN8Ji4MzA7VL5R3hbw8yn8G+fzZBy/eSJHR6OKQd23YRPgvk00TQDMZWCD0hgkbbil+32T1t1er+lKMtqrL4aB4bR8fOhTLspk3shrAHG6jQJReJmnR7T//H9B+NaCG4qhZEguMAGKOKOfXJVza4M2Lr7GJxkj9yfTaYkeIgPI7MwpOoq+D7ox9yhsO8ZQHoM9BGwcneBzm2Lxot3l/4DQ3d6da9N9a/NBDl9O0RZcz3G9h8Q96TEtKmw9eCtpEDmprIXPFHRBNKUN6Tioz1z5jl4B15LxRqVWOikQ1hnZEH9w8ecLWO2Erg==
Received: from MN6PR12MB8567.namprd12.prod.outlook.com (2603:10b6:208:478::12)
 by SA3PR12MB9092.namprd12.prod.outlook.com (2603:10b6:806:37f::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Wed, 9 Jul
 2025 06:56:40 +0000
Received: from MN6PR12MB8567.namprd12.prod.outlook.com
 ([fe80::9bde:b697:6d6d:ee04]) by MN6PR12MB8567.namprd12.prod.outlook.com
 ([fe80::9bde:b697:6d6d:ee04%2]) with mapi id 15.20.8901.024; Wed, 9 Jul 2025
 06:56:39 +0000
From: Slava Ovsiienko <viacheslavo@nvidia.com>
To: Bing Zhao <bingz@nvidia.com>, "dev@dpdk.org" <dev@dpdk.org>, Raslan
 Darawsheh <rasland@nvidia.com>
CC: Ori Kam <orika@nvidia.com>, Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Suanming Mou <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>,
 "NBU-Contact-Thomas Monjalon (EXTERNAL)" <thomas@monjalon.net>
Subject: RE: [PATCH] net/mlx5: fix the queue length checking
Thread-Topic: [PATCH] net/mlx5: fix the queue length checking
Thread-Index: AQHb8IYMi+HS+dnAu0CL8RhS3XzKlrQpXA/g
Date: Wed, 9 Jul 2025 06:56:39 +0000
Message-ID: <MN6PR12MB85679726C7DDDF9D96AEF55DDF49A@MN6PR12MB8567.namprd12.prod.outlook.com>
References: <20250709040000.112338-1-bingz@nvidia.com>
In-Reply-To: <20250709040000.112338-1-bingz@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN6PR12MB8567:EE_|SA3PR12MB9092:EE_
x-ms-office365-filtering-correlation-id: 136dd3f9-805c-48e3-2f6d-08ddbeb5c159
x-ld-processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?Q/9UZ2+mUPaPOLhSw5RG2XNBwxXNo91KxIQrS6dZtFjU47yQJFA2YXJh0zXz?=
 =?us-ascii?Q?Ya7ADrVGP5E62vCFeSXK/z0qmPeLBiKgfRkIusFYvgckrB/5eqtodN8abE5H?=
 =?us-ascii?Q?8OJRfKVDCJbEJd3ZpmpyrhuBEPHp1TSkx4ImKB4KDabjr+0OQrwGpYA6ipO4?=
 =?us-ascii?Q?AjGZgsTYLs20qEw5sSjXLn0wjIKX8mCVCD9YGgtJIJBkikRrgQfoTaEAwk1C?=
 =?us-ascii?Q?R8Ek9/8bTd6L6fOkQ1hJd4wJUqYoozp91jjVwruPAGGEX0q6sCOKEB7PDMZK?=
 =?us-ascii?Q?RcWSNJQ4dWkNnlS859fSTSUElNcHK7hG5cIh8hatHyB1jkoaPp2++gA0qeHo?=
 =?us-ascii?Q?4M+ZTH2yp/9YwhC3W+/VCK/KIREj2FS3YfQUxE6ZebYzDneEYgmMTg52mF9z?=
 =?us-ascii?Q?2QknIZ0pLQClOoLh621fwMEM3kJuZ4zZ42Bly7tAGbqvei87D8OfybET68VB?=
 =?us-ascii?Q?NjopNUPhLqapng28t2qiZZjNq3UmfAenLwwO7vaaQHaC3feZSFl9MmyTiEdz?=
 =?us-ascii?Q?IU2Rl1VJF89IQgbD2IZYDaVz1i3StKjxnebYcuvjiBw3sDkungJ7XyIAhA/g?=
 =?us-ascii?Q?JuwO9v00Hc22ut+muFn1AGS0DfFSGh44EIgl1Gn3JI6t/mG4goi6bIXbT/d5?=
 =?us-ascii?Q?llQXwDCmGfBIiu6lmzozT9AeIWJN68ZvsMS3SzB6k1WjfCyFqko8U+t96ZaX?=
 =?us-ascii?Q?5ocBkzUhy0hk7NlUH/G7QSg4B9aS/jJUeAnbkNMQidO//OATuZI2Nk9S6PI1?=
 =?us-ascii?Q?IXKKANUw9Cqi+ZTB0MbvN/JdUEJXJVrSzBpdq40CdjooCLIVo9gJxjs+fhiM?=
 =?us-ascii?Q?pygS07mPM8O+aCZF4p8KRMk6FfABoCUWWsHXSxKb3xy5syw8bzN2oxqgyq1h?=
 =?us-ascii?Q?vDGCD162Rzka3WXR0s1H58QszdoXxoNXOLc/R+Iatu65Nz0ygJt/FeiqEVnf?=
 =?us-ascii?Q?duoxCNoXJBsa0DIyzVyI2F2U9cW61+jUR78gkLOF7bw3YEvVkOTmFkY3klWr?=
 =?us-ascii?Q?4plI8x7/nuI5VGEDlqzl8A7p3HLf3cznEoOBNtf3K8bwBEYtAowPFBZcxwR2?=
 =?us-ascii?Q?eEI8/C9R4wtWPf1Wb3zVJJpn8OihVBW8JyfBuVuBy9YvHpnzag/Sn/POk+XZ?=
 =?us-ascii?Q?VSY7mXk5s9kXTJYdG0aiSw8Rdl77BSxK4nOSkKACwBwkbAePk6Z1vqJ8N1BE?=
 =?us-ascii?Q?iAf1jdpdD03pvd9hinXAZUX/St9zVOWfD8K3qqp22KBIUHQR3eZYBfcvHy/n?=
 =?us-ascii?Q?4BvmJJGPv3+mM+ba3lsqmTEQxb5TN0k+JZ6TaHQ5fEHF3yZtIVmtMR7BHR1F?=
 =?us-ascii?Q?N+pYzWM1JSOvecexm2IPr0A09WbVSnx6E7sqcntFqGJM6HHiHvlCViCNsh8t?=
 =?us-ascii?Q?AaJ4a5zMV79bogYGJAmN2A5WJ8RQrWe+C8RfWi45YNn4yKRnhSmDX1pOk0jG?=
 =?us-ascii?Q?smeBjRc0tIKqhDRWEbUT1//J0GHkN6djSA4knraGcx/B+0ao6KFfdw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN6PR12MB8567.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2ngIL+s0YjoDZjxBh9/Q81mNtcy6qDcPjKVUScdc6zbY6JFnYTi/MMU2zZDb?=
 =?us-ascii?Q?L7zbyJzW17gsVQ/Yj5B5/UZodUj/3TjKgTvUXpjcGSfwcWktn3a5vkBpi9QG?=
 =?us-ascii?Q?KmTK0G04r1SiCM/XLo6C3kvhexF7wpk7lnbl1XX4CHXODgoBKcJRCNplRrQu?=
 =?us-ascii?Q?MBbgNAiK5G+0hJTBWrpirBsAMzQ6CXoLKYd1cNmYRu57IepreVPA9zhdAzGW?=
 =?us-ascii?Q?gV3L3YUGDTpm/2irRn7U2jYgU64fqXjDMS/L3W3BnlOmUKg5vOsCT2ycC/dn?=
 =?us-ascii?Q?p11Yiu+ASAuAerFnZYyzmZfP983n/5qsAi4nB1Tep6XD6ot9whKAhHJObv6G?=
 =?us-ascii?Q?ZvxJrUrhqkKVhhjdnBnjoQ0KKJT6NbAPVcb7CLKPvt4pshrIu3ZI/ocv2Fq8?=
 =?us-ascii?Q?mKm6MoUcXPwkJYtNL7BKoAd9F8wGo3oQRxAtkhdEccKXa3rvzsIAxQ6lMrP5?=
 =?us-ascii?Q?qd89SYZNUTT5X2X9IpXB9PD48WwrhXcnHeKfmWQTlw8YaNqClZVJe9fn27WK?=
 =?us-ascii?Q?k1lyiN46785AK4G077FfkrNHMKvdIza+LSJy1sw6/NQtpurEzx3hUFi2Jytk?=
 =?us-ascii?Q?LQ4mBtgf4jsOJ6ntYA6HsHfCSSJ4WDz4S89LpTdXhBd6V7Jcbw+pWwMnLjqn?=
 =?us-ascii?Q?tcPgMWoQf5ZR8WmHVh4TX4crGhJhxuJ0Tas9UhvMYblvoDQSQY7ziu2AvE/d?=
 =?us-ascii?Q?LNgG/XjKyGbkXN5XTfWkItT8WzTZNd6RCWseEpkaQIn6aFsmia+umFsSt4p3?=
 =?us-ascii?Q?Nw73HSxjlbeJhVOwrNSvyyo2OVN1ZRFSJu6xrbb6y3QbKZuZ17uSYycxxFZr?=
 =?us-ascii?Q?GwnELdiLmIMTkx05E/9D+uKq8tBI7wPr8LUbvupZi4iWydXnf5wcPGsILU/W?=
 =?us-ascii?Q?IVPOBjDdBUjBzS77Cryph3c79RC61J5CIJsQj3bmhGWZxlAle0mZF+AnjT4t?=
 =?us-ascii?Q?Xjkei9zKQR7mEpK/bogSYg2OHFVE3q3HAGkHWordvBSXySvTMNGWXgYCse7V?=
 =?us-ascii?Q?36XhIMatgeG+NrepK13oXjAiBhzuy8z74xL6LhxqI0zQUd6vvSIy4apIeYMh?=
 =?us-ascii?Q?AUzV9193BsYlbueEZ/LEG9e5ofAqgUIXD0NokXYv0eaUJ6lsnBCFT5Vx26iL?=
 =?us-ascii?Q?18yzVtbXjYKVK8FTHTp7le7eB8SZPwiRM/ky+406i0i3/8N5llr5ZZuzcDEU?=
 =?us-ascii?Q?ycS9TTd3jc2OV3R2Fjnjg/R01jVdwc0Jm2mBTYN6GFcJYx7k8Z/KrrWfcLLR?=
 =?us-ascii?Q?J3DptO03hOPziipIlO4ybLtNtjINVIRsh05tXLLNxn47jMiPCVwEXRa3+QdD?=
 =?us-ascii?Q?Ud7GEESJLf8upiLL65nvTCSXC20L1byRkeanglVoRxEo2wLCP3qC9XlpdU6E?=
 =?us-ascii?Q?ZSmiO2QrAJzqAPtjZ8JUFPApSLK0XcVMQEFEZtMFjf0SNsGrG3DPj13GcnAq?=
 =?us-ascii?Q?VqRgjd0noE+Hc3dwBL1an57Y1Rj6a9CA7BCWrg1tDIM04IYsljtk4SkXyEHP?=
 =?us-ascii?Q?kYyd4uiBd5QAQ8kVaJEM129iW5yqssNTOceCtT2cmwM6ckGqGuvJ9EakRA9Y?=
 =?us-ascii?Q?P8gQ3afOLNLg9sN0t3ZpnRmxHgBL9T/xvm1L1U21?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN6PR12MB8567.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 136dd3f9-805c-48e3-2f6d-08ddbeb5c159
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2025 06:56:39.8406 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ikFOxXG5y3z4IBBkuu1o103EcXA+62pocb2/meVfG7zJVpk3tplsZic/ySWGDOGmb9wvIpRte0jVPirSttZ2yA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9092
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
> From: Bing Zhao <bingz@nvidia.com>
> Sent: Wednesday, July 9, 2025 7:00 AM
> To: Slava Ovsiienko <viacheslavo@nvidia.com>; dev@dpdk.org; Raslan
> Darawsheh <rasland@nvidia.com>
> Cc: Ori Kam <orika@nvidia.com>; Dariusz Sosnowski
> <dsosnowski@nvidia.com>; Suanming Mou <suanmingm@nvidia.com>;
> Matan Azrad <matan@nvidia.com>; NBU-Contact-Thomas Monjalon
> (EXTERNAL) <thomas@monjalon.net>
> Subject: [PATCH] net/mlx5: fix the queue length checking
>=20
> In the new consecutive memory mode of Tx queues allocation, the needed
> WQ length is calculated via txq_calc_wqebb_cnt(). This function is used b=
oth
> in Verbs and Devx modes, but in the Devx queue creation, the actual lengt=
h is
> re-calculated / adjusted for the Devx API. The queue parameters
> 'max_inline_data' and 'inlen_send' are used separately for the length
> calculation for different modes and the counts calculated are different a=
s a
> result.
>=20
> So passing the mode as a bool input to adjust the calculation in differen=
t
> modes will solve the mismatch. In the meanwhile, since the memory and MR
> are allocated successfully before creating a SQ / CQ.
> So the error is not critical and a warning message is enough, the saved l=
ength
> can be used to create the queue.
>=20
> Fixes: d94177339289 ("net/mlx5: use consecutive memory for Tx queue
> creation")
>=20
> Signed-off-by: Bing Zhao <bingz@nvidia.com>
Acked-by: Viacheslav Ovsiienko <viacheslavo@nvidia.com>

