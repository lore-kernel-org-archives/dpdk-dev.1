Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 153B5C54E65
	for <dpdk-dev@archiver.kernel.org>; Thu, 22 May 2025 15:10:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 41AC64060F;
	Thu, 22 May 2025 17:10:49 +0200 (CEST)
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com
 [209.85.128.176])
 by mails.dpdk.org (Postfix) with ESMTP id 2E74A402E5
 for <dev@dpdk.org>; Thu, 22 May 2025 17:10:48 +0200 (CEST)
Received: by mail-yw1-f176.google.com with SMTP id
 00721157ae682-70da0603e24so44320667b3.0
 for <dev@dpdk.org>; Thu, 22 May 2025 08:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1747926647; x=1748531447; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=AgJrHBef5zcwd3I3J3Xb1mLyx7oYkhB7tM4DtxaDFMo=;
 b=fgYSg6fSjw+RZGlV2+Ufu6Xz1f+N2pzYP4RArQI536dYOod5eyDHgMKO8/VJ467HiG
 /BviXe/2141TYaUHzNa8U8Bjg1c9txUfHACgQYXQPhvhZGcjS68b6ZtYWal1Iiuh4L24
 KiWnQ4T/KlBwQPnMd2roIxnyqR6xZ2krrYBAI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747926647; x=1748531447;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AgJrHBef5zcwd3I3J3Xb1mLyx7oYkhB7tM4DtxaDFMo=;
 b=hA4zkEe/AALEaeWPAv9Pokuuy0/rGHM61qIWXLDuV9nK19h4MYF8bxPiDn3kCwV0N0
 Z+Acdgg1jNBmpO0KyIWj+omhtVQw6EQEg7emb0ZM060c9n7RQGWqhDO3QcUORPz0Lwy8
 NGwh5KqshDB6Z/BtjUiGbnfvrHYnacyCyTbKcM3mpf7bikcNfHQw7C0kbhqIh88yDtD4
 Kb0/oUl6Tl/EVWSLwVtsoNozyfoetL9YRI2tlg+ooCRg8Lu4fFrYxBAizZqv0dIdgsAr
 IUvA5aXy64MZj1Zplj/P8SJAvSDzTaVXUdCdQwI5p5/4bV2FjS+Wzx1WzXX0AK8prL1G
 PhCw==
X-Gm-Message-State: AOJu0YzT0ccIOlG3Q6LgQpRz1Ni3VdWOl0cSFrO1BlTJym1qyfrXiI/D
 tn1tggLwuqmR+gVeTFuUy05YhVGPxB9/NNvVd8hGpY1ymdTInW6fIs6gQxwoFmNAkWwsGkGTqBc
 ASf/Zz7t1RjznqKGD2A+xmLYPYFou1FqbYbEMI7tRZ4YynEnM/+vH
X-Gm-Gg: ASbGnctQh8wOmcXvJ8WmJOCusRrXykmVTjcp2JxkOuONYPeqEe+5Jqgeg222ZUzp5oW
 /Xe+0gLABTP9AV7ZfOavCq5GhnMOl8HKn4E0gB5/GBnq0xbK/SXaGbL2kexvnMx3BZT9S0pkJT3
 wsxMunt6CKrg+/gkUnAVj7SYd1w08Cc9XPDWV/bnQ1bHEm2tlKRUhCzFkdolrkJEgZ6i4=
X-Google-Smtp-Source: AGHT+IFhVbKuIptHsvRlRSek6gpeEgGenUW8CjqhtD7PlG2Unprbq5Vnf2tx3UkB+pvBW7H9nZYQxEUDSQwMU3JoAOQ=
X-Received: by 2002:a05:690c:9a91:b0:706:b2fb:5ed with SMTP id
 00721157ae682-70ca7bb5684mr346997917b3.34.1747926647125; Thu, 22 May 2025
 08:10:47 -0700 (PDT)
MIME-Version: 1.0
References: <20250423194011.1447679-1-npratte@iol.unh.edu>
 <20250516201834.626206-1-npratte@iol.unh.edu>
 <20250516201834.626206-5-npratte@iol.unh.edu>
In-Reply-To: <20250516201834.626206-5-npratte@iol.unh.edu>
From: Dean Marx <dmarx@iol.unh.edu>
Date: Thu, 22 May 2025 11:10:35 -0400
X-Gm-Features: AX0GCFv5k-TnMecEK7NYVWM2TSUwil5iPfwW3Ll9gUcDj-hqPobK1MhGQzSPmEw
Message-ID: <CABD7UXNB7-fEd5HUwEkLNEfDmLL19rH7owsta2YuAv1_goG_mQ@mail.gmail.com>
Subject: Re: [RFC v2 4/6] dts: add extended timeout option to interactive
 shells.
To: dev@dpdk.org
Cc: stephen@networkplumber.org, luca.vizzarro@arm.com, paul.szczepanek@arm.com,
 yoan.picchi@foss.arm.com, Honnappa.Nagarahalli@arm.com, thomas@monjalon.net, 
 thomas.wilks@arm.com, probb@iol.unh.edu
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

Reviewed-by: Dean Marx <dmarx@iol.unh.edu>
