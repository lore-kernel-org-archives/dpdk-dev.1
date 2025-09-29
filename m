Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD258CAC5B9
	for <dpdk-dev@archiver.kernel.org>; Mon, 29 Sep 2025 17:27:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0179C40670;
	Mon, 29 Sep 2025 19:27:40 +0200 (CEST)
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com
 [209.85.222.170])
 by mails.dpdk.org (Postfix) with ESMTP id 8D6B240613
 for <dev@dpdk.org>; Mon, 29 Sep 2025 19:27:38 +0200 (CEST)
Received: by mail-qk1-f170.google.com with SMTP id
 af79cd13be357-854585036e8so511858685a.1
 for <dev@dpdk.org>; Mon, 29 Sep 2025 10:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1759166858; x=1759771658; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SOnTk1oYJiPijfgQe12yVBFkRGVKxrkFsmlwDYY0UdA=;
 b=XTOs5xtLVJSOMubZyoV+JpBkvkQ+zHUbeZ7et136zpNfknYp/WyXzAZIa8E9klv8su
 xbkXEfIdHUKnrLJeai1WbYlcXRVztBziRvfK/5qkWLfd9T4cGwsZfGggOkYyPcGxWbYZ
 GOn+2IfHpDG/QsDtG5JfX0oYMpGBaN4bu6y/c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759166858; x=1759771658;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SOnTk1oYJiPijfgQe12yVBFkRGVKxrkFsmlwDYY0UdA=;
 b=k7C/9z9B19Bx39wZ2t8XyXHleeVnr1OlEee22Tvvd9Z3fQIZorO0fAfyDsePUX4aW8
 ktQllXfb8YapCmIf/r0O1ACBQWYYPS0Vp4HHJyIRz+wY0QPdMesUedDzBTfulzRsDLjp
 Qer0NE5SoI6Cfkd6MtdlsyO68A6dVNWvmUFycFAWSHdJffKkFFKD05k1/qWP/pi/IvZF
 e2kCn475Z1NbO+0HoBAvaKQjCLM2S7QqNkBoZF8nTM8yoy2m+GaRPI2/JbowFWGeZ2tR
 xzV19KqaNLZB/131waOM4OWp10Tizc3vR7t+A8iNeXfGi0VUddkkZ+h5aNAkaoArHSnX
 ENRg==
X-Gm-Message-State: AOJu0YymSteRgV/LaA/Uiajs9G321k5HNdkp78Bf4qLTyJUb5Mw0BOT5
 kGbbfQyqwQtltqrJHLwNAM8E0iUQeYJvTe6lKRUNqPR8bSkizvk2AUnqGp+69+AShH5eN5HnABa
 345zy
X-Gm-Gg: ASbGncv77sJuHico83AcnU92D0SA8UnjhI+rff8SV2u3RDY5xzk4ZPlsn02WL3nQedp
 iri2CXQA46ECl0ddGnkzzoMTbCfUp+OZZczF0V1gTJdSUcdW6pegyLtGN3iIgR/W7pq1zGYvvi8
 jGJVRAeyGuQNa2bOCwqV4OV41dWSP7VnE0Q+blWibjuk3bsNUWC3PNK5Kkcu9fxN9WNPFYHijMF
 1PMJX4yiO0mQ4oJUyVes2aVn1DPj3xDv7dXJmGedJ4/AHCdLuFXwufHLnKfVuaUr7bF3xgAc9KG
 t8HxC/xF+zgYdkWNjPuDcg/ZNsclDHAE9AbfGoTJm0C4LV9bRgGpovbZe6/wzfT6Q1N41hBm1Lr
 mMw8DcRVyCWyz6ZFRESlA7ypKXieVDJLBL6Y=
X-Google-Smtp-Source: AGHT+IGOEEciqBHX5XcXGkFWFiPsfNBJS8rhCWIRfZiJwRGK/HhGW3T0TFHxpMkNbfZ98OZE4O8o8A==
X-Received: by 2002:a05:620a:1988:b0:84f:77e1:2b2 with SMTP id
 af79cd13be357-85adf5d26f1mr2228104385a.4.1759166857647; 
 Mon, 29 Sep 2025 10:27:37 -0700 (PDT)
Received: from d122205.iol.unh.edu ([2606:4100:3880:1220:4f6d:e2af:7f5f:4df])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-85c337a1c97sm838586585a.55.2025.09.29.10.27.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Sep 2025 10:27:37 -0700 (PDT)
From: Andrew Bailey <abailey@iol.unh.edu>
To: luca.vizzarro@arm.com
Cc: dev@dpdk.org, dmarx@iol.unh.edu, ivan.malov@arknetworks.am,
 probb@iol.unh.edu, Andrew Bailey <abailey@iol.unh.edu>
Subject: [PATCH v6 0/3] dts: add tx_offload support in dts
Date: Mon, 29 Sep 2025 13:27:31 -0400
Message-ID: <20250929172734.218467-1-abailey@iol.unh.edu>
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

Andrew Bailey (3):
  dts: allow mbuf_fast_free to be set with testpmd shell
  dts: add TX offload capabilities to NIC capabilities
  dts: update tx_offload test from old dts

 doc/api/dts/tests.TestSuite_rx_tx_offload.rst |   8 +
 dts/api/capabilities.py                       | 126 ++++++++--
 dts/api/testpmd/__init__.py                   | 157 +++++++++++-
 dts/api/testpmd/types.py                      | 227 +++++++++++++-----
 dts/framework/parser.py                       |  30 +++
 dts/framework/testbed_model/capability.py     | 109 +++++++--
 dts/tests/TestSuite_checksum_offload.py       |  10 +-
 dts/tests/TestSuite_pmd_buffer_scatter.py     |   4 +-
 dts/tests/TestSuite_rx_tx_offload.py          | 126 ++++++++++
 dts/tests/TestSuite_vlan.py                   |   4 +-
 10 files changed, 683 insertions(+), 118 deletions(-)
 create mode 100644 doc/api/dts/tests.TestSuite_rx_tx_offload.rst
 create mode 100644 dts/tests/TestSuite_rx_tx_offload.py

--
2.50.1

