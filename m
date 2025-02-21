Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEC6CC021B3
	for <dpdk-dev@archiver.kernel.org>; Fri, 21 Feb 2025 20:31:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AD515410E8;
	Fri, 21 Feb 2025 21:31:52 +0100 (CET)
Received: from CY4PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11020130.outbound.protection.outlook.com
 [40.93.198.130]) by mails.dpdk.org (Postfix) with ESMTP id 3314B410E6
 for <dev@dpdk.org>; Fri, 21 Feb 2025 21:31:51 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xJ/YAaMVfT10tajXT04lg64ThOBaI2cUauzI9OoPBPPpvux144jPOYLq+ssw2tqsusnSz1wxw9IpnFCO1WVM3KnenVcsrTFq8Hq5JGsly8w2Cj0yp2cztoOwBsfvreoe1PGV9yeQHky+bLdqT9AWXsoCYLl1VdekE+FNCA5ea8yY/1mh8BYebZH3PLj+5RjCz3/f2elqrCuMv4RGxUGyFXpLzCp63qQZic8cuKFcz9S6TbRBP934EQc35HxMATDMb62fmoYLk8gmtJkqN+gHUb/g5+T2orTwKXOUERz2I/9q7H54YIe0Flrmq2os2h1x5qTHlY6a1+m7+x8dQfxotw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VuvfBaWa4jn0aC9VaDqVBZVWVGtkR8kSVfN7/MshKT0=;
 b=KYfk1Vuctslgxca2uTvRKuuSpX9fPjY8Q/gtgYl0RHWAe6QuaI/4CrkffV/4qQPnURxv2+wSk7gda5VzoET89mYGkHOXiOADuGn2cNUKzlhSZbWGqmSUDJ6MfOimoVFoqmH7Nsph/8xx7aLYMMUkpvj/A0DZTTiDpIvKLWfFeuXPN/rl+KqWm28fCWrFQ7rhLNv3j+tykQ17sJfV9+8dIR3U/NEgPGToENeV3jY27eVtsLWYG2rG6dntwH39pFw7SZELth1YMPKRJBz+FW4356d4fJTspARqTyZ4ky1nbI5GoWc9j9UZiz5ApMib3rnSW295rade75p4obFNdcpFWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VuvfBaWa4jn0aC9VaDqVBZVWVGtkR8kSVfN7/MshKT0=;
 b=aif/jnt+20uPy1ENFxbOydvS/EVfkEi2RpicL+9IJF4eA9X2IhOkjHJu63sg1kf6AoYKEuXpjtO9xVZ14em3rCb77NVKgkKaKM1tgeDMX2KKjQwGvvNDER7TJNO2szYF/U4s4DNAjnXQqrRBaWDX3nl8RlGkrC0jRczDdY3X6iY=
