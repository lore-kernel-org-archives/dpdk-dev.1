Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75852D39420
	for <dpdk-dev@archiver.kernel.org>; Thu,  2 Apr 2026 13:23:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 276924028B;
	Thu,  2 Apr 2026 15:23:09 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 6ABE74027F
 for <dev@dpdk.org>; Thu,  2 Apr 2026 15:23:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775136186;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=52X8lCxruDF5caYSzuSg0dNBA2BqDic7g19Xlomz6AI=;
 b=WblOEio/ig0FhVRvCdmcWtm6imE7BCy/pRB7tDemP+dwtaKDr0ULmpOYvQYt5wYq7P23Dm
 9/SORO9pEAX2pyL9cWKcflQJDhURUteWaq7eLle6iXPwx7wLqvlLhJQpJ8+YRgGG9PXfSv
 nIfcuaLu9DsLkT0qjJ134dzq+xTuoog=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-250-4eVQs0CCOfy8qLF79EYN_Q-1; Thu, 02 Apr 2026 09:23:05 -0400
X-MC-Unique: 4eVQs0CCOfy8qLF79EYN_Q-1
X-Mimecast-MFC-AGG-ID: 4eVQs0CCOfy8qLF79EYN_Q_1775136184
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-5a2bebd46a2so755013e87.2
 for <dev@dpdk.org>; Thu, 02 Apr 2026 06:23:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775136184; x=1775740984;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=52X8lCxruDF5caYSzuSg0dNBA2BqDic7g19Xlomz6AI=;
 b=E1xSlksxWiZZ9Bkdd5EJY1yTn4RT2DjD5uTpwE+RaOadNAGEq6Fq4S9w2JTrDWQLMq
 VCc6fQmjLOsHs7kt8xmLEJaKUgSq1niBEhPzGGVKIh1Dbxwc5NMm8I46EnkcL6WYQNgp
 Mn7Ip+z4BDDfJDXjV6t7/HjACSo0X4sWPLyMDIJCl5vKOiheVAebXInpUnH4UaulaSK3
 tOaEqA3ZATpfI80TgoMDVWXXSDzyi95SGNfEbRA1X3F8dhYfPE2g1rmjyiN8M6C/I+yi
 xoVLydr/Dv0Xe8D8/he3qh6di2zIlg/EohK76wzKyU1u0fnsMpeGAz7Jq8yMxod3ww3N
 ZbYA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWtDIyKrqcgsuRsuyoRlpB5EFky0zwJGp81P028Fj55Pwj1P+gfCZNH0hR501755n3Eny4=@dpdk.org
X-Gm-Message-State: AOJu0YwFvJEE4YU/gBcvkuD6zGtXk/KT1zSI/OplKI7it/cS5M1g1v4u
 N6qzkYHmfjKJZeg6l75yBquWc/07UTh7DBuOOH8ScR9UHJl7vbPRQ6gneixr/LPvgHUuL4L8uzq
 mzkSyMF9AQKmRi22IwT30b/B3Lo9ggm/PLYPiUy9Gzfnr5KvJ5RwaMNruhPx6NkYS48vqleul/s
 QvFGglvS+jA9Lmlc5h+ZE=
X-Gm-Gg: ATEYQzyUa/YcgYaZyXO/ljA0zxn79egq4G2hhUAXqtKDesEmYrLonMl9b4zRY5xczJF
 KSnCHrGY/dAYf6PC8YwowKOt/Ng2M0EbBmczwyX8d4MziTljlQXAgUVdgRufu0qUilEihoVgZvk
 VVstfKfJ9dOSFytr/K1pi6iMCP2Ae3YIt1LPmjU+rIbouLEmzLlhwBa6aQEWWrh117j+sMpl6zA
 HI7cLwDb/0LhUkKsS0ubQebnq0HTKUMYLJA/ApbZJS/P7h6UBnJx6wJcreaUSJwhudc9Q==
X-Received: by 2002:a05:6512:3d24:b0:5a2:8495:965f with SMTP id
 2adb3069b0e04-5a2c1eedd00mr2899151e87.15.1775136183894; 
 Thu, 02 Apr 2026 06:23:03 -0700 (PDT)
X-Received: by 2002:a05:6512:3d24:b0:5a2:8495:965f with SMTP id
 2adb3069b0e04-5a2c1eedd00mr2899142e87.15.1775136183397; Thu, 02 Apr 2026
 06:23:03 -0700 (PDT)
MIME-Version: 1.0
References: <20260402112803.537002-1-david.marchand@redhat.com>
 <ac5VOtwRuV5I0ohZ@bricha3-mobl1.ger.corp.intel.com>
In-Reply-To: <ac5VOtwRuV5I0ohZ@bricha3-mobl1.ger.corp.intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Thu, 2 Apr 2026 15:22:50 +0200
X-Gm-Features: AQROBzAeckrQm4Utrh3DBWrh-H9_l48Bh1L0Ub7uKnPwI92XNnMmFQUFdAeqvKY
Message-ID: <CAJFAV8zRWPB9_oA_zkL+L9Pt+RLAnvEq_4TwPHYG7mmP1sV05A@mail.gmail.com>
Subject: Re: [PATCH] version: 26.07-rc0
To: David Marchand <david.marchand@redhat.com>
Cc: Bruce Richardson <bruce.richardson@intel.com>, dev@dpdk.org, 
 Thomas Monjalon <thomas@monjalon.net>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 5461rIjxLIdMA9lo8wpL3FXSYUwD307pIHYhbqZv5Zc_1775136184
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

On Thu, 2 Apr 2026 at 13:38, Bruce Richardson
<bruce.richardson@intel.com> wrote:
>
> On Thu, Apr 02, 2026 at 01:28:03PM +0200, David Marchand wrote:
> > Start a new release cycle with empty release notes.
> > Bump version and ABI minor.
> >
> > Signed-off-by: David Marchand <david.marchand@redhat.com>
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>

Applied.
Here we go.


-- 
David Marchand

