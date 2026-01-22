Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21356D489BF
	for <dpdk-dev@archiver.kernel.org>; Thu, 22 Jan 2026 17:47:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 87D58402D3;
	Thu, 22 Jan 2026 18:47:48 +0100 (CET)
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com
 [209.85.219.44]) by mails.dpdk.org (Postfix) with ESMTP id AE2FF4026F
 for <dev@dpdk.org>; Thu, 22 Jan 2026 18:47:46 +0100 (CET)
Received: by mail-qv1-f44.google.com with SMTP id
 6a1803df08f44-8947e17968eso12274976d6.0
 for <dev@dpdk.org>; Thu, 22 Jan 2026 09:47:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1769104066; x=1769708866; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3NWxcUnYDjYwWuaKKXKYSjRkTEd0bQglj6OaSeMP5cI=;
 b=B2z4bpG7gGDcOSEh+qbl106NZTuaUgYAv/bDXjoQFV2xeGwabPD/ifqhB1sS1ks/Vr
 aWOmoeIGnWV8SsQUI6xuBMyM2bbY8smWkZEZV5n7zY9hv/pfnTn/lgXYT0DyKfl8NjcY
 GsXrS+B4yOoDaDYXabtiF1+TQrQrapbib0MjU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769104066; x=1769708866;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3NWxcUnYDjYwWuaKKXKYSjRkTEd0bQglj6OaSeMP5cI=;
 b=a1ayrTX7N//KnrmWYaGg8F1Zmt2TPVUQS2WJ3uqmw4+N86qVpSvFjOf56h+8QF02kQ
 uey1fwBXNqPymBpElRsqVxONah+ag7RsDOxheDw67sHtMhCCGNfiZvIGq/xqbPHsdkhH
 PNEuuWM4xTv6jnTN3OZy9GHG6HOc/+oquLiYbUgFNEdz2lwzgzj1m12IXV1kT7IrjgYq
 oCKwemY/N02g8BRnbha2+HBybOie0CglZSYvPwLVTe/KPxK7HW2bcKPlO4in555D9pqx
 1rT8ld49tYYwh3mqKWjNDjOe7+nbBmXzpypoF8zPtSLs5t2QJkYKuLUy2Rb7kiEy5IbY
 4mgA==
X-Gm-Message-State: AOJu0YzGyeODCyhH2lNNUljygeyl+56/ODfoQ+rPZ4HE7rOppix/tz5r
 Oh7EhkDl+mOFpYqZUT3vv1AAMjes1mAbBbWKqQZ8XhP/ceCze6/8quE5OYL65vZOZzB+UL5WX/h
 lXQjt
X-Gm-Gg: AZuq6aIv0D37H1a4ciQMT6+zdb13poKvOFKnhagqdDLt+HU8mCLGpeBl6wp4BUvysth
 H/VSxzpFjKhmd5fou3oIC75SjWRoQGyy85vd+Q+HgB5NpSAQmerTGVzUIiqyhIQVdaEI0IvRdey
 uMBBzC6Ia1JKyc7RtWdyn1jx4xmvWpmXiQ4qe6PAIpnJgvu8LkfSokPTjg8ucSgeCh8g9BijG6J
 XFbqx/zq8oxDw+lu1lpC7uzTz4iJug44CEFhsdkKnTjwcQrARxLE13k1ROVsTjN0lopvbfD+RxR
 BilMcJrmY/tZe7IrRxAVHiNaUqePjUMoIbpcxFogtFFhE4YzWobkVuolimucFvmPOUsrOknYLt7
 /3BRqPVKdByhhTJ9W9+rpwlPOR5IJv6Fy4+QqXNVaaHofHlg2BzHZYMb4ciPouqPapAPR3V9pGj
 otZT4N9AACD9StsdTXIr5gV4qt/4o4Ssk=
X-Received: by 2002:ad4:5d61:0:b0:894:6e23:3c3f with SMTP id
 6a1803df08f44-894901ca375mr4868946d6.20.1769104065947; 
 Thu, 22 Jan 2026 09:47:45 -0800 (PST)
Received: from d121016.iol.unh.edu ([2606:4100:3880:1210::202])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8942e605f93sm147943676d6.24.2026.01.22.09.47.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Jan 2026 09:47:45 -0800 (PST)
From: Dean Marx <dmarx@iol.unh.edu>
To: probb@iol.unh.edu, luca.vizzarro@arm.com, yoan.picchi@foss.arm.com,
 Honnappa.Nagarahalli@arm.com, paul.szczepanek@arm.com
Cc: dev@dpdk.org,
	Dean Marx <dmarx@iol.unh.edu>
Subject: [PATCH v4 2/2] dts: fix docstring typo in dynamic queue suite
Date: Thu, 22 Jan 2026 12:47:42 -0500
Message-ID: <20260122174742.237855-2-dmarx@iol.unh.edu>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260122174742.237855-1-dmarx@iol.unh.edu>
References: <20251106181355.209706-1-dmarx@iol.unh.edu>
 <20260122174742.237855-1-dmarx@iol.unh.edu>
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

Add missing colons to the verify sections of the
dynamic queue test suite cases.

Fixes: ae9b7659fc77 ("dts: update test suites doc")

Signed-off-by: Dean Marx <dmarx@iol.unh.edu>
Reviewed-by: Patrick Robb <probb@iol.unh.edu>
---
 dts/tests/TestSuite_dynamic_queue_conf.py | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/dts/tests/TestSuite_dynamic_queue_conf.py b/dts/tests/TestSuite_dynamic_queue_conf.py
index 3ddfa31152..5ac85bee7d 100644
--- a/dts/tests/TestSuite_dynamic_queue_conf.py
+++ b/dts/tests/TestSuite_dynamic_queue_conf.py
@@ -287,7 +287,7 @@ def rx_queue_stop(self) -> None:
             * Set forward mode.
             * Send packets with different addresses and capture.
 
-        Verify
+        Verify:
             * Stopped queues don't handle traffic and doesn't block traffic on other queues.
         """
         self._stop_queues(True)
@@ -302,7 +302,7 @@ def rx_queue_configuration(self) -> None:
             * Set forward mode.
             * Send packets with different addresses and capture.
 
-        Verify
+        Verify:
             * Ring size of port queues can be configured at runtime.
         """
         self._modify_ring_size(True)
@@ -317,7 +317,7 @@ def tx_queue_stop(self) -> None:
             * Set forward mode.
             * Send packets with different addresses and capture.
 
-        Verify
+        Verify:
             * Stopped queues don't handle traffic and doesn't block traffic on other queues.
         """
         self._stop_queues(False)
@@ -332,7 +332,7 @@ def tx_queue_configuration(self) -> None:
             * Set forward mode.
             * Send packets with different addresses and capture.
 
-        Verify
+        Verify:
             * Ring size of port queues can be configured at runtime.
         """
         self._modify_ring_size(False)
-- 
2.52.0

