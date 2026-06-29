Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BE82C43458
	for <dpdk-dev@archiver.kernel.org>; Mon, 29 Jun 2026 09:28:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E001240299;
	Mon, 29 Jun 2026 11:28:34 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 0BA4C4021F
 for <dev@dpdk.org>; Mon, 29 Jun 2026 11:28:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782725312;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wbOIyKCeKycB2jKBGqur+4xn7cVGbQjef1Gvgyx+Eik=;
 b=UJhKKOnjL8lhVjwp+4vn7lWbmEcMs1Huh0miJSD0NcNoCTeG/WtQ3yNfNNThC5lUEPg5CS
 DD4KymlWHF3qJRzl+O0obKKlZHhHBGcesIZkrJoK8TUixe7xX1W4G3hZ5nPdQFiSbzMaXI
 /qw52oGjlIbc28O6d/tPWTNzciKp4os=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-ej3DCAwXM3KTkGg5XRP9Mg-1; Mon, 29 Jun 2026 05:28:30 -0400
X-MC-Unique: ej3DCAwXM3KTkGg5XRP9Mg-1
X-Mimecast-MFC-AGG-ID: ej3DCAwXM3KTkGg5XRP9Mg_1782725309
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-3965cf89797so21531271fa.0
 for <dev@dpdk.org>; Mon, 29 Jun 2026 02:28:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782725309; x=1783330109;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wbOIyKCeKycB2jKBGqur+4xn7cVGbQjef1Gvgyx+Eik=;
 b=F970ZLRuDIKNKI+wCsyEfkbxcMALrgyehJY8jVVVkd7w3dhK3xmw+qCknDBMlNF6Ao
 IOU7X2981JLyjpoLmOj792nz2gtIn2TBuEvSw1c5erH3TciMn0I+IZ53oKHeijUhE8LW
 HbUv8PfK2PzpchndtPcHcFTfYTqnMCHO0zIIaYJ5ExkwrEfafRzoQ36d1wqz9CW3Nzo+
 N1nWQGl7T81DGpsG2yZdLCZoaZ4QTvmZq762gUsqqM9Hkvz9V8G4k05Q8cnipSnJx1VU
 XFZfzMSyum9e5xDjHKPAqGJChSXe7HN9XpE3z8zzzH3IfaFaxTpiEoqSszCugA/PCcJ9
 5KLQ==
X-Gm-Message-State: AOJu0Ywp0dnCbK7hk8QCCqhPexsqm1dFF2MoYSXxHlbpbRYgtXfFpom2
 lcp9NFU1pra38ys87wnliiNexsMUceysJbbu7u2dlyzEklQ3NqS5YMiLjm935/pd30eJJm+T1Zy
 XKwauuDj8adtGP4pvlBkHR5PnOSm/kCEkp4FzWtERiFtgkrmYzlAQKDkP0hXNXg60sB8Ti85hOA
 h5wIziM2JhmrMPBNbN4Hw=
X-Gm-Gg: AfdE7cmN3ucqCIKXW+EE+TubGoYABKiEjEBcxlJGFRdWu/WVWLnPOyl9iDH8Vb3CKX5
 hvWLrmpJ0DFmRawzgvPKRMdfoJRSfB9ZLdIj/IZU/ENg/XcFBy0aqsnYdgWUEH051hcbQmc/PV9
 MGonrKtOFQT5Pv/MC3J79rfyCm6hb0cJ9l709KTCJ4FKlvsa69RuTvlOzo20bKHGs3593ML8kPj
 rayoB7P2xLZ8G2vOURU7OvlzD3yxkSWCuJNZtAgFBEssbnykD8zmMKiQ/Q=
X-Received: by 2002:a2e:bc03:0:b0:39b:d6b:9854 with SMTP id
 38308e7fff4ca-39b0d6ba662mr6533081fa.11.1782725308888; 
 Mon, 29 Jun 2026 02:28:28 -0700 (PDT)
X-Received: by 2002:a2e:bc03:0:b0:39b:d6b:9854 with SMTP id
 38308e7fff4ca-39b0d6ba662mr6533021fa.11.1782725308377; Mon, 29 Jun 2026
 02:28:28 -0700 (PDT)
MIME-Version: 1.0
References: <20260625072254.4190227-1-david.marchand@redhat.com>
 <20260628140557.1718861-1-david.marchand@redhat.com>
In-Reply-To: <20260628140557.1718861-1-david.marchand@redhat.com>
From: David Marchand <david.marchand@redhat.com>
Date: Mon, 29 Jun 2026 11:28:14 +0200
X-Gm-Features: AVVi8Cce56DGJHi-KUo9aY5dgQGk_B7yBHH6WJ8qHYhyl55SQIeAzVATAyWD2nE
Message-ID: <CAJFAV8yqQv8q0XCyJxytP_EwmybmiW+53sHM1ON=CAcscaSfMA@mail.gmail.com>
Subject: Re: [PATCH v2] dev: skip multi-process in hotplug
To: David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org, longli@microsoft.com, 
 Chengwen Feng <fengchengwen@huawei.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: RfsYW2K_v-CuLN_K2rvsb1WMZsxUktP8boqZbmF69us_1782725309
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

On Sun, 28 Jun 2026 at 16:06, David Marchand <david.marchand@redhat.com> wrote:
>
> If multi-process is disabled (--no-shconf/--in-memory),
> there is no need to build a multi-process message.
>
> Signed-off-by: David Marchand <david.marchand@redhat.com>

Applied, thanks.


-- 
David Marchand

