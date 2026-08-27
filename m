Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CEF8C61DC6
	for <dpdk-dev@archiver.kernel.org>; Thu, 27 Aug 2026 11:43:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7660B40616;
	Thu, 27 Aug 2026 13:43:44 +0200 (CEST)
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
 by mails.dpdk.org (Postfix) with ESMTP id 7E280402D1;
 Thu, 27 Aug 2026 13:43:41 +0200 (CEST)
X-QQ-mid: esmtpgz13t1787831018t9d7635a2
X-QQ-Originating-IP: +kKujXSZWmzd/6X9frazzhupN0II4gjQOBP86aXlLvY=
Received: from DSK-zaiyuwang.trustnetic.com ( [122.233.170.62])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Thu, 27 Aug 2026 19:43:34 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 10399236674815064065
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH 03/13] net/txgbe: do not force reconfig on link retry
Date: Thu, 27 Aug 2026 19:41:55 +0800
Message-ID: <8356C0D20B83F2FE+20260827114309.10530-4-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.55.0.windows.2
In-Reply-To: <20260827114309.10530-1-zaiyuwang@trustnetic.com>
References: <20260827114309.10530-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: NeOhHDeijSx5qJ7v2yMR6YZWlZ+n7jAd74x0gluwNLfvLAhuV12tRpOn
 i4+L39AHd7We3RI7JQ8uAKJQxvNUu+LdI1INcCKwOMDFeEGy4XO3KN+IhV3SRXhhQ8+/Za8
 86qmWjSeJonTBuwOQpW6vTYzlwbtGU3rzHDD0Qv700VKruEXkpILPVaUm/vTnbFZc/OfJwJ
 vXwJb1GKoeO3P3sFhnyaHAIBV3/KAhO6sgjIP0ixjGuXKcpF+JrDVtjwCFdTZ8OdR7c95Z2
 A+LZ8T8jybX9A1Ch6YpZ181z6wP7OSPTc+L8wFIruOI8tVNVg0hB09cAHclGzwrciDwDWXV
 i7JqdrsQfFddDrHOTeOcxsGy4JaJhbB5cN77mEVpNdN8eB796DBJFeheOANdHUaxoxpuIjb
 w3Mz+7FeGCdr+TbUhe+itWhc9HdN5Q2/IpNgfszgCmUGk+jPJfRvEkV+5wKMZtd8a/zFMsq
 nV5RTN3DAm1kFCyJ9kwsq3tkNsI5GQvXTdPZ/sKESWr/OpuA/Hl3qtaBYPcE6T5ZmT4eMzp
 YTCbqyI6AbvbVIclIf7LX8tx3j+UYzPZaIyNEH5QDdPdzl0PaaYkQOFxNhGalRvGUsAq80J
 nzolvlRgGJe/HgDwG8VM4lfoI7zp8Yz9rGr38zvbG2zGvSEBiYYs0b65BVaZLkAOOStigLA
 +6PD35wgiaoAZln4gG4gVJpFIqMICfMY6AuoZb1lAxfprvIDPIzSA9fyZzG69WyGxnC+ElG
 Dmu6F8LJZQWqTN++PyYz8KXt60bg6gOe5Ggc8Jb1yhSKIsGPVXEygjrFT6SSGgHcR0b396S
 7yXoNdkEb/y5UWwPnwwh9ZwFDs2jIFNQJzGy2eMgoPVm0/iTAbv5BXEa3XqYy1NeXRnJTFA
 zc5EKUFVn7RaFPkNVOtHiI/2MKLGSbUeor9/3cnx/0oY/IPbSQ0arUPeRI/QoahREOfJUCG
 KyLMgFk9McU3D3XfbsWdMHL9hUYCtmEkr2oJ8u8HmHmuzmvrL5AC1LI1O/t3A5pmc6ge7F6
 yimtnSuzfzllEi9CDJ5ICv4uioVJZyvRZoNYXnq8iBhYnjY0n1D0HkpEF27ollAoK9vLThb
 pkJ4Q3jin/Sm705g6E8ktHRNE774U6ytQ==
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
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

The link alarm retry calls mac.setup_link() with
autoneg_wait_to_complete = true. On the AN73/xpcs path, setup_link
skips reconfiguration when the link is already up and AN is done
only if the flag is false. With true, a retry that arrives after the
link is up still runs set_phy_link_mode() and resets the established
AN73 link, which then drops and never recovers (e.g. after DAC
hot-plug).

Pass false from the retry path instead.

Fixes: 6104fd11086e ("net/txgbe: fix link stability for 25G NIC")
Cc: stable@dpdk.org

Signed-off-by: Zaiyu Wang <zaiyuwang@trustnetic.com>
---
 drivers/net/txgbe/txgbe_ethdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/txgbe/txgbe_ethdev.c b/drivers/net/txgbe/txgbe_ethdev.c
index 4d2746371b..b0d2bc3450 100644
--- a/drivers/net/txgbe/txgbe_ethdev.c
+++ b/drivers/net/txgbe/txgbe_ethdev.c
@@ -3286,7 +3286,7 @@ txgbe_dev_setup_link_alarm_handler_aml(void *param)
 		return;
 	}
 
-	hw->mac.setup_link(hw, speed, true);
+	hw->mac.setup_link(hw, speed, false);
 
 	u32 link_speed = TXGBE_LINK_SPEED_UNKNOWN;
 	bool link_up = false;
-- 
2.55.0.windows.2

