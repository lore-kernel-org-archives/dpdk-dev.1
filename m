Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A785C5B543
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Jun 2025 08:32:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 213564042E;
	Wed,  4 Jun 2025 10:32:23 +0200 (CEST)
Received: from egress-ip11a.ess.de.barracuda.com
 (egress-ip11a.ess.de.barracuda.com [18.184.203.234])
 by mails.dpdk.org (Postfix) with ESMTP id 1FF744029D
 for <dev@dpdk.org>; Wed,  4 Jun 2025 10:32:12 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on2137.outbound.protection.outlook.com [40.107.22.137]) by
 mx-outbound9-92.eu-central-1a.ess.aws.cudaops.com (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 04 Jun 2025 08:32:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y7yn2NEhVelHaLEacuUgnAu6BGDTHwSS7qh9PFoZgzWcbVVzt58X1nbf+j4RfqweINBsGVelF9hZ6yux6OT3d3u0Dw0ZkdapWy0BYWxDZx7wa98xmGunLLwXxhs4semaKxWhfd+a6mThYZhjnx8OfgOBZZ6o3AZhRGCqzkpX09Qr6qSRjCD0WU+yHbxWeMD1dbx9pT05udUuaGSYYPVc0/j3DWYs9BFjPH7S0ObvghyOz/UDZUhBZFbskx0JXT1nIAVKearhz0zI6G/jVjEEReO9yVxlWTCGZ0nrq+doG08wgcF6xt5Z5IBr0qDDbUPsCRuybtjVBlcL1pjWBR43Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uqjQ22tXk4qFC5UxZG3uuMnrsIv3IaAOpKcKrvJBKxQ=;
 b=ARDrJmiPML5rhFyChhuKS96pxXmbTtAmLPkj7jyof4ssw9PJql6ZYkG6nS9Fp7MHHv0HyFrPugSGg/qV7k2lV5/hgl83DcbdPLP/t/mEdZwC3zUzapG/FYnJsbSOiPA7EPPzYajZddhpAxdU7UcYkgOAip4JuCj//Curztu6sCefwQ1ZV86u4fNgT3PlPgFHomi6x2cYNIe54eDmX8+2kTfwtnL/7L14xX2rIgMA7JhP2z5NHFh+S5qKeXD8o/UMeFcP4sXATGQiAbG8pHD4NkdfEinwe2V5ZRgt9B5Ep/MIuRNUvZuGcsuEi74kiRqZpiAWRi37H4DfugglxXwJZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=napatech.com; dmarc=pass action=none header.from=napatech.com;
 dkim=pass header.d=napatech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uqjQ22tXk4qFC5UxZG3uuMnrsIv3IaAOpKcKrvJBKxQ=;
 b=pWHaxjBHFRk2QqhTd5qXIYSF6x2DK/xWKn8ZYZ32QWFbYA1insf4m1Qi0lJ6YOXnsWJzBWtlDj6GdqccIL32gA6vuuI+XYlg3vWGycDjyuIuwGLTB8Iu5BrDttpXuvNxp/so2zGYOuAfzbddu6ZlFgolYNOEpGRFzhT3K7BVbcA=
Received: from PAWP190MB2160.EURP190.PROD.OUTLOOK.COM (2603:10a6:102:471::8)
 by GVXP190MB2232.EURP190.PROD.OUTLOOK.COM (2603:10a6:150:219::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.19; Wed, 4 Jun
 2025 08:32:00 +0000
Received: from PAWP190MB2160.EURP190.PROD.OUTLOOK.COM
 ([fe80::d3d4:c2b6:72cd:a034]) by PAWP190MB2160.EURP190.PROD.OUTLOOK.COM
 ([fe80::d3d4:c2b6:72cd:a034%4]) with mapi id 15.20.8813.018; Wed, 4 Jun 2025
 08:32:00 +0000
From: Danylo Vodopianov <dvo-plv@napatech.com>
To: Maxime Coquelin <maxime.coquelin@redhat.com>, "thomas@monjalon.net"
 <thomas@monjalon.net>, "aman.deep.singh@intel.com"
 <aman.deep.singh@intel.com>, "yuying.zhang@intel.com"
 <yuying.zhang@intel.com>, "orika@nvidia.com" <orika@nvidia.com>,
 "mcoqueli@redhat.com" <mcoqueli@redhat.com>, Christian Koue Muf
 <ckm@napatech.com>, "matan@mellanox.com" <matan@mellanox.com>,
 "david.marchand@redhat.com" <david.marchand@redhat.com>, Mykola Kostenok
 <mko-plv@napatech.com>, Serhii Iliushyk <sil-plv@napatech.com>
CC: "stephen@networkplumber.org" <stephen@networkplumber.org>, "dev@dpdk.org"
 <dev@dpdk.org>, Chenbo Xia <chenbox@nvidia.com>
Subject: RE: [PATCH v4 1/1] vhost: handle virtqueue locking for memory hotplug
Thread-Topic: [PATCH v4 1/1] vhost: handle virtqueue locking for memory hotplug
Thread-Index: AQHb1INXbzAz0TMiZEy8qVH/AecSzrPyqBqr
Date: Wed, 4 Jun 2025 08:32:00 +0000
Message-ID: <PAWP190MB2160B45C3304F810ED0172918B6CA@PAWP190MB2160.EURP190.PROD.OUTLOOK.COM>
References: <20250602084025.1881768-2-dvo-plv@napatech.com>
 <20250602085005.1882499-1-dvo-plv@napatech.com>
 <20250602085005.1882499-2-dvo-plv@napatech.com>
 <6ee82aef-dbb1-4e5f-8a53-6a956161c1db@redhat.com>
In-Reply-To: <6ee82aef-dbb1-4e5f-8a53-6a956161c1db@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: ru-RU
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=napatech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAWP190MB2160:EE_|GVXP190MB2232:EE_
x-ms-office365-filtering-correlation-id: 008023cd-d946-4846-2562-08dda34246bc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|921020|38070700018|8096899003|7053199007;
x-microsoft-antispam-message-info: =?koi8-r?Q?xqQ584nsrbjxCeNg3GnYc/ehFQoLlbEtGNk/Cq1QVXJv7zaaAmDp5+6pbrtT4p?=
 =?koi8-r?Q?Ql6Fub4UjX360QxOWG7e+R1PRP4mfsIxM0Esya4V7LHB5TZm+la3mUw2q/Ul2h?=
 =?koi8-r?Q?3ok7dbhDVThX2Cjcork1Iz7jphiHSd0xyAnz30owjWCCVt+vPt6BPg7qHAkGRo?=
 =?koi8-r?Q?TDCNT6JXq5ddkMcxsbCBQOjvoKzZPv9ome/whqNrSoBBfGNpvgKM3D+NDGhuWP?=
 =?koi8-r?Q?i8/baPKiZWwm8yANTxMODNJoKcW05Z1ry/n4cbqVdNt7DBKr6lMzvD00iDfrCK?=
 =?koi8-r?Q?2fh42yUVuhFkqFEoCRNYLXqir7TezIztnZEyB61j318V5eZptAIMf3rt0kcfb0?=
 =?koi8-r?Q?y2ZQqq/P2+j0gLbw0InBYD2j3dGf15lV/xz1Rj+60d69C/MpHSA5NeaPTBIpcO?=
 =?koi8-r?Q?RdKK+KgcIC5omm05mF2gP26gFZAfFKsspLR6H7wPWDxKe9pwi2SaN1lIzeeEHS?=
 =?koi8-r?Q?VQnojhtpjgWBlOOXXQd+c11WmW7WTkhveOAmJFB4KJiNxg/jPXMeC6HBg6flt9?=
 =?koi8-r?Q?+ACTQUtpUARg6B86AAtnOqF6VXRnmZLBoo0kIsOulbjUOyXOApaP+9GMnBz6O1?=
 =?koi8-r?Q?4VApZGuxJxwOlhGpMTQVXRvUNZ2hJjmNhB+5+X1wKBG9ZOpKAQ90IsbXqjmryv?=
 =?koi8-r?Q?ymGfFP/yxa4qd7P6/qUJtO3PBeYgXXVt6umMrSTBmVjwv8Df4VsW39qaRNKsmE?=
 =?koi8-r?Q?6L/62yj+GxBJfmsUJoVp7KGMjwiqggMMW167OQljmncPQjI/xjsECqpFKIhiD3?=
 =?koi8-r?Q?gs9Am82vVWrYK0Vvm7cTGDxiFw7+Giq3QQjYxf2q+Is9qggpdiFwsMof6NATJ1?=
 =?koi8-r?Q?p/wP+k1PghlwVviyOyffx8aEq/r9F1KUpl12jkM5wkJuex58mTXXwMt8TP4n69?=
 =?koi8-r?Q?P8LPIFSdpOmEOf3lW4k7qsZWL2/ZYujVjsM0ArR9bivI5C5rYpo1DfbVkWFNjK?=
 =?koi8-r?Q?iZUCvQ8ythR+euzAwbsMBB4RMoyqghvE3crc4VlMVrYCyzTLwqgGC6kH6oazyu?=
 =?koi8-r?Q?qUSUpQBowAmN/sFBAXhNenBBy29d7TgCCjTCV4mlewKDpUOsyUUlwTlvVVAC7z?=
 =?koi8-r?Q?PyGdcutjpi5uTJcGH+6ueWHdJ6YyTQY9dbImDZfUNxkO9nah6gPVDxJrSE4rfe?=
 =?koi8-r?Q?snNbK0Q/VX2TZheIrMarFavOTOVEGzRDP/zjjpyzawneewd5Ud+dVXEBGtVUpJ?=
 =?koi8-r?Q?x0sIkmC9I1k4myLix81FPiqcDtRp4ByBIN4pQTXw5AzjDVWOr3PyBvqbZ0h1Hc?=
 =?koi8-r?Q?riP96hKo+xLg2Ssi4pGbgp4bi1n+2N4E4MdzhOHM5wwctzg56/vQADOLPVspGv?=
 =?koi8-r?Q?Dpq1jzhUPMu22FAjOdyUDctqOxAkEEMKH7n0ImWRTYIvuUJfARaf1zdkzfzAiB?=
 =?koi8-r?Q?vOhlr7Je1on1jbmhLtCVawGhXfYpId+lO10+8BO11EhSsSZEZGxfXXYaVd/gBP?=
 =?koi8-r?Q?oVeLS4RsMZB0nwj8pJMU5C5ou2s=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAWP190MB2160.EURP190.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(921020)(38070700018)(8096899003)(7053199007);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?koi8-r?Q?hXh4atZk5PcEO9nmkhgitKEUZiixoevR2V1HoXIV0klYi4Vju0Hw2oaoaoZOIt?=
 =?koi8-r?Q?66ZuCkLS8aQlF+uBWVDmasKO5RHt+L3+asuqZaF6GmAH8AqhMyaeXRGwd5L1qF?=
 =?koi8-r?Q?zylQf1VtrT7x4BrJ8uzZEYL/lVTlwYZFoAVh6NquhiSrSndKNSJU1iU7+LVVqG?=
 =?koi8-r?Q?FY8A6LHkocPcu++Xec5su5BK/HbRF4Owtqn2k/5oTyz6TV7s8jrQUnmJkL0XTf?=
 =?koi8-r?Q?cRq3UjQpl6unjNIghLGnmg3eBGN0d/cGzbJdLRDwY7D4YuzF6kARiN4DaIa/SU?=
 =?koi8-r?Q?Si/MWpO7rwTW2Et2Ycp1Q2fG/nZhqPNfbXgShWKnFHYz77+2v2gpqaG8Lq44+Y?=
 =?koi8-r?Q?I3/6GJG4AwZmrGx+FEGiODzKaPCS/o0lokYqHoIy0ozuk3Dk+Cp/VT//1H7QDd?=
 =?koi8-r?Q?IIN7TfEk3f7tOYI6I1BU7auX1DNb5CDrsSBPokdes8mWU4t1XOWz2EDVloLi3O?=
 =?koi8-r?Q?qvgxJBS0LsAUr78nm2kFTFo9/QvWULp+uxE0t6CGChwJjEQKKzhNA03o6Dshad?=
 =?koi8-r?Q?88D5GaoK5qJcVkv/yN5sNlx2czIz9vDu8xY1p9bVbyd58tiYPr1LxhBAwQJkwJ?=
 =?koi8-r?Q?PS+ZcyhnYZLyNThb/aVvggmA1GKIlfBwLp0/0UXJ6Rr2FHetj1cqhk4I6jWzaY?=
 =?koi8-r?Q?ek4GzWn/1D1PiEOqXE0sBqFO6j/WvY27nSvEWK2yRIF0IUbvj/rMFFvGZwHok+?=
 =?koi8-r?Q?a/U1snI5vHxm6xKk2DU3aUrfpyuRQfIvx+6Rl4bGSUKX8tqm7wnHyxIqBHGGRQ?=
 =?koi8-r?Q?WvPo9v0teZrF+VO0VoWLaPLud/Jm5XKYyhcxwyMUZHIs6Ymnjd28D+hUud1KgI?=
 =?koi8-r?Q?E1Dam8vaVoeNQ2W1EaN1gTpzDCjf0xMuKNQUirUHeAuhYYvg57ot8ZsNn3tYp8?=
 =?koi8-r?Q?kKTtTXB15SMDGca18a5gUaJZBW4Tv0ATOSI0HONjKJ4TCk2E0nNJ/xSxKFH5wX?=
 =?koi8-r?Q?AVVCqbjVYkKtKKtVGBT9mN9U43HQpRq69+xlSHtSNuhw457xZNHtNnfJGqTnET?=
 =?koi8-r?Q?+XzQN4H1TRDVJ+DkxKsFpTl6RKRpvKIsaHgjJdbLxi1HI68cQHZD5R2SX6fytS?=
 =?koi8-r?Q?gVSjAN6hwDUsxOPA8KGKBQbRhqXWR+YDQUbHsmo4WrwOf205IBIsm2DC4Tz98F?=
 =?koi8-r?Q?zcyy77YonFeTuzrN+QdIs6Yrsi1KKlju0kMgUQotvc9cNYHyx5+s9f4GWTThDr?=
 =?koi8-r?Q?vlOWtdDqd3n5cdU0U0QfOXnxRp3jqbMt9ShMQAQ6kFxJsmMz2UWZ317Vrx5UKl?=
 =?koi8-r?Q?MsSYZ2nqRui+Jo+h551bLL2djJNVNbdlbDo22yFAtLmW2JCCtMdJxpmKBSZp6w?=
 =?koi8-r?Q?37JPZeE1TY+Eui1Z69MgOdSD2rKifZjOlEq8sHfcpsZ5NJEyWVfbt+2W70nA2h?=
 =?koi8-r?Q?7biUuB46D6GN2/mrohkbUSM8Q7w9aZPSRRtdQSVkQX4dUueNAiaGWDmeO5x2cl?=
 =?koi8-r?Q?1L3HckXpCt3NY7E/dfjz7edrrCW5igRmKOas05ODkCwJ2uWAazqUMwMaGSc52S?=
 =?koi8-r?Q?gGgqIVoRjSLyLV11gbLUVM0eeT3qoQp1WVFpEUUwktOEuEr8uF?=
Content-Type: multipart/alternative;
 boundary="_000_PAWP190MB2160B45C3304F810ED0172918B6CAPAWP190MB2160EURP_"
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: gsq4USFXnIG8l3b31c5+TCEwyuADLhzDLcxlMhwoHJLyQ8rL/Ukhob7kQXpIGgTYt2g9Pt/bd6ZcS8+NcX9F2sK9AiZE9CXxBqLe9UeCSOjGWnMJan2pleTbvQX8cgbG65KwW3rKHoDwT5Q0kPZtiJUApeZRFzA9s+oqrXydznTxj6Oe9Peuv2vXWHU2FPbQ3ozbR+X1TiUnAmXJApuPOcaUZbb7uJ8wK+498O0E3ZJjN71kDPlB/t+hXZwuvBq5BHd/tIsjUKRQQwnIiVDeNDBUQJlW+AyjvDFI8J4hYCK8+TdzKkHs+nzQzEDCFsbrgkbwvufuc0LqQu/TmUt+UOHRbOEq8N/b3RY/ec56bXjjFweOthWJK487eDoByQ2lQkEBrl/zWY7ZuqkUzqO8Xh638epuciGt/4Qj/TD9P2cprYjb6yZo1miUrVafGxwPdXdWNUj3ogOTiCJunHq5HGUrk3mYwGTl/dci7ZKcPbf4KBmyxcihuO9hY4yNTrOcDjNEajJQ5oQl3vNsNfjn7lga5jzpwj/h0t9VqVaIPcTWSoj0XdRdwCJnTOEAMXcGMJxn9G2rLzTgMETJhduAoYsVkq3FnTqAk5FLiBivRtyPrvyHvRKnUz7h33y8BSAAvY4Mvl32tJdEFiypGFwLfQ==
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAWP190MB2160.EURP190.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 008023cd-d946-4846-2562-08dda34246bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2025 08:32:00.6194 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E/pAtQ4QJq0n4fTWRtYP4/2gj9mtyFYDTALo+CP+5cZxPGgiilH/t61O73+WMcdDeg2dgD9w0pUox7hig6dk7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXP190MB2232
X-BESS-ID: 1749025925-302396-7822-5687-1
X-BESS-VER: 2019.1_20250527.1501
X-BESS-Apparent-Source-IP: 40.107.22.137
X-BESS-Parts: H4sIAAAAAAACAzXLuwrDMAyF4XfRnEGWJTvKq5QO8kVkCRnqoVDy7vWQLIefA9
 /rB/07YIMxd4HzAxtnirP2eZK7FyPvrllTwkStmSZhk8o1NriWx+/juL0Gwdtj6EUxrO
 zOEk0wF6xKLa5FmazC9f4D27ORJ4EAAAA=
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.265086 [from 
 cloudscan21-166.eu-central-1b.ess.aws.cudaops.com]
 Rule breakdown below
 pts rule name              description
 ---- ---------------------- --------------------------------
 0.00 HTML_MESSAGE           BODY: HTML included in message 
 0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS113687 scores of
 KILL_LEVEL=7.0 tests=HTML_MESSAGE, BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
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

--_000_PAWP190MB2160B45C3304F810ED0172918B6CAPAWP190MB2160EURP_
Content-Type: text/plain; charset="koi8-r"
Content-Transfer-Encoding: quoted-printable

Hello, Maxime

Thank you for your review.
If I understand correctly, you propose modifying the VHOST_USER_ASSERT_LOCK=
() macro so that a VHOST_USER_SET_MEM_TABLE request does not trigger an ass=
ertion.
However, I believe such modification would not be appropriate, as it would =
revert the logic introduced in commit 5e8fcc60b59d ("vhost: enhance virtque=
ue access lock asserts"). With this approach, we would be performing memory=
 hotplug without queue locking, which could lead to unintended consequences=
.
Regarding VDPA device regression. We faced with this issue when we request =
the number of lcores that the default amount of memory on the socket cannot=
 handle it.
So, regression occurred during the startup part, during device configuratio=
n when it creates pkt mbuf pool.

Let me know your thoughts regarding this.

________________________________
=EF=D4: Maxime Coquelin <maxime.coquelin@redhat.com>
=EF=D4=D0=D2=C1=D7=CC=C5=CE=CF: 3 =C9=C0=CE=D1 2025 =C7. 15:30
=EB=CF=CD=D5: Danylo Vodopianov <dvo-plv@napatech.com>; thomas@monjalon.net=
 <thomas@monjalon.net>; aman.deep.singh@intel.com <aman.deep.singh@intel.co=
m>; yuying.zhang@intel.com <yuying.zhang@intel.com>; orika@nvidia.com <orik=
a@nvidia.com>; mcoqueli@redhat.com <mcoqueli@redhat.com>; Christian Koue Mu=
f <ckm@napatech.com>; matan@mellanox.com <matan@mellanox.com>; david.marcha=
nd@redhat.com <david.marchand@redhat.com>; Mykola Kostenok <mko-plv@napatec=
h.com>; Serhii Iliushyk <sil-plv@napatech.com>
=EB=CF=D0=C9=D1: stephen@networkplumber.org <stephen@networkplumber.org>; d=
ev@dpdk.org <dev@dpdk.org>; Chenbo Xia <chenbox@nvidia.com>
=F4=C5=CD=C1: Re: [PATCH v4 1/1] vhost: handle virtqueue locking for memory=
 hotplug

Hello Danylo,

On 6/2/25 10:50 AM, Danylo Vodopianov wrote:
> For vDPA devices, virtqueues are not locked once the device has been
> configured. In the
> commit 5e8fcc60b59d ("vhost: enhance virtqueue access lock asserts"),
> the asserts were enhanced to trigger rte_panic functionality, preventing
> access to virtqueues without locking. However, this change introduced
> an issue where the memory hotplug mechanism, added in the
> commit 127f9c6f7b78 ("vhost: handle memory hotplug with vDPA devices"),
> no longer works. Since it expects for all queues are locked.
>
> During the initialization of a vDPA device, the driver sets the
> VIRTIO_DEV_VDPA_CONFIGURED flag, which prevents the
> vhost_user_lock_all_queue_pairs function from locking the
> virtqueues. This leads to the error: the VIRTIO_DEV_VDPA_CONFIGURED
> flag allows the use of the hotplug mechanism, but it fails
> because the virtqueues are not locked, while it expects to be locked
> for VHOST_USER_SET_MEM_TABLE in the table VHOST_MESSAGE_HANDLERS.
>
> This patch addresses the issue by enhancing the conditional statement
> to include a new condition. Specifically, when the device receives the
> VHOST_USER_SET_MEM_TABLE request, the virtqueues are locked to update
> the basic configurations and hotplug the guest memory.
>
> This fix does not impact access lock when vDPA driver is configured
> for other unnecessary message handlers.
>
> Manual memory configuring with "--socket-mem" option allows to avoid
> hotplug mechanism using.

s/using/use/

It needs a fixes tag, and stable@dpdk.org should be cc'ed, so that it
gets backported to LTS branches.

>
> Signed-off-by: Danylo Vodopianov <dvo-plv@napatech.com>
> ---
>   lib/vhost/vhost_user.c | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/lib/vhost/vhost_user.c b/lib/vhost/vhost_user.c
> index ec950acf97..16d03e1033 100644
> --- a/lib/vhost/vhost_user.c
> +++ b/lib/vhost/vhost_user.c
> @@ -3178,7 +3178,13 @@ vhost_user_msg_handler(int vid, int fd)
>         * would cause a dead lock.
>         */
>        if (msg_handler !=3D NULL && msg_handler->lock_all_qps) {
> -             if (!(dev->flags & VIRTIO_DEV_VDPA_CONFIGURED)) {
> +             /* Lock all queue pairs if the device is not configured for=
 vDPA,
> +              * or if it is configured for vDPA but the request is VHOST=
_USER_SET_MEM_TABLE.
> +              * This ensures proper queue locking for memory table updat=
es and guest
> +              * memory hotplug.
> +              */
> +             if (!(dev->flags & VIRTIO_DEV_VDPA_CONFIGURED) ||
> +                     request =3D=3D VHOST_USER_SET_MEM_TABLE) {

It looks like a workaround, and I'm afraid it could cause regression
with some vDPA devices, or that it would not be enough and we would have
to add other requests as exception.


Wouldn't it better to modify VHOST_USER_ASSERT_LOCK() so that it takes
into account the VIRTIO_DEV_VDPA_CONFIGURED flag?

Thanks,
Maxime

>                        vhost_user_lock_all_queue_pairs(dev);
>                        unlock_required =3D 1;
>                }


--_000_PAWP190MB2160B45C3304F810ED0172918B6CAPAWP190MB2160EURP_
Content-Type: text/html; charset="koi8-r"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dkoi8-r">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Hello, Maxime</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Thank you for your review.</div>
<div class=3D"elementToProof" style=3D"text-align: left; text-indent: 0px; =
margin-top: 1em; margin-bottom: 1em; font-family: Aptos, Aptos_EmbeddedFont=
, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; col=
or: rgb(0, 0, 0);">
If I understand correctly, you propose modifying the <code>VHOST_USER_ASSER=
T_LOCK()</code>&nbsp;macro so that a
<code>VHOST_USER_SET_MEM_TABLE</code>&nbsp;request does not trigger an asse=
rtion.</div>
<div class=3D"elementToProof" style=3D"text-align: left; text-indent: 0px; =
margin-top: 1em; margin-bottom: 1em; font-family: Aptos, Aptos_EmbeddedFont=
, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; col=
or: rgb(0, 0, 0);">
However, I believe such modification would not be appropriate, as it would =
revert the logic introduced in commit
<code>5e8fcc60b59d</code>&nbsp;(&quot;vhost: enhance virtqueue access lock =
asserts&quot;). With this approach, we would be performing memory hotplug w=
ithout queue locking, which could lead to unintended consequences.</div>
<div class=3D"elementToProof" style=3D"text-align: left; text-indent: 0px; =
margin-top: 1em; margin-bottom: 1em; font-family: Aptos, Aptos_EmbeddedFont=
, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; col=
or: rgb(0, 0, 0);">
Regarding VDPA device regression. We faced with this issue when we request =
the number of lcores that the default amount of memory on the socket cannot=
 handle it.</div>
<div class=3D"elementToProof" style=3D"text-align: left; text-indent: 0px; =
margin-top: 1em; margin-bottom: 1em; font-family: Aptos, Aptos_EmbeddedFont=
, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; col=
or: rgb(0, 0, 0);">
So, regression occurred during the startup part, during device configuratio=
n when it creates pkt mbuf pool.&nbsp;</div>
<div class=3D"elementToProof" style=3D"text-align: left; text-indent: 0px; =
margin-top: 1em; margin-bottom: 1em; font-family: Aptos, Aptos_EmbeddedFont=
, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; col=
or: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"text-align: left; text-indent: 0px; =
margin-top: 1em; margin-bottom: 1em; font-family: Aptos, Aptos_EmbeddedFont=
, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; col=
or: rgb(0, 0, 0);">
Let me know your thoughts regarding this.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>=EF=D4:</b> Maxime Coquelin &lt=
;maxime.coquelin@redhat.com&gt;<br>
<b>=EF=D4=D0=D2=C1=D7=CC=C5=CE=CF:</b> 3 =C9=C0=CE=D1 2025 =C7. 15:30<br>
<b>=EB=CF=CD=D5:</b> Danylo Vodopianov &lt;dvo-plv@napatech.com&gt;; thomas=
@monjalon.net &lt;thomas@monjalon.net&gt;; aman.deep.singh@intel.com &lt;am=
an.deep.singh@intel.com&gt;; yuying.zhang@intel.com &lt;yuying.zhang@intel.=
com&gt;; orika@nvidia.com &lt;orika@nvidia.com&gt;; mcoqueli@redhat.com
 &lt;mcoqueli@redhat.com&gt;; Christian Koue Muf &lt;ckm@napatech.com&gt;; =
matan@mellanox.com &lt;matan@mellanox.com&gt;; david.marchand@redhat.com &l=
t;david.marchand@redhat.com&gt;; Mykola Kostenok &lt;mko-plv@napatech.com&g=
t;; Serhii Iliushyk &lt;sil-plv@napatech.com&gt;<br>
<b>=EB=CF=D0=C9=D1:</b> stephen@networkplumber.org &lt;stephen@networkplumb=
er.org&gt;; dev@dpdk.org &lt;dev@dpdk.org&gt;; Chenbo Xia &lt;chenbox@nvidi=
a.com&gt;<br>
<b>=F4=C5=CD=C1:</b> Re: [PATCH v4 1/1] vhost: handle virtqueue locking for=
 memory hotplug</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Hello Danylo,<br>
<br>
On 6/2/25 10:50 AM, Danylo Vodopianov wrote:<br>
&gt; For vDPA devices, virtqueues are not locked once the device has been<b=
r>
&gt; configured. In the<br>
&gt; commit 5e8fcc60b59d (&quot;vhost: enhance virtqueue access lock assert=
s&quot;),<br>
&gt; the asserts were enhanced to trigger rte_panic functionality, preventi=
ng<br>
&gt; access to virtqueues without locking. However, this change introduced<=
br>
&gt; an issue where the memory hotplug mechanism, added in the<br>
&gt; commit 127f9c6f7b78 (&quot;vhost: handle memory hotplug with vDPA devi=
ces&quot;),<br>
&gt; no longer works. Since it expects for all queues are locked.<br>
&gt; <br>
&gt; During the initialization of a vDPA device, the driver sets the<br>
&gt; VIRTIO_DEV_VDPA_CONFIGURED flag, which prevents the<br>
&gt; vhost_user_lock_all_queue_pairs function from locking the<br>
&gt; virtqueues. This leads to the error: the VIRTIO_DEV_VDPA_CONFIGURED<br=
>
&gt; flag allows the use of the hotplug mechanism, but it fails<br>
&gt; because the virtqueues are not locked, while it expects to be locked<b=
r>
&gt; for VHOST_USER_SET_MEM_TABLE in the table VHOST_MESSAGE_HANDLERS.<br>
&gt; <br>
&gt; This patch addresses the issue by enhancing the conditional statement<=
br>
&gt; to include a new condition. Specifically, when the device receives the=
<br>
&gt; VHOST_USER_SET_MEM_TABLE request, the virtqueues are locked to update<=
br>
&gt; the basic configurations and hotplug the guest memory.<br>
&gt; <br>
&gt; This fix does not impact access lock when vDPA driver is configured<br=
>
&gt; for other unnecessary message handlers.<br>
&gt; <br>
&gt; Manual memory configuring with &quot;--socket-mem&quot; option allows =
to avoid<br>
&gt; hotplug mechanism using.<br>
<br>
s/using/use/<br>
<br>
It needs a fixes tag, and stable@dpdk.org should be cc'ed, so that it<br>
gets backported to LTS branches.<br>
<br>
&gt; <br>
&gt; Signed-off-by: Danylo Vodopianov &lt;dvo-plv@napatech.com&gt;<br>
&gt; ---<br>
&gt;&nbsp;&nbsp; lib/vhost/vhost_user.c | 8 +++++++-<br>
&gt;&nbsp;&nbsp; 1 file changed, 7 insertions(+), 1 deletion(-)<br>
&gt; <br>
&gt; diff --git a/lib/vhost/vhost_user.c b/lib/vhost/vhost_user.c<br>
&gt; index ec950acf97..16d03e1033 100644<br>
&gt; --- a/lib/vhost/vhost_user.c<br>
&gt; +++ b/lib/vhost/vhost_user.c<br>
&gt; @@ -3178,7 +3178,13 @@ vhost_user_msg_handler(int vid, int fd)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * would cause a dead l=
ock.<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (msg_handler !=3D NULL &a=
mp;&amp; msg_handler-&gt;lock_all_qps) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (!(dev-&gt;flags &amp; VIRTIO_DEV_VDPA_CONFIGURED)) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; /* Lock all queue pairs if the device is not configured for vDPA,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; * or if it is configured for vDPA but the request is VHOST_USER_S=
ET_MEM_TABLE.<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; * This ensures proper queue locking for memory table updates and =
guest<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; * memory hotplug.<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (!(dev-&gt;flags &amp; VIRTIO_DEV_VDPA_CONFIGURED) ||<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; request =3D=3D VHOST_US=
ER_SET_MEM_TABLE) {<br>
<br>
It looks like a workaround, and I'm afraid it could cause regression<br>
with some vDPA devices, or that it would not be enough and we would have <b=
r>
to add other requests as exception.<br>
<br>
<br>
Wouldn't it better to modify VHOST_USER_ASSERT_LOCK() so that it takes<br>
into account the VIRTIO_DEV_VDPA_CONFIGURED flag?<br>
<br>
Thanks,<br>
Maxime<br>
<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vhost_u=
ser_lock_all_queue_pairs(dev);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unlock_=
required =3D 1;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; }<br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_PAWP190MB2160B45C3304F810ED0172918B6CAPAWP190MB2160EURP_--
