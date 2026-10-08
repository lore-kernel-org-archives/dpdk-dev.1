Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D68DCA6019
	for <dpdk-dev@archiver.kernel.org>; Thu,  8 Oct 2026 23:38:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DF11840B9A;
	Fri,  9 Oct 2026 01:37:44 +0200 (CEST)
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com
 [209.85.210.172])
 by mails.dpdk.org (Postfix) with ESMTP id 64A3D40B99
 for <dev@dpdk.org>; Fri,  9 Oct 2026 01:37:42 +0200 (CEST)
Received: by mail-pf1-f172.google.com with SMTP id
 d2e1a72fcca58-85377c8bc96so2188583b3a.3
 for <dev@dpdk.org>; Thu, 08 Oct 2026 16:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1791502661;
 x=1792107461; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=AutbEqXNQU9LPX5AmSCbzwCNp+NpT+lVDpgLHM8sOzo=;
 b=DpzZZ/TkeL6Yg6TVuej5AHwvc6FPC43/ef2TompboOzy3ptttJ+1k89YDMR3eZZIGT
 h3tS8TbBjF4W7SjqKS9edNvD7MnsGDvCWeAHyTx8tqf16DJfewfbMeq7R46CiGl6mdhC
 cDZTj6pY3CDA8hFd85i8LilNtl1BAf4B4ReemG4adiVz7su4HERmpBRkFgjprJZiyTkD
 243HcjxTSu+vi606bMH9TF2UI8p7WP4uJv0mKbelml2gqmfQQqi9YqQVsJ/QMFc9dGVb
 gKco3s9tFgNMmoWEPm+s8DjUJbg3cGVihuasTzCU2lq7qFeCyyEGDtgukYixHwLEztm6
 /4ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791502661; x=1792107461;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=AutbEqXNQU9LPX5AmSCbzwCNp+NpT+lVDpgLHM8sOzo=;
 b=IGEcwy1hsyr7luAni7ofM9IuyKZVpVt7ssr0dPoa2726gOuW4you68GB30DfWd+FKj
 P1rQvNvcgKkfDs9hWgzZ+Uu88g+9iGObaPQ1LrpfcJ9bSYHXKjJos2qhGk3laQ6+uhv9
 w702R5VLSgoQojQ8k7fNyGw4XdC1OhE7C/SsGgeArsS/3/5XEYbhEN5lioPWrNgwf5Vp
 wM6727ojMzh4uq0Qt/Z1sMXOuuPVa6yXZITVDvR8Lv4Nk+Z9i0PymHDUq0QkdVlpvHAw
 3JBB7FwGk0QJqnswszYG2MkP9ItLhYJwyQ9xBs8czOtMPkFRrJ+AC7rCbSU/ygTYKXjI
 2f0g==
X-Gm-Message-State: AFq9FYKyifnyO6sVnzwJfnNnl6XHR7mq1/xJpz6PcUrkqGBipfxk9Jfs
 5yWkh3gf33MPtCXBM5JvoD0+uq3K0qQ4hm2Eg23J6oz95z542Rn4VX+ZAIN6XA2C6DUwe8JMTqf
 EXHmhfAI=
X-Gm-Gg: AYBFou29waJzitvG20+gcjFc04RP5HcdLBE/BvqK4kU1kuEhdbd9yoTu3TVzaDy0h8K
 bmBrIadmTv2JDhVMGaYkfeBYJlIQYAQXgApN7tOQ/PdrPiGAvMrin9WORPhpWH5KV81IFU6UyXG
 JJ7VSBP0DpbfCcSJvc7U5pHcCxesWgcptLWggVFGyY98Evtr93PXO+NsNsoJ+uawks9crGKrzJj
 gnfpRNgWiwU8TopVm9WaXo/x69ux/uXP0aajz2M1sZ/jgdE+ImzzyTL5lFbiVUc4aR1LwDF3rW9
 ilsHSl7d6CGr3puf7gEOlBFrRG/8ZglCK3mImf8AJTxAxGBgAHPSD4RshMsIgXTu45GIas3+Df/
 un/trQ2CqvgBocJ9LznOABGBMHi6e+l7sHRTVY7hHUI8RriSIMNGz09u6DauzIUvmAgclrCttvo
 sQzDHfNEwXKjQiB108krgVdllv0k6nO76/RZzfKsR8OMHtuuZk5Uq5hRXAO8wKGmWOe/jGTcKuX
 0eNwMq8HU49JBse5FpoP6BDKoTPcAxriXSWeA==
X-Received: by 2002:a05:6a00:4f87:b0:881:1fb6:a81 with SMTP id
 d2e1a72fcca58-897c3ff538amr72757b3a.3.1791502659873; 
 Thu, 08 Oct 2026 16:37:39 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-896c42b06e9sm187909b3a.42.2026.10.08.16.37.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2026 16:37:39 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Harman Kalra <hkalra@marvell.com>
Subject: [PATCH v3 22/29] mempool/octeontx: use IO barrier in pool destroy
Date: Thu,  8 Oct 2026 16:35:15 -0700
Message-ID: <20261008233649.1260843-23-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261008233649.1260843-1-stephen@networkplumber.org>
References: <20260729175715.165120-1-stephen@networkplumber.org>
 <20261008233649.1260843-1-stephen@networkplumber.org>
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

The barrier flushes outstanding writes to the FPA pool before the
teardown mailbox sequence. That is ordering against the device, so
use rte_io_wmb(). Control path.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/mempool/octeontx/octeontx_fpavf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mempool/octeontx/octeontx_fpavf.c b/drivers/mempool/octeontx/octeontx_fpavf.c
index 6cd0fc057f..7051422cb7 100644
--- a/drivers/mempool/octeontx/octeontx_fpavf.c
+++ b/drivers/mempool/octeontx/octeontx_fpavf.c
@@ -616,8 +616,8 @@ octeontx_fpa_bufpool_destroy(uintptr_t handle, int node_id)
 
 	RTE_SET_USED(node_id);
 
-	/* Wait for all outstanding writes to be committed */
-	rte_smp_wmb();
+	/* Make outstanding pool writes visible to the device */
+	rte_io_wmb();
 
 	if (unlikely(!octeontx_fpa_handle_valid(handle)))
 		return -EINVAL;
-- 
2.53.0

