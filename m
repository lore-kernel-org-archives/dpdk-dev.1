Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16952C83F1A
	for <dpdk-dev@archiver.kernel.org>; Tue, 22 Jul 2025 17:22:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 04AC14066F;
	Tue, 22 Jul 2025 19:22:21 +0200 (CEST)
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com
 [209.85.219.53]) by mails.dpdk.org (Postfix) with ESMTP id 7220E4003C
 for <dev@dpdk.org>; Tue, 22 Jul 2025 19:22:19 +0200 (CEST)
Received: by mail-qv1-f53.google.com with SMTP id
 6a1803df08f44-7048d8fec46so1404256d6.0
 for <dev@dpdk.org>; Tue, 22 Jul 2025 10:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1753204939; x=1753809739; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aTdxfpuXJf1x6WnOZAZ9H6v37q0r5D1oGqBmPcrhLw4=;
 b=CX0AqH1VDVHqf6BTceZADAerqSbKjw9Pnmmzqh0ripNOfQQ9Vc/s/J+sXDG8A/nTd3
 5GyYG+xPJeA3dMMhuAbo5CSlJYW2LuhVAxpdm2tOMdbp5a+s5RZ6EGFUB2zZElEo3qVR
 wkXNeFTCfQC2Ivd5PubKBiqKex/S+sRa8H1fc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753204939; x=1753809739;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aTdxfpuXJf1x6WnOZAZ9H6v37q0r5D1oGqBmPcrhLw4=;
 b=g08oe7vWQ1NTYe6ygMhm5s21O03MQQf5b4/9qZDIvv2mrV0HTKKC0N4DrUL4MU+clC
 YTrDtN2kI62xInWO1/ipz17NPcV7H0EvUYFLB88EY86qEzfFXDs4iZ09TP2bmAhP6tMZ
 TBIzICmfW/y9BPfWDr4XT5DZveEEtRfR2hT/4d8jRs5q1xTwoCWZWEC31NP1b2i/1J4C
 CYD71MmjbZ6Gty9SEssb9YrwKRBTdqT3pYRCAwSW4qNWwxuKczELvi+D1xt1DIaRb401
 7wsEteovPVwVCLtaXINvFioeUue+i9DHvNiJzx8iTZ92IyA9jeIfNnyLiQGGupkJy+WY
 Lang==
X-Gm-Message-State: AOJu0Ywyp2O82mLPLyYLpmoiAuMiWVgQnI7cxSWcTo31fEKcDTEQjqP8
 ea7D+Vivggq1Yj84VO/k0fU8dWw7He/YGbxbJ08RGvZU7Gh/hvpZuMPvRVSDgbHssuI=
X-Gm-Gg: ASbGncvBjPANPx0WU7pcKR2hAD0n8YaFJ4JVEOUcvRw05/e2hz0rAnXcnXy1FuvuUuO
 Hz386/4vCC/aQ7WTDXWdCCYhv9tJ5FC8Nu7YWvpudCmtKQtqdXAxHr2hiQB+qHWOwiHDiBxLnD6
 tLQ+I/nm21MiphAPDlLSqKclc99/Dv1PjVcLZZN/ALp5JC0cnTDwEpymAo111nf23CAFBV0UVro
 K4FaraayrUApWA8G4GYVow3TxxvJnCeeRYOqUM++COVstdGA7KH3MPy3eRQsHoglOP+5wc/O0lO
 zI0GXJSinT8XzjG88rjSYGUq6F9wdt4dPdODNZt0aVs0k+7vI9sIBkwrpQcIBwnULT7XQvE1m/P
 prmpj3dIFCG03qsus4smsk6HntJxBRagslspukb7L3/sZKkP36TJ0
X-Google-Smtp-Source: AGHT+IFg8vSxnFuRDf0R8q2xPOxhYT/86B9vK0j4K4/n4JtR6GYexEvjfrOJMjyLB+kbEzPNVMZx7Q==
X-Received: by 2002:ad4:5d6f:0:b0:704:7dfa:3fd with SMTP id
 6a1803df08f44-706eb692e9cmr52387406d6.4.1753204938541; 
 Tue, 22 Jul 2025 10:22:18 -0700 (PDT)
Received: from fedora.iol.unh.edu ([132.177.125.205])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-7051bacda6esm53571466d6.107.2025.07.22.10.22.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Jul 2025 10:22:18 -0700 (PDT)
From: Dean Marx <dmarx@iol.unh.edu>
To: probb@iol.unh.edu, luca.vizzarro@arm.com, yoan.picchi@foss.arm.com,
 Honnappa.Nagarahalli@arm.com, paul.szczepanek@arm.com
Cc: dev@dpdk.org,
	Dean Marx <dmarx@iol.unh.edu>
Subject: [PATCH v1 2/2] dts: add exception handling to checksum verify method
Date: Tue, 22 Jul 2025 13:22:14 -0400
Message-ID: <20250722172214.202308-2-dmarx@iol.unh.edu>
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

Current implementation of the checksum offload test suite
contains a section in the verify checksum method
that causes NameError exceptions when the packet is
dropped. Add a try block to encapsulate this section
and handle any errors created.

Fixes: 8c9a7471a0e6 ("dts: add checksum offload test suite")

Signed-off-by: Dean Marx <dmarx@iol.unh.edu>
---
 dts/tests/TestSuite_checksum_offload.py | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/dts/tests/TestSuite_checksum_offload.py b/dts/tests/TestSuite_checksum_offload.py
index b03c3d46ed..9dfbcb8028 100644
--- a/dts/tests/TestSuite_checksum_offload.py
+++ b/dts/tests/TestSuite_checksum_offload.py
@@ -89,8 +89,11 @@ def send_packet_and_verify_checksum(
             if testpmd_packet.l4_dport == id:
                 is_IP = PacketOffloadFlag.RTE_MBUF_F_RX_IP_CKSUM_GOOD in testpmd_packet.ol_flags
                 is_L4 = PacketOffloadFlag.RTE_MBUF_F_RX_L4_CKSUM_GOOD in testpmd_packet.ol_flags
-        self.verify(is_L4 == good_L4, "Layer 4 checksum flag did not match expected checksum flag.")
-        self.verify(is_IP == good_IP, "IP checksum flag did not match expected checksum flag.")
+        try:
+            self.verify(is_L4 == good_L4, "Layer 4 checksum flag did not match expected checksum flag.")
+            self.verify(is_IP == good_IP, "IP checksum flag did not match expected checksum flag.")
+        except NameError:
+            self.verify(False, "Test packet was dropped when it should have been received.")
 
     def setup_hw_offload(self, testpmd: TestPmdShell) -> None:
         """Sets IP, UDP, and TCP layers to hardware offload.
-- 
2.50.1

