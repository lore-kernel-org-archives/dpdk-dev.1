Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DFF0EB2700
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Feb 2026 19:52:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7BAC6402B0;
	Tue, 10 Feb 2026 20:52:20 +0100 (CET)
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com
 [209.85.222.47]) by mails.dpdk.org (Postfix) with ESMTP id 6570F400D6
 for <dev@dpdk.org>; Tue, 10 Feb 2026 20:52:19 +0100 (CET)
Received: by mail-ua1-f47.google.com with SMTP id
 a1e0cc1a2514c-948ee050c4cso89309241.1
 for <dev@dpdk.org>; Tue, 10 Feb 2026 11:52:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1770753139; x=1771357939; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4Uao9+nTVNNbq4aJ5LDLIhICLczvkgcexV0XAk7F0pk=;
 b=RKStmPOLGRpdLTVQAcopERW7NELnCZRCcJT98mhRudIFoBBm2G9Q2HZKeFQd1POoH3
 AGdDWcj+0pQwyBcDXyDGQGjbQS0jBAHNCBujy3GT4fbWh836Nf8ufEUtL4K24jFX6po6
 JQ4fGER1Vwb3XCsjOqzX1d0pMNJNQPL5BNrZc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770753139; x=1771357939;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4Uao9+nTVNNbq4aJ5LDLIhICLczvkgcexV0XAk7F0pk=;
 b=VDhu61pyoswb7Qs7LIEW+WLGFLzUhzKDrj0kJL07ShwE3oaS0+B7qJSjAITU175NUD
 YhpxNZABk1Sce1denvRiSuwtKX2W5Z3N4sat4DPQJJhwQfePcRWzN+eJ42ZxvsWGtEZr
 NhCZR3ZG62lj4/YZvrc47bxQjmIhlO3zCm6QGZHwmorQlDc2VJRWDPiQf/FLDyRtoJQP
 t6VwWPWUSU7Y3MV26Vwzkbde/HR8x5/oEkwnnkYi6d8+e+8paAFRcnizHfLei9+D82sM
 +Q3DhiYmN7AOaICdRU/RPAddL0h3WL1rExWEDZxZEB8LFPK9Za0zrC8BVaZ5IZ5Iratt
 n+yA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX/24ZwKF5SKzgCr4FR7lC/5vDk4wvi4VDCng7qkjwEKNhLZ4ITeLRUbOWxVZEQeBYOTyc=@dpdk.org
X-Gm-Message-State: AOJu0YxBYCLWR8c7+M/Jssakse1tzcPRg+Z6AGnndrthuWtkSFHIJk7J
 nlEpTsEabbuUjqgeHsEsfs2yVqx5rDjH+Iw5SbpnTD+VkEr22kcmFXwgRJtZlzZK7RPEefHoojG
 yeDBM
X-Gm-Gg: AZuq6aKjZgVThYyUInxxYYqDYiDwQMRyMzbLbSqB8mz5XxUkzV2K9HyJ6z8Uwb619h9
 3LIeMKzTvTbzBJ8YSKrhYM7GuzBxfMbdHJBkT+DIJ4YEpm5gsyqkVEbAKXkudVckcdom2x59E9X
 4E3Anfg1KhhRwTJ2oaQkwhqh7NuCKNpIvaHHTf8Nj+fHV7RTYMTxKPefYodIdjRboeyVNuN8qdG
 9C2dwbv6b+29i5fOOPDdwKez5WF8CwI8yH5zEzrnT009S+B7ISa26GIVOKY/VVB/SmIHursIYGr
 rX5A5NFYsEIcye+dsf4GDK/VhPNKCUZ8DAbz00tfKg9ZYYkLFjQD3zEdO4SiDySvfW72/eJBIVV
 +OmpiH+wX5lawvTIuBtGrsem3ANczsu0Cni8Rk7b88669Gd0Cr2bf9lAXKGkLYLhC873jOK0FTa
 2UHYRlsi6fIyN00rfxAw6ZDSFZH6GPtPglRshPgXHY94HEYBMHytpNDG6MmdV8oyQm
