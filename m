Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6B18C79FB6
	for <dpdk-dev@archiver.kernel.org>; Thu, 10 Sep 2026 03:13:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8137D40A82;
	Thu, 10 Sep 2026 05:13:18 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id D081A4028F
 for <dev@dpdk.org>; Thu, 10 Sep 2026 05:13:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789009996; x=1820545996;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=AlAlw+bXi9GHcM0cwyfOzc+fdspj9Y2yskoqDePbxAk=;
 b=Nj3RLgHZgixFOfHochvw2DkfAjrIEQ0qh20ZB7O6ppflu1lV3TZegQzs
 urG/FJxSMtrrZBIUUh3U4HBm/MJpmRSEhCe03qMno74XUXNfPvwOQsxR1
 tdPUViB5nKii03QchGgKgRt9dmFozeLF1dCjMX7iR32tQuK7AscaK3K3w
 HWkOtAPZ4KcIjr/e5D5RLwue+gD1gDV0gFzlvPdv2rJFRjvOIPDRP2q+V
 TO9pRrJ6LDPfwM31T0Jnxsi9o0tSfxZ9aDBSyIojup8fntauSfGQVZcgf
 jMSWATfuErLTPZow5Uyp9T8jFBA2LyuYO7mkgizf6SlteVPAJLNi74+6T A==;
