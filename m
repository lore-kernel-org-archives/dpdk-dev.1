Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DBADC83F1A
	for <dpdk-dev@archiver.kernel.org>; Wed, 23 Jul 2025 13:50:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 407BE406A2;
	Wed, 23 Jul 2025 15:50:27 +0200 (CEST)
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com
 [209.85.222.171])
 by mails.dpdk.org (Postfix) with ESMTP id 9BE264067C
 for <dev@dpdk.org>; Wed, 23 Jul 2025 15:50:25 +0200 (CEST)
Received: by mail-qk1-f171.google.com with SMTP id
 af79cd13be357-7e372c8a9a4so269265485a.2
 for <dev@dpdk.org>; Wed, 23 Jul 2025 06:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1753278625; x=1753883425; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=k/9/y6Us0KkkGsjQsJmXxkc9fx1mzvvHUgpJZmDvxko=;
 b=jRQOIra7G3pR+EQtearwRGOxv2IjAbNqrpSNlEWKME7y4uUxaBAHLF6aC6zg0GyssQ
 XJUf4UP1xLyAWEIuHbRFJIFW1kB6UHtZR3NWU4LIaGI+G1uWEVh3EiaIF/C/0NH16gWV
 M6CyP2wtlCSlm0vL80waPmWMd5XX3w4lTZlv8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753278625; x=1753883425;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=k/9/y6Us0KkkGsjQsJmXxkc9fx1mzvvHUgpJZmDvxko=;
 b=c59vNodx27Xp+/uOtDBq+Hvy2G8x6Wo1qg5pbN6mCsCFo6iNeaDgtrcEiM4bztCJCu
 7U9h0Z99DJJmGjwdORkBex3DItyMnQIE/0FnLibiAojpMyefodi82kpdZ2sSRpGZZQIn
 KxayfqZJluTyeTKKUEDAO0FVezNRCQKBDxSsbHAH7HsAQsRb6QOGeKXvztHrtM58fa35
 jHU0pvT8T6TNBOlzJWrFWiKfkDlAfkv/tqV0vLuZKAPG8eE0x0A1xpcu8xubWReq3F5y
 MMLW0d+uYtcDq4BEaihB0X7QBXgnaT3HQCmUue494zikoo5WA9Doxt58FrzCsDqkRwHE
 F8Cw==
X-Gm-Message-State: AOJu0YwSbC5eX+QWYtVBuZEmJZhx+rXH8id2ZOvoKEvni8VeHa7LV23i
 HvkfVUIqOqwUslycfKSlBgUT4rGB20Cenv24ez1y/aBbugYgJSnySgyMpJIm46dcsWk=
X-Gm-Gg: ASbGncvlnnnJQWG5cygOjouVW5lDijwh8+Z44YmKDlhQzgwt6qy115L+3bjTfQhL+Ae
 sq3zVZkiWSmfWW6mrK0fI9f2a5p+Ha/Af1w56jDc68i+5Yunwniv0QHLJU2LG2/fiAvpvCYzlHE
 fbtGqEmUVoUUb/z+qUtM6iIMYi40VbAszAamLSnvYgptp46jnQ1oaEhTMMLDo4hRo0yDdxJNsK6
 jhncHOds3h0Vnw2m2XKpFlYmomOGpjaMqMNqTxyQSVQaLBJRi3VMVSCyVfxWchAa/9eeUCaDh1y
 FYjH8Azl539oseqWyIekGi4ww0oLVXi78SbBKYRXP0FGkJmS5+dHwW4NkYB6Xovj8vv2Nb7HVoa
 8nVN/u8ysN7SezHKUV6Bmi6ElDs3pSuBsXWbiBdyqnzWGeJN90dUA
X-Google-Smtp-Source: AGHT+IECK30c23q06OPIaK6qrqSAYX2C9ut/qYgncbvPcVXti8sr9NhnnHv1or91UBzCXgn2eNTMsw==
X-Received: by 2002:a05:620a:ac0e:b0:7e3:46ad:65ed with SMTP id
 af79cd13be357-7e62a1d9272mr401689485a.37.1753278624665; 
 Wed, 23 Jul 2025 06:50:24 -0700 (PDT)
Received: from fedora.iol.unh.edu ([132.177.125.204])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7e356c9155csm643433285a.95.2025.07.23.06.50.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Jul 2025 06:50:24 -0700 (PDT)
From: Dean Marx <dmarx@iol.unh.edu>
To: probb@iol.unh.edu, luca.vizzarro@arm.com, yoan.picchi@foss.arm.com,
 Honnappa.Nagarahalli@arm.com, paul.szczepanek@arm.com
Cc: dev@dpdk.org,
	Dean Marx <dmarx@iol.unh.edu>
Subject: [PATCH v1] dts: make one link the default topology
Date: Wed, 23 Jul 2025 09:50:21 -0400
Message-ID: <20250723135021.218084-1-dmarx@iol.unh.edu>
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

