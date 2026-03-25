Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83BD8109C058
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Mar 2026 18:42:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 79810406BC;
	Wed, 25 Mar 2026 19:42:34 +0100 (CET)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11021107.outbound.protection.outlook.com [52.101.52.107])
 by mails.dpdk.org (Postfix) with ESMTP id 3042A402CE
 for <dev@dpdk.org>; Wed, 25 Mar 2026 19:42:33 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JUn7TKL1ShjTJ51hB1lOMgIu+TQNkrukOHStcikuF4JaqPQJ6CoGP1ihpHHulsFrAkhUKVw4U8swjWlmmx9n+sc/oGEvxTWyPhEO57Qgv07psOA7nSBJGQiTchuqVXDFF6fx8bl3T1uo+90fEoNTAL51xwrEpMj/RZoyF4cIcGZmVqog7RuDrNjMOjAbEpFawITPEVKJIjzxcs4LqUqySiS4Dse0vVcGKqY2ceGh5VibZrCsO7jfehGxAAVCS6KS7QwcueyWSm+n+VVrNVAZguhG/3c8ZRoIDLsZLbZ1fdtl9vxg5VFTRVHbzmbRJDSjUgeW6WWjJ3XPdIVH6V5Rpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qEfg88ep/6JZnXF6w/7HrQg3l9KLK0FYjdC3z/AqRVU=;
 b=Eu9ZxsGvvTzC2qJwiwaElHhLo7+H7Vw8akvOlqEAgKReJlZtqwzOG+ZOgh4lzWx1OJOsDUTitOdHdfcBvHuK2sEgm/lOVFnbT2OxNIbjuO62ULzdiBDmaGP2e+XPGHuYrni+FAwgaeys/KUpn+xcPUhNCY1rLjOEm2iEfg9ReViOOvG2w6Ro4FZJy/FXyhbvZlNdjM1ZkyUgJ2gmqPYZplsN9kfrrEQnaGag6cpHcorg1F9pxz6W5kUqI+0EVPXEK1BZ+68cJnjzkrQMZ3V7MvjVvk9j9uyy7+XoQpTWiuO5NkNC9dLX7lXZkRGYFK8svM8AMY6CffUDAlMY5PrNKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qEfg88ep/6JZnXF6w/7HrQg3l9KLK0FYjdC3z/AqRVU=;
 b=CKb7yvPG1cPNSvz1papQPzK1OR7tV8B95BI74Vg0eguUCckRDyFZrOw/b4SoQ8JRACI2odj9xw6uYdoYZala6RRn6Piw/fdMMPq7Hw+bl7QIUrvwK54jMTz3k3FIq4ou3MSt14tvvurLO/72DbAAq3QtReVoUBDVbZtq1qABaSg=
