Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCCBBD277F3
	for <dpdk-dev@archiver.kernel.org>; Sat, 10 Jan 2026 17:23:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0CF3D4028E;
	Sat, 10 Jan 2026 18:23:42 +0100 (CET)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com
 [209.85.221.45]) by mails.dpdk.org (Postfix) with ESMTP id 036BC40144
 for <dev@dpdk.org>; Sat, 10 Jan 2026 18:23:41 +0100 (CET)
Received: by mail-wr1-f45.google.com with SMTP id
 ffacd0b85a97d-430f3ef2d37so4491393f8f.3
 for <dev@dpdk.org>; Sat, 10 Jan 2026 09:23:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768065820;
 x=1768670620; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BrYJKyULIpJXYBg8DqLRcvXUGdMtGgexeH/RJHo5W30=;
 b=QHskkIhUrCdbkNQKP3sj/NAzzrvENoS8B3I3Barli2cvYfpbdYDtdksLoXTL1AbJRJ
 S01OhbGtz0y4RDD/iKBIYNagdzSvd6o19IwP6zbwl/D0bY4nZRlSux6p45DpwgWwzeoL
 ej5FGSwkbW9Mw4tvdnTpAwGqOnEpnDYiXcdiURhzdC9vjvtdoVXBUkAkb66XDpZRT5iA
 yEk2hqDuUQbazuupLzLNxV7hrD/oalKchU+xfwNeQXRQKqyXDT8PLngR5BTp0N6zfXuK
 Sot2o1GRWqFBn6ZnH5cdzU75HJElJs+QOmIHULlCmouDV3bh5A6GUu8INWUMWvmbMYg0
 NFYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768065820; x=1768670620;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BrYJKyULIpJXYBg8DqLRcvXUGdMtGgexeH/RJHo5W30=;
 b=tq7zZQd7liRSFlj/VLTUfVlc6KNtcFDR1Gv+HHhbi1n3FKIMZcBaqXVf9vJ2TDZBrn
 HeqOG6WsPqKZaAgUZqyQbl0V7/vldOIFzYiErRtRAjtoy8VWWCJ7V1JHU3WpHKxPBTYB
 28c/Y66WMvoMBrezNmd6D2lkUisAquXTmZyonkCKocabHEsZ1b0MvHPbdY40bnNVW8j5
 WVKctTWRvjdTZp1H7B43NutlB3iTJx5DZaTfJ/BOaz6UYFsdSvUmXjP6XIuVezBu3Ns5
 to46h0ez409tDhMEM0d/EWgcyNQXE3Z9CtEYP+LywpcfNnIKOc5bUk7UoQsoQKUlS7d8
 Pftw==
X-Gm-Message-State: AOJu0Yxowqv675h74ZoDLt3dQRxDgge+7ge6IOCNe2RXlZRolDdcvKuP
 /ufqhQRxTiP0kSTBpzGyQP7yt41zqOjEZSm7FQ/xKqpuJqdI1jgo7/BEjOY437drQhaxQSyBu33
 cgNY7
X-Gm-Gg: AY/fxX7jopLq0t8bGjOO0y8lsgGdb3EdJuhIbs9eJfExaXHKUUdMNNVceezQvpCGar9
 EroJtmJuqhs//TIdJ+crdzlkGyP4iSsrneGI30hJTOW82CYaCXBzdqxd7YDuA5ALDLMVUmPMXUa
 ovMnRjyuNGTP689lCR6riAH/Y3rfkS9ELXf0n9/m1hQHtRfuIo9YWqKFa8h7YcGbSZKc/ODWNza
 +wXlZjmXnC6xvL8K2L+sgD37MugZt4WUBUPAmTsgL0lJzSHH3WBmiN4sbY3vkIxnwbJ083o9nLC
 N7BBmmP2YmeqP8YRVr36D9T8R/nTSDI1G+IIdfqxy1S9Svcc4pkABs3WXZowS1C1b/IFWqhcgG6
 7mins1N0FooW0ak8v7BUUEKXpIdJCSrBJsvtvfwboevqFQU0scbx+B5oMeV/MhrFB4YIfuT1eqW
 7VJVn3KfBmxfkADsQTNFyXRNbMebZAFF39ig/0ghL5Rx8rrdSx5w==
X-Google-Smtp-Source: AGHT+IEp4IAFHVdGRHnx1KQ8wXtha0yOzN2FFUcg0GwkXezDuTg0NDx9DNhx0djphXpQa2glEFaAtg==
X-Received: by 2002:a05:6000:2013:b0:430:f5ab:dc8e with SMTP id
 ffacd0b85a97d-432c378a8c5mr16408812f8f.13.1768065820564; 
 Sat, 10 Jan 2026 09:23:40 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd0e16f4sm29558206f8f.11.2026.01.10.09.23.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 Jan 2026 09:23:40 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v4 0/3] null pmd minor cleanup and add test
Date: Sat, 10 Jan 2026 09:22:35 -0800
Message-ID: <20260110172336.9859-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260104222523.329760-1-stephen@networkplumber.org>
References: <20260104222523.329760-1-stephen@networkplumber.org>
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

This series adds small optimization to net/null and
adds a unit test for null PMD.

v4 - change parameters to packet burst

Stephen Hemminger (3):
  net/null: cleanup info_get
  test: generate larger packet bursts
  test: add a test for null PMD

 app/test/meson.build              |   1 +
 app/test/packet_burst_generator.c |  38 +-
 app/test/packet_burst_generator.h |   4 +-
 app/test/test_pmd_null.c          | 968 ++++++++++++++++++++++++++++++
 drivers/net/null/rte_eth_null.c   |   9 +-
 5 files changed, 994 insertions(+), 26 deletions(-)
 create mode 100644 app/test/test_pmd_null.c

-- 
2.51.0

