Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1A01C55167
	for <dpdk-dev@archiver.kernel.org>; Fri, 31 Jul 2026 06:04:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 98BEB4028B;
	Fri, 31 Jul 2026 08:04:15 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 4F85840280
 for <dev@dpdk.org>; Fri, 31 Jul 2026 08:04:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785477853;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=r1p1qAPSxfwJZDl8bjLJZbpF/CZLvFg2I1shMSFXR0g=;
 b=Z25qD/LCEgMA+tSvNNgosplahmpDg8gXVgYx9r3rGU7/1bFl9xi/WcTOgkY7FbI0mL3qp1
 468JuhSKVccQnf0pxUpPFOf76tIPoU4t8npoXbZiysm+hF67EJt8bxCWnNGX4HE3/3WXBK
 ++/AWgdr5CQ/Wc0Xli2FcMm/0SaAYgo=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-146-LDqSQ5mGN4ehPYfthWsZOg-1; Fri, 31 Jul 2026 02:04:11 -0400
X-MC-Unique: LDqSQ5mGN4ehPYfthWsZOg-1
X-Mimecast-MFC-AGG-ID: LDqSQ5mGN4ehPYfthWsZOg_1785477850
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-39f71fd0285so2155211fa.0
 for <dev@dpdk.org>; Thu, 30 Jul 2026 23:04:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785477850; x=1786082650;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=r1p1qAPSxfwJZDl8bjLJZbpF/CZLvFg2I1shMSFXR0g=;
 b=r5IZ6IJb3Jq7z6HoQODFQ+BwSq2VF8efe52w0mR7+qBdAAAQWYHTO8a09NBHSeLYBd
 L9COit/W9q1IZb/tJDlL+bXBdCfCcDwn2dEnexDx4z0sYqZ2xVrFUPflbd80sMsrruSi
 v9YcZPRMldAcMFC+PFKi/KDQ3MXriBbL812S+6+ZN3VGnqi6LwsBFD1zsKEZ/B01sUZb
 QUR8PpIta1Ll8Y0OK6K/1EMydgtiNQyir4voNqtTxLpmnG1ayrR0IIBN6Y8riShbGztR
 irhKdqp0RFJlQ+hTjwVidbnh86L+CWR1An5loHBZc9YA9iB5s/7hEOuMEaxl8RHUsKRF
 R6pw==
X-Gm-Message-State: AOJu0YxJcOTepBEOwcDbJVwT3W9I70qu6VMnigw5Wb+aEw2KyREHIU2d
 6Mxtaz+yS4aPqZqvp/q0oEZldxPBhoEAGkJF/1bgvnykuYir+QKZJ/GeJ6GuTERhp/OEgY4XLOO
 uKclx3cr4YoFnVIVYrYtfg8Z8eRryybW8Ww96mJ5VJRD7ONQV2ExD/dud4daaE7QSWoduMH5Azt
 McQLiK9dbBT57Mgv/i/vflqmWwSXo=
X-Gm-Gg: AR+sD13UHfiHpqclhwdcsmRvXK9dguwok/9fRZtO8yAFE34sMHyykhU5ukWt68iIU7k
 7IoVs+3lxWAs264N1KQSkjYqS5xH+6L10SsSIx+pf9ZnX/F3h0pc2PM1TpUgRMY6DukuSiUL2Dd
 NfR/jPdSVX5QSvRCHUBYz1BuUvLx99kOkABui/a1iDj2+bkQIrsCHsogxv8Rnr7yDTd7O8ohHGC
 gab58sHHyt882XTwh5fEWa7sHEeJNNOw804fk1T36AiC+c0
X-Received: by 2002:a05:6512:686:b0:5ae:bd27:a13 with SMTP id
 2adb3069b0e04-5b2e203d455mr159335e87.54.1785477849758; 
 Thu, 30 Jul 2026 23:04:09 -0700 (PDT)
X-Received: by 2002:a05:6512:686:b0:5ae:bd27:a13 with SMTP id
 2adb3069b0e04-5b2e203d455mr159321e87.54.1785477849123; Thu, 30 Jul 2026
 23:04:09 -0700 (PDT)
MIME-Version: 1.0
References: <20260730113846.25d8568e@phoenix.local>
In-Reply-To: <20260730113846.25d8568e@phoenix.local>
From: David Marchand <david.marchand@redhat.com>
Date: Fri, 31 Jul 2026 08:03:55 +0200
X-Gm-Features: AUfX_myR7WWEPZthADeX-96hERtRsGQd0PXKY5CgNWD-LvrG6d1NnxBAsEUukuM
Message-ID: <CAJFAV8w4T_rCyLVYPbQM=06xo=AwSoFk1f71+yJP7PZvtaPUUw@mail.gmail.com>
Subject: Re: stdio is not a spelling error!
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, Thomas Monjalon <thomas@monjalon.net>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: GFQADXyxlLMzRJDSn7S7eyZH79O-0jO-G7zrWuOwdjo_1785477850
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

On Thu, 30 Jul 2026 at 20:39, Stephen Hemminger
<stephen@networkplumber.org> wrote:
>
> Is there a way to get stdio  into the allowed dictionary for codespell in CI.
>
> CI reports this (a lot), I fixed it locally by having a revised codespell dict.
>
> WARNING:TYPO_SPELLING: 'stdio' may be misspelled - perhaps 'studio'?
> #347: FILE: lib/capture/capture.c:13:
> +#include <stdio.h>
>            ^^^^^
>
> WARNING:TYPO_SPELLING: 'stdio' may be misspelled - perhaps 'studio'?
> #1610: FILE: lib/capture/filter.c:6:
> +#include <stdio.h>
>            ^^^^^

It seems dpdk.org dictionnary used by checkpatch was not generated
with devtools/build-dict.sh (that filters stdio).
I fixed it manually.


-- 
David Marchand

