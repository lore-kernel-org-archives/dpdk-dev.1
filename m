Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26262CA9ED1
	for <dpdk-dev@archiver.kernel.org>; Mon, 12 Oct 2026 11:05:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9D3E34060C;
	Mon, 12 Oct 2026 13:05:41 +0200 (CEST)
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
 by mails.dpdk.org (Postfix) with ESMTP id 4CBD4402DB;
 Mon, 12 Oct 2026 13:05:37 +0200 (CEST)
X-QQ-mid: zesmtpsz4t1791803133t6ce066b5
X-QQ-Originating-IP: Td5ogaKzRGVSEzCxhtG5tdGiisuASDCKwpM53wY9NzA=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.198.217.6])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Mon, 12 Oct 2026 19:05:31 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 4933670868224840411
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v8 03/16] net/txgbe: fix e56 PHY configuration error
Date: Mon, 12 Oct 2026 18:56:20 +0800
Message-ID: <7AC5D70676875B74+20261012110518.1911-4-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.55.0.windows.2
In-Reply-To: <20261012110518.1911-1-zaiyuwang@trustnetic.com>
References: <31C12A7AAC7E19F2+20260827114309.10530-1-zaiyuwang@trustnetic.com>
 <20261012110518.1911-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: MLQK/Qc97rZTCPhAmKTjwUU0Dan7Q8pSfp0HJj4juxYkSj1tbTT+gS8J
 ybsGZSudSeXqgt8bLtk5JJ4Wlm/h8YO9uZLnP4CuDHf5RIhUo3dQE3T5ZoG43d01d8pLg6z
 V4ocCf/lUazCm1uTt0172+Po9JKg8jym/T+J2RIrMijdUG7ZseprgPn9WPGDyp0NxgIPnNe
 mV01lVIxrU8ZJ53Wzwv8Kz+K4D2aRgFNOy20ketIeHaFPlom1kwY1xAQbwL/n0/1ZOpm/5e
 DaYNmXhfhapY5azegTyJobua+tlAzWo6spyjqpnJX0qrf1KRgkFHwAJMv0Qr4QN6rCUq4Uz
 Q/kiBlp3nDLFBDYWxulsJOTBjntnfE8cis5y8zCX/LpvwShltQiedS+Qvu4ZGWBePYqnVjc
 ClJUkAjifZv1js7S8m7CLdVBUPqjDl3l+iKRWsLbKF+e3Nrci9cvRx4CNVWuXIyX3QzZmkn
 BbaQA+HRVQ0ZItNpgNpWrYplhE8dMa0TXwZFUuoxYieLhTeL6XiaZlLLZazgQrsd12iax1+
 LdLK6nxMwpMDJeaz6xQcv9SHMQlipre1edPsuT7+UgMF4fQltuRaosk5PMS6f8IDhv0k+1k
 QWT1s6nNNFZVz5OezJ5rsDkW6EzL8cV4dYAOQsYgfKUFuWU8JACUhtoGkZFVb2777/8lWha
 kguru/cqD7s240OMN13gj+0sD0o5NSKFQaYNoxVqEPnkGpW8APoLn7nXwMy7zwNIZQe3tps
 p8oXQuvdaPPcBlLQCPPH8xAGh+6KnvUHczhYd70acwhVO+RCaV10KFQZlAixH2DE5wyJvLJ
 BGMZVKI2hHv/tOdLVp72OZif8B8ZufLOEuPbjsIZ3oU2zf6My6pLRpJFJ9lza4CTzGKSQ05
 qTqFfwifFEQKkwS8GdTmWrSO9gTWSCdw6ytkPLwc3/SVQrKT0fdXaAlObD/lbwBPEJRIG6f
 T3GiTs7OuIX+a4ztCYk5SIRHXCV9jLtmFk9SqbuFoQsBBLuNZMLt1OOhfd1mi1xgP4Hw7S9
 rxtKzzibtGZCpuJ/oY0iRAulPOuDIbEiFW2sTwUC0B1FFAzKHInVngSbJ/5w5oX6ZzyRhyV
 OmjGP3rxIYC
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
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

The e56 PHY RXS ring equalizer/tap configuration is written to the
wrong bit field: set_fields_e56(&rdata, 9, 4, 0x366) targets the
unrelated lower bits, so the configured tap values are never applied
and the equalizer stays at its default setting, which can degrade
the received signal on both the 40G and 10G paths.

Fix the field range to (21, 12), so the equalizer/tap configuration
takes effect.

Fixes: f7cfc21e9f75 ("net/txgbe: fix link stability for 40G NIC")
Cc: stable@dpdk.org

Signed-off-by: Zaiyu Wang <zaiyuwang@trustnetic.com>
---
 drivers/net/txgbe/base/txgbe_e56.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/txgbe/base/txgbe_e56.c b/drivers/net/txgbe/base/txgbe_e56.c
index cbcc05333e..2711863f2c 100644
--- a/drivers/net/txgbe/base/txgbe_e56.c
+++ b/drivers/net/txgbe/base/txgbe_e56.c
@@ -423,7 +423,7 @@ u32 txgbe_e56_cfg_40g(struct txgbe_hw *hw)
 
 		addr  = E56PHY_RXS_RINGO_0_ADDR + (E56PHY_RXS_OFFSET * i);
 		rdata = rd32_ephy(hw, addr);
-		set_fields_e56(&rdata, 9, 4, 0x366);
+		set_fields_e56(&rdata, 21, 12, 0x366);
 		wr32_ephy(hw, addr, rdata);
 	}
 
-- 
2.55.0.windows.2

