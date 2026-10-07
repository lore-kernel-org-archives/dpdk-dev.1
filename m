Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72742CA6004
	for <dpdk-dev@archiver.kernel.org>; Wed,  7 Oct 2026 21:42:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 43E144281D;
	Wed,  7 Oct 2026 23:41:29 +0200 (CEST)
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com
 [209.85.215.172])
 by mails.dpdk.org (Postfix) with ESMTP id A384B427D7
 for <dev@dpdk.org>; Wed,  7 Oct 2026 23:41:27 +0200 (CEST)
Received: by mail-pg1-f172.google.com with SMTP id
 41be03b00d2f7-cc4d192643dso1065382a12.1
 for <dev@dpdk.org>; Wed, 07 Oct 2026 14:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1791409287;
 x=1792014087; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lioAldGG5zTEHfPK2eWAuZ4LAdSS1FRBVVP1a6yD+L0=;
 b=FEIwWovlVknl/L6sQx8dCJltcXTq2YHE6CLY92gq0vGCCV1F7SRpUwDKrd3+2+OiVL
 Q/ysTRn4qKhP6NKqlK7pYwCY6fwdXiLrjhI4XvNA8Rx6p3lY4PTRAJUs8FANH0zJHsQ+
 q2oN2WIPDzXIukSqABEiSAO4rkBvG0AjP0XTjG6Q/TZhY02flb2m6EFvSQviIKVM15CP
 dV9JEHOgVtZ8u5/KxAd2WISFPBcrh52cTq33TsPl0F79HObHtK9Tc53JOAIQxvBcfdfB
 N9IPneTltzGc0+Rd1/2atYrRNpVLKJ+0sAZc85EotMav9EGwUND+vEFJpGS2tsULdVrV
 VxNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791409287; x=1792014087;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=lioAldGG5zTEHfPK2eWAuZ4LAdSS1FRBVVP1a6yD+L0=;
 b=HH66VkyFM2USIwlSiR88+d+b2cwd4FTs9ArnflGBKWEsQl2oCIRqvxwYKkGAvgBq5Q
 3MwVk0cxKvvOWJIP697wH3msPyxBtsGybj3HVk3XdsXZqjIjRTVL0IO2eM8wTbSG3fRW
 Fmcqo3CYz2WmJtD+lvcQjSuavZOuZ4HdI+6ZW+UNkiWywjMfQXf7YYvTAw59puFwsf7T
 weKvWiLOosZEKxjogwIYCVY1FdLcI8ycI3RmE4s3yNiRHEXrCseUpsdO6CTUcp/nDP8P
 SVAmWQM3lJigwAmdkkXUa58cnIA6a5CiKFn98KFn2c9D9bpZLxGX7Y4oMMCvkDFh6W6j
 3p6A==
X-Gm-Message-State: AFq9FYIZ0L6GHoiAXX6tjEUVS6RRGZKZJnn2l2Rx81+0KQD5GcUoHibK
 QUTxnENi7NKmnh/5K5tlGG0w36CaQUvCjFP5Wt3SRlzlBlBdGwLj3aTdwrkV/wqW3s9CJAhSNo0
 vVI2SGps=
X-Gm-Gg: AYBFou32D4whacp39zOTeH6gzQM196w1KNlqd+NQdo8k/4WwwEmkqIUENmKYnUeQMsC
 aKnKO89eiI9W1S/wF6RX8QwnCIm++EEiUcW0qQgX68RboohXDYXgqaEYps0TWkO+3pD4EHgzZx5
 GTu8RKr+o7gTxOrzmI1SYsM/dgJmOKIYQW4vq5IeRwJEHgM96JjPYFbh9eTb0snUq4cbLFzGisy
 Cp1ek0vl09FCc/lisr93em36c6MA15uK9r2m9bkrHSJBqbVEHqvuPkzTtoj/l+UsZBQn48OjEOl
 IUc67ZKMffTabHIbavma1m/3LEGB+dm56UnTyT7gLM6b1LH1w5nJF/Nltsiw5h6l89OTG9h+ZHc
 7CJ9uTUwhBzYKcsltpkh368tZulzl9hFKgFybMvYt3BzzXMggn8QPWG6grMwQAi32O6oP3jhhA3
 Oz6RYFkV4zAUnl4M652mUxqrwZU1k4RKNJkgvB55PU29gnShsdGuCt0LRH7KzWO49D+ZQq4kxrU
 xVOBFe5cGT7kQ8dQ9h0k9b3VFEf21N3qE8lmP/Ehnjombxn
