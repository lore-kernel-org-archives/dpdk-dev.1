Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 569C0C5B543
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Jun 2025 13:23:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5605E402AB;
	Thu,  5 Jun 2025 15:23:02 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id 3DA8140281
 for <dev@dpdk.org>; Thu,  5 Jun 2025 15:23:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1749129781; x=1780665781;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:mime-version;
 bh=eXl0/HEJklGFA86ZEl3YpWFpR1eBEbfNYtUvR9j57DA=;
 b=G4sq4+ILHXRPvZhJr4wiLP+6VaS0q6Uow6FXmbeOu5d+AuTtXVU/cuCu
 smLNxi6nFPpiOOApOrlUSi8UbcJp/YzcE9XWXprYRu1E/hxOvZxrqdkg0
 CDZxn3uTT2k7/FSVpq522XPSW7/9AqwRz6l0OwCK+7ykC1XIUDwa0OG2X
 dkOcrsfAPzc6xoPqDV85Jl+XK60jqfCyDz3LoMZAvbmTCKbiboxlkKHIm
 FyPDxt93Afq1BeAMfejkvZcO55KtWE90mtmRDRxf5LyQrZoIenkUYBemM
 WfnqSSLIJVwtvBlfUSZ3vb0hhtZ4aHQBWHzdSij1RpwSlObvf/2yzfl8P Q==;
X-CSE-ConnectionGUID: E8tVPg0TRpymJcA3L5UMXg==
X-CSE-MsgGUID: 40sOxNopSFGEJogpyzyjRg==
X-IronPort-AV: E=McAfee;i="6800,10657,11455"; a="51118553"
X-IronPort-AV: E=Sophos;i="6.16,212,1744095600"; d="scan'208,217";a="51118553"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jun 2025 06:22:59 -0700
X-CSE-ConnectionGUID: yKsxtTluTT+Lf7JahRfB1Q==
X-CSE-MsgGUID: lXFGE261REGXL51i++4DYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,212,1744095600"; 
 d="scan'208,217";a="146090549"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jun 2025 06:22:59 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 5 Jun 2025 06:22:58 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Thu, 5 Jun 2025 06:22:58 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.75)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Thu, 5 Jun 2025 06:22:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dtAFGyJVJm1IU/x3IA+DrcMf6r/K8RYXublehiCRWpn0qvh9G7i62s8vdYR4CBTI3BB1uAxutBGqXBwhv2DGreITLYBcJk+qd+XKL993XkGvHqP9fys2M4r/B3JRSLnmvvxG+krBRoPhxW9l1nuiqVWS+//YRr56mxHQl7w/u5Q0LKl04/ooLBZ4+qs5Qpa6vugRkH1E9YBSibWpgMQ8zYeeahRF9UAwXCCL5mBHnI3LJejWYDkX9eHaZRt3X99rDHOEzL3yMMTCjgPCGSLyKbrkUuoOVJXJBo7L6bNxS9IGmK1xXGeX/MAIg0S5FQnHLpoD3gu5MRD5q60D3z35dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZT1d+A8DOGTAGpb24mpWqn8zX42NeK4vCp5TbxJ/nTw=;
 b=DcDEEpRB6Gsb0TipVLJ3LPGm8hWeg9pdmlXb6tifjDK5oeOgxsd1IMCqaFie1UeCWNncicO8w/yQ/tBEsaEJMMUPbE6CPYxsEtuMzjXjQ3qguGRHD90uRQiaZIpnZGUIPn+nkKT0tWmQ72qk3GU/zglaWK7xBoQwC68i4ZYkfBsYgqqwIDGtsctqX/WS2d5F22yRCu4LtoShTWhYn9TsQ8TwaWeZ1wg9jvzZmePKhbyphB1S8IQG7kpaUoCOq0llucPtTEbrF2K3fwi5B4DdTt0aIPS7rSNr86a4tOs6gYYl04K5mgLUgazPPlzBWuw9yxCbhWPiRyj1FQqPw2r2bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB7458.namprd11.prod.outlook.com (2603:10b6:8:145::13)
 by DS7PR11MB7805.namprd11.prod.outlook.com (2603:10b6:8:ea::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.37; Thu, 5 Jun
 2025 13:22:53 +0000
Received: from DS0PR11MB7458.namprd11.prod.outlook.com
 ([fe80::1a9e:53a6:9603:8f79]) by DS0PR11MB7458.namprd11.prod.outlook.com
 ([fe80::1a9e:53a6:9603:8f79%3]) with mapi id 15.20.8769.025; Thu, 5 Jun 2025
 13:22:53 +0000
From: "Ji, Kai" <kai.ji@intel.com>
To: "Nicolau, Radu" <radu.nicolau@intel.com>
CC: "dev@dpdk.org" <dev@dpdk.org>
Subject: Re: [PATCH v2] crypto/qat: remove ZUC 256 support
Thread-Topic: [PATCH v2] crypto/qat: remove ZUC 256 support
Thread-Index: AQHb1HKf2DM1lb8PxU6x+cRbjhs69bP0kN+t
Date: Thu, 5 Jun 2025 13:22:53 +0000
Message-ID: <DS0PR11MB7458C75FF5E750AFE8263DFE816FA@DS0PR11MB7458.namprd11.prod.outlook.com>
References: <20250603092324.66743-1-radu.nicolau@intel.com>
 <20250603103054.60606-1-radu.nicolau@intel.com>
In-Reply-To: <20250603103054.60606-1-radu.nicolau@intel.com>
Accept-Language: en-GB, en-US, en-IE
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB7458:EE_|DS7PR11MB7805:EE_
x-ms-office365-filtering-correlation-id: 99823dbd-7d5c-4c6a-5c95-08dda43413ac
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|7053199007|8096899003|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?K1Fod+YG4qeFzV3cN94BYZ5aQDBYF6NrMNKNiFu39IuI8Sjwe7NhIxe/1W8S?=
 =?us-ascii?Q?2uWF2ISWoCvssDK8joONryiXjDwiWYwYNXs1ZMZOG4zQRGRqK/UpdIH4fkDR?=
 =?us-ascii?Q?i0VPLEGFusSXs3B7+UB7Kv6/FcRd+Urq4zdPcHrUBrN4gQuExgqtk3BrCnR2?=
 =?us-ascii?Q?fk7B/zZa/AGohLB+l4LYBRy3cVxvqwNoi07c3Rk3BzHUQwhjz3t0MRliuzUD?=
 =?us-ascii?Q?+Vl3oeBGSc+4h4iOX9ldUSTiwxyhQjbdlCr3tR8rvB6OTd6XEt1KQvqtElOx?=
 =?us-ascii?Q?eDZLu7NfrT2JZaGKqzsGL+pBy2oCf0NERJbQr7GeNj/+ypR9ccvGbtDP2TEw?=
 =?us-ascii?Q?VfP38GCjeD76giVXXaxQ/8NHVIaU87Pk4K5Orp7/z91D7E9Bbkm7q5gD/srL?=
 =?us-ascii?Q?1bK1L+rr+ZhfdvbHhXpaDFwZuOVnUudSPUpCeEqNpdJLn429iSRvYr5cyEz+?=
 =?us-ascii?Q?Mn14AtNOP5EjeQP1JPYeuzXhUhKSPhlho6ru6kJv8sfymEDkuJosW+DxDEZ5?=
 =?us-ascii?Q?lmljIuknZ9sJSKAW7cGW2hBBipwTtFYGNFCdtSaoQIZBFjO8fXnKv7bVIeXB?=
 =?us-ascii?Q?WDXUe3Rd4pdmsj7XM6OhytggMrNIoj+JwssmLQrVppSCl6JDU/R7wUAVtzDU?=
 =?us-ascii?Q?g28Q7rHU7a9zU7vZ0Kf0l2g75QePT1orz1nsECdHqnGRvf9rBXNCcTMIzCJ5?=
 =?us-ascii?Q?rqSj9beccsdvWppgtXmJIvYyzKK4sCnnlJNrusZiUdToNAOaHeSKyK2s8mhr?=
 =?us-ascii?Q?F3g6Ef4fO8KsiKGVX7lXNcp6mhj6P6mL/vhCp4Esw2FElET5X6D+RmxvuDAZ?=
 =?us-ascii?Q?dJ/MnmU+3OIcf+gRpBu9BFyksKhDOYUmXl+T1MK6yY9rmnZpPePznwbLwJH7?=
 =?us-ascii?Q?ZVP0dc6R8rZZRbl+oBUrmOnQDmkgt97naS0EHzpPIV6H63uQtzOptZFUMBD+?=
 =?us-ascii?Q?WquFOW89SW9pCn4SyLq8yLV32ChwVzLEfnVwtIFMwL+ngMev2x5kHZphYBW9?=
 =?us-ascii?Q?enD38uBJaCgwqiYzhKwS3jFnc/CQ3mfRRME/ZGlkDnG7LpJJ6uqqQmf6ZCNG?=
 =?us-ascii?Q?v1rPY9X1pHwsmHPdyFSUhydvgMEUAN0J23hDoAw/AiWe0nsvM4VxxXCeGgg4?=
 =?us-ascii?Q?gqDq2VHU9zHtdbrUqyazta3Bg9Wlwh+t8MkSafPbCeSMMxBRJ1squxH8FGqs?=
 =?us-ascii?Q?AMFeN/Ut4KgN07F/twJ8CH/S612kK+HTffO/PxP0jZDZRiluo4PzT3BmntFo?=
 =?us-ascii?Q?euNEvHsd70XDQKovRXUIo+TFfbHYx3a3tNZcgqhnwFZru9rFwVeMQU/S/NpA?=
 =?us-ascii?Q?yLrYezKP98dAgA5tdQBmajFiHu/H9+vsd6GvQ0hUjWMBgS1JA6q9xpXEWGJR?=
 =?us-ascii?Q?UvojVhpO7OlDFKVdnNFjEbWgcoFGEC+uMzKg0b2MiIabQMMTn3Tn+e5yqDby?=
 =?us-ascii?Q?QKY60eScRUjz2dBten80gPZKPH0aF5r96Be49gTX0MWm3YHD/sHl1XyQRUBF?=
 =?us-ascii?Q?/qXP/O8i4Y3G2ms=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7458.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007)(8096899003)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2DkBC6WS659R6juhLg4/TtbPR4j1lKmk6CitrDIgbSg9YayWE8viGZkZZngL?=
 =?us-ascii?Q?fvRSThRKb2NVaXfDY86GHSVqZkoqQTn3Ye6nTm6y3Rsxh9XIHIqABBfRI3L5?=
 =?us-ascii?Q?7eCGinL3RdL5gWbfY9AIXajlcgxoyH6mm4Zzru3UIUtmw8lcmBWy01e451Fu?=
 =?us-ascii?Q?nJlHGodvsm1KGjrvlP/BiC2q4esyQRVI7KT5IIJ0zpukd+NfchI4f9JEnOS0?=
 =?us-ascii?Q?AMmXryZyJRl57lDqBHsbFnAITKobNuUHGhOk5pmghwVJE649SoXAxjz4MvsT?=
 =?us-ascii?Q?mjDs8K9Wjstr4ZIyU0MbV5j4meDCaTHxFv1qV1CwmyIg79eI7mI/PvxUbZTx?=
 =?us-ascii?Q?2N0em2HDIM3zOEJuzmhW1na2KtmQyh6xDi1WM2gGVbySl+dyn15fYh8CYBBJ?=
 =?us-ascii?Q?tmf0/q9FTc5nBah4aTG308CwPWYSqloEX6jnrrF3ICDPAnczIoajKEXHXmL0?=
 =?us-ascii?Q?mAoYfiv9L8QAfTPCtnnpOPOeAo3p4U2+GdMd8scPP17naMpVvhN6QKZPhc0Y?=
 =?us-ascii?Q?SwyyYZXpsejUQHe/XAQzVNdmmRuanRZhd4vsXNm8sTrB/TXPPEih0DLVW4hg?=
 =?us-ascii?Q?TZCxoMn89ESFG4f1x1LGe6hmD++v6/U+oYzOR8P2KnsJei/5Nj+kmi2kPINp?=
 =?us-ascii?Q?aCAXa6e4gK0+tt6LPOotyOwWUo7/v2KtewDjWysopo9SLojY6ezozv+NIyQa?=
 =?us-ascii?Q?36x64lVPu2BlxKDGhMioK4vgFPZH2+dgKFDXL/XMH1PoOqm51WnyOpLbEQg8?=
 =?us-ascii?Q?hVujUJcBV6x6fgwG9f4OKD8yWGACUO7t4mAT7HgHVVc+xNzYjJYnJ/51TJ/r?=
 =?us-ascii?Q?G6DftNf4zNLf/n4h5roNeJmxvPftqIUPAlFRwBbYemmD5BCnNOxdm/8JKp4G?=
 =?us-ascii?Q?clSl30Xalp9w5axjPr59TL2uEZ1mjJx7ax+sCRwbWhSGLRILz+ADcz10rZ2x?=
 =?us-ascii?Q?PjV3Xw7R9R3hFoc2wjkuSIYB3WXbeDj19hYRFBJPWpHeTV5feRsOWoqCJCnl?=
 =?us-ascii?Q?8BZETjQ30l4LYsEFAbibZnYHKEuHa2be+rOKbL7UEvdPw9xU71PIgrzC4KyW?=
 =?us-ascii?Q?bke1IwCrF4WWbVehYkDJj6JCfgV+i1uRNepOm+LPX9ldLIZOr5CcOBvnz/Ge?=
 =?us-ascii?Q?Fpyl4VgnVUXGfsGqjRQOo+dTy87rGgZQIcFkgVfXj6qB9RdR8ErB5hnLlo/n?=
 =?us-ascii?Q?A2/Gd2UEQ+n9VgGiRKiO743lCiKsgbiEBJXU89miMe/i5s8LtTXvVETa3uS1?=
 =?us-ascii?Q?m4awPFchqy7VV1V/vv20fa/YiTlWm7ztmptp8BZCBLOhZpgJUDcfqZfiWD3s?=
 =?us-ascii?Q?HWsBN/upyqIdPp7aPQp+xEMJN7IclDa42kMGSIjLwwQ3EMDe8x4dZG9Bd+l0?=
 =?us-ascii?Q?A6/LY1LDgViquk5uXHkEGh5EeHOBpv7MWW9LM1zin4JWE4a8cTMf9HUXW65f?=
 =?us-ascii?Q?Oj34Y6CHBoivPfe8y9iCviiCw7QJcfW1bXKuzKZu290KT5EOtmRBsVe9HkIK?=
 =?us-ascii?Q?J0deAGCLU8hKgVFl0WB4QvyfF9/gOi/RChdmYjKWl+aclZWiMMiJdSXyUOGO?=
 =?us-ascii?Q?neAjDbVpoy8a/CXYhg0=3D?=
