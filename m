Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29796D116F5
	for <dpdk-dev@archiver.kernel.org>; Tue,  2 Dec 2025 07:37:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 43D8240268;
	Tue,  2 Dec 2025 08:37:23 +0100 (CET)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013058.outbound.protection.outlook.com
 [40.107.201.58]) by mails.dpdk.org (Postfix) with ESMTP id 0B912400D5
 for <dev@dpdk.org>; Tue,  2 Dec 2025 08:37:22 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lLa0G0TdnGNiV7LBqoHRFTuRRAa6IWU4fscKjEiKIJLBhQtHqUnyPMRxnzoZLvF38qGQdHyFGtx2YX8TzlGyJPju96IxxJacCrKJsJToZi0AvZoXsp7EgM+BVCY2tr0dFISXd5G4kFmsRa3VmPlyniu1Lbdgl+fcMnqORHs/+VtayUwybnJDaWVqUni1e6KuPzN31vY09vE3OwCulCcg5MsJN/+vJBjocf9c6oZOU1DQXAmlHE+1kENAf+49O8G6bkC8eKWQhgARYg9koieMXKfy7lkTbKw0g/QBIp3wBRUGwIebB2/j2AfRk5642GGIUV+psUcIthvjEjS018KC6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hg09ukpSvQngSugdmm9BYq7orPuiDmYnqLz5uGoYYtc=;
 b=dJ148eJt8eRMzzoNvJzD7Et9cJ15cJAlXlAQTOO5wpjlb3QbE/2cTK/uQ8YWs/hN0owQQbbODpZPQcvnjwKk5oFw90SXXeHXxNQY2vtxnwN5HrpNsaVNA0upu7PMGugNkoViF8I6o/dV0vcdI2735lhMBaUVfIEthqfu/kb1ov5K8L+OjJIhCcAetbXtd2zIiUrUOD6bjnBWj6Z+96r2eNNAAnlGVwQzL975nXY2qAvjkLjyzzzfu4ByV4sXpclJMGVP5oSlntQ3d9E4eI8yDvxZqkWjNFIqAAB9atuBeXQIL4DdFRaDHEEqW0X6Y/TJkvVPGniq8efjq/QI6RL+9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hg09ukpSvQngSugdmm9BYq7orPuiDmYnqLz5uGoYYtc=;
 b=jxR2BylRn/b2s9aknkRCmcZ6trybJyMMa4ZpgJAMUwCQdge1zbnyTQxrHkwcMoAyDhejkC+aL7AkSxNUBa5hMUSYQpVWzmyFLzeEjZ5iKk7oymPnACX57y4zBxbAOoPb7OE/JWwhQLx95KaGPRRoYbRJ4y8MDTswXI/4xqnqCsw=
