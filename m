Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4530CCA1012
	for <dpdk-dev@archiver.kernel.org>; Sat,  6 Sep 2025 17:30:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0A07540269;
	Sat,  6 Sep 2025 19:30:21 +0200 (CEST)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41]) by mails.dpdk.org (Postfix) with ESMTP id 4F37140261
 for <dev@dpdk.org>; Sat,  6 Sep 2025 19:30:19 +0200 (CEST)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-45de1084868so1524315e9.2
 for <dev@dpdk.org>; Sat, 06 Sep 2025 10:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1757179819;
 x=1757784619; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R2utwB9KLKR4CbQ5HfkrHSm+UX4fxw8H27CG46M3R/Y=;
 b=lypKFEWjiEuSUYQv5rgRqH6RJFjcA8Olfsfiv7MJJ/uNNNv3XRpX3djz5g9lVEsS70
 n5PN7XpTcGhrEdR2LEyCLD5RPjfRKHMyleOv3p+egxlSq6TfdeVjDUy5Yr3GCg18IAjA
 NaHjteghm6rdlK2qiKuBJKnHdRikBNg3SA7wA0OgVDGxU60x1AWvmjqk1sFdr/cBiEKT
 aHMlcsFbYBc8VLGTJYONgdWGsbTnlhhUMAjPszF73tq5DcUhYfv2cKosKdsyPEL32DF+
 WuoSHQAvxPBrYbZEXZmfw4MijdcqJC3sjhNWajcbHT8zArFt9AySxYuFtPBglIoWa3c3
 PyaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757179819; x=1757784619;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=R2utwB9KLKR4CbQ5HfkrHSm+UX4fxw8H27CG46M3R/Y=;
 b=ovu8SGLGhMGFnUEoPTSTNRg7XbEzznH4ZrLmxILjYT2nviE7WBlhnLYbC39POqMUC8
 6hSntkOKyM5LINl9QCQUQYasuMqUIro9tZH17QVrUSxtMUq3cIK/K+LYEYDS6g5LHF+l
 y72lYq/b1+BbLGfzwhCelmAJ1lB/8vvbdnna6gvyKLUin66iHPG3NnnrP5hgDzTkrSv2
 DYLHjAZcyzXpIGGlqJ8hThJsvdt2SuEB/395+K+T53j7ci9VFK8fjkZdfNUWappmBMzm
 mA6pZX29rlrBImy7Yh6nfHq0bCUdCixX86pw2qgZgPQ1n5JED8gS2oWwnYAyUZjc/KcO
 hMXA==
X-Gm-Message-State: AOJu0Yxol1kNHxhq7RFtdEnDCbbchXoRzNEaASXmqSZvH8sOpwhC0pR6
 VgV+Eot6/lbX/4QfGt1/eJ3VYxPqlcQVTKpNX//XYCdXz7168hcI4CUp7y6OQNnfrhw=
X-Gm-Gg: ASbGnctlkUa/Kb0XEUanYI56tkUyi+U6ZGxMU6JN/7FQWV06Yczdr3Rq8GjYQYbjifN
 aXBbmVM9bYBUGErmUG32D/HbKvf2rcxK9ipEmbSv+ifI6LMjcrQiyujKZyoUpAM6X6jZSqRt+wh
 BMsXB5Bx4pi2ZZw771dIyK9soLssZFuCrrc1vQ/QurR0mgFoc+WF5uJ0+bzkoCK6gUA1bVbgDKg
 cgvEzpP/Xt3qDHfCeU1CwXqpzvECIbkUaNB9UQaztCtDi4mWsZVK2Y/aGUWbOGFBJ3dtNjK5QZq
 e3ZOVwA4IkoIGOK+T4MTyysTRaC+PE8MYvg0CjAX8v5/j/YsxmUwuNZ9pmUnL7bHQd0dB5nMwDH
 9JZSi3+godFtrs8SO9kp3NRzdlWYCydZPTkZvXVcaWsBZORGX9qIUc4I5cwGW+wAvPxmpmff/6Z
 w=
X-Google-Smtp-Source: AGHT+IEJ99VEeQ5QS72Jk3DO/7dJp+vgbhpTbMmTUIfAe9LygMe8pV0FXyi8RG1pllzBbhU6GW4AAw==
X-Received: by 2002:a05:600c:5254:b0:456:1a69:94fa with SMTP id
 5b1f17b1804b1-45ddde8be3bmr18795045e9.13.1757179818745; 
 Sat, 06 Sep 2025 10:30:18 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45dd4affb6bsm93036885e9.1.2025.09.06.10.30.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 06 Sep 2025 10:30:18 -0700 (PDT)
Date: Sat, 6 Sep 2025 10:30:11 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Ivan Malov <ivan.malov@arknetworks.am>
Cc: dev@dpdk.org, Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>, Andy
 Moreton <andy.moreton@amd.com>, Pieter Jansen Van Vuuren
 <pieter.jansen-van-vuuren@amd.com>, Viacheslav Galaktionov
 <viacheslav.galaktionov@arknetworks.am>
Subject: Re: [PATCH 0/4] common/sfc_efx/base: link stability improvements
 for X4 NICs
Message-ID: <20250906103011.6401e9c6@hermes.local>
In-Reply-To: <20250905144514.11698-1-ivan.malov@arknetworks.am>
References: <20250905144514.11698-1-ivan.malov@arknetworks.am>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Fri,  5 Sep 2025 18:45:10 +0400
Ivan Malov <ivan.malov@arknetworks.am> wrote:

> As announced in [1], this series provides three fixes for link bring-up on
> X4 adaptors and an improvement to have link up faster in typical use cases.
> 
> [1] https://mails.dpdk.org/archives/dev/2025-August/323545.html
> 
> Ivan Malov (4):
>   common/sfc_efx/base: fix autoneg detection with netport MCDI
>   common/sfc_efx/base: default to auto fcntl with netport MCDI
>   common/sfc_efx/base: fix auto FEC selection for netport MCDI
>   common/sfc_efx/base: use saved netport FEC choice by default
> 
>  drivers/common/sfc_efx/base/efx_impl.h     |  6 +++
>  drivers/common/sfc_efx/base/efx_np.c       | 56 +++++++++++++++++-----
>  drivers/common/sfc_efx/base/efx_phy.c      |  4 ++
>  drivers/common/sfc_efx/base/efx_port.c     |  1 +
>  drivers/common/sfc_efx/base/medford4_phy.c |  1 +
>  5 files changed, 57 insertions(+), 11 deletions(-)
> 

Queued in next-net
