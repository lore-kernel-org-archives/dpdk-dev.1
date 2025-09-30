Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44195CAC5B8
	for <dpdk-dev@archiver.kernel.org>; Tue, 30 Sep 2025 23:38:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ED7B84028B;
	Wed,  1 Oct 2025 01:38:48 +0200 (CEST)
Received: from fhigh-b1-smtp.messagingengine.com
 (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
 by mails.dpdk.org (Postfix) with ESMTP id 0B487400EF
 for <dev@dpdk.org>; Wed,  1 Oct 2025 01:38:48 +0200 (CEST)
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 04A807A0149;
 Tue, 30 Sep 2025 19:38:46 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-06.internal (MEProxy); Tue, 30 Sep 2025 19:38:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1759275526; x=
 1759361926; bh=4YX41rjWdzDKyKX0OzTCujDVbd0r2F+14oOnZnGUiv4=; b=S
 LDGfG/8MVb/rOGgDWfX+IhfLVk3+otTheCoe5AzKNhPaIqie6Pn+npLVIKR0YEeW
 10jmmUIyNV3kBNQ80USPfIJZbTxKgBexNGfh5+WaDC/j2o10AMk8M6mFtVtAsWN1
 aLLCuxWROIJoUGEd/HUKiYEvL++BlTUTzK8n8QHW35V8h7smj3IqCVOw2AUobBjU
 asoESVKlbe0XIA7nMTxZcKXOGjFZMjRpydFyyvnD0fhGWRDxUsK/xGfMPITY2Px7
 Vi1/9SVM0WDUjv4VrT1+i6gK6q0gybYHvQNadU2JTg0M5PMaGtPzvVGEA24zOMgS
 gaAepElDRafYKuAz3P7bQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm2; t=1759275526; x=1759361926; bh=4
 YX41rjWdzDKyKX0OzTCujDVbd0r2F+14oOnZnGUiv4=; b=eA9+O4ZkB+e63FZn6
 ESPAlJZgY4e58/+GqDoEi/gAv+u6X03RAkODAborpbDmfB0DNcTAyyg5fK6YTA6U
 dpW9SegHCoehk0TlyiQM83eeeCH6P8vm8WYI7iBnBaVJ+hjfLhy2q8edWV0poTBP
 +lqAxrL55tRS1/KYLZp2SO0lzyi5yiXOQdmD3DG5StU3Lkw1FOI6CearImDdqNAu
 ocKqDKLkt3MKJh8FGFtpkEVWzA+vH6s/wUMn3d2Y71KTRvXAs2eHtkdeR0/f+d3k
 gcyfM+evyle3Qkbvjwmc8ZeZrssILfPPqjnravrx9CVCnrX+Nq38M8IFfgbH3Pmh
 mKNZg==
X-ME-Sender: <xms:BmrcaABvtxlqP9r83Kp_yL37P8604hdipBOyh7vXtaH6JFh0dqfrJg>
 <xme:BmrcaLec0BgqGiY2luTAHnhJcbdPUz14WxTgp8Cy5AFP5xtST_n27r9Cr-w5RGhWD
 5FLiGoxQ_-haYhoN7mp9WADayi2GSIP4Ql1UIW3xWMm8rShrXtfLw>
X-ME-Received: <xmr:BmrcaPJrjH5YvbFQ3DxMy9jfJOD1Bst5P9AcLMMwxWzVrDBw68ibjaKfFM5FSV7-sACvZO0t_f_WUNpfQNLEiJXn7I7ez9M>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdekudejjecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgjfhgggfestdekredtre
 dttdenucfhrhhomhepvfhhohhmrghsucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhho
 nhhjrghlohhnrdhnvghtqeenucggtffrrghtthgvrhhnpedvjefhudeghedvtdeijeeige
 etuedugfejueekieeltdfhteevkeehhfeilefhtdenucevlhhushhtvghrufhiiigvpedt
 necurfgrrhgrmhepmhgrihhlfhhrohhmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvg
 htpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegu
 vghvseguphgukhdrohhrghdprhgtphhtthhopehshhhpvghrvghtiiesnhhvihguihgrrd
 gtohhmpdhrtghpthhtohepvhhirggthhgvshhlrghvohesnhhvihguihgrrdgtohhmpdhr
 tghpthhtohepsghruhgtvgdrrhhitghhrghrughsohhnsehinhhtvghlrdgtohhmpdhrtg
 hpthhtohepmhgssehsmhgrrhhtshhhrghrvghshihsthgvmhhsrdgtohhmpdhrtghpthht
 ohepshhtvghphhgvnhesnhgvthifohhrkhhplhhumhgsvghrrdhorhhg
X-ME-Proxy: <xmx:BmrcaG2jTmHJGnLowxKdxpp3mqLhk8gL168raooNQMR7Wk3ZDPsgtA>
 <xmx:BmrcaBjejozyM-viopmsae-pnPxahIw0etzR4J0jBwtDJFnLcl09QQ>
 <xmx:BmrcaPWPa6bLEIUS_PenUpAX_skPFZ8aBqTdRL5kIFPQQYuHnWEnQw>
 <xmx:BmrcaIU4dBFm4tTx4o-kzN2HLpIeT9oMkyt_9FQomuis8_GtmU1-0g>
 <xmx:BmrcaOvU4hZIOSClrc2g2mRXiMI3QaJLswM8BpU5oa0bU8EqK9yfoaNR>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 30 Sep 2025 19:38:45 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: shperetz@nvidia.com, viacheslavo@nvidia.com, bruce.richardson@intel.com,
 mb@smartsharesystems.com, stephen@networkplumber.org
Subject: [PATCH v3 0/5] add mbuf debug capabilities
Date: Wed,  1 Oct 2025 01:25:01 +0200
Message-ID: <20250930233828.3999565-1-thomas@monjalon.net>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250616072910.113042-1-shperetz@nvidia.com>
References: <20250616072910.113042-1-shperetz@nvidia.com>
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

History is added to mbuf for debugging.

This series set some marks in mbuf allocation/freeing and ethdev Rx/Tx.
More marks could be added in other libraries.
Drivers could benefit a finer debugging by marking alloc/free calls,
in addition to marks already done in the mbuf library.
Even better, the application could add its own marks.

As part of this series, mbuf statistics can be dumped,
and a Python script will help to parse mbuf history.

The changes in this v3 are mainly in the mbuf library.
Most comments are addressed, except suggestions for the mempool library.
The patch adding detailed marks in the mlx5 PMD is removed from this series.


Shani Peretz (4):
  mbuf: record mbuf operations history
  ethdev: mark mbufs in burst functions
  app/testpmd: add commands to dump mbuf history
  usertools/mbuf: parse mbuf history dump

Thomas Monjalon (1):
  mbuf: move header include for logs

 app/test-pmd/cmdline.c                | 246 +++++++++++++++++++++++++-
 config/meson.build                    |   1 +
 lib/ethdev/rte_ethdev.h               |  15 ++
 lib/mbuf/mbuf_history.c               | 214 ++++++++++++++++++++++
 lib/mbuf/mbuf_log.h                   |   2 +
 lib/mbuf/meson.build                  |   2 +
 lib/mbuf/rte_mbuf.c                   |   7 +-
 lib/mbuf/rte_mbuf.h                   |  13 +-
 lib/mbuf/rte_mbuf_dyn.h               |  18 ++
 lib/mbuf/rte_mbuf_history.h           | 174 ++++++++++++++++++
 meson_options.txt                     |   2 +
 usertools/dpdk-mbuf_history_parser.py | 173 ++++++++++++++++++
 12 files changed, 862 insertions(+), 5 deletions(-)
 create mode 100644 lib/mbuf/mbuf_history.c
 create mode 100644 lib/mbuf/rte_mbuf_history.h
 create mode 100755 usertools/dpdk-mbuf_history_parser.py

-- 
2.51.0

