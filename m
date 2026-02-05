Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEE13EA7950
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Feb 2026 01:43:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B901D4028E;
	Thu,  5 Feb 2026 02:43:51 +0100 (CET)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com
 [209.85.221.41]) by mails.dpdk.org (Postfix) with ESMTP id EFD7740264
 for <dev@dpdk.org>; Thu,  5 Feb 2026 02:43:50 +0100 (CET)
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-4358fb60802so267510f8f.1
 for <dev@dpdk.org>; Wed, 04 Feb 2026 17:43:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1770255830;
 x=1770860630; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Bw9pkgCwH3DHoWwf2Sj7FnPmTGK1G0Z48s2bB3FWhaU=;
 b=dgxj/Kf0Ipk5l3i8Vu24dToV13OQa9PUsxbrxquJkmLr2eXnYn0HlZv88M6u70m2XE
 98T6CkTa/6KMmrfruaWX/DJ42YuZYHkqYe7D2NKemoeoySou0UZTOAet5vPExQFUMvNc
 +9P7/rBK9NG/AtO3COg+rrI04dY3K6zoF09zllL8mWvS+iqXzY4X6+jtjmAjmoGwQ0PW
 Bglfpu0zmyVRzzE1XiKgzspImjY6QhkzS2CNUCx+9FvZOsnv+VZ6ZA/HTzHgJfvHIFSm
 E0QuMD6TwaOiL662qq5bLNXeEB1DZ7LfY9n50dwZuirAiUrklAIqTxU9KsFd6mB6eUMa
 5x7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770255830; x=1770860630;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Bw9pkgCwH3DHoWwf2Sj7FnPmTGK1G0Z48s2bB3FWhaU=;
 b=epCaPTju5aJT8s/6/9ctqP4kFlL/PgdUkPb6LNv5KLZOuJPtyh8P3HTMoFy8AlUgjh
 uQnwLazofBC0W6A9KeeCnLEvdkfmUNgTrBHVFhv7JSdyR7gT/NLPWjohoOErSOfuIwR4
 BBGEI4TG6K68m+mK0i/gDHfeKEFZnIhXDhCArRbq87k9yQOvNi4n5WssY4MaXQDjOFH4
 kVFiCaCtjkjAsOtXrtTUdXeobNQxbGP4J7MOWctOdfOQHfuS/m6wDWH2PgaYFw3Hhlr7
 ZlLHTj2QEhzXYjCGrM1rWbkTVN6Qmj5cxRScfb0Dt6vvuC0MXaqmMVHGD0c89CTB0iJH
 tonw==
X-Gm-Message-State: AOJu0YwFrUwDW30BLwTdiHnEonbY/1NUor+RYuQ/8+XmCXXccqA+/wWh
 Nx8ITWEX2wjP3XJK0Idhw3OfQd3w+xmwZ97SAdRmWy17aAPtk5KAZh/YWXpUUmgKpc8=
X-Gm-Gg: AZuq6aJSJEE8zFh2KmnkU7cipexKg+lFETuWDRriaGGkMfkgkmXAYJzHudXdVaPzAmy
 M2oSvuPnNUZmHV7AqOG5LlGczi5JRAA7q9yzlZVuXi5OgrlspnPMX11/I+JONjOJ/CR8cTd7spO
 KBpoHmR8VvjpHYMdKgtbq927miY91j8240QLQVCj5dviKDaNmZ2PadxUVQilPgCdY9nvvUdoUv4
 ooc6zC2fDCuIO+JHf5FcnyDq//jEEV8MwcqQ0u1IjIUsB0P1KaEzuy/+moJBv71hjruo54G+Huv
 dZqM+ltqTFBtH9pcs74b3bWiC7dIt9yPN5UyyCxFe0luH0j1nqIL39ZnVeB3tAOfZ2WtoQtnAvg
 WeMI9mhnvx2CpQHFUMORH2qK1jJcx2jYatnxgvlTYykwJKLzc5K+5m7zaGWWoAPY/NS3gqZOl2r
 MUe3w8WvrQIglBU1qJe+k6SsJO1QZZK9g6RctL1rp75Om+iJMgELHw
X-Received: by 2002:a05:6000:2887:b0:425:86da:325f with SMTP id
 ffacd0b85a97d-436213eb7d6mr1559128f8f.27.1770255830537; 
 Wed, 04 Feb 2026 17:43:50 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43617e38fbbsm10693743f8f.13.2026.02.04.17.43.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Feb 2026 17:43:50 -0800 (PST)
Date: Wed, 4 Feb 2026 17:43:45 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: <dev@dpdk.org>
Subject: Re: [PATCH v4] devtools: replace checkpatches shell wrapper with
 Python script
Message-ID: <20260204174345.06352357@phoenix.local>
In-Reply-To: <aYOCr5S3USrer0vp@bricha3-mobl1.ger.corp.intel.com>
References: <20260131204823.29363-1-stephen@networkplumber.org>
 <20260204165949.19709-1-stephen@networkplumber.org>
 <aYOCr5S3USrer0vp@bricha3-mobl1.ger.corp.intel.com>
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

On Wed, 4 Feb 2026 17:32:31 +0000
Bruce Richardson <bruce.richardson@intel.com> wrote:

> On Wed, Feb 04, 2026 at 08:59:17AM -0800, Stephen Hemminger wrote:
> > Alternative to the checkpatches.sh shell script that wraps the Linux kernel's
> > checkpatch.pl with a standalone Python implementation. The new
> > dpdk-checkpatch.py script provides equivalent functionality without
> > requiring the kernel source tree or Perl.
> > 
> > Performance is significantly improved: checking a recent flow parser
> > patch series dropped from 2m23s to 0.43s (approximately 300x faster).
> >   
> Yep, it is definitely a LOT faster. Running on top 10 commits on main tree
> with old and new script:
> 
> $ time ./devtools/checkpatches.sh -n10
> 
> 10/10 valid patches
> 
> real	0m32.570s
> user	0m30.517s
> sys	0m2.256s
> 
> 
> $ time ./devtools/dpdk-checkpatch.py -n10
> 
> 10/10 valid patches
> 
> real	0m0.255s
> user	0m0.214s
> sys	0m0.040s
> 
> 32.5 seconds down to a quarter of a second is a massive gain. Looking
> forward to switching script for checking patches in future!
> 
> /Bruce

I still am finding some unintentional differences but it much
easier to fix false positives than in old code.
