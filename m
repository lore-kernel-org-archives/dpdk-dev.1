Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AFE8CCD1BF
	for <dpdk-dev@archiver.kernel.org>; Thu, 23 Oct 2025 12:14:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 585D8402D0;
	Thu, 23 Oct 2025 14:14:27 +0200 (CEST)
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
 by mails.dpdk.org (Postfix) with ESMTP id E629F402C3
 for <dev@dpdk.org>; Thu, 23 Oct 2025 14:14:24 +0200 (CEST)
X-QQ-mid: esmtpgz12t1761221659tca1ae6d8
X-QQ-Originating-IP: 2/NrsSekqrwyVFRZd3hS231hI9BPtAdpjA+c50zYpzA=
Received: from DSK-zaiyuwang.trustnetic.com ( [60.186.187.129])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Thu, 23 Oct 2025 20:14:17 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 709148327519139664
EX-QQ-RecipientCnt: 2
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>
Subject: [PATCH 0/6] net/txgbe: fill in functionality gaps for Amber-Lite NICs
Date: Thu, 23 Oct 2025 20:13:49 +0800
Message-Id: <20251023121356.21944-1-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz5a-1
X-QQ-XMAILINFO: ND42uzdxTIzr6aJI2jADJF0sJB5Cglti7iJqkY7UWPodKDeyvH1tbvnm
 5TYVUip6FhEB0AL+8XYFL5mA4ALJU7MurjghKtXmAmRcwp3OvwWHLnA0dxq0OfiGYodFx9/
 ecWsbRgePmwT+nAID0Y3CkChTvdWH6hiCFab1mLb9BZmcubI2fpo1lDbolEvjKyVwSOjOiz
 q/dpJPGOphA/tvNHRRs8Mlappgrdpjrs7fbzZ4krAZHm1HqKnckLg5PNyZpVr8r/Vdmn0A+
 57+Ga5vjkCj8Dl1NxlLOXzbdxqL/mBBNDiddaVliSAifkWP8o5UR8+Ac54wDnlEQjCO8jRP
 EPkNfq90c1S2ZoClYsWU0z96NagSz7cGiy7yqhAIjxQieATxMd5lejUMVq8bhKn+fMZgVlt
 2ChrWbmtsh4ZEHBwfe+leiHZCK4z1P4tpS1CstAxlysiYvPAL4hXb6mn7MIa2PYri1augPa
 gofQmD5TBbbqxMaz2i5dnUO5ycsNAZe/D1B1IU3B0u/lH2E0rK2KilZ0exMeSMBAhW7YdSb
 9/xNwEfhb84vsjzctSX6lWrxSr/AMRGcq/2J8klLilYEJbedAe7YyUCGrDgnM+TMbFa6d4b
 SE/t9bbCqKG85LFjhdpu2joFGFZxTEslfF51Pd8Z/nWemSoxBAe2fR00SalqoqEDEHDMsPZ
 riue+mKHCKbe24s74cUbh1g7kf7HOLxqaVfkm37W1l11V28n2CcfiHqbvt1upQB7KwzD/F7
 PvIF3WSY7stAlTzSBfNL2BtVvqZXXrsz9h87J+uaL+l6wSAKZFh9MEkBtD3BNLyqORGJTmn
 AhEt1IwZx6vWwHNyJYTvYrMEs7AaIKpddUgnLZe2xEjY28BsRnDgHSBqQVmDe3sudz+KUJN
 Nhj3uC6BWh2IJdfrB+1JeYwSep2AiB/JrUdTlZgPDjt9mXgmrrhdjy+It9riwvTJvrjhc24
 rp7dC7QsK6nQ8Ushqm3wOyhvOzM3EvGDf4PXnXd1t0JPhxstmigtxMQaz64tTqq6Qwt0zRh
 3eJvL91K7aWZ7Xdv4rN6j+e+kmgbA=
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
X-QQ-RECHKSPAM: 0
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

This patchset adds missing functionality for Amber-Lite NICs in the txgbe driver,
addressing previously overlooked features to improve support for these devices,
particularly for the VF.

Zaiyu Wang (6):
  net/txgbe: add Amber-Lite 25G VF IDs to PCI ID map
  net/txgbe: add flush operation for Amber-Lite NICs
  net/txgbe: add RSS register selection for Amber-Lite 25G VF
  net/txgbe: add BME reset for Amber-Lite 25G VF
  net/txgbe: add check link for Amber-Lite VF
  net/txgbe: add PF-triggered VF link status change handling

 drivers/net/txgbe/base/txgbe_mbx.h  |  2 +
 drivers/net/txgbe/base/txgbe_regs.h | 16 +++++-
 drivers/net/txgbe/base/txgbe_vf.c   | 52 ++++++++++++-----
 drivers/net/txgbe/txgbe_ethdev_vf.c | 87 +++++++++++++++++++++++++++--
 4 files changed, 136 insertions(+), 21 deletions(-)

-- 
2.21.0.windows.1

