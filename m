Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C26AC83F17
	for <dpdk-dev@archiver.kernel.org>; Wed, 23 Jul 2025 14:22:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A7D3F40E26;
	Wed, 23 Jul 2025 16:22:21 +0200 (CEST)
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com
 [209.85.222.179])
 by mails.dpdk.org (Postfix) with ESMTP id 2B32E40B9B
 for <dev@dpdk.org>; Wed, 23 Jul 2025 16:22:20 +0200 (CEST)
Received: by mail-qk1-f179.google.com with SMTP id
 af79cd13be357-7df981428abso1027270985a.1
 for <dev@dpdk.org>; Wed, 23 Jul 2025 07:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1753280539;
 x=1753885339; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sMIY+v12LWv+uNEv8Ae1KGBiALOAH7r5nEeDZUKiDak=;
 b=IGUnMkecrUOgmF5NDj1FEP7LoPY7shrFdQwwhg3n6S9QvFMFGr5a6/p7Kss7Hgb+ND
 5K/2R1t/XkgwjgKNN1HRsG7MFJJ5Q6ici/0//siJHzGaw6TQSXqBnQKwvmKKI/5KD3Sf
 9FvmD9DcbirijPxQeSHSAbnm8p7t444C0IJF9X+jwk4DCeA2K2vETOuGVXGib490jRNW
 iHY3Hw+zR9TVAGVJ+aIMxbFZJgOvk0i3XcXoLcksau3ssZ2Zt9TONa+sEiJlgou2aGB6
 H8X8ltufxBGHXAd/KUUwctJ6JIonCHvEEr5a8N4XKzkZKP87gW3eqnah3WWjR63WQ6Lr
 9Ayw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753280539; x=1753885339;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sMIY+v12LWv+uNEv8Ae1KGBiALOAH7r5nEeDZUKiDak=;
 b=jV/c7KoM7xHIMxTqrfGJY1nt62g5Xtvi1Qgvtuh1s0gsla8sQlNfxl35bTZobEo+dg
 Ot/uv5VKXHz7vJZGhOJO2Al+kNT4EYWSULtpLi+dfABKuDfgVG3AWKmZBAxMqEzDz3ML
 OkjL0HruBa2YuxSlRhXBE7dPYWUu3nxf/sYJ5Ge4PUwxuJM3VAVG5R0oEMtl7y/ax/4g
 s41mw3EOemNFbeDBxhvK0voAgcaG3QaqFLnndgR0R0sm9nTRqRB7/VU6Xsi4xoCxVcHe
 BIUqizlODJVjoom1mR9HJNm+2Niw0dx7J1J9DDjwF18/ad0Yi6cLZx3okYAHQl8cDmgS
 Mpsg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV/ztqbxHlhh2nwHHuSBEjhAubTC0itwPEDGevgqCPw7OIBHvvnkKwGeeyKFTczLvo1uwo=@dpdk.org
X-Gm-Message-State: AOJu0Yz2rvc9qG28auiVP57mjwskz0fx48sGoC/7RRPfHszS0+ff1H2R
 qoSs0YhHV39iyPEwY9T35Bs7+ZzsK+hAVPb7nTSoBAZurFkWGAkRBDsayEl9qSuVAJ0=
X-Gm-Gg: ASbGncvwY8lmPwe9+cXPkE9V+7cPacZftjkpKAG223F4+rQetOOGZ4ythLpL1Cv3fBD
 GKmgHRXb1zEY3Fz4CIGThkH2wqZgVYOIpZGRAm8SI7HwfQWeG4XtWzauHF4brej8jS44P5MOUiY
 JKiVCgaZChjcP0w0EDLQdE7zLX3r5AT9wGkvP2XqNqshezQ8bZTNrSxQv75wJMDM9BMG7bH3bqN
 2DbBvL8Dat904v0NbYklPle80g1+a041AFXPUxXGpBHhTG/r0NuQFzemg5+w0pYjULdc6Hb3eyX
 6KuykzuQBUsz2luW/Hm0RYG/o5jQ+mH0fZGaQaDAyRav3P8FBT6TJ8T6L8+n0AFs6/fIBpO8pqF
 QLusYQnZfHqGJl5+CWj2fGjTCPzNrLT3zysKJXTlDKbo4aSHGoVODr3zjCWpdnf/jv60X+ELb0X
 x8w7l4RSS74A==
X-Google-Smtp-Source: AGHT+IGwbFQrzUtPsl8FNfwbUuEbdQoypGkMSPpi8n+/oq0jm8m6JI5mLeTRQC0oKUyY0t02ao7cDA==
X-Received: by 2002:a05:620a:720a:b0:7e2:3a27:a10b with SMTP id
 af79cd13be357-7e62a18980dmr303927985a.51.1753280539437; 
 Wed, 23 Jul 2025 07:22:19 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7e356c61497sm661459985a.80.2025.07.23.07.22.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Jul 2025 07:22:19 -0700 (PDT)
