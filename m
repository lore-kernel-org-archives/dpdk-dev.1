Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59701C021B3
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Feb 2025 22:04:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 73D3E40693;
	Thu, 20 Feb 2025 23:04:18 +0100 (CET)
Received: from egress-ip11b.ess.de.barracuda.com
 (egress-ip11b.ess.de.barracuda.com [18.185.115.215])
 by mails.dpdk.org (Postfix) with ESMTP id EED3A40676
 for <dev@dpdk.org>; Thu, 20 Feb 2025 23:04:15 +0100 (CET)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur02lp2044.outbound.protection.outlook.com [104.47.11.44]) by
 mx-outbound46-229.eu-central-1c.ess.aws.cudaops.com (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 20 Feb 2025 22:04:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=owpQIn2LlHZXW+bNaqu8KiT65XHARXlWNoBeXjMSVmoEgeDF3ParrIghlDwSmAzQIu6dSG2AWCbEcNdMuyCLvbyUtmghtp26xzTe0lW10DjT1ltnY6nPVkTgWToBPvrX4O6BIPOAIoMAr0yYwzpiTx0pU/l1fvYhnsmFYzwjOCz/GsFCOSJPRIwr70h3KFe44QaxP8lSfSF2gI8dNNWpI+dAz94bIhcKMUCtGhg6keOQZNQAyDVm+oJqhnpCTylI7au2p7lJkCoNwDdn9lUpQ9Sem3bymw1oeapUihTcO7tDmtR27Ag9LqGT7RcvGtJKXnOKp8WNTkHBoIUj9o8hcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q6URoEYGXD4rDKdTqqwJa6JApC6DKw+HBgy1vpToMIs=;
 b=prxNmhCkVup8q52R0DuR5qtvWMfJx3IyDDFApPK6S6XtoMb65sZFskT6zJO4MaXtHcetJ+8eJ3l9wR7cY/lcAuO2pCF9jz9imQL0Mzpi2iHTh4orflLocnk0QYneyieot+N+VR+PcvgthodEx1YutYMnq4TEKIPS5owmPr4JOCyrkrKpSWc9tHAURsq3Jr5QSM+bAcuxMn5VP+pbF//eCbo1qu1FWSrhlx1OwU01M7NiNhfpjHkPPbsr5U0fy0v3H4wN57LrI3IBdrI/4DGc7qfq6Yhmz0uGP9dAXL32lAcSeXjZmPa/WoJ6sLu/jSq8UdRn3nS8MncE9+RURTGt8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q6URoEYGXD4rDKdTqqwJa6JApC6DKw+HBgy1vpToMIs=;
 b=fuEIudzfZ9IKOpTQZqJ28cHLi8npALEx4DMZslOfCso+31raRaiUmVaxgPWVdsfOvR8u0KFtM6bIUmbDHLeYZpt+WbM4uzzrxS+YANrQHv6fAwvGNMkDqPt7/bi6BxRjmlE5PxzmevFeSt4EKBz20KSueo3JQRc/CflLrzZKJTc=
Received: from CWLP265CA0497.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:18b::15)
 by DB9P190MB1865.EURP190.PROD.OUTLOOK.COM (2603:10a6:10:37c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Thu, 20 Feb
 2025 22:04:13 +0000
Received: from AM3PEPF00009B9C.eurprd04.prod.outlook.com
 (2603:10a6:400:18b:cafe::ef) by CWLP265CA0497.outlook.office365.com
 (2603:10a6:400:18b::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.16 via Frontend Transport; Thu,
 20 Feb 2025 22:04:13 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 AM3PEPF00009B9C.mail.protection.outlook.com (10.167.16.21) with Microsoft
 SMTP Server id 15.20.8466.11 via Frontend Transport; Thu, 20 Feb 2025
 22:04:13 +0000
From: Serhii Iliushyk <sil-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org, Danylo Vodopianov <dvo-plv@napatech.com>
Subject: [PATCH v1 02/32] net/ntnic: add link state machine
Date: Thu, 20 Feb 2025 23:03:26 +0100
Message-ID: <20250220220406.3925597-3-sil-plv@napatech.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250220220406.3925597-1-sil-plv@napatech.com>
References: <20250220220406.3925597-1-sil-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM3PEPF00009B9C:EE_|DB9P190MB1865:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: d187c245-de5f-457a-0b73-08dd51fa82ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/H/peOdKBYfjYdoHo7ez+BJ3H+7sUkj2R5D+4UmcXlNwgARvP8Uh8Ta6GLdd?=
 =?us-ascii?Q?3a/op4Fy+DjY3iBARC+X2HKUePN0qr0/4tcMgM1JNRwRVkmF0ydG3ZTS8f2F?=
 =?us-ascii?Q?y9SMjHZ5bVY6WC5ifweKAgGHO9cBJNjmHYNeyST78sPSAZMItenwpx0vUVpN?=
 =?us-ascii?Q?52I35JSKtFSMqSRmWxI6n88pV/qV8QKvqwBCDIIAekDiZO6oRClqs1llypkX?=
 =?us-ascii?Q?Zdx/fcXCpB/aILbBXOK3r4RBjG5AqJIdG+KgvHreSo6BHLkhjilQmP0u9Q0y?=
 =?us-ascii?Q?SY5r9GQ+zLWyRQFPRIQFd+gL+eZyOL82KtTq2lJf4e1tr5l0hUJRQBIIfGln?=
 =?us-ascii?Q?/LEXIFcfmLpWcyt/xJOZpzgRrU8xcqVdKNx7ZiwvmT8mTvje5yZ7s2JVil9S?=
 =?us-ascii?Q?ceYTQBGLQc1lvOvW63CX2U67CtEglr6al1R3QVF2aTnFjq4BzdRpjAhXEPQJ?=
 =?us-ascii?Q?z0vAZtfJ2idIVvTAfJLYMiGsl4dHrgGqK3px9ys90Mi0VrsR9Pk89b7syav4?=
 =?us-ascii?Q?Z/Pq00QvAQK7n0WsBLiS9LXOhADLXvlEbam6XCIun0VxU3Mp6qt1YzaMpsLd?=
 =?us-ascii?Q?5g5g/7ZCZli2+EQ2xBy6Uc3L9n+89qkuNKR7BhLYjjjXLwwz1Qut4ikcuRWs?=
 =?us-ascii?Q?Ht6qimAE4uc62QIOQtkfgkfNgdSKZX2yeTBRukufBvF8O9i7RZu8C8YiIMyn?=
 =?us-ascii?Q?FnuU5tAG9ThRiYQUZsA3lj/tiAtf5rwX3xpUtW2NfMNkcABc4DHhImzLFAuM?=
 =?us-ascii?Q?ssRTuBII0n0VNrt6Hn1JFrXkvwfA0R2XReOws9CPZG6JOwz8ToJ/Qu5PvhHg?=
 =?us-ascii?Q?lz+M9/qEX4G5ky/ZHOUjInTEWwO9tr5zgWkFHir1glQLq95Bn7CMSqkDqFJg?=
 =?us-ascii?Q?TbW1FjqpkRvu+q2R4i6etVi+1ooOHW08Q12x5AxdAhsd0KlGaFKTycijNkeJ?=
 =?us-ascii?Q?bj4p/g0TmY8l/Bdcu46MT4UmObx4OAHMKOnF5XMmpX/p1IrQCqkCoLl+/Upd?=
 =?us-ascii?Q?8pZOKA8DGPSQ+Uulio7Ed1ibv3CwqpT8anQBMeQGXZJDxVOOWlE16XJX2wbE?=
 =?us-ascii?Q?OTkW1QT5qwfXH8SMJLkZ5EMlCNnp6uEjzNm0KcDUlDS+Nmj+tYTWeKFXxveB?=
 =?us-ascii?Q?md9BhFofbmxLNd30JY/c+9RAgIaa5pqKya3Nzw8zSk7lH8xqE4gwIZ5TuTjc?=
 =?us-ascii?Q?5EA09P983mgExFzuXr0l+lMPDTilDh6+8LPljMTpL0OWlzcyBhxUL+W03gmt?=
 =?us-ascii?Q?G1z/Odln/Kjx/AeZXrnRY/3Et7STvqI9uRBlibl8FwboRSkW6L8ViHNayMSa?=
 =?us-ascii?Q?oycgmVLe7AKWpIxvXS47D4VXUgmZbnp7qwJsk48/3miDoRf3OQVV7gsoSZn8?=
 =?us-ascii?Q?fHEdUrF3BYtD9EcGwBfv9Bi1AWvz5O3RPAKdIKLHwpR0UE9L4wijxq/gqQw9?=
 =?us-ascii?Q?pkSrUBauZO8r+/wp2xwjmiGzvXR3/7dPpJ9EcaICwIYvKWix9vkHbQL108Xv?=
 =?us-ascii?Q?bj/F9slYBqdciGc=3D?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: /oWu1A21/eZCSWB9hDxUQmkFdJ4A+tU/w5qA8C9IefvGuefrO1JdfaA7YqeAg+VAza+pudj9ntGKYz+wZymHUK/Z3UHwOm3PRGrYIDvxo4uAEeF7xkN4kOjdZqvyGEqewellwrGpsZbG4iJTtF7G5ycqrQNCO24cMDskGxwY8IRfdTlf+coPEXiR6WatQjYcT3qLVYtQu7fPp/AIFJeJA06FDV6EmS8zphwuDTtEIc3mBgKE7OR3kOZ1LR3o9FB+QEpl9nUdkJcws80hQia/SxsiuZ7XrNK6FiwAaRqIE81ypqfW8wHyQhhUtP9ImWU9ImyNvzFugdnIhzWL9H+aA4RF7JIUrRTVZrHKE6NtaeWRuQhG3dNj1fvJyE/W/kn5jrXSN9s/n0TBazgWykS8TndN8T/ifIzQPr0YlpMY4+QoaobQtCmOQKBRHKA19yhDI9FaBKGVt0RqppX21GfnTtVPN/Tz+WqmxIpL4INTB5kD5vf4b+Q3QrJ9fon0HGBYGDVjS4xnVigsBo7tTvE+w19/NI6qOstuIJo29sijejzXc/hw06apYjQGIcKDjYz2ANs0TUrArMqKUE1tIA8WC5/BdEiY6s52jRTkJvW9+7rKVLKRzDT9dnP7cLiObzMy3JkOzaxNklnJsWNIP98GI1gmAgVMVe6cBMeGAQVZbcM=
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 22:04:13.1150 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d187c245-de5f-457a-0b73-08dd51fa82ab
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: AM3PEPF00009B9C.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9P190MB1865
X-BESS-ID: 1740089054-312005-29070-14085-1
X-BESS-VER: 2019.1_20250219.2339
X-BESS-Apparent-Source-IP: 104.47.11.44
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKViaWppZAVgZQ0CDFwMLCwsQ8zT
 TZMtnAIi0VyDc0NUk1MTYxT0w0N1WqjQUAsXNspUEAAAA=
X-BESS-Outbound-Spam-Score: 1.00
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.262653 [from 
 cloudscan19-233.eu-central-1b.ess.aws.cudaops.com]
 Rule breakdown below
 pts rule name              description
 ---- ---------------------- --------------------------------
 0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
 1.00 BSF_SC7_GK0121_1       META: Custom rule BSF_SC7_GK0121_1 
X-BESS-Outbound-Spam-Status: SCORE=1.00 using account:ESS113687 scores of
 KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND, BSF_SC7_GK0121_1
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

From: Danylo Vodopianov <dvo-plv@napatech.com>

Minimal 100g agx link state machine implementation was added.

Signed-off-by: Danylo Vodopianov <dvo-plv@napatech.com>
---
 drivers/net/ntnic/include/nt4ga_link.h        |   5 +
 .../link_agx_100g/nt4ga_agx_link_100g.c       | 111 ++++++++++++++++++
 2 files changed, 116 insertions(+)

diff --git a/drivers/net/ntnic/include/nt4ga_link.h b/drivers/net/ntnic/include/nt4ga_link.h
index 8366484830..af7ea4a9f2 100644
--- a/drivers/net/ntnic/include/nt4ga_link.h
+++ b/drivers/net/ntnic/include/nt4ga_link.h
@@ -82,9 +82,14 @@ typedef struct adapter_100g_s {
 	nthw_gpio_phy_t gpio_phy[NUM_ADAPTER_PORTS_MAX];
 } adapter_100g_t;
 
+typedef struct adapter_agx_100g_s {
+	nim_i2c_ctx_t nim_ctx[NUM_ADAPTER_PORTS_MAX];	/* should be the first field */
+} adapter_agx_100g_t;
+
 typedef union adapter_var_s {
 	nim_i2c_ctx_t nim_ctx[NUM_ADAPTER_PORTS_MAX];	/* First field in all the adapters type */
 	adapter_100g_t var100g;
+	adapter_agx_100g_t var_a100g;
 } adapter_var_u;
 
 typedef struct nt4ga_link_s {
diff --git a/drivers/net/ntnic/link_mgmt/link_agx_100g/nt4ga_agx_link_100g.c b/drivers/net/ntnic/link_mgmt/link_agx_100g/nt4ga_agx_link_100g.c
index ad3398500f..369b9b601f 100644
--- a/drivers/net/ntnic/link_mgmt/link_agx_100g/nt4ga_agx_link_100g.c
+++ b/drivers/net/ntnic/link_mgmt/link_agx_100g/nt4ga_agx_link_100g.c
@@ -27,6 +27,106 @@ void link_agx_100g_init(void)
 	register_agx_100g_link_ops(&link_agx_100g_ops);
 }
 
+/*
+ * Link state machine
+ */
+static void *_common_ptp_nim_state_machine(void *data)
+{
+	adapter_info_t *drv = (adapter_info_t *)data;
+	fpga_info_t *fpga_info = &drv->fpga_info;
+	nt4ga_link_t *link_info = &drv->nt4ga_link;
+	nthw_fpga_t *fpga = fpga_info->mp_fpga;
+	const int adapter_no = drv->adapter_no;
+	const int nb_ports = fpga_info->n_phy_ports;
+	uint32_t last_lpbk_mode[NUM_ADAPTER_PORTS_MAX];
+	/* link_state_t new_link_state; */
+
+	link_state_t *link_state = link_info->link_state;
+
+	if (!fpga) {
+		NT_LOG(ERR, NTNIC, "%s: fpga is NULL", drv->mp_adapter_id_str);
+		goto NT4GA_LINK_100G_MON_EXIT;
+	}
+
+	assert(adapter_no >= 0 && adapter_no < NUM_ADAPTER_MAX);
+
+	monitor_task_is_running[adapter_no] = 1;
+	memset(last_lpbk_mode, 0, sizeof(last_lpbk_mode));
+
+	/* Initialize link state */
+	for (int i = 0; i < nb_ports; i++) {
+		link_state[i].link_disabled = true;
+		link_state[i].nim_present = false;
+		link_state[i].lh_nim_absent = true;
+		link_state[i].link_up = false;
+		link_state[i].link_state = NT_LINK_STATE_UNKNOWN;
+		link_state[i].link_state_latched = NT_LINK_STATE_UNKNOWN;
+	}
+
+	if (monitor_task_is_running[adapter_no])
+		NT_LOG(DBG, NTNIC, "%s: link state machine running...", drv->mp_adapter_id_str);
+
+	while (monitor_task_is_running[adapter_no]) {
+		int i;
+
+		for (i = 0; i < nb_ports; i++) {
+			const bool is_port_disabled = link_info->port_action[i].port_disable;
+			const bool was_port_disabled = link_state[i].link_disabled;
+			const bool disable_port = is_port_disabled && !was_port_disabled;
+			const bool enable_port = !is_port_disabled && was_port_disabled;
+
+			if (!monitor_task_is_running[adapter_no])
+				break;
+
+			/*
+			 * Has the administrative port state changed?
+			 */
+			assert(!(disable_port && enable_port));
+
+			if (enable_port) {
+				link_state[i].link_disabled = false;
+				NT_LOG(DBG, NTNIC, "%s: Port %i is enabled",
+					drv->mp_port_id_str[i], i);
+			}
+
+			if (is_port_disabled)
+				continue;
+
+			link_state[i].link_disabled = is_port_disabled;
+
+			if (!link_state[i].nim_present) {
+				if (!link_state[i].lh_nim_absent) {
+					NT_LOG(INF, NTNIC, "%s: NIM module removed",
+						drv->mp_port_id_str[i]);
+					link_state[i].link_up = false;
+					link_state[i].lh_nim_absent = true;
+
+				} else {
+					NT_LOG(DBG, NTNIC, "%s: No NIM module, skip",
+						drv->mp_port_id_str[i]);
+				}
+
+				continue;
+			}
+		}
+
+		if (monitor_task_is_running[adapter_no])
+			nt_os_wait_usec(5 * 100000U);	/*  5 x 0.1s = 0.5s */
+	}
+
+NT4GA_LINK_100G_MON_EXIT:
+	NT_LOG(DBG, NTNIC, "%s: Stopped NT4GA 100 Gbps link monitoring thread.",
+		drv->mp_adapter_id_str);
+	return NULL;
+}
+
+static uint32_t nt4ga_agx_link_100g_mon(void *data)
+{
+	(void)_common_ptp_nim_state_machine(data);
+
+	return 0;
+}
+
 /*
  * Initialize all ports
  * The driver calls this function during initialization (of the driver).
@@ -34,9 +134,20 @@ void link_agx_100g_init(void)
 int nt4ga_agx_link_100g_ports_init(struct adapter_info_s *p_adapter_info, nthw_fpga_t *fpga)
 {
 	(void)fpga;
+	const int adapter_no = p_adapter_info->adapter_no;
 	int res = 0;
 
 	NT_LOG(DBG, NTNIC, "%s: Initializing ports", p_adapter_info->mp_adapter_id_str);
 
+	/*
+	 * Create state-machine thread
+	 */
+	if (res == 0) {
+		if (!monitor_task_is_running[adapter_no]) {
+			res = rte_thread_create(&monitor_tasks[adapter_no], NULL,
+					nt4ga_agx_link_100g_mon, p_adapter_info);
+		}
+	}
+
 	return res;
 }
-- 
2.45.0

