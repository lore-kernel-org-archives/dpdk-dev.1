Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33D4BC28B2E
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Mar 2025 07:30:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 16CD640261;
	Tue, 11 Mar 2025 08:30:06 +0100 (CET)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2084.outbound.protection.outlook.com [40.107.223.84])
 by mails.dpdk.org (Postfix) with ESMTP id E705B400D7;
 Tue, 11 Mar 2025 08:30:03 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gwUsHd0jDCXkhgUuoJZVNA+9xJ4ELlhlUjV46qO3934FKz994Dhph0ZYqH9lFILJ8OJeuEB2zNA4OrNLMkpDRhxBLYoxTNMH0vkWx6RVdOEIytgr27d7D/8H080REf4wtFN9HDK5SuZeb7LcAFNgfW4P9S2WSN+3vcTKeoNNavOVnN45gDrYfQXDNQtOyPEisrmrRDsRezOGsSyP4Fk6EJ+RzIgKKNI6Xa+dTlyT+GPrLUkWGAwiG2IwtJE4VvKDz5mfyrhcCa6yU+b5Ksi7iaYwV5jxxog0QipQXnM0UAWQp8Egs9Pk7sN7PToLE+jtKI+jYK8Bw59MRLuPiDTKAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GSblYI/a5m7m0T3U/WoK55Y9eCVuA9cLgJ6r/yrS1ZE=;
 b=ry0XNz9T5kJQHHbyeMApXeK726+cYeBkScE8SowUjDSFRPH7vSGQxqG6etbTOMYakE/xUPiizypLpJLT22mJOftg8bpDP3lHlxUWuMA121jQ8ak9voikUvtrJxNDbF3F6ctonc2tKrIFWDM0ZZGuAGo3E+G44A2xscvHaNrST3gt2AGvt9tALa81OCHecW3yDSQtnnoni+kc7Il8ujJ+7Qgv0592EJgSeOL1mKtWv0QX5XC9GlLxnAT06yJoJdWzHCVm2FbFJXiQUsWGzlnx3021ZM2B6qqF6Yjx1dAgYIjmLj++UH/27O0mv3Iv5eiyc+bC49wPyIkfSdJcIj4loA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GSblYI/a5m7m0T3U/WoK55Y9eCVuA9cLgJ6r/yrS1ZE=;
 b=QYQRqG0VNiA/Y8cPSu7vZ5IHP040q5HQPIWLRMxWtYO1knrrduvEumSxxweEs8mgAn4NXKTKZB+mfRK/Bt1Wg1T5fESh1c5GJ6mJq6b1/gbzvFIe1hxnnDdiNtrPJX9WuXPy5eMS61u5RUyjKOYfQYJvNM84Okf/1Lb4op5+bm0drSqyqLku5Fa+YbuVfLbsMs8jjm+acggicT/AmbhT3YEx20i1l3CyyLbNO/jQQQGNNhqEY/8kABfr+OkqpAI69vi0vSFoYGkw1MB+5HBzB2hKVHRXMDNTo9dfWsp3pQYGC98/cgyal1Jt0+y1Qtdf43okb1ap0WMYwmIS3/dtIw==
Received: from CH3PR12MB8460.namprd12.prod.outlook.com (2603:10b6:610:156::15)
 by PH7PR12MB7940.namprd12.prod.outlook.com (2603:10b6:510:275::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 11 Mar
 2025 07:30:01 +0000
Received: from CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5]) by CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5%7]) with mapi id 15.20.8511.026; Tue, 11 Mar 2025
 07:30:01 +0000
From: Raslan Darawsheh <rasland@nvidia.com>
To: Maayan Kashani <mkashani@nvidia.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: Dariusz Sosnowski <dsosnowski@nvidia.com>, "stable@dpdk.org"
 <stable@dpdk.org>, Slava Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao
 <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>, Xueming Li
 <xuemingl@nvidia.com>
