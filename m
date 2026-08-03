Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8F44C55184
	for <dpdk-dev@archiver.kernel.org>; Mon,  3 Aug 2026 16:55:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5E0B740DD2;
	Mon,  3 Aug 2026 18:53:37 +0200 (CEST)
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com
 [209.85.210.171])
 by mails.dpdk.org (Postfix) with ESMTP id E4A2B40B90
 for <dev@dpdk.org>; Mon,  3 Aug 2026 18:53:30 +0200 (CEST)
Received: by mail-pf1-f171.google.com with SMTP id
 d2e1a72fcca58-84e0688b7e8so3482016b3a.1
 for <dev@dpdk.org>; Mon, 03 Aug 2026 09:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1785776010;
 x=1786380810; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=o9kkitIcACETudCuT+/j9pUjDFYrlmx4NX5ndvaDZ7s=;
 b=aGWCF/v0D/OAakCclgV0KBVN2Z7nIvWk9UOmGNer24DBSiJfTUknhiD5rVANgumXD9
 iBsiMqmWLJQQOQH0E9mSbCTa7BqG5KHWr4dwSmwjzgoD1ghEXd8TCHXZMec18u7zyv02
 8fnq6EqsYcbzk+VhP6k7uSRMMH8YJyUMbL8cyGW/Egzu1pdxG9qoLa+nrWfaLMql6Kyr
 o5fME/XAMFpKQC83IcieRN4sIs9bd3qSo9FIzCqEze0N4cykesdPInsXk2f9y54889qX
 f7cyV4Bp+QVg0HRHQT3siC86JUOGxAF7ehi80n8jMTGnJi6zQ4FZkHgwxlBChsqSHgav
 BrgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785776010; x=1786380810;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=o9kkitIcACETudCuT+/j9pUjDFYrlmx4NX5ndvaDZ7s=;
 b=RAaayrrutJMh1hmR6e0K6bb4opKylA7mv2GsWXbUcCLr26BD3RfXz0TJ0dBlK5pJtd
 WK0h5rPEKyL8RMD/tRQU8Ok8MwcSwTxsBygV4/mOXX4Kt+1T0HhlJf03zSzw+RAWPJnh
 dVmRi7tkFdoOb54/MrN/hf9BbR8bj2Q0J4gM7rwyUg3k66LLCLXyt6e1bQ4DgeAGUHwp
 06wqblt0CNM8X0/nYrH851wrZj9mmsXpeBDQl/QKe2+6BTsJcrpQJg0ZInBcH3A0nWXI
 Zke4uZNakZPeEggNtLQXdwM9XY1QENLNY8NOZbGYkO832yqbcJhHHTobHgESg3r8zCzw
 Uhiw==
X-Gm-Message-State: AOJu0YyCtZNwY7JVIQ7nYGNvSAUKE88yqfPfPyheLmGvQgI9s/jidjgd
 MEjFnyqLINjmIVt4Z5FaJn+/y0LHJqRGe49/7rFFhSMNkDYWPYHe9lZ5wehts5hpkIx1zA/D+wy
 2aLdv
X-Gm-Gg: AR+sD10CByomRm0rvgAOEbkK1Xw4XfvtScKxL7II2XNOfB+it42fY0R5ElsJW6CZhsO
 bwmHg1o27r3KKkA3abpPrP4cQuSlr4QXecvIAtYBWKML7zSerdIICMdK7Dvm6k/tKNR7NCxBmGN
 sQs2PNf1Izqu1MZcyZ5hpfcgSvLQeQBAl1uRtXHPoWWyPeM8ZicMzYEHxsorcL+JKvSLnA+vgQ3
 eyESeFk02QY9qIYDPqDkxdLrps/ujDQwhvnRAkfHcGqgIpdxuPRGwNzikW9WQT/uZSW017zaNWj
 o9CmCDMFQmGTS+XxGU46R1oOgDYd52FeHCVTBYY6RA8D3PjXk8M0RtFVH195KPvXk8A9a5MxLbe
 v9rE9egzvVPry2G4NjpOO+1lmWmjYpAv8U+5eGLT1npSMF9oJmPkMwZXxsNv87+Tisc/3Ny6hVj
 YRU/PcMxQJUyBNwHp7n5eGNO914n/J0JCKr1b7Pcm7peUSs1gxk7kVN013CPdaefKPJeHFwrGbN
 doiawRYolLAk8LIibav+NjWoZU=
X-Received: by 2002:a05:6a21:50a:b0:3bf:983d:e9b4 with SMTP id
 adf61e73a8af0-3c92a749950mr11307435637.33.1785776009970; 
 Mon, 03 Aug 2026 09:53:29 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3153dd4e5b0sm37711635eec.1.2026.08.03.09.53.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2026 09:53:29 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v2 22/22] doc: add release note about rte_ethdev changes
Date: Mon,  3 Aug 2026 09:52:08 -0700
Message-ID: <20260803165304.289869-23-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260803165304.289869-1-stephen@networkplumber.org>
References: <20260803165304.289869-1-stephen@networkplumber.org>
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

The changes to rte_ethdev are visible to applications,
which may need to include some network headers directly.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/rel_notes/release_26_11.rst | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index c8cc86295d..a5e049ac04 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -77,6 +77,15 @@ Removed Items
     ``rte_rib6_is_equal``
   * table: ``RTE_LPM_IPV6_ADDR_SIZE``
 
+* Removed the experimental flow director API:
+
+  * ixgbe: ``rte_pmd_ixgbe_get_fdir_info``, ``rte_pmd_ixgbe_get_fdir_stats``
+  * i40e: ``rte_pmd_i40e_get_fdir_info``, ``rte_pmd_i40e_get_fdir_stats``
+
+* Removed some testpmd commands:
+
+  The ``fdir`` option in ``show port`` and ``clear port`` were removed.
+
 
 API Changes
 -----------
@@ -93,6 +102,16 @@ API Changes
    Also, make sure to start the actual text at the margin.
    =======================================================
 
+* **Changed ethdev include files.**
+
+  * Dropped inclusion of ``rte_flow.h`` in ``rte_ethdev.h``.
+    Applications using flow API should include it directly.
+  * Network headers ``rte_ip.h``, ``rte_udp.h``, ``rte_tcp.h`` and ``rte_sctp.h``
+    are no longer indirectly included by ``rte_ethdev.h``.
+    Applications should include network headers as needed.
+  * Legacy flow director definitions are no longer included by ``rte_ethdev.h``.
+    ``rte_eth_ctrl.h`` is removed. Internal driver definitions were moved to ``ethdev_fdir.h``.
+
 
 ABI Changes
 -----------
-- 
2.53.0

