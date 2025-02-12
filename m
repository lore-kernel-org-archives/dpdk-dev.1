Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD4F5C02198
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Feb 2025 15:02:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B42A642789;
	Wed, 12 Feb 2025 16:02:39 +0100 (CET)
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com
 [209.85.214.175])
 by mails.dpdk.org (Postfix) with ESMTP id 318C14111B
 for <dev@dpdk.org>; Wed, 12 Feb 2025 16:02:38 +0100 (CET)
Received: by mail-pl1-f175.google.com with SMTP id
 d9443c01a7336-220ca204d04so4763335ad.0
 for <dev@dpdk.org>; Wed, 12 Feb 2025 07:02:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1739372557;
 x=1739977357; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MEb6pdudpk4ciNoT65itChB7oPCPy3PGJHQxe4un7Y8=;
 b=SQPSyPJCSKM4XKepzfBcEJaeIhRlTV6jr6CzYyozg1WHi5Zuf/IM0tQYFy5asaKjfy
 d4pDE/+nHeMf2FS1XlxVBxITB+Jv0bJaxthjgTfDm9qHxQZ2XmKEiLP3FfWKuTbgd8Oy
 7GJkw5h16TR+f2pca2zKtB6J2dnY4Ot4bg0pZUbYzWtNx34W/XNl/c+OcGnQmlQB186h
 XUKkma6Z3lrZCwzEvGJm5W3liplp3fdGcbU1XtwPEfnfKfHamZxqT87iniE82G6wjfRC
 rHPCnt04j1YE5taJBgF53SFMuCOd9I0PxIHX3PwHlAKlRK3om87xfRkAKoFoL4EX/I6t
 2keA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739372557; x=1739977357;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MEb6pdudpk4ciNoT65itChB7oPCPy3PGJHQxe4un7Y8=;
 b=l/4+rvYMoicTRWDmn/u1t5HiUSqCXFhDOuQ7Bi1SYMF2V69Ih3UtzZIxGuuVErYp2j
 n1kbWRaxkPtPk2zAcOqJfxviEJCdqroVY1DI/50seOtmBGa/ilA5+wLaIjBNgseu1m0L
 PYOpTpLWIjBh23gyKmqrzi/0NNz3AfwEBuXLWfQPki5mxj2d+gBuXdmT/Ys7Jl5CyZWI
 N2fdGcSN8kCD7UANFQUD9T2paKlxzs9p1gjgEQO+0S9C0VtBrBi0Co9A39vDkZFwbIGF
 usxMSMHGNrzh7+gc6pRCOgQZ/LKqJF+L6jTliMQ+okjg45aQaxs9LApxdljAwm/ejQIQ
 ryqg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVDVMMuRlL0Ei8Qv7Z4bX/uFBc4+DsQaY/6UrSW8qlYxWdy3IfBq+BQKtM48OCba/GwQ8E=@dpdk.org
X-Gm-Message-State: AOJu0Ywczx6gq24q7/MUhMLM2sUC/jD2W+SEnVOjiWvp5aoOH3OrEJv7
 rx2hBTuKDsXTUU+E3Qt+4/0t2cFKPgcEZKNy+hLnoElVr1MckjCMl3Fe/PAmJv8=
X-Gm-Gg: ASbGnctcVsv8VuVSUO5FImT+d5WkNNX7KQ7EPQVVKrwu2WRLUSRqi7jiJPVObYG05FN
 FHZwEVjVQHeWwWXtLHOlVnnqpgLpjEwE2SfIoBhMyYSxvWUmJWM+fh44+qJEHSU/TXQW0uByrrY
 hSoO10XenMjTh9IGzKN9gWQTuT88V1GeXo42p3duJuN0iSsZaeLFbwPp2V5QSpr4dLaxe+/bVhJ
 /S3LozlibmVxhvI5sG84GlRJjtzN7m9OHscTtaW+S3ZTzEFyNXSj8l92hcIo1dz9BFMG3RExkjX
 GVpV0K31sjOXd6KKoV+fMkBXo4zeKZ7+5xfgcuU9/f5xqdbUPYgE52usE35jRq7IV/DJ
X-Google-Smtp-Source: AGHT+IHfiMI8bnItaCXKejVYLr8TIRUVqbMhUUqqeq5lC/LzloM+P/HKQhEg2IW9rxBWMwlPbi5Tsw==
X-Received: by 2002:a17:902:e84c:b0:21c:1140:136c with SMTP id
 d9443c01a7336-220bbaae91dmr47819225ad.3.1739372557080; 
 Wed, 12 Feb 2025 07:02:37 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21f368cf8acsm114363855ad.248.2025.02.12.07.02.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Feb 2025 07:02:36 -0800 (PST)
Date: Wed, 12 Feb 2025 07:02:34 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Navin Srinivas <g.navinsrinivas@gmail.com>
Cc: bugzilla@dpdk.org, dev@dpdk.org
Subject: Re: [DPDK/other Bug 1562] dumpcap captures all available network
 interfaces when specifying any PCI network interface
Message-ID: <20250212070234.7f69425e@hermes.local>
In-Reply-To: <CACOt6jyPUfBPaX7t4rYde8dTgn9-we38s7WYFrrYx0iOyOC7FQ@mail.gmail.com>
References: <bug-1562-3@http.bugs.dpdk.org/>
 <bug-1562-3-P2fNaCPFLO@http.bugs.dpdk.org/>
 <CACOt6jyPUfBPaX7t4rYde8dTgn9-we38s7WYFrrYx0iOyOC7FQ@mail.gmail.com>
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

On Wed, 12 Feb 2025 13:29:57 +0530
Navin Srinivas <g.navinsrinivas@gmail.com> wrote:

> Hi,
> 
> Is this backported to 22.11.1?
> 
> Thanks,
> Navn Srinivas

No, it required a couple of other patches related to management of network interface list.
