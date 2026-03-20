Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BA711099B33
	for <dpdk-dev@archiver.kernel.org>; Fri, 20 Mar 2026 18:21:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 381F3402BB;
	Fri, 20 Mar 2026 19:21:31 +0100 (CET)
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com
 [209.85.222.179])
 by mails.dpdk.org (Postfix) with ESMTP id A435B402B2
 for <dev@dpdk.org>; Fri, 20 Mar 2026 19:21:29 +0100 (CET)
Received: by mail-qk1-f179.google.com with SMTP id
 af79cd13be357-8cd8dbf4f2eso239713785a.2
 for <dev@dpdk.org>; Fri, 20 Mar 2026 11:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1774030889; x=1774635689; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E+9Ppxl9rFrQeUpZasrdrQ/rpFoV4WqmpTmP1F+s68U=;
 b=RIUvy6dvV06GWXhtrwmDXwl1wt15+k05o0axGnwXjYR3evPuNhDMGtOXNwOn+yxYul
 ESclkcNgITy+V1J/wEYqlGHkNpZBbhLuDSRGrVoqcK5YpxfvOrAdMl1BMCxpmix5nuax
 dXehlQoE3ymvveniVKrHZcqZ7s1phU5LFgWE8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774030889; x=1774635689;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=E+9Ppxl9rFrQeUpZasrdrQ/rpFoV4WqmpTmP1F+s68U=;
 b=C4GW1ZGNrXYryRrDuWKYcIeOqpf5JQllwm0OXLQrwHuGct9Qd822+UN0L2LbX5cnAM
 Vfkm+BuPwdeaz6adMfVLRYrTnhsdEtN5fp4c8CK1WEFDs/Pc15In7rpj4j8huJxg4OPu
 nUGQbS14X1dvBQ2CJRur+6aAYExsAEzWx6ScJbgzWx8O9ZF94//JiudSb86YFY2si88q
 CeQnbrqbFYZHsfa7GjIoMdIZwoifBYyFv0+rS1t0WEQg/DgHL9fcUvAin4YorNGFwOQv
 DEV//GB+iG7cr03GWcMMzGlkORpggGPid5x2zUFytfgORmJzKNV068JNME5pXPw8LPsd
 idyQ==
X-Gm-Message-State: AOJu0YxdANoAMAgeqlFb4lB2JoNkCxa/lU9cS1T9ck+DA5codviu7qIP
 QK6iT9pkmGnNSoWJH2PjvBlfS5eYNiBzv2WPBvWCUGxsDXvJjK+jxTFDiR0eo4L7cxs=
X-Gm-Gg: ATEYQzxi/e/HmI5iOwmp0Iy6goaT0UpHkhIGbrRoRU+L0sAOoSpZkzcuxbG4N6nCwDf
 ffmUVLKmAcn5El/YPAxLIJYw/3BWbHC7I+5alL4Phm5XoPJp0IuAR4VHzsLp4zNBBHziZeZi1Hp
 oa5be+RDFOs8jY5XjhizoCbIzqcrOPnyVoUh+7wLVKhcXmgrqv+e40eiA5An7Q6bUHqvHxqqhXW
 mBpsiojomuSdTNfjDa4ugAeSlOME1DZnsw+2LxY0ldp/pm8qoY8MHMXD1g4RD1/ojcTkcC3V0VB
 yAzSLfnEQS/fOj/7KBkNiSLMZrgAGWq2l1+orOv3s0fXGyQFDAp3dtrO2JDFzA1id+hvi6QFW0B
 x62izM18laSf0HFJwAuxOEOndLxelY6O5IOcsWRj9PGBHFIK5oUMnIPD0wksPQx9kW6U/5bxLod
 7SajUFhjInJ0JutKjeZf3GP8X4vu67NDsuJIuHUVdP/F7PT2CqSZfjMr0V4dhXVA==
X-Received: by 2002:a05:620a:4887:b0:8cd:b2e9:8190 with SMTP id
 af79cd13be357-8cfc7e929bemr542955485a.18.1774030888911; 
 Fri, 20 Mar 2026 11:21:28 -0700 (PDT)
Received: from fedora.iol.unh.edu ([2606:4100:3880:1271:ac5d:4186:4dc6:47eb])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cfc8fa74c1sm212095385a.18.2026.03.20.11.21.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Mar 2026 11:21:28 -0700 (PDT)
From: Dean Marx <dmarx@iol.unh.edu>
To: probb@iol.unh.edu, luca.vizzarro@arm.com, yoan.picchi@foss.arm.com,
 Honnappa.Nagarahalli@arm.com, paul.szczepanek@arm.com
Cc: dev@dpdk.org, Dean Marx <dmarx@iol.unh.edu>,
 Andrew Bailey <abailey@iol.unh.edu>
Subject: [PATCH v4] dts: update overall result pass/skip logic
Date: Fri, 20 Mar 2026 14:21:26 -0400
Message-ID: <20260320182126.35724-1-dmarx@iol.unh.edu>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260320154641.21334-1-dmarx@iol.unh.edu>
References: <20260320154641.21334-1-dmarx@iol.unh.edu>
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
 dts/framework/test_result.py | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/dts/framework/test_result.py b/dts/framework/test_result.py
index c6bddc55a9..21faa55dc1 100644
--- a/dts/framework/test_result.py
+++ b/dts/framework/test_result.py
@@ -45,11 +45,11 @@
 class Result(IntEnum):
     """The possible states that a setup, a teardown or a test case may end up in."""
 
-    #:
-    PASS = auto()
     #:
     SKIP = auto()
     #:
+    PASS = auto()
+    #:
     BLOCK = auto()
     #:
     FAIL = auto()
@@ -195,8 +195,15 @@ def extract_result(value: ResultNode | ResultLeaf) -> ResultLeaf:
                 case ResultLeaf():
                     return value
 
+        # Filter out setup/teardown steps
+        results = [
+            extract_result(child)
+            for child in self.children
+            if not (isinstance(child, ResultNode) and child.label in self.__ignore_steps)
+        ]
+
         return max(
-            (extract_result(child) for child in self.children),
+            results,
             default=ResultLeaf(result=Result.PASS),
         )
 
-- 
2.52.0

