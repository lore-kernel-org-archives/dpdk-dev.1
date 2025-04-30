Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23B67C3ABA9
	for <dpdk-dev@archiver.kernel.org>; Wed, 30 Apr 2025 16:51:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4FA5B402B1;
	Wed, 30 Apr 2025 18:51:53 +0200 (CEST)
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com
 [209.85.214.170])
 by mails.dpdk.org (Postfix) with ESMTP id 795EA402A0
 for <dev@dpdk.org>; Wed, 30 Apr 2025 18:51:52 +0200 (CEST)
Received: by mail-pl1-f170.google.com with SMTP id
 d9443c01a7336-2260c91576aso429165ad.3
 for <dev@dpdk.org>; Wed, 30 Apr 2025 09:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1746031911;
 x=1746636711; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NpTIt68JDskDoOLlKi50Sl4n348ZrYh9gh3Z2DInT4g=;
 b=Y7nlE5ds+u7RRh4rx0rm1r6XFcqZOyfPjeCAYv455Yka7v4j4HV+BtnygnCJNTiuwD
 pK3UtNMZaWWFb1XTYRyiQB/3w5OIvpIwoQBtYRiF3xxTtxaShN2Kg/5S9tqceW6WjD0u
 WpmkCMsWGKJ2Uvy5P7YFGqIpKw0VIDwzBy0e/GQ5ft6G3BAK800oWkSUTdDWw2ut+aqc
 mbQMA1RGxpNKzJybCpjMHEhhdIa21yniLx511kqX+KcTR1d6qI5mgBhyeQmKZOT/Fd5S
 TTqfy/UrjTUExXV0AGjST5GvAHrUz4Jr+BIqiyjK+vNYx3Be3crbGDqChN42gqeXH2oU
 WBHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746031911; x=1746636711;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NpTIt68JDskDoOLlKi50Sl4n348ZrYh9gh3Z2DInT4g=;
 b=YVDVe6Vkd9CnURTM+p417vozKfYn7wfhtqL0rPnezCNQXV2jFP8fixwHAOuXqbwKZ7
 NLAtewwr9mVWoz5Jc0hrNZ95V4DY5HdWJWuPvPp7bXaiAXSrh3z4rhd1qL0Xa+VkQFx3
 J+HGt/HFr5Cs1XCj/HkSW5s+RSxOHxRuP5xgZsM3JYR+WaEB/BydWatzP8toWR0Fs25V
 b7J3rdla/ITWRw3Ztx6hWrhWe7PCSAB+uFyQBFMCmwvaaMUQFNvqT/AWpb1PwPGFPIFJ
 aFDpT3rXF5icfycxi/jEqvDqUL3WvD+PNhBeyr9fCAya4X16+bQxRUxpV+bKXPGInjbG
 S5cw==
X-Gm-Message-State: AOJu0Yzk+ynWe8Xf5l8+dc2DYiaiX8IXRhJnrnoh5xyV5Mv+727RqQQx
 DAkY3tGt41jms+/j+VptInL8QdmF3x/YSvKUOB4yqAyTT0NUkSf2Ds7hmWEBwc4=
X-Gm-Gg: ASbGncvHyz3HUapmWMAqPt5lPWg2HgkHEua6wmIcnDyUk6MU0W0P6xXHUBtTky6uhaI
 rYOkOzqUg+tyi1PAinUW7XLL1hEL4EI/MpQY/+mLY2yGB4i4poo3oVoeEtmwq78S5PL9sCVWv4T
 Gm/MkrMdKHtR+xE2HA7Afha89drFC04FHqvMrlPZSKYg2wf8nqvfWk9lAQfTAan4XC+pHIOELHE
 9qnCiaOn0v27Cr5j4HjF10p9/PC5OoNnONUX6GJzfhLp/f7CwLAozAyioAk91h+CBWgvmyo4PwW
 B3dI0mrrLQPimb5vSQH+dVtItogHhsT6lWkE1TfdeAp7KadKuzJqffeIVb2BB3WoJgSL6Aohhlu
 3GLs5ryEnb7+sMFo5
X-Google-Smtp-Source: AGHT+IFgf0TB+SYy8WDnU1vVV5i6DU4QE++I7bJoRsjhjYBblEH+/XCf26KVIaYdUHpGdX32Vby3ZQ==
X-Received: by 2002:a17:903:1cf:b0:216:53fa:634f with SMTP id
 d9443c01a7336-22df58624f2mr57820685ad.48.1746031911485; 
 Wed, 30 Apr 2025 09:51:51 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22db5216c35sm124899655ad.233.2025.04.30.09.51.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Apr 2025 09:51:51 -0700 (PDT)
