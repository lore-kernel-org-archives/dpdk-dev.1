Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C429CD4F26
	for <dpdk-dev@archiver.kernel.org>; Tue, 12 May 2026 07:56:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 545194066A;
	Tue, 12 May 2026 09:55:54 +0200 (CEST)
Received: from mail-qv1-f74.google.com (mail-qv1-f74.google.com
 [209.85.219.74]) by mails.dpdk.org (Postfix) with ESMTP id F052040278
 for <dev@dpdk.org>; Tue, 12 May 2026 00:23:44 +0200 (CEST)
Received: by mail-qv1-f74.google.com with SMTP id
 6a1803df08f44-8aca14d1faaso129606086d6.3
 for <dev@dpdk.org>; Mon, 11 May 2026 15:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1778538224; x=1779143024; darn=dpdk.org;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=K0SQBcVNBF19tHvkuf2YJfJPa34TCVkJ1j0nomeq7Ws=;
 b=jlyLlr8JbkhRr3uhuourhGo09cAPlO7mrAoVpUffs2EyddDNckN5nmKmUCJMvy1xeQ
 ZylkIYgmeFpXJnyrLEsz6ZUR0o6yP4SXa+WiyjGB6PtP1RzodPD2ZMJhe9yX8VnANFuP
 7rCpFGGomE12pjyLh4MXuYbsKUhMthreAjGJODi0oJkl8A1Lwk5D1iGkucPTGtB7ku+Q
 4ezNgE5lLCUWHAP7zTHVA99r1zUPIKYrtHEaBOk6dkQIl3Z4Nl4g0rMev1l/u8BdadgP
 SxZC3ywN699gQNUdLYSCb7WFYuexWHZY+8OXjUvp55j5dVcHNzG74QpaLkFlGJ+NQRx7
 nwZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778538224; x=1779143024;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=K0SQBcVNBF19tHvkuf2YJfJPa34TCVkJ1j0nomeq7Ws=;
 b=mTeC4/pFCvpZiwjVDpivlPIWx+db8IPsBIM7QEyVQomW1Fa8on6U1UBu4+quF8mLBv
 kUTc7rRYAC9wfnvVPWGn2Tx56SAH/VvDWz4kyKQXPPnp9CvspxS9Tgr2+5RbfZzuOcSp
 SD6dQe9Ojic0uXpCxl3dyMWm5GjRMvTAfu7nIq0Reloq0V9+1YMbWfAlc2wbp36RzmgP
 AiJurSAprwyfGCIO0cMBLJtpU/wA55iORyt7+hCE4wjeSG+YhSRx8MXliLmPILyfyV7t
 dhbYZP8Rc9IPoHONJ4UxF7eM6zC76L4OXxt9NiLBqxmZop0ZZB72KxSL8ZiirtzZ4Wcl
 Vl7w==
X-Gm-Message-State: AOJu0YxEYCXokFdgUJNo+U2TVsoF4nJF/0Hue4112r/SPOqBknquGzcF
 3AfM7wMxyl1N/BIuZRY1V/FSiJ1HHp9dcJRfCcB7onwLRuxmpP4IqXAA4BWMMWZ/oLCIJGY5jt9
 M2Doo1A==
X-Received: from qvbmy9.prod.google.com ([2002:a05:6214:2e49:b0:89c:6214:e749])
 (user=blasko job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:19e4:b0:8ae:672d:36a5
 with SMTP id 6a1803df08f44-8c664633de8mr9614766d6.51.1778538224001; Mon, 11
 May 2026 15:23:44 -0700 (PDT)
Date: Mon, 11 May 2026 22:22:54 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260511222301.862880-1-blasko@google.com>
Subject: [PATCH 0/6] net/gve: add hardware timestamping support
From: mark-blasko <blasko@google.com>
To: jeroendb@google.com, joshwash@google.com
Cc: dev@dpdk.org, jtranoleary@google.com, Mark Blasko <blasko@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Tue, 12 May 2026 09:55:49 +0200
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

From: Mark Blasko <blasko@google.com>

This patch series introduces support for GVE hardware timestamping on DQO
queues. To support concurrent access, a mutex lock is introduced to protect
admin queue operations. A mechanism is then added to periodically synchronize
the NIC clock via AdminQ, and support is introduced for the read_clock ethdev
operation. Finally, the RX datapath is updated to reconstruct full 64-bit
timestamps from the 32-bit values in DQO descriptors.

Mark Blasko (6):
  net/gve: add thread safety to admin queue
  net/gve: add device option support for HW timestamps
  net/gve: add AdminQ command for NIC timestamps
  net/gve: add periodic NIC clock synchronization
  net/gve: support read clock ethdev op
  net/gve: reconstruct HW timestamps from DQO

 doc/guides/nics/features/gve.ini       |   1 +
 doc/guides/nics/gve.rst                |  18 +++
 doc/guides/rel_notes/release_26_07.rst |   3 +
 drivers/net/gve/base/gve_adminq.c      | 127 +++++++++++++++++----
 drivers/net/gve/base/gve_adminq.h      |  29 +++++
 drivers/net/gve/base/gve_desc_dqo.h    |   8 +-
 drivers/net/gve/gve_ethdev.c           | 148 ++++++++++++++++++++++++-
 drivers/net/gve/gve_ethdev.h           |  39 +++++++
 drivers/net/gve/gve_rx_dqo.c           |  26 +++++
 9 files changed, 377 insertions(+), 22 deletions(-)

-- 
2.54.0.563.g4f69b47b94-goog

