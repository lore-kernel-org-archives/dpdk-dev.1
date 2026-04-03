Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFE2EE8538E
	for <dpdk-dev@archiver.kernel.org>; Fri,  3 Apr 2026 19:26:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C8FC540296;
	Fri,  3 Apr 2026 21:26:42 +0200 (CEST)
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
 by mails.dpdk.org (Postfix) with ESMTP id DA2FB4028B
 for <dev@dpdk.org>; Fri,  3 Apr 2026 21:26:41 +0200 (CEST)
Received: by mail-dl1-f41.google.com with SMTP id
 a92af1059eb24-126ea4b77adso2728531c88.1
 for <dev@dpdk.org>; Fri, 03 Apr 2026 12:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1775244401;
 x=1775849201; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=AxxW1FmBGz6gsL2oOkR6ngZpBfPZZgimLabXDF8dV3c=;
 b=Lqn4g4qdgBlzH7W41Ahg52/bQIIEf7LLIxm9IRq99aM4Wpf65ECbB9v5XzbRU4Ml3f
 eYuY8H6+5wCPvjNBxf9dVm1KjvJX/9P2BJLDszurjM6KyOpO3IVs/Df9Bhcqv0s85+AO
 oK2gkZWo1NAsZN4SZ2K27frkir/J7EHy6G5390JdOfd/QtDOgY2MrVPmDFnLwvqZKCxM
 nfVgRArqiMHijL/S6GwmOFWERZwz0FKAIdeaiGDblcac9yGAINYPQ36xzjRJYDfMSNeV
 X7eQfrztvDEhEYAO1mh38CiPj0l2jhGcjfiAXRXVxx5cNORX2xkITLbj0RgOd+Pibe/d
 XXCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775244401; x=1775849201;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AxxW1FmBGz6gsL2oOkR6ngZpBfPZZgimLabXDF8dV3c=;
 b=Zm/RO9Imz3NuwyQy/enTmLN+XZQywN41cGQCOzN1ldEjuU9Uvpv0t5KVfWfhii+t9N
 0toPM+HxZVuNy5eLzsirc30KhU7B5Tkw1epZhiP6LlrVYbX1jLRNwzaUD4rXRtmJIXBm
 NHGMNxGqDMZkMeYyAWXAt1v+spaVaGBN77+DPVpNKmFyw0LhH0MA1lEOXpOBLylFE6uS
 Vc6YV/XYRmUVfLfXN5Z89wcu+cLF6uyQ3HbSFNrtj3osqZC64LaiH430kIes3XG8dRgU
 8R2CmXsi/F8dMYWEwB9aOkuhqUe+pXiejWEt0Zj7fP1da0VYFkBSQ0jgOjOdKB9K/Lz+
 Eihw==
X-Gm-Message-State: AOJu0YzevUee/45p8Qu1f1gxB5rYbkxeIuEDtdefrDB5sIxlon7hpEzP
 ezGr4fcu6EaXzpc3bhRHCRNf8FcobycDiYQbPBZLP+zYTa9VAhvtUh1DeY1mRkYOmNLA1ZOXRcQ
 j9cNY
X-Gm-Gg: ATEYQzxR1ZVcWvybzotuzei6dj6ifZhdQjnD++QgAu6s6y594SX0Kn5VOGHd67C6IZC
 UXhKfTV9zPN8awy+tSGjtvYpNlwqIA8EH8IR8Xb9LTLIV2NA6Onx1eIYBBRVridjUKXFORsmJ5w
 4jc+nMligv/AQJyS8JPfmZ7uxENrA3QRZ2aHAinjtMteCJ66MzqMTMN96oQVqa4tVHjN0a7I7Ss
 JK9U4BvZY4SUtgDinaIljeNGg0ETNnIwhKvYgQVbkboqyunGge1/2xnL6Bh2ze8hEQmBO9LRVSU
 fz/k4iw7ubnTV4BJzH/hZRPYcN3GzTlF3nf4in7N/UrHPzL25/j/+/yQ8vexYEFruqqSHaQISUU
 wr4f19IPKDAWPPhCfIDtSpoByKky2rqTmJaEVG4IA9tXOfX+LJ3xHPtUVESezDd3hdIXMlkDb00
 +qQrba5jUSIjEVr1d8pSfCTG2aT7PUKIBc
X-Received: by 2002:a05:7022:52b:b0:12b:ee7b:51ec with SMTP id
 a92af1059eb24-12bfb6ed64amr1902909c88.1.1775244400674; 
 Fri, 03 Apr 2026 12:26:40 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12bf90973b6sm4291956c88.9.2026.04.03.12.26.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Apr 2026 12:26:40 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Robin Jarry <rjarry@redhat.com>
Subject: [PATCH] net/tap: avoid using netlink socket if closed
Date: Fri,  3 Apr 2026 12:26:35 -0700
Message-ID: <20260403192635.320320-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
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

Coverity flagged that nlsk_fd could be negative when passed
to tap_nl_set_flags() during device close.

Coverity issue: 502576
Fixes: b5d76639551e ("net/tap: replace ioctl with Netlink")
Cc: stable@dpdk.org
Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/tap/rte_eth_tap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/tap/rte_eth_tap.c b/drivers/net/tap/rte_eth_tap.c
index a5d460a0b3..ba9aef74c0 100644
--- a/drivers/net/tap/rte_eth_tap.c
+++ b/drivers/net/tap/rte_eth_tap.c
@@ -1124,7 +1124,7 @@ tap_dev_close(struct rte_eth_dev *dev)
 		}
 	}
 
-	if (internals->remote_if_index) {
+	if (internals->remote_if_index != 0 && internals->nlsk_fd != -1) {
 		/* Restore initial remote state */
 		int ret = tap_nl_set_flags(internals->nlsk_fd, internals->remote_if_index,
 					   internals->remote_initial_flags, 1);
-- 
2.53.0

