Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08851CCD184
	for <dpdk-dev@archiver.kernel.org>; Tue, 21 Oct 2025 13:45:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 31E1B402C9;
	Tue, 21 Oct 2025 15:45:56 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 673CB400D5
 for <dev@dpdk.org>; Tue, 21 Oct 2025 15:45:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761054353;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mHL88CLPrWkIba0oC1qr9pLBOnbvEULFbs1rA+ZdoUQ=;
 b=SKCftPvVg1zeDGBhLHtXTxe0C3W303cK7wCRzWK3KFlsq0hHYf7A91hFSBU7oxeLH85B7N
 lBBpcqUp9ka2FgeA8+BW5OEK325OJ0wJ0iZ6fJ6jhUZq7PDX+s+VLBT2KN0Xrlhd3yBqb3
 gTvqk5Pz/j72qgXe9d6PGRSS/dz7TNs=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-363-1Op71vG-OuadgpVGvS7TQQ-1; Tue, 21 Oct 2025 09:45:52 -0400
X-MC-Unique: 1Op71vG-OuadgpVGvS7TQQ-1
X-Mimecast-MFC-AGG-ID: 1Op71vG-OuadgpVGvS7TQQ_1761054351
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-368348cf7d5so35878791fa.0
 for <dev@dpdk.org>; Tue, 21 Oct 2025 06:45:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761054351; x=1761659151;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mHL88CLPrWkIba0oC1qr9pLBOnbvEULFbs1rA+ZdoUQ=;
 b=GtHSxmXVPazWiCMx8xlv8FR3a9q5JjYYkEhSN/3jux0omP9aXoI1vSqLBl/Ok/99/A
 cQTs6w5nwum/kOrty6bM0ka5qQGK2UT1IpfBDIj24MYGm37w6N2mGih0xOpcqMEiyD2B
 MjurxTIIZ88w34nhROsn9sttdmvS99ikBEw+vdSVJ74b8Us2rL/VIe8bkKZcfXK0nnYc
 EBZhAqYsEUevj39fBOTtJ4/MaN/ajA3t5m88RXrC7sFHeL51pa0S8fJD0Tb2TROaU/gt
 wX3GT9KjMbCEgCVTGccSSyW4l1c4I2HN1ZVyX4y+4h4jWxNfKrI5UJxKlFHyoXeawPdF
 RNuw==
X-Gm-Message-State: AOJu0YxufHL9ReXDvjkC10/M0rEWPUyqhuTU8Y/PhUJrHg1JRIxgK542
 gKsuhJKu8YnHVoB8THooseWC9VJ91KgTkLEEkkUXMKwDwjkeQQa6y/ZRrbXM8XWKhKoudl/psZc
 1Cns1XtCnNIsIT2OvCqnzdUIaCfbgqNpgn2JgCnKYi4W1qYNjWz7PS+imZUH+J1+rId4arOBwAK
 QvZ2jIZSNwNze6ObxOhL4=
X-Gm-Gg: ASbGncsr5FhE1e5lhNmHYqLg5LAyuTfu3yYYFUoNm74FLCohyJ5ZfD9bOUDsxhEiQoG
 91uAB92xJI5vBLp3gM5k4fI1BRL2a7a5QM5hNz7R1Brt9nfHpoF5ZeamcVbDcPGwnyleMnk2s6j
 V5IQfxeBhZO5M3uJi6pc4U3B8M4rbAqLfE5zpGqJjQI9AyGWmFBII6hSIVhA==
X-Received: by 2002:a05:6512:1546:10b0:591:ebc3:a686 with SMTP id
 2adb3069b0e04-591ebc3ab84mr629827e87.44.1761054351013; 
 Tue, 21 Oct 2025 06:45:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEUsW0hG4j0ToaPr9fcPE6GbDbpeQ5LNkCsHyBWEF0bn2CqtT4Ac004E1+uKmXV1U/YmYAM04OiWpQ9hIgg9AM=
X-Received: by 2002:a05:6512:1546:10b0:591:ebc3:a686 with SMTP id
 2adb3069b0e04-591ebc3ab84mr629819e87.44.1761054350586; Tue, 21 Oct 2025
 06:45:50 -0700 (PDT)
MIME-Version: 1.0
References: <20250825083229.919586-1-ashwini@wisig.com>
In-Reply-To: <20250825083229.919586-1-ashwini@wisig.com>
From: David Marchand <david.marchand@redhat.com>
Date: Tue, 21 Oct 2025 15:45:38 +0200
X-Gm-Features: AS18NWB_Zrbq8Qv38LqcTnJrSfQccl1mv6JR0FDQhuGHkOzGUy61ZpR2k-57dw0
Message-ID: <CAJFAV8yWB+_+0XF4nk+Vx=DmY2mZVG=T2k-XUoaBB1KG_u8y5w@mail.gmail.com>
Subject: Re: [PATCH] vduse: fix typo in struct vduse_iova_info comment
To: Ashwini Sahu <ashwini@wisig.com>
Cc: dev@dpdk.org, Maxime Coquelin <maxime.coquelin@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: efovcDcl8aQ8DY3HRqxK-tgjluKVwm-btRZN8hQkSsM_1761054351
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

On Mon, 25 Aug 2025 at 10:32, Ashwini Sahu <ashwini@wisig.com> wrote:
>
> Fixes a typo in the kernel header comment for struct vduse_iova_info
> where "IOVA region" was incorrectly repeated.
>
> Signed-off-by: Ashwini Sahu <ashwini@wisig.com>

As I said in the other thread [1], I prefer we don't "fix" uapi headers in DPDK.
This needs to be fixed in the kernel itself.

1: https://inbox.dpdk.org/dev/CAJFAV8wqC1PpVvRoxdRpb-8v5FY90KOfKuTGLL_CvbUnpdjsRg@mail.gmail.com/


-- 
David Marchand

