Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7157DCA5FE2
	for <dpdk-dev@archiver.kernel.org>; Sat,  3 Oct 2026 02:51:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 307E44026A;
	Sat,  3 Oct 2026 04:51:47 +0200 (CEST)
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mails.dpdk.org (Postfix) with ESMTP id 68E754003C
 for <dev@dpdk.org>; Sat,  3 Oct 2026 04:51:45 +0200 (CEST)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2db8e9fe9c7so902325ad.0
 for <dev@dpdk.org>; Fri, 02 Oct 2026 19:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1790995904; x=1791600704; darn=dpdk.org;
 h=content-type:cc:from:subject:message-id:mime-version:date:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=LFwsC9h2vKZu8WECt+FZ+TAhHeQ4MHaPzIpaG9Lsb78=;
 b=Jk/VPYOaSUVjptzLivFQj+6ZrlpKDjcn91kPP65c47euRKWlsUK6g7x8tDKSLZ6RRA
 V3ulmW8+jrFAzXWpRo08ffD4z+42YWo1VY++DHn3G5n/wIKi8n1NbMWWXrZdNHlnY8Tv
 9fQgFkd9q9qejB/+ZSD1corN99Deg+o6+zaakWR+xs06Tg4GZDQvm7Vnwuhc91i/qkCO
 Ek6/hde9AWVB76Hiqr06MRWwLzYTHkeXm2z1LYPLCHteVzJMkii4blrDEt37vrOqofqe
 CPLEFsp+7Vl+Y+3z7RsZboxKaa3DB8Giz7/ETCBdrTy8w0Lj8guGRakW5moCpMhw6Buc
 LOKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790995904; x=1791600704;
 h=content-type:cc:from:subject:message-id:mime-version:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=LFwsC9h2vKZu8WECt+FZ+TAhHeQ4MHaPzIpaG9Lsb78=;
 b=o8lT0JCTrC43pYPUuYZjZQ5Cp8GXF2C9oBr5JdESG23pBwQzT7rI6L1zgm7Q+S8Nc7
 MJmryKhlBlm7VI1wo73IWe6BetqHyt3lcnFyBaniDzT3o4AC6wj73w11bcIcOMEqAH3D
 einCyRT1jowSExAdGvgCniz+K4QtBIbVcLkeslEL27jeyrwjpHSryuiFsYsDuzZJnqYQ
 lpDgX5FdRf9vV+3g/rZlWy6sK7E4p4iPz7Xw4bBt7QrLtv4H2ZSiC6gA9uB37JA+bhQ6
 tWiJK4klEeBIdrP87BxxCYJX1qGBTkJnv3AEfYjIX4AasoBiH0ZSY5m0hHSMMQh6qoSC
 Mktw==
X-Gm-Message-State: AFq9FYJbWQ6lxQ/Zsrev5ihgrlb34qASBo5GGzvLYseJhVXuYUpI0XC3
 AJAXHYepvb2XFJwteucZ7ml6j7wVdotpOsQM8qPyUoZ6fqAsrwHZmnoppHXxgmwnrFniY7Ua8tI
 uJaRpk3ZClEIBni/nsIeW9kWcFlrr3OEiHEyLExFzmahHeMdD8eAn0iU/fw/U89uqrRRJc3bCid
 rNNhIXayq3ZY6tw57XX96OefPCGFE+N2kw1w==
X-Received: from pljf2.prod.google.com ([2002:a17:902:ff02:b0:2df:b094:2fb6])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:ace:b0:2dd:ad74:ac81 with SMTP id
 d9443c01a7336-2e49b697c6amr40911855ad.28.1790995903577; 
 Fri, 02 Oct 2026 19:51:43 -0700 (PDT)
Date: Fri,  2 Oct 2026 19:51:32 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20261003025142.1930363-1-joshwash@google.com>
Subject: [PATCH 0/8] gve: precursor control plane changes before bare-metal
 support
From: Joshua Washington <joshwash@google.com>
Cc: dev@dpdk.org, Joshua Washington <joshwash@google.com>
Content-Type: text/plain; charset="UTF-8"
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

This patch series includes a number of precursor changes to the GVE
ethdev driver layer in preparation for introducing support for a new
GVE Mailbox control plane (an alternative to the existing AdminQ control
plane).

The most major change in this series is the introduction of a new
control_ops struct that will be used by both AQ and Mailbox for various
operations which may need to communicate with the device. There are also
some changes to how RSS and timestamping are handled in ethdev due to
slight feature differences between the control planes.

Jasper Tran O'Leary (1):
  net/gve: fix RSS config memory leak on close

Joshua Washington (2):
  net/gve: update RSS config just after successful programming
  net/gve: add RSS cache boolean flag

Mark Blasko (5):
  net/gve: refactor ethdev for control ops interface
  net/gve: rename doorbell BAR variable to be more generic
  net/gve: split default queue counts into Tx and Rx
  net/gve: clean Tx queue directly in dqo
  net/gve: refactor timestamp support to clock read type

 drivers/net/gve/base/gve_adminq.c |  33 ++---
 drivers/net/gve/base/gve_adminq.h |   9 +-
 drivers/net/gve/gve_ethdev.c      | 207 ++++++++++++++++++++----------
 drivers/net/gve/gve_ethdev.h      |  59 ++++++++-
 drivers/net/gve/gve_flow_rule.c   |   6 +-
 drivers/net/gve/gve_rss.c         |   2 +
 drivers/net/gve/gve_rx.c          |   6 +-
 drivers/net/gve/gve_rx_dqo.c      |   6 +-
 drivers/net/gve/gve_tx.c          |   6 +-
 drivers/net/gve/gve_tx_dqo.c      |  20 ++-
 10 files changed, 236 insertions(+), 118 deletions(-)

-- 
2.56.0.rc1.315.gc6ed9934b7-goog

