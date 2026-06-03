Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE914CD6E55
	for <dpdk-dev@archiver.kernel.org>; Wed,  3 Jun 2026 05:52:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 36CC440615;
	Wed,  3 Jun 2026 07:52:23 +0200 (CEST)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com
 [209.85.221.53]) by mails.dpdk.org (Postfix) with ESMTP id 97791402AB
 for <dev@dpdk.org>; Wed,  3 Jun 2026 07:52:21 +0200 (CEST)
Received: by mail-wr1-f53.google.com with SMTP id
 ffacd0b85a97d-45eedc94d37so3107745f8f.3
 for <dev@dpdk.org>; Tue, 02 Jun 2026 22:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780465941; x=1781070741; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=VMaN5GzTEinyvtis25MIQ7bS+MBpHkVpHjDMP2xn/Hc=;
 b=sYb5bLtboPRA8Agzmtky6QarXpdwfEJYvHcsiR5ooT0vh/2Ib1RY0WdiCDe+NcT1Do
 X+pOFoLpYzAbrJloaKhbp1L40Qxlr2pTcx3SnifZAd/u5GNWfPzYsww34BMqCx5Eu1dj
 2Kn6Uc81vm3nlzldjnIXrWME1Mb0WnXGEoBrfOg0h2vq3wx0OucbCHzqcQs2+m3s3kF1
 FP9rjf4lFOiQr+Mpmvcn9pnNL7GFZwVH4N+zVErewKIl/mIUijYRI327drcpBej1XgbD
 4WbgYvfOTjfjw7RJYqq2xv4Dlmxzftl7qmGJY4CbqTLRHHgZ9pw9u3fKC0YJ1/WB+gVS
 7M0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780465941; x=1781070741;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VMaN5GzTEinyvtis25MIQ7bS+MBpHkVpHjDMP2xn/Hc=;
 b=mr44syiroq1Af3VtoBuU+G0tn0XDxE8EQArB4gf3M+Y2uMklIuD21m9dFO89ebEY8x
 k+1EL2C52yyB0YaXHgOTxTrMXsH0R0pOO0T1llmjL5vG7wF+J+pS90IMZBKo/4vkV0sj
 +9SpnMmz253mPVgTrZbnLnvnXLsDYUVrjrfB7sAdgMbmumAaW318ooM8qGm9lgNzC+CE
 xtOSxkGBrCR8A+b3yN92ZVmqEljX1zL8qv7thK1OMezVc99klr45kFZNRXHS9r4UME/S
 6W48rlqzPZo6IjyZsaxX/jug4k5Iq276SoqUrbzl49BvFefzd/RdMtxwFd5JaBH1M6Qn
 nadQ==
X-Gm-Message-State: AOJu0YxEdW7OlDpuNwgmG0eDHisJHm4JnkvI96aByrj/cEhBGk7hf8lr
 pFI/WYPJuSaSS9YOlfl4gt0vO93vAM2VcOr/1q0o/62H1VyFHGt5Oxux4dsSRtEQ
X-Gm-Gg: Acq92OGtIErkYjNCG2FSVK0QRlPJTZXPB4r5OZqnPBuAkmhKQSH1qHwWmgQYLoq0wNW
 DQINSfdegp8CiYXXyJk1yJLrET61fqXC/cZyFxPz/0nufxcvTJQPmkoRpWMP8+psOob1Cfgm3VC
 57JAWA9OPtkq+cjPLcTxoiCvsBwkOqzIZdoSsdIwS2jqIJM+z9YHu3pyoirzFXQ+ztWvUBy0Axb
 GqyQ4IkBE6lXXNE2SohJP/idXuvaCdBEjTXZiR8XVmYDz368EDPX5ILk6ANeY79tTZwT4OY7Boc
 gtttwgiTpQ41cEDtSE3GRvhtjEdUkgXlLOr+wPHYU3XbUi5fgqrXF85HBwgX/GuKtZGjOSJT2b4
 EtgUnOlppCHXN9SGznlqY8veOHqw5rGMmnZ4YOs0rCEJn6diUmsBPsLoW7IzSDoGOBfaw2e/wsN
 BuW7pxMDyb0/WKzC7qWOXiva0X/DugaNwGFYJcIne2zDQBF7bua96Via9y
X-Received: by 2002:a05:6000:40c8:b0:45e:f672:40fb with SMTP id
 ffacd0b85a97d-4602183b4f8mr2381843f8f.22.1780465940959; 
 Tue, 02 Jun 2026 22:52:20 -0700 (PDT)
Received: from happy ([185.229.111.129]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f2e4004sm4854281f8f.9.2026.06.02.22.52.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2026 22:52:20 -0700 (PDT)
From: Denis Sergeev <denserg.edu@gmail.com>
To: dev@dpdk.org
Cc: chaoyong.he@corigine.com, stable@dpdk.org, sdl.dpdk@linuxtesting.org,
 Denis Sergeev <denserg.edu@gmail.com>
Subject: [PATCH] net/nfp: fix null dereference in flower ctrl NFD3 Tx
Date: Wed,  3 Jun 2026 08:51:56 +0300
Message-ID: <20260603055211.120315-1-denserg.edu@gmail.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

In nfp_flower_ctrl_vnic_nfd3_xmit(), when txq is NULL, goto xmit_end
leads to unconditional dereference of txq->qcp_q in nfp_qcp_ptr_add().
The same goto from the "no free descriptors" path incorrectly increments
the hardware write pointer despite no descriptor being written.

Replace both gotos with early return, removing the unused xmit_end label.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: a36634e87e16 ("net/nfp: add flower ctrl VNIC Rx/Tx")
Cc: stable@dpdk.org

Signed-off-by: Denis Sergeev <denserg.edu@gmail.com>
---
 drivers/net/nfp/flower/nfp_flower_ctrl.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/nfp/flower/nfp_flower_ctrl.c b/drivers/net/nfp/flower/nfp_flower_ctrl.c
index 6ac2caf367..1fa751a106 100644
--- a/drivers/net/nfp/flower/nfp_flower_ctrl.c
+++ b/drivers/net/nfp/flower/nfp_flower_ctrl.c
@@ -168,7 +168,7 @@ nfp_flower_ctrl_vnic_nfd3_xmit(struct nfp_app_fw_flower *app_fw_flower,
 		 * enabled. But the queue needs to be configured.
 		 */
 		PMD_TX_LOG(ERR, "Ctrl dev TX Bad queue.");
-		goto xmit_end;
+		return 0;
 	}

 	txds = &txq->txds[txq->wr_p];
@@ -183,7 +183,7 @@ nfp_flower_ctrl_vnic_nfd3_xmit(struct nfp_app_fw_flower *app_fw_flower,
 	free_descs = nfp_net_nfd3_free_tx_desc(txq);
 	if (unlikely(free_descs == 0)) {
 		PMD_TX_LOG(ERR, "Ctrl dev no free descs.");
-		goto xmit_end;
+		return 0;
 	}

 	lmbuf = &txq->txbufs[txq->wr_p].mbuf;
@@ -207,7 +207,6 @@ nfp_flower_ctrl_vnic_nfd3_xmit(struct nfp_app_fw_flower *app_fw_flower,
 	cnt++;
 	app_fw_flower->ctrl_vnic_tx_count++;

-xmit_end:
 	rte_wmb();
 	nfp_qcp_ptr_add(txq->qcp_q, NFP_QCP_WRITE_PTR, 1);

--
2.50.1

