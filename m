Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01AFEC9830B
	for <dpdk-dev@archiver.kernel.org>; Wed, 23 Sep 2026 20:54:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DAA3B4027C;
	Wed, 23 Sep 2026 22:54:35 +0200 (CEST)
Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com
 [74.125.228.12]) by mails.dpdk.org (Postfix) with ESMTP id 6750B40276
 for <dev@dpdk.org>; Wed, 23 Sep 2026 22:54:33 +0200 (CEST)
Received: by mail-pz2-f12.google.com with SMTP id
 d2e1a72fcca58-85469d20963so752080b3a.1
 for <dev@dpdk.org>; Wed, 23 Sep 2026 13:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790196872;
 x=1790801672; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=VU9YYPiUfXK2kYzxFx006uf8BBORQa4JkSz/QMwwY74=;
 b=MyMNIA/tXtWdWd38G60pkxJAEcIyyXGngpt+Dajwj9ul6V9IM7mlay5q5KtT9kQ1nS
 rwMRSsnM/CvJvf/VPkujfMjO03v4hvy8m+dRTBmKEd89FLlHPk4HvsSfmsC6zkZIV6wL
 2Oosrb2dDNlmAR5DdBFZ2rwsRT4HRBe7qfUikHZnlYMX0KMJYxBTiMbUKYRjbtEOdW8Q
 KvmKXwNo/PblGU4hrK64WgVMJe1HFohN3QoRcFt6sEYrgWWKI6FbfWYMWCvtTH/Dr11G
 SG5xJ3Wwb/BMuW0LrWyIU3nGEnYO9mJV/VAn8aprp0GKcDsU+lG8Z9/Lq9aNYMPXhT4H
 Hqsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790196872; x=1790801672;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=VU9YYPiUfXK2kYzxFx006uf8BBORQa4JkSz/QMwwY74=;
 b=fOOBfTrZAZ/ZIZALtU1w1j0fVjo4g/8uOTU2t1QtQsxmqYiM/aZSNaQRRivYEUxzua
 ZEfO5bnmwmIncxbbzQykpL8Lf2Qq0Z1xSfpHEmwNorKb7tVziD6Vyf36/X8VU/UPNnkW
 2IQtUiOFre7y+yNfvwtAJICPsjGOO88Jm8yvyzCDPK5kF3fZIHYHPdPWBajI90Ij3kTy
 bWyO5izSKZQsjtv4JxYiJLax3lNOMNpZzweHqWYmi2PrG11xcRUVgP4Twv1EEw0JcaQt
 T2nxM66gqwaKdBiLXfBR33/weAKvXn3zgBp6fFwk5nK2kWBAmp8gdjPKSaDd7jU2tcU1
 jXZw==
X-Gm-Message-State: AFuF++kdSJIT2CWCiVSGGXUiknpiswNILh8VE9ju9VCYkZj4sVbLGdBA
 MZjCSZQbYx/dT/8UQck8Fb/52mbI1u6Ltn+0pIj2x1BRWuW1ozzDGNVlgZQh7T+kIYI=
X-Gm-Gg: AYBFou3InYF24uiBXL5VVPIRG/1h2pbRzw53mRraT1LNAL5YX7t6F0p1wsWq5bCGrEC
 BxaWKfSrV6NuErKaYuzAqRgkHowb1tIQdhPfn0DHgiy+u+tTDTS1bC1L/Pv/zn+Uv6BIWFCmig+
 GmVbvG3gnJxUnkDEhPgVIDwDdStB+tVT1zhVA46ab8sB6VkGkViF19GGZKenJ5g3/QJer+5HoGG
 hYds1TTQDueXlBpsD32rbOf12EwRi0UtYyMrkARgl3FzXizGZJItB/gZCtBUCilz3ntCBp51iPF
 f33nUZYweoSfpjCwt+2t6tnVDYC3NBTqTz6bYYply747s2rSjZf2+FgnY7UDvElfZ9jpBPcxfFX
 5KUvZGZwIg2CizD/SA+F87jq2IQVUgntIER1jBzKnlRp+vsbA8kjj0coPfx87qymeCdnTOtdhWM
 dT+D2SIxq6XPTfPwhwySXebJ1Y+IiBziTD+y3uhT8ifJYBBy6PSBysBs/Mq6J5U+vmilw8gi2mN
 DgxbIg65GW9tQ7IoMdSnzsbAU0+75FtnVzAbJtai1TNtHnK02Q=
X-Received: by 2002:a05:6a00:21ce:b0:874:708d:b637 with SMTP id
 d2e1a72fcca58-87e9d8da5eamr265535b3a.35.1790196872330; 
 Wed, 23 Sep 2026 13:54:32 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-87d1dff9769sm1852839b3a.46.2026.09.23.13.54.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 13:54:32 -0700 (PDT)
Date: Wed, 23 Sep 2026 13:54:30 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Thomas Monjalon <thomas@monjalon.net>
Cc: dev@dpdk.org, Aaron Conole <aconole@redhat.com>, Anatoly Burakov
 <anatoly.burakov@intel.com>
Subject: Re: [RFC] devtools: rewrite doc vs code check in Python
Message-ID: <20260923135430.7e16c673@phoenix.local>
In-Reply-To: <1ZOSY-tgQCqc-X4cyeVRVQ@monjalon.net>
References: <20260923184207.626576-1-stephen@networkplumber.org>
 <1ZOSY-tgQCqc-X4cyeVRVQ@monjalon.net>
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

On Wed, 23 Sep 2026 21:19:45 +0200
Thomas Monjalon <thomas@monjalon.net> wrote:

> 23/09/2026 20:42, Stephen Hemminger:
> > The existing check-doc-vs-code.sh only compares rte_flow items and
> > actions, and only for drivers whose directory matches the ini name,
> > so none of the drivers under net/intel are checked.
> > 
> > Replace it and parse-flow-support.sh with a Python script covering
> > the whole NIC feature matrix:  
> [...]
> >  devtools/check-doc-vs-code.py          | 1132 ++++++++++++++++++++++++
> >  devtools/check-doc-vs-code.sh          |   84 --
> >  devtools/parse-flow-support.sh         |   92 --
> >  doc/guides/contributing/new_driver.rst |    4 +-
> >  doc/guides/contributing/patches.rst    |   27 +
> >  doc/guides/nics/features.rst           |    5 +
> >  8 files changed, 1169 insertions(+), 180 deletions(-)
> >  create mode 100755 devtools/check-doc-vs-code.py
> >  delete mode 100755 devtools/check-doc-vs-code.sh
> >  delete mode 100755 devtools/parse-flow-support.sh  
> 
> Thanks for working on it.
> 
> My concern is how easy it is to maintain for all contributors
> having to insert their rules and exceptions?
> 
> It is replacing less 200 lines with more than 1000 lines
> so it looks a lot more complex.
> It is probably fully generated by AI?
> Can we make it simpler?
> 
> 

The other suggestion would be to git rid of the .ini file method
of generating this feature matrix in doc and just have python script
generate it.  Prefer a single source of truth, less work
