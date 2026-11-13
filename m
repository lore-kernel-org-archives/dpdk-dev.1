Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0A2606A33A
	for <dpdk-dev@archiver.kernel.org>; Fri, 13 Nov 2026 19:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=FEPGs5Vr
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 595CC4028E;
	Fri, 13 Nov 2026 20:45:29 +0100 (CET)
Received: from mail-pj1-f98.google.com (mail-pj1-f98.google.com
 [209.85.216.98])
 by mails.dpdk.org (Postfix) with ESMTPS id 7D5BF40264
 for <dev@dpdk.org>; Fri, 13 Nov 2026 20:45:27 +0100 (CET)
Received: by mail-pj1-f98.google.com with SMTP id
 98e67ed59e1d1-3ae6b4c669fso1537057a91.0
 for <dev@dpdk.org>; Fri, 13 Nov 2026 11:45:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794599126; x=1795203926;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=WS+XYzFVTnNlU7a/zYTUGg0jdspe6g0f+TARBqRYb3U=;
 b=UEmjHdItrAx12aCoYudoFUDGHMVVTD2OtpdnXKgIVi54P3S9+/ajK5uDpGoZdVPDi5
 dl7vAkZ6BOXUXVIVPVMEBPcMYmL5RZneT42trSzp7LIKUEkHayeVgbBlLmPhnonoWoJ2
 h5HLL5f+wsm6TPoCWo4W4VWmgefs0lEP00MqofkfJYXhy39WPAoz3SJQkffVOqDVsmcq
 p/WPHF3CZ0U6bt/ikQlm9G53FXOHWY9t51mJH2csaUnKAMOfo06rSq+AFu1c6SByflu3
 FmwGbmQ15qrTIoy4JXqXT+G/i+DjsfBqQKrXcJsCiuqbweTnZYjoX4cN3MOyJTntnvSj
 8+mQ==
X-Gm-Message-State: APuU4Z/oeYAKnD1U9wXw/Ox/HcS9t2fLkpDgNntm7FechK0RQ4ZHyuXM
 H24hzShNY7vJS+YN5pj2bHJEm6cIflHC9yqt9AHOHJEdo/gcyfVyVdNnRPPitVBa1P7GEquWlmJ
 zAiLP4U3vW0Woy9CKo4Na2ccOmgZB2z8dR+fUu/nJJfyALN4g8ce9/fIMIaxVeDOcsoVgtPMfZA
 5zy1Wv0eBQVgcHNRhx8EWVmaViwWc9DFjIGeYvvg3XK8j9rgfRe+fpAwS9VNDP0xNXY5Na0sZg0
 IxfjA==
X-Gm-Gg: AYBFou2BEkqw43yE4+51giQPhIOwyEismnNeVt4GsOhRWwgcNtkHATyvFsIiKRAMdNz
 w//To9Wura8h+ULpxfhM2SNazQ+7gNrb9aYFgjJ7bJKfXNq8v9D5HLfPRoUQ4uWWw2rnVnfg0Li
 HKLj1dppxsJ2jaWg34vuveV72wUMtklilOiP0QOaNyInz8lOnNoIbTOPMg3AoS3twzDQ7Mv4fyq
 kBMJOyK3XIUbE6ycbM4Uo5DmUQuBpoz4pSo6pvBurKou7XzP30wazIUN4mviNlqJZCVaava7mkm
 BVWAClWF+d2hrLNqVwVEugRUDvvEztzJa6Z0yjb5uE7JoGJgBucducYTFEYva3LLQ9t/WMZ5Gvd
 /NOH3VB3ChjSlUT4eQ1IyT7auV5nG+Ecy4EWluTKIiFHZY7OzguNMaVXVvIGku3DYY4DNPkuZHy
 8R6SkJnZpG5jobiyaI6IpeuJh0HenF2dUTf7mNfqXxotZFJA==
