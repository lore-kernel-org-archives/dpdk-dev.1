Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D2FFCA1005
	for <dpdk-dev@archiver.kernel.org>; Tue,  2 Sep 2025 11:43:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CEC6240666;
	Tue,  2 Sep 2025 13:43:36 +0200 (CEST)
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com
 [209.85.222.172])
 by mails.dpdk.org (Postfix) with ESMTP id 482914065C
 for <dev@dpdk.org>; Tue,  2 Sep 2025 13:43:35 +0200 (CEST)
Received: by mail-qk1-f172.google.com with SMTP id
 af79cd13be357-7f901afc2fbso423960585a.0
 for <dev@dpdk.org>; Tue, 02 Sep 2025 04:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1756813414; x=1757418214; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KzNESLvTFH15SVFDmdsLVFf6ZP3BK9Z4Lz6wX68DW3w=;
 b=MBxqlOEMp1Id0ILqrppRRGjeaUJJMz/sB/zbHxj6OfTXNGPY+IoFMJZ1DTGlP/cMFb
 iv4h00MrHJsjZjN7UuKZ2KsAnTPINlCSoqxvtvcFl2FJvnMXfHgfyZQm9OLdF+mLzhh5
 3h/RSgO6qb3Z47wmXFlkz3k9zZlcgC+U/9u6M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756813414; x=1757418214;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KzNESLvTFH15SVFDmdsLVFf6ZP3BK9Z4Lz6wX68DW3w=;
 b=T/S3Q3k+EjS5wJSzfXBcRTJD6V+CeOPm2rSy9ttl1nP7aXqaxgGS0aFAPHaWrX8AET
 Iq7BJjkCyGfcDWM3pyTmGZ5FtRwFARlCYB0cHewpFyGDToMq4AI3jhCJpUG23cjA8wtx
 UgLAugu/a33wqbV4WqcGeP1DnYkI3bIRawYJYhYqpoPvrDll7sgD/5xuPOaCwbd4DiAg
 q8YIGO/f6/NxzXkA/xTsIwU78BQmU0h6vEnnYF3kQCaQfDG2T6eMbmSymJN+4QQB5d66
 7QkumEJ4alSBQ4XMWT4nmebHZUD478Y9wqWsJ9tH9VN2k4NwtSmqdsB0fkih3Q3d1WvC
 b37g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWD9qqhtE7IPw1aMUEw8Xy7b54iPVg+OWowPjQpnxqoZuIc8VkNm6M+p6Q3zsg6L3TLd4k=@dpdk.org
X-Gm-Message-State: AOJu0YwYCx9mghflm6WpSLtbEsx6c9wJFGhLuuYClQZoEVjnKSrJ28SZ
 iYDLt/8N4WahtoPeCpJMeBg06LSzNlKQL2ioSsEBVfq+ucV9wN0pb8AqJM4L76DC8GNI253HjFY
 YqMR9
X-Gm-Gg: ASbGncsYOiJLEd3N1a+bHdqYEY4zxIyEXgzZuejJ++5brz96XYac9aLwFKsxOejYswK
 dk8OuqvS6GJ4j9SVA48DW6D/lpyCKDAs+6sDqFYAB5SSp0buhNBtEUo284BjmnYKF/NtnbVNEMz
 P8Q8DHaSHGaqoZgBFXssPt7Bct7oheO+g/FIjNjVd0YAVk4iCIOIYLhTbXcmfoSmqvXt7fR32YH
 NIONU61C11i2rkFAnoJZR2d3B0mHnyHB9A+dP+yQLs1FEJ3d+HJFTsLGKw3iGEIUY/v/k/SpqAr
 tZ5aH6K2nNOAa5LaPqq6/S8g6Yv6RRKck5r/6Vdfp/z7nP9S50pKIcYcSNu11YLr1CXa+hLs94/
 hPDSf1Zlz3lNDDjRDhnJqjt4yo81xXZdMGid00HFm7Q23RA==
X-Google-Smtp-Source: AGHT+IEe9nJwgURB13BXEXE0kekx4T8kwhNWy2V2MD7rq/v5yJAWNTKVZEG+c5DRZ/zbR2TRfiFR5Q==
X-Received: by 2002:a05:620a:808e:b0:808:2794:7c40 with SMTP id
 af79cd13be357-80827947fd3mr51015485a.37.1756813414563; 
 Tue, 02 Sep 2025 04:43:34 -0700 (PDT)
Received: from d122205.iol.unh.edu ([2606:4100:3880:1220:4f6d:e2af:7f5f:4df])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8069d5ba3besm121813185a.64.2025.09.02.04.43.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Sep 2025 04:43:33 -0700 (PDT)
From: Andrew Bailey <abailey@iol.unh.edu>
To: luca.vizzarro@arm.com
Cc: abailey@iol.unh.edu, dev@dpdk.org, dmarx@iol.unh.edu, probb@iol.unh.edu
Subject: [PATCH v1 2/3] dts: add reception check to checksum offload suite
Date: Tue,  2 Sep 2025 07:43:26 -0400
Message-ID: <20250902114327.48185-3-abailey@iol.unh.edu>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250902114327.48185-1-abailey@iol.unh.edu>
References: <20250902114327.48185-1-abailey@iol.unh.edu>
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

From: Dean Marx <dmarx@iol.unh.edu>

In the current implementation of Checksum Offload, the variables
is_L4 and is_IP are not initialized outside of the loop that
checks the received packet, so if the packet is dropped these
variables cause a NameError in the verification steps.
Add a line that sets these variables to None prior to the check,
then verifies they are not None directly after.

Fixes: 8c9a7471a0e6 ("dts: add checksum offload test suite")

Signed-off-by: Dean Marx <dmarx@iol.unh.edu>
Reviewed-by: Patrick Robb <probb@iol.unh.edu>
Reviewed-by: Luca Vizzarro <luca.vizzarro@arm.com>
---
 dts/tests/TestSuite_checksum_offload.py | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/dts/tests/TestSuite_checksum_offload.py b/dts/tests/TestSuite_checksum_offload.py
index b03c3d46ed..d411af70a9 100644
--- a/dts/tests/TestSuite_checksum_offload.py
+++ b/dts/tests/TestSuite_checksum_offload.py
@@ -85,10 +85,15 @@ def send_packet_and_verify_checksum(
         testpmd.start()
         self.send_packet_and_capture(packet=packet)
         verbose_output = testpmd.extract_verbose_output(testpmd.stop())
+        is_IP = is_L4 = None
         for testpmd_packet in verbose_output:
             if testpmd_packet.l4_dport == id:
                 is_IP = PacketOffloadFlag.RTE_MBUF_F_RX_IP_CKSUM_GOOD in testpmd_packet.ol_flags
                 is_L4 = PacketOffloadFlag.RTE_MBUF_F_RX_L4_CKSUM_GOOD in testpmd_packet.ol_flags
+        self.verify(
+            is_IP is not None and is_L4 is not None,
+            "Test packet was dropped when it should have been received.",
+        )
         self.verify(is_L4 == good_L4, "Layer 4 checksum flag did not match expected checksum flag.")
         self.verify(is_IP == good_IP, "IP checksum flag did not match expected checksum flag.")
 
-- 
2.50.1

