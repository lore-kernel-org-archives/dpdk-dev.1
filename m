Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1289BC5DF81
	for <dpdk-dev@archiver.kernel.org>; Mon, 24 Aug 2026 18:15:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E5EAA40270;
	Mon, 24 Aug 2026 20:14:59 +0200 (CEST)
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com
 [209.85.210.171])
 by mails.dpdk.org (Postfix) with ESMTP id 3B5FD400D6
 for <dev@dpdk.org>; Mon, 24 Aug 2026 20:14:58 +0200 (CEST)
Received: by mail-pf1-f171.google.com with SMTP id
 d2e1a72fcca58-84e27035206so1454820b3a.3
 for <dev@dpdk.org>; Mon, 24 Aug 2026 11:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1787595297;
 x=1788200097; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=rtc2UZZQ4BgXNaH4aLGZEOTnW5IHAvCGOl5ijI5Ee5g=;
 b=DF/MFxG0YINK2NStVxPGBL1BY6UENiEd+56RAmWwsTTMy83w4lmsyIbwvBaEAL5+Kc
 Q3FPwdBok2GYd62di9rkCOpZxKX8fg0DS3wZkNqZiC2Ei5wGW+WUC8Bg4xmPIXqgUS5i
 MXHe6yVnPwwhF6wZwnuJDfb8jT2dHCzVuXyGX9NcVUZIMpjyGxfag4dEKxE+pKNTwWqT
 NyJcZeynMrYy5yAPnbtBujgtC33o3WitxFYe+fWYx1MbCWkZpQmOk66i9U28hJKkGdk3
 nn44i0B5+6nqsHoPQGZkr0/tANohWSyipnAkf0wiRAWkcaXIXp83Fi2hpc/zMcWLo1Pp
 X8Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787595297; x=1788200097;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=rtc2UZZQ4BgXNaH4aLGZEOTnW5IHAvCGOl5ijI5Ee5g=;
 b=TOzkpDoVEZ/pz6IiabPCzK2TyQ1MF3Sy5foe1Q3WgSl64TXg+jhHgItbL61jlT3lzd
 nhLC7qKLvqLWi5yPPeR1cnMKunGHOGJ9DtPIDKoIWn8r6JyC4wwBTtSXFg50/+ahU3xj
 RUPkHdG34GgISMGnFMiiCUB67Y6nBFOAS2bJaliC8xg4QAQEfqzGRBvbTFbYyqJ8osvt
 58sOJCrmpGxmFpUf0ZlJ+EoSY62XNFcpmNSaK5FVvf9GE8eva+AWe9Gq1r3w97kLxP4c
 i0JCLNC+RMV562M0+zrZzOgbYhoxOZjf1BdRr89lBygx2elgpost7wY0MXvM1oOqv0dZ
 RF6A==
X-Gm-Message-State: AFuF++lgiGw22w35wH0vOeBw7un8cyB18H+4AseuLBkOkD4ion69LWsb
 QPFdZGzhVoUui4npOpA0p8M3azdSLVWer9lgk2oxmmGEC22GHRovVyARzG44373kkH8=
X-Gm-Gg: AR+sD13wA0ukcZpxoZTVU9NhOQnrgLeX9AMeUBIfjXLe1VlgQhJg5Z08EUk+rwFvE/Z
 XIJJItN2Aylsv8PwMNbXUjUIhlscjms/PUCiHVboGL36hKA5n3tCtlEcRGzjdVhZ8VqPAq4mF4c
 9WLll9vdwJQpyyVReVvkVoSIMLiIrdnNf/YCs2ME3kmxQSp3WJ8TSyro+/ihG/5i6eSfWjuUj6t
 3l1fl4zh2+ka4t/Gx4S2TxniboaBltNDVUXbLInuTwcd3/YdwDJcSI0gJk9+j0L6+sbbIkdvjq0
 2VG7FuTEwVWWiqA9bX13TyGz0UP7yFPBFX08dQTYTkd1ePFyHtKASupXiEqRqTp6tP5MhCHicuG
 a4AeNpeNH7XFBFX752R0BI8I4iMJR2JXC1DApQMZZDXWAzA84qfYTKMXLeoZHGHdggB2Z4+NJHS
 FXcAyTplrnxIgd6Cowxk5FAIda24M87iAIcdZ7BkgIPVoK8V6YcgyZRK9VQo4QQeQ4cdjvIvfB1
 8/+6A4LkDi1oNXMClVrvC3hbQAYjw==
X-Received: by 2002:a05:6a00:2406:b0:848:4754:28e5 with SMTP id
 d2e1a72fcca58-851fa065680mr44306446b3a.16.1787595297148; 
 Mon, 24 Aug 2026 11:14:57 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc199e72326sm1315275a12.32.2026.08.24.11.14.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 11:14:56 -0700 (PDT)
Date: Mon, 24 Aug 2026 11:14:48 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Gagandeep Singh <g.singh@nxp.com>
Cc: dev@dpdk.org, hemant.agrawal@nxp.com
Subject: Re: [PATCH v12 00/15] et/enetc: add new features for ENETC4 on i.MX95
Message-ID: <20260824111448.58a8a3ac@phoenix.local>
In-Reply-To: <20260821055643.1359277-1-g.singh@nxp.com>
References: <20260819053415.645865-1-g.singh@nxp.com>
 <20260821055643.1359277-1-g.singh@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Fri, 21 Aug 2026 11:26:28 +0530
Gagandeep Singh <g.singh@nxp.com> wrote:

> V12-Changes:
>  - Fixed documentation for:
>    - missing double quotes for enetc4_txq_prior
>    - In accurate comment related to secondary process burst functions.
>    - Added a note related to LRO and its BD size chosen.
>  - Fixed secondary process burst functions selection.
>  - Removed "Unicast MAC filter" from vf, but comment regarding "RSS
>    hash" is false positive as or RSS hash, the only mandatory
>    requirement is `[provides] rte_eth_dev_info: flow_type_rss_offloads
>    , which the VF sets in enetc4_vf_dev_infos_get
>    (`dev_info->flow_type_rss_offloads = ENETC_RSS_OFFLOAD_ALL`).
>  - Fixed lro and scattered_rx configuration by enabling only after
>    rsc_enable branch.

Applied to next-net
