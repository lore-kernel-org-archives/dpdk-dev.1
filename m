Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBE98CAC5AE
	for <dpdk-dev@archiver.kernel.org>; Fri, 26 Sep 2025 14:16:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E75B240698;
	Fri, 26 Sep 2025 16:16:12 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id BE07C40698
 for <dev@dpdk.org>; Fri, 26 Sep 2025 16:16:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758896171;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fKYLi9ouN0kYZQLqa/q9AJ/48V8g97KhABbgFJDh/hE=;
 b=IhHI/OUJMnAsmnjt5yENP+Da0Po4lc708LTXCoIHdUcjPabocYnUz39/csp/pl5A6He2+H
 XoJJPk4jVsglq89hb7xXg6zmBp4iuNI62bOpBbyW+PVWb0xLC6Xjbbl6sOsuXkgrDEMIPQ
 SfK5tuxPWw1MR2wkC828cvcjQ7ZD84w=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-342-qmMc_Q2pMou0ekGydPIijA-1; Fri, 26 Sep 2025 10:16:08 -0400
X-MC-Unique: qmMc_Q2pMou0ekGydPIijA-1
X-Mimecast-MFC-AGG-ID: qmMc_Q2pMou0ekGydPIijA_1758896167
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-36d99707249so9681231fa.3
 for <dev@dpdk.org>; Fri, 26 Sep 2025 07:16:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758896167; x=1759500967;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fKYLi9ouN0kYZQLqa/q9AJ/48V8g97KhABbgFJDh/hE=;
 b=SyZCjnFvfcCz8efBxjj7czVu6rI8Dgq0CXFiaOT0P/8THBezd9ygZqHcWM7JdgokJh
 r+apz+DkoOeNsmNX0+T1JcyC2Khkn7fId3w5TPoehUeU8hMYeAJuDVAZ9Yp3LgysQijW
 LnCFNdyxUHNGoc2USLFhEGQZTceah1mPXVml9EwwF4gW8T9CqoGqGJAOIws3da0AiLeu
 +/s79gMdKcVggWml+6+93/WPPzQrva7IleZPwNWUDMNUdx4scT1/smrmgGgg3+RDRn9q
 pLXK0O9B+CueQcNJv8rlm9F98sOoEzwNrx6C4oGSSMjO1vw969wFIJUzpVwWU2y0d+tf
 mKcw==
X-Gm-Message-State: AOJu0YwFPPX+GH6TRpAQ7KDPEiKT2LlBChDlgzMNCiUe10SGrbqD1Nys
 44sEJaey3iNsSshJxCs85+oiVkx5ljjPv2c3Q0aXYeKtEqwFRjk62gwAyPJ4+Inr5gLwEV5/lcu
 WKSboMapCzuYQaCLP/bvh7xEa4XZFeaNaaOuQNcoh6c1ynWb3hmMXV5uHqHPFCTwZWQBY6nvJpS
 1C+50ztfxMN3fC/4qJs4/4WQCDavk=
X-Gm-Gg: ASbGncu+iTD4wpavrn1FJT/ZD+MjQ7C2LaBtD2qHdQR7JSJixZeLjmjp9Zvh7CWdhib
 DQ0hQ7ss1oXqSzHyqN1ipJ6F7vgiZmwdKg5X28ivRe4jjgDHD3lJGAcvKGDuzumbvDPuqtEmaH+
 KIZaobtyymJSMMebobJaE6etg=
X-Received: by 2002:a2e:be15:0:b0:36a:6540:3ba3 with SMTP id
 38308e7fff4ca-36f7f932d9amr22122091fa.39.1758896167036; 
 Fri, 26 Sep 2025 07:16:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFiZ/7d/aJ1xp7eoWIdRGar4hz5uZkVnKOtBRKHaEy8ZmaTcy4zdmMMzXlq/rJJGXcLc1brF22rUX7IHcLqWsY=
X-Received: by 2002:a2e:be15:0:b0:36a:6540:3ba3 with SMTP id
 38308e7fff4ca-36f7f932d9amr22121901fa.39.1758896166349; Fri, 26 Sep 2025
 07:16:06 -0700 (PDT)
MIME-Version: 1.0
References: <20250919075654.220920-1-bruce.richardson@intel.com>
 <20250923143225.12252-1-bruce.richardson@intel.com>
In-Reply-To: <20250923143225.12252-1-bruce.richardson@intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Fri, 26 Sep 2025 16:15:53 +0200
X-Gm-Features: AS18NWDY8sdAIJ6e6bOwL3yL10Jq_A8Zok_y4q4UakgkHaMN4VoNV8Q-QBiIKiY
Message-ID: <CAJFAV8ycKPnzcWiMd0H8zs98wBkDtd2_gXg3KEoVUwjJjONfWA@mail.gmail.com>
Subject: Re: [PATCH v2] telemetry: remove deprecated functions
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 7-JzJddvO8oOIyMsEC9P8jZKNun3A-o06tGHabCbZVU_1758896167
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

On Tue, 23 Sept 2025 at 16:33, Bruce Richardson
<bruce.richardson@intel.com> wrote:
>
> The "_u64" telemetry functions were replaced by the "_uint" versions
> back in 2023 [1], so can be removed from the release.
>
> [1] https://doc.dpdk.org/guides-23.03/rel_notes/deprecation.html
>
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> Acked-by: David Marchand <david.marchand@redhat.com>

Applied, thanks.


-- 
David Marchand