Subject: Re: [PATCH] net/mlx5: fix assert failure on hairpin queue release
Thread-Topic: [PATCH] net/mlx5: fix assert failure on hairpin queue release
Thread-Index: AQHbiQBo758FN9hgvkKrzKznqJdGDLNtnDnW
Date: Tue, 11 Mar 2025 07:30:01 +0000
Message-ID: <CH3PR12MB8460E523E13221FBA82135C6CFD12@CH3PR12MB8460.namprd12.prod.outlook.com>
References: <20250227101415.89079-1-mkashani@nvidia.com>
In-Reply-To: <20250227101415.89079-1-mkashani@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB8460:EE_|PH7PR12MB7940:EE_
x-ms-office365-filtering-correlation-id: 7fb12382-dc1a-4645-a7ca-08dd606e88be
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?aAyxX4MLleh620aorrLzG2dHZEchvh4F+6+hJY3wK3Qh48UDFu+dJ7k6f5?=
 =?iso-8859-1?Q?YKyJ43NuzGBagJWUvi7Ilimsmqzu9SIuLV1aOLXyiao5D/HUCqwej1eAVy?=
 =?iso-8859-1?Q?CJ+FgRngNceUrz0fzKxQsUuUuiNW7CwlSkprBPIbiRd9yXvgSSacnuZRQ8?=
 =?iso-8859-1?Q?U4HY9+Do9ZWWygj+WGuJ4l1X2aTChEcTo4bz3EMDQTGbf/3h31PxyWoohu?=
 =?iso-8859-1?Q?FJJO2cq+GN+fhdje4CJB8Sf5ZWrJTTRjRHBXDETH6ogNi/XCOltn5QS7Q4?=
 =?iso-8859-1?Q?e9ja73nMHE3V4iOEBimq6XTkFLsQFEA99fPEhExugvE6chnVQumwGKwY2k?=
 =?iso-8859-1?Q?SSuD23zhW51CzH7SuaSRz1/ZUWJSOJJ6W70Cv90C3BIwV4Gk4LMIONOd5m?=
 =?iso-8859-1?Q?4GR4bm7Ogn49oiAGatZFNQ/pdUVUUSxl4m4rt7gpXFd4K8YrX7tXXFVKJw?=
 =?iso-8859-1?Q?Za0LMqSltX58PM4dBLCSenHSEVIMZCvpCJ8P9nA0NfYIvQysF0DM7rG7iT?=
 =?iso-8859-1?Q?ErKpGhDdlVKPoZUIj8iX4EVAUXOoqfjIOMtFj+MOxgzH0AIB8qPGjPFob8?=
 =?iso-8859-1?Q?e3Cprg8UZ02OM3FEalQuAXTi9GNmkNGPTSRpeSQCt9rC6epTrdEM6X+58E?=
 =?iso-8859-1?Q?o5ZKqOdORhoN5kWKh9cg2HLum3mmmoBD1ggluo5fZ41qzDOuZie8W1CjEf?=
 =?iso-8859-1?Q?s1daZkp3wBvHVAkec2ed2z+GaKGwjPVuQT3Cweh108ScYYzwZq8mg4zhiu?=
 =?iso-8859-1?Q?Fmc39n7zRxC/f8N0UPO46YkoN3IrBvbl/3BILfM9AGHXWWUZ9kjn6fwzdn?=
 =?iso-8859-1?Q?wxlZTH2TgCcoIai6+w4qXcHrWGhg7wgnGylSMoAqyioKHl1ETuTHDSsMVf?=
 =?iso-8859-1?Q?e6C4N33eDfCHN7Bvbe2DjOxzrJb8ycvUDJXunDbDcZkccYeZh4QupR5LBl?=
 =?iso-8859-1?Q?sbUQx8eFlSruBGi5egAxb3hRI5zioGTVuKkV8s+nG7Lg9z8YLR7rW6ZTdg?=
 =?iso-8859-1?Q?n2/fBGP3bGaFLcLDVd40un1broUnahYUgiDW+KKexrYNFxVyz48BpMRlOv?=
 =?iso-8859-1?Q?9vcdk5tcMPBpkJEJGmBNMaXIy/fBLTXlm0XfH4GtgD3ZUTN57t79ritrPj?=
 =?iso-8859-1?Q?rsJI/17SP8LDKRd6vlgkJyDVVX1eJNvv0J7gs71FZoJxzIJD0U2vrAvCMW?=
 =?iso-8859-1?Q?CYNNtzpRkDy2seIN0a3n0qff0GoVWb3O0v05xNEcXgwkVpOnhf90t6jcRP?=
 =?iso-8859-1?Q?giYc+BWkXv9dY9U3QJDFi9CH+yL3NvdTdZy//CH/iGIyDC7NkABY/V3Nk4?=
 =?iso-8859-1?Q?XxTmpP2AcDCmi1UB9flX9ZlVn8gadEdkMnPGPHYfPTYScfNL8+pKgJNKTN?=
 =?iso-8859-1?Q?KcGyO0g1Fbzco8qdJFUtTfJlp3pgA8Rx0ml+ZduhuYADkkUPx6zB75AdfY?=
 =?iso-8859-1?Q?uBlAQ+J4sNr2z6KtyBAm/Fyd1vae95w4keYm2iQaWGTjV8t69rr+kVwRFN?=
 =?iso-8859-1?Q?dYTCoVA+a1zMPIEU8gn+h9?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8460.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?dJouSiYdKAVC54r7jlrtbC7dM9yZ7h/7TfICZNKNYmWyApbVKVLffVNjbZ?=
 =?iso-8859-1?Q?K8JGIlqmLofeqJguoY097Sli1W2pqIAukWKIx6c1SBBmSkIpKPmUtK74W9?=
 =?iso-8859-1?Q?1dSY/9gXI1lDlrmAOUyU1zlVNW/IAU/BlkCZqD9VePYzD6nflavfDnk7dY?=
 =?iso-8859-1?Q?65OXLyvzFbCKwy3ps5S5vCGMGUqag0mnBmF1onRbeiLpV/3nZeO5Mj6ZS5?=
 =?iso-8859-1?Q?gne/f5C7mEOzMCmSsbP1RBZ1BobXCoTg6vdY4skfpPjkQvmjGKK/HgKrVl?=
 =?iso-8859-1?Q?w/9NHYfCdCKV7uH8psLz7cQJ7kF9CIrrCLuvMepf5Z8CRhLFThH/8yC+pP?=
 =?iso-8859-1?Q?VncrNScET1XEVXv9yTpLO6Y+CS8E8V4iot/5ipQxdpS3Ex6Ltt6uhDD+WH?=
 =?iso-8859-1?Q?XF04+CjuJ1aUFoR7ghPcT088RSiG5xN/2QsNJvtLDY0/Ny1Y24VLUErneV?=
 =?iso-8859-1?Q?bfHQH2bpz32T2o/e+ZMawHcpdLxopnT3QkVZXfCKPsElep9/CtNADT/k2I?=
 =?iso-8859-1?Q?NEn8uRm69bCglroewW+Vg7Ic5mO7NxsguLXAjyvZlt2GTMHnDE5K8j8Djp?=
 =?iso-8859-1?Q?BdNvClMlebIPOEbXo9ewg3QpkYm6lPdcDHyRtnGtWSIBY+OEluXxDcqIux?=
 =?iso-8859-1?Q?RmUXIQpTKfgMrPtG3vwW94L8YOTdxjP4+UE/GSPc5HLy2dSkLwKvF+5EEu?=
 =?iso-8859-1?Q?2hiPPmIaAqoy/oeyZcvN+ffHi96Z8JQzcW7ZpBcF0ccfB0xC41yGCV55H6?=
 =?iso-8859-1?Q?X79awR4ox7tVhKI664FhgTXgKC8CQVtpk0wPXOhJv1klqOO/232+e5/UKZ?=
 =?iso-8859-1?Q?4iVmEtVVjVPTyJ4leFp4lpjykhhepzqd+vnD3JgNFXk3ZoT2FSrrtlQ6ci?=
 =?iso-8859-1?Q?AiGWDaGgza565OwR9vECCZ75bHaqP/WWRZ/ERCuwqsaZtrDRIh33vF16Va?=
 =?iso-8859-1?Q?qJXFVIILKu+i2u+gS9HRRGwfYXGESnwQhOAOk9mR+TCeZjJ7ebf9Si+iug?=
 =?iso-8859-1?Q?XRxXKf16r5IyoUqwyc3eGDLtruUouLBZdRioWgZUTmU5DG0KGXJ0b4BKEg?=
 =?iso-8859-1?Q?kFpMX6HjHGlqeacC3+qj/wpafiJKUdy03YbdTu8g85uU7BpHuMuRD3gfDo?=
 =?iso-8859-1?Q?U04bCIxo7CRgyOvwYnR0R0cTifAUQIhn6DtOva9ZNCRSoHR3ywcl/mO7M6?=
 =?iso-8859-1?Q?VI735tJ46xgnMsh1z/g5UDxxPXZXPhfBJ1SbeSNKyAJjGUmP07wdBqAe6B?=
 =?iso-8859-1?Q?7Wnq9kswaXVLi/7Pzauk6p585GodqGK4oOPoPgHBASIm+enAvoEZG62jYM?=
 =?iso-8859-1?Q?YyF2VGzx5NcfnNqz5FvLqSPkIja6RS9tDxu/TN4JqosW5A4Q+Z8Yw9CJPi?=
 =?iso-8859-1?Q?W1R/Qmoyz5O+tgz8pj/eCFsgvX0BWl4h0oNkOqoLf0qdu9I7+ZyRJ5BHEj?=
 =?iso-8859-1?Q?OnDBndEleXT6fle4r46evLi6cDGHde5CiWzXArX8+7t24xxJL01E8RHeAf?=
 =?iso-8859-1?Q?hXWOtbtvVH3ob5dPQfl3QGYQ3aKuIGD/A7LLgqpcS0l18XN8QJblBeZrlb?=
 =?iso-8859-1?Q?QTCYfwsdg45y0yLE8aQI2+Ob2eQ26EyEybP+lwxLPRzzAN1VA+xydyx/+f?=
 =?iso-8859-1?Q?Zl0Hv/4whvY1Q=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8460.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fb12382-dc1a-4645-a7ca-08dd606e88be
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2025 07:30:01.3309 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kNOoUGqh0w7sk9FO6MXe3g5ViP3Z+3713GTnky5z7FHRE3ltBo9HuJdSyaSAcviCcMdtVz6R5zoP6kTTRAq/NA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7940
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

Hi,=0A=
=0A=
>From: Maayan Kashani <mkashani@nvidia.com>=0A=
>Sent: Thursday, February 27, 2025 12:14 PM=0A=
>To: dev@dpdk.org=0A=
>Cc: Maayan Kashani; Dariusz Sosnowski; Raslan Darawsheh; stable@dpdk.org; =
Slava Ovsiienko; Bing Zhao; Ori Kam; Suanming Mou; Matan Azrad; >Xueming Li=
=0A=
>Subject: [PATCH] net/mlx5: fix assert failure on hairpin queue release=0A=
=0A=
>Assert was triggered because of ctrl_ref mismatch on hairpin queue.=0A=
>Fixed the mismatch.=0A=
=0A=
>Fixes: 09c2555 ("net/mlx5: support shared Rx queue")=0A=
you are using wrong fixes tag, I'll fix during integration.=0A=
>Cc: stable@dpdk.org=0A=
=0A=
>Signed-off-by: Maayan Kashani <mkashani@nvidia.com>=0A=
>Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>=0A=
=0A=
Patch applied to next-net-mlx,=0A=
=0A=
Kindest regards,=0A=
Raslan Darawsheh=0A=
=0A=
