Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3183C54F30
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 May 2025 15:37:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AE42E40A80;
	Tue, 27 May 2025 17:37:42 +0200 (CEST)
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com
 [209.85.222.169])
 by mails.dpdk.org (Postfix) with ESMTP id 20DD34066C
 for <dev@dpdk.org>; Tue, 27 May 2025 17:37:41 +0200 (CEST)
Received: by mail-qk1-f169.google.com with SMTP id
 af79cd13be357-7c5b2472969so352999285a.1
 for <dev@dpdk.org>; Tue, 27 May 2025 08:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1748360260; x=1748965060; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r/+AoRZImsQgt+4xQOwjl27WGBbL/yNhWqY8zw1fAGI=;
 b=ORvqr6fyZdYsdNXBNR+N13+HvSsgQQekW/zmBEBSIK/Y98G0EaweU/8SGEFpqpG61e
 UJwI38RX8/QcAvI/cdcH/TdyPjEuxqvaBtnaWsMBSXvDPvXA1DSIy1D/A4vTtW4bNs8x
 07oGzWmxhxqwQ1EpnYEnsB338lrp6SZul+vGM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748360260; x=1748965060;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=r/+AoRZImsQgt+4xQOwjl27WGBbL/yNhWqY8zw1fAGI=;
 b=HZpCZ4HTTgtqXfHZB6T6iUa+EzFavUDKrpkC1ceWC/YqwLbeT6Pb/6jBJihuuCdW2A
 inZarJSBHLFU7l1+YTTaRXKdopx9NCgiBCnwGTneQ5GRWrxWhtZRw102BP/teV0LoUCQ
 oH3rg+WfS2f7cu1vuJH2Mqvha3SmsIYEw6zaNvvsBIm36uOpb7ATgr96uzxhXk+E1cYJ
 wT/4YFrL/bUf1RhMz8dZQx9IZHOprHRvyhWS8+IKkqDWujqjCnmHD3KCFdBmN4m6Rrph
 V8iY+KwwZg7hGdl78NyjsTek+fKDEEFZ35GjtsXZgSQHw08ykK7dIXWfthqqkZD6qNAm
 gLyg==
X-Gm-Message-State: AOJu0Yy+VgjiJ3+367km2eJ+AgI7AlEnogDoVylI69E0xZU6NTlAhVt2
 ToqR0HXjLuRDV3M9j81KYzOleJYQhojGJhXQFS9p/9sIu/+gnc3NGiokHz8qNdIzilw=
X-Gm-Gg: ASbGncs1hC0eGu08Rqz5Xw5CFeWdnjHJMHXlvz4bvBZI/14ALMKOboDrtAbH4fke/Pv
 9FOSfBfZ7a/PC4mu30kB9foeThnCWKECla1h54QqoO6xb3UFGWrP6UsDjQ79jNfDvOT2SOVaxCo
 2j7JQoJcGo98qXJqPZiG3s3PF3bFFdEifbfF6IcyBYuexg5sZLf6HiMFYzQKBWwZi7r+du4iBW6
 IHn9fVbiJ86JjVON/Kra7Ykb4YJ/tfmFwssON+6wyTuSZemI4qHfuXmMtgrgAyksJytgnRmSRbz
 CKGRjVuJTDDczBqRGQq7TcyjKKcdIi6I+TPbZKZUFQg+ulwBPt6pAM78spoFH/NB
X-Google-Smtp-Source: AGHT+IHskmuArsmByML55tRmzLcDLw1hWq8vUbiGUPUwK07g0NaJ2NA3Sr4nZ4ZBvyB49ZbDojoJFg==
X-Received: by 2002:a05:620a:f15:b0:7cd:1f0f:f61d with SMTP id
 af79cd13be357-7ceecc44736mr2158665585a.54.1748360260264; 
 Tue, 27 May 2025 08:37:40 -0700 (PDT)
Received: from fedora.hsd1.nh.comcast.net ([2606:4100:3880:1257::100a])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7cd467bd91asm1753910685a.7.2025.05.27.08.37.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 May 2025 08:37:39 -0700 (PDT)
From: Dean Marx <dmarx@iol.unh.edu>
To: probb@iol.unh.edu, luca.vizzarro@arm.com, yoan.picchi@foss.arm.com,
 Honnappa.Nagarahalli@arm.com, paul.szczepanek@arm.com
Cc: dev@dpdk.org,
	Dean Marx <dmarx@iol.unh.edu>
Subject: [PATCH v1 3/3] dts: fix doc generation bug
Date: Tue, 27 May 2025 11:37:34 -0400
Message-ID: <20250527153734.368235-3-dmarx@iol.unh.edu>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250527153734.368235-1-dmarx@iol.unh.edu>
References: <20250527153734.368235-1-dmarx@iol.unh.edu>
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

Fix a bug in the port stats check test suite that was causing
the DTS doc generation to fail.

Fixes: 8f21210b1d50 ("dts: add port stats check test suite")

Signed-off-by: Dean Marx <dmarx@iol.unh.edu>
---
 dts/tests/TestSuite_port_stats_checks.py | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/dts/tests/TestSuite_port_stats_checks.py b/dts/tests/TestSuite_port_stats_checks.py
index 2a3fb06946..491c2263b6 100644
--- a/dts/tests/TestSuite_port_stats_checks.py
+++ b/dts/tests/TestSuite_port_stats_checks.py
@@ -51,10 +51,15 @@ class TestPortStatsChecks(TestSuite):
 
     #: Length of the packet being sent including the IP and frame headers.
     total_packet_len: ClassVar[int] = 100
-    #: Packet to send during testing.
-    send_pkt: ClassVar[Packet] = (
-        Ether() / IP() / Raw(b"X" * (total_packet_len - ip_header_len - ether_header_len))
-    )
+
+    @property
+    def send_pkt(self) -> Packet:
+        """Packet to send during testing."""
+        return (
+            Ether()
+            / IP()
+            / Raw(b"X" * (self.total_packet_len - self.ip_header_len - self.ether_header_len))
+        )
 
     def extract_noise_information(
         self, verbose_out: list[TestPmdVerbosePacket]
-- 
2.49.0

