Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C00D7CA1013
	for <dpdk-dev@archiver.kernel.org>; Thu, 18 Sep 2025 15:16:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E09BB40288;
	Thu, 18 Sep 2025 17:16:58 +0200 (CEST)
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com
 [209.85.222.173])
 by mails.dpdk.org (Postfix) with ESMTP id 20FE84027A
 for <dev@dpdk.org>; Thu, 18 Sep 2025 17:16:58 +0200 (CEST)
Received: by mail-qk1-f173.google.com with SMTP id
 af79cd13be357-828d8d06630so123330785a.1
 for <dev@dpdk.org>; Thu, 18 Sep 2025 08:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1758208617;
 x=1758813417; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yxS6hIzCzYXa6eMy3GtnWMuV24D6ge/Kzi8chAC6mXE=;
 b=UMc8vOwfV71j8+8YE4E/d+tls1RCHeQ2pd8CK428bu+xEBLiidYaO/mNcziX7w9d7Z
 zrDe/eZLvwhUAqNUgd/w3BnoNZp7RGrPYK2E7btuetTB3UC7I+OnKQmmNIif2Xo51s6Z
 He62Bus3KfPzfkCxkPJJqU8pUVrTHqbNOGEtU6Jj/LB1CkO8ss5LvD8jkL9o4ULEr6yn
 1nVOrFVe8/Ho4yek77Y5tmC0BhD88fwaGA4QOMwZ/9I3ylX08CDihdCNNYQv7UN0Yw8l
 J+n1wNIxlxuVK/8Wm1TCeHWw6hUjg78U7GoLoFugcqXYG0wy5Mkoauz+5o7Fy3VXvV38
 lfUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758208617; x=1758813417;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yxS6hIzCzYXa6eMy3GtnWMuV24D6ge/Kzi8chAC6mXE=;
 b=Gc2XEGYNvSiafteKxUaA33zaj3m0a8JtyWwXMuBK/UBUej6CW/0Uk2lkwA5aoND2i+
 2IDRRGUIFXbJ1kZoeGISpbwAG2tEucKcTCNCxz6Qo4aWrFhRn0yKjZQMs6AhlrRH3UqK
 YnU/JKzSIhq8U7VRDsLS5a2IHLQ/S+VSEvw3NTy/WVSvSdRZNSn/4q4Luia5pkeyBCKa
 xFz6ylwzNgFvigxaKupBSp2fTDPoJsZQPdxuuiOMkHZ1GZZqM+IPub39d070I6oWDjU7
 GRZ/Y/TIV17nQOZTielGhgyc6l7TCxGWxM0HmBX0pyShgrTQTM7gHsevFRCcyQIur9G0
 r/mA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW7Sg1g0WbCZOVyeiJJXL5rJ9erVSIkTGNFPMu6qv+Y1cPX9VaAuMSvIxHsre6nXURe2aw=@dpdk.org
X-Gm-Message-State: AOJu0YyRVK3wKjDUKlMrDNyOTm/Lrsm+8XDABlUE4v4cdPfRGWxljJfh
 4YJGnvlMV1YpcUvEFVJrrzMXYsaSfDbcWhrwpUzRKBltSInhpX1m+/Br7OHkhf8c51E=
X-Gm-Gg: ASbGncu8aOZNndqqzzPhh8VVMe9lGOtfCd/C/FfcZclP/9Lk+0uOyIjDJFnGHgKg76I
 LXxHGNBr/Hk4MXcZoVTj4aPMjBp7RSmb0jIdmIWUz8mtcGZ8oo1VlPp1eqTqoaCv1PhGhMR02Ik
 xPYHx/U3PEdK+xHe0IHzZ1nsgVpcZ8NjHXbfQOAZGEyWdMHbc55H7D3Iz9aIO9dkGV9Sh8P1Q19
 1MyJWyasyIlA23ReguyRFJGYvpbCYBvqCr+0GwLddXFtH0Bef+1YZ2BjxdUzPz2Ds6s1nOev0pb
 ilSFy4mYRFtDBJBY/5dl90lwhkLJuAavddvke5ddHXKaoB18kpKmTT0TNVN2qxDAZJRXmpqtDXs
 6PK8LgDRltYySfe468sRIk2lxsF6Gd1L1KjRiqfKyUeRJbDnhKNxLI921REoVykbhrYxXbtTPjv
 gMXixwUuly3q2M8CsieQ==
X-Google-Smtp-Source: AGHT+IGPIDfFgXoLOfvk2Hjy24d6QwmEfVX87ZufkwpvfHFw+eWs1vxIq1tsnux1nzSGkYGBc/sZpQ==
X-Received: by 2002:a05:620a:a511:b0:836:974d:978e with SMTP id
 af79cd13be357-836974d995cmr273118185a.41.1758208616463; 
 Thu, 18 Sep 2025 08:16:56 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4bdaa89796csm14999001cf.52.2025.09.18.08.16.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Sep 2025 08:16:56 -0700 (PDT)
Date: Thu, 18 Sep 2025 08:16:52 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Thomas Monjalon <thomas@monjalon.net>
Cc: David Marchand <david.marchand@redhat.com>, dev@dpdk.org,
 maxime.coquelin@redhat.com, anatoly.burakov@intel.com
Subject: Re: [RFC v2 8/9] uapi: import VFIO header
Message-ID: <20250918081652.36fd3566@hermes.local>
In-Reply-To: <2776153.atdPhlSkOF@thomas>
References: <20250903072826.1727004-1-david.marchand@redhat.com>
 <20250903151800.1965006-9-david.marchand@redhat.com>
 <20250905211157.00ab0e5a@hermes.local> <2776153.atdPhlSkOF@thomas>
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

On Thu, 18 Sep 2025 10:48:12 +0200
Thomas Monjalon <thomas@monjalon.net> wrote:

> 06/09/2025 06:11, Stephen Hemminger:
> > On Wed,  3 Sep 2025 17:17:58 +0200
> > David Marchand <david.marchand@redhat.com> wrote:
> >   
> > > Import VFIO header (from v6.16) to be included in many parts of DPDK.
> > > 
> > > Signed-off-by: David Marchand <david.marchand@redhat.com>
> > > ---
> > >  kernel/linux/uapi/linux/vfio.h | 1836 ++++++++++++++++++++++++++++++++
> > >  kernel/linux/uapi/version      |    2 +-
> > >  2 files changed, 1837 insertions(+), 1 deletion(-)
> > >  create mode 100644 kernel/linux/uapi/linux/vfio.h  
> > 
> > The linux kernel source tree has a well defined method for making exported
> > uapi headers: 
> > 	make headers_install
> > 
> > DPDK should not be inventing its own method for this.
> > 
> > If you use this on current released kernel (6.16) you will get slightly different file.
> > The point of having DPDK vfio.h was to workaround case where distro was too old;
> > not to be different.  
> 
> The diff below is because of a different (but compatible) version.
> I don't see the point about the method.


The reason to use the same method of generating uapi headers
is then the guard values are the same. If some other header happens
to include the other vfio.h there will be no problem.
