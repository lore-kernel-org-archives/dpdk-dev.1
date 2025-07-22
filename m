Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AA20C83F27
	for <dpdk-dev@archiver.kernel.org>; Tue, 22 Jul 2025 17:22:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D495B40283;
	Tue, 22 Jul 2025 19:22:19 +0200 (CEST)
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com
 [209.85.219.41]) by mails.dpdk.org (Postfix) with ESMTP id 2E66D4003C
 for <dev@dpdk.org>; Tue, 22 Jul 2025 19:22:18 +0200 (CEST)
Received: by mail-qv1-f41.google.com with SMTP id
 6a1803df08f44-6fad79433bbso51831826d6.0
 for <dev@dpdk.org>; Tue, 22 Jul 2025 10:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1753204937; x=1753809737; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=0BT1wuc9zzqIvku4Y/jthshT2FfmZ8Ln66Qeoy2sDAs=;
 b=FpOLnxLEGct67YS9iafOHq6BBZZqswfS3LwpKUqqZTVTn8b7vd0aZgIoRy3oKnwr66
 Cqekd7ZHpwQX74azk3AVTQ5OJNlpiGSrSYATCeUhIEuOvXVyE5ErW/1yaLa6VY5sBsaD
 If/DrvFn8fq6DM2ghePvCiK3I2iDFnJ5mtl0s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753204937; x=1753809737;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0BT1wuc9zzqIvku4Y/jthshT2FfmZ8Ln66Qeoy2sDAs=;
 b=hohahTiST7/MjHdXnkokDL526VLD51JYtW2sKN350vRmcwTfyiUmmzxKbL1IUDXDLb
 K81ZrNTbnYIbU0PM7IthMRJAvXaUirtVLQuoeRfqcAL58zi4AQGNhYedbAlBS+ZqLAYv
 3VKxQ5wNtvpjO4LnvEU9z+luR/C1nI9V9PBlOJI5gPuthSL440ABVh1CYzpiUTb69SMD
 KKM6ctIKh642m+sw3adD8LTLdCpoxxQkJbTh7XXfc5WTSeBFI9sR3gRbiDqDdXK4ttH8
 3zCat7qCBhSlNrzkQAGXDV4cEGhENQug5AqNhDbUn6KHPLn781AArGJSU86BzEIkMd6U
 MQlw==
X-Gm-Message-State: AOJu0YzW1+3UpZLOMui7x4qvU7EsEvPy8DgdEXkR3xh4pP8RlQ8DnCCl
 Pt0sr4R/r4o0g5Gr6mxerXxkHQRzvj0f714uO/sjJSBt4vM2KpmllnhdWBPYqvwNWjw=
X-Gm-Gg: ASbGnctNEUAc6s0dB50qln/mDJMWPnqL6DhKqAyzjBi8ZpXnS5F6efgHt5P1rrBIbYH
 GresqCkVdh6ezpVSsA1aIfYr9lzwjl5v2jY13UCbi2kBIJEJVT98IRox+9+nCFNz8y7dgdXaheD
 MgD9nPtwiI0S3IGXxs5Skxhztmm4rrOwspM9PCY79R/VzwTqmqgQOiVf7RLksnzcCRAOVpuJyC/
 rIuky6ZDE7ypMOlJcJFBvKnq4MmaOeRvQ+zAeY/SNqOhIjlfwRBT4fOLqTduopmTnc8Vo7jPvsE
 0m4VDuPIE7VYh9O5CLkjIA1HiwQhibSFCMa1ahZwiHHvHy4dvWaXBAP2y82uCzVXqJ0jALbfoi9
 YClHB67fsnHx6lYIUF5DXRnMBTWYWtUP8YDrJYI0KPbZkGyKsbePWJ6TJ6JvxIN0=
X-Google-Smtp-Source: AGHT+IGaizY7chfHNYkA9piSdzI95kpT/hz9W6HvT779F3Ig7YUvrQ7KUylhsExJYO10VyKySj0rog==
X-Received: by 2002:a05:6214:419c:b0:6fd:4cd1:c79a with SMTP id
 6a1803df08f44-704f6adc103mr385949576d6.21.1753204937368; 
 Tue, 22 Jul 2025 10:22:17 -0700 (PDT)
Received: from fedora.iol.unh.edu ([132.177.125.205])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-7051bacda6esm53571466d6.107.2025.07.22.10.22.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Jul 2025 10:22:17 -0700 (PDT)
From: Dean Marx <dmarx@iol.unh.edu>
To: probb@iol.unh.edu, luca.vizzarro@arm.com, yoan.picchi@foss.arm.com,
 Honnappa.Nagarahalli@arm.com, paul.szczepanek@arm.com
Cc: dev@dpdk.org,
	Dean Marx <dmarx@iol.unh.edu>
Subject: [PATCH v1 1/2] dts: fix docstring typo in checksum suite
Date: Tue, 22 Jul 2025 13:22:13 -0400
Message-ID: <20250722172214.202308-1-dmarx@iol.unh.edu>
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

Current test suite docstring for checksum offload suite
says there are 6 test cases when it should say 7.

Fixes: 8c9a7471a0e6 ("dts: add checksum offload test suite")

Signed-off-by: Dean Marx <dmarx@iol.unh.edu>
---
 dts/tests/TestSuite_checksum_offload.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/dts/tests/TestSuite_checksum_offload.py b/dts/tests/TestSuite_checksum_offload.py
index c9efdcaa1c..b03c3d46ed 100644
--- a/dts/tests/TestSuite_checksum_offload.py
+++ b/dts/tests/TestSuite_checksum_offload.py
@@ -36,7 +36,7 @@
 class TestChecksumOffload(TestSuite):
     """Checksum offload test suite.
 
-    This suite consists of 6 test cases:
+    This suite consists of 7 test cases:
     1. Insert checksum on transmit packet
     2. Do not insert checksum on transmit packet
     3. Hardware checksum check L4 Rx
-- 
2.50.1

