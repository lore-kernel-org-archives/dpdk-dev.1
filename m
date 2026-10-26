Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23A8C606A31A
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 Oct 2026 09:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=RW/tOqOa
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F3E10402BD;
	Tue, 27 Oct 2026 10:34:37 +0100 (CET)
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com
 [74.125.82.177])
 by mails.dpdk.org (Postfix) with ESMTPS id DF2E640041
 for <dev@dpdk.org>; Mon, 26 Oct 2026 22:21:32 +0100 (CET)
Received: by mail-dy1-f177.google.com with SMTP id
 5a478bee46e88-36a0f27c9f4so659217eec.1
 for <dev@dpdk.org>; Mon, 26 Oct 2026 14:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793049691; x=1793654491; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mYa5rLtxb4YfN5j9XMUUy2cYnt68IQG71P02A1q1nsk=;
 b=RW/tOqOa0zBr4dnkWh9pJn+pOkQO3mfWxdS/Y+S/eGqxhbbrzd3+QSwBuBwwhdSQJ/
 Kq0SV1raHDKR+YWBnd+7OB2msDaiPbHLLyCHO7nsCCxbwmnc4mD8D+S9qwtAR1Q5ioyO
 IhL7zMJqlv54Xw4tOaMEDQXYbOqDJuUtHYiPP4YTcjKghX7ELKVI46pc/krLjoMq1g/c
 r/G/OfwsXcRLYqWgJYQHUHLAmjIxTWDO3133KfRfQyKxx60JZRRTV1pmPix+iwnMMG84
 xaUi/sATUNQmFUXTSP/xBwHGplpXrCmvr06WpE2C4FXjFbjS9xUN1yjrvQqJ9Evo6+CO
 jWnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793049691; x=1793654491;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=mYa5rLtxb4YfN5j9XMUUy2cYnt68IQG71P02A1q1nsk=;
 b=OB8EoSkQQplDDucM2UNGxMZsEZakv8OMMzduRBkFqsICizHHvaqcve9D9JyPc4mYqA
 n50SIuLjAzi5RTAhqwuPbs80wkErQqiTR85a5Ib/KyLnkxWFpYCu5QA0aHNurN1dMF6H
 ARlIiGEmkQbmbnBd7sa+4PSacFMmlStVsBjLXxk8RCqxfTAu/8rZxuzPApIf/1/DQezM
 v0+HDpY4Qo5WmVE0SByiCw8LC1dbc59G7JLC/Kc+fgRb4AiOvCzrRqGnNhY/EY/+saBj
 Qv7nwrRuaFfdOb3/gucd9AjAJ3eBn4hrfzjItwwqz6DGUfTNXqZhkdcU+s9bH2/IDDWd
 kI7g==
X-Gm-Message-State: AFq9FYKqD57K4NMUxfenv9qZJzooTn4XxWArr5HORYJJnoWknwGOEDhG
 ceY2hP2kb7qztAyKU4RmyBY/uJtQByKghhEbhWNJ4eu/SmIwjijydixgA0YLqFNq
X-Gm-Gg: AYBFou066C7EUUHnh7u2yc8bCbBqodKH9u0W7XRYLhS50WIwod7R5oqpqFd7oWdQ4EH
 JcsncKbRXzorNzKUWsRFZMr4mcaAAI777/Vk8wtTOfF9Dnd+tyqqrxRcP4T5by6nZ/IiioP/HRt
 SVy2J4zxNJvMxxNFm5WPmIfbGNcZiH6x7VCLda94rI7dhHfiHccz5Uu7tBTpbJr5tyzHduDL+OT
 r31vh/BkBdRK3kmCK5XGxZ90eBK8FWnBmS9nGOD6vnxJkESSRnwos8PF9/ELIlykAK4d4sCg8Jt
 Dc8oqYKL1najqt0zTMhZvxsR9dLuxFXZ+poGaD9yXt7kfq2QyvDwZHnCwiPgcIvqd38YvKioj1C
 p/BngbHnUVcTW17aBWTlTIEEia/z04+A3gRINHIjflZhvgW63iYTqM42cONtZtODjXL8g50fCz/
 I1AHuUCVn56PewJqFmiixwXfw+fohgXRQlbmNuMIN5twDsyF1tz8a8j6eOwkdFfNlaE5ztzGE21
 kRBJ8H1txgR0DSjGdwtjp5Ys31oXwUYy8M02a9JOEgqcGkx9HO6kMxs3g==
