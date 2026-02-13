Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14698EF99D3
	for <dpdk-dev@archiver.kernel.org>; Fri, 13 Feb 2026 19:36:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5C739402C0;
	Fri, 13 Feb 2026 20:36:00 +0100 (CET)
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com
 [209.85.222.174])
 by mails.dpdk.org (Postfix) with ESMTP id 9AF1F402B2
 for <dev@dpdk.org>; Fri, 13 Feb 2026 20:35:58 +0100 (CET)
Received: by mail-qk1-f174.google.com with SMTP id
 af79cd13be357-8cb4136d865so136560585a.1
 for <dev@dpdk.org>; Fri, 13 Feb 2026 11:35:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1771011358; x=1771616158; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tEODn3z57Z61O0H2kYEz4rY7ntZJK//ajDKDc5SmqRs=;
 b=RWQc8cWS8lwX3JO98Dr6K4tAV1XCeA2ytjIB1DnzTBfYwXLrb5JQFQzot0ODFlnBNb
 4arObchwY3gPvz7/X0wDhMl3isWcPzee2/pH25GCDz6yw0K5OVmqFDBwpHXzT2l22Vj1
 kg6VS5iABZc8H8p6c/dAEmKw4AulEwU/mHIv8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771011358; x=1771616158;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tEODn3z57Z61O0H2kYEz4rY7ntZJK//ajDKDc5SmqRs=;
 b=ZCux+ZHSrFrFtrp1x0vieaBaSksTiyEH1Th/6+NKchyKZzeLOXsMhHacNCi+JX4GPG
 eb3E5PxOSWvV5RdPBMJoeC1a1JqBHIknWBAZF565ygCNHPYZFP7yp5C5bl2J3gds2Ztm
 XkEDIlJNSveIleUgxQx8By4F6eErosftqRQAC3MTwR3QVO5DR/pTTCAT0sEEAsusbh12
 b+m+t6rcyeb5tTgiwYzvHbsaYrSiBWyCajTIMQdvf8CJUnHEXeH+no9/tLmxxxOkq0Wc
 POutrfnBrOPIqDzmzxGph0uwcQNkYzZ90lZCmNmEmv76bY2+z6vRJYEr8Uh8yH1jQLHa
 1R2w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWtWAvfnRv2Dd6eglUcGvNihUp9kQxE4aWObvB5XLWydBkmMsflUKCeUJaO9F6CH+wT82g=@dpdk.org
X-Gm-Message-State: AOJu0YydHM19WdMI3SILQ+4S4aDfV/909WPpHaHQ2CeR0UYvMx+dfG7+
 vUKQPjue8Y9hMesNWsaVXARS37IM8Oyj7TX4yOAQ1d/Sq4BxflCPfLxhoYz2p+ixZPE=
X-Gm-Gg: AZuq6aJ3X2EYunj+kjisfJ3E+F/yYVVliFmPCGVxNgXa91X1bD3IAz0hAoRu2tarlzs
 zsxi/JuiFToLp/NlJl4uLjgEEw0cZB0eIT+VqZDmkGTHelimvzYxmbIU6hZvOGxmrlZnpI7Z3vB
 8dN6cwMQ6RSt8Zy4c8LN4Dx3nF6uj7uToHTjj52TQLxnoP3KV0l3Whi+CnRSWRPGiXk9rFj29kW
 Bs0hJMcLUBSs46g4tockfgqHs9ie7CM38OxS1wFIiOlvwEP+GQQDUh+JuG1aWfYg6+D+hJ7AKXV
 nFV40snmeA992/iK7cVWO16ZNk6zD08GaiFqx8g6OjsyOXAmg1AA9YZsbkw4IqcC3T6zyCsa7y9
 FVCuACpigpRck3votI+8upj/CMnbOMBcrARMKX6ep8dMnsiZ+Gvusvh7hcYgDao16evIMb2GrYC
 FK2rNL+/ownIOjTI/67a5YsbNdZm6dhPwXUwZipbSM0dBYXa4U7Yaveos5ekz+lRnR
X-Received: by 2002:a05:620a:471f:b0:8ca:2cf9:8197 with SMTP id
 af79cd13be357-8cb4c01475amr92993985a.47.1771011357774; 
 Fri, 13 Feb 2026 11:35:57 -0800 (PST)
Received: from d122205.iol.unh.edu ([2606:4100:3880:1220:4f6d:e2af:7f5f:4df])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cb45f13a61sm146726085a.7.2026.02.13.11.35.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Feb 2026 11:35:57 -0800 (PST)
From: Andrew Bailey <abailey@iol.unh.edu>
To: luca.vizzarro@arm.com,
	probb@iol.unh.edu
Cc: dmarx@iol.unh.edu,
	dev@dpdk.org,
	Andrew Bailey <abailey@iol.unh.edu>
Subject: [PATCH v3 0/5] dts: add cryptodev testing support
Date: Fri, 13 Feb 2026 14:35:34 -0500
Message-ID: <20260213193539.103858-1-abailey@iol.unh.edu>
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
 dts/configurations/nodes.example.yaml         |   6 +
 dts/configurations/test_run.example.yaml      |   1 +
 dts/configurations/tests_config.example.yaml  |   8 +
 dts/framework/config/node.py                  |   4 +
 dts/framework/config/test_run.py              |   3 +
 dts/framework/params/types.py                 |  65 ++
 dts/framework/parser.py                       |  28 +
 dts/framework/remote_session/dpdk_shell.py    |   5 +-
 dts/framework/test_run.py                     |   5 +
 dts/framework/test_suite.py                   |   6 +
 dts/framework/testbed_model/linux_session.py  |  78 ++
 dts/framework/testbed_model/node.py           |  10 +
 dts/framework/testbed_model/os_session.py     |  34 +
 dts/framework/testbed_model/topology.py       |  89 ++-
 dts/tests/TestSuite_cryptodev_throughput.py   | 692 ++++++++++++++++++
 19 files changed, 1857 insertions(+), 3 deletions(-)
 create mode 100644 doc/api/dts/tests.TestSuite_cryptodev_throughput.rst
 create mode 100644 dts/api/cryptodev/__init__.py
 create mode 100644 dts/api/cryptodev/config.py
 create mode 100644 dts/api/cryptodev/types.py
 create mode 100644 dts/tests/TestSuite_cryptodev_throughput.py

--
2.50.1

