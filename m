Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C61B7CCF9E0
	for <dpdk-dev@archiver.kernel.org>; Tue, 28 Oct 2025 12:22:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8D666402D7;
	Tue, 28 Oct 2025 13:22:52 +0100 (CET)
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com
 [209.85.219.46]) by mails.dpdk.org (Postfix) with ESMTP id 3306B4021E
 for <dev@dpdk.org>; Tue, 28 Oct 2025 13:22:51 +0100 (CET)
Received: by mail-qv1-f46.google.com with SMTP id
 6a1803df08f44-87dfd3c24ddso87560456d6.0
 for <dev@dpdk.org>; Tue, 28 Oct 2025 05:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1761654170; x=1762258970; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5nu/uCmQw/IocyPFAJC6dq6pMAr1WxA+js92fINIsMs=;
 b=DWMDNj/5rxwUp64jkYJtOtfl8xzxo7efK/Zue6wIL3QvkZy+wXxHyqRwTPBfcz/2MZ
 uxhyLTTZmTCBGGbZdcSF5ooRTGIfNTCW7XyJI90S8hUiXdn+rghc9gOANxw+gr1Njjbq
 pVpX8mpQHOlL3SBjquKZW8Q3uCjgpiQetqN3U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761654170; x=1762258970;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5nu/uCmQw/IocyPFAJC6dq6pMAr1WxA+js92fINIsMs=;
 b=vXho8oJQIZg48fqZ64zK8GXxuJRWJeBarOeF8m5m0g505RcmN2OUqepxctO8UCQGSQ
 Ez2XGnLXAUt6ld3MaUQDz8olNa3skCdqMjS47fvDb5PSHI0lNfdd3SXe2DnbjlOeEewx
 558EWUqUYAuUPPS+21R/lp/l8j4QSNGeZtZKxQKvNGELXZ4R23mLS9Vpz/6ODermet0V
 hR1nW8ai78RBKbG4W2uhwIEcbQCPj+2Mgj+CXlkE190Z9AgZldY6CBWdLITn2sSjuWMS
 tGI5Sykm3fyOef1G4CjbHDfSfHTGqxIZB31/VrKFpd18k3lR3r/a/CWuCalbvjXN15Rl
 Rrpg==
X-Gm-Message-State: AOJu0YwawNLRMllJJnwdYpTQri8tWQbXf3StV5H1yxdlN9USajVadf+L
 PbxiWk9xBEOrdX8tsWvko9swemdju7cYWvRH5Ed2VoYpfxX/mwSONb4v+PNZaPZu36s=
X-Gm-Gg: ASbGncteuT7HLpLAinhkUZIf7gd9ayqLdDGE+qTisN+JxONPVGKRzXQ48fVPfPTAjSM
 Iv1Qd0OuWLstHHdgM9XzEMG82UqL5GW2JUNNts3L2JnJNrfxSizBfabMbfI/zOiZT9WRfvi2zv4
 QdKQ2jv+BfA5CvqL/mXejbMAwCMapP1tqg49YCWgPFIAxB0iwLDsvDgRXQoI3xuxfkyL4eX/ZLw
 MOICoykx15PuJYxWGiUtuaIDU6pGXC+3R2yDK9yoplroJEI5ztHQwYuh3H7jnSeKQBLV507/yjF
 EjH/Nv3YmyuDI60fr1sxphUQ6YzLAez8QiWU5F87OGbFcN6FHewib87wMAqtmMJ3HZz0to+S3CL
 0sqITIbd0iOJStJKvPeMe2UiES6bmIlGFzVw2fel4WsIqr1s+vh4FhesXF52H0gXBVDTR0dGNv6
 i6eWtk8Nf1UGgu
X-Google-Smtp-Source: AGHT+IGTVBdzFrVtrObAHXwxfNfqAuEEJxuxusjzMMHBODzF7FgiGUhNS1gFaiYs5+/ut3zHkJoA+g==
X-Received: by 2002:a05:6214:1c4c:b0:87f:bb8e:410b with SMTP id
 6a1803df08f44-87ffaff9100mr40400566d6.3.1761654170393; 
 Tue, 28 Oct 2025 05:22:50 -0700 (PDT)
Received: from d122205.iol.unh.edu ([2606:4100:3880:1220:4f6d:e2af:7f5f:4df])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-87fc4969008sm75450306d6.42.2025.10.28.05.22.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Oct 2025 05:22:49 -0700 (PDT)
From: Andrew Bailey <abailey@iol.unh.edu>
To: probb@iol.unh.edu
Cc: dev@dpdk.org, luca.vizzarro@arm.com, dmarx@iol.unh.edu,
 Andrew Bailey <abailey@iol.unh.edu>
Subject: [PATCH v11 0/3] dts: add Tx offload support in dts
Date: Tue, 28 Oct 2025 08:22:37 -0400
Message-ID: <20251028122240.112773-1-abailey@iol.unh.edu>
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
 dts/tests/TestSuite_rx_tx_offload.py          | 134 +++++++++++
 dts/tests/TestSuite_vlan.py                   |   4 +-
 10 files changed, 691 insertions(+), 118 deletions(-)
 create mode 100644 doc/api/dts/tests.TestSuite_rx_tx_offload.rst
 create mode 100644 dts/tests/TestSuite_rx_tx_offload.py

--
2.50.1

