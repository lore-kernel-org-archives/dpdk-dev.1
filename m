Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D09ECAC5A5
	for <dpdk-dev@archiver.kernel.org>; Thu, 25 Sep 2025 08:43:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DAC29402AB;
	Thu, 25 Sep 2025 10:43:05 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 6225E4028F
 for <dev@dpdk.org>; Thu, 25 Sep 2025 10:43:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758789784;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aA7F/PS3E8uGFdVqbaXRW/7kiZFdtQwnl1BV5Y3mSrk=;
 b=Y7MrP8gjp7x8B8RN4LSE+m4ZiGRQmCRcIVGtWpTENYiZh/jzHERqaJLaEGzMzfxxp+Cxi9
 wO8W1frSkDYGnkNL584HUqatuMOYhmq5YEN+VoddLqchNUgGjXDbkOkqLFZAzhefYO4VTP
 6BAflKxHkFobLylTbx/E4zEHTukJ4Ss=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-640-X3QCkqNsPHihL7mcjZy16g-1; Thu, 25 Sep 2025 04:43:02 -0400
X-MC-Unique: X3QCkqNsPHihL7mcjZy16g-1
X-Mimecast-MFC-AGG-ID: X3QCkqNsPHihL7mcjZy16g_1758789781
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-57e47033f38so264076e87.0
 for <dev@dpdk.org>; Thu, 25 Sep 2025 01:43:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758789780; x=1759394580;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aA7F/PS3E8uGFdVqbaXRW/7kiZFdtQwnl1BV5Y3mSrk=;
 b=FsZlGgD9UncgYdvvXGG0YJl4pIIRj06Sv8Khzj4FhoS+GWgnjvNyd5O/XRRk/N6aO7
 O6FdlMyhK3qt9RhaeuDoxNSFFRrRfOdqGJ6FhWZwVPzYuJm3bznZsX4NMsVJCwbnF//C
 7962s1DrCC7IcAfMkz77nMiX6bFACNqLr63Ok2x9b0Pn3oL/aQE8GT74pNMWw20dKzJo
 daUYNTtkLqucrFNB18pfzPPgw5KTkGsFDHFro7A+ByjqjvpNOR70ug+dTH83m8oH4uii
 Yvremlk7Gqt1zKC2Vkx0zzBo4FVjtX9PCjz5m/rl/8Sn89Wgff89QnMr03I4pek7CRQD
 8cyg==
X-Gm-Message-State: AOJu0Ywm6wgeC/Fm8su1F4GCkUBrsp/YZAjuswL8z+9bSo41nm3h/brM
 2ll4zzTpMEZTp+lYm52GOSHp3aso/wFq41BBVrQluWR3PnxYt7A1mM8p27LASVJxZVpCbYjWzur
 ihUWzjvbY/tkh0mOOnn9SHWvlseTCfLlcjQdzQ2Ang9C9wV5hDPZuQzW4qMhcEZmDSyPvxoe5Nw
 N46zUU9GJV1Rd9ZadXmSU=
X-Gm-Gg: ASbGncsip9zu1cEH//j3gJklkn+D7dlxSQuMPMN9B2FVO+xzbftqINOxDV/0aYoUERV
 OK5ZWyuoMaMl85mGnXNO/loLvpxIPa1hWk4F3XbrdIoUTIp+km7KyhHVIkmTRoA4yvXGExri2Nh
 MV8q7q8UiT6YbY86fJw2aH8cY=
X-Received: by 2002:a05:6512:a83:b0:57f:3f75:9b3b with SMTP id
 2adb3069b0e04-582d2b4a278mr696808e87.38.1758789780501; 
 Thu, 25 Sep 2025 01:43:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGxluQR8aKFCZyFn3EbeNWctD6Zv0BQ++GqFDwhu0T1h1FzTcUJpfhC1wIc8iDMESM6llUWDsMeBKxciX3ps28=
X-Received: by 2002:a05:6512:a83:b0:57f:3f75:9b3b with SMTP id
 2adb3069b0e04-582d2b4a278mr696798e87.38.1758789780024; Thu, 25 Sep 2025
 01:43:00 -0700 (PDT)
MIME-Version: 1.0
References: <20241127112617.1331125-1-david.marchand@redhat.com>
 <20250924172536.2447183-1-david.marchand@redhat.com>
 <20250924172536.2447183-7-david.marchand@redhat.com>
 <aNT2gMD4BH44UB3i@bricha3-mobl1.ger.corp.intel.com>
In-Reply-To: <aNT2gMD4BH44UB3i@bricha3-mobl1.ger.corp.intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Thu, 25 Sep 2025 10:42:47 +0200
X-Gm-Features: AS18NWAp1459hHH6KE941EgtjCq3TEwXAmz7PNlQdAU80npjAgiZs48J5gfME10
Message-ID: <CAJFAV8z7pnVm51HmfNDTr7=xsALPcKN9fRh7rVGgKgM2sWY8mQ@mail.gmail.com>
Subject: Re: [PATCH v3 6/7] buildtools/chkincs: use a staging directory for
 headers
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org, Thomas Monjalon <thomas@monjalon.net>, 
 Tyler Retzlaff <roretzla@linux.microsoft.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 2pCx-W5-U8JSqPNsDC9O_CMg0z9BF1kNCiqYuDdJNA8_1758789781
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

Hello Bruce,

On Thu, 25 Sept 2025 at 10:00, Bruce Richardson
<bruce.richardson@intel.com> wrote:
>
> On Wed, Sep 24, 2025 at 07:25:34PM +0200, David Marchand wrote:
> > A problem with the current headers check is that it relies on
> > meson dependencies objects that come with their include_directories
> > directives, and all of those point at the library / driver sources.
> >
> > This means that we won't detect a public header including a private
> > (as in, not exported) header, or a driver only header.
> >
> > To address this issue, a staging directory is added and every header
> > is copied to it.
> >
> > Drivers and library headers are staged to two different directories
> > and the check is updated accordingly.
> >
> > Signed-off-by: David Marchand <david.marchand@redhat.com>
>
> In general looks ok to me.
> One small comment though - can we not have "staging" as a top-level
> directory, but instead hide it inside the buildtools directory, or even the
> chkincs directory? I dislike having too many subdirectories directly off
> the root of the project, especially ones purely for internal tooling.

Well, at first I was trying to change the whole build process iow rely
only on the staging directory and remove all the include_directories:
directives from the declare_dependency() objects.
Libraries and apps were ok, but there were a *lot* of complications
with drivers (what a *huge mess*, especially for NXP drivers with
"compat.h" includes, and Marvell drivers to a smaller extent).
I may retry in the future with some AI tool that will brute force this :-).

For now, I gave up but did not reconsider the location of the staging part.
Moving to buildtools is indeed saner as it is only for the check now,
and I can also make this staging stuff dependent on the check_includes
option now.

I have a strange build error with Windows + clang target that I'll
need to understand (maybe a problem in how we reference DPDK public
headers via "" instead of <>?).


-- 
David Marchand