Date: Wed, 23 Jul 2025 07:22:16 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
Cc: Ivan Malov <ivan.malov@arknetworks.am>, Thomas Monjalon
 <thomas@monjalon.net>, Ferruh Yigit <ferruh.yigit@amd.com>, Andrew
 Rybchenko <andrew.rybchenko@oktetlabs.ru>, dev@dpdk.org, dpdk stable
 <stable@dpdk.org>
Subject: Re: [PATCH] [PATCH v3] lib/ethdev: fix segfault in secondary
 process by validating dev_private pointer
Message-ID: <20250723072216.5a34b44a@hermes.local>
In-Reply-To: <CA++2-x6bEQ+rjaddbyQLVTZTpy_4kUn12jmpXew9T=b0BjqSdA@mail.gmail.com>
References: <20250723045022.1580829-1-14pwcse1224@uetpeshawar.edu.pk>
 <20250723131049.1703172-1-14pwcse1224@uetpeshawar.edu.pk>
 <0792a0e5-dbbf-f3bc-527b-2fe7d33e8822@arknetworks.am>
 <CA++2-x6bEQ+rjaddbyQLVTZTpy_4kUn12jmpXew9T=b0BjqSdA@mail.gmail.com>
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

On Wed, 23 Jul 2025 18:34:04 +0500
Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk> wrote:

> Hi Ivan, agree. I think we can atleast currently guard all the known
> crashes.
> 
> Sure, I will check the macro and get back to you.
> 
> Thank you!
> 
> On Wed, Jul 23, 2025, 18:19 Ivan Malov <ivan.malov@arknetworks.am> wrote:
> 
> > Hi Khadem,
> >
> > On Wed, 23 Jul 2025, Khadem Ullah wrote:
> >  
> > > In secondary processes, directly accessing 'dev->data->dev_private' can
> > > cause a segmentation fault if the primary process has exited or if the
> > > shared memory is no longer accessible.
> > >
> > > Secondary application not only breaking on device closing,
> > > but also getting segfault when we do "show device info all" from  
> > secondary  
> > > after primary closes.
> > >
> > > This patch adds safety checks while using rte_mem_virt2phy(), with an
> > > unlikely() branch hint to minimize performance impact in the fast path.
> > > This ensures 'dev_private' is still valid before accessing it.
> > >
> > > Fixes: bdad90d12ec8 ("ethdev: change device info get callback to return  
> > int")  
> > > Cc: stable@dpdk.org
> > >
> > > Signed-off-by: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
> > > ---
> > > lib/ethdev/rte_ethdev.c | 15 ++++++++++++++-
> > > 1 file changed, 14 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/lib/ethdev/rte_ethdev.c b/lib/ethdev/rte_ethdev.c
> > > index dd7c00bc94..343e156a4f 100644
> > > --- a/lib/ethdev/rte_ethdev.c
> > > +++ b/lib/ethdev/rte_ethdev.c
> > > @@ -4079,6 +4079,13 @@ rte_eth_dev_info_get(uint16_t port_id, struct  
> > rte_eth_dev_info *dev_info)  
> > >
> > >       if (dev->dev_ops->dev_infos_get == NULL)
> > >               return -ENOTSUP;
> > > +     if (rte_eal_process_type() == RTE_PROC_SECONDARY &&
> > > +             unlikely(rte_mem_virt2phy(dev->data->dev_private) ==  
> > RTE_BAD_PHYS_ADDR)) {  
> > > +                     RTE_ETHDEV_LOG_LINE(ERR,
> > > +                     "Secondary: dev_private not accessible (primary  
> > exited?)");  
> > > +                     rte_errno = ENODEV;
> > > +                     return -rte_errno;
> > > +     }
> > >       diag = dev->dev_ops->dev_infos_get(dev, dev_info);
> > >       if (diag != 0) {
> > >               /* Cleanup already filled in device information */
> > > @@ -4307,7 +4314,13 @@ rte_eth_macaddr_get(uint16_t port_id, struct  
> > rte_ether_addr *mac_addr)  
> > >                       port_id);
> > >               return -EINVAL;
> > >       }
> > > -
> > > +     if (rte_eal_process_type() == RTE_PROC_SECONDARY &&
> > > +             (dev->data->mac_addrs == NULL)) {
> > > +                     RTE_ETHDEV_LOG_LINE(ERR,
> > > +                     "Secondary: dev_private not accessible (primary  
> > exited?)");  
> > > +                     rte_errno = ENODEV;
> > > +                     return -rte_errno;
> > > +     }
> > >       rte_ether_addr_copy(&dev->data->mac_addrs[0], mac_addr);
> > >
> > >       rte_eth_trace_macaddr_get(port_id, mac_addr);  
> >
> > I see one more API has been augmented with the check. But community
> > members may
> > still argue this is not robust, as many other APIs will also fail. So,
> > even if
> > the task was to augment as many APIs as possible with the check, then the
> > check
> > would still be required to be factorised/generalised somehow. What do you
> > think?
> >
> > Please also note that there are already macro invocations in many of these
> > APIs,
> > for example, RTE_ETH_VALID_PORTID_OR_ERR_RET. Could be convenient.
> >
> > Thank you.
> >  
> > > --
> > > 2.43.0
> > >
> > >  
> >  

No top posting.

How are you monitoring the primary? Lets fix that
