Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56B9FCDB47F
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Jun 2026 11:53:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 48E5140A6B;
	Wed, 24 Jun 2026 13:53:18 +0200 (CEST)
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
 by mails.dpdk.org (Postfix) with ESMTP id D2A6040665;
 Wed, 24 Jun 2026 13:53:11 +0200 (CEST)
X-QQ-mid: esmtpgz10t1782301988te7eeb591
X-QQ-Originating-IP: 3eJwwmNDQsLUxGKn4iGEbAbUqqcRJB36+05Rq7HsQqw=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.204.248.247])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 24 Jun 2026 19:53:07 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 14636224960280344702
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v10 04/21] net/ngbe: fix VF promiscuous and allmulticast
Date: Wed, 24 Jun 2026 19:52:36 +0800
Message-Id: <20260624115254.20348-5-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260624115254.20348-1-zaiyuwang@trustnetic.com>
References: <20260423034024.14404-1-zaiyuwang@trustnetic.com>
 <20260624115254.20348-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: M9t1NOw+1P4GlsRJL1AjMeAKWeyheZgxTGy096hN2GslBg7MvO3NaX6L
 uUKSpMr0WvmdPJpUC88UXuvtBdGqlvL7/iAQEDYwXuqyx8tjB5WBu+N8UZv+gxHCSbaUjw4
 QOuskmlo39IY8iFv3JFNfLMF+8fevqWLnyZpK/ZC8z/JtCh2t/bGIOHtlEsbTvbiFiF2byP
 nI20dHhR10tZbp0Ak+04RA7mw7G0SN6n2njoFrechIfLE9El1NB3a5IzHSgPNqVeQNx6vfF
 jbNUHSfY4eXg5jOBi5rI/u83IgMkN4RQbvbVrtOPqsmSu9khgSnL461wnQ2ollYwSoixi9n
 at/lkL5EqhrddWjTlbgbhXownontdWC4ju0DNFK+bD5I1gQEtEFZG9nZegNUQYJOMiPh38U
 ISVQCZTRhse3Lo58c0Ql6ydE+SGftnUSUSfomOfp3C59WiizHT13YUd2yIbBAKE9H1PCtnm
 z76AQPzhkehV30nNryatW7L+3J43ACHVXEvjUi16XXkWj4cYzrAcB6e0M++VHBxNoF2FhHp
 3MQQYjBYj6EfkB5gasdf+x2YX/S7/J7KD3HkMtV9nF1c4jkkrYc/O7Nt8gS7H8tv+CAkUHC
 3QMMc/fuocohdP4S5DQ/xlMKCf6Zo89P0m/DZPiy+HqElyRUyWrp/y4Lrt3e4RnDsWAVyjL
 1n1p3pdy5JeI7EAn8DUlCejGT6EEEBWtkxNsSN7iw3an3nvbk2hCBoZwzmqyRn2ZXll/Afz
 KqDN7N3fF9kXVjVfKhCtXl5GFBCc9VUTx5pPM8kn0fI63UiHUWM0ckukf/VCtqBBroeKTHb
 dg+2EtmhbHIjd0wWnpKmmVQtZcZfC2uFj7MZDKYtsQjL0h0nSBS942hfZ80wabbd3yKqH7C
 4ZKKunyp+9I4OVPL9EnCvWgUf9JpndJfXTqbj0dyVnZq9cVzCKxg+cVeFbQ0tGWRWfimP1R
 O2QUyOa1jdx1ZCKPJSAU0TRGhx3jA1RkvPWCxlkjBadHTNhRJ+3rovehywjr+Vrlm89GdPh
 JMHZmIzjQy7J7FmRg6/5XZZBSqPjnZxmo+NyZ5q3F4JmWXH79tdwZyQgMWJ9hQFL/JtmW5v
 jguGIh2spI/
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
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

