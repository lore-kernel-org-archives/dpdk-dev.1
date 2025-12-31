Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40E56EEB573
	for <dpdk-dev@archiver.kernel.org>; Wed, 31 Dec 2025 23:22:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 14624402A0;
	Thu,  1 Jan 2026 00:22:09 +0100 (CET)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11022104.outbound.protection.outlook.com
 [40.93.195.104]) by mails.dpdk.org (Postfix) with ESMTP id 263D240267
 for <dev@dpdk.org>; Thu,  1 Jan 2026 00:22:07 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JvL/qdQJg6oLK1mUIwR/OGP7D+CEzIeccnHn7qi9UYS6cW1SF9gFGpX/oHrJsjfP2xUJ5m6LZJn0lq/Lkp6XVBv7rI4krJo8/1DV76IRlpZmNjFPuCbnebLtJGcKvAwex95TXyvF4v0c/tFiYZixRoIoh/1z5MeGXGTF4t2gy5Z6V83NnOd38E2JuJje4Ornn1ZTpH6yffv98K4NOwZ5YN5wGVO3oRIl3bfVg/ttg4VlqZE1ZIjR6UHc1jOCMAQiaaDwsZ8slZOinheu+YNi3YNgs/zH/g7+fxd3MmqApTB/Pw4NtzvGK+IyhERxPBeFxYNkqwNXaC5XvG0uy1excA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Job42SgbgCsxD6D1rbgH0webZ1ueXiqHRRf9iyP7tFk=;
 b=nGDKKI6PEHv2HJBFn+HoHn3+/f3X/n0SkRThvI76V9IshX7p47xxuMKXIq3vqHdlTxyQlIV8ei/up6uVFVOL2KwAidR9MTAD6x7ZpBfqdLEONkUDSLq6g+aAg4M07lh7B4jtsgsXn7E70GiEK7MK6o3FkZsALOj02TpWdCFZeVeCOKGgOakl2sAc4H4XaKjxjhKts18F1v+Y5pL92Ir4jo6ttQQvSkWMNQuSvgBc56q6aLAuhJOtdk/+8uto9GEju3OY77Cys/lXZlECxUXoHLxnCtuKw/mMjigDvKPbWcPSLP/Rkp5MXn9uFR5cmIbLgGQKu9ON52TDFm+CFt9OXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Job42SgbgCsxD6D1rbgH0webZ1ueXiqHRRf9iyP7tFk=;
 b=WzWokV0bSm33PMnojesepj8j22h4voEQMHFMc7gfQvlbr9OrmxdE0JGC9xj94BHyjjvYkXTg5D1iV+9bIQayMBz9FKknbsxAbcV9YQsq/iICIlp18jh8ZROCH77nfQnYzjoQRioSRyrBXt1eKHqtFEISBzsnavNT22u7nJTpGnY=
