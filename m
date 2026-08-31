Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78D1AC61DD3
	for <dpdk-dev@archiver.kernel.org>; Mon, 31 Aug 2026 18:20:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 60B144026D;
	Mon, 31 Aug 2026 20:20:25 +0200 (CEST)
Received: from alln-iport-5.cisco.com (alln-iport-5.cisco.com [173.37.142.92])
 by mails.dpdk.org (Postfix) with ESMTP id 6D8EB40269
 for <dev@dpdk.org>; Mon, 31 Aug 2026 20:20:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cisco.com; i=@cisco.com; l=12719; q=dns/txt;
 s=iport01; t=1788200423; x=1789410023;
 h=from:to:subject:date:message-id:mime-version;
 bh=eWU7vHyPHy8F79KZUFLdvXHupzdAiQ4z5Vfsq85G9wQ=;
 b=g7ZLw4gI39V527l7WJS6qPhvTJUwwQe2SANo2V5xTOybk2tv446qxh+8
 l5uuMkJYynr0zQcyjVXgyQGKOZgfOz8esHJpyKZHXNlUF0vOaHw8s0lg4
 0KXQ7f3/COJWqzpGpMLcWhj562cn/Ra4Y0fESZuuM3NMkDSqK1vZ2Mc0m
 7AsE6I7uhiKP8lGBQnYDf13x9g4BD5Ei5sUgjhQucngdJa16ymnqRJM8M
 BafCTH5Fp1Y3Kh2M7clVJppEHdXAfWBPzw7hJt5luoDmciJb8By0B/U/Q
 E2aR1VClM7S8+FaHiQWourGskh+jaCvSmOkThtO2FHWgDBiEx7D1iXfpK Q==;
X-CSE-ConnectionGUID: 3LtGfhUdTgKQbP7JSKTv9g==
X-CSE-MsgGUID: eIWF4xW2RgqjUIOXKjALLQ==
X-IPAS-Result: =?us-ascii?q?A0BDBADqxJVq/5QQJK1agS6BK4E9MVOCK4hsA4UrhliCI?=
 =?us-ascii?q?Z4egX4PAQEBDQJRBAEBhQUCjXYCJjUIDgECBAMCAwEBAQEBAQEBAQEBCwEBB?=
 =?us-ascii?q?QEBAQIBBwWBDhOGUAyHbAF/JwQbhRhXAwECs3MCihx4gTSBAeA5gU2FBYNZA?=
 =?us-ascii?q?SqBNQGEMx2DJYEfJxuBSUSBFAFCgycchCmEE4IwBIIiehIbgWJLIIEphnGIT?=
 =?us-ascii?q?IFEIgMmMywBVRMXCwcFgWYDKi8tMjwyHYEjPhc1WBsGBYEdgSiDRCMZNnqBC?=
 =?us-ascii?q?V6BKylhEheBCYIIAoJXggMCAUlDDgdHUwkTC209NxUZAwSBNQWNYoNKBlkSL?=
 =?us-ascii?q?IEfHysaKBgUFy2SRmiPFUejMAqEHoFhoDEXqmsBlACFCCOjZwGFDQIEAgQFA?=
 =?us-ascii?q?hABAQaBaQE6K4EucBU7gmhSGQ+IStVygTYCBwIHDgMLk2YBAQ?=
IronPort-PHdr: A9a23:dBJuIB9OXaKyLf9uWBDoyV9kXcBvk7zwOghQ7YIolPcSNK+i5J/le
 kfY4KYlgFzIWNDD4ulfw6rNsq/mUHAd+5vJrn0YcZJNWhNEwcUblgAtGoiEXGXwLeXhaGoxG
 8EqaQ==
