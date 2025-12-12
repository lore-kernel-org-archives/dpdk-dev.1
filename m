Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA7F0D44166
	for <dpdk-dev@archiver.kernel.org>; Fri, 12 Dec 2025 10:39:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3E58040268;
	Fri, 12 Dec 2025 11:39:42 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by mails.dpdk.org (Postfix) with ESMTP id 5E06B400D6
 for <dev@dpdk.org>; Fri, 12 Dec 2025 11:39:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1765535980; x=1797071980;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=ZROaIgDqnNenQ2hDHc3l3wfvpJT0rNSjCndzK3LWIy4=;
 b=Sf5Bqy2r5bNWUtsKqPMy+LRhmYFZyz+NJgkNFvjrfSxy74+vZW3L1SvC
 bpVmQusQfOOBZ0PLflfkI8LUvp29XxhU4qQG/5fKZG3U3DOQlHWLMIVfH
 8JePDNJNDCM8eJfyhuNcXdnZVMuQRVyMWpeQqL1QwrFiGMUOeC5hRV5nj
 UsF2ZcApZzVHzfFEGvmAl11Odjm53v9dQOvkpYO+7OhbGWRIO5FvQs2BB
 76Xrv6+y0jBvElPAJh/pUpe20BsqEC8b71KB2T1mZ05X04Sp4wtLcYBml
 sWeYoMRYElzpLtEctPJZtS0R0E2/Ia7+FxEBJfSKXhAbKlj9pcTtf9/L+ w==;