Received: from EA3PR21MB5743.namprd21.prod.outlook.com (2603:10b6:303:2b1::20)
 by LV2PR21MB3373.namprd21.prod.outlook.com (2603:10b6:408:14d::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.1; Wed, 31 Dec
 2025 23:22:03 +0000
Received: from EA3PR21MB5743.namprd21.prod.outlook.com
 ([fe80::643:a9be:8194:f5a5]) by EA3PR21MB5743.namprd21.prod.outlook.com
 ([fe80::643:a9be:8194:f5a5%5]) with mapi id 15.20.9478.004; Wed, 31 Dec 2025
 23:22:03 +0000
From: Long Li <longli@microsoft.com>
To: madhukar mythri <madhukar.mythri@gmail.com>, Stephen Hemminger
 <stephen@networkplumber.org>
CC: "dev@dpdk.org" <dev@dpdk.org>, Madhuker Mythri <madhuker.mythri@oracle.com>
Subject: RE: [EXTERNAL] [PATCH] net/netvsc: Fix on race condition of multiple
 commands
Thread-Topic: [EXTERNAL] [PATCH] net/netvsc: Fix on race condition of multiple
 commands
Thread-Index: AQHca13fON/7BJ3k7Uq9o8X1sMVdRrUpQRDQgAGkHoCAALvRAIAQ3UwA
Date: Wed, 31 Dec 2025 23:22:03 +0000
Message-ID: <EA3PR21MB5743C76495BAA587CAA14C0DCEBDA@EA3PR21MB5743.namprd21.prod.outlook.com>
References: <20251212115238.59710-1-madhukar.mythri@gmail.com>
 <DS3PR21MB5735BCEBB4C726C7E0B7AC4DCEA9A@DS3PR21MB5735.namprd21.prod.outlook.com>
 <20251220102503.54d04c5d@phoenix.local>
 <CAAUNki3mxT3TZNxmiyLYU6zsjXdvCj6ZxCX9QU8Nh7JQ2HV5wA@mail.gmail.com>
In-Reply-To: <CAAUNki3mxT3TZNxmiyLYU6zsjXdvCj6ZxCX9QU8Nh7JQ2HV5wA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=6c1230a2-963f-42d6-8b05-6080c7458bc8;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-12-31T23:09:28Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: EA3PR21MB5743:EE_|LV2PR21MB3373:EE_
x-ms-office365-filtering-correlation-id: ce38b82c-cbed-4160-c996-08de48c36808
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|38070700021|8096899003|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?sMl56qu1OCvs+gCESitc3qKlGYv7Zay5lt0knSry/srIac4DV+49rvD75hiS?=
 =?us-ascii?Q?F7x7Logl5iAC1/i8XDkYPkYxlbMhtw6CPLCUdiyX11yQuj4wGkFepc72HnL1?=
 =?us-ascii?Q?nUSYkxPlC2hIvWvbfS/ywVTvatL005bMFKY8Lx4pS/3nuAzA6RPhMGlM7ETg?=
 =?us-ascii?Q?LX5IB2AXEsKT071Ocm47gj9OJjqMKp2xelHmaFZm6RD+aWXYiiuJOL8/8wn1?=
 =?us-ascii?Q?JgSwZ1OVfkYbZ5eHA6TTpNrJwg+EkVjC3OG8SQ54ccus02CiZKPnhPFASnQ4?=
 =?us-ascii?Q?bBnHpjlXk3K/4TZxOmQztR8hC6L7CHEpGohy6o7VEMJvhXwg0hzUfnUqy+2A?=
 =?us-ascii?Q?2aCsI4sYy6+PPhJapNgFzKb4eooGPV+8QjLsp6Uvw/aetJtmJ9kVSSSxhpVc?=
 =?us-ascii?Q?/cwQ/2vQd9nAOfMpWmupddBUjClHQ3xO1k3K8ApzC/2onONeMv/yPRlDFom5?=
 =?us-ascii?Q?UXQQRr3VC8MWNOg0hu3rQEqtKBhMzRkMl/3KmhRmcWfgLYu4GVF+lfOCk6hh?=
 =?us-ascii?Q?rDYF1BnbT7QUD091L1Ekb2aZgcPyrB1R7coVVrLeobcM0ubOR/Y6GoSVWGZp?=
 =?us-ascii?Q?VOS5n4Yr8b6zyIKv02KZUPQdhbzMmjd1GrHO4snTnKKzxEaMYWiV3pprZGfA?=
 =?us-ascii?Q?2cluqK4x+1ni70sj0cuqhgTKN4N7oYiZ6nsl292/aZZQbbZZMGCMgMdb2sR4?=
 =?us-ascii?Q?YuhqtDfU6EZHwqwma7yxIpkQm01sB6o+ntyX/5hH4n6YZqbdLLD1/ey7BEkc?=
 =?us-ascii?Q?zfSnzXWLzYwzVyeeSoGhD1Bec7hzvM4bncCp6eeb8/m0wpfzIwTzIvIqnkek?=
 =?us-ascii?Q?VIR8xa2Fq6Xev+uun1LTp1UgBly2LvRTapBr6wJDh86Hig4wr4nIWSC5oenp?=
 =?us-ascii?Q?mI7vx7DiB0QRyy1UBYCfe0w4qyCe5r1CzauPQxbg9n2h3QbiDBAwydthB+kf?=
 =?us-ascii?Q?ywwTY2PCU+5W68jqWX3Rj2Uua3PoeVS4MEW1ZU87F/yhPBMQiZrhWPLHjuZa?=
 =?us-ascii?Q?p6o7T70Qo5GZf7RkKIDri6KJ1Tkzzt6WywP+vpSYsMFvipOK53eUy+rRceWk?=
 =?us-ascii?Q?DFvlepRYpashNvowGO0zyhK3qGHBnSS51pTUGzGGiq7l4cRCAZYQLy7wfpAZ?=
 =?us-ascii?Q?+32zeGG1BN+DFaSYB+IatSk8bv4VfduZn2NvhD01utcpXSaAORPYuUI+1JTu?=
 =?us-ascii?Q?1rNrEyV9BTBrNoW767LBG0iLCojKAL26S8SZxc7Ce4xE4mUnwEk3i/+Y4jwn?=
 =?us-ascii?Q?Mik406gsnWzSFqWX7veev7YSPgRYZt2XsfoKAuzsA1m+d33hlEG3abLHRl67?=
 =?us-ascii?Q?2hWEpYQV+VATl2VeZpEHcEJ2zqBLHak5/BtylWnLSkPQfius3rNKFgoZfZ8L?=
 =?us-ascii?Q?Z/kNy9vHyxPV6uJD8mSzYgKrSUTAzTQl+nVxZxgCCBbtxK8zAn0o6p62YtHW?=
 =?us-ascii?Q?k3ciFTYZYLmMHmW/rfSnLiV7t2+4AIetd/QQb+rUVdYng3IxKD9dXjG0TW/U?=
 =?us-ascii?Q?I5mjiJjbS9HZ2npyS3BzI9pj2/amCM6kDi47?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:EA3PR21MB5743.namprd21.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(8096899003)(7053199007);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?NDxHHLgBVcvWRvV49OnGxb0N088vfD/B2+biyr5d9WUnOr66NAs8eg5xtx41?=
 =?us-ascii?Q?vOHB0RxDQHzDI9OpYeyeCJMSMH1E0VRdWEJdODq6u5vkIaidRM67T+m52gTJ?=
 =?us-ascii?Q?ZU8L73NyBDCtKgb7TTQq7Yt0N0G6ypSPbSkJnBumM4PFwgGoxxmD90B4xNeU?=
 =?us-ascii?Q?qW0sxNXmw0w4NwCA4bL88CGC5iQXOuI0s5F4jz7QUmcJB5fOHKPsjHhoPVH7?=
 =?us-ascii?Q?VUGovTKY8eXlZ7F1Lt+dUTvO/nSpP+UVZaKyY7wzIA0cW6CQwFR/f4xSaMmn?=
 =?us-ascii?Q?m7P8L9d+bVD0ldSW8/tRvNqIGYSvaY02q+5y5kE2bBxuBS8ooeQ//AwA8A3i?=
 =?us-ascii?Q?QGodlNmLZTw6DOpXtScD16I3u+hAjOyg/bVAwXSb2ncyguoBZmoMyrkxbCYy?=
 =?us-ascii?Q?jAj+nalFhpzZ2WmT3AuqzanCokT2dNvvA48P8SjEHOxdBp+UGOT6ZgB9SNFh?=
 =?us-ascii?Q?YdhziI2ari1Y2FdcLzPIGs1Y45NqUvzFy/TH+e4h7266ZhjyeKZKzPfz1xyw?=
 =?us-ascii?Q?6h0aX6Uy8fW6qCo91lKcipAFRGVVFYfFK0GAxSbJ4SsW/FDdmzZj9mFaHKCb?=
 =?us-ascii?Q?cJdkHn+qA5+YiTo8/HUKzd9zgs5tjG4G9W66hah7yyPA1n+tivTirBbGfvpy?=
 =?us-ascii?Q?33yP9KbXlx9BzxKC9le12A2nOwk0nxOa1gkRUJYGljNaxcYg1NJ0rQkzU6ub?=
 =?us-ascii?Q?kiOOE2kRgt/okoah80kKR887TTeP1bYvvjmAnTo8dUifFvwKE0ftw6rKrDHJ?=
 =?us-ascii?Q?kh/9Kfol4TWWX9UNgGcRFYSmHrTopujVJ4/bXea9hpsO7uUij1g6M0BT/xXr?=
 =?us-ascii?Q?qSAAlSDrG3ISRWGwNSLH0ckQl603D8WXrb4e1no2rxK8V7bSYmopOE9xFamR?=
 =?us-ascii?Q?FI3T6VWfEbuN53PBaGcgZ7jSm3bEpc2e9K6ZmqLE1n3Zo1AZVep7RfPEYDJn?=
 =?us-ascii?Q?1IYuEIuZQpyS0cILRFDh5Cg6fg2VEmw2o6wIoPQRE+/IdEThycJKIS7RVKmm?=
 =?us-ascii?Q?5NscWclTK8kCaNtwqyipP+R8PYsCsoExbl4RipxREQ4yxxlUu3adqvG8L0JP?=
 =?us-ascii?Q?ZpPUj9A4HAWZ0MBi8Amwzzm+xDM40RTtVvz6roL0Jq5feL8K8f8+jkhXazlk?=
 =?us-ascii?Q?2znKGqsbuX3vDoF2jN+1g9v1K9/ia4PWmfX4JKn0wXhsS+zyG7o/Rzq02yqc?=
 =?us-ascii?Q?qYrWbXXxqTb92Uo9eEU0PGj0IvhdX3kmUU7nF9F1sK/1u42SfjZswdIn2OOv?=
 =?us-ascii?Q?fQ0HGuobjjocPshagMLm+qYW7rPgrN5KiWGCkBMNa7uWPGFZidvq2ESOLV2b?=
 =?us-ascii?Q?HR2lVs07QkR2O1JsFDJwNcV+2xsxd5LwwFt1Lkue8hP1XdUofzENfd7hhUKl?=
 =?us-ascii?Q?pz+79XNeDVjO1mlKIRgIvXoh5jDLghCVUGOsQE9bC6NWlrjvFWdyXQrf3ZX+?=
 =?us-ascii?Q?QvGTzMor36582UMOql0EP6i4W1i5Wz/jVzr+9ucXW90QY8oVqD9uQ3OSPji8?=
 =?us-ascii?Q?Nd/XYtE10s8uGTy7PDWOm9z/Grm4s1G3LoAshpLvxwT9FjgOUq051IwwyPuB?=
 =?us-ascii?Q?JMBVuwJQsUsVCBolyLEG9rO5sH98WRMhSTChIAeHMvNFa/DmExM1kMDFNN+e?=
 =?us-ascii?Q?/6FEPvwwoA+CPDY9aTkh3+IDZJcu+Slz1kI1oe7ZZaoqT+9jJaP574GhIb58?=
 =?us-ascii?Q?LtJJ5t44NjpPYP+F22hNcOmlnwGPo+za5S4EbPi9KGE+tlHU?=
Content-Type: multipart/alternative;
 boundary="_000_EA3PR21MB5743C76495BAA587CAA14C0DCEBDAEA3PR21MB5743namp_"
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: EA3PR21MB5743.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce38b82c-cbed-4160-c996-08de48c36808
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Dec 2025 23:22:03.4274 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I+smK0BXX8i0D/7CVyirnlW0Sfss2zjmcWfhBETD3wqx9CHqia2q6tiAb8ttVpFwDyA0oaMWfan0uZaNdDZJpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR21MB3373
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

--_000_EA3PR21MB5743C76495BAA587CAA14C0DCEBDAEA3PR21MB5743namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Madhukar,

I suggest caching the result of hn_rndis_query_hwcaps(), as suggested by St=
ephen. This can be done inside PMD. Do you want me to submit a patch?

For querying link status, the lock should be implemented inside hn_rndis_ex=
ec1(). The drawback is that this function can potentially wait for up to 60=
 seconds on response from host, maybe not suitable for spinlock in producti=
on use. But I think it's better to have application retry on BUSY (with som=
e delay logic), as the netvsc is designed in this way since introduced.

