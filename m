Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21AA5C88E53
	for <dpdk-dev@archiver.kernel.org>; Fri, 11 Sep 2026 16:26:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1F69942DD1;
	Fri, 11 Sep 2026 18:26:21 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 6FF0C42D35
 for <dev@dpdk.org>; Fri, 11 Sep 2026 18:26:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789143978;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vGI+e1/7WhF/FQxRj69k4+M6SH3OSvyenGlyD76mtFY=;
 b=RsW/w4yFvlzI+IryRUK+GnsUItevz1XxkE0ROoHlCGSfm6htTs0APiSXJ4NM9+WNX69tvk
 3IaITLvrjvmQ/ADxdaWeiQ5bWcfKiHgEpE/3d9+MDea48C/oyXij1/nYXVqPqNKuUt/wFV
 BvQ9pNqFBM4PXJRL3VevAS8CT/gWa0I=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-294-KZKkeloPPvywk0UaYMsQ_Q-1; Fri, 11 Sep 2026 12:26:14 -0400
X-MC-Unique: KZKkeloPPvywk0UaYMsQ_Q-1
X-Mimecast-MFC-AGG-ID: KZKkeloPPvywk0UaYMsQ_Q_1789143973
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-3a33567d27dso5211871fa.2
 for <dev@dpdk.org>; Fri, 11 Sep 2026 09:26:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789143973; x=1789748773;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=vGI+e1/7WhF/FQxRj69k4+M6SH3OSvyenGlyD76mtFY=;
 b=rAo9jKY3k28YNqhz/TEqS55Vu0XaVzSumT4rltQo+6PU5kJ79ez8q+Q5Z/vpmxhDjw
 LB9dM9rbPljBc3+MbxoMFm+AlagSNaQJ6STsCan+zKot0w7NZuVAc47xI3W/jwn4D49P
 DS7j8072FLJ02JhLO6GZWgwEddZMMLq5vrhRqd0gyEkhkcoWTtvUJsenw4aWaYIhtyZB
 QZ6Bev9tCkAZYILRlh9PT6cc1rmqEtttvIi+NcCO75L0XYpb3j7eZ/Iqloy9RAI0OPTu
 RYqVSWImqJILFWY586VdvWWgJWAM4X5iNOEd2yTAL/N2MuGfOghIeiao1TSp3LrAm5pP
 r34g==
X-Gm-Message-State: AFuF++nVdAe8BCX9p1aV+eN+WKyGWIrrkG3HmcV6DNICnJOQkyOTXQbv
 AJcY90ZZzkMks2gdluQtPj0HJm5ZJh1ftTQ0Bh3eoow20777IJqup/Zpo4DKtyzaMEz9vZtOhFb
 +g3r45KzxSKj+IIwNaSdpEgXzAkTkShPpEcM5/LCuaW6aNprgY2sZfml1rsU5ggaM9xH0SXtzJ2
 EST+MkGpMDyrMU8X/xXsY=
X-Gm-Gg: AYBFou1nYVSLUyppBQvl4dRg7pqMROPeBCHsryssl3zITj0doMdzSTp6ngfUY91G3fw
 +oSRcjBImZaOdQFGYzarokaCg/iu/z3qydj+P8fueVzVnREByTQH3iQfYR129KEW98hSFTogE7n
 1ZxnkYe4Df+rn5wDpcG4JaS9kiwhXWM7+reAr7fzn2xZjlGecldZbC9XiUTwR0B/qTAc4hlSP9a
 cpwuWnnBjxsIGpEuMxdrIS1eiE/2TpzIUzXKdRwKj6fIGV+
X-Received: by 2002:a05:6512:3e24:b0:5ae:bbd3:27e3 with SMTP id
 2adb3069b0e04-5b8a0280f13mr1146080e87.5.1789143973417; 
 Fri, 11 Sep 2026 09:26:13 -0700 (PDT)
X-Received: by 2002:a05:6512:3e24:b0:5ae:bbd3:27e3 with SMTP id
 2adb3069b0e04-5b8a0280f13mr1146069e87.5.1789143973008; Fri, 11 Sep 2026
 09:26:13 -0700 (PDT)
MIME-Version: 1.0
References: <20260403091836.1073484-1-david.marchand@redhat.com>
 <20260904122804.2256481-1-david.marchand@redhat.com>
 <20260904122804.2256481-2-david.marchand@redhat.com>
 <IA4PR11MB927840F83DA2372511FE1CFF8EB02@IA4PR11MB9278.namprd11.prod.outlook.com>
 <CAJFAV8wutDRxg8jf01VPC1Bgr=2vUYXjQ_Yzo5GnLbUWD-XGjA@mail.gmail.com>
 <CAJFAV8y7GrUQqk8aq=oS6GD50F85U19fBrbh4nCFOstCtbGBjA@mail.gmail.com>
In-Reply-To: <CAJFAV8y7GrUQqk8aq=oS6GD50F85U19fBrbh4nCFOstCtbGBjA@mail.gmail.com>
From: David Marchand <david.marchand@redhat.com>
Date: Fri, 11 Sep 2026 18:26:01 +0200
X-Gm-Features: AcwNN1Uzj5OkJ4zhV_RR3jKLpsneKWQxw30xo2B99Hf_3TwpzlbbMnxY_BC-7_0
Message-ID: <CAJFAV8yXjCi8qU_e9dopme_B0hvRJePSsGS-B3Ugp2kP2N_5rg@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] net/iavf: fix duplicate MAC addresses install
To: "Loftus, Ciara" <ciara.loftus@intel.com>, 
 "Richardson, Bruce" <bruce.richardson@intel.com>
Cc: "dev@dpdk.org" <dev@dpdk.org>, "stable@dpdk.org" <stable@dpdk.org>, 
 "Medvedkin, Vladimir" <vladimir.medvedkin@intel.com>, 
 "Burakov, Anatoly" <anatoly.burakov@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: TvG6GqKwJXMAuTSaP2Ny0b47SvI11YuXnBiWRvMMb8c_1789143973
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

On Fri, 11 Sept 2026 at 17:37, David Marchand <david.marchand@redhat.com> wrote:
> Interesting..
>
> It's been so long I started touching this code, I am not sure at what
> I tested now...
>
> It seems I found a leak of the mac address array on VF reset.
> iavf_dev_uninit + iavf_dev_init results in overwriting
> dev->data->mac_addrs right?
>
> This should break the mac restoration during a VF reset, regardless of
> who does it, the driver or ethdev.
>
> The multicast addresses look unaffected, as those are stored in the
> iavf_info struct.
>
> I could copy the mac address and reinsert the mac addresses during
> iavf_post_reset_reconfig...
> But I think it is simpler to just check eth->data->mac_addrs state in
> iavf_dev_init.

I think I'll just embed this array in iavf_info, which already has the
multicast mac addresses.
That will just work.

I just need to carefully sanitize dev->data->mac_addrs before
releasing the port.


-- 
David Marchand

