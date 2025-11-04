Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23CF5CCFA04
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Nov 2025 18:09:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 34299406B4;
	Tue,  4 Nov 2025 19:09:37 +0100 (CET)
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com
 [209.85.216.54]) by mails.dpdk.org (Postfix) with ESMTP id 3C152406A2
 for <dev@dpdk.org>; Tue,  4 Nov 2025 19:09:36 +0100 (CET)
Received: by mail-pj1-f54.google.com with SMTP id
 98e67ed59e1d1-33db8fde85cso5627915a91.0
 for <dev@dpdk.org>; Tue, 04 Nov 2025 10:09:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1762279775;
 x=1762884575; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PPQTx0z2LrGhFBoUFfqMhsEtngbOKeBe2Sa3KcccjjA=;
 b=0b6pZFd8yiLk4gFvcqinTrs/Y00+s9X4FnmYPBrclhYi4KbVS6QKuPuVRAooYD62jQ
 7s24ZavGtUmErPpiPpwIPmflibF2OuOpycyHZVm9/6m8KMn9AF9TfH5dgVfT4q+ex9Om
 T4XBoIJRf58mVRPYigdxj+bC2IfVlvXWxu9fMshtSEvgddognfWK0xepS9a7IkQiUQh0
 54jIuYKpHq8oqCi4cZp24kzBOj0H0dp2MYKxptKlVY420NywQh1dJamELBheA8hdb5vn
 nwj9qalFzQMZA7pB/Ev7HucLEDWyh8fSgrbVL6m02kPxDHX1PVNN1FqACJp6omb6AOqH
 bt/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762279775; x=1762884575;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PPQTx0z2LrGhFBoUFfqMhsEtngbOKeBe2Sa3KcccjjA=;
 b=KqPqbaJ/hLDC/xP1NONJ3nOFAs0jHlFi18EvNKvWbRfXPxvwWU9+1zlCqpQ419v/Tp
 Uc80oRWfNxIqunoi4x/bDLxHIfa7kDn7uG0lA25XQbwrUotV1oVDi9ExHzUpukADdAvI
 B2DiF/dq/ukVCuMk/ubrow8XM3/xSNT9PKGs93Y2xBFEw8lG6tSMMSWgcNW8Luh1j0+w
 1N3ddySV1kshWw+le9bEN1BzjxZ2jFj2J4218MgbsXzHRJXIuAx4yqGJPh2MTmHLPz5t
 Fmbw2/3WKbA3dczPqaprI/gEkVePlu9ccw+IL3bV/GAQCzgwCni7J1ld6bYaCYG6V0PJ
 V93A==
X-Gm-Message-State: AOJu0YyDkYeOBneWo/1+mzSa6CZ3PLyOKn54+8SySm+4vvvz5HTdETJo
 Wn9VL/UrhuZ3tbIpkvTVmSQv0b3kfDsPV9fNDnqP3T+5nTg47pdA0FjS79JG+mwnTvwtKSVogvk
 pqILh
X-Gm-Gg: ASbGncuBAT/xfbgsCe8ZOKYiHBxCCgL1mVEMsHq3PRA6rv9dsOzQIcqzrYGvt3aWRnT
 M/7V8spkrchEEurSB0dQ8XSzcaQ8WmdgZLb2hFV9dFAAZL2e8ck+bBlw8Joyvl72wOz2XT096lP
 v+AeGp0qbLstwS5n1q9p1uM8VWr4djSNV/PJGVXpnZr+ex+2gh1RzlTzpTrvXrL3ch2GqUzTsjw
 VqZ7aE7fCY05/np5uQ1Z7eytkVchDIzH5CEnme7Chz6w1GRe5XeC+IfsOhSVInpARnoDxs8GaOy
 zzxldn6WNZt7FAREtoXwY2vdcCjzr7Fzn+sGj0ZriCrmBZBfWgTqtzio1RCdtPbz7AOXQdDyQBm
 8HK5vXfLhZdA6mKr6LB3U5+tL/cQP0D2WeJCwRL2WBYEYbSZKOmuy8ipqjmbw7n9r9v6JtOy7YV
 a/yygfp8l1NbfDtEzDEPb8VhMQQTBhr0LN1bRxYuL5sl3YAbYPIw==
X-Google-Smtp-Source: AGHT+IGEwX+3mG+zAdycDDo2UywzC66qsNFeD/TA3ULVoaxyEpPC1lJXN7TPU5ABkwSgLqRje+68GQ==
X-Received: by 2002:a17:903:46c3:b0:294:cc1d:e28d with SMTP id
 d9443c01a7336-2962ad3c72cmr6158435ad.25.1762279775102; 
 Tue, 04 Nov 2025 10:09:35 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-ba1f86b0688sm3035988a12.28.2025.11.04.10.09.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Nov 2025 10:09:34 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>,
 Reshma Pattan <reshma.pattan@intel.com>
Subject: [PATCH v6 4/8] dumpcap: handle pdump requests from primary
Date: Tue,  4 Nov 2025 10:07:08 -0800
Message-ID: <20251104180927.403355-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251104180927.403355-1-stephen@networkplumber.org>
References: <20250811213632.16023-1-stephen@networkplumber.org>
 <20251104180927.403355-1-stephen@networkplumber.org>
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

The primary process will start to notify all secondary processes
about pdump changes. The dumpcap secondary process can just call
rte_pdump_init() and it take care of that.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
Acked-by: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
---
 app/dumpcap/main.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/app/dumpcap/main.c b/app/dumpcap/main.c
index 3621c0ebe3..46a6cb251e 100644
--- a/app/dumpcap/main.c
+++ b/app/dumpcap/main.c
@@ -528,6 +528,8 @@ cleanup_pdump_resources(void)
 		if (intf->opts.promisc_mode)
 			rte_eth_promiscuous_disable(intf->port);
 	}
+
+	rte_pdump_uninit();
 }
 
 /* Alarm signal handler, used to check that primary process */
@@ -659,6 +661,14 @@ static void dpdk_init(void)
 	if (rte_eal_init(eal_argc, eal_argv) < 0)
 		rte_exit(EXIT_FAILURE, "EAL init failed: is primary process running?\n");
 
+	/*
+	 * Register pdump callback handler.
+	 * Primary will notify all secondary processes of change.
+	 * No impact for this application, but need to reply.
+	 */
+	if (rte_pdump_init() < 0)
+		rte_exit(EXIT_FAILURE, "EAL pdump init failed\n");
+
 	/*
 	 * If no lcore argument was specified, then run this program as a normal process
 	 * which can be scheduled on any non-isolated CPU.
-- 
2.51.0

