Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F6A9D3CC86
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Jan 2026 22:25:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3A2C240DF5;
	Wed, 14 Jan 2026 23:25:06 +0100 (CET)
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com
 [209.85.128.68]) by mails.dpdk.org (Postfix) with ESMTP id 488A54027D
 for <dev@dpdk.org>; Wed, 14 Jan 2026 23:25:04 +0100 (CET)
Received: by mail-wm1-f68.google.com with SMTP id
 5b1f17b1804b1-4779aa4f928so3165095e9.1
 for <dev@dpdk.org>; Wed, 14 Jan 2026 14:25:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768429504;
 x=1769034304; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=IGlFXT6diRUkPSs0APJR6kixqbqhZSsAkUCGM6e0d/4=;
 b=T8hLhFc6UTkRGtWbrfksnX4GbXF7uiuGQ9Gjwrm29y6MP7bqR0NwRZLwqxcZMUSOO+
 v+qD3H3FNn1TqSBc/7pXh0DR1NCxBGrQMVk3wOQLaiwqqE5+S1+MYhVIDRFKkP+mFlIu
 b//j7PGVEX0AZ2hkvqQutZhMCIOB0gPR80ZLsMpcBLQznPPa9S/BZEg3W1NBTtO6a1js
 KZ+aIKdBWo3dp37X38xWRkh8NMYZDDfGqykmKCUl8L1HpI8iIr0eYgCTfYhWkKNk3tYd
 beuRjAB+CG6DLL7doq/16952XGeKvXQs3cVim/pqANOa2R0i86MTLNw7lDPjwbfSuWvf
 onoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768429504; x=1769034304;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IGlFXT6diRUkPSs0APJR6kixqbqhZSsAkUCGM6e0d/4=;
 b=UEnqupM9uu+eAmOSYdEpmvkCeRGxdtSn4FnCtKtc9yh+3mcUZNcl4jjlUOuBq9TP2n
 nijfFZTDljMPoRWjSleBFDJfZ9+rv88VnJqsOCpP0vjvFaNGy3VEf4QmP1ICP6nhxDHp
 JZ7TvdkqhZxQCEnffUkChZzgpd+D1wVIriu3YO1J9EMTiOUDl7SQY2xe4xsbaa8m9AfS
 6VU9k5qlj1UHfYiS+M2YZJNg4v2sTVdnqzPpLg1+LfTezk7C2a13CEWP6IYVqWG4f4Vi
 GNP64TR/wvkIFdl7d/arTkXzSDGa+EwPXN5sXX5T8ZNPF6sBe7nguBOXQ5DQcKQUqbc/
 T67A==
X-Gm-Message-State: AOJu0YwOKpJOXIJ8Cnq/nXKHw4Uq+SnXyUnamH5G1cUtTK2V5oieMt7s
 MNGuJRvFXCbiXbnoGiYWILUVB4+u+25uU1IFLbb3yPKQxqAWACkuuBQcjDAJsGZbGXXia/zJ0li
 Tbjs7P5U=
X-Gm-Gg: AY/fxX4EsZGbF4R24QaGAehlX3yrNABj/SvovTzK/QE/arXmfPim4i8Q2N8DaGSBsYh
 4yzbcpSh55+pG2qAXt+YdZPVR7qvKTa6BcjNsY6hzy127kAVF5lQo+IpENXxpecDybZBkcnk+AA
 HdGS4tHwqsVvkONaeAcwS+vRVH4t4QyQTpXrFeXQKZeNRFQ0KcXKS3gDa8ugfVAgpPY11TQ2Icq
 uunqxK+xEg/NQLdomTw9mMXRx9ZtOom24SqI7trdBS/ddoqeAdjJQ33pJDuAzbdG0cTsjLUqhb5
 GF1fGtB1iB/xjpdrO7z57Uelysvswd0PtKKW+UvGkUhcV2E6whqgUctSpw98cgFH1tGXGpDgJvs
 2CF2fGvY5mhx1gXGp0OksfUFZLaRKc5b4OI4m9wscMVzIzAKxWS6/qHK9YuyddRC6bqyJOXEcDu
 q9LeXUUXrN1vJwfytoj34jLzFY/ary4g7T1NWhCPQG21EBKN9APQ==
X-Received: by 2002:a05:600c:c16a:b0:477:1af2:f40a with SMTP id
 5b1f17b1804b1-47ee334d0aemr56817855e9.17.1768429503194; 
 Wed, 14 Jan 2026 14:25:03 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47f42907141sm12040355e9.9.2026.01.14.14.25.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Jan 2026 14:25:02 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH 00/29] doc/guides: sample application documentation
 improvements
Date: Wed, 14 Jan 2026 14:21:41 -0800
Message-ID: <20260114222458.87119-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
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

This series addresses grammar, clarity, consistency, and structural
issues across DPDK sample application documentation guides.
Initial work was done by tech writer Nandini but never merged;
picked those up and added AI grammar and style review fixes.
Looks much better and consistent now.

The changes include:

Capitalization fixes:
  - "linux" to "Linux" per DPDK style guidelines
  - "Qemu" to "QEMU"
  - Consistent use of VMDq, vDPA, DCB terminology

