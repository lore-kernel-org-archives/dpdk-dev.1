Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBCC5C369A1
	for <dpdk-dev@archiver.kernel.org>; Tue,  8 Apr 2025 21:55:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 26F8F40608;
	Tue,  8 Apr 2025 23:55:16 +0200 (CEST)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11022083.outbound.protection.outlook.com
 [40.93.200.83]) by mails.dpdk.org (Postfix) with ESMTP id 95382402ED
 for <dev@dpdk.org>; Tue,  8 Apr 2025 23:55:14 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lTz6vffG1/0sz/EU9Y0/lor7xdvYsyWkSNhepuK2j+BPwWR0c5BxRsSegfbqsj2VSxYBgu9YOh1l+UzVn4EwJM14CeBHMQCXEfJielcAmw3p7WtRtfkueFwstajCu7cpVuf0jdw2VsSN/mxKZyemJpFHFLkHJ1PZ7RGU3O6CbSLIyBqyxcF355be/+On3x/hfwX0aMk7C+Rw1psEZSyfNnyCXgGJPOhODEMx4kelocbjtTUNNmmPf0zAnVV/Hh36X2EOABv+aPcz3KP6J0AhQKu53pPVUIt++/veNDFOmLHpy7PnHhBhdtl/sd8RzeV3gAkdRdCzK4mEkYeYbW23CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zNXJPzSUpx82qzNDWmM5FQjpfyJRm+Asa7uXKScpugY=;
 b=drkyC/1Y1dHfXsPl7DnOWx3IA+K+BHIEhiO2iZnT/FUALhnccT+lp+Xec/TvojJwsqWUYzwkKlpvs3EtskorTxH2FOaGwH6YhwKbwNg4Ja27nMLfR65qGAZgFkmAvDRg88qbWDPHNZHpwaIrF3jnPwaZGe+s4LtN8oPptlM663g1r3sG+4eTPR6YCXsigr6oA8N754+J6FP5z8be9ERoVPmBjS3ZPuAGuzXWSMI8/sitUs6b+IslkLo3mcXp+jn4wJECJcOrImXs58hkZMp/ThnkbfSYeJImcsRYaVtGrZNqFvMHWdY9k/VMUeOl+uAASF/oG5CJC8zBOvSnwMX99w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zNXJPzSUpx82qzNDWmM5FQjpfyJRm+Asa7uXKScpugY=;
 b=HlTAV8Bnop+o07PaSyxS0lw57w05DEOx1hDznSQQdg+6uVCoM7e69G73uI+Hw02jNQ0TzIzRVELZSLM/cyQIGZUbbyUN8s8smILKnNgBNhVFkG5Oup0PQf/LTgpdSj0D+2w4EDGUNizGoxRSjK6v8UKcpqNkoQMmhB0mEEIbq0U=
