Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7495DC5DF9C
	for <dpdk-dev@archiver.kernel.org>; Mon, 24 Aug 2026 17:02:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8A33340270;
	Mon, 24 Aug 2026 19:02:05 +0200 (CEST)
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com
 [209.85.210.178])
 by mails.dpdk.org (Postfix) with ESMTP id B47EF400D6
 for <dev@dpdk.org>; Mon, 24 Aug 2026 19:02:03 +0200 (CEST)
Received: by mail-pf1-f178.google.com with SMTP id
 d2e1a72fcca58-84847482584so106625b3a.0
 for <dev@dpdk.org>; Mon, 24 Aug 2026 10:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1787590923;
 x=1788195723; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=D3R5LCX4Np0K2b2+2UumQsU6Jyu/SXtT5cLokw4vqKo=;
 b=pMoHtalhAo3E+2DqhrSVlpQSMO58ca//16BtS3BTE1Fc9em03BoKyqmlmgTVsqyx/m
 6r4jRJgKga5fvO1oH4EAaKfWLCQsM3hG9OGG3wuzLJDCF2AJi08Dm2TgCP8vJYLug1/D
 9YDRDCXwfznSrq/ht8MTZIkZg+Y1V15LgxN13jeN4XUR3+C0B2Iyz9HGOQ6V3T+NS7LV
 YqoiOfU6TNuMxpoMpoz2Z4cJtjpef82S4VfvZaUdcAiUqn6BQ8k9r3/Cj1GwmDlR8FpR
 sDDeLdI5diKQ70zMXyNbRsNvnNV9PZ6h9YNCRQZdidllZ8cbhT+fA0x9Q4gef3q1eOv3
 qIZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787590923; x=1788195723;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=D3R5LCX4Np0K2b2+2UumQsU6Jyu/SXtT5cLokw4vqKo=;
 b=hnnnL5T1J6e12ANT8AaYO6utSmgeZLEBFaDGf9YuTSQrE9WAt+HX0l3Hz+F2er1ErD
 QTquyCQH2J9H3yTu6Fx+lP4/SOdeShT5nNVM3jTZ4wPCAGUWmcI6G3J0xZjxixgUYCWv
 1rqUvVmRX9RtmW1HqUn/Dlj9Mkw8BHkki1nhuzvcYBjvuieAnoOM8Ocn4e5G0COuNOfJ
 HUgJTYX3BEB7kg4oaONeLCU0YtZqvvkel6ScHm1MaNYVqynjHV+9xozA2n2eyWnycxEK
 /xQFNkvNrDVuYpaf2RQgAWvnz9W/FywKFqNXMNbclwNkK8TrMUQT66SJomnqwCKeLsuX
 h5gw==
X-Gm-Message-State: AFuF++lNNQeR6yYfq9jpvurF/DuhO6Tb+2nNeNnmcPxINvdXcMmuSFJE
 p2EA75LMBsZ3yvhZfbYTeXQ07d8DiZR1FaouQBlEN/shQJqH+/jkqJq9CFsc1JZm1qY=
X-Gm-Gg: AR+sD10DQ+QPSxSYxWwJZ5bQLdnbAF4FMMzT1boA20919tonSAj3folyx0ZIgIyxjnO
 2r26yXkSmAIXnYVyBPmF/dfC4O/xUudpxtVfv4wAsej662nRfCR6LsCdmvr6fSh++37ulY4/D3I
 F0MGCu8N2bPnKKWskpWJZFnTfTIQ+LSvzrxu4PaXaPA+0zD0uR/glHxLG7REKt52K27XVx0UJtn
 dRVQRbap+gO7gRlFLjthgtkeCl4XC8SHjolhzPfUthQqO5w2BeLnz11IMNpeYujxbd6KCDNkXWJ
 F62svj/ptdJ6oSYwX+Vo9PbJDld7VFbwg+6xwIPAIneI4GET1IbIetKMNZun1xS3h7AHPX/fOc0
 R36ZXrlNJTyr0be8FrHvr54Vfm3Rde37QgoY7CbhaPch4djmZeskHxwa3b3CenHhtsrMGHqanr8
 0BUXk779ANnSgNF/WEouMBS5v2REEA+LdJ8Dh6cFaL7YETlcd/fU2Ml1M8STHkdkpkP07ZVo9fH
 6zrM5Uromtx/kbdXozZ3JuUBOesfVWgroU=
X-Received: by 2002:a05:6a00:1803:b0:842:63f5:d097 with SMTP id
 d2e1a72fcca58-8523ba7ad3emr726001b3a.3.1787590922438; 
 Mon, 24 Aug 2026 10:02:02 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8520f17660esm2194481b3a.60.2026.08.24.10.01.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 10:02:02 -0700 (PDT)
Date: Mon, 24 Aug 2026 10:01:51 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org, rjarry@redhat.com, cfontain@redhat.com
Subject: Re: [PATCH v6 0/3] Remove limitations coming from legacy VMDq
Message-ID: <20260824100151.79c4dfb7@phoenix.local>
In-Reply-To: <20260824114207.312513-1-david.marchand@redhat.com>
References: <20260403091836.1073484-1-david.marchand@redhat.com>
 <20260824114207.312513-1-david.marchand@redhat.com>
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

On Mon, 24 Aug 2026 13:42:04 +0200
David Marchand <david.marchand@redhat.com> wrote:

> Since the commit 88ac4396ad29 ("ethdev: add VMDq support"),
> VMDq has been imposing a maximum number of mac addresses in the
> mac_addr_add/del API.
> 
> Nowadays, new Intel drivers do not support the feature and few other
> drivers implement this feature.
> 
> This series enforces that the driver announces VMDq pools before
> using VMDq related features, then remove the limit of number of
> mac addresses for others.
> 
> Next step could be to remove the VMDq pool notion from the generic API.
> However I have some concern about this, as changing the quite stable
> mac_addr_add/del API now seems a lot of noise for not much benefit.
> 

Applied to next-net
