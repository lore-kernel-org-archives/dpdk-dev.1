Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0586AD65C4F
	for <dpdk-dev@archiver.kernel.org>; Wed, 17 Dec 2025 14:18:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D9D2840275;
	Wed, 17 Dec 2025 15:18:47 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id 183C34026C
 for <dev@dpdk.org>; Wed, 17 Dec 2025 15:18:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1765981126; x=1797517126;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=DCBm+4ftVJryE/tMzYPi4OaiDknQb/eg87bJ6ft6l0A=;
 b=JH87xW8Bj7oX/H3hCEXV+KVTEm1A5sJyqivdOKYMFwMEPQhKvgF3g5Z3
 WO0WuZfLh+z6/FmEoGZkaRYts/arJb3b1MRY6J1C8RyeNS8aS/10nwebP
 NwTY578HA4fMjbzwylDypxYET0jCeMS+J/AtivPHhbUcZhcdVrY42qBdw
 7fpoEsk/SLIoXOx8lvJ+KKMjSaZHzGlOgANPOvzH2V8HzIF5T+NfGJ5r5
 bGHjVtFkDAG4HuApxEGpexpURmD4X+fmkL2kTZXaSSQgeNID2PnRuJwyR
 GbtMSLdQV9LnS3/qlN1YA9byUr/AjPWOkqqBesLV+XSurJXkKTqCJEsQt Q==;
