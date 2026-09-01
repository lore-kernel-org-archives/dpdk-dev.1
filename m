Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0D0EC61DD6
	for <dpdk-dev@archiver.kernel.org>; Tue,  1 Sep 2026 23:10:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BE07D4064C;
	Wed,  2 Sep 2026 01:10:49 +0200 (CEST)
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com
 [209.85.216.41]) by mails.dpdk.org (Postfix) with ESMTP id B702A40281
 for <dev@dpdk.org>; Wed,  2 Sep 2026 01:10:47 +0200 (CEST)
Received: by mail-pj1-f41.google.com with SMTP id
 98e67ed59e1d1-3964e76d0f4so438194a91.3
 for <dev@dpdk.org>; Tue, 01 Sep 2026 16:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1788304247;
 x=1788909047; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9s4tSOf6KEO9Ns4VPPTt5uMQMFEpG0Uv7tHLGMaChTM=;
 b=RIyEubYuepq1vIlrVAl8CILJq/HhSp0Sj5HLc8GdWvI/6FuuoR5bftL8VzyTWQsGZF
 btFHaDqQKfTK3/ELB1i0pI7QbFI4mytquWRUSXfPkTypkbusb1C7fdack+4XIp2ivxEZ
 0b9YcLwwRT0oZCqFQAWiy24h3i5RTpu0NRvOgMDpiFY5UDz+24OaRCfQsFDOVAqjESzU
 yiWRqhQTPnBo9e/1ObE0BhsDILptVdOAS3eJ8xpbGOYAY1PGQdReH+mo3RNky4Ptpmw0
 awYRgESwIFrwZiC0iY/SFYtxUkUqmqnpCfSG+ucN2hKIjLgYo5yuLWb28HKvPzC3md2f
 m+0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788304247; x=1788909047;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=9s4tSOf6KEO9Ns4VPPTt5uMQMFEpG0Uv7tHLGMaChTM=;
 b=ikgVXV74A1+4v5pjWfwftOuQmPtY47xPBd8XquvWAqAMiVT8ir/Uc0jS+1VgbwZ/sk
 L1BmuSRJQowOxoHMGHDaXBltF1t6z7qefKwO1QiwJ+b576KE8+reZitk3YP1Tj/qj2IQ
 5cVJmHdQpiJYdvNuXt1a/FHhWkci8e+y7CWBSoFZcZDrhETwJvgvE6g5oFalC57TdYcZ
 3ybT775tMOqIKtSHGJqhwTdQanF3StBoK7R+JaLckUQHlnOm8jzeb13juKD63UcYBWAU
 Hkjxo9ZFwJnxOCvDQHkic+fEZrnS7NAv1F2CTRJmr1H6J2GkNuCykUTgGolhniVkRrHp
 LN1g==
X-Gm-Message-State: AFuF++krqFd2ZoYVUhRElH1ewrnNwZ/zGo4RcH2jwLdxFa/3TZ52ZeBZ
 AOW7D9DLrDVuZY2jubZ8xj+8Y8Yoblr3xmvFvn+xzlWhgUBUO0tF6eEJsCIablfImoN2Ltwbw1E
 2ZdID
X-Gm-Gg: AYBFou1Zy1vdjFa0R4Ia9rNs7uQcUn8ZGfaTAvseaaMqpb0qqfsrDN6OWuuJzaso6Qv
 CeX2YxOTDOr2+qqf3IwIPpB+DlcyBoInYY/m0s/R3z5ZTjfbNKqS34Lg/8xNNn/72idgzzbaAos
 SUwaOgDb00kir181ek6QgOXzRD/XRlf/QjvoAQeSBdSZafiIVRXX0me/XH+lWgrM6Nr9XFXQL96
 4f4Aok1YJiVrepG4RuVvp9ww87nujcZa0wGKO8fVncDr3RWv2iQdxInDccgjNSjIc16w66qoc7b
 XHkgoREDO2Fmc9uy39ibPi30Lk5fSdK6iX0cpkkJzZvoSygiPqMNhCJQuOuuio/3ISUbJCz0gW7
 mSYorb1sG8OMQWvnHiE5ZPUdn8RboIMtLfbrg+97Unsi5KmGvqNV/XVZBWOeIPpmjgFB6CjD9f5
 7ai9RWqrlLijnXgu+xydzhCWYqLKDMIYyM8EPVW2cMpCWgaDi9wjbOGmQaBVEwLwULwiy9Glkeu
 AEHyKTDZklbWqZy9WQoiU5Ilh5N0y1jk/WSMZk=
