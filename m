Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06F68CCD185
	for <dpdk-dev@archiver.kernel.org>; Mon, 13 Oct 2025 21:20:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 058D9402A0;
	Mon, 13 Oct 2025 23:20:28 +0200 (CEST)
Received: from fout-b6-smtp.messagingengine.com
 (fout-b6-smtp.messagingengine.com [202.12.124.149])
 by mails.dpdk.org (Postfix) with ESMTP id 99A9740288
 for <dev@dpdk.org>; Mon, 13 Oct 2025 23:20:26 +0200 (CEST)
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
 by mailfout.stl.internal (Postfix) with ESMTP id 7CC191D00069;
 Mon, 13 Oct 2025 17:20:25 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-03.internal (MEProxy); Mon, 13 Oct 2025 17:20:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1760390425; x=
 1760476825; bh=SmVrdMTYCdvp2+QFE1khjIIrhFbG7lsDaciILmxF8rs=; b=c
 0xA3yni6oOEjcTWhicpZ9gJStw6YImIIV18uOvhW9OwVS7b2hBe65QjTCcrLUo6p
 o/YEUbiaK+JgHofnGhf24NmnZTrAw4m/ldsTiTnQUaqGwIO/15zgDgeSema7Z3Ne
 oaqE3C8tMqhy7hqNUzABFyGuglCreUt+BA1wYjNTCVqNuLFbnTPCi0jcL/9xN+MP
 M2NtBfbTCsURD+9XgzLQosZiMeouzQRo+xJBKZdC/zZOpQ6H27z+nWiweOIGCTyd
 xBeFAT98LTZh/q5y/XZwqwTrzzc6Dn33/JsEphWLdrEjH37C+t3ExNzuufIg+35X
 MWzsqWSloOCJzXA83whQw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm2; t=1760390425; x=1760476825; bh=S
 mVrdMTYCdvp2+QFE1khjIIrhFbG7lsDaciILmxF8rs=; b=kIs9tjZoB1QXnm/7b
 cW0xFh5UDjBQ38k6slboPOip3iGzlwguLTei7j3XgWUH3CXs7cVyYi46fusHGFHK
 yMGI2QFQSYTAg+mz7XwhlGzui1Ft4aVUWEqrbQvZpB5h8foH3HGm735FxQvWiPOx
 AcN9R5aSeWi+l9KHHTMQxsxIwQ/XktnrzsAYFYr9o3XVkylpNIEMVNkWFFkprKRt
 ep2y1sWiK5Akbbo9EjOAfHtS8+KtmBgH/h/7aV/sJV68WKYFRQoZYni6P134ZY93
 2EGQtA9/oyngJzWN4LXu0mQfB/xjb0xqI0VzzMAT3SFCvj3MXjgyRepgVaFvJ8KW
 0PCbw==
X-ME-Sender: <xms:GG3taEf0DM8lOd1D49Xi3U0xVymADqqgAY7xIu4fKdczuu-T2mOSEg>
 <xme:GG3taPIlbJONA08Y-27Eawd-QY3C7PfKYF_wb14gwFN0u9DCKPfHIt3-BfSl6rVrQ
 A50YZbhhj2l0lco7veZP_1S0WsmLFC5ZknoHpNgon6H-0X09oNyyA>
