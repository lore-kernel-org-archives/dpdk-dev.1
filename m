Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3EE6C88E64
	for <dpdk-dev@archiver.kernel.org>; Mon, 14 Sep 2026 11:49:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0B00640DD8;
	Mon, 14 Sep 2026 13:49:34 +0200 (CEST)
Received: from mail.amicon.ru (mail.amicon.ru [77.108.111.100])
 by mails.dpdk.org (Postfix) with ESMTP id C60BC40144;
 Mon, 14 Sep 2026 12:09:44 +0200 (CEST)
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; d=amicon.ru; s=mail; c=simple/simple;
 t=1789380584; h=from:subject:to:date:message-id;
 bh=JjurHh1MvaJ+f9mvpmvnvtWgTXA9VHXh+a0EWBh7Ai0=;
 b=nH7AV9VMXGz12XdimLLg2s5mkta3T/S0FhPZlElxf0JAzAroC9Cx/vICldO25UsqbBA6Vivecr6
 IVkedFVwaZ4PVzeQVFopHedCALtBZSpMypQDZhuHvERyMK4VNUv+Qg/DYOu/Zmn1sgDYKXRxNH9Zs
 5ZiPoLNXyEKlQf0Xq5hT68hJdtFRDJ2LnlQ0Fo1koo11ob/cYGn2O7NV9bfT++2w+U4k6+R/et5yH
 Fz/USdAsSZ/wXGtwLKcxHEO4edtMvZBLeqiNHFilEllnVxPEyde8IvJVQp2Jgc0AGGQTY72vRQfoI
 3uRCRTtuHZE3WUTZV0phP1fBMwfjdigDqAdA==
Received: from amicon.ru (172.16.36.76) by mail.amicon.lan (192.168.0.59) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.27; Mon, 14 Sep
 2026 13:09:44 +0300
From: Artem Novikov <naa@amicon.ru>
To: <dev@dpdk.org>
CC: <naa@amicon.ru>, <rrv@amicon.ru>, <lvc-project@linuxtesting.org>,
 <bruce.richardson@intel.com>, <stable@dpdk.org>
Subject: [PATCH] net/e1000/base: check VF reset mailbox write
Date: Mon, 14 Sep 2026 13:09:34 +0300
Message-ID: <20260914100934.55518-1-naa@amicon.ru>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Originating-IP: [172.16.36.76]
X-Mailman-Approved-At: Mon, 14 Sep 2026 13:49:28 +0200
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

e1000_reset_hw_vf() sends E1000_VF_RESET through the VF
mailbox and then waits for the PF response. The posted write can
fail before the reset message is written to VMBMEM or before REQ is
set, for example when the VF cannot obtain the mailbox lock.

Return the write error directly so the reset path does not treat a
failed current request as a later read failure or as unrelated
mailbox state.

Fixes: af75078fece3 ("first public release")
Cc: stable@dpdk.org

Signed-off-by: Artem Novikov <naa@amicon.ru>
---
 drivers/net/intel/e1000/base/e1000_vf.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/intel/e1000/base/e1000_vf.c b/drivers/net/intel/e1000/base/e1000_vf.c
index 488ac3a94b..86ec1ea058 100644
--- a/drivers/net/intel/e1000/base/e1000_vf.c
+++ b/drivers/net/intel/e1000/base/e1000_vf.c
@@ -253,7 +253,9 @@ STATIC s32 e1000_reset_hw_vf(struct e1000_hw *hw)
 		mbx->timeout = E1000_VF_MBX_INIT_TIMEOUT;
 
 		msgbuf[0] = E1000_VF_RESET;
-		mbx->ops.write_posted(hw, msgbuf, 1, 0);
+		ret_val = mbx->ops.write_posted(hw, msgbuf, 1, 0);
+		if (ret_val)
+			return ret_val;
 
 		msec_delay(10);
 
-- 
2.43.0

