Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63A9ECAC5AE
	for <dpdk-dev@archiver.kernel.org>; Fri, 26 Sep 2025 08:11:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A750A40262;
	Fri, 26 Sep 2025 10:11:23 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id D8AB74025D
 for <dev@dpdk.org>; Fri, 26 Sep 2025 10:11:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1758874282; x=1790410282;
 h=from:to:subject:date:message-id:references:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=sYFklxeDgz+GMPP7AXrDyacvtry9Nxryqrf+0W6WIHE=;
 b=nhcEYhvHK3ZrZUjK4mYGj09oCkA9x7+mrV71A8lZgSF5sIZlaXJ3Fb8W
 0HryvXxaeetzv706nGXHr/jvI969dnQYCG0yX5TbAY/NbaZ14qaaLpBUI
 cY/D+nFNXP3MhQtBKAlV8SBBogulQ3Ttol7R1Pekxkpk6J0tM+c/pvT19
 dpvk1tN54B+1RZlbNzIc3GRfY5e+rm0hov7ts0PC/KzasDzAhPZ/OSq+J
 p1bPkW/CX7Eg4py3X3ukiiEIKpZ8r2qHlv6QM8O1yXJJTeOWg5whNw4Zl
 fBGc5lAFEzXD+m9v8MERaudulHjYmiB50jF76bXYBdBlA3hGtp98DMTaQ g==;
