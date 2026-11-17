Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ABE6606A32F
	for <dpdk-dev@archiver.kernel.org>; Wed, 18 Nov 2026 09:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=g/Z/715g
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 07D62402DD;
	Wed, 18 Nov 2026 10:20:04 +0100 (CET)
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69])
 by mails.dpdk.org (Postfix) with ESMTPS id 01F344026F
 for <dev@dpdk.org>; Tue, 17 Nov 2026 15:11:46 +0100 (CET)
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-91eb556c8a0so87893806d6.2
 for <dev@dpdk.org>; Tue, 17 Nov 2026 06:11:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1794924706; x=1795529506; darn=dpdk.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=OBvURpTQdg5YqsbNGyk88C0bQDfoGEiLiPD6zAwR7Nk=;
 b=g/Z/715gjaFiIorpOG77sMYOfwTz0zs7AEs3mthJQnNdR9B476xrh+c8Wm5NscT3FM
 p2F6L0Q7hXl2N01NRWav6GhoiofELV11dyO7pnBLwDz3Dp/lBiVVDZ5VGI4rKwqPPE8q
 BmHJRjGSvTXsfh2om7yrAu4ZT17yxPVpuBDqB6f7orraOaPEnDiN0OQG0qWcP3QXBu27
 KRTlfh0qEjOxEb32CyEDwaftWGp6qoNao04ldQvBiyBGpVp0seV4RtUZEhLOPCz3LeqH
 d/yzTSZMneRgAt/56w9RPhYYKQ3ccTrg3K/q/h2vmByqIVYzdtRVVNxPQpnPowF6W72z
 Aw0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794924706; x=1795529506;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OBvURpTQdg5YqsbNGyk88C0bQDfoGEiLiPD6zAwR7Nk=;
 b=VdC2E1RdXcsW5QZ77ncaykZLCrNKzvkQ/MWxqeiw+RtlZp8XEAr1LCiuHnC6Al5twL
 G6K3mm7YqfclUHKhoW1xwNTmpCuar5iJhHbzIMogZbjrH7gqyDD1Z4k8zF3jAzlN5hRL
 e3OFPrCxDIDLJkvRelFubEDvveaQLqM9i3oBM7c2N/kF4poUjUi40M6MCgwAC1BfrS8J
 P6mHoHhxtyUMjN7akFUrw3i4X+E3q+zCiRFQhdCeKSaseonaVnfvdgODxmqaEz+vlZJD
 UVmVfxnCMTGaps3xfVvVsLKiO+kgnlmXMPlQi2tFx9GqnH3xA86tLCzJPWVa5+U5/kdl
 PbVg==
X-Gm-Message-State: APuU4Z+N6UV8GmnwYioLKG3XgOI2qiVsqWWy/lAnULiAevPOcvBMeVoE
 1VbjOdJ9jH8WJiAY4qBm9qfatkM7mJvUSex5Qgw9Wjd6YbCD5XFc8+Rr5Dbq44LCx7cx5XOIXcx
 eSl1/6ZRj3PQSefTkj+zhet2oYOkgn5V5hWKQu1AcSlblk2EnkLtWbKXvDACTa0L1JVv5Y0/n7P
 DLvk6IJRPKiQ2NU2YUfCpwkkkEuEO4
X-Received: from qvnu9.prod.google.com ([2002:a0c:f889:0:b0:91e:8f74:1788])
 (user=rnwolfe job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:29e8:b0:91f:1eee:8c5b
 with SMTP id 6a1803df08f44-91f2420d00bmr221276156d6.42.1794924705188; Tue, 17
 Nov 2026 06:11:45 -0800 (PST)
Date: Tue, 17 Nov 2026 09:11:41 -0500
In-Reply-To: <20261115140016.3830109-1-rnwolfe@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261115140016.3830109-1-rnwolfe@google.com>
X-Mailer: git-send-email 2.56.1.708.g77570a6a1d-goog
Message-ID: <cover.1794908231.git.rnwolfe@google.com>
Subject: [PATCH v2 0/3] net/gve: fix GQI Tx cleanup and QPL FIFO reclaim
From: Ryan Wolfe <rnwolfe@google.com>
To: dev@dpdk.org, Junfeng Guo <junfeng.guo@intel.com>, 
 Joshua Washington <joshwash@google.com>
Cc: stable@dpdk.org, Harshitha Ramamurthy <hramamurthy@google.com>, 
 Rushil Gupta <rushilg@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Wed, 18 Nov 2026 10:20:02 +0100
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-21.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series fixes three independent bugs in the GQI Tx paths of net/gve:

- 1/3 clears the first freed sw_ring entry in gve_free_bulk_mbuf() so
  completed or refcounted segments do not leave stale mbuf pointers that
  are freed a second time on queue stop or release.
- 2/3 fixes GQI_RDA multi-segment non-TSO packet descriptors to pass
  data_len instead of pkt_len for the head segment, reclaims completed
  descriptors when nb_free runs low mid-burst, and stops counting normal
  ring-full backpressure as stats.errors.
- 3/3 fixes GQI_QPL jumbo Tx FIFO reclaim, TSO pre-allocation space
  checks, malformed TSO mbuf handling, and doorbell flushing.

v2:
- split v1 into three atomic Fixes patches for stable backporting
- free and count malformed TSO mbufs (pkt_len <= hlen) in
  gve_tx_burst_qpl() while tracking nb_sent separately from nb_tx so an
  invalid TSO request cannot stall the queue at tx_pkts[0]
- use for (;;) and add the missing blank line after
  gve_tx_reclaim_fifo_qpl()

Ryan Wolfe (3):
  net/gve: clear first freed slot in bulk mbuf free
  net/gve: fix GQI RDA multi-seg descriptor length and clean
  net/gve: fix GQI QPL jumbo Tx FIFO reclaim and doorbell

 drivers/net/gve/gve_tx.c | 78 ++++++++++++++++++++++++++++------------
 1 file changed, 55 insertions(+), 23 deletions(-)

