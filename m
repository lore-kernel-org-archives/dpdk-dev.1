Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49A93CA5FA1
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Sep 2026 11:21:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2319F41140;
	Tue, 29 Sep 2026 13:21:52 +0200 (CEST)
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
 by mails.dpdk.org (Postfix) with ESMTP id 6B9BF41143;
 Tue, 29 Sep 2026 13:21:46 +0200 (CEST)
X-QQ-mid: zesmtpgz6t1790680903tf63670e8
X-QQ-Originating-IP: PSo9x0pmonIgOV78F5h5e5yPY8g6mJX4fQBU24e3zDY=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.227.112.38])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Tue, 29 Sep 2026 19:21:41 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 8878897796165999725
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v5 05/15] net/txgbe: do not force reconfig on link retry
Date: Tue, 29 Sep 2026 19:18:05 +0800
Message-ID: <C4A860C232CD57C4+20260929112119.4516-6-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.55.0.windows.2
In-Reply-To: <20260929112119.4516-1-zaiyuwang@trustnetic.com>
References: <20260827114309.10530-1-zaiyuwang@trustnetic.com>
 <20260929112119.4516-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: NpiO5ZMYC9gn3XFYGCfo1BZoc58TsU6roD1V8HSG1Np3q8IFZhfOtV+a
 CoIUVZbgN0IIBjWSNSiEHV92T4giI31RsNEKl37aApjDjp8SBsXwejimcVX5i365l/D5iHB
 KyOqv7185zxXWYZ17Ohcf1b8BdbywoA6eHBSpMTIn3qVTswDw6vIgB3o3P03pVQWUn5Qp/Y
 2ukCW8nFJCdm/OsIS03StkhKdvJKvDNL7KR8JjzG0wyS9Jms9faIROBhUjO3jAww5XOieiX
 mTu40kZVo5VW6o1N9wUu1+irQ9KA2kvwjToTF3o4NBIcOLlz7fwRpSUiOl6VEDQaf+iC53U
 yB7n/Q7MQW2YSPtDjFFTwdRcnhETlVPJj0UWk2tQRMFjuzUp/zn899MWnqYtnHzlEAFkOkg
 1Hk7aTlEgBYEihGOstfU4Od0do4oZ7qNP/qys7peYZhxt1M8yteVtsOtISfhOwo24nYKKEv
 6lQUJ+Q4NObyckCduxyJNVqqoJs74ZM9uJU03SltafkYCPdg4SpChOjpAbx2UNSArMOK52C
 oaxvZGqo3aWlfW+NplpZe+mlNSyBOQqYFAKsWcS+iuTJ6zLN5PvOBv5kDuLdQEhODnE5tVi
 V9t/KxsBkBiLrAOtnrn87x/Cy24JHcdUfpuMeewKAwQWBYaiNbECRhBRliXkGkZsuM8gQOK
 7XMILlYBDbmzmZRX0LQ8THoMn7vWbeg8G99Xvodr0sBTZucKaAD1ZJLuYQBPJdAXZ6Faoxn
 6RavOpJC0KWeY6mxRtkewdGNwrVSFws1q5YUVEJa5fiafs4EC1m6VZfz9+ZDmcHKdbJQsbb
 WZUQWRH8PEHpz11dS1bQeBtvAzCcsu7JxVRWb4g7Ql7IixCOeCDrTGNtI64RCNxczqh2SBO
 JeYQ+KWNDGPvJc2zrjfy51lWdAAXJW7AiwkVclLvhfBjlJ5NerYj0fO4wnEGu8/gTHjoivb
 TmByeYc2vey+T3+YTtLMy1YsvQGPKWsk5gSCDzMiQbBxync1OzAsR45kjRzlFZMLtn2hAFy
 iqKqnsja+od0fDZXhdj3awyZfGnfd4SoEXRHspyzJAm4KVzIY8JzJjFiLC7P+e61MTkMAOx
 jA10Gx2HhrD6pZV4G/WjfU/g10DTocy0A==
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
index ae15c0f440..c50f7df9ed 100644
--- a/drivers/net/txgbe/txgbe_ethdev.c
+++ b/drivers/net/txgbe/txgbe_ethdev.c
@@ -3303,7 +3303,7 @@ txgbe_dev_setup_link_alarm_handler_aml(void *param)
 		return;
 	}
 
-	hw->mac.setup_link(hw, speed, true);
+	hw->mac.setup_link(hw, speed, false);
 
 	u32 link_speed = TXGBE_LINK_SPEED_UNKNOWN;
 	bool link_up = false;
-- 
2.55.0.windows.2