X-Received: by 2002:a05:693c:6206:b0:36a:dbb:2607 with SMTP id
 5a478bee46e88-36a0dbb4fd4mr1653276eec.23.1793049690990; 
 Mon, 26 Oct 2026 14:21:30 -0700 (PDT)
Received: from aviuser.. ([192.19.252.250]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36a11b45b8csm617393eec.17.2026.10.26.14.21.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 14:21:30 -0700 (PDT)
From: Tathagat Priyadarshi <tathagat.dpdk@gmail.com>
To: dev@dpdk.org
Cc: weh@microsoft.com,
	longli@microsoft.com,
	stephen@networkplumber.org
Subject: [PATCH v2 0/2] net/mana: fix tx burst error handling and add TSO
 support
Date: Mon, 26 Oct 2026 21:21:23 +0000
Message-ID: <20261026212125.3193356-1-tathagat.dpdk@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261012073626.642397-1-tathagat.dpdk@gmail.com>
References: <20261012073626.642397-1-tathagat.dpdk@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 27 Oct 2026 10:34:36 +0100
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series fixes error handling in the MANA transmit burst and adds
hardware TCP segmentation offload (TSO).

Patch 1 drops a packet that cannot be sent, counting it in stats.errors,
instead of skipping or stalling on it, so rte_eth_tx_burst() keeps
returning a contiguous prefix and a short return means only a full ring.
It also bounds the segment count by the size of the SGL array.

Patch 2 adds hardware TSO for IPv4 and IPv6 TCP packets.

Testing on Azure Standard_D8ds_v6 (kernel 6.8.0-1067-azure, MANA PCI
7870:00:00.0; the driver reports no firmware version), two VMs on one
subnet:
- VM A ran testpmd txonly, modified locally to emit TCP packets with
  RTE_MBUF_F_TX_TCP_SEG set (not part of this series), after
  "csum set ip hw 0", "csum set tcp hw 0" and "tso set 1460 0".
- VM B captured the frames with tcpdump on its kernel interface, GRO off.
- A 4000-byte IPv4 packet in a single mbuf, in mbufs with a header-only
  first segment, and in mbufs with payload in the first segment, each
  arrived as 1514, 1514 and 1080 byte frames with consecutive TCP
  sequence numbers, per-segment IP IDs and valid IP and TCP checksums.
- Plain UDP with "tso set 0" was unaffected.
IPv6 TSO was not tested.

v2:
- Patch 1:
  * Drop unsendable packets and return a separate consumed count instead
    of breaking out of the burst; break only when the ring is full.
  * Move the MAX_SGL_ENTRIES_FOR_TRANSMIT check here from patch 2, limit
    nb_seg_max and nb_mtu_seg_max to it, and add Fixes and Cc stable.
- Patch 2:
  * Use the drop path for all per-packet TSO failures.
  * Honour the TCP checksum implied by RTE_MBUF_F_TX_TCP_SEG when the
    packet is sent unsegmented.
  * Bound the TSO segment walk and check the SGE count against the
    expected one, instead of the unreachable check in the loop.
  * Move GDMA_WR_OOB_IN_SGL and GDMA_WR_PAD_BY_SGE0 next to
    struct gdma_work_request.
  * Document the extra SGE in mana.rst, add a release note, and rewrite
    the commit message.

With the drop-and-continue path, CQE suppression is back to the original
behavior where only an uncompleted final packet of a burst may wait for a
subsequent burst to generate a CQE.

Tathagat Priyadarshi (2):
  net/mana: fix transmit burst error handling
  net/mana: add hardware TSO support

 doc/guides/nics/features/mana.ini      |   1 +
 doc/guides/nics/mana.rst               |   8 ++
 doc/guides/rel_notes/release_26_11.rst |   4 +
 drivers/net/mana/gdma.c                |   5 +
 drivers/net/mana/mana.c                |   4 +-
 drivers/net/mana/mana.h                |   6 +-
 drivers/net/mana/tx.c                  | 191 +++++++++++++++++++++----
 7 files changed, 186 insertions(+), 33 deletions(-)

-- 
2.43.0
