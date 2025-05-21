Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02737C54E71
	for <dpdk-dev@archiver.kernel.org>; Wed, 21 May 2025 14:02:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 28CBC427D5;
	Wed, 21 May 2025 16:02:43 +0200 (CEST)
Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com
 [99.78.197.217]) by mails.dpdk.org (Postfix) with ESMTP id 11DB24028F
 for <dev@dpdk.org>; Wed, 21 May 2025 16:02:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1747836161; x=1779372161;
 h=from:to:cc:subject:date:message-id:mime-version;
 bh=QdhWlNB2f6khDIl+XtwUMqUQi9c8pZ3bwUgxYMcZTvE=;
 b=cgCXVSoGbb5EMPvhonSlRXNlKQPJdpi7eIJ9NcKHkoFZkb2ftm3sYBKj
 kUx2Kt86dsRc65LKaY0L7f0DwvJTHI+RKxH9YxztLMt+aAVrke1/GOidi
 rw0Ifjp+i8E+Vje8mL+iufRy1SqeTcGL2cyNzpzJrdGNzN2xUlg73mAK8
 J+TkAH4LdsM+e1KsQ5y8C+Jrg/3IFxT4EIr359o5+L9qlgRhmjySLbp8j
 MrhqyDFVwITHHqLslPOdpogmUaxTjSt11hnjc1jZXd6B4RLrrjPzfXOdc
 AqEu4v/PcRFwNjQiQHVpm1Vz6zuCE0pd7Kn7/ymaoYRyhpU0GvGVeRWj5 Q==;
X-IronPort-AV: E=Sophos;i="6.15,303,1739836800"; d="scan'208";a="52422188"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO
 smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.25.36.214])
 by smtp-border-fw-80006.pdx80.corp.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2025 14:02:37 +0000
Received: from EX19MTAEUB001.ant.amazon.com [10.0.43.254:8504]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.39.182:2525]
 with esmtp (Farcaster)
 id ff571c94-9afb-449c-964e-2af174f0b802; Wed, 21 May 2025 14:02:36 +0000 (UTC)
X-Farcaster-Flow-ID: ff571c94-9afb-449c-964e-2af174f0b802
Received: from EX19D007EUA002.ant.amazon.com (10.252.50.68) by
 EX19MTAEUB001.ant.amazon.com (10.252.51.26) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 21 May 2025 14:02:35 +0000
Received: from HFA15-CG15235BS.amazon.com (10.106.83.30) by
 EX19D007EUA002.ant.amazon.com (10.252.50.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 21 May 2025 14:02:33 +0000
From: Shai Brandes <shaibran@amazon.com>
To: <stephen@networkplumber.org>
CC: <dev@dpdk.org>, Shai Brandes <shaibran@amazon.com>
Subject: [PATCH 0/8] net/ena: release 2.13.0
Date: Wed, 21 May 2025 17:02:05 +0300
Message-ID: <20250521140213.2576-1-shaibran@amazon.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.106.83.30]
X-ClientProxiedBy: EX19D042UWA003.ant.amazon.com (10.13.139.44) To
 EX19D007EUA002.ant.amazon.com (10.252.50.68)
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

This patchset includes an upgrade of the ENA HAL,
introduces a new feature, and addresses three bug fixes.

Thank you in advance to the net maintainers and community members
for your time and effort reviewing the code.

Best regards,
Shai Brandes
AWS Elastic Network Adapter team

Shai Brandes (8):
  net/ena/base: avoid recalculating desc per entry
  net/ena/base: coding style changes
  net/ena: separate doorbell logic for Rx and Tx
  net/ena: support fragment bypass mode
  net/ena: fix unhandled interrupt config failure
  net/ena: fix aenq timeout with low poll interval
  net/ena: fix virtual address calc for unaligned BARs
  net/ena: upgrade driver version to 2.13.0

 doc/guides/nics/ena.rst                       |  13 +-
 doc/guides/rel_notes/release_25_07.rst        |  10 ++
 drivers/net/ena/base/ena_com.c                |  39 +++++-
 drivers/net/ena/base/ena_com.h                |   8 ++
 .../net/ena/base/ena_defs/ena_admin_defs.h    |  15 +++
 drivers/net/ena/base/ena_eth_com.c            |   6 +-
 drivers/net/ena/base/ena_eth_com.h            |  15 ++-
 drivers/net/ena/ena_ethdev.c                  | 112 ++++++++++++++----
 drivers/net/ena/ena_ethdev.h                  |   9 +-
 9 files changed, 194 insertions(+), 33 deletions(-)

-- 
2.17.1