Content-Type: multipart/alternative;
 boundary="_000_DS0PR11MB7458C75FF5E750AFE8263DFE816FADS0PR11MB7458namp_"
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7458.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99823dbd-7d5c-4c6a-5c95-08dda43413ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2025 13:22:53.1317 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qjH3QvpwkTzZ5JLiAtm+u9+HyUwM7cqqjNIqigoJBbNld9Wg3CSC5SvHswY8cllqxxqEUe4g/FBIWqVeMCny4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7805
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

--_000_DS0PR11MB7458C75FF5E750AFE8263DFE816FADS0PR11MB7458namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Acked-by: Kai Ji <kai.ji@intel.com>

________________________________
From: Nicolau, Radu <radu.nicolau@intel.com>
Sent: 03 June 2025 11:30
To: Ji, Kai <kai.ji@intel.com>
Cc: dev@dpdk.org <dev@dpdk.org>; Nicolau, Radu <radu.nicolau@intel.com>
Subject: [PATCH v2] crypto/qat: remove ZUC 256 support

Remove ZUC 256 support from Gen 3 and 5 hardware

Signed-off-by: Radu Nicolau <radu.nicolau@intel.com>
---
v2: removed usnused function

 doc/guides/rel_notes/release_25_07.rst       |  5 ++
 drivers/common/qat/qat_adf/icp_qat_hw.h      |  2 +-
 drivers/crypto/qat/dev/qat_crypto_pmd_gen3.c | 40 +---------------
 drivers/crypto/qat/dev/qat_crypto_pmd_gen5.c | 49 ++------------------
 drivers/crypto/qat/dev/qat_crypto_pmd_gens.h | 20 --------
 drivers/crypto/qat/dev/qat_sym_pmd_gen1.c    | 33 -------------
 drivers/crypto/qat/qat_sym_session.c         | 25 ++--------
 drivers/crypto/qat/qat_sym_session.h         |  1 -
 8 files changed, 14 insertions(+), 161 deletions(-)

