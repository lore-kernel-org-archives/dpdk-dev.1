Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1203C53214
	for <dpdk-dev@archiver.kernel.org>; Fri, 20 Feb 2026 05:04:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7A9B140663;
	Fri, 20 Feb 2026 06:04:25 +0100 (CET)
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com
 [209.85.219.50]) by mails.dpdk.org (Postfix) with ESMTP id 3D28F40653
 for <dev@dpdk.org>; Fri, 20 Feb 2026 06:04:20 +0100 (CET)
Received: by mail-qv1-f50.google.com with SMTP id
 6a1803df08f44-897023602b1so20048566d6.0
 for <dev@dpdk.org>; Thu, 19 Feb 2026 21:04:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771563859;
 x=1772168659; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Zrxd7VzydPBG1Kx0iDxD87oC4ndq/lrvRO78GtBcCeY=;
 b=s6sxWAIct2CCXl0vhf+cj7JJcrCWrbVNvsduJDQWzAvxsZz7NOBMfaaOJgnUGold7N
 nqiHO+TerlrGZ95Om6NE4K45c8R4vO5gXnLNaDBiVE6SRuiaXPJG+8xdBikO1NPaLvSX
 qZ/nP9SCayxDpCbJw/BwnYYVIuUCWBB3+mce/nVbP2GoVAifqF9rImT8QAhl8UqoDpLA
 rrCMNxeSW1HpAqAffPAaDJ7LBZebdHVSXvCRkFRwf9S5KS8UjRWYrx823pnTWe3em/Nk
 2Scte8kNEYv5tWfI5udArcexjxojKj20OzmQinnKMkAyT33Usi69JFfggg6PQKhEGgeY
 RCoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771563859; x=1772168659;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Zrxd7VzydPBG1Kx0iDxD87oC4ndq/lrvRO78GtBcCeY=;
 b=GvE0ui8VeZcYkE+RbEQndfLI6owOsDdCMOLEClGkD2amx7ZFeqArgibDCPR1JPcv2n
 5tFq04rGC5a4SOlBNY1+Bf5IG11ExzPdpygZlzcyR+tr6ZFeh5/D6MfVis9jugCqSvO2
 KWNwfPgCBv+mkbJeTpPiHF0v4TIjCxcISoEWT2i3iVRtYlqS27WBf3u0/g2TfPaHmRmG
 hAZzaNahFNSxaZE1PblMeKzs6MGpBmTSAvZN7IcuUPcGkaj0agnSr9sS2QpipOxiXXFj
 OHDuKIcrgRPshE3NS7Qs6bC883O0bZXlnB7vaTXG33ct7jkvMRyEv0nsJfsjdkH5cs96
 SvbQ==
X-Gm-Message-State: AOJu0Yy+pqli3vQor4wSM32FPfzLeLdVlveM7ji5aZhOtddKRfrY2vRC
 D34fufLRu07Xk0GrshgmVHHGg9SZcMLUO0hAzQgPKXuMqmLytCwWORdZ2SNstsSXAYcow9pk/pY
 O9ekc
X-Gm-Gg: AZuq6aLxnC4lOwvfpo9+/xi13kBP1aKQl3s9TJZgC9Mwv9ZH+u3nEI9ICU6Ax5KbAQ0
 t5DhkJOBfFergN+t8Ri0lDuwEX43R9kVsNotPejUgwZzNSeOYKjLzhinalIEi6BXxgG8BgFM6Xg
 wHa4KnLu7FY6DkncAEfwBOELQpxReqw6so0rWfq9JqIMFh2b9muNIRgmpXYNvp+yMYkEHg08HWV
 49quajxWes7xi78IGTcE6UsbZBB/PHuu7CzHAhiilnnw6NIgKYTemadO6B7eCmJeigOdvZ8mYlg
 ZlI7+266Ad+FWtZyRdORAFVOO27pbOMrVIHB5BLRl3C958u5cbQORulUyG57pB4KOElGbh2Z/8u
 KtncBm2ky4iCVehMRNoDvssuOCBkzkMhf4dj14vMjv0fOXn9ghT9xhDSsnLBoZxnzd/EXVLlyrA
 a8fy9H/YKVWBZQMvhDi0XM1VLa2Otm5JGj9y3geBdj1XeLwOCCiIdYcZURyC2FfKR7SXOW0sU9
X-Received: by 2002:ad4:5bc8:0:b0:896:fa50:4c17 with SMTP id
 6a1803df08f44-89957fe68admr119031116d6.29.1771563859520; 
 Thu, 19 Feb 2026 21:04:19 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cb2b0f38dbsm2289278685a.21.2026.02.19.21.04.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Feb 2026 21:04:19 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	stable@dpdk.org
Subject: [PATCH v3 06/10] net/tap: fix resource leaks in tap create error path
Date: Thu, 19 Feb 2026 21:02:08 -0800
Message-ID: <20260220050409.1571022-7-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260220050409.1571022-1-stephen@networkplumber.org>
References: <20260215195348.557945-1-stephen@networkplumber.org>
 <20260220050409.1571022-1-stephen@networkplumber.org>
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

