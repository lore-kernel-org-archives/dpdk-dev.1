Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D43BC02198
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Feb 2025 09:17:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ED505410FB;
	Wed, 12 Feb 2025 10:17:52 +0100 (CET)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2080.outbound.protection.outlook.com [40.107.101.80])
 by mails.dpdk.org (Postfix) with ESMTP id F2F6240269;
 Wed, 12 Feb 2025 10:17:50 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Uu4boFuHe/kCszjsq7p4T4kaeaEW2HkOQ8xrx8BIur6bI+vq2K/DSGRZgu4ecQGgB/lGuRbGk1kypd0bLjT4HwOEzjbS0lo6ZXLPHdOYsFaTd0GY8hF294USae7qMfOJlhcBh4j/sl1Euxv2faoZoY4sKOc6KbdfTIc4w25V0S3+0tfXRS7qj4rUxDG7UISOk5rQ/sE40o/NqHIfyetgEYk0nUygVI1TrUGkER9TJZCCsnh/thMRlsHYOEhG74ez19Mi+FNBwfMGZ6cVrelle3KT9FK8029qH17/Y97si+MO5vhpFk4qeDJ+ownhra/t42OxPZEF4J/MR5SAvgvDJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1gziEk/YGy99mpxxJuy17zvSEim14dDR4+jmcKQH984=;
 b=FlHa5m6uHSdGSKken3XNMsX72Wg/OYGjEqk6u7dBDn+RJyhc6cspvNzgR9WQVSNJTHSTb1NQq6yzujuyZVbekO0oKpycZb5ve28GPvmjlD0IYZceC5KQ5aSOR0LfctFFz1PsG1H4dUni4925BY07UYCbOTEkoKRyQqlLT0uOXAeE4eLtl+PYQumF8OlO3UNwqCGnuaY4Rxc716Q0gryurmhlD9vrkMgZJvOv3VKXAxvTyb/pqYTOJFydoKjGdIXUtd3ZZCqRFRj67Cg1MeqWLvbEv535BBvAsO4VoJz1YJML8MQDG7sxgexseaD75IwDiHuJkg2G/mUwlD/XCpzreA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1gziEk/YGy99mpxxJuy17zvSEim14dDR4+jmcKQH984=;
 b=w5xLYnDXiwcjAMjauD8HVrgTpss2o1jT0EekHC5O3CFXkPLAHUWIaVVJIW/5vmhmiwMA3CA2DBYpsTalU5jBwFZa6hhvvl5VD2H6vakjK00gu1zna/XsJLO+Ln0kaPIL2Z/vzY6YA/AYJQLFOYS9993F3IHVWeVRX3pVgOr9ITM=
