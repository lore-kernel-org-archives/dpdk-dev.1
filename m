Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F982E83841
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Feb 2026 23:05:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C0EC64065D;
	Tue, 17 Feb 2026 00:04:55 +0100 (CET)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com
 [209.85.221.51]) by mails.dpdk.org (Postfix) with ESMTP id 247A040663
 for <dev@dpdk.org>; Tue, 17 Feb 2026 00:04:53 +0100 (CET)
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-43638a3330dso2887915f8f.0
 for <dev@dpdk.org>; Mon, 16 Feb 2026 15:04:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771283093;
 x=1771887893; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Zrxd7VzydPBG1Kx0iDxD87oC4ndq/lrvRO78GtBcCeY=;
 b=GwJZEZCvWvAZS4lz60b3YN41F8A3BhI9v2IwOKdOEouQzy3AJu9EbrPm3Lm2eTdDXg
 +Ib5Vpdg96aCUhyad2OOcCzuvOT7LUaGs/YerMkv9bA62nzEOxVAbrUhNSPGc1/pRdkR
 TSvuuXOapX1E3br+KnhyIGuBvZ/9nQx21QgPDk2I8ya6uS3nIQxWqCtAlYQeyPZELFeB
 tOnibqVEPcU75UTyww/y5e06h0jU/hl5zsQ/M0KKGM0c1FPLrpqY2Glt8R3KsxFQkKf0
 t/nWxHsTcNWQKqNLFP50EmX6WrFwjDQ/6vxHDq42+LdD6ifgR7VStYU4mmw/c1qvsfdu
 a+cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771283093; x=1771887893;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Zrxd7VzydPBG1Kx0iDxD87oC4ndq/lrvRO78GtBcCeY=;
 b=RWh94AHI1HtYo49NXj1WiEmcFku2YC9WBhoQaxkyxRiTuKd5GD0g0vpUw79EoV63LQ
 qM0THlTw6ZHjOtSCDqm5u22Gn/8YpUeDDrjamxAbrefmweDKH5G0QpYTudJEkAK2AEE5
 KxpKE86Qtpi7K6P7FzO4lBBxK/Bcyb2fodhOMuvSkDjSa6Cb9N3q0PO0Rl3xJwcAdxtW
 Qjtda88E8K6F9NvHPW9SSB5GFCvXC1ixiu3ZPPaLJaYn0SMA+eFl0+jUe0NUVygCEU6u
 wssruKYi9l6vljgJamWeGvXERKdKUrWyogmrCsOjv76cfcjFsxeRpota3LcEsQeRalX6
 rboQ==
X-Gm-Message-State: AOJu0YzF65QHhSodCK9wPhg8rATzxUQ7CZDRo+Y9TlmM0FyyemXJX2MQ
 /5fYVFz4Js0gMaR33A0QZtDP/58Uu4zAec9b4Nb43VsTI02HPTuL+Lc6zaqSMsQYmiIUTjs04+/
 M1X955fw=
X-Gm-Gg: AZuq6aKbiwZanCzWcAwaU8p/iSB/1Zm9ipprUsQXKRHART7rGMXUDWqMu671j+0UPpY
 9OjsLCxUvF/VZ+2OyK7iZZF8IIxEpfycbziQKoW72slKjAtsvuSDn/iebJvuqxu4dIMoOb9mwhi
 nwmpEKO64DxJcX8bDueP/2kboVXCrIHqIfcAg4Akx6ETwCWGT+KLo9pT9DJieAQEZ3HOr41puJ2
 G/WhriY0qnuDQOo7ldsOpCcasAc/8wwYbKNXVniVFeq/RvZbryjG0gcyWviA/Q93SzXYEagOOGI
 d4pBlan6RfG/Rb/e8N6a+d+YH/8QKVkd6PCsrTEwOhEmvxtBVpwDW+sLp2WnVyjcwmeijix1UCq
 y662T0Vi7TXvrVp4mbs5gSgOKa8PGYwK6+SgA/7z2TiOU8t8Y4gNKz1h9Xf94etczomseS1voCU
 vH13OSNvM360GyD8FHrUCO3+qTrGwrrK0RWtPnfukcw2ss+UrAkJsLZ2yoPyqWuw==
X-Received: by 2002:a05:6000:230b:b0:436:3563:49a2 with SMTP id
 ffacd0b85a97d-4379db93ae0mr15342993f8f.37.1771283092631; 
 Mon, 16 Feb 2026 15:04:52 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43796ac82f7sm33158867f8f.28.2026.02.16.15.04.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Feb 2026 15:04:52 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	stable@dpdk.org
Subject: [PATCH v2 06/11] net/tap: fix resource leaks in tap create error path
Date: Mon, 16 Feb 2026 15:02:30 -0800
Message-ID: <20260216230437.847578-7-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260216230437.847578-1-stephen@networkplumber.org>
References: <20260215195348.557945-1-stephen@networkplumber.org>
 <20260216230437.847578-1-stephen@networkplumber.org>
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

