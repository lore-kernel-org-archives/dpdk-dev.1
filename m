Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E146CD342F
	for <dpdk-dev@archiver.kernel.org>; Fri,  8 May 2026 19:11:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3EB434025E;
	Fri,  8 May 2026 21:11:14 +0200 (CEST)
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
 by mails.dpdk.org (Postfix) with ESMTP id BB3A140150
 for <dev@dpdk.org>; Fri,  8 May 2026 21:11:12 +0200 (CEST)
Received: by mail-dl1-f52.google.com with SMTP id
 a92af1059eb24-12c1a170a50so3354587c88.0
 for <dev@dpdk.org>; Fri, 08 May 2026 12:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1778267471;
 x=1778872271; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ah2TvkQ2dQNgiUtjtJEOEFfVWhIEHi3c3rggvz2KptM=;
 b=BWiuThcSGe2Si3rxSFY44O79JMTkmvanRV9Gi0NDKMt9KNL9jA6nvu2zOlP9/kJcZZ
 PlBvX9boATr5iaBguK8HLgIPS7zf9rxiTNB4Wz/IaolwxamZfLyxL7WZz7uW4gUKDtXl
 K6IoUOd24VzhAwaPq2CpYleYVCNyTiXylkgzP3A5wDKVo9CSQPb10L9nd8fQAvo+bFbk
 9DGbGtaBNIsSy1OS+m8K44i+W9xkjsahIuokRSCnxbIWuxE+o3wueDw1jyAUkBv8gMB3
 tlcvobW8auxMZfJ0BDa8PLQlF4mHtBQNeoyQO5GOqSxQ3O91AfFVl6AhPT/XLWPRD7u4
 CXZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778267471; x=1778872271;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Ah2TvkQ2dQNgiUtjtJEOEFfVWhIEHi3c3rggvz2KptM=;
 b=iGE7pu0X7gBxyvdI48hqQsh/rKYer8sIVIF0y9eU/fyympSPhi4r3fMbUSrc6t1ECD
 7C8W4mEHJ/UKvIAkLpHZ6DP96Kb9IYsj8NXH8qxbzZqOP0AY7/YevzTwlUvCHNRlaCWX
 h3weHGCiesYJqjenUyvhJqeJiokGT7QKZiTtAly1J9uhOc7Y+tr++538NFLaGQFWkmDm
 FiJUYTEFQcg+/EXsLSY3L/JLa3DWYiZ0SBwTjHuUnjDrjRHZyoh+SIpQxlXsijIp3QxV
 1wBB7q6ZBjWSICnnMP90YqIr3vWs2o1FONUzmXhPYmbVEUjYYnuSFB2aRzcoraKouZ2z
 BxEg==
X-Gm-Message-State: AOJu0YzTmRg+1YZjJg0sVp5ozVS4g0e/2GHbV0vAj0Nc5j9Ze8UDfLsA
 NSufQHJ1KjoYhQNULvic5I7tCDZlGzHr0rveD2SU6h0z8qDpf88lxOpPFjdwCeQMlFaMs1Msnuc
 JcrnD
X-Gm-Gg: AeBDieukkApLkz6IOk0dfDakR0/mrjfSuWdBH4qkSW+5WybXZrWh77P/j4ejmoNuGPW
 so7tbIalFCWC7wSXqZ/YI24ZuTmu9LWI/J7xWAUjnY4BPTzJkRd5ORI1y1ADdsT/m0nzODfz4Y0
 B7dCxh8QOJGme3UmAfTH7A5KRjzY3TRVDk43V+Z3c5h8S5e6cPlj1ai/xTJx5FE+xLhBZZBN9Yz
 dvD/L5wjeLfFVUtHzcLz4nLnDG+NzE6WeinIo3qPMdx5q7VB5mtvXT73QmcN1f8CfJGy0ReN/hU
 rgzi8o2XR+dQiP+s/tinuJLiASVJjxzhX2H8xUwBCdsJfGMGx+0DxxRRbSOK38MTt0OFXe3LMYd
 ZjnnEYURYkPAcTV7sKrt/9wX+J+yAQCyRq+l5IYgMqEs9kzn9SFIT7b+MflIQqJtD6qrLH00Cg1
 NwD//vhPM7qJCLaiS4vTvnWNieiz4ZmaZd
X-Received: by 2002:a05:7022:f503:b0:132:5d31:dcb4 with SMTP id
 a92af1059eb24-1325d31de97mr1888821c88.23.1778267471325; 
 Fri, 08 May 2026 12:11:11 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1329fc4bf3fsm212796c88.5.2026.05.08.12.11.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 May 2026 12:11:10 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v2 0/4] net/axgbe: fix resource leaks and OOB access
Date: Fri,  8 May 2026 12:10:48 -0700
Message-ID: <20260508191109.734377-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260218164324.915065-1-stephen@networkplumber.org>
References: <20260218164324.915065-1-stephen@networkplumber.org>
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

Code review of the axgbe PMD identified several correctness bugs,
primarily around resource management on error paths in device
initialization and an out-of-bounds descriptor ring access.

Patch 1 fixes multiple resource leak paths in eth_axgbe_dev_init():
  - mac_addrs leaked when hash_mac_addrs allocation fails
  - hash_mac_addrs leaked when phy_init() fails
  - rte_intr_callback_register() return value unchecked
  - DMA reset failure via hw_if.exit() logged but not propagated

Patch 2 fixes wrapper_rx_desc_init() which only releases the
current queue on mbuf allocation failure, leaking all mbufs
from previously initialized queues.

Patch 3 adds pthread_mutex_destroy() calls in axgbe_dev_close()
for the four mutexes created during init.

Patch 4 fixes an out-of-bounds read in both Rx and Tx descriptor
status functions where desc[idx + offset] can exceed the ring
size. The offset is now folded into the index before masking.

v2:
  - Patch 2: use rte_pktmbuf_alloc_bulk() instead of per-descriptor
    allocation.
  - Add Fixes: tags to all patches.

Stephen Hemminger (4):
  net/axgbe: fix resource leaks in device init error paths
  net/axgbe: fix Rx queue leak on descriptor init failure
  net/axgbe: destroy mutexes on device close
  net/axgbe: fix descriptor status out-of-bounds access

 drivers/net/axgbe/axgbe_dev.c    | 27 ++++++++++++---------------
 drivers/net/axgbe/axgbe_ethdev.c | 26 ++++++++++++++++++++++++--
 drivers/net/axgbe/axgbe_rxtx.c   |  8 ++++----
 3 files changed, 40 insertions(+), 21 deletions(-)

-- 
2.53.0