Received: from DM4PR12MB5104.namprd12.prod.outlook.com (2603:10b6:5:393::24)
 by CY8PR12MB7755.namprd12.prod.outlook.com (2603:10b6:930:87::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.19; Wed, 12 Feb
 2025 09:17:47 +0000
Received: from DM4PR12MB5104.namprd12.prod.outlook.com
 ([fe80::cca:53e:1dee:e92e]) by DM4PR12MB5104.namprd12.prod.outlook.com
 ([fe80::cca:53e:1dee:e92e%6]) with mapi id 15.20.8422.015; Wed, 12 Feb 2025
 09:17:46 +0000
From: "Ande, Venkat Kumar" <VenkatKumar.Ande@amd.com>
To: "Tummala, Sivaprasad" <Sivaprasad.Tummala@amd.com>, "david.hunt@intel.com"
 <david.hunt@intel.com>, "anatoly.burakov@intel.com"
 <anatoly.burakov@intel.com>, "jerinj@marvell.com" <jerinj@marvell.com>,
 "radu.nicolau@intel.com" <radu.nicolau@intel.com>, "gakhil@marvell.com"
 <gakhil@marvell.com>, "cristian.dumitrescu@intel.com"
 <cristian.dumitrescu@intel.com>, "Yigit, Ferruh" <Ferruh.Yigit@amd.com>,
 "konstantin.ananyev@huawei.com" <konstantin.ananyev@huawei.com>,
 "mb@smartsharesystems.com" <mb@smartsharesystems.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "haijie1@huawei.com" <haijie1@huawei.com>, 
 "stable@dpdk.org" <stable@dpdk.org>
Subject: RE: [PATCH] examples/l3fwd: adjust Tx burst size based on Rx burst
Thread-Topic: [PATCH] examples/l3fwd: adjust Tx burst size based on Rx burst
Thread-Index: AQHbfQo+jqmahdRycU+ZXlog2wOPSLNDYtUQ
Date: Wed, 12 Feb 2025 09:17:46 +0000
Message-ID: <DM4PR12MB5104BFD4E30B1543F5A064B49EFC2@DM4PR12MB5104.namprd12.prod.outlook.com>
References: <20250212045416.2393001-1-sivaprasad.tummala@amd.com>
In-Reply-To: <20250212045416.2393001-1-sivaprasad.tummala@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=b9fa63b6-86ac-40f9-9bf7-0459a7e068a2;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-02-12T09:14:02Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5104:EE_|CY8PR12MB7755:EE_
x-ms-office365-filtering-correlation-id: 221ef2cf-fff2-4827-6898-08dd4b461d26
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|38070700018|7053199007|921020; 
x-microsoft-antispam-message-info: =?us-ascii?Q?jlxJ2/clacOmh7ze7qWdJDEUNRDhYZbsz1LdCIrZdTsyLZvLkGonftk8Unbs?=
 =?us-ascii?Q?H/vW+FQ4Ex1bcjYv2ZUsF7Lw5OGrQVTDc1c4cmE+CBQwu8vPe7a9BZJWZCKT?=
 =?us-ascii?Q?a8FqBU0It1yuSWHOiwhdACeahuFLCxPgzfs1WaOl4zHS1VOW00q5Q8CE83LQ?=
 =?us-ascii?Q?1KhiS9Iezj7gqu5suhRaMuNhIYoH2cpzFm8cLffAkIVhxxg6LBpfqOhLEBEy?=
 =?us-ascii?Q?kTavFX+VCmkDl56ECOmF9MHX/DaTMEJK784UXruD7X+PDiHzaVyuiq7H5yJ0?=
 =?us-ascii?Q?Mqh+EqCEV3lupSso9ZtfOEo2MkcCS7BsHtcETi9ZFI9ctN2JvTlzADBYwnyF?=
 =?us-ascii?Q?XCDHkEI3TUVNA3AcZCXrMybjlr5xpl/b0dhMS28Cdg3b19g5K2ZZuBDLKMwP?=
 =?us-ascii?Q?AWt/Vksiu5J1tYMiMtaoCst4aV0UjL4Mcnofp9AUjX7MNU4BZSw4Ewq9/lho?=
 =?us-ascii?Q?NaPhK2vttmht6pG2dFzAk6Dmo8gIerTWYaLlk69cJZdHqlcrgGnB2ePZBQcb?=
 =?us-ascii?Q?rDfa5/hetZuKVxAlwbFifVwhlQqdiL8FR0AiS/Nxm4dftp7Mxu0Z3IS/gXkf?=
 =?us-ascii?Q?26K294QuQ0xba/HPjRODMOXyI80VW0IKXv9OkTC8+11ozM87mECUpRndMmYg?=
 =?us-ascii?Q?Xc9mkNa9jvIbeuD2VKDQa+M6kyiSgLxUk3WqTwBWG103L9MYgpY65PGOv9Gn?=
 =?us-ascii?Q?F7AyG3P0mARdRCBSVPFizh2+/KaIYyltiCEq67yheazazMqlWktK1wCCsWTF?=
 =?us-ascii?Q?0JsEjSXavzvMUoVThb0eDsAa2i5LntAu7YbbjWMbDJhPVMzsT2aP6Q/WjIAf?=
 =?us-ascii?Q?KKkXy3iWuo0I29ofWc4v8HuT1BI26X9XMExxELuQdQUB7ACmXInxJB1d28yF?=
 =?us-ascii?Q?xaVJYYEzQUcqASOihwNi4dsfb+5cpx88xFvRhdugriaKsMkXoTnsti8x3S+A?=
 =?us-ascii?Q?Vz7KCl0qNHtRuyIL7Dd5cwqChB5uRGYbCZpZXGlWy76pi4pl8TUlvTNsgIYw?=
 =?us-ascii?Q?9VR8yvAPyTkh9KNDfxNjZQtDXSpXdlj1C0NrAmqFDez76hIMsypmNZ9Unxkc?=
 =?us-ascii?Q?nad0APx7MEm2oSLjJEoj+Qdte4c3G+XX6yez/pOux+IuX6NXDGsywjJRe4El?=
 =?us-ascii?Q?cRo2WqKdlH173tX2f0VpwWkCnoYh8l+BdYOLqC2Y1Wjm0xADPm7dj8ETfiuB?=
 =?us-ascii?Q?IKbqz7PA+isDw18LmInZIwN5vB8tmZHmAwyaYl0eeJJfGr5dzbzu3z8wk7Ji?=
 =?us-ascii?Q?djLQaaFzq9MsH/6/0jslLjqU96R/U5CZBZBMqUJ7jsGLcN7ZFbJmAoMiqhku?=
 =?us-ascii?Q?ajvxy85XMqrhjpdUQrymGxzWT3O5QErpqtlkj/x8p0tWMZGjKEpgWcdEJnyw?=
 =?us-ascii?Q?R+N90zJllmKMj3vy88A2wMq4FOzPhMDdtxr3o95+7rxDCey/xw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5104.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018)(7053199007)(921020);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Jhy56nqrEzMFBE/P7twvkFw5nj+MrraAFBYj1gaxrPiN/epgXamvwySPYahG?=
 =?us-ascii?Q?5B6eRSRhgmfD3T7rmrbUw+J0kyJGmFH+CB3xZuTyWJLuivE6SkxDxlpeCOpx?=
 =?us-ascii?Q?b4PCbfRePOvJBRLUeN+3Wt1YjvfqPv1LEauHBNXcms99CXOfIxdGitPGIs0v?=
 =?us-ascii?Q?f5HVrdur1XxvqpGH/O+cfD7DII05aOdzLsFDvyHJXL1oGdQ0d7RomO9Amhor?=
 =?us-ascii?Q?87CS/CnTFfGiIuXHN7RIdv7datM0MB94w/sBAJj2l3GDxjId43pNElFv8VYh?=
 =?us-ascii?Q?/l+a9ky8RxcCYBUcLcGIcUf48xulB9ppQliuo2H9JnOjf7PYE6qTOb6Phf2b?=
 =?us-ascii?Q?PNFFXBieYNDqQ9ZbXMbeP/tSjhljWshnIzkgk3b2IPftHVG3yvU4gmEreuBx?=
 =?us-ascii?Q?QCOIkQERjn8bswK1AOCsTXZPm2BLxkJCAd1XcmmFpvR4x1VJfQwC+qizHLvF?=
 =?us-ascii?Q?nIPx1mV3KXljYNlR84IccDXjw58Pac/DSQpNqxWkrRZ0nEaqcVV0ZCAxN3BI?=
 =?us-ascii?Q?YlUFJhKAuIZC/zxLuTFwmomzLs8bDoW4xCRjKVFbLXvlD9VYJr6jNfi2yl4P?=
 =?us-ascii?Q?56DJ4sZWVi6MPMT48HUMOenZT2PAeN2UnbxyWRoR1YqhbWuwaSRwVTKqkPej?=
 =?us-ascii?Q?Gg0tUbsEYirlE89Jy0RNEJgX9857tBli1vOJXJQFb9Y50XSc8edqO9jjQt+V?=
 =?us-ascii?Q?jnOXpQyV9+VTCiCTLHElTHobhU8iliqRihjAZ8PipqDirTv340gdMU9883TN?=
 =?us-ascii?Q?TJrEPmhzkYNGFLkcvm80djAc04mRUBl1EYLKi4llXkxJaev/fSkM/ndI6x7x?=
 =?us-ascii?Q?e+10+7mtshic14a0J97v5Q/b+IeupWgMuqch2eAAzR/KbmWZLZvetPzdK4KW?=
 =?us-ascii?Q?PXc8O27P34Vn4cniWIjYgT1JeI60awQK4mOfSJbyMMrehXPsOIsqhu+P2fit?=
 =?us-ascii?Q?KY5MD3Cmv83KDBi1/tCKrttMdiiXCWFbKWrbI1s5g0FoOqHIMvFHIjDD/nlN?=
 =?us-ascii?Q?ijTXcFIzG3/Asfnr/BOq/FaNB2mBdf1PNrC4qn9a71Vhs7nA1rRxKPJ4Yc/s?=
 =?us-ascii?Q?j5nbsaaYxKB6lYES6nlru3QQtXAZdMYvgfC4Xs7w4YT5UP6E6WRvC2GYR06y?=
 =?us-ascii?Q?J0kJXKGU7uFAwhM636HwSM5VLmUGeJp0Rugu+lgC0nZDoXHYs8TD6GVG6kOg?=
 =?us-ascii?Q?nG0XjCLMcph/jkO+9+5NfUjHxsqIU+CPExavU9JxV33VwctrhNjGb1e7Ufre?=
 =?us-ascii?Q?N+ILuX3KXg1M/62iRPxHeFGgssC1i5rhRKxP3ejgQ4TBF568WZkZ037CG21i?=
 =?us-ascii?Q?HLS/3fi9FF8rWZJPxlDiAHlz0vhEiIoUPxns89iNr73+BvexZnjNOKFJowqz?=
 =?us-ascii?Q?ivgpeW9HICiwgLZ30uSRvz29DUy3Ixyey00qFcWNVzDc4gU2f+HlH1cp+M3U?=
 =?us-ascii?Q?+FFgotr78VmrpbH0J8u0AHSKpbdj+EkJ8/kFcl/fmHanRRfOcD9jBlBJppuE?=
 =?us-ascii?Q?llLkBIaHvJN4dWD6BtH3IMaSCkDBpHBNnfyYO3JlSXfK0dq0XQ8ejGtOZ8WO?=
 =?us-ascii?Q?0/ChffY7s0ohLn9czOI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5104.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 221ef2cf-fff2-4827-6898-08dd4b461d26
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2025 09:17:46.4726 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ph2lOekKpIvkR5nXCCBj2VXxVrwh+Xqou1XbB6MlyfpUzyBmIqkVT7Q/BFWWXcAsUPOY9VJ4rtwoeUD0LPhz5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7755
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

