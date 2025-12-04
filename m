Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0E6FD1F9D2
	for <dpdk-dev@archiver.kernel.org>; Thu,  4 Dec 2025 12:17:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D5BF04021F;
	Thu,  4 Dec 2025 13:17:37 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by mails.dpdk.org (Postfix) with ESMTP id 2009840144;
 Thu,  4 Dec 2025 13:17:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1764850656; x=1796386656;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:mime-version;
 bh=8GnBgnv0tbrkRe4P8oj4KRNULxBkKAz3gDFnsbmafiM=;
 b=aiqnqOxo+J31O00cnvHIfhTMptMvYcNjIRIVS5oQ04/NfWyoUE6r8LBu
 w5dRXtAX9yYEa/s5vMfL+2N+MC/rOafANI55kKdzT2XEJHtFhJp7F2f+l
 P+iZ/aa4s8viP4vnHeuPiII4PKVngOBH1Gg7bQQQLHBDHc4PvlnyYdskz
 UEd5rbcjpa3oqQpNjWkwyApDH5lziC+oo+hpidvhAdGiM3egjSR5hYLDC
 cpwsboEZ10lj84LjCFtYOu33MunH/ZtKOY1LT+Cw3YGVBpk6OB2iSfE1G
 MfpFVw/x44z6jqa1+4l5ZTJ/KayTlhoVRUNOWd0wqEYpt2iJSMJ2tX4J6 w==;
