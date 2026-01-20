Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31FA4D2ECF7
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 Jan 2026 08:32:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6B35540BA6;
	Tue, 20 Jan 2026 09:32:08 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 645C140273
 for <dev@dpdk.org>; Tue, 20 Jan 2026 09:32:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768897926;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2jBFokm/wTFMgnMWhaEooyUHi1RIes71QtZz1l76CA8=;
 b=Ingk+S2Wk2i8iiCt7cKV898TqHNSvj6FIUmTsGugc4hDVKLRpI4xwDgk2ZsnpLZO8xQwKr
 U/KogjeLSq8+DPmEFqetn3ZchF7SEmi27kgpa0xcDNPYIPHu/bZhsKSEoz9/XllRNg4fvK
 WpMEB583qE2rSghbp69GXyiikZA2wTQ=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-541-uCPOQ6g6Oz24Feubib3WtQ-1; Tue, 20 Jan 2026 03:32:04 -0500
X-MC-Unique: uCPOQ6g6Oz24Feubib3WtQ-1
X-Mimecast-MFC-AGG-ID: uCPOQ6g6Oz24Feubib3WtQ_1768897923
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-59b70088327so4479306e87.1
 for <dev@dpdk.org>; Tue, 20 Jan 2026 00:32:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768897923; x=1769502723;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2jBFokm/wTFMgnMWhaEooyUHi1RIes71QtZz1l76CA8=;
 b=eIY6oelEy73V8e8NWra0V5EbfO1XchVTX6xD46nQYJVGVnQq3cXeip2lTHMNYhDXjZ
 FN3sQYvB3q+ejEODY/AaGcex2yjW9PWLh0UisKWTvQN4Y19PoKyQDnAKm3+ZAmsMb/k9
 T7Zyk+EaUcNCT4J7WrMSl0F8XjMC+fe1AQLRYTcGvJeHFyhObKCU/QdWi9HJaloX0U9j
 t50425FgJSW6U9koZkzvJzGhNk0LgOqLzVCukmABa/6N+5WEj6VbcoYyOZpaqPpng3CY
 kvMmyNeXfuNgh2og5BgiSCnD3cDwUg5+NKOudsWWbbekXzd/kUGrJcY/L/0B/j21DlSn
 0j4Q==
X-Gm-Message-State: AOJu0YwBh+jMin+PjKX3AVaNcsB+NjErdBirmmlIOeNQvIJa9AUVZ7jJ
 UrtDn4Ad/yCSF60VlZUiQoZ+NWZZEGAGX8gY77/8Dl5tSWclCTbign/wqbaSKVnsHBK+jDEuHq4
 7aiRqA5A+xUJ2b6yadC7KCg1j54SU5SzlC+P1M023Y1TE/Hq2XmMtjA8d/jDFmu+iBcyv9qa7+X
 5y0nwgK1MzNLos0pkOpBA=
X-Gm-Gg: AZuq6aLfmkuafiP+yNoPm0uzXW30k0WfpI/Ij3LraQzYCPDtErXPTvcr6tlyB4Gl/25
 s2J9E9EQ9W7TuHATi07SOpif/Lw+i0qbY7xeKNTFRRJCdxlPg4NlczJNTRKB9CZUqzBsa+BB7pp
 0FtnCBKzV9zfWbyoovAFGg77ormwr3I57uIi8MjqdZTwP4k4loEBNf9P3TdghSwxiHw63x
X-Received: by 2002:a05:6512:2390:b0:594:5545:b743 with SMTP id
 2adb3069b0e04-59baeef7b2bmr5056707e87.27.1768897922804; 
 Tue, 20 Jan 2026 00:32:02 -0800 (PST)
X-Received: by 2002:a05:6512:2390:b0:594:5545:b743 with SMTP id
 2adb3069b0e04-59baeef7b2bmr5056691e87.27.1768897922356; Tue, 20 Jan 2026
 00:32:02 -0800 (PST)
MIME-Version: 1.0
References: <20251205121301.3443561-1-bruce.richardson@intel.com>
 <aTLP4TBHLtqm0kpR@bricha3-mobl1.ger.corp.intel.com>
In-Reply-To: <aTLP4TBHLtqm0kpR@bricha3-mobl1.ger.corp.intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Tue, 20 Jan 2026 09:31:49 +0100
X-Gm-Features: AZwV_Qj1i4BbhKcoGMa4qS5Mdwi-LLy1X_iJ6TWVEzf5p3ynhdPUhs3FzKLZqS4
Message-ID: <CAJFAV8yEy9Oz3u0ZqyA4RHQPUjmvEFSLH1cAnfMZccehd0+Z5w@mail.gmail.com>
Subject: Re: [PATCH] build: bump meson version to remove warnings
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org, ci@dpdk.org, Thomas Monjalon <thomas@monjalon.net>, 
 Aaron Conole <aconole@redhat.com>, Luca Boccassi <luca.boccassi@gmail.com>, 
 Timothy Redaelli <tredaelli@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: VQmMdkdGWA2Rt_eH5cC-U5eHDtPZg7gUmSCvEfIOKr4_1768897923
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

Hello,

On Fri, 5 Dec 2025 at 13:28, Bruce Richardson
<bruce.richardson@intel.com> wrote:
>
> On Fri, Dec 05, 2025 at 12:13:01PM +0000, Bruce Richardson wrote:
> > The build of DPDK now uses features from version 0.6 of meson, which is
> > greater than the current minimum of 0.57.2. Although these features are
> > non-critical, they do cause warnings to be emitted on build. Increase
> > minimum meson version to 0.61 (== version in Ubuntu 22.04 LTS) to remove
> > these warnings.
> >
> > Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> > ---
> >  meson.build | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> With this patch, and the previously submitted patchset for assigning test
> cases to the various categories/suites, all warnings in the meson
> configuration stage should now be gone.
>
> In terms of the specific version, as noted above I chose the version of
> meson present in Ubuntu 22.04 as a reasonable baseline. Both debian stable,
> and debian old-stable have newer versions than that in them. For the RHEL
> line, I'm not sure what the baseline is, but I believe that RHEL 8 shipped
> originally with a meson version even older than 0.57, so moving to a later
> one I hope doesn't matter. [I wasn't easily able to find out from Google
> what the current meson version in RHEL 8/9/10 is]

Cc: Timothy for .rpm distributions, Luca for .deb.

I prefer we get some acks from distributions people.
Also, this patch requires coordination with the CI guys (as can be
seen in patchwork, many envs are using old versions of meson).


-- 
David Marchand

