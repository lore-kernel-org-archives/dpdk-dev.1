Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1C6AC3600E
	for <dpdk-dev@archiver.kernel.org>; Wed, 26 Mar 2025 21:53:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E498D402C8;
	Wed, 26 Mar 2025 22:53:25 +0100 (CET)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2137.outbound.protection.outlook.com [40.107.244.137])
 by mails.dpdk.org (Postfix) with ESMTP id 281574028F
 for <dev@dpdk.org>; Wed, 26 Mar 2025 22:53:25 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BoD6Zb6DiBxlI6p3V4+J6AGTVWZuT5vHDDhNdQ2zSae7K4u9/Lo3aEkXEIw46yaP98VYqqs7jDTpHzfqSvR4RZtpaqvCiqDFu/wzf8D9k91DxBYtkfu9EYpTc7bhEKSgmvH0qXnOZz4MhcsQNDXKa/ccwS95eKduyFnQumylEKh6q5XW89YDg3ZPu9q7a8RTuHH4ROo5gTuXFFXjFwTBSzueHJ3v/IvN9qQdcG3QNNJl/y9cGNwhHOOR6Q0Yz+GJ3ggDS9PSEEd/UiJr8IZpboyiIb0WMET2hAjVL0PTj1lVeXFVaEhgDUSr8WBXjk1sPScV/vashxjygreI84rpaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ihNWrBMRdAMBWgthgP48Joizm5zshcaYaUOjG5K5HRg=;
 b=jNMC7WnmsM28g1zW+qBxy+5F83mNR0C0hGjHuEi8JLVjDtjVDSxp/o4S3zfhOo5uAGsPQtLVEY3ry4BHcdnPv9uqQ9G4Wji9TatybOy1u4kUTYYaV12JUnR2PjdCiVs7PhsSPNOASolvLqkqFl3Tk1O/AuP0FA3DILDJYbUzk0+Nqjd/eLKNDU6o85d18VTz8sfqjjFAbvI6/1ouh/60fdjJN0AdE8cz+sx8sp4BPXIPRktNW2wlzTq2N1HQ8QTRaZ0IxC0+4N27h2SGtCuX4OQ3/bIwTmSHEyJfXGY9pZi/SYVDn9lE1wSp5WepiwGr6kh5vR60Ijc9ifSbc9j/5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ihNWrBMRdAMBWgthgP48Joizm5zshcaYaUOjG5K5HRg=;
 b=Pg79OUVUGMqp4VXE7tQNHD9XtGYevFmkubkxp9WA0P1UtmJ8nE5c0X+H/leHVdFFwOurHUB6OLmXybHK5O37jf8QQy+SK2qDg0lT6hTJPzI3UveK6zHbVvu2UeyBR3ROdZ0eKQUXQZgoy3lbJABgRLb8+r2iOov5pMRRS9yswj4=
