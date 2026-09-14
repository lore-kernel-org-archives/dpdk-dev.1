Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7292C88E64
	for <dpdk-dev@archiver.kernel.org>; Mon, 14 Sep 2026 11:50:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1A75C40E17;
	Mon, 14 Sep 2026 13:49:36 +0200 (CEST)
Received: from mail.amicon.ru (unknown [77.108.111.100])
 by mails.dpdk.org (Postfix) with ESMTP id C94B340144;
 Mon, 14 Sep 2026 12:10:43 +0200 (CEST)
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; d=amicon.ru; s=mail; c=simple/simple;
 t=1789380643; h=from:subject:to:date:message-id;
 bh=nafiIUhvQ5FSgXaQNIVErW2T2eg55s2kN9vsD10A45E=;
 b=BSQnG88wKBQ4IAmA85s+EmewFlO9EyURSzo14L+lGA9z4Sr4tjIaFGp/sfOOv14ICWrqFQRVkyW
 Jlg2fKE/sUqp8caNaZJGBdWqVsk+8h0mQmc3jKK5jx0mp1BkIcCKiuwsk4jHva8n3LC28lHRtsd5A
 y9ovPDFp9q1zYdYIHvFr0l4vh0TiMjRHRdiGZ5M0hZ6vGhPNEsc6g/aloL6j8Y1LFA76V9Qo4vWYn
 qOSVRZCByx3zGXkaLTi65ipsNZ/jS0J/jFc9vn0owC7IzCtoQRx3hDWnPRA9n2Ql98x++U+ocpesF
 sBPqUOUrCyjtjjlcSy6y+dNbpWFbSC6k3mVw==
Received: from amicon.ru (172.16.36.76) by mail.amicon.lan (192.168.0.59) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.27; Mon, 14 Sep
 2026 13:10:43 +0300
From: Artem Novikov <naa@amicon.ru>
To: <dev@dpdk.org>
CC: <naa@amicon.ru>, <rrv@amicon.ru>, <lvc-project@linuxtesting.org>,
 <bruce.richardson@intel.com>, <stable@dpdk.org>
Subject: [PATCH] net/e1000/base: check PHY link status read
Date: Mon, 14 Sep 2026 13:10:32 +0300
Message-ID: <20260914101032.55796-1-naa@amicon.ru>
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

The Kumeran lock loss workaround checks the PHY link state before
reading the Kumeran diagnostic register. The PHY status read can fail,
but the returned error is ignored and the link output is used
immediately.

Propagate the PHY read error before using the link state so the
workaround does not continue with an invalid status.

Fixes: 5a32a257f957 ("e1000: more NICs in base driver")
Cc: stable@dpdk.org

Signed-off-by: Artem Novikov <naa@amicon.ru>
---
 drivers/net/intel/e1000/base/e1000_ich8lan.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/intel/e1000/base/e1000_ich8lan.c b/drivers/net/intel/e1000/base/e1000_ich8lan.c
index 0290a7dcb4..816a361fa9 100644
--- a/drivers/net/intel/e1000/base/e1000_ich8lan.c
+++ b/drivers/net/intel/e1000/base/e1000_ich8lan.c
@@ -5548,6 +5548,8 @@ STATIC s32 e1000_kmrn_lock_loss_workaround_ich8lan(struct e1000_hw *hw)
 	 * stability
 	 */
 	ret_val = e1000_phy_has_link_generic(hw, 1, 0, &link);
+	if (ret_val)
+		return ret_val;
 	if (!link)
 		return E1000_SUCCESS;
 
-- 
2.43.0

