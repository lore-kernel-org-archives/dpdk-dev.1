Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A765C61DC6
	for <dpdk-dev@archiver.kernel.org>; Thu, 27 Aug 2026 11:43:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 612514064E;
	Thu, 27 Aug 2026 13:43:39 +0200 (CEST)
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
 by mails.dpdk.org (Postfix) with ESMTP id 391DD40284;
 Thu, 27 Aug 2026 13:43:36 +0200 (CEST)
X-QQ-mid: esmtpgz13t1787831013t42c95dee
X-QQ-Originating-IP: P8XimNg+/9PFRKeH4urhuqfIDmL/lDqXD6aU37wST6Q=
Received: from DSK-zaiyuwang.trustnetic.com ( [122.233.170.62])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Thu, 27 Aug 2026 19:43:31 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 1746274163170576862
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH 02/13] net/txgbe: fix incorrect link state in 10G forced mode
Date: Thu, 27 Aug 2026 19:41:54 +0800
Message-ID: <877A1D804D3975B2+20260827114309.10530-3-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.55.0.windows.2
In-Reply-To: <20260827114309.10530-1-zaiyuwang@trustnetic.com>
References: <20260827114309.10530-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: MAFEYtBOfSqmwn6XV1oPAQspd75KwEBNmWQDdKBO84HjOlNh+K9ezK1x
 WlAeBsIer16moLRcPXJRSEdYAa+Xnm06A31mVBl2Cxi5jQbMYcoHEBoOtzOUh3WdiDPtSTh
 isTEO3zGdraMns4ezJyloSLdef50xIHSsKcvVpYkUbUk94gOV41EyqN13rerlfBoqahcwcr
 +R2qyTYm+FAo2tRKy3xbs2996/sVkfpjF813wXhZ+ZBG4ysuZw61g5y8eG7gcfePJAXX4J9
 nllnQF8T9Ia/DnZQpr+LZnzqa0jSHqICzD7c4cBy18trAgaQ5CCmNJGc11NjrbrkpL59zuF
 2/VFATMR9lNp9/Km580bkofYkrOWlH17lRTwR5DCT9IhccatTzT0/IDqv3fSaKI6mS0F764
 RFRbSWdxDyVwEGdBTDY0IlT3WGJ4RVZgjAnSAzXl2aX6u9gAefVGRt+P7o2vlKYNzZeEcuF
 IgUp+FLN7vRTlrdOeSmfBRW53ol8j2Islj+OHG8BrjoOJwYpfsjytJdvoW3BSHNhoMObFWG
 OHSvvZmAaDXv59XAJ9x0SXd6/wC/C05rIgueS62eD7QdSyNGhUf8IEsBFIFjJ2EBi75efhy
 yHBwY0DnbSo8vPE6L4+YFOLgKOGSZs8zmyWd964fTUTX7i/XkGBV9++oILj2i7CPIB1QId2
 MZAfJFrDnRPcBsO21SImlyIBVKKv08tpHz0wIjYjE9Pb11hL54IUgYEMd+JOy7+nAPy7mz7
 G30bB0+c8CjOr23v2e3CI7ebjRbFl9oe0Z/MNhvFxqPBNp9jVbHqU8D201rpeX4ZHbEWdaN
 kAn81f6K8B6jej3IHmO1QAPXFagTfYmaiDTUe8QwPkeZl3YTi1meY+EnPx0Kr8ggztTyHV2
 rJFSe9aGz/e5ic648XZ+9vOlCyrV7VgwdsyboRI4VYGUK0EPuhpnVvRwo29sIwkiR1SrNte
 Do3gvVLQNVagUFZ1f1q7Sekk2h483YHdGETB+LVCDRFrgepDhgMKIvl/+aAm2M/Tb5Sx6/c
 BvpP0CLY+oT60A/UJR/5BqgNtIKmBQoRaNfe/tIYdJPqdoI0i3enNoWmgTXe4dXf9HPPZIO
 c4Pw1YikHKoLEGdcgWUirhQZynC3+0KddBY7PQqIInp
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
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

When an AML40 port is configured in 10G forced mode (auto_neg=0),
the hardware can link up but the driver keeps reporting link down
after a peer link failure: link_valid is cleared on timeout but
never restored when the peer recovers, so the link stays down until
the port is restarted.

Restore hw->link_valid = true in the success path of
txgbe_setup_phy_link_aml40(), symmetric to the 40G path.

Fixes: f7cfc21e9f75 ("net/txgbe: fix link stability for 40G NIC")
Cc: stable@dpdk.org

Signed-off-by: Zaiyu Wang <zaiyuwang@trustnetic.com>
---
 drivers/net/txgbe/base/txgbe_aml40.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/txgbe/base/txgbe_aml40.c b/drivers/net/txgbe/base/txgbe_aml40.c
index 1098efe5e6..05eac68f3b 100644
--- a/drivers/net/txgbe/base/txgbe_aml40.c
+++ b/drivers/net/txgbe/base/txgbe_aml40.c
@@ -197,6 +197,8 @@ s32 txgbe_setup_phy_link_aml40(struct txgbe_hw *hw,
 	ret_status = txgbe_set_link_to_amlite(hw, speed);
 	if (ret_status == TXGBE_ERR_TIMEOUT)
 		hw->link_valid = false;
+	else
+		hw->link_valid = true;
 	rte_spinlock_unlock(&hw->phy_lock);
 
 	for (i = 0; i < 4; i++) {
-- 
2.55.0.windows.2

