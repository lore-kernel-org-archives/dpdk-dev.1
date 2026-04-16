Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0751CFB44C1
	for <dpdk-dev@archiver.kernel.org>; Fri, 24 Apr 2026 07:05:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 44C43402E0;
	Fri, 24 Apr 2026 09:05:49 +0200 (CEST)
Received: from send195.i.mail.ru (send195.i.mail.ru [95.163.59.34])
 by mails.dpdk.org (Postfix) with ESMTP id EBB3540144;
 Thu, 16 Apr 2026 11:03:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru;
 s=mail4; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:
 To:From:From:Sender:Reply-To:To:Cc:Content-Type:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
 X-Cloud-Ids:Disposition-Notification-To;
 bh=Rnqp6rtPfh4KQVNHyFcEZNlaKI9VYxvn+eExYBXtZis=; t=1776330181; x=1776420181; 
 b=fPmFdTqjVsHEXuN21kCok3tAqZ/bMj370tfflG4HQUx66jQwEX5Y8WdmCbricnBkvZsLuLeOnZH
 +1EjPeqJhnXTfpk0SQreju35GxR3lKcAmq6Mj+C8DA4y4jpF2Vzb7+58vaS/VeTqo0x+Z7gWPhbwy
 7BDS2SMmwafp5ffLcvRb6qz62jbDlqBqqSpfvzFpoUJLdQOcxQ+qdf3YMuzZpRuNP9J2s9XQn7Prw
 xoiv0U1PzQVl1E9O83eX4i4SapHFdRQjZzH75JYm2zsktsx/dwaXpaBg7wAnmxHrAzY9HHbeSdyQQ
 RqT6umLZaTSimOhXZ9bVANog92vyHPEorouA==;
Received: by exim-smtp-5c94f89c8c-gnt2m with esmtpa (envelope-from
 <lyulin.2003@mail.ru>)
 id 1wDIcm-00000000CBH-0doz; Thu, 16 Apr 2026 12:03:00 +0300
From: Denis Lyulin <lyulin.2003@mail.ru>
To: Kishore Padmanabha <kishore.padmanabha@broadcom.com>,
 Ajit Khaparde <ajit.khaparde@broadcom.com>,
 Manish Kurup <manish.kurup@broadcom.com>,
 Shuanglin Wang <shuanglin.wang@broadcom.com>,
 Randy Schacher <stuart.schacher@broadcom.com>
Cc: dev@dpdk.org,
	stable@dpdk.org,
	Denis Lyulin <lyulin.2003@mail.ru>
Subject: [PATCH] net/bnxt: fix memset size mismatch in Tx queue start
Date: Thu, 16 Apr 2026 12:02:51 +0300
Message-Id: <20260416090252.2211405-1-lyulin.2003@mail.ru>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: exim-smtp-5c94f89c8c-gnt2m;
 auth=pass smtp.auth=lyulin.2003@mail.ru
 smtp.mailfrom=lyulin.2003@mail.ru
