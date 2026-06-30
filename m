Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AB69C43458
	for <dpdk-dev@archiver.kernel.org>; Tue, 30 Jun 2026 15:38:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 949A240B8C;
	Tue, 30 Jun 2026 17:37:45 +0200 (CEST)
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com
 [74.125.82.176]) by mails.dpdk.org (Postfix) with ESMTP id D795A406BC
 for <dev@dpdk.org>; Tue, 30 Jun 2026 17:37:36 +0200 (CEST)
Received: by mail-dy1-f176.google.com with SMTP id
 5a478bee46e88-30b9e755555so926383eec.1
 for <dev@dpdk.org>; Tue, 30 Jun 2026 08:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1782833856;
 x=1783438656; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=33qXM3QfYqGeUSVTUFNODD/wkWrFSJJxhg4W3cuLuoc=;
 b=D97bJYaBPd9dX/CLS7uOMkGZ8EDpFXub+duIgtclr2nirfs4FBxFuKj10Rb7sTvYy+
 LEBwh1CiFW2/wi33eMNJyHeIL6IeR4u/dPCMHjCFSiAfd3rg6vM3+kK9ud09WUWIjrxP
 8lg7DkJZV4nrA7oTTrW633yCZpKYpQvIh7EWZD+9jBi+DV52UQ5bctgBy2ApjiUPpre3
 HVNJLoNF2wvIXkwpBwSYCGjZeMYGOjyA+D2nAyiqQBZq+EiBiOYegC3W2RDM1svkMTSW
 vIuQMnw0/V71KNA3x3eA0GNFTtouEEgyglxSU4HtlWC2w1hcp5gmndpn+OzXcvcBot13
 C36Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782833856; x=1783438656;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=33qXM3QfYqGeUSVTUFNODD/wkWrFSJJxhg4W3cuLuoc=;
 b=UVU2ekmNolRZ7+u+i8JaAGQ9fK1as3vbdKEN10vp9Gxs+PPXHbSRXYtRpVGCuxzs/f
 s9N+/+3m/voGpRVWeP2mgMwAXT/NhzK8vFq6DAxo7SpH+wHFxD4llmS7XG1mV1jPBi7V
 eQVoKF1KJITs16UxA8jgXpPyFZOoRoVCLhKEkB7VTnuc8eb8L0ZrcBjDxjacQC7B76zL
 6Mua0wJbgZFmidS/dNQdMyh46lq2IexF1ms8aFk6FCJI/9gQZK/krYVu3rmsV7kC5nLn
 5cL3fHNk/yMAbrS8oEcWaEaFaI921dvPkMvBtKY6S/TyqlPx/ZwKjJYlUFWq8yN/qDcF
 Ni3Q==
X-Gm-Message-State: AOJu0YxdhmqoXS4BrnPJAQzhObjvLKvn3hzdxzz/RwhNKd35uGw+26XF
 wQ4tah0ImpxB/Ks42z8VC/sXbpR5KLOU6vG67Kq8PfpeGTmDISltDjrHcxOd/FEA9LX2D4DbO5H
 qQj8z
X-Gm-Gg: AfdE7cnf8v4ygJYUNpp2C3oAw4/bMGOueiedf09/BYylTVb4zKoexiy6fo4BmUoTOiZ
 Iz1vuDU1vUGaP9fS5tjYJYOpqYGDd8EmUuxyBhP0kV7qOqD6/WBQsQB4yM3bGrudf1iTy1KYuIC
 SR4G5nl0NxY22ytw0GhbrCwhW3DBdyM4pzXnWNTFALnhA9B/IsQgnVUnYFVCnebisf7pcu1if6x
 SuhPJU2MytAKhhtIFk7pZMS4nbpD8C103WLoRDTRokexf3Fvs7jfR9Y1DZDdbu0G9IpkhHiqE4E
 NidTW2L2Q0zguoOGzGl+i+HBmU3A9SvBXtVFhtGny7Zb6LPb0Ic67xs4kwppAn+DtHpTFQ33j3j
 K9HMbLqp7gxPvQm7M1/NonBUdem6yR2yUl7+QAI7w5XeSiXJMTxoiwiFosd4pcLnHPtYH2WMKfB
 JI4fBXQzBmvSeerbdLo7woCbS09cB3BjvD/2gfauOpLfHxpyhzRibJpBq6bUo9Ug==
X-Received: by 2002:a05:7300:a945:b0:2df:7fe3:96a with SMTP id
 5a478bee46e88-30ef03e3120mr830255eec.0.1782833855932; 
 Tue, 30 Jun 2026 08:37:35 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30ee2fc21casm9072139eec.10.2026.06.30.08.37.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jun 2026 08:37:35 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v2 8/8] doc: add release note about ip_frag changes
Date: Tue, 30 Jun 2026 08:36:20 -0700
Message-ID: <20260630153723.525167-9-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260630153723.525167-1-stephen@networkplumber.org>
References: <20260616210656.464062-1-stephen@networkplumber.org>
 <20260630153723.525167-1-stephen@networkplumber.org>
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

The changes to ip_frag might impact some conformance or
performance tests.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/rel_notes/release_26_07.rst | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/doc/guides/rel_notes/release_26_07.rst b/doc/guides/rel_notes/release_26_07.rst
index 4ca0a9ac77..a419803401 100644
--- a/doc/guides/rel_notes/release_26_07.rst
+++ b/doc/guides/rel_notes/release_26_07.rst
@@ -241,6 +241,12 @@ API Changes
   - ``rte_pmd_mlx5_enable_steering``
   - ``rte_pmd_mlx5_disable_steering``
 
+* **ip_frag: hardened IP reassembly against malformed fragments.**
+
+  Duplicate, overlapping, oversized, and (for IPv6) per-fragment-header
+  fragments are now rejected rather than mis-reassembled. This changes which
+  fragment streams reassemble and may affect throughput.
+
 
 ABI Changes
 -----------
-- 
2.53.0

