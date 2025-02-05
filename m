Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D2ACC0219B
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Feb 2025 10:46:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4A8E840649;
	Wed,  5 Feb 2025 11:46:08 +0100 (CET)
Received: from egress-ip42a.ess.de.barracuda.com
 (egress-ip42a.ess.de.barracuda.com [18.185.115.201])
 by mails.dpdk.org (Postfix) with ESMTP id F046740609
 for <dev@dpdk.org>; Wed,  5 Feb 2025 11:46:04 +0100 (CET)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (mail-dbaeur03lp2169.outbound.protection.outlook.com [104.47.51.169]) by
 mx-outbound43-8.eu-central-1c.ess.aws.cudaops.com (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 05 Feb 2025 10:46:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ezylDBl0YyyiSYlwkxDlAb39W4pmYk5RAxwGJ30PIyLZN5AgXihAbLX+Dud0K4KK3FuZDB1tOQOx8esuxNsG1ObOKqZYiVqPWV/CueEIVbA8oTMT1SacT87fmj87G66C7hM7AMlhhqWhWQSJv2VrB0o3DG70ogCfyVrQnqprTOvY1yL71/DUaE9JoJWX24UZNh8I7j/JqeeFXZgj+F9P+kftRVLwjRGw3BlOJ4JfCvuvYDY6qyZ//AclWgNnfVclXeGrVDeGHjBVybMIcRly+MKEq6oXTkajqlQb7PtN/jauzrq+B1TERslseo+1JmdoBHEK1J/erHbghR5xlmNoFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zRKpFF+WF5+nMnuUeYLUsJI0Oo30HZfnbypT5I74Lr8=;
 b=hkjjaiwifGsgDX0dHGGghbKj8d1dezc6otbM7njehBxOm1mzZu7dkYve6wkybWz6TsenQBtC7EuY1tLtFrbkyri74kkX6u7MkTPurJIFJdzGcCS4mMjzVYaencfBXIA1zJDONaUI8mcM3p4vWppyVCzkJfd3ozoS58OW7ROTXl6K+CKFCEei5t89Udk4KX6/A9+gcdA6s5dPDyrciQAXY3DwtNUVcvo4A8q/FTno3c+s3zjSpBY6Pn1ckdSB1KVjrYpudW5ATyHxCIkVdHeKNFqvJvV0bv1eyrHQmTIH0skutMTYmScBugAbv9uijfFq6q356AjoiZYxv4HcpTpU8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zRKpFF+WF5+nMnuUeYLUsJI0Oo30HZfnbypT5I74Lr8=;
 b=m0dwE1ZJtFG+1p5seZX+SPud5MhRWU66aa5EyJTI0o6e07UgP9G9SZ2/QsgIWJQ+ks667XPe0s4+eEaE/OMxqoUU548eIJheJFmwKuirVg4+uWS9ssWrUBE5Ix4/y2zwDihfpFPSWQkmpCPX6D55QjaKnkzJSAFBbiJcwD4Dr5A=
Received: from CWLP265CA0357.GBRP265.PROD.OUTLOOK.COM (2603:10a6:401:5a::33)
 by PR3P190MB0953.EURP190.PROD.OUTLOOK.COM (2603:10a6:102:87::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.26; Wed, 5 Feb
 2025 10:46:02 +0000
Received: from AMS0EPF000001A5.eurprd05.prod.outlook.com
 (2603:10a6:401:5a:cafe::33) by CWLP265CA0357.outlook.office365.com
 (2603:10a6:401:5a::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.27 via Frontend Transport; Wed,
 5 Feb 2025 10:46:02 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 AMS0EPF000001A5.mail.protection.outlook.com (10.167.16.232) with Microsoft
 SMTP Server id 15.20.8398.14 via Frontend Transport; Wed, 5 Feb 2025 10:46:02
 +0000
From: Serhii Iliushyk <sil-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org, Danylo Vodopianov <dvo-plv@napatech.com>,
 Oleksandr Kolomeiets <okl-plv@napatech.com>
Subject: [PATCH v2 07/34] net/ntnic: add var definition transparently
Date: Wed,  5 Feb 2025 11:45:16 +0100
Message-ID: <20250205104548.1533554-8-sil-plv@napatech.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250205104548.1533554-1-sil-plv@napatech.com>
References: <20250121170814.3252171-2-sil-plv@napatech.com>
 <20250205104548.1533554-1-sil-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF000001A5:EE_|PR3P190MB0953:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 9ebd61e4-6675-4d80-5aa5-08dd45d248e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?b9QtFm/Td89MMqOMs+if0T/nruQqDdwCo4XbWWeWvpzTVa5L3Otr0I8fa4ZA?=
 =?us-ascii?Q?wJjjnWqoVSBm6I5b3PxQYQUQWgmTi7KtGDq6twtMF3YOXWvy4tERINUuDD/l?=
 =?us-ascii?Q?THEaTV+bPSSETwQteqTUYL2aDjpcvXshAKAf/6jo/N7YaThnxMwWa6RflGK4?=
 =?us-ascii?Q?6/uDeOZ8gBvrQJDenuOlBMFRN1nsmNi09rV95ehVhZUMFSPZIDJk3QT9P5oT?=
 =?us-ascii?Q?imYxbKz5e9NhJwkreFrO1kojSUhf7veojyefAQgFyTw4CaZojPrJKvU/3Q5U?=
 =?us-ascii?Q?3Odl21GbgSwDUQMsD76HVpAN7bD9w65bT+tXK7lnPHn0N2o0xgT8uAIQzOwX?=
 =?us-ascii?Q?5O7ug10mpML7n64LIdfFQl5WqBeJPkVyruarfu6/Hp5MXhrxzlFJmBxE2Tg/?=
 =?us-ascii?Q?23HL6PiRRHCVZ5IFjiRjN4WFsA6L8HWHG6nKnpBA0roeO+j9Cw8yUDrEwd0k?=
 =?us-ascii?Q?vgSXb0fa2sHIrR3khoiZNod6o76GztjARDzpsedPyaCBRIuVUB1YJcEoALvm?=
 =?us-ascii?Q?boN3Sr/PFaKbkXXCmoMYNvJLerdBj9o6mNjEAB9wErC6EEo1Ux+ohMq4dSPX?=
 =?us-ascii?Q?QBLnjWFAj0S9MhAiYKvEs1N/mU/hV5op6mKKv1t2CBwfHT7uI3TmRPr1pUEb?=
 =?us-ascii?Q?gyHHW8uwD7o653dJbiJOw/x2K3G2urJcG280J1+vUsDsqEqfPGzN5Lmmc2ci?=
 =?us-ascii?Q?OuiGrQVIh6etO75AkfHmO5A3cY0SqPCUqaNZoAxResD7rZNiwb8fjFxpRqfm?=
 =?us-ascii?Q?Ah/4hqCKrbqlaDys2BE+Gi+QyeuTN5TX+PL0waQuPl4Mv9z7F4E6NDO/Buh/?=
 =?us-ascii?Q?Rpo1BWgAIOV/bO0mwC+tA16I79deJ3TK0iFkRfz8gz7GLTCPjd1OOaYfhhvX?=
 =?us-ascii?Q?6GEqUjqt5uZEbAcG95d3SFCgj8udp5p4Nm86Gud9asK+lzCxrHl1ihlX8B0s?=
 =?us-ascii?Q?dE6aE9SfGZXzG2PMIoSNi4SMDQbtJRbRDLMEiTcRbGf9j+da5/DztW2UFVIg?=
 =?us-ascii?Q?i2vU+Za0t9UL6/Epem1fOElU0Ikyv67p3Q5a3AMvp/Zvt3JChuHNvStlqSH3?=
 =?us-ascii?Q?nssI9W8RbupsPP6lYZ6ZBuR/2ZcMjq8YeF+iVRVj1tIan2Rgl6vl8VaR1OzL?=
 =?us-ascii?Q?4LgSq3TnYPUDf2dIhbfzywzBN81niuSt19OjrNeI9iRX4Jr0xJZFwPMt5HzO?=
 =?us-ascii?Q?hFjorEiokEvHu9xLroFZgE9wltynrLiEce5A/NceGlUCcnMT3vd1uQ/25EsK?=
 =?us-ascii?Q?jT9MljJA9/i2Lx9iRidAw1G70V9y1mPBgLPiIps5MrhXBFngd5SNzpeHk3U5?=
 =?us-ascii?Q?QyCFTz+hY/hiFCN0g8GFbJH4Se1MySbJ734RhZHT76WTlx448OI9zYYrUSZZ?=
 =?us-ascii?Q?hmebCXAooLeviRwPBlpGY/xvoIvMYCGvzbCF2FJ9hR6ppQ3+A4pfKaY93DMR?=
 =?us-ascii?Q?/PmVkEejC+K/al2skiceMez1DrKvDt7nfFCNd5ofhar2yfhDMrL5mg=3D=3D?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Kz4MgI2YIAOYU9KGzbJSjuLL+XYaGBh9tYr8faHlzTBDkSXtQK+nY2QBoWfgYwP6AAih+WMMEUnMGG5HpOwZAZQ/gjiAHh6nCGhmzLeW9Ch0CXgykWalA0vK/pq9nUahAn8UEqUGzrx8j0bUbv8mktflKJwSYwhwTgDCjriDXNke6d15vT24LZjKu4I4JG5QWLrCAOCYbsX+zKFrHwI1EMDn8t9yTHALpfipzArO8MNBy49GbdaTtmEdAEg4PRi2oKSQ0igtaA2zgWfOC3MnRS+ipEdmmkmWTERgGy5L8zG2eQ+ZG8v+1j7fi1GSzNbavyB0l/RvJ1ppHrhLGCfHl2NtADa3CKt2Fr5kybcyZcqu+/SEKqULfMM/DMYEz1XQgbfIazFCojbX7qvVDAM/my2s6onpW4vgVy6d+P/VclzC95hkCEWB5jFP+e1enx66SeLBGkR51OBebuEYmEY4p8uATasewuaT1a4VMMrDglrMNPjbdt5cS46Ujvm5mbItw9BftlbhSIXBAyGGjiCDJ8PiGJfXQBj3xd+oQF5/XBUq6Pc1yUsuGGeHb8aIKCTWnGFP0S54M0pgNdSZTcLjc5SbUMbidUbfnf1KCF0nZQzHfqJYjF80z3y7rQisebrx6h7/9A8WW48BI9fwtVoaeg==
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 10:46:02.3395 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ebd61e4-6675-4d80-5aa5-08dd45d248e8
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF000001A5.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3P190MB0953
X-BESS-ID: 1738752364-311016-7905-614-1
X-BESS-VER: 2019.1_20250203.2302
X-BESS-Apparent-Source-IP: 104.47.51.169
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVpbm5kBGBlDMIiXVJNXcwCglNd
 XELMXAMik12TLZ0sAwycQ4OdnCyFipNhYAHob84kAAAAA=
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.262304 [from 
 cloudscan21-135.eu-central-1b.ess.aws.cudaops.com]
 Rule breakdown below
 pts rule name              description
 ---- ---------------------- --------------------------------
 0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS113687 scores of
 KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
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

set eth_base to NULL after freeing to prevent
use-after-free

CID: 446746 Use after free (USE_AFTER_FREE)

Coverity issue: 446746
Fixes: 1d3f62a0c4f1 ("net/ntnic: add base init and deinit of flow API")

Signed-off-by: Danylo Vodopianov <dvo-plv@napatech.com>
---
 drivers/net/ntnic/nthw/flow_api/flow_api.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ntnic/nthw/flow_api/flow_api.c b/drivers/net/ntnic/nthw/flow_api/flow_api.c
index 82d4e34ae9..d25d1a3dd1 100644
--- a/drivers/net/ntnic/nthw/flow_api/flow_api.c
+++ b/drivers/net/ntnic/nthw/flow_api/flow_api.c
@@ -385,8 +385,10 @@ static void flow_ndev_reset(struct flow_nic_dev *ndev)
 	}
 
 	/* Delete all eth-port devices created on this NIC device */
-	while (ndev->eth_base)
+	while (ndev->eth_base) {
 		flow_delete_eth_dev(ndev->eth_base);
+		ndev->eth_base = NULL;
+	}
 
 	/* Error check */
 	while (ndev->flow_base) {
-- 
2.45.0

