Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC96BC44515
	for <dpdk-dev@archiver.kernel.org>; Mon, 20 Jul 2026 08:00:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8BCE24028F;
	Mon, 20 Jul 2026 10:00:54 +0200 (CEST)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52]) by mails.dpdk.org (Postfix) with ESMTP id 215E04028C
 for <dev@dpdk.org>; Mon, 20 Jul 2026 10:00:53 +0200 (CEST)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-493b966dd74so40728575e9.3
 for <dev@dpdk.org>; Mon, 20 Jul 2026 01:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784534453; x=1785139253; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=o5obO/0ENG+D+AJyEOeMGBq0bpvDEJY1fWGikOx3mkw=;
 b=nnjJusah6FHs+O0aLPDQ9SLpLzg3mVN6FghDJm546cS5g7EQU0KukLl7U+0UWjruC4
 23DLZJxBtXVvXdUfDTohrZKUI4PhKAd2Ga3ZTsOiidlcaocKs20bK5X5mrbxlV/adbTF
 1Z2tzrocgikUV1sl6qm7apqO1m38uhwKyTyzxjP4jlrOyfXgk+2/ya9EbOMuYs/+HzW4
 SFHdc9OpgBYKsFKsk2syIm6SxqdeoXwQ5vxr4VpgEntm1vxTstsSiigsFuavM+anoBze
 mnlIAZcD5FCdkVHTnyBsXDCC6hzfcJ8YIzdNKrZdFybk0wxK/u3GnsQU+pVDiUpcD7Pj
 y6WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784534453; x=1785139253;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=o5obO/0ENG+D+AJyEOeMGBq0bpvDEJY1fWGikOx3mkw=;
 b=Rqy858ZL3R2XyeGKYBcLCeEvuTLF+FEDSeBoX2TvMmzQl05Q0UeQtob/7xj7QtZY8j
 6WuLarrufxRrJOOqInbs++2XLdco7f3fu0Ur66t4101fbtIdEhU5Z7LY1ho4oYKICYhK
 VXALroC4s/8i6z6OBL6wa4LwoOF2YKHUXFZBlHw+03h+U7mEuzoSDLn1E6LIDpZGbQS7
 yAtZ9U4bNMPMkxEtxSGSoV4slTgfi44sFhYbxPBclITecf2laPTyrrMKt4jQHmZBjPrM
 UvfywRaVG4Y/lWL/DQKx8mjNtN1WVimqHO0/D8X+amBjKKT5lTXT4YDXbnFOp5CsV7lI
 C1MA==
X-Gm-Message-State: AOJu0YycJK3m/LFkXMkeU/4USYRwX/+V2xHONq48IVY15A9P7xAkv2/l
 Y6cPpjZLvz2ykfuw8lBihj2S/FVCQdMvDfqPz/0GXiHOS19u4Vw6bnwvJcLoxw==
X-Gm-Gg: AfdE7ckkK5A/BQD2WNlD2em2GpL2nuUe18cwl9n16lAlvi3a7h/eugio6poiKQivMyq
 tEVMVluU64TWzjSu/YWpZhwD9ahJpdo3qDG/IZQBAN5RFMEl3UiwwiFgc6kyb+Rwp2ek4GvqWCd
 VEBuuhEHNFjhs/uLBsgBg/5E0j2/9vepMOyy8yEbBVyMjNY2L0XtHQ5eczSOQ9VjAsNuKi4QorR
 H5hrw6A8uNUgfklI7AHIx+QrBCavqNyZS2hRRiJOuHaBgKfQngE9s0rkwLWLSHmdvrIVg9ovjXs
 HvSbD9cecGyrY2QvZS6UKbW80W4Ii10qDGFDZjcCaj04YGseqSTW1yFprM60OKTNxWxhXRtgEFz
 GRAxdJp0oncYW1P2z1apoSq1BJDWlejlk6vZkpUT9jQtYgjJeWi5CozgZJcrA+Rargmd7BRXnkW
 UJWgrbFCYkp4Q2bcaIDA7ztu9xr8YSFxD37yIv/kGw
X-Received: by 2002:a05:600c:6287:b0:490:e5c1:b8bf with SMTP id
 5b1f17b1804b1-4954a3f3927mr139588095e9.13.1784534452249; 
 Mon, 20 Jul 2026 01:00:52 -0700 (PDT)
Received: from freepad.sicorp.iliad.local (free-mobile.vlq16.iliad.fr.
 [213.36.7.11]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49549c96fecsm308012755e9.11.2026.07.20.01.00.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 01:00:51 -0700 (PDT)
Sender: Maxime Leroy <maxime.leroys@gmail.com>
From: Maxime Leroy <maxime@leroys.fr>
To: dev@dpdk.org
Cc: anatoly.burakov@intel.com, sivaprasad.tummala@amd.com,
 Maxime Leroy <maxime@leroys.fr>
Subject: [PATCH 0/6] examples/l3fwd-power: fix Rx interrupt mode for shared FD
 PMDs
Date: Mon, 20 Jul 2026 10:00:29 +0200
Message-ID: <20260720080035.673782-1-maxime@leroys.fr>
X-Mailer: git-send-email 2.43.0
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

l3fwd-power's Rx interrupt (one-shot) mode was written around NICs whose
interrupt fd is assigned per queue at setup, stays fixed and is
level-triggered, as on MSI-X hardware. PMDs that do not fit that model
never sleep on interrupts: they either fail to arm, watch an unbound fd,
or miss the wake, and the 10 ms poll timeout hides all of it.

dpaa2 is the motivating example: it delivers Rx interrupts through one
QBMan portal per lcore, so the queues of a lcore share a single fd that
is bound when the interrupt is enabled, not at queue setup; the
notification is edge-triggered on an empty to non-empty transition; and
arming a queue that already holds traffic returns -EAGAIN with the queue
left unarmed.

This series makes the interrupt and legacy loops handle those cases
while leaving MSI-X NICs unchanged:

  1/6 factor the duplicated arm/sleep/disarm block into a helper.
  2/6 check the arm return: on -EAGAIN poll and retry, on any other
      error drop interrupt mode for the lcore instead of sleeping on
      unarmed queues.
  3/6 register the fd in the epoll set after arming, not before, so a
      fd bound at enable time is watched only once it exists.
  4/6 accept -EEXIST when several queues share one fd.
  5/6 recheck the queues before sleeping so a packet that arrived during
      the arm window is not missed under edge-triggered interrupts.
  6/6 block indefinitely instead of on a 10 ms timeout, and wake the
      workers through an eventfd on exit, so a broken interrupt path no
      longer hides behind periodic polling.

Maxime Leroy (6):
  examples/l3fwd-power: factor out Rx interrupt sleep path
  examples/l3fwd-power: check Rx interrupt enable errors
  examples/l3fwd-power: enable Rx interrupt before epoll add
  examples/l3fwd-power: accept shared Rx interrupt FD
  examples/l3fwd-power: recheck Rx queues before sleeping
  examples/l3fwd-power: block until Rx interrupt or exit

 examples/l3fwd-power/main.c | 184 +++++++++++++++++++++++++++++-------
 1 file changed, 150 insertions(+), 34 deletions(-)

-- 
2.43.0

