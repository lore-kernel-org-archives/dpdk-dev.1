Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24CBFC43458
	for <dpdk-dev@archiver.kernel.org>; Tue, 30 Jun 2026 13:24:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BAD2740678;
	Tue, 30 Jun 2026 15:24:28 +0200 (CEST)
Received: from out162-62-57-210.mail.qq.com (out162-62-57-210.mail.qq.com
 [162.62.57.210])
 by mails.dpdk.org (Postfix) with UTF8SMTP id 74C8F400D7
 for <dev@dpdk.org>; Mon, 29 Jun 2026 06:17:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1782706673; bh=yF2u/mHbSqp+RPweuPVS4NocE45Wv3fiNUgF89WJLag=;
 h=From:To:Cc:Subject:Date;
 b=NrGfpBjbkHSq8ihNaspBJEZOp2G5N6r2k1XnEBVHfIOQAoMyTmNw1zB4FYDlXGtoU
 67bBoU3BaJ17U625Md0R5eI5cGuxoVfawB7J/vN3q9qyHrSbTc3uy0GeNT9xh1gSA4
 uTRn9Xnu7DqM9MsZ4NKwSnZxzoa3PiVRPoaPEVlU=
Received: from fedora.tail0f0cf3.ts.net ([139.159.170.83])
 by newxmesmtplogicsvrszb51-0.qq.com (NewEsmtp) with SMTP
 id 46F384AE; Mon, 29 Jun 2026 12:17:47 +0800
X-QQ-mid: xmsmtpt1782706667te87sloem
Message-ID: <tencent_FD79B9DBEB2FD074BFAAACCC6DD7A6EBB906@qq.com>
X-QQ-XMAILINFO: MpzImNZj21oww0ZIHK9zfuCfnkIkclyd04fEqJ8lXdGBkvidntuO2/jM6kNZco
 zEistwFWoTacxgC9aaRYxokUHIyIN0982k+VGhfCQbXHyZs9DlB5Vu4tHE8Ycf2wcODcl2ENAOog
 PsQXojD/hRfcFOX1iYEgOtolvWkoMTSh5bzj5o+7bXxZedwLOeEoiOvGAXrbdMRxcsMNJoRlzjr0
 u7Y11Az1+GfchGe835Dnjf5fWoZgyZsIooaPszApnrbG9raPut05YKfGvIAO8wueKH/WZzKNfcBg
 IngOhXaQWSkj/D3awcYwTuH354hGfEL80gfjjWZxk01YO6QTtN+LGM5naNzLr001cLzL5970/4Ih
 46nPA47hOzJmk1bY+zFmsFzzU90ZqM9fyUcOc+96l63/5Ll1SNOtetCw0I4PgjSSE4akTJJm4/FQ
 +SSrjzZ3XL+8mkBMAfc7K2h2hRQ0cbvD5CuEVNCVOXR0EujJNtiSCZCKhNcegifHXtNmLgsaVmHn
 xRzsK8DcJot7xn99wJ2L7K3NIWNVUbOYyjjbHlEASpeZhlS2S0Qjb8A5pIeeghBzyVi4+FVh/tyQ
 l7TRXsAL1olwDzAfl29KlAMUuBSw6zZStSn8RFRLP/PRLt51+q/NQY48panM9PBkpFYoDBUNZ/R/
 hQR5spf8y+O8gNJ2sRegWJ4Xsn8HYgq4PEJqS4bFsPOucdFQgYu4SA21hblQaTdgjLp9CnMShAWM
 vNWryVq0bJE18qlAKlz+tCbcib8gWLpysgVCQPLIuPZONasRRnvQirrcFrGLJtrWoIIsduR5c5cy
 cEK2hlOTv+/IOLsPn1V0kIfCNmd2EKqUxluOEk+SIvHRL8W1K7EHVYA9LTawT1207AxADlEpR+JZ
 o62SoQq/PztMQ+05gfPSjb4Qne+9Opesn93hMPLJj9n0BvVy9uMzKob1wYR3OU4TJg6ZBrnS51fn
 y6psYu3pvxETtvuXM2p6gSWUBT1KfGnHvTorFB7eVY3YuyYKFkKp3PFw44gYmPtp6LVFtkDyMWnO
 k7V+3p+fX/XaSNaWGZ6yZ84sycqPNA0a3y3P3BSQ==
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
From: datshan@qq.com
To: thomas@monjalon.net
Cc: dev@dpdk.org
Subject: [PATCH 0/2] fix dmadev incomplete ABI validation
Date: Mon, 29 Jun 2026 12:17:33 +0800
X-OQ-MSGID: <20260629041735.301180-1-datshan@qq.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 30 Jun 2026 15:24:27 +0200
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

