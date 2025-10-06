Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADCFCCCA471
	for <dpdk-dev@archiver.kernel.org>; Mon,  6 Oct 2025 13:03:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0630340668;
	Mon,  6 Oct 2025 15:03:22 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 535A240661
 for <dev@dpdk.org>; Mon,  6 Oct 2025 15:03:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759755799;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OE3vockcU2KJvysTCz8mFRZjLynCyQdGlUkBhcvIVXE=;
 b=RM3DDutZVwCtRRPAZzJ8uDfpcVTYYi5Dlv+JuCADWKkVelGW35/3ucgXiusrmWD6NBxvHq
 KqENu1PglhntnliecxE279GRXF3Kn6LPszT2+jgt5YadH7TlwR2Z7P942zZKXO4S3nanly
 GRD/zqx2PbeAthJWriBuI/+0gsdDcLs=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-274-tvuJfKA4Pjag8OaM-RCQ1g-1; Mon, 06 Oct 2025 09:03:18 -0400
X-MC-Unique: tvuJfKA4Pjag8OaM-RCQ1g-1
X-Mimecast-MFC-AGG-ID: tvuJfKA4Pjag8OaM-RCQ1g_1759755797
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-57cd230eb72so2946221e87.3
 for <dev@dpdk.org>; Mon, 06 Oct 2025 06:03:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759755797; x=1760360597;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OE3vockcU2KJvysTCz8mFRZjLynCyQdGlUkBhcvIVXE=;
 b=elXO/fi9D7vH3TA3qHRJTexeq7FihHfJJMVCFMDcIl1xsV6q0fCV9rM6iH/V/Ou5FX
 ufrPqj4RxEjCoZy/7qb0qrTXmwyFF2iyomNi4OG41584rhbri3YWvnY1zo0W7Qd56nR/
 59gYfZT9vag4LZG+F1jOHxMB+EH67TkkIGhE4QG7yNTEWlB0xtJ1H+meFdq3yrLIuf9O
 5ZnNVydWfJnZUUICPRguiaLGbqjAXIBdypJBGUWNSJKkQ03z2kFN6ommdREp+Du9eHkp
 GoiY4Gh5PdxtkPJdi30kuo3vKmICC+qMckCklDteargjAbf+FQNBNJ+VguNJxLaNksTE
 wsnw==
X-Gm-Message-State: AOJu0Yxxv9JjKn3QJygxqxLkn8S3MdtljI8yUijKrcxFygHmbLJ8g/ub
 H61MomnpII9+pppHwkfmqRUca+NAWjMKg4ivfU2IsiKg9cWRZOUG1rC4dL1GSiUSUMFqwl3N62T
 FSxmi1l8dNXaYh4Pc1++pLkIgpDG8Lp1wP4j6N+IK3OX5FXI7JdKf6/7uGEddvvVvvaUCSKE01u
 +qwI7giQs0zBtB64hf8yU=
X-Gm-Gg: ASbGncsSf+4OebGhI5y/FT7vDPBXgr+h53Um9t3nWhlIOKOx+YNlONVa+K1F9rRTLuL
 Zb6DRRV7V7Mj2fAKqaJYWpNC05tNPygvfM+gEZ1bA1HcwetCN8vqYoWh4dYKh8f9mEvzH6oZwwt
 ck8HXOVLjzdY/UtrzhlRNOAenwmM/P
X-Received: by 2002:a05:6512:b85:b0:57d:7343:3c6 with SMTP id
 2adb3069b0e04-58cb9a39359mr4458483e87.16.1759755796808; 
 Mon, 06 Oct 2025 06:03:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEUSO6EFghBOR2Qc2qdItb6pk4jBwtHkDNRttArKFM2CVW1K9jpDIRGk+fgkhfBDSm0q3hyA9GiBwTaS6skyec=
X-Received: by 2002:a05:6512:b85:b0:57d:7343:3c6 with SMTP id
 2adb3069b0e04-58cb9a39359mr4458451e87.16.1759755796292; Mon, 06 Oct 2025
 06:03:16 -0700 (PDT)
MIME-Version: 1.0
References: <20251006124506.388456-1-thierry.herbelot@6wind.com>
 <CAJFAV8zvhYiOy=PuUctg8N7EyM6asQdDNpnx_Xc+WusCz02L+A@mail.gmail.com>
 <8f14ef89-8f1a-42e7-8cf3-e609de32a98d@6wind.com>
In-Reply-To: <8f14ef89-8f1a-42e7-8cf3-e609de32a98d@6wind.com>
From: David Marchand <david.marchand@redhat.com>
Date: Mon, 6 Oct 2025 15:03:04 +0200
X-Gm-Features: AS18NWD-UK8_lIWQ8e0tBvNIjU20f1ZOx6DF1q1eVqbdTprzGb-gNoQ43jpWGuk
Message-ID: <CAJFAV8yDgdeRLdrNdEM2y-0BgpnGkfRLRecczMEnDgshSPMgug@mail.gmail.com>
Subject: Re: [PATCH] net/intel/e1000: reduce the optimization level for gcc >
 11
To: Thierry Herbelot <thierry.herbelot@6wind.com>
Cc: dev@dpdk.org, Thomas Monjalon <thomas@monjalon.net>, 
 Bruce Richardson <bruce.richardson@intel.com>,
 Stephen Hemminger <stephen@networkplumber.org>, 
 Olivier Matz <olivier.matz@6wind.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: svgZEXhAEJCpzxmSZE8_xQaf1avGgyR1NUYqgqA5kok_1759755797
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

On Mon, 6 Oct 2025 at 15:01, Thierry Herbelot
<thierry.herbelot@6wind.com> wrote:
> We can not expect a random developer to sprinkle memory barriers in the
> PMD until testpmd seems to be working.

Then random developer can report the issue and keep from trying to
hide the issue which is not helping.


-- 
David Marchand

