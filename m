Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E62DFCD98ED
	for <dpdk-dev@archiver.kernel.org>; Wed, 17 Jun 2026 08:15:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B5DD140BA0;
	Wed, 17 Jun 2026 10:14:53 +0200 (CEST)
Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
 by mails.dpdk.org (Postfix) with ESMTP id E154640674;
 Wed, 17 Jun 2026 10:14:49 +0200 (CEST)
X-QQ-mid: zesmtpgz4t1781684087t84a7158d
X-QQ-Originating-IP: 8c5b+9eq1Y2/EdSwBw1Gwp1NUOBJiI5hoWIqCZouHKM=
Received: from DSK-zaiyuwang.trustnetic.com ( [183.157.22.210])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 17 Jun 2026 16:14:46 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 5559253789852011559
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v8 04/21] net/ngbe: fix VF promiscuous and allmulticast
Date: Wed, 17 Jun 2026 16:12:51 +0800
Message-Id: <20260617081309.19124-5-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260617081309.19124-1-zaiyuwang@trustnetic.com>
References: <20260423034024.14404-1-zaiyuwang@trustnetic.com>
 <20260617081309.19124-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: NtlZ4W2gZhzdRFdRuOljS4vZuu3m9p2LAG4xPdsd3kJGv1EQSbqHCVni
 9Kpf4GObmt8rMy3A9QKSaiOzm42AQsMqKWn0vx2CkMOYhc2TWRDsqOtvnRSi8USB5j3sQ7c
 2crP/CpNv6O3IEhdIz9t0hzcU3mzKKO6fIrvfGxqkwmTL/sk49uFt4LuLOSE4Ax/GAhTbFJ
 HoTwh6XsUsz9tjJXlB37xQSGGqVeYALpiTrL/Pl3+rujMlzD6N8JIQ9IRgEYjIlmhevNLZ3
 1nrYE7So+aFOIrJukxgnmIG1AcNc6uM3fMHW1yqGz+uvRpX/LJogqMHiuU154KbWDUofiYP
 4i1sUJWy1HmKLpiIBvgb3bbXzlUnui8FLaTxvfFb9Kqd/9trAcOoLEwVOk6bgdh+/ENaGkx
 gY90K6vV42XnjmKM11nyO8/trFQBntQKbRO7QP3zKH/oyEWrJrXbBWT8FqtKx7gshf8D5RL
 pZ4xHuZMZAD7FmYkdsA1MF+yjJXDld/y8HSuhNCJAPPTMWayD+rzKIRfEKSy7F7x2yxRhaz
 Z6VvVHdGOHVfFLB/xW4bEgRnrilk3ZUUzN28mowaQlVdeTzKzBUHRJPGP6HL8dsfwQSB5To
 n8bY88+xluXjWUoy5fp1dWMUyK5SD+LrY7zFj5rFW/0UB+w8wcJL8OSwNL4ZPLDuHU3lICp
 L8fMOv7ZB8mAkGMLjyIjOP0mhWuyx/8Fta6G3j1NoFcRzw4nPbPpZjZGOKCq84RMLxVBH+u
 xI9t1GjxC7/ogERUwtqDJUDiZjWBD8tG0PaMstmMAyykGRVhoGDm17h+TroDg39cuPF0J5e
 4PgaWBEouqNyK9n9wa69uXKrfV/w/mO+E8DQd6CMo4UNyuUh0ch4E5n3PAvo+5/PTjOBXqS
 Xqa4Gxc2tbeaTi90HHeYzeBONQTY62a9bQ3tOalArCviPUkVQetG6aiA6qp9yhQbZtFIl7W
 UsvZUsnoz4VtI/WB1iXdrgqY6KaffxW7vxK//pc+KvBO7TGJJGjMRzJW14qsLKB438VKDsg
 e6UFR3eQQkl+dAsXkwu4l7p5n0iu4xSg2SaScq0FiSyUN41Ldh
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
X-QQ-RECHKSPAM: 0
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

The configuration of allmulti and promiscuous modes conflicts
together. For instance, if we enable promiscuous mode, then enable and
disable allmulti, then the promiscuous mode is wrongly disabled.

To resolve this, the following changes are made:
- do nothing when we set/unset allmulti if promiscuous mode is on
- restore the proper mode (none or allmulti) when we disable
  promiscuous mode

Fixes: 7744e90805b5 ("net/ngbe: add promiscuous and allmulticast ops for VF device")
Cc: stable@dpdk.org

Signed-off-by: Zaiyu Wang <zaiyuwang@trustnetic.com>
---
 drivers/net/ngbe/ngbe_ethdev_vf.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ngbe/ngbe_ethdev_vf.c b/drivers/net/ngbe/ngbe_ethdev_vf.c
index ea3a988df6..c440e02369 100644
--- a/drivers/net/ngbe/ngbe_ethdev_vf.c
+++ b/drivers/net/ngbe/ngbe_ethdev_vf.c
@@ -1196,9 +1196,13 @@ static int
 ngbevf_dev_promiscuous_disable(struct rte_eth_dev *dev)
 {
 	struct ngbe_hw *hw = ngbe_dev_hw(dev);
+	int mode = NGBEVF_XCAST_MODE_NONE;
 	int ret;
 
-	switch (hw->mac.update_xcast_mode(hw, NGBEVF_XCAST_MODE_NONE)) {
+	if (dev->data->all_multicast)
+		mode = NGBEVF_XCAST_MODE_ALLMULTI;
+
+	switch (hw->mac.update_xcast_mode(hw, mode)) {
 	case 0:
 		ret = 0;
 		break;
@@ -1219,7 +1223,7 @@ ngbevf_dev_allmulticast_enable(struct rte_eth_dev *dev)
 	struct ngbe_hw *hw = ngbe_dev_hw(dev);
 	int ret;
 
-	if (dev->data->promiscuous == 1)
+	if (dev->data->promiscuous)
 		return 0;
 
 	switch (hw->mac.update_xcast_mode(hw, NGBEVF_XCAST_MODE_ALLMULTI)) {
@@ -1243,6 +1247,9 @@ ngbevf_dev_allmulticast_disable(struct rte_eth_dev *dev)
 	struct ngbe_hw *hw = ngbe_dev_hw(dev);
 	int ret;
 
+	if (dev->data->promiscuous)
+		return 0;
+
 	switch (hw->mac.update_xcast_mode(hw, NGBEVF_XCAST_MODE_MULTI)) {
 	case 0:
 		ret = 0;
-- 
2.21.0.windows.1

