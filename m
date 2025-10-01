Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E3E2CCA470
	for <dpdk-dev@archiver.kernel.org>; Wed,  1 Oct 2025 08:38:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6C03740697;
	Wed,  1 Oct 2025 10:38:05 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by mails.dpdk.org (Postfix) with ESMTP id AE21F40691;
 Wed,  1 Oct 2025 10:38:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1759307883; x=1790843883;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=kztUGDb5KPN91kYbup1i/IPFKiaHLIRhX3FLEwjVDfY=;
 b=GUTrKkQz/Qy6JY0yHcLwnKcfj/VTl924JAt0qsedniYqtuPiK+Gqo2Ms
 nFy93ixqFgB/wovYuxLW+8UqL9wDq8Hoegx1N0i8OfSO0gziCKqe6RIlV
 CCtRmVoGcqjc8RD1NgOCMUvYwfr50GlaMiMMOARs5owSkjOMZamZ9r3H8
 5BMNmGGO/KXX8TAOCL7uUqrTlF42zJiwRkSB55wHPMJ0l0Ym5OQllwSER
 WUQgTRfQEGQqpFm6/VQfqT/6bto4Ohp/YwtJj8hc7ydgiobE5L7QEVqzF
 laxGeGFc1a5mLcg+g0RzvLNpKJVFoubIQ33Xve3NvlbzOT/tP8N62JqsB g==;
