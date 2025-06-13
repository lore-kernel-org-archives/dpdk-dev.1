Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8362C61DB2
	for <dpdk-dev@archiver.kernel.org>; Fri, 13 Jun 2025 08:42:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4B72342ECD;
	Fri, 13 Jun 2025 10:42:25 +0200 (CEST)
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
 by mails.dpdk.org (Postfix) with ESMTP id 16270402E2;
 Fri, 13 Jun 2025 10:42:20 +0200 (CEST)
X-QQ-mid: esmtpsz18t1749804137t29fb0454
X-QQ-Originating-IP: krf6hvMExDdxCN/GzCDcM9KJ1ppeGZiNw4IoSKMeEOU=
Received: from lap-jiawenwu.trustnetic.com ( [36.20.60.58])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Fri, 13 Jun 2025 16:42:15 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 15836818761092713411
EX-QQ-RecipientCnt: 4
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: dev@dpdk.org
Cc: zaiyuwang@trustnetic.com, Jiawen Wu <jiawenwu@trustnetic.com>,
 stable@dpdk.org
Subject: [PATCH v3 02/17] net/txgbe: fix incorrect parsing to ntuple filter
Date: Fri, 13 Jun 2025 16:41:44 +0800
Message-Id: <20250613084159.22184-3-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20250613084159.22184-1-jiawenwu@trustnetic.com>
References: <00DEAE896AFE0D2D+20250606080117.183198-1-jiawenwu@trustnetic.com>
 <20250613084159.22184-1-jiawenwu@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: OeEhaKIXvy7RIGvrlUby++0XJlF8+Gdz0NEU9GrZO8nCG7MCI6ndDgDp
 67AvBxEu+IeLFDHzdPRlZapku4XzBtD4slEoU0IxRC/fnD8t/RFQGOly3AlwHbBAspv+cVx
 dDn609zBi8PcXQTMHtTDhlg9iSpbzcKxRz+RhGx4ui8fNxrEYq7o+bJ9dORPpBfQ03xrWTp
 dkN5c2tOgDdpyg1ycEcP44ddrlP5kpkXSUt0jT9Xa2YEZF0shHjd0McZ3sTSJdLGyM/oRqC
 Mgug1IukCmHcNJuAiuamYKdbtcUHuArjCHxPVD7IDp1OJ5aRaAA6wWC9xOTCS7XCDG857Fe
 4fKVvnzoPqCZqGUqH5ultVcLVjkvkOvH3T+4auD1NC7Um8Kv7FSUZTIpUFQltt8/6XKaNGX
 72rvXr+ZoktKuiydrAarV3uZAxmFUsNXsLvNMZ677dCV+gMI9IsVn2ZKBkWMVjyOZR64ODp
 zrA5SqBgYo4deq41d4u4+hco/loHKeTkPBJmPzanPQYgdL2IAFixoquBKp9BpovnSdxtNuG
 pbnRAd09YZKcsKKGuwkZellHkfdQCSd/RUaOPdGiYvk+ILozwPhME2fU+tRyoqJ9+IZF7DI
 13NBFXyRViDmdcchcJqvuEgDEEUijqPDla+JhXrO10sBzTjSw5IZdJLMz2skLh4U5Zdln/Y
 wypH1roxcEIVtkP5msJOFR6ylbw1MtC5Zyw/ssfo+L6rhxzvnaaEbFZ9A5JO8riQgFxjJMQ
 PR39GaPZ29tFib4q5ZusJv9iZLnYOOwI7hDbkNuz/7oAIJEkABx5rqcLZETwE7c0LvxB56g
 SAkglCytxYwS5NLiHIpFhJFyvM5fVkvqGlLf2hkeHXv4+Ns4X1/avqkNATP64OTUcUpFibt
 qLL3Sx5K4gKorXmEsJ6f1kfNGK6obaeF7hhG/xMYs073/rmTdirNDHsY4IFrURWr4EYIWlW
 4ksmy0y35TL9xRZizhxkfqr/2uCGuVevTsR4Z64TNSC8+vKYAiHTpduwG2YAZrSgI2RRy2C
 9QRK8bOI9y/5pSezWFEbix+jypTznKIGbXHBGlSw==
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
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

The rule is incorrectly parsed to ntuple filter when setting the pattern
likes:
flow create ... ipv4 / udp dst is ... / raw ... / end actions ... / end

It causes the rule to be created successfully, but not works. Fix it to
parse for FDIR rules.

Fixes: b7eeecb17556 ("net/txgbe: parse n-tuple filter")
Cc: stable@dpdk.org

Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 drivers/net/txgbe/txgbe_flow.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/txgbe/txgbe_flow.c b/drivers/net/txgbe/txgbe_flow.c
index 1d854d0767..269f0b54e3 100644
--- a/drivers/net/txgbe/txgbe_flow.c
+++ b/drivers/net/txgbe/txgbe_flow.c
@@ -361,7 +361,7 @@ cons_parse_ntuple_filter(const struct rte_flow_attr *attr,
 
 	if (item->type != RTE_FLOW_ITEM_TYPE_END &&
 		(!item->spec && !item->mask)) {
-		goto action;
+		goto item_end;
 	}
 
 	/* get the TCP/UDP/SCTP info */
@@ -490,6 +490,7 @@ cons_parse_ntuple_filter(const struct rte_flow_attr *attr,
 		goto action;
 	}
 
+item_end:
 	/* check if the next not void item is END */
 	item = next_no_void_pattern(pattern, item);
 	if (item->type != RTE_FLOW_ITEM_TYPE_END) {
-- 
2.48.1

