Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB2C7C83F1A
	for <dpdk-dev@archiver.kernel.org>; Thu, 24 Jul 2025 10:10:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 825EB402CE;
	Thu, 24 Jul 2025 12:10:11 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by mails.dpdk.org (Postfix) with ESMTP id C6B9140267
 for <dev@dpdk.org>; Thu, 24 Jul 2025 12:10:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1753351810; x=1784887810;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=ftYQo0FsVjjywvvQYPHATkDORWWntUrmRZF0EaGGyr4=;
 b=ZLF3foTBzA3LiP+rfqA691PrvQ9IAb/uwy0ekII3qK+yltZyFHbfu79c
 qeZOt3lOsi+FlODxbt9aTz/6T0fRBgoQr662YYBeJl+4DNrKL3dPWzs0k
 Akkw8Z7RisVw8z3J7BauZYSw90H7OivMVYh/9E4toJctzZqnBUL9iKPTQ
 Yu0QaniThNy6Vk/68K842V8cWiX2HPKMXZSMWPr84hDxGhYeq11VFLLG0
 YEnsP+9fmuTE3ed5yTlM7jAhAvdXnm+4YdRt6NnIvihDxzH3apOVik6Ny
 5wLgyd4zMJ6mCchBTqIMyaB95PqTJpqq084GZ9pqDGNdHok4cu5TVNt7r g==;