X-CSE-ConnectionGUID: 4mVAIQCARI2nbHzE/R5CBA==
X-CSE-MsgGUID: xr3ZNtRZQvWCEwOX2zPHAw==
X-IronPort-AV: E=McAfee;i="6800,10657,11569"; a="61682651"
X-IronPort-AV: E=Sophos;i="6.18,306,1751266800"; d="scan'208";a="61682651"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Oct 2025 01:38:02 -0700
X-CSE-ConnectionGUID: bJ1I6VacTuia1wQ/5b1cFQ==
X-CSE-MsgGUID: Vv3MvAM4TIu3nCd7H2GeoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,306,1751266800"; d="scan'208";a="183920239"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Oct 2025 01:38:01 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 1 Oct 2025 01:38:00 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 1 Oct 2025 01:38:00 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.54)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 1 Oct 2025 01:38:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XdgKtYxz9PW6WGj/wGLUYs0HNyWn2shAikKYhtOVA5LjFLxQLBHTBSnd8EnKqqK0SlJaKvv1m0ituhL/YHP/lXappASxYesOYgB4m5jS2QKAnt3zP8rSDGSZ4S5olBQlPNmDo6KzvbKsS6xCJllnfkIJ8IMtPQ0agigfBmYgKgYmGmDGU9ROyRjLBeHZS317OroLpuUUTPglI+sZi7IxCdiU3GimObFe71GH3tVFsIxiZb6vJFBnTpCxeoJ5/a+tEe88R9fexJRmBg8HQqrCGCdWN2kw9c8VlVkLr4bFMShLJEQ5Rxrr6hPcVyLXG+PzcmX9o7wM/GObdfIYayxkDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vYNqjUuwMl9EQE+TEfPa+33ur6jybK4pWJzvpQA/V1g=;
 b=RY5H/NeGVezjVX+KfkaRgme4ZdlMXZHr2KbtUvN3TeUaI3zo4ziwmPWLs1YA260q0gKy0Bh93V3jCyKbKxsX4Ndgdz069WfXMCHyW8sX8JLJ5nEd270q/s8NkJBxJ2DNJtJW/ZfcKknPH9q52sWe3GUbdTSEls4hYtBKsGdDiP+iDMJG9KQ78scUTFyMQOWQ83qkJKVS+Bp4bzochEg6b42qPVoiZoM+f6CuIkK8AUrzyg+YYLKtTvHulN4npmtAnGRQ0xuJj8rw9Nnq2WqhA1hJyGsSNOVKSYuo+4Hjl3fRB/+17yqFMVDpQD/wey6WsSAQE1Zms9Su/p4mP9x2yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM3PPF7D18F34A1.namprd11.prod.outlook.com
 (2603:10b6:f:fc00::f32) by CO1PR11MB5186.namprd11.prod.outlook.com
 (2603:10b6:303:9b::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.15; Wed, 1 Oct
 2025 08:37:52 +0000
Received: from DM3PPF7D18F34A1.namprd11.prod.outlook.com
 ([fe80::e891:61bf:88e7:bd9c]) by DM3PPF7D18F34A1.namprd11.prod.outlook.com
 ([fe80::e891:61bf:88e7:bd9c%8]) with mapi id 15.20.9137.018; Wed, 1 Oct 2025
 08:37:52 +0000
From: "Loftus, Ciara" <ciara.loftus@intel.com>
To: "Richardson, Bruce" <bruce.richardson@intel.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "Miskell, Timothy"
 <timothy.miskell@intel.com>, "techboard@dpdk.org" <techboard@dpdk.org>
Subject: RE: [PATCH 1/2] net/iavf: support VF initiated resets
Thread-Topic: [PATCH 1/2] net/iavf: support VF initiated resets
Thread-Index: AQHcMU3AqHIGIyG6mU6GyIhfLzcII7SrcJsAgAGJkoA=
Date: Wed, 1 Oct 2025 08:37:52 +0000
Message-ID: <DM3PPF7D18F34A105FE85AAA7D7387DDD838EE6A@DM3PPF7D18F34A1.namprd11.prod.outlook.com>
References: <20250929143039.547207-1-ciara.loftus@intel.com>
 <aNudwFx7CPH3vWot@bricha3-mobl1.ger.corp.intel.com>
In-Reply-To: <aNudwFx7CPH3vWot@bricha3-mobl1.ger.corp.intel.com>
Accept-Language: en-IE, en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PPF7D18F34A1:EE_|CO1PR11MB5186:EE_
x-ms-office365-filtering-correlation-id: 68d12ad7-fea5-452d-c111-08de00c5cfa3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?HhHcyDldRpp3W9J+G3ayA+rVaNrlFAA6O+2aowW+x1dS1Qiqs0lV8WboHf8q?=
 =?us-ascii?Q?cAQL3RBCmP4bWV647fq/D3WUFgbenHcdrR2+3Rv58nrPxp3iZR9yH1s5Af/I?=
 =?us-ascii?Q?1OhAQ49KcjEbtVP10mSLviGkApDL2EQafhJ63xQn/jT+9+/Hi4PytPzgpTlZ?=
 =?us-ascii?Q?WKDmT7ZtReD+A1KDhM1eTz9RPeM+Au5D65eKx0a8CjISSqGl0WoOsnde7Ckd?=
 =?us-ascii?Q?qg9XMmsd/OCoDxBlMKIDcJwEXVLba3KcGgF59j8QftZAV/26YyEd1jJAGOWc?=
 =?us-ascii?Q?JdTfFwZf3yFYdpo6bKv/o6Ohu4Ec6uDk/yjBGdvWMoEjbqlaP9wryynBgfOb?=
 =?us-ascii?Q?r9mFWpiH1tw1FyR2iuePFXyGRebnrzWMB2m4/fOogcNYgn+hBVehRgr/rBVq?=
 =?us-ascii?Q?Qnza1f74azcJX9rK0lHYOMNUJeMT0qhLWq09nRA+lxJPqil0AQsRVzZ6aOrA?=
 =?us-ascii?Q?4CIz4Zhgesy3o0YdNf3Haxj9SXfKHcE/8tmWue7tHwUkyNL/QoAPFKpCPadG?=
 =?us-ascii?Q?xdFnwEq0SUKd/WhUDDp3Ae8jmES0nRIhqxbsIIB1nGoc0sxX6gLKWgyWEQVS?=
 =?us-ascii?Q?uf3kShR3VQcyxbo5IRjuQCbU4RDBWXVacRf6zxubOsPH4jwPrgsEg8P9lhTy?=
 =?us-ascii?Q?h4xpF4Vh4tj6p/S3auhe1oN85SBJ6+eXDmqBOYhB+keD5IwXmsgUxH2VIBrq?=
 =?us-ascii?Q?edR3EAfEUNPC9cQ1pae7nxTmZSz4o0fR8Rhl/93UlcOfiuuvRSk8Tj+qZQK1?=
 =?us-ascii?Q?oQ6oxxrY51CK815GlKDFkeVT2atPp0aX8BEDTuWsuzU67pj0AlE0M9HypAk1?=
 =?us-ascii?Q?GpJTXZXjnhxt7f7SmAOmKKcM3J993rY9ZwNxdLjdrdO+wyg8VVB9SxQ1G+Xe?=
 =?us-ascii?Q?VeTXkIfRSj7R3RbsVh+VCZ70SZgBlVwAE6K23pn1O8gh8lLKqj80WGWKpdW5?=
 =?us-ascii?Q?cF9KV8CcVezc/raubinQDvfJc9n8KkznDpUwsJlICXfRTfwqM2k1npe9d+Z0?=
 =?us-ascii?Q?qcEPnuAYEJqRZt4lXC/OqECrgT7TXXijbvHjM975EcDHQN+xxU2gQfXwI2oS?=
 =?us-ascii?Q?YGEnJbJw4T7J79jBevUB7mceLd00irStdvit1lg7UXeF1G0oX/e/xr5hSvZb?=
 =?us-ascii?Q?mRHgv3j/fxGoXw8fQOjGdeoOHUoQ26ZTIkDNS6Jj6RG5Y41PHYE8oTNMIKig?=
 =?us-ascii?Q?RteGaRURe6rHSu/cd7SRysk2Zk+5f/5/YYj1X+nDVMpccOBniPJvBNqT1sN5?=
 =?us-ascii?Q?oJbTNZ4db8khXdHKOKVBb1fCLZzZDD9/GHj6p74/i7MVqlR2kZodbLfUfQf4?=
 =?us-ascii?Q?j6F/WNwLYJ6+cyHjj8HjGoZK0YNhsrYuTQjqQ0PX8TB0DL4egxboCFoTQ05Z?=
 =?us-ascii?Q?ZFF7VFMrA/GRQshdeStbg+DNpv4rR2nZajHRta4Wa9+9c1z2dWaBgM6pFjOq?=
 =?us-ascii?Q?aiFxviAYGcOMLYm33QHQK7GsTMxkni+7yPMTb13CurV7eyBrSwGfHT0J3tsy?=
 =?us-ascii?Q?WWJAv/lMbNw8QjWez/vCkdihth4+8F0AR/cx?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM3PPF7D18F34A1.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?GKNRO5iKVViWVvDoauXM+u5UVwF+bocuArh8hyVbrmsKUOJFzcWwuxnflTQE?=
 =?us-ascii?Q?aNSUZ/1yqlhkMroGGS8YqQC3g5GqZJMofXxLTpZi6BksUet+0syt7cdrNTsE?=
 =?us-ascii?Q?mdmm3Ikw49P2eDJwJMQpF9e9JyR7yLKp6jb0T4kYPx3HiScuOxScKwDbL5xc?=
 =?us-ascii?Q?439wo0Qlk7PzasmIobs+5XBpjRtxsuDRLdUHmN5OvLwFIh8dRIoNRSyy5vAL?=
 =?us-ascii?Q?PB3fnerr6BercDnLIua32LYZD3osA7aV33H/YZjhV01FHD7cIoFsmGoZD1td?=
 =?us-ascii?Q?5HiFdpLXbGJdaYhnG+QOkynVl8zpRywbm1BdUBbkxzIfxpYvodnxW1wW74nl?=
 =?us-ascii?Q?n6Wn4pbgP/UaNIVM4+dQ2c8kHV/OJnS+rgTCVvrgPWv1ntcvqZ3b4elCNKdm?=
 =?us-ascii?Q?sP29ELIStZyAXya9B2asNgL5lRZB23F2+GL4VsWcxWEcGbYadQ6ndoG5Hecp?=
 =?us-ascii?Q?UuPHkBh+3NPZTst1Hp9jqCS9Uy9CHOBn3nQzZLj3WjYwNCGepz4IePL2NEY0?=
 =?us-ascii?Q?nhFtm3GG8pfHShTvf4RP2BOOqd0Hr4JaYIJzJXDbtVCsJlTiTWob9wNiofl5?=
 =?us-ascii?Q?90hA8nBlhaVwhKFTE0BKCAzd/nxkG0kBomLcN1A7qZqIsOjrxKEMOF0Ek3fr?=
 =?us-ascii?Q?ZpXc+nzdyXtrUxch4BLhhYI4GFUTWk8yfMdSc8IHU0GQ/3fdjHmII8AfjHdG?=
 =?us-ascii?Q?DE0Ptcc9pg8pAp0El/p/CWvYT2StV1hiZLy5oK7jL2ZjEtWuJRE0rluLpdzW?=
 =?us-ascii?Q?xNZUZK8xyILkNJktkMgf2rRt6hWGeN1oYow5soihOHsNCosHqI8upkpv3tvp?=
 =?us-ascii?Q?JJUiYyCtcOqkccpYNUAFpDr9hZ0LUlftPx10t+Tdsvzq4Mad52LTCUk1y5i0?=
 =?us-ascii?Q?ds1ZutDp5YOvdGx0+sh3AJcL7rixQ/ZqkbOZnC4HmehG6pXpEaVCz3oDBHkv?=
 =?us-ascii?Q?Ys4JRnaDvMNPN3tFanYNbwY8C8MJGMBfPFq97CslTDJ0JtO2MzxtAx66beMn?=
 =?us-ascii?Q?Xz2G2ztOcjGP6IIirGq6dezwHx99dsNAXUrBEzbzCsvzBU7iFWThrZFenkpT?=
 =?us-ascii?Q?86nDhH1lCZlJNF6qcFE9Uv9OTTR/9d2eDlU++vieGMKxeE+pHTiIPmdmh8/7?=
 =?us-ascii?Q?9rdGxgQBBZbJBejQOtnqX4DM30c3e+OYBe5QDmdlrtCTQJ6spx+wTuC1DTLz?=
 =?us-ascii?Q?lW15LyvSUE3Bcvh1e4BkymO8CTEq/RddHSHmEY+PBk/MDlPET/+XOBgPjK4H?=
 =?us-ascii?Q?1wsZ83Itagpf2V9W2Qimcr9Cqzk+XyyfIrHgLFce/Ci10jKT+TnZRgLk9L+d?=
 =?us-ascii?Q?h/iPUkPWI6TvL8uTd6ZELfI67KMmaOk999U6WNggfIAMXsMOiCZAjMi+hlbZ?=
 =?us-ascii?Q?B7bAzK1HWH7qGKMIOIxwgnobqzfldtb1V3dv7bWbqHlUbcBLbBhym4JfBZzQ?=
 =?us-ascii?Q?cQdewoauz2LMbkDrJ8g3BFZCEIpaU82u5UkHJrMQJrXuF460JV/mh1Kb4QUd?=
 =?us-ascii?Q?eBb4NXbzrnGQyjij2jZq0DGGB9/jHC9rQUzbRhAoOKuoiS8IOSOr0WNi+G6p?=
 =?us-ascii?Q?DpD1rxNx3LmI/f2cJeJUKjzHw4IQK8MQpOlTb6ci?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM3PPF7D18F34A1.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68d12ad7-fea5-452d-c111-08de00c5cfa3
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2025 08:37:52.4744 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5tgrwxnYK7c9OuIucz8wHoEpog0tn3T+puV25gSv4WFqV1E8YbUSIozWXPlUENHVOQGRbrMCXZnaIn75RkX3Jw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5186
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

>=20
> On Mon, Sep 29, 2025 at 02:30:38PM +0000, Ciara Loftus wrote:
> > Introduce a function that allows a VF to request the PF to reset itself=
.
> > This is useful for example when the application detects that one of the
> > queues have hung or any event where a reset is required and the PF is
> > unlikely to trigger it.
> >
> > Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
> > Signed-off-by: Timothy Miskell <timothy.miskell@intel.com>
> > ---
> >  drivers/net/intel/iavf/iavf.h         |  2 ++
> >  drivers/net/intel/iavf/iavf_ethdev.c  |  5 ++++
> >  drivers/net/intel/iavf/iavf_vchnl.c   | 29 +++++++++++++++++++++++
> >  drivers/net/intel/iavf/meson.build    |  1 +
> >  drivers/net/intel/iavf/rte_pmd_iavf.c | 33
> +++++++++++++++++++++++++++
> >  drivers/net/intel/iavf/rte_pmd_iavf.h | 11 +++++++++
> >  6 files changed, 81 insertions(+)
> >  create mode 100644 drivers/net/intel/iavf/rte_pmd_iavf.c
> >
> > diff --git a/drivers/net/intel/iavf/iavf.h b/drivers/net/intel/iavf/iav=
f.h
> > index 435902fbc2..6e7aec1bb1 100644
> > --- a/drivers/net/intel/iavf/iavf.h
> > +++ b/drivers/net/intel/iavf/iavf.h
> > @@ -565,4 +565,6 @@ void iavf_dev_watchdog_enable(struct
> iavf_adapter *adapter);
> >  void iavf_dev_watchdog_disable(struct iavf_adapter *adapter);
> >  void iavf_handle_hw_reset(struct rte_eth_dev *dev);
> >  void iavf_set_no_poll(struct iavf_adapter *adapter, bool link_change);
> > +bool is_iavf_supported(struct rte_eth_dev *dev);
> > +int iavf_request_reset(struct rte_eth_dev *dev);
> >  #endif /* _IAVF_ETHDEV_H_ */
>=20
> In general, I'm not a huge fan of adding driver-specific functions and I
> feel like this should fit under the existing reset APIs in some way. That
> should avoid the need to update (or such a big update) to testpmd, for
> example.
> Some thoughts here:
>=20
> 1. we could add a devarg to the driver to adjust whether reset does a
>    "softer" reset of the VF just resetting itself, or a "hard" reset wher=
e the
>    PF does a fuller reset of the VF.
> 2. rather than a devarg, would do use a driver-specific function to adjus=
t
>    this behaviour. The difference here would be that the driver-specific
>    function would be an init-time one rather than runtime, so the runtime=
 of
>    the app, like testpmd, would be generic.
> 3. the most generic solution would be to add an additional parameter to t=
he
>    reset() function itself to specify a hard or soft reset. This would me=
an
>    updating all drivers to handle the new parameter (shouldn't be hard, s=
ince
>    it would be __rte_unused in all cases by default). This also opens up
>    the possibility of other drivers - especially VFs - using it in the sa=
me
>    way. We could actually document that the "hard" option "may be used by=
 VF
>    drivers to request a full reset of the VF by the PF".

Hi Bruce,

I did not make it clear in my commit messages the full purpose of this new =
API.
Along with resetting the VF, the VF is also reconfigured and restarted
transparently, using the existing iavf_handle_hw_reset implementation.
While there is probably merit in extending the reset API to include a soft/=
hard
reset flag, I would still need this new API to fulfil the purpose described=
 above.
If we wanted to make this generic I see two options:
1. extend the reset API to optionally reconfigure and restart
2. introduce a new generic API that performs a reset followed by a reconfig=
ure
and restart.

Thanks,
Ciara

>=20
> CC'ing techboard to get some wider opinions here, especially thoughts on
> option #3.
>=20
> /Bruce