Thanks,
Long



From: madhukar mythri <madhukar.mythri@gmail.com>
Sent: Saturday, December 20, 2025 9:37 PM
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: Long Li <longli@microsoft.com>; dev@dpdk.org; Madhuker Mythri <madhuker=
.mythri@oracle.com>
Subject: Re: [EXTERNAL] [PATCH] net/netvsc: Fix on race condition of multip=
le commands

You don't often get email from madhukar.mythri@gmail.com<mailto:madhukar.my=
thri@gmail.com>. Learn why this is important<https://aka.ms/LearnAboutSende=
rIdentification>
Hi Li and Stephen,

We have a common DPDK application for all the PMD's, in which we are seeing=
 issue for this Netvsc PMD only.
I mean, for KVM hypervisor with Intel or Mellanox NICs we did not see such =
sync issues. Also, with failsafe PMD on hyper-v did not seen such sync issu=
es.

So, i thought this would be better to fix at PMD level using spinlock.

@Stephen Hemminger<mailto:stephen@networkplumber.org> , yes we can store th=
e device info get details after probe and reuse it later.
For Link-status get with multiple threads we can go with retry mechanism.

However, w.r.t all other PMD's this device info get and Link-status get has=
 issues in multi threaded application.

Regards,
Madhuker.

On Sat, 20 Dec, 2025, 23:55 Stephen Hemminger, <stephen@networkplumber.org<=
mailto:stephen@networkplumber.org>> wrote:
On Fri, 19 Dec 2025 17:35:33 +0000
Long Li <longli@microsoft.com<mailto:longli@microsoft.com>> wrote:

