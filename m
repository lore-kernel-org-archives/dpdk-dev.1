Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBD45E9A02C
	for <dpdk-dev@archiver.kernel.org>; Wed, 18 Feb 2026 16:05:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 65DEE40613;
	Wed, 18 Feb 2026 17:05:03 +0100 (CET)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47]) by mails.dpdk.org (Postfix) with ESMTP id 62CA3402EE
 for <dev@dpdk.org>; Wed, 18 Feb 2026 17:05:01 +0100 (CET)
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-48336a6e932so33804115e9.3
 for <dev@dpdk.org>; Wed, 18 Feb 2026 08:05:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771430701; x=1772035501; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8RCRBTbTaFBi75Llu3HmyDN+ZiaSdsAlLuqz6Fopa2c=;
 b=Ug5XNly9UUTShr2fRie46erQp2JVeypjBJLwPybk/DifUyyEBgOBF/i0Xw32Jb7Znw
 565IDzrfGweOzRTQ6Z+fQDiUR8WCEZ2sZhdbQNP0C1ms0FKcFZ5LXQ5x2Vyq5QyZL+Xh
 NzGDU0l0sYb9WDkRMUYQyL+RGnhM3oTrCHa7hRo0347rdzvP4ZiwpSJMIdtYowNNUPXv
 K03ZGBsrVjMuOhZ2bkAi5TEOtZ/TLc4/SUOaXXcJnApoKc0zDyXs2oWIfhJYt0gEAfV3
 jJhyvblTvSlgpKal8I/2Bj8uqRoHCrMN730g1wF3oo7Tb9I4yLM5TgyawYk8sjHEKBT1
 Vlww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771430701; x=1772035501;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8RCRBTbTaFBi75Llu3HmyDN+ZiaSdsAlLuqz6Fopa2c=;
 b=h7aNMydLavvJPX3zWZ8UJf4VpAp5vGJAzjlUMvwRv69ug/98lDscORqR4PJomyY9af
 LUbIU0qI+Mvz1txzjrkrHZ0QcT5ZoPw1LIjFJBoCk+Ixsx6Tu5QeChMeJZpZgg0bDiFM
 0Lv/IWB2WotunrodsrilQJMg0RP77RxMM3ak94ylvEGhRKQL7mib8KkeI+0omqLnvDbG
 OUYeTbBegBux7CmBp/eybF70Ow9xvoGKR4HbjtJKeJFmuBMuNT/gWcBU0HqMa68zx2hG
 1MeyCMGRuXOvJnmV1W1buv4T0+/PkXChkbFDG0CRIMFYM81ZHwCpSOPeZcFfs3zT80gG
 D5wQ==
X-Gm-Message-State: AOJu0YyWoAxp8D8i24NdrjWPMtii0W4/Sy8k78226l19hyXHhAVmSogT
 /+Scm0NP0ySWIL362Gq3HmNdQ08HBsl3up/oQ26FzmlILSn5XEeYipPA
X-Gm-Gg: AZuq6aJ55oIPxfi16qfa2kFBX+zypfVUYghqnLGLobdM7LNkj09xhKRv5XGkQl2YkkJ
 DV2lq+gF3ptTVNKAjjOj1IC1dpgQNvwiogH9rBG7BP72YvLXdPGk51oMdFrfru7WGHEe8XYBTKX
 ahwo24SbOXKjYG7xucCVVvT4oQsa6/AQzfbTMm4MT9F4J12EPXB74N4DnEFxtLuM+UezWDh3LvK
 kOlDfe2k/OsJl1giul83ChdoedFqsxhccPNlQy2bfyhmtJ2XCnRWQdeUPlf98lIUELEOb84T6wc
 AtO/xeBU8Fnz2S+bb3EJbkGFGR3qj20WO7gE2KJ2YWE6rvgGIFssBq8FZ8mFfL1kahBihajDx9a
 CdSflj6SszS2K4VUqHYdmD8NnGZ0k8naGCppUR5vs9fFVdwo29I4w2SrdgHF2dwSTO2ppUSQBCo
 zLjrSIsLvJ6I+CUQuTVenfa8L64SEu61/vTPHz
X-Received: by 2002:a05:600c:c491:b0:47d:3ffa:5f03 with SMTP id
 5b1f17b1804b1-48379be825emr270359825e9.21.1771430700606; 
 Wed, 18 Feb 2026 08:05:00 -0800 (PST)
Received: from freepad.iliad.local ([213.36.9.41])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4835dd0e327sm604619175e9.14.2026.02.18.08.04.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Feb 2026 08:05:00 -0800 (PST)
Sender: Maxime Leroy <maxime.leroys@gmail.com>
From: Maxime Leroy <maxime@leroys.fr>
To: hemant.agrawal@nxp.com
Cc: dev@dpdk.org,
	Maxime Leroy <maxime@leroys.fr>
Subject: [PATCH 02/11] net/dpaa2: fix rx error queue memory leak on port close
Date: Wed, 18 Feb 2026 17:04:44 +0100
Message-ID: <20260218160453.142311-3-maxime@leroys.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260218160453.142311-1-maxime@leroys.fr>
References: <20260218160453.142311-1-maxime@leroys.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

The rx_err_vq is allocated separately with rte_zmalloc() in
dpaa2_alloc_rx_tx_queues(), but dpaa2_free_rx_tx_queues() only frees
its q_storage contents via dpaa2_queue_storage_free() — the struct
dpaa2_queue itself is never freed, leaking memory on every port close.

Add the missing rte_free() and NULL assignment.

Fixes: 46d02eeaaeb8 ("net/dpaa2: fix queue freeing")
Signed-off-by: Maxime Leroy <maxime@leroys.fr>
---
 drivers/net/dpaa2/dpaa2_ethdev.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/dpaa2/dpaa2_ethdev.c b/drivers/net/dpaa2/dpaa2_ethdev.c
index cef819650b..b75b934b17 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.c
+++ b/drivers/net/dpaa2/dpaa2_ethdev.c
@@ -691,6 +691,8 @@ dpaa2_free_rx_tx_queues(struct rte_eth_dev *dev)
 		if (priv->flags & DPAAX_RX_ERROR_QUEUE_FLAG) {
 			dpaa2_q = priv->rx_err_vq;
 			dpaa2_queue_storage_free(dpaa2_q, RTE_MAX_LCORE);
+			rte_free(priv->rx_err_vq);
+			priv->rx_err_vq = NULL;
 		}
 
 		/*free memory for all queues (RX+TX) */
-- 
2.43.0