Received: from SA6PR21MB4231.namprd21.prod.outlook.com (2603:10b6:806:412::20)
 by SN7PR21MB3884.namprd21.prod.outlook.com (2603:10b6:806:2e6::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.4; Tue, 8 Apr
 2025 21:55:12 +0000
Received: from SA6PR21MB4231.namprd21.prod.outlook.com
 ([fe80::5c62:d7c6:4531:3aff]) by SA6PR21MB4231.namprd21.prod.outlook.com
 ([fe80::5c62:d7c6:4531:3aff%6]) with mapi id 15.20.8632.011; Tue, 8 Apr 2025
 21:55:12 +0000
From: Long Li <longli@microsoft.com>
To: Stephen Hemminger <stephen@networkplumber.org>, "longli@linuxonhyperv.com"
 <longli@linuxonhyperv.com>
CC: Wei Hu <weh@microsoft.com>, "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [EXTERNAL] Re: [patch v4 6/6] bus/vmbus: set event for channel
 without monitoring support
Thread-Topic: [EXTERNAL] Re: [patch v4 6/6] bus/vmbus: set event for channel
 without monitoring support
Thread-Index: AQHbqJEU1msVCsHhkE2gy1dK3QzJnrOaUJSw
Date: Tue, 8 Apr 2025 21:55:12 +0000
Message-ID: <SA6PR21MB4231ED0D3C3B0D1684CCE0DACEB52@SA6PR21MB4231.namprd21.prod.outlook.com>
References: <1744065904-18455-1-git-send-email-longli@linuxonhyperv.com>
 <1744065904-18455-7-git-send-email-longli@linuxonhyperv.com>
 <20250408071813.680880e7@hermes.local>
In-Reply-To: <20250408071813.680880e7@hermes.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=c049d4ac-2b15-4064-a167-a896a9bf1c86;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-04-08T21:54:52Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA6PR21MB4231:EE_|SN7PR21MB3884:EE_
x-ms-office365-filtering-correlation-id: 803a3284-f585-4dbd-485d-08dd76e8098d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?y4TA5ItoKINNRvpS8+oj3unjnAUzd0aL+02T8RA73OAn4v/1cxno3OB/cr4Q?=
 =?us-ascii?Q?3ifFYxrHnZDs0TnSasppoUQvZUtewzmJtI/NmElnrVh2lPI3ni3Ua84uTACn?=
 =?us-ascii?Q?rwIJiApYcMibTrHQOqrduQBMNz5iHR4+ccm1MwUwuuQ6Ms3/4XtK/yVeNiWk?=
 =?us-ascii?Q?+gNfc5K71MWx0RksurEIhAIkB63ZjDhK/WI+NIWCXREGxWcHWorhdJyrG4L+?=
 =?us-ascii?Q?9Ur2L/XLf3KKa54NyN5oxopa+XEHrMxEPJ7F7xDsVyV4sU6bl5VgeBtFc0qR?=
 =?us-ascii?Q?I8a1rAMRPQeHZ46KzNZNnGHbLunYMhfkhupHGBz7ZZLMmYBNSmWpwY3/C0tW?=
 =?us-ascii?Q?GeDAuzr6RvZt+CISAJVb6OtWlk5Gw6F+9OB6cFB6iQMhD+vTbpA2PiJkhCRF?=
 =?us-ascii?Q?pvmJkZMwlteSHlZWrbxSqXWE4ZKGkBmRMTdOcXRPpKLT5l8YKF2tXdTyNPXJ?=
 =?us-ascii?Q?UEPDnltO3D6nNci2JffB21RcoHIoXjhw0najAUbH7mO89VdlfziLYmaCRpDS?=
 =?us-ascii?Q?uCNKmLOGP+6T3wIbUB49qkNbj8BGdkJhHXQJBxI9XuXeoDqWloeKMowBLoBU?=
 =?us-ascii?Q?WgpQtKcuCdo7xi7+MIxyB+33kcOX4qYs9a38aBrdMZ8+4IviKVkUEdqf7KIu?=
 =?us-ascii?Q?pCvKTU8qVkZzpbXKCz7hEEhAN1RF6W1My9nQTyL9bCg8MdRU9uZwbofuPglt?=
 =?us-ascii?Q?7w4vbXK1HIJwiN1tgvPag0BdFqJBBcLJzvVql5UJ6Bp8hqs86bfgnIkqqscu?=
 =?us-ascii?Q?8AbgXzHFcBvRE3LYcbkmmfK7O6HDr8X1iJ2LhskSPmeVQa8ZYfah4Ovpt8Qd?=
 =?us-ascii?Q?BLOC0sxupDNsRrcT1Yn6oX9Cn2QI8CMvvrJTiS3fKvEFxOELNKYjxava0nBf?=
 =?us-ascii?Q?nCFBiwTe5eHDLdvcvLZvRwNB9Btg9gu8FdhB7tCaVBc4XNYJB4bOepTpLmhr?=
 =?us-ascii?Q?GMqUb8rQOHyOHZeUqp/If24O3k/lFu6sAAD9Cxa6s/pyfqvmw6ktsJeFfQqo?=
 =?us-ascii?Q?6aUFFaI0CCLe1/5anPRM5+q6zmalnRdY33JyKUMrI+zZTxEByQ/sC/vGtA+M?=
 =?us-ascii?Q?YUbjEGe9AfQqxWWCpDzjth9YrKO/r2J5DL7wxrmCUJ191W8AmLoRnJ7ZTbAJ?=
 =?us-ascii?Q?yDP6DnCnmJlBXWtE3TuqLJTx/6LCdefUPCDBxlz75k4nr2YNqGDBWWa5eQWU?=
 =?us-ascii?Q?0qSM+uc9XPREeqRa9Z9Z7SKjzt36F3cIWFOjXgctQXgQW0yJy3yiQjbgWw4Q?=
 =?us-ascii?Q?xlt5enyB0VqSCCRNv10iWbhGKKrOhRGKavzDzYag/lGNXD4WZfqfytidK3VG?=
 =?us-ascii?Q?wTgoo8mxADZiGCBb5uR2+dn1KbmYjCRAnPUJG+PlA7hXECDY10ik/Uxn5nku?=
 =?us-ascii?Q?uKydg9BkYH7J3nSXPsjoJSKK+xqDYrKP6rjngB+QqRrYNSwTeSgYamo30fhi?=
 =?us-ascii?Q?ggUchHi9L++KZkjdWiYbgp4kZhgUSxGh9zHDVrIKFgvnGmwCoA96KaCc8A3F?=
 =?us-ascii?Q?LiccpHEMgbDh3Qs=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA6PR21MB4231.namprd21.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kUCz8v6V9ijfVf8j44PBl6lTa8lNYCAiYPU2uO0iqKob1eW3cPUVnoxkNScW?=
 =?us-ascii?Q?GBAnO06jVXHKEk1Y+K376cAXZbTrLy+pS2Sk4cZfrL4qCKOsIiCG12LcZPgX?=
 =?us-ascii?Q?ZgG88UUukCnHfW++LP/PkWI3gsqcqs7fZ1/hYkDiPD+z1x/G4N7xeACeCztg?=
 =?us-ascii?Q?rZ1veqdXZw1EOs5Fodc1JI0mUmEDu89OHNxhqDa/9bs6WoNcEaZLXx8kjA6z?=
 =?us-ascii?Q?8HEIogd8Las5IZ3zDQQj1XvuOwmWz9thegBZdEq04+xYJ/SmWEMRQpoK31Rm?=
 =?us-ascii?Q?EBC/vCrEj2bpaaWpxfGbRc2hUhIj8k37BPFrirnjW7fIIy13wd0BDw4iQUr3?=
 =?us-ascii?Q?JurIAg1YgDi/t1x3Ex3G82eXUJutgSRObArhD3YvK6nUopA+r6AHW3jc4V04?=
 =?us-ascii?Q?ZEP4LRi59ySfkavqptU/elLBx/Q9jQOITMDt/rOJSKOgX8ztyQMZyzlKbmn8?=
 =?us-ascii?Q?Y8Ki3d6K/8mdtOqTg2HWf6kkLWIJJdB7Tv+pWqosNHT23dK+EFMcjdekWhB3?=
 =?us-ascii?Q?sQskZbBHvlUuSsblGPSAPTI0Ky7ZDKXqLdZ6uQdN4jH4xGrA0BX0ldx90Jz2?=
 =?us-ascii?Q?+EZH0mZZsYI3wJvPQUGFdf8R9hbYcwq22qmPkqvZqXh48NHXjSA3xmheadxb?=
 =?us-ascii?Q?xpghT25e23eAiwkt724a6wfNI2sC4gBaufHv+iW7ITMX/XeFuppbY/ldtXg6?=
 =?us-ascii?Q?oXQ/YDqOdS0ErTTYcq+yHzquwHbuS7rueC8G28CCZauBpuXFVUQwuxQR8Efy?=
 =?us-ascii?Q?D7LxLRMsOV0ty/Z/ERvZ+2GwFgy749SrbO7vZk2GbHDu0C/xHOdKLwssUBEM?=
 =?us-ascii?Q?p0QAFT26AqD5pothGn92ARJvb82GXYgRs9l1aVq6EZzsF8mU8T3/GsAiTMmY?=
 =?us-ascii?Q?J/V6Xp1sSEYctvrnCUXJw2OVhzPOGNzt2K1j9nMll1hrs6y9gBg9lodLeNRe?=
 =?us-ascii?Q?rUOAc34rwyZuYmO9nUfYzhlBCReKJ0Z5GM4zX+i/Tgw5nFjh8CcfoBSeiR4Y?=
 =?us-ascii?Q?jzOEZXLLaS9Cu/pbvR4jZOLMMpQWZfmUW8W6DXa3H/BooEBjJWzUf0ubF67e?=
 =?us-ascii?Q?ttMJTFthJu3ju7QX0XFYb2Lu1i5Gdctq0YZfNb0OBOhyN7ZDeH34oO0/lVKE?=
 =?us-ascii?Q?CuwxoRQIL6m4UzJ7Spp40eHw2IUZ96fO5nTwbzL/EKAqFBUTz/gfcPO4q6MM?=
 =?us-ascii?Q?SRX3gaXjQRPrx9IGa8i8aYCttUK+5G+WPac4rmEi7Ar6sQz5M3RzZt2aw0Xw?=
 =?us-ascii?Q?J36dLDSKtcRvRUJeOuDZmpsnkhcRbgPzegPhkcJdJddrrOArpud+DP6J6SWp?=
 =?us-ascii?Q?fJJmjLvbpOMaEVNbkf2jK4WU0644A+scudquKLETo4JLaZ4fOzHq1NJNCDqZ?=
 =?us-ascii?Q?85smdfbc6L73Jpq7BwbfnV4Lj/dt2d3muKwMuU6d6kHIgsieKkHNGCYy+bF9?=
 =?us-ascii?Q?Dt4SIVM4h8NKbdcWBSx1p4ZmWo7Ls+ffoPRWudLJCWP6Qto8X5rGOyEwDdno?=
 =?us-ascii?Q?NoYNjevLnImw8S8gtjbD+/LfbKspiEa3yo3QpmsIHlyqEnOnrRL97bD/k0M+?=
 =?us-ascii?Q?RaC+IWxjTn6BMUaCts//PBDfDQoFk7jgUD5ozzVp?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA6PR21MB4231.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 803a3284-f585-4dbd-485d-08dd76e8098d
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2025 21:55:12.0806 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U3h2YxNOCGZ6cO3eblDlOjKDKRDqqkUBtRdaU3MBaT0Wb84EOcW09WIMG+vGmKbY+6/P3Rte/tOaCbLVe41bjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR21MB3884
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

> Subject: [EXTERNAL] Re: [patch v4 6/6] bus/vmbus: set event for channel w=
ithout
> monitoring support
>=20
> On Mon,  7 Apr 2025 15:45:04 -0700
> longli@linuxonhyperv.com wrote:
>=20
> > From: Long Li <longli@microsoft.com>
> >
> > For vmbus channels without monitoring support, use kernel UIO
> > interface to indicate packet through interrupt page and UIO file handle=
.
> >
> > Signed-off-by: Long Li <longli@microsoft.com>
>=20
> Something is wrong, no longer applies cleanly.
> $ git am ~/Downloads/bundle-1421-vmbus.mbox
> Applying: net/netvsc: introduce private data for storing vmbus device for
> secondary process
> Applying: net/netvsc: introduce get_vmbus_device to get the vmbus device
> Applying: bus/vmbus: store UIO fd for secondary process
> Applying: bus/vmbus: support channels without monitoring enabled
> Applying: bus/vmbus: add rte_vmbus_device to all functions accessing vmbu=
s
> error: patch failed: drivers/bus/vmbus/vmbus_channel.c:80
> error: drivers/bus/vmbus/vmbus_channel.c: patch does not apply Patch fail=
ed at
> 0005 bus/vmbus: add rte_vmbus_device to all functions accessing vmbus

I rebased the patch to net-next and sent v5.

Thanks,
Long
