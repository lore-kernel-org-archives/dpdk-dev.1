Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1996C79F99
	for <dpdk-dev@archiver.kernel.org>; Tue,  8 Sep 2026 13:28:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D497740E40;
	Tue,  8 Sep 2026 15:28:02 +0200 (CEST)
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
 by mails.dpdk.org (Postfix) with ESMTP id 14D6340E8A;
 Tue,  8 Sep 2026 15:27:58 +0200 (CEST)
X-QQ-mid: zesmtpsz3t1788874075t0f47f269
X-QQ-Originating-IP: L+OahTIspMfBrSJpiB7ZscBMAoPXw2gn/Sg36FWRNyc=
Received: from DSK-zaiyuwang.trustnetic.com ( [36.24.66.61])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Tue, 08 Sep 2026 21:27:53 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 2841321965969147171
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v3 04/15] net/txgbe: do not force reconfig on link retry
Date: Tue,  8 Sep 2026 21:25:49 +0800
Message-ID: <F430CCD287899606+20260908132742.2661-5-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.55.0.windows.2
In-Reply-To: <20260908132742.2661-1-zaiyuwang@trustnetic.com>
References: <20260827114309.10530-1-zaiyuwang@trustnetic.com>
 <20260908132742.2661-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: NwMblr6Dy8b0HFmyCYOWMykV/7VJSiqpmKS5vPGRMxei6hQFkOLSdC5W
 /y36PmoctGM+MM/F18OVYNFfqAQnpPTXwaTdoAUdUHwI5KlCrsiOAsxNxttIthlXULQ9/r9
 ojK2YKjFyzakYJqZAA1oDcAYII6Lsf69wSVHS9iG8se2PGfLgWiBxQuiUdeSDZDbUpyte44
 4+jV79YWn0p6EkVg5OstGtNpxAMl09Bta57PYuRlZXOCjPZa0tSd5/vFcvs315G6sMgUE3R
 Pl9yIfe+EjnbTu8UNM8Zhlv9k2WfsLDXb46MjP+BZG8QxSWB9lv5EQYlsvDeUN1EFHSRC57
 w3qXdsUUenWqYKlNmspuvlCj4KH4O3EtWW8gqoI/AVy0L4Ipn2z2MxOPZ1ybRCtivK6Oj6r
 vKgjnN/D4Bm8Qfg+YUitIxNDRBS9tqUNOQcO6jG0buICc7ew/aCiIxUBiHhMPZD3NxgdAUz
 FUXJ3EH41WjTkc+1vDjyMvD8TJjDdXdXHEGY5RHkWmq6RcP4Ibg1JwZScVnfnB3tj6gXvMC
 KDI6Ns33pQz2NjeId+AqBCBP1Ap6/VRkgXL4UNJRq0rGdTjfrEOHTm1ZwQdzb1h2O6dhLVk
 ekSvlOvGD/JLIBNy+Gi3sNtQcCbU6bOzD0gYjcNBfgd58Uha+3DzAbf2kz30no3JHacQjHl
 9R2npJv0QMxiCSSusIH8z8WgnBDQqkDADgZXh305t0462SCDHMoBm9pFWAEcraDSANBy9gs
 jXgdt43wEqZDE4Ht7vz3VI3oP1Ilim6Ax4ZCYDtspvXqmfNBdhxTEV05S6ilFksCSgsRNqx
 lwsouGBsIJ1br0jXa+tG/FOwKMWjQk+e5u36vb0jKbnihxMM1D5GOTlSPeq/HbSPBGtK8rV
 QHVEg6WfBMYhjdtZlKvMTsrwaFvzfmNjardGPXNJalxLyWgQdZxfS5rWbZMThIpm+zS0ZE7
 5g0lL7ZQEYa4J53rW7tDaFhVQnDqBe4d+9E/DggByUG9Aku58tlQg7Dk5uGhcxVBzQ2iLg7
 GGwN8lWvlZJ7uE7jOSJDTHwOaH9jx5QSStJV3OpFEN6fLj4CrdahjWMP0jdxWct/9K0FDKM
 sV+KkRRQDU7jvrjgx6hbOhnC6wC68kw0kiX9+CXO7b7DrodCCgpIwtIcqwXrHaJHJmas0Ra
 T1cE3wofBDxwQs4=
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
index bc2e11e801..9e4eca40cf 100644
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

