Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FD55CC6B1A
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Oct 2026 09:13:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1E6B44064E;
	Wed, 14 Oct 2026 11:13:06 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazon11013070.outbound.protection.outlook.com
 [40.107.162.70])
 by mails.dpdk.org (Postfix) with ESMTP id 05C8740430;
 Wed, 14 Oct 2026 11:13:03 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xpcuiNqTSGodrielhEKshn5AyygTQ6qqGx8C7L+0w8F8VobSyWJPiV73ElLvKtw/sNihrDtzKAwibSylENbEV8lUspol4QedfOm7OiedgLJi11uTbGjES8AdhHd+b3W7/qOkiKHoqvgvARrCslSrSNh+8D0HBQD/D+6QUkJSV0RqBg8rTxeXKxjMtl/oJX90wIW5ZlJDQw2P43idXAamWHtE2HOm+0O8hPIolTZnCFmwfbhqNJ3nt3lL7JUxWiRQAqTSReU8JfDLEU61Jywa+SHk+bYTBHoLcEVqsgmcc2XTF2UJ8CYQqBzTnHCyGxEemcIczVvj2SyPKOgu76CXOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BaPN6/G7eROMNVj4baTn6wic/tBzE8KFtyTDxxHAoqU=;
 b=HWX8MOYi8Ry9JKHFMnAlENPQWEfLZb2II1Scu7oZ8D0VNC1wvBfVcNlDjZEgnLbbcBbQu44s2PR4nZ2kH14e7MTCstE0Ro86+20Jv15lSTKqB5nFbt9R5GJwI5lJW9rppTNvqU15O6ZxKuQqnD276d/lzIBcxpv9cTL8hX9WfmBnWP6+bRyCkC0J8Md36EyNbIPaUVd38oEMv7EgsHAy0zj9Husgf9TNVoVdBu7xEtcVJtCgU+8DB+tF5BstEb2oGvPgnH7hsOYbmLVIrOuKpYNPt25xEJMpWoTmUodZuoBVZ+Vr36M2fj6A5iYW8DRBqSx616UeX+m/z2I5C4NqYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.176.1.74) smtp.rcpttodomain=cisco.com smtp.mailfrom=ericsson.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ericsson.com; 
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BaPN6/G7eROMNVj4baTn6wic/tBzE8KFtyTDxxHAoqU=;
 b=QiM0gLaiK42ae+eNSnx5NpzH9EUmHMIx1sgbbDMJzRCq1q99n2R84LNdzM6P5HsK+mVZkRvTKI92j9SmWr+BZtOlgcloa5402ROwcsz44YzJhKPJnXvv47yCCRnjjHrGx9XSMnot045wLDugsB0tF6g3sqLldZspHoLYYpIvKf8YZKwwSb2Jwcva6iIc0R3km2oWOsL0Fs5K7kMtRgmxQWxqX10oyPPi+yqEHoEf5uA5eqzDL3TFsvKnCKrncaWJc77EyTgRyXc9U92BSsUjSalEbd3dacKc+83eWe8TOTb1TcApBcUgTCLmsoHGhv+PH2z2NzjiJKMg5AzKdtF3fQ==
