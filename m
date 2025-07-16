Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90786C83F22
	for <dpdk-dev@archiver.kernel.org>; Wed, 16 Jul 2025 16:17:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7ABFB4013F;
	Wed, 16 Jul 2025 18:17:17 +0200 (CEST)
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com
 [209.85.214.169])
 by mails.dpdk.org (Postfix) with ESMTP id 3760D400D6
 for <dev@dpdk.org>; Wed, 16 Jul 2025 18:17:16 +0200 (CEST)
Received: by mail-pl1-f169.google.com with SMTP id
 d9443c01a7336-23dea2e01e4so78467395ad.1
 for <dev@dpdk.org>; Wed, 16 Jul 2025 09:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1752682635;
 x=1753287435; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FG2ZOmAZQbXchGMOiwV/hOxLPS1sxUdQRKK1pxUiJSg=;
 b=jHB7wx/YnS0Lwh7LBHKp44kcWWWhdmocWRDzLc0ZYkQaQ7XJJfUnluFUeioL6LkRTM
 vWpl9uQBYGHmUyHQ1802RjHm8Tmxh9cdkOjgEzPFzFprCtBxBOQzdsK+GiGdgW8/7ISU
 i10C1l+2mKsCHL9ytCOVP6iGWh2P3pb/oFOdBGe7WVJR3Qh54Pe+VqkW4RxMZhDIkD5E
 Om44+J74fsGxlnY21lgie58IpSb+cPTW7zjlazu5sSqQwCr9mBu81pW4Z74SGhiFHOVN
 cSUle8dNF+cM69oI9FGe9qTJj0UOojsGMtyvj8nLdTRlV6ZAiyoIeSGxIA23tXASM4Fj
 es/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752682635; x=1753287435;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FG2ZOmAZQbXchGMOiwV/hOxLPS1sxUdQRKK1pxUiJSg=;
 b=J02ZLgERN5p8zWqwzFTwdtQJ6k/KKbQ7jaJiA13/KyR9Zw61DlVqw9lV417VZCTShz
 q9ZoLKMqTap9CdqUJ+qkZXvXr6q2VuCThmZkCFAq7DY00KjBdwMmuD5FEmjap3RzCWZ6
 95nvU0Qv0lXKFW1RmCR/UIV8FFQ9fQC9yuZwxGjjJEJShSTrysfrD8aObqVxaW23r0Mh
 pX6ome0Kq3kVSsS9kSpqpWqvE1tMzrWiuTimI9Ei6H+beKddsFx1Wof5US71EwZbuqaq
 CMoun71gSW3s9Qjd8t3tb0YrIAG/clXqRSRQVVJ9uxaLMc3CwCsuyoUclm4RbN+U3Px3
 T4oA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVX3Z7gCtjVQAhxfGifEkJRIKIRoqz1IrIqhWVxfOCjAwHJ/oi+CBh1b44cV+RtWgVy5rs=@dpdk.org
X-Gm-Message-State: AOJu0Yx3wmukK0Wf+t+6xYxR4z/9rwMLBvj+qJzxLwWn3LDhLqw806S2
 I1KLdU7iR5Bh5xW6GBKg7Oob0uXiah6iTr+y2qzvO31a4W5MTitAwVEqhGEGuWUr408=
X-Gm-Gg: ASbGncv9qBDB9+fDeyqE4SREShizybn5Z+qBiCmE9StRohlUvTOn2ADawoNQvaXPFFd
 J3P7TFxRH1XCS/wCHRfSpeZJwidISDyBShP5g/5xWsw9XMKmPs1LKnEq3/diD8fLYb9MEQldgXS
 tkCtL3+hl/hib2C5YVCePKv9Zhjvh5Ybu/Pe7DsVIt74O/v3+a8wKXp6Wft+biEaoK69hJvhxSf
 CNfMRXyZ/+CYwVpr4bRmdwrsjjTUcPv2MITV6s2OK0trrcXLpIjtKyfaU+C1+hFw7AUFIkawxdr
 cih3wgXYNxgue4Vf3K3nNokIEnsJgzI06g0mi+2vOn43BLe3so2WP3+03XBeZGs+jeB6WAg39Qe
 fv1KtbcE0WM5ZOblq8mQP1DTu9LPb6QXHKu0qe1pATnMdN0AhuIQeTBjY7oFIyYmY7bjqi0GE4M
 8=
X-Google-Smtp-Source: AGHT+IE8pJyCGMForCjLPLlzYEnix7wUZJjwAbBjHkA5GFJcT+0c35e1AxL0emnJk6LRafsqrTUlPA==
X-Received: by 2002:a17:902:d486:b0:234:f182:a754 with SMTP id
 d9443c01a7336-23e25772cfbmr41955785ad.47.1752682635254; 
 Wed, 16 Jul 2025 09:17:15 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23de4335306sm126081955ad.166.2025.07.16.09.17.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Jul 2025 09:17:14 -0700 (PDT)
Date: Wed, 16 Jul 2025 09:17:12 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Thomas Monjalon <thomas@monjalon.net>
Cc: Bruce Richardson <bruce.richardson@intel.com>, dev@dpdk.org, Matan Azrad
 <matan@nvidia.com>, Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Dariusz
 Sosnowski <dsosnowski@nvidia.com>, Bing Zhao <bingz@nvidia.com>, Ori Kam
 <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>
Subject: Re: [PATCH] doc: remove Mellanox acquisition explanation
Message-ID: <20250716091712.77a64ef5@hermes.local>
In-Reply-To: <4667722.LvFx2qVVIh@thomas>
References: <20250716101516.224980-1-thomas@monjalon.net>
 <aHeA3jXjcq80QERe@bricha3-mobl1.ger.corp.intel.com>
 <4667722.LvFx2qVVIh@thomas>
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

On Wed, 16 Jul 2025 17:56:04 +0200
Thomas Monjalon <thomas@monjalon.net> wrote:

> 16/07/2025 12:37, Bruce Richardson:
> > On Wed, Jul 16, 2025 at 12:15:16PM +0200, Thomas Monjalon wrote:  
> > > Time has passed since Mellanox acquisition by NVIDIA.
> > > No need to explain this anymore.
> > > 
> > > Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
> > > ---  
> > 
> > I wonder if we should include in DPDK a "future_cleanups" doc which
> > describes cleanups that can or should be done at specific points. For
> > example, after a specific release or date, or after we drop support for a
> > compiler or kernel version. After we add a workaround for a particular
> > tooling issue (or other change), it would be nice to have somewhere to
> > record when exactly the workaround can be removed and how/why to do so.  
> 
> It looks very programmatic :)
> Yes why not.
> 
> In this case, there was no clear deadline.
> 
> 

There still are lots of experimental API's to make stable as well.
