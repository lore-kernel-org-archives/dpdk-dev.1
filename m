Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B0CCCAC5A7
	for <dpdk-dev@archiver.kernel.org>; Tue, 23 Sep 2025 04:45:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 819C440676;
	Tue, 23 Sep 2025 06:45:47 +0200 (CEST)
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com
 [209.85.160.178])
 by mails.dpdk.org (Postfix) with ESMTP id 1849240144
 for <dev@dpdk.org>; Tue, 23 Sep 2025 06:45:45 +0200 (CEST)
Received: by mail-qt1-f178.google.com with SMTP id
 d75a77b69052e-4ca7a71adcbso14780791cf.3
 for <dev@dpdk.org>; Mon, 22 Sep 2025 21:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1758602744;
 x=1759207544; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A1iwbpaUIwnHVmmQWPUO+03mbQuXQsChsL8dlVAyncI=;
 b=FscX8FssiztFIx7oNq8ycsntspgbGiyKhiDcTZIOe0+2jC0lurn/CdQamJGUH1duwx
 JJCVDjG6TtcKNjN5z+FQzMMUgr7eSIeeOrVvLArqKI9KeKFdX5cmHe75jul6zNMyGimI
 3X1fxrfxMdgBFeZeGxC8IP83+gL9BgEGnVALQ4IGNMEbcyaulLJvnGd8jmo4asb9R0QP
 yEY7qyabSnX1BmVPryQY19AdAH96IVq37HucvUfe+K3BdgfEJqISuzNig768qJf6Mbtq
 df+DSPYuolHnAFHpqlsMp5WpgqX3k7J3JWuztyEu0fG/FtKHkCWGe6uIvkMwIw8bpE/7
 flJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758602744; x=1759207544;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=A1iwbpaUIwnHVmmQWPUO+03mbQuXQsChsL8dlVAyncI=;
 b=ZHbA7ZQCHgyyulXDMCD6rBK0uCbTCaib036pzVNG2TA+fmY9LxLoa+1eMXBimC60FT
 qEPBBeAm95a7Ow1cyAmVFMafRHWxMwnN/JZVOcIg0bNygtCwZsGzx1LbTbG+bK7Qv2qy
 5cUGLCe46XBLiTVrOndUlaJg2pes0m9lpwqDKVjwtTYO5sXPpq6MdZ4MvS4yi0l7dVn/
 r/cVpCLsBDn0EJtwup5JGPacqV97NE6okemDj+SvFoxLBczwGLYQacMXu2+gy4qNUvv4
 BnOjPrdqOqZcNiHbftkqrk2vJF25TC/waTKEjXFJWEBKlnpX3QdqRWeLiJoAM9nKfS5n
 /gfw==
X-Gm-Message-State: AOJu0YyD8i7Go/q+0jrEvJEA2VWwMUhsdqGA4ON+waoXUvamSgVnYKvK
 isdfxQLFukd85NBcH9Fw37K53zVIGUJCFQdZD9gICXLokkxeLWWFNlQqOn2ktJAF3cqw+1X/FFz
 m5aD0
X-Gm-Gg: ASbGnctjDWuknjbdDxMT32u3QXmn41Mpx5jvdgeeRh1le1UdTOjivp3H9Ds15qo1QVn
 MNWFiUrWsgfYA46OlCuU4zlNn1Mk/T8oYwPUacAwpXWrHuCdFN5zqjVPMazIMtR3O/ToL7GyH1b
 GNMjkxa/TUChVIHBaWkUWTSOCCEq/KNjFic8c3wPWrud0DO2kLR/Pf+SRjVPwEG9UyhiUQ2lC6h
 y5ZclQVUSnIj0X1kdKv590GOCmMMBtINYGfX+FMOytHJLIJKR+NOGvYvd2+7WC9EiFvWcpLY13q
 nj0bzd9ECnH97ix5coT+b1UZ8WRZaXgxZNde11KGkx8huyqJqUTDw2RiNdjzWD9vByrfSetHKsG
 nDfWrYwMMRuDLI7Avo3gMWRnmhcpwEX0QVIgDMG/ezB+CSgGytdxrXTs6rh5ZdkSIcf25kG5j
X-Google-Smtp-Source: AGHT+IFHOnmfpH0Ir6PXpFfb89bQ+BBD++iQ8SO4sI6EzdIQIqcDsO4kRFn5OyO5gP4EPZ8zSLQc+A==
X-Received: by 2002:a05:622a:1b88:b0:4b7:9a38:d002 with SMTP id
 d75a77b69052e-4d3698e8865mr14965681cf.33.1758602744383; 
 Mon, 22 Sep 2025 21:45:44 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4d0df5f7d03sm14771361cf.7.2025.09.22.21.45.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Sep 2025 21:45:44 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, rbhansali@marvell.com,
 stable@dpdk.org
Subject: [PATCH 2/2] net/cnxk: fix overrun in dis_xqe_drop
Date: Mon, 22 Sep 2025 21:45:29 -0700
Message-ID: <20250923044528.89132-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250923044528.89132-2-stephen@networkplumber.org>
References: <20250923044528.89132-2-stephen@networkplumber.org>
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

The function parse_flag expects 16 bit value for flag,
but dis_xqe_drop is a byte. Detected when LTO enabled as:

../drivers/net/cnxk/cnxk_ethdev_devargs.c:166: warning: writing 2 bytes into a region of size 1 [-Wstringop-overflow=]
  166 |         *(uint16_t *)extra_args = atoi(value);
../drivers/net/cnxk/cnxk_ethdev_devargs.c: In function ‘cnxk_ethdev_parse_devargs’:
../drivers/net/cnxk/cnxk_ethdev_devargs.c:312:17: note: destination object ‘dis_xqe_drop’ of size 1
  312 |         uint8_t dis_xqe_drop = 0;
      |                 ^

Bugzilla ID: 1790
Fixes: 0344fb5a59c2 ("net/cnxk: add option to disable XQE drop")
Cc: rbhansali@marvell.com
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/cnxk/cnxk_ethdev_devargs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/cnxk/cnxk_ethdev_devargs.c b/drivers/net/cnxk/cnxk_ethdev_devargs.c
index 5d774e0d70..68e6b1d190 100644
--- a/drivers/net/cnxk/cnxk_ethdev_devargs.c
+++ b/drivers/net/cnxk/cnxk_ethdev_devargs.c
@@ -309,7 +309,7 @@ cnxk_ethdev_parse_devargs(struct rte_devargs *devargs, struct cnxk_eth_dev *dev)
 	uint16_t custom_sa_act = 0;
 	uint16_t custom_inb_sa = 0;
 	struct rte_kvargs *kvlist;
-	uint8_t dis_xqe_drop = 0;
+	uint16_t dis_xqe_drop = 0;
 	uint32_t meta_buf_sz = 0;
 	uint16_t lock_rx_ctx = 0;
 	uint16_t rx_inj_ena = 0;
-- 
2.47.3

