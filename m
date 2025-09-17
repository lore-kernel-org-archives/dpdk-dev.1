Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B3A5CA0EE8
	for <dpdk-dev@archiver.kernel.org>; Wed, 17 Sep 2025 12:42:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8DE45402C3;
	Wed, 17 Sep 2025 14:42:57 +0200 (CEST)
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com
 [209.85.222.170])
 by mails.dpdk.org (Postfix) with ESMTP id F0FAC402A9
 for <dev@dpdk.org>; Wed, 17 Sep 2025 14:42:55 +0200 (CEST)
Received: by mail-qk1-f170.google.com with SMTP id
 af79cd13be357-8116af074e2so628677585a.0
 for <dev@dpdk.org>; Wed, 17 Sep 2025 05:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1758112975; x=1758717775; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tu5blZZOd2AuZgCjacaxX0A3mTgHjn4evfPTm1+qyu8=;
 b=OqngxHmvH0aLmoCGKx6hpu5mvM9waaW+0EkCEfBCARVSrYry/cwdBUypyRw7pOnc3g
 etxM8VwKbD1FsrDsM79eEcB+XTb/u9C7Os7kuD3wHdgkHLITmbvkiCCOOYiaxTjNA7wM
 aaxhGKf054gxv/JxNsZXJKJXKnDnN2pOk5xvU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758112975; x=1758717775;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tu5blZZOd2AuZgCjacaxX0A3mTgHjn4evfPTm1+qyu8=;
 b=TlV1+9TfQFzwzmdjfwh0W+UnvEXD9ZjivrHoHGOaj9SkZjt6Ep/JmcU9iT1IE2hfO3
 +KOzB6P+i7lNudt5RK6g6dWQlaWTOfwVBjuZrQKqZFqFzNuY/QFgwMdRQ93oy8rnuNJk
 kvyrLSCQzsbWPLAEg9QISEdQXyLw9Y7E17b6eElC/a4kMxOpNgMdpQ4uWyySF3lTQw1R
 nQoxCeDTSgNNHzZfTiAHjK7ZN/zejpqtTroOjLZuJtBYLpsQFBDICKKzsBuIg8Sn/KYa
 1EeeWYGzNhfIHftlj3DxCKKZPPQepMmsZr/xL2/ix6vF0OypIQbZXVA79TKnbgNW9YPG
 OMaw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXsbpuiUHe0FCeKrY56oaSUHzYQj83ntp8vm6v/EF5i8ypHpcNd2RGvOMrMN5zDGEiokeE=@dpdk.org
X-Gm-Message-State: AOJu0YzPpxf2WhDNdJdUFpVfhxWQVqndf+oRzGBUQcoM/PBh/2Bu/WDO
 Fd95n1NSiLLfio3NPGb12jHJ6xVob7wTf6SYOMTt5kdVRgrCq+L+AmYOGxLxvPBDHTGG1L4DS8r
 /uhBl
X-Gm-Gg: ASbGncs8y3X0uvxDoU4MW3yLPNoCoo3r9gE6RW1aJ8NoffqXd/mAQvWHpNeVOx9jer8
 xd9vdyq77eJUoEukT61Xcle2ampNjWMBX+larzHBWbPreY3GtnGpFqfgf+l2AsawJZezT5kM+mM
 fL6WCJ/l4plrseDardtHXIYdsQMS7nfFQVDWmYg83VPgSWQLZBvdXtk06MdZIw2UP1FF9a11S3h
 p6EmVo8v5oElkIoGBzvauKnv6RlSNnZ4TE4skYpjkiZ+4MYx/KAlSgjY7jEBHvpqkdv5RXV0Dhh
 ZL+Dy3Xe5G3LDSh+KmuexVTejp3jGy820XQTSXjhShF3RDqWWftgNDL58h76l9L44qUX5vLPDA8
 CDMQvEOoz23rTqrVHigay5TNXfXY1yDgBsAo=
X-Google-Smtp-Source: AGHT+IFAmeS/fO1vYEsBtfzBw0aEHP0Yymm4QCBMrga8S8HqSCE/3K51a4JyiFCKGRbjJ+PBjyoEeQ==
X-Received: by 2002:a05:620a:28d2:b0:826:2b73:c73b with SMTP id
 af79cd13be357-8311390f961mr205498785a.44.1758112975087; 
 Wed, 17 Sep 2025 05:42:55 -0700 (PDT)
Received: from d122205.iol.unh.edu ([2606:4100:3880:1220:4f6d:e2af:7f5f:4df])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-825abc11db2sm908046285a.45.2025.09.17.05.42.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Sep 2025 05:42:54 -0700 (PDT)
From: Andrew Bailey <abailey@iol.unh.edu>
To: luca.vizzarro@arm.com
Cc: abailey@iol.unh.edu, dev@dpdk.org, dmarx@iol.unh.edu, probb@iol.unh.edu,
 ivan.malov@arknetworks.am
Subject: [PATCH v3 0/3] dts: add tx_offload support in dts
Date: Wed, 17 Sep 2025 08:42:40 -0400
Message-ID: <20250917124243.31567-1-abailey@iol.unh.edu>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250902142725.56736-1-abailey@iol.unh.edu>
References: <20250902142725.56736-1-abailey@iol.unh.edu>
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

Andrew Bailey (3):
  dts: allow mbuf_fast_free to be set with testpmd shell
  dts: add TX offload capabilities to NIC capabilities
  dts: update tx_offload test from old dts

 dts/framework/parser.py                       |  30 +
 dts/framework/remote_session/testpmd_shell.py | 720 +++++++++++++++---
 dts/tests/TestSuite_checksum_offload.py       |  10 +-
 dts/tests/TestSuite_pmd_buffer_scatter.py     |   4 +-
 dts/tests/TestSuite_rx_tx_offload.py          | 130 ++++
 dts/tests/TestSuite_vlan.py                   |   4 +-
 6 files changed, 789 insertions(+), 109 deletions(-)
 create mode 100644 dts/tests/TestSuite_rx_tx_offload.py

--
2.50.1

