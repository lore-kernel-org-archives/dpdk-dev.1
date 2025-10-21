Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56A71CCD1A7
	for <dpdk-dev@archiver.kernel.org>; Tue, 21 Oct 2025 14:45:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4CEBE40655;
	Tue, 21 Oct 2025 16:45:48 +0200 (CEST)
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com
 [209.85.222.182])
 by mails.dpdk.org (Postfix) with ESMTP id D5643400D5
 for <dev@dpdk.org>; Tue, 21 Oct 2025 16:45:46 +0200 (CEST)
Received: by mail-qk1-f182.google.com with SMTP id
 af79cd13be357-8915bd01244so878360985a.1
 for <dev@dpdk.org>; Tue, 21 Oct 2025 07:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1761057946; x=1761662746; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O7GVl4GRABacOVT8GZLRSIcJHlrcKcOObY2rb+CosOQ=;
 b=iQ7YXibJ/fFJxQ17RKs0JNcPBEPHx7vtqYNARgG8l0DYEMDewlkpd/4r30yvTUoNKO
 AYW9plKqZS6vYmUYt81zesF67oi6sVFwl001OCdYM9c7/IloUQ6GKvK464rdJPHqqFbp
 Xl/b85EZFCGxEVWjbhK4r0qEm+bO+Q0E0UxyE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761057946; x=1761662746;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=O7GVl4GRABacOVT8GZLRSIcJHlrcKcOObY2rb+CosOQ=;
 b=orjNqAftpCl0t5CdBgglD7d6tQTrSB1LoKPK7n1vau66KR2l7w0jyMXexj9dQtZOCa
 y83TxvgKMXyVAKpS9pYRQ143hNfdlUZ/i4OMgxMyTRGbpUswEcRKDm3Et0fyNIJ34Uq4
 cgeg2Gw50RM/UW5rYyQ73CN0dr1mo3pEjzhku/6Vb62w2fT3zSiJ+pmIV5nM6QunFTt4
 CRXuNBHGVzEHYGNH3vAEgNrBwyo3ORaUoRi/tT2AYGADPy8eqQOC3tN+LPkKqH8KJ8q6
 MLBiaogoHs5njTlY2eSlsiBn3oNl63B8MZQYKxjbTgkI0a07GfLMbce7QIINUKxvtd0D
 3jsA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXj50Aa2snpy2JDLFPvLQn1INRKp7C0mSth1lEpfbe1U9S9CwwgKAo7GdcVO+aeG8040J4=@dpdk.org
X-Gm-Message-State: AOJu0YxDozwk1wdTnxTRB2QQxJCbbIK2Xuby3IWd6bUAC+4qqcX/w6mU
 invdMxuC0I0DW22FcFe+LgAQmiRYcOvNUoYJAjoQzhadFgzTBekHrmvaYZFdSG/lmvk=
X-Gm-Gg: ASbGncuWZVmVUCVB+jxV3BgYn6zKl8L8tSmLaYoSbeCHT42cLZy8J2eD9pyNisHpr3t
 QPJFf7KYL2bjAoPSBm4tmut5FWHVzLEGJMI+sV4Mlbbsx5EVuVG4dEQLWtmBXxusVsVuTnah/CZ
 K+vB4w7ktUCPr2ehiVyRHL2Z6dgGKSECEawsHHjQPGwGwYZUaVKxl+9Segj0fyGjWFe01q/7z5k
 teG1lI8e+pQQ2EI99MoH8NWM++GS335u74ywF+8WGfPdJdYHHajBB6fxa/QHoiVdDMiq1PNanGq
 gV5EFSSRSooNGTbQXoy721xU0/FLqCzGuh9GeBpKiF9CelM2oQRARDb/ddzXDrRW3h6ZulaUSHj
 cOVU0Zuq0N8Lvl5Ckoa/plth3+ykG+dp/8c13R0u4Y3I9D4MvB9hu7mctmgMp42O8XU2de/heb9
 W0AQheSkf+qKuM
