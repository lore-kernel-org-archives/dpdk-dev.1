Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA738C3ABC9
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 May 2025 11:44:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2B161402DC;
	Thu, 15 May 2025 13:44:24 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 32D0840289
 for <dev@dpdk.org>; Thu, 15 May 2025 13:44:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747309461;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VIVrOo0YlMfKH0X4RaPcCasoU0qlbNWGT/wKumoeTWk=;
 b=XRWPK9DC6RBuOTXAZjm+BB3XdGSw2YAGJdo52qaOBJp0pEH5lpzk6GIP2ERoh1OXv2P/ej
 uSyWb4FWjjSXZXo/A6Zr+ZPhmzDOUMnDNI+6Hvy+sAmlaOOwgbOOnrnfM/rGEc1koTX7+q
 fR9mb487d131w7Y/nDhqxtc2qcWBMhI=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-qvt8bLu_Pd6Lp85oA-Rq6w-1; Thu, 15 May 2025 07:44:20 -0400
X-MC-Unique: qvt8bLu_Pd6Lp85oA-Rq6w-1
X-Mimecast-MFC-AGG-ID: qvt8bLu_Pd6Lp85oA-Rq6w_1747309459
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-326e5661860so5453681fa.1
 for <dev@dpdk.org>; Thu, 15 May 2025 04:44:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747309459; x=1747914259;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VIVrOo0YlMfKH0X4RaPcCasoU0qlbNWGT/wKumoeTWk=;
 b=kfOVj3lJL729TJeAetZDmm8milnWSxc7uX0eKHXT0WU5rJqrCTwK3eqRL1Uo+sGc0q
 cFFvCx/LZN8esqmKdX1ZJkrxhnUkvkws9HRf3UYI9DX22owz3Bug+30lViswBv6JfBLo
 6CDxe4Ngm2YsJeU7g1ZFFNFrAl78Suur/cZ8JcrC60zvqhEbKFUEnAo1BEgboufSl2we
 TwfXJWhK1dtfO6reIJClJseNwQf7zYQmhhM2QX/nCkDBzWGDTj0tGWPYpT2wS9cP6nJe
 CL7vPi3MQNj4rjumrKkmqJ/HASG9x5giB32if6GAmcmpWR3zPtsWg1Z9By1QuKdskKwA
 8l2g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWf7QM/+NZMOiwyMS4NS+q+5OndfnuWxjiRHplQqOZYyET1JeVlluG2PjTKH4DlOj+Oqe0=@dpdk.org
X-Gm-Message-State: AOJu0YwWSEsQFEXOREbZN8xJRHuGkRVPCPCMuCCg9vu6jhQXapd+ZYnn
 PjqHwJvDYuRHL2PO/xtm037P5mbtDJaQ1UA/7l2y4PA3XlF7PqZM50JHwuWFbreCrvIsSsn/No+
 7kfQA9wDGFdWoXU3sCrX9VXL1x57w5k2zR6xSchBByAuocdL0d9TpcKn288A+317L3zFHDCKCtL
 lLFQm2d/GrGfnX0XA=
X-Gm-Gg: ASbGnctbyYqYtVh75rfXMPIcr1RTAZzD+RXz18BDpUyUgGdc9qEwbrH7ZSguTUSfqSW
 Ofz4preYb3idOOszxHhYKxAHpxPwlibluaz2v1ht7MDn5dFQL7Cyd8dWimwjcdKCbO0K3eFE=
X-Received: by 2002:a2e:bc8a:0:b0:30b:ab00:846a with SMTP id
 38308e7fff4ca-327f843e7damr13518871fa.3.1747309458792; 
 Thu, 15 May 2025 04:44:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGZ2tFOBMOOPRfGyxF8d84zq0UzyWDftl2WBRrFYCyG0xwlTDWUFVTLLAQLoteKjTLVvXNT8alLNXVBIcCzspw=
X-Received: by 2002:a2e:bc8a:0:b0:30b:ab00:846a with SMTP id
 38308e7fff4ca-327f843e7damr13518731fa.3.1747309458355; Thu, 15 May 2025
 04:44:18 -0700 (PDT)
MIME-Version: 1.0
References: <1744662518-5433-1-git-send-email-andremue@linux.microsoft.com>
In-Reply-To: <1744662518-5433-1-git-send-email-andremue@linux.microsoft.com>
From: David Marchand <david.marchand@redhat.com>
Date: Thu, 15 May 2025 13:44:06 +0200
X-Gm-Features: AX0GCFsHWMXYevYYdeuI76hT788nEZq_HZeo51SjWIm73P9OYHVOFU9Qa9dgx94
Message-ID: <CAJFAV8x9dAP7ziqAgCZ9-5EuThAhCFgdQKHTMY1KysH1WPOU2A@mail.gmail.com>
Subject: Re: [PATCH] eal: simplify code to avoid Coverity false positive
To: Andre Muezerie <andremue@linux.microsoft.com>
Cc: Tyler Retzlaff <roretzla@linux.microsoft.com>, dev@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: xo3l0jasaKCP5r6uYMnL-pdx4wrW2avLnvaecIR_8W0_1747309459
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

On Mon, Apr 14, 2025 at 10:29=E2=80=AFPM Andre Muezerie
<andremue@linux.microsoft.com> wrote:
>
> Coverity complained about an overflow in a recently added function:
>
> https://scan4.scan.coverity.com/#/project-view/66295/10075?selectedIssue=
=3D461876
>
> CID 461876: (#1 of 1): Overflowed constant (INTEGER_OVERFLOW)
> 21. overflow_const: Expression powi, which is equal to 0, where base is
> known to be equal to 1024, overflows the type that receives it, an
> unsigned integer 64 bits wide.
>
> This complaint was a false positive, but it revealed that the function
> could be written in a simpler way, making the code more readable and
> likely allowing Coverity to make the right determination.
>
> Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>

Reviewed-by: David Marchand <david.marchand@redhat.com>

Applied, thanks.


--=20
David Marchand

