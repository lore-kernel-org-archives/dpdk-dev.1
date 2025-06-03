Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DE7EC5AD49
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Jun 2025 14:33:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A9ED940DDE;
	Tue,  3 Jun 2025 16:33:44 +0200 (CEST)
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com
 [209.85.128.171])
 by mails.dpdk.org (Postfix) with ESMTP id 8DB7840DDD
 for <dev@dpdk.org>; Tue,  3 Jun 2025 16:33:43 +0200 (CEST)
Received: by mail-yw1-f171.google.com with SMTP id
 00721157ae682-70e102eada9so51378017b3.2
 for <dev@dpdk.org>; Tue, 03 Jun 2025 07:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1748961223; x=1749566023; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y8YNihdQALAu1a3pPsuxa1Y1fA943ti9QlOb40zSaek=;
 b=JakOpPeisN7CkyBX46LK7pHmbuym7EdwgM+c9gg5GqX6bf5tC+dQJH4Eg20VFdPotV
 9jpmLWuft9qCxMNuv8Oty84t6DHtKsff/+jqeBOzAuTQD+oKZD4LOOYQoKzhNxQfwAmW
 SusCQtmnKa96g3BgttVeh0PxOgQnzbWVBKtz8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748961223; x=1749566023;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=y8YNihdQALAu1a3pPsuxa1Y1fA943ti9QlOb40zSaek=;
 b=rbH0hOzKOuF9efKpjgYkuqUXJJjQvsbpvZoergO+9FOjNu1/vaZ3TvVNiNjHkryuGz
 yv/eC8Q4Da25SEjOXDr7E0GroIODgbvWR+75EvSav6NKmuuG5NaNr48bKYa1/h5o4Z+p
 QV+oYLI/ypz5Fe8cBj/G+trmk7085FOkvJjjzqLBUPc0tPYdDsm0YDzIICGOklWplNmT
 8/vbOayem58fsR2McJ7PUioLTuj7f1CiGYrlVcvSfNCEFxRj2D+eb4xDAnw3Q2Ld177F
 guGDUZs145z84te+u7+foRZIoyjmNbi19aHoDk1x6S6T1/BC1FE241rB+VTw/vI1VJ3C
 nxSA==
X-Gm-Message-State: AOJu0Yya3YdPkpJSU1eKct8ao/kxU+UJgT1ChDWkgrwIjz5+ah3gL+U6
 q0kQFCDN/TzP73nvn8/xVho4omqb7cjaDletZOV7CfYHRi7Si55ZJmIXacbAFUvP30aBCDJ7TKF
 vguPeNVT3wAllps7yPHLeZQqQ8tNjoS3dOKxW1iofBQ==
X-Gm-Gg: ASbGncvPisE7iN4p50up/vbU5xGpZd50OjM5KTml8eArDjFVHu6NksaHUm6IUeqBZl6
 3sN60HqgG8at6pWyH6WEhH0Vr6xpbDoqc0RK7hBu1Q8GLjNCdNDXVWYcvu9l5rBTEO8qQJQRcCk
 tiJhfgEZ91O7L64OTFThxpR0RIxFJaqBbOEhkx/n6bRBmIoSSSTjOhH8Vf8iePdXXolAnJ23p9G
 4DIjg==
X-Google-Smtp-Source: AGHT+IF5iiSuFKD7y1zXzf7M8HaZJRXS2he9imGLBl6p0Fm8/UJNr2Eccy4wHTg6eemTSOjX+6P6Jf0kcIdgk1pWdo4=
X-Received: by 2002:a05:690c:74c5:b0:70c:b958:9fbb with SMTP id
 00721157ae682-70f97e31f95mr237959397b3.4.1748961222831; Tue, 03 Jun 2025
 07:33:42 -0700 (PDT)
MIME-Version: 1.0
References: <20250331155800.449823-1-thomas.wilks@arm.com>
 <20250506132933.1580584-1-luca.vizzarro@arm.com>
 <20250506132933.1580584-4-luca.vizzarro@arm.com>
In-Reply-To: <20250506132933.1580584-4-luca.vizzarro@arm.com>
From: Dean Marx <dmarx@iol.unh.edu>
Date: Tue, 3 Jun 2025 10:33:31 -0400
X-Gm-Features: AX0GCFsJQQETqtJkG7MBK8XbLSwyUbLAb2ehzxzadC9crG8ftPoLSQy-fsF74Kg
Message-ID: <CABD7UXNmEBKiZuf=ddg6avfxeSSxh56Sbm6eK9Jho1rrLwYfpw@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] dts: add packet capture test suite
To: Luca Vizzarro <luca.vizzarro@arm.com>
Cc: dev@dpdk.org, Stephen Hemminger <stephen@networkplumber.org>, 
 Thomas Wilks <thomas.wilks@arm.com>, Paul Szczepanek <paul.szczepanek@arm.com>,
 Patrick Robb <probb@iol.unh.edu>
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

On Tue, May 6, 2025 at 9:31=E2=80=AFAM Luca Vizzarro <luca.vizzarro@arm.com=
> wrote:
>
> From: Thomas Wilks <thomas.wilks@arm.com>
>
> Add a test suite that tests the packet capture framework
> through the use of dpdk-dumpcap.
>
> Signed-off-by: Thomas Wilks <thomas.wilks@arm.com>
> Signed-off-by: Luca Vizzarro <luca.vizzarro@arm.com>
> Reviewed-by: Paul Szczepanek <paul.szczepanek@arm.com>

<snip>
> +
> +    def close(self) -> None:
> +        """Close the application.
> +
> +        Sends a SIGINT to close the application.
> +        """
> +        self.send_command("\x03")
> +        super().close()

I believe code x03 is for SIGQUIT, not SIGINT:
https://www.chromium.org/chromium-os/developer-library/reference/linux-cons=
tants/signals/

Otherwise:
Reviewed-by: Dean Marx <dmarx@iol.unh.edu>
