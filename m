Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A2F8CD4F26
	for <dpdk-dev@archiver.kernel.org>; Tue, 12 May 2026 07:57:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 96440406A2;
	Tue, 12 May 2026 09:56:01 +0200 (CEST)
Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com
 [209.85.160.201])
 by mails.dpdk.org (Postfix) with ESMTP id A99F4402DF
 for <dev@dpdk.org>; Tue, 12 May 2026 00:44:01 +0200 (CEST)
Received: by mail-qt1-f201.google.com with SMTP id
 d75a77b69052e-50da31af14cso114299351cf.1
 for <dev@dpdk.org>; Mon, 11 May 2026 15:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1778539441; x=1779144241; darn=dpdk.org;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=K0SQBcVNBF19tHvkuf2YJfJPa34TCVkJ1j0nomeq7Ws=;
 b=YsLvwMIaGZ6LC5nxOY1pylxF8pJAxF9JYMqDH3TkYvEPUWo9Ng6o5xNyIsrs+cpRms
 tOFWuXKhapklW2Wi2740PM7/Rzw4IVL/9LHmTKs+JR9j1foQaqJkGBUdSj7qhRsS33UD
 bAnJfIg2fQd9wKKSbZGNn7iIzmgkW4AzFMjdOyXcMWPa8HwUP68sn5aRP2N+8GVjvvLi
 SmQHFHLwEZ1zSSax2e2fFXGmLdHUiP6RUzmeueEOWl1UVxWL1RBhoKhGGckEvNvDhd2s
 EKOHgeYzx398EjJBEiYYYIfVBgz8KT6MkR81LFIvwCFFmjhGwO4QQwfjYq5nu8CcjlIU
 kFRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778539441; x=1779144241;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=K0SQBcVNBF19tHvkuf2YJfJPa34TCVkJ1j0nomeq7Ws=;
 b=jJaBj1AoBNcUURCZEsShREWTNwrFEY8QmVrASo4a7TsKEtbcfF0mvWxV1r95zYEM1r
 hP8HJAnKwiOI774XXWTMUDpLNuhvWWbdeQjvbZ9tFAY5XAsWmUxBWyuHhTRnyineKGm8
 HVhLFcsdrf0reIlSpILJsplqwLBRn7WFvjjBsBIEfKds+ZfTDhKCZL53zEzSOQBa0rqZ
 G9oVsOl4a90HKhKK8tyzYSBzg8UUbTGryN9I5mJFHvIx4+lVs0DSyytn81Q/T3hY1rPH
 4wowJstPMUIrFSpIU1ok12iLD7TlZ0bYxjdyrUMdJe8TqDBu+JZao5Tdbb2/kidpGY3G
 AFFw==
X-Gm-Message-State: AOJu0YxGSEFEKyYzpXNQtFh18xqlJKlGVyJTNsTua/NVADz03Ut6IR9v
 hB1jY7filJ78/wnyM8aqMxD/R4lNb4L+D/GnLRKT6wigFG2VR24cUlThZ8YlYyW5ljnXy2fLlLM
 D9XFzjQ==
X-Received: from qvbod13.prod.google.com
 ([2002:a05:6214:2f0d:b0:8b6:bda5:2dc3])
 (user=blasko job=prod-delivery.src-stubby-dispatcher) by
 2002:ac8:7d56:0:b0:50e:5aed:caea
 with SMTP id d75a77b69052e-51461bea0f5mr394657271cf.14.1778539440746; Mon, 11
 May 2026 15:44:00 -0700 (PDT)
Date: Mon, 11 May 2026 22:43:48 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260511224354.872997-1-blasko@google.com>
Subject: [PATCH 0/6] net/gve: add hardware timestamping support
From: mark-blasko <blasko@google.com>
To: stephen@networkplumber.org
Cc: dev@dpdk.org, Mark Blasko <blasko@google.com>
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

