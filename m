Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91325C44506
	for <dpdk-dev@archiver.kernel.org>; Wed, 21 Jan 2026 21:08:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5879C42E8E;
	Wed, 21 Jan 2026 22:08:30 +0100 (CET)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49]) by mails.dpdk.org (Postfix) with ESMTP id B780142E87
 for <dev@dpdk.org>; Wed, 21 Jan 2026 22:08:28 +0100 (CET)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-47ee974e230so2343765e9.2
 for <dev@dpdk.org>; Wed, 21 Jan 2026 13:08:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769029708;
 x=1769634508; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L94o++XYmppN/uOGPmSYyzqre8GCLglOjy8jI0F6OzQ=;
 b=Obe4m/17IQruxtX3RGl+OmftzjBINlDYrC4JySbyuNKXpUJll+jroRHQF3TP7TTMva
 X3TIXEeXcSAla5Y7RUrJYbrIhfp9dtFyhbRvL99mFIt5nvzjydIQh2/AFS+bVZII0txS
 N7glhy0UN1A4R2rxRWkfSzHwYveOvdCT/yPEQHzkojLTDoNCXbuu175N5gsr+WPk2EUS
 vVX8c5v4Jb/5UG7jUa0QVpPladIIUoIPV5U+u8MHvrPRh2QpDMInJD8v66H3fa1RC3cC
 hqQGEzzoFXtLMX2N6pTFu4ojh9K2vb9JWMzSeVjVApTysHjPMLDWy3X+7FKeWTkMxL35
 n/Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769029708; x=1769634508;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=L94o++XYmppN/uOGPmSYyzqre8GCLglOjy8jI0F6OzQ=;
 b=iI9VmWVzldmVQImLnMUnygQZYak7V8x6YpiWADOpQnSGefADSZxdKM3e0CC5rH6Lfl
 lEGrUnUXTOTsJpcFimja/RmOMHuvDN7A4letQ7DpnwhOUwEjGWGBE0mO2X53gDRHu82Y
 qpLinVCd6Bi+clT3cB7fgFT6Z/tEDrEtR6LHNnjjZDP7iqk6W70aSgsGrvT8Q8ukp5jy
 w6j7Dx+tpynhrdRwt6FUuRnVjyRQVHg2KJ3hIgXUiBo3l8Ah2yLZLQpXFtj9N7TaiqS/
 VPwpa5tejc2XoRCAtyo/AcYu5qIb1GS52bqvIDWo2T9AfFj1KYidVNrk325hWbeJitoy
 Sstw==
X-Gm-Message-State: AOJu0Yy3KGS9J1L1in6g2Nk1G7XAriGZV9TIrMZ13mXE07bQ/uA7RECD
 T8Lc74xMHHC2fzppcjarcZkmlW3a2fYPoYfOdBagJspMgUxE9Na1JUf4zVRfDw2T/NkoX2bnk5C
 oK/1b
X-Gm-Gg: AZuq6aJUObSUs7zSx3wpr40CP7YQDSi7G0rIqVhXRqPNkxFSEFAs6vW2Pj0Nf5Mz4QU
 x2Z6/Fi/dsA61gQYLMyBxH5Oj/VJJ5T2ti45V0/c1P6m3+AK95+17PQqULzh/Xf4Hh0PvI4dJMf
 WfvumBQ+kzpcm21fVyWSq7z7G4c4bVUvei+cDCXyMqCDrX5MdSP9tXv7yftDqnJDnsxtYdyui0h
 Bcjt69RdQ/LpLQX5uo0h7/2wJ9NpDGxrso9szkgA8XKlacywjL4i0C7C+s2TVLGcccpsncXkuGY
 +imnENs/u/l2C16shXTYJ4V95P3eLiKqV+gTl3dCasfH+OOdU+k7LklRFyY8VgZ6RVzO36IHbvL
 Z2i+p0qvBf0qUZy0hE8xk3ex7nmad61WhATRayaTw6iRVMx4HG914QLlYkLPi9Ga8GOSP67QoeK
 pnwQ1DoZPCLRIcVxsRA/eml6UHgX2Ar5VPyIGtZ+uM2VEamas3PA==
X-Received: by 2002:a05:600c:8b75:b0:477:b734:8c22 with SMTP id
 5b1f17b1804b1-4803e79b7famr107514485e9.8.1769029708299; 
 Wed, 21 Jan 2026 13:08:28 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48047028928sm27539845e9.2.2026.01.21.13.08.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Jan 2026 13:08:27 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Akhil Goyal <gakhil@marvell.com>, Fan Zhang <fanzhang.oss@gmail.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>,
 Ciara Power <ciara.power@intel.com>,
 Declan Doherty <declan.doherty@intel.com>
Subject: [PATCH v12 6/8] test: fix format overflow in cryptodev test
Date: Wed, 21 Jan 2026 13:06:26 -0800
Message-ID: <20260121210810.1044276-7-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260121210810.1044276-1-stephen@networkplumber.org>
References: <20251110182209.104087-1-stephen@networkplumber.org>
 <20260121210810.1044276-1-stephen@networkplumber.org>
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

The vdev args buffer could in theory get truncated if there were
lots of sockets or lcores. Handle that by checking return value
of snprintf.

Fixes: 8bfdd8a7f0f1 ("test/crypto: refactor to use sub test suites")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 app/test/test_cryptodev.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/app/test/test_cryptodev.c b/app/test/test_cryptodev.c
index 9bdd357727..bd6a2d3fa6 100644
--- a/app/test/test_cryptodev.c
+++ b/app/test/test_cryptodev.c
@@ -17713,8 +17713,16 @@ scheduler_testsuite_setup(void)
 		RTE_LCORE_FOREACH_WORKER(i) {
 			if (worker_core_count > 1)
 				break;
-			snprintf(vdev_args, sizeof(vdev_args),
-					"%s%d", temp_str, i);
+			ret = snprintf(vdev_args, sizeof(vdev_args),
+					   "%s%d", temp_str, i);
+
+			/* If too many args the result will have been truncated */
+			if (ret >= VDEV_ARGS_SIZE) {
+				RTE_LOG(ERR, USER1,
+					"Cryptodev scheduler test vdev arg size exceeded\n");
+				return TEST_FAILED;
+			}
+
 			strcpy(temp_str, vdev_args);
 			strlcat(temp_str, ";", sizeof(temp_str));
 			worker_core_count++;
@@ -17728,8 +17736,14 @@ scheduler_testsuite_setup(void)
 			return TEST_FAILED;
 		}
 		strcpy(temp_str, vdev_args);
-		snprintf(vdev_args, sizeof(vdev_args), "%s,socket_id=%d",
-				temp_str, socket_id);
+		ret = snprintf(vdev_args, sizeof(vdev_args), "%s,socket_id=%d",
+			       temp_str, socket_id);
+		if (ret >= VDEV_ARGS_SIZE) {
+			RTE_LOG(ERR, USER1,
+				"Cryptodev scheduler test vdev arg size exceeded\n");
+			return TEST_FAILED;
+		}
+
 		RTE_LOG(DEBUG, USER1, "vdev_args: %s\n", vdev_args);
 		nb_devs = rte_cryptodev_device_count_by_driver(
 				rte_cryptodev_driver_id_get(
-- 
2.51.0

