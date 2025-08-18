Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 037CCCA0EC6
	for <dpdk-dev@archiver.kernel.org>; Mon, 18 Aug 2025 11:05:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3C96B4014F;
	Mon, 18 Aug 2025 13:05:46 +0200 (CEST)
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com
 [209.85.128.173])
 by mails.dpdk.org (Postfix) with ESMTP id 4F9904013F;
 Mon, 18 Aug 2025 13:05:44 +0200 (CEST)
Received: by mail-yw1-f173.google.com with SMTP id
 00721157ae682-71e816e7f09so8971607b3.1; 
 Mon, 18 Aug 2025 04:05:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755515143; x=1756119943;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VX6rhIQR+wjwVsQf0MAyQV/4RnyK0LFLCZhO5bmx0eI=;
 b=oPUGrLK+2vtR5Jau3V7ODeFKSzQXUHLsmy/+3lY/iS2MSBQcscSrIBLq6mce2+4qgG
 /uDreRh+EkWeZaGh2vS+A6ummTPk80NGIHjO5yCLJjN2N2HYxGF9/IHCNwv3kl7SK+W4
 v9XgfklXi52TC0fwwCknYuAVTkg5lIMBgjAcr7xDHe1YCRoGghFeGRLKpmO7nAAhSWF2
 Glwx180s1COQnnSG3aEqndlskxBUJP4yfNCCMJJxl4e/7Tms9Mlsr7HlusAT75hnR6jT
 r3yATw0vBrYiAULHipbfvCvojy0LObzl++mufHKrjkM4YJj6rPOyjym2VLJHoJiAh30/
 4tJw==
X-Gm-Message-State: AOJu0Yy4cWGSKlTlTZBgX0nxI/VxOxnyT+cstKMMKRA3jycEryDSpgA1
 NSmxweViv3ul7A2oyYOLHMfYFz6e5uOi971UHnaeIA3mzV09rrsyabKatdhCfjCl
X-Gm-Gg: ASbGncvNd6XVBHzdc5Fd+O4TfcfPlJXDFBIy2wPNAzuSu+7p2mJ0BIpt9t+WM5ByfTL
 VKCJV2bmhky67bxZqnUysGLSu94VFEoU8SMhppYlgvDgv7MLoDad5KkPlVIl5eAy/a6o3hQ2Rtj
 udszaEq5C4fB33Wb7Po0qT/8jWmvAf6rmM/9n1ov+uGfzfK/kzN+ePrjnKmhPuYFNrzluSs2Spq
 EiJY2OYY6tjZ3TIWprbv1PCLh5Em4Twvs1zJ56EUL0hnSNSFhecnBh4bzqNK3sPQEjlrO8xmswk
 7xOLs4IdSWGOaLiQE36141LAckmdl/dPA75iGU3Tki5zazpQ0psMmB3kf1bNQTirL1RWRAaRi6G
 xhEW/Yw33GQJjUNtoYM9DhVhmGYh2WEL3EgQam4ZTP6KRoXgNaFE2hvxDJ+E=
X-Google-Smtp-Source: AGHT+IENHTK3xGv5tIfuZzYI8+YJk9MfE8OSJIZXKS3fFfYffR7D4Y/sr83w/1WddmyNPQ+4pHTnaw==
X-Received: by 2002:a05:690c:6485:b0:71d:4acb:4df1 with SMTP id
 00721157ae682-71e6de24a60mr117367417b3.33.1755515143082; 
 Mon, 18 Aug 2025 04:05:43 -0700 (PDT)
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com.
 [209.85.219.179]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-71e6e064d49sm21310437b3.45.2025.08.18.04.05.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 Aug 2025 04:05:42 -0700 (PDT)
Received: by mail-yb1-f179.google.com with SMTP id
 3f1490d57ef6-e93cc7c64faso788387276.0; 
 Mon, 18 Aug 2025 04:05:42 -0700 (PDT)
X-Received: by 2002:a05:6902:160c:b0:e93:451f:93a1 with SMTP id
 3f1490d57ef6-e93451f9659mr7813782276.42.1755515141853; Mon, 18 Aug 2025
 04:05:41 -0700 (PDT)
MIME-Version: 1.0
References: <20250723160822.1686060-1-luca.boccassi@gmail.com>
In-Reply-To: <20250723160822.1686060-1-luca.boccassi@gmail.com>
From: Luca Boccassi <bluca@debian.org>
Date: Mon, 18 Aug 2025 12:05:30 +0100
X-Gmail-Original-Message-ID: <CAMw=ZnS1dWACxYBD9X3xkrthAZxC-n1anNRnGo_LK+mRpWGZ6g@mail.gmail.com>
X-Gm-Features: Ac12FXwACk6hDIse0-Pb5DCZ712VNnmkgmD2tDulbYdyP-lCfZ8szjxFNprVAEU
Message-ID: <CAMw=ZnS1dWACxYBD9X3xkrthAZxC-n1anNRnGo_LK+mRpWGZ6g@mail.gmail.com>
Subject: Re: 22.11.9 patches review and test
To: stable@dpdk.org
Cc: dev@dpdk.org, Ali Alnubani <alialnu@nvidia.com>, 
 John McNamara <john.mcnamara@intel.com>, Raslan Darawsheh <rasland@nvidia.com>,
 Thomas Monjalon <thomas@monjalon.net>
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

On Wed, 23 Jul 2025 at 17:08, <luca.boccassi@gmail.com> wrote:
>
> Hi all,
>
> Here is a list of patches targeted for stable release 22.11.9.
>
> The planned date for the final release is by the 25th of August 2025.
>
> Please help with testing and validation of your use cases and report
> any issues/results with reply-all to this mail. For the final release
> the fixes and reported validations will be added to the release notes.
>
> A release candidate tarball can be found at:
>
>     https://dpdk.org/browse/dpdk-stable/tag/?id=v22.11.9-rc1

Hi Ali,

Any news from Nvidia on testing this stable RC? Is that planned/in
progress? Thanks
