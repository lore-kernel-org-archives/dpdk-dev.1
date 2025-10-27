Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E468CCF9E5
	for <dpdk-dev@archiver.kernel.org>; Mon, 27 Oct 2025 03:17:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E4E3040677;
	Mon, 27 Oct 2025 04:16:15 +0100 (CET)
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
 by mails.dpdk.org (Postfix) with ESMTP id 0CD834065F;
 Mon, 27 Oct 2025 04:16:12 +0100 (CET)
X-QQ-mid: esmtpsz16t1761534969tdbd2f8da
X-QQ-Originating-IP: 9AZvf/ep8xyykUMOMuQ1Iu3vWDlafYRAgOdpUOLWEYQ=
Received: from lap-jiawenwu.trustnetic.com ( [36.20.107.118])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Mon, 27 Oct 2025 11:16:08 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 6868014541887765934
EX-QQ-RecipientCnt: 4
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: dev@dpdk.org
Cc: zaiyuwang@trustnetic.com, Jiawen Wu <jiawenwu@trustnetic.com>,
 stable@dpdk.org
Subject: [PATCH 10/19] net/txgbe: fix FDIR mode is not be cleared
Date: Mon, 27 Oct 2025 11:15:33 +0800
Message-Id: <20251027031542.10512-11-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20251027031542.10512-1-jiawenwu@trustnetic.com>
References: <20251027031542.10512-1-jiawenwu@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: OZZSS56D9fAjgWTlrlnqyHA+6EO1luAjTnpRgMkDRFQJOtygYERY/OhQ
 a+aBtQ5mqnasv/DAOPEvh3giyP/Sh10EvgvyUNf76dUtXBlqDgkxmHTF+NoIeuoBL3U9x/E
 gMjKjKujHMefuWQ89+4IOjeE/54SW/so0xLx9yZRgZZASCviNSVoyTjGYyKMmbEhyrxAATK
 5WAnPX5ZCjmVhFyTeMMBWQsoT3lOIqI6Kiw5hrm5mik5iL3TSpDUP20QRTuoKSfydEY1K4D
 lGyBSkC32jYkOxq6mPr1I4U3WXXdeBiTpNHYHVFoHD7ZqWdZyIRlgX0OgukrXZ5CCb4Gpav
 L8AbOBbf7CAVG92nAYjaoT9l/8yVZnHlUaj1QgCklN3Gmwe48+xfRM0sDmeEViptXwLWyC4
 xLJ8uMX291S6FKrpT7KsJR4rkVrHEmoF+ZehsrGhBdRQbjOF2JzyfMT6yS02l2zcnNAZbMT
 uZf0SVBJxsHjibPfSeB5dV6T99fbyVAWO8Lm+kC+YUQg2PnJZx7IUOqprC3GcI7FWFvmbFI
 RQNpKHcCXhhIquTti9lf5F8Gh/psR6MYZqZgxtXsK5lpPI6YzA4TbX6ZUV77/DrcbK8N5A6
 tYTqE/UVGU2vxK9aFDuxiujntUfwWbnSow+9v/W5H/45vKwchAyZXlYIaCvrMdQDj+Fm+mq
 OBGS3A182nQH+2Cd7pn5JOFLIK2TKAG+Z1d42hzbkJUKrVO5KxhNvJe9EgvgH/hrUIbXogu
 x+a2f3ItYedApQB5ehr729izyXq79YYHoEBysVr+lr/KU0orZzUH6/Sh/VouVgVppyjCwIf
 4tRE4XTPbRBlPnhVB7guKUlziKs7z7PB7Z89SFr0zqmuzRmkCXLPcvVwn+5zSDXuNd5jJex
 ZPPiMauEx8R0iku0rPOdgtyLkKG+cGqdh2KjIggzYm7ytj/GX+KTdPk4VES/ZSVsbR8zlgb
 gOVR9EahEyPrF3UUhbRlRtqpIQ0pHlGGOeAcDkK6dU8RVfjpL+UXld/ITR4Qw7lAB+kZ8tp
 CTSUKip+WZeAk7G7XVLePYplv0a+Y=
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
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

When FDIR flow rules are all cleared, FDIR mode is not cleared. This will
cause that creating new FDIR flow rules failed, for their mode are
different from the previously deleted ones.

Fixes: 6bde42fe7fa5 ("net/txgbe: flush all filters")
Cc: stable@dpdk.org
Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 drivers/net/txgbe/txgbe_fdir.c | 1 +
 drivers/net/txgbe/txgbe_flow.c | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/drivers/net/txgbe/txgbe_fdir.c b/drivers/net/txgbe/txgbe_fdir.c
index 631dec69e8..77d0cc4c30 100644
--- a/drivers/net/txgbe/txgbe_fdir.c
+++ b/drivers/net/txgbe/txgbe_fdir.c
@@ -970,6 +970,7 @@ txgbe_clear_all_fdir_filter(struct rte_eth_dev *dev)
 	memset(fdir_info->hash_map, 0,
 	       sizeof(struct txgbe_fdir_filter *) *
 	       ((1024 << (fdir_conf->pballoc + 1)) - 2));
+	fdir_conf->mode = RTE_FDIR_MODE_NONE;
 	filter_flag = TAILQ_FIRST(&fdir_info->fdir_list);
 	while ((fdir_filter = TAILQ_FIRST(&fdir_info->fdir_list))) {
 		TAILQ_REMOVE(&fdir_info->fdir_list,
diff --git a/drivers/net/txgbe/txgbe_flow.c b/drivers/net/txgbe/txgbe_flow.c
index 31af3593ed..25cf0db316 100644
--- a/drivers/net/txgbe/txgbe_flow.c
+++ b/drivers/net/txgbe/txgbe_flow.c
@@ -3429,6 +3429,7 @@ txgbe_flow_destroy(struct rte_eth_dev *dev,
 	struct txgbe_fdir_rule_ele *fdir_rule_ptr;
 	struct txgbe_flow_mem *txgbe_flow_mem_ptr;
 	struct txgbe_hw_fdir_info *fdir_info = TXGBE_DEV_FDIR(dev);
+	struct rte_eth_fdir_conf *fdir_conf = TXGBE_DEV_FDIR_CONF(dev);
 	struct txgbe_rss_conf_ele *rss_filter_ptr;
 
 	switch (filter_type) {
@@ -3488,6 +3489,7 @@ txgbe_flow_destroy(struct rte_eth_dev *dev,
 				fdir_info->mask_added = false;
 				fdir_info->flex_relative = false;
 				fdir_info->flex_bytes_offset = 0;
+				fdir_conf->mode = RTE_FDIR_MODE_NONE;
 			}
 		}
 		break;
-- 
2.48.1

