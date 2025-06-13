Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4313C71135
	for <dpdk-dev@archiver.kernel.org>; Fri, 13 Jun 2025 08:43:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3DF2F42EC1;
	Fri, 13 Jun 2025 10:42:35 +0200 (CEST)
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
 by mails.dpdk.org (Postfix) with ESMTP id 6630142EAB;
 Fri, 13 Jun 2025 10:42:31 +0200 (CEST)
X-QQ-mid: esmtpsz18t1749804149t06a79eac
X-QQ-Originating-IP: 77E0UVksIogFspcuhXis+0DcoM/JvBvuAcKIhBwaOpU=
Received: from lap-jiawenwu.trustnetic.com ( [36.20.60.58])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Fri, 13 Jun 2025 16:42:28 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 7980477468027955435
EX-QQ-RecipientCnt: 4
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: dev@dpdk.org
Cc: zaiyuwang@trustnetic.com, Jiawen Wu <jiawenwu@trustnetic.com>,
 stable@dpdk.org
Subject: [PATCH v3 08/17] net/txgbe: fix reserved extra FDIR headroom
Date: Fri, 13 Jun 2025 16:41:50 +0800
Message-Id: <20250613084159.22184-9-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20250613084159.22184-1-jiawenwu@trustnetic.com>
References: <00DEAE896AFE0D2D+20250606080117.183198-1-jiawenwu@trustnetic.com>
 <20250613084159.22184-1-jiawenwu@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: MDeaZQDDejThVO8uHojW1WSK1XjfvoCp3Gp/xmOy/5/Uz5wgk8JqEEqG
 7zCJ0rSEgLbBbwkSF0d2V/zQlQt5ULqcLQMQcAjke7tgs8sztRJTUG80+/cQY5WjB24ZRI1
 6ctdGd47RZ1/t8b1a5cJDhMyrxnadDmO5UjgWLGFsMMTAZRX5XqaUHDMakTe/jSmnW7rGGy
 ke7Hsj9qFAdLALjAnaXH/Q8SYpkINXQTQp+2Et2vOdjBC51yJOjveSYwkeVgw42feDSLIgB
 PHIcURD05vUCTfYYBMPsVClNLhl1OTwgk7lTiC5MbJ8XJI04cRwj/NJwPPf0llu5HXx8TqH
 QCF1XHvGFvW3HCIRGGYjMmI7xJ6Fqv9UevoyNB6FwNiEOyMrWS6HaTLlDYtOk7/e2YcBVJc
 5GTGYjum8xPy1A2TCi3EHvsIuqubk99UeeRKhJjNI6EvFrlZWo61eZdioyJeyUZPYm9bfb6
 9V6saWT8nAuQLbBpgpIa7s1g7E8N3xr+K258SvsxLc6hYQnsakZQK2VdyWto7rpz8HVRTDe
 +VQdRSOMyI5rIB2OYfUCWnobhm8T3NYBGI9CWAvJRGzhKnbALbxcjJwUWEXPrlwgqoGLQNa
 0L2Tw3q1O/9i+n2UMnfJs0He5AsKt8K9mgoDjL7OwOGO3tcjLvUHRm81qhqUuINyI2uZfw6
 O5X+tqR95b3C1m9z1j8l9kfkYQuZG3OHyGEaCdDH/Iint7pNjZAvTnB+Uy7olrpZu4g5GyX
 xslotT3fiNPGt+UuihCJwlV9TNwLwWI4jKdkyKqwyow2gI1rVBlsP1dSl0GQ1WOVcr0maOK
 9Hwhz6Iha1cRV/qCvEXfxtCONV76MO6r+qTsHTPpGxBqmC+3aAfqJAstEN8lxB4K0oN2btG
 RASYewTV0KpLawt8tzJsIYJcP2pZj/VwHY4qD40mZ01K0PAVtqZAoSlhzDTVpcaszFfhGv9
 OxgI/Yg/7iJ8fGJSjPUdK6wNbHiCBDErq3+L1ATDM46TMEoldGXL66AlPNqoSyo9R8ry8yB
 duwhwanunsa+KMqCXICMRQlFW6LWl1tjKN2oFpTw==
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

Remove redundant 256KB FDIR headroom reservation. FDIR headroom was
already allocated in txgbe_fdir_configure() when FDIR is enabled, the
second reservation resulted in 256KB less available RX packet buffer than
the theoretical size.

Fixes: 8bdc7882f376 ("net/txgbe: support DCB")
Cc: stable@dpdk.org

Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 drivers/net/txgbe/base/txgbe_hw.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/txgbe/base/txgbe_hw.c b/drivers/net/txgbe/base/txgbe_hw.c
index ae2ad87c83..76b9ee3c0a 100644
--- a/drivers/net/txgbe/base/txgbe_hw.c
+++ b/drivers/net/txgbe/base/txgbe_hw.c
@@ -2106,9 +2106,7 @@ void txgbe_set_pba(struct txgbe_hw *hw, int num_pb, u32 headroom,
 	u32 rxpktsize, txpktsize, txpbthresh;
 
 	UNREFERENCED_PARAMETER(hw);
-
-	/* Reserve headroom */
-	pbsize -= headroom;
+	UNREFERENCED_PARAMETER(headroom);
 
 	if (!num_pb)
 		num_pb = 1;
-- 
2.48.1

