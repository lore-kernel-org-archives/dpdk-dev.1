Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9BB9C7115B
	for <dpdk-dev@archiver.kernel.org>; Mon, 23 Jun 2025 16:02:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 072C6402DD;
	Mon, 23 Jun 2025 18:02:00 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 0FA76402AE
 for <dev@dpdk.org>; Mon, 23 Jun 2025 18:01:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750694518;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AGT1lxd+2ujDkGc70bSo7Dxr7azW7+zcJvDsC3wZ6v0=;
 b=MkNNySX8Orr0QrhxeNygIlmrmf/lnCeYd5gQ0oApc/j4lIYUBbSKVGiG7DB7N95FXBn0mM
 0fudk8ZN9IMmytZCaTF9Q34m+3PhTvJZwLR30aHxZUMnYAZ4mkFSYYzglk2bkL1kuppNKX
 wUm64Ko3UjblXriM06bjkTk7hhd3wDo=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-656-iwZmyY6pN8idfJqg4G5rYw-1; Mon, 23 Jun 2025 12:01:57 -0400
X-MC-Unique: iwZmyY6pN8idfJqg4G5rYw-1
X-Mimecast-MFC-AGG-ID: iwZmyY6pN8idfJqg4G5rYw_1750694515
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-553b5884201so3353612e87.3
 for <dev@dpdk.org>; Mon, 23 Jun 2025 09:01:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750694515; x=1751299315;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AGT1lxd+2ujDkGc70bSo7Dxr7azW7+zcJvDsC3wZ6v0=;
 b=emX6CsLcZXoiPRWFPpDEFLQzuNamZgRAWk+oysOsLboPadgwXH/yysAN8Mk6weLAVS
 HxcQCO4mMs1JuAchYYpIbSMAA+jonYzPry/U/kkxlcm+wjG5MQo+QDnW1U3jaFPVcOii
 qzrMiJ5YUrZiLrLNWvwcxFrICilWXKAmiluq2AoQbSoW7XscmOEZoAu5d/iiFfU0iZox
 8t/qDkAWh3ODTnJnSg1Zt/h17xJT8sqh7wKDeJ2nV54QU9raOIL6VyqQsKFF0x4mI+ax
 PY6hR9XdQDdvQoqn4v/FZmh9DJuY/bMVhT5DJzvRVxX6dgej5XfJJ16EFXU2n5cLN4A9
 lNzA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWeLmOhTh9dUybRuU+dOjVUZkFv7hgvEUnOw5vRSx5Ehv/4bfd3hyTaPyNSU/5HVmkNlUE=@dpdk.org
X-Gm-Message-State: AOJu0YyTpe5666sivxFvJxBzYEH8VwyZYa8JiAmGFpEnqa49WXYuJ6DK
 ObFWEZJqW6aX8GJabXV9/mi3KaRHfbzaqH0RYsBUX94NqM9adyh/kjnjsO/nTnNjuSIlUTjzdDU
 ZQr+2ZGhF3j60kyv8/J99PWems4DkeoJ1XaB55I3CBarByYEt9uEFzx4qosAXcL46FcddOpfCEB
 JwSuFjlZqwkZ6Ny2y6zQs=
X-Gm-Gg: ASbGncugNhdmlcCwAOIgq8M4x0HD1Amg/61UW1BkjJ37jQolLNv8n+hYzPwWL2RQqB4
 yYYZw7Rvs5yBOR8Sh1BLK1e6kTS2eK5Z7/owOfj7CsZTt8vXmeK0YE8mInlzrvLEllmgnrSCRfx
 yEAlgX5w==
X-Received: by 2002:a05:6512:3e04:b0:553:296b:a62 with SMTP id
 2adb3069b0e04-553e3b99018mr4372986e87.12.1750694513342; 
 Mon, 23 Jun 2025 09:01:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFTc27fzKDVoDQoSgWkXeuFoUywwU8VrDFFdC0epEj+1UCpgLobZmYv2wv/k2fgAN+/CapfSNVo7cJthjWNevs=
X-Received: by 2002:a05:6512:3e04:b0:553:296b:a62 with SMTP id
 2adb3069b0e04-553e3b99018mr4372879e87.12.1750694511834; Mon, 23 Jun 2025
 09:01:51 -0700 (PDT)
MIME-Version: 1.0
References: <20250313113829.1480907-1-bruce.richardson@intel.com>
 <20250527152913.279011-1-bruce.richardson@intel.com>
 <5697443.hdfAi7Kttb@thomas>
In-Reply-To: <5697443.hdfAi7Kttb@thomas>
From: David Marchand <david.marchand@redhat.com>
Date: Mon, 23 Jun 2025 18:01:40 +0200
X-Gm-Features: AX0GCFs-po-MEMqMS2x0NHC6cEEbf_hKoYJfsuEYU3fyoIS6RZhCGHFPOyI4oPU
Message-ID: <CAJFAV8wActb8OErY7T1qfk7mzmcYue+Am12Hbr=7nybNP0VYsg@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] lcore options cleanup
To: Thomas Monjalon <thomas@monjalon.net>
Cc: Bruce Richardson <bruce.richardson@intel.com>, dev@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: vlRpusqFbS7KtGZz3wNFEAmwuNQcx0avv6aYiHuOEG0_1750694515
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

On Sun, Jun 8, 2025 at 11:12=E2=80=AFPM Thomas Monjalon <thomas@monjalon.ne=
t> wrote:
>
> 27/05/2025 17:29, Bruce Richardson:
> > This patchset performs some basic cleanup of EAL lcore arguments before
> > any more serious work is done on them (as discussed in previous patchse=
t
> > revisions).
> >
> > * mark the old coremask parameter (-c) and service core mask (-s) as
> >   deprecated, so they can be dropped in future. Everything should now b=
e
> >   done using core lists where possible.
> > * consolidate the, previously separate but similar, "-l" and "--lcores"
> >   flags into just short and long versions of the same thing. This does
> >   not affect the "--lcores" flag at all, but expands the scope of what
> >   was possible with "-l".
> > * Add documentation of examples of use of the -l/--lcores parameter
> >
> > V5: adjust the examples in patch 3, to only use quotes where necessary
> >   and explain in a note why they are sometimes used in the examples.
> >
> > Bruce Richardson (3):
> >   eal: deprecate old coremask-based EAL parameters
> >   eal: merge corelist and core mapping options
> >   doc: provide examples of using lcores EAL parameter
>
> This first step looks reasonnable,
> but we need more acks for the deprecation.
>
> Applied without the first patch deprecating the famous -c option,
> pending for a later stage in this release cycle.

Sorry, I wanted to review this series sooner.
It looks good to me, even though it is already applied.

The deprecation notice lgtm, I sent some comments on it.


--=20
David Marchand

