Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E399C35FF1
	for <dpdk-dev@archiver.kernel.org>; Sun, 16 Mar 2025 13:49:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 670DE40268;
	Sun, 16 Mar 2025 14:49:17 +0100 (CET)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2051.outbound.protection.outlook.com [40.107.102.51])
 by mails.dpdk.org (Postfix) with ESMTP id 2BEB240261
 for <dev@dpdk.org>; Sun, 16 Mar 2025 14:49:14 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n6m0TRp4Z5MEZJCQ1Id9rFvakDELVvGqg4U+gh39ANhLXGYmpWQqHTdtG6r26i5JliHMUqKveytFxEJIjX0fy1NbfPGjLTGd4HY+hWjWIEphcUC40E2f/mc9NJoNx8U3PnPiEA6ecwcoIPIxeAbhE/Gjci48Vq209ccSYjSi3HO0QLTcdpIduLOfnlHGOvJl8GqDgYYPrwvQ16HCJRbr4eSfZvMNMrTHJeulo0YCCEyoDkq6d1yDgZ3u6I8nzbSYrVEuKJ3apV5YTNZlUBQH7BFcDMiiX2vMsFZJhJR9SyvoBzhwr9ixeRLgpp4dCcxQg7gkCCs2A7kSV6pklNp5gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CJFsSyPKSztEjxJBGjzMDaHPtpSghUj23TQUKQ8ktq4=;
 b=lgnspNwrtihICvKKKGDpBNyvhpm9SHny4vBzcN4XjL2as4fhCaQMXBfjy2XsFNVsWjibxkXuY7dz+mGpq6mWRYpIoY3Cz2tb5mhrkH+lek/rko408tnl6YzGCU1sHX4x6pSqE8kjst5mBZAnO7hfU2GKMwR2rwalzd0MIkNSD4j43bghcn1jct+5NZxZODIQIB3gAhIXbzoGW9JAfT89ULpnhMsx9kzdIMkqEuOkZFY9+/X8gRX2zJ/bckuUOjI36is7L3Qx7WgxN6Tl9+OsdjOMNH+bIG7zFCk9X+6qc2m50sQJJAYcl8dMMOs0ff+qbuF8bw/PTKl7wgW9b1xPsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CJFsSyPKSztEjxJBGjzMDaHPtpSghUj23TQUKQ8ktq4=;
 b=MjI0paXWlxDW4x+AUpMIiWpG8SNo/LGr7Fm0+JzxzeZ9YHKna2UXavQTHkx/ULg8C85Q8/AtW0RlMNph3b1RGcnSbqjfpmyKNn3q3Rd30g/Y+2AKsnzWnV6vzT7SOIU4wlurfvNun/s2k/nP1XEewJYluoy8trFAHv48jQ5lGL6avr1TEj459TWSneiRp1KhaKIYs0o4JoAd7f+DbX0Y5p2fI/b6YEDJ1Z3Pd6kG1vilZq46jGhJW6uwYO9BMKvjoiJxQ+bxXzE+k1i7/nq/Zw8yJPNzXIAr1KnLd6jKyztlwkJDFXAGg9vsY0vI9zr3v2b9dBr2ISpwWfWniEJ+QA==
Received: from CH3PR12MB8460.namprd12.prod.outlook.com (2603:10b6:610:156::15)
 by SN7PR12MB8170.namprd12.prod.outlook.com (2603:10b6:806:32c::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Sun, 16 Mar
 2025 13:49:11 +0000
Received: from CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5]) by CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5%7]) with mapi id 15.20.8534.031; Sun, 16 Mar 2025
 13:49:11 +0000
From: Raslan Darawsheh <rasland@nvidia.com>
To: Maayan Kashani <mkashani@nvidia.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: Dariusz Sosnowski <dsosnowski@nvidia.com>, Bing Zhao <bingz@nvidia.com>,
 Slava Ovsiienko <viacheslavo@nvidia.com>, Ori Kam <orika@nvidia.com>,
 Suanming Mou <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