X-CSE-ConnectionGUID: uVP34j3ATLKB2iQYxdXlrg==
X-CSE-MsgGUID: NV2XAYl9QYCQEx6lZS/nIg==
X-IronPort-AV: E=McAfee;i="6800,10657,11564"; a="61093784"
X-IronPort-AV: E=Sophos;i="6.18,294,1751266800"; d="scan'208";a="61093784"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Sep 2025 01:11:17 -0700
X-CSE-ConnectionGUID: AHxcORiJRI+d5W2ETw1PWg==
X-CSE-MsgGUID: 8jPH/7I6Q2SRTDNQrTnfOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,294,1751266800"; d="scan'208";a="182832249"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Sep 2025 01:11:16 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 26 Sep 2025 01:11:16 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Fri, 26 Sep 2025 01:11:16 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.20)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 26 Sep 2025 01:11:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kn5leqMCsHYEVwEkWq3blN6evJ8pN7MiBFUlW5CNdIL/XEZJ0QdUBTtkK14u4Tuj205iyCsyhZsJix1kNJMLqdhtb5YWjoy/ZSuqIeBP+0P4KuQCrVDzEN8fuR1gNGMsQXht+JVoDnN1E7pCjpGDBAZX5HHWt5XvyutzKaWBQRxmxXqAb83nRrgfCSGoo2oTQDwqcg7aEJs9NwDu9iUiwggGG2hyq2FVIvjzRY8G6v7b14U6ckKiRLR+IFmwfDCPEUKIrq1llHOV3zUeiVbrz3pvsRc7m/50Nu0lsDrMYsC5hADYi3K1riddY6QEknQcMkXtEWOZgnfCtodZjNDZFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9KZIdiiGKMt3V9T+hB/4ALoj/3Ix2ja1QvpvlBqoVtY=;
 b=F8oYb6mzc6Mpx9MbWELwwgSxHnHrOobiGlkX1fhDKowoEt2y87ARitHO2xsTXuqawjnDLnALhxJUuSyes/E+QAyL4cOKI+nfvjykmRTNPxw0H+xmBg3Fq70sJOjsdo1VcwVZvvtOTUx4uvN1o5hX6TiQsMTNXTRz4cluA2maGhH1VTlJmU3jUFp5awLTqa/oLIqPIu2PCzezbzox7ZMAXdDSztjkUEtuKfn52cuDSuhapIb2XWxBQvFL7aVHHdHq6zcr937UEb/0fTAbei9NiyDM6UQuncVesOSZSYmxT871QeZC4QkAVQbS28L2wnzsE5xMp9P5tlIY2ZuXe4tTzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM3PPF291EF9BF1.namprd11.prod.outlook.com
 (2603:10b6:f:fc00::f15) by MW4PR11MB5821.namprd11.prod.outlook.com
 (2603:10b6:303:184::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.19; Fri, 26 Sep
 2025 08:11:08 +0000
Received: from DM3PPF291EF9BF1.namprd11.prod.outlook.com
 ([fe80::576b:ce1f:299d:677d]) by DM3PPF291EF9BF1.namprd11.prod.outlook.com
 ([fe80::576b:ce1f:299d:677d%4]) with mapi id 15.20.9137.017; Fri, 26 Sep 2025
 08:11:08 +0000
From: "Shetty, Praveen" <praveen.shetty@intel.com>
To: "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [PATCH v3 4/4] net/cpfl: add cpchnl get vport info support
Thread-Topic: [PATCH v3 4/4] net/cpfl: add cpchnl get vport info support
Thread-Index: AQHcLG0dm8L4Oew7CkWmPc8Khrf6GrSlINWg
Date: Fri, 26 Sep 2025 08:11:08 +0000
Message-ID: <DM3PPF291EF9BF11F8AEBE720965B1550439D1EA@DM3PPF291EF9BF1.namprd11.prod.outlook.com>
References: <20250922141058.1390212-2-praveen.shetty@intel.com>
 <20250923125455.1484992-1-praveen.shetty@intel.com>
 <20250923125455.1484992-5-praveen.shetty@intel.com>
In-Reply-To: <20250923125455.1484992-5-praveen.shetty@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PPF291EF9BF1:EE_|MW4PR11MB5821:EE_
x-ms-office365-filtering-correlation-id: 62de3975-1e78-4bb8-a95b-08ddfcd43f57
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?tPyJKRX6MAg7jbg8dOpWXKNe2igx4o5Cu4JmIEVuQE/bBT0Bwcpc7prqTQFX?=
 =?us-ascii?Q?U2jPsE0pxXV8wdQXn2Z85UmJB8AiPELvtLD01ZEpcG9xJo+d6MklpcmjoELB?=
 =?us-ascii?Q?G0WrigvyBtTTlxuzVJuJvcJILRo/UTDLWLuYr1R7ryk6DI08UzgU/UJkbZ+K?=
 =?us-ascii?Q?A+Y7OBZy3Rg9D5g5i/pdkjug+eMGLu16UUsVDct+eqjb4FtombYag+jnep6D?=
 =?us-ascii?Q?ijy/TWe4xTHQcBsjlucdjaD4b7gewI8Tgp32qa6EyV5HrkQ7kz3ZdWR8Y+xi?=
 =?us-ascii?Q?qxxyfutQX0NhfUsoFxeTlMJUAApEnMf3/qJjDaQMYz6sdieR9Xb7YhUBfEPd?=
 =?us-ascii?Q?KdNSoc4I/r3TlTPniHz7uxsC4r+SyWP6nYgk3JyrauNGUl+WMhEc2ry5YLtX?=
 =?us-ascii?Q?oihBE935BS8sYT2SrJIN8WZUjwyd4q20vt0BbhpsGpYsB1pBo+eQF2pu5OIM?=
 =?us-ascii?Q?wwwS0ZDqAXTpIGQGqujrwec8UU44ZglDungawZm6el5cy+GIdo2MfzbAKYlf?=
 =?us-ascii?Q?aVtgeguT3zyz2Wpqje6Rkyt6i3PF6oG7tTiACMJi2uRmHYXIa/HAj6IMq3Bi?=
 =?us-ascii?Q?EFIRkWZrvUTkY1u3BAsThTY1ZIllazhgG8khhq59yfZctRhXXYXpXiddaKvC?=
 =?us-ascii?Q?LfFvznB2BdeINJL50ISBEjBcQXD0OVJ4XUCfPWdqiTp+SBjskLf08Ql9A8Wt?=
 =?us-ascii?Q?HL7jJgplrNf8+P4cErk3x3VxxnjOIkI5GPGakdZ/iGjU5UBa5bYSqH2/7J1D?=
 =?us-ascii?Q?Ap+UbYvRKu3npt36wjrIj+SdyLK/xHRmFUE5cT8Tbg0z5gZewR6ChZFkBgLq?=
 =?us-ascii?Q?PqrVydl1KV+qXHGMfi9akV2JzGsbLMXAPl77w1uzbGPGDR1i3o1xFRMeUg6P?=
 =?us-ascii?Q?n52C6EN+cRRYWaFwM/DFhy0eAWqZchR0a1KMtgNaphnL2PTSdnPFfQF3jhkH?=
 =?us-ascii?Q?lyWYjZmDNy5YGttVZbYExOZq+aQyO5RYa2TBcDsy8EmLo8EWW7iDDOYneiuD?=
 =?us-ascii?Q?r2s09e1gM+DgEvhJVYqIdk6UbGVbYSsHgkbovbhi7h/gfxhWMaz1tQhZuYL1?=
 =?us-ascii?Q?zEDGToTDS2J6jnnK81tdg3849kHwkv+oItdOLkRGwxxJk3kvZNWHr3DFdGrn?=
 =?us-ascii?Q?MfbzxSjc8EC1VJ8r/Bt+GuxCaCsQdOXiVpJNl7/IFlI1ygFmD2bGfbvQ7Ex+?=
 =?us-ascii?Q?7ZmDL9Cl+yjhQ0QzKixl2Sv9uX0TefDkS8Q9XRnLOLsYiZfpyinWtEOg3tzQ?=
 =?us-ascii?Q?uu6l2m4KYSKSoVUBKykM5WigClynaNI3mnUHHhL20DOQliF9bF9mNnseR/D1?=
 =?us-ascii?Q?UyVNR2JJxHxWUn5Pkn6gmMiyXWJzcmSajJgOOtzlTdPeT3G1qWp2+rdeHDbk?=
 =?us-ascii?Q?Fpwr0L2JE39Xz86Gl4/6VDrrAMA1Dbqyh9vdXtR2eM9p7NBIWqim4dyA+tIw?=
 =?us-ascii?Q?SzZxA4OTTRBTcPXD4bCahhK2o1R8z30uO01Y+7MkzY3MRQiApuTLcg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM3PPF291EF9BF1.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?NgOJTqfw9aB3CJj6UfWKMNdA5w8gCGSbpl5TmD0kL6xp20Fk46qGUkggyTjr?=
 =?us-ascii?Q?UMNZ8752uFLLTtr0XlZEGQNEGWUqXWg76POIpJvYalFWkmMs1Yxa55OoJSQF?=
 =?us-ascii?Q?71T5OrX0acqbhT6ac0qwZy2HCING6kPFl2xxFJyIZDcsix3TC/niyjU6HgKx?=
 =?us-ascii?Q?raaX7dMm/6DBfGlxPLVyVoGtowHuz3d6Gl+J9zGShtQZFvrtekgO7e8nILa8?=
 =?us-ascii?Q?sMKuocVPXMLDZAfMeqPZQolwWLEIp6VByhEGOQUOXWarvnmW/6TjuqFfcPrS?=
 =?us-ascii?Q?deEom/uogJM7YvL+VoWyJ48hH3i5SpEJVb5Rf+lfG0HoYH0T9Ns8YOeddMyI?=
 =?us-ascii?Q?huywqQ2I1IuwZ3FBGbisMBmiXufFTM0E6gM/B935Uo7cqjq61iyZGAn1XQGT?=
 =?us-ascii?Q?1Kvo2MsQUq4vGULgIxgVkI6wKPvvPkYm8aYlSIdsIMpDzpdodqq2VB7oIMwj?=
 =?us-ascii?Q?oCB9MSkF92Lt9ngimeR57wX7m0D7jTogFMOYG23ioTenO8cWtBkkAwR4bb8Y?=
 =?us-ascii?Q?F+PLeAOK6cQm4j7zzzZiW/IyL+FyF+aP8UcmkMj9izHR9WepHzw0Gfo0giWZ?=
 =?us-ascii?Q?AaYBV/s05jnzqi/VGRTjg4ezQx9611VIEl1WFMxpjN4viXKrC2q4n5HebAI1?=
 =?us-ascii?Q?uqwcMTdDzBsBc4WPlqHhwDT/00eZeKIuNQcJocU5dmevnJROwNv21EbZlat0?=
 =?us-ascii?Q?/KFisxBtjONAiuStbo0Y9O7VQtlSjG7j8O3UUx6+b90zuQeyfITCUbY/kRpR?=
 =?us-ascii?Q?PRAED9pAUmGYFo+97xuFGLAoDK7D2QZ3N4Rnj9kXdLUauzVTXFAdr1ZEa9jN?=
 =?us-ascii?Q?jbkC9vPfw/FBHOEgnACYQX6b7ckG7GH+HFk85O/W/rreYzhjE21rYRJXbmpQ?=
 =?us-ascii?Q?5L9bKWdnTBJtSIkU0tMWmfk39PAk2TBUiY3wm9QfXyGf97dJJLIGy3Lvg7sZ?=
 =?us-ascii?Q?dUt7fU22LNiTP+GnaQkQ6qF3WMU2t6/NWoG/UqDgIJdgiR86SValxT9EumUS?=
 =?us-ascii?Q?ZHhV+X58hJeGcX5Wkhcqedt6Im0e1VctVik2azWVLXwyFmkTIAkWPvcbhrNm?=
 =?us-ascii?Q?Cj3UY7BaMM6PO9XNR3blU8KcP9QMstydMjnOhyU7HbW76/AnSsGIKbbV3ftO?=
 =?us-ascii?Q?PvD7MykeUzfLg/6YKVrA28qXrDPv1O6zz2ng6qSPMBFGHLsCM3cIK3WLxTA6?=
 =?us-ascii?Q?S+ZyVTbpwzXxjQQZYx2lZPWj9FFxOOm0EFi6u2qXzy2Yk4rBT6jStWNi7+C4?=
 =?us-ascii?Q?2ZZQS4yPvLjOxDBs2ttp+ovmj9b8851CB807Vw648d4oi5Pv2hK7qFhFDNeC?=
 =?us-ascii?Q?JnxJGQfFWIIhoASTwGmKpQv03jXmGhpC1tC55M4I7yTBD0aPbTGs4qEro1pm?=
 =?us-ascii?Q?LbkVwj0vQQH03sxzQgv/ixKP8c+dsx83Xzb/z/iQH4SuNqfpruC/f7uG3qPT?=
 =?us-ascii?Q?86ZodnNgfPnXGk/CDNZ5ZGA0Oox+FC9P6jsivRRckj0mn1DZPYplEVl+fhlW?=
 =?us-ascii?Q?39+dvHxO1/rBToinp75bJm6jaFjoztpX0O+8uRc5I9vCXhcK6hq4aZe9xC0q?=
 =?us-ascii?Q?j31I78vV5KAgwwFAIhEDh+XwjA5dF0qNuStg0bpe?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM3PPF291EF9BF1.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62de3975-1e78-4bb8-a95b-08ddfcd43f57
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2025 08:11:08.2289 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7SU8QYvnLV46r4W3PrTfEKpONXvRYRNkAZJtn5U0gVz0bLNAHBfJkhceFeJ0ox2+K7VSa5lYLdkRM8/cRG+QO1ohKaPBAi/DR97eTjz71SM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5821
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

From: Praveen Shetty <praveen.shetty@intel.com>

vCPF will only receive the relative queue id from the FW.
CPCHNL2_OP_GET_VPORT_INFO cpchnl message is used to get the absolute rx/tx =
queue id and vsi of its own vport.
This patch will add the support to call CPCHNL2_OP_GET_VPORT_INFO cpchnl me=
ssage from the vCPF PMD.

Signed-off-by: Praveen Shetty <praveen.shetty@intel.com>
Signed-off-by: Dhananjay Shukla <dhananjay.shukla@intel.com>
Signed-off-by: Atul Patel <Atul.Patel@intel.com>
---
 drivers/net/intel/cpfl/cpfl_cpchnl.h |  8 ++++  drivers/net/intel/cpfl/cpf=
l_ethdev.c | 63 +++++++++++++++++++++++++  drivers/net/intel/cpfl/cpfl_ethd=
ev.h | 70 +++++++++++++++++++++-------
 3 files changed, 125 insertions(+), 16 deletions(-)

diff --git a/drivers/net/intel/cpfl/cpfl_cpchnl.h b/drivers/net/intel/cpfl/=
cpfl_cpchnl.h
index 0c9dfcdbf1..c56d3e6cea 100644
--- a/drivers/net/intel/cpfl/cpfl_cpchnl.h
+++ b/drivers/net/intel/cpfl/cpfl_cpchnl.h
@@ -140,6 +140,14 @@ enum cpchnl2_func_type {
 	CPCHNL2_FTYPE_LAN_MAX
 };
=20
+/**
+ * @brief function types
+ */
+enum vcpf_cpchnl2_func_type {
+	VCPF_CPCHNL2_FTYPE_LAN_PF =3D 0,
+	VCPF_CPCHNL2_FTYPE_LAN_VF =3D 1,
+};
+
 /**
  * @brief containing vport id & type
  */
diff --git a/drivers/net/intel/cpfl/cpfl_ethdev.c b/drivers/net/intel/cpfl/=
cpfl_ethdev.c
index c411a2a024..7b7e21afa6 100644
--- a/drivers/net/intel/cpfl/cpfl_ethdev.c
+++ b/drivers/net/intel/cpfl/cpfl_ethdev.c
@@ -1902,6 +1902,43 @@ cpfl_dev_alarm_handler(void *param)
 	rte_eal_alarm_set(CPFL_ALARM_INTERVAL, cpfl_dev_alarm_handler, adapter); =
 }
