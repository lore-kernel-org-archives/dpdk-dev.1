Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61A1FC87FCA
	for <dpdk-dev@archiver.kernel.org>; Thu,  7 Aug 2025 15:34:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 41BA0402E9;
	Thu,  7 Aug 2025 17:34:03 +0200 (CEST)
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com
 [209.85.160.176])
 by mails.dpdk.org (Postfix) with ESMTP id 655B740270
 for <dev@dpdk.org>; Thu,  7 Aug 2025 17:34:01 +0200 (CEST)
Received: by mail-qt1-f176.google.com with SMTP id
 d75a77b69052e-4af12ba96daso13448881cf.1
 for <dev@dpdk.org>; Thu, 07 Aug 2025 08:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1754580841; x=1755185641; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0BT1wuc9zzqIvku4Y/jthshT2FfmZ8Ln66Qeoy2sDAs=;
 b=gejb8/HPZkPHxDFeP0jV2Hls4Q/DOxiR8HPp8tQ3Y51GrBpjck8w5Kpzntm3zGQ3l8
 yt2tRfKW9G1L7YAOjqu0C8CIaaqon1qJdSWfZ/2DX7jPWavfs/aRRodo7/l/QughOABH
 aoBwvfYFgcAY0+ULdSd5Aufbi3nR/fUnwHUcM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754580841; x=1755185641;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0BT1wuc9zzqIvku4Y/jthshT2FfmZ8Ln66Qeoy2sDAs=;
 b=EAu7YzwFQtJ4PjTWfD7gqBCtMKy+Y6arpqxZM3b8izT/xz4PnaV8VnVkVyTLIwzIqC
 Dsh+X2nTYMdy16XTcxFZgDEs+hOfj7dRzDI3cyElyHi/+ei9A0NpmKQ8DgwGkJFku3PJ
 hkeyWeRcbc5n8fXj7g6cqYEqNvB7OUAp0l7PduaQ3v7np5PZOuDuK9k3nBW18Q1/LVg4
 y0EnV3zcS0DtpIVR02ZZE2rFFCos0QSo/a9UlUFyQKFYEAnVSVdXaO4/jymDL257ZQ9/
 kmo3tRDVaMCK4v/oiAeahtDccDZVC8fARWJpH2jpXolW0UrWTJhfjmmelBvfrGxHo1G2
 00Tw==
X-Gm-Message-State: AOJu0Yw8VUb2JB8JZOrZxR94O9XnoBUY/Rybjd6/KLK2R8ghslvcn7P4
 EmPcwnCrOX/5WSZr50c25QaniIqoURQjmRrxt/3RvgUr/C4TGZnWytRgazHM9R29y38=
X-Gm-Gg: ASbGncsWcd0UItqmJRoznNFDpg9k5wvthIT+a/wWaDVYqabvWygtXPhq/xChhT21A1r
 moKUyyCeo618q9FvkORNKTMcTiQnUf5qWaLIBrhcVU4TgTZjUVWpwl1k1NvMoGmNUf9jO41YTe1
 tzxvhNSllggYF98pfEsEt8Yz8eFOeir3S2aZS3pWem1Jr2TVWAOxeOBMVgYtjJ+M228wgPUpqrw
 wPY4mfOeXcAiWEOO64K2rT8+5b5ja1diI28xGpNZ9WgNbEhNttH3oidMB4bfaVUK8tOC7yt8jEA
 UlmSfN0InEgD1vDeVU8BwibHp8UNNRWiFcpLoSNWza6tAIUjXXjrJkDnBCOVtCQOJTDz0Z01oEe
 oPCZqM8viZXCH3keXSQx2DOmQuXPmthfm
X-Google-Smtp-Source: AGHT+IG8ot5M11mdmSwUXbxbgcm9LkAZb96yULsdY0p6Mni7mNpnRz7ycZa0x5EMklEfAfYADCM8Pw==
X-Received: by 2002:a05:622a:83:b0:4b0:863b:f4e6 with SMTP id
 d75a77b69052e-4b0adf19896mr2303641cf.14.1754580840549; 
 Thu, 07 Aug 2025 08:34:00 -0700 (PDT)
Received: from fedora.iol.unh.edu ([2606:4100:3880:1271:ac5d:4186:4dc6:47eb])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4b095e6c7d4sm19943141cf.54.2025.08.07.08.33.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Aug 2025 08:34:00 -0700 (PDT)
From: Dean Marx <dmarx@iol.unh.edu>
To: probb@iol.unh.edu, luca.vizzarro@arm.com, yoan.picchi@foss.arm.com,
 Honnappa.Nagarahalli@arm.com, paul.szczepanek@arm.com
Cc: dev@dpdk.org,
	Dean Marx <dmarx@iol.unh.edu>
Subject: [PATCH v2 1/2] dts: fix docstring typo in checksum suite
Date: Thu,  7 Aug 2025 11:33:57 -0400
Message-ID: <20250807153358.304262-1-dmarx@iol.unh.edu>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250722172214.202308-1-dmarx@iol.unh.edu>
References: <20250722172214.202308-1-dmarx@iol.unh.edu>
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

