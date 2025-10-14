Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07002CCD18D
	for <dpdk-dev@archiver.kernel.org>; Tue, 14 Oct 2025 12:40:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 30E7A402EB;
	Tue, 14 Oct 2025 14:40:56 +0200 (CEST)
Received: from fhigh-b7-smtp.messagingengine.com
 (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
 by mails.dpdk.org (Postfix) with ESMTP id DB2A9402AE
 for <dev@dpdk.org>; Tue, 14 Oct 2025 14:40:54 +0200 (CEST)
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 20EB27A0142;
 Tue, 14 Oct 2025 08:40:54 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-04.internal (MEProxy); Tue, 14 Oct 2025 08:40:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1760445653;
 x=1760532053; bh=roFbGfwGqnsUk9wcfqeVW7hwNACk9FKqHzS73ujLb4s=; b=
 GpiRli75x4Blr2VbV7ZBtBbHidsK+9jhmwo2FHoJZqA0QN5oVn+2UXIjn4KtSblK
 H8ISc5nfpAuggZUvQ8utyNn1WoVgB9vr9RW5MJQQun/s7lh0xcMVcOF1kUyjNTrW
 mQfeYjfl/Bo44iwZmsjDTYKB18aD/w4R88rv5WeNKd5V47WgJH9XR9S6q8ACO23j
 JwGKbghFOpDSk0r3s7vnySbpjP6DerS+wDIiGKyqoVSYV0XdFAh99L/Ow+SwpbvQ
 FptuopFWEdwwN7c0vOzTIOCIyXKBvORM4vzlysMkjnYvnvaKILZRd9ca4VUBYcE/
 RjmPAO53/U6BToRu69sH3w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1760445653; x=
 1760532053; bh=roFbGfwGqnsUk9wcfqeVW7hwNACk9FKqHzS73ujLb4s=; b=x
 rigedsBYByDde5ugmF8fzmVrSV8E2gTyafyc9mZRydhIeGPDrSjwsBZj/+acnUGl
 6M09LFEIBHPbVxuQvWMtvPKuEkgXvZ+yJh/vGA+I4ShJe5XnZmOsh6o0LPe/ghb6
 +veGzR4goKyrR/unTC40vic1azTNBl5s7EvBky/2jkCKt9oGljc7rocewGORc066
 KM0jDnJD+KOx+zOZwyS2zyMfVWrfNWju+IplVvqMOs8pgoDIXldXsaNsymCDSTbr
 LONoHL6rmOCGakMkpC1KZcn8lZMOuEsKqu5lbFjHnZ0HekiaSA/ApPam02mfiPct
 ALOxPLk1gAA3eNGIdrxSw==
X-ME-Sender: <xms:1UTuaE2naGWOn3MZm122IxQXnVSYj8l8I5EAldESIZQXpc-BHb_beg>
 <xme:1UTuaIDD1jgDw1OBVFCgZ1UoEEHJM71wSzjB76JvsxDBuNOCI8QJfjTQObrs9vxnH
 QorEGfDG72UkRtyiJa3TAEccQ3PuG_4-nJU1WC2V01AyDzmQYdD5nU>
X-ME-Received: <xmr:1UTuaIeFT7fGpbNOEb0b6IV9hF8HLXZpgoLm8t5tCYVh1aPUjwYZVpSdcFTRXN4DNCyr8P8YMCyn6JbIhs_OaYqc2VGE4e4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvddtheehucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfgggtgfesthekre
 dtredtjeenucfhrhhomhepvfhhohhmrghsucfoohhnjhgrlhhonhcuoehthhhomhgrshes
 mhhonhhjrghlohhnrdhnvghtqeenucggtffrrghtthgvrhhnpedtieffffegfeetlefhke
 euteeuudffjefgleevtdeijedukefgveehteehheegjeenucevlhhushhtvghrufhiiigv
 pedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehthhhomhgrshesmhhonhhjrghlohhnrd
 hnvghtpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthho
 peguvghvseguphgukhdrohhrghdprhgtphhtthhopehshhhpvghrvghtiiesnhhvihguih
 grrdgtohhmpdhrtghpthhtohepvhhirggthhgvshhlrghvohesnhhvihguihgrrdgtohhm
 pdhrtghpthhtohepsghruhgtvgdrrhhitghhrghrughsohhnsehinhhtvghlrdgtohhmpd
 hrtghpthhtohepmhgssehsmhgrrhhtshhhrghrvghshihsthgvmhhsrdgtohhmpdhrtghp
 thhtohepshhtvghphhgvnhesnhgvthifohhrkhhplhhumhgsvghrrdhorhhg
X-ME-Proxy: <xmx:1UTuaN5luKBrAKA7B9X8tl-dMA3rIxCjpSzSTP7uPLhYxgFBIOoqww>
 <xmx:1UTuaDUudM-Irv1YodkLUgXMqRrw6yfAHEtZOOXopxvBAwSdgRvUyA>
 <xmx:1UTuaE66xCimYpHURr5OF1IsnUXumaXfdvFaI_S5uNvcaOReM9Xttg>
 <xmx:1UTuaGo2g-VLccRGxwEmtb__oUQ4nMoZRmscNnTrO7_lXOHwb_i_vA>
 <xmx:1UTuaBBDX52w7CbJ3unGXGRXHQtmclciYV1SNhBYVnCrWuoCBGvWPu2M>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Oct 2025 08:40:52 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: shperetz@nvidia.com, viacheslavo@nvidia.com, bruce.richardson@intel.com,
 mb@smartsharesystems.com, stephen@networkplumber.org
Subject: [PATCH v6 0/7] add mbuf debug capabilities
Date: Tue, 14 Oct 2025 14:33:33 +0200
Message-ID: <20251014124046.1032293-1-thomas@monjalon.net>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250616072910.113042-1-shperetz@nvidia.com>
References: <20250616072910.113042-1-shperetz@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

---

v6 changes:
- simplify testpmd commands
- use enum op type
- rename Tx ops
- mark free before freeing
- mark out of sanity check loop

v5 change:
- fix MSVC build in testpmd

v4 changes:
- fix/rewrite testpmd commands
- fix python script
- fix thread safety
- fix checks
- fix logs
- change config (no Meson option)
- add documentation

v3 changes:
- use atomic
- fix prefix
- add asserts
- reformat dump
- remove #ifdef clutter
- remove mlx5 patch

v2 changes:
- move to mbuf in dynamic field

v1:
- mempool feature

---

Shani Peretz (3):
  mbuf: record mbuf operations history
  ethdev: mark mbufs in burst functions
  usertools/mbuf: parse mbuf history dump

Thomas Monjalon (4):
  doc: explain debug options in mbuf guide
  mbuf: move header include for logs
  app/testpmd: use space separator in dump commands
  app/testpmd: add commands to dump mbuf history

 app/test-pmd/cmdline.c                      | 309 ++++++++++++++------
 config/rte_config.h                         |   1 +
 doc/guides/howto/debug_troubleshoot.rst     |   7 +
 doc/guides/prog_guide/mbuf_lib.rst          |  18 +-
 doc/guides/rel_notes/release_25_11.rst      |   7 +
 doc/guides/testpmd_app_ug/testpmd_funcs.rst |  33 ++-
 lib/ethdev/rte_ethdev.h                     |  11 +
 lib/mbuf/mbuf_history.c                     | 229 +++++++++++++++
 lib/mbuf/mbuf_log.h                         |   2 +
 lib/mbuf/meson.build                        |   2 +
 lib/mbuf/rte_mbuf.c                         |   5 +-
 lib/mbuf/rte_mbuf.h                         |  15 +-
 lib/mbuf/rte_mbuf_dyn.h                     |  18 ++
 lib/mbuf/rte_mbuf_history.h                 | 206 +++++++++++++
 usertools/dpdk-mbuf-history-parser.py       | 166 +++++++++++
 15 files changed, 923 insertions(+), 106 deletions(-)
 create mode 100644 lib/mbuf/mbuf_history.c
 create mode 100644 lib/mbuf/rte_mbuf_history.h
 create mode 100755 usertools/dpdk-mbuf-history-parser.py

-- 
2.51.0