=20
+static
+int vcpf_save_vport_info_response(struct cpfl_vport *cpfl_vport,
+		struct cpchnl2_get_vport_info_response *response) {
+	struct cpchnl2_vport_info *info;
+	struct vcpf_vport_info *vport_info;
+	struct cpchnl2_queue_group_info *qgp;
+	struct cpchnl2_queue_chunk *q_chnk;
+	u16 num_queue_groups;
+	u16 num_chunks;
+	u32 q_type;
+
+	info =3D &response->info;
+	vport_info =3D &cpfl_vport->vport_info;
+	vport_info->vport_index =3D info->vport_index;
+	vport_info->vsi_id =3D info->vsi_id;
+
+	num_queue_groups =3D response->queue_groups.num_queue_groups;
+	for (u16 i =3D 0; i < num_queue_groups; i++) {
+		qgp =3D &response->queue_groups.groups[i];
+		num_chunks =3D qgp->chunks.num_chunks;
+		/* rx q and tx q are stored in first 2 chunks */
+		for (u16 j =3D 0; j < (num_chunks - 2); j++) {
+			q_chnk =3D &qgp->chunks.chunks[j];
+			q_type =3D q_chnk->type;
+			if (q_type =3D=3D VIRTCHNL2_QUEUE_TYPE_TX) {
+				vport_info->abs_start_txq_id =3D q_chnk->start_queue_id;
+				vport_info->num_tx_q =3D q_chnk->num_queues;
+			} else if (q_type =3D=3D VIRTCHNL2_QUEUE_TYPE_RX) {
+				vport_info->abs_start_rxq_id =3D q_chnk->start_queue_id;
+				vport_info->num_rx_q =3D q_chnk->num_queues;
+			}
+		}
+	}
+	return 0;
+}
+
 static int
 cpfl_stop_cfgqs(struct cpfl_adapter_ext *adapter)  { @@ -2720,7 +2757,11 @=
@ cpfl_dev_vport_init(struct rte_eth_dev *dev, void *init_params)
 	/* for sending create vport virtchnl msg prepare */
 	struct virtchnl2_create_vport create_vport_info;
 	struct virtchnl2_add_queue_groups p2p_queue_grps_info;
+	struct cpchnl2_get_vport_info_response response;
 	uint8_t p2p_q_vc_out_info[IDPF_DFLT_MBX_BUF_SIZE] =3D {0};
+	struct cpfl_vport_id vi;
+	struct cpchnl2_vport_id v_id;
+	struct rte_pci_device *pci_dev =3D RTE_DEV_TO_PCI(dev->device);
 	int ret =3D 0;
=20
 	dev->dev_ops =3D &cpfl_eth_dev_ops;
@@ -2790,6 +2831,28 @@ cpfl_dev_vport_init(struct rte_eth_dev *dev, void *i=
nit_params)
 			cpfl_p2p_queue_grps_del(vport);
 		}
 	}
