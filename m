Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECDF5C982D6
	for <dpdk-dev@archiver.kernel.org>; Thu, 17 Sep 2026 14:36:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1759242E5D;
	Thu, 17 Sep 2026 16:36:36 +0200 (CEST)
Received: from mail-ed2-f12.google.com (mail-ed2-f12.google.com
 [74.125.228.76]) by mails.dpdk.org (Postfix) with ESMTP id 90E3542DD0
 for <dev@dpdk.org>; Thu, 17 Sep 2026 16:36:33 +0200 (CEST)
Received: by mail-ed2-f12.google.com with SMTP id
 4fb4d7f45d1cf-6a98604f6b4so1466402a12.2
 for <dev@dpdk.org>; Thu, 17 Sep 2026 07:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789655793; x=1790260593; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0rirXxHnXhmTxV5wTwzbAl8MVBX4+fwxzfzdMKPtgJE=;
 b=QyjvLK2j7zYtNjx9NfPdqePA9ww0mUfoUCZUK1f7RsqC4i0jcUgzuwvaSZGBi5ySfg
 09OexCD3SRit7jaHLuaF6EOrYdUA5w3uy/qsSAXMif4N8thzuwKCIO9hp8Xgi2d06AB4
 E8QVLjbK4qGMab3/V8nfEbnHGQxcepqVD8Gr2CzE4SLUh5yauo3QvjBmtBXTpb+v93AK
 Jb9CeDJJ6eQcmCH4QIjFblfo+4Md110p8vBPpcB1AT/DELPozBuK0HCDdxd/swfIMCE4
 xkPHZ5xXc16MW556zkxbLPMWrW1MoDvSMscwJOgjO5HSrtFrKkZG5RR7gtP1frt3tUu1
 VDaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789655793; x=1790260593;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=0rirXxHnXhmTxV5wTwzbAl8MVBX4+fwxzfzdMKPtgJE=;
 b=ftImbo1xQdMI4u9M62hNnJ5DsW5hasqZJaeQIeV0pCKk0QcX345Zvj1ZmQB83zcteP
 UNbIbDm7BTr0yZQt7Jv0UdqybIKV4hAZjKWoiXglWv9Fi3bXLH+5FWHE6LeSfYgLcpbC
 vZRLUT28IXA5pPP1hJ2lMXuuo64gZkIGtduM+dXRZ9sXaFl15XFwvFh/rXPtADqrxFDn
 /1rLsBOn+3tqTezEjVwCeQeb46l1WvrL56Ns3RX7TUXY3qKx81BUqSTIG3pWC8rjbe91
 k5WL3EP5yh1Pi1nDvw7AdrB/LJM+BO7dzYd7f1t7VK2d7AttjHdJKJBWS+oURZzYitW8
 YzlQ==
X-Gm-Message-State: AFuF++lfZcIQ7b2PnKBKYxI4Cn2qTA/fmCCshKhcFQ+bNXpjQ5nKForO
 dXZFEczsdh5G+rIAucigMet752DmzOJqbkDq4OqR2+7MZNKuKKoG0zDk
X-Gm-Gg: AYBFou2PHSO0vNCB9riT+9NyJO8KqyvKSF1uCC5MfFsyYeO1tmi6fcKFXGb1LR3Nrf3
 VVvld5Y3V+uefGi/JPm0hIF2mwH6MHTg5P3Be+qWSx9FBKjmYh0skp1sWhu5FgmJE3n+A59nECc
 ZiodmBK+21+ARfWhAsiPhNLLlD/+4vsgso9nV0vOKpIP5D1OCMZlruWqT+f3g+r/oHlI+AeH3Ji
 Jf+hYG0MTT7u+OTv1ZaIVHaHaan8boHfe1EOvxq7fE/yQBQtqHAkZRSAP5uzMdn1z6WOPyeFNYd
 3Ky6GVTNqhsgztBJaQ26KniRtdvySxkw2AL5Wn09nLJApmrCAg0Go1bv4ozl/0IoP3FGNfTu6Vf
 neuyFKY4E+mTmtWBeLRam/JpHz/r83z2Pf1RKFzc1w0Gh1V5FY25jTpN4Yb8ncMtJx1Uli7EjvC
 oFAsAJh0v4kG9rLHJRtxS9OCtUxQRpk3cl+DZcJwVQTOpR0goceV3GIQpDbLU=
X-Received: by 2002:a05:6402:a0c9:b0:6a9:b800:3347 with SMTP id
 4fb4d7f45d1cf-6aa2223bf49mr4797370a12.8.1789655793111; 
 Thu, 17 Sep 2026 07:36:33 -0700 (PDT)
Received: from dpdk.lxd ([89.101.57.120]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6aa1d2727bfsm3440986a12.20.2026.09.17.07.36.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 07:36:32 -0700 (PDT)
From: Marat Khalili <qm2k21@gmail.com>
To: Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Marat Khalili <qm2k21@gmail.com>
Cc: dev@dpdk.org, Marat Khalili <marat.khalili@huawei.com>,
 Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v4 1/7] bpf/validate: fix finished status on restart
Date: Thu, 17 Sep 2026 14:35:31 +0000
Message-ID: <20260917143539.46951-2-qm2k21@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260917143539.46951-1-qm2k21@gmail.com>
References: <20260915192626.48125-1-marat.khalili@huawei.com>
 <20260917143539.46951-1-qm2k21@gmail.com>
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

From: Marat Khalili <marat.khalili@huawei.com>

If debug session is reused, requesting evaluation result while
evaluation is still in progress would successfully return result from
the previous evaluation instead of expected -EAGAIN error.

Make evaluation start clear the finished status.

Fixes: 6b0da0602cc7 ("bpf/validate: introduce debugging interface")

Signed-off-by: Marat Khalili <marat.khalili@huawei.com>
---
 lib/bpf/bpf_validate_debug.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/bpf/bpf_validate_debug.c b/lib/bpf/bpf_validate_debug.c
index 5d18804a74..9a03976632 100644
--- a/lib/bpf/bpf_validate_debug.c
+++ b/lib/bpf/bpf_validate_debug.c
@@ -568,6 +568,7 @@ __rte_bpf_validate_debug_evaluate_start(struct rte_bpf_validate_debug *debug,
 	debug->last_point = NULL;
 	debug->pc = 0;
 	debug->evaluate_started = true;
+	debug->evaluate_finished = false;
 
 	const int rc = debug_send_event(debug,
 		RTE_BPF_VALIDATE_DEBUG_EVENT_VALIDATION_START);
-- 
2.43.0

