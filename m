Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99384606A31A
	for <dpdk-dev@archiver.kernel.org>; Wed, 28 Oct 2026 14:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=AxL87jiv
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CFA6740609;
	Wed, 28 Oct 2026 15:17:57 +0100 (CET)
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com
 [209.85.214.171])
 by mails.dpdk.org (Postfix) with ESMTPS id 7FA2240151
 for <dev@dpdk.org>; Wed, 28 Oct 2026 15:17:54 +0100 (CET)
Received: by mail-pl1-f171.google.com with SMTP id
 d9443c01a7336-2ea7190aea1so4601815ad.1
 for <dev@dpdk.org>; Wed, 28 Oct 2026 07:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1793197073;
 x=1793801873; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=NfNaRxeSiTRk0nNaoduYbA1DIml+FPlns9ZlFhSOlws=;
 b=AxL87jiv/neb2wopFLynYuJkvkqtE1FBmkn5u5IjwN+Ocpxjubc0KssmI1yW4vLpOb
 wv1Ib5W2VMD/6Q2k+iXV5TT2EsY1pLX7I9aIi5JPXOf5Np8VzWZh34FRa+TA7mEqt83F
 763a737PsooRpsbnOibaG92tkruInJrg13YEo7dR2ai+gjVX/E2f3FhyCtEtbiTIng0O
 OL+P7hBSlQPJSZhxlgzU8EkSnYSpGySAUK6DPMbGOlTBUWjnn1EdRmIpCsM94w8moz+L
 SucGYU4EGRoiSTDAxl3YMlQNwbwnicmqoVfL+535KZk0h1wBgkrbLUCKgH6kiHcGJsaQ
 2+6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793197073; x=1793801873;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=NfNaRxeSiTRk0nNaoduYbA1DIml+FPlns9ZlFhSOlws=;
 b=R+BpVJJhUOQ3p6cl9umV3Wk9BXKOWvpUXJdQf3hZMNeBE7h+IcFd1jBL4zvTUr5ztc
 bfx/p5329SW3xY5jxHyosWN33BDZ4MnnI+dK89ZOL+D4R2q+kczB1YFlAJ+8K0+dN9lC
 GCKYCdF4FUOiL9roYpYaSK4WFkDZXeQR8xTPobFVlMRRsFr2I3Jx1mQG4DWNqigbWtX6
 xcOAW9/gipgh/DxKCJ1fb/JrbpJML0OiMsvd4WtwXH94+MbWfEla7sjUq8KgToQjmC2M
 Oug64/Z/wEFMMDHRyOgn1pIUgW7vt83KhZlKo5Q07EoK3ZuUAK6vHTtbYblS4hGs0dxS
 KQFw==
X-Gm-Message-State: AFq9FYJ8UKm1jZpqlmSIQ9KlrlU+HIVflQs1mOL3Vjr/HgTyxI2nvr2L
 /QqADPzSLaC8oBRppV/O2vqDVey3M9qN/kCQGogpw7oc6tHb7me206D8Yb9qC91TKkJRF9QsMJC
 Bs28boRI=
X-Gm-Gg: AYBFou2BysFVaLSgApTEIpV9Wp5zJwjhLmS26ziPZTSCCWF4GCAtTSK5kymUwoeZ2qS
 Yr748NcWdhD9eySC0gNd+N0Uw8iSWgwnstQqf8ykLkIGfVa9VGMHPotTmyqHDFdxge0tvTfaUaJ
 hKsjcJvYSbERBaRqQTZcTR1+AxQoHWEonzXVupLxy+MMuYH5BU+omwwvLdjSTKdT62oJ+UMhl4B
 Ta/xhZ2ckQr6PlBCB7W9I61xaydJf9GLqxyo047XpGO1wQy53UBVwkJhJtaVR99MNlJDMIOWAt2
 jeY4It0xJa8yrdqn43ELy29JqbbM8tAr0XIJPzKVoPov97I1w5j8rfQJFingaV3mWIPkyHAQr9C
 cESWuUi7nvs10E54ZJxXA7bysg0Ocm9UYi70C3t33mFGyjiMYGUX+Zept/8oKoBW9Q0Dsfscl3b
 I/ZwN7VzeTOmERHht77pQ83STCCuGzPUK2HTYFVJ1kBSUphiMOoLsA7eQuWRJfbcYRmMWE/kv/P
 9udkw+kCHY+TeGsEqNoCLYgG/HMC/WbGLBr9SBAC1b0hnoM/RGLdPoDvWogZ8BUxBVNG7nEj5JU
 bqN6OjiINTFoY5hsM8WjK5TLjDEXre1S8bzP26z7j4Tk67tWmZKduiCTfazFAOGftXYm
X-Received: by 2002:a17:903:13d0:b0:2e9:492e:1688 with SMTP id
 d9443c01a7336-2eb001418bfmr21544725ad.8.1793197072974; 
 Wed, 28 Oct 2026 07:17:52 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2eae6c3b67bsm22182415ad.52.2026.10.28.07.17.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 07:17:52 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Thomas Monjalon <thomas@monjalon.net>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Ori Kam <orika@nvidia.com>
Subject: [PATCH 1/4] ethdev: reject hairpin queue in add first Rx callback
Date: Wed, 28 Oct 2026 07:16:50 -0700
Message-ID: <20261028141750.310963-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261028141750.310963-1-stephen@networkplumber.org>
References: <20261028141750.310963-1-stephen@networkplumber.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

rte_eth_add_rx_callback() and rte_eth_add_tx_callback() refuse
hairpin queues, but rte_eth_add_first_rx_callback() was missed.
A callback installed on a hairpin queue is never invoked.

Fixes: cf5516696d77 ("ethdev: add hairpin queue")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/ethdev/rte_ethdev.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/lib/ethdev/rte_ethdev.c b/lib/ethdev/rte_ethdev.c
index f843e8808a..562a24d559 100644
--- a/lib/ethdev/rte_ethdev.c
+++ b/lib/ethdev/rte_ethdev.c
@@ -6173,6 +6173,11 @@ rte_eth_add_first_rx_callback(uint16_t port_id, uint16_t queue_id,
 		return NULL;
 	}
 
+	if (rte_eth_dev_is_rx_hairpin_queue(&rte_eth_devices[port_id], queue_id)) {
+		rte_errno = EINVAL;
+		return NULL;
+	}
+
 	struct rte_eth_rxtx_callback *cb = rte_zmalloc(NULL, sizeof(*cb), 0);
 
 	if (cb == NULL) {
-- 
2.53.0

