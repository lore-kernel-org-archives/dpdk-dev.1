Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCB49CAC5B8
	for <dpdk-dev@archiver.kernel.org>; Thu,  2 Oct 2025 11:58:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BA1BD40DDC;
	Thu,  2 Oct 2025 13:58:32 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id EB32F4013F
 for <dev@dpdk.org>; Thu,  2 Oct 2025 13:58:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759406310;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=e+Ni4CpffNgAbWaOb78LLGizY0J424ldomXstZIadVw=;
 b=X80oAzyY4+bn628LoS+9aSda+a0z2dOs4b1Rb7U10wq+fwq/v0WBlRSLVtjQnWlk/Nme2w
 qI2it4KCB++rlDRfcyvx7VemkIcaMXySfGmUa4+AhCO46GjtBku2f17O/S3Rt9Pz7vuIM6
 3b12u/AOEPYxFS95gvLIHtWNKByIF7Y=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-136-vH3Lqxn_NeO5nHS3EjkeBQ-1; Thu, 02 Oct 2025 07:58:27 -0400
X-MC-Unique: vH3Lqxn_NeO5nHS3EjkeBQ-1
X-Mimecast-MFC-AGG-ID: vH3Lqxn_NeO5nHS3EjkeBQ_1759406306
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-36af4d383feso5222671fa.2
 for <dev@dpdk.org>; Thu, 02 Oct 2025 04:58:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759406306; x=1760011106;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=e+Ni4CpffNgAbWaOb78LLGizY0J424ldomXstZIadVw=;
 b=puq8VH2u7jwhOobKQPeU8cMg/ROekZMFSNjtc9ujXHE14pMlcPsWc1jaRtgfh6M+bd
 4VpGy+JYS+GsXda3UaUFmynHsJcrOK1kAzAa5Rx6xvWcOX5gpFkShHMBvjDty+r1J/NZ
 E5fqJK7k/SoGYnE09ZtNO3nZTkbysFjGJMw6/6fQFDGVvnlLvVCb8+ZipsUb1xnm+UwR
 TmKxQ0m88fjzlL2UwO4y0veiUxSg/LWC6JBPXJbP1YEQmsnJbsJ437TjXyCq0TXRXuH1
 V7N2ljDME2OezcImHHqOzPhxXWeY/mmXESEKsXmxWg0cKeHEUMSOFYv0/4edIDAk1M5L
 75wA==
X-Gm-Message-State: AOJu0YwMCvTz7shpQ1ZZlLERtthOEokSSlEkq0sEJP6RrHyUXos/0bo+
 s+YUWPCiG7oJW4I9E5ai6iRM21ySjGtvuCMPMUSyht9bIs1szjLrJesas5P21G7KOhB3+34443C
 DaaexVmI430n0abbwcZRw0MvuZ2o10qVp6o7O0USnxqjpvRDi81r4fRjlvzMWUcnnyBel/5Zgsx
 yzrFzftwal0pabfFDHOWg=
X-Gm-Gg: ASbGncsATnuEwzf3Zxbb5+zmiQk2dvn+WeF96uQG4vnD30B7o13LpB99q5Im/K39SL3
 aEjwzm4xDX72XWwBYv+W+AA5BAw0erOP3mVQDexS6VQ3MxHmRh1tv+jU5or6d7A0HRmuSlupAZh
 1R+wtNDBTtOASvhEVrllbHTV+yxl4k
X-Received: by 2002:a2e:a817:0:b0:371:fb14:39bb with SMTP id
 38308e7fff4ca-373a710b419mr21942761fa.16.1759406305767; 
 Thu, 02 Oct 2025 04:58:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHttAAkwz52cEuSI8wj4k5z0cMVuZ3Mx82UNIcfTW2W/2aZFzyTe8Pm9fc8QglzOx6l0vjsI1qG7kJNNPnDpVE=
X-Received: by 2002:a2e:a817:0:b0:371:fb14:39bb with SMTP id
 38308e7fff4ca-373a710b419mr21942601fa.16.1759406305232; Thu, 02 Oct 2025
 04:58:25 -0700 (PDT)
MIME-Version: 1.0
References: <20250923165830.527416-1-bruce.richardson@intel.com>
 <20250924111318.567771-1-bruce.richardson@intel.com>
 <CAJFAV8ztEthzEhjCYy-L0T98F7zb2qECG+2Cd0-HavPEBUQnAg@mail.gmail.com>
 <aN4yl66c5ftB_EpB@bricha3-mobl1.ger.corp.intel.com>
In-Reply-To: <aN4yl66c5ftB_EpB@bricha3-mobl1.ger.corp.intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Thu, 2 Oct 2025 13:58:13 +0200
X-Gm-Features: AS18NWBeGdRFvTXg0YXdu0PhV0LHtL7jNG6IHLVtMbam9FPdlKPhRphP0qjOF1E
Message-ID: <CAJFAV8xW5B8M+f0AGL1PfAQRLwXLCv6qB3t0CpUNykXH_mdszQ@mail.gmail.com>
Subject: Re: [PATCH v2] build: validate libraries returned from meson find
 function
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org, Nicolas Chautru <nicolas.chautru@intel.com>, 
 Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>, 
 Bing Zhao <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>,
 Suanming Mou <suanmingm@nvidia.com>, 
 Matan Azrad <matan@nvidia.com>, Srikanth Yalavarthi <syalavarthi@marvell.com>, 
 Ciara Loftus <ciara.loftus@intel.com>, Maryam Tahhan <mtahhan@redhat.com>, 
 Long Li <longli@microsoft.com>, Wei Hu <weh@microsoft.com>, 
 Anatoly Burakov <anatoly.burakov@intel.com>, David Hunt <david.hunt@intel.com>,
 Sivaprasad Tummala <sivaprasad.tummala@amd.com>, Rosen Xu <rosen.xu@altera.com>,
 Tomasz Kantecki <tomasz.kantecki@intel.com>,
 Dmitry Kozlyuk <dmitry.kozliuk@gmail.com>, 
 Tyler Retzlaff <roretzla@linux.microsoft.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: nHxKehnyQMz2pjSey60u9YKGO3Q0t4bPt00zt8U_4u0_1759406306
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

On Thu, 2 Oct 2025 at 10:07, Bruce Richardson
<bruce.richardson@intel.com> wrote:
> On Thu, Oct 02, 2025 at 09:53:15AM +0200, David Marchand wrote:
> > It's a pity meson refuses to define user helpers... so much copy/paste
> > in this patch.
> >
>
> Yes, though if we want to reduce it I can remove some that is currently
> unnecessary. For example, windows support doesn't have any cross-compile
> options and only supports a single target so the checks there probably
> aren't necessary. I added them for consistency.

For many (all?) DPDK devs, copy/paste is the rule when it comes to meson stuff.
Let's keep this consistent.

>
> The other thing we could do to help out here, is check to see if any more
> libraries can be switched to using pkg-config. I noticed some libs have
> fallbacks after a pkg-config call - we could remove the fallbacks and just
> mandate use of pkg-config for those.

It may be differently implemented across distributions, and their versions..
I suspect we will still need the fallbacks.


> > > This checking is not necessary (or should not be necessary) for
> > > dependencies got using pkg-config, since the .pc files for each build
> > > type are stored in a different directory on the system.
> >
> > Would it affect the library lookup if we pass has_headers to find_library()?
> >
>
> I don't think it would affect things, since the headers are common in many
> cases, only the binary files differ (thinking especially of the 32-bit vs
> 64-bit case here).

Ok, nevermind, I'm fine with this patch.


-- 
David Marchand

