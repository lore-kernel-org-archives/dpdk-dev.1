Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41884C369AB
	for <dpdk-dev@archiver.kernel.org>; Mon, 21 Apr 2025 15:33:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4A0F4402A9;
	Mon, 21 Apr 2025 17:33:20 +0200 (CEST)
Received: from SEYPR02CU001.outbound.protection.outlook.com
 (mail-koreacentralazon11023075.outbound.protection.outlook.com
 [40.107.44.75]) by mails.dpdk.org (Postfix) with ESMTP id 4E81940299
 for <dev@dpdk.org>; Mon, 21 Apr 2025 17:33:18 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v0afnuDAXBpRHNIDoxjHELudumoSU5yN0vlYI7vkb8ndMNzrLX71Ij6qr9lvsgGRZjO0cbpZAbOi5jA0ZUf8c/hI/LDGeB4LSrL5rh5SdcWJkZtbgb0pGR4eQ2CpWNgDMzRRKsCS/woGrrwEA8Jeg8BU1ujPes8ctQ0xHbV2hpGhXBz7dHmcWIeOrQ3RWco5ZOR8fyo7MvhEz4YKgIIWwW12zLojbZtYauNU8FvhXkwz6wJN6Wx4Ecni05RTcNMFCy7Du6TrcJvVUwleDY3QCvbNxcuz3MgEkHXMRRWXKpTmf3V1djOFLb2XVq3obj4vJKaskD/Rcya0HlKTGsL37g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rr6a0FOY/elwYu7VgUCwt4l+EbdY0VC7KxB8aZRtS80=;
 b=qypri1lKL1Zw7vZbC0e5aF9+rpKKDk4rU6+eYRr7uvhvnsB485nRbWEN3plh5HbiTo67aoRJUpjGnDuU3iLC4kK+XoETb3w1Q4jbvPOSQSCOU4GRCJGXkY9RT10oPCuUxc9Fnn7527xsXhUuS41l56XuOpTeHN88QVRPprUZGFcNMXjbhKrGWuOxsgwVio53jUrBs8GzdtCTOZIZ396gF476VM8xNT03vIXNgE8IVptpKW2rJ56mR/UyU43g33Mo7E8U3Kqhf6Zq3dNkoeutt8ygaVUaT4l+NllbwW6ffzcNM3A7vdaZxW5w9Iw37ziGCQ/z5VeOVY698c2KqoLz8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rr6a0FOY/elwYu7VgUCwt4l+EbdY0VC7KxB8aZRtS80=;
 b=fIDmwdP00oUHUVZKAtQlvbBA3Vz0pkQIJWX7ssqM0GmhDwAUvEbJm2VE0xisA58eGcmJuobS0Y4T+V5KxZ82QZdsuwoudNfm4zL0SsuGmNUcR+4PEmr6wqNKPDDDhtf5eeWC+vVx2c43gk13SEQJbcKo+/SaMKahBn5cwUUdiMg=
