Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D53CCD4F3C
	for <dpdk-dev@archiver.kernel.org>; Mon, 18 May 2026 11:55:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0B93C402B8;
	Mon, 18 May 2026 13:55:29 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 12D044026A
 for <dev@dpdk.org>; Mon, 18 May 2026 13:55:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779105326;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=k8ljS2rCYbisQoot4dLlX71wO5xfrQbQXtNdoM3Jd/0=;
 b=Xgw/XDDsFMA36avOAExX0irPiHDZHkQSpWSsdqahyO5zjBOpzw4SN85mvgnJUT9znpMUBh
 RFqN3txUAjGmxYP3B19y3+C7n6hXIE1NG7f73iCt4M+63nY9DJHQKeXOVttFpTntj6TNic
 f8Cm1vNe3yFvqE1muOCfWNVTTdZAhYg=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-2qOaLAgTMtSZOEqmRFZ53Q-1; Mon, 18 May 2026 07:55:25 -0400
X-MC-Unique: 2qOaLAgTMtSZOEqmRFZ53Q-1
X-Mimecast-MFC-AGG-ID: 2qOaLAgTMtSZOEqmRFZ53Q_1779105324
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-5a8cb92f023so1133647e87.3
 for <dev@dpdk.org>; Mon, 18 May 2026 04:55:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779105324; x=1779710124;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k8ljS2rCYbisQoot4dLlX71wO5xfrQbQXtNdoM3Jd/0=;
 b=AQst1CKK47IeBtj+rEFwhknIiEAAHBq01ORb4FszFR4USidzpmMqde4w1QFiduyaTO
 4UCvMJ4PAdWR8mIwU/PaHXFPbYAWrj+0JpQhN3AqiOYiKd2DIvBB3k9NyxS+ew0FWX3h
 Y8WnncY4uBioDzsQY/tO9Swzwrh4cvjcrZ3BFybiqGNdCq6f3Meb3/Fdf4EQQ5ePbeaJ
 x8L/d3YJd5XT4hq337f3w08kETk4DqhKpu/dSvk3IwD7N6zYNaZ2QMRL0hyED7PP6zWr
 CAUIypBBwOz64TgEsuPDGPcabJ62KHfmuDCIPv92vCMNxLB6WnQp9M3Zr3t79yU1Rk/H
 SslA==
X-Gm-Message-State: AOJu0Yy1ycN/yibmW7SxLjhhdzfSGOcFd1ERBARFNUFBjlJe/pTRvNCY
 eGqHSZQY2JWQOObYKTDXQSZnfzveyCHEyB4eDjqqdPqq7augNJP7S5O2KqD6q+jhAJ3yCJ3m6nV
 owRjxSJMQPi+H0eO4rG2DcpeAqTE+epor6619AeMBGzypt1KRsB7HrNbLkRNoLLSMhrcZCP41Ju
 +LCxYJc1DAdstZbRCBaME=
X-Gm-Gg: Acq92OGoRIsEvy3ISNJgQta+p5+MCZjyOzEpKInu4hNjOI0m3xqqEaAMch3j/jWs3LZ
 v7nqDDs7emF3fJUIKMwDGqoKy1MmGJc6V58zGiS7JE1Glxx0EZ/7ETKyy6xPPtQX1PFLWb3kzZN
 vjw9SxoyATh3SWHg4JACtoqr7zyQwaAfeITKerj9YvL0JwsNejrrCZ1TmTej1TyPOgxKgmjC0d1
 PE1S6qnIDpsVFURbrm9mwBYVyEsHYpvtOvzxGLL3TcjXIoQ1N5rBAuEER5Nw//vTmsn+w==
X-Received: by 2002:a05:6512:3b96:b0:5a8:a754:f9d6 with SMTP id
 2adb3069b0e04-5aa0e769b74mr4645208e87.29.1779105323806; 
 Mon, 18 May 2026 04:55:23 -0700 (PDT)
X-Received: by 2002:a05:6512:3b96:b0:5a8:a754:f9d6 with SMTP id
 2adb3069b0e04-5aa0e769b74mr4645192e87.29.1779105323271; Mon, 18 May 2026
 04:55:23 -0700 (PDT)
MIME-Version: 1.0
References: <20260505140352.3995590-1-thomas@monjalon.net>
In-Reply-To: <20260505140352.3995590-1-thomas@monjalon.net>
From: David Marchand <david.marchand@redhat.com>
Date: Mon, 18 May 2026 13:55:11 +0200
X-Gm-Features: AVHnY4LQuLqFFzy1TmJUMAUrBwLzZgyOWj3TOh6B4ekVGhHkxfztuySixGtzK2Q
Message-ID: <CAJFAV8wKu9SZKi7TmOMwfj1bNS=2QQ7qDP=kWMPbhFYi-EcKVg@mail.gmail.com>
Subject: Re: [PATCH] devtools: fix regex matching literal plus in patches
To: Thomas Monjalon <thomas@monjalon.net>
Cc: dev@dpdk.org, Haiyue Wang <haiyue.wang@intel.com>, stable@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: yyUBKjCTLeEVX1fQfBK-8fw9LIpN6LtChig8kToAIQM_1779105324
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

On Tue, 5 May 2026 at 16:04, Thomas Monjalon <thomas@monjalon.net> wrote:
>
> In Extended Regular Expressions (ERE) as used in awk,
> '+' is a quantifier, not a literal character.
> The pattern /^+/ matches the start of any line
> instead of only lines beginning with a literal '+'.
> As a result, check_experimental_tags and check_internal_tags
> were matching context and removed lines in diffs, causing false positives.
>
> Use [+] character class to unambiguously match a literal '+'.
>
> Fixes: cfe3aeb170b2 ("remove experimental tags from all symbol definitions")
> Fixes: fba5af82adc8 ("eal: add internal ABI tag definition")
> Cc: stable@dpdk.org
>
> Signed-off-by: Thomas Monjalon <thomas@monjalon.net>

Reviewed-by: David Marchand <david.marchand@redhat.com>


-- 
David Marchand

