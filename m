Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71A66C43458
	for <dpdk-dev@archiver.kernel.org>; Wed,  1 Jul 2026 16:21:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5E06040285;
	Wed,  1 Jul 2026 18:21:33 +0200 (CEST)
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com
 [209.85.216.51]) by mails.dpdk.org (Postfix) with ESMTP id B77EC40278
 for <dev@dpdk.org>; Wed,  1 Jul 2026 18:21:31 +0200 (CEST)
Received: by mail-pj1-f51.google.com with SMTP id
 98e67ed59e1d1-37f816d01e3so676198a91.2
 for <dev@dpdk.org>; Wed, 01 Jul 2026 09:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1782922890;
 x=1783527690; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ti49Syya4GlV3SaokTqphGl4LUp6WcHoVu0DaMQzULU=;
 b=vwxlSYCL0FaelsoepJKrv8thIkatzLym5462aGcYyg9gR3SOezq7kupmG563LVHWNy
 genUi7RgFxU1crUJN24LYUMnNkHwblZTvdu7FOUykbLcH5APbLR6bYJ1x6FaDmFVC0Ce
 HlvQlPU938fivRJtRup/3tXSXc+fRyVWYM9CAnGwsO3wLVTS535p+o04UAZSq0LidUiW
 ixxkLWXEiMIDSZgFBUDIUVEj53Zg1mKL3h7ZVwsWbk6Re7Yl+hTDMUtjG26v8awi8Aqy
 M6s4yVYAosGUcaXyBuYeF94w9jJrhFIB14Y14B6uh92lGUUTmW2DXpd2CmyGywHVSJVC
 OWXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782922890; x=1783527690;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ti49Syya4GlV3SaokTqphGl4LUp6WcHoVu0DaMQzULU=;
 b=WVTpE89a/bG/PRTbbAfRyKDwbB3KFqJvZw9PWuaT8mtAFEI24FgODsiEzkoseIWBnL
 FmJ13R2m1t+yW730Zeafu6oA2i5+31C0uGWshK/YNZFaDuUSx9op2hQaenEdiyscF6hc
 Aouf8yYle2+dPv2zinkL9SNARhRMAcd9oAXyGCrJLsd4rB9OXsLeAQkdmuI4wKJDXIyT
 by/JET2a3CZMNWt4Pl24/aD4t7u9D8c5FuH52hhRMwY9zO0oRSD5rv8Dl+jt1ONh37m6
 9ahcRocuaetINdZpJiYo37EEk34LUr/Mx+c1hJtH9PIz4SWcEBg2Jo57kAF5bf9FWdch
 l/ew==
X-Gm-Message-State: AOJu0Yx4WT/1UNrd3zJ8P5gTKvi/EFX6cfSzI30mCNVIYydfXUUOky6Z
 qZbk7+ZpF8izVWVJLsgJsfEzCp2xparJ1OmibBQ4GAocLKwvbHLQR7Ay59m178sA67yXsGGb8rd
 gh52Z
X-Gm-Gg: AfdE7cn8QVT9sRP5PcP8uo52DhL8w3UVFWG/AlZkydymyMSvAT8Vqwnxm1uDVvzhPvx
 Rwj3YVa4VkY+voneorjNcJEbGSgzm9QXYN/XzCCCh7sJFL4+UY/jBOnHjMY/DzxRoag5r375iZ+
 5vShIMWy/go+Qff8CqrujgMMrDTBI7X34fBXwr+Li/LueMz3uFHHnc1kfKxgofK47FwYgkSzV4X
 V0BjtlGhO+iZm0gCwbwxx/PlX+FGPPc4rdHroGELwpSIrCU7JB5rTqCf9xYI9OLhxVoN3Bu4DK1
 rI0aIeokg8Zu4Q4oAmgFgxon2Q7qvvKT9rNndDfDpBiJGGL47Qib8KWZD004Tp5GISU6zcjMmSI
 yq41as2sZHSeMdy+lLTH2diV+dF05+LOvfCCUFVRdvOJHNCPj9GDFj6ourPPrwGbO4jpFkQ4XzZ
 XKYPZsrkd7ju+vD1Wa7r4ZUU4902xG+jcCe8E103CxOp+PvbIuyP8=
X-Received: by 2002:a17:90b:3852:b0:37f:9ce3:ca94 with SMTP id
 98e67ed59e1d1-380aa1fa176mr2097837a91.29.1782922890321; 
 Wed, 01 Jul 2026 09:21:30 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30ee32519aesm22039877eec.27.2026.07.01.09.21.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2026 09:21:29 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v3 0/8] ip_frag: fix reassembly defects and add test
Date: Wed,  1 Jul 2026 09:20:25 -0700
Message-ID: <20260701162127.207318-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260616210656.464062-1-stephen@networkplumber.org>
References: <20260616210656.464062-1-stephen@networkplumber.org>
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

The IP reassembly library tracks only a running byte total and reserved
slots for the first and last fragments, with no coverage map. As a result
it mishandles duplicate, overlapping, oversized, and misheadered
fragments, and the IPv4 key is missing a field RFC 791 requires. There
was also no functional test to catch any of it.

These came out of reviewing a duplicate-fragment report on the list.

Patches 1 and 2 are interdependent: the overlap discard relies on the
duplicate handling so an exact duplicate is dropped on its own rather
than discarding the whole datagram. The rest are independent.

Patch 6 adds a functional test modeled on the Linux selftest ip_defrag.c.
It passes on this series; with any single fix reverted the matching case
fails.

v3 - drop stable from one patch and reword release note

Stephen Hemminger (8):
  ip_frag: tolerate duplicate fragments
  ip_frag: discard datagrams with overlapping fragments
  ip_frag: include protocol in IPv4 reassembly key
  ip_frag: drop IPv6 fragments with per-fragment headers
  ip_frag: reject oversized reassembled datagrams
  app/test: add test for IP reassembly
  ip_frag: remove use of rte_memcpy
  doc: add release note about ip_frag changes

 app/test/meson.build                   |   1 +
 app/test/test_reassembly.c             | 675 +++++++++++++++++++++++++
 doc/guides/rel_notes/release_26_07.rst |  10 +
 lib/ip_frag/ip_frag_internal.c         |  40 +-
 lib/ip_frag/rte_ipv4_reassembly.c      |  17 +-
 lib/ip_frag/rte_ipv6_fragmentation.c   |   3 +-
 lib/ip_frag/rte_ipv6_reassembly.c      |  36 +-
 7 files changed, 771 insertions(+), 11 deletions(-)
 create mode 100644 app/test/test_reassembly.c

-- 
2.53.0

