Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43777CCD199
	for <dpdk-dev@archiver.kernel.org>; Thu, 16 Oct 2025 13:26:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 45C0B40E72;
	Thu, 16 Oct 2025 15:26:44 +0200 (CEST)
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com
 [209.85.219.54]) by mails.dpdk.org (Postfix) with ESMTP id 13A3540269
 for <dev@dpdk.org>; Thu, 16 Oct 2025 15:26:42 +0200 (CEST)
Received: by mail-qv1-f54.google.com with SMTP id
 6a1803df08f44-795773ac2a2so10647676d6.1
 for <dev@dpdk.org>; Thu, 16 Oct 2025 06:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1760621201; x=1761226001; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1Uxidg4LrcQDOx4wGbqdtWd4tY9MaCZY1W0bFYqNEVM=;
 b=P0iLsoBFzqiN4Fc97sqgPz+JIRohiRoiwnV5F8hRS/XDQHnPXnceY32eBos2FMFXEV
 +mgR9sSgnTYg7sl3E/HbuKKQd6mBkgV45rl0z4e2RyjqzKLH9pqu75WaDPs1ZcQ893ko
 /ENv+pXZJGsJHYoPKLKyMqcVkzNMDirEef5+M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760621201; x=1761226001;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1Uxidg4LrcQDOx4wGbqdtWd4tY9MaCZY1W0bFYqNEVM=;
 b=U3+iBSDCTwfK3TyTJnR00X50lC7h7z9Hn5GyJsNMJFazJliV0F4Fqqv2AkG7cg9OeJ
 6lTgZKCYeZvq9rXEJwo+gvC7W4pZOkAmP5LLXDKGcXTuro23Vs/I9DXjsHhWxt1BtcTZ
 G0QO+uPiShN3u1wwMiHAJSAyyZLrne5vmMj+QlPJUGUFeNrEYNpehBrxxDEvKyGBcebk
 XZ36w9sfQ4UzxI85mHLPYKOqHO7GcBVOyEQ0DbIaeyuSUhgSKxokgYIMUAn83yrf59DC
 jxhj9i+TZE4SovekcY6PZS5HLUHBx821dVDmv0eBO2mhLiQSysnOfpBunabkpG6DgR7g
 oKIg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV8wosWpiRDu05pmMNHZEOkbNiGpBkw0KNKMDdvdcrmIKyS5xoTXmyvRqOvVKXJf1Opc00=@dpdk.org
X-Gm-Message-State: AOJu0YwZKqGHx/iLvrLnn3jqh93Zk6FKvBrH+gGVvaU4PdNORitF8Z+S
 Ojo1kqGmXALoqPPUqdNvmka+6ELRB1+ZRZSDwzDFJ1twJHc2FmVOhAvl+OktCY1rnFE=
X-Gm-Gg: ASbGnctTu8l1vliLBaLOnJKGBI/DowpjhfYBGjWDTbvMkuwMsM1HvP+xoUBAB8/iO7F
 bzXWe/Gn9aLtHfweKh+Bb1zuNdauuM0wpLOAcvkTX9HWxtG50OP8VfiFoeX93cSop2mK/6DWhA5
 jWB1nRNRWplQjK4dT2kCaBHXvs75G4NT0ddBWJPKS5h1MvGo2WmQptaLXM3yzhXge0NmX14BZRv
 p098RCV3Yw8i08kBqcUshZd/gYVXg69dN7G8C/F7dVvwyujwmH8z85gG8r1eX3ryw66ObCBz3U0
 5EDy+Rirla7HvbxmpYfM6zpQSyZ89gwvmZ8hk7ZFmxkhaA9xRBCdji/kPPBV4KRXtRG6GgP+h/C
 4iEnQup5o7++m3vajXgeJhv3FP/khAjvR1JkHeYv8cdqI0TyDIX20BxAPr4VjxPn0UDp0MrkVwk
 WuMTPIHRkhhOT88Zg7VB5TuoLkhN38qK+m0cGO+C0CCmnOyQDN/5lP0N40J8BhuA==
X-Google-Smtp-Source: AGHT+IHb5letn37Nuy9N5BOSP2tCSzdT0cBTsKfGMbuI8xmzOhsABipSn80333BkAcq9YCCmsbxVHw==
X-Received: by 2002:a05:622a:612:b0:4e7:2058:b2e2 with SMTP id
 d75a77b69052e-4e89d38cf60mr1406051cf.40.1760621201185; 
 Thu, 16 Oct 2025 06:26:41 -0700 (PDT)
Received: from d122205.iol.unh.edu (d122205.iol.unh.edu. [132.177.122.205])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4e89aedad52sm4015661cf.30.2025.10.16.06.26.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Oct 2025 06:26:40 -0700 (PDT)
From: Andrew Bailey <abailey@iol.unh.edu>
To: luca.vizzarro@arm.com
Cc: abailey@iol.unh.edu, dev@dpdk.org, dmarx@iol.unh.edu, probb@iol.unh.edu
Subject: [PATCH v7 0/3] add tx_offload support in dts
Date: Thu, 16 Oct 2025 09:24:18 -0400
Message-ID: <20251016132421.12176-1-abailey@iol.unh.edu>
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