Received: from SA6PR21MB4231.namprd21.prod.outlook.com (2603:10b6:806:412::20)
 by SN6PR2101MB1360.namprd21.prod.outlook.com (2603:10b6:805:107::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.25; Wed, 26 Mar
 2025 21:53:22 +0000
Received: from SA6PR21MB4231.namprd21.prod.outlook.com
 ([fe80::ebfa:8e51:9b6f:f94a]) by SA6PR21MB4231.namprd21.prod.outlook.com
 ([fe80::ebfa:8e51:9b6f:f94a%6]) with mapi id 15.20.8558.037; Wed, 26 Mar 2025
 21:53:22 +0000
From: Long Li <longli@microsoft.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: "longli@linuxonhyperv.com" <longli@linuxonhyperv.com>, Wei Hu
 <weh@microsoft.com>, "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [EXTERNAL] Re: [patch v2 0/6] Support VMBUS channels without
 monitoring enabled
Thread-Topic: [EXTERNAL] Re: [patch v2 0/6] Support VMBUS channels without
 monitoring enabled
Thread-Index: AQHbkhMMqddCMyfSsUuQ4ghuHsMq3bNulhjQgAEOuICAFmlbsA==
Date: Wed, 26 Mar 2025 21:53:21 +0000
Message-ID: <SA6PR21MB423104031B84EF44AAFEB98FCEA62@SA6PR21MB4231.namprd21.prod.outlook.com>
References: <1741642977-14297-1-git-send-email-longli@linuxonhyperv.com>
 <20250310162038.5c05ce8b@hermes.local>
 <SA6PR21MB4231702177B6AACAF54FF40DCED02@SA6PR21MB4231.namprd21.prod.outlook.com>
 <20250312083611.5d34cd99@hermes.local>
In-Reply-To: <20250312083611.5d34cd99@hermes.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=14b3c278-c894-4b2a-a017-bdb645344e44;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-03-26T21:50:59Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA6PR21MB4231:EE_|SN6PR2101MB1360:EE_
x-ms-office365-filtering-correlation-id: b75456fd-88fe-4e10-5760-08dd6cb0a077
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?1ZWJZfbLbC/n/hZV7k6Jdgv5Nbw+FuUWMs0tYz/TQSu/RD1XcYDZzTqL0O7g?=
 =?us-ascii?Q?qUav2KngS33TrcOKRyHxwwZUArawZAUTdN6rPPzQI6fKvSLhZPbEwWZC9SlQ?=
 =?us-ascii?Q?fhTOnjXVPy46f4H6bs8WPx7gzdmbVrWrPXUD0XhmSDGOK/oO55OqrDdRCMIR?=
 =?us-ascii?Q?r9h/C8O02wABbbn438wxCRqKqoBUALLVw5S3domYNneQoWqWO+3pgWpRtvfk?=
 =?us-ascii?Q?pW5aAFu+T6C3X/ZsUDCWko6n+lxHBfUI7kTNYmN7haY29vd07G4trc01ncig?=
 =?us-ascii?Q?xxLQkH4QCFV55ztjLn5VqsTQyCuQxzjbgamUxPAbFKbJXjaVbIFWz1uXsSES?=
 =?us-ascii?Q?H/Sai5WLAXLOxH2sGMwYHZMgpyATmzQCG9KDKjR6JWoA9qSmgfwh+NJ7y6xd?=
 =?us-ascii?Q?iFPCrizOfvfTtqYZzwr0eVB9wSf/OUmDpezL13hhm9sZEuOh07Ubnj2TTN/0?=
 =?us-ascii?Q?undBr/JihwbjRxOoaJRo1zbV4vGABCdK2V9XaTEtP3AfDa8l9PhbCNIxkwQ9?=
 =?us-ascii?Q?/BIQIUxnNhax6xijbZ2TbUeq7zSnq5a5tKmkdwJr25CxXFZqHGJ1IS39IuiJ?=
 =?us-ascii?Q?qtCna+MG5E1o1sUXJqZsmEEKqVSDjwQTeu7rwbKoWOoIq2hvVjgBpBQUvhyo?=
 =?us-ascii?Q?rUcmHgUB/UiiR/z+pJbZ0IPEQURojgDSEfoTCGnu0avHM/HNhqxSHia6tnkE?=
 =?us-ascii?Q?qalFIXGT2h83Hu6zfvlRiIZw5ih+kLIERhgIiHB68HGPGqmhh4sgFZFXASg9?=
 =?us-ascii?Q?PaJodaiV3z1QPSuu2rwkl37Svg+01cLPdU22wIg+bVZUDsOKOpsdkSPTPVzy?=
 =?us-ascii?Q?wUn7BqYQqYV1QXoSXK+KyIOX8JJANt2kZk7fChdDKnaVuZsVczqVgoIDqJcZ?=
 =?us-ascii?Q?B8eGetIPqbn/OCLLNsdL/yLHDWcnU+A4dX5VzCI1PLj8+xwXn6sZdA2Z9+QI?=
 =?us-ascii?Q?CZCpQ8nOxegRNvwl1amC6keuiz4mPovtBxDdPOuHZtTfn5iUFrO9Q5Hp6eDT?=
 =?us-ascii?Q?g90HnHvYqR4IYQwFZT1eCB9uSvDRZZf01lzNnvBUwNgs10hFEwk8sOSkqeZX?=
 =?us-ascii?Q?f9z6/vHWBqDu88Qq13WKGFNz715fPQrmXCQTey2nhgcHBXYb8y+MN+tf/VZd?=
 =?us-ascii?Q?GkcYgzyVwwK7IEXcmEga7kxchPc8+ZijaPyDs8VOWX78aQxb0EhUpEcN4vsd?=
 =?us-ascii?Q?SlIBx4uQ8D48Ulxb5+IP5NhfJ2CrJtsJ9UqV0AWI5j/LRhWCNGYN+d3bbBuc?=
 =?us-ascii?Q?yHX55ghGiZ7f24+chVA5JKdy+MeoBH9YVeg2HJgC7sKcblhisPhmjBr0axXl?=
 =?us-ascii?Q?Ym1nLBaYdnpUm2sApnLiehFLs31Gfqk9rcKBVez3VmutcFwV9NX2D/WPg6L6?=
 =?us-ascii?Q?iK+Kuoba/Jn85XvRlkA0/drYJ090+v4UmwdY8xZbtoYIcZul9fLyNQ5owJdq?=
 =?us-ascii?Q?nDdZmTko40qrLTbVC0iGGR/yzIqsrfY8G+1exh+I2epA8CaACOEK1sPSiVhY?=
 =?us-ascii?Q?hsX8Y2oz72k3PBI=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA6PR21MB4231.namprd21.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?pZqBhaVGM6pdi3KEP+5GgidPrsiLyhzim1O4VqmQlLVAyJ9+FjB90NFTsknr?=
 =?us-ascii?Q?XKSswCCs+TJl/hLOtCeWgxY7O/B/rAjmtmH+Y1M+bppzpPNMTZcDw5SQdXMx?=
 =?us-ascii?Q?bh7OIgrHo/K2RXRg8hOmidF1rVx10Rhm7fwr33cdpQd0fT0qiNR3rpZNY9Uj?=
 =?us-ascii?Q?E519R8UbvADTM4y7API0+3MU8hyu4eahtsq6R8iGsCX7dVW0Z0pwD5FQb9TY?=
 =?us-ascii?Q?KLbNgJlfNUa0wFP/gseE6YSqr4ohcIcOzg9w4K3hJ/CnwSFqveJZrfHhx7Lc?=
 =?us-ascii?Q?fh0ZyF3X9bq8qeoRsnAv2y2sScONJkvg9L7Eh+MeFqkFiPj6RTKzADa8ONXp?=
 =?us-ascii?Q?LlLPxPpezGhF+eHfsgM6yD5aKTvCOOMaylH+rSkuvoLfDBCTtAuBR5iw4Yc/?=
 =?us-ascii?Q?7B7eA4BT2UYeKQ8Csdkenp4tJTRMxMykyakn2LdTS0RHjRucdC10pa8s94pl?=
 =?us-ascii?Q?TqNNtfOf0k+6qcmYqrodeVNdZlMSFjEU1KvA7Ih1Na+u7Ue1ifZHF4yMGai/?=
 =?us-ascii?Q?KfHFU/c7cJbf9OVErGM/ZHGgcB5yr3Vo2E/Pn3q2HRNMISYFlocnxPZP/6Mp?=
 =?us-ascii?Q?g4aMj9lC7B/Z7EAZ68b1Po6piYh+obiVBcbp/y6qlHtW6d8JyntbNMrP6qWD?=
 =?us-ascii?Q?G8E/g37ZPrZZt3+wOc5lqlGfGB6UCxXAhROpjOiMfCQZ0GBlh67sU+WsjrO9?=
 =?us-ascii?Q?Flfg4AcGqBtqlu6PNYY4/KBHZhs190D7DRrTAQ1IqRWx4dAIyNRcuvqFFAos?=
 =?us-ascii?Q?X/dBgqWOfpbHVa5QX9fbdCPmIceuLgFKtcecpBfMq4McpQmkjtAM1NnXNi2v?=
 =?us-ascii?Q?3f8CxoQyzpXWPs2RKBaFe4HG4rpkcDilOlDmRxOp7l+VDpCwU0NcphiJaTIL?=
 =?us-ascii?Q?jGOXJ8UAA2PF0/yyxyVGSyusq3Mt1iKWlwDqwBCc3OrFmKuDHWLgpu2jOMEf?=
 =?us-ascii?Q?7b7NwIOw2uzYOLvyN+ydzy/S2Pct/QyAfULPHIh8mmgN/PuGulHSGSJfKkrY?=
 =?us-ascii?Q?kpHKE8PHEv3nvBCzZOQBQYTd/IE4GIPjpr7hX5MqfOJkU/5P/6qbhOAvoH21?=
 =?us-ascii?Q?IxaYTXItSs5G5labNK4cVh2/0Xgc3avztZ25OMt7My0d7XK/8qD+YNWliQcu?=
 =?us-ascii?Q?61LATCG/slYvbXCU0LOUrPWX+awOtpjcVwE1+zXhwJDxOlaAdo69b79vXWcr?=
 =?us-ascii?Q?T8qX9++dG9+zxbQoUgmfG8tk4pDTJ3uHu8+AT1Swevv/sG22U1vS10d4Fsrf?=
 =?us-ascii?Q?Bxt+Fht/lrYIPh950LP9mS3VPVZ69j05xDK+Y3rLa+WwGVS5Asj2gAQZK9Cm?=
 =?us-ascii?Q?1mZEoNsAfS6rv2d4qW/0n13iZO2bK2iz/6t6rbfBhs1WfovgOzyoXRakB8eJ?=
 =?us-ascii?Q?pu5yB/T69h3Zr8xXi9FlpZMUtI56SHmUFtxleojOT7YlEvUyvMf9EX19wyXr?=
 =?us-ascii?Q?o3i/fO91sJZeAFrz2DOl1P2Ws8nvjfVLl4FSqt0cdvjibGLpCTjjuMak1AIo?=
 =?us-ascii?Q?5CftMAD+gS8170ygeej533q0NTOZB9b2UZHj3ZUJpobKPSX9K89GxIRuYvJK?=
 =?us-ascii?Q?wjGJxdPDhBDxw+gNax15/an3w5XXtcMC9LF8R6sG?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA6PR21MB4231.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b75456fd-88fe-4e10-5760-08dd6cb0a077
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2025 21:53:21.8471 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jqUkGbDB/RQ2vneRxEDBBDueFE3R+/M9APsWad/WQXeZIKvWMnTVPFH1nxo8e6C9ev96cyp2zFZ0mek9BWpMWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR2101MB1360
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

> Subject: Re: [EXTERNAL] Re: [patch v2 0/6] Support VMBUS channels without
> monitoring enabled
>=20
> On Wed, 12 Mar 2025 00:33:52 +0000
> Long Li <longli@microsoft.com> wrote:
>=20
> > > Subject: [EXTERNAL] Re: [patch v2 0/6] Support VMBUS channels
> > > without monitoring enabled
> > >
> > > On Mon, 10 Mar 2025 14:42:51 -0700
> > > longli@linuxonhyperv.com wrote:
> > >
> > > > From: Long Li <longli@microsoft.com>
> > > >
> > > > Hyperv may expose VMBUS channels without monitoring enabled. In
> > > > this case, it programs almost all the data traffic to VF.
> > > >
> > > > This patchset enabled vmbus/netvsc to use channels without
> > > > monitoring enabled.
> > >
> > >
> > > CI still reports a build issue
> >
> > There are ABI changes to rte_vmbus_* calls. This patch added
> rte_vmbus_device* as the 1st parameter to those calls.
> >
> > This will be a breaking change, and it only affects hn_netvsc as it's t=
he only PMD
> using the vmbus.
> >
> > Reading ./doc/guides/contributing/abi_policy.rst, I think the best opti=
on is to
> use RTE_NEXT_ABI. But I can't find its definition in the code base.
> >
> > Please advise on how to proceed with making those breaking ABI changes.
> >
> > Thanks,
> > Long
>=20
> Can't take it as is, here are some options:
>=20
> 1. Version the API even though should only be used internally. Use API ve=
rsioning
>    as transistion until 25.11.
> 2. Wait for 25.11 and just fix it now, and do deprecation notice now.
>=20
> 3. Mark the API's as internal (in 25.11) and do deprecation notice now.
>=20
> 4. Make new functions with different names, and mark old ones as deprecat=
ed,
> then remove in 25.11

Hi Stephen,

I have sent deprecation notice and it has been accepted:
https://patchwork.dpdk.org/project/dpdk/patch/1742242184-19600-1-git-send-e=
mail-longli@linuxonhyperv.com/

Can you take this patch series?

Thanks,
Long
