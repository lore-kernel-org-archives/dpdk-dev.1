Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 354A860A2624
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 14:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=B/TwPbxr
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 796D74042F;
	Tue,  3 Nov 2026 15:52:43 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTPS id CD0AE402DE;
 Tue,  3 Nov 2026 15:52:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793717562; x=1825253562;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:mime-version;
 bh=aNJQaAHgzeodgKgpKMYEQHoWyw/anJi9ls3Fd1IqEPY=;
 b=B/TwPbxrSwN5n+41//jwLn/AIIRlTfAxcOyrEBQXLR7bxdbZ9r9Ph+21
 l8059vo0XxrwEGOwZKc5lQni4tbmGuCIHk6ct6MHd1zZfm4L2PFZIspZS
 Ui1iagUu1TjMOJiKWSj52UvhQUOLO3m1mLRfo+Xr3ZZsisSJXsBCO0nh2
 3q/wsWf9TeCCVY5PKOyQT0dfXWnV6lWu3fXSDJk8TkMAs3BAusyihSdZQ
 OwH3phI8LVWJpNTkl+CG68Y03rdbD0Luz//dK4zgMfdaVFrok8+HVQmGu
 Nr6e8meDhkszS5Geyxk03lfF2q6gFGHvBUosliufBXwsrV/ckIirX1cA8 Q==;