X-CSE-ConnectionGUID: dCVDDSbvTM2g6mDVCe8RcA==
X-CSE-MsgGUID: X8Vvt0DRSaGZVC5v6ACqiQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11639"; a="66523688"
X-IronPort-AV: E=Sophos;i="6.21,143,1763452800"; d="scan'208";a="66523688"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Dec 2025 02:39:40 -0800
X-CSE-ConnectionGUID: VhX3HcGXSFeZDAzFvktBdw==
X-CSE-MsgGUID: 2Rt8N5sFRtyaksKLRfGTgg==
X-ExtLoop1: 1
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Dec 2025 02:39:40 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 12 Dec 2025 02:39:39 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Fri, 12 Dec 2025 02:39:38 -0800
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.63) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 12 Dec 2025 02:39:38 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vJtITZh4HTB4z6p2FQr+eIUJfKicT3fwj2EV+T32DFArDml380k6WSfOcQd5oPvPbp40fH1ocf+XgLUbjEbg1iyzRhghv7nmQAk8FIixt3h4fFZi8eOzXijmOfUqCQWbDc8+zMZ3dn3Z+gIPat8IyFeiItZ7EldPUNHfAhvq8rgQG6oXob11XeI5mzFWwxqWljkkVE0Px9SJ5k2o44QlLft8YIa3PuRLVKfHOD4lUHx66qQ2TJ+5KIJHErN41sQuqitUGoWSpVElWb0sikSeePFhUQ/hMhPCuPjwpHAEFEYNAp+604qp1WVINzu5ACq7Ft9EojG/jscfmRA6IygWdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8L3IPwLII6BNh0jtDgaZ9gdyeJDKSgYAmvbYCdH8K/A=;
 b=cMhlEj01f4zHW1o9Hacqt+6TIwI7e4i1q87K3MbAMKhR12LMOd0xfVqSNdkPjoWZmxP3XbltPsmAelZf1y6e5KF/isp8hEChVELcCcyzJA6uoVxZuTTmy9do46GYz0ekB/mcF3Sd8AzLaQI1Bpdh8JYBsyWA/4ZkzJnQz3rzPYDpmkV7M6+6ZvozVYNy7ITsMyM9a8ohi9qhY/pGz1vkqYmGgNhMr2SdvvsRBcWSG0rtroJq8MEJ/ZFYhBUBCjG+HJcgyh2CIl+oTvSwMDQPXfROuGRIreQv78n3Q+rGM9nTkbnSB/FoezqIPqFkbi+Q8OB3XppvvwjaT3SPz06cfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ5PPF6E320AF71.namprd11.prod.outlook.com
 (2603:10b6:a0f:fc02::833) by CY5PR11MB6211.namprd11.prod.outlook.com
 (2603:10b6:930:25::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.10; Fri, 12 Dec
 2025 10:39:32 +0000
Received: from SJ5PPF6E320AF71.namprd11.prod.outlook.com
 ([fe80::3fc5:ddc5:5858:5507]) by SJ5PPF6E320AF71.namprd11.prod.outlook.com
 ([fe80::3fc5:ddc5:5858:5507%5]) with mapi id 15.20.9412.005; Fri, 12 Dec 2025
 10:39:31 +0000
From: "Loftus, Ciara" <ciara.loftus@intel.com>
To: "Richardson, Bruce" <bruce.richardson@intel.com>
CC: "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [PATCH 02/13] net/ice: use same Tx path across processes
Thread-Topic: [PATCH 02/13] net/ice: use same Tx path across processes
Thread-Index: AQHcaP7HB1PzzyAuQ0qEI/NoAiv07LUcU8MAgAGAaMA=
Date: Fri, 12 Dec 2025 10:39:31 +0000
Message-ID: <SJ5PPF6E320AF71A1CDEBBD0F9D47C9CD1C8EAEA@SJ5PPF6E320AF71.namprd11.prod.outlook.com>
References: <20251209112652.963981-1-ciara.loftus@intel.com>
 <20251209112652.963981-3-ciara.loftus@intel.com>
 <aTqtjmjRHjphXtK2@bricha3-mobl1.ger.corp.intel.com>
In-Reply-To: <aTqtjmjRHjphXtK2@bricha3-mobl1.ger.corp.intel.com>
Accept-Language: en-IE, en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ5PPF6E320AF71:EE_|CY5PR11MB6211:EE_
x-ms-office365-filtering-correlation-id: 8b93f1b7-a795-4c08-49e5-08de396abc23
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?/Re4wdAK2FzA0rFhoZkdlCmk4RNjWkX+j7IWrBqxHOM5CUn/JmhkNY6I0BQK?=
 =?us-ascii?Q?wkfqlTpTIneIF6tAX43Dvze3TDXZVv10S4o9/Xyen9AffXm/e45t2bP1vQjN?=
 =?us-ascii?Q?WX4b7CwOOXbx+nzmSpsqFwnyL0EaPobqKFg4RQCqo3cr5qbIGfMavnVu7elu?=
 =?us-ascii?Q?CbZG8HmJj7tRfRicwCtpML26bANqmtBsQVQlN8a0ov3ttbpCFVi/azs6pv0V?=
 =?us-ascii?Q?DTm2ZO+OOmOjUP5wBVviwqlAOhXR+baAzLJEvojMDLxGC90jK6Rya2hW5Qzx?=
 =?us-ascii?Q?g/JvhaIJ2xOY2AhFqoZc1rOZRwylMtOjDkB9Z29BWzNPEHtuS8rVloqj7XQX?=
 =?us-ascii?Q?6v0OLZfAFVP79NiCeV3ABtt4kbgwPqKtlNcLJDRhTbWzSXjOlDLXPheBzUzV?=
 =?us-ascii?Q?DQhu2sBWnbM3TgMft4l5og8gYLoGkYYcL0Z0YU8xKw51A1lSudQw8snGu+N+?=
 =?us-ascii?Q?o/CigTF1r0GK3j+hjVv0+7EKa5UsCWSdSY5e/mqqJJoUEBKgmVxdNf9d5LHT?=
 =?us-ascii?Q?aba+YuF9B8HEhAii70Sdq/wmvZtKMGDRe2F4NTy8myJWC/IrOPjD+zN5Q59V?=
 =?us-ascii?Q?/a57WyVRGmzg9BNCfqDTbxhYWPDrTkv7lO0vOzpw5H5MBTFj7nIuWv7HN1t1?=
 =?us-ascii?Q?vCyVMshTYH/KKex+7ZXTR2pSY7R/8y6xnFQyY7a/C5f2xWdJJcAZM12rkPBw?=
 =?us-ascii?Q?YFh+njJ/FpwLLZIFRfXA52jPvyk7NKWuYvHnD+0t6R4MB+F+f3TTb9ST0AA5?=
 =?us-ascii?Q?1bVw6DVVRaQLv2qL99+cwTmCW9rtu2R6QzX7h1GoM3xOThp+XNAUPm8aUHEA?=
 =?us-ascii?Q?Cjv4pbi3Syqf4LFevijgVG0OG5UEyq5QrerHGUSTIPpY0ObIrf/ZmPoXlPd9?=
 =?us-ascii?Q?ZKH4wzDaSR9ABMVPVNWm+vZUvEvPEGt+RKUNIZ1tgYe3RIaeu0TBXM69D4Fs?=
 =?us-ascii?Q?Vw3yynPGAbkBooleBkDDzJzZhi4snHmBiVaQtSp05wcyXRDP1Lk+MFT5kBPA?=
 =?us-ascii?Q?iFD5e1TWc2l+sx8tgorqSlx006XGI155odv6NvfFJBk1oWfU0goDmRw5uLi1?=
 =?us-ascii?Q?aHGoJB1KfhgvyraRPJH8JHeG7HTet7iZLeM5RIrvY6GGND19BD7QZryWt95e?=
 =?us-ascii?Q?8Lwrk1okZRPxdQ5mmDdBQpDQWTTUs/eQzCw4M+4+ejix7/wxxm1NBsgF6tMv?=
 =?us-ascii?Q?MYb4t2U4nqzb5OziFzLyqwq9vUa9eM7+t5ldouTtnwAgvwUYFXPEokHWZQZn?=
 =?us-ascii?Q?HzDESA/7hS5OXKjWsnJ8UpyExhSHgw9pn42DsgfgDgHtiryg453tYCno/cU7?=
 =?us-ascii?Q?fWLzTm5zl41wEw4xtLaN/v1nxqloMbKhFNKIqPN8BKrK22m4+vrvjwjreZjR?=
 =?us-ascii?Q?WraiApCU8iGGF7fvdHnK0wbCbm+ibZOMtWzDKghuKsO/11z+DKD6PE8xON8e?=
 =?us-ascii?Q?v1Gv87/3Ew9wxxBWBDc1rHar9cq4e46Q5bO3/ATvoZKtJqjG6aihpYKC5MjM?=
 =?us-ascii?Q?f4EqAlG51/VTRK7md+SCGq2I5LIw6HPkfkLQ?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ5PPF6E320AF71.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?t5htOZHjsaAQmPVBV/KMCxo8kYI+oN6reZixuZPuiAvzvbuobrwi707Htf5z?=
 =?us-ascii?Q?L343oDGlgMbLYWejUCJaXJrW8wOCAOigB/FtyR3S64LUXzxM22wcz+hcYTeK?=
 =?us-ascii?Q?RMSrgDNWasCJymDxvNa7LKJPo0wPyS2tZqqZDNXmziKjigmlSpa+X1s48/na?=
 =?us-ascii?Q?X6CrTNSrw/+7Nc6QmyaMjT6YPdHolnR47kFADFNiYVSPngB4Ksu1aR6599Eb?=
 =?us-ascii?Q?ZNSK0JfDU3gKgHvum5JF1TwH5y/VlgGRqqIAV7TodD1NvivMpq/z6+cKMhAJ?=
 =?us-ascii?Q?XR9wrDvAmHrKbDcuSxCNh+/zD63UGbJwEVSfaFeU8npZy7emCnfsxbjxz98y?=
 =?us-ascii?Q?klvpk9hDUK0jWGpuZjDoPE4R/f9FjWgXmNQA/uTpIVe/MQk28ToJmLOZEWPA?=
 =?us-ascii?Q?EYMmOCVfDzJuawGLz79KWwX9fetmpsSjvO6tpGZQatNhHFPYDbKtI8A8pX6z?=
 =?us-ascii?Q?yjwiIfksyFsvmAgHr5MidK0K2rGal9EwS/XuXbUVoYHPaO65FWempfjslT5F?=
 =?us-ascii?Q?CBe3DkxUV8LaZ+H42RTj3g7R7FC2ySuXi4AYR6XZ+etpcN83Bdbwe1nONMC3?=
 =?us-ascii?Q?U/rjkbGQKSz2sKYCrrzjEMFoEYibJfsxR4OjpqpDsNQLjcxwl/0+eURDcuxB?=
 =?us-ascii?Q?gvZiUAGd8WU1W/UTKVsteJSzvK3J5uFTSAV10fbu0v5QLDZaeOxgrE3/Mo78?=
 =?us-ascii?Q?rXujp3/toaFzWb6GTH1PdsWo8vti5D4F1lU9xzcTQqjvBbMnOwT5hyyOG6Fj?=
 =?us-ascii?Q?h9ykk9RDBT5rHn79Ik4JeAqSvLWxSz5EAiddfjm6qTGjfqvb4/2UjgE4KXeA?=
 =?us-ascii?Q?qlgUsbOfwNf96K79FLACaQ8e19Am9zvFjz0jDuIvpyHZfKryI7+vq8VI7md/?=
 =?us-ascii?Q?yaRc1ab7O+mUCRh1AzIH775oO/OPAfqwUtbk2p9EXu1ZDppzWmQcEej9deWL?=
 =?us-ascii?Q?xR+ktQ6878HIv1yCt9KRTbnl7/R+xqvvbqL3o70ELPcBiV8c0SBl9CPWdu0R?=
 =?us-ascii?Q?/zpxA7/VopwcfnwWuA9HaZgq+t1Fu/siAlmfNo9lZ+lA74zDlbMBzFuS72Ii?=
 =?us-ascii?Q?+xvu9kVU7bQepGo+/mDQRNPevwKAibUx4UIaFLvgM/fPs+E4ruFPY72AXcsu?=
 =?us-ascii?Q?ja1Z65pLJE4EBUfyZyVuJ/PnZu4iy+6UjQYpWlHvq6dP7+OjLbC4iUKDtvc+?=
 =?us-ascii?Q?uZUO6h7nkWBsVYjAuYBi2Ye2xFxY1ps2jVCs5xu0TI9klBCRwq0UQq9JCbJ4?=
 =?us-ascii?Q?sQYxA/N/3cTGZjLLv7lhlxtCW5mkQj5kUjVxP1BaJDIAq9aw3oWER2sAQCb1?=
 =?us-ascii?Q?4IV/N94EX6b8iD345ix/C6heyQHHEi1V4Et6IqujBnn08zUvjHOAZiWGBjdy?=
 =?us-ascii?Q?CywOMfOc9nKML7470scrmYSIAIbtv8qQfIbHPriOHUStPcU7XrN4t8bZ6cxQ?=
 =?us-ascii?Q?U0IRO59IAVh8LEMiqo0hwCdMHIkoWOX7W6jL/MjceIj3c0dp1UO6z8kdm8KH?=
 =?us-ascii?Q?rXScd/e7kcjZtBNyfmxD+zrAF3RklYsOerlty4DrJvUYher9spFEW5Yjsghg?=
 =?us-ascii?Q?sUk1I7k/lE1hNhF9SMHXXuObcWtWdkM89cS2zXYB?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ5PPF6E320AF71.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b93f1b7-a795-4c08-49e5-08de396abc23
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2025 10:39:31.8834 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8nf+h4U2YgMnhF7I74N6a6FLWAFAN1vgxbYx0KtrDH1czWdJ7Fr0RP7kJJxUXrHCzvH+yZmNqcLatAhX9GN3Ig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6211
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
> On Tue, Dec 09, 2025 at 11:26:41AM +0000, Ciara Loftus wrote:
> > In the interest of simplicity, let the primary process select the Tx
> > path to be used by all processes using the given device.
> >
> > The many logs which report individual Tx path selections have been
> > consolidated into one single log.
> >
> > Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
> > ---
> >  drivers/net/intel/ice/ice_ethdev.c |   1 +
> >  drivers/net/intel/ice/ice_ethdev.h |  12 ++-
> >  drivers/net/intel/ice/ice_rxtx.c   | 139 ++++++++++++++++-------------
> >  3 files changed, 87 insertions(+), 65 deletions(-)
> >
> > diff --git a/drivers/net/intel/ice/ice_ethdev.c
> b/drivers/net/intel/ice/ice_ethdev.c
> > index c721d135f5..a805e78d03 100644
> > --- a/drivers/net/intel/ice/ice_ethdev.c
> > +++ b/drivers/net/intel/ice/ice_ethdev.c
> > @@ -3900,6 +3900,7 @@ ice_dev_configure(struct rte_eth_dev *dev)
> >  	ad->tx_simple_allowed =3D true;
> >
> >  	ad->rx_func_type =3D ICE_RX_DEFAULT;
> > +	ad->tx_func_type =3D ICE_TX_DEFAULT;
> >
> >  	if (dev->data->dev_conf.rxmode.mq_mode &
> RTE_ETH_MQ_RX_RSS_FLAG)
> >  		dev->data->dev_conf.rxmode.offloads |=3D
> RTE_ETH_RX_OFFLOAD_RSS_HASH;
> > diff --git a/drivers/net/intel/ice/ice_ethdev.h
> b/drivers/net/intel/ice/ice_ethdev.h
> > index 72ed65f13b..0b8af339d1 100644
> > --- a/drivers/net/intel/ice/ice_ethdev.h
> > +++ b/drivers/net/intel/ice/ice_ethdev.h
> > @@ -208,6 +208,16 @@ enum ice_rx_func_type {
> >  	ICE_RX_AVX512_SCATTERED_OFFLOAD,
> >  };
> >
> > +enum ice_tx_func_type {
> > +	ICE_TX_DEFAULT,
> > +	ICE_TX_SIMPLE,
> > +	ICE_TX_SSE,
> > +	ICE_TX_AVX2,
> > +	ICE_TX_AVX2_OFFLOAD,
> > +	ICE_TX_AVX512,
> > +	ICE_TX_AVX512_OFFLOAD,
> > +};
> > +
> >  struct ice_adapter;
> >
> >  /**
> > @@ -658,6 +668,7 @@ struct ice_adapter {
> >  	bool tx_vec_allowed;
>=20
> Can tx_vec_allowed by dropped at this point?

In this driver I don't think so, as it's used during ice_tx_done_cleanup() =
to select
the appropriate cleanup function. If we were to remove it we would need to
evaluate something like the following every time instead of using the bool:

ice_tx_path_infos[ad->tx_func_type].features.simd_width >=3D RTE_VECT_SIMD_=
128

>=20
> >  	bool tx_simple_allowed;
> >  	enum ice_rx_func_type rx_func_type;
> > +	enum ice_tx_func_type tx_func_type;
> >  	/* ptype mapping table */
> >  	alignas(RTE_CACHE_LINE_MIN_SIZE) uint32_t
> ptype_tbl[ICE_MAX_PKT_TYPE];
> >  	bool is_safe_mode;
> > @@ -679,7 +690,6 @@ struct ice_adapter {
> >  	/* Set bit if the engine is disabled */
> >  	unsigned long disabled_engine_mask;
> >  	struct ice_parser *psr;
> > -	enum rte_vect_max_simd tx_simd_width;
> >  	bool rx_vec_offload_support;
> >  };
> >
> > diff --git a/drivers/net/intel/ice/ice_rxtx.c b/drivers/net/intel/ice/i=
ce_rxtx.c
> > index 74db0fbec9..f05ca83e5b 100644
> > --- a/drivers/net/intel/ice/ice_rxtx.c
> > +++ b/drivers/net/intel/ice/ice_rxtx.c
> > @@ -4091,6 +4091,44 @@ ice_prep_pkts(void *tx_queue, struct rte_mbuf
> **tx_pkts,
> >  	return i;
> >  }
> >
> > +static const struct {
> > +	eth_tx_burst_t pkt_burst;
> > +	const char *info;
> > +} ice_tx_burst_infos[] =3D {
> > +	[ICE_TX_DEFAULT] =3D {
> > +		.pkt_burst =3D ice_xmit_pkts,
> > +		.info =3D "Scalar"
> > +	},
> > +	[ICE_TX_SIMPLE] =3D {
> > +		.pkt_burst =3D ice_xmit_pkts_simple,
> > +		.info =3D "Scalar Simple"
> > +	},
> > +#ifdef RTE_ARCH_X86
> > +	[ICE_TX_SSE] =3D {
> > +		.pkt_burst =3D ice_xmit_pkts_vec,
> > +		.info =3D "Vector SSE"
> > +	},
> > +	[ICE_TX_AVX2] =3D {
> > +		.pkt_burst =3D ice_xmit_pkts_vec_avx2,
> > +		.info =3D "Vector AVX2"
> > +	},
> > +	[ICE_TX_AVX2_OFFLOAD] =3D {
> > +		.pkt_burst =3D ice_xmit_pkts_vec_avx2_offload,
> > +		.info =3D "Offload Vector AVX2"
> > +	},
> > +#ifdef CC_AVX512_SUPPORT
> > +	[ICE_TX_AVX512] =3D {
> > +		.pkt_burst =3D ice_xmit_pkts_vec_avx512,
> > +		.info =3D "Vector AVX512"
> > +	},
> > +	[ICE_TX_AVX512_OFFLOAD] =3D {
> > +		.pkt_burst =3D ice_xmit_pkts_vec_avx512_offload,
> > +		.info =3D "Offload Vector AVX512"
> > +	},
> > +#endif
> > +#endif
> > +};
> > +
> >  void __rte_cold
> >  ice_set_tx_function(struct rte_eth_dev *dev)
> >  {
> > @@ -4101,74 +4139,58 @@ ice_set_tx_function(struct rte_eth_dev *dev)
> >  	struct ci_tx_queue *txq;
> >  	int i;
> >  	int tx_check_ret =3D -1;
> > +	enum rte_vect_max_simd tx_simd_width =3D
> RTE_VECT_SIMD_DISABLED;
> >
> > -	if (rte_eal_process_type() =3D=3D RTE_PROC_PRIMARY) {
> > -		ad->tx_simd_width =3D RTE_VECT_SIMD_DISABLED;
> > -		tx_check_ret =3D ice_tx_vec_dev_check(dev);
> > -		ad->tx_simd_width =3D ice_get_max_simd_bitwidth();
> > -		if (tx_check_ret >=3D 0 &&
> > -		    rte_vect_get_max_simd_bitwidth() >=3D
> RTE_VECT_SIMD_128) {
> > -			ad->tx_vec_allowed =3D true;
> > -
> > -			if (ad->tx_simd_width < RTE_VECT_SIMD_256 &&
> > -				tx_check_ret =3D=3D
> ICE_VECTOR_OFFLOAD_PATH)
> > -				ad->tx_vec_allowed =3D false;
> > -
> > -			if (ad->tx_vec_allowed) {
> > -				for (i =3D 0; i < dev->data->nb_tx_queues; i++) {
> > -					txq =3D dev->data->tx_queues[i];
> > -					if (txq && ice_txq_vec_setup(txq)) {
> > -						ad->tx_vec_allowed =3D false;
> > -						break;
> > -					}
> > +	/* The primary process selects the tx path for all processes. */
> > +	if (rte_eal_process_type() !=3D RTE_PROC_PRIMARY)
> > +		goto out;
> > +
> > +	tx_check_ret =3D ice_tx_vec_dev_check(dev);
> > +	tx_simd_width =3D ice_get_max_simd_bitwidth();
> > +	if (tx_check_ret >=3D 0 &&
> > +		rte_vect_get_max_simd_bitwidth() >=3D RTE_VECT_SIMD_128)
> {
> > +		ad->tx_vec_allowed =3D true;
> > +
> > +		if (tx_simd_width < RTE_VECT_SIMD_256 &&
> > +			tx_check_ret =3D=3D ICE_VECTOR_OFFLOAD_PATH)
> > +			ad->tx_vec_allowed =3D false;
> > +
> > +		if (ad->tx_vec_allowed) {
> > +			for (i =3D 0; i < dev->data->nb_tx_queues; i++) {
> > +				txq =3D dev->data->tx_queues[i];
> > +				if (txq && ice_txq_vec_setup(txq)) {
> > +					ad->tx_vec_allowed =3D false;
> > +					break;
> >  				}
> >  			}
> > -		} else {
> > -			ad->tx_vec_allowed =3D false;
> >  		}
> > +	} else {
> > +		ad->tx_vec_allowed =3D false;
> >  	}
> >
> >  	if (ad->tx_vec_allowed) {
> >  		dev->tx_pkt_prepare =3D rte_eth_tx_pkt_prepare_dummy;
> > -		if (ad->tx_simd_width =3D=3D RTE_VECT_SIMD_512) {
> > +		if (tx_simd_width =3D=3D RTE_VECT_SIMD_512) {
> >  #ifdef CC_AVX512_SUPPORT
> >  			if (tx_check_ret =3D=3D ICE_VECTOR_OFFLOAD_PATH) {
> > -				PMD_DRV_LOG(NOTICE,
> > -					    "Using AVX512 OFFLOAD Vector Tx
> (port %d).",
> > -					    dev->data->port_id);
> > -				dev->tx_pkt_burst =3D
> > -					ice_xmit_pkts_vec_avx512_offload;
> > +				ad->tx_func_type =3D
> ICE_TX_AVX512_OFFLOAD;
> >  				dev->tx_pkt_prepare =3D ice_prep_pkts;
> >  			} else {
> > -				PMD_DRV_LOG(NOTICE,
> > -					    "Using AVX512 Vector Tx (port
> %d).",
> > -					    dev->data->port_id);
> > -				dev->tx_pkt_burst =3D
> ice_xmit_pkts_vec_avx512;
> > +				ad->tx_func_type =3D ICE_TX_AVX512;
> >  			}
> >  #endif
> >  		} else {
> >  			if (tx_check_ret =3D=3D ICE_VECTOR_OFFLOAD_PATH) {
> > -				PMD_DRV_LOG(NOTICE,
> > -					    "Using AVX2 OFFLOAD Vector Tx
> (port %d).",
> > -					    dev->data->port_id);
> > -				dev->tx_pkt_burst =3D
> > -					ice_xmit_pkts_vec_avx2_offload;
> > +				ad->tx_func_type =3D ICE_TX_AVX2_OFFLOAD;
> >  				dev->tx_pkt_prepare =3D ice_prep_pkts;
> >  			} else {
> > -				PMD_DRV_LOG(DEBUG, "Using %sVector Tx
> (port %d).",
> > -					    ad->tx_simd_width =3D=3D
> RTE_VECT_SIMD_256 ? "avx2 " : "",
> > -					    dev->data->port_id);
> > -				dev->tx_pkt_burst =3D ad->tx_simd_width =3D=3D
> RTE_VECT_SIMD_256 ?
> > -						    ice_xmit_pkts_vec_avx2 :
> > -						    ice_xmit_pkts_vec;
> > +				ad->tx_func_type =3D tx_simd_width =3D=3D
> RTE_VECT_SIMD_256 ?
> > +						    ICE_TX_AVX2 :
> > +						    ICE_TX_SSE;
> >  			}
> >  		}
> >
> > -		if (mbuf_check) {
> > -			ad->tx_pkt_burst =3D dev->tx_pkt_burst;
> > -			dev->tx_pkt_burst =3D ice_xmit_pkts_check;
> > -		}
> > -		return;
> > +		goto out;
> >  	}
> >  #endif
> >
> > @@ -4186,24 +4208,13 @@ ice_set_tx_function(struct rte_eth_dev *dev)
> >  		ad->tx_pkt_burst =3D dev->tx_pkt_burst;
> >  		dev->tx_pkt_burst =3D ice_xmit_pkts_check;
> >  	}
> > -}
> >
> > -static const struct {
> > -	eth_tx_burst_t pkt_burst;
> > -	const char *info;
> > -} ice_tx_burst_infos[] =3D {
> > -	{ ice_xmit_pkts_simple,   "Scalar Simple" },
> > -	{ ice_xmit_pkts,          "Scalar" },
> > -#ifdef RTE_ARCH_X86
> > -#ifdef CC_AVX512_SUPPORT
> > -	{ ice_xmit_pkts_vec_avx512, "Vector AVX512" },
> > -	{ ice_xmit_pkts_vec_avx512_offload, "Offload Vector AVX512" },
> > -#endif
> > -	{ ice_xmit_pkts_vec_avx2,         "Vector AVX2" },
> > -	{ ice_xmit_pkts_vec_avx2_offload, "Offload Vector AVX2" },
> > -	{ ice_xmit_pkts_vec,              "Vector SSE" },
> > -#endif
> > -};
>=20
> Looking at the code with this patch applied, I think there may be an issu=
e
> with the scalar case in this version. At line 4197 we have a block which
> assigns a value to tx_pkt_burst and tx_burst_prepare, but does not assign=
 a
> value to the tx_func_type values. That means when it falls through into t=
he
> "out" section, the function point for pkt_burst get overwritten.

This should be fixed in the v2.

>=20
> > +out:
> > +	dev->tx_pkt_burst =3D mbuf_check ? ice_xmit_pkts_check :
> > +					 ice_tx_burst_infos[ad-
> >tx_func_type].pkt_burst;
> > +	PMD_DRV_LOG(NOTICE, "Using %s (port %d).",
> > +		ice_tx_burst_infos[ad->tx_func_type].info, dev->data-
> >port_id);
> > +}
> >
> >  int
> >  ice_tx_burst_mode_get(struct rte_eth_dev *dev, __rte_unused uint16_t
> queue_id,
> > --
> > 2.43.0
> >
