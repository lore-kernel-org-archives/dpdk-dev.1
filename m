Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10806ECD9BF
	for <dpdk-dev@archiver.kernel.org>; Fri,  6 Feb 2026 04:45:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1040D402B6;
	Fri,  6 Feb 2026 05:45:36 +0100 (CET)
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com
 [209.85.221.172])
 by mails.dpdk.org (Postfix) with ESMTP id 8B6C640293
 for <dev@dpdk.org>; Fri,  6 Feb 2026 05:45:34 +0100 (CET)
Received: by mail-vk1-f172.google.com with SMTP id
 71dfb90a1353d-5637886c92aso100248e0c.0
 for <dev@dpdk.org>; Thu, 05 Feb 2026 20:45:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770353134; cv=none;
 d=google.com; s=arc-20240605;
 b=AbB0YX2YTEeFjHlCDaakAIGSuTiH2+SCHp991SOLZ/VE3R/DJ6hgIEW2qP6ZA3LOY2
 TrWvHImY79fe1BUsn3whvPgAzxkLuteM1jHjX3if4na9alGgEp7EgV2sO6/Co2fLywGT
 AH3NUPnltSssEJGeMn+qDHpqfbRGHBXyMdI6eT1GAxVxkymSNyJVsJISCAf4Q2nnfjIO
 UOwL2jHjXNkU24VadbvWFTSX2v3jdQ0+tNgqcHv4pn76NJl7dGWL/ID79QhyWhEFsx0p
 B+1688fiZK31VUKwav61BmX5IyIV9PeLyvmKSgY08PtiQJhLTJKPv29njkrgmv4dDQOH
 AENA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=nw1x3abL3Shl9VBVovxcafJZIXyJF+bulNN6KL9lmWc=;
 fh=t33Egyn4DAOwVRnwraldPtDjoBFAjogf3LzpsEMwxHQ=;
 b=Ms8kyk8NiR3GoqL2rxOqyO/sSKsU4Qxtie5L1NgmazKoA8ds1wYdrfbPcZZv2eXcRE
 trsuQnfqJXO9FPHvgcZeWgatKcZNuaWCfBf6soCtgTouBrAEv6c7k8eBwlA5Cpr9K8NZ
 Bx38SgbOvDPGckTZAK9dpMqYY/cVTzwLRta4xV/5xKZEtbtGEX9ymaMlle+kOsj9KTVL
 S1PISP1k7O7rQeNXI3nGWcqCKNp9COvlV75LJHb8TCA0ep+JMJeXETOGcXhLoMqcoeFu
 W+SeetIW+Syxc4Z6kImrRI2U3oXegRLmQQR0IeS39owwhPZ/K12cFlT1Kq/60xe31fLw
 pRAg==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770353134; x=1770957934; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=nw1x3abL3Shl9VBVovxcafJZIXyJF+bulNN6KL9lmWc=;
 b=X/wZ9mUA/XMeXs6NKAwmQXFmEfpL7QWY5Vmyx0ZM5J2nKTT01pNt8gTBV32hx+B/fj
 bNb0UJyDyN6Lk2TNnhoojCIo1SZ2cuSgQ2URHU0nmkt/KFPIY/igp6PA87CGuMwBX5WY
 HEktFED3zAAjONaVc77m3HyMOeJH5pB2tqqTSyaRzw3JU+q8WP8inZXvKvpQxIIw/sNM
 xBxz+feLAAXCNOCivOlFHvZlnJVFeb72z2CXex5uOrEu0g8dAIikipaCVaEuQoM5qcIU
 PuzCuAeeLfXhDFYu/XLtXbehYZlpNt9K7+VBIe9qoEhS3kDPXGqAcja6EVxDpey9TLsO
 hUEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770353134; x=1770957934;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nw1x3abL3Shl9VBVovxcafJZIXyJF+bulNN6KL9lmWc=;
 b=XEjW4E8BRCsLKCO7uzmVNylv5Id2MDbL9YMHEngX/0j7ogGL6ikzng9qrNIbvEQ1l5
 1pJs/yDtwBglzygexXA7AMSIXJTWd+iNySQBWgio2EyKvS24w46xSgd7pruE8XiufAIB
 wraa4+OJ9dD7A3j1iktipsk5woE/lk4JIe645UA4k4Ocktx8lOqDeFNhIRnMBksa8g6y
 Ez1eJzZiznlDCmGkAwBcVD9nBSbJ1XlSnGqlV/Nh58GRgcMlUXm5AXszLjge+ohHcX9o
 tRmZyvm+Y2lgHkuORD7pmJhNtaFl+sPDYgWR4NJqXcFfucWKJ1QApICz1F48bcSnVJYg
 AI3w==
