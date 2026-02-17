Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C44FAE9A028
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Feb 2026 17:53:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7737940649;
	Tue, 17 Feb 2026 18:53:37 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 5F6D840261
 for <dev@dpdk.org>; Tue, 17 Feb 2026 18:53:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771350815;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SdeX7O+MoejHbGuhOngyLmt52gT9w+TBxSMGvjC9GxI=;
 b=IEuRqRwsWuwRe5N1OkKhkRAUt5HyMjN6IzrnN1k6JR6nFayuL16yJfvj4arrDo6OAAFkQh
 jqGWsXpLV25P3VZb3HW3eb4KKYsyM9cW/MZ9BIE1TuQPq5F5d5DGyJ7Ubk7uPXVnRtaExM
 l/1ZroIi+SlmXqzy1KeMz82NVb9gJ6w=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-684-wKD8IrOGO_mSjRGgMgISVQ-1; Tue, 17 Feb 2026 12:53:34 -0500
X-MC-Unique: wKD8IrOGO_mSjRGgMgISVQ-1
X-Mimecast-MFC-AGG-ID: wKD8IrOGO_mSjRGgMgISVQ_1771350813
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-3870a6d4ca9so27698561fa.1
 for <dev@dpdk.org>; Tue, 17 Feb 2026 09:53:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771350813; x=1771955613;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SdeX7O+MoejHbGuhOngyLmt52gT9w+TBxSMGvjC9GxI=;
 b=cp7/61FBjDPQBS+GcUWv9fB6MdgBtA7cgxXsWegVzMV6smvobrAI/G6BGtXkdusFqf
 CCQyTC0cra80DgIyldpifWtUoRwk0yCC7jHPQpP4tR6F4N0x1kAsKx4n92ZC8hr57Vmz
 7JF+3838VzEKhUdJqok42Zh72aTxqCH4/HZDpsqHIHcdpinfpfOQY5uEd7O3fyyGZR+E
 2b5afFKR2zgYEr1lChkPPJQYtzvJBkXMiryBs62LCV31NhxsCWbvWYeTVq2lnsQRKfiq
 +K7ioGAwZ1S/vnBQxhajhD6kkbFaleIltvtcFJuVZO9hf/TWxEs0BJGDfkX3Po7eauUd
 D0NQ==
X-Gm-Message-State: AOJu0YyzdTLQoxxz1Nza3fqUXVN2nG0WiEM9l/+ou7lkLMVVtL3h1XtI
 YS0/EedEXWUwPtDh13EMBmrPxTyDxOq5N5W5hQjGDC98RiRl/ajpfo/JRHTh5ptKoyzvh1Gh/GJ
 XdJacf/ye9rJqb+z/Uwk79lOhd3v3tH1JoBFNxoJm73j2jCjrD3MB2MLtba88BkqYMJiF/l98Gj
 KZ4mRe8Jen6R4CiB1zCrA=
X-Gm-Gg: AZuq6aKHZXeWQva3wSpCkjIP+M0Llgo6cJsS7AE2MgjJbDK4SBabXufMFnkro3e5eVP
 PLnTgi9LG6RZQ3jzQpnIBigL0GSN6ILw7hR6vk2gHhXuoc6nSKUKKu99brNLFQV/WFgCOTYvCQt
 90j194CaEhARaHUzvkqOkewo3okR6mqW3FmYm9SGI5wXnpKUedT1OawSm0Ly+glcFkGjLs1Df2D
 +HgmCDaanAhC1HuHnlaz9ayFyYuICkHznBook17Br0e/VJDtekIcVEWyB+wexRNdly4Rw==
X-Received: by 2002:a2e:b8c3:0:b0:388:22dd:939f with SMTP id
 38308e7fff4ca-38822dd95b6mr34066571fa.8.1771350812819; 
 Tue, 17 Feb 2026 09:53:32 -0800 (PST)
X-Received: by 2002:a2e:b8c3:0:b0:388:22dd:939f with SMTP id
 38308e7fff4ca-38822dd95b6mr34066451fa.8.1771350812282; Tue, 17 Feb 2026
 09:53:32 -0800 (PST)
MIME-Version: 1.0
References: <20260123162104.1854187-1-thierry.herbelot@6wind.com>
 <20260217124844.1458644-1-bruce.richardson@intel.com>
In-Reply-To: <20260217124844.1458644-1-bruce.richardson@intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Tue, 17 Feb 2026 18:53:20 +0100
X-Gm-Features: AaiRm53Qov9f-TrzybQmhvjrgu9UTqzdze4MeEV6mcmqFUos8_ZNTFC0xsYAJ7M
Message-ID: <CAJFAV8wcc_+6AY2029ZV8=ft9qYmbztStodF88tVXUS_UPPXMw@mail.gmail.com>
Subject: Re: [PATCH] usertools/pmdinfo: fix search for PMD info string
To: Bruce Richardson <bruce.richardson@intel.com>, thierry.herbelot@6wind.com
Cc: dev@dpdk.org, rjarry@redhat.com, stable@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: NvOcLf_EwRAeqd3aPytx_NOkBqMFtuHzfiPbuwhhFhs_1771350813
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

On Tue, 17 Feb 2026 at 13:49, Bruce Richardson
<bruce.richardson@intel.com> wrote:
>
> The PMD_INFO_STRING constant string is not guaranteed to appear in the
> output binary immediately after an unprintable character. Because of
> this, in some cases the information for a driver could be missed by the
> PMD info script as it only checks for the prefix at the start of strings
> that it finds. Change the script to use "s.find()" rather than
> "s.startswith()" to fix this issue.
>
> Fixes: 0ce3cf4afd04 ("usertools/pmdinfo: rewrite simpler script")
> Cc: stable@dpdk.org
>
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>

Surprising we hit this issue only now.
Acked-by: David Marchand <david.marchand@redhat.com>

It would be good to hear back from the initial reporter.


-- 
David Marchand

