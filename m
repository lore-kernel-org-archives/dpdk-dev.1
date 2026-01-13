Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0536DD2F35C
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Jan 2026 19:25:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DE458402DE;
	Tue, 13 Jan 2026 20:25:38 +0100 (CET)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com
 [209.85.208.41]) by mails.dpdk.org (Postfix) with ESMTP id 66C9C4028B
 for <dev@dpdk.org>; Tue, 13 Jan 2026 20:25:37 +0100 (CET)
Received: by mail-ed1-f41.google.com with SMTP id
 4fb4d7f45d1cf-64d02c01865so997830a12.1
 for <dev@dpdk.org>; Tue, 13 Jan 2026 11:25:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768332337;
 x=1768937137; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x106Q+djr9enLSK4Z7XSfx8Df/wjs9enI/txEGP5r68=;
 b=kqvdPsxKXSECZnuTj1Xhtc5zWXEOfrYAfHJfA5rJbcQj+2eplT4qxa9BAnFPIUzP0G
 bx177JMJaNxdD541ILkSpwmk9dOOrrmFn1xpKo6MG7x84BDEbjrGndGShNgwKEfN0lHP
 vfoWlPvXMNL1Q6xOLi4OhQPso7O2dA7hl/YiXOVVrwrIlQlWy4UyURGxnHyTsCAjvXUX
 /2cR0zVMezLdKwRq/kZ0An4OX6Bvk4Of8Wr/UtqEsTz7Ckf8HxAKx29747vzE3q39N1V
 HZKvHmCA9mlcKnMxjWiVDCGyaFpmzNCwKpPHRwB4r8o2y0QEj+QvewpKA+naI46332UC
 RkFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768332337; x=1768937137;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=x106Q+djr9enLSK4Z7XSfx8Df/wjs9enI/txEGP5r68=;
 b=B7co0VOz6ySoQp5rsIkdQudUJwMr+aoPOGtJHdbeMnQtZsyQD7WwdzjH/DQ0DbGCGQ
 7gCXc3Ew63aRTBEoyNPnfe2ndd8uKwWBRA2Qup0fkEQp5tcDFp+u387CiFW/vxC1S5W/
 9jM8zU7Ek9GpYrg3/Ftjt0NN+uSEYBMYNa84YHWNd8p19wQ2Wqimh4KF7umc8JYGIPMN
 cLcdyMQLEUMwz7oTpmYfVbsrn/aUg0MmsQzsJBzhUge1vNbErpfaGpbNWrvu678EaxVt
 r83QKvmflgVzCNoFUVq3ZboXxyi2PRdSfFAAHVdvphqcMDerog0Zi5XBkcggQFtfwZgF
 6tlw==
X-Gm-Message-State: AOJu0YxlZOlp4w7OPrgcV9dwg5MbqJc2VjIyvgjhhXt0si2qsgrIRRMl
 4cZkDUlkVro8P6AsVcKmEp9S1vGQ0zhduMCMgzbFsMJ4Rr+Cv7kLdHxNoTeejvQLgqKWwswPwEm
 uTtaW
X-Gm-Gg: AY/fxX6yVC2zb4apEgMZvMxRC5OREnwR5vF4GGwgt2MCnQvEGEzyCxjkX//8bodSMwd
 fsAT8+BOmh+7AdHMFZ79ouqqKjL2tapYNS74Nrza6/UDGFCSMbXebVa9tjuBlCIJrOJe7wR00zM
 pFfTCayszMVQdDbSBjbzelMIll4D7Nig29uLErYQ7WM8ltq9LhkgU4AFU7on6IiXtk7W4mXSrkm
 lTezMH5QVeYakI4tRowD1NE4ev+5c7OTG+epKvbS5pWtaaKGWKtyL2j3spcXTA96zZ/k0QN3scA
 Q5/Q8WZ0/1KeWYzeX8aNcMxA/Uyfw8ZjpD7G87CDm6a7qS6X1nE15MyvZLnqxLFR0xrx8I+EPdx
 Ox9YlUb6S2i/jnbRQ+/kT11Skjou+e9iBBuv3hekhXa+jrEEt35CxUWsZvdiFuZiING5SNRyecs
 HUe6rvfBjYPFhngKBmFprB8dI9QStVIuyiYdNxMur2zGAt87aEwA==
X-Received: by 2002:a05:6402:2693:b0:64d:498b:aeff with SMTP id
 4fb4d7f45d1cf-653ec46ecf5mr58912a12.34.1768332336784; 
 Tue, 13 Jan 2026 11:25:36 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6507b22c3absm20945603a12.0.2026.01.13.11.25.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jan 2026 11:25:35 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v3 0/9] net/pcap: improvements and test coverage
Date: Tue, 13 Jan 2026 11:23:32 -0800
Message-ID: <20260113192530.116470-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260106182823.192350-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
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

This series brings several improvements to the PCAP PMD:

 - Update documentation to reflect actually supported features
 - Code cleanups: remove unnecessary rte_malloc/rte_memcpy usage,
   convert flags to bool, remove global variables, avoid volatile
 - Add MTU set support for single interface mode
 - Add Tx offload support
 - Support nanosecond timestamp precision
 - Add comprehensive test suite

This was done via mix of new code and AI feedback.

Stephen Hemminger (9):
  doc: update features for PCAP PMD
  net/pcap: avoid using rte_malloc and rte_memcpy
  net/pcap: support MTU set
  net/pcap: use bool for flags
  net/pcap: support Tx offloads
  net/pcap: support nanosecond timestamp precision
  net/pcap: remove global variables
  net/pcap: avoid use of volatile
  test: add test for pcap PMD

 app/test/meson.build                  |    2 +
 app/test/test_pmd_pcap.c              | 1801 +++++++++++++++++++++++++
 doc/guides/nics/features/pcap.ini     |   10 +
 drivers/net/pcap/pcap_ethdev.c        |  336 +++--
 drivers/net/pcap/pcap_osdep.h         |    1 +
 drivers/net/pcap/pcap_osdep_freebsd.c |   37 +-
 drivers/net/pcap/pcap_osdep_linux.c   |   21 +
 drivers/net/pcap/pcap_osdep_windows.c |    6 +
 8 files changed, 2083 insertions(+), 131 deletions(-)
 create mode 100644 app/test/test_pmd_pcap.c

-- 
2.51.0