X-Google-Smtp-Source: AGHT+IFNEoVAXPeICVDlV93x9Md06OVUsrCAx/vQRukpr/EKaXrvDaKA3UtRWBUl+Iz1jNc+7Vyigg==
X-Received: by 2002:a05:620a:4629:b0:88f:c8f0:ca85 with SMTP id
 af79cd13be357-8907021361dmr2067249685a.62.1761057946054; 
 Tue, 21 Oct 2025 07:45:46 -0700 (PDT)
Received: from d122205.iol.unh.edu ([2606:4100:3880:1220:4f6d:e2af:7f5f:4df])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-891cd57b780sm770350385a.24.2025.10.21.07.45.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Oct 2025 07:45:45 -0700 (PDT)
From: Andrew Bailey <abailey@iol.unh.edu>
To: luca.vizzarro@arm.com
Cc: abailey@iol.unh.edu, dev@dpdk.org, dmarx@iol.unh.edu, probb@iol.unh.edu
Subject: [PATCH v8 0/3] dts: add tx_offload support in dts
Date: Tue, 21 Oct 2025 10:45:25 -0400
Message-ID: <20251021144528.39748-1-abailey@iol.unh.edu>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250902114327.48185-1-abailey@iol.unh.edu>
References: <20250902114327.48185-1-abailey@iol.unh.edu>
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

This patchset introduces the support for Tx offload configuration
through DTS, allowing test cases to be written utilizing Tx offload
capabilities. Along with configuring these capabilities, they are also
added to the NIC capabilities class, in which they can be required by
test suites. Finally, a test suite was created using the aforementioned
changes to update the Rx\Tx offload test suite in legacy DTS.

---
v2:
* Removed mentions of mbuf_fast_free being configured for Rx queues/ports
  as this is not accurate behaviour.
* Clarify argument descriptions in docstrings.
v3:
* Added seperation between port and queue capabilites as it is relevant
  to the added test case that queues support mbuf fast free
  configuration.
* Homogenized methods for getting Rx and Tx offload capabilities and
  configurations
* Moved to use the text parser to gather the configuration, rather than
  returning the raw string output.
* Updated test suites to use the new ports/queues offload flags in the
  requires decorator
* Updated mbuf fast free test suite to test ports and queues
  individually. Along with updating the way it confirms the
  configuration to be consistent with the new process of getting the
  configuration.
* Moved the get configuration method to the get nic capability patch as
  it is more relevant to that patches context.
v4:
* Cleaned up some typing issues in testpmd, and moved where prefixes
  are passed to the capability flags.
* Added documentation page for test suite.
* Removed use of optional in the added test suite.
v5:
* Moved configuration and capability handling to proper files in the
  api directory.
* Updated Tx capability flags to adhere to the new way of handling them.
* Test suites no longer need to worry about using the flag prefixes when
  analyzing offload configurations, but will still need to for required
  capabilities.
v7:
* Testsuite now assumes mbuf fast free is enabled by default.
v8:
* Made small change, updating port_id argument to come first in each
  new method.

Andrew Bailey (3):
  dts: allow mbuf_fast_free to be set with testpmd shell
  dts: add TX offload capabilities to NIC capabilities
  dts: update tx_offload test from legacy dts to next dts

 doc/api/dts/tests.TestSuite_rx_tx_offload.rst |   8 +
 dts/api/capabilities.py                       | 126 ++++++++--
 dts/api/testpmd/__init__.py                   | 157 +++++++++++-
 dts/api/testpmd/types.py                      | 227 +++++++++++++-----
 dts/framework/parser.py                       |  30 +++
 dts/framework/testbed_model/capability.py     | 109 +++++++--
 dts/tests/TestSuite_checksum_offload.py       |  10 +-
 dts/tests/TestSuite_pmd_buffer_scatter.py     |   4 +-
 dts/tests/TestSuite_rx_tx_offload.py          | 128 ++++++++++
 dts/tests/TestSuite_vlan.py                   |   4 +-
 10 files changed, 685 insertions(+), 118 deletions(-)
 create mode 100644 doc/api/dts/tests.TestSuite_rx_tx_offload.rst
 create mode 100644 dts/tests/TestSuite_rx_tx_offload.py

--
2.50.1

