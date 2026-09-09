Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E060C79FB7
	for <dpdk-dev@archiver.kernel.org>; Wed,  9 Sep 2026 16:06:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0AE804067D;
	Wed,  9 Sep 2026 18:06:43 +0200 (CEST)
Received: from alln-iport-3.cisco.com (alln-iport-3.cisco.com [173.37.142.90])
 by mails.dpdk.org (Postfix) with ESMTP id A6A5F4067A;
 Wed,  9 Sep 2026 18:06:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cisco.com; i=@cisco.com; l=744; q=dns/txt;
 s=iport01; t=1788970001; x=1790179601;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=Dt8d3U7b3ppBDmB9KybX6H2vuVVXSjcs4mPteUq4Meg=;
 b=Olw8ThpnaQuOo+PPeHTy4+mUURQux3ElRK4eLM5QuLiOR8zLEflkSwOD
 uAMCDXXbDUHipr4knOkg7IdE3S1AAk3JDRV+qxQn91hDeo37pC64wBnqw
 RHdsYoOmAItHLjZX20KrPpcqqDPDT5hBl3+naaGDHK/AJqgzV4vCHu35y
 tuogqB98w9prRFSn8dy/WJCBCy+y2qf6uXMnmjLAIt9EL7MFzXSLA4vJP
 tX/Xpnvwl5yg4qzce8S5CGN5dOI9v5XcXGIu5rddseXpMFTN5pbjXmCV0
 ppGAokKrK2XUHkAQwZ5qlviHufi1vbaceCe+kwyDDCdJsx7x3rw5W8DtJ w==;
X-CSE-ConnectionGUID: jzzGp4h7QuGMWqmhqQ0BVQ==
X-CSE-MsgGUID: t4qxfQgDQrmSLmiHq7vaTw==
X-IPAS-Result: =?us-ascii?q?A0A5AACBg6Fq/5EQJK1aHQEBAQEJARIBBQUBgXwIAQsBg?=
 =?us-ascii?q?heCFEKNO6d2gX4PAQEBD1EEAQGFBY4GAiY0CQ4BAgQDAgMBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEKAQEFAQEBAgEHBYEOE4ZckBU2AUaDeliCdQPBf4IsgQHeRoFzFYE4AY1gd?=
 =?us-ascii?q?oR8JxUGgUlEig6FeASDHBKUKkiBHgNZLAFVEw0KCwcFgWYDNRIqFW4yHYEjP?=
 =?us-ascii?q?heBBxsGBYEdgSeDPyMZNnqBCV6BKylgARIXgQeCCAKCVIIBAgFJQw4HRVMJJ?=
 =?us-ascii?q?0EKElMmCxgNSBEsNxUZBD5uB5IXgQ9LgUhExwWEKKFcGjOqbZkIpFqEaYFoP?=
 =?us-ascii?q?IFZTSMVgyNSGQ+OKxnQFShyAQEHAgcOAwuBaJF+AQE?=
IronPort-Data: A9a23:org6O6+3IBWIBpFICNJxDrUDF3+TJUtcMsCJ2f8bNWPcYEJGY0x3z
 WRNCzyOOPmPMWrycoh0Ydzg8xgFvsXRz95kGwBk/CxEQiMRo6IpJzg2wmQcns+2BpeeJK6yx
 5xGMrEsFOhtEDmB4E/rbei5xZVF/fngbqLmD+LZMTxGSwZhSSMw4TpugOdRbrRA2bBVOCvT/
 4mvyyHjEAX9gWAsYzpFs/nrRC5H5ZwehhtJ5jTSWtgT1LPuvyF9JI4SI6i3M0z5TuF8dsamR
 /zOxa2O5WjQ+REgELuNyt4XpWVTH9Y+lSDX4pZnc/DKbipq/0Te4Y5nXBYoUnq7vh3S9zxHJ
 HqhgrTrIeshFvWkdO3wyHC0GQkmVUFN0OevzXRSLaV/wmWeG0YAzcmCA2k0L5834rp3XlhT2
 tknMTUNdynbrdyPlefTpulE3qzPLeHiOIcZ/3UlxjbDALN+EdbIQr7B4plT2zJYasJmRKmFI
 ZFHL2MxKk2cPnWjOX9PYH46tP20h3LyWzZZs1mS46Ew5gA/ySQhjeO0YIGOKoTiqcN9ghqBt
 mz/8EjAGBQhENme6SPa7HuQmbqa9c/8cMdIfFGizdZmjUO7ynQfC1sRT1TTieKlg0S6VvpTM
 0AXvC00osAa9E+iSsP0dxixumCJuhpaUN1Ve8U56RuEzKnJ5g+DBUABRyRfZdgi8sQxQFQC0
 FOAldLtHSF1ubi9THuH6LqQqXW5Pi19BXcIZSYLRBUM/8Tnqak2hwjRQ9JnVqWyi7XdAzvwy
 jaRpSw/r7Aal9AG06H99lfC6xq3pZ/TTyYw7x/JU2ahqAh+YeaNfI+v9VXA7elJNq6cR0Ofs
 XwA3cOZ6YgmFo2NkzCRR+MlGbiz+fuBNHvXhlsHN4Uh8DGk4FameoZS6TV5IgFvP9psRNPyS
 EbXvQUU4NpYO2GnKPcnJYmwEM8ti6PnELwJS8zpUzaHWbApHCfvwc2kTRX4M7zF+KT0rZwCB
 A==
