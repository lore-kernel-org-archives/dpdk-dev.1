Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAB48CCA470
	for <dpdk-dev@archiver.kernel.org>; Wed,  1 Oct 2025 23:17:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 73F0B40277;
	Thu,  2 Oct 2025 01:17:33 +0200 (CEST)
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com
 [209.85.160.169])
 by mails.dpdk.org (Postfix) with ESMTP id 1629540262
 for <dev@dpdk.org>; Thu,  2 Oct 2025 01:17:32 +0200 (CEST)
Received: by mail-qt1-f169.google.com with SMTP id
 d75a77b69052e-4de659d5a06so2402021cf.3
 for <dev@dpdk.org>; Wed, 01 Oct 2025 16:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1759360651; x=1759965451; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HVxwscB+YQrmNbIXpDDDTy+cGZ+fr+ozYClecGLtE4k=;
 b=eYHSieZ53R3pQWOqw7nOlN+xqtl9tcj03bJMzXw7tPZ2Ip0lSpFI4PerGJsk5zwDoL
 7O/b8mpIbuNOEFON35hESO/+qkS18vHnC8aMV/lchY1ar38Gl/xcaXV7uv4JV3faSSTm
 pYDlRTjeqa4LZLOU9zDPljrDmWy1Y7onMqHnI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759360651; x=1759965451;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HVxwscB+YQrmNbIXpDDDTy+cGZ+fr+ozYClecGLtE4k=;
 b=r78J95aKPbKJPcHfkGFwo8j03atckLnUKQKiv1Qu0S/QsrMsH2gO8vd+d1XoBn+o9x
 49NjVNCxbdpkkbPwSzLi7OJTDVCVVFcqDYrupGDacRuHJVDOCTlFHcUzvZKWVnhEeinR
 v9KIsL9eTrP4S9LESzI0URz9tmwkzqdV1xTaOJXX5j2GtPcSdFvCqbJBEDwFilWWzkLM
 rqIzMiXIgEwPsYoMaP2wX2s68SWyB/UQXAWbtkSW/nEYuPJm5bfeNWkGp8qwCKof8tnY
 bmKwdFa/hijMuADb316u4ZbkJQsXJEYgTBmpezK5t6Ugrgg4ZONEbThr/bj/ta4MDa4f
 BvYA==
X-Gm-Message-State: AOJu0YyG1APwHLJ1psvtSuhWVJYq45LggBp7OLsxXHEpVbsQnO/lh33S
 hF6HjVXQkQRf3KKmT9LhJ8HbI6SbxXCu8b41Kb3ixj4PJm3M1JKEP5Ocuj/ZiRHUXYs=
X-Gm-Gg: ASbGncsQe9E09YglNI857bX2G6nNbDpDyd6HLCfQbHzEWTRM6m8rHXbBncQh1UAezbx
 KWYyVb/3Ef7L5jnksvj4wRFuf2aABiHiZ2xSJ3b74fLPtEuK7cXB8BfTnFMPJe+q3xjG0gpg7+k
 4xCLsW2HSh68FGpp/Z8idF2+hp5c0029b0E8VLQKLm8D1vn4jY8imStBr78xSEhtWpZtbT1Ek8f
 jXzNyzBr67dXEnvW4bsEUKB26l5k0p9P3BYn+wD+DFb8cfbfNp4XdMB4EQtdkZZTO8PLuNtz6ES
 PHfPoyYqqP+2yuvmv72Zy0qtbXG2Fnon/pR6cj03zAHdWycjvAsUkvtF33f7Ij9sX5ikCEaLGds
 p9b2SbJcYlnSBcUiBbXPfh7jvPgaeX1nGJL4hpJH5wbRm+6mvSVdvCJEbQBw=
X-Google-Smtp-Source: AGHT+IGw1nIG/e06HPr8m4UYiIUWSAFyh1AkDasinRykt0cNQ0IiGeEUu7ChNpDDfHtIvxf7CxAMWw==
X-Received: by 2002:a05:622a:1249:b0:4da:16c:6ce9 with SMTP id
 d75a77b69052e-4e41c3542a7mr70165751cf.5.1759360651263; 
 Wed, 01 Oct 2025 16:17:31 -0700 (PDT)
