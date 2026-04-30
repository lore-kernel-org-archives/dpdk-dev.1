Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60468CD13D3
	for <dpdk-dev@archiver.kernel.org>; Thu, 30 Apr 2026 17:22:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8DAD040395;
	Thu, 30 Apr 2026 19:22:55 +0200 (CEST)
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
 by mails.dpdk.org (Postfix) with ESMTP id 051264021F
 for <dev@dpdk.org>; Thu, 30 Apr 2026 19:22:54 +0200 (CEST)
Received: by mail-dl1-f47.google.com with SMTP id
 a92af1059eb24-12dbd0f7ecaso2606265c88.0
 for <dev@dpdk.org>; Thu, 30 Apr 2026 10:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1777569773;
 x=1778174573; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:to:from:date:from:to:cc:subject:date:message-id
 :reply-to; bh=qb7ApX+ULciiqQCyAC7iQca6lC853MF9CviVxpL6LVM=;
 b=IQLXLKfSkvWVIFo5dPsJ9MmHMZ6i9sRAc33Itc/hMWs1Bth9eK5k3OmCETZJ9t2gWc
 tg3V/vS3UFq9aBM33NbuXuMGsjOrPDWjUHUgGB7LPlBtkB7hskxQ9lC2aCQjZ11Sy0ZT
 ykyzAIm0w+ZNkpdUByXxnumGuKkkd1giLv6J5177wV66+NFnBZcMDxaQjJORyhdXmOs7
 hAd2eUmHqV6jPlSOcGg/ztUoV5JZE80o+EHB6q0ka8mTvUeOK2cOFBlDW9lOGe9Zq0JF
 DUqx28w7BQjhELu5Q82yWf2mrVzBrHAKbmcPyyAVNO7/vq6AQU+cl70+se0JtSJ3U3od
 C2BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777569773; x=1778174573;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:to:from:date:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=qb7ApX+ULciiqQCyAC7iQca6lC853MF9CviVxpL6LVM=;
 b=UigQ/Lnln+Byunk/RHWtPY/L+bUQYy/i5Y7W6w2dm6CE+f49MeTqaLs1Esuw3T4gu7
 a38S1c+0SH96UVoBm3ctpVS1EALNHZnb4UOr40eB7ompBQ++Ngq7Q74AQDI1ArukjrPz
 GRFcWCcSgP24ADO1C1VtVxQBUv74dkPh12D51siReccezPJQwWkg0pXolRmtZqF45wOJ
 Wc2XO8khwsn4nCudOMtcgcV34Frmqp1TwR0PetIMIpVNJQJLEddl5wmZwTEUoVk3tllq
 SKH20k9cPYvS0M9/xQumGh47Ih59xU7T7Z//LLjR82Xu5c1FSvna9QjrJXv9mU1l/LwO
 QM7g==
X-Gm-Message-State: AOJu0YzDVODhaMEACp9UmLD7TYgHsJLFYss3omKnRFqStpTB5k6oVoM/
 oaCHBshRmZOvoEQKmQ59b22JhhngaWXuAfCzpKrEdGrGZt7HHh3LZh0l1lyOmPnbf6eFxpoKlRi
 zCwWu
X-Gm-Gg: AeBDiet3okkmkmq2R4iH7ImG8EC4RMzsxWmoTT5UMboxsIPm0jFOdMtMsnccpAwxtU2
 NCFGxfxWMKRkjyR+sj7TAWJjfb6pFBRZIwI6PpLTXI2qXPanjzdFsa0liboMMpz9J34oxQwUosI
 pYtulUbrm0AVZ3K3WJzGeiQPk4I3r7KdHnGqi9hTaioHGWcP6ZoUx6b5CguQSvv6CEXNHaHc0m8
 MdpL4JHDrFIVmonCWEX/jcPVnLr++WNTaul2IZkY8HaqrtVBF1UdkvTl2rFxG2QTD+TVUf79oIJ
 Bwa/gkODp1jqy174KqsHqBqrTJcC2Lm9jv1eyuazN1VDtTZnZNy0eo360vBWnmbYm4wnx7Ai0xS
 IW3HyMukE8QWPXHMUN1YxtdDn9/JvUYZmbHzNB5JN92ZvobB/5ROfq46QxzrmyttQeyqImRhB3i
 z6NIqqLsPBK2t1O5F2F6uH28NosyXlZ7vPw32fOyMAsQHxZoalrGFOuCbN
X-Received: by 2002:a05:7022:fd09:b0:128:d714:3ca6 with SMTP id
 a92af1059eb24-12deac418f7mr2065556c88.12.1777569772973; 
 Thu, 30 Apr 2026 10:22:52 -0700 (PDT)
Received: from phoenix.local ([104.202.41.210])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12de3216e81sm11156796c88.4.2026.04.30.10.22.52
 for <dev@dpdk.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2026 10:22:52 -0700 (PDT)
Date: Thu, 30 Apr 2026 10:22:49 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Subject: Re: [PATCH v6 0/3] af_packet: cleanup and add test
Message-ID: <20260430102249.369832b0@phoenix.local>
In-Reply-To: <20260429182055.398105-1-stephen@networkplumber.org>
References: <20260413230018.515837-1-stephen@networkplumber.org>
 <20260429182055.398105-1-stephen@networkplumber.org>
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

On Wed, 29 Apr 2026 11:18:58 -0700
Stephen Hemminger <stephen@networkplumber.org> wrote:

> A couple of small patches for the af_packet PMD.
> Fix indentation and add a basic test.
> 
> Stephen Hemminger (2):
>   net/af_packet: fix indentation
>   test: add test for af_packet
> 
> v6 - add myself as maintainer
> 
> v5 - end test after 10 packets or timeout
> 
> v4 - fix test to use stdatomic correctly
> 
> Stephen Hemminger (3):
>   maintainers: nominate myself for af_packet
>   net/af_packet: fix indentation
>   test: add test for af_packet
> 
>  MAINTAINERS                               |    3 +-
>  app/test/meson.build                      |    1 +
>  app/test/test_pmd_af_packet.c             | 1123 +++++++++++++++++++++
>  drivers/net/af_packet/rte_eth_af_packet.c |   64 +-
>  4 files changed, 1158 insertions(+), 33 deletions(-)
>  create mode 100644 app/test/test_pmd_af_packet.c
> 

Applied to next-net 