X-Gm-Message-State: AOJu0YxS98gEgqjgiywNdoGdp/JAJ2HdKw5sihZuU0Y1wYU0B2DiuwPc
 ryv6i/TGtDm+hOF3xuIrd1T+oZznQDRtDpxB4dsQEfpWppYVAU2v/qS4L6/oOv814ygxelb5OBp
 8D8z3nIljEUCnj0HngxDCRcHYPXo87N77nor6
X-Gm-Gg: AZuq6aKMil98kwXNfZifezsIZdvLJpkXYS3aSQSHIAdDUs6ZhlJFaWFXjJlQgL3An12
 8DYEL++FZDtQ5b/jw4bR0KMvOtNAReTOkWu+6oK/izrbsKMDNWXlt0CvdcaD22pdLxOZVbVOXmR
 97qmx8NvyzyFsgLmLTon54LgD4RD9Hz9X2E2uuPx/uph2S9ZNPxnrhjXywx2p5J9COoDbDOwMDc
 sxTlLKAE5q2vY5jgBQAYxh9MHYAbpWZqFE/JrZtRgvuypdfPduBahxAeuzx3L2PMYV9Qgw=
X-Received: by 2002:a05:6122:f18:b0:559:5ef5:b196 with SMTP id
 71dfb90a1353d-56705fcf6e7mr493388e0c.13.1770353133703; Thu, 05 Feb 2026
 20:45:33 -0800 (PST)
MIME-Version: 1.0
References: <20260203070740.62305-1-scott.k.mitch1@gmail.com>
 <20260206011141.2377-1-scott.k.mitch1@gmail.com>
 <20260205174901.462eddb1@phoenix.local>
In-Reply-To: <20260205174901.462eddb1@phoenix.local>
From: Scott Mitchell <scott.k.mitch1@gmail.com>
Date: Thu, 5 Feb 2026 20:45:22 -0800
X-Gm-Features: AZwV_Qi9HTcNtbNCcAnP75utyliw4iCV_FxcZBnVakKLyo96kDcxIbEmdE5KeMg
Message-ID: <CAFn2buBvDjxTwKjq03tpWL0wG896sjA4qggjw_YD4xk6WL_zBA@mail.gmail.com>
Subject: Re: [PATCH v6 0/4] af_packet correctness, performance, cksum
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org
Content-Type: text/plain; charset="UTF-8"
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

> Why are the header structures marked packed, that is bogus, BSD and Linux don't do it.
> Windows probably does but Windows code seems to love packed even when it is not necessary.

Agreed. I'm not sure why rte_udp_hdr and rte_tcp_hdr are marked as packed.

> This is failing compile on FreeBsd

I forgot to carry the "Depends-on: patch-160679 ("eal: add
__rte_may_alias and __rte_aligned to unaligned typedefs")"
(https://patches.dpdk.org/project/dpdk/patch/20260202044841.90945-2-scott.k.mitch1@gmail.com/)
forward from previous patches. I also see this failure locally with
GCC without the Depends-on patch applied. I expect it will resolve on
FreeBsd once this patch is applied and I can rebase this patch.
