Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D36E8D3CC86
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Jan 2026 22:27:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F1C8242759;
	Wed, 14 Jan 2026 23:25:40 +0100 (CET)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44]) by mails.dpdk.org (Postfix) with ESMTP id F040A41141
 for <dev@dpdk.org>; Wed, 14 Jan 2026 23:25:37 +0100 (CET)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-47ee76e8656so3631325e9.0
 for <dev@dpdk.org>; Wed, 14 Jan 2026 14:25:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768429537;
 x=1769034337; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HJ+iWJDdQo/rvI/za3xFdgQhyZDNTtANiK3diSm3cw8=;
 b=BoJzRVQV5/xnrUxw2D0ki5S9vjSRqAGhPaUyrWVjD4yf9wfs9PqIhWmgamaSuJFiBh
 qepShy9RpA98B9Wa6sNWZ07kI2HuznPfF6vpMKOlGMctRw0VtWQJRzrZTdV4Q3OP99uR
 yF5AsXyhSkXVLIFY5akl+Fhli2HC+TqVQQHuvqFbuYRQdsGPlB04duoSHQUnYvA2U2Ua
 5QCdbh6Xvv3DJwWsViYSNPFeDBEBk6UBPPBjlzVHBscYMHBweZVM+t902AVtfczpXuHW
 gL5LyBmy9p+EFgV8XOInDdIF2aWhaA0bfgs0kbVlpm3bhGR7CVrrTQi9Iw64KCLB0Agr
 Irlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768429537; x=1769034337;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HJ+iWJDdQo/rvI/za3xFdgQhyZDNTtANiK3diSm3cw8=;
 b=ZpkSRusm4M27S4oks697G5UbZ/gKkKWeiYsDpZDj0mhcRKKPQ7a/qVfJ81zWERZZI7
 OVSD30U6nNkTdRaBH+tj/L1uALjkPdQ6YILz0wCavKrskzgnrOhqjdCBfiNDGx1VXBqa
 nJFOMkZG+WUz8HwC7a9fsOp04MtXZAYS4XP4cr1HzP0knd6QAqAsb4/W7z3q8TBnL24B
 mgBRFN1o8z0LKeJ57F8n15bkBGa50929776r37t2sWX+bGdFsKQi2htbb1rTmaFnH+G5
 LH4T70fDPKMYYYVXrvyGJcc7tD++W64P/TTR2Q3eR/SnNZw3OEGRKjep8gvbRNm2flKz
 BSxg==
X-Gm-Message-State: AOJu0Yw/a54nPchnzvsiTbDxH/dWcFVPKYFWOhkuETa26c5vglq346Op
 Bcel3iWAvj9uCy601AOgP+ffn1pVPKLot2ELjlUcAszNgDz6tGHs/+n3daKRVs0zmMcyVGloQXC
 u5FIw
X-Gm-Gg: AY/fxX7Rsl1osHxoSvRzZwihRM9c99WIOJmEbYuFs+lY3WGB6CPXo2oBjObxfXrTVv7
 uE7mS0nZXUCnj7ctl0OAnJ2UeSkAZ0l8Lj9kXFmezn5XLO7Otk05g790BqJ8ylg7ct9XCPJu+R0
 yTXIzwlacLZcBssvTpMgbgm5jEocS9/RwEJ5XmBroWMRwn4EdLuwJZtS+//j5daVZ9JRjdhOlky
 9m5yaIpvOqsTBYKCCXcCfP2qDnupvUVb5dSdwN/yJxQZ3KQHENfExskDQGkkkLhjhDP1avLThtd
 e5AEDO2out7QTRTjCucCeg6mwOhDsF7riss2D9MZa1BMtb/lgcE9jeUPiEO9RXUdFgiaLoq3whh
 AJeRqS50U7RYS4nb6bnfoSoHknM74JhivIyCnSGZuj+sbgJHPuGY9zedMQooUYSC6cPFlhXu2uM
 Y6PjiWo6Re6IugDQyunXWJq5ZeT4Sn/ZaPfX2pFPXath6GJIjrOw==
X-Received: by 2002:a05:600c:4fc9:b0:477:6e02:54a5 with SMTP id
 5b1f17b1804b1-47ee33719c3mr44956845e9.18.1768429537600; 
 Wed, 14 Jan 2026 14:25:37 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47f42907141sm12040355e9.9.2026.01.14.14.25.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Jan 2026 14:25:37 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Cristian Dumitrescu <cristian.dumitrescu@intel.com>
Subject: [PATCH 20/29] doc/guides: improve IP pipeline sample app guide
Date: Wed, 14 Jan 2026 14:22:01 -0800
Message-ID: <20260114222458.87119-21-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260114222458.87119-1-stephen@networkplumber.org>
References: <20260114222458.87119-1-stephen@networkplumber.org>
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

Improve the IP pipeline sample application documentation:
- rename sections for consistency with other guides
- fix port enable/disable command descriptions which
  incorrectly referred to input ports instead of output ports

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/sample_app_ug/ip_pipeline.rst | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/doc/guides/sample_app_ug/ip_pipeline.rst b/doc/guides/sample_app_ug/ip_pipeline.rst
index f9e8caa0a8..153a6e3900 100644
--- a/doc/guides/sample_app_ug/ip_pipeline.rst
+++ b/doc/guides/sample_app_ug/ip_pipeline.rst
@@ -4,8 +4,8 @@
 Internet Protocol (IP) Pipeline Application
 ===========================================
 
-Application overview
---------------------
+Overview
+--------
 
 The *Internet Protocol (IP) Pipeline* application is intended to be a vehicle for rapid development of packet processing
 applications on multi-core CPUs.
@@ -107,8 +107,10 @@ Once application and telnet client start running, messages can be sent from clie
 At any stage, telnet client can be terminated using the quit command.
 
 
-Application stages
-------------------
+Explanation
+-----------
+
+The following explains the stages of the application.
 
 Initialization
 ~~~~~~~~~~~~~~
@@ -134,7 +136,7 @@ executes two tasks in time-sharing mode:
    to/from given table of a specific pipeline owned by the current data plane thread, read statistics, etc.
 
 Examples
---------
+~~~~~~~~
 
 .. _table_examples:
 
@@ -396,11 +398,11 @@ or table ::
   pipeline <pipeline_name> port out <port_id> stats read [clear]
   pipeline <pipeline_name> table <table_id> stats read [clear]
 
-Enable given input port for specific pipeline instance ::
+Enable given output port for specific pipeline instance ::
 
-  pipeline <pipeline_name> port out <port_id> disable
+  pipeline <pipeline_name> port out <port_id> enable
 
-Disable given input port for specific pipeline instance ::
+Disable given output port for specific pipeline instance ::
 
   pipeline <pipeline_name> port out <port_id> disable
 
-- 
2.51.0

