Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3B560A5BD0
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Nov 2026 16:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=EQ8B5PnU
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D8A0E40297;
	Wed, 11 Nov 2026 17:18:50 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTPS id 1028D4026A;
 Wed, 11 Nov 2026 17:18:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794413929; x=1825949929;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:mime-version;
 bh=3HjEKeeEyTCEhiGZRZnMKXeBbI5T4zVbRFfEizxA3xM=;
 b=EQ8B5PnUY5C0E9QpHP7wboetDDtYCsvBCZDdvJrZ4ZghOOQZMjlpZlWe
 1NE87W99bu8nVzD+EN69IK338cxZ/On94GAqZWYALk9nhSj7ES0Bzl6ee
 jodH+u349uq5BrAz9dLKLyASorsy3V4LaHO52RW8NruBIQEJEvDnJUOaC
 1emvEvXZy/qnsc7SBeIfwLq+0lo3nvqh6h128kSZEXL6E08eXeGfTn+hI
 w3gwzUnd049Kar1+9dB4Imz3jSSiM/BqCA2K79CP4wslJFwLhh8Ho3nKj
 LCkikF31RWbOqdO4RDstQj1vyrfS34KZAQtYmD3/BzxWNAVVGZng2aomu g==;
X-CSE-ConnectionGUID: COKopTofSi60XTyP/fr5IQ==
X-CSE-MsgGUID: SAFTFwmHTsGKqXBChw+lVQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11963"; a="3089198"
X-IronPort-AV: E=Sophos;i="6.27,208,1787036400"; d="scan'208,217";a="3089198"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Nov 2026 08:18:46 -0800
X-CSE-ConnectionGUID: nLcQ+4XuQ0W5wznyVvKmmA==
X-CSE-MsgGUID: mfRG8QHWSde2XCBjJ2dSwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,208,1787036400"; d="scan'208,217";a="10173753"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa012.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Nov 2026 08:18:46 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 11 Nov 2026 08:18:45 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Wed, 11 Nov 2026 08:18:45 -0800
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.2) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 11 Nov 2026 08:18:45 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wJxUaE4PMJ3IyVaTDALOLq0+/pJNzyuWz+af1iRk0igRG5rmp2UvMrGbhRFOtX/gmlcCEfheIpKww4M6BcAbeLLSxswBNvqwEY+H5rosz3X7QHnuLXJ6FiXVmkjnEcoCE5Iy4DDlV2lolAg8pJq53zovOAPCNinx8M+0XtmrrYxE3ABBUsBU+iGaaD+WHZ7wnFFY7gnss7WbUIXGlmi5J1+qyBZUfGemF/FagVecNv/hvGbTYNHaSiGMCgxgfg8KmOJuhAc7W81D1V//t43rR4JrTsOA1vplIDf1crN/wEyLuTTg4eZjBCQI8Owk1J0au5SPOnQWl7NhLJ+hbPrhSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=81sx/0PRDBltcvrHO3yhhEedKT95Ez5ACcl1CO5RuaM=;
 b=zL6TOfLGB8HJhtpsFtI1Vf9xe4s7yoa754DBKq2tjHtVv/nMHdkAp3vvaTlfTTi0iJxsiv/wHd102Qcu4jqcLZ2GvGkFPTtbFmerwOZEQqjPuxoaADBofSZVB4rU46wgAqlaQs08wmuslW3oG066rvoLlm6eLOL73RGtUaaa0zdKS0RP5Wm0EQyH7YpkXzkfQPlmBEvKmSW9kjj56DvvlqLfSSlRfw7FefbzFrjmnEdjpfCnZx96z2DSHlp1U7IYv0/VCZt+6/x3zqMXGvNstKFHBP6BrzvYYjsmXzxdam+WFVI7WTLrk2WwZVw6zHCHCmPpI4KHV42V5cQcLC74oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV2PR11MB6045.namprd11.prod.outlook.com (2603:10b6:408:17b::20)
 by CH3PR11MB665988.namprd11.prod.outlook.com (2603:10b6:610:365::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.9; Wed, 11 Nov
 2026 16:18:43 +0000
Received: from LV2PR11MB6045.namprd11.prod.outlook.com
 ([fe80::1f72:3d49:b6ba:91ae]) by LV2PR11MB6045.namprd11.prod.outlook.com
 ([fe80::1f72:3d49:b6ba:91ae%6]) with mapi id 15.21.0615.008; Wed, 11 Nov 2026
 16:18:43 +0000
From: "Ji, Kai" <kai.ji@intel.com>
To: "Nicolau, Radu" <radu.nicolau@intel.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: "stable@dpdk.org" <stable@dpdk.org>, Akhil Goyal <gakhil@marvell.com>, Fan
 Zhang <fanzhang.oss@gmail.com>, "Kundapura, Ganapati"
 <ganapati.kundapura@intel.com>
Subject: Re: [PATCH] test/crypto: fix callback test case
Thread-Topic: [PATCH] test/crypto: fix callback test case
Thread-Index: AQHdcc35dD1i+wAZYUmtBXt/4zhbhLcpDN6U
Date: Wed, 11 Nov 2026 16:18:43 +0000
Message-ID: <LV2PR11MB6045CC87C0986FC242827F5D81712@LV2PR11MB6045.namprd11.prod.outlook.com>
References: <20261111111441.3031123-1-radu.nicolau@intel.com>
In-Reply-To: <20261111111441.3031123-1-radu.nicolau@intel.com>
Accept-Language: en-GB, en-US, en-IE
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR11MB6045:EE_|CH3PR11MB665988:EE_
x-ms-office365-filtering-correlation-id: 2d699d3c-2e24-403e-69bc-08df400f747e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|42112799006|38070700021|10067099003|11063799006|56012099006|261022105027099003|261022075727099003|261021121427099003|261021123027099003|261021135927099003|261026140227099003|261028144727099003|261102123227099003|261009223027099003|22082099003|18002099003|8096899003|3023799007;
x-microsoft-antispam-message-info: cZ3c+u954qj5izxhKBcQlMkKR8M2FrhCQTO5CitcIp9jhi3GjFIR5JjrwFTocspFyiLdF4iLhyxfYrdIe9QvbO2Tk/wayXIluT528jTfF4jnuExJJjAm/uYZWKkEXMoLgnRrkc1lQ+OUckPkIq2UwWT7HDXGXY0dHkWkUckhiuz+CGj70OUfTam1jtntfNyuphTbGPwHd2woLBJuom39BOJnrb2ROqJP1bkSXI3fGYrDZRoumsPkffoirIX/2wG94p49luG7aenTuG8H/OCBmx3BAnhqHkH7qopVWnE4guXeDLCOGv0apG4dBYEItTb5qFYXcNXCLp4od/374YsZTbewr6NGzG3DgwGqvSRuS81ydy3+3/NY+wJuOWPTohx58w+UUUrcuEp/vMSk4YmUeVRaDzVvgCcjTUCE2sy3uQOYJ6qsDrg170PCIZQOlN6LS/v6+GYfwo7gACQNnPGzMsd8s/ggj2luGI6gNqMbWeZQM4JjfSR01OKEm2gqfACB2uafXFDo3VdUWRAa9KWChDkMDSi58w1/5PP7cs/yS7a7kA8TsGwJupz8mwFzQeNQWYzb0b6+TJSsZX+g9aVvVmYMkYSJI+oO6l3yZfuXV1p/dwsNPIfYbvD0ZNFMMaZkvdWwvgiYa/N3nWlY1203MMKHCn/rwJLd+175gGopxqnKorCJ66cg96GqILyF++CaxKEm/b+atx9qhbNH9HEH58vlBwZ164bp9bcUwrNrycg=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV2PR11MB6045.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(42112799006)(38070700021)(10067099003)(11063799006)(56012099006)(261022105027099003)(261022075727099003)(261021121427099003)(261021123027099003)(261021135927099003)(261026140227099003)(261028144727099003)(261102123227099003)(261009223027099003)(22082099003)(18002099003)(8096899003)(3023799007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?E0FWHEIitCnKTRJjpVZGn9DiyqLq3anAfM7eMLG0PUS4o+amx8crMOwrgv?=
 =?iso-8859-1?Q?K0+bJBm00kAzcNBXNmoRYFIi883DxNLuBtLZd9sSO0GmTMNZILpN8d20dd?=
 =?iso-8859-1?Q?ZgHeAxR0rGkbKgVgp0BKCKMFzRYB9SHpEBrwxQet7c8sluEWVmlOmXzqiU?=
 =?iso-8859-1?Q?/TNrOIGn5xtn98NFCUtbv4a9PenP+mQPsCJHpXSf2MtqNWJudzU/325Srk?=
 =?iso-8859-1?Q?HGeiNaj2/sNwcRUR5pAeKtnGV/4rgMnc1EUI+3a8JdZgSs0OOdL6iSNRg9?=
 =?iso-8859-1?Q?0MsoTONeAHepFqGO7bjN3NaSyBM3SO6mDbK6j4nGVW8nu2krEiiGdHDoEN?=
 =?iso-8859-1?Q?w+HRcm0GbO83eUELa9XThXsUybEuxZ1zEK1nfyCuzl+UKbUsmqQsOPNHg3?=
 =?iso-8859-1?Q?XkH8rQBgw0+FUsJW+hwXlbxgLQkLBAkFh11mAblddd+Uk0u0CZG4mSL0kT?=
 =?iso-8859-1?Q?UfSObGBn9FAsP37d9vAZpBkEDuGvcREkwrXP6/Rp1jsn3fiDqqUhQoUVHn?=
 =?iso-8859-1?Q?vuRQvbNM1XuDQpTs+2dtXotBPEVuG1n2ye6SDaBjZn24LNWJqQsNRa3yMp?=
 =?iso-8859-1?Q?q3cxkdrGI3ufedODliQpVHJNqyy9+W0eLxzemLBhc6whtxdAkXDU13/LD6?=
 =?iso-8859-1?Q?OmDZ9fHD9ZfnytNIiOxyMZsjrLMMxxGxUlXtXjDYY8SqAPjLwarrLjcI80?=
 =?iso-8859-1?Q?LPAJACzOvnI4OyQIHsPhhM3ceCDTuGnhj4zVwX/qq2bIgMZRnZjhWikgvU?=
 =?iso-8859-1?Q?0CK65PlvbmNUbD0Xm3RmZcGfxijhgKxDdZwfblXpl6gfxiJnLTsUrzR2kl?=
 =?iso-8859-1?Q?AddJIh3VLRwku1TSAq/Gy9TAw6AuZftocpCP8cRzdMVwIh5h3niW4NiJ8s?=
 =?iso-8859-1?Q?gxGWYTrJzHTBo1lYFe5FMKTEWeviHKlfUWNmPrwWuPuAWll8+DdNa+6k+B?=
 =?iso-8859-1?Q?obE6UpZxrMe6zLtAzCCYn4duNYJ/Fjxr9uqs+l4EI2f2vT8O0xScDTRPbY?=
 =?iso-8859-1?Q?mdjWDfVL59vmpwqLVKRkO7Pl/uNzSXCXIb6LtdhM7Uz/MbEaVplYt4Cqqe?=
 =?iso-8859-1?Q?uZSU196sQWnlT3FGabrdqcnzOm827dipmAGjopzIMZX3pLCDIDC5Nsny0E?=
 =?iso-8859-1?Q?KS1ujTeEL/XmLBWN7MQLoJQ40moRdKfQFT9KvAvt8c94qSRFZrIlssXn4V?=
 =?iso-8859-1?Q?qSsT1twpK47pWU56B01TbLYlHHlh8J/2FUC7ez54PomLWfKC4e1E3BD8LZ?=
 =?iso-8859-1?Q?/CvXWgAGqZdexcVXUa0me6JuQKw69dqCupO0UP+LUNT2+yu3K8QuhYhHAf?=
 =?iso-8859-1?Q?v0iM76xbwKTRVWF/2JUfLQQ6UmbmdhlYkspR7d6mATeWYviQsin61R3RBo?=
 =?iso-8859-1?Q?YB0zNrOI5XZrRr1Vk06nS+mvx/ah7OgoCmcgfiWDMlJCTdnqfCfnthp9fx?=
 =?iso-8859-1?Q?fkxDIlAyTtYHUiVvQWOYyNAiwqkjs4anvd9IP2HOXIaVhX1SOAWZf5pJyC?=
 =?iso-8859-1?Q?gfhP4YIKLOmY21WTnRxNcR8hw0PYQQgrt7dP5yABjpQXJpV9liiJtm0IYk?=
 =?iso-8859-1?Q?/0IqH3qEmdmC4+2BsNFdwuQu9xb4cdKVclrHnxKmi4bOHKEEKCs6bLyMB4?=
 =?iso-8859-1?Q?ctetyF4RU757BBoZp8gN1kXWRCn7hEJf7YXqxQPx5/putMukDqN67fjpgu?=
 =?iso-8859-1?Q?7kvpT8JUV5jU57AS3sAv657Uy6v6xbZeiXDoyJub4TD44fLIDsKeSK66bi?=
 =?iso-8859-1?Q?1h28/jlBgWoAK2u++EzLkWYckoYS3ub8ex68+E2s4+2pzX?=
Content-Type: multipart/alternative;
 boundary="_000_LV2PR11MB6045CC87C0986FC242827F5D81712LV2PR11MB6045namp_"
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: daWWvRSJy0izH6fnsNWlR289MJqKNmpu9iaJlurhlfLIg0n7RrYFZxPYff2JzfVw6XwdILlP19KpByx6lMOXTKaSDuLd8NphuaS9uo5PBttwWsBQ7ZrrpW/HPaUDgIPDkKwnFwJtdmDLNCf4BliZngXH5MPx1hZIOyNyhiG7hRSfv+24zNBCDeVSHy0SopGXu9sR2zhzt9+KAg4gX1PPbGW3NW+ZQnu86Kqvz4xFGZa5GOq67/EAtWEX/qvThq6mgy6C9K7BVn+IYgg5InKgX+QiNVdcjUqjsyFeigzXm/67jLW3HA2yACunF4X8GrpBw8aiWmgmVyk3XK5jdDBhYw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR11MB6045.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d699d3c-2e24-403e-69bc-08df400f747e
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2026 16:18:43.2171 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XKwdR+2Wt0XBDKSU/rQVqqnWUdaSCh6ppmP08HexTk6QSWYiV5QcqoDheM4qCQRAUzpWl1FuoMEjw7zbrpJv/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB665988
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

--_000_LV2PR11MB6045CC87C0986FC242827F5D81712LV2PR11MB6045namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


Acked-by: Kai Ji <kai.ji@intel.com>


________________________________
From: Radu Nicolau <radu.nicolau@intel.com>
Sent: Wednesday, November 11, 2026 11:14
To: dev@dpdk.org <dev@dpdk.org>
Cc: Nicolau, Radu <radu.nicolau@intel.com>; stable@dpdk.org <stable@dpdk.or=
g>; Akhil Goyal <gakhil@marvell.com>; Fan Zhang <fanzhang.oss@gmail.com>; K=
undapura, Ganapati <ganapati.kundapura@intel.com>
Subject: [PATCH] test/crypto: fix callback test case

Fix test_enqdeq_callback_null_cipher function to
match its name by removing the chained ops.

Fixes: 4ad17a1c8fb3 ("test/crypto: fix enqueue/dequeue callback case")
Cc: stable@dpdk.org

Signed-off-by: Radu Nicolau <radu.nicolau@intel.com>
---
 app/test/test_cryptodev.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/app/test/test_cryptodev.c b/app/test/test_cryptodev.c
index fd02107baf..d8c64a13ae 100644
--- a/app/test/test_cryptodev.c
+++ b/app/test/test_cryptodev.c
@@ -15191,21 +15191,14 @@ test_enqdeq_callback_null_cipher(void)

         /* Setup Cipher Parameters */
         ut_params->cipher_xform.type =3D RTE_CRYPTO_SYM_XFORM_CIPHER;
-       ut_params->cipher_xform.next =3D &ut_params->auth_xform;
+       ut_params->cipher_xform.next =3D NULL;

         ut_params->cipher_xform.cipher.algo =3D RTE_CRYPTO_CIPHER_NULL;
         ut_params->cipher_xform.cipher.op =3D RTE_CRYPTO_CIPHER_OP_ENCRYPT=
;

-       /* Setup Auth Parameters */
-       ut_params->auth_xform.type =3D RTE_CRYPTO_SYM_XFORM_AUTH;
-       ut_params->auth_xform.next =3D NULL;
-
-       ut_params->auth_xform.auth.algo =3D RTE_CRYPTO_AUTH_NULL;
-       ut_params->auth_xform.auth.op =3D RTE_CRYPTO_AUTH_OP_GENERATE;
-
         /* Create Crypto session */
         ut_params->sess =3D rte_cryptodev_sym_session_create(ts_params->va=
lid_devs[0],
-                               &ut_params->auth_xform, ts_params->session_=
mpool);
+                               &ut_params->cipher_xform, ts_params->sessio=
n_mpool);
         if (ut_params->sess =3D=3D NULL && rte_errno =3D=3D ENOTSUP)
                 return TEST_SKIPPED;
         TEST_ASSERT_NOT_NULL(ut_params->sess, "Session creation failed");
--
2.52.0


--_000_LV2PR11MB6045CC87C0986FC242827F5D81712LV2PR11MB6045namp_
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
<div class=3D"elementToProof" style=3D"font-family: &quot;IntelOne Text&quo=
t;; font-size: 10pt; color: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"appendonsend"></div>
<div style=3D"font-family: &quot;IntelOne Text&quot;; font-size: 10pt; colo=
r: rgb(0, 0, 0);">
Acked-by: Kai Ji &lt;kai.ji@intel.com&gt;</div>
<div><br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<hr style=3D"display: inline-block; width: 98%;">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<b>From:</b> Radu Nicolau &lt;radu.nicolau@intel.com&gt;<br>
<b>Sent:</b> Wednesday, November 11, 2026 11:14<br>
<b>To:</b> dev@dpdk.org &lt;dev@dpdk.org&gt;<br>
<b>Cc:</b> Nicolau, Radu &lt;radu.nicolau@intel.com&gt;; stable@dpdk.org &l=
t;stable@dpdk.org&gt;; Akhil Goyal &lt;gakhil@marvell.com&gt;; Fan Zhang &l=
t;fanzhang.oss@gmail.com&gt;; Kundapura, Ganapati &lt;ganapati.kundapura@in=
tel.com&gt;<br>
<b>Subject:</b> [PATCH] test/crypto: fix callback test case </div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-size: 11pt;">Fix test_enqdeq_callback_null_cipher functi=
on to<br>
match its name by removing the chained ops.<br>
<br>
Fixes: 4ad17a1c8fb3 (&quot;test/crypto: fix enqueue/dequeue callback case&q=
uot;)<br>
Cc: stable@dpdk.org<br>
<br>
Signed-off-by: Radu Nicolau &lt;radu.nicolau@intel.com&gt;<br>
---<br>
&nbsp;app/test/test_cryptodev.c | 11 ++---------<br>
&nbsp;1 file changed, 2 insertions(+), 9 deletions(-)<br>
<br>
diff --git a/app/test/test_cryptodev.c b/app/test/test_cryptodev.c<br>
index fd02107baf..d8c64a13ae 100644<br>
--- a/app/test/test_cryptodev.c<br>
+++ b/app/test/test_cryptodev.c<br>
@@ -15191,21 +15191,14 @@ test_enqdeq_callback_null_cipher(void)<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Setup Cipher Parameters=
 */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ut_params-&gt;cipher_xform=
.type =3D RTE_CRYPTO_SYM_XFORM_CIPHER;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ut_params-&gt;cipher_xform.next =3D &=
amp;ut_params-&gt;auth_xform;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ut_params-&gt;cipher_xform.next =3D N=
ULL;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ut_params-&gt;cipher_xform=
.cipher.algo =3D RTE_CRYPTO_CIPHER_NULL;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ut_params-&gt;cipher_xform=
.cipher.op =3D RTE_CRYPTO_CIPHER_OP_ENCRYPT;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Setup Auth Parameters */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ut_params-&gt;auth_xform.type =3D RTE=
_CRYPTO_SYM_XFORM_AUTH;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ut_params-&gt;auth_xform.next =3D NUL=
L;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ut_params-&gt;auth_xform.auth.algo =
=3D RTE_CRYPTO_AUTH_NULL;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ut_params-&gt;auth_xform.auth.op =3D =
RTE_CRYPTO_AUTH_OP_GENERATE;<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Create Crypto session *=
/<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ut_params-&gt;sess =3D rte=
_cryptodev_sym_session_create(ts_params-&gt;valid_devs[0],<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;ut_params-&gt;auth_xform, ts_params-&g=
t;session_mpool);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;ut_params-&gt;cipher_xform, ts_params-=
&gt;session_mpool);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ut_params-&gt;sess =3D=
=3D NULL &amp;&amp; rte_errno =3D=3D ENOTSUP)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return TEST_SKIPPED;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TEST_ASSERT_NOT_NULL(ut_pa=
rams-&gt;sess, &quot;Session creation failed&quot;);<br>
--<br>
2.52.0<br>
<br>
</div>
</body>
</html>

--_000_LV2PR11MB6045CC87C0986FC242827F5D81712LV2PR11MB6045namp_--
