Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFED8CD343F
	for <dpdk-dev@archiver.kernel.org>; Fri, 15 May 2026 17:47:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 83118402C1;
	Fri, 15 May 2026 19:47:21 +0200 (CEST)
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com
 [209.85.222.173])
 by mails.dpdk.org (Postfix) with ESMTP id C49E540269
 for <dev@dpdk.org>; Fri, 15 May 2026 19:47:19 +0200 (CEST)
Received: by mail-qk1-f173.google.com with SMTP id
 af79cd13be357-911dfc86903so15905985a.3
 for <dev@dpdk.org>; Fri, 15 May 2026 10:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1778867238; x=1779472038; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=CZKfllA0Qv8wzMqduWWolD3SlPfvxwMR6a30pcJnShE=;
 b=BHK9cSvq3w02qKln9E3Gd37gu1m+izLhavDgpU9sX3uNFOKhLlac6+lQp7Wbr/ab/T
 RLAFcw6bZ6CpxkT8/LW8MUxYzlSFgeZgDGb97igLzQ7o5slN/KbpHUqbZ8kuKOXa/CWd
 ZERNaAUWwcWJBKFcVnxFZin0YaHA6OZVGOZOw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778867238; x=1779472038;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CZKfllA0Qv8wzMqduWWolD3SlPfvxwMR6a30pcJnShE=;
 b=pJAb8fmL/T40/XBIDteq0GGVBeawBg3AMYZ+0ciqlL1/vorhThsgyZawKYawpwxQkc
 5mvtuwMVhJSJVA8bFKK7f1gsAYNCngf+51DcCPpF7eHEd0iXiuaWB7ma4L7/Si0TfL09
 7o8EwsDtKi43m9t31/23WKVv8+qa97nCYRxZ3d40Wl4MpfZveJjI2XY+B0BTELus9Wdt
 de/4na+Lom0+4oEFUFdbRgopnSuFJH8bTgcJXezIpbg/DnTKeRjTTIu7EB6dC80gtL1x
 5jp1y00+2ZBtrmpDCd1ldE8zoVqEEYvhyvsqR0bK1qsAAThc+xAihJLD5vTkccGf8qkE
 zmkA==
X-Gm-Message-State: AOJu0Yz2wi8yA4GMQxtvOzGrY0EVvles8hpLyfnDPbtqxheHTqSrsRV/
 zppIz5GtnW25NMqeh/F2Dlcp7UAUSQLIYj+j8BFyQc51GJbIK+z0+HWIuP2Vz50NdKyA3rkUcPA
 do4qBLz0NGOYvxttWzuDFMztirovvFdhe4GkHrNQ2PVS95LPpNySXERFWTYKxTM1wKY6oLON/6k
 u84vMGpCU6qMKgSPSX0b9RBKowYho=
X-Gm-Gg: Acq92OHtXR6XPzrtI+gl8TpOf+jf7mfXLXViFyQ5pdMBxTINKDsoXQqSSErvP5vUpr1
 Y5a1VKP/hgTA1gyWNHnjBijXxd6/8CdFKHqd05uqHy20Yje56I/EHfTm4ILVeuApHsm93etYy1O
 h0fgLSdoJoYqvtrSEfz04PMtzNcY5mgm/lt4EohMamRRoYkU3OkznhVjJxKtQOTEH4/fqMqZhqZ
 JbyihhhozjHfjxO1TnKlPwMKs9SupVti58OFUM3McbL1vq17nT0ek9hmQj7UmzEoABDv56FmOiq
 d/8rOv9WmuwAiLMCjHNGgkbi6NEMJ6E9Ubd1IuKq633z5llYbRH1XWjVdg3zCCRVQWHO2vKpwyt
 JXgo14W0/fjDfF4tU0gpLYIIUrrGZNaI0NAg6liGz+U5F3cKr/Zs+QSUx4XU/vnErHAiNPThmvP
 GNRSv0RaCALJHuPmyZsofqnr2DFDQI+pfiYyYsDovQD/SVtnlZOGtD8B1KQwk1uyO0K8N2oH2aq
 Cs=
X-Received: by 2002:a05:620a:1711:b0:910:d4ca:4a8a with SMTP id
 af79cd13be357-911d0c5cff5mr854606185a.61.1778867238372; 
 Fri, 15 May 2026 10:47:18 -0700 (PDT)
Received: from d122201.iol.unh.edu ([2606:4100:3880:1220:4f6d:e2af:7f5f:4df])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-910bc83f926sm617658985a.30.2026.05.15.10.47.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2026 10:47:17 -0700 (PDT)
From: Andrew Bailey <abailey@iol.unh.edu>
To: dev@dpdk.org,
	luca.vizzarro@arm.com,
	patrickrobb1997@gmail.com
Cc: lylavoie@iol.unh.edu, ahassick@iol.unh.edu, knimoji@iol.unh.edu,
 Andrew Bailey <abailey@iol.unh.edu>
Subject: [PATCH v1] dts: add sleep to trex setup
Date: Fri, 15 May 2026 13:47:14 -0400
Message-ID: <20260515174714.211668-1-abailey@iol.unh.edu>
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

Previously, there were some cases where the single core performance test
suite would report zero Mpps. Adding a sleep in between setting up the
TREX generator and sending the packets resolves this issue.

Bugzilla ID: 1946
Fixes: d77d7f04f24c ("dts: add single-core performance test suite")

Signed-off-by: Andrew Bailey <abailey@iol.unh.edu>
---
 dts/framework/testbed_model/traffic_generator/trex.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/dts/framework/testbed_model/traffic_generator/trex.py b/dts/framework/testbed_model/traffic_generator/trex.py
index 22cd20dea9..19a71a7dd5 100644
--- a/dts/framework/testbed_model/traffic_generator/trex.py
+++ b/dts/framework/testbed_model/traffic_generator/trex.py
@@ -184,6 +184,7 @@ def _generate_traffic(
         """
         self._create_packet_stream(packet)
         self._setup_trex_client()
+        time.sleep(1)
 
         stats = self._send_traffic_and_get_stats(duration, send_mpps)
 
-- 
2.50.1