diff --git a/doc/guides/rel_notes/release_25_07.rst b/doc/guides/rel_notes/=
release_25_07.rst
index 11bb6d34f7..07bfa71700 100644
--- a/doc/guides/rel_notes/release_25_07.rst
+++ b/doc/guides/rel_notes/release_25_07.rst
@@ -87,6 +87,11 @@ New Features
 Removed Items
 -------------

+* **Removed ZUC-256 algorithms from Intel QuickAssist Technology (QAT) PMD=
.**
+
+  Support for ZUC-256 cipher and integrity algorithms was removed from
+  Gen 3 and Gen 5 PMD.
+
 .. This section should contain removed items in this release. Sample forma=
t:

    * Add a short 1-2 sentence description of the removed item
diff --git a/drivers/common/qat/qat_adf/icp_qat_hw.h b/drivers/common/qat/q=
at_adf/icp_qat_hw.h
index 1d61a0b833..e929b16df2 100644
--- a/drivers/common/qat/qat_adf/icp_qat_hw.h
+++ b/drivers/common/qat/qat_adf/icp_qat_hw.h
@@ -367,7 +367,7 @@ enum icp_qat_hw_cipher_convert {
 #define ICP_QAT_HW_CHACHAPOLY_ICV_SZ 16
 #define ICP_QAT_HW_CHACHAPOLY_AAD_MAX_LOG 14
 #define ICP_QAT_HW_ZUC_256_KEY_SZ 32
-#define ICP_QAT_HW_ZUC_256_IV_SZ 24
+#define ICP_QAT_HW_ZUC_256_IV_SZ 16

 #define ICP_QAT_HW_CIPHER_MAX_KEY_SZ ICP_QAT_HW_AES_256_F8_KEY_SZ

diff --git a/drivers/crypto/qat/dev/qat_crypto_pmd_gen3.c b/drivers/crypto/=
qat/dev/qat_crypto_pmd_gen3.c
index af664fb9b9..f2ff952482 100644
--- a/drivers/crypto/qat/dev/qat_crypto_pmd_gen3.c
+++ b/drivers/crypto/qat/dev/qat_crypto_pmd_gen3.c
@@ -204,7 +204,6 @@ qat_sym_crypto_cap_get_gen3(struct qat_cryptodev_privat=
e *internals,
         uint32_t legacy_size =3D sizeof(qat_sym_crypto_legacy_caps_gen3);
         capa_num =3D size/sizeof(struct rte_cryptodev_capabilities);
         legacy_capa_num =3D legacy_size/sizeof(struct rte_cryptodev_capabi=
lities);
-       struct rte_cryptodev_capabilities *cap;

         if (unlikely(internals->qat_dev->options.legacy_alg))
                 size =3D size + legacy_size;
@@ -258,14 +257,6 @@ qat_sym_crypto_cap_get_gen3(struct qat_cryptodev_priva=
te *internals,
                         continue;
                 }

-               if (slice_map & ICP_ACCEL_MASK_ZUC_256_SLICE && (
-                       check_auth_capa(&capabilities[iter],
-                               RTE_CRYPTO_AUTH_ZUC_EIA3) ||
-                       check_cipher_capa(&capabilities[iter],
-                               RTE_CRYPTO_CIPHER_ZUC_EEA3))) {
-                       continue;
-               }
-
                 if (internals->qat_dev->options.has_wireless_slice && (
                         check_auth_capa(&capabilities[iter],
                                 RTE_CRYPTO_AUTH_KASUMI_F9) ||
@@ -279,27 +270,6 @@ qat_sym_crypto_cap_get_gen3(struct qat_cryptodev_priva=
te *internals,

                 memcpy(addr + curr_capa, capabilities + iter,
                         sizeof(struct rte_cryptodev_capabilities));
-
-               if (internals->qat_dev->options.has_wireless_slice && (
-                       check_auth_capa(&capabilities[iter],
-                               RTE_CRYPTO_AUTH_ZUC_EIA3))) {
-                       cap =3D addr + curr_capa;
-                       cap->sym.auth.key_size.max =3D 32;
-                       cap->sym.auth.key_size.increment =3D 16;
-                       cap->sym.auth.iv_size.max =3D 25;
-                       cap->sym.auth.iv_size.increment =3D 1;
-                       cap->sym.auth.digest_size.max =3D 16;
-                       cap->sym.auth.digest_size.increment =3D 4;
-               }
-               if (internals->qat_dev->options.has_wireless_slice && (
-                       check_cipher_capa(&capabilities[iter],
-                               RTE_CRYPTO_CIPHER_ZUC_EEA3))) {
-                       cap =3D addr + curr_capa;
-                       cap->sym.cipher.key_size.max =3D 32;
-                       cap->sym.cipher.key_size.increment =3D 16;
-                       cap->sym.cipher.iv_size.max =3D 25;
-                       cap->sym.cipher.iv_size.increment =3D 1;
-               }
                 curr_capa++;
         }
         internals->qat_dev_capabilities =3D internals->capa_mz->addr;
@@ -558,16 +528,8 @@ qat_sym_crypto_set_session_gen3(void *cdev, void *sess=
ion)
                                 (ctx->qat_cipher_alg =3D=3D
                                 ICP_QAT_HW_CIPHER_ALGO_SNOW_3G_UEA2 ||
                                 ctx->qat_cipher_alg =3D=3D
-                               ICP_QAT_HW_CIPHER_ALGO_ZUC_3G_128_EEA3 ||
-                               ctx->qat_cipher_alg =3D=3D ICP_QAT_HW_CIPHE=
R_ALGO_ZUC_256))) {
+                               ICP_QAT_HW_CIPHER_ALGO_ZUC_3G_128_EEA3))) {
                         qat_sym_session_set_ext_hash_flags_gen2(ctx, 0);
-               } else if ((internals->qat_dev->options.has_wireless_slice)=
 &&
-                       (ctx->qat_hash_alg =3D=3D ICP_QAT_HW_AUTH_ALGO_ZUC_=
256_MAC_32 ||
-                               ctx->qat_hash_alg =3D=3D ICP_QAT_HW_AUTH_AL=
GO_ZUC_256_MAC_64 ||
-                               ctx->qat_hash_alg =3D=3D ICP_QAT_HW_AUTH_AL=
GO_ZUC_256_MAC_128) &&
-                               ctx->qat_cipher_alg !=3D ICP_QAT_HW_CIPHER_=
ALGO_ZUC_256) {
-                       qat_sym_session_set_ext_hash_flags_gen2(ctx,
-                                       1 << ICP_QAT_FW_AUTH_HDR_FLAG_ZUC_E=
IA3_BITPOS);
                 }

                 ret =3D 0;
diff --git a/drivers/crypto/qat/dev/qat_crypto_pmd_gen5.c b/drivers/crypto/=
qat/dev/qat_crypto_pmd_gen5.c
index e1302e9b36..5714420e1e 100644
--- a/drivers/crypto/qat/dev/qat_crypto_pmd_gen5.c
+++ b/drivers/crypto/qat/dev/qat_crypto_pmd_gen5.c
@@ -113,11 +113,11 @@ static struct rte_cryptodev_capabilities qat_sym_cryp=
to_caps_gen5[] =3D {
                 CAP_RNG_ZERO(aad_size), CAP_RNG_ZERO(iv_size)),
         QAT_SYM_CIPHER_CAP(ZUC_EEA3,
                 CAP_SET(block_size, 16),
-               CAP_RNG(key_size, 16, 32, 16), CAP_RNG(iv_size, 16, 25, 1))=
,
+               CAP_RNG(key_size, 16, 16, 0), CAP_RNG(iv_size, 16, 16, 0)),
         QAT_SYM_AUTH_CAP(ZUC_EIA3,
                 CAP_SET(block_size, 16),
-               CAP_RNG(key_size, 16, 32, 16), CAP_RNG(digest_size, 4, 16, =
4),
-               CAP_RNG_ZERO(aad_size), CAP_RNG(iv_size, 16, 25, 1)),
+               CAP_RNG(key_size, 16, 16, 0), CAP_RNG(digest_size, 4, 16, 4=
),
+               CAP_RNG_ZERO(aad_size), CAP_RNG(iv_size, 16, 16, 0)),
         QAT_SYM_CIPHER_CAP(SNOW3G_UEA2,
                 CAP_SET(block_size, 16),
                 CAP_RNG(key_size, 16, 16, 0), CAP_RNG(iv_size, 16, 16, 0))=
,
@@ -128,32 +128,6 @@ static struct rte_cryptodev_capabilities qat_sym_crypt=
o_caps_gen5[] =3D {
         RTE_CRYPTODEV_END_OF_CAPABILITIES_LIST()
 };

