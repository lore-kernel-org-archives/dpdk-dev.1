Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98810C43458
	for <dpdk-dev@archiver.kernel.org>; Mon, 29 Jun 2026 06:19:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 882DC40299;
	Mon, 29 Jun 2026 08:19:26 +0200 (CEST)
Received: from out162-62-57-137.mail.qq.com (out162-62-57-137.mail.qq.com
 [162.62.57.137])
 by mails.dpdk.org (Postfix) with UTF8SMTP id 64FC84021F
 for <dev@dpdk.org>; Mon, 29 Jun 2026 08:19:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1782713961; bh=yF2u/mHbSqp+RPweuPVS4NocE45Wv3fiNUgF89WJLag=;
 h=From:To:Cc:Subject:Date;
 b=C0kJuijdo8yvtgXxA7MJ0A8FESF7XKPFSQjGOCH16SDiu6hX0qBpVQPYhWhD7+QoS
 I4iebBffvPXWNtC3zEHjn+lfVaL5PEcPFqnKCsjtW/iGUIa259+hkyh+3piWlS1h/I
 RER+9faNP3bBF5OMg6s22rFkmpiVraakMEhp/G8I=
Received: from fedora.tail0f0cf3.ts.net ([139.159.170.83])
 by newxmesmtplogicsvrsza63-0.qq.com (NewEsmtp) with SMTP
 id 4D416624; Mon, 29 Jun 2026 14:19:20 +0800
X-QQ-mid: xmsmtpt1782713960thqz5reid
Message-ID: <tencent_903B8080FAF1650B6FCB3653CE05CBC55F09@qq.com>
X-QQ-XMAILINFO: N/tkE0oBJLbnpMxKgl8DS3sv2Qa7NP3OY80JE1EK2K3e6swxL4nEUgfjGE2QnR
 fkS4nDTGUiiJYZWi6otQFXkvNqTBGrDAfnS0Gm2b0y0/uam8nd07AvnTwi5cUrkvEi39egDKkDUo
 BgJF8mO1p3s5zJQW1c+Z/1YhQQRPq/jvKS8/6pJ5V74okVJY9cwdC2jfQVb5dewYs8pxI/NcMa+i
 3NA+5K3/zIqgn+UU0x2ZL0kkyHbPyx3XIqFNdpM/nJ29MgFdT+cF3rJmB5eLwOlBPDNsOdZkHvmp
 8eB9c+b/XIkcUERMVYhr7ZzCyrrLX5aOozGRbvSXMOFrwBAbABBJC2Of4QtojCKaOjwFyTlJ2IJ4
 M6yBHC0W7bP/45bK1p2s/Ooc3R56Zxl9VV3qi3fBNjLc0QgDnlOamAkzs60aWGZORleRDapliSRR
 jP69Ho4gBM5+PJGiNRMe2aqN8AXPyJ1RHSG/qWcfcHEauMUNNcWmB+kLwJhxcg6Jxc62TzEJ3xfu
 3l79cfb53viLjarXx/hphgQidlu9/45UoQ2o5aZ6asIgp3Rgo6wish2bzoqI/6siRpa64AwN2TlF
 9M52S0eELXCuaa49IpcfXUl6lvAsA/m3wSFJzUEllZBmkEu1PO1a711dXwYxCecvugqp9Ld8UQUM
 87khxg3qW3axYSVaqg0PRXxZVT7TteUnSEhcwGecBTFbLt0/X3E3erfdJ2vh3Jx9Pe0Qb4vXY+lO
 o3wPlXScEmtsu/O80aVdJiTpYj0kP8xArcWKM/LMCuVB4GxhypXqAtwnaY3bFETkOjcUDlUJ5/TB
 I5KYIpJxeYbgcAJ7m22bOy9d8loXAZIcdTbqbSUYb0BIB6wRpT3I2ElUVYTk+SPFCQhvrixwSCdI
 pzi4iJxaDTUVSnxvOsHuiu8Ye5cK5iATpZAawDLs7xJSVZalQERPbhn36JiyXdNnBEvuq2Aem5ZY
 97RKORYIETIkNJKKkWbXCRJmA0pKVIV6UgrkEeOTeRNM3pXeUxwaM+UxfQZ/+4F2AMStoq3T8Unm
 cDCq3mF8wH19B+7bJHybbUxJPli7nenfXS1dkmJW8ONHCCWNLNgVrjyLqNibPNRXljP+BxJm1Yxt
 yVWX6Z/lveFm4imTs=
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
From: datshan@qq.com
To: thomas@monjalon.net
Cc: dev@dpdk.org
Subject: [PATCH 0/2] fix dmadev incomplete ABI validation
Date: Mon, 29 Jun 2026 14:19:15 +0800
X-OQ-MSGID: <20260629061917.321374-1-datshan@qq.com>
X-Mailer: git-send-email 2.54.0
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

From: datshan <datshan@qq.com>

Fix dmadev incomplete ABI validation.

Chengwen Feng (2):
  dmadev: fix incomplete configuration validation
  test/dmadev: add config and vchan validation tests

 app/test/test_dmadev_api.c | 186 ++++++++++++++++++++++++++++++++++---
 lib/dmadev/rte_dmadev.c    | 156 +++++++++++++++++++++----------
 2 files changed, 283 insertions(+), 59 deletions(-)

-- 
2.54.0

