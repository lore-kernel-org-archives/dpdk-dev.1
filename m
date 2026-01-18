Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2878EC9830C
	for <dpdk-dev@archiver.kernel.org>; Sun, 18 Jan 2026 19:17:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 79EF542DF0;
	Sun, 18 Jan 2026 20:14:34 +0100 (CET)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com
 [209.85.218.49]) by mails.dpdk.org (Postfix) with ESMTP id E4FF340E26
 for <dev@dpdk.org>; Sun, 18 Jan 2026 20:14:30 +0100 (CET)
Received: by mail-ej1-f49.google.com with SMTP id
 a640c23a62f3a-b7ffbf4284dso473563566b.3
 for <dev@dpdk.org>; Sun, 18 Jan 2026 11:14:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768763670;
 x=1769368470; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XvOaFVvGzjTAR/ZyHvRS+lz3PeeL5NYwRjltJi/Tq0E=;
 b=aHhHql4O9mwGl1Nz2pYHehtZWYqLHLqdxTnYkmF57MMuIY+JS5pIPLblHBwuW8qgZD
 rmtxVdPJtKD17XXBprBSvRFfRXly1D20d3klMCwlCyT49qrucYRzh4JvvGf6Tym0WG/h
 YEVZQejRU1hBMsKXwwT0AcY0KC+7R02iJdxsNmCQGvtYWh2gRXVu99BsYUnRJdvHSSNK
 2cyp8/zPhSTeKAfYd97ZEePOO5U6IVFRFykiitBDtn6mwC2AS4JRixbq/1MApRBBZLH9
 nPj6CK+WXynUQq8jBCq8ey6AfcvHvu3CZg/aflLJ80OqHVFprMvcn0ExmNMCAYBMvjaa
 yjgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768763670; x=1769368470;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XvOaFVvGzjTAR/ZyHvRS+lz3PeeL5NYwRjltJi/Tq0E=;
 b=fu+Ra2EuSqG7j1Y9ug/IthlchIKVJvk9OoCvQ3Hwlc52QYqrHhD/uKpYJM2jfX/jFs
 jfEKmZXjwMkKy6fF2US7hMZDX1gLQ02H9ixOIli0hSoRyALnJbBMegitBaKbjJnyjKqY
 CtanqZ4JvZ4Xmc7AOaxRuFRGt5qNYVj2HSzez2wiTGyqG0c73W+4oUbFG/9k3fxtfWfX
 woiTxxQw+g/Ut8dtn17idmY6THueWG/J+Y64qupkVRb7u6iF9SfHSN2LVPAasMyEBzYN
 s/nGyQUJaEzgAjrdwIn4OHzBeXhmCKpiKf3PsRICVbNu1pi3yKXcJUmMt9fTLucw9Rw1
 iyQQ==
X-Gm-Message-State: AOJu0YwoL3k6UDz2O28Z/0I+gnU67vt8R/k6jj8QwfW6r2SH8FaPUQ5R
 UqcBCL3amqtVe80W352j9FFMY+0BUtGm3emPK8qw/360z2GS1mXRTXS7HwRO3NXZ++X+OBPUQ6f
 pOh3r
X-Gm-Gg: AY/fxX5LRnKTi0lrqkSu27L7XeUzS7DPG+qc5ziZCdiWXNHR91J/8Hicwozhk2HIjBB
 HKKh3BvD2ryE0U2pVycFybd510xlltJ3HSWx+ePay2sZqMX+wK4vbd/2ZdKmy49aF4WUNm3Y0d6
 64gJyA3XQrkc548j8X9q0T/zeqPmTJYxaNqWdGj+fb8ds9Jz0qdEApAEkGClq3U92d8azf4flby
 r0P9pz+mPvZ3oS650LXRKvupz1j/2b6cvOAAaQkI0pl/lPeG5WPdgxWINg/zN7nlj//zYOdun+v
 cY/yFx8++O0tmDQKgttSSeJ7glICduMp6gn5irJHW14WvkC4Opg9bzyFriWSe+Spfytfeaw8pWP
 DrsXtraRoRLahd7PTMrgkDUahI8sw/RUl1uYcqWTTsruMO30e0BaVnKdshSlXhvYSke+V1zcFvR
 Enp4yl7FeXhA27xdZPYtA6iIRP0GGASuf2YhW+66qSTU7rvRsrWqfz8JdB4mJu
X-Received: by 2002:a17:907:2d0e:b0:b81:ec75:d649 with SMTP id
 a640c23a62f3a-b8792e3a484mr709012066b.27.1768763670450; 
 Sun, 18 Jan 2026 11:14:30 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b87959c9f8dsm886287166b.36.2026.01.18.11.14.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Jan 2026 11:14:30 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v5 40/54] doc: correct typos in packet distributor guide
Date: Sun, 18 Jan 2026 11:10:43 -0800
Message-ID: <20260118191323.241013-41-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260118191323.241013-1-stephen@networkplumber.org>
References: <20240513155911.31872-1-nandinipersad361@gmail.com>
 <20260118191323.241013-1-stephen@networkplumber.org>
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

Correct various issues in the packet distributor documentation:

- remove extra space after "each"
- fix typo "work" to "worker" in queue description
- fix "of less use that" to "of less use than"
- fix inconsistent capitalization "APIS" to "APIs"

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/prog_guide/packet_distrib_lib.rst | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/doc/guides/prog_guide/packet_distrib_lib.rst b/doc/guides/prog_guide/packet_distrib_lib.rst
index 3c3b746aca..10e187be04 100644
--- a/doc/guides/prog_guide/packet_distrib_lib.rst
+++ b/doc/guides/prog_guide/packet_distrib_lib.rst
@@ -33,11 +33,11 @@ The operation of the distributor is as follows:
 
 #.  As workers request packets, the distributor takes packets from the set of packets passed in and distributes them to the workers.
     As it does so, it examines the "tag" -- stored in the RSS hash field in the mbuf -- for each packet
-    and records what tags are being processed by each  worker.
+    and records what tags are being processed by each worker.
 
 #.  If the next packet in the input set has a tag which is already being processed by a worker,
     then that packet will be queued up for processing by that worker
-    and given to it in preference to other packets when that work next makes a request for work.
+    and given to it in preference to other packets when that worker next makes a request for work.
     This ensures that no two packets with the same tag are processed in parallel,
     and that all packets with the same tag are processed in input order.
 
@@ -78,7 +78,7 @@ while allowing packet order within a packet flow -- identified by a tag -- to be
 
 
 The flush and clear_returns API calls, mentioned previously,
-are likely of less use that the process and returned_pkts APIS, and are principally provided to aid in unit testing of the library.
+are likely of less use than the process and returned_pkts APIs, and are principally provided to aid in unit testing of the library.
 Descriptions of these functions and their use can be found in the DPDK API Reference document.
 
 Worker Operation
-- 
2.51.0

