Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88BFCC5ACD3
	for <dpdk-dev@archiver.kernel.org>; Fri, 20 Feb 2026 17:06:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D54BB40659;
	Fri, 20 Feb 2026 18:06:29 +0100 (CET)
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com
 [209.85.160.171])
 by mails.dpdk.org (Postfix) with ESMTP id 2720E40612
 for <dev@dpdk.org>; Fri, 20 Feb 2026 18:06:25 +0100 (CET)
Received: by mail-qt1-f171.google.com with SMTP id
 d75a77b69052e-506989e8516so19098071cf.0
 for <dev@dpdk.org>; Fri, 20 Feb 2026 09:06:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771607184;
 x=1772211984; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Zrxd7VzydPBG1Kx0iDxD87oC4ndq/lrvRO78GtBcCeY=;
 b=gH9d0XtySdn4AmwHBc0TZJFcHnSUOoT+/Twxz7b12wubBKSVElFoqBlOALahHdPS2+
 wcnmbttVYi++L0PgFWHWiwKtO06p8e2B1QnfyanrVTC0eVqQTZBCwW4zVhrGV+i6OSUT
 HcdFcwCAWVK0vWSPmv7d2v33w8iWqVegxjhgZwHXKbjs0pSgNEvNaIpOyQ2jfZ/sAGlu
 xHOw0DzAx1ltGIu0CRjkPgv38JEJlZGMxBNNxWYFUe6QeQqFs909IboHldkBKO/sQCne
 rLrnINNaHu/kzyEBAOarIBkq7xYtAH372ozqM9n3x0B5cuRwbFgUtArk3okgY1sD9+DO
 8HNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771607184; x=1772211984;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Zrxd7VzydPBG1Kx0iDxD87oC4ndq/lrvRO78GtBcCeY=;
 b=C4sJjqrBUnpVHQ6j4BONaGLkWd7LcPDLA64a7w2gk54S431fEZrfcbZkKwfl+Fr/CC
 BEN3ArOHhQYPWyaRGym/4RiD077z7Z1dN/vEntR2pU+oXr1wjmTe4V1ZZDOZXTe3T2jr
 R5yCCA53WJQUSXZ5lNiVlMHulkaQavjQyzKXSiYNugl2SQJfHQULtrXuNVV28qGlgqE/
 hhtE2USb2A3+Hpq6EJ2bba7he76HeR56LaCd7GaTj4nbo0DK2594yIrHwdctQyoC1yzg
 lmamBvqTTgJavpCkU0rrORguMzkLOphN83DF5/5E9AoVKOZymX2QtlCV/pf7x12c36nt
 dn9g==
X-Gm-Message-State: AOJu0YwY9Lx7ZEK0xpMfEtpPyOL+7TvevkiraWKq9NHAqo2o8cZLBWKw
 9gAwFX7iTU/gLhrKQ7V/jtLK02gscCCU2FevYSq43oE5wKoh9BQD/4QtJmegw4y6vTB8BWMnfCQ
 IdA/q
X-Gm-Gg: AZuq6aLED9LFOfOR+YEV7me44zsM572r2ofbQ3HeTmfW8J3nc5neezUtiKAOwzFH4wu
 3TxufL/LM79QfLKnFY6tRqCoQCsaMG7hxmwZ94M+ADrR/3Q6BYhcoMC9mJxx0UAZcBlUtXOYWaP
 RIWQZTD2Dzyj3ad+qZlNGuAhi8BFo0p2NmzA/Y5Jcb/++5NQV80KHYVBGm4F+zwTSw0dP7ymME7
 wqDqx5UKSgq4rZsvCi1aXBY3GAgCvgNZqB3tQtKe3kEZUt+857CjwtC5amorvFCqW51zvVpjTlC
 +Fg1WGDr8ylDx6BwE0gErH2eCIuvx1Ede2u9ky229FMmd+JGtxv+hcByFlSzfJfj+0dFmT6FzOf
 zWoOt0TpDnSh9uBmgwEDt//Xn2OW+QmoSCWMhuAIX9oN2kS1qMqvBi9aPUBujqBOSqAvhngafQD
 OXIhWLS+hj5dpbxNHh7wE3VTkOR6fJsDcqECIVGw6Knn4MwFR9HlSlZUdvempNFdQ3dqM8yKjy
X-Received: by 2002:a05:622a:1807:b0:502:f01d:1b43 with SMTP id
 d75a77b69052e-5070bbe4773mr7396181cf.29.1771607184408; 
 Fri, 20 Feb 2026 09:06:24 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-50684bc39e6sm276277591cf.31.2026.02.20.09.06.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Feb 2026 09:06:24 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	stable@dpdk.org
Subject: [PATCH v4 05/10] net/tap: fix resource leaks in tap create error path
Date: Fri, 20 Feb 2026 09:02:05 -0800
Message-ID: <20260220170614.75560-6-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260220170614.75560-1-stephen@networkplumber.org>
References: <20260215195348.557945-1-stephen@networkplumber.org>
 <20260220170614.75560-1-stephen@networkplumber.org>
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

Correct two leaks in eth_dev_tap_create():

- process_private was never freed on error_exit. Add free() before
  releasing the port.
- If the process_private malloc failed, the function returned -1
  directly without releasing the ethdev port allocated by
  rte_eth_vdev_allocate(). Jump to a new error_exit_nodev_release
  label instead.

Bugzilla ID: 1881
Fixes: ed8132e7c912 ("net/tap: move fds of queues to be in process private")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/tap/rte_eth_tap.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/tap/rte_eth_tap.c b/drivers/net/tap/rte_eth_tap.c
index 45ca32cfb8..9b38d1f50b 100644
--- a/drivers/net/tap/rte_eth_tap.c
+++ b/drivers/net/tap/rte_eth_tap.c
@@ -2010,7 +2010,7 @@ eth_dev_tap_create(struct rte_vdev_device *vdev, const char *tap_name,
 	process_private = malloc(sizeof(struct pmd_process_private));
 	if (process_private == NULL) {
 		TAP_LOG(ERR, "Failed to alloc memory for process private");
-		return -1;
+		goto error_exit_nodev_release;
 	}
 	memset(process_private, 0, sizeof(struct pmd_process_private));
 
@@ -2200,9 +2200,12 @@ eth_dev_tap_create(struct rte_vdev_device *vdev, const char *tap_name,
 		close(pmd->nlsk_fd);
 	if (pmd->ka_fd != -1)
 		close(pmd->ka_fd);
+	rte_intr_instance_free(pmd->intr_handle);
+	free(dev->process_private);
+
+error_exit_nodev_release:
 	/* mac_addrs must not be freed alone because part of dev_private */
 	dev->data->mac_addrs = NULL;
-	rte_intr_instance_free(pmd->intr_handle);
 	rte_eth_dev_release_port(dev);
 
 error_exit_nodev:
-- 
2.51.0

