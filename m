Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5475C02198
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Feb 2025 09:46:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B854C410FB;
	Wed, 12 Feb 2025 10:46:34 +0100 (CET)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2063.outbound.protection.outlook.com [40.107.237.63])
 by mails.dpdk.org (Postfix) with ESMTP id 96D9140269;
 Wed, 12 Feb 2025 10:46:33 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WTemvbx0/CNvdbiIiG5lPqihLup4lQSF1A2BAYCM2/rGbLLHYwErIbH+SNsfYdphRupzNzmTXhUYNulJsJ4kvPxqdNIY7VG9eR7el1s1Rz7XzZ74oOZSV+q8GfLmum3rPsOIDa8PZkZ6lsgWv03ohf4BiJvL2wJXhtuYb2v1ZjyYerU9bnwuzRoWnR0EmmCQ7rCTE9yE7Hjq8mgOfNgOZj1pDFefrUdV4HKiwdSaHnK7HyRC+XbOGE+s4QewAdL4fpLtcoKRLYZLap2oJ+xibG/yURsC1etDgUBVBH5ZtC6JKOFB3Q1OdEnHIoNleIdgIpBah1lLO885toq3ey0Sug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=os+a6Zh6a6TM4539EApq9AGdXhHnuv3oz/5XJiiu74U=;
 b=RNANP0xiTrJfWlnclGfbOY40ppnggHX859+8BwxBWRyV8/FnF4mGfXqyX173AFHyNqxMkJDf0PEDdZy/euOmjGvb7egrMxsrKt4f4ATk6HO5o0HG4x4OVZ/qjXW9llJW/RBht4zr+Ia0On76VdysrG5HnML64GRVCa+EjaOe5JPfNBI5jITPEmYH2n6Imv1xMaQR6D3+ZPUHc0Ho7kpA0N4RfgjZv306ZsxpaKmRc7kOTGAx05N582HFbqJgPQBtw7NgTvAF+C+K0EQ9jwVFAxhq0cUWjaarDd9fiPO3T2AdpI/WTaXDBpf/hySvdIHXxC7buM4+rg4RoR/WWvh0/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=os+a6Zh6a6TM4539EApq9AGdXhHnuv3oz/5XJiiu74U=;
 b=bvDXjpdoPpYC0UBqyZhODyM6LfRX78iJT+Xqdcn8Db2D0nKJ7hZGpiugH+1VCCUUrEzuFK/Rq40zyAOq8IEreQUxUyXHES80Zctny+sfD3m2DfM3TeSYVl9DIbth0/gxRnuVdsfk1ITE8LYSlEjIREYjxk2Y3wUKfMsTT1StN/w=
