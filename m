Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 612B5C83F27
	for <dpdk-dev@archiver.kernel.org>; Tue, 22 Jul 2025 18:22:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B26AE402DE;
	Tue, 22 Jul 2025 20:21:59 +0200 (CEST)
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com
 [209.85.222.175])
 by mails.dpdk.org (Postfix) with ESMTP id BF44540283
 for <dev@dpdk.org>; Tue, 22 Jul 2025 20:21:58 +0200 (CEST)
Received: by mail-qk1-f175.google.com with SMTP id
 af79cd13be357-7e62773cab8so56844585a.1
 for <dev@dpdk.org>; Tue, 22 Jul 2025 11:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1753208518;
 x=1753813318; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J63SIc6kqwpOo8KLLzTVpSU7qFqpgSOiZzY9sFziJc4=;
 b=HuUduTABBvj7yaogGyGhC8UyNFkBCkhA+BroI5/fACWxcIJtgSeGCxQig5V5UA2/Mp
 Pe6xeo1WBUnlcM4ZppXgi+x773vxd/gxlDNfVuuxRgX+WtS3+AlpTj60xKW95/4waTuV
 7ozRj7QPazslaMMcOu412GC4IsqEQEgkpgBnqv71nQnZAES/a8yoCGoCCdSfnwhl2FB3
 JakfaDIPmbpTO4jjYUnj6y5VRyhXVbhF0iWzPAibQ12yQTZ6Hm2DGadxd7U46EqA3QOv
 d0z5dh3blr3GjRWpdSoCc1GpApgbtkBFCFpaAZoGZH0m2J9W/X4VGjmfR9tACqnYGCwe
 1Ajw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753208518; x=1753813318;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=J63SIc6kqwpOo8KLLzTVpSU7qFqpgSOiZzY9sFziJc4=;
 b=WHgnx7enkPVQjiUKMoe+WMVYrwCZlj5LTeRRZ4voibffOCNaRiKZ9PN/u/vCzjvaRn
 ut+9oEkoyyx+arjcveA8skt/NvHu/DxAnB9IfPLHqwmS9Jp1KQejyVw//W+Mnwrv5wY4
 VDxdWjGSFpTfy7NEfJagOAvfCFwgd+0yuIgMvzJ40178Krw/Jt2b2w8v6sk/roMLW0WX
 tjWRb70NfKOA/OqIypdcaqASApbbuier1yq/Fmaf7UuvU0pM0zpZs4M6lwoPUxO+i5CE
 1hYXGD0oSSlwKyXPeLLp7ko75fLNWQMC6JQPyhPPYaVXYImeq2g2QUnxzp/2MLWVJdQJ
 4lAQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVsPPfS/KMDQEJNG5NCWyWWL3Lk/vNP/sFnfWiEbRZTFOxs/+wNfg1TMFLmqIym57nA678=@dpdk.org
X-Gm-Message-State: AOJu0YxKfk+0AcKjWqvin2zFWgzagNAluEm+K2Hck6oeeMoJzvf84SuY
 +0PEfqamfsEZWYswEqQMZhuW2KPbTyNX+7e3+VumZrk5D1vloCm3QFnQG/j6100HJjY=
X-Gm-Gg: ASbGncsLDCs8l1N2gOqEHY3cJx83yxQqiCVLDGQtc1poXTtDKDCU+nyyFVkgymWasKG
 EWuy7zqUTwC6bhXVAj3U/EOfUeHuEeQ/AWLZt1IjCg5Gh8OYdJhbBVHV1FZ1pcvhwEDDsCyeGK0
 8bhBiLs5RDp/yDQQ1ymiwUwN4KhFkKIXaSHH/Y+paVesmShMSPLXktFYyWGDEc6sH4gUymOgxtt
 vzTdlh4XLz4m7JtsdUDzaTm3KdBFVeV9OqDIf4HXd8lzXCmi8c3Mr8N3ZA6qbuyqHdvglvo6hLr
 Vlrbwys6g/dj24e82w3Dfk3AsgDIKXEhMEFEkF2CgY3L0Hxj3AU1Bgy/edZJPh6MRYH1sKAxia3
 m7VQlMWvhOPmCbKboioXL0LJH/irdhbs9ZsFTLuqrd9WSF1Z0lugYbiCSCBvl3iWWvOhqM3dIFh
 s=
