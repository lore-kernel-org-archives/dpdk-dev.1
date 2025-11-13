Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EEB6CD98F7
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Nov 2025 23:31:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3940F4025A;
	Fri, 14 Nov 2025 00:31:17 +0100 (CET)
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com
 [209.85.222.175])
 by mails.dpdk.org (Postfix) with ESMTP id BEB1B40151
 for <dev@dpdk.org>; Fri, 14 Nov 2025 00:31:15 +0100 (CET)
Received: by mail-qk1-f175.google.com with SMTP id
 af79cd13be357-8b272a4ca78so195585985a.1
 for <dev@dpdk.org>; Thu, 13 Nov 2025 15:31:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1763076675; x=1763681475; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=+TDI6v5DNZXfhDYdwg8yAcnUgaxcikC0W8DrwItJpJk=;
 b=SiUgQHGqtMvTToJnvvUsXFiPfLGLZ7y8C+GJqfgagcYUQAd+yzvsAN6Et4kihibjAn
 Lth2iExM9T/ab40uAwoYtsvuFwJlriAmA0Xs3ihs5ipInr6ZFt5BSa92201tARTTFYCG
 pvwhxIXAYSgwQdy6FdW1jnC4qtEdEjBsaXN2o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763076675; x=1763681475;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+TDI6v5DNZXfhDYdwg8yAcnUgaxcikC0W8DrwItJpJk=;
 b=H3DTljZ+kpEnQhXjS1y4+nZ+9tznX9O5DzfnEKpOsDJGvo1PbevCCGVuubpbgx5NaI
 2VENo0hzZ7m1dRp5+6uaqx/YlP38putHNTstbr9z0g0gLx5564eQoakZYMth5bOGFRpg
 2rodVF0AK49RK/Sa+15ew5JWVGJhzrladnL3O0ikQCSMw68vCaYW2DaRZI7x7JNKoLFP
 orEgEpXRLqq2UOFUanAgZhVFE4hZzG/IeekwF8BSKXn1fsrz96H9kOvTcIIocDMwYfSo
 mDbMHk/jkqdCiwx1yhOCUUB/ATs37RUTWgM4zWh+BQpN89AM19qzSvOWYK0HcuwwElqh
 34gA==
X-Gm-Message-State: AOJu0YwYYCMa7EFttivOuwOKPztWFku2wjANMHPJYWCs23Ev3hTRUIIq
 ISPHiS/QdCXD5apDPLz5XCi638PQ5l7wjwXGCSE26E4Lu0n41uTmnqlRiJMYeFiH4AlSY1EdY0t
 NoNfYRiU=
X-Gm-Gg: ASbGncsIvLknx9vvW/flvixsZdn/6VMdvSowJuiMEIzA6kxhBLcNEKl3jwDbRr0S1vI
 s5bmyEZIezYEcSJit7oEjZjpySabiAZa66PYLOHWS69aZk8D01sqsIE5TCkT4kho270asLmluey
 vjJW7HUpqlHFlqg/jGZkDutFkuShReQkYj8tt5wa2IPlVRv28F9eH0kwGhcDY7i2l0RTTEGTlaC
 dgBukpUUvEw1gEoglsPo1GxythayPSN0y0rwgHLRrHBsF3YegdT/hwtPgQCeeXR6Az+SnBvACEW
 L/XE8tsaA1V3FH42g+SzfrSZNpWo7fbhu9kZqhHwSR8UzbDXSC4z3bfRcCp/VDB7VXzQnD3yybP
 P/Td1MLQ2gqCVlTc8s068eHYxYAXEVQFBfs+L1QtpT/l4KuEGNFgRRzThE5B7tnxreYfH6Ey1Aa
 KFGvbSuYWzSll68585GNQ=
X-Google-Smtp-Source: AGHT+IH/4qKDro273K+r/+z77KNs+kv+0ZEeGlFY6Vhfqbaekk6Zh+jAAz0B4TWJF8fFcgNz46nAqQ==
X-Received: by 2002:a05:620a:3948:b0:8ab:58d3:6030 with SMTP id
 af79cd13be357-8b2c31af060mr162980785a.57.1763076674999; 
 Thu, 13 Nov 2025 15:31:14 -0800 (PST)
Received: from patrick-laptop.iol.unh.edu
 ([2606:4100:3880:1271:8c70:5b9e:ecd3:14e])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8b2af064724sm221837285a.54.2025.11.13.15.31.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Nov 2025 15:31:14 -0800 (PST)
From: Patrick Robb <probb@iol.unh.edu>
To: luca.vizzarro@arm.com
Cc: dev@dpdk.org, thomas@monjalon.net, david.marchand@redhat.com,
 Patrick Robb <probb@iol.unh.edu>
Subject: [PATCH 0/2] Small formatting issue fixes in DTS
Date: Thu, 13 Nov 2025 18:29:52 -0500
Message-ID: <20251113232954.273454-1-probb@iol.unh.edu>
X-Mailer: git-send-email 2.49.0
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

There are a few formatting issues in DTS which are being
reported by the devtools dts-check-format script. The 2
commits in this series should resolve these issues.

Patrick Robb (2):
  dts: fix incorrect import order for RSS testsuite
  dts: shorten a too long line

 dts/api/testpmd/__init__.py    | 2 +-
 dts/tests/TestSuite_pmd_rss.py | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
2.49.0

