Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5D06CCD199
	for <dpdk-dev@archiver.kernel.org>; Thu, 16 Oct 2025 20:36:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A987640E31;
	Thu, 16 Oct 2025 22:36:04 +0200 (CEST)
Received: from fout-a7-smtp.messagingengine.com
 (fout-a7-smtp.messagingengine.com [103.168.172.150])
 by mails.dpdk.org (Postfix) with ESMTP id 248C84026D
 for <dev@dpdk.org>; Thu, 16 Oct 2025 22:36:04 +0200 (CEST)
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
 by mailfout.phl.internal (Postfix) with ESMTP id 8A1A5EC0223;
 Thu, 16 Oct 2025 16:36:03 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-03.internal (MEProxy); Thu, 16 Oct 2025 16:36:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1760646963;
 x=1760733363; bh=s6TWsAWzVBWBVZo9tlj/vhyMCR11g0Kjzd+cNKoDJao=; b=
 h5aYXAGlyYumPnsNWstRFVuMAopCa3L8TtTcRlz54jRuQYrLdnkHlaF5sWaheD/0
 lp2VMVzmmYIP/WKItPj31Hox/OYXG8SnH7gk5Pl+ivuXoSoWB15A7E6nCGitavgf
 mdklbuxAeyL3M1gApR0sNnfDCK8UEuduhFNFr4SmmHj6RxDeFEG9hjCpSKpeNhFb
 ka52sS6Hvs5GdP8fipArpl6zmWEN3+DJ5qhCn9YwEsYkq39mAE10TCu929L9P7oI
 sknLvZEACKfxg4jSEYVEkXZu8Tp7loxuTTrAw+iJav0fEFGwwta0L6wbLiEw/bV9
 Krn70+HhnC7BMz3s441x9w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1760646963; x=
 1760733363; bh=s6TWsAWzVBWBVZo9tlj/vhyMCR11g0Kjzd+cNKoDJao=; b=H
 E1QlIpq8wZR5v/rQu1tPbPxLC/LHKCDRmZFkqvdCgW3L8DMswUtSAr1X6t7fqJJC
 Qf4OiEvcUcC2P0tDXCnFH3EnOew9K5qEXjwqXbpd6TzXEGmCRsB5MG3RpN8/m8Zp
 MyrivSJepI65KHfw8ku/8rjiYw70E82dfW3GdTY1ItBKhi7Wuv7E0qOPJVkQaFM4
 1EkpLJ+8gFrSCjwK053IfajeUghS0BapOpFyIOl4S0lEl/1583P2vKVV+JyzMSLv
 pp+KkLlXPOWkgFuMXHzy0l5kWBdvdHblYaK/29SAovYUtTV7TBgZfEsraD+I8et+
 yzT7EeeWTZJgVVInUm97Q==
X-ME-Sender: <xms:MlfxaBUpUH6jrCg5aetTJarqvqYvwTHDvOsgT_6dBl-E4tO7Cb6Mpg>
 <xme:MlfxaKi1YuZqjywt7qXL9Bye2JY8e_n9J6J_C_Az7wZKhPs408n8ev1XRJ9EsrS1Z
 WFhv-bGQvyL08JFXLDJdWy1t5-8M-MV2uS9bL8-qr1j2aF7IyY7Fg>
X-ME-Received: <xmr:MlfxaI-QVUTD8l-HKQnPGILb0wBDDtmRay-bfa_JzRVM2lKGJvjcQ-1iDdCwV7mrd-Um1wJysPEu7Ya5NtcC0VNtmHUqm7g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvdejvdejucetufdoteggodetrf
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
X-ME-Proxy: <xmx:MlfxaEZIlDWqLDUM0uIWPX146EqrQJF7x3XLyZbc1GhXyzQ3H8K8aA>
 <xmx:MlfxaH0EXab5-zQ_1vUDVSazn9nNiD_f0VgIKaslzVcIbDnCVy0_OQ>
 <xmx:MlfxaPamzNSzDkcdG8zchInhVXBZf9XSG7mxd1W1SmLFxZ-WU9C2jQ>
 <xmx:MlfxaPLpYR7luNHUlrKWuXdt799niGliVF-73_QzXw1ZDqBNmGOgOA>
 <xmx:M1fxaJiwxiMIRTd2Tar-LVRg6kod8B1bTMyChqP0XYpLsnCVIZEfMlVE>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Oct 2025 16:36:01 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: shperetz@nvidia.com, viacheslavo@nvidia.com, bruce.richardson@intel.com,
 mb@smartsharesystems.com, stephen@networkplumber.org
Subject: [PATCH v7 0/7] add mbuf debug capabilities
Date: Thu, 16 Oct 2025 22:34:38 +0200
Message-ID: <20251016203557.2554678-1-thomas@monjalon.net>
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

v7 changes:
- loop for sum of allocated mbufs
- remove unused Python import

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
 lib/mbuf/mbuf_history.c                     | 223 ++++++++++++++
 lib/mbuf/mbuf_log.h                         |   2 +
 lib/mbuf/meson.build                        |   2 +
 lib/mbuf/rte_mbuf.c                         |   5 +-
 lib/mbuf/rte_mbuf.h                         |  15 +-
 lib/mbuf/rte_mbuf_dyn.h                     |  18 ++
 lib/mbuf/rte_mbuf_history.h                 | 207 +++++++++++++
 usertools/dpdk-mbuf-history-parser.py       | 165 +++++++++++
 15 files changed, 917 insertions(+), 106 deletions(-)
 create mode 100644 lib/mbuf/mbuf_history.c
 create mode 100644 lib/mbuf/rte_mbuf_history.h
 create mode 100755 usertools/dpdk-mbuf-history-parser.py

-- 
2.51.0