X-CSE-ConnectionGUID: rFmIE6iWR3az4JqcJFze1A==
X-CSE-MsgGUID: K25BCwEORIeuuQaj3B2Ekw==
X-IronPort-AV: E=McAfee;i="6800,10657,11631"; a="66942634"
X-IronPort-AV: E=Sophos;i="6.20,248,1758610800"; d="scan'208,217";a="66942634"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Dec 2025 04:17:35 -0800
X-CSE-ConnectionGUID: AzelXYVURKixoxcNlxPetA==
X-CSE-MsgGUID: blRipIdBSk+6lQNTea+rWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,248,1758610800"; 
 d="scan'208,217";a="195780894"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Dec 2025 04:17:35 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 4 Dec 2025 04:17:34 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Thu, 4 Dec 2025 04:17:34 -0800
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.68) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 4 Dec 2025 04:17:34 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iXDRVg0N12GN2fl6r0JOOCKrjtmlF882NS72f6wP6iRx/MDeGMzBZPR7nvBpPEceRfu+2CKeWlGXDgMkAb+D74qMBNtEinYTZhIGJHVUGd0ilPcDTv6m0c4WceHebRexjyXMDK/AP04s46JjEOk9ePhpzrkpZR0Tjlz1Js4n3trsCr0987S4H+u99mdZtC0NvZYqxnm5mm8B1aDla32BdyLTxyyi/k4EU9jnR1eedySMF8mBCXTm3KOFjo3F4CjyesiXpt4FbUjwwyQg/gP2RPewYEiOM4Yl7Zn1hHokOZbr9KrpGF3j99UrzEJfUGFRM+FGxpeC289udSKZVR1wrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gKBCAy2SFDymMn6sM3sx8S450nxe2MtDn8WSit42szg=;
 b=q6Pno9YG1S+Yen1IXkub+ZkNXfmMZkE/eCjl0Ds3AvULG4SWQnOfq/LEzSGLdM6frilCzACmV/W4eAFo0Yjqwz92dJGQfbFYdCppl/8Rrt33hoYt0/dqoZXV8r1ZYpdJhiAw1LojYEB6QDZJcYAqw5JX68Vdh+oJah+NjB3zZnQJRX6d16CjSwH5nrpc3zZ9nhea+1fT3CrQPy355YzP/EJjKgBpGfdAa61ZovLrYMMc4gkspyL4osgBTyWMxavWgpf8Rc9/Owz9tNZYqhKEQlK3qA5ykce0Dsw3H2wrP8jipjufZzrtLbyKDDfC2q4XeNEm/AIuhvu95PChPj83Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB7458.namprd11.prod.outlook.com (2603:10b6:8:145::13)
 by IA1PR11MB8098.namprd11.prod.outlook.com (2603:10b6:208:44b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Thu, 4 Dec
 2025 12:17:32 +0000
Received: from DS0PR11MB7458.namprd11.prod.outlook.com
 ([fe80::6d78:37d8:c835:540]) by DS0PR11MB7458.namprd11.prod.outlook.com
 ([fe80::6d78:37d8:c835:540%4]) with mapi id 15.20.9366.012; Thu, 4 Dec 2025
 12:17:31 +0000
From: "Ji, Kai" <kai.ji@intel.com>
To: "Nicolau, Radu" <radu.nicolau@intel.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: "stable@dpdk.org" <stable@dpdk.org>, Anoob Joseph <anoobj@marvell.com>,
 Volodymyr Fialko <vfialko@marvell.com>, Akhil Goyal <gakhil@marvell.com>,
 Kiran Kumar K <kirankumark@marvell.com>
Subject: Re: [PATCH 1/2] pdcp: add digest physical address
Thread-Topic: [PATCH 1/2] pdcp: add digest physical address
Thread-Index: AQHcY3juW2rXxwyhYEqfGGx+Ugg9f7URaN2I
Date: Thu, 4 Dec 2025 12:17:31 +0000
Message-ID: <DS0PR11MB745862DDAB8EB9BB063E7F4281A6A@DS0PR11MB7458.namprd11.prod.outlook.com>
References: <20251202104550.849311-1-radu.nicolau@intel.com>
In-Reply-To: <20251202104550.849311-1-radu.nicolau@intel.com>
Accept-Language: en-GB, en-US, en-IE
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB7458:EE_|IA1PR11MB8098:EE_
x-ms-office365-filtering-correlation-id: 530658c6-bb20-4535-2263-08de332f1998
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|42112799006|376014|8096899003|7053199007|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?sS4KEeCUV8g5AotjZ7ceWIERn6shc4M0zCFBCyHUXTpflamiUvmPGVIvD4Lq?=
 =?us-ascii?Q?wMDdIUGiA9pk/sxLbCjLj3F0ehsuJrizgLVT95UgD9oZvGhPA/o4ELA2XMTJ?=
 =?us-ascii?Q?WOsefKCNP2x7QSATX7QnVWmL7/cUYHGU+X5z/5NELaCpLSJM5D9uYBkuUpTK?=
 =?us-ascii?Q?y1Cv2yHy4DqlBYnkBAJ5zC4zzS/c3Bvi6zE0Eiw8Em1QN6uWnOu1vTwuHTo3?=
 =?us-ascii?Q?GYKfFLVOMnEjByP6YrTPt2mG1OhB96/xPLEFuPrmMEEuYx2IwbJnUFYN5bAE?=
 =?us-ascii?Q?pKfTKuuJuiU9C2W771YuSUqrQKlcgPFpeGBjtvDW7ykbugl7WheW2nGkkWgL?=
 =?us-ascii?Q?SEVkOUgd3OpjvdKoZKuCibfgu3nG7LePbT769QRRK9cifR8mRkF4noSTSjPf?=
 =?us-ascii?Q?FuvcPs0IEXMZeCQXFwfYujbvBndjNoyIqMUhR3MzfBJlr9KBmrVDMZLkwqFn?=
 =?us-ascii?Q?B9PAJ9hCMW2S+UfP3RvpM5VkWI1uuXRzTiyVWZLbCTYHpO3FFfC14+xEwBW+?=
 =?us-ascii?Q?jKYdQaz7itrxqIzO4piGCxQqOBm4ehdJTY7gEZbKiGRy53BCfUn4OOmNi25y?=
 =?us-ascii?Q?R4ATTvB56nzHBS0DU7PXGZCP6PpMY0OE2TrJOHjQP2qpPMZGsF3V8xaGTPNN?=
 =?us-ascii?Q?KcW/4vcQNqB4zKAwIMjMppkIMH3VUiE/awSRjVYCTlrBhcwlyN/2HJZIbDof?=
 =?us-ascii?Q?iMQOP+6qmw6+uSnB2k+tV8uyTc4Oxo6d5tW8IFzUHkBWDuy1iV3Q2HYcZxg4?=
 =?us-ascii?Q?9YgTZHq9g05qJYRV/OglOgvMTrUZ33T15OQjJi1kNYWqSoauAbBzs/6ML/py?=
 =?us-ascii?Q?NBpvaHgTkvLUQbF/mRHzHF0sBA5DGAjd1wHfccAQD7vhXGTOKgXxcc9/elbB?=
 =?us-ascii?Q?sIkUcj01l8R4I8A1wJMiJblj+ZM4x94mfJkTFENrcnDLKo2Ffjh0qppwM+hq?=
 =?us-ascii?Q?c1C1uDzDq4PRVDdx4stFuAFFmVDlfy7B40rclWmA15AaR3isnpCLTSGv6DWh?=
 =?us-ascii?Q?UdteoykB10DYS7TPpkOvVDqfE9SCzE8A4opg2vJWP+wHLngVD35E81z+2r2+?=
 =?us-ascii?Q?QAB6g4viVyRbjlUpU4HbFychhVmcYdh28ZwCFUmVu7SmN0hbyspwPYduqCNk?=
 =?us-ascii?Q?m65VbzZAzm4AJ28/AzGkIK26Pqwx8/Wm+CbLgnY+KARGm+98NfdIHqBJvSvQ?=
 =?us-ascii?Q?D6FZdfwXhBwJcwZTGfkOC+rSCJ6+IH7+YtJPYQjtmfuouQAsZ7HUfsukaCSq?=
 =?us-ascii?Q?nHagewFw+L11W/YAUj20FDkNU5XOKicDRDdrIFTru9fBkDbIZ3wTKuBvwQjJ?=
 =?us-ascii?Q?+BBy9PYkNMfrDF7mgphU7P0a6LffXXwdC+7kaJdJIz21qaOo7X1RuhHfyJ5a?=
 =?us-ascii?Q?oSbwV+3np/bmAvfihZGFHkpAjHkYXasrfs577Lk4Pbqw4qzFFcBw8Y8x3UvX?=
 =?us-ascii?Q?kKeg+CzkDE2AgOhMK5th5yg849jQjvd/Iuowq2AHGv6smC86fNNOZzE+gDZE?=
 =?us-ascii?Q?lTUX/JNQduEZ2SNouZTZsafSNvt948IYAw+Q?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7458.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(42112799006)(376014)(8096899003)(7053199007)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?VVTP6PWryKjeGObwvkNZo2xCg+9XWGcgPexk0TqN0iAG6wdBQDlsboeJFyiR?=
 =?us-ascii?Q?Ds3y56HBtE+9n+/KuAnwfd5rp5iiN8BU/8ulZ6V8D0nfCUzsXCqaRQWI5qIx?=
 =?us-ascii?Q?PDmcHImf0/0RPJaL+hmLWVRgy7YqTx87HBZIwMPWcPTxZ1XcwGKywPVIsmtp?=
 =?us-ascii?Q?I5l89GY3RBdHHPssfAGS08J2te5Tw+WFThhlutEwBRCKK45jIby0cfYhmFID?=
 =?us-ascii?Q?1ixZ3rL6XGXyM/sc3vNMQ+kAv9JW+ZK+tX1bgjulUKPjsKNveUGQUjJPVA0a?=
 =?us-ascii?Q?XsIluEJvCbANsuJo8PpwUJ419O8rCidsFAX1qR74vYcR7dP83VJb1K02gWyT?=
 =?us-ascii?Q?8M/I/0jPAQQJjR6vl8vtfzC2f07YGHu2vGmii07UKKRpeuib8Ll07eVzqeO6?=
 =?us-ascii?Q?q9nZrcBhgxmQxRfRwFtdgBBdZbm5h/uO5kN1Y6EEsISVBX3Cpw48d0ozeQ7i?=
 =?us-ascii?Q?AluEPET3p36fcOrY0NbduoDteZCuwYNN7E6OJiBlHQnCPVk+owY2yd08Nb/K?=
 =?us-ascii?Q?EHz01vJBnOpPebj31ZHR+CYLA6g6PQRIe9J7gxYbCuc4HTj1GzoL220oJXcX?=
 =?us-ascii?Q?QdnP+DiXbKAbERWx+69B42R2iGBpKPPBvmCiyqSsY4v7gV/7LNA2PgparF6z?=
 =?us-ascii?Q?HKd3pI0T0nNzZEJrCi6Y8tHUa9kzzvkf5ZuT5JsBke+mKJhZqMzlILtEhkY2?=
 =?us-ascii?Q?7v2AG8AsT+csvV6lXV/Jd16aXiycmN8FJIvn3/X/OAAACB+4H2iVytuTNrM5?=
 =?us-ascii?Q?sMDjlDMoJQa2Iq/jfVKP0svz0OaRmVOwh2wMTKxcExdjjeuPatlLqrc+R9z+?=
 =?us-ascii?Q?xKiQalt8F6333I9q1l76Oe1mANlgCyQThrv5bYKfBfnwf7/5bnF3fP/5SX0p?=
 =?us-ascii?Q?X/N/ulyRIi4gSzbnrH2eajufuurlRnSqEV3J9kCXfZPKFt1rboWwRLJ4tdym?=
 =?us-ascii?Q?69HOPI+5LLaRGCI0ihGbgLTbsUe9pX392ZEkLVzJxJ8hW4hfh+4Pe2cFJ93q?=
 =?us-ascii?Q?g/da5W+qw6E3Xl5ZIbFtODy7NMrEp6VQ/rodagUmXtn4ibrug1dTc6eLLPn+?=
 =?us-ascii?Q?iF21O+Y7epgvOX2Mg5ZhGF/Ex2nRmlx/z1CuLUFUD8xdYxB8pKhQVer+2iUh?=
 =?us-ascii?Q?vCD9kVU54rDuBJMr73lmBk3PemFfgcAtXlDj87PTEW0OLy+KjjVYNrPZGEsu?=
 =?us-ascii?Q?UzS4TbU1lqcBEp/J9b+RESVYcGkJyeERIeu8BIgDbpXu3RC2uph0lMGkXliW?=
 =?us-ascii?Q?sJFOqlA8ktG1eySI1WhjJi6VcRsHWhOyKMgm7q1c3EtDhOA8q3+vYn3DCEnn?=
 =?us-ascii?Q?MOjVEomK9uzWQYi/XrcI5iotj6jgIdBYRqY8IHKos+4sWKIIbzPzLRj/Hk/W?=
 =?us-ascii?Q?zMqA8xGOU/R1cKHgISpp3Sj2DIjZSdkwkvla7SIcupubpX4q3tSs2/EL3vRS?=
 =?us-ascii?Q?/Y+3okNk4z4Rdo83TckoGrQBBuu9TReZcjuNPBC9g6eiLca4Zhvr7HYmdAz9?=
 =?us-ascii?Q?f0LiKgrt1HhwlUZj7OkADf4cVdiAHt3h4YpcAEBY54RBsMXNVRG8oK2Yb/uh?=
 =?us-ascii?Q?k4Q+cmA7TAGdyGl3Kds=3D?=
Content-Type: multipart/alternative;
 boundary="_000_DS0PR11MB745862DDAB8EB9BB063E7F4281A6ADS0PR11MB7458namp_"
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7458.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 530658c6-bb20-4535-2263-08de332f1998
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2025 12:17:31.8512 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w5MkQOx/lOAgPGdo3wjcKLnD8ZriMp27EG8H9Gy7mZIQcHNVSNVzLsxecF7vkIp8cICEOYPDBVgq1D8JLNe7GQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8098
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

--_000_DS0PR11MB745862DDAB8EB9BB063E7F4281A6ADS0PR11MB7458namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Acked-by: Kai Ji <kai.ji@intel.com>

________________________________
From: Radu Nicolau <radu.nicolau@intel.com>
Sent: 02 December 2025 10:45
To: dev@dpdk.org <dev@dpdk.org>
Cc: Nicolau, Radu <radu.nicolau@intel.com>; stable@dpdk.org <stable@dpdk.or=
g>; Anoob Joseph <anoobj@marvell.com>; Volodymyr Fialko <vfialko@marvell.co=
m>; Akhil Goyal <gakhil@marvell.com>; Kiran Kumar K <kirankumark@marvell.co=
m>
Subject: [PATCH 1/2] pdcp: add digest physical address

Set the physical address for digest buffer.

Fixes: a785af14ff79 ("pdcp: add pre and post process for UL")
Cc: stable@dpdk.org

Signed-off-by: Radu Nicolau <radu.nicolau@intel.com>
---
 lib/pdcp/pdcp_process.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/pdcp/pdcp_process.c b/lib/pdcp/pdcp_process.c
index 9b9b881124..f55ae3bec0 100644
--- a/lib/pdcp/pdcp_process.c
+++ b/lib/pdcp/pdcp_process.c
@@ -351,6 +351,8 @@ cop_prepare(const struct entity_priv *en_priv, struct r=
te_mbuf *mb, struct rte_c
                 op->auth.data.length =3D (pkt_len - RTE_PDCP_MAC_I_LEN) <<=
 auth_shift;
                 op->auth.digest.data =3D rte_pktmbuf_mtod_offset(mb, uint8=
_t *,
                                                                (pkt_len - =
RTE_PDCP_MAC_I_LEN));
+               op->auth.digest.phys_addr =3D rte_pktmbuf_iova_offset(mb,
+                                                              (pkt_len - R=
TE_PDCP_MAC_I_LEN));
         }

         __rte_crypto_sym_op_attach_sym_session(op, en_priv->crypto_sess);
--
2.50.1


--_000_DS0PR11MB745862DDAB8EB9BB063E7F4281A6ADS0PR11MB7458namp_
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
<div style=3D"font-family: &quot;IntelOne Text&quot;; font-size: 10pt; colo=
r: rgb(0, 0, 0);" class=3D"elementToProof">
Acked-by: Kai Ji &lt;kai.ji@intel.com&gt;</div>
<div style=3D"font-family: &quot;IntelOne Text&quot;; font-size: 10pt; colo=
r: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Radu Nicolau &lt;radu=
.nicolau@intel.com&gt;<br>
<b>Sent:</b> 02 December 2025 10:45<br>
<b>To:</b> dev@dpdk.org &lt;dev@dpdk.org&gt;<br>
<b>Cc:</b> Nicolau, Radu &lt;radu.nicolau@intel.com&gt;; stable@dpdk.org &l=
t;stable@dpdk.org&gt;; Anoob Joseph &lt;anoobj@marvell.com&gt;; Volodymyr F=
ialko &lt;vfialko@marvell.com&gt;; Akhil Goyal &lt;gakhil@marvell.com&gt;; =
Kiran Kumar K &lt;kirankumark@marvell.com&gt;<br>
<b>Subject:</b> [PATCH 1/2] pdcp: add digest physical address</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Set the physical address for digest buffer.<br>
<br>
Fixes: a785af14ff79 (&quot;pdcp: add pre and post process for UL&quot;)<br>
Cc: stable@dpdk.org<br>
<br>
Signed-off-by: Radu Nicolau &lt;radu.nicolau@intel.com&gt;<br>
---<br>
&nbsp;lib/pdcp/pdcp_process.c | 2 ++<br>
&nbsp;1 file changed, 2 insertions(+)<br>
<br>
diff --git a/lib/pdcp/pdcp_process.c b/lib/pdcp/pdcp_process.c<br>
index 9b9b881124..f55ae3bec0 100644<br>
--- a/lib/pdcp/pdcp_process.c<br>
+++ b/lib/pdcp/pdcp_process.c<br>
@@ -351,6 +351,8 @@ cop_prepare(const struct entity_priv *en_priv, struct r=
te_mbuf *mb, struct rte_c<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; op-&gt;auth.data.length =3D (pkt_len - RTE_PDCP_MAC_I=
_LEN) &lt;&lt; auth_shift;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; op-&gt;auth.digest.data =3D rte_pktmbuf_mtod_offset(m=
b, uint8_t *,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; (pkt_len - RTE_PDCP_MAC_I_LEN));<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; op-&gt;auth.digest.phys_addr =3D rte_pktmbuf_iova_offset(mb,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (pkt_le=
n - RTE_PDCP_MAC_I_LEN));<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __rte_crypto_sym_op_attach=
_sym_session(op, en_priv-&gt;crypto_sess);<br>
-- <br>
2.50.1<br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_DS0PR11MB745862DDAB8EB9BB063E7F4281A6ADS0PR11MB7458namp_--
