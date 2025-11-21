Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E87EBCFC26F
	for <dpdk-dev@archiver.kernel.org>; Fri, 21 Nov 2025 12:42:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0A60B4026F;
	Fri, 21 Nov 2025 13:42:12 +0100 (CET)
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com
 [209.85.128.176])
 by mails.dpdk.org (Postfix) with ESMTP id 9BB5B40267
 for <dev@dpdk.org>; Fri, 21 Nov 2025 13:42:10 +0100 (CET)
Received: by mail-yw1-f176.google.com with SMTP id
 00721157ae682-78a76afeff5so20100437b3.0
 for <dev@dpdk.org>; Fri, 21 Nov 2025 04:42:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1763728930; x=1764333730; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=B2iLvW/CeHMUsLNhYUO6f4f7wKJjxjUIog5B1XF1eqc=;
 b=gBlp2ttc+9+UqWjAqA0HkFGd0AQx/TNmx4EsClv8KstwyueaFo/w4tSEwzUe5N62y+
 2jBNUTdQLakqJVhkHlBrZRDnctiqka7FsySRI0J2lJIY2awnBVGbJzqrrhsXAjwZnVpx
 Cmf+vBWWGWVx7DYM7E6DEo4zuP6ZF6sy/OKV9HZkzR0tnSSMNf6WTY2y1Za4fdm8Sgv6
 WExQfyIPEUJ2lD6WbNhd9S7ndATh+BU/+05qpxfC9xsGvFEkklyE0aD9HaePxe/FJjj5
 rVgmgRBbnPFweW26JrbqjnyH+nlFlUgKwEE42YR0xVUQLjBAXRU7OkQQLAHiP4bVYrwB
 gH0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763728930; x=1764333730;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B2iLvW/CeHMUsLNhYUO6f4f7wKJjxjUIog5B1XF1eqc=;
 b=vtb4hLaBq+eZkJ7yHYD7FPmYur6hGekhrfhtgdIBYBrIUSJmrJQ/TcFIfZ40jCnEHC
 9GTi+krq4v9Mj08dm7wFkPk77AfmxYyYOXAJWWRetRGIQROrSNK5GKi8zg/z0noyGzj3
 DXUwnRbcGkWZqdUnQ/1yTKxlKkLS4LAnn7cF1iv+nbCNEy5QF3CazbhGmy0ra7wn5xTk
 HZl4x5qA20PSWXLaOG7jsDQEl1SG0iw6Fy7E58sU3B2kIPR7dBNCY+Wh0ORoSP/t/aIW
 v05d271xJh5S2IR7AkxKS5YVFW58krqRK1s02Y6jMdZkar44s2vNItB3SmpcMOuLPnJE
 Y65w==
X-Gm-Message-State: AOJu0YxItsqDHP4/KQWIhGC47MGSLEa11NUKiD+avQ8fJv4o56T1YHwt
 VHuwqRj2y+VECqqtnkG4qWMZruDU0VVwnw9/tWj1VvldgtQpRGPEBPNIPA/tmNhA4GqLXi3Et91
 UrzGFJBQEg0o99Gve/RgQRCW339MtmzM=
X-Gm-Gg: ASbGnctoWqoo1aDNLPuncwSzbb1PHBM/nOphSmIsmoC2ITKTSWixZJxtIn+HJ35mAo9
 obG8SLKiRNFHFegaz2uYH6bhvBYONEQ02fRHYB/cLB8xv5siST1Nj3uUPskbESs2r220j9KhEth
 i/gJSAY7ucvoI9g1TL4QSy/8zKPMXhIRxXHgiL5qADfslUGNxpF8kjmMojgmd0FQ7RdQu3uYUuL
 2EDkt+9KRF1uElsRfaZg0EvixcIpamflGfoopU3nPh6YP0LrHT0Io2Ly25OnWBErBPtwFqSjVRN
 kreVNOv1NP6gTK4jJQ0qMNcwZPWC4w==
X-Google-Smtp-Source: AGHT+IF307sBs2UX/uPW7eivVEp9BrF33likOxHCg7zkEWo4yX/mknJfvEwNslUKnD7bh/4mt23cXT7TY9WOGUuoRJ8=
X-Received: by 2002:a05:690c:680a:b0:77f:aab8:31ae with SMTP id
 00721157ae682-78a8b551859mr16846167b3.46.1763728929954; Fri, 21 Nov 2025
 04:42:09 -0800 (PST)
MIME-Version: 1.0
References: <20241223132220.138227-1-luca.boccassi@gmail.com>
 <Z3uwcddSVFDt6dNn@bricha3-mobl1.ger.corp.intel.com>
In-Reply-To: <Z3uwcddSVFDt6dNn@bricha3-mobl1.ger.corp.intel.com>
From: Luca Boccassi <luca.boccassi@gmail.com>
Date: Fri, 21 Nov 2025 12:41:59 +0000
X-Gm-Features: AWmQ_bkGykJZT4NKhB7VAMU7rABLBgEJ_v3zepEMTgiyQSv8VbtC6FRCJToAUnU
Message-ID: <CAMw=ZnRLow0-1chqdn7oWN=4AZtqcpn-aMJYPW0NWrgipkL+rg@mail.gmail.com>
Subject: Re: [PATCH] doc: add install_tag to meson
To: Thomas Monjalon <thomas@monjalon.net>
Cc: dev@dpdk.org, Bruce Richardson <bruce.richardson@intel.com>
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

On Mon, 6 Jan 2025 at 10:30, Bruce Richardson
<bruce.richardson@intel.com> wrote:
>
> On Mon, Dec 23, 2024 at 01:21:13PM +0000, luca.boccassi@gmail.com wrote:
> > From: "bluca@debian.org" <bluca@debian.org>
> >
> > This allows building and installing only the documentation, without
> > recompiling the whole project, using:
> >
> > meson build -Denable_docs=true
> > meson compile -C build doc
> > meson install -C build --no-rebuild --tags doc
> >
> > In Debian/Ubuntu the documentation is built separately from the binaries,
> > in a separate architecture-independent build job, so that it has to be
> > done only once, instead of once per supported architecture.
> >
> > Signed-off-by: Luca Boccassi <bluca@debian.org>
> > ---
> > This requires meson 0.60, so there's a warning printed as the minimum
> > defined is 0.57, but it's harmless, and the feature is only used when
> > explicitly invoked with --tags, which simply has to be done with newer
> > meson versions. If install --tags is not used, then there's no issue.
> >
> >  doc/api/meson.build    | 3 +++
> >  doc/guides/meson.build | 1 +
> >  2 files changed, 4 insertions(+)
> >
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>

Hi Thomas, looks like this was never applied? Is there anything missing? Thanks