X-Google-Smtp-Source: AGHT+IEUOMz2foHMNMG++/i+UyBquz9CBdu4+GWWtyUcNCYBy5eMYLDgsQYcV+DUtuft3bIDs2rvBg==
X-Received: by 2002:a05:620a:aa1b:b0:7dd:f63c:b195 with SMTP id
 af79cd13be357-7e62a1a43e2mr38399285a.32.1753208517812; 
 Tue, 22 Jul 2025 11:21:57 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7e356a0732dsm568022585a.0.2025.07.22.11.21.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Jul 2025 11:21:57 -0700 (PDT)
Date: Tue, 22 Jul 2025 11:21:54 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
Cc: Bruce Richardson <bruce.richardson@intel.com>, Thomas Monjalon
 <thomas@monjalon.net>, Ferruh Yigit <ferruh.yigit@amd.com>, Andrew
 Rybchenko <andrew.rybchenko@oktetlabs.ru>, dev@dpdk.org, dpdk stable
 <stable@dpdk.org>
Subject: Re: [PATCH] lib/ethdev: fix segfault in secondary process by
 validating dev_private pointer
Message-ID: <20250722112154.78349c82@hermes.local>
In-Reply-To: <CA++2-x69b=_+7wYaK57fv8j0F4VOsSVJ-S-yyi76Lgoy=E-dpg@mail.gmail.com>
References: <20250722115439.1353573-1-14pwcse1224@uetpeshawar.edu.pk>
 <20250722063924.2f87f3f7@hermes.local>
 <CA++2-x7VPCtojdJ7+DXdK=ohAJtLu_3U8KPxHS9CNAqzMd1hoA@mail.gmail.com>
 <20250722084225.7a40e2bc@hermes.local>
 <CA++2-x6bMRbxne_JdtSkCjVmAPMsY4762xzDbqPhqq8K8695EQ@mail.gmail.com>
 <aH-4xyH45rElgVb0@bricha3-mobl1.ger.corp.intel.com>
 <CA++2-x4+3QE+EOCdUcX8go27Z0tqrb4Br1MADQEiu=q3GgRpPA@mail.gmail.com>
 <20250722103824.7c9db0a0@hermes.local>
 <CA++2-x69b=_+7wYaK57fv8j0F4VOsSVJ-S-yyi76Lgoy=E-dpg@mail.gmail.com>
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

On Tue, 22 Jul 2025 22:53:08 +0500
Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk> wrote:

> Right, but performance and reliability are both important. While DPDK
> rightly prioritizes performance, some level of reliability should still be
> ensured, especially to catch known issues that could lead to instability.
> 
> On Tue, Jul 22, 2025, 22:38 Stephen Hemminger <stephen@networkplumber.org>
> wrote:
> 
> > On Tue, 22 Jul 2025 22:04:32 +0500
> > Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk> wrote:
> >  
> > > Agree, but I think it's also a good practice to guard against known cases
> > > that are prone to crashes.  
> >
> >
> > Right but DPDK chooses performance over API safety.
> > For example rx/tx burst doesn't check args.
> >
> > The point is that as a library, if application is doing something wrong
> > returning error doesn't always help.
> >  

The problem is that all those values dev->data and private are shared
between processes without any locking. If the API's are going to MP safe
then they would require locking. The DPDK has made an explicit decision
to not use locking in ethdev control or data path.

You can get away with checking for dev->data being NULL on x86 where
there is data consistency. But on weakly ordered platforms that is not going
to work.
