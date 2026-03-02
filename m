Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65B74EB362E
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Mar 2026 18:55:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 48BAA4028C;
	Mon,  2 Mar 2026 19:54:59 +0100 (CET)
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com
 [209.85.219.51]) by mails.dpdk.org (Postfix) with ESMTP id CFE31400D7
 for <dev@dpdk.org>; Mon,  2 Mar 2026 19:54:57 +0100 (CET)
Received: by mail-qv1-f51.google.com with SMTP id
 6a1803df08f44-899aede64e8so45499606d6.1
 for <dev@dpdk.org>; Mon, 02 Mar 2026 10:54:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1772477697; x=1773082497; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=488eUAyPxCDjdvapqIYOt4rr+RJZzVD3zArqArLwD5g=;
 b=gbBr/Hc4gwbs1wte615fmyLHo5JBqITzlY3ijOFiMvBWls5HDQwNHn4ln+2nwQ4vUW
 REqPJGjn7Yb5dFtjTPiCTh0cX/LTx6lNiQMchUgpIpuvXj0tAdlPzFW52whC1Db2cakQ
 v3VuH3r12I4jonB5BoQC6UZRTO9qdygJ51IPg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772477697; x=1773082497;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=488eUAyPxCDjdvapqIYOt4rr+RJZzVD3zArqArLwD5g=;
 b=Pp3p1zl4hGWrX8lQ2203fV0PgtgLBPnuRwHE6WWRhHjJm5cYDTSoCN0PF27ePAFC6P
 XgbeD8i9tslQeHn/8dBXLZL2ntHfGHm7ZE5VzLRCgy0+j3XSuA2rOkD8m1uIZBhNomPh
 mW/cx7KFNI/jJhTByYk3GBYc5sIEnvmB5PoK8vwXA98lt8eOpXai+MBoc/O321odCGJx
 sRplaKcbC/iSqrd7WRU80ZE6aK82UnD7ZnFjm4SB2y2vcik+mxTxq174qdlQwYxhrwr2
 psoQsBdoEBl6/Rt7vjR/T7uhHqjYL3F+JB8dK7wXH51zQDQOOLoItCtfqGdCylO2Mbgk
 MTkw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU5hi1EcTCFI+OQrPLsi3YLGAVfmEctg476YstfsdqVLsdZK0Vp/C3NVpSH9sIlhT1Z0is=@dpdk.org
X-Gm-Message-State: AOJu0YwQxYSC95Bmfd+EA6UDnsohhHbNh3oDyvFpHFcHMKchcTfg3SIB
 sJVNvkB/erHx5kLEhfVeJ7IaFNr/WFvTpXD8noB12b/ERyKh0g7ZnxFGjq9l2qmThKM=
X-Gm-Gg: ATEYQzyTR71shl1uLajQQfakUSNz0Xgy6XDZcx8WmTSrP2ARvoOHPavHe+EpFBndxlW
 r2GDrNbw+V06i5soxZfKG5zd6oZ39nGiqUz02ae9LVN5E5mb/ewQEr/c8jTsCfaaldG5KEBhiFp
 RVqMWWvHzfY1fcPDgrX9Kku8SqJhNxnp+REbEa22hvPw+S29Csx9417CgvpbIuQCARyz28D8xW+
 z4HP7Nh6dSuffvGcnoZeBjp61nrrnsM0aPC0pDcao4pocxxYaSk3i34miu4f33Zi1UdZT+i0cbD
 UklZVfn6m++jzokAnu1542n+ELBTdajuKId/Mn5c8t1HRckSs3dDo4xNRGlnowpdkGkpK/penxt
 cRL9tpy1U+HTwRUpQw//MumdmhPUX2tpE1U+8vkC4y4D4XLX4jP9uMovsexiCvWn7GUiMT6bQh1
 f+LmpgV0EllPzg8uRtcYk1hIrDHz9XwW1UBsnzL2JX3o1OOkhHVgi/ZExULgzBIHs1
X-Received: by 2002:a05:6214:226c:b0:899:a85a:f083 with SMTP id
 6a1803df08f44-899d1f1b2damr196440056d6.12.1772477697085; 
 Mon, 02 Mar 2026 10:54:57 -0800 (PST)
Received: from d122205.iol.unh.edu ([2606:4100:3880:1220:4f6d:e2af:7f5f:4df])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-899eed12615sm46719586d6.8.2026.03.02.10.54.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2026 10:54:56 -0800 (PST)
From: Andrew Bailey <abailey@iol.unh.edu>
To: probb@iol.unh.edu
Cc: luca.vizzarro@arm.com, dmarx@iol.unh.edu, dev@dpdk.org, gakhil@marvell.com,
 kai.ji@intel.com, dharmikjayesh@arm.com, david.marchand@redhat.com,
 Andrew Bailey <abailey@iol.unh.edu>
Subject: [PATCH v4 0/5] dts: add cryptodev testing support
Date: Mon,  2 Mar 2026 13:54:33 -0500
Message-ID: <20260302185438.122584-1-abailey@iol.unh.edu>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260210193448.69423-1-abailey@iol.unh.edu>
References: <20260210193448.69423-1-abailey@iol.unh.edu>
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
v3:
* Fixed some tests that were being run with incorrect arguments.
* Updated crypto-device pci paths for driver binding and VF creation.
* Updated example yaml files for tests_config and nodes files.
v4:
* Updated how virtual functions are allocated to a run of the cryptodev
  application.
* Updated config files to be more readable.
* Reduced total commands sent to SUT node for crypto VF creation.
* Fixed various typos and docstring issues.
* Updated a vdev test case to use the correct devtype.


Andrew Bailey (5):
  dts: add find float method to text parser
  dts: automate VFIO-PCI modprobe in node setup
  dts: add cryptodev package to DTS
  dts: add cryptodev throughput test suite
  dts: add crypto test decorator

 .../tests.TestSuite_cryptodev_throughput.rst  |   8 +
 dts/api/cryptodev/__init__.py                 | 137 ++++
 dts/api/cryptodev/config.py                   | 508 +++++++++++++
 dts/api/cryptodev/types.py                    | 185 +++++
 dts/configurations/nodes.example.yaml         |  14 +
 dts/configurations/test_run.example.yaml      |   1 +
 dts/configurations/tests_config.example.yaml  |   8 +
 dts/framework/config/node.py                  |   4 +
 dts/framework/config/test_run.py              |   3 +
 dts/framework/params/types.py                 |  65 ++
 dts/framework/parser.py                       |  28 +
 dts/framework/remote_session/dpdk_shell.py    |   5 +-
 dts/framework/test_run.py                     |   5 +
 dts/framework/test_suite.py                   |   6 +
 dts/framework/testbed_model/linux_session.py  |  69 ++
 dts/framework/testbed_model/node.py           |  10 +
 dts/framework/testbed_model/os_session.py     |  34 +
 dts/framework/testbed_model/topology.py       |  78 +-
 dts/tests/TestSuite_cryptodev_throughput.py   | 695 ++++++++++++++++++
 19 files changed, 1860 insertions(+), 3 deletions(-)
 create mode 100644 doc/api/dts/tests.TestSuite_cryptodev_throughput.rst
 create mode 100644 dts/api/cryptodev/__init__.py
 create mode 100644 dts/api/cryptodev/config.py
 create mode 100644 dts/api/cryptodev/types.py
 create mode 100644 dts/tests/TestSuite_cryptodev_throughput.py

--
2.50.1