[AMD Official Use Only - AMD Internal Distribution Only]

-----Original Message-----
From: Sivaprasad Tummala <sivaprasad.tummala@amd.com>
Sent: Wednesday, February 12, 2025 10:24 AM
To: david.hunt@intel.com; anatoly.burakov@intel.com; jerinj@marvell.com; ra=
du.nicolau@intel.com; gakhil@marvell.com; cristian.dumitrescu@intel.com; Yi=
git, Ferruh <Ferruh.Yigit@amd.com>; konstantin.ananyev@huawei.com; mb@smart=
sharesystems.com
Cc: dev@dpdk.org; haijie1@huawei.com; stable@dpdk.org
Subject: [PATCH] examples/l3fwd: adjust Tx burst size based on Rx burst

Caution: This message originated from an External Source. Use proper cautio=
n when opening attachments, clicking links, or responding.


Previously, the TX burst size was fixed at 256, leading to performance degr=
adation in certain scenarios.

This patch introduces logic to set the TX burst size to match the configure=
d RX burst size (--burst option, default 32, max 512) for better efficiency=
.

Fixes: d5c4897ecfb2 ("examples/l3fwd: add option to set Rx burst size")
Cc: haijie1@huawei.com
Cc: stable@dpdk.org

Signed-off-by: Sivaprasad Tummala <sivaprasad.tummala@amd.com>
---
 examples/l3fwd/l3fwd.h        |  6 +++---
 examples/l3fwd/l3fwd_common.h | 11 +++++++----
 examples/l3fwd/main.c         |  2 ++
 3 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/examples/l3fwd/l3fwd.h b/examples/l3fwd/l3fwd.h index 0cce3406=
