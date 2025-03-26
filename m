Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A8B4C3600B
	for <dpdk-dev@archiver.kernel.org>; Wed, 26 Mar 2025 13:54:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1AA6B402DF;
	Wed, 26 Mar 2025 14:54:49 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 180B6402DA
 for <dev@dpdk.org>; Wed, 26 Mar 2025 14:54:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742997287;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0mZCZw619pbIzciXM/2QJGms/95PsieFNbdyUdeS4Dk=;
 b=TImmoVE+V37EuyzLNM77jsQaqxq4zN/nMJ6rv1y200OyviWyVqlXXwDjow1aidhROyvGLv
 k286fPy0ChQwnD4ZGmxmnsuY+h7N2KBYbILWkGw6wi0FYYwRMNG7ddUHew25/5OVVAHu7u
 NFAtBZA1nBohloEzmauJesXz/zBhrq0=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-446-x8vLD-3jN9S_9XXuorUYdQ-1; Wed, 26 Mar 2025 09:54:46 -0400
X-MC-Unique: x8vLD-3jN9S_9XXuorUYdQ-1
X-Mimecast-MFC-AGG-ID: x8vLD-3jN9S_9XXuorUYdQ_1742997285
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-54991f28058so2286463e87.3
 for <dev@dpdk.org>; Wed, 26 Mar 2025 06:54:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742997285; x=1743602085;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0mZCZw619pbIzciXM/2QJGms/95PsieFNbdyUdeS4Dk=;
 b=hetHHIil18qxlqeUOwescsqqmE7sTOkgPWnMCUs4TLQIod9V3kDmopeLe7YaXIXC+r
 0M/M7+dqzKC2wL0NP1FgxFs/tZHGc1ULAggMXGus1U1OSPnZ4ZxgCDLjCiRqw4PGNCgc
 iVtH8yB+clBzhnIFVwibqtJ1/Tf+w/+SZTAANnjZN+OrkLf3Lahuz6YcwM5TSHlKARj4
 pU8uN9Jd/XcxgHsxaK2GzcnptBX5eCd/vQ5RYGAhrYjJ+2QDxM3MmzJUqKBXkFy9Eixg
 TvRqU7z6xxe4g0SYhqRnzBkU5gIdtfmyhKVSgNLroEGwmQq+QLu2Ue2kwzk8Ldi65zEI
 FnPg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVcEM60VI4rB6NWNTIpHIL+2uI+cirtw/QL/O2EYr8QahhaTidGQUi7vvhp3ZuZgeHZQ/4=@dpdk.org
X-Gm-Message-State: AOJu0Yygl0GNDsUMsoiKQvbrvNeAnumOEAi9v5ISz/3BVt5eeC5w2dbX
 IIXKokNSJQdyvbHD6q7FPNRF68n+RUjlyeRdoUXnIDuQUmyjXSTriQ3h6Nq7Vm02ZpNF78/5CFo
 QGfseVwwMNdO5B9YPNKAF08wUWoXvrLSfN5iO8n8a3KlN7VtGOQ7HmYt14+9g3xIPuzAivDuwnQ
 FXpuu5FXtrSzsGvqw=
X-Gm-Gg: ASbGncs2GMJEj83X3seethVEXGlU+KZnedYktwyqzNUpxgQin8ULdigCM3/etHIiLcs
 SrkNh6XrU2+8/A7xM630Khv/Fnbb0hoziq5gPzYgGJ4HzPrFxsdEqh0VhYwqWbRrsqOWjoMKDwY
 U=
X-Received: by 2002:a05:6512:ea7:b0:545:2eca:863 with SMTP id
 2adb3069b0e04-54ad64f9f7fmr6677719e87.42.1742997284795; 
 Wed, 26 Mar 2025 06:54:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHEBslxsG3wHuI/VUhIo/a2cWGzPQca8I1+Ei+TylShv3jkQO/ttuyJ0nk42PiW6gmjaYogD9pZwkEk6HNMcZE=
X-Received: by 2002:a05:6512:ea7:b0:545:2eca:863 with SMTP id
 2adb3069b0e04-54ad64f9f7fmr6677708e87.42.1742997284326; Wed, 26 Mar 2025
 06:54:44 -0700 (PDT)
MIME-Version: 1.0
References: <20250305212349.2036410-1-david.marchand@redhat.com>
 <20250317154308.2782689-1-david.marchand@redhat.com>
 <CAJFAV8xiZB8r9=5D2tpc9Onrh+7582ZzM8cY_2VHojaQ7xe=BQ@mail.gmail.com>
 <Z-QC4XwlHXSlFBHe@bricha3-mobl1.ger.corp.intel.com>
In-Reply-To: <Z-QC4XwlHXSlFBHe@bricha3-mobl1.ger.corp.intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Wed, 26 Mar 2025 14:54:32 +0100
X-Gm-Features: AQ5f1JpGXWZgC_etMvGP0vc2GS-qf9KIWODly8z7y83rdYXdXRIGGQIAak0wA5s
Message-ID: <CAJFAV8zQqVFz8ChfgY8MKsy-dBJJEtxHs2vTmvB1L7CDMOkyTg@mail.gmail.com>
Subject: Re: [RFC v4 0/8] Symbol versioning and export rework
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: thomas@monjalon.net, dev@dpdk.org, andremue@linux.microsoft.com, 
 dpdk-techboard <techboard@dpdk.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: VDn4IqsfSfkpeZfPOsMt1lbIPtJJ84pFZBpzvPFMgdw_1742997285
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Wed, Mar 26, 2025 2:37=E2=80=AFPM Bruce Richardson
<bruce.richardson@intel.com> wrote:
> > - I am considering making rte_function_versioning.h a non exported
> > header (precisely, moving it to buildtools/ and maybe renaming it).
> >
> > This header contains macros not prefixed with RTE_.
> > Using it requires some build trick (see use_function_versioning).
> > And I don't see symbol versioning as a MUST infrastructure that DPDK
> > needs to provide to datapath applications.
> >
> > Yet technically, this change would be an API breakage if some
> > applications indeed relied on it.
> >
>
> Is it not needed for exporting if an exported library header had versione=
d
> symbols is in?

That could be, though we don't expose such versionned symbols atm (and
I don't think we ever did in DPDK).
The only public symbol is always the symbol implemented for the latest
ABI for newly compiled applications.

Wrt to your other comment on the header(s) location, I don't mind
moving to lib/eal/common.


--=20
David Marchand

