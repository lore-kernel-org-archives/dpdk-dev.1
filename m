Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D76606A7D9
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 Oct 2026 11:43:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7F6BE40A79;
	Tue, 27 Oct 2026 12:42:40 +0100 (CET)
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
 by mails.dpdk.org (Postfix) with ESMTPS id 9312B406BA;
 Tue, 27 Oct 2026 12:42:37 +0100 (CET)
X-QQ-mid: esmtpsz17t1793101353t3229d17a
X-QQ-Originating-IP: k2BpxvqaUrgWTdBc4iCeAeaJ9d1Y88WYoW1e2nO1JN4=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.227.112.25])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Tue, 27 Oct 2026 19:42:32 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 17800596175833570588
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v12 07/17] net/txgbe: fix link speed display info for 10G mode
Date: Tue, 27 Oct 2026 19:38:23 +0800
Message-ID: <68976B22FBBC02BA+20261027114218.9724-8-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.55.0.windows.2
In-Reply-To: <20261027114218.9724-1-zaiyuwang@trustnetic.com>
References: <31C12A7AAC7E19F2+20260827114309.10530-1-zaiyuwang@trustnetic.com>
 <20261027114218.9724-1-zaiyuwang@trustnetic.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: NXz8NrbNT+i24YU0SeikzWY15GsEtepR2zzhqatbJmwJY760vYufNu0U
 ZUoQVvj6MQbTXv4m9CQ/pknyS2MRRnpiMXh5+Oq0HWfdTCvwAHWP9RmvJbJO/YyVF2ycbDY
 QrNdG6d/wtulyb9Bg8fxJoz0XBpRw354J4cLUzE1yarFUxTUF4F8NQQXa5Ew7PwQ9Qcqf1g
 fh2t1bufNDU67LyeWp6c9CnYmnYLYr6LhQbuNzc1eVD+nJV2Ozc4qa7YwwLbePl5lwYVqmc
 HYtq1uXXmrhiM6kvU4xrHQ3UpCI2QvNjWOkb8KS7GqSLDTTuLWXMt9LZL8uZP26tY/zju2c
 gk2MOHXB15VskUNMG5NwgD194jh9xU51JVN6rYlmMfKiFwkX7iGhEpadS2zSt6DFHQXHDcJ
 +PABdQ7FzKhcrb6I9iH0es3dFZ8zcVL9Hv031hzEH0QG+57/iZsOw9Ead7YqO4DYsstPUtw
 uBLQcgN/ufKBicrX5KEXERQ1E4QrLV/0aejBoH6ZVv1km+7ONvFkoORBCe3jV1gbL58fTLu
 7cepCDlbb91bu35z4W7v8IH59IESw/XYe9AGZQAwMuGzCAPjW7UAx+LZOcWr3UWjclxvfbX
 C1x1XE+qqmjtjNB1hOi1YJibeaGgcaqy1bua5rhL8pgRbZwMh5S84njVNuwud1E1MIRyzfd
 QU07XO3wNmEErC9AzBKrpCMK3ZwQwF/vf7VQfgLXRKJRLJduD+1qBrIw9xhh7q/E6QNQneg
 ho5fxX6XSylbesl07sVm7RAy8xns0lIRP8sAyPSdr7/VQaOi7uDh8OjvgQMGWwMKNwepA4y
 aePxsKUh/oeGvb+Bif9QrfQBQ0SPHIwqVKKyOiXX0vvoxGouH1iRpFt0C+4E1XUgStlJLZj
 VAHLRRa3Je/0wLj1LnHLFyIQZUmn5j4/R71k5gMts+q4ANqz9wbtqQ2vVXgpvL0rzhcRQFz
 QFn/T+JzF21D4HCaJAEjUxAWxIMBHKvB1qoAFo2wXfJDNuoLox1ey3/UAy3zq18XQ/NkA27
 9P8xRWo1xmxfIyspjq1Yk2F5Eh7y1x85xhgTlXlc1utd+zqvmJ/80EQ8MHPOfrVZKtTZqWh
 IM1pKV4pKOxw5qEsAIHi9UP0I9L359tHLlToq4b3vSUh8CJT4VUqvk59BfKBvBJ3v6MkETE
 +jTt34sgpNWPSZo=
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
X-QQ-RECHKSPAM: 0
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

When an AML40 port links up at 10G, DPDK reports the speed as 100M
instead of 10G. The 10G link status bit is not recognized in
txgbe_check_mac_link_aml40(), so any non-40G speed falls through to
the default case (UNKNOWN) which is then reported as 100M.

Add the 10G port status bit recognition, so a 10G link is reported
as 10G.

Fixes: abf042d32b39 ("net/txgbe: add Amber-Lite 25G/40G NICs")
Cc: stable@dpdk.org

Signed-off-by: Zaiyu Wang <zaiyuwang@trustnetic.com>
---
 drivers/net/txgbe/base/txgbe_aml40.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/txgbe/base/txgbe_aml40.c b/drivers/net/txgbe/base/txgbe_aml40.c
index ab7012608f..4b63810b16 100644
--- a/drivers/net/txgbe/base/txgbe_aml40.c
+++ b/drivers/net/txgbe/base/txgbe_aml40.c
@@ -85,6 +85,9 @@ s32 txgbe_check_mac_link_aml40(struct txgbe_hw *hw, u32 *speed,
 		if ((links_reg & TXGBE_CFG_PORT_ST_AML_LINK_40G) ==
 			TXGBE_CFG_PORT_ST_AML_LINK_40G)
 			*speed = TXGBE_LINK_SPEED_40GB_FULL;
+		else if ((links_reg & TXGBE_CFG_PORT_ST_AML_LINK_10G) ==
+			TXGBE_CFG_PORT_ST_AML_LINK_10G)
+			*speed = TXGBE_LINK_SPEED_10GB_FULL;
 	} else {
 		*speed = TXGBE_LINK_SPEED_UNKNOWN;
 	}
-- 
2.55.0.windows.2