Received: from SA1PR21MB6683.namprd21.prod.outlook.com (2603:10b6:806:4a4::6)
 by SA3PR21MB5792.namprd21.prod.outlook.com (2603:10b6:806:498::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.5; Wed, 25 Mar
 2026 18:42:30 +0000
Received: from SA1PR21MB6683.namprd21.prod.outlook.com
 ([fe80::879f:eec1:ca0e:d219]) by SA1PR21MB6683.namprd21.prod.outlook.com
 ([fe80::879f:eec1:ca0e:d219%3]) with mapi id 15.20.9769.006; Wed, 25 Mar 2026
 18:42:30 +0000
From: Long Li <longli@microsoft.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: "dev@dpdk.org" <dev@dpdk.org>, "bruce.richardson@intel.com"
 <bruce.richardson@intel.com>
Subject: RE: [EXTERNAL] Re: [PATCH 2/2] eal: add meson options for hotplug MP
 message buffer sizes
Thread-Topic: [EXTERNAL] Re: [PATCH 2/2] eal: add meson options for hotplug MP
 message buffer sizes
Thread-Index: AQHcu/kHZ2JVOAUoRkixhPOdYKv0ZLW+ipKAgAEK+gA=
Date: Wed, 25 Mar 2026 18:42:30 +0000
Message-ID: <SA1PR21MB668315426C13F348585445B5CE49A@SA1PR21MB6683.namprd21.prod.outlook.com>
References: <20260325014506.1866374-1-longli@microsoft.com>
 <20260325014506.1866374-2-longli@microsoft.com>
 <20260324193500.5c67857d@phoenix.local>
In-Reply-To: <20260324193500.5c67857d@phoenix.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=06adaf63-b4da-4221-9094-8f6b38d962bf;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-03-25T18:39:43Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB6683:EE_|SA3PR21MB5792:EE_
x-ms-office365-filtering-correlation-id: f1a1a098-efe1-43af-a24f-08de8a9e4572
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700021|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info: 9rdI+LYDtWikG79OdP6TAr5bhz6nzCoowoomyT8Qoa1yf5X0O+myv3+S3OzkpAblrfRIdRBQaUS2lMQEFX7kG9AQtFo2YOHNAwCp46z0+1yAiL6WAkWh86ncGieBqFl5GywGo06Gj8BPhP44doJWRTw6aOnyJwrlj6VUIQT6yW7Fw1EWN8OJUrAZVUhuqflmDpE2mH7honRuWHOyErlINLmW1AI4IzPPLzb9FgMf13E3cxqtoPPdcbsWigKe3G7Yc6P45mKUyu65JG8x118zl3UNjRrwijfXzJ1o7oy8kyGd/7cOra9RO9MC3nvjVhG47wjsdq2/BIzhbW6zpVvYoFAcKurUoxbgJlxi7sVVdD8jwaDRWu4FZv4njQ5dtGMe5BBPccQZ2+ZLfdEkPqYQxapTaVbQHiKN0pEgaoX6PNKu2uHEiv4jQooPI4DLHgweguul/EjgcCjXMSOQYX7qNvFCKjmOXEGFIrOkSFAwkYzDAQa/Uqd+5DAhq+z0cq+1Hk0tPDOA2AG9cEcjl5LaL0LXBIn2rexgT9A0STE6KTw4EXrfvvM2zP9DHZwW//b4WhzurF+LrdjKj3fs57db4own/pd0UlQzHRsM8BPnC/FZjczagZ90EQXP44Pn8UKmgcmC39YdzK6ZayPMoC7n5xvZQPZ32c4zsc8ISV3MZx2irV1DzX1eHoWFiRktqoiHLtfP4v6Q+L3dR1OTVoPtVdTXRw/axtxy9/RFBwWbR2IwVE+ZihJ53eF0cvfWO6VVWmz0lCk2UaqJgyxqUgGDK4nnu50y9DXkv1byLAoQdlQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR21MB6683.namprd21.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?EJZxyI+UfPPMEssID24j5yd8TU9R+R0mSrb8IjIQg7/CyBGOUmikdQ+lsSH8?=
 =?us-ascii?Q?tzRLF595UUty0T1ODKAhbf1hmscXjtV559boiLXhjg2JsDuvFQVb9V8uD60T?=
 =?us-ascii?Q?JzAEOFZMnv+UH3n4ARYN1S6ospQJB4wCyWrYGEwfZqCKzp4/lXmv17CMFdjQ?=
 =?us-ascii?Q?updbLzpa3B5da81gnIGX85CMrxKav0mkaeZfhUOPvmJ84+isIBQ47Q9nO7tm?=
 =?us-ascii?Q?rwOC9NAzZD/pHNLYChUGgPj1eBkp/p/NXhJeKh6aPeJwAACY/yMnVuf8a8aw?=
 =?us-ascii?Q?ww/f9Dr/5BH0LsXLTuK8Y4HAWE5t7xm2pLVFuzmbyQ3A7OgxiBurnsqLya2z?=
 =?us-ascii?Q?iWzzj3jH5fpULSc3j3hi0Qhs5M7PFn7oUG/Laul9cBigtMxcd5dHppvhcx+L?=
 =?us-ascii?Q?TfooiCBUEHSwEGs0rlEYarjYx3pxDkCH4gzGoIJ5VKsibYKx5ZbR/g7eR2Tq?=
 =?us-ascii?Q?+HXjcylFbhp0OBXQRhG2QPWuJaxDbjdLlM9S6tXsVFmEsP0rLFGltGgHuRBZ?=
 =?us-ascii?Q?JlmjXnSE3PIt2I66+e8VpDFrrLOrqupiBQdONCwwWsRwOyhpMxk8vTBEOeql?=
 =?us-ascii?Q?sck8GVtfqDmfUBn48m6J7cIhrEx6C82+sPA2ofO439mTyZ40hxE5SyBKW/A2?=
 =?us-ascii?Q?QC8BHDf0Rh8jiN+VL2PE0OA2UEWPbvAURg2P5NN7G/Nn/9PQpwDOoJfljdE6?=
 =?us-ascii?Q?faoRvRB9hOGJVHvPRk1ahvgB6y+rdtWmFkvV7+lWdkMeGDhlg9ECn9TcDtzZ?=
 =?us-ascii?Q?o6VOCBbgYDz8z9RcBHtNKwu9hlr7bbJdOKAE4QhKjx0l4TME+I1Bhzkssmy8?=
 =?us-ascii?Q?E/EzpmA8GlaeiAkjQaZLxKbuTl3Dg8Kj1a7cVmqa6ze3fZhwUR2rn3eZBDJw?=
 =?us-ascii?Q?S7f3WJHiCuFMiFWwlE8FW3OyPqTUk/6KqNs/9wZzchWUxAo2Z2xls5BDyu7L?=
 =?us-ascii?Q?EI14/LQvMxyDCP9rZsJDtwAp+z7q6HWbYP/xIZS1Mx47IOoAzQ8jUg6Kw1+B?=
 =?us-ascii?Q?gorJ0nPBd8TLteCXgXIOEbqgKuCNsP9R/kz9d1nOdl6MVcf8yEFCeoOfTM/F?=
 =?us-ascii?Q?2O840CWjhIsE7+lbl6fPxbSY0PQl5rqz7zU2b3XAV9l+2xB1PybvhWdlQkYU?=
 =?us-ascii?Q?tcGcDPtl6U8WjBBPaHSpjvRIiLvyJkHQ9Awb/cqOG0OC7qlIJ9C0h4F7zNtq?=
 =?us-ascii?Q?gvpe6eYxNlxy0jR8CW5Psjc6UtqW0rOmyZ5TAcSfcbu3poRA+HVdjj0vQ9Nt?=
 =?us-ascii?Q?TXpI8p8496zS0NbeFoEBGEu2ExYS5+cA3/9YoB+HuVTHfYoKQAMmZCbbdqJU?=
 =?us-ascii?Q?TIQihNw3UrHB/y3qCgV2qhnnvnwm8aW7cTwTjA4qBOIHwPGi7ys0WCAtkvk4?=
 =?us-ascii?Q?RH/Cjfo2J579gkqvLLFBE1TKQEsMTV7myR8SkNiz+VEvbUkywa4c/uxZWtmF?=
 =?us-ascii?Q?InCe2+osUkG0ijQtlkD6Ip5Xe3f29cBstd0Y5/I7vj8+ofXRZteGV3W0pkFL?=
 =?us-ascii?Q?h7vOoR84yhOCFhCuc/MGxVvAEyrgXSizd+VDwPeTEKLouKwRVTJlpTzgNUa+?=
 =?us-ascii?Q?kJ7Tv3NqfG/HVxN2XwGx0KjB45RUOZ4u02zM4mjsjnkfPCgbykcGSV48jVKY?=
 =?us-ascii?Q?s2eRRu6dl+ghQNEfBn7edVDJMRXPYdPxcbhfc8YGVXVxiHfT4lkcZE3e1XwW?=
 =?us-ascii?Q?wp6bPznwndr516V56kJLzxCzZGE9WlqYYDTbac658N0/0UoG?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB6683.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1a1a098-efe1-43af-a24f-08de8a9e4572
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2026 18:42:30.7561 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /598k4KiyaNjzXlwGVp2EICpPWmecpxanbV6asb9HV8ZrkD3J1+A9KnGjBNCtGh+gcPcvHUbBym559pEEDHHHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR21MB5792
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

> On Tue, 24 Mar 2026 18:45:06 -0700
> Long Li <longli@microsoft.com> wrote:
>=20
> > Add meson build options to allow increasing the multi-process hotplug
> > message buffer limits at build time for deployments with many NICs:
> > - 'dev_mp_devargs_max_len' (default 128): max device args length
> > - 'mp_max_param_len' (default 256): max MP IPC message param length
> >
> > Example: meson setup build -Ddev_mp_devargs_max_len=3D256
> > -Dmp_max_param_len=3D512
> >
> > Guard the existing #defines with #ifndef so the meson-generated values
> > from rte_build_config.h take precedence when overridden.
> >
> > Add a static_assert to ensure eal_dev_mp_req fits within the MP
> > message param buffer, catching misconfiguration at compile time.
> >
> > Note: all primary and secondary processes must be built with the same
> > values, as these sizes affect shared IPC message struct layouts.
> >
> > Signed-off-by: Long Li <longli@microsoft.com>
>=20
>=20
>=20
> The whole mp API needs some work on sizing.
> Ideally the message would be variable size and not include all the file
> descriptors if not needed.
>=20
> Even better it should be TLV encoded instead of fixed structure.
> But doing this probably has to wait until 26.11.

Will work on it.

Can you take the 1st patch in the series?
eal: return error on devargs truncation in hotplug MP messages.

Thanks,
Long
