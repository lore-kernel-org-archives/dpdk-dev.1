Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50192E9B369
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Mar 2026 11:13:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7B465402B0;
	Mon,  2 Mar 2026 12:13:35 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id BBC0B4028C
 for <dev@dpdk.org>; Mon,  2 Mar 2026 12:13:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772450013;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Oy0ZF4Gmb2cVFv4EJArGmHfHp44PHtAM/xW+bHqmVW4=;
 b=Bw5bBlAtA7qvDHeov9KkDmFwpWuRYlxr1O2yGhA2JQnGzYx6xK+2lY8p9ZTwl4Ma1/dS1E
 S4wwGuphrMqwt/HSyQ48t0/hBhJ4VHnMSm4INJ+5nU0NQLeRdy4h/7olZSy7lBGrKGtcYC
 5Y7hBecBvSxCa4PpxcZzTVYDLRct4c0=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-501-ZgYBPD35O0auhguBpyTTEw-1; Mon, 02 Mar 2026 06:13:32 -0500
X-MC-Unique: ZgYBPD35O0auhguBpyTTEw-1
X-Mimecast-MFC-AGG-ID: ZgYBPD35O0auhguBpyTTEw_1772450011
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-389e8532376so46321671fa.1
 for <dev@dpdk.org>; Mon, 02 Mar 2026 03:13:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772450010; x=1773054810;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Oy0ZF4Gmb2cVFv4EJArGmHfHp44PHtAM/xW+bHqmVW4=;
 b=ib8dkDfqC9++ZEcIJdCIlKlf0nZAwcpgP8WMTZ7YIA+eWYgQCbjbAqSP9ZqK30Y5g/
 d+IiZBTEkLl3Tt7RAHCVdLdm/a3sAbIsLLHsjj5MYKuoaZFl2fC7a/P48Fd5opXzr2dP
 CrXXLsBukRKp24U4fYt+PWobSIFQKEO6zc0QIcjrfsbFTd8a7VxdYCZjxVHVeJXRotHp
 vtfP/s/kLQGGU0TxLEb1i134BH91dIVXYII72GHummwfFus8DbkO2lv78/iIOqPqSFim
 0+NBrjXMyZsWi/sxCd3RpB4WDvS9YmRETGPesd6Fs7g6sv2XEb1iXH4w+NZH3pHktpKU
 0u2g==
X-Forwarded-Encrypted: i=1;
 AJvYcCU2T12LT4jGzlxcTXo21b+x5Z34AhTEdO9Q5w7hHRgTg6PPVXAC7uMJSf4D8/yIJGkF0M0=@dpdk.org
X-Gm-Message-State: AOJu0YztcQxY/KeTAWuzks0t0Fvdx13H1EraGLmrugAeC3URfPWQpiTG
 EJQuFbHzgu9EmdgdRfg1+hKQcQOFXbt2e6Pyemz6l+mQA5oW34/oNR0VlTsYFh2WTtuJGx+u5qE
 asS9u8IcE4kxPRKGA7VNgPSPfl64I/Cxi7QoYy4xx3Sb01fsU/lnCgsz81smgS/UTo6s9h1dzff
 38m5wbaYvE+sjjO/bVPXU=
X-Gm-Gg: ATEYQzwHJqxIflvTfqltPAu7cJ9omCqcNM+xvp0DxY4mdPSt3gfLPiXH3Mc6ac7xRtH
 3YtYUM76qBmuvmLn4oHP4IoJbifp/VeOKdVZ/8x0s8kob3p5ni2dg7x6S4NiD140+qxEl3DrwXW
 rmwIpQnBLNtjAouVc00037xTd0oXgBRGWZ7R0IV/Pr5ptLMTraRYrW6xEaObmAhHvLtvMoywqzy
 5tQ/IIiKx3xz4XuIfJjf0PAXXlWPygVjCfytq09k+kiMgfCIsIDLSVQDO1SXQgYWGgApA==
X-Received: by 2002:a05:651c:25d5:10b0:389:fc6b:943f with SMTP id
 38308e7fff4ca-389ff119cebmr56498821fa.11.1772450010476; 
 Mon, 02 Mar 2026 03:13:30 -0800 (PST)
X-Received: by 2002:a05:651c:25d5:10b0:389:fc6b:943f with SMTP id
 38308e7fff4ca-389ff119cebmr56498631fa.11.1772450010041; Mon, 02 Mar 2026
 03:13:30 -0800 (PST)
MIME-Version: 1.0
References: <20260225112922.3982104-1-david.marchand@redhat.com>
 <20260226162057.207202-6-david.marchand@redhat.com>
 <DGP1R1WJWJGI.1TU6RUU13GBYQ@redhat.com> <4506449.8Dcp7MaWsk@thomas>
 <aaGhdEEgxiA4Z33A@bricha3-mobl1.ger.corp.intel.com>
 <20260227141045.236af55b@phoenix.local>
 <aaVSHYANsEFRx-oQ@bricha3-mobl1.ger.corp.intel.com>
In-Reply-To: <aaVSHYANsEFRx-oQ@bricha3-mobl1.ger.corp.intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Mon, 2 Mar 2026 12:13:18 +0100
X-Gm-Features: AaiRm52t47aiQZLthlBtGKrajsB7K6nyNauGc_6rhMUgmby3fg9rW6-uPhIxbzI
Message-ID: <CAJFAV8xPhdCZGiipprqOouuM0shw_MNVWa7jSG6b3Jp7X7hpSw@mail.gmail.com>
Subject: Re: [RFC v2 5/5] eal: configure initial device probing
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Thomas Monjalon <thomas@monjalon.net>, 
 Robin Jarry <rjarry@redhat.com>, dev@dpdk.org, 
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: mZO5YdssxLU5bd6UMa19PTLa1gqXL93_7hhzvB8NIsI_1772450011
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

On Mon, 2 Mar 2026 at 10:04, Bruce Richardson
<bruce.richardson@intel.com> wrote:
> > > > > Or:
> > > > >
> > > > > BOOL_ARG("--no-autoprobe", "-P", "Disable automatic probing of non-blocked devices", no_autoprobe)
> > > >
> > > > I don't see the benefit of a short flag.
> > > > It makes reading commands less obvious.
> > > >
> > > I actually would prefer to have a short option available, and I'd really
> > > like that short option to be "-A" since it serves as the perfect addition
> > > to the "-a" flag to specify devices to probe.
> > >
> > > Based on that, I would look for long options which allow "-A" as the short
> > > version for example:
> > >
> > > --allowlisted-devs-only

--allow-only?


> > >
> > > /Bruce
> >
> > Also if -b or --block-list become a no op with --no-autoprobe. So it should be a warning?
>
> Yes, I think a warning about ignored parameter would be appropriate.

Thomas had the same comment when we talked about the series.
However, I would reject the combination rather than warn.


-- 
David Marchand

