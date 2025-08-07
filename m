Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ACEBC87FCA
	for <dpdk-dev@archiver.kernel.org>; Thu,  7 Aug 2025 15:34:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1CF5540652;
	Thu,  7 Aug 2025 17:34:04 +0200 (CEST)
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com
 [209.85.160.178])
 by mails.dpdk.org (Postfix) with ESMTP id DA56E40270
 for <dev@dpdk.org>; Thu,  7 Aug 2025 17:34:02 +0200 (CEST)
Received: by mail-qt1-f178.google.com with SMTP id
 d75a77b69052e-4af156685e2so29435051cf.1
 for <dev@dpdk.org>; Thu, 07 Aug 2025 08:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1754580842; x=1755185642; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/8nzwBJS2Iu+UWa+/s+P6zGA5y+Fide30YvktlZIa+M=;
 b=bw76oXSUC8kinCHJQMs519v2Wg5rWeoyqOSkKtMF8oLM4LlT/DTiE7Um0KY5o6UGAP
 ElZTJjeqkjD+ssOjq5dMmXEodKkrfLKgpKQ0Spb7k2rYgX5rmzd5OMtKuCa9kRHk8Uuf
 HAnYHh1s41ZmneYsCUUU4LmUveKvxeiObv/OQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754580842; x=1755185642;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/8nzwBJS2Iu+UWa+/s+P6zGA5y+Fide30YvktlZIa+M=;
 b=X/+QesadVJ+ZWYiaXHReA2PA/w4w9V49Ux63yeZPr59gU73Kh+hq2ppN9TL9+w6Z6J
 cbCbeQL5/PNL5aiZh8nk82G0DfQ2zaijOtsJTKL9kb7PiOnaUc98apvnnPb/3rc6SGcQ
 DQlALYXhAsDuQcivDsrrwNLBsUNcYQo2zezW8UB90drBYiUcNNKtUPaRf82GZajPURVK
 l974srgUa9q82MeG/N5w8aEyr1UV+E7ZePd8yTlZaJp07I36GLDZpdit0+VJJrO41bmh
 im1352qkN9C7+cTs/m86x65Nf3JSL9vuJlpwgarWd5q4Z3GpdAjoa4SmQmAOhR9hQi+P
 75+g==
X-Gm-Message-State: AOJu0YwTailmZgSXIpPLbK6n4ghYewawKZ85/11w12cxbi1FJgKD3O+p
 9jakEN3HdcGyZPT6WA5TWZEuSmCxbfUb0AHeiiho9TWNUdv09lQ1AfZu4HAcBu/BO/w=
X-Gm-Gg: ASbGnctK32S45H+gXVZrbnLVgTh2A+54rHywbLoGKHhhrbGg9OIGkMqJBPF4iMyBJNx
 megiighA7RGiO/PU0OKSXpuyZEf3saERQA6xKOr/9H85n+75KDTVcIs2WaLnWCz4ry86WRsCLJk
 waKcZoQRtBsV4dQkj6A4EoJ8Y/GDsctP+ObTP0K+cEOKBx5wOlDj8ZFSbKrokveAwogpLada/V5
 pUjaTaDCPkFh4h+vuOjMxVE1gjZn+kYc0jknqI46bziheOEn8h6SZ9vq2LSM2lLTBdbOjN5H7rm
 aBgfaABHvM3FmqKR2G+1/a6CjJ+jV0tACxKOBC+LiM8BqzCHJCQhUDB17aBXDT0oEKgqi/6OCcE
 am/2gLZVj875kBhS5sxTAbO7uw3L1arDE
X-Google-Smtp-Source: AGHT+IHzQiFA07MxFlwJll+N0ESg3lD+bSPODYHT8zo7tw2fc21kVpTolU1uu8nd85U/cbB7MMMapA==
X-Received: by 2002:a05:622a:13c7:b0:4ab:3963:c650 with SMTP id
 d75a77b69052e-4b0a0718816mr61355301cf.10.1754580841873; 
 Thu, 07 Aug 2025 08:34:01 -0700 (PDT)
Received: from fedora.iol.unh.edu ([2606:4100:3880:1271:ac5d:4186:4dc6:47eb])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4b095e6c7d4sm19943141cf.54.2025.08.07.08.34.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Aug 2025 08:34:01 -0700 (PDT)
From: Dean Marx <dmarx@iol.unh.edu>
To: probb@iol.unh.edu, luca.vizzarro@arm.com, yoan.picchi@foss.arm.com,
 Honnappa.Nagarahalli@arm.com, paul.szczepanek@arm.com
Cc: dev@dpdk.org,
	Dean Marx <dmarx@iol.unh.edu>
Subject: [PATCH v2 2/2] dts: add reception check to checksum offload suite
Date: Thu,  7 Aug 2025 11:33:58 -0400
Message-ID: <20250807153358.304262-2-dmarx@iol.unh.edu>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250807153358.304262-1-dmarx@iol.unh.edu>
References: <20250722172214.202308-1-dmarx@iol.unh.edu>
 <20250807153358.304262-1-dmarx@iol.unh.edu>
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

In the current implementation of Checksum Offload, the variables
is_L4 and is_IP are not initialized outside of the loop that
checks the received packet, so if the packet is dropped these
variables cause a NameError in the verification steps.
Add a line that sets these variables to None prior to the check,
then verifies they are not None directly after.

Fixes: 8c9a7471a0e6 ("dts: add checksum offload test suite")

Signed-off-by: Dean Marx <dmarx@iol.unh.edu>
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