Subject: Re: [PATCH] doc: add limitation under unified FDB
Thread-Topic: [PATCH] doc: add limitation under unified FDB
Thread-Index: AQHbiQJA45opbIzHUUC0bQkh/JL1JbN14klK
Date: Sun, 16 Mar 2025 13:49:11 +0000
Message-ID: <CH3PR12MB8460754B3C2463DE407831C4CFDC2@CH3PR12MB8460.namprd12.prod.outlook.com>
References: <20250227102727.92428-1-mkashani@nvidia.com>
In-Reply-To: <20250227102727.92428-1-mkashani@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB8460:EE_|SN7PR12MB8170:EE_
x-ms-office365-filtering-correlation-id: 8a45e7da-736e-450c-509b-08dd649154f4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?AJNINoKcnNJQI+b3dMtVmq8+y1WL4TlItBeHCdvd5+ooNIAdEXsBF10jU5?=
 =?iso-8859-1?Q?TMCXPtvPuKVwCt8tt4Qxst3XmMl9Fp38L/D0dcBaAqUsIjjYfS5xayfLLM?=
 =?iso-8859-1?Q?3xgPks0GmbgftJE8+r6BpcQHGpZSp8LpDmvj9Y39xm7PyeEJ5POzT2zUuy?=
 =?iso-8859-1?Q?VJJi6fOOX8ZSLhN5MTwDcfxUww5Cqn2W4j47XyENn0koHfPjIW+PBELlyD?=
 =?iso-8859-1?Q?lGJnfJRXrlO2520tywVI8tpKS34KDTVYwk5ktcGhaapCrsGrNoK/GZg4xc?=
 =?iso-8859-1?Q?Sgptg9XwIEPfUv22w0gn6txByQcQTPrlVt23ZWu8DpkU1uB/EYJkOF6xhY?=
 =?iso-8859-1?Q?4JXaHom1R41gfzE1JeP2C111qZoiEhcnw0pPivDh+TORbQNLR/KsmBm5FK?=
 =?iso-8859-1?Q?SQi3V3sUBNRCwzSjaG2wWnVL/qOPlVkAf02u88AjsNzN9gelAF16NSimeI?=
 =?iso-8859-1?Q?iJizAcMTtwOyjSqHNOuon2pgy1dOmL/nOjduLuGQ/7V10dy/VNTnVCPZUR?=
 =?iso-8859-1?Q?qipT5xQ4KKRtFHhm/jQvOX0EyX5yT3IeQQ6ccdJR7DPS0M/5xEjLWUDCc2?=
 =?iso-8859-1?Q?21p6/pCYwQ+AkSTVN1ePxGWQ19xTBNx4hTV01nfGQcdzc+2RozZumJTnOY?=
 =?iso-8859-1?Q?sVJZ+XaI1R8GZ78S/Jr3OlWprxITroiNx61whrgrkGF+Uf330W05aamwLy?=
 =?iso-8859-1?Q?LFp6gd7mOX9Vff3QF5WWpV1jEzE4ptCvMr+pPigrfHZW1xGzmC/2F0Jzn2?=
 =?iso-8859-1?Q?E5hIXoflGkI35V5eZqxNk184hQWQwGSt4+rD+SL0AzByNI1T33JphBFS+L?=
 =?iso-8859-1?Q?X8ysPPg1yE8LTRLXvjOjyBbQgDB8gRkJeRWOWewxJBHGIR2CGZLpXtlAN3?=
 =?iso-8859-1?Q?jnUMr6QR/hGykRci3hs9OQUC7NxnEBPIu7WfAvaJtXGRgd0bHI2YjoJrJP?=
 =?iso-8859-1?Q?qsQ8soTxk5kUga/CBTGV2gYI+AaUDdB4iyAzqLbv/38liaedR8ZQ6lSW9o?=
 =?iso-8859-1?Q?pKAEkN8ICvWquZ5+DpcW7WPpSa8NhLxIesxKPskhMk8WlVYY2wbmxPQd6x?=
 =?iso-8859-1?Q?nU15Zag+uBY1pVVT7xcB+z4/VIRx5RojY0fYLUj7skOpzOYTsMAHeB1KVx?=
 =?iso-8859-1?Q?Nq7y0HQ+7cMkQMeTiVr2ACif0n53eULrvk1Y8MmADeSiEs/TOCCjXZKv4M?=
 =?iso-8859-1?Q?USf3wNtHoMoc3mnHkviEFh3+PP4jZ17xbTz00yEQm1U42tXVk62wfeBq8Y?=
 =?iso-8859-1?Q?BfZ5GHBjEG9YfhxdQSAzChwDvahqZaI3dyFgsHkmeDWiUttnZue08hizZe?=
 =?iso-8859-1?Q?169RK7uVC/T1hIVVtgWY8q+YziR46nkGmGz7meDMQD7GNiuWMLvj7eC8U0?=
 =?iso-8859-1?Q?1qPCFJ1exymucDQgSNzLhgPHC50lpNLdTB147J0gcPzxhOzmnmMDmhtzKa?=
 =?iso-8859-1?Q?uF8YuL/wKiFO9x4gvnpTAEw4RAsrcPZeZqEDGQLjQTR82oyfzioejH+8C7?=
 =?iso-8859-1?Q?2TDMyFsvBT4rpxq8vtzQvF?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8460.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?CwLr46YYTFlXqcn/PUldBnJ6PuljML4E8Jy+UVrweZT3lSkxNjfNWQu3lp?=
 =?iso-8859-1?Q?zRp4Jr2/K6OGqu9bstTlleRc8KjICCOj5WxJ472PdFWZU0jBZGxyT3kkGC?=
 =?iso-8859-1?Q?KuFaz0ZeCq16jGJP1s/i7OsG3v0BSO6EU9eVzUSfCzyW60A82eKtAAckR8?=
 =?iso-8859-1?Q?VsunaCtV+1wHl5af3imAPb5qb+uqnZbKmn2Ernqq4ym4hwXdWTev/R6gC0?=
 =?iso-8859-1?Q?CoyuL6e2C19xkeSOfI9dhY8rClPeTVPsiLo1qKB42YX5Fum9wGf2BDl+/N?=
 =?iso-8859-1?Q?FkqFI2/SgHD+fxq7LzGt6QlsQVy51XYY01TXAQhyCJpTMvotnUzju5Zixc?=
 =?iso-8859-1?Q?8nD998GQxP7obTqOpfl6xOaGNZ47ALEBJFNBUstggyJAm0rQaiylaIm0UI?=
 =?iso-8859-1?Q?cOdaRfGkADM+VgYGWKQMvWLHX8aiFTZ7iAAVHZtNJD/PGXuae791TLFBMZ?=
 =?iso-8859-1?Q?M+GMb50MjyRe5qIYi163B9eW3N9rB4hfem8am4jSHwT+/15cJV9oDv1zVA?=
 =?iso-8859-1?Q?zz9xgJMq/n8WR25ltlRNpfaDXns307Xhen2sj3NKRmBHJ5GWF0Y5jZ3hBU?=
 =?iso-8859-1?Q?OCvsCKCs/kpCuP5e68URzJEP2rnK07cecSoij63/9LVVf/pJlzyUwePcmu?=
 =?iso-8859-1?Q?iLcEf9JfFa5DIC8Dn6NMcUkqqG+3U9mP9mlqyk+1PX2j5K2VRhXeDl1fQY?=
 =?iso-8859-1?Q?Nwy6QOOm/+4tOn/q+15rgnDTyEyGmam7NoSpGo6ihjQOoFjwqlxWbXDE2m?=
 =?iso-8859-1?Q?vQ3iJSIbry3u+6LaH/9f2sIfbCdDUSlIAVADRETFF9wJpQOWCz8gssMC86?=
 =?iso-8859-1?Q?noLORxCFfgrufFHJJk+Zjl5W0tB3Fh2Tq4oaZoG6gTjurGWKS+mtz3dbBF?=
 =?iso-8859-1?Q?2PvRVtEfGm8yu9Mt4gJiVBcQb7X0jG03YDF1Pr5i9ung4AkiphT2Z+/o+B?=
 =?iso-8859-1?Q?KYQW7d0yrzKpUniwwPo8vXg5tgih4fpi1Z4FRqf2iJpsHofqLXuURgIPP2?=
 =?iso-8859-1?Q?m3eQjXpG6yGAa8O8G3juvYpLgpf+SAPskzpZlGau7xcHiVRYlD5Q/1xWJP?=
 =?iso-8859-1?Q?4HN4E3sAh2zYqHXrV5CULVl0f9/+3boWUSUSxyJxCuL6oeCnIA/BoFSnLL?=
 =?iso-8859-1?Q?Ct7ZOf5vb2zgWUXapdLo7QLfA2FwRohcK5J55VkbO7xC/sV1GTu8ur7DXI?=
 =?iso-8859-1?Q?83u9tNDYxEPpPwuVwAum3ymkMbtYv7s1HFkWPdtWmfWdY+EUyTbFzdrOpV?=
 =?iso-8859-1?Q?3TIE+kktRgulwPebL5ZWUg4oMuXUtdWiX4a4jXWKhIjrDNgs0PTx1UFG4V?=
 =?iso-8859-1?Q?+pybK5chTSl/umZR6gVw+TOg1Xc3HGAYJR+v0g+8O9MPrtAJljvKtn/8Ae?=
 =?iso-8859-1?Q?irLA048VFpCrzXrXrGB8QF7eXOC54ol/dVbeln9oLJH91UcDZJJ9Tcg4TC?=
 =?iso-8859-1?Q?R+2BkPiEuDxVczM1YV6gwI7R7BZodtRDRpRKgUEI65XcIci7DZgI/Lz3o1?=
 =?iso-8859-1?Q?W22EZ1tVB8GNUyT+lW/Ww97RXRHbcZEZL3fYGYgkI8VK4jyqYlzzmTR1vU?=
 =?iso-8859-1?Q?lLBsp+Y8Ed2iXOOoqsUMh1Zk0C/uGDGRtu2vmfHn62krR0bm87LNPmMJrD?=
 =?iso-8859-1?Q?lpUrrSg+31IBA=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8460.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a45e7da-736e-450c-509b-08dd649154f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2025 13:49:11.4510 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4GaLy6sKJyDs+mXIV4bT+EcyL7YoyOXkzvCKjMjWlex4dZmjgVdw9o/oMTL1uj/0G82KhWi81rFxac62axzhxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8170
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
From: Maayan Kashani <mkashani@nvidia.com>=0A=
Sent: Thursday, February 27, 2025 12:27 PM=0A=
To: dev@dpdk.org=0A=
Cc: Maayan Kashani; Dariusz Sosnowski; Raslan Darawsheh; Bing Zhao; Slava O=
vsiienko; Ori Kam; Suanming Mou; Matan Azrad=0A=
Subject: [PATCH] doc: add limitation under unified FDB=0A=
=0A=
Add limitation for unified FDB group 0 table creation.=0A=
=0A=
Signed-off-by: Maayan Kashani <mkashani@nvidia.com>=0A=
Acked-by: Bing Zhao <bingz@nvidia.com>=0A=
=0A=
Patch applied to next-net-mlx,=0A=
=0A=
Kindest regards,=0A=
Raslan Darawsheh=0A=
=0A=
