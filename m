Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F211D3EE97
	for <dpdk-dev@archiver.kernel.org>; Thu, 22 Jan 2026 17:08:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 12C7E40274;
	Thu, 22 Jan 2026 18:08:26 +0100 (CET)
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com
 [209.85.128.176])
 by mails.dpdk.org (Postfix) with ESMTP id BD98E4026F
 for <dev@dpdk.org>; Thu, 22 Jan 2026 18:08:24 +0100 (CET)
Received: by mail-yw1-f176.google.com with SMTP id
 00721157ae682-790ac42fd00so12800597b3.3
 for <dev@dpdk.org>; Thu, 22 Jan 2026 09:08:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769101704; cv=none;
 d=google.com; s=arc-20240605;
 b=KoIVZY98K7Bom+0xFvL0B07Jz+d0FtFRQ1wi1zRtOzlylkk9rIKqHpULpFb+cQya5v
 TAgRFu/aNbQ03OENGgTyP4EeLrOrrvJOYsYwuh2b6LW+M5WrcVwc4+l5s+BV9Ok/l75+
 k6BN5JL58msbFLDNllbkck0d6PQ92Azlj0tVahqs2VT5VJ6+vXoW53ycw2eNhQJ3MW0t
 Oywi/v1qyvGWcAe8+QoE/OcrWqWfSeIzrD5tifEQisHAgsLPNFkkREKzUL1hx30RlmaN
 1uEVy3oUaqAECInTgpySROZYYeimYx9axzEuRb4rmFbHs4FykpTeaISDoo5qYmUKuGxu
 d/LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=5LTVUWFKqxTnlRJ+43dyj9rgpwEsEGWuURtCeSzMvnc=;
 fh=f94efNnYZMPEMzrwka0gzDsWHrWKqvcGEYHLumH//gw=;
 b=GpQC8dfUJSPgGQTgMCyTRpTmI/oOSlF6nPO6mYsDk6yIycSxdfLYypXBuqRzmN6GGK
 /htjHbD6B/xPMh63yMZzpSf2STEoJiwZClW2uzKZretKV3EOMhrWuZhUT5nQPUyhVG9a
 SSK9M9tX19UH+Ahj3jH3BSEv9efpIYjVU83x1o7PEJSm2EOLfbQ4O+252kAnhHZGFuwt
 cuVSQD0FEK/h0vLH62No/pL4ZyGpdaubvxJmmk6fwA3nu5IUNuW8BZipRwyZllL8Uwwn
 368wupyFwsWOSimih2RnrzkwfNsJ6EVrgArPYdJcQ+B1zRM0LhMJLY0E6N9EYHr4kDhw
 5E9Q==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1769101704; x=1769706504; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5LTVUWFKqxTnlRJ+43dyj9rgpwEsEGWuURtCeSzMvnc=;
 b=XLWNj2SySrf0jmADKL49ud0uPaBT6T/MDAN4iDWMUr6apJT1Sl7EK0VddxgQMh1x6s
 hBqm3qlw7zfg/LqrxRpwgeNBfWXAvZVGTWD4tVnKTlTaPdhvNwzVrMbGCfei9aUVk2IM
 nEPaWfqOV/bg8CP3gOyygTketz4V1vJVElODA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769101704; x=1769706504;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5LTVUWFKqxTnlRJ+43dyj9rgpwEsEGWuURtCeSzMvnc=;
 b=R1w/VvxtZte2LfN6ucs/pAybL+nDnNsN9tw6R+IxVKUkAL6+Aq83q/oJ9iYtFZD1Ta
 wxMc/QVpjA1ChtGM4rsI+y2DcBulAOC9maDj9IzMGFJCuWVE/gmLlsK7Ar64Jbl7JudS
 SoSNi3t4PN13z8J7t7YWObJ2RUQCsf+bczwdW8KQEk142PnM8blmWNd2IERAVwBCTIPC
 Dm6EF03I1mma/xP9+N+Gf66a39wM4n7SfWE3tClGOLOxIM5iENaeVo39VPqztul04s+u
 yXDJVctJzc1IOdNQV/36GzYVxrD2ntO3H1gXDqPxNqZnuVqj+EL+i9foJIXlOEWb6OQw
 vPxg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW+A6tFow3XhxXPBUzabfWgpzGEJcr7iY+ShoE3ovYZVg/tjEpVK/kMxS6A0IGj6ClLVrw=@dpdk.org
X-Gm-Message-State: AOJu0Yy5PZLIsMrC5xyqRgKyHdwFz4dJxdwwt3ULFplThKzUUQoWYAEM
 QsTmMkAnEYw8ZsR+KUyVMStY+OzVNHiV6CsEcsEQTxsSZWXsN4XPJWTygC1BxpIzcxB30Q+2aZ7
 mpbIzUHZWYsxyoOrSbu7tIrGc/ekJsU4rMMaAizdBTA==
X-Gm-Gg: AZuq6aIw0dqP2Wx1r+4XL9JZBH20VIHVev3TmJfS4xIdARKVSyTTL/ZAUzjzAB8FGQo
 xmxuaNrgilrxihZCh/aqHW2E0ARu4AAOtuMZ2dAuD+pgjlYuKnNabrILXG3yEGt/Wa/2HWfxgic
 /SN68BOYT4FvAcJnhh9WYWUUrr2AuqqjuIIqMAR7FJtn8LnrOk1CRIc+6OnQKCvxTaH3I1hjLGR
 uYRCpcVm2pl8kEXZ1cSz0W4HE8za7hebCDropTa379RM4X/eERr03Txesh6DhT8wTZwNTF0G+MM
 ZXQa58/FSg==
X-Received: by 2002:a05:690c:4c10:b0:793:ac88:2a49 with SMTP id
 00721157ae682-794399bb01amr3689417b3.49.1769101703867; Thu, 22 Jan 2026
 09:08:23 -0800 (PST)
MIME-Version: 1.0
References: <20250826200720.104443-1-dmarx@iol.unh.edu>
 <20251106181355.209706-1-dmarx@iol.unh.edu>
 <00c96241-3728-414c-bd1b-a1a0f28e2423@arm.com>
In-Reply-To: <00c96241-3728-414c-bd1b-a1a0f28e2423@arm.com>
From: Dean Marx <dmarx@iol.unh.edu>
Date: Thu, 22 Jan 2026 12:08:12 -0500
X-Gm-Features: AZwV_Qj2mBCt0sVy6vguYUWBABQFx_MLNaWOT9UOA-XGEr9jWepdlZRcgZaPjrM
Message-ID: <CABD7UXOU+DbkQja3CKSWq9wrHaa-qAwmk6MFAk4su1m0ycNkAw@mail.gmail.com>
Subject: Re: [PATCH v3] dts: add test case docstring checks to format script
To: Luca Vizzarro <Luca.Vizzarro@arm.com>
Cc: probb@iol.unh.edu, yoan.picchi@foss.arm.com, Honnappa.Nagarahalli@arm.com, 
 paul.szczepanek@arm.com, dev@dpdk.org
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

Got it, I'll add a patch updating the dynamic queue docstrings as well
