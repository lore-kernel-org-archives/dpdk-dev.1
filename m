Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE9F6C36002
	for <dpdk-dev@archiver.kernel.org>; Wed,  9 Apr 2025 22:42:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7D712402AF;
	Thu, 10 Apr 2025 00:42:30 +0200 (CEST)
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com
 [209.85.222.171])
 by mails.dpdk.org (Postfix) with ESMTP id 36EBC40288
 for <dev@dpdk.org>; Thu, 10 Apr 2025 00:42:27 +0200 (CEST)
Received: by mail-qk1-f171.google.com with SMTP id
 af79cd13be357-7c5b8d13f73so25459885a.0
 for <dev@dpdk.org>; Wed, 09 Apr 2025 15:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1744238547; x=1744843347; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MEV5Zxa/XGdNZQ37N4kp31p5uHMgHcvuqW9d6pjD+5g=;
 b=fkCs+OqySWyuHcaNZE6Xk1GEivqEcFmXpruZlvq3LmePn/9/XDLe5jqeM5vmsoxBXI
 ShgZwLCyEZhVwh+vN2k+pJyeYu7WExZh9QJKJpkmmnEiZAk12tmoKO4ik8lKFxAvcQeR
 52VT3xabET+Nxb0moNpLlWRWgXcFtogrN8hsI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744238547; x=1744843347;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MEV5Zxa/XGdNZQ37N4kp31p5uHMgHcvuqW9d6pjD+5g=;
 b=Jf7QR0F/CeAuAN5YCS22qi+HQnjsPE6w072fJ+cV7z+fbfP8cx2CFc0p4VsWtaWvCR
 6jFnnuhgb9jdpiDh+LlXOlyrYqfmZFpQVo1qtq1AenaiPvU3yqgNtcg5dgv8JN2ERi4Q
 r8Nibllo5IwNAS/yWkjZge9au+RI3ZB2MW+WFYCEpJKG6hieKr4UUYwq2fncyut2edZC
 5xHRGVHFdy9M4LufjQHWnlplUXypPW9PzqULQh3ohJFnC/YNqmkSLkgV9rUe4yAzHEhZ
 wNTcvU9zPU8X7yaBtjLfVpo0GUT/OGwieHS5ix3R93xUXolGfx0Rcs7AhSEsI8R9FUII
 ryLQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUBfCHEFwM4jbr5DRYjcVLx8DdKPO7viGaBgypTgE6Uf2mqkU9GEwiKsMfyn0udURiWRsw=@dpdk.org
X-Gm-Message-State: AOJu0Yyk6ouaNAWpWKpWzZejTCrd+Uz+vzGkkGtp/TUsycJ9ENTZAuwH
 fjRCPAS8l1gI0CeJ4qQN+9pEncpU9dTf6gRIKGUv5N11H9ESUHZYeDkGf++bx1Y=
X-Gm-Gg: ASbGncuvUS8Ml6ReJRp8g1r+iWyr1xfL59SJ44rnLz8k+Sohs9Mpo66NuQMQakJH4eA
 7joV7VHQRi7/D+TH9MvaEeqi5VnON0c7Jl6qs4oaKLDcQPcNi2ePMVoYmU/eW3WdMj5bd3yFC88
 InsBT+ydYGLVkGsQgwC3GQqjClF9bCk1LFNv2N4IvXwfLds+G4qOFBH0bMXSwMNW+Esi8u+rLzX
 iRwxDFppz2GLkzoKmoECuenJcEpUsIEdvNmoz3PNwRvFthsP8mNbw17Ib44dP7fwljUVgRGPdO4
 wy9V8oLJ9fOVc+aUXkWVMOetgK51ftxYgpqd+nhg0IBaAh0mD7YAVyHWdpIrWtTxXJbWuwUHG58
 RzOOaVgQlFFVDmw==
X-Google-Smtp-Source: AGHT+IHyWm/Fsc+r8zJColhGrwq8POx7vCvn4Py2HhJym4lL0izWYuVa9RASpMDMBI3b3HA92IVrhw==
X-Received: by 2002:a05:620a:6185:b0:7c5:4d2e:4d26 with SMTP id
 af79cd13be357-7c7a81c07c3mr20477485a.51.1744238547246; 
 Wed, 09 Apr 2025 15:42:27 -0700 (PDT)
Received: from patrick-laptop.iol.unh.edu
 ([2606:4100:3880:1271:8c70:5b9e:ecd3:14e])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c7a11ca015sm125949985a.82.2025.04.09.15.42.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Apr 2025 15:42:26 -0700 (PDT)
From: Patrick Robb <probb@iol.unh.edu>
To: Paul.Szczepanek@arm.com
Cc: probb@iol.unh.edu, Luca.Vizzarro@arm.com, dev@dpdk.org, dmarx@iol.unh.edu,
 npratte@iol.unh.edu
Subject: [PATCH 0/4] dts: smoke test bugfixes 
Date: Wed,  9 Apr 2025 18:38:21 -0400
Message-ID: <20250409223825.1579256-1-probb@iol.unh.edu>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250403023059.1762841-1-probb@iol.unh.edu>
References: <20250403023059.1762841-1-probb@iol.unh.edu>
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

There are two smoke test bugfixes which have come in from our 25.03 DTS
development and which should be resolved with this series.

1. The patchseries which we merged for 25.03 which added the testsuite
specific configs inadvertently broke enabling smoke tests, as we build
the tests config model using the test suite list coming in from the
parsed test_run.yaml, before smoke_tests have been added. Then, later in
the execution this produces a key error. I think that adding a
placeholder smoke tests test suite config is the most reasonable
solution to this. Users are unlikely to specify any test config for
smoke tests as they don't require any, although if they happen to do so,
I understand this change to be non-breaking (and I gave it a test run).

2. I am also seeing the smoke test which relies on regex on
dpdk-devbind.py status output is failing on at least one of our systems
currently. The fact that this broke is rather peculiar since regex
syntax is obviously stable, and my reading of the current regex is that
it "should" work. In any case, I simply changed the regex to a pattern
which is more permissive and still captures the driver in use, which is
what is needed for the testsuite.

changes in v2:

The v2 patchseries adds an extension to the smoke test meson fast tests
timeout in order to accommodate for slower test times on older systems.

The v2 also disables smoke tests in the example testrun config file,
based on discussion at the previous DTS meeting. In some cases
there are esoteric reasons why some meson tests may fail, and they will
also extend the test run execution time. For these reasons we think that
smoke tests should be opt in by default instead of opt out by default.

Patrick Robb (4):
  dts: include smoke tests in tests config
  dts: update dpdk-devbind script regex
  dts: default smoke tests to off
  dts: extend meson fast tests timeout

 dts/framework/config/test_run.py   | 7 +++++--
 dts/test_run.example.yaml          | 2 +-
 dts/tests/TestSuite_smoke_tests.py | 4 ++--
 3 files changed, 8 insertions(+), 5 deletions(-)

-- 
2.48.1

