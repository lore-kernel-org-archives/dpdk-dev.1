Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF397C982ED
	for <dpdk-dev@archiver.kernel.org>; Mon, 21 Sep 2026 10:07:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 19FCD4029B;
	Mon, 21 Sep 2026 12:07:31 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 5BCD84021F
 for <dev@dpdk.org>; Mon, 21 Sep 2026 12:07:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789985248;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R4Z4Rpm4YzNX2acfpcusHk11mobqNV3NC21yXJvcW20=;
 b=CKA6HgsZNBwhntgiQwk5Z65t2Jcg6QB7jfxm4FM92SFFczevjtZ8H2gXqYjIn+pg/kXtOe
 AjymJPBfmAMU3122wm3vi7QnDIZXNv5EWF0RgRyvoFacywXJUntDQbM5pykG9rMZ5o7KKh
 ivYGSUAWwAFXW7x9Lf4dBrq1rAb0dyA=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-LRTXdcs-N6-92YrW1-TXMw-1; Mon, 21 Sep 2026 06:07:27 -0400
X-MC-Unique: LRTXdcs-N6-92YrW1-TXMw-1
X-Mimecast-MFC-AGG-ID: LRTXdcs-N6-92YrW1-TXMw_1789985246
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-5b74cdd0182so1318028e87.0
 for <dev@dpdk.org>; Mon, 21 Sep 2026 03:07:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789985246; x=1790590046;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=R4Z4Rpm4YzNX2acfpcusHk11mobqNV3NC21yXJvcW20=;
 b=MZ41zpLFKtDCfTvVgIjip/7hLBrDWtig16s4hHyKAbQx7vql81gDHsGALFzaydMv00
 UnFia0IyxW8yqm5mGX29ofnBIPKlME9ak8wYYZXopCcMFy3iyXYHKq+JbDX+RqaFPwN0
 0VvyAzdvzRTXNk/Lq3ppg3Mg8tjL4BHa5L5bsbcW4svO7yBrb/VW0WuZqimZhzj8asu8
 rfy4FWi1e1HaqqcLu8+Y1AVfMw34OdW728gYCM0B1F2ak3eOBivTSl0m4+fy9Eudpsss
 dglUSZwrxZGq1zbky7GBaSjQBYArTnS+EsiVpbfzsxmml8Hp42X3HNeq8Cu6WKTfXScc
 bXDQ==
X-Gm-Message-State: AFuF++kX3XH9AZ8Y7K/aB2+AX1l8CFTqYq9svKIcsIOb96MIeviasB69
 wnvmmjn4svNyUZwuVr3BNNhu9PS7/4S+qeUmRcKc9vmosv/a31XcvNGvZg7slH6BtRVTgKHWqKm
 V02qTIHW7wCXK4A1bpRoSJoJ/83+5yAK+8nGLb/52ei/RJOZLJdEz11NlpZo9Xi6/TuQsQwHVSw
 T8iQYPQip7JHOO1+etg9A=
X-Gm-Gg: AYBFou3Xlo3T0e28XhX0juVd8utoeKegNoZ+cXEcyzv2gJ1nNdCShM1yypyByg8zrlw
 99yoIiUeABPZtt32VBjej2KYVAOjNMoGltqF4VBMznkIo2V8xsSFJOBfvam0WBQ3aGdhDbB2UWS
 ugB0B9enom5yrKGin74Wqow4j+vqlQ59SliJGTaCbo4jChQYwQkKarAaRj4N0RhLWeohjNeNboY
 8w0ESo/5uCsXpIfVv026kMPGCAo6Ywj9Lpuh03ykoaJXOos
X-Received: by 2002:a05:6512:b8e:b0:5b4:a2ec:c078 with SMTP id
 2adb3069b0e04-5b8c180b408mr3679386e87.21.1789985245887; 
 Mon, 21 Sep 2026 03:07:25 -0700 (PDT)
X-Received: by 2002:a05:6512:b8e:b0:5b4:a2ec:c078 with SMTP id
 2adb3069b0e04-5b8c180b408mr3679368e87.21.1789985245331; Mon, 21 Sep 2026
 03:07:25 -0700 (PDT)
MIME-Version: 1.0
References: <20260914144234.1540150-1-david.marchand@redhat.com>
 <20260914144234.1540150-3-david.marchand@redhat.com>
 <20260921083125.40120-3-rasland@nvidia.com>
In-Reply-To: <20260921083125.40120-3-rasland@nvidia.com>
From: David Marchand <david.marchand@redhat.com>
Date: Mon, 21 Sep 2026 12:07:13 +0200
X-Gm-Features: AcwNN1VZyEab9g9sleloYokuFkDISYD72K7cwPt075SpFbMpIhP9xnl5DpMD5Xw
Message-ID: <CAJFAV8w-Fjd0eHrO-vQmsC+5OP_gRvLExKO9+Y5sEfGQG4tR-Q@mail.gmail.com>
Subject: Re: [PATCH v7 3/5] net/mlx5: pass maximum number of unicast MAC to
 common code
To: Raslan Darawsheh <rasland@nvidia.com>
Cc: dev@dpdk.org, Dariusz Sosnowski <dsosnowski@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: _dxS4kCN-W2t4ZwD9FWjP8WYPhL423qSz7WZG0zc6f4_1789985246
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

On Mon, 21 Sept 2026 at 10:32, Raslan Darawsheh <rasland@nvidia.com> wrote:
> =F0=9F=A4=96 This review was drafted with assistance from Claude (Anthrop=
ic) and reviewed by me before posting.
>
> In mlx5_nl_mac_addr_sync() (drivers/common/mlx5/linux/mlx5_nl.c), `n` is
> now the caller-supplied array size rather than the old fixed
> MLX5_MAX_MAC_ADDRESSES (256):
>
>         struct rte_ether_addr macs[n];
>
> This VLA scales with whatever `n` the caller passes, and by the end of
> the series that can be as large as the device-reported unicast MAC
> capability (up to ~4096 per the release note added later in the series)
> -- roughly 25KB on the stack versus ~1.5KB before this series.
> mlx5_nl_mac_addr_sync() can be reached from interrupt/alarm-thread or
> hotplug contexts where stack budgets are tighter than the main lcore
> stack, so this can overflow the stack. Could you switch this to a heap
> allocation (or a bounded scratch buffer) now that `n` is no longer a
> small compile-time constant?

I don't mind switching to heap, this is control path with netlink
involved in any case.


--=20
David Marchand