Received: from AS4P250CA0027.EURP250.PROD.OUTLOOK.COM (2603:10a6:20b:5e3::18)
 by FRWPR07MB10676.eurprd07.prod.outlook.com (2603:10a6:d10:17a::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Wed, 14 Oct
 2026 09:12:59 +0000
Received: from AMS0EPF00000569.eurprd02.prod.outlook.com
 (2603:10a6:20b:5e3:cafe::71) by AS4P250CA0027.outlook.office365.com
 (2603:10a6:20b:5e3::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Wed, 14
 Oct 2026 09:12:59 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 192.176.1.74)
 smtp.mailfrom=ericsson.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ericsson.com;
Received-SPF: Pass (protection.outlook.com: domain of ericsson.com designates
 192.176.1.74 as permitted sender)
 receiver=protection.outlook.com; 
 client-ip=192.176.1.74; helo=oa.msg.ericsson.com; pr=C
Received: from oa.msg.ericsson.com (192.176.1.74) by
 AMS0EPF00000569.mail.protection.outlook.com (10.167.242.119) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Wed, 14 Oct 2026 09:12:59 +0000
Received: from seliius19819.seli.gic.ericsson.se (153.88.142.248) by
 smtp-central.internal.ericsson.com (100.87.178.63) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 14 Oct 2026 11:12:59 +0200
Received: from seliiuvd10563.seli.gic.ericsson.se
 (seliiuvd10563.seli.gic.ericsson.se [10.120.141.220])
 by seliius19819.seli.gic.ericsson.se (Postfix) with ESMTP id DA3324020B73;
 Wed, 14 Oct 2026 11:12:57 +0200 (CEST)
Received: by seliiuvd10563.seli.gic.ericsson.se (Postfix, from userid 93258)
 id AA6E7617B8BA; Wed, 14 Oct 2026 11:12:57 +0200 (CEST)
From: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>
To: <dev@dpdk.org>
CC: Stephen Hemminger <stephen@networkplumber.org>, Sriram Yagnaraman
 <sriram.yagnaraman@ericsson.com>, Jakub Grajciar <jgrajcia@cisco.com>,
 <stable@dpdk.org>
Subject: [PATCH 2/6] net/memif: close file descriptor zero
Date: Wed, 14 Oct 2026 11:12:53 +0200
Message-ID: <20261014091257.1051190-3-sriram.yagnaraman@ericsson.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20261014091257.1051190-1-sriram.yagnaraman@ericsson.com>
References: <20261014091257.1051190-1-sriram.yagnaraman@ericsson.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF00000569:EE_|FRWPR07MB10676:EE_
X-MS-Office365-Filtering-Correlation-Id: 28b31251-515b-4073-f555-08df29d357bc
X-SMTP-Server: smtp-central.internal.ericsson.com
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|36860700016|376014|82310400026|261009223027099003|260925022911599003|260925021911599003|260925021311599003|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: I2pvdjnYzyjj7Mk7SQPYpA/+OcvNN3Xo3CfSfbYJoEkwmdUWP5mghE8vHLFrow5rpMT4dxrrLGhSq5BPSUpVUMw0dJEfFq5RDvTkZcbIRV0jhvUeLng0ejx4vPwvuUbeohMwbT1Its6OPojuwCNoflJCzsJ+Ttal4NGokM/QrI2XfX/INuxFwibulssQhfvNlUlTiS6MZdNr01J2HIScZCb43wXOjocxNE03ePitRsXgWXP1F0iewKO9w0RLCpKX7CvUFB4GLAnzAlvgMriBcTsh04eWl6g7Qp3wQHbNNvHOXKN4G5nV3ZANIrcgxSkolKHzo0BkGqh3sDqOXk7mecNb845FAyzXzwa/gjetTWEJ9oJ7Ze4xF5Z4NqeMNUwdVjA5tiC+ITJWdwNZ48zgjQ0K8w0TP8ejaV4NpnRljYYY6EqRgb14Jzgxg6i9yXvjNh0idpHl0kh9hhkTfSj0Ylfzf9HY6pN1i9yU4sYalyW00AQs+EEvTgmBMAcbw4c4DavWaPCgHj+mY+khDTFD0wawR8l+adBn19600GVMbFfukB3D/htt6aOjfwV5yo557gcr85sE49XzHiZzXQxeKI8z2mboc0qPnmbzKhduYalBHCI/PN9YMJD07xj5g3SY3SH6twDvtgQfx68wS8w6JJ2ZcO8etRe/C3fiOubw1URCjkvt1RsvkboJB+0lFJFRH3WwLBc8/3q9RNK84uQUxg==
X-Forefront-Antispam-Report: CIP:192.176.1.74; CTRY:SE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:oa.msg.ericsson.com; PTR:office365.se.ericsson.net;
 CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(36860700016)(376014)(82310400026)(261009223027099003)(260925022911599003)(260925021911599003)(260925021311599003)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: h2aVe7bFjkwFeo3FUSuzzB/SL5u8vi062aw6taDmyHISIzxC0UnYQD4PeK6GPWvShPfpDc4RagH9Sz+3not8T+uGvZPTTzK5qrCD7ThOxg4R95tAAnhCACCfecBNRczB/zINUy1rVnETMwoVt4/JEm+eRkIYhMc3rQ4oGA4LyTa8hR5f18GgL0gj8DwaerYZdsxNhhYO5UiPOecQEz6RsQY9sUYOsSptEpza0bQ+nxr9Pp9FvIAeQ2Jicq3a6O7Izxhct64Jj36IV8AGAvHPKqTyzazQtlSrVVvnwQwq5y2m/0c+iEMcCWNf+uAF15jUbyZDU/DhJEFdIuqhOP8WGIBqHMZiH7gXYQhe/Ura5EufK5tDOL7381L550L/fX7+r/w288+BLHvKylwXULd0rFcVm48hmsZNNCqjujK9tdF8Oy3d9RuP00KM17gUi9XD
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 09:12:59.6147 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 28b31251-515b-4073-f555-08df29d357bc
X-MS-Exchange-CrossTenant-Id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=92e84ceb-fbfd-47ab-be52-080c6b87953f; Ip=[192.176.1.74];
 Helo=[oa.msg.ericsson.com]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF00000569.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRWPR07MB10676
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

Several cleanup paths guard close() with "fd > 0", which skips a valid
file descriptor of 0 and leaks it. A descriptor of 0 is legitimate (for
example when stdin has been closed before the region or interrupt fd is
created). Use ">= 0" consistently with the -1 sentinel the code already
uses elsewhere, in memif_free_regions(), the memif_region_init_shm()
error path, the control-channel teardown in memif_disconnect(), and the
SCM_RIGHTS fd check in memif_msg_send().

Fixes: 09c7e63a71f9 ("net/memif: introduce memory interface PMD")
Cc: stable@dpdk.org

Signed-off-by: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>
---
 drivers/net/memif/memif_socket.c  | 8 ++++----
 drivers/net/memif/rte_eth_memif.c | 6 +++---
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/net/memif/memif_socket.c b/drivers/net/memif/memif_socket.c
index 8231a936e5..5918406271 100644
--- a/drivers/net/memif/memif_socket.c
+++ b/drivers/net/memif/memif_socket.c
@@ -41,7 +41,7 @@ memif_msg_send(int fd, memif_msg_t *msg, int afd)
 	mh.msg_iov = iov;
 	mh.msg_iovlen = 1;
 
-	if (afd > 0) {
+	if (afd >= 0) {
 		memset(&ctl, 0, sizeof(ctl));
 		mh.msg_control = ctl;
 		mh.msg_controllen = sizeof(ctl);
@@ -624,7 +624,7 @@ memif_disconnect(struct rte_eth_dev *dev)
 		}
 
 		ih = pmd->cc->intr_handle;
-		if (rte_intr_fd_get(ih) > 0) {
+		if (rte_intr_fd_get(ih) >= 0) {
 			ret = rte_intr_callback_unregister(ih,
 							memif_intr_handler,
 							pmd->cc);
@@ -664,7 +664,7 @@ memif_disconnect(struct rte_eth_dev *dev)
 				continue;
 		}
 
-		if (rte_intr_fd_get(mq->intr_handle) > 0) {
+		if (rte_intr_fd_get(mq->intr_handle) >= 0) {
 			close(rte_intr_fd_get(mq->intr_handle));
 			rte_intr_fd_set(mq->intr_handle, -1);
 		}
@@ -682,7 +682,7 @@ memif_disconnect(struct rte_eth_dev *dev)
 				continue;
 		}
 
-		if (rte_intr_fd_get(mq->intr_handle) > 0) {
+		if (rte_intr_fd_get(mq->intr_handle) >= 0) {
 			close(rte_intr_fd_get(mq->intr_handle));
 			rte_intr_fd_set(mq->intr_handle, -1);
 		}
diff --git a/drivers/net/memif/rte_eth_memif.c b/drivers/net/memif/rte_eth_memif.c
index 5e28db782d..24a44d94d7 100644
--- a/drivers/net/memif/rte_eth_memif.c
+++ b/drivers/net/memif/rte_eth_memif.c
@@ -1290,12 +1290,12 @@ memif_free_regions(struct rte_eth_dev *dev)
 			/* This is memzone */
 			if (i > 0 && (pmd->flags & ETH_MEMIF_FLAG_ZERO_COPY)) {
 				r->addr = NULL;
-				if (r->fd > 0)
+				if (r->fd >= 0)
 					close(r->fd);
 			}
 			if (r->addr != NULL) {
 				munmap(r->addr, r->region_size);
-				if (r->fd > 0) {
+				if (r->fd >= 0) {
 					close(r->fd);
 					r->fd = -1;
 				}
@@ -1416,7 +1416,7 @@ memif_region_init_shm(struct rte_eth_dev *dev, uint8_t has_buffers)
 	return ret;
 
 error:
-	if (r->fd > 0)
+	if (r->fd >= 0)
 		close(r->fd);
 	r->fd = -1;
 
-- 
2.43.7

