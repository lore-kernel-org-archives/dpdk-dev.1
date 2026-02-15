Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B535E63F08
	for <dpdk-dev@archiver.kernel.org>; Sun, 15 Feb 2026 19:54:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AA0F84065E;
	Sun, 15 Feb 2026 20:54:05 +0100 (CET)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47]) by mails.dpdk.org (Postfix) with ESMTP id 221EC40654
 for <dev@dpdk.org>; Sun, 15 Feb 2026 20:54:04 +0100 (CET)
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-4806f3fc50bso30617175e9.0
 for <dev@dpdk.org>; Sun, 15 Feb 2026 11:54:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771185244;
 x=1771790044; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SkFp6nWRD2mFuHGaYH5Hkb9C+ZocVt7NW34e/5zAHcI=;
 b=0LfVDERMgpZtrxCw+dEtC9GEX03pme04HWK2JJXAYfdV5Ho0pUA0JbIIBXVT4AMktM
 4YmQHVYIeg8okxFWmonSWTCwZy96/jiYOBijx73rsvch1DTRd5WpcqZm0lfiCUPise69
 t9SDBqOKd6HAx6fdv7nOZyXPZH6HU8wemHD0WeokS86DAxMaWs4biELU+50lqV6pwYVI
 KycQ38Gs6iWlz51Xvl4o6ZeP4pwyfTRO1VzHqusAocl4T13LzFyVoMPuJwvgvSeRBYBm
 ASLI8V5l77w8U8GzKERyCZVmakao5+ht6f0VaQrm+sKoU4o2Ry7Nj4CW2sZhI7797p+D
 2DUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771185244; x=1771790044;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SkFp6nWRD2mFuHGaYH5Hkb9C+ZocVt7NW34e/5zAHcI=;
 b=ajr99qiFl2STlXgHAPkso4E5TXAnl1LAH04wXxdvLtfWd7WLrm6R3uWUh+mFzFd+th
 21kV2M1hIvFAr5q/0R/dL1c1uaW9H2TuIDsueVea2g/77tYHxB8s/Uy77juEjL9lLion
 u2dEwYBr4nQUGMVbgdQNeEVqv8C0CQxGbVGYPP3LsvlkGHrPmnOZajmh6q565kGKMf7Z
 Ti0E8+K+e0GHaSx2FNCJu6UZqRNnGSKN7m0T/dEE9UjqcKsmqmKqL34YrW4KebV72v5V
 fN+qVNI3AMEDRuIKtFHsHndvgIajNliLF8ldIGUX8UO05Rh1/nWUExV+cAh3f0yRZbFu
 S+/Q==
X-Gm-Message-State: AOJu0Yy53tDECsKcPE8DQnWbp/2RXMpzuFQKErHSUH9UN18WIw3KmNmO
 zA2ouRvPpTVclcV54Q8qu9AiV0VkMyFh3YAOhSJY6rqjuTvknBHxM0zGeqc/kj3Yp2euaC//LWd
 qStsddsI=
X-Gm-Gg: AZuq6aKI/Rr9b/K8+226cSHNTcKUdjIrdxmHMB+EkAecUp5M71YOWSDkMmK5f8poqH5
 QP0DfoSoYBoxB7gN5ek5TUf9mkCDQG2QK9Lqwda975aT/CfwwreUTaVwk0eT7PaY3v+succMA6M
 dIcRD48ckjML6vPhjlE4wYyB4YSsCUwv5VJf/zEhfv4I0z4qbp2DA3xn+z34GZ7C7PmWRmP53+c
 4ZR1bXj4tCicLYxgiWmEfwY6S/tDXNa11waZPJuY6dt+WCAsH2HS+KDTQqFJqQcwYJ7pab70Eq+
 wVAB/IfWA7U82kAlDr2ksavx6RcmOLSF+hA9BdEFAnWpl9KoPt+2MF1GPq7Z6VitbDKjmnO8yAx
 YIJxd9iBQnSxIb/k1SxRWfKP5IpL3Jo2FUvKPnA6GbvGE/DSN8+2kyTvzDcgalkFaXVjZ6GAHF5
 tQzGoRggNxU88xSdLA1OUcU7KNLxOcOsy1aM6GY7T4woBo+hEIurVRyd2gq+E6jDxeExCeDXzz
X-Received: by 2002:a05:600c:35c2:b0:483:6de6:37ad with SMTP id
 5b1f17b1804b1-48379c14f3amr102856745e9.34.1771185243664; 
 Sun, 15 Feb 2026 11:54:03 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4835d99497asm526490415e9.6.2026.02.15.11.54.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Feb 2026 11:54:03 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Raslan Darawsheh <rasland@nvidia.com>, Ferruh Yigit <ferruh.yigit@amd.com>
Subject: [PATCH 06/10] net/tap: fix resource leaks in tap create error path
Date: Sun, 15 Feb 2026 11:52:24 -0800
Message-ID: <20260215195348.557945-7-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260215195348.557945-1-stephen@networkplumber.org>
References: <20260215195348.557945-1-stephen@networkplumber.org>
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
index 4fa71429fe..0bc0e11e0b 100644
--- a/drivers/net/tap/rte_eth_tap.c
+++ b/drivers/net/tap/rte_eth_tap.c
@@ -2012,7 +2012,7 @@ eth_dev_tap_create(struct rte_vdev_device *vdev, const char *tap_name,
 	process_private = malloc(sizeof(struct pmd_process_private));
 	if (process_private == NULL) {
 		TAP_LOG(ERR, "Failed to alloc memory for process private");
-		return -1;
+		goto error_exit_nodev_release;
 	}
 	memset(process_private, 0, sizeof(struct pmd_process_private));
 
@@ -2202,9 +2202,12 @@ eth_dev_tap_create(struct rte_vdev_device *vdev, const char *tap_name,
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