-static int
-check_cipher_capa(const struct rte_cryptodev_capabilities *cap,
-               enum rte_crypto_cipher_algorithm algo)
-{
-       if (cap->op !=3D RTE_CRYPTO_OP_TYPE_SYMMETRIC)
-               return 0;
-       if (cap->sym.xform_type !=3D RTE_CRYPTO_SYM_XFORM_CIPHER)
-               return 0;
-       if (cap->sym.cipher.algo !=3D algo)
-               return 0;
-       return 1;
-}
-
-static int
-check_auth_capa(const struct rte_cryptodev_capabilities *cap,
-               enum rte_crypto_auth_algorithm algo)
-{
-       if (cap->op !=3D RTE_CRYPTO_OP_TYPE_SYMMETRIC)
-               return 0;
-       if (cap->sym.xform_type !=3D RTE_CRYPTO_SYM_XFORM_AUTH)
-               return 0;
-       if (cap->sym.auth.algo !=3D algo)
-               return 0;
-       return 1;
-}
-
 static int
 qat_sym_crypto_cap_get_gen5(struct qat_cryptodev_private *internals,
                         const char *capa_memz_name,
@@ -195,14 +169,6 @@ qat_sym_crypto_cap_get_gen5(struct qat_cryptodev_priva=
te *internals,
         capabilities =3D qat_sym_crypto_caps_gen5;

         for (i =3D 0; i < capa_num; i++, iter++) {
-               if (slice_map & ICP_ACCEL_MASK_ZUC_256_SLICE && (
-                       check_auth_capa(&capabilities[iter],
-                               RTE_CRYPTO_AUTH_ZUC_EIA3) ||
-                       check_cipher_capa(&capabilities[iter],
-                               RTE_CRYPTO_CIPHER_ZUC_EEA3))) {
-                       continue;
-               }
-
                 memcpy(addr + curr_capa, capabilities + iter,
                         sizeof(struct rte_cryptodev_capabilities));
                 curr_capa++;
@@ -233,15 +199,8 @@ qat_sym_crypto_set_session_gen5(void *cdev, void *sess=
ion)
                                 (ctx->qat_cipher_alg =3D=3D
                                 ICP_QAT_HW_CIPHER_ALGO_SNOW_3G_UEA2 ||
                                 ctx->qat_cipher_alg =3D=3D
-                               ICP_QAT_HW_CIPHER_ALGO_ZUC_3G_128_EEA3 ||
-                               ctx->qat_cipher_alg =3D=3D ICP_QAT_HW_CIPHE=
R_ALGO_ZUC_256)) {
+                               ICP_QAT_HW_CIPHER_ALGO_ZUC_3G_128_EEA3)) {
                         qat_sym_session_set_ext_hash_flags_gen2(ctx, 0);
-               } else if ((ctx->qat_hash_alg =3D=3D ICP_QAT_HW_AUTH_ALGO_Z=
UC_256_MAC_32 ||
-                               ctx->qat_hash_alg =3D=3D ICP_QAT_HW_AUTH_AL=
GO_ZUC_256_MAC_64 ||
-                               ctx->qat_hash_alg =3D=3D ICP_QAT_HW_AUTH_AL=
GO_ZUC_256_MAC_128) &&
-                               ctx->qat_cipher_alg !=3D ICP_QAT_HW_CIPHER_=
ALGO_ZUC_256) {
-                       qat_sym_session_set_ext_hash_flags_gen2(ctx,
-                                       1 << ICP_QAT_FW_AUTH_HDR_FLAG_ZUC_E=
IA3_BITPOS);
                 }

                 ret =3D 0;
diff --git a/drivers/crypto/qat/dev/qat_crypto_pmd_gens.h b/drivers/crypto/=
qat/dev/qat_crypto_pmd_gens.h
index 846636f57d..1f19c69f88 100644
--- a/drivers/crypto/qat/dev/qat_crypto_pmd_gens.h
+++ b/drivers/crypto/qat/dev/qat_crypto_pmd_gens.h
@@ -881,26 +881,6 @@ qat_sym_convert_op_to_vec_aead(struct rte_crypto_op *o=
p,
         return 0;
 }

-static inline void
-zuc256_modify_iv(uint8_t *iv)
-{
-       uint8_t iv_tmp[8];
-
-       iv_tmp[0] =3D iv[16];
-       /* pack the last 8 bytes of IV to 6 bytes.
-        * discard the 2 MSB bits of each byte
-        */
-       iv_tmp[1] =3D (((iv[17] & 0x3f) << 2) | ((iv[18] >> 4) & 0x3));
-       iv_tmp[2] =3D (((iv[18] & 0xf) << 4) | ((iv[19] >> 2) & 0xf));
-       iv_tmp[3] =3D (((iv[19] & 0x3) << 6) | (iv[20] & 0x3f));
-
-       iv_tmp[4] =3D (((iv[21] & 0x3f) << 2) | ((iv[22] >> 4) & 0x3));
-       iv_tmp[5] =3D (((iv[22] & 0xf) << 4) | ((iv[23] >> 2) & 0xf));
-       iv_tmp[6] =3D (((iv[23] & 0x3) << 6) | (iv[24] & 0x3f));
-
-       memcpy(iv + 16, iv_tmp, 8);
-}
-
 static __rte_always_inline void
 qat_set_cipher_iv(struct icp_qat_fw_la_cipher_req_params *cipher_param,
                 struct rte_crypto_va_iova_ptr *iv_ptr, uint32_t iv_len,
diff --git a/drivers/crypto/qat/dev/qat_sym_pmd_gen1.c b/drivers/crypto/qat=
/dev/qat_sym_pmd_gen1.c
index 561166203c..8cb85fd8df 100644
--- a/drivers/crypto/qat/dev/qat_sym_pmd_gen1.c
+++ b/drivers/crypto/qat/dev/qat_sym_pmd_gen1.c
@@ -248,9 +248,6 @@ qat_sym_build_op_cipher_gen1(void *in_op, struct qat_sy=
m_session *ctx,
                 return -EINVAL;
         }

-       if (ctx->is_zuc256)
-               zuc256_modify_iv(cipher_iv.va);
-
         enqueue_one_cipher_job_gen1(ctx, req, &cipher_iv, ofs, total_len, =
op_cookie);

         qat_sym_debug_log_dump(req, ctx, in_sgl.vec, in_sgl.num, &cipher_i=
v,
@@ -303,9 +300,6 @@ qat_sym_build_op_auth_gen1(void *in_op, struct qat_sym_=
session *ctx,
                 return -EINVAL;
         }

-       if (ctx->is_zuc256)
-               zuc256_modify_iv(auth_iv.va);
-
         enqueue_one_auth_job_gen1(ctx, req, &digest, &auth_iv, ofs,
                         total_len);

@@ -396,11 +390,6 @@ qat_sym_build_op_chain_gen1(void *in_op, struct qat_sy=
m_session *ctx,
                 return -EINVAL;
         }

-       if (ctx->is_zuc256) {
-               zuc256_modify_iv(cipher_iv.va);
-               zuc256_modify_iv(auth_iv.va);
-       }
-
         enqueue_one_chain_job_gen1(ctx, req, in_sgl.vec, in_sgl.num,
                         out_sgl.vec, out_sgl.num, &cipher_iv, &digest, &au=
th_iv,
                         ofs, total_len, cookie);
@@ -527,9 +516,6 @@ qat_sym_dp_enqueue_single_cipher_gen1(void *qp_data, ui=
nt8_t *drv_ctx,
         if (unlikely(data_len < 0))
                 return -1;

-       if (ctx->is_zuc256)
-               zuc256_modify_iv(iv->va);
-
         enqueue_one_cipher_job_gen1(ctx, req, iv, ofs, (uint32_t)data_len,=
 cookie);

         qat_sym_debug_log_dump(req, ctx, data, n_data_vecs, iv,
@@ -591,9 +577,6 @@ qat_sym_dp_enqueue_cipher_jobs_gen1(void *qp_data, uint=
8_t *drv_ctx,
                 if (unlikely(data_len < 0 || error))
                         break;

-               if (ctx->is_zuc256)
-                       zuc256_modify_iv(vec->iv[i].va);
-
                 enqueue_one_cipher_job_gen1(ctx, req, &vec->iv[i], ofs,
                         (uint32_t)data_len, cookie);
                 tail =3D (tail + tx_queue->msg_size) & tx_queue->modulo_ma=
sk;
@@ -644,9 +627,6 @@ qat_sym_dp_enqueue_single_auth_gen1(void *qp_data, uint=
8_t *drv_ctx,
         if (unlikely(data_len < 0))
                 return -1;

-       if (ctx->is_zuc256)
-               zuc256_modify_iv(auth_iv->va);
-
         if (ctx->qat_hash_alg =3D=3D ICP_QAT_HW_AUTH_ALGO_NULL) {
                 null_digest.iova =3D cookie->digest_null_phys_addr;
                 job_digest =3D &null_digest;
@@ -716,9 +696,6 @@ qat_sym_dp_enqueue_auth_jobs_gen1(void *qp_data, uint8_=
t *drv_ctx,
                 if (unlikely(data_len < 0 || error))
                         break;

-               if (ctx->is_zuc256)
-                       zuc256_modify_iv(vec->auth_iv[i].va);
-
                 if (ctx->qat_hash_alg =3D=3D ICP_QAT_HW_AUTH_ALGO_NULL) {
                         null_digest.iova =3D cookie->digest_null_phys_addr=
;
                         job_digest =3D &null_digest;
@@ -774,11 +751,6 @@ qat_sym_dp_enqueue_single_chain_gen1(void *qp_data, ui=
nt8_t *drv_ctx,
         if (unlikely(data_len < 0))
                 return -1;

-       if (ctx->is_zuc256) {
-               zuc256_modify_iv(cipher_iv->va);
-               zuc256_modify_iv(auth_iv->va);
-       }
-
         if (ctx->qat_hash_alg =3D=3D ICP_QAT_HW_AUTH_ALGO_NULL) {
                 null_digest.iova =3D cookie->digest_null_phys_addr;
                 job_digest =3D &null_digest;
@@ -849,11 +821,6 @@ qat_sym_dp_enqueue_chain_jobs_gen1(void *qp_data, uint=
8_t *drv_ctx,
                 if (unlikely(data_len < 0 || error))
                         break;

-               if (ctx->is_zuc256) {
-                       zuc256_modify_iv(vec->iv[i].va);
-                       zuc256_modify_iv(vec->auth_iv[i].va);
-               }
-
                 if (ctx->qat_hash_alg =3D=3D ICP_QAT_HW_AUTH_ALGO_NULL) {
                         null_digest.iova =3D cookie->digest_null_phys_addr=
;
                         job_digest =3D &null_digest;
diff --git a/drivers/crypto/qat/qat_sym_session.c b/drivers/crypto/qat/qat_=
sym_session.c
index 7f370f03fb..8489e26e28 100644
--- a/drivers/crypto/qat/qat_sym_session.c
+++ b/drivers/crypto/qat/qat_sym_session.c
@@ -541,8 +541,6 @@ qat_sym_session_configure_cipher(struct rte_cryptodev *=
dev,
                         goto error_out;
                 }
                 session->qat_mode =3D ICP_QAT_HW_CIPHER_ECB_MODE;
-               if (cipher_xform->key.length =3D=3D ICP_QAT_HW_ZUC_256_KEY_=
SZ)
-                       session->is_zuc256 =3D 1;
                 if (internals->qat_dev->options.has_wireless_slice)
                         is_wireless =3D 1;
                 break;
@@ -989,25 +987,8 @@ qat_sym_session_configure_auth(struct rte_cryptodev *d=
ev,
                                 rte_cryptodev_get_auth_algo_string(auth_xf=
orm->algo));
                         return -ENOTSUP;
                 }
-               if (key_length =3D=3D ICP_QAT_HW_ZUC_3G_EEA3_KEY_SZ)
+               if (key_length =3D=3D ICP_QAT_HW_ZUC_3G_EEA3_KEY_SZ) {
                         session->qat_hash_alg =3D ICP_QAT_HW_AUTH_ALGO_ZUC=
_3G_128_EIA3;
-               else if (key_length =3D=3D ICP_QAT_HW_ZUC_256_KEY_SZ) {
-                       switch (auth_xform->digest_length) {
-                       case 4:
-                               session->qat_hash_alg =3D ICP_QAT_HW_AUTH_A=
LGO_ZUC_256_MAC_32;
-                               break;
-                       case 8:
-                               session->qat_hash_alg =3D ICP_QAT_HW_AUTH_A=
LGO_ZUC_256_MAC_64;
-                               break;
-                       case 16:
-                               session->qat_hash_alg =3D ICP_QAT_HW_AUTH_A=
LGO_ZUC_256_MAC_128;
-                               break;
-                       default:
-                               QAT_LOG(ERR, "Invalid digest length: %d",
-                                               auth_xform->digest_length);
-                               return -ENOTSUP;
-                       }
-                       session->is_zuc256 =3D 1;
                 } else {
                         QAT_LOG(ERR, "Invalid key length: %d", key_length)=
;
                         return -ENOTSUP;
@@ -2238,8 +2219,8 @@ int qat_sym_cd_cipher_set(struct qat_sym_session *cde=
sc,
                 cdesc->qat_proto_flag =3D QAT_CRYPTO_PROTO_FLAG_ZUC;
         } else if (cdesc->qat_cipher_alg =3D=3D
                         ICP_QAT_HW_CIPHER_ALGO_ZUC_256) {
-               if (cdesc->cipher_iv.length !=3D 23 && cdesc->cipher_iv.len=
gth !=3D 25) {
-                       QAT_LOG(ERR, "Invalid IV length for ZUC256, must be=
 23 or 25.");
+               if (cdesc->cipher_iv.length !=3D ICP_QAT_HW_ZUC_256_IV_SZ) =
{
+                       QAT_LOG(ERR, "Invalid IV length for ZUC256");
                         return -EINVAL;
                 }
                 total_key_size =3D ICP_QAT_HW_ZUC_256_KEY_SZ +
diff --git a/drivers/crypto/qat/qat_sym_session.h b/drivers/crypto/qat/qat_=
sym_session.h
index 2ef2066646..0c7b9cc6cf 100644
--- a/drivers/crypto/qat/qat_sym_session.h
+++ b/drivers/crypto/qat/qat_sym_session.h
@@ -147,7 +147,6 @@ struct qat_sym_session {
         uint8_t is_auth;
         uint8_t is_cnt_zero;
         /* Some generations need different setup of counter */
-       uint8_t is_zuc256;
         uint8_t is_wireless;
         uint32_t slice_types;
         struct rte_net_crc *crc;
--
2.43.0


--_000_DS0PR11MB7458C75FF5E750AFE8263DFE816FADS0PR11MB7458namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div class=3D"elementToProof" style=3D"font-family: &quot;IntelOne Text&quo=
t;; font-size: 10pt; color: rgb(0, 0, 0);">
Acked-by: Kai Ji &lt;kai.ji@intel.com&gt;</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;IntelOne Text&quo=
t;; font-size: 10pt; color: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Nicolau, Radu &lt;rad=
u.nicolau@intel.com&gt;<br>
<b>Sent:</b> 03 June 2025 11:30<br>
<b>To:</b> Ji, Kai &lt;kai.ji@intel.com&gt;<br>
<b>Cc:</b> dev@dpdk.org &lt;dev@dpdk.org&gt;; Nicolau, Radu &lt;radu.nicola=
u@intel.com&gt;<br>
<b>Subject:</b> [PATCH v2] crypto/qat: remove ZUC 256 support</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Remove ZUC 256 support from Gen 3 and 5 hardware<b=
r>
<br>
Signed-off-by: Radu Nicolau &lt;radu.nicolau@intel.com&gt;<br>
---<br>
v2: removed usnused function<br>
<br>
&nbsp;doc/guides/rel_notes/release_25_07.rst&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; |&nbsp; 5 ++<br>
&nbsp;drivers/common/qat/qat_adf/icp_qat_hw.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 |&nbsp; 2 +-<br>
&nbsp;drivers/crypto/qat/dev/qat_crypto_pmd_gen3.c | 40 +---------------<br=
>
&nbsp;drivers/crypto/qat/dev/qat_crypto_pmd_gen5.c | 49 ++-----------------=
-<br>
&nbsp;drivers/crypto/qat/dev/qat_crypto_pmd_gens.h | 20 --------<br>
&nbsp;drivers/crypto/qat/dev/qat_sym_pmd_gen1.c&nbsp;&nbsp;&nbsp; | 33 ----=
---------<br>
&nbsp;drivers/crypto/qat/qat_sym_session.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; | 25 ++--------<br>
&nbsp;drivers/crypto/qat/qat_sym_session.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; |&nbsp; 1 -<br>
&nbsp;8 files changed, 14 insertions(+), 161 deletions(-)<br>
<br>
diff --git a/doc/guides/rel_notes/release_25_07.rst b/doc/guides/rel_notes/=
release_25_07.rst<br>
index 11bb6d34f7..07bfa71700 100644<br>
--- a/doc/guides/rel_notes/release_25_07.rst<br>
+++ b/doc/guides/rel_notes/release_25_07.rst<br>
@@ -87,6 +87,11 @@ New Features<br>
&nbsp;Removed Items<br>
&nbsp;-------------<br>
&nbsp;<br>
+* **Removed ZUC-256 algorithms from Intel QuickAssist Technology (QAT) PMD=
.**<br>
+<br>
+&nbsp; Support for ZUC-256 cipher and integrity algorithms was removed fro=
m<br>
+&nbsp; Gen 3 and Gen 5 PMD.<br>
+<br>
&nbsp;.. This section should contain removed items in this release. Sample =
format:<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp; * Add a short 1-2 sentence description of the removed it=
em<br>
diff --git a/drivers/common/qat/qat_adf/icp_qat_hw.h b/drivers/common/qat/q=
at_adf/icp_qat_hw.h<br>
index 1d61a0b833..e929b16df2 100644<br>
--- a/drivers/common/qat/qat_adf/icp_qat_hw.h<br>
+++ b/drivers/common/qat/qat_adf/icp_qat_hw.h<br>
@@ -367,7 +367,7 @@ enum icp_qat_hw_cipher_convert {<br>
&nbsp;#define ICP_QAT_HW_CHACHAPOLY_ICV_SZ 16<br>
&nbsp;#define ICP_QAT_HW_CHACHAPOLY_AAD_MAX_LOG 14<br>
&nbsp;#define ICP_QAT_HW_ZUC_256_KEY_SZ 32<br>
-#define ICP_QAT_HW_ZUC_256_IV_SZ 24<br>
+#define ICP_QAT_HW_ZUC_256_IV_SZ 16<br>
&nbsp;<br>
&nbsp;#define ICP_QAT_HW_CIPHER_MAX_KEY_SZ ICP_QAT_HW_AES_256_F8_KEY_SZ<br>
&nbsp;<br>
diff --git a/drivers/crypto/qat/dev/qat_crypto_pmd_gen3.c b/drivers/crypto/=
qat/dev/qat_crypto_pmd_gen3.c<br>
index af664fb9b9..f2ff952482 100644<br>
--- a/drivers/crypto/qat/dev/qat_crypto_pmd_gen3.c<br>
+++ b/drivers/crypto/qat/dev/qat_crypto_pmd_gen3.c<br>
@@ -204,7 +204,6 @@ qat_sym_crypto_cap_get_gen3(struct qat_cryptodev_privat=
e *internals,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t legacy_size =3D s=
izeof(qat_sym_crypto_legacy_caps_gen3);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; capa_num =3D size/sizeof(s=
truct rte_cryptodev_capabilities);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; legacy_capa_num =3D legacy=
_size/sizeof(struct rte_cryptodev_capabilities);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct rte_cryptodev_capabilities *ca=
p;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (unlikely(internals-&gt=
;qat_dev-&gt;options.legacy_alg))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; size =3D size + legacy_size;<br>
@@ -258,14 +257,6 @@ qat_sym_crypto_cap_get_gen3(struct qat_cryptodev_priva=
te *internals,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; conti=
nue;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (slice_map &amp; ICP_ACCEL_MASK_ZUC_256_SLICE &amp;&amp; (<br=
>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; check_auth_capa(=
&amp;capabilities[iter],<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RTE_CRYPTO_AUTH_ZUC_EIA3) ||<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; check_cipher_cap=
a(&amp;capabilities[iter],<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RTE_CRYPTO_CIPHER_ZUC_EEA3))) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; continue;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (internals-&gt;qat_dev-&gt;options.has_wireless_sl=
ice &amp;&amp; (<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; check=
_auth_capa(&amp;capabilities[iter],<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RTE_CRYPTO_AUTH_KASUMI_F9) ||<br=
>
@@ -279,27 +270,6 @@ qat_sym_crypto_cap_get_gen3(struct qat_cryptodev_priva=
te *internals,<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; memcpy(addr + curr_capa, capabilities + iter,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sizeo=
f(struct rte_cryptodev_capabilities));<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (internals-&gt;qat_dev-&gt;options.has_wireless_slice &amp;&a=
mp; (<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; check_auth_capa(=
&amp;capabilities[iter],<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RTE_CRYPTO_AUTH_ZUC_EIA3))) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cap =3D addr + c=
urr_capa;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cap-&gt;sym.auth=
.key_size.max =3D 32;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cap-&gt;sym.auth=
.key_size.increment =3D 16;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cap-&gt;sym.auth=
.iv_size.max =3D 25;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cap-&gt;sym.auth=
.iv_size.increment =3D 1;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cap-&gt;sym.auth=
.digest_size.max =3D 16;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cap-&gt;sym.auth=
.digest_size.increment =3D 4;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (internals-&gt;qat_dev-&gt;options.has_wireless_slice &amp;&a=
mp; (<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; check_cipher_cap=
a(&amp;capabilities[iter],<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RTE_CRYPTO_CIPHER_ZUC_EEA3))) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cap =3D addr + c=
urr_capa;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cap-&gt;sym.ciph=
er.key_size.max =3D 32;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cap-&gt;sym.ciph=
er.key_size.increment =3D 16;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cap-&gt;sym.ciph=
er.iv_size.max =3D 25;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cap-&gt;sym.ciph=
er.iv_size.increment =3D 1;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; curr_capa++;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; internals-&gt;qat_dev_capa=
bilities =3D internals-&gt;capa_mz-&gt;addr;<br>
@@ -558,16 +528,8 @@ qat_sym_crypto_set_session_gen3(void *cdev, void *sess=
ion)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (ctx-&gt;qat_cipher_alg =3D=3D<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ICP_QAT_HW_CIPHER_ALGO_SNOW_3G_U=
EA2 ||<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ctx-&gt;qat_cipher_alg =3D=3D<br=
>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ICP_QAT_HW_CIPHER_ALGO_ZUC_3G_128_EEA3 ||<b=
r>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ctx-&gt;qat_cipher_alg =3D=3D ICP_QAT_HW_CI=
PHER_ALGO_ZUC_256))) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ICP_QAT_HW_CIPHER_ALGO_ZUC_3G_128_EEA3))) {=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qat_s=
ym_session_set_ext_hash_flags_gen2(ctx, 0);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; } else if ((internals-&gt;qat_dev-&gt;options.has_wireless_slice=
) &amp;&amp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (ctx-&gt;qat_has=
h_alg =3D=3D ICP_QAT_HW_AUTH_ALGO_ZUC_256_MAC_32 ||<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ctx-&gt;qat_hash_alg =3D=3D ICP_QAT_HW_AUTH=
_ALGO_ZUC_256_MAC_64 ||<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ctx-&gt;qat_hash_alg =3D=3D ICP_QAT_HW_AUTH=
_ALGO_ZUC_256_MAC_128) &amp;&amp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ctx-&gt;qat_cipher_alg !=3D ICP_QAT_HW_CIPH=
ER_ALGO_ZUC_256) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qat_sym_session_=
set_ext_hash_flags_gen2(ctx,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; 1 &lt;&lt; ICP_QAT_FW_AUTH_HDR_FLAG_ZUC_EIA3_BITPOS);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ret =3D 0;<br>
diff --git a/drivers/crypto/qat/dev/qat_crypto_pmd_gen5.c b/drivers/crypto/=
qat/dev/qat_crypto_pmd_gen5.c<br>
index e1302e9b36..5714420e1e 100644<br>
--- a/drivers/crypto/qat/dev/qat_crypto_pmd_gen5.c<br>
+++ b/drivers/crypto/qat/dev/qat_crypto_pmd_gen5.c<br>
@@ -113,11 +113,11 @@ static struct rte_cryptodev_capabilities qat_sym_cryp=
to_caps_gen5[] =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; CAP_RNG_ZERO(aad_size), CAP_RNG_ZERO(iv_size)),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; QAT_SYM_CIPHER_CAP(ZUC_EEA=
3,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; CAP_SET(block_size, 16),<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; CAP_RNG(key_size, 16, 32, 16), CAP_RNG(iv_size, 16, 25, 1)),<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; CAP_RNG(key_size, 16, 16, 0), CAP_RNG(iv_size, 16, 16, 0)),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; QAT_SYM_AUTH_CAP(ZUC_EIA3,=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; CAP_SET(block_size, 16),<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; CAP_RNG(key_size, 16, 32, 16), CAP_RNG(digest_size, 4, 16, 4),<b=
r>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; CAP_RNG_ZERO(aad_size), CAP_RNG(iv_size, 16, 25, 1)),<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; CAP_RNG(key_size, 16, 16, 0), CAP_RNG(digest_size, 4, 16, 4),<br=
>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; CAP_RNG_ZERO(aad_size), CAP_RNG(iv_size, 16, 16, 0)),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; QAT_SYM_CIPHER_CAP(SNOW3G_=
UEA2,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; CAP_SET(block_size, 16),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; CAP_RNG(key_size, 16, 16, 0), CAP_RNG(iv_size, 16, 16=
, 0)),<br>
@@ -128,32 +128,6 @@ static struct rte_cryptodev_capabilities qat_sym_crypt=
o_caps_gen5[] =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RTE_CRYPTODEV_END_OF_CAPAB=
ILITIES_LIST()<br>
&nbsp;};<br>
&nbsp;<br>
-static int<br>
-check_cipher_capa(const struct rte_cryptodev_capabilities *cap,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; enum rte_crypto_cipher_algorithm algo)<br>
-{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (cap-&gt;op !=3D RTE_CRYPTO_OP_TYP=
E_SYMMETRIC)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return 0;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (cap-&gt;sym.xform_type !=3D RTE_C=
RYPTO_SYM_XFORM_CIPHER)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return 0;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (cap-&gt;sym.cipher.algo !=3D algo=
)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return 0;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 1;<br>
-}<br>
-<br>
-static int<br>
-check_auth_capa(const struct rte_cryptodev_capabilities *cap,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; enum rte_crypto_auth_algorithm algo)<br>
-{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (cap-&gt;op !=3D RTE_CRYPTO_OP_TYP=
E_SYMMETRIC)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return 0;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (cap-&gt;sym.xform_type !=3D RTE_C=
RYPTO_SYM_XFORM_AUTH)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return 0;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (cap-&gt;sym.auth.algo !=3D algo)<=
br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return 0;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 1;<br>
-}<br>
-<br>
&nbsp;static int<br>
&nbsp;qat_sym_crypto_cap_get_gen5(struct qat_cryptodev_private *internals,<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const=
 char *capa_memz_name,<br>
@@ -195,14 +169,6 @@ qat_sym_crypto_cap_get_gen5(struct qat_cryptodev_priva=
te *internals,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; capabilities =3D qat_sym_c=
rypto_caps_gen5;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; capa_=
num; i++, iter++) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (slice_map &amp; ICP_ACCEL_MASK_ZUC_256_SLICE &amp;&amp; (<br=
>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; check_auth_capa(=
&amp;capabilities[iter],<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RTE_CRYPTO_AUTH_ZUC_EIA3) ||<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; check_cipher_cap=
a(&amp;capabilities[iter],<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RTE_CRYPTO_CIPHER_ZUC_EEA3))) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; continue;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; memcpy(addr + curr_capa, capabilities + iter,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sizeo=
f(struct rte_cryptodev_capabilities));<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; curr_capa++;<br>
@@ -233,15 +199,8 @@ qat_sym_crypto_set_session_gen5(void *cdev, void *sess=
ion)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (ctx-&gt;qat_cipher_alg =3D=3D<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ICP_QAT_HW_CIPHER_ALGO_SNOW_3G_U=
EA2 ||<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ctx-&gt;qat_cipher_alg =3D=3D<br=
>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ICP_QAT_HW_CIPHER_ALGO_ZUC_3G_128_EEA3 ||<b=
r>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ctx-&gt;qat_cipher_alg =3D=3D ICP_QAT_HW_CI=
PHER_ALGO_ZUC_256)) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ICP_QAT_HW_CIPHER_ALGO_ZUC_3G_128_EEA3)) {<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qat_s=
ym_session_set_ext_hash_flags_gen2(ctx, 0);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; } else if ((ctx-&gt;qat_hash_alg =3D=3D ICP_QAT_HW_AUTH_ALGO_ZUC=
_256_MAC_32 ||<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ctx-&gt;qat_hash_alg =3D=3D ICP_QAT_HW_AUTH=
_ALGO_ZUC_256_MAC_64 ||<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ctx-&gt;qat_hash_alg =3D=3D ICP_QAT_HW_AUTH=
_ALGO_ZUC_256_MAC_128) &amp;&amp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ctx-&gt;qat_cipher_alg !=3D ICP_QAT_HW_CIPH=
ER_ALGO_ZUC_256) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qat_sym_session_=
set_ext_hash_flags_gen2(ctx,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; 1 &lt;&lt; ICP_QAT_FW_AUTH_HDR_FLAG_ZUC_EIA3_BITPOS);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ret =3D 0;<br>
diff --git a/drivers/crypto/qat/dev/qat_crypto_pmd_gens.h b/drivers/crypto/=
qat/dev/qat_crypto_pmd_gens.h<br>
index 846636f57d..1f19c69f88 100644<br>
--- a/drivers/crypto/qat/dev/qat_crypto_pmd_gens.h<br>
+++ b/drivers/crypto/qat/dev/qat_crypto_pmd_gens.h<br>
@@ -881,26 +881,6 @@ qat_sym_convert_op_to_vec_aead(struct rte_crypto_op *o=
p,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
&nbsp;<br>
-static inline void<br>
-zuc256_modify_iv(uint8_t *iv)<br>
-{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint8_t iv_tmp[8];<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; iv_tmp[0] =3D iv[16];<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* pack the last 8 bytes of IV to 6 b=
ytes.<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * discard the 2 MSB bits of eac=
h byte<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; iv_tmp[1] =3D (((iv[17] &amp; 0x3f) &=
lt;&lt; 2) | ((iv[18] &gt;&gt; 4) &amp; 0x3));<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; iv_tmp[2] =3D (((iv[18] &amp; 0xf) &l=
t;&lt; 4) | ((iv[19] &gt;&gt; 2) &amp; 0xf));<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; iv_tmp[3] =3D (((iv[19] &amp; 0x3) &l=
t;&lt; 6) | (iv[20] &amp; 0x3f));<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; iv_tmp[4] =3D (((iv[21] &amp; 0x3f) &=
lt;&lt; 2) | ((iv[22] &gt;&gt; 4) &amp; 0x3));<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; iv_tmp[5] =3D (((iv[22] &amp; 0xf) &l=
t;&lt; 4) | ((iv[23] &gt;&gt; 2) &amp; 0xf));<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; iv_tmp[6] =3D (((iv[23] &amp; 0x3) &l=
t;&lt; 6) | (iv[24] &amp; 0x3f));<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memcpy(iv + 16, iv_tmp, 8);<br>
-}<br>
-<br>
&nbsp;static __rte_always_inline void<br>
&nbsp;qat_set_cipher_iv(struct icp_qat_fw_la_cipher_req_params *cipher_para=
m,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; struct rte_crypto_va_iova_ptr *iv_ptr, uint32_t iv_le=
n,<br>
diff --git a/drivers/crypto/qat/dev/qat_sym_pmd_gen1.c b/drivers/crypto/qat=
/dev/qat_sym_pmd_gen1.c<br>
index 561166203c..8cb85fd8df 100644<br>
--- a/drivers/crypto/qat/dev/qat_sym_pmd_gen1.c<br>
+++ b/drivers/crypto/qat/dev/qat_sym_pmd_gen1.c<br>
@@ -248,9 +248,6 @@ qat_sym_build_op_cipher_gen1(void *in_op, struct qat_sy=
m_session *ctx,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ctx-&gt;is_zuc256)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; zuc256_modify_iv(cipher_iv.va);<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enqueue_one_cipher_job_gen=
1(ctx, req, &amp;cipher_iv, ofs, total_len, op_cookie);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qat_sym_debug_log_dump(req=
, ctx, in_sgl.vec, in_sgl.num, &amp;cipher_iv,<br>
@@ -303,9 +300,6 @@ qat_sym_build_op_auth_gen1(void *in_op, struct qat_sym_=
session *ctx,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ctx-&gt;is_zuc256)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; zuc256_modify_iv(auth_iv.va);<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enqueue_one_auth_job_gen1(=
ctx, req, &amp;digest, &amp;auth_iv, ofs,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; total=
_len);<br>
&nbsp;<br>
@@ -396,11 +390,6 @@ qat_sym_build_op_chain_gen1(void *in_op, struct qat_sy=
m_session *ctx,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ctx-&gt;is_zuc256) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; zuc256_modify_iv(cipher_iv.va);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; zuc256_modify_iv(auth_iv.va);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enqueue_one_chain_job_gen1=
(ctx, req, in_sgl.vec, in_sgl.num,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; out_s=
gl.vec, out_sgl.num, &amp;cipher_iv, &amp;digest, &amp;auth_iv,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ofs, =
total_len, cookie);<br>
@@ -527,9 +516,6 @@ qat_sym_dp_enqueue_single_cipher_gen1(void *qp_data, ui=
nt8_t *drv_ctx,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (unlikely(data_len &lt;=
 0))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return -1;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ctx-&gt;is_zuc256)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; zuc256_modify_iv(iv-&gt;va);<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enqueue_one_cipher_job_gen=
1(ctx, req, iv, ofs, (uint32_t)data_len, cookie);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qat_sym_debug_log_dump(req=
, ctx, data, n_data_vecs, iv,<br>
@@ -591,9 +577,6 @@ qat_sym_dp_enqueue_cipher_jobs_gen1(void *qp_data, uint=
8_t *drv_ctx,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (unlikely(data_len &lt; 0 || error))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break=
;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (ctx-&gt;is_zuc256)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; zuc256_modify_iv=
(vec-&gt;iv[i].va);<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; enqueue_one_cipher_job_gen1(ctx, req, &amp;vec-&gt;iv=
[i], ofs,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (uint=
32_t)data_len, cookie);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; tail =3D (tail + tx_queue-&gt;msg_size) &amp; tx_queu=
e-&gt;modulo_mask;<br>
@@ -644,9 +627,6 @@ qat_sym_dp_enqueue_single_auth_gen1(void *qp_data, uint=
8_t *drv_ctx,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (unlikely(data_len &lt;=
 0))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return -1;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ctx-&gt;is_zuc256)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; zuc256_modify_iv(auth_iv-&gt;va);<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ctx-&gt;qat_hash_alg =
=3D=3D ICP_QAT_HW_AUTH_ALGO_NULL) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; null_digest.iova =3D cookie-&gt;digest_null_phys_addr=
;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; job_digest =3D &amp;null_digest;<br>
@@ -716,9 +696,6 @@ qat_sym_dp_enqueue_auth_jobs_gen1(void *qp_data, uint8_=
t *drv_ctx,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (unlikely(data_len &lt; 0 || error))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break=
;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (ctx-&gt;is_zuc256)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; zuc256_modify_iv=
(vec-&gt;auth_iv[i].va);<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (ctx-&gt;qat_hash_alg =3D=3D ICP_QAT_HW_AUTH_ALGO_=
NULL) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; null_=
digest.iova =3D cookie-&gt;digest_null_phys_addr;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; job_d=
igest =3D &amp;null_digest;<br>
@@ -774,11 +751,6 @@ qat_sym_dp_enqueue_single_chain_gen1(void *qp_data, ui=
nt8_t *drv_ctx,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (unlikely(data_len &lt;=
 0))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return -1;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ctx-&gt;is_zuc256) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; zuc256_modify_iv(cipher_iv-&gt;va);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; zuc256_modify_iv(auth_iv-&gt;va);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ctx-&gt;qat_hash_alg =
=3D=3D ICP_QAT_HW_AUTH_ALGO_NULL) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; null_digest.iova =3D cookie-&gt;digest_null_phys_addr=
;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; job_digest =3D &amp;null_digest;<br>
@@ -849,11 +821,6 @@ qat_sym_dp_enqueue_chain_jobs_gen1(void *qp_data, uint=
8_t *drv_ctx,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (unlikely(data_len &lt; 0 || error))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break=
;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (ctx-&gt;is_zuc256) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; zuc256_modify_iv=
(vec-&gt;iv[i].va);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; zuc256_modify_iv=
(vec-&gt;auth_iv[i].va);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (ctx-&gt;qat_hash_alg =3D=3D ICP_QAT_HW_AUTH_ALGO_=
NULL) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; null_=
digest.iova =3D cookie-&gt;digest_null_phys_addr;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; job_d=
igest =3D &amp;null_digest;<br>
diff --git a/drivers/crypto/qat/qat_sym_session.c b/drivers/crypto/qat/qat_=
sym_session.c<br>
index 7f370f03fb..8489e26e28 100644<br>
--- a/drivers/crypto/qat/qat_sym_session.c<br>
+++ b/drivers/crypto/qat/qat_sym_session.c<br>
@@ -541,8 +541,6 @@ qat_sym_session_configure_cipher(struct rte_cryptodev *=
dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto =
error_out;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; session-&gt;qat_mode =3D ICP_QAT_HW_CIPHER_ECB_MODE;<=
br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (cipher_xform-&gt;key.length =3D=3D ICP_QAT_HW_ZUC_256_KEY_SZ=
)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; session-&gt;is_z=
uc256 =3D 1;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (internals-&gt;qat_dev-&gt;options.has_wireless_sl=
ice)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; is_wi=
reless =3D 1;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
@@ -989,25 +987,8 @@ qat_sym_session_configure_auth(struct rte_cryptodev *d=
ev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rte_cryptodev_get_auth_algo_stri=
ng(auth_xform-&gt;algo));<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retur=
n -ENOTSUP;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (key_length =3D=3D ICP_QAT_HW_ZUC_3G_EEA3_KEY_SZ)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (key_length =3D=3D ICP_QAT_HW_ZUC_3G_EEA3_KEY_SZ) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sessi=
on-&gt;qat_hash_alg =3D ICP_QAT_HW_AUTH_ALGO_ZUC_3G_128_EIA3;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; else if (key_length =3D=3D ICP_QAT_HW_ZUC_256_KEY_SZ) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (auth_xfo=
rm-&gt;digest_length) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case 4:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; session-&gt;qat_hash_alg =3D ICP_QAT_HW_AUT=
H_ALGO_ZUC_256_MAC_32;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case 8:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; session-&gt;qat_hash_alg =3D ICP_QAT_HW_AUT=
H_ALGO_ZUC_256_MAC_64;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case 16:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; session-&gt;qat_hash_alg =3D ICP_QAT_HW_AUT=
H_ALGO_ZUC_256_MAC_128;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; QAT_LOG(ERR, &quot;Invalid digest length: %=
d&quot;,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; auth_xform-&gt;digest_=
length);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -ENOTSUP;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; session-&gt;is_z=
uc256 =3D 1;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; } else {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; QAT_L=
OG(ERR, &quot;Invalid key length: %d&quot;, key_length);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retur=
n -ENOTSUP;<br>
@@ -2238,8 +2219,8 @@ int qat_sym_cd_cipher_set(struct qat_sym_session *cde=
sc,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; cdesc-&gt;qat_proto_flag =3D QAT_CRYPTO_PROTO_FLAG_ZU=
C;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (cdesc-&gt;qat_c=
ipher_alg =3D=3D<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ICP_Q=
AT_HW_CIPHER_ALGO_ZUC_256) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (cdesc-&gt;cipher_iv.length !=3D 23 &amp;&amp; cdesc-&gt;ciph=
er_iv.length !=3D 25) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; QAT_LOG(ERR, &qu=
ot;Invalid IV length for ZUC256, must be 23 or 25.&quot;);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (cdesc-&gt;cipher_iv.length !=3D ICP_QAT_HW_ZUC_256_IV_SZ) {<=
br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; QAT_LOG(ERR, &qu=
ot;Invalid IV length for ZUC256&quot;);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retur=
n -EINVAL;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; total_key_size =3D ICP_QAT_HW_ZUC_256_KEY_SZ +<br>
diff --git a/drivers/crypto/qat/qat_sym_session.h b/drivers/crypto/qat/qat_=
sym_session.h<br>
index 2ef2066646..0c7b9cc6cf 100644<br>
--- a/drivers/crypto/qat/qat_sym_session.h<br>
+++ b/drivers/crypto/qat/qat_sym_session.h<br>
@@ -147,7 +147,6 @@ struct qat_sym_session {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint8_t is_auth;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint8_t is_cnt_zero;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Some generations need d=
ifferent setup of counter */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint8_t is_zuc256;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint8_t is_wireless;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t slice_types;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct rte_net_crc *crc;<b=
r>
-- <br>
2.43.0<br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_DS0PR11MB7458C75FF5E750AFE8263DFE816FADS0PR11MB7458namp_--
