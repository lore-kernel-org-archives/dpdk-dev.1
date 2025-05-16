Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37887C3ABD8
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 May 2025 20:18:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0EEDE40615;
	Fri, 16 May 2025 22:18:39 +0200 (CEST)
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com
 [209.85.222.177])
 by mails.dpdk.org (Postfix) with ESMTP id A85D340395
 for <dev@dpdk.org>; Fri, 16 May 2025 22:18:38 +0200 (CEST)
Received: by mail-qk1-f177.google.com with SMTP id
 af79cd13be357-7c57f2f5a1bso30638385a.1
 for <dev@dpdk.org>; Fri, 16 May 2025 13:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1747426718; x=1748031518; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GLmAhPbccgUTdLhi9VCJ+yfxlPGz4YB2xebgDh2ST8k=;
 b=CDO76+2wB/aCL05l0KPoQFoBx0+tpi40fNXffx3ji2ZnricOiMnxrgpmYZNsI3UffW
 YniQUDYpjQjYKmokC5wLLh8wxFA+FmvEhf45gPywISfjwvRH62bdZLa/te+PDvSVoHH7
 BxlwoF47cKB+QMrVobNHlHU+8XU4y+FUpGkYY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747426718; x=1748031518;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GLmAhPbccgUTdLhi9VCJ+yfxlPGz4YB2xebgDh2ST8k=;
 b=q/w+Zqjlnefp/DfxNJqp98fg21XNamT1UnyvwGpM7LSOsTH9xRJ16CKMUvxzr9VOcF
 S3+cRCa9qkpBPKpslhnDpoVA9OzAZaLz7lGZbo8Bw+1sBg21JcJf8uXpu438G7sy9a8y
 OK10WYRzJbnttvd2roqOh2WFhmCvLylkLwXsHJRCvYUeumcR/ECANwx4RYeBH6TPF5y+
 R23rziA/LSxN7ANMfh/R6tZHeikd2IE363uVoAK7FTNrJzzO2K3bivjqgKXo0CCu8oUd
 TA2zit+IkBhsA2Dpjt/PeyDQqu8c+fq2PbP+d+9/AfJwU6824wA0wITxxqFQIDYJB7M3
 qBcA==
X-Gm-Message-State: AOJu0YxjT4xjVHbBOE9KhqCZt4bcsjg2yIc3Dj46GKZzpJN/CCoJgVi3
 h16fsXMudMK0vsIg02WYsHZ3XRb1Y+Q4AzGROy74NSFuYjKVYoy+NxaHhfLz8b7YNO4=
X-Gm-Gg: ASbGncvvKmgJOqqDE7pM20XU3DFsQA64pW9w0Bmz1baRezr2xYDJrlOdkZF23D/XDpl
 hJ9ExITVZ2w1GqjXrGnuOndtKVdZJpWICShRFpcW8jeoFsOlKa+GRz1cZS47DqfGE/7zgTcsVpc
 7KPlGY+M2CeLaxHX17sTHxEcBHvxDw1CpPy6qCrfu7xZmX0gE8b11R8owCtHFS6WabgG/gDp0JV
 58mcjZBh7cqazcpEZ5GK72Tw1ix/G7kHR4qXTkKOi03BAZD7h1Xcuxhf/x/6/DYF34pUHJYFJ6F
 DiMBUuv5E6/RrvFbAPy9Rujm08JTvO5uXBz4UCG7QmNa8e2K1NLxMfXHE56PP7Q=
X-Google-Smtp-Source: AGHT+IHXyYRnREQehHG2tGoMH/Sjc8XAQ7O1/OeO3MJGBJAxAOKvNxVSV996JUyXRZA5YU8U5u9Udg==
X-Received: by 2002:a05:620a:269f:b0:7ca:e392:2a1b with SMTP id
 af79cd13be357-7cd467bc781mr278354585a.10.1747426717824; 
 Fri, 16 May 2025 13:18:37 -0700 (PDT)
Received: from localhost.unh.edu ([2606:4100:3880:1271:e2f8:4ec3:8bf3:864c])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7cd467d93d5sm159673685a.31.2025.05.16.13.18.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 May 2025 13:18:37 -0700 (PDT)
From: Nicholas Pratte <npratte@iol.unh.edu>
To: stephen@networkplumber.org, dmarx@iol.unh.edu, luca.vizzarro@arm.com,
 paul.szczepanek@arm.com, yoan.picchi@foss.arm.com,
 Honnappa.Nagarahalli@arm.com, thomas@monjalon.net, thomas.wilks@arm.com,
 probb@iol.unh.edu
Cc: dev@dpdk.org,
	Nicholas Pratte <npratte@iol.unh.edu>
Subject: [RFC v2 0/6] Add TREX Traffic Generator to DTS Framework
Date: Fri, 16 May 2025 16:18:28 -0400
Message-ID: <20250516201834.626206-1-npratte@iol.unh.edu>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250423194011.1447679-1-npratte@iol.unh.edu>
References: <20250423194011.1447679-1-npratte@iol.unh.edu>
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

v2:
  * Still some formatting issues that need clean up.
  * Several issues have been addressed
     - Includes some of Patrick's comments.
     - Personally identified bug fixes.
  * Single core perf test has been fleshed out.

Nicholas Pratte (6):
  dts: rework config module to support perf TGs
  dts: rework traffic generator inheritance structure.
  dts: add asynchronous support to ssh sessions.
  dts: add extended timeout option to interactive shells.
  dts: add trex traffic generator to dts framework
  dts: add performance test functions to test suite api

 dts/{ => configurations}/nodes.example.yaml   |   0
 .../test_run.example.yaml                     |   8 +-
 dts/configurations/tests_config.example.yaml  |   9 +
 .../trex_configs/intel_40g.yaml               |  18 ++
 dts/framework/config/test_run.py              |  20 +-
 dts/framework/context.py                      |  11 +-
 .../remote_session/interactive_shell.py       |   9 +-
 dts/framework/remote_session/ssh_session.py   |  14 +
 dts/framework/settings.py                     |   6 +-
 dts/framework/test_run.py                     |  27 +-
 dts/framework/test_suite.py                   |  33 +-
 .../traffic_generator/__init__.py             |  22 +-
 .../capturing_traffic_generator.py            |  34 ++
 .../performance_traffic_generator.py          |  69 +++++
 .../traffic_generator/traffic_generator.py    |  43 ---
 .../testbed_model/traffic_generator/trex.py   | 292 ++++++++++++++++++
 dts/tests/TestSuite_single_core_perf.py       |  56 ++++
 dts/tests_config.example.yaml                 |   4 -
 18 files changed, 605 insertions(+), 70 deletions(-)
 rename dts/{ => configurations}/nodes.example.yaml (100%)
 rename dts/{ => configurations}/test_run.example.yaml (82%)
 create mode 100644 dts/configurations/tests_config.example.yaml
 create mode 100644 dts/configurations/trex_configs/intel_40g.yaml
 create mode 100644 dts/framework/testbed_model/traffic_generator/performance_traffic_generator.py
 create mode 100644 dts/framework/testbed_model/traffic_generator/trex.py
 create mode 100644 dts/tests/TestSuite_single_core_perf.py
 delete mode 100644 dts/tests_config.example.yaml

-- 
2.47.1

