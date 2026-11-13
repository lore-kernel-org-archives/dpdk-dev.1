Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CE01606EB94
	for <dpdk-dev@archiver.kernel.org>; Fri, 13 Nov 2026 15:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=G8zVuB+3
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9458040DCA;
	Fri, 13 Nov 2026 16:57:51 +0100 (CET)
Received: from mail-pj1-f98.google.com (mail-pj1-f98.google.com
 [209.85.216.98])
 by mails.dpdk.org (Postfix) with ESMTPS id 36A4040682
 for <dev@dpdk.org>; Fri, 13 Nov 2026 16:57:50 +0100 (CET)
Received: by mail-pj1-f98.google.com with SMTP id
 98e67ed59e1d1-3b0b3438540so1343871a91.0
 for <dev@dpdk.org>; Fri, 13 Nov 2026 07:57:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794585468; x=1795190268;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=h4iAu+N/cqfmsAtjK63DpIw4IMfnvxow767MOEPB/ZI=;
 b=qKhmKWY+WDmV5M8FhFX7A6kpQI/cugvI2fyJqRV369Sksm8zbQaujSbXBraU5u6Xyo
 aRDJwyTyIchny34O3eVTSwK2VquHxDYJkwcdkSIVohghOExkFYxFl0g4PCb/k/Uar+iY
 rTg7lW9VwSkV68l7OcMrBfPvrL10An6zQaEtpzaO9RFr/nAaLkLBZ1rrN/AZ587DXpzt
 b47YInIbBx97C4co+I7GnZrwWNjVjDNlvzfIhHlST176GRr/QdEnbgXuhOFMOzZ2x+JY
 Ta9x3F9BmiNir9B0699lSxbies1rqWPaYq3xdQtnAYwdZDFM39dHvwvJ/BKbfwoqby+/
 6iMQ==
X-Gm-Message-State: APuU4Z9/orfl7JL0DbVUv0nhG5OsPvzJuqRbYRtIu6avwlAg/p22PGgq
 6jiRhu6Eq6QzsUcLg1HlouleaBLPu8tqxO6uuDYhD9OoueWPBW36XJrEgByz5hiLJyyPMh1EBG3
 BIMzwmNFYqxINf9iDR6+2arW+AyQQQYiIoqvrqfE5qdgnMpPpnpgxXOK4ce114vm+Rhdo4WTIlM
 1aLIQ60RnXZJBZvkA0Cgza1URjOlN5nPDpwtGnQX2wz+mM7QH073XSCovNFH38hHOeohbJR3Edv
 oVq9w==
X-Gm-Gg: AYBFou0lujpAoCcnoJcNG08aP8Zi1l+yrAsyQCuPmVfFDgEOHxhWcwYAmr15Ze7iKGY
 mWzBuxxMpN2Yf/pxBEwLCeSr6/mLaKwbHJYyGnSvwkARSPHKxLcGOdKC8MLad3oGU7qQrBF7FTj
 QyRQzsClV3gdMd1/pVbxwZRUa6A83fsqd5b9bhvfqFPc9UavcsmipIDr4p4D3NhkEQ4dmHYTsL9
 3dkly63JPanev89e/sEhL0VHQ9MM6kGXH0Q9/68AMRRmEkeGk8nj2ZmPesA59bgCldRD3nCAyIi
 VydrCwhv7iPl9DSuT2gFas5jau++0mOBgHQtwsJ6GPzqZ2VHj1LInWt7lOb5OCGA/sIwQoytciz
 FeisiL+16snMP3gDZ/ez8+7aitWftodegSY7cM0WvZfICCU0sRGuW1h4ExZX5iYm+ltCS/SEg2T
 9eifd5JLNSOeaPRMEk5Q29JT1Sg5DDDFagS15BBirwoSmM5Q==
X-Received: by 2002:a17:90b:1dc3:b0:3b0:9782:8721 with SMTP id
 98e67ed59e1d1-3b1b0a0e116mr2577812a91.36.1794585468414; 
 Fri, 13 Nov 2026 07:57:48 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-119.dlp.protect.broadcom.com. [144.49.247.119])
 by smtp-relay.gmail.com with ESMTPS id
 98e67ed59e1d1-3b1ae81cfa5sm4339219a91.0.2026.11.13.07.57.47
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 13 Nov 2026 07:57:48 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-1b3a348a6dbso1907778c88.1
 for <dev@dpdk.org>; Fri, 13 Nov 2026 07:57:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1794585467; x=1795190267; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=h4iAu+N/cqfmsAtjK63DpIw4IMfnvxow767MOEPB/ZI=;
 b=G8zVuB+3QVu2lqCeRjapLd0N7p6uPbLVE+iAfBuK9QYDPx+RkegrnbPxWhcmyoqMXZ
 H8gmp4Mh89AjEjYQoFw+MVD+jaIKTBrwLXZKShlI8JEMiLNqxF2jIhnXLNJmun801kjM
 ovVu8jJ2zn+EVmgWXZDD1iJQgTtQ3M4vjLSeM=
X-Received: by 2002:a05:701b:21c3:b0:1b3:a8a3:c6de with SMTP id
 a92af1059eb24-1b50306c4e1mr2795117c88.5.1794585466699; 
 Fri, 13 Nov 2026 07:57:46 -0800 (PST)
X-Received: by 2002:a05:701b:21c3:b0:1b3:a8a3:c6de with SMTP id
 a92af1059eb24-1b50306c4e1mr2795085c88.5.1794585465916; 
 Fri, 13 Nov 2026 07:57:45 -0800 (PST)
Received: from accvda5707.acc.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b5031b98e5sm8386190c88.14.2026.11.13.07.57.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Nov 2026 07:57:44 -0800 (PST)
From: Kishore Padmanabha <kishore.padmanabha@broadcom.com>
To: dev@dpdk.org
Cc: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>,
 Aman Singh <aman.deep.singh@intel.com>
Subject: [PATCH 3/3] doc: update mempool cache description
Date: Fri, 13 Nov 2026 10:56:33 -0500
Message-ID: <20261113155633.1883479-3-kishore.padmanabha@broadcom.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261113155633.1883479-1-kishore.padmanabha@broadcom.com>
References: <20261113155633.1883479-1-kishore.padmanabha@broadcom.com>
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
---
 doc/guides/prog_guide/mempool_lib.rst | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/doc/guides/prog_guide/mempool_lib.rst b/doc/guides/prog_guide/mempool_lib.rst
index 0bb85fb68d3e..e89cf77ee9bf 100644
--- a/doc/guides/prog_guide/mempool_lib.rst
+++ b/doc/guides/prog_guide/mempool_lib.rst
@@ -96,7 +96,10 @@ the speed at which a core can access its own cache for a specific memory pool wi
 The cache is composed of a small, per-core table of pointers and its length (used as a stack).
 This internal cache can be enabled or disabled at creation of the pool.
 
-The maximum size of the cache is static and is defined at compilation time (RTE_MEMPOOL_CACHE_MAX_SIZE).
+The size of the cache is specified at pool creation, up to the number of objects in the pool.
+When the cache is full, half of it is flushed to the pool's ring,
+and when it is empty, half of it is refilled from the pool's ring.
+Requests of more than half of the cache size are served, fully or partly, by the pool's ring.
 
 :numref:`mempool_figure_cache` shows a cache in operation.
 
-- 
2.54.0