X-Received: by 2002:a17:90b:3a47:b0:3ac:860e:1af9 with SMTP id
 98e67ed59e1d1-3b1b0d7e539mr2502720a91.41.1794599125830; 
 Fri, 13 Nov 2026 11:45:25 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-119.dlp.protect.broadcom.com. [144.49.247.119])
 by smtp-relay.gmail.com with ESMTPS id
 98e67ed59e1d1-3b1b3fbf607sm1933872a91.4.2026.11.13.11.45.25
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 13 Nov 2026 11:45:25 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93cb93c874bso487587585a.0
 for <dev@dpdk.org>; Fri, 13 Nov 2026 11:45:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1794599077; x=1795203877; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=WS+XYzFVTnNlU7a/zYTUGg0jdspe6g0f+TARBqRYb3U=;
 b=FEPGs5VrdL95DBY0yj077tjhf9YeBehRMAYDx/6PXNbktUQ5320Eqa3iUYI4VbwhDM
 kigm92rhJ5mibfC639GeP+a1xq7QGsCkz7ACUe50wGUZv4OuCoUHL9xmSPYDPeRbg4C0
 sbtmQ2icvqy9UVdkNSY1NBK+mqlRyAWE1p2Ns=
X-Received: by 2002:a05:620a:688f:b0:93b:d7a4:9d4b with SMTP id
 af79cd13be357-9494bbeb2damr549086785a.30.1794599077219; 
 Fri, 13 Nov 2026 11:44:37 -0800 (PST)
X-Received: by 2002:a05:620a:688f:b0:93b:d7a4:9d4b with SMTP id
 af79cd13be357-9494bbeb2damr549082785a.30.1794599076705; 
 Fri, 13 Nov 2026 11:44:36 -0800 (PST)
Received: from accvda5707.acc.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9494c870f31sm257145185a.27.2026.11.13.11.44.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Nov 2026 11:44:36 -0800 (PST)
From: Kishore Padmanabha <kishore.padmanabha@broadcom.com>
To: dev@dpdk.org
Cc: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>,
 Aman Singh <aman.deep.singh@intel.com>
Subject: [PATCH v2 3/3] doc: update mempool cache description
Date: Fri, 13 Nov 2026 14:44:28 -0500
Message-ID: <20261113194428.1954550-3-kishore.padmanabha@broadcom.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261113194428.1954550-1-kishore.padmanabha@broadcom.com>
References: <20261113194428.1954550-1-kishore.padmanabha@broadcom.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The programmer's guide still described the maximum cache size as a
compile time constant. Describe how the cache size is specified, and how
the cache is flushed and refilled.

Fixes: b815acfdfc48 ("mempool: remove cache size limit")
Signed-off-by: Kishore Padmanabha <kishore.padmanabha@broadcom.com>
Reviewed-by: Morten Brorup <mb@smartsharesystems.com>
---
v2:
* Changed "number of objects in the pool" to "size of the pool".
* Changed "pool's ring" to "pool's driver".
* Dropped the sentence about requests larger than half the cache size.

 doc/guides/prog_guide/mempool_lib.rst | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/doc/guides/prog_guide/mempool_lib.rst b/doc/guides/prog_guide/mempool_lib.rst
index 0bb85fb68d3e..ef025ded3b0d 100644
--- a/doc/guides/prog_guide/mempool_lib.rst
+++ b/doc/guides/prog_guide/mempool_lib.rst
@@ -96,7 +96,9 @@ the speed at which a core can access its own cache for a specific memory pool wi
 The cache is composed of a small, per-core table of pointers and its length (used as a stack).
 This internal cache can be enabled or disabled at creation of the pool.
 
-The maximum size of the cache is static and is defined at compilation time (RTE_MEMPOOL_CACHE_MAX_SIZE).
+The size of the cache is specified at pool creation, up to the size of the pool.
+When the cache is full, half of it is flushed to the pool's driver,
+and when it is empty, half of it is refilled from the pool's driver.
 
 :numref:`mempool_figure_cache` shows a cache in operation.
 
-- 
2.54.0

