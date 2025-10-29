Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0269ACCF9E9
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Oct 2025 13:13:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4C9904028E;
	Wed, 29 Oct 2025 14:13:33 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id E66E840288
 for <dev@dpdk.org>; Wed, 29 Oct 2025 14:13:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761743611;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DhZGJutNG5uopker7lGg6Dh+QHDIAuO2cfCNyBbwpGo=;
 b=TbXsrEWn6eeMkz3rPwLFn/GOtHLKF8yaUwI7DdI6RVW/1NVkLNpfnNJdSw9+7pIYYbcLTu
 4rXXvv5IToQd5UM41cfiiVhgtX3VAp/RmqzOehGJObXgomRfLt/mdOz82+06nWrX1VbEGF
 puV/+B9W+PdS4Q2dlcXiGf215qL2ObQ=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-323-gYXIcqNaPrOu1monOvcShA-1; Wed, 29 Oct 2025 09:13:28 -0400
X-MC-Unique: gYXIcqNaPrOu1monOvcShA-1
X-Mimecast-MFC-AGG-ID: gYXIcqNaPrOu1monOvcShA_1761743607
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-57893a7d857so6313904e87.1
 for <dev@dpdk.org>; Wed, 29 Oct 2025 06:13:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761743607; x=1762348407;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DhZGJutNG5uopker7lGg6Dh+QHDIAuO2cfCNyBbwpGo=;
 b=eNgWibjcCKPiIliWINHEP6lUTMrag1UCv4rE3n2O/xgTlR9u1F21f2Jn9Vi7jlUMKX
 v4GssBNK/X9BEnFXQatwl4N3pV/iof6qXpO0uBhYbHJXzabAWEzkxPcOTFHRWef5xaog
 h6A0DnZ8JwjKVDNpsdfLkxyCa7Mu/x4jRd+wrKlLk7NiH1h1fPZJZb9lsMKMstWQe/LP
 6JV0naH/0/rIrA6TlyPA1/EzBuY3u//zPS1RMrzffxPEquASRJRR30ewzuCdx39SsrKM
 4ZfRBagNMcp83nVOHwtRo0HkAXnfw+Dwun6hvKtM2INoMRXRJzheNgdsRjJcDab5+axW
 nvjQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW9Mx6dkFiJRnDe0gPzMmHe6Z13z2X/apiL0Mcti8lvsVjUJ7uR0rJY+KA6Ppvp4fvOswE=@dpdk.org
X-Gm-Message-State: AOJu0YzDBpr7l/AhZ66xQh8SngeAYTX+C536nNSq7nO7nLwqf+ih/apl
 wBSIdPbveLHPR7kdh1pLj+ubdu1izV1pUw1MVGyHryr7NkNCpsn5ww6O4ci+ZSmF7L1o+CY1Njd
 sYvjGAFJC+sfh8EFnqqX9aynWBr5W0RZnkC78efBWdwmOv7pVEEn05MH4nEhaJBYkzLCaaynZ5p
 KWixxim12FiYtLUlF373U=
X-Gm-Gg: ASbGncuDRNc7KXixaQKpeGhncPBHpcPVoTcMh8JcpyrigYd9dwdUXsGMDwDCENV78pX
 h4WdRy1ZfLDxB5fN6nxhp9NB9Xl4neOmjlmWFCShvTkc/RwsJYHwm39jsG/1TpHPZh4kuh5Xm4w
 9DXHupeu8oHTcSyHshH6PPvHhLHbtQuaY9c/MMqRijocmgDHTnBj4W3Dzh8A==
X-Received: by 2002:a05:6512:1113:b0:592:fbaf:ec90 with SMTP id
 2adb3069b0e04-594128bf691mr1213389e87.24.1761743607058; 
 Wed, 29 Oct 2025 06:13:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEu5pA9LoI5r6iLu86kvFcsR1vHyAO0SvUU3+OQuh3b8dGhu3POVF4/biEYPP7Qm8C9QsNRchJayPuY2sZ/kY0=
X-Received: by 2002:a05:6512:1113:b0:592:fbaf:ec90 with SMTP id
 2adb3069b0e04-594128bf691mr1213375e87.24.1761743606601; Wed, 29 Oct 2025
 06:13:26 -0700 (PDT)
MIME-Version: 1.0
References: <20251028172324.3149379-1-jerinj@marvell.com>
 <20251028172324.3149379-2-jerinj@marvell.com>
In-Reply-To: <20251028172324.3149379-2-jerinj@marvell.com>
From: David Marchand <david.marchand@redhat.com>
Date: Wed, 29 Oct 2025 14:13:15 +0100
X-Gm-Features: AWmQ_blBkmu7f6e2g4uED8AgAiivJDAEenXlhsoCDmuIILgFGqo6GkBucMUw5cs
Message-ID: <CAJFAV8x8uNSgnP5gn3pNk9k8eb1FNMkoY55h2kt_CpeofQDyrQ@mail.gmail.com>
Subject: Re: [dpdk-dev] [PATCH v1 2/3] net/iavf: fix issues with clang 21.1.4
To: jerinj@marvell.com
Cc: Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Yiding Zhou <yidingx.zhou@intel.com>, 
 Qi Zhang <qi.z.zhang@intel.com>, dev@dpdk.org, thomas@monjalon.net, 
 bruce.richardson@intel.com, stable@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: OyH5FYMo0cMsxw29dWJIqFMLpvXxrAhmoxefzoJM3cM_1761743607
X-Mimecast-Originator: redhat.com
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

On Tue, 28 Oct 2025 at 18:24, <jerinj@marvell.com> wrote:
>
> From: Jerin Jacob <jerinj@marvell.com>
>
> Fix the following error seen with clang 21.1.4
>
> drivers/net/intel/iavf/iavf_vchnl.c:123:38: error: variable
> 'notify_byte' is uninitialized when passed as a const pointer
> argument here [-Werror,-Wuninitialized-const-pointer]
>
> Fixes: cb5c1b91f76f ("net/iavf: add thread for event callbacks")
> Cc: stable@dpdk.org
>
> Signed-off-by: Jerin Jacob <jerinj@marvell.com>

Reviewed-by: David Marchand <david.marchand@redhat.com>

Tested on fedora 43.

-- 
David Marchand

