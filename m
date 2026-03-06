Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A13CFCB622
	for <dpdk-dev@archiver.kernel.org>; Fri,  6 Mar 2026 16:40:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3B842402E3;
	Fri,  6 Mar 2026 17:40:33 +0100 (CET)
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com
 [209.85.222.175])
 by mails.dpdk.org (Postfix) with ESMTP id 97B4B40262
 for <dev@dpdk.org>; Fri,  6 Mar 2026 17:40:31 +0100 (CET)
Received: by mail-qk1-f175.google.com with SMTP id
 af79cd13be357-8cb38e86cf2so1000069785a.1
 for <dev@dpdk.org>; Fri, 06 Mar 2026 08:40:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1772815231; x=1773420031; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m+SqVoWbt4D7mYUebbsOXyLXc2FkCyzMb9Xnuk+BBGk=;
 b=H9Ct9XAZG0OwIt7u6V3Sp0dV+8Is6RAomAyFiuPHGZpsDB6voegRBUee0hom/S1UV/
 cnMipNRbF/hCl1S6UYwKs3ec6Pohss0bW6uUjlQcIOjeUfYYhEHjLJYSMHixCHY6oSWm
 LcndrCX439RwWUfSUQ/8SsOT8/TAl11ClWz5c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772815231; x=1773420031;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=m+SqVoWbt4D7mYUebbsOXyLXc2FkCyzMb9Xnuk+BBGk=;
 b=c4nxsR4FYJGLenLz+zMWuq6x4/up9iSvre1dMNgZEutbIWcyTFRxIJ1A73y7q115T8
 SaLkFRUqQs8J8nkal2PY4P/wAn58+pP3wPEQpMYv4nWAgLobWOunyzXhrvnRpEv+UsJc
 XV4czLEJuAlV++/GP77NlRVaHB7gX0kZzTfGbHholqsNftaZrGBacg4tq4k0ITJReWXS
 U00MBkQxtj0EC7qCyrXYTA2mFHYZr6ZS55c4/quXzeADhAdGa49FxeBP3CLCyW01Y8Wf
 8nOjHB5ajqcrKya+43TAgvUkJD+b1yCLgavKFtJzlpOZvzQkwL+cuQwATxUxTC89TO5Z
 KlbA==
X-Gm-Message-State: AOJu0YwZSqmXnxRU5UxbhwotFkI3TNcf/LtWHHJvIN8jqn6SbMkD1gqQ
 +SUaby2bLf4ld69WpgjS4T4n+fxzd1NPJ1YHzA1T/c3zwxpiZCxL7v0ZpvpkmBZKsVQ=
X-Gm-Gg: ATEYQzwl2BROiu+zO54aaeDnUBL5UR6NzECdlF1arKhesuZS/g58ihFYVfu+WuDHN64
 3yuSOQh8VDWQ30dmMrGOmPiUr0TCEjt2Q2n8PweeJsfWrQRaj6JWlUVdsjsgwyUdCdLJCVes2hm
 iZbh+hwmhIF+FLyh56ampZsZi2QDRktZqWARiaq2P38zFsVWywuh1yQAP14wU15nEm4yrVOtuXM
 XIjWLchpvpeqT62qnP2w7ajxCyZaw3rMvxXXXY2OoUCpXi7Zkc2twyWzxHgJz4cGZUCdJF7yCLN
 NCuBxi3dWbJu7wbSyQY+ZCFI2qa3WCnZLLTKmy1ugVRW40t56VKWHnrFvuPd23+xP5u6pRgl5L3
 AwmRrLHtPXGmHNdWISIpEt9d3uA3UpmD01w1GOf4uRNa3MWe3oS9Ht6tEVx+mFBJvMcj4K2OvQC
 e9+0KRx4cjgARmRP9id0fR7sJXlMnv/aD2BBkgnJ0R+6vyo6sL+sq7fxiSrXEe3IS5
X-Received: by 2002:a05:620a:29c3:b0:8c9:e976:d20 with SMTP id
 af79cd13be357-8cd6d441089mr363783785a.46.1772815230720; 
 Fri, 06 Mar 2026 08:40:30 -0800 (PST)
Received: from d122205.iol.unh.edu ([2606:4100:3880:1220:4f6d:e2af:7f5f:4df])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cd6f566fd5sm144608185a.43.2026.03.06.08.40.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2026 08:40:30 -0800 (PST)
From: Andrew Bailey <abailey@iol.unh.edu>
To: probb@iol.unh.edu
Cc: dev@dpdk.org, luca.vizzarro@arm.com, dmarx@iol.unh.edu, kai.ji@intel.com,
 dharmikjayesh.thakkar@arm.com, david.marchand@redhat.com,
 gakhil@marvell.com, Andrew Bailey <abailey@iol.unh.edu>
Subject: [PATCH v5 0/5] dts: add cryptodev testing support
Date: Fri,  6 Mar 2026 11:40:22 -0500
Message-ID: <20260306164027.171723-1-abailey@iol.unh.edu>
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
v5:
* Updated test suites to use zero VFs when running a vdev test.
* Updated variable naming and docstrings to be consistent.
* Resolved rebase conflicts with main.

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
 dts/configurations/nodes.example.yaml         |  12 +
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
 19 files changed, 1858 insertions(+), 3 deletions(-)
 create mode 100644 doc/api/dts/tests.TestSuite_cryptodev_throughput.rst
 create mode 100644 dts/api/cryptodev/__init__.py
 create mode 100644 dts/api/cryptodev/config.py
 create mode 100644 dts/api/cryptodev/types.py
 create mode 100644 dts/tests/TestSuite_cryptodev_throughput.py

--
2.50.1

