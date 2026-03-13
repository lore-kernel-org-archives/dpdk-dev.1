Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71EBE107BCD0
	for <dpdk-dev@archiver.kernel.org>; Fri, 13 Mar 2026 18:22:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 56A36402BB;
	Fri, 13 Mar 2026 19:22:44 +0100 (CET)
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com
 [209.85.160.175])
 by mails.dpdk.org (Postfix) with ESMTP id 94BDE402A2
 for <dev@dpdk.org>; Fri, 13 Mar 2026 19:22:43 +0100 (CET)
Received: by mail-qt1-f175.google.com with SMTP id
 d75a77b69052e-50905b779dfso28458521cf.3
 for <dev@dpdk.org>; Fri, 13 Mar 2026 11:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1773426163; x=1774030963; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wfLTmxbX1C9zuDEpkLB8zviOTISUMgh3TpOq/9xU8XM=;
 b=iM+I0beAQAQIKrFNsuip3zTOO+1Q4HVOjrOakXJj4m5PMAtjrS5kKTpXpOjGPka0FQ
 OmCb7CPv4RMk9j0CIF3CeD71Z6Oi7aK7/yWpysXH+t9rlERBHGUzkmd5sfwZl9H+fQbL
 c5HBOruxfG3mlrKVCPMwFobNabOEABtTYKKFo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773426163; x=1774030963;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wfLTmxbX1C9zuDEpkLB8zviOTISUMgh3TpOq/9xU8XM=;
 b=GP7KhA2oz2XGYtgDcXBdCpcd0WZpjWFlRTpkYRwwEMDf2vHQ5nFqhXUrkX1hiVLFSL
 FTqrhAj6eQO8Nr6wFHttoIslVlpotEh2nWvFaXfJtQnUMrFXcQEvtu0tWsBqAaQMqIsu
 6XKp6Q6PrepXWekuV4J7dSDr7X1C85tVgqpCFiqQMujJvTIcTIOq6nZJBjuTGzNGqHR+
 8uIE+v+pbwprolF4xyzTWS9W241NXxlTF3Q+4okOJhw7qGdcO29CEHQ72l3g1W6DUhiy
 y6CrcdH/fnv4M0KSen/oRNfa43jSgXW69dKZFBfayNF7VNizlPpA6+zZdsmhpy9HZjBP
 jHyQ==
X-Gm-Message-State: AOJu0YzaImHhJ2w5/98xglskXH+qdbpDWqdKaKqBYsHWYaT+LPc2PtPc
 qN766X1CocMuJsEr6VQ9HgF3+7Bic07pWLQLAkicQrRxj4ZRKp/bfYBq1ZuxIZOAXYo=
X-Gm-Gg: ATEYQzxsnhQvX+QQLdH9T34nnjXx7zF917sB4MgayGDTK1uwsXkm9EyHZRsZw5IhBE8
 T3iGZ18be/cgGZyPE7TQ5tlzYPXv668Z7qvx5a+Iwpxq+hl5gJ66UAD2WMx/FAhGFlCdL1wBaVo
 E1Tiz657at09U4HP6YJpglzFmtw9zPn1m949Q0PvJgJXpkfESD5watyzhyh8Aip0F5Q7IyIS9t+
 t1AYANOgrFybZVTHbYXNKUI/Ge5Y4mHXEvwW3EQl77hiAkERzmKXhOuJJSb1psdhtIywATjE1SF
 gnuonh7jpG8vDHiQDbPTWb9ae7VtbsRmmU3AUJn93iDDifqAZtLgZ/RTAREwKRa4LdQU7u0FNO9
 yLOkb38UBHOY7DSrv+QolVo1FnuLGD9UAYPOS3k02JiyxZUGGhaSAI4Tmx/b3SKcWoqTzLgm4CY
 i/SpNRZ8NkZWH/VSpR2Xhls0ZQbU1PmxB6MoiT0CArvZhWpY1B5NIsgmP3R2c24g==
X-Received: by 2002:ac8:5814:0:b0:4ee:1b0e:861a with SMTP id
 d75a77b69052e-50957b78e16mr55463881cf.13.1773426162768; 
 Fri, 13 Mar 2026 11:22:42 -0700 (PDT)
Received: from fedora.iol.unh.edu ([2606:4100:3880:1271:ac5d:4186:4dc6:47eb])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-50939e8e0ecsm60162881cf.5.2026.03.13.11.22.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2026 11:22:42 -0700 (PDT)
From: Dean Marx <dmarx@iol.unh.edu>
To: probb@iol.unh.edu, luca.vizzarro@arm.com, yoan.picchi@foss.arm.com,
 Honnappa.Nagarahalli@arm.com, paul.szczepanek@arm.com
Cc: dev@dpdk.org, Dean Marx <dmarx@iol.unh.edu>,
 Andrew Bailey <abailey@iol.unh.edu>
Subject: [PATCH v2] dts: update overall result pass/skip logic
Date: Fri, 13 Mar 2026 14:22:40 -0400
Message-ID: <20260313182240.130379-1-dmarx@iol.unh.edu>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260313155601.112819-1-dmarx@iol.unh.edu>
References: <20260313155601.112819-1-dmarx@iol.unh.edu>
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

Update overall result of test suites such that
when some cases skip and at least one passes,
the result is a pass instead of a skip. Only
when all cases skip is the result a skip.

Bugzilla ID: 1899

Signed-off-by: Dean Marx <dmarx@iol.unh.edu>
Tested-by: Andrew Bailey <abailey@iol.unh.edu>
Reviewed-by: Andrew Bailey <abailey@iol.unh.edu>
---
 dts/framework/test_result.py | 29 +++++++++++++++++------------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/dts/framework/test_result.py b/dts/framework/test_result.py
index c6bddc55a9..e05663f90e 100644
--- a/dts/framework/test_result.py
+++ b/dts/framework/test_result.py
@@ -187,18 +187,23 @@ def serialize_model(self) -> dict[str, Any]:
 
     def get_overall_result(self) -> ResultLeaf:
         """The overall result of the underlying results."""
-
-        def extract_result(value: ResultNode | ResultLeaf) -> ResultLeaf:
-            match value:
-                case ResultNode():
-                    return value.get_overall_result()
-                case ResultLeaf():
-                    return value
-
-        return max(
-            (extract_result(child) for child in self.children),
-            default=ResultLeaf(result=Result.PASS),
-        )
+        results = [
+            child.get_overall_result() if isinstance(child, ResultNode) else child
+            for child in self.children
+        ]
+        max_result = max(results, default=ResultLeaf(result=Result.PASS))
+
+        if max_result.result != Result.SKIP:
+            return max_result
+
+        if any(
+            r.result == Result.PASS
+            for child, r in zip(self.children, results)
+            if not (isinstance(child, ResultNode) and child.label in self.__ignore_steps)
+        ):
+            return ResultLeaf(result=Result.PASS)
+
+        return max_result
 
     def make_summary(self) -> Counter[Result]:
         """Make the summary of the underlying results while ignoring special nodes."""
-- 
2.52.0

