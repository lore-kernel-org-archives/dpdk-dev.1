Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 672DBC3600C
	for <dpdk-dev@archiver.kernel.org>; Tue,  8 Apr 2025 06:02:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8D38940E3E;
	Tue,  8 Apr 2025 08:02:36 +0200 (CEST)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2137.outbound.protection.outlook.com [40.107.220.137])
 by mails.dpdk.org (Postfix) with ESMTP id CF17040E1F
 for <dev@dpdk.org>; Tue,  8 Apr 2025 08:02:33 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pEh9mVlWvr7ToqKeELYRZcLg8jCrEril8oDrf2efp/4xH3c4IctEJ1gpTAQOrMlSOvvqU4prwBh2MGeR4GQR/nH/R459V8Zt90yz/D4dtshbF4ji33ImGjFQHNgoP4RRizC6/oQiQfXfSvDC5OSkdrT8nxqPpwn0wB3T97kW7yxQ+FSoh7lD3803pveEMZOv1I+r+i3G+RcV62djrShkFH2rGmH7i6UXEtc9U3jy9MecnzM9y5SuBeXAwdBfv2xeO6PPQs8Xe6pnNX+JIyDuVVeech1fmeP35A7Ukg8EuRgfeLVUyNNs/cx7S+FtVe9RHVBOOodtU6h+mdwT/Bzcdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VOwTi4Pcx46KqacJkBiTSHQMjoFC/rz0Xc8ckN5bBeg=;
 b=K8OaBFu24Ws71YKERVuUFNp7oZrfDCqKl6T4Yk1V4JZKKQsAJBAAdUn9+sGPquhSxepxCcsEZ5wCyuFrphtb9N0aqQqx5tYmdjrenb0qvJQedWmMt0gMpoi+RC/03yIikbvFZu9eJPEgFNFC2YFf5rRNLVouN/2JYVbOQsEv9EADocvbzZb9KZLFWfm/TnCAKPYSSuKIbVX/hnkv0G72uhqg0dwr7fu30OcSiNoxf/5j+aRIrd+VsxnBkJ5PT/KQW1Y0b8sXj+fW5w+gf0/MOgulpIpjnuQ2MCYg6YkNifz6m72H61Ithwhg3lTi+v8v+bVXgJ2voT2dGZQGp4lkVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VOwTi4Pcx46KqacJkBiTSHQMjoFC/rz0Xc8ckN5bBeg=;
 b=YLlHd1dir+8n/rKLfGpNYXHIC9o//VxAovfoXCioDsUZ9d/c7ts+udww92OfpGWc26VxS+D6JTGmTEFBT0GnfebVaiAGFwLRjy+HwpQO1Sol01X5MbWzPx7nLDzuARZORH+a64Hdix2fczer6sipul418Xu3zjvNi5OTa45M8gQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from SJ0PR13MB5545.namprd13.prod.outlook.com (2603:10b6:a03:424::5)
 by SJ0PR13MB5918.namprd13.prod.outlook.com (2603:10b6:a03:439::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.33; Tue, 8 Apr
 2025 06:02:32 +0000
Received: from SJ0PR13MB5545.namprd13.prod.outlook.com
 ([fe80::b900:5f05:766f:833]) by SJ0PR13MB5545.namprd13.prod.outlook.com
 ([fe80::b900:5f05:766f:833%4]) with mapi id 15.20.8583.043; Tue, 8 Apr 2025
 06:02:32 +0000
From: Chaoyong He <chaoyong.he@corigine.com>
To: dev@dpdk.org
Cc: oss-drivers@corigine.com,
	Chaoyong He <chaoyong.he@corigine.com>
Subject: [PATCH 3/3] net/nfp: correct RSS algorithm configuration logic
Date: Tue,  8 Apr 2025 14:02:03 +0800
Message-ID: <20250408060203.473733-4-chaoyong.he@corigine.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250408060203.473733-1-chaoyong.he@corigine.com>
References: <20250408060203.473733-1-chaoyong.he@corigine.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0032.apcprd02.prod.outlook.com
 (2603:1096:4:195::12) To SJ0PR13MB5545.namprd13.prod.outlook.com
 (2603:10b6:a03:424::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR13MB5545:EE_|SJ0PR13MB5918:EE_
X-MS-Office365-Filtering-Correlation-Id: 2391833d-85c7-4d8a-43d4-08dd7662f361
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|52116014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?nZtK5A/ku2vllMo0vEzlMY7NjCy9YY2kQ9VI/ZCP0NWVc9BQEgreQqT0Z6k1?=
 =?us-ascii?Q?zhiVngS+SMthz2UwFtXUNIrmbhBPa+xpx1tfpBUfBvlEzLvSG8MpfvKgLEPq?=
 =?us-ascii?Q?5VBYRUfw6dmEdUBWXYoSjuM4CLBWKGJA55Zc0uSGGRdc2l3lDsU42AwrVQev?=
 =?us-ascii?Q?cp2SiMYIEwrW3t7LqHFeSEKYpIyvjyoh7EiqK9Tnpf6Cs9iHiKXVvAcBhuy6?=
 =?us-ascii?Q?bEQW3Bb8BNZjAsdrZZMDKPW5mnmV3bSwROuvfZgEZHuD9fbC2uyKHbl6l27j?=
 =?us-ascii?Q?yoDHy5GoT4crWVt2R7qo4GidOcQXVA8NATGtvNBl/znKH9zXXAXqxVzPPGhG?=
 =?us-ascii?Q?nddr2jEOfPSPA0wlItFXa30X+LTXuIWHoeH8htvI/Hcde9Arcwsf1OykWzgb?=
 =?us-ascii?Q?eVUej08duMGeJ1aXZcQ3OI7qrcpfPRObisbsQ/Ahx9d2gDAWfq8HbuVlShsy?=
 =?us-ascii?Q?xrdXXl8I3Uhcn01ER46UBPqa74InNS8KizgbHOT1DSHJWRjtqvHT+1xbBWXJ?=
 =?us-ascii?Q?72YHdzoQ2qdCbP3QXGXH/EULbgCh/Nym3/iAcYebiNgtRW+71WPAHbdOMsNb?=
 =?us-ascii?Q?QA3ZVuswNg8ao0gZfC7mhYZir8iPjicBW1XgEvDVFyKbauE3kDO9t0rBrKmo?=
 =?us-ascii?Q?PV9gCbFCaINYg2vNZCaXVKpYLFpnmkT/lhOYxW8t7QdmoA//lsJ34qAHOA/v?=
 =?us-ascii?Q?Sz3PtrUE/RLvqBdRnYSTB1jO1Go+ZPvpZjL+9dW8qXCW6waIHwX+SGCl5x3Z?=
 =?us-ascii?Q?F5hCIyFJuaP+wXrok+YMtgEyENliGJVS5Pjru2QOogVjJpPt4CM1W2ce/ffo?=
 =?us-ascii?Q?JQglN40BgUAOOB6LO44aca9klukFne9xkEQl1xUVPXoM3O6uA6sYNLtr+E4B?=
 =?us-ascii?Q?hyQkczOfzSDeBUD4/6F2pgIL76i3GL+FFmiEild+QnpF22v3sJGjeRu/RONn?=
 =?us-ascii?Q?rlcRSVtq7QQqEn6op8Z5XjWQEwuTidb7bsApuJ9Dm0lwsx/Bfgq2CKyBpyuD?=
 =?us-ascii?Q?xrZyzVbXDNb2AH/DKgCC6c2hnSjMa0KDQd01X0STiqBPBzQ5cSkAXdgtX0QG?=
 =?us-ascii?Q?WyY59dxgSJY6gNnq66uq4cMmrdiE4mj81TA6YTWnHo5ZqPrSS8PzTSrmtjHE?=
 =?us-ascii?Q?1F8Ft2l4NKgdU1w9VjTuIe3UsMSauChmZ6NiKAIQK691D/ob8bXmVIzO9tGm?=
 =?us-ascii?Q?c2vHP1xMQvqWnL/LH3DDTRQT5qMxMxmZyegZEEHgFCmnykJ/L7UOLWd20ARe?=
 =?us-ascii?Q?MQdMY0H7zSO3WOZq2lYgepQ91hGNUpnHM6v0iyDkymePzJl4tyyQsnSYGA2J?=
 =?us-ascii?Q?By/pEbQCpuWCXrS62u8CJdHyYAjFi5vFzL/SiFcoHSeirijRrmg+HL2f/2za?=
 =?us-ascii?Q?PCgd7Jctl3WLq0+SzpkFJv5fkTmzQG3zCj0ndGvJq75JI001rdJcbCiFrJrb?=
 =?us-ascii?Q?dYuLpPbGbuoz+xBqyscAGXLgCtL1Yz4qYUjzQda/5fVElfBwJIBsZw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR13MB5545.namprd13.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mrm6Kc3Uu5k9OnfrHrPQD5XcpMnEtQOQuJcoQI3tT6/giLYVuKTXK2kLIozZ?=
 =?us-ascii?Q?R6DFbMbirME3c22Ex2F7653iJC1+MNDJbWiK5itZr9A0AyIjor4+VC0T+qbk?=
 =?us-ascii?Q?3ji7qUTha5ve2pg5E0LicCqJQyqbVcW5XpCUGAC58TV8X7fCrzfCZUmdiExC?=
 =?us-ascii?Q?zM78Yqqylu9HqwixDdrKnFeLRHXcpwyLMy5gOqsKaoFVqeWvy7kCDkoqAAYk?=
 =?us-ascii?Q?ysK02kJDbfCB56OeIR4MgMpWWnqUYrz5PoxxBCtD1VWJruteR3vKUYig8iCv?=
 =?us-ascii?Q?DDiM+9nlu/w9ART3XLbi9gT3vc5x6tL9Dfc21S6bDGzFR6c9HknbyTT9faG8?=
 =?us-ascii?Q?TpEF5qHl66b41t1caEsVcEKnyXDOK5aseJAGkW86Xp98UCZuNO/NIyaQR1tv?=
 =?us-ascii?Q?4rb3MHoDl/DROr7Kg7RuqGLVWUQA/6ns1tsct6o9u8qOJmCFS+CvIZogNU7Q?=
 =?us-ascii?Q?jTuEuNAf8ZbV3MB9e5kMX2A0a37Ac94ha8rxefdzt6RkixWtalanYgbT5WM7?=
 =?us-ascii?Q?pXl/5vRlNWrrvKrqatw9yj+Pd2kg2fFGEH+fmFatsph75F8Ni/Lzpi+si3k+?=
 =?us-ascii?Q?kOmnhNOGcFvFRAE3dQGzUfABw1dm82H6SEFcTNvBgVIihC0bdZMYjmaeUZrA?=
 =?us-ascii?Q?I/gcDc8TJpytKcMvJ45DgE6Qln6rdfiRmHG+9Q3KT5XJoCgYOrwDIW3g8+v3?=
 =?us-ascii?Q?LyrdoDRohDtfaUFPyLLDhkJEjq6kXDdxn8/cGpAzHSaeVoEdzRy0L/IyrTyM?=
 =?us-ascii?Q?ghJvZDfUefFX88uHlWqAnjBurmp6eIFDcboh4dxAG5PsLcPOm/2DocnShGwf?=
 =?us-ascii?Q?sY3AL3C+MtsYVFJeB4sfurTnTaARJFZEKu3qJHrplX/bXo8Y65hrUlrD1m2+?=
 =?us-ascii?Q?ppWipdGE3B5D1XOmses1gUZghkoHz0EHYYoTvfKjW2fUISPLsuIyg13Zwssq?=
 =?us-ascii?Q?r7L531Iu2s7g1pGvD2BJN2viCxrL1M6iuB3yuWxylvFtgMpbsVyibza4V25w?=
 =?us-ascii?Q?Szcw6b9kztpqQFXwm6+x2POyLURi1Njl2TlAVLzy7qiLJ3ehKC36vJKXsUTR?=
 =?us-ascii?Q?qVTCgIaWfcB6/im+5eWGc2C63UV3M4AEt/DWP98fSEch+kYkAf8a+jiY2Tc7?=
 =?us-ascii?Q?WiUfNMgKryz5gzBj0J1SrcJc1JO7BeoGqBsV7poZjTnB3yKyefPed74WxoOt?=
 =?us-ascii?Q?64E4dMX92bnt/VQFv9/iQ4VFQCkTTLdI5EutiGts2HT2kct12NPFrKBxVhf7?=
 =?us-ascii?Q?cF4k7LvkGO58x1BEQE421ap6SyHwSJO3V688o5tJPpGEN9Q68s0kNB4gclVY?=
 =?us-ascii?Q?2zQqqxCaYDJCcC2oNZUnjW770W9rfKCZoJC3lxywyXYKB/1fIxVkxINtTP+/?=
 =?us-ascii?Q?T6mZIegN5jRcp1MPMo3G5eBwJ83CABrFjdHi6nuaByEp21dLJiaorbq27/mj?=
 =?us-ascii?Q?tqq43LB/6Z+ZmiCboPlWRwOwj+4K68JvKM2BGaRfLYxdf5rGfyoS/XsGDRup?=
 =?us-ascii?Q?c/OhCMPfroktoCCm3JTeApiAsP8aGtrhMNhz/h2kH/Jyu9EZw9yFAE1QovJ7?=
 =?us-ascii?Q?ZsycOCdqmuGpPaj7mszR1uCriYvYCz95FcbiBZPyxHWOkiUXbmKijlwkJHKf?=
 =?us-ascii?Q?rg=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2391833d-85c7-4d8a-43d4-08dd7662f361
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR13MB5545.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2025 06:02:32.1230 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EV3e+b9zBS1eFUzg73iqz9z4GNw4AchLsNbt1AXVkdtNygOkhfS2zFjJxh0nhCzXPINXldBBX+y8DG/4FddAEukoXEhPrcc3d8Aw8nsgtLk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR13MB5918
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

Correct the RSS algorithm configuration logic, also do some refactor to
the related logic.

Signed-off-by: Chaoyong He <chaoyong.he@corigine.com>
---
 drivers/net/nfp/nfp_net_common.c | 121 +++++++++++++++++++++----------
 1 file changed, 81 insertions(+), 40 deletions(-)

diff --git a/drivers/net/nfp/nfp_net_common.c b/drivers/net/nfp/nfp_net_common.c
index 7f1ab70d9b..f578ec1909 100644
--- a/drivers/net/nfp/nfp_net_common.c
+++ b/drivers/net/nfp/nfp_net_common.c
@@ -1952,6 +1952,37 @@ nfp_net_rss_hf_get(uint32_t cfg_rss_ctrl,
 	rss_conf->rss_hf = rss_hf;
 }
 
+static void
+nfp_net_rss_hf_set(uint32_t *cfg_rss_ctrl,
+		struct rte_eth_rss_conf *rss_conf)
+{
+	uint64_t rss_hf = rss_conf->rss_hf;
+
+	if ((rss_hf & RTE_ETH_RSS_IPV4) != 0)
+		*cfg_rss_ctrl |= NFP_NET_CFG_RSS_IPV4;
+
+	if ((rss_hf & RTE_ETH_RSS_NONFRAG_IPV4_TCP) != 0)
+		*cfg_rss_ctrl |= NFP_NET_CFG_RSS_IPV4_TCP;
+
+	if ((rss_hf & RTE_ETH_RSS_NONFRAG_IPV4_UDP) != 0)
+		*cfg_rss_ctrl |= NFP_NET_CFG_RSS_IPV4_UDP;
+
+	if ((rss_hf & RTE_ETH_RSS_NONFRAG_IPV4_SCTP) != 0)
+		*cfg_rss_ctrl |= NFP_NET_CFG_RSS_IPV4_SCTP;
+
+	if ((rss_hf & RTE_ETH_RSS_IPV6) != 0)
+		*cfg_rss_ctrl |= NFP_NET_CFG_RSS_IPV6;
+
+	if ((rss_hf & RTE_ETH_RSS_NONFRAG_IPV6_TCP) != 0)
+		*cfg_rss_ctrl |= NFP_NET_CFG_RSS_IPV6_TCP;
+
+	if ((rss_hf & RTE_ETH_RSS_NONFRAG_IPV6_UDP) != 0)
+		*cfg_rss_ctrl |= NFP_NET_CFG_RSS_IPV6_UDP;
+
+	if ((rss_hf & RTE_ETH_RSS_NONFRAG_IPV6_SCTP) != 0)
+		*cfg_rss_ctrl |= NFP_NET_CFG_RSS_IPV6_SCTP;
+}
+
 static int
 nfp_net_rss_algo_conf_get(uint32_t cfg_rss_ctrl,
 		struct rte_eth_rss_conf *rss_conf)
@@ -1968,13 +1999,31 @@ nfp_net_rss_algo_conf_get(uint32_t cfg_rss_ctrl,
 	return 0;
 }
 
+static int
+nfp_net_rss_algo_conf_set(uint32_t *cfg_rss_ctrl,
+		struct rte_eth_rss_conf *rss_conf)
+{
+	enum rte_eth_hash_function algorithm = rss_conf->algorithm;
+
+	if (algorithm == RTE_ETH_HASH_FUNCTION_TOEPLITZ)
+		*cfg_rss_ctrl |= NFP_NET_CFG_RSS_TOEPLITZ;
+	else if (algorithm == RTE_ETH_HASH_FUNCTION_SIMPLE_XOR)
+		*cfg_rss_ctrl |= NFP_NET_CFG_RSS_XOR;
+	else if (algorithm == RTE_ETH_HASH_FUNCTION_DEFAULT)
+		*cfg_rss_ctrl |= NFP_NET_CFG_RSS_CRC32;
+	else
+		return -ENOTSUP;
+
+	return 0;
+}
+
 static int
 nfp_net_rss_hash_write(struct rte_eth_dev *dev,
 		struct rte_eth_rss_conf *rss_conf)
 {
+	int ret;
 	uint8_t i;
 	uint8_t key;
-	uint64_t rss_hf;
 	struct nfp_hw *hw;
 	struct nfp_net_hw *net_hw;
 	uint32_t cfg_rss_ctrl = 0;
@@ -1988,38 +2037,15 @@ nfp_net_rss_hash_write(struct rte_eth_dev *dev,
 		nn_cfg_writeb(hw, NFP_NET_CFG_RSS_KEY + i, key);
 	}
 
-	rss_hf = rss_conf->rss_hf;
-
-	if ((rss_hf & RTE_ETH_RSS_IPV4) != 0)
-		cfg_rss_ctrl |= NFP_NET_CFG_RSS_IPV4;
-
-	if ((rss_hf & RTE_ETH_RSS_NONFRAG_IPV4_TCP) != 0)
-		cfg_rss_ctrl |= NFP_NET_CFG_RSS_IPV4_TCP;
-
-	if ((rss_hf & RTE_ETH_RSS_NONFRAG_IPV4_UDP) != 0)
-		cfg_rss_ctrl |= NFP_NET_CFG_RSS_IPV4_UDP;
-
-	if ((rss_hf & RTE_ETH_RSS_NONFRAG_IPV4_SCTP) != 0)
-		cfg_rss_ctrl |= NFP_NET_CFG_RSS_IPV4_SCTP;
-
-	if ((rss_hf & RTE_ETH_RSS_IPV6) != 0)
-		cfg_rss_ctrl |= NFP_NET_CFG_RSS_IPV6;
-
-	if ((rss_hf & RTE_ETH_RSS_NONFRAG_IPV6_TCP) != 0)
-		cfg_rss_ctrl |= NFP_NET_CFG_RSS_IPV6_TCP;
-
-	if ((rss_hf & RTE_ETH_RSS_NONFRAG_IPV6_UDP) != 0)
-		cfg_rss_ctrl |= NFP_NET_CFG_RSS_IPV6_UDP;
-
-	if ((rss_hf & RTE_ETH_RSS_NONFRAG_IPV6_SCTP) != 0)
-		cfg_rss_ctrl |= NFP_NET_CFG_RSS_IPV6_SCTP;
+	nfp_net_rss_hf_set(&cfg_rss_ctrl, rss_conf);
 
 	cfg_rss_ctrl |= NFP_NET_CFG_RSS_MASK;
 
-	if (rte_eth_dev_is_repr(dev))
-		cfg_rss_ctrl |= NFP_NET_CFG_RSS_CRC32;
-	else
-		cfg_rss_ctrl |= NFP_NET_CFG_RSS_TOEPLITZ;
+	ret = nfp_net_rss_algo_conf_set(&cfg_rss_ctrl, rss_conf);
+	if (ret != 0) {
+		PMD_DRV_LOG(ERR, "Fail to set rss algorithm configuration.");
+		return ret;
+	}
 
 	/* Configuring where to apply the RSS hash */
 	nn_cfg_writel(hw, NFP_NET_CFG_RSS_CTRL, cfg_rss_ctrl);
@@ -2034,24 +2060,18 @@ int
 nfp_net_rss_hash_update(struct rte_eth_dev *dev,
 		struct rte_eth_rss_conf *rss_conf)
 {
+	int ret;
 	uint32_t update;
-	uint64_t rss_hf;
 	struct nfp_hw *hw;
 	struct nfp_net_hw *net_hw;
 
 	net_hw = nfp_net_get_hw(dev);
 	hw = &net_hw->super;
 
-	rss_hf = rss_conf->rss_hf;
-
 	/* Checking if RSS is enabled */
 	if ((hw->ctrl & NFP_NET_CFG_CTRL_RSS_ANY) == 0) {
-		if (rss_hf != 0) {
-			PMD_DRV_LOG(ERR, "RSS unsupported.");
-			return -EINVAL;
-		}
-
-		return 0; /* Nothing to do */
+		PMD_DRV_LOG(ERR, "RSS unsupported.");
+		return -EINVAL;
 	}
 
 	if (rss_conf->rss_key_len > NFP_NET_CFG_RSS_KEY_SZ) {
@@ -2059,7 +2079,11 @@ nfp_net_rss_hash_update(struct rte_eth_dev *dev,
 		return -EINVAL;
 	}
 
-	nfp_net_rss_hash_write(dev, rss_conf);
+	ret = nfp_net_rss_hash_write(dev, rss_conf);
+	if (ret != 0) {
+		PMD_DRV_LOG(ERR, "RSS write failed.");
+		return ret;
+	}
 
 	update = NFP_NET_CFG_UPDATE_RSS;
 
@@ -2116,6 +2140,18 @@ nfp_net_rss_config_default(struct rte_eth_dev *dev)
 	uint8_t i;
 	uint8_t j;
 	uint16_t queue = 0;
+	uint8_t default_key[] = {
+		0x6d, 0x5a, 0x56, 0xda,
+		0x25, 0x5b, 0x0e, 0xc2,
+		0x41, 0x67, 0x25, 0x3d,
+		0x43, 0xa3, 0x8f, 0xb0,
+		0xd0, 0xca, 0x2b, 0xcb,
+		0xae, 0x7b, 0x30, 0xb4,
+		0x77, 0xcb, 0x2d, 0xa3,
+		0x80, 0x30, 0xf2, 0x0c,
+		0x6a, 0x42, 0xb7, 0x3b,
+		0xbe, 0xac, 0x01, 0xfa,
+	};
 	struct rte_eth_conf *dev_conf;
 	struct rte_eth_rss_conf rss_conf;
 	uint16_t rx_queues = dev->data->nb_rx_queues;
@@ -2143,6 +2179,11 @@ nfp_net_rss_config_default(struct rte_eth_dev *dev)
 	}
 
 	rss_conf = dev_conf->rx_adv_conf.rss_conf;
+	if (rss_conf.rss_key_len == 0) {
+		rss_conf.rss_key = default_key;
+		rss_conf.rss_key_len = NFP_NET_CFG_RSS_KEY_SZ;
+	}
+
 	ret = nfp_net_rss_hash_write(dev, &rss_conf);
 
 	return ret;
-- 
2.43.5