Received: from OSQP153MB1307.APCP153.PROD.OUTLOOK.COM (2603:1096:604:373::18)
 by KUYP153MB1211.APCP153.PROD.OUTLOOK.COM (2603:1096:d10:10::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.5; Mon, 21 Apr
 2025 15:33:13 +0000
Received: from OSQP153MB1307.APCP153.PROD.OUTLOOK.COM
 ([fe80::b5b4:898a:d979:93e9]) by OSQP153MB1307.APCP153.PROD.OUTLOOK.COM
 ([fe80::b5b4:898a:d979:93e9%4]) with mapi id 15.20.8678.011; Mon, 21 Apr 2025
 15:33:13 +0000
From: Wei Hu <weh@microsoft.com>
To: "longli@linuxonhyperv.com" <longli@linuxonhyperv.com>, Stephen Hemminger
 <stephen@networkplumber.org>
CC: "dev@dpdk.org" <dev@dpdk.org>, Long Li <longli@microsoft.com>
Subject: RE: [EXTERNAL] [PATCH 0/4] Fix incorrect page size and address
 caclulations on systems with 64k (or other) page sizes
Thread-Topic: [EXTERNAL] [PATCH 0/4] Fix incorrect page size and address
 caclulations on systems with 64k (or other) page sizes
Thread-Index: AQHbsJi21vghLNaM2kW7NdmGODESZrOuQ/pw
Date: Mon, 21 Apr 2025 15:33:13 +0000
Message-ID: <OSQP153MB130713AD706A5973530891D6BBB82@OSQP153MB1307.APCP153.PROD.OUTLOOK.COM>
References: <1745004770-9795-1-git-send-email-longli@linuxonhyperv.com>
In-Reply-To: <1745004770-9795-1-git-send-email-longli@linuxonhyperv.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=70ad5247-988b-4424-bd1f-d9032bc0d23c;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-04-21T15:32:26Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSQP153MB1307:EE_|KUYP153MB1211:EE_
x-ms-office365-filtering-correlation-id: 233eebc8-d26a-4936-797f-08dd80e9d484
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|10070799003|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?f+WlqYd1Fq1bK469vqHNBQkceaODVPirbbcIqTk45GZIMd6fyq6ZQmfKQJwi?=
 =?us-ascii?Q?VW+IbzVDyZYijxgKBZKLVqOkTAadPRAw3c45abXVtn6Ts1CaKJuvDmqVlF9W?=
 =?us-ascii?Q?IAIE2SEY50WGYZNSiM4dVnIY+mSuFCCVdCYSzz8C5EWzD+9H4pfMyhHkaitP?=
 =?us-ascii?Q?fTnd8Uy2/3T6f5T65UABVo7knVtXkNvpK94UATsNJXcDPEyY5Ka0UOZF7gl+?=
 =?us-ascii?Q?pqDmzs0LDlV6kiMLUz/0H/Mf8A0pGZaQGB+w9qpcGZ2x3s3Ql5t7903lQi2V?=
 =?us-ascii?Q?E1E+jWgMfHOIDab8E60/4NvZX9Vt3if0wTRGI3wf28tLMiYIHGPcQv7nbGKh?=
 =?us-ascii?Q?D84N0tM/66r71EroRPgNi5qSKwsuE2FHJcB+/CAKmJuEfTJogZ5gqgtSMPOc?=
 =?us-ascii?Q?h+JN2L0Jg+gbBjK4ERX7qPWoKmGIWxUAUqQLiwhiigxvpdqwhmYWZhRZnzjs?=
 =?us-ascii?Q?oH3fFbvJVkjTVTy9eDjfN8j1W2Pd8lBddyhvu5NkVGfflLLtYaazv2K/E8LX?=
 =?us-ascii?Q?k4sVTt5tLYpHi143Cw5XE26JEuOADasMol5TlLYUmTH14kZHMvgj4hLt4n8C?=
 =?us-ascii?Q?f0DyrxKGvCsoYe5lPRLUDBQdtdHhP1O0b//F1EIEFY5z6K+GeVeQMdvtIxM3?=
 =?us-ascii?Q?XwduAn554uYujrx3VfMnd2ZpCTpx+I2iFAF8MhJPK2bqdoBVVBycpi0r4FlR?=
 =?us-ascii?Q?NezY0i59oA8K6MzludZKBoGJCdnXfKHFBg7BuprdgtGoRD/WsmDjj6r8G125?=
 =?us-ascii?Q?npOBDWMq7WHCderqlfzji7DK6NZ7/7itHIy/Pk8rJcKZmYV4TNwGnLCJ6hiq?=
 =?us-ascii?Q?P5wFjiEeL09eWGJO5H6Zry8/Z3EK9FXc0vofhb/rAFdXr2RKCI+nsZ8NjllL?=
 =?us-ascii?Q?VWZTiZd3NOOx3ea1my0++EP58AEJPjWFKpExZLhUEP3jSblW9OFx7N1pma8C?=
 =?us-ascii?Q?8dWqmSBMJwImKstNfB3EjHWfdUYmdIxgz70akiaIjOP8cMMgyf3XmxOfPowB?=
 =?us-ascii?Q?7PpLbaGwxeUyRq9/FGLvCaO6n2+vk8I2bVhcNm6W/2ukOMRWEB4az608IxcS?=
 =?us-ascii?Q?jChGO4lRSY+G/LdvSpjv2PT/lhv/v5gfM9w9ZJtdY5jGgrXFboTgXfwy8Jp1?=
 =?us-ascii?Q?TYVn3FR/lC8HlwWFlYxAScfb9Sc3BwFkBMkA0LiLH2AZ1vsuKLu+y5trpqy/?=
 =?us-ascii?Q?VHeXYSg5lNK7q9I0khJ/5W+VEpI4Gj4Y2vHBdmRGl0MuZ2Ywi8Jer/HprRHT?=
 =?us-ascii?Q?0RXANzp2ReM5TaaXOG6zVV6qWvB7bi5y3Lq3K2ZlWp93T5bc547QvOkrPGRo?=
 =?us-ascii?Q?tf07uQA9jiW3NU3ICEDhdd523gnfp9BUmousFiVfz/956XY0Jn6pZyRn9coQ?=
 =?us-ascii?Q?Nv8krfD+PHdg243ode51k4Us+dkss67/+UnFBMLL4wcAYkfYqRyEvstsaqRm?=
 =?us-ascii?Q?hiAr3Fe7A+/xtOMsGgC4KY8llW7THuFlOZJG1Nx6Jah41b0PRNEftg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OSQP153MB1307.APCP153.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(10070799003)(38070700018)(7053199007);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?FVhBYP8I3Ta6DywSWAEB34UgsiC2D2LILs+k1ffKAZxWcQprHhOTdLhn230r?=
 =?us-ascii?Q?57Nk9g77aDrBkQJcSlJWIO0D14nUQOAuirHZSrfROjN/HhEvDN/1v3O9ncQM?=
 =?us-ascii?Q?jsUAgQrrlPdWSqtDnq5Q2w9mN2WVMO5SrONudvqGT0PBgVfgFy7xrJQh8zll?=
 =?us-ascii?Q?P/TSAeo3dADOhQYMW0ZXDtCE756IXuxYQUYkumrRFtW41ezA7TEE5VPjRoPP?=
 =?us-ascii?Q?b4A6mashWg8X1OAzWL3o6i2Qf0zCY2r1lRJ+NHfWk/2TfL1kS/GtmUf1HQL5?=
 =?us-ascii?Q?H6nC/SjdtYJGSNTF+JVpV517++uX+kCcpmCPyYDB6a4r3f6tAkwOTEO1qwvC?=
 =?us-ascii?Q?P4k4hQqsOdNExsBaJIxGl1+XfE+8mVw1KIUBNIZnrGnh3y7cIt5d5vJJ5Hcu?=
 =?us-ascii?Q?EKG7hEHjSbfK9ey3moaJdPnr7WpfGz7zn+WpKWxxrHiXvj6XtY+Yj4jwV6JR?=
 =?us-ascii?Q?Jm3vbJlppZSWXiLLaJ1P/Kq1MJFV98RDT7/RRc6U5zyJWZvOHo4tQPKjDrN7?=
 =?us-ascii?Q?G+VfnBAGkrIqbIAeF48Of6TcUiR/XyMyiygw7ETLEhrQb78h+oLSa2WnaHQt?=
 =?us-ascii?Q?8SicCFJFQDkr+3Qx3PCfrlZxOWdbwOK2UgGzCXqid0y0WwBUseZMsN2VOeAL?=
 =?us-ascii?Q?IC+N7pJjfcVI9tPfibwE98hWkCh46HxlkP/oY64WJ5TcwenGEzxQZRMEcjMd?=
 =?us-ascii?Q?PsbH9HJaRkBPotTANnmW3ak6TX3RUK0LlcHOokWIzr7oHkEZflISPzf41ttw?=
 =?us-ascii?Q?QUSCqzYFOWc5RmQUT4OYjx9CUQQO2DDG23OeAOLOI7HvqPxv4OxDJ7d9W0MF?=
 =?us-ascii?Q?1TVwt7qqKnmFgDP97Ybz1XL62fwmu9lOWjHXGw3R/SeQw3PBfBjD1if9P9xs?=
 =?us-ascii?Q?Gw0kCImK8eE7Z0GJe7qh/17KWdU3T3Ikz0p6bzTZvZuN8aXv0uzsnaznUIv1?=
 =?us-ascii?Q?HAiH6Jem5x3DVSnKy6WBS0idABPDCSjI2uIN6G9DYqbEsGLc7wQ6buTuv//T?=
 =?us-ascii?Q?RKFiCJzpa6N1AlJh0zSlnv00hjf2rLHFkb0+43flupQsJyjqR7TS6BOL5srG?=
 =?us-ascii?Q?GMWFCOD652Rov60bsVeJjOwDghGVewN3HPKh6Ktrv2cJhuzOK7sXOf+OsPGQ?=
 =?us-ascii?Q?wRVz0iE9zViCkyi0IFnlesSLtdnGaiIacAyZcA3rVLXJdpP6GNDchHllVNcT?=
 =?us-ascii?Q?gHhpP4pxD29oO5GWkAn5X/4kDsmjEJpk0SAWIgmiwWNcClyhO5jMAiIwq+3z?=
 =?us-ascii?Q?02FDp4YgPGpzBY+QMdhvxL2kg8T553kOSswpC57rSa0eDjMT1C+mK/kubB9I?=
 =?us-ascii?Q?pIshgWSl70ROTsXmpl2hMe/nTT1Vvqz/cTFVHT6VCLkbkUJckqKEYo9xVj1w?=
 =?us-ascii?Q?MGRO145nw7QvaFZfoSVNYeXj0TrbUWywLU/RaYbT6Qt38NF/GsDRx0dcuflr?=
 =?us-ascii?Q?/lz0S8/ru6/asB7DLZTklOoxJpMxkOEc0fnvcxK+HX+GuRp1Y1hSD8jXe8jS?=
 =?us-ascii?Q?UFdP+PhBsLlzgb7cZzFk+z02l92Nvz3nlYv10EM3gos5IZLytsCgjz+LxZno?=
 =?us-ascii?Q?5CGqut4HzztUMz1cefjH4ceR0qbaaA3mm/oyXaxWq7ASdo4szqcg/VF8YTY8?=
 =?us-ascii?Q?ICYDxygkOKJ0oeHvuZFw81o=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSQP153MB1307.APCP153.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 233eebc8-d26a-4936-797f-08dd80e9d484
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2025 15:33:13.7593 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fIH10KsIaCXaGbuYdZtj7H+ZraLapmRMjDch6SPzffrks+YZiyHXFfrev2jbgYEpvr1roonXJ5kYSj4un8GVAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUYP153MB1211
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

> From: longli@linuxonhyperv.com <longli@linuxonhyperv.com>
> Sent: Saturday, April 19, 2025 3:33 AM
> To: Stephen Hemminger <stephen@networkplumber.org>; Wei Hu
> <weh@microsoft.com>
> Cc: dev@dpdk.org; Long Li <longli@microsoft.com>
> Subject: [EXTERNAL] [PATCH 0/4] Fix incorrect page size and address
> caclulations on systems with 64k (or other) page sizes
>=20
> From: Long Li <longli@microsoft.com>
>=20
> The Hyper-V uses 4k page size regardless of system page size.
>=20
> This patchset fixes issues while running on systems with page sizes other=
 than
> 4k.
>=20
> Long Li (4):
>   bus/vmbus: Align ring buffer data region to system page boundary
>   bus/vmbus: Define Hyper-V page size
>   bus/vmbus: Use Hyper-V page size for mapping to UIO pages
>   net/netvsc: Use Hyper-V page size for the driver
>=20
>  drivers/bus/vmbus/bus_vmbus_driver.h |  4 ++++
> drivers/bus/vmbus/linux/vmbus_uio.c  |  2 +-
>  drivers/bus/vmbus/rte_vmbus_reg.h    |  9 +++------
>  drivers/bus/vmbus/vmbus_bufring.c    |  9 ++++++---
>  drivers/bus/vmbus/vmbus_common_uio.c |  2 +-
>  drivers/net/netvsc/hn_rndis.c        | 14 +++++++-------
>  drivers/net/netvsc/hn_rxtx.c         | 16 ++++++++--------
>  drivers/net/netvsc/hn_var.h          |  4 ----
>  8 files changed, 30 insertions(+), 30 deletions(-)
>=20
> --
> 2.34.1

Reviewed by: weh@microsoft.com
