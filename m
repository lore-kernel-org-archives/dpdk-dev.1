Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D139EC87FCF
	for <dpdk-dev@archiver.kernel.org>; Thu,  7 Aug 2025 14:07:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5D9864064A;
	Thu,  7 Aug 2025 16:07:36 +0200 (CEST)
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com
 [209.85.160.175])
 by mails.dpdk.org (Postfix) with ESMTP id 60CD6402B3
 for <dev@dpdk.org>; Thu,  7 Aug 2025 16:07:35 +0200 (CEST)
Received: by mail-qt1-f175.google.com with SMTP id
 d75a77b69052e-4b0619a353dso7448731cf.3
 for <dev@dpdk.org>; Thu, 07 Aug 2025 07:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1754575655; x=1755180455; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k/9/y6Us0KkkGsjQsJmXxkc9fx1mzvvHUgpJZmDvxko=;
 b=etsNlflgI3o5fo/eJPo1bltWBfJaURwd6Q7vlxTndqg3RourYLRwXPsDd0tKEYDkbp
 HbH7xZb4vuHYog8KZHOBA0Ujs34vtqrwZRJSZKbq4mEZ2+5mFdakJP9LSTCDMxlEaerR
 mCgCS0nIW7L2XgLNk9jQysv8+qAyDK9444xy8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754575655; x=1755180455;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=k/9/y6Us0KkkGsjQsJmXxkc9fx1mzvvHUgpJZmDvxko=;
 b=EiUVB8WBmUp10lqFBeIZYfwU3J+mBwqEn8jW54Qx7LMed7IsDJ3EcEKy1dOK2Wr34y
 mvOtN5FG5LIGg515IVlEzDeltbxLeOYA7DYLXb0CP38dyTQy/1zwrrWOFoWyo7ISn8r/
 5M/eS9vLx5EWvxSdAp6fSbAMOYiHdJZ77ON9D07tjzOqNsUKXz0C/b34jX5LvMzE3vzw
 wR2oA0UWdvy/HAyN+UfYDkOafqit1Tqhqiz3/krdtRvzf38+QjvJ3xqCV3RwZt5bt/Lc
 XyCphhmkx8sW+cdsoaOd5+2iwuW4KXxGQuOcTpnYa7kchaA9aWA1kbCujG1AitXG1Btu
 BStw==
X-Gm-Message-State: AOJu0YzWQNo6q05mIbLoPgFHN3r7xWLPPEajkLBVbg+IRyBS2S7bQfW7
 kgTrRA9ovhyxqeQoF/hcUp/894EOS7z2fV0hYAt+eNzvDXkJwBnWzbmNjDmyVh/iXUQ=
X-Gm-Gg: ASbGnct2rYN9A6yj29GF2eXCuBw9+BygqS4TXv2Rmt3+g/USbN0QkJ3qIkyPBK2X+k9
 BNI+st3/VT7NRJIu5imSbCDLbfxH00/mG7kdbM7mVXX3dwfAH0uv5UikV1BTdVUYnQN1US6941M
 Mmx/Ff2c1j3wDb2n7LG3T6JqmbsLjzBGDWho3DPZUjTvn4TQ0tUpnyuJIL1mv8b/N4oB3zg82CS
 hqBogwdbEs8Er0Ipx+FgJkNRTRT9PnxuQDtDP0wcijp53llzDrW7awVVB3OezMHbiNo7+SR/CsN
 I+l0+lp/a5f+EBrG39E+zgidn6tZjMW96pUErPP3fcK6I7ZGLJ8U8ZXBwij5eJDHX0NnC+3GnWb
 jSuXeDlDSUp9WOC2MuFnFZB4fsrMDUaQb
X-Google-Smtp-Source: AGHT+IGxZwfrW2px2PBIe1KGG2zXjuv8GkK6V+EA+z6MtYGwywsNhHFzAhmwuhrqSjRBYDUtLiVzsg==
X-Received: by 2002:a05:622a:201:b0:4b0:7ad6:ea9c with SMTP id
 d75a77b69052e-4b09268fb99mr87742341cf.31.1754575654341; 
 Thu, 07 Aug 2025 07:07:34 -0700 (PDT)
Received: from fedora.iol.unh.edu ([2606:4100:3880:1271:ac5d:4186:4dc6:47eb])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4b06ac5bd99sm50835031cf.21.2025.08.07.07.07.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Aug 2025 07:07:33 -0700 (PDT)
From: Dean Marx <dmarx@iol.unh.edu>
To: probb@iol.unh.edu, luca.vizzarro@arm.com, yoan.picchi@foss.arm.com,
 Honnappa.Nagarahalli@arm.com, paul.szczepanek@arm.com
Cc: dev@dpdk.org,
	Dean Marx <dmarx@iol.unh.edu>
Subject: [PATCH v2 2/2] dts: make one link the default topology
Date: Thu,  7 Aug 2025 10:07:30 -0400
Message-ID: <20250807140730.292639-2-dmarx@iol.unh.edu>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250807140730.292639-1-dmarx@iol.unh.edu>
References: <20250723135021.218084-1-dmarx@iol.unh.edu>
 <20250807140730.292639-1-dmarx@iol.unh.edu>
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

Currently the default topology for test suites when not specified
is two link, which causes all one link test runs to skip.
This makes writing test suites less flexible for a user
who doesn't add a topology requirement, so changing this
to one link reduces barriers to getting a test suite
running quickly.

Bugzilla ID: 1759

Signed-off-by: Dean Marx <dmarx@iol.unh.edu>
---
 dts/framework/testbed_model/topology.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/dts/framework/testbed_model/topology.py b/dts/framework/testbed_model/topology.py
index 899ea0ad3a..9f21520bbb 100644
--- a/dts/framework/testbed_model/topology.py
+++ b/dts/framework/testbed_model/topology.py
@@ -35,7 +35,7 @@ class TopologyType(int, Enum):
     @classmethod
     def default(cls) -> "TopologyType":
         """The default topology required by test cases if not specified otherwise."""
-        return cls.two_links
+        return cls.one_link
 
 
 class PortLink(NamedTuple):
-- 
2.50.1