X-CSE-ConnectionGUID: 6VZ3G/mVS2KnU6Y7+Pl1IA==
X-CSE-MsgGUID: EabHgMIQS1K/jkCNl8G5xg==
X-IronPort-AV: E=McAfee;i="6800,10657,11955"; a="2474271"
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; d="scan'208,217";a="2474271"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Nov 2026 06:52:40 -0800
X-CSE-ConnectionGUID: pQWyOImdQXi8dtolC+47ew==
X-CSE-MsgGUID: QKJn5PyVTui7m5v5b9rMhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; d="scan'208,217";a="6768366"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Nov 2026 06:52:40 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 3 Nov 2026 06:52:39 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Tue, 3 Nov 2026 06:52:39 -0800
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.10) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 3 Nov 2026 06:52:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J2H4wyEO4S8dHu/Nu4NuZUqElBWUN0jUDAh8n6g+qRZi5Pxm33UaJdsadf/sdUbwiPTl6n9TJSoG3h+wSZ/3eYuf+7IdoYYs/MgaNB7K4Vlnxheeipi4hwiDlt7Igv1X9gZMhHZ4O8SdrLfAuIm+PLS/08xXfdsjGUNoKJmu0k49hT6AJfWiv/uIqh4iTiw7wAx463n88uDtyTXUwCqrOsfsAgLFzovG1g2o94+uSmCdg6pDKLy2+3GQ2eXqlkf3yVIy6pNBqY29wr4gH3NiURB5fi5GwIh2i6rFa/VTXTm9LRWv6V/XldFiFtueE33q88QOIPJiWfMHcgm/JNixbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xH/RzQlt75opDTLGvjARCEV0G7O3OKyskWNL+7Qi/lM=;
 b=PHDjAylHb6l+cv3rwbAzOhCr5E/oCUgXZdu+Apx31X1UjC1J5qDq0M0aZvlLbEWNl3d5dnnIR5vBcNaeBf+vC/u4uSwFVOCrht59jCeNWG/MY3g1+D+BdyZK3++tYR5jGkZDCnL/vc9AlHnpe/jCJZuoXAbryD96NCoGVtI5oGfdF6nfA9x6+xFCoOhMwiecdwWtYMIPjM0xQyEgaFM8l3VN/3YPQL96BzbAJ6QEpr6pbvqCNtn/Wg2OI8RyKdHPOWjVupKS/25JT4ABvGanRGhfSvWL9RXdeLpGnXdnPY162B84lUQyo1O6NTZ0xxht9Ts4JtNcQEWx2u3hwQRwkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS7PR11MB6037.namprd11.prod.outlook.com (2603:10b6:8:74::5) by
 PH7PR11MB6772.namprd11.prod.outlook.com (2603:10b6:510:1b6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Tue, 3 Nov 2026
 14:52:33 +0000
Received: from DS7PR11MB6037.namprd11.prod.outlook.com
 ([fe80::24c2:b261:ba79:a64e]) by DS7PR11MB6037.namprd11.prod.outlook.com
 ([fe80::24c2:b261:ba79:a64e%5]) with mapi id 15.21.0592.007; Tue, 3 Nov 2026
 14:52:32 +0000
From: "Ji, Kai" <kai.ji@intel.com>
To: Sun Yuechi <sunyuechi@iscas.ac.cn>, Akhil Goyal <gakhil@marvell.com>,
 Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "stable@dpdk.org" <stable@dpdk.org>
Subject: Re: [PATCH] crypto/openssl: fix SM2 encryption output length
Thread-Topic: [PATCH] crypto/openssl: fix SM2 encryption output length
Thread-Index: AQHdZVS0ZUtqcct+O0W4xbummMUtobccewgP
Date: Tue, 3 Nov 2026 14:52:32 +0000
Message-ID: <DS7PR11MB603704F7F9C0F285B47F195A81692@DS7PR11MB6037.namprd11.prod.outlook.com>
References: <20261026141652.2484406-1-sunyuechi@iscas.ac.cn>
In-Reply-To: <20261026141652.2484406-1-sunyuechi@iscas.ac.cn>
Accept-Language: en-GB, en-US, en-IE
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR11MB6037:EE_|PH7PR11MB6772:EE_
x-ms-office365-filtering-correlation-id: 10a9015a-7a6d-4a92-842c-08df39ba1761
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|42112799006|38070700021|11063799006|56012099006|261009221227099003|261009223027099003|261022105027099003|261102123227099003|261021121427099003|261028144727099003|261026140227099003|261026121527099003|10067099003|22082099003|18002099003|3023799007|8096899003;
x-microsoft-antispam-message-info: kcZlz5dshnFi4z6IgjbhiPD45qg/97NWg/wkUW5ca/5QkpCzyboNdXTI4Pbg+/bL3GdExOZoA5BUVYBp5idZCU3LWTk6dVlSwg1ceMLiNBzolu9sdF6DRhRGTsiiDTBoM6j1L9kV2sL1cPtCymwjz9/z7BIWaaiRK5DjIsN+C6h3seVooApBkFt041LtxQZ4ggLBsiHpRhUI6DWP1E4ENH24t7Tpw7rNsdrhjW0WWGsevWz8KVAvUSijziaHG+GZ5jyiXgvYOARHWRHrWL4ZYGOIHuretJOHS9AoFlnShhgdyAg93ALhXqoUE2yE2cRcELfQuBENq1j/XgMxEQmTcjsIMoMifvnpmVg1T6t4RcUWCGDr2QBqKb9o21inRdPs7P5CsQCXdriWXJEHDBDuAHCRzHZN0FujfuUy8RoulhS7pL/7K4Rh7hKMXV1bNqbqg1l4xprct8n+un/ICdK3rWXw/szkLrnrzRYam/FoKTwOExoTJ2qVaF7N3qI7KQyOJkQ0dZml0WY94uqwq7m4rIPIamjnO6JyykW16hBAiAfX1HwSFx+JxkT/ToDGnmH4KQvoEPxb2FVz7BAWF8uom4thV/9MgIeuyUE6MIWJ1tyqXZBAwqjV3UPBjxfZaQw/Y5OQg4GhH6JiBMYKdJ4jNdEIJwFnlW/AUUKg5pVOAt0J7xAItI1DtpRzMrcgg3T19gh/vxl3bK4GbbG+3pav54ZDzIUdFz1FZe4BixQOu4Q=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR11MB6037.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(42112799006)(38070700021)(11063799006)(56012099006)(261009221227099003)(261009223027099003)(261022105027099003)(261102123227099003)(261021121427099003)(261028144727099003)(261026140227099003)(261026121527099003)(10067099003)(22082099003)(18002099003)(3023799007)(8096899003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?/3W5amfUNz7TyeBRRYv7lbb1F9XgYWNBa+bZWpRpYcyz8Pw3T59pI35qA2?=
 =?iso-8859-1?Q?JnCXzrJYZCn09qZMGwzKjNAivi7vfUcCkPBX5MnkrQ2lZPzhtc5KB9mXCH?=
 =?iso-8859-1?Q?c5rlJ+hElO49QKLCWeWRFoPrTZo0zYy4uNYbaj0qYwx13ZyQ2w7Lau3loh?=
 =?iso-8859-1?Q?z+xSDmszIxb13y0hEHUJd1Ny7VfZ52IJEBrqc63FjLYOqTdvZjjqE/wXQI?=
 =?iso-8859-1?Q?WVfQbRwVAyMGqboJk4nn/ME4slVFBJojVwyq7BS+DzfGXucP8pQfBgMQzH?=
 =?iso-8859-1?Q?SoQXEo9nKfAVpSTJ9bl8+aye/1q3r9SIQoaMEZZ9eSJ2/tLOxjJp2MFYjX?=
 =?iso-8859-1?Q?vysimFQR9DU3sOx/bDbA/9ZlqSyg5/n0/8baG069ePsjyzI63cxBDDFmrk?=
 =?iso-8859-1?Q?o72cmYPSawd53lJfb3pkKTSBkWlvpNrLGevCSZA1VABbohQyN1vF27WryQ?=
 =?iso-8859-1?Q?+2jf1xBJJd91KX+sf3X10FR6vNtWvd7Dhad7WB2ostgiSSm8STeZIWYeAe?=
 =?iso-8859-1?Q?2wuQDBXfysoUIcbQ+asXbEpwbl0XmbxkdQYiGqqQMSyOsObH/mpzJmWuzv?=
 =?iso-8859-1?Q?lsiwWt+SH7n06WkNgZZEAX/PLjcX+NJ8Nh2qqZwVSn9UzN9KBOJ/C+YjTU?=
 =?iso-8859-1?Q?dTuYy7ABaGA2kkBYWLcL/2EL+GkLOT2F9rXXOQe2LCxKMrkkwYc6NpT5im?=
 =?iso-8859-1?Q?r45AU2CwAS8PDP3enj1ZO5g/h+WGogP8OPvaFQPDdngCTABqWUbU/BZWIK?=
 =?iso-8859-1?Q?T2mVGurSTGjLwSNUixR35VB3Ald5GmhYAJw6lx0F/GGSmVnoIn/G7mM3cr?=
 =?iso-8859-1?Q?1QkYIGvb/l3ZW+wiwIH8eyFB91WiVk2dD08p45jsDF+VolKZu5GXMiX11V?=
 =?iso-8859-1?Q?bMDh8D0Ga3Wb5WA/ae2/hwTD0cWvb2iffF9v8xDv26ofXRJ7LnabHB30Ja?=
 =?iso-8859-1?Q?B3vLG9ykTitpe+pybl2HLIqiiYnQkEb+kipeWPZ28vut01qxfuS53KA8IB?=
 =?iso-8859-1?Q?nMJld/Thlp5nqkwj8OV+j3oDOIQcOWKuVLhDEXN6TMXFS/sKKTW9xb4R+N?=
 =?iso-8859-1?Q?HkX+4AD1/S3wi3Q24tbpNqW+E54t3YU80QnaoTSGq4vzZ8RHxKW1s+M3Ba?=
 =?iso-8859-1?Q?OBVN5FwYZr9XR+0atwnHcZBLZZW+7dkSRnJSV/Pxm++m+/mRgnpwyYK5Kl?=
 =?iso-8859-1?Q?Em0h8dr+wpjVsBdJLFlKSBgMfI82cmBU8w/7BHzQRZ4xdc5EvWKpqYbOVi?=
 =?iso-8859-1?Q?h7KNatKu+kXTeNZv/3TkARJPAOBxgR9SALP+gSw3sXKkyV84xk8Vn4zddO?=
 =?iso-8859-1?Q?lXA1sBYOp7mii2LE89ogzPQXXHiW3tyUZ8AcGNq+Ln/9g1DDHQikEi1UQy?=
 =?iso-8859-1?Q?7QrDRy6VGMEjGrpx/aOCkeW0hobpAzJMa9YYYCyo9Pls+k1fNUeLpjPJkE?=
 =?iso-8859-1?Q?GZc+PiZYfKD+fxGeM80bse2Dhn/Ru7m6VeRciDCwgpaVyIdOd0UkLug8oG?=
 =?iso-8859-1?Q?8RMiWbgP1OwFoE5iMenohOAplMa/EaAE4YCFkEi9Vo7Thg4628oek8uJna?=
 =?iso-8859-1?Q?bavPjBznEqGwTCemgPDNXhbXmj3zRmy3KMOgCubE+8QIcCScfT87dssBht?=
 =?iso-8859-1?Q?eN+OK+eB1dDp9LfnLjpNehww4sOMij8GLLRddNxuV9DSEX+0rKfbFgpito?=
 =?iso-8859-1?Q?duoREV3rIibeDMB4E9XpCRp/uRKKhKcuQdplTaRXUfM6KWfqczrVr5/oFY?=
 =?iso-8859-1?Q?w3OzLc66cySin2t9wq4cwKC6UC3XQynh5uOlSW9wWUC0ux?=
Content-Type: multipart/alternative;
 boundary="_000_DS7PR11MB603704F7F9C0F285B47F195A81692DS7PR11MB6037namp_"
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 1S21slJljcVdwZmQAZC4aM1XXVIxkxUMQBDmVqyWK5x2Z5EJQpei0Tg2PJJgOJ/4hLRhxInRn3GsroHdCEW0PX+uhFYqJXmQH+b8S+R52o2B2Z0MZ7LWNjD+7+rAvSbCXfZZeauZtxUMPmbAjQu2nKREghIr9adrNcQ3Az+n5xF3h7Tnw8uap01Qe+mCWZD8Et3gBNEl1Mbf3LCWIqXWBCOYWnpcTbqm17SYPynCYQxI46VGncqkRWLpVCwsuK0aCQdioH6/3BzRhE7p2XSLDQt7BYhl1Bq6poQ+FCexXD+TRQHCvTwGCpxFD8GXdzPIVaR5gdWw7aBCp2XBV3Z9HA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB6037.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10a9015a-7a6d-4a92-842c-08df39ba1761
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2026 14:52:32.8772 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gD0qh8RduB2rb93z7UHwgooIAlz5RMuiZVPQnh0g6uzO3vVZjM3d3q/+Hb14DQQqRFslbRXijHZNan+kfRNjHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6772
X-OriginatorOrg: intel.com
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--_000_DS7PR11MB603704F7F9C0F285B47F195A81692DS7PR11MB6037namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Acked-by: Kai Ji <kai.ji@intel.com>


________________________________
From: Sun Yuechi <sunyuechi@iscas.ac.cn>
Sent: Monday, October 26, 2026 14:16
To: Ji, Kai <kai.ji@intel.com>; Akhil Goyal <gakhil@marvell.com>; Gowrishan=
kar Muthukrishnan <gmuthukrishn@marvell.com>
Cc: dev@dpdk.org <dev@dpdk.org>; Sun Yuechi <sunyuechi@iscas.ac.cn>; stable=
@dpdk.org <stable@dpdk.org>
Subject: [PATCH] crypto/openssl: fix SM2 encryption output length

SM2 encryption passed a zero output length to EVP_PKEY_encrypt(),
which OpenSSL 3.6.3 and later reject as "buffer too small".
Query the required length first, as the RSA path does.

Fixes: 3b7d638fb11f ("crypto/openssl: support asymmetric SM2")
Cc: stable@dpdk.org
Signed-off-by: Sun Yuechi <sunyuechi@iscas.ac.cn>
---
 drivers/crypto/openssl/rte_openssl_pmd.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/crypto/openssl/rte_openssl_pmd.c b/drivers/crypto/open=
ssl/rte_openssl_pmd.c
index 1b33470c8f..8791186fec 100644
--- a/drivers/crypto/openssl/rte_openssl_pmd.c
+++ b/drivers/crypto/openssl/rte_openssl_pmd.c
@@ -2791,6 +2791,10 @@ process_openssl_sm2_op_evp(struct rte_crypto_op *cop=
,
                         if (!EVP_PKEY_CTX_set_params(cctx, eparams))
                                 goto err_sm2;

+                       if (!EVP_PKEY_encrypt(cctx, NULL, &output_len,
+                                       op->sm2.message.data, op->sm2.messa=
ge.length))
+                               goto err_sm2;
+
                         if (!EVP_PKEY_encrypt(cctx, op->sm2.cipher.data, &=
output_len,
                                                                  op->sm2.m=
essage.data,
                                                                  op->sm2.m=
essage.length))
--
2.56.0


--_000_DS7PR11MB603704F7F9C0F285B47F195A81692DS7PR11MB6037namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family: &quot;IntelOne Text&quot;; font-size: 10pt; colo=
r: rgb(0, 0, 0);">
<span style=3D"color: rgb(0, 0, 0);"></span>Acked-by: Kai Ji &lt;kai.ji@int=
el.com&gt;</div>
<div><br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<hr style=3D"display: inline-block; width: 98%;">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<b>From:</b> Sun Yuechi &lt;sunyuechi@iscas.ac.cn&gt;<br>
<b>Sent:</b> Monday, October 26, 2026 14:16<br>
<b>To:</b> Ji, Kai &lt;kai.ji@intel.com&gt;; Akhil Goyal &lt;gakhil@marvell=
.com&gt;; Gowrishankar Muthukrishnan &lt;gmuthukrishn@marvell.com&gt;<br>
<b>Cc:</b> dev@dpdk.org &lt;dev@dpdk.org&gt;; Sun Yuechi &lt;sunyuechi@isca=
s.ac.cn&gt;; stable@dpdk.org &lt;stable@dpdk.org&gt;<br>
<b>Subject:</b> [PATCH] crypto/openssl: fix SM2 encryption output length </=
div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-size: 11pt;">SM2 encryption passed a zero output length =
to EVP_PKEY_encrypt(),<br>
which OpenSSL 3.6.3 and later reject as &quot;buffer too small&quot;.<br>
Query the required length first, as the RSA path does.<br>
<br>
Fixes: 3b7d638fb11f (&quot;crypto/openssl: support asymmetric SM2&quot;)<br=
>
Cc: stable@dpdk.org<br>
Signed-off-by: Sun Yuechi &lt;sunyuechi@iscas.ac.cn&gt;<br>
---<br>
&nbsp;drivers/crypto/openssl/rte_openssl_pmd.c | 4 ++++<br>
&nbsp;1 file changed, 4 insertions(+)<br>
<br>
diff --git a/drivers/crypto/openssl/rte_openssl_pmd.c b/drivers/crypto/open=
ssl/rte_openssl_pmd.c<br>
index 1b33470c8f..8791186fec 100644<br>
--- a/drivers/crypto/openssl/rte_openssl_pmd.c<br>
+++ b/drivers/crypto/openssl/rte_openssl_pmd.c<br>
@@ -2791,6 +2791,10 @@ process_openssl_sm2_op_evp(struct rte_crypto_op *cop=
,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!=
EVP_PKEY_CTX_set_params(cctx, eparams))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto err_sm2;<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!EVP_PKEY_en=
crypt(cctx, NULL, &amp;output_len,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; op-&gt;sm2.message.data, op-&gt;sm2.message.length))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto err_sm2;<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!=
EVP_PKEY_encrypt(cctx, op-&gt;sm2.cipher.data, &amp;output_len,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; op-&gt;sm2.message.data,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; op-&gt;sm2.message.length))<br>
--<br>
2.56.0<br>
<br>
</div>
</body>
</html>

--_000_DS7PR11MB603704F7F9C0F285B47F195A81692DS7PR11MB6037namp_--
