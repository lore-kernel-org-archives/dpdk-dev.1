Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1BCDCAC5A5
	for <dpdk-dev@archiver.kernel.org>; Tue, 23 Sep 2025 04:45:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DBBE34060F;
	Tue, 23 Sep 2025 06:45:45 +0200 (CEST)
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com
 [209.85.160.169])
 by mails.dpdk.org (Postfix) with ESMTP id 225AB4021F
 for <dev@dpdk.org>; Tue, 23 Sep 2025 06:45:44 +0200 (CEST)
Received: by mail-qt1-f169.google.com with SMTP id
 d75a77b69052e-4b5ed9d7e20so50590701cf.0
 for <dev@dpdk.org>; Mon, 22 Sep 2025 21:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1758602743;
 x=1759207543; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=6rFMHek97teAX6fsjfBIFU8LQl/ia5wHp0lyNoLeajo=;
 b=cU/CZllQSKgJg9j+Sr6py/kFasSvdTdaI8Fao69LqaB1RW7ikYql9IBzdYRM2zYd8+
 8Gj99INpVmP7SZ/e5hSU7BdHd7Pbiovk81Nhaef95QuyQhoH49G363FIwBUkgzWsUh70
 C2tFRrF9vtU4vk18x1MlschzZdC+v//ITbCpRYqK8pjWuS59CdqcDLOYb9PsPlqdt9o/
 rjUvzbK9KXqc8JI2NX6PpvQWKRDctv1A3KEbVl7G+IprDuSRjYey/s43BDq3ZugaMugp
 I3DkkKb3PRGW3LK2W23pfBaHPDCH2MXSZB5BIMCXhedAtUmRstmbI7H/Uy+yJN/0OWyR
 DH6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758602743; x=1759207543;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6rFMHek97teAX6fsjfBIFU8LQl/ia5wHp0lyNoLeajo=;
 b=ZrAR+LxPeBwlCPyLVSQxMPPQ4mifYRXF4rW88WVCubBDnvB92VJneFOOlcDe4xAjgK
 YxBHRSstgFV6PrzgkfNeZEw5fo6oVzNgeaBCK+d9YyTQOy2R0m+OVZ1bvtFtnBVnWDSj
 5rrEjsEX0OzawZjy7hrTDHaUsQlVgnja01OegpMhS07xnwPRA6JsUxKQ7AlyG5Okl5XV
 AaQHXnqOZkaWqCzcCMl15XxqnGvsy5xa01/xdxSM68DYM12WmcKsCxaVghAVAm9iHG2j
 9yVKkFtMn2RxbX2JVtTaui/JdquPjFWi0n3O6nx/3Z9x51hYWJWLiMukEWVqUAFNll+K
 /AOg==
X-Gm-Message-State: AOJu0Yzt3j8Uhzp/ewf9PLyYxb+YehI9i9EpXPluivXM5TNvOjDWfCdo
 Y0KWu/Yi6+NCCSt13EhFHA2V5ljS5G0Eo4YByiVkoKopdUwkqfPzShvWYjUzDPmoxQZ1D0pwhbd
 bElo+
X-Gm-Gg: ASbGncvEIGqsbZ8Ngin3VMsIf+iF2U6E+8FkjG2qUX5h7M6c01qxGwEpJPPmqlx5dL2
 rf9o2ij17EOC82TGjMvfYbIPku6P75iI/040wFj9YUlYvC5ka8r2Mzi5TPx60rksWbsqqIGQ1gi
 gcVh0IIU4BD9BNp5f58QHv6RzTINKiyzIudZ6+OWFybE3BdaqM0qYlc4t0Bauhg/l7nQCODgMki
 8VYdEtPQBR15drJdh9XgmTKE3e1ASplLxRVsNkKgwFMf2Wwel/0fxXg8hBsQ2ezy0jGTDl2IUdF
 uHKKov658TIHht1kuXFOjaFSC3cQZZoll/kkvzUz3w4jTqbDeVjc4OtJv78iqYTd2i1iY4yFqm7
 53zNZGYzih6NFx5ha1ZLI+p+DCIwdxtP4ixIV3iCQ3A58J9s1ZDFWL68Af517FevQs9SCYZGm
X-Google-Smtp-Source: AGHT+IFL6K51yWGdSqL/MOe0UV9XyWhLruBa8axRPvnj8Z8c4HYXfCDBMkY91vieS1QDQMethKFi5g==
X-Received: by 2002:a05:622a:22a0:b0:4b7:aa99:5459 with SMTP id
 d75a77b69052e-4d3736bce5cmr14123011cf.76.1758602743308; 
 Mon, 22 Sep 2025 21:45:43 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4d0df5f7d03sm14771361cf.7.2025.09.22.21.45.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Sep 2025 21:45:43 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, rbhansali@marvell.com,
 stable@dpdk.org
Subject: [PATCH 1/2] net/cnxk: fix overrun when processing tail drop arg
Date: Mon, 22 Sep 2025 21:45:28 -0700
Message-ID: <20250923044528.89132-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.3
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

If cnxk is compiled with LTO, compiler detects that the code
to parse a flag is expecting to write 16 bit value into a
one byte field.

In function ‘parse_flag’,
    inlined from ‘kvargs_process_common’ at ../lib/kvargs/rte_kvargs.c:187:9,
    inlined from ‘rte_kvargs_process’ at ../lib/kvargs/rte_kvargs.c:203:9,
    inlined from ‘cnxk_ethdev_parse_devargs’ at ../drivers/net/cnxk/cnxk_ethdev_devargs.c:371:2:
../drivers/net/cnxk/cnxk_ethdev_devargs.c:166: warning: writing 2 bytes into a region of size 1 [-Wstringop-overflow=]
  166 |         *(uint16_t *)extra_args = atoi(value);
../drivers/net/cnxk/cnxk_ethdev_devargs.c: In function ‘cnxk_ethdev_parse_devargs’:
../drivers/net/cnxk/cnxk_ethdev_devargs.c:306:17: note: destination object ‘force_tail_drop’ of size 1
  306 |         uint8_t force_tail_drop = 0;
      |                 ^

Bugzilla ID: 1790
Fixes: 75473b5b62c3 ("net/cnxk: add option to force tail drop")
Cc: rbhansali@marvell.com
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/cnxk/cnxk_ethdev_devargs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/cnxk/cnxk_ethdev_devargs.c b/drivers/net/cnxk/cnxk_ethdev_devargs.c
index e42344a2ec..5d774e0d70 100644
--- a/drivers/net/cnxk/cnxk_ethdev_devargs.c
+++ b/drivers/net/cnxk/cnxk_ethdev_devargs.c
@@ -303,7 +303,7 @@ cnxk_ethdev_parse_devargs(struct rte_devargs *devargs, struct cnxk_eth_dev *dev)
 	uint16_t outb_nb_desc = 8200;
 	struct sdp_channel sdp_chan;
 	uint16_t rss_tag_as_xor = 0;
-	uint8_t force_tail_drop = 0;
+	uint16_t force_tail_drop = 0;
 	uint16_t scalar_enable = 0;
 	uint16_t tx_compl_ena = 0;
 	uint16_t custom_sa_act = 0;
-- 
2.47.3

