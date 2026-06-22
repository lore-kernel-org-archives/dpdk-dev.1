Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E97CCCDB46B
	for <dpdk-dev@archiver.kernel.org>; Mon, 22 Jun 2026 23:21:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AAE4E40269;
	Tue, 23 Jun 2026 01:21:06 +0200 (CEST)
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com
 [74.125.82.182]) by mails.dpdk.org (Postfix) with ESMTP id 5C75A4025E
 for <dev@dpdk.org>; Tue, 23 Jun 2026 01:21:05 +0200 (CEST)
Received: by mail-dy1-f182.google.com with SMTP id
 5a478bee46e88-30c591fb1cbso172170eec.1
 for <dev@dpdk.org>; Mon, 22 Jun 2026 16:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1782170464;
 x=1782775264; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=UYwGofezZbaNR6P8ed9gEEOhmK9kMFrm7aVSB9AR25U=;
 b=sAuJFMI9N5KhCrRxrtmcmJSLQY1J1Df4ftaXn0YViUh6Hxy3nvHV22D1ovh4Ulz63U
 o0gZujtXtnBALJhQnEdfwmF07FtZ3hVDKGoAr2srFswqN1wRwRfSIr8+3lq+n3fqhkmU
 R+2+yLlygWXXA4c59ntvGXsYTIqO4icCS49RI95sldC70or8w2lHppgRcZJ5z8zCan7p
 z5AJMH9kpK2rTDyKOhD3SeuTM44kypfODlcBrDr8c9MYjFBfU3SYKy9/h0vJebs05C4V
 SBwcwhlS+hjfWc8Y1hqVTwZ5aWq3dnwUymxXFWs9W5hHqgInceuyDvcRjSEvWJXbeoVY
 4Jxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782170464; x=1782775264;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UYwGofezZbaNR6P8ed9gEEOhmK9kMFrm7aVSB9AR25U=;
 b=jrAI14cqcIm2q+S5zsECcv4ETxSzirwiKjbHUJ3KvPRGWyZz0ZBfqC38qURwo53yct
 44mRoQxqU8GAb0oyWFwwGJkpCXv5IOxADdR2LZnt1UFTyvGN5Us+PyhlE9EAvkklZAqE
 30KuzSO6sQvb7tCUjsY6GzhKhQzM2QRJE2WHhUUT6onpyQ80YZAtKAx4clOGEX69EN8N
 RY1rDh2BukTX0uIKJeFYKbM6+g1pD4Qn2HlPg7sC71cv1G0URTk9U+Vq6s9X5D/vDrTW
 9h9tPp/E3XZMkGW/GNi2vBXkCBXWkbiFW0D3IgfwS/Sw4oadkBkxqhNw4qCAKty2CMjy
 wqgQ==
X-Gm-Message-State: AOJu0YwFBgX7yB0/bizZOi3ijNGFUA5OAQlVjdSlHPbOp/mnd07og5Cv
 l+bIJ8Za5BD7lXjUXi8em4baKU5g5Nw2rOp2AG7nHCUj9NrK98P9OTj4L9ZHEagac0OZ62rnti1
 2TCfj
X-Gm-Gg: AfdE7ckq5Hz+ju5XssFC+gl55r1hE+V4lPYEqxnhBx2l4YvfOglE9kZFl/BxTk5wds+
 9wLtJTkZpuWtuV3qMutq2dkzlG7dcqnwVNhZZByLbIqa3mqO4eiv7MJGCbWTSXuPIGIjVEOzd/+
 phHploaTKl+n8tals0x4ZwLK69a2cTu11t2hXdGoQRXpNSUjl8ayZhVojFfwgORwCXSID6OSLtN
 ybiTCPZcNDYW8JmIBAqV4OI80+gN4TZcwe23KSIEc/rjU4JY/Cm43eOKxuw5PUUElbpTTu4iO7i
 elmLgdmcTGTayTqjfB/FE80eDvIdgym6kr6Jws9OPXfVs9F2bR6ZChRyp6JYpmFfSvhWTYSHhGj
 GkyfqT6gA77xSSQsE2bhaBfc3YCsmqduKA+x5tyNR1IDDY6xz6ghTuoo/c9zmqzwQRo08kC718E
 PdWYa40WF1UoE5MipRR30STK4HMuHDFXyZbiaVhAc9VP61/uJ5UJZH1/IJSp1TNg==
X-Received: by 2002:a05:693c:42d7:b0:30c:23ab:b7d2 with SMTP id
 5a478bee46e88-30c23abc5dcmr5764931eec.28.1782170463899; 
 Mon, 22 Jun 2026 16:21:03 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c1ba635d8sm13370472eec.10.2026.06.22.16.21.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2026 16:21:02 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH] test/pmd_af_packet: cleanups
Date: Mon, 22 Jun 2026 16:21:00 -0700
Message-ID: <20260622232100.63865-1-stephen@networkplumber.org>
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

Fix two coverity bugs where fcntl() return value not checked.
Also mark some other cases as FAILED instead of skipped.
Such as failure to transmit or failure to allocate mbuf's.

Coverity ID: 503765
Coverity ID: 503766

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/test/test_pmd_af_packet.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/app/test/test_pmd_af_packet.c b/app/test/test_pmd_af_packet.c
index b668ca5b81..9fe595d606 100644
--- a/app/test/test_pmd_af_packet.c
+++ b/app/test/test_pmd_af_packet.c
@@ -556,19 +556,22 @@ test_af_packet_loopback(void)
 
 	/* Set TAP fd to non-blocking for reading */
 	int flags = fcntl(tap_fd, F_GETFL, 0);
-	fcntl(tap_fd, F_SETFL, flags | O_NONBLOCK);
+	if (flags < 0 || fcntl(tap_fd, F_SETFL, flags | O_NONBLOCK) < 0) {
+		printf("fcntl failed: %s\n", strerror(errno));
+		return TEST_FAILED;
+	}
 
 	/* Allocate and send packets */
 	allocated = alloc_tx_mbufs(tx_bufs, BURST_SIZE);
 	if (allocated == 0) {
-		printf("SKIPPED: Could not allocate mbufs\n");
-		return TEST_SKIPPED;
+		printf("Could not allocate mbufs\n");
+		return TEST_FAILED;
 	}
 
 	nb_tx = do_tx_burst(port_id, 0, tx_bufs, allocated);
 	if (nb_tx == 0) {
-		printf("SKIPPED: No packets transmitted\n");
-		return TEST_SKIPPED;
+		printf("No packets transmitted\n");
+		return TEST_FAILED;
 	}
 
 	/*
-- 
2.53.0

