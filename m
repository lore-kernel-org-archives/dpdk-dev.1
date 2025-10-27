Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3A90CCF9E5
	for <dpdk-dev@archiver.kernel.org>; Mon, 27 Oct 2025 13:02:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 151964028B;
	Mon, 27 Oct 2025 14:02:40 +0100 (CET)
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com
 [209.85.160.178])
 by mails.dpdk.org (Postfix) with ESMTP id 011604026F
 for <dev@dpdk.org>; Mon, 27 Oct 2025 14:02:38 +0100 (CET)
Received: by mail-qt1-f178.google.com with SMTP id
 d75a77b69052e-4b109c6b9fcso42132811cf.3
 for <dev@dpdk.org>; Mon, 27 Oct 2025 06:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1761570158; x=1762174958; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UCLowpOFjZj2gnEaQEXADYbzl78xqNFYytO872fsU9E=;
 b=RgJp9Dzym4ffrj7SSuhQMZM2NQLqimzGEz7zvpo63sxamkaW9Xv8G0mA63TO3siD81
 yjxZscIAohCM5kpOhubdNjjFXq29BwLwOPUoNiopsKsWSOZdiLvGYFZfyXDCkb2UWa6R
 E8/qcSIsyorhza6Td8cDj0QzcM2WFPbAP16KU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761570158; x=1762174958;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UCLowpOFjZj2gnEaQEXADYbzl78xqNFYytO872fsU9E=;
 b=kzvYDpcVF7LUX3ez6DrxSQFA834PQEsgrUwQAWOeAR0qSVOgvpsmGsKYFPofY9ttsg
 iQfu16yahx4Xc5gXZJY9hJGnO8pznbsxXll13iPd8A9kfO7Tr2/DuiwdUFXYf69ki4SG
 TBxQFInc/aQ6RBT0k4PrZzUJROVTuSXvuDnvqL5RfXeMCVPSlRtQbtMfx1r8W3ToO7AR
 YXk9v1SN/Eeq5D5d3x3n8Q5E3l7AXD7x4pO7GyrYrr7XUegSjHbiS4ttTUbbHMgQlQ7S
 FuwQYA5zmNkbF47qozyfAj0WcIwUKUHGs6lY87zTIUu8YnuUWuoqVAUFGkZM5w2x7g0M
 z8vw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXCOHNc1SA+qYajyNL/KG8wt1fdqZ7AJDq0QVW4pwyuYo8xS0nkdNeZPS69ztaA60pOb/0=@dpdk.org
X-Gm-Message-State: AOJu0YzRKxLb3ZNo3sOB3ok9ClvWAY7Vs4JT+H5vQwJ2hwA0obyrYetw
 XdHjQDb2kbcw0aWrhRE4kewqPNOLq7TnTtcoHNey3Bw84/N/ghYEB5Mm/28lgPmhnq1aQWtPjin
 rZunb
X-Gm-Gg: ASbGnctyp8vYsZnokV/XrCF0j4VwP2x9FKweJywK+tJQiIqNNqEh7rpZ4N4ZBxRnNyU
 +zmSxyP1ciudXUt/1JuHizk6HR7EdpvVatC3AMf8SA0xc9LmJkFID2pL6QrKQtKvOjBitgqOpjX
 KDwwaTnfh5TuRYA1Hw2/pzbyN7QBHarNJks8/ac/RtCLaOpxZUEJuy9RAnfJ7NmnIoISMiH83+m
 kbvHDM5vFu/6uu+Bm9nIOVReXdSdlfh+imVpLUqPlR5f1NZ/yUsMTIm5yyL33ofp5jKjTwrk4l/
 Ffh1knTq2labvpC7jj2TcoASy5xcz3SbT84nI/1yHlf67VDyzv62WUgacdiua570uJvZDBV6rFU
 NMnmG69g0upCW2C2NyCoEk23yXA2jyU1uX4cM/Sq3vp2V/IURGr8vIkl/GIZ9FK03SUl8WjC5z+
 6aF1+0qyFVU+j9
X-Google-Smtp-Source: AGHT+IFV4r0h7Eqn9xZmC7x56lvJkwEVvFVuICuo9SWJRbyL92TfXh2tChzuh++3g+aEMsYGHtCgig==
X-Received: by 2002:a05:622a:9001:b0:4eb:a296:6ef7 with SMTP id
 d75a77b69052e-4eba2967202mr99120471cf.2.1761570158116; 
 Mon, 27 Oct 2025 06:02:38 -0700 (PDT)
Received: from d122205.iol.unh.edu ([2606:4100:3880:1220:4f6d:e2af:7f5f:4df])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4eba37b96d0sm51104511cf.6.2025.10.27.06.02.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Oct 2025 06:02:37 -0700 (PDT)
From: Andrew Bailey <abailey@iol.unh.edu>
To: probb@iol.unh.edu
Cc: abailey@iol.unh.edu, dev@dpdk.org, dmarx@iol.unh.edu, luca.vizzarro@arm.com
Subject: [PATCH v10 0/3] dts: add Tx offload support in dts
Date: Mon, 27 Oct 2025 09:02:12 -0400
Message-ID: <20251027130215.95444-1-abailey@iol.unh.edu>
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
v9:
* Removed unecessary variable from testsuite and fixed typos.

Andrew Bailey (3):
  dts: allow mbuf fast free to be set with testpmd shell
  dts: add Tx offload capabilities to NIC capabilities
  dts: add Rx Tx offload test suite

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