X-CSE-ConnectionGUID: dp5Ck7wQSZKLX5SYe6IDOw==
X-CSE-MsgGUID: TMcHY7hJSxSh5Jg0rA26jQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11900"; a="89323296"
X-IronPort-AV: E=Sophos;i="6.25,271,1779174000"; d="scan'208";a="89323296"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Sep 2026 20:13:14 -0700
X-CSE-ConnectionGUID: bNOEXACdQ6qG64M+xYjbyQ==
X-CSE-MsgGUID: TV5Kh68TROSRU8f4S9aJaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,271,1779174000"; d="scan'208";a="271994892"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Sep 2026 20:13:15 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 9 Sep 2026 20:13:14 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Wed, 9 Sep 2026 20:13:14 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.1) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 9 Sep 2026 20:13:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HhgTomCUG3n79jKKSOfzOTPLd+f87tvgFYDnkLAKO8u018S9yd5RHj6QRSVLwtghJZQtpKjUwwLxMDieX7T3Hdoq1Wsihn8O/SPX9pnskxNEPIG3ycwEPN81FY/SKgvWfBYi8kcQRSQBxg9NOPNSc8tK92Dt0mbDl/+RRjWecZSJQDSuLpqhaYIwLNvBxr67bilV/Oz0KS9LYWvK5HZlR9he8LEL503A6LfyTIIOur9MNGH4CCstJHqjCultJm/sA36CApGwP+Mhco3OHi8B0m/M936YmAqU1XOkU6Ycy5FeVrprY4KK2iH1W9U/0B72FBa+cIe4frDablqDiZlCew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=smnvbXdlj51/pFaDHJ653rORoj38kB1FgGTawoiHQ8c=;
 b=KcCuKDAAZJjinAMeBjJsHVncHbnNZNSC+SBKEqoLHXgq7SEhOyA2K+q1AJW1sw2ValZhym4ocOR7EDD8uNOOXGBUzUM9evl+yxEA8LlDJDEPBwXI0FONeT9raoXXp7iOO883+DZ/5pdw9gL/mtG1Q98ul3AmRsMc7khkcPzoFWgFTxx5x80mvQhncq72zO+XDdVZh+7kl8xjVCGCWJ06QMoxKjie09PKToQrSemS4YxEQSffU8LbgNgpbNsJMFOCuWUYNiQQ7XnQI4Mg0TPYwm3PcHwm+XQUdWcL7XrjSEo7njoCZH2vi0mB9+FzWhsvQ2PUI9VW5YxR2/FRiOix9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5670.namprd11.prod.outlook.com (2603:10b6:8:37::12) by
 LVUPR11MB9591.namprd11.prod.outlook.com (2603:10b6:408:3a2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Thu, 10 Sep
 2026 03:13:09 +0000
Received: from DM8PR11MB5670.namprd11.prod.outlook.com
 ([fe80::2862:26b4:aead:8b9f]) by DM8PR11MB5670.namprd11.prod.outlook.com
 ([fe80::2862:26b4:aead:8b9f%3]) with mapi id 15.21.0406.007; Thu, 10 Sep 2026
 03:13:07 +0000
From: "Patel, Atul" <atul.patel@intel.com>
To: "Richardson, Bruce" <bruce.richardson@intel.com>
CC: "Singh, Aman Deep" <aman.deep.singh@intel.com>, "dev@dpdk.org"
 <dev@dpdk.org>, "Shetty, Praveen" <praveen.shetty@intel.com>, "Shukla,
 Dhananjay" <dhananjay.shukla@intel.com>
Subject: RE: [PATCH] net/cpfl: fix VF ID calculation for vCPF
Thread-Topic: [PATCH] net/cpfl: fix VF ID calculation for vCPF
Thread-Index: AQHdNqglKSDyAEBpiEuTRkeTE3bA1ra+RPqAgAjxzDA=
Date: Thu, 10 Sep 2026 03:13:07 +0000
Message-ID: <DM8PR11MB5670FB19F3D640761679CC1281BF2@DM8PR11MB5670.namprd11.prod.outlook.com>
References: <20260827212216.765057-1-atul.patel@intel.com>
 <apqfA2kvaIIW11qQ@bricha3-mobl1.ger.corp.intel.com>
In-Reply-To: <apqfA2kvaIIW11qQ@bricha3-mobl1.ger.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5670:EE_|LVUPR11MB9591:EE_
x-ms-office365-filtering-correlation-id: ae55efdb-c938-4eaa-8f24-08df0ee96ffb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|10070799003|366016|376014|23010399003|1800799024|38070700021|4143699003|11063799006|10067099003|56012099006|22082099003|18002099003|6133799003|3023799007;
x-microsoft-antispam-message-info: mSzV9KIegLonVyrY2yBqo4Y6q5SUlWlFGDrPahnYQM+t94UFaDLwgsy7rLEaruIOecTZDcj3OWkrPjESiYHyuwUT3tPl8YXqhH11Z47zO8ETUIKFscybZDa4UjfDs8g2+VnPsB9CBSria1H3nkZFRQxjuNO+aEbQtE4zPpAcm2Vl2csxZ3+oQ6U6Txa+bE1IhYiLp8QHGG7CWxkkR1g0IzoKPvXXQnNAylH7vt4EHy5OZYYXzo7xPDXjmzr+O+l9TucSkvJBoFCbM5QkOLOUtpicIw8DjGLCOEaIU1OO0/umx7PTKigy5xE5GH/bPW7vRnjWFKu/dITzchVEuSTQyWPv8iHu2VbMTlTlhcL+FGm9bVJg4H3uq9ZY3fcc/8d6I/7KByyEu6z8cTlrmNjz+FIQ3rA2FuVSImU+Qob6VFW6S7yi0tp9otm9cTPSxv/n1K+oBmWXPyROFYgqb7yBSj57zlQZKI/zZc9ak1qbDMG6kJ4a1ipBSy73FV0x4OolMZTZeW/IgX6LCgWXYv4FGv2rS4Q1NLJ4j8KVqBnH7PISndnafmMN0AbJlYIlONruiZ6RIW921O4r4KcehkpyFkREQ72Tq7GarBmtWtuor1vEWxtGMtrv9XEzvq5Yv9FLz3LfVehppFGVGx0q2w6aQMhqmPxmivsrQHs8LaDzjIPbVoqpKJ8YH2WvKcB+B8XgUpNpo0BztwnSXII3Pw0v/qNL/OSKYVMglOVhmu/G+8Y=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR11MB5670.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(366016)(376014)(23010399003)(1800799024)(38070700021)(4143699003)(11063799006)(10067099003)(56012099006)(22082099003)(18002099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?LEVJrDpq8YvIYeQyG6NlYvJE1TxsO/9obmTmdlJ5B9m1L4yreycWpUQjz7xf?=
 =?us-ascii?Q?CmArLQ7uUz/XnUgV160VA2hBv4LQyXS8KKKr+f2HWAGf8vcVFKNXZW5KXlVM?=
 =?us-ascii?Q?lKQu8uOasS+e9uLy2oGmo7i+dS+SqQPy7z5ABpoPb7Fv7t+APE0B4X0HtevR?=
 =?us-ascii?Q?auzFnu3vYnfRf2GWeWn3ynNccPQwu3Pe45HWsyuLaJni7RcnQJ6U/t+wykQy?=
 =?us-ascii?Q?IhzsBuK4CJ9Dy2yvaeSGSebRk69eZcmVe6BKv4yhixbOI60hSBvBViI5QUrl?=
 =?us-ascii?Q?owYgE7oAO+mTpofpf89TyKmHtxe5KeA/T1Akph4+dVdHpUdGURr9iC6Q4nd/?=
 =?us-ascii?Q?8rG369zMQiqUbxDI2dPte/q8r4J0BCn7jiWbCABuGylXyDyZTplFiJOalbHr?=
 =?us-ascii?Q?2nAvKpBmLYAu7Nn9EbIH+YOdSxedOK9OVIoWjhpuJe1cqcgvSVuWEQijT1td?=
 =?us-ascii?Q?jU38hq0/5jcEPlv+ug3GyYDtd7bVJbELdX2Mw115zPAJ/QWI8tlzB6FzobOk?=
 =?us-ascii?Q?3ghFj3AEgFNBe3pNW/FV3lO3BZ4V8kfYOzLCOh01FLZUk0g6rZbgsCM+RZl3?=
 =?us-ascii?Q?wHpNWa/fibQvBk8xdduLi0RftDVKyp19+N6sFD6s0OzwD2A4WE+mJJOE6Y56?=
 =?us-ascii?Q?pxdzST4W29xhZilB/O8YduBXnQcX7n39bU7+gOSq11ePltGnxopAA03LwkPh?=
 =?us-ascii?Q?PAPDfbGbZge/pg3xtBCf8UjY82G4ZkxX/KJ/BGtGI5ECa8jw3sfrU4M/AhgZ?=
 =?us-ascii?Q?1ZdWNmHmnrlOUyOrO+dIQQTtaczUZZZXIwweCp4f+Chlj0OoXrW7Rjx6iLfj?=
 =?us-ascii?Q?bfSRfXAppjvyt05AKqdU4mFHxQF/ThdJaL8O5q4w/Udd0KmpFzPQqTSm4pOg?=
 =?us-ascii?Q?6huUqDda/Okrh6l8xky4DVllufqIJW0TjUTknw0CVTngz093OhsxmmreLf/8?=
 =?us-ascii?Q?l+kvRFyiPiB47bcrhACFTARknnvZLRywl8e0J5n2fqaMeRuQonx8jPD/9JU5?=
 =?us-ascii?Q?/XqH/pXq3XvVX0mo5Tcj9D54g4mZ7pKPrgLFKs/zMfT0g2S41UUG40rdjD2A?=
 =?us-ascii?Q?2KzHbc/n4SRJ7z571kc7JBHn17EMrZvpexCRqV5iA0cZ7NMMU/V6kLIH83O2?=
 =?us-ascii?Q?b0u4pYRTVME4y1YH706brrgQViMbQvBzYYl7RvpnA2MSUwDdbeTsNNvC7YyV?=
 =?us-ascii?Q?kMFqsSZ6K0SFv4c0Luc6ZyWNA0J1/PpvIBIua+6HbRoq/ygGXwdkvYmdoVdU?=
 =?us-ascii?Q?+SfOgHjQN1+NQPgs3c4r5FqbqvyfAFuyqhnwJSOlTU+PiF7XmkcXKIoodmzQ?=
 =?us-ascii?Q?Jyr1mdLbmTtfCFiSluIFre3msLEDVeNqm4vKrLUyG4UqCOvPRrywTTrc4839?=
 =?us-ascii?Q?6+4D8nZThlEZzpG/5yrbWqFWTzyoHqxsdlXkqNzFMqZbb8hT75rcaqlMlWWC?=
 =?us-ascii?Q?6Z5llLmmMkzY1wd4977b/tg6YwJSVBOpoMlCDpJJhmQ5iRXY0CSzi2yePNyR?=
 =?us-ascii?Q?ca/TunU4bjJodhTYE6idE1Qi9Didheo2OL5aps70zGxJRguD5ZRyalO5q4Yj?=
 =?us-ascii?Q?JlKv4ktf2qXmrrKuuEyUm9B8D+4P5LpCtOQ35sI7Cz2G95PRV/HCG0hLZ0S4?=
 =?us-ascii?Q?cMsYf6W3e6+lgv+dGD+uVngP23i+0r2OYXtrzRHwJsn1BdPJgObzAolcZmiS?=
 =?us-ascii?Q?vsdI3M8Jf7elAMUWDVT3dUWLkvY5oSEDhmutYJfDiE1Nfc2taigTkQHcTG7A?=
 =?us-ascii?Q?+VUZeZcSw2wpb0vgDZiMgNo3n+fxvrHN9+QE/F5j++xRj5U7e9+SO2dzQPfs?=
x-ms-exchange-antispam-messagedata-1: /hfS6sttZE/PTg==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: tsajZ0X22jUwPDzNIvQxIJlcbi5a7WBZ/wl6oYYgC6POELQI/eUSBP0oE5eKVCpsPOV1seAheEjusl59CU8Xbdy05JTvS5RkH5/iLcWOd0IM/Q7J9OeJKOYx5vqeu0LW9XRSZ+2FLvkkFH+3IBHrgh+92H4giMxxzgykWepVlpno6bRs8l0okVFW/F+KpUiBAZSTLoTyFpLBF+YC2bzu8PAO8xJE1HZAjynvbW2I/y/AK6PXjsjRI+5Imkuqtscr3nHe/mNGKJUV4cXi+Fj63/QEw2+DxayXIwMpEzhjT19F4fCkJ2PcGpi7VxTDW67OsBHEFUTg34GH1vHpH7PHhw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5670.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae55efdb-c938-4eaa-8f24-08df0ee96ffb
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2026 03:13:07.8631 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XkQwUC71FQClL8F+zAwIvhfb++fZG5wXpx7hEHQe//NJtigaBrKE8Ml/pKw2Ci8uOd6jeWWwU16dnEPsVRDgJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LVUPR11MB9591
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

Hi Bruce,

Thanks for the review,
No, the vf_id is not meant to be globally unique across the system - it sta=
ys local to the PF, same as other devices. The pf_id here is fixed to a sin=
gle CPF (CPFL_HOST0_CPF_ID), and the control plane expects the vf_id in str=
uct cpchnl2_func_id to be relative to that PF (the header even documents it=
 as "indexing is relative to PF specified above").

The subtlety is purely in how those VFs are presented on the host side in t=
he vCPF model. The VFs belonging to that one PF are exposed to the host spr=
ead across multiple PCI devices, with 8 functions each. So the PCI function=
 number alone isn't enough to recover the PF-relative vf_id - it wraps ever=
y 8 functions.

For example, with VFs enumerated on bus 0000:af:
PCI BDF        device  function   ->  vf_id
0000:af:00.0     0        0             0
0000:af:00.1     0        1             1
...
0000:af:00.7     0        7             7
0000:af:01.0     1        0             8
0000:af:01.1     1        1             9
...
0000:af:01.7     1        7            15
0000:af:02.0     2        0            16

The macro just reconstructs that PF-relative index from the PCI address:
	vf_id =3D device * 8 + function

The previous code used pci_dev->addr.function directly, so it only worked f=
or the first device (VF 0-7) and collided for every VF on a subsequent devi=
ce - e.g. 0000:af:01.0 (VF 8) was incorrectly reported as VF 0.

Thanks,
Atul

-----Original Message-----
From: Richardson, Bruce <bruce.richardson@intel.com>=20
Sent: Friday, September 4, 2026 4:06 PM
To: Patel, Atul <atul.patel@intel.com>
Cc: Singh, Aman Deep <aman.deep.singh@intel.com>; dev@dpdk.org; Shetty, Pra=
veen <praveen.shetty@intel.com>; Shukla, Dhananjay <dhananjay.shukla@intel.=
com>
Subject: Re: [PATCH] net/cpfl: fix VF ID calculation for vCPF

On Fri, Aug 28, 2026 at 02:52:16AM +0530, Atul Patel wrote:
> The VF ID was incorrectly set to only the PCI function number, which=20
> fails when VFs span multiple PCI devices (device IDs > 0).
> Calculate the VF ID as (device_id * 8) + function to correctly map VFs=20
> across devices.
>=20

Is this saying that the vf_id's need to be globally unique across the whole=
 system, or is there some other subtlety that I'm missing here? Just trying=
 to understand the context of this patch, thanks. Most other devices the vf=
 id is local only to the relevant PF, i.e. each device has its own vf 0 etc=
.
Is that not the case here?

/Bruce

> Fixes: f1ab44fb0ebf ("net/cpfl: add vCPF port info")
>=20
> Signed-off-by: Praveen Shetty <praveen.shetty@intel.com>
> Signed-off-by: Atul Patel <atul.patel@intel.com>
> Signed-off-by: Dhananjay Shukla <dhananjay.shukla@intel.com>
> ---
>  drivers/net/intel/cpfl/cpfl_ethdev.c |  3 ++- =20
> drivers/net/intel/cpfl/cpfl_ethdev.h | 10 ++++++++++
>  2 files changed, 12 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/intel/cpfl/cpfl_ethdev.c=20
> b/drivers/net/intel/cpfl/cpfl_ethdev.c
> index 4315adb68c..01e1b57cc8 100644
> --- a/drivers/net/intel/cpfl/cpfl_ethdev.c
> +++ b/drivers/net/intel/cpfl/cpfl_ethdev.c
> @@ -2839,7 +2839,8 @@ cpfl_dev_vport_init(struct rte_eth_dev *dev, void *=
init_params)
>  		pci_dev =3D RTE_CLASS_TO_BUS_DEVICE(dev, *pci_dev);
>  		vi.func_type =3D VCPF_CPCHNL2_FTYPE_LAN_VF;
>  		vi.pf_id =3D CPFL_HOST0_CPF_ID;
> -		vi.vf_id =3D pci_dev->addr.function;
> +		vi.vf_id =3D VCPF_VF_ID_FROM_PCI(pci_dev->addr.devid,
> +						pci_dev->addr.function);
> =20
>  		v_id.vport_id =3D cpfl_vport->base.vport_info.info.vport_id;
>  		v_id.vport_type =3D cpfl_vport->base.vport_info.info.vport_type;
> diff --git a/drivers/net/intel/cpfl/cpfl_ethdev.h=20
> b/drivers/net/intel/cpfl/cpfl_ethdev.h
> index d41aa93191..97ec128128 100644
> --- a/drivers/net/intel/cpfl/cpfl_ethdev.h
> +++ b/drivers/net/intel/cpfl/cpfl_ethdev.h
> @@ -103,6 +103,16 @@
>  	((((type) & 0x3) << 14) + (((host_id) & 0x1) << 13) +	\
>  	 (((pf_id) & 0x1) << 12) + ((vf_id) & 0xfff))
> =20
> +/* Max VFs per PCI device (functions 0-7) */
> +#define VCPF_VFS_PER_PCI_DEV	8
> +
> +/* Calculate VF ID from PCI device and function IDs.
> + * VFs span multiple PCI devices, e.g.:
> + *   device 0: VF 0-7, device 1: VF 8-15, etc.
> + */
> +#define VCPF_VF_ID_FROM_PCI(device_id, function) \
> +	(((device_id) * VCPF_VFS_PER_PCI_DEV) + (function))
> +
>  struct cpfl_vport_param {
>  	struct cpfl_adapter_ext *adapter;
>  	uint16_t devarg_id; /* arg id from user */
> --
> 2.34.1
>=20
