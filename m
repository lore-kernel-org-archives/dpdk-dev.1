Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DF3CCCA471
	for <dpdk-dev@archiver.kernel.org>; Mon,  6 Oct 2025 08:04:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3112740608;
	Mon,  6 Oct 2025 10:04:39 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazon11013068.outbound.protection.outlook.com [40.107.159.68])
 by mails.dpdk.org (Postfix) with ESMTP id BBC9640613;
 Mon,  6 Oct 2025 10:04:37 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ghMAeb7QWvAS2qOJIA6HuzLTUbYiB0xwP26Fgl1wxY8LtoCxJ2F0+Eu1PxT23bQpmVXffhFeKMSsdkF4+CDRzJnkyv6Mctfw4AqtPLjGcdolxZr9IvbUsywRUsVx1nuQvD2SQVTLxND+nP5HVcYm8xl1knEI8YXPPSn4P8quVs5E30Guco6zHM+YZ1+s+Yoik2hldHgU37HChWuvraW2wfziNuzRO3EX+aUqF5fxWOoNXhaUkMtqxv/oiPwzVZMdqu9Ect1Hp653Yvd5Srs8CFdsYnb+BcgQeueyBjc+rAWgFkyaY9Dg6MMwo40D0gYRyuLWjkXpAghi1DbW3XZ9bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DibKo4OqZJM+UTha19dpDvY7ydRzimBdKpmYHuZHszw=;
 b=THll6dqRoZvjn1JToD5rvy846HM6MdKPNc99K6XMsGVpPckxi2ZKWaIeLh8SMgjqGrjTBwBOYB2elsUgK+v7wteNO8Nwf7GMDTRYiXnGAI1SHIKnHxYNw+ID/k3NTLo8FLHAC/GmwXvO8D7JrrqfjJkaRTiyG1WZ4RUITl2hQdXRRkXcZunOCoHNOYmnhfIbtJQZ90kuMaSlUWF7t9MLneucVrCKGil2b+SxJI9maSWYVlpWvXngvCj5wVzItuwYoujWo/KIqKRokB24mvX08qarpUtYZDVVygW76n7ox0czmYYDW5ASsXmsj6jF81W93MvXP/AyMPoFddzUOntPkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DibKo4OqZJM+UTha19dpDvY7ydRzimBdKpmYHuZHszw=;
 b=PLAcmH+SLmYMpcdXLuZhV4QLGnry3vP/9ZT3IM4luMJja0nagMuKvzstmflr/bjVhfAKL2A42Okt/NHbkcXujtrNqx6cX+6lrxINY+6Y+J52HtOBMpEJB7c3+lnhMlCjKdy/nYwimmt8IzP8XnGokgiND76htoqLx0Aiygn1fHnxXqNL2u0LcocKVahXjuLJorNIVtOoctymaehJIwXcy74ba0laW11jzMKxR3o+9ACggy96FNcscrupfHrkGplFZ8ZTsYiN/AMvyIiwS42e16pOC6Oqv760ifRzC2o1nNrvW3gaRQouvxb0ZPnNKoWkm7zjcTRlH4b0uQ41GqZ6jA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9328.eurprd04.prod.outlook.com (2603:10a6:102:2b6::15)
 by AM8PR04MB7842.eurprd04.prod.outlook.com (2603:10a6:20b:245::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Mon, 6 Oct
 2025 08:04:32 +0000
Received: from PAXPR04MB9328.eurprd04.prod.outlook.com
 ([fe80::f268:adb3:8817:15e1]) by PAXPR04MB9328.eurprd04.prod.outlook.com
 ([fe80::f268:adb3:8817:15e1%4]) with mapi id 15.20.9182.017; Mon, 6 Oct 2025
 08:04:32 +0000
From: Hemant Agrawal <hemant.agrawal@nxp.com>
To: dev@dpdk.org,
	stephen@networkplumber.org,
	david.marchand@redhat.com
Cc: Vanshika Shukla <vanshika.shukla@nxp.com>,
	stable@dpdk.org
Subject: [PATCH 02/11] net/enetfec: fix out-of-bounds access in UIO mapping
Date: Mon,  6 Oct 2025 13:34:01 +0530
Message-Id: <20251006080410.1433284-3-hemant.agrawal@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251006080410.1433284-1-hemant.agrawal@nxp.com>
References: <20251006080410.1433284-1-hemant.agrawal@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0036.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::20) To PAXPR04MB9328.eurprd04.prod.outlook.com
 (2603:10a6:102:2b6::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9328:EE_|AM8PR04MB7842:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b7210bd-dbde-4fe1-16a9-08de04aefb53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|1800799024|366016|376014|19092799006|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?PaBgPeAsV6WNcsKnut3d/cBmpJtSlHBofKj6Gfyv9T5jogMbKZM6tfs9AMxI?=
 =?us-ascii?Q?LjPzysKt4c7oGtsVogyvAlrP3avuMGucXK3wFCLgHwD5xX1zC0nB+a93d2jB?=
 =?us-ascii?Q?TnxAe8PH2dChUr2XHgNBPLxUr5uMxXHE1SHs2PQKjXfIHQ2XuVowfzrAQwMP?=
 =?us-ascii?Q?yWpAVr/We82ReQBDSB6sYsn2DfFSrIN0moPpqEyyrsYzHIpkuCY50FoUMzfZ?=
 =?us-ascii?Q?eXAelBJABAfov9a4WW1T7HyqBRelPBDG6mTntgHygrvnmrJa1wimTtMr5LtI?=
 =?us-ascii?Q?d6eUzLGpr3+QczyQ6KexrYK0upEcr1o1Mw8d3OWPUMiV89FCedrOQkK+qLQ0?=
 =?us-ascii?Q?Dh0ra+ApH8PKa09lFJ27R4ZrJassi0EHIZIj5vyQcUBvqXPa21eqpspHpsjn?=
 =?us-ascii?Q?tr5Rw/nkq7nb/NH5t90JRGkvl6uyo0LueTPvxrLvqxjj9pJLyrtDHv0E+EGE?=
 =?us-ascii?Q?FFxhabJB4qZB0fa5XpkfL+CPUjwhcHUJkO7vnNnQ6xUOwaUYNFi6dOmbdElg?=
 =?us-ascii?Q?Z8Wc9qQTmobmZYLPr/kFZR/SZzAl4rRmbsBrRih+2+Ssr2UnOyGugMcuWSrn?=
 =?us-ascii?Q?HVuSmkbd9TXWg3rJHRfL//pPRHbD4wyR4qAP2k6FujhHG+poEhTdrjZLEMBQ?=
 =?us-ascii?Q?PWzmBd+kxfd6h6eRer9MINhkqs/I/uQFhsL2Jb8610+z4SEN+dt5bwm8AItw?=
 =?us-ascii?Q?rJlKm0wDVABAfWsHLeEX/8Hp1UBrBQoMB+xN7EON9A6DWHqvu7PIjpsfLm1y?=
 =?us-ascii?Q?kseCeNLHD4pQkKopoZMpKN7B4ddoMFcWaW6R81dNEsCSr5NWoTTaLnlh45Ey?=
 =?us-ascii?Q?AGc0v0JkPkDhf/mPOrEkdMSKpecDclFkLtTzhAluN3EgQ7jCsImWSOA6bajL?=
 =?us-ascii?Q?3H2DAkXCormfV1pcH9JVVj3jGM79dW1Dg3Z3m9Ah78YzGEeGMd5F/aIfAuTf?=
 =?us-ascii?Q?s+1HNMIQL4pJ55UQDeS+hEHiyJcwljzZgKYHjIlN7RmPJ1jzBIED9igcGYIb?=
 =?us-ascii?Q?Lngmm1o1KxxyJiik/qRIXQ9fmwOlxYLO8aJ4UgkUpHpjoSMJ9Ato8H71xsgp?=
 =?us-ascii?Q?MS/5yLp0eW0naFc8BAO2WiFh7CayB7P8lczgiN3CTaUXG1b/mxLGAWiuZ4hz?=
 =?us-ascii?Q?mZyGbg8XChnICo+UeoBh/7a40HLBkVRij2K4rtMVr6kcFm/dwhLthQgCeRMr?=
 =?us-ascii?Q?Atve9nLxc6QNzF8vzHU15vNtsij2R3Vz2Sc51Jq/oepZLWyMo1Um3165ug6A?=
 =?us-ascii?Q?jYAoPndeaNA5KgZSyczhr0QoZA52NaK5YyvIHp5Y3lmDWeLFY1SJWEuS14o2?=
 =?us-ascii?Q?QWox93+Xe7AZ9lysS/cDH6iYFmQyPsoNOAj84HT4L8W1fmegpU0z0lAfVEHb?=
 =?us-ascii?Q?r7I7OPRurIWBa/aVG0+5eK4IZVyVStjNHGROgO0dojueRqxGOguQMo2aAMUb?=
 =?us-ascii?Q?AP1Vru1+hkhHXcTV/J1BFHu7aCaeljWEE7wXm7sulkNYJWGIy8etlMTzo4Rw?=
 =?us-ascii?Q?5s8Id9phXDK3X9C66d3YQMGjBl83vwuoQkyl?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9328.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(1800799024)(366016)(376014)(19092799006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?w7PJuCbRGJE2hrVo+8QQUA6cBrPSjzYqu7WTtIwHiXO16lD4aD3Gv0zZ/ylN?=
 =?us-ascii?Q?9/e8uWDV3n7s1ysnJ2fhdGeUVGaYs+QuRV3p7fdxO6r7zDBePV7FUuTzzdoY?=
 =?us-ascii?Q?NUbQ47NzVZNgiosH0UjAXLrszehvUmr9BJOwpJwAEVhr23B9nAdbEFeX//fz?=
 =?us-ascii?Q?hMFHMpYWXGPnM30o5i/bsYLPnQvIwzY3wVHtczbv7BxQrjBjCjwDSQT7eMda?=
 =?us-ascii?Q?wyUS2Gu+6yiWiwudaqtZj/ddKuqqZfhjx89xOwRMqY4CxKJ1VhCiOa8R5Ddz?=
 =?us-ascii?Q?hucdtTrrcAABoit9sYWYSirBR8f5VBC21Q2AKkeUDDf1wMtlhBfP9gsX9W12?=
 =?us-ascii?Q?ZqWaK9R+bToYd+65othrTzwd5S+wWTraPgTJNSjsU0IJFuOJhuOu8J3wvWBT?=
 =?us-ascii?Q?6HeMAgcQX+uVh2OCsgjq4CE8X0nKFIK0E3Gpd1p6WGaaZP7zBjwpL32G7/ha?=
 =?us-ascii?Q?SE4T51o6JdaPW3oc9IXYA/DnJHKGpUoPqlfbP/mnTj92iGo/9wNQv9sickYt?=
 =?us-ascii?Q?sJirYkBTZpvcjSzbsr4JVsh5clXjTI28t/EWzj6OOvTHvhfeULw4YIqUqjdM?=
 =?us-ascii?Q?TN4tVzeWpVrN+uKKzkp1pjz9P3SiiHvq+rg8bi5ECeAOUFc57ddH890rZmlF?=
 =?us-ascii?Q?IvFdKk3t/QG7ORBU7Dz5w84vddYcUwyIKIePyQJaxMV4XXAW2y98zfqZvCNI?=
 =?us-ascii?Q?9Uw2l+ngv0ekGCdJpb1oMhxc9Nh8dXLvsLWCFmYIoksChnu6pYR5YTyHtW/Q?=
 =?us-ascii?Q?iN3AGx2ZuhWKaaTdiaTGWVfqVn3lJ1EqDetIac8PxjkYB7SZe1Q0FaGIpsHH?=
 =?us-ascii?Q?qrv1GknJaAW+F0z9SopVb+Cc4MZ0CIBFwuD5z/QQ+9fkC4WJgQqaLgxaQLeQ?=
 =?us-ascii?Q?r6eOc3ayDxSwu7LtTtMJZcsqEhUAYb4+g8FbwjDHzxnJmROmOLJsZKfmG2dY?=
 =?us-ascii?Q?W5qNioKJGFZM7X4/Dx1uXCHLtyJv4q2T7oAkyY5dK7T+X/mfOIN7Q97Pdhy7?=
 =?us-ascii?Q?7rDQy4DBQyizem/Wgj5VQ9FmxY1G8wRTqJIt2T8lKAxsrynaNWtOJMWdK4KC?=
 =?us-ascii?Q?Y9QUn4rqjJqwC2RY2wF+Z8oefzMCxL0AfaXafXsReQct7G6IqXNX4aoTP3mm?=
 =?us-ascii?Q?ucnlVvUr805xxXuQw4T7fE+/FyE7BvTMrWVsplSHC6j1+sTbrD0bftTaK64Y?=
 =?us-ascii?Q?76iMcLYuQANHpoBRLAhO2bzgKpc/NEB4OPkB4bc2kZ4hctX496iFVzGka3BM?=
 =?us-ascii?Q?NnBEX8nOELjyvS3giew6vAPcO+cOpVXsD9J9qE9OH6vUm4EK+kT4vBg/3c5U?=
 =?us-ascii?Q?/wKCK1sK+EioDLwoFrFCHtCXrxl1YaIFdqI6v7FdeVJfipJuVBB/z38IUjjn?=
 =?us-ascii?Q?UYfeCGRoKAcRCE5EfmvceQa3LUUCOvLM32Jo7dTm6mOIe3xeb9PwY2QX2g++?=
 =?us-ascii?Q?meU9USdJheg4CZ18mpMiIP0TcaPIDfhoS6PprVM1jTpdH+4MevuIWnfTfOL7?=
 =?us-ascii?Q?uwVO70Ux75wzVSNoPl/K8MhCNm2q5wyKXdJ3sc9CO+Y4hr4cyV7nLeSCteJ/?=
 =?us-ascii?Q?2+WLpMCOzE8cdINGF3bzDchoYO+8osZ1nWHf5Wem?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b7210bd-dbde-4fe1-16a9-08de04aefb53
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9328.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2025 08:04:32.4207 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wypz8BkJy83kve/GyJfMrUnUdccY/tWYduYDVV4KuY9YnY4zIDEb+DYVj82wibED0dYfejvT5+h0+F3eYEw6tA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7842
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

From: Vanshika Shukla <vanshika.shukla@nxp.com>

NXP internal Coverity flagged a potential out-of-bounds
access due to invalid mapping size. This patch adds a check to
ensure the mapping size is within valid bounds before proceeding
with memory mapping.

Fixes: b84fdd39638b ("net/enetfec: support UIO")
Cc: stable@dpdk.org

Signed-off-by: Vanshika Shukla <vanshika.shukla@nxp.com>
---
 drivers/net/enetfec/enet_uio.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/enetfec/enet_uio.c b/drivers/net/enetfec/enet_uio.c
index 23cb4e7e93..f32d5e1b1e 100644
--- a/drivers/net/enetfec/enet_uio.c
+++ b/drivers/net/enetfec/enet_uio.c
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: BSD-3-Clause
- * Copyright 2021,2024 NXP
+ * Copyright 2021,2024-2025 NXP
  */
 
 #include <stdbool.h>
@@ -142,6 +142,10 @@ uio_map_mem(int uio_device_fd, int uio_device_id,
 	}
 	/* Read mapping size and physical address expressed in hexa(base 16) */
 	uio_map_size = strtol(uio_map_size_str, NULL, 16);
+	if (uio_map_size <= 0 || uio_map_size > INT_MAX) {
+		ENETFEC_PMD_ERR("Invalid mapping size: %u.", uio_map_size);
+		return NULL;
+	}
 	uio_map_p_addr = strtol(uio_map_p_addr_str, NULL, 16);
 
 	if (uio_map_id == 0) {
-- 
2.25.1