IronPort-Data: A9a23:5cI9I6rR9MNQDd952i3Zz5hE1JVeBmKjZxIvgKrLsJaIsI4StFCzt
 garIBmGOfyINGfyKosjYNzlph8EuZCBn4BjSQY6pSw2FHhH9+PIVI+TRqvS04x+DSFioGZPt
 Zh2hgzodZhsJpPkjk7zdOCn9j8kif3gqoPUUIbsIjp2SRJvVBAvgBdin/9RqoNziLBVOSvV0
 T/Ji5OZYgLNNwJcaDpOtfrT80o35ZwehRtB1rAATaET1LPhvyF94KI3fcmZM3b+S49IKe+2L
 86r5K255G7Q4yA2AdqjlLvhGmVSKlIFFVHT4pb+c/HKbilq/kTe4I5iXBYvQRs/ZwGyojxE4
 I4lWapc5useFvakdOw1C3G0GszlVEFM0OevzXOX6aR/w6BaGpfh660GMa04AWEX0r1THU5A9
 cEUFD8uVxq72MCN446lG+Y506zPLOGzVG8eknhkyTecCbMtRorOBvyTo9RZxzw3wMtJGJ4yZ
 eJANmEpN0qGOkMJYwtHYH49tL/Aan3XaSFZo1+9rqss6G+Vxwt0uFToGIqPJIfaHpUKxy50o
 ErL3lvXXgElbuaQ0Di401Wcpe3muQfCDdd6+LqQs6QCbEeo7mAeFjUaTVe45/6jhSaDt8l3I
 kgQ/G8q6KM17kHuF4C7VByjq3nCtRkZMzZNL9AHBMi24vO8yy6SB3MPSXhKb9lOiSP8bWVCO
 oOh9z8xOQFSjQ==
IronPort-HdrOrdr: A9a23:OIvLh66fvJ2IagzaNwPXwKnXdLJyesId70hD6qkXc31om62j+P
 xG885rtiMc5Ax7NU3I+urvBEDoexq1yXcf2+ks1NmZNmXbhFc=
X-Talos-CUID: =?us-ascii?q?9a23=3AaO39tWlNFhWwuHdZrtbphwV2KrbXOSb50FjeI3K?=
 =?us-ascii?q?0NWlKcbetFn2r2596wsU7zg=3D=3D?=
X-Talos-MUID: 9a23:F25JawomeDu6UVL5w7QezzxDC+k085v0Mk8Uk6gnnPmnNwVUHw7I2Q==
X-IronPort-Anti-Spam-Filtered: true
Received: from alln-l-core-11.cisco.com ([173.36.16.148])
 by alln-iport-5.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 31 Aug 2026 18:20:22 +0000
Received: from alln-opgw-4.cisco.com (alln-opgw-4.cisco.com [173.37.147.252])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by alln-l-core-11.cisco.com (Postfix) with ESMTPS id 2D61C180001C4
 for <dev@dpdk.org>; Mon, 31 Aug 2026 18:20:22 +0000 (GMT)
X-CSE-ConnectionGUID: cE+0Mp/BR4SsXwexHFR9Og==
X-CSE-MsgGUID: o8VHkSNXTKOXTUPLkLx/+w==
Authentication-Results: alln-opgw-4.cisco.com;
 dkim=pass (signature verified) header.i=@cisco.com
X-IronPort-AV: E=Sophos;i="6.25,254,1779148800"; d="scan'208,217";a="85121848"
Received: from mail-eastus2azon11010027.outbound.protection.outlook.com (HELO
 BN1PR04CU002.outbound.protection.outlook.com) ([52.101.56.27])
 by alln-opgw-4.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 31 Aug 2026 18:20:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nL/66Le3VB2EON+pfLlP2uFk6hVI+sO10EhBsR4KRcOw/EfAOA0mjtU3nZhoPcVdXUHifYgMVhkI1t3Y5yYO661tdF85q4ABb5T2dznL8fp3yDwYihl7WAyls2HGiOmuLq4TolSqRRx7sh/XpLMAj8Lx5TqDqKEKEhzTroZOezufAPfApqb21Z6TacLSXRV++vGX8kKIXLjQUGd53D3EYQBzvrxO7eLZoQOQ8vpVdz075hS4zjvSsY82/KiW2lXDM8aQTMHAsYM2CJfYFpl9erNOfudDoVXwfvFGM1kNnQLHGWm3OlK6aMOyYSmEKOYAqy6mZOHmGirMXW7Yrnp1bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eWU7vHyPHy8F79KZUFLdvXHupzdAiQ4z5Vfsq85G9wQ=;
 b=fYuRc77Nz1OHqjdTFOzn+4cJzK3+QMgWqvfGoUSx6QEIg8QKI0jQaSAHlRPmN8ECep9zZ7BVLJNiirf6FTkVcT87zqS83NbErvS3+3FN9T1DFsfYcetT9iDG7qEv61aFYpRV4gbimCL890Zoor/3Dw0kKBrxHElKy5PIQ3Gb7PfCqVvGDhKEWBfRfuBgQnSgEZefh2b1h8YfOLpkCwxLrNd1CjS4U2zegVwLURhNnl7/NJCZWXrxY889HU8B24HHQadLM7S1UOybeEekyGT9PEW9mTq2FVI9l4W1F2+cra9e9abGxXW9z7aZNq4pBo8g7SNxwdKyb5ej05+EUti0xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