+	/* get the vport info */
+	if (adapter->base.hw.device_id =3D=3D IXD_DEV_ID_VCPF) {
+		pci_dev =3D RTE_DEV_TO_PCI(dev->device);
+		vi.func_type =3D VCPF_CPCHNL2_FTYPE_LAN_VF;
+		vi.pf_id =3D CPFL_HOST0_CPF_ID;
+		vi.vf_id =3D pci_dev->addr.function;
+
+		v_id.vport_id =3D cpfl_vport->base.vport_info.info.vport_id;
+		v_id.vport_type =3D cpfl_vport->base.vport_info.info.vport_type;
+
+		ret =3D cpfl_cc_vport_info_get(adapter, &v_id, &vi, &response);
+		if (ret !=3D 0) {
+			PMD_INIT_LOG(ERR, "Failed to send vport info cpchnl message.");
+			return -1;
+		}
+
+		ret =3D vcpf_save_vport_info_response(cpfl_vport, &response);
+		if (ret !=3D 0) {
+			PMD_INIT_LOG(ERR, "Failed to save cpchnl response.");
+			return -1;
+		}
+	}
=20
 	return 0;
=20
diff --git a/drivers/net/intel/cpfl/cpfl_ethdev.h b/drivers/net/intel/cpfl/=
cpfl_ethdev.h
index 81f223eef5..90b9e05819 100644
--- a/drivers/net/intel/cpfl/cpfl_ethdev.h
+++ b/drivers/net/intel/cpfl/cpfl_ethdev.h
@@ -165,10 +165,20 @@ struct cpfl_itf {
 	void *data;
 };
