Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89BBBCFA466
	for <dpdk-dev@archiver.kernel.org>; Mon, 24 Nov 2025 16:20:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A32CC4068A;
	Mon, 24 Nov 2025 17:20:32 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 7EBD2402B1
 for <dev@dpdk.org>; Mon, 24 Nov 2025 17:20:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764001230;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6ghD99zQinRTZ9wOXmIp+iP/d7iOHOtF5/GguBFkhXA=;
 b=bFZHTCkQGGx6Gc7JB0ShovK+Kqn6OdXDEsD71qIT9KWExTJoXSo4EJ/OItCu5uNa8FTTcA
 +bSPs8iZt0kNi7zPvi6TAfamx9D4TTKkD3ONUeoQsdKGws7lIR+OzdxQsihq/qjxSSSinT
 VATmULXbGLoQcgkyvSUnjHnk2i9GuNM=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-124-QCpmAuTCNUyo7FI2u7s0jg-1; Mon, 24 Nov 2025 11:20:27 -0500
X-MC-Unique: QCpmAuTCNUyo7FI2u7s0jg-1
X-Mimecast-MFC-AGG-ID: QCpmAuTCNUyo7FI2u7s0jg_1764001226
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-5943838a6d1so4207387e87.1
 for <dev@dpdk.org>; Mon, 24 Nov 2025 08:20:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764001226; x=1764606026;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6ghD99zQinRTZ9wOXmIp+iP/d7iOHOtF5/GguBFkhXA=;
 b=BaOmHonwu/WwOTMEFUXDVocVfZStv0CE598Zhfft5pc2rJCnrGiTALpVGwayCE5zp1
 9YSBpjTP2y7WYvYYLrWxihGCjlQZGUS/oYa8Z37G2wZyRivp6pHl95UGRxdrMsc42alX
 wcv7j2jmKHIpqgppyu1rUoy1ZfvK+7ZdA2BjIvs+l7T4CsImlAqgwHyNLTpCrXVOwFLc
 kQ3EL7Jy+8kV6G1kj+WmUjxHcktnZitQSTWXh/3fT86P+KZPmog6x6Aawjv+ECyZBDy4
 ba7UlIm1LqAc+tFF36mN0K28JyvCUJ1IeRxEfsXXstrmFT0HempMJn8Cv2tHf28acGCP
 xmUA==
X-Gm-Message-State: AOJu0YydkqIOm3Sg8ujahUxHtCX6k9qrbnVyEQ2LXlS6KUTojcBsTiYS
 P+ptvdF7a+XggHoEbRlMc3QnZF1tvZCbhC8DTr8dw6tcLz8f8MF/ej1ZrTPm3IvN4oR7SqkMMVj
 EDb3jy6X82f0RCM51O1py+61tWaoHykX+h/vof3Vdg9IE+M+p9tQSTWohd9VVF018SDp9II8HUj
 Ml/2upWjq8p34DfbSyw+U=
X-Gm-Gg: ASbGncvNKppOj7nwncvDdrRjosGR85jzA53+JLqvYlkheWQlmgnaRDOPo8x9hOXykPZ
 ku5d2ses9N7dbqRcZx00RG4JU7uAGa69yGI35gcvgJ6LwhzFMqYlNF5lBn1r+aLDVZGp7lez85O
 0nSTUiOu739d46YMaIx/s5JRErFAsYQzp0A+iGZfOU8W3xeyr7wnuan7ZYJN1Dk34ievdA
X-Received: by 2002:a05:6512:acc:b0:595:7e8e:3bc4 with SMTP id
 2adb3069b0e04-596a3ee2ef1mr4321926e87.42.1764001225776; 
 Mon, 24 Nov 2025 08:20:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEKg5Q/VSudQ6slyGnneqyJERxG9fgJ9UhwLUtHzaeANdOK0vV3xsDtYkTDKHPrkiqUXR9eJBb7OoX1OpHaeHE=
X-Received: by 2002:a05:6512:acc:b0:595:7e8e:3bc4 with SMTP id
 2adb3069b0e04-596a3ee2ef1mr4321919e87.42.1764001225245; Mon, 24 Nov 2025
 08:20:25 -0800 (PST)
MIME-Version: 1.0
References: <20251110182209.104087-1-stephen@networkplumber.org>
 <20251120162327.78062-1-stephen@networkplumber.org>
In-Reply-To: <20251120162327.78062-1-stephen@networkplumber.org>
From: David Marchand <david.marchand@redhat.com>
Date: Mon, 24 Nov 2025 17:20:12 +0100
X-Gm-Features: AWmQ_blAD9DpQCL6w5ZWsHKwN3cfs6_UeKfUCoFt1AlZlOhrI2iFXZmzN7ZfvdU
Message-ID: <CAJFAV8xtZJacdsHRp9R9M6Qp9dSkzv-yrHmLBgatBq2AUcmF2g@mail.gmail.com>
Subject: Re: [PATCH v4 0/4] examples: fix format-truncation errors
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: U2mlrR0cglcFKbePhliFBGh8b6e3vdZ9q6qfZ2cH8P8_1764001226
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

On Thu, 20 Nov 2025 at 17:23, Stephen Hemminger
<stephen@networkplumber.org> wrote:
>
> Enabling format-truncation warning in examples show several
> possible overflows that are easily addressed.
>
> v4 - use RTE_STR()
>
> Stephen Hemminger (4):
>   examples/server_node_efd: fix format overflow
>   examples/vdpa: fix format overflow warning
>   examples/ip_reassembly: add check before formatting name
>   examples: enable format truncation warning

Series applied.


-- 
David Marchand

