Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7435DC44515
	for <dpdk-dev@archiver.kernel.org>; Mon, 20 Jul 2026 13:34:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 77D384028E;
	Mon, 20 Jul 2026 15:34:41 +0200 (CEST)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com
 [209.85.221.49]) by mails.dpdk.org (Postfix) with ESMTP id C802A40288
 for <dev@dpdk.org>; Mon, 20 Jul 2026 15:34:39 +0200 (CEST)
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-47f785467faso605284f8f.2
 for <dev@dpdk.org>; Mon, 20 Jul 2026 06:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784554479; x=1785159279; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=coEknfaMuENiodM1P7yATkk0yqdGrx5xww1v5IOy8hs=;
 b=mz7cpxz9FGFuBNvNer/wOuh6Xd5W4LTjlsSTus9TISq5MyBgKafKwBJE94pB1mABtx
 Br7YbL52dQOnVuCP42Yi4cZ6R6V0upPVmPN3TIAwL2c1bJ++boFzAQpKx+j03M0Nt7NB
 5tBBJiUmbeRGMDUgdgDN5NYO3eCoVv9xfuKXtPZeb4o0OxkfjZmx5MCXFmwfmzIWFwVb
 h2dgqYGOI9GwmppUuHp4hfZWXmu4bw530QWyJxIAJsjVVS1AZitPGvdE5qJkKNWwDXe9
 Wh8SPC1RaxTMYb81ofceR6iM0SZltbaccGqiJKqTKbIY4exn/r2mg8/qaZjil/D9X1Gq
 pgEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784554479; x=1785159279;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=coEknfaMuENiodM1P7yATkk0yqdGrx5xww1v5IOy8hs=;
 b=Dh3KLeOPs9IDcc+vniFLz/OPO60odC1FOePFiwZ1ZWQKAAzb//Mt0efoDvJ1YSXDU6
 i9mHQE/7LaxqMoJB6XcfKDo2bbigY6KTb2FBc5NLYwzaYnIdWwuYBBLVAnH/kXY/72C4
 jxJzwTpQpo9hcoqG04lW9N0LlnaNHQTJmXAlG6IVYE1dVvCCtiLTioXfvm1SyxMhquJG
 FfohmMmUg4D3ZRnQXunchKdviVmuWsRelQjjUk5/YJqGt6aGCASsQISkU6kjqcYoakxj
 LjwmzkSp1LmXkSYCtI1uveFF0gcXUCF2rUFauwyg/d4d/4ae0ExtGL+GvLJd0OEQH4By
 SKBg==
X-Gm-Message-State: AOJu0Yz0UhNJllUsozzycmGJONPiok/faEOgYRDg/58YD7UsFgvlom1r
 r6fnkorXcy9aJj7VRGwTZXjuTrOpN5vZcAGX+KVaREmHJ5h1MwwpWnbQ5N9XqDNa
X-Gm-Gg: AR+sD10R/vmpkDNScgiQZm6ieknxNim9vooHfd7G6aHHdTR3PMV5AxH9T7nHCDXNnDH
 MlwRPIk+vcKOhtFIFKn7DAo1fkfhaqvwsx74WwQNiB0NymWzbBsy/jVTJshmztDSdQdRK3A92QQ
 kYgI197DdapGV8PJc/jbmNTQQDWGOvMrZuqp3Aw2rgRsxxOf1NCZ/k8frrPzQX74c/hcP0wr9pb
 Kfie7BqONBfOMTwLjOl+plI6/FpiPthDi2Sh6ztImyTXu0BfQHtLERWseCdfGbw1UAzf2hAdrlf
 UaliLR05ynhhCBnQa+YvxaF0gEUXfVQ3HY5nAYoJ10ARVd64Tc6pY0d7kpjFk9V9jsBsW7QjtJe
 azhIFuLfuQmGUhDijUiDFD/KwlBTsAIN/Ovzen4OAE+6JVeX7xVprvO632iP874vW0e8htHwx2x
 ssx6VZELcGpj9NGMH2Ng6kndGCyWz0v9PjP2E6igau
X-Received: by 2002:a5d:5d0e:0:b0:472:7dce:d8c7 with SMTP id
 ffacd0b85a97d-47f62328198mr16394076f8f.36.1784554479071; 
 Mon, 20 Jul 2026 06:34:39 -0700 (PDT)
Received: from freepad.sicorp.iliad.local (free-mobile.vlq16.iliad.fr.
 [213.36.7.11]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f63e51986sm34246203f8f.11.2026.07.20.06.34.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 06:34:38 -0700 (PDT)
Sender: Maxime Leroy <maxime.leroys@gmail.com>
From: Maxime Leroy <maxime@leroys.fr>
To: dev@dpdk.org
Cc: thomas@monjalon.net, david.marchand@redhat.com, hemant.agrawal@oss.nxp.com,
 Maxime Leroy <maxime@leroys.fr>
Subject: [PATCH v1 0/2] net/dpaa2: fix RSS for plain and tunnelled traffic
Date: Mon, 20 Jul 2026 15:34:34 +0200
Message-ID: <20260720133436.869334-1-maxime@leroys.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260630123857.392884-1-maxime@leroys.fr>
References: <20260630123857.392884-1-maxime@leroys.fr>
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

The RTE_ETH_RSS_LEVEL_INNERMOST support merged in 618a06c53d47 maps the
inner level to hdr_index = HDR_INDEX_LAST in the IP key extracts. The
hardware only resolves that index when several IP headers are stacked, so
a non-tunnelled frame, which carries a single IP header, resolves to
nothing: its RSS hash is constant and every such frame lands on a single
Rx queue. This breaks RSS for plain traffic, which the ethdev API
requires INNERMOST to hash, since a plain frame's innermost header is its
only IP header.

dpaa2 cannot express strict inner-only hashing and keep plain traffic
spread at the same time: the only index that resolves for a single header
is the outer one (index 0). This series therefore reverts the INNERMOST
support and, rather than exposing the RSS level selector, always extracts
both the outer IP (index 0) and the innermost IP (HDR_INDEX_LAST) as the
PMD default. Plain frames keep being hashed on their only IP header;
tunnelled frames are additionally spread on their inner IP.

The tradeoff, documented in the dpaa2 guide, is that two tunnelled flows
sharing an inner IP but differing in their outer IP may hash to different
queues. A future generic RSS level (for example OUTER_INNER) could expose
the distinction explicitly if other PMDs are interested.

Note on timing: the reverted INNERMOST support is present only in the
26.07 release candidates (currently rc4) and has never appeared in a DPDK
release. This series should be applied before 26.07 is released, so the
broken behaviour never ships and no cross-release regression is left
behind.

Maxime Leroy (2):
  net/dpaa2: revert inner RSS level support
  net/dpaa2: hash inner IP for tunnelled traffic

 doc/guides/nics/dpaa2.rst              |  3 +
 doc/guides/rel_notes/release_26_07.rst |  3 +-
 drivers/net/dpaa2/base/dpaa2_hw_dpni.c | 82 ++++++++++----------------
 drivers/net/dpaa2/dpaa2_ethdev.c       |  3 +-
 4 files changed, 36 insertions(+), 55 deletions(-)

-- 
2.43.0

