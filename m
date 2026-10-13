Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 051D3CC6B0E
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Oct 2026 16:55:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0866A40272;
	Tue, 13 Oct 2026 18:55:59 +0200 (CEST)
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com
 [209.85.216.50]) by mails.dpdk.org (Postfix) with ESMTP id 10C4640269
 for <dev@dpdk.org>; Tue, 13 Oct 2026 18:55:57 +0200 (CEST)
Received: by mail-pj1-f50.google.com with SMTP id
 98e67ed59e1d1-3ab8309dcbaso2334548a91.1
 for <dev@dpdk.org>; Tue, 13 Oct 2026 09:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1791910557;
 x=1792515357; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ScX7d1za9E73YH9epivnL7iNW7vCKibiO2qdiycs4GE=;
 b=YHM6GdhBRuYoxYO/fVzk5wMpMsGdFCxA3LybaeaHWePTC9M5AN+hcj0Czu5srCH3hN
 FUrh2YDmKMUEzA0mjXSCQLxdDydSnUPkBj7rLIHbZR17l9USt7q/LRaAOS64pq2ogctE
 spMD2AZPPeYLiJ0gopwDyGETZkbFkIhU7xeLyyxhxx4JA0qG516uaxd6ifaeDAxxkrqi
 2kurIc2yWVOp1xC+9LQsukr7kJ688/znAuJs5xMXNfVvMa3hmFeWxV9U3yw4LFllQ2b0
 9FUC5OWBnRtBe1+e57x+KKxMdpodmka7VsDIOJvimyDSbzwJWQOHM8p1T7aPoHmmwW3K
 BU/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791910557; x=1792515357;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ScX7d1za9E73YH9epivnL7iNW7vCKibiO2qdiycs4GE=;
 b=uV4PH/btYFVaV76FtsrbCEAuChXwNdpOGOjeMGpWPVnbSaiPbgT4kbYgmhYfaDEdle
 UH9kojnymQoYAkzjgXEUcR71hc8hhreuiaQxKktxreMAII3h3Q1dTVfFWMNtJNL66gxX
 RRnFQGLQOKfRCNYmpRgNYV5UUzZ6MIJDtc7pltn8NCoUaqxXqaif492UuxUO2XRc2M02
 XfRlRFf0+KCLhmLckVzXyrvg6xDsfLbr7DyK3YxOnCxN9/ouJHAv/fOx+hbuevCiGkho
 duObXJWLWzj0OoqQmvhQ+SWsbBhK/y3nbPbyBmYIhJT/KV0pQ3itpqGPsktHZtaPetOg
 yxlw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwsIZ2elKoVl/aa9dwZSEskgBI1MbUL42FppO2JcPEG+cnFOE8uf9CXgcF1kfYd+C4he4c=@dpdk.org
X-Gm-Message-State: AFq9FYKYttfZY5uPiYA4NrY4jtxQZ4WAiGvfVwzdrq5f1TlOPjvEC7wn
 WNxLYbo2h/Bysd95+RTiLCfNGuYp/fNDOv8BIY6QzASpSSCEMy6ze8S75NwXW+Vsum8=
X-Gm-Gg: AYBFou1C3DjlqEU9XhkT3JahcgFVrEGWPyz3iAPXAkxqsXWzvahkcmBu6aNlMUuHBUQ
 WWQpkdKCJChgNSoNqg85vUwMZHl09wiDjcxi/TMXsXFTUtMuMmxMHrz+uicWEnUnjY/7fGNnfSD
 xD4NRF7jKcx1pZkPVYYTpW7rDK/OeiakWMsn+Oy/9t3To8EuZwZcLwwnF5X9HMsdmGF7lTttbI6
 Y/g5XXC4wJGJZtLb9oChB5/Eux1elCr+WYoPwfk4A1amHYqNPr1GofFUsNqYIfYNPHjJNp1PaVg
 7k7JXgX26bLD5ahMGBx54uwAYMLjZzkFgaNSUr5PwauRsTRlkYhFkcFh0s4gbaCBIRpGroC4bAn
 WviAjLph59Ax5hPDtXCwEs58QWsmnpEjvsFax3q/hPN8VbwKmxi1TC3GZyLkeCVbgDmlAyGeb0P
 o052NJGXur3vM21OH+80WVJpIn9pnvEDGgySZihOHYLShV5joYuawWbrRfEPvRDV48xsacsl+zZ
 OnVlrfjQzjJRwwtgOW0sM1FpIZ0NSn4ae6tWr6A
X-Received: by 2002:a17:90b:1d50:b0:3ab:4e4:e97a with SMTP id
 98e67ed59e1d1-3ab3ab227d9mr7469994a91.26.1791910556834; 
 Tue, 13 Oct 2026 09:55:56 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ac5f04e324sm569126a91.2.2026.10.13.09.55.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 09:55:56 -0700 (PDT)
Date: Tue, 13 Oct 2026 09:55:54 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Marat Khalili <qm2k21@gmail.com>
Cc: Konstantin Ananyev <konstantin.ananyev@huawei.com>, dev@dpdk.org
Subject: Re: [PATCH v2 9/9] bpf: add callback flag to skip multi-thread check
Message-ID: <20261013095554.64daff10@phoenix.local>
In-Reply-To: <20261012210917.161343-10-qm2k21@gmail.com>
References: <20261011182158.124246-1-qm2k21@gmail.com>
 <20261012210917.161343-1-qm2k21@gmail.com>
 <20261012210917.161343-10-qm2k21@gmail.com>
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

On Mon, 12 Oct 2026 21:09:16 +0000
Marat Khalili <qm2k21@gmail.com> wrote:

> Add RTE_BPF_ETH_F_SKIP_MT_CHECK flag allowing callers to bypass the
> suitability check when installing BPF packet callbacks.
> 
> This allows overriding rejections in cases where the port or queue is
> configured with multi-thread capabilities (such as MT_LOCKFREE),
> but the application guarantees that only one dataplane thread
> accesses the queue at a time.
> 
> Update the unit test to verify that callback installation succeeds
> when this flag is specified, and add a release note documenting the
> restriction and the override flag.
> 
> Signed-off-by: Marat Khalili <qm2k21@gmail.com>
> ---

No, this just adds more ways for things to go wrong and get abused.
Application should just not turn on lockfree.