X-ME-Received: <xmr:GG3taBHcdByEgPBhWf1MDqu5erHWPbqPh5WtL75htEjuJHZazxPZOWWxXWtsGRD4ohicPWrLBVrI0g_9qm917RF9YobocBk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduudekjedvucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtkeertd
 ertddtnecuhfhrohhmpefvhhhomhgrshcuofhonhhjrghlohhnuceothhhohhmrghssehm
 ohhnjhgrlhhonhdrnhgvtheqnecuggftrfgrthhtvghrnhepvdejhfdugeehvddtieejie
 egteeuudfgjeeukeeiledthfetveekhefhieelhfdtnecuvehluhhsthgvrhfuihiivgep
 tdenucfrrghrrghmpehmrghilhhfrhhomhepthhhohhmrghssehmohhnjhgrlhhonhdrnh
 gvthdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohep
 uggvvhesughpughkrdhorhhgpdhrtghpthhtohepshhhphgvrhgvthiisehnvhhiughirg
 drtghomhdprhgtphhtthhopehvihgrtghhvghslhgrvhhosehnvhhiughirgdrtghomhdp
 rhgtphhtthhopegsrhhutggvrdhrihgthhgrrhgushhonhesihhnthgvlhdrtghomhdprh
 gtphhtthhopehmsgesshhmrghrthhshhgrrhgvshihshhtvghmshdrtghomhdprhgtphht
 thhopehsthgvphhhvghnsehnvghtfihorhhkphhluhhmsggvrhdrohhrgh
X-ME-Proxy: <xmx:GG3taKA6lrBJ9-027ToSsQPgGGCW6dqYnRzWsHnRmVcPUxv3m0SN2g>
 <xmx:GG3taM8Q5jxoiMPCPP698BSeUdpM8r8z-_3lUTyJprpsThytB00Few>
 <xmx:GG3taOCR0IUN-XTztGomiav2kCt02ZR5GxFJAnOsmjMOXkhY3jeHMg>
 <xmx:GG3taJQr033EvgQrIrbeZTXfGZ3ApvsOxkz7SIvVUWyf5RJEnufljQ>
 <xmx:GW3taLqQ23lY3JHTeDD4Wej5C0IMy6NEQgbf_PQhj6TvXCdbxoL-6uqS>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Oct 2025 17:20:23 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: shperetz@nvidia.com, viacheslavo@nvidia.com, bruce.richardson@intel.com,
 mb@smartsharesystems.com, stephen@networkplumber.org
Subject: [PATCH v4 0/7] add mbuf debug capabilities
Date: Mon, 13 Oct 2025 23:16:00 +0200
Message-ID: <20251013212019.892032-1-thomas@monjalon.net>
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

The changes in this v4 are:
- fix/rewrite testpmd commands
- fix python script
- fix thread safety
- fix checks
- fix logs
- change config (no Meson option)
- add documentation


Shani Peretz (3):
  mbuf: record mbuf operations history
  ethdev: mark mbufs in burst functions
  usertools/mbuf: parse mbuf history dump

Thomas Monjalon (4):
  doc: explain debug options in mbuf guide
  mbuf: move header include for logs
  app/testpmd: use space separator in dump commands
  app/testpmd: add commands to dump mbuf history

 app/test-pmd/cmdline.c                      | 338 ++++++++++++++------
 config/rte_config.h                         |   1 +
 doc/guides/howto/debug_troubleshoot.rst     |   7 +
 doc/guides/prog_guide/mbuf_lib.rst          |  18 +-
 doc/guides/rel_notes/release_25_11.rst      |   7 +
 doc/guides/testpmd_app_ug/testpmd_funcs.rst |  33 +-
 lib/ethdev/rte_ethdev.h                     |  11 +
 lib/mbuf/mbuf_history.c                     | 227 +++++++++++++
 lib/mbuf/mbuf_log.h                         |   2 +
 lib/mbuf/meson.build                        |   2 +
 lib/mbuf/rte_mbuf.c                         |   7 +-
 lib/mbuf/rte_mbuf.h                         |  13 +-
 lib/mbuf/rte_mbuf_dyn.h                     |  18 ++
 lib/mbuf/rte_mbuf_history.h                 | 206 ++++++++++++
 usertools/dpdk-mbuf-history-parser.py       | 166 ++++++++++
 15 files changed, 949 insertions(+), 107 deletions(-)
 create mode 100644 lib/mbuf/mbuf_history.c
 create mode 100644 lib/mbuf/rte_mbuf_history.h
 create mode 100755 usertools/dpdk-mbuf-history-parser.py

-- 
2.51.0