Received: from SA6PR21MB4231.namprd21.prod.outlook.com (2603:10b6:806:412::20)
 by SA1PR21MB2067.namprd21.prod.outlook.com (2603:10b6:806:1c2::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.9; Fri, 21 Feb
 2025 20:31:48 +0000
Received: from SA6PR21MB4231.namprd21.prod.outlook.com
 ([fe80::5c62:d7c6:4531:3aff]) by SA6PR21MB4231.namprd21.prod.outlook.com
 ([fe80::5c62:d7c6:4531:3aff%4]) with mapi id 15.20.8489.010; Fri, 21 Feb 2025
 20:31:48 +0000
From: Long Li <longli@microsoft.com>
To: Stephen Hemminger <stephen@networkplumber.org>, "longli@linuxonhyperv.com"
 <longli@linuxonhyperv.com>
CC: Wei Hu <weh@microsoft.com>, "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [EXTERNAL] Re: [Patch v3] net/mana: use mana_local_data for
 tracking usage data for primary process
Thread-Topic: [EXTERNAL] Re: [Patch v3] net/mana: use mana_local_data for
 tracking usage data for primary process
Thread-Index: AQHbhJzH55STPovgMkOCG5ZWEZXKhrNSMLYw
Date: Fri, 21 Feb 2025 20:31:48 +0000
Message-ID: <SA6PR21MB42311170DC4057B9D20C6427CEC72@SA6PR21MB4231.namprd21.prod.outlook.com>
References: <1740094322-10919-1-git-send-email-longli@linuxonhyperv.com>
 <20250221121114.41e3e8d8@hermes.local>
In-Reply-To: <20250221121114.41e3e8d8@hermes.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=478e0fc8-6962-4da7-9a36-d4be66b7dc8d;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-02-21T20:12:45Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA6PR21MB4231:EE_|SA1PR21MB2067:EE_
x-ms-office365-filtering-correlation-id: 8a7c753f-4837-463f-7e63-08dd52b6c434
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|10070799003|1800799024|366016|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?w8JYuSsOXONWORgiqOMz7RnzT+JR3Wph/M/Lb8pOfxeFkgNlw0LuVs6B12XK?=
 =?us-ascii?Q?Yc8DI0pLv0KxccyTYF3lOeOLR4XpbeUbPS48OX5FVTzKDvruj55rHUbDjqGi?=
 =?us-ascii?Q?KscwPeuYCbufz+CkpGrmBOzrv4RASZAaEj9Gq2Ps0XW2bLKvnoUucFShWHBn?=
 =?us-ascii?Q?bBB4da0NuWQ4Qn/QyrJgMzjN2ZZ104RaduB5fTwzyjqh4T7BXXTeBeC0pmzR?=
 =?us-ascii?Q?bTnhaBnxPWSo+4ewndY5EJMjDR+F4yatuOIOWcxf3731QxTzlhqm1+Yr6cKD?=
 =?us-ascii?Q?XP65vqxFRm4i5slgzCK521CJYcvHHW4pGrrpV+97fV2+ODvDKmIyZNly+wRP?=
 =?us-ascii?Q?omHHFA0U/wo6U2FpdtGaXNONS0NQW7Gk7s66yiRCy1Q0xOesdYrzFz9lBRvp?=
 =?us-ascii?Q?ySOmcRsqMwuTnwH52aw6MiAJakHQqj8Qv025q0jf4k88H/svOFUoWOQekN+T?=
 =?us-ascii?Q?T6VSRFeoqfN0/LXLw/uwEYG5l/wlEoUGfSQkG36pVnz3+w9kTSpfZzBIfuL6?=
 =?us-ascii?Q?BYjYiKj6n3BGWnrZxA9UBDLvaMHSNKLvI39OdPg3QsaNSq7T2B5RN2H94dAj?=
 =?us-ascii?Q?Wubbqm2RVtETbjb3JDYjvCRn/2E0rdSGyECPSnId5Rp3olRPJapyHJiA4653?=
 =?us-ascii?Q?x5qzXJ6GtxZXmzObDQonrXTSyTYKMw2kSe7CeoTRyc0Ji6dKECqlOdnkgxN4?=
 =?us-ascii?Q?ezK7aLrA9HrMw8GOjZHpsKvj1oBeR06/VXQnhF6kIoQdS0nHyHzR+2ZcpxwU?=
 =?us-ascii?Q?1dwjIIQAnCTFJZoDQveF1/hNCOE6JzO0DaznaZ0pqyiuMb13YGGzpB+4eEtU?=
 =?us-ascii?Q?0QLbgAN8XTj7Fbt9F6FCgWAUFkuCBcVTxuRWO3OjaVSkNNH5KdZ/hSFPdl6r?=
 =?us-ascii?Q?SSUAqUxVHeeJfSSY2npOMz7Hq8nrKCHG1uyUtz2sF8OjaDIt5STsnFivv4o4?=
 =?us-ascii?Q?0FnK4xDWWyaFnAaBPDlNeSymFY0ykCc1Jv2F6gJk6JgGivNoeoFEPTk0fjJe?=
 =?us-ascii?Q?AkyRWgrCYfA6gPKmp25j91mox+KyzjDDk6R2Ijt+ZVBVWYp/sF4+oLFtg7XK?=
 =?us-ascii?Q?gKKGXb2bt+A7c9a/K+PLUpDVno/Rvj5h1vxu5T/7pu/EfJiMon/iE6QmfloF?=
 =?us-ascii?Q?U6rFTP4sH8gVgqIaFzB7IRKh7e8Ces7VL7K2NxeQo2MEr9ot5Ps/p8QNfPnQ?=
 =?us-ascii?Q?1TJR7BcbxHhzz88JSkppbAw26dcsQmuV0YxTk7g/FdUVIzqP/Rxumdw6+s7U?=
 =?us-ascii?Q?FfR+MgAYZsiVXGhHBRE+yD3JVxS58/+rjpuSRWzTZN++u53t2et0ftiKNsc/?=
 =?us-ascii?Q?2JqSgxehHRPQSTAyF37QBtAN3gOzUdIhV5TnwNgwii0Rdz4HAU2KzNA/PdFI?=
 =?us-ascii?Q?pl+0NYawaPkcS42ZYhe8UbuxZXgLLINmfpxRuSDgSHpIXhgCbB0FHDi1GcEg?=
 =?us-ascii?Q?f3tnP3tUQz131lZQTSzAClVrb0xOEira?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA6PR21MB4231.namprd21.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(10070799003)(1800799024)(366016)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?PaKVK0ca93UEElp0Lc73Pr8mN4tAAb4whV9OHal3F14amoMAYrQiiXrvLs7b?=
 =?us-ascii?Q?y9VRtI8yKTQ6O2cyVg7/3rhx77IoUlTDjRHngG9QwUJxvEYmazURoWOumnUz?=
 =?us-ascii?Q?+gPD/7I7gv/jlhHjzsi0s/2F88QHwS+4SpiMzI7FYzZz5z3yTNcZN1ZKGXWn?=
 =?us-ascii?Q?lTxMwrfIq5Fry9O3cBmrsdXL016ouZjH5xZXQmgBzE4Uaw/xtYcQfUCv+RgU?=
 =?us-ascii?Q?1HTrVndnp+o8vNQr0NiVde7XoVYMA5c87rtuVSdheT3DbWp5fJy4RiWxLqul?=
 =?us-ascii?Q?/DOJekLqkbdG6drj4nh+WDVWyfwUch+R0gyotsfkFVdrCNcJ+4LpWtarjeM0?=
 =?us-ascii?Q?MrAw7gEF3cPA0oTpkv4UdQrhtB9OsRfORZoSh8h4IfPReexIk1fqPLqvbTZm?=
 =?us-ascii?Q?HidphCsA/cZ3HDFwOoCti9Y0FStPQULf+UOBIhRXgj08AeVgD7IHB9ayisJe?=
 =?us-ascii?Q?YaVhTcTZKPbHXn/zSgFJPEuf/jyGKiyRCfa01AkFAWUeBGVxPrTWxz6Nd/4X?=
 =?us-ascii?Q?S4ikCMHBPAjrvSOxg88/tUM/gH1kZFZwDdvxew1scOx4jR+9HRS0F9k1As3X?=
 =?us-ascii?Q?UUOVXjohiQllKAkAFyBRLu3UkI+rRllnY2MqGU7qQWVE8TUfwr+uOwcG++ea?=
 =?us-ascii?Q?BYNyCRElYc2tjOydc77ZL9ZwgyFtAjzem/qJTFeRfqQJ/CT58awJmv2VsMnM?=
 =?us-ascii?Q?BrZh2goyEOvSDW7QkyKXpeJhG5VO5iiu49nYFlj+/5uodb4NoAjPqzyLWGFD?=
 =?us-ascii?Q?DSf1jwquXvCmK9RZJzVX7Uk1FDpAU5oLPz1cGZpag2XtjTSjlQ9JeDiF0ARU?=
 =?us-ascii?Q?ZPsNAqVnuOsRGE4K+K4Ks4PZdBuQTi0A//t/W3MZsj/U9CQy6IN7jN2Urmfe?=
 =?us-ascii?Q?71XeWsEmrJ83QQNeJtP2X7hqQpPEMaqnYZLL1GSE8U/h1wKMFkWPVLhpSkZJ?=
 =?us-ascii?Q?PNGJJuDHXZ5OTrUl7K1qlg4VzQJbWRAOtYcWzOprHyutO/HRfLnHNdWjQETc?=
 =?us-ascii?Q?7lb5v35jE9h7dekUHSo1QLOMOY3eeLs8Mm0XQn/HrOCiqLDlPgLS3S7vzPiW?=
 =?us-ascii?Q?45+4+v8bpV+PPSaBizd4ZXEjM37hgkp3hlgcNp1YbKCjJz8up7TX6AYUVPSL?=
 =?us-ascii?Q?Hgqg+czOlBbb/L32T6Fa7OiAYn585S1Ce+E1L/+Zw+iK3n+AxC0CFUyKJLkn?=
 =?us-ascii?Q?55w8b3c2t3DRHObINuMGdfWVX/2jmaoIVu6vAyxQ7uySSjvdlTB5xawqIOjv?=
 =?us-ascii?Q?3YEUCr/Phy16ybRj62swCxppLD20c9CoF2mMWhlvsvdStf0nowocY8Qr01aM?=
 =?us-ascii?Q?B6GbZ2nc5//TMoaajeL8UA86692pMSzlczsdL3ZZq93J+48WLOHD2y5952F9?=
 =?us-ascii?Q?zeJP8Holg2rmDc69hPVh2Edx/g4K0sr0RjkvNHiD+DJjwrSkZZal3gVwmy8R?=
 =?us-ascii?Q?M+DaFh2sF3dD91tPG8sNYRniwMh/eKsvT70OdEOjqPfclfkIf1rwuu8Mhc/U?=
 =?us-ascii?Q?cjdmlWkcmNjGv3P1eSh7QfR4d6xN5iFEbBr0uZpCJfu6ntGDOlsD33KfU+Oi?=
 =?us-ascii?Q?8YkSCKMg4YkOQLpsC+Sx3rr86J7AzW9CGYrZRSw/PF9z0sJY2DVOEokv4cEv?=
 =?us-ascii?Q?Khtbalifg0il7JqnacjvJCgIVvhKykFDptW18v469mIY?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA6PR21MB4231.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a7c753f-4837-463f-7e63-08dd52b6c434
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2025 20:31:48.5161 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LUqb9AfQXzIQkNOy61VtWgIQ+okqHTQJ1F7Zz77B+lmHZi+OP41uGV1ApUsPyIKwLts7gDVsSEUGSp4/fjVkbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR21MB2067
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

> Subject: [EXTERNAL] Re: [Patch v3] net/mana: use mana_local_data for trac=
king
> usage data for primary process
>=20
> On Thu, 20 Feb 2025 15:32:02 -0800
> longli@linuxonhyperv.com wrote:
>=20
> > From: Long Li <longli@microsoft.com>
> >
> > The driver uses mana_shared_data for tracking usage count for primary
> > process. This is not correct as the mana_shared_data is allocated by
> > the primary and is meant to track usage of secondary process by the
> > primary process. And it creates a race condition when the device is
> > removed because the counter is no longer available if this shared
> > memory is freed.
> >
> > Move the usage count tracking to mana_local_data and fix the race
> > condition in mana_pci_remove().
> >
> > Fixes: 517ed6e2d590 ("net/mana: add basic driver with build
> > environment")
> > Signed-off-by: Long Li <longli@microsoft.com>
>=20
> Ok, mind if I break the long lines when merging?

Yes, please do.

Sorry I didn't catch this earlier. Will do next time.

Long