Received: from PH0PR11MB7616.namprd11.prod.outlook.com (2603:10b6:510:26d::20)
 by SJ0PR11MB5200.namprd11.prod.outlook.com (2603:10b6:a03:2df::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 18:20:19 +0000
Received: from PH0PR11MB7616.namprd11.prod.outlook.com
 ([fe80::9ba7:5071:9af5:340]) by PH0PR11MB7616.namprd11.prod.outlook.com
 ([fe80::9ba7:5071:9af5:340%5]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 18:20:19 +0000
From: "Randy Tice (rtice)" <rtice@cisco.com>
To: "dev@dpdk.org" <dev@dpdk.org>
Subject: [RFC] mbuf: add configurable base private size for pktmbuf pools
Thread-Topic: [RFC] mbuf: add configurable base private size for pktmbuf pools
Thread-Index: AQHdOXCgdP+ENN3UFk+QdyL24xrKUg==
Date: Mon, 31 Aug 2026 18:20:19 +0000
Message-ID: <PH0PR11MB76163DCD87BB40C437CB54C8A9A92@PH0PR11MB7616.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-reactions: allow
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB7616:EE_|SJ0PR11MB5200:EE_
x-ms-office365-filtering-correlation-id: 4d0fe611-a63f-4b36-23b5-08df078c83a9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|56012099006|10067099003|11063799006|6133799003|18002099003|8096899003|38070700021;
x-microsoft-antispam-message-info: gdntxvXk2cETM0rnT0buEmb2/nn0ZSlHm0pmcouUavzZGCfQseqoKM+PX77g2SYyQPOXlSTnvGW0WnnzdTX7PhZbTX92QXQl1C1Iw3Sh73gi+6n/Vvov+5Dy/pLpfwq6dHc+COnin7zAGqWJ3byUY3+6+h3EzPVpPaw2fMQBg0sMl8EFOtTwPFvRwCpZzAVh8FwArGKxUeSkYwl+/aC0Cd4Pr019qLqyINEW8/TMFmYLbsiSQyiqNASC+8w21F6wBcjD3u+9uOuDHcxxgOy+f4FoqOvOcQjJRDrbOfVL6qXBnUVwMNR/h8q4XlK+fQSBb1BdJu9ice107wgnM2+uqDZhRiNYTrZ/dCnWQZQ3YZiH3H6XirWP1oGGc2DAK8z4AmFgHjczdK/6O+LC8DOV21+pxsh6Ykc+r0LtXnJZ2J2MjUCLw/PsKAQpM6xYCQqSSjL/alQ6B3WGZRRu+ph8gSHR8s8vpCP1vPrHan+o/XbU2ATRuNqx4LJcpo5VMYqtRzYg1g8tAYQr3kGIXtZSok1HzwV1zDAApxCHm9FEPlGjI86ZAn6wenx0xmWztBNxBzS0JlxhG7E/izDtGqOCoaX1fFRdOnemopWmXO0e+Wn0oefxk7hLCE6dU7bXeNAt3os+1Fk4wBwuB+t/W8ZpK6FwwKgn6vAss+QNOotoDDNTUrehvZJY24VL06URZwNgLQ2q1N5kbMieyYIcbOBKaYbT0COyem7Fpg18XIZT4Ag=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR11MB7616.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(56012099006)(10067099003)(11063799006)(6133799003)(18002099003)(8096899003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?KladBlPmbRdvWh8ZoMoUNbHYDVxbzldzdYdBkkGczl9JKk/c7QPme5nLtjZ9?=
 =?us-ascii?Q?KjE19mVqLBkoNa2ncxt+tgKot7QUCQLn3/+cJGqrQM8NTuKkXSGyZ4UmjUwA?=
 =?us-ascii?Q?qUR9a0nn08d5ARBq8i/P40UifcAsgHiCOvmsm1oUcXOhCBKE5D80pHKhvG68?=
 =?us-ascii?Q?24rJiDzmn1AREK3Yxf6wgCThy6YivyWW9+YmcbIL087II6DfDhu2xz7whTzY?=
 =?us-ascii?Q?Kb41Dhw8K+EHW4ly77GlUDqKmIRPm+Wy11SwqFnToeUbpjl58img5fYiL9jT?=
 =?us-ascii?Q?itaq7MfrMeuJ5MGUfzN7+oRNdKdlq+ldmXrEwuHnnhZGb82kz8Bj0mNyiuz8?=
 =?us-ascii?Q?6U7dn9OMX3fJmeLhDOr/FccBaK1+gf4HXC2Qc0VlcgA7+voxalqvdikkBvxi?=
 =?us-ascii?Q?DYTo0Uh0lxhTc1DJwNQyzt6P5GdTqmpfSOYD9sBNVLpG1VnN2jHoeBusY7rC?=
 =?us-ascii?Q?ROqiO2bRwap5VULqL/gLR8QilfUZHVQ8sxkY+4tm2wAX23lqBWgZ+P7SZ/x+?=
 =?us-ascii?Q?gZo5aFCNBcnrmBWy+FxpPk2x5BpHvvX/LvKlz/uu8bN0VHnzNcT5HuOMxgco?=
 =?us-ascii?Q?zYV6hKihe/83ILD3Q79ie4ofrBxu+8em0XmXQqT3jjB3xMyEWDczoHeB+Zsf?=
 =?us-ascii?Q?J+J6f3nyxpna1I9iTAhtE1mh97m9hlvqNVw7n8TsMlp+Plok1R3N9+/4ymSX?=
 =?us-ascii?Q?v6++QivPvB/28rcmOYUvuf63CO88EBA6oEk6JuvKFZKe0wO1Gbx5fAAck4Yj?=
 =?us-ascii?Q?rpcyDBhKOU17VEmzwL4fT8rHBSQtE9f+K01LsntRmzL3OZxioAJm7HuHRZr+?=
 =?us-ascii?Q?Qa3VUO8rSaSp+COraOgur1n6eTYraoZKC+CbJD8iKxnqUNKfLPLSZhPIXV2S?=
 =?us-ascii?Q?4Dm/0hyOf+WnVZEXOvo5a9d7XQEgIiyE7RmahmEgtOYnIWSWO3FdThWQAWkR?=
 =?us-ascii?Q?WDUyThp3VKfK6Kpa9D5M1X4hAIMhQ5YfGKd1DZ+tiA3FvYyeA4cNJvB65r7q?=
 =?us-ascii?Q?3AV+LGO6Q7ZtYu4toUY04gCkAB8XwPIjLIZm5qMpcLWGkNH4yMH8ZwL1xFAa?=
 =?us-ascii?Q?CuadtLYGIH0Jd2L9JX2cnw3nVT854NLDCVeRnme8H+Tp3ZRJOm4tATHPH+Ux?=
 =?us-ascii?Q?QLlGe53L59mAG5HCNoiToQSv+BylsEL4Iqob5Wt5sd45fazbVry91WxYkcMz?=
 =?us-ascii?Q?hJZ1RWHThWRAGF3/qLbhE7OFymzAsr/iz7F1ZDDFxrA0RSxCJew4ioyuKDP2?=
 =?us-ascii?Q?nBw7ghbtnn4tFQWyZsQwcyAU0lQ4M/jGsxRH9eNNxinxTYImbkrXRVfp0OCw?=
 =?us-ascii?Q?/SQOS/QypqhvUNeQfpMfoyBom6eoK02xamXjn/Ic1Hne+arqrAKc5fiRzlX1?=
 =?us-ascii?Q?KSNqP8D8upHVHSb5oCuonfqIziO/lQfFTyPXE3exVeCJnAuXsW502hSA6KXJ?=
 =?us-ascii?Q?fDxtCVz2AhwSOQo8avX7i2QFwN5f6u8qw1ZfQV8IslgLGGuNpQYh/76uFRcy?=
 =?us-ascii?Q?6LtMNiW/zzFQuQsXnyFLkma1Z+Xxod9uLNktwJ5sgL7Vzh03wPF6+czD0Bpo?=
 =?us-ascii?Q?XGwOVghgVqYgWORgu20tcVaJZVisVSJG0sBKJ7CfqQIes9/BiA7Gqiuhf7h/?=
 =?us-ascii?Q?aok0Xdb53ysMpuUKIfm7aBbNHStPnv/dMQcu8C16zi96mZLhwVRletu5pQJE?=
 =?us-ascii?Q?9Tc9C7HY8s3/s2sQLxqXVD/H50E6/on9wWFFPZcOtPE3NnR/D5cJdVVPyYGu?=
 =?us-ascii?Q?mzOjMcNxQw=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_PH0PR11MB76163DCD87BB40C437CB54C8A9A92PH0PR11MB7616namp_"
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: u5xbqunOyBUnRitEib98SpqHA5z6qyIMvZXXsKus3ZRDVexY729QzblORVgYOKtKPiaF3Ok7Lo2C88WEPCDNyrb1XTdh5fyt2crxyyax1j12lhD5ozeUhZz/Cb73Dj8Qs4p6mN8cKJWJ4hwwl7fyudEDJt2ki8XKiQ3p/3VmLrCsdcxTpeJ6pgUIBT3ppXwZeOG4JJobbPVSbytsU7Bd6JI1lLHp3pJkyIOKvhWYWnnlvXrjkv+JUl7hxd6DiJq+8L7VLDE7+rhfOeLnXll1+mORWMH4jmaMoHUwhS6fdfFSeoz8FwbapLf2ak+h15uGI7MXvNWUiOd78Nv6q08/cQ==
X-OriginatorOrg: cisco.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7616.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d0fe611-a63f-4b36-23b5-08df078c83a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2026 18:20:19.5293 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dSlDKKv+dGV64Lv4Qs2PmjP14x/+rwj5+p9q5wnGOApCF/97YLFOP8FeSyB5fkj9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5200
X-Outbound-Client-TLS: ANONYMOUS; alln-opgw-4.cisco.com [173.37.147.252];
 TLSv1.3; TLS_AES_256_GCM_SHA384; 256
X-Outbound-SMTP-Client: 173.37.147.252, alln-opgw-4.cisco.com
X-Outbound-Node: alln-l-core-11.cisco.com
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

--_000_PH0PR11MB76163DCD87BB40C437CB54C8A9A92PH0PR11MB7616namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,

I would like to get feedback on a proposed mbuf change before sending patch=
es.

Some deployments need a guaranteed private-data reservation in every packet=
 mbuf, across multiple mbuf pools and across different consumers of the mbu=
f APIs.

Today, each pktmbuf pool can request a private size when the pool is create=
d. That works when the application owns all pool creation policy directly. =
However, not all relevant mbuf pools are necessarily created by application=
 code. Some pools may be created by libraries, drivers, or other components=
 outside direct application control.

One example already in DPDK is vhost crypto, which creates its own mbuf poo=
l and supplies a private size for struct vhost_crypto_data_req. There are a=
lso driver-created pktmbuf-style pools, such as cnxk inline meta pools and =
TAP GSO context pools. These are examples of pool-creation paths where the =
application may not directly control the private-size value used at creatio=
n time.

A PMD-specific devarg could solve one instance of this problem, such as a s=
ingle driver-created pool, but that seems too narrow if the requirement is =
not inherently PMD-specific. A deployment with multiple drivers, libraries,=
 or other pool-creation paths outside application control could need the sa=
me base private-size adjustment. In that case, configuring the same value i=
ndependently through component-specific options would be fragile and easy t=
o get wrong.

The proposed generic model is to add a configurable base private size for p=
ktmbuf pools. The effective private size would be:

align(pool_requested_priv_size + application_base_priv_size,
      RTE_MBUF_PRIV_ALIGN)

The tentative EAL option name is:

--mbuf-base-priv-size=3D<size>

The intent is:

  *   default behavior remains unchanged when the option is not used;

  *   the configured base size is added to the private size requested by ea=
ch pktmbuf pool;

  *   the final effective private size remains aligned to RTE_MBUF_PRIV_ALI=
GN;

  *   pool-specific private-data requests still work as they do today;

  *   DPDK centralizes the policy so pools created outside application cont=
rol can reserve the same base private-data space as application-created poo=
ls.

This is not intended to define ownership or layout of the private area. It =
only ensures that a deployment can reserve a common base amount of private =
data consistently. Applications, drivers, libraries, or components would st=
ill be responsible for their own interpretation of the reserved private are=
a.

Questions for the list:

  1.  Is a deployment-wide pktmbuf base private-size reservation something =
DPDK would consider acceptable?

  2.  Is --mbuf-base-priv-size=3D<size> a reasonable name, or would another=
 name better describe the intent?

  3.  Should DPDK expose the effective-size calculation as a helper so pool=
-creation paths outside application control can apply the same rule?

  4.  Would maintainers prefer consumer updates in the same series as examp=
le users, or as follow-up patches after the generic mbuf/EAL change is acce=
pted?

  5.  Would maintainers prefer this to remain component-specific, even if m=
ore than one driver, library, or pool-creation path may need to apply the s=
ame base reservation?

The main goal is to avoid downstream mbuf layout changes and avoid componen=
t-specific configuration drift, while still allowing deployments to reserve=
 a consistent private-data area across all packet mbuf pools, including poo=
ls created outside direct application control.

Thanks,
Randy


--_000_PH0PR11MB76163DCD87BB40C437CB54C8A9A92PH0PR11MB7616namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
</head>
<body>
<p style=3D"text-align: left; text-indent: 0px; text-transform: none;"><spa=
n style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: 12p=
t; color: rgb(0, 0, 0);">Hi,</span></p>
<p style=3D"text-align: left; text-indent: 0px; text-transform: none;"><spa=
n style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: 12p=
t; color: rgb(0, 0, 0);">I would like to get feedback on a proposed mbuf ch=
ange before sending patches.</span></p>
<p style=3D"text-align: left; text-indent: 0px; text-transform: none;"><spa=
n style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: 12p=
t; color: rgb(0, 0, 0);">Some deployments need a guaranteed private-data re=
servation in every packet mbuf, across
 multiple mbuf pools and across different consumers of the mbuf APIs.</span=
></p>
<p style=3D"text-align: left; text-indent: 0px; text-transform: none;"><spa=
n style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: 12p=
t; color: rgb(0, 0, 0);">Today, each pktmbuf pool can request a private siz=
e when the pool is created. That works
 when the application owns all pool creation policy directly. However, not =
all relevant mbuf pools are necessarily created by application code. Some p=
ools may be created by libraries, drivers, or other components outside dire=
ct application control.</span></p>
<p style=3D"text-align: left; text-indent: 0px; text-transform: none;"><spa=
n style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: 12p=
t; color: rgb(0, 0, 0);">One example already in DPDK is vhost crypto, which=
 creates its own mbuf pool and supplies
 a private size for <code>struct vhost_crypto_data_req</code>. There are al=
so driver-created pktmbuf-style pools, such as cnxk inline meta pools and T=
AP GSO context pools. These are examples of pool-creation paths where the a=
pplication may not directly control
 the private-size value used at creation time.</span></p>
<p style=3D"text-align: left; text-indent: 0px; text-transform: none;"><spa=
n style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: 12p=
t; color: rgb(0, 0, 0);">A PMD-specific devarg could solve one instance of =
this problem, such as a single driver-created
 pool, but that seems too narrow if the requirement is not inherently PMD-s=
pecific. A deployment with multiple drivers, libraries, or other pool-creat=
ion paths outside application control could need the same base private-size=
 adjustment. In that case, configuring
 the same value independently through component-specific options would be f=
ragile and easy to get wrong.</span></p>
<p style=3D"text-align: left; text-indent: 0px; text-transform: none;"><spa=
n style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: 12p=
t; color: rgb(0, 0, 0);">The proposed generic model is to add a configurabl=
e base private size for pktmbuf pools.
 The effective private size would be:</span></p>
<pre><div style=3D"text-align: left; text-indent: 0px; text-transform: none=
; font-size: 12pt; color: rgb(0, 0, 0);"><code>align(pool_requested_priv_si=
ze + application_base_priv_size,=0A=
 &nbsp; &nbsp; &nbsp;RTE_MBUF_PRIV_ALIGN)</code></div></pre>
<p style=3D"text-align: left; text-indent: 0px; text-transform: none;"><spa=
n style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: 12p=
t; color: rgb(0, 0, 0);">The tentative EAL option name is:</span></p>
<pre><div style=3D"text-align: left; text-indent: 0px; text-transform: none=
; font-size: 12pt; color: rgb(0, 0, 0);"><code>--mbuf-base-priv-size=3D&lt;=
size&gt;</code></div></pre>
<p style=3D"text-align: left; text-indent: 0px; text-transform: none;"><spa=
n style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: 12p=
t; color: rgb(0, 0, 0);">The intent is:</span></p>
<ul style=3D"text-align: left;">
<li style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: 1=
2pt; color: rgb(0, 0, 0);">
<p role=3D"presentation"><span style=3D"text-transform: none;">default beha=
vior remains unchanged when the option is not used;</span></p>
</li><li style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-si=
ze: 12pt; color: rgb(0, 0, 0);">
<p role=3D"presentation"><span style=3D"text-transform: none;">the configur=
ed base size is added to the private size requested by each pktmbuf pool;</=
span></p>
</li><li style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-si=
ze: 12pt; color: rgb(0, 0, 0);">
<p role=3D"presentation"><span style=3D"text-transform: none;">the final ef=
fective private size remains aligned to
<code>RTE_MBUF_PRIV_ALIGN</code>;</span></p>
</li><li style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-si=
ze: 12pt; color: rgb(0, 0, 0);">
<p role=3D"presentation"><span style=3D"text-transform: none;">pool-specifi=
c private-data requests still work as they do today;</span></p>
</li><li style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-si=
ze: 12pt; color: rgb(0, 0, 0);">
<p role=3D"presentation"><span style=3D"text-transform: none;">DPDK central=
izes the policy so pools created outside application control can reserve th=
e same base private-data space as application-created pools.</span></p>
</li></ul>
<p style=3D"text-align: left; text-indent: 0px; text-transform: none;"><spa=
n style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: 12p=
t; color: rgb(0, 0, 0);">This is not intended to define ownership or layout=
 of the private area. It only ensures
 that a deployment can reserve a common base amount of private data consist=
ently. Applications, drivers, libraries, or components would still be respo=
nsible for their own interpretation of the reserved private area.</span></p=
>
<p style=3D"text-align: left; text-indent: 0px; text-transform: none;"><spa=
n style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: 12p=
t; color: rgb(0, 0, 0);">Questions for the list:</span></p>
<ol start=3D"1" style=3D"text-align: left;">
<li style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: 1=
2pt; color: rgb(0, 0, 0);">
<p role=3D"presentation"><span style=3D"text-transform: none;">Is a deploym=
ent-wide pktmbuf base private-size reservation something DPDK would conside=
r acceptable?</span></p>
</li><li style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-si=
ze: 12pt; color: rgb(0, 0, 0);">
<p role=3D"presentation"><span style=3D"text-transform: none;">Is <code>--m=
buf-base-priv-size=3D&lt;size&gt;</code>&nbsp;a reasonable name, or would a=
nother name better describe the intent?</span></p>
</li><li style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-si=
ze: 12pt; color: rgb(0, 0, 0);">
<p role=3D"presentation"><span style=3D"text-transform: none;">Should DPDK =
expose the effective-size calculation as a helper so pool-creation paths ou=
tside application control can apply the same rule?</span></p>
</li><li style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-si=
ze: 12pt; color: rgb(0, 0, 0);">
<p role=3D"presentation"><span style=3D"text-transform: none;">Would mainta=
iners prefer consumer updates in the same series as example users, or as fo=
llow-up patches after the generic mbuf/EAL change is accepted?</span></p>
</li><li style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-si=
ze: 12pt; color: rgb(0, 0, 0);">
<p role=3D"presentation"><span style=3D"text-transform: none;">Would mainta=
iners prefer this to remain component-specific, even if more than one drive=
r, library, or pool-creation path may need to apply the same base reservati=
on?</span></p>
</li></ol>
<p style=3D"text-align: left; text-indent: 0px; text-transform: none;"><spa=
n style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: 12p=
t; color: rgb(0, 0, 0);">The main goal is to avoid downstream mbuf layout c=
hanges and avoid component-specific
 configuration drift, while still allowing deployments to reserve a consist=
ent private-data area across all packet mbuf pools, including pools created=
 outside direct application control.</span></p>
<p style=3D"text-align: left; text-indent: 0px; text-transform: none;"><spa=
n style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: 12p=
t; color: rgb(0, 0, 0);">Thanks,<br>
Randy</span></p>
<div style=3D"direction: ltr; font-family: Aptos, Arial, Helvetica, sans-se=
rif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
</body>
</html>

--_000_PH0PR11MB76163DCD87BB40C437CB54C8A9A92PH0PR11MB7616namp_--
