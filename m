Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EFDFC44508
	for <dpdk-dev@archiver.kernel.org>; Thu, 22 Jan 2026 00:55:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7AADB410EE;
	Thu, 22 Jan 2026 01:54:29 +0100 (CET)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com
 [209.85.221.43]) by mails.dpdk.org (Postfix) with ESMTP id 7887240ED3
 for <dev@dpdk.org>; Thu, 22 Jan 2026 01:54:28 +0100 (CET)
Received: by mail-wr1-f43.google.com with SMTP id
 ffacd0b85a97d-42fbbc3df8fso256511f8f.2
 for <dev@dpdk.org>; Wed, 21 Jan 2026 16:54:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769043268;
 x=1769648068; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fSQ28D8+Fido7f8Cmxfgje4bFreVs0D2H9du/Rh6CRA=;
 b=N4W2FHSc3Nrtt7La+LUJpvKQw4iPnxOI8jc1WA6igULxMuwyVvEBQSpsOgIxhNIbko
 NRRmNO5vyeNqANqJwqI/+JS91kwNHC7nrxxKsI5jKwLjN1nzbztbZ8/TXree+WGbc0vM
 fNPc8XnQZ6amhZG3MKyBqh0bBJcEH13xf+sOopFUxlY5kLabszkd+rZnGTreVij5/h4I
 h5jjlr7S0LpRK/tYj3j5qYPzpdkp3tCKFbRD5bj4wv/fJHD5LotGnTK9Px0LuD6Ko5LL
 WbCFT1Mpp+t81IxKOA1w60/fSHYa+Ay5oj2U69JcOd6JORnVFl3dUL7NFCOqsTiQtE5O
 kCwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769043268; x=1769648068;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fSQ28D8+Fido7f8Cmxfgje4bFreVs0D2H9du/Rh6CRA=;
 b=SAkqr0tjrmWx0Avw84q9idjFBvQcDpExx6jADKD09LbOS7wbenFjA9qznlu9MpPdQ5
 oy+gubkMg79Cyhgz2kGg3zhSiX5+0cnck6ZWRA8tVYUNh/d5bfD08vB9aPLBKN2OzYLr
 1H7djUeeDj4L+6Gp9Kg2ogD6neOBuVI/7nr0JbGC/LJZ3nzJDapadDSQN3OiyjTVvTS5
 IBfSVzJRwgxt9IBmx83xD0lhMPe1bp2Q3OfH4CsGPjoY4mANfJfGS7vtqiN+ssAUZJ9R
 mo1MjXRm3YBxgeIBO7kJajSsss9+WIwD4JVFoI3JnDoU0F+uPBDPSqlwkCIZBKRKL4bn
 gTqA==
X-Gm-Message-State: AOJu0Yyw67yf6TisooNm7WAPUZ1UVdnYLy0TkIDBse3zLdNF64PBOCUS
 DtpazojBRC7FuQgWA5ud6e2VDZekBi7T5okY3XmaGkFYekjcHL2mVCH+YlKVLPOyBp0vktliGS8
 nOrup
X-Gm-Gg: AZuq6aLufzNehtG6Qzu+kd3sQ6cou/JwumDqdm93dmulrL4XwalystBeOOok6lvXDH8
 xZcfkjRgKNo4Pg4cqET8qrPLDn5HHP1jdefBhBvHI62wDxfAeKWofbDTK53CHiLSQud7K6usorB
 9LmfrUVnJ1duy9nkOtrakFvcgPpSVDw0GKAec1/2TYY634c0nr1dZ+kK1S0ejdz2X6Z3f1KX0eJ
 zbBXtp3P2RU8FGKDeW76Lw+VC6b8HV2dBCtXE1BBCbEh7iiEFsoiCO94Jiv/SLKTXqp33v4L3yF
 9dd0BXJwWBGMgSDHbLZsUU8M9FVAQb192n7JbbqHv/tUqx5gxFrrzAAXhB+QAhuDr2TOdFHn2Nj
 UY6w9R/NSSFXcYVf0eAFD3Odkuwto2WbvqbB1ghTxy1v3sp0S1K/kQvXYWFn7+0IXQvwFa0Zyeu
 9dZ4dHDseP1DLU5o1E3tsRo19/jq4JWUxx7fmwm3qPI75AdpNONeEudpVPoYDv
X-Received: by 2002:a5d:5d81:0:b0:430:fb6d:1442 with SMTP id
 ffacd0b85a97d-4359017f167mr13198958f8f.62.1769043267993; 
 Wed, 21 Jan 2026 16:54:27 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4356997e6dasm41695104f8f.32.2026.01.21.16.54.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Jan 2026 16:54:27 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Naga Harish K S V <s.v.naga.harish.k@intel.com>,
 =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v3 11/14] test/eventdev: skip test if eventdev driver disabled
Date: Wed, 21 Jan 2026 16:50:27 -0800
Message-ID: <20260122005356.1168221-12-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260122005356.1168221-1-stephen@networkplumber.org>
References: <20260118201223.323024-1-stephen@networkplumber.org>
 <20260122005356.1168221-1-stephen@networkplumber.org>
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

If DPDK is build with -Ddisable_drivers=eventdev/* then the
test will be unable to create the needed software eventdev device.

Fixes: 50823f30f0c8 ("test: build using per-file dependencies")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/test/test_event_eth_tx_adapter.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/app/test/test_event_eth_tx_adapter.c b/app/test/test_event_eth_tx_adapter.c
index a128a4f2c2..0753634e7d 100644
--- a/app/test/test_event_eth_tx_adapter.c
+++ b/app/test/test_event_eth_tx_adapter.c
@@ -208,11 +208,14 @@ testsuite_setup(void)
 	TEST_ASSERT(err == 0, "Port initialization failed err %d\n", err);
 
 	if (rte_event_dev_count() == 0) {
-		printf("Failed to find a valid event device,"
-			" testing with event_sw0 device\n");
+		printf("Failed to find a valid event device, testing with event_sw0 device\n");
 		err = rte_vdev_init(vdev_name, NULL);
-		TEST_ASSERT(err == 0, "vdev %s creation failed  %d\n",
-			vdev_name, err);
+		if (err != 0) {
+			printf("vdev %s creation failed %d: %s\n", vdev_name,
+			       err, strerror(-err));
+			return TEST_SKIPPED;
+		}
+
 		event_dev_delete = 1;
 	}
 	return err;
-- 
2.51.0