X-CSE-ConnectionGUID: pOsRCoKJS4ea/BOSvscfRg==
X-CSE-MsgGUID: mnNkDBg/Su2G6IqEB4b2wA==
X-IronPort-AV: E=McAfee;i="6800,10657,11501"; a="66222165"
X-IronPort-AV: E=Sophos;i="6.16,336,1744095600"; d="scan'208";a="66222165"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Jul 2025 03:10:08 -0700
X-CSE-ConnectionGUID: RoRi84JvRPuhD1ZaeXuvmA==
X-CSE-MsgGUID: +E89b1BgTEif46KnmEujXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,336,1744095600"; d="scan'208";a="164381051"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Jul 2025 03:10:07 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 24 Jul 2025 03:10:07 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Thu, 24 Jul 2025 03:10:07 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (40.107.92.83) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 24 Jul 2025 03:10:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ue7NZ7/kBXdfNy9h6RicYAAXpBFe54ZBuZfFx+hV7bQxggZNj6Q7ACWEFAoqs9Ca5i14/XS/ofWSmapFY0M3yWwMY9tUCXqUCeivQJGmSmKkngbG0BK75pWXBlsnSKl1HGRev1xtGgERY0wqj/IWbGi/bZV+yZp8LBPDD+JLvGUCjeqWdRz5fEE5doObWuvDPHRow7jAP6ALewrE0rF3P7tzbt8InJDAmKRYuiismzujVvPwlGRdEDFrxmRbWBrLVNtqKGXCu3ApMGelKppXLS8u+9bFDq9bWaxGocGnwSbMHMSm1hD1Tb7ZfhrymhRWBeoH87+rz0kXfCxq3BlTsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ftYQo0FsVjjywvvQYPHATkDORWWntUrmRZF0EaGGyr4=;
 b=vDVTNiBb+EUnY44b59uPdWd15oK/zhYdLK11MdD6FA3ycBY9Lnf1XEXIpd6F0dFoIwFHfLOJb5t6AcEd9aaQs6HgJoqJnpeE2/wHoKSjNMhqliv1gPWRBmfbrfGnbsxysD2mLKNsWaa/eDyv+zW+Rk80cXa/omKn/BuIeB0K+GMZ6RZ3UDOqZfSXM1FJ9aXW+59B7l3R4Lf/4KOVOUxjrpGX+ChKsjFihLnCJ6loxe4gfzB6IdzWReoeId2R87kM9vUAgu8U6uBQ04a3vlgAu1yMzV91I1xDgB3SmHiEc++OtrPq9I7vGJETBzuvEz3ZR8mM9P4yQmeYFxZS8PnNGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5208.namprd11.prod.outlook.com (2603:10b6:510:3b::16)
 by CY8PR11MB7315.namprd11.prod.outlook.com (2603:10b6:930:9e::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Thu, 24 Jul
 2025 10:10:02 +0000
Received: from PH0PR11MB5208.namprd11.prod.outlook.com
 ([fe80::692:5ac7:5d71:56e]) by PH0PR11MB5208.namprd11.prod.outlook.com
 ([fe80::692:5ac7:5d71:56e%2]) with mapi id 15.20.8964.019; Thu, 24 Jul 2025
 10:10:02 +0000
From: "Finn, Emma" <emma.finn@intel.com>
To: "Marchand, David" <david.marchand@redhat.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "thomas@monjalon.net"
 <thomas@monjalon.net>, "Richardson, Bruce" <bruce.richardson@intel.com>
Subject: RE: [PATCH 2/2] net: remove v25 ABI compatibility
Thread-Topic: [PATCH 2/2] net: remove v25 ABI compatibility
Thread-Index: AQHb+wwccbNrDM1QAkuPcS45XR7Rx7Q/oLGAgAFuaNA=
Date: Thu, 24 Jul 2025 10:10:02 +0000
Message-ID: <PH0PR11MB5208FD8849743BF99B1C59A9EA5EA@PH0PR11MB5208.namprd11.prod.outlook.com>
References: <20250722132441.3700305-1-david.marchand@redhat.com>
 <20250722132441.3700305-2-david.marchand@redhat.com>
 <aIDSPdozAm7JUAnd@bricha3-mobl1.ger.corp.intel.com>
In-Reply-To: <aIDSPdozAm7JUAnd@bricha3-mobl1.ger.corp.intel.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5208:EE_|CY8PR11MB7315:EE_
x-ms-office365-filtering-correlation-id: 6adef634-482e-4017-8a59-08ddca9a4168
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?RnWzyVC57q6luZ+UQrCkujgCVVvazUmVQ2fwhAPqOO7u0UuRd+xDVMdfk663?=
 =?us-ascii?Q?kQPivTPJgue1x4OXhj1QPKG3UjJyKiTqnDeea948Kv4p4enq59K6DJHdBBtq?=
 =?us-ascii?Q?GsKG3jShdX4zv1Q66W4u50I6nviFsr7HklreXgLS1eY79ZJlVJVSQUefFNwC?=
 =?us-ascii?Q?n9wblb0DBWKopgjPJll/YbHjV2kPJBHE+ws5M80zIgW4ZNzGymIzF63i0yW0?=
 =?us-ascii?Q?q+AeSSP/o+YnJ25J2oPs1GoWbkGmuQa9ctX5a+5cRVBkvFjNtHqGka3DiywF?=
 =?us-ascii?Q?S1nFf2qcm6gm3xdDQr2bDsVaLIykZZ5c93EMEOFqbD5o9k2b3AlOvEg6OGmA?=
 =?us-ascii?Q?0evsKbbU/OQR3ERskQ7i2rE7SmKyFbrb25DmjS2Th2yr9AAfChnPuVzg4LMa?=
 =?us-ascii?Q?NKZdhOJgaRuBB5QRfGGmTb13OadPL1/EKiOapW8aBt1HFoknc6poM/nRst/i?=
 =?us-ascii?Q?VU5Vd71OayjxIPNISJklCVgkxeQlg1z7Yk2JqYAzI1R+B5Gu8II0h1MVH0Vw?=
 =?us-ascii?Q?NLRxMmoUU+uzDjE3WVrQixkUNeo1wcq7K2ZAYtbgakONb2AnAkuo/FIgVLKo?=
 =?us-ascii?Q?iEoOdkkgXLMpskCx36weugXX8J93s/y5vyJGow4/d8C9D4iccaxsMuVWGVv4?=
 =?us-ascii?Q?kSVsK6iU9VA7C/kMgcaN2ZCEDveh3UfWC/zW1udRSVX4ifNGm2A61PIqZHZT?=
 =?us-ascii?Q?GQw1edNzoQFwUsyH0uIssCwCI1lkh9ggp0k1idt3AwGwf/K9sHBWFgmsZpcY?=
 =?us-ascii?Q?VHR2LM5HfrKjsajOH6th53nUQsd9sC5ddofBLeuIeaNswh5cZpJdQJroWxLy?=
 =?us-ascii?Q?/b9tMYdXOJua6e3OPgTrnAHzMe3jDUrJ0enqrR0wUBgs63aYH1/fO1ojOF+N?=
 =?us-ascii?Q?0JMoBJ//FbJhmOi7rz9gg8CGN3hkDKcRJpjYQGcU4VuAb1QE3XzXbtIyumYl?=
 =?us-ascii?Q?+BqMoXXK6J/sUHhtB9DmTkH5BrJW88zfWhGXVCFLwI9Kjt0xc8Lyw87HpAbF?=
 =?us-ascii?Q?qisiOv/qAuxud6Xxjfc5tNhB2c9gaPMq1rJvDYqZ/E4GFlixZIrChhyM4nwD?=
 =?us-ascii?Q?OB8UF9L+XomBAaDEBts4IaSiAON1J1yE0VI8adl1b6cNlwJaKYEbhiZdwsGO?=
 =?us-ascii?Q?fJgb1D/6E2ccK7zfRl8qWu3rBfVScLbt+Y9YQUZO88HQmHu1/21CeBlI1ApQ?=
 =?us-ascii?Q?DzzLC7/HX8dz+JiynPUiEwCSX2JDKWKWyz17jY5g+YNW5x7a8RllC2trt1Q7?=
 =?us-ascii?Q?/PMmvcg6grof8mcNldo4sR4QjPUCdTkppXBo+xeEDWSzj59KEGEvoqppaZDv?=
 =?us-ascii?Q?ZruhrraeCaLla8YDPf+tQsMTZFZ9d61O+PelwDt+qVcod4XlTH5GfO8PBgSK?=
 =?us-ascii?Q?3ky2nE/oTWuUauSnDAhD9R+4pvUccTVNu3I8BuIGwSyf62F2NllVaCf5tqfz?=
 =?us-ascii?Q?ZPGi13xTmA3lLuGxUMukSlQAHdVz6UGkO5Mv8rM4qnLV364/pB6eCg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR11MB5208.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?fVtwZbfxizvA3ons+CVP+s2HvkIzNTHR98tNXwuuk10sevBoSJ2zQF2HfCzc?=
 =?us-ascii?Q?8KiQwDNWX8M/7vKojszysZa3YQpiPUIqqlOni7YtVFMjROjijK8mJUkY6bQw?=
 =?us-ascii?Q?mB9aIdRaIwyeiY2ftOrpA7cy7RAJSw4gy/Tgma7BhO/mR1LxBCY8bXH0NCAk?=
 =?us-ascii?Q?S+ISw8RDclC64ygcsW9TRG7JiGQurwLPOC7yfw2m+09esGVTdI3sHsqH2Zl7?=
 =?us-ascii?Q?/7k/Lx+jQMiQfpczvoL5b118nLeLRikEX4dBhqq99B2GrN1AbfJO1nOYFPQS?=
 =?us-ascii?Q?Ab7s6oBZWnzRRsId3YHC2ER+w1/yuldf6ppJorm8o4A9wotK7u72sel4847f?=
 =?us-ascii?Q?+n/5ZEKyqXT66nlppM+NRat/8LYF7BBJTE6sQScgXoogn9X9Rzy/d4b8GzwS?=
 =?us-ascii?Q?ismMws7iHGEioOtBI6q8Ifctycn3iDdH/8y5we86trXT1OTjqWTY9CsbCV9k?=
 =?us-ascii?Q?Xen4HFnEo5M+6poQiZz75V0FdzuIWfQgACfU+L7iJCc5VWP97UaWh7+L/fvN?=
 =?us-ascii?Q?pgWzApaxZ+I1EACo0O19Mg9yrbOkfcugBogPLVSqdVgGBybK0kJoXfN1tEsV?=
 =?us-ascii?Q?xDwp/2GOdauzfhL3b6EHlQRZTP5KrEibTfkh752RE5eiEhoaArKdifVABUr0?=
 =?us-ascii?Q?MigfA9/FaBX5jFJMO68fz32QjFi+RzJFOVd73q3edcbEeGRUFNSmaT+JXPRQ?=
 =?us-ascii?Q?PnhG0PiFeNHDs2HnuOW8GQ8BUbZk7Wh6bf0mZgMgbPEuG+lQiq8iMBprS3Lv?=
 =?us-ascii?Q?1tWekhU6P9PgmR3zHL0YUDq4hVblVH7d+bNi5FsAFlMqBesS3ve8QNUp0ZDu?=
 =?us-ascii?Q?XuoIh/OYwdrBQ1qQUDaPlSVBx4cOc2Wncs+78wk/jJNp10aYlDJk+LDUMV4X?=
 =?us-ascii?Q?O/8SJeoUnocUTohEdgYsU99tedK4dkp8g6XH0ryXvFNou84RZWiqb1LBLbP1?=
 =?us-ascii?Q?KbMXhc7/OrRujfwrKOfWoKj1I6AzRvTENvL2qvH5T9eKKTxZpM6YWOhT8sfq?=
 =?us-ascii?Q?l2ZalfgUtUckxK8Cm6nyBBCyzqc5rUio8KB1kiIDnrC1L47umIMRCvQh0bbD?=
 =?us-ascii?Q?qAP1A7EiAQSOU5ZEAoi7p4zMAwPqlyTdsG/H60pR6diyMZG2Kr2YH4S1l1EU?=
 =?us-ascii?Q?Ock143xUskk7oSR46W+MGiVmf9dCj66gXBkyPN+Hp5OtXuUw8dDVn/+sj0pR?=
 =?us-ascii?Q?0J3DcrJL+mh34iQ9jPls8Pom0jk1PtCgsPgcNZ4GF5zkrZsCfruReXtSYJT3?=
 =?us-ascii?Q?2sXDkMUqPtkJbcM8dOYm4A9dbuhYYzusrsDgkD1454uZNvjh1G08ROrwjOsB?=
 =?us-ascii?Q?U1/GJbi6eX/JJha96+xjSxormeIVaqdaesgkZiF6hNk3wAMRQucH08ZEJ3kt?=
 =?us-ascii?Q?PfclKlRLmsGBU8ZkbmUcf3ZKRnsgLh4ZLRrL4R0lt1bRKOPJufBQYeUG169u?=
 =?us-ascii?Q?1F/BZheTg4y+XY2qWHObdMMvpDD2O2wQHbC+uNsTdX1s6jNzQrRWMbmPZu8S?=
 =?us-ascii?Q?DlSRphzLnGkZ7UFDz9vWkcq4u3LhTPFNz5v7KtBt89+jRKQbDAcBRobFABOw?=
 =?us-ascii?Q?mwcFLTslP0ej4Sv5tipfyeL1SBm5tvHlFON2pCui?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5208.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6adef634-482e-4017-8a59-08ddca9a4168
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2025 10:10:02.7334 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1OTsWVBJ8IzgzV+b2a3/5gt6g/KWyFrN2LmKKc5RgpprV0uj/LzZILhijDFC7ykkMnW2p2SWx4AO/rCszEYEJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7315
X-OriginatorOrg: intel.com
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
> From: Bruce Richardson <bruce.richardson@intel.com>
> Sent: Wednesday 23 July 2025 13:15
> To: Marchand, David <david.marchand@redhat.com>
> Cc: dev@dpdk.org; thomas@monjalon.net
> Subject: Re: [PATCH 2/2] net: remove v25 ABI compatibility
>=20
> On Tue, Jul 22, 2025 at 03:24:41PM +0200, David Marchand wrote:
> > Now that the ABI has been bumped to 26, we can drop compatibility
> > symbols for the CRC API.
> >
> > The logtype is not used anymore and can be removed.
> >
> > Signed-off-by: David Marchand <david.marchand@redhat.com>
> > ---
>=20
> Not an expert in this area, but code changes look ok to me.
>=20
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>
>=20

I reviewed and tested. Changes look good to me too.

Acked-by: Emma Finn <emma.finn@intel.com>