X-Mailru-Src: smtp
X-7564579A: EEAE043A70213CC8
X-77F55803: 4F1203BC0FB41BD949E5EAB5516A89290DF06F0D2DF8E3E79F6E52EAE14C76E3182A05F5380850404C228DA9ACA6FE27B6D6427ED01CE4D73DE06ABAFEAF67057C96A72F187254F78782F5C1F235DA1B249BFCD68258DFAF
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE78BAADB77C21FF6F2EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637AC83A81C8FD4AD23D82A6BABE6F325AC2E85FA5F3EDFCBAA7353EFBB553375663BEDCB502AD08FC08AD02B54E6DF9D9C146DB1AA13DB82BC4BF4A80E85ABFDD48EEF46B7454FC60B9742502CCDD46D0DEDCF5861DED71B2F389733CBF5DBD5E913377AFFFEAFD269176DF2183F8FC7C02F11D39E7306DD338941B15DA834481FCF19DD082D7633A0EF3E4896CB9E6436389733CBF5DBD5E9D5E8D9A59859A8B6E954A0C70C50C109CC7F00164DA146DA6F5DAA56C3B73B237318B6A418E8EAB8D32BA5DBAC0009BE9E8FC8737B5C22498CC43D8C9E04EB0576E601842F6C81A12EF20D2F80756B5FB606B96278B59C4276E601842F6C81A127C277FBC8AE2E8B02DCDCB5FF0CCBAE3AA81AA40904B5D99C9F4D5AE37F343AD1F44FA8B9022EA23BBE47FD9DD3FB595F5C1EE8F4F765FC72CEEB2601E22B093A03B725D353964B0B7D0EA88DDEDAC722CA9DD8327EE4930A8783F69A4C139826B9191E2D567F0EC4224003CC83647689D4C264860C145E
X-C1DE0DAB: 0D63561A33F958A549887B07123190AA5002B1117B3ED696A1F25B9792C08A5BF5FEB6EB1EB183FD09CF0A614B9999B12D69E7FE39063EFC1E618B5D5F965AFD97DA6AD59C166F02B2D1C9E48B6DC60AE2A7E19323554B12787CBDA4B9FA07AC4107E9D3253933954EAF44D9B582CE87C8A4C02DF684249CC203C45FEA855C8F
X-C8649E89: 1C3962B70DF3F0AD73CAD6646DEDE191716CD42B3DD1D34C77DD89D51EBB774225B6776AC983F447FC0B9F89525902EE6F57B2FD27647F25E66C117BDB76D659124C5CD97C51A1F318B929B5B7970BC1D8784B61E3761E303791A127341A785754268BAE3C5ECE53B8341EE9D5BE9A0A4BAEB8A099CE6FF90FFE05D9CB8CC1D0AEBCC7AB9DA5866639A4D55D2591C6014C41F94D744909CE5DDE6AB186FA14AA15C35E0BAFFE8D415811D22EBD454E4C3FCF178C6DD14203
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu53w8ahmwBjZKM/YPHZyZHvz5uv+WouB9+ObcCpyrx6l7KImUglyhkEat/+ysWwi0gdhEs0JGjl6ggRWTy1haxBpVdbIX1nthFXMZebaIdHP2ghjoIc/363UZI6Kf1ptIMVYrk7BQKFwEtlN+yEztlwUWgfrlwq9pMbA==
X-Mailru-Sender: C0FC423AA8FD9F6963CC77E2AC28C4C9661C47036ED8E205B951B70A5BD4BD8E881F61904F92339A0204F27602BC6032CFB1E98417576B9F6EFAE8183A2EAE0DD521319575DF8831E3C55DE776B662A175379CF7CCB93CA93DDE9B364B0DF289AE208404248635DF
X-Mras: Ok
X-Mailman-Approved-At: Fri, 24 Apr 2026 09:05:46 +0200
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

When the tx_queue is started, previous stats are reset.
For tpa_v2 and P7, extended stats structure is used:
`struct bnxt_ring_stats_ext`, so passing wrong size to memset
makes not all stats to be reset. This commit sets correct size of
the structure passed to memset when zeroing-out previous stats.

Fixes: dd0191d5e70d ("net/bnxt/tf_ulp: support Thor2 ULP layer")
Cc: shuanglin.wang@broadcom.com
Cc: stable@dpdk.org

Signed-off-by: Denis Lyulin <lyulin.2003@mail.ru>
---
 drivers/net/bnxt/bnxt_txr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/bnxt/bnxt_txr.c b/drivers/net/bnxt/bnxt_txr.c
index 27758898b0..b6ad37f872 100644
--- a/drivers/net/bnxt/bnxt_txr.c
+++ b/drivers/net/bnxt/bnxt_txr.c
@@ -729,7 +729,7 @@ int bnxt_tx_queue_start(struct rte_eth_dev *dev, uint16_t tx_queue_id)
 	 */
 	if (BNXT_TPA_V2_P7(bp))
 		memset(&bp->prev_tx_ring_stats_ext[tx_queue_id], 0,
-		       sizeof(struct bnxt_ring_stats));
+		       sizeof(struct bnxt_ring_stats_ext));
 	else
 		memset(&bp->prev_tx_ring_stats[tx_queue_id], 0,
 		       sizeof(struct bnxt_ring_stats));
-- 
2.34.1