X-CSE-ConnectionGUID: Ks8nzzE0TESNr18pSvldnQ==
X-CSE-MsgGUID: eDlMKfoaRZSByJnf0HayFw==
X-IronPort-AV: E=McAfee;i="6800,10657,11645"; a="85334880"
X-IronPort-AV: E=Sophos;i="6.21,156,1763452800"; d="scan'208";a="85334880"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Dec 2025 06:18:36 -0800
X-CSE-ConnectionGUID: KRcDAJEvQvO/qy0RAuw7Dg==
X-CSE-MsgGUID: kzBVUuBIRBOK6qk20EZgvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,156,1763452800"; d="scan'208";a="198801970"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Dec 2025 06:18:33 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 17 Dec 2025 06:18:32 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Wed, 17 Dec 2025 06:18:32 -0800
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.46)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 17 Dec 2025 06:18:32 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NBQs2k1XZ/rI0izdt4RUxk5Yw8zDBh52kpXe/XFFQDD0b0mH+daYLnXP36zOvo0svJgQfYtjB/09zQSMPd6nhEupNexuHETWEKHd+6bv/jt8bMmMB9ruLzM4PdunMRz4snsHH44TWkOUTwcUHdQv/Si7a78XvlWsEbTxfzJJjmk9LE1TRtqxGPwl74UnvnUVpTApupx7iZvulSOXcJaXWtg8Hc7+PdZLd18ZLX+G21HWVzSCuUxEom4HvNkXN+QnQpUKYwTxkZoDLTfv+pmnRT+WqBdPt3Lo/tq7M/C3lDeNt9xdjGZN/D9y3BH8deoa6D6m0p3a+3gOxENiwLnbIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RTnmTb8oCDCBFZRSbzCHK+jFsQnn9VfIIiZE2BZbwe8=;
 b=TsjYdSFG0qamN8e+VCtHfx7VH7ywAQdC0+8Hqy7VQrtessNEQSUgGOh2wRy8fdlZYEw4U9LRl9ah7FOQLNKaREKiL0C9b4cOP8UBSWpZOKI5jypvCRVe8TNRzAKtVX9TbMVUXd+t2RX95SsOdjAM6Psy4IKdxWY2H7hZtgVGMHe4iII/LEHxwBV+fXv/o/+Y/Y4kMUvMXkw34EF+eqO4D1LpDtaYG1svhJ66ZIrac9E0gFJK8d9l73qRBA+XG7KsmMzv8SMqgBWsPajmb12qi5Ij29vG3oXb7jcoSNkZTjohCOlA2Je4MTERPNLO6+8NyN4Z5vFAhYPlwinOlqx09Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY5PR11MB6116.namprd11.prod.outlook.com (2603:10b6:930:2b::14)
 by MW4PR11MB6668.namprd11.prod.outlook.com (2603:10b6:303:1e9::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Wed, 17 Dec
 2025 14:18:29 +0000
Received: from CY5PR11MB6116.namprd11.prod.outlook.com
 ([fe80::2b59:d9a6:8854:e9b9]) by CY5PR11MB6116.namprd11.prod.outlook.com
 ([fe80::2b59:d9a6:8854:e9b9%4]) with mapi id 15.20.9434.001; Wed, 17 Dec 2025
 14:18:29 +0000
From: "Mandal, Anurag" <anurag.mandal@intel.com>
To: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>, "Richardson, 
 Bruce" <bruce.richardson@intel.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "Burakov, Anatoly"
 <anatoly.burakov@intel.com>
Subject: RE: [PATCH v3] net/ice: add MAC anti-spoof option
Thread-Topic: [PATCH v3] net/ice: add MAC anti-spoof option
Thread-Index: AQHcZEGAPn5qQK3460OIGurf0zTObLUPyuyAgAAkB/CAAA4vQIAMnksAgAkzcYCAAAxfAIAAEziAgAAHv4CAAABMgA==
Date: Wed, 17 Dec 2025 14:18:29 +0000
Message-ID: <CY5PR11MB61162578092FBC66127A2EDDE4ABA@CY5PR11MB6116.namprd11.prod.outlook.com>
References: <20251113105914.34949-1-anurag.mandal@intel.com>
 <20251203104126.75935-1-anurag.mandal@intel.com>
 <98CBD80474FA8B44BF855DF32C47DC35F655B7@smartserver.smartshare.dk>
 <CY5PR11MB61160E99ADCBFDE1182D6BABE4D9A@CY5PR11MB6116.namprd11.prod.outlook.com>
 <98CBD80474FA8B44BF855DF32C47DC35F655BA@smartserver.smartshare.dk>
 <aTrhuMI14CVK27aS@bricha3-mobl1.ger.corp.intel.com>
 <aUKZmzuLWYguKOlE@bricha3-mobl1.ger.corp.intel.com>
 <98CBD80474FA8B44BF855DF32C47DC35F655F2@smartserver.smartshare.dk>
 <aUK0GxJjmJDB0ojE@bricha3-mobl1.ger.corp.intel.com>
 <98CBD80474FA8B44BF855DF32C47DC35F655F3@smartserver.smartshare.dk>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F655F3@smartserver.smartshare.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR11MB6116:EE_|MW4PR11MB6668:EE_
x-ms-office365-filtering-correlation-id: 3da21af1-f488-438d-5bc1-08de3d7726cb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?/fUzyv3vvAEy1i9gzrmk5tEJI9jhlXlPqY9lzVAayn+51kY3pEQfzjOd/c?=
 =?iso-8859-1?Q?qiZ2vQXZgQBIQUU/XPN+WgigFgXJfRv9CVEMEOw7fLqukpuoPoMu+WB1tY?=
 =?iso-8859-1?Q?RHG8PL6dLNr7oZUurccmnM2Avp1Z7+lNLfsPsc6G5GD0UL0rqv0vgNUjKC?=
 =?iso-8859-1?Q?/nPzVEjvuZw7v+iHSBFddeckWiVRpLygev6XwMq/eZlfAkb6qqAIkGhxUV?=
 =?iso-8859-1?Q?q+cw5cPGZ8wD74s4r6BpS6t4EE6NSvCMIPGKi3MhJy8TeRzLw5GCT8X2sZ?=
 =?iso-8859-1?Q?nyGtUBRLsLyq9wUBiCA2FScxACme6aGF2sI39HB0sugnydSRxDsDqi3RGv?=
 =?iso-8859-1?Q?sReofMHRhZed/aUvNl4h3AuIpMHPopyBhVYLtasn4HAAS2y2iCmqSqpPAh?=
 =?iso-8859-1?Q?viBUkTkwsMdoE32SV099pW19riydQ/uuoLarCc7QW1DZU98yGDuA+A02HI?=
 =?iso-8859-1?Q?7xNunXe9nXG6SilgSd2FkTBEDXcpC6OvYcXRoTnLlM+7Ztc7KeTGXiRY+j?=
 =?iso-8859-1?Q?9CAiD8JGsZmSwH/AdGmzB56Is0LSWQao/CaLXC/ioBfqT98xZP4m7TworI?=
 =?iso-8859-1?Q?D1Kakd5+Uq45quV/kRmttya3H/854/FB/dkw9jksWMQ75jwJB+ptl9mYm1?=
 =?iso-8859-1?Q?ICIIfdzV9OKfIpcP0HjMSULE3GGDlr8FSPqBIGPlFDYzWLS35t0AreSMpf?=
 =?iso-8859-1?Q?orTLEussmU/86Ql49dy7t+N2shqV3M+NbpqaQ8nPrKIblDEOlpRLWYGRey?=
 =?iso-8859-1?Q?d4eOkMslPylFIkKBzyxE6w1JZzgO1XRinHUBQIkaia+Fv/nm5j+TqEh882?=
 =?iso-8859-1?Q?NKPEAOvFf0SkUm/x3Ae/TEdkIZCbYQowoP3sOORHXMpPm14+/rwAVhkQ+z?=
 =?iso-8859-1?Q?ZJ5E8QQAnnPa51eIlhUuHnM/HZBe2ib/3wll7ec+m7CduOUhAaCkApWNu4?=
 =?iso-8859-1?Q?yqE8LAwesmFhFRCMpxSXSQ1rzjl7fQrpLMl1/0nARiXtWM3phQsDF7lkpg?=
 =?iso-8859-1?Q?Rf1T0XYzllhTIWwIQ5QMGAmwLm0KsunfL3jtUi24FalyDZzQTl/3AYBLW3?=
 =?iso-8859-1?Q?vQ9KyiN3NcSFwENrwcvQC33cgHI7jZyNG7J9dcr8S85ZESBLh0UYYrePnR?=
 =?iso-8859-1?Q?RNXwWX/DOZz2sFc71M2iVQijCWZ2SaHkiLiK9CZWcuFbKdJ6upkFbiRR9G?=
 =?iso-8859-1?Q?IvRF3LQhjWmQR30Q81YwfX4iNVHp9R0Sf1qNQNfjtkFFLN+tHcvYOxuGxj?=
 =?iso-8859-1?Q?PYENcniUGfDyzE34qRGv4dOXGXwEoMLmkgpN0edylXv6GlrfiOmQWJyO5Y?=
 =?iso-8859-1?Q?ebGO/vSnBn0WewjVhAbctQqUyHUCsN7eYogJvUShzci3BSVo0KuBlaGIVH?=
 =?iso-8859-1?Q?ScVeqBPDRNg/achNL5SPeXTRzteEOHSPU5SEnH3OUa/JfAbFo9VmRv2ghj?=
 =?iso-8859-1?Q?h1jb6BtRnDghXLvZyDPYgN04RO02OxxG/iOaCHo+6CkmChVLWlQMhnFjc4?=
 =?iso-8859-1?Q?TTzQGJUHnnYSqhDpUCowUnoIFHSej6SkUWzEdetf9wfGQyXUvaqie3Q7V4?=
 =?iso-8859-1?Q?0Vt6mgih3Xu5GjHepT01UnFtDtF6?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR11MB6116.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?yh08jECgpqUNozMRl4h+wxMYzYQqGbOL4JoEXb8QiSyEwtvYCX8EwVx0tE?=
 =?iso-8859-1?Q?qxjcf7I+mdLmSpqIRP5D2M28S1fXFqk9zncqPTTJiDBdmeJgCIv/nzWRZm?=
 =?iso-8859-1?Q?1jMgHc3uTr8VzuYLDJ44p2QmTi61hT2921sLTffxLjAbDIyT/oLlS9C4+O?=
 =?iso-8859-1?Q?9CLEAlVgF8lMpOcCAuNUCFMwoxlca6O5A3W2aYuhtY/Kb85sxbf+wnEOtB?=
 =?iso-8859-1?Q?RtupgmoFHx26iQCSFrvrk8YNqrBH+LzFECoG7mN5eOziGKvsJV6QbSOEGY?=
 =?iso-8859-1?Q?DggBzh9qbhgV467GCIbpp9FGmT5m8x1H3BlND6MMEnO6Xy0VkvT2MVXzst?=
 =?iso-8859-1?Q?4e3GKzAhUj/O/D68hv2jM7OLQ3tenCykthvBrSQR5LfLlm7VMhTHZK1cAN?=
 =?iso-8859-1?Q?rnrCuDOlnodFDNEEfkLFbHHMCtidpJVe8QCciDHSkb/+/spC4fv28R3hTI?=
 =?iso-8859-1?Q?+R07Wk+WxbvlPBxOqO2vhEEK/U7Uih01y5rEN9zGecEjIbiwN/O/izL6MN?=
 =?iso-8859-1?Q?nG1/+tE3HmtNQb3W6s3KbpSAK4adSGtsMfQFO7yxbe7vr3OSyfAhizRw35?=
 =?iso-8859-1?Q?ezgso+ZDF5/swFQ8W0wC4Ff1VQwdPgpmEUhjTeHC3BB9om5FAKiStaBF76?=
 =?iso-8859-1?Q?1FcAfmH2b1yOhC0GLmaGAt7Fk/DFlnLrdMwE2MIzHbx+ZeyFsyMiBqxuhD?=
 =?iso-8859-1?Q?Z8n83hoXQoB9TLWwNAvKUB/e9VIGqBn8FMd/Rbjb2NTMsphKrytvzsSI8y?=
 =?iso-8859-1?Q?Qif3pyWzgKbxtAjr7uMIrQdnordVcIfz/9QoUM2r8bAt06IVOw38qWnGTR?=
 =?iso-8859-1?Q?2SeVrHvJK81lMcmJffEWjHLHwlZoyp6DV0TYuf1EesSh+kiZgmSGArlpih?=
 =?iso-8859-1?Q?+9Q5sdhouB6SqbmNd41/+vr729OTtZWvKzvmHakYiNmNd4OhmM7q6CkkZ8?=
 =?iso-8859-1?Q?QtHwKZHR/r9UoXEElW/z1x6UvDDDGid6jcBhyHIj+6e83aYV/LWqDu3ayI?=
 =?iso-8859-1?Q?Sou1lvi9LCZOInR7RTAHvvL+Z7NFuxuw2evGSwTrm47Jbbgr/7L1Bhj03V?=
 =?iso-8859-1?Q?hrAvnQHUuBBxPVBSIAaeEgHK9NlKkO+wuP4G8rqfRBrZAAx0GsBvjFkEnY?=
 =?iso-8859-1?Q?OLtI/KOtPBMtcSzKSJ+hvLX63E08JIH+3R6B9Xb93R1V9HspZxSreGJn4L?=
 =?iso-8859-1?Q?0xRFr6voPenErfXFgecizGj4knEkQQm/uMeokH4iLPWmapeK1AnUKpu1UN?=
 =?iso-8859-1?Q?UTtk61hSFcXi/zfKYJevb/TGpodFQQoZadBn6AXiSiEzgQEz8fUe+yMDLg?=
 =?iso-8859-1?Q?uDQP7RwleyxsVX10WdiJkxmUcvFrWl4C+3300Y8BflSZLWJZFOBrv8Kpdp?=
 =?iso-8859-1?Q?6KSPhVgBi8DqueEaKOv54joLDaDwt8oQNw/WWC1Hc8edRFGOONKyuTUi8r?=
 =?iso-8859-1?Q?0GX8ewpGLnM+vUzeEc2snmlqAYhXNjxUJil8T+JMiQLxsXWrGY5DFcjhSf?=
 =?iso-8859-1?Q?QFFqJu2SQNLyR1UQagx3dbleJ1v3FDaTtqLTNEmE2gPrHvvXK0d5aV35tx?=
 =?iso-8859-1?Q?3hfX2BuzNX9TIn+3w8Popn3zhZlTB0O8dFbzNXnbvKiNpOMI2B9mjyKV6I?=
 =?iso-8859-1?Q?vr3Gbtp24ggOPGktoLQuqs4T6IagFmHd3T?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6116.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3da21af1-f488-438d-5bc1-08de3d7726cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2025 14:18:29.4401 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GhYxgD4x77hRNnkYtpv8bG6CtzvJcJcRutu/7Vk4O1ARM8TWy7+3LenGuCRqxOMaakrJjs9+b4dyp/qFyVKF6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6668
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



Thank you.

Regards,
Anurag M

-----Original Message-----
From: Morten Br=F8rup <mb@smartsharesystems.com>=20
Sent: 17 December 2025 19:44
To: Richardson, Bruce <bruce.richardson@intel.com>
Cc: Mandal, Anurag <anurag.mandal@intel.com>; dev@dpdk.org; Burakov, Anatol=
y <anatoly.burakov@intel.com>
Subject: RE: [PATCH v3] net/ice: add MAC anti-spoof option

> From: Bruce Richardson [mailto:bruce.richardson@intel.com]
> Sent: Wednesday, 17 December 2025 14.46
>=20
> On Wed, Dec 17, 2025 at 01:37:16PM +0100, Morten Br=F8rup wrote:
> > > From: Bruce Richardson [mailto:bruce.richardson@intel.com]
> > > Sent: Wednesday, 17 December 2025 12.53
> > >
> > > On Thu, Dec 11, 2025 at 03:22:32PM +0000, Bruce Richardson wrote:
> > > > On Wed, Dec 03, 2025 at 03:47:08PM +0100, Morten Br=F8rup wrote:
> > > > > > From: Mandal, Anurag [mailto:anurag.mandal@intel.com]
> > > > > > Sent: Wednesday, 3 December 2025 15.36
> > > > > >
> > > > > > Hi Morten Br=F8rup,
> > > > > >
> > > > > > From: Morten Br=F8rup <mb@smartsharesystems.com>
> > > > > > Sent: 03 December 2025 17:11
> > > > > > > @@ -1761,13 +1763,39 @@ ice_setup_vsi(struct ice_pf *pf,
> enum
> > > > > > > ice_vsi_type type)
> > > > > > >  		/* Source Prune */
> > > > > > >  		if (ad->devargs.source_prune !=3D 1) {
> > > > > > >  			/* Disable source prune to support VRRP
> > > > > > > -			 * when source-prune devarg is not set
> > > > > > > +			 * when source-prune devargs is not set
> > > > > > >  			 */
> > > > > > >  			vsi_ctx.info.sw_flags =3D
> > > > > > >  				ICE_AQ_VSI_SW_FLAG_LOCAL_LB;
> > > > > > > -			vsi_ctx.info.sw_flags |=3D
> > > > > > > +		} else { /* Enable Source Prune in Rx */
> > > > > > > +			vsi_ctx.info.sw_flags =3D
> > > > > > >  				ICE_AQ_VSI_SW_FLAG_SRC_PRUNE;
> > > > > > >  		}
> > > > > >
> > > > > > This looks like a bug fix related to Source Prune?
> > > > > >
> > > > > > Ans: Not exactly.
> > > > > > Initially, Source Prune was disabled, and MAC Anti-spoof
> check
> > > was
> > > > > > enabled by default. This was done by following:- Source=20
> > > > > > Prune is disabled by setting local loopback with=20
> > > > > > ICE_AQ_VSI_SW_FLAG_LOCAL_LB flag in the Rx direction.
> > > > > > ICE_AQ_VSI_SW_FLAG_SRC_PRUNE is added to prevent transmitted
> > > packets
> > > > > > from being looped back in some circumstances.
> > > > > > Now, MAC Anti-spoof check can be disabled by clearing both=20
> > > > > > ICE_AQ_VSI_SW_FLAG_SRC_PRUNE and=20
> > > > > > ICE_AQ_VSI_SEC_FLAG_ENA_MAC_ANTI_SPOOF flags and setting Tx
> > > loopback
> > > > > > with
> > > > > > ICE_AQ_VSI_SW_FLAG_ALLOW_LB flag in the Tx direction.
> > > > > >
> > > > > > As we moved to making both source prune and mac anti-spoof
> check
> > > > > > disabled by default, I thought no point to set=20
> > > > > > ICE_AQ_VSI_SW_FLAG_SRC_PRUNE during source prune disable and
> then
> > > > > > clearing it to disable mac anti-spoof.
> > > > >
> > > > > OK. Thank you for elaborating.
> > > > >
> > > > > >
> > > > > > Thank you.
> > > > > >
> > > > > > Regards,
> > > > > > Anurag M
> > > > >
> > > > > Note to maintainers:
> > > > > This devarg is like the Source Prune devarg.
> > > > > If we want to elevate these exotic features into proper Ethdev
> > > APIs, it should be done for both devargs in a separate patch.
> > > > >
> > > > > Acked-by: Morten Br=F8rup <mb@smartsharesystems.com>
> > > > >
> > > > Applied to dpdk-next-net-intel.
> > > >
> > > Unfortunately, this patch causes changes in the driver behaviour=20
> > > leading to CI failures. These issues can be seen with testpmd=20
> > > where packets
> are
> > > looping back inside a nic port unexpectedly.
> >
> > Can you please elaborate "packets are looping back"?
> >
>=20
> When testpmd is configured for mac forwarding, sending in a single=20
> packet leads to a constant stream of packets being handled by testpmd.
>=20
> > If the packets egress on one physical port, they certainly shouldn't
> ingress back on the same physical port.
> >
> > However, if they egress on one virtual port, and are internally
> switched to ingress on another virtual port on the same physical port,=20
> I would consider that expected behavior - the same would happen if=20
> those ports were physical and connected to the same physical switch.
> >
> > If they are ingressing on the same virtual port they were sent on,
> that would seem like a bug in the NICs virtual switch. A physical=20
> switch normally wouldn't transmit packets back out on the port they=20
> ingressed on.
> >
>=20
> Not exactly sure what is happening internally, it needs some=20
> investigation.

Sure sounds like it.
Let's hope it's only testpmd, and not a broader issue with the NIC/driver.

>=20
> > > Therefore, this patch
> > > needs to
> > > be dropped from next-net-intel.
> > >
> > > Can you please do a new version adding the feature you require
> while
> > > still
> > > keeping the existing default behaviour.  I'm going to move the
> patch
> > > status
> > > from accepted to "changes requested" in patchwork, in anticipation
> of a
> > > new
> > > version.
> > >
> > > Regards,
> > > /Bruce
> >
> > This sounds like the CI needs to be fixed.
> > Why does the CI expect this kind of filtering to be enabled by
> default?
> > I wouldn't expect other NICs to perform similar filtering.
> >
> It could well be a testing issue, or a combination of incorrect=20
> default behaviour and a sub-optimal test case. However, until that is=20
> fully root-caused, I'm backing out the patch for safety.

> A new patch with reverted default behavior seems like the proper short-te=
rm solution.
> While investigating, we can live with the wrong default behavior, as a "w=
ell known bug".
> And the configurability will be helpful for root-causing.

>=20
> /Bruce

Hi Morten & Bruce,

Please note, when I sent the patch[v2] with MAC Anti Spoof enabled by defau=
lt which is the current behaviour without the concerned patch , then no CI =
issues were reported.
PFB the reference.
https://patches.dpdk.org/project/dpdk/patch/20251116035749.45922-1-anurag.m=
andal@intel.com/

Root Cause of the CI failure:-
Source Prune is disabled by default while doing that we used to set ICE_AQ_=
VSI_SW_FLAG_SRC_PRUNE flag as well which is added to prevent transmitted pa=
ckets from being looped back in some circumstances like the one CI reportin=
g.

Now, if we make MAC anti-spoof disabled by default , we have to clear/not s=
et that ICE_AQ_VSI_SW_FLAG_SRC_PRUNE  flag and  set ICE_AQ_VSI_SW_FLAG_ALLO=
W_LB flag.

Hence, my initial solution in patch v2 was to keep source prune disabled an=
d mac anti-spoof enabled by default.

Please let me know the way forward.

Thanks,
Anurag
