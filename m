Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8421CD3F070
	for <dpdk-dev@archiver.kernel.org>; Wed, 28 Jan 2026 14:30:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D0F6F402B6;
	Wed, 28 Jan 2026 15:30:37 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 115A84003C
 for <dev@dpdk.org>; Wed, 28 Jan 2026 15:30:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769610635;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rKHTY6G1DI5n9wuV3L3r/D0K9a7CrUIaN5YijZ+eyFo=;
 b=LLIvUSkoQiukp0CdsbdgHrWuYbJQsh19EoKc0hhUt6sQsnJGzgFwSqwcdwSLT/5Hy3UnoY
 PwsbmvkH7jYSbWtWqx8G7ZBtO5loq6/0k8/XbZdJH04Tv73cQxnmcyQQz7yVZ3eNCTUplQ
 Q0xNvRyjeSLRzQI+2neBRkdMUptIyxI=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-1-Pb85TxbQOU-lDonXIbfMWA-1; Wed, 28 Jan 2026 09:30:31 -0500
X-MC-Unique: Pb85TxbQOU-lDonXIbfMWA-1
X-Mimecast-MFC-AGG-ID: Pb85TxbQOU-lDonXIbfMWA_1769610630
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-59e08e08e63so589944e87.3
 for <dev@dpdk.org>; Wed, 28 Jan 2026 06:30:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769610630; x=1770215430;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rKHTY6G1DI5n9wuV3L3r/D0K9a7CrUIaN5YijZ+eyFo=;
 b=ONRjCjdolCRCR419TQcrvb5LW8fGQ6ba3ZQ7mfbbcxE/dbtMkqxHMiaQ8manA2zIox
 /dqPypZSI28QDGf+vEQPOMroTVoAxmmDHCvWrZUgr1SfB2D/Qy8qpU2wm2lPylGl6QVf
 etp7ddlxMNQeBZo74sQpdSQIxJKTq7Y04/9Ed6zMsVvHzoW/i/tS5Gi6PKCH51Ur1WLY
 vgJ4nGaeZU+so8sOX85Oi8wowoACJumlF96ElOb3HKmwYiBMq4Yx3mhUTK2aduikReHZ
 uqiINvZ2KoUcrf1wqPPBlziD2X5jJNTPv5xhJZlE6DSTgKYDDZwclmg/lgPJSnQiNgoC
 fu9A==
X-Gm-Message-State: AOJu0Ywzht1XqbDhL/CzovvY24aPPPOvbnK2A0ade4vNfExKBh48TTY/
 n51Uf51uMSLatKVxP3N9kKWdbB90qyI7D37J4jb1iSI71LPzatPUDGDYxNUkdbJyhO9uDcZ5xy4
 C6YTXZDZuyoPIMpki6qj+jSQhdDlON0wR2AG0n8H/FItNCw922+jQEALwO5kB+OCzOJhFmEWQyR
 D3jOQPsgYHP3yl7VRR9R+eRtDWzFk=
X-Gm-Gg: AZuq6aK56AkI30fd2K0YiumsT2zM5lFu3KIo6iYUICdSMfHOLWhde+FrVVr7f6g5Hwj
 628m3Lqjh4XGXnE7TdR3yevQKtWBdbtNa9+iUyGxuDeC8gtUj2uqBUnteXAB291GzVjSVgk/11O
 4WOePKd0dvtZsSCNsHbxT88CT+aap8+1sAvjuSsDV7RbaFZ0sWan3mtcAJwTTrE4aery9i8Yr3S
 JbPzARz45SP+KBUxqABn4sARCmCZNNwqxAimTCfrVOJ8/sc/TFDm6decg==
X-Received: by 2002:a05:6512:1393:b0:59d:e351:c339 with SMTP id
 2adb3069b0e04-59e04137389mr2442835e87.48.1769610629894; 
 Wed, 28 Jan 2026 06:30:29 -0800 (PST)
X-Received: by 2002:a05:6512:1393:b0:59d:e351:c339 with SMTP id
 2adb3069b0e04-59e04137389mr2442825e87.48.1769610629259; Wed, 28 Jan 2026
 06:30:29 -0800 (PST)
MIME-Version: 1.0
References: <20260127174429.1504288-3-cburdick@nvidia.com>
 <20260127192146.169967-1-stephen@networkplumber.org>
In-Reply-To: <20260127192146.169967-1-stephen@networkplumber.org>
From: David Marchand <david.marchand@redhat.com>
Date: Wed, 28 Jan 2026 15:30:17 +0100
X-Gm-Features: AZwV_QjmXOFZoWlBWDsZ9r8QWZpksVEsTiymU1G9KI96MCdsYftSvBJh1BmHANM
Message-ID: <CAJFAV8zWtmZX86h7U=tXxAss+1B7=Jpex9NgNkOA67ATTWyvNQ@mail.gmail.com>
Subject: Re: [REVIEW] common/mlx5: support dmabuf
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: imT_uUQMNDNOuBFrxac1rO9NlOATsJFDZIYivs7IkzE_1769610630
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

Hello Stephen,

On Tue, 27 Jan 2026 at 20:22, Stephen Hemminger
<stephen@networkplumber.org> wrote:
>
> AI-generated review of bundle-1701-dmabuf.mbox
> Reviewed using Claude (claude-opus-4-5-20251101)
>
> This is an automated review. Please verify all suggestions.
>
> ---
>
> # DPDK Patch Review: dmabuf Support
>
> ## Summary
> This patch series adds dmabuf (DMA buffer) support to DPDK EAL and the MLX5 driver, enabling DMA transfers between drivers without proprietary kernel modules.
>
[snip]

> **Warning: Missing version.map updates**
> New exported symbols need to be added to `lib/eal/version.map` under the `EXPERIMENTAL` section.

I noticed similar comments on other series.
There is no version.map update needed anymore, since v25.07.


-- 
David Marchand