IronPort-HdrOrdr: A9a23:3zHIKKn15bFECttCqkXpEEDlRLXpDfIY3DAbv31ZSRFFG/FwWf
 rDoB19726XtN9/Yh8dcLy7UpVoIkmslqKdn7NxAV7KZmCP01dAR7sM0WKN+VDd8lXFltJ15O
 NHb7V0DsH2ABxRiMb35xT9LvMbqeP3lZxBQYzlvhBQpcYAUdAF0ztE
X-Talos-CUID: 9a23:MtU4hmxhzJCz8NPIVCB3BgUWCNIKaiHdk07NDGqHEGNpUYTNY2GprfY=
X-Talos-MUID: 9a23:/jNFtQjzcY4+EqqZPR0cP8MpKJtx86qXB2w0i5A9n8yFFTUvJT6hk2Hi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.25,270,1779148800"; d="scan'208";a="853183380"
Received: from alln-l-core-08.cisco.com ([173.36.16.145])
 by alln-iport-3.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 09 Sep 2026 16:06:39 +0000
Received: from rtp-orb-10405.cisco.com (rtp-orb-10405.cisco.com [64.100.22.53])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by alln-l-core-08.cisco.com (Postfix) with ESMTPS id B88C318000443;
 Wed,  9 Sep 2026 16:06:38 +0000 (GMT)
From: Randy L Tice <rtice@cisco.com>
To: dev@dpdk.org
Cc: stable@dpdk.org, thomas@monjalon.net, pbhagavatula@marvell.com,
 sthotton@marvell.com, ndabilpuram@marvell.com, kirankumark@marvell.com,
 skori@marvell.com, skoteshwar@marvell.com, hkalra@marvell.com,
 rbhansali@marvell.com, Randy L Tice <rtice@cisco.com>
Subject: [PATCH 0/1] Fix CN20K mbuf size truncation
Date: Wed,  9 Sep 2026 12:06:36 -0400
Message-Id: <20260909160637.3607104-1-rtice@cisco.com>
X-Mailer: git-send-email 2.35.6
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Outbound-Client-TLS: ANONYMOUS; rtp-orb-10405.cisco.com [64.100.22.53];
 TLSv1.3; TLS_AES_256_GCM_SHA384; 256
X-Outbound-SMTP-Client: 64.100.22.53, rtp-orb-10405.cisco.com
X-Outbound-Node: alln-l-core-08.cisco.com
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

This small fix prepares the CN20K inline security receive paths for mbuf
layouts larger than 255 bytes.

The affected code recovers a packet mbuf by subtracting the size of
struct rte_mbuf from a pointer stored in completion metadata. Keeping
that size in an 8-bit local variable makes the recovery sensitive to
future mbuf layout growth. The patch widens the local size variable
without changing the surrounding fast-path logic.

The issue was found while preparing an unrelated mbuf layout extension.

Randy L Tice (1):
  drivers: fix CN20K mbuf size truncation

 .mailmap                          | 1 +
 drivers/event/cnxk/cn20k_worker.h | 4 ++--
 drivers/net/cnxk/cn20k_rx.h       | 4 ++--
 3 files changed, 5 insertions(+), 4 deletions(-)

-- 
2.35.6