Received: from DM4PR12MB5104.namprd12.prod.outlook.com (2603:10b6:5:393::24)
 by PH7PR12MB7234.namprd12.prod.outlook.com (2603:10b6:510:205::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Wed, 12 Feb
 2025 09:46:30 +0000
Received: from DM4PR12MB5104.namprd12.prod.outlook.com
 ([fe80::cca:53e:1dee:e92e]) by DM4PR12MB5104.namprd12.prod.outlook.com
 ([fe80::cca:53e:1dee:e92e%6]) with mapi id 15.20.8422.015; Wed, 12 Feb 2025
 09:46:30 +0000
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
Thread-Index: AQHbfQo+jqmahdRycU+ZXlog2wOPSLNDa98A
Date: Wed, 12 Feb 2025 09:46:30 +0000
Message-ID: <DM4PR12MB5104DB1957A1FCCD736F4A359EFC2@DM4PR12MB5104.namprd12.prod.outlook.com>
References: <20250212045416.2393001-1-sivaprasad.tummala@amd.com>
In-Reply-To: <20250212045416.2393001-1-sivaprasad.tummala@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=1a521f36-d7d8-46fa-a570-c92a410b0131;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-02-12T09:46:23Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5104:EE_|PH7PR12MB7234:EE_
x-ms-office365-filtering-correlation-id: 0bafdb54-805e-4bce-9bf3-08dd4b4a20cc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|1800799024|38070700018|921020|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?cM9+vsJI3/45L862wncv3CrZtoPKoO+MX/4nryvgPdopVjlQY7Y5kNxi9Di7?=
 =?us-ascii?Q?jc8EwAQgXFGf8J2VIxA/fPT9xMXjjR/wrLhQdxe+Scwgaeae/sNBNnzP+KJx?=
 =?us-ascii?Q?xsschegtgcb+Wgobsabo4MJT0bZtIKVeRxswPGyazYRmBXa5ehBQpQ9xc02f?=
 =?us-ascii?Q?vWeRhvdtL/Vs7jrdw956qXVhwdWZZ+CWT3yD6vmSeYrnDrDUFK54HjeqYli/?=
 =?us-ascii?Q?a7KP+q/0Wc7/3tY1xTLcBuAiRlSeQW7yQWZ/SiRI7X3E7OyUKA/Wde8GN5zO?=
 =?us-ascii?Q?cg2J5T4bXkRaypg+mCBxbUVjqM3nfiQrmH6+r0eEWA0gMlFWtKgPmZhdTH68?=
 =?us-ascii?Q?xeQyLEK+CBhYFVBCEDh0CueZYEGS14JA8XkCRqH81i6oeQMLSfChlvywyceS?=
 =?us-ascii?Q?oUN3nmQo58Ve9INs5DR82deSz6nlLdVImBnRrT0incXzuYXL15NAWZq613J1?=
 =?us-ascii?Q?mmk2thVQDb4HQXNG5SlKxFpOz86drnBEq35d3PJZduFtdezuxUoFkGAep4oU?=
 =?us-ascii?Q?kJoa0kQe3YpzbeeJu1Wqj0ePCO1uc+MQveaRx1eEcS/MtrJ/jQyepROzYhL2?=
 =?us-ascii?Q?LZMxkyHn4yzK6UvCDoy4PAJbwt2lSt2KjqzQY5Fx0Gt6Aim80lWDzojfC602?=
 =?us-ascii?Q?Lw/VgY9nL/DQNgcgO0uiJ/0iLlHbGSHlgliHBfz7aidtJ65k3O3NsA/ivYom?=
 =?us-ascii?Q?lD2ktPdZQUHPg/AXWDw28sv7nsSidXuDHk8l1A0zqs/rfIQK6bduhCq4uiOE?=
 =?us-ascii?Q?QmDeHjmxr5NCuA18ZiMYP09dtrjuerYIASMxYBx8mtOAPoZwx7V/13qwH+HI?=
 =?us-ascii?Q?sKSoLIj0ayfKcJdJ9RZEJA8p2RlJ6GcpoPA/Ovt9nT8Y2o+z3ECnCRHBxd2R?=
 =?us-ascii?Q?LLIHAu92K1+CUSu+te7lyEonRLWqkuEyKLhIQpQDQmujFcceNREChKRHPC+X?=
 =?us-ascii?Q?FIBhoV7ppp97ZnkfEsCRPPfsOg5Yjt+hJGbMVX8n1uWJVHGtO5qJPbp7TqkY?=
 =?us-ascii?Q?DB+TKl6dRAD+kcyNaJHzUz5Te3bOZ+hWW5+Jl3VDhNNpWYFBUMcaX7+EbYTt?=
 =?us-ascii?Q?W45RwNyawlhOE1DjHnDImo87bmNoSPS/QejK59VPikClJmnRGHXvQXCAg2um?=
 =?us-ascii?Q?Wn1X81tZR2npPaNRZFRw1JjMsmFs6W17AV0tdL19AILxd7zrv3mAo1o+WA6V?=
 =?us-ascii?Q?wn1iWq0+/6H9nlmTKt2NFLyhfNYmR+qOxSSMc9UJcH0zwnttCbaMq7Lc416G?=
 =?us-ascii?Q?oN7VrhJoxUdOy+AhbcvBXmRzEvywlvSRzZOBypc8tUX9yxG0h72sXNSKdIrv?=
 =?us-ascii?Q?SsOktNu3QyMDhpmHEQSpLPmr1KZypzMx4UKLHyNbCxLkLXHjicNduWwbyBy7?=
 =?us-ascii?Q?g6l4IyeXy+qwfrS/Bq+ffVFikZsgrfQEjrtxmAiBIJVvzdfYYg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5104.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018)(921020)(7053199007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?fdyBxRPE2zjnRvieDNLAdFnVw47QeQNe5KjjrtrId9YxloLKtvU3LVSn1G65?=
 =?us-ascii?Q?itoERg5qCfx2Ls2u4q7kow6CuZIdTQliGL5lriIReU5Lff9in1LZPqU34rD7?=
 =?us-ascii?Q?6j4DL51wv1jY/Ev+RN2vbHElPZXoOkLmLbf8IEALAyAPIChuo6yaco49gatu?=
 =?us-ascii?Q?77K4KsTOQ+EEeOf2JOjlGbnIq8JpGzh7BotGJ/WjScMwOWt7kv8oRLJH/jUH?=
 =?us-ascii?Q?w9NIrSbSdPYRk1kRIpd7gl8RTW3oj0lS4IqYEFLlUzgTqYvnRDwfoupFHpp3?=
 =?us-ascii?Q?1ZCIaDe+XrHf9Yp/6rbkwz6Fcc9u08ZqPIEpLoZyuYCyod/GDYV338zxhbNE?=
 =?us-ascii?Q?VBZbmhRe4czFX0ecW3Mf4uyitOCciIkxakADFbeKj58frR/WzN0v4yKUy57Y?=
 =?us-ascii?Q?Ulk3h3OiBe/VT14TmWMpLvb6BudzCrVMyv1eDAS09iEmVIIP2WZSBc4EDeTA?=
 =?us-ascii?Q?uR4CGR6n/sxDIf4NLfc0FTXu+S+OXwfDem1+NJ0nehts/thiOM9jH15P5IRR?=
 =?us-ascii?Q?BBGj1HDM74T4V/kkKhM0he0ABu/h6A00ZYd40VS+KqJBIY3NjB2tziyZa4o+?=
 =?us-ascii?Q?URrrbw9t5kGLApUQbF5inQqwf1PRTSmnlwbVCUzPWc+WSSwBk/+K62hoGCOo?=
 =?us-ascii?Q?sxxvA9MfE3hm4x2e4w9Y7mF3rR+4lwo//pIwVY1a0/L0xu9jBnBR7WRQBaGV?=
 =?us-ascii?Q?EHFXrThpMVv+nKPmLcUbsRzoGHToro7MI0HWd+JXhRdjB61ceXIB6AWGmVHk?=
 =?us-ascii?Q?SGZc49ATTpcayER2qZHRVUAXNoXRxsFM0gAQ6o5PqDaIn3CAtO06O2xSmty5?=
 =?us-ascii?Q?n6H6mhU3kXwU2vIo5DajPSyKROXv3pp8Kb+Fdh+sVXBrP8aL2DmMXSGT4AHG?=
 =?us-ascii?Q?xF/Bc9yiyrYop1I7SS7gYRWpR6zJI2HbMIQOx3DmIXRhGoK7+lpzBho1fTXf?=
 =?us-ascii?Q?y2qU2zvxgeJy4pPhMKCCFJ39G7MOb1o1G5/VKsumKOYM0x2+5lFy8vBtOK6q?=
 =?us-ascii?Q?gSIvtM3eae/GEc8eP3V5hArWyTSMhZpLCFbSwWV46uAEfskSswf3I1+aS9Uz?=
 =?us-ascii?Q?VJpcImpu4xi2oqrpmA1aI/GBGHaBOLWM/TBHJd3rbrIBRsw0h9R9K+ZiSb/0?=
 =?us-ascii?Q?cEC+36S/PXphiPGzhd/GUEisEfCKcu06m+G/OWDFJdr6FBtvWRIHuMEzEPDs?=
 =?us-ascii?Q?vMdP6+xuoPKzRQTiK1hxkPq5iPC5QK3Pljhb6IxJdAAyRuJQ34hBUC77dOb2?=
 =?us-ascii?Q?QieNs6tGC8JFtSRpxukuzmW5/KnLZ2o1pnzGTEVw8HcQcQfS1x+FekREeTSy?=
 =?us-ascii?Q?I0jTfHC3uaUSVYecn4ENycZKbB8ZPJNWiIatC3BFUOMxTIowUJ+XbtCCYkQ9?=
 =?us-ascii?Q?iVeVN3qel1ls4kwIM6ElrBTXQWA/EqPdglbvem9V5gxZ8QBwDWJzJOiMGVSu?=
 =?us-ascii?Q?DULwRfit3tJtoy5fXSoromDpbpBTMXOetqKv6V3hjtCwJu39/1gHZFJtA8+3?=
 =?us-ascii?Q?hBd6Ep0ueaw3bOW4ji8Sw7Jhd0guyr3h0ib0WYijw9/YGw4ahUruCzTg8RLC?=
 =?us-ascii?Q?TIAe+wh5nOByt5DuD20=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5104.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bafdb54-805e-4bce-9bf3-08dd4b4a20cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2025 09:46:30.6142 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TBAiT9z5InmQQaaoD8pkzPdG/2SG2wdKEN8AQIt+bDYHvtSheniPVYXf8msfb9mKQNcAmVBkJd6YEEDJTtNGxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7234
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

Tested-by: Venkat Kumar Ande <VenkatKumar.Ande@amd.com>

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

