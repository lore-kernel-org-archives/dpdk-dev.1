Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB68BFD45FA
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Feb 2026 22:59:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1573640279;
	Wed, 25 Feb 2026 23:59:21 +0100 (CET)
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com
 [74.125.82.174]) by mails.dpdk.org (Postfix) with ESMTP id C3CF3400D6
 for <dev@dpdk.org>; Wed, 25 Feb 2026 23:59:19 +0100 (CET)
Received: by mail-dy1-f174.google.com with SMTP id
 5a478bee46e88-2ba895adfeaso213990eec.0
 for <dev@dpdk.org>; Wed, 25 Feb 2026 14:59:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1772060359;
 x=1772665159; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VFmEpw7EJZVX0sBZUW5OPnvVJ5kMYW8Y3aAOtDj//8o=;
 b=Sr1NfBx94xFb6H4u+vXmrLe7HpaHhLAd2g2GEexlph7C9alfoVP1C/LNaa5gTCovQF
 imkjQa/6AZ5hLPo5XtAQZqnbPfIcpNXGZ2PIM+RwSxtJo0bAPspcf+TTuT3FXpLmwLcR
 wZ7hnkZt30vpttLlQJ5CcyGLnIiM40YRgfamixzhzg43FIz3pPSUrgUwCUy20wxIjWxT
 iJyQYmBYykZBC45M2Rq92DV07qeEU3M2TPNPJJMQqmTggDxdlxNMZ81NmK+wLPjOK43H
 g53TZu38mU0WsTEL6MwCAsPlNKgyVsHGpmHLMfXf5+GUgoIL8zYcapYDbEfiCBtcI3Y+
 LR5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772060359; x=1772665159;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VFmEpw7EJZVX0sBZUW5OPnvVJ5kMYW8Y3aAOtDj//8o=;
 b=KmgmZoAnKZF+vGQ4hh83i3LA97GEuuFAgMjAQcEIqaUw5Wxg7dkrBgOXBqn7nhj7vv
 VynszDfUc+KsVKMMkHC+STwcw7eTPdbrP+k3Fu7eNIizhzvwppPHT2aY7ehjb0cZkaD/
 TYI1YaAOnxo1/QEi4ELNW6YDTHk9913qlVBVmp/1NzOWAPMPWSQ7oXUF2O2hT22yEtGk
 qmj3Z+8u7LSkd0W0fuP/V6HC1pMMjHNmkWfixWMYGIQdD6gXghxMxiNfYeKuURWU8aYH
 0S62Mqq05K1BiUhF70JN0Y0qqaE2ACALx+m/4njcCQ+S0g85zmc2albbxEKxWLyK73V8
 VWFw==
X-Gm-Message-State: AOJu0YzjqQVF7+JggVhflAGMvLYm1n9isQi6heEi6x1TGExfnGRPhAc3
 k0xrMTxjPpZ/mhdUvSS91CHtGzcsezyDsqFuaUU2hJE25gVKqKbaBmCMRVYKc85EkXZM0SU6e/i
 HjcOngAM=
X-Gm-Gg: ATEYQzxdF3woGxzvdkRxk9l6YBieJ04iDl94qWE0Ara6tR0+hcQPIEofw0YS1TWvo64
 DeGl+86A21CT7QjcYqcgwztGFFNY8PawtCoDaz9uL/uXjZxEk8E0WHnGkFbrVX4gu/f3RLq9MdY
 /+m2YJazP78/UMs84n8K0S0+Ky7cvCnNGcFj+MLh382zRoT8dSyAGfBcox8KqArUYJIOupVEVbX
 mhNEVKW/srXoGiIF+X2mKC48VAIzcqXcMcrfunRxjnhDyXa+WHlHrmbPhculjRob4gxCLtRG2Ii
 L7yVCxm25j6A6ctNJKXMO8Z1dHqcYa9EqOMTK25dNfVlX7nHdN6jHGuAy+7n6N7x32bJgaue5wx
 eAGBHTJ3pfsYF6vumVjL5Ke1bt4Vks+uiUeb2hpTO3Dwebc80vV1tMfLcutlr5ZbjBN+3O4dOYZ
 VRyNkvrKXqwgasv1sLrrpydOQDmKP6o+LixAj178amOMoZFpCOa8VJj02QGAVg+A==
X-Received: by 2002:a05:7300:a287:b0:2ba:7b63:3f6e with SMTP id
 5a478bee46e88-2bdd2f133aemr102495eec.11.1772060358715; 
 Wed, 25 Feb 2026 14:59:18 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2bdd1f23c47sm411104eec.19.2026.02.25.14.59.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Feb 2026 14:59:18 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v3 0/4] pcapng: enhancements and test fix
Date: Wed, 25 Feb 2026 14:57:15 -0800
Message-ID: <20260225225916.518790-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260220184255.306368-1-stephen@networkplumber.org>
References: <20260220184255.306368-1-stephen@networkplumber.org>
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

Modify the test code for pcapng so it can run on Windows.
Use wrappers where needed.

The test code can timeout on slow emulated CPU's.
Revise to cap test time and scale independent of TSC.

The library timestamp conversion can produce bogus values
if rte_pcapng_copy() is called before rte_pcapng_fdopen(),
since the TSC delta wraps unsigned. Handle the negative
delta case explicitly.

v3 - better handling of test timeout


Stephen Hemminger (4):
  test: fix pcapng test to work on Windows
  test: use fixed time length for write packet test
  pcapng: handle packets copied before file open
  test: add pcapng test for copy before open

 app/test/test_pcapng.c  | 176 +++++++++++++++++++++++++++++++++++++---
 lib/pcapng/rte_pcapng.c |  10 ++-
 2 files changed, 170 insertions(+), 16 deletions(-)

-- 
2.51.0

