Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D9FF103FFAC
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Feb 2026 22:10:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B0F044060F;
	Fri, 27 Feb 2026 23:10:51 +0100 (CET)
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com
 [74.125.82.178]) by mails.dpdk.org (Postfix) with ESMTP id BFDFE402C6
 for <dev@dpdk.org>; Fri, 27 Feb 2026 23:10:49 +0100 (CET)
Received: by mail-dy1-f178.google.com with SMTP id
 5a478bee46e88-2bdca815fdfso1112682eec.1
 for <dev@dpdk.org>; Fri, 27 Feb 2026 14:10:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1772230249;
 x=1772835049; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qAaOrC1KGJCr8ln8XYamEzM/gJGE6a4GG+iSiYESEwo=;
 b=KoxMMa7PPdXGrkas0XR0AFbV/GWFBFoucHqPRSKHanT+jFeFTrWKrK1V0aQDDeN0KP
 AG2h2ae8lMeYDgtkB+aobcGsw5udyPd8dfdNxSYMpt8YOmXpRKZICJWQAs550zu1w8SB
 Kl8rc5EWVeXa3d9BYgr280z4CCv0y20Tvyaf6BOQpHKusk2pWk8FXqKJ0OdFe1seT4ac
 vnhQa4/OBxC1FIX2joDJJHXNWf2ZBrnDQIxaAVqWm4sU8nxNSJv+TA+iI2EHQp6+7Vdg
 jqouWsdIOF/65BnjAzSjVW5gAKxH6AdntAVvhHpcxkQmhF7jwvNiiNE7WnIGRHTcfwVP
 eeFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772230249; x=1772835049;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qAaOrC1KGJCr8ln8XYamEzM/gJGE6a4GG+iSiYESEwo=;
 b=IAd1UZU4BoPJBZSQ8QeM7FT16omgPdQCaQZ6ESyyc3VCifmETMh+Kp82x3OZddTLgE
 adNqXv028/GS71pMsOZQ3BVgvdKYuzpQt0qsUSWbLTwuXURJOXuJWWiuKRMS/0y8vGyg
 ApaKVlAY6Sp3fDAeEM2tAr8wqbLW5fIDVxdjrnXpeuW3iyzedHZugxbKoYN6oYoPKbq7
 HRCR+hHccJ9Ttf5PkdiY2WvWASMgp6cu2t4YX/YgVlZhUIvEKI0dTaf4nk/MUEZilwjy
 hiuOYI1gdAkfNJXrsRYtZMzoPhk8COZgtsad6BK/e8sMHaI2bIWO6rZxGnaHD0RKhRoW
 32pw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU+BRbcwM3WG7M6o30GSvpq1mCglr775s0rAvgPruPzLyYxpgU6dDvDz4bHVtrVikGqbrM=@dpdk.org
X-Gm-Message-State: AOJu0YwDmqE0vryS1zrJ5bjpNyGeuNY9MNuBkJI011oRAzTwH1u/eSTz
 6x+3I8dNSPvTY0rvnSe1Go4XAi8jl93rd1pYkuq2/BxIA+AASYb3OP9Tqij/es1BMyw=
X-Gm-Gg: ATEYQzxzn2bg5Me90UzoXSW7G7AMGNZiz9Cc+O34YgbQIGxzZs54sjOuDLfyoCX1VtQ
 2dlVM8SaBrI1M5LQoOY4QpHxKkOj9N+iRh9x7CgSdyVjLbEEybADy1bcDjWmR1mGy3KU7JP1K2e
 eKjfD4lztvZAxjjIDYZ8cgn/wZoLwn+ok/bGRPRU5XZ2xKnoLWcLDhbJC/8+aZ8AXN0bggApoV7
 obeqEhf+iu3r+Xj27YEwX8sDN2O8aTgOFoZxZct1IOnEXfzZiYu+8RnTbwzSSSbEYlQLz5AQurG
 gXHoxc/qdlHPPqnl9o8Jcf6LzB5AacPCpQKpeQ60tp0/mWW2AigfrntvKHA9DjsaneopVTPtJGd
 /PLwGoHA5BU5sW/RgcCr8twjM9cXB2VSILVtNIWszoQFxvZSh05nq8Meco4Wz50cf8Ekuumhn/K
 96/wOuIqzMJBSj1uQUPglD1lnyh1b+4u2PPCHpfIKNBQBXnn4j+SvvKkbQVhwvBSJbkYeBr1sLd
 CA=
