Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 760B3C44501
	for <dpdk-dev@archiver.kernel.org>; Wed, 21 Jan 2026 11:12:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DAEEB427DA;
	Wed, 21 Jan 2026 12:12:07 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 0B96F427CB
 for <dev@dpdk.org>; Wed, 21 Jan 2026 12:12:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768993925;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ltxRRl+zhfeVQjgBltwYdXEVKbEF6bL9z2ILZWsqZBA=;
 b=bPQgSBc9WDNBaO1/pddSW4iQNknRJcHQOcgGARJZQ0eoUj0zeXx8b9d4Bv7IEQXTLIcOIH
 cCYg3A1s+B4j6Xc57yYOhoGR9S0VM8RfiqfHEsUAYsrMWCTJ/jvudQR7jqhQn1Ir9hifuN
 9o1plBNBF49Bqp1/lRVOP/PniYJHJmY=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-JuouRBdNMf-sY3Mq0y14xQ-1; Wed, 21 Jan 2026 06:12:04 -0500
X-MC-Unique: JuouRBdNMf-sY3Mq0y14xQ-1
X-Mimecast-MFC-AGG-ID: JuouRBdNMf-sY3Mq0y14xQ_1768993923
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-59dd34abc17so264933e87.1
 for <dev@dpdk.org>; Wed, 21 Jan 2026 03:12:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768993922; x=1769598722;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ltxRRl+zhfeVQjgBltwYdXEVKbEF6bL9z2ILZWsqZBA=;
 b=glnvwAT94FN1i80msjFW2JxEQnYdz6Disc6KBdh3sLBZvI14FROnqvMh4Q/sW+1zw2
 H/SPJjPCtUau1DlDyGylOJoa5chqVVNA9irQQRnwr3dX1AsL0bsLq/XiS2GoPXEumo2C
 d34pQf0vPOOAUjMZvoZXYuGVaoNBlEmsz1v5LUvnOB26kXs9i/4277m0tM1mkZ1wGv2r
 QxvXJuIcNRvsb1d4JAfa/ZN99eIjnT/fED9jKsOgeBzQSs9TtEC6Iyt690sWvBn0sxgh
 Zb4FVYw9tJTX5gnF1ofXxVCpdmXrbVtwa9IpvGu+0N8ckx+eXXU1cFxrDZU4oX2UFMZC
 A39A==
X-Gm-Message-State: AOJu0YxNyXDVJqcQLL6JYbQ29nFokoH9WGsdTbvRyo//TFSFb4IKFKTt
 RR6w8f+WdPhtVdjpgwdVzVNn7J73CcDrFLs01yuvmtF1PAv2swRWn5FUrZ3xLwuZhLbXs7jXv9B
 Im9ai2MJZg6yU4c3yF1mbSK/EKyxEzr417wR/usMIWaUZb0eV+SqblApWNpy7AQVn/N2+txMwRM
 Gi/mBdn6nHOS6AjQyvAR0+h5x0/APuHQ==
X-Gm-Gg: AZuq6aIDV1JvZYJM0CbmCe4bA8vZ++EFE6frQh13hYYOxmiA0w2G7U2JsLbT25cU93j
 dpEENto4J0EK/tHEXaS0sCTtDJPAvlzSx9A/U2W1ROG7qc8/b+mtufysWzHhzvDGKEMGnC1Lkt6
 XWNnz2pcLneLD6pSLEPenSlNAiBUh5EEmLo7SGiEniowQBppd5ihR8t41d+XftBWtEOeS8
X-Received: by 2002:a05:6512:8017:20b0:59b:b04d:b7c with SMTP id
 2adb3069b0e04-59bb04d0bafmr3552853e87.2.1768993922561; 
 Wed, 21 Jan 2026 03:12:02 -0800 (PST)
X-Received: by 2002:a05:6512:8017:20b0:59b:b04d:b7c with SMTP id
 2adb3069b0e04-59bb04d0bafmr3552845e87.2.1768993922145; Wed, 21 Jan 2026
 03:12:02 -0800 (PST)
MIME-Version: 1.0
References: <20260121110757.1948723-1-thomas@monjalon.net>
 <20260121110757.1948723-3-thomas@monjalon.net>
In-Reply-To: <20260121110757.1948723-3-thomas@monjalon.net>
From: David Marchand <david.marchand@redhat.com>
Date: Wed, 21 Jan 2026 12:11:50 +0100
X-Gm-Features: AZwV_Qhjdm-Hk12AuPFdt_Hg-oUQPVlGBupRDjjERj6g_L6dhJoBdumtzQldLGE
Message-ID: <CAJFAV8y=g4uPxfsUT66nmXt1NGc_7pXW4Ef2VgJP6iT_F68Lsg@mail.gmail.com>
Subject: Re: [PATCH 2/2] net/mvpp2: fix variable shadowing
To: Thomas Monjalon <thomas@monjalon.net>
Cc: dev@dpdk.org, bruce.richardson@intel.com, stable@dpdk.org, 
 Liron Himi <lironh@marvell.com>, Jacek Siuda <jck@semihalf.com>, 
 Tomasz Duszynski <tduszynski@marvell.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: b3vtmrRmL3TXN3zgG008jwAr9ikQRg2Xc3IYPA0CzWY_1768993923
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

On Wed, 21 Jan 2026 at 12:08, Thomas Monjalon <thomas@monjalon.net> wrote:
>
> With shadowing warning enabled, we can see "i" was declared twice:
>
> drivers/net/mvpp2/mrvl_ethdev.c: In function 'mrvl_rx_pkt_burst':
> error: declaration of 'i' shadows a previous local [-Werror=shadow]
>  2676 |                         int i;
>       |                             ^
> /mrvl_ethdev.c:2592:13: note: shadowed declaration is here
>  2592 |         int i, ret, rx_done = 0;
>       |             ^
>
> Fixes: afb4d0d0bf91 ("net/mrvl: add Rx/Tx support")
> Cc: stable@dpdk.org
>
> Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
Acked-by: David Marchand <david.marchand@redhat.com>


-- 
David Marchand

