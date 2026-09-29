Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48D63C9832A
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Sep 2026 15:57:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5F38341132;
	Tue, 29 Sep 2026 17:57:08 +0200 (CEST)
Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com
 [74.125.227.171])
 by mails.dpdk.org (Postfix) with ESMTP id 844B240E0A
 for <dev@dpdk.org>; Tue, 29 Sep 2026 17:57:07 +0200 (CEST)
Received: by mail-pj2-f43.google.com with SMTP id
 98e67ed59e1d1-396ccdaea75so1620955a91.1
 for <dev@dpdk.org>; Tue, 29 Sep 2026 08:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790697427;
 x=1791302227; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=JFxOez81TD9LwPmgNhRWq29p0+i72zj/gOgtf+hG6SU=;
 b=tzL0Ur0l2A1NltQa4YiE70KCpGkFwIW6yn8l6HnOvgXnsHFRSS7vaQxGar44WaAnNs
 zZGj9bzsp9wzDcZtb/MByRvvAdHvOuGJ3ktPMBtbtNZlBPxS5KLyRSMq5JlHe+6yNTaR
 9jceHEAGTWrAfrHTvmO/lw/IRrAE9vsCV+weY3e/zpw5yIRdwSfpfWvd34I2Mm8pq2lx
 +RelN5GNU51BGNEO4PHOB3h/VUVkyiZb95HwT1q5bwtmWxlGEPulw7d4MhrV93sF2wRv
 S3v021j1Y8Oy+uKKj/yOvPk3+aotMv6ALJPxODEvuTKOaSih/2lfS1o1DMqqqVUi0lOo
 DMlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790697427; x=1791302227;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JFxOez81TD9LwPmgNhRWq29p0+i72zj/gOgtf+hG6SU=;
 b=j0BmTzjsPiDH0zYjV9OMtaic03YegOlpI059IY0hq5MkMKrrwi3PXg+9zGmsTX6SjO
 IxGDiXbyLA46EDU8s6NY7vcTUvhCp7OXrI7Q6Ya7xgua3gAO5YLLwpjVuxEhledEpNQj
 XMupavoru4JmoTZBovjHANEDAJMLoy8KbrPae1Ong9w638199N1orOUmtZNl4HGt00nE
 +3L6sNVbEV/vwSOlhFddc/gN2Z1Lr3Q+ewc8qcdHOWGUUAEZpMaK30RlgRKKP2kOc12H
 b5PaKfIGP2hk7qPhR+i6F7UjKhsn0frslRs7FFLcEZW+BwErZCZxAyT+wFluBhTEVMsO
 Yrbw==
X-Gm-Message-State: AFq9FYLsvdyJbEeum/xNKXim6l2+Sqae+EXrpCyXFEVqDDfUeN1rdbyS
 OBHmcEw0SEVeKe9wVeTZmncdtAYBhTxbSJZtABq1ONgkP4EBOwwAReq1q1q2cU8SfXk6jfQXoz3
 1fC6zFKE=
X-Gm-Gg: AYBFou2VRXm5Bo7Opr+GGYgnXqheMveV01F5y1W1Gp0daeD10SuiHMNKKhIRlIuA5Sf
 /53cKoQ3dLaf9DBEJxrTQG6hxhTS2HZWFgTIp5Jerqu0qIwhywxFf48jOBFjqqUFsNTr7BQt6s0
 wVlm2Tum+L/BTWKjieOMT9syV+E30coKMO6QCN7ErakIJYBVzMntZoP9egCrj5oqPWmLZ6YUlf6
 QncmygpFqAP5v+PDrAIhWRt2bgcP5Uz49nltYGv3djE09Wvd2/pFtZJzCsTRPgySClLTKhz+wxD
 8VsZpnzol7K2Gv1Jsrjqq2jkcEE1FlAYIwLOQmMkvJ2NCHfAsF3Idxvii24tHiEOjlxozX0WHa5
 P8MT0cDaSTdnxBW7N21CdNU9UU+jM08ALvRu6V5dBg17SjgWRzb2IsdoqWdPErhDEk9L6azOjmL
 3tPkQqeNyVKjrkqbJZBMe3DNSFUJquLqV9tLmGjtzjIh9OAjaLNtFn53L7dbfbv+uUEkwskRXRL
 k0bJorAcKmyLt+koL8ODuX9535wHXddwHqLhg==
X-Received: by 2002:a17:90b:5102:b0:3a0:78b6:588e with SMTP id
 98e67ed59e1d1-3a49c165d3emr1666634a91.23.1790697426620; 
 Tue, 29 Sep 2026 08:57:06 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a4b6b92c20sm733144a91.0.2026.09.29.08.57.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 08:57:05 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Thomas Monjalon <thomas@monjalon.net>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: [PATCH] ethdev: replace rte_memcpy with assignment
Date: Tue, 29 Sep 2026 08:57:00 -0700
Message-ID: <20260929155701.877309-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
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

Can use structure assignment instead of rte_memcpy here.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/ethdev/rte_ethdev.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/lib/ethdev/rte_ethdev.c b/lib/ethdev/rte_ethdev.c
index 7c57a9bb8f..6f5a957d00 100644
--- a/lib/ethdev/rte_ethdev.c
+++ b/lib/ethdev/rte_ethdev.c
@@ -16,7 +16,6 @@
 #include <rte_log.h>
 #include <rte_interrupts.h>
 #include <rte_kvargs.h>
-#include <rte_memcpy.h>
 #include <rte_common.h>
 #include <rte_mempool.h>
 #include <rte_malloc.h>
@@ -631,7 +630,7 @@ rte_eth_dev_owner_get(const uint16_t port_id, struct rte_eth_dev_owner *owner)
 	rte_spinlock_lock(rte_mcfg_ethdev_get_lock());
 
 	if (eth_dev_shared_data_prepare() != NULL) {
-		rte_memcpy(owner, &ethdev->data->owner, sizeof(*owner));
+		*owner = ethdev->data->owner;
 		ret = 0;
 	} else {
 		ret = -ENOMEM;
-- 
2.53.0

