Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B13DECD8CB2
	for <dpdk-dev@archiver.kernel.org>; Wed, 10 Jun 2026 13:46:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A51AD40270;
	Wed, 10 Jun 2026 15:46:41 +0200 (CEST)
Received: from fhigh-a7-smtp.messagingengine.com
 (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
 by mails.dpdk.org (Postfix) with ESMTP id CC1DA4026D
 for <dev@dpdk.org>; Wed, 10 Jun 2026 15:46:40 +0200 (CEST)
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 3042F140012C;
 Wed, 10 Jun 2026 09:46:40 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-02.internal (MEProxy); Wed, 10 Jun 2026 09:46:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1781099200;
 x=1781185600; bh=LPEgJam4wocaOR3B7zAGhoFEWTgqn6WwRzGEG1TN/bI=; b=
 hznwL+UXnNW8SGwCsNrWIVM7fVy1g021ZyCr8Hgo3DlsTvdmJ21xkMp4tRTmXZsD
 kevSWh/R6ZJL5ATQboyQ/QeraeqFGoDIVrqam/gmO83PKFYPumsHc7a2T9ivlzIH
 2bJ53A0vSmgnxh6lxXT18kLt86btnUEQnFtO3Cs5cijiiJa5hxZGM0ft/G5NxmAo
 xn5jL4hvbdyT2ZeC1xMEduuRKvDnE5rZ/cUwC6JJMUKr7hpuVKoJ3goZZbEr64uL
 SHazSUBv+Y2gcx3of8J6O/LPyndKJIGyxGMBj6qKvMyJNjjjpcnJfKglBXTn1K88
 J2VEjVTVwdVXkNS2OaIYRg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781099200; x=
 1781185600; bh=LPEgJam4wocaOR3B7zAGhoFEWTgqn6WwRzGEG1TN/bI=; b=Y
 dYnnJTxL0SmA/MEDK44+Zx5w0qc+/IcI81OVNMDkhcLJfYH5Rwk94NkvawB1wsCE
 QVlgPoFfHgEsbkOco4BZwztBxJTkmphmw/eO28o/Sy6exlVvQvqTrHXaO8a5ZUtj
 h2XT0anjgQBoqw2iTNBD0bc79XHxv2Y3UMDY5kBKigq9VTE1P3YP0GR0GGls/hRA
 CDcWUr+pIWng6DJBvT9F7GmR0UcKt7H7bwWmr8Ipz9hMsVTiBSo16IAK+EQhG+aa
 H6TDQXMaskONW9uaapGtYFOl1E27maadjzvc55CRMT7TdU5mLPM65WXeeICzdyES
 +xYhuerCXyd5CmNsB6UHQ==
X-ME-Sender: <xms:v2opah4B4Ye6oLdnFC5xEQ5wDQ68rz2AWmWAMyu6Gdy6h9YNX_a-tw>
 <xme:v2opajNZDqsszcuDhBuC6gUvsTSAXRFQCqFPI9ozUFBcSiFBQwG4FwUQL1iOHobFZ
 xleBehpIR_0bx4C4JGaa6IdyChimqbSPBpYHob3eSakNjqaTEVhXw>
X-ME-Received: <xmr:v2opanl_2AnRC6iAf1wvpJbLvdZoobM2r1KbnSFAq_gQk2SRLOv483JFMc8dSBjk7N4OsRLFjYEH5-jmboHp8qeuAQ>
X-ME-Proxy-Cause: dmFkZTFOCB/UCbXA6qC8oQFWHD6YYH7CK/4uYCjItaubXNywd6TO/MxVU1+PHflObKQQF1
 xdDnOWnwRa7xNRr57RO431OYtFg3bUgYE360JNuBhqK6Q8NKyhkTsLgLPFxtrd6vMYZw5V
 Wqi/mbN2slMsN4cV3hmmCZszMaYmHSCSp5wP661iU1Th/INFrtRB8nnuQd+ovdb+nRmTQA
 4U4bRKbwp9d7z65iTGwMXbjkSp+EFyQYpmJJ4v5zgwwNTMNdndoBT9lgDknrubINJeN0Iy
 5NZx3GBnvcD0Jtq4IEkiAEFOJ3XmM+RNFn6jxRsaLvjJ7oGTUTwNohtRLus+VzLVU32bgM
 1DXxAzIK0AWfYXorVhwojKXd8CjgEZIvmErNe8cHnuo9/jWEwa85/rWWVoxarfMHr4RPi6
 VhG4lKO83xIMGuWR0tod8NiVTiI/G8gb8gK4QPxPC5bZ2H9Pe8dyWIug5803MHde12qLU9
 OX2sv9XSGyB7pp+TlbYZkAnJ+16q33m8D0ZBBd02aBvgMZldZQnRv3QAGYjcx2aau51Qd0
 JuvRcmIKm+fZtsWZTswvHcsgQwTIE7fMjCMIWHfVvQKO5Fq5oXx/3Jb+pY4CveHLSgauDh
 qLYNWCIGv/Se90jaoyVLGgMHt4QXNiUK4FZcEgJ+1/JhKkHsKQLIrmROqCGg
X-ME-Proxy: <xmx:v2opaiT0EtefXZyw37qHMMscTfretTKqbpvKTU1NQjsrQlTSaIV45w>
 <xmx:v2oparBTGBhJmSikrV8cCyYtK-5AmkZiXYhszvymTHjXrW7CxTIBTA>
 <xmx:v2opapRFlsy1LttE4iOu1SlCfjQ2i5g2idAaXhAWff3GdeVui93Xow>
 <xmx:v2opapoTUAVHCW4GcjY_bUOtSN58LauS2RdEqvgPNueb7kVBsmy0xA>
 <xmx:wGopapnSx0cD5298fhT0VyIqFOKTTqUNjE09g7lGknOJsTkknrDzfKfw>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Jun 2026 09:46:39 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, vladimir.medvedkin@intel.com
Subject: Re: [PATCH v6 0/7] Cuckoo hash optimization for small key sizes
Date: Wed, 10 Jun 2026 15:46:37 +0200
Message-ID: <-xO4_p-wQBOKvUB4G2CtqA@monjalon.net>
In-Reply-To: <20260329232409.205940-1-stephen@networkplumber.org>
References: <20250818233102.180207-1-stephen@networkplumber.org>
 <20260329232409.205940-1-stephen@networkplumber.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
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

> Stephen Hemminger (7):
>   hash: move table of hash compare functions out of header
>   hash: use static_assert
>   hash: remove spurious warnings in CRC32 init
>   hash: simplify key comparison across architectures
>   hash: add support for common small key sizes
>   app/test: convert hash test to use test suite runner
>   test/hash: add test for key compare functions

That's a pity we didn't have more reviews.

Applied, thanks.


