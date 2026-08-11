Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18B1EC5B572
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Aug 2026 15:55:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 25C6840C35;
	Tue, 11 Aug 2026 17:55:10 +0200 (CEST)
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com
 [209.85.219.44]) by mails.dpdk.org (Postfix) with ESMTP id 2AFFA4026F
 for <dev@dpdk.org>; Tue, 11 Aug 2026 17:55:09 +0200 (CEST)
Received: by mail-qv1-f44.google.com with SMTP id
 6a1803df08f44-8eeb4508f29so19498856d6.0
 for <dev@dpdk.org>; Tue, 11 Aug 2026 08:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1786463708; x=1787068508; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=9K12mhJK+t/e7y98sINW1JdA2/9w/3axHu5TxnokBxA=;
 b=TvDRrFRShXmTRCV00+J4jcZXT+9W0jJbXIS3hp/1XQloJwN7cK5VhmpmJxAD/3Inxt
 MZqsBaLs90A6PmJbdOc1WyfPK+cPh+Dyl+PrRGdsNOOiI7E4Jq4aul06L6v62hFggImI
 aTJGE7Q70y3O6s/AMJKaAPhijyt5evS1CwINo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786463708; x=1787068508;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9K12mhJK+t/e7y98sINW1JdA2/9w/3axHu5TxnokBxA=;
 b=QUvYZ871OuOFIaOrJy1oFjOphdhECA5G5MflzWdQnDSTaTtCEBC5WCdmhX9j+znMiE
 qtoDMJLAZFnMAwGNnz70cbsQ4tsQ2RI3xAn+OewWI/gAeijT3h106Y+Ahp+sgMtKN8XP
 VmHBh+9KwLmYoEdY7nPzHy8JT95slXlzZruIEpCHpzFZr1eVakXK9+J2ZEOmpK436avo
 ERHphLWEwiIBx5WpHYmMAb/2Jt7fZDhyx0XvVN4KVtmO3z+zOEmXOYfLjD5glH361KDs
 HkDNZm18lsom5FThDF6W1AdlH958aW3yUyXjvtzGE9o6BN1wX2pkOwoXSBi6qg5yyrVz
 18BQ==
X-Gm-Message-State: AOJu0YyT8IKOmvV4gsb1xrPEZwxgE+k/tb8nfkuUgPDzsPSMTRF9h2fR
 xG9jySerUu6/N8jAsZHRZg4McMgLb0ac19IDpBaU96gO4fkIooPp5dc2g7Z0evBmAjb1U3hdDZN
 ZGRCwjV43Ub3KnHCBR+jLbneZR6b5byKzX/vTJXnHuP7qekZRni3jA0+rCQWikyDb4uGyieooVn
 GDTAljZnJXsjxjtxcUTAcnswSzbtA=
X-Gm-Gg: AR+sD10ivEku0yE5jeH33zWIc60N/3TGnp3WLnAWHqloGsOI0PNqVPQbJAuzey9HNF2
 wo6VP8druEbkCFhsDJ5gmSBVpL06MLWGXIyddkdGjFf/M5v2ZhUotWjPGyCL6x+Kl5ahxSDLIqA
 lVLaHdbrq6xCcYSh1VH56REqGEZwBV40Ihl3UkcSXJFuEzUEHtSOgfFWN6VaLjvYuEknRwkShKF
 vr0P0PwMHWP0BCM2sFjCHaamZvkURK062EC8tcxtVLIrZKQow9Ys53V+veKkAOUkV5yl3ND4ZXP
 nlQdIUovUjB5LrRY4aCvNfyypbLdxo8BN9DtxXRxPnuxQt61ePfpjvFVGgdCOWvRrSqf2mpuE7w
 xAHhBfMe9hf63oCSeH12gsfVCrlW+qWl6HtUAWsDMVIRjWKHHpq1MTycJcTI3oKLjRzUxskEvwH
 iAlCIoa6ihQo1nSQPi+qhg9J0nniz0BJidPDVUzv0+JL1Ydo+JDGQ98248nySvWSPmIkI9f5P6A
 U+alq5JDDA=
X-Received: by 2002:a05:6214:19ce:b0:8ec:235c:7a66 with SMTP id
 6a1803df08f44-90a66ed9380mr40097706d6.27.1786463707970; 
 Tue, 11 Aug 2026 08:55:07 -0700 (PDT)
Received: from d121029.iol.unh.edu ([2606:4100:3880:1210::219])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-90a6c29fe59sm2120326d6.15.2026.08.11.08.55.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Aug 2026 08:55:07 -0700 (PDT)
From: Andrew Bailey <abailey@iol.unh.edu>
To: dev@dpdk.org,
	luca.vizzarro@arm.com,
	patrickrobb1997@gmail.com
Cc: knimoji@iol.unh.edu, lylavoie@iol.unh.edu, dladd@iol.unh.edu,
 Andrew Bailey <abailey@iol.unh.edu>
Subject: [PATCH v2 0/2] dts: update verbose output regex for VXLAN packets
Date: Tue, 11 Aug 2026 11:54:48 -0400
Message-ID: <20260811155450.486646-1-abailey@iol.unh.edu>
X-Mailer: git-send-email 2.55.0
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

I am resubmitting this patch on the behalf of Dean as he no longer works
on this project. No changes have been made, only a rebase on main to
resolve merge conflicts.

Signed-off-by: Andrew Bailey <abailey@iol.unh.edu>

Dean Marx (2):
  dts: update verbose output regex for VXLAN packets
  dts: add VXLAN protocols to flow test suite

 dts/api/testpmd/__init__.py         |   2 +-
 dts/tests/TestSuite_flow_offload.py | 202 +++++++++++++++++++++++++---
 2 files changed, 181 insertions(+), 23 deletions(-)

--
2.55.0

