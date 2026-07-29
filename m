Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14F89C53219
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Jul 2026 18:00:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8AF0C40E38;
	Wed, 29 Jul 2026 19:57:58 +0200 (CEST)
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com
 [209.85.216.47]) by mails.dpdk.org (Postfix) with ESMTP id 1C92140E16
 for <dev@dpdk.org>; Wed, 29 Jul 2026 19:57:50 +0200 (CEST)
Received: by mail-pj1-f47.google.com with SMTP id
 98e67ed59e1d1-38deea72eebso1326542a91.1
 for <dev@dpdk.org>; Wed, 29 Jul 2026 10:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1785347869;
 x=1785952669; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=uhlBVr7LvIUuwGqvE3jFh7veqJ/02zCN791CtXiegBs=;
 b=dgwIcpLZqEUMlsSQ0VobWDKHpbll2ZYehTDjJyMuryLuQpAdn95SK/ZFGfMn4av39/
 4hMbJndcI7FHj9ViXyfqahp0ntAWULmvF3Uup0WpihYW+OmYxuIBjjacggtRf/mJbDDm
 tu3mc/hvgX7/JoL6f+3KUzgG84PduiTLDBYFjssLm9L64fmPOqdUt7DqOsiEiKsZkT+U
 KGUYYztMt25gNQO6XJvdvvXvhRFuPxEfWhkk18S7XkJSfer9XdwyIdz1d18eJ+fo5UgH
 CL5MXQtws4bt6Osbjd/M2sY1gl/kKrj2LxOW06/+TMlWksG7WkoZcAQx+LLZYsoJ25T5
 pZ2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785347869; x=1785952669;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=uhlBVr7LvIUuwGqvE3jFh7veqJ/02zCN791CtXiegBs=;
 b=Tlj28R4zV7yy4UPoLGX13/GcOi6zo13rAswogYnzlDvEg4vtEJddrlF2KJ63B4xbs9
 DnRv8OqO7kzzyfKJiHXOhieEM8GsTWitafzvW/U3FMvgymJZVufTg110TECgLVIVKmHf
 mm++doYVW34MkhIL2IrnlipKwq4wmC52y7lNaUI95M4KeUIj7aXAQ/BV7o2xdNEVR1wW
 UddgepK3u6b9oX72sU6jsIhxVa0kQcc3NJvpHDanzJMHFbGG8qFAbqWWI07EHwnJCLtk
 KYwCCOuiQuBQF9knggJpLWupyXM7kcL0x+mPOYdOhBRPgby0r/r4+4gVAdNrrCQc21sp
 GYdg==
X-Gm-Message-State: AOJu0Yx8LflWAX2hW5iYWwuLHlUCJxrRAD3KkYqGc85lHjco50giLjJw
 aV/+cm1vKLSFTo/ZscxVqabKQbwClbc6bjSpuYHq1cnxLwRrWxAaluhHuxNAVLCELPhniSo0uCE
 LK/bm
X-Gm-Gg: AR+sD13J6UM9SNCPo1q1aL7wXFWh/h36pEaelPcro8g8/pfDJAJec4QWoFm8/pOxKIV
 gS/gB2bBt5H8L7xQkw0ijfCicoDN9NZLboYqsFiaTrv08KLv/XKOlpVmrQpSEac7DSzClqG4tvK
 8YMKMxVKs9kEDCIrD7UmaI+b/DOhpwFxJXhZTDnKFlefVFEelmznRTdGZwaXYsc1B01aoFCyaCC
 aYZGUpYnen2gIKw5LOO6pJ/lnGmX0QWUGYzDRaqPZwTTUhU8zCKVmfJWsfaTLshaQvft/nZl2GQ
 rfPNXgLlGnDVHxOpK/dyyik77G47ANWa0qYS1bh5ku6GKlvrTQIE3f13D8u9TnTMpoTUae9ubYP
 cbiTTY+Sjnu4+vW9qjLr1gHG0mMrpt5Tgg1W/J2P1NeV/AcZdPGWU5BcbKFixRte/ZJBZIqSbx8
 iDWOI9NRi2sP+9DImHODaubghx/+N5+4833Zk1SN3at5p8q4Fh7jxetF1t2LnFZfVHxI09Vm93D
 V2K6bVIjRRBVNeBnV06Q/f/HjM=
X-Received: by 2002:a17:90b:264b:b0:38e:4b71:8b0 with SMTP id
 98e67ed59e1d1-38f6a51ccecmr8113295a91.25.1785347869214; 
 Wed, 29 Jul 2026 10:57:49 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31504b15f77sm13111562eec.4.2026.07.29.10.57.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 10:57:48 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [RFC 29/32] eal: remove stale SMP barrier in rte_service
Date: Wed, 29 Jul 2026 10:54:22 -0700
Message-ID: <20260729175715.165120-30-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260729175715.165120-1-stephen@networkplumber.org>
References: <20260729175715.165120-1-stephen@networkplumber.org>
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

Leftover missed by the C11 atomics conversion of this file. The
barrier pairs with nothing: no store follows it, and the next use
of the lcore is synchronized by remote launch.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/eal/common/rte_service.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/lib/eal/common/rte_service.c b/lib/eal/common/rte_service.c
index d2ac9d3f14..0c6467285b 100644
--- a/lib/eal/common/rte_service.c
+++ b/lib/eal/common/rte_service.c
@@ -795,7 +795,6 @@ rte_service_lcore_del(uint32_t lcore)
 
 	set_lcore_state(lcore, ROLE_RTE);
 
-	rte_smp_wmb();
 	return 0;
 }
 
-- 
2.53.0

