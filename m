Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0A54CA1009
	for <dpdk-dev@archiver.kernel.org>; Wed,  3 Sep 2025 14:24:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 06553402BD;
	Wed,  3 Sep 2025 16:24:21 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazon11013032.outbound.protection.outlook.com [52.101.72.32])
 by mails.dpdk.org (Postfix) with ESMTP id 7E26240281;
 Wed,  3 Sep 2025 13:17:27 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wNVQWQrxhlnnNHC9Kke9rbxmcXdJMMt+0EAI0/543QKCnKlRiMk8ol8apeCy/Joghfxh5tg6EtVV04AEjMgKs2YUxt2Lld/1nHRJbUY88nRwuOaBfkdqN0TKwIoUA6AwYioQG1JTBvOGTeu1Q8XeDeVwnJFb8AzlbrfgJqQHfV6ap0nQwJdd/pbfq0s6IiXM1TG1xewergVSME+vADcyxXJyw/ZCa2p0AFuAJFno2Lyx8+J1bmXH2S78J+AmWdEqX4cmftP4xVOBlaGnYf6Tk0MCX3hzdC8/nN7GUfI7NRBEY0jYLzyW8/jmFQ8f7d/bI+386Jo5xChwfcdUybsA6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RMTU0iAjQcON5RCCxdxyfEujTJdTp28ZubEo5GN7pew=;
 b=LDX1q63Xkn3AxVgmIweTtCSkGbNpOIMeexnGLa8uBz8LRjdTmOE6zdfI7vOk4Cq8A05AF60nS3WwlxwY+pJNqkArzPFk0dhKRWVxrO2PB7n0Zh+8xWD1xTZPk3CnEUdO3plP1Ng8hoxnGZfMIzVWCa6dT3QmBHOW+UrS1tIYkhyAKq5F2aXmS9MPw304UFpsKeBu67dEmBgavKiQZwEU4ga6ZM75v1n4uZ5uLmQEw1KKMvU1RISyyoGo7UtpE1PPWav7pUGJGOJux0L5TtHK2SCJxbTrvov7hZ3dbQs1b3mLAOXkepK2B9lOOSYxL5ZyA7JkngLe1XYQO6ftGgNi/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RMTU0iAjQcON5RCCxdxyfEujTJdTp28ZubEo5GN7pew=;
 b=epG7jto2QPEYDlHWOnr/NMq6cBzHU+C4UzDH8VarlVjDLVlxn5xrNLD7ByPThfyGY/7OysUUMYpdgjzN+bb7npV000Va1GdKS7RpflJRhcwGgdm+1mhAFpPdk+jvjdhs5YHBQa6ElCtBl1IwdXqdnNkCYh4AKVpjNoiaZbQwvjoSxNWruLPN/fs7/fbHDYWk0IveOIHatinYTLzcdnWtuwbWVnva240hz+JYHLtObdZFPchJAycru6rQllNzu2GlBmIoxseFM3FWkwBa9M4VQtbIlhMuGo/8m338zlK4ifqtaXM8NOW1E1N46rSHdhxsPL3EFM7FP/tuzhPMc5LV2Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
Received: from PA4PR07MB7424.eurprd07.prod.outlook.com (2603:10a6:102:cd::11)
 by AM7PR07MB6836.eurprd07.prod.outlook.com (2603:10a6:20b:1bb::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.29; Wed, 3 Sep
 2025 11:17:26 +0000
Received: from PA4PR07MB7424.eurprd07.prod.outlook.com
 ([fe80::34b2:3abb:5dfc:2137]) by PA4PR07MB7424.eurprd07.prod.outlook.com
 ([fe80::34b2:3abb:5dfc:2137%5]) with mapi id 15.20.9094.016; Wed, 3 Sep 2025
 11:17:26 +0000
From: Thanushree Sreerama <thanushree.sreerama@nokia.com>
To: dev@dpdk.org
Cc: thanushree.sreerama@nokia.com, stable@dpdk.org,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH] pci: pci_vfio: Retry vfio setup device reset,
 if device is busy
