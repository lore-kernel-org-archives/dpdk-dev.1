Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C2ADCA5FA5
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Sep 2026 15:42:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 358DE40679;
	Tue, 29 Sep 2026 17:42:19 +0200 (CEST)
Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com
 [74.125.227.140])
 by mails.dpdk.org (Postfix) with ESMTP id C5CDB4026E
 for <dev@dpdk.org>; Tue, 29 Sep 2026 17:42:17 +0200 (CEST)
Received: by mail-pj2-f12.google.com with SMTP id
 98e67ed59e1d1-398a147688bso3210171a91.1
 for <dev@dpdk.org>; Tue, 29 Sep 2026 08:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790696537;
 x=1791301337; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=dEPVZD81+uipXzdGNS1cudElutPQgy3tg80pUEp9KU4=;
 b=A7nd9nl9z9BSZlcCZpRqSj3FBB0BEI4sH0vYDCUR3NsmnlGeCQV4h6UnsIttw1f8aV
 AMYw/ZSkdn7zkCQz8vqUWBWFIsAoe70Top7tQx3d1KllqTuzzvjuwJi8FT2452WcEXTP
 6erccL6bB6BnEVz86dg3j/Uz3UhTMaQYGOMCoXgPyDUxDYw0I8qmfHTtDVFuFtwC+i84
 Bt1PVlim+VeMpYk1EbHHgpXE2+RVCZWIU9Q6ykwK+X0JYZBP+ow2sTWZtYnbgBhkCPzo
 MVeV169GCE93Bi/man29sAn5nOR1qyPOLlg8zkGVDC6z2XgJSOcJZINKfB6etu/1cYB7
 rI/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790696537; x=1791301337;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=dEPVZD81+uipXzdGNS1cudElutPQgy3tg80pUEp9KU4=;
 b=jUmIdtp12EOiSqFilCKfcvBJHxIFX95efztOaecyhcrdBWuXHkHSL7daYrqnB2EBhg
 ki6UbDrJnLxrZlEtcLV0EhvVIsvNWdD8nhFHGX7awB01Pr6ZdZCRr0czsk0WBZLXB7Jy
 Npj+FJt4rK6dXt1rGW9ESqstF1Y8y7Rzwuu9aPJQ6kvr4MQrcNzy8s+Z8DF/7UyATgWA
 MSvZHIvVEVby4kuUmLpXwx9/29dMkHe26IXDaT+smOlm2ucZbROjLnhq/t98y66W7Nvr
 b9lLYOKnrkOLO903MIbJfvf2BGSeqEy6/sBCtHyHpx59gGmBQ6ejW0qhPUqoJAODFEbP
 uIPA==
X-Gm-Message-State: AFq9FYJlXMPW0vBWBufmsYHVu/aOlzGtxzqCOFxE2iAh1L3CFuCvNBLt
 nEkakFiPHaLXIh2SLfp4BHVTdNgAWPNQPZwqHCfIevY6F+Za7v/v5gicZvs+a8QpRUA=
X-Gm-Gg: AYBFou1jczKkfgbTuIWBT60mDqmIYT5D4wqP+c0ImsG5PThVFgZjXVNLNZoJVGWmqBj
 1obE1aVQZSIZPcWX/Y4UPgEIIBH3K4joYM7ZlOoCt1JVfgYxMmuS3UCKuUARM6034kEmWlJJroq
 tzyBE2rVABm0Btql2XG90UaCIGXsPHddNeOKQaj2NHbx7ENYQOWClexoii6HR/nyx54qNaSqknK
 fuJoIEhb0Is7/xAw87vkY/3ZaCxz5l3KZrB5vWBbp8kDQ32SuejEedRaxLG8u5OSE66VSO/z3m6
 +cQEef4lGto2oHAYdDAe3NAfwv2Fb6snATBWZXgR0rrCia7c/O6Jemy3oml6lzppFU5GYbqJ1KN
 cxqJdsgX0Uvr0Tm2YQI91FoS9O1PmfMsHAttYICzjEOnJeCjJLIKJFeoCyfIzRWWEBfJwg4Gx60
 JF3fTLCppWixAQmDxuvhysMFrPNDiHXptVIoMEpGcb21YNiNuh8/qzqPFcRevwqau4uQI9k7nMB
 2uAiYypRCnjSOeibS13IMH6geFIi4UA2Z2J8QhU
X-Received: by 2002:a17:90b:3b4c:b0:3a4:6b54:863f with SMTP id
 98e67ed59e1d1-3a46b548711mr5735270a91.41.1790696536677; 
 Tue, 29 Sep 2026 08:42:16 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a4982d5b3asm6129201a91.17.2026.09.29.08.42.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 08:42:16 -0700 (PDT)
Date: Tue, 29 Sep 2026 08:42:13 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>
Cc: "dev@dpdk.org" <dev@dpdk.org>, Arthur Chan <arthur.chan@adalogics.com>
Subject: Re: [PATCH 0/7] net/memif: validate input from connecting peer
Message-ID: <20260929084213.4f00c1bd@phoenix.local>
In-Reply-To: <PA4PR07MB72807B6698334B7CCFBA3A4190812@PA4PR07MB7280.eurprd07.prod.outlook.com>
References: <20260922194138.508919-1-stephen@networkplumber.org>
 <PA4PR07MB72807B6698334B7CCFBA3A4190812@PA4PR07MB7280.eurprd07.prod.outlook.com>
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

On Thu, 24 Sep 2026 11:24:08 +0000
Sriram Yagnaraman <sriram.yagnaraman@ericsson.com> wrote:

> > -----Original Message-----
> > From: Stephen Hemminger <stephen@networkplumber.org>
> > Sent: Tuesday, 22 September 2026 21:41
> > To: dev@dpdk.org
> > Cc: Stephen Hemminger <stephen@networkplumber.org>; Arthur Chan
> > <arthur.chan@adalogics.com>
> > Subject: [PATCH 0/7] net/memif: validate input from connecting peer
> > 
> > The PMD has effectively been unmaintained for some time, which is why
> > these have sat. A call for a new maintainer went out and Sriram Yagnaraman
> > has volunteered; he has reviewed and tested this series.
> >   
> 
> Thanks for the series, Stephen.
> Acked-by: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>

Applied to next-net. Had to resolve minor conflict on the statistics handler.