> > When multiple processes issue command requests(like: device info get an=
d
> > link-status) at same-time, then we could see the command request failur=
es,
> > due to race-condition of common function execution.
>
> Hi Madhuker,
>
> I'm not sure if we should use a lock in the driver for this. It's not cle=
ar in DPDK documents but in general the calls to query device status are no=
t thread safe.
>
> Is it possible that the application uses a lock to sync calling to this?
>

I do not know of any restrictions about threads calling query operations.

For info_get() the transaction is in rndis_get_offload().
There are couple of ways to handle this better. One would to do
the query during probe and remember the result. The hypervisor is
not going to change supported offload. The other and simpler way
would be to just have hardcoded offload values. The code for query
got compute offloads is inherited for BSD and unless someone was trying
to run on Windows 2012 or earlier version of Hyper-V it would never change.

Link status is a little more complex. Does the hyper-visor ever report
that the software path is down? And reading through the hn_rdis_exec code
it looks like if multiple operations are in process the second one
should return -EBUSY. Application could retry in that case.

--_000_EA3PR21MB5743C76495BAA587CAA14C0DCEBDAEA3PR21MB5743namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" xmlns:w=3D"urn:sc=
hemas-microsoft-com:office:word" xmlns:m=3D"http://schemas.microsoft.com/of=
fice/2004/12/omml" xmlns=3D"http://www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:Aptos;}
@font-face
	{font-family:"Segoe UI";
	panose-1:2 11 5 2 4 2 4 2 2 3;}
