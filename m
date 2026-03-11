Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CB08112584E
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Mar 2026 16:06:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EE0894060A;
	Wed, 11 Mar 2026 17:06:05 +0100 (CET)
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com
 [209.85.219.54]) by mails.dpdk.org (Postfix) with ESMTP id 523E1402E7
 for <dev@dpdk.org>; Wed, 11 Mar 2026 17:06:04 +0100 (CET)
Received: by mail-qv1-f54.google.com with SMTP id
 6a1803df08f44-89a14be4733so23386d6.2
 for <dev@dpdk.org>; Wed, 11 Mar 2026 09:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1773245163; x=1773849963; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fc/VrvnImOfgN59VF4Zgzw9usuqptH+Z0oysmd2KHU0=;
 b=f8xBF1Stymp4/JXNG4hYjkS+CQR3N1EBmKYKxQFl/d+7Uv+TtOoGHNfmsLjoFvNI+H
 ONr1s1Z7RB9N40Dl2Q6pnMYXEPqcBtBJh7EzzluKdUMjfr6EdBtjSNTVkHOn3e1mR17k
 TUOFBnGhHKeNE/Lq36gnBj/ANDPLBXwwKq+xg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773245163; x=1773849963;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fc/VrvnImOfgN59VF4Zgzw9usuqptH+Z0oysmd2KHU0=;
 b=B6DAyVuG1uyP8rDTBn4sDcFC371Th9LnvzxbbY0EHX27HHC2gjJ1SF11iLS6a5F/Ue
 BrKwc+N4BbT/QktNcR/D7WB8QN6MWB1jGHoh7LJ2rEe0E+dIC9kXUIP7LE2ylC7I2BHf
 jKO1dMivNze2O8tLQcyBjVHC8rPRD4YTxtbPgD1GqK1VBOoLOg5dLb9GCILafzICaEWV
 GT5xJkO0UklQLmehiP3CZgRdeg+pok/FPCvvntEye9Yz5QywejM8kqo3ucVzFY8pwHRY
 TpcIH4tqygVXswx5j7YppxvWXAJallYkeDdmoHlFyFqHmLYTu9uX9gzHzwhmHRDNJ3Cu
 HuPg==
X-Gm-Message-State: AOJu0YyKNSNcG+mTV/mfuHTTqnsNxm+gNlE4pzxmAHYjE066HmRCrfzr
 4xj8ej7FnoE3db0YfBTTukIpR0xB0/UBPazCuHadOr349DYjc2y7pPU9KCEalZmxEiE=
X-Gm-Gg: ATEYQzyDOsPNzunjEYtcXoB4LvUilocggsRJHxBsEBrJnvHiPbNrkSZJRaCtbLutlzB
 QHLxLq8YzFQzsTFxJpr0AdlA7TRshxiI7xTwAUY8mOMN4bAn9/yI6hKmxydJqbq7Bf2HrqWkF2t
 k6Odw1Xj5XaeYVORqkNl3QFx53B2i1LYMEtBWWQ4P92FS4/ZFIlpMJnIJy9rp4b3jlxsy9QAjQO
 r5oFn+s/UmYkUvN9NkAzzQG1kuItQyUKvaN3TVQPdjqJyBorXwOuRpy6TAeoObA8Vrm2FYqftwG
 gXpFXBfeGMTyCkSPCnLg/+CcqZ3F4rGU3GZ7eBkStzFSoGaXBwRJD345+QrOpqA2XOMssbtIHmn
 HxzN1ALHKEdhVUoenaM5th7AtckGY+xtk5xlQjHEpPmwUcUU8Be0QQYERwJg8zSMrujeZaA6X2z
 QJDG3RrpbOcbQPQ3/vqPt38paBV0tZHcBuLUHlQe/xfLiYVOhMeM5oBpsGGSa/hxum9LaKMnMMv
 OfdPEWZv2okL+Wtln8bI56qNQMIvds=
X-Received: by 2002:a05:6214:2305:b0:899:fcf2:8379 with SMTP id
 6a1803df08f44-89a66b01087mr37744006d6.32.1773245163529; 
 Wed, 11 Mar 2026 09:06:03 -0700 (PDT)
Received: from patrick-laptop.iol.unh.edu
 ([2606:4100:3880:1271:8c70:5b9e:ecd3:14e])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-89a65ce1c9esm16863136d6.27.2026.03.11.09.06.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Mar 2026 09:06:02 -0700 (PDT)
From: Patrick Robb <probb@iol.unh.edu>
To: luca.vizzarro@arm.com
Cc: dev@dpdk.org, dmarx@iol.unh.edu, abailey@iol.unh.edu,
 manjunathgouda.hosamani@intel.com, Paul.Szczepanek@arm.com,
 thomas@monjalon.net, Patrick Robb <probb@iol.unh.edu>
Subject: [PATCH v6 1/2] dts: make one link the default topology
Date: Wed, 11 Mar 2026 12:03:06 -0400
Message-ID: <20260311160307.441948-1-probb@iol.unh.edu>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250820140651.39604-1-dmarx@iol.unh.edu>
References: <20250820140651.39604-1-dmarx@iol.unh.edu>
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

From: Andrew Bailey <abailey@iol.unh.edu>

Currently the default topology for test suites when not specified
is two link. However, the majority of the DPDK functions tested
in DTS can be tested with a single link. It is more intuitive for
a testsuite or testcase lacking a topology decorator to default
to the more basic requirement of 1 link, and force tests which
really do require two link to include decorators explicitly
saying so.

Signed-off-by: Andrew Bailey <abailey@iol.unh.edu>
Signed-off-by: Dean Marx <dmarx@iol.unh.edu>
Reviewed-by: Patrick Robb <probb@iol.unh.edu>
---
 dts/api/capabilities.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/dts/api/capabilities.py b/dts/api/capabilities.py
index 2d0cd65854..09bc538523 100644
--- a/dts/api/capabilities.py
+++ b/dts/api/capabilities.py
@@ -63,7 +63,7 @@ class LinkTopology(IntEnum):
     @classmethod
     def default(cls) -> "LinkTopology":
         """The default topology required by test cases if not specified otherwise."""
-        return cls.TWO_LINKS
+        return cls.ONE_LINK
 
 
 class NicCapability(IntEnum):
-- 
2.49.0

