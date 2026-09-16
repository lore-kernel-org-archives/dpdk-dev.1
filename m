Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D02A2C88E77
	for <dpdk-dev@archiver.kernel.org>; Wed, 16 Sep 2026 11:48:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E6A854067D;
	Wed, 16 Sep 2026 13:48:09 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id D6BAB402B0
 for <dev@dpdk.org>; Wed, 16 Sep 2026 13:48:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789559288;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dJZc4d4vw5wiM3eCcW2JIhkF5KdCTWNDL5OfuZOdMuo=;
 b=RsPz1fs5GWd++uu86G89M6l+tNLk3v/kjN7gsgsV82LrOruPb0J1w+sMXUtLGhkEitXE1k
 0+oZ7SMB0B8gBJ+zsd1chj8aAM5EupP0+M1seo3yw0fh3p67Ce8oZTj1QkTSVtEeTaRpkz
 QZsdgYPe6Lc24hKyGVXazxnV5StU09w=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-475-_O7RXpbaPk-p3yTvnRn-og-1; Wed, 16 Sep 2026 07:48:06 -0400
X-MC-Unique: _O7RXpbaPk-p3yTvnRn-og-1
X-Mimecast-MFC-AGG-ID: _O7RXpbaPk-p3yTvnRn-og_1789559285
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-3a592f20c7cso29182901fa.0
 for <dev@dpdk.org>; Wed, 16 Sep 2026 04:48:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789559285; x=1790164085;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=dJZc4d4vw5wiM3eCcW2JIhkF5KdCTWNDL5OfuZOdMuo=;
 b=a26CVgEaCb1SvUEAJZHVktDR52O0PVV0fM3mNn1b3C4Uvqn475htSOyxd13HtcDpFN
 rsRKMI91NOzbRHI3L5er1nTWo/zVe4cNQJjm9KiEU92HjCHBnEsfDG31Cs1GPaEK0weP
 Ph1duNDvWhIdHB+7NS/iodTgiJic6S0xGb3TfgG35Fi2m7h4zIhDGf2ectGgVYDI5ir1
 MCIxCqhiVy8Eof20h9uWaSbC9ZItlHQOfssQ+bgZ9VF34CUuh5hPKf6CBKDYzkieoC3E
 dKDpIG1BdnxTLlNtO/JL92iSGvQtt30P+02E1trBZrlerf6MpjGFh+4fyswYDX1a45+u
 WMoA==
X-Gm-Message-State: AFuF++mnTiEVflV33D/2qi4kC2i4ptLG7Qix273d8rZtui+z1sLDpg1i
 eFF9GyO19kLJAINjzvL4jZxh16F0x+l93hDbIUWWGYsAqARQFIYoK4IC2nk/3DqXsemd0orm3WP
 6cSsM/VXc4rHdQG5GV+Rnk7HbceiRZvesiF80mhw3Y/e5tXISookGYuvUTJgTCenfpHAQ1Ro20m
 zlEgyC2Za1aqqDXG+4qyn/PhFJE0w=
X-Gm-Gg: AYBFou28Cqf3W/AYHm0T05JgZcTPOVUpXT9Qq8PXzhR4nPkO+v+iCapY1JSceS70HFx
 vktuI5ZApb1hxJwf/TpfBokUwL/h5QuswO71zf8TUMKTGq+/H/UCSe3uXcKSrna/1cqtDZed6FR
 bse65UaJ8OliZrIbCxS55hQGe+JpaDJP3YBDhCz7+ZwCXl2NDFUpcT2wXxq4E+2BUnzVujNxlHY
 q+1rcWjfXAVPkBdW4EMHlYmFABACvU0iih5DRWQM+i6hUx5
X-Received: by 2002:a05:6512:3e07:b0:5b6:95e:87ce with SMTP id
 2adb3069b0e04-5b8b660a94fmr1267481e87.2.1789559284735; 
 Wed, 16 Sep 2026 04:48:04 -0700 (PDT)
X-Received: by 2002:a05:6512:3e07:b0:5b6:95e:87ce with SMTP id
 2adb3069b0e04-5b8b660a94fmr1267463e87.2.1789559284282; Wed, 16 Sep 2026
 04:48:04 -0700 (PDT)
MIME-Version: 1.0
References: <20250925130438.3072610-1-david.marchand@redhat.com>
 <20260113080624.2230169-1-david.marchand@redhat.com>
In-Reply-To: <20260113080624.2230169-1-david.marchand@redhat.com>
From: David Marchand <david.marchand@redhat.com>
Date: Wed, 16 Sep 2026 13:47:52 +0200
X-Gm-Features: AcwNN1WZe_e3ELkeH50OFvPmD0Sq8tPyHHlrexO32WGRpbKj4F5q_EvMVEep2ME
Message-ID: <CAJFAV8wyzO8WX+U+fw-ok4JSYtbSobn3bAjv6+a8SBCwGUuYqQ@mail.gmail.com>
Subject: Re: [PATCH v2] buildtools: add symbol check to Windows
To: dev@dpdk.org
Cc: andremue@linux.microsoft.com, thomas@monjalon.net, 
 bruce.richardson@intel.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: qoWeebDKClW7bygmoiOE_6HTCNKtMt6oS_-14E9geek_1789559285
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

On Tue, 13 Jan 2026 at 09:06, David Marchand <david.marchand@redhat.com> wrote:
>
> The symbol check was implemented so far with shell scripts, relying
> on objdump and other unix tools preventing it from being run on Windows.
>
> There was also an ask from some maintainers to convert this type of
> developer checks to python scripts, to make it easier to extend and
> maintain.
>
> The new implementation still performs the four consistency checks:
> - symbols exported as experimental but missing __rte_experimental flag,
> - symbols flagged as experimental but missing export declaration,
> - symbols exported as internal but missing __rte_internal flag,
> - symbols flagged as internal but missing export declaration,
>
> The initial implementation was done relying on Claude Code
> (asking it to reimplement the existing check after it analysed
> the current build flow).
>
> I then cleaned up the python script, removed dumb comments, fixed coding
> style, fixed MAINTAINERS, fixed some dumb issues (like definition order in
> buildtools/meson.build).
>
> Actual implementation on Windows seems doable now but is left to
> an interested party.
>
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> ---
> Changes since v1:
> - asked Claude to fix compatiblity with Python 3.6,
> - removed unused field ArchiveMember.size,

Not much interest, it seems.

I marked it as RFC in patchwork, and I'll leave it there if someone
wants to pick it up in the future.


-- 
David Marchand