Grammar and clarity:
  - Adding missing articles ("a", "the", "an")
  - Fixing incomplete sentences
  - Correcting subject-verb agreement
  - Fixing typos (e.g., "Keep- Alive" to "Keep-Alive")

Formatting consistency:
  - Adding proper RST code formatting with double backticks
  - Standardizing section headers with "Overview" sections
  - Using consistent command-line option formatting

Style improvements:
  - Replacing contractions with full forms
  - Adding Oxford commas where appropriate
  - Removing outdated trademark symbols

Content fixes:
  - Fixed duplicate "srTCM" entries to show correct "trTCM" options
    in QoS metering documentation
  - Completed truncated phrase "and also on the main" to
    "and also on the main lcore" in timer documentation

The following sample application guides are updated:
  - timer
  - packet_ordering
  - service_cores
  - rxtx_callbacks
  - skeleton
  - l2_forward_crypto
  - l2_forward_event
  - qos_metering
  - qos_scheduler
  - vmdq_forwarding
  - vmdq_dcb_forwarding
  - vhost
  - vhost_blk
  - vhost_crypto
  - ptpclient
  - vdpa
  - cmd_line
  - dma
  - fips_validation
  - hello_world
  - intro
  - ip_pipeline
  - ipsec_secgw
  - l3_forward
  - multi_process
  - vm_power_management
  - keep_alive

Stephen Hemminger (29):
  examples/timer: correct documentation errors
  examples/packet_ordering: correct documentation errors
  examples/service_cores: correct documentation errors
  examples/rxtx_callbacks: correct documentation errors
  examples/ip_fragmentation: correct documentation errors
  examples/eventdev_pipeline: correct documentation errors
  doc/guides: improve VMDq sample application documentation
  examples/distributor: correct documentation errors
  examples/ipv4_multicast: correct documentation typo
  examples/test_pipeline: correct documentation errors
  examples/qos: improve sample application documentation
  examples/vhost: improve sample application documentation
  examples/ptpclient: improve sample application documentation
  doc/guides: improve vDPA sample application guide
  doc/guides: improve command line sample app guide
  doc/guides: improve DMA sample app guide
  doc/guides: improve FIPS validation sample app guide
  doc/guides: improve Hello World sample app guide
  doc/guides: improve sample applications introduction
  doc/guides: improve IP pipeline sample app guide
  doc/guides: improve IP reassembly sample app guide
  doc/guides: improve IPsec security gateway guide
  doc/guides: improve link status interrupt sample app guide
  doc/guides: improve multi-process sample app guide
  doc/guides: improve pipeline sample app guide
  doc/guides: improve VM power management sample app guide
  doc/guides: improve keep alive sample app guide
  fix ipsec gw
  fix pipeline

 doc/guides/sample_app_ug/cmd_line.rst         |  20 +-
 doc/guides/sample_app_ug/dist_app.rst         |  30 +--
 doc/guides/sample_app_ug/dma.rst              | 104 ++++-----
 .../sample_app_ug/eventdev_pipeline.rst       |  22 +-
 doc/guides/sample_app_ug/fips_validation.rst  | 117 +++++-----
 doc/guides/sample_app_ug/hello_world.rst      |  10 +-
 doc/guides/sample_app_ug/intro.rst            |  54 ++---
 doc/guides/sample_app_ug/ip_frag.rst          |   4 +-
 doc/guides/sample_app_ug/ip_pipeline.rst      |  18 +-
 doc/guides/sample_app_ug/ip_reassembly.rst    |  12 +-
 doc/guides/sample_app_ug/ipsec_secgw.rst      |  92 ++++----
 doc/guides/sample_app_ug/ipv4_multicast.rst   |   2 +-
 doc/guides/sample_app_ug/keep_alive.rst       |   8 +-
 doc/guides/sample_app_ug/link_status_intr.rst |   6 +-
 doc/guides/sample_app_ug/multi_process.rst    |  27 +--
 doc/guides/sample_app_ug/packet_ordering.rst  |  23 +-
 doc/guides/sample_app_ug/pipeline.rst         |  10 +-
 doc/guides/sample_app_ug/ptpclient.rst        | 139 ++++++------
 doc/guides/sample_app_ug/qos_metering.rst     |  95 ++++----
 doc/guides/sample_app_ug/qos_scheduler.rst    | 214 +++++++++---------
 doc/guides/sample_app_ug/rxtx_callbacks.rst   |   7 +-
 doc/guides/sample_app_ug/service_cores.rst    |  41 ++--
 doc/guides/sample_app_ug/test_pipeline.rst    |   2 +-
 doc/guides/sample_app_ug/timer.rst            |  45 ++--
 doc/guides/sample_app_ug/vdpa.rst             |  71 +++---
 doc/guides/sample_app_ug/vhost.rst            | 185 +++++++--------
 doc/guides/sample_app_ug/vhost_blk.rst        |  58 ++---
 doc/guides/sample_app_ug/vhost_crypto.rst     |  94 ++++----
 .../sample_app_ug/vm_power_management.rst     | 138 ++++++-----
 .../sample_app_ug/vmdq_dcb_forwarding.rst     | 193 ++++++++++------
 doc/guides/sample_app_ug/vmdq_forwarding.rst  | 144 +++++++-----
 31 files changed, 1050 insertions(+), 935 deletions(-)

-- 
2.51.0