Received: from DM4PR12MB5055.namprd12.prod.outlook.com (2603:10b6:5:39a::20)
 by SA0PR12MB4413.namprd12.prod.outlook.com (2603:10b6:806:9e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Tue, 2 Dec
 2025 07:37:19 +0000
Received: from DM4PR12MB5055.namprd12.prod.outlook.com
 ([fe80::2c56:65d9:9ce1:c415]) by DM4PR12MB5055.namprd12.prod.outlook.com
 ([fe80::2c56:65d9:9ce1:c415%4]) with mapi id 15.20.9366.012; Tue, 2 Dec 2025
 07:37:19 +0000
From: "Sebastian, Selwin" <Selwin.Sebastian@amd.com>
To: "Govindaiah, Vinay" <Vinay.Govindaiah@amd.com>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: "Govindaiah, Vinay" <Vinay.Govindaiah@amd.com>
Subject: Re: [PATCH] net/axgbe: add support for V4000 Kracken2e
Thread-Topic: [PATCH] net/axgbe: add support for V4000 Kracken2e
Thread-Index: AQHcY1r+wWBr/ogsRUCgj6aceKeesbUN9jhD
Date: Tue, 2 Dec 2025 07:37:19 +0000
Message-ID: <DM4PR12MB505543F20F4534C5A82A029E8DD8A@DM4PR12MB5055.namprd12.prod.outlook.com>
References: <20251202071152.317942-1-vigovind@amd.com>
In-Reply-To: <20251202071152.317942-1-vigovind@amd.com>
Accept-Language: en-US
Content-Language: en-IN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-12-02T07:37:06.5216087Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
x-ms-reactions: allow
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5055:EE_|SA0PR12MB4413:EE_
x-ms-office365-filtering-correlation-id: 4d41dbec-6ec7-4545-ca84-08de31759fef
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|10070799003|376014|1800799024|38070700021|8096899003|7053199007;
x-microsoft-antispam-message-info: =?us-ascii?Q?HoG5MX5g4kOAQnttgYo2kVkRQfv6U00aT/GtvES4wa3ie5DVx+QKP0daSRuV?=
 =?us-ascii?Q?FzRWWK7eMOR4uQKWZ9n1NggcMBgx9V2+5T4+0V7hp25en/0dHwpwNGzWqZJg?=
 =?us-ascii?Q?7tgXGdjoieh4WvTBZeE2A70nGtIRhblSk8a01jLrv3/c0jzJWiPSsZ//FnF+?=
 =?us-ascii?Q?LA+zbS4Xup28BbdLQdDMfOz7heAdHlxdc+JCNHJ9kw+EsrHrtlfyOUol4tFW?=
 =?us-ascii?Q?BqFaikR22w5ARJTpT1KvIFzjHyLkuJKA9dz2zW9Ksml9dzO01wQV0I9IfUJN?=
 =?us-ascii?Q?rxBcoAjO/+YNVPTdK3nfWLx/R0lCY3GMXv62JgPjiLNr5c3dVjQ/7KYYZUrU?=
 =?us-ascii?Q?UcriQA5i1W5cmajFlKRqDfZ+Tip1Y86PJjrRjfPjeFIRP3DumuwQjUam9FSF?=
 =?us-ascii?Q?8qveH86mTVrWSfKm/1U3W6fOSqmkK6iaJG+Ld0cwYnQJqvxXcKh5RkaqZ/7N?=
 =?us-ascii?Q?UoABtqR60JQDTu3yXIeIGm6JysEkE4yy3ItlVy7KPti3DQkuy8dYLXzpT6ZN?=
 =?us-ascii?Q?q+y1uVhM726HxgLaG+DhSeRgqPu2H9oCqjcJENUHFIthdGE9T55f+4rYzwpf?=
 =?us-ascii?Q?2GgovV4wt+H1Y+Yk2cZnx77Zbun1/lxMa0EcfLL9Acbed57/4PPhEGRwiSJq?=
 =?us-ascii?Q?OoKFWLht7yLj9R0pEXkpyVVQbchanmTI278V3jQG0r81fYPN3sH7rSk0AT52?=
 =?us-ascii?Q?Gq5UcFnh1LG5n4B9+uKQfH/YYs7IB04ZEBAupKgl6vi0QIdCHoBLPnY2QwLJ?=
 =?us-ascii?Q?siKjWc4cnJiVFTAeLfDKRXuZLejGoVpjCyvpz6jI7tg+xdcZZURExOnkt5T/?=
 =?us-ascii?Q?TMnyrrKMNU5J3OVtlYWvGBGTWYlM1JSOgSK8YmzkLMRjSFJhOxmidvjmHDM0?=
 =?us-ascii?Q?KKKXqNwTHlFc0jyaE6vhYMW0TbKp2QqYQSyc6AJ9+WlkKs6MLnXtsHfaG1qO?=
 =?us-ascii?Q?Y2spz4rfJoNJ9M4fcytd3WZZmx+o/ByHLVtJ2cEb02sSjkquSffkeD+kPO16?=
 =?us-ascii?Q?byh5T1w1VXhGXf/tjPLiHYZGNFA5hSxoMAHkE4ehB3ARmVLUgmArYIj9c3DP?=
 =?us-ascii?Q?p0kSmeOKR1dRcT63/3oeGxxtzm8mYup8ev91n8pWb1mxMEv2cN6c9Rvf0k+9?=
 =?us-ascii?Q?jlG7378eFxkweZ8du8lOmiboTwEt79M9dIhvFgPOos6fsx5iimedsWoKJzzb?=
 =?us-ascii?Q?4pOPqxoLwj9sC8ozDPkA5vlNqsrVgGpndtF6gfI0V7K17W/Zyl4wGJ+Pdst4?=
 =?us-ascii?Q?mHWfKeJn0shExX2qCpS/ZpSIRrsMesRqkduiyDRGS9ueHy/ceB1GlFKHXIma?=
 =?us-ascii?Q?DBnhD6qL/j79C4xi9eSxfG27dc3+JLLGZLojH6CohX4jPsM9V+BJl2byyHse?=
 =?us-ascii?Q?O5c0coYTEHQ2WjY2HORLe8ayq6o60cjrZ27MBBt0dHWEFpkCrHFJj+1+op7X?=
 =?us-ascii?Q?b3VkpkJs4jr4Ah6s2pOSFPdriJe/8IYHMbdiHHupYaKmjv9xO66LuzdajDk7?=
 =?us-ascii?Q?pKwX4FDAO4n/RK/JhXQCIIFP/iFO90ebIzkp?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5055.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(10070799003)(376014)(1800799024)(38070700021)(8096899003)(7053199007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?OzUhno0JJ9Wz7C/upej1ZwYgZfOhMgr/3OeAJjSDvUdHkJgdmkfLgr1iawuq?=
 =?us-ascii?Q?VTQMWIGgzmivTzVRvC4TtMLroiesr8/CxPVy5NQldtymvfU9TKf3xLxBRcPI?=
 =?us-ascii?Q?j8z7dWXf0VlUlg4/TXs6r5VJ9hXVve5IMOEbfoHCU0ybie34xiqkFJNUZxgS?=
 =?us-ascii?Q?oyeeYo0xgyEXl7MBXEl8ykZWxUMAb92x0lTI1Z3qSs8ETOVIvLpDujfOudnL?=
 =?us-ascii?Q?pqzVJDovKu/EkEw5Nri6A9o7IK3EOuIhtSTqWx6p9KEWyJGDGWkIyvT8Qud5?=
 =?us-ascii?Q?KqUG2fVfPDl4Xm9IOO3XJgemxFDQYotOBaRLqJuen1+6SiKXC7rVyV69GZCM?=
 =?us-ascii?Q?R/YdcVY+646KNKMLWVedwZ5Zv9EBEfdUER81UUSkwIfR/jnBfqEvZZtf29Fc?=
 =?us-ascii?Q?0I0/VupGhrZLdgCdAfVCO2FYbjM4lNmRniHuWPiE4Wn/zixG0t2A6z41XOM/?=
 =?us-ascii?Q?xD1YFtjJGla0Gh/i+0FdmBTGtlJIS4XWlaaw2bbSVnTe94c/8Z9nuEUkNfRJ?=
 =?us-ascii?Q?73EBdeAlBCwosEX9+IV7DOI/vwlz4GmVRYMYZKgcDtnE8rjVrLKJoR+Ht0Ud?=
 =?us-ascii?Q?d9s5BOwU3r+cBQAE7QwxMlah3biDYRzhMLyhHVrBN8aKo8l/8UQVJBtt/mei?=
 =?us-ascii?Q?6Y/aIlN/zGae4xKPAAVel01qKejgWuetbEcN1zi2ZbbtW+4ZRnRQl3S0+K+g?=
 =?us-ascii?Q?DhPXeMPqIH51ruv7Vp0P+PZA9zOLGln2I05uivDRzdFspYaZXPoE52IJaJT6?=
 =?us-ascii?Q?y4j6TnEhUFVAMqXci33yf33BwFpH7J3yNPZvyNLG+GOrr83x4ao6Njgdg9rC?=
 =?us-ascii?Q?MR9b3DQayCfcciQ/OCxehjxFeYemV5RfNrkecDaUCvmvlYpJQUBpnXSnteff?=
 =?us-ascii?Q?erfXYaxcV5PyiuppD2SYQ3pempQKmEepvjrUenTCV1FaueBMEmi+l1YKkO4T?=
 =?us-ascii?Q?t2ePI3GKmkZepXldvdu/36oNtMj6Cb1BCSqMEjiDiINEHq3XZwIU8qvS09NZ?=
 =?us-ascii?Q?gfV6Dq40o69ebljS7/HHKe5Ewow9FZLHsEuRRBMk+kcbDSf/LQgGC3TZRrjC?=
 =?us-ascii?Q?yujxrZLj8F7pzf8qlth6unIvdsWJEvu3HJUyhESm2sNSjUrrZJNAMe+i0yhq?=
 =?us-ascii?Q?N3i6zFB6Cv46w6eX+nTm3+mIgBACUTsk5sFVQhAraJ9OZgWjbopspU0hk+Nd?=
 =?us-ascii?Q?V3/qd89obrUT/IyVMj/NP7FF1xoamfVcZP72eY84ueevTjHtq8Xtfkf2IHME?=
 =?us-ascii?Q?CS5Dk66jXaDsMgzCBTcAMsMyUyB34qkhYJYDhX7t/5bJ2sNGNJgnnV+V0XGZ?=
 =?us-ascii?Q?CXGaFriXuGT489pUM+RZBM+P4afn7l4ans+Lo86FVPnw08rhunNUkabSHoFe?=
 =?us-ascii?Q?7gfxdm26WLuy4YhfsF5B7RtW7HxYIY0lJmkvLzfh2P+VQdKCgu7Npz7QPA3S?=
 =?us-ascii?Q?4COGB0dN0rvv6viUtfpM/9M0bODISWCC8XWBxWgJGNThwctXIBW8F/R8zZ5L?=
 =?us-ascii?Q?LNc7Dag+/nsdUdfv80MBMYuNc12PioPi2mz9tI63ZxzS9Z28ZWafSdHUo/I1?=
 =?us-ascii?Q?eyKrAEwK1SwrEkFExWKr7mt3npSqCFiuUeoj8+WkDQcJLqJtBZNPKIlR6zuj?=
 =?us-ascii?Q?+++2HybbX1y5JMa1+5a0aEBdjOd6syiMBwyP+4PczfNsKHzgpoIZ/Yul6iVn?=
 =?us-ascii?Q?6rv/hA=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_DM4PR12MB505543F20F4534C5A82A029E8DD8ADM4PR12MB5055namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5055.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d41dbec-6ec7-4545-ca84-08de31759fef
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2025 07:37:19.7147 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4IyPsy7jka0Q/as4ogSZNpP/TL3+NA5m460s2UfEJ9huppok2FDZjrJXdQPITkgz09J/ZUHMyFX4+xcelTadYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4413
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

--_000_DM4PR12MB505543F20F4534C5A82A029E8DD8ADM4PR12MB5055namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - AMD Internal Distribution Only]

Acked-by: Selwin Sebastian<selwin.sebastian@amd.com>

Get Outlook for iOS<https://aka.ms/o0ukef>
________________________________
From: Govindaiah, Vinay <Vinay.Govindaiah@amd.com>
Sent: Tuesday, December 2, 2025 12:41:52 PM
To: dev@dpdk.org <dev@dpdk.org>
Cc: Sebastian, Selwin <Selwin.Sebastian@amd.com>; Govindaiah, Vinay <Vinay.=
Govindaiah@amd.com>
Subject: [PATCH] net/axgbe: add support for V4000 Kracken2e

add device ID's for Kracken2e to enable
driver to support this device.

Signed-off-by: Vinay Govindaiah <vigovind@amd.com>
---
 drivers/net/axgbe/axgbe_common.h |  2 ++
 drivers/net/axgbe/axgbe_ethdev.c | 16 ++++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/drivers/net/axgbe/axgbe_common.h b/drivers/net/axgbe/axgbe_com=
mon.h
index 93e6c177b6..6e4e23027d 100644
--- a/drivers/net/axgbe/axgbe_common.h
+++ b/drivers/net/axgbe/axgbe_common.h
@@ -905,6 +905,8 @@
 #define PCS_V2_RV_WINDOW_SELECT         0x1064
 #define PCS_V2_YC_WINDOW_DEF            0x18060
 #define PCS_V2_YC_WINDOW_SELECT         0x18064
+#define PCS_KR_WINDOW_SELECT            0x8080
+#define PCS_KR_WINDOW_DEF               0x8060

 /* PCS register entry bit positions and sizes */
 #define PCS_V2_WINDOW_DEF_OFFSET_INDEX  6
diff --git a/drivers/net/axgbe/axgbe_ethdev.c b/drivers/net/axgbe/axgbe_eth=
dev.c
index cf3b0d9ef5..aa7d332b44 100644
--- a/drivers/net/axgbe/axgbe_ethdev.c
+++ b/drivers/net/axgbe/axgbe_ethdev.c
@@ -185,6 +185,7 @@ static const struct axgbe_xstats axgbe_xstats_strings[]=
 =3D {

 #define Fam17h  0x17
 #define Fam19h  0x19
+#define        Fam1Ah  0x1A

 #define CPUID_VENDOR_AuthenticAMD_ebx   0x68747541
 #define CPUID_VENDOR_AuthenticAMD_ecx   0x444d4163
@@ -2291,6 +2292,21 @@ eth_axgbe_dev_init(struct rte_eth_dev *eth_dev)
                         unknown_cpu =3D 1;
                 }
                 break;
+               case Fam1Ah:
+               /* V4000 (krackan2e) */
+               if (cpu_model =3D=3D 0x68) {
+                       pdata->xpcs_window_def_reg =3D PCS_KR_WINDOW_DEF;
+                       pdata->xpcs_window_sel_reg =3D PCS_KR_WINDOW_SELECT=
;
+
+                       /* V4000-Krkan2e devices do not need cdr workaround=
 */
+                       pdata->vdata->an_cdr_workaround =3D 0;
+
+                       /* V4000-Krkan2e devices do not need rrc */
+                       pdata->vdata->enable_rrc =3D 0;
+               } else {
+                       unknown_cpu =3D 1;
+               }
+               break;
                 default:
                         unknown_cpu =3D 1;
                         break;
--
2.34.1


--_000_DM4PR12MB505543F20F4534C5A82A029E8DD8ADM4PR12MB5055namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
</head>
<body>
<p style=3D"font-family:Calibri;font-size:10pt;color:#0000FF;margin:5pt;fon=
t-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[AMD Official Use Only - AMD Internal Distribution Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Aptos, -apple-system, HelveticaNeue, sans-serif;=
font-size: 12pt">
<div dir=3D"ltr" style=3D"font-family: Aptos; font-size: 15.4px;"><span sty=
le=3D"color: rgb(33, 33, 33); text-transform: none;">Acked-by: Selwin Sebas=
tian&lt;</span><span style=3D"color: rgb(15, 108, 189); text-transform: non=
e;">selwin.sebastian@amd.com</span><span style=3D"color: rgb(33, 33, 33); t=
ext-transform: none;">&gt;</span></div>
</div>
<div id=3D"ms-outlook-mobile-body-separator-line" style=3D"font-family: Apt=
os, -apple-system, HelveticaNeue, sans-serif;font-size: 12pt" dir=3D"auto">
<br>
</div>
<div id=3D"ms-outlook-mobile-signature" style=3D"font-family: Aptos, -apple=
-system, HelveticaNeue, sans-serif;font-size: 12pt">
Get <a href=3D"https://aka.ms/o0ukef">Outlook for iOS</a></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Govindaiah, Vinay &lt=
;Vinay.Govindaiah@amd.com&gt;<br>
<b>Sent:</b> Tuesday, December 2, 2025 12:41:52 PM<br>
<b>To:</b> dev@dpdk.org &lt;dev@dpdk.org&gt;<br>
<b>Cc:</b> Sebastian, Selwin &lt;Selwin.Sebastian@amd.com&gt;; Govindaiah, =
Vinay &lt;Vinay.Govindaiah@amd.com&gt;<br>
<b>Subject:</b> [PATCH] net/axgbe: add support for V4000 Kracken2e</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">add device ID's for Kracken2e to enable<br>
driver to support this device.<br>
<br>
Signed-off-by: Vinay Govindaiah &lt;vigovind@amd.com&gt;<br>
---<br>
&nbsp;drivers/net/axgbe/axgbe_common.h |&nbsp; 2 ++<br>
&nbsp;drivers/net/axgbe/axgbe_ethdev.c | 16 ++++++++++++++++<br>
&nbsp;2 files changed, 18 insertions(+)<br>
<br>
diff --git a/drivers/net/axgbe/axgbe_common.h b/drivers/net/axgbe/axgbe_com=
mon.h<br>
index 93e6c177b6..6e4e23027d 100644<br>
--- a/drivers/net/axgbe/axgbe_common.h<br>
+++ b/drivers/net/axgbe/axgbe_common.h<br>
@@ -905,6 +905,8 @@<br>
&nbsp;#define PCS_V2_RV_WINDOW_SELECT&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; 0x1064<br>
&nbsp;#define PCS_V2_YC_WINDOW_DEF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; 0x18060<br>
&nbsp;#define PCS_V2_YC_WINDOW_SELECT&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; 0x18064<br>
+#define PCS_KR_WINDOW_SELECT&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; 0x8080<br>
+#define PCS_KR_WINDOW_DEF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x8060<br>
&nbsp;<br>
&nbsp;/* PCS register entry bit positions and sizes */<br>
&nbsp;#define PCS_V2_WINDOW_DEF_OFFSET_INDEX&nbsp; 6<br>
diff --git a/drivers/net/axgbe/axgbe_ethdev.c b/drivers/net/axgbe/axgbe_eth=
dev.c<br>
index cf3b0d9ef5..aa7d332b44 100644<br>
--- a/drivers/net/axgbe/axgbe_ethdev.c<br>
+++ b/drivers/net/axgbe/axgbe_ethdev.c<br>
@@ -185,6 +185,7 @@ static const struct axgbe_xstats axgbe_xstats_strings[]=
 =3D {<br>
&nbsp;<br>
&nbsp;#define Fam17h&nbsp; 0x17<br>
&nbsp;#define Fam19h&nbsp; 0x19<br>
+#define&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Fam1Ah&nbsp; 0x1A<br>
&nbsp;<br>
&nbsp;#define CPUID_VENDOR_AuthenticAMD_ebx&nbsp;&nbsp; 0x68747541<br>
&nbsp;#define CPUID_VENDOR_AuthenticAMD_ecx&nbsp;&nbsp; 0x444d4163<br>
@@ -2291,6 +2292,21 @@ eth_axgbe_dev_init(struct rte_eth_dev *eth_dev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unkno=
wn_cpu =3D 1;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; case Fam1Ah:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; /* V4000 (krackan2e) */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (cpu_model =3D=3D 0x68) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pdata-&gt;xpcs_w=
indow_def_reg =3D PCS_KR_WINDOW_DEF;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pdata-&gt;xpcs_w=
indow_sel_reg =3D PCS_KR_WINDOW_SELECT;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* V4000-Krkan2e=
 devices do not need cdr workaround */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pdata-&gt;vdata-=
&gt;an_cdr_workaround =3D 0;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* V4000-Krkan2e=
 devices do not need rrc */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pdata-&gt;vdata-=
&gt;enable_rrc =3D 0;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; } else {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unknown_cpu =3D =
1;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; default:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unkno=
wn_cpu =3D 1;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break=
;<br>
-- <br>
2.34.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_DM4PR12MB505543F20F4534C5A82A029E8DD8ADM4PR12MB5055namp_--