Date: Wed, 30 Apr 2025 09:51:49 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Prashant Upadhyaya <praupadhyaya@gmail.com>
Cc: dev@dpdk.org
Subject: Re: Regarding Mellanox bifurcated driver on Azure
Message-ID: <20250430095149.5c08e08e@hermes.local>
In-Reply-To: <CAPBAu3WPaMMErEfbVtKBsd7n-D5GGLGYARex_dURxWtrMmTtXQ@mail.gmail.com>
References: <CAPBAu3WOch_LYAUp_R47-=Uaos1yJLKgpRBM1ewJ+vaRysCDCQ@mail.gmail.com>
 <20250426082843.736964ba@hermes.local>
 <CAPBAu3WOq6_77mBvd=B8x2tso9hWpjFTyUuEeJgZazSm_y_GHQ@mail.gmail.com>
 <20250428083712.50b2e7ce@hermes.local>
 <CAPBAu3UDao48OmcnEMQw9-W3pesM1W2ftQsEG3EtHDxxOXCc=Q@mail.gmail.com>
 <20250429092415.2a37c090@hermes.local>
 <CAPBAu3XDwr82ghjdhK=QXO53OPH3MgUtkP7r3TLEwOnHe_St5w@mail.gmail.com>
 <20250430072825.13ceae3e@hermes.local>
 <CAPBAu3WPaMMErEfbVtKBsd7n-D5GGLGYARex_dURxWtrMmTtXQ@mail.gmail.com>
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

On Wed, 30 Apr 2025 22:00:29 +0530
Prashant Upadhyaya <praupadhyaya@gmail.com> wrote:

> On Wed, 30 Apr 2025 at 19:58, Stephen Hemminger <stephen@networkplumber.org>
> wrote:
> 
> > On Wed, 30 Apr 2025 13:00:53 +0530
> > Prashant Upadhyaya <praupadhyaya@gmail.com> wrote:
> >  
> > > > With DPDK on Azure, an application should never use the VF directly.
> > > > It needs to use either netvsc PMD which handles both the vmbus (slow  
> > path)  
> > > > and VF (fast path) combined. Or use the older vdev_netvsc/failsafe/tap
> > > > combination.
> > > > The latter uses a virtual device to make a failsafe PMD which then does
> > > > a combination of TAP (via kernel slow path) and MLX5 VF.  The failsafe  
> > PMD  
> > > > is what is exposed for application usage.
> > > >
> > > > The limitations are not explicitly mentioned in the documentation but:
> > > >   - don't use VF directly in application
> > > >   - there is no support for bifurcation where some packets go to kernel
> > > >     and some to DPDK
> > > >   - there is only very limited support for rte_flow; that is with  
> > failsafe  
> > > > PMD
> > > >     (not netvsc PMD) and the limitations are that the emulation of  
> > rte_flow  
> > > >     in the TAP device only supports a few things.
> > > >  
> > >
> > > Thanks Stephen, the above information was very instructive.
> > > If I do use the Netvsc PMD with the latest DPDK, will my DPDK app get the
> > > non IP packets like ARP, please confirm.
> > > I quickly tried the Netvsc PMD but don't seem to be getting the ARP  
> > packets  
> > > in still.
> > > When you mention "The failsafe PMD is what is exposed for application
> > > usage", what is the meaning of this, are the apps expected to use  
> > failsafe  
> > > PMD, please suggest.
> > >
> > > Regards
> > > -Prashant  
> >
> > ARP handled differently in virtual network environments. The ARP packets
> > sent
> > get consumed and replied to by the network infrastructure (in all virtual
> > networks
> > not just Azure). Non-IP packets always show up on the synthetic VMBus
> > device.
> >
> > Current docs are here:
> >
> > https://learn.microsoft.com/en-us/azure/virtual-network/setup-dpdk?tabs=redhat
> >
> > See vdev_netvsc for picture.
> > https://doc.dpdk.org/guides/nics/vdev_netvsc.html
> >
> >
> > Thanks again Stephen. I finally was able to run the netvsc pmd and it is  
> detecting the ports.
> However, for every accelerated networking interface of Azure, it detects
> 'two' ports. This is presumably for controlling both the slow and fast path
> ?
> This poses an issue for my app as it wanted to see only 'one' interface in
> its control as a lot of business logic is kind of tied to it.
> So a question -- am I observing correctly that DPDK, in case of netvsc,
> will enumerate two ports for each accelerated networking interface ?
> 
> Regards
> -Prashant

The hidden VF interfaces are "owned" in DPDK.
If you use the standard API's in ethdev it will skip the owned interfaces.

/**
 * Macro to iterate over all enabled and ownerless ethdev ports.
 */
#define RTE_ETH_FOREACH_DEV(p) \
	RTE_ETH_FOREACH_DEV_OWNED_BY(p, RTE_ETH_DEV_NO_OWNER)

