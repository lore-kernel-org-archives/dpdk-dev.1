Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65928FD8FF4
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Feb 2026 19:23:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AE1FA4027F;
	Thu, 26 Feb 2026 20:23:08 +0100 (CET)
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com
 [209.85.219.41]) by mails.dpdk.org (Postfix) with ESMTP id 2CC8D400D6
 for <dev@dpdk.org>; Thu, 26 Feb 2026 20:23:07 +0100 (CET)
Received: by mail-qv1-f41.google.com with SMTP id
 6a1803df08f44-89549b2f538so20906826d6.2
 for <dev@dpdk.org>; Thu, 26 Feb 2026 11:23:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1772133786;
 x=1772738586; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nAclJk29pxolc/2h6Z76cGcGPifMw1vri1miOTolj8c=;
 b=uxPScaq7Kw8+deW36Pr1vtHh4sHT+4k+Ro2Jjn4ZPsSQzbtbUYdIdYM2+TC5E41MkK
 uLH3BRCb7ylrBhkcVoNFePSwUf1LGR0cpU3fDH6rJpdqTdbjNVC7FFxLaDw4Z76gO9az
 dAn2vW1tGtJX/mZFeoJtXZGlw1WDLD8PZJ1KtQ+c9gpz4LTT9DEhfneg3l/AMjFAlmmU
 dmObj7MI1CUAqdhsa8FxcT6YvayNLitQCvP7PZcKVzSUKUi9Da2zYeceztvAcEvg48uP
 WlzYSKRowqwVNUDZZPdfnGWNrUErjlXLxrKmlLb3naiXu/mzZabhw5qoVo6N+4ETl6n4
 ItPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772133786; x=1772738586;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nAclJk29pxolc/2h6Z76cGcGPifMw1vri1miOTolj8c=;
 b=XKjwew4bEKJrqo62/6H8xCFZUztGCHAsNw+tftsb8A5bSYTsuHXV70qmMDAcAsPXZy
 FkYsCjwbAXPUoLeUg5RqTQs2H3oc+LeVq4q3cIQ/RbsHKCB14hkNIoKTsHH8niN6E5We
 vEzDNNZneykd4vNyTRsKhMUH2LrLbISH6tRFtn4ZDXG0x6md2lek1eyNKL/EGcjhZtyJ
 uE+clPlcGPJzXgHuii5suVzmgFkkOyNyjGw/xfF+18qlwVqlYd77sGPi117FmtoDOlIc
 06pEZ3OGTG0P/n1UOxOb5nElvkTnqf6K9J2xWHd4I227w+j8nE31TXEg9TQRZPB81SSm
 Q2pA==
X-Gm-Message-State: AOJu0YxART45lEGqEHYJTY11KGJnVzQVKsg7Hq6xPNeDU1Ju50c4jb7b
 mNSMeWI/MlokTGHhDfLcIFSsCmtMG++d6EdJzBiYrnCAHto/3rp5PnIM3gmKPWbeiUg=
X-Gm-Gg: ATEYQzxCJ9XDKgaVq7qmycUL2WGpot6u5lKiMuLgIVWroaWYnibSO75q32wQbJJZX72
 KnWhOCXcwO3n8xyvPIMg+RqRvQTKYjzXif3LMbO6DmhzAcV6OPr3QIwjI+ph+Y8WSrFw0U5DRXo
 e4/QvyiSUbtqYpCGdJ0Ifo31EBUBuJWp40bSdtWG3hSf0rFxhgkJO3GfOJBiE9TMwjXL+Gq4zZK
 0WGkyzmWD6OEZEzasLrVibk4FkEpjcm9Edga1sWiQQdY0zZ94yF7UkCtCZ735SDqvLBkWew7HVY
 A191XHGWQPeK9GLCCdCG52RqYoMvBE/VmGjheAjfdGQiR0Dbg45y2FYlFFRX4ZA/T1GPR9BDBSh
 Jc06cZgOuy1qkxqFeQ85omnU+OkFYwBkp26pXpGUJyGTSmLCM9Af7I3tjM6s9OuGRQJ5T3hK4Yw
 rSveXH7C1ouPL4xpX/qDYUuFFz/R5QAl5e70wE2bIHSEar0m5f6iSj976vpkmQzrqi
X-Received: by 2002:ad4:596f:0:b0:894:6e2f:f963 with SMTP id
 6a1803df08f44-899d1e84d7fmr3375926d6.62.1772133786407; 
 Thu, 26 Feb 2026 11:23:06 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-899c715ae7asm25099236d6.6.2026.02.26.11.23.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Feb 2026 11:23:06 -0800 (PST)
Date: Thu, 26 Feb 2026 11:23:03 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Maxime Leroy <maxime@leroys.fr>
Cc: dev@dpdk.org, hemant.agrawal@nxp.com, david.marchand@redhat.com,
 stable@dpdk.org
Subject: Re: [PATCH v2 08/17] net/dpaa2: fix error packet dump crash and
 memory leak
Message-ID: <20260226112303.576de05c@phoenix.local>
In-Reply-To: <20260226143341.282188-9-maxime@leroys.fr>
References: <20260218160453.142311-1-maxime@leroys.fr>
 <20260226143341.282188-9-maxime@leroys.fr>
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

On Thu, 26 Feb 2026 15:33:32 +0100
Maxime Leroy <maxime@leroys.fr> wrote:

> Fix three bugs in dump_err_pkts():
> 
> 1. NULL pointer dereference: mbuf was checked for NULL but then
>    dereferenced unconditionally on the next line.
> 
> 2. Memory leak on multi-segment packets: the while loop walked
>    mbuf to NULL, so the subsequent rte_pktmbuf_free(mbuf) was a
>    no-op and the packet was never freed. Use a separate iterator
>    variable and free the original mbuf pointer.
> 
> 3. Segment index not reset between packets: variable i was
>    initialized once at function scope and never reset inside the
>    do/while loop, so hexdump titles had wrong segment numbers.
>    Make it local to the multi-segment block.
> 
> Not tested, found by code review.
> 
> Fixes: 8b49427e73 ("net/dpaa2: add Rx error queue support")
> Cc: stable@dpdk.org

You need to use longer (12 character) SHAs on Fixes tags now.
Same problem in patch 14