X-Received: by 2002:a05:620a:294a:b0:8c7:3ff0:d489 with SMTP id
 af79cd13be357-8cb1eeeb92fmr400611685a.1.1770746808688; 
 Tue, 10 Feb 2026 10:06:48 -0800 (PST)
Received: from d122205.iol.unh.edu ([2606:4100:3880:1220:4f6d:e2af:7f5f:4df])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8caf77f2868sm1079300385a.3.2026.02.10.10.06.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Feb 2026 10:06:48 -0800 (PST)
From: Andrew Bailey <abailey@iol.unh.edu>
To: luca.vizzarro@arm.com,
	probb@iol.unh.edu
Cc: dmarx@iol.unh.edu,
	dev@dpdk.org,
	Andrew Bailey <abailey@iol.unh.edu>
Subject: [PATCH v2 0/5] *** dts: add cryptodev testing support ***
Date: Tue, 10 Feb 2026 13:06:40 -0500
Message-ID: <20260210180645.65880-1-abailey@iol.unh.edu>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260122214424.322422-1-abailey@iol.unh.edu>
References: <20260122214424.322422-1-abailey@iol.unh.edu>
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

This patch series adds support to use the dpdk-test-crypto-perf
application. This application utilizes crypto devices that must be
listed in the format of a port under the `cryptodevs:` label. Along
with this, the application does not utilize a traffic generator and
therefore a new test suite decorator has been made to signify this.
Crypto tests must be enabled in test_run.yaml as `crypto: true`.
It is not supported to enable crypto testing along with functional
or performance testing. Specific capabilities of a crypto device
cannot be gathered at setup and therefore, non-relevant tests skip at
runtime. Finally, the application must be run with virtual functions
and the process of creating and binding them has been automated within
this series.

---
v2:
* Updated example yaml files for test_run and tests_config.
* Expanded test suite coverage.
* Resolved git problems where patches were removing code added by the
  previous commit.
* Updated test suite to only run tests that are configured in the
  tests_config yaml.

Andrew Bailey (5):
  dts: add find float method to text parser
  dts: add cryptodev package to DTS
  dts: add cryptodev throughput test suite
  dts: add crypto test decorator
  dts: automate VFIO-PCI modprobe in node setup

 .../tests.TestSuite_cryptodev_throughput.rst  |   8 +
 dts/api/cryptodev/__init__.py                 | 134 ++++
 dts/api/cryptodev/config.py                   | 499 +++++++++++++
 dts/api/cryptodev/types.py                    | 185 +++++
 dts/configurations/test_run.example.yaml      |   1 +
 dts/configurations/tests_config.example.yaml  |   5 +
 dts/framework/config/node.py                  |   4 +
 dts/framework/config/test_run.py              |   3 +
 dts/framework/params/types.py                 |  65 ++
 dts/framework/parser.py                       |  28 +
 dts/framework/remote_session/dpdk_shell.py    |   5 +-
 dts/framework/test_run.py                     |   5 +
 dts/framework/test_suite.py                   |   6 +
 dts/framework/testbed_model/linux_session.py  |  84 +++
 dts/framework/testbed_model/node.py           |  10 +
 dts/framework/testbed_model/os_session.py     |  34 +
 dts/framework/testbed_model/topology.py       |  92 ++-
 dts/tests/TestSuite_cryptodev_throughput.py   | 691 ++++++++++++++++++
 18 files changed, 1856 insertions(+), 3 deletions(-)
 create mode 100644 doc/api/dts/tests.TestSuite_cryptodev_throughput.rst
 create mode 100644 dts/api/cryptodev/__init__.py
 create mode 100644 dts/api/cryptodev/config.py
 create mode 100644 dts/api/cryptodev/types.py
 create mode 100644 dts/tests/TestSuite_cryptodev_throughput.py

--
2.50.1

