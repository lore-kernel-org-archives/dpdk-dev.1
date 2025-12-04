Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82A83D20694
	for <dpdk-dev@archiver.kernel.org>; Thu,  4 Dec 2025 13:46:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 671114021F;
	Thu,  4 Dec 2025 14:46:15 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 3082A40144
 for <dev@dpdk.org>; Thu,  4 Dec 2025 14:46:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764855972;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RGHBk6KgDzmasRlDZu08uaYlvG30AIrJm7uGHaHQ2S0=;
 b=bpT67PeulIg66GIq/RTwbbt8XOjLrMvw0L9rE9w0YhN7w5297XU8/C7NI1NkmrzWxuxoII
 KSVvzmSp5+NUHorPc75kFlodRjt0a+jK05vkD0O9EaYOxo0teEp8qBHJtTgZLwVz6g0Vm4
 SC0bYf8BK/lYAO1mOpoSvSzTRO1StJc=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-197-qlf6uzFrPBem4mvPI2W5Qw-1; Thu, 04 Dec 2025 08:46:11 -0500
X-MC-Unique: qlf6uzFrPBem4mvPI2W5Qw-1
X-Mimecast-MFC-AGG-ID: qlf6uzFrPBem4mvPI2W5Qw_1764855970
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-595904df717so814590e87.0
 for <dev@dpdk.org>; Thu, 04 Dec 2025 05:46:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764855969; x=1765460769;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RGHBk6KgDzmasRlDZu08uaYlvG30AIrJm7uGHaHQ2S0=;
 b=DUu3bkywj2wUPwaUsEk72NegUzE7lkxgUC2WWTphZ431dOYdxpJ7ehjepffFQCEDVZ
 1gmUz8aAf2d89aXgM5X1PcKNyplowty7P70gHQVXmnoNLNqWkJ13eeAszr13Wg9rNNpk
 /bEhZJJYH6PSy/LZamiODZcQL+gg6LzcN0amOnvhiuBq21HPyjRZsnA2hXuNscU4cGw7
 9C4BCNY6GNWZDFc0J+h+C7IyEMdijedZJCF7MumnJmvC3+Jcb+ibIuzKdFWzsRXlunxm
 SGSqfTrj0cHjnLmqoE2duU4I18Haa24qK7K/E2xvOAt3yAM+FEV8bs6DmZZ5dGZBFrRo
 6hPg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV65MJm31EIsUEyPzx5yXQYIPezjMdsLMYbpXmvRJu3EKqAt3F8NqkRkrLPtjZkyHRgbJo=@dpdk.org
X-Gm-Message-State: AOJu0YyArODjH6rUa6pinGVPNgzWctOzNPQbVHU9P+tiD8i6E1/XbsTV
 9gx/P+nI6Jz19dgJ4+kMthUWbKaWFDlWY5p2NT9DzDCPL93VGUU3P9I1pp8qtYMitnCj0uQIU7t
 iS2veXaenEO1NUnSWmcubECKV3uNGaHBLlXHdYpLlx2UahEqa4+bsfr4LvaHxsMMZsnaSvI8yXX
 aIVsD3h3KtPVIS7ERbVLbSv0xupjA=
X-Gm-Gg: ASbGncvtiuC+gjl30u/2NurxJjgNmA3M6bmCiKy2LGX6PWR6tD0olboL0+IYWQJY8nf
 Po/FS5jiYfCO/cUYPZXIAbRhPTIisOCMuLBBvfDBuvGfGpuPMa4Ty/0RbZB6/q/2TU2wsYfF8X0
 aCTj2x7EqtloEXEqZxCWaGiqTLy9jZOrBknSYn81HP/w02Uc1JD1HvV3Sv12sxks1Y2WGO
X-Received: by 2002:a05:6512:b98:b0:594:2c64:54c9 with SMTP id
 2adb3069b0e04-597d3fe95e3mr2491316e87.37.1764855969510; 
 Thu, 04 Dec 2025 05:46:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF+0zIpzZFp4AZP/LJGgXV0/tp0CkMziAtoqzRApj7srWRMlMYa8JgiuTuWly7q8AYcELnhSlMsO0UL4y3FJF8=
X-Received: by 2002:a05:6512:b98:b0:594:2c64:54c9 with SMTP id
 2adb3069b0e04-597d3fe95e3mr2491307e87.37.1764855969076; Thu, 04 Dec 2025
 05:46:09 -0800 (PST)
MIME-Version: 1.0
References: <20251202130819.3805720-1-david.marchand@redhat.com>
 <f7tqztddntu.fsf@redhat.com> <6247294.lOV4Wx5bFT@thomas>
In-Reply-To: <6247294.lOV4Wx5bFT@thomas>
From: David Marchand <david.marchand@redhat.com>
Date: Thu, 4 Dec 2025 14:45:57 +0100
X-Gm-Features: AWmQ_bk5AvygJVNGRNmOeVGix0vdyXbI86u5-N3cp0nYHJGXRSg6T_fkdrzvZhM
Message-ID: <CAJFAV8yP1=wJ0xw_Ruf+KDR-MKW_Zu2QhTwPv6QKBNv8qu9_sg@mail.gmail.com>
Subject: Re: [PATCH] version: 26.03-rc0
To: David Marchand <david.marchand@redhat.com>
Cc: Aaron Conole <aconole@redhat.com>, dev@dpdk.org,
 Thomas Monjalon <thomas@monjalon.net>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: WoMo9kKOW5VlZHfq9X6HEWiGIx1iC9hJf8ctKCbmY2k_1764855970
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

On Thu, 4 Dec 2025 at 14:16, Thomas Monjalon <thomas@monjalon.net> wrote:
> 02/12/2025 14:18, Aaron Conole:
> > David Marchand <david.marchand@redhat.com> writes:
> >
> > > Start a new release cycle with empty release notes.
> > > Bump version and ABI minor.
> > >
> > > Signed-off-by: David Marchand <david.marchand@redhat.com>
> >
> > Acked-by: Aaron Conole <aconole@redhat.com>
> Acked-by: Thomas Monjalon <thomas@monjalon.net>

Applied, thanks.


-- 
David Marchand

