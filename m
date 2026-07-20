Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 017C2C44515
	for <dpdk-dev@archiver.kernel.org>; Mon, 20 Jul 2026 11:46:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D38F040290;
	Mon, 20 Jul 2026 13:46:12 +0200 (CEST)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com
 [209.85.221.54]) by mails.dpdk.org (Postfix) with ESMTP id 8731A4028E
 for <dev@dpdk.org>; Mon, 20 Jul 2026 13:46:11 +0200 (CEST)
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-47f785467faso511797f8f.2
 for <dev@dpdk.org>; Mon, 20 Jul 2026 04:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784547971; x=1785152771; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=lbDUYv6SvxLDuwhS9L5Ru6LW03tqe3dok4lTiVGMOFg=;
 b=RKG5kE4qxbT+MkoD5xyiAH0zltxXwoRp3qj2tupu3UvqA6ulEra3Vln3k2IOU6blHK
 pnDL/Ejhh64CDlYUaXdU0eetHdfQcIpkqRsVW3XXEMm61uX9kg6XzRP05DhtCAZ1ferH
 zs0PyxJKgvXrIoUU1j+AnYLZSyDknnb+Rr838KORtbxvl00qYlhiaPr3tzP3Qy57mfuf
 ZLy2muYxrNiiS9+WfeUwURGgqNu8Wflzu7yy1JoK0TFdMoMo40VbG6o8nD4oWWozTSmp
 mQKXSHpC+QcT+TB/72xGTbLoDM0wXqXnEsu8F06jFb1+IB28Iyke6aJAIO3pFaozEyb9
 LjwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784547971; x=1785152771;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lbDUYv6SvxLDuwhS9L5Ru6LW03tqe3dok4lTiVGMOFg=;
 b=I22mZdXefkNhyF5+Ru93zIj+8pugYUCqKwP/nUqB516Rn6MTBAJWozefQOysfhbZok
 rqS+Znr0yJp1LxSXOM/6qIUL1O1DkFhYy9KSDs4VSzfugnQGmwGqiL8T7T6qZT3XLmgr
 dHMSdtaye5T5m5z24P9x/G9fuBg/CvVsEeip61aXtX68zGaQWbSdTJC83XsXbOedrO56
 saE6YF59578e1PKSlStYTxGGYHdVinchl+7yefsyWoELaFtpOS6P3ijEKTEfM9hdaEI8
 1GoF+rGet320ckkBAs1vsrF5Qplqw8Kz8t5wnoJ3Abjf9Eb7Bm15kZ80RVDNdaJ7fx/D
 6l7Q==
X-Gm-Message-State: AOJu0YzJdrSrQT5dqH1QYdlEDlDBn/53C+37bTECUgUxIn9noRZ3GeL6
 Rc73uZm2rxJsOdcFIsCinX6UJ7r8xlYQ+SzzpAkwpdSEYs7MVaFXiSayCSonGtHd
X-Gm-Gg: AfdE7cmrDeRYwhXztgIyGbWdnK16buAgHQe3m+04dVLxdhJab4O3Do8jw35QSAZn7nJ
 sGvF9Ufk0sPWyVN2Uwartb1HFO+QZIZK9mkhYCjW25jdgfdh5wQSil0kuKw59tUSussD37AVX81
 rKdYmNSTXwmuxUx2XdiVQv11zKZ4pnEd0JLmgE+dDRGyg0/5/SZuKGJh08fB3vAYHcJqsBIVzme
 xY4i2FMzIY4xmNFp3cs6Kb6AS6ms1VhN1uUM8XM89lvK2lmYYWWX5S7MRTW5Ybdbsp0543jEjba
 6rsszBca5+qqRWi4BToxry1qqJb9kgAiH0R2g2L+5OJQST+rMGnL7NkTmqVQ2PpxxPeyD7p+JGh
 MsGxIU6I680kvJmdgbh/xHeCCC0J2qfqOIe+BI3p3/2MnJkabn1fDG0Euo6Kz4VMOcLhwdTRffL
 zfpIjwfIBC1/0rk/+OM/JDJL/Pt/qfmXg7iA==
X-Received: by 2002:a05:6000:299b:20b0:47f:77dc:60c6 with SMTP id
 ffacd0b85a97d-47f77dc6260mr3299788f8f.1.1784547970908; 
 Mon, 20 Jul 2026 04:46:10 -0700 (PDT)
Received: from localhost.localdomain (free-mobile.vlq16.iliad.fr.
 [213.36.7.11]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f63ec7ea1sm30162360f8f.24.2026.07.20.04.46.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 04:46:10 -0700 (PDT)
Sender: Maxime Leroy <maxime.leroys@gmail.com>
From: Maxime Leroy <maxime@leroys.fr>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Thomas Monjalon <thomas@monjalon.net>,
 David Marchand <david.marchand@redhat.com>, Maxime Leroy <maxime@leroys.fr>
Subject: [PATCH] doc: drop recommendation against bool in structures
Date: Mon, 20 Jul 2026 13:46:02 +0200
Message-ID: <20260720114602.787429-1-maxime@leroys.fr>
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

The coding style advised against bool in structures, citing space and
type-size concerns inherited from the Linux kernel. That does not match
DPDK practice: bool is already used in over 1400 structure fields across
the tree, including core APIs such as rte_flow. Drop the note so the
style guide reflects actual usage.

Signed-off-by: Maxime Leroy <maxime@leroys.fr>
---
 doc/guides/contributing/coding_style.rst | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/doc/guides/contributing/coding_style.rst b/doc/guides/contributing/coding_style.rst
index 976a1e1de3..11de3bb39a 100644
--- a/doc/guides/contributing/coding_style.rst
+++ b/doc/guides/contributing/coding_style.rst
@@ -313,15 +313,6 @@ Structure Declarations
 * Use of the structures should be by separate variable declarations and those declarations must be extern if they are declared in a header file.
 * Externally visible structure definitions should have the structure name prefixed by ``rte_`` to avoid namespace collisions.
 
-.. note::
-
-    Avoid using ``bool`` in structures because it wastes space and
-    the type size is unclear. A preferred use of
-    ``bool`` is mainly as a return type from functions that return true/false,
-    and maybe local variable functions.
-
-    Ref: `LKML <https://lkml.org/lkml/2017/11/21/384>`_
-
 Queues
 ~~~~~~
 
-- 
2.43.0

