Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE268CCD1BE
	for <dpdk-dev@archiver.kernel.org>; Thu, 23 Oct 2025 01:32:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CAC1D40151;
	Thu, 23 Oct 2025 03:32:00 +0200 (CEST)
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com
 [209.85.222.177])
 by mails.dpdk.org (Postfix) with ESMTP id B4553400D6
 for <dev@dpdk.org>; Thu, 23 Oct 2025 03:31:58 +0200 (CEST)
Received: by mail-qk1-f177.google.com with SMTP id
 af79cd13be357-8907af237ceso25264385a.3
 for <dev@dpdk.org>; Wed, 22 Oct 2025 18:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1761183118; x=1761787918; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GKnWgzbMpbkptwj2MOVxTwYyzniGea0l9MCucGh9V50=;
 b=A7J9WtjMkvg5xqlL7zJpSZvB1tvvTroTPFtELbor42O6OjDUALLSWFLrvSdcr9Mmrp
 T+H14geTVAcLuEJwsA3N9Mu8X1QuLmBGkcrOSLRfffOJ3p/zGGWXe1zMSVkWIy//7um0
 t1gy4+mJvgYv8WCGc77K1AptPzKD7BIvlJvLc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761183118; x=1761787918;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GKnWgzbMpbkptwj2MOVxTwYyzniGea0l9MCucGh9V50=;
 b=WFuORcrdqKrJkjlZ0Y10NPXiAYRIbr6PFvaaoVtudSoBSpxxPTh2oVXdKlExBfBRMT
 IOS/uW3DVB5VsWf6ZcqhySBBwVfV3udH/+Y6xEZK8RWeT7ehvLW/JwtvJtH8XVuHhVHk
 shxxAYZiBIPuRgJlmqbEB1sfzP8D114+x2X4JcnOzqj0RXgYgdjr5J6gZo3xi0jtYRbY
 b6mpYjoVQKWzwADWOUNrMJj10AYUKXhO0TDUy1TgKb+A5f99mQkbQWQFcCiESYw0Rjnq
 lwKTi04/A7STbr472AngjBsDFTcGfgxeGISBYnj5YEX5sbve2CI3Pcyh/7PVLMzmSuvW
 ItFg==
X-Gm-Message-State: AOJu0Yw8TQSBXVEFlff3ug6ZlXJeFmZJTJtZlbOnYJhr8fFHveBSIcU/
 eIbs7d5tig40/ok4q1SsGbpcKIBFXQ8Q3qdh05AQyEkI3iqG5t9yq8BAzxDjeYjBWjlAW4Jsy4h
 iiq1JvTo=
X-Gm-Gg: ASbGncvTMsbIDfhHBpYDIG80IOBDD8eXucLiQFqsSs4uxMRnli0Vxvqw4+R4vFFB+zL
 A1LqYKwWC/Sd0Pqzzio/sR+xBGLPizrXyRZ2ndGsTGgnno/SdNPlZDsBR/Z5e8rUUnuNC6ucZi8
 Vc+lzY1Os/JbTRzOPD9AMbZOZjPdzCF+nwd3IbB0ugGmQosYPocSeXvGLOM6pdke/wKBxKFjQWW
 3XcxydN5eVeTKJvvHBfGHZNAtude4A9A2gdIFZGoDa6yAk96Xr9dPgWCYDXOV6S+fUnE/mrIk3s
 JeBd5cTGRiz3cte3j0N1VQjQ0sUnnExMBuv0f3KU8LQgCJ/dk7sxsn+24oFkL8AlshngFCuq/8T
 Y4Q3HxtG1x36uX9lxnG8Cvkkmsh8xj4axuLHvohlkVuqgv/6Q/NTg0yi24ShvYH/DiVHBSBI7Ra
 2wQkAklX17xX1rU8JaLUY=
X-Google-Smtp-Source: AGHT+IHug05J+YLSs6hx57x9pVEThi09ZbnU10gLqfHVQzEpvpinpKT/ONJjOoAIMJbf9EfaxHnGVQ==
X-Received: by 2002:a05:620a:1aaa:b0:892:43af:ba37 with SMTP id
 af79cd13be357-89c0f7014a9mr119159685a.5.1761183117844; 
 Wed, 22 Oct 2025 18:31:57 -0700 (PDT)
Received: from patrick-laptop.iol.unh.edu
 ([2606:4100:3880:1271:8c70:5b9e:ecd3:14e])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-89c12546031sm56080085a.56.2025.10.22.18.31.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Oct 2025 18:31:56 -0700 (PDT)
From: Patrick Robb <probb@iol.unh.edu>
To: Luca.Vizzarro@arm.com
Cc: dev@dpdk.org, dmarx@iol.unh.ed, abailey@iol.unh.edu,
 Paul.Szczepanek@arm.com, Patrick Robb <probb@iol.unh.edu>
Subject: [PATCH v5 0/3] Add TREX Traffic Generator to DTS Framework
Date: Wed, 22 Oct 2025 21:30:46 -0400
Message-ID: <20251023013049.1368129-1-probb@iol.unh.edu>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251001231659.2297751-1-probb@iol.unh.edu>
References: <20251001231659.2297751-1-probb@iol.unh.edu>
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

v5 changes:

1. Adding a new api test function for taking a performance metrics dict
and writing it to a new performance metrics json file within the output
dir of each respective testsuite that calls this function

2. Adding the option to start a shell without adding it to the shell
pool, for when a shell is intended to outlive the current shell pool
cleanup.

Nicholas Pratte (3):
  dts: rework traffic generator inheritance structure
  dts: add trex traffic generator to dts framework
  dts: add performance test functions to test suite API

 ...sts.TestSuite_single_core_forward_perf.rst |   8 +
 doc/guides/tools/dts.rst                      |  49 +++-
 dts/api/packet.py                             |  39 ++-
 dts/api/test.py                               |  32 +++
 dts/{ => configurations}/nodes.example.yaml   |   0
 .../test_run.example.yaml                     |   6 +-
 dts/configurations/tests_config.example.yaml  |  17 ++
 dts/framework/config/test_run.py              |  22 +-
 dts/framework/context.py                      |   5 +-
 dts/framework/remote_session/blocking_app.py  |  12 +-
 .../remote_session/interactive_shell.py       |   8 +-
 dts/framework/settings.py                     |  12 +-
 dts/framework/test_run.py                     |  52 +++-
 .../traffic_generator/__init__.py             |  13 +-
 .../capturing_traffic_generator.py            |  34 +++
 .../performance_traffic_generator.py          |  64 +++++
 .../testbed_model/traffic_generator/scapy.py  |  14 +-
 .../traffic_generator/traffic_generator.py    |  44 +--
 .../testbed_model/traffic_generator/trex.py   | 259 ++++++++++++++++++
 .../TestSuite_single_core_forward_perf.py     | 151 ++++++++++
 dts/tests_config.example.yaml                 |   5 -
 21 files changed, 768 insertions(+), 78 deletions(-)
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