X-Received: by 2002:a05:7301:7c01:b0:2ba:659f:2002 with SMTP id
 5a478bee46e88-2bde1cbcc24mr1814468eec.15.1772230248660; 
 Fri, 27 Feb 2026 14:10:48 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2bdf0cd07e6sm501020eec.21.2026.02.27.14.10.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Feb 2026 14:10:48 -0800 (PST)
Date: Fri, 27 Feb 2026 14:10:45 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: Thomas Monjalon <thomas@monjalon.net>, David Marchand
 <david.marchand@redhat.com>, Robin Jarry <rjarry@redhat.com>,
 <dev@dpdk.org>, Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: Re: [RFC v2 5/5] eal: configure initial device probing
Message-ID: <20260227141045.236af55b@phoenix.local>
In-Reply-To: <aaGhdEEgxiA4Z33A@bricha3-mobl1.ger.corp.intel.com>
References: <20260225112922.3982104-1-david.marchand@redhat.com>
 <20260226162057.207202-6-david.marchand@redhat.com>
 <DGP1R1WJWJGI.1TU6RUU13GBYQ@redhat.com> <4506449.8Dcp7MaWsk@thomas>
 <aaGhdEEgxiA4Z33A@bricha3-mobl1.ger.corp.intel.com>
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

On Fri, 27 Feb 2026 13:51:48 +0000
Bruce Richardson <bruce.richardson@intel.com> wrote:

> On Fri, Feb 27, 2026 at 02:43:46PM +0100, Thomas Monjalon wrote:
> > 26/02/2026 17:50, Robin Jarry:  
> > > David Marchand, Feb 26, 2026 at 17:20:  
> > > > Some applications use port hotplug as their primary way for using DPDK
> > > > resources.
> > > > Having a systematic device probing is a problem when not all available
> > > > resources will be used by the application, as such applications won't set
> > > > an explicit allow list at startup.
> > > >
> > > > This is the case for OVS on systems with multiple mlx5 devices:
> > > > one device can be used by the kernel while the other(s) are used by DPDK.
> > > > In such a setup, the kernel used device may get reconfigured in
> > > > unexpected ways and trigger issues like the one described by Kevin
> > > > not so long ago in bugzilla 1873.
> > > >
> > > > Add an EAL option so that we can change the default behavior from
> > > > block-listing to allow-listing.  
> > [...]  
> > > > +	const char * const argv29[] = {prgname, prefix, mp_flag, eal_debug_logs,
> > > > +				       "--allow-explicitly" };  
> > > 
> > > I am not convinced by the option name. What do you think of:
> > > 
> > > 	--no-autoprobe
> > > 
> > > That would match the Linux sriov_drivers_autoprobe sysfs.  
> > 
> > The name --no-autoprobe is better indeed.
> > 
> > The exact effect of this option is to disable initial probing
> > of devices on all buses (except vdev).
> > Another name could be --no-initial-probing
> > 
> > I think we should add the opposite option as well
> > to allow changing the default mode later.
> > For such an option, --autoprobe looks better than --initial-probing.
> > 
> > Other opinions?
> > 
> > 
> > [...]  
> > > Depending on what option name we settle on, could you add a short flag
> > > too? E.g.:
> > > 
> > > BOOL_ARG("--no-autoprobe", "-N", "Disable automatic probing of non-blocked devices", no_autoprobe)
> > > 
> > > Or:
> > > 
> > > BOOL_ARG("--no-autoprobe", "-P", "Disable automatic probing of non-blocked devices", no_autoprobe)  
> > 
> > I don't see the benefit of a short flag.
> > It makes reading commands less obvious.
> >   
> I actually would prefer to have a short option available, and I'd really
> like that short option to be "-A" since it serves as the perfect addition
> to the "-a" flag to specify devices to probe.
> 
> Based on that, I would look for long options which allow "-A" as the short
> version for example:
> 
> --allowlisted-devs-only
> 
> /Bruce

Also if -b or --block-list become a no op with --no-autoprobe. So it should be a warning?
