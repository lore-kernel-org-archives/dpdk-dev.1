Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03F78F33A76
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Mar 2026 14:36:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1F98B4029D;
	Thu,  5 Mar 2026 15:36:15 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 7DCD740287
 for <dev@dpdk.org>; Thu,  5 Mar 2026 15:36:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772721372;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=81aBr8nO7Bb1+MhSnU7s+ie61fEGKiMjhk5OYFPALIk=;
 b=IKNVT8ze+3gPLodeQhL7E/oY/mozb/IElNBxrDN1Q4Stm5fmV05UKCiN2K+Dk7YK3fsFx5
 F9DrivpJY/eAtUMXqLlWQcdJr6yguoq0YyacS04PkJZqJBn866ROBZufbB/LZWrY9fVNxH
 VWH0od8T8b4SNXgf1fFufYnMlrLz0A8=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-660-LE1kxBi1MuSDqSZsrKZrjg-1; Thu, 05 Mar 2026 09:36:10 -0500
X-MC-Unique: LE1kxBi1MuSDqSZsrKZrjg-1
X-Mimecast-MFC-AGG-ID: LE1kxBi1MuSDqSZsrKZrjg_1772721369
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-38a36acf971so3958451fa.2
 for <dev@dpdk.org>; Thu, 05 Mar 2026 06:36:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772721369; x=1773326169;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=81aBr8nO7Bb1+MhSnU7s+ie61fEGKiMjhk5OYFPALIk=;
 b=bqTT5ygdpA1OUpuNcK6z32C+d41hqUR/mdZtwiU7ozjA36HiG9PrrFH5YMq2Cl+UBP
 vfwFtq2ma/2wxQnnWfypmJkm0XLiocIJab2MMTMs+Gy2T33K843/p0p/j3zUj0EHO0Y0
 SxAiMMPZJ06mHELvxlyII177cbco88ljrC+623Wln+w6Au2jxVsQeCHH7z2CwzFPVYuR
 ntmbXs5lrJToaWwFWKCaPsZGL0i6NOONbXTvdV9b6bsivHRoflZOzp2bGzZge9ns1jeL
 d01UpPekYnbbAnDQpBE1nZx5qj8ugL4TxzRBHimRZnqqOhAE5fPyDIJeKudNtSsmohK1
 WxfQ==
X-Gm-Message-State: AOJu0YzfTfY7LdmjfmKI8g6QLg1KU2KY01eby8TrPbkmZPeP14yzd8b4
 xjR5n5ozTOyK8ES4zBTDzqJgXDeuuj5BDGkCJlmD7N8esT+L6yLy6hbi5RiKJcVH26beI00obgs
 bNfytVtf7ziwwnTOcQV22Xeavr9mNKysj+xVJiPVuftilzZI0DV89eUaDus+Wsdb7LPJcRHlldD
 aCbgBFpvnh2zcZNNe7iFs=
X-Gm-Gg: ATEYQzyqsfxv3wl/lGCrdlTUI9MPFQ64UsC8PW5Y8TK7Fn2z6TlUohv3FENyyL2TmjZ
 7DOc3Jmv5yNjtHgxhXJ7zZanW3WvicFLsaVrLDhIXbTjlEwUPu6YCCHmGS/MYUi/+HfGXtH0Me2
 5G0C0pVWYHZpoMXTozgqjXq3/v6JbCqVkFi1TBClUTxwaD+Mm2HWaO3gbBrbUEtyuxYpbT1Rnef
 0vDIRC1ccoPzyrosxgguka/JUjkoxXRdRmc/ozTrNI5r99tuEEpoxesXaZtlwXKagPp4g==
X-Received: by 2002:a2e:be9e:0:b0:38a:3668:283c with SMTP id
 38308e7fff4ca-38a36682992mr8581001fa.33.1772721368975; 
 Thu, 05 Mar 2026 06:36:08 -0800 (PST)
X-Received: by 2002:a2e:be9e:0:b0:38a:3668:283c with SMTP id
 38308e7fff4ca-38a36682992mr8580831fa.33.1772721368496; Thu, 05 Mar 2026
 06:36:08 -0800 (PST)
MIME-Version: 1.0
References: <cover.1772114309.git.anatoly.burakov@intel.com>
 <7afe68e70f330c54c68f81656f9c3271c4d5549d.1772114309.git.anatoly.burakov@intel.com>
In-Reply-To: <7afe68e70f330c54c68f81656f9c3271c4d5549d.1772114309.git.anatoly.burakov@intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Thu, 5 Mar 2026 15:35:55 +0100
X-Gm-Features: AaiRm50ge1xu0ge9MSp-Qy88TtpPIyEQMWVOQG6yOlcMJs21589Q9VFq2eyVHbw
Message-ID: <CAJFAV8wHK9VSgH6tzQxwTE_8gxJ9LLOqMHHOHCWUVAFedVg2zw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] doc: add deprecation notice for VFIO API
To: Anatoly Burakov <anatoly.burakov@intel.com>
Cc: dev@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: CVbS2gua8zQY6j61q9DF_4S1LsSjfLGiE5tUAG2SGYY_1772721369
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

On Thu, 26 Feb 2026 at 15:00, Anatoly Burakov <anatoly.burakov@intel.com> wrote:
>
> The entirety of VFIO API will be either made internal and only available to
> drivers, or will be removed. Add upcoming changes to deprecation notices.
>
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>

Acked-by: David Marchand <david.marchand@redhat.com>


-- 
David Marchand

