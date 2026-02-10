Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECF96EB2705
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Feb 2026 19:35:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DCA28402B0;
	Tue, 10 Feb 2026 20:35:13 +0100 (CET)
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com
 [209.85.219.43]) by mails.dpdk.org (Postfix) with ESMTP id C5ADB400D6
 for <dev@dpdk.org>; Tue, 10 Feb 2026 20:35:12 +0100 (CET)
Received: by mail-qv1-f43.google.com with SMTP id
 6a1803df08f44-89505dd3e24so13700776d6.1
 for <dev@dpdk.org>; Tue, 10 Feb 2026 11:35:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1770752112; x=1771356912; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=4Uao9+nTVNNbq4aJ5LDLIhICLczvkgcexV0XAk7F0pk=;
 b=XWdLrlRLmpztYU5Og91EyY/Yogi//zWGk5CNd6IYMpqOC9huSosES2Q9pwFBW2wB13
 ncz5LhCY+IQ1KzeOM1kde6U+OwE/mos/nbgJhV6X2aOv7cs4TgchffEbVP3QDDDf6cCr
 LV0WiCLATWMkVR+VacZcXgRnQ9N1+Q+/JYmtQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770752112; x=1771356912;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4Uao9+nTVNNbq4aJ5LDLIhICLczvkgcexV0XAk7F0pk=;
 b=JHYOu3vV8948PlzOZnaoc+lEHB1LCLG9YBYHWkIJ0tvGT+aIqcYtYD59J46VjV3BK9
 KOGA15W+UByGavJtTbzZyYP8BOhf7gsH0fiTQ0GAfP7oXMOk/zlCXCiVUV1JiO3PCsRq
 /6p8owPeEU9rDoj8/Y/Xp1Vyk4bCkGMkfswTeBKKtptcRQKNGROlwJhlN2EVQinuR5Bv
 xl2cl5XTzN4j1n5gEcXinXuk9sn0FadM1u5r7uM6KtELLwr0/cNo5zbNAkn1IiX9diIH
 BhLWsEh9B87COi3SczJykC7H/3s+GgkpINQzMHX9xhdYgrZ58l64XquwyDCcGBbcpBia
 w5Kg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXi8BgRkOeMRCzKuW1vmt9LqYPlWO+27jxpXAl2nArSVPm4eebphkPj1HHYGF+c+8cqYEY=@dpdk.org
X-Gm-Message-State: AOJu0YyXRaafjSX2/lMbsKiwu14xZcvvEGrWXsoVhXxYtKHRFUkSN5aM
 HBlH+1zBRkEfuho2XCbCkoxHatwRQyF045IdJdl1tLyubCt9B/f2dn6CHW9ixt77QVs=
X-Gm-Gg: AZuq6aK66oF/tHNNgov+joVypge5Skrc3uiENyLD0AJ5WOzdWP8xcjAsNOpNy/XjZY9
 pVl06PfQJBR2QCo7/IJ+o0zZqQo0pmkanQVC6uSG3DbynQtqUbL0N6mzpty1qY+MlWky3h+Qlrp
 fNqIiF4VZr7Y6FsRor83Q4KDN/PmvlJHLVN93n3Ul9S2VYZYaMYcAvhfwNeGG/zw28aVjIbDm0l
 ajk4NzfSCwst6A3B4vVoGiyNof31PINHMAAv89XhSJFrawtCd6Zg142QRvRluz5MkjMxuC1khzW
 LQtIQtu37i4nFgQCtVUsXmSH8RrNnljk94cwHcd5RvVSadGjbgXQnTIlHO/6BUa3EDWpaOcZN2S
 6R5NFVBomGrwsCzyKCJQ4fyp3RRUt7TLfIXIG1HVl2TzUvb5DDg1tffjVMwZBlLj+a01nLZtZsW
 sUL7A5ZLeeyvq5Q4+plLgg3/k/1n0UxnMNcsNbkRs9bQnXs+zIn9A6O3ayfyF6w4M3
X-Received: by 2002:ad4:5deb:0:b0:895:4c45:a617 with SMTP id
 6a1803df08f44-8954c45ac06mr188415196d6.36.1770752112126; 
 Tue, 10 Feb 2026 11:35:12 -0800 (PST)
Received: from d122205.iol.unh.edu ([2606:4100:3880:1220:4f6d:e2af:7f5f:4df])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8953bf3b6b2sm107455356d6.6.2026.02.10.11.35.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Feb 2026 11:35:11 -0800 (PST)
From: Andrew Bailey <abailey@iol.unh.edu>
To: luca.vizzarro@arm.com,
	probb@iol.unh.edu,
	dev@dpdk.org
Cc: dmarx@iol.unh.edu,
	Andrew Bailey <abailey@iol.unh.edu>
Subject: [PATCH v2 0/5]  dts: add cryptodev testing support
Date: Tue, 10 Feb 2026 14:34:43 -0500
Message-ID: <20260210193448.69423-1-abailey@iol.unh.edu>
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

