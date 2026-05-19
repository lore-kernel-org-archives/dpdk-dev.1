Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4000FCD4F57
	for <dpdk-dev@archiver.kernel.org>; Tue, 19 May 2026 10:28:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 418ED40652;
	Tue, 19 May 2026 12:28:07 +0200 (CEST)
Received: from mails.dpdk.org (localhost [127.0.0.1])
 by mails.dpdk.org (Postfix) with ESMTP id A80C940296;
 Tue, 19 May 2026 12:28:05 +0200 (CEST)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com
 [209.85.221.45]) by mails.dpdk.org (Postfix) with ESMTP id CA0534021E
 for <announce@dpdk.org>; Tue, 19 May 2026 12:28:03 +0200 (CEST)
Received: by mail-wr1-f45.google.com with SMTP id
 ffacd0b85a97d-43d7e23defbso1883042f8f.0
 for <announce@dpdk.org>; Tue, 19 May 2026 03:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779186483; x=1779791283; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=IRAJAwxceiIFvwTvjdrlODfhY/YUP6obgW6fVYWR0GU=;
 b=YMv/0BLku+Xet4AscNX9c8EOAeqCaoCVcZasjn/tmaqfIu1HSM4PJpyVduIGJv18Ct
 suRO+GLKExJ8v6dJwLI+bGBHWOaATXicqBQediWTdnoIgzxXJY9tLGe/45pq8iyMpr1g
 baeodXuqPQazviWoVGyNpo+coUTRSsLmZAdaa22yEAMV1ckY7d79eSiWRKjU0FrzBCc5
 2yfsTWBOH81uUshO0m/MxS+JXCOU9H3NF0Nzd0L1eh1jZiaty8t3AjZuoHld6iAUEQo1
 4t+6IHo4eHH/p9Lljnju/pDWHo3G04tIY2s7Jyh3ylBfgSus20fPx97BSsFdabqAkdEt
 1kqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779186483; x=1779791283;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IRAJAwxceiIFvwTvjdrlODfhY/YUP6obgW6fVYWR0GU=;
 b=LIgf14ti8b3D1puhXT1Ai21qPDhLZDAhzhB/U/MmfnhZtVi5t9a8fgKWsz2+d77mt2
 QxzyEYxRtt/fgKnirr2fGxoo2AdimlEmJeYfW+poZ1hziYLJ+zk9k+ut7d5iAXJECQiA
 FcMQfZ4jJzLujpnLTGmT1QEyF/S2dmV/6VK6RVfE8VZNBIGn4SLdF93a1MBnzfvlbKEy
 lA/6N/BYtb+SBZzmBNj1IUpkUIkXXyZvZQv/s2eAz6pRzFhFdPojj8xOrfOi+17cCtNi
 AKq7UIE2O03wH+WSeHHHQXQMakVbCT1wW/zc/n5kILdsw8jSqaH5S2x/S6vA8sQitmhR
 dr7Q==
X-Gm-Message-State: AOJu0Yxo7pp3z+8AXC+Ia7Hg2y5jj4+El1jRkMcO0H0M0U8xGQA5g0T0
 rVhiDHlzQUZLs4pXBIoiyCqm3aO2jjHHHAWSQr1cDJ9N2QAO/UWGl3rQWGwHbg==
X-Gm-Gg: Acq92OHWoenOiQOFLL7+1mUcGriRGbcglteuf5W+AORPrygke6z35aBhAtU0cCbh3tx
 8WIPLXtjl3pqyTCqwfzuLryHBe4PjdNc0mxJofqio9IninGQnGUOPmASu7YrP/MNAk/EdL7TyUk
 HTaUgI3VM4+R1m7lInaFNow19HeWZkDQZnxMIDIJMs3GjQz99oU3PQv2/nCTsApgBNp6S2U6NWO
 0xJ9/pzHeeAJj8t8uBgD0VdcfRGh7cp6I7K+rxZJ2eVxiOkwwIaz1CAKxhmwxY8fd6Z5FpvhElw
 CQU2gFOtuN/V1MEZ1xwqMOV0iNGWy7cXsAsK2SH8coD0nk6TlYlD9v9V0Vh/U8eQxCn0Mch9ZOt
 UAk9vFAl1v6c7T2Pwd84QuaC8OeGV1yJrrpqlKJ4WxlBF/ItzE/yroJzspW9m/jqq+6tipn1jh6
 vGY1MClNmh4OuNKt5qFCIkUP56fT78B5H60AUu73c=
X-Received: by 2002:a5d:5d12:0:b0:45e:8547:f214 with SMTP id
 ffacd0b85a97d-45e8547f294mr8402309f8f.32.1779186482979; 
 Tue, 19 May 2026 03:28:02 -0700 (PDT)
Received: from localhost ([2a01:4b00:d036:ae00:5670:761c:bfe8:8866])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-45da0a17ec2sm41712604f8f.24.2026.05.19.03.28.02
 for <announce@dpdk.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 03:28:02 -0700 (PDT)
From: luca.boccassi@gmail.com
To: announce@dpdk.org
Subject: DPDK 24.11.6 released
Date: Tue, 19 May 2026 11:27:55 +0100
Message-ID: <20260519102759.451367-1-luca.boccassi@gmail.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: announce@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
X-BeenThere: dev@dpdk.org
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Unsubscribe: <https://mails.dpdk.org/options/dev>,
 <mailto:dev-request@dpdk.org?subject=unsubscribe>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
Errors-To: dev-bounces@dpdk.org

Hi all,

Here is a new stable release:
	https://fast.dpdk.org/rel/dpdk-24.11.6.tar.xz

The git tree is at:
	https://dpdk.org/browse/dpdk-stable/?h=24.11

Luca Boccassi

---
 VERSION                                |  2 +-
 doc/guides/rel_notes/release_24_11.rst | 17 +++++++++++++++++
 lib/net/rte_net.c                      | 29 +++++++++++++++--------------
 3 files changed, 33 insertions(+), 15 deletions(-)
Luca Boccassi (3):
      docs: fix build issue due to missing spacing between paragraphs
      Revert "net: fix packet type for stacked VLAN"
      version: 24.11.6