@font-face
	{font-family:"\@DengXian";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:12.0pt;
	font-family:"Aptos",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
span.EmailStyle19
	{mso-style-type:personal-reply;
	font-family:"Aptos",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;
	mso-ligatures:none;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style>
</head>
<body lang=3D"EN-US" link=3D"blue" vlink=3D"purple" style=3D"word-wrap:brea=
k-word">
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Hi Madhukar,<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I suggest caching the result of hn_rndis_query_hwcap=
s(), as suggested by Stephen. This can be done inside PMD. Do you want me t=
o submit a patch?<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">For querying link status, the lock should be impleme=
nted inside hn_rndis_exec1(). The drawback is that this function can potent=
ially wait for up to 60 seconds on response from host, maybe not suitable f=
or spinlock in production use. But
 I think it&#8217;s better to have application retry on BUSY (with some del=
ay logic), as the netvsc is designed in this way since introduced.<o:p></o:=
p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thanks,<o:p></o:p></p>
<p class=3D"MsoNormal">Long<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div style=3D"border:none;border-left:solid blue 1.5pt;padding:0in 0in 0in =
4.0pt">
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b><span style=3D"font-size:11.0pt;font-family:&quot=
;Calibri&quot;,sans-serif">From:</span></b><span style=3D"font-size:11.0pt;=
font-family:&quot;Calibri&quot;,sans-serif"> madhukar mythri &lt;madhukar.m=
ythri@gmail.com&gt;
<br>
<b>Sent:</b> Saturday, December 20, 2025 9:37 PM<br>
<b>To:</b> Stephen Hemminger &lt;stephen@networkplumber.org&gt;<br>
<b>Cc:</b> Long Li &lt;longli@microsoft.com&gt;; dev@dpdk.org; Madhuker Myt=
hri &lt;madhuker.mythri@oracle.com&gt;<br>
<b>Subject:</b> Re: [EXTERNAL] [PATCH] net/netvsc: Fix on race condition of=
 multiple commands<o:p></o:p></span></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<table class=3D"MsoNormalTable" border=3D"0" cellspacing=3D"0" cellpadding=
=3D"0" align=3D"left" width=3D"100%" style=3D"width:100.0%">
<tbody>
<tr>
<td width=3D"0" style=3D"width:.3pt;background:#A6A6A6;padding:5.25pt 1.5pt=
 5.25pt 1.5pt">
</td>
<td width=3D"100%" style=3D"width:100.0%;background:#EAEAEA;padding:5.25pt =
3.75pt 5.25pt 11.25pt;aspect-ratio: revert !important;background:revert !im=
portant;block-size: revert !important;border:revert !important;bottom: reve=
rt !important;color:revert !important;color-scheme: revert !important;conte=
nt-visibility: revert !important;cursor:revert !important;direction:revert =
!important;display:revert !important;font-size:revert !important;height:rev=
ert !important;hyphens: revert !important;letter-spacing:revert !important;=
line-height:revert !important;margin:revert !important;opacity: revert !imp=
ortant;order: revert !important;outline: revert !important;overflow:revert =
!important;padding:revert !important;position:revert !important;resize: rev=
ert !important;rotate: revert !important;scale: revert !important;tab-size:=
 revert !important;table-layout:revert !important;text-align:revert !import=
ant;text-indent:revert !important;text-orientation: revert !important;text-=
overflow: revert !important;text-shadow:revert !important;text-transform:re=
vert !important;text-wrap: revert !important;top:revert !important;transiti=
on: revert !important;user-select: revert !important;vertical-align:revert =
!important;visibility:revert !important;white-space:revert !important;width=
:revert !important;word-break:revert !important;word-spacing:revert !import=
ant;writing-mode:revert !important;zoom: revert !important">
<div>
<p class=3D"MsoNormal" style=3D"mso-element:frame;mso-element-frame-hspace:=
2.25pt;mso-element-wrap:around;mso-element-anchor-vertical:paragraph;mso-el=
ement-anchor-horizontal:column;mso-height-rule:exactly">
<span style=3D"font-size:9.0pt;font-family:&quot;Segoe UI&quot;,sans-serif;=
color:#212121">You don't often get email from
</span><span style=3D"color:black"><a href=3D"mailto:madhukar.mythri@gmail.=
com"><span style=3D"font-size:9.0pt;font-family:&quot;Segoe UI&quot;,sans-s=
erif">madhukar.mythri@gmail.com</span></a></span><span style=3D"font-size:9=
.0pt;font-family:&quot;Segoe UI&quot;,sans-serif;color:#212121">.
</span><span style=3D"color:black"><a href=3D"https://aka.ms/LearnAboutSend=
erIdentification"><span style=3D"font-size:9.0pt;font-family:&quot;Segoe UI=
&quot;,sans-serif">Learn why this is important</span></a></span><span style=
=3D"font-size:9.0pt;font-family:&quot;Segoe UI&quot;,sans-serif;color:#2121=
21">
<o:p></o:p></span></p>
</div>
</td>
<td width=3D"75" style=3D"width:56.25pt;background:#EAEAEA;padding:5.25pt 3=
.75pt 5.25pt 3.75pt;aspect-ratio: revert !important;background:revert !impo=
rtant;block-size: revert !important;border:revert !important;bottom: revert=
 !important;color:revert !important;color-scheme: revert !important;content=
-visibility: revert !important;cursor:revert !important;direction:revert !i=
mportant;display:revert !important;font-size:revert !important;height:rever=
t !important;hyphens: revert !important;letter-spacing:revert !important;li=
ne-height:revert !important;margin:revert !important;opacity: revert !impor=
tant;order: revert !important;outline: revert !important;overflow:revert !i=
mportant;padding:revert !important;position:revert !important;resize: rever=
t !important;rotate: revert !important;scale: revert !important;tab-size: r=
evert !important;table-layout:revert !important;text-align:revert !importan=
t;text-indent:revert !important;text-orientation: revert !important;text-ov=
erflow: revert !important;text-shadow:revert !important;text-transform:reve=
rt !important;text-wrap: revert !important;top:revert !important;transition=
: revert !important;user-select: revert !important;vertical-align:revert !i=
mportant;visibility:revert !important;white-space:revert !important;width:r=
evert !important;word-break:revert !important;word-spacing:revert !importan=
t;writing-mode:revert !important;zoom: revert !important;align: left !impor=
tant">
</td>
</tr>
</tbody>
</table>
<div>
<div>
<p class=3D"MsoNormal">Hi Li and Stephen, <o:p></o:p></p>
<div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
<div>
<p class=3D"MsoNormal">We have a common DPDK application for all the PMD's,=
 in which we are seeing issue for this Netvsc PMD only.<o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal">I mean, for KVM hypervisor with Intel or Mellanox NI=
Cs we did not see such sync issues. Also, with failsafe PMD on hyper-v did =
not seen such sync issues.<o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
<div>
<p class=3D"MsoNormal">So, i thought this would be better to fix at PMD lev=
el using spinlock.<o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
<div>
<p class=3D"MsoNormal"><a href=3D"mailto:stephen@networkplumber.org"><span =
style=3D"color:#1155CC">@Stephen Hemminger</span></a>&nbsp;, yes we can sto=
re the device info get details after probe and reuse it later.<o:p></o:p></=
p>
</div>
<div>
<p class=3D"MsoNormal">For Link-status get with multiple threads we can go =
with retry mechanism.<o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
<div>
<p class=3D"MsoNormal">However, w.r.t all other PMD's this device info get =
and Link-status get has issues in multi threaded application.<o:p></o:p></p=
>
</div>
<div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
<div>
<p class=3D"MsoNormal">Regards,<o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal">Madhuker.<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div>
<p class=3D"MsoNormal">On Sat, 20 Dec, 2025, 23:55 Stephen Hemminger, &lt;<=
a href=3D"mailto:stephen@networkplumber.org">stephen@networkplumber.org</a>=
&gt; wrote:<o:p></o:p></p>
</div>
<blockquote style=3D"border:none;border-left:solid #CCCCCC 1.0pt;padding:0i=
n 0in 0in 6.0pt;margin-left:4.8pt;margin-top:5.0pt;margin-right:0in;margin-=
bottom:5.0pt">
<p class=3D"MsoNormal">On Fri, 19 Dec 2025 17:35:33 +0000<br>
Long Li &lt;<a href=3D"mailto:longli@microsoft.com" target=3D"_blank">longl=
i@microsoft.com</a>&gt; wrote:<br>
<br>
&gt; &gt; When multiple processes issue command requests(like: device info =
get and<br>
&gt; &gt; link-status) at same-time, then we could see the command request =
failures,<br>
&gt; &gt; due to race-condition of common function execution.&nbsp; <br>
&gt; <br>
&gt; Hi Madhuker,<br>
&gt; <br>
&gt; I'm not sure if we should use a lock in the driver for this. It's not =
clear in DPDK documents but in general the calls to query device status are=
 not thread safe.<br>
&gt; <br>
&gt; Is it possible that the application uses a lock to sync calling to thi=
s?<br>
&gt; <br>
<br>
I do not know of any restrictions about threads calling query operations.<b=
r>
<br>
For info_get() the transaction is in rndis_get_offload().<br>
There are couple of ways to handle this better. One would to do<br>
the query during probe and remember the result. The hypervisor is<br>
not going to change supported offload. The other and simpler way<br>
would be to just have hardcoded offload values. The code for query<br>
got compute offloads is inherited for BSD and unless someone was trying<br>
to run on Windows 2012 or earlier version of Hyper-V it would never change.=
<br>
<br>
Link status is a little more complex. Does the hyper-visor ever report<br>
that the software path is down? And reading through the hn_rdis_exec code<b=
r>
it looks like if multiple operations are in process the second one<br>
should return -EBUSY. Application could retry in that case.<o:p></o:p></p>
</blockquote>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_EA3PR21MB5743C76495BAA587CAA14C0DCEBDAEA3PR21MB5743namp_--
