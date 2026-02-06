Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D0DEEB28FA
	for <dpdk-dev@archiver.kernel.org>; Fri,  6 Feb 2026 09:42:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 35BCC4029A;
	Fri,  6 Feb 2026 10:42:16 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 43CAB40293
 for <dev@dpdk.org>; Fri,  6 Feb 2026 10:42:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770370933;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3XMCv3l0UsO9JvXosJBX1MvywayGrEQuZxqtHKusZ/A=;
 b=HivruBfEuD3nCYc9MRUBDMoV1prIVSbEWrCsXm4aqzOe+Wdi1i8eW8NJNduQAROq9z71hF
 cvHLAuAhs+FB+TVI/thQ+4UFGqez4FOlpvRYHRzQKwCuRE6i4yIoIxG5IqeC5Ldf66vFjv
 5yFNAzM4QzSZyb8WpRO5JU3ijTKPn8c=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-246-OV7QQR2sP2eM2N6xwhkLhg-1; Fri, 06 Feb 2026 04:42:12 -0500
X-MC-Unique: OV7QQR2sP2eM2N6xwhkLhg-1
X-Mimecast-MFC-AGG-ID: OV7QQR2sP2eM2N6xwhkLhg_1770370931
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-38316f5d849so13387131fa.1
 for <dev@dpdk.org>; Fri, 06 Feb 2026 01:42:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770370931; x=1770975731;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3XMCv3l0UsO9JvXosJBX1MvywayGrEQuZxqtHKusZ/A=;
 b=deKGCvYVUISEXqKgWuGVRY0+LS+mG7FWeVOHIBGqxa7jLE6nx9pvSsB42WMztIP86F
 6Yj1srq0T4Ir0SAovYIP9l6s+r7mivR/E1ykSLbIYS6ZkavY5eu4Hxs2cVld57ehIro4
 Q1VtFhHXQU4DlVjh/TMAbX7n4ZlcY3+JcbSUm4VF8CY8lGZ+vaCiv7T+ibq6C5EglJvH
 UCt0XCdH6e32jqe5m6JTtbeUqC2soa+QyC2bvq6QgOna6pJUuM/Byjcgk6CYE16uBhdC
 MTSLmp46J+asE40NraF/hm2szEEfHVaWwsJKf0H0lZzbHaMJXSppahLMEyVvl1Bbgttl
 9W4Q==
X-Gm-Message-State: AOJu0YxGhcLSqIuWI06yqBJEK+YEAR4aG+epiqnmw3KnJPhWw7OjUEgV
 Mj2NPYBvcndPXq8aWQQvZ7umbcFDTlblXssLkwFxpDcksvTRFJ1N7tpKod6AaeeJLcJb3iXBFbh
 8zkVgoa8yUvoue1S6wJ/7X/sbnvcHWp7fc4AcrRqDDwrknCpyX/JqA2k3df/sAgWOueVDXPXvBD
 +Cvs1sBTZDGmgbXPqF4PP5mIuLItY=
X-Gm-Gg: AZuq6aKbfQjftTJBgsRApTHWqHn7BDQcuRABKzMtE80oxrVOJR4kMggh8PRdWI1PP7m
 0gUS7oZtLV4Uzi9Pm6EHBalofvQplaB0M5/PlD8V738VMO5K2xRhZqk6FtdHOpLYjNeQ/XwcOfd
 oTiMGZPojkIZJz9L+ZQDqtxK8zMoBWW7Z3MpSXRTrXz4oqQIRIvm4qIUZSK2A0mAsDCeekq+Fzg
 ob3ZGdwDZEf2KEyljeUpRpS/EWiMOuHG2qLiLnPMmttOS0ERQL88mPCKA==
X-Received: by 2002:a05:651c:40c1:b0:386:8faf:eedc with SMTP id
 38308e7fff4ca-386a0c07f39mr15481251fa.15.1770370930889; 
 Fri, 06 Feb 2026 01:42:10 -0800 (PST)
X-Received: by 2002:a05:651c:40c1:b0:386:8faf:eedc with SMTP id
 38308e7fff4ca-386a0c07f39mr15481161fa.15.1770370930402; Fri, 06 Feb 2026
 01:42:10 -0800 (PST)
MIME-Version: 1.0
References: <20260206083649.2625478-1-david.marchand@redhat.com>
 <3359303.NG923GbCHz@thomas>
In-Reply-To: <3359303.NG923GbCHz@thomas>
From: David Marchand <david.marchand@redhat.com>
Date: Fri, 6 Feb 2026 10:41:57 +0100
X-Gm-Features: AZwV_QhC1zE62StDYzMDS8cj_5l4uQp8UCRfmZzHvYwo21Pg-RhObhrHybPSARc
Message-ID: <CAJFAV8zW_Cjf_mrvewN0N1AEm_ihWBMWqQ1_d1EjSQvnAu7bOw@mail.gmail.com>
Subject: Re: [PATCH] devtools: fix indent in SPDX check
To: Thomas Monjalon <thomas@monjalon.net>
Cc: dev@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ZfyTTicuGBaETguwGUs5Aa-h5v7J42UiBAK7RjryeF4_1770370931
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

On Fri, 6 Feb 2026 at 10:37, Thomas Monjalon <thomas@monjalon.net> wrote:
>
> 06/02/2026 09:36, David Marchand:
> > We have a mix of tabs and spaces.
> > Clean this up.
>
> Most shell scripts in devtools are indented with tabs.
> So replacing spaces with tabs makes more sense here.

I don't mind changing it all.


> And of course, if someone asks, vim is better than emacs ;)

Obviously yes.


-- 
David Marchand