Received: from patrick-laptop.iol.unh.edu ([2606:4100:3880:1257::10e7])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8777aabeac7sm95224285a.64.2025.10.01.16.17.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Oct 2025 16:17:30 -0700 (PDT)
From: Patrick Robb <probb@iol.unh.edu>
To: Luca.Vizzarro@arm.com
Cc: dev@dpdk.org, Paul.Szczepanek@arm.com, dmarx@iol.unh.edu,
 abailey@iol.unh.edu, Patrick Robb <probb@iol.unh.edu>
Subject: [PATCH v4 0/3] Add TREX Traffic Generator to DTS Framework
Date: Wed,  1 Oct 2025 19:16:56 -0400
Message-ID: <20251001231659.2297751-1-probb@iol.unh.edu>
X-Mailer: git-send-email 2.49.0
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

This series adds support for performance traffic generators, and
includes an implementation for using the TREX traffic generator for
performance testing. It also includes a new testsuite which measures the
single core forwarding performance of a SUT in millions of packets per
second.

There are some points in this series which may warrant further
discussion. Namely:

- We want to run only the functional traffic generator OR the
  performance traffic generator at a given time. So, this series makes
DTS tear down and bring up traffic generators as needed, depending on
whether a testcase is of type functional or performance. I think this is
a good approach in general, but in order to facilitate this I have
removed the shell pool cleanup at testcase teardown and testsuite
teardown. Now, it only cleans up at testrun teardown. I think it is
possible to add these shell pool cleanups back in and keep the existing
solution, but I would like to discuss it at the next CI or DTS meeting.

- Currently, the testsuite prints out a stats table to the console when
  the single core forwarding testsuite is complete. It may make sense to
start writing these stats to an output file as well.

If you would like to test this series, please also note that you will
have to move your YAML configs to the new configurations directory.

Nicholas Pratte (3):
  dts: rework traffic generator inheritance structure
  dts: add trex traffic generator to dts framework
  dts: add performance test functions to test suite API

 ...sts.TestSuite_single_core_forward_perf.rst |   8 +
 doc/guides/tools/dts.rst                      |  35 ++-
 dts/{ => configurations}/nodes.example.yaml   |   0
 .../test_run.example.yaml                     |   6 +-
 dts/configurations/tests_config.example.yaml  |  17 ++
 dts/framework/config/test_run.py              |  22 +-
 dts/framework/context.py                      |   5 +-
 dts/framework/remote_session/blocking_app.py  |   4 +-
 .../remote_session/interactive_shell.py       |   2 +-
 dts/framework/settings.py                     |  12 +-
 dts/framework/test_run.py                     |  54 +++-
 dts/framework/test_suite.py                   |  32 ++-
 .../traffic_generator/__init__.py             |  13 +-
 .../capturing_traffic_generator.py            |  34 +++
 .../performance_traffic_generator.py          |  64 +++++
 .../testbed_model/traffic_generator/scapy.py  |   1 +
 .../traffic_generator/traffic_generator.py    |  44 +--
 .../testbed_model/traffic_generator/trex.py   | 258 ++++++++++++++++++
 .../TestSuite_single_core_forward_perf.py     | 139 ++++++++++
 dts/tests_config.example.yaml                 |   5 -
 20 files changed, 690 insertions(+), 65 deletions(-)
 create mode 100644 doc/api/dts/tests.TestSuite_single_core_forward_perf.rst
 rename dts/{ => configurations}/nodes.example.yaml (100%)
 rename dts/{ => configurations}/test_run.example.yaml (88%)
 create mode 100644 dts/configurations/tests_config.example.yaml
 create mode 100644 dts/framework/testbed_model/traffic_generator/performance_traffic_generator.py
 create mode 100644 dts/framework/testbed_model/traffic_generator/trex.py
 create mode 100644 dts/tests/TestSuite_single_core_forward_perf.py
 delete mode 100644 dts/tests_config.example.yaml

-- 
2.49.0