X-Received: by 2002:a17:90b:520f:b0:398:9c00:29e9 with SMTP id
 98e67ed59e1d1-39aee1b72e5mr558807a91.17.1788304246798; 
 Tue, 01 Sep 2026 16:10:46 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3990d80433dsm7614260a91.17.2026.09.01.16.10.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 16:10:46 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, Ori Kam <orika@nvidia.com>,
 Thomas Monjalon <thomas@monjalon.net>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: [PATCH 2/2] ethdev: remove deprecated shared flow action
Date: Tue,  1 Sep 2026 16:10:33 -0700
Message-ID: <20260901231033.169368-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260901231033.169368-1-stephen@networkplumber.org>
References: <20260901231033.169368-1-stephen@networkplumber.org>
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

RTE_FLOW_ACTION_TYPE_SHARED has been deprecated since 21.05 when it
was replaced by RTE_FLOW_ACTION_TYPE_INDIRECT. It has no remaining
users in the tree.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 cover-letter.txt                       | 12 ++++++++++++
 doc/guides/rel_notes/release_26_11.rst |  3 ++-
 lib/ethdev/rte_flow.h                  | 11 -----------
 3 files changed, 14 insertions(+), 12 deletions(-)
 create mode 100644 cover-letter.txt

diff --git a/cover-letter.txt b/cover-letter.txt
new file mode 100644
index 0000000000..ecbd3239e2
--- /dev/null
+++ b/cover-letter.txt
@@ -0,0 +1,12 @@
+The DPDK policy is that an experimental API should be promoted to
+stable after one or more releases. A large part of the ethdev API had
+been left marked experimental long past that point; the meter API, for
+example, has been experimental since 17.11 and is implemented by many
+drivers and used by applications as if it were already stable. This
+series promotes 119 ethdev symbols introduced in 24.11 or earlier whose
+prototypes have not changed since, along with the stale doxygen
+EXPERIMENTAL warnings on structures and inline functions. The patches
+are split by feature so that each can be dropped on its own.
+
+The trace point symbols are left experimental on purpose; trace
+infrastructure is intended to stay unstable.
diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index 591718253d..7f278d4645 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -71,7 +71,8 @@ Removed Items
 * Removed deprecated symbols:
 
   * eal: ``__rte_packed``
-  * ethdev: ``rte_flow_copy``, ``struct rte_flow_desc``
+  * ethdev: ``rte_flow_copy``, ``struct rte_flow_desc``,
+    ``RTE_FLOW_ACTION_TYPE_SHARED``
   * fib: ``RTE_FIB6_IPV6_ADDR_SIZE``, ``RTE_FIB6_MAXDEPTH``
   * lpm: ``RTE_LPM6_IPV6_ADDR_SIZE``, ``RTE_LPM6_MAX_DEPTH``
   * net: ``RTE_IP_ICMP_ECHO_REPLY``, ``RTE_IP_ICMP_ECHO_REQUEST``
diff --git a/lib/ethdev/rte_flow.h b/lib/ethdev/rte_flow.h
index dcd1dbf03e..869cc9a26d 100644
--- a/lib/ethdev/rte_flow.h
+++ b/lib/ethdev/rte_flow.h
@@ -3059,17 +3059,6 @@ enum rte_flow_action_type {
 	 */
 	RTE_FLOW_ACTION_TYPE_SAMPLE,
 
-	/**
-	 * @deprecated
-	 * @see RTE_FLOW_ACTION_TYPE_INDIRECT
-	 *
-	 * Describe action shared across multiple flow rules.
-	 *
-	 * Allow multiple rules reference the same action by handle (see
-	 * struct rte_flow_shared_action).
-	 */
-	RTE_FLOW_ACTION_TYPE_SHARED,
-
 	/**
 	 * Modify a packet header field, tag, mark or metadata.
 	 *
-- 
2.53.0