ee..9d7c73504b 100644
--- a/examples/l3fwd/l3fwd.h
+++ b/examples/l3fwd/l3fwd.h
@@ -35,7 +35,7 @@
 /*
  * Try to avoid TX buffering if we have at least MAX_TX_BURST packets to s=
end.
  */
-#define        MAX_TX_BURST      (MAX_PKT_BURST / 2)
+#define        MAX_TX_BURST      (DEFAULT_PKT_BURST / 2)

 #define NB_SOCKETS        8

@@ -152,8 +152,8 @@ send_single_packet(struct lcore_conf *qconf,
        len++;

        /* enough pkts to be sent */
-       if (unlikely(len =3D=3D MAX_PKT_BURST)) {
-               send_burst(qconf, MAX_PKT_BURST, port);
+       if (unlikely(len =3D=3D nb_pkt_per_burst)) {
+               send_burst(qconf, nb_pkt_per_burst, port);
                len =3D 0;
        }

diff --git a/examples/l3fwd/l3fwd_common.h b/examples/l3fwd/l3fwd_common.h =
index d94e5f1357..6cb7de5144 100644
--- a/examples/l3fwd/l3fwd_common.h
+++ b/examples/l3fwd/l3fwd_common.h
@@ -25,6 +25,9 @@
  */
 #define SENDM_PORT_OVERHEAD(x) (x)

+extern uint32_t nb_pkt_per_burst;
+extern uint32_t max_tx_burst;
+
 /*
  * From http://www.rfc-editor.org/rfc/rfc1812.txt section 5.2.2:
  * - The IP version number must be 4.
@@ -71,7 +74,7 @@ send_packetsx4(struct lcore_conf *qconf, uint16_t port, s=
truct rte_mbuf *m[],
         * If TX buffer for that queue is empty, and we have enough packets=
,
         * then send them straightway.
         */
-       if (num >=3D MAX_TX_BURST && len =3D=3D 0) {
+       if (num >=3D max_tx_burst && len =3D=3D 0) {
                n =3D rte_eth_tx_burst(port, qconf->tx_queue_id[port], m, n=
um);
                if (unlikely(n < num)) {
                        do {
@@ -86,7 +89,7 @@ send_packetsx4(struct lcore_conf *qconf, uint16_t port, s=
truct rte_mbuf *m[],
         */

        n =3D len + num;
-       n =3D (n > MAX_PKT_BURST) ? MAX_PKT_BURST - len : num;
+       n =3D (n > nb_pkt_per_burst) ? nb_pkt_per_burst - len : num;

        j =3D 0;
        switch (n % FWDSTEP) {
@@ -112,9 +115,9 @@ send_packetsx4(struct lcore_conf *qconf, uint16_t port,=
 struct rte_mbuf *m[],
        len +=3D n;

        /* enough pkts to be sent */
-       if (unlikely(len =3D=3D MAX_PKT_BURST)) {
+       if (unlikely(len =3D=3D nb_pkt_per_burst)) {

-               send_burst(qconf, MAX_PKT_BURST, port);
+               send_burst(qconf, nb_pkt_per_burst, port);

                /* copy rest of the packets into the TX buffer. */
                len =3D num - n;
diff --git a/examples/l3fwd/main.c b/examples/l3fwd/main.c index 994b7dd8e5=
..4cabd05be2 100644
--- a/examples/l3fwd/main.c
+++ b/examples/l3fwd/main.c
@@ -59,6 +59,7 @@ uint16_t nb_rxd =3D RX_DESC_DEFAULT;  uint16_t nb_txd =3D=
 TX_DESC_DEFAULT;  uint32_t nb_pkt_per_burst =3D DEFAULT_PKT_BURST;  uint32=
_t mb_mempool_cache_size =3D MEMPOOL_CACHE_SIZE;
+uint32_t max_tx_burst =3D MAX_TX_BURST;

 /**< Ports set in promiscuous mode off by default. */  static int promiscu=
ous_on; @@ -733,6 +734,7 @@ parse_pkt_burst(const char *optarg)
                return;
        }
        nb_pkt_per_burst =3D burst_size;
+       max_tx_burst =3D burst_size / 2;
        RTE_LOG(INFO, L3FWD, "Using PMD-provided burst value %d\n", burst_s=
ize);  }

--
2.34.1

Tested-by: Venkat Kumar Ande <VenkatKumar.Ande@amd.com>