=20
+struct vcpf_vport_info {
+	u16 vport_index;
+	u16 vsi_id;
+	u32 abs_start_txq_id;
+	u32 num_tx_q;
+	u32 abs_start_rxq_id;
+	u32 num_rx_q;
+};
+
 struct cpfl_vport {
 	struct cpfl_itf itf;
 	struct idpf_vport base;
 	struct p2p_queue_chunks_info *p2p_q_chunks_info;
+	struct vcpf_vport_info vport_info;
=20
 	struct rte_mempool *p2p_mp;
=20
@@ -320,6 +330,7 @@ cpfl_get_vsi_id(struct cpfl_itf *itf)
 	uint32_t vport_id;
 	int ret;
 	struct cpfl_vport_id vport_identity;
+	u16 vsi_id =3D 0;
=20
 	if (!itf)
 		return CPFL_INVALID_HW_ID;
@@ -329,24 +340,30 @@ cpfl_get_vsi_id(struct cpfl_itf *itf)
=20
 		return repr->vport_info->vport.info.vsi_id;
 	} else if (itf->type =3D=3D CPFL_ITF_TYPE_VPORT) {
-		vport_id =3D ((struct cpfl_vport *)itf)->base.vport_id;
-
-		vport_identity.func_type =3D CPCHNL2_FTYPE_LAN_PF;
-		/* host: CPFL_HOST0_CPF_ID, acc: CPFL_ACC_CPF_ID */
-		vport_identity.pf_id =3D (itf->adapter->host_id =3D=3D CPFL_HOST_ID_ACC)=
 ?
-								CPFL_ACC_CPF_ID : CPFL_HOST0_CPF_ID;
-		vport_identity.vf_id =3D 0;
-		vport_identity.vport_id =3D vport_id;
-		ret =3D rte_hash_lookup_data(itf->adapter->vport_map_hash,
-					   &vport_identity,
-					   (void **)&info);
-		if (ret < 0) {
-			PMD_DRV_LOG(ERR, "vport id not exist");
-			goto err;
+		if (itf->adapter->base.hw.device_id =3D=3D IDPF_DEV_ID_CPF) {
+			vport_id =3D ((struct cpfl_vport *)itf)->base.vport_id;
+
+			vport_identity.func_type =3D CPCHNL2_FTYPE_LAN_PF;
+			/* host: CPFL_HOST0_CPF_ID, acc: CPFL_ACC_CPF_ID */
+			vport_identity.pf_id =3D (itf->adapter->host_id =3D=3D CPFL_HOST_ID_ACC=
) ?
+							CPFL_ACC_CPF_ID : CPFL_HOST0_CPF_ID;
+			vport_identity.vf_id =3D 0;
+			vport_identity.vport_id =3D vport_id;
+			ret =3D rte_hash_lookup_data(itf->adapter->vport_map_hash,
+						   &vport_identity,
+						   (void **)&info);
+			if (ret < 0) {
+				PMD_DRV_LOG(ERR, "vport id not exist");
+				goto err;
+			}
+
+			vsi_id =3D info->vport.info.vsi_id;
+		} else {
+			if (itf->adapter->base.hw.device_id =3D=3D IXD_DEV_ID_VCPF)
+				vsi_id =3D (uint16_t)((struct cpfl_vport *)itf)->vport_info.vsi_id;
 		}
-
-		return info->vport.info.vsi_id;
 	}
+	return vsi_id;
=20
 err:
 	return CPFL_INVALID_HW_ID;
@@ -375,4 +392,25 @@ cpfl_get_itf_by_port_id(uint16_t port_id)
=20
 	return CPFL_DEV_TO_ITF(dev);
 }
+
+static inline uint32_t
+vcpf_get_abs_qid(uint16_t port_id,  uint32_t queue_type) {
+	struct cpfl_itf *itf =3D cpfl_get_itf_by_port_id(port_id);
+	struct cpfl_vport *vport;
+	if (!itf)
+		return CPFL_INVALID_HW_ID;
+	if (itf->type =3D=3D CPFL_ITF_TYPE_VPORT) {
+		vport =3D (void *)itf;
+		if (itf->adapter->base.hw.device_id =3D=3D IXD_DEV_ID_VCPF) {
+			switch (queue_type) {
+			case VIRTCHNL2_QUEUE_TYPE_TX:
+				return vport->vport_info.abs_start_txq_id;
+			case VIRTCHNL2_QUEUE_TYPE_RX:
+				return vport->vport_info.abs_start_rxq_id;
+			}
+		}
+	}
+	return 0;
+}
 #endif /* _CPFL_ETHDEV_H_ */
--
Recheck-request: iol-intel-Performance

2.37.3