Date: Wed,  3 Sep 2025 13:17:23 +0200
Message-ID: <20250903111723.5111-1-thanushree.sreerama@nokia.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0020.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::21) To PA4PR07MB7424.eurprd07.prod.outlook.com
 (2603:10a6:102:cd::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR07MB7424:EE_|AM7PR07MB6836:EE_
X-MS-Office365-Filtering-Correlation-Id: a99f53fb-bdf0-4001-806e-08ddeadb7662
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Lg8cMJUZ1E+MWy1hLDZMjlXMytPAYQp81bzpmdKF3uZ7fLYXQSrNw6lD7MkQ?=
 =?us-ascii?Q?tZyXXs1X3Iu0WcQ8dXy71HQmnPOi2+RCcq1LN2pO1GeG88FdpFNhSztcboce?=
 =?us-ascii?Q?TAemrmkrY1LlOvEpxH3scLoZ6/wtG79KiawoWMLAu5ZJHvtDf1ToARP3SgJg?=
 =?us-ascii?Q?lJwg+ETZvCjPWGXgefNUpxLb3h804XgRNmuFNlNeCUutGpzz3ByqMZ3hs8Ip?=
 =?us-ascii?Q?xjz/NL8OHP8ZYd/PdtjUCieYkAc7p7b61FRuWqJTDd8i+78tttp2oRi3ZUWe?=
 =?us-ascii?Q?kkBWcHN4JtS1FcPKzmUEfKkjKvRviWGoGi/qhlAKI15YsXUGK41wQKT7SzDG?=
 =?us-ascii?Q?FAxzU7ZOIv+xf+1EYmC/4AKXsvWX0RT0CkU4xO+3pHm9hs7NAOdc2dGg1YIh?=
 =?us-ascii?Q?428srCVRmw7NeJbtCYSJ9VnaEyvR/2n8/ou8KNzuEh3hCqOiDp/f0GtCKZIh?=
 =?us-ascii?Q?Gy37pxQ3bCnwStH9r+9fRGJ3HAng2TkCu4TXLTkprmGzPfCbyXeX99ur/Gzs?=
 =?us-ascii?Q?jCb32vcobTJFQtvLb5Lu/lRKGwosN9G1mw1a6pvhs5svIUfykhF7bUg/KWuq?=
 =?us-ascii?Q?R3mLgvSSNpQBp0fx5i8CUVtgT9gI7qPhmccvJGt9w2uZ3amH2HXMnvJfPLQI?=
 =?us-ascii?Q?dlyOeK8jaxW7sS0KmgLcLJvXYiAo7FLNSbKSj9Nlk9+SXqaFVQIxiiVGIfmR?=
 =?us-ascii?Q?F3fVSEHARPN/Vbx0LVTxM2Cg6y0oJf55i1woX/FI9snkEKeeXMkGLUBMF/9Z?=
 =?us-ascii?Q?uvZzWSkiwyj4DDVMz3E0nE9cQPDf59QTKXagKy6PHioVw/0JAG4e6j68H/Nv?=
 =?us-ascii?Q?w7MhhCu7QmQxjKNz4FEH30erUbKLl/btZ6EGWs+QPOFHr6Lw8j/IaQlzqxfl?=
 =?us-ascii?Q?9r6jm0WqVXtwVq/4Ek3EZ6Q7XhldvlCE4y2k4OYdpOO7+EyI247OodhbFGxT?=
 =?us-ascii?Q?uJrX+oDn5XU5DvH9pVUPKdq9x2Oo+7HE6bxXLNAX/P6LRkbAQDGZ+w31SRwX?=
 =?us-ascii?Q?adiecHc0z5swApJSMz8nV209Cka+/aUxaxX4KBcU8NX49dktefPJkAyzTEXw?=
 =?us-ascii?Q?PWAUT7n6UtFO1VU6xpLVqBTRpvUBQhsPMcbEtwc8uh0lCgt4az/mOOEXo6NX?=
 =?us-ascii?Q?34UDAUVsr0snSKPWPPSbCfP2id5x7IExm545tHg0dhj2kVGc8DsnocxIf16w?=
 =?us-ascii?Q?fVqphoFdefqKWPfCyVJYBB6lpYZqr/TVQKJFuP6ZsJOcDHDTOBNVA4NY7ScN?=
 =?us-ascii?Q?2VW5D2HyuInwGWZ3lBC+iMsxdQPMGoOSMkSwxLnGjAE6GglPPaT+JDbV11ZC?=
 =?us-ascii?Q?F1xVAiTcRPO4hlIAtPHCZ6aTdFUJqC0eQV2Wa9G48jksoa7y+wPwqi4WdEtw?=
 =?us-ascii?Q?Y9JEqkatxe6hIM9t0BbblNXEbJJEgMPKf05YPHxW/B4hZREhNA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR07MB7424.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1AcMCtas4BuMtoxXORNg3K5s0zK8ePqcJ2o+kPelr+2XzadEzEHpDxMhyD0a?=
 =?us-ascii?Q?qQSdOXpA557nJmXGOq7TnDHnFFc27q6tee/fb9dRPbwKWDMe+FTUbosZ4qPZ?=
 =?us-ascii?Q?SCmkFYfonFYYAOwGrHmbI0xp1YFEBx2jz19L9k3F71GxaMI70/IOyv4zZ1P5?=
 =?us-ascii?Q?00OcwC932c7bZlRhGsUc6wctek9y7q2XRByf62Zm2oW9VI6I6FuOytm01bWk?=
 =?us-ascii?Q?awZ98wCc+cT47wnjw357s17Yauz918E1A0/DBt06rT3C9zyWGzdJSaOnQxxQ?=
 =?us-ascii?Q?vHak//EfZBHjl8d58FF4+4Gxc6288Vog+eFWkJiVVRz+RDQPEr4VI5qRfQHK?=
 =?us-ascii?Q?nrb44mS8O54C+oMRgHWITFxDeUkbjSjtTsyg34pVaWlbQvcwsE0HGA7BSvVi?=
 =?us-ascii?Q?7Wi6qnU0DxnMTZQvag5uuax+Aiqn2gyz5FRZbMUI1GatsgNbCL/CMMCqnb1/?=
 =?us-ascii?Q?V985kgv+FDZXRXGQIMWfegoU6dYeLSz7dlHa9GK09jlCEy41muRx8v5CRbA2?=
 =?us-ascii?Q?x4W/EHgoCSbfoGX+aM+XDx9tjy8hWJAgY5jBuxkhwVG3iXTmEGyFyj8NRMdW?=
 =?us-ascii?Q?+cyx1uu+R+zfXvEppxQQKRRK9LTVMjIuTbjy4EwZbmrDpyxqD9q+qoSEyCJk?=
 =?us-ascii?Q?Gy9WXiMMyaOYX1SEY83O5bAtYZfyn/oqkYf/ISy3oHTshiB9M8jdU7sRl5ra?=
 =?us-ascii?Q?5u0nqq8AM2HRGkuHmgMbquiNzZelXN0cQ1LtDKmhttPlrLWeZ4qXUNYEkOFM?=
 =?us-ascii?Q?gulXRUEOcFcw/0VI3S/z9zXGR2YzA3gWNT0SAbeiFQ/XhodaAfoAlkAVLHVn?=
 =?us-ascii?Q?pk3HnSQAMAvMsn8h2Degq5Cdr9hItWiNpQMAWXRZiwu5STIu952sG+NGh1OA?=
 =?us-ascii?Q?sEGN28yDPcog+JT2N7pfEVSk2cK6wF86KFUzNckER7vt1NN78eixOkA/NJJu?=
 =?us-ascii?Q?kVAB0gCi+1zeRacy8lMRSfY/X1bvGgft7YKdxvL/3MMINCbOE6tPL1RM6ljQ?=
 =?us-ascii?Q?yNPYhwdR9v3R9GqTzDEqyvRJ9N+4KIDaeo4SCGkTMcLPY4G25EqOzkgbURYk?=
 =?us-ascii?Q?gnRuzkof1ZZNAwhLqVioXRzm11ZHq4tTZu+adB7S0YF6q9rV4PDujwDnFTug?=
 =?us-ascii?Q?jNBUmDsJmq2nHCwmeJxVlMQcxIaAc0v+w7wBW23av+b9O4FNZndTL2AHY5nV?=
 =?us-ascii?Q?1ws4hfY+R43RNf3W4JxG9PL9Pvdfgs0YtY87eAtIjLGzHp3lY/6R8RgK1Ki3?=
 =?us-ascii?Q?Nj5/PZ5SlzpaVXm/9MYd3YELmIrlU4IlX6tKX3tDkoLonMntmBZC35McSgbS?=
 =?us-ascii?Q?Xc3m4qZiuEpRGI4aOYB/IlD6o/WkvxYSPTo4mFlhRsHxcD0pT70hQQn7qy3/?=
 =?us-ascii?Q?3MRE1A9g7OycDTFudbDJ7xXjptmhe0QFFz/2MYtx6aZHtg36GpqH/hpwMjyj?=
 =?us-ascii?Q?xAqhxmPA8UjnxxPSQYLqwN71n3IlEzysJsGoB+jpFw+Gg9p1ayyUOa9xKzpl?=
 =?us-ascii?Q?yBcbxN3QgA63S6X+ROuGE/Hw1IG0ndOfM3eklnhRho92xpFOsFqNILpR+x0B?=
 =?us-ascii?Q?8BwAuOrhXwbVduYVfCSkQk0wyn/0Xkorc5/BnWMKi2OXo5nUvW2eV5ytn6da?=
 =?us-ascii?Q?AEqW7Nco3Kmq7uWXxlvlq+w=3D?=
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a99f53fb-bdf0-4001-806e-08ddeadb7662
X-MS-Exchange-CrossTenant-AuthSource: PA4PR07MB7424.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 11:17:26.2585 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M+abVBWDWhcXR+g1IOS9HeQgxDqYaFqet3JojVWtMouPa7R+DoS8LkYNwHiJG5PLhwxHe7y9wT1D1eIniBjvWTeFyKV9gTb61Ai3PgHl3Ow=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR07MB6836
X-Mailman-Approved-At: Wed, 03 Sep 2025 16:24:20 +0200
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

From: "Thanushree.Sreerama" <thanushree.sreerama@nokia.com>

Add proper EAGAIN handling for the device setup by retrying the device reset

Issue:
asc-0a Disp_0[18237]: EAL: Unable to reset device! Error: 11 (Resource temporarily unavailable)
asc-0a Disp_0[18237]: EAL: 0000:f4:02.3 setup device failed
asc-0a Disp_0[18237]: EAL: Requested device 0000:f4:02.3 cannot be used

Caused due to:
92d847a35e1 ("Revert "driver core: Fix uevent_show() vs driver detach race"")
Cc: stable@dpdk.org

Change-Id: Ic3ae8701fccdbf1e8e2a575d48e707b4c58e939a
Signed-off-by: Thanushree Sreerama <thanushree.sreerama@nokia.com>
---
 drivers/bus/pci/linux/pci_vfio.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/bus/pci/linux/pci_vfio.c b/drivers/bus/pci/linux/pci_vfio.c
index fab3483d9f..20e212c9f1 100644
--- a/drivers/bus/pci/linux/pci_vfio.c
+++ b/drivers/bus/pci/linux/pci_vfio.c
@@ -478,6 +478,8 @@ pci_vfio_is_ioport_bar(int vfio_dev_fd, int bar_index)
 static int
 pci_rte_vfio_setup_device(struct rte_pci_device *dev, int vfio_dev_fd)
 {
+	int i, ret = 0, max_retries = 5, retry_delay_ms = 20;
+
 	if (pci_vfio_setup_interrupts(dev, vfio_dev_fd) != 0) {
 		RTE_LOG(ERR, EAL, "Error setting up interrupts!\n");
 		return -1;
@@ -498,7 +500,19 @@ pci_rte_vfio_setup_device(struct rte_pci_device *dev, int vfio_dev_fd)
 	 * Reset the device. If the device is not capable of resetting,
 	 * then it updates errno as EINVAL.
 	 */
-	if (ioctl(vfio_dev_fd, VFIO_DEVICE_RESET) && errno != EINVAL) {
+	for (i = 0; i < max_retries; i++) {
+		errno = 0;
+		ret = ioctl(vfio_dev_fd, VFIO_DEVICE_RESET);
+		if (!ret || errno == EINVAL)
+			break;
+
+		if (errno == EAGAIN) {
+			RTE_LOG(DEBUG, EAL, "Device busy, sleep %d ms and retry to reset %d of %d times\n",
+				retry_delay_ms, i + 1, max_retries);
+			usleep(retry_delay_ms * 1000);
+			continue;
+		}
+
 		RTE_LOG(ERR, EAL, "Unable to reset device! Error: %d (%s)\n",
 				errno, strerror(errno));
 		return -1;
-- 
2.43.0

