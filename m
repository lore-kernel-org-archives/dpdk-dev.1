Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3281CD8C92
	for <dpdk-dev@archiver.kernel.org>; Mon,  8 Jun 2026 08:31:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EBE87402AD;
	Mon,  8 Jun 2026 10:31:02 +0200 (CEST)
Received: from mail.amicon.ru (mail.amicon.ru [77.108.111.100])
 by mails.dpdk.org (Postfix) with ESMTP id A72B4402CC;
 Thu,  4 Jun 2026 18:14:23 +0200 (CEST)
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; d=amicon.ru; s=mail; c=simple/simple;
 t=1780589662; h=from:subject:to:date:message-id;
 bh=xh1rSjunKZkM7BY/98OdfOQw9tkpIMNL0RRV2b+LACQ=;
 b=icH+MY/0c/RnKBmlCMZUlZC63fc/8+kPD8uMNaVkuK4SC9SzEmOSSoFE/hsv2xNJxlrqQOM0ynI
 IOTz8gQJqsz+ckqCdHyJf2heCLld/vZvGQgNRoD8wmf8Ef5i9KQ/iH9KvAc6LU8a06vO9g2WhSpI5
 8MuI5STAbchIXmOSzjVWn99zPQLQXLDUJiL3WZF641kEQ6570f1K4mLEforBSEtuPFLKZv+F3SP1w
 Ut5W3HixZlS9rNTaHRwtVbxWVmU5OWDH07HWqveJmLHoigUmJsi9r6VfRb+gbwLcbZQFzx8++C04P
 ny3Zh4GrReA3hT6yiN6DIff8ysbOBrYUExUw==
Received: from amicon.ru (172.16.30.5) by mail.amicon.lan (192.168.0.59) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.27; Thu, 4 Jun
 2026 19:14:21 +0300
From: Artem Novikov <naa@amicon.ru>
To: Vladimir Medvedkin <vladimir.medvedkin@intel.com>, Qi Zhang
 <qi.z.zhang@intel.com>, Jeff Guo <jia.guo@intel.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>, Artem Novikov <naa@amicon.ru>
Subject: [PATCH] net/iavf: remove unreachable hash action case
Date: Thu, 4 Jun 2026 19:13:53 +0300
Message-ID: <20260604161354.95602-1-naa@amicon.ru>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Originating-IP: [172.16.30.5]
X-Mailman-Approved-At: Mon, 08 Jun 2026 10:31:01 +0200
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

The hash action parser stops iterating when it reaches
RTE_FLOW_ACTION_TYPE_END. The switch below uses action_type copied
directly from action->type inside that loop, so the END case cannot be
selected.

Remove the unreachable case. No functional change.

Fixes: 7be10c3004be ("net/iavf: add RSS configuration for VF")
Cc: stable@dpdk.org
Cc: jia.guo@intel.com

Signed-off-by: Artem Novikov <naa@amicon.ru>
---
 drivers/net/intel/iavf/iavf_hash.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/intel/iavf/iavf_hash.c b/drivers/net/intel/iavf/iavf_hash.c
index 217f0500ab..7ce7b86d8e 100644
--- a/drivers/net/intel/iavf/iavf_hash.c
+++ b/drivers/net/intel/iavf/iavf_hash.c
@@ -1490,8 +1490,6 @@ iavf_hash_parse_action(struct iavf_pattern_match_item *match_item,
 					       rss_type, pattern_hint);
 			break;
 
-		case RTE_FLOW_ACTION_TYPE_END:
-			break;
 
 		default:
 			rte_flow_error_set(error, EINVAL,
-- 
2.43.0