X-Received: by 2002:a17:903:4686:b0:2dd:ad73:5b69 with SMTP id
 d9443c01a7336-2e60036cef4mr29030115ad.25.1791409286539; 
 Wed, 07 Oct 2026 14:41:26 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e60484ca89sm16573335ad.57.2026.10.07.14.41.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2026 14:41:26 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Thomas Monjalon <thomas@monjalon.net>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: [PATCH 07/20] ethdev: promote link connector to string to stable
Date: Wed,  7 Oct 2026 14:39:37 -0700
Message-ID: <20261007214115.3092715-8-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261007214115.3092715-1-stephen@networkplumber.org>
References: <20261007214115.3092715-1-stephen@networkplumber.org>
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

rte_eth_link_connector_to_str() was added in 25.11 and has not changed.
It is a pure enum to string helper with no driver involvement, like the
already stable rte_eth_link_speed_to_str().

The xstats counter enable and query functions are left experimental.
They are currently implemented only by net/mlx5, so the interface
should not be frozen before a second driver has tried to use it.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/rel_notes/release_26_11.rst | 3 ++-
 lib/ethdev/rte_ethdev.c                | 2 +-
 lib/ethdev/rte_ethdev.h                | 4 ----
 3 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index 3ad6ba2d81..ac8ce1d9a5 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -300,7 +300,8 @@ API Changes
   * utility functions:
     ``rte_eth_get_monitor_addr``, ``rte_eth_representor_info_get``,
     ``rte_eth_buffer_split_get_supported_hdr_ptypes``,
-    ``rte_eth_timesync_adjust_freq`` and ``rte_tm_node_query``
+    ``rte_eth_timesync_adjust_freq``, ``rte_tm_node_query``,
+    and ``rte_eth_link_connector_to_str``
   * buffer split and error handling types:
     ``rte_eth_rxseg_split``, ``rte_eth_rxseg``, ``rte_eth_rxseg_capa``
     and ``rte_eth_err_handle_mode``
diff --git a/lib/ethdev/rte_ethdev.c b/lib/ethdev/rte_ethdev.c
index 7c57a9bb8f..338be3a289 100644
--- a/lib/ethdev/rte_ethdev.c
+++ b/lib/ethdev/rte_ethdev.c
@@ -3329,7 +3329,7 @@ rte_eth_link_to_str(char *str, size_t len, const struct rte_eth_link *eth_link)
 	return ret;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_link_connector_to_str, 25.11)
+RTE_EXPORT_SYMBOL(rte_eth_link_connector_to_str)
 const char *
 rte_eth_link_connector_to_str(enum rte_eth_link_connector link_connector)
 {
diff --git a/lib/ethdev/rte_ethdev.h b/lib/ethdev/rte_ethdev.h
index ae43420cf6..a3642b3c6e 100644
--- a/lib/ethdev/rte_ethdev.h
+++ b/lib/ethdev/rte_ethdev.h
@@ -3075,9 +3075,6 @@ int rte_eth_link_get_nowait(uint16_t port_id, struct rte_eth_link *link)
 const char *rte_eth_link_speed_to_str(uint32_t link_speed);
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change without prior notice.
- *
  * This function converts an Ethernet link type to a string.
  *
  * @param link_connector
@@ -3085,7 +3082,6 @@ const char *rte_eth_link_speed_to_str(uint32_t link_speed);
  * @return
  *   NULL for invalid link connector values otherwise the string representation of the link type.
  */
-__rte_experimental
 const char *rte_eth_link_connector_to_str(enum rte_eth_link_connector link_connector);
 
 /**
-- 
2.53.0

